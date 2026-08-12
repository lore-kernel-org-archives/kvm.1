Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA035F172
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523888; cv=none; b=bHWpAXBMPg076d+xfN4U9OokXlbsas6hy5kJORmlHzBngTHvwAVAotrF8sN3g9f6VAszBgvXMmhlxaIp2Cj1sdWjSOQEbcvdNS5jrtayxP5haJ0LBeWrIqHFdSKT+fXppgtuvZRXzCJrLfklKUTOkYn5nakqMiEgm64+/63pNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523888; c=relaxed/simple;
	bh=dc0AJgn2r0v5kc7J/h0QeUe1JhkSzNw6Eecc5pbQAdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d53LAPkVdLeWHCquO5kQ6nLFP0r3Euj0vGDFeoEhAMTXElJFbCysRTU4tVo9MKyjzteQ75uEPUpUigSvVq4T9+cfZFCJYqdOncMEB+XhcEUiZyBCVhQdq9XPzT3wI+lyW47nA+rnYBD+p/NENeLSRaTCqaU9PDwW6ToY5vFGhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GCQ5xwMB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GCQ5xwMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3BKyaeqpYSTlDWKjB7TB3f4UFnbfTGLHTVMtViKua70=;
	b=GCQ5xwMBofqdtRmcPnVgINcavwcmLejK7nZLNyGJ7VMqBuoJM+mOGuA9bsh8l3
	AVs+aqDu2h78lh60nVq6BKIw7zkqQSvvhccmmHm/dmY16DvLc1yzti+yXlLe7TJO
	b4elbTcjW7hP7iRcu49JnRXd7QzFMNm3CtDsDKqRDD/Hg=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3RVu8MHxqFzloPQ--.65529S2;
	Wed, 12 Aug 2026 16:37:16 +0800 (CST)
Date: Wed, 12 Aug 2026 16:37:13 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v5 4/6] KVM: selftests: Verify duplicate edge preserves
 IOAPIC state
Message-ID: <anwwuTD-uo28Msmh@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anwugm-oU0v1VM-t@192.168.1.215>
X-CM-TRANSID:_____wB3RVu8MHxqFzloPQ--.65529S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw45tF1rtr43tw47ur1kuFg_yoW5CryDp3
	yDGrZ09r4rJF1fGa4xJF4qgr4rur4kW3yxA3s5u3yrJF15trZrZrs5JrW8XrW5GrW8X3Wa
	va4Sy3Z8ua1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYNtsUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3hz052p8MLxTxQAA3d

From: Hao Zhang <zhanghao1@kylinos.cn>

Extend ioapic_state_test to verify that a coalesced duplicate edge
interrupt does not make an already-delivered interrupt visible in the
IOAPIC IRR state returned by KVM_GET_IRQCHIP.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/ioapic_state_test.c b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
index be5237f34ad2..51f6662d553c 100644
--- a/tools/testing/selftests/kvm/x86/ioapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
@@ -3,7 +3,9 @@
  * Regression tests for in-kernel I/O APIC state.
  */
 
+#include "apic.h"
 #include "kvm_util.h"
+#include "processor.h"
 #include "test_util.h"
 
 #define TEST_IOAPIC_PIN		16
@@ -51,6 +53,19 @@ static void set_ioapic_entry(struct kvm_vm *vm, bool level_triggered,
 	set_ioapic(vm, &irqchip);
 }
 
+static void enable_lapic(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic_state lapic;
+	u64 apicbase;
+
+	apicbase = vcpu_get_msr(vcpu, MSR_IA32_APICBASE);
+	vcpu_set_msr(vcpu, MSR_IA32_APICBASE,
+		     apicbase | MSR_IA32_APICBASE_ENABLE);
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	*(u32 *)(lapic.regs + APIC_SPIV) |= APIC_SPIV_APIC_ENABLED;
+	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &lapic);
+}
+
 static int kvm_irq_line_status(struct kvm_vm *vm, int level)
 {
 	struct kvm_irq_level irq = {
@@ -62,6 +77,16 @@ static int kvm_irq_line_status(struct kvm_vm *vm, int level)
 	return irq.status;
 }
 
+static void assert_ioapic_pin_irr(struct kvm_vm *vm, bool expected)
+{
+	struct kvm_irqchip irqchip;
+
+	get_ioapic(vm, &irqchip);
+	TEST_ASSERT(!!(irqchip.chip.ioapic.irr & (1 << TEST_IOAPIC_PIN)) == expected,
+		    "Expected IOAPIC IRR for pin %u to be %u, got 0x%x",
+		    TEST_IOAPIC_PIN, expected, irqchip.chip.ioapic.irr);
+}
+
 static void test_no_remote_irr_for_undelivered_level_interrupt(void)
 {
 	struct kvm_irqchip irqchip;
@@ -84,9 +109,37 @@ static void test_no_remote_irr_for_undelivered_level_interrupt(void)
 	kvm_vm_free(vm);
 }
 
+static void test_duplicate_edge_interrupt_preserves_delivery_state(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int status;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	enable_lapic(vcpu);
+
+	set_ioapic_entry(vm, false, vcpu->id);
+
+	status = kvm_irq_line_status(vm, 1);
+	TEST_ASSERT(status > 0,
+		    "Expected edge interrupt delivery, got %d", status);
+
+	assert_ioapic_pin_irr(vm, false);
+
+	status = kvm_irq_line_status(vm, 1);
+	TEST_ASSERT(!status,
+		    "Expected duplicate edge interrupt to be coalesced, got %d",
+		    status);
+
+	assert_ioapic_pin_irr(vm, false);
+
+	kvm_vm_free(vm);
+}
+
 int main(void)
 {
 	test_no_remote_irr_for_undelivered_level_interrupt();
+	test_duplicate_edge_interrupt_preserves_delivery_state();
 
 	return 0;
 }
-- 
2.15.0

