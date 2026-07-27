Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82320331EA2;
	Mon, 27 Jul 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137450; cv=none; b=qijyvebCqneP2XE7WNDwuFDPG760X7ZBytCoEjUA815wrlpGsLGwcpQ9/T1d5zB6LMieibMyLIC36hUsw1hS3ENCd+JLjSAW54geWZ7MPtrUbeuHK9Vnx6vNB3Lvq+CcqOG8X3bMPlU3FwyQ+8HQVUIB5Mbmq61dRepU7Tm/PbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137450; c=relaxed/simple;
	bh=Xgi8nY5spuA4bSX8QFQma1wylQOwN9QSS6x109YAJi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NeB9r6LGLAy88+jPD7K5KAGHnbilErzhF3byWni+7xYE7xfM26FXOr6d7dGcpE0YVa1aFAQBkgsIHUh8ug5gRHi3VFdin5t6lIb1C5WeNSVP6WXYvp+SwlK1jI0CzvwyZgIcPEM5L9FVUmKq9GVczqDkbytnctNgdCqRBPBJ5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx+aAnCWdqq6kHAA--.4079S3;
	Mon, 27 Jul 2026 15:30:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxLsfqCGdqOz4aAA--.51743S3;
	Mon, 27 Jul 2026 15:30:06 +0800 (CST)
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
Subject: [PATCH 5/6] LoongArch: KVM: Add remote tlb flushing support
Date: Mon, 27 Jul 2026 15:21:08 +0800
Message-Id: <20260727072109.2151675-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260727072109.2151675-1-maobibo@loongson.cn>
References: <20260727072109.2151675-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLsfqCGdqOz4aAA--.51743S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With remote tlb flushing, vpid index stays unchanged and only vmid
index is updated, since remote tlb flushing is to flush TLBs relative
GPA --> HPA.

For flushing method, cpumask tlb_flush_pending is added and set for
all possible CPUs. When vCPUs is sched on the physical CPU, vmid is
updated and cpumask for this physical CPU is cleared.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  3 +++
 arch/loongarch/kvm/main.c             |  2 ++
 arch/loongarch/kvm/mmu.c              | 16 ++++++++++++++++
 arch/loongarch/kvm/vcpu.c             |  7 ++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index a01623c42c7a..2c3cb475abf9 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -133,6 +133,7 @@ struct kvm_arch {
 	unsigned long kvm_features;
 
 	s64 time_offset;
+	cpumask_t tlb_flush_pending;
 	unsigned long vmid[NR_CPUS];
 	struct kvm_context __percpu *vmcs;
 	struct loongarch_ipi *ipi;
@@ -357,6 +358,8 @@ static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot) {}
 void kvm_check_vpid(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer);
+#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
+int kvm_arch_flush_remote_tlbs(struct kvm *kvm);
 void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm, const struct kvm_memory_slot *memslot);
 void kvm_init_vmcs(struct kvm *kvm);
 void kvm_exc_entry(void);
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 7b3661da8958..86b1af823e2b 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -322,6 +322,8 @@ static void kvm_check_vmid(struct kvm_vcpu *vcpu)
 
 	cpu = smp_processor_id();
 	context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
+	if (cpumask_test_and_clear_cpu(cpu, &vcpu->kvm->arch.tlb_flush_pending))
+		vcpu->kvm->arch.vmid[cpu] = 0;
 
 	/*
 	 * Check if our vmid is of an older version
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index e104897aa532..560a2d0f111f 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -940,6 +940,22 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
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
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..19c81ae8941a 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -210,7 +210,12 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
 		return RESUME_GUEST;
 
 	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
-		vcpu->arch.vpid = 0;  /* Drop vpid for this vCPU */
+		/*
+		 * vpid need the same with vmid if vpid is not separated
+		 * with vmid
+		 */
+		if (!cpu_has_guestid)
+			vcpu->arch.vpid = 0;  /* Drop vpid for this vCPU */
 
 	if (kvm_dirty_ring_check_request(vcpu))
 		return RESUME_HOST;
-- 
2.39.3

