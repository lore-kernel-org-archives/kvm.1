Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2B40C5C0;
	Wed, 26 Aug 2026 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783829; cv=fail; b=VNoQhVSx8yEltcTtVw1W5hKr4v46Nswe5nsQ+DdcP1H0/52lAOPoiDyylbyJQIrQrmIM6CE1I6Anh2/8cT18/s55edEcCSITOm3Z7bSJeGMux89iix8pTOhaR0SnpGIYbZaiPmfAeK3XPPtQ9FHA2zcG22R5YRL969ZE6LU2XPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783829; c=relaxed/simple;
	bh=Dm9IUn+69u8PYBpjkKZi/pGOncuJ1Md9ZP9WaYsFMzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDU5yII9wvJ+Voc8Yfo+rowcanKhNaQ8oo2CIBQx6+zg98rO8Wv1VNpdSDxGDFmQqNMH2vJblnrnj/gSIkAt97kBzsLSS0YpPWcRUYPqc2B47CFnUqrdHRl3vijHUd8lR1j7JigKmzu4o44yz6vExlvUMfCt4cPlK3/F0z9ju/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Syiyhjjl; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Syiyhjjl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1z3UN0wDycltHzMlLnpuWH6aElkBQDALfWmqB76hMhUUnrTyZXVmLY7BVEjppOAdeYl68ezvk39rmP7t7Cw5zPlpqknjYSz3tz0VHfCQ3fYYmlILfbfqdqpZsjrzy+C86Cv+k+kh3Z/DaUwydZV3cLrEE0CuWQaI/y0A1eADBuZ1VZW+4wNB9ShX05QNCLWr6H0qQNQ7ujiPLo3TDyo5DuGDY8rZCT0Y7R/RI4c4MtH+m5D5mHjP+V/4NV5WzOQEvxD1vu2VhSART3wWnijr/jdgKsgwEsZBkp9vK1KQcvSUeuYgWG2EvDAnvW8ejRUBr6EPwUd6TtYyTb/NUjoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s84QPhetN/pr1206/GW+mpXaSGe7qTDGkkQ+USrIh8k=;
 b=pGu2HCkajor28PirfK84RpL5HOzJ9dALFSbBdgqiYoHbvpYh7+bjsg9jTpauNMmP6Tty3VufEOq4ule8//SidZmRAUQGAPC85fuAFaqUFZ5knf3ZEDWnLu8NLqdyW8TQFUKa8Ucy4pwIH4YjzYZ8dtWUZS+jWjre6kShVajGYYN7DCU1KyDFCyLFwEh4SHeG/pIOchyEorFctvwKBiK0WUIssJSabHY3+7OypcqtmgyqiCl0savf3/OH2HxfbCVCpIKR+oKRJMuVgGRnoSA5396NKsiDxS2UzPuqie/tBtIt50c59uGfOZy9VgbGbON04SQ0MEC3v3c0Ch/tUFdk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s84QPhetN/pr1206/GW+mpXaSGe7qTDGkkQ+USrIh8k=;
 b=Syiyhjjlo5OtG0VDJFrJi7EmveZhxA5NA6AflO/n+PZ95mB/Jvih2ex53MogTtsqa9/ZwXcakLw5k9aVmQk1CMrS604ciLA5uuur3Yv1pmGb27prFtiBdpTeg5wlUyFmhYX1H2eFkah4Ks+7UKYYyptbOlyXD1wnSdbb/KMwh2Y=
