Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD93F4107;
	Tue, 14 Jul 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014366; cv=none; b=Fm5tekVk+euWlL1RSBMFnooqH1aHbLL2sVID3iQCpi54iDzM/3me+wwvjVwuHGx4KmIw6C9xd0H4Oxidut0FBphS5KrUtHfw8Bf/T70C6KGP+xq+ITJsuR4NicdjzKfCO2HdYYsRgIaLpdO4US0k64N+1Mkb8ky7NF1zj0uFD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014366; c=relaxed/simple;
	bh=O0PYKArdyd0ZTgrp+9S9jfX/yUyb+wlnAvv2d8vvLeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gt5i1qRkgXU9IIxbn/XGZQe82xkq8QcuJOG2Iyxp3RQPTOFCrkLMPtXls/J7E1l0iSO4EEBn+++2FOOP1wPDPqdm1w/uuqh9d+J4IJZbL1EnSyDhtFcc7QXlEFaqFVWR+F3nM/1PtnwarwQiemqIBXRPqK/7W5xsJlPOTpt2+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxSesa5lVqrFMDAA--.13305S3;
	Tue, 14 Jul 2026 15:32:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxIuQT5lVqzZEMAA--.38917S4;
	Tue, 14 Jul 2026 15:32:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Song Gao <gaosong@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] LoongArch: KVM: Return directly when IPI address is not aligned
Date: Tue, 14 Jul 2026 15:25:17 +0800
Message-Id: <20260714072520.2745942-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260714072520.2745942-1-maobibo@loongson.cn>
References: <20260714072520.2745942-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuQT5lVqzZEMAA--.38917S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When IPI address is not aligned with its access size, it should return
directly in read/write operations, rather than only print WARN_ON_ONCE().
The method is the same with in kernel extioi and pch_pic operations.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/ipi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 4fa0897d7bdb..928f9bd5e1f1 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -186,9 +186,13 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcpu, gpa_t addr, int len, void
 	uint32_t offset;
 	uint64_t res = 0;
 
-	offset = (uint32_t)(addr & 0x1ff);
-	WARN_ON_ONCE(offset & (len - 1));
+	if (addr & (len - 1)) {
+		*(uint64_t *)val = res;
+		kvm_pr_unimpl("%s: ipi not aligned addr %llx len %d\n", __func__, addr, len);
+		return 0;
+	}
 
+	offset = addr - IOCSR_IPI_BASE;
 	switch (offset) {
 	case IOCSR_IPI_STATUS:
 		spin_lock(&vcpu->arch.ipi_state.lock);
@@ -204,11 +208,6 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcpu, gpa_t addr, int len, void
 	case IOCSR_IPI_CLEAR:
 		break;
 	case IOCSR_IPI_BUF_20 ... IOCSR_IPI_BUF_38 + 7:
-		if (offset + len > IOCSR_IPI_BUF_38 + 8) {
-			kvm_err("%s: invalid offset or len: offset = %d, len = %d\n",
-				__func__, offset, len);
-			break;
-		}
 		res = read_mailbox(vcpu, offset, len);
 		break;
 	default:
@@ -227,9 +226,12 @@ static int loongarch_ipi_writel(struct kvm_vcpu *vcpu, gpa_t addr, int len, cons
 
 	data = *(uint64_t *)val;
 
-	offset = (uint32_t)(addr & 0x1ff);
-	WARN_ON_ONCE(offset & (len - 1));
+	if (addr & (len - 1)) {
+		kvm_pr_unimpl("%s: ipi not aligned addr %llx len %d\n", __func__, addr, len);
+		return 0;
+	}
 
+	offset = addr - IOCSR_IPI_BASE;
 	switch (offset) {
 	case IOCSR_IPI_STATUS:
 		break;
-- 
2.39.3

