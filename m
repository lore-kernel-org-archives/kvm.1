Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217840B6D4
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829891; cv=fail; b=Bo3FNEqI5Tgk6I7Bt1QevfS3tLVLl68uBluu8pQCWQrYRvcW/KUaXQvKnCPUesE1F9IHEhm/yV7oowmfClhcxbBCMcpoMAniaSo8K9s1s4q7AIEbt8M6LVSMcLeDSbdtVec4uBQb5Wt+Bn1HOq/EoSOUEIeSdE6VMqORAQ4fx4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829891; c=relaxed/simple;
	bh=0MEKsbeE7SawF0CTBVQcnbmCtLN8SnGXrUNkUnQ1tu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tALSdid9X9a1DiEzmUG/1Y6KdVzefSG++8qh2FXsuw42Aux30ZqlrYgKd19k8xA0VtUROnoA7hC5MDrQCNlaIG5VO4UTPhxMiU7AJ5rgQxgkb8o2eS3dos9pSA/EGt2CJyrN571ywnNHFGqtVefZlWxnKYNiPxBeUAhuJ87k71U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CtNg5WIA; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CtNg5WIA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa5zPBl2hFiEH4Gf3Hz8Mu/SvPgB2eGVWpA6hwS70aNMH4/vWYVeDfXiv0iQBrLKlVZkaE4WnQmrKg+/qKAFn4UfQpbvPP7JUMaA/2kOXV1l9cX89Pv6r66X2BQdBzzMfS8pbOHGjISd+W+AWYeA8PY+zbmRagNsEvN6OLAGT5CNVUqM1WgQOTNUl0QxqNe7mbJDk1cROUzbbCAfc/j0XuLf+q+DNpl5Wv238YlsrxsfqpRaiW5cXjCEZh1FXlAPixuGrml3uikgjvzgAs3V9vClp6zZHiHpahF61xUdglS9qHyOgkaI9i+FTlz0m4i9YqLA/zOXTAHXoW5i3dAK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+wV/971+I1vejfgNruLMKrvtbrOlGLc0IkaBWJSKZg=;
 b=QxQznUbMlISdj0L6qt3iYyqwI0efn4aXUGnoqJkG0vCFjIrUXyx8Ac/5D5VLJwAPVfnPr3pANCDdjEnf9fA3RHdTxQhSBTE8UriJE2WaObTjs27Qr65lKNb5m5kE5cSk70bPnki/8RT0SFoc5TSgHRDQ2GYJRS+wXr3XHa+E1QjegDYZ1+RNZyFDaJa9a6QK3MjpeNWARzEWVq4YdTQlNk14vHlSkR4BkGpiQBqJr4C/yyc3xNhd4Om3olFxG5/eu2gi9T/6h3o0f5J+8CDaN81mpGzJgGDwUQjj9qNdKGK1rUVetll2Z3Ee2RHtuNbhDm0ZGbsuqjj8YpfqkyHJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+wV/971+I1vejfgNruLMKrvtbrOlGLc0IkaBWJSKZg=;
 b=CtNg5WIAsyj3YuVdeiy99wnYLmCqeo8hy7R0vm/TCeaquaOi4psXf5R6oKbjYrhFjDQPlK/a/1tYHGWnODgT6Xgh00oY1gr+LnfhK+cQiupDksOvnoq3bsvyI9KE2Kbe3jQ8hPmGN82gfgcqOua82P53k7yiIDLgq6g5wwZjWgw=
Received: from BN9PR03CA0907.namprd03.prod.outlook.com (2603:10b6:408:107::12)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 04:44:40 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::3e) by BN9PR03CA0907.outlook.office365.com
 (2603:10b6:408:107::12) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:39 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:19 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 3/7] KVM: x86/pmu: Clear the hardware PMC filter allow list on filter changes
