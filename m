Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AC3D9680
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916416; cv=none; b=OpW2Qv1lKn2f5aEPIg58rRAkpZSxe0sCZUmHf26tfuJWJNuv9Pf38VpOfZlMBGMBWz9/VovIHQnGMhrHKbTLpA3ZLHkjvDEO0mIIu8gVjQo6jr3AMeqrKenh6PcVBRi4NC6SiEjRmUxzBNiQoSMnfsYVx9pWfAUXtn4910LUdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916416; c=relaxed/simple;
	bh=pknl9TYvrxvyOFWsgkanW5sgMZO4eSyzokheV0jIqaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUEVP1lYACcmWcJzke2jQ+4Jy2Q97E+GKGY6cOluJSaWFhCqaCDWiuqlaZyyz/6L+ujgVOTd+aQ2vMXxrkv7ndLAF9O8XBjnyAk1/ghbEIiRodp39XX0VbRLpeXVfxDj4zLku3GJYlMS2NRovtSg49QKyT0Mc3OgX1lDhEjqeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwjPFYgc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwjPFYgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785916415; x=1817452415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pknl9TYvrxvyOFWsgkanW5sgMZO4eSyzokheV0jIqaA=;
  b=hwjPFYgchtT7tCYmePh1y9CzTEBXfNpe6bEZjuryffLlncAlkPR2OT8F
   hl7/gvql/ARQY6b3cwUtttbvMB/+oyBmWVKkcUui2S3woRSeGn6pG+Qni
   Q10sUTx5UukxU8CqjfLQQVfdHqrnZYbELaci+C3ppklD0Husfy5iKCbsx
   wLCfwV8GlID9loUdJ5Pf054c8fynd2CkqcWLFJyjj87/SGV6ZZ7Dxmwj7
   ZZqv9GQxoih6CpFlW5kjo3YM3zNnPNGq3C5OGPT/dUkg3AwCWJfbYeJMp
   n/cnyJzGneYjp48e4CWbfK77xMh8L8+OTM417sEO7yyUIhsytADGq6H1H
   Q==;
X-CSE-ConnectionGUID: jOMFJG4xRKmCFPAS0O9/vg==
X-CSE-MsgGUID: lozOC43KQvGsJ2UCDo2RLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97643025"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97643025"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 00:53:34 -0700
X-CSE-ConnectionGUID: vYnFk2RDSXG54R7vQ54xqA==
X-CSE-MsgGUID: qRVFZR06QYWKWpAvvGwsgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261166542"
Received: from fuxiaogu-mobl1.ccr.corp.intel.com (HELO [10.238.208.47]) ([10.238.208.47])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 00:53:34 -0700
Message-ID: <4fedcaa6-d710-48f8-84c4-de682350bb2f@intel.com>
Date: Wed, 5 Aug 2026 15:53:31 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: TDX: Enable Bus Lock VM exit
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-3-xiaoyao.li@intel.com>
 <20260805034602.5B2BB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260805034602.5B2BB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/2026 11:46 AM, sashiko-bot@kernel.org wrote:
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index cdc0d24657acb..c037e9cb5bdfc 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -2031,7 +2031,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
>>   }
>>   
>>   
>> -int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>> +static int __tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>>   {
>>   	struct vcpu_tdx *tdx = to_tdx(vcpu);
>>   	u64 vp_enter_ret = tdx->vp_enter_ret;
> 
> [Severity: High]
> Does this code handle the bus_lock_detected bit (bit 26) being set in
> vp_enter_ret or the raw 32-bit exit reason?
> 
> If userspace triggers a bus lock concurrently with an exit, the hardware can
> set bit 26.  Will strict equality checks on vp_enter_ret (such as checking for
> EXIT_REASON_EPT_MISCONFIG later in this function) fail because the bit is
> unmasked?

Sashiko is correct. I think the handling like

   (vp_enter_ret == EXIT_REASON_EPT_MISCONFIG)

is not safe, we need to first mask vp_enter_ret. Will add a separate 
patch for it.

> This also appears to affect tdx_to_vmx_exit_reason(), where comparing the raw
> exit reason directly against 16-bit constants like EXIT_REASON_TDCALL will
> fail to match if the bus lock bit is set, leading to incorrect emulation.

This is valid. We need to adjust tdx_to_vmx_exit_reason().

However, there is a more important problem. Since Bus Lock VM exit makes 
bit 26 possible in EXIT REASON, the trick of "return -1" in 
tdx_to_vmx_exit_reason() will introduce false-positive in the following 
check of if(vmx_get_exit_reason(vcpu).bus_lock_detected) added by this 
patch.

how about something like below:

---8<---
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c037e9cb5bdf..54598dcda938 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -927,7 +927,7 @@ static __always_inline u32 
tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
  static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
  {
         struct vcpu_tdx *tdx = to_tdx(vcpu);
-       u32 exit_reason;
+       union vmx_exit_reason exit_reason;

         switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
         case TDX_SUCCESS:
@@ -937,28 +937,29 @@ static __always_inline u32 
tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
         case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
                 break;
         default:
-               return -1u;
+               return (u16)-1u;
         }

-       exit_reason = tdx->vp_enter_ret;
+       exit_reason.full = tdx->vp_enter_ret;

-       switch (exit_reason) {
+       switch (exit_reason.basic) {
         case EXIT_REASON_TDCALL:
                 if (tdvmcall_exit_type(vcpu))
-                       return EXIT_REASON_VMCALL;
+                       exit_reason.basic = EXIT_REASON_VMCALL;

-               return tdcall_to_vmx_exit_reason(vcpu);
+               exit_reason.basic = tdcall_to_vmx_exit_reason(vcpu);
+               break;
         case EXIT_REASON_EPT_MISCONFIG:
                 /*
                  * Defer KVM_BUG_ON() until tdx_handle_exit() because 
this is in
                  * non-instrumentable code with interrupts disabled.
                  */
-               return -1u;
+               return (u16)-1u;
         default:
                 break;
         }

-       return exit_reason;
+       return exit_reason.full;
  }

  static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)

