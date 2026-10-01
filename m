Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78941DDE5
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829888; cv=fail; b=tgy5j1BUNqIVGXuoSPvL5sEmf6htuMOkaN/wYqsArZmN3QkYDS1cQCf4onVMJQhoZ1Bpdj0r6oz+udUySaz2EEZ4HSVKpqn+dyKDYqo2Ym79rXs5R0EAW5qwESRQiffdgEWQxW1v9RMnqv9KQGObXah5rTfVxgp5CbCkfg6wOI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829888; c=relaxed/simple;
	bh=qEhCHFOThufFy/UHTxF77XoGZnzucURtKyfjKwUHZxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4q4Rx6ON0gnbzmTrgGEUHXoXyyEG5Gh2mgVe4EWuGzvWyck6LvwuQL36FABZt69MC2ytC8NmW9mOtOnmw7FhmFYMxkU1PukhJxqa81FK+Gx7uGi9g+HnqyCCj3i59vZ4+/mEIdjE+pGZoBKb0olCLj9b7/KahvvyuwrkNAMsGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uSwdFow5; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uSwdFow5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuAjfRJj9Ld3iEowMdJ6wH0kmU2tq3rDo95hFYa1R18DAiiOm+tCaccpB16c/sPH1wAg9BoGPH/wumuMYcfAt8RG43G0isutdaq0dBit+E3LmypeRU8DjrQ+E/pCcTVlNr/vUpwxyyX3fSAJsZHJzHnZrKluQmvy/T/jC2z5qbgcYr47Z4FqGLPnr+Aum4LqaIWA5zrJv+ploJU6dHjbKZrSusTBFMUAcgozs6HJe8GyO0dMXFeGoXcMDK8/eWDAVOBRF4ZDDlGYKqqznXsmi2GRndo7ZjXKB4180NyEov/ao9XQuum0xkpLHEsIquiseHBIrt7tiaa1oA6P6sYC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lshk45VekJwsGBStA9zMK4hQFgPGkrAVLnyyDo/IpuE=;
 b=bp8XP3njvFciiMQooz4APpqhGwKr24SWWO0iIq5p5nk3zhUdphRV2YdS3P3qXWySHgDEGkJT1K0SYAJA0qVMu1HIxb32MiXGyaqboWcPCqUQPMQ0slAi6X2smWnPlf8gHIKQ8TcaxXA1FSlZfvEPTE0YNhKlXl1rMBBT3yl5vyFagD/v5ne6KtLmsdfYNAJw9F1G8LgF5HHdOnI8CCmHVNJSgZLq3xvP32r+wzfKmuEB9uAxetZxDV5rgsQPyBNtfPZtfQqrGIfHPiC1IwK9zVvTHwDYzQszh+mVWQAuEPrHZcmeQqRt/Il3xF+Eqt+II4/9SW5/vrst76XC9u+gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lshk45VekJwsGBStA9zMK4hQFgPGkrAVLnyyDo/IpuE=;
 b=uSwdFow5i83CB/TcDc5HVSv+FN9qYhrPsPXn9kmabJ9neHDeJu6WYw3XSDxh91b8x1sZe0XFiB+juHw/MYIfWhVB0VNWSyXR1v5UloXi9S9zKJZyYpcDQ6KmLc8oawJf8EURMMfee+BJp/EwDE5RgX1M/NSebIFeV6Ip78g2sTE=
Received: from BN9PR03CA0909.namprd03.prod.outlook.com (2603:10b6:408:107::14)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:44:41 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::8f) by BN9PR03CA0909.outlook.office365.com
 (2603:10b6:408:107::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 04:44:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:41 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:31 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 7/7] KVM: SVM: Enable hardware-assisted PMC filtering
Date: Thu, 1 Oct 2026 04:43:51 +0000
Message-ID: <20261001044351.50535-8-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dce95c-f61f-4deb-6080-08df1f76b510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|11063799006|3023799007|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xbo+JqEkQlCvVewD3OVA5igomo7iRb2xZA+2PI8O2mlIzJbFWDxxVF2NFNUfktf+e/f1ALxUtgVnHgnviDGKRSaHefdZyxwBQoO2fsSwOtTSSDsBRzFTzs8/VUUiB/y7vLcB918UTDR8G84uvcxcxFrBAi5ejWvF+zlNPUCpaJE9AEiNFsG16jI85S2R3xgzCs7ekEnkxWdQkIximanSGej+2iffJAQPurq+I1JrRXLB1RlggXgk68SSzaPn+AQmnFP1i9y8fdbxyYopu8kXfUxUzx/cks5Cj/p8O+gv3GmFaV+jqt5cMlqDVujcacK1fEWvYeJmF16eJdjZesyCPttiD10CnctauD3swIZeg9/8JMkxwSz2XYG/wi5kIOXO/0hu+xvYgTwBeXywMn/pspq9tkHkQRpNJqXM8prLsVO+0yJvuF3sZE25LUm0zDLDJsyKlVOslOh6R9maU7M6VrSQrhFHSYZ3UIa1sjD1ax0w6DogQ9OqIoU9TqFlNf9LD7EhvGuoFNzBvMl01NCgQ/S8F4CUGC7iAl69GgXWs+PwE4vKN8j5JSxrhBPQTEUnagVnjgpqhZmmY6H3KQSj8lAAQQAR+5XrZEbnf8bJY35fGg1Bk2KpyBT9eyMneR83m4KtuZgM1bCWrXCwvYkAV6IwihX4m/FucOAT7pU54MJ3b75mZZOws4oAvmjcIBX1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(11063799006)(3023799007)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ocr7GiniJYUQ7Qqw3BQgbbSBq7sUtfX/rf7K8H+EKn6EhgelQhl0bKBtqL4/ppWrCW03cqxQvSAVZz6PdvgNl6BTKnU1QkeBmE+K+cG1pdoNVyxF5O7k2Xm/LiOUna7hhbwwdLw1tKf23SG83DZhNfUfmO7EUVdYK7hujf125wrtYkxqEa+g2t3j20xHwVM7et3kY71JsiNt9a3kuUoYgTBzGRXFadgp/Cc46T80o2NT1GAH3TxqojgBTwV7zBzYWCeNbV3Qop8oO2JYbF6hVM7b10O8EllH5HvlA0sA0fD3Twuqj9AwO0feQCMu170yBRj/svjZgwqXGmHzh20PVVcUY9urgCSlrd1fxHuuitdaDsfeSJ4ajE14smiA/HOxgjulSVnKe6XHyZZMOcGG7FvZr8jEvar9QlH8EFbpXGFdqruCiRldgPpB9eF8rUJD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:41.3828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dce95c-f61f-4deb-6080-08df1f76b510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669

