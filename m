Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B033248166;
	Tue, 26 May 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800000; cv=none; b=qm4bVNi6J1dCUtiHjQ4wxL6i75RW/7nFz6P+knX8nZbZz3xMIEQT868LOwFmMUaF88i73M8C/OUgefKTMSkLnc4pGuzWivazCgas7r0ypwQL4irW3eV9LUeNRC0v2BJirIX/PSy50RaLTDs1uEDhLjg9pNBTSdnrYZ8mhJEmHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800000; c=relaxed/simple;
	bh=AFs+WNya3mZde7xpB7WAr9WR9Ggo95jUIl2MIL6j13A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4/Es1iQqydHObYwoK58ei6tMdInbfckMPZRTDQQq3AcMuI3U2qevyWJPWWGTghkbRIE1kBlN8dpUWEp2y/VuYlS0gZPE28YJzVFrMPkeHLHJQWRda1i+sy2M5PDzmNY5sMZUsy+IUbeNGvQOiJC1CTPBOAsnNZ/ee/c3lFjcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxf+uulxVqJ2gNAA--.37968S3;
	Tue, 26 May 2026 20:53:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxpsCulxVqb5iRAA--.44615S2;
	Tue, 26 May 2026 20:53:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] LoongArch: KVM: Inject interrupt with batch method
Date: Tue, 26 May 2026 20:52:53 +0800
Message-Id: <20260526125256.2511876-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260526125256.2511876-1-maobibo@loongson.cn>
References: <20260526125256.2511876-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsCulxVqb5iRAA--.44615S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With bitmask method, interrupt can be injected with batch mode, rather
than one by one. Also remove unused array priority_to_irqp[] here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/interrupt.c | 95 ++++++++++------------------------
 1 file changed, 28 insertions(+), 67 deletions(-)

diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index 48dd56aa4dc5..50081484336e 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -9,39 +9,16 @@
 #include <asm/kvm_vcpu.h>
 #include <asm/kvm_dmsintc.h>
 
-static unsigned int priority_to_irq[EXCCODE_INT_NUM] = {
-	[INT_TI]	= CPU_TIMER,
-	[INT_IPI]	= CPU_IPI,
-	[INT_SWI0]	= CPU_SIP0,
-	[INT_SWI1]	= CPU_SIP1,
-	[INT_HWI0]	= CPU_IP0,
-	[INT_HWI1]	= CPU_IP1,
-	[INT_HWI2]	= CPU_IP2,
-	[INT_HWI3]	= CPU_IP3,
-	[INT_HWI4]	= CPU_IP4,
-	[INT_HWI5]	= CPU_IP5,
-	[INT_HWI6]	= CPU_IP6,
-	[INT_HWI7]	= CPU_IP7,
-	[INT_AVEC]	= CPU_AVEC,
-};
-
-static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
+static void kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned long mask)
 {
-	unsigned int irq = 0;
+	unsigned long irq;
 	unsigned long old, new;
 
-	clear_bit(priority, &vcpu->arch.irq_pending);
-	if (priority < EXCCODE_INT_NUM)
-		irq = priority_to_irq[priority];
-
-	switch (priority) {
-	case INT_AVEC:
-		dmsintc_inject_irq(vcpu);
-		fallthrough;
-	case INT_TI:
-	case INT_IPI:
-	case INT_SWI0:
-	case INT_SWI1:
+	irq = mask & KVM_ESTAT_IRQ_MASK;
+	if (irq) {
+		if (irq & CPU_AVEC)
+			dmsintc_inject_irq(vcpu);
+
 		old = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
 		set_gcsr_estat(irq);
 		new = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
@@ -49,34 +26,20 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 		/* Inject TI if TVAL inverted */
 		if (new > old)
 			set_gcsr_estat(CPU_TIMER);
-		break;
-
-	case INT_HWI0 ... INT_HWI7:
-		set_csr_gintc(irq);
-		break;
-
-	default:
-		break;
 	}
 
-	return 1;
+	irq = (mask >> GINTC_VIP_DELTA) & KVM_GINTC_IRQ_MASK;
+	if (irq)
+		set_csr_gintc(irq);
 }
 
-static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
+static void kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned long mask)
 {
-	unsigned int irq = 0;
+	unsigned long irq;
 	unsigned long old, new;
 
-	clear_bit(priority, &vcpu->arch.irq_clear);
-	if (priority < EXCCODE_INT_NUM)
-		irq = priority_to_irq[priority];
-
-	switch (priority) {
-	case INT_AVEC:
-	case INT_TI:
-	case INT_IPI:
-	case INT_SWI0:
-	case INT_SWI1:
+	irq = mask & KVM_ESTAT_IRQ_MASK;
+	if (irq) {
 		old = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
 		clear_gcsr_estat(irq);
 		new = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
@@ -84,30 +47,28 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 		/* Inject TI if TVAL inverted */
 		if (new > old)
 			set_gcsr_estat(CPU_TIMER);
-		break;
-
-	case INT_HWI0 ... INT_HWI7:
-		clear_csr_gintc(irq);
-		break;
-
-	default:
-		break;
 	}
 
-	return 1;
+	irq = (mask >> GINTC_VIP_DELTA) & KVM_GINTC_IRQ_MASK;
+	if (irq)
+		clear_csr_gintc(irq);
 }
 
 void kvm_deliver_intr(struct kvm_vcpu *vcpu)
 {
-	unsigned int priority;
-	unsigned long *pending = &vcpu->arch.irq_pending;
-	unsigned long *pending_clr = &vcpu->arch.irq_clear;
+	unsigned long mask;
 
-	for_each_set_bit(priority, pending_clr, EXCCODE_INT_NUM)
-		kvm_irq_clear(vcpu, priority);
+	mask = READ_ONCE(vcpu->arch.irq_clear);
+	if (mask) {
+		mask = xchg_relaxed(&vcpu->arch.irq_clear, 0);
+		kvm_irq_clear(vcpu, mask);
+	}
 
-	for_each_set_bit(priority, pending, EXCCODE_INT_NUM)
-		kvm_irq_deliver(vcpu, priority);
+	mask = READ_ONCE(vcpu->arch.irq_pending);
+	if (mask) {
+		mask = xchg_relaxed(&vcpu->arch.irq_pending, 0);
+		kvm_irq_deliver(vcpu, mask);
+	}
 }
 
 int kvm_pending_timer(struct kvm_vcpu *vcpu)
-- 
2.39.3

