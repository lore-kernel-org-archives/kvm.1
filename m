Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9C39BFE6;
	Tue, 19 May 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183796; cv=none; b=StnyEkckCHlF1juCqKklCVrYn/zLt0B8iJqidGoaFYDXip53uylV8s1qJLB46iUd4TuCtIrV21zdCYgMTo8vZSwQEc3zmRBGCSHSPyrNcEU4iTFrrwjsB4UO6F0eT4jG0fpwmP9/AmUDmPqf63ILfRdjrqNdZkgZdKcwjWRgjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183796; c=relaxed/simple;
	bh=jRgxzR5R5e3osofRZx8RtxmKw2RC7rx8wLXzJD6MlwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRUAxHyvwK6OwzD/rg0dltLT3Y87Iq1XyrNXbdW9/uV6U2xKTeHQzOs8DkG/IfWhpQYMdxuO4+tpH3elCnXxvDdo0FJ/kqa8EHBMVorN+N7OQMe26P6ULqzlkY7CDKjOKDa6hSrxfebip4xGf/mu0+JJrsTg3YYHpgqYnopzdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxdnivMAxqXS0LAA--.8403S3;
	Tue, 19 May 2026 17:43:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMKtMAxqjD6IAA--.61010S3;
	Tue, 19 May 2026 17:43:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/6] LoongArch: KVM: Check irq validility in kvm_vcpu_ioctl_interrupt()
Date: Tue, 19 May 2026 17:43:03 +0800
Message-Id: <20260519094308.3983046-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260519094308.3983046-1-maobibo@loongson.cn>
References: <20260519094308.3983046-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKtMAxqjD6IAA--.61010S3
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
 arch/loongarch/kvm/vcpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..673977a25138 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1486,7 +1486,14 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 {
-	int intr = (int)irq->irq;
+	int vector, intr = (int)irq->irq;
+
+	vector = intr;
+	if (intr < 0)
+		vector = -intr;
+
+	if (vector >= EXCCODE_INT_NUM)
+		return -EINVAL;
 
 	if (intr > 0)
 		kvm_queue_irq(vcpu, intr);
-- 
2.39.3

