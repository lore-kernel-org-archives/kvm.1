Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349574052CD
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829887; cv=fail; b=CeFVoQm59N1Z1kYlpGnsS7ZoQUvxuExwUNhEsXerNbSlc2oJuIGUoaq60NBRc1j0jQ5uC7wuuM1cTwilqxOpbQ+9C9iuGiDfMDmmjcDI3w9J8JxSM6/voR2KG2qiSTAnWb61HGn+M9uD1td7DZVNcytB9LJ39xnPS+P2JMbDht8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829887; c=relaxed/simple;
	bh=ChcUrk72W/2YNF3dHWFwTwkgaXjYMHkGs4Ph7adL1kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xe5oBAQDI/KmZQXCF7WUAt3vpWdSaB1d1IqgiM440TPLxLoe1/0Q21Lw64W7tpif5DyPL43RJJdX5A1fGya3MvXuBig4DO4EocNk+NCSj9DYVDN4uwfR0VJW6IDcVsBYnC5ucDhU/eyHpjNaUjsoZpUoYXXyd9Uw94TEuSdDJIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MkHDLgSN; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MkHDLgSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyxgIy2Bh3AHosjM6eKKRgNvk27lycTsg17gQ/GQAWQNP0A+NiNvqyMrtmLAu/R0ZoHZQIlUzhg4JFRlkpMB4nb9U/XJr+2olPTEXGstYnnhIJnhGbFZE38eghO4RvmPFKTX/qObBIpdCJNO6SaPfYOb5oowvvQaF9BjZELlXG0PUBpVolgqV7KEpXoTuZOmH3lsxoYLyOxKJV1L55lR2AAvdYl58mr3DUEhZlShOaPy6uTAdHTuxzhvy12a4/wi9lkewPqiUL6TJIsuZL+l1KJ+RcSIB7sOorVYCDpAQQ51YF8I1U+Y/SEcz5afrvz2jxOOYBvj4zkGQBX02ggktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2Hf5Wum8CncqR0FKW88fYjlxOiD0kKb6eRycZgGNrk=;
 b=BT3ZO+JFEii58KUCSDUgtC++zU+JLjTSZj2muE/ymDfsOYdX0xe2b+XIlGbGgbbqQK246DLzvlgt85Jf0aIYOaUrhIZ2kiYKGCe9+McSjHZkh0XglaBkvXkcasAKIrMSa48yMROgczWCc5/CRWqrkv4a+zG9pWjG9gcSlSUGQgyDM/KMtner5/SZ8KeeuCE32l8445qI7yl/5XuWOebr5c8n+ODcRI1FY/sGlmkbvZoSQtFvR+SF6W2FkVQ4LXPHWhbeUb3eGwrq7A8sr30ohc5qRowW1DIern9VstB9dl6qcirHrEJd/JoX1sYQS/Ol3q1Sm31A3JLaDAekCgKJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2Hf5Wum8CncqR0FKW88fYjlxOiD0kKb6eRycZgGNrk=;
 b=MkHDLgSNPMiDuKAxg4wK3qxbzxjaxiQubaKNrJrI4yCaiSVLDxnmn4xn0scHIVDHVfAr3Nu1m9dwNmy6+Xm/QiaHfdlDILWaU8Fws6iDe649Y15RiY7ZPdlxVndgQuQxKdA0BN+jY0oRZfMfzvoMmTY4t7+mnhR08yevREkelV4=
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 04:44:40 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::23) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 04:44:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:40 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:22 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 4/7] KVM: SVM: Maintain the hardware PMC-filter allow list
Date: Thu, 1 Oct 2026 04:43:48 +0000
Message-ID: <20261001044351.50535-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001044351.50535-1-manali.shukla@amd.com>
References: <20261001044351.50535-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: faedb3b6-fdcc-43b9-36e6-08df1f76b45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|22082099003|18002099003|11063799006|10067099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	N+jR04IowhdAT0lPTkBO/MFl6G53YJomUfOwjHPa1fLyQGtrOD/R4JJmuxc7Yzr6W2lzW0dyCqelQfpNtzns8CnhzbaYoXxolE/THq3npxUEKZXUP5TyeGra7vtY/iynllLza+hVwzklD3eUv5qFSrJUXvex6v0jUjHeiMYHVI0LvvmVnjj0znrafQLwkZ1ocC8o3yuJkXk71j/X9FJD8NIC9Dz4R5ekqtR0+qKOGO36g98zNlKLgyg6AeyeNCEuY9w/buWn8OsYzDhmV7ubpwWNfrSCVLH+1kwkh9AI2ZC80tsR+wj3erJd19NL1KvV9IrdChjAvWwG5Hi941zhL6k1byzBtwO3N5O/GcQkWJZYq6MDhjNvX7VsrYAxjJimeiC3LlggWMAZfij+Y2X45t5CLHmKxDf6JNxB0WIhfS+iDVFXcx6iu5fXFpHA98bEBXb/eJtgYrs0/Cg+Q3sbxMooxmLsMrgXe0rUEdo83gVP0kLQQuF/jEMAaZBCVP52TA5tzyOWMvHkgga921sz7b4m4bVrzbvoma8IAxIw2AUJcgse693pEroOTObWl3tRhTxaCCs3z9RbgQVzuCPq4AohsRNf3dwJFVaa05fPbghq5h0L0r59qUD3Lr1NI9VApaWi1PtBmIJ3LNI+fig/0OTVCz/PnH5RaQf+z90yETdYcrpb+fZykrDcXLgX1MjL/+IRA1hCkxL+NXdp6ujugQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(10067099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D/SPzTcc8tMoN9HDg3hCjs4WOiFswLFW7xOQd3HdBi7X/ll41F68EXJBnBFLU9JDPgxVYkNykBwWvh8bFpwYGyyM4uOUHLoC+9TFVy3cyGM5zkormtKusoZ7ZlWVrcghPlkTGzAbYQzEgJSxYtfSZq/YUlSYNXVo/jbJ/1KI1w4N3iYFwhtOTtZyjPi1GKa4bYI/RqhjDar6+2B+PgkiR4VL7qghsyK6aycptQkkGl4nMoKjmSYUIMxZl+VEtKFGDonDs/1WBgKczSMzq7+8Eylh9EqU6smRlKD/MCGD4BIuMq0OoHqXeG/1GvPs/oUWTigQIN76VPQVPt8LhL9KF+AImiri3BdfkcAzATt6xjNnSMKrLq9RK6e/N0LXpLdIQ2ZLqPPajTtNH5Y19BOe2PGD5qmXH5cCak5405ZTPgD3OQOA3nnntcGFfyqd5j+T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:40.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faedb3b6-fdcc-43b9-36e6-08df1f76b45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343

With hardware-assisted PMC filtering, VMRUN fails if an enabled
counter's event isn't in the VMCB's allow list, and the guest can
program any listed event without a VM-exit.

Add an event to the list when KVM allows it, so that the guest can
reprogram it later without a VM-exit.  When the list is full, rebuild it
from the enabled counters.  A PerfCntrGlobalCtl write can enable
counters without writing their event-selects, so check all counters
again on it.

Because the guest can change its event-selects without KVM seeing it,
KVM's copies can be out of date.  Reload them from the VMCB before KVM
uses them, including when userspace reads them, e.g. for migration.
Reload only once per VM-exit: KVM's own changes reach the VMCB only when
the counter is reprogrammed, so a second reload would lose them.

Nothing uses this until KVM_MEDIATED_PMU_CAP_HW_FILTERED is set.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/svm/pmu.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c |  3 ++
 arch/x86/kvm/svm/svm.h |  6 +++
 3 files changed, 96 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7d3a151b6cdee..634e6a337c31f 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -138,6 +138,60 @@ static u32 amd_pmu_adjust_msr_idx(struct kvm_vcpu *vcpu, u32 msr)
 	return msr;
 }
 
