Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58722B594;
	Tue, 26 May 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799983; cv=none; b=sCOuOObxzBucV6JtSF+QOtRlnCkf8CzrApJbytwCxDuNzNV4F9ic25HEXcWeM+rBz1vVJNnijJUCr9BZIIQ09BTIhLXQfFnhVXkvH4UPFjg3BPjepBrQ5Ss1HDhvhqsJV8fb1zt7C5QXVSdYDPCofN5o/uWdbQTfARLmnnlM0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799983; c=relaxed/simple;
	bh=YXvPAAq9mWglp8bbJDg6RlfHdjGIxJI5tkxM4tuS3Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZSHARRodAW3hXTyu2iWOAI1JHMDwzsF6mmTBx7nnAEIDe1tQZBVfoxNVM5By81DmaIeQPhMaQRwYjAt31nCu8ShjKasfiCmml76kLgAFKf8t0UZa88rXjgVSEBsZg6c/CCyhPA8Ef4DeHJ9K7OTHwlZhkYF5fnMsKmbqkRTeOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxncCslxVqHWgNAA--.14407S3;
	Tue, 26 May 2026 20:53:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxWcGplxVqbZiRAA--.1284S4;
	Tue, 26 May 2026 20:52:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] LoongArch: KVM: Check msgint feature in interrupt post
Date: Tue, 26 May 2026 20:52:51 +0800
Message-Id: <20260526125256.2511876-3-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAxWcGplxVqbZiRAA--.1284S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Interrupt AVEC is valid only if VM has msgint feature, and this feature
is checked in interrupt handling. Since interrupt handling is executing
in VM context switch, and it is hot path, here move the feature checking
in interrupt post rather than interrupt handling.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/interrupt.c |  5 -----
 arch/loongarch/kvm/vcpu.c      | 14 +++++++++-----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index a18c60dffbba..48dd56aa4dc5 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -36,8 +36,6 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 
 	switch (priority) {
 	case INT_AVEC:
-		if (!kvm_guest_has_msgint(&vcpu->arch))
-			break;
 		dmsintc_inject_irq(vcpu);
 		fallthrough;
 	case INT_TI:
@@ -75,9 +73,6 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 
 	switch (priority) {
 	case INT_AVEC:
-		if (!kvm_guest_has_msgint(&vcpu->arch))
-			break;
-		fallthrough;
 	case INT_TI:
 	case INT_IPI:
 	case INT_SWI0:
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index df5be9b265e8..ebd432da3ca4 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1493,14 +1493,18 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 	if (vector >= EXCCODE_INT_NUM)
 		return -EINVAL;
 
-	if (intr > 0)
+	if (!kvm_guest_has_msgint(&vcpu->arch) && (vector == INT_AVEC))
+		return -EINVAL;
+
+	/*
+	 * Clear irq with INT_SWI0 (which is 0) is missing from SW side
+	 * INT_SWI0 is cleared by guest kernel with the similar instruction
+	 * clear_csr_estat(1 << INT_SWI0)
+	 */
+	if (intr >= 0)
 		kvm_queue_irq(vcpu, intr);
 	else if (intr < 0)
 		kvm_dequeue_irq(vcpu, -intr);
-	else {
-		kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
-		return -EINVAL;
-	}
 
 	kvm_vcpu_kick(vcpu);
 
-- 
2.39.3

