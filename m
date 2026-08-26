Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C236D9E7;
	Wed, 26 Aug 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783804; cv=fail; b=QPztAuQFLg8CizHknbkzl8MM+Af5+GR/BzVvdqmMDCxKdOn+UnImwvCtjM3MF+955aTWVAtOHVGjUxqXpLZ94559JakQSB8ScBdZ/uFLmc3ftOK/sgnTKfj6DNlFkWMzYdKKdvH9GIXZ2iiuiAucORt4RpcB8AaZAB9Wk1fJb3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783804; c=relaxed/simple;
	bh=UcQSjmWeg2yjNeGuVQm1U4pxV+nR5aPWp00GaJttdVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6xULTLu8bQjoTrWSQCeP3nN7Yd4XfPmM2nnurnq9Ua3kkTGygq3d5B540xVNwbTS+u+BIdyOwRzTGQG/cqIenJrvqXax8xke6G4Bvo5LJwhISkKZMosLRgC+PgczdrsELkxCAJp4imR62S9clAisq2x9BQtHAV4Q0eQYyH4mSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bXZkqo+i; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bXZkqo+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xojp4DT0TSY0w+NgqXTGuY2hntHUGnJzLBGA+O0i8H8z3T1mNnn56zykpwGkG1E2E/t2m5YvkwRgvut2hwwUagp0o0hym0p1iU7+lXw9Ro9fXGcLTP5rH0rSSf6mxmGMWnjF5tbgVuT5UqmaeTjuPLCfgjFmTeuEegBf47hWt/m5hGnZMvQvc/14ZaNxd8MDpWltiJ2G4SwDNn8vMSGqI04cOccWvtPLdFhEJkuRc1PvG9ohyRmAzRggYHL6Glc3M6WZLlzSQ1pVZHfa0vIlZg73mFbbGxVMHHpxSze7xnc3/a7mv/pnVihuQwQXU9LGS/SVVmlECvSu0qmO5QXNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOwYcv2dgarSXC7nejodzdwI3rDT1autW39QPQETgEQ=;
 b=VFefasTiGFHr8UlspZlEb1GUs2nPEdcDJpFvGD0KeCd9dHSQ144pZzVyFbNwAZSk6LkXAi3VysoxcgbVjLixGm9QD/ns+A2//gIpAgOHBbZgqa6MbZawJETzQxTXrxIbc2Y9uuPdv1DX2ZgHkaP38sr3QX9M9vQPK5AVpl79XEDb0k5zXLgagDNSNVcJFmarFGRYymB2YYdd0Uj8TKWwOQRLWOuxu6y7z1yD8p7l/0yxNUwqAKCjLaD+oNt9YpDHuSZDFXhJfStxLQWdXIbloBaftFKsCF1hgWfpyG8vHiGwLv9CUES8Q9EREgr+Ukc+rCL7+ybHb7hrEoMRd7eMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOwYcv2dgarSXC7nejodzdwI3rDT1autW39QPQETgEQ=;
 b=bXZkqo+i0795LiHs371lmtRkMBwnlKds5UJ2JQTL9hyWokuaZDYGNgvXpetDOgBx4BMknciN0RbpzYCQBORVMiWEKD1NF7/YxLUEnztE9Pkt4YMr8SJHjAyQ4Kz3+nJgji3LO8wly/N9weGxR00sqxXndnv+LRzJAvDPPyNvHUU=
