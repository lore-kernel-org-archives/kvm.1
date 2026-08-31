Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6D3CF201;
	Mon, 31 Aug 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170085; cv=none; b=AnStX+ZuEd712lhgp+BE8ZeKLDsWOk+BRFX2E63pqNU96PBXU14A6U5qhaKs8JmNO4nRsiUpCfpIiElAa4mLlQDX+qUPbw3zA4FBUHTJOC9ZbU6dLpRBn7mfhOwqU6N2lxrjKPTCXmmIE35oH7pk5LwAkyXzaCsyqUZMBBzfTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170085; c=relaxed/simple;
	bh=R3R1jTkrD7xCKzb6vZI8gU7hsmNtfk0+vBBFFAfVGJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8zYtAw7arw8xeUsCIvqJpTaQnZImbUZouv0MzbDlYrVm3ZphHPcwY9zvQ3jxO34Vs2pWZF8D/fqIliAAAnVZg2iVP4PVeYelRR8H4sehJz3TDXIwylbaoHQ3LyDW9dzW0Pf4qUEcjqXasMxVzEGPrh0/Caav0fmFo4YJvLW6q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxLtNgT5Vqx90GAA--.19278S3;
	Mon, 31 Aug 2026 17:54:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxKs5eT5VqDTYYAA--.20453S4;
	Mon, 31 Aug 2026 17:54:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] LoongArch: KVM: Implement vmid updating logic
Date: Mon, 31 Aug 2026 17:47:15 +0800
Message-Id: <20260831094716.4016652-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260831094716.4016652-1-maobibo@loongson.cn>
References: <20260831094716.4016652-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKs5eT5VqDTYYAA--.20453S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

VMID calculation method is the same with ASID on LoongArch, it is
percpu vmid calculation method. For every physical CPU, VMID of
different VM is different, and it is the same for different vCPUs
of the same VM.

When vCPU is scheduled on the physical CPU, it checked vmid of this
VM and the global cached vmid, and judge whether it is valid or not.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  7 ++++
 arch/loongarch/kvm/main.c             | 55 ++++++++++++++++++++++++---
 arch/loongarch/kvm/mmu.c              | 30 +++++++++++++--
 arch/loongarch/kvm/tlb.c              | 14 +++++++
 4 files changed, 97 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 5c2f76d1e2f8..8273122604d8 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -79,6 +79,7 @@ struct kvm_arch_memory_slot {
 #define HOST_MAX_PMNUM			16
 struct kvm_context {
 	unsigned long vpid_cache;
+	unsigned long vmid_cache;
 	struct kvm_vcpu *last_vcpu;
 	/* Host PMU CSR */
 	u64 perf_ctrl[HOST_MAX_PMNUM];
@@ -132,6 +133,8 @@ struct kvm_arch {
 	unsigned long kvm_features;
 
 	s64 time_offset;
+	cpumask_t tlb_flush_pending;
+	unsigned long vmid[NR_CPUS];
 	struct kvm_context __percpu *vmcs;
 	struct loongarch_ipi *ipi;
 	struct loongarch_dmsintc *dmsintc;
@@ -319,6 +322,8 @@ bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 
 /* MMU handling */
+void kvm_flush_tlb_all_stage1(void);
+void kvm_flush_tlb_all_stage2(void);
 void kvm_flush_tlb_all(void);
 void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa);
 int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long badv, bool write, int ecode);
@@ -353,6 +358,8 @@ static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot) {}
 void kvm_check_vpid(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer);
+#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
+int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
 void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm, const struct kvm_memory_slot *memslot);
 void kvm_init_vmcs(struct kvm *kvm);
 void kvm_exc_entry(void);
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index a98f0284134a..0099d0f0b803 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -218,7 +218,10 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
 		++vpid; /* vpid 0 reserved for root */
 
 		/* start new vpid cycle */
-		kvm_flush_tlb_all();
+		if (!cpu_has_guestid)
+			kvm_flush_tlb_all();
+		else
+			kvm_flush_tlb_all_stage1();
 	}
 
 	context->vpid_cache = vpid;
