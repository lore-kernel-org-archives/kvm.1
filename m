Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9B199EAD
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357005; cv=fail; b=Y27fSxUpyiBb/MKz1qQrrtwmjvmWQqueywj1V4FryFOhSzlfUPkqesi0l+CoE6iS3A4Cp6YBQtJZ+76dG/VKDFS8tZCmaohKwAwD890Msyv/Ko29dEj5wk54XQ8Yafop/kGRJkePGjiXu6wb7ruh7s2XPvAM/e8JfDITGiE76cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357005; c=relaxed/simple;
	bh=Ca+ajVANaZINRh56U3XYHb0SCPz9r+0NXnPCAdW6jFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4CnojNv8lbayOaTtdBvb3qIMSqoBhYmfxkuSk185RzvtrBMyjb66DgL8eLI5ugZn3f26ISPOiJaHqVIR/iP/KKqEwqBODmeHxWEkS8CmlNAXhVIiRV7YCVdTI98eM0t4oxabnE2PmSajei7mxAKab7JLEqZ66myU9g2ntvzVEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tTryqiF9; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tTryqiF9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=optvjPg1qO4lh1pzBCBV+oTA/UmS63uZF3rlRZEA6WE49JiGUtSzsLyxSKkudf6ZCc61Y/I5ZuTC8zb74YrsmRig0RI7rKs8hqgFwsFHAfZ/PtFI4CZtaH3469Ig6+Bu2rEjLvpQNfAO4shhplSYknTV5flBOzm1vgcGr6W3qjojc0JRB4udEZBkCZNx77rWCQhKRaDuT/M1RQPcZ9atESq0+cg35SXwZuKPurB0f+FKNxfyG4c1MkqIJjE6zOPJPGbuYX37xdn/PjZSj1QwbL0Eqkoz/HYqlys5i0HfKKdRON2+zCsjGXxpzOcgWfW/Zz/XM6eaOBWv8g7CS2s9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5LYf9qQGrvNgs4MuzKXwJA5if55/6ifgBKhA0j8hBY=;
 b=wEQ08E9/nOTFZR8fJ+J27sI1D3Fxja4CSjPVD/rKp40jpZ/ryimxXD0KtBWmLmlvtFfxgk5g1RB+Ts849934YjWOBpf4GLsqgcZlUXrN4zdUkyRTn6HD1QXdZO6L2zJMn756bNySueai16+ODFxQC62a0tBVlwqMwGKGD34ODGtc5MBJqUcRCyHVkA4ijYCmGoMZkuB00Ewvdk+yL7xaLGmA9Pw1E0qdzWThE94ICy+0Uh3plb9RpGXRIhcV+MQtY0Kj++2QWl8l0S2/RipUABIacLN6R8gRa9JTOvjxCIP44+Cy4X6NXGtN/o4ZRRfMEPlVboOMKc2veihUcrQbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5LYf9qQGrvNgs4MuzKXwJA5if55/6ifgBKhA0j8hBY=;
 b=tTryqiF9BZM3YngIZ7jqH0n6oG2ycU2MFGiVxCSNLkC1u180iKYu3pzgc47uLdcJEdX/bQulRBBRcAJiXaOdlL9wiY6SKDatAVYTAuS1Fbgnyio1e4EmiqkWI4KLGUMKJD5JLScCfbWc01nP8HuoUgJ2bWNDT6aOigOUtoYlkw4=
Received: from PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::12)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:16:35 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::a8) by PH8P220CA0026.outlook.office365.com
 (2603:10b6:510:348::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:16:35 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:16:30 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 3/8] KVM: x86/pmu: Add support for hardware-switched PMU
