Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD92D617
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779770355; cv=none; b=RRGorLZ5xl8QzZiW/0n1nxnL2vGf8J/ovls3wF2A9ofqLd/AaafiJ0jynB4CLcPO466HB1B/ySAWpm9ONx4Pw4RIMP0wPMnXbR5Upcf5AIp3KFvl8Tkn4ppwXyeIyYqRq5+PEQyUWJ6KBewzbWVtPt1OrAx1oes4fvmBGaStSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779770355; c=relaxed/simple;
	bh=IWkdcpZwkbkvUQQuITBrIHdmWL8FQ6KyCf0guN6A+Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF97UxHKIULxfhySDqTqlAQGg8RvO9IsZgYI56lOE5d6JsikYvR9v2WpJ0Owwkzv8TP9D1weKL/ak1PQ+d+0wJWcirykVsYaVPX1fA4Cjj4iPOIcJ12qp9oBMAOLjCKljU5W3XsU5bmFN3vgq+PQh2dajnwmHOfYW8Y4vd7Wtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC7UIWyK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC7UIWyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779770354; x=1811306354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IWkdcpZwkbkvUQQuITBrIHdmWL8FQ6KyCf0guN6A+Ck=;
  b=iC7UIWyKx/ujJaBP1q9kKxUevLpsXjtmdJvqmhiyOt+6yNGgV9zUED42
   S/froE7qFlH044WK/ZMRzTGoxVXgKAIOOb7gmcoLuEjbA3ngQDSmIWpqA
   1VISMkluPWZ19/NTHRd8lyZ3kgivWdnKUy5xBehiHTJZFu+4KVagNmo1Y
   WKo2KfnTNHuZhs39uRiyNLo1cPAI9fSgLwqoUyXBxQA3QK6pIGSyzHiTj
   K94QS5pPt7BMvGz8EhxvALhZ9ZZFqzgh3iznT0EvwXnt+bIet6i+KQrOk
   5EHGzEAzebVGPMGb/yeZOQnz44QDZEwZioZMw487Bx4cqfG3vglEVo7LS
   w==;
X-CSE-ConnectionGUID: Bc6KrQRYTfSu9hnD+rEHdQ==
X-CSE-MsgGUID: Mf0fThPuTl6GNVVxdAbrWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84201032"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="84201032"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 21:39:13 -0700
X-CSE-ConnectionGUID: kabI2CP8RZm6tHCiUvxVZw==
X-CSE-MsgGUID: 51zsWnPWQeOnufRWjYsbFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="241855784"
Received: from unknown (HELO [10.239.158.26]) ([10.239.158.26])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 21:39:12 -0700
Message-ID: <a5ac59f9-7215-4345-b67e-6a850a98cab0@intel.com>
Date: Tue, 26 May 2026 12:39:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 1/4] nVMX: Remove the IA32_DEBUGCTLMSR
 access in debugctls test
