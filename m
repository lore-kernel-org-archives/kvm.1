Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214C486434;
	Mon, 14 Sep 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405020; cv=fail; b=B6VcAUGdRc3Rwkv9QLFRYqzCtG1wXewMguEFhYf3OhMjBURIP7ZAgDpKQu0AMbnDo0rLzjIcjyENojJX6U1EFzv2owko0koxZIPrdxNYmlYmHXqkqwEk3DfwfudpkN4rW/yZ1VKDdJl43H0yP5AwJjAo/njte48kbwDZmP7inDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405020; c=relaxed/simple;
	bh=rYCSK3206pe5ziTIZoOZ+zjMoYbKxb7HIrU0GGMUJGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbdueyaO00fYGraJB/wc5lvm+pnV9dRIT7kuS//L9rO59Xwm9QVkFCHF0cR2fwJAiwRQdiOY8jOGJusU4BJgBcSWQ9Xn9jFU4JCGVQsWSGMky+0AAMJE4xU3pkx5P1oodwszRjolizAGBXQfMsn7Ojgt1hT0GBypdpYzqH6mPmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OxrKeYvt; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OxrKeYvt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRLMkrssheInSOprriTz8YABuf6caWORcSzeviXb5MfLztleCHKKuoOJ8R7cXVACL04GYXhZiNqb9wyqrXfVkKLL5nOm8Zwu/0PN9DIKJMVuga1EN5SyjzzfRazDR/XdssAnHd6U5q0Pkf+oBQ/BkB7erOCKH0TalKoEZDc1uy5zYysmvzicUr2tcZRDPzciv5/HbTLcLOhBK1QX1lvOc2q26dx5Q4JbTfW3HNI5uwTkmFOkFI1gR0oQRH3+mujT6e3Z4AAdLGeXLp3R0+Z3J9vtgsthxWrhD5LcoB5s+cVMDUsCV6NVELQGo2plTdi5DEDUT2XG5AnUjgsgEuYqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dMjLS0RPL8LEf3RJwJO1f0yXEpQq4jLYuc8dQZHfls=;
 b=Q+bDDppzY1faynt2Ol6qRGz8/kzhjar7FZUYBRN7SzJxnRlYpA99nCuNOsJJxU/GcmiJUkXGhLAD3xCR/trtGaoUoKebBh68e9Zg4tykuAL+EXYiRTzxPT9cO1bkO3WrZ0VIZahD7tu5WIvAQax01EwAqRYPsSxAMsWQP34znx88H7mjUKZqHkEtgVA1KZlBF3Y5uhvrSJndTtmKw6guIEr//VTQOIs4TwgwYpFD686oI5cq7bxrWx4IgueKKpE/vzRmAmHCAZAsf9kXlzhiJIP9ix94vWg+rMvIpc419b7S9JBfyqF0+/45T4pnP+LGO8nbx7NE2L0Js2jOKzd8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dMjLS0RPL8LEf3RJwJO1f0yXEpQq4jLYuc8dQZHfls=;
 b=OxrKeYvtCnkqxeRh1cK9XGQjdTgYV1BdXf6LlctAj8hBieVcWrnBgXJuQ31Kr2KA3L4DbiUddzTsjG5RKdWrvakQq0OqI5LtUANsoHiXJ6oeLEA3X21AVkN9IQweR6/cm2zI+i3t3EYbGAZQwtbMm4qEqlhvW+fLwKmlrJ7NE4g=
