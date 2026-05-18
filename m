Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741638887A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080416; cv=fail; b=GUac7EXjeJB4um++jJ2BUPeQG+a0yW1RfIu2vJDBONe+kT6HP5b3qcF6itlljz6WawDfngeOax0uLTm/lW/ovNSyOdHrir43KSiEjMZ49/BtMCXsxLZH7ZNMWWUi2o2kxOe08Uk/A0+NNmFJ7pwp/VgAeb90ZOG2GLxefYV46Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080416; c=relaxed/simple;
	bh=80Elqi2xhsPOXt9+CpFEhQX9gCMPtY7+oYUzsi4UsmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnDKrc+TPR+Yn+XRfFoqdGM+cHFcI+zKIvOOhDpIzNY+oZRrqJAtMlUfNXvHJVB6iBpCIvfiNspaOOr84UrpXZgVf1BC0RFV7awwpvea8991rj7V9B19KADGQ91Yy5uSusqcK0XDtAEMC4VoOrc+NN01c09HqHEOcjL1AGfExIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Ocn7XHY; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Ocn7XHY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6qFlsnEhHv7RMkDhNS+gtYA7cUJpdjt9L8bqJlq6Z5uFr016OypAhDqW7kzzxKD3WeGEMjjwRacvT7RVMb1t4VGz4bmOrRJbsFntbOU9NIVeXdQzz9GNUh6pIoiYhxl8p0M4fCSUM3GH1/fNJIHxGWBnBkzsZc6eyFjYqtFH24chcWL7jtznRPPYykx+yuG5Qb7CFqL74ws6anCuBGbmp+N9O+1xp9YFE8cV/fodSGZcZMOd0X96T7YoA6qbLgA73rvTVWAgVmJbzj+Noao4XyEe8/D/ixPX/URiuL04UriOHaSgWjqp910R7oHViVIQVp4Ib+1MC4IA9J6XZJbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKKTk7Kb2lxOfcUWL3+JZqj0VuvY9q9ycwZIBOtG3cs=;
 b=bOaTMOF+k6iyvhVBE4cI+SXEm3CU4tdsoctPHgiBlKDm3vZxhhZtRo/EJ4+AB0kUGrWsgibp3IjjfahqT4cbmNjY5FL5YJJNKKYoTZC4ZmY3BKZo4KkliodAnt56jkiNXcFwz/6PO/4MBGIXx1l5k62mvGHeoMGPEfRT9viin8OGnq+a3xQdQUQ1+9Q0malFCZfY5sfdJUQ9hxsSVyk5pEcla7IxJoBAnlKRvo7Qy3Vw+FCplnrDA5zLW+NnoiEZ90+FsVTTPYFACsXceiBOBKN1HrIEwO/GPrwVUmp6Y1MzcPQLhBQAtSYKWuOjRHihIerFYS1x7MxLUAlQVGR5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKKTk7Kb2lxOfcUWL3+JZqj0VuvY9q9ycwZIBOtG3cs=;
 b=4Ocn7XHYLmWaSWpzQpIHyhtn6v+u/Gv7tUfB+4m2i4CNt3ctqNkfj4DRpJBAwjDBW/+aAe6WP+uCuspg8m3Lb7kOPvvgmdL9uzjuILZgKTYE6zTw0sEY0EIB5RwZxzxWIHX4fz2btZgc7ThB1L9TAI9UYh9E7Jqoru3U/8jJ40w=
Received: from BL1PR13CA0066.namprd13.prod.outlook.com (2603:10b6:208:2b8::11)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 05:00:07 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::97) by BL1PR13CA0066.outlook.office365.com
 (2603:10b6:208:2b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 05:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 05:00:07 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:59 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v7 7/7] KVM: SVM: Add Page modification logging support
