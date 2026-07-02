Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E1390CB4
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976009; cv=none; b=HABQLsLULXL1mog63juO6x26vTTuDbg+FJykrDV/12sLqBBMH3WrvWgNH2fyHo9EY111vwvVEhR86gLezR5HUZeNiEmxpN9InK4doZ24sfzVV6CMN2+F6yLR9QXtqoyZrTlAIc/8q/XiXKbI106khSiILE/3GyzC8/vPZHFC5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976009; c=relaxed/simple;
	bh=ZK9/EOTISoIAP+uURRMkKrJVl7AQMXR9TrCd+39fsUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TatOLrytbUoOjxPN5318gQqR4cBgNHYgiPNrXEusbzSpN1cZAedoaK01o/ClALYBxQf27f9WtR0pf6LgkUttTFc5O00Ywkdox0VClVdex7ozcf59XXIumkIfKtCCTpZ8ClhigRD1BBMdT7gNz7bJMjhd/Q2rP8Ti19GqjqMIRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=EZc1Hr+j; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EZc1Hr+j"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVg3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVg3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975049;
	bh=Xt0i1MTfSh4zsAWVZ1Kvw1n0DKQnlQtHohgCzZhcEw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZc1Hr+jtfMpK63GEOuPEDvMYXScG7kFZPoAYoEbYTJvXM3pRMYWs8ycfGEnRoa5I
	 WOiQl6TuaMSJKSyEpR2bS24yJqJyZ0d+4bgjJlvEQxlm2RE6UdF8US/7JnjT/aACCP
	 U6y0yRXoz4sUibxPG2b9OORAW17lB195opfFX40PpeBt3ert4DI/DXiKRNcdTU9HV8
	 j/bOxnCxZs7JVmox42/t5yc+CaKK0hJCymC35rwkJEEbDfT6A9Q0DICAI9ETQFsV8a
	 AhJ5GnksGVVTt++yOFsTmnBcCzJ9Gs1YhMJt2oobfU/23vLDFKNgaiVPNgUy6SZXsu
	 lflEAHqmzyF+A==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 07/11] x86/vmx: Validate the PAT MSR handling during VM-Exit
Date: Wed,  1 Jul 2026 23:50:35 -0700
Message-ID: <20260702065039.3434909-8-xin@zytor.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702065039.3434909-1-xin@zytor.com>
References: <20260702065039.3434909-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that the PAT MSR is correctly handled during VM-Exit.

The following behaviors are verified:

  1. The PAT MSR is saved to VMCS during VM-Exit iff the "Save PAT"
     VM-Exit control is set.

  2. The PAT MSR is not saved to VMCS during VM-Exit iff the "Save PAT"
     VM-Exit control is cleared.

  3. The PAT MSR is loaded with the value from VMCS host PAT MSR field
     iff the "Load PAT" VM-Exit control is set.

  4. The PAT MSR is retained iff the "Load PAT" VM-Exit control is
     cleared.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx_tests.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index daa1504c..460ed76e 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -12320,6 +12320,124 @@ test_again:
 	test_set_guest_finished();
 }
 
