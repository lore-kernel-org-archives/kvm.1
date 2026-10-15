Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F351B16C
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060878; cv=fail; b=rjdP+/XjTjCZLsxa4TZlLjHs20FtUhRK0uUM575dlZWKxGmy9Uy2z0p3rRq4IeAuG9uIhZTCDDDwqV7BoVXlWj91PvzHGB6TZZEVC8woLOebkVlnihi0pDShW2mFb94nYfCN+uki7tQbCdSwCYZqLsW/o0KvYDLrSxMeY2sPL3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060878; c=relaxed/simple;
	bh=dZUfibYSrD9J4/1sWrF5asA//UoWs5XyWT5O1ANWzrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGg9p+dbcBekcGnL7Fk462G8a9icxuY7Ba0SDOjPbwoAqpffyw2fUoQQeuf7+a1QnoOzRGFFkSYgTS0OPBylXKBD/lB/9KoNL/h3bgO0rM4F+OcgO/tK7HoUGpPDJlmDml69HoAujlmfmYCvntLQWsumLYeaOq677eEttFgkm+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hTZCiFFW; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hTZCiFFW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxH03ko2Mh+aFtN3F8pak6wJZIGI7wkdwjJoT2YBhvGIdimNxjC7JO4UkpgBAuE//7ShDiIkLBgqtlqhNOmk/LMpAagsTwX4CJ2jjlr52EwxgUtEpV1nIY13QkFOZBbkUzouaPtKYUA8yrcY04DYtYckFEA/qER7YNVYTU+rwjZ3uzBP8Mlv7qS7nTrp+wLgSMxSOo75soC8Fs2GPNqiNl3O+6iyJ6IpJuMvO1QTDOlwqeBI3Qz+W+tcsnbZtZarRH8HL4QF2k9S5/auqCaRt1H3UU5iQLlY85F3h/pgMUcX85gflVIHg4kHNI5NZjbKxUDCvRS8OOCUV55w+VUy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7geYXwdH2HhGXM1MzfvWHF/FnYb+eBHYPUwBtkJ1Wtw=;
 b=buX59OWQUK+Ykthz08gh+QXTczzedTXr3AaWlGOlTDuJrwaXMKk+tQ0/tAWvsQonw8WHA5NUt/J6mw1fXXAjBULj1SoYPsR/5ksvtQAWbD7C4hrVF1wCTR9Fqsf7fp+orPYG/FRBGgX3pdRR3pEF2t2zN50cdFcDsYuN0/6leEamd90uIj7T98rEP5iDUAZz4/CWniD7X1AeMfBq+pjScj1RsrdgUvxZSu6eLgEhIJWTJ90xyigpcEPi+5pthy1SgiT7p3xuUZx86EI1w/Exj7+9lfqCHBlOPeL36p/T/pUfLpelq8rIy1YgULmoOjp82k+ydCaJKPqZHV21GuNHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7geYXwdH2HhGXM1MzfvWHF/FnYb+eBHYPUwBtkJ1Wtw=;
 b=hTZCiFFWl2NYjZmvETTr7vN7jn2x39PuScoEgMV0MXBbqUJLFHrXWlm3oCV09pWYfwOi2/E7q2QVyPxg833AfcZQTSThnepLJ2k7tqgufu6t82B7x8kgxVcA9j8ax1iuQQruV6wMTx6ubOMaRaaWoncPoHi0i+ePr/vRpWdwfXM=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by SAWPR12MB999116.namprd12.prod.outlook.com (2603:10b6:806:4e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:40:04 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::88) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Thu, 15
 Oct 2026 10:40:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 10:40:03 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 05:39:54 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <mlevitsk@redhat.com>,
	<joao.m.martins@oracle.com>, <nikunj@amd.com>, <kai.huang@intel.com>,
	<yosry@kernel.org>
