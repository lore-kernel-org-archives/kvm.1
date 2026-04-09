Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C7370D5B;
	Thu,  9 Apr 2026 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704083; cv=none; b=d97j6ka6LpQoAyiQ45ZJeuKxevHwGhrz9ztgF/JHW4KqNgTnF/dpFJpGwWhRGywKZ6/EVGLULjbVPbtdxo1astGXJaJUjF+q33R8ygFAgITeLkfc57xJkpiVkjZHrrYM23xBnc1VFw5bJZoUgbnpPMUnlnjL4KHkT+wAhUr2ZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704083; c=relaxed/simple;
	bh=0pzuAWzpVngTq7uFimeChvbs2L1mwTDF67Lt+JPnBPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNVUNN4olMLLC4zDa5P69+2RbQuQPbPIX/JpMABhsv/bJwqYPsb4tALphPmJqSvWmDm5Nv/PBVoJgVYGvmbB9muar9B+AquPDWBzBX2cV0tyq9ueYLY7v/NWrWHPrKTDASvSr4+9Rv/lx4QfxtlZLAwMV6XlOCy5SC14/6PRVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8DxecINGNdpd2ojAA--.138S3;
	Thu, 09 Apr 2026 11:07:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJBxSeAIGNdpHB5pAA--.3831S3;
	Thu, 09 Apr 2026 11:07:56 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn
Subject: [PATCH v10 1/2] LoongArch: KVM: Add DMSINTC device support
Date: Thu,  9 Apr 2026 10:42:14 +0800
Message-Id: <20260409024215.136932-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260409024215.136932-1-gaosong@loongson.cn>
References: <20260409024215.136932-1-gaosong@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeAIGNdpHB5pAA--.3831S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add device model for DMSINTC interrupt controller, implement basic
create/destroy/set_attr interfaces, and register device model to kvm
device table.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 arch/loongarch/include/asm/kvm_dmsintc.h |  21 ++++
 arch/loongarch/include/asm/kvm_host.h    |   3 +
 arch/loongarch/include/uapi/asm/kvm.h    |   4 +
 arch/loongarch/kvm/Makefile              |   1 +
 arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++++
 arch/loongarch/kvm/main.c                |   6 ++
 include/uapi/linux/kvm.h                 |   2 +
 7 files changed, 154 insertions(+)
 create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
 create mode 100644 arch/loongarch/kvm/intc/dmsintc.c

diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/include/asm/kvm_dmsintc.h
new file mode 100644
index 000000000000..b04b89dd2a35
--- /dev/null
+++ b/arch/loongarch/include/asm/kvm_dmsintc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_KVM_DMSINTC_H
+#define __ASM_KVM_DMSINTC_H
+
+
+struct loongarch_dmsintc {
+	struct kvm *kvm;
+	uint64_t msg_addr_base;
+	uint64_t msg_addr_size;
+};
+
+struct dmsintc_state {
+	atomic64_t  vector_map[4];
+};
+
+int kvm_loongarch_register_dmsintc_device(void);
+#endif
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 19eb5e5c3984..6a8d72cf8e4e 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -22,6 +22,7 @@
 #include <asm/kvm_ipi.h>
 #include <asm/kvm_eiointc.h>
 #include <asm/kvm_pch_pic.h>
+#include <asm/kvm_dmsintc.h>
 #include <asm/loongarch.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -135,6 +136,7 @@ struct kvm_arch {
 	struct loongarch_ipi *ipi;
 	struct loongarch_eiointc *eiointc;
 	struct loongarch_pch_pic *pch_pic;
+	struct loongarch_dmsintc *dmsintc;
 };
 
 #define CSR_MAX_NUMS		0x800
