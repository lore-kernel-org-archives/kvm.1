Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB246C837
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712269; cv=none; b=ETF/HTtX5xfabqCZ5KZc1WH1doSdy5v4hHN2yRnYPOAkEPk1Cr0WpWxCzsKbjMqngvHg2VAEh3k/6kftnI2YmulKbMJuLFuPMwQUINrD8VhA6m/mdvWy63WulBcq3tbm+OWwhHaQ0ypLtCA3mjKsBwAP9mb5L7V2uPmOSJeWpSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712269; c=relaxed/simple;
	bh=izbe7ZcJLT4/vE0QipHanYV81LIiL3sGrBu3pjzK7pU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QM592MHCUT8XauBGI3aHi47S+0T0WyG+lUMapdcMs9PfPAxxGFPdFEwnDMsmUfmRLCYe0hiavCBzde2IYEfZTAK/4IRruC35C1TX+FLmCn5BMesNIHERf+JjbfbxYbDOUD58tBv+pR5QFyyOStYduwiblxo0g7rAB/wqFpoa+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpVGSKLM; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpVGSKLM"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848474825ffso1279976b3a.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786712267; x=1787317067; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bDJ7mlcbwJNTCYEfJjjmPhvi6YvmwwLSKsLivI/3Dm4=;
        b=CpVGSKLMoYgoYRwgrtRQB5XyA5EJbHXlAZ43FVWRYzng6iRZm9mEvtSpEGr6E1It8z
         XWRuZMP5ZqfBcftsqX7ODr48zeKhwXoH9SofhSfDa/PeQOHbbdq+g09rLStKMSIdDFhd
         dmINW9JBjq/M+GddVXWMzU+TRGjXPGN2QyvWEc7L3xt0zVyZ+oNxQ7Uz+9n+c1+x/tAk
         cTM7YQIETc9s17zOf14sgtsZf+Gt0oKxQL73aVwo0qxxYK7/cUOz+dRrgKOo2tgHtxxA
         a/EBmqANlSPnVm8pB4rcb5IgZuWNzq3C57m9f/letwy/SQ41HpXIb10rDcZdIcWK9AHJ
         cnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786712267; x=1787317067;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDJ7mlcbwJNTCYEfJjjmPhvi6YvmwwLSKsLivI/3Dm4=;
        b=eP1l/TO6iCdCjvANl9hJBKBCSe9LCpL8b2rtMFH1KM6TRHFdA1ioyCsPPWCer/sXW4
         yw2jhwCR6LI5y8J5UxUoSVvXIG7NZcgWotGuYoU+koiMLrS8AeMsjXHiNUa/yAmcWyMM
         V29gRNDai9AVUuoWg9XmhPTXg1xfeVMoXASwKR2ksEkqIfpP+N05Lk82NZTQ7ooEn1LN
         gphVwCTy21IltHFRnqYk8/LbGmIHukT5ck+wmzrT0tqcf0ouSRk+UukwW2dSlWlvAWtw
         i341sHkvH16VSzce8ijYrAugAT6sCEN2oBvbcoJg+f+PTRTUKyrvNqrqSporpbkFBP5L
         b7qw==
X-Gm-Message-State: AOJu0YysTo6Br13jeHz34FZMMFXSRUK9BBntvg4XKvfTYgBNINzyoMx4
	Di74v+SfXpzzgPmW9IHqg2zRb+CD4w00nBdFWaafhmfXGHOAQfjaGU6rwbGFMtuJKRrAAr09ZTe
	hVooMdg==
X-Received: from pfoo3.prod.google.com ([2002:a05:6a00:1a03:b0:84c:282c:5608])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd0e:b0:84e:cd14:aeba
 with SMTP id d2e1a72fcca58-84fdc6800aemr5107346b3a.6.1786712266971; Fri, 14
 Aug 2026 05:57:46 -0700 (PDT)
Date: Fri, 14 Aug 2026 05:57:45 -0700
In-Reply-To: <178669637845.81620.8189698601844425753@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <178669637845.81620.8189698601844425753@linux.alibaba.com>
Message-ID: <an8QybMBNTk3zdIF@google.com>
Subject: Re: [RFC] Expose L1 guest register state for nested VMX via KVM_GET_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Zhengrong Li wrote:
> [RFC] Expose L1 guest register state for nested VMX via KVM_GET_NESTED_STATE
> 
> Problem
> =======
> 
> KVM_GET_REGS and KVM_GET_SREGS always return the register state of the
> currently active guest context.  When a vCPU is in VMX non-root
> operation running an L2 nested guest, these ioctls return L2 state.
> There is no way for userspace to retrieve L1 guest state while L2 is
> active.
> 
> This affects any tool that inspects vCPU register state.  For example,
> QEMU's "info registers" monitor command and GDB stub both show L2
> registers when L2 is running, making nested VM debugging difficult.
> Users have no way to determine where L1 was executing, 

vmcs12.HOST_RIP will provide a solid clue given that software convention is to
put the exit handler close to the entry point.

> what page tables it was using,

vmcs12.HOST_{CR3,CR4} and vmcs12.HOST_EFER

> or which privilege level it was in.