Subject: [RFC PATCH 2/5] KVM: nSVM: Add nested PML emulation
Date: Thu, 15 Oct 2026 10:39:30 +0000
Message-ID: <20261015103933.2088307-3-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|SAWPR12MB999116:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a33b8f-85b2-4f63-0bda-08df2aa8ac12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0/tD59Ts3Ir3baHSyZlvYoLUHNqijPW1WA2ZxId/AR8HJeIKCCBhtzsKlrEHi+BDYGEC+PrUy+ZHtvoUNYNYe4aCHhdoeigM5gvbgpVzXrZC8Ap51HCgbr8BOwX4zjMX7gh3rMbnSdp7KTD9CNf7Tfs448N5VJ1QEO0UesRE1bPFY9XLm60ttwv/PbDk60tkX2IV8UJp3RRS/7TM1PezOxkcN3yWUAaiiMUokOfDonwd6YwWwDXfDdJUMEyXNPSBEQfu+jyGpqkyced6YjCy660pjKNOos+TNebu13E/ehoOYPsDOqgBL4R4Tz5/7dwc8zb7MMof7UGGpP79EsJwWJOmDQo6L/rYB/wCq++1y0MzEWvl8yhCbM5orctGi87DtQ/52kbUPaGupYE2E0QtTtZbrV6gASQzLyU+79WOK78xJVVj7Naq3WkYRj4+d7HR3JSkkBaNySkCX1Fu/W0yrcqXGimwgmaSjzkqPil5tQpm/rZkilCKLyrJYjd9INFczEpAMZyV/v9Gq+TLiO780lcUWXSGmmbLob9vV4UlehBm3Jbq/MvFeF/ckZWPWlNcGY04ojC/c7M7WYSqxpJ/LfINj5L1AgjVQxUUeNw6dW4FcXixaPVcMqQpzJ/zPK8Na/Cx3HFt8iIAlLt4JNGrh/m7pUwuxRKjfl4KRyrznEizlSq1GVbh2CLOQrnuVfpuVr9Y/Sb/BLNPrDiSWmD2Lg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sylq+apWkCnr4v8nqPSljVCQY8GTsX7n0rlpa8Nsuuon0v4fHfJYJS29lBRxNjsT+YBtVYvluS2+D0NoOocE1ytxUSVTCLxRQkBDurOn6OAGIK3KJY5AbPIS+tqpF+hhE6xIIb1zgZD5qM8upBM0poYupgk59ts5tT8B2aCjYEl12BMfb9tHlymw+H/1DoapIgf8QpOGCKD1JUgXzkkuUimUTQ3vbLZyF2GTuid7LZ6gcc3jKUnb+clqvziSsCuYqBYp3s2U2BXTg3eiOqthgDoqcngKmtAzfciHdnHas4G+b2J6Lg+vXOH3vdSds3hHDYgCtieZBF9Uu8NoNT9iFQyl87m8m42jQRc0ML3sLSrMYHba+Mmggjs/VBoFfLLNOci0cN4H+wEvsz/249KOABSqY8muN3lbu4dXnqTDqCGPmG/SgzDr8uI686ZHSTZ0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:40:03.9255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a33b8f-85b2-4f63-0bda-08df2aa8ac12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999116

Emulate Page Modification Logging (PML) for nested SVM guests, allowing
L1 hypervisors to use PML to track dirty pages in their L2 guests.
KVM emulates PML in software by write-protecting L2 SPTEs and logging
dirty GPAs to L1's PML buffer via the write_log_dirty hook.

PML_FULL exits are prioritized over NPF exits to ensure L1 processes
the PML buffer before continuing L2 execution.

Clear any pending PML Full on nested VMRUN.  The flag is derived from L1's
log index, and a fault that KVM discards instead of injecting can leave it
set after L1 has drained its buffer.  No event is lost: if the buffer is
genuinely full, the next dirty write raises PML Full again.

Assisted-by: LLM
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/svm/nested.c      | 75 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h         |  8 ++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 043d0ec02b27..c9ec05620e44 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -234,7 +234,7 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 		if (level == walker->level && write_fault &&
 				!(pte & PT_GUEST_DIRTY_MASK)) {
 			trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
-#if PTTYPE == PTTYPE_EPT
+#if (PTTYPE == PTTYPE_EPT) || (PTTYPE == 64)
 			/* Only the nested GPA walk yields an L2 GPA to log. */
 			if (w == &vcpu->arch.ngpa_walk &&
 			    kvm_nested_call(write_log_dirty)(vcpu, addr))
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..8251b38d1479 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -17,6 +17,7 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 
 #include <asm/msr-index.h>
 #include <asm/debugreg.h>
@@ -63,7 +64,14 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 	if (WARN_ON_ONCE(hweight64(fault_stage) != 1))
 		fault_stage = PFERR_GUEST_FINAL_MASK;
 
-	vmcb->control.exit_code = SVM_EXIT_NPF;
+	/*
+	 * Only the exit code differs for a PML Full; hardware leaves the
+	 * EXITINFO fields as the nested page fault that filled the buffer
+	 * would set them.
+	 */
+	vmcb->control.exit_code = svm->nested.pml_full ? SVM_EXIT_PML_FULL : SVM_EXIT_NPF;
+	svm->nested.pml_full = false;
+
 	vmcb->control.exit_info_1 = fault_stage |
 				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
 	vmcb->control.exit_info_2 = fault->address;
@@ -416,6 +424,16 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 	       !kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
 		return false;
 
+	if (control->misc_ctl & SVM_MISC_ENABLE_PML) {
+		if (CC(!(control->misc_ctl & SVM_MISC_ENABLE_NP)))
+			return false;
+		if (CC(!IS_ALIGNED(control->pml_addr, PAGE_SIZE)))
+			return false;
+		if (CC(!nested_svm_check_bitmap_pa(vcpu, control->pml_addr,
+						   PAGE_SIZE)))
+			return false;
+	}
+
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
 					   MSRPM_SIZE)))
 		return false;
