Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA284FECD8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060821; cv=fail; b=GZjvno3DPEFgBwKSBHLCRwN+qXqXco2t/2J8muuqrNe5Koh1u6SO0y8fREs+i7xyGXdzNEKDSS+yRmSfNaGq2B422BVs8XXDQ2zoozj4rusWFJi9/kGrkBfSPOV4datEZ4NoZ4P79FnTVViANpFjUhnWXUIMPSihk7tWC43P4Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060821; c=relaxed/simple;
	bh=Ka5HOID2VT0chHOf6hiUNEPIcUYDMJZ+GU/Q/hR5zJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aD7ogeT9u40ByJby7vDt5T+9ofVdt6L12L0H8Ey2yBmSr71FsU/ZZda2uzJ66jrz/4+3ud9BWiX5AnDGT1DPO6eclEKXpLRQ7QNAX6F4M2hRsXAem4UWI4Xrmg1V8LjCAKOD5lOTfG2GpB/g9Pl0DTjldOuWvW8SVlVfhURxZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZw/76wV; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZw/76wV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSj4XZ/w2aYdIIPr5gThmiLpkBF1ESuyGsvasHwZng38qrZlFKrE8h7he6nJV7TuICMsv1uO1rP0XJWImDME7G6D8Cu3aneDNWJv3duD3RZmOTUPv8umueeUWZEDmHnHmA7C905fC74k2H/S1BOA3JfcVKxl3NQTArfUMR5qdF9NpEPggfyffb0syNt49l5Ts0PY6nivPES/5fWslEovPUGT1DO8oHQBV7eehHx+JsviKGIxnEXtlreIUwKO+tbiohKNBfu+l2IrEnCKyZmfS+zO89Lgp8o/ZpLc+tMYqcBYehyXQfNgFeqmkdlpFiCWKG2CN9VDHzw38usdqO+IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kCE6/g9A/lzhwskpvxXp81Rs8USbk2ibleS5trn/jU=;
 b=OjJP1J2OG8eCe0CLpmx9UhS9DQEfYEACuW9TNfpNnjlMzd6gudMw/HxaA45d7Vmr5yyPMYmSTsRaCv6vZoCDcKqY4JwQ7qYcVIpZVyAs7cRi9CvKRBwUAtb1fdVw5Sm+EeuGweogcEwTyX3PIxzn/ZOqhD2j+lQGtFwzrw0qsUmTLyiEIwPJHRkT1fb6++hx97iJ3Aw/ipPa5xQsabeum75+KLKYJHwYIfJL8VxSUz24qffK2BzOqRynjAvUe7GaY69idgkMrr/6MAjcGAQBLBYCY8R+iWJd8zqw69+PMnINYOxPfsGubJNKxqYhgl8Qs09Ncc+BEZ3QmPw5AnB2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kCE6/g9A/lzhwskpvxXp81Rs8USbk2ibleS5trn/jU=;
 b=qZw/76wVtAwgDFlplHvJDVl8mR9c3mkGbrAxd7C2KAsgKbrJsWkHu9OsLvo0NC7l+yJr8YJlnkKSLAaBllzlodTVUe2ZFpNxIl+LiFDndoV4ofVB8EyLwh4TG02Tvb/fKC1tzLeC8LP15PUgJ6LuiX6ecWWFRiEVBYYiK3Yucxg=
