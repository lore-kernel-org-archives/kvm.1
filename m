Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357C3AA517
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036768; cv=fail; b=RBHtnHCvDEC9U7SKEwJv3C1WOp2Qawtx06OEqhtppjFZNVwL01o+UxCzdjf7yg4b7CN//+wLyhhfAcrtkBtgDsN2FB+HGl2n8Avmm8CT7Kh6l0CwwCqubYYkZzX5dzAFVJWeknj9fq1CXvVDqInnngh4UZL96osMsC9dhxJxknQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036768; c=relaxed/simple;
	bh=746t7aQ8chDSbboMOT8funvPALPFzYG22Oh8Bg11Z/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUtdVyMGNTs31jMQQRbALIkwXqACp0Ju5M5FDGGYcQpkqNsjiTmYbFfcHwYYH7lNbuMgczm98QEqOb6hRDjcnD++VtLUO/9FAatCt43jUiWYcJUVDGBvp2dM9SoqVFoxc12MhqEp8hy9kmOoxcKk9mOPHMKqsPPr93EIzlqw880=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fQzRkm9P; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fQzRkm9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMWK3rd7ea1waCYQSKjqj5rAI6tguNuej+bfkefZjpOuQT4Gqep2jz1+T9cshy0ULlzgSQmAOUdSKJQCXxDXvt+61NDEA0jtcs5GNb1F/Tcaztrt4w0dJM5JtAR1B3JBBUkPBJuTfz0Tu8fIbGPIOetvwsbDq/EfVzTXrG6lQY1NLSKO/kSsDGGTEF+ITJWyfZazy3KWT/4LxI4pYAm4upFAapgH2iTD+ctcHzxf31wZKkDyhe8sujPHQBUEucYiVWi1zcRybiLIfROEKGSF1UV21/Og4SXjD2lI0ntD/lU9Kd4cJo16IwvLERF/CIjYp7sgaqeaOMNavCl6+MNzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmMv6zFlKB5mpHSd0ZqpGXx+wHyS0gv8b81cihYkaoc=;
 b=AUPnBSLdWJbgGhUEt8//HlngXzMirX43bUWwRgPCLdHxk7zJPivhLSLVVKnPb40h9h6VxUan+krEOiJ9swgwbuess9PKo36/aiDUIJ/N60VoAKB3KnWAA4itSARvZc7rUj8bVfenUyK6PJ0AAvpxRhN8yKUylMJ0zFQxjK4DTQ3BFspFMGfXFBBLwuczkb0M+/0HLZLlMSks4M9uJwhBR2G536tTPFW8vst8eqjWdrkZZ8l+SOdZC8Qo5cPOrG2SgvKI5XmeHuJ2JE4Dv7QI6aXCT/A2R8LTpDBvqK+9n9FIPwWOB6Bf6rmT/Q49S6BgvfOaOhNl5sWW0S97OP6vBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmMv6zFlKB5mpHSd0ZqpGXx+wHyS0gv8b81cihYkaoc=;
 b=fQzRkm9P57q1+U1xFqrK9HKlo67lL2SXw9zPlUsZp0E8pT1XTNxvBRwgnd9Cblem/Q1XZJoQKYXRFltZeHyXSwv0bHPbL6qNQD/xNLo2hmrwG/bFv+sNgxK7AjGw5BCz9Z6P89k4xbZKR1zYN/9pQh+08h7W3t7iNUBld1/akNk=
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 06:39:19 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::af) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 06:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 06:39:19 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:39:16 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <nikunj@amd.com>, <pbonzini@redhat.com>, <seanjc@google.com>
CC: <bp@alien8.de>, <joao.m.martins@oracle.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <thomas.lendacky@amd.com>, <yosry@kernel.org>
Subject: [PATCH v7.1] KVM: SVM: Add Page modification logging support
Date: Fri, 29 May 2026 06:38:33 +0000
Message-ID: <20260529063833.1660791-1-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com>
References: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d31386-7628-4871-6380-08debd4d02f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099006|5023799004|11063799006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	rnkKy7Dqjdy349+NmPke5h9ebPExfTIUdo+p7eCJY3bPJkO0JmCe/gTAs003CMq9GkohGfEb/YsUJ+maosbP8rVMd+TPao6LZticdgByuj8CH3bQ67iS8SltjyLPwxm3kwlBRFgvL5I1JrjONmRF7jzKvUFcubRnU4bIeomgumRW2dKz6bHCSsy1KIwCGKl0ODtaD6NSOWkHUf7s3yVp41tbch68llXnE6G6pwLq2Wl847arjRewd8YqDxGlz8mhx0FHjBJeUsNzCCLl/7LDVHvOcGDOGb02fKRwx6npe9m+grOAU3UhChUpTn+M5ivmhFH1KjmCj7Auwj4ANH+Hdzkr8NDBwpTgAIdQrJHnOCJsmF0lnuC6BAx+P+COr9y5K3rQtxjA7rBOt7rWyBNEncgNmDq/z3T/6K8BFc8UjrMXv42UBmctUujxiqrbeHC/N8YD4X7z7hgJ+VNU7mN0u4Uf+/BrUmg6b3rnKDnk6YOgDWPJmKwP0gMOQpYZwUPYMGAnFdksYeksdW/zLFkReWGq5oDjf4YPJ3taNZtflzJ0a9C6lNHv1Z1OYBjbD4YhGJfZPpYdrVFfoLalviIavB9lGfUtw/6p341VwqpiCiZZoN6fFBlVjG2SycVq6s2Oq6YoFBORSCWP372vleb+kV4a7vx3FSDVo5vZQWcukwkmpDubrFVXqwWnKLi1kbpY2SaMMstZ0+wPcfndahvbOIMBhkYZyCeekQ7OpCZ30p4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ctYc808x7/yUc/x3PDwrIcUWoieLo11n2CEE4DL966rK9nHlT2iF2oDWZ2cQGjrSpcCdDcgE2BwvWAq9uPh32GFiWef8ZYC8mDT210H6n2znzLSp/FiA1j8af39JB6i3236YUbTsFP0mrfLXLO7KFILcD6FLsvei//BE8RAvKhUs4jFugyruDy7rxtVwEsAF3FAM/t/dvDlzZo1iH6b7K0ZSLcU43/ILJ0snRl+Ml9jVBUdh5+YDGkxqrmxZYLjnCuXMXhX3Jmha9ticQWHkdFHmcW9MzQiFBaSuXkPTMJSuLiFgiti9d3laXF6eWCXQY/29o88cbkWBrGiuR0Yctdn/Xh9H4B4l42l+HxLryHD0hApa44ulgE6o831KzIu4nn/v5kdUQbuxI16WKT0jviUBmVpC9iT/X5pnNeHTSov3fzKCs/Bi3lN4Ot6tgGwe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:39:19.2791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d31386-7628-4871-6380-08debd4d02f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780

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
all AMD VMs without special-casing encrypted guests.

