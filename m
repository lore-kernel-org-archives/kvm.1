Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52248A8CD
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060818; cv=fail; b=kCDkv5sPCQWnzNtq5sG5TrNELyf44V6lAz3988KoCcntLosGUzYaOEcbIGrdYrsw9KyOZqHT5jKRAjSPeEum7NvU7lRSBDHIVPX6zsR3AMaoFQVP5fQ4T92WhrOH1Ylp0SquxO9Y8N2uidUXDCgoOHdUeXHguhiTRYPCfeW0V54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060818; c=relaxed/simple;
	bh=l+LUZSAWjDfd/CPqNkvYGsWD24HFK/jfSbWlfm+Zh6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS6r01c8SKIHwtkbLM/4ITCw7w8t3ln1UUb4FvR7R39MS93Sqti8EOY4LstO7JZ528Tu1qL/rolsrsxRc2is5dkYhRwGGLWd1jMf+2ZN1ZSekUnlP3TCvbMhlpBGGjVD7FxgYIKIlNHFuTTKd4dHkGheH+dlhz65qsP6FcA2ym4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rcvWAtri; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rcvWAtri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UErMUJXPs+M6wjZVjE31O4OCEqTT4cNggdQGG4MmSxPffScmjm9rj+CMYcbdtmdC1lxQiatZKyS260cuBiRjIHypP22H3J407FFCHEf9KpRYZnCZ5RKDjdgqqpKCZI8OHM/fiGnF5Sui2b+txD0F5c33s01cxbzEBKgpMtMf1yAfFj4RPjDFpTFGI8SUl7uu/qwNb5MCCPmjTY/T3qyE4Q2d4Cx8aGlxO329taf/jIqti07m5QxJzZX4WuqTn39O0MWROQYvJxyRO8/BaOpHz1rRpCu5ugVHuLOrIW09UbkqaY4TuIu17wQX4p6VTRQzVD4KuM8WP0S0DQJl9OSigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t1sQjoXXwV2eEglOCcmq+LYloQeu4P5iJnPvSjZgtU=;
 b=no5BCuIXa8OD6lFwPwv632dC+NrXmmdbfrzJUqWF45/bVJ6XtkmULY+4cu0hLRpXYI0hXtSoS6HV4MN5bmjHwgP2WCWS1eYFat2FjXWPvJAOWCii5dzS/iCX752lcbY/v2UD7Pdh39WaG0KcEoUHBXRnbkRohZQH5/fk1gxQ9sOGgKFmFrBicqwrYaklUhWTI2bL9pXmZnR2ZvQqwg0xz9YY5eoc1TbgMEVwA1OMbbFlxLuHMnVkJlW+Mcohz6vP1Fwnrxo55qX8RZQZSO51yKyX3wzafyMssDzCHDV8OJHXOF+l2D8YYR2k1UsxHKKYX5Wqiaf77WWnE7oRJgGkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t1sQjoXXwV2eEglOCcmq+LYloQeu4P5iJnPvSjZgtU=;
 b=rcvWAtriIyzNAhj45ORBfmT0p+gZN4Murlbdzgb0GGh1vQaktdWEL9XoPy/kjas+VrvAT1L/i3nctFEJGIEDxC8bXr7+vDFNFqpeabyOdCjDXOf7wmO1hqcwVDwF49GO3yqjRkpRgWih/ZqWQj+Jn17TJ2WmhiCKHl1m4nmA1OI=
