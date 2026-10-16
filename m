Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D373B19A5;
	Fri, 16 Oct 2026 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187696; cv=fail; b=LIilaoHq5E9bv/3LOB6v3opnz6vsQCaUNU6d6khjKqbyzuPS/XiKQFLoEGHI/D9XLAkrRRa9Mk3GtVa2qngaYp59iIIFrGqVodLbBvRarxyYRx9AQp+mlFANLRMujn6TlazZDP0idnqgsc2gXnTZQzLNQXbU4/NNiG1PdbYPP9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187696; c=relaxed/simple;
	bh=8VoBm7mzWD21o2oAe7hMgB0cCAO1mGPyTHzd6iMxTMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7e/DDNXyby+/W7HcYZQi/U3kePhC5AmqZJKcMEVmxjrRMD03xg9GOxEa0NH57EM2ICRgzrR84TM0kqUHu/LMikjB4KDgaqzRhadWgYTo9muzrZMWAkQeHJxYCYc64HgURc5JVHnP843K8tgX7UCAPgutiHizdtLZCOx/9eGnlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1dk0Q7+W; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1dk0Q7+W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QILCo6kIrfumqRRrqx04YPPGvUQF++/4Her3JihsyCjOEEIN7bT82umse7vuQfbILVTsFATL1QGT7570tzMolwXw0dV3a012elGrLXGP/kUODVREF3Om1/9H3MQmr/7fU+10P2HsojfhZMpMeaEnZSluF3oUSke0uOMWvIP6sS11gOB/d84yfk7yzsYStrPyqkd4ofPlGw+/k7WIF5QA6Yh24sV6NcgF5ue7uv7++bWC7KUHdmDI2OBkE6lQCJAGQQHn9nKmTU7sBTvxnLee1Cgu9kV4RW4eUwOVLrTDzBM0+OGZB7Pf3DID8L8gALLQar7jVRGq+YIx6sIl7Ce7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxPHzjLAfTm5jRH8Ba8vBFRZ8nUTnpQj+HY6rwFiE7g=;
 b=JD4GPg/jFlTvVWLH2rhla/xeHEjwWwnIypGOBH6H+BFuXbp8Xut4AINglaAv0bTySJgJh4MAuFSfQVyUSY+dUbyMxaWhaIDt17el5AFDq2Bsbx8tWBmeyR/wUUBeSEhI7QtBnKYjyrn7fuvJ79Q2PS7UVawK5qLRQXDuXvhxxq06pzGgpN3JD9RI+r0gLYnPgr1bdklQn6i3jHiYoDeMKt6Jk8R2qDEa1bhrWYQNl2XmNi6wE9Hkka2Pv0GoJyyDoAz7jkhkYcMgXqmoqoweXTcz6C3Vn+FhZ5oyitXZny502V9A2ysK5hiwknoZMLNkDhYunU4s8ez1iptSUWK/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxPHzjLAfTm5jRH8Ba8vBFRZ8nUTnpQj+HY6rwFiE7g=;
 b=1dk0Q7+Wccwe+z5OTgmAMrL+iiM+B7eJ/A/CSZ/+9iprHy5DHDqe5Fz+McxFaq/YuFa/+gW6St95xR+uaSRr209u5mwxJNBledUJDjnf09N+bFV2nsKD3+HJVkof4BxWMAXlaWYfXa/v7U2v7ljKXEQ/DBgR+lT1SeTuRzNN89M=
Received: from PH8PR15CA0017.namprd15.prod.outlook.com (2603:10b6:510:2d2::7)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 21:54:49 +0000
Received: from PH7PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::1a) by PH8PR15CA0017.outlook.office365.com
 (2603:10b6:510:2d2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 21:54:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000C.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 21:54:48 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 16:54:41 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v3 3/4] x86/sev: Add guest support for Enhanced SMT Protection
Date: Fri, 16 Oct 2026 21:54:06 +0000
Message-ID: <004b0e0058a17625876e689490d359e9314990f5.1792184487.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792184487.git.prsampat@amd.com>
References: <cover.1792184487.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000C:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4af28d-b2da-43bf-6f60-08df2bd0195a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|261009223027099003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7RTtZ7PjOgtjTUbjs47H3s8G2rM9Tb2QlKwmRWSQzIBkkrLNcw4FGzkVttARB/AKu7k31BXZ1RXxKplSayLjiUE41s1bGoSEUjCIiSWvQZMJYav1/a1pA4T7irnH5kSafg2oBYt7Wsk8mazpgwiVPmQTsrGt+6khaFWoJLIKCJSSmnXjO1SS+JFUI0oimyjtPA/TFsRZjxpx5UTp4KQgXcGS6X7O06px+XrxEfoaDUpXmD+HOn6ouehdMuUAIIVX4WjjC1vLUnGO1PlkSy7fZCvDZw6r1CiS4BjtvWcWlZiNDkzeU6xEK1CLbLDeSSlMAy7qnPK3xNNarFH98egBfZPmWmlNjqTPlhtjISUjUB6Cdb51qYJt/GptCRdhhx9XdBQ4kQnzssnDH02kxYqPtyvMaHAMvsYDqLP7wK35XUdfB+GaGVsyh38Sn1HEm6aNZDxIFPoRtzxPJZ055ij+2WuTjVyKwyjHebZx2jayjPDl/nUKoVGY+hz0mP5J8s3SS+uAuAutBYw3CnjgKEZk5wTouZ2J8edPnTsnXfwT2npfUVn6hRHTuqaI1MwEPo5TBvlD3iRcLs3s1KwtWGDZkK2DmOz+EdvkpL/ja5YY2FWQUijSwN5kMIboPzvgixaVyNe14Ld/9GrTtFQciLV4KN/w4279AMwMWKZ3p0Ri8fr6r1u2TlxDUhHY58clZBhC0EImqTdhq4VDIMjjbksVbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(261009223027099003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/DuvLxsardk315BVPS3fBWfcsFpLT2PHr7YffCI4Wh/g4hWE+vSUgOFPAfwYnaevgKoQDXqQcGfPZ/imyRwo2WXp1v0vD57bNyH/gE6Tr+kqqN6Wo7zVnT9DUYV6bNBP3b246bPfk/dW0TYBUC95lXY9AAqXqq5g/PiW1Vvqh5iB7NONkxm14/12Qe+ongXM5QCKMnAtHfd0HZ8dAHzfbaEmyj6eAl8xSM60dU5+ehj22Qw7uMdn5c0p6s+Zk2CL9EesVyVqPJ9DVSN1wqfNWsBeqxEbMyRo5CtO6J2TjnfyChusPKW+SulDBopD99tQB7kkqKRO/zzkD8RJJoiKIsofWKJ6cv9t1iqmTh4+aRuyxJOIdjw+MhflLK+vjsAP4E+hqNjXLUsxMsnpQCScGy0QJwvJBHLCnosOvisnKyVwj0K7uk/c5lqKXq/ldabL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 21:54:48.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4af28d-b2da-43bf-6f60-08df2bd0195a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

Enhanced SMT Protection requires every VMSA to carry the vCPU's identity
and the mask of SMT siblings it may co-run with. The guest builds the
VMSA itself when bringing up an AP, so populate both fields there, before
the page is turned into a VMSA and while it is still writable.

Fully set the sibling mask so that all threads of the same guest trust
each other.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v2..v3:
* Collected Reviewed-by from Tom
* Use sev_status to determine SNP support for guest as well - Tom

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
index cc292d7c6fd1..b89766bb9365 100644
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
 
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
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