@@ -278,15 +281,54 @@ static void __kvm_check_vpid(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
+static void kvm_update_vmid(struct kvm_vcpu *vcpu, int cpu)
 {
 	unsigned long vmid;
+	struct kvm_context *context;
+
+	context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
+	vmid = context->vmid_cache + 1;
+	if (!(vmid & vpid_mask)) {
+		/* finish round of vmid loop */
+		if (unlikely(!vmid))
+			vmid = vpid_mask + 1;
+
+		++vmid; /* vmid 0 reserved for root */
+
+		/* start new vmid cycle */
+		kvm_flush_tlb_all_stage2();
+	}
+
+	context->vmid_cache = vmid;
+	vcpu->kvm->arch.vmid[cpu] = vmid;
+}
 
-	vmid = vcpu->arch.vpid & vpid_mask;
-	if (vcpu->arch.tgid != vmid) {
-		vcpu->arch.tgid = vcpu->arch.vpid & vpid_mask;
-		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
+{
+	int cpu;
+	unsigned long ver, old, vmid;
+
+	/* On some machines like 3A5000, vmid needs the same with vpid */
+	if (!cpu_has_guestid) {
+		vmid = vcpu->arch.vpid & vpid_mask;
+		if (vcpu->arch.tgid != vmid) {
+			vcpu->arch.tgid = vcpu->arch.vpid & vpid_mask;
+			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+		}
+		return;
 	}
+
+	cpu = smp_processor_id();
+	if (cpumask_test_and_clear_cpu(cpu, &vcpu->kvm->arch.tlb_flush_pending))
+		vcpu->kvm->arch.vmid[cpu] = 0;
+
+	/* Check if the vmid is out of an older version */
+	ver = vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
+	old = this_cpu_ptr(vcpu->kvm->arch.vmcs)->vmid_cache & ~vpid_mask;
+	if (ver != old)
+		kvm_update_vmid(vcpu, cpu);
+
+	vcpu->arch.tgid = vcpu->kvm->arch.vmid[cpu] & vpid_mask;
 }
 
 void kvm_check_vpid(struct kvm_vcpu *vcpu)
@@ -392,6 +434,7 @@ static int kvm_loongarch_env_init(void)
 	for_each_possible_cpu(cpu) {
 		context = per_cpu_ptr(vmcs, cpu);
 		context->vpid_cache = vpid_mask + 1;
+		context->vmid_cache = vpid_mask + 1;
 		context->last_vcpu = NULL;
 	}
 
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index e104897aa532..e07ba28cc565 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -893,7 +893,12 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsigned long gpa, bool write)
 		 * there is invalid tlb with small page
 		 * need flush these invalid tlbs for current vcpu
 		 */
-		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+		if (!cpu_has_ptw) {
+			if (!cpu_has_guestid)
+				kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+			else
+				cpumask_set_cpu(vcpu->cpu, &vcpu->kvm->arch.tlb_flush_pending);
+		}
 		++kvm->stat.hugepages;
 	}  else if (kvm_pte_huge(*ptep) && write)
 		ptep = kvm_split_huge(vcpu, ptep, gfn);
@@ -929,8 +934,11 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long gpa, bool write, in
 		 *
 		 * With SW PTW, invalid TLB is added in TLB refill exception.
 		 */
-		vcpu->arch.flush_gpa = gpa;
-		kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+		if (!cpu_has_guestid) {
+			vcpu->arch.flush_gpa = gpa;
+			kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
+		} else
+			cpumask_set_cpu(vcpu->cpu, &vcpu->kvm->arch.tlb_flush_pending);
 	}
 
 	return 0;
@@ -940,6 +948,22 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
 {
 }
 
+int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
+{
+	/*
+	 * Queue a TLB invalidation for each CPU to perform on next
+	 * vcpu loading
+	 */
+	if (cpu_has_guestid) {
+		cpumask_setall(&kvm->arch.tlb_flush_pending);
+		/* Be sure that other CPUS can watch the changes */
+		smp_wmb();
+	}
+
+	/* Return 1 continue to send ipi to running vCPUs */
+	return 1;
+}
+
 void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
 					const struct kvm_memory_slot *memslot)
 {
diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
index afcacb62988a..994216c98ea2 100644
--- a/arch/loongarch/kvm/tlb.c
+++ b/arch/loongarch/kvm/tlb.c
@@ -21,6 +21,20 @@ void kvm_flush_tlb_all(void)
 	local_irq_restore(flags);
 }
 
+/* Invalidate all stage1 TLB entries including GVA-->GPA mappings */
+void kvm_flush_tlb_all_stage1(void)
+{
+	lockdep_assert_irqs_disabled();
+	invtlb_all(INVGTLB_ALLGID_GVA_TO_GPA, 0, 0);
+}
+
+/* Invalidate all stage2 TLB entries including GPA-->HPA  mappings */
+void kvm_flush_tlb_all_stage2(void)
+{
+	lockdep_assert_irqs_disabled();
+	invtlb_all(INVTLB_ALLGID_GPA_TO_HPA, 0, 0);
+}
+
 void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa)
 {
 	unsigned int vmid;
-- 
2.39.3