Received: from BN9PR03CA0483.namprd03.prod.outlook.com (2603:10b6:408:130::8)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:40:10 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::a6) by BN9PR03CA0483.outlook.office365.com
 (2603:10b6:408:130::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 10:40:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 10:40:09 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 05:40:00 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <mlevitsk@redhat.com>,
	<joao.m.martins@oracle.com>, <nikunj@amd.com>, <kai.huang@intel.com>,
	<yosry@kernel.org>
Subject: [RFC PATCH 4/5] KVM: selftests: nVMX: Add nested PML coverage to nested_dirty_log_test
Date: Thu, 15 Oct 2026 10:39:32 +0000
Message-ID: <20261015103933.2088307-5-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: a271e224-229a-4591-f4aa-08df2aa8afa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	e919r/Icfg2+EsoeSMXXHadD9Pf6Ck5SPJ2w3AY+cFuobleLh4hlLLk34/MdGRW5ikS30hbPAjKSR/8N/bK/GF0G1gIzujrxdfMHuXzz1uRNe9S7FjHCzsAtM0WLKmDrNRocmwVvfopwYMe8oMvK/7DNfhuWzUkFpVlewT2t4FqG4lYqEPeKIzCJ7TCl49DlDRVqUV/T3AvzVtf7ZBPqinsuEo2sZK630RpoNCG5OofAEffN8nWFzz3LXyw9FAUj73/irk1cg6TwwRVrfRYulYms1saLhtfsVLBu08RYGQJgDCqRKn7hatZenodTcXE/cqphdKa317LyaKN3g6HjpRM3UuaHOBU5qOx7+srdOj45caAPz6lKgqMh9xzS4WeXLYcb6xJprGQZPa8dhovA+REt27985YDyeYTgbLWdGs3R3vFWWD7oj6jwBmOEAKCNfQb2+b6HR5jTxUyhgro0fOBCoFiUdVuruivOkOI2TvLc08UPMDr5ygYXnHN9MwIiS84ZXwz31xR+RGEHNpHeYPAK75PUm88E2dULFZpPTwQM6h6R8jdA6UqcVfYUR7wlD0Gwd1g91WKQ0L0xW8ptVuYM9y2pUtTsjSrQGUnZA6CP2DMNujc9InL8Xv071DD2ENjNwvoEaZHyxfZ5WKlFfzeeUmLG995Y2mK4hTAv0HVrso8O+K7gVvUJI+dz/koB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZuIYbrxxFCzQkXe0HTnHd8fFl8zrNHWebr7y2xpxYBSG2cULP2WF5IUPbxUrH9e+xP5uAtHSaao+whBGj+7Kppq3yFizImIfvGPnGI7d3V8npPoLbAksAWPdbAHJ6W4JadBGFUg52LV3tOvtBucSv7JKH7LOJxqvmYffMg0oU1eEafX0SDXXAjv9K60Cy/AmjVm8L46Wh6UE2s8t+Rgk6oYpEk+e8oYlQBqI1tVELucrQrAPNhsQgfT2PS/Rr7aG6mHaKS4WRX4q5y4K9wmD10cBzqfq3JUmQtFGmWTw21ky2B1Y9bzoX5+pfmNYJ86DxRpfIomGPElaGfCBc2GcF2biKBds7moLzSefg4eA4pjjqspwdX5tXeOGv7PcnXIJJ396t7RQZKfu94k+jgW1UCBcNYbEUoAgo1EZx2AAI0CXcxlC47fa4Q92/VsctZwc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:40:09.9225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a271e224-229a-4591-f4aa-08df2aa8afa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

Add coverage for nested PML, i.e. for KVM logging L2's dirty GPAs into L1's
PML buffer on L1's behalf.  Verify each page is logged exactly once, no
matter how many times L2 writes to it, and that L1 takes a PML_FULL exit
when the buffer fills, can drain it, and can resume L2 without losing
entries.

Seed PML_INDEX past the end of the buffer so that L2's first write takes a
PML_FULL exit before anything is logged.  This keeps the number of exits
deterministic, and leaves the buffer contents identical to a run that never
fills, so the logging checks apply unchanged.

Assisted-by: LLM
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h |   5 +
 tools/testing/selftests/kvm/lib/x86/vmx.c     |  18 +++
 .../selftests/kvm/x86/nested_dirty_log_test.c | 149 +++++++++++++++++-
 3 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 8fd97434eee5..b52b2770ba0a 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -471,6 +471,10 @@ struct vmx_pages {
 	void *stack;
 
 	u64 eptp_gpa;
+
+	/* PML buffer */
+	void *pml;
+	u64 pml_gpa;
 };
 
 union vmx_basic {
@@ -515,6 +519,7 @@ static inline bool kvm_cpu_has_vmx_virtualize_apic_accesses(void)
 	return kvm_cpu_has_secondary_exec_control(SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES);
 }
 
+bool kvm_cpu_has_vmx_pml(void);
 void vm_enable_ept(struct kvm_vm *vm);
 void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 5a06746ebea4..8ccdae85d761 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -118,6 +118,9 @@ vcpu_alloc_vmx(struct kvm_vm *vm, gva_t *p_vmx_gva)
 
 	vmx->stack = (void *)vm_alloc_stack(vm, 1);
 
+	vmx->pml = (void *)vm_alloc_page(vm);
+	vmx->pml_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->pml);
+
 	if (vm->stage2_mmu.pgd_created)
 		vmx->eptp_gpa = vm->stage2_mmu.pgd;
 