Received: from BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:56:47 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::31) by BL1PR13CA0225.outlook.office365.com
 (2603:10b6:208:2bf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 16:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 16:56:46 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 11:56:45 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [PATCH 3/3] x86/sev: Add guest support for Enhanced SMT Protection
Date: Mon, 14 Sep 2026 16:55:56 +0000
Message-ID: <56d81f0c1527c8291733aaea72fb70742fb96719.1789399214.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4090a5b0-90e1-4b48-63f1-08df1281294c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/418UIsTlNdPXLPDpZ3P7TH4O99EQzfxcWxpH8ZYpFlFLhFm4Eh5RL6XS4mOkULQXtBAP++iaD3AFLX1WqiX1JSmFLkOSb2rGn5geoHWOlHXT0K/deZ9Tg/tr3M8/XN9Ic09jsCiXrSJYcM6hdO7FuJ+vqM/UTsygDBjFnLsfuDvxnOCwBREZWgQwDDFP6TToHRJrPy7oxi6AV12ai4uXQjTGjo4cet5US2sT1NcTD5ogDhqhw6qNqxogp/+1ImIj5hio6eqf8pWQilWLHcZ/c1YQHjJ2GRjauTPz4N4qOjJaKXmsBCM/yHliSqcj8wahxPS3AgHGI3Q6VlWu7LLG/GJqReTv6eExIL9ih4boiq7YZ9wZME1Pa5u2fZ/jOlH21tRdppXmeLaufndgIQRtT6pqiBAjVx9QmtGj0fIpGVJpR2DIYly1oR/ksGCy9zl7XjMzXDT3nrtkGwAOaU+EdqAGKgtXJDXGNN5bUPXNsjhHa6Wqk5A+U0sQvSSxjKhvbSRhStiCdER6KRJcajw1FI7bJTSEweUxRCmMKJv5QOXi2i4K+aX8Wu3/eEWLEYH0Bhm4SVvbzcz4p2utARbMzwZo7WcHaYwO9B5h+xZIo+BvhVp7zNf4H53I/fmv/fXecSfRxQwy0kssCpw7LRuZewPg+z1M6U+JbzGBNE5T2bF0iDW3pxgDBjeNwOvN5d4sm+qLmf0M9No68R/XODaKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TLj7j6Yt9lPITUUjsmm4VyckGf6pALOzllwudOpQ174h5tz3j1YoAJ/ZRxV311UlHqbCqyqtbv4JPQ1E+n6Ye86G0nYnrTxmNuF75+7cx7uPjcsBucTPI1t9+40gEjwYwAIK/1joIT8nez77DMB5Fbew4n/F7ImybY6qJxJHekGntreX0+dfbq5zT0DyTbNZflI3ydv1Tgxubpw4NAeTPUuJqKDWaJEWqfzJ1FaYwsDKlb5aAP1+qzPqczsCrzSVP/jsk6k16GGf7ICtEB/+LPSgHHcvpB4kzfij/97If+lD/X56NaPw/B3bJxWBcabnAGFIo9P1p1UyeeAt8ciE2bi5x/6u0MCTqegP+lVg7KKnvZLyewnVoj3IZpd0067odATBtDRcGpyFYNEXsGVnX6ue896EUz7qBm4QE9cZtTa0dqSF0lJ3te9mc3eaVd+N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:56:46.2376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4090a5b0-90e1-4b48-63f1-08df1281294c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

Enhanced SMT Protection requires every VMSA to carry the vCPU's identity
and the mask of SMT siblings it may co-run with. The guest builds the
VMSA itself when bringing up an AP, so populate both fields there, before
the page is turned into a VMSA and while it is still writable.

Fully set the sibling mask so that all threads of the same guest trust
each other.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 arch/x86/boot/compressed/sev.c   |  2 +-
 arch/x86/coco/sev/core.c         | 13 +++++++++++++
 arch/x86/include/asm/msr-index.h |  4 +++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c6512f2ea31e..44bc14ee27c6 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -188,7 +188,7 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
 				 MSR_AMD64_SNP_SECURE_AVIC |		\
-				 MSR_AMD64_SNP_RESERVED_BITS19_22 |	\
+				 MSR_AMD64_SNP_RESERVED_BITS20_22 |	\
 				 MSR_AMD64_SNP_RESERVED_MASK)
 
 #ifdef CONFIG_AMD_SECURE_AVIC
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index cc292d7c6fd1..730cff2700d4 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -89,6 +89,7 @@ static const char * const sev_status_feat_names[] = {
 	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
 	[MSR_AMD64_SNP_SECURE_AVIC_BIT]		= "SecureAVIC",
+	[MSR_AMD64_SNP_ESMT_PROT_BIT]		= "ESMTProt",
 	[MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT]	= "IBPBOnEntry",
 };
 
@@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
 	vmsa->vmpl		= snp_vmpl;
 	vmsa->sev_features	= sev_status >> 2;
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
+	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
+		vmsa->vcpu_id = apic_id;
+		/*
+		 * The mask fully set puts every vCPU in one group, so any two
+		 * of them may be co-resident. A legal ESMTP sibling must
+		 * also match on ASID, so the sibling of a vCPU in guest mode is
+		 * always either another vCPU of this same guest or idle.
+		 */
+		vmsa->vcpu_sibling_mask = U32_MAX;
+	}
+
 	/* Populate AP's TSC scale/offset to get accurate TSC values. */
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {
 		vmsa->tsc_scale = snp_tsc_scale;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index fbcb3313e946..6fd26151d146 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -745,7 +745,9 @@
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
 #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
 #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
-#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
+#define MSR_AMD64_SNP_ESMT_PROT_BIT	19
+#define MSR_AMD64_SNP_ESMT_PROT	BIT_ULL(MSR_AMD64_SNP_ESMT_PROT_BIT)
+#define MSR_AMD64_SNP_RESERVED_BITS20_22 GENMASK_ULL(22, 20)
 #define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
 #define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
 #define MSR_AMD64_SNP_RESV_BIT		24
-- 
2.43.0

