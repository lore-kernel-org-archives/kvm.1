Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018A38BF9A
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207154; cv=none; b=GD0pvA4okdAH60FDXEvod7aH5XYa4Ot3vZWEB7OAL9mC6W+YQlhb+RXwCZX6t6Eq3hdFfoEgAkIP5L5j8JbztuCDexEtmu9yRVm5eQv9QdJDvezMMh20KyNNcNIPtEgdSFQq5wyRpVzYZ45SkyIUUXL/ee73RYTWJPQC/EGHcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207154; c=relaxed/simple;
	bh=lW8AHNH/+vVrGsnW97+vNe55BLkMWejyxN3dMB0c0oU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cqKGsvds41j5Nyey1LN7YTrrGsE+UygQ9SLcreHKGdxwfbYOqagAqfkcJXUhv6odmC6dxNRkDj0eWLkD6VM8HJ6s6FUkvrlL5hrZWe239Vt4R4mqolbHxtwTt2dC8HiKFpC++xflKnZd/xUGApWYDkVNnvkKFhUIQESN/IJlERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9Bpo/B4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9Bpo/B4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CA91F00A3A;
	Tue, 23 Jun 2026 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207151;
	bh=ZgKAtATzCLKgvTXIuYFlbsStE3EyNxB1trWghX3F0KM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9Bpo/B4Wq7qOuo+Qp7HxcjJPVGMtZAnTNvEGEcu/GGCbaXKlRugEfNpag5MhDw68
	 R8SBwgEFxoiUziwR9y5T6R0tn/3Kp4nA7Qnu0OqK1MKCaVZJ1qWXW9XJVJ5ghrTnQM
	 5sewMEHhN+yuRxtCpA3/b+6KFaJ/d4znl5zbVI+jWO3cyY83iVhVhDtzyiig0luGfO
	 v1yZQWD7815BI3I2wIoCwnQppSiXyCiamSWqVJuECV7Q+nSnFjwCm+aZpp3anVBFno
	 UjryV6+jp7qS/PSIDk27y6G0WwwdpDaUJYG1IO7b3XbLwtrYOqbY0O9jBFPRf292LI
	 MdBbgVmNIeg7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: guest_memfd: Add `write` parameter to
 kvm_gmem_populate()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623091556.1500930-4-joro@8bytes.org>
References: <20260623091556.1500930-1-joro@8bytes.org>
 <20260623091556.1500930-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:32:31 +0000
Message-Id: <20260623093231.B4CA91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The integer `write` parameter is passed directly as the `gup_flags`=
 bitmask to `get_user_pages_fast()`, treating a bitmask as a boolean.

Pre-existing issues:
- [Medium] Modified user pages acquired via `get_user_pages_fast()` are not=
 marked dirty before their reference is dropped, leading to potential data =
loss.
--

commit 49441863078cd5114f78eb8c75f1d31489417864
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: guest_memfd: Add write parameter to kvm_gmem_populate()

This commit adds a write parameter to kvm_gmem_populate() to optionally
acquire a writable reference to the user-space page via get_user_pages_fast=
().
This ensures page permissions are enforced when KVM needs to write error
details back to userspace.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b28..7a245a402a1b2 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -893,7 +893,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_g=
fn, void __user *src, long
>  		if (src) {
>  			unsigned long uaddr =3D (unsigned long)src + i * PAGE_SIZE;
> =20
> -			ret =3D get_user_pages_fast(uaddr, 1, 0, &src_page);
> +			ret =3D get_user_pages_fast(uaddr, 1, write, &src_page);

[Severity: Low]
Does this pass an integer parameter directly into the gup_flags argument?
While the integer value 1 coincidentally evaluates to FOLL_WRITE (1 << 0),
is it safe to rely on the numeric value of an internal macro definition her=
e?
Would it be more robust to explicitly pass FOLL_WRITE based on the write
parameter?

[Severity: Medium]
This is a pre-existing issue, but since we are explicitly handling writable
pages here, are we missing a dirty page notification before the reference
is dropped?

If a user-provided CPUID page fails validation during a SEV-SNP VM launch,
sev_gmem_post_populate() modifies the page directly via memcpy() bypassing
the user page tables. However, kvm_gmem_populate() drops the reference
shortly after:

virt/kvm/guest_memfd.c:kvm_gmem_populate() {
    ...
    ret =3D __kvm_gmem_populate(...);
   =20
    if (src_page)
        put_page(src_page);
    ...
}

Does this drop the reference without calling set_page_dirty_lock() or an
equivalent dirtying function? If so, could the memory management subsystem
reclaim the unmarked page and cause userspace to read stale data instead of
the detailed error information?

>  			if (ret < 0)
>  				break;
>  			if (ret !=3D 1) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623091556.1500=
930-1-joro@8bytes.org?part=3D3
