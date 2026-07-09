Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FB3EDE6A;
	Thu,  9 Jul 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585717; cv=none; b=SgDfCwk5woTAxjRcTSM0k7POsdTvldMClAgmrk05+Z8sv6IeQz3V9exer1W3hOhGSPAafrpF0N/xNMqobvLUn9NjJUw+DSrFWJS9SkynvuwwZqZs9yEZ4KL0d8QibEOBscs/aSCFmiG0dEVtxRB2YVZVEotj+ay1W/4+xfVRK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585717; c=relaxed/simple;
	bh=++JNIRDcmqDW09//3t1KfwK6Ve49mGiUWaRQoN47vpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPBo/IeSy+Rwd+zy6aqhvddbYj0DJWyiKd0Vxc7b4Cye/Bx1hI2PWAuaqBYDe55XxWyNcLYYOlbKXFQdvucaboTXxiKm0CWRS8vQoCaL9GGHxxQt3pwbtSrwS3X6b88fJDmPasenTa9X4pdeqOOJ/98IRcvj+DGDGRbAIXjHdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxaeuwW09q6sYBAA--.7555S3;
	Thu, 09 Jul 2026 16:28:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxnMapW09q3qIGAA--.32266S5;
	Thu, 09 Jul 2026 16:28:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] LoongArch: KVM: Return directly when IPI address is not aligned
Date: Thu,  9 Jul 2026 16:21:08 +0800
Message-Id: <20260709082109.1361767-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260709082109.1361767-1-maobibo@loongson.cn>
References: <20260709082109.1361767-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxnMapW09q3qIGAA--.32266S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When IPI address is not aligned with its access size, it should return
directly in read/write operations, rather than only print WARN_ON_ONCE().
The method is the same with in kernel extioi and pch_pic operations.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/ipi.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index bccdfd963e5b..8ec40e09c5ab 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -181,9 +181,12 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcpu, gpa_t addr, int len, void
 	uint32_t offset;
 	uint64_t res = 0;
 
-	offset = (uint32_t)(addr & 0x1ff);
-	WARN_ON_ONCE(offset & (len - 1));
+	if (addr & (len - 1)) {
+		kvm_pr_unimpl("%s: ipi not aligned addr %llx len %d\n", __func__, addr, len);
+		return 0;
+	}
 
+	offset = addr - IOCSR_IPI_BASE;
 	switch (offset) {
 	case IOCSR_IPI_STATUS:
 		spin_lock(&vcpu->arch.ipi_state.lock);
@@ -199,11 +202,6 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcpu, gpa_t addr, int len, void
 	case IOCSR_IPI_CLEAR:
 		break;
 	case IOCSR_IPI_BUF_20 ... IOCSR_IPI_BUF_38 + 7:
-		if (offset + len > IOCSR_IPI_BUF_38 + 8) {
-			kvm_pr_unimpl("%s: invalid offset or len: offset = %d, len = %d\n",
-				__func__, offset, len);
-			break;
-		}
 		res = read_mailbox(vcpu, offset, len);
 		break;
 	default:
@@ -222,9 +220,12 @@ static int loongarch_ipi_writel(struct kvm_vcpu *vcpu, gpa_t addr, int len, cons
 
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
@@ -241,11 +242,6 @@ static int loongarch_ipi_writel(struct kvm_vcpu *vcpu, gpa_t addr, int len, cons
 		ipi_clear(vcpu, data);
 		break;
 	case IOCSR_IPI_BUF_20 ... IOCSR_IPI_BUF_38 + 7:
-		if (offset + len > IOCSR_IPI_BUF_38 + 8) {
-			kvm_pr_unimpl("%s: invalid offset or len: offset = %d, len = %d\n",
-				__func__, offset, len);
-			break;
-		}
 		write_mailbox(vcpu, offset, data, len);
 		break;
 	case IOCSR_IPI_SEND:
-- 
2.39.3

