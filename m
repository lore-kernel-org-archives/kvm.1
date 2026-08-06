Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036730216D
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024040; cv=none; b=MISuDOy5Xa9ap0KjRWFBoNR1cZmqs53PDS4jnD8t1Le0Hg3zpd1FFFrKXcuDbM9V3QVjEMC8CZJ9cTZOvdAFjxmUgTXGNII8GsLnL2bT6WnuR0P7X1m7oMAmXG3tZgcBWTlfKwZ2MbKuttzeY/mSheLKRKYwYtcwH/imFn5ahXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024040; c=relaxed/simple;
	bh=GYei0px+oHMZUx5qon8jifTbYchdV5wg1cgBGyw3eBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WGdWDcmq1n1yuqVKLNjK6M6KJkSKh8WHSJb6PeQKcGwQzkSscn33GoYe0McdKsXEip9caloNIUfakaT9iRXW4j5vDtBBIaXprQFKCZEgj8hEC26zN/Dw8FW/b4oOMs4mfvmrhSr6/F6fpQmLsFvWtI///wMrseiYXiE8NOvdY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ny019XLH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ny019XLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9vBpc8/wF5IXiEpufDIAKvs8G4Fqk+0SO3gsC5HEWJU=;
	b=ny019XLHmVKjsjB44uHZecOZgFXoc9VLEKTOarfPK8WyOfigW1DGcbSd5ia1vL
	AwTRiaOGhu9sX//+bNc6O5zkUN3FXAmPURKzX5rs6Wsup8x+Gml67fOAJxfoopWn
	66qe1FtwieK5NKL9MTynvACFikVUqqQV0jKScqaFRSwrk=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCX_5FOkHRqLZUyMg--.16349S2;
	Thu, 06 Aug 2026 21:46:54 +0800 (CST)
Date: Thu, 6 Aug 2026 21:46:54 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Verify IOAPIC doesn't set remote_irr on
 failed delivery
Message-ID: <anSQTobr7UThcimc@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anSOdijwS6LBbfYJ@192.168.1.215>
X-CM-TRANSID:_____wCX_5FOkHRqLZUyMg--.16349S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryfJw4rKw4fAFWftr1DZFb_yoWrAry8p3
	ykCasY9r4rGF1xKF1fJF1qgFy5CFZrtayrCw18Wry8tryrJr97ZFs2vFW8Zas0gw48Kwn3
	Z3WfX345uw4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhMa8UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+Q7u4Wp0kE7k4wAA3-

From: Hao Zhang <zhanghao1@kylinos.cn>

Add a regression test for level-triggered I/O APIC interrupt delivery
when no local APIC can accept the interrupt.

remote_irr tracks that a level-triggered interrupt has been accepted by a
local APIC and that the I/O APIC must wait for the corresponding EOI before
delivering the interrupt again.  If no local APIC accepts the interrupt,
remote_irr must remain clear, as no EOI will ever be generated.

Configure an I/O APIC redirection entry and inject an I/O APIC-only GSI
before creating any vCPUs.  Verify that KVM_IRQ_LINE_STATUS reports failed
delivery and that KVM_GET_IRQCHIP reports remote_irr clear.

This covers the case where failed delivery returns a negative value and
must not be treated as a successful delivery for remote_irr tracking.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 70 ++++++++++++++++++++++
 2 files changed, 71 insertions(+)
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
index 000000000000..3e1badcc391c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
@@ -0,0 +1,70 @@
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
+	get_ioapic(vm, &irqchip);
+
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.vector = TEST_VECTOR;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.dest_id = NO_SUCH_APIC_ID;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.dest_mode = 0;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.trig_mode = 1;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.mask = 0;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.remote_irr = 0;
+
+	set_ioapic(vm, &irqchip);
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
+int main(void)
+{
+	test_no_remote_irr_for_undelivered_interrupt();
+
+	return 0;
+}
-- 
2.15.0

