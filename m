Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2E37CD47;
	Tue, 14 Apr 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151399; cv=none; b=Qc4mxN/0tMF6d2CicEQsAkC3sRJI+IYbA/o9k5fzHAE7N5esxiFcT6DaNZUNZ1FSJiqqgw/oi26VoT0VNP/HJTbG2/yauJHgRadirxWvhlfZKiBWorANNr2EzwSbHAStrXxjG02prAxvL9ogEckA0kXYeopEjsUu4gmM1dSe6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151399; c=relaxed/simple;
	bh=m9vLfXkwAGNcbtz4PWLItZyVz3fDONiH0jAW58kcJVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/Zgr9Zc53ADVP02orHNe7bB3tYquISpxddizkEiEyuVf5/l/pJRtxou//RXzOz7wDg8DqUZ8tkORm9kvwEGSnOLoAxKP6g9SCgi7GqoidV7tyeDCP9i6udM3AxmNy1jRipBRYYOOHQpUEdJf7bmpJF+YykjLEuOcIQih6GLZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx8epk691p8mkAAA--.2096S3;
	Tue, 14 Apr 2026 15:23:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxfcJi691pErxsAA--.8539S3;
	Tue, 14 Apr 2026 15:23:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] LoongArch: KVM: Move AVEC interrupt injection in switch loop
Date: Tue, 14 Apr 2026 15:23:11 +0800
Message-Id: <20260414072313.3801110-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260414072313.3801110-1-maobibo@loongson.cn>
References: <20260414072313.3801110-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxfcJi691pErxsAA--.8539S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When AVEC interrupt controller is emulated in user space, AVEC interrupt
is injected by software like SIP0/IPI interrupt. Here move AVEC
interrupt injection in switch loop.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/interrupt.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index fb704f4c8ac5..f67dddfec7d0 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -32,12 +32,11 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	if (priority < EXCCODE_INT_NUM)
 		irq = priority_to_irq[priority];
 
-	if (kvm_guest_has_msgint(&vcpu->arch) && (priority == INT_AVEC)) {
-		set_gcsr_estat(irq);
-		return 1;
-	}
-
 	switch (priority) {
+	case INT_AVEC:
+		if (!kvm_guest_has_msgint(&vcpu->arch))
+			break;
+		fallthrough;
 	case INT_TI:
 	case INT_IPI:
 	case INT_SWI0:
@@ -64,12 +63,11 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 	if (priority < EXCCODE_INT_NUM)
 		irq = priority_to_irq[priority];
 
-	if (kvm_guest_has_msgint(&vcpu->arch) && (priority == INT_AVEC)) {
-		clear_gcsr_estat(irq);
-		return 1;
-	}
-
 	switch (priority) {
+	case INT_AVEC:
+		if (!kvm_guest_has_msgint(&vcpu->arch))
+			break;
+		fallthrough;
 	case INT_TI:
 	case INT_IPI:
 	case INT_SWI0:
-- 
2.39.3

