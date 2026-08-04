Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683445A2A1;
	Tue,  4 Aug 2026 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887917; cv=fail; b=D/IUmd0vmhSJ7COUHnpj/LqHQKipFea584D/mBCPkizQgcZJB8p35lCEQ5TdosNdBP9jd4cK5EGZLK3bvQrIgpOdu5Hq2NTw+dlZeGyBagd0qb5zcnOXlFxkOZFOfJ8k3se/pkn7oWaHYngX+Neyh6eoU22WuTN0fw0DEelSkdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887917; c=relaxed/simple;
	bh=D2BFSOKK+PS1S1uSPgp2sRifgd1j0o5B15LkN3eU5gU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKtgOZOwnBQoAvfB/n2G/Wbo3kkGO/8JPqPVn9G46gG+0ljI2gBL+vQRwMlYgedypOjE6DL1yZx11jc9fedlMbDbGWahxG/V7ns+FaP86W/ke4xgqAhRpmRN+jH8H4KZ5LBxN/pJ2EtHNVs0qF7BAfd4lODWTW1DT3gQvFmYAzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f7tGKu3q; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f7tGKu3q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiFJZPRRLq6MS5CgiNPfcQiKbWD2w64kzn7ZCQKbqlEtAkdMvgsPvLHZVl+3xbC+PWBhpNWrKcUYOp1kdamQ1mruyiRJU6lIkX4RIY0IKaCmf2qi+HoIzU1tKpnHcuSC7pkmwr6eXTMXzC17n9emgn/aUQBzd8UX1E0l02mAmEHiM75zhh/K350Jp2SPqeukeBMaomAoXIAqywh+RIII+d6oBXqdszi5QfyMzkXCmnCwfPB1uzV6T1zXiGfhvixtXux1YHnk03+CKTt+d5DEb+UrVV249fCYiw52Ea320KKhgIsbBWws+9pQrJVsRGMoZPFqj8/1LD8L55xMnUNwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agKBAIkdcUX1mAByCSYZCZkvQllQ6CnkomtPJKlO2CQ=;
 b=HEEnfvyaXkGOX8cHspY3Z9TZjrHP3v3TPY88puvU0YFRu1OKB3pDFVdQ63uMcxIMxaEFAIezMvQ0XtWGzG3hABAwXGHe5c9QHxSGa4EReKtDeJwv2PB0mvUX6n7o5cbZi011nHdjugrufAQ+AYUgx+jZ7fJoiu6kkJD0w1Fs3M/765mGQNJWCTWZoqDOMw8p6iugKHrd5nORH7pwMrv0AGZ8fcDJrfqRLwnafyl466qMuX/gQxJSM1guI/Bmi1be5d5jtywS9SpG0k4HqzWfweSQPCuOxRh8LN6YGvnssJqBglWw7yOwxLUak5SLMiDnYGEamIvmFBS6oH9cYzZmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agKBAIkdcUX1mAByCSYZCZkvQllQ6CnkomtPJKlO2CQ=;
 b=f7tGKu3q5O0OuTV2gAgnb20jbnq8Scf2OUkPHJ+PVAiajigyugDwmew+yOAdCUsTMe6ABb5gb6qerC6zdJikdQnaOrBze6Xyjy18r1OBcpFSPqUogUMglOykcLIzDa57Dp56JmNCaQJos45+xiB33CTmbXw3frG4linMKVmrRpk=
Received: from BLAPR03CA0179.namprd03.prod.outlook.com (2603:10b6:208:32f::33)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 23:58:30 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::36) by BLAPR03CA0179.outlook.office365.com
 (2603:10b6:208:32f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 23:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:58:29 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:58:28 -0500
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
Subject: [PATCH v4 09/10] KVM: SEV: Add support for IBPB-on-Entry
Date: Tue, 4 Aug 2026 18:56:10 -0500
Message-ID: <20260804235611.4053375-10-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: a333bb30-839e-4d4f-1475-08def284488d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|13003099007|6133799003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aiS/h43VtTUpf/hhklQt/FdSyEkQKVKmUQn3ZE81b+JLhuwwTs6yQOTKVu5BxBDBXWZT8/QONcfX/QzZlO7MGofF7JzIrkEEkfTAqIEHVLvHNC/+rMHmcOu6DR4KkwXdVbEWghxiuUfOJk1wF7MBCK8rvyOmuWMve8IbG7NtxhOrlHl3V0N7+/Mo99+tjSA78Jd90aZ0nTJfReTvDhJeJVkmhn2bNUsCXq5CHeTTbMx+BE5eFymZzC7nIDYWdhHI67Teq4FFw5Kr0FCGK4Xf4NGIeIZ5Vgx9RQZiM/bEVX9lapah5SoaNSFz4By9/CdiYLrOf14fEHqgSDJSOp+6j/hrbD9+csm8frmGzteowt4uLJwItuwyFuxH5PvEFb+ZUzH/PgmJ2OamtvH5YJaEuJHXAuXM8RQnUTcN/hgI+goX8DSW/JtCciEh/LYVc5Jnw9vTC+qKpE3JufNhqZCFF3owFL062dRxteh7bbtimxWNL1kR/tBFTBRKS6sxCHCY6sDZmX4Dpo2Sgy13UX35rhW50iZ6brPAHZ9UTApSB+WwLj4E9GZqM4IT0Q6LspwdmriXXOfYc8X3Ev8tSE+2tk+RuI3AzJbA2I9OsbMJ1tZhscpd/SVOycl1Lv7dgODDazhzO4v5LSC0zDDOOksBQjVC33HZ2GSls9fNtWzfdks=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(13003099007)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+YS5CQZAwuJAvKbloEFx7XhaXFby3lWshY5KOClQt3+qagyi1z/xyr6osl8cq4pRGmcMRoBjsptXfTPnPyYd1LMM97AxuFjxsPIGEampgSM7HxYS47iFloY7Xc2yJsTIV7Ho7RTCAFNP1aVrD0VCzm2kwzDbtgd3L+SOsdD8YP6PLMnUMvljKGWR1NWd75jF2p4FqNpCqMIdNHiHnCCpk4U12qiyiJvWzwuKIx/2egEFbOZwi1C9o57YEp6umnt5O6dMG67bXix13msSchubQFsq7XWRq+CikRcnFH74U6f7MY9siTuSa18d4Z8GFYNgDfuzgl0Mzc7xj8Z9ZngBX5Q3J2d88UlmGu2y+SRm25WeZEzuG46HsxbSTiV3TIXM/Z/YWMNBkfsi9tcTgh2QpnYD8yGZcWXi1kx+I/kbiSeKv2S2AOt+hX86QSZWfbU/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:58:29.9534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a333bb30-839e-4d4f-1475-08def284488d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

AMD EPYC 5th generation and above processors support IBPB-on-Entry
for SNP guests.  By invoking an Indirect Branch Prediction Barrier
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
index 3d0940a3b9f3..11e40644b967 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -460,6 +460,7 @@
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
index 6baf458383f4..85a692840886 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3224,6 +3224,9 @@ void __init sev_hardware_setup(void)
 
 		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+		if (cpu_feature_enabled(X86_FEATURE_SNP_IBPB_ON_ENTRY))
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_IBPB_ON_ENTRY;
 	}
 }
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 3d0940a3b9f3..11e40644b967 100644
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
index 2e016cae4ebe..ff4322a940c6 100644
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

