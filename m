Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AD2D2385;
	Tue, 16 Jun 2026 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570548; cv=none; b=cC1V3jxey7tM7kzBadvo4zfkwR8wRGRUyjvqetPQydWsJ5rEAk8IxuXzngV0gMbPyPVyZxG2d9FpeuVrVG+oE9X1BK3cyFplzjEtXWHyp9jcQQ4xlxn1+0pKajvzIu0pFca6eZRDc7Ui4jkxSLRWUUUnU4h/7K822E2wMd1nEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570548; c=relaxed/simple;
	bh=RsloKe9hQ9zv7cfql4A6qbPzRs6avRB8AkEEwO+WL1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCnlp5c9KSUCYzFo3OfVwrMN1VUGntHa3pjY+A8QHsZUEz45NUj2F+bc8elZE8iO2+/Gh0+ubTeM9dtGAeUeoSUcqX9vl502uOC4HPX9R9jFpEr/7pu1QXJfHGLgdyR1ug+WbQkSQtkTANxbiS9SGwcMv2PHBmUEi5HctM+q4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYJ7D7BF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYJ7D7BF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD611F00A3E;
	Tue, 16 Jun 2026 00:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570546;
	bh=DcNmpSuvGvRbFZwYk0pJbRbZvF3SMFkfNNxcyw1Wsf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYJ7D7BFJ9Ry7zqAYzFbSdskOi3rVFemJeBu9epDtBPFxXWriPU2I4V1JS6hTCbca
	 lUNkCp+HbRyplLLfu+1/v0mkN3qq8usz/8oadF6PVB6Gc/9dymN0dy5fkrDXa/UZ39
	 1UftQvOe4c3Rp7CxgXQzi4hdOT6AajCR3fEd9ikW03zfZEWNTGwjo+CKWetaODSaqW
	 VQvmCNODDdrGYo7IV/6dkOqdfU8b7v1L6O6hCnzhNnoa7fN5iFOQ4Wt3pTjl0dP/J+
	 qhnPHnH5mc+H9td2X+cIUZ0R4xw8+DX0IqJvUE5t1JnvJTQgtUZE7zJvXon2OW2bWE
	 4R6PT7Sq4pqPQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH v2 09/25] KVM: SVM: Use a static ASID per vCPU
Date: Tue, 16 Jun 2026 00:41:38 +0000
Message-ID: <20260616004155.1435766-10-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from dynamic ASID allocation to a static per-vCPU ASID.  The ASID
dynamic ASID allocation logic is now only effectively used when running
out of ASIDs on a CPU (uncommon on modern hardware), or switching CPUs.

The per-CPU ASID generation is initialized to 1, and the per-VMCB ASID
generation is initialized to 0. This leads to a TLB flush of the ASID on
the first VMRUN, allocating a new ASID, and pumping the per-VMCB
generation to 1 (matching the per-CPU generation). The ASID remains
static until either:
- The vCPU runs on a new CPU, in which case KVM resets the per-VMCB
  generation to allocate a new ASID on the new CPU.
- KVM hits the maximum ASID on a CPU and increments the per-CPU ASID
  generation, at which point all vCPUs on this CPU will allocate a new
  ASID.

Drop the complexity and make the ASID static for each vCPU.  This makes
SVM's handling of ASIDs closer to VMX's handling of VPIDs, and
simplifies the code. It also completely avoids full TLB flushes (i.e.
TLB_CONTROL_FLUSH_ALL_ASID) on systems with FLUSHBYASID.  Full flushes
previously happened when updating the generation, so not so common, but
should generally be avoided as they cause a VMRUN to invalidate the TLB
entries for other VMs as well as the host.

When a vCPU is migrated to a new physical CPU, flush the (now static)
ASID instead of allocating a new one. This might cause extra TLB flushes
when switching CPUs (compared to just using a new ASID), but odds are
that the TLB is cold on the new CPU anyway.

As using ASIDs cannot be disabled like VPIDs, allocate a fallback ASID
to be shared by all vCPUs after running out of ASIDs (and flushed on all
VMRUNs), in the very unlikely scenario that more than 32K vCPUs are
active at the same time (as ASIDs are recycled when vCPUs are deleted).
Add allocate_asid() and free_asid() wrappers to handle the fallback
ASID logic, as it will be reused for nested in following changes.