Date: Mon, 18 May 2026 04:59:16 +0000
Message-ID: <20260518045916.2988667-8-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: da52cfdf-2d88-4ec2-1c7f-08deb49a54a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	3pADbzDL1S4KS7X/lnwyNSYMVEzllazmq9YTSOqyOChjgaLPTTXlfQgdTD49vK8ez0/OQsNsga1nCaH/qKzlCfixwcEl2ivQqAdrS0ZFufH2LS+vQJrZSgcQPJT6Ht2iYcvjsTyOcVLhwS0Tx+Bb71e4Gs4ImR0dmM+NFKMWQyJUy8ZLfG+v6UDKjk77F3Fh7TH5pAFz7BHWkxYxtO/VP9EcrF97RQvy5VBNocnujKWPgYXO1Vi1k1wwaMwQlMdHl/BEsjA21MUiz99gBSQXP5oVy1CqRnCM8TijvHc2TPGS2zkduOYddTZyzl98FdrRTEKRjeq6G2ckDqQNEYGdDbnDnsx/Lsm1zRQPC5srFeV/xXrS5RJ18Ft7/YeMUGo1c0eDU5CMB3kFHoDYGPshHPAiqbxk66MzZilvqAibj5C6FvWPU7HqhPhmNvr/TadktspSYWBnifbynC6o7NOiG5Lbak7hPPqFbYwfS6b+WyB7/3FsgSp2BXEv9EQenw7mkE3dK5YaWK/ogc7v7F9CELisrq8HN/M/gTuH00qC7sE20VRgAZsauGQj8bJ/l4f4fNfrDIu0HShJ/9XL97Bs2CTnKnjyxdlI5DRFjiOENo1YlTmQ0kqwh/aZse/aD2DeyToUr4O3QSKe/JXUdGtVeULLGnarymJFK93MT1mivyb98A2iH62WUKgP0ZwpPPzgFlmsFZZ3x7wpskcem/fNYCCPHbfAF5/Y9tdx2p4qL/s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ayBDkJwAyIJhx4ISrTZQxr+ejTvkybCt+orWVSmq6bU6FZ1Rng3w6eMue/q3SVxXlLTBgFPrKK7I/OQOGs7Y29II8fJoYNrRo1JqsOqBUSfCbV0HnUwsNzvS2q7xKOwADWDZZTycZEitQ2MNXVGj5bBnB7LqdY4KVrpMKxAUBH6BW26QnSlp6ZL+3Fj8sTDp9uVCYVj/DwtBxMNcTsUSOPu+g+jPAH4oFEI+kV/m3iGPN9rb/cYZPVXYtwfjBnz26eKp3F8O+eoOqxSc5ZsnrUNHThwDbJfAlXBXC+nXD+ZsD465UDbX85VPtWWw9KQsVrG3QW5UJJoFpltSvQObhFe1tKtfh7Rhga0mb3s12wJ2NDV3PcDbVjqvJKjkcpJj1yA5QSo5wYxCXwwH9cYBQqhUU9Lf1EiP6SmC/jW5GLChCBYYyYF+YqEAPYcG7lBm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 05:00:07.0758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da52cfdf-2d88-4ec2-1c7f-08deb49a54a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

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

Since PML_INDEX in the VMCB control area remains valid after an intercepted
SHUTDOWN, only initialize it on reset and leave it unchanged on INIT to
avoid discarding already-logged entries that haven't been flushed.

PML operates on guest physical addresses at the NPT level, tracking D-bit
updates in page tables rather than memory content. This allows it to work
identically for normal and confidential computing guests
(SEV/SEV-ES/SEV-SNP), enabling cpu_dirty_log_size to be set uniformly for
all AMD VMs without special-casing encrypted guests

Use vmcb01 directly when updating PML controls to ensure L1's state
remains correct, as svm->vmcb points to vmcb02 when L2 is active.

Clear PML fields to avoid stale data in vmcb02 for nested guests.

Add a new module parameter to enable/disable PML, and enable it by default
when supported

Acked-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/svm.h      |   6 +-
 arch/x86/include/uapi/asm/svm.h |   2 +
 arch/x86/kvm/svm/nested.c       |   6 ++
 arch/x86/kvm/svm/sev.c          |   2 +-
 arch/x86/kvm/svm/svm.c          | 108 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h          |   3 +
 6 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f199c52709df8..e0a7549a7c727 100644
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
@@ -244,6 +247,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_MISC_ENABLE_SEV		BIT_ULL(1)
 #define SVM_MISC_ENABLE_SEV_ES		BIT_ULL(2)
 #define SVM_MISC_ENABLE_GMET		BIT_ULL(3)
+#define SVM_MISC_ENABLE_PML		BIT_ULL(11)
 
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f6147..e806761850921 100644
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
index 4ef9bc6a553f3..dd30aef9fc497 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -882,6 +882,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
 
+	/* Clear PML fields to avoid stale data in vmcb02. */
+	if (pml) {
+		vmcb02->control.pml_addr = 0;
+		vmcb02->control.pml_index = -1;
+	}
+
 	/*
 	 * Stash vmcb02's counter if the guest hasn't moved past the guilty
 	 * instruction; otherwise, reset the counter to '0'.
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 37d4cfa5d980b..893145a691191 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4861,7 +4861,7 @@ struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 	 * Allocate an SNP-safe page to workaround the SNP erratum where
 	 * the CPU will incorrectly signal an RMP violation #PF if a
 	 * hugepage (2MB or 1GB) collides with the RMP entry of a
-	 * 2MB-aligned VMCB, VMSA, or AVIC backing page.
+	 * 2MB-aligned VMCB, VMSA, PML or AVIC backing page.
 	 *
 	 * Allocate one extra page, choose a page which is not
 	 * 2MB-aligned, and free the other.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e74fcde6155ec..0abe6d3f06209 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -179,6 +179,9 @@ module_param(vnmi, bool, 0444);
 
 module_param(enable_mediated_pmu, bool, 0444);
 
+bool __ro_after_init pml = true;
+module_param(pml, bool, 0444);
+
 static bool __ro_after_init svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
@@ -1260,6 +1263,24 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	if (vcpu->kvm->arch.bus_lock_detection_enabled)
 		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
 
+	if (pml) {
+		/*
+		 * Populate the page address and index here, PML is enabled
+		 * when dirty logging is enabled on the memslot through
+		 * svm_update_cpu_dirty_logging()
+		 */
+		control->pml_addr = (u64)__sme_set(page_to_phys(vcpu->arch.pml_page));
+
+		/*
+		 * PML index in the VMCB control area remains valid after an
+		 * intercepted SHUTDOWN, so only initialize PML index on reset
+		 * to avoid discarding already-logged entries that haven't been
+		 * flushed.
+		 */
+		if (!init_event)
+			control->pml_index = PML_HEAD_INDEX;
+	}
+
 	if (is_sev_guest(vcpu))
 		sev_init_vmcb(svm, init_event);
 
