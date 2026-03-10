Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B97F44E05C;
	Tue, 10 Mar 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136352; cv=none; b=ViEt7pnVqbhZn1YutYkAmxdJqojzWpwvvkQM1nVl+XVrS/wOBGcvArjvimYW+HGC3tqGwuYZNMa9gIWMC8GOe1yFtbMLSsIf/qpsRx20stL+Bjhd+qPTQ13lkk1mV/BCvbduBbquDck2Mgn8yQyCbHsWHSxbWWslICKx7ij8rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136352; c=relaxed/simple;
	bh=a1uKxUjJubkgg11olvLlobm//6jTJ9MXX1VV2jbmJIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uj1Gvr7gC+LV6ZedTvCWKNGZ3QmpBwpgc1dw2ryxsaO210zgGSE9K7ATIkv12sf9SQ+P+IJ1XnOJuUhTsm4i8HkDdWG3/90fKD5t7zH4qeOl3fOq1rbjCRnf2gMkpxn5dvKI6RTtTrfbb4qgnuIC9QNxexdfcy3c6xa/BpD006A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Cx68LQ6a9pE3cZAA--.9031S3;
	Tue, 10 Mar 2026 17:52:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJDxzsLP6a9p7gVSAA--.24922S4;
	Tue, 10 Mar 2026 17:52:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn
Cc: loongarch@lists.linux.dev,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] KVM: LoongArch: selftests: Add basic PMU event counting test
Date: Tue, 10 Mar 2026 17:26:56 +0800
Message-Id: <20260310092657.1023650-3-gaosong@loongson.cn>
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
X-CM-TRANSID:qMiowJDxzsLP6a9p7gVSAA--.24922S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Introduce a basic PMU test that verifies hardware event counting for
four performance counters. The test enables events for CPU cycles,
instructions retired, branch instructions, and branch misses, runs a
fixed number of loops, and checks that the counter values fall within
expected ranges. It also validates that the host supports PMU and that
the VM feature is enabled.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/loongarch/pmu.h     |  46 +++++
 .../kvm/include/loongarch/processor.h         |   1 +
 .../selftests/kvm/lib/loongarch/processor.c   |   6 +-
 .../selftests/kvm/loongarch/guest_pmu_test.c  | 171 ++++++++++++++++++
 5 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/pmu.h
 create mode 100644 tools/testing/selftests/kvm/loongarch/guest_pmu_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fdec90e85467..137f97ad34c0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -221,6 +221,7 @@ TEST_GEN_PROGS_riscv += rseq_test
 TEST_GEN_PROGS_riscv += steal_time
 
 TEST_GEN_PROGS_loongarch = arch_timer
+TEST_GEN_PROGS_loongarch += loongarch/guest_pmu_test
 TEST_GEN_PROGS_loongarch += coalesced_io_test
 TEST_GEN_PROGS_loongarch += demand_paging_test
 TEST_GEN_PROGS_loongarch += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/include/loongarch/pmu.h b/tools/testing/selftests/kvm/include/loongarch/pmu.h
new file mode 100644
index 000000000000..0d9ecb9de8c3
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/loongarch/pmu.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * LoongArch PMU specific interface
+ */
+#ifndef SELFTEST_KVM_LOONGARCH_PMU_H
+#define SELFTEST_KVM_LOONGARCH_PMU_H
+
+#include "processor.h"
+
+/* Performance Counter registers */
+#define LOONGARCH_CSR_PERFCTRL0			0x200   /* perf event 0 config */
+#define LOONGARCH_CSR_PERFCNTR0			0x201   /* perf event 0 count value */
+#define LOONGARCH_CSR_PERFCTRL1			0x202   /* perf event 1 config */
+#define LOONGARCH_CSR_PERFCNTR1			0x203   /* perf event 1 count value */
+#define LOONGARCH_CSR_PERFCTRL2			0x204   /* perf event 2 config */
+#define LOONGARCH_CSR_PERFCNTR2			0x205   /* perf event 2 count value */
+#define LOONGARCH_CSR_PERFCTRL3			0x206   /* perf event 3 config */
+#define LOONGARCH_CSR_PERFCNTR3			0x207   /* perf event 3 count value */
+#define  CSR_PERFCTRL_PLV0			BIT(16)
+#define  CSR_PERFCTRL_PLV1			BIT(17)
+#define  CSR_PERFCTRL_PLV2			BIT(18)
+#define  CSR_PERFCTRL_PLV3			BIT(19)
+#define PMU_ENVENT_ENABLED	(CSR_PERFCTRL_PLV0 | CSR_PERFCTRL_PLV1 |\
+				CSR_PERFCTRL_PLV2 | CSR_PERFCTRL_PLV3)
+
+#define LOONGARCH_CPUCFG6			0x6
+#define  CPUCFG6_PMP				BIT(0)
+#define  CPUCFG6_PAMVER				GENMASK(3, 1)
+#define  CPUCFG6_PMNUM				GENMASK(7, 4)
+#define  CPUCFG6_PMNUM_SHIFT			4
+#define  CPUCFG6_PMBITS				GENMASK(13, 8)
+#define  CPUCFG6_PMBITS_SHIFT			8
+#define  CPUCFG6_UPM				BIT(14)
+
+/* Hardware event codes (from LoongArch perf_event.c */
+#define LOONGARCH_PMU_EVENT_CYCLES		0x00  /* CPU cycles */
+#define LOONGARCH_PMU_EVENT_INSTR_RETIRED	0x01  /* Instructions retired */
+#define PERF_COUNT_HW_BRANCH_INSTRUCTIONS	0x02  /* Branch instructions */
+#define PERF_COUNT_HW_BRANCH_MISSES		0x03  /* Branch misses */
+
+#define NUM_LOOPS                               1000
+#define EXPECTED_INSTR_MIN                      (NUM_LOOPS + 10)  /* Loop + overhead */
+#define EXPECTED_CYCLES_MIN                     NUM_LOOPS       /* At least 1 cycle per iteration */
+#define UPPER_BOUND				(10 * NUM_LOOPS)
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index b8f6c3348ddd..af8d05820961 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -189,6 +189,7 @@ struct handlers {
 	handler_fn exception_handlers[VECTOR_NUM];
 };
 
