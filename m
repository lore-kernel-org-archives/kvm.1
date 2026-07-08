Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA383DEAD8;
	Wed,  8 Jul 2026 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492567; cv=none; b=mnNS7H+70KyFx+UhsJTJ7602DGND96xE41KEv9zNDpvPNsPcpdEzYXnw6F+8wmXvMzoih4OBsARyCFGzqCxVNf/jOCedOjB8ntwp9tyCRgxBfXmB5/swR4SCGWisNbjH74ov8ulUbDpIi4CLkxB6lPy0bu4NtRVyqCueKP50piQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492567; c=relaxed/simple;
	bh=suLKObQ8cwo/2+4uOP/QPmtmMtIqG1IdGMv0tjp5F0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ten/8c5M7bVNF4rEshoy/uZUlbRkcjorTwxrf/y59NThDL5bhbwmRTHiYw0wizjxFaWE2fPJuCheP1CJ91rZpWZHeuNS7zVgljihkXhuOAznfzzUO9QqAiNqJcwBq7wj0EuY21mguu83sEAPz/cJZ4aoriYnB37fBp6Q28VufDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8bh75jH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8bh75jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5F11F000E9;
	Wed,  8 Jul 2026 06:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492565;
	bh=LUci1eeIGZR60x9RRa+kO3ISSiYMQFtTFiPjzT4W8Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n8bh75jHX9MRylqsw0Yaa0Q3H6kruoLcgH4Jti8+QFkVQ9iOAkS4y6avye9Vv6kj6
	 Rz9t8B0c5xbyP+z1wQS6yj8gu13w2Hwv9h9hOQBefIiSeB9wJ0nQc8OWmgMP6CixSX
	 aq/jcwGVOlKoYCtSV5cM/gUWYmZ6jLAyvOjeeogtMIbLgQfZD1lvCt2/FYESE7+/+k
	 JbBlnxtkvYqX65d+9V8R5mpjaJ6xQzSz4KztMt1mOyTMY7THdKu13kd8bCUMnHgSAY
	 R7IEk3L5Yqmj6+zWVYxSfshgXQ8tlMRkTuSEjTxciGU38HOmauKRotpmsB80hTUtj+
	 nIXxwh7vl6eEA==
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
Subject: [RFC PATCH v3 22/27] KVM: SVM: Add support for incomplete IPI handling for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:20 +0530
Message-ID: <7dc2e50818a41e345ce84a7773fc373d2a8ba363.1783490022.git.naveen@kernel.org>
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

Secure AVIC hardware accelerates self IPIs, i.e., on WRMSR to
APIC_SELF_IPI and to APIC_ICR with destination shorthand APIC_DEST_SELF,
hardware updates IRR in the guest APIC backing page of the vCPU,
re-evaluates interrupt state and injects an interrupt if it can be taken
right-away. All other APIC_ICR writes result in a #VC, and the guest
software needs to take care of delivering the IPI to the target vCPU(s).

Guests can choose to handle IPIs in one of two ways:
1. Delegate full IPI handling to the hypervisor by invoking SVM_EXIT_MSR
   VMGEXIT, in which case the guest will need to allow the IPI vector to
   be injected by the hypervisor by updating allowed_irr in the guest
   APIC backing page. Hypervisor follows regular interrupt injection
   flow for delivering the IPIs.
2. Handle updating APIC_IRR in the APIC backing page of the target
   vCPU(s), and rely on the hypervisor only to notify/wake up the target
   vCPU(s). In this scenario, hypervisor can use the AVIC doorbell for
   accelerated IPI delivery. This allows guest to forbid IPI injection
   from the untrusted hypervisor, and this is the model adopted by the
   Linux guest.

Note: for (2), since guest does _not_ set the IPI vector in allowed_irr
in its backing page, even if the hypervisor tries to inject it via
VMCB->requested_irr, hardware does not set these vectors in the guest
APIC_IRR. This ensures that the hypervisor can never inject an IPI into
the guest.

(1) is handled by the stock interrupt delivery flow:
  kvm_lapic_set_irr()
   \-->  KVM_REQ_EVENT, kvm_vcpu_kick()
          \--> VMCB->requested_irr/update_irr
		\--> VMRUN