Use vmcb01 directly when updating PML controls to ensure L1's state
remains correct, as svm->vmcb points to vmcb02 when L2 is active.

PML is not enabled in hardware for nested guests; treat PML_FULL as
unexpected exits.

Add a new module parameter to enable/disable PML, and enable it by default
when supported.

Acked-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---

Sending updated 7/7 patch here, rather than reposting the full series.

Sean, any remaining comments? Happy to send v8 if needed.

v7 -> v7.1:
* Drop redundant pml_addr=0 in nested_vmcb02_prepare_control() (Yosry)
* Fix misleading comment, pml_index=-1 is hardening not stale-data cleanup (Yosry, Sean)
* Route nested SVM_EXIT_PML_FULL to KVM and treat it as unexpected exit (Sean)

---
 arch/x86/include/asm/svm.h      |   6 +-
 arch/x86/include/uapi/asm/svm.h |   2 +
 arch/x86/kvm/svm/nested.c       |  14 ++++
 arch/x86/kvm/svm/sev.c          |   2 +-
 arch/x86/kvm/svm/svm.c          | 115 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h          |   3 +
 6 files changed, 138 insertions(+), 4 deletions(-)

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
index 4ef9bc6a553f3..8533a7610a5fa 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -882,6 +882,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
 
+	/*
+	 * PML is never enabled in hardware for L2.  Make sure that an
+	 * unexpected PML write would trigger a PML_FULL VM-Exit.
+	 */
+	if (pml)
+		vmcb02->control.pml_index = -1;
+
 	/*
 	 * Stash vmcb02's counter if the guest hasn't moved past the guilty
 	 * instruction; otherwise, reset the counter to '0'.
@@ -1782,6 +1789,13 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
 		if (nested_svm_is_l2_tlb_flush_hcall(vcpu))
 			return NESTED_EXIT_HOST;
 		break;
+	case SVM_EXIT_PML_FULL:
+		/*
+		 * All PML full exits are handled by KVM.  KVM emulates PML in
+		 * software for L1, but never enables PML in hardware on behalf
+		 * of L1.
+		 */
+		return NESTED_EXIT_HOST;
 	default:
 		break;
 	}
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
index e74fcde6155ec..bde900311191b 100644
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
@@ -3635,6 +3722,13 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
 	    (u64)exit_code != __exit_code)
 		goto unexpected_vmexit;
 
+	/*
+	 * PML is never enabled when running L2, bail immediately if a PML full
+	 * exit occurs as something is horribly wrong.
+	 */
+	if (unlikely(is_guest_mode(vcpu) && exit_code == SVM_EXIT_PML_FULL))
+		goto unexpected_vmexit;
+
 #ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_code == SVM_EXIT_MSR)
 		return msr_interception(vcpu);
@@ -3703,6 +3797,14 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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
 
@@ -5310,6 +5412,9 @@ static int svm_vm_init(struct kvm *kvm)
 			return ret;
 	}
 
+	if (pml)
+		kvm->arch.cpu_dirty_log_size = PML_LOG_NR_ENTRIES;
+
 	svm_srso_vm_init();
 	return 0;
 }
@@ -5465,6 +5570,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.gmem_prepare = sev_gmem_prepare,
 	.gmem_invalidate = sev_gmem_invalidate,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
+
+	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,
 };
 
 /*
@@ -5690,6 +5797,10 @@ static __init int svm_hardware_setup(void)
 
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

