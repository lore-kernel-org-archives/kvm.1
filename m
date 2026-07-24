Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E69456DFF
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922788; cv=fail; b=LBL8hMU+kYt7O3JeKMowWBfldPmbj3sUv0RFR4eHkeJsol7VVOnTdA3cuhDT0j0S3s5cHMqlKAtcS3ZKWqwYqLVM5oYp5w0SVpbQK7Euzv6rx82jdGuaPjPTkMfsA8szorERq9ExYd/bHZLL0jj2SjJ6FLOpOxJcdrWg/tIZxHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922788; c=relaxed/simple;
	bh=HK1Dj4EmvhAcbLuuRENAIP142iC02aZApyckYT00/PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxgyAi/+UZRoqvnJHoK4uGGj+Ib4lC8DU28sqlMkjP+nav5FIIZxfpWQoTnZmTAKH6igqK/xf8ErE1KjBIOzWTVRFh+XAbxl3auTOjfMiQjae6ofjinAfOWVkZL4ym4UUa33r4M1zWaRsa9kkKkjrx94VaW4UqO0/swpA4OqIw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MmSF8wkR; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmSF8wkR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odoVrZ3QoEy7NFRuIkz85a3/mwUBrTsyueLgI+enqLeVit/y6R3HIFmG4Thk+QoszbLe9kgslyyy6sHzsVsNRKFHSpGGT2kL+6EJV7efn8VPK9T3cF+XDKBq0DsGqjHZ2FDWXb3ImUZ3eCx7mL4sA81kSMtonAUkVzcLlCTQxaNIaHSAgWvrOGwxLcNdl0DQ43sVO93Lvh6nFYXPFLwu88nu7GBjjy98e9zCoOZk6OthmNCwNSU2rRrIIo5eENmYtPqNgk5KsS0xomh8jzw1RD+2tJljb4CstFP5UIEU8L4oAOSoLONGTWMurPqllst6k3m/9K1L9vR+D6SKN7Tvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZipuqsZqwj1O7/f8uFqKf+WIZDuNsOo+M205e7HQhE=;
 b=DZ/QO7faf1TRORSlWw84MY/o4ZuJrnqLoQ7Bc9oJUyrRQLysb+RWLA3p8WyDkXiAKdocLcgA4QEzucKqNonDX5CYHp814wdn1Dx/Bd6d//dYKtcSlSUy5Nr9QLBnLysFK1nFqE+lg8uRPHnnfAXapvKVVuYj2Fx4CJ3vfU04W1ZRvDvXTYw6oNOLYAA3dFkoA/z+LGFEKBwIZXG4sYs1cw99gK0ajdg24SnaeWQ3UufguZw/qt2sKEoof8nsHyZckIC0vCYP8DkB1Q5UTHCQoUZdRlV+2npq1iUzfIe77SNQvoJu7D0JNl9+KC+I0hJMDpLI2OzIPbkwmjhgpNq5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZipuqsZqwj1O7/f8uFqKf+WIZDuNsOo+M205e7HQhE=;
 b=MmSF8wkRyqcIkH0176XEHkWk/LU6Fq8QZ9yjMIctmmheVW0SZeCHeq4ot3yBj3fqiFPPB8pARU5wVd8B9JA5DQJv7hTNKEuBk7O6heSZ2kyhUUmMuaruanjYnYmdu5aFZglLeuyscS0OHyBArpJIS52PN82zmLIuIGdLIavawig=
Received: from SJ0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:a03:3a0::28)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:53:01 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::31) by SJ0PR03CA0263.outlook.office365.com
 (2603:10b6:a03:3a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 19:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:53:00 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:52:56 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 3/7] KVM: SVM: Emulate guest accesses to LBR v2 MSRs
