Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907C492E5A;
	Mon, 14 Sep 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405001; cv=fail; b=LLt0rUFYCZowLnEmSYCDPoBZYKe0/6EuNy2Ju3r/vJmJRVUSh4LTaQLoue2AV9bekmewS3KseCfQ7vmq9/v64X0MsqWYQ54kWCILuqRKsMrpdnO9kp70qavhnOMaRfuQrP/EogtUR8ULjVRc348oI/IVU4vYFGNlGHhoaaVADc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405001; c=relaxed/simple;
	bh=itmrILxNstA1VvUx+muynPdv0Smz7nY/zRq6pCwbKVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrpNzupwo0qqkdrjM9MZesZZsAQ9yyvVz2NEOujaJcYWR/1fKm41UWHe3nBsC2FJdLOA7x5QayrpP5CkDfpkLL6f6qqvpMA4IgBlEaMIYSz/Cfs00jmTuHcgt/ZrZnbk/axT7w913Nu7THLDDFHFoqRnpmbGv9diyXW7GTFe45w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ehMs2tH; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ehMs2tH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhLCWwb8MVG5LqupvXVDk0mNEUA4v07wzRRNx1PcAkyTTeaIfdQEsUkleFHy9hAxTX4JsyGovmhGQkgsIzfRsqjJydgAyGUTL+xBCVXIKhqBzaBTNIFRmtHE+qy7AZcPwpxafVOjVW1JldXqpky6vo3wmokXncWsThrwF2BdxsLyPuqE+xZK3X/rXc9T9cYOfUnju7h/o3JVsM+IAgA3hkJMQjklp50Jfg8VNqmYgg9YZR0UKgYNGnczDN/CtBg7BDDOOjV1Zw0HNlZGIxBtTZbH+sJVn/AMK2RRyWJdw9XUWgfoppECJC/tQ6oxlUukA5fDcUCsA6arDPyPebY77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY5/J95ZMw6bX9tUwuIZfGV5w6z0NneAESIbAK2NUdo=;
 b=aPqrIMkvbxrMETktX27vXUW+si7FrLJ+4XqDYorT8sT72gx9ERj00F2GHkvsiVD1s4rTUFLRl6uWPtlM/DtOK9R7/jpPg3w0MKQt+WxE6Fuzlgf9pvK9XgZ95fEylBaKqktTYLTH5thVxUDT+FLQVOfp5KVzJUJbQ0Gdn2ONUSkqfiLeFy7Ezig+WwhJXl8rqauoRkduArsmZ+MQGVn8TTy6T74K1aXwMl7guPkcp6s8sWo74E5XFAEM0U0gCfliMwAYjifNckMjhWYzB6OWnA1exsMBc7ra76biPV6LB7jMnv0BjtC9pKKr/fqFjCPo0yreOuN8aYH8Kofhg2vzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY5/J95ZMw6bX9tUwuIZfGV5w6z0NneAESIbAK2NUdo=;
 b=1ehMs2tHHnrdOKqYbJc1WlDDSQXnkltOo41Xd0vF/inOkj2TlNBbqAK0QWN9NMCykeK/Se7FLMksyIrZFZ21/KYgY+8IOveZQJ/5RHqn68OMoyv9OGMfwcG60jyBirOhXkV1hjq6/YubNuVXVK4UGSWhdhk+w6dHHoHU6IhhwbM=
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 16:56:35 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::37) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 16:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 16:56:34 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 11:56:34 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [PATCH 2/3] KVM: SVM: Add host support for Enhanced SMT Protection
Date: Mon, 14 Sep 2026 16:55:55 +0000
Message-ID: <df22a9879871f5f926ff74b203e06b58ed505503.1789399214.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789399214.git.prsampat@amd.com>
References: <cover.1789399214.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef35b07-5dfe-4f9f-9c3c-08df1281227d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|56012099006|11063799006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6q9Se44+pFg+Rkd3NY0mEPOx9n7LyzFRtUOPe0aIDcZ7Z275oxWSIcMuDc8sjxJXVLtfeb85rv3FNcbeUSGAG0e0NgY6IsnIDdnek4QxBar2IVAdcmw5FD6oH3g93Ui3kp7pkM2nEkp3QkPNRLB2CzQ1R6eg5k8MsIvkJP3Gyv0rFSidvGpxODD5k1zR82Ka9/9NbBA9HT3phwoIrwGJwIexPIF6nQtLX+73SL13zOqnuZZXAvEnQxXiQOT2G1KR6Gb2rUZddumqTePHG9VzJwcODB+nyZncXxIugqL+UPKQoN2sHncbLfiMIZ2LbbZuE137DQuRbS5v4a0+cDQpbAe8dXCm8Ex76uzvvmUYS/m6MZqEUBMYu+HKibmZmmRUfoQbyWvXwID5YK5tPtheUkVkCPYRHrSf7DeXh9WNFr1hY3RtEeDVMJ5/YLpQdSM3x43vMFmcfo6Ic+q0TxsjItfNCDj5psljQdb6Uny6+f5fUd8S6LfTZllpCDLc5RyWeax6k3RJdrQKYiAW3mskOpBeCBCa4U1ypG97/jXdPcWGdcgiPFPOvL8sSGAeSk933lRNGfdOx+EAdavf/xlCeunP8yISNKXq+TcShoD4xPplZWSa86Dk047KNqppTSnMwz0DHfx+wX4pZJb+CKTVl95dhZLt7fWOYtQBWF6HJJN+1XsfmabWuppcCe/iwkrHcYd27ZnwUYHOwuR0WVTRPg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KUiorCbcuzxu6CHVh3lBCsfgOfpEyDSxkjC88piSBcS0EcFJLk3Pr6TUneqtYpxga4UcOLbWYph+IOGtdTNtDjvdJSi+PHQ/DIYryg6fo8PEDyOZWaiGH/Is61KSOerO8lfT38Nw9aPIcZs6HYo+7+ZtqrLM6e9CRMAxWo9eXKtN333E3LYtgBIH45kd8Pcwapi9BojPF9/E4DJX6ev4Wf04J2UHue9owN4gkOLgsMcDDpMaBNZf98XIWpiVRWHPWh7TSSpEPWsu9C8IdodMcvhEFmJT5owDoLTuHjPCbuiF0BNHHa5ImVQSPtMB5WCox9cfUCOwDhphIpfC8l9uUQ031LyJuOKunrX3uZ9igtSuE+cGi/xZalYVh0VEzecYuQjgjN0ymWL6MKrJXWWj+9pOHU/UuLpyoEHN+7FY/oh/Zy332o3jt/BI0t8mwzju
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:56:34.8197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef35b07-5dfe-4f9f-9c3c-08df1281227d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

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

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  1 +
 arch/x86/include/asm/svm.h         | 12 ++++++--
 arch/x86/include/uapi/asm/svm.h    |  9 +++++-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 arch/x86/kvm/svm/sev.c             | 48 +++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c             |  7 +++++
 7 files changed, 75 insertions(+), 4 deletions(-)

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
index 5705723f1f41..edb99af4d6a6 100644
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
@@ -3083,6 +3097,30 @@ static const char * __init sev_str_feature_state(bool is_supported, bool is_usab
 	return is_supported ? is_usable ? "enabled" : "unusable" : "disabled";
 }
 