@@ -556,6 +574,8 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->nested_cr3          = from->nested_cr3;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
+	to->pml_addr            = from->pml_addr;
+	to->pml_index           = from->pml_index;
 
 	/* Copy asid here because nested_vmcb_check_controls() will check it */
 	to->asid           = from->asid;
@@ -909,6 +929,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	if (pml)
 		vmcb02->control.pml_index = -1;
 
+	/*
+	 * Clear any pending PML Full, as L1's log index has just been
+	 * reloaded from vmcb12.  A fault that KVM discards instead of
+	 * injecting can leave the flag set after L1 drained its buffer.
+	 */
+	svm->nested.pml_full = false;
+
 	/*
 	 * Stash vmcb02's counter if the guest hasn't moved past the guilty
 	 * instruction; otherwise, reset the counter to '0'.
@@ -1311,6 +1338,8 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	vmcb12->control.event_inj	  = 0;
 	vmcb12->control.event_inj_err	  = 0;
 	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
+	vmcb12->control.pml_addr          = svm->nested.ctl.pml_addr;
+	vmcb12->control.pml_index         = svm->nested.ctl.pml_index;
 
 	trace_kvm_nested_vmexit_inject(vmcb12->control.exit_code,
 				       vmcb12->control.exit_info_1,
@@ -1886,6 +1915,8 @@ static void nested_copy_vmcb_cache_to_control(struct vmcb_control_area *dst,
 	dst->misc_ctl2		  = from->misc_ctl2;
 	dst->pause_filter_count   = from->pause_filter_count;
 	dst->pause_filter_thresh  = from->pause_filter_thresh;
+	dst->pml_addr             = from->pml_addr;
+	dst->pml_index            = from->pml_index;
 	/* 'clean' and 'hv_enlightenments' are not changed by KVM */
 }
 
@@ -2169,6 +2200,47 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
 }
 
+static int nested_svm_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	u16 index;
+	gpa_t dst;
+
+	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) || !nested_pml_enabled(svm))
+		return 0;
+
+	/* The flag can be set here if the fault that raised it was discarded. */
+	if (svm->nested.pml_full)
+		return 1;
+
+	index = svm->nested.ctl.pml_index;
+	if (index >= PML_LOG_NR_ENTRIES) {
+		svm->nested.pml_full = true;
+		return 1;
+	}
+
+	gpa &= ~0xFFFULL;
+	dst = svm->nested.ctl.pml_addr + sizeof(u64) * index;
+
+	/*
+	 * Drop the entry if the write fails.  VMRUN only verifies that L1's
+	 * buffer address is a legal GPA, not that it is backed, so a failure
+	 * here means L1 has pointed PML at memory it does not have, and only
+	 * L1's own dirty tracking suffers.
+	 */
+	if (kvm_write_guest_page(vcpu->kvm, gpa_to_gfn(dst), &gpa,
+				 offset_in_page(dst), sizeof(gpa)))
+		return 0;
+
+	/*
+	 * Decrement PML_INDEX after logging the GPA (buffer fills backwards
+	 * from index 511 to 0)
+	 */
+	svm->nested.ctl.pml_index = index - 1;
+
+	return 0;
+}
+
 struct kvm_x86_nested_ops svm_nested_ops __initdata = {
 	.leave_nested = svm_leave_nested,
 	.translate_nested_gpa = svm_translate_nested_gpa,
@@ -2179,4 +2251,5 @@ struct kvm_x86_nested_ops svm_nested_ops __initdata = {
 	.get_state = svm_get_nested_state,
 	.set_state = svm_set_nested_state,
 	.hv_inject_synthetic_vmexit_post_tlb_flush = svm_hv_inject_synthetic_vmexit_post_tlb_flush,
+	.write_log_dirty = nested_svm_write_pml_buffer,
 };
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6d0242966dc8..6a0359eb0c7c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -196,6 +196,8 @@ struct vmcb_ctrl_area_cached {
 	u64 exit_info_2;
 	u32 exit_int_info;
 	u32 exit_int_info_err;
+	u64 pml_addr;
+	u16 pml_index;
 	u64 misc_ctl;
 	u32 event_inj;
 	u32 event_inj_err;
@@ -235,6 +237,7 @@ struct svm_nested_state {
 	struct vmcb_save_area_cached save;
 
 	bool initialized;
+	bool pml_full;
 
 	/*
 	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
@@ -657,6 +660,11 @@ static inline bool nested_npt_enabled(struct vcpu_svm *svm)
 	return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_NP;
 }
 
+static inline bool nested_pml_enabled(struct vcpu_svm *svm)
+{
+	return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_PML;
+}
+
 static inline bool l2_has_separate_pat(struct kvm_vcpu *vcpu)
 {
 	/*
-- 
2.48.1

