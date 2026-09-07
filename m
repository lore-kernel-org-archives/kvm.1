Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94F40B6F4
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763178; cv=fail; b=hlZ73fNYIOoGeSubNxGoCTatlibUtlrZ/rwLGj7+QR4rmzWlhvE6Vh8kHuAB2erE37Q+PNIMyHFhlAR2KtAJmLbj9C43sO/srowc2TV89v1JlwB9XRXP8ueALQbiHYex9c8L3cMTWJlDoKQPPgVJcSmJOZVEWOgCOpftP1a10Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763178; c=relaxed/simple;
	bh=MEMduuv03u8bLycDD5Dmwd9skmwMdoQ/Yyy4duZHAgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmVZnOuqWipTb6R4P3dxfjN/5O5Zp0EoAl9NkOwoGBokeJBZPtCzrQ+i097XBPEv8Y5vo/EuSUi9r2qCfssn4yIyF7zvg95wSmZy8sz988MxHtOCa1SAp8RrfSdWbVmPT9LHOWsufLFAIyIHuNhYC9ZQ6HntZu5fzbWSCUjxqVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K3drlqTr; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K3drlqTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ej0wPqIln2kSAf3D+hWac1vRVUWxXRPEgMnwLMI1N6zEEzH44mk7qNFvwzlzj8A8601jI/lgUX4CypTgHrVOxW7JhxEUgkxpOra4hH/RRZLsXOVgots5o0axYdgqf5V8BPb8dYeHA4pISvW0nNKVkXY5zKFnDGPMQEVF4zoDBq39hFFdqG98jpFHXjIdVopatvq1ZFOmp34r6Gy2/hFELMPzx451ZgGZvBt+y1QQjcGYjGtzI7evZNjOk/y9gXRdk/+xnrzCwcK9VH1TmKXTADd3oxFUjU7PnB14d63pF4BxJPGCWz7AYokMS8gbJlhR4iKt1E1MD5QCVZ8CcaN50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHxArw/97c98eAPORmNmX6kWAN2Cr3M/k7vA1XPkghg=;
 b=gRzanpGTwDMUgLR3+B57xhsJgB/jxOYvu64dlEck7JKxRBmyvQbUiPVbGVFOSdcWpUeoRTSTVEvwZQqREJtM7ZQNR4TmCdUP092mX1i9n7ec+WGmNA+5REldspGYSQeXlPiXUgd4wOkyfZ9m7oxDw/RfkMqjcC6mvyBnmX2iDwPKG63lX2hIuQNb4Bus4Ltk6dL+B4XlhKo585EiWCYLqRnYPgqEQeiFvvr5W7hgms3R+0XuMg6XJ/T4zt4qTFarJ3Z2Llb9taYuQTUwqaEP9iz0MyZlGZRpFTRSZKAMcNSXTX2R5nzD50UYlcQLIkDcveYTE0Tl/jCz4pPM8hO3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHxArw/97c98eAPORmNmX6kWAN2Cr3M/k7vA1XPkghg=;
 b=K3drlqTrAv/BkeJSPmjEiJBL3/unuNn1uTAHL5daj6Lu+C//rbvvvZholFt6W9oIaCVfdmOfZx5SZRK4i4XrN2Jpfu46Ucc4PavQMOYRgUSTfKeOEHWhDj9P3GIMmRB2GUqGADwRUasRWHHmXhdm7fJaER+lf8wT9oyvNGa1aCk=
Received: from SJ0PR03CA0198.namprd03.prod.outlook.com (2603:10b6:a03:2ef::23)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 06:39:31 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a3) by SJ0PR03CA0198.outlook.office365.com
 (2603:10b6:a03:2ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 06:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:31 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:28 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 2/8] KVM: x86: Move PML page to common vcpu arch structure
