Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EE36C5AA
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543612; cv=fail; b=lWaOQkFXx/dtn+4qOcdYAPuXILflu+Rn68t9JjY1TKW7m7hIz0DyIbkLA5KBIDm9b7Rng11Ngl6TLMQLPZZPLB4+ldOARJ3fIOpBJqX3ZSe5I/rJEGotqKYqD7r2Za5US+CY8LHEPDS/eCrGYPaK8LVhVtXY8SZL7Z692Th+pA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543612; c=relaxed/simple;
	bh=P1EV9R/R5+EjMV2sFUIuW5hteSDBO2YlReOrLcmGAx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgzlcmONG7xfWdab8Njl8YBshyTpS8arn2gZSiBvEbfP7+7M8gkjk3akcg0ROT6IlZY/PEPbMF4ogIJjW2ks4qCubfHhnqgbIEZALrwprBM1uYr7ubwBvzO+a+ZttRnHzZ6FT3WiYX8hXkp8wMIHDiQWanAe75x8TuyEi+vuKjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jaxBzcpm; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jaxBzcpm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXkpoRIKfsfuFP90C13cX589evPEi/PvWlHujBu+V6bWpIHgKJmbtecB+AgGBsT5/B/demsMYPV6YCJ98utF8r3ENG+sGoev1YDlPqNbaN2FsRZozDdbHgrlJWS9keFRKTnrJsGHAX+sAYoVtLOt43wVWkqrKDwKdF7TiyAE/7Y8MFrl4qm+7SOEHIjoLKAkKt6OllSt0nrDUdoSN/mZ1ngmgSIsesxe9NxO15/Vb5SNoE/vpQkF96TU1nAQetE+DCEpc2e3A/0JstYOFhzr/A98HbCncgLIbirPHl/5QWV7881y1b0fMwIiV3imW0oKsfoOLhwZGjRauGfNN0TZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKMTCRifSIKUcZV3MsXGsOd4yX+qqf3QxBABJHzNf7s=;
 b=P/I5buu1Spwmaf6XtTxvlY8cUBLoov5H5y88AfBmW4RnIyp9f+vYl3Q75tLdjHjcgKO4H5bKo72hL30bllsMy3T7HSyF+E6BLqsfZzWKhoPA6k6Dj3rOkQQr6WFYDXrs9/s0Tl277J092VP5e5sXefW7m3FYqn9kH95cS7vrRYbfXy1N5ymjOR0S5aPYo5lTXzLUguhRiBiFHY9AryS4EAOiXigu+fdjwCiO0MgNQ2N5GwWmGedNNgepSvjGNLRwAj8Mdo4RNvJ8BVRs5sZIaaBObxkCN3pYhP4xXnXieZh68/onAXm0BMjnEy3YwYmGrtR3yhT3GMghLHs5xePzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKMTCRifSIKUcZV3MsXGsOd4yX+qqf3QxBABJHzNf7s=;
 b=jaxBzcpmhFFGG0X4I7aP1CfWqthfpbfH1fNwXJHs5sQtx2fNeJxbaXzZfIXZBson8sGn46RwDM6RD6vwb7hn9GlDO2gFFIYDEt+fuMUUhWtskgWMly3qyLWrPs9ZmKLnC+DxP0siVO3402Z4OTSvTav3dbjj+CALbOMXh16DdBE=
