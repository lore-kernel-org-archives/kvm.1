Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA6471271;
	Tue,  6 Oct 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305756; cv=fail; b=uTal+uRPGfspgaRvJPIUs4zE+aQiHKBPZxCb2LUmL29b7feUbdWEKOATXohwYBPvnn5vlOeRxCW1tJJJuhnILuIeOzY/X/ewMCkxjZ0v6rwVo7QB5//igVr2fGKSMyXT1+D/YZ2C0Sz5TJg+GnmF8VAmFVHYl7KWPA+dZ0RG1TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305756; c=relaxed/simple;
	bh=h7BfYu/rtI2zWh3tEm368KPfSPMi0rJB6+WBNRlU4GY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvnfrrppsPk4hYqCzgf7I+zicdkc3XzZziwpDHuTCPdvj2a7du9XlQeNrUjINABZDDGr3swEht26AEXQ7vXKmwDKmNkPSnr3n41GRWAUwUrj7ztX2uuibE6gRUOHNA7MtYpI15W28kCfqNQRRms37wQK4R586c873weE8GGR5NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iQhuzOnW; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQhuzOnW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYm3JldhazP0FxaXiSNOOtxAUKPG8YpM3EzkYdzw97HwRDpgs5xUDxJgQWrz5vYPEgj2t0fnxiOZDI27XrN/rjBcc1X5jDUlmvTDJkzQltzw2MLfNjmy6EK+p5qPkmp+Zl4V4FDv8e1AJnd11KC7FuEdNSCc4/SMXIrfpvR19TcembaKZ/h5/Ne08ipAt3fSIuZbJkm4nJbV0+YpqPrFOhbtVEbMsDYXCNVZk4+bmDBUTG6lDmjxZzTkQosoCXhPAQr4FhqJFedSzZaMVk/nZCkC5KAy6EVDeoSVHI3DFmAIEOXMzCfbFwBPa6H0ikg6eWWR6mEajpcsFUtHb3o+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz/e+AHHi2lzPDR+BypgKf6JsGnVGpBN9k8BwaF6hCA=;
 b=NaedDZgJVOh7fPwvMCPSfa7+baMJk2nZBfsQuywg+Y12/PGBIh8Z3ewlVu5nyG0pdab22ug17xD7zjrptMpe2b01TFCPVJrOdPWrxkkCU/RX23OugsNK9UgL+7GDks5WOu/yRt6MtWZgfOPU0jv7IbMMLxaPgtFKgatAD3/ODAN7Oligqb+FxgNyp3ne5428vm2KT5oYxaNtytm5vBqNPONWWQnAf3oKKQlBcOup9U7vCEZZDNjp3ecLmcr6hBRv3OYHQDBOQdgQShW1NXSMu/zVfFOJ1Xm+iKLx3OLwNt5ig/k3syFmsAq35p2qcCM7ps07a2f92lp1O47zc/d7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz/e+AHHi2lzPDR+BypgKf6JsGnVGpBN9k8BwaF6hCA=;
 b=iQhuzOnWzkgtaIxRctdsDuZMlNa/gkBbIPkeo6aHrrp3+PCMfwyDYLXF6hSEFHtq67bDppStvFV/S0Eh9wbwWhytAgMsYSN1ltSramYw9neTgliUWH99K28midBfT/gJSFQmm/p+IgtULmZfFwATg3EH4HZgWU1MfaaZiOwuXeI=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 16:55:46 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::24) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 16:55:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 16:55:45 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 11:55:44 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v2 3/4] x86/sev: Add guest support for Enhanced SMT Protection
