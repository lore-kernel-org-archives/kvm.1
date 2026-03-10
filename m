Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35244105C;
	Tue, 10 Mar 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136347; cv=none; b=BP3An6lj6q6sDEMM610gEWmSJydeK1WsyVEUorQFc6MU7xo6UYU7LVIY+ivaDnOXavjsPICXdVwsTg7nrs5Yq9Ko2QWeah4NCapCIVzsMplvmv68kumyI7B3h+imTp8Eseem9QHQTL1gdMHdq2P0xTC5JCnMOS/8bsBqjpti2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136347; c=relaxed/simple;
	bh=aDK2zjIo/VGAi78xisCb95IxYzIab8mD5RWmB9xKoaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ik01EF1KZWQy2T1NQFH5qGkwA41a4VR53QfqX3yQf/tCNJROcXcG7lMF1syeEYwSv7fnXkMxjhXnthPn0GeZLQzlkQBDsJNBdRKnx0e/pCPLoGI5bY0YEzcY3fadtIdRmD5gFpKA0Ym7h2fBwCjNRdqNT45h8y8g8+7uUqhBq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Axw8DQ6a9pDXcZAA--.15654S3;
	Tue, 10 Mar 2026 17:52:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJDxzsLP6a9p7gVSAA--.24922S3;
	Tue, 10 Mar 2026 17:52:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn
Cc: loongarch@lists.linux.dev,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: LoongArch: selftests: Add cpucfg read/write helpers
Date: Tue, 10 Mar 2026 17:26:55 +0800
Message-Id: <20260310092657.1023650-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260310092657.1023650-1-gaosong@loongson.cn>
References: <20260310092657.1023650-1-gaosong@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsLP6a9p7gVSAA--.24922S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add helper macros and functions to read and write CPU configuration
registers (cpucfg) from within the guest and from the VMM. This
interface is required for querying and setting CPU features, such as
PMU capabilities, in upcoming selftests.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 .../selftests/kvm/include/loongarch/processor.h       | 11 +++++++++++
 tools/testing/selftests/kvm/lib/loongarch/processor.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index 76840ddda57d..b8f6c3348ddd 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -150,6 +150,17 @@
 	__v;					\
 })
 
+#define read_cpucfg(reg)			\
+({						\
+	register unsigned long __v;		\
+	__asm__ __volatile__(			\
+		"cpucfg %0, %1\n\t"		\
+		: "=r" (__v)			\
+		: "r" (reg)			\
+		: "memory");			\
+	 __v;					\
+})
+
 #define EXREGS_GPRS			(32)
 
 #ifndef __ASSEMBLER__
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 17aa55a2047a..68eb34032a99 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -267,6 +267,14 @@ static void loongarch_set_csr(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val)
 	__vcpu_set_reg(vcpu, csrid, val);
 }
 
+static void loongarch_set_cpucfg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val)
+{
+	uint64_t cfgid;
+
+	cfgid = KVM_REG_LOONGARCH_CPUCFG | KVM_REG_SIZE_U64 | 8 * id;
+	__vcpu_set_reg(vcpu, cfgid, val);
+}
+
 static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	int width;
-- 
2.47.3

