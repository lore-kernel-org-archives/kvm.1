Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435F40DB4B
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763180; cv=fail; b=ZAj1DLwcjBRoHj3xNWdqDq0oURlvtLgx+P3Vui5fuc4q2Nebcq3sswD6RDtMjBdczycvzDsVIEHHCAQQfZTSwb5e2IdVbrBAqUKW8r4D/uyJ4jMU6FbWRekkWPRQYBAPW55ZuUBUY5r2bNeW9qAnu7l8+I7i7vJYBzVb/G3KlOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763180; c=relaxed/simple;
	bh=WIbZGOV8pNwZDXxM/rds8SlaETMDLUMyqrgr5L61icM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXifHSPBMBV6Ft5MLv3i7qNWjGuxSsmb7SPbr3SPyeJmHe7FNZmZ7+HFEwEzoVCRLSI2fLbmYRyg3o1uPF6EPx47AR+dfkMTDCG/MM1U7dycVqXhOBZppoA1VB8O49IvxLmEruj+yfjs2okmysJA0vBo5uC0gXuri3USPb4WLZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qhLg7IME; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qhLg7IME"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL+PXVnlmUlf2FTw1H10tSE9j68X2SzL53HXOZJKMhyzdUmv+xm9KAKdU1ZvRjYa98gnvFJNhSCeGQSaOlY7z2huCA68anEu+SnFIKKnfeVam8Q+XcjGS0tU/sLY77RM+pZsa6CiGc0QxqpVdcVY+5lGy8uj1u6WoSKLhkptbhvsWizevBss9jfVtc4XNuIGXZXJixhF9WXURqAFzLT+VhjpmHCVHvHecwol7KgCcvcJZ5xHPEUvNpnnDJs06SEcHPpUvDVblhCmcm0kblV4tEbZOVAx9GyFMzBGWIthEIIn4GSKPFb2rEMPP+Fh8qoE1N3n6XGDswyvlFxXCAKCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bhRN0LTanQWW058Qu2iLyRKtBylKWt7iHazIcGvwLE=;
 b=i6Z28EtIl7A63uJTyZEKu1GKdU6ot5G3stgc9kJwkv24h00zpH2dxcZJt+dEqxBYoWwfym3fQqG6FmFgyhb6HhPB4rzqHfLy2ml1nx6kpn5kQG6WYMaysfl3Cn7tX6Lccp4MjpGTki9QwQGlljf5F55PUvsvfASLNMix5vapV0lA+AMA9YD1Z+8lH85xxziacxU12+ECxqoq6lCcqZPsBTmQogYFjgyoPTyhWYyfyVkJf0wkrHoB71ILSL+PA6GmiV4T/9OMhhGuyRdNEj++zcH46UxKBoRxRVZSYV3g462Mj/uuvQnfjH4xh5DGimQ1vIHcqvlOkF2Xaaxthk3TAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bhRN0LTanQWW058Qu2iLyRKtBylKWt7iHazIcGvwLE=;
 b=qhLg7IMEsOKhhjA3aluGfG0dQxCCZmzE+cAl7Ic6i2OBOy1STW+vqxT0UEHZ/NoORq+gXtnpSFP4DIU7w5/KYId4GVVv4L5OwUJwWBuoqnJynC/OIqgk+k+a2lADVptx9/xb4QYYCJtuNCTckcn4mxEwsPIVusE97A0FUekLeYA=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:35 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::7a) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 06:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:34 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:31 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 3/8] KVM: x86: Carve out PML flush routine
Date: Mon, 7 Sep 2026 06:39:01 +0000
Message-ID: <20260907063906.1964557-4-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaf0c85-37fa-4ea9-ba27-08df0caac7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7WUfZJUgttzdBBsiXECdtRgLFCctsUozXLlCDF+evvRp3n9Ox10f56lh7BgRYfmfW0sZ/0woyUgqClt8P217ZlCuknFE7iJa9+8v3KLOvrXG9qqsWAd6SMCI0z0ca2S6fZQyLPBqjagZ5BpR4YM/ozZnTwQvLGpKvOgowfhQDnrlJu+K+O/8BJgUl/3Cfr8byF19HoqEwQZbJsCGuqywBbLLCFfxUoIlTU2zTPBd2vLd11AcWpMG7qck6e0SNmcRJe/zwIsoeakzC4Hptool00wWN7PgeMn6ybVREDHY/lpyE3eV6Vv+m4JL2Veq1VNI4nIeB4Nx9yA/R81Laozyip/7egawE33xikkSNtzbOA7dzKfYOLgBJ2Y4LnKqXDPMfdIxjHBtFQLCzhCI1uyw9ADAxWUleQAVwA5vamk6QwG65O5dBSt7Lamteyfi/9UKJPeOM6j8wiDTEXVkzIzQColPcz2DvGJiCjqVn5Z/ICl4RQbPQg1L+y/AJFRL1vLoCJmEF1FPl8b3WULcGHbcAjrtOWtzORUpboFkrnp9/f+6p0L5WodNYRg8vDFbj3OQ1NGp30LKLxwCvFDpv0cm1gadxdsf6nshTgjjskkVzRPNl6f2Ouolg+AF8fJMzOb6s1sJEeAQccY3poaFXkVJrZ8LKHXCaLoVssLZzAEjN5GVmxetd7/W3yFVWxbY5ji9E01v+of2+f+vzHeT0ikSPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TTg751Ic7FWCPFwc/sx7xkiv2AA5vbcWzw3jIoTKRYB8WTg/kUR32UOcjNJiGISej2ZWzGX3YDPkBGW7LfwJ1GmEjhpnulHIo0oqjPI53McqrWmZIKxAl6YN35QVkKxQU3u56APnw1bBXHEzKef49CzBPDBGzX9QjkKoPzaIqbJ8P/WaNdAFbD+/SmlJXRyHaZLCrrrqsI4UPelxVMfzdgFdsLIz3mucXqCNSCIxG3BqfiMsp3bBClbA8+t4njJD7nW1VBTGDoB1tr9Ja4NEnrXTR/OweJu6QKItScTT03y1s0e5PC2qZidgzZEdUK6+i9455ia8vkJbSp2jkB9Sv/If31hisAIg184ozWLvkBnPHLrN1+QXVlcjAA9e6M4PlBYvN9ZB5QpKzzMLQvWP/dctWX2JRNbjTLWL47u2N0F/Ba2FTQtNwwdSLpp6gLZb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:34.4078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaf0c85-37fa-4ea9-ba27-08df0caac7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

