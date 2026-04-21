Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B43DDDA0
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807769; cv=none; b=VlCIUI/ODIfx6DN72FEamlhyGzdOUPIpancW3xBbTZIPTpIuIxWNFvcqYV2tsd0sN+rtr7FntBTNXP42YhJIEsmk6wSP4MO3885IKGlSn/T6Rp9/efyEq1UWfAcoicyW7+FyE/XJaNWUF9xAn9NCRtQeObDA+dmAcN1VTkvkWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807769; c=relaxed/simple;
	bh=adn8Uc2yDh85BH7+kTrpUYGWKnLM48VKknHLCruc38k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LEoEfdv9MxgCMUChajXOJb6UXbI5hoFkDkyG3gGlaxFyMqLh0p0O/T3KbUgkr0VrrYL2ABSzRTI3urS9SXzBDH0GlMiUJYZfeUSEXaPThKlcoVX1CIl4uMBeK46uJ/o2sdDzpL8DMH9Ki6Rw+bxvug2LdQ9DvhsiU8Zv7xrVHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/9zC7xd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/9zC7xd"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f5f48458eso2720714b3a.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776807768; x=1777412568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wBXhP7l3qKavd+/rS/ZPK9R2Dt9HUYv7viOl5dm0lU=;
        b=C/9zC7xddt/r4tG2m7Uy2AJ8LdBAXLKso34CBPLpHfnG0duRthsEwMVsxTOCzC1wss
         1PuDD8QyywYhX448AlmpvR4OSc6QXQy47kd2bHdBF1nmSsDzXMo7uO2nZ90BPtH3wjbb
         RAHq/qoVIf9XBA83otSN7sj8BA1710A6nQKHXVasTKc0MqlRXXY4OfTmU8GnQRclN9mO
         opeVbuvuLrxaEEpnKeWCOttLFX7cmeG/qZ4Mlj9auQq5KcbAecdyNNEwN1bJwj4XJbW4
         l6rynKMouvX71Z4hqAJw6rBrbgQ2NxZ7DVNUSs7A7yU1R6wxElMroASMpf05Z1707one
         wnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807768; x=1777412568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wBXhP7l3qKavd+/rS/ZPK9R2Dt9HUYv7viOl5dm0lU=;
        b=U7plmvsNF1EjFj6SJDNJTyl4eK7vaO25+GWqL1xREm8IvUfxLmjk9qxqefY9rKy3cy
         51S/z489Udq/r2nxvqUk9Rq+vbNxn3nzGHnLtIIIfTCaUwBJYc86tH9bwGF3olAU3Cun
         eNjBGoUT1XbvZ/P4Dq60MJyBA++5GNA+V9C5gS1iVzJf+OlXDzrJZ2PBEchZI4RL8R6e
         H2y1OtHJ0kNUmDnMRwfd9DTFxaQx+lExi9zxL6l/SGhigMyU3/qpb2AjxRhLDipNLuA7
         pkypmNKMi8For8bjePgXN1JqFRG0rLtSVByiQoh9l7ZLvsE37a1ba0EH8lQVltNBY9C7
         3ORw==
X-Forwarded-Encrypted: i=1; AFNElJ8zYCLvY5+IE22QgeY2pmYv+ogJ3a40NOQzyzACA9g9Pddy7qomiTDKrhd9s6SJZmf8ii8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+sB09+ppsYNtjybtqKBVAzU+wzthAwpBe0fq5gATFssf2JAt
	H7LmK6ebkT8j7XC4UsdrJgM+7Ddx9NRUshI+KtWUPUzAAozVH86vDh7VVUkuwRcm2yTj3pCRElt
	LaoYoCQ==
X-Received: from pfbci14.prod.google.com ([2002:a05:6a00:28ce:b0:82f:7242:4cb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa08:b0:82f:b0:28f0
 with SMTP id d2e1a72fcca58-82f8c8e5120mr22041138b3a.34.1776807767604; Tue, 21
 Apr 2026 14:42:47 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:42:46 -0700
In-Reply-To: <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com> <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
Message-ID: <aefvVjTtx22EzMkR@google.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 08:57:24PM +0000, Sean Christopherson wrote:
> > This as delta? (I had typed this all up before Peter posted a new verison, so
> > dammit I'm sending it!)
> 
> :-)
> 
> I'll go stare at it in the morning, I'm about to go crash out.

New delta against your effective v2, builds all of my configs (which isn't _that_
many, but I think they cover most of the weirder ways to include KVM (or not)).

I'll start testing the full thing to try and get early signal on the health.

diff --git arch/x86/entry/common.c arch/x86/entry/common.c
index 8de94a590b26..0532c1b65dd9 100644
--- arch/x86/entry/common.c
+++ arch/x86/entry/common.c
@@ -6,6 +6,15 @@
 #include <asm/fred.h>
 #include <asm/desc.h>
 
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+/*
+ * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as
+ * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
+ * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
+ * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
+ * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
+ * the VM-Exit is held pending until it's unblocked in the host.
+ */
 noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
 {
 #ifdef CONFIG_X86_64
@@ -20,3 +29,4 @@ noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
        }
 }
 EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
+#endif
diff --git arch/x86/include/asm/fred.h arch/x86/include/asm/fred.h
index 2bb65677c079..18a2f811c358 100644
--- arch/x86/include/asm/fred.h
+++ arch/x86/include/asm/fred.h
@@ -110,7 +110,6 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { ret
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
diff --git arch/x86/kernel/idt.c arch/x86/kernel/idt.c
index d95d8d196cd4..d69d27846424 100644
--- arch/x86/kernel/idt.c
+++ arch/x86/kernel/idt.c
@@ -267,7 +267,7 @@ void __init idt_setup_early_pf(void)
                             ARRAY_SIZE(early_pf_idts), true);
 }
 #else
-void idt_entry_from_kvm(unsigned int vector)
+noinstr void idt_entry_from_kvm(unsigned int vector)
 {
        if (vector == NMI_VECTOR)
                idt_do_nmi_irqoff();
diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index f6f5c124ed3b..753f0dbb9cf8 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -7083,9 +7083,6 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
        vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-void vmx_do_interrupt_irqoff(unsigned long entry);
-void vmx_do_nmi_irqoff(void);
-
 static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 {
        /*

