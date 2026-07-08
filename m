Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB43DB31B;
	Wed,  8 Jul 2026 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492495; cv=none; b=rorZEr7D4k07AxzFgDtIVhX2VXHpcnDnfnWMGue49kiUg/80+f1qrz8n4I4/FBHPl25dS8CN1u5tH8Vb1pmcgM63txJDKuT2SFN+cTuoe6Cmt4At7Qub0lOSIZSnCirTM0uIHUuAa+DNGa2QmVjOOemDpMEFco3TuSlvZkf0WkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492495; c=relaxed/simple;
	bh=cLUY83AdywRpz1vwBhqcik98HF96D5Ch4IllhbubAwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YekrO9jeIpn9848+0o+3RSaj3cd3uRjIVwl0/MwqELMv0ro8mjfzGihNh2XaDudLACMu2AE3Vflpsb7Vlf7VZfOqyN4SnMSSlqyvExOT9fc04ygU9x13/HZqLinhNwSXnI3j75kV1XFCSeHRfNrBZIiOAxx5S00reWFouQWcGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uynyf3GB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uynyf3GB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D5C1F00A3D;
	Wed,  8 Jul 2026 06:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492493;
	bh=SUZVO3ZHNiszhnSmeVluxGIbAwh93Dn3RyYcPofagKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uynyf3GBrRhmSer2N0MH5mEUbc26H3y0cINPlkhC2wWxcTPR2uQSvWIyJzaFvig3V
	 mE8qLtbkZuhkRd9WzxwL36bGg0Y6zQezUcv1dtseoeNvO5BrOI9BcAUbJdlxdUVz/R
	 MDBBJ1mPBlhffQKo7QLYDUUlxryOl+3RGD3g8DIPIX9r1uNvJbdflfGL6PAT+XXSec
	 WGC29rWeSW8VQLRoTSAZhQtrcDDqLPB9Rl328D4/BQ5jipXSMHrDGJwawriWWD0V6/
	 50oTMBWxOS0D2XjSMC1g/fpTKx+KZVYVJHDxNPhQO7T3htBYDD8vQb1Jz2plQ5qMG5
	 iEd3XCXwum+RA==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 21/27] KVM: SVM: Add interrupt delivery support for Secure AVIC guests
Date: Wed,  8 Jul 2026 12:02:19 +0530
Message-ID: <46920d50baf7a8a333579beda6f6b2645b5ee4cd.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To inject an interrupt into a Secure AVIC enabled guest, KVM needs to:
- set the vector in VMCB->requested_irr (VMCB offset 0x150), which is a
  contiguous 256-bit field representing vectors that the hypervisor
  wants to inject into the guest.
- set VMCB->update_irr (VMCB offset 0x134) so hardware knows to process
  requested_irr from the VMCB, and
- invoke VMRUN.

As the field name suggests, KVM can only "request" for interrupts to be
injected into the guest.  Guest is free to ignore vectors it does not
want to accept from the hypervisor, and it controls which vectors are
actually accepted by setting up allowed_irr field in its private APIC
backing page (8 32-bit APIC registers following APIC_IRR in the backing
page).

On VMRUN, hardware updates APIC_IRR in the private guest APIC backing
page based on update_irr/requested_irr in the VMCB and allowed_irr in
the guest APIC backing page, and then clears VMCB fields update_irr and
requested_irr.

Because hardware clears requested_irr and update_irr in the VMCB on
VMRUN in no particular order, KVM can't stuff incoming vectors directly
into the VMCB fields. Instead, park vectors to be injected into the
guest in KVM's copy of the APIC_IRR (already done in the default flow in
svm_deliver_interrupt()).

Since Secure AVIC requires interrupts to be injected through the VMCB,
do not use AVIC doorbells for interrupt delivery. Instead rely on the
non-AVIC flow in svm_complete_interrupt_delivery() to set KVM_REQ_EVENT
and kick the vCPU.

Before VM entry, KVM invokes svm_inject_irq() (since APIC_IRR has
vectors to be injected, and since kvm_cpu_has_injectable_intr() returns
true), at which point transfer all pending interrupt vectors from KVM's
APIC_IRR to VMCB->requested_irr and set VMCB->update_irr.  Atomically
clear APIC_IRR so that incoming interrupt vectors are not lost. Also
update vCPU irq_injection stats and optionally invoke the corresponding
tracepoint if enabled (its debatable whether kvm_apicv_accept_irq
tracepoint should be invoked instead).

