Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476081;
	b=jnF+CHPbfcMsiyWZovPvGEWyzdC6gU2msbwGRZpQbzd3Csjq56RgCqC3SO+c0KFIHS60
	 qAmrRKebbf8ylA8JDhnj3mBq3iLfM9feq2L/LDsXZJuWt/LXQXnmDRt3+oLjWpbD7bmwu
	 1SroZKkpgf4jKNlI9Hy/fW3bUGTzNpDwgFU945KYicFW14A64iXhgZbWQN/oRxcuhHhoW
	 /PYhVsqzM1Q2yuMWZn69WPipegNldRn8y94/iTpg5sdJVl1E8JVZVYT5di5sAl6qCJWr+
	 TttZayTuCJmS32wZKs1bpC5vl1ztYs7qIQQs+xaCXg9dU73NU4RMg4OXyXskQEwdlMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476081;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tp9jQ4oelgtpzj/v8bv9wLlxVYP5GdG01f7cnS9ax54=;
	b=bWKHYQXQOVODyTgKo6BcJPVblt3BaxDEzOQXpM/9L1wE38gVO7KiHBu/3g4s9lTmAGtk
	 BDlCoZDznyiEk9XFiP46iBZMAnB5ypzjxwnQuBEzvsrK7vh7xDEcK01JoWWRcfN/ztMvz
	 Hi0+aTztiUZToeUZ/XuWSHBcyCi8eqgG4NOpEFdpXD4xvfNmSvIa7JIcrUAIlMbr7+CEk
	 JiQxfM/qoc8ge51kTEhh6Xay0PZJR/0LlCIwmqWRpUfdSjGjRaN3IyS3EDfypuNAZkdZc
	 mUqwluUhkMJnVGOQmaaW5o17DL2IjQOnV5cBrj4WV/crplX1HZvYuPM9FMBwCnkyrDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rXKVSoFq;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A49606A319;
	Tue, 20 Oct 2026 06:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A49606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rXKVSoFq
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792476075; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tp9jQ4oelgtpzj/v8bv9wLlxVYP5GdG01f7cnS9ax54=;
	b=rXKVSoFqPzcBdwdoeBbbk8g2iuZHrIzS5Jg8DfHbo/N+VGyIdIwZG1F7wQxEaOfV24gW1cN1Vl4PhgnuASN8hYhKeY3UxdkpV8Y4LkeAqre+72JtLJF16d2dyOey/cM7IT2mDHLilz2wFTX7MkgwLTb9BtxBEg4CsedXio1ew8w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xiang.zheng@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XDBuaQ1_1792476072;
