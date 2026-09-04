Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E423BD1B
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560292; cv=none; b=V2K5SMl4nLkKSPc+ty+Z9nyHvFs8e4vKPm1U0rKbo6Q6kCgO7Dqk6p1/H43urqZVLsCCuQRQuvf4KiuS4Nmr3Mn+o5l0To4wbXrDzJ1BDEng4eCCqtj/paO5OVRVtVpspmtzVt8kMBpJGgaWE8+YP9Dwj7j0nkJL0sVyM1FZk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560292; c=relaxed/simple;
	bh=ZENZVYKfRZowQpXJJGeTTMdiDuBxsatJ+x3ZT35tEIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pnmQCoU5ieQUuTZ5EeY5M0e7hDsNEBNim2jdE8vwS4ZXyXypUw/jGy88Nuw5YM9qgyY7VB6kK+zguK4HhEo1xkPYuXzM+al/mOwNVSUueUMngB7XSD110b0HOCKLoteL2zhvBjfXDrPkc9i7OLMp8cCJR/v4ZNiwqSKS0wo5N3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCWwuOB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCWwuOB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6111F00A3D;
	Fri,  4 Sep 2026 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560290;
	bh=nozF1cP4H3rEuuDbBEjfCcrT3gaqKUm0AAVYIi+tgYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCWwuOB1jMij8HdqjdruJMHdlra95LyJHkHL7Pdm5PmcleNTBYqkRklEsXLT1PXKK
	 k/feKrKRDzswJIiXSqwJrYbplC6j4iVJtNZofnvQBA2nqcj9teNv7wZSwA3ZVj1NH3
	 VMx9qBIKxS13lxuOu2tDqagcxcnoM/IGN9E8XJjHthrcDzlNGLUVSVn4KndHuyJdln
	 SdHO1DCKXSwuziRTOAfxY+uMv3ciFxcLROwSnyIeyrq6KBv14w0He4rKZUFeXI5CWn
	 9t3ppVAD1heUOYRZs7N5biaC3JHwfe08J7cDfhMZ1XSfK8O4B5MFidV+0qS0rTW+pB
	 EfbjbsCozU1Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904215841.303070-9-rick.p.edgecombe@intel.com>
References: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
 <20260904215841.303070-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:18:10 +0000
Message-Id: <20260904221810.BE6111F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The retry loop in `kvm_tdp_mmu_map_private_pfn` fails to top up me=
mory caches on `RET_PF_RETRY`, leading to a permanent infinite loop when `p=
amt_cache` is depleted.
--

commit 346b744d7586de76e5cf17e0acaaeca78c9eea73
Author: Kiryl Shutsemau <kas@kernel.org>

KVM: TDX: Get/put PAMT pages when (un)mapping private memory

This commit adds Dynamic PAMT support to KVM's S-EPT MMU by getting PAMT
pages when adding guest memory and putting them when removing guest memory.
It uses per-vCPU PAMT caches topped up via a new topup_external_cache op.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 22cf222d30339..48e4cf91b77f6 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -614,6 +614,10 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *=
vcpu, bool maybe_indirect)
>  					       PT64_ROOT_MAX_LEVEL);
>  		if (r)
>  			return r;
> +
> +		r =3D kvm_x86_call(topup_external_cache)(vcpu, PT64_ROOT_MAX_LEVEL);
> +		if (r)
> +			return r;
>  	}

[Severity: High]
Does this code guarantee eventual cache exhaustion during page faults?

When a host userspace process initiates KVM_TDX_INIT_MEM_REGION, it calls
kvm_tdp_mmu_map_private_pfn() in arch/x86/kvm/mmu/mmu.c. In that function,
mmu_topup_memory_caches() is located outside the retry loop:

	r =3D mmu_topup_memory_caches(vcpu, false);
	if (r)
		return r;

	do {
		if (signal_pending(current))
			return -EINTR;

		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
			return -EIO;

		cond_resched();
		guard(read_lock)(&kvm->mmu_lock);

		r =3D kvm_tdp_mmu_map(vcpu, &fault);
	} while (r =3D=3D RET_PF_RETRY);

During kvm_tdp_mmu_map(), if tdh_mem_page_add() or tdh_mem_sept_add()
encounters TDX_OPERAND_BUSY due to contention, tdx_pamt_put() frees the
just-allocated PAMT page to the generic kernel buddy allocator instead of
returning it to the cache.

kvm_tdp_mmu_map() then receives -EBUSY from tdp_mmu_set_spte_atomic() and
translates it to RET_PF_RETRY. Because the topup is outside the loop, the
pamt_cache is never replenished upon retry.

[ ... ]
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 957078e8656ef..09573112540e9 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -1701,8 +1728,13 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *k=
vm, gfn_t gfn,
>  static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_le=
vel level,
>  				  u64 new_spte)
>  {
> +	struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
>  	struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
>  	kvm_pfn_t pfn =3D spte_to_pfn(new_spte);
> +	int ret;
> +
> +	if (KVM_BUG_ON(!vcpu, kvm))
> +		return -EIO;
> =20
>  	/* TODO: handle large pages. */
>  	if (KVM_BUG_ON(level !=3D PG_LEVEL_4K, kvm))
> @@ -1710,6 +1742,10 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm,=
 gfn_t gfn, enum pg_level leve
> =20
>  	WARN_ON_ONCE((new_spte & VMX_EPT_RWX_MASK) !=3D VMX_EPT_RWX_MASK);
> =20
> +	ret =3D tdx_pamt_get(pfn, &to_tdx(vcpu)->pamt_cache);
> +	if (KVM_BUG_ON(ret, kvm))
> +		return ret;

[Severity: High]
Does this failure path cause a permanent infinite loop?

After the cache is completely drained due to the missing topups on retry,
alloc_dpamt_page() in arch/x86/virt/vmx/tdx/tdx.c returns NULL because it
lacks a GFP_ATOMIC fallback for a non-NULL cache:

static struct page *alloc_dpamt_page(struct tdx_pamt_cache *cache)
{
	if (cache)
		return tdx_alloc_page_pamt_cache(cache);

	return alloc_page(GFP_KERNEL_ACCOUNT);
}

Consequently, tdx_pamt_get() fails with -ENOMEM. This is subsequently treat=
ed
as a retryable error by tdp_mmu_map_handle_target_level() which returns
RET_PF_RETRY.

This causes the host kernel thread executing the page population ioctl to
blindly repeat forever, creating a viable denial of service vector for
unprivileged host userspace.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904215841.3030=
70-1-rick.p.edgecombe@intel.com?part=3D8
