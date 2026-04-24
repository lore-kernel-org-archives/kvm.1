Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C113B5B3;
	Fri, 24 Apr 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053088; cv=fail; b=Ye06khOH4iktjOAUzJi/S+MK51cilvrfUS9naMto1rKpWqbZJbHMm0ysbuoc3H530zjyUaliFU/QglrzhZg/XSwAIkJqBS99/rAXCuq6pkLFRsByfqiHVGOeydKIqpi7U9KJzfl1kRc8IXJEsvj9ZzZtFJhbKg5qCIyGn0fVaok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053088; c=relaxed/simple;
	bh=b/yN7alrEaujuTkmtZNedOLcM/qBFwPkRq1+ZVWG89E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bY6qnhfs5nqOOVpmxbbPVQfhyVdu63apI66rG92o2iwh3z+//V0LQKxmuZ4koGIKb9N0Hk1Q7gspuwa7RNOQIkWY0I/T9utCuAUDGjCNNgHm60BiB/rD8pBNo8I39uW2xpjau3+X4ALz9WPpTsgu6KUpAmQzP80zeU/M/r6qS/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x7KoVGGI; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x7KoVGGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mftRD/Cz9Huaw2F98AawisSSFPFG51rsqME2LSBXqhHIqq78Q4VWaN6lSHeb1rpS0w1HW3qUaziAafp6UoIkhdFMmWW9biEB9G7Sq0911Wn6JS3alkOcA89t20rnroTXr6mBonN13++noST7IWaDe+zwHMzcOTh5zpzSWopg4Txw7qVPvLXTsj7kRcfADTmbs13FOcO/DAkkH+GldFBVdonhoDm7Bsu2EZ+768O9/5ihvFDq7kZ+l6S1DYOiQl2yijGkukR4KfZIUEpTC1++2OJvB0SBCE2HpH68SJEW3COWhg3rbTHFnDTLCik8Ondbl9Ul3whOAYAqFPKSzMIm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwZ2B4WSWBlK4x+ZdSKQ4wlck9LiWJwzJ++DTuFWNSc=;
 b=lQbKCoCKYylsGUTsKo4fzKLdFXHYu7HbwPOeZBrXNGE3ld8xoRXKNEn4so3gGG0mhjBfXIt5vlq9i6KqNbu2slfIM2UGLHalKFsDwhtvX5TmT2H9NPIsZcLhKRkoHX523sogbXz//EuK3SNjuTkq5YAHF9ANSKVO/XoLtutjzJj1vw0FB1YMraRPkM2Xtx7gBsx7PkfUhXFZW/OSpoaUQImG0mIIO6FZwIqd75sALDQT1fiRdDpQfm9oxzhzU18e6dNSgbalu6fOADcqlJU3GkJ9Cgw1ruIJzJpUc8Y4LXr4Qsx3uzvjlDuinVJfey7JWDBO3WRl1PNiXLWNq/0RuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwZ2B4WSWBlK4x+ZdSKQ4wlck9LiWJwzJ++DTuFWNSc=;
 b=x7KoVGGIQZtn7ckFJEhrT/kCwVqNXz+1VzOqUqAx0D9Uq/9/5dzDd1YFtKHeYyoLxcsh7EQicNQkLViWQUd2pRdU2QP1QGeXG4CXqh72gJnIWeA5vJwhrJtGx8F4U0HJHY3ZfEkxSfsNfj/dhUVft7snL4EcOeWbE8KFKDOnoaw=
Received: from SA0PR11CA0200.namprd11.prod.outlook.com (2603:10b6:806:1bc::25)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Fri, 24 Apr 2026 17:51:22 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::10) by SA0PR11CA0200.outlook.office365.com
 (2603:10b6:806:1bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 17:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:51:22 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:51:21 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH v4 7/7] KVM: SVM: Enable Restricted Injection for an SEV-SNP guest
Date: Fri, 24 Apr 2026 17:51:05 +0000
Message-ID: <20260424175105.4106-1-huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777048608.git.huibo.wang@amd.com>
References: <cover.1777048608.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 57746540-62fe-49a4-0dc3-08dea22a190b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z/U5OrAnu5Wbo/vnyjbFtMH4i28D2jpcLGtwlYsOjY1Iff5NoXlAjCeroNoxlvz6e7uDz8QmltdMZM2aPAW0ONjvVsntWwOHtvXcPxkt7KpKUy1r02T8TI24cFGBOgdAe4tHt9Wtqo8gSq5u0rKwz7UabfuIMsYnuhDV/sudHDQTwjHI2kLS01xONEggJTkUw6HTyqonyuQTzUhFxnXdzxU7Gm0x02KZmOMbmotnOsBh+8FiwzRTP2eg9iunk3b88di0H0J2b4L3piII9lRQewQJBPMV2Z6huYvCZ4cy14wjqsiI/pnU7rUkrawmgGYEJPITpirmmI5QULnWLZeGtU4TRVQmCqw5B3v1p05BEj2/CBwNh7Gk3qIw7kuiPZp4wWC48HzUvEBGTUDE4uavlboLOcfGxCT9rx14yjsBbpfRAjHaSNBKRyPtI9sIn5/mIVvSgjPCMKgVvjlGuzg61ASeeus/9fFtQNWli2L8n6fpRNPlXmLJtQYj6xBz5mvJJzH36WLql/tHFxpne6FZz5+BOYw80iEBWgI+zj1v/Dt3hNZpNEecmluR9MHHntGWDapDPjbw1etcGThXUI8swxZuLc2n0T5MQC8FaFQUU/UG8qQfvnaM+SYY8kdPZqmq5qlB22lLOK2Bw8tFt37sRwh2ZqMbzgVL/9pTzTHzD4lvR7Dma7D0prxI0WQRikxrjMINurzUmldpOe79hWfDWlt1i6Va0/l/KwNNZlORRtbhQw1Rtr2FE/sMgY3nA5MtdD+RNH0oJTSHx03eOmW59A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mXmQBeFS/LdAo00mD+Mnh7ZiMYgcafnWuHE9/uxyMS+Ht67+GBflbCMHPas4lHwIxYUeDALaOA/Jg4czQH4enH5alhQau84z8wa44V69E48Yvafstprgjrei0tfT3b3AdQMuSujGtE/Dne85XB0vijSIT2g9+Xml+JfUfzb180wUNpHG0NZioZ/dWLTPlxi48z8DJWFGgrHCPj9xcPntUuQ12meG3mv57sBnHJkQResLPkmr6U2CKYhNqDita5hTE/4/88r9uCMDTFl2Y6Xl99Se8lEzIBofORPra3Ke5Qaq7TsCSTG7mxEuh8v6XPFrx+cHjCLLiMBZeMBs9dNIa5Y6i3deKrbFVs2pRY5ZJSZOkVL4GdGSwAlZm218optJL1LRohxteySfriUrutlJJefALem6frJRNhYGenVh1CSqxGXnKM5PIXldh4n4o8+7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:51:22.5313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57746540-62fe-49a4-0dc3-08dea22a190b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

Enable Restricted Injection in an SEV-SNP guest by setting the corresponding
bit in the VMSA SEV features field (SEV_FEATURES[3]) from QEMU.

Add Restricted Injection to the supported hypervisor features.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/sev-common.h  |  1 +
 arch/x86/kvm/svm/sev.c             | 26 +++++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index de7bd88e539d..dc35806ff05e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -453,6 +453,7 @@
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
index 95ee199e38fb..c26575516eec 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -40,7 +40,9 @@
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
 
-#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATION)
+#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP |		\
+				 GHCB_HV_FT_SNP_AP_CREATION |	\
+				 GHCB_HV_FT_SNP_RINJ)
 
 /*
  * The GHCB spec essentially states that all non-zero error codes other than
@@ -64,6 +66,10 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
 static bool __ro_after_init sev_snp_enabled = true;
 module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
 
+/* enable/disable SEV-SNP Restricted Injection support */
+static bool sev_snp_restricted_injection_enabled = true;
+module_param_named(restricted_injection, sev_snp_restricted_injection_enabled, bool, 0444);
+
 static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
 module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
 
@@ -3224,6 +3230,12 @@ void __init sev_hardware_setup(void)
 
 	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+	if (!sev_snp_enabled || !cpu_feature_enabled(X86_FEATURE_RESTRICTED_INJECTION))
+		sev_snp_restricted_injection_enabled = false;
+
+	if (sev_snp_restricted_injection_enabled)
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_RESTRICTED_INJECTION;
 }
 
 void sev_hardware_unsetup(void)
@@ -4740,10 +4752,20 @@ void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm)
 		vcpu->arch.reserved_gpa_bits &= ~(1UL << (best->ebx & 0x3f));
 }
 
+static void sev_snp_init_vmcb(struct vcpu_svm *svm)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
+
+	/* V_NMI is not supported when Restricted Injection is enabled */
+	if (sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION)
+		svm->vmcb->control.int_ctl &= ~V_NMI_ENABLE_MASK;
+}
+
 static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
 	struct vmcb *vmcb = svm->vmcb01.ptr;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV_ES;
 
@@ -4810,6 +4832,8 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 		set_ghcb_msr(svm, GHCB_MSR_SEV_INFO((__u64)sev->ghcb_version,
 						    GHCB_VERSION_MIN,
 						    sev_enc_bit));
+	if (is_sev_snp_guest(vcpu))
+		sev_snp_init_vmcb(svm);
 }
 
 void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
-- 
2.43.0