+void loongarch_vcpu_setup(struct kvm_vcpu *vcpu);
 void vm_init_descriptor_tables(struct kvm_vm *vm);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector, handler_fn handler);
 
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 68eb34032a99..a64d47ad6ce8 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -7,6 +7,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "ucall_common.h"
+#include "pmu.h"
 
 #define LOONGARCH_PAGE_TABLE_PHYS_MIN		0x200000
 #define LOONGARCH_GUEST_STACK_VADDR_MIN		0x200000
@@ -275,11 +276,12 @@ static void loongarch_set_cpucfg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t va
 	__vcpu_set_reg(vcpu, cfgid, val);
 }
 
-static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
+void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	int width;
 	unsigned long val;
 	struct kvm_vm *vm = vcpu->vm;
+	uint32_t cfg6;
 
 	switch (vm->mode) {
 	case VM_MODE_P36V47_16K:
@@ -290,6 +292,8 @@ static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}
 
+	cfg6 = read_cpucfg(LOONGARCH_CPUCFG6);
+	loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG6, cfg6);
 	/* kernel mode and page enable mode */
 	val = PLV_KERN | CSR_CRMD_PG;
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_CRMD, val);
diff --git a/tools/testing/selftests/kvm/loongarch/guest_pmu_test.c b/tools/testing/selftests/kvm/loongarch/guest_pmu_test.c
new file mode 100644
index 000000000000..59ec945b6e05
--- /dev/null
+++ b/tools/testing/selftests/kvm/loongarch/guest_pmu_test.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LoongArch KVM PMU event counting test
+ *
+ * Test hardware event counting: CPU_CYCLES, INSTR_RETIRED,
+ * BRANCH_INSTRUCTIONS and BRANCH_MISSES.
+ *
+ */
+#include "kvm_util.h"
+#include "loongarch/processor.h"
+#include "pmu.h"
+#include <linux/bitops.h>
+
+/* Guest test code - runs inside VM */
+static void guest_pmu_base_test(void)
+{
+	uint64_t cnt[4];
+	int i;
+	uint32_t cfg6, pmnum;
+
+	cfg6 = read_cpucfg(LOONGARCH_CPUCFG6);
+	pmnum = (cfg6 >> 4) & 0xf;
+	GUEST_PRINTF("CPUCFG6 = 0x%x\n", cfg6);
+	GUEST_PRINTF("PMP enabled: %s\n", (cfg6 & 0x1) ? "YES" : "NO");
+	GUEST_PRINTF("Number of counters (PMNUM): %x\n", pmnum + 1);
+	GUEST_ASSERT(pmnum == 3);
+
+	GUEST_PRINTF("Clean csr_perfcntr0-3\n");
+	csr_write(0, LOONGARCH_CSR_PERFCNTR0);
+	csr_write(0, LOONGARCH_CSR_PERFCNTR1);
+	csr_write(0, LOONGARCH_CSR_PERFCNTR2);
+	csr_write(0, LOONGARCH_CSR_PERFCNTR3);
+	GUEST_PRINTF("Set csr_perfctrl0 for cycles event\n");
+	csr_write(PMU_ENVENT_ENABLED |
+		LOONGARCH_PMU_EVENT_CYCLES, LOONGARCH_CSR_PERFCTRL0);
+	GUEST_PRINTF("Set csr_perfctrl1 for instr_retired event\n");
+	csr_write(PMU_ENVENT_ENABLED |
+		LOONGARCH_PMU_EVENT_INSTR_RETIRED, LOONGARCH_CSR_PERFCTRL1);
+	GUEST_PRINTF("Set csr_perfctrl2 for branch_instructions event\n");
+	csr_write(PMU_ENVENT_ENABLED |
+		PERF_COUNT_HW_BRANCH_INSTRUCTIONS, LOONGARCH_CSR_PERFCTRL2);
+	GUEST_PRINTF("Set csr_perfctrl3 for branch_misses event\n");
+	csr_write(PMU_ENVENT_ENABLED |
+		PERF_COUNT_HW_BRANCH_MISSES, LOONGARCH_CSR_PERFCTRL3);
+
+	for (i = 0; i < NUM_LOOPS; i++)
+		cpu_relax();
+
+	cnt[0] = csr_read(LOONGARCH_CSR_PERFCNTR0);
+	GUEST_PRINTF("csr_perfcntr0 is %lx\n", cnt[0]);
+	cnt[1] = csr_read(LOONGARCH_CSR_PERFCNTR1);
+	GUEST_PRINTF("csr_perfcntr1 is %lx\n", cnt[1]);
+	cnt[2] = csr_read(LOONGARCH_CSR_PERFCNTR2);
+	GUEST_PRINTF("csr_perfcntr2 is %lx\n", cnt[2]);
+	cnt[3] = csr_read(LOONGARCH_CSR_PERFCNTR3);
+	GUEST_PRINTF("csr_perfcntr3 is %lx\n", cnt[3]);
+
+	GUEST_PRINTF("assert csr_perfcntr0 >EXPECTED_CYCLES_MIN && csr_perfcntr0 < UPPER_BOUND\n");
+	GUEST_ASSERT(cnt[0] > EXPECTED_CYCLES_MIN && cnt[0] < UPPER_BOUND);
+	GUEST_PRINTF("assert csr_perfcntr1 > EXPECTED_INSTR_MIN && csr_perfcntr1 < UPPER_BOUND\n");
+	GUEST_ASSERT(cnt[1] > EXPECTED_INSTR_MIN && cnt[1] < UPPER_BOUND);
+	GUEST_PRINTF("assert csr_perfcntr2 > 0 && csr_perfcntr2 < UPPER_BOUND\n");
+	GUEST_ASSERT(cnt[2] > 0 && cnt[2] < UPPER_BOUND);
+	GUEST_PRINTF("assert csr_perfcntr3 > 0 && csr_perfcntr3 < UPPER_BOUND\n");
+	GUEST_ASSERT(cnt[3] > 0 && cnt[3] < UPPER_BOUND);
+
+}
+
+static void guest_code(void)
+{
+	guest_pmu_base_test();
+
+	GUEST_DONE();
+}
+
+/* check PMU support */
+static bool kvm_has_pmu_support(void)
+{
+	uint32_t cfg6;
+
+	/* Read CPUCFG6 to check PMU */
+	cfg6 = read_cpucfg(LOONGARCH_CPUCFG6);
+
+	/* Check PMU present bit */
+	if (!(cfg6 & CPUCFG6_PMP))
+		return false;
+
+	/* Check that at least one counter exists */
+	if (((cfg6 & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT) == 0)
+		return false;
+
+	return true;
+}
+/* Dump PMU capabilities */
+static void dump_pmu_caps(void)
+{
+	uint32_t cfg6;
+	int nr_counters, counter_bits;
+
+	cfg6 = read_cpucfg(LOONGARCH_CPUCFG6);
+	nr_counters = ((cfg6 & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT) + 1;
+	counter_bits = ((cfg6 & CPUCFG6_PMBITS) >> CPUCFG6_PMBITS_SHIFT) + 1;
+
+	pr_info("PMU capabilities:\n");
+	pr_info("  Counters present: %s\n", cfg6 & CPUCFG6_PMP ? "yes" : "no");
+	pr_info("  Number of counters: %d\n", nr_counters);
+	pr_info("  Counter width: %d bits\n", counter_bits);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_device_attr attr;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret = 0;
+	struct ucall uc;
+
+	/* Check host KVM PMU support */
+	if (!kvm_has_pmu_support()) {
+		print_skip("PMU not supported by host hardware\n");
+		dump_pmu_caps();
+		return KSFT_SKIP;
+	}
+	pr_info("Host support PMU\n");
+
+	/* Dump PMU capabilities */
+	dump_pmu_caps();
+
+	vm = vm_create(VM_MODE_P47V47_16K);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	vm_init_descriptor_tables(vm);
+	loongarch_vcpu_setup(vcpu);
+
+	attr.group = KVM_LOONGARCH_VM_FEAT_CTRL,
+	attr.attr = KVM_LOONGARCH_VM_FEAT_PMU,
+
+	ret = ioctl(vm->fd, KVM_HAS_DEVICE_ATTR, &attr);
+
+	if (ret == 0) {
+		pr_info("PMU is enabled in VM\n");
+	} else {
+		print_skip("PMU not enabled by VM config\n");
+		return KSFT_SKIP;
+	}
+
+	while (1) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_PRINTF:
+			printf("%s", (const char *)uc.buffer);
+			break;
+		case UCALL_DONE:
+			printf("PMU test PASSED\n");
+			goto done;
+		case UCALL_ABORT:
+			printf("PMU test FAILED\n");
+			ret = -1;
+			goto done;
+		default:
+			printf("Unexpected exit\n");
+			ret = -1;
+			goto done;
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+	return ret;
+}
+
-- 
2.47.3