Date: Mon, 10 Aug 2026 15:44:51 +0530
Message-ID: <67cd3b3b8f031338d76094673d738d72caa10c31.1786345201.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b3badf-5f21-4077-b5b4-08def6c8752f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jXQpvoN8v2Htkbh/4l8RiCAHwCnoUVU5QuDNOuPV6+2KGD/jSG30tp7N+kudIKL1g2cAKpENV5GI2T8dLTlvPr33ZFxa5Vsh3Jf2FYxjpwO3qmlIcz7e7t43/qCFh/9ilKBOYwnJDfwLuSiEceqcy7oCuor67wUczB7OyCCXLG8zyzneVkhtqTI+lc3MuPdEHo6q9yINAcsM+lPfqI2J0D73/BMspUFvfcApw0lj4DicruWTHy7YZ2tM/A1Fuy/oO13WB3rdRvJtFn9nvxry+iyu0yEb2HS3yNlrHYRYGX/5mvbWLPYNWYFVWoDZmqmT3u/gmO9OKiI2VB4Xbhfn2j9C1K3X4qLNkzrSS1HJ0rCwz5JM7h0ySPMwcnhe2aCrxrQ6+OUOVkIkJ++Rhs2KjRYncHcZLKe1XeHt41oF3uBg8tGKZCkfjWuGtvwq/A6tkoaXpbiwShYrTZuCJ5pkrwloGZ1z/7L1fCt7GCMQL60zdjrM9bQS6wFY5MF9AMfX604LVFEIX4bWv1DX24loxopduai9cv45W6mI2fis6Ym6BvfbKDpfokbm/kEagVzNB7Q+xsT3qefDcjRP10vWbUzM+j43mAWEB1FbXmC5xTPoxdwRMwISkVb5BnWG3r3IXxOmiHDXCXCGgegWh9mOk5Ukurs9X7OqKbYLima0UvOB5lXAb+wHiHZY+0mvbJ/Kn0JU0yRozePpe0MOM80s2g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cPl+bA+gu+2juRXKLk/j6mK38uPSQpptXbJ9eoxk2A60R8T6EBxx7JHMep+r03xwK/Cm952EoMX80KLpJOdUM030vGaod7YVN6SOEni4cWpmI3K3x8Pzz///tEghSSFZLLLzqG7fPIYcWGVIUR+8DNnmwWMwfBvTWCOVkJ3N6+IvQbhYSjfyPzv7btYJzj6xGgZNmTMY/Saj8blDDZaChRtosL5VLLPw/ia0Xxtepkz9nD6KR+6b/Eg555IJ00h9wy/7LFceEU1PvYkmwgms0Xb2lbA10Ky+c5KdvEEoNmN7sVFYsea09KOrJeP7TTKkGAMHuVDs6IOSQ40RIDmiKqKIGYyer5/4mRxiFpy2YyaaP7caDoGAWSIbFaZBBA8KjkSwHiHOdRc/LEjobs6LUTk64pW9Zu18dSVdTFEWfYv29f3MCV9p9RiPSek6Rl3b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:16:35.1802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b3badf-5f21-4077-b5b4-08def6c8752f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844

Implement the hardware-switched mode of mediated PMU. The key design
differences from the software-switched mode are listed below.
  * Hardware handles context-switching of the guest PMU state.
  * The guest PMU state resides in a vendor save area (such as VMCB or
    VMCS) instead of struct kvm_pmu.

When enabled, the load and put functionality of mediated PMU simplifies
to just scheduling the active host events in and out.

Event filtering and instruction emulation require the ability to change
the guest PMU state in software. Since struct kvm_pmu is not guaranteed
to always have the correct state, make use of the new vendor state sync
ops to access MSR states directly from a vendor save area. These are
also used to read the latest counter value when RDPMC is intercepted
for legacy guests with fewer counters.

The software-switched mode continues to be the default for hardware
lacking the features to support this capability.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/pmu.c           | 97 +++++++++++++++++++++++++++++-------
 arch/x86/kvm/pmu.h           |  7 +++
 arch/x86/kvm/svm/pmu.c       |  2 +
 arch/x86/kvm/svm/svm.c       |  3 +-
 arch/x86/kvm/vmx/pmu_intel.c |  2 +
 arch/x86/kvm/vmx/vmx.c       |  3 +-
 6 files changed, 95 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 5ede3ee968e3..4c918aa6d6f3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -130,6 +130,24 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 #undef __KVM_X86_PMU_OP
 }
 