@@ -1324,9 +1345,15 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
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
@@ -1351,6 +1378,9 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 error_free_sev:
 	sev_free_vcpu(vcpu);
+error_free_pml_page:
+	if (vcpu->arch.pml_page)
+		__free_page(vcpu->arch.pml_page);
 error_free_vmcb_page:
 	__free_page(vmcb01_page);
 out:
@@ -1368,6 +1398,9 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	sev_free_vcpu(vcpu);
 
+	if (pml && vcpu->arch.pml_page)
+		__free_page(vcpu->arch.pml_page);
+
 	__free_page(__sme_pa_to_page(svm->vmcb01.pa));
 	svm_vcpu_free_msrpm(svm->msrpm);
 }
@@ -3331,6 +3364,53 @@ static int vmmcall_interception(struct kvm_vcpu *vcpu)
 	return kvm_emulate_hypercall(vcpu);
 }
 
+void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb *vmcb01 = svm->vmcb01.ptr;
+
+	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
+		return;
+
+	/*
+	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
+	 * code, but in that case another update request will be made and so
+	 * the guest will never run with a stale PML value.
+	 */
+	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
+		vmcb01->control.misc_ctl |= SVM_MISC_ENABLE_PML;
+	else
+		vmcb01->control.misc_ctl &= ~SVM_MISC_ENABLE_PML;
+
+	vmcb_mark_dirty(vmcb01, VMCB_NPT);
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
@@ -3407,6 +3487,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 #ifdef CONFIG_KVM_AMD_SEV
 	[SVM_EXIT_VMGEXIT]			= sev_handle_vmgexit,
 #endif
+	[SVM_EXIT_PML_FULL]			= pml_full_interception,
 };
 
 static void dump_vmcb(struct kvm_vcpu *vcpu)
@@ -3456,8 +3537,14 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	pr_err("%-20s%016llx\n", "exit_info2:", control->exit_info_2);
 	pr_err("%-20s%08x\n", "exit_int_info:", control->exit_int_info);
 	pr_err("%-20s%08x\n", "exit_int_info_err:", control->exit_int_info_err);
-	pr_err("%-20s%lld\n", "misc_ctl:", control->misc_ctl);
+	pr_err("%-20s%llx\n", "misc_ctl:", control->misc_ctl);
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
@@ -3703,6 +3790,14 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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
 	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
 		return 0;
 
@@ -5310,6 +5405,9 @@ static int svm_vm_init(struct kvm *kvm)
 			return ret;
 	}
 
+	if (pml)
+		kvm->arch.cpu_dirty_log_size = PML_LOG_NR_ENTRIES;
+
 	svm_srso_vm_init();
 	return 0;
 }
@@ -5465,6 +5563,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.gmem_prepare = sev_gmem_prepare,
 	.gmem_invalidate = sev_gmem_invalidate,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
+
+	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,
 };
 
 /*
@@ -5690,6 +5790,10 @@ static __init int svm_hardware_setup(void)
 
 	nrips = nrips && boot_cpu_has(X86_FEATURE_NRIPS);
 
+	pml = pml && npt_enabled && cpu_feature_enabled(X86_FEATURE_PML);
+	if (pml)
+		pr_info("Page modification logging supported\n");
+
 	if (lbrv) {
 		if (!boot_cpu_has(X86_FEATURE_LBRV))
 			lbrv = false;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2b6733dffd76f..7cd8207359d7c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -52,6 +52,7 @@ extern int vgif;
 extern bool intercept_smi;
 extern bool vnmi;
 extern int lbrv;
+extern bool pml;
 
 extern int tsc_aux_uret_slot __ro_after_init;
 
@@ -832,6 +833,8 @@ static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
 	svm_set_intercept_for_msr(vcpu, msr, type, true);
 }
 
+void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
+
 /* nested.c */
 
 #define NESTED_EXIT_HOST	0	/* Exit handled on host level */
-- 
2.48.1

