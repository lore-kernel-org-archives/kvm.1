Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7B4A1DEE;
	Tue,  6 Oct 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305739; cv=fail; b=S5ThLrCRra+I67/hGm/bEJTCG2itJzHujJmokPTT4mlGyDHeADuba+HgusG4ijQpvoFnfNJKI/32ilthyyXbuXaNoriIcm8Y3NlOJ17tvXyMQ/DrSHp9evV5mhPh3x/H7JJFDvEGCiw+0mvP1+vcb23eDYBSgMDB+uVWsC8EAWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305739; c=relaxed/simple;
	bh=Me8RZ801XMiJh2K9B1b9iDFLfXJh0HSMJ7NJmjFvQ0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=In4SncdELFUd+iZfUih+bYHvtKlumJQUlXkftyZgJw74m+CRw7/XOAZ8OT1AvTlMmnNgZHTB3HDTXFS04JkuNtB0SNaofHe7jKsEt+lv9md3PTY0zi7VdH7ovqjir+baFhTSQuUKJw43wzGbcW+1wdGlsp3hn6p2ZCWaLa6+sZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oe4VRKgL; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oe4VRKgL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anwcEkYEnD7zdMm9cBtT+nRMSoITdoPRliEUn1Ru8jBnrCVLRH7wr3xpt6NHa7jjYJ2TIrGHjCd1owjHlx0kd/0o5A/VptJyA0BHc8uyscbVnTJU71JWXSILhkIhl3edoUpwH1C1wLNl2v48PZ3OpTbl3MkIDk91/dP3E78fAOeJTT8U92D3b7ne9vgjts6ks1LfE8U+DzBRf2A9dAWutbETxZ1tktd8VV3oUSASP9uaIzSicsCEd0g/cPUtDLJCxagp1lPykXWlN1dS+jV4XTJIskB0fyKYeJpPk/eHup2g/iUUlnD5ddZo2hiniN9BMeSQ6TiWShqbOTwt/cLiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1GQebGjvqbznPZHxzRJHqtPIQYFWtqug/HKMPfUSgw=;
 b=O01wnKSd6Ca5PPbfYEs2w794vecolA5CebBYoCcAdQUzTGv5ACJYbDm6VMCaE7O/m8boy6Ubc1/c5OhnAILe3HD4ez/LvoH1+rIAIWPGeDslmM6tSdfoL0RW/cLDXinGJcdSTYjuGoLRQhiYa2iyC/AZIrjlAGaqYVtWkEFkngv7bs9MyVuDEskBGEEz00GLjvl4+qlTfmsenzipdqLWHhfzM1PDDEoU0I7hz63DBhoVbqFJVWSoOMaIuWKZsc/vXEKHSzKXZ1jZ+QMu2VJWjEYW8KS8uAXlmepHBf1yV01xnFvhSwTE/c+t20Mof/iWhE5OjNguBkfdziAcU4YcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1GQebGjvqbznPZHxzRJHqtPIQYFWtqug/HKMPfUSgw=;
 b=Oe4VRKgLpjYSY43KWYXDX29FiOGZwn93FoUcpjKEOMvos5mVqGRIAbSIhlJnNaEJlTgYuw4S5k7W7QNGHCdB6MVLr4Njf47JOp0C8bYYGRdL4AFPzKZhzELddzJ3xQW8hxCN6Rk7WvYNrZ3281RTqhpB5SNd0WMiP8Q9dCPdEIA=
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 16:55:30 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::90) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 16:55:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 16:55:29 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 11:55:28 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v2 2/4] KVM: SVM: Add host support for Enhanced SMT Protection
Date: Tue, 6 Oct 2026 16:54:59 +0000
Message-ID: <64ea6ba62315d33b7bfb48ec6cab29ac4ee2fa06.1791302373.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791302373.git.prsampat@amd.com>
References: <cover.1791302373.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a4d42a-5ac2-4eb8-b7dc-08df23caa0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|22082099003|18002099003|6133799003|3023799007|10067099003|56012099006|11063799006|20046099003;
X-Microsoft-Antispam-Message-Info:
	uCPcsFUOfdx6bqHRvQiM4xQY3Zhy9H7Q0dF5wtQdPpGfEkUbYU26gk2pUdoMYrL8/gUMJeJmRJEO6jg30pMr+1gfSX3HNNgnaQaF+Sltp4yhfpsANZW/QC263iQ07H0wjj8otVoQ1wbZdUx2LxfQTrQo3cK/MuVkjpJKAOhCthZEEHkX0F1gvFG3DJTuQ4NeRTicFHSAJ6nwHiGp/rTxbWlr521O57I3pr6CNTUtRc6md6iyePYMmsc5A5lMr6sJu99J6bW9GGVqBVkIEDTo5KB6PU63KaGN3kQWzCAOSp2I8OxaCm9U0gSnanwRZb+7EaNBlTyi+auC4ztjwl6XTHuPce7NJYL0rZUcGm/ODTl66kPH154FMlQZaSYooAx03RAUJOawaQixe/ZdlH6pT9sfterkEElGtuwyLSK7nhhCppeDgzBTyTy681cppOIEolLsnPMt2rzOE6arQPsYvEoq0v2XuVc1Vo+H7QfM8jwPGygr07FbvGR9TT6OzlHeBhwOf2Rfrq5Zeqn0/VSNWLuKcMHGzlaZTdRNLPu2qL8AUWBXcXf4Rbo9EkzQjcsMT/qDioiTIAC9g5P1ANtWys7nxNOJojeSZUNmdm2noWgpsMdOgVMi7jkFz4I/TiuZccSUBjEhyQi7MYYC1NOPbdO9VaW0W5iyzS/ubGDlAiu+I5aDhcOnr3S5Dt4+xNNPVpxcAHF7SH4UXpIhd0pEfg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t42UG5UHAl2TxNe/c2yrDkVIm2/ODwc7KLJQz7059l4WP4b/kHALCXoINgJ+FOqaZVnZZTSWQ81osAbzSfe3SBr4MkwKSupXddxzb3ffLam+HrO91moFE8YS9RKd+0LY7p5lmxLPGZ+8MooIVfY5UNbV9GybNbNZubOL59o797D5qB2WT13uEKASKNaf+L7JjOyMzMrYOJxH8TvvN/w/uTkNhtdDcctGK2lZ2bRJLy/BGmKM7i5ViwZWkqbk5U54IddS/+1HzkCRj4exdQsYb5d3XJq17YRDdcyuu71bVyHYFxrqFMWu+beHCDMpeMLOpU2cleNX8c1D2w2G8UOwOM4o/9Xobx9iVQ4lFTpztcVuyiupAQO3XAUzmpAfCmyHzDGfFUmN1DFG3sIwLXwI0uaaTnLL7BhI6VekEvHPMY87S38PvubGpR3zvgwl2BI2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:55:29.8782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a4d42a-5ac2-4eb8-b7dc-08df23caa0eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030

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

Acked-by: Borislav Petkov (AMD) <bp@alien8.de> # non-virtualization changes
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v1..v2
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
index 5705723f1f41..df836dfe3e55 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -67,6 +67,11 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
 static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
 module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
 
+static unsigned long esmtp_timeout_ns;
+module_param(esmtp_timeout_ns, ulong, 0644);
+MODULE_PARM_DESC(esmtp_timeout_ns,
+		 "ESMTP VMRUN sibling-wait timeout in nanoseconds (0 disables the timer)");
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

