Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C54582F0;
	Tue,  4 Aug 2026 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887907; cv=fail; b=WchNZBvUWtXq26KUBK2dqmNUieI1dc1Gh86QMSKHfslJ7XroFPJKSq5g0J+Rt/ULAkvSxpfuWKD4sxz5GJstoVJXNcrZqXJ0QtvsOvzClkqqJCXVzxqYpr7SppvsqOhpx3SvauxLhxXUP72dv7zeSN55YUfI7IMXQSqFdmDiMfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887907; c=relaxed/simple;
	bh=JqWCvw6n1PXq0ecDyD/mlJcp57yfGaJpJZzltBJnM0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMCHbAcgcAaRyreHhEMtug5YxJG+fVyDl184hen1va3oITUyf7Ya948ZqsrqPTa+Vhtyk/0gXRICW93+K/7ZOMq1UmM8EXCT8vI16ZhTR8L2kGaInwQGhC10GxgD2LbHhCK5jvv7uCT5bCges+mWy5+tCoVRVoOF3RutbSlrEcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5mU3h7EO; arc=fail smtp.client-ip=52.101.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5mU3h7EO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSHSNucMrg7kfmPC8UC5974pgYpYcVrhHW2SFx+YkLfqZ70WPVHiXp4w6ehimPoWFEeu3t+IeREHLmiXzP97RiBaHgz+AwKEu1aInBmPvOskh0OxHbHG9I3oQLgPlxpkwU8B6OnpB+0qFKSXvyyK9AVX2xUnEv8CHaAQYoMM7+bkB2Q/JJpKTylqxHjSOLUQvSJeicIRcoAqpl9y/BNaIe7fpDZNPuxYmX9otXqCQ6c1rQRfBI4f6EX5ThCcfQXq40KKY5m/9kUqrB/9Akp0i02SouST72t9YJ/ey6rPwHIzJnj21VurDXt33/JdVNWJ2cHKsOO52OUKcj8oY/vNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yUNlP56oYRLa/AYEo+qJ09/sa+osMtl8RYNNaGWUpc=;
 b=OCusul1aIAPK9XqwH9Cb6cktpK90gDrGdNDQcjDQqFswPaBMdbjCGjexxv0HE72udsAAACwLBZAfRoNx2eBz0Fxd/AUUgKpKUEBuAYQei8BZnLGopH/3sW1bc9QcJHNR3qcUja03WhWi8hmKKj+OBU/8hyITNF0Q/P8xXiTDdnVZv1bY9NwUfSF7sWIgz8zAd3OvYXs1VyhIjk7syDI/2qwkMw5Vp4kfKoTobQXIhhGQILOzslJJRbNN7dguqT6lqJY0Y4QRvC4BVxDPTlsf/A44DJU9yhuk4/QomwRmaAgpIfd1YSEuc8YM9QJNvJZMFLQ34jaLg7ty2F1FxnTddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yUNlP56oYRLa/AYEo+qJ09/sa+osMtl8RYNNaGWUpc=;
 b=5mU3h7EOGolMciemPVrd/AP/IBBMhv7XWzrbr7lxD4lIY+SP5TS3pIOjUAj46Uvbz2dm+X8pAjfijN1RMEc6pv9lYAmTSKbUm3Rcwebyp57GDBeh5mPOOKeHZOWQYka1j1kup+XJ9Zjp0mPtHQLHkELZ/HgUMQ/HNZvuicm6WnQ=
