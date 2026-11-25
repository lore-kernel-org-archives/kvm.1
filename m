Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622314;
	b=Q7QIr8WDiVZuVDyYDG/hnF3QYFUq3TDP5+DQOZarOZxN7mHgC3GgABHDofNVvx57GP3K
	 ovoI1BzblZN9eIXKhoraSbC+42Tv9NsHwgMWffpX814W3nrhmqReIV43x9GaToKZ0AGln
	 /4SS32+ZSLNulh8P7SEJPVLdhCBgTzm1ruf8mhxa2N7u9Ngnx93G267iqGuVwWl/TPBp4
	 rTYLppDGOnf/1AZ9gD3loPQ+b5wWgIHad6YegRnNVDLlR+PlW1t9uzmyGIbu2WXKHLiCH
	 OJkb+wAe7KOQ/Qsuh56r4thv3BR0wOUCb3n61JTYAdOTeqoR4BieV+f1ro5syv/RRmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622314;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=vx8QxYL7d+TDSakwDw4bpqj3m3BNoGgy5VWbf0qHx0s=;
	b=mSFMma3xhsPe/+iRkH4XMHphl5Ua/cecO2gJZBXyz/7fDo/fEA/skzToyjyOPSZsHJ7U
	 R+fS2b8KiXiRotAJnhceh5Mq/4e4j80Lpmy/sRjtxuL1EYH4sCMgnM9FWPuPDf/CVxz+c
	 FeVGzsh1IAGw4wTwJqcsYb92TS1y7c2GeTud2GGJwovH4AVACRx/oid3E36F1eZ2/7uQF
	 gA6Fwxmr+GcTSbgf87ossXjyyhdWkL5z+gvvaiE0wS76WWLoE5VqODP8OvQxPo3dsVM9h
	 ONBe31AhVFo1cNVjmL7G5r7mIQx1IRI5k9eC7r5em+DUxHO6OPAiREfznqoyNpoPEuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gaI51KGX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC6606A6B8
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89EC6606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gaI51KGX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795622312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vx8QxYL7d+TDSakwDw4bpqj3m3BNoGgy5VWbf0qHx0s=;
	b=gaI51KGX4h5X2qzMs2+xpjG7bXuxhg94ooXyNiYy99IdzjqfUtwmvxRQTgZrPx/Ek7p2+0
	vRFSitRwkbDbfoWrFPMGIpLshkqIK4TPoUbRCoG8tQO5RlIr9ypYLrzUYIxt3RSz2q33eX
	fmsgZIYjecVmC31qF7cKDcmZFXmAKuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-f1CKUIIoOY672_CLq3VEhw-1; Wed,
 25 Nov 2026 15:58:28 +0000
X-MC-Unique: f1CKUIIoOY672_CLq3VEhw-1
X-Mimecast-MFC-AGG-ID: f1CKUIIoOY672_CLq3VEhw_1795622307
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BCD91955F10;
	Wed, 25 Nov 2026 15:58:27 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08AD03001DBD;
	Wed, 25 Nov 2026 15:58:25 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v5 5/5] KVM: x86: nVMX: fix races in delivery of nested posted interrupts
Date: Wed, 25 Nov 2026 10:58:19 -0500
Message-ID: <20261125155819.408795-6-mlevitsk@redhat.com>
In-Reply-To: <20261125155819.408795-1-mlevitsk@redhat.com>
References: <20261125155819.408795-1-mlevitsk@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If a nested posted interrupt races with a L0 vm exit on a target vCPU,
that is reflected to L1, then this nestedf posted interrupt is currently
neither processed nor delivered to L1 as a regular interrupt.

Since it is not possible to know if APICv hardware has processed
the interrupt, opt to always process it a moment before nested VM exit.
(call vmx_complete_nested_posted_interrupt)

To ensure that vmx_deliver_nested_posted_interrupt and
vmx_complete_nested_posted_interrupt don't race do the following:

Have a cmpxchg based loop in vmx_deliver_nested_posted_interrupt that
atomically checks that target vCPU is in nested mode and has suitable
posted interrupt configuration, and then set KVM_NESTED_PI_PENDING.

If the above cmpxchg loop succeeds, this means that even if the target vCPU
is in process of exiting the nested guest, it will notice this
KVM_NESTED_PI_PENDING flag when it reaches its
vmx_complete_nested_posted_interrupt, and then it will process it.

If it fails, it means that the target vCPU is no longer in the guest
mode, and thus it is safe to deliver the interrupt as a normal interrupt.