@@ -247,6 +249,7 @@ struct kvm_vcpu_arch {
 	struct kvm_mp_state mp_state;
 	/* ipi state */
 	struct ipi_state ipi_state;
+	struct dmsintc_state dmsintc_state;
 	/* cpucfg */
 	u32 cpucfg[KVM_MAX_CPUCFG_REGS];
 
diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
index 419647aacdf3..c39b8ac7a90a 100644
--- a/arch/loongarch/include/uapi/asm/kvm.h
+++ b/arch/loongarch/include/uapi/asm/kvm.h
@@ -155,4 +155,8 @@ struct kvm_iocsr_entry {
 #define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL	        0x40000006
 #define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT	        0
 
+#define KVM_DEV_LOONGARCH_DMSINTC_CTRL			0x40000007
+#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE		0x0
+#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE		0x1
+
 #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
index cb41d9265662..6e184e24443c 100644
--- a/arch/loongarch/kvm/Makefile
+++ b/arch/loongarch/kvm/Makefile
@@ -19,6 +19,7 @@ kvm-y += vm.o
 kvm-y += intc/ipi.o
 kvm-y += intc/eiointc.o
 kvm-y += intc/pch_pic.o
+kvm-y += intc/dmsintc.o
 kvm-y += irqfd.o
 
 CFLAGS_exit.o	+= $(call cc-disable-warning, override-init)
diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
new file mode 100644
index 000000000000..1bb61e55d061
--- /dev/null
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_dmsintc.h>
+#include <asm/kvm_vcpu.h>
+
+static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
+				struct kvm_device_attr *attr,
+				bool is_write)
+{
+	int addr = attr->attr;
+	void __user *data;
+	struct loongarch_dmsintc *s = dev->kvm->arch.dmsintc;
+	u64 tmp;
+	u32 cpu_bit;
+
+	data = (void __user *)attr->addr;
+	switch (addr) {
+	case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE:
+		if (is_write) {
+			if (copy_from_user(&tmp, data, sizeof(s->msg_addr_base)))
+				return -EFAULT;
+			if (s->msg_addr_base) {
+				/* Duplicate setting are not allowed. */
+				return -EFAULT;
+			}
+			if ((tmp & (BIT(AVEC_CPU_SHIFT) - 1)) == 0)
+				s->msg_addr_base = tmp;
+			else
+				return  -EFAULT;
+			s->msg_addr_base = tmp;
+			cpu_bit = find_first_bit((unsigned long *)&(s->msg_addr_base), 64)
+						- AVEC_CPU_SHIFT;
+			cpu_bit = min(cpu_bit, AVEC_CPU_BIT);
+			s->cpu_mask = GENMASK(cpu_bit - 1, 0) & AVEC_CPU_MASK;
+		}
+		break;
+	case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE:
+		if (is_write) {
+			if (copy_from_user(&tmp, data, sizeof(s->msg_addr_size)))
+				return -EFAULT;
+			if (s->msg_addr_size) {
+				/*Duplicate setting are not allowed. */
+				return -EFAULT;
+			}
+			s->msg_addr_size = tmp;
+		}
+		break;
+	default:
+		kvm_err("%s: unknown dmsintc register, addr = %d\n", __func__, addr);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int kvm_dmsintc_set_attr(struct kvm_device *dev,
+			struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_DEV_LOONGARCH_DMSINTC_CTRL:
+		return kvm_dmsintc_ctrl_access(dev, attr, true);
+	default:
+		kvm_err("%s: unknown group (%d)\n", __func__, attr->group);
+		return -EINVAL;
+	}
+}
+
+static int kvm_dmsintc_create(struct kvm_device *dev, u32 type)
+{
+	struct kvm *kvm;
+	struct loongarch_dmsintc *s;
+
+	if (!dev) {
+		kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
+		return -EINVAL;
+	}
+
+	kvm = dev->kvm;
+	if (kvm->arch.dmsintc) {
+		kvm_err("%s: LoongArch DMSINTC has already been created!\n", __func__);
+		return -EINVAL;
+	}
+
+	s = kzalloc(sizeof(struct loongarch_dmsintc), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s->kvm = kvm;
+	kvm->arch.dmsintc = s;
+	return 0;
+}
+
+static void kvm_dmsintc_destroy(struct kvm_device *dev)
+{
+
+	if (!dev || !dev->kvm || !dev->kvm->arch.dmsintc)
+		return;
+
+	kfree(dev->kvm->arch.dmsintc);
+	kfree(dev);
+}
+
+static struct kvm_device_ops kvm_dmsintc_dev_ops = {
+	.name = "kvm-loongarch-dmsintc",
+	.create = kvm_dmsintc_create,
+	.destroy = kvm_dmsintc_destroy,
+	.set_attr = kvm_dmsintc_set_attr,
+};
+
+int kvm_loongarch_register_dmsintc_device(void)
+{
+	return kvm_register_device_ops(&kvm_dmsintc_dev_ops, KVM_DEV_TYPE_LOONGARCH_DMSINTC);
+}
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 2c593ac7892f..713771a93d90 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -416,6 +416,12 @@ static int kvm_loongarch_env_init(void)
 
 	/* Register LoongArch PCH-PIC interrupt controller interface. */
 	ret = kvm_loongarch_register_pch_pic_device();
+	if (ret)
+		return ret;
+
+	/* Register LoongArch DMSINTC interrupt contrroller interface */
+	if (cpu_has_msgint)
+		ret = kvm_loongarch_register_dmsintc_device();
 
 	return ret;
 }
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 80364d4dbebb..0c940fbcee8b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1224,6 +1224,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_LOONGARCH_EIOINTC	KVM_DEV_TYPE_LOONGARCH_EIOINTC
 	KVM_DEV_TYPE_LOONGARCH_PCHPIC,
 #define KVM_DEV_TYPE_LOONGARCH_PCHPIC	KVM_DEV_TYPE_LOONGARCH_PCHPIC
+	KVM_DEV_TYPE_LOONGARCH_DMSINTC,
+#define KVM_DEV_TYPE_LOONGARCH_DMSINTC   KVM_DEV_TYPE_LOONGARCH_DMSINTC
 
 	KVM_DEV_TYPE_MAX,
 
-- 
2.39.3

