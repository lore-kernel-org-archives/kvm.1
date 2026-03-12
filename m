Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D1401A2A
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345802; cv=none; b=uL2bETcFj8/M1UOw9BpvIdUriNOx3kLUkFAUT7GLgVylvGyhPhD5kN9JT0e87sss0cCHAj0X5xF8H0fhZ1/lzibPT+rvl8nnmBLPClszRXQoLGekH2mlxWMrXJrDohHqjXK20SA8+HiNsIafvXP2F2Ojq5FdFJ8x3Qlumc0vjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345802; c=relaxed/simple;
	bh=wTnYGwbdX/lSveAS+UZo2huZhKEfV0uR+AHAU9dV7lU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SXpVj8GrSuxuO5+xLbOKnEiyHfhXc7RBrUktjn+elXtoSZ+kghY795mbgihDZmhkkhKbjdbnegZOYaF25QiLplCIucCNF9O7Ffqo19MiA+OwsX9E1U1AUlWMwo8o0Oh0JIM9gdaoFBB3drmNZbbqZxC16M6AmI5U8/QoeyVvzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmxXof+P; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmxXof+P"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8299c57642cso8243099b3a.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345800; x=1773950600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGW4F9YDdVyAp+Axdo0UMNOT3pNrYGcRHoOGmtNS79k=;
        b=HmxXof+PNowJtjG3v1+vMsN9RMzilt2Dr+kXdEwklnQVaQn0yFzs0H1lkMRm9bSSqb
         ErRMIWaOWmS/VOUsT/QY9ezAMzSiVDmzanEI/A8NwNIKEUIcMt+CatYGVsEehynUfUXr
         EPgXVz1z6YmpJMogixroWPMXx6axzDwn42n+CAjGARM/mWEJJzCUiVTSnXBxr3mw/j4u
         donQHbVbE6xb3C1UXeME+6nzr2c0XiHg+nex2hnn5vcRtOIuaSx0SN7pjqCHmA0XsCss
         Df2gau4Ri2r+BWWbz67p8cDc2iBTyJKoSabwOjU4LftimmDIKMqqzkLEubGTb+0XJjsy
         9cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345800; x=1773950600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGW4F9YDdVyAp+Axdo0UMNOT3pNrYGcRHoOGmtNS79k=;
        b=si/3Yotp2Sjbfm5JAGZaSP9x64uvck52g05evuzYPk0zG1bo75mwpGw40HpwfQFrn4
         colgZXadc2HMT3/P3q9s5gpohRo1gOUsS5O7JTKNO6E1RNl4NfWh3QDU7HIZ/agY6i0C
         YvxYLqR14+GT/UUCS5jMLMOj8L0yGTSgmasC7UQt1sDIzYbIPS2pt4lM3lMjZTVzFdoV
         RCqj0t64UFrNZ1/33qFrFK9GO/PO6kwAlC9PUKSmGXJ5Yngb5lXJ1YYl853hS+E3vBAp
         WPfQPklZKE31w7jhT7b4/gC95qzWlxDk4EDdGEQR5liiDRyeGebOPxNPk5emaHZoGGAI
         bxVg==
X-Gm-Message-State: AOJu0YwbE7y1nXpo1SpsI2hLABFvyVvPTA/2fozgFGRBVNjIkiOV+0hl
	jNNWAQlchBEx8x5yCLpj8VWmSITJaMKnKkpbm5/PW5u2v7Zpl+WLrGNjUJtIekQJTHst0CEh6aj
	wSujPmC8eZO0JmB8HO2/qhuXKk3PjB56EtHkhgdWW0wiFE5kMGEDzxC/uG+Xjmmy6AZt+P5RaSq
	WmCOHQaSS2Zn1VG9ySRThrPedpQArOCcZiySt/rLQF+0A=
