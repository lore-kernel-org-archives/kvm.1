Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7A3EBF07
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798730; cv=none; b=icL89gKboWgJ4OpoxbU3mjErBS8axgSD/2zn83rIFvL9qnWcs77vptcO+sdfkcucgNRg3qbX9X1n2pKhtq/uzVazQJELl49c4ekdx7G1IoogqtMI6xDZSgWaOLjLbt3Vyx2la/ObbFiftYTrnpXgtPckAPC/cGKceE2KyGWmP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798730; c=relaxed/simple;
	bh=o0zmR0o/j+9yDEnZtEcENTS9Le/e88/UMK9ho5DPMoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mnj0Q570DvFyM2ePWivP12diFE/VVwg0rwW0Ft78qXOMMkbOiGZ7tLFZ7wkfi2ujIiqHGQmKt9VTOVje9WIZMZ5nByTFWS3clbZruHS5THBqd5Ev3ke+38DN8XuZ+StreMfkNnHIVUXiyVVkPIi504wQZblCHxiWpDUpCo7bbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPJvLAvJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPJvLAvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779798729; x=1811334729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o0zmR0o/j+9yDEnZtEcENTS9Le/e88/UMK9ho5DPMoA=;
  b=fPJvLAvJ7pUjsrZViGF974j78A/yea1xlR+3A3B4x0wPfvF3BJh6hVrI
   7Y5WOuVUChkjG4O3zt3f7z+F8XXrurvuj0WJuO+Wc+41W8IHLyhDM1iwS
   XK0IlcCT3tdBuInZIma7DjPDdhFH8vxR925J15KrAOL67FiQTzmK9JT9G
   fCRYRGqgJG3240Ok9jgoraDR4/JYGFcVZdJ24qAbeiNV7+vyNPrDICbEp
   kZDxC3QpmrA/QC8djnCBVx3TJ5yg3WQl7NmTfHa1hZHB5AQr9ajzsH8gN
   84ITICbGqDJ8AWHCF1J19p25IvdtadRD3gE/QkNDgBQP72AQmFCyitAUy
   g==;
