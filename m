Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB926B2D2;
	Tue, 28 Jul 2026 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198970; cv=none; b=jqYAjj6of+DDSJLrwHkZLeVaMX8Q7SDxFwUNnHIosLkGcjAsMMlwJXBPVMymKICIQWjqK/pSP8vEYy5RMR4q1izDwsE3dgsAtmO7C90fNKHSr7hp9HO672nyw/L1cGJRjDh0Y6YxLmzuxVIUezhJuvNM7i83lT9rJWRxt4bx+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198970; c=relaxed/simple;
	bh=t4++KuLuRIWwN5d6QuJgXZ0stIWYFvLUxnFjscsrpV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMc94f7k966JAiuR12CE3EKbJXgS4WPTz+r3COC6CpkdqTSwkpP5D5w59HL+8yWPx3TrTxMOaLqe0jBvKD51Y4Z7QLvUxSo/H+U/F+IHlQsjAbhk33mtP+rWJtIXyFKsalbvAwS/pZa67prFOYYHAoY1MA8WifT8s90n1yyaMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuoFLpJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuoFLpJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4060A1F00A3F;
	Tue, 28 Jul 2026 00:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198968;
	bh=J52DntNJ0E8QX+RWr7u3rJkFrwXAmqy4MYmqIFX4NZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuoFLpJ/Xe/jk67KbGbIPiY7mlrjU13GgziQe9JUUP8rMRPhe8FxciRXNQpH6TjIq
	 IzHSiKc7I/2GvGdm7dgopjmJ1EHgmes6kBntMv3isGYBpTYjO9TcRL65QXtFwLOcwO
	 oNTJLxiQlm4hcOahfSiEpyA2sU2RqlxOakl9eSYyPtzxf2csiKaKGcU696Q2MvdYZv
	 gHvm3dWKw7z25Blu0omFV7tvAL649v5x7CGq2Kyo6JEoNQJlSRfMjq3v/q/gZgnGVD
	 LlpKg+8FgvRd8/NujESrxDI1qN7J+et78k84w2ZVHUNaMs3tDfkPE5/FAhqktDtRHy
	 11K9hXRUrWh+Q==
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
Subject: [PATCH v1 10/28] KVM: SVM: Use a static ASID per vCPU
Date: Tue, 28 Jul 2026 00:35:39 +0000
Message-ID: <20260728003557.1136583-11-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
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
TLB_CONTROL_FLUSH_ALL_ASID) on systems with FlushByAsid.  Full flushes
previously happened when updating the generation, so not so common, but
should generally be avoided as they cause a VMRUN to invalidate the TLB
entries for other VMs as well as the host.

When a vCPU is migrated to a new physical CPU, flush the (now static)
ASID instead of allocating a new one. This might cause extra TLB flushes
when switching CPUs (compared to just using a new ASID), but odds are
that the TLB is cold on the new CPU anyway.

As using ASIDs cannot be disabled like VPIDs, allocate a fallback ASID
to be shared by all vCPUs after running out of ASIDs (and flushed on
every vCPU run, for now).  If a fallback ASID cannot be allocated, fail
vCPU creation (for non-SEV guests), but do not fail SVM initialization,
to allow for allocating all ASIDs for SEV (if at all possible).

For SEV, the same ASID continues to be used by all vCPUs in a VM. Move
svm->asid initialization from SEV-specific VMCB initialization to vCPU
creation, such that svm->asid is always initialized on vCPU creation for
both SEV and non-SEV vCPUs. This makes the logic simpler to follow, and
makes it easier to hide it in allocate_asid() and free_asid() helpers.

Carefully handle SEV VM migration by copying svm->asid before the
SEV-specific VMCB initialization for the destination, such that the ASID
ends up being correctly initialized in the VMCB. Also, keep the ASID
initialization in sev_init_vmcb(), even though it's already done in
init_vmcb(), to specifically handle the SEV VM migration case where the
ASID in the VMCB needs to be updated but init_vmcb() is not called
again.

Note: A nice side-effect is reading the min/max ASIDs once during
initialization, instead of once per-CPU.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  4 +--
 arch/x86/kvm/svm/sev.c    |  3 +-
 arch/x86/kvm/svm/svm.c    | 63 +++++++++++++++++++--------------------
 arch/x86/kvm/svm/svm.h    | 24 ++++++++++-----
 4 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ef0326932c446..ed4af5a08f794 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -928,9 +928,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	else
 		vmcb02->control.bus_lock_counter = 0;
 
-	/* Done at vmrun: asid.  */
+	vmcb02->control.asid = vmcb01->control.asid;
 