Apply a similar logic on the receiving side:
Use xchg to snapshot the old value of guest state in leave_guest_mode,
and by using this snapshot, determine if we need to process
the posted interrupts.

Also delay publish to of the nested posted interrupt state to
KVM_REQ_GET_NESTED_STATE_PAGES to avoid dealing with a situation where
vm exit causes a L2->L2 vm exit before nested APICv pages were mapped.

Fixes: 705699a13994 ("KVM: nVMX: Enable nested posted interrupt processing")

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/regs.h       |  5 ++--
 arch/x86/kvm/vmx/nested.c | 63 ++++++++++++++++++++++++++-------------
 arch/x86/kvm/vmx/vmx.c    | 60 ++++++++++++++++++-------------------
 3 files changed, 76 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index b36254db1b8f..4a507e15134b 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -461,9 +461,9 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 	vcpu->stat.guest_mode = 1;
 }
 
-static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
+static inline int leave_guest_mode(struct kvm_vcpu *vcpu)
 {
-	atomic_set(&vcpu->arch.nested_guest_state, 0);
+	int old_value = atomic_xchg(&vcpu->arch.nested_guest_state, 0);
 
 	if (vcpu->arch.load_eoi_exitmap_pending) {
 		vcpu->arch.load_eoi_exitmap_pending = false;
@@ -471,6 +471,7 @@ static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 	}
 
 	vcpu->stat.guest_mode = 0;
+	return old_value;
 }
 
 static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1b4483dd6354..220ef40d4cb1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3434,7 +3434,18 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
 }
 #endif
 
-static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+static void nested_vmx_enable_posted_interrupts(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	WARN_ON_ONCE(vmcs12->posted_intr_nv & ~KVM_NESTED_PI_VECTOR_MASK);
+
+	atomic_or(KVM_NESTED_PI_ACTIVE |
+		 (vmcs12->posted_intr_nv & KVM_NESTED_PI_VECTOR_MASK),
+		  &vcpu->arch.nested_guest_state);
+}
+
+static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu, bool from_vmentry)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3513,6 +3524,9 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 			vmx->nested.pi_desc = NULL;
 			pin_controls_clearbit(vmx, PIN_BASED_POSTED_INTR);
 		}
+
+		if (!from_vmentry)
+			nested_vmx_enable_posted_interrupts(vcpu);
 	}
 	if (nested_vmx_prepare_msr_bitmap(vcpu, vmcs12))
 		exec_controls_setbit(vmx, CPU_BASED_USE_MSR_BITMAPS);
@@ -3543,7 +3557,7 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	}
 #endif
 
-	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu))
+	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu, false))
 		return false;
 
 	return true;