Received: from localhost.localdomain(mailfrom:xiang.zheng@linux.alibaba.com fp:SMTPD_---0XDBuaQ1_1792476072 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 14:01:14 +0800
From: Xiang Zheng <xiang.zheng@linux.alibaba.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Shannon Zhao <shannon.zhao@linux.alibaba.com>,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: x86: Add RTC EOI retargeting regression test
Date: Tue, 20 Oct 2026 14:00:53 +0800
Message-ID: <20261020060053.25011-3-xiang.zheng@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020060053.25011-1-xiang.zheng@linux.alibaba.com>
References: <20261020060053.25011-1-xiang.zheng@linux.alibaba.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inject the RTC interrupt (GSI 8) from userspace, let the target vCPU
handle it and write the EOI, then have the guest retarget the RTC to
the other vCPU before the next injection.  Every injection must be
reported as delivered by KVM_IRQ_LINE_STATUS, and each target vCPU must
see its own interrupt count advance, for 64 rounds.

Without the ioapic fix, and with AVIC enabled, the second injection is
reported as coalesced and the test fails; it passes with AVIC disabled
or with the fix applied.

Signed-off-by: Xiang Zheng <xiang.zheng@linux.alibaba.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/rtc_eoi_retarget_test.c | 155 ++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/rtc_eoi_retarget_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f43549a56f0b..7bc2db4c57be 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -140,6 +140,7 @@ TEST_GEN_PROGS_x86 += x86/apic_bus_clock_test
 TEST_GEN_PROGS_x86 += x86/xapic_ipi_test
 TEST_GEN_PROGS_x86 += x86/xapic_state_test
 TEST_GEN_PROGS_x86 += x86/xapic_tpr_test
+TEST_GEN_PROGS_x86 += x86/rtc_eoi_retarget_test
 TEST_GEN_PROGS_x86 += x86/xcr0_cpuid_test
 TEST_GEN_PROGS_x86 += x86/xss_msr_test
 TEST_GEN_PROGS_x86 += x86/debug_regs
diff --git a/tools/testing/selftests/kvm/x86/rtc_eoi_retarget_test.c b/tools/testing/selftests/kvm/x86/rtc_eoi_retarget_test.c
new file mode 100644
index 000000000000..564bc7199c1c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/rtc_eoi_retarget_test.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <unistd.h>
+
+#include "apic.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+#define IOAPIC_GPA		0xfec00000ULL
+#define IOAPIC_REGSEL		0x00
+#define IOAPIC_WINDOW		0x10
+#define IOAPIC_REDIR_LO(pin)	(0x10 + 2 * (pin))
+#define IOAPIC_REDIR_HI(pin)	(0x11 + 2 * (pin))
+
+#define RTC_GSI			8
+#define RTC_VECTOR		0xd1
+#define NR_VCPUS		2
+#define NR_ROUNDS		64
+
+static u32 irq_count[NR_VCPUS];
+
+static void pio_outb(u16 port, u8 val)
+{
+	asm volatile("outb %0, %1" : : "a"(val), "Nd"(port));
+}
+
+static void ioapic_write(u32 reg, u32 val)
+{
+	WRITE_ONCE(*(u32 *)(IOAPIC_GPA + IOAPIC_REGSEL), reg);
+	WRITE_ONCE(*(u32 *)(IOAPIC_GPA + IOAPIC_WINDOW), val);
+}
+
+static void rtc_handler(struct ex_regs *regs)
+{
+	u32 me = GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID));
+
+	WRITE_ONCE(irq_count[me], READ_ONCE(irq_count[me]) + 1);
+	xapic_write_reg(APIC_EOI, 0);
+}
+
+static void guest_code(void)
+{
+	u32 me, expected = 0;
+
+	xapic_enable();
+	me = GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID));
+
+	if (!me) {
+		/* Mask the PIC so only the IOAPIC contributes to IRQ status. */
+		pio_outb(0x21, 0xff);
+		pio_outb(0xa1, 0xff);
+		ioapic_write(IOAPIC_REDIR_HI(RTC_GSI), 0);
+		ioapic_write(IOAPIC_REDIR_LO(RTC_GSI), RTC_VECTOR);
+	}
+	sti();
+	GUEST_SYNC1(0);
+
+	for (;;) {
+		expected++;
+		while (READ_ONCE(irq_count[me]) < expected)
+			cpu_relax();
+		/* Change the route before the next lazy EOI update. */
+		ioapic_write(IOAPIC_REDIR_HI(RTC_GSI), (me ^ 1) << 24);
+		GUEST_SYNC1(READ_ONCE(irq_count[me]));
+	}
+}
+
+static void run_until_sync(struct kvm_vcpu *vcpu, u64 expected)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		TEST_ASSERT(uc.args[0] == expected,
+			    "vCPU%u: got %lu RTC interrupts, expected %lu",
+			    vcpu->id, (unsigned long)uc.args[0],
+			    (unsigned long)expected);
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+	}
+}
+
+static int inject_rtc(struct kvm_vm *vm)
+{
+	struct kvm_irq_level irq = { .irq = RTC_GSI, .level = 1 };
+	int status;
+
+	vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq);
+	status = irq.status;
+
+	/*
+	 * Deassert (level 0) to clear the IOAPIC IRR bit.  An edge assert
+	 * leaves IRR set, so without this the next round would be reported
+	 * as already pending, not delivered.  .irq and .status share a union.
+	 */
+	irq.irq = RTC_GSI;
+	irq.level = 0;
+	vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq);
+
+	return status;
+}
+
+int main(void)
+{
+	struct kvm_vcpu *vcpus[NR_VCPUS];
+	struct kvm_irqchip chip = { .chip_id = KVM_IRQCHIP_IOAPIC };
+	struct kvm_vm *vm;
+	int round, status, r;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_IRQCHIP));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_IRQ_INJECT_STATUS));
+
+	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
+	vm_install_exception_handler(vm, RTC_VECTOR, rtc_handler);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	virt_pg_map(vm, IOAPIC_GPA, IOAPIC_GPA);
+
+	/*
+	 * Require a full in-kernel IOAPIC; vm_create_irqchip() silently falls
+	 * back to a split irqchip when KVM_CREATE_IRQCHIP is unavailable.
+	 */
+	r = __vm_ioctl(vm, KVM_GET_IRQCHIP, &chip);
+	__TEST_REQUIRE(!r || (errno != ENOTTY && errno != ENXIO),
+		       "Full in-kernel IRQCHIP is required");
+	TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_GET_IRQCHIP, r, vm);
+
+	alarm(30);
+	/* vCPU0 programs the IOAPIC, so it must run first. */
+	run_until_sync(vcpus[0], 0);
+	run_until_sync(vcpus[1], 0);
+
+	for (round = 0; round < NR_ROUNDS; round++) {
+		int target = round & 1;
+
+		status = inject_rtc(vm);
+		TEST_ASSERT(status == 1,
+			    "round %d: RTC to vCPU%d not delivered, status %d%s",
+			    round, target, status,
+			    status == 0 ? " (coalesced)" : "");
+		run_until_sync(vcpus[target], round / 2 + 1);
+	}
+	alarm(0);
+
+	printf("PASS: %d RTC injections delivered across target changes\n",
+	       NR_ROUNDS);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1 (Apple Git-155)

