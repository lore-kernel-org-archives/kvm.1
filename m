Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F637F015
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342951; cv=none; b=kmtrrASXuNP6K/Nb4xbtgrjiXUoTV7HT3Twa+PBcM4yP1mcLA49lsbm95XaaZZYt2VVgQuTr57Li8E9yVnEYoRvqLv05XzlKc4MHoFg4iGazDQsv1H1HxSMc8O7ImqjC17Za689V77qchb7kRT5Sj7Md1kFf/hhmsqugcXt58iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342951; c=relaxed/simple;
	bh=g7TGWEaiwNnmyXwaF7kNuuVbx3rmLGTy9MDWTG2+2G0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rds5BTYbV6q2ob0N66rWfzRveXvWQQ7IQObd5xNosnCjzOvl8VAbNxlKSSPyJxAhqiZIxsSIHVa/k6IQvYU5gndEZxQW+djvJgGfHh3WURvzlJPAL1M7sfSV/L7HyTcJvEjPDK1Z8RbZKjYENO31vI8LC7w70O9y3LBExmtwJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UuujFTIp; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UuujFTIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=mWS8DLoF+8WX+fl6SSFMX+Usz5CJpmKeA+HLpxaTHaQ=;
	b=UuujFTIpgNmGEzVlo8muIc6iOUoPKYR0xu2H4Miy7+v1QB6A5z61p3TdBokLri
	pt9PlAXZMc3R54Tn9k4XhagV5ASUoGDJpPMmFKwnSiuSeZv+lL1/sBpfq7duvfIU
	ESOVuc/Xys4jGAac1zZo+eaupUCEKgp/jRo6Ovy7exhAQ=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAny0MRbnlqPqW+Jw--.16452S2;
	Mon, 10 Aug 2026 14:22:10 +0800 (CST)
Date: Mon, 10 Aug 2026 14:22:09 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: selftests: Verify failed IOAPIC delivery
 preserves state
Message-ID: <anluERKCXkZglDEe@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anls-aUppuiFolpS@192.168.1.215>
X-CM-TRANSID:PCgvCgAny0MRbnlqPqW+Jw--.16452S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ary3try7ur4fKr48KFWkCrg_yoW7Gw1Dp3
	ykGa4qvrWrGryxKF1rJF1DGF45uFyDCayrC348uryrtFWrJrZ7ZFn7Zry8Za4Ygw40kasa
	v3WfX345u3yUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRuT5JUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3RKYi2p5bhIVXgAA34

From: Hao Zhang <zhanghao1@kylinos.cn>

Add regression coverage for I/O APIC interrupt delivery when no local
APIC can accept the interrupt.

For level-triggered interrupts, verify that failed delivery does not set
remote_irr, because no local APIC accepted the interrupt and no EOI will
ever be generated.

For edge-triggered interrupts, verify that failed delivery does not cause
KVM_GET_IRQCHIP to drop the pending IRR bit.  Edge interrupts are hidden
from the saved IRR state only after they have actually been delivered.

Both cases use an I/O APIC-only GSI and inject the interrupt before
creating any vCPUs, forcing KVM_IRQ_LINE_STATUS to report failed
delivery.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 108 +++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/ioapic_state_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6fc34e9bf8e1..89e3f82e75b0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -86,6 +86,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_features
 TEST_GEN_PROGS_x86 += x86/hyperv_ipi
 TEST_GEN_PROGS_x86 += x86/hyperv_svm_test
 TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
+TEST_GEN_PROGS_x86 += x86/ioapic_state_test
 TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
diff --git a/tools/testing/selftests/kvm/x86/ioapic_state_test.c b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
new file mode 100644
index 000000000000..3613a67f4b21
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Regression tests for in-kernel I/O APIC state.
+ */
+
+#include "kvm_util.h"
+#include "test_util.h"
+
+#define TEST_IOAPIC_PIN		16
+#define TEST_VECTOR		0x50
+#define NO_SUCH_APIC_ID		0xfe
+#define TEST_IOAPIC_EDGE_TRIG	0
+#define TEST_IOAPIC_LEVEL_TRIG	1
+
+static void get_ioapic(struct kvm_vm *vm, struct kvm_irqchip *irqchip)
+{
+	int r;
+
+	irqchip->chip_id = KVM_IRQCHIP_IOAPIC;
+	r = __vm_ioctl(vm, KVM_GET_IRQCHIP, irqchip);
+	if (r && errno == ENXIO)
+		__TEST_REQUIRE(0, "In-kernel I/O APIC not available");
+
+	TEST_ASSERT(!r, KVM_IOCTL_ERROR(KVM_GET_IRQCHIP, r));
+}
+
+static void set_ioapic(struct kvm_vm *vm, struct kvm_irqchip *irqchip)
+{
+	irqchip->chip_id = KVM_IRQCHIP_IOAPIC;
+	vm_ioctl(vm, KVM_SET_IRQCHIP, irqchip);
+}
+
+static void set_undeliverable_ioapic_entry(struct kvm_vm *vm,
+					   bool level_triggered)
+{
+	struct kvm_irqchip irqchip;
+
+	get_ioapic(vm, &irqchip);
+
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.vector = TEST_VECTOR;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.dest_id = NO_SUCH_APIC_ID;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.dest_mode = 0;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.trig_mode =
+		level_triggered ? TEST_IOAPIC_LEVEL_TRIG :
+				  TEST_IOAPIC_EDGE_TRIG;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.mask = 0;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.remote_irr = 0;
+
+	set_ioapic(vm, &irqchip);
+}
+
+static void test_no_remote_irr_for_undelivered_interrupt(void)
+{
+	struct kvm_irq_level irq = {
+		.irq = TEST_IOAPIC_PIN,
+		.level = 1,
+	};
+	struct kvm_irqchip irqchip;
+	struct kvm_vm *vm;
+
+	vm = vm_create_barebones();
+	vm_create_irqchip(vm);
+
+	set_undeliverable_ioapic_entry(vm, true);
+
+	vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq);
+	TEST_ASSERT(irq.status == -1,
+		    "Expected failed interrupt delivery, got %d", irq.status);
+
+	get_ioapic(vm, &irqchip);
+	TEST_ASSERT(!irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.remote_irr,
+		    "KVM set remote_irr for a level-triggered interrupt that wasn't delivered");
+
+	kvm_vm_free(vm);
+}
+
+static void test_undelivered_edge_interrupt_stays_pending(void)
+{
+	struct kvm_irq_level irq = {
+		.irq = TEST_IOAPIC_PIN,
+		.level = 1,
+	};
+	struct kvm_irqchip irqchip;
+	struct kvm_vm *vm;
+
+	vm = vm_create_barebones();
+	vm_create_irqchip(vm);
+
+	set_undeliverable_ioapic_entry(vm, false);
+
+	vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq);
+	TEST_ASSERT(irq.status == -1,
+		    "Expected failed interrupt delivery, got %d", irq.status);
+
+	get_ioapic(vm, &irqchip);
+	TEST_ASSERT(irqchip.chip.ioapic.irr & (1 << TEST_IOAPIC_PIN),
+		    "KVM dropped an undelivered edge-triggered interrupt from IRR");
+
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	test_no_remote_irr_for_undelivered_interrupt();
+	test_undelivered_edge_interrupt_stays_pending();
+
+	return 0;
+}
-- 
2.15.0

