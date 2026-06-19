Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30541EB9E3
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830159; cv=none; b=sJczWcNrM1DaQtfnasaGiwxJDMxf+iaL17dp5CyevnZ48sYMK37mTyYwFa3pb/a+uODfNJEgxgPql7F+UT3PmZgL3L5tEd7zNLXOdg2qLHCxELuFmtN3isYyvHpsEEMxB4hzpoCcXbV+iE8qHkTzaMhXBFBpPgPSQWtCaJuC8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830159; c=relaxed/simple;
	bh=X+J9x+VP3Q/NxqK23eu2o4TfKjI7gtzahQ+m/jxZcmY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZ56s8N44uvhxvuF9ElQupYEx0vhuwII/dtuudBR0DdPpB4xki9UkdM6+jCsFcDMWyqtSWJ/ipEpNbtkBK/ZbS0+6/ECjlhFdh9+8QQA2aMix1g0fmAUtaTciEgVjY7RPU1HGjb5Dqh6Rxqg4n4hfICYNubv54zmQcwg6ByiFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6kCAoGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6kCAoGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378771F000E9;
	Fri, 19 Jun 2026 00:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830158;
	bh=C4XP7fS/RKU6k9VXAlDQxz4O/d1P6SB2Iec2VwhasFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X6kCAoGlg0v/RWW7iXSW0hpbsRYoyNo1PFIuQzSEj0xpemN5n4l/WU0UZVY1L/0tf
	 jhWUMkcC5fADr+h2G3zmcISm0VHn4a/ktoiYI84e8td2o4snlpaq1uQGmVIDFWreu0
	 nC62UBe4LrXir21igGsemASCz/dm9qbdvCzmKMfHhMdtHjeRByy9sei94c5RLFJjex
	 ElWheIGt08t+wLc3hxdPEWllfR29dym39RZNMxwdCgUpalTETEKNY+W1dBpA/2vzJ/
	 cZGMJBpJYA6ik3q6FEDleG6j8wtSFpIh3YzB+BEZ2Lf/9wMwCTTkOdFSp0ljThgymO
	 VjPOH48hz1qEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:49:17 +0000
Message-Id: <20260619004918.378771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `kvm_gmem_is_private()` hardcodes address space 0 by using `gfn_to=
_memslot(kvm, gfn)`, which breaks multi-address-space vCPUs (e.g., SMM).
--

commit 8dfdb2d13d27c9727b32ecdcb6460d23702e6438
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Introduce function to check GFN private/shared status

This commit introduces a new KVM utility function to check whether a given
GFN is backed by private memory. It checks for a guest_memfd file associated
with the memslot and queries the inode's private memory state.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 8101f64e0366f..bca912db5be6e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -510,6 +510,37 @@ static int kvm_gmem_mmap(struct file *file, struct v=
m_area_struct *vma)
>  	return 0;
>  }
> =20
> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
> +{
> +	struct kvm_memory_slot *slot =3D gfn_to_memslot(kvm, gfn);

[Severity: High]
Does this code correctly handle multi-address-space vCPUs (such as SMM on
x86)?

The call to gfn_to_memslot() internally looks up the memslot tree strictly
for address space 0. If a vCPU is operating in an alternate address space
where the memslot layout differs from address space 0, this lookup could
return an incorrect memslot or no memslot at all.

This could cause KVM to incorrectly treat private memory accesses as shared
for alternate address spaces, potentially leading to incorrect page table
installations or guest memory corruption. Should this function perhaps take
the target kvm_vcpu or the kvm_memory_slot directly so it is evaluated
against the correct address space?

> +	struct inode *inode;
> +
> +	/*
> +	 * If this gfn has no associated memslot, there's no chance of the gfn
> +	 * being backed by private memory, since guest_memfd must be used for
> +	 * private memory, and guest_memfd must be associated with some memslot.
> +	 */
> +	if (!slot)
> +		return 0;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D9
