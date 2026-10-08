Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222402D1911;
	Thu,  8 Oct 2026 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418486; cv=none; b=h7iTWSlkPf4ij+6Z78tbTnHZMtsskLLpZ2KL6rDGtVTDV5DacPXPTKn7KHG6H2AIZE4PBycQ248C8tejPPwgSj78yJhpu81aSD5LOhFI/5KvGCLcTY0IaREjHCEOJkcEelTgYpWzPHYidRWlMANInzmBsyp9mpjJl7BRjmduyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418486; c=relaxed/simple;
	bh=0QEN1as3bJZTOQOqXvya+DPQ6yEnV/Wh0Zd19e9SxWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceoUqre2hVbhpwajgfsX0ZxYcP7wRPEfrS6hLkh9gFffPev2om+YqvuB+OmiAYjLW1VvyWr7KmoSPLQ1kp9TYdbulypygQ75RtEMODwUojbsNHGfWPrCXpNI5xyQgnGt9kELo0Ojdw82My/BHgfiWvS45//14Y3mzQyKd3YUpKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOfsQMLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOfsQMLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B541F00898;
	Thu,  8 Oct 2026 00:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418484;
	bh=c4Ur0kCVne/eZ0rEMj3maO+T8Zsx4R7w/XvNojIOrnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GOfsQMLLvMVOF1dldM99tVDbEPvt59dbA2DahXKBbJZ+nFEPezwA2O+wV7K38OIaI
	 Zg0L8WgU1d1SaUmbFL1f40ZFxXtFdCqMLf4xHmPxgKgMLSGFY6e2uD/i8N3lVYAh9k
	 ZrD8mrZuJgVZuSyfmmYkkBLXDh529Z4xIhNxPOTCOq1ck6p/OmDUzJ16TRBkBqVcyp
	 GVPHbvnaS2HWY3FFyRoJknKMr+MWds3NVxgG+0xYWaOO6SlKi2FdTNc0dOkpPqzLoi
	 ykFd/fqoWzYV4DoZj4SKQrKxov2CFreq8yrtf7v+lpBBCPNYOqiTKDSyhY5b5bOZ7M
	 OvrznCuBypJrw==
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
Subject: [PATCH v2 10/29] KVM: SVM: Use a static ASID per vCPU
Date: Thu,  8 Oct 2026 00:14:06 +0000
Message-ID: <20261008001425.2458927-11-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from dynamic ASID allocation to a static per-vCPU ASID.  The
dynamic ASID allocation logic is now only effectively used when running
out of ASIDs on a CPU (uncommon on modern hardware), or switching CPUs.

The per-VMCB ASID generation is initialized to 0, which never matches the
per-CPU ASID generation (bumped every time a CPU is enabled for
virtualization). This leads to a TLB flush of the ASID on the first VMRUN,
allocating a new ASID, and bumping the per-VMCB generation to match the
per-CPU generation. The ASID remains static until one of the following:

- The vCPU runs on a new CPU, in which case KVM resets the generation of
  both VMCBs to allocate a new ASID on the new CPU.

- KVM hits the maximum ASID on a CPU and increments the per-CPU ASID
  generation, at which point all vCPUs on this CPU will allocate a new
  ASID.

- The CPU is re-enabled for virtualization (e.g. after CPU hotplug), at
  which point the per-CPU generation is bumped and all vCPUs that
  previously ran on it will allocate a new ASID.

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

Static ASIDs also make the following fixes to the dynamic ASID
allocation scheme unnecessary, so drop them:

- Bumping the per-CPU generation when enabling virtualization on a CPU,
  added by commit 25f744ffa0c8 ("KVM: SVM: Bump asid_generation on CPU
  online to avoid ASID collision after hotplug").  A vCPU can no longer
  run with an ASID that is (re)assigned to another vCPU.

- Resetting the generation of both VMCBs on a CPU switch, added by
  commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
  VMCBs on pCPU switch").  An ASID is now owned by the same vCPU on all
  CPUs, so a VMCB that misses a CPU switch can no longer end up using an
  ASID owned by another vCPU on that CPU.

- Tracking a pending full flush per-CPU (i.e. flush_all_asids), added by
  commit 60d93c27859f ("KVM: SVM: Preserve TLB control (i.e. pending TLB
  flush) on failed VMRUN").  The full flush on generation wraparound was
  needed on behalf of all vCPUs on the CPU, as their ASIDs were about to
  be recycled, so it had to be tracked per-CPU instead of in the VMCB of
  the vCPU that happened to trigger the wraparound.  With static ASIDs,
  TLB flushes are only needed for the vCPU's own ASID, so tracking them in
  the VMCB is sufficient, and a pending flush in the VMCB is still
  preserved on a failed VMRUN.

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
Decide whether to free an ASID based on the ASID range rather than the
VM type, as an SEV VM's vCPUs may stop being SEV vCPUs (or vice versa)
as a result of SEV VM migration.

Keep the ASID initialization in sev_init_vmcb(), even though it's
already done in init_vmcb(), to handle SEV VM migration.  svm->asid is
already reinitialized on destination SEV VMs during migration before
VMCB initialization, so the ASID ends up correctly in the VMCB.
Additionally, free any existing non-SEV ASID on the destination vCPU
before overwriting it, to avoid leaking ASIDs when creating vCPUs then
migrating an SEV VM onto them.

Note: A nice side-effect is reading the min/max ASIDs once during
initialization, instead of once per-CPU.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  4 +-
 arch/x86/kvm/svm/sev.c    |  7 +++-
 arch/x86/kvm/svm/svm.c    | 79 +++++++++++++++------------------------
 arch/x86/kvm/svm/svm.h    | 25 +++++++++----
 4 files changed, 55 insertions(+), 60 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c3c12a4d6fe07..5d63ae47ebb6c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -936,9 +936,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	else
 		vmcb02->control.bus_lock_counter = 0;
 
-	/* Done at vmrun: asid.  */
+	vmcb02->control.asid = vmcb01->control.asid;
 
-	/* Also overwritten later if necessary.  */
+	/* Overwritten later if necessary.  */
 	vmcb_clr_flush_asid(vmcb02);
 
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0fbb72d57e6da..99577859e1aab 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2035,6 +2035,11 @@ static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 static void sev_vcpu_migrate_asid(struct vcpu_svm *dst_svm,
 				  unsigned int asid)
 {
+	/*
+	 * Free the (potentially non-SEV) ASID on the destination vCPU before
+	 * setting the new SEV ASID.
+	 */
+	free_asid(dst_svm->asid);
 	dst_svm->asid = asid;
 }
 
@@ -4888,7 +4893,7 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV;
 	clr_exception_intercept(svm, UD_VECTOR);
 
-	svm->asid = sev_get_asid(vcpu->kvm);
+	WARN_ON_ONCE(svm->asid != sev_get_asid(vcpu->kvm));
 	svm->vmcb->control.asid = svm->asid;
 	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0c3befd9bc850..8f27722bc4faf 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -192,6 +192,8 @@ DEFINE_PER_CPU(struct svm_cpu_data, svm_data);
 
 static DEFINE_MUTEX(vmcb_dump_mutex);
 
+kvm_tlb_tag_t fallback_asid;
+
 /*
  * Only MSR_TSC_AUX is switched via the user return hook.  EFER is switched via
  * the VMCB, and the SYSCALL/SYSENTER MSRs are handled by VMLOAD/VMSAVE.
@@ -583,15 +585,6 @@ static int svm_enable_virtualization_cpu(void)
 		return r;
 
 	sd = per_cpu_ptr(&svm_data, me);
-	/*
-	 * Bump the current asid_generation value to ensure any vCPU that
-	 * previously ran on this CPU sees a stale generation and is forced
-	 * to acquire a new ASID, preventing a latent ASID collision.
-	 */
-	sd->asid_generation++;
-	sd->max_asid = cpuid_ebx(SVM_CPUID_FUNC) - 1;
-	sd->next_asid = sd->max_asid + 1;
-	sd->min_asid = max_sev_asid + 1;
 
 	wrmsrq(MSR_VM_HSAVE_PA, sd->save_area_pa);
 
@@ -994,6 +987,8 @@ static void svm_hardware_unsetup(void)
 
 	__free_pages(__sme_pa_to_page(iopm_base), get_order(IOPM_SIZE));
 	iopm_base = 0;
+
+	kvm_destroy_tlb_tags();
 }
 
 static void init_seg(struct vmcb_seg *seg)
@@ -1246,8 +1241,8 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	if (gmet_enabled)
 		control->misc_ctl |= SVM_MISC_ENABLE_GMET;
 
-	svm->current_vmcb->asid_generation = 0;
-	svm->asid = 0;
+	control->asid = svm->asid;
+	vmcb_set_flush_asid(vmcb);
 
 	svm->nested.vmcb12_gpa = INVALID_GPA;
 	svm->nested.last_vmcb12_gpa = INVALID_GPA;
@@ -1375,6 +1370,12 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 		goto error_free_avic;
 	}
 
+	svm->asid = allocate_asid(vcpu);
+	if (!svm->asid) {
+		err = -EINVAL;
+		goto error_free_msrpm;
+	}
+
 	svm->x2avic_msrs_intercepted = true;
 	svm->lbr_msrs_intercepted = true;
 
@@ -1386,6 +1387,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	return 0;
 
+error_free_msrpm:
+	svm_vcpu_free_msrpm(svm->msrpm);
 error_free_avic:
 	avic_vcpu_free(vcpu);
 error_free_sev:
@@ -1417,6 +1420,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	__free_page(__sme_pa_to_page(svm->vmcb01.pa));
 	svm_vcpu_free_msrpm(svm->msrpm);
+
+	free_asid(svm->asid);
 }
 
 #ifdef CONFIG_CPU_MITIGATIONS