Finally, always return true for interrupt_allowed() since KVM has no
visibility into the guest APIC state and KVM can simply pend interrupts
in requested_irr at any point. Return early from svm_enable_irq_window()
for the same reason -- KVM has no visibility into that.

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/include/asm/svm.h |  7 +++++--
 arch/x86/kvm/svm/svm.h     |  2 ++
 arch/x86/kvm/svm/sev.c     | 27 +++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c     | 25 ++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 5857b942957b..b4a803686e0b 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -162,10 +162,13 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u64 vmsa_pa;		/* Used for an SEV-ES guest */
 	u8 reserved_8[16];
 	u16 bus_lock_counter;		/* Offset 0x120 */
-	u8 reserved_9[22];
+	u8 reserved_9[18];
+	u32 update_irr;			/* Offset 0x134 */
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_10[664];
+	u8 reserved_10[8];
+	u32 requested_irr[8];           /* Offset 0x150 */
+	u8 reserved_11[624];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f5e270086b51..44f1d25a167c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1019,6 +1019,7 @@ void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa)
 bool snp_is_secure_avic_enabled(struct kvm *kvm);
 bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu);
 bool snp_protected_apic_has_interrupt(struct kvm_vcpu *vcpu);
+void savic_update_requested_irr(struct kvm_vcpu *vcpu);
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1059,6 +1060,7 @@ static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_sa
 static inline bool snp_is_secure_avic_enabled(struct kvm *kvm) { return false; }
 static inline bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu) { return false; }
 static inline bool snp_protected_apic_has_interrupt(struct kvm_vcpu *vcpu) { return false; }
+static inline void savic_update_requested_irr(struct kvm_vcpu *vcpu) {}
 #endif
 
 /* vmenter.S */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a0c5271ec4ca..754fe12c2f82 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4428,6 +4428,33 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 	return 0;
 }
 
+void savic_update_requested_irr(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	u32 *apic_irr, irr;
+
+	for (int i = 0; i < APIC_ISR_NR; i++) {
+		apic_irr = (u32 *)(vcpu->arch.apic->regs + APIC_IRR + i * 0x10);
+
+		if (!READ_ONCE(*apic_irr))
+			continue;
+
+		irr = xchg(apic_irr, 0);
+		svm->vmcb->control.requested_irr[i] |= irr;
+		vcpu->stat.irq_injections += hweight32(irr);
+
+		if (trace_kvm_inj_virq_enabled()) {
+			unsigned long irr_injected = irr;
+			unsigned int vector;
+
+			for_each_set_bit(vector, &irr_injected, BITS_PER_TYPE(irr))
+				trace_kvm_inj_virq(i * 32 + vector, false, false);
+		}
+	}
+
+	WRITE_ONCE(svm->vmcb->control.update_irr, 1);
+}
+
 static int sev_handle_savic_vmgexit(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *target_vcpu;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3f731483f6a2..612cc4ac9bd2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3824,6 +3824,11 @@ static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 type;
 
+	if (snp_is_secure_avic_enabled(vcpu->kvm)) {
+		savic_update_requested_irr(vcpu);
+		return;
+	}
+
 	if (intr->soft) {
 		if (svm_update_soft_interrupt_rip(vcpu, intr->nr))
 			return;
@@ -3896,7 +3901,7 @@ void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
 	bool in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);
 
 	/* Note, this is called iff the local APIC is in-kernel. */
-	if (!READ_ONCE(vcpu->arch.apic->apicv_active)) {
+	if (!READ_ONCE(vcpu->arch.apic->apicv_active) || snp_is_secure_avic_enabled(vcpu->kvm)) {
 		/* Process the interrupt via kvm_check_and_inject_events(). */
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 		kvm_vcpu_kick(vcpu);
@@ -4050,6 +4055,14 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * KVM does not have access to the Secure AVIC guest APIC backing page.
+	 * The only thing KVM can do is to queue up interrupts in the VMCB
+	 * (Requested_IRR), which is always allowed.
+	 */
+	if (snp_is_secure_avic_enabled(vcpu->kvm))
+		return 1;
+
 	if (svm_interrupt_blocked(vcpu))
 		return 0;
 
@@ -4070,6 +4083,16 @@ static void svm_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * Secure AVIC does not allow VINTR, so we can't request an interrupt
+	 * window. The only reason we end up here is if an interrupt arrived
+	 * just as we injected pending interrupts (from
+	 * kvm_check_and_inject_events()). Ignore and proceed, any pending
+	 * interrupt(s) will be re-injected on next entry.
+	 */
+	if (snp_is_secure_avic_enabled(vcpu->kvm))
+		return;
+
 	/*
 	 * In case GIF=0 we can't rely on the CPU to tell us when GIF becomes
 	 * 1, because that's a separate STGI/VMRUN intercept.  The next time we
-- 
2.54.0

