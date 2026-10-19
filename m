Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444018;
	b=R1JPyZEpiWA9I7Na2LcRhbDFCjS5lloF9W1GyvUUPNo26mpirtss020sZEx8P0Jy/Lh9
	 6N7dbloXgCmswSEWuYdIgmGjAiKOLYDYXwIPepPwkgQXDBdws55Sm4CFoM4aqj/uOUzAJ
	 5pdbADNWPjx9ay1Tc9rWJsrXtS0qqV1YT3TqYQOnc4eqh1O9KkOEuCY16gVcaXa0WtKl7
	 IWEzHggLRoLYqprl5NPn2LBgn8OUaMpNydY+qoeFIwgpp3XEq7AYc9rC7ebXrlkt9kZgb
	 mrQORn6QNy2f1apuZm32NmUJsoTPmNWlgC/0VQxVD4AK0BOUF4cVlm46pnEQ4i/rS/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444018;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fhGLVKQan4A27R/CLkMAh+GRaAtIUHhHoUrSgc6sJy8=;
	b=ewEYTV0HtDGTTHL3XC3uy7ucoAaSDKk/xTBnRK3TjHzH7baWexKwohjt59DzbgqdjGAP
	 pKbT+KensYUvCn+eoDdkB8iRKc9YarJ2WlLEhryGmlIpIFbb3m7tcOU+qshxu5UTxZSX4
	 4UrvffM5W9c2jW/iAMaIahlQcXqBYFkHRUm0TfAlxl9oJj6nMlrKpkdlFVzbzK+sK0g1d
	 RsJdcf0gN8Hj75x2vKS8Y+ltmYlR6a1tiMesgb8mP9985hB7EBC5SbSDmpXry9wx1PXgS
	 wbh7wnhnWlbpFGtZFIfu7uzoBDSqAcI+PVlnH5oErqfxMA3hcxxQGbL1YmA9FJoNLzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eAdLntyd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.44
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A2606A31E
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 175A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eAdLntyd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anYdZnLK1aRzlBT6krhtK3yjHL9inBuuirsUYU0AaAUKg2Fg6DEnvTw1ZllsFkHI+8/TojgILi+R1K7UeEbCnIIfMGfQSsIH+oURS9NlPGVkMjLvVxMuYFEYwG69g4hQgftebCw8pZA46d7Be0D3HuvEDOoYwKth7ImwbUze3kR6TBTcF81VikEvn0QWXY2KqxGrS87sRtwId7oqR/P+ETh4ce2w1feZVXjO8p1FaMO04s+AwN/Tx8g4+Y4YEiZBLIcrC4t5LVCTesHjHBJ13s/tj2hElAjLWWPY+cKqdKg3mbqMLP2/lKf1Lq/u8QWNAYpI4OdOdDVda2GpLjuNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhGLVKQan4A27R/CLkMAh+GRaAtIUHhHoUrSgc6sJy8=;
 b=sGTL1Xstf0lQOUT2GB+cinLvONflQ06dgi8453+MnzSCdOnIu+1O+IqoCxwycIAWHjj/si6SuuIp4gwBvNtKYUEIuqTggj3MXdXI6h3YHl2mbo9V4x7vsX4Wbs8i54KBN3od6Ex0Aip+s1nUAvgnE7YXZruN5m709LcedGY8aO/jd1/yga23wDxhwl2fsmHndu3d/BPwGZQcc9PnFT5NrbE6lNo+lfdOXPR7t8jfeQyK72CePht/WFHwWT8rK60fpVsMkZoiIw3WF+HTSBMDfFgWPCfKaS7EeLQPbTq6gc9w6HBqoXicGE/D+QlQcSESb6VrVxuo0gWgHeT+egGOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhGLVKQan4A27R/CLkMAh+GRaAtIUHhHoUrSgc6sJy8=;
 b=eAdLntydDCaex1u1q7MneyCE15AvlfgdObatRkwhpFxXdSOgja+OsRI2crwqW+RgdPgSWUVQ84c6ka7NMZxUd98vkdiOgh+AFwvdCKkaLub5eYv3pMyvUBj8ldJRe/0FYONpm8O0Hsvknfx+QY/eXIi6KHsXrVavBoTjC2V4jSs=
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:06:55 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::5e) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:06:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:06:55 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:06:53 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 03/12] KVM: SVM: Emulate guest accesses to LBRv2 MSRs
Date: Mon, 19 Oct 2026 21:05:23 +0000
Message-ID: <20261019210532.378628-4-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9d0ab2-d908-4d8a-fa36-08df2e24e7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|260925021911599003|260925021311599003|260925022911599003|261009223027099003|10067099003|56012099006|6133799003|10063799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	FllLiuJH6BFnhp1J6bLOSoAVfpkEwlH9ez/7yV+AtkqlhSjZDIJi4sNhyJ4wNg2kDQCkUV9kMVSS7Ms146VdlJSNIXgOlEnl5et3oSdkf/y4/pUWzsDoiykkf1ViMYh4RMws/MZl32fOV//TA5191+gRxFPayfb5D9hWT7QzO/S02sc3oa0e/8yCgIHb5pBsr9VXk3H+TP1D0ENEr7GJFcjzTe3FLUrgGWKrZZO+zZnF6wN2gnIMjbq729RhWBtjCuhBWJ0RDwPZm83/uIM618n5jQYaxdQKPCAu0UWh2gWgmgeu9wZkQNzRiYJYM1BVzJU8iNummjJZzuDYFjCnskC+mOg5389xooSS9c0C6RRsjAudPmHFoQKK/aSuXiEHJrIsbgEqUBqo+Row/IFb5fvROYbr/9Migk6pg654NaOH/40jfucDVt6yhFp3Kz9z3TA34tv88EN+RzL2yoYZPhotHs9MIF7lTGB2Eo6WVrJ+4+Rgt2txXd4qojQAVje6bGx+4BugCr/mNMEOQmCPQwBUIKKZbqBWylnYw/Vpt7bE4gTdRIYLvdTyW5+sEUccoUu+J+EXblzE001+wl+MHwfUqvw+oQxN2rGR1f2gT5UCPJ/oDhXBnr8QOT77qBClblxWVYLvxYSddwqn1vnygVaq+hU+H/9A2f8BtIly9O4ehxIkWlod0VFkVAxIHHuCUtwAkA7i+w905NUcmnM/Fg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(260925021911599003)(260925021311599003)(260925022911599003)(261009223027099003)(10067099003)(56012099006)(6133799003)(10063799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/a71yHbFfALeqkplbWCMGnSnewvrn2Ega01xHovCgMzlMdtWT4zc+NBDpNXbuQ79siRVeFwEecAI1UgcgXNDI0hj9nOVxQ/oyWF48CQX8/9y6ev4et/Dy1qVzUcwIMmY2Lg8EgBgqg1u9pJxK9yGzq52QFxdsiDlmlOOqBKuNxztE7ahqq16AaM/o5kHGt2l//yTFMGtX9AELYsFL/qU6AVO2qhaQbrhhC018WEj4U0E/ugZ8iIJ7dwpye8FXVNQbFm/HApC3RxfmLiPY3kX2jbO8lC8N91MpLnYolr2RNgfn/aJ3cVkq9sZyymI1me43A/5hvFBKMMQI57Juq7xxjlh0IZLRDvkWt91wHprCOVPTaSHY7TRuM5I6Qb/Z1ZkTxcjemj+pm8zLj05mx5tu36lHZRrtwJr5otKxBuYzELDOz6Yc3fasaZ79zWwMZaJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:06:55.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9d0ab2-d908-4d8a-fa36-08df2e24e7e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

