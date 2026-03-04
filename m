Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B952F5468;
	Wed,  4 Mar 2026 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587981; cv=none; b=NvzF6SMB4LgHsqJOGrw9AWg3Uf4yPS4lXTJUjjPVn13kwJouq7DUAuutDQJz8RNGl+IHCOP+llVSg+hfb0nUCkVGeLYv/0VsPaaaAVga00yf8NbSqnJahnwdOIZTzwCE0FcpymPkopGEI8RxckqVAKXpJqJZhO42Pwo1yGr2F88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587981; c=relaxed/simple;
	bh=33SGLST8+UpM50/Nwz/riVG5btj7miMTPQLL7AhgVjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=et56Onaoi8d7k+wboN1c+bxo+jPgETxXT2HE8cEh7fL+mbhUpRrBhCfTFFOGi3736MDhWW+qf6dPT3ap+p0Ye7CiwLIwnpbxj1ZjHt2WweSyymaHwLmhFHpIxhE3qWjQ/E44KFWaW/3xYSw02cJMOpQhrFV6qSew4FO8ZB3D5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxgsDHi6dpCEMXAA--.10893S3;
	Wed, 04 Mar 2026 09:32:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMLHi6dpo_NNAA--.15250S2;
	Wed, 04 Mar 2026 09:32:55 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Fix typo issue in kvm_vm_init_features()
Date: Wed,  4 Mar 2026 09:32:54 +0800
Message-Id: <20260304013254.2543620-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMLHi6dpo_NNAA--.15250S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Most of VM feature detection is integer or operation, and integer
assignment operation will clear previous integer or operation. Here
change integer assignment operation with integer or operation.

Fixes: 82db90bf461b ("LoongArch: KVM: Move feature detection in kvm_vm_init_features()")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 63fd40530aa9..a555ea037cf5 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -49,8 +49,8 @@ static void kvm_vm_init_features(struct kvm *kvm)
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PMU);
 
 	/* Enable all PV features by default */
-	kvm->arch.pv_features = BIT(KVM_FEATURE_IPI);
-	kvm->arch.kvm_features = BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
+	kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI);
+	kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
 	if (kvm_pvtime_supported()) {
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_PREEMPT);
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);

base-commit: 4d349ee5c7782f8b27f6cb550f112c5e26fff38d
-- 
2.39.3

