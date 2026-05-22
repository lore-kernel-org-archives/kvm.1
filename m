Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276413438AA
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484754; cv=none; b=iepp2hH4wo7lhx7CPw4hHE2lynTXteBhC1GaJQ7JyDW6Wg6lhZeSNPb6iTExWXrrIjWcYenSub3RVLPP+CklJ/NO/abmH7UHXTVVBDxloiRFd4g6hDcMf64yDg//VG66JqppQtsLiwrsY4gj/7RJZlFs1Q15t3/uLU1rBgJnigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484754; c=relaxed/simple;
	bh=XRsEQ0Na/g02daLpn9PGbahWZxa/BfY7Th5AqJ+Jnho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIwCbYIG27hHDYTj1G2ORxZlvSuYdHZNw5TDvOM116T265e432gv4yOYIq8VxVK1Zq6aOjLKjua8BfF2dAFsZGN8CymjXcwHHhIykETFjNMH61/SMB2XA49vCPcUP2KMT2W5D/wSbOGHIh76SoxcrniigXXlvgRfbspHhxcIG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCLF7f2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCLF7f2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF5D1F000E9;
	Fri, 22 May 2026 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779484753;
	bh=kBh5CRzcfYVKfGv9wpF1dTrMFLAd6hLVpRHVvprfsOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCLF7f2LKMR4PgLS7jjLOb2ucE+coCNBWOCq11fQXBaNVqsn4GTeuX4c1AHVD8NhW
	 0fRWKBt28C1raUbIYVJuHxgSBnvX4GVI4/ItiZPa6PSNTMM0acZVVfAxtCC8ykPccc
	 lKdOJrVDk6ojTcEZsvGi0vheTiq2d5UI8bLCSiJvKmRYrmRoDj2t4T+X8mYNOlS9bf
	 1u0DGpd+a5RYoGiITN7j7RVFOHlUnets/IAREW0cnaf3+QtvP2+jU/asKozG9gG58W
	 L+t4E0hwX3EyYNm9NTgI/BjJ5XRJeT8k/m4pH1PyU/IqNa+lKrC/xBz9uiy7CBT+of
	 0W/MiKG2Ci0ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: guest_memfd: Use write permissions when
 GUP-ing source pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v1-1-9fc8d6437b65@google.com>
References: <20260522-fix-sev-gmem-post-populate-v1-1-9fc8d6437b65@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 21:19:12 +0000
Message-Id: <20260522211912.ECF5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifications to the pinned user space source page (`src_page`) ar=
e not tracked with `set_page_dirty_lock()`, risking silent data loss if the=
 page is evicted.
- [High] Userspace can maliciously trigger a `WARN_ON_ONCE` kernel panic by=
 passing a zero `uaddr` for non-ZERO page types, leading to a potential den=
ial of service.
--

commit 6a7184de221e96f7e4e45a9996f99d0f23dabd6a
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Use write permissions when GUP-ing source pages

sev_gmem_post_populate() may write to the source page if there was an error
while performing SNP_LAUNCH_UPDATE.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2469,6 +2469,7 @@ static int snp_launch_update(struct kvm *kvm, struc=
t kvm_sev_cmd *argp)
>  	sev_populate_args.type =3D params.type;
> =20
>  	count =3D kvm_gmem_populate(kvm, params.gfn_start, src, npages,
> +				  params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID,
>  				  sev_gmem_post_populate, &sev_populate_args);

[Severity: High]
This is a pre-existing issue, but could userspace intentionally trigger a
WARN_ON_ONCE kernel panic here by passing a zero uaddr for non-ZERO page
types?

In snp_launch_update(), if userspace provides params.uaddr =3D 0 alongside a
non-ZERO page type (e.g., KVM_SEV_SNP_PAGE_TYPE_CPUID), src is set to NULL
because 0 bypasses the PAGE_ALIGNED(src) validation.

When kvm_gmem_populate() is called with src =3D NULL, it skips
get_user_pages_fast() and leaves src_page as NULL. The __kvm_gmem_populate()
function then invokes the sev_gmem_post_populate() callback with
src_page =3D NULL, which triggers the WARN_ON_ONCE in the callback. On
production systems configured with panic_on_warn=3D1, this could allow an
unprivileged local user to crash the host.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -892,8 +893,9 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_g=
fn, void __user *src, long
> =20
>  		if (src) {
>  			unsigned long uaddr =3D (unsigned long)src + i * PAGE_SIZE;
> +			unsigned int flags =3D may_writeback_src ? FOLL_WRITE : 0;
> =20
> -			ret =3D get_user_pages_fast(uaddr, 1, 0, &src_page);
> +			ret =3D get_user_pages_fast(uaddr, 1, flags, &src_page);

[Severity: High]
This is a pre-existing issue, but does this miss tracking modifications to
the pinned user space source page (src_page)?

While the FOLL_WRITE flag correctly handles the copy-on-write,
in sev_gmem_post_populate(), if the SEV-SNP firmware returns an invalid
parameter error for a CPUID page, KVM copies the expected values into the
user-provided src_page via kmap_local_page() and memcpy().

However, kvm_gmem_populate() uses get_user_pages_fast() to pin the page
and subsequently calls put_page(src_page) without explicitly marking the
page as dirty (e.g., using set_page_dirty_lock()).

Because the modification bypasses the user's page tables and directly
writes to the kernel's direct map, the user PTE's hardware dirty bit
remains unset. If the page is file-backed or swap-backed and memory
pressure forces it to be reclaimed, the memory subsystem might see both
the PTE and the struct page as clean, discarding the page without writing
the changes to the backing store. This would cause the user-space process
to silently read stale CPUID data.

>  			if (ret < 0)
>  				break;
>  			if (ret !=3D 1) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-fix-sev-gm=
em-post-populate-v1-0-9fc8d6437b65@google.com?part=3D1