+static void kvm_pmu_get_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
+{
+	if (!kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		return;
+
+	if (kvm_pmu_call(get_vendor_state)(vcpu, msr))
+		kvm_pmu_warn_vendor_state(msr);
+}
+
+static void kvm_pmu_set_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
+{
+	if (!kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		return;
+
+	if (kvm_pmu_call(set_vendor_state)(vcpu, msr))
+		kvm_pmu_warn_vendor_state(msr);
+}
+
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 {
 	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
@@ -200,6 +218,27 @@ void kvm_handle_guest_mediated_pmi(void)
 	kvm_make_request(KVM_REQ_PMI, vcpu);
 }
 
+static __always_inline u32 fixed_counter_msr(u32 idx)
+{
+	return kvm_pmu_ops.FIXED_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
+}
+
+static __always_inline u32 gp_counter_msr(u32 idx)
+{
+	return kvm_pmu_ops.GP_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
+}
+
+static __always_inline u32 gp_eventsel_msr(u32 idx)
+{
+	return kvm_pmu_ops.GP_EVENTSEL_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
+}
+
+static __always_inline u32 pmc_counter_msr(struct kvm_pmc *pmc)
+{
+	return pmc_is_gp(pmc) ? gp_counter_msr(pmc->idx) :
+				fixed_counter_msr(pmc->idx - KVM_FIXED_PMC_BASE_IDX);
+}
+
 static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
@@ -553,18 +592,23 @@ static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 {
 	bool allowed = pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc);
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
+	struct kvm_vcpu *vcpu = pmc->vcpu;
 
 	if (pmc_is_gp(pmc)) {
 		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 		if (allowed)
 			pmc->eventsel_hw |= pmc->eventsel &
 					    ARCH_PERFMON_EVENTSEL_ENABLE;
+
+		kvm_pmu_set_vendor_state(vcpu, gp_eventsel_msr(pmc->idx));
 	} else {
 		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
 
 		pmu->fixed_ctr_ctrl_hw &= ~mask;
 		if (allowed)
 			pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
+
+		kvm_pmu_set_vendor_state(vcpu, kvm_pmu_ops.FIXED_COUNTER_CTRL);
 	}
 }
 
@@ -772,6 +816,8 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
 		return 1;
 
+	kvm_pmu_get_vendor_state(vcpu, pmc_counter_msr(pmc));
+
 	*data = pmc_read_counter(pmc) & mask;
 	return 0;
 }
@@ -855,10 +901,12 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+		kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
 		msr_info->data = pmu->global_status;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_CORE_PERF_GLOBAL_CTRL:
+		kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_CTRL);
 		msr_info->data = pmu->global_ctrl;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
@@ -898,6 +946,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 
 		pmu->global_status = data;
+		kvm_pmu_set_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 		data &= ~pmu->global_ctrl_rsvd;
@@ -917,6 +966,8 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 */
 		if (kvm_vcpu_has_mediated_pmu(vcpu))
 			kvm_pmu_call(write_global_ctrl)(data);
