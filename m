Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00C35836E;
	Thu,  9 Apr 2026 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700504; cv=none; b=lMrVmC21x2retz4tOPWbrviPqfhqOmlpd2InL79ZKZc0K6Upaxec6Xw7N/eJ9wCunE2kj9K6eZ/k+Uk/ZqXiBIhgqCU1oUT1ZAFUT0RYT8F+S6NW1nLN6vT86Fz70citsrYRFQJHUbyiY1m8FDRqGnFKZRe/7o6v2QsXD71aAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700504; c=relaxed/simple;
	bh=tsXt5NW0QXfcT/VEBRGx41rpG0v38RhIs7ZLIVmWGmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDomFQalzddD1NkKe8Ouom6aNHL/PV71aYnlC+7B7QnwAmEu8Ut3f/3VOqJPKOXXFkmXtvGD+Ly0Tw8gSuKOp5w/ui2hbV8o7C4pfr6WG4M99rzH8Xkmuyb0DK4XL0IobmlCuA4f4QAeCNSVd41HOSZsS0H3lvHzkBYClI1FEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGrILvtt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGrILvtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775700502; x=1807236502;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tsXt5NW0QXfcT/VEBRGx41rpG0v38RhIs7ZLIVmWGmA=;
  b=nGrILvtt0zoXZMcgK5xP97Qgjz60rZk3F2Df3JMegMeWTDhPDzX91s4q
   yEdbfsVFTd4lFBfAbiXMNL8W+V6o/9W3fnVs6/hMP3wZT+oplYnze2qoS
   96m6MAjbnFqDSb5N0lG5WWV61xrSTBR+oRn/lFGVOMgc7qKS6UF/ANu6X
   b7nqDaek+q4yhzoZUq+ZVkVOjyLAzvGwttVgUlQiA3AOXcaW1WYuwx2Z2
   /PHoW3OOTJzuhlEFp6A1xv+ex9+SMn2zs2JiCUMPFRiplxhaBpM8zaMZ1
   4wF/0VclQNGG7ZH5erY+0oBFb1FJl94GF6Rwa0bdG5Z2u/RQrMP5Io17J
   Q==;
X-CSE-ConnectionGUID: EfA4wIsJTHq3fNDqxxrihg==
X-CSE-MsgGUID: y1x6FgpASe2QKr6b7+JEKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76583842"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76583842"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 19:08:21 -0700
X-CSE-ConnectionGUID: v62/nuwaQI2mVOPwioZhXQ==
X-CSE-MsgGUID: grIbnCEGQ8yPKpKbCdnsDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="228565181"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 19:08:18 -0700
Message-ID: <5da1feaa-a376-4586-9593-12eff82e0b3d@linux.intel.com>
Date: Thu, 9 Apr 2026 10:08:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] KVM: x86: Move error handling inside
 free_external_spt()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, yan.y.zhao@intel.com,
 kai.huang@intel.com, kvm@vger.kernel.org, kas@kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-17-rick.p.edgecombe@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260327201421.2824383-17-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/28/2026 4:14 AM, Rick Edgecombe wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Move the logic for TDX’s specific need to leak pages when reclaim
> fails inside the free_external_spt() op, so this can be done in TDX
> specific code and not the generic MMU.
> 
> Do this by passing the SP in instead of the external page table
> pointer. This way TDX code can set sp->external_spt to NULL. Since the
> error is now handled internally, change the op to return void. This way
> it also operated like a normal free in that success is guaranteed from

operated -> operates ?

> the callers perspective.
> 
> Opportunistically, drop the unused level arg while adjusting the sp arg.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [re-wrote log and massaged op name]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> Notable changes since last discussion
>  - Since free_external_sp() is dropped in the latter DPAMT patches, don't
>    bother renaming free_external_spt().
> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  2 +-
>  arch/x86/include/asm/kvm_host.h    |  3 +--
>  arch/x86/kvm/mmu/tdp_mmu.c         | 13 ++-----------
>  arch/x86/kvm/vmx/tdx.c             | 25 +++++++++++--------------
>  4 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index ed348c6dd445..10ccf6ea9d9a 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -96,7 +96,7 @@ KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
>  KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
>  KVM_X86_OP(load_mmu_pgd)
>  KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
> -KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
> +KVM_X86_OP_OPTIONAL(free_external_spt)
>  KVM_X86_OP(has_wbinvd_exit)
>  KVM_X86_OP(get_l2_tsc_offset)
>  KVM_X86_OP(get_l2_tsc_multiplier)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 09588e797e4b..fbc39f0bb491 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1881,8 +1881,7 @@ struct kvm_x86_ops {
>  				 u64 new_spte, enum pg_level level);
>  
>  	/* Update external page tables for page table about to be freed. */
> -	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
> -				 void *external_spt);
> +	void (*free_external_spt)(struct kvm *kvm, gfn_t gfn, struct kvm_mmu_page *sp);
>  
>  
>  	bool (*has_wbinvd_exit)(void);
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 806788bdecce..575033cc7fe4 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -455,17 +455,8 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
>  		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
>  	}
>  
> -	if (is_mirror_sp(sp) &&
> -	    WARN_ON(kvm_x86_call(free_external_spt)(kvm, base_gfn, sp->role.level,
> -						    sp->external_spt))) {

Nit:
One thing might be worth to mention in the cover letter is that before the change,
if tdx_reclaim_page() return an error code, the warning will be triggered. After
the change, the warning is covered by the TDX_BUG_ON_3(), which is deeper in the
stack. So it's clearer that tdx_reclaim_page() failure is not handled silently.

> -		/*
> -		 * Failed to free page table page in mirror page table and
> -		 * there is nothing to do further.
> -		 * Intentionally leak the page to prevent the kernel from
> -		 * accessing the encrypted page.
> -		 */
> -		sp->external_spt = NULL;
> -	}
> +	if (is_mirror_sp(sp))
> +		kvm_x86_call(free_external_spt)(kvm, base_gfn, sp);
>  
>  	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
>  }
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index bfbadba8bc08..d064b40a6b31 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1765,27 +1765,24 @@ static void tdx_track(struct kvm *kvm)
>  	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
>  }
>  
> -static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
> -				     enum pg_level level, void *private_spt)
> +static void tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,

gfn is also not used in the function right now.
Also, since sp is passed now, the gfn can be got from sp->gfn, should gfn
also be dropped?


> +					struct kvm_mmu_page *sp)
>  {
> -	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> -
>  	/*
> -	 * free_external_spt() is only called after hkid is freed when TD is
> -	 * tearing down.
>  	 * KVM doesn't (yet) zap page table pages in mirror page table while
>  	 * TD is active, though guest pages mapped in mirror page table could be
>  	 * zapped during TD is active, e.g. for shared <-> private conversion
>  	 * and slot move/deletion.
> +	 *
> +	 * In other words, KVM should only free mirror page tables after the
> +	 * TD's hkid is freed, when the TD is being torn down.
> +	 *
> +	 * If the S-EPT PTE can't be removed for any reason, intentionally leak
> +	 * the page to prevent the kernel from accessing the encrypted page.
>  	 */
> -	if (KVM_BUG_ON(is_hkid_assigned(kvm_tdx), kvm))
> -		return -EIO;
> -
> -	/*
> -	 * The HKID assigned to this TD was already freed and cache was
> -	 * already flushed. We don't have to flush again.
> -	 */
> -	return tdx_reclaim_page(virt_to_page(private_spt));
> +	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
> +	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
> +		sp->external_spt = NULL;
>  }
>  
>  static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,