> [ ... ]
> 
>> @@ -2141,6 +2143,21 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>>   	return 0;
>>   }
>>   
>> +int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>> +{
>> +	int ret = __tdx_handle_exit(vcpu, fastpath);
>> +
>> +	/* Exit to user space when bus lock was detected */
>> +	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
>> +		if (ret > 0)
>> +			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +
>> +		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>> +		return 0;
> 
> [Severity: High]
> Does this code silently drop negative error codes?
> 
> If __tdx_handle_exit() returns a negative error code (like -EIO or -EFAULT)
> while bus_lock_detected is true, it skips setting vcpu->run->exit_reason but
> still returns 0.
> 
> Could this cause KVM to return success to userspace with an uninitialized or
> stale exit_reason instead of propagating the error?

It won't return uninitialized or stale exit_reason. But changing the 
negative error codes to 0 is a wrong behavior. I will fix it.

The VMX handler looks to have the issue. I'll cook a separate patch to 
fix it.

>> +	}
>> +	return ret;
>> +}
> 
> [ ... ]
> 
>> @@ -3167,6 +3184,10 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
>>   				vcpu->kvm->arch.notify_window);
>>   	}
>>   
>> +	if (vcpu->kvm->arch.bus_lock_detection_enabled)
>> +		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
>> +				 SECONDARY_EXEC_BUS_LOCK_DETECTION);
> 
> [Severity: High]
> Is it safe to write this execution control to the TD VMCS without verifying if
> the TDX module supports it?
> 
> If a host userspace process enables KVM_CAP_X86_BUS_LOCK_EXIT but the TDX
> module restricts this capability, could td_vmcs_setbit32() fail on TDH.VP.WR,
> triggering the KVM_BUG_ON() macro and destroying the VM?

Same for the patch 1. This is not possible, TDX module itself should 
always support Bus Lock VM exit unless the hardware doesn't support it. 
But in the case of hardware doesn't it, KVM doesn't set 
kvm_caps.has_bus_lock_exit thus userspace cannot enable 
KVM_CAP_X86_BUS_LOCK_EXIT.

>> +
>>   	tdx->state = VCPU_TD_STATE_INITIALIZED;
>>   
>>   	return 0;
> 

