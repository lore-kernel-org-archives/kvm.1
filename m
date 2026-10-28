Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212901;
	b=d8HB+ew0otEETRnvJii4yWOWivyWTivgNT0Q3rRuBLrL/lUKlcM+KuemXuxC5ytN+VhF
	 AD2fI21dDfMuquKu51IYVHxToCTpxdhtqR4tSAfFCUpgJ2AdsOBrV2aIqn+QSh3BuNqdu
	 SfT4hjOct6sDLWxa1dY+HOZpdZGagCs4TFPRxXGbRgozGvCwtDN4MyxppJoEERLwg8JSt
	 Sd7Mi45+dz5dPgXmVBuekOfPKwXXD1zCadC79+O84Fhjp6BskJk1tfdrmmRC1x11+UroM
	 g33UCDDJArOnKYKIk16PwNWlribNHebmivAWWqBahPHxUpg0L1vKXFVbdOiwu6ZBlNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cCEoF6s94hPP1zkc5Bn/lx1s1R+sfWNsW5xGnw922Do=;
	b=5Y2cOJO2ogfvs/Ixtbpzu5J6MdY9Gwt7rYmx2Mqv7ERJTJWdFAdfkGpv+jranWq5hAZK
	 tEAztqocWzhx2dAgC+VLIgULyCqDYfTcl00KEFnAp9H1xzt+XeRvSVKUmgQpYQUkyaiGr
	 Tu8s+4K/PlNonBWOngVtGP0ZrrtOV+h6bV/ofnFy5soqiEyolXtslGYDiP7TNefPdZxZF
	 b0RkZQ2Iz2bVJxpnGJ5nasqspsp9DFXlnYO+6gHPRs3SGyI8UT92pE4OdCL+AK06QbyQ6
	 ulwv6lx7vawT9hCfyKJfLId8Dd1DYa3EpENhy4NHkRfLLlY84s+MCb/yUpRdz+RJrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L6ds6xCo;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B40606A33B
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B40606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L6ds6xCo
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso1088123a91.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793212900; x=1793817700; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cCEoF6s94hPP1zkc5Bn/lx1s1R+sfWNsW5xGnw922Do=;
        b=L6ds6xCooLXl1F7vSVYsmM0XuZB39A0c/mZvIvNz+AsClzszPf3VkE1brXqdqAI50f
         tfiZWyV/Kr5sAHMBOrvr145/8Oa4XNsMMktW3ydsBV8fcMeueDz6Z3SQV0yHhqsmWD3c
         YBGBtDEHhsroBczslP8JkYgUpuyAfhkYhirHbOHof6m0Tl/KWV5CtThhrCWveAqktNaO
         5bBY2KYfkmTDjnbfzDiuYeTC/IHi/UDQd3sQEPyIqoH8NAkg4Ww1zzIIoNNVy/6MzMHm
         uKx30j6mTwObDhP5gUS8UFVtvoHHCYQAMSHHD4O4pxVkexfrEd1jqDlSzIBcLErLSIni
         7Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212900; x=1793817700;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cCEoF6s94hPP1zkc5Bn/lx1s1R+sfWNsW5xGnw922Do=;
        b=u+zlBJKF24xlwaTbc12kHKCPgjbSUzwfcSkUkJ7yD8hfrhU7FgJSpMhdO8Z4dc5ulj
         rJUHPutNh3vuC+PpXO21MBfKvDUNxqj0cUvqigrwz4lszR9eyEBeNfuN1aw4dBdj5EBD
         oWsejdWXm7hAenBiP4CZ7DtW/wPV7GBAhHV1+CT1tzv46oKiVRZCf8PZtPND1X0hWt2q
         0oye4KQsJNuk17qawE3fUPj3/6I7ntzuqPytumpYD+Dp67Gd5WL6QRUVBOTGLHi3klUW
         n55TteIPPfWvCM8DBls++1bW6XjTkf19cy5k1tsW5E3jowEhU5CxG+HtwhQYnntJuNQ2
         9KEA==
