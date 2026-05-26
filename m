Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999A224234;
	Tue, 26 May 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799983; cv=none; b=hU4vmyjMCrdMkFBLfBDmbY4wGj4E1h+Dn5pYRXb6j8xBUf881j3Vq94rYH6AIIAI7YL9tzmfEeI4U9e6W8+xfoK7aIel3iQrUI6RtfCl9MxwsTne2PRVF7uv/221UWZSsvpHiyCbJf3UdcaLmYBszTraAIR64aJibEHLA/dDTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799983; c=relaxed/simple;
	bh=xf2yltQCPL4KYbVDKfNIsg8mC4dPbeakx6my0quoUbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcjSGVpFAp399Y6SSL+vkJJ7RU1oT/Ane/zNP/3ifZkbHQM43OZ2IZuWu72kc794SaUOKN8Z+RKm4tkZdASYos28kw0FOParbKejjywkXYPemthRAQ0ldeljLgqcX8JP0YFxRMrp+6jzb5KWEIiTSzovuBd31TWMairuBmo5vbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxrOmrlxVqGWgNAA--.36459S3;
	Tue, 26 May 2026 20:52:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxWcGplxVqbZiRAA--.1284S3;
	Tue, 26 May 2026 20:52:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/6] LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()
Date: Tue, 26 May 2026 20:52:50 +0800
Message-Id: <20260526125256.2511876-2-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAxWcGplxVqbZiRAA--.1284S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Function kvm_vcpu_ioctl_interrupt() can be called from userspace, here
add irq validility cheking in kvm_vcpu_ioctl_interrupt().

Fixes: f45ad5b8aa93 ("LoongArch: KVM: Implement vcpu interrupt operations")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..df5be9b265e8 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1487,6 +1487,11 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 {
 	int intr = (int)irq->irq;
+	unsigned int vector;
+
+	vector = abs(intr);
+	if (vector >= EXCCODE_INT_NUM)
+		return -EINVAL;
 
 	if (intr > 0)
 		kvm_queue_irq(vcpu, intr);
-- 
2.39.3

