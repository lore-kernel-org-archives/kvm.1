Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B830F526;
	Wed, 26 Aug 2026 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783854; cv=fail; b=LPlFi/PcsFXAJeP8yuV4+DHzNU3xI7elWQw/0np169KErOWBNZkGcDqDoLdD47dLOGxD42qKR3HnSs82WlT+3p0DgcYv3noTn6MV3pySFBzllJqg9RTNcIJqbZfiBGbavZhlieb0+chMvojLYw4DLWMIP/3PfvlIihNDvlKTXRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783854; c=relaxed/simple;
	bh=asezm175rtd01o9eZITQjJI7P91atktw+cHQyRAyrs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fqfbtreqm/5xX3EOd5L0CvOvR6VP4e5BVAVSG9x9hsVACt7BfdOoFm0KRFuQ2Brgoc5rRb9OHM7C45bGqqXy8oPZ72jRx6kr74NcomWNszg+jePCVNI56RqmO7ez41JtfhiuH8XKOw8p/tec/BZCBgSb+fBuZ8yYsaO2VINqHc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0N0AMXJq; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0N0AMXJq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/BC3CaVlSmCTfS+B9DUfq/ZmOPtnEHBCCxCcn/nenC+qz5C62d4WxJ58o3hZR25oHxmibEE10eWohNUqIzfPeQVFv0x3zCC8H7Fj5qu3AfqRLWG2O5EbKJlUe8J1vDzQJq9uPxZX8yaAzKfzgt1aOYtnwfWb4b3DOfA+Rc0wrKf0cjB8Sr8nRh30+xg78SDkvjGUOHFcK6IMb4qIBpYIHVFRFlnstDe5x1f+Fc3cPj2zWit9IRthu7rDpuKKojJ1tA1AtEeRaBormvPg/XUWEN58Say/uykpswAB8pcdYiUDJz3OfNxDbUAzoeBCevx1uYTwNFGRGMZpAMH7FzhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy3YV3tMRp0D9ZfksLXoCCJQ9M3ffgSV5ZXq58HbhKc=;
 b=vfDpM6Nxx00ruMcvOVq9hiFAtbLuWf4amT3Za1RkyrgU0ocX1/LKSOolYsh2EUietQnI03YTndenZjOUIjUm1YRlO4RDEEvj1tS6GCliACWbcQbkL84APeChjx8lcOMT+u5S5e73p4SJPd2bqQEJd+sxhdLqUSLZtCWPrTOQL0MMdHm1jyssernhBOqEKRlanHPPB+aAnQCeuvW6dvnL1HN/Mna/dZ8cknmFNVzVycOrkRuNMbEPipREmsI0hvvxjzu2cDjL/zdAxwje92rIU/tlBVjVn19jbkhn19BPdPYf9uZf+20hcZak1ZOMkRaBm1LxCghHpUlzvwUMqShl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy3YV3tMRp0D9ZfksLXoCCJQ9M3ffgSV5ZXq58HbhKc=;
 b=0N0AMXJqY7v9TcmDdt/VemhsrEJG5ueyHNV7VqzK1LvmfrTsqbjpSjdgTMYN1tH9nGyrQnbII1ANRvd5QGUPupBy5SiO61GAj19MfUwKRSMogxqdUgdwFpurFCYv/A9a82HOBydG0BDa3FQyRq7VarB/c+z/P2wiMM+3fhixbJU=
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 22:37:11 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::c) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 22:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:37:10 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:37:09 -0500
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
Subject: [PATCH v5 8/8] KVM: SEV: Add support for SNP BTB Isolation
Date: Wed, 26 Aug 2026 17:35:10 -0500
Message-ID: <20260826223510.3669875-9-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cb55a5-6f07-463d-99c0-08df03c2916c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|5023799004|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	owjGQTRPl18prqow93c9lLw3IeUc2ykmYzQuKZti8GSgGs6rHb5oUVnH0OyaVuQ+k32LFYUjE1FzOw+GuyLNud5Tm4Ka5l2kkqr3zj/nh4cxoVGfXgi01vHv8xfvc641srRBVRScBK+CcOGIYS5tsYqpEyZFoUDOtX9XeuK/qwoM6JIN3WDCpvHnwL4Al1R+TzbN/a+UqJ11PwJxFrtnVDTslwYE0ukGZsllBvRxAvokKC3Zr7yM07ZL8CWUs7sDp9T2PmzmkRksVR/gPK568yv8UbzqAOLJ8tt6eHrtqGvxN1S+dBIwnGnQtCJ4rUKt7teRBTMDfO+DpZTkSYWlFhSShj52PeQnNkWyXnU9buBQ3tZzltwkALZDLgGRqRNMxHoWIE/6uB39BcyKK2claIVWSmyN35F/qthfb08tQuDuw3YCLTaWJUS7wsk0PQlnl5COeagRUXpCmI46viXmPo/S9biw9YlsteO+5fJIP3g5D1GqcL97dX4Bkha+uRO/e6Jqgz/qT5/Om7QdGzhHoH9biTR8yYEfNCXbJg3IWLNfOmR20AQuMtiIF94qpdDCCGOnVYamXLaKERzKlaJcPfKg9FPr8Z6+zVFCyoPhhHcISwbWj64ikNyZSo9B0RwCKz2iX9B92WM4qJQb3apuYQ==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0l1i/xHntxIXJYVqc8AWVGpimRD8nft91oSiiDbVXm3Q7i/6pibFhDNtoM21/2ZKZeRt9JY96CfzMSJFKf6QZ5dEOpa119FUdnLV7eVTD7Ug5jSb0990fOMvPfY6vJZUe+wLdq/L0aAv6+PtuW9qP/NnpUPkAusz09qGdeZZ7XrCsogEtJSTaE9sLjLoC8f/f/Ov4cYW8gKlWLXgbI66Qa/kWFOk7wDZJQPgnEDPqcYjPhHkA9CZFTqgEEsQuPGhlDbS9d81arODQHGy5CkelWG+Yvkutluiux6Knfsp1wjZqtHHuUgAa+BqZp5/YmvzentiK+oL5Mt30TRQ+eN5cHHgXtU/jGpUquD+DtFZQdE0EhcJEd0Md6WCdvw3j1sgjFAGfyreCf37ln2+Ixm7uBx7fbswGDRfshHx5wqqoN7y1RoAw0PygRvRNvgPQwFH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:37:10.6482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cb55a5-6f07-463d-99c0-08df03c2916c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

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

