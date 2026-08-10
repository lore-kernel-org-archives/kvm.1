Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51D386552
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357055; cv=fail; b=dr0LIyWu5tcj1C5oxpq7Qy1IFSPWyjFLMu8eFscwTbEMnAPexcjumS6naT9Q1+HhCYdlzj2WJyCgTtKF0wxF/yUIFbVaLRxTipzl7KuuYsRZjqpAPyJVezvfOeLDl3GgazlLEb5NLnNtq1p+QwOoMrmH2eFHX5KmNvWViGJAEyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357055; c=relaxed/simple;
	bh=i2iF+7gk7Mg2aQ0AOjozSFePRb989j5XjSIF6k8RcLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a94sPuyFnQYOqSziLqWr+iBSGkRMfC220P22b37/VbKKp2sm4udlZL9PYtppQN0guaH56s5CUcz0DFNiGdMVd2ESr01Sohr8yzP3dZsNAxVO+4LVY0PuF7B1a09NYEx1SjI96zjlUnj7KVkvvPR2jhNzaqxWfAX8dnxRS8Top8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KspTpsfN; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KspTpsfN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0pr2vZcK9eeiVfmbsheqf27xGoLOsXUCJ95IexNrZ4fprKSuTzxGesyP+rBaIHrkhbg2Joncx0KljY5y843l+4fXB7ZMb7fIcneX8d5MwtYPLg+hXF6yg22C+iFKd6gxlB7V3FtKwPRhXYNYlrNOWBojgWctaZ8x9wfYd80mpOu5ZIWy7hTL7/tHaiJyidkhkp+g0+HFIY914yyMhzs/cD6cH/uq9UuCWIGH0wgnXWczy2fras6+GJ/tL12gSNI3aPFjClElmS6C4GOErtBbXSa96Ql9NHtZIsKrOsN8CR3hbHBIALK/01QQrhfY+PGVfd9DcdLhHx+y6b0x+/zPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5jdxQwxZslw4CEflmx/JQzRBsCSgjsm0kvcGwcbAEs=;
 b=mLm3BnorKUiEiq4ayKS5FIz7QUsLi10OvHUMJwQKR/UE0xlZAXElHbGYI2Ecdn5jO+7cSa4GnB2jEIUTrsJ2u1yY4lDfJbOfgmucu3/NAp3LH+FqCp8zRl1RapBdNd3YGkiAD8+D+hWHlERS9mMo/H1AXMARuIIDrJ792qWtYxCWTPQNB5koX0uRYEd9yMePO+sTt6f8pnNOyVwr/Xa5Ln2b60Ld9NOphxV5IpdY5omhdezuIn0liis5oc5A8kzeTqvWszEsGwk2QBkhmTne0+Bmziaoqgt71/sjyD/078Pyje+y5w3G5WRnBgVTtfC/oizc3G+kEoplc3gG2S2NfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5jdxQwxZslw4CEflmx/JQzRBsCSgjsm0kvcGwcbAEs=;
 b=KspTpsfNqYTuSBcGdoRqx8BpH+zwZhZlMoGr3ZZmtCHTkr798rOCujSowKY999rtfX1fja4YJ6oWx63JPCkv2bsjV42Y2LPUypJZ5/8H8+QdNHXgivpXtRRmcg2O+XMj6bZTOeUNJ9Y8eA2kQDnsmh98n7wDzht14ihvCJvUIKU=
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:17:27 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::8f) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:17:27 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:17:20 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 6/8] KVM: SVM: Add support for hardware-switched PMU
Date: Mon, 10 Aug 2026 15:44:54 +0530
Message-ID: <901b3726ed48b666f72913e6c395f1317b574dd9.1786345201.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: d5870216-ca9f-4998-f113-08def6c89467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0P/ombJgpVQHKHBzfRBhgZVhTCRHk81SRCB0JVp0cW3GtIQnalfvPWuCCW8/pbsO8m4g/BXLXOcH+YGLRqPzc8fh12iVC/BhNgCgaK7QlZ8IexwvVqPiM1I8m43OBUXFDqMRf2XFIhkBxM3cTHcrB2F4BfrGCin9c5VxmtCLPKACakOtOik1WtyLaUBYBiCwdiuEes3xMY7buT/iH6jmltVaNe8mFew2SxIVJM4p4C7zaPWYS3BXqx/OeXbDQEdR3vsnSgMFsienQKFAzolndPunwD6fLmcwqPlaXyTNiSxX3gq9o/cPMuztVfTrqlaskzI3s0n0XzE9vLVnzeeJP7TchIe8OcgPiMlegNE7UBNmfa4naOPd7j0SYWJNeZwm8AXpXFa3WQA8v0+9N9LBSjRZHr2Ftm4Q4vw09LMwIxHlQ8h9lLS/8akMF57ugaybQADtALbBdCJA2J2XD63rzvR4Jrxp6AcJgMBZWeOzp+oJ2KJMZQubDK64g0gFNSsZcTvLLjVAc6e//bG6atDMOunX2QiM8/vcQdQWBg5o8A8MJBiXigYi5xNw7DwGaQch/zhBLp6t1mB+r2U1CBurYLFk9qgEeYkmIs+eCSkHJx3/mGhUN+uQq2GCaj1RAdijIw/4yn9+D+dr0z/y2X4vE8lUc66pClH00eSXbhosre4oWzUWAx57QzGYQZP6Vxb2jYy0OaQ82D37cIuP5p6gNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	msq2WRnDwCmqwm+XJvlUwXvfaGu10EuVLZpDNjK2ddnm9VqK1grUjrGUcJ4eUsXwprS/wtUkkK/4xshvea0OwaBrqz+68z9j5Ozpbll4m6A8K+h9+IR6RbZiJmq9/lZiFXDlhV0XVTRuKpuZF04/ZZG/PaIhtIibFzCEQlsMAyJlYW0HSANZX4vhEAfsb7JyhtWdPR3Nuby+aHEMZWPtKu5whxMMC/YO1GO6BRKRQzcovzpM4rTMCGqAJD7yzsK2L5uQQLvV06D5tt7Ec92DEYgQYjsnp6lBm1za3/S/jIR6jotzb/rcpkfkQhhcy86wJZeROyQY78IRNGR0ULxTqSVIIGQGu7EzVTgTh8z3zmsvV2h5cl+Nqfy6tQFl5XAmIJFnXdkgzSC8m4v5oqy7jIREvOPlDl9+sT0z4v06yszk2/fbG5EWSTq6iQk85QDl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:17:27.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5870216-ca9f-4998-f113-08def6c89467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587

