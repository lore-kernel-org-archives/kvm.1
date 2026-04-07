Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBED355F2D
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543626; cv=fail; b=LKq2gE0zZditsDzFoXi7xVUY4gLpSFVaWTfjAv2bT8bmNC7e2hK+SRhRaZUvN0NZ1fmOiflYlAm5bLQBrGjYDtyPoEEzSKmP1ozAXO/Iw3J7hJvxX0waqz5R0kSRcbO+vLx+UfTVGUe5EYsz/gDTGBYByADOsm2YDBt2RiwjVF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543626; c=relaxed/simple;
	bh=OXl06l2m2tPYsXqudd5kmLcfvkHGeamsD5lkmZ4O1P0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3pSMk3IAF66BEQMMBrIlu7v0IBEnwORHds8Zv7p624PxtjbTYsz0WrrLDc03Ivahr8Pvqs6f95N8JOB+06ZIa+uRAGcgcaPfoLdTMBSdHNPL20tE4MlsqEQ6JHlRsCaamzuGlMXDILA0FqlKbwEjSfpUrWTsWF68wkkgF0ctQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zsxmrrrh; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zsxmrrrh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy507apIXUlMMOpAn43VGAqXK6x3qcYnZYi1GsrWfic3vvYGaCjpqM9SeSFCJUXmYRC7qchzrzFPoyqFMS6CN7qmMNuOgJ0BZ1E8+74/LkR/FcJz9OGxq/x9adgnYZUcIrdl4tKfUSNo9q8sO55HEoLSUGHI7YfbMjC7Yk6V+LRv8qDdR29vH8mFN2j8InOMfSy91ioDTELfnptgVpimLLsbGkPqif0HxWUVOv9VzYw4rdy4h698c2q+e9nErrSXol2bLWwKfKsjCxZiAg4dzogxFhDjghNqg+7/WYFC0bHevqxHfAiFqWdc4BBjTRP9tItUHq8hr0JfGGM0/wgN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LLfDsU3T1fCUIcSicjNcuckHT0cjRheHugrL8RvfgU=;
 b=aW18kVMcoiewa+IMYx510q7KZ9/iZDSy78y1W0Vg6q5voZHlvAbM4EWt8NbKN2qPe8G2XUg9HGTdqTEzxO8dR8ocbXewGItiksX/AoBnnwxbONvZscactj8n4znYjzr8gy38hLH6qZGLYrCRPsr5luF3KSs51uiH6XsDbGFOqshfClLVvGlIrBHtdXlD6SKB62PINyPS8ff74zWU09d0BaO3liBnGpBuNfuoIvp3dYS9Q7t9txxqlmeXtJd+q/z/qDPOjQOxDO9cLCnftUkP1VU80EU+7tNnf97K4O+Svb2NT4hbZbZp4bn0MWT9y/ECj3NXp25gmFQvmA+Q9pMUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LLfDsU3T1fCUIcSicjNcuckHT0cjRheHugrL8RvfgU=;
 b=zsxmrrrhyMA3Jnvua1bAZCMx2kr0YiRM5VmFdsKQ+QPee3NrHeTmJ9yblY2Vo5b4ZyNZRenFG3IWURe+d/xHHQBFds03Woq9g3CT5KRyEcOUpJA0WXm2Ku77ihZh2Oq9ksX9o1Xxou+9jzh0+a657WlHHt1nnPfH+mJxZfpjN9k=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 06:33:38 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::96) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:38 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:34 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>
