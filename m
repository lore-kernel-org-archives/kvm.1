Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9430F526;
	Wed, 26 Aug 2026 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783812; cv=fail; b=LZ+bfNS+UuEz6TsWBz7VfOBsQQeXfcaI+l1l44r/MW2IQ4HdKWV0WKmlLDuWGNZCXyVSmQwuvrw2+8G32HxYioBBoXpDQWJViCWcjYYKvQORFzg+7xZEuMsYaioJdAQf63gJVYES6/2fEFH7ZiWSmpNaSK16AMiVvIqA52JOUuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783812; c=relaxed/simple;
	bh=mHWDinEStA5n+jjIO80R4zYCrc+Da4MMYvkorM74lpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCtL8cotZ6VfnXYIN6a7oBAlPwb6GsdyvA+3DxeB+M/2AbM/q6UPWSNy3Bzp8TQ/wcOkGpNF+llmTBTu7Wg1Mzq94gUG02uPMvvsIWh5QTYOR/k27jxBFuCsNqdhIVh9EvQ1L0SpZLYvQ6viAHByq+2F6JVfFeqKIm7/RLypzSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BdDP1jnx; arc=fail smtp.client-ip=52.101.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BdDP1jnx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjSoV1ypybNwh1bqIGzTr47++DjAhbRA6kRveGKgUUg6Ne8Zl4YLjzUHoIYnopQyronpeUJB0QiNrKx3ruZqurEtYFt38cvEcaachC3QKSnFmAP0Y5nmXokiT7RfxSeDQxeUDYNIvasU6rslcH/oO+vcEYAn+uMqg2LhVO6bB4CRbA33P47NM2O3f5FX0j5bMgTdW9cYlT/Sv0XtaN0qUzTHNwmcCX9FGUoS1xinSTNmS3Bt2uBMEeqSXknfUuYnV8thCVIucfRU3QZAxAKceuHFG/GO4YExgvVi2oimCnYtnu2XSYeSgoAuwtiNZc50oSHEGn47/FX2s1l/kFMxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iY2igYwOVI9hazyzs4pvu2KE/JKrXh4BctQmHgGYDw=;
 b=A26xG7VfTCuROyD7VYDEDlkqZL6wsVGUFCW+wnhatIlfN5qVONCA4C/HowQhbXcRWpVrU72qI1S7fZpeUB472AeDLdgA+i5BvodX1Z5ukGiTqrZSQrYo1r4x7L1STvl5SXkuMt2Ccwnsa72AmVTn1YYRWTp5mdVJGpLJShABFG92Y05N+FrR5uFsRbhAQBqkrOIhhx6U4bXzTkpPeLR82LJWCK89xpyNHridgoXUaaTeRcCAKZTlo3W1vfoE4G/6+y1Z1Mrs3hDSIHQHAdpuZNuAb7/HH/m9wlQAEhpFTQpcwV+mYKE+2XAuNslRhiRqVqyJhGytgw7tH3GjdAs/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iY2igYwOVI9hazyzs4pvu2KE/JKrXh4BctQmHgGYDw=;
 b=BdDP1jnxsdi8RmnE46JpWMePqvESqap7lr0CYr4ZTAHysmw7FSEUzsaHcfpgns9V2zrT/3ajOAFO2ES2+n2sJJNacDZdpaq5m6Plc0d2o0lcgZLerLT9+J/8ZvAA8Z1qzmaOGi/jGTydWlTBNzhMaHLn678+nsaUKWmbBDXuAYg=
Received: from BN9PR03CA0882.namprd03.prod.outlook.com (2603:10b6:408:13c::17)
 by IA5PR12MB999302.namprd12.prod.outlook.com (2603:10b6:208:605::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 22:36:47 +0000
Received: from BN3PEPF00022BBF.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::23) by BN9PR03CA0882.outlook.office365.com
 (2603:10b6:408:13c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 22:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BBF.mail.protection.outlook.com (10.167.248.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:36:47 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:36:46 -0500
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
Subject: [PATCH v5 6/8] KVM: SEV: Advertise SVM_SEV_FEAT_SNP_ACTIVE
Date: Wed, 26 Aug 2026 17:35:08 -0500
Message-ID: <20260826223510.3669875-7-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBF:EE_|IA5PR12MB999302:EE_
X-MS-Office365-Filtering-Correlation-Id: 20875495-62c6-44c0-9d7a-08df03c28391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|6133799003|22082099003|5023799004|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	bip8wRgwXg97Yoiavm77GPG+HAEVaASdA4+fCvfHGH3SZdQ7m7nIHY/+GQLxKPhxDKcls6fZaEq35m0kdunY0UGlHe6wy/oitDmyKfnttopiVShUte/TLJssxRBzfT7cGc3cE+/tvr7cg1m6HNnyWPAtXJa9v78dTmhpVCCESVNYwg2n/Ikp2I1LZ1zZqMkYhu+x6Iw1GP5dRjeoVOlXlreR+/g5XryEa98wi4IGeodGcLoKBtP3FjG8fXUBZWoyitHCxD2LiLz40nGYqhS7MXhi7dmgNhdYhIqkHVlCbcoHdelIKaA465EgFlDsctIkx+itiH2aeKdWDZY0UoADU3rob8Y8w9UMCcYpOTC4HR9jZ2Qkdxwp25ZiKoU18uTrm9r5GmMTLROy4VAkhC7Ix0gEuqK8ClQTQ8/V0xJboD8u5nDzGHsOa3Nuv3kCM4pJ+eR000VbDVFMfJFJXmKZ4Nd8d5FmHF4QFwE90l7aWbcAACQDvoecJag7Onk7w7vvAQYffNyrudZv6C7mmWv4u4yS5BKfV74itgfQI7iyBqa6/RIwepL2OyOglM+ZH8ooZzb8uBm/eEGj/EnPbXLNeRoe+ue9k/RETou4+NxYGdPq1NtEF5osf6bO0IxzyfkVZXDG/gIeMwHQG4x5laaZ1KorQFWHK3JOUdRRyeYM+VHPpS926Lm/kFYAMYwugGUE9aEl4uG8pKR6PFt3j31XZg==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(6133799003)(22082099003)(5023799004)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eQN4O4uxG85uVnHVSdLxkJ2VwfnVEhuz86O49wgcNWRw7XeX4LMVV4KWU7YxWP0ctGSwIk0WaniTk89MvXeYJYcz+Rsac/rVFJUn4g3tPvJEd8xVdvvePiQaEvLfBp4KWMI2udlMIgkEaqWeSjAdvU+r6iMT5ML1Je7xm4J5C5Xw+NIXVehuV3FRpFEbDIhB4HCU7RjkRfTwxnltzOQ1HhXAE1uSTf72ahNS082ZnAqD1QnG4x/ZF7CyP2V+pcKFBRB23eEEaSwMYF6TEhhE3GSQ9MpYL2VzeAXMq12nijHbWln4o+z2u7DqGqtcBL+NImgkHtn5ioGdeJOmb6dHm7KB5tUVZb3nCIRdLbHA2qqvYgqN8+Y+BKHuhcK6K1mk0ZdAKV3ttr5RK6hLATOGVnGnPamR0ECm4Ru1yz9O5ucqJ7KLoooaIS0xIT4gFAFa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:36:47.4553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20875495-62c6-44c0-9d7a-08df03c28391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999302

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
index 3c9483733865..6cfb7496415e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3257,8 +3257,12 @@ void __init sev_hardware_setup(void)
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
index 8269f146b1f5..d70482e07141 100644
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

