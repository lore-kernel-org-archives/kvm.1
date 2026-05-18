Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBA405C30
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080395; cv=fail; b=nDAmxCzRnXjWM29ScS7ZTrBJmu2OHqbXIPlfPVrLQHSYBOGXw3zFgl09p3n7XcisM99jn/RxYvHO5D6WCDeFfrD6f1LoU/IlhaDUDNLja5srd35mBBQIN1H1jnbmVvQhb0Hsnct+xVUtFKgFzoFgEHYP4mMygmYND2S7FDIofMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080395; c=relaxed/simple;
	bh=Lv/EySBkHYqdSayOfLt10zapeqylK7iMH2AeiYftORQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sN13pmHrSVOFDSoZYpyqqfL598B1WhDo8HOApZvMQNlfygHUimivNBzLJSSxHsyM9n1E6Iz4oePxz9HT0/iFcNFXOFbERqMpd5wQONdJMQBy01mwVnVZuyL+Xx4/trpuCzv1En/cfrP77sHtZvPfev/EyZyzngsJfA9ARQpiaVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zmlADeMs; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zmlADeMs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiv9fmx9L0/rTLHMR64kWrAIcHZmD6FFK8VQpJOIR1ifvsPePToRq6VOwOoCpXP7O5mUtDrqrmGi8B9/UaiLyfAbAbFrRzoZjKimWzofQTpaKGcqXb95BbwkUBpOVPs9c1A13G5oUEkzHzqaKQ2lco0rGXPNrConrANuNi55wxTaqkR9S5Zz4AozixypIdKzamh/t3ls8ANQ5Bt48px72baiAOyvFu/yNiKEVO1MFnSV8Q1cc100MqRKXOCNduNCH9lzJA/9v8HJ64trn6uy9p425qX+rbRZH0qhcvQCos4SyNJXcSX/hQsXJM/zgeDt0mLCOo9bRFbW8bRDP2neKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN6U34980jnEt/OAcit2z3klq1uyk/GW6CaJbJj2sPg=;
 b=fwbMiK825HfK2i3o0qUuo96mPpVT/YYI4UhbfT5GY1lKl2IJ56RrDR5FlRmBYmYhwK8+tkFvAqS17b+piGxmInFyXlhfvrQocu+hAMwpKRtF9Pr/aacrgNifvZMwaZSum9sRjCZoNjRrl87+W781RJQ4S5eKjNx2Q/2oIzxnnNocbWKwQZt7VbvgjfIjmGCQJuVrAn9RQzrhPZGMHBTmy+GCkntbPtvyyvY6S+wgkHe1tkcyfBWTxZEduR9v0r0wIQcR95xp+ZuorcWCCPnUtdjd214hx7RMlNVqN2lCROt7CgrP0tJwUQrN8DxmAVjaksEfUPLAQs/8ChCDvZ4VGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN6U34980jnEt/OAcit2z3klq1uyk/GW6CaJbJj2sPg=;
 b=zmlADeMsJyqIdeSJq3xWmRANOsjTPpSZO7bYeReohn1DPPME1FgW8ORc9LK3sD1US9DGGTxvtg2HWEq+NqYVMBR4R1Y6w5Xyssj5MBNp6AH8xhmlPaxDGwh92iKvCexhyTZELXlouw0No+WiMMOawaICfloCD3bw7UFdSzwqORE=
Received: from IA1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::9)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 18 May
 2026 04:59:47 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:464:cafe::27) by IA1P220CA0018.outlook.office365.com
 (2603:10b6:208:464::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 04:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 04:59:46 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:43 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v7 2/7] KVM: x86: Move PML page to common vcpu arch structure
