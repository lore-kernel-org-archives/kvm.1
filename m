Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFC6285CA8;
	Thu,  2 Apr 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135307; cv=none; b=IZ0V/xRlx0ply7xQBQlRkQ80l2SGX5i5R2+Vk6a81oBG5A3ynsN+W3YIcfRppf9Z1K/ttVndk8XlPljbtW5FjbBfncb49RZIz0tlR60VPDfWa/FkHg/p3s1LaIjbhQhl7syjnzTI1r4LZAykmOSGCjYX8mPG5ib3TceMg+90hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135307; c=relaxed/simple;
	bh=bvczBY/WyeuBZmp33DGd9oyyd3hhtrefGoU6v+iCB+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lB7rbuiqghHEuwM8nNaoh0x8ooF9jfPKcUDKjXztSSENvp8fxmlLW1nbLNZ877rsRejsVYkI/Evw8gv4fygyWMz0LDK+hWXPpC8TvjprJOzSkxBy/16H24YNbLIhyBWSi88SzHm0tbZOC82L/6ZXUfcl6tFLqm1pDxU+Sissqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8BxcfA_as5pTDchAA--.28536S3;
	Thu, 02 Apr 2026 21:08:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJCx+8E6as5p6oJjAA--.58940S4;
	Thu, 02 Apr 2026 21:08:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn
Subject: [PATCH v9 2/2] LoongArch: KVM: Add dmsintc inject msi to the dest vcpu
Date: Thu,  2 Apr 2026 20:42:37 +0800
Message-Id: <20260402124237.4174550-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260402124237.4174550-1-gaosong@loongson.cn>
References: <20260402124237.4174550-1-gaosong@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8E6as5p6oJjAA--.58940S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Implement irqfd deliver msi to vcpu and vcpu dmsintc inject irq.
Add irqfd choice dmsintc to set msi irq by the msg_addr and
implement dmsintc set msi irq.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 arch/loongarch/include/asm/kvm_dmsintc.h |  2 +
 arch/loongarch/include/asm/kvm_pch_pic.h |  4 +-
 arch/loongarch/kvm/intc/pch_pic.c        | 15 +++++++-
 arch/loongarch/kvm/interrupt.c           | 37 ++++++++++++++++++
 arch/loongarch/kvm/irqfd.c               | 48 +++++++++++++++++++++---
 5 files changed, 97 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/include/asm/kvm_dmsintc.h
index b04b89dd2a35..3f6a22f5a4ee 100644
--- a/arch/loongarch/include/asm/kvm_dmsintc.h
+++ b/arch/loongarch/include/asm/kvm_dmsintc.h
@@ -11,11 +11,13 @@ struct loongarch_dmsintc {
 	struct kvm *kvm;
 	uint64_t msg_addr_base;
 	uint64_t msg_addr_size;
+	uint32_t cpu_mask;
 };
 
 struct dmsintc_state {
 	atomic64_t  vector_map[4];
 };
 
+int dmsintc_set_msi_irq(struct kvm *kvm, u64 addr, int data, int level);
 int kvm_loongarch_register_dmsintc_device(void);
 #endif
diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
index 7f33a3039272..5f49b1f82c56 100644
--- a/arch/loongarch/include/asm/kvm_pch_pic.h
+++ b/arch/loongarch/include/asm/kvm_pch_pic.h
@@ -70,6 +70,8 @@ struct loongarch_pch_pic {
 
 int kvm_loongarch_register_pch_pic_device(void);
 void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level);
-void pch_msi_set_irq(struct kvm *kvm, int irq, int level);
+struct kvm_kernel_irq_routing_entry;
+int pch_msi_set_irq(struct kvm *kvm,
+		struct kvm_kernel_irq_routing_entry *e, int level);
 
 #endif /* __ASM_KVM_PCH_PIC_H */
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index dd7e7f8d53db..875420f8c6ab 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -4,6 +4,7 @@
  */
 
 #include <asm/kvm_eiointc.h>
+#include <asm/kvm_dmsintc.h>
 #include <asm/kvm_pch_pic.h>
 #include <asm/kvm_vcpu.h>
 #include <linux/count_zeros.h>
@@ -67,9 +68,19 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
 }
 
 /* msi irq handler */
-void pch_msi_set_irq(struct kvm *kvm, int irq, int level)
+int pch_msi_set_irq(struct kvm *kvm,
+		struct kvm_kernel_irq_routing_entry *e, int level)
 {
-	eiointc_set_irq(kvm->arch.eiointc, irq, level);
+	u64 msg_addr = (((u64)e->msi.address_hi) << 32) | e->msi.address_lo;
+
+	if (cpu_has_msgint && kvm->arch.dmsintc &&
+		msg_addr >= kvm->arch.dmsintc->msg_addr_base &&
+		msg_addr < (kvm->arch.dmsintc->msg_addr_base  + kvm->arch.dmsintc->msg_addr_size)) {
+		return dmsintc_set_msi_irq(kvm, msg_addr, e->msi.data, level);
+	}
+
+	eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
+	return 0;
 }
 
 static int loongarch_pch_pic_read(struct loongarch_pch_pic *s, gpa_t addr, int len, void *val)
diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index fb704f4c8ac5..76a133adedc2 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -8,6 +8,42 @@
 #include <asm/kvm_csr.h>
 #include <asm/kvm_vcpu.h>
 
+static void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
+{
+	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
+	unsigned int i;
+	unsigned long temp[4], old;
+
+	if (!ds)
+		return;
+
+	for (i = 0; i < 4; i++) {
+		old = atomic64_read(&(ds->vector_map[i]));
+		if (old)
+			temp[i] = atomic64_xchg(&(ds->vector_map[i]), 0);
+	}
+
+	if (temp[0]) {
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
+		kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, temp[0]|old);
+	}
+
+	if (temp[1]) {
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR1);
+		kvm_write_hw_gcsr(LOONGARCH_CSR_ISR1, temp[1]|old);
+	}
+
+	if (temp[2]) {
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR2);
+		kvm_write_hw_gcsr(LOONGARCH_CSR_ISR2, temp[2]|old);
+	}
+
+	if (temp[3]) {
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR3);
+		kvm_write_hw_gcsr(LOONGARCH_CSR_ISR3, temp[3]|old);
+	}
+}
+
 static unsigned int priority_to_irq[EXCCODE_INT_NUM] = {
 	[INT_TI]	= CPU_TIMER,
 	[INT_IPI]	= CPU_IPI,
@@ -33,6 +69,7 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 		irq = priority_to_irq[priority];
 
 	if (kvm_guest_has_msgint(&vcpu->arch) && (priority == INT_AVEC)) {
+		dmsintc_inject_irq(vcpu);
 		set_gcsr_estat(irq);
 		return 1;
 	}
diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
index 9a39627aecf0..18df75c78de8 100644
--- a/arch/loongarch/kvm/irqfd.c
+++ b/arch/loongarch/kvm/irqfd.c
@@ -6,6 +6,28 @@
 #include <linux/kvm_host.h>
 #include <trace/events/kvm.h>
 #include <asm/kvm_pch_pic.h>
+#include <asm/kvm_vcpu.h>
+
+static int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
+				struct kvm_vcpu *vcpu,
+				u32 vector, int level)
+{
+	struct kvm_interrupt vcpu_irq;
+	struct dmsintc_state *ds;
+
+	if (!level)
+		return 0;
+	if (!vcpu || vector >= 256)
+		return -EINVAL;
+	ds = &vcpu->arch.dmsintc_state;
+	if (!ds)
+		return -ENODEV;
+	set_bit(vector, (unsigned long *)&ds->vector_map);
+	vcpu_irq.irq = INT_AVEC;
+	kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
+	kvm_vcpu_kick(vcpu);
+	return 0;
+}
 
 static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
 		struct kvm *kvm, int irq_source_id, int level, bool line_status)
@@ -16,6 +38,21 @@ static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
 	return 0;
 }
 
+int dmsintc_set_msi_irq(struct kvm *kvm, u64 addr, int data, int level)
+{
+	unsigned int virq, dest;
+	struct kvm_vcpu *vcpu;
+
+	virq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
+	dest = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
+	if (dest >= KVM_MAX_VCPUS)
+		return -EINVAL;
+	vcpu = kvm_get_vcpu_by_cpuid(kvm, dest);
+	if (!vcpu)
+		return -EINVAL;
+	return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, virq, level);
+}
+
 /*
  * kvm_set_msi: inject the MSI corresponding to the
  * MSI routing entry
@@ -28,10 +65,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 {
 	if (!level)
 		return -1;
-
-	pch_msi_set_irq(kvm, e->msi.data, level);
-
-	return 0;
+	return pch_msi_set_irq(kvm, e, level);
 }
 
 /*
@@ -71,13 +105,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
 int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 		struct kvm *kvm, int irq_source_id, int level, bool line_status)
 {
+	if (!level)
+		return -EWOULDBLOCK;
+
 	switch (e->type) {
 	case KVM_IRQ_ROUTING_IRQCHIP:
 		pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
 		return 0;
 	case KVM_IRQ_ROUTING_MSI:
-		pch_msi_set_irq(kvm, e->msi.data, level);
-		return 0;
+		return pch_msi_set_irq(kvm, e, level);
 	default:
 		return -EWOULDBLOCK;
 	}
-- 
2.39.3