+static void amd_sync_eventsels_from_hw(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_save_area *save = &svm->vmcb->save;
+	int i;
+
+	/*
+	 * Refresh only once per VM-exit: KVM's own writes reach the VMCB only
+	 * when the counter is reprogrammed, another refresh would discard them.
+	 */
+	if (!svm->pmc_eventsels_stale)
+		return;
+	svm->pmc_eventsels_stale = false;
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		pmu->gp_counters[i].eventsel = save->pmc[i].perf_ctl;
+		pmu->gp_counters[i].eventsel_hw = save->pmc[i].perf_ctl;
+	}
+}
+
+static void amd_rebuild_hw_pmc_allowlist(struct kvm_vcpu *vcpu)
+{
+	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
+	struct vmcb_save_area *save = &to_svm(vcpu)->vmcb->save;
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	int i;
+
+	memset(control->allowed_perf_ctl, 0, sizeof(control->allowed_perf_ctl));
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++)
+		if (save->pmc[i].perf_ctl & ARCH_PERFMON_EVENTSEL_ENABLE)
+			control->allowed_perf_ctl[i] = save->pmc[i].perf_ctl;
+}
+
+static void amd_add_hw_pmc_allowlist(struct kvm_vcpu *vcpu, u64 eventsel)
+{
+	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
+	u64 mask = control->allowed_perf_ctl_mask;
+	int i, slot = -1;
+
+	for (i = 0; i < ARRAY_SIZE(control->allowed_perf_ctl); i++) {
+		if ((control->allowed_perf_ctl[i] & mask) == (eventsel & mask))
+			return;
+		if (slot < 0 && !control->allowed_perf_ctl[i])
+			slot = i;
+	}
+
+	if (slot < 0)
+		amd_rebuild_hw_pmc_allowlist(vcpu);
+	else
+		control->allowed_perf_ctl[slot] = eventsel;
+}
+
 static int amd_get_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 {
 	struct vmcb_save_area *save = &to_svm(vcpu)->vmcb->save;
@@ -186,6 +240,14 @@ static int amd_set_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 		return 0;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 		save->perf_cntr_global_control = pmu->global_ctrl;
+
+		if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED) &&
+		    pmu->nr_arch_gp_counters) {
+			u64 bitmap = BIT_ULL(pmu->nr_arch_gp_counters) - 1;
+
+			amd_sync_eventsels_from_hw(vcpu);
+			kvm_pmu_request_counters_reprogram(pmu, bitmap);
+		}
 		return 0;
 	}
 
