Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD1409608;
	Tue, 16 Jun 2026 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599550; cv=none; b=WSJv0QOKHGqNqvOo2+Z0ZgZiKIGOGT/sCL3oigVUKcNF36Lpog9WVGTlSpUhFxV+5npDn0foa3YXuq/UWvukpQ/I253in/R5b51N6+XwgiWtYUtWLSzaC54z3X5u16dfXE4rjkHmY5fX7S8YbOBRoTWEkNw30927HXwYA1/Rbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599550; c=relaxed/simple;
	bh=kN7K3MlEQhvRvlV/bLifGWm2hCPjoLAO+4k5Xnlex7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GUHXUOH/jLlmd58BCOtyX2l9DkzS8Z2QSR45j7kEbFMP3iFjV6T66dXtEcrvnnMGSrrChUkmm9lt5sYQHoaLP3teiBEITFcVmVIAtBHkx68UGH9s8ndy2Um+yw7fADPsqbXY7FxkbJ7jaCYR5+nlVLlTyZKE5pnX5t/7jsPrgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxBOk4DTFqsa8UAA--.48101S3;
	Tue, 16 Jun 2026 16:45:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxXcI0DTFquQaoAA--.54652S2;
	Tue, 16 Jun 2026 16:45:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: User internal API to deliver interrupt in kernel mode
Date: Tue, 16 Jun 2026 16:45:38 +0800
Message-Id: <20260616084538.2274484-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxXcI0DTFquQaoAA--.54652S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

API kvm_vcpu_ioctl_interrupt() is mainly to used to deliver interrupt
from user mode, and internal APIs kvm_queue_irq() and kvm_dequeue_irq()
are used in kernel mode.

Also this patch removes unnecessary printk information with inject
unsupported interrupt with number 0.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c |  7 ++++---
 arch/loongarch/kvm/intc/eiointc.c |  8 +++++---
 arch/loongarch/kvm/intc/ipi.c     | 10 ++++------
 arch/loongarch/kvm/vcpu.c         |  4 +---
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index de25735ce039..a726c6cafec3 100644
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
index 2ab7fafa86d5..63f917de7903 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -36,7 +36,6 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 {
 	int ipnum, cpu, found;
 	struct kvm_vcpu *vcpu;
-	struct kvm_interrupt vcpu_irq;
 
 	ipnum = (s->ipmap >> (irq / 32 * 8)) & 0xff;
 	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
@@ -67,8 +66,11 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
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
index 1f6ebbd0af5c..ab3d894eb146 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -10,15 +10,14 @@
 static void ipi_set(struct kvm_vcpu *vcpu, uint32_t data)
 {
 	uint32_t status;
-	struct kvm_interrupt irq;
 
 	spin_lock(&vcpu->arch.ipi_state.lock);
 	status = vcpu->arch.ipi_state.status;
 	vcpu->arch.ipi_state.status |= data;
 	spin_unlock(&vcpu->arch.ipi_state.lock);
 	if ((status == 0) && data) {
-		irq.irq = LARCH_INT_IPI;
-		kvm_vcpu_ioctl_interrupt(vcpu, &irq);
+		kvm_queue_irq(vcpu, LARCH_INT_IPI);
+		kvm_vcpu_kick(vcpu);
 	}
 }
 
@@ -40,15 +39,14 @@ static void ipi_send(struct kvm *kvm, uint64_t data)
 static void ipi_clear(struct kvm_vcpu *vcpu, uint64_t data)
 {
 	uint32_t status;
-	struct kvm_interrupt irq;
 
 	spin_lock(&vcpu->arch.ipi_state.lock);
 	vcpu->arch.ipi_state.status &= ~data;
 	status = vcpu->arch.ipi_state.status;
 	spin_unlock(&vcpu->arch.ipi_state.lock);
 	if (status == 0) {
-		irq.irq = -LARCH_INT_IPI;
-		kvm_vcpu_ioctl_interrupt(vcpu, &irq);
+		kvm_dequeue_irq(vcpu, LARCH_INT_IPI);
+		kvm_vcpu_kick(vcpu);
 	}
 }
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..bd90be3f498b 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1492,10 +1492,8 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 		kvm_queue_irq(vcpu, intr);
 	else if (intr < 0)
 		kvm_dequeue_irq(vcpu, -intr);
-	else {
-		kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
+	else
 		return -EINVAL;
-	}
 
 	kvm_vcpu_kick(vcpu);
 

base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
-- 
2.39.3

