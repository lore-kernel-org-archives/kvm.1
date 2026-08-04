Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA514582F0;
	Tue,  4 Aug 2026 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887888; cv=fail; b=g+7o/JsD+2pEIR5qNvMHBmCG9X/xgAMd0BzqU0PG8BjOp+NvRRChtSWxMXNK68ny0JcTknlSOsPhtS+DbiovQN8dbGrT15oZON5zv1boNiR4CuFGeCuFUMD3LFqpw1jGzev3V33rCB6BzSh2ihMyfkmbX69hD85Jh+IE1szpY4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887888; c=relaxed/simple;
	bh=N7WwLBVLHuFhxyWgcB3UkZzCthwmdVPsSeb7LD6rxfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBVr92CyKQdcSxEbZIyxdqWP1RN6vOeGUs4xwx0ij2xedv6bBkZ6nCs+SBvcMtT2jMNLM+5zkmuIfb17j4df3zuwArrrjqnsfX/CpkummrCQRQgLXjrfAqsvnagUYXN4lHeiOcFON5XKcgyrcQX9H5O+aaJSttNCaCbLPxzfwio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jf1BxtIV; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jf1BxtIV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuL3FLEPVOGc/t7sbyN2sVxf5oaZ6C62Vi3zDjN62xRGcvCsL5tWdD2Sae71IFzKYs2Dwa2WI3s3yRBWIRtRDdo5SjKd9sTeacghiT7FyfUD0CusTDKVUO4s+9ZC1h1JtulqIfkWYldiwjD9IOj2L+muEqoRQzRfiPmoSbviUO7L3cq6SNrdS2MawWJJPdlk5VYfYbY29ltk1b/IF1khECCsqm+tHRxP36ueRyaWCgXyA30r+qnhgS2cyDTb+jppNSDNfv9IidnJ3gYPplwZ0ks5EbhIf31xmrpymR2C020oKEB4qa4GmIWf+oeWGcSpu883C68HCHJiMR3RqSwMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zUpMl9p5En0H7ADzo2SxrC/oJnoDzDsT42KG3D+4bY=;
 b=yhyfJgNkHIvH4Dsje3IdyQIN/yb0ni5YYMHvedgeDS1v2Pt/7KKALmT55A1WXZUt1eWr+2MAC0GcF3mLTEqY9wZf4X2HmtLQLYaDo1LKs0HXVIs8aSdx3WG5OliTI2lTHK3VErxn1RKVTF8yGHSrzl6ntYq+PTwv+tvk92THR1CIWn/xHUMhw6DDJQF70FxPkHoihwe62fz0VCCA/DeCMcSE/WG2jFIQSJeqXYX0gI7VyOte+PDuD8/eLWSVvDfTvzVcW1t0DBCl6Z4Lx1OfhNNFznN7dPKb/b+Gx0YJa3vUq9w9nMBcKcNY+TuWYRnD+lDwhJvK0gKx/+hTDVK7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zUpMl9p5En0H7ADzo2SxrC/oJnoDzDsT42KG3D+4bY=;
 b=jf1BxtIVkjUAjEAJu4dwmoNT7km281ktq9jJuK8Nu4ocRJrAIVS5XKyAMwQPKhR+CcCsOmwZ5BcxTx/DSSq32Po3JBVPHqUW8JIyaxDJSgPDYJ7y8QYOnuO3d/Yr3nRJLDrBz5bxnNT9K9NfhdcT1w8vF8AKhkF0NXDkEwQ4dFc=