-	/* Also overwritten later if necessary.  */
+	/* Overwritten later if necessary.  */
 	vmcb_clr_flush_asid(vmcb02);
 
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3aac702f45b2b..087d18a5eda69 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2071,6 +2071,7 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
 		dst_svm = to_svm(dst_vcpu);
 
+		dst_svm->asid = dst->asid;
 		sev_init_vmcb(dst_svm, false);
 
 		if (!dst->es_active)
@@ -4816,7 +4817,7 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV;
 	clr_exception_intercept(svm, UD_VECTOR);
 
-	svm->asid = sev_get_asid(vcpu->kvm);
+	WARN_ON_ONCE(svm->asid != sev_get_asid(vcpu->kvm));
 	svm->vmcb->control.asid = svm->asid;
 	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b8f3f71f70673..31194c773af7c 100644
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
@@ -1229,8 +1229,8 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	if (gmet_enabled)
 		control->misc_ctl |= SVM_MISC_ENABLE_GMET;
 
-	svm->current_vmcb->asid_generation = 0;
-	svm->asid = 0;
+	control->asid = svm->asid;
+	vmcb_set_flush_asid(vmcb);
 
 	svm->nested.vmcb12_gpa = INVALID_GPA;
 	svm->nested.last_vmcb12_gpa = INVALID_GPA;
@@ -1335,6 +1335,12 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 		goto error_free_sev;
 	}
 
+	svm->asid = allocate_asid(vcpu);
+	if (!svm->asid) {
+		err = -EINVAL;
+		goto error_free_msrpm;
+	}
+
 	svm->x2avic_msrs_intercepted = true;
 	svm->lbr_msrs_intercepted = true;
 
@@ -1346,6 +1352,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	return 0;
 
+error_free_msrpm:
+	svm_vcpu_free_msrpm(svm->msrpm);
 error_free_sev:
 	sev_free_vcpu(vcpu);
 error_free_vmcb_page:
@@ -1367,6 +1375,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	__free_page(__sme_pa_to_page(svm->vmcb01.pa));
 	svm_vcpu_free_msrpm(svm->msrpm);
+
+	free_asid(vcpu, svm->asid);
 }
 
 #ifdef CONFIG_CPU_MITIGATIONS
@@ -1892,19 +1902,6 @@ static void svm_update_exception_bitmap(struct kvm_vcpu *vcpu)
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
@@ -3758,16 +3755,15 @@ static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
 
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
@@ -3775,14 +3771,8 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
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
@@ -5606,6 +5596,7 @@ static __init void svm_set_cpu_caps(void)
 
 static __init int svm_hardware_setup(void)
 {
+	unsigned long nr_asids;
 	void *iopm_va;
 	int cpu, r;
 
@@ -5758,6 +5749,14 @@ static __init int svm_hardware_setup(void)
 
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
 
+	/* Consumes max_sev_asid initialized by sev_hardware_setup() */
+	nr_asids = cpuid_ebx(SVM_CPUID_FUNC);
+	r = kvm_init_tlb_tags(nr_asids, max_sev_asid + 1);
+	if (r)
+		goto err;
+
+	fallback_asid = kvm_alloc_tlb_tag();
+
 	for_each_possible_cpu(cpu) {
 		r = svm_cpu_init(cpu);
 		if (r)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d41d189ecf4e1..a75862e693134 100644
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
@@ -283,7 +283,7 @@ struct vcpu_svm {
 	struct vmcb *vmcb;
 	struct kvm_vmcb_info vmcb01;
 	struct kvm_vmcb_info *current_vmcb;
-	u32 asid;
+	kvm_tlb_tag_t asid;
 	u32 sysenter_esp_hi;
 	u32 sysenter_eip_hi;
 	uint64_t tsc_aux;
@@ -370,11 +370,6 @@ struct vcpu_svm {
 };
 
 struct svm_cpu_data {
-	u64 asid_generation;
-	u32 max_asid;
-	u32 next_asid;
-	u32 min_asid;
-
 	bool bp_spec_reduce_set;
 
 	struct vmcb *save_area;
@@ -487,6 +482,21 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
 	vmcb_mark_dirty(vmcb, VMCB_NPT);
 }
 
+extern kvm_tlb_tag_t fallback_asid;
+
+static inline kvm_tlb_tag_t allocate_asid(struct kvm_vcpu *vcpu)
+{
+	if (is_sev_guest(vcpu))
+		return sev_get_asid(vcpu->kvm);
+	return kvm_alloc_tlb_tag() ?: fallback_asid;
+}
+
+static inline void free_asid(struct kvm_vcpu *vcpu, kvm_tlb_tag_t asid)
+{
+	if (!is_sev_guest(vcpu) && asid != fallback_asid)
+		kvm_free_tlb_tag(asid);
+}
+
 static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
 {
 	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
-- 
2.55.0.229.g6434b31f56-goog