Date: Mon, 18 May 2026 04:59:11 +0000
Message-ID: <20260518045916.2988667-3-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518045916.2988667-1-nikunj@amd.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d76e52-cfd4-4ebd-a17c-08deb49a4887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	bSIXanBqCk6UzJT+jONTq6xSJqDpSi4K/ysQh6ik4ocL6MMRSTdt6cDxCnyVi4c5YPK5HuMsnOdufx9yKdMiSAkphm8VHui4LLTWjzMZbOQ8NuKQkE1TFAO7c8HeStTmkOzcc5QmrUBkvDODLAxKQd/8FxdC9cAmr4FgP7a/hXS/o5Dal3TlRwu9Dq0EszmaKJNEDz7TJivnpbZ6Ctk2Qt2GXb1WfYE7Oj7HRxjOSVX1OFlHyjKdfk2EJBmu7cNyAu6c+Vy3jiTjTIuSpg77r5V8/InFHKvBx/fTDX0XjHnUtrrkA+9DuRJ2S2hzGAKMjdCdYI2wBvtIKUCRgdU80nsxiviadXXroaRDHsN1izDVzeGdbyGHl3l9X1THfCGZ7Z2WZ3GxSqKeY4bsjIdHmspq7MK/eVFStCxWzBw4u0GOLMwwzfcndNLAv0fSDCNGOHLoXrKgNfI5n6N8nE3EO8TBHTNg+fhC5YzIKzb6xWslrg9sacBplv4/e6A+BP6eRrF4X+1HeZHFmu4agLfFCwplU+/0tIsAYlGk6zpWt/ZeKVxEM1yIzGagK/n0YLVRR31X2uHDx/0adZE6NhLv+ugNaeidGg3sU5Eix47mIvmLLejMgyxbfaaL3+TRtkAzbnlDnFMomAzlWOYslYFTPnU2ao0hblDZhw7JWSLJcV5duziy0eUIOOZ5ct7OFE8/XN5xkzx2yMF9E6d3H2ekOElfwWwU25iQPpODsT8p5t0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7mNk/0RMPVOt4eQaBM7FBnN4k6oSHaCVmW6n6KbG+I+C4RKtA+VbzFk6iCsPPapIu5WIqILrCBFCf0/tnzrKI+E38DThS0Rk19uvxiE3KAMvo9KF3OAdFTaQdF1jwtY/T2OWWPUtSU8lOK6ywZ3zpcJ95SPJymtfoJ16W9rUdag9P8hi/FyIKjdM/lrfhj+SJanUPv0l2lbOh9/PQgod1O5nIwZTW5SQPvnqWaygzKEi4gm/mxNM+W8NoL54GM1dMqh1tNtr4Tp+oNkVVz23aH9bxAeAFX3MgehJ/oZCS+6fDj4L/FerK8BTC7YC/K3aUvIZcM919EeDIOkzdAFR4/hfFSLJBt2We9eOkqgasMvwC9gLKU1BHVAGqDX+hPGibDDHX6T0YOPGS0kMSpc8WgxEiJdgI7lVGSNSDRfBOBunO8bKLh9xbIBvHvoe52cR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 04:59:46.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d76e52-cfd4-4ebd-a17c-08deb49a4887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5

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
 arch/x86/kvm/x86.h              |  6 ++++++
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 271bdd109a98e..1f14285380691 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -893,6 +893,8 @@ struct kvm_vcpu_arch {
 	 */
 	struct kvm_mmu_memory_cache mmu_external_spt_cache;
 
+	struct page *pml_page;
+
 	/*
 	 * QEMU userspace and the guest each have their own FPU state.
 	 * In vcpu_run, we switch between the user and guest FPU contexts.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index db468bcdc9808..7524eb7ddf386 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4946,7 +4946,7 @@ static void init_vmcs(struct kvm_vcpu *vcpu)
 		vmcs_write64(XSS_EXIT_BITMAP, VMX_XSS_EXIT_BITMAP);
 
 	if (enable_pml) {
-		vmcs_write64(PML_ADDRESS, page_to_phys(vmx->pml_pg));
+		vmcs_write64(PML_ADDRESS, page_to_phys(vcpu->arch.pml_page));
 		vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 	}
 
@@ -6411,17 +6411,16 @@ void vmx_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info, u32 *error_code)
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
@@ -6444,7 +6443,7 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 	 * Read the entries in the same order they were written, to ensure that
 	 * the dirty ring is filled in the same order the CPU wrote them.
 	 */
-	pml_buf = page_address(vmx->pml_pg);
+	pml_buf = page_address(vcpu->arch.pml_page);
 
 	for (i = PML_HEAD_INDEX; i >= pml_tail_index; i--) {
 		u64 gpa;
@@ -7681,7 +7680,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (enable_pml)
-		vmx_destroy_pml_buffer(vmx);
+		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
 	nested_vmx_free_vcpu(vcpu);
 	free_loaded_vmcs(vmx->loaded_vmcs);
@@ -7710,8 +7709,8 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	 * for the guest), etc.
 	 */
 	if (enable_pml) {
-		vmx->pml_pg = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-		if (!vmx->pml_pg)
+		vcpu->arch.pml_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		if (!vcpu->arch.pml_page)
 			goto free_vpid;
 	}
 
@@ -7782,7 +7781,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 free_vmcs:
 	free_loaded_vmcs(vmx->loaded_vmcs);
 free_pml:
-	vmx_destroy_pml_buffer(vmx);
+	vmx_destroy_pml_buffer(vcpu);
 free_vpid:
 	free_vpid(vmx->vpid);
 	return err;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index daedf663c0a9c..645ec09628e82 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -258,13 +258,6 @@ struct vcpu_vmx {
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
index 38a905fa86de2..ca3c693bfb35e 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -797,4 +797,10 @@ static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
 
 	return true;
 }
+
+/* Support for PML */
+#define PML_LOG_NR_ENTRIES	512
+/* PML is written backwards: this is the first entry written by the CPU */
+#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
+
 #endif
-- 
2.48.1

