Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299464;
	b=sHrHO8GPxTLaK59Vc9KFO15En8Yxs6hj9dFMm+l7fDnRJ0MvzZqB4PuYhtDS+6AbpgJv
	 b+kU1Rt3IrdYyZ/Hs+e8REIjtD8Z0PNuf2cMey/4vk6gIVEmZrgAcSNbLKFi0xUo+lvJs
	 hE0DkqGXnAaXHvDrR/FUSKh7Exy+wJtXZQK+U+gFj13lFeYuUhidgfzRT0hCBlnvMurLf
	 Y2Ys9RZOgIetbxYlCM0Y9qHB0fFO0lMBYF/mVd2gMfW9j3q5lIz5Zm1EdtoArzTk2DIiB
	 d5rWFw7ydDYO16YPF1K6AEZIpJ3i+1RRUV0mZnZpKTj5c3ZepH3ZIgWd7g8Ay3gNodQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299464;
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
	bh=vx57afOsVswwH5SVISrir1FZjk1kxbH+tarytbAqyzk=;
	b=4ADXGyWOFPtackjaMmBzydYN2HgPEvobsIv5my2OJhwHc8ejGQQH7DLu460yVRZvFbqF
	 kA8r0kKlcsPFwvIZY/8C2eFpBR98D6pFFjr5+c5P0CT+jS9qBTALycRWy2lWs+CUi50iq
	 32xq+VcC1OLFbpibO17qPBsd5hxy9u+W5KWIXJQa+zeqItXiPWe5kl3QYCNUcaWVjwcqG
	 iWuT4lc+A8ogK6du93i4tx++ZfmpmnybWBLiDAwH5zgWQ9Pr9YVAbZZGHZuguE3rph9Wk
	 d0kUpcjQ+aIgF1HFMU+v0ZOibA6ibsjOP+s6/ua0NiAKWlr4jcAaKoCS2Qyxy5JlkuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ER3ZLnv8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.10
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63706606B9F6;
	Tue, 10 Nov 2026 08:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63706606B9F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ER3ZLnv8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS5xaNlA4Xk8hQuncfnD21Xq26SqABdW02uXK1FbxVMsdVuoODM4LMp5fchRMqRCbb4sZGaCx+VW+B34BX2HxRWUKBneE0Zvh27+2AKp6xguna1kh2iZ7rW213GQO0fKRwwlxzLAMH0mK5iVLNa7QihupbJLeCsvl14LXF6P02N3ZbEt8JyS+HLabiy1YgzUaoEFpboPMkJ9F4AkxhH6Uxgm/2MYTEHtlMDoYioSthJUO7TD7co9GYBQa0MgYcbk+lLNl5Yye9wOOT1dyfRuEOz8tN/fdBKzQgJjLClKaL6m29/Kh1Jvc86048w/ABftnWViUzJtwmsrBDtDerJdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx57afOsVswwH5SVISrir1FZjk1kxbH+tarytbAqyzk=;
 b=K9YDhrp75VHYdnDZa8aYHZy0W+7R3/Tl/E5yWl4fZqwvSNEtBTQv2dNzx0zNKEycNz5WEg/U6hKunVvf7OVTpwJqWW5ErC5R6/XODOo7oj9JRdZv/oXnr0dJN35fvjICFlhEdzJhtfMgWrt8reU6vSk40l5UZAgN8eytviiiwInu5kW4B8I1DgGph2WXh2F0Qhd5g6GOMIuav1JYEMjwnkVbBnFWO8VAvvfKqaIEzSrtBmleV2spdZqej8jJ6wQixSGj4xQzAgJWTb+pW1F9t0DCbAfcTzHk6vsvlzN3MXfHQcaUI95dB27Sg8P7cvJOlo2GfLcaxtseSgdi38kRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx57afOsVswwH5SVISrir1FZjk1kxbH+tarytbAqyzk=;
 b=ER3ZLnv8aPrdsZ7Tzhe4JFZ8411hNK5NLZ683tRrdjvgotTkL97T818F32aTZHrjd6iQPlgpbHeTTGjuDWCaJzNjvEyEQIYVx74YUPphluc1jfFT7hJBKWYndyNNNGIHqV5nx4PY/kj/ZUtgLSlbhxt/V1nbH3G+5Z45hmm2fxk=
Received: from CH2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:59::19)
 by IA6PR12MB818206.namprd12.prod.outlook.com (2603:10b6:208:5fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:30:58 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:610:59:cafe::6e) by CH2PR03CA0009.outlook.office365.com
 (2603:10b6:610:59::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 08:30:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:30:58 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:30:57 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  9/9] KVM: SVM: Enable Alternate Injection for an SEV-SNP guest
Date: Tue, 10 Nov 2026 08:28:54 +0000
Message-ID: <a6cc7810268bcda31aa5ba89d86fdffd5a2863cc.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA6PR12MB818206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dab755c-b69c-4feb-e5ad-08df3f04f22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|10067099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	QgQfKK++ujPA6tndyFK9Kn0UEyTOo2S3+uG6WhoZzIhxGIUXMj65Oc70B/nkVkrsgam4gmWGVRCAKtXM7QktIqB823XdzCN0W8ju9VCJFOaJJYigstL7y/5G9Ba97vQJIkTFBoxV7Mxqbhr/kPapjz2zQE8F38qLj6ByVv4mT1/K0jkUP/Iqc0PTTLMmJJDZ8NKKAg3Nvb+eqAMZdrc0t03wSmHY4gGiTTYeDw1P7WEiq3eNMExoApHFGfvgW8A/GIsQxfmpebwhjHhrZEbrzKIvThrbePmnIAzXVA9IsY6xKOX/xl/YB2zm28RJXcZsjvS8knmRWsc309WaIqMEFWx+eM6itbmRMryVaIha0e1slARczP/S+lc675LXMv6vOK8lZ5nd/Y3528yUKWCxMsFDaw6zvh0GXmsRpr7fOS5qwU1WOfPvuAapIJUgNfjwqDlESgqBCVH3D5Ubn6uxi7+d30eaLlueGjP2XBxVt5b8JFpp20Z4m1H/7yrG4yNit3r/HKKCYS2oaV7oZlQplnssxnLDdKANE3BeCka5bReEkXRduqZt0tVU5Wh3ae6c1AqGARzpy0LaG9pWfdHpMCpV4PRHKBSsVeJGkyOk+nt6oqqY0on3YaGkRi23moSomrzXT8ZNeYHloJrNF3DIV/JkjuRzdKAiRgPdputpriKx4copzn6y6/IFdBFaU9ZvLeW7WIR+4OJJERAwQ3HSdg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZRhsEkPx2LGKjqSe4VKRxSq67yW2yRgOXnQod0OLtjkrpoGPWOC0wyBz7lhP8DF5HAkkPqS8RBEpTye03rkSjjnjwucy9Qsddxfvj22VryypUTXXi213Sc8TO0w+vctAGwdaziqw766SGxsj9IPSsMAS94CYnoVXx6BPK1uoGUgpw5ctuyjjmG13OjOZKB9dZviYG70kRRyTVFaOGR2j05yxgqoKM4tn29Ub+qIrvZhqNFMVKxXkrZ1Nnd1PtJuYJlsqonWat9SLbSDMzddJMbcc/fZ/J9uPYlB8NvgYO4hQmdC3FIjtBRvQlum8Z6qnQIviKw+mkr3z+uxYxQSCe898/gcQ1kcU72WzZCbzyVQaMQaFAj9gVzevcyNH1y0l5Te0Bzdzs4c6vzy20ALubJtUiGuziuZLEUUyiQUAGQt0RYYNMdh25OoNluY8QwLX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:30:58.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dab755c-b69c-4feb-e5ad-08df3f04f22d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB818206

When the SVSM detects that the hypervisor supports Alternate Injection,
it can configure Alternate Injection and create APs with it enabled in
sev_features.

Add Alternate Injection support to the hypervisor advertised features

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/sev-common.h  |  1 +
 arch/x86/kvm/svm/sev.c             | 12 +++++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 41af7bd2473c..b2746a4d926a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -454,6 +454,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* hardware-enforced cache coherency */
 #define X86_FEATURE_RESTRICTED_INJECTION (19*32+12) /* Restricted Injection */
+#define X86_FEATURE_ALTERNATE_INJECTION (19*32+13) /* Alternate Injection */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index a09cf5690aba..62f0c3aa7549 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -145,6 +145,7 @@ enum psc_op {
 #define GHCB_HV_FT_SNP_RINJ		(BIT_ULL(2) | GHCB_HV_FT_SNP_AP_CREATION)
 #define GHCB_HV_FT_APIC_ID_LIST		BIT_ULL(4)
 #define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
+#define GHCB_HV_FT_SNP_ALT_INJ		BIT_ULL(9)
 
 /*
  * SNP Page State Change NAE event
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7846d4ebb278..fd0212abc3af 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -44,6 +44,7 @@
 				 GHCB_HV_FT_SNP_AP_CREATION	| \
 				 GHCB_HV_FT_SNP_RINJ		| \
 				 GHCB_HV_FT_APIC_ID_LIST	| \
+				 GHCB_HV_FT_SNP_ALT_INJ		| \
 				 GHCB_HV_FT_SNP_MULTI_VMPL)
 
 /*
@@ -72,6 +73,10 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
 static bool sev_snp_restricted_injection_enabled = true;
 module_param_named(restricted_injection, sev_snp_restricted_injection_enabled, bool, 0444);
 
+/* enable/disable SEV-SNP Alternate Injection support */
+static bool sev_snp_alternate_injection_enabled = true;
+module_param_named(alternate_injection, sev_snp_alternate_injection_enabled, bool, 0444);
+
 static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
 module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
 
@@ -3242,9 +3247,14 @@ void __init sev_hardware_setup(void)
 
 	if (!sev_snp_enabled || !cpu_feature_enabled(X86_FEATURE_RESTRICTED_INJECTION))
 		sev_snp_restricted_injection_enabled = false;
+	if (!sev_snp_enabled || !cpu_feature_enabled(X86_FEATURE_ALTERNATE_INJECTION))
+		sev_snp_alternate_injection_enabled = false;
 
-	if (sev_snp_restricted_injection_enabled)
+	if (sev_snp_restricted_injection_enabled) {
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_RESTRICTED_INJECTION;
+		if (sev_snp_alternate_injection_enabled)
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_ALTERNATE_INJECTION;
+	}
 }
 
 void sev_hardware_unsetup(void)
-- 
2.43.0

