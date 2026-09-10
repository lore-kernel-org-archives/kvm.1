Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5A33D6D6
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047203; cv=none; b=ttyRdF/HJlS1CqOyx9zJ+GB+wr4yx+NbJGUmO/B4MCxVwxrudzTKFBjB6R3RDlCadVTdFRaaOJaE6aSfwAhZTZd8hZvrHSF8uoNJJRVGlsvnitJEmb/k/+5h6j/6hqiWaBsmDORNRHXXAFGlnY3Dmd3hlxKuCCnYl8g9aD7q1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047203; c=relaxed/simple;
	bh=6eWdslWyzdpGuccaaE/s12ZUg+3xv4baG7q42/grGwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmpEpBNhklCIagVb/VGQphgIdQLYMJNp0G85QPsuDb89Nvq0TWxr06VJ5dqUPMVcAu7r55V9y64Nc4LjZS5LHU7UrE6EdqZeMLgE2gUITx5+S1XYDJ5J99PPvIcAtV14znnk14A5tnDbUkartXPxXrjilsN5WZ1D0H/UPniq6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0asVh8u; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0asVh8u"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-7f4ddb9adf4so2861003a34.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789047200; x=1789652000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ceaTla6FiiLBfg3RPB4HvVU4vj1Kt+j0ZZ10PrWg9a8=;
        b=c0asVh8uDlZI6WZN+pIk6RhSIBBuZMjve4jNIPDI9/VC0MKupdl/XdNYA4/xty81R+
         DDbTUGNK3V5SY1h54BJGfHvMGrD1eOHqHjvQO72eMHi8uIeyAsdG9DL0muzUFpY70zO0
         bIRKx5w4et725bDjRamutQrf6gzV6ieCdc/Lkth9JUMWh/PbEiGOxHL9UUBdWjXlre6l
         1KA1CwXEdEEuElGtEjIkRURb+Fx3AcSo/tq1OqTmuzbVyOQ+QqEism2Nq/JZIs51LHO7
         OtGf5ykZHzW3Y7CFqQRr8q0YJSXfeb4Vr23mubWia96ejz3iDcOEOmIRLqf38E803Lhf
         AEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789047200; x=1789652000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ceaTla6FiiLBfg3RPB4HvVU4vj1Kt+j0ZZ10PrWg9a8=;
        b=S9G4XNtmQkDHMAgX6DcfxFje12LWHB6N3BCNan8cVjd7Axvc/sY6tCXsV+sCR2qH9P
         HI5rgTIpKuuTimBOYDEiPeB+KOLOptwa8NZcEc4IGMKYRdZOf8Cka2XP+evm6OyJ9Yvv
         b/+DCCc+bo6kSmru+zfL5SSaLMYyyJWZkfVr/s+fXv9cvXjY/+Dxz9GdH2AijC/uGiEJ
         bwBQmlQNoY5GLkVYFSIuCnSu++DYXJREDeOCDa8fDJTxPeawa3opiYohQxkd0mRA3SkL
         RrsXexSkv6QHFemj0Dh8FAimFXMQSRoZuG71Deq0CzpI1eaF5y1uBoVC6M2DxQm6Gv40
         hS8A==
X-Forwarded-Encrypted: i=1; AKwUvByo0PkFLLQKrLJwuKWkKaVKMHMn7/jSO71TNrnQFr/CyxOtBi9izzq+8vy9dF1RBn4u3qM=@vger.kernel.org
X-Gm-Message-State: AFuF++kfrlvLa7ns6tfM9NbOyvokH/T2l1kWbClA6lLLVfYV1t1bM6Bs
	BY+JGAXu510pOosNJb3GtF3wphv0gzTkVlKYgIa+EHTHSi+KpgAY9h7e
