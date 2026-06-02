Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103C314D37
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423453; cv=none; b=Wue+b0HyzO3W0YJtxUfxp/l3MyOUxCz8ujTNAVwALbN8bZeUdlKJu8byKeHJIcqNTrS+/3YlQolfEhFT5Lo1RQTdKlfr3fDFXBo0bfBoje4wA5iY/Uu7LKnR0ceovZadlWR2mNrs8Zup8uZVRSMJquw73ZBbLX5L3UFhi0oGR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423453; c=relaxed/simple;
	bh=55JwT1dL9HeQcAAQMZDonExHtYCFmfiOia+RFb96p9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oss/U/WBOeotFFREHtvPlFpN4kZ2drfyrHOFHJ2IkZlSR1DFeieaBtyliVuUbKwZEpMJI8excuU0h5uWQSa6WcitrQfUEPE05sAa248OC+8yhAlhn+RFsKybvIXJ/rD/Gmbue4k1BKP+71eg3mQCC/lLOsq1naPvAtMTy8RcMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbhCNzET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbhCNzET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2461F00893;
	Tue,  2 Jun 2026 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423452;
	bh=mLfyhmGLVekgtLbZ/p7pUfzBfwXh2ZiIS+Pgki7HVuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbhCNzETgPEYZGX2mSMbWZiJnsEXyqS1lAQhoTX0bTsqSki8tmLfJYAVT0nW87b+j
	 H3sj6hSuanQ/Xo0s0KiEayOXzxYAPd1W6689lmCJEydrP/hnRB2FKlGUnIPwi3OoOi
	 MFEk1BjKK+FGllsJgwDiSfUoZwPGTeqiIL/RGpaYc5huTmdlt6OmyxkGbE2ywlGEOI
	 FY+K5Msb5d9xHKt0T5zoxhCX2bAqEC2imEesVSxZW1SVze8uGxXuwL+TOqwi9649Er
	 rdpsAGpzo1laFwbJS4+BONDsq8a/MvnW6PBlDL2sUPYS8FLMu9ZnFaag1H1NQXvLTT
	 48Wg3GsaoRgQQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 05/10] KVM: s390: vsie: Fix rmap handling in
 _do_shadow_crste()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602174819.255785-6-imbrenda@linux.ibm.com>
References: <20260602174819.255785-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 18:04:11 +0000
Message-Id: <20260602180412.2E2461F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] GFP_ATOMIC allocation in gmap_insert_rmap bypasses KVM's MMU cache=
, potentially causing a host soft lockup or VM crash under memory pressure.
--

commit 765063f80a5ceb72c474a34db34b451374e3d79f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()

Fix _do_shadow_crste() to also apply a mask on the reverse address, to
prevent spurious entries from being created, like already done in
gmap_protect_rmap().

Message-ID: <20260602142356.169458-6-imbrenda@linux.ibm.com>

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 4f8d5592c9a92..20e28b183c1ac 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1466,15 +1466,17 @@ static int _do_shadow_crste(struct gmap *sg, gpa_=
t raddr, union crste *host, uni
[ ... ]
> -	gfn =3D f->gfn & (is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK);
> +	mask =3D is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK;
> +	r_gfn =3D gpa_to_gfn(raddr) & mask;
>  	scoped_guard(spinlock, &sg->host_to_rmap_lock)
> -		rc =3D gmap_insert_rmap(sg, gfn, gpa_to_gfn(raddr), host->h.tt);
> +		rc =3D gmap_insert_rmap(sg, f->gfn & mask, r_gfn, host->h.tt);

[Severity: High]
This is a pre-existing issue, but gmap_insert_rmap() allocates with GFP_ATO=
MIC
instead of using KVM's pre-allocated MMU cache.

Does this bypass KVM's MMU cache forward progress guarantees? In the shadow
fault path (_gaccess_shadow_fault), the MMU cache (mc) is topped up before
taking locks. If this allocation fails with -ENOMEM, it loops back and tops
up the cache again.

However, because gmap_insert_rmap() uses:

arch/s390/kvm/gmap.c:gmap_insert_rmap() {
    ...
    rmap =3D kzalloc_obj(*rmap, GFP_ATOMIC);
    if (!rmap)
        return -ENOMEM;
    ...
}

instead of the pre-allocated mc->rmaps, the topup operation will see a full
cache and return 0 immediately without sleeping or reclaiming. The fault
handler then retries the same atomic allocation, potentially creating an
infinite loop that soft lockups the host under memory pressure.

Can the MMU cache (mc) be passed down to _do_shadow_crste() and=20
gmap_insert_rmap() to utilize pre-allocated memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602174819.2557=
85-1-imbrenda@linux.ibm.com?part=3D5