+
+		kvm_pmu_set_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_CTRL);
 		break;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		/*
@@ -927,12 +978,18 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		fallthrough;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
-		if (!msr_info->host_initiated)
+		if (!msr_info->host_initiated) {
+			kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
 			pmu->global_status &= ~data;
+			kvm_pmu_set_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
+		}
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
-		if (!msr_info->host_initiated)
+		if (!msr_info->host_initiated) {
+			kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
 			pmu->global_status |= data & ~pmu->global_status_rsvd;
+			kvm_pmu_set_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
+		}
 		break;
 	default:
 		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
@@ -1020,6 +1077,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	if (kvm_vcpu_has_mediated_pmu(vcpu))
 		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
 
+	kvm_pmu_set_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_CTRL);
+
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
 	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
 		   pmu->nr_arch_fixed_counters);
@@ -1142,6 +1201,9 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 	if (bitmap_empty(event_pmcs, X86_PMC_IDX_MAX))
 		return;
 
+	kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_CTRL);
+	kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
+
 	if (!kvm_pmu_has_perf_global_ctrl(pmu))
 		bitmap_copy(bitmap, event_pmcs, X86_PMC_IDX_MAX);
 	else if (!bitmap_and(bitmap, event_pmcs,
@@ -1150,11 +1212,17 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
+		kvm_pmu_get_vendor_state(vcpu, pmc_counter_msr(pmc));
+
 		if (!pmc_is_event_allowed(pmc) || !cpl_is_matched(pmc))
 			continue;
 
 		kvm_pmu_incr_counter(pmc);
+		kvm_pmu_set_vendor_state(vcpu, pmc_counter_msr(pmc));
 	}
+
+	kvm_pmu_set_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
+
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 }
 
@@ -1313,21 +1381,6 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
 	return r;
 }
 
-static __always_inline u32 fixed_counter_msr(u32 idx)
-{
-	return kvm_pmu_ops.FIXED_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
-}
-
-static __always_inline u32 gp_counter_msr(u32 idx)
-{
-	return kvm_pmu_ops.GP_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
-}
-
-static __always_inline u32 gp_eventsel_msr(u32 idx)
-{
-	return kvm_pmu_ops.GP_EVENTSEL_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
-}
-
 static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -1364,6 +1417,10 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 
 	perf_load_guest_context();
 
+	/* Guest PMU state is restored by hardware */
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		return;
+
 	/*
 	 * Explicitly clear PERF_GLOBAL_CTRL, as "loading" the guest's context
 	 * disables all individual counters (if any were enabled), but doesn't
@@ -1423,6 +1480,12 @@ void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 
 	lockdep_assert_irqs_disabled();
 
+	/* Guest PMU state is saved by hardware */
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED)) {
+		perf_put_guest_context();
+		return;
+	}
+
 	/*
 	 * Defer handling of PERF_GLOBAL_CTRL to vendor code.  On Intel, it's
 	 * atomically cleared on VM-Exit, i.e. doesn't need to be clear here.
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 5d6f6863ad40..42d33072ece9 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -50,8 +50,10 @@ struct kvm_pmu_ops {
 	const int MIN_NR_GP_COUNTERS;
 
 	const u32 PERF_GLOBAL_CTRL;
+	const u32 PERF_GLOBAL_STATUS;
 	const u32 GP_EVENTSEL_BASE;
 	const u32 GP_COUNTER_BASE;
+	const u32 FIXED_COUNTER_CTRL;
 	const u32 FIXED_COUNTER_BASE;
 	const u32 MSR_STRIDE;
 };
@@ -110,6 +112,11 @@ do {									\
 	(kvm)->arch.mediated_pmu_caps &= ~(caps);			\
 } while (0)
 
+static inline void kvm_pmu_warn_vendor_state(u32 msr)
+{
+	WARN_ONCE(1, "accessing unsupported vendor save slot for MSR 0x%x\n", msr);
+}
+
 /*
  * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
  * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c18286545a7a..5dccf8776368 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -321,8 +321,10 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
 
 	.PERF_GLOBAL_CTRL = MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+	.PERF_GLOBAL_STATUS = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
 	.GP_EVENTSEL_BASE = MSR_F15H_PERF_CTL0,
 	.GP_COUNTER_BASE = MSR_F15H_PERF_CTR0,
+	.FIXED_COUNTER_CTRL = 0,
 	.FIXED_COUNTER_BASE = 0,
 	.MSR_STRIDE = 2,
 };
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9d607b98bd06..2e39b5e752cd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4618,7 +4618,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	kvm_clear_available_registers(vcpu, SVM_REGS_LAZY_LOAD_SET);
 
-	if (!msr_write_intercepted(svm, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
+	if (!kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED) &&
+	    !msr_write_intercepted(svm, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
 		rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, vcpu_to_pmu(vcpu)->global_ctrl);
 
 	trace_kvm_exit(vcpu, KVM_ISA_SVM);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index bfa8612fb450..d0723814410e 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -853,8 +853,10 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.MIN_NR_GP_COUNTERS = 1,
 
 	.PERF_GLOBAL_CTRL = MSR_CORE_PERF_GLOBAL_CTRL,
+	.PERF_GLOBAL_STATUS = MSR_CORE_PERF_GLOBAL_STATUS,
 	.GP_EVENTSEL_BASE = MSR_P6_EVNTSEL0,
 	.GP_COUNTER_BASE = MSR_IA32_PMC0,
+	.FIXED_COUNTER_CTRL = MSR_CORE_PERF_FIXED_CTR_CTRL,
 	.FIXED_COUNTER_BASE = MSR_CORE_PERF_FIXED_CTR0,
 	.MSR_STRIDE = 1,
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..7d8c032c1897 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7383,7 +7383,8 @@ static void vmx_refresh_guest_perf_global_control(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (msr_write_intercepted(vmx, MSR_CORE_PERF_GLOBAL_CTRL))
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED) ||
+	    msr_write_intercepted(vmx, MSR_CORE_PERF_GLOBAL_CTRL))
 		return;
 
 	if (!cpu_has_save_perf_global_ctrl()) {
-- 
2.53.0