Received: from BN9PR03CA0457.namprd03.prod.outlook.com (2603:10b6:408:139::12)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:40:12 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::a0) by BN9PR03CA0457.outlook.office365.com
 (2603:10b6:408:139::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 10:40:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 10:40:12 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 05:40:03 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <mlevitsk@redhat.com>,
	<joao.m.martins@oracle.com>, <nikunj@amd.com>, <kai.huang@intel.com>,
	<yosry@kernel.org>
Subject: [RFC PATCH 5/5] KVM: selftests: nSVM: Add nested PML coverage to nested_dirty_log_test
Date: Thu, 15 Oct 2026 10:39:33 +0000
Message-ID: <20261015103933.2088307-6-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015103933.2088307-1-nikunj@amd.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 47071a8f-614e-441c-d48c-08df2aa8b110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|11063799006|261009223027099003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003|6133799003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	zopHF9gFydIBGF2/uggJfnsmdwJlqx1Gn6Sfst9infAi/6MO9TbsvrrrDDq45T/hRm4gzjGvbPj7JP9anh0bqzZN9BMk8YU8fC+m/c7gKq8ON17a+Btgso3jcpiHtcP/WfNJKELGV3iyw2OHB4fzwW3CHv4Xipweffabd6rNYFVUh01Xw9lkyq4NAwLDzsYgh1AokbiAT1Kb2DwUFyHYdF/TE/3MZQlC4XpuQ4fg7bdvhZYhQMhDED2kp/q3EpDFAo6US4MpS+zMiGgdTASSMDR0nL/OXmEr2pupWSIhAfwcAHzEU0w27ZemZreEJcg4kgZ32MyocU1c3w6wmujI99EzXyAeYJ7F0n+3kdqFvJvF/ic16nJqS6tvf63MtRi5Xe0q8l4myZhyRiQWV1+IX2FRhx7MpIN5BBS9HQBQd0er9/ShixxrC/cTIGSaEhwUJibw19LSEhsjVtDfRL6BIMBosMrSafFgYSQ2LMpOruGAZ6pDwsu1j+gWIf1wK21sB2PmTYNlXanDNj2F20AYVHDag+um8vh8a78VxJbiH+NQup5ToJpfk/jXCPB9iT29XoVkuYUksYcMPx0crxOo4Up9G1OEoaUUaEWcn0xflYwn94kcNTcALN+5HNlIZ40zkbwL/T6TdXJ16LnfWI07BJCpYwBrNS3oyu/bcDKhJyQKFKAIfNlS0bgWliRYsMpvCb6znXwg/o+tIX80L1AHeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(6133799003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kEmNIvzxb80Ha7YgV254JfoTFrDlJNpZgH/g2Yavi19PioR/d/OaST/3g3xuoQjgzjdqiGLB8OLFH1sZkAOhURcbIVEGMDm9Z4qZmUqnQYMZDdRNIzWGy2XBFsdAE3a9qFxdrxmn2GBq335mg1FO3i1ykVYahZqlfcVmnchXsdoNACBxyKejUDxLjKjEId1WZr6XO4qscKjK7gnSXL31PHTa69y3ByOLdXyHomEXCLKR0pwXa6EQIHdFls4c/Gf4Bgg3SzjyeJq0swdKi5PRsNvG8AZRRfBv/lK4IN55AoFb8LoMJTbES+XinaAazpNgKcMW1BXs95xXVRET6uESnW+Q4fAO8QiVhbIGgNSK66ss/t155m9dt8jLswUoJ7o3vsCmf1b3XlpdgAKbzAM4KgntH6jJo3JkWAi51WTO1qQx8T2lvDPLyK87Zjh6DJa0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:40:12.3058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47071a8f-614e-441c-d48c-08df2aa8b110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

Extend the nested PML test to cover nSVM.

Assisted-by: LLM
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/include/x86/svm.h |  6 ++-
 .../selftests/kvm/include/x86/svm_util.h      |  4 ++
 tools/testing/selftests/kvm/lib/x86/svm.c     |  3 ++
 .../selftests/kvm/x86/nested_dirty_log_test.c | 48 +++++++++++++++++--
 5 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..3f4eda041fd4 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -219,6 +219,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_RDPRU		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 4)
 #define	X86_FEATURE_AMD_IBPB		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 12)
 #define	X86_FEATURE_EFER_LMSLE_MBZ	KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 20)
+#define	X86_FEATURE_PML			KVM_X86_CPU_FEATURE(0x8000000A, 0, ECX, 4)
 #define	X86_FEATURE_NPT			KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 0)
 #define	X86_FEATURE_LBRV		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 1)
 #define	X86_FEATURE_NRIPS		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 3)
diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testing/selftests/kvm/include/x86/svm.h
index c8539166270e..00b410bb18be 100644
--- a/tools/testing/selftests/kvm/include/x86/svm.h
+++ b/tools/testing/selftests/kvm/include/x86/svm.h
@@ -115,7 +115,10 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u64 avic_physical_id;	/* Offset 0xf8 */
 	u8 reserved_7[8];
 	u64 vmsa_pa;		/* Used for an SEV-ES guest */
-	u8 reserved_8[720];
+	u8 reserved_8[184];	/* Offset 0x110 */
+	u64 pml_addr;		/* Offset 0x1c8 */
+	u16 pml_index;		/* Offset 0x1d0 */
+	u8 reserved_9[526];	/* Offset 0x1d2 */
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
@@ -174,6 +177,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define SVM_MISC_ENABLE_NP		BIT(0)
 #define SVM_MISC_ENABLE_SEV		BIT(1)
+#define SVM_MISC_ENABLE_PML		BIT(11)
 
 #define SVM_MISC2_ENABLE_V_LBR BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE BIT_ULL(1)
diff --git a/tools/testing/selftests/kvm/include/x86/svm_util.h b/tools/testing/selftests/kvm/include/x86/svm_util.h
index c201c30485e7..62d2ca9dda34 100644
--- a/tools/testing/selftests/kvm/include/x86/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86/svm_util.h
@@ -33,6 +33,10 @@ struct svm_test_data {
 
 	/* NPT */
 	u64 ncr3_gpa;
+
+	/* PML buffer */
+	void *pml; /* gva */
+	u64 pml_gpa;
 };
 
 static inline void vmmcall(void)
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index b05be50f075d..ef22f2686b3f 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -45,6 +45,9 @@ vcpu_alloc_svm(struct kvm_vm *vm, gva_t *p_svm_gva)
 
 	svm->stack = (void *)vm_alloc_stack(vm, 1);
 
+	svm->pml = (void *)vm_alloc_page(vm);
+	svm->pml_gpa = addr_gva2gpa(vm, (uintptr_t)svm->pml);
+
 	if (vm->stage2_mmu.pgd_created)
 		svm->ncr3_gpa = vm->stage2_mmu.pgd;
 
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
index b1008724f46d..cc49fa0c4293 100644
--- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
@@ -250,6 +250,45 @@ static void l1_pml_vmx_code(struct vmx_pages *vmx)
 	GUEST_DONE();
 }
 
