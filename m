Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D32FF669
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610421; cv=fail; b=RJzb4u0F5EyeZAQI8kBUc0NlbvgV2Cn4CvZ3DKab8Z2FpNABkaAfXow62YD0Gm3wb7WELOCg+S4uEIlsH+xVtwtFqqWfoJqkuCr3u0qifo1y7xFRLybdEYYZWqZT1k9/8O75uhzlN4IqOODOvgu191212lt7OvtIaG5tELOkPpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610421; c=relaxed/simple;
	bh=lUAY6RfnhGvSuKOqXYlbCiWrWP3Aat99rrPsq95l3Xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWHRo9+AwhKItiO0hBmfj6+nZGYH9CWwKvNacQSnX2ANZXSk/2pnnrBdHTeWNPY4QzdwJBHS2pYt+gKvilwH6kzrtvu3jT5svPKobLIG/nwGJJg4lEv8WlzUndww9XRreRx43UPyXDtqWa3NtxqEN5bk3bMJ6IEDoGvDIDDv9cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Ne84Mq5; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Ne84Mq5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZ6AE8w/IO+Z2zwz+CDAs66gwrsO7cX5UJ3gJPpqXdiW4ZF0gksyj6x0eGk8nnMNzZb81F9uc3X1UNvOPUuXjGp3Ufawgpp2i2K1gkPAxbYqKc4N9PVGGMiiWGG9wZgNU1s9aW2f0PepH/6ueG0P9XGcyYs5WTgkanL3ex+/7ISyfgVuBfQKp7a4xHN5Oxr3lZOdkpzPwX/Ib9d5LDYdMxzKEvhJH7N4NM5vSFHVO5HRv0OhexOQtfgYppv2kgzlPy/ydJNmzUi/TjBJuWMRGEYS+D/zW/5qdUcvQVcyepG0oe/pfe3cTaY+Qzc8S97qpOsJD0yLm0X8PYB26mJNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB5z9tDsYhj/pOdGTHuS3LxQz/NG7rc5cfrTFu7iHG4=;
 b=tY/8RfCHHG1joYI/eALytJ4wFaly6rIHddv6rPYQSwREDf/IaN8bef4SYMTNOO3C4ysTlXY7DSPfSsk/n7oCQSlERpkBAl8u5aA+bgCpy/AV/1dDQcoqjGWta4/pyIS8FcYEFGbzNiuIM/DRVQch5pr6K62qG3Pq/R6U4dTr3VKT3SE7xWG8/U0pntJ1RHEZZIfpYMUUjQZB+sgKgZgG1K+W5m69jVr814QjNGMw1uZ271DMU+1qKc3zm8CNfDJv6PPc9I3vB6BNPW7mHnFzxdpZ4Va6duHGzhoBIuehoK1RXRqXmg9T7DJcUTep3UNxvItGuA1QOAyQHRiif56ZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB5z9tDsYhj/pOdGTHuS3LxQz/NG7rc5cfrTFu7iHG4=;
 b=3Ne84Mq5UHp4yteQE2eAjICj49+ymsjMmnFk5y+7uhXRhekr8bLQbcIun/Zbr1md7BH8oxS6hGNM2xLQrFjooWiMGIpWw4QDXnTCCYm8rkjk6fcNPifjdJ/rdCJNFaDZepS9rsiPL3OFe17MsvlLxuwTNdkHsK96cKheRE13sUA=
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:06:56 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::50) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 05:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:06:54 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:06:51 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v4 2/5] KVM: nSVM: Disable LBRV in nested control cache when unsupported
Date: Tue, 21 Jul 2026 05:05:57 +0000
Message-ID: <20260721050600.87268-3-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721050600.87268-1-shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b510b1-58c1-4db0-84ad-08dee6e5e23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	V3AJ5qsCy2zPUDM51vsod6aXLJgmcEb3oU8oBGUFzwr8V5MnawJBTV2Qn20myejQaohKDpka6BUdjE/I/MeJ5Drim9T4GjPbZjLnDXwTQRVwVGlHx7KEf7PdMD+XENGg9PtsYSlU3spdzDy+kA4v6sZAWjhlcWMV8EjqabY5wHC9f7kzfLhs/CvU5qzogSK8j9RwHSMJqAHsPMFDkkqppP6CKnuXnZug3L+tEPFE2uGQGolWdYsLqxwu2LPHMDdJwkj46x4RhOj9835FlvICTwDfXD0odv6uEH8+r/WR6djuvY7iFOeMWjgjLoaMfGw9V42P+zYM8n5gP7NVJMHimuMfEl2pQ7YEXKiWdqLqOhdZOJ5UvnvebpHY7wQWYTcGU5FvMrlQFFbNaOkmi/y9/5jMRoc7grERvjL2n/bE77MkeSbsEY8yNfPgjBkjmgG2gmuroYGtQU96olBrRiY2DcMpN6+S5Z/GnwfIosKNNeZiVl3jV68iASVX3fYIBl8uUmmY6qy3uQLdwNm5I3twX2STFiNm2h0KheATTnGXQ1/6lHKxlQP5BbRtiK2He1KRWiwYs2apHfjRvgHFTGpla/wGuGqZUUaxRWRLuK1hQ2RnbWWc3jVspvIZ2UUC8Bdjrgn/WmtR0ZKpIztFUybWhNdL1tsyq61o+KHXWgDrBO8LtRaD/roYMqkpuu7L4RiWjlwa0doQ5d310TUpEcJJpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9vCENI+iR4VyoftF5ndi6NF3q+jxC+TWXYM7nDG13Q19lOadg/p+oASttzWCiUYMytKOgpDQ296DlVVF7adZN6Lx+ZjWkLM/NLzqrVxjpxt4LZXhDPrCwb25yX78TY3AbrZ9+IYGw6pZa5UpsEVA2lqNYIaDqG5MVySSBib5vSRFca2t6vC+9l9bsih4E24LiBVV/QD7KPdcYBbEKzHWWQjUmWPqP4YZp3xDXkmUrBLOuFfJZStvdO/vPgHE9Wxd9MLcK5RwvP8cHE2IjgTAqwXImadDri3PLhtUDIm8ny26r0gtWUsapYAmwsW6+OaizK8cGhQ2RM5DYVlZTMEk35Dqx1IKMsNjCrMFJGmr/ku384AH/jS1ngo/c5X6y9lMnmUKI5eUUOgrHCO0hBgwtCU+3Taw/EMGiXPWoHSTyZl733xHDRHObTEfkRGugVWg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:06:54.9580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b510b1-58c1-4db0-84ad-08dee6e5e23e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() when
the vCPU does not support LBR Virtualization. This lets the cached value be
consumed directly instead of re-checking X86_FEATURE_LBRV on every access.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v3 -> v4:
 * Drop the redundant !lbrv check and the extra comment (Yosry).

v3:
 * New patch.
 * Sanitize V_LBR in the cache and drop the redundant X86_FEATURE_LBRV
   checks (Yosry Ahmed).

---
 arch/x86/kvm/svm/nested.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 52b8d0f9b139..8d1967f5c099 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -528,12 +528,16 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 
 	/* Always clear misc_ctl bits that the guest cannot use */
 	to->misc_ctl = from->misc_ctl;
+	to->misc_ctl2 = from->misc_ctl2;
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_NP;
 
 	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
 
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
+		to->misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
+
 	to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
 	to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
 	to->tsc_offset          = from->tsc_offset;
@@ -551,7 +555,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
 	to->nested_cr3          = from->nested_cr3;
-	to->misc_ctl2		= from->misc_ctl2;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
 
@@ -738,8 +741,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 
 bool nested_lbrv_enabled(struct kvm_vcpu *vcpu)
 {
-	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
+	return to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
 }
 
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
-- 
2.43.0

