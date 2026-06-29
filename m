Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CCF27E05E;
	Mon, 29 Jun 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700347; cv=none; b=GcUg3rfeOng3IByo+Am126iepuZGbkOKWxNpiaaaNm+Oyom+gwJbSB4Ep78WpbksdUuKnziRNrFcQfALZ+blBMWq6qkQLMK/AoR0Auo/rpD0Lhh6hTgRDVbtBij5oTrkY9KiRpG0hAE1oT/xaV4nLrwJB7+AXykh+AsV20K+T7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700347; c=relaxed/simple;
	bh=yv74qRvlrZfNeiCVDtAxT6HA57j42oE/SYKOkZy0w+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCVJeAoPiRU2/LpOGmijctxlhgcqAZGoKPvZC6rlFyv+LO7HGab1up/QZZw4jVKCG9PLF416wqUZh4bTw/i02VAOWVHEjAkj40qcIq7DOBQ4d06ScUIe0fXPonteYWS7iCLci08dlBXppAPlVJrNx5v19MycIVAGJAZzlH5FrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxVeg42UFqVv8YAA--.58034S3;
	Mon, 29 Jun 2026 10:32:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxWeAu2UFqbBe3AA--.19539S5;
	Mon, 29 Jun 2026 10:32:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] LoongArch: KVM: Use internal API to deliver interrupt in kernel mode
Date: Mon, 29 Jun 2026 10:32:13 +0800
Message-Id: <20260629023213.597030-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260629023213.597030-1-maobibo@loongson.cn>
References: <20260629023213.597030-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeAu2UFqbBe3AA--.19539S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

API kvm_vcpu_ioctl_interrupt() is mainly to used to deliver interrupt
from user mode, and internal APIs kvm_queue_irq() and kvm_dequeue_irq()
are used in kernel mode.

Also move IPI inject and ack within lock protection to avoid contention
in ipi_set() and ipi_clear().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c |  7 ++++---
 arch/loongarch/kvm/intc/eiointc.c | 14 +++++++++-----
 arch/loongarch/kvm/intc/ipi.c     | 14 ++++++--------
 arch/loongarch/kvm/vcpu.c         |  3 +++
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 708abbcd55bf..ed8553224775 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -47,7 +47,6 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
 				struct kvm_vcpu *vcpu, u32 vector, int level)
 {
-	struct kvm_interrupt vcpu_irq;
 	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
 
 	if (!level)
@@ -57,9 +56,11 @@ int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
 	if (!ds)
 		return -ENODEV;
 
-	vcpu_irq.irq = INT_AVEC;
+	if (!kvm_guest_has_msgint(&vcpu->arch))
+		return -EINVAL;
+
 	set_bit(vector, (unsigned long *)&ds->vector_map);
-	kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
+	kvm_queue_irq(vcpu, INT_AVEC);
 	kvm_vcpu_kick(vcpu);
 
 	return 0;
diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 555e55246f0c..681dfb548dbf 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -17,7 +17,8 @@ static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
 		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
 			ipnum = count_trailing_zeros(ipnum);
 			ipnum = ipnum < 4 ? ipnum : 0;
-		}
+		} else if (ipnum >= LOONGSON_IP_NUM)
+			ipnum = 0;
 
 		cpuid = ((u8 *)s->coremap)[irq];
 		vcpu = kvm_get_vcpu_by_cpuid(s->kvm, cpuid);
@@ -36,13 +37,13 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 {
 	int ipnum, cpu, found;
 	struct kvm_vcpu *vcpu;
-	struct kvm_interrupt vcpu_irq;
 
 	ipnum = (s->ipmap >> (irq / 32 * 8)) & 0xff;
 	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
 		ipnum = count_trailing_zeros(ipnum);
 		ipnum = ipnum < 4 ? ipnum : 0;
-	}
+	} else if (ipnum >= LOONGSON_IP_NUM)
+		ipnum = 0;
 
 	cpu = s->sw_coremap[irq];
 	vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
@@ -67,8 +68,11 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 	if (found < EIOINTC_IRQS)
 		return; /* other irq is handling, needn't update parent irq */
 
-	vcpu_irq.irq = level ? (INT_HWI0 + ipnum) : -(INT_HWI0 + ipnum);
-	kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
+	if (level)
+		kvm_queue_irq(vcpu, INT_HWI0 + ipnum);
+	else
+		kvm_dequeue_irq(vcpu, INT_HWI0 + ipnum);
+	kvm_vcpu_kick(vcpu);
 }
 
 static inline void eiointc_update_sw_coremap(struct loongarch_eiointc *s,
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 8d9dacfc1b15..eacf2073c603 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -10,16 +10,15 @@
 static void ipi_set(struct kvm_vcpu *vcpu, uint32_t data)
 {
 	uint32_t status;
-	struct kvm_interrupt irq;
 
 	spin_lock(&vcpu->arch.ipi_state.lock);
 	status = vcpu->arch.ipi_state.status;
 	vcpu->arch.ipi_state.status |= data;
-	spin_unlock(&vcpu->arch.ipi_state.lock);
 	if ((status == 0) && data) {
-		irq.irq = LARCH_INT_IPI;
-		kvm_vcpu_ioctl_interrupt(vcpu, &irq);
+		kvm_queue_irq(vcpu, LARCH_INT_IPI);
+		kvm_vcpu_kick(vcpu);
 	}
+	spin_unlock(&vcpu->arch.ipi_state.lock);
 }
 
 static void ipi_send(struct kvm *kvm, uint64_t data)
@@ -40,16 +39,15 @@ static void ipi_send(struct kvm *kvm, uint64_t data)
 static void ipi_clear(struct kvm_vcpu *vcpu, uint64_t data)
 {
 	uint32_t status;
-	struct kvm_interrupt irq;
 
 	spin_lock(&vcpu->arch.ipi_state.lock);
 	vcpu->arch.ipi_state.status &= ~data;
 	status = vcpu->arch.ipi_state.status;
-	spin_unlock(&vcpu->arch.ipi_state.lock);
 	if (status == 0) {
-		irq.irq = -LARCH_INT_IPI;
-		kvm_vcpu_ioctl_interrupt(vcpu, &irq);
+		kvm_dequeue_irq(vcpu, LARCH_INT_IPI);
+		kvm_vcpu_kick(vcpu);
 	}
+	spin_unlock(&vcpu->arch.ipi_state.lock);
 }
 
 static uint64_t read_mailbox(struct kvm_vcpu *vcpu, int offset, int len)
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 361fca46e2b3..265aaad63315 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1465,6 +1465,9 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 	if (vector >= EXCCODE_INT_NUM)
 		return -EINVAL;
 
+	if (kvm_arch_irqchip_in_kernel(vcpu->kvm))
+		return -EINVAL;
+
 	if (!kvm_guest_has_msgint(&vcpu->arch) && (vector == INT_AVEC))
 		return -EINVAL;
 
-- 
2.39.3

