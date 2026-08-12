Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CD2C15A5
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524145; cv=none; b=p17vgsuv6jVVJDc5Pyy8h0naG3ELTAgYhL4MLgOPgL4a+JbCk0/0pIt0EolkNtwXc33wQk0+89dw9wCo14sgiVruJ22KNIVNdDqG/LVSrPiPUAwA0PRQv86//70838kzTLE++cTtbD38XADBgmjstREt/eB+0noWvTiY0K/vd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524145; c=relaxed/simple;
	bh=qf/DbtBw4FyJLmpiU8nGv1jAkqlYO2SJxS3+X3X6ZY4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ic385QcQnuLmePYAA4lde/G1N7C+z4y9TRyGQSO7oHc3oKt7V5fsk1s5H9drWwbgTaVKO+oFSQHAnYCHjwCbt3ch1wGQWVIVhASPf/WTGcp2wXgN0TrrNVDe1JkNaBOhaJxLpikR7l2eljEIAptDwAs47ozxWLMOem72u9uPiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l1uiogkr; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l1uiogkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=r7uc5DYp4idKun4vvs3p0cAUMTtv9Fhcy0QW5HrAaeQ=;
	b=l1uiogkrzFO2muApm1RmiLV0Bghu06/mwDp1syUEKPfls3tpqaNzbmjd65/ULf
	ExNhdoIox6ABmdKLqnH8y7MKmf3l9nTZVw1z+HgQnWG4QA+Wgg1xrQzJnR8cUO4N
	omDgOuGtNySSrBNlxzvEck+9tGfq/PWEbCA+YPvjonAPc=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD395e8MXxq1ecTPQ--.60055S2;
	Wed, 12 Aug 2026 16:41:32 +0800 (CST)
Date: Wed, 12 Aug 2026 16:41:29 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v5 6/6] KVM: selftests: Verify edge-to-level clears IOAPIC
 state
Message-ID: <anwxue_Ek_KwldWy@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anwugm-oU0v1VM-t@192.168.1.215>
X-CM-TRANSID:_____wD395e8MXxq1ecTPQ--.60055S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW7urW7Cw4kKF1xKrWxWFg_yoW5XFW8p3
	yqkF98trs3JF1xK3WxJFs5WFWfu3WkurW8ArZ3Z345J3WrA397XrZ5GrW8trW5JrW8XFZI
	yasYy3Z8uayDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRo5l5UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3hw1KGp8MbxmXgAA38

From: Hao Zhang <zhanghao1@kylinos.cn>

Extend ioapic_state_test to verify that reprogramming an IOAPIC RTE from
edge-triggered to level-triggered via guest MMIO clears stale
edge-triggered delivery state.

Verify that KVM_GET_IRQCHIP still reports the pending IRR bit after the
pin is switched to level-triggered mode.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 .../testing/selftests/kvm/x86/ioapic_state_test.c  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/ioapic_state_test.c b/tools/testing/selftests/kvm/x86/ioapic_state_test.c
index 51f6662d553c..f024f4f01571 100644
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
@@ -136,10 +142,49 @@ static void test_duplicate_edge_interrupt_preserves_delivery_state(void)
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