X-Received: from pful12.prod.google.com ([2002:a05:6a00:140c:b0:829:8b09:e941])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1988:b0:829:bd4d:37d7 with SMTP id d2e1a72fcca58-82a19864db3mr524335b3a.24.1773345799220;
 Thu, 12 Mar 2026 13:03:19 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:03:03 +0000
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-6-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 05/10] x86/svm: Add tests for PF exception testing
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

The nVMX tests already has coverage for PF exception testing by running
ac_test_run() in L2. Add a similar test for nSVM to improve test parity
between nSVM and nVMX.

The VMX tests intercept MSR accesses and CPUID by default, hence why
there is special handling for MSR and CPUID VM exits. The svm tests do
not intercept the EFER accesses by default and EFER updates in L2 do not
affect L1, so we do not need to handle MSR exits like the VMX tests.
CPUID should be emulated by KVM so the interception is not required
there either.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 x86/Makefile.common |  2 ++
 x86/svm.h           |  1 +
 x86/svm_tests.c     | 71 +++++++++++++++++++++++++++++++++++++++++++++
 x86/unittests.cfg   | 33 ++++++++++++++++++++-
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/x86/Makefile.common b/x86/Makefile.common
index ef0e09a65b07..31d1ed577712 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -117,6 +117,8 @@ $(TEST_DIR)/access_test.$(bin): $(TEST_DIR)/access.o
 
 $(TEST_DIR)/vmx.$(bin): $(TEST_DIR)/access.o
 
+$(TEST_DIR)/svm.$(bin): $(TEST_DIR)/access.o
+
 $(TEST_DIR)/svm_npt.$(bin): $(TEST_DIR)/svm.o
 
 $(TEST_DIR)/kvmclock_test.$(bin): $(TEST_DIR)/kvmclock.o
diff --git a/x86/svm.h b/x86/svm.h
index 052324c68301..66733570f0e3 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -112,6 +112,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define TLB_CONTROL_DO_NOTHING 0
 #define TLB_CONTROL_FLUSH_ALL_ASID 1
+#define TLB_CONTROL_FLUSH_ASID 3
 
 #define V_TPR_MASK 0x0f
 
diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 8dbc033533c0..a40468693b39 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -13,6 +13,7 @@
 #include "x86/usermode.h"
 #include "vmalloc.h"
 #include "fwcfg.h"
+#include "access.h"
 
 #define SVM_EXIT_MAX_DR_INTERCEPT 0x3f
 
@@ -3943,6 +3944,60 @@ static void svm_apic_passthrough_tpr_threshold_test(void)
 	report(svm_apic_passthrough_tpr_threshold_ipi_isr_fired, "self-IPI fired");
 }
 