Received: from BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 23:58:19 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::2b) by BL1PR13CA0225.outlook.office365.com
 (2603:10b6:208:2bf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 23:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:58:18 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:58:17 -0500
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
Subject: [PATCH v4 08/10] KVM: SEV: Advertise SVM_SEV_FEAT_SNP_ACTIVE
Date: Tue, 4 Aug 2026 18:56:09 -0500
Message-ID: <20260804235611.4053375-9-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e1d253-1ad4-42f5-782c-08def28441cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|5023799004|13003099007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pTbuqi/a0iOu+inuFtglLZ63Vr8ZP/dXtieivKbmiVP00KPD4lT1bi1FAFUo4oSplS6eGl7QT7+WnrsFdbrjeDIzT7wMubvZFrhr60uHltu3vkyAHsxJ+QOfefLmIl5YN/9+9DFXTXV3ormxMa9LfmDrADE9ZcJ/fO+YBYMdvGjO/w/+I1c7WHcw/Wj9ppRa+vPkHMZ1CtGxLn3SN+bWnTaXZ5iP8TTCenuZ0vr1nuMZFn5Y+PVMDLGo79k56tOiTvNNXSavtGJ5N55ukFwLhtb+0Hn2k5N6Hgiz1YrI2OHfSm58wXalvFgAYDFsZFI22g8xo0j8CMXM+CS2nLvIG22yFeHN1OQ8gmpFGxfMyx3Kh750yapwKN+iKGTRKgGZs7JeKJ7q2l2Ta+a7IPAvNHX9vzsI479hCNgYyj+CX6BkgGGzPy1Fv+8HwKO/lezF5Nj33JkpZq+CA1f6C5XWSM4TPh/Cno9Iv533B04v3+j89+uMwX7zYbrPe3jPdiMxYXE+PabiOczfInmMleM2ve12xsaAFfEJWt5W+K9rRbJ3TSlaKYsy3qy222KCJcH7nvqXPIbPwRAPwIHNNmongaWFavy/l77tcZZyzdDCeXGH0V5buJlNrE/UpirUcBSkC6XWaDMflqXwMNwOv/oL1aQxSu6tuZizi15KffV0igGUguD1O3AdtDhADBK29TFXa64iW25cFn2u8HIWVldlqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(13003099007)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jnqXdGfV6CMSlxtWCVH2A/s3yDl1FwpNY60Yudwlyx+/F+dMMyyu7QKR2zQW3RKfTY3baQ1lDSMWBPpRgssCvlih4jBnHi+Y+x7UUa23cdPGr8rnygAWfsim8F/5U3bT44JRdrAlDXvYIt3T0rY1yhV9389BDIMxsx27OjYBki0+lzWFRSxKSPv1rIiWnodiqNiBrF9vxnKreyjS1M8TF3+vF0xZIkY6+SwLDkOL7ciATVE2aOfwYy+vkaxSletMVwLxYV/qtQkkldc1ooqmm3jerzIaYU1p7T4MHye8ckZVVZQkbfsnoYZQrLIdcQUKxu3HEL9W7hcwaNW39gz+RErPa4HJKRqrQVYZQ2revPc2WIhq6VZHX2CRLLN4qly5E25R042rJxXvHZvS56CqbZIgqKOxSz/q/Z7XaYmcY4juZdwfEcGINjf+AQKY6BNe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:58:18.6345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e1d253-1ad4-42f5-782c-08def28441cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244

Allow userspace to set the feature in kvm_sev_init.vmsa_features.

KVM still needs to set the flag for backwards compatibility, but
disallowing SVM_SEV_FEAT_SNP_ACTIVE for an SNP guest is "bizarre."

Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/kvm/aaWog_UjW-M3412C@google.com/
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/include/asm/svm.h                        | 3 ++-
 arch/x86/kvm/svm/sev.c                            | 8 ++++++--
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index a206a0ed2c58..facabba26a91 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -311,7 +311,8 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT_ULL(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT_ULL(9)
 
-#define SVM_SEV_FEAT_SNP_ONLY_MASK			(SVM_SEV_FEAT_SECURE_TSC)
+#define SVM_SEV_FEAT_SNP_ONLY_MASK	(SVM_SEV_FEAT_SNP_ACTIVE | \
+					 SVM_SEV_FEAT_SECURE_TSC)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 951f0e6be9e5..6baf458383f4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3219,8 +3219,12 @@ void __init sev_hardware_setup(void)
 	    cpu_feature_enabled(X86_FEATURE_NO_NESTED_DATA_BP))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
 
-	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
-		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+	if (sev_snp_enabled) {
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
+
+		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+	}
 }
 
 void sev_hardware_unsetup(void)
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 5f4032239f7f..2e016cae4ebe 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -13,11 +13,13 @@
 #include "svm_util.h"
 #include "kselftest.h"
 
+#define SVM_SEV_FEAT_SNP_ACTIVE		BIT_ULL(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP		BIT_ULL(5)
 #define SVM_SEV_FEAT_SECURE_TSC		BIT_ULL(9)
 
 /* Features valid only for SNP guests, rejected for SEV-ES and below. */
-#define SNP_ONLY_FEATURES		(SVM_SEV_FEAT_SECURE_TSC)
+#define SNP_ONLY_FEATURES		(SVM_SEV_FEAT_SNP_ACTIVE | \
+					 SVM_SEV_FEAT_SECURE_TSC)
 
 /*
  * Some features may have hidden dependencies, or may only work
-- 
2.43.0

