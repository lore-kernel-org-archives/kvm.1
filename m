Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92E3B8BC1
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357068; cv=fail; b=E0KkbGlH3TW8X8fNikFvj1nC5L+20i9tKonJTzYQifwoOvNSfOHiWz8DRBwTQhOK5w9diVqv9RQlUjJvEXq2i1uT23IfaFCdyZK/G6NPNs3sgYa7Moiie1x+b9wH0/aHPjtTsMBXFooXSLrktMhkrMsd/g8F67gCi4tGwzW7S3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357068; c=relaxed/simple;
	bh=sLgF5fNJocxRJrJKX0lIphfwCXvtmYWNtiAvf/67Xcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6rqA85XT4n7U0tc7c3dMz3CzF9yboG2IF7EIUnz8ThFaXCIFzLepgPltTRL17/FUONDE0PRaWE4wTbiwqOJ4FlMe5olT06X6glb5j78uzySbPyPhF7e0eYeTlJw/e75Y//N0c6d2PznBmpkinJpFbkIcpc4rm5NwBPowILsyj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IlTHx1mG; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IlTHx1mG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoIFEZUq/xumNID7Ahq24RBc653rS/NagUqjaozBxDGnuCl3X7ZleflzJMcd3W1elF6ZMbnKunpo953kc6ADlfUae5NellsBjVAH/InJf8ytl2X4gVclrGqZoa/VJTU8Lj8c0uW7JgUaYdHHkCqtk8g0x14GnlXpTS/5u4IYDa+V7L7nSV3yebf87MMZF3S579qonHmPxwYoUcq7AdZlugLXz515svIsTMjxzXmULsVsYAVaMN8Im3QyHBEdJEI9jSHvpcTmWkMH4mSIqMTdZT06Ir6Me/Ppoyxc23tkl5aaeRFy6A4l1baJW/+BCm8FtF0FiuJtixZu3ca9LE4NIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvpR2lChk3+EqZyDQalwO6BeWWBhDehhWAlf6qfAr64=;
 b=eeGVpqGQGwFPGIgeu0vSzBbBOvEfYFITRNEG/ahRRI/lob0LXrEj8fN7Gv8p4amdsZwfoJJ05FJ/xD0Brx0gWLNc0E6K1SHVbWcj8a9TwQHh7yxn9gW7xCp+BUxtUz3wO4TjhIhZeguQXP8GX4hlTa43Myfwu2RJ9gANKKcEsiKkFS/eMQJm07XO/n5mR7//vxrZsG0kM3MUxK60Sjli/2N0ViAlgr8KH9WRvqhku7EHZDBVUYxQTdvSQk6+W7Ht2+sc/0zJb6MeQxuHxsFl7v18aOEkQdCOzxvlVpTEus2Vc76inasMOI95VeD1nJhxu6BRd/989Qo7gyUo0Oob9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvpR2lChk3+EqZyDQalwO6BeWWBhDehhWAlf6qfAr64=;
 b=IlTHx1mGjK8iXQ6Oowrm5r2Hrf13ngoCApdiKvFUa/RZmJOUWs+gBMT/FhkOWUpQSgbFxDNXGsLoVcAfQfemrh2+2o+eOxkSGfTK0Q50wyun7FOH00rXXfc56GQ9f8LYg2xBY31M1b/TSnZq3ljsvNtsgTKXkqyDly4UeG1wABM=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:17:41 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::2b) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:17:40 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:17:36 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 7/8] KVM: nSVM: Add support for hardware-switched PMU
