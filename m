Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3505C44CACB;
	Tue, 10 Mar 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136346; cv=none; b=saePiiZmUKAQz5CMUvBK/BTZnIfVRf61jvO1eko5LU2Tc1/5/w6ds2GbVW9aX1ZOizHzj/pYwyXJeRIPgWhgmwr05kJdzzTC3nppg0DCIezlUPvr+lbWTr28AmDR/Kx6sNsjkvNgitNXUbLCNtY8OqgwkJGGYR6f7SVVgtdcKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136346; c=relaxed/simple;
	bh=ctXQiTZW13quB11/yeg5Pmi6ZLAOVK7tZ/Okfn+1Il4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NH0GyrfPOTVeKk1QBaHXBgThooWcG02GtODV6k1ivaXEEwSpPmMWImFvN1uLINCW1yWBpTmkOhTZ6jSlcma8NVwVr5wYJST0hAD6GCue+6JqZMSMnJxrZFwL7mjFPvP3sD7Au38Kv2D66Q5E+Hi9g3q6zLp9h6ZS74hfi3DOqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8BxEMDR6a9pF3cZAA--.15824S3;
	Tue, 10 Mar 2026 17:52:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJDxzsLP6a9p7gVSAA--.24922S5;
	Tue, 10 Mar 2026 17:52:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn
Cc: loongarch@lists.linux.dev,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] KVM: LoongArch: selftests: Add PMU overflow interrupt test
Date: Tue, 10 Mar 2026 17:26:57 +0800
Message-Id: <20260310092657.1023650-4-gaosong@loongson.cn>
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
X-CM-TRANSID:qMiowJDxzsLP6a9p7gVSAA--.24922S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Extend the PMU test suite to cover overflow interrupts. The test enables
the PMI (Performance Monitor Interrupt), sets counter 0 to one less than
the overflow value, and verifies that an interrupt is raised when the
counter overflows. A guest interrupt handler checks the interrupt cause
and disables further PMU interrupts upon success.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 .../selftests/kvm/include/loongarch/pmu.h     | 20 +++++++++++
 .../kvm/include/loongarch/processor.h         |  3 ++
 .../selftests/kvm/loongarch/guest_pmu_test.c  | 36 ++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/loongarch/pmu.h b/tools/testing/selftests/kvm/include/loongarch/pmu.h
index 0d9ecb9de8c3..6009811ad4ca 100644
--- a/tools/testing/selftests/kvm/include/loongarch/pmu.h
+++ b/tools/testing/selftests/kvm/include/loongarch/pmu.h
@@ -22,6 +22,7 @@
 #define  CSR_PERFCTRL_PLV3			BIT(19)
 #define PMU_ENVENT_ENABLED	(CSR_PERFCTRL_PLV0 | CSR_PERFCTRL_PLV1 |\
 				CSR_PERFCTRL_PLV2 | CSR_PERFCTRL_PLV3)
+#define  CSR_PERFCTRL_PMIE			BIT(20)
 
 #define LOONGARCH_CPUCFG6			0x6
 #define  CPUCFG6_PMP				BIT(0)
@@ -43,4 +44,23 @@
 #define EXPECTED_CYCLES_MIN                     NUM_LOOPS       /* At least 1 cycle per iteration */
 #define UPPER_BOUND				(10 * NUM_LOOPS)
 
+#define PMU_OVERFLOW				(1ULL << 63)
+static inline void pmu_irq_enable(void)
+{
+	unsigned long val;
+
+	val = csr_read(LOONGARCH_CSR_ECFG);
+	val |= ECFGF_PMU;
+	csr_write(val, LOONGARCH_CSR_ECFG);
+}
+
+static inline void pmu_irq_disable(void)
+{
+	unsigned long val;
+
+	val = csr_read(LOONGARCH_CSR_ECFG);
+	val &= ~ECFGF_PMU;
+	csr_write(val, LOONGARCH_CSR_ECFG);
+}
+
 #endif
diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index af8d05820961..9b5859831ba8 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -83,6 +83,8 @@
 #define LOONGARCH_CSR_PRMD		0x1
 #define LOONGARCH_CSR_EUEN		0x2
 #define LOONGARCH_CSR_ECFG		0x4
+#define  ECFGB_PMU			10
+#define  ECFGF_PMU			(BIT_ULL(ECFGB_PMU))
 #define  ECFGB_TIMER			11
 #define  ECFGF_TIMER			(BIT_ULL(ECFGB_TIMER))
 #define LOONGARCH_CSR_ESTAT		0x5  /* Exception status */
@@ -90,6 +92,7 @@
 #define  CSR_ESTAT_EXC_WIDTH		6
 #define  CSR_ESTAT_EXC			(0x3f << CSR_ESTAT_EXC_SHIFT)
 #define    EXCCODE_INT			0    /* Interrupt */
+#define	     INT_PMI			10   /* PMU interrupt */
 #define      INT_TI			11   /* Timer interrupt*/
 #define LOONGARCH_CSR_ERA		0x6  /* ERA */
 #define LOONGARCH_CSR_BADV		0x7  /* Bad virtual address */
diff --git a/tools/testing/selftests/kvm/loongarch/guest_pmu_test.c b/tools/testing/selftests/kvm/loongarch/guest_pmu_test.c
index 59ec945b6e05..598ab96ed237 100644
--- a/tools/testing/selftests/kvm/loongarch/guest_pmu_test.c
+++ b/tools/testing/selftests/kvm/loongarch/guest_pmu_test.c
@@ -11,6 +11,7 @@
 #include "pmu.h"
 #include <linux/bitops.h>
 
+static int pmu_irq_count;
 /* Guest test code - runs inside VM */
 static void guest_pmu_base_test(void)
 {
@@ -66,10 +67,40 @@ static void guest_pmu_base_test(void)
 
 }
 
+static void guest_pmu_interrupt_test(void)
+{
+	uint64_t cnt;
+
+	csr_write(PMU_OVERFLOW - 1, LOONGARCH_CSR_PERFCNTR0);
+	csr_write(PMU_ENVENT_ENABLED  | CSR_PERFCTRL_PMIE |
+	LOONGARCH_PMU_EVENT_CYCLES, LOONGARCH_CSR_PERFCTRL0);
+
+	cpu_relax();
+
+	GUEST_ASSERT_EQ(pmu_irq_count, 1);
+	cnt = csr_read(LOONGARCH_CSR_PERFCNTR0);
+	GUEST_PRINTF("PMU interrupt test success\n");
+	GUEST_PRINTF("csr_perfcntr0 is %lx\n", cnt);
+
+}
+
+static void  guest_irq_handler(struct ex_regs *regs)
+{
+	unsigned int intid;
+
+	intid = !!(regs->estat & BIT(INT_PMI));
+	GUEST_ASSERT_EQ(intid, 1);
+	GUEST_PRINTF("get PMU interrupt\n");
+	WRITE_ONCE(pmu_irq_count, pmu_irq_count + 1);
+	pmu_irq_disable();
+}
+
 static void guest_code(void)
 {
 	guest_pmu_base_test();
-
+	pmu_irq_enable();
+	local_irq_enable();
+	guest_pmu_interrupt_test();
 	GUEST_DONE();
 }
 
@@ -131,6 +162,9 @@ int main(int argc, char *argv[])
 
 	vm_init_descriptor_tables(vm);
 	loongarch_vcpu_setup(vcpu);
+	vm_install_exception_handler(vm, EXCCODE_INT, guest_irq_handler);
+	pmu_irq_count = 0;
+	sync_global_to_guest(vm, pmu_irq_count);
 
 	attr.group = KVM_LOONGARCH_VM_FEAT_CTRL,
 	attr.attr = KVM_LOONGARCH_VM_FEAT_PMU,
-- 
2.47.3