Nor does the guest have to take the host's word for it.  SEV_FEATURES is
written into the VMSA by sev_es_sync_vmsa() and measured by
SNP_LAUNCH_UPDATE with SNP_PAGE_TYPE_VMSA, so bit 7 is covered by the
launch measurement and appears in the attestation report.  At runtime the
guest can additionally read the active state from SEV_STATUS bit 9
(MSR_AMD64_SNP_BTB_ISOLATION, dumped as "BTBIsol" by
sev_status_feat_names[] in arch/x86/coco/sev/core.c).  A guest requiring
BTB Isolation can therefore confirm it is active rather than trusting what
the host advertised.

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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/svm.h                        | 2 ++
 arch/x86/kvm/svm/sev.c                            | 8 ++++++++
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 2 ++
 3 files changed, 12 insertions(+)

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
index 20a761cf3491..53cc6d043883 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3260,6 +3260,14 @@ void __init sev_hardware_setup(void)
 	if (sev_snp_enabled) {
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
 
+		/*
+		 * Unlike Secure TSC and IBPB-on-Entry below, BTB Isolation has
+		 * no host enumeration bit to gate on: the APM defines it as
+		 * architecturally present on every SEV-SNP-capable processor.
+		 * If SNP is supported, BTB Isolation is available.
+		 */
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_BTB_ISOLATION;
+
 		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
 
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index f2f97dca3935..3f592e245a66 100644
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

