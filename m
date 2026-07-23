Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DB46D2A8;
	Thu, 23 Jul 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805394; cv=none; b=r2FBh0fNjVTt/EsN2OtjyTGgNTJu28Y7+U2FXBEYYf8Xbrz8ngIPx6Rj9hYFageKryP9CRhUT6VozpHD0BYBOWQXL3S3zQZ6Gv2dgh9wgCnrQV5BVVcdc7Ee1xK9m7AoNFD1trErZfzzCXdsEYTKZkR03xrOJ/wPzcjE5xCy0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805394; c=relaxed/simple;
	bh=BXHfDBkLjwk/p9tPeFmqdKMra6gUzMwV0Qp1he+QsWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ly7BimWn/gsNhfBrmqJ+kf+qgEzZpNAd+fIHVMyGYEhjNhUsJ/8rhDJEV6dtnlMU7uWCcQ2QnRs5e7p39YTOPyWsokrNzVELPWfOV8sweEvDC3NNBb+gIYiPlsqwNYj3JLT2XIGk77bsU162jeASZG3i+lTNy+ZX9Yvbl2kZrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V8Z54e7C; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V8Z54e7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GK
	ZRI4b2nI9B4m6WAsZUHWrKS9FQXYqlTvwRckczEkk=; b=V8Z54e7CEHrNs+R9em
	gEtu3w40tFqfcjQyF3Q2Vd+PH4/rWIPYh/5uyffBxkJ+AEg6IQhmmGFqmFFRCZXM
	2CQQtFVf77ft0YrOk/qNZaUNrRWnrZkRb8HCzHO9KhFSvjMsXygCPrzSEV5/L/lT
	HXiUldJjUE5cNjYawDLWhF8iA=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXL9v392Fq4JzILA--.10535S2;
	Thu, 23 Jul 2026 19:16:07 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH 2/2] KVM: LoongArch: selftests: Add in-kernel MMIO read fast path test
Date: Thu, 23 Jul 2026 19:16:05 +0800
Message-Id: <20260723111605.1630027-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXL9v392Fq4JzILA--.10535S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy5CFyxCw1UKr1UXFy7KFg_yoWrZFWxpa
	y0kw1Yyr48Gr17Gr1xGws8uw4fKrs5JF4xXFn3XryS9r45JF9YqF1xKas7Xa43K3yFqr1a
	va48GF1Y93WDJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jerWrUUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwBgv6mph9-jVRQAA3J

From: Zeng Chi <zengchi@kylinos.cn>

Add a test that exercises the in-kernel MMIO read fast path of
kvm_emu_mmio_read(). The guest performs an MMIO read from an in-kernel
emulated PCH-PIC, immediately followed by a marker instruction, and the
test verifies that the marker instruction is executed, i.e. that the PC
advances by exactly one instruction instead of skipping the instruction
after the MMIO read.

The test skips gracefully when the host KVM cannot create a PCH-PIC
device.

Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  3 +-
 .../selftests/kvm/loongarch/mmio_read_test.c  | 89 +++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/loongarch/mmio_read_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6fc34e9bf8e1..4daf90caaabc 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -228,7 +228,8 @@ TEST_GEN_PROGS_riscv += mmu_stress_test
 TEST_GEN_PROGS_riscv += rseq_test
 TEST_GEN_PROGS_riscv += steal_time
 
-TEST_GEN_PROGS_loongarch = loongarch/pmu_test
+TEST_GEN_PROGS_loongarch = loongarch/mmio_read_test
+TEST_GEN_PROGS_loongarch += loongarch/pmu_test
 TEST_GEN_PROGS_loongarch += arch_timer
 TEST_GEN_PROGS_loongarch += coalesced_io_test
 TEST_GEN_PROGS_loongarch += demand_paging_test
diff --git a/tools/testing/selftests/kvm/loongarch/mmio_read_test.c b/tools/testing/selftests/kvm/loongarch/mmio_read_test.c
new file mode 100644
index 000000000000..7f64ca91ca8f
--- /dev/null
+++ b/tools/testing/selftests/kvm/loongarch/mmio_read_test.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LoongArch KVM in-kernel MMIO read fast path test
+ *
+ * When an MMIO read hits a device emulated inside KVM (such as the
+ * PCH-PIC), kvm_emu_mmio_read() completes the access without returning
+ * to user space and advances the guest PC by one instruction.
+ *
+ * This test issues such an in-kernel MMIO read immediately followed by
+ * a marker instruction and checks that the marker instruction actually
+ * runs, i.e. that the PC advanced by exactly one instruction (4 bytes)
+ * rather than skipping the instruction after the MMIO read.
+ */
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "loongarch/processor.h"
+
+/* Physical base the in-kernel PCH-PIC is mapped at (no memslot backs it) */
+#define PCH_PIC_BASE		0x10000000UL
+
+static void guest_code(void)
+{
+	unsigned long marker = 0;
+	unsigned int val = 0;
+
+	/*
+	 * 'ld.w' faults out as an MMIO read and is emulated in kernel.
+	 * The following 'addi.d' must execute; it is skipped if the MMIO
+	 * read fast path advances the PC twice (by 8 instead of 4).
+	 */
+	asm volatile(
+		"ld.w	%[val], %[base], 0\n\t"
+		"addi.d	%[marker], %[marker], 1\n\t"
+		: [val] "=&r" (val), [marker] "+&r" (marker)
+		: [base] "r" (PCH_PIC_BASE)
+		: "memory");
+
+	GUEST_PRINTF("mmio read val=0x%x, marker=%lu\n", val, marker);
+	GUEST_ASSERT_EQ(marker, 1);
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint64_t addr = PCH_PIC_BASE;
+	int dev_fd;
+
+	vm = vm_create(VM_MODE_P47V47_16K);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	/* Create the in-kernel PCH-PIC and map it at PCH_PIC_BASE */
+	dev_fd = __kvm_create_device(vm, KVM_DEV_TYPE_LOONGARCH_PCHPIC);
+	if (dev_fd < 0) {
+		print_skip("PCH-PIC device not supported by host KVM");
+		kvm_vm_free(vm);
+		return KSFT_SKIP;
+	}
+	kvm_device_attr_set(dev_fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL,
+			    KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT, &addr);
+	close(dev_fd);
+
+	/* Identity-map the MMIO page so the guest can reach the device */
+	virt_map(vm, PCH_PIC_BASE, PCH_PIC_BASE, 1);
+
+	while (1) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_PRINTF:
+			pr_info("%s", uc.buffer);
+			break;
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			goto done;
+		default:
+			TEST_FAIL("Unexpected exit: %s",
+				  exit_reason_str(vcpu->run->exit_reason));
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

