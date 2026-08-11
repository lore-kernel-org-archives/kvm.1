Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46513379C4A
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434009; cv=none; b=pdQC52kTpvOViq7OUICwlOdnfV8lMbq0zlnMmYTzrOfZToTIB9Gh99s7jD//VJg2xiOREhm09BLZZVDpRDVGUAuDi1CPtInY2bpDXjxf/5ZOJjhG4g75OKYGcoGBckqw04MNlMIUdbfLFiR3MweP3EHe29/nAyT644h8XyiE9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434009; c=relaxed/simple;
	bh=plaso9psqK0+k1Ga3BN7NauBow/911i3F/L2DYtOlAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AS1aFC9oeJNE6h2D0cY8YRWxy1G2lDyqXvTtesSoQj153Oxc9rcztoxxRWytExDiwlFZVsjXycYNsGqFNyLSMxdCxUsqD8rn3jcFBOajmaFdcDnLU8hxGv8EBNPz6sTiFpxQUSxnX7N6iWCYa4N6tsmDcebrbWjyMUp31WRnFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jJ72Vcvu; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jJ72Vcvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=rhmk74NoGX0rjcG+7snUa3STz7lzqxTtPbndz82Ntww=;
	b=jJ72VcvuZ0ebXTEXZSjaw3nu0lzCaJkOs9qsQI632KFt0IKoVtrJ+t7OGZE56l
	xDxkBBblmB4ygii887zslL+jwpjatWovGxJj39BchMn+8P9dT18g5HdsWZYJCZVZ
	HeAoNjeS89nYUN6LPJkdiQvN1Fj9v+sOThhOIop1ogEw0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnz3y40XpqRVp0NQ--.25850S2;
	Tue, 11 Aug 2026 15:39:36 +0800 (CST)
Date: Tue, 11 Aug 2026 15:39:36 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: [PATCH v4 2/4] KVM: selftests: Verify failed IOAPIC delivery
 preserves state
Message-ID: <anrRuBOSoc5rskqC@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anrQfoE8HRvsaao_@192.168.1.215>
X-CM-TRANSID:_____wDnz3y40XpqRVp0NQ--.25850S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw47Xry8JFWDtFyUtrWDArb_yoWrAr4Dp3
	4kC340vr4rGFyxKF1rJF1DWr15uFyqkay8Cw10gry8JFyrJ397AFs2qFW8Za4Ygw48Kws3
	Za4rX345uw4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEdb1sUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3Rjbzmp60bjMcAAA3V

From: Hao Zhang <zhanghao1@kylinos.cn>

Add an x86 selftest for the in-kernel I/O APIC state that is exposed
through KVM_GET_IRQCHIP.

Create a VM with an in-kernel irqchip and no vCPUs, route an unmasked
level-triggered I/O APIC pin to a non-existent APIC ID, and verify that
failed delivery does not set remote_irr.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 92 ++++++++++++++++++++++
 2 files changed, 93 insertions(+)
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
index 000000000000..be5237f34ad2
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
@@ -0,0 +1,92 @@
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
+static void set_ioapic_entry(struct kvm_vm *vm, bool level_triggered,
+			     u32 dest_id)
+{
+	struct kvm_irqchip irqchip;
+
+	get_ioapic(vm, &irqchip);
+
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.vector =
+		TEST_VECTOR;
+	irqchip.chip.ioapic.redirtbl[TEST_IOAPIC_PIN].fields.dest_id =
+		dest_id;
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
+static int kvm_irq_line_status(struct kvm_vm *vm, int level)
+{
+	struct kvm_irq_level irq = {
+		.irq = TEST_IOAPIC_PIN,
+		.level = level,
+	};
+
+	vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq);
+	return irq.status;
+}
+
+static void test_no_remote_irr_for_undelivered_level_interrupt(void)
+{
+	struct kvm_irqchip irqchip;
+	struct kvm_vm *vm;
+	int status;
+
+	vm = vm_create_barebones();
+	vm_create_irqchip(vm);
+
+	set_ioapic_entry(vm, true, NO_SUCH_APIC_ID);
+
+	status = kvm_irq_line_status(vm, 1);
+	TEST_ASSERT(status == -1,
+		    "Expected failed interrupt delivery, got %d", status);
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
+	test_no_remote_irr_for_undelivered_level_interrupt();
+
+	return 0;
+}
-- 
2.15.0

