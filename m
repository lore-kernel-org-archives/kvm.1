Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9A38B7DC
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434214; cv=none; b=oulTOGVzHOZRM2LWdNaOy5cgfsfzr40i3lDlJiw/Ok9DQw4lEEEHXXVegz1bHvTmU/2QnS4R7s/5br5OP+ppJLV1tpddkXqJqumeYbkODSC3M7DSKzQ1NdYe01cW4drFVjUyZ8imRdslzLk8Jb0QgecJ/ZsGiDmEP5iAg2CSiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434214; c=relaxed/simple;
	bh=hNaNDmCXj5vtkR5mpAE3lQQKLMAIUcdzGrhDyknTJxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jkwV0AB6wWxfanSVQG+6uNefLsLj8oUWF52974L2J0weSS8snhSx+vt/+NBQ0nE7X66BTEKw8HYI1Xci8iEGglc5NjdI5PIcC7edv7U0DcJWwBbI4TSgosCg+TZNdQBar1upRyXy5yhZW9WAzTrqUQHp6zfFi3BnUiocWaOqjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XCNGdjqT; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XCNGdjqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=uGSF8H5xI13XTLHiHTW9JBqKloTrw5z8QkY0nLFOYSA=;
	b=XCNGdjqT5IpvgadYoTs60F2fzZejl5HbyKviOPxvHI9EkS97/6QR2ygUGYZrfd
	DQVB2zYSms64/fNgRpvKNeE3TGd2rtgraW4Wmu5kpRwhWbxh+ZTxzzeRJjZVfg3G
	q9WxKBDRQhrnLtaY+O5rHfYLp1Iizg2kENDEK32KzzVyQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBn7syN0npqf_qcPA--.42780S2;
	Tue, 11 Aug 2026 15:43:09 +0800 (CST)
Date: Tue, 11 Aug 2026 15:43:09 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: [PATCH v4 4/4] KVM: x86: ioapic: Clear irr_delivered on
 level-triggered RTE
Message-ID: <anrSjerPIvO4Ww-T@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anrQfoE8HRvsaao_@192.168.1.215>
X-CM-TRANSID:_____wBn7syN0npqf_qcPA--.42780S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr4xWFWUXF1kJF1Uur47XFb_yoW7CF4fpa
	ykCFZ0qrs5J3WfGa4kJw4vgFy3u3Z5CrW8A34Du3y5t3W5X3s7Zr4kGrW8JFyrCrW8Xa1a
	va4Yy3W5uF4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEveHAUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+Q4RBGp60o756QAA3+

From: Hao Zhang <zhanghao1@kylinos.cn>

irr_delivered hides delivered edge interrupts from KVM_GET_IRQCHIP.
The interrupt remains in IRR until the guest deasserts the line.

The guest can reprogram an IOAPIC RTE from edge to level via MMIO.
If an edge interrupt was delivered before the trigger mode change, a
stale irr_delivered bit can incorrectly mask a subsequent pending level
interrupt from KVM_GET_IRQCHIP.

That can cause userspace to migrate the VM without a pending level
interrupt that is still present in KVM's in-kernel IOAPIC.

Clear irr_delivered when the RTE is configured for level-triggered
interrupts, and add a regression test that reprograms the IOAPIC via
guest MMIO to verify that the pending IRR remains visible.

Fixes: 5bda6eed2e36 ("KVM: ioapic: Record edge-triggered interrupts delivery status")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/ioapic.c                              | 11 +++-
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 67 +++++++++++++++++++---
 2 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 676effd674f9..81db025d2ac9 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -377,8 +377,17 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 		 * as edge-triggered. This behavior is used to simulate an
 		 * explicit EOI on IOAPICs that don't have the EOI register.
 		 */
