Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB45211466
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934948; cv=none; b=sd40njlvo0YpNG/TOkFEUMtalZ6JKm01bmQUAk+OUKLNynSmmlpcEzdhNMAuRJOZVJekmAuMtdT9i6hODzHxF6B9e+Q9Lp5hpeQu4TbR1H4nbizkn/AqVHYHsUr9VMN8Vc5mI97mNzM/b5nGJybFrrjAzf9stv56R6leaWvefqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934948; c=relaxed/simple;
	bh=n2WL18QbkJXJN8OvYh75LNNQjNrZrLU+wUyTRx9yt5s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kzag8Qs/gzz0syrZarwY5Tyg/sKTXBNXi8/mE1/Z1PgF77Zp5SbsKyZAtM2psMBLTiD51LQZOBELPWSVQi+wpneQ5bAAKkW3zgR+NCKUVEGo3UxaonVROep84buphsfhoPO0+jdoSD8YW7F5metoh5FS8qhki8V5cBYpo/d8v5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZqK2Hfp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZqK2Hfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786934946; x=1818470946;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=n2WL18QbkJXJN8OvYh75LNNQjNrZrLU+wUyTRx9yt5s=;
  b=fZqK2HfpZeY0QetjVK2SQBUtSIkog1KO6nQAkblXwmimBMT6wdzDR2RC
   RNmiNxv+Qc3fSlyJn30L/oemWhPXIzOB2z/MGjo4TBgn305ma2HBU1Tuu
   sRJo+zY5G2CcENGkt9fkIbWxVzhbx0oRHD77uejvAmihToXvn2b+7XuM7
   cCsSlFyaH2TNnf41rrAWTGXqXzFVBPF6ibBlkYKpKeCl6Q8J7qIcZ3XEJ
   8IBwS90ZESPk/2pGAwwyVm7bjrnWiNagE8V+8t6dLqmmCAjw+ZPMlKZ2W
   WwKq9+iYjQP/kMSc09n8Btayaq9lSNPupxsMmGic/mldLilDJ6Q9l+KXi
   A==;
X-CSE-ConnectionGUID: fVjm/tPuSa2ADBOj0qYOLQ==
X-CSE-MsgGUID: mL26GzHLQr+vVXFHr+Ad1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91220971"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="91220971"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 19:49:06 -0700
X-CSE-ConnectionGUID: iJPeAk6JQOKC7btkjK5iig==
X-CSE-MsgGUID: mppKOT1GQ9SIdFr5jkZb/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="261511890"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 19:49:04 -0700
Message-ID: <d67eb097-1223-4b68-92d4-1510d3d7be7c@intel.com>
Date: Mon, 17 Aug 2026 10:49:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com>
 <20260812082306.11E8B1F000E9@smtp.kernel.org>
 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
 <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
 <an5W5XC97HK229MX@google.com>
 <eddf28d4-c211-41fb-b0a3-586e5afde030@intel.com>
 <an8wUfZ9JxvEhtHS@google.com>
Content-Language: en-US
In-Reply-To: <an8wUfZ9JxvEhtHS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/2026 11:12 PM, Sean Christopherson wrote:
> On Fri, Aug 14, 2026, Xiaoyao Li wrote:
>> On 8/14/2026 7:44 AM, Sean Christopherson wrote:
>>> On Wed, Aug 12, 2026, Rick P Edgecombe wrote:
>>>> Side note. I really dislike how tangled this area is for something that seems
>>>> like it should be much more straightforward. Deriving partially I think from the
>>>> overloading of the TDVMCALL leafs with the exit reasons. So we have things like:
>>>> ...
>>>> 	case EXIT_REASON_EPT_VIOLATION:
>>>> 		return EXIT_REASON_EPT_MISCONFIG;
>>>> ...
>>>
>>> I peeked at that code again, and FWIW I still think swizzling the exit_reason for
>>> TDVMCALL is the least awful solution.  If we don't do that, then we'll have to
>>> update every single use of the exit_reason to demux TDVMCALL into the "real" exit
>>> reason, which will be a mess.
>>
>> I'm not sure if you read my idea[1]?
>>
>> I think there is only one place KVM cares about the exit_reason TDVMCALL,
>> just the
>>
>> 	case EXIT_REASON_TDCALL:
> 
> No, the massaged exit_reason is also subtley consumed via trace_kvm_exit().

yeah. This is exactly the one I don't like, it looks like 
trace_kvm_exit() is tracing the wrong exit reason, though it is by 
intentional.

> It's also consumed by tdx_complete_emulated_msr():
> 
> 	if (vmx_get_exit_reason(vcpu).basic == EXIT_REASON_MSR_READ)
> 
> and by tdx_interrupt_allowed()
> 
> 	return vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
> 	       !to_tdx(vcpu)->vp_enter_args.r12;
> 
> and by tdx_protected_apic_has_interrupt():
> 
> 	if (vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
> 	    to_tdx(vcpu)->vp_enter_args.r12)
> 		return false;

