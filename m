Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB00387566
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975056; cv=none; b=Hf/VMHKpnVnmo6KCiWwSBkwtihx+QhAySPUZBPUBqQhvjA8DI++JFQ2IFF9lmPbhJlT/9mogeRMrsCiMqH0kzkAgSh6ht/XRLG1wf1rqPJgG651MAUXkS4QmGxW54OKCgEQ1weL2O94uWyysJPaHNUHmxjNjq7wwq0l7XeIU9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975056; c=relaxed/simple;
	bh=WPb0f4pQKckopThfNKVv8RpSkktJaTRklXhlccSFwAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNav7iz17ytv7fbQrd4nDsqO4Z8yYPDJKr1pvjZ4ftnFBqAsSbm3N1M6VW2a6sZfVtMAlIPigipOOWUpbek8uXtJKCgQGMzStncu5+Za/YGHLHpfairHstUeB2sk/MFnfz2CgOqJ/LEzpaWcVyCx6AhNGKaFQwyXRZhNBVKVZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=On/82eSp; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="On/82eSp"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVj3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVj3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975050;
	bh=4y7fjuRem9rT1YlT3CaRGckLC/o5GFl6MBfAEPYfhf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=On/82eSpMxcz3m8DJcgRsCyB/bPtccM7olBd02GfHdxrSQ64gE8YX+AfQrB5dr2lk
	 rIMqqCBb6ziBEYiKz5AHRkzgPPnjMHs7DCo1Q1y1JVo9sYHsKlwp29TUvr3p7kp+v7
	 XiBi0hlBhU9SWy+rDwx8CmeqzYywUiIoWU33OxNStr1JC9ospc7PxIjBBdHxe+V4sd
	 +LBAaRw9DpwTWslosb1hU8FIZVr9Cyx4JrF++h0XimTb+GDo/JXoImLUwh7MgtZu0b
	 kSYZyAh9FXY5Z6K/hW0GiSarzLK0BgFIbWRQZefNjvMtRxywYDg/rVP+e0vxg3u7w/
	 UHb1UpAzD0IIQ==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 10/11] x86/vmx: Validate FRED state checking during VM-Entry
Date: Wed,  1 Jul 2026 23:50:38 -0700
Message-ID: <20260702065039.3434909-11-xin@zytor.com>
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

Add a test to verify that attempting a VM entry with a reserved bit set
in the host FRED_CONFIG MSR correctly triggers a VM-entry failure.

More similar tests can be added later.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx_tests.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index f50d1d21..aafcb465 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -12535,6 +12535,44 @@ static void vmx_exit_control_cet_test(void)
 	test_set_guest_finished();
 }
 
+static void vmx_entry_fred_test_guest(void)
+{
+	vmcall();
+}
+
+static void vmx_entry_fred_test(void)
+{
+	struct vmcs *curr;
+
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_FRED)) {
+		report_skip("Load FRED state entry control is not available");
+		return;
+	}
+
+	/* Allow the guest to read FRED MSRs directly */
+	msr_bmp_init();
+
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_FRED);
+	vmcs_set_bits(EXI_CONTROLS, EXI_ACTIVATE_CTRL1);
+	vmcs_set_bits(EXI_CTRL1, EXI_SAVE_FRED | EXI_LOAD_FRED);
+
+	wrmsr(MSR_IA32_FRED_CONFIG, 0x4000);
+	vmcs_write(HOST_FRED_CONFIG, 0x4000);
+	vmcs_write(GUEST_FRED_CONFIG, 0x400000);
+	test_set_guest(vmx_entry_fred_test_guest);
+
+	/* Following test_vmx_vmlaunch() needs a "not launched" VMCS */
+	vmcs_save(&curr);
+	vmcs_clear(curr);
+	make_vmcs_current(curr);
+
+	/* Bit 2 of FRED_CONFIG is reserved; setting it will result in a VM entry failure */
+	vmcs_write(HOST_FRED_CONFIG, 0x1004);
+	test_vmx_vmlaunch(VMXERR_ENTRY_INVALID_HOST_STATE_FIELD);
+
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12658,5 +12696,6 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_exit_control_pat_test),
 	TEST(vmx_exit_control_rtit_test),
 	TEST(vmx_exit_control_cet_test),
+	TEST(vmx_entry_fred_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0

