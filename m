Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060AD3314D2
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537732; cv=none; b=VvYCUc5ZKQ1Q0xiFPKMhhhzbxo3PnqSsEnLDu++648uon871pBGlkPSn3ew95jhrZ/QS9+2wyH/K6jUVCD9lPTsy7oSvU/s8fUdU7oKoR1rBoKutfneumiyRlELnWmOChDve6qtbA1ypoqZR3/KWaJDx3Xne1Tdrw/s6fLgrjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537732; c=relaxed/simple;
	bh=4LxiFYCHHCmoMFkLpeAMYklp1aHvDjzyy1OxE/p4MxI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JjyaRZGj3gZNrGwLVfCkSrNDiD2LYfeKBIfrHa5wtHtOAeNUk3EzbnUH9uGgO+9fJ0wB2ueCkfs6O884DxYEBARH8BW33kSapCTFKf0AoHsNv81cLFr8TcZUy5B96PKnlsb1aEf59CzFNGAy5VS3az/OWOXADkvjdKZKwfi9/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUI1VjNr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUI1VjNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786537730; x=1818073730;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=4LxiFYCHHCmoMFkLpeAMYklp1aHvDjzyy1OxE/p4MxI=;
  b=VUI1VjNrASnvG1qH67rq+tP8ZXHr9HRvXKvgIWksEqeeDC1YeIFQv0Gf
   e66p9naDB5RamhxWe0axMpYhdJS9tyk/APqNhNljItgPXZAs/xTpl46Jx
   rned9T9Rmszd2CEWwRzy6NAHUvQSNb3KRE5HukllmQ7SWI765V6QuFcho
   PZTteByCpf8KWQ7OFgCZa01FKGvxafczHb2NTXmPcfpkGjwvrBFf7qaOH
   ZWJ4nJZGjByNC1wa3cvpzv6qtAQWuhSqcOFM8b52lfhHJLgMKvrosN7Ov
   VztPPnGrKM+30d+/9EB0zAFoSNHmr/4iIAwcMDEPZ9BhLgHvGXfx3u3yI
   w==;
X-CSE-ConnectionGUID: 7AtGf2GZSxmL/Xp6XYJwRw==
X-CSE-MsgGUID: /XSHfT+oSpeo796b/NRWDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98235785"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="98235785"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 05:28:49 -0700
X-CSE-ConnectionGUID: NLHutKhjTiSAB5baGwtQ9Q==
X-CSE-MsgGUID: x+itKN7uS9iPIS2c/2v+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267888704"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 05:28:48 -0700
Message-ID: <646f9595-459f-4224-b4e5-4ec2eecc0bc6@intel.com>
Date: Wed, 12 Aug 2026 20:28:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com>
 <20260810113924.4ACBE1F000E9@smtp.kernel.org>
 <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com>
 <anplcWfYReCMeu1A@google.com> <anpnFAK6EZToizbZ@google.com>
 <95d81370-3244-43c8-a6fb-6c2146d24dda@intel.com>