Date: Mon, 10 Aug 2026 15:44:55 +0530
Message-ID: <ee1f0eb2aae5f5984b5db33d89937a06a305d0dc.1786345201.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 077e18db-a6c2-40db-6425-08def6c89c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	yLXjk5arfuDV9uR04z/N1u+qSC2WmvK+sX/HCUZIpVIRl36aeg13G5YSRgBCC8KY2ps+LG8f2r0z+k9eGG4sCqZuDJ6J21y210VI/IByLrx9jh+LkDq8WLsZ/5XZ6muxgaGXn5JQO2KdMCtxymNdT+R5VKeGlXQaGNGbiq4/Bi+wMSGResmBnsbbY6eFtC5K1Sa8bgSw1LrRgZAuOIy6pYvIkxzKq5ZSz8MsnHccCsyV9sVnuwAiM8vwYbKUi6LHzPH61kB2uH+Qz9ewOAZEcUdrhKvz5GfRlSN5uV2AsB5eckmavqq8vnR2I/YZoHbwuhd8csVd9uHqgQduNQGwjlDaKCjC1vk2egQxEub/srvFc2iBtqcrIyKMBn+ftqWj1SN8pCGVmui773quz9066y5gGRE+38LN1MDaBcjaO+M6W8V1Q3gt5PXgvaKPFX0T5Wtsr3/cRv9Jw1FvrQg6ve1TnRrLbW4Nf8IwxUjHDZs/uB1EXOztVdjQa/50Ct3/oNYMghrWcVLJz6gXBoEFkKFVL/CAimcmeV1qMMRF3T/4LQL5g0VO5u3iOxWS9ms+jdjJ1wQImUlGmNjfix7vOToTHULssPfXQsP6NVsRowneVyT0k9F6Ju7WSfFV1y/XoKCUExNz329tSBRNQzxaxw6qLygOHMbo3o1pog2ixDJsKB6/jFFGde9HkLPXgZMCVBzSe/k8Fdm/QSITlHcOfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YZdFGwgCnz9xI6p2++k+s0ujfe3dwREoJGiXWSIj9dRQzrZsFe2q2OyDhl5PoxWAJLsBfZbrTVRUjkeBWKJ+kN3zEzBx0CEzpAjjPDnlijpf7oRzpnO7tfuqSiNhhWCZL6muUrgr7NoDF81AF9MBvpn4mBmL7HXRWmIaeoKX/xXgwiHrQHRE3ODJKZ88a2iKZLcBPr4IIqUNK69qO9T5gNm2eb7Xh4cgDnymdLrX1AMKIPCaJz0fhEJ83GyB364iWOjfgO4cle7gpFvqhGZoSv0gcF91goYRosu0Jkqll/5oT5H2tV/VOdk6aIRD8nvYRTg9aqFZx2QdwcLORMFJW0nJE88AXZ8h3eZOZM2CZ4GxY8keXY6Bdt8ii9ZFgaT/1ZgCh31ngsDE84J6tHOllC0FElaYRBDMys6E3njk423Ru0439MlKlZCPGfQOsy9h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:17:40.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077e18db-a6c2-40db-6425-08def6c89c2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

Add nested support for PMC virtualization and advertise
X86_FEATURE_PERFCTR_VIRT so that a L1 hypervisor can use it for its L2
guests. As long as the L0 hypervisor uses hardware-switched mediated
PMU for L1, it is used while L1 runs L2 guests as well, irrespective of
what L1 does.

Since hardware runs L2 from vmcb02, not vmcb12, enable PMC
virtualization in vmcb02 whenever it is enabled in vmcb01, so that
hardware switches the PMU state using the vmcb02 save area. The state
to switch depends on whether L1 enables PMC virtualization for L2.

An L1 hypervisor enables PMC virtualization for L2 by setting bit 3 of
misc_ctl2 in vmcb12. Following commit 84dc9fd0354d ("KVM: nSVM: Cache
all used fields from VMCB12"), cache the PMU-related fields to avoid
TOCTOU hazards. Copy the cached L2 PMU state into vmcb02 for L2 VMRUNs,
and back into vmcb12 on nested VMEXITs, so that L1 observes the latest
L2 PMU state.

When L1 does not enable PMC virtualization for L2, the PMU state to
switch is the one in the vmcb01 save area. Copy it into vmcb02 for L2
VMRUNs, and back into vmcb01 on nested VMEXITs, so that the latest PMU
state is preserved for L1.

The counter reprogramming done on nested transitions writes into the
vmcb02 save area, so run it after copying the PMU state into vmcb02;
otherwise the copy overwrites it.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/cpuid.c      |  1 +
 arch/x86/kvm/svm/nested.c | 45 ++++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/svm/svm.c    |  4 ++++
 arch/x86/kvm/svm/svm.h    | 18 ++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ddb022cb203a..ce4f984bc6e1 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1217,6 +1217,7 @@ void kvm_initialize_cpu_caps(void)
 		VENDOR_F(VGIF),
 		VENDOR_F(VNMI),
 		VENDOR_F(SVME_ADDR_CHK),
+		VENDOR_F(PERFCTR_VIRT),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_001F_EAX,
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..a9f9caeb7840 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -605,6 +605,7 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
 	to->g_pat = from->g_pat;
 
 	svm_copy_lbrs(to, from);
+	svm_copy_pmcs(to, from);
 }
 
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
@@ -741,6 +742,17 @@ static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
 		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
 }
 
+static bool nested_vmcb12_has_vpmc(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Since nested AVIC is not supported, L2 PMIs can only be delivered
+	 * via VNMI, so make it a hard requirement.
+	 */
+	return guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_VIRT) &&
+		nested_vnmi_enabled(to_svm(vcpu)) &&
+		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_PMC);
+}
+
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 {
 	struct vmcb_ctrl_area_cached *control = &svm->nested.ctl;
@@ -823,6 +835,11 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 	}
 	vmcb_mark_dirty(vmcb02, VMCB_LBR);
 	svm_update_lbrv(&svm->vcpu);
+
+	if (nested_vmcb12_has_vpmc(vcpu))
+		svm_copy_pmcs(&vmcb02->save, save);
+	else if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		svm_copy_pmcs(&vmcb02->save, &vmcb01->save);
 }
 
 static inline bool is_evtinj_soft(u32 evtinj)
