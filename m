Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57B3BB13B;
	Thu,  6 Aug 2026 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982504; cv=none; b=gYXXERs2q5n6Z6o9BwxgkA99xKpgqDXglBK3lS4GHpTojpQVZwti2cqvtqMZ6J/lFD9Jt9229B0xhzHW7OWxv5IpqQh5W4O/yuOQYsBxW4vF94XSnZ6lSwToowlWLCBNdUuzqx8ZKviCsYnbyOoPqkVpOB77rF1uCxaOB9/Oy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982504; c=relaxed/simple;
	bh=vLqje1R0wmw0hkuEkX2+EcU/OagBhQaMLcK5D1Yeg8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dUr3vrbtr1DhW7T4CDRgsvogr8K4PagB9pS+iD3/mPndS/XwGUuvv5U7C4r1w3+aOSue0YfTayTVLPIbKG+fmd/Jvj3l+kbb7yWiBb25tRAPxe+DOCj3N4/oddY0PG92Xzs1q41NQRpFsIJs4lgnpt37p/cMiQtZiUm989wihtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxyvAj7nNqQNsKAA--.35008S3;
	Thu, 06 Aug 2026 10:14:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxzMYi7nNqCFQlAA--.58013S2;
	Thu, 06 Aug 2026 10:14:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] LoongArch: KVM: Implement vmid updating logic
Date: Thu,  6 Aug 2026 10:07:38 +0800
Message-Id: <20260806020739.2149268-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260806020739.2149268-1-maobibo@loongson.cn>
References: <20260806020739.2149268-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzMYi7nNqCFQlAA--.58013S2
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
 arch/loongarch/include/asm/kvm_host.h |  7 +++++
 arch/loongarch/kvm/main.c             | 42 ++++++++++++++++++++++++++-
 arch/loongarch/kvm/mmu.c              | 19 +++++++++++-
 arch/loongarch/kvm/tlb.c              | 14 +++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 78f97dea124d..e623f781e2a5 100644
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
index c36e62ab0d91..72c1d23156e5 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -220,6 +220,8 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
 		/* start new vpid cycle */
 		if (!cpu_has_guestid)
 			kvm_flush_tlb_all();
+		else
+			kvm_flush_tlb_all_stage1();
 	}
 
 	context->vpid_cache = vpid;
@@ -279,9 +281,32 @@ static void __kvm_check_vpid(struct kvm_vcpu *vcpu)
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
+
+static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
+{
+	int cpu;
+	unsigned long ver, old, vmid;
 
 	/* On some machines like 3A5000, vmid needs the same with vpid */
 	if (!cpu_has_guestid) {
@@ -291,6 +316,20 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
 			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
 		}
 	}
+
+	cpu = smp_processor_id();
+	if (cpumask_test_and_clear_cpu(cpu, &vcpu->kvm->arch.tlb_flush_pending))
+		vcpu->kvm->arch.vmid[cpu] = 0;
+
+	/*
+	 * Check if our vmid is of an older version
+	 */
+	ver = vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
+	old = this_cpu_ptr(vcpu->kvm->arch.vmcs)->vmid_cache & ~vpid_mask;
+	if (ver != old)
+		kvm_update_vmid(vcpu, cpu);
+
+	vcpu->arch.hw_vmid = vcpu->kvm->arch.vmid[cpu] & vpid_mask;
 }
 
 void kvm_check_vpid(struct kvm_vcpu *vcpu)
@@ -396,6 +435,7 @@ static int kvm_loongarch_env_init(void)
 	for_each_possible_cpu(cpu) {
 		context = per_cpu_ptr(vmcs, cpu);
 		context->vpid_cache = vpid_mask + 1;
+		context->vmid_cache = vpid_mask + 1;
 		context->last_vcpu = NULL;
 	}
 
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 714640a2e614..80e7a8bdc344 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -932,7 +932,8 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long gpa, bool write, in
 		if (!cpu_has_guestid) {
 			vcpu->arch.flush_gpa = gpa;
 			kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
-		}
+		} else
+			cpumask_set_cpu(vcpu->cpu, &vcpu->kvm->arch.tlb_flush_pending);
 	}
 
 	return 0;
@@ -942,6 +943,22 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
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
index b25847aab968..a573db026e01 100644
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

