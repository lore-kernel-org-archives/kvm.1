Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1703B1EFC
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765441; cv=none; b=IPAbnrSx6Ga3jF6RBcpjlJ2tXTIH4QoME/odT9tBRrNFaCQZ7zoi9C1kEsN88AnVhv24tAil8nmmt6tOi+xQoCCp6biB+2Lgqm089/W0PiKg4WkWXHrY4DUoytetEXa37g7BfTvoMw4hCeRNW49OjozEoTA3rL5WgCu05iSiHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765441; c=relaxed/simple;
	bh=wgXQEe8w+wtVhbVc4U+qSWbw8W6T5LsHW2S9YLQYnCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQtFpUozO0BoDGX56HVOV24QdT27clJng9Ijtv3OEx8drWfHINOK2g5edxCsMERxin27X46Dy5DH84q1XaDa6XEG4zaMXqm3KQpfKsXw+/8tpGynXX49lF9lj/Fqinnl9R9fWHGrYLKt34OY6LloTfB2JE9+SfSj0dmN8hsa7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF5pPMJg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF5pPMJg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779765439; x=1811301439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wgXQEe8w+wtVhbVc4U+qSWbw8W6T5LsHW2S9YLQYnCM=;
  b=nF5pPMJg/9dwggtpQF7oWqpSMMu68w+jlLhUHXAHEz8/NTZIN1nCIs4r
   /KvppvUR3ufuZ83tP+spCSdRZJM8xuifEgm6fR7K/ra78MLpLnuZ7QxF3
   VfTj66/PFTG29TojkMInjOhhPjd2Yuxs7fdoKhu3ighwy0WOQ1K/UW6RK
   P9S2ijsOeVsBO2b6yrfJ8FBFuERYeJmZLyjFPge6e1PFE70785O4byp+T
   7uJJKhIp3gzP/taxOXD5lyS85/3b0XLPew7LiVXW77AN7mY5GOOYGBF45
   zeRV+7XA0AJNZasid1/lP0+Hu0P4BlUfyb0NpSi+GzTOP/4hVQYbW6OEB
   g==;
X-CSE-ConnectionGUID: ciPhjvO2T7+unfyA3wjmqA==
X-CSE-MsgGUID: 7ghUlyI6SfucYfNK2oUSQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80479572"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80479572"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:18 -0700
X-CSE-ConnectionGUID: 6H9sty80Tlm6PKPVAxmR+A==
X-CSE-MsgGUID: IGu4hb2xRJa3TW8MvHyy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246741783"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:16 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [kvm-unit-tests PATCH v2 4/4] nVMX: Validate DEBUGCTLMSR_LBR states during VMX transitions
Date: Tue, 26 May 2026 11:16:37 +0800
Message-ID: <20260526031704.109102-5-chenyi.qiang@intel.com>
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

Add tests to verify that DEBUGCTLMSR_LBR state is correctly
handled during VMX transitions on top of the shared helper.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 x86/unittests.cfg |  9 +++++++++
 x86/vmx_tests.c   | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 78c15e2b..d089c86d 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -487,6 +487,15 @@ arch = x86_64
 groups = vmx
 timeout = 240
 
+[vmx_legacy_lbr_test]
+file = vmx.flat
+test_args = "vmx_legacy_lbr_test"
+qemu_params = -cpu host,migratable=no,+vmx
+check = /sys/module/kvm/parameters/enable_pmu=Y /sys/module/kvm/parameters/ignore_msrs=N
+arch = x86_64
+groups = vmx
+timeout = 240
+
 [debug]
 file = debug.flat
 arch = x86_64
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 934d6021..80ed541a 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -11843,6 +11843,23 @@ static void vmx_rtm_test(void)
 	report_pass(__func__);
 }
 
+static void vmx_legacy_lbr_test(void)
+{
+	if (!this_cpu_has(X86_FEATURE_PDCM)) {
+		report_skip("%s : Perfmon/Debug Capabilities MSR not supported",
+			    __func__);
+		return;
+	}
+
+	if (!pmu_lbr_version()) {
+		report_skip("%s : LBR not supported", __func__);
+		return;
+	}
+
+	vmx_debugctl_transition_test("DEBUGCTLMSR.LBR", DEBUGCTLMSR_LBR);
+	report_pass(__func__);
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/syscall_handler/guest_regs */
@@ -11968,5 +11985,7 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_bus_lock_detect_test),
 	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_RTM_DEBUG */
 	TEST(vmx_rtm_test),
+	/* "debug controls VM-entry/exit controls tests" for DEBUGCTLMSR_LBR */
+	TEST(vmx_legacy_lbr_test),
 	{ NULL, NULL, NULL, NULL, NULL, {0} },
 };
-- 
2.43.5

