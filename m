Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63414302149;
	Mon, 11 May 2026 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482324; cv=none; b=nk63A2/5Mrtidf3VyYYi75uqpdLsHP/oMjUOz76QOUCZor+fysq1fYKU+FvNGDPkMVZ58Upq9ky4cM4mKhKTUcBAQLSJEDB/CdcKWiNurbrH1/DLAyKhgzbyc37dby+U076G5sUxYVnvYahzes5RgWEd74DGKaJ8YZ6TwuGYxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482324; c=relaxed/simple;
	bh=Rm2/WHlYQCxLU+XwtLydiVNkDktoFkH3+mkPNJFowYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TMjED3QEDfhnI8AvFvsFfl1TajaKBDSel9HvTMosy/09y4nGJSR+gNV/KeGIU2Sl4b/N0iui/ph76lX5OSQL/xSVxsZERNrBYALOFE1KGlkBpGlS7MLigmvoaDBCmO7+oTEhIc5ryaoaWcDEowUU7SZED2D3fRqY4nAks6vfIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxZniQfAFq84wIAA--.2007S3;
	Mon, 11 May 2026 14:52:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMKQfAFqB+h+AA--.43621S2;
	Mon, 11 May 2026 14:52:00 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] LoongArch: KVM: Deliver interrupt with batch method
Date: Mon, 11 May 2026 14:51:45 +0800
Message-Id: <20260511065146.680650-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260511065146.680650-1-maobibo@loongson.cn>
References: <20260511065146.680650-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKQfAFqB+h+AA--.43621S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With bitmask method, interrupt can be delivered with batch mode, rather
than one by one. Also remove unused array priority_to_irqp[] here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/interrupt.c | 58 +++++++++-------------------------
 1 file changed, 15 insertions(+), 43 deletions(-)

diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index a3f6e5f75dfb..380aabb3d4d0 100644
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
@@ -49,17 +26,11 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
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
+	irq = (mask >> 2) & KVM_GINTC_IRQ_MASK;
+	if (irq)
+		set_csr_gintc(irq);
 }
 
 static void kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned long mask)
@@ -85,8 +56,6 @@ static void kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned long mask)
 
 void kvm_deliver_intr(struct kvm_vcpu *vcpu)
 {
-	unsigned int priority;
-	unsigned long *pending = &vcpu->arch.irq_pending;
 	unsigned long mask;
 
 	mask = READ_ONCE(vcpu->arch.irq_clear);
@@ -95,8 +64,11 @@ void kvm_deliver_intr(struct kvm_vcpu *vcpu)
 		kvm_irq_clear(vcpu, mask);
 	}
 
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

