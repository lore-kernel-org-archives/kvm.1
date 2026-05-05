Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B120331A6D;
	Tue,  5 May 2026 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975361; cv=none; b=W5tGuUYzoHGBtLy4i40jNJ3poOe75rZrN1D334YhgXBmGs0GfQNfA+ECq/G/bED7d1GrokBG17HThahxTF2x/E7R2XNvRrJDe9wfWIKHOcp8DRqRMMi1BSWg+D3CVGCnOEyBOn3PCBqyhhgTU7GcgZlHekZep9WIES90Haj3YEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975361; c=relaxed/simple;
	bh=9cwA2Ax9dm0ci6zoDqPJ0UqknDr0wXQou0U68YGwm7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adtaOVaf4E9wnr+lPNLyi502hs1MxiL/u4l7BerP21FmctWj7Va8caktUBhHMSaTAbmgOu1HBR8IZgThwaLvw24Hk6hP1J1x4U4JrHKkHnZoYPKp2T07uzoW0ItntuAuyWieg0rYf0dXLTbCIBxRLZXkzzvXl9Xw+O4+u0HW8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E69D581606;
	Tue, 05 May 2026 12:02:30 +0200 (CEST)
Message-ID: <0323cf8e-0093-4e54-8bcd-3e336ed945ed@proxmox.com>
Date: Tue, 5 May 2026 12:02:29 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/28] KVM: VMX: enable use of MBEC
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: jon@nutanix.com
References: <20260430150747.76749-1-pbonzini@redhat.com>
 <20260430150747.76749-16-pbonzini@redhat.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <20260430150747.76749-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777975243973

see inline.

On 4/30/26 5:10 PM, Paolo Bonzini wrote:
> [...]
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 337bbfecc021..72a75fa33c93 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -114,6 +114,9 @@ module_param(emulate_invalid_guest_state, bool, 0444);
>   static bool __read_mostly fasteoi = 1;
>   module_param(fasteoi, bool, 0444);
>   
> +bool __read_mostly enable_mbec = 1;
> +module_param_named(mbec, enable_mbec, bool, 0444);
> +
>   module_param(enable_apicv, bool, 0444);
>   module_param(enable_ipiv, bool, 0444);
>   
> @@ -2773,6 +2776,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>   			return -EIO;
>   
>   		vmx_cap->ept = 0;
> +		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
>   		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_EPT_VIOLATION_VE;
>   	}
>   	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
> @@ -4735,6 +4739,9 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
>   	 */
>   	exec_control &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
>   
> +	if (!enable_mbec)
> +		exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> +
>   	/* SECONDARY_EXEC_DESC is enabled/disabled on writes to CR4.UMIP,
>   	 * in vmx_set_cr4.  */
>   	exec_control &= ~SECONDARY_EXEC_DESC;
> @@ -7823,6 +7830,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
>   	return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);
>   }
>   
> +bool vmx_tdp_has_smep(struct kvm *kvm)
> +{
> +	return enable_mbec;
> +}
> +
>   static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx, u32 new_ctl)
>   {
>   	/*
> @@ -8622,6 +8634,8 @@ __init int vmx_hardware_setup(void)
>   
>   	if (!cpu_has_vmx_ept_ad_bits() || !enable_ept)
>   		enable_ept_ad_bits = 0;
> +	if (!cpu_has_ept_mbec() || !enable_ept)
> +		enable_mbec = 0;
>   
>   	if (!cpu_has_vmx_unrestricted_guest() || !enable_ept)
>   		enable_unrestricted_guest = 0;
> @@ -8683,7 +8697,7 @@ __init int vmx_hardware_setup(void)
>   	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
>   
>   	if (enable_ept)
> -		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
> +		kvm_mmu_set_ept_masks(enable_ept_ad_bits, enable_mbec);
This patch introduces a build failure for me on v7.1-rc2
(and v7.1-rc1) due to a function signature mismatch for
kvm_mmu_set_ept_masks.

In this patch, the call site in arch/x86/kvm/vmx/vmx.c is updated to
pass two arguments:
kvm_mmu_set_ept_masks(enable_ept_ad_bits, enable_mbec);

However, the definition in arch/x86/kvm/mmu/spte.c and the declaration
in arch/x86/kvm/mmu.h appear to have remained single-argument
functions:
void kvm_mmu_set_ept_masks(bool has_ad_bits);

This results in:
error: too many arguments to function ‘kvm_mmu_set_ept_masks’

>   	else
>   		vt_x86_ops.get_mt_mask = NULL;
>   
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index db84e8001da5..0a4e263c4095 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -567,6 +567,7 @@ static inline u8 vmx_get_rvi(void)
>   	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
>   	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
>   	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
> +	 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |				\
>   	 SECONDARY_EXEC_ENCLS_EXITING |					\
>   	 SECONDARY_EXEC_EPT_VIOLATION_VE)
>   
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index d09abeac2b56..69cf276be88e 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -103,6 +103,7 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
>   int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
>   int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
>   u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
> +bool vmx_tdp_has_smep(struct kvm *kvm);
>   
>   void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>   		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);