X-CSE-ConnectionGUID: L8k7cxguRVms7olZViou8A==
X-CSE-MsgGUID: 71Sqb+WnQyCSQIyYRAwiiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91178846"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="91178846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:32:08 -0700
X-CSE-ConnectionGUID: qaz+tZuBQR2qf7Y01XimDA==
X-CSE-MsgGUID: gA0VBQC8THOMT4Pw/VPyzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="265770263"
Received: from unknown (HELO [10.239.158.26]) ([10.239.158.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 05:32:06 -0700
Message-ID: <a479bef3-f24a-458d-ab90-3216712e1fcb@intel.com>
Date: Tue, 26 May 2026 20:32:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 2/4] nVMX: Validate
 DEBUGCTLMSR_BUS_LOCK_DETECT states during VMX transitions
To: Chenyi Qiang <chenyi.qiang@intel.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-3-chenyi.qiang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260526031704.109102-3-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
> Add tests to verify that DEBUGCTLMSR_BUS_LOCK_DETECT state is correctly
> handled during VMX transitions.
> 
> Wrap the VM-entry/VM-exit DEBUGCTL transition flow into a shared helper so
> follow-up DEBUGCTL feature tests can reuse the same checks.
> 
> The following behaviors are verified in the helper:
> 
> 1. Guest states are loaded from VMCS iff "Load debug controls" VM-Entry control is set.
> 2. Guest states are saved to VMCS iff "Save debug controls" VM-Exit control is set.
> 3. DEBUGCTL MSR is cleared after VM exits.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

Though some nits below, the functionality looks good to me.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   lib/x86/msr.h     |  1 +
>   x86/unittests.cfg |  8 ++++
>   x86/vmx_tests.c   | 96 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 105 insertions(+)
> 
> diff --git a/lib/x86/msr.h b/lib/x86/msr.h
> index 7397809c..da75740d 100644
> --- a/lib/x86/msr.h
> +++ b/lib/x86/msr.h
> @@ -103,6 +103,7 @@
>   /* DEBUGCTLMSR bits (others vary by model): */
>   #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
>   #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
> +#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
>   #define DEBUGCTLMSR_TR			(1UL <<  6)
>   #define DEBUGCTLMSR_BTS			(1UL <<  7)
>   #define DEBUGCTLMSR_BTINT		(1UL <<  8)
> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> index 48835eba..c8426770 100644
> --- a/x86/unittests.cfg
> +++ b/x86/unittests.cfg
> @@ -471,6 +471,14 @@ arch = x86_64
>   groups = vmx
>   timeout = 240
>   
> +[vmx_bus_lock_detect_test]
> +file = vmx.flat
> +test_args = "vmx_bus_lock_detect_test"
> +qemu_params = -cpu max,+vmx
> +arch = x86_64
> +groups = vmx
> +timeout = 240
> +
>   [debug]
>   file = debug.flat
>   arch = x86_64
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 91f417c6..a3e52d3b 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -11737,6 +11737,100 @@ static void vmx_cet_test(void)
>   	test_set_guest_finished();
>   }
>   
> +static struct vmx_debugctl_test_data {
> +	u64 mask;
> +	u64 guest_debugctl;
> +} vmx_debugctl_test_data;
> +
> +static void vmx_debugctl_test_guest(void)
> +{
> +	vmx_debugctl_test_data.guest_debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +	vmcall();
> +
> +	wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data.mask);
> +	vmcall();
> +
> +	vmx_debugctl_test_data.guest_debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +	vmcall();
> +
> +	wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_data.mask);
> +	vmcall();
> +}
> +
> +static void vmx_debugctl_transition_test(const char *label, u64 mask)
> +{
> +	u64 debugctl;
> +
> +	vmx_debugctl_test_data.mask = mask;
> +
> +	msr_bmp_init();
> +	wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
> +	vmcs_write(GUEST_DEBUGCTL, 0x0);
> +
> +	/* Validate when save/load debug controls are set */
> +	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
> +	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
> +
> +	test_set_guest(vmx_debugctl_test_guest);
> +
> +	enter_guest();
> +	skip_exit_vmcall();
> +	/* Validate VM-entry loads the guest DEBUGCTL value from GUEST_DEBUGCTL. */
> +	report(vmx_debugctl_test_data.guest_debugctl == 0x0,
> +	       "%s: Load debug controls", label);
> +
> +	enter_guest();
> +	skip_exit_vmcall();
> +	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +	/* Validate VM-exit clears host DEBUGCTL and saves guest DEBUGCTL into the VMCS. */
> +	report(debugctl == 0x0 && vmcs_read(GUEST_DEBUGCTL) == mask,
> +	       "%s: Save debug controls", label);
> +
> +	if (ctrl_enter_rev.set & ENT_LOAD_DBGCTLS ||
> +	    ctrl_exit_rev.set & EXI_SAVE_DBGCTLS) {
> +		printf("\tDebug controls are always loaded/saved\n");
> +		test_set_guest_finished();
> +		return;
> +	}
> +
> +	wrmsr(MSR_IA32_DEBUGCTLMSR, mask);
> +	vmcs_write(GUEST_DEBUGCTL, 0x0);
> +	/* Validate when save/load debug controls are clear */
> +	vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
> +	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
> +
> +	enter_guest();
> +	skip_exit_vmcall();
> +	/* Validate guest observes the host's DEBUGCTL value. */
> +	report(vmx_debugctl_test_data.guest_debugctl == mask,
> +	       "%s: Guest=host debug controls", label);
> +
> +	wrmsr(MSR_IA32_DEBUGCTLMSR, 0x0);
> +	vmcs_write(GUEST_DEBUGCTL, 0x0);
> +
> +	enter_guest();
> +	skip_exit_vmcall();
> +	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +	/* Validate VM-exit clears host DEBUGCTL and does not save guest DEBUGCTL into the VMCS. */
> +	report(debugctl == 0x0 && vmcs_read(GUEST_DEBUGCTL) == 0x0,
> +	       "%s: Don't save debug controls", label);
> +
> +	enter_guest();
> +}
> +
> +static void vmx_bus_lock_detect_test(void)

the name reads ambiguous to me.

how about debug_controls_debugctrlmsr_bus_lock_detect_test? hmm, seems 
too lengthy

> +{
> +

unnecessary new line.

> +	if (!this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
> +		report_skip("%s : \"Bus Lock Detect\" not supported", __func__);
> +		return;
> +	}
> +
> +	vmx_debugctl_transition_test("DEBUGCTLMSR.BUS_LOCK_DETECT",
> +					 DEBUGCTLMSR_BUS_LOCK_DETECT);
> +	report_pass(__func__);
> +}
> +
>   #define TEST(name) { #name, .v2 = name }
>   
>   /* name/init/guest_main/exit_handler/syscall_handler/guest_regs */
> @@ -11858,5 +11952,7 @@ struct vmx_test vmx_tests[] = {
>   	TEST(vmx_canonical_test),
>   	/* "Load CET" VM-entry/exit controls tests. */
>   	TEST(vmx_cet_test),
> +	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_BUS_LOCK_DETECT */
> +	TEST(vmx_bus_lock_detect_test),
>   	{ NULL, NULL, NULL, NULL, NULL, {0} },
>   };

