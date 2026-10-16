Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE423B7B7F;
	Fri, 16 Oct 2026 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187685; cv=fail; b=bwT5t6cwnduGmb1FrLoK+ROMCYch+8JJngCnCvCr304zU4krOnrBwlJKiZd4H829NM4h+hz3/Y6V8zA7AMvmnO0Sh8rOq4zhfoLymBkaqI8lpuMnVYCiph7VLIVCMaH8DYjHPg2OGs7qiAO2Yi+7B0RRJXF2uh7qjHgRSssg+98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187685; c=relaxed/simple;
	bh=fSjB8OYgRF6pMfIMqB1iCh3I8p7giwkNV9Nb8KSYygs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bolVgGHwDJyeDBcrBhX0x8gHUoqo1J6OWsoA+YsergwfCC2r3KSS2WiIjoNnYNn5bQnAOV8dI/UCbetfh+MI+s8uruDJEKdcz5ATyP62nfttFpcjm8gsetktOJCoc7Jhe0AFnvSss6vZqs2ATReb6gfoBoN3WH4c/DNufxVkGpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gsFUghbg; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gsFUghbg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7vhDenMxh25HY8TqpVcETq3sgQjqHzwBNlJ9viMw1acJ2qab2vK6xInPuOjH1dvfLOgPApwy0DBkc1//FBJluR2Wufs7SJz0dEqJQiAZiaVgb9IcKAhcwxrAAmM6K4YnPfw7OILcLaLkNuknttKUBuAOhdg59re093xKLb95LTZPzp+c5NwbxFGfm2m4UT69KcrjAQwpOgiPqlJRsfsnxfa2ZZC0tl2abXUo7s4nSprsvISmNeC+W0DAbED6ef+HZH2tmTNJjhaQt8BTOATOQiIbTBgE6yvrKIXxIH3MuYoVxrAtIlH0J7r99hxg7sGEjk+v/vDh6NocaxkPQYyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaMxAJaEgiZeJ02siufR63D2g13OPsJwg3QsnfTAVSA=;
 b=FCYb2qLldgy90A1b4o/EAoe+RMMPIK58dGOaWwTMGm4C2dFdNZr8Hroz20JLIMRLw10mmd7+uqZqb1huhPTBZdS8TwZtVfJpRxhUR4pTOQM/IM65X3QABFzP59hz+lHSzgZG/dmvAnedGWGcuCl1nbusGYj0YOcwNNy3WUiy7uxnYOzAb3U74d+zPkNZZgKld6mRptsnm5n1PTfIDvXskpbpz3/5v+fFHcmqICgtk6J0vWFFcTb/B47yOOTfnzQqoNx455gHtBUCvTj+Hz3AfoNie3hj3ZBf/SzhSBJiF0LTr3wEeBnkbIgYHiPaTUZkflTASXtVtkdA2LkZWhkd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaMxAJaEgiZeJ02siufR63D2g13OPsJwg3QsnfTAVSA=;
 b=gsFUghbgMrny686Qr0ROTr08YeLfK4yYWWJK20O5eIpXRfiYYyOyoTJvmBtQW8d8Jk/sytftFvznKpz+jW9cTRYxwBTp4FiqAdws1Ys+Vxyr/ssxGhzdQWw7rVwG1nfzjMiwA6yQSkj9m3EW0iscrw2XAW8r39GusYHbhcANTTo=
Received: from PH8PR02CA0005.namprd02.prod.outlook.com (2603:10b6:510:2d0::13)
 by EA3PR12MB172729.namprd12.prod.outlook.com (2603:10b6:303:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 21:54:38 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:510:2d0:cafe::8) by PH8PR02CA0005.outlook.office365.com
 (2603:10b6:510:2d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 21:54:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 21:54:37 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 16:54:29 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v3 2/4] KVM: SVM: Add host support for Enhanced SMT Protection