Ah, I really should have checked the code more carefully.

>> in tdx_handle_exit().
>> [1]
>> https://lore.kernel.org/all/646f9595-459f-4224-b4e5-4ec2eecc0bc6@intel.com/
>>> And once we track the exit_reason separately from vp_enter_ret, IMO it all becomes
>>> more logical and easier to follow.  vp_enter_ret holds the information about why
>>> VP.ENTER returned/exited, while exit_reason holds information about why the _guest_
>>> exited.  Obviously it's imperfect since we're still fudging EXIT_REASON_EPT_MISCONFIG,
>>> but again, I think that's a better alternative than demuxing exit_reason in multiple
>>> locations.
>>
>> The question do we really need to swizzle EXIT_REASON_TDCALL to other exit
>> reasons ahead? why cannot them just be handled in the central handler for
>> EXIT_REASON_TDCALL?
> 
> Because as above, it's not as central as you think.  If we want to not swizzle
> the exit_reason, then IMO the only sane way to do that is to not track exit_reason
> for TDX vCPUs, i.e. move vcpu_vt.exit_reason back to vcpu_vmx and force TDX to
> always demux vp_enter_ret every time.

How about adding a specific field to track the TDVMCALL leaf? Full diff 
as below (the EPT MISCONFIG part can be split into a separate one)


-----8<--------
diff --git a/arch/x86/include/asm/shared/tdx.h 
b/arch/x86/include/asm/shared/tdx.h
index f20e91d7ac35..61d00100a2b1 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -69,6 +69,13 @@
  #define TD_CTLS_LOCK                   BIT_ULL(TD_CTLS_LOCK_BIT)

  /* TDX hypercall Leaf IDs */
+#define TDVMCALL_CPUID                 10 /* EXIT_REASON_CPUID */
+#define TDVMCALL_HLT                   12 /* EXIT_REASON_HLT */
+#define TDVMCALL_IO_INSTRUCTION                30 /* 
EXIT_REASON_IO_INSTRUCTION */
+#define TDVMCALL_MSR_READ              31 /* EXIT_REASON_MSR_READ */
+#define TDVMCALL_MSR_WRITE             32 /* EXIT_REASON_MSR_WRITE */
+#define TDVMCALL_MMIO                  48 /* EXIT_REASON_EPT_VIOLATION */
+
  #define TDVMCALL_GET_TD_VM_CALL_INFO   0x10000
  #define TDVMCALL_MAP_GPA               0x10001
  #define TDVMCALL_GET_QUOTE             0x10002
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 545b03d9d10b..113bcf301ec9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -734,6 +734,12 @@ void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
         local_irq_enable();
  }

+static bool tdx_is_tdvmcall(struct kvm_vcpu *vcpu, u64 
tdvmcall_exit_reason)
+{
+       return vmx_get_exit_reason(vcpu).basic == EXIT_REASON_TDCALL &&
+              to_tdx(vcpu)->tdvmcall_exit_reason == tdvmcall_exit_reason;
+}
+
  bool tdx_interrupt_allowed(struct kvm_vcpu *vcpu)
  {
         /*
@@ -741,7 +747,7 @@ bool tdx_interrupt_allowed(struct kvm_vcpu *vcpu)
          * interrupt is always allowed unless TDX guest calls TDVMCALL 
with HLT,
          * which passes the interrupt blocked flag.
          */
-       return vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
+       return !tdx_is_tdvmcall(vcpu, TDVMCALL_HLT) ||
                !to_tdx(vcpu)->vp_enter_args.r12;
  }

@@ -759,7 +765,7 @@ static bool tdx_protected_apic_has_interrupt(struct 
kvm_vcpu *vcpu)
          * otherwise the interrupt would have been serviced at the 
instruction
          * boundary.
          */
-       if (vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
+       if (!tdx_is_tdvmcall(vcpu, TDVMCALL_HLT) ||
             to_tdx(vcpu)->vp_enter_args.r12)
                 return false;

@@ -906,28 +912,9 @@ int tdx_vcpu_pre_run(struct kvm_vcpu *vcpu)
         return 1;
  }

-static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
-{
-       switch (tdvmcall_leaf(vcpu)) {
-       case EXIT_REASON_CPUID:
-       case EXIT_REASON_HLT:
-       case EXIT_REASON_IO_INSTRUCTION:
-       case EXIT_REASON_MSR_READ:
-       case EXIT_REASON_MSR_WRITE:
-               return tdvmcall_leaf(vcpu);
-       case EXIT_REASON_EPT_VIOLATION:
-               return EXIT_REASON_EPT_MISCONFIG;
-       default:
-               break;
-       }
-
-       return EXIT_REASON_TDCALL;
-}
-
  static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
  {
         struct vcpu_tdx *tdx = to_tdx(vcpu);
-       u32 exit_reason;

         switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
         case TDX_SUCCESS:
@@ -935,30 +922,10 @@ static __always_inline u32 
tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
         case TDX_NON_RECOVERABLE_TD:
         case TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE:
         case TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE:
-               break;
+               return (u32)tdx->vp_enter_ret;
         default:
                 return -1u;
         }
