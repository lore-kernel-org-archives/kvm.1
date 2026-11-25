Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622312;
	b=pWRE7sen9s7blZsQqmAvXtHyQNMTiCo6uR9xm3XK50Gacoa9wYm4fwZYwrjXwViR39pi
	 i8qHfPjou2/6JS6hPhHoBrCahdUQY7MjkKRE3ro/CyMyLJfodqzriSSkCOgwA/JfSgeR5
	 bg7X8hvsCak3z/xh/JRyGRLBVdb37fpb9ihQQxlKEWpj6lQHBe07yLRaO6/9pkV0DPNsY
	 JSceT9yQ8/ZeiKV9Tmhkud1qISrdTLTFP5cFQ2F3NZDIUbfgFGCmw/xJOj7g6hNUlxr3N
	 ROYp0LVrIiDXeDryU43Ut9Pbqh9Hcdf0cSYjBfTROf7mWELRUBvRxEETuppJDUKJqAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622312;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=yPBfEKahhfYei6glmdPdejVYAgGYQtYkDSj3W5f5X7s=;
	b=GdyUpMgrfkiTZ7TCli2hFt9uq6TKbCufO8UgzB1+kgSS4HebjdTVcEBMYd6rHHC53Lbg
	 fhf7OEBbL+3XqHPusSHHWehMWqISkgo1k5BHppjljR3bMCAw7YcHVOaRmFRdzqx5rysvH
	 l1sTiruG2wGZoH7ZyD0N7KnOwXQj0GcFnI2dfKAAgz4pFWdb0JpffwISLiBJEiR9LRSMX
	 TTnP0q2odGO2XOTnLU1Do85ISFg3JCzAlhP3f6+3o6PTUSoaT2ywRk2mGhG9tCTJndKsU
	 VX5N+V/3PeftJ5EIETo7Hz5Ep7uARPEYkbQU574wYrDEsfXbH31/2d9ysB70POxCGNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZGvvaUA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6809606A69A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6809606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZGvvaUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795622311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPBfEKahhfYei6glmdPdejVYAgGYQtYkDSj3W5f5X7s=;
	b=dZGvvaUAt+oskmw8jL8EigWCnBJGGkDtWcjPJFZghbJn8zBbx6BVTlKGiswwX7pPZmcPRf
	coDj8Xs/lkmWIdYojBsaseuJDhPlBjz/krx/PeU4DWbunFBz/wILEkXXmrSSZcPyNLuoku
	2IFdvVi5W6qUrldXBc62/3hD9qO/cHA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-llluhFTaNsSqw3KHF2SPZg-1; Wed,
 25 Nov 2026 15:58:26 +0000
X-MC-Unique: llluhFTaNsSqw3KHF2SPZg-1
X-Mimecast-MFC-AGG-ID: llluhFTaNsSqw3KHF2SPZg_1795622305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C99F9195604E;
	Wed, 25 Nov 2026 15:58:25 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEE223001DB7;
	Wed, 25 Nov 2026 15:58:24 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v5 4/5] KVM: x86: nVMX: move nested APICv state to nested_guest_state
Date: Wed, 25 Nov 2026 10:58:18 -0500
Message-ID: <20261125155819.408795-5-mlevitsk@redhat.com>
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

Replace vmx->nested.pi_pending,pi_active and posted_intr_nv with
KVM_NESTED_PI_VECTOR_MASK,KVM_NESTED_PI_ACTIVE,KVM_NESTED_PI_PENDING
flags of nested_guest_state.

Since the nested state is cleared as a whole to 0, on each nested VM exit,
explicit clearing of vmx->nested.posted_intr_nv and vmx->nested.pi_pending
was dropped.

