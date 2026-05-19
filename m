Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4127B50F
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227516; cv=none; b=KQZ5KJTr1q9rHMrrhbrDcKnr94upXaw0uTGCUZa5xcZSVaEES+94FUaZJHpcpm5b6unN8dAstISrf6fpy7r8mqZ8OlZMYwssG2+1EPNFd/0w+znIy1jlPfdHB1KCq9jUSJEleDgLPlOnwGDxPaWfckQSejEccoSLqMA9u5VW0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227516; c=relaxed/simple;
	bh=NTKTEWqYGeNHeDrY6YIUmGirX/DfUVmILAb5AIQTGac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlOhTgzqwYc/542ZPQsY/WIrF1C+M+aEESXzO79YDMQJaWyOPIHr2xkpKu8qqARGYJxjoafU/kNdmTIWw1h1wl6nHxRAEHYOxelZYeSk3Lwq0deDetDAHKggwvbiYEJuyWrGTButd4fqhyxuOnhGAO8klV/ssI2yFxmGt4LizvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=wjEyr/72; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="wjEyr/72"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so44877805e9.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779227513; x=1779832313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RDyyn+M8MIxbFjxf/o7zgAiEMZXV5nd3uXgGzFmKZ+g=;
        b=wjEyr/72h5fnxcj1mOq/gMxnArNjWwp4+eQRYKVEG63FslTlqy0baF8F8WPWu9OTEt
         P+TlsJFIZufSo4wedVmSr63KgjCMVMYZPjQ4ddWZ1icom5CJPlL4+CkziSOLrrb5iG4g
         bMpveNZua6GkbyoMtXKrRDPqbajN2NwqM4yC10jWIr0HAygG5IHMN7SBto+NRKrxcfCx
         GNIHayYOqiJISas5AEdEG/ri52Rc9ABQddQDz42Ejon7NXu2WAQAuSPAPAynm2GDAaAf
         onzYdgwgZXT8KNdT/ZPMBQ965Vu+gsFkk5CEfR4QRC3X9vZoiTSRaJN6wVOP2Cl2LYfX
         ZaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227513; x=1779832313;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDyyn+M8MIxbFjxf/o7zgAiEMZXV5nd3uXgGzFmKZ+g=;
        b=O00lHA4oWaDfH9s5mPUJDV4vb7nxUmohayiqIyF36WCuDy8LbxdQDM9zC8A+Qc9Drs
         8UGuFPPx3cMpKF4NB9teC3qkRKTcc9c7tdMu2HjPTsQ2PXNHxSpdFKGdgkl57v9QGNRG
         uvyHdAmCEM6ExUrED2Qxnr2pWqtycxX1RIZhzeauXi0pFvwOXgPwfE3VZ3PX9A/wIWYQ
         jbrL+X9mK6ixE+bDln+nLfsDo7geDemz1MIMHvLRfVKULya0vKQAW4QYORyRT5XTMGuP
         3R3BvQddlE9GmVin+bAqE6ArV9PIPJgSHjz08iEVjNGad2MHbtp0a+Dpif5beHHYp7tu
         Z+Gw==
X-Gm-Message-State: AOJu0Yx31lsjT0OuJ/RS1z+oQxyRNct9rOVSP/EUkGyv83zcQH7++dV5
	R+sSTVGCzj0oFF8IQK6LBFqq2YkonMAhyAeakGiyhrrP9t/KMCWixD6qBX/rLp4mJrc=
