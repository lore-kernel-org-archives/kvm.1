Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220828C84A
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332076; cv=none; b=Tpa1upiJM/l/7RpaqvxJg0mUouOv/wuPKTADNyLgckghnrScUQzcG/tXTMIEKQHOuuCDjglwZWjDk9OhIbsEgPaLF1o5aS7SsoKHFJGxbY+OHRV7a3G0JmiWlGuaP2gScUEJXJO8NvDHc72xA8xAFGqQVHdpYbNfn6q7PR2ZAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332076; c=relaxed/simple;
	bh=6htT/AEciEKvpJIl67X/+ZPnZ0DKO+8AwuaP+qc5H00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q0WQjKpwOUi6CQGtnM2g+TBYBhCEFoCIx1pSuo+Uk8y5AxUcIM4Ocq9NqkQOeD4ZDZC0AS97wEKiecGluKeAeIDjB56tqdhorihO2n9ugIe4m/FTb66RoPGLmDLgy4APIIqt1YF9PkgFNp54Mm/yvOkMZFwOqYEAVcfud7Bgs/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjDDPnZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjDDPnZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AFF1F00893;
	Mon,  1 Jun 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780332074;
	bh=tan5KXwMphDruf5dSUqWIZLdoYE7hkIpdF5Y5yZk2Sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jjDDPnZ1rEfnEmV6lh/w+A11rHJk+f4Q9MVzSGnUfs+yv0nWk5m0ck/9hx2KwEptr
	 WFkr7haik7jWkSNlMiHLzFwXAHOvTOEz/zmgxITAKr9Mt1gRcG9AwIeTR/0vKYnume
	 E/wxXoH5Dqx52fPP+eq051Qox9/VKhvAYbwzOjjJHxRIsO/ziesMAWr+ZhI8uGVEO2
	 3arhIFA+pqE7UYlbKIAil/ON+IkdTAPkFUkmKpNeBPio2MSZFyH5QcYMOctxySvEjO
	 fHTxwxORZBm7DEoGR55ppndUkkP/BqhAj4QVwMza5VsnpRBUbxdPaQ9qwOD3jcYBhb
	 tZNfr8vYWmS0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] KVM: s390: vsie: Fix rmap handling in
 _do_shadow_crste()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601152951.196859-6-imbrenda@linux.ibm.com>
References: <20260601152951.196859-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 16:41:14 +0000
Message-Id: <20260601164114.71AFF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `_do_shadow_crste()` creates a corrupted Region-3 large page e=
ntry (PUD) due to `_crste_fc1()` hardcoding `_SEGMENT_MASK`, leading to har=
dware Translation-Specification exceptions.
--

commit 249b86f32c315315b0e5e5c41fd24415c3c08a7f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()

Fix _do_shadow_crste() to also apply a mask on the reverse address, to
prevent spurious entries from being created, like already done in
gmap_protect_rmap().

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 4f8d5592c9a92..20e28b183c1ac 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
[ ... ]
> @@ -1497,8 +1499,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t =
raddr, union crste *host, uni
>  		return -EAGAIN;
> =20
>  	newcrste =3D _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);

[Severity: Critical]
This is a pre-existing issue, but does this create a corrupted Region-3 lar=
ge
page entry when dealing with 2GB large pages?

Looking at _crste_fc1() in arch/s390/kvm/dat.h, it hardcodes _SEGMENT_MASK:

arch/s390/kvm/dat.h:_crste_fc1() {
	union crste res =3D { .val =3D PFN_PHYS(pfn) & _SEGMENT_MASK };
	...
}

If oldcrste.h.tt is TABLE_TYPE_REGION3, f->pfn may have non-zero bits in
the 20-30 range (which map to IBM bits 33-43) if the fault was not at the
start of the 2GB page. Since _SEGMENT_MASK only masks out the lower 20 bits,
these bits remain set.

Will writing this entry with bits 20-30 set (which should be strictly
zero per architecture) cause the hardware to raise a Translation-Specificat=
ion
exception?

> -	gfn =3D gpa_to_gfn(raddr);
> -	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, gfn,=
 sg->asce))
> +	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, r_gf=
n, sg->asce))
>  		;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601152951.1968=
59-1-imbrenda@linux.ibm.com?part=3D5