Also, since nested entry sets nested_guest_state to KVM_NESTED_IN_GUEST,
the publishing of KVM_NESTED_PI_VECTOR_MASK,KVM_NESTED_PI_ACTIVE is delayed
to happen after enter_guest_mode().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  5 ++++-
 arch/x86/kvm/vmx/nested.c       | 33 +++++++++++++++++++--------------
 arch/x86/kvm/vmx/vmx.c          |  7 +++----
 arch/x86/kvm/vmx/vmx.h          |  2 --
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 78fcc7fcece7..43acc724b8e4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -757,7 +757,10 @@ struct kvm_vcpu_arch {
 	u64 arch_capabilities;
 	u64 perf_capabilities;
 
-#define KVM_NESTED_IN_GUEST	BIT(8)
+#define KVM_NESTED_PI_VECTOR_MASK	0xFF
+#define KVM_NESTED_IN_GUEST		BIT(8)
+#define KVM_NESTED_PI_ACTIVE		BIT(9)
+#define KVM_NESTED_PI_PENDING		BIT(10)
 	/* Non zero when the guest is executing a nested guest */
 	atomic_t nested_guest_state;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bff719dce07d..1b4483dd6354 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -351,7 +351,6 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
 	free_vpid(vmx->nested.vpid02);
-	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
 	if (enable_shadow_vmcs) {
 		vmx_disable_shadow_vmcs(vmx);
@@ -2445,13 +2444,9 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 			 ~PIN_BASED_VMX_PREEMPTION_TIMER);
 
 	/* Posted interrupts setting is only taken from vmcs12.  */
-	vmx->nested.pi_pending = false;
-	if (nested_cpu_has_posted_intr(vmcs12)) {
-		vmx->nested.posted_intr_nv = vmcs12->posted_intr_nv;
-	} else {
-		vmx->nested.posted_intr_nv = -1;
+	if (!nested_cpu_has_posted_intr(vmcs12))
 		exec_control &= ~PIN_BASED_POSTED_INTR;
-	}
+
 	pin_controls_set(vmx, exec_control);
 
 	/*
@@ -3720,6 +3715,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 	}
 
+	if (nested_cpu_has_posted_intr(vmcs12))
+		atomic_or(KVM_NESTED_PI_ACTIVE | vmcs12->posted_intr_nv,
+			  &vcpu->arch.nested_guest_state);
 	/*
 	 * Re-evaluate pending events if L1 had a pending IRQ/NMI/INIT/SIPI
 	 * when it executed VMLAUNCH/VMRESUME, as entering non-root mode can
@@ -4033,13 +4031,15 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	void *vapic_page;
 	u16 status;
 
-	if (!vmx->nested.pi_pending)
+	int nested_state = atomic_read(&vcpu->arch.nested_guest_state);
+
+	if (!(nested_state & KVM_NESTED_PI_PENDING))
 		return 0;
 
 	if (!vmx->nested.pi_desc)
 		goto mmio_needed;
 
-	vmx->nested.pi_pending = false;
+	atomic_andnot(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
 
 	/*
 	 * Don't test the value of PID.ON.
@@ -4191,6 +4191,8 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 	void *vapic = vmx->nested.virtual_apic_map.hva;
 	int max_irr, vppr;
 
+	int nested_state = atomic_read(&vcpu->arch.nested_guest_state);
+
 	if (nested_vmx_preemption_timer_pending(vcpu) ||
 	    vmx->nested.mtf_pending)
 		return true;
@@ -4217,7 +4219,7 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 	if ((max_irr & 0xf0) > (vppr & 0xf0))
 		return true;
 
-	if (vmx->nested.pi_pending && vmx->nested.pi_desc) {
+	if ((nested_state & KVM_NESTED_PI_PENDING) && vmx->nested.pi_desc) {
 		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
 		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
 			return true;
@@ -4448,7 +4450,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	}
 
 	if (kvm_cpu_has_interrupt(vcpu) && !vmx_interrupt_blocked(vcpu)) {
-		int irq;
+		int irq, nested_state;
 
 		if (!nested_exit_on_intr(vcpu)) {
 			if (block_nested_events)
@@ -4481,6 +4483,8 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 			goto no_vmexit;
 		}
 
+		nested_state = atomic_read(&vcpu->arch.nested_guest_state);
+
 		/*
 		 * If the IRQ is L2's PI notification vector, process posted
 		 * interrupts for L2 instead of injecting VM-Exit, as the
@@ -4489,7 +4493,8 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		 * through the local APIC trigger posted interrupt processing,
 		 * and enabling posted interrupts requires ACK-on-exit.
 		 */
-		if (irq == vmx->nested.posted_intr_nv) {
+		if ((nested_state & KVM_NESTED_PI_ACTIVE) &&
+			((nested_state & KVM_NESTED_PI_VECTOR_MASK) == irq)) {
 			/*
 			 * Nested posted interrupts are delivered via RVI, i.e.
 			 * aren't injected by KVM, and so can be queued even if
@@ -4498,7 +4503,8 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 			if (block_non_injected_events)
 				return -EBUSY;
 
-			vmx->nested.pi_pending = true;
+			atomic_or(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
+
 			kvm_apic_clear_irr(vcpu, irq);
 			goto no_vmexit;
 		}
@@ -5587,7 +5593,6 @@ static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
 		copy_shadow_to_vmcs12(vmx);
 		vmx_disable_shadow_vmcs(vmx);
 	}
-	vmx->nested.posted_intr_nv = -1;
 
 	/* Flush VMCS12 to guest memory */
 	kvm_vcpu_write_guest_page(vcpu,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..e6dd37a3ac44 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4370,7 +4370,7 @@ void vmx_recalc_intercepts(struct kvm_vcpu *vcpu)
 static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 						int vector)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int nested_state = atomic_read(&vcpu->arch.nested_guest_state);
 
 	/*
 	 * DO NOT query the vCPU's vmcs12, as vmcs12 is dynamically allocated
@@ -4380,12 +4380,12 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 	 * L1 has enabled posted interrupts for L2.
 	 */
 	if (is_guest_mode(vcpu) &&
-	    vector == vmx->nested.posted_intr_nv) {
+	    vector == (nested_state & KVM_NESTED_PI_VECTOR_MASK)) {
 		/*
 		 * If a posted intr is not recognized by hardware,
 		 * we will accomplish it in the next vmentry.
 		 */
-		vmx->nested.pi_pending = true;
+		atomic_or(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 		/*
@@ -5019,7 +5019,6 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 
 	vcpu_setup_sgx_lepubkeyhash(vcpu);
 
-	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
 	vmx->nested.current_vmptr = INVALID_GPA;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..0632cd8908b3 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -151,8 +151,6 @@ struct nested_vmx {
 	struct kvm_host_map pi_desc_map;
 
 	struct pi_desc *pi_desc;
-	bool pi_pending;
-	u16 posted_intr_nv;
 
 	struct hrtimer preemption_timer;
 	u64 preemption_timer_deadline;
-- 
2.56.1

