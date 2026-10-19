Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444103;
	b=5iBWAhUMUhZPeE4wE7TEC/2WitIt+HGXE6GWuRKaxk+CBo/caqYabahOD9YMtMFYJKup
	 61618khfu0GPOGzNip4etsTGkWR71p2vxi5Y1xiKlc808h/oZ3oil9flriMnMZWutL4M1
	 +NEQjeVTfxCMSFGoLGFae4fX7nxv6M/NGw2mlJOhOvjZVaTY3ijq/w6VB6jA7QUi0j6SX
	 VaN/szLvwiie9UT3PuBN3XNGvVdIddJK0a3C5vyG6GRYDFGvD/tA3JcPI7/zJpmvMeP04
	 R60k3ocs+6E7b3FbD1E9sH/NixYdvXouWZD7OdKvKEK+52WAgmorIODAOGEY7uFk1PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444103;
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
	bh=fhhso+XXNCa64PZRMGSbz5Mte+fVfak3No7DcPqjeMs=;
	b=ECWmK4o4PHpff67cIU2S6FhtyUG3y3aXPu45lh/yBSxz+ckSvmoNoR+L1j2GPiu72x2f
	 Wyk+JPoGGcKxZHsl/oPt6KdquQoA5EIi/ed7/b9pQFLdUi+77cJavHrLAfmDMsJR2rIvo
	 yuPKr8DLyOYUVS0WRiaiWJOBFuKhXqn5es5fhm9btqwhXYStjWHZeTM6MjnvhMYKVySp6
	 UY51shEQlDvO7OumBjdH//WgljHg6wo+lJgfxti1lSqvWCbe5COdAbNjDYZdEVrxwgz8q
	 3xM+F7fegznPlACA+IbXLYkZCNvtv6kgKUf7lfcbRf7eGY7BjGKqJSs5G1uQEpvrfFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yDugLpzb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AC606A31A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D08AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yDugLpzb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S72x6QIePupD5/uAnB2NgEFoID3qK2eUFe31BrKnoDnwzL9SW9/wQV2fW2xgOYgcSVu6qJB2IcyP6vu5tbyeWKdkpNbkG4NSgkouYBGnTa6NAVKS7jFZUatNrFbae4+aqlRH6jrwPQfzyg1dSCmmTDUtVrg0AMTQD8yabu12axJA654aguHBasllemDWt7TKCQr0ITFL+m7xrCp69scpzNKxMKyj6UCK0v9OhdTQ1wMTulMEwk1CZ5JzyKRpWQ1qmJRkp+UT+NQ/2jaGpp4Boco1fh0PvrhfDmY3sGChAsbj/XQx8kvxEtFECtvc/UXVCQ+v/ryfPsrgLynkkGto7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhhso+XXNCa64PZRMGSbz5Mte+fVfak3No7DcPqjeMs=;
 b=V3LLdKViIcJMCyUeHg3sge9js54mwIwg52QdIsEyCza08F3oJgRmdDfKK5cV4voARH8D4ZVeYSe73Lhm5+h3FaK5VbNI7MtWnZQ3DvM4P1Ep3u7hGDFaHaRf6TmSpF84Em0YYyLWvulY8BirZU1S6iWYxcROiQ6vupb9YStpk8aprXlWrWzOsIhsuaeBNEfONivNv8p4YSwaMCazWt90/fDl7BY+oRX3ZAI7bbgqFUmmuUq6EFh0J97htEIXNQ4bBxtji5UlFgXNJvJ1YQf96Y8rmcRXjo2frV2Nt0R8T3/n+pbjz86FOmTR9y7OGqkoHaFhnsfU3jlvdNaIv4Eu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhhso+XXNCa64PZRMGSbz5Mte+fVfak3No7DcPqjeMs=;
 b=yDugLpzbNYMAt2xzbg0hhXUAyEu94mj+IrZJ6tIelwP0/FUzwXJZxrRMhOLt0gu3ZSM0FWPiC3ornKZuUzgcLv6SYLTZCqlEnR2yV6OWg7gIL+GBeFLUefRLISlaA9bKqaFga0heAn3Z5sMT+Hw82211HAZvHU6muwKsOCLfEkQ=
