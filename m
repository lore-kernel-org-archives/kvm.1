Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8A37F733;
	Tue, 28 Apr 2026 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369446; cv=none; b=MsZ7ZLdAvZ8n0QoabinX19RCggfIzIjAE2BRUsBVz0bEkii2mRzLEbn94pp+/G/saxKP1nXJw/0u6xk+OvPDczrw8Jee3ljsQ5alFo9/wwCYwnOzUy0meOo0HJC71teJOEwAAGQO+ZBx8/xO+pnLRV1CNJ6fbjnTnD6MmJyj5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369446; c=relaxed/simple;
	bh=IZN2UvEGJf77lifxDojCugFWinMAwXa1VpFtqtzwUJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMpVaqVGqEa+yVPBgNJH39FrNL8D8+G94HE9IQNaxBqKjc0BStU+xQVQkv3lr5uwY7iVWPxqO9qHc+pwHIZ7tf2BtiZ6Um7Z5TKiyfaAVRrYMqkwfBPOCOdlBcEV1eCqqcZ/enPf0ADWk8l+q+A+sE7IjUdn/IAFqDxO/de9Z3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmYZaBln; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmYZaBln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777369444; x=1808905444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IZN2UvEGJf77lifxDojCugFWinMAwXa1VpFtqtzwUJg=;
  b=GmYZaBlnmp4yUsl9nKApoFl/qkgTCx6UUtOLBzOomPXfVS3dlpRfLDlG
   8NSWZelzPF0SY1GXNutwRn4GDAmKsqQ9EJwrqvjAsQOtYzkB4JIb0RdlM
   MYC4kgsQy4Z1I4XTUNNYifebZx/pkUr80rVxG1fEIfxxg2wMiXdccMz7s
   wgBetlewhOoYZW91nMZsOUOKiq4c9ko/oS1syYyIvECVm/2dZJXigRa8v
   gUyjxnI3u71DDNFNvccyDqrwOiMIVNFULaarSgCssm8/eYcQUawj/DxOW
   ipGc0BEXdeUfCcLVtRewLhznRKWsDTEmiGSeGNBTsPWp8OOxYiv4YHTzV
   Q==;
X-CSE-ConnectionGUID: pxzZ85v8S/mMekG2L5Zqfw==
X-CSE-MsgGUID: Waf3fuu0Q9+DscnFDxd1kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78335615"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78335615"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:44:03 -0700
X-CSE-ConnectionGUID: 0C+rWLPFToi3IAKqWd2Z7Q==
X-CSE-MsgGUID: Rf3C5pC2QEGk4e7Z1ZDD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="264296639"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:44:00 -0700
Message-ID: <e47f29d5-17f1-47ce-b80e-bfa543f9a712@linux.intel.com>
Date: Tue, 28 Apr 2026 17:43:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86
 core
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 Paolo Bonzini <bonzini@redhat.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260423155936.843498069@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/2026 11:56 PM, Peter Zijlstra wrote:
> Move the VMX interrupt dispatch magic into the x86 core code. This
> isolates KVM from the FRED/IDT decisions and reduces the amount of
> EXPORT_SYMBOL_FOR_KVM().
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> ---
>  arch/x86/entry/Makefile             |    2 -
>  arch/x86/entry/common.c             |   48 ++++++++++++++++++++++++++++++++++++
>  arch/x86/entry/entry.S              |   46 ++++++++++++++++++++++++++++++++++
>  arch/x86/entry/entry_64_fred.S      |    1 
>  arch/x86/include/asm/desc.h         |    4 +++
>  arch/x86/include/asm/desc_defs.h    |    2 -
>  arch/x86/include/asm/entry-common.h |    2 +
>  arch/x86/include/asm/fred.h         |    1 
>  arch/x86/include/asm/idtentry.h     |   11 --------
>  arch/x86/kernel/idt.c               |   13 +++++++++
>  arch/x86/kernel/nmi.c               |    8 ------
>  arch/x86/kvm/vmx/vmenter.S          |   46 ----------------------------------
>  arch/x86/kvm/vmx/vmx.c              |   20 ++-------------
>  13 files changed, 118 insertions(+), 86 deletions(-)
> 
> --- a/arch/x86/entry/Makefile
> +++ b/arch/x86/entry/Makefile
> @@ -13,7 +13,7 @@ CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_
>  CFLAGS_syscall_32.o		+= -fno-stack-protector
>  CFLAGS_syscall_64.o		+= -fno-stack-protector
>  
> -obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
> +obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o common.o
>  
>  obj-y				+= vdso/
>  obj-y				+= vsyscall/
> --- /dev/null
> +++ b/arch/x86/entry/common.c
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/entry-common.h>
> +#include <linux/kvm_types.h>
> +#include <asm/fred.h>
> +#include <asm/desc.h>
> +
> +#if IS_ENABLED(CONFIG_KVM_INTEL)
> +/*
> + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as

s/acknowledge/acknowledged
 
> + * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
> + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
> + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
> + * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
> + * the VM-Exit is held pending until it's unblocked in the host.
> + */

[...]

> -
> -#if IS_ENABLED(CONFIG_KVM_INTEL)
> -/*
> - * Special entry point for VMX which invokes this on the kernel stack, even for
> - * 64-bit, i.e. without using an IST.  asm_exc_nmi() requires an IST to work

Although it's being removed, I guess what it says is still true?

It says asm_exc_nmi() requires an IST to work correctly, and the new path for
handling NMI when FRED is disabled.

idt_entry_from_kvm
    idt_do_nmi_irqoff
        IDT_DO_EVENT_IRQOFF call asm_exc_nmi
            ...
            call asm_exc_nmi

It seems the stack before calling asm_exc_nmi is not an IST?
Does it matter?

> - * correctly vs. the NMI 'executing' marker.  Used for 32-bit kernels as well
> - * to avoid more ifdeffery.
> - */
> -DECLARE_IDTENTRY(X86_TRAP_NMI,		exc_nmi_kvm_vmx);
> -#endif
> -
>  DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
>  #ifdef CONFIG_XEN_PV
>  DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);

[...]

> @@ -7127,17 +7124,9 @@ static void handle_external_interrupt_ir
>  	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
>  		return;
>  
> -	/*
> -	 * Invoke the kernel's IRQ handler for the vector.  Use the FRED path
> -	 * when it's available even if FRED isn't fully enabled, e.g. even if
> -	 * FRED isn't supported in hardware, in order to avoid the indirect
> -	 * CALL in the non-FRED path.
> -	 */
> +	/* For the IRQ to the core kernel for processing. */

For -> Forward?

>  	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
> -	if (IS_ENABLED(CONFIG_X86_FRED))
> -		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
> -	else
> -		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
> +	x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
>  	kvm_after_interrupt(vcpu);
>  
>  	vcpu->arch.at_instruction_boundary = true;
> @@ -7447,10 +7436,7 @@ noinstr void vmx_handle_nmi(struct kvm_v
>  		return;
>  
>  	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> -	if (cpu_feature_enabled(X86_FEATURE_FRED))
> -		fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
> -	else
> -		vmx_do_nmi_irqoff();
> +	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
>  	kvm_after_interrupt(vcpu);
>  }
>  
> 
> 
> 