Received: from SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 06:33:23 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::2a) by SJ0PR03CA0011.outlook.office365.com
 (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:23 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:20 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>
Subject: [PATCH v6 2/7] KVM: x86: Move PML page to common vcpu arch structure
Date: Tue, 7 Apr 2026 06:32:40 +0000
Message-ID: <20260407063245.2755579-3-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260407063245.2755579-1-nikunj@amd.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 52780aa0-e121-424c-1bd9-08de946f91a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u8QAv5codxyrGRQdTg6YBDpOH5VkUNtG25tC6RtrQR7qjrDTCO62WHUra9qmdXsEyIbrITguuwZkq140m9WGtf/ujsNj54lPeb+AMlcvNgytbwqmiz9XXwgndymploxybW0nshqWWBuZ0OIXsA5cfUK1LM6G5AKE5TcN2HYsb1JVZpWz9ims+3KyUHd3gN3HKitUfQhquTdiibWTzC1R2QRzAx4BDtIO0JVI5qtDcvm77RSR5gaecXVFHTeh5hw1cxgMfF+xd6Nb+Rc0QLJPKjFghvUFx77ibNWMJtDdC1DtR0PXVXWqN4AHMy0f+yt4iKS3NTZ+f4AwOoaZFGx1RICgqC6EyWmX7lX6hCKwsnHq4ykf+gOBrf0VuaeewdOaJ1C/3lOWzy5k8A/uPgCfH5h5320rOFtfG2I4FHzqxF/W6VorGBKczMZg88pcFy4POSs3HCLlJoa93H/MrEWjl0ilOFJbkuL7qTY98G3SAGiVtQWWpZwVH9sWyALpl5m+KfBQfS4/b0HWosC//n3HMgWUP1uIPDRxyt7twReZ7yLGkmCRfcbIrh9/0jqwoUDlaV0R3HV/aRvz7ZRW4FUbzAzo0orZsMYXLVz9F5CaXEM2WxVzSv4hdG/nuURj8Fz47x8IKPGRmsKnaMLQVADeUEcsiZcu3nnxplbzJnqFvt1DulKqJgDdkhLkc1bvDWB+CkWihCL7OT/sPUZJ/CY8vARc0ZSS35b4eYzfWAhkpZbB/nKfke2Rm/n2M55QA7D0fvAsX6GdyrPaHMgTHNoCXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R1TTO+S80r/qBENRApVJGjaQHoU9sBm7f1BlrPXjj66/wOTFA0AOqnZNhCytX/Bw+hAIjABoCYifdj5kHyt4TaDdCH+sZimquzmsL+evhsG6GtazUeHOnyfLQvBszol54HXnRj5H/gOQ44Q2ywuwovPtgV5NqjYIsgSIWlT6pdGbhAdZi/tMM5HVbp5N3JqhFfGerT3nuVjrC6g3ionl5bD9+tNqMXDcRSIs9HHrAi7M5qEX23BwEB+W1vHBTpeeGTAKED7+ijgjVhlXJ/EjM4jw8VOU1GrujVpERopmHJetKuqTgWGWLHf0z7XKOl727r2voCRDSXQe6xwxDNiJrNhNaUQ+P/8Vk1BMzy0uDLxfiFf7b/Q4+3phvW+7PtNhXUAR8dSwAbbdesxpYZlKwMUktJnikoHVPCmexakjsghiUKXRU1H37U4LEQMw/MAQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:23.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52780aa0-e121-424c-1bd9-08de946f91a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

Move the PML page pointer from VMX-specific vcpu_vmx structure to the
common kvm_vcpu_arch structure to enable sharing between VMX and SVM
implementations. Only the page pointer is moved to x86 common code while
keeping allocation logic vendor-specific, since AMD requires
snp_safe_alloc_page() for PML buffer allocation.

Update all VMX references accordingly, and simplify the
kvm_flush_pml_buffer() interface by removing the page parameter since it
can now access the page directly from the vcpu structure.

No functional change, restructuring to prepare for SVM PML support.

Suggested-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 24 ++++++++++++------------
 arch/x86/kvm/vmx/vmx.h          |  2 --
 arch/x86/kvm/x86.c              |  4 ++--
 arch/x86/kvm/x86.h              |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6e4e3ef9b8c7..9ed19e99d481 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -873,6 +873,8 @@ struct kvm_vcpu_arch {
 	 */
 	struct kvm_mmu_memory_cache mmu_external_spt_cache;
 
+	struct page *pml_page;
+
 	/*
 	 * QEMU userspace and the guest each have their own FPU state.
 	 * In vcpu_run, we switch between the user and guest FPU contexts.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b77750a2efc2..909085a5dfb3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4934,7 +4934,8 @@ int vmx_vcpu_precreate(struct kvm *kvm)
 
 static void init_vmcs(struct vcpu_vmx *vmx)
 {
-	struct kvm *kvm = vmx->vcpu.kvm;
+	struct kvm_vcpu *vcpu = &vmx->vcpu;
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
 
 	if (nested)
@@ -5026,7 +5027,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write64(XSS_EXIT_BITMAP, VMX_XSS_EXIT_BITMAP);
 
 	if (enable_pml) {
-		vmcs_write64(PML_ADDRESS, page_to_phys(vmx->pml_pg));
+		vmcs_write64(PML_ADDRESS, page_to_phys(vcpu->arch.pml_page));
 		vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 	}
 
@@ -6491,17 +6492,16 @@ void vmx_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info, u32 *error_code)
 		*error_code = 0;
 }
 
-static void vmx_destroy_pml_buffer(struct vcpu_vmx *vmx)
+static void vmx_destroy_pml_buffer(struct kvm_vcpu *vcpu)
 {
-	if (vmx->pml_pg) {
-		__free_page(vmx->pml_pg);
-		vmx->pml_pg = NULL;
+	if (vcpu->arch.pml_page) {
+		__free_page(vcpu->arch.pml_page);
+		vcpu->arch.pml_page = NULL;
 	}
 }
 
 static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u16 pml_idx;
 
 	pml_idx = vmcs_read16(GUEST_PML_INDEX);
@@ -6510,7 +6510,7 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 	if (pml_idx == PML_HEAD_INDEX)
 		return;
 
-	kvm_flush_pml_buffer(vcpu, vmx->pml_pg, pml_idx);
+	kvm_flush_pml_buffer(vcpu, pml_idx);
 
 	/* reset PML index */
 	vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
@@ -7738,7 +7738,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (enable_pml)
-		vmx_destroy_pml_buffer(vmx);
+		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
 	nested_vmx_free_vcpu(vcpu);
 	free_loaded_vmcs(vmx->loaded_vmcs);
@@ -7767,8 +7767,8 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	 * for the guest), etc.
 	 */
 	if (enable_pml) {
-		vmx->pml_pg = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-		if (!vmx->pml_pg)
+		vcpu->arch.pml_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		if (!vcpu->arch.pml_page)
 			goto free_vpid;
 	}
 
@@ -7839,7 +7839,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 free_vmcs:
 	free_loaded_vmcs(vmx->loaded_vmcs);
 free_pml:
-	vmx_destroy_pml_buffer(vmx);
+	vmx_destroy_pml_buffer(vcpu);
 free_vpid:
 	free_vpid(vmx->vpid);
 	return err;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9b0c5dde9437..ba04d32a1412 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -262,8 +262,6 @@ struct vcpu_vmx {
 	unsigned int ple_window;
 	bool ple_window_dirty;
 
-	struct page *pml_pg;
-
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 628b6f51d2be..52c06d095c25 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6720,7 +6720,7 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
 		kvm_vcpu_kick(vcpu);
 }
 
-void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, struct page *pml_page, u16 pml_idx)
+void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, u16 pml_idx)
 {
 	u16 pml_tail_index;
 	u64 *pml_buf;
@@ -6739,7 +6739,7 @@ void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, struct page *pml_page, u16 pml_
 	 * Read the entries in the same order they were written, to ensure that
 	 * the dirty ring is filled in the same order the CPU wrote them.
 	 */
-	pml_buf = page_address(pml_page);
+	pml_buf = page_address(vcpu->arch.pml_page);
 
 	for (i = PML_HEAD_INDEX; i >= pml_tail_index; i--) {
 		u64 gpa;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 3b2cc2756033..21d88a768d8e 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -769,6 +769,6 @@ static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
 /* PML is written backwards: this is the first entry written by the CPU */
 #define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
 
-void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, struct page *pml_pg, u16 pml_idx);
+void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, u16 pml_idx);
 
 #endif
-- 
2.48.1

