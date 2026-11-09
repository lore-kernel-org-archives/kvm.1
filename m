Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794256576;
	b=kO8vEnF6RPfrPAhD8fZzbxXPDCVPxEAfxbPOPLc/VFY+S9jqfZjsUMo/RBB3BWEoj6dz
	 Zqx6688RYqgMXJlsxHhSfWbDuCqmbXBdpetNzoRdv884hODruklSF8joT861dCVOHaJEa
	 E3+mwf+oKMoriwr/AIkr2FgJUj5KUv5psBquBxw9boFmMqBLdzkLFzRl+uIsuKDyS2Vp9
	 6sW+P0Y9SJAEEwn1DVnmncGE53utef7TegQSlqV27/5crTQLxoF626MkcyyZKgMMKJaet
	 mJTvLHdGGDnUwT5kigm3YlpiOhwC3ESQpmii/5LNgYM2+qTHmBIcJl1h93j0UHfBQQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256576;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=f0Fvxz8IarrM0LqyW3sZn+tRqrgRRI8tdzDpB8mCZlI=;
	b=TXyW088idatX7L0H0sLyR7lcWyWZwwVmeaQlm0PdGldWfwsa/cLxL8PRoMAVkXGf4n5s
	 Onn2Ihesf/Xp39qQUF0qLq6PoB1eBMNbW04hJiv9QKJfqkGrAeUYvWvmLk+mOGk2TM8B8
	 moNw9S6Zhqayq6XbKP/hoTzmJni2TIlp34N/6yJlVpFCEeHOKDjLQm/DQzOiNe/Urt7gk
	 Z6L4OOIZZAOPeCy0oYzganNazDABsH91CMRQl21K48SdO09vo1YfB6XZxQb+Abte+lKis
	 Tm4BDW9VAUM7rHXnS3dg3xrp82UAJzGm3L/JwVtWA4W4I462BGtH5lCzzF4rEHdGO2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2AKBLNOf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E838606A31C;
	Mon,  9 Nov 2026 20:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E838606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2AKBLNOf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFysrJAsE/bTZrOPG7huk3M1loFXfTsSWQud3hMWVjlJLH+MZKDnenZDQUcOb7R3WOB6lstY6NLCRjnFaQL714Iv2MPnvKS8URKb57iD2fwoi2yVr8sxbhSiEOzFukrZlgbeV8/7EIznaBYY7OqVaQah8z3jt5e08m5y1NjfGJXKLW9CSSjt3XB66GwJN6ZuCtFCMMru/KVIfDD813TXPdClvnFed/4qil2MiTJnbuZd1vNHtx/70GIQIFh/Tkwl8UTBvVhC3nBAbzIn6THsLP7xUbU76O5WYzCV7NccrM2B2c8gGfkrAW1QaOKVAYTdivSFOpwIqu8Yymvc0EU3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0Fvxz8IarrM0LqyW3sZn+tRqrgRRI8tdzDpB8mCZlI=;
 b=dqMQu9VqirS0j/jDjIuBYvy2mGlBCjoZUNp9LDH+scusKvijSOOlZZ0kiBDnj9EM3P8VEaWVESZPHngGhUPzXPkVhjLh95uMUK/2lqSTvk1Dd1dOwfzGdYEE9vEKpxAdarYbmuijriFxdYgptURwN4zN/MmSXhj7abd+zB4aqkoHSndBGI3DguObXFmjlX19JboR5FIFHock4rd/iwxkhq+91frrblfuzOstI+JFhWplQr0xBOyYgRt62rUh6txRCSpjzoEyW8JLM38MlD4Lv7YDh5ll7NQYvXaOBIJryyG+xcxRbUPb2uesYUNRvHlsJLeHjRNfxIQpvhnOeWz8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0Fvxz8IarrM0LqyW3sZn+tRqrgRRI8tdzDpB8mCZlI=;
 b=2AKBLNOfKP+/yNLTHlhCljRNKSGe4uSgWD3e90f+zvtvn98tx3Q6D91foW2RT3//1r7M3RPn2ksX9pVGoIUfzMJ0pdI6a+VUISMcuYq+eCKGHZjNpnAmI0AQ9NzdoGnaOu6iL3ghJDHJ62q7NloEDW3pN45BMTJEMOZ7NGJtgSc=
