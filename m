Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9C3C0A01;
	Tue, 16 Jun 2026 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576803; cv=none; b=BtEPt5yOWWfFGkDne7DhSpvpF7s5sVjJp/uZIllmDpTFhDOd2j6aBGTxA0R8PsjZG48IHeFCsmcmzHtJFyiDMr3KJjAFKrvzXr8lFdmUIxuklSbpp5XJ+YG1yktZK3ZtIUG1GsCz4t+Q9naS2MTyfBZOkGK6fjahm8OMntfkYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576803; c=relaxed/simple;
	bh=4VNbeuAEBxmJSqCtxGL09pPzAi93oBcZmmlW/auoegw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RW5waaO1GrIurj+gK39zIGAXUnnmaUgrxTDZkiXcSHGM5azmrzHMF3e6svrEfe89da6HMsgfzqNpbFIKafKdaVweeO3+m84HRloOfcDv8e6TdvbFnUX2Mei55uXjqbYLx6XY9HF19t6XUwkwL2xpDigHZbzGCCSfs8fbxihYaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxHupOtDBqdZsUAA--.53100S3;
	Tue, 16 Jun 2026 10:26:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxXcJItDBqz7WnAA--.54020S3;
	Tue, 16 Jun 2026 10:26:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/2] KVM: LoongArch: selftests: Enable LASX feature by auto detect method
Date: Tue, 16 Jun 2026 10:26:14 +0800
Message-Id: <20260616022615.2141072-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260616022615.2141072-1-maobibo@loongson.cn>
References: <20260616022615.2141072-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxXcJItDBqz7WnAA--.54020S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add LSX and LASX features when VM is created. These features are detected
firstly, enable it if it is available on host machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../selftests/kvm/include/loongarch/processor.h      | 10 ++++++++++
 .../testing/selftests/kvm/lib/loongarch/processor.c  | 12 +++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index 93dc1fbd2e79..2324e311180f 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -131,6 +131,16 @@
 #define  CSR_TLBREHI_PS_SHIFT		0
 #define  CSR_TLBREHI_PS			(0x3fUL << CSR_TLBREHI_PS_SHIFT)
 
+#define LOONGARCH_CPUCFG2		0x2
+#define  CPUCFG2_FP			BIT(0)
+#define  CPUCFG2_FPSP			BIT(1)
+#define  CPUCFG2_FPDP			BIT(2)
+#define  CPUCFG2_FPVERS			GENMASK(5, 3)
+#define  CPUCFG2_LSX			BIT(6)
+#define  CPUCFG2_LASX			BIT(7)
+#define  CPUCFG2_LLFTP			BIT(14)
+#define  CPUCFG2_LLFTPREV		GENMASK(17, 15)
+
 #define read_cpucfg(reg)			\
 ({						\
 	register unsigned long __v;		\
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 64d91fb76522..e7fb54d746f4 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -278,7 +278,7 @@ static void loongarch_set_csr(struct kvm_vcpu *vcpu, u64 id, u64 val)
 
 void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	int width;
+	int width, ret;
 	unsigned int cfg;
 	unsigned long val;
 	struct kvm_vm *vm = vcpu->vm;
@@ -292,6 +292,16 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}
 
+	/* Enable LSX/LASX feature by detecting host capability */
+	cfg = CPUCFG2_FP | CPUCFG2_FPSP | CPUCFG2_FPDP | CPUCFG2_LLFTP;
+	ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_LOONGARCH_VM_FEAT_LSX);
+	if (!ret)
+		cfg |= CPUCFG2_LSX;
+
+	ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_LOONGARCH_VM_FEAT_LASX);
+	if (!ret)
+		cfg |= CPUCFG2_LASX;
+	loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG2, cfg);
 	cfg = read_cpucfg(LOONGARCH_CPUCFG6);
 	loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG6, cfg);
 
-- 
2.39.3