@@ -437,6 +440,21 @@ bool kvm_cpu_has_secondary_exec_control(u32 ctrl)
 	return ctrl_msr & ctrl;
 }
 
+bool kvm_cpu_has_vmx_pml(void)
+{
+	u64 ctrl;
+
+	if (!kvm_cpu_has(X86_FEATURE_VMX))
+		return false;
+
+	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_TRUE_PROCBASED_CTLS) >> 32;
+	if (!(ctrl & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS))
+		return false;
+
+	ctrl = kvm_get_feature_msr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32;
+	return ctrl & SECONDARY_EXEC_ENABLE_PML;
+}
+
 void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm)
 {
 	vmx->apic_access = (void *)vm_alloc_page(vm);
diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
index 7e5f9ae1cb00..b1008724f46d 100644
--- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
@@ -192,6 +192,149 @@ static void test_handle_ucall_sync(struct kvm_vm *vm, u64 arg,
 	}
 }
 
+#define PML_LOG_NR_ENTRIES	512
+#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES - 1)
+
+#define PML_FULL_MAX_EXITS	64
+
+static void l2_pml_guest_code(void)
+{
+	gva_t page0 = TEST_ALIAS_GPA(0);
+	gva_t page1 = TEST_ALIAS_GPA(1);
+
+	/*
+	 * PML logs a GPA when the stage-2 Dirty bit goes from clear to set, so
+	 * the duplicate write to page0 must not produce a second entry.
+	 */
+	WRITE_ONCE(*(u64 *)page0, 1);
+	WRITE_ONCE(*(u64 *)page0, 1);
+	WRITE_ONCE(*(u64 *)page1, 1);
+
+	vmcall();
+}
+
+static void l1_pml_vmx_code(struct vmx_pages *vmx)
+{
+	int nr_pml_full = 0;
+
+	GUEST_ASSERT(vmx->vmcs_gpa);
+	prepare_for_vmx_operation(vmx);
+	load_vmcs(vmx);
+
+	/* PML requires EPT. */
+	GUEST_ASSERT(vmx->eptp_gpa);
+
+	prepare_vmcs(vmx, l2_pml_guest_code);
+
+	vmwrite(PML_ADDRESS, vmx->pml_gpa);
+	vmwrite(GUEST_PML_INDEX, PML_LOG_NR_ENTRIES);
+	vmwrite(SECONDARY_VM_EXEC_CONTROL,
+		vmread(SECONDARY_VM_EXEC_CONTROL) | SECONDARY_EXEC_ENABLE_PML);
+
+	vmlaunch();
+
+	for (;;) {
+		u64 reason = vmread(VM_EXIT_REASON);
+
+		if (reason == EXIT_REASON_VMCALL)
+			break;
+
+		GUEST_ASSERT_EQ(reason, EXIT_REASON_PML_FULL);
+		GUEST_ASSERT(++nr_pml_full < PML_FULL_MAX_EXITS);
+
+		vmwrite(GUEST_PML_INDEX, PML_HEAD_INDEX);
+		vmresume();
+	}
+
+	GUEST_SYNC_ARGS(vmread(GUEST_PML_INDEX), nr_pml_full, 0, 0, 0);
+	GUEST_DONE();
+}
+
+static void check_pml_buffer(struct kvm_vm *vm, u64 pml_gpa, u64 pml_index)
+{
+	u64 *pml_buf = addr_gpa2hva(vm, pml_gpa);
+	int nr_page0 = 0, nr_page1 = 0;
+	int i;
+
+	/*
+	 * L2 also dirties its stack, page tables, etc., so the buffer holds
+	 * more than just the test pages.  Search it rather than assuming the
+	 * test pages land at a fixed offset.  PML fills the buffer backwards,
+	 * starting at PML_HEAD_INDEX.
+	 */
+	TEST_ASSERT(pml_index < PML_HEAD_INDEX,
+		    "PML buffer is empty, PML_INDEX = %lu", pml_index);
+
+	for (i = PML_HEAD_INDEX; i > pml_index; i--) {
+		if (pml_buf[i] == TEST_ALIAS_GPA(0))
+			nr_page0++;
+		else if (pml_buf[i] == TEST_ALIAS_GPA(1))
+			nr_page1++;
+	}
+
+	TEST_ASSERT(nr_page0 == 1, "GPA 0x%lx logged %d times, expected 1",
+		    (u64)TEST_ALIAS_GPA(0), nr_page0);
+	TEST_ASSERT(nr_page1 == 1, "GPA 0x%lx logged %d times, expected 1",
+		    (u64)TEST_ALIAS_GPA(1), nr_page1);
+}
+
+static void test_nested_pml(void)
+{
+	u64 pml_gpa, pml_index = PML_HEAD_INDEX, nr_pml_full = 0;
+	struct kvm_vcpu *vcpu;
+	gva_t nested_gva = 0;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	bool done = false;
+
+	pr_info("Nested TDP: enabled, PML\n");
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_pml_vmx_code);
+	vm_enable_tdp(vm);
+
+	pml_gpa = vcpu_alloc_vmx(vm, &nested_gva)->pml_gpa;
+
+	vcpu_args_set(vcpu, 1, nested_gva);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, TEST_MEM_BASE,
+				    TEST_MEM_SLOT_INDEX, TEST_MEM_PAGES,
+				    KVM_MEM_LOG_DIRTY_PAGES);
+
+	virt_map(vm, TEST_MEM_BASE, TEST_MEM_BASE, TEST_MEM_PAGES);
+
+	/* Leave the stage-2 Dirty bits clear, or L2's writes won't be logged. */
+	tdp_identity_map_default_memslots(vm);
+	tdp_map(vm, TEST_ALIAS_GPA(0), TEST_GPA(0), PAGE_SIZE);
+	tdp_map(vm, TEST_ALIAS_GPA(1), TEST_GPA(1), PAGE_SIZE);
+
+	while (!done) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			pml_index = uc.args[1];
+			nr_pml_full = uc.args[2];
+			break;
+		case UCALL_DONE:
+			done = true;
+			break;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+	TEST_ASSERT(nr_pml_full == 1, "Expected 1 PML_FULL exit, got %lu",
+		    nr_pml_full);
+
+	check_pml_buffer(vm, pml_gpa, pml_index);
+
+	kvm_vm_free(vm);
+}
+
 static void test_dirty_log(bool nested_tdp)
 {
 	gva_t nested_gva = 0;
@@ -282,8 +425,12 @@ int main(int argc, char *argv[])
 
 	test_dirty_log(/*nested_tdp=*/false);
 
-	if (kvm_cpu_has_tdp())
+	if (kvm_cpu_has_tdp()) {
 		test_dirty_log(/*nested_tdp=*/true);
 
+		if (kvm_cpu_has_vmx_pml())
+			test_nested_pml();
+	}
+
 	return 0;
 }
-- 
2.48.1