Received: from MN2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:208:23b::9)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 22:36:59 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::4d) by MN2PR11CA0004.outlook.office365.com
 (2603:10b6:208:23b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 22:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:36:59 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:36:57 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>, Nathan Fontenot <nathan.fontenot@amd.com>
Subject: [PATCH v5 7/8] KVM: SEV: Add support for IBPB-on-Entry
Date: Wed, 26 Aug 2026 17:35:09 -0500
Message-ID: <20260826223510.3669875-8-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826223510.3669875-1-kim.phillips@amd.com>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3b7632-6408-4e26-f9dc-08df03c28abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|5023799004|11063799006|56012099006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	AnPCnBwB8ByEyUdEqikcrc7Qd3a7AOvIPw8YKgwA1sXB4NyWXgz8wpQ1pH5plA8N+G92SjZ7rdQ5Bdx2wlm9VjitTbCXLFvOAuXFpUwyfZyNhI+myOvlVqPUd+vwHwc4CbzTbtQwH61SI5iFSQTgxK1SD8bzsKmicwladAfvA58lRtNncrvfFMTZJYVskk/DiOigGa1kFUsX26bEpJJJS5qklSVemfV/cJZrH7pd2ba9Qi3ApZJ+CX7+FPc4bZuBo4dl+tWyPUar591RgEJpT3EcSRXKRrQa2a0gVLRPLYUP7L5iM1E7V2YTXN4e3dH4jOKwPq4XxnGf79glhaQkGE/hU/Ex5vKhPvN5XVKK+2ytkol2/FxeMP9I/n+mHiChRpvG4PRxx6AxQZr7v/a7wpaJLJlbgwY/gthZuCEbze/sZWzPGCFGxW/P0uDrS2/uB0wtHkjf7LAwooeIuFO2Lkf8obhBz8GVvlnwh+oMgo74gi2HoBVE6wM5CGZuRjGunqmlZV6UZQoZ03zZMzLFzefTgSplDPyz2x8jfejogEnKZN1VJ97wC9x8ep49DD99/1b3lcKApWTAfsb74q/UjYOS1NEybUlfPGDevaaML7yZReLyTEA7FLKpl1mRvnlgom09l1WBNTjCSVy20dg0tBm5zrrrRp1cwKXFcgCtLHd4B5npaUszk95g/ICmB6p4jOboN2+pMsuNJt1URCu/nA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VhbDgCQRAbO8UApbItpMcOp1MPIewxaSHOOyUnTpTSntU9huPkeD1XlRlJVWcWaPX8l2CghJjrO18mkxtc7yrYQqvD2a1g8YJ3mGdKUR/XeklPBminEu2McjYBPRalSLIHOmiRlWDMQ73AHkssEwW4/fFQ9UgGSyMi9vRajU5yz40W2IMy8scaIU6PyyXAQ4BM5+/0KIQ+LigIkUCB3RvrnvrSFePBGapfxJf7ZDmdSfINg/RKUdt9Mpdf/zloR4yMApgyTiHli4F3R6PwIindVvPQqpFmKwzELtNAdPxdJt+hht2vG2wDlzDHy85eXkg38DmGAaH3CR99cjwpkifg+tvbn4AkMduL+FEkxGuIxYkAPljjWOX3BfPchTn4R2+T5+zLuh+WWvFxJJ5SPvRvXdKh8Spl/nTOrUczDRKIcvAEyJeVO+Lw0voSOsdPJD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:36:59.4530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3b7632-6408-4e26-f9dc-08df03c28abf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

AMD EPYC 5th generation and above processors support IBPB-on-Entry
for SNP guests, while 3rd and 4th generation processors can via
microcode patches.  By invoking an Indirect Branch Prediction Barrier
(IBPB) on VMRUN, old indirect branch predictions are prevented
from influencing indirect branches within the guest.

SNP guests may choose to enable IBPB-on-Entry by setting
SEV_FEATURES bit 21 (IbpbOnEntry).

Host support for IBPB on Entry is indicated by CPUID
Fn8000_001F_EAX[IbpbOnEntry], bit 31.

If supported, indicate support for IBPB on Entry in
sev_supported_vmsa_features bit 21 (IbpbOnEntry).

Also add SVM_SEV_FEAT_IBPB_ON_ENTRY to the sev_init2 selftest's
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
 arch/x86/include/asm/cpufeatures.h                | 1 +
 arch/x86/include/asm/svm.h                        | 4 +++-
 arch/x86/kvm/svm/sev.c                            | 3 +++
 tools/arch/x86/include/asm/cpufeatures.h          | 1 +
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 4 +++-
 5 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f70ee74b5f92..3aad2b53f59b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -472,6 +472,7 @@
 #define X86_FEATURE_ALLOWED_SEV_FEATURES (19*32+27) /* Allowed SEV Features */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 #define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */
+#define X86_FEATURE_SNP_IBPB_ON_ENTRY	(19*32+31) /* SEV-SNP IBPB on VM Entry */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index facabba26a91..9d8107824d10 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -310,9 +310,11 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT_ULL(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT_ULL(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT_ULL(9)
+#define SVM_SEV_FEAT_IBPB_ON_ENTRY			BIT_ULL(21)
 
 #define SVM_SEV_FEAT_SNP_ONLY_MASK	(SVM_SEV_FEAT_SNP_ACTIVE | \
-					 SVM_SEV_FEAT_SECURE_TSC)
+					 SVM_SEV_FEAT_SECURE_TSC | \
+					 SVM_SEV_FEAT_IBPB_ON_ENTRY)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6cfb7496415e..20a761cf3491 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3262,6 +3262,9 @@ void __init sev_hardware_setup(void)
 
 		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+		if (cpu_feature_enabled(X86_FEATURE_SNP_IBPB_ON_ENTRY))
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_IBPB_ON_ENTRY;
 	}
 }
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 6547c0aee45b..634cd09366da 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -460,6 +460,7 @@
 #define X86_FEATURE_ALLOWED_SEV_FEATURES (19*32+27) /* Allowed SEV Features */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 #define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */
+#define X86_FEATURE_SNP_IBPB_ON_ENTRY	(19*32+31) /* SEV-SNP IBPB on VM Entry */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index d70482e07141..f2f97dca3935 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -16,10 +16,12 @@
 #define SVM_SEV_FEAT_SNP_ACTIVE		BIT_ULL(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP		BIT_ULL(5)
 #define SVM_SEV_FEAT_SECURE_TSC		BIT_ULL(9)
+#define SVM_SEV_FEAT_IBPB_ON_ENTRY	BIT_ULL(21)
 
 /* Features valid only for SNP guests, rejected for SEV-ES and below. */
 #define SNP_ONLY_FEATURES		(SVM_SEV_FEAT_SNP_ACTIVE | \
-					 SVM_SEV_FEAT_SECURE_TSC)
+					 SVM_SEV_FEAT_SECURE_TSC | \
+					 SVM_SEV_FEAT_IBPB_ON_ENTRY)
 
 /*
  * Some features may have hidden dependencies, or may only work
-- 
2.43.0

