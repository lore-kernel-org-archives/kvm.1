Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E89340A6F;
	Wed, 23 Sep 2026 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126730; cv=none; b=NzR6Tt2Lpn1vIL/hEcyaAmRV3i9rhYB8wR55Mh571TiE5TBQSkF5sKCw50tHxuDBAU2rNPlpj7eUKRb9EMaA9Ej2uC4ZxopMAsHkcxU9QIPpI9aQi3xfJIPxgLZFo7rRLGeMMT5+uswuAq3/shV5ltaG/8ioBA1gemSSHIrgZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126730; c=relaxed/simple;
	bh=k8rHS55MgpgmLFzdDArshj1+YZnAVCY3dlNP48hX514=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKZ1G2M9sX2Ji+R9UD63sW+KV4T2vIc9uYPyQaB2mFmqH8No84GGKVF1xjPjuWYQ5cJW3PpTVodNEmSJ9j24TWM7l5kQfUNQc/ZaIh+DCDle6p2tvBS8tOvJwGJo0P6kDoykxyqdvPb6BbmkljzRP9LcEhYBmoZRz420gE61YWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxjdKGKrNqU9wOAA--.43329S3;
	Wed, 23 Sep 2026 09:25:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx6c2EKrNqyQIkAA--.45699S3;
	Wed, 23 Sep 2026 09:25:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/2] LoongArch: KVM: Remove parameter line when inject MSI
Date: Wed, 23 Sep 2026 09:18:02 +0800
Message-Id: <20260923011803.1057945-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260923011803.1057945-1-maobibo@loongson.cn>
References: <20260923011803.1057945-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx6c2EKrNqyQIkAA--.45699S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With MSI interrupt, there is intterupt set injection, no interrupt
clear action. DMSI interrupt controller is specially for MSI irqchip.
And there is checking with parameter level in most upper function
kvm_set_msi() and kvm_arch_set_irq_inatomic() already, here remove
duplicated line parameter checking in MSI injection leaf functions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/asm/kvm_dmsintc.h | 3 +--
 arch/loongarch/include/asm/kvm_pch_pic.h | 2 +-
 arch/loongarch/kvm/intc/dmsintc.c        | 9 +++------
 arch/loongarch/kvm/intc/pch_pic.c        | 6 +++---
 arch/loongarch/kvm/irqfd.c               | 4 ++--
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/include/asm/kvm_dmsintc.h
index 7c0158764d84..e19b3f5b3c52 100644
--- a/arch/loongarch/include/asm/kvm_dmsintc.h
+++ b/arch/loongarch/include/asm/kvm_dmsintc.h
@@ -22,7 +22,6 @@ struct dmsintc_state {
 int kvm_loongarch_register_dmsintc_device(void);
 void kvm_loongarch_unregister_dmsintc_device(void);
 void dmsintc_inject_irq(struct kvm_vcpu *vcpu);
-int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level);
-int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 vector, int level);
+int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data);
 
 #endif
diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
index 887b0431fd20..19ed1494c114 100644
--- a/arch/loongarch/include/asm/kvm_pch_pic.h
+++ b/arch/loongarch/include/asm/kvm_pch_pic.h
@@ -72,6 +72,6 @@ struct kvm_kernel_irq_routing_entry;
 int kvm_loongarch_register_pch_pic_device(void);
 void kvm_loongarch_unregister_pch_pic_device(void);
 void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level);
-int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int level);
+int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e);
 
 #endif /* __ASM_KVM_PCH_PIC_H */
diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 89f980d867be..79e56e330aeb 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -43,13 +43,10 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 	}
 }
 
-int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
-				struct kvm_vcpu *vcpu, u32 vector, int level)
+static int dmsintc_deliver_msi_to_vcpu(struct kvm_vcpu *vcpu, u32 vector)
 {
 	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
 
-	if (!level)
-		return 0;
 	if (!vcpu || vector >= 256)
 		return -EINVAL;
 	if (!ds)
@@ -65,7 +62,7 @@ int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
 	return 0;
 }
 
-int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
+int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data)
 {
 	unsigned int irq, cpu;
 	struct kvm_vcpu *vcpu;
@@ -78,7 +75,7 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
 	if (!vcpu)
 		return -EINVAL;
 
-	return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, irq, level);
+	return dmsintc_deliver_msi_to_vcpu(vcpu, irq);
 }
 
 static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 2b63b0c2c7ce..220fc23ffe8c 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -68,20 +68,20 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
 }
 
 /* msi irq handler */
-int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int level)
+int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e)
 {
 	u64 msg_addr = (((u64)e->msi.address_hi) << 32) | e->msi.address_lo;
 
 	if (cpu_has_msgint && kvm->arch.dmsintc &&
 		msg_addr >= kvm->arch.dmsintc->msg_addr_base &&
 		msg_addr < (kvm->arch.dmsintc->msg_addr_base + kvm->arch.dmsintc->msg_addr_size)) {
-		return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
+		return dmsintc_set_irq(kvm, msg_addr, e->msi.data);
 	}
 
 	if (e->msi.data >= EIOINTC_IRQS)
 		return -EINVAL;
 
-	eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
+	eiointc_set_irq(kvm->arch.eiointc, e->msi.data, 1);
 
 	return 0;
 }
diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
index 40ed1081c4b6..2e9c32023752 100644
--- a/arch/loongarch/kvm/irqfd.c
+++ b/arch/loongarch/kvm/irqfd.c
@@ -29,7 +29,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 	if (!level)
 		return -1;
 
-	return pch_msi_set_irq(kvm, e, level);
+	return pch_msi_set_irq(kvm, e);
 }
 
 /*
@@ -78,7 +78,7 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 		pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
 		return 0;
 	case KVM_IRQ_ROUTING_MSI:
-		return pch_msi_set_irq(kvm, e, level);
+		return pch_msi_set_irq(kvm, e);
 	default:
 		return -EWOULDBLOCK;
 	}
-- 
2.39.3

