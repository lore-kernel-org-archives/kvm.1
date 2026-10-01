Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844043B42EB
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860894; cv=fail; b=dLtWLKVacANmqLHxHWDryO4fLcYPV79GdAuMpA5NVLM85CLkGuDq8I8xowgOcqbBbCNOU4whsRwI5Z/WRJqRJw3S+vg8DZMhs3S+YRMkek98nB3fRIf6jQZMz9gR690xcWQxBVnfq2jb6QUty6AZhblZNRxQY3lSUVO3qxrpbQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860894; c=relaxed/simple;
	bh=0FXZXqcvkzjKMwq8wYr8S5SOkKjCHeX6crnZMSOS1uU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcLPZMQTE/DsNqzRiA0TDtzyT2ylXl1luuLXS1TTI0Yk3itvD177SH8HANUORuXwYx3ztR1Zutaz0nZGpZEDAb95hJgEJGpcJZZxDcEizgwo+0ghi1yCP57VC/mpqNoqh7yweweJSYaWKeXBmFPpXtznrlCJA7oiSryhdb+vpxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=25ufiODJ; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="25ufiODJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRpLCN8aeSOnebWEgjzESTBwsOSswS5yQq+E6UfEBD3OKM1DexSVqnhovVtNVPbLtFSf9bD0sUVZq8wkivSWYRJHUUtkkAqj4FrmjWvxW4pyCTs0QA4VGzJohv0LjVl/Sn8ZivpHQaCEeoRThcCfoWLTimMN82WjNNo0M6jSc99kvuSsotbAEA2BgqGjVMGdqfXQyzK+dXtWiuUtDMCeF5VY5Xl8e7KKpqpJDcxYgeV5ZPoDPBH0ZjmTFnKrRk7AJ30gHCfxx1H82gtWhUD6zZTIzUHeAdfoaxTwct48f6Y2KW3qHyx75r+LuxB/51ZgxL35fL91fW+Hcr2XOSu8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKkemuQeNPY7Z2oCpSl18Ekd/u7WnVZhfIGItVRMUzs=;
 b=UldwiR+y8FfDmd2OP+S5dW6NF8nAn9TQ03Lg79K44eKWTRYJpENEMEUyJwNUURKYjns5ZA5LnnWIESxjksH1EshLwjYQyqtWrhBl5kqwYhVVmQwAJ+fHNDeA4vDqrhyav0Aw84QHgLqQ10rF+xIfXTOsUeEzLHG4VshvRjoBvkwnQh5SgbQ3ThOhXTmVUpDrZre1yW9osOZpaw+XK7qlLETyk91zYCwIta0BSXTcyQPk92AtoQ7VJtO3RJaakcO7YBS9LAN2g34WttANWROzc0Dn2okLPTXH23afWB/Z3twzDMsOxPAxBVrQlSKcA2tCW8NI1OGRwofT+cQNMnqzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKkemuQeNPY7Z2oCpSl18Ekd/u7WnVZhfIGItVRMUzs=;
 b=25ufiODJV6fyTeHnxH/GkjgMqQ3fVYptwzzUb+DTfB9QQjXHv1JfinImiJG8HxvR3I9QydJAQv6FWBYUcCEXxh4k9q6iigmFpVuLK6yjtkJchN7wt8AOkDE9ao33vFmMhmoyWPxhKh+s1A/6QVYpVunefvfWgRqSxMWakO9VHjY=