Received: from BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::35)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 23:58:02 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::25) by BL1P222CA0030.outlook.office365.com
 (2603:10b6:208:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 23:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:58:02 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:58:01 -0500
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
Subject: [PATCH v4 07/10] KVM: SEV: Disallow setting SNP-only features for non-SNP guests via a single mask
Date: Tue, 4 Aug 2026 18:56:08 -0500
Message-ID: <20260804235611.4053375-8-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5668d252-c91e-49cf-e283-08def284380c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|6133799003|18002099003|56012099006|11063799006|5023799004|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info:
	d2CQuBJ817x94BC3bb1RH9Ro4CyRNAXyz9Otr7UfZMW8AMrJkqi/dZlhrEblxxq6RegxyZBK2BDUIi5GPs3AnN+mwfJp5R4Kx7p5Ic0HO0bOtE8BSyvmyx+/BRwpGia220W7d84oO3hsPRQobfV9mH8XOlIzrjt0QuexsgrIprG0eDRmldXfomvu9+kAFxt2jyK9tdoDNaZ+PpWOYsqwd5NfDrBMYL4azh8y3EjdtSemuBpngtcL1eb424LWmhSwFRWByAPZ4VpnQAKhWsRxIHG+8nDDrScGuSDbjHu/SvBmzJNqs7LaAPcev8CoCMtmuSPW+FEMFkcBO8DtNelMMKbrPoKjvyBwW2BlGwpU7gwxqjMRdtzRUhKORru388mXWxV1jDsevwzTOtZifW54+d1V3jVRnufbtr2MDMpP9Hy7qAvWRWYBV28xhbCgOe1Th21AlmaWISr2czdD0p+D/EDwhmzwgxTFoOnstSd3MFU6WPRm+1v7qZ42gFdgCGnzpn4+Sw+arZ5L7mxHwsIPwHx2qQj55+I4g69MuSwyoifkwTD1RlpMDQjT6gPq0bVBcjhvxjgupVKoAktlASKW0XGKNJKW7JmFYZZI1laYyT8SNwpbhu397Yu9ac6H6AWQDGjf5zDKr6jpAdXB8i5QMBUBoJxNzAqWNSVEH2vU3cZqAO+1STIefdTeIXioPmPKQEp/U9we6v+VoyRHd9cCOg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004)(13003099007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t4p27OEq2MvgPtPVRAXYQ7KYftYZM6rtRLe3KBE5t3aGJrKd78yF39EFy+TvwOTDI5Kx8XsR+oPBvFlZaKhZGquabKG2dz1SsJu4ex0IUPOLKEAlrydRmU5ClRrcf3K+tPrh+4v8kfZfOYpoVCDeMM9U7cmarqi+81VVZsF4VCJe1uh9G5QOCopwMZoaRIfdwcM6P8V5cxkqzUA/0385RynY1Ez9XDKw4WfXAn4TKOa2hPY4c/y+qsr+x3ylaESnbPOFnBHiG4D3vK7XL3NDJ6FPGMzsyL15mzh7OaMkIXZOImwTJ5TNbrbJixN/ggfyS/CWO5FuXjGnDvY35WmJ4QAlos8PIme+gXe1YuOH1AGA04Ofv8ltgHEyysYtNGgE1XD7ptMMLdqE8K2UoR+NuIOk/M3suJKrDp0EsoIN2xMW51cpldCVYuajhjwQKf3Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:58:02.2735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5668d252-c91e-49cf-e283-08def284380c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

As SNP-only features get added, adding them to the valid_vmsa_features mask
in __sev_guest_init() often gets neglected.  Add SVM_SEV_FEAT_SNP_ONLY_MASK
to help group these common features together.

Also establish SNP_ONLY_FEATURES in the sev_init2 selftest as the
corresponding mask for features that must be rejected for non-SNP guests,
populate it with SVM_SEV_FEAT_SECURE_TSC, and exercise the rejection path
by masking those bits out of the features passed for SEV-ES guests.  Define
the selftest's SNP_ONLY_FEATURES as ULL so future bits can use BIT_ULL()
there without truncation against the u64 supported_vmsa_features.

Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/kvm/aaWog_UjW-M3412C@google.com/
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/include/asm/svm.h                        |  2 ++
 arch/x86/kvm/svm/sev.c                            |  2 +-
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 12 +++++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 52c900bf7e20..a206a0ed2c58 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -311,6 +311,8 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT_ULL(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT_ULL(9)
 
+#define SVM_SEV_FEAT_SNP_ONLY_MASK			(SVM_SEV_FEAT_SECURE_TSC)
+
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
 struct vmcb_seg {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 944aaea6501f..951f0e6be9e5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -504,7 +504,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		return -EINVAL;
 
 	if (!snp_active)
-		valid_vmsa_features &= ~SVM_SEV_FEAT_SECURE_TSC;
+		valid_vmsa_features &= ~SVM_SEV_FEAT_SNP_ONLY_MASK;
 
 	if (data->vmsa_features & ~valid_vmsa_features)
 		return -EINVAL;
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 7b0643bf7ca1..5f4032239f7f 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -14,16 +14,18 @@
 #include "kselftest.h"
 
 #define SVM_SEV_FEAT_DEBUG_SWAP		BIT_ULL(5)
+#define SVM_SEV_FEAT_SECURE_TSC		BIT_ULL(9)
+
+/* Features valid only for SNP guests, rejected for SEV-ES and below. */
+#define SNP_ONLY_FEATURES		(SVM_SEV_FEAT_SECURE_TSC)
 
 /*
  * Some features may have hidden dependencies, or may only work
  * for certain VM types.  Err on the side of safety and don't
  * expect that all supported features can be passed one by one
  * to KVM_SEV_INIT2.
- *
- * (Well, right now there's only one...)
  */
-#define KNOWN_FEATURES SVM_SEV_FEAT_DEBUG_SWAP
+#define KNOWN_FEATURES		(SVM_SEV_FEAT_DEBUG_SWAP | SNP_ONLY_FEATURES)
 
 int kvm_fd;
 u64 supported_vmsa_features;
@@ -112,7 +114,7 @@ void test_features(u32 vm_type, u64 supported_features)
 		if (!(supported_features & BIT_ULL(i)))
 			test_init2_invalid(vm_type,
 				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) },
-				"unknown feature");
+				"unknown or unsupported feature for VM type");
 		else if (KNOWN_FEATURES & BIT_ULL(i))
 			test_init2(vm_type,
 				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) });
@@ -161,7 +163,7 @@ int main(int argc, char *argv[])
 
 	test_features(KVM_X86_SEV_VM, 0);
 	if (have_sev_es)
-		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features);
+		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features & ~SNP_ONLY_FEATURES);
 	if (have_snp)
 		test_features(KVM_X86_SNP_VM, supported_vmsa_features);
 
-- 
2.43.0

