Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357462FE057;
	Wed, 23 Sep 2026 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126730; cv=none; b=QU3CLsnLj1vL3Dhsg8I8pusmfCk7405pOclp+KAJALWhdv5DumEXP7MEsTI5opdn0AbUEHrri0SXuqo/cF0rSIEvZN+26b/iautWZ5lWGXtQyI9xmSQJfRjVP11gWkaYJGiitRSddQ+U0NTeSE8BExJOJ881tj2/hV0jceip/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126730; c=relaxed/simple;
	bh=nZrOVK9FPxlpstQa1JW3zYNU6W7mZPfqskLeSanf9bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppZkdwl3X2FEZhmQ8tdjKqJ+UD2WLH55nY4pfaSiMIWed+mIxpC3DC88IdLDix1MG39ncb72cTqv4W6ZWeJNSssINEximHtDb31YK82FNw4jhhRYQnsC18HCH25G0DRJQ0Cpol+JNZa1naVc4lFemqVFZqE22p62ps0ApMThRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxTtOGKrNqVdwOAA--.43100S3;
	Wed, 23 Sep 2026 09:25:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx6c2EKrNqyQIkAA--.45699S4;
	Wed, 23 Sep 2026 09:25:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 2/2] LoongArch: KVM: Remove duplicated checking with DMSI irq injection
Date: Wed, 23 Sep 2026 09:18:03 +0800
Message-Id: <20260923011803.1057945-3-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJBx6c2EKrNqyQIkAA--.45699S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There are some duplicated error checking in DMSI interrupt injection
function, also vcpu::arch::dmsintc_state is structure rather than pointer,
NULL pointer checking with dmsintc_state is not necessary, here remove
these unnecessary checking.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c | 32 +++++++------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 79e56e330aeb..6fe52471007c 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -14,9 +14,6 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 	unsigned long vector[4], old;
 	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
 
-	if (!ds)
-		return;
-
 	for (i = 0; i < 4; i++) {
 		old = atomic64_read(&(ds->vector_map[i]));
 		vector[i] = old ? atomic64_xchg(&(ds->vector_map[i]), 0) : 0;
@@ -43,25 +40,6 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 	}
 }
 
-static int dmsintc_deliver_msi_to_vcpu(struct kvm_vcpu *vcpu, u32 vector)
-{
-	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
-
-	if (!vcpu || vector >= 256)
-		return -EINVAL;
-	if (!ds)
-		return -ENODEV;
-
-	if (!kvm_guest_has_msgint(&vcpu->arch))
-		return -EINVAL;
-
-	set_bit(vector, (unsigned long *)&ds->vector_map);
-	kvm_queue_irq(vcpu, INT_AVEC);
-	kvm_vcpu_kick(vcpu);
-
-	return 0;
-}
-
 int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data)
 {
 	unsigned int irq, cpu;
@@ -69,13 +47,17 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data)
 
 	irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
 	cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
-	if (cpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
 	vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
 	if (!vcpu)
 		return -EINVAL;
 
-	return dmsintc_deliver_msi_to_vcpu(vcpu, irq);
+	if (!kvm_guest_has_msgint(&vcpu->arch))
+		return -EINVAL;
+
+	set_bit(irq, (unsigned long *)&vcpu->arch.dmsintc_state.vector_map);
+	kvm_queue_irq(vcpu, INT_AVEC);
+	kvm_vcpu_kick(vcpu);
+	return 0;
 }
 
 static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
-- 
2.39.3