X-Gm-Gg: AYBFou1eI0NP7GCSTEiXnDlU3oUj3k5IXXceL9bAbpR59xiq2lJsABcVGc+FnmvMNIw
	+pg5mzZAJbIheqrCjeMAXnytD1+k7UttttrUCsbqLgxpVLkm8tbaas/SfFQT2iHJ5Bei48TpVjp
	Vi2RQPY8Q8Knu8aQK8dy/6Q68tGJds0Ab1vO92S+bMTztZ5xZZ/YiuiLVNde9Q4yduSPwQiHB1M
	wWcnsjwUvOP+1+s69T8joh+JLpr3DPMiNESdDJ/8LONsaRIFSFB5ZgxfeXFZ6potdwwN93bvPau
	uH6N9lG7bOSap8cZEHXYZCd8MIMdLwAArSNtFtqvlOh2HXKKqs5tc+i5r74p7fnwZ5kbc0YzvoC
	O0+O5/baqDAnBEztc9HBEwtU+PDEFZ7wObt9SSDVNsGkcu1xiPtqvnYddVpBl4y19TujX1cBchG
	L8CP7rIVi0kg0XDG14UrwJ/E9Mw/2ta1d8WKeoq+HAFCqum8IA4v3/fGT29oR5pr1bZPxtjN217
	NNnSXbg4VsE
X-Received: by 2002:a4a:e842:0:b0:6b0:ab1f:ec0c with SMTP id 006d021491bc7-6b6fd1cc120mr22896747eaf.34.1789047199406;
        Thu, 10 Sep 2026 06:33:19 -0700 (PDT)
