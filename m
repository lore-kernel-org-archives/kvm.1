Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F534A77D;
	Mon, 17 Aug 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962635; cv=none; b=F+gYL8XshjyuGnfMIsesphPc1yu4jr1fw/XE7oprBAZdIFrxnCqauZovVfRQ6ZMke+VAzjNKIqNVNLE8xd3IWGTxpeYKe6B+Ps0XS9O965b9sZlX6hc4KXGjPgL44uJRUDBZddOkvZnCaB/5NllNm4m0QmGRMhK/KpY+1n29Bdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962635; c=relaxed/simple;
	bh=rLta7c9UNxhLPMC3tzbD+MDihNhuVICKvjjHUjcpGVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1/ihaaBjEpgqwzq87V6nqctR/+8UMHijM0lKdPwyyP8YgxKPvK74NabtYeT84WvKG9JFoMKKAet2PDBr5UKXze5/4QJ0Pnl6T8pekdV8pxa/haFTr+lHYsB2u8a9uBaUn549iFdLwssTm41YceNjOjc8BnujxykDRxeC2Vz21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b=EhpFkqZO; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b="EhpFkqZO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bosc.ac.cn; s=default;
	t=1786962622; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bSkLJIwWoBbKXTGld5vNA2SwhsKRhDDs4ksXo9qv2/Y=;
	b=EhpFkqZOOK1EfO4J1jjsTp46nNGCDp84gAQbb3hlG/sOuuowt1Z7yC1+XU5oZu4WH2+1G4oBS4Q+dHWScMQynohRS5ch+gYPZc5qH8XNHUN2TkFTL0HC5zUOUd7WiGrwHmVVArv8WQ0z3hjck4OFkQRWIXRSWPE87wKHC/dpoFEgSJvCxSoJB3JWkNgclNwX1KaziStugmK6jmlx9JkTwA7X+s6vgK5+y5/ZGzUTWtBTpjV+EStFXmMTeQmS9HARwJfcneBSEvvBBV5DSQvqVagwQuuSEBnBIb4euXfLwxJ5vogP65YNjgJb296KFXy/1kJbtrXRs3F4DNcJ7WGp+g==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07441667|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00759289-3.75725e-05-0.99237;FP=13670882455029613794|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=guoyaxing@bosc.ac.cn;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.ip799S6_1786962290;