For (2), guest updates APIC_IRR in the APIC backing page of the target
vCPU(s) and issues AVIC_INCOMPLETE_IPI VMGEXIT requesting KVM to notify
the target vCPU(s). Wire up SEV code to enable and process
AVIC_INCOMPLETE_IPI as a valid exit code for VMGEXIT. Update AVIC
incomplete ipi handling to accept and process unaccelerated Secure AVIC
exit ID similar to SVM AVIC handling for TARGET_NOT_RUNNING.

For AVIC_INCOMPLETE_IPI exits from a Secure AVIC guest, KVM can use an
AVIC doorbell to notify the physical CPU running the target vCPU. This
results in Secure AVIC hardware re-evaluating the private guest APIC
backing page and delivering pending interrupts to the vCPU. This is
distinct from device interrupts being injected by KVM, which require
injection through VMCB. To distinguish the two, update
svm_complete_interrupt_delivery() to only kick the target vCPU if there
is an _injectable_ interrupt pending in KVM's APIC_IRR. Otherwise, take
the SVM AVIC path and send an AVIC doorbell or wake up the vCPU if it
was blocking.

Ensuring IPI Delivery:
=====================
A problem unique to IPI handling described in (2) is KVM's complete lack
of visibility into whether the IPI has been processed by the target vCPU
or not. As an example, if the target vCPU is exiting, the source vCPU
may observe it to still be IN_GUEST_MODE (between #VMEXIT and when KVM
actually updates guest vCPU mode) and choose to send an AVIC doorbell.
However, since the vCPU was in the process of exiting, the doorbell has
no effect and the source vCPU has no feedback on this.  Furthermore,
since KVM has no visibility into the guest private APIC backing page,
there is no way to know if the IPI was processed or not (or if there is
anything pending in APIC_IRR in the guest private APIC backing page). In
the absence of any other event, the target vCPU will exit and block
since protected_apic_has_interrupt() only checks KVM's APIC_IRR which in
this case won't have the IPI vector set.

Since there is no support from hardware to address this, add a flag in
vcpu_svm structure 'snp_savic_has_pending_ipi' to track pending IPIs for
a specific vCPU. Set this flag on the target vCPU in avic_kick_vcpu()
and update snp_protected_apic_has_interrupt() to check this flag for
pending IPIs - this ensures that KVM will never allow a vCPU to block if
it has pending IPIs. Clear this flag unconditionally before VMRUN (in
pre_sev_run()) since VM entry guarantees that the guest private APIC
backing page will be re-evaluated and pending interrupts queued.

Use smp_mb() in avic_kick_vcpu() and snp_protected_apic_has_interrupt()
to order accesses to vcpu->mode and snp_savic_has_pending_ipi
(load-store ordering):

Source vCPU (AVIC_INCOMPLETE_IPI):
  avic_kick_vcpu():
    WRITE_ONCE(snp_savic_has_pending_ipi, 1);
    smp_mb();
    svm_complete_interrupt_delivery():
      READ_ONCE(vcpu->mode);

Target vCPU:
  vcpu_enter_guest():
    vcpu->mode = OUTSIDE_GUEST_MODE;
  ...
  kvm_cpu_has_interrupt():
    snp_protected_apic_has_interrupt():
      smp_mb();
      READ_ONCE(snp_savic_has_pending_ipi);

