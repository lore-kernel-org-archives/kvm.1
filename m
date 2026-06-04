Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A73D6CAE;
	Thu,  4 Jun 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563483; cv=none; b=EvH3asb5cw0Z6kI5vqcBWe8RsMYu+FYdK6/bnCcPRrxO6aZ7DdvxNa15lPTYPJaPWESRAlP/8zoSQsqsdAb1TgBVMeHgAXO6iqJtIQgNEhijQWpTkLLhBTpjwl8C9VDj1E3yWGWAwqHdIpMdhYDKYOsX/FsWJzULb42lAbPUANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563483; c=relaxed/simple;
	bh=aFjfiS6Ccq8MRExNzQOvB6UC/aSBLiumOfINILAX5Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuWmHhM29gBVt0VI9xgunCvDhXhFFTd3uRGSBzcEG09dy9JQy4t4RHC3o57KjM35WMU+rVUpEREqGyUJTvf4X2HMdQ4w8yczNeklfZFIA4ptNJutnP/7IKpiV07ScT0cmU0JktolI6hwSM+P0BiReRnwU38eK7HVA0bluUOB2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxhukUPiFq9HkQAA--.45704S3;
	Thu, 04 Jun 2026 16:57:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAx28ERPiFqlIObAA--.31690S4;
	Thu, 04 Jun 2026 16:57:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] KVM: LoongArch: selftests: Add FPU test case
Date: Thu,  4 Jun 2026 16:57:52 +0800
Message-Id: <20260604085752.2820331-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260604085752.2820331-1-maobibo@loongson.cn>
References: <20260604085752.2820331-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx28ERPiFqlIObAA--.31690S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add FPU test case and verify FPU register get and set APIs, the
FPU width supports 64/128/256 bits.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/loongarch/fpu_test.c        | 144 ++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..7d11592b3759 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -224,6 +224,7 @@ TEST_GEN_PROGS_riscv += rseq_test
 TEST_GEN_PROGS_riscv += steal_time
 
 TEST_GEN_PROGS_loongarch = loongarch/pmu_test
+TEST_GEN_PROGS_loongarch += loongarch/fpu_test
 TEST_GEN_PROGS_loongarch += arch_timer
 TEST_GEN_PROGS_loongarch += coalesced_io_test
 TEST_GEN_PROGS_loongarch += demand_paging_test
diff --git a/tools/testing/selftests/kvm/loongarch/fpu_test.c b/tools/testing/selftests/kvm/loongarch/fpu_test.c
new file mode 100644
index 000000000000..459996286c83
--- /dev/null
+++ b/tools/testing/selftests/kvm/loongarch/fpu_test.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
+#include "kvm_util.h"
+#include "processor.h"
+#include "loongarch/processor.h"
+
+struct kvm_fpureg vector = {{1, 2, 3, 4 }};
+
+static void guest_code(void)
+{
+	unsigned long val;
+	struct kvm_fpureg *fp = &vector;
+
+	val = csr_read(LOONGARCH_CSR_EUEN);
+	csr_write(val | 7, LOONGARCH_CSR_EUEN);
+
+	__asm__ __volatile__("fld.d $f0, %0, 0\n" : : "r"(fp) :);
+	GUEST_SYNC(0);
+
+	__asm__ __volatile__("vld $vr0, %0, 0\n" : : "r"(fp) : );
+	GUEST_SYNC(1);
+
+	__asm__ __volatile__("xvld $xr0, %0, 0\n" : : "r"(fp) :);
+	GUEST_SYNC(2);
+
+	__asm__ __volatile__("fst.d $f0, %0, 0\n" : : "r"(fp) : "memory");
+	GUEST_SYNC(3);
+
+	__asm__ __volatile__("vst $vr0, %0, 0\n" : : "r"(fp) : "memory");
+	GUEST_SYNC(4);
+
+	__asm__ __volatile__("xvst $xr0, %0, 0\n" : : "r"(fp) : "memory");
+	GUEST_SYNC(5);
+
+	GUEST_DONE();
+}
+
+static void run_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	int cont;
+
+	cont = 1;
+	while (cont) {
+		vcpu_run(vcpu);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_PRINTF:
+			printf("%s", (const char *)uc.buffer);
+			break;
+		case UCALL_DONE:
+			printf("FPU test PASSED\n");
+		case UCALL_SYNC:
+			cont = 0;
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_ASSERT(false, "Unexpected exit: %s",
+				exit_reason_str(vcpu->run->exit_reason));
+		}
+	}
+}
+
+static bool __vm_has_feature(struct kvm_vm *vm, int feature)
+{
+	int ret;
+
+	ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, feature);
+	return !ret;
+}
+
+
+int main(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct kvm_fpu fpu;
+	struct kvm_fpureg *fp = &vector;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	__TEST_REQUIRE(__vm_has_feature(vm, KVM_LOONGARCH_VM_FEAT_LSX),
+			"LSX not available, skipping test\n");
+	__TEST_REQUIRE(__vm_has_feature(vm, KVM_LOONGARCH_VM_FEAT_LASX),
+			"LASX not available, skipping test\n");
+
+	run_vcpu(vcpu);
+	vcpu_fpu_get(vcpu, &fpu);
+	sync_global_from_guest(vm, *fp);
+	TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx",
+			fp->val64[0], fpu.fpr[0].val64[0]);
+
+	run_vcpu(vcpu);
+	vcpu_fpu_get(vcpu, &fpu);
+	TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got 0x%llx %llx",
+			fp->val64[0], fp->val64[1],
+			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);
+
+	run_vcpu(vcpu);
+	vcpu_fpu_get(vcpu, &fpu);
+	TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
+			"Wanted 0x%llx %llx %llx %llx from xr0, got 0x%llx %llx %llx %llx",
+			fp->val64[0], fp->val64[1], fp->val64[2], fp->val64[3],
+			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
+			fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);
+
+	fpu.fpr[0].val64[0] += 0x10;
+	vcpu_fpu_set(vcpu, &fpu);
+	run_vcpu(vcpu);
+	vcpu_fpu_get(vcpu, &fpu);
+	sync_global_from_guest(vm, *fp);
+	TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx",
+			fp->val64[0], fpu.fpr[0].val64[0]);
+
+	fpu.fpr[0].val64[0] += 0x10;
+	fpu.fpr[0].val64[1] += 0x10;
+	vcpu_fpu_set(vcpu, &fpu);
+	run_vcpu(vcpu);
+	vcpu_fpu_get(vcpu, &fpu);
+	sync_global_from_guest(vm, *fp);
+	TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got 0x%llx %llx",
+			fp->val64[0], fp->val64[1],
+			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);
+
+	fpu.fpr[0].val64[0] += 0x10;
+	fpu.fpr[0].val64[1] += 0x10;
+	fpu.fpr[0].val64[2] += 0x10;
+	fpu.fpr[0].val64[3] += 0x10;
+	vcpu_fpu_set(vcpu, &fpu);
+	run_vcpu(vcpu);
+	vcpu_fpu_get(vcpu, &fpu);
+	sync_global_from_guest(vm, *fp);
+	TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
+			"Wanted 0x%llx %llx %llx %llx from xr0, got 0x%llx %llx %llx %llx",
+			fp->val64[0], fp->val64[1], fp->val64[2], fp->val64[3],
+			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
+			fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);
+
+	run_vcpu(vcpu);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.39.3