Received: from wenlongli.debian ([179.253.249.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm21837545eec.29.2026.09.10.06.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:33:18 -0700 (PDT)
From: Wenlong Li <wenlongli486@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	kvm-riscv@lists.infradead.org
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Avoid synchronous IPIs on VMID rollover
Date: Thu, 10 Sep 2026 21:33:00 +0800
Message-ID: <20260910133300.956555-1-wenlongli486@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current VMID rollover path synchronously invokes HFENCE.GVMA on
all online CPUs using on_each_cpu_mask(). This sends IPIs to remote
CPUs and causes a vCPU running in guest mode on a targeted CPU to exit.
The rollover path then waits for all CPUs to complete their local TLB
flushes before VMID allocation can continue.

Make VMID rollover lazy to remove this cross-CPU synchronization.

Track active and reserved software VMIDs for each possible CPU. On
rollover, preserve hardware VMIDs that may still have stale
translations, clear the active VMID, and mark a local TLB flush
pending for each CPU.

Do not send IPIs or otherwise force remote vCPUs to exit during
rollover. Instead, when a CPU next activates a VMID before guest
entry, perform the pending local HFENCE.GVMA and only then publish
the new active VMID.

Perform VMID activation after preemption is disabled in the guest
entry path. This keeps the per-CPU active VMID and pending flush state
associated with the same CPU that subsequently enters guest mode.

Keep reserved hardware VMIDs unavailable to the bitmap allocator
while stale translations associated with them may still exist. This
prevents a hardware VMID from being reused prematurely after a
generation rollover.

Represent a software VMID as a generation combined with a hardware
VMID, and extract only the hardware VMID when programming HGATP or
issuing VMID-specific fences.

Reserve hardware VMID 0. Disable VMID allocation when the hardware
VMID space is too small to retain one reserved VMID per possible CPU
while still leaving a VMID available for a new allocation.

Invalidate the per-CPU VMID bookkeeping when virtualization is
disabled, so stale G-stage translations are flushed before the CPU
next enters a guest.

This removes IPIs and remote CPU synchronization from the VMID
rollover path, avoiding VM exits caused solely by VMID exhaustion on
another CPU.

Tested on QEMU with two host CPUs and the VMID width temporarily
forced to 2 bits. Repeated rollover, protection against premature VMID
reuse, activation-versus-rollover stress, and vCPU migration were
exercised with multiple concurrent guests without guest failures or
host warnings.

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Wenlong Li <wenlongli486@gmail.com>
---
 arch/riscv/include/asm/kvm_gstage.h |   5 +-
 arch/riscv/include/asm/kvm_vmid.h   |  26 ++-
 arch/riscv/kvm/main.c               |  12 +-
 arch/riscv/kvm/mmu.c                |   5 +-
 arch/riscv/kvm/tlb.c                |   9 +-
 arch/riscv/kvm/vcpu.c               |   4 +-
 arch/riscv/kvm/vcpu_sbi_replace.c   |   4 +-
 arch/riscv/kvm/vcpu_sbi_v01.c       |   6 +-
 arch/riscv/kvm/vmid.c               | 347 ++++++++++++++++++++++++----
 9 files changed, 348 insertions(+), 70 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1b77..7a295e106005 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -8,7 +8,7 @@
 #define __RISCV_KVM_GSTAGE_H_
 
 #include <linux/kvm_types.h>
-
+#include <asm/kvm_vmid.h>
 struct kvm_gstage {
 	struct kvm *kvm;
 	unsigned long flags;
@@ -108,7 +108,8 @@ static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *
 {
 	gstage->kvm = kvm;
 	gstage->flags = 0;
-	gstage->vmid = READ_ONCE(kvm->arch.vmid.vmid);
+	gstage->vmid = kvm_riscv_gstage_vmid_hwid(
+			atomic_long_read(&kvm->arch.vmid.id));
 	gstage->pgd = kvm->arch.pgd;
 	gstage->pgd_levels = kvm->arch.pgd_levels;
 }
diff --git a/arch/riscv/include/asm/kvm_vmid.h b/arch/riscv/include/asm/kvm_vmid.h
index db61b0525a8d..78811ab7dba0 100644
--- a/arch/riscv/include/asm/kvm_vmid.h
+++ b/arch/riscv/include/asm/kvm_vmid.h
@@ -6,21 +6,39 @@
 #ifndef __RISCV_KVM_VMID_H_
 #define __RISCV_KVM_VMID_H_
 
+#include <linux/atomic.h>
 #include <linux/kvm_types.h>
 
 struct kvm_vmid {
 	/*
-	 * Writes to vmid_version and vmid happen with vmid_lock held
-	 * whereas reads happen without any lock held.
+	 * Software VMID:
+	 *
+	 *   [ generation | hardware VMID ]
+	 *
+	 * Only the low hardware VMID bits may be written to HGATP
+	 * or used as a hardware fence VMID.
 	 */
-	unsigned long vmid_version;
-	unsigned long vmid;
+	atomic_long_t id;
 };
 
 void __init kvm_riscv_gstage_vmid_detect(void);
 unsigned long kvm_riscv_gstage_vmid_bits(void);
+
+int __init kvm_riscv_gstage_vmid_alloc_init(void);
+void kvm_riscv_gstage_vmid_alloc_free(void);
+
 int kvm_riscv_gstage_vmid_init(struct kvm *kvm);
+
+unsigned long kvm_riscv_gstage_vmid_hwid(unsigned long vmid);
+
 bool kvm_riscv_gstage_vmid_ver_changed(struct kvm_vmid *vmid);
+
 void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu);
 
+/*
+ * Invalidate the current CPU's fast-path VMID state while preserving
+ * the old identity conservatively in reserved_vmids.
+ */
+void kvm_riscv_gstage_vmid_cpu_invalidate(void);
+
 #endif
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 89568ccce01d..d6c6be4df61b 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -16,7 +16,7 @@
 #include <asm/kvm_nacl.h>
 #include <asm/sbi.h>
 #include <asm/kvm_vcpu_vector.h>
-
+#include <asm/kvm_vmid.h>
 static DEFINE_PER_CPU(bool, kvm_riscv_virtualization_enabled);
 
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
@@ -84,6 +84,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 
 void kvm_arch_disable_virtualization_cpu(void)
 {
+	kvm_riscv_gstage_vmid_cpu_invalidate();
 	kvm_riscv_aia_disable();
 	kvm_riscv_csr_cleanup();
 	kvm_riscv_nacl_disable();
@@ -112,6 +113,7 @@ static int kvm_riscv_cpu_pm_notifier(struct notifier_block *self, unsigned long
 		 * is enabled on this CPU.
 		 */
 		if (__this_cpu_read(kvm_riscv_virtualization_enabled)) {
+			kvm_riscv_gstage_vmid_cpu_invalidate();
 			kvm_riscv_aia_pm_enter();
 			kvm_riscv_csr_cleanup();
 		}
@@ -130,6 +132,7 @@ static struct notifier_block kvm_riscv_cpu_pm_nb = {
 static void kvm_riscv_teardown(void)
 {
 	kvm_riscv_aia_exit();
+	kvm_riscv_gstage_vmid_alloc_free();
 	kvm_riscv_nacl_exit();
 	kvm_riscv_v_exit();
 	kvm_unregister_perf_callbacks();
@@ -181,8 +184,15 @@ static int __init riscv_kvm_init(void)
 
 	kvm_riscv_gstage_vmid_detect();
 
+	rc = kvm_riscv_gstage_vmid_alloc_init();
+	if (rc) {
+		kvm_riscv_nacl_exit();
+		return rc;
+	}
+
 	rc = kvm_riscv_aia_init();
 	if (rc && rc != -ENODEV) {
+		kvm_riscv_gstage_vmid_alloc_free();
 		kvm_riscv_nacl_exit();
 		return rc;
 	}
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 6035b5ec9503..db49fac8e9af 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -15,7 +15,7 @@
 #include <linux/sched/signal.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>
-
+#include <asm/kvm_vmid.h>
 static bool __read_mostly eager_page_split = true;
 module_param(eager_page_split, bool, 0644);
 
@@ -799,10 +799,11 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
 {
 	struct kvm_arch *ka = &vcpu->kvm->arch;
+	unsigned long vmid = atomic_long_read(&ka->vmid.id);
 	unsigned long hgatp = kvm_riscv_gstage_mode(ka->pgd_levels)
 			      << HGATP_MODE_SHIFT;
 
-	hgatp |= (READ_ONCE(ka->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
+	hgatp |= (kvm_riscv_gstage_vmid_hwid(vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
 	hgatp |= (ka->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
 
 	ncsr_write(CSR_HGATP, hgatp);
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 2ae34632cdcb..36678aeb64ef 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -224,7 +224,7 @@ void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
 	 * entries by VMID whenever underlying Host CPU changes for a VCPU.
 	 */
 
-	vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
+	vmid = kvm_riscv_gstage_vmid_hwid(atomic_long_read(&vcpu->kvm->arch.vmid.id));
 	kvm_riscv_local_hfence_gvma_vmid_all(vmid);
 
 	/*
@@ -244,7 +244,7 @@ void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
 void kvm_riscv_tlb_flush_process(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
-	unsigned long vmid = READ_ONCE(v->vmid);
+	unsigned long vmid = kvm_riscv_gstage_vmid_hwid(atomic_long_read(&v->id));
 
 	if (kvm_riscv_nacl_available())
 		nacl_hfence_gvma_vmid_all(nacl_shmem(), vmid);
@@ -255,7 +255,7 @@ void kvm_riscv_tlb_flush_process(struct kvm_vcpu *vcpu)
 void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
-	unsigned long vmid = READ_ONCE(v->vmid);
+	unsigned long vmid = kvm_riscv_gstage_vmid_hwid(atomic_long_read(&v->id));
 
 	if (kvm_riscv_nacl_available())
 		nacl_hfence_vvma_all(nacl_shmem(), vmid);
@@ -533,6 +533,7 @@ int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 nr_pages)
 {
 	kvm_riscv_hfence_gvma_vmid_gpa(kvm, -1UL, 0,
 				       gfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT,
-				       PAGE_SHIFT, READ_ONCE(kvm->arch.vmid.vmid));
+				       PAGE_SHIFT, kvm_riscv_gstage_vmid_hwid(
+						atomic_long_read(&kvm->arch.vmid.id)));
 	return 0;
 }
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index e062ca19f9d8..85542c1a5ec3 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -943,14 +943,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			continue;
 		ret = 1;
 
-		kvm_riscv_gstage_vmid_update(vcpu);
-
 		ret = kvm_riscv_check_vcpu_requests(vcpu);
 		if (ret <= 0)
 			continue;
 
 		preempt_disable();
 
+		kvm_riscv_gstage_vmid_update(vcpu);
+
 		/* Update AIA HW state before entering guest */
 		ret = kvm_riscv_vcpu_aia_update(vcpu);
 		if (ret <= 0) {
diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 506a510b6bff..84ba5ce4131e 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -104,7 +104,7 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_FENCE_I_SENT);
 		break;
 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
-		vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
+		vmid = kvm_riscv_gstage_vmid_hwid(atomic_long_read(&vcpu->kvm->arch.vmid.id));
 		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
 			kvm_riscv_hfence_vvma_all(vcpu->kvm, hbase, hmask, vmid);
 		else
@@ -113,7 +113,7 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_SENT);
 		break;
 	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
-		vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
+		vmid = kvm_riscv_gstage_vmid_hwid(atomic_long_read(&vcpu->kvm->arch.vmid.id));
 		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
 			kvm_riscv_hfence_vvma_asid_all(vcpu->kvm, hbase, hmask,
 						       cp->a4, vmid);
diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
index de544ea3f28d..e38794838ca4 100644
--- a/arch/riscv/kvm/vcpu_sbi_v01.c
+++ b/arch/riscv/kvm/vcpu_sbi_v01.c
@@ -88,14 +88,16 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		if (cp->a7 == SBI_EXT_0_1_REMOTE_FENCE_I)
 			kvm_riscv_fence_i(vcpu->kvm, hbase, hmask);
 		else if (cp->a7 == SBI_EXT_0_1_REMOTE_SFENCE_VMA) {
-			vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
+			vmid = kvm_riscv_gstage_vmid_hwid(
+				   atomic_long_read(&vcpu->kvm->arch.vmid.id));
 			if (cp->a1 == 0 && cp->a2 == 0)
 				kvm_riscv_hfence_vvma_all(vcpu->kvm, hbase, hmask, vmid);
 			else
 				kvm_riscv_hfence_vvma_gva(vcpu->kvm, hbase, hmask, cp->a1,
 							  cp->a2, PAGE_SHIFT, vmid);
 		} else {
-			vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
+			vmid = kvm_riscv_gstage_vmid_hwid(
+				   atomic_long_read(&vcpu->kvm->arch.vmid.id));
 			if (cp->a1 == 0 && cp->a2 == 0)
 				kvm_riscv_hfence_vvma_asid_all(vcpu->kvm, hbase, hmask,
 							       cp->a3, vmid);
diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
index c15bdb1dd8be..05819e4f7cb5 100644
--- a/arch/riscv/kvm/vmid.c
+++ b/arch/riscv/kvm/vmid.c
@@ -6,11 +6,15 @@
  *     Anup Patel <anup.patel@wdc.com>
  */
 
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/kvm_host.h>
 #include <asm/csr.h>
@@ -18,26 +22,54 @@
 #include <asm/kvm_tlb.h>
 #include <asm/kvm_vmid.h>
 
-static unsigned long vmid_version = 1;
-static unsigned long vmid_next;
+static atomic_long_t vmid_generation;
+static unsigned long *vmid_map;
 static unsigned long vmid_bits __ro_after_init;
-static DEFINE_SPINLOCK(vmid_lock);
+static unsigned long vmid_cur_idx = 1;
+
+static DEFINE_RAW_SPINLOCK(vmid_lock);
+
+static DEFINE_PER_CPU(atomic_long_t, active_vmids);
+static DEFINE_PER_CPU(unsigned long, reserved_vmids);
+
+static cpumask_t tlb_flush_pending;
+
+#define VMID_FIRST_VERSION	(1UL << vmid_bits)
+#define NUM_VMIDS		VMID_FIRST_VERSION
+#define VMID_HW_MASK		(NUM_VMIDS - 1)
+
+static bool vmid_gen_match(unsigned long vmid)
+{
+	return !((vmid ^ atomic_long_read(&vmid_generation)) >> vmid_bits);
+}
+
+unsigned long kvm_riscv_gstage_vmid_hwid(unsigned long vmid)
+{
+	if (!vmid_bits)
+		return 0;
+
+	return vmid & VMID_HW_MASK;
+}
 
 void __init kvm_riscv_gstage_vmid_detect(void)
 {
-	/* Figure-out number of VMID bits in HW */
+	/* Figure out the number of VMID bits supported by hardware. */
 	csr_write(CSR_HGATP, (kvm_riscv_gstage_mode(kvm_riscv_gstage_max_pgd_levels) <<
-			      HGATP_MODE_SHIFT) | HGATP_VMID);
+		   HGATP_MODE_SHIFT) | HGATP_VMID);
 	vmid_bits = csr_read(CSR_HGATP);
 	vmid_bits = (vmid_bits & HGATP_VMID) >> HGATP_VMID_SHIFT;
 	vmid_bits = fls_long(vmid_bits);
 	csr_write(CSR_HGATP, 0);
 
-	/* We polluted local TLB so flush all guest TLB */
+	/* Flush the local guest TLB after probing HGATP. */
 	kvm_riscv_local_hfence_gvma_all();
 
-	/* We don't use VMID bits if they are not sufficient */
-	if ((1UL << vmid_bits) < num_possible_cpus())
+	/*
+	 * VMID 0 is reserved.  During rollover every possible CPU may
+	 * reserve one hardware VMID, and we still need at least one VMID
+	 * available for a new allocation.
+	 */
+	if (vmid_bits && NUM_VMIDS - 1 <= num_possible_cpus())
 		vmid_bits = 0;
 }
 
@@ -46,80 +78,293 @@ unsigned long kvm_riscv_gstage_vmid_bits(void)
 	return vmid_bits;
 }
 
+int __init kvm_riscv_gstage_vmid_alloc_init(void)
+{
+	int cpu;
+
+	if (!vmid_bits)
+		return 0;
+
+	vmid_map = bitmap_zalloc(NUM_VMIDS, GFP_KERNEL);
+	if (!vmid_map)
+		return -ENOMEM;
+
+	vmid_cur_idx = 1;
+
+	/* Hardware VMID 0 is reserved. */
+	__set_bit(0, vmid_map);
+
+	atomic_long_set(&vmid_generation, VMID_FIRST_VERSION);
+
+	for_each_possible_cpu(cpu) {
+		atomic_long_set(&per_cpu(active_vmids, cpu), 0);
+		per_cpu(reserved_vmids, cpu) = 0;
+	}
+
+	/*
+	 * Every CPU performs an initial local invalidation before its
+	 * first VMID activation.
+	 */
+	cpumask_copy(&tlb_flush_pending, cpu_possible_mask);
+
+	return 0;
+}
+
+void kvm_riscv_gstage_vmid_alloc_free(void)
+{
+	bitmap_free(vmid_map);
+	vmid_map = NULL;
+}
+
 int kvm_riscv_gstage_vmid_init(struct kvm *kvm)
 {
-	/* Mark the initial VMID and VMID version invalid */
-	kvm->arch.vmid.vmid_version = 0;
-	kvm->arch.vmid.vmid = 0;
+	atomic_long_set(&kvm->arch.vmid.id, 0);
 
 	return 0;
 }
 
 bool kvm_riscv_gstage_vmid_ver_changed(struct kvm_vmid *vmid)
 {
+	unsigned long id;
+
 	if (!vmid_bits)
 		return false;
 
-	return unlikely(READ_ONCE(vmid->vmid_version) !=
-			READ_ONCE(vmid_version));
+	id = atomic_long_read(&vmid->id);
+
+	return unlikely(!vmid_gen_match(id));
 }
 
-static void __local_hfence_gvma_all(void *info)
+/*
+ * Called with vmid_lock held after vmid_generation has already been
+ * advanced.
+ *
+ * No remote CPU is interrupted here.  Instead, preserve every VMID
+ * which may still be used by a CPU and queue a local invalidation for
+ * that CPU's next VMID activation.
+ */
+static void flush_context(void)
 {
-	kvm_riscv_local_hfence_gvma_all();
+	unsigned long vmid;
+	int cpu;
+
+	bitmap_zero(vmid_map, NUM_VMIDS);
+	__set_bit(0, vmid_map);
+
+	for_each_possible_cpu(cpu) {
+		vmid = atomic_long_xchg(&per_cpu(active_vmids, cpu), 0);
+
+		/*
+		 * The CPU may already have been caught by an earlier rollover
+		 * without performing another activation since then.  In that
+		 * case reserved_vmids is the only record of the old context.
+		 */
+		if (!vmid)
+			vmid = per_cpu(reserved_vmids, cpu);
+
+		if (vmid)
+			__set_bit(kvm_riscv_gstage_vmid_hwid(vmid),
+				  vmid_map);
+
+		per_cpu(reserved_vmids, cpu) = vmid;
+	}
+
+	cpumask_copy(&tlb_flush_pending, cpu_possible_mask);
+}
+
+/*
+ * Update every reserved copy of an old software VMID.
+ *
+ * Do not stop after the first match: the same VM may have been active
+ * on more than one CPU when rollover occurred.
+ */
+static bool check_update_reserved_vmid(unsigned long old_vmid,
+				       unsigned long new_vmid)
+{
+	bool hit = false;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(reserved_vmids, cpu) == old_vmid) {
+			per_cpu(reserved_vmids, cpu) = new_vmid;
+			hit = true;
+		}
+	}
+
+	return hit;
+}
+
+/*
+ * Allocate/promote a software VMID.
+ *
+ * vmid_lock must be held by the caller.
+ */
+static unsigned long new_vmid_locked(struct kvm_vmid *kvm_vmid)
+{
+	unsigned long vmid = atomic_long_read(&kvm_vmid->id);
+	unsigned long generation = atomic_long_read(&vmid_generation);
+	unsigned long new_vmid;
+
+	if (vmid) {
+		new_vmid = generation |
+			   kvm_riscv_gstage_vmid_hwid(vmid);
+
+		/*
+		 * The old VMID is still protected by one or more CPUs.
+		 * Keep the same hardware VMID and only promote generation.
+		 */
+		if (check_update_reserved_vmid(vmid, new_vmid))
+			return new_vmid;
+
+		/*
+		 * The VM had a VMID in an older generation.  Reuse the same
+		 * hardware number if it has not already been claimed.
+		 */
+		if (!__test_and_set_bit(
+			    kvm_riscv_gstage_vmid_hwid(vmid), vmid_map))
+			return new_vmid;
+	}
+
+	/*
+	 * Find a free VMID in the current generation.
+	 */
+	vmid = find_next_zero_bit(vmid_map, NUM_VMIDS, vmid_cur_idx);
+	if (vmid != NUM_VMIDS)
+		goto set_vmid;
+
+	/*
+	 * No free VMID.  Start a new generation, preserve all CPU-local
+	 * users, and defer each CPU's flush until its next activation.
+	 */
+	generation = atomic_long_add_return(VMID_FIRST_VERSION,
+					    &vmid_generation);
+	flush_context();
+
+	/*
+	 * NUM_VMIDS - 1 > num_possible_cpus(), therefore rollover must
+	 * leave at least one allocatable hardware VMID.
+	 */
+	vmid = find_next_zero_bit(vmid_map, NUM_VMIDS, 1);
+
+set_vmid:
+	__set_bit(vmid, vmid_map);
+	vmid_cur_idx = vmid;
+
+	return generation | vmid;
 }
 
 void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu)
 {
-	unsigned long i;
+	struct kvm_vmid *kvm_vmid = &vcpu->kvm->arch.vmid;
+	atomic_long_t *active;
 	struct kvm_vcpu *v;
-	struct kvm_vmid *vmid = &vcpu->kvm->arch.vmid;
+	unsigned long flags;
+	unsigned long vmid;
+	unsigned long old_active_vmid;
+	unsigned long i;
+	unsigned int cpu;
+	bool vmid_changed = false;
 
-	if (!kvm_riscv_gstage_vmid_ver_changed(vmid))
+	if (!vmid_bits)
 		return;
 
-	spin_lock(&vmid_lock);
+	/*
+	 * active_vmids and tlb_flush_pending are per-CPU admission state.
+	 * They must refer to the same CPU for the complete activation.
+	 */
+	preempt_disable();
+
+	cpu = smp_processor_id();
+	active = this_cpu_ptr(&active_vmids);
+
+	vmid = atomic_long_read(&kvm_vmid->id);
+	old_active_vmid = atomic_long_read(active);
 
 	/*
-	 * We need to re-check the vmid_version here to ensure that if
-	 * another vcpu already allocated a valid vmid for this vm.
+	 * Fast path.
+	 *
+	 * The cmpxchg races with flush_context()'s xchg on the same
+	 * per-CPU atomic.  Either this activation is captured by rollover,
+	 * or rollover clears active first and the cmpxchg fails.
 	 */
-	if (!kvm_riscv_gstage_vmid_ver_changed(vmid)) {
-		spin_unlock(&vmid_lock);
-		return;
+	if (old_active_vmid &&
+	    vmid_gen_match(vmid) &&
+	    atomic_long_cmpxchg(active, old_active_vmid, vmid) ==
+	    old_active_vmid)
+		goto out;
+
+	raw_spin_lock_irqsave(&vmid_lock, flags);
+
+	/*
+	 * Re-read under the allocator lock because another vCPU of this VM
+	 * may already have promoted or allocated the shared VMID.
+	 */
+	vmid = atomic_long_read(&kvm_vmid->id);
+
+	if (!vmid_gen_match(vmid)) {
+		vmid = new_vmid_locked(kvm_vmid);
+		atomic_long_set(&kvm_vmid->id, vmid);
+		vmid_changed = true;
 	}
 
-	/* First user of a new VMID version? */
-	if (unlikely(vmid_next == 0)) {
-		WRITE_ONCE(vmid_version, READ_ONCE(vmid_version) + 1);
-		vmid_next = 1;
+	/*
+	 * Even if another vCPU already updated the shared VMID, this CPU
+	 * must still discharge its own rollover flush obligation.
+	 */
+	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+		kvm_riscv_local_hfence_gvma_all();
 
-		/*
-		 * We ran out of VMIDs so we increment vmid_version and
-		 * start assigning VMIDs from 1.
-		 *
-		 * This also means existing VMIDs assignment to all Guest
-		 * instances is invalid and we have force VMID re-assignement
-		 * for all Guest instances. The Guest instances that were not
-		 * running will automatically pick-up new VMIDs because will
-		 * call kvm_riscv_gstage_vmid_update() whenever they enter
-		 * in-kernel run loop. For Guest instances that are already
-		 * running, we force VM exits on all host CPUs using IPI and
-		 * flush all Guest TLBs.
-		 */
-		on_each_cpu_mask(cpu_online_mask, __local_hfence_gvma_all,
-				 NULL, 1);
+	/*
+	 * Publish the CPU-local active identity only after the required
+	 * local invalidation is complete.
+	 */
+	atomic_long_set(active, vmid);
+
+	raw_spin_unlock_irqrestore(&vmid_lock, flags);
+
+	/*
+	 * A new software VMID may contain a different hardware VMID, so
+	 * request an HGATP update for every vCPU in the VM.
+	 */
+	if (vmid_changed) {
+		kvm_for_each_vcpu(i, v, vcpu->kvm)
+			kvm_make_request(KVM_REQ_UPDATE_HGATP, v);
 	}
 
-	vmid->vmid = vmid_next;
-	vmid_next++;
-	vmid_next &= (1 << vmid_bits) - 1;
+out:
+	preempt_enable();
+}
+
+/*
+ * CPU virtualization/CSR state is being discarded.
+ *
+ * Withdraw fast-path eligibility, but conservatively preserve the last
+ * identity instead of making its hardware VMID immediately reusable.
+ */
+void kvm_riscv_gstage_vmid_cpu_invalidate(void)
+{
+	unsigned long flags;
+	unsigned long vmid;
+	unsigned int cpu;
 
-	WRITE_ONCE(vmid->vmid_version, READ_ONCE(vmid_version));
+	if (!vmid_bits)
+		return;
 
-	spin_unlock(&vmid_lock);
+	lockdep_assert_preemption_disabled();
+
+	cpu = smp_processor_id();
+
+	raw_spin_lock_irqsave(&vmid_lock, flags);
+
+	vmid = atomic_long_xchg(this_cpu_ptr(&active_vmids), 0);
+
+	if (vmid)
+		per_cpu(reserved_vmids, cpu) = vmid;
+
+	/*
+	 * If active was already zero, retain the old reserved entry.
+	 */
+	cpumask_set_cpu(cpu, &tlb_flush_pending);
 
-	/* Request G-stage page table update for all VCPUs */
-	kvm_for_each_vcpu(i, v, vcpu->kvm)
-		kvm_make_request(KVM_REQ_UPDATE_HGATP, v);
+	raw_spin_unlock_irqrestore(&vmid_lock, flags);
 }
-- 
2.47.3