To: Chenyi Qiang <chenyi.qiang@intel.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-2-chenyi.qiang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260526031704.109102-2-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
> "debug controls" test was added by commit dc5c01f17b1a ("VMX: Test
> behavior on set and cleared save/load debug controls") to verify that
> "VM-Entry load debug controls" and "VM-Exit save debug controls" are
> correctly emulated by KVM for nested VMX. But due to the limitation that
> KVM didn't support MSR_IA32_DEBUGCTL for guest at that time, the test
> commented out all the value comparison of MSR_IA32_DEBUGCTL and leave
> it to future when KVM supports the MSR.
> 
> The test doesn't check the functionality of save/restore guest
> MSR_IA32_DEBUGCTL on vm-exit/entry, but it keeps the write of
> MSR_IA32_DEBUGCTL. It leads to
> 
>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x407de7 Unhandled WRMSR(0x1d9) = 0x1
>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x0 Unhandled WRMSR(0x1d9) = 0x2
>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40936f Unhandled WRMSR(0x1d9) = 0x3
>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40cf09 Unhandled WRMSR(0x1d9) = 0x1
>    kvm_intel: kvm [18663]: vcpu0, guest rIP: 0x40940d Unhandled WRMSR(0x1d9) = 0x3
> 
> to the kernel log. Though it doesn't break the test, the log confuses
> people to think something wrong happened in the test case.
> 
> Current KVM doesn't support some bits of MSR_IA32_DEBUGCTL but they

This sentence doesn't read right because my version used "does support", 
not "doesn't support".

> depend on the vcpu model exposed. To simplify the case and eliminate
> the confusing "Unhandled WRMSR(0x1d9)" log, remove the MSR_IA32_DEBUGCTL
> logic in the test and make it concentrate only on DR7. Following patch
> will bring back MSR_IA32_DEBUGCTL separately.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> ---
> Changes in v2:
>    - Rewrite of commit message by Xiaoyao.
>    - Add RB from Xiaoyao.
> ---
>   x86/vmx_tests.c | 46 ++++++++++++++--------------------------------
>   1 file changed, 14 insertions(+), 32 deletions(-)
> 
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index ff387ded..91f417c6 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -1856,21 +1856,18 @@ static int nmi_hlt_exit_handler(union exit_reason exit_reason)
>   }
>   
>   
> -static int dbgctls_init(struct vmcs *vmcs)
> +static int dbgctls_dr7_init(struct vmcs *vmcs)
>   {
>   	u64 dr7 = 0x402;
>   	u64 zero = 0;
>   
> -	msr_bmp_init();
>   	asm volatile(
>   		"mov %0,%%dr0\n\t"
>   		"mov %0,%%dr1\n\t"
>   		"mov %0,%%dr2\n\t"
>   		"mov %1,%%dr7\n\t"
>   		: : "r" (zero), "r" (dr7));
> -	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x1);
>   	vmcs_write(GUEST_DR7, 0x404);
> -	vmcs_write(GUEST_DEBUGCTL, 0x2);
>   
>   	vmcs_write(ENT_CONTROLS, vmcs_read(ENT_CONTROLS) | ENT_LOAD_DBGCTLS);
>   	vmcs_write(EXI_CONTROLS, vmcs_read(EXI_CONTROLS) | EXI_SAVE_DBGCTLS);
> @@ -1878,23 +1875,19 @@ static int dbgctls_init(struct vmcs *vmcs)
>   	return VMX_TEST_START;
>   }
>   
> -static void dbgctls_main(void)
> +static void dbgctls_dr7_main(void)
>   {
> -	u64 dr7, debugctl;
> +	u64 dr7;
>   
>   	asm volatile("mov %%dr7,%0" : "=r" (dr7));
> -	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> -	/* Commented out: KVM does not support DEBUGCTL so far */
> -	(void)debugctl;
> -	report(dr7 == 0x404, "Load debug controls" /* && debugctl == 0x2 */);
> +	report(dr7 == 0x404, "DR7: Load debug controls");
>   
>   	dr7 = 0x408;
>   	asm volatile("mov %0,%%dr7" : : "r" (dr7));
> -	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x3);
>   
>   	vmx_set_test_stage(0);
>   	vmcall();
> -	report(vmx_get_test_stage() == 1, "Save debug controls");
> +	report(vmx_get_test_stage() == 1, "DR7: Save debug controls");
>   
>   	if (ctrl_enter_rev.set & ENT_LOAD_DBGCTLS ||
>   	    ctrl_exit_rev.set & EXI_SAVE_DBGCTLS) {
> @@ -1905,46 +1898,37 @@ static void dbgctls_main(void)
>   	vmcall();
>   
>   	asm volatile("mov %%dr7,%0" : "=r" (dr7));
> -	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> -	/* Commented out: KVM does not support DEBUGCTL so far */
> -	(void)debugctl;
>   	report(dr7 == 0x402,
> -	       "Guest=host debug controls" /* && debugctl == 0x1 */);
> +	       "DR7: Guest=host debug controls");
>   
>   	dr7 = 0x408;
>   	asm volatile("mov %0,%%dr7" : : "r" (dr7));
> -	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x3);
>   
>   	vmx_set_test_stage(3);
>   	vmcall();
> -	report(vmx_get_test_stage() == 4, "Don't save debug controls");
> +	report(vmx_get_test_stage() == 4, "DR7: Don't save debug controls");
>   }
>   
> -static int dbgctls_exit_handler(union exit_reason exit_reason)
> +static int dbgctls_dr7_exit_handler(union exit_reason exit_reason)
>   {
>   	u32 insn_len = vmcs_read(EXI_INST_LEN);
>   	u64 guest_rip = vmcs_read(GUEST_RIP);
> -	u64 dr7, debugctl;
> +	u64 dr7;
>   
>   	asm volatile("mov %%dr7,%0" : "=r" (dr7));
> -	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
>   
>   	switch (exit_reason.basic) {
>   	case VMX_VMCALL:
>   		switch (vmx_get_test_stage()) {
>   		case 0:
> -			if (dr7 == 0x400 && debugctl == 0 &&
> -			    vmcs_read(GUEST_DR7) == 0x408 /* &&
> -			    Commented out: KVM does not support DEBUGCTL so far
> -			    vmcs_read(GUEST_DEBUGCTL) == 0x3 */)
> +			if (dr7 == 0x400 &&
> +			    vmcs_read(GUEST_DR7) == 0x408)
>   				vmx_inc_test_stage();
>   			break;
>   		case 2:
>   			dr7 = 0x402;
>   			asm volatile("mov %0,%%dr7" : : "r" (dr7));
> -			wrmsr(MSR_IA32_DEBUGCTLMSR, 0x1);
>   			vmcs_write(GUEST_DR7, 0x404);
> -			vmcs_write(GUEST_DEBUGCTL, 0x2);
>   
>   			vmcs_write(ENT_CONTROLS,
>   				vmcs_read(ENT_CONTROLS) & ~ENT_LOAD_DBGCTLS);
> @@ -1952,10 +1936,8 @@ static int dbgctls_exit_handler(union exit_reason exit_reason)
>   				vmcs_read(EXI_CONTROLS) & ~EXI_SAVE_DBGCTLS);
>   			break;
>   		case 3:
> -			if (dr7 == 0x400 && debugctl == 0 &&
> -			    vmcs_read(GUEST_DR7) == 0x404 /* &&
> -			    Commented out: KVM does not support DEBUGCTL so far
> -			    vmcs_read(GUEST_DEBUGCTL) == 0x2 */)
> +			if (dr7 == 0x400 &&
> +			    vmcs_read(GUEST_DR7) == 0x404)
>   				vmx_inc_test_stage();
>   			break;
>   		}
> @@ -11780,7 +11762,7 @@ struct vmx_test vmx_tests[] = {
>   		interrupt_exit_handler, NULL, {0} },
>   	{ "nmi_hlt", nmi_hlt_init, nmi_hlt_main,
>   		nmi_hlt_exit_handler, NULL, {0} },
> -	{ "debug controls", dbgctls_init, dbgctls_main, dbgctls_exit_handler,
> +	{ "debug controls dr7", dbgctls_dr7_init, dbgctls_dr7_main, dbgctls_dr7_exit_handler,
>   		NULL, {0} },
>   	{ "MSR switch", msr_switch_init, msr_switch_main,
>   		msr_switch_exit_handler, NULL, {0}, msr_switch_entry_failure },

