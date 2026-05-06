Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E14C77A4
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093280; cv=none; b=P1/iDsyrS8eAygkSxBVmFDokQuk+7QRTHh5s//MNwfdwii60Yk7X+3T2O7/LLAyOst4DOW9OFIDluIhYFs1E9BvquTmZEgw/lqGQvwCUWq6p/8PKbKGUXQ4E/hBYFVXAauSg6CsfhxBQgXt7sTKsVsd2PzsPWJL0gGgzFeJiWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093280; c=relaxed/simple;
	bh=dD50kImjAs4n/VJYYHkpt8yr+7YokNw7UmkSvq/Vj68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLAlOcIUW2xABG2xx0f8Uu66ULOr3pQJ+SW3TQd9BRlW5JSv7R1AXhxyY7a3Cixp2g3u0N27uStZ3gEs1A5kbQIK6cZVg05TBlYAXHzxvhThzNDqEIF15fq8umqs962VoDnqfuX/ZtoKvHCmo6Jp/Gr3zvNn4LAxNRKLFzEm4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOsEotGp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOsEotGp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2eba42b8dso701215ad.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778093273; x=1778698073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0+CpfFl26keveVnjN2M5HYQ28HxPGqSFHqLnNi302Zw=;
        b=hOsEotGpQn57w2eNWjQIyEqFHCUuVtR/P8fYmExFA6FXpCfVsuWnNtxJBf9TCd+z+x
         Iz3umMXky7tnMLWAXHZn8AbKJoSUOeiyZnKxy7hSfo0nGmlCrttybONLPmZz18/ybW7q
         YDaDNPHvmA8R/sMwqS8NXE1UXt6bTLkOdA53M5YWKztUzW8858ccukA4gJDb0w2ZiSIa
         Ra8j8ECkl1uNbEdaBS/3/j+0HUoqsPAoI+gJuq6ZT2cSD+yWNlt2JfQKKNIHdG5kF+i/
         VrRF85rhKOdZjMQGYLp6FV0HKhugjyVSKUHrz/cfNPVEpOApT915tzW8EiW+WmjGfkvR
         L74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093273; x=1778698073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+CpfFl26keveVnjN2M5HYQ28HxPGqSFHqLnNi302Zw=;
        b=qCBYAjOjui2yghIKyuOiQutUqgsk2LNceTGKs69Lv8V20zId/7JdjNmOGWjOMIDLUa
         cxR9m25RRy1CsrYjriXZ/w7OYLlqBd/+w9kJpMLeo8QhYEtd7KM2EKs+FA0zXfGelzzX
         V78kO9Q1bMb6QNkpy1WnWYvriU8Pbiwdsgql/1aJQS3hDUkG/AySvXMRvJKUR6OWjxP8
         xmDVIuL6LdeTSRh/qWxM0+Yn7hpFUrAu6YAdMNhYv7zrWHSzSZ+jZvwZk3wO4416/zmb
         6JM96o3+0MgNtQrvvHWir+OiiRIP5VnJHLhiNtYis5UvW2C35im3bWJISkg02W9C60qQ
         vZeg==
X-Gm-Message-State: AOJu0YyfCDHyvkaAMNGUd88fV7Em4qYH4UvFXa33ysFQrO6ybK/jTTmo
	U7ZnIlJoV5m98jZuG4sStriNsVscqF2rc2fE4zrvTjoLaCijUBUYluaoQoX4LV8yEFhhVZhu67+
	CtN3Vig==
X-Received: from plhs18.prod.google.com ([2002:a17:903:3212:b0:2ba:7815:4806])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3887:b0:2b9:4941:7f6e
 with SMTP id d9443c01a7336-2ba792b53damr49354055ad.2.1778093273063; Wed, 06
 May 2026 11:47:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 11:47:45 -0700
In-Reply-To: <20260506184746.2719880-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506184746.2719880-5-seanjc@google.com>
Subject: [PATCH v2 4/5] *** DO NOT MERGE *** KVM: x86: Hack in a stat to track
 guest-induced exits (for testing)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Not-signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/svm/svm.c          | 81 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c          | 79 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  2 +
 4 files changed, 164 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..bff534bd00dc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1703,6 +1703,8 @@ struct kvm_vcpu_stat {
 	u64 invlpg;
 
 	u64 exits;
+	u64 guest_induced_exits;
+	u64 msr_exits;
 	u64 io_exits;
 	u64 mmio_exits;
 	u64 signal_exits;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..7886bd1ad8f2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4378,6 +4378,81 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 	return EXIT_FASTPATH_NONE;
 }
 
