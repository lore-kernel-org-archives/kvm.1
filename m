Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E735F18B;
	Wed, 23 Sep 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127084; cv=none; b=og6kN+0wT5zuKaTCaPFoCeh5lp7c6EsI/GwOHTBRSO5gd6Y8vJcNn7XR1sUDLAPDh28bgJaU/zHTYJa4gPoCsbrao2j50Q12NFo6fBS2r7tY/KYIx5NJf8Co3dNEXapOF8wDumZ8S5I7injwi3cYg7eIcmMRzyQcMBpI6d1E79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127084; c=relaxed/simple;
	bh=rAhP4ycQCC6kZ0Cn2Gr67i5s82Iz0iIBumYuC/rA9Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2qWDWKf9Gya4lOiN2pJAkX5tWqOGYl8urbfpdbUokfVfX3k62HDm08WKD4HSMxiPCSS8UjU5xcxzsVGcLJjJ7/pcLZszInyrXIF7KDLt06lgs1Z3xBhB56ZrTeh4BJ6eSNG3gxuvfZz8z7eFJoMjv5uOaWU0Pdy6GHB/qKOBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxXdLmK7Nq4dwOAA--.43711S3;
	Wed, 23 Sep 2026 09:31:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxE+TlK7NqTgMkAA--.46508S2;
	Wed, 23 Sep 2026 09:31:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: LoongArch: selftests: Enable HW PTW by auto detection method
Date: Wed, 23 Sep 2026 09:23:56 +0800
Message-Id: <20260923012356.1058379-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxE+TlK7NqTgMkAA--.46508S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add HW PTW feature when VM is created. This feature is detected firstly,
enable it if it is available on host machine. With HW PTW feature enabled,
refill exception will not happen and it is not necessary to set refill
exception entry.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../selftests/kvm/include/loongarch/processor.h  |  3 +++
 .../selftests/kvm/lib/loongarch/processor.c      | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index 0e59daa8024e..8d9fabdc89e3 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -79,6 +79,7 @@
 #define  CPUCFG2_LASX			BIT(7)
 #define  CPUCFG2_LLFTP			BIT(14)
 #define  CPUCFG2_LLFTPREV		GENMASK(17, 15)
+#define  CPUCFG2_PTW			BIT(24)
 
 /* LoongArch Basic CSR registers */
 #define LOONGARCH_CSR_CRMD		0x0 /* Current mode info */
@@ -128,6 +129,8 @@
 #define LOONGARCH_CSR_PGD		0x1b
 #define LOONGARCH_CSR_PWCTL0		0x1c
 #define LOONGARCH_CSR_PWCTL1		0x1d
+#define  CSR_PWCTL1_PTW_SHIFT		24
+#define  CSR_PWCTL1_PTW			BIT_ULL(CSR_PWCTL1_PTW_SHIFT)
 #define LOONGARCH_CSR_STLBPGSIZE	0x1e
 #define LOONGARCH_CSR_CPUID		0x20
 #define LOONGARCH_CSR_KS0		0x30
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 47bbde3e205a..35e35c62759f 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -282,6 +282,7 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 	unsigned int cfg;
 	unsigned long val;
 	struct kvm_vm *vm = vcpu->vm;
+	bool has_ptw = false;
 
 	switch (vm->mode) {
 	case VM_MODE_P36V47_16K:
@@ -300,6 +301,12 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 	ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_LOONGARCH_VM_FEAT_LASX);
 	if (!ret)
 		cfg |= CPUCFG2_LASX;
+	ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_LOONGARCH_VM_FEAT_PTW);
+	if (!ret) {
+		cfg |= CPUCFG2_PTW;
+		has_ptw = true;
+	}
+
 	loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG2, cfg);
 	cfg = read_cpucfg(LOONGARCH_CPUCFG6);
 	loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG6, cfg);
@@ -338,6 +345,9 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	/* PGD page shift and width */
 	val = (vm->page_shift + width * (vm->mmu.pgtable_levels - 1)) | width << 6;
+	if (has_ptw)
+		val |= CSR_PWCTL1_PTW;
+
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL1, val);
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_PGDL, vm->mmu.pgd);
 
@@ -345,8 +355,10 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 	 * Refill exception runs on real mode
 	 * Entry address should be physical address
 	 */
-	val = addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
-	loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
+	if (!has_ptw) {
+		val = addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
+		loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
+	}
 
 	/*
 	 * General exception runs on page-enabled mode

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.39.3

