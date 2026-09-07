Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FF400E0D
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763198; cv=fail; b=nvNH+WTbTj9tn2UIE+mF6y0Demi2pesNXjoHaHGkO1cCuS/gvtQDFl+Tj7VEWHDRyuFzj7SsFOaKy+6d1gNdH3qVqgVQ1ltvB78dgA1w2ZnV+7M1WSUxJUZXwril11Nh1W1MhTFbBcJGCz+OdUTZ8LocD6Z1GXJB5x/MrPIBHEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763198; c=relaxed/simple;
	bh=ApgN/yuo3bZkVl6U2fZk1kHg1UyfUo80A8dkpfMFfS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR5H5PDtFKeI0fmG6X1cf5MjVteztZD0unq5LsOCFJZRY+WIczEHiyeTre3nhd9Bbdy+sbyKV0mLE3sPO7edudc/Y54nt4Pgj4sT1Dcu5C/N9jS6DV/iNbEh9fTDN4Du1jN2a03dJ5TN8ipyneXif6ok5apRvTDdRh37UnRFqAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jYv7//yP; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jYv7//yP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCdkAyaYFKLWf2bX2vn7n5u36DFkBHidnt9Rp24PmEiHnknI8MWD0oppbHmcBO2ygBe2q+u0y8ZGbDd8nuDNIDAwm+npL+cazUdxJDvs58ub3PC42gEHhs4vwwdjYcrk2XTsA+RFdSICWrGzsqel4BcEAo1oo2IrL5vT16Bw4TAzp7n3UFZRqSxlRhVY6/dr7yVKK7LxDiQPu1ueGj9nNmt2A2mJpwylMTQQ+KahN76HgzELBwYikrzhvwjdvQtprI/+oVGm7BFnAWStHbjtpawT46tWhb7X637OP38FV6qWl185f2XXy7vvgxpCJKHVhGEePgtbeyMP5k//S+aCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+GPOwTdfhAWUyFkZCH/7FheGO4m1FoM4ff+n8w4xoY=;
 b=e7Z04+9R1vG/knMGHK0LdHTbq2gMik7Oj2R2E1T5R4nGNM2IG5pBUJwqkU6HYub+GqcVjfCmZjbkU93qib4TsKQ+KgzGLlkYaH6bwcZhK6fhOH3h5FgkODADxv47P6cn8Qhd0iRcldOnKob7mj/DUt5cTpolyr9InBQVjCOtwe1ZK16stJhla8qWz7Se80bb95mP1Qp0J/l4xQzs2TqC/hyvKfw8R2qBnE3Z2K5EajwlozhZUaj5LLpTCBxkyFmcE6Sj2fLmMFp1/pV5Y5TElaXi7fs7BlBSCgJEtfKjnP6x9Ep+voMZepqf12/u1UHvkf8t2t9RShmG4AnvzxIXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+GPOwTdfhAWUyFkZCH/7FheGO4m1FoM4ff+n8w4xoY=;
 b=jYv7//yPMFRVdm/oCHS4+smH0U5V1EiF89539MINrnVShjucH+hNoX3PkxPRLBB9VZMpwin34LheLEysr16rjj8ZQbgQ55Hugl/lY5Hfk4NKc9qYkB3A3vuAcFDlxZzCj7+6KymApn05CAJ3PIa4q62/3phVjNZmD0GsprICsWY=
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:50 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4d) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 06:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:50 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:46 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 8/8] KVM: SVM: Add Page modification logging support
Date: Mon, 7 Sep 2026 06:39:06 +0000
Message-ID: <20260907063906.1964557-9-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f01650-257c-4f90-e9df-08df0caad17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|6133799003|3023799007|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EqwMYNa3dfKGb/KvyQy7EEb8LfE46HJBOWDnHLckadtXtikT8zdyoGuBLPZBRzARpt32hjeZiF+J7SHHsuUCQzH3kghGfrr2iHrmbVz8HEb5y3i2ed9ksj6fG3B9vt2mHzKUldUczOU99kYU2+hcv+6j0RkrZXFH1qN62QQ3BgvB6H2WQnCwzQj/bVmmkwo0HiIr928YUyL69o1HePdflOqkcXwkB4nhpGeWFovuOvvKrOLga8AbDuuJtMfvPG3M8+jhLlMSi6H+pIcuc+oLY9qvyXFcetPvqP/d5nloAQBSUNieKDBEm6lGdkijGC2fxDE9Vgcs4ETK3l/gANSqnxpz8SHrRQCrjXPR7UE2mqzxMgF27yAzNVTOW2vwNXLTuZ7JqCMFapAMXdyDqg1VInMTOWnxPQWQzX/IsYOgjuyR+1s5i+jr+hM32R8vFIUGtkC/L1/f/8f6qhKPZ4ko4uoHUe8MYEkjSNfmeK3CI9XDPj1hmLJOtQPJi4lrWEK9jmdukHdlXJQy6USDNwmNwcQi+Cb0oIhrLxUY15BwFxple7eIijkJRomM/oUTTgw6gh7sWVfKE7CiAfG7h646nRTCtKo51dmhdKqZPNnv+lkwKRovrpWymLEtEZ+6wU5aA/lZhh11Ab2MJMSyjzGsLoEvS2Q1Qg3IKiGLwXuUeRWobnB4/d5dzB23gLe3KPLXOd0k4HZvf4w1KU5tCvJDtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lk8Q2N3bwLspfLAmPXcOm4bED6l9e1y6s77ZppOw+31nQVRavAooHlW05MzAKYPBan/ui9LXJYgcjFcD+cukm3bye309E9srChTCaFSBC3tTOcH6ybKLe7/hexgtreZZCzqIdkeNA975C9Gqp16dAgq/XZsR66AypwoZ2S0QIz2yBnT0ScKx+3yNd/79G2gzlwKrVoQOC75hlvyDqL4rC1qNA9hqb7+pn4KeRyDZYh8nZ5oVTNPmAgs5shxPcTvl9vHcnNzbaj5BFZbuG2ayH7TsqjjRa6adxVppvP5h2F6XlQe5yh/SVGs1igYUn11kKLv3zp5nt2fRQ6RGke/gxSb+unb8wRBzHWKqiWzwx0qau8WmPFCERl93GJhup5NFwwR4QCe8kshWkT5+QGmOPvILZ+v+jFhX1sOCiIieHp716S84crVU57Kdw+0mLTHt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:50.7101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f01650-257c-4f90-e9df-08df0caad17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

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
 arch/x86/include/asm/svm.h      |   6 +-
 arch/x86/include/uapi/asm/svm.h |   2 +
 arch/x86/kvm/svm/nested.c       |  14 +++++
 arch/x86/kvm/svm/sev.c          |   2 +-
 arch/x86/kvm/svm/svm.c          | 106 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h          |   1 +
 6 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f199c52709df..e0a7549a7c72 100644
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
index 73f37b050d0a..da417c4c5915 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -901,6 +901,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
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
@@ -1820,6 +1827,13 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
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
index 5705723f1f41..cfe990f80504 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4994,7 +4994,7 @@ struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 	 * Allocate an SNP-safe page to workaround the SNP erratum where
 	 * the CPU will incorrectly signal an RMP violation #PF if a
 	 * hugepage (2MB or 1GB) collides with the RMP entry of a
