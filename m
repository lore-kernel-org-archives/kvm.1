Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60A3E7BB1
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585951; cv=fail; b=Ls1AWIAnXdj1hWxCoy6kjZP+uY1T+8ZPo2rIDF3UZB8/SEMlpMgLf3pjQ4KHFr+C8RLZviv8elulngfPaU57KlgWu/HZqGRTKjjbfeH0L4MXdWU+SvckxCPWsermXWFupqdpbM2ICZ6Z9IhvmaH4CFyL2xA3q5VCd77gezYy4cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585951; c=relaxed/simple;
	bh=19UZWreuXFCuJ0HK6SXBeRKLXXeTTLWi6H8Z1B0lJTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaNWLiJfz6l0eHXcyxsqHj4080tFyZFMkB3DFpr593A+3ShmYyKIRCG8SMAgOFCD/zfMbqSbW8aAogK532lEmG6sLmyD5WlxWb37UGvxERsrSq8XXYO16siD3qxEYKGm6aN1V24vpBgcqhcszGb6iLk9Cg2FejPU7QCWTmmwCUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qnmDyieG; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qnmDyieG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnVNowYCqZQ24GSwWJUoHMZCB6TS20dSGa/xvUU9oq53dMYr26tmX0T/7sOpgiojXO1OLPsvzElqzPcZ3YYT75QOnHHOTmF7/a7BX9bHu8sFSNdJ1JZwIumajKYJs52oUZT8Q8LsPpBMrD5fVzltu/t65E3Vil7+vKIBP+XbD1/ju3v1v6fPEXcLXkPaTjSyHCyoZsVWXB0J6m9YgjH5oU+txeVwszoe6CDZnI7oMNMZLb0hz++oAG01pq2UplH6+ghy7kpKnBMjKpadawUoovEr4hK3kpNsr76MO9P8/ykLvmarQxdN/4klUBFScLm2okmHFNh0uF9QWyyi6yzCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khzlv0977kCoOC24Quh6aAnzPEmQMiwHLtH3bJuJS2Y=;
 b=c9Yy/ZMuNdsndQpXvFMGxKImELuzHeUtIxGYfjU3kqQjl1SpkAqYTPQgwXWGtx/dJNuKBdYDUydt+uy1afFo7iK/9rHy5rw/UQhmzb6QK2qnq/KH2UaPvgFUOGVhmpuEes3QHW4M1dgUZClYLKmEKeruhJqNp7lI5BL4i5/iqbz4zBYPORP9YXEKe1+NmqBjMpkNefdUK4JYfXnd1aetjp9roNXtcvAhSuGiC3l9yqXQUKxnl4RNauJC2AuILz02xuxszch76L33Io7dU7vEgeXWdypeen9TJff9l4xdWJcDqCm9sl+IPhiwrQtRbbJvOpA6vsbDwsWFTV46aFjFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khzlv0977kCoOC24Quh6aAnzPEmQMiwHLtH3bJuJS2Y=;
 b=qnmDyieGOWV6GfKgX7ApHPS1KXSWOtoJQ7oK1jR3NyAw88YoZyp9n3AthFx/EZ0UFfWwF3ccOLxi7O0Un23oMFD4PXWi8Y/rLA0trlzkWVuKmSKrZD+NxSx0JWXYAL/TgcpBsMQRjZ80W0HheP8FGyFqPkhsvlbuOdlgXjRQlCM=