Received: from BN9PR03CA0844.namprd03.prod.outlook.com (2603:10b6:408:13d::9)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 13:21:21 +0000
Received: from BN3PEPF00022BCB.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::48) by BN9PR03CA0844.outlook.office365.com
 (2603:10b6:408:13d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 13:21:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCB.mail.protection.outlook.com (10.167.248.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:21 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:21:16 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 7/9] KVM: SEV: Filter PMC event-selects forwarded by SEV-ES and SNP guests
Date: Thu, 1 Oct 2026 13:20:19 +0000
Message-ID: <20261001132021.254270-8-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCB:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6ba423-d709-4a96-35ce-08df1fbee26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|10067099003|260925022911599003|260925021311599003|260925021911599003|3023799007|6133799003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0IQ430thtWKVaJAdJ/+mVZcXrKnwAckCM5bPHFF18nl0eS3FECZAb5dcr0OncmbZ3p5wbNFWd9pSa7B17FjlpJE9byhGD2oExEbiHEZRHnehRQTPvHl3FrRqfjVEqFKvYjGXBIV2qmpWbTHXnbP8mZfY4slzAsXCDyBRJcRexnexg1vy4ahZ+ljxXfHpeV/u66Aqy0f8bxNe4XjPHbVR8/XTJCnMjw3qhZZgKL9AhfFF6Ukx6lnCmOs8aRNmWqbE3uZGOF9W7MGjYiwKEcw5Sqctfq99pexRukAERfdXAAP4MJ0QENJDGQBewEXV2asyPNLHcEUfOCwH1jEjO3dPBOD1T60flLQLXSQIxCVE6R3m+DiGCHh/a5kddh+/caAfQXRLy9bvvuCCuizUDOpaGEpakR+rk97jL46E9PcwG1X7eLgolwwGcMAh1Xl1MjhXAdJ4UYWRlBYMD2IPBSR+J/BUS14CtpAQjJDc+5Cd3JjAFY62zM9Nn0SUIlCSSo2v0mBnaWaGHgDBIWnzNrFBEoi9TD6PxaNmOkm1WIuRUVgLcQFiRAYZGpIB9z2GTWCtJbYFPK6Kbm++3GXHoTkvOzI41KwxiKDTeAdS1V4KyYnlpDWNUPn0yE38ZZxlVXxy2CYp/pDTQDDGtQJSrw0Xnu5Epm6m0wEooDNrKvtgCi0eubeOssC23AjGNuletR5/q3PgzGfO70n7uNxovk4+xQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(3023799007)(6133799003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uiHvOVXyqBX5hjbXXw5pz/c0P5VPd524emc/3vJn5wjDC/1IuxhzVbEmEPnzaCUcPKulDZOYgLOVjHHw9xR9DWvVK6nJpBl8M8BenQrG9lcjkPjyKm5HVvBhdhjdL+oaGrYbuwVr1b8Q48Hd4ve/zqzOj+WweDv7dDJby1w7uqtbeHpFQhG/VmYLTb4JPzDuyCPmFmxhhacgL5XK7QFai3D/mDutgPfyvzNaF2uw+k6+tZnor/n9NKg2/87of37UOe1WGeuKXE3BxeBwHNfq8lPIoDSTfovg30JZxhxLlJOpVJJ7mXk1l3/B2gFfSVtee6KOQKoDM/Uug5XlgFHyv6y8AnuwnJ4vXSjm+TMEcc6SzdjCAGRS/otk/Br8bzf4IjsJIK0GVN4+BaTuUoBJ0OE14PjwrMggULhuRAI795gwyqPp6RyYj1p6FxWqsWVk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:21.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6ba423-d709-4a96-35ce-08df1fbee26a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647

KVM can't intercept a protected guest's event-select writes, and can't
read or write the VMSA copy, so the guest forwards writes that trapped
on a missing allow-list entry with SVM_VMGEXIT_PMC_FILTER, along with
all of its event-selects.

Emulate the write and run the resulting reprogramming synchronously, so
the event filter decision is returned in the scratch buffer and RAX/RDX
for the guest to program.  As for other guests, a full allow list is
rebuilt from the enabled event-selects, but as these are guest-supplied,
only events the filter allows are listed.

Now that KVM tracks the guest's event-selects, skip counting emulated
instructions, KVM can't update the counters in the VMSA.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/pmu.c     |  7 +++-
 arch/x86/kvm/pmu.h     |  1 +
 arch/x86/kvm/svm/pmu.c | 81 ++++++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/svm/sev.c | 54 ++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c |  1 +
 arch/x86/kvm/svm/svm.h |  3 ++
 6 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index ace39076977af..23d439ad182c6 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -573,7 +573,7 @@ static bool is_fixed_event_allowed(struct kvm_x86_pmu_event_filter *filter,
 	return true;
 }
 
-static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
+bool pmc_is_event_allowed(struct kvm_pmc *pmc)
 {
 	struct kvm_x86_pmu_event_filter *filter;
 	struct kvm *kvm = pmc->vcpu->kvm;
@@ -587,6 +587,7 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
 
 	return is_fixed_event_allowed(filter, pmc->idx);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(pmc_is_event_allowed);
 
 static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 {
@@ -1209,6 +1210,10 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 
 	BUILD_BUG_ON(sizeof(pmu->global_ctrl) * BITS_PER_BYTE != X86_PMC_IDX_MAX);
 
+	/* KVM can't access a protected guest's counters. */
+	if (vcpu->arch.guest_state_protected)
+		return;
+
 	/*
 	 * The guest can reprogram allowed events without trapping.  Don't count,
 	 * or raise a PMI, for a counter the guest has since repurposed.
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index d0b0589d3ae45..484e94307d731 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -175,6 +175,7 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 }
 
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val);
+bool pmc_is_event_allowed(struct kvm_pmc *pmc);
 
 static inline bool pmc_is_gp(struct kvm_pmc *pmc)
 {
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 3ef05b651de21..967bd687b54c4 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -138,6 +138,46 @@ static u32 amd_pmu_adjust_msr_idx(struct kvm_vcpu *vcpu, u32 msr)
 	return msr;
 }
 
+/* KVM can't read a protected guest's event-selects, the guest forwards them. */
+static void amd_load_eventsels_from_ghcb(struct kvm_vcpu *vcpu)
+{
+	struct perf_ctls *ctls = to_svm(vcpu)->sev_es.ghcb_sa;
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int i, n;
+
+	n = min_t(int, READ_ONCE(ctls->num_counters), pmu->nr_arch_gp_counters);
+	for (i = 0; i < n; i++) {
+		pmc = get_gp_pmc_amd(pmu, READ_ONCE(ctls->counters[i].perf_ctl_idx),
+				     PMU_TYPE_EVNTSEL);
+		if (pmc) {
+			pmc->eventsel = READ_ONCE(ctls->counters[i].perf_ctl_val);
+			pmc->eventsel_hw = pmc->eventsel;
+		}
+	}
+}
+
+/* Return the filtered event-select, the guest programs it. */
+static void amd_publish_eventsel_to_ghcb(struct kvm_pmc *pmc)
+{
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+	struct perf_ctls *ctls = to_svm(vcpu)->sev_es.ghcb_sa;
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	int i, n;
+
+	n = min_t(int, READ_ONCE(ctls->num_counters), pmu->nr_arch_gp_counters);
+	for (i = 0; i < n; i++) {
+		if (get_gp_pmc_amd(pmu, READ_ONCE(ctls->counters[i].perf_ctl_idx),
+				   PMU_TYPE_EVNTSEL) == pmc)
+			WRITE_ONCE(ctls->counters[i].perf_ctl_val, pmc->eventsel_hw);
+	}
+
+	if (get_gp_pmc_amd(pmu, kvm_ecx_read(vcpu), PMU_TYPE_EVNTSEL) == pmc) {
+		kvm_eax_write(vcpu, lower_32_bits(pmc->eventsel_hw));
+		kvm_edx_write(vcpu, upper_32_bits(pmc->eventsel_hw));
+	}
+}
+
 static void amd_sync_eventsels_from_hw(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -151,6 +191,14 @@ static void amd_sync_eventsels_from_hw(struct kvm_vcpu *vcpu)
 	 */
 	if (!svm->pmc_eventsels_stale)
 		return;
+
+	if (vcpu->arch.guest_state_protected) {
+		if (svm->sev_es.pmc_filter_pending) {
+			amd_load_eventsels_from_ghcb(vcpu);
+			svm->pmc_eventsels_stale = false;
+		}
+		return;
+	}
 	svm->pmc_eventsels_stale = false;
 
 	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
@@ -168,6 +216,21 @@ static void amd_rebuild_hw_pmc_allowlist(struct kvm_vcpu *vcpu)
 
 	memset(control->allowed_perf_ctl, 0, sizeof(control->allowed_perf_ctl));
 
+	/*
+	 * Unlike the VMCB copy, which hardware keeps to listed events, a
+	 * protected guest's event-selects are guest-supplied.  Check each
+	 * enabled event against the filter, or the guest could list any event.
+	 */
+	if (vcpu->arch.guest_state_protected) {
+		for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+			struct kvm_pmc *pmc = &pmu->gp_counters[i];
+
+			if (pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc))
+				control->allowed_perf_ctl[i] = pmc->eventsel;
+		}
+		return;
+	}
+
 	for (i = 0; i < pmu->nr_arch_gp_counters; i++)
 		if (save->pmc[i].perf_ctl & ARCH_PERFMON_EVENTSEL_ENABLE)
 			control->allowed_perf_ctl[i] = save->pmc[i].perf_ctl;
@@ -234,20 +297,22 @@ static int amd_get_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 static int amd_set_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 {
 	struct vmcb_save_area *save = &to_svm(vcpu)->vmcb->save;
+	bool protected = vcpu->arch.guest_state_protected;
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 
-	/* A protected guest's PMU state is in the VMSA, there's nothing to do. */
-	if (vcpu->arch.guest_state_protected)
+	if (protected && !to_svm(vcpu)->sev_es.pmc_filter_pending)
 		return 0;
 
 	/* MSR_PERF_CNTR_GLOBAL_* */
 	switch (msr) {
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
-		save->perf_cntr_global_status = pmu->global_status;
+		if (!protected)
+			save->perf_cntr_global_status = pmu->global_status;
 		return 0;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
-		save->perf_cntr_global_control = pmu->global_ctrl;
+		if (!protected)
+			save->perf_cntr_global_control = pmu->global_ctrl;
 
 		if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED) &&
 		    pmu->nr_arch_gp_counters) {
@@ -264,14 +329,18 @@ static int amd_set_vendor_state(struct kvm_vcpu *vcpu, u32 msr)
 	/* MSR_PERFCTRn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_COUNTER);
 	if (pmc) {
-		save->pmc[pmc->idx].perf_ctr = pmc->counter & pmc_bitmask(pmc);
+		if (!protected)
+			save->pmc[pmc->idx].perf_ctr = pmc->counter & pmc_bitmask(pmc);
 		return 0;
 	}
 
 	/* MSR_EVNTSELn */
 	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
 	if (pmc) {
-		save->pmc[pmc->idx].perf_ctl = pmc->eventsel_hw;
+		if (protected)
+			amd_publish_eventsel_to_ghcb(pmc);
+		else
+			save->pmc[pmc->idx].perf_ctl = pmc->eventsel_hw;
 
 		if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED) &&
 		    (pmc->eventsel_hw & ARCH_PERFMON_EVENTSEL_ENABLE))
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 1cf2260423573..b73484620e2a3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -35,6 +35,7 @@
 #include "svm.h"
 #include "svm_ops.h"
 #include "cpuid.h"
+#include "pmu.h"
 #include "trace.h"
 
 #define GHCB_VERSION_MAX	2ULL
@@ -3496,6 +3497,11 @@ static bool sev_es_are_required_ghcb_fields_valid(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_MMIO_WRITE:
 	case SVM_VMGEXIT_PSC:
 		return kvm_ghcb_sw_scratch_is_valid(svm);
+	case SVM_VMGEXIT_PMC_FILTER:
+		return kvm_ghcb_sw_scratch_is_valid(svm) &&
+		       kvm_ghcb_rax_is_valid(svm) &&
+		       kvm_ghcb_rcx_is_valid(svm) &&
+		       kvm_ghcb_rdx_is_valid(svm);
 	default:
 		return true;
 	}
@@ -4023,6 +4029,52 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	return snp_do_psc(svm);
 }
 
+static bool sev_es_is_pmc_filter_msr(u32 msr)
+{
+	switch (msr) {
+	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
+		return !(msr & 1);
+	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int sev_es_handle_pmc_filter(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	u32 msr = kvm_ecx_read(vcpu);
+	int ret;
+
+	if (!kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED) ||
+	    !sev_es_is_pmc_filter_msr(msr)) {
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
+	}
+
+	ret = setup_vmgexit_scratch(svm, true,
+				    struct_size_t(struct perf_ctls, counters,
+						  vcpu_to_pmu(vcpu)->nr_arch_gp_counters));
+	if (ret)
+		return ret;
+
+	svm->sev_es.pmc_filter_pending = true;
+	ret = __kvm_emulate_msr_write(vcpu, msr, kvm_read_edx_eax(vcpu));
+	/* Reprogram now, so the filtered event-selects go back to the guest. */
+	if (!ret && kvm_check_request(KVM_REQ_PMU, vcpu))
+		kvm_pmu_handle_event(vcpu);
+	svm->sev_es.pmc_filter_pending = false;
+
+	if (ret)
+		svm_vmgexit_inject_exception(svm, X86_TRAP_GP);
+	else
+		svm_vmgexit_success(svm, 0);
+
+	return 1;
+}
+
 static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4659,6 +4711,8 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 
 		return snp_begin_psc(svm);
 	}
+	case SVM_VMGEXIT_PMC_FILTER:
+		return sev_es_handle_pmc_filter(svm);
 	case SVM_VMGEXIT_AP_CREATION:
 		if (sev_snp_ap_creation(svm))
 			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ac8f06e1f5a10..cdd102c761994 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2851,6 +2851,7 @@ static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 {
 	return is_sev_es_guest(vcpu) && vcpu->arch.guest_state_protected &&
 	       msr_info->index != MSR_IA32_XSS &&
+	       !to_svm(vcpu)->sev_es.pmc_filter_pending &&
 	       !msr_write_intercepted(to_svm(vcpu), msr_info->index);
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1f3cd12e44c46..3615997b339ec 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -282,6 +282,9 @@ struct vcpu_sev_es_state {
 	gpa_t snp_guest_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
+
+	/* Handling SVM_VMGEXIT_PMC_FILTER, the scratch area holds event-selects. */
+	bool pmc_filter_pending;
 };
 
 struct vcpu_svm {
-- 
2.43.0

