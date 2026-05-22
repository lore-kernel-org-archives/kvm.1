Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20B3438B5
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493652; cv=none; b=KzyAaCSEg0ySFklIBLIrmTuOULieCblJpoCvsl8pJbs+QHmILSpgQs/GYNU+bIE1iWaTAmYBuRQyWqX3LHD8ZI66934pysWN97h3iztJdp1z/na4RuaWtHokOQTLn/8UlVcPaLbpkavs3TdqXfHYAbHq7LaoJuNQ3UmK861YysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493652; c=relaxed/simple;
	bh=WEs1dQQVET0BdWBs8iyn4pTUU3grIDXe2zsPvcV8DDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BT3R5U4EsJwi8cV0ttjnlsuWGQ11BczWk7PFtBhexLlADedfimCJTIsOdSiabDDnLSE3dapWDY7pofnZl9wtvCb5nwi7TNEIvpSd8m2h51hAegMogqEL0w6kxeOqVzPwR1QEQgo/31RV8rz5+i8sQA2dtCOSK+Z1VYp0Gj5NsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckqyrPHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckqyrPHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E6D1F000E9;
	Fri, 22 May 2026 23:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493651;
	bh=yxeRN+PYXYYg2VY5fhiEvOom2XqHGEJw5zrdFmuZySc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckqyrPHRb8PhLI/u5JYAgQm3ir4mf7Ua9M/vzV8jT4X74ProCvjXx5HkQJ1f3Ou+Y
	 mKjgSKZmcYzBNg8L/dEkR/mKplgWg2CA9mubnxyOwgz27UnhwGTuBMho1EreFowwY8
	 yNxn7JkFDCZ7eZ9jXQrza2nmbr72JhaMfhW7NsNc2kb/2fU3couKrYF+BocBpMcbPY
	 N4vTqmdTNwf+gKBefsfOh6TXn4LssNp0rxLjRn5Bmk6O2dX/Z3AiFa7jD8v7LTeUPP
	 yfE2bEGH2TjCy29d9wlCqkdWttQERT+msGoxFy6TMER3jX3cOlbqCAO6LUItZsdGPb
	 KsCNzDOnOcFTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] KVM: guest_memfd: Use write permissions when
 GUP-ing source pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v2-1-3f196bfad5a1@google.com>
References: <20260522-fix-sev-gmem-post-populate-v2-1-3f196bfad5a1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:47:30 +0000
Message-Id: <20260522234731.42E6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pages acquired via GUP with FOLL_WRITE and modified by KVM are rel=
eased without being explicitly marked dirty, which can lead to silent data =
loss under memory pressure.
- [High] Unprivileged users can trigger a kernel warning by passing a zeroe=
d user address for an ioctl parameter, which can lead to a panic if panic_o=
n_warn is enabled.
- [High] kmap_local mappings are unmapped in the wrong order, violating the=
 strict LIFO requirement of the API.
- [High] The boundary check for the memory region in `tdx_vcpu_init_mem_reg=
ion` is vulnerable to an integer overflow during bitwise shifting, allowing=
 bounds checks to be bypassed.
--

commit 4e7b5c15d63f1f0042fe1de3db050a1e03871f04
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Use write permissions when GUP-ing source pages

This patch updates kvm_gmem_populate to optionally request write
permissions when calling get_user_pages_fast on source pages. It
modifies sev_gmem_post_populate to request write permissions when loading
a CPUID page, ensuring copy-on-write resolves read-only mappings before
writes occur.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 940b97d4a8523..2f254c447923e 100644
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
This is a pre-existing issue, but could this allow an unprivileged user to
trigger a kernel warning or panic?

Earlier in snp_launch_update(), if a user provides a non-ZERO type such as
KVM_SEV_SNP_PAGE_TYPE_CPUID but sets params.uaddr to 0, src is resolved to
NULL. Since 0 is page-aligned, the PAGE_ALIGNED(src) check passes.

When kvm_gmem_populate() is called with src set to NULL, it skips
get_user_pages_fast() and leaves src_page as NULL.

If sev_gmem_post_populate() then evaluates:

WARN_ON_ONCE(sev_populate_args->type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO && !sr=
c_page)

Will this trigger the warning, potentially crashing the system if
panic_on_warn is enabled?


[Severity: High]
This is another pre-existing issue, but are the kmap_local mappings in
sev_gmem_post_populate() being unmapped in the correct order?

The kmap_local_page() API requires mappings to be unmapped in strictly the
reverse order of how they were established (LIFO).

If src_vaddr is mapped first and dst_vaddr is mapped second, they should be
unmapped starting with dst_vaddr.

If sev_gmem_post_populate() unmaps src_vaddr before dst_vaddr, does this
violate the LIFO requirement and risk triggering kernel BUGs when
CONFIG_DEBUG_KMAP_LOCAL is enabled?

>  	if (count < 0) {
>  		argp->error =3D sev_populate_args.fw_error;

[ ... ]

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b8c3d3d8bbfe5..00dcfcbc47f68 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3185,7 +3185,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu=
 *vcpu, struct kvm_tdx_cmd *c
>  		};
>  		gmem_ret =3D kvm_gmem_populate(kvm, gpa_to_gfn(region.gpa),
>  					     u64_to_user_ptr(region.source_addr),
> -					     1, tdx_gmem_post_populate, &arg);
> +					     1, false, tdx_gmem_post_populate, &arg);
>  		if (gmem_ret < 0) {
>  			ret =3D gmem_ret;
>  			break;

[Severity: High]
This is a pre-existing issue, but could this boundary check bypass validati=
on
due to an integer overflow?

In tdx_vcpu_init_mem_region(), region.nr_pages is shifted left by PAGE_SHIF=
T:

if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
    !region.nr_pages ||
    region.gpa + (region.nr_pages << PAGE_SHIFT) <=3D region.gpa ||
    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT=
) - 1))
        return -EINVAL;

If a user provides a large region.nr_pages value (like 0x0010000000000001),
will the shift by 12 bits overflow and wrap around to a small positive
value?

If it wraps, does this prevent the region.gpa addition from overflowing,
allowing the upper-bound vt_is_tdx_private_gpa check to pass, and causing
the loop to iterate region.nr_pages times populating memory outside the TDX
private GPA bounds?

[ ... ]

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b28..07d8db344872b 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -892,8 +893,9 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_g=
fn, void __user *src, long
> =20
>  		if (src) {
>  			unsigned long uaddr =3D (unsigned long)src + i * PAGE_SIZE;
> +			unsigned int flags =3D may_writeback_src ? FOLL_WRITE : 0;
> =20
> -			ret =3D get_user_pages_fast(uaddr, 1, 0, &src_page);
> +			ret =3D get_user_pages_fast(uaddr, 1, flags, &src_page);
>  			if (ret < 0)
>  				break;
>  			if (ret !=3D 1) {

[Severity: High]
This isn't a bug introduced by this patch, but does this lead to silent
data loss under memory pressure?

When may_writeback_src is true, get_user_pages_fast() acquires a writable
page using FOLL_WRITE.

If there is a CPUID validation error, sev_gmem_post_populate() modifies this
page using a temporary kernel mapping. Because this bypasses the user PTEs,
the hardware dirty bit isn't set on the mapping.

Later in kvm_gmem_populate(), the reference is dropped with
put_page(src_page).

Since set_page_dirty_lock() is not called, will the memory management
subsystem consider the page clean and silently discard the error reporting
modifications if the page is reclaimed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-fix-sev-gm=
em-post-populate-v2-0-3f196bfad5a1@google.com?part=3D1
