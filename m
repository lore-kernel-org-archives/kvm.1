Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB018DF80;
	Thu,  6 Mar 2025 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227527; cv=none; b=FZPoVP9UaV76VnyrTSml9onDBR2/EAUfDrWXSdC5LmKOWgj6RlNNO9aS3QcPszZlDl5dKeOtuNXBAplsAeGeMj8BNY+dA0xTIFIHs7rZv5vvkZXPjsv5h7y4HyBZM3OYyoYXSpUBrpZNcVB8pPcSBMGUw89qg+QWqmTZmxDa/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227527; c=relaxed/simple;
	bh=en3UvaCU0h9YBK+KvaBYWsRGVN1XAwBxSdsnclYeHgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHREMhN0AUZltDeo6J1n/YB+0n+yCnohvFOTlC2aojgeoTKhtK7spnStEVhEkO+NjBGoFyhxf5nu1Qg/mTbr+hV/L05WNfy510jydbS/tZ8JeOJFJz7wg0mmfxJDIoevOAV81X32K2iw/voixl8qz3Zojhguc8R21v1KIdzRln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxG6wCBslngcqLAA--.10156S3;
	Thu, 06 Mar 2025 10:18:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxu8QABslnjKE4AA--.11561S4;
	Thu, 06 Mar 2025 10:18:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 2/2] LoongArch: KVM: Add interrupt checking with Loongson AVEC
Date: Thu,  6 Mar 2025 10:18:40 +0800
Message-Id: <20250306021840.2120016-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250306021840.2120016-1-maobibo@loongson.cn>
References: <20250306021840.2120016-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8QABslnjKE4AA--.11561S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There is newly added macro INT_AVEC with CSR ESTAT register, which is
bit 14 used for Loongson AVEC support. AVEC interrupt status bit 14 is
supported with macro CSR_ESTAT_IS, here replace hardcoded value 0x1fff
with macro CSR_ESTAT_IS so that AVEC interrupt status is supported by
KVM also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20f941af3e9e..9e1a9b4aa4c6 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -311,7 +311,7 @@ static int kvm_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int ret = RESUME_GUEST;
 	unsigned long estat = vcpu->arch.host_estat;
-	u32 intr = estat & 0x1fff; /* Ignore NMI */
+	u32 intr = estat & CSR_ESTAT_IS;
 	u32 ecode = (estat & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
 
 	vcpu->mode = OUTSIDE_GUEST_MODE;
-- 
2.39.3