+static bool is_guest_induced_exit(u64 exit_code)
+{
+	switch (exit_code) {
+	case SVM_EXIT_READ_CR0:
+	case SVM_EXIT_READ_CR3:
+	case SVM_EXIT_READ_CR4:
+	case SVM_EXIT_READ_CR8:
+	case SVM_EXIT_CR0_SEL_WRITE:
+	case SVM_EXIT_WRITE_CR0:
+	case SVM_EXIT_WRITE_CR3:
+	case SVM_EXIT_WRITE_CR4:
+	case SVM_EXIT_WRITE_CR8:
+	case SVM_EXIT_READ_DR0:
+	case SVM_EXIT_READ_DR1:
+	case SVM_EXIT_READ_DR2:
+	case SVM_EXIT_READ_DR3:
+	case SVM_EXIT_READ_DR4:
+	case SVM_EXIT_READ_DR5:
+	case SVM_EXIT_READ_DR6:
+	case SVM_EXIT_READ_DR7:
+	case SVM_EXIT_WRITE_DR0:
+	case SVM_EXIT_WRITE_DR1:
+	case SVM_EXIT_WRITE_DR2:
+	case SVM_EXIT_WRITE_DR3:
+	case SVM_EXIT_WRITE_DR4:
+	case SVM_EXIT_WRITE_DR5:
+	case SVM_EXIT_WRITE_DR6:
+	case SVM_EXIT_WRITE_DR7:
+	case SVM_EXIT_EXCP_BASE + DB_VECTOR:
+	case SVM_EXIT_EXCP_BASE + BP_VECTOR:
+	case SVM_EXIT_EXCP_BASE + UD_VECTOR:
+	case SVM_EXIT_EXCP_BASE + PF_VECTOR:
+	case SVM_EXIT_EXCP_BASE + AC_VECTOR:
+	case SVM_EXIT_EXCP_BASE + GP_VECTOR:
+	case SVM_EXIT_RDPMC:
+	case SVM_EXIT_CPUID:
+	case SVM_EXIT_IRET:
+	case SVM_EXIT_INVD:
+	case SVM_EXIT_PAUSE:
+	case SVM_EXIT_HLT:
+	case SVM_EXIT_INVLPG:
+	case SVM_EXIT_INVLPGA:
+	case SVM_EXIT_IOIO:
+	case SVM_EXIT_MSR:
+	case SVM_EXIT_TASK_SWITCH:
+	case SVM_EXIT_SHUTDOWN:
+	case SVM_EXIT_VMRUN:
+	case SVM_EXIT_VMMCALL:
+	case SVM_EXIT_VMLOAD:
+	case SVM_EXIT_VMSAVE:
+	case SVM_EXIT_STGI:
+	case SVM_EXIT_CLGI:
+	case SVM_EXIT_SKINIT:
+	case SVM_EXIT_RDTSCP:
+	case SVM_EXIT_WBINVD:
+	case SVM_EXIT_MONITOR:
+	case SVM_EXIT_MWAIT:
+	case SVM_EXIT_XSETBV:
+	case SVM_EXIT_RDPRU:
+	case SVM_EXIT_EFER_WRITE_TRAP:
+	case SVM_EXIT_CR0_WRITE_TRAP:
+	case SVM_EXIT_CR4_WRITE_TRAP:
+	case SVM_EXIT_CR8_WRITE_TRAP:
+	case SVM_EXIT_INVPCID:
+	case SVM_EXIT_IDLE_HLT:
+	case SVM_EXIT_RSM:
+	case SVM_EXIT_AVIC_INCOMPLETE_IPI:
+	case SVM_EXIT_AVIC_UNACCELERATED_ACCESS:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
 static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_intercepted)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
@@ -4573,6 +4648,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (is_guest_mode(vcpu))
 		svm->nested.ctl.next_rip = svm->vmcb->control.next_rip;
 
+	if (is_guest_induced_exit(svm->vmcb->control.exit_code))
+		++vcpu->stat.guest_induced_exits;
+
+	if (svm->vmcb->control.exit_code == SVM_EXIT_MSR)
+		++vcpu->stat.msr_exits;
+
 	return svm_exit_handlers_fastpath(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c2c33a5f7dc..859f4bc01445 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7478,6 +7478,79 @@ noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
 	kvm_after_interrupt(vcpu);
 }
 
+static bool is_guest_induced_exit(struct kvm_vcpu *vcpu)
+{
+	switch (vmx_get_exit_reason(vcpu).basic) {
+	case EXIT_REASON_EXCEPTION_NMI:
+		if (is_nmi(vmx_get_intr_info(vcpu)))
+			return false;
+		return true;
+	case EXIT_REASON_TRIPLE_FAULT:
+	case EXIT_REASON_IO_INSTRUCTION:
+	case EXIT_REASON_CR_ACCESS:
+	case EXIT_REASON_DR_ACCESS:
+	case EXIT_REASON_CPUID:
+	case EXIT_REASON_MSR_READ:
+	case EXIT_REASON_MSR_WRITE:
+	case EXIT_REASON_HLT:
+	case EXIT_REASON_INVD:
+	case EXIT_REASON_INVLPG:
+	case EXIT_REASON_RDPMC:
+	case EXIT_REASON_VMCALL:
+	case EXIT_REASON_VMCLEAR:
+	case EXIT_REASON_VMLAUNCH:
+	case EXIT_REASON_VMPTRLD:
+	case EXIT_REASON_VMPTRST:
+	case EXIT_REASON_VMREAD:
+	case EXIT_REASON_VMRESUME:
+	case EXIT_REASON_VMWRITE:
+	case EXIT_REASON_VMOFF:
+	case EXIT_REASON_VMON:
+	case EXIT_REASON_TPR_BELOW_THRESHOLD:
+	case EXIT_REASON_APIC_ACCESS:
+	case EXIT_REASON_APIC_WRITE:
+	case EXIT_REASON_EOI_INDUCED:
+	case EXIT_REASON_WBINVD:
+	case EXIT_REASON_XSETBV:
+	case EXIT_REASON_TASK_SWITCH:
+	case EXIT_REASON_MCE_DURING_VMENTRY:
+	case EXIT_REASON_GDTR_IDTR:
+	case EXIT_REASON_LDTR_TR:
+	case EXIT_REASON_PAUSE_INSTRUCTION:
+	case EXIT_REASON_MWAIT_INSTRUCTION:
+	case EXIT_REASON_MONITOR_INSTRUCTION:
+	case EXIT_REASON_INVEPT:
+	case EXIT_REASON_INVVPID:
+	case EXIT_REASON_RDRAND:
+	case EXIT_REASON_RDSEED:
+	case EXIT_REASON_INVPCID:
+	case EXIT_REASON_VMFUNC:
+	case EXIT_REASON_ENCLS:
+	case EXIT_REASON_SEAMCALL:
+	case EXIT_REASON_TDCALL:
+	case EXIT_REASON_MSR_READ_IMM:
+	case EXIT_REASON_MSR_WRITE_IMM:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static bool is_msr_exit(struct kvm_vcpu *vcpu)
+{
+	switch (vmx_get_exit_reason(vcpu).basic) {
+	case EXIT_REASON_MSR_READ:
+	case EXIT_REASON_MSR_WRITE:
+	case EXIT_REASON_MSR_READ_IMM:
+	case EXIT_REASON_MSR_WRITE_IMM:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
 static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 					unsigned int flags)
 {
@@ -7667,6 +7740,12 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	vmx_recover_nmi_blocking(vmx);
 	vmx_complete_interrupts(vmx);
 
+	if (is_guest_induced_exit(vcpu))
+		++vcpu->stat.guest_induced_exits;
+
+	if (is_msr_exit(vcpu))
+		++vcpu->stat.msr_exits;
+
 	return vmx_exit_handlers_fastpath(vcpu, force_immediate_exit);
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..dc69b8cebe0b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -283,6 +283,8 @@ const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	STATS_DESC_COUNTER(VCPU, tlb_flush),
 	STATS_DESC_COUNTER(VCPU, invlpg),
 	STATS_DESC_COUNTER(VCPU, exits),
+	STATS_DESC_COUNTER(VCPU, guest_induced_exits),
+	STATS_DESC_COUNTER(VCPU, msr_exits),
 	STATS_DESC_COUNTER(VCPU, io_exits),
 	STATS_DESC_COUNTER(VCPU, mmio_exits),
 	STATS_DESC_COUNTER(VCPU, signal_exits),
-- 
2.54.0.545.g6539524ca2-goog