X-Gm-Message-State: AFq9FYLxr3IGtAvqC4/08P6i7A6md1dTNQo6/uES520lfoi4uAXljkCg
	DifXZ+hbZYKAYt/Ewou+Rsvoyotl8lST22IN/ap+nqDehas5LmUVaCNkdKnpEUMHlPAk43Kb89I
	AAp1JqA==
X-Received: from pjlm17.prod.google.com ([2002:a17:90a:7f91:b0:3a7:e2d8:4f4c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280b:b0:3ac:8af9:4a6a
 with SMTP id 98e67ed59e1d1-3ae580df8d5mr2273458a91.42.1793212900004; Wed, 28
 Oct 2026 11:41:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 11:41:36 -0700
In-Reply-To: <20261028184136.1803336-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028184136.1803336-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028184136.1803336-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: x86: Convert all runtime WARNs to ONCE variants
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Bulk convert all non-ONCE WARN_ON() and WARN() calls that are reachable at
runtime to have ONCE protection, as WARNing multiple times on the same
issue rarely adds value, and if KVM is flawed/buggy, unprotected WARNs can
be leveraged by a misbehaving guest to effectively DoS the host.  In the
Age of AI, such flaws/bugs are depressingly easy to find.

Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c          |  2 +-
 arch/x86/kvm/i8254.c           |  2 +-
 arch/x86/kvm/irq.c             |  4 ++--
 arch/x86/kvm/lapic.c           |  8 ++++----
 arch/x86/kvm/mmu/tdp_mmu.c     |  4 ++--
 arch/x86/kvm/msrs.c            |  2 +-
 arch/x86/kvm/svm/avic.c        |  2 +-
 arch/x86/kvm/svm/nested.c      | 12 ++++++------
 arch/x86/kvm/svm/sev.c         |  2 +-
 arch/x86/kvm/svm/svm.c         | 12 ++++++------
 arch/x86/kvm/vmx/nested.c      | 12 ++++++------
 arch/x86/kvm/vmx/posted_intr.c |  2 +-
 arch/x86/kvm/vmx/vmx.c         |  8 ++++----
 arch/x86/kvm/x86.c             | 18 +++++++++---------
 arch/x86/kvm/x86.h             |  2 +-
 15 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5d2e3617c952..d9e3d49a6cc5 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1977,7 +1977,7 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
 	 * space, just put 'flush all' entry there.
 	 */
 	if (count && entries && count < kfifo_avail(&tlb_flush_fifo->entries)) {
-		WARN_ON(kfifo_in(&tlb_flush_fifo->entries, entries, count) != count);
+		WARN_ON_ONCE(kfifo_in(&tlb_flush_fifo->entries, entries, count) != count);
 		goto out_unlock;
 	}
 
diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddd..7ad8c11a1809 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -409,7 +409,7 @@ static void kvm_pit_load_count(struct kvm_pit *pit, int channel, u32 val,
 
 	if (hpet_legacy_start) {
 		/* save existing mode for later reenablement */
-		WARN_ON(channel != 0);
+		WARN_ON_ONCE(channel != 0);
 		saved_mode = pit->pit_state.channels[0].mode;
 		pit->pit_state.channels[0].mode = 0xff; /* disable timer */
 		pit_load_count(pit, channel, val);
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 871977288272..7f8b092b4479 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -128,7 +128,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_has_interrupt);
 int kvm_cpu_get_extint(struct kvm_vcpu *v)
 {
 	if (!kvm_cpu_has_extint(v)) {
-		WARN_ON(!lapic_in_kernel(v));
+		WARN_ON_ONCE(!lapic_in_kernel(v));
 		return -1;
 	}
 
@@ -513,7 +513,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	struct kvm *kvm = irqfd->kvm;
 	int ret;
 
-	WARN_ON(irqfd->producer != prod);
+	WARN_ON_ONCE(irqfd->producer != prod);
 
 	/*
 	 * If the producer of an IRQ that is currently being posted to a vCPU
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 61bf09badb5a..08b96b124b07 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2062,7 +2062,7 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 
 	if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
-		WARN_ON(kvm_get_running_vcpu() != vcpu);
+		WARN_ON_ONCE(kvm_get_running_vcpu() != vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;
 	}
@@ -2272,7 +2272,7 @@ static void cancel_hv_timer(struct kvm_lapic *apic)
 {
 	lockdep_assert_preemption_disabled();
 
-	WARN_ON(!apic->lapic_timer.hv_timer_in_use);
+	WARN_ON_ONCE(!apic->lapic_timer.hv_timer_in_use);
 	kvm_x86_call(cancel_hv_timer)(apic->vcpu);
 	apic->lapic_timer.hv_timer_in_use = false;
 }
@@ -2359,7 +2359,7 @@ void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu)
 	/* If the preempt notifier has already run, it also called apic_timer_expired */
 	if (!apic->lapic_timer.hv_timer_in_use)
 		goto out;
-	WARN_ON(kvm_vcpu_is_blocking(vcpu));
+	WARN_ON_ONCE(kvm_vcpu_is_blocking(vcpu));
 	apic_timer_expired(apic, false);
 	cancel_hv_timer(apic);
 
@@ -2392,7 +2392,7 @@ void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	WARN_ON(!apic->lapic_timer.hv_timer_in_use);
+	WARN_ON_ONCE(!apic->lapic_timer.hv_timer_in_use);
 	restart_apic_timer(apic);
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 44dad106fad1..9169d8dbe43c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -43,7 +43,7 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 #ifdef CONFIG_KVM_PROVE_MMU
 	KVM_MMU_WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
 #endif
-	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
+	WARN_ON_ONCE(!list_empty(&kvm->arch.tdp_mmu_roots));
 
 	/*
 	 * Ensure that all the outstanding RCU callbacks to free shadow pages
@@ -1368,7 +1368,7 @@ static bool __kvm_tdp_mmu_age_gfn_range(struct kvm *kvm,
 	 * this helper must NOT be used to unmap GFNs, as it processes only
 	 * valid roots!
 	 */
-	WARN_ON(types & ~KVM_VALID_ROOTS);
+	WARN_ON_ONCE(types & ~KVM_VALID_ROOTS);
 
 	guard(rcu)();
 	for_each_tdp_mmu_root_rcu(kvm, root, range->slot->as_id, types) {
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..b8ab784704fa 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -643,7 +643,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	r = kvm_x86_call(set_efer)(vcpu, efer);
 	if (r) {
-		WARN_ON(r > 0);
+		WARN_ON_ONCE(r > 0);
 		return r;
 	}
 
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3b037e385523..0042039e15e3 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1042,7 +1042,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	lockdep_assert_preemption_disabled();
 
-	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
+	if (WARN_ON_ONCE(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
 	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..ab66f07337b5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -100,7 +100,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	WARN_ON(mmu_is_nested(vcpu));
+	WARN_ON_ONCE(mmu_is_nested(vcpu));
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 
@@ -260,7 +260,7 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 		int bit_nr = svm_msrpm_bit_nr(merge_msrs[i]);
 		u32 offset;
 
-		if (WARN_ON(bit_nr < 0))
+		if (WARN_ON_ONCE(bit_nr < 0))
 			return -EIO;
 
 		/*
@@ -277,7 +277,7 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 		if (j < nested_svm_nr_msrpm_merge_offsets)
 			continue;
 
-		if (WARN_ON(j >= ARRAY_SIZE(nested_svm_msrpm_merge_offsets)))
+		if (WARN_ON_ONCE(j >= ARRAY_SIZE(nested_svm_msrpm_merge_offsets)))
 			return -EIO;
 
 		nested_svm_msrpm_merge_offsets[j] = offset;
@@ -1065,7 +1065,7 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 
 	svm->nested.vmcb12_gpa = vmcb12_gpa;
 
-	WARN_ON(svm->vmcb == svm->nested.vmcb02.ptr);
+	WARN_ON_ONCE(svm->vmcb == svm->nested.vmcb02.ptr);
 
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
@@ -1716,7 +1716,7 @@ static void nested_svm_inject_exception_vmexit(struct kvm_vcpu *vcpu)
 			kvm_update_dr7(vcpu);
 		}
 	} else {
-		WARN_ON(ex->has_payload);
+		WARN_ON_ONCE(ex->has_payload);
 	}
 
 	nested_svm_vmexit(svm);
@@ -2123,7 +2123,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 {
-	if (WARN_ON(!is_guest_mode(vcpu)))
+	if (WARN_ON_ONCE(!is_guest_mode(vcpu)))
 		return true;
 
 	if (is_pae_paging(vcpu)) {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6427db390b1c..8cd0f1539829 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3007,7 +3007,7 @@ void sev_vm_destroy(struct kvm *kvm)
 	if (!sev_guest(kvm))
 		return;
 
-	WARN_ON(!list_empty(&sev->mirror_vms));
+	WARN_ON_ONCE(!list_empty(&sev->mirror_vms));
 
 	/*
 	 * If this is a mirror VM, remove it from the owner's list of a mirrors
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 487897ef11dd..c8e82debb7f4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1598,7 +1598,7 @@ static void svm_set_vintr(struct vcpu_svm *svm)
 	/*
 	 * The following fields are ignored when AVIC is enabled
 	 */
-	WARN_ON(kvm_vcpu_apicv_activated(&svm->vcpu));
+	WARN_ON_ONCE(kvm_vcpu_apicv_activated(&svm->vcpu));
 
 	svm_set_intercept(svm, INTERCEPT_VINTR);
 
@@ -1633,8 +1633,8 @@ static void svm_clear_vintr(struct vcpu_svm *svm)
 	if (is_guest_mode(&svm->vcpu)) {
 		svm->vmcb01.ptr->control.int_ctl &= ~V_IRQ_INJECTION_BITS_MASK;
 
-		WARN_ON((svm->vmcb->control.int_ctl & V_TPR_MASK) !=
-			(svm->nested.ctl.int_ctl & V_TPR_MASK));
+		WARN_ON_ONCE((svm->vmcb->control.int_ctl & V_TPR_MASK) !=
+			     (svm->nested.ctl.int_ctl & V_TPR_MASK));
 
 		svm->vmcb->control.int_ctl |= svm->nested.ctl.int_ctl &
 			V_IRQ_INJECTION_BITS_MASK;
@@ -2666,7 +2666,7 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 			err = kvm_set_cr8(vcpu, val);
 			break;
 		default:
-			WARN(1, "unhandled write to CR%d", cr);
+			WARN_ONCE(1, "unhandled write to CR%d", cr);
 			kvm_queue_exception(vcpu, UD_VECTOR);
 			return 1;
 		}
@@ -2688,7 +2688,7 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 			val = kvm_get_cr8(vcpu);
 			break;
 		default:
-			WARN(1, "unhandled read from CR%d", cr);
+			WARN_ONCE(1, "unhandled read from CR%d", cr);
 			kvm_queue_exception(vcpu, UD_VECTOR);
 			return 1;
 		}
@@ -2725,7 +2725,7 @@ static int cr_trap(struct kvm_vcpu *vcpu)
 		ret = kvm_set_cr8(vcpu, new_value);
 		break;
 	default:
-		WARN(1, "unhandled CR%d write trap", cr);
+		WARN_ONCE(1, "unhandled CR%d write trap", cr);
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
 	}
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..ec3bc441a0e6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -515,7 +515,7 @@ static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 
 static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 {
-	WARN_ON(mmu_is_nested(vcpu));
+	WARN_ON_ONCE(mmu_is_nested(vcpu));
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	nested_ept_new_eptp(vcpu);
@@ -1315,7 +1315,7 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
 	}
 
 	/* L2 should never have a VPID if VPID is disabled. */
-	WARN_ON(!enable_vpid);
+	WARN_ON_ONCE(!enable_vpid);
 
 	/*
 	 * VPID is enabled and in use by vmcs12.  If vpid12 is changing, then
@@ -1698,7 +1698,7 @@ static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx)
 	unsigned long val;
 	int i;
 
-	if (WARN_ON(!shadow_vmcs))
+	if (WARN_ON_ONCE(!shadow_vmcs))
 		return;
 
 	preempt_disable();
@@ -1733,7 +1733,7 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
 	unsigned long val;
 	int i, q;
 
-	if (WARN_ON(!shadow_vmcs))
+	if (WARN_ON_ONCE(!shadow_vmcs))
 		return;
 
 	vmcs_load(shadow_vmcs);
@@ -4978,7 +4978,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
 			kvm_set_dr(vcpu, 7, DR7_FIXED_1);
 		else
-			WARN_ON(kvm_set_dr(vcpu, 7, vmcs_readl(GUEST_DR7)));
+			WARN_ON_ONCE(kvm_set_dr(vcpu, 7, vmcs_readl(GUEST_DR7)));
 	}
 
 	/* Reload DEBUGCTL to ensure vmcs01 has a fresh FREEZE_IN_SMM value. */
@@ -5408,7 +5408,7 @@ static struct vmcs *alloc_shadow_vmcs(struct kvm_vcpu *vcpu)
 	 * doesn't support virtualization of VMCS shadowing, so vmcs01 should
 	 * always be the loaded VMCS.
 	 */
-	if (WARN_ON(loaded_vmcs != &vmx->vmcs01 || loaded_vmcs->shadow_vmcs))
+	if (WARN_ON_ONCE(loaded_vmcs != &vmx->vmcs01 || loaded_vmcs->shadow_vmcs))
 		return loaded_vmcs->shadow_vmcs;
 
 	loaded_vmcs->shadow_vmcs = alloc_vmcs(true);
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 2644add54b76..0f508015692b 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -187,7 +187,7 @@ static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
 		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
 	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
 
-	WARN(pi_test_sn(pi_desc), "PI descriptor SN field set before blocking");
+	WARN_ONCE(pi_test_sn(pi_desc), "PI descriptor SN field set before blocking");
 
 	old.control = READ_ONCE(pi_desc->control);
 	do {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..0038626f5486 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3089,7 +3089,7 @@ void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 	loaded_vmcs->vmcs = NULL;
 	if (loaded_vmcs->msr_bitmap)
 		free_page((unsigned long)loaded_vmcs->msr_bitmap);
-	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
+	WARN_ON_ONCE(loaded_vmcs->shadow_vmcs != NULL);
 }
 
 int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
@@ -4468,7 +4468,7 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	unsigned long cr0, cr3, cr4;
 
 	cr0 = read_cr0();
-	WARN_ON(cr0 & X86_CR0_TS);
+	WARN_ON_ONCE(cr0 & X86_CR0_TS);
 	vmcs_writel(HOST_CR0, cr0);  /* 22.2.3 */
 
 	/*
@@ -5537,7 +5537,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			 * STI and MOVSS blocking.
 			 */
 			if (is_icebp(intr_info))
-				WARN_ON(!skip_emulated_instruction(vcpu));
+				WARN_ON_ONCE(!skip_emulated_instruction(vcpu));
 
 			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			return 1;
@@ -5962,7 +5962,7 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 	if (!idt_v || (type != INTR_TYPE_HARD_EXCEPTION &&
 		       type != INTR_TYPE_EXT_INTR &&
 		       type != INTR_TYPE_NMI_INTR))
-		WARN_ON(!skip_emulated_instruction(vcpu));
+		WARN_ON_ONCE(!skip_emulated_instruction(vcpu));
 
 	/*
 	 * TODO: What about debug traps on tss switch?
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..a9be847d3cc2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -370,7 +370,7 @@ static int exception_type(int vector)
 {
 	unsigned int mask;
 
-	if (WARN_ON(vector > 31 || vector == NMI_VECTOR))
+	if (WARN_ON_ONCE(vector > 31 || vector == NMI_VECTOR))
 		return EXCPT_INTERRUPT;
 
 	mask = 1 << vector;
@@ -4907,7 +4907,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 		return X86EMUL_PROPAGATE_FAULT;
 
 	offset = addr & (PAGE_SIZE-1);
-	if (WARN_ON(offset + bytes > PAGE_SIZE))
+	if (WARN_ON_ONCE(offset + bytes > PAGE_SIZE))
 		bytes = (unsigned)PAGE_SIZE - offset;
 	ret = kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, val,
 				       offset, bytes);
@@ -5167,7 +5167,7 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	bytes -= handled;
 	val += handled;
 
-	WARN_ON(vcpu->mmio_nr_fragments >= KVM_MAX_MMIO_FRAGMENTS);
+	WARN_ON_ONCE(vcpu->mmio_nr_fragments >= KVM_MAX_MMIO_FRAGMENTS);
 	frag = &vcpu->mmio_fragments[vcpu->mmio_nr_fragments++];
 	frag->gpa = gpa;
 	if (write && bytes <= 8u) {
@@ -7042,7 +7042,7 @@ static int kvm_x86_check_processor_compatibility(void)
 	 * compatible, i.e. KVM should never perform a compatibility check on
 	 * an offline CPU.
 	 */
-	WARN_ON(!cpu_online(cpu));
+	WARN_ON_ONCE(!cpu_online(cpu));
 
 	if (__cr4_reserved_bits(cpu_has, c) !=
 	    __cr4_reserved_bits(cpu_has, &boot_cpu_data))
@@ -7783,7 +7783,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			vcpu->arch.nmi_injected = true;
 			kvm_x86_call(inject_nmi)(vcpu);
 			can_inject = false;
-			WARN_ON(kvm_x86_call(nmi_allowed)(vcpu, true) < 0);
+			WARN_ON_ONCE(kvm_x86_call(nmi_allowed)(vcpu, true) < 0);
 		}
 		if (vcpu->arch.nmi_pending)
 			kvm_x86_call(enable_nmi_window)(vcpu);
@@ -7800,7 +7800,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			if (likely(irq != -1)) {
 				kvm_queue_interrupt(vcpu, irq, false);
 				kvm_x86_call(inject_irq)(vcpu, false);
-				WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
+				WARN_ON_ONCE(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
 			} else {
 				kvm_warn_on_lost_irq(vcpu);
 			}
@@ -8470,8 +8470,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * KVM_DEBUGREG_WONT_EXIT again.
 	 */
 	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)) {
-		WARN_ON(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP);
-		WARN_ON(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH);
+		WARN_ON_ONCE(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP);
+		WARN_ON_ONCE(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH);
 		kvm_x86_call(sync_dirty_debug_regs)(vcpu);
 		kvm_update_dr0123(vcpu);
 		vcpu->arch.dr6 |= kvm_get_dr6_fixed_1(vcpu);
@@ -10038,7 +10038,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 
 	lockdep_assert_held(&kvm->slots_lock);
 
-	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
+	if (WARN_ON_ONCE(id >= KVM_MEM_SLOTS_NUM))
 		return ERR_PTR_USR(-EINVAL);
 
 	slot = id_to_memslot(slots, id);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cfe96962a4e4..99ba31aa5ef5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -348,7 +348,7 @@ static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
 static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
 {
 	if (vcpu->arch.l1_tsc_scaling_ratio != kvm_caps.default_tsc_scaling_ratio)
-		WARN_ON(adjustment < 0);
+		WARN_ON_ONCE(adjustment < 0);
 	adjustment = kvm_scale_tsc((u64) adjustment,
 				   vcpu->arch.l1_tsc_scaling_ratio);
 	adjust_tsc_offset_guest(vcpu, adjustment);
-- 
2.56.0.313.g2479322e68-goog

