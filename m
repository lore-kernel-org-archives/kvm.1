Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194459;
	b=2jA0VRoDubyn+crBhMal1NURJvxGCK9IZ4aSUFf27BreXXujZjrn557q7c66KCP28hZS
	 7U5V6lMGUMj+Hd4THgFlJ6R9Kho3E2qnChpI4sP9fE0SHe1moRB699qt8BGBbCJPrZKul
	 jJELC27NBxv0ONoHo6xfLwTcc6faI//V36/qL59520IRw061TYPeXiFuHvdw0Tk7Ynnb2
	 /18VrGaS+5P9/DvT9MiwygO9u9GXcDHtzU64rKyPJv1AxO58D1Mx5bJZBT30EwT2Vw1au
	 koEGggJpNwyrqL5avbNEbaZNAOoNom8N7jchW2Qv71i9Kkxwbe45JBAargb7pawRRDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194459;
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
	bh=d35WHgpgxaTQDREQh3Q86nDso1zAf9HDMjlaXgwNHhU=;
	b=YUY5EEkappmaxQMG2xoCgvh39N/FYEYrrAcx2nDPJjhwyYUlLhFyMdgCcYi5aTiLfwgh
	 7D0sVbWybVbyTBs2E0C4jkqO0Mz23XU0MNZ0DrJdQ7o6evX7MQepZhcGc55ilnvXEB8gO
	 +caodv/FCEmkfsaWQloXao3fnZEUgevGU/0UIv4WDWwQF2NmDfqkWOeQQfYCS/iPr0TO0
	 bnP0G7Yh1NactIzLajQbXXYWPvZlJzrAZUyJiiH7FFQuJxnTgB6aLISLOUVp8i3PyNIPZ
	 sZvtbMJCvQ+O3JQd/1hU9EWCVXc4K79hWsTA23P3oDFN0yjM+Nn1ypZLeLGtsPlFSBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Yxlv5DKf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.29
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E1606A320;
	Mon,  9 Nov 2026 03:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05E1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Yxlv5DKf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUPFXU1jNZ+qFx9Bl5eY6jO5uHWtQ/zyKL4yEZLZ8Zlf2iNouZHouVghdseb+wzwAYYIdJwpWeXaLHnxne1A0xdAlx+iYQXfh44Wo6+rwRHTKkMxq57LOOU1UjBPVphOnZMV0tESOnSZMcx19Zr3BTJmuvCDKqO8bYsIZ/msQIw3ttl89UItC7O9R0J+xWh45zppkAGuE1CokfVF0sIyiixeyZrMBuhpTrAW/U+K3L278hAxliB2ciJECZtjNIF5D3GaB28ti5GDpFyspibNTxu2racP9giVs8JaeYcZAqSpEGK17tkJKKcwnZucSewskqRzak4CPiGXmRqBgzqe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d35WHgpgxaTQDREQh3Q86nDso1zAf9HDMjlaXgwNHhU=;
 b=e636y3xvjoj7v0lP7nD0qbaJFQ1KmtVyCHZL8DwxxiME1hpbGZ2Y4GZAVqyU/ggDHld0p6SRuDvPcnFtrNdobiz2keDXYc+ZfRquocpBlptHaNtKZHCgxrcON0zx21z4+4qscQ+Sog8hMUIPKp3cGbx9CgZybe30+qqAt+LtY7dvgusjGQaTH76JNm6Dv60GZTjv9koOGnxUVvd3GNYXXFf+1zsnm0StPr4zmooM/IjjYtYucF9Y0u05rhoaiDY/CP8PD1OiptZ+xg2ThcJTrOCotAcsA4sD83zRzxF3xSfppcmDOnf1VjhdmAkj+8Aszcyie384OIqQ27xVM2PfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d35WHgpgxaTQDREQh3Q86nDso1zAf9HDMjlaXgwNHhU=;
 b=Yxlv5DKfIt2BdmAYjBTY6gpl5w1GA8Hjj8t10OxdgnrDXjk0oqVi2nsTwjXEd9ObwiIiceAL3gN6KfkA72pDaCDIMantnwY21fW6ISELle7Fl2XQyaKq6BkgNUySsSZPDJ4RA2YgepIghBfylLHDVdMULnP/OxOtJZtWeX+/iD0=
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:20:31 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::19) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 03:20:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:20:31 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:20:30 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>,
	"Thomas Lendacky" <thomas.lendacky@amd.com>