@@ -202,12 +264,25 @@ static int amd_set_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
 		save->pmc[pmc->idx].perf_ctl = pmc->eventsel_hw;
+
+		if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED) &&
+		    (pmc->eventsel_hw & ARCH_PERFMON_EVENTSEL_ENABLE))
+			amd_add_hw_pmc_allowlist(vcpu, pmc->eventsel_hw);
 		return 0;
 	}
 
 	return 1;
 }
 
+static void amd_clear_hw_pmc_allowlist(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+
+	memset(control->allowed_perf_ctl, 0, sizeof(control->allowed_perf_ctl));
+	amd_sync_eventsels_from_hw(vcpu);
+}
+
 static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -227,6 +302,10 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_EVNTSELn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
+		if (msr_info->host_initiated &&
+		    kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED))
+			amd_sync_eventsels_from_hw(vcpu);
+
 		msr_info->data = pmc->eventsel;
 		return 0;
 	}
@@ -254,6 +333,13 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_EVNTSELn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
+		/*
+		 * The guest may have changed the event-select without a VM-exit.
+		 * Reload it first.
+		 */
+		if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED))
+			amd_sync_eventsels_from_hw(vcpu);
+
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
@@ -430,6 +516,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.mediated_put = amd_mediated_pmu_put,
 	.get_vendor_state = amd_get_vendor_state,
 	.set_vendor_state = amd_set_vendor_state,
+	.clear_hw_pmc_allowlist = amd_clear_hw_pmc_allowlist,
 
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_AMD_GP_COUNTERS,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2023d38bba634..a892ead12ae22 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4596,6 +4596,9 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 		x86_spec_ctrl_restore_host(svm->virt_spec_ctrl);
 
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED))
+		svm->pmc_eventsels_stale = true;
+
 	/* SEV-ES guests must use the CR write traps to track CR registers. */
 	if (!is_sev_es_guest(vcpu)) {
 		vcpu->arch.cr2 = svm->vmcb->save.cr2;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 3db6b73e81634..20c00789b2ae0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -372,6 +372,12 @@ struct vcpu_svm {
 	bool x2avic_msrs_intercepted;
 	bool lbr_msrs_intercepted;
 
+	/*
+	 * The guest may have rewritten allowed event-selects without trapping
+	 * since the last VM-exit.
+	 */
+	bool pmc_eventsels_stale;
+
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
 };
-- 
2.43.0