-
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
@@ -1096,9 +1063,6 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 
run_flags)

         kvm_clear_available_registers(vcpu, ~TDX_REGS_AVAIL_SET);

-       if (unlikely(tdx->vp_enter_ret == EXIT_REASON_EPT_MISCONFIG))
-               return EXIT_FASTPATH_NONE;
-
         if (unlikely((tdx->vp_enter_ret & TDX_SW_ERROR) == TDX_SW_ERROR))
                 return EXIT_FASTPATH_NONE;

@@ -1589,27 +1553,6 @@ static int 
tdx_setup_event_notify_interrupt(struct kvm_vcpu *vcpu)
         return 0;
  }

-static int handle_tdvmcall(struct kvm_vcpu *vcpu)
-{
-       switch (tdvmcall_leaf(vcpu)) {
-       case TDVMCALL_MAP_GPA:
-               return tdx_map_gpa(vcpu);
-       case TDVMCALL_REPORT_FATAL_ERROR:
-               return tdx_report_fatal_error(vcpu);
-       case TDVMCALL_GET_TD_VM_CALL_INFO:
-               return tdx_get_td_vm_call_info(vcpu);
-       case TDVMCALL_GET_QUOTE:
-               return tdx_get_quote(vcpu);
-       case TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
-               return tdx_setup_event_notify_interrupt(vcpu);
-       default:
-               break;
-       }
-
-       tdvmcall_set_return_code(vcpu, TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED);
-       return 1;
-}
-
  void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int 
pgd_level)
  {
         u64 shared_bit = (pgd_level == 5) ? TDX_SHARED_BIT_PWL_5 :
@@ -2024,12 +1967,56 @@ int tdx_complete_emulated_msr(struct kvm_vcpu 
*vcpu, int err)
                 return 1;
         }

-       if (vmx_get_exit_reason(vcpu).basic == EXIT_REASON_MSR_READ)
+       if (tdx_is_tdvmcall(vcpu, TDVMCALL_MSR_READ))
                 tdvmcall_set_return_val(vcpu, kvm_read_edx_eax(vcpu));

         return 1;
  }

+static int handle_tdcall(struct kvm_vcpu *vcpu)
+{
+       struct vcpu_tdx *tdx = to_tdx(vcpu);
+
+       if (tdvmcall_exit_type(vcpu)) {
+               tdx->tdvmcall_exit_reason = EXIT_REASON_VMCALL;
+               return tdx_emulate_vmcall(vcpu);
+       }
+
+       tdx->tdvmcall_exit_reason = tdvmcall_leaf(vcpu);
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
+       case TDVMCALL_MAP_GPA:
+               return tdx_map_gpa(vcpu);
+       case TDVMCALL_REPORT_FATAL_ERROR:
+               return tdx_report_fatal_error(vcpu);
+       case TDVMCALL_GET_TD_VM_CALL_INFO:
+               return tdx_get_td_vm_call_info(vcpu);
+       case TDVMCALL_GET_QUOTE:
+               return tdx_get_quote(vcpu);
+       case TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
+               return tdx_setup_event_notify_interrupt(vcpu);
+       default:
+               break;
+       }
+
+       tdvmcall_set_return_code(vcpu, TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED);
+       return 1;
+}

  int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
  {
@@ -2040,11 +2027,6 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, 
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
@@ -2086,26 +2068,12 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, 
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
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index ac8323a68b16..fc9c0c462f77 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -68,6 +68,22 @@ struct vcpu_tdx {

         u64 vp_enter_ret;

+       /*
+        * Valid only when exit_reason is EXIT_REASON_TDCALL.
+        *
+        * When r10 of TDCALL is 0. It means the TDCALL is invoked for a
+        * TDVMCALL leaf that is defined by the GHCI spec. In this case,
+        * tdvmcall_exit_reason is set to the value of r11.
+        *
+        * When r10 of TDCALL is not 0. KVM treats it as a KVM hypercall.
+        * In this case, tdvmcall_exit_reason is set to EXIT_REASON_VMCALL,
+        * as what to invoke KVM hypercall in VMX. If GHCI defines the
+        * number of EXIT_REASON_VMCALL to a new TDVMCALL leaf in the future
+        * and KVM is going to support it, KVM will need to choose a new 
value
+        * for tdvmcall_exit_reason to distinguish it from the KVM 
hypercall.
+        */
+       u64 tdvmcall_exit_reason;
+
         enum vcpu_tdx_state state;

         u64 map_gpa_next;
