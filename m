Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DD27B50F
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227533; cv=none; b=eJ1LACTwbD1oEAnm1aKZ7V6i0kNfNfw/xqlH0noi4Q28P22wQnvghfOKZz3zdW0i4L16rIwOP5lT3YGSPPc/cL5Fyr4Lqk9dgv/w6bunBn+H3H4+IVjFa/54bRAsmHf1kqVc6PdyuWqTBU+zO0QSzYJXZqUF+bzh8NZVSHJ6X/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227533; c=relaxed/simple;
	bh=z9jr7Oyp2qL0w4wDi0rKxXqkMhaJDB3+Zkx7SBwks2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR6cuRDDNAAx58/pxdcZejMNPK40+Bntj5+crH3TiKHTgnEVubRUrHwpR1jYV+Leo/fnVqCFEAZ1veTLzxp7rrq/evEAB+T5auxayOBix0HdAoNbluB72hKJubzA10rBDZecNC60VoMLFEPDGNqao8OVVuqgCDXnvF9JpjA5PH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=tzd1Z7Zi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="tzd1Z7Zi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e7c636e74so1924471f8f.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779227530; x=1779832330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bRW+xglLCV78m7WHmapNpRo89YKaitY1DzApVr60AJA=;
        b=tzd1Z7ZiOBpR/Z1uxyH8r8zyAUOtZs+7gke8G3e2/0TwkJMWEpvcDF3Ve4qHssZ42Z
         jL9aOas1ovuQkVbKLYmGd2hBptQ2QsdgbDEi5KcJuZ1D89A28uEu5NrDfTcVlIt1Gcfr
         eawEch1sZtTpa0B8/bSmGWrbfpslPxC8eev7YAvUtjgyQxhvctdUV4sSpvBYlLQUmBcx
         i9iRXTGGEpwvduDzOwVovDubxxJhH64aL0sRN2a1VinPOA4AhBBAWNxh2eHiMTj9ecTr
         ZLRRz8YvoJZZSsbB0ZrRVMNsZKDBq03f4j2kdr47rjPnihXbygT+fatTPF9RaSzvATwv
         I05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227530; x=1779832330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRW+xglLCV78m7WHmapNpRo89YKaitY1DzApVr60AJA=;
        b=GPjbXSEIHj9VPTZVluRZ1ZTHqG4y24M7tuXc12rz79SWs8mPBfyc7QmUzt62p+Nc9q
         Y8sYb82Vk9v1ol+8uHdEFb1/ZULvw6yax9aXBmvtScC5zZub3Th6BvPHxSVd4iW46bDH
         sB9jZA1RxTQbXN1eHZf4VjNTa/iFzZfYvIdFYa8Aadk5WyFIccECpdFyRO7UkQ3NrmMP
         JiPmaKGGdXusKQyW2pFcfpcbp4gSqeAOh1ZCZzJx7FjqvYpGnctBZAid3XtRJjmiS0xx
         uusBJ34uk7/uksy5xdezl+2hr7Lb+zhwusFfWUUUJy7zcKdNC/Vt3MPFjgvoVtVbUhH7
         b4fQ==
X-Gm-Message-State: AOJu0YxXDwlyw668X+b156vKYyhu0PP0fW+bTgPckxQxVTipJX+Sc/dj
	cv2iqbzfzoQfdCWJQ3AhBMPMp03R8dKNLctZjxqIL19FK6LptzSSW87l3cr9/Ta7/NqtW0zEPDu
	dxcZi
X-Gm-Gg: Acq92OEWlCbHKLiV7r+sbVLMdmkiRepbnItHrxN8jraqi889H/aQNco6ogSZ7Q6QaNW
	kILQq7nMDYqXveObeP9rvhUD7a8Uq0fwwtHQWs7ni62oOu5eceT+Cpg7RqMctcCNL1G0xjDKgt7
	woxjmRuvLlsChoGF0B6mq16ti3irxAEVFKQ53/d05J1kV77jz62tGqYK54LZ+r2eZcJOjj+SrLa
	ziWz+KqXJu4c+1kelHzgtDMYjir2SVlQO4tKo/DCTJHl/pOKzXf9Qbm1K/S9nVJQUqP6TLNb/wj
	8qsgylS0EcUvX/BgbKAiOtHN1x/47a9iQ5e64X0Z3zGXEeQ8e/Cvc8FOCaUTTL458lFr66a/DUA
	qde3eAvKkNX1BcC0jn/GmSKg45pDGAK1YUs3CTAmOAEhf2ncx5CafA3tpqezQmV9tNfSmqGHeod
	PPstWGpPxuWzJLoEJKra4WkEntkG9bSnc+HQ6ZrzITctYanP2yyQ/zUxKSQzzRScW0TBwliBOkn
	tWkSWW5S2E2eCp4jLzutFEHyOMfjVXCbhvT0BT5JvhqJSGxox1aUY9o