Zen 5 processors introduced the ability to offload guest PMU context
switches to hardware using a feature called PMC virtualization. Use the
feature, detected using X86_FEATURE_PERFCTR_VIRT, to implement the new
hardware-switched mode of mediated PMU.

The feature is enabled by setting bit 3 of misc_ctl2 residing in the
VMCB control area. Since the guest PMU state now resides in the VMCB
save area, implement the vendor state sync PMU ops for use during event
filtering, instruction emulation and RDPMC interception to access the
latest PMU state.

The vendor state sync calls always use MSR_F15H_PERF_{CTL,CTR}x indices
because of how GP_EVENTSEL_BASE and GP_COUNTER_BASE are set in the SVM
kvm_pmu_ops. For legacy models, where X86_FEATURE_PERFCTR_CORE is not
set, these are translated to the equivalent MSR_K7_{EVNTSEL,PERFCTR}x
indices, as get_gp_pmc_amd() would otherwise return NULL.

The underlying implementation depends on the availability of either
VNMI or AVIC for guest PMI delivery. Synthesized overflows such as
those resulting from incrementing counters due to instruction emulation
are still injected through the KVM_REQ_PMI processing path. Since AVIC
can be inhibited, make VNMI the hard requirement.

When both VNMI and AVIC are enabled, AVIC gets preference in hardware.
The main advantage of using AVIC is that it lets the guest change the
delivery mode in the LVTPC. Unlike AVIC, VNMI ignores the LVTPC, as the
APIC is emulated, and always presents PMIs as NMIs.

PMC virtualization does not use a VMCB clean bit. Hardware reloads the
guest PMU state from the VMCB save area on every VMRUN. Hence, any
software updates to the VMCB do not require calling vmcb_mark_dirty().

The "vpmc" vendor module parameter is introduced to toggle the feature.
Compared to software-switched mediated PMU, enabling the feature
reduces the world switch overhead. Hence it is enabled by default when
the host supports X86_FEATURE_PERFCTR_VIRT and also has mediated PMU
enabled (kvm_amd.enable_mediated_pmu=1).

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/svm.h |   1 +
 arch/x86/kvm/svm/pmu.c     | 115 +++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c     |  51 ++++++++++++++++
 arch/x86/kvm/svm/svm.h     |   1 +
 4 files changed, 168 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 73f17af22d6c..e1c8a333e86f 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -247,6 +247,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