+static void l1_pml_svm_code(struct svm_test_data *svm)
+{
+	struct vmcb_control_area *ctrl = &svm->vmcb->control;
+	int nr_pml_full = 0;
+
+	/* PML requires NPT. */
+	GUEST_ASSERT(svm->ncr3_gpa);
+
+	generic_svm_setup(svm, l2_pml_guest_code);
+
+	ctrl->pml_addr = svm->pml_gpa;
+	ctrl->pml_index = PML_LOG_NR_ENTRIES;
+	ctrl->misc_ctl |= SVM_MISC_ENABLE_PML;
+
+	run_guest(svm->vmcb, svm->vmcb_gpa);
+
+	for (;;) {
+		if (ctrl->exit_code == SVM_EXIT_VMMCALL)
+			break;
+
+		GUEST_ASSERT_EQ(ctrl->exit_code, SVM_EXIT_PML_FULL);
+		GUEST_ASSERT(++nr_pml_full < PML_FULL_MAX_EXITS);
+
+		ctrl->pml_index = PML_HEAD_INDEX;
+		run_guest(svm->vmcb, svm->vmcb_gpa);
+	}
+
+	GUEST_SYNC_ARGS(ctrl->pml_index, nr_pml_full, 0, 0, 0);
+	GUEST_DONE();
+}
+
+static void l1_pml_guest_code(void *data)
+{
+	if (this_cpu_has(X86_FEATURE_VMX))
+		l1_pml_vmx_code(data);
+	else
+		l1_pml_svm_code(data);
+}
+
 static void check_pml_buffer(struct kvm_vm *vm, u64 pml_gpa, u64 pml_index)
 {
 	u64 *pml_buf = addr_gpa2hva(vm, pml_gpa);
@@ -289,10 +328,13 @@ static void test_nested_pml(void)
 
 	pr_info("Nested TDP: enabled, PML\n");
 
-	vm = vm_create_with_one_vcpu(&vcpu, l1_pml_vmx_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_pml_guest_code);
 	vm_enable_tdp(vm);
 
-	pml_gpa = vcpu_alloc_vmx(vm, &nested_gva)->pml_gpa;
+	if (kvm_cpu_has(X86_FEATURE_VMX))
+		pml_gpa = vcpu_alloc_vmx(vm, &nested_gva)->pml_gpa;
+	else
+		pml_gpa = vcpu_alloc_svm(vm, &nested_gva)->pml_gpa;
 
 	vcpu_args_set(vcpu, 1, nested_gva);
 
@@ -428,7 +470,7 @@ int main(int argc, char *argv[])
 	if (kvm_cpu_has_tdp()) {
 		test_dirty_log(/*nested_tdp=*/true);
 
-		if (kvm_cpu_has_vmx_pml())
+		if (kvm_cpu_has_vmx_pml() || kvm_cpu_has(X86_FEATURE_PML))
 			test_nested_pml();
 	}
 
-- 
2.48.1

