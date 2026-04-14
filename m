Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD036E47F;
	Tue, 14 Apr 2026 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151411; cv=none; b=WK1vpn5poz59IQOQC9WscYcXNh6UJqkfj9aDkx3g8KTovwaeWNS/Sr6SoBR2YeE9m92/nYwwBxtgAt06jSdij9qI++HYCnZLf2vWVvoSKALN2L26atP+gXlxZbhiErk0LeR2K6dAoHbVgRx6PCRYMhin21gaC+JwtoDOyfavYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151411; c=relaxed/simple;
	bh=tESCXq+yp8XK39DMet5wQKnmpLoNPeIl300dX6w+ZZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpB/ZRdz3m2k6uard5kIA2hKnPKj8vb+uuz0TgSFj90bt7Rtbfg0oauL/AA/lVDxdH3K4irkadWMurJtwipCFuHA/aEDiLklVQk+P+fHbvMoKUFhthSsXr8WSCSXVJWJmIj1OzCaMihS1wbIzktJ0Ig7rVQL2tQnHwixtykCVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxAutn691p+2kAAA--.2106S3;
	Tue, 14 Apr 2026 15:23:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxfcJi691pErxsAA--.8539S4;
	Tue, 14 Apr 2026 15:23:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] LoongArch: KVM: Fix HW timer interrupt lost when inject interrupt from software
Date: Tue, 14 Apr 2026 15:23:12 +0800
Message-Id: <20260414072313.3801110-3-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCxfcJi691pErxsAA--.8539S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With passthrough HW timer, timer interrupt is injected by HW. When
inject emulated CPU interrupt by software such CPU_SIP0/CPU_IPI, HW
timer interrupt may be lost.

Here check whether there is timer tick value reversion before and after
injecting emulated CPU interrupt by software, timer enabling by reading
timer cfg register is skipped here. If timer tick value is detected
with value changed, timer should be enabled. And inject timer interrupt
by software if there is.

Cc: <stable@vger.kernel.org>
Fixes: f45ad5b8aa93 ("LoongArch: KVM: Implement vcpu interrupt operations").
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/interrupt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index f67dddfec7d0..422515744dc0 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -27,6 +27,7 @@ static unsigned int priority_to_irq[EXCCODE_INT_NUM] = {
 static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 {
 	unsigned int irq = 0;
+	unsigned long old, new;
 
 	clear_bit(priority, &vcpu->arch.irq_pending);
 	if (priority < EXCCODE_INT_NUM)
@@ -41,7 +42,20 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	case INT_IPI:
 	case INT_SWI0:
 	case INT_SWI1:
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
 		set_gcsr_estat(irq);
+		new = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
+		/*
+		 * On some platforms, the passthrought HW timer interrupt
+		 * is lost when inject CPU interrupt by software if HW
+		 * timer interrupt is arriving.
+		 *
+		 * Here check whether there is inversion with timer tick
+		 * value, inject timer interrupt by SW if so.
+		 */
+
+		if (new > old)
+			set_gcsr_estat(CPU_TIMER);
 		break;
 
 	case INT_HWI0 ... INT_HWI7:
@@ -58,6 +72,7 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 {
 	unsigned int irq = 0;
+	unsigned long old, new;
 
 	clear_bit(priority, &vcpu->arch.irq_clear);
 	if (priority < EXCCODE_INT_NUM)
@@ -72,7 +87,11 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 	case INT_IPI:
 	case INT_SWI0:
 	case INT_SWI1:
+		old = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
 		clear_gcsr_estat(irq);
+		new = kvm_read_hw_gcsr(LOONGARCH_CSR_TVAL);
+		if (new > old)
+			set_gcsr_estat(CPU_TIMER);
 		break;
 
 	case INT_HWI0 ... INT_HWI7:
-- 
2.39.3