Date: Fri, 16 Oct 2026 21:54:05 +0000
Message-ID: <040a45e5a99c2c420f3319ac0562e1c0fe75e655.1792184487.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792184487.git.prsampat@amd.com>
References: <cover.1792184487.git.prsampat@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|EA3PR12MB172729:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1eba1e-a3c8-43e5-a745-08df2bd012aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|20046099003|22082099003|18002099003|3023799007|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Yxz0BjzDUKDFLPUFZ7p1vH5/K47xFZXRaNK6+DFi9dyoResZwHoJlqK3Bupz7xAkNa3R/bXZSKRHSH9OA//NFCIq4b/46oWMuLidukFo5MeQQO0xete4NCt7JDGjcRcwYghGmRH0Bdk+abahofRTO8OJDZrBFFs2vQqWUk/iGgYZJI+Jypih3CsYJ/8QEjUSf7UyAo/vxpLC/ioj4JjnohTfaqcXotXQZj4vmfNAhcNdZONljA8CiKGxk4gntc2TaIEj+vBpBCWvGEOr447gDqNTdCzO1BiVGie6I6/seaEwc4CC/s9DhV0o6phfOLhLBiGtU1eHMZZffFfNmATYZLU0ES42K4UeVZ8i2cIEecQYyvmWF00d4nN5UD9y2b4LLt/pcpH/OUVNPZKSzPzt3BwEeWPL0oE0Y1dY/W2ayOZcQvbREENBVqFTgFKJ/7ev81Ngk3m3kXhniTv7gO5alMhBb5lmAMsxDWG0r3fbQ5E0FIp5d39JWRPfeGDwz0DMMD5UeMYV8fVAncT7rp6tydQ+qS128tfZqGwDndM52MrvXuW3MNvoGETHyx6bwocf8jrK/3ONWl9SiB3X7kig7D6Kc8by++tQjWcbAsexUo+8DmalDqUvavPUXEePea+FOb1Rdi2s5SIV9H33Ox/ptfozUnaQ0fOB3CneZnFePPVM0k8hWIbuwM6YRSIKuH6FkPe0k3VviVCKIB5DQnsg+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(20046099003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LPkzjJ+jC1cvoY2boYIQRD2ceUz1jZHYCGm83Bp8BewX4SRpBYDiewtdVBmSOCj0mIrKoT520HzFX4SzDXclrxrgSwmllr7ncKcwjpTyHhQ+OwBhH45ygcyVpreNJcwpZK4hSxgBWbLzLQEqM4B8yu40DYGEFpmy9G0egzlLmnfcdVEyd4ZZ3b5T20f7SoHkL7nAhLosjZ8VeStQt8VNj+XSNwQuzJh9LrGdM/l4XJcQA4EEitRUpqRpNtxSxY7rIDDtEwqYJy2aWHdfUYxZLM67Lkc8WhdRsaIK4acO7UTKRnYbHWl5O0C2MndKf3LBnotjfatWX6gWAtgLoohB2OThDZrsfQZBUms8MQpFjqDnhamePhNMHu2GzeB2Rm/7Isvsujgcia30SrgkXSsl9Yk84uDzG7REvIp7GiAsQTY7bgkD+CaR5Vk+9E3EKKZ9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 21:54:37.5149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1eba1e-a3c8-43e5-a745-08df2bd012aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB172729

Enhanced SMT Protection (ESMTP) protects an SEV-SNP guest from SMT side
channels by requiring that, while a vCPU is in guest mode, its SMT sibling
thread is either idle in host mode or executing a vCPU the guest has
declared to be a legal sibling. A legal sibling is another ESMTP vCPU of
the same guest that carries the same VCPU_SIBLING_MASK and agrees on
VCPU_ID outside that mask.

Hardware enforces this at VMRUN, which no longer enters guest mode right
away but stalls until the condition holds. Three new exits report that it
could not be met, all of them non-fatal:

ESMTP_ILLSIB: a sibling thread is running a vCPU that is not a legal
sibling of this one.

ESMTP_TIMEOUT: the stall exceeded the timeout programmed in the VMCB. The
timer bounds how long VMRUN waits for the core to settle. A module
parameter exposes an interface to program this timer.

ESMTP_RETRY: If DBREQ is detected, VMRUN exits. ESMTP_RETRY indicates an
internal event and the hypervisor should execute a VMRUN.

Refer to the AMD64 APM Vol 2, section "AMD64 Enhanced SMT Protection".

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de> # non-virtualization changes
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v2..v3:
* Collected Reviewed-by from Tom
* Reword esmtp_timeout_ns description - Tom
* Convert esmtp_timeout_ns unsigned int to avoid division overflow
  errors - Sashiko

v1..v2:
* Collcted Acked-by from Boris
* Move idle wakeup ICR programming to svm_enable_virtualization_cpu()
  instead of sev_hardware_setup()
* Remove cond_sched() in ESMTP exit paths
* Program the IDLE_WAKEUP_ICR for all present CPU siblings
* Add documentation for ESMTP timeout
---
 .../admin-guide/kernel-parameters.txt         | 19 ++++++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/include/asm/svm.h                    | 12 ++++-
 arch/x86/include/uapi/asm/svm.h               |  9 +++-
 arch/x86/kernel/cpu/scattered.c               |  1 +
 arch/x86/kvm/svm/sev.c                        | 48 ++++++++++++++++++-
 arch/x86/kvm/svm/svm.c                        |  8 ++++
 arch/x86/kvm/svm/svm.h                        |  2 +
 9 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..e09f18c0de34 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3240,6 +3240,25 @@ Kernel parameters
 			max_snp_asid == min_sev_asid-1, will effectively make
 			SEV-ES unusable.
 