+static bool tlb_control_flush;
+
+static void svm_pf_inv_asid_test_prepare(struct svm_test *test)
+{
+	vmcb->control.intercept |= BIT_ULL(INTERCEPT_INVLPG);
+	tlb_control_flush = false;
+}
+
+static void svm_pf_inv_tlb_ctl_test_prepare(struct svm_test *test)
+{
+	vmcb->control.intercept |= BIT_ULL(INTERCEPT_INVLPG);
+	tlb_control_flush = true;
+}
+
+static void svm_pf_exception_test(struct svm_test *test)
+{
+	ac_test_run(PT_LEVEL_PML4, false);
+}
+
+static void svm_pf_exception_forced_emulation_test(struct svm_test *test)
+{
+	ac_test_run(PT_LEVEL_PML4, true);
+}
+
+static bool svm_pf_exception_test_finished(struct svm_test *test)
+{
+	switch (vmcb->control.exit_code) {
+	case SVM_EXIT_VMMCALL:
+		break;
+	case SVM_EXIT_INVLPG:
+		if (tlb_control_flush) {
+			/* Flush L2 TLB by using TLB Control field */
+			vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+		} else {
+			/* Flush L2 TLB by assigning a new ASID. */
+			vmcb->control.asid++;
+		}
+		break;
+	default:
+		report_fail("Unexpected exit to L1, Exit reason: 0x%x",
+			    vmcb->control.exit_code);
+	}
+
+	/* Advance guest RIP to the instruction after exit instruction. */
+	vmcb->save.rip = vmcb->control.next_rip;
+
+	return vmcb->control.exit_code == SVM_EXIT_VMMCALL;
+}
+
+static bool svm_pf_exception_test_check(struct svm_test *test)
+{
+	return vmcb->control.exit_code == SVM_EXIT_VMMCALL;
+}
+
 struct svm_test svm_tests[] = {
 	{ "null", default_supported, default_prepare,
 	  default_prepare_gif_clear, null_test,
@@ -4069,6 +4124,22 @@ struct svm_test svm_tests[] = {
 	  svm_apic_passthrough_thread_test_prepare, default_prepare_gif_clear,
 	  svm_apic_passthrough_guest, svm_apic_passthrough_test_finished,
 	  svm_apic_passthrough_test_check},
+	{ "svm_pf_exception_test", next_rip_supported,
+	  default_prepare, default_prepare_gif_clear,
+	  svm_pf_exception_test, svm_pf_exception_test_finished,
+	  svm_pf_exception_test_check},
+	{ "svm_pf_exception_forced_emulation_test", next_rip_supported,
+	  default_prepare, default_prepare_gif_clear,
+	  svm_pf_exception_forced_emulation_test, svm_pf_exception_test_finished,
+	  svm_pf_exception_test_check},
+	{ "svm_pf_inv_asid_test", next_rip_supported,
+	  svm_pf_inv_asid_test_prepare, default_prepare_gif_clear,
+	  svm_pf_exception_test, svm_pf_exception_test_finished,
+	  svm_pf_exception_test_check},
+	{ "svm_pf_inv_tlb_ctl_test", next_rip_supported,
+	  svm_pf_inv_tlb_ctl_test_prepare, default_prepare_gif_clear,
+	  svm_pf_exception_test, svm_pf_exception_test_finished,
+	  svm_pf_exception_test_check},
 	TEST(svm_apic_passthrough_tpr_threshold_test),
 	TEST(svm_cr4_osxsave_test),
 	TEST(svm_guest_state_test),
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 1a89101a5b2d..65dcf8b6cba8 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -253,7 +253,7 @@ arch = x86_64
 [svm]
 file = svm.flat
 smp = 2
-test_args = "-pause_filter_test -svm_intr_intercept_mix_smi -svm_insn_intercept_test"
+test_args = "-pause_filter_test -svm_intr_intercept_mix_smi -svm_insn_intercept_test -svm_pf_exception_test -svm_pf_exception_forced_emulation_test -svm_pf_inv_asid_test -svm_pf_inv_tlb_ctl_test"
 qemu_params = -cpu max,+svm -m 4g
 arch = x86_64
 groups = svm
@@ -265,6 +265,37 @@ qemu_params = -cpu max,+svm -m 4g
 arch = x86_64
 groups = svm
 
+[svm_pf_inv_asid_test]
+file = svm.flat
+test_args = svm_pf_inv_asid_test
+qemu_params = -cpu max,+svm -m 4g
+arch = x86_64
+groups = svm
+timeout = 240
+
+[svm_pf_inv_tlb_ctl_test]
+file = svm.flat
+test_args = svm_pf_inv_tlb_ctl_test
+qemu_params = -cpu max,+svm -m 4g
+arch = x86_64
+groups = svm
+timeout = 240
+
+[svm_pf_exception_test]
+file = svm.flat
+test_args = svm_pf_exception_test
+qemu_params = -cpu max,+svm -m 4g
+arch = x86_64
+groups = svm
+
+[svm_pf_exception_fep]
+file = svm.flat
+test_args = svm_pf_exception_forced_emulation_test
+qemu_params = -cpu max,+svm -m 4g
+arch = x86_64
+groups = svm
+timeout = 480
+
 [svm_intr_intercept_mix_smi]
 file = svm.flat
 test_args = svm_intr_intercept_mix_smi
-- 
2.53.0.851.ga537e3e6e9-goog

