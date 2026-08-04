Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A446C82C;
	Tue,  4 Aug 2026 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887929; cv=fail; b=nFSZ2989ftJycMZmp6bwRL8D4xQEuPz0JfrS5+kVS25ucyX7TCvQSbVcv6dr16rFsPgaR3zwJnF0Ybrg88lj4NoH71JwsgZMBV3hbeHUFej49hMjeKNXbhbb3LIA1GP0mr3zAljcnXhotQV72NXMcmVCCYfml7hitErxm/Axtos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887929; c=relaxed/simple;
	bh=H/dQG4vl+rW9sRAyyYQtemULJ8k11lUDSzpbzo9mrlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOokObuj6pI/2KLm7KSbOlXXQ58dtjXDYW9xMe0/TT48dGJHjX0RTlX5CifiC90vXkHQ9R7ODaRRLw8BeH6ImZzHu2TyLwzXoLj4hH9KRdLE8YQ4I1u61ky0meMJ+B91s+0HrOwjscNFusCzulLCxWLz4RD/pe6Y7FUBpya30Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wKZrseyl; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wKZrseyl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJo47cmQrp8ElH2nains7Gc1aCHm5cT+00SCecXJlIXL5xD8xBiHpkbq3x3KHW8x40nfWH4QagWqFg9OmazgYeRi5TyTWQgI0qjM+RDBnS2wUnxSTsShjOuql4M6exEoTkFhY7QOBywROIKLT/sE/wDxgFfGxDzbWaQYExJYug9LIe3x+4HkM2Y6b4QM8HZfpICZlfSHjzxTP2Xpb9AzgRr4meavRuYGk3Ft0YDLKjme0B491OMvuHfV+9pUNHesnhJol7LTGM0YSdsqqRbOXhG20B7cX6nmV3eFG3THGSmoynqpX8csw8swvVvozuhs5Iti+FMa2btW5El3GDpaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEOPtcs43LcolZkGd56P6R+xK46bFqS7t9QZ7qusE6M=;
 b=j2kUuIUdDf3rFYZhYinyzDPP/fY59B62fzkNwpok/Ac+oWaXjX+YjskYHY4EuGHfaXnLTfgXPin8aTlnmiVK4F21wf7Qy3+1XfOZ0qbvfR4q69mO16km0vETjc78K34tLSf9K3W2gQ1vT4C6yoft5x5uWd/dwsOtU/aNo4Nvy3XPR0IntwRrdd/mgo40rhDnrTGr7oiTuxOzXxoQiHXw/VnC/Jfy5uK911JUViLc8EQUyx3rgv+Gq2NLYBkPCkxZPZIbQpcHwVkVkzkQHrMYFtuYKvPtB0SoVgRpPM8iMsfKUA2Mtz5VMkRQaXnu32/nbDmmvRc3AUSCoqLYe2KpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEOPtcs43LcolZkGd56P6R+xK46bFqS7t9QZ7qusE6M=;
 b=wKZrseyl9+ZNJ1tHOi38ANxemyWoRu+dVSAoWMuXQ5bTCzhqMNUIwsugCUtro+U757Qmzt2u1/3a6RB5WgkwU7v5w1mK8EUC8ikdW59wHLqTrrULymYBflOJJfskAMrC5VXKqfsIQVKlQ0xOn2t6GgfbUC0fXcypTMKpZ1+91y0=