Subject: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Date: Tue, 7 Apr 2026 06:32:45 +0000
Message-ID: <20260407063245.2755579-8-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a79b8d-c49b-4faa-835e-08de946f9a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PTKn6M+XITzfJaq0xNVoxayS5sxjXPxARJkF8e7fWglL+Ff43SssqBAQ9R3Dlp7GCmAfle/uCrvPokGsnG/rz8gkgQokJm9euJuoM6/xUj80oYp1g+MSspY38B1E1oEorcJ7akcPw87VWErD3MRdOdtOHR3yIM5KPKvbWS/j2/7UhudVmN9jwLdr3M2rxgaR+PdoEg0u7vetWRZmY9Mf8iE0UA2/T9DaCde6rUZhZidm2/cXtAaVC3BeCTkXs6szA+vvErhPZjA5TWM9SZ39PR+RZz57DWuOfnGb/FJhr9aKMHP7b2lGyJn1v0I/MINjSTtXuTlckPgUdn6k5MPpl8DSeZKGJeJ6G02d3NTgUazYEoczqvH8vPQho+jqW8u2WvL0/C8gmIWm/0xxWRsdVfMb622Q7yvFmH+n0Bgko4jmuQJssT74ejaRDrdzt8LZwf9wfrdyHl27HVkaXLVNagclosC/cgx7EFmWunclgds2FLHYoCJTbaVErMntxwcElSVrKr1nSq4zNmCLxbCGVQN1p86kspydGtEugF6U5am2wLOpFnv00VXA4DBSjKZkZ7odyZ/PCxnrQGZslcCUvpAJN53cj6Cq3G96ZPPaWFCuZo7iUpE9UUC4UaHynrX/IoB7sdxbmFGzVIoz7cPb2bEpa8oNKcCUkQJWoI4SU/ZJNAQm50RMD0ydEO5/GkmITORBu9ZGQSaxXG0M2qn1dtxRmd7P2geuTkYNB3U8oGN5yC79OnyeCV1HcExCX3QTiwkNJ/nsdeb3irldpYFSdA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aLKvtBfMEiGRaxk4EFC9stzMZ9wJr7vzpQrU9/AUOkZNqXfCWsiOyoyfJpnCspCjM/PzWYDNvV8oztllWHo3qomeTWh4Y7QsT2qRIDjF0ReA7/brx32JN8PWq8/6f0GstxbaP9v+Ltk0ryJjvNCfTXgqsdvM2Gv2+zpVEpyY/E1BcUG4jv6RMr7cPvr+/IeBI1S+9ghAlfCcwpgAmOSAw9PY5H+Q8c+BsrRQ1J3K/p8kSl2Jiepc+DCuwEeEpivyYoITaNkZNe67Sc/A1ZXowhJFyJe9wmzULci9mfHbjGWhLZEQuM1CVuQk5gZy0wGN/JcHu3kQHProvult+v59jW9KTgrjfLH+WKxRddTdA3F+HZ8NolQmL7Gx5b0HxbUxHu1bKO2Gh6cHAYD3ylvX1a321FSbLGMTuuzMadmqDuyRrfcH+VmUGLpUOpPg3N6k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:38.1513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a79b8d-c49b-4faa-835e-08de946f9a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615

Currently, dirty logging relies on write protecting guest memory and
marking dirty GFNs during subsequent write faults. This method works but
incurs overhead due to additional write faults for each dirty GFN.

Implement support for the Page Modification Logging (PML) feature, a
hardware-assisted method for efficient dirty logging. PML automatically
logs dirty GPA[51:12] to a 4K buffer when the CPU sets NPT D-bits. Two new
VMCB fields are utilized: PML_ADDR and PML_INDEX. The PML_INDEX is
initialized to 511 (8 bytes per GPA entry), and the CPU decreases the
PML_INDEX after logging each GPA. When the PML buffer is full, a
VMEXIT(PML_FULL) with exit code 0x407 is generated.

PML operates on guest physical addresses at the NPT level, tracking D-bit
updates in page tables rather than memory content. This allows it to work
identically for normal and confidential computing guests
(SEV/SEV-ES/SEV-SNP):, enabling cpu_dirty_log_size to be set uniformly for
all AMD VMs without special-casing encrypted guests

When L2 is active, svm->vmcb points to vmcb02, so updates to PML controls
must explicitly target vmcb01 to ensure the L1's state remains correct. Use
the svm_vmcb01 guard to ensure vmcb01 is active during the update.

Disable PML for nested guests.

Add a new module parameter to enable/disable PML, and enable it by default
when supported

Acked-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/svm.h      |   6 +-
 arch/x86/include/uapi/asm/svm.h |   2 +
 arch/x86/kvm/svm/nested.c       |  13 +++-
 arch/x86/kvm/svm/sev.c          |   2 +-
 arch/x86/kvm/svm/svm.c          | 101 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h          |   3 +
 6 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 8fe91a0651bc..d52096d3eaa2 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -165,7 +165,10 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u8 reserved_9[22];
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_10[664];
+	u8 reserved_10[128];
+	u64 pml_addr;			/* Offset 0x1c8 */
+	u16 pml_index;			/* Offset 0x1d0 */
+	u8 reserved_11[526];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
@@ -242,6 +245,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_NESTED_CTL_NP_ENABLE	BIT_ULL(0)
 #define SVM_NESTED_CTL_SEV_ENABLE	BIT_ULL(1)
 #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT_ULL(2)
+#define SVM_NESTED_CTL_PML_ENABLE	BIT_ULL(11)
 
 
 #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f614..e80676185092 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -101,6 +101,7 @@
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
 #define SVM_EXIT_VMGEXIT       0x403