Back the LBRv2 MSRs with their VMCB save-area fields in
svm_{get,set}_msr(). This is required when guest accesses to these
MSRs are intercepted. This allows the guest to retain the values
of these MSRs on VMRUN/#VMEXIT cycle when vLBR is disabled.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Use KVM_BUG_ON() in svm_vmcb_lbrv2() for an out-of-range LBR stack
  index, and then use entry 0.
* Do not mark the VMCB dirty on writes to the LBRv2 MSRs since VMCB clean
  bit for LBR doesn't cover the LBRv2 state.

---
 arch/x86/include/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c     | 69 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h     |  3 ++
 3 files changed, 74 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index d76844224745..fb42c6806655 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -257,6 +257,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_TSC_RATIO_MAX	0x000000ffffffffffULL
 #define SVM_TSC_RATIO_DEFAULT	0x0100000000ULL
 
+#define SVM_LBR_V2_STACK_SIZE 16
+
 
 /* AVIC */
 #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK	(0xFFULL)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..428c95d7ef21 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -752,6 +752,12 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm->lbr_msrs_intercepted = intercept;
 }
 
+static bool svm_lbrv2_supported(struct kvm_vcpu *vcpu)
+{
+	return guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) &&
+	       kvm_vcpu_has_mediated_pmu(vcpu);
+}
+
 void svm_vcpu_free_msrpm(void *msrpm)
 {
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
@@ -2855,6 +2861,19 @@ static u64 *svm_vmcb_lbr(struct vcpu_svm *svm, u32 msr)
 	return &svm->vmcb->save.br_from;
 }
 