Note #1, svm->asid can technically be dropped in favor of directly using
svm->vmcb->control.asid. However, that would require allocating the ASID
in init_vmcb(), and there is no corresponding cleanup function to free
the ASID. That would also require avoiding reallocation of a new ASID
during a vCPU reset. Opt for simplicity and keep svm->asid, which is
allocated and free in the vCPU creation/freeing paths like VMX VPIDs.

Note #2, a nice side-effect is reading the min/max ASIDs once during
initialization, instead of once per-CPU.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  4 +--
 arch/x86/kvm/svm/svm.c    | 68 +++++++++++++++++++++------------------
 arch/x86/kvm/svm/svm.h    | 22 +++++++++----
 3 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f891299d278a0..66c5b5131cbb1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -925,9 +925,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	else
 		vmcb02->control.bus_lock_counter = 0;
 
-	/* Done at vmrun: asid.  */
+	vmcb02->control.asid = vmcb01->control.asid;
 
-	/* Also overwritten later if necessary.  */
+	/* Overwritten later if necessary.  */
 	vmcb_clr_flush_asid(vmcb02);
 
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5d4c45d788b54..fae5cb7102010 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -189,6 +189,8 @@ DEFINE_PER_CPU(struct svm_cpu_data, svm_data);
 
 static DEFINE_MUTEX(vmcb_dump_mutex);
 
+kvm_tlb_tag_t fallback_asid;
+
 /*
  * Only MSR_TSC_AUX is switched via the user return hook.  EFER is switched via
  * the VMCB, and the SYSCALL/SYSENTER MSRs are handled by VMLOAD/VMSAVE.
@@ -571,10 +573,6 @@ static int svm_enable_virtualization_cpu(void)
 		return r;
 
 	sd = per_cpu_ptr(&svm_data, me);
-	sd->asid_generation = 1;
-	sd->max_asid = cpuid_ebx(SVM_CPUID_FUNC) - 1;
-	sd->next_asid = sd->max_asid + 1;
-	sd->min_asid = max_sev_asid + 1;
 
 	wrmsrq(MSR_VM_HSAVE_PA, sd->save_area_pa);
 
@@ -977,6 +975,8 @@ static void svm_hardware_unsetup(void)
 
 	__free_pages(__sme_pa_to_page(iopm_base), get_order(IOPM_SIZE));
 	iopm_base = 0;
+
+	kvm_destroy_tlb_tags();
 }
 
 static void init_seg(struct vmcb_seg *seg)
@@ -1228,8 +1228,8 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	if (gmet_enabled)
 		control->misc_ctl |= SVM_MISC_ENABLE_GMET;
 
-	svm->current_vmcb->asid_generation = 0;
-	svm->asid = 0;
+	control->asid = svm->asid;
+	vmcb_set_flush_asid(vmcb);
 
 	svm->nested.vmcb12_gpa = INVALID_GPA;
 	svm->nested.last_vmcb12_gpa = INVALID_GPA;
@@ -1339,6 +1339,15 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 		goto error_free_sev;
 	}
 
+	/*
+	 * svm->asid is unused by SEV, put zero in there to trigger VMRUN
+	 * failure if this ever ends up in the VMCB.
+	 */
+	if (is_sev_guest(vcpu))
+		svm->asid = 0;
+	else
+		svm->asid = allocate_asid();
+
 	svm->x2avic_msrs_intercepted = true;
 	svm->lbr_msrs_intercepted = true;
 
@@ -1371,6 +1380,9 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	__free_page(__sme_pa_to_page(svm->vmcb01.pa));
 	svm_vcpu_free_msrpm(svm->msrpm);
+
+	if (!is_sev_guest(vcpu))
+		free_asid(svm->asid);
 }
 
 #ifdef CONFIG_CPU_MITIGATIONS