Received: from PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::10)
 by EAYPR12MB999181.namprd12.prod.outlook.com (2603:10b6:303:2be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:08:19 +0000
Received: from CY6PEPF00000049.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::28) by PH5P222CA0008.outlook.office365.com
 (2603:10b6:510:34b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:08:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000049.mail.protection.outlook.com (10.167.247.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:08:18 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:08:16 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 08/12] KVM: SVM: Support LBRv2 virtualization for SEV-ES guests
Date: Mon, 19 Oct 2026 21:05:28 +0000
Message-ID: <20261019210532.378628-9-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000049:EE_|EAYPR12MB999181:EE_
X-MS-Office365-Filtering-Correlation-Id: d347edc2-473f-42f0-370e-08df2e25195c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rwvxmdXPSRCthM+mJpC66usrta6fRkByakIp+vL4SMh0Rklx/uaVLqBHqoE2ytjeuc4K53yecxzPMIeBDT4/2Mx0fF/L4ntcyyPOGp+OYSXWsVO4o/q5Ek0d+e2IhyJgsYMfFzJ9CRjs7FIgZXfyCSzgrQHGoTrDMmvBiRZSdFMXD24Rcj8t4Cy9qeShKivCj9lbQUl+ThLZeGZkdQh8e05Tuq/8YUexiUljeyJJKkdvnK5WVke2o9YxiY6NpJ4MZLvE6JzfwVmomFTe5ENsQxXY6ePYAaWdKR1WPxMrATHzgl8uzaJrp0ie4pDrChRVZzDse8+sGlGA8RIU6o5GG9W2QFcQOF4fe6PY72uorSaJHCTufjAIpnx8dxnTSjvFQuW69KYQgVpZtv+rLls9MaQ+qudtWdZpQn1bTrV1G2aenAGcaFyJQgZivT5nx/QgImllE9WaGReidbzzea3e6CnI3YzpWV07X1IHum7KDMWGFh3ptyqJ409YzjiqVfDKrGs4qj9h7ccqahOryU7zS2rEwiJJ5i/dMgKVL3h0N6LP8AueUD9qlFlxxV1emISEpLe93DyeMwenp/UUL0UW2GzkJ4PpSdkRV8ngfn4INlxSET3d0IURLqJTEF3tNLo19smW6VC9D1rcHuzRyCQtoYQZmgTgQuaGlMn0qRvjDAa1FeQ9P0so9qn0aBNSEEfIfp67pSZ5kXUpM10aytdWnA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iICW8nMG+5bEZr4+zONL3tfdv5vJRlmR0kfn5snYle/P/iW2gHimxXYYjitbEBUyjmYqmjIKg1NCt9+RNFP3gKfrUhc/UxXzM1dIT27FhsstiVYNnR4TAwHxt/MIAZhyFHkjp8rg6rqWPE+FYvZRoPQ7iJFWn0NnQLr5WKf6usLo+zZqk09uvfh6soWd/lq6UJYj+EfhGDtVj9Dp2HmjNULVsttZNzctJEvAe0C2ZVQq55eD3yGPZzNly1ClbK70y+eGL1m3eOCQoPWEHuqDCs0H3nStesDLmyjN3Mta5mELGXhi86GzxJoZcTzY5tdBxbj92T5LMi9RnRTkmZO3b0+hhZ0hJjdj+kwveqGAed1Hp4YQxIUn29bf5BhENofTtyB+S7OnjegIn/N8l9s48egiBGq7qnXPuG/Kg6phuwjX4Pjpg8xIpwM5dawFtlgp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:08:18.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d347edc2-473f-42f0-370e-08df2e25195c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000049.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999181

Add the LBRv2 fields to the SEV-ES VMSA save area and treat LBRv2 as
always active for SEV-ES+ guests, which run with LBR virtualization
mandatorily enabled and keep DBG_EXTN_CFG in the encrypted VMSA.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch.

---
 arch/x86/include/asm/svm.h | 12 +++++++++---
 arch/x86/kvm/svm/svm.c     | 15 +++++++++++++--
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index fb42c6806655..0473e38e33bc 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -446,7 +446,8 @@ struct sev_es_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
-	u8 reserved_0x298[80];
+	u64 dbg_extn_cfg;
+	u8 reserved_0x2a0[72];
 	u32 pkru;
 	u32 tsc_aux;
 	u64 tsc_scale;
@@ -495,6 +496,11 @@ struct sev_es_save_area {
 	u8 fpreg_x87[80];
 	u8 fpreg_xmm[256];
 	u8 fpreg_ymm[256];
+	struct {
+		u64 lbr_stack_from;
+		u64 lbr_stack_to;
+	} __packed lbr[16];
+	u64 lbr_select;
 } __packed;
 
 struct ghcb_save_area {
@@ -567,7 +573,7 @@ struct vmcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		1912
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1912
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
@@ -598,7 +604,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xd8);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
-	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x2a0);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ea7535ccc3fe..d5656e047dad 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -761,8 +761,19 @@ static bool svm_lbrv2_supported(struct kvm_vcpu *vcpu)
 static bool svm_lbrv2_active(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	return svm_lbrv2_supported(vcpu) &&
-	       (svm->vmcb->save.dbg_extn_cfg & DBG_EXTN_CFG_LBRV2EN);
+
+	if (!svm_lbrv2_supported(vcpu))
+		return false;
+
+	/*
+	 * SEV-ES+ guests run with LBR virtualization mandatorily enabled and
+	 * keep DBG_EXTN_CFG in the encrypted VMSA, so KVM can't observe
+	 * LBRV2EN; treat LBRv2 as always active.
+	 */
+	if (is_sev_es_guest(vcpu))
+		return true;
+
+	return svm->vmcb->save.dbg_extn_cfg & DBG_EXTN_CFG_LBRV2EN;
 }
 
 static void svm_recalc_lbrv2_msr_intercepts(struct kvm_vcpu *vcpu)
-- 
2.43.0