+#define SVM_MISC2_ENABLE_V_PMC	BIT_ULL(3)
 
 #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
 #define SVM_TSC_RATIO_MIN	0x0000000000000001ULL
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 5dccf8776368..7d3a151b6cde 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -125,6 +125,89 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	return amd_msr_idx_to_pmc(vcpu, msr);
 }
 
+static u32 amd_pmu_adjust_msr_idx(struct kvm_vcpu *vcpu, u32 msr)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE) &&
+	    msr >= MSR_F15H_PERF_CTL0 &&
+	    msr <= MSR_F15H_PERF_CTR0 + 2 * pmu->nr_arch_gp_counters)
+		msr = ((msr & 0x1) ? MSR_K7_PERFCTR0 : MSR_K7_EVNTSEL0) +
+		      ((msr - MSR_F15H_PERF_CTL0) / 2);
+
+	return msr;
+}
+
+static int amd_get_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
+{
+	struct vmcb_save_area *save = &to_svm(vcpu)->vmcb->save;
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+
+	/* MSR_PERF_CNTR_GLOBAL_* */
+	switch (msr) {
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+		pmu->global_status = save->perf_cntr_global_status;
+		return 0;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+		pmu->global_ctrl = save->perf_cntr_global_control;
+		return 0;
+	}
+
+	msr = amd_pmu_adjust_msr_idx(vcpu, msr);
+
+	/* MSR_PERFCTRn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
+	if (pmc) {
+		pmc->counter = save->pmc[pmc->idx].perf_ctr;
+		return 0;
+	}
+
+	/* MSR_EVNTSELn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
+	if (pmc) {
+		pmc->eventsel_hw = save->pmc[pmc->idx].perf_ctl;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int amd_set_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
+{
+	struct vmcb_save_area *save = &to_svm(vcpu)->vmcb->save;
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+
+	/* MSR_PERF_CNTR_GLOBAL_* */
+	switch (msr) {
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+		save->perf_cntr_global_status = pmu->global_status;
+		return 0;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+		save->perf_cntr_global_control = pmu->global_ctrl;
+		return 0;
+	}
+
+	msr = amd_pmu_adjust_msr_idx(vcpu, msr);
+
+	/* MSR_PERFCTRn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
+	if (pmc) {
+		save->pmc[pmc->idx].perf_ctr = pmc->counter & pmc_bitmask(pmc);
+		return 0;
+	}
+
+	/* MSR_EVNTSELn */
+	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
+	if (pmc) {
+		save->pmc[pmc->idx].perf_ctl = pmc->eventsel_hw;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -134,6 +217,10 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_PERFCTRn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
 	if (pmc) {
+		if (msr_info->host_initiated &&
+		    kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED) &&
+		    amd_get_vendor_state(vcpu, msr))
+			kvm_pmu_warn_vendor_state(msr);
 		msr_info->data = pmc_read_counter(pmc);
 		return 0;
 	}
@@ -158,6 +245,10 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
 	if (pmc) {
 		pmc_write_counter(pmc, data);
+		if (msr_info->host_initiated &&
+		    kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED) &&
+		    amd_set_vendor_state(vcpu, msr))
+			kvm_pmu_warn_vendor_state(msr);
 		return 0;
 	}
 	/* MSR_EVNTSELn */
@@ -174,6 +265,9 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			else
 				__clear_bit(pmc->idx, pmu->pmc_has_mode_specific_enables);
 