Move the PML (Page Modification Logging) buffer flushing logic from
VMX-specific code to common x86 KVM code to enable reuse by SVM and avoid
code duplication.

The AMD SVM PML implementations share the same behavior as VMX PML:
 1) The PML buffer is a 4K page with 512 entries
 2) Hardware records dirty GPAs in reverse order (from index 511 to 0)
 3) Hardware clears bits 11:0 when recording GPAs

No functional change intended for VMX, except tone down the WARN_ON() to
WARN_ON_ONCE() for the page alignment check. If hardware exhibits this
behavior once, it's likely to occur repeatedly, so use WARN_ON_ONCE() to
avoid log flooding while still capturing the unexpected condition.

The refactoring prepares for SVM to leverage the same PML flushing
implementation.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/vmx/vmx.c | 26 ++------------------------
 arch/x86/kvm/x86.c     | 31 +++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h     |  2 ++
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index caa24dafe989..8baf570dd456 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6429,37 +6429,15 @@ static void vmx_destroy_pml_buffer(struct kvm_vcpu *vcpu)
 
 static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 {
-	u16 pml_idx, pml_tail_index;
-	u64 *pml_buf;
-	int i;
+	u16 pml_idx;
 
 	pml_idx = vmcs_read16(GUEST_PML_INDEX);
 
 	/* Do nothing if PML buffer is empty */
 	if (pml_idx == PML_HEAD_INDEX)
 		return;
-	/*
-	 * PML index always points to the next available PML buffer entity
-	 * unless PML log has just overflowed.
-	 */
-	pml_tail_index = (pml_idx >= PML_LOG_NR_ENTRIES) ? 0 : pml_idx + 1;
 
-	/*
-	 * PML log is written backwards: the CPU first writes the entry 511
-	 * then the entry 510, and so on.
-	 *
-	 * Read the entries in the same order they were written, to ensure that
-	 * the dirty ring is filled in the same order the CPU wrote them.
-	 */
-	pml_buf = page_address(vcpu->arch.pml_page);
-
-	for (i = PML_HEAD_INDEX; i >= pml_tail_index; i--) {
-		u64 gpa;
-
-		gpa = pml_buf[i];
-		WARN_ON(gpa & (PAGE_SIZE - 1));
-		kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
-	}
+	kvm_flush_pml_buffer(vcpu, pml_idx);
 
 	/* reset PML index */
 	vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..dc5af51c0a90 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3941,6 +3941,37 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
 		kvm_vcpu_kick(vcpu);
 }
 
+void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, u16 pml_idx)
+{
+	u16 pml_tail_index;
+	u64 *pml_buf;
+	int i;
+
+	/*
+	 * PML index always points to the next available PML buffer entity
+	 * unless PML log has just overflowed.
+	 */
+	pml_tail_index = (pml_idx >= PML_LOG_NR_ENTRIES) ? 0 : pml_idx + 1;
+
+	/*
+	 * PML log is written backwards: the CPU first writes the entry 511
+	 * then the entry 510, and so on.
+	 *
+	 * Read the entries in the same order they were written, to ensure that
+	 * the dirty ring is filled in the same order the CPU wrote them.
+	 */
+	pml_buf = page_address(vcpu->arch.pml_page);
+
+	for (i = PML_HEAD_INDEX; i >= pml_tail_index; i--) {
+		u64 gpa;
+
+		gpa = pml_buf[i];
+		WARN_ON_ONCE(gpa & (PAGE_SIZE - 1));
+		kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
+	}
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_flush_pml_buffer);
+
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 05c31ee984c9..2d747c20965c 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -905,4 +905,6 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
 /* PML is written backwards: this is the first entry written by the CPU */
 #define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
 
+void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, u16 pml_idx);
+
 #endif
-- 
2.48.1