-		if (e->fields.trig_mode == IOAPIC_EDGE_TRIG)
+		if (e->fields.trig_mode == IOAPIC_EDGE_TRIG) {
 			e->fields.remote_irr = 0;
+		} else {
+			/*
+			 * irr_delivered tracks edge-triggered interrupts that
+			 * have already been delivered.  Clear stale edge-triggered
+			 * delivery state when the entry is configured for
+			 * level-triggered interrupts.
+			 */
+			ioapic->irr_delivered &= ~(1 << index);
+		}
 
 		mask_after = e->fields.mask;
 		if (mask_before != mask_after)
diff --git a/tools/testing/selftests/kvm/x86/ioapic_state_test.c b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
index da0276a1542f..f024f4f01571 100644
--- a/tools/testing/selftests/kvm/x86/ioapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
@@ -7,12 +7,18 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "test_util.h"
+#include "ucall_common.h"
 
 #define TEST_IOAPIC_PIN		16
 #define TEST_VECTOR		0x50
 #define NO_SUCH_APIC_ID		0xfe
 #define TEST_IOAPIC_EDGE_TRIG	0
 #define TEST_IOAPIC_LEVEL_TRIG	1
+#define IOAPIC_DEFAULT_GPA	0xfec00000ULL
+#define IOAPIC_REG_SELECT	0x00
+#define IOAPIC_REG_WINDOW	0x10
+#define IOAPIC_RTE_LOW(pin)	(0x10 + 2 * (pin))
+#define IOAPIC_RTE_TRIG_MODE	BIT(15)
 
 static void get_ioapic(struct kvm_vm *vm, struct kvm_irqchip *irqchip)
 {
@@ -53,6 +59,19 @@ static void set_ioapic_entry(struct kvm_vm *vm, bool level_triggered,
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
@@ -98,19 +117,12 @@ static void test_no_remote_irr_for_undelivered_level_interrupt(void)
 
 static void test_duplicate_edge_interrupt_preserves_delivery_state(void)
 {
-	struct kvm_lapic_state lapic;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
-	u64 apicbase;
 	int status;
 
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
-	apicbase = vcpu_get_msr(vcpu, MSR_IA32_APICBASE);
-	vcpu_set_msr(vcpu, MSR_IA32_APICBASE,
-		     apicbase | MSR_IA32_APICBASE_ENABLE);
-	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
-	*(u32 *)(lapic.regs + APIC_SPIV) |= APIC_SPIV_APIC_ENABLED;
-	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &lapic);
+	enable_lapic(vcpu);
 
 	set_ioapic_entry(vm, false, vcpu->id);
 
@@ -130,10 +142,49 @@ static void test_duplicate_edge_interrupt_preserves_delivery_state(void)
 	kvm_vm_free(vm);
 }
 
+static void guest_switch_ioapic_pin_to_level(void)
+{
+	u32 *ioapic = (u32 *)IOAPIC_DEFAULT_GPA;
+
+	WRITE_ONCE(ioapic[IOAPIC_REG_SELECT / sizeof(u32)],
+		   IOAPIC_RTE_LOW(TEST_IOAPIC_PIN));
+	WRITE_ONCE(ioapic[IOAPIC_REG_WINDOW / sizeof(u32)],
+		   TEST_VECTOR | IOAPIC_RTE_TRIG_MODE);
+
+	GUEST_DONE();
+}
+
+static void test_edge_to_level_clears_delivery_state(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int status;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_switch_ioapic_pin_to_level);
+	enable_lapic(vcpu);
+	virt_map(vm, IOAPIC_DEFAULT_GPA, IOAPIC_DEFAULT_GPA, 1);
+
+	set_ioapic_entry(vm, false, vcpu->id);
+
+	status = kvm_irq_line_status(vm, 1);
+	TEST_ASSERT(status > 0,
+		    "Expected edge interrupt delivery, got %d", status);
+
+	assert_ioapic_pin_irr(vm, false);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	assert_ioapic_pin_irr(vm, true);
+
+	kvm_vm_free(vm);
+}
+
 int main(void)
 {
 	test_no_remote_irr_for_undelivered_level_interrupt();
 	test_duplicate_edge_interrupt_preserves_delivery_state();
+	test_edge_to_level_clears_delivery_state();
 
 	return 0;
 }
-- 
2.15.0

