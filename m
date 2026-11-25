Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588207;
	b=xb+dG0iYfOXBWC139JltQytsyS9ykkipA4/dOPsXURaxZKU4sKaBeTp3RNkrKbn3nwlV
	 JOgjgcSNtkHxGQ+Tpib+xxywiZfYB2xO0vHJx2bDQ55A/kB2Bff4Feyi7oGBV83iHg2fp
	 X5UECMwXvrFY4K+xJ96xGi99KafFgJe6P1+6+hwUBDY8acr2IOY8xAnwrpn3ZEyrR/HXH
	 atJnJA1sD/TC+y+G0XfHfkBkZwUOyU8RJku7SPE5J8Ip+i5HboFsn8BZwyqlTJt/tMab6
	 DRyX/XB3hrSYiHvgS2pbo9aYxecW0Ully4EAFShJlYEblasuuuMP5S7258DuBYC0RIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EI9iN8WP/z32qsZ9Htvf2ISMotr31c9Hgi0M9PXkKHw=;
	b=UcWLvrTWXHpIVGybaDP7DEnUFSgRYZNGQCKsM1RjDE1e0vEPTPdFaT4PtioPU823BemU
	 Dbq7Wxhi+9rtlA/bTV0u6O47kwxrNLYM3tO7UWi2r4ujLPY4yY+d/0mSC5XlNivzkt1Wh
	 zRpW8WxZtsUPLS4ekDTDdWCc/tQH4z6/bC/xDeNTe/3XU1aztnXKwUswTRicldjGioiZQ
	 hFXbFW/ZDtIbAPo3Wwtht4prKnB+ivNV3MCHNzHpm0qxn1ezsCKohzoNUKRk2NosD+73P
	 a3hWSF7W8XBMU14dEpdOw8RYF3/QoGEDJD967jJUxLVeLP6/2eSvz8RF41CYWx+iX9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pWmDmt02;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D4606A697
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 678D4606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pWmDmt02
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a9f9473029so4068188b3a.2
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795588207; x=1796193007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EI9iN8WP/z32qsZ9Htvf2ISMotr31c9Hgi0M9PXkKHw=;
        b=pWmDmt02UcXRawX12m7sNm98B7L7cvaUgr8R27ivTAd34BENBhhAAbQ5lqJMlYCWOe
         o47/jjZHZGeyFOkzFQm7aiHGyZp4MgrvZICXWixqVXUhRD9kFYtF4HUQx9KveRuNUjHQ
         sfRHTLqtOq+2h3STAdCTYIO1tU1vP7w/3upmGGn2/T+FeX5qODwL6cEzg2eRaSqTUsq6
         ViGEZgAzrMcSIYi6rWJugghAu1LZwbpP98DEaww/+JXSY4izHhhcl16U1dVWQinfV4AZ
         pbvssHog+1ZBARCN+SRhfNepTcaisnvc2ra4fHU7caLg8dYdUs2CGeW56VJp7gPIdtgk
         74uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795588207; x=1796193007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EI9iN8WP/z32qsZ9Htvf2ISMotr31c9Hgi0M9PXkKHw=;
        b=XxwhuKjl3HYyYqWRqGRLhTrNGCdyzbGbTDE4SHMeENepDSVHvtdM3QZpFH97rAF87t
         QhJTmLWDCL+F9D6EqO/lZ0Mn1iowXcFi0oQkGwqgYENj941NMzNZMAT81QwAOoHAqhUb
         uvpN7I9rQr1VaKTQwCHSmpvxnt05a91sxVf96WT23vbpuzX1unX7/U5kfKRgyMvXNTP1
         1LiwwIu3i1f3W7JCsvTwpkTJMfFeeYDTMWl85H4Myndb7y67KRYLp4l/jkWCuVHnoil5
         NFrfC2LGE1PAY+tAK+8iukIbxzuWb63eXTRe7s69dd4OPsuShlJ9lfSIEwJuXnYd5I9k
         iDPg==
X-Gm-Message-State: APuU4Z+hDw7rfomwNYcAwtXmg3VJtoy+JMmBCHYIIzcX1Fub+fsJUr0G
	GGwUzvm8+aE1qfLZmhVnnxpFw3pa7coAQQ+N4NTFjg+8FuILue5JyDpeMNcs6Vat
X-Gm-Gg: AZFdTZfUNb/I9AfS34L+ngdUS5noy9hOOT6odboqkY+uEttKNt3gQTzGVH4sIIPvuZI
	r5bPT9x+2DpScYLuZgGtEf9qaT4ynwkkXvEwoCwHaZyEDGcyMpNTdL3vcA0SniZOy/tqLoZ0exP
	7szPAg7i+yIJ/KiHF44t0F61UFuVnFHf5fAuW+sXe3knXpNWWNMKjno8F1hz+CpIuDwRD1+4MZS
	RgPI/pjHHvhU8adxZtO5/kaBI07n1s29xnWiyy6pFxeuI644v/RlCz3nXyz3kahpds25lTiNBEs
	OKP+d2fwGwPviAYaZHja28M0ki2ZLgdejgMh/p5FE93EdckOB7xCS5JepeYpJIxT/Lbh99aYjcs
	H8y8XmJkXxrPdKGzBpidUUGty8t6HH31b7Tpxa32zyJdRSS2Tg+5p1mTq+6w0q0He95JLfbNn7+
	b54x2EJ7m+n7zNOuHabcnQqWP3lh96ZBBPPMegNhoxIh7hDGZk/U6g8MYSMAfNeZI22ykiiQ3Dx
	KZ2GMjOR2srxoPRE/eUc56yIWh3hUv6n3Qvo3HcBFAcvdVczORFksCCS43JGsM+d8FIPde+nC1+
	F9cp0mm1wZyvbQTKSqVBZcZQGtfL3j0BTx5vqHZEhk61lmqZTihzsHKA9Yq2twwvpKOMi86c
