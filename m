Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA073DE43B;
	Thu, 20 Aug 2026 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217275; cv=none; b=flZOVF2pYVh+yLKvYITCK6l8juZQO4h31jMK5zTJ7FZ0gWLrxKdwnj7mHtmfU0OvuIRg1vVLczldqwm+BfDmxyo1DADOF9gBM2KqyEFdLjO5gBiz0Mgyuicu3Vl2uCxmz6W7YTojOldbq9+hRP9xOueQWc20yfu4+Y5qNZU5TZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217275; c=relaxed/simple;
	bh=FnLMc3y+mrEj2GvDMl2VGD/eu3D5gWEgPUR5KBAN9cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/vNbmElRbO35u3BkwdeQcLx1azp1yCZFDRiNfRFIFzTgKJEjcbulv2zeIdeFXOBmlbdfxrtHgZRROWsYX9CoY9ivTlByJZBfN2QkPS7aqpb/mi9irXDmJ1bXShV2wmbazWm35ozwGxL/9M3dkEMmsbRSZzynzTaHGL5/WYVZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luECnttL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luECnttL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787217274; x=1818753274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FnLMc3y+mrEj2GvDMl2VGD/eu3D5gWEgPUR5KBAN9cs=;
  b=luECnttLh++duOakP30tcdYi1onyKgAboXLW10yhsz11hF/YHBvGHwWc
   ueDDFilUXA4IUbggF6IWRFGLcFjKX8bQ5ejVZ0rDvdW4+b/5mvO4HwywC
   dGMvY43m0NbooxHnmzkJQ9D8BbKJWI2k5FrV9dNAaBUNrg3EBJozgYRzJ
   64CtkNrPe/POIhA7z+jmHPxf0vOFVUAKnPzOVU99H+t9xq2/IeBROwPl9
   ZomdlzkYSKCKS9TerT2CF/mL11tMS9tDRrcR3sxb2Ty3I/KQzOSIfnhMC
   TMUUigs45kox1xnpXpK8B6wmuAsj3bpu9koy5leEjQR3cZY3Bb0cXUlZg
   Q==;
X-CSE-ConnectionGUID: 0VBhK3OUQea8ltaHkUwq2w==
X-CSE-MsgGUID: 1XWXkIr3R8uynhjznSBWpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91555793"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="91555793"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 02:14:33 -0700
X-CSE-ConnectionGUID: q/aAH1GuSBuOm0dJzYBj2Q==
X-CSE-MsgGUID: t0F+ELO7Q4qJW0V6ASSTOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="259762737"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 02:14:31 -0700
Message-ID: <431fdbda-cb12-4455-8c03-0d25918ee972@linux.intel.com>
Date: Thu, 20 Aug 2026 17:14:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yan Y Zhao <yan.y.zhao@intel.com>, Kai Huang <kai.huang@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260814224509.2342760-1-seanjc@google.com>
 <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
 <aoT_6cnARCAYTrYG@google.com>
 <bd8f77eb6605f771fafbcef55a47211ecbb70e19.camel@intel.com>
 <aoXSKH4QLTA5DTXe@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aoXSKH4QLTA5DTXe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> From: Sean Christopherson <seanjc@google.com>
> Date: Fri, 14 Aug 2026 07:50:32 -0700
> Subject: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
>  guessing it from CPUID
> 
> Explicitly track the root level for TDX VMs instead of trying to infer the
> depth of the paging tree based on an individual vCPU's CPUID information.
> Applying KVM's existing logic to select the root level to TDX is flawed as
> nothing *requires* userspace to fill in the correct guest.MAXPHYADDR for a
> vCPU's CPUID.  Guessing at the correct root level is also ridiculous given
> that userspace has already told KVM the root level during TD initialization.
> 
> Relying on userspace to set the expected/correct CPUID lets a misbehaving
> userspace trip the KVM_BUG_ON() in tdx_load_mmu_pgd() by configuring guest
> CPUID to use an "incorrect" guest.MAXPHYADDR.
> 
> Don't use kvm_gfn_direct_bits() to infer the mirror root level, as the
> connection between TDX's one and only "direct" bit and the predetermined
> root level is a TDX implementation detail.  I.e. avoid baking in the
> assumption that there is exactly one "direct bits", that the one bit is a
> pivot between normal and mirror roots, and that the pivot bit is the most
> significant bit of the effective GPA space.  For the same reason, set the
> root level and direct bits in TDX code, i.e. don't provide a helper in the
> MMU, because from the MMU's perspective, they are two separate concepts.
> 
> Keep gfn_direct_bits even though it can be trivially derived from
> mirror_root_level as saving a whole eight bytes per VM is meaningless,
> keeping the TDX details buring in TDX would require a kvm_x86_ops hook, and

Nit: buring -> burying 

> the value is queried fairly often and in hot paths.
> 
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Fixes: 20d913729c11 ("KVM: x86/mmu: Taking guest pa into consideration when calculate tdp level")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

With the fixup in https://lore.kernel.org/kvm/aoX5sbITQYeB7USY@google.com/