+			if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+				pmc->eventsel_hw = data;
+
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
@@ -239,6 +333,24 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void amd_pmu_reset(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct vmcb_save_area *save = &to_svm(vcpu)->vmcb->save;
+	int i;
+
+	if (!kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		return;
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		save->pmc[i].perf_ctl = 0;
+		save->pmc[i].perf_ctr = 0;
+	}
+
+	save->perf_cntr_global_control = 0;
+	save->perf_cntr_global_status = 0;
+}
+
 static bool amd_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pmu)
 {
 	return host_pmu->version >= 2;
@@ -311,10 +423,13 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.refresh = amd_pmu_refresh,
 	.init = amd_pmu_init,
 	.pmc_is_disabled_in_current_mode = amd_pmc_is_disabled_in_current_mode,
+	.reset = amd_pmu_reset,
 
 	.is_mediated_pmu_supported = amd_pmu_is_mediated_pmu_supported,
 	.mediated_load = amd_mediated_pmu_load,
 	.mediated_put = amd_mediated_pmu_put,
+	.get_vendor_state = amd_get_vendor_state,
+	.set_vendor_state = amd_set_vendor_state,
 
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_AMD_GP_COUNTERS,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2e39b5e752cd..079b1a56e995 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -179,6 +179,9 @@ module_param(vnmi, bool, 0444);
 
 module_param(enable_mediated_pmu, bool, 0444);
 
+bool vpmc = true;
+module_param(vpmc, bool, 0444);
+
 static bool __ro_after_init svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
@@ -1267,6 +1270,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 
 	svm_hv_init_vmcb(vmcb);
 
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		control->misc_ctl2 |= SVM_MISC2_ENABLE_V_PMC;
+
 	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 
 	vmcb_mark_all_dirty(vmcb);
@@ -3563,6 +3569,30 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "excp_from:", save->last_excp_from,
 	       "excp_to:", save->last_excp_to);
 
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED)) {
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "perf_ctl0:", save->pmc[0].perf_ctl,
+		       "perf_ctr0:", save->pmc[0].perf_ctr);
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "perf_ctl1:", save->pmc[1].perf_ctl,
+		       "perf_ctr1:", save->pmc[1].perf_ctr);
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "perf_ctl2:", save->pmc[2].perf_ctl,
+		       "perf_ctr2:", save->pmc[2].perf_ctr);
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "perf_ctl3:", save->pmc[3].perf_ctl,
+		       "perf_ctr3:", save->pmc[3].perf_ctr);
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "perf_ctl4:", save->pmc[4].perf_ctl,
+		       "perf_ctr4:", save->pmc[4].perf_ctr);
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "perf_ctl5:", save->pmc[5].perf_ctl,
+		       "perf_ctr5:", save->pmc[5].perf_ctr);
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "perf_cntr_global_control:", save->perf_cntr_global_control,
+		       "perf_cntr_global_status:", save->perf_cntr_global_status);
+	}
+
 	if (is_sev_es_guest(vcpu)) {
 		struct sev_es_save_area *vmsa = (struct sev_es_save_area *)save;
 
@@ -4452,6 +4482,14 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, unsigned enter_fl
 
 	amd_clear_divider();
 
+	/*
+	 * On #VMEXIT, PerfCntrGlobalCtl goes back to its reset state since
+	 * its save slot is of Swap Type C. All enable bits are set but PMC
+	 * virtualization requires them to be cleared before VMRUN.
+	 */
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+
 	if (is_sev_es_guest(vcpu))
 		__svm_sev_es_vcpu_run(svm, enter_flags,
 				      sev_es_host_save_area(sd));
@@ -5289,6 +5327,9 @@ static void svm_vm_destroy(struct kvm *kvm)
 
 static int svm_vm_init(struct kvm *kvm)
 {
+	if (vpmc)
+		kvm_set_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED);
+
 	sev_vm_init(kvm);
 
 	if (!pause_filter_count || !pause_filter_thresh)
@@ -5735,6 +5776,16 @@ static __init int svm_hardware_setup(void)
 	if (!enable_pmu)
 		pr_info("PMU virtualization is disabled\n");
 
+	/*
+	 * PMC virtualization does not raise host PMIs that need to be injected.
+	 * Instead, it requires VNMI or AVIC for guest PMI delivery. AVIC can,
+	 * however, get inhibited so make VNMI the hard requirement.
+	 */
+	vpmc = vpmc && vnmi && enable_mediated_pmu &&
+	       cpu_feature_enabled(X86_FEATURE_PERFCTR_VIRT);
+	if (vpmc)
+		pr_info("PMC virtualization supported\n");
+
 	svm_set_cpu_caps();
 
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 66b44b54608e..eee26f6ce10c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -53,6 +53,7 @@ extern int vgif;
 extern bool intercept_smi;
 extern bool vnmi;
 extern int lbrv;
+extern bool vpmc;
 
 extern int tsc_aux_uret_slot __ro_after_init;
 
-- 
2.53.0