Date: Fri, 24 Jul 2026 19:50:36 +0000
Message-ID: <20260724195040.630468-4-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724195040.630468-1-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d807be2-2fae-416d-b097-08dee9bd2ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10063799003|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5vzCzCIukMuU1WeutPfoUL+zZ3BtcQXEhxLmJccmI5T7qBFFRQdSqzOVUrJ2vQ36hM99cH4ZLtWSoGH1cEK89ftZVncx4TheS5gYkYUK+qOyorg+aIbgsBLIeNsbRR1HMBWxNK42P8L7HCqmFgBXYB3dkwgsaI2K3EHO0DZDue5/qzfGpjSneCBORB2QQyGV41IfjdocgWDKMMGmXC+XxcLaoRSlOCm23Xfa1akX50T7hTA/H7j3Q75OBBoYbfE+Q5ryaOwxZ+Ep6FDBXpS5NTbBj8RZtM4Qs0iEnDsCQdgwcxJ7hkhx7iz3xs2hbWNCphOYEaBwTcoC0XqNZCfoKV+xxHl2pEge5zo28oS/sbVjt3Ing1cWB+hljg8aTFZiRmTzBEZ2V6MzCsETBjKkZR3ls1c39gpc71Nj5d1FQTWbC6e9INKkgn8cEe4jbRx48PDz1wWHN/s3RzhHteng5LWJlzB68wRRTHzq/8F8Ow4ZJ8KcEJ76Ek9lzmRrHsNxenwBdVqrIxTpKKGZIfF50PTi4MhWFewOk7JLjjm8KTUi6bIbopSVklTliFf2J2ChNB97o5tAYfBj9xRcLrODDP+1QSH+ZQ5yiiGqwNClKKRtHsweAYNfeVjDBHaD6h/8ZY/pdY38fbqsQRzpju6ZU31bzrMEPOXAr87kS2dHyj9PXZ/gt2SIwm50XvS7aVMKE1iFZe3LK6beSK2QpktiKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10063799003)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XKN/3VDHACNBynCBKQBH+OO7wLDph7ZhrnXUw3Gp/E+2u+bExeVcnS1g6D2VKt1ZU0VosMXKwOltfAqfSI8GACfPncjLMT3F2ENseG80B0BeXqoKlXKbF/wMBJPniT6y7n9HvlOJxXpETJhONJPlvH7Hc0OKDQ+xbIdQKFgUSUKJ4h5t2VSvs+xU1BbauFtZidhnsj1J7zr4uk/0xYcAwXm3TGgg7M7eTjKN5KdTjHUSexP1ipttJS72Yflj7yHHrhXAWLHM6rwALqZV+mMZprxX6X34zk5KDbdK/dZdHK5KcLGBP1FrDW9Yzc+Kt8bAfTGG+YbFGEMPUr6JrlSIb5vW5Jehym3MKfW38nZkbv6zrl4qnt8x9By14xG5gmbAg0v29sXnEOfVGq55bj+vGUOzRobhyMw6IigLt7K3oQRUE6457s3J7QiSKAYhTqLv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:53:00.8462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d807be2-2fae-416d-b097-08dee9bd2ad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298

Back the LBR v2 MSRs with their VMCB save-area fields in
svm_{get,set}_msr(). This is required when guest accesses to these
MSRs are intercepted. This allows the guest to retain the values
of these MSRs on VMRUN/#VMEXIT cycle when vLBR is disabled.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/include/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c     | 68 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h     |  2 ++
 3 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index fbcf6c4dbb92..f3bc97bc6aca 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -253,6 +253,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_TSC_RATIO_MAX	0x000000ffffffffffULL
 #define SVM_TSC_RATIO_DEFAULT	0x0100000000ULL
 
+#define SVM_LBR_V2_STACK_SIZE 16
+
 
 /* AVIC */
 #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK	(0xFFULL)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..13ac62604ca0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -744,6 +744,12 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
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
@@ -2787,6 +2793,19 @@ static u64 *svm_vmcb_lbr(struct vcpu_svm *svm, u32 msr)
 	return &svm->vmcb->save.br_from;
 }
 
+static u64 *svm_vmcb_lbrv2(struct vcpu_svm *svm, u32 msr)
+{
+	u32 offset = msr - MSR_AMD_SAMP_BR_FROM;
+	u32 idx = offset >> 1;
+
+	if (WARN_ON_ONCE(idx >= SVM_LBR_V2_STACK_SIZE))
+		return &svm->vmcb->save.lbr[0].lbr_stack_from;
+
+	if (offset & 1)
+		return &svm->vmcb->save.lbr[idx].lbr_stack_to;
+	return &svm->vmcb->save.lbr[idx].lbr_stack_from;
+}
+
 static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 				      struct msr_data *msr_info)
 {
@@ -2882,6 +2901,21 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -3181,6 +3215,40 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		*svm_vmcb_lbr(svm, ecx) = data;
 		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		break;
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
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
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
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
+	case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31:
+		if (!svm_lbrv2_supported(vcpu))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		*svm_vmcb_lbrv2(svm, ecx) = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
 	case MSR_VM_HSAVE_PA:
 		/*
 		 * Old kernels did not validate the value written to
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..f62bf19024cc 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -784,6 +784,8 @@ BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
 #define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
+#define DBG_EXTN_CFG_RESERVED_BITS (~DBG_EXTN_CFG_LBRV2EN)
+#define LBR_SELECT_RESERVED_BITS (~GENMASK_ULL(8, 0))
 
 /* svm.c */
 extern bool dump_invalid_vmcb;
-- 
2.43.0