+#define SVM_EXIT_PML_FULL	0x407
 
 /* SEV-ES software-defined VMGEXIT events */
 #define SVM_VMGEXIT_MMIO_READ			0x80000001ull
@@ -236,6 +237,7 @@
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
 	{ SVM_EXIT_VMGEXIT,		"vmgexit" }, \
+	{ SVM_EXIT_PML_FULL,		"pml_full" }, \
 	{ SVM_VMGEXIT_MMIO_READ,	"vmgexit_mmio_read" }, \
 	{ SVM_VMGEXIT_MMIO_WRITE,	"vmgexit_mmio_write" }, \
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b36c33255bed..9afe4d86793b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -790,12 +790,23 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 						V_NMI_BLOCKING_MASK);
 	}
 
-	/* Copied from vmcb01.  msrpm_base can be overwritten later.  */
+	/* Copied from vmcb01. msrpm_base/nested_ctl can be overwritten later. */
 	vmcb02->control.nested_ctl = vmcb01->control.nested_ctl;
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
 
+	/*
+	 * Disable PML for nested guests. When L2 runs with PML enabled, the
+	 * CPU logs L2 GPAs rather than L1 GPAs, breaking dirty page tracking
+	 * for the L0 hypervisor.
+	 */
+	if (pml) {
+		vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_PML_ENABLE;
+		vmcb02->control.pml_addr = 0;
+		vmcb02->control.pml_index = -1;
+	}
+
 	/*
 	 * Stash vmcb02's counter if the guest hasn't moved past the guilty
 	 * instruction; otherwise, reset the counter to '0'.
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f9c1aa39a0a..427de45843f2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4820,7 +4820,7 @@ struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 	 * Allocate an SNP-safe page to workaround the SNP erratum where
 	 * the CPU will incorrectly signal an RMP violation #PF if a
 	 * hugepage (2MB or 1GB) collides with the RMP entry of a
-	 * 2MB-aligned VMCB, VMSA, or AVIC backing page.
+	 * 2MB-aligned VMCB, VMSA, PML or AVIC backing page.
 	 *
 	 * Allocate one extra page, choose a page which is not
 	 * 2MB-aligned, and free the other.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 32b002f92528..f7a5a10f50a2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -172,6 +172,9 @@ module_param(vnmi, bool, 0444);
 
 module_param(enable_mediated_pmu, bool, 0444);
 
+bool pml = true;
+module_param(pml, bool, 0444);
+
 static bool svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
@@ -1206,6 +1209,16 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	if (vcpu->kvm->arch.bus_lock_detection_enabled)
 		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
 
+	if (pml) {
+		/*
+		 * Populate the page address and index here, PML is enabled
+		 * when dirty logging is enabled on the memslot through
+		 * svm_update_cpu_dirty_logging()
+		 */
+		control->pml_addr = (u64)__sme_set(page_to_phys(vcpu->arch.pml_page));
+		control->pml_index = PML_HEAD_INDEX;
+	}
+
 	if (sev_guest(vcpu->kvm))
 		sev_init_vmcb(svm, init_event);
 
@@ -1294,9 +1307,15 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	if (!vmcb01_page)
 		goto out;
 
+	if (pml) {
+		vcpu->arch.pml_page = snp_safe_alloc_page();
+		if (!vcpu->arch.pml_page)
+			goto error_free_vmcb_page;
+	}
+
 	err = sev_vcpu_create(vcpu);
 	if (err)
-		goto error_free_vmcb_page;
+		goto error_free_pml_page;
 
 	err = avic_init_vcpu(svm);
 	if (err)
@@ -1321,6 +1340,9 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 error_free_sev:
 	sev_free_vcpu(vcpu);
+error_free_pml_page:
+	if (vcpu->arch.pml_page)
+		__free_page(vcpu->arch.pml_page);
 error_free_vmcb_page:
 	__free_page(vmcb01_page);
 out:
@@ -1338,6 +1360,9 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	sev_free_vcpu(vcpu);
 
+	if (pml && vcpu->arch.pml_page)
+		__free_page(vcpu->arch.pml_page);
+
 	__free_page(__sme_pa_to_page(svm->vmcb01.pa));
 	svm_vcpu_free_msrpm(svm->msrpm);
 }