Received: from PH8P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::7)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 08:32:25 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::8b) by PH8P222CA0029.outlook.office365.com
 (2603:10b6:510:2d7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 08:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 08:32:24 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:32:21 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits dynamically
Date: Thu, 9 Jul 2026 08:29:52 +0000
Message-ID: <20260709082953.69434-5-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709082953.69434-1-shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2adff6-5313-489d-0c12-08dedd949a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DweyyzEeMEyOb4ehswTGZVt+x7udazyG+x7lKhK1JJouoklDdPH5IiTdsuh7vyNkdy6lcTrF7U+R0vg15vvIe64u1Y8jGBwR9yzYpBDJiCS/11S3rWstt8qUYACL/P4WEIpav+64A5HRZ4Lv9uzTI6DMAzjFyixFGe1cxE4zOidKQvGSotz7lQlHPnYeLw1Bx/coZB+UfmjYcdlkrcHSrPcr2BEh0wOgFTPPauE/eOmmsLt6JbDG6/KnCBsjcBnsVS/FacAGMLEAQ3BIKCW/KlOt3WlSD8MF1fymRuBdTVhS1ir6W3TpHpHeORqbVz1uw1Ecwaiq8LXyDuCO3SBQRwv+QGgUgg2qSOhkiK9w+Zfw/sKXsMG7rJDqtYRDxRHG6m/HfQMeRZ7t4apM8BdRqeAsOPjZMY+oXFbluevd+aGnH1YLd0gqSnDqjwXQTRehkjT7BbrC34grsOYQtcnKEYAFuAtJ8MP+m5FYj8tgmsdXDFJ9B6YA/NDLqsJFl15FdY1mZTVHCaF+f+5w+20Y6P2qQL245JJBRNR/xng9HpvAqxKuqcVEBhKX5gzUGhA3EH8xzFmSbNEjFPBZ2k3MfHZYrdQ0b4Zb+n4DvXFaKRIpz80pU8MBN9+9BYVXFKU4LmlNncSqgmUDMZoYNZstynYzUpIYptI/kRu2EWx+o4XYv/pSWCW4fvUk+eMxTp/N+2IIaTnQoN4zHHvK8EPxBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0lRQi3l7vNg+52y0OFn2PQfbX0x3iw/QYUV0pvTGEXUaBdsv21BLGoC6aizsTxf42vUZEq5O4zJ+5k5orV3YRVDfMDMjkPaFYalfeuDulKdyEi0zETUXFZUrh8plSBRVDE9hMHw7aV+216hUI/+OBmJ1AxnDCmdbdAZdY0XF5HiMBPP7XizdGLojqLdPD0Kxx9t2//4IRLj8cUe1JWb3EAxm4u1vOfpOp3av+ob7bANp3ccCzQCZ5HjdEX3jEHB8wK1EfV6c8C1SVBaTBWu4ylgAeNiB/SHeyUpyOUY1Auaqz72KY//61Env6Bm3pmiRFrDSwpy7r69KzhY7bf9LsvnB68vXplBBUQ5aKMxW0Itn0dfoHV+xYQ1nekKaHzr2YUiW4Z9oNAz/lsoDAm9Ne1SHUwG8HsbqDS5FicAns1uVYJ2TAL0jWnVfcTCFsX2z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:32:24.7022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2adff6-5313-489d-0c12-08dedd949a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
svm_get_debugctl_reserved_bits(), that derives the reserved bits from the
guest's CPUID. This will allow DEBUGCTLMSR_BUS_LOCK_DETECT only when the
guest supports Bus Lock Detect, on both the MSR write and nested load
paths.

Plumb the vCPU into svm_copy_vmrun_state() so it can pass it to the helper.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v3:
 * New patch.
 * Replaced the static DEBUGCTL_RESERVED_BITS macro with a per-vCPU helper
   that gates the bit on guest CPUID.

---
 arch/x86/kvm/svm/nested.c |  8 ++++----
 arch/x86/kvm/svm/svm.c    |  6 +++---
 arch/x86/kvm/svm/svm.h    | 12 ++++++++++--
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 0a9e28a02692..4dfccc2deda8 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -821,7 +821,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		 * svm_set_msr's definition of reserved bits.
 		 */
 		svm_copy_lbrs(&vmcb02->save, save);
-		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		vmcb02->save.dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
 	} else {
 		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
 	}
@@ -1204,7 +1204,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 }
 
 /* Copy state save area fields which are handled by VMRUN */
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save)
 {
 	to_save->es = from_save->es;
@@ -1231,7 +1231,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 
 	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
 		svm_copy_lbrs(to_save, from_save);
-		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+		to_save->dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
 	}
 }
 
@@ -2072,7 +2072,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cead8f99d856..a59389c322da 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3164,7 +3164,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			data &= ~DEBUGCTLMSR_BTF;
 		}
 
-		if (data & DEBUGCTL_RESERVED_BITS)
+		if (data & svm_get_debugctl_reserved_bits(vcpu))
 			return 1;
 
 		if (svm->vmcb->save.dbgctl == data)
@@ -5037,7 +5037,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 
 	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
 
-	svm_copy_vmrun_state(map_save.hva + 0x400,
+	svm_copy_vmrun_state(vcpu, map_save.hva + 0x400,
 			     &svm->vmcb01.ptr->save);
 
 	kvm_vcpu_unmap(vcpu, &map_save);
@@ -5081,7 +5081,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	 * used during SMM (see svm_enter_smm())
 	 */
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, map_save.hva + 0x400);
+	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, map_save.hva + 0x400);
 
 	/*
 	 * Enter the nested guest now
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 8d77c10cf4f6..402a827f622d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -783,7 +783,15 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
 BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
-#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
+static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
+{
+	u64 debugctl = DEBUGCTLMSR_LBR;
+
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
+		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	return ~debugctl;
+}
 
 /* svm.c */
 extern bool dump_invalid_vmcb;
@@ -873,7 +881,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu);
 void svm_free_nested(struct vcpu_svm *svm);
 int svm_allocate_nested(struct vcpu_svm *svm);
 int nested_svm_vmrun(struct kvm_vcpu *vcpu);
-void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
+void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save);
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
 void nested_svm_vmexit(struct vcpu_svm *svm);
-- 
2.43.0