Content-Language: en-US
In-Reply-To: <95d81370-3244-43c8-a6fb-6c2146d24dda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/2026 11:20 AM, Xiaoyao Li wrote:
> On 8/11/2026 8:04 AM, Sean Christopherson wrote:
>> On Mon, Aug 10, 2026, Sean Christopherson wrote:
>>> On Mon, Aug 10, 2026, Xiaoyao Li wrote:
>>>> On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
>>>>>> @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu 
>>>>>> *vcpu, u32 *reason,
>>>>>>        struct vcpu_tdx *tdx = to_tdx(vcpu);
>>>>>>        *reason = tdx->vt.exit_reason.full;
>>>>>> -    if (*reason != -1u) {
>>>>>> +    if (tdx->vt.exit_reason.basic != -1) {
>>>>> [Severity: Medium]
>>>>> Will this check always evaluate to true due to C integer promotion 
>>>>> rules?
>>>>>
>>>>> The basic field in union vmx_exit_reason is a 16-bit unsigned 
>>>>> bitfield. When
>>>>> comparing it to -1, the unsigned 16-bit value is promoted to a 
>>>>> signed 32-bit
>>>>> integer. If the value was set to -1 (65535), the comparison 
>>>>> evaluates as
>>>>> 65535 != -1, which is always true.
>>>>>
>>>>
>>>> Well, how about something below on top of this patch?
>>>
>>> No, we need to not rely on magic exit_reason.basic values.  Can't 
>>> this be?
>>>
>>>     if ((tdx->vp_enter_ret & TDX_SW_ERROR) != TDX_SW_ERROR) {
>>
>> This would arguably be a bug fix as well, because the "real" 
>> EXIT_REASON_EPT_MISCONFIG
>> path gets a false negative.  E.g. when getting information for an EPT 
>> Misconfig
>> for the tracepoint, KVM really should print all information, not zeros.
>>
>> At a glance, this exact change can probably be a separate patch too.
> 
> Yeah, this issue can be fixed by the patch which turns real 
> EPT_MISCONFIG to TDX_SW_ERROR.
> 
> Side topic, tdx_to_vmx_exit_reason() can change EXIT_REASON_TDCALL to 
> other Exit Reason. Do we want to print TDCALL instead of the transformed 
> reason here?

Well, the more I think about this all, the more I dislike the fancy 
trick to turn TDCALL into other Exit Reason, in 
tdx_to_vmx_exit_reason().  Without it, it's straightforward to handle 
the EPT_MISCONFIG. And without it, the exit trace can also get the 
correct Exit Reason. How about something below? which is on top of 
kvm-x86/next


diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..2474a298e2cd 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -924,7 +924,6 @@ static __always_inline u32 
tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
  static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
  {
         struct vcpu_tdx *tdx = to_tdx(vcpu);
-       u32 exit_reason;

         switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
         case TDX_SUCCESS:
@@ -932,30 +931,11 @@ static __always_inline u32 
tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
         case TDX_NON_RECOVERABLE_TD:
         case TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE:
         case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
-               break;
+               return (u32)tdx->vp_enter_ret;
         default:
                 return -1u;
         }

-       exit_reason = tdx->vp_enter_ret;
-
-       switch (exit_reason) {
-       case EXIT_REASON_TDCALL:
-               if (tdvmcall_exit_type(vcpu))
-                       return EXIT_REASON_VMCALL;
-
-               return tdcall_to_vmx_exit_reason(vcpu);
-       case EXIT_REASON_EPT_MISCONFIG:
-               /*
-                * Defer KVM_BUG_ON() until tdx_handle_exit() because 
this is in
-                * non-instrumentable code with interrupts disabled.
-                */
-               return -1u;
-       default:
-               break;
-       }
-
-       return exit_reason;
  }

  static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
@@ -1093,9 +1073,6 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 
run_flags)

         kvm_clear_available_registers(vcpu, ~TDX_REGS_AVAIL_SET);

-       if (unlikely(tdx->vp_enter_ret == EXIT_REASON_EPT_MISCONFIG))
-               return EXIT_FASTPATH_NONE;
-
         if (unlikely((tdx->vp_enter_ret & TDX_SW_ERROR) == TDX_SW_ERROR))
                 return EXIT_FASTPATH_NONE;

@@ -2027,6 +2004,41 @@ int tdx_complete_emulated_msr(struct kvm_vcpu 
*vcpu, int err)
         return 1;
  }