X-Received: by 2002:a05:6a00:1c85:b0:8a0:76ea:36e1 with SMTP id d2e1a72fcca58-8c8794b875bmr14853645b3a.7.1795588206720;
        Tue, 24 Nov 2026 22:30:06 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b278f0sm8355165b3a.51.2026.11.24.22.30.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 22:30:06 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Test that an NMI-window single-step preserves the guest's RF
Date: Wed, 25 Nov 2026 14:30:00 +0800
Message-ID: <20261125063000.92971-2-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261125063000.92971-1-flyingpeng@tencent.com>
References: <20261125063000.92971-1-flyingpeng@tencent.com>
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

Add a test for the case where KVM single-steps the IRET of an NMI
handler to find out when NMIs are unblocked (SVM without vNMI) and that
IRET returns to an instruction breakpoint with RF set in the popped
RFLAGS.

The guest arms an instruction breakpoint, sends itself an NMI that is
delivered at the breakpoint address, and from the NMI handler sends a
second NMI, which stays pending, and sets RF in the interrupt frame.
The second NMI is delivered once the first handler's IRET completes,
and when it returns the breakpoint must not fire.

Without the preceding fix the test fails on AMD with kvm_amd.vnmi=0:

  x86/nmi_iret_rf_test.c:80: READ_ONCE(db_count) == 0
  0x1 != 0x0 (READ_ONCE(db_count) != 0)

It passes with vNMI, and on Intel, where KVM doesn't single-step to
open the NMI window.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/nmi_iret_rf_test.c      | 109 ++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nmi_iret_rf_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..d7df9df89de2 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -147,6 +147,7 @@ TEST_GEN_PROGS_x86 += x86/xapic_tpr_test
 TEST_GEN_PROGS_x86 += x86/xcr0_cpuid_test
 TEST_GEN_PROGS_x86 += x86/xss_msr_test
 TEST_GEN_PROGS_x86 += x86/debug_regs
+TEST_GEN_PROGS_x86 += x86/nmi_iret_rf_test
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
diff --git a/tools/testing/selftests/kvm/x86/nmi_iret_rf_test.c b/tools/testing/selftests/kvm/x86/nmi_iret_rf_test.c
new file mode 100644
index 000000000000..9d2ced788329
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nmi_iret_rf_test.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Verify that KVM doesn't clobber RFLAGS.RF loaded by the guest's IRET when
+ * KVM single-steps the IRET of an NMI handler to open the NMI window.
+ *
+ * Without vNMI, SVM detects the end of NMI blocking by intercepting IRET and
+ * then single-stepping it.  If that IRET returns to an instruction that has
+ * an enabled instruction breakpoint with RF set in the popped RFLAGS (which is
+ * what an OS does when it resumes after handling the breakpoint), the guest
+ * must not see a second #DB on that instruction.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "apic.h"
+
+#define DR7_L0		BIT(0)
+#define DR7_GE		BIT(9)
+#define DR7_FIXED_1	BIT(10)
+
+extern char bp_target[];
+
+static int nmi_count;
+static int db_count;
+
+static u64 self_nmi_icr(void)
+{
+	return ((u64)x2apic_read_reg(APIC_ID) << 32) | APIC_DEST_PHYSICAL | APIC_DM_NMI;
+}
+
+static void send_self_nmi(void)
+{
+	x2apic_write_reg(APIC_ICR, self_nmi_icr());
+}
+
+static void guest_nmi_handler(struct ex_regs *regs)
+{
+	if (nmi_count++)
+		return;
+
+	GUEST_ASSERT_EQ(regs->rip, (u64)bp_target);
+
+	/*
+	 * NMIs are blocked, so this one stays pending until KVM sees the IRET
+	 * below complete.  Return to bp_target with RF set, as if resuming
+	 * after the instruction breakpoint was handled.
+	 */
+	send_self_nmi();
+	regs->rflags |= X86_EFLAGS_RF;
+}
+
+static void guest_db_handler(struct ex_regs *regs)
+{
+	db_count++;
+	regs->rflags |= X86_EFLAGS_RF;
+}
+
+static void guest_code(void)
+{
+	u64 icr;
+
+	x2apic_enable();
+
+	asm volatile("mov %0, %%dr0" : : "r"(bp_target));
+	asm volatile("mov %0, %%dr7" : : "r"((u64)(DR7_FIXED_1 | DR7_GE | DR7_L0)));
+
+	/*
+	 * Send the NMI with a bare WRMSR so that it is delivered with RIP
+	 * pointing at bp_target, i.e. before the breakpoint is checked.
+	 */
+	icr = self_nmi_icr();
+	asm volatile("wrmsr\n\t"
+		     "bp_target: nop"
+		     : : "c"(APIC_BASE_MSR + (APIC_ICR >> 4)),
+			 "a"((u32)icr), "d"((u32)(icr >> 32)) : "memory");
+
+	asm volatile("mov %0, %%dr7" : : "r"((u64)DR7_FIXED_1));
+
+	GUEST_ASSERT_EQ(READ_ONCE(nmi_count), 2);
+	GUEST_ASSERT_EQ(READ_ONCE(db_count), 0);
+	GUEST_DONE();
+}
+
+int main(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
+	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.7

