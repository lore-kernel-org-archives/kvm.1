Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245008;
	b=hblMc+Mga4PyjZ+MiDaizB0m1q8d9HfVALcwQRKHjNh8RoMAi7MTvFa6xGQRQtZHtO+E
	 7mHVAMp+6GJRCV0N9Agq7WskJD5MdZeGGI6mbjNA/oF8VZPcbOpF0nwcV69UPPr+4ydfq
	 6jU3E0FB6wh9hD9wPKJLw0ho8qCdX0WfdgdaasEzHx9cS7euy4IkZLsCT4FSnN994XVZu
	 UIAZ/k8UAmrc7uN8GQ6qWuEGT/9/Z2oI6KH/N8THjGv2Xmh1pxs2D6o2ibxBGbqB9P9Yb
	 Vouxf1rz/9U1JxBL216t8LEvawt7kaoeoghnFOH57NgtNqIxaY5escDIYPD2lQJWZpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245008;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=XUB/7JwFVR3vCwhz9vzj6yKZKYA2g43PyYaNlGDfQBs=;
	b=nVmT7adLTz2b3/QuNmOJytiSfE/oVz9uEQytOgEVk/8UelJ8zFHpHiFb+koFqUQziB7P
	 Mqo1+huNhOWMHWXsdEPGvVgD6WFTaEIU8JzXT7cteCJAI2By2zHiZ9ViSLLFIhu7RHTUX
	 Of5VW1W0wSjxyjuZRhyVYXOK2WNhnyUAuLog2VBkL221Ee2gF31jlybjl1SCxjtQEckw0
	 EWvelGZK6DNoVslUKB23Y6TAlbEX+NlQQCQwHAFCe4q4sNGyHyPzFS3UQU8cjZB4PTfR3
	 AjNbFgq4heMIoGTpZrXE5iHbmB5otLYgYicihDZFuFBOjSUDqGy1hbH7YWC7YaE4FGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53333606A31F;
	Thu, 29 Oct 2026 03:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53333606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxOvBNv+Jq1FMaAA--.11225S3;
	Thu, 29 Oct 2026 11:36:45 +0800 (CST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJDxzM5Nv+JqXRAxAA--.11789S2;
	Thu, 29 Oct 2026 11:36:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Add KVM_LOONGARCH_VM_FEAT_CRASH feature detect support
Date: Thu, 29 Oct 2026 11:36:36 +0800
Message-Id: <20261029033636.1280539-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzM5Nv+JqXRAxAA--.11789S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add feature detect with KVM_LOONGARCH_VM_FEAT_CRASH, so that VMM in
user space can detect and enable this feature.

Fixes: 00289c235d40 ("LoongArch: KVM: Add hypercall crash support")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index e4c1c65fe20b..ba5fdfcd7016 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -165,6 +165,7 @@ static int kvm_vm_feature_has_attr(struct kvm *kvm, struct kvm_device_attr *attr
 	case KVM_LOONGARCH_VM_FEAT_PV_IPI:
 	case KVM_LOONGARCH_VM_FEAT_PV_PREEMPT:
 	case KVM_LOONGARCH_VM_FEAT_PV_STEALTIME:
+	case KVM_LOONGARCH_VM_FEAT_CRASH:
 		if (kvm_vm_support(&kvm->arch, attr->attr))
 			return 0;
 		return -ENXIO;

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.39.3