+#define TDVMCALL_CPUID         EXIT_REASON_CPUID
+#define TDVMCALL_HLT           EXIT_REASON_HLT
+#define TDVMCALL_IO_INSTRUCTION        EXIT_REASON_IO_INSTRUCTION
+#define TDVMCALL_MSR_READ      EXIT_REASON_MSR_READ
+#define TDVMCALL_MSR_WRITE     EXIT_REASON_MSR_WRITE
+#define TDVMCALL_MMIO          EXIT_REASON_EPT_VIOLATION
+
+static int handle_tdcall(struct kvm_vcpu *vcpu)
+{
+       struct vcpu_tdx *tdx = to_tdx(vcpu);
+
+       if (tdvmcall_exit_type(vcpu))
+               return tdx_emulate_vmcall(vcpu);
+
+       switch (tdvmcall_leaf(vcpu)) {
+       case TDVMCALL_CPUID:
+               return tdx_emulate_cpuid(vcpu);
+       case TDVMCALL_HLT:
+               return kvm_emulate_halt_noskip(vcpu);
+       case TDVMCALL_IO_INSTRUCTION:
+               return tdx_emulate_io(vcpu);
+       case TDVMCALL_MSR_READ:
+               kvm_ecx_write(vcpu, tdx->vp_enter_args.r12);
+               return kvm_emulate_rdmsr(vcpu);
+       case TDVMCALL_MSR_WRITE:
+               kvm_ecx_write(vcpu, tdx->vp_enter_args.r12);
+               kvm_eax_write(vcpu, tdx->vp_enter_args.r13);
+               kvm_edx_write(vcpu, tdx->vp_enter_args.r13 >> 32);
+               return kvm_emulate_wrmsr(vcpu);
+       case TDVMCALL_MMIO:
+               return tdx_emulate_mmio(vcpu);
+       default:
+               return handle_tdvmcall(vcpu);
+       }
+}

  int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
  {
@@ -2037,11 +2049,6 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, 
fastpath_t fastpath)
         if (fastpath != EXIT_FASTPATH_NONE)
                 return 1;

-       if (unlikely(vp_enter_ret == EXIT_REASON_EPT_MISCONFIG)) {
-               KVM_BUG_ON(1, vcpu->kvm);
-               return -EIO;
-       }
-
         /*
          * Handle TDX SW errors, including TDX_SEAMCALL_UD, 
TDX_SEAMCALL_GP and
          * TDX_SEAMCALL_VMFAILINVALID.
@@ -2083,26 +2090,12 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, 
fastpath_t fastpath)
         case EXIT_REASON_EXTERNAL_INTERRUPT:
                 ++vcpu->stat.irq_exits;
                 return 1;
-       case EXIT_REASON_CPUID:
-               return tdx_emulate_cpuid(vcpu);
-       case EXIT_REASON_HLT:
-               return kvm_emulate_halt_noskip(vcpu);
         case EXIT_REASON_TDCALL:
-               return handle_tdvmcall(vcpu);
-       case EXIT_REASON_VMCALL:
-               return tdx_emulate_vmcall(vcpu);
-       case EXIT_REASON_IO_INSTRUCTION:
-               return tdx_emulate_io(vcpu);
-       case EXIT_REASON_MSR_READ:
-               kvm_ecx_write(vcpu, tdx->vp_enter_args.r12);
-               return kvm_emulate_rdmsr(vcpu);
-       case EXIT_REASON_MSR_WRITE:
-               kvm_ecx_write(vcpu, tdx->vp_enter_args.r12);
-               kvm_eax_write(vcpu, tdx->vp_enter_args.r13);
-               kvm_edx_write(vcpu, tdx->vp_enter_args.r13 >> 32);
-               return kvm_emulate_wrmsr(vcpu);
+               return handle_tdcall(vcpu);
         case EXIT_REASON_EPT_MISCONFIG:
-               return tdx_emulate_mmio(vcpu);
+               /* EPT MISCONFIGs are *always* KVM/kernel bugs. */
+               KVM_BUG_ON(1, vcpu->kvm);
+               return -EIO;
         case EXIT_REASON_EPT_VIOLATION:
                 return tdx_handle_ept_violation(vcpu);
         case EXIT_REASON_OTHER_SMI:
