Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59985012A9
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860910; cv=fail; b=f6wiz2ZIDIH1INmiWoJ3Vlwx5T8t0q1+LCzBS5jN6e68qK9IJ6WOnir8G0Y0TW4xYx0AdJX0pAd5zKSeMhMqdfl4DW+WEUqEfbYArMZV7Wb1RwV6Mwg5UtygRnFkpH9SLeFROHDtopeg3C3w1uS0jjrMfJQdnephvKuMY43wDVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860910; c=relaxed/simple;
	bh=X56dEXISqNWLz0WRFlc4/NFVmWHN+vKExrz9d37sQjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLaD6FP8xJYwcVJvShIHxH74wYY7NP+IH6iyT0WvRdqWm1eE1gweg0OSA3/yFjM2PrUpgj8SAjdbAV+AEFll7cQbmMjdN9HYcdx4LE3doTFpdwbm1C61UpDJbe9g8eRGGuUA0uyxQZUTrbN9uPsTCbhPoSx5IWZLcQwXeUvuCb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JV0+jzhg; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JV0+jzhg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTfODk04+/l+Dmtra11t430b5ACye+y/H1OaYbxv9e/bpKwGocKt/CJy5bjqltScxoPDQYPAaLiLtZMUvEH+Y8dVm/N4fYLViwvELRzOT+1ttNqoeOz0OVgre/M2I4W5RTEar9tgCAgmrTtixGfH67fkV6A0euMNN7W3lG46d346zKhI8CUjl3VjVpRRdtqJiD1K7dUYKY1sTqwQBBZ3beWmih/l6IxxWUPQyeRCCeA34GA9LgvTUp9VTz1qOd2vv6GL4KNo5GFqUxj2jfbZmttAHn+CMr60iaeUb/H2UJwsnKUjCRHGcqZrTLKqsseCrq+vWI2x9C1CLsBLnaHZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj2VRutgQZauQSsb3G4N6d2/82hOjQveZGp/1v/sGIg=;
 b=RD/zbYmFAlOsFmznaT45iGWLNB0DCtAqxDMyrszMaAqRzF/Y7SQw56xTdn6bJjym6iNu7BFTcOFpAMlKy/c+a7C6jkH87codxIcBdR8H1ppX32P/5LbtCLLYIHTYmuslPqxCsUqWzzEZHGl2A7d+8Om0IqqYVbJBy9FpTihMTULcEik/zn57Ud0yFWw+sLCETviJlgAVUhpuhAyhlnnQ0LvUO24OBqe1q33qrZ62RVU/8/jOakYtzVfytYbT53sJfhYSZ3TSqVwyB/w1EBq7hNqwB0kccnhGjPiihv2zKpjIGNLeUXRr89309ptn1mxZN84v5264/2Wwy8vy3v0HmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj2VRutgQZauQSsb3G4N6d2/82hOjQveZGp/1v/sGIg=;
 b=JV0+jzhgkYJA6287u5agx+rnVWSSwOkKaeq0XWJ5KydPZ7oVTae613WTGbecoM2Nl0EcyXm2B0f38qt4QK/3onN/UXDomoW5It169T78vrhz/U3N8qwKtUXnLSmi7QsFQ/oDBPXwLBCg6RsAabCsEeH4szYVlDP7H7/A8ZVrrsM=
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 13:21:28 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::af) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 13:21:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:28 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:21:24 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 9/9] KVM: SEV: Enable hardware-assisted PMC filtering for SEV-ES and SNP guests
Date: Thu, 1 Oct 2026 13:20:21 +0000
Message-ID: <20261001132021.254270-10-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001132021.254270-1-manali.shukla@amd.com>
References: <20261001132021.254270-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: e19afae6-2b26-436c-d1ab-08df1fbee674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kfZMP8Sy44A3Lvp369knLaO9z3Ar5tmsZYtixZcM+OzXTfj8T+uI5WuHrBNelGjWWR3NaFyjxsLDCUj20b83TZaIh2sa849usEkmSLsSrOXDPHZQyGf1L2/+zOJxwmJ5hWnC0g+ojP8dT/t3XGJR3ppVhn/5jNOFzoF/Lm/ZCqKjDE9+rZwCSV3nxvwrDZVgPJvigomxtMtLwZOn2FonDGVDid/CzbxjUBTXHeZrPu0OFrKpwZqBKwoI18T9U2SEjfALkVzmUNFMbzHIYk6dXZ4JOUq4aOlrdgnvUpfsqVuigWmhO7RPteTsvP4wldRLLlm46ufT46TU7jbgX8sNmG46sQICxhyqNeDy66OL+cZnWz4q1EXTFyPHhx5r2+V/LShchQq+FwNMqJSc6oZWDqcENyg/+9pWemuuG1A8KnaLMweVyPm/v0fYtu8tO9mnvjHJxo6tUYx8eAkR6uRS39XZoW6EXNhxXwO1OXlSJYEhx2hPl1BN+JjjFheC/bKpk/VAyQrJaeOA5cJSLI8/NKEBWyiq8nbZQtx5diMmP6pySK6MXrg704p3A7QTpQ0itQ+Ri0USST0EZpy1vp9mkCKkgIt/wgKK7onkW6IiyxmrXF3Ii5FUXaZplKu+zugj8K3CDx1ZZNePv+MasJkE6XBOMxTJEFFbnaKD/OrwAVbdLa4HCcJhzOOLaiPOfYV1zPrEzaE81Pfpmm0LrYE3rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VozloH91Hwxy4QsOgsu8CXbSbVSpcxcE+1ilpHc8tNhGuyXuREaZiruCFVFBHwTDfOn/v7o2ne1G2M/0FdtG3fP67JhzfmfSO8yQ9c6wUx33DC2gSXBknFMkwudiZOKz7V8/AlZWC0CDbRGhoFxATsgbegdNk9dWJghYXZjpor/LHV3MFfwzbjf9R8+Z+EjsaccjsUE6Z3UWdDMfqeizT2oNsFBLU4VgsxPhgHMLOfyekstaRSE4pj24ZmurNNVXs4wFCd805g3RT/4L+E5VkL3wCTEG5q3Ze9QaNroXoZ2f2gtYN67JiBgJFQJltA9OpklmFIMlHkd7A6BxGdTRaRcNwjbjvfOfK9ZzOnpKmbtCZbTf+rxuVx52wOtQFeMEVJqkbyeMm1dUiLBE4R0tsfgVWDPkBsT8ErrNMvng66ZITKUZoA39OGxhnby/m/Ul
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:28.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19afae6-2b26-436c-d1ab-08df1fbee674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

Without filtering, a guest with PMC virtualization programs its
event-selects itself, so the PMU event filter doesn't apply to it.  Only
advertise SVM_SEV_FEAT_PERFCTR_VIRT when the hardware supports PMC
filtering.  SEV-ES and SNP guests then forward trapped event-select
writes with SVM_VMGEXIT_PMC_FILTER for KVM to filter.

sev_hardware_setup() now checks vpmc, so call it after vpmc gets its
final value.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++++----
 arch/x86/kvm/svm/svm.c | 14 +++++++-------
 arch/x86/kvm/svm/svm.h |  2 ++
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b73484620e2a3..acd761c7437d9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -544,10 +544,8 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 		sev->vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
 
 	if (es_active && !sev_es_is_perfctr_virt_enabled(kvm))
-		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED);
-
-	if (es_active)
-		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_FILTERED);
+		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED |
+					       KVM_MEDIATED_PMU_CAP_HW_FILTERED);
 
 	ret = sev_asid_new(sev, vm_type);
 	if (ret)
@@ -3258,6 +3256,11 @@ void __init sev_hardware_setup(void)
 
 	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+	/* KVM must filter the events of a guest with PMC virtualization. */
+	if (sev_es_enabled && svm_pmc_filter_supported() &&
+	    cpu_feature_enabled(X86_FEATURE_SEV_PERFCTR_VIRT))
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_PERFCTR_VIRT;
 }
 
 void sev_hardware_unsetup(void)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cdd102c761994..0784ce62dd672 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -186,7 +186,7 @@ module_param(vpmc, bool, 0444);
  * TODO: Support nested.  vmcb02 doesn't enable PMC filtering, so L2 could
  * program denied events through vmcb01's passthrough event-selects.
  */
-static bool svm_pmc_filter_supported(void)
+bool svm_pmc_filter_supported(void)
 {
 	return vpmc && !nested && cpu_feature_enabled(X86_FEATURE_PMCFILTER);
 }
@@ -5779,12 +5779,6 @@ static __init int svm_hardware_setup(void)
 
 	iopm_base = __sme_set(__pa(iopm_va));
 
-	/*
-	 * Note, SEV setup consumes npt_enabled and enable_mmio_caching (which
-	 * may be modified by svm_adjust_mmio_mask()), as well as nrips.
-	 */
-	sev_hardware_setup();
-
 	svm_hv_hardware_setup();
 
 	enable_apicv = avic_hardware_setup();
@@ -5842,6 +5836,12 @@ static __init int svm_hardware_setup(void)
 	if (svm_pmc_filter_supported())
 		pr_info("PMC filtering virtualization supported\n");
 
+	/*
+	 * Note, SEV setup consumes npt_enabled and enable_mmio_caching (which
+	 * may be modified by svm_adjust_mmio_mask()), as well as nrips and vpmc.
+	 */
+	sev_hardware_setup();
+
 	svm_set_cpu_caps();
 
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 3615997b339ec..d44e4f4829fc1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -867,6 +867,8 @@ static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
 
 #define SVM_PMC_FILTER_MASK	(AMD64_EVENTSEL_EVENT | ARCH_PERFMON_EVENTSEL_UMASK)
 
+bool svm_pmc_filter_supported(void);
+
 int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 
 /* nested.c */
-- 
2.43.0