@@ -863,7 +880,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(vcpu);
-	svm_pmu_handle_nested_transition(svm);
 
 	/*
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
@@ -986,6 +1002,10 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	/* SVM_MISC2_ENABLE_V_LBR is controlled by svm_update_lbrv() */
 
+	/* L0 uses hardware-switched mode for both vmcb01 and vmcb02 */
+	if (kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		vmcb02->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_PMC;
+
 	if (!nested_vmcb_needs_vls_intercept(svm))
 		vmcb02->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
 
@@ -1065,6 +1085,9 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 	nested_vmcb02_prepare_control(svm);
 	nested_vmcb02_prepare_save(svm);
 
+	if (!nested_vmcb12_has_vpmc(vcpu))
+		svm_pmu_handle_nested_transition(svm);
+
 	ret = nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
 				  nested_npt_enabled(svm), from_vmrun);
 	if (ret)
@@ -1228,6 +1251,9 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 		svm_copy_lbrs(to_save, from_save);
 		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
 	}
+
+	if (kvm_cpu_cap_has(X86_FEATURE_PERFCTR_VIRT))
+		svm_copy_pmcs(to_save, from_save);
 }
 
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
@@ -1300,6 +1326,9 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
+	if (nested_vmcb12_has_vpmc(vcpu))
+		svm_copy_pmcs(&vmcb12->save, &vmcb02->save);
+
 	vmcb12->control.event_inj	  = 0;
 	vmcb12->control.event_inj_err	  = 0;
 	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
@@ -1325,7 +1354,9 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
-	svm_pmu_handle_nested_transition(svm);
+
+	if (!nested_vmcb12_has_vpmc(vcpu))
+		svm_pmu_handle_nested_transition(svm);
 
 	svm->nested.vmcb12_gpa = 0;
 
@@ -1381,6 +1412,10 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 
 	svm_update_lbrv(vcpu);
 
+	if (!nested_vmcb12_has_vpmc(vcpu) &&
+	    kvm_vcpu_has_mediated_pmu_caps(vcpu, KVM_MEDIATED_PMU_CAP_HW_SWITCHED))
+		svm_copy_pmcs(&vmcb01->save, &vmcb02->save);
+
 	if (vnmi) {
 		if (vmcb02->control.int_ctl & V_NMI_BLOCKING_MASK)
 			vmcb01->control.int_ctl |= V_NMI_BLOCKING_MASK;
@@ -1545,7 +1580,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		 * into PMU state from arbitrary contexts (e.g. to avoid using
 		 * stale state).
 		 */
-		__svm_pmu_handle_nested_transition(svm, true);
+		if (!nested_vmcb12_has_vpmc(vcpu))
+			__svm_pmu_handle_nested_transition(svm, true);
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
@@ -2074,6 +2110,9 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	nested_vmcb02_prepare_control(svm);
 
+	if (!nested_vmcb12_has_vpmc(vcpu))
+		svm_pmu_handle_nested_transition(svm);
+
 	/*
 	 * Any previously restored state (e.g. KVM_SET_SREGS) would mark fields
 	 * dirty in vmcb01 instead of vmcb02, so mark all of vmcb02 dirty here.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 079b1a56e995..2023d38bba63 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5583,6 +5583,10 @@ static __init void svm_set_cpu_caps(void)
 		if (vnmi)
 			kvm_cpu_cap_set(X86_FEATURE_VNMI);
 
+		/* Nested AVIC is not supported, so VNMI must be enabled */
+		if (vpmc && vnmi)
+			kvm_cpu_cap_set(X86_FEATURE_PERFCTR_VIRT);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index eee26f6ce10c..3db6b73e8163 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -175,6 +175,12 @@ struct vmcb_save_area_cached {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
+	struct {
+		u64 perf_ctl;
+		u64 perf_ctr;
+	} pmc[6];
+	u64 perf_cntr_global_status;
+	u64 perf_cntr_global_control;
 };
 
 struct vmcb_ctrl_area_cached {
@@ -806,6 +812,18 @@ do {								\
 	(to)->last_excp_to	= (from)->last_excp_to;		\
 } while (0)
 
+#define svm_copy_pmcs(to, from)							\
+do {										\
+	int i;									\
+										\
+	(to)->perf_cntr_global_control = (from)->perf_cntr_global_control;	\
+	(to)->perf_cntr_global_status  = (from)->perf_cntr_global_status;	\
+	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++) {			\
+		(to)->pmc[i].perf_ctl = (from)->pmc[i].perf_ctl;		\
+		(to)->pmc[i].perf_ctr = (from)->pmc[i].perf_ctr;		\
+	}									\
+} while (0)
+
 void svm_vcpu_free_msrpm(void *msrpm);
 void svm_enable_lbrv(struct kvm_vcpu *vcpu);
 void svm_update_lbrv(struct kvm_vcpu *vcpu);
-- 
2.53.0

