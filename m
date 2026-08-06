Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3623AC00
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000582; cv=none; b=oGAK+Z1NC5+yrsiZvYg/W7j84HYx9Ai2m/WjIi6vE1VDVEeCnSujMDAJbMgPY8X9bNwJHcxyxagGKCTvoAA84Iv3gXf6jqrlyOtuw55tIp4L2tHTKM0pj8p/yXvP195uZ539ShtwT/UYzNGsHiTV8dE4Z529HkGziJqAKSXbfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000582; c=relaxed/simple;
	bh=kQbUP99AmCOZKVTYVGzCQ2SF4V64WmPh3ti8iYmzHMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pE986hizFbgHPoXVO2aBtBn6HD9DqElH+I1vhVmzVbKnQHobJjryID7a5n9OSS2ocxbM5O8tX8yu0XwQJ16A5UYPquXsbNf9d2kB2+NecQ8Y2RFUODuXcvIH+o4RcIkxAaZT6dvnrTDnk4AIfJoIEzOMgrypdyRqn3Tn0SWIBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLFcuK5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLFcuK5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EACF1F000E9;
	Thu,  6 Aug 2026 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786000581;
	bh=3k1UzYZkSpC0CLrjhbuhyBFhK3DQHqVU2so7A5cU4JM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TLFcuK5GJLBTyZ+vFeXYLF2KdF2k3g/JC1U1llbFEeY2A5ltBV9DOpQ1Tqw/smCvA
	 RSO4OpMafdSYd0WlaOUXOc5Y6ajutWwSuMAGaPkfR16Y86yFsv+d15jK+DPRr3W6mx
	 oiPL/8Sy6qEgE6ElZ5isopqQkkUm/ykSWrveMZ4tZ6Jd7GSv1sF9WSifWbjXZ8l25G
	 VJTSlvi5heDOHBU5HkeZTCoPnNgIsQkohfhxhRkRJs984ezQ8onKEDc8z7Gtk65xVx
	 81R84LYmdJGm7LwS7+Q0PP9AuClvo3c261x5/WuwvsNdRImhL6RPmltH7NdntJq5Sq
	 rapOSILtL67iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806020850.1221381-9-rick.p.edgecombe@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
 <20260806020850.1221381-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 07:16:20 +0000
Message-Id: <20260806071621.3EACF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Transient TDX_OPERAND_BUSY errors during private memory mappin=
g cause KVM to indefinitely retry the fault without restocking vCPU memory =
caches, leading to cache depletion and deterministic VM or host crash.
--

--- Patch [8]: [PATCH v9 08/11] KVM: TDX: Get/put PAMT pages when (un)mappi=
ng private memory ---
commit caefd7119dad264568b4b1abac0ec41595539508
Author: Kiryl Shutsemau <kas@kernel.org>
Subject: KVM: TDX: Get/put PAMT pages when (un)mapping private memory

This patch adds Dynamic PAMT support to KVM's S-EPT MMU by getting a PAMT
page when adding guest memory, and putting the page when removing it.
The kernel supplies the TDX module with a few pages that cover 2MB of host
physical memory.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 957078e8656ef..09573112540e9 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

> [ ... ]

> @@ -1679,16 +1694,28 @@ static struct page *tdx_spte_to_sept_pt(struct kv=
m *kvm, gfn_t gfn,
>  static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
>  				     enum pg_level level, u64 new_spte)
>  {
> +	struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
>  	gpa_t gpa =3D gfn_to_gpa(gfn);
>  	u64 err, entry, level_state;
>  	struct page *sept_pt;
> +	int ret;
> +
> +	if (KVM_BUG_ON(!vcpu, kvm))
> +		return -EIO;
> =20
>  	sept_pt =3D tdx_spte_to_sept_pt(kvm, gfn, new_spte, level);
>  	if (!sept_pt)
>  		return -EIO;
> =20
> +	ret =3D tdx_pamt_get(page_to_pfn(sept_pt), &to_tdx(vcpu)->pamt_cache);
> +	if (KVM_BUG_ON(ret, kvm))
> +		return ret;
> +
>  	err =3D tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
>  			       &entry, &level_state);
> +	if (err)
> +		tdx_pamt_put(page_to_pfn(sept_pt));
> +

[Severity: Critical]
When tdh_mem_sept_add() returns an error like TDX_OPERAND_BUSY, this path
calls tdx_pamt_put(), which frees the page back to the global allocator
instead of returning it to the vCPU cache.

Since a busy error returns -EBUSY and triggers a RET_PF_RETRY loop in
kvm_tdp_mmu_map_private_pfn():

kvm_tdp_mmu_map_private_pfn() {
    ...
    do {
        ...
        r =3D kvm_tdp_mmu_map(vcpu, &fault);
    } while (r =3D=3D RET_PF_RETRY);
    ...
}

Does this repeatedly drain the vCPU's memory cache without topping it up?

The loop re-attempts the mapping without calling mmu_topup_memory_caches(),
meaning repeated contentions could quickly exhaust the cache capacity.

>  	if (unlikely(tdx_operand_busy(err)))
>  		return -EBUSY;
> =20
> [ ... ]
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
> +

[Severity: Critical]
If the vCPU's pamt_cache is exhausted due to the retry loop mentioned above,
tdx_pamt_get() will return -ENOMEM.

Does this KVM_BUG_ON() trigger when the cache depletes, permanently killing
the VM?

Could a busy guest intentionally induce TDX_OPERAND_BUSY contentions by
performing memory operations simultaneously with TDH.VP.ENTER on other vCPUs
to reliably trigger this crash?

>  	/*
>  	 * Ensure pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory()
>  	 * before kvm_tdx->state.  Userspace must not be allowed to pre-fault

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806020850.1221=
381-1-rick.p.edgecombe@intel.com?part=3D8