X-Gm-Gg: Acq92OG2b9ftbIpNyp/2Ye4pUlAN1vKZfcpQ6bNIePksnRZTWIdHgDg34OP95diWrzC
	Lt/b5SFYt7245L0lGdOtoNhcyWtbkaamm6koA8OmcGoNEdmQriAJrHl5u3+9HyT3YRQVtp0cvcv
	YofmZ4qWhtZxeRZds9v1MqoqsBTasbzqfbdO/tX87QufDKmymCfd3tVdhC1WwddW/kwMuHNf+OT
	8hipEOnboHX5UgxKHaH7LPi3iN2mEx/WN3o7QX2OWm1ycPWpH2XcyoNjEFDUXzR6y027yFSI6dy
	uzcgmsgfx5NosiL4Ozkq3n2OsE7aU3WZsz1ty7a79IUw/VsD4hyVMGTguqyyehesHHvftKrJ3GU
	Atxt1ADHv173IlU6dDRwEHNFEaYywwXvmYOErqv4ys5hkxi+ih86/fPg9qVIVlndiIlvy5qomCT
	lzK/hzV4JAsOUklyJm3GyC/lnbbwByHgwbCsSjclmr6e/0p9QzxFkS+8rpDIl9Ifi0SM8zWvNq9
	TJFloM0dYYJVW5wStgmHFBGsYTjI0ZBXrVYnvTqsBngpMd9GsEb3PVF2oEaUEOgHMM=
X-Received: by 2002:a05:600c:8189:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-48fe632249dmr324006805e9.16.1779227512557;
        Tue, 19 May 2026 14:51:52 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm222376005e9.4.2026.05.19.14.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 14:51:51 -0700 (PDT)
Message-ID: <3d357a67-b1e0-4204-8748-a926ced24c5c@grsecurity.net>
Date: Tue, 19 May 2026 23:51:50 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 04/20] x86: Dedup guest/host context
 switch of registers across SVM and VMX
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
 <20260514210500.1626871-5-seanjc@google.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20260514210500.1626871-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.05.26 23:04, Sean Christopherson wrote:
> Deduplicate the context switching of registers across VM-Enter<=>VM-Exit
> between SVM and VMX.  The required functionality and implementations are
> practically identical, literally the only difference is that SVM doesn't
> need (or want) to manually swap RAX as SVM automatically swaps RAX at
> VMRUN and #VMEXIT.
> 
> Opportunistically rename the structure to "guest_regs" to clarify its
> purpose, and to avoid conflicts, e.g. with realmode's "struct regs".
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  lib/x86/virt.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  x86/svm.c      |  4 ++--
>  x86/svm.h      | 47 ++++-----------------------------------------
>  x86/vmx.c      |  8 ++++----
>  x86/vmx.h      | 42 +---------------------------------------
>  5 files changed, 63 insertions(+), 90 deletions(-)
>  create mode 100644 lib/x86/virt.h
> 
> diff --git a/lib/x86/virt.h b/lib/x86/virt.h
> new file mode 100644
> index 00000000..ccc90c25
> --- /dev/null
> +++ b/lib/x86/virt.h
> @@ -0,0 +1,52 @@
> +#ifndef _x86_VIRT_H_
> +#define _x86_VIRT_H_
> +
> +#include "libcflat.h"
> +
> +struct guest_regs {
> +	u64 rax;
> +	u64 rcx;
> +	u64 rdx;
> +	u64 rbx;
> +	/*
> +	 * Use RSP's index to hold CR3, as RSP isn't manually context switched
                                   ^^^ that should be CR2...
> +	 * by software in any relevant flows.
> +	 */
> +	u64 cr2;
            ^^^ or this one cr3?

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
> +extern struct guest_regs regs;
> +
> +#define __SWAP_GPRS			\
> +	"xchg %%rcx, regs+0x8\n\t"	\
> +	"xchg %%rdx, regs+0x10\n\t"	\
> +	"xchg %%rbx, regs+0x18\n\t"	\
> +	"xchg %%rbp, regs+0x28\n\t"	\
> +	"xchg %%rsi, regs+0x30\n\t"	\
> +	"xchg %%rdi, regs+0x38\n\t"	\
> +	"xchg %%r8, regs+0x40\n\t"	\
> +	"xchg %%r9, regs+0x48\n\t"	\
> +	"xchg %%r10, regs+0x50\n\t"	\
> +	"xchg %%r11, regs+0x58\n\t"	\
> +	"xchg %%r12, regs+0x60\n\t"	\
> +	"xchg %%r13, regs+0x68\n\t"	\
> +	"xchg %%r14, regs+0x70\n\t"	\
> +	"xchg %%r15, regs+0x78\n\t"
> +
> +#define SWAP_GPRS			\
> +	"xchg %%rax, regs+0x0\n\t"	\
> +	__SWAP_GPRS
> +
> +#endif /* _x86_VIRT_H_ */
> \ No newline at end of file
> diff --git a/x86/svm.c b/x86/svm.c
> index 941e0784..893b3f49 100644
> --- a/x86/svm.c
> +++ b/x86/svm.c
> @@ -223,9 +223,9 @@ void vmcb_ident(struct vmcb *vmcb)
>  	}
>  }
>  
> -struct regs regs;
> +struct guest_regs regs;
>  
> -struct regs get_regs(void)
> +struct guest_regs get_regs(void)
>  {
>  	return regs;
>  }
> diff --git a/x86/svm.h b/x86/svm.h
> index d9f7c731..a9e15f67 100644
> --- a/x86/svm.h
> +++ b/x86/svm.h
> @@ -2,6 +2,7 @@
>  #define X86_SVM_H
>  
>  #include "libcflat.h"
> +#include "virt.h"
>  
>  enum {
>  	INTERCEPT_INTR,
> @@ -390,26 +391,6 @@ struct svm_test {
>  	bool on_vcpu_done;
>  };
>  
> -struct regs {
> -	u64 rax;
> -	u64 rcx;
> -	u64 rdx;
> -	u64 rbx;
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
>  typedef void (*test_guest_func)(struct svm_test *);
>  
>  int run_svm_tests(int ac, char **av, struct svm_test *svm_tests);
> @@ -435,7 +416,7 @@ int get_test_stage(struct svm_test *test);
>  void set_test_stage(struct svm_test *test, int s);
>  void inc_test_stage(struct svm_test *test);
>  void vmcb_ident(struct vmcb *vmcb);
> -struct regs get_regs(void);
> +struct guest_regs get_regs(void);
>  void vmmcall(void);
>  void svm_setup_vmrun(u64 rip);
>  u64 __svm_vmrun(u64 rip);
> @@ -454,36 +435,16 @@ static inline void clgi(void)
>      asm volatile ("clgi");
>  }
>  
> -
> -
> -#define SAVE_GPR_C                              \
> -        "xchg %%rcx, regs+0x8\n\t"              \
> -        "xchg %%rdx, regs+0x10\n\t"             \
> -        "xchg %%rbx, regs+0x18\n\t"             \
> -        "xchg %%rbp, regs+0x28\n\t"             \
> -        "xchg %%rsi, regs+0x30\n\t"             \
> -        "xchg %%rdi, regs+0x38\n\t"             \
> -        "xchg %%r8, regs+0x40\n\t"              \
> -        "xchg %%r9, regs+0x48\n\t"              \
> -        "xchg %%r10, regs+0x50\n\t"             \
> -        "xchg %%r11, regs+0x58\n\t"             \
> -        "xchg %%r12, regs+0x60\n\t"             \
> -        "xchg %%r13, regs+0x68\n\t"             \
> -        "xchg %%r14, regs+0x70\n\t"             \
> -        "xchg %%r15, regs+0x78\n\t"
> -
> -#define LOAD_GPR_C      SAVE_GPR_C
> -
>  #define ASM_PRE_VMRUN_CMD                       \
>                  "vmload %%rax\n\t"              \
>                  "mov regs+0x80, %%r15\n\t"      \
>                  "mov %%r15, 0x170(%%rax)\n\t"   \
>                  "mov regs, %%r15\n\t"           \
>                  "mov %%r15, 0x1f8(%%rax)\n\t"   \
> -                LOAD_GPR_C                      \
> +                __SWAP_GPRS                     \
>  
>  #define ASM_POST_VMRUN_CMD                      \
> -                SAVE_GPR_C                      \
> +                __SWAP_GPRS                     \
>                  "mov 0x170(%%rax), %%r15\n\t"   \
>                  "mov %%r15, regs+0x80\n\t"      \
>                  "mov 0x1f8(%%rax), %%r15\n\t"   \
> diff --git a/x86/vmx.c b/x86/vmx.c
> index 44ee3697..603730c2 100644
> --- a/x86/vmx.c
> +++ b/x86/vmx.c
> @@ -44,7 +44,7 @@ struct vmcs *vmcs_root;
>  u32 vpid_cnt;
>  u64 guest_stack_top;
>  u32 ctrl_pin, ctrl_enter, ctrl_exit, ctrl_cpu[2];
> -struct regs regs;
> +struct guest_regs regs;
>  
>  struct vmx_test *current;
>  
> @@ -1732,7 +1732,7 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
>  	asm volatile (
>  		"mov %[HOST_RSP], %%rdi\n\t"
>  		"vmwrite %%rsp, %%rdi\n\t"
> -		LOAD_GPR_C
> +		SWAP_GPRS
>  		"cmpb $0, %[launched]\n\t"
>  		"jne 1f\n\t"
>  		"vmlaunch\n\t"
> @@ -1740,14 +1740,14 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
>  		"1: "
>  		"vmresume\n\t"
>  		"2: "
> -		SAVE_GPR_C
> +		SWAP_GPRS
>  		"pushf\n\t"
>  		"pop %%rdi\n\t"
>  		"mov %%rdi, %[vm_fail_flags]\n\t"
>  		"movl $1, %[vm_fail]\n\t"
>  		"jmp 3f\n\t"
>  		"vmx_return:\n\t"
> -		SAVE_GPR_C
> +		SWAP_GPRS
>  		"3: \n\t"
>  		: [vm_fail]"+m"(result->vm_fail),
>  		  [vm_fail_flags]"=m"(result->flags)
> diff --git a/x86/vmx.h b/x86/vmx.h
> index 425b1c43..56f37633 100644
> --- a/x86/vmx.h
> +++ b/x86/vmx.h
> @@ -5,6 +5,7 @@
>  #include "processor.h"
>  #include "bitops.h"
>  #include "util.h"
> +#include "virt.h"
>  #include "asm/page.h"
>  #include "asm/io.h"
>  
> @@ -58,26 +59,6 @@ struct invvpid_operand {
>  	u64 gla;
>  };
>  
> -struct regs {
> -	u64 rax;
> -	u64 rcx;
> -	u64 rdx;
> -	u64 rbx;
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
>  union exit_reason {
>  	struct {
>  		u32	basic			: 16;
> @@ -587,25 +568,6 @@ enum vm_entry_failure_code {
>  	ENTRY_FAIL_VMCS_LINK_PTR	= 4,
>  };
>  
> -#define SAVE_GPR_C				\
> -	"xchg %%rax, regs\n\t"			\
> -	"xchg %%rcx, regs+0x8\n\t"		\
> -	"xchg %%rdx, regs+0x10\n\t"		\
> -	"xchg %%rbx, regs+0x18\n\t"		\
> -	"xchg %%rbp, regs+0x28\n\t"		\
> -	"xchg %%rsi, regs+0x30\n\t"		\
> -	"xchg %%rdi, regs+0x38\n\t"		\
> -	"xchg %%r8, regs+0x40\n\t"		\
> -	"xchg %%r9, regs+0x48\n\t"		\
> -	"xchg %%r10, regs+0x50\n\t"		\
> -	"xchg %%r11, regs+0x58\n\t"		\
> -	"xchg %%r12, regs+0x60\n\t"		\
> -	"xchg %%r13, regs+0x68\n\t"		\
> -	"xchg %%r14, regs+0x70\n\t"		\
> -	"xchg %%r15, regs+0x78\n\t"
> -
> -#define LOAD_GPR_C	SAVE_GPR_C
> -
>  #define VMX_IO_SIZE_MASK	0x7
>  #define _VMX_IO_BYTE		0
>  #define _VMX_IO_WORD		1
> @@ -739,8 +701,6 @@ enum vm_entry_failure_code {
>  #define VMCS_FIELD_RESERVED_SHIFT	(15)
>  #define VMCS_FIELD_BIT_SIZE		(BITS_PER_LONG)
>  
> -extern struct regs regs;
> -
>  extern union vmx_basic_msr basic_msr;
>  extern union vmx_ctrl_msr ctrl_pin_rev;
>  extern union vmx_ctrl_msr ctrl_cpu_rev[2];

