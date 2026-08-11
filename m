Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC53815D0
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434109; cv=none; b=Z9cbPRLjR98UfZ2Jl5o8+9+uHZPwrDC64eFy8s6m9+A1Fijy2cHMK+uR3aXKOT3Qg9h/NgGT0+4pnhuShC2Mm8e4uyWJfCCzzvOYLP9BdrcSjLajmYoSsiXpPzsyFocAknKnZdkZKk3vcGcDQ7MomxxxhPx8xuB0u2od96oKASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434109; c=relaxed/simple;
	bh=MXJFna7WOXuhsBcURmbqxiW45t0tqtrGnhZI0VqXSlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=emrf+birZiP2Sbb3AKNJZ7me6lfRzJmmUsJaESPRCZVO43gzbpFG5woP5I+55/9SmU4Y+FZfHduZz7LU0lXX8hjM8AJpyspjdP1C+Q1iKq49Ijy/Ehja6ka47+A3Z4Mm1YIfRHlO1BgXdslSwDPV/7XjvG3iL1p8IB4pMVNFvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VoWPfxy/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VoWPfxy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=N3CtHIduiCfm1F1NealDI3MNujbfwOrtNvaganYK7yk=;
	b=VoWPfxy/RrHHTSEnFkwShP1kDTdO2ieAEXCCRlLoOToXfvaLQ7qA7zcHHouA3n
	CxyMHq+I2tvfXGHsjQYRwwbbVw0x+g0DIQ625XfY45a7CTc3/mmXK/28k68iK4Pq
	IMGnZoGsBsMN1El7GQBFNehMNVxJwKXO/Mhs/+RjHtECU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXP5Im0npqhJp0NQ--.3153S2;
	Tue, 11 Aug 2026 15:41:27 +0800 (CST)
Date: Tue, 11 Aug 2026 15:41:26 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: [PATCH v4 3/4] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Message-ID: <anrSJmPCKNe6jaUc@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anrQfoE8HRvsaao_@192.168.1.215>
X-CM-TRANSID:_____wDXP5Im0npqhJp0NQ--.3153S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1xArWxXw17KF13CFy5CFg_yoWrGrW3p3
	yDCFZ0vrs5JF1fJa47Ja1DWrWrur1kGrW8C34Du3y8JF15tr97XFs5JrW8XFW5GrWkX3Wa
	va4rK3W5ua1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRqZXwUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3gf26Wp60ifTVAAA3k

From: Hao Zhang <zhanghao1@kylinos.cn>

For edge-triggered interrupts, ioapic_set_irq() clears irr_delivered
before checking whether the new edge is a duplicate.  A duplicate edge
is then coalesced without being serviced, leaving the interrupt visible
in KVM_GET_IRQCHIP state even though the original interrupt was already
delivered.

Move the state update after the duplicate-edge check so duplicate edges
do not make a delivered interrupt appear pending during VM migration.

Add a selftest to verify that a duplicate edge interrupt does not make
an already-delivered interrupt visible in the saved IRR state.

Fixes: 5bda6eed2e36 ("KVM: ioapic: Record edge-triggered interrupts delivery status")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/ioapic.c                              |  2 +-
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 47 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 24a7cc3b8b7e..676effd674f9 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -230,11 +230,11 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
 	old_irr = ioapic->irr;
 	ioapic->irr |= mask;
 	if (edge) {
-		ioapic->irr_delivered &= ~mask;
 		if (old_irr == ioapic->irr) {
 			ret = 0;
 			goto out;
 		}
+		ioapic->irr_delivered &= ~mask;
 	}
 
 	ret = ioapic_service(ioapic, irq, line_status);
diff --git a/tools/testing/selftests/kvm/x86/ioapic_state_test.c b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
index be5237f34ad2..da0276a1542f 100644
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
@@ -62,6 +64,16 @@ static int kvm_irq_line_status(struct kvm_vm *vm, int level)
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
@@ -84,9 +96,44 @@ static void test_no_remote_irr_for_undelivered_level_interrupt(void)
 	kvm_vm_free(vm);
 }
 
+static void test_duplicate_edge_interrupt_preserves_delivery_state(void)
+{
+	struct kvm_lapic_state lapic;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 apicbase;
+	int status;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	apicbase = vcpu_get_msr(vcpu, MSR_IA32_APICBASE);
+	vcpu_set_msr(vcpu, MSR_IA32_APICBASE,
+		     apicbase | MSR_IA32_APICBASE_ENABLE);
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	*(u32 *)(lapic.regs + APIC_SPIV) |= APIC_SPIV_APIC_ENABLED;
+	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &lapic);
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