Date: Thu, 1 Oct 2026 04:43:47 +0000
Message-ID: <20261001044351.50535-4-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca6388a-6a85-43cd-6b60-08df1f76b437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vmr+bzhRsiieFIK+cBIlWzH50OJwFQfjJ58ZWsop/Dr8wrhKPXAoqjgjt4M8sUuHZTEkFPvFEY5k3GQnWSNAXM9w8UmyXqxsjQ29BPvF/fmii5AFAsOQK7X7R4J+KyPq/lmMza0Q/REsJzp/EaQ6RxyqhqqIGJfnmzrnS73ghUHPldAXjackAN9DDgR1MgEyUDWyDcAb9pYxRLzZYHbXEh/t4SWnlyIPBr4Y9xMB/8bTWBxr+6KFUvrtlInCmqcjSsT7Xz+GSeqO4uS4G3pRlOj9iTeydp8qBI58YZU/dxMSIyy6oeggYHrl6TdO4af9tvUr49LjzE0Gz3qdjKxLlpWchC2AoBUsQyd+OR3CidlqAqF+sZtPBHHr5CU3kpbZy8c7ByvHbnv4zcNweKetQR9djDCB6Kcex9+N4bEEmAvwIPbVbJX6RfMh/ivtmqSBFLgc7JwTrV2atCRJhiItSG0sY+oTIbdW1XLzusXecvrt6xiLMNK306cyaoM+7v/L1SIyuIiw72VlfH9tk17HpufoSm96UJTL+QRxuMLql+t/QcJeW1UXOmglMRHuHR6oro1AnMC8SSfw7u+xjE/sMgXwbZZ6zLRxxyM5ZORbTlPvv0Xc/oxlUgjbP8WAtutGTPztU4/TbHC7chLeVxSC/8/CrYNMfSwiIZIL4vYmMs/rrdBXZ8jbNS8VTAujfZpfTvgwOBm3YWOEkSe2wq7Hew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BJSjiOjjj1JlTG6VC7mgGbw9/Lc0a3YztSKc5r8xEDlJ6I/+XKTMbFc7+r17fqFWIomvt2tbi88O/Z5ljGd72b3hTXp77lBcWJREWjC8pcMrMpFnFF1CGBNQ+S/hiVhf4w4AIwiTs8iap89apekkQcoVoOQtcJtw8zYGj4ldOaZHFKrVzNktPwGfQ8hyVi94lvi6rP7uFI3jnm+fqGcrjzRKTgBjaBkYN91NGyAM9QhC3KzcZeflEqVkGUg5BEqehJdwNqNE51b1Wp363kJ9Do0vjesK4/LILtGfioV9why0dJOJfKUS2sduXe2b+GEhGZ7tnGcu4SrIb6fRalvzuQZi3pvHhLE8allbEb9u1wE6kOCvMeMxceTkaD3gPKYDdqVJt31UeMd/D3UKohZNzHqPWzYJx0HA1A5Rmbwh4JTzVCPYYhsBEAYjQkJWRjfi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:39.9604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca6388a-6a85-43cd-6b60-08df1f76b437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328

With hardware-assisted PMC filtering, the VMCB holds a list of the
events KVM has allowed, and the guest can enable those events without
KVM seeing it.  When userspace changes the PMU event filter, the list
can still hold events the new filter denies, so the guest could keep
counting them.

Clear the list when the filter changes, so that only events the new
filter allows get added back.  Re-check all counters in the same pass:
an enabled counter whose event isn't listed would make VMRUN fail, and
the counters pending re-check may have been picked before the filter
change was seen.

SVM implements clear_hw_pmc_allowlist() later in the series.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h        |  7 +++++++
 arch/x86/kvm/pmu.c                     | 16 +++++++++++++++-
 arch/x86/kvm/pmu.h                     |  1 +
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 4a617162d4c08..dcec41ad080a4 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -27,6 +27,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
 KVM_X86_PMU_OP_OPTIONAL_RET0(pmc_is_disabled_in_current_mode)
 
 KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
+KVM_X86_PMU_OP_OPTIONAL(clear_hw_pmc_allowlist)
 KVM_X86_PMU_OP(mediated_load)
 KVM_X86_PMU_OP(mediated_put)
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 338df11e2a4df..fea7b65e68331 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -628,6 +628,13 @@ struct kvm_pmu {
 	 * redundant check before cleanup if guest don't use vPMU at all.
 	 */
 	u8 event_count;
+
+	/*
+	 * Flush the hardware PMC filter's allow list on the next reprogram, as
+	 * its entries were vetted under conditions that no longer hold, e.g.
+	 * the old PMU event filter.
+	 */
+	bool filter_changed;
 };
 
 struct kvm_pmu_ops;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4c918aa6d6f37..7cc72b3863545 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -721,6 +721,17 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(sizeof(bitmap) != sizeof(atomic64_t));
 	atomic64_andnot(*(s64 *)bitmap, &pmu->__reprogram_pmi);
 
+	/*
+	 * Stale allow-list entries would keep matching in hardware, drop them.
+	 * Every enabled counter's event must then be listed again, so re-vet
+	 * all counters, not just the ones pending.
+	 */
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED) &&
+	    xchg(&pmu->filter_changed, false)) {
+		kvm_pmu_call(clear_hw_pmc_allowlist)(vcpu);
+		bitmap_copy(bitmap, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	}
+
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap) {
 		/*
 		 * If reprogramming fails, e.g. due to contention, re-set the
@@ -1370,8 +1381,11 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
 	BUILD_BUG_ON(sizeof(((struct kvm_pmu *)0)->reprogram_pmi) >
 		     sizeof(((struct kvm_pmu *)0)->__reprogram_pmi));
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		atomic64_set(&vcpu_to_pmu(vcpu)->__reprogram_pmi, -1ull);
+		if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED))
+			vcpu_to_pmu(vcpu)->filter_changed = true;
+	}
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_PMU);
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 42d33072ece90..4a19b806b8480 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -42,6 +42,7 @@ struct kvm_pmu_ops {
 	void (*mediated_load)(struct kvm_vcpu *vcpu);
 	void (*mediated_put)(struct kvm_vcpu *vcpu);
 	void (*write_global_ctrl)(u64 global_ctrl);
+	void (*clear_hw_pmc_allowlist)(struct kvm_vcpu *vcpu);
 	int (*get_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);
 	int (*set_vendor_state)(struct kvm_vcpu *vcpu, u32 msr);
 
-- 
2.43.0