X-Received: by 2002:a05:6000:2405:b0:43b:3e40:2223 with SMTP id ffacd0b85a97d-45e5c5b9673mr34963337f8f.19.1779227529431;
        Tue, 19 May 2026 14:52:09 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm45423710f8f.15.2026.05.19.14.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 14:52:08 -0700 (PDT)
Message-ID: <063cda25-9e48-4874-91f9-00797aa76d59@grsecurity.net>
Date: Tue, 19 May 2026 23:52:08 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 06/20] x86/virt: Track "guest regs"
 using per-CPU variable
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
 <20260514210500.1626871-7-seanjc@google.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20260514210500.1626871-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.05.26 23:04, Sean Christopherson wrote:
> Make the guest_regs structure used to context switch registers between
> host and guest per-CPU to fix a bug where VMX tests that run multiple
> vCPUs can fail due to register corruption, e.g. two CPUs enter the guest
> in quick succession, only one of the CPU's registers will be preserved
> across VM-Enter => VM-Exit.
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Closes: https://lore.kernel.org/all/3bac29b9-4c49-4e5d-997e-9e4019a2fceb@grsecurity.net
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  lib/x86/smp.h   | 25 +++++++++++++++++++++++++
>  lib/x86/virt.h  | 35 ++++++++---------------------------
>  x86/svm.c       | 14 +++++---------
>  x86/svm.h       |  1 -
>  x86/svm_tests.c |  5 +++--
>  x86/vmx.c       | 19 +++++++++++--------
>  x86/vmx_tests.c | 39 +++++++++++++++++++++++++--------------
>  7 files changed, 77 insertions(+), 61 deletions(-)
> 
> diff --git a/lib/x86/smp.h b/lib/x86/smp.h
> index 272aa5ee..e4dc0395 100644
> --- a/lib/x86/smp.h
> +++ b/lib/x86/smp.h
> @@ -20,6 +20,30 @@
>  #include "atomic.h"
>  #include "apic-defs.h"
>  
> +struct guest_regs {
> +	u64 rax;
> +	u64 rcx;
> +	u64 rdx;
> +	u64 rbx;
> +	/*

> +	 * Use RSP's index to hold CR3, as RSP isn't manually context switched
> +	 * by software in any relevant flows.
> +	 */
> +	u64 cr2;

Similar comment as for 4/20. But as there seem to be no user of this
slot, it probably doesn't matter all that much.

> +	u64 rbp;
> +	u64 rsi;
> +	u64 rdi;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +	u64 r12;
> +	u64 r13;
> +	u64 r14;
> +	u64 r15;
> +	u64 rflags;
> +};
> +
>  /* Offsets into the per-cpu page. */
>  struct percpu_data {
>  	uint32_t  smp_id;
> @@ -32,6 +56,7 @@ struct percpu_data {
>  		uint32_t exception_data;
>  	};
>  	void *apic_ops;
> +	struct guest_regs guest_regs;
>  };
>  
>  #define typeof_percpu(name) typeof(((struct percpu_data *)0)->name)
> diff --git a/lib/x86/virt.h b/lib/x86/virt.h
> index 1066390d..d05d4fc6 100644
> --- a/lib/x86/virt.h
> +++ b/lib/x86/virt.h
> @@ -2,35 +2,16 @@
>  #define _x86_VIRT_H_
>  
>  #include "libcflat.h"
> +#include "processor.h"
> +#include "smp.h"
>  
> -struct guest_regs {
> -	u64 rax;
> -	u64 rcx;
> -	u64 rdx;
> -	u64 rbx;
> -	/*
> -	 * Use RSP's index to hold CR3, as RSP isn't manually context switched
> -	 * by software in any relevant flows.
> -	 */
> -	u64 cr2;
> -	u64 rbp;
> -	u64 rsi;
> -	u64 rdi;
> -	u64 r8;
> -	u64 r9;
> -	u64 r10;
> -	u64 r11;
> -	u64 r12;
> -	u64 r13;
> -	u64 r14;
> -	u64 r15;
> -	u64 rflags;
> -};
> -
> -extern struct guest_regs regs;
> +static inline struct guest_regs *this_cpu_guest_regs(void)
> +{
> +	return (void *)rdmsr(MSR_GS_BASE) + offsetof_percpu(guest_regs);
> +}
>  
>  #define GUEST_REG_OFFSET(name) \
> -	[off_##name] "i" (offsetof(struct guest_regs, name))
> +	[off_##name] "i" (offsetof_percpu(guest_regs) + offsetof(struct guest_regs, name))
>  
>  #define GUEST_REGS_OFFSETS	\
>  	GUEST_REG_OFFSET(rax),	\
> @@ -52,7 +33,7 @@ extern struct guest_regs regs;
>  	GUEST_REG_OFFSET(rflags)
>  
>  #define GUEST_REG(name) \
> -	xxstr(regs+%c[off_##name])
> +	xxstr(%%gs:%c[off_##name])
>  
>  #define SWAP_REG(name) \
>  	"xchg %%" xxstr(name) "," GUEST_REG(name) "\n\t"
> diff --git a/x86/svm.c b/x86/svm.c
> index 1762cadb..beb57f33 100644
> --- a/x86/svm.c
> +++ b/x86/svm.c
> @@ -223,13 +223,6 @@ void vmcb_ident(struct vmcb *vmcb)
>  	}
>  }
>  
> -struct guest_regs regs;
> -
> -struct guest_regs get_regs(void)
> -{
> -	return regs;
> -}
> -
>  // rax handled specially below
>  
>  
> @@ -246,8 +239,10 @@ void svm_setup_vmrun(u64 rip)
>  
>  u64 __svm_vmrun(u64 rip)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>  	svm_setup_vmrun(rip);
> -	regs.rdi = (ulong)v2_test;
> +	regs->rdi = (ulong)v2_test;
>  
>  	asm volatile (
>  		      ASM_PRE_VMRUN_CMD
> @@ -269,6 +264,7 @@ extern u8 vmrun_rip;
>  
>  static noinline void test_run(struct svm_test *test)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  	u64 vmcb_phys = virt_to_phys(vmcb);
>  
>  	cli();
> @@ -278,7 +274,7 @@ static noinline void test_run(struct svm_test *test)
>  	guest_main = test->guest_func;
>  	vmcb->save.rip = (ulong)test_thunk;
>  	vmcb->save.rsp = (ulong)(guest_stack + ARRAY_SIZE(guest_stack));
> -	regs.rdi = (ulong)test;
> +	regs->rdi = (ulong)test;
>  	do {
>  		struct svm_test *the_test = test;
>  		u64 the_vmcb = vmcb_phys;
> diff --git a/x86/svm.h b/x86/svm.h
> index 67a1cddd..4e7e9e7a 100644
> --- a/x86/svm.h
> +++ b/x86/svm.h
> @@ -416,7 +416,6 @@ int get_test_stage(struct svm_test *test);
>  void set_test_stage(struct svm_test *test, int s);
>  void inc_test_stage(struct svm_test *test);
>  void vmcb_ident(struct vmcb *vmcb);
> -struct guest_regs get_regs(void);
>  void vmmcall(void);
>  void svm_setup_vmrun(u64 rip);
>  u64 __svm_vmrun(u64 rip);
> diff --git a/x86/svm_tests.c b/x86/svm_tests.c
> index 8ce3cc2e..8547e729 100644
> --- a/x86/svm_tests.c
> +++ b/x86/svm_tests.c
> @@ -577,6 +577,7 @@ static void restore_msrpm_bit(int bit_nr, bool set)
>  
>  static bool msr_intercept_finished(struct svm_test *test)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  	u32 exit_code = vmcb->control.exit_code;
>  	bool all_set = false;
>  	int bit_nr;
> @@ -649,9 +650,9 @@ static bool msr_intercept_finished(struct svm_test *test)
>  	 *      while RAX hold its lower 32 bits.
>  	 */
>  	if (vmcb->control.exit_info_1)
> -		test->scratch = ((get_regs().rdx << 32) | (vmcb->save.rax & 0xffffffff));
> +		test->scratch = ((regs->rdx << 32) | (vmcb->save.rax & 0xffffffff));
>  	else
> -		test->scratch = get_regs().rcx;
> +		test->scratch = regs->rcx;
>  
>  	return false;
>  }
> diff --git a/x86/vmx.c b/x86/vmx.c
> index 8a38ae8a..4cb8d66c 100644
> --- a/x86/vmx.c
> +++ b/x86/vmx.c
> @@ -44,7 +44,6 @@ struct vmcs *vmcs_root;
>  u32 vpid_cnt;
>  u64 guest_stack_top;
>  u32 ctrl_pin, ctrl_enter, ctrl_exit, ctrl_cpu[2];
> -struct guest_regs regs;
>  
>  struct vmx_test *current;
>  
> @@ -632,6 +631,8 @@ const char *exit_reason_description(u64 reason)
>  
>  void print_vmexit_info(union exit_reason exit_reason)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +
>  	u64 guest_rip, guest_rsp;
>  	ulong exit_qual = vmcs_read(EXI_QUALIFICATION);
>  	guest_rip = vmcs_read(GUEST_RIP);
> @@ -642,13 +643,13 @@ void print_vmexit_info(union exit_reason exit_reason)
>  	printf("\texit qualification = %#lx\n", exit_qual);
>  	printf("\tguest_rip = %#lx\n", guest_rip);
>  	printf("\tRAX=%#lx    RBX=%#lx    RCX=%#lx    RDX=%#lx\n",
> -		regs.rax, regs.rbx, regs.rcx, regs.rdx);
> +		regs->rax, regs->rbx, regs->rcx, regs->rdx);
>  	printf("\tRSP=%#lx    RBP=%#lx    RSI=%#lx    RDI=%#lx\n",
> -		guest_rsp, regs.rbp, regs.rsi, regs.rdi);
> +		guest_rsp, regs->rbp, regs->rsi, regs->rdi);
>  	printf("\tR8 =%#lx    R9 =%#lx    R10=%#lx    R11=%#lx\n",
> -		regs.r8, regs.r9, regs.r10, regs.r11);
> +		regs->r8, regs->r9, regs->r10, regs->r11);
>  	printf("\tR12=%#lx    R13=%#lx    R14=%#lx    R15=%#lx\n",
> -		regs.r12, regs.r13, regs.r14, regs.r15);
> +		regs->r12, regs->r13, regs->r14, regs->r15);
>  }
>  
>  void print_vmentry_failure_info(struct vmentry_result *result)
> @@ -1707,15 +1708,16 @@ void test_skip(const char *msg)
>  
>  static int exit_handler(union exit_reason exit_reason)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  	int ret;
>  
>  	current->exits++;
> -	regs.rflags = vmcs_read(GUEST_RFLAGS);
> +	regs->rflags = vmcs_read(GUEST_RFLAGS);
>  	if (is_hypercall(exit_reason))
>  		ret = handle_hypercall();
>  	else
>  		ret = current->exit_handler(exit_reason);
> -	vmcs_write(GUEST_RFLAGS, regs.rflags);
> +	vmcs_write(GUEST_RFLAGS, regs->rflags);
>  
>  	return ret;
>  }
> @@ -1815,6 +1817,7 @@ static void run_teardown_step(struct test_teardown_step *step)
>  
>  static int test_run(struct vmx_test *test)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  	int r;
>  
>  	/* Validate V2 interface. */
> @@ -1835,7 +1838,7 @@ static int test_run(struct vmx_test *test)
>  		return 1;
>  	}
>  
> -	memset(&regs, 0, sizeof(regs));
> +	memset(regs, 0, sizeof(regs));