@@ -1896,19 +1908,6 @@ static void svm_update_exception_bitmap(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
-{
-	if (sd->next_asid > sd->max_asid) {
-		++sd->asid_generation;
-		sd->next_asid = sd->min_asid;
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
-
-	svm->current_vmcb->asid_generation = sd->asid_generation;
-	svm->asid = sd->next_asid++;
-}
-
 static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
 	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
@@ -3745,16 +3744,15 @@ static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
 
 static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
-	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
-	 * If the previous vmrun of the vmcb occurred on a different physical
-	 * cpu, then mark the vmcb dirty and assign a new asid.  Hardware's
-	 * vmcb clean bits are per logical CPU, as are KVM's asid assignments.
+	 * If the previous VMRUN of the VMCB occurred on a different physical
+	 * CPU, then mark the VMCB dirty and flush the ASID.  Hardware's
+	 * VMCB clean bits are per logical CPU, as are KVM's ASID assignments.
 	 */
 	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
-		svm->current_vmcb->asid_generation = 0;
+		vmcb_set_flush_asid(svm->vmcb);
 		vmcb_mark_all_dirty(svm->vmcb);
 		svm->current_vmcb->cpu = vcpu->cpu;
         }
@@ -3762,14 +3760,8 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	if (is_sev_guest(vcpu))
 		return pre_sev_run(svm, vcpu->cpu);
 
-	/* FIXME: handle wraparound of asid_generation */
-	if (svm->current_vmcb->asid_generation != sd->asid_generation)
-		new_asid(svm, sd);
-
-	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
-		svm->vmcb->control.asid = svm->asid;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
+	if (unlikely(svm->vmcb->control.asid == fallback_asid))
+		vmcb_set_flush_asid(svm->vmcb);
 
 	return 0;
 }
@@ -5598,6 +5590,7 @@ static __init void svm_set_cpu_caps(void)
 
 static __init int svm_hardware_setup(void)
 {
+	unsigned long min_asid, nr_asids;
 	void *iopm_va;
 	int cpu, r;
 
@@ -5751,6 +5744,17 @@ static __init int svm_hardware_setup(void)
 
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
 
+	/* Consumes max_sev_asid initialized by sev_hardware_setup() */
+	min_asid = max_sev_asid + 1;
+	nr_asids = cpuid_ebx(SVM_CPUID_FUNC);
+	r = kvm_init_tlb_tags(min_asid, nr_asids - min_asid);
+	if (r)
+		goto err;
+
+	fallback_asid = kvm_alloc_tlb_tag();
+	if (!fallback_asid)
+		goto err;
+
 	for_each_possible_cpu(cpu) {
 		r = svm_cpu_init(cpu);
 		if (r)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4bf8afdc77cbd..4442e9fd4f5d0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -26,6 +26,7 @@
 #include "regs.h"
 #include "x86.h"
 #include "pmu.h"
+#include "mmu.h"
 
 /*
  * Helpers to convert to/from physical addresses for pages whose address is
@@ -143,7 +144,6 @@ struct kvm_vmcb_info {
 	struct vmcb *ptr;
 	unsigned long pa;
 	int cpu;
-	uint64_t asid_generation;
 };
 
 struct vmcb_save_area_cached {
@@ -282,7 +282,7 @@ struct vcpu_svm {
 	struct vmcb *vmcb;
 	struct kvm_vmcb_info vmcb01;
 	struct kvm_vmcb_info *current_vmcb;
-	u32 asid;
+	kvm_tlb_tag_t asid;
 	u32 sysenter_esp_hi;
 	u32 sysenter_eip_hi;
 	uint64_t tsc_aux;
@@ -369,11 +369,6 @@ struct vcpu_svm {
 };
 
 struct svm_cpu_data {
-	u64 asid_generation;
-	u32 max_asid;
-	u32 next_asid;
-	u32 min_asid;
-
 	bool bp_spec_reduce_set;
 
 	struct vmcb *save_area;
@@ -476,6 +471,19 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
 	vmcb_mark_dirty(vmcb, VMCB_NPT);
 }
 
+extern kvm_tlb_tag_t fallback_asid;
+
+static inline kvm_tlb_tag_t allocate_asid(void)
+{
+	return kvm_alloc_tlb_tag() ?: fallback_asid;
+}
+
+static inline void free_asid(kvm_tlb_tag_t asid)
+{
+	if (likely(asid != fallback_asid))
+		kvm_free_tlb_tag(asid);
+}
+
 static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
 {
 	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
-- 
2.54.0.1136.gdb2ca164c4-goog