@@ -1942,18 +1947,6 @@ static void svm_update_exception_bitmap(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
-{
-	if (sd->next_asid > sd->max_asid) {
-		++sd->asid_generation;
-		sd->next_asid = sd->min_asid;
-		sd->flush_all_asids = true;
-	}
-
-	svm->current_vmcb->asid_generation = sd->asid_generation;
-	svm->asid = sd->next_asid++;
-}
-
 static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
 	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
@@ -3875,37 +3868,24 @@ static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
 
 static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
-	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
 	 * If the previous VMRUN of the VMCB occurred on a different physical
-	 * cpu, then mark the VMCB dirty as hardware's clean bits are per pCPU.
-	 *
-	 * Reset the ASID generation in both VMCBs. This will lead to assigning
-	 * a new ASID now, and then again when switching to the other VMCB.
-	 * However, this is needed as the ASID is shared between the VMCBs, and
-	 * otherwise it would be possible to use an ASID allocated on one pCPU
-	 * on another, for example:
-	 * - vCPU migrates from pCPU A to pCPU B, allocates a new ASID.
-	 * - vCPU migrates back to pCPU A, and then switches the VMCB.
-	 * - The new VMCB does not detect a pCPU change and runs on pCPU A with
-	 *   the new ASID allocated on pCPU B, which is potentially used by
-	 *   another vCPU/VM.
+	 * cpu, then mark the VMCB dirty and flush the ASID, as hardware's clean
+	 * bits and TLB entries are per pCPU.
 	 */
 	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
 		vmcb_mark_all_dirty(svm->vmcb);
 		svm->current_vmcb->cpu = vcpu->cpu;
-		svm->vmcb01.asid_generation = 0;
-		svm->nested.vmcb02.asid_generation = 0;
+		vmcb_set_flush_asid(svm->vmcb);
         }
 
 	if (is_sev_guest(vcpu))
 		return pre_sev_run(svm, vcpu->cpu);
 
-	/* FIXME: handle wraparound of asid_generation */
-	if (svm->current_vmcb->asid_generation != sd->asid_generation)
-		new_asid(svm, sd);
+	if (unlikely(svm->vmcb->control.asid == fallback_asid))
+		vmcb_set_flush_asid(svm->vmcb);
 
 	return 0;
 }
@@ -4644,13 +4624,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	sync_lapic_to_cr8(vcpu);
 
-	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
-		svm->vmcb->control.asid = svm->asid;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
-	if (this_cpu_ptr(&svm_data)->flush_all_asids)
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
-
 	svm->vmcb->save.cr2 = vcpu->arch.cr2;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS) &&
@@ -4742,7 +4715,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	}
 
 	if (!svm_is_vmrun_failure(svm->vmcb->control.exit_code)) {
-		this_cpu_ptr(&svm_data)->flush_all_asids = false;
 		vmcb_clr_flush_asid(svm->vmcb);
 
 		/*
@@ -5754,6 +5726,7 @@ static __init void svm_set_cpu_caps(void)
 
 static __init int svm_hardware_setup(void)
 {
+	unsigned long nr_asids;
 	void *iopm_va;
 	int cpu, r;
 
@@ -5911,6 +5884,14 @@ static __init int svm_hardware_setup(void)
 
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
index 14b57c5cdf916..53c5ed2d93d91 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -26,6 +26,7 @@
 #include "regs.h"
 #include "x86.h"
 #include "pmu.h"
+#include "mmu.h"
 
 /*
  * Helpers to convert to/from physical addresses for pages whose address is
@@ -145,7 +146,6 @@ struct kvm_vmcb_info {
 	struct vmcb *ptr;
 	unsigned long pa;
 	int cpu;
-	uint64_t asid_generation;
 };
 
 struct vmcb_save_area_cached {
@@ -285,7 +285,7 @@ struct vcpu_svm {
 	struct vmcb *vmcb;
 	struct kvm_vmcb_info vmcb01;
 	struct kvm_vmcb_info *current_vmcb;
-	u32 asid;
+	kvm_tlb_tag_t asid;
 	u32 sysenter_esp_hi;
 	u32 sysenter_eip_hi;
 	uint64_t tsc_aux;
@@ -372,12 +372,6 @@ struct vcpu_svm {
 };
 
 struct svm_cpu_data {
-	u64 asid_generation;
-	u32 max_asid;
-	u32 next_asid;
-	u32 min_asid;
-
-	bool flush_all_asids;
 	bool bp_spec_reduce_set;
 
 	struct vmcb *save_area;
@@ -1080,6 +1074,21 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
 #endif
 
+extern kvm_tlb_tag_t fallback_asid;
+
+static inline kvm_tlb_tag_t allocate_asid(struct kvm_vcpu *vcpu)
+{
+	if (is_sev_guest(vcpu))
+		return sev_get_asid(vcpu->kvm);
+	return kvm_alloc_tlb_tag() ?: fallback_asid;
+}
+
+static inline void free_asid(kvm_tlb_tag_t asid)
+{
+	if (asid > max_sev_asid && asid != fallback_asid)
+		kvm_free_tlb_tag(asid);
+}
+
 /* vmenter.S */
 
 void __svm_sev_es_vcpu_run(struct vcpu_svm *svm, unsigned int flags,
-- 
2.56.0.360.g66cac248cb-goog