Tested-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/cpuid.c            | 14 --------------
>  arch/x86/kvm/cpuid.h            |  1 -
>  arch/x86/kvm/mmu/mmu.c          | 18 ++++++++++--------
>  arch/x86/kvm/vmx/tdx.c          | 20 +++++++++++---------
>  5 files changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 283847619ff8..b2a74c69cc4a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1406,6 +1406,7 @@ struct kvm_arch {
>  	struct kvm_mmu_memory_cache split_desc_cache;
>  
>  	gfn_t gfn_direct_bits;
> +	int mirror_root_level;
>  
>  	/*
>  	 * Size of the CPU's dirty log buffer, i.e. VMX's PML buffer. A Zero
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index ddb022cb203a..34c609a60eef 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -483,20 +483,6 @@ int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu)
>  	return 36;
>  }
>  
> -int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu)
> -{
> -	struct kvm_cpuid_entry2 *best;
> -
> -	best = kvm_find_cpuid_entry(vcpu, 0x80000000);
> -	if (!best || best->eax < 0x80000008)
> -		goto not_found;
> -	best = kvm_find_cpuid_entry(vcpu, 0x80000008);
> -	if (best)
> -		return (best->eax >> 16) & 0xff;
> -not_found:
> -	return 0;
> -}
> -
>  /*
>   * This "raw" version returns the reserved GPA bits without any adjustments for
>   * encryption technologies that usurp bits.  The raw mask should be used if and
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 8d863f45585d..46bfe8699e67 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -68,7 +68,6 @@ void __init kvm_init_xstate_sizes(void);
>  u32 xstate_required_size(u64 xstate_bv, bool compacted);
>  
>  int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
> -int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu);
>  u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu);
>  
>  static inline int cpuid_maxphyaddr(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c519e8e8d646..c78897510a1e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5928,19 +5928,21 @@ void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
>  
>  static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
>  {
> -	int maxpa;
> -
> -	if (vcpu->kvm->arch.vm_type == KVM_X86_TDX_VM)
> -		maxpa = cpuid_query_maxguestphyaddr(vcpu);
> -	else
> -		maxpa = cpuid_maxphyaddr(vcpu);
> -
>  	/* tdp_root_level is architecture forced level, use it if nonzero */
>  	if (tdp_root_level)
>  		return tdp_root_level;
>  
> +	/*
> +	 * If the VM has mirror roots, then the root level is predefined as the
> +	 * mirror root (and by extension the normal root) needs to match the
> +	 * root level that was configured for the external page tables that are
> +	 * being mirrored by KVM.
> +	 */
> +	if (vcpu->kvm->arch.mirror_root_level)
> +		return vcpu->kvm->arch.mirror_root_level;
> +
>  	/* Use 5-level TDP if and only if it's useful/necessary. */
> -	if (max_tdp_level == 5 && maxpa <= 48)
> +	if (max_tdp_level == 5 && cpuid_maxphyaddr(vcpu) <= 48)
>  		return 4;
>  
>  	return max_tdp_level;
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b272c20586a7..a0bc9f818f43 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -56,9 +56,6 @@
>  bool enable_tdx __ro_after_init;
>  module_param_named(tdx, enable_tdx, bool, 0444);
>  
> -#define TDX_SHARED_BIT_PWL_5 gpa_to_gfn(BIT_ULL(51))
> -#define TDX_SHARED_BIT_PWL_4 gpa_to_gfn(BIT_ULL(47))
> -
>  static const struct tdx_sys_info *tdx_sysinfo;
>  
>  void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, u64 err)
> @@ -1609,10 +1606,7 @@ static int handle_tdvmcall(struct kvm_vcpu *vcpu)
>  
>  void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
>  {
> -	u64 shared_bit = (pgd_level == 5) ? TDX_SHARED_BIT_PWL_5 :
> -			  TDX_SHARED_BIT_PWL_4;
> -
> -	if (KVM_BUG_ON(shared_bit != kvm_gfn_direct_bits(vcpu->kvm), vcpu->kvm))
> +	if (KVM_BUG_ON(pgd_level != vcpu->kvm->arch.mirror_root_level, vcpu->kvm))
>  		return;
>  
>  	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa);
> @@ -2760,6 +2754,14 @@ DEFINE_CLASS(tdx_vm_state_guard, tdx_vm_state_guard_t,
>  	     if (!IS_ERR(_T)) tdx_release_vm_state_locks(_T),
>  	     tdx_acquire_vm_state_locks(kvm), struct kvm *kvm);
>  
> +static __always_inline void tdx_set_mirror_root_level(struct kvm *kvm, int level)
> +{
> +	BUILD_BUG_ON(level != 4 && level != 5);
> +
> +	kvm->arch.mirror_root_level = level;
> +	kvm->arch.gfn_direct_bits = gpa_to_gfn(BIT_ULL(level == 4 ? 47 : 51));
> +}
> +
>  static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>  {
>  	struct kvm_tdx_init_vm __user *user_data = u64_to_user_ptr(cmd->data);
> @@ -2823,9 +2825,9 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>  	kvm_tdx->xfam = td_params->xfam;
>  
>  	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW)
> -		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_5;
> +		tdx_set_mirror_root_level(kvm, 5);
>  	else
> -		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_4;
> +		tdx_set_mirror_root_level(kvm, 4);
>  
>  	kvm_tdx->state = TD_STATE_INITIALIZED;
>  out:
> 
> base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
> --
> 