Subject: [RFC PATCH v5 8/8] KVM: SVM: Enable Restricted Injection for an SEV-SNP guest
Date: Mon, 9 Nov 2026 03:18:40 +0000
Message-ID: <bc0064a430e360c06643586724098275f5bec394.1794171754.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794171754.git.huibo.wang@amd.com>
References: <cover.1794171754.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bbd297-9b6d-4a06-ffd2-08df3e106946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|56012099006|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	o/PAQFfQIvIuDdR3YyB58ALjAzNGLybLjQu6kylqHQT9vvqZ2AbnOLPW4lyIFT1Q/aAUTtRgoZjkNGzVwBn1cGwg3JpKKXRVKnZlD7+laCFhg0LzaCkBw52JHNnRVK++vlvXOQf6fAm149XjlafmJImHGRsl1/y+aBKDF9kSvFtCVDARgpafvRawxXJSGOdwuOhLyVVQPM2wuJNSh54ont5qE0DdXUWs2CbeqNBPvW6NiAAFGDK3O6tt+qG+SuUKbuNAAC4WjlJ7eZ9n79EXwoolalf5UhRfp3HtffBxZHfiqjAQ2Q9IYfysDfbEX7mzepw28epKgFWXRyjmTi7/r/dr+OGZ65qG/OrTSqVWHguSjTFaHKdkemNcgb+0+l8FaF7TSj7TIKR8FgXz5uC8uj4XPRxRHSqByuvgS41sn+oLg2UyUIaOH3ES0IY6odp25PY6PQuZmkadnfA7xgljuWHuU1QjSAYSfti3ZabjL6cQUeMK/cgAnxi3D5A71CaLO94nNiTH7WnP/oJryW8AMeeoRZbAWm1piQxPiKkqfK3B2j+eUqq3oVW8GuIG4y80BTI1eRA3TWOYutJRNRKqDIi11doQipDgc6cZrZwFkqmGEpcypRvDLd9J1xe0NqdvW/iem4VBxKY2Jizf+p/SLfI6qmWkxVfxzX7feuMkY2EDCczqHAGKMs2gmHyOJzAGclJzPuCci17BQAcPNAQhzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rcpjCZ76TayrAeQHX+9J1pO4WqNQQytCF7zs0b03bYSBnuJVHTjjsJ9DQ8/bUtKFwoJehgJOPByAzZteJ7Mlju5P9Saz1cdVEupvo2WFE7xYS2i3AlaDI1TdvGCeGcdkG+7scbrJ8IubxUmmueOEY2HTiPCTdq3jNcz5Nmfut3txIRuOpQj8C/Gfn2XCHdb8yytk9RD6hsKBQMmEbK7XQoIQ6lmo3CnD8ZO+w0K7cl4VipbdKjsGGZSmlrOYSvJRKf8iQuDViAXLBGJD4StAWiorHD8dNtOBEuyMq4FDvMvQOyND7WtVHCCGYkr3asAQcKMSi4ie7xFu2zSGhoTokIo8pli7Z3hPiwgJkF4JHkDyw2U18SqBiiArmdm59nE81CCUGwVu8Fa0Li/CecF6dzoN4QLwftB7W9/vu2INZhIYcIDo4xpRjpBm+2a2r0ob
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:20:31.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bbd297-9b6d-4a06-ffd2-08df3e106946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788

Enable Restricted Injection in an SEV-SNP guest by setting the
corresponding bit in the VMSA SEV features field (SEV_FEATURES[3]) from
QEMU.

Add Restricted Injection to the supported hypervisor features.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/sev-common.h  |  1 +
 arch/x86/kvm/svm/sev.c             | 21 ++++++++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f70ee74b5f92..c491c355fabd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -466,6 +466,7 @@
 #define X86_FEATURE_SNP_SECURE_TSC	(19*32+ 8) /* SEV-SNP Secure TSC */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* hardware-enforced cache coherency */
+#define X86_FEATURE_RESTRICTED_INJECTION (19*32+12) /* Restricted Injection */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 01a6e4dbe423..ee17a3541b55 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -136,6 +136,7 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
+#define GHCB_HV_FT_SNP_RINJ		(BIT_ULL(2) | GHCB_HV_FT_SNP_AP_CREATION)
 #define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
 
 /*
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b7c2993f8c63..a7b290d3fd42 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -42,7 +42,9 @@
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
 
-#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATION)
+#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP |		\
+				 GHCB_HV_FT_SNP_AP_CREATION |	\
+				 GHCB_HV_FT_SNP_RINJ)
 
 /*
  * The GHCB spec essentially states that all non-zero error codes other than
@@ -3261,6 +3263,9 @@ void __init sev_hardware_setup(void)
 
 	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+	if (sev_snp_enabled && cpu_feature_enabled(X86_FEATURE_RESTRICTED_INJECTION))
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_RESTRICTED_INJECTION;
 }
 
 void sev_hardware_unsetup(void)
@@ -4862,10 +4867,22 @@ void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm)
 		vcpu->arch.reserved_gpa_bits &= ~(1UL << (best->ebx & 0x3f));
 }
 
+static void sev_snp_init_vmcb(struct vcpu_svm *svm)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
+
+	/* V_NMI is not supported when Restricted Injection is enabled */
+	if (sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION) {
+		svm->vmcb->control.int_ctl &= ~V_NMI_ENABLE_MASK;
+		svm->vmcb->control.int_ctl &= ~V_GIF_ENABLE_MASK;
+	}
+}
+
 static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
 	struct vmcb *vmcb = svm->vmcb01.ptr;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV_ES;
 
@@ -4932,6 +4949,8 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 		set_ghcb_msr(svm, GHCB_MSR_SEV_INFO((__u64)sev->ghcb_version,
 						    GHCB_VERSION_MIN,
 						    sev_enc_bit));
+	if (sev_snp_guest(vcpu->kvm))
+		sev_snp_init_vmcb(svm);
 }
 
 void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
-- 
2.43.0

