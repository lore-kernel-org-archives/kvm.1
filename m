Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38342EC0A1;
	Mon, 11 May 2026 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482322; cv=none; b=VQ7w11S6YwlVoHbi5B8CjCw6vkPrOMmrIYPm/St4QShqP/Agv1xCEM7XdxJChQnBcReQgJhFwVu/7url8fO+svxCv5PRLVAN/7RLqa71bKLTXT76G4UTgQrHn6WBFmYURBM/HjruZICD4fFQAnOEWfWma/8lVqTQh+ICAQxn81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482322; c=relaxed/simple;
	bh=OEhVC3HTdlFrE1Ut6EHZaB9hLmN9TaXIQyV4fSmq+U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jULigVu40Kf2aCoHcKniODxHpM3+wyKkDz+BAcmRWrbX0UZktFkZ1J3qKsN9YdBAs3M/y2Kpt0o6hVicUv6xISdGM7sI5Vs2XlNjKRJBdwC0hZUzLOXAK9Nkpp32bsh75qFj0TNqHagwT0pBAZHUlblGMkS0MuiyKBsyTKubtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx+HiOfAFq74wIAA--.2040S3;
	Mon, 11 May 2026 14:51:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAx28GEfAFqAOh+AA--.42931S5;
	Mon, 11 May 2026 14:51:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] LoongArch: KVM: Clear interrupt with batch mode
Date: Mon, 11 May 2026 14:51:44 +0800
Message-Id: <20260511065146.680650-4-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAx28GEfAFqAOh+AA--.42931S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With bitmask method, interrupt can be clear with batch mode, rather
than one by one.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/interrupt.c | 37 ++++++++++++----------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index 48dd56aa4dc5..a3f6e5f75dfb 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -62,21 +62,13 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	return 1;
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
@@ -84,27 +76,24 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
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
+	irq = (mask >> 2) & KVM_GINTC_IRQ_MASK;
+	if (irq)
+		clear_csr_gintc(irq);
 }
 
 void kvm_deliver_intr(struct kvm_vcpu *vcpu)
 {
 	unsigned int priority;
 	unsigned long *pending = &vcpu->arch.irq_pending;
-	unsigned long *pending_clr = &vcpu->arch.irq_clear;
+	unsigned long mask;
 
-	for_each_set_bit(priority, pending_clr, EXCCODE_INT_NUM)
-		kvm_irq_clear(vcpu, priority);
+	mask = READ_ONCE(vcpu->arch.irq_clear);
+	if (mask) {
+		mask = xchg_relaxed(&vcpu->arch.irq_clear, 0);
+		kvm_irq_clear(vcpu, mask);
+	}
 
 	for_each_set_bit(priority, pending, EXCCODE_INT_NUM)
 		kvm_irq_deliver(vcpu, priority);
-- 
2.39.3