Received: from guoyaxing..(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.ip799S6_1786962290 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 18:25:00 +0800
From: Yaxing Guo <guoyaxing@bosc.ac.cn>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	majiuyue@bosc.ac.cn,
	anzoso@outlook.com,
	guoyaxing@bosc.ac.cn
Subject: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
Date: Mon, 17 Aug 2026 18:24:47 +0800
Message-ID: <20260817102447.40259-1-guoyaxing@bosc.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guest Linux uses mm_cpumask to decide whether an sfence.vma needs to be
local or remote. Under KVM that mask tracks guest CPUs, not the host CPUs
that previously backed a vCPU.

This can miss stale VS-stage TLB entries when a vCPU migrates across host
CPUs. For example:

  - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
  - vcpu0 migrates to host CPU0.
  - the guest updates the mapping on vcpu0 and issues a local sfence.vma.
  - later, the guest task runs on vcpu1 while vcpu1 is backed by host CPU1.

Host CPU1 did not observe the guest-local sfence.vma, and KVM can enter
vcpu1 with a stale VS-stage translation left behind by vcpu0.

The reported failure was seen on a XiangShan RISC-V system. A bash task
ran on vcpu0 while vcpu0 was backed by host CPU1, and a read-only page was
prefetched into CPU1's VS-stage TLB. vcpu0 later migrated to host CPU0,
where the guest triggered COW, updated the mapping, and issued only a local
sfence.vma. The stale VS-stage entry on CPU1 survived. When the same guest
task later ran on another vCPU backed by host CPU1, it hit the stale
translation. The page contained a GOT pointer, and using the stale data led
to a NULL dereference and a userspace segmentation fault.

The existing local TLB sanitize path flushes G-stage entries when a vCPU
migrates, and flushes VS-stage entries only for implementations selected by
the Andes-specific kvm_riscv_vsstage_tlb_no_gpa static key. That handles a
split two-stage TLB implementation where HFENCE.GVMA does not invalidate
VS-stage entries, but it does not cover the generic guest-local sfence.vma
case above.

Track, per VM and per host CPU, the last vCPU that entered the guest on
that CPU. Before guest entry, flush the current CPU's VS-stage context for
the VM if either the current vCPU migrated since its last exit, or this
host CPU is switching from another vCPU of the same VM. Keep the existing
HFENCE.GVMA behavior tied to vCPU migration.

This also subsumes the Andes split-TLB workaround. That workaround was
needed because the migration sanitize path previously relied on
HFENCE.GVMA alone for most implementations, and only issued HFENCE.VVMA
when kvm_riscv_vsstage_tlb_no_gpa was set. The new sanitize path always
issues HFENCE.VVMA when reusing a host CPU for a VM context that may have
missed a guest-local sfence.vma, so it no longer depends on HFENCE.GVMA
invalidating VS-stage entries. The implementation-specific static key and
setup hook are therefore no longer needed.

Reported-by: Zhizun Wang <anzoso@outlook.com>
Reviewed-by: Jiuyue Ma <majiuyue@bosc.ac.cn>
Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
 arch/riscv/include/asm/kvm_host.h |  6 +++---
 arch/riscv/kvm/main.c             | 15 ---------------
 arch/riscv/kvm/tlb.c              | 31 +++++++++++++++++++++++--------
 arch/riscv/kvm/vm.c               | 16 ++++++++++++++++
 4 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 24585304c..396ac6209 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -91,6 +91,9 @@ struct kvm_arch {
 	/* G-stage vmid */
 	struct kvm_vmid vmid;
 
+	/* Last VCPU that ran on each physical CPU */
+	int __percpu *last_vcpu_ran;
+
 	/* G-stage page table */
 	pgd_t *pgd;
 	phys_addr_t pgd_phys;
@@ -330,7 +333,4 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
 
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
 
-/* Flags representing implementation specific details */
-DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
-
 #endif /* __RISCV_KVM_HOST_H__ */
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 0f3fe3986..b1bbc0835 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -10,23 +10,10 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/kvm_host.h>
-#include <asm/cpufeature.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>
 #include <asm/sbi.h>
 
-DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
-
-static void kvm_riscv_setup_vendor_features(void)
-{
-	/* Andes AX66: split two-stage TLBs */
-	if (riscv_cached_mvendorid(0) == ANDES_VENDOR_ID &&
-	    (riscv_cached_marchid(0) & 0xFFFF) == 0x8A66) {
-		static_branch_enable(&kvm_riscv_vsstage_tlb_no_gpa);
-		kvm_info("VS-stage TLB does not cache guest physical address and VMID\n");
-	}
-}
-
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
 {
@@ -172,8 +159,6 @@ static int __init riscv_kvm_init(void)
 		kvm_info("AIA available with %d guest external interrupts\n",
 			 kvm_riscv_aia_nr_hgei);
 
-	kvm_riscv_setup_vendor_features();
-
 	kvm_register_perf_callbacks();
 
 	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index ff1aeac4e..1541d059a 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
@@ -160,12 +161,19 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
 
 void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
 {
+	bool vcpu_migrated;
+	bool vcpu_switched;
 	unsigned long vmid;
+	int *last_ran;
 
-	if (!kvm_riscv_gstage_vmid_bits() ||
-	    vcpu->arch.last_exit_cpu == vcpu->cpu)
+	last_ran = this_cpu_ptr(vcpu->kvm->arch.last_vcpu_ran);
+	vcpu_migrated = (vcpu->arch.last_exit_cpu != vcpu->cpu);
+	vcpu_switched = (*last_ran != vcpu->vcpu_idx);
+	if (!vcpu_migrated && !vcpu_switched)
 		return;
 
+	vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
+
 	/*
 	 * On RISC-V platforms with hardware VMID support, we share same
 	 * VMID for all VCPUs of a particular Guest/VM. This means we might
@@ -176,16 +184,23 @@ void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
 	 * To cleanup stale TLB entries, we simply flush all G-stage TLB
 	 * entries by VMID whenever underlying Host CPU changes for a VCPU.
 	 */
-
-	vmid = READ_ONCE(vcpu->kvm->arch.vmid.vmid);
-	kvm_riscv_local_hfence_gvma_vmid_all(vmid);
+	if (vcpu_migrated && kvm_riscv_gstage_vmid_bits())
+		kvm_riscv_local_hfence_gvma_vmid_all(vmid);
 
 	/*
-	 * Flush VS-stage TLB entries for implementation where VS-stage
-	 * TLB does not cahce guest physical address and VMID.
+	 * Guest-local sfence.vma only invalidates VS-stage translations on
+	 * the Host CPU currently backing the VCPU. If a VCPU migrates, or
+	 * if this Host CPU switches between VCPUs of the same VM, stale
+	 * VS-stage entries can be left behind on a Host CPU that missed a
+	 * guest-local flush. Flush the current CPU's VS-stage context before
+	 * entering the guest.
 	 */
-	if (static_branch_unlikely(&kvm_riscv_vsstage_tlb_no_gpa))
+	if (kvm_riscv_nacl_available())
+		nacl_hfence_vvma_all(nacl_shmem(), vmid);
+	else
 		kvm_riscv_local_hfence_vvma_all(vmid);
+
+	*last_ran = vcpu->vcpu_idx;
 }
 
 void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 13c63ae1a..2907218a1 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/percpu.h>
 #include <linux/uaccess.h>
 #include <linux/kvm_host.h>
 #include <asm/kvm_mmu.h>
@@ -30,7 +31,9 @@ const struct kvm_stats_header kvm_vm_stats_header = {
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
+	int *last_ran;
 	int r;
+	int cpu;
 
 	r = kvm_riscv_mmu_alloc_pgd(kvm);
 	if (r)
@@ -42,6 +45,17 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		return r;
 	}
 
+	kvm->arch.last_vcpu_ran = alloc_percpu(int);
+	if (!kvm->arch.last_vcpu_ran) {
+		kvm_riscv_mmu_free_pgd(kvm);
+		return -ENOMEM;
+	}
+
+	for_each_possible_cpu(cpu) {
+		last_ran = per_cpu_ptr(kvm->arch.last_vcpu_ran, cpu);
+		*last_ran = -1;
+	}
+
 	kvm_riscv_aia_init_vm(kvm);
 
 	kvm_riscv_guest_timer_init(kvm);
@@ -54,6 +68,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_destroy_vcpus(kvm);
 
 	kvm_riscv_aia_destroy_vm(kvm);
+
+	free_percpu(kvm->arch.last_vcpu_ran);
 }
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
-- 
2.43.0