Received: from BN0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:ea::9)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 22:36:36 +0000
Received: from BN3PEPF00022BC1.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::45) by BN0PR04CA0064.outlook.office365.com
 (2603:10b6:408:ea::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 22:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BC1.mail.protection.outlook.com (10.167.248.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:36:36 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:36:34 -0500
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
Subject: [PATCH v5 5/8] KVM: SEV: Disallow setting SNP-only features for non-SNP guests via a single mask
Date: Wed, 26 Aug 2026 17:35:07 -0500
Message-ID: <20260826223510.3669875-6-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC1:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 333cf665-24e7-426d-0ae7-08df03c27cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|13003099007|6133799003|11063799006|56012099006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	80iR/0i6y0XkZn1/H/U5czAjk1HMvmHGXGFn2RLKA89XxiNkjSYR5I0Hefda748pobl21HLXwBfM5hT4szKZ6O6NSo9jUGFCtZXIdk3zWz4DTR1F1WOSAJCaSvuA7rmZ1RnCjbIGHvns2FeZGSsSsaYeFfB8LvMIZhjzx/b1lLsX1TU6LXiGaUcYZkXlTCsppzDRNLSrruu9apBpYu4VCUJYfktBlKsaByEYdUmCkfSIe6EQGTkWQfAXR+Ip/WVkyHEkl/bZ03XRnZzbanOZKR8UfLrxIIVwvuTm/qyC2oaukTLVTZN4Vbtp7svo06EUKDyfa6BdvuExk2WuiVJPDciHFGw9r4+lX4HRrhXgCww7tiQDSJMKlqJeLprxGhc0C8rim1pJVMs1ng2xh8ukkrAGPCyTyZr4D+oENLmiHwWOqzyDmwc3YodsuYwTCObgBoGh+6Gqz4BGKCWxRcB6lCa8eKfP06Dx5ETVZg7poRsL/2rZ7JCEq51PzTG+v93PT64GObRSBOAKnjnSliI0zNHaKc6RTgldxp/Zyz9FdbwAlU1kzcCaEzTnVpuCbJz9M8cyaawmzlg4Jmj3+iNYPk7uT8oDXewVZnJjlm9taDzRjSp3wdjur5iMwO9OykFoAMohw6ZoMbqC1Xv7DJLE/E5uZBFRjhOM+BB1RiShrKfVgKGsh5QT8m7KfGhrrO3nvzOEN14ynGF+lrTu75ok7Q==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(13003099007)(6133799003)(11063799006)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O37pqazBe4/wJwC1sCrYqY+iDyFruYLqfUEQ9vIm+4aP/utpWOmKjhyOavKk5gLEij57khyrSQWoqxYIPqpjpFvwQX16hdEjYvlznQxf75cmNa4uFP7cgrVmXVhXAMkJFBTVBrDcc/2NidPJaRJ+pCLneYHb1czLLai+MWKZZTMG233iKysh1ZULLjXepzqpLjhJbR8/n+Bs9POSnZzoAq3FxAuHk+O/IcSiJU185JQA3tYrQM7w0ty6YRQuC+EM5cB5KKdJBJWsgY4hRXrycP4C9PfWahfSfQ6YWCWd0Nifpp/eLkIwji09hNEsF5fAsJ6SPfRIP3h1gbNRmitQyoUyGYIey40c8bxLKExnjqx6MNmKMeBMN5z9v5NetwfG8eWSqW9GP8xlrDUMGUf71Dxp3QSECcts3Jm62vumU9JgxE5G7B7EmpY+VAACkyyh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:36:36.1603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333cf665-24e7-426d-0ae7-08df03c27cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596

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
index 5705723f1f41..3c9483733865 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -506,7 +506,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		return -EINVAL;
 
 	if (!snp_active)
-		valid_vmsa_features &= ~SVM_SEV_FEAT_SECURE_TSC;
+		valid_vmsa_features &= ~SVM_SEV_FEAT_SNP_ONLY_MASK;
 
 	if (data->vmsa_features & ~valid_vmsa_features)
 		return -EINVAL;
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 61a94c6eec27..8269f146b1f5 100644
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
@@ -108,7 +110,7 @@ void test_features(u32 vm_type, u64 supported_features)
 		if (!(supported_features & BIT_ULL(i)))
 			test_init2_invalid(vm_type,
 				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) },
-				"unknown feature");
+				"unknown or unsupported feature for VM type");
 		else if (KNOWN_FEATURES & BIT_ULL(i))
 			test_init2(vm_type,
 				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) });
@@ -157,7 +159,7 @@ int main(int argc, char *argv[])
 
 	test_features(KVM_X86_SEV_VM, 0);
 	if (have_sev_es)
-		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features);
+		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features & ~SNP_ONLY_FEATURES);
 	if (have_snp)
 		test_features(KVM_X86_SNP_VM, supported_vmsa_features);
 
-- 
2.43.0

