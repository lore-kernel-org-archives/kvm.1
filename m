Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBEB449ED2;
	Thu, 22 Jan 2026 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080488; cv=none; b=JvIx784VVmqS6v2o6Cqfu6vxsn9kUBpMesCJKxScCQY/vwXbkI0MTz59ufWNVvYjVG/WyoZYUbZ1W9jC3ktTJvtcp1JbsAOiraknU8Jd5D61Y0H7i6OCdlQMmsPmViDnxHq1CbIed+uBW73S70O00TrogBTdhJ9VogCFKqHHyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080488; c=relaxed/simple;
	bh=GBEwIMlOfud73+AdzLtZf6JUYUDPLFklNoFIZ8RKkXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sd6RVF0BKZoOwzUStNtuxelibEjaw9OSemccsOPiVfXIX+YRtwG7p5TxT/oywL4Yx0oEv7wuSyrXMnhRkhx0DyyahiMNoiUy9Gc9DwIiixp/LoHpBGZv6bJgNYfX20QUbpDOqDivfjq012tNSdaBq/zXUZCevzgIEbYzbBgBeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxmsKcBnJpyHsLAA--.37269S3;
	Thu, 22 Jan 2026 19:14:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxquCbBnJpwR4rAA--.21397S3;
	Thu, 22 Jan 2026 19:14:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 1/3] LoongArch: KVM: Move LSX capability check in LSX exception handler
Date: Thu, 22 Jan 2026 19:14:31 +0800
Message-Id: <20260122111434.1737872-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260122111434.1737872-1-maobibo@loongson.cn>
References: <20260122111434.1737872-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxquCbBnJpwR4rAA--.21397S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Like FPU exception handler, check LSX capability in LSX exception
handler rather than kvm_own_lsx().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/exit.c | 4 +++-
 arch/loongarch/kvm/vcpu.c | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index cb493980d874..76eec3f24953 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -792,8 +792,10 @@ static long kvm_save_notify(struct kvm_vcpu *vcpu)
  */
 static int kvm_handle_lsx_disabled(struct kvm_vcpu *vcpu, int ecode)
 {
-	if (kvm_own_lsx(vcpu))
+	if (!kvm_guest_has_lsx(&vcpu->arch))
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
+	else
+		kvm_own_lsx(vcpu);
 
 	return RESUME_GUEST;
 }
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 656b954c1134..aff295aa6b0b 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1358,9 +1358,6 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 /* Enable LSX and restore context */
 int kvm_own_lsx(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_guest_has_fpu(&vcpu->arch) || !kvm_guest_has_lsx(&vcpu->arch))
-		return -EINVAL;
-
 	preempt_disable();
 
 	/* Enable LSX for guest */
-- 
2.39.3