To enforce the PMU event filter, KVM intercepts every write to the
guest's event-selects, which is slow for guests that reprogram their
counters often.  When the CPU supports PMC filtering, pass the
event-selects through and let hardware enforce the filter, so that the
guest can reprogram allowed events without a VM-exit.  The userspace ABI
is unchanged.

Hardware-assisted PMC filtering doesn't work when PerfCntrGlobalCtl is
intercepted, so it has to be passed through.  The event-selects are
passed through only for the counters the guest was given, but
PerfCntrGlobalCtl can't be intercepted for only some counters, so it and
the global status MSRs are passed through in full, even to a guest given
fewer counters.  PerfMon-v1 and legacy guests also no longer get a #GP
on them.  Such a guest can set the enable bit of a counter it wasn't
given, but that counter's event-select stays intercepted, so the guest
still can't use it.

Nested isn't supported yet: vmcb02 doesn't enable PMC filtering, so L2
would run with vmcb01's passthrough event-selects unfiltered.  Enable PMC
filtering only with nested=0.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/svm/svm.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a892ead12ae22..4d48286faeb50 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -182,6 +182,15 @@ module_param(enable_mediated_pmu, bool, 0444);
 bool vpmc = true;
 module_param(vpmc, bool, 0444);
 
+/*
+ * TODO: Support nested.  vmcb02 doesn't enable PMC filtering, so L2 could
+ * program denied events through vmcb01's passthrough event-selects.
+ */
+static bool svm_pmc_filter_supported(void)
+{
+	return vpmc && !nested && cpu_feature_enabled(X86_FEATURE_PMCFILTER);
+}
+
 static bool __ro_after_init svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
@@ -752,6 +761,27 @@ void svm_vcpu_free_msrpm(void *msrpm)
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
 }
 
+static void svm_recalc_pmu_filter_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	bool intercept = !kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED);
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	int i;
+
+	for (i = 0; i < AMD64_NUM_COUNTERS; i++)
+		svm_set_intercept_for_msr(vcpu, MSR_K7_EVNTSEL0 + i, MSR_TYPE_RW,
+					  intercept || i >= pmu->nr_arch_gp_counters);
+
+	/* The F15h alias exists only if the guest has PERFCTR_CORE. */
+	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++)
+		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTL + 2 * i,
+					  MSR_TYPE_RW, intercept);
+
+	for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
+		svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTL + 2 * i,
+					     MSR_TYPE_RW);
+}
+
 static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
@@ -776,6 +806,9 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 					     MSR_TYPE_RW);
 
 	intercept = kvm_need_perf_global_ctrl_intercept(vcpu);
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED))
+		intercept = false;
+
 	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
 				  MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
@@ -784,6 +817,8 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 				  MSR_TYPE_RW, intercept);
+
+	svm_recalc_pmu_filter_msr_intercepts(vcpu);
 }
 
 static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
@@ -1273,6 +1308,11 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
 		control->misc_ctl2 |= SVM_MISC2_ENABLE_V_PMC;
 
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_FILTERED)) {
+		control->misc_ctl2 |= SVM_MISC2_ENABLE_PMC_FILTER;
+		control->allowed_perf_ctl_mask = SVM_PMC_FILTER_MASK;
+	}
+
 	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 
 	vmcb_mark_all_dirty(vmcb);
@@ -5332,6 +5372,8 @@ static int svm_vm_init(struct kvm *kvm)
 {
 	if (vpmc)
 		kvm_set_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED);
+	if (svm_pmc_filter_supported())
+		kvm_set_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_FILTERED);
 
 	sev_vm_init(kvm);
 
@@ -5793,6 +5835,9 @@ static __init int svm_hardware_setup(void)
 	if (vpmc)
 		pr_info("PMC virtualization supported\n");
 
+	if (svm_pmc_filter_supported())
+		pr_info("PMC filtering virtualization supported\n");
+
 	svm_set_cpu_caps();
 
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 20c00789b2ae0..3a5e9e4ecaa90 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -862,6 +862,8 @@ static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
 	svm_set_intercept_for_msr(vcpu, msr, type, true);
 }
 
+#define SVM_PMC_FILTER_MASK	(AMD64_EVENTSEL_EVENT | ARCH_PERFMON_EVENTSEL_UMASK)
+
 int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 
 /* nested.c */
-- 
2.43.0