+static bool sev_esmtp_setup_wakeup_icr(void)
+{
+	unsigned int cpu, sibling;
+	bool wrmsr_success = true;
+
+	for_each_online_cpu(cpu) {
+		for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
+			u64 icr;
+			int ret;
+
+			if (sibling == cpu)
+				continue;
+
+			icr = (u64)per_cpu(x86_cpu_to_apicid, sibling) << 32;
+			icr |= LOCAL_TIMER_VECTOR & 0xff;
+			ret = wrmsrq_safe_on_cpu(cpu, MSR_AMD64_IDLE_WAKEUP_ICR, icr);
+			if (ret)
+				wrmsr_success = false;
+		}
+	}
+
+	return wrmsr_success;
+}
+
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
@@ -3259,6 +3297,10 @@ void __init sev_hardware_setup(void)
 
 	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+	if (sev_snp_enabled && cpu_feature_enabled(X86_FEATURE_AMD_ESMTP) &&
+	    sev_esmtp_setup_wakeup_icr())
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_ESMTP;
 }
 
 void sev_hardware_unsetup(void)
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
index 5d15c706e43b..a1d77ce041b7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3743,6 +3743,13 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return 0;
 	}
 
+	if (svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_RETRY ||
+	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_ILLSIB ||
+	    svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_TIMEOUT) {
+		cond_resched();
+		return 1;
+	}
+
 	if (exit_fastpath != EXIT_FASTPATH_NONE)
 		return 1;
 
-- 
2.43.0