+	kvm-amd.esmtp_timeout_ns=
+			[KVM,AMD] Enhanced SMT Protection (ESMTP) VMRUN
+			timeout, in nanoseconds, for SEV-SNP guests that enable
+			ESMTP.  When an ESMTP vCPU executes VMRUN, hardware
+			waits for every sibling thread to either be idle or
+			run a legal sibling vCPU of the same guest before
+			entering guest mode.  If the wait exceeds this timeout,
+			VMRUN exits with VMEXIT_ESMTP_TIMEOUT and KVM retries
+			the VMRUN.
+
+			The value is converted to TSC cycles and programmed
+			into the VMCB when a vCPU is initialized, so changing
+			it at runtime only affects vCPUs that are created or
+			reset afterwards.
+
+			Default is 0, which disables the timeout, i.e. VMRUN
+			waits until the sibling condition is met or a physical
+			interrupt arrives.
+
 	kvm-arm.mode=
 			[KVM,ARM,EARLY] Select one of KVM/arm64's modes of
 			operation.
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f70ee74b5f92..4cf477e95c58 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -529,6 +529,7 @@
 						      * and purposes if CLEAR_CPU_BUF_VM is set).
 						      */
 #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
+#define X86_FEATURE_AMD_ESMTP		(21*32+21) /* AMD Enhanced SMT Protection */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3a8e51a0c9e8..fbcb3313e946 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -761,6 +761,7 @@
 #define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
 #define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
 #define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
+#define MSR_AMD64_IDLE_WAKEUP_ICR	0xc0010137
 
 #define MSR_SVSM_CAA			0xc001f000
 
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..323ab7089302 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -165,7 +165,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u8 reserved_9[22];
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_10[664];
+	u64 esmtp_timeout;		/* Offset 0x148 */
+	u8 reserved_10[656];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
@@ -310,6 +311,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
+#define SVM_SEV_FEAT_ESMTP				BIT(17)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
@@ -482,6 +484,11 @@ struct sev_es_save_area {
 	u8 fpreg_x87[80];
 	u8 fpreg_xmm[256];
 	u8 fpreg_ymm[256];
+	u8 reserved_0x670[560];
+
+	/* Enhanced SMT Protection */
+	u32 vcpu_id;
+	u32 vcpu_sibling_mask;
 } __packed;
 
 struct ghcb_save_area {
@@ -554,7 +561,7 @@ struct vmcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		744
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		2216
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
@@ -589,6 +596,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x670);
 
 	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0x0);
 	BUILD_BUG_RESERVED_OFFSET(ghcb_save_area, 0xcc);
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f614..e59baf4b3c3f 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -135,6 +135,10 @@
 #define SVM_EXIT_SW				0xf0000000ull
 
 #define SVM_EXIT_ERR           -1ull
+/* Enhanced SMT Protection VM exits taken during VMRUN sibling sync */
+#define SVM_EXIT_ESMTP_ILLSIB  -5ull	/* Illegal ESMTP sibling */
+#define SVM_EXIT_ESMTP_TIMEOUT -6ull	/* ESMTP_TIMEOUT expired */
+#define SVM_EXIT_ESMTP_RETRY   -7ull	/* Internal event; retry VMRUN */
 
 #define SVM_EXIT_REASONS \
 	{ SVM_EXIT_READ_CR0,    "read_cr0" }, \