Date: Mon, 7 Sep 2026 06:39:00 +0000
Message-ID: <20260907063906.1964557-3-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907063906.1964557-1-nikunj@amd.com>
References: <20260907063906.1964557-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: f4cba0d0-1b9c-45d4-bea2-08df0caac5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EOjQC2gq4YJjhSpArcBT/rM5mFoWcaodiPDvlc5Y9XyoXlq7W9AwwJ8F2V8mRPCbe1f4OS98G75QyjeKHGpwnUpzWG/RUYkju6OxL0vtVX8jEvlu2WqTgCiGA+9quS9U84CNC5Jf1A3J5PHnik8IuT5lnuETB2nw6N/l7vJvQ0m7vqkeSfaQl6LsD/uPCfFnkiip2TVb1mb27CxJFwB9kkkJQnjTurBjIrZwCHLTD2fbvTjT6SKn+QyVcBumPUuzW6ToNp4Gdm4UvsjLhr9bUel+TxzRk0Nlq4c5o0yabCFFqkAL/sHjK06pzZjH37RMkfY4RRJdg9JnzSavm1nc8nF6ISEgzIAT7lVI4cZn8MpvfxxV0GOdxI7YWiRemnaU18ohxuMmnodwF4ZcytBfsOqpRWW7uHIycDkQb9/Q6a+4DnwtcC0aG1wdshkY+de/ebxtNGaw3GP6WbOXFi/ZfVRR58nM6YHhB7CbvF7FB0p0ptsZ7Kb/Hrj0CFNInTtzSi2l1ZWogVWKkyDPlXk9hmmILaKEt34BbbkpHrS9gcZLkO18kFCQBoIcJo18xcdOJkxV837++nkVC3+x56WOGuhCZPPl6cZ3bwwLi+BcsQaMoPR4DT4xLEemeXRAQY4IKKzJxYj8IqdRK+HvfaWngUqVptFIah4ilEqXqP9G4a4X9ijFantEEEK1Q3+/xRIXaffWvJktv5zFejxlC2/ehg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lGo2DVhJhfD3Pvi+jSb1700qYhoDPCyq72KczGP01jOiYmYeRurolvqcccCqst/dZ3WiLyWy5VJ0hmD1fDYpIuGPIVNb5U6TRleda9iBGs8PHajA7qY7NTieMs5k39/CDt5lern46/YYlefNXQCiaEXyD+jJdXnAlrH0OjOiZUn5VOU7N5SA7IXeZUYKyF7nhR7nyPMeKrPGWa6eg87OmDLk/AGUdFUJhEQ/eTz4r+XD3alAT2plzHrTxd4X2PYp4fngwxIY4oQIn4KWF4cnvAoehQYos+2eEieo9JYoy1SgYup6mbdv2Tu4sfuzzEtV6k/Fanaz38h+GO+/2yfHkZNCwxklekxCNET4yiwn6zRSjyFRgv1Rct4KUxH9hacdVkpuZlELQyw/qvBm1qm5lMmKkd2TJcLbJcfSQRC+oq0eeJSp4BMgwfs1ehGes2XG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:31.0866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cba0d0-1b9c-45d4-bea2-08df0caac5c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

Move the PML page pointer from VMX-specific vcpu_vmx structure to the
common kvm_vcpu_arch structure to enable sharing between VMX and SVM
implementations. Only the page pointer is moved to x86 common code while
keeping allocation logic vendor-specific, since AMD requires
snp_safe_alloc_page() for PML buffer allocation.

Update all VMX references accordingly.

No functional change, restructuring to prepare for SVM PML support.

Suggested-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 21 ++++++++++-----------
 arch/x86/kvm/vmx/vmx.h          |  7 -------
 arch/x86/kvm/x86.h              |  5 +++++
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3af7395c2430..07c422793702 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -789,6 +789,8 @@ struct kvm_vcpu_arch {
 	 */
 	struct kvm_mmu_memory_cache mmu_external_spt_cache;
 
+	struct page *pml_page;
+
 	/*
 	 * QEMU userspace and the guest each have their own FPU state.
 	 * In vcpu_run, we switch between the user and guest FPU contexts.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a4fb4e77a56f..caa24dafe989 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4978,7 +4978,7 @@ static void init_vmcs(struct kvm_vcpu *vcpu)
 		vmcs_write64(XSS_EXIT_BITMAP, VMX_XSS_EXIT_BITMAP);
 
 	if (enable_pml) {
-		vmcs_write64(PML_ADDRESS, page_to_phys(vmx->pml_pg));
+		vmcs_write64(PML_ADDRESS, page_to_phys(vcpu->arch.pml_page));
 		vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 	}
 
@@ -6419,17 +6419,16 @@ void vmx_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info, u32 *error_code)
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
 	u16 pml_idx, pml_tail_index;
 	u64 *pml_buf;
 	int i;
@@ -6452,7 +6451,7 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 	 * Read the entries in the same order they were written, to ensure that
 	 * the dirty ring is filled in the same order the CPU wrote them.
 	 */
-	pml_buf = page_address(vmx->pml_pg);
+	pml_buf = page_address(vcpu->arch.pml_page);
 
 	for (i = PML_HEAD_INDEX; i >= pml_tail_index; i--) {
 		u64 gpa;
@@ -7649,7 +7648,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (enable_pml)
-		vmx_destroy_pml_buffer(vmx);
+		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
 	nested_vmx_free_vcpu(vcpu);
 	free_loaded_vmcs(vmx->loaded_vmcs);
@@ -7681,8 +7680,8 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	 * for the guest), etc.
 	 */
 	if (enable_pml) {
-		vmx->pml_pg = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-		if (!vmx->pml_pg)
+		vcpu->arch.pml_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		if (!vcpu->arch.pml_page)
 			goto free_vpid;
 	}
 
@@ -7753,7 +7752,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 free_vmcs:
 	free_loaded_vmcs(vmx->loaded_vmcs);
 free_pml:
-	vmx_destroy_pml_buffer(vmx);
+	vmx_destroy_pml_buffer(vcpu);
 free_vpid:
 	free_vpid(vmx->vpid);
 	return err;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..6bcca3487c59 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -265,13 +265,6 @@ struct vcpu_vmx {
 	unsigned int ple_window;
 	bool ple_window_dirty;
 
-	/* Support for PML */
-#define PML_LOG_NR_ENTRIES	512
-	/* PML is written backwards: this is the first entry written by the CPU */
-#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
-
-	struct page *pml_pg;
-
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..05c31ee984c9 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -900,4 +900,9 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
 
+/* Support for PML */
+#define PML_LOG_NR_ENTRIES	512
+/* PML is written backwards: this is the first entry written by the CPU */
+#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
+
 #endif
-- 
2.48.1