An unfortunate effect of this is that the guest will see a spurious
wakeup from idle. Irrespective of whether the AVIC doorbell resulted in
the IPI being delivered, KVM now forces an additional VMRUN to clear the
flag snp_savic_has_pending_ipi and this results in a spurious wakeup.
This should not be a functional issue for well-behaved guests.

Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/svm.h  |  1 +
 arch/x86/kvm/svm/avic.c | 13 +++++++++++++
 arch/x86/kvm/svm/sev.c  | 14 ++++++++++++--
 arch/x86/kvm/svm/svm.c  |  4 +++-
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 44f1d25a167c..9da6a2da6592 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -368,6 +368,7 @@ struct vcpu_svm {
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
 
+	bool snp_savic_has_pending_ipi;
 	gpa_t snp_savic_gpa;
 };
 
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6b3983d4f45e..e3758c054783 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -536,6 +536,18 @@ void avic_ring_doorbell(struct kvm_vcpu *vcpu)
 
 static void avic_kick_vcpu(struct kvm_vcpu *vcpu, u32 icrl)
 {
+	if (snp_is_secure_avic_enabled(vcpu->kvm)) {
+		WRITE_ONCE(to_svm(vcpu)->snp_savic_has_pending_ipi, true);
+
+		/*
+		 * Ensure write to snp_savic_has_pending_ipi is visible before the
+		 * subsequent vcpu->mode read in svm_complete_interrupt_delivery().
+		 *
+		 * Pairs with smp_mb() in snp_protected_apic_has_interrupt().
+		 */
+		smp_mb();
+	}
+
 	vcpu->arch.apic->irr_pending = true;
 	svm_complete_interrupt_delivery(vcpu,
 					icrl & APIC_MODE_MASK,
@@ -716,6 +728,7 @@ int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu)
 			kvm_apic_send_ipi(apic, icrl, icrh);
 		break;
 	case AVIC_IPI_FAILURE_TARGET_NOT_RUNNING:
+	case AVIC_IPI_FAILURE_UNACCELERATED:
 		/*
 		 * At this point, we expect that the AVIC HW has already
 		 * set the appropriate IRR bits on the valid target
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 754fe12c2f82..06555dbec45b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3580,6 +3580,9 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
 		cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
 
+	if (snp_is_secure_avic_enabled(kvm))
+		WRITE_ONCE(svm->snp_savic_has_pending_ipi, false);
+
 	/* Assign the asid allocated with this SEV guest */
 	svm->asid = asid;
 
@@ -4514,6 +4517,7 @@ static bool is_snp_only_vmgexit(u64 exit_code)
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 	case SVM_VMGEXIT_PSC:
 	case SVM_VMGEXIT_SAVIC:
+	case SVM_EXIT_AVIC_INCOMPLETE_IPI:
 		return true;
 	default:
 		return false;
@@ -4577,7 +4581,9 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	if (control->exit_code == SVM_VMGEXIT_SAVIC && !snp_is_secure_avic_enabled(vcpu->kvm)) {
+	if ((control->exit_code == SVM_VMGEXIT_SAVIC ||
+	     control->exit_code == SVM_EXIT_AVIC_INCOMPLETE_IPI) &&
+	    !snp_is_secure_avic_enabled(vcpu->kvm)) {
 		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is only valid if Secure AVIC is enabled\n",
 			    control->exit_code);
 		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
@@ -4616,6 +4622,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_EXIT_WBINVD:
 	case SVM_EXIT_MONITOR:
 	case SVM_EXIT_MWAIT:
+	case SVM_EXIT_AVIC_INCOMPLETE_IPI:
 		return svm_invoke_exit_handler(vcpu, control->exit_code);
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE: {
@@ -4976,7 +4983,10 @@ bool snp_protected_apic_has_injectable_intr(struct kvm_vcpu *vcpu)
 
 bool snp_protected_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
-	return snp_protected_apic_has_injectable_intr(vcpu);
+	/* Pairs with smp_mb() in avic_kick_vcpu() */
+	smp_mb();
+	return snp_protected_apic_has_injectable_intr(vcpu) ||
+	       READ_ONCE(to_svm(vcpu)->snp_savic_has_pending_ipi);
 }
 
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 612cc4ac9bd2..63ee36501383 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3901,7 +3901,9 @@ void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
 	bool in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);
 
 	/* Note, this is called iff the local APIC is in-kernel. */
-	if (!READ_ONCE(vcpu->arch.apic->apicv_active) || snp_is_secure_avic_enabled(vcpu->kvm)) {
+	if (!READ_ONCE(vcpu->arch.apic->apicv_active) ||
+	    (snp_is_secure_avic_enabled(vcpu->kvm) &&
+	     snp_protected_apic_has_injectable_intr(vcpu))) {
 		/* Process the interrupt via kvm_check_and_inject_events(). */
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 		kvm_vcpu_kick(vcpu);
-- 
2.54.0

