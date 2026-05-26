Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D03B1EE2
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765437; cv=none; b=BOGz0odyOxe2PRfaOVZtJrdEwNcFPz/2onPSnScOTbqZ9HalILNIwfCRUDxnetyAupeexUCx+zsDFAx9FBXDpOKG9eZV/xWVsSfP4pk4e+yv1iCUgps9DgMIWGPGqJGAJpPkHsKOe+anpCfj1xJwuhbtSZHHluq7OdwG1n2MjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765437; c=relaxed/simple;
	bh=N6fTiRN01VOs25vcpwxytBOtP9r5Et+eHYz8OR0WL7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbX022j2DwzgvWTKSaDAlvip2tFZDqDr3unFucM9j3umhBp3Kp384yO/vD24+p9F81IghBFCuuJxn2mtvT0+s9xygPY0sIgwOLyQyrto6IqFjZFdAyk+u/r6Pg+w0iaBIGita3t7iWeFLbBoS8Lsw2sSrJMrMKGvpjfWtELewB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC4br5f+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC4br5f+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779765436; x=1811301436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N6fTiRN01VOs25vcpwxytBOtP9r5Et+eHYz8OR0WL7s=;
  b=CC4br5f+cibAaWpZ19MPZccipq/7yUS3fK3P9YgCelSwTt/U0NQ9ywTu
   HkyfSw9IEr7yWTtj6jzTXR3Gs4EufVjrxAH34w0zlAE3O3Cyz+0H8l595
   dJlKr8nqd4E+5yTGsZhzs7zjK7kcSkYX42AJnxTjyHd2fRRoB1+L1MvBE
   N+d7cESq5Tjgr21JTocBkrpvvfV0jXhdT1UMNL/z7vYhsjumnGc2KkVd5
   6GXLfWUc/6yE6eofsVj4enEdugGIsa4V+sxwpQJB/W1n0/vGPEc6pkKty
   phzgpBezhc6DZ2op06L2UXkOx33HzeCT5P3oTJsizAYR5UdYLzpRNLLiZ
   Q==;
X-CSE-ConnectionGUID: ktezvC8PR1a3NYMIqXI5Gg==
X-CSE-MsgGUID: 2cV+OpyeTvGzoJcvWHiP9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80479565"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80479565"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:16 -0700
X-CSE-ConnectionGUID: ENId6KbUShSVGsFi3bAcQQ==
X-CSE-MsgGUID: 7c7t6UNTRDeXciv7vkk2bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246741764"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:14 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [kvm-unit-tests PATCH v2 3/4] nVMX: Validate DEBUGCTLMSR_RTM_DEBUG states during VMX transitions
Date: Tue, 26 May 2026 11:16:36 +0800
Message-ID: <20260526031704.109102-4-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260526031704.109102-1-chenyi.qiang@intel.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that DEBUGCTLMSR_RTM_DEBUG state is correctly
handled during VMX transitions on top of the shared helper.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 lib/x86/msr.h     |  1 +
 x86/unittests.cfg |  8 ++++++++
 x86/vmx_tests.c   | 14 ++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/lib/x86/msr.h b/lib/x86/msr.h
index da75740d..8b019f7e 100644
--- a/lib/x86/msr.h
+++ b/lib/x86/msr.h
@@ -110,6 +110,7 @@
 #define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
 #define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
 #define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
+#define DEBUGCTLMSR_RTM_DEBUG		(1UL << 15)
 
 #define MSR_LBR_NHM_FROM	0x00000680
 #define MSR_LBR_NHM_TO		0x000006c0
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index c8426770..78c15e2b 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -479,6 +479,14 @@ arch = x86_64
 groups = vmx
 timeout = 240
 
+[vmx_rtm_test]
+file = vmx.flat
+test_args = "vmx_rtm_test"
+qemu_params = -cpu max,+vmx
+arch = x86_64
+groups = vmx
+timeout = 240
+
 [debug]
 file = debug.flat
 arch = x86_64
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index a3e52d3b..934d6021 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -11831,6 +11831,18 @@ static void vmx_bus_lock_detect_test(void)
 	report_pass(__func__);
 }
 
+static void vmx_rtm_test(void)
+{
+	if (!this_cpu_has(X86_FEATURE_RTM)) {
+		report_skip("%s : \"RTM\" not supported", __func__);
+		return;
+	}
+
+	vmx_debugctl_transition_test("DEBUGCTLMSR.RTM_DEBUG",
+					 DEBUGCTLMSR_RTM_DEBUG);
+	report_pass(__func__);
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/syscall_handler/guest_regs */
@@ -11954,5 +11966,7 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_cet_test),
 	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_BUS_LOCK_DETECT */
 	TEST(vmx_bus_lock_detect_test),
+	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_RTM_DEBUG */
+	TEST(vmx_rtm_test),
 	{ NULL, NULL, NULL, NULL, NULL, {0} },
 };
-- 
2.43.5