memset(regs, 0, sizeof(*regs));

>  	init_vmcs(&(test->vmcs));
>  	/* Directly call test->init is ok here, init_vmcs has done
>  	   vmcs init, vmclear and vmptrld*/
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index e0d5e390..e2bf06ac 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -102,15 +102,16 @@ static void vmenter_main(void)
>  
>  static int vmenter_exit_handler(union exit_reason exit_reason)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  	u64 guest_rip = vmcs_read(GUEST_RIP);
>  
>  	switch (exit_reason.basic) {
>  	case VMX_VMCALL:
> -		if (regs.rax != 0xABCD) {
> +		if (regs->rax != 0xABCD) {
>  			report_fail("test vmresume");
>  			return VMX_TEST_VMEXIT;
>  		}
> -		regs.rax = 0xFFFF;
> +		regs->rax = 0xFFFF;
>  		vmcs_write(GUEST_RIP, guest_rip + 3);
>  		return VMX_TEST_RESUME;
>  	default:
> @@ -10196,6 +10197,7 @@ static void vmx_sipi_test_guest(void)
>  
>  static void sipi_test_ap_thread(void *data)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  	struct vmcs *ap_vmcs;
>  	u64 *ap_vmxon_region;
>  	void *ap_stack, *ap_syscall_stack;
> @@ -10210,6 +10212,8 @@ static void sipi_test_ap_thread(void *data)
>  	init_vmcs(&ap_vmcs);
>  	make_vmcs_current(ap_vmcs);
>  
> +	memset(regs, 0, sizeof(regs));
> +
>  	/* Set stack for AP */
>  	ap_stack = alloc_page();
>  	ap_syscall_stack = alloc_page();
> @@ -10652,10 +10656,11 @@ static unsigned long long host_time_to_guest_time(unsigned long long t)
>  static unsigned long long rdtsc_vmexit_diff_test_iteration(void)
>  {
>  	unsigned long long guest_tsc, host_to_guest_tsc;
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  
>  	enter_guest();
>  	skip_exit_vmcall();
> -	guest_tsc = (u32) regs.rax + (regs.rdx << 32);
> +	guest_tsc = (u32) regs->rax + (regs->rdx << 32);
>  	host_to_guest_tsc = host_time_to_guest_time(exit_msr_store[0].value);
>  
>  	return host_to_guest_tsc - guest_tsc;
> @@ -10881,6 +10886,7 @@ typedef void (*pf_exception_test_guest_t)(void);
>  static void __vmx_pf_exception_test(invalidate_tlb_t inv_fn, void *data,
>  				    pf_exception_test_guest_t guest_fn)
>  {
> +	struct guest_regs *regs = this_cpu_guest_regs();
>  	u64 efer;
>  	struct cpuid cpuid;
>  
> @@ -10897,23 +10903,23 @@ static void __vmx_pf_exception_test(invalidate_tlb_t inv_fn, void *data,
>  	while (vmcs_read(EXI_REASON) != VMX_VMCALL) {
>  		switch (vmcs_read(EXI_REASON)) {
>  		case VMX_RDMSR:
> -			assert(regs.rcx == MSR_EFER);
> +			assert(regs->rcx == MSR_EFER);
>  			efer = vmcs_read(GUEST_EFER);
> -			regs.rdx = efer >> 32;
> -			regs.rax = efer & 0xffffffff;
> +			regs->rdx = efer >> 32;
> +			regs->rax = efer & 0xffffffff;
>  			break;
>  		case VMX_WRMSR:
> -			assert(regs.rcx == MSR_EFER);
> -			efer = regs.rdx << 32 | (regs.rax & 0xffffffff);
> +			assert(regs->rcx == MSR_EFER);
> +			efer = regs->rdx << 32 | (regs->rax & 0xffffffff);
>  			vmcs_write(GUEST_EFER, efer);
>  			break;
>  		case VMX_CPUID:
>  			cpuid = (struct cpuid) {0, 0, 0, 0};
> -			cpuid = raw_cpuid(regs.rax, regs.rcx);
> -			regs.rax = cpuid.a;
> -			regs.rbx = cpuid.b;
> -			regs.rcx = cpuid.c;
> -			regs.rdx = cpuid.d;
> +			cpuid = raw_cpuid(regs->rax, regs->rcx);
> +			regs->rax = cpuid.a;
> +			regs->rbx = cpuid.b;
> +			regs->rcx = cpuid.c;
> +			regs->rdx = cpuid.d;
>  			break;
>  		case VMX_INVLPG:
>  			inv_fn(data);
> @@ -11250,7 +11256,12 @@ static void do_vmx_canonical_test_one_field(const char *field_name, u64 field)
>  	field_org_value = vmcs_read(field);
>  
>  	test_host_value_direct(field_name, field);
> -	test_host_value_vmcs(field_name, field);
> +	/*
> +	 * Skip the GS.base VMCS test, the VMX infrastructure accesses per-CPU
> +	 * variables (referenced via GS) immediatedly after VM-Exit.
> +	 */
> +	if (field != HOST_BASE_GS)
> +		test_host_value_vmcs(field_name, field);
>  
>  	/* Restore original values */
>  	vmcs_write(field, field_org_value);