Given that VMLAUNCH and VMRESUME are CPL0-only, this one's easy. :-D

> SVM Comparison
> ==============
> 
> For AMD/SVM, KVM_GET_NESTED_STATE already returns the vmcb01 save area,
> which provides comprehensive L1 state (see svm_get_nested_state() in
> arch/x86/kvm/svm/nested.c, line 1943):
> 
>     copy_to_user(&user_vmcb->save, &svm->vmcb01.ptr->save,
>                  sizeof(user_vmcb->save));
> 
> The SVM vmcb_save_area includes:
> 
>   Registers:  RIP, RSP, RAX, RFLAGS
>   Control:    CR0, CR2, CR3, CR4, EFER
>   Debug:      DR6, DR7
>   Segments:   ES/CS/SS/DS/FS/GS (selector, base, limit, attr)
>   Tables:     GDTR, IDTR, LDTR, TR
>   Syscall MSRs: STAR, LSTAR, CSTAR, SFMASK, KERNEL_GS_BASE,
>                 SYSENTER_CS/ESP/EIP
>   Other:      PAT, SPEC_CTRL, CPL
> 
> This gives userspace a near-complete snapshot of L1 state.
> 
> VMX has no equivalent.  KVM_GET_NESTED_STATE for VMX returns vmcs12
> (which contains L2 guest state + L1 host-state area for VM-exit) but
> never exposes L1's running guest state from vmcs01.

Because there is no L1 "running" state.  The majority of the data that's listed
above is explicitly loaded from vmcs12 on VM-Exit from L2 => L1.  CR2 isn't
loaded because it's software's responsibility to context switch CR2.

In other words, what you want is already available via KVM_GET_NESTED_STATE, it
simply requires reading vmcs12.HOST_xxx.

> Proposed: L1 Guest State Snapshot for VMX
> =========================================
> 
> Add a new section to the VMX nested state data that provides a
> comprehensive L1 register snapshot, assembled from all sources KVM has
> access to.
> 
> The data should be returned as a VMCS12-sized blob (same format as the
> existing vmcs12 and shadow_vmcs12 sections).  This reuses existing
> infrastructure and lets userspace parse fields using the well-known
> vmcs12 layout.
> 
> Fields to include (from vmcs01 hardware VMCS):
>   GUEST_RSP, GUEST_RIP, GUEST_RFLAGS
>   GUEST_CR0, GUEST_CR3, GUEST_CR4
>   GUEST_IA32_EFER, GUEST_IA32_PAT
>   GUEST_DR7
>   GUEST_ES/CS/SS/DS/FS/GS (selector, base, limit, ar_bytes)
>   GUEST_GDTR, GUEST_IDTR (base, limit)
>   GUEST_LDTR, GUEST_TR (selector, base, limit, ar_bytes)
>   GUEST_SYSENTER_CS, GUEST_SYSENTER_ESP, GUEST_SYSENTER_EIP
>   GUEST_PDPTR0-3
>   GUEST_INTERRUPTIBILITY_INFO, GUEST_ACTIVITY_STATE
> 
> Additional fields from KVM's vcpu software model (vcpu->arch.*):
>   CR2      -- vcpu->arch.cr2 (cached from last #PF)
>   DR6      -- vcpu->arch.dr6 (cached from last debug event)
>   MSR_IA32_SPEC_CTRL  -- vcpu->arch.spec_ctrl
>   MSR_KERNEL_GS_BASE  -- via kvm_get_msr() or uret array
>   MSR_STAR, MSR_LSTAR, MSR_CSTAR, MSR_SF_MASK
>     -- via uret/uret_msrs array (populated on VM-exit)
> 
> Note: the MSR-derived fields (KERNEL_GS_BASE, STAR, LSTAR, CSTAR,
> SFMASK, SPEC_CTRL) are not VMCS guest-state fields in Intel VMX.  They
> are saved/restored by the VM-entry MSR-load mechanism or KVM's MSR
> save/restore path.  

No.  Like GPRs, KVM can't distinguish between L1 and L2 values because how L1
manages L2's values is defined by L1 software, not by the architecture.

> Hardware Limitation (GPRs)
> ==========================
> 
> Neither Intel VMX nor AMD SVM saves general-purpose registers (beyond
> RAX/RSP/RIP) into the VMCS/VMCB on VM-entry.  RBX, RCX, RDX, RSI, RDI,
> R8-R15 remain in physical registers and are overwritten when L2 starts.
> 
> For SVM, hardware saves RAX to the VMCB save area; for VMX, RAX is not
> in the VMCS guest-state area at all.  This is a hardware constraint,
> not something KVM can work around.
> 
> The L1 hypervisor is responsible for saving its own GPRs (typically on
> its stack), which KVM cannot locate.

Well, KVM could locate that, but so could QEMU.  The host RSP will provide a
very good starting point for guessing L1's GPR state.

> Questions for Maintainers
> =========================
> 
> 1. Is exposing L1 guest state via KVM_GET_NESTED_STATE acceptable?

No, because architecturally it has no meaning, and in practice the vmcs12 host
state should give you pretty much everything you need.  If you want more debug
information than what is avaiable via KVM ioctls, then there's always BPF.