Date: Tue, 6 Oct 2026 16:55:00 +0000
Message-ID: <92a1de684bfb5d8633c2de0ed8511f33282a0d70.1791302373.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791302373.git.prsampat@amd.com>
References: <cover.1791302373.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9498cf6d-3e87-47bb-0cdf-08df23caaa73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ig/HYJcyFaV0qAmcoxAxUJkpGm//0Ho1RKJEK3c+p3JqjoMpXlErkt37wOk9cqIOSVDp+8oeMlchz2ddl3/RO3qL9/JVpm5heH1URXobCym0AfG8rmyALGiF1UPROJ9/KV0as+QZovbSgUOTPpFJg7+GbHe63QGUFYYgQ0kTXkOQWQor1Kz2dLrc5bgfSE09QHBxlkkLmiNfID9oIpGl5ag+osGIDfhKRm5rfcfTQqAHgARQ0tM2FSXa6llZlqEX9jeUZGyyb78uNcPCTYb/meZFyXBugmyXjohjm4QMWlOwtzeqNO3sOVVSX5MyjqNAOn4R6l0Nm8u2cfWD9e6gQaGOzA1GtItKsm7UDkFhGREAaCvmXXazo70uCI1MuWgbR88iRAHF+coHwXqOVyTQd1gQBvTyc2cSSPK7ni2jZgynHGAuhtPDuiQTOk0bDPLp1mYml6twfvtQ9H2fEBzHYPsgXWm+FFIQNoMxTFVBPeed9itUGCjE/7yx3Oet32RiRbKrUKL0/2chjppD1mhndno6dYYz7Gyui2jnfM04foTv52ge4pl63At6tKdEqBcluBd7Ww0ZioYNdUXXPikXJzX2l58HbHQ+gSpRru7Ved5dVMBxNiktZf5HBAie6taLCvULCsh+y+5mGiIgpxM2I61D5XefSZdSkX9n/t5za5I+cFAt3JbmsLagjMzOp9DGeEvWsScBvzV1cvZ/v4VmKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ebpa+EsOvZ9AssPFJ3Lbw0xUOm3u1TOv9QU7pytuuq16AVTrJ4QavwNy+7PYuEY/xTg8nWa/RcVaGkZh4gkDyM0vGn9flbs64JLPv3oQ5bOmsZHJXfq+jUlfPu4Dldm0GRd7HsreBDWGFmmf/Ht8oWiU74zPRWAsohERtjql8MpUm3VF5X0TXyWFRGV4RKGYhOKxzrxwZLvB6cCEkspYyt3AscoyXHWy6e89SRCjIcSs95g8knCx1FGWFpq6XpVD0Z3luK80iwi1WEu/OPsUHUeuYsyavXIYom0RHIw+RKfzLu+lnof1XuIn0U0GWaOERoj2ZY7L3PL/ZPDZRzbWJ92chEB1l2/1shz31A4MLGqAPF6MhGvTP8mbyCeLMj7zeUbowJZQofL0KuVYujc69WxkcS+YJHK9MGC735korTneODutrsos9bqWhAx6H6IA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:55:45.8674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9498cf6d-3e87-47bb-0cdf-08df23caaa73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447

Enhanced SMT Protection requires every VMSA to carry the vCPU's identity
and the mask of SMT siblings it may co-run with. The guest builds the
VMSA itself when bringing up an AP, so populate both fields there, before
the page is turned into a VMSA and while it is still writable.

Fully set the sibling mask so that all threads of the same guest trust
each other.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v1..v2:
* Add ESMTP to SNP_FEATURES_IMPL and SNP_FEATURES_IMPL_REQ  
---
 arch/x86/boot/compressed/sev.c   |  6 ++++--
 arch/x86/coco/sev/core.c         | 13 +++++++++++++
 arch/x86/include/asm/msr-index.h |  4 +++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c6512f2ea31e..4e0fa5a5f70b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -188,7 +188,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
 				 MSR_AMD64_SNP_SECURE_AVIC |		\
-				 MSR_AMD64_SNP_RESERVED_BITS19_22 |	\
+				 MSR_AMD64_SNP_ESMT_PROT |		\
+				 MSR_AMD64_SNP_RESERVED_BITS20_22 |	\
 				 MSR_AMD64_SNP_RESERVED_MASK)
 
 #ifdef CONFIG_AMD_SECURE_AVIC
@@ -204,7 +205,8 @@ bool sev_es_check_ghcb_fault(unsigned long address)
  */
 #define SNP_FEATURES_IMPL	(MSR_AMD64_SNP_DEBUG_SWAP |	\
 				 MSR_AMD64_SNP_SECURE_TSC |	\
-				 SNP_FEATURE_SECURE_AVIC)
+				 SNP_FEATURE_SECURE_AVIC |	\
+				 MSR_AMD64_SNP_ESMT_PROT)
 
 u64 snp_get_unsupported_features(u64 status)
 {
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