+static void vmx_exit_control_pat_test_guest(void)
+{
+	wrmsr(MSR_IA32_CR_PAT, 0x0506);
+
+	vmcall();
+}
+
+static void vmx_exit_control_pat_test(void)
+{
+	bool entry_not_load_pat_tested = false;
+	u64 host_pat = rdmsr(MSR_IA32_CR_PAT);
+
+	if (!(ctrl_exit_rev.clr & EXI_SAVE_PAT)) {
+		report_skip("Save PAT exit control is not available");
+		return;
+	}
+
+	if (!(ctrl_exit_rev.clr & EXI_LOAD_PAT)) {
+		report_skip("Load PAT exit control is not available");
+		return;
+	}
+
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_PAT)) {
+		report_skip("Load PAT entry control is not available");
+		return;
+	}
+
+	/* Allow the guest to read the PAT MSR directly */
+	msr_bmp_init();
+
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_PAT);
+	vmcs_write(HOST_PAT, host_pat);
+
+test_again:
+	/*
+	 * Case 1:
+	 *
+	 * The PAT MSR is not saved to VMCS during VM-Exit if the "Save PAT"
+	 * VM-Exit control is cleared.
+	 *
+	 * The PAT MSR is retained if the "Load PAT" VM-Exit control is cleared.
+	 */
+	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_PAT | EXI_LOAD_PAT);
+	if (entry_not_load_pat_tested)
+		test_override_guest(vmx_exit_control_pat_test_guest);
+	else
+		test_set_guest(vmx_exit_control_pat_test_guest);
+	vmcs_write(GUEST_PAT, 0x0606);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_CR_PAT) == 0x0506, "The PAT MSR is retained at VM Exit");
+	report(vmcs_read(GUEST_PAT) == 0x0606, "VMCS guest PAT is not saved at VM Exit");
+
+	wrmsr(MSR_IA32_CR_PAT, host_pat);
+
+	/*
+	 * Case 2:
+	 *
+	 * The PAT MSR is not saved to VMCS during VM-Exit if the "Save PAT"
+	 * VM-Exit control is cleared.
+	 *
+	 * The PAT MSR is loaded with the value from VMCS host PAT MSR field
+	 * if the "Load PAT" VM-Exit control is set.
+	 */
+	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_PAT);
+	vmcs_set_bits(EXI_CONTROLS, EXI_LOAD_PAT);
+	test_override_guest(vmx_exit_control_pat_test_guest);
+	vmcs_write(GUEST_PAT, 0x0606);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_CR_PAT) == host_pat, "VMCS host PAT is loaded at VM Exit");
+	report(vmcs_read(GUEST_PAT) == 0x0606, "VMCS guest PAT is not saved at VM Exit");
+
+	/*
+	 * Case 3:
+	 *
+	 * The PAT MSR is saved to VMCS during VM-Exit if the "Save PAT" VM-Exit
+	 * control is set.
+	 *
+	 * The PAT MSR is retained if the "Load PAT" VM-Exit control is cleared.
+	 */
+	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_PAT);
+	vmcs_clear_bits(EXI_CONTROLS, EXI_LOAD_PAT);
+	test_override_guest(vmx_exit_control_pat_test_guest);
+	vmcs_write(GUEST_PAT, 0x0606);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_CR_PAT) == 0x0506, "The PAT MSR is retained at VM Exit");
+	report(vmcs_read(GUEST_PAT) == 0x0506, "VMCS guest PAT is saved at VM Exit");
+
+	wrmsr(MSR_IA32_CR_PAT, host_pat);
+
+	/*
+	 * Case 4:
+	 *
+	 * The PAT MSR is saved to VMCS during VM-Exit if the "Save PAT" VM-Exit
+	 * control is set.
+	 *
+	 * The PAT MSR is loaded with the value from VMCS host PAT MSR field if
+	 * the "Load PAT" VM-Exit control is set.
+	 */
+	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_PAT | EXI_LOAD_PAT);
+	test_override_guest(vmx_exit_control_pat_test_guest);
+	vmcs_write(GUEST_PAT, 0x0606);
+
+	enter_guest();
+	report(rdmsr(MSR_IA32_CR_PAT) == host_pat, "VMCS host PAT is loaded at VM Exit");
+	report(vmcs_read(GUEST_PAT) == 0x0506, "VMCS guest PAT is saved at VM Exit");
+
+	if (!entry_not_load_pat_tested) {
+		entry_not_load_pat_tested = true;
+		vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_PAT);
+		goto test_again;
+	}
+
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12440,5 +12558,6 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_cet_test),
 	TEST(vmx_exit_control_fred_test),
 	TEST(vmx_exit_control_efer_test),
+	TEST(vmx_exit_control_pat_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0