Received: from CYZPR05CA0040.namprd05.prod.outlook.com (2603:10b6:930:a3::17)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 20:36:08 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::2b) by CYZPR05CA0040.outlook.office365.com
 (2603:10b6:930:a3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Mon, 9
 Nov 2026 20:36:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 20:36:07 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 14:36:03 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v4 3/4] x86/sev: Add guest support for Enhanced SMT Protection
Date: Mon, 9 Nov 2026 20:35:13 +0000
Message-ID: <c64b614ddc83eabc6bb1bdf288272110df04256a.1794244450.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794244450.git.prsampat@amd.com>
References: <cover.1794244450.git.prsampat@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 039191fe-fb97-4bd7-64f3-08df3ea11534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|261022105027099003|261026140227099003|261021121427099003|56012099006|261021123027099003|261028144727099003|261009223027099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GWjR03fc6EqM4rFw9zJhTnDWzzQevPcrf4CIImzAyKSl1w0X/71oEarvFk96ir9/6wVOJGvkf7VnEDP5tvDw2EnpWRB365ep8ygPpMZk2HTnQ5BebwvbLdsFZDVtZ45cmwIkMwl28GvYcnwCZTPTQPMTLRFB/C+VAHF5RoT81gy4P+uzLyUm/hMLiRJ3c383Tomb9XX2Daq7NpevWB7UmBqWDnvz2CjM3jYvvd5l+fEsOq3HYFN4YZEXwKKassMTPOghcwXGT5y/EWf/SlWomc/1lehk7i0dBnKagK9wh5SyYIjtiTSGxyK9WvcekHaC3IMnBu0aZJspEOki8sLLSpCyZ6r+51LWEJDJXKdJ5x0/3pkld70xHVuRblTJU0mGyCFf087F4AxuffdG9WywnIZqKtmgvMhhLSxbZYOJ+QFWrzt8YYtNVV41ovn4mwD4C1KaoKN1xPzNslWCG9NP7Al2ExWRamH/RVlRCvOpikETRs74/CQMRVYp/A5MQlCayz0l2tSykotGKAeD75Ak4OEq3+zY8EMA80ArRMwlgawICGaQ/Lkg/xRXQTLEjVc6Dw1PNIFTm8AT/uSV0lBv5Zaj8SeVVs+qCPF8MSCYHBQRQ/N+bhZF98SPjpj0JpRQ/bJGjy+OwG55xWK++I2NR7xG7D5DnJMeA1nA2rORTyrLBF6KrDt6XAXMWi/TMbu5BE22JuOw/xH6IOQEuJWL1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(261022105027099003)(261026140227099003)(261021121427099003)(56012099006)(261021123027099003)(261028144727099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	shgQrhK68z3nU0yWAnNrlKmjZWpjIlNROcbHCcKGcReJQE8lPpM9dOYJsjCHGg7yQonSuymyGVrQ77xWipk/OZKo+MMlen6wGslkkS8E0Hq2XyuXtm5aYfJb/KO1kffDqgLWbFhY15Wf/en/HTG2uiwXkKiOttfyvG/KQ/6D7LEssbTPijpie9YF5dGk26a1KHDSeW3SLBQfD9xcf82mBDzw6hvZm5aYMrI3/2qgK98SwVSQWXSkpUFSREcflKdPz3xwJpQVRVZsxYno/GFFJ06aTnbp38/XHHfkoDN6X5748gLqxw/70NlmdcQCeNqkbQqyNbGpX6OjOnFei8IB7ZG4phlO61ChDRt3QOqmf+0GBipClDYC2mNc/49vR3Z52b6s/PCgm62P3eW9swu9jYRLQfhGH4EF+wxzUIX064/84dKCsEGW781vL5R82+VN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:36:07.4965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039191fe-fb97-4bd7-64f3-08df3ea11534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469

Enhanced SMT Protection requires every VMSA to carry the vCPU's identity
and the mask of SMT siblings it may co-run with. The guest builds the
VMSA itself when bringing up an AP, so populate both fields there, before
the page is turned into a VMSA and while it is still writable.

Fully set the sibling mask so that all threads of the same guest trust
each other.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v3..v4: No Change
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