-	 * 2MB-aligned VMCB, VMSA, or AVIC backing page.
+	 * 2MB-aligned VMCB, VMSA, PML or AVIC backing page.
 	 *
 	 * Allocate one extra page, choose a page which is not
 	 * 2MB-aligned, and free the other.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d59d301e1e5..950c250a77b5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -179,6 +179,9 @@ module_param(vnmi, bool, 0444);
 
 module_param(enable_mediated_pmu, bool, 0444);
 
+bool __ro_after_init pml = true;
+module_param(pml, bool, 0444);
+
 static bool __ro_after_init svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
@@ -1267,6 +1270,23 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
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
+		 * The VMCB control area remains valid after an intercepted SHUTDOWN
+		 * (AMD APM Rev 3.45+), so only initialize PML index on reset to avoid
+		 * discarding already-logged entries that haven't been flushed.
+		 */
+		if (!init_event)
+			control->pml_index = PML_HEAD_INDEX;
+	}
+
 	if (is_sev_guest(vcpu))
 		sev_init_vmcb(svm, init_event);
 
@@ -1326,9 +1346,15 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
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
@@ -1353,6 +1379,9 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 error_free_sev:
 	sev_free_vcpu(vcpu);
+error_free_pml_page:
+	if (vcpu->arch.pml_page)
+		__free_page(vcpu->arch.pml_page);
 error_free_vmcb_page:
 	__free_page(vmcb01_page);
 out:
@@ -1370,6 +1399,9 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	sev_free_vcpu(vcpu);
 
+	if (pml && vcpu->arch.pml_page)
+		__free_page(vcpu->arch.pml_page);
+
 	__free_page(__sme_pa_to_page(svm->vmcb01.pa));
 	svm_vcpu_free_msrpm(svm->msrpm);
 }
@@ -3344,6 +3376,45 @@ static int vmmcall_interception(struct kvm_vcpu *vcpu)
 	return kvm_emulate_hypercall(vcpu);
 }
 
+static void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb *vmcb01 = svm->vmcb01.ptr;
+
+	if (enable)
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
@@ -3421,6 +3492,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 #ifdef CONFIG_KVM_AMD_SEV
 	[SVM_EXIT_VMGEXIT]			= sev_handle_vmgexit,
 #endif
+	[SVM_EXIT_PML_FULL]			= pml_full_interception,
 };
 
 static void dump_vmcb(struct kvm_vcpu *vcpu)
@@ -3470,8 +3542,14 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
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
@@ -3649,6 +3727,13 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
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
@@ -3717,6 +3802,14 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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
 
@@ -5311,6 +5404,9 @@ static int svm_vm_init(struct kvm *kvm)
 	if (!pause_filter_count || !pause_filter_thresh)
 		kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_PAUSE);
 
+	if (pml)
+		kvm->arch.cpu_dirty_log_size = PML_LOG_NR_ENTRIES;
+
 	svm_srso_vm_init();
 	return 0;
 }
@@ -5429,6 +5525,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
 
+	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,
+
 	.deliver_interrupt = svm_deliver_interrupt,
 	.pi_update_irte = avic_pi_update_irte,
 	.setup_mce = svm_setup_mce,
@@ -5689,6 +5787,10 @@ static __init int svm_hardware_setup(void)
 
 	nrips = nrips && boot_cpu_has(X86_FEATURE_NRIPS);
 
+	pml = pml && npt_enabled && cpu_feature_enabled(X86_FEATURE_PML);
+	if (pml)
+		pr_info("Page modification logging supported\n");
+
 	if (lbrv) {
 		if (!boot_cpu_has(X86_FEATURE_LBRV))
 			lbrv = false;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..f566dae44bb0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -53,6 +53,7 @@ extern int vgif;
 extern bool intercept_smi;
 extern bool vnmi;
 extern int lbrv;
+extern bool pml;
 
 extern int tsc_aux_uret_slot __ro_after_init;
 
-- 
2.48.1