@@ -3253,6 +3278,54 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
+		return;
+
+	guard(svm_vmcb01)(vcpu);
+
+	/*
+	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
+	 * code, but in that case another update request will be made and so
+	 * the guest will never run with a stale PML value.
+	 */
+	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
+		svm->vmcb->control.nested_ctl |= SVM_NESTED_CTL_PML_ENABLE;
+	else
+		svm->vmcb->control.nested_ctl &= ~SVM_NESTED_CTL_PML_ENABLE;
+
+	vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
+}
+
+static void svm_flush_pml_buffer(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+
+	/* Do nothing if PML buffer is empty */
+	if (control->pml_index == PML_HEAD_INDEX)
+		return;
+
+	kvm_flush_pml_buffer(vcpu, control->pml_index);
+
+	/* Reset the PML index */
+	control->pml_index = PML_HEAD_INDEX;
+}
+
+static int pml_full_interception(struct kvm_vcpu *vcpu)
+{
+	trace_kvm_pml_full(vcpu->vcpu_id);
+
+	/*
+	 * PML buffer is already flushed at the beginning of svm_handle_exit().
+	 * Nothing to do here.
+	 */
+	return 1;
+}
+
 static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_READ_CR0]			= cr_interception,
 	[SVM_EXIT_READ_CR3]			= cr_interception,
@@ -3329,6 +3402,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 #ifdef CONFIG_KVM_AMD_SEV
 	[SVM_EXIT_VMGEXIT]			= sev_handle_vmgexit,
 #endif
+	[SVM_EXIT_PML_FULL]			= pml_full_interception,
 };
 
 static void dump_vmcb(struct kvm_vcpu *vcpu)
@@ -3378,8 +3452,14 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	pr_err("%-20s%016llx\n", "exit_info2:", control->exit_info_2);
 	pr_err("%-20s%08x\n", "exit_int_info:", control->exit_int_info);
 	pr_err("%-20s%08x\n", "exit_int_info_err:", control->exit_int_info_err);
-	pr_err("%-20s%lld\n", "nested_ctl:", control->nested_ctl);
+	pr_err("%-20s%llx\n", "nested_ctl:", control->nested_ctl);
 	pr_err("%-20s%016llx\n", "nested_cr3:", control->nested_cr3);
+
+	if (pml) {
+		pr_err("%-20s%016llx\n", "pml_addr:", control->pml_addr);
+		pr_err("%-20s%04x\n", "pml_index:", control->pml_index);
+	}
+
 	pr_err("%-20s%016llx\n", "avic_vapic_bar:", control->avic_vapic_bar);
 	pr_err("%-20s%016llx\n", "ghcb:", control->ghcb_gpa);
 	pr_err("%-20s%08x\n", "event_inj:", control->event_inj);
@@ -3625,6 +3705,14 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_run *kvm_run = vcpu->run;
 
+	/*
+	 * Opportunistically flush the PML buffer on VM exit. This keeps the
+	 * dirty bitmap current by processing logged GPAs rather than waiting for
+	 * PML_FULL exit.
+	 */
+	if (vcpu->kvm->arch.cpu_dirty_log_size && !is_guest_mode(vcpu))
+		svm_flush_pml_buffer(vcpu);
+
 	/* SEV-ES guests must use the CR write traps to track CR registers. */
 	if (!sev_es_guest(vcpu->kvm)) {
 		if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
@@ -5135,6 +5223,9 @@ static int svm_vm_init(struct kvm *kvm)
 			return ret;
 	}
 
+	if (pml)
+		kvm->arch.cpu_dirty_log_size = PML_LOG_NR_ENTRIES;
+
 	svm_srso_vm_init();
 	return 0;
 }
@@ -5289,6 +5380,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.gmem_prepare = sev_gmem_prepare,
 	.gmem_invalidate = sev_gmem_invalidate,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
+
+	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,
 };
 
 /*
@@ -5515,6 +5608,10 @@ static __init int svm_hardware_setup(void)
 
 	nrips = nrips && boot_cpu_has(X86_FEATURE_NRIPS);
 
+	pml = pml && npt_enabled && cpu_feature_enabled(X86_FEATURE_PML);
+	if (pml)
+		pr_info("Page modification logging supported\n");
+
 	if (lbrv) {
 		if (!boot_cpu_has(X86_FEATURE_LBRV))
 			lbrv = false;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6942e6b0eda6..88de4d6cd9bb 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -50,6 +50,7 @@ extern int vgif;
 extern bool intercept_smi;
 extern bool vnmi;
 extern int lbrv;
+extern bool pml;
 
 extern int tsc_aux_uret_slot __ro_after_init;
 
@@ -746,6 +747,8 @@ static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
 	svm_set_intercept_for_msr(vcpu, msr, type, true);
 }
 
+void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
+
 /* nested.c */
 
 #define NESTED_EXIT_HOST	0	/* Exit handled on host level */
-- 
2.48.1