+static u64 *svm_vmcb_lbrv2(struct vcpu_svm *svm, u32 msr)
+{
+	u32 offset = msr - MSR_AMD_SAMP_BR_FROM;
+	u32 idx = offset >> 1;
+
+	if (KVM_BUG_ON(idx >= SVM_LBR_V2_STACK_SIZE, svm->vcpu.kvm))
+		idx = 0;
+
+	if (offset & 1)
+		return &svm->vmcb->save.lbr[idx].lbr_stack_to;
+	return &svm->vmcb->save.lbr[idx].lbr_stack_from;
+}
+
 static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 				      struct msr_data *msr_info)
 {
@@ -2950,6 +2969,21 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_LASTINTTOIP:
 		msr_info->data = lbrv ? *svm_vmcb_lbr(svm, msr_info->index) : 0;
 		break;
+	case MSR_AMD_DBG_EXTN_CFG:
+		if (!svm_lbrv2_supported(vcpu))
+			return KVM_MSR_RET_UNSUPPORTED;
+		msr_info->data = svm->vmcb->save.dbg_extn_cfg;
+		break;
+	case MSR_AMD64_LBR_SELECT:
+		if (!svm_lbrv2_supported(vcpu))
+			return KVM_MSR_RET_UNSUPPORTED;
+		msr_info->data = svm->vmcb->save.lbr_select;
+		break;
+	case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31:
+		if (!svm_lbrv2_supported(vcpu))
+			return KVM_MSR_RET_UNSUPPORTED;
+		msr_info->data = *svm_vmcb_lbrv2(svm, msr_info->index);
+		break;
 	case MSR_VM_HSAVE_PA:
 		msr_info->data = svm->nested.hsave_msr;
 		break;
@@ -3249,6 +3283,41 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		*svm_vmcb_lbr(svm, ecx) = data;
 		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		break;
+	/*
+	 * No VMCB clean bit covers the LBRv2 state, i.e. the CPU never skips
+	 * loading it on VMRUN, so there's no need to mark the VMCB dirty.
+	 */
+	case MSR_AMD_DBG_EXTN_CFG:
+		if (!svm_lbrv2_supported(vcpu))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (data & DBG_EXTN_CFG_RESERVED_BITS)
+			return 1;
+
+		if (svm->vmcb->save.dbg_extn_cfg == data)
+			break;
+
+		svm->vmcb->save.dbg_extn_cfg = data;
+		svm_update_lbrv(vcpu);
+		break;
+	case MSR_AMD64_LBR_SELECT:
+		if (!svm_lbrv2_supported(vcpu))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (data & LBR_SELECT_RESERVED_BITS)
+			return 1;
+
+		if (svm->vmcb->save.lbr_select == data)
+			break;
+
+		svm->vmcb->save.lbr_select = data;
+		break;
+	case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31:
+		if (!svm_lbrv2_supported(vcpu))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		*svm_vmcb_lbrv2(svm, ecx) = data;
+		break;
 	case MSR_VM_HSAVE_PA:
 		/*
 		 * Old kernels did not validate the value written to
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6d0242966dc8..cde6bef61dcd 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -797,6 +797,9 @@ static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
 	return debugctl;
 }
 
+#define DBG_EXTN_CFG_RESERVED_BITS (~DBG_EXTN_CFG_LBRV2EN)
+#define LBR_SELECT_RESERVED_BITS (~GENMASK_ULL(8, 0))
+
 /* svm.c */
 extern bool dump_invalid_vmcb;
 
-- 
2.43.0