@@ -3674,7 +3688,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	prepare_vmcs02_early(vmx, &vmx->vmcs01, vmcs12);
 
 	if (from_vmentry) {
-		if (unlikely(!nested_get_vmcs12_pages(vcpu))) {
+		if (unlikely(!nested_get_vmcs12_pages(vcpu, true))) {
 			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
 		}
@@ -3704,6 +3718,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 			vmcs12->exit_qualification = failed_index;
 			goto vmentry_fail_vmexit_guest_mode;
 		}
+
+		if (nested_cpu_has_posted_intr(vmcs12))
+			nested_vmx_enable_posted_interrupts(vcpu);
 	} else {
 		/*
 		 * The MMU is not initialized to point at the right entities yet and
@@ -3715,9 +3732,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 	}
 
-	if (nested_cpu_has_posted_intr(vmcs12))
-		atomic_or(KVM_NESTED_PI_ACTIVE | vmcs12->posted_intr_nv,
-			  &vcpu->arch.nested_guest_state);
 	/*
 	 * Re-evaluate pending events if L1 had a pending IRQ/NMI/INIT/SIPI
 	 * when it executed VMLAUNCH/VMRESUME, as entering non-root mode can
@@ -4024,22 +4038,15 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 	}
 }
 
-static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
+static int __vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
 	void *vapic_page;
 	u16 status;
 
-	int nested_state = atomic_read(&vcpu->arch.nested_guest_state);
-
-	if (!(nested_state & KVM_NESTED_PI_PENDING))
-		return 0;
-
 	if (!vmx->nested.pi_desc)
-		goto mmio_needed;
-
-	atomic_andnot(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
+		return -ENXIO;
 
 	/*
 	 * Don't test the value of PID.ON.
@@ -4056,7 +4063,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (max_irr > 0) {
 		vapic_page = vmx->nested.virtual_apic_map.hva;
 		if (!vapic_page)
-			goto mmio_needed;
+			return -ENXIO;
 
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
 			vapic_page, &max_irr);
@@ -4071,10 +4078,22 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.virtual_apic_map);
 	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.pi_desc_map);
 	return 0;
+}
+
+static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
+{
+	int nested_state = atomic_read(&vcpu->arch.nested_guest_state);
+	int ret;
 
-mmio_needed:
-	kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
-	return -ENXIO;
+	if (!(nested_state & KVM_NESTED_PI_PENDING))
+		return 0;
+
+	atomic_andnot(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
+
+	ret = __vmx_complete_nested_posted_interrupt(vcpu);
+	if (ret == -ENXIO)
+		kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
+	return ret;
 }
 
 static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
@@ -5089,6 +5108,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+	int old_nested_state;
 
 	/* Pending MTF traps are discarded on VM-Exit. */
 	vmx->nested.mtf_pending = false;
@@ -5120,7 +5140,10 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	if (enable_ept && is_pae_paging(vcpu))
 		vmx_ept_load_pdptrs(vcpu);
 
-	leave_guest_mode(vcpu);
+	old_nested_state = leave_guest_mode(vcpu);
+
+	if (old_nested_state & KVM_NESTED_PI_PENDING)
+		__vmx_complete_nested_posted_interrupt(vcpu);
 
 	if (nested_cpu_has_preemption_timer(vmcs12))
 		hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e6dd37a3ac44..4a5adb1507ce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4370,41 +4370,41 @@ void vmx_recalc_intercepts(struct kvm_vcpu *vcpu)
 static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 						int vector)
 {
-	int nested_state = atomic_read(&vcpu->arch.nested_guest_state);
+	int old = atomic_read(&vcpu->arch.nested_guest_state);
+
+	while (true) {
+		if ((old & (KVM_NESTED_PI_ACTIVE | KVM_NESTED_PI_VECTOR_MASK)) !=
+		    (KVM_NESTED_PI_ACTIVE | vector))
+			return -1;
+
+		WARN_ON_ONCE(!(old & KVM_NESTED_IN_GUEST));
+
+		if (atomic_try_cmpxchg(&vcpu->arch.nested_guest_state,
+		    &old, old | KVM_NESTED_PI_PENDING))
+			break;
+	}
 
 	/*
-	 * DO NOT query the vCPU's vmcs12, as vmcs12 is dynamically allocated
-	 * and freed, and must not be accessed outside of vcpu->mutex.  The
-	 * vCPU's cached PI NV is valid if and only if posted interrupts
-	 * enabled in its vmcs12, i.e. checking the vector also checks that
-	 * L1 has enabled posted interrupts for L2.
+	 * If a posted intr is not recognized by hardware,
+	 * we will accomplish it in the next vmentry.
 	 */
-	if (is_guest_mode(vcpu) &&
-	    vector == (nested_state & KVM_NESTED_PI_VECTOR_MASK)) {
-		/*
-		 * If a posted intr is not recognized by hardware,
-		 * we will accomplish it in the next vmentry.
-		 */
-		atomic_or(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
-		kvm_make_request(KVM_REQ_EVENT, vcpu);
+	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
-		/*
-		 * This pairs with the smp_mb_*() after setting vcpu->mode in
-		 * vcpu_enter_guest() to guarantee the vCPU sees the event
-		 * request if triggering a posted interrupt "fails" because
-		 * vcpu->mode != IN_GUEST_MODE.  The extra barrier is needed as
-		 * the smb_wmb() in kvm_make_request() only ensures everything
-		 * done before making the request is visible when the request
-		 * is visible, it doesn't ensure ordering between the store to
-		 * vcpu->requests and the load from vcpu->mode.
-		 */
-		smp_mb__after_atomic();
+	/*
+	 * This pairs with the smp_mb_*() after setting vcpu->mode in
+	 * vcpu_enter_guest() to guarantee the vCPU sees the event
+	 * request if triggering a posted interrupt "fails" because
+	 * vcpu->mode != IN_GUEST_MODE.  The extra barrier is needed as
+	 * the smb_wmb() in kvm_make_request() only ensures everything
+	 * done before making the request is visible when the request
+	 * is visible, it doesn't ensure ordering between the store to
+	 * vcpu->requests and the load from vcpu->mode.
+	 */
+	smp_mb__after_atomic();
 
-		/* the PIR and ON have been set by L1. */
-		kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR);
-		return 0;
-	}
-	return -1;
+	/* the PIR and ON have been set by L1. */
+	kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR);
+	return 0;
 }
 /*
  * Send interrupt to vcpu via posted interrupt way.
-- 
2.56.1