@@ -246,7 +250,10 @@
 	{ SVM_VMGEXIT_EXT_GUEST_REQUEST, "vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
-	{ SVM_EXIT_ERR,         "invalid_guest_state" }
+	{ SVM_EXIT_ERR,         "invalid_guest_state" }, \
+	{ SVM_EXIT_ESMTP_ILLSIB,	"esmtp_illsib" }, \
+	{ SVM_EXIT_ESMTP_TIMEOUT,	"esmtp_timeout" }, \
+	{ SVM_EXIT_ESMTP_RETRY,		"esmtp_retry" }
 
 
 #endif /* _UAPI__SVM_H */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 8665a6474806..16620fa0e290 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -67,6 +67,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_ESMTP,		CPUID_EDX,  1, 0x80000025, 0 },
 	{ X86_FEATURE_AMD_HTR_CORES,		CPUID_EAX, 30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..cb54c518f5c8 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -67,6 +67,11 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
 static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
 module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
 
+static unsigned int esmtp_timeout_ns;
+module_param(esmtp_timeout_ns, uint, 0644);
+MODULE_PARM_DESC(esmtp_timeout_ns,
+		 "ESMTP VMRUN sibling-wait timeout in nanoseconds (default: 0, timer disabled)");
+
 #define AP_RESET_HOLD_NONE		0
 #define AP_RESET_HOLD_NAE_EVENT		1
 #define AP_RESET_HOLD_MSR_PROTO		2
@@ -506,7 +511,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		return -EINVAL;
 
 	if (!snp_active)
-		valid_vmsa_features &= ~SVM_SEV_FEAT_SECURE_TSC;
+		valid_vmsa_features &= ~(SVM_SEV_FEAT_SECURE_TSC | SVM_SEV_FEAT_ESMTP);
 
 	if (data->vmsa_features & ~valid_vmsa_features)
 		return -EINVAL;
@@ -1021,6 +1026,15 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 
 	save->sev_features = sev->vmsa_features;
 
+	if (sev->vmsa_features & SVM_SEV_FEAT_ESMTP) {
+		save->vcpu_id = vcpu->vcpu_id;
+		/*
+		 * All vCPUs of a guest are put into one group and can be run
+		 * co-resident on the sibling thread of the same core.
+		 */
+		save->vcpu_sibling_mask = U32_MAX;
+	}
+
 	/*
 	 * Skip FPU and AVX setup with KVM_SEV_ES_INIT to avoid
 	 * breaking older measurements.
@@ -3259,6 +3273,9 @@ void __init sev_hardware_setup(void)
 
 	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+	if (sev_snp_enabled && cpu_feature_enabled(X86_FEATURE_AMD_ESMTP))
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_ESMTP;
 }
 
 void sev_hardware_unsetup(void)
@@ -3290,6 +3307,31 @@ int sev_cpu_init(struct svm_cpu_data *sd)
 	return 0;
 }
 
+void sev_esmtp_enable_wakeup_icr(void)
+{
+	unsigned int cpu, sibling, shift;
+	u32 core;
+
+	if (!(sev_supported_vmsa_features & SVM_SEV_FEAT_ESMTP))
+		return;
+
+	cpu = raw_smp_processor_id();
+	shift = topology_get_domain_shift(TOPO_CORE_DOMAIN);
+	core = per_cpu(x86_cpu_to_apicid, cpu) >> shift;
+
+	for_each_present_cpu(sibling) {
+		u32 apicid = per_cpu(x86_cpu_to_apicid, sibling);
+		u64 icr;
+
+		if (sibling == cpu || (apicid >> shift) != core)
+			continue;
+
+		icr = (u64)apicid << 32;
+		icr |= LOCAL_TIMER_VECTOR;
+		WARN_ON_ONCE(wrmsrq_safe(MSR_AMD64_IDLE_WAKEUP_ICR, icr));
+	}
+}
+
 /*
  * Pages used by hardware to hold guest encrypted state must be flushed before
  * returning them to the system.
@@ -4792,6 +4834,10 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 		svm->vmcb->control.allowed_sev_features = sev->vmsa_features |
 							  VMCB_ALLOWED_SEV_FEATURES_VALID;
 
+	if (sev->vmsa_features & SVM_SEV_FEAT_ESMTP)
+		svm->vmcb->control.esmtp_timeout = mul_u64_u32_div(esmtp_timeout_ns,
+								   tsc_khz, 1000000);
+
 	/* Can't intercept CR register access, HV can't modify CR registers */
 	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
 	svm_clr_intercept(svm, INTERCEPT_CR4_READ);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5d15c706e43b..624675a12d51 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -591,6 +591,8 @@ static int svm_enable_virtualization_cpu(void)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 	}
 
+	sev_esmtp_enable_wakeup_icr();
+
 	svm_init_os_visible_workarounds();
 
 	svm_init_erratum_383();
@@ -3743,6 +3745,12 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return 0;
 	}
 
+	if (svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_RETRY ||
+	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_ILLSIB ||
+	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_TIMEOUT) {
+		return 1;
+	}
+
 	if (exit_fastpath != EXIT_FASTPATH_NONE)
 		return 1;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..8cd8b825c9a0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1008,6 +1008,7 @@ void __init sev_set_cpu_caps(void);
 void __init sev_hardware_setup(void);
 void sev_hardware_unsetup(void);
 int sev_cpu_init(struct svm_cpu_data *sd);
+void sev_esmtp_enable_wakeup_icr(void);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
@@ -1036,6 +1037,7 @@ static inline void __init sev_set_cpu_caps(void) {}
 static inline void __init sev_hardware_setup(void) {}
 static inline void sev_hardware_unsetup(void) {}
 static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
+static inline void sev_esmtp_enable_wakeup_icr(void) {}
 static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
-- 
2.43.0