Received: from BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::6)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 23:58:41 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::24) by BL1P222CA0001.outlook.office365.com
 (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 23:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:58:41 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:58:40 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>
Subject: [PATCH v4 10/10] KVM: SEV: Add support for SNP BTB Isolation
Date: Tue, 4 Aug 2026 18:56:11 -0500
Message-ID: <20260804235611.4053375-11-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804235611.4053375-1-kim.phillips@amd.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6712bfc7-fb64-42a0-fc67-08def2844f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|13003099007|3023799007|6133799003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C+87YGtamE73bWtu/ZItCDy/B/NImjhrGLYB6UNglJ+4TuWaicZ7Vag+Y7JJNbp3IKgcWXcJLxFRjDvDwaS5Nd+LA14tzQBwxG5DY88cHcuqHFeGSy6+OIxfQo/jtivcIuVTPcietfwS/PrwzPSDm853n1gUyfbrUt8toz8YiDzJnYFVLzHeOGCdvI5QY0LoUnhwCyTwzaArnxypshuPmvCK92NTjC4490lytyyyuVWRrfLeZC+G3HG46f94TcR6akmDAC3c1yVGqqzkDrssCYKK64vyCQt2XBUTJTr7TaCBhFMzFwSu+vQtMnXzPTsBDOD4KXVn5f4XPbbgtI5NfEzfuoiwOi+jhY6req1GuOQPqm8lfv6sptRUVlCKG9LD4LXy/mNJFeSSxeyB8a/mA1hOSQtrotPvH2k6Rz/NRX1VP34ES1vuHy+yPHJRv7NSoBs1xkKjHUoET0ZtYrRq11xFAB4qIyV/95rEy86pbPkDkILMe6fHzOk9CjQop2a+hD9Y3NaKFvnsbhh9+qq7oAUD77GPUtZpbdPfgKLNK63EMrn9RmIBvmLs7dheB/ME29xBJia6HAgXhGbQusPJet9hPebpPXPWT5JMGsDD9hZENAqHggZMolG0ayQqiadvUeeDzngG7HV3weC+VcyGew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(13003099007)(3023799007)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Xbzc6ipmo1RX03vy4l+Rgcf+OiFyJShnTlhqtcb4hYso4NMpek/J52X18Ewy7a8X2NEnAwsgAcz2vGFvFWO13xzWCvI3XDsEIvpYG7u19bl4OoK5hMPQkiVEr7SM6TefruxadXijBEm/gIz0w0byQ1yrokcnjEsh3Xy53UO3c/RVAEaWe6LpdXYa7pbn5T5MQsT0VgknwMkBBXHAQElyIalm4+y4WDskRELEnqXLtv5jooOlrBocLY54GRheWCPeBErGwV6ChmgMsmeGoBDNO0AaHyNSfzCAUYsnirdiaGEvy9GBAPiNr8DZuPA4B0DZqmKS5G03XIi8dr2UWiMsaGWOQ6CwD4DODlTNW7CGCZhJwl2kgo39Gmu+LfYpRJD9tJa/7weiJlhf/6BhugrRMrraeKBmdwWYbmLaHZAsRuO1ZV8XeJZQpH8yr3fKBqJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:58:41.2917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712bfc7-fb64-42a0-fc67-08def2844f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

Advertise support for BTB Isolation via SEV_VMSA_FEATURES when SNP is
enabled.  BTB Isolation is an optional feature that can be enabled by the
guest to ensure its guest Branch Target Buffers (BTBs) are not affected
by any context outside that guest.

SNP-active guests may choose to enable the Branch Target Buffer
Isolation mode through SEV_FEATURES bit 7 (BTBIsolation).

Unlike the sibling features advertised here (Secure TSC, IBPB-on-Entry),
BTB Isolation is advertised unconditionally.  This is deliberate, not an
oversight: the AMD64 APM (Vol. 2, Section 15.36.17 "Side-Channel
Protection") defines BTB Isolation as architecturally present on every
SEV-SNP-capable processor.  There is therefore no host enumeration bit
for it (no CPUID leaf or MSR capability), by design -- unlike
IBPB-on-Entry, whose host support is enumerated via
CPUID Fn8000_001F[IbpbOnEntry] bit 31 precisely because it is not
universal.  A per-feature host gate is thus neither possible nor
meaningful; if SNP is supported, BTB Isolation is present.

Also add SVM_SEV_FEAT_BTB_ISOLATION to the sev_init2 selftest's
SNP_ONLY_FEATURES and KNOWN_FEATURES to validate it is accepted
for SNP guests and rejected for SEV-ES.

For more info, refer to page 615, Section 15.36.17 "Side-Channel
Protection", AMD64 Architecture Programmer's Manual Volume 2: System
Programming Part 2, Pub. 24593 Rev. 3.42 - March 2024 (see Link).

Link: https://bugzilla.kernel.org/attachment.cgi?id=306250
Cc: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/include/asm/svm.h                        | 2 ++
 arch/x86/kvm/svm/sev.c                            | 7 ++++++-
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 9d8107824d10..0da2234b71c6 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -309,10 +309,12 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT_ULL(3)
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT_ULL(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT_ULL(5)
+#define SVM_SEV_FEAT_BTB_ISOLATION			BIT_ULL(7)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT_ULL(9)
 #define SVM_SEV_FEAT_IBPB_ON_ENTRY			BIT_ULL(21)
 
 #define SVM_SEV_FEAT_SNP_ONLY_MASK	(SVM_SEV_FEAT_SNP_ACTIVE | \
+					 SVM_SEV_FEAT_BTB_ISOLATION | \
 					 SVM_SEV_FEAT_SECURE_TSC | \
 					 SVM_SEV_FEAT_IBPB_ON_ENTRY)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 85a692840886..ee14795a20bd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3220,7 +3220,12 @@ void __init sev_hardware_setup(void)
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
 
 	if (sev_snp_enabled) {
-		sev_supported_vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
+		/*
+		 * Some SNP-only features such as BTB Isolation are
+		 * available on all systems that support SNP.
+		 */
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE |
+					       SVM_SEV_FEAT_BTB_ISOLATION;
 
 		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index ff4322a940c6..cf21bfffacb6 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -15,11 +15,13 @@
 
 #define SVM_SEV_FEAT_SNP_ACTIVE		BIT_ULL(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP		BIT_ULL(5)
+#define SVM_SEV_FEAT_BTB_ISOLATION	BIT_ULL(7)
 #define SVM_SEV_FEAT_SECURE_TSC		BIT_ULL(9)
 #define SVM_SEV_FEAT_IBPB_ON_ENTRY	BIT_ULL(21)
 
 /* Features valid only for SNP guests, rejected for SEV-ES and below. */
 #define SNP_ONLY_FEATURES		(SVM_SEV_FEAT_SNP_ACTIVE | \
+					 SVM_SEV_FEAT_BTB_ISOLATION | \
 					 SVM_SEV_FEAT_SECURE_TSC | \
 					 SVM_SEV_FEAT_IBPB_ON_ENTRY)
 
-- 
2.43.0

