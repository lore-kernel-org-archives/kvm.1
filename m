Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6438735A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080397; cv=fail; b=eveS9vBz6o5hxSU8UTrAECrkaf6aA5ATsR9lFRv/nML0RxB+8ijou0PrsrdmwjL48+51B3ECu5xBUqa3EMqo5HAo/KueGuqYZYbSuPZQUeOKaslT1NdUa86C9WmRY9799Br+/QGfZcVqy75zNlDgEOuR9ro5qdlIRQMn/VyiciU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080397; c=relaxed/simple;
	bh=7VlPJWYKf0WEv3JFEAePP88UnnpI/LUYtUrooXm/edw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx0wwV8cCwAmZsbrf7Va7u/ielKukQwVwQbyRKvIuD46ZGife5mOYd/WWQ5zh+5Gx80crrPiFNnydfsXQ4g1cgGNSbpFsweFDdNG1wqWOUBIOcAuXopjcl63WeJBQadjATWuVZQ/fzt7r1082Ux4bqGWlmZKL2aqHB6D0vvtBak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L69eY7ip; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L69eY7ip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWO3yuugNF0lAk3MFk5fn0lLSZjAnYi0VoKCVaMOerWOFbbykmEkzu2T46uNLnMJdaMm3yyaATeAO54hqzKb916kBbEUUZ7uhKx60nnqTjl1P9I/A8i6SoN9tyPAp/6zEm0RCYU63hITYsaEKQ+FIglojJEMQ02xXW/P7F+qb9kGQT8Bceib379kkHiMSpaF0d007y6rUJwhEC61bU2u/gbaVR9GnVPY8KJvvNzMHItUGHZkHcTDDTtg4LqWFbckL3KhEIiBHA7SJP4aCWHw33Wy3Pk/Zg6YT4vK4m9KsLeVAUDKeW4Vaz+au1GrN3YfmhRzIgm/cdQHnPFlHGe/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHrc4HOQrwEfXBax5PKF4S6exIz6aLsTKIJ8bqcSSm0=;
 b=dYVGNzbXFsXcR4HrH+U7AwnQ2j+cbN4Tkx0ipLfgnacfhjoY9gOZJKeZ1PoXa8Vtrpaf1YiSoLRXbJUIdzwJd3vhzjwhF5GDdRUdRcFNbyeKo0H/k+QwY6eyYTrsh5bAcZozDVs8HM4dsx2Q5Rl3k7TMe9zJENuWZwAwLLTBnv1bKMkVlrrm4T0N6weDXmGQ9MGq7T8nrgQ3GWmYu47l89FpgLO/r9OhOhcNKBW7qsTW+O56QGxzp/SAePYOsLcrP+EXfTNsARjDZJFf8Fn+XEm4jsqu4/ojSDz+CjYdZnB7Emlhc0U4DOCuuVxloJ4xkJh9REIXkN5gKavk1/1wIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHrc4HOQrwEfXBax5PKF4S6exIz6aLsTKIJ8bqcSSm0=;
 b=L69eY7ipo46hnKi4BKTa+i6LiDH1SY/pjZoeA3k2He125y3fI33lQzRShfMHs6BmqR4rBUeBVcMMSf8syOPGjzetN73elAspCmFgeQcz8wu3zxfsakc7/OR9H+WU9/0cAzs0T0JP/TUsvJP2RHT+1orLc9bghFe3FqUdkDPo18Y=
Received: from IA1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::6)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 04:59:50 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:464:cafe::d9) by IA1P220CA0019.outlook.office365.com
 (2603:10b6:208:464::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 04:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 04:59:49 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:46 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v7 3/7] KVM: x86: Carve out PML flush routine
Date: Mon, 18 May 2026 04:59:12 +0000
Message-ID: <20260518045916.2988667-4-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b871fa4-72e4-4423-b497-08deb49a4a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	UOulogjIVch0QQneE22/+8o9meRXzv4+xG/YQ/RKIFvw64ixCfi2Om/CUjwwufM1rSkGW5DxqXSe2Zw25U4GQUxMnj1OQx0Q4kyZGpV/N5are7T8tICbwWOkk2oyBDgANKI3sD3Ob582vLE6ZnhtCHJWwsWOS3h7br8URk8GvSQjpT/QAVpClehEd+Kfinn+5LFwvmKsceUfCW4kc54zIW90YWRYx+7OuaotQcgZr/EMu+P7tvgsuG7lVm8XKK4XRGpXtgMQTlTL6WZQV/ViZyLMD9Q8daZnYzPv0l4l7+yTq7xUkNBswRN5RD4HokY/6sQqRqCWYAUAnxLjbp++H4HSee/lQGvmAmp9TtQCNpAkafVjJ4Gvl38Gx4isNAI8f50Dm1Lch5Ixp7/CRJXTtxtq+6T325LrJs0Rn2teG/440loIeLJ+HOUCU89ae0u68kNA81n5pIze6JaQOTSUkCAq9Kgm0sk2oWVV+yjrKw4YmEijxyfH81up2oSVzQE8KdErHqE1Nq6kB+XsVC82+8BSt4xw+ssm6+mKvGGdsx6+n0MjECeARx0fFlUum3bTFjyvZ/3xSUmDwrfVzyX6YnwlNWCMfGrVS1vNvF7o5+jKDAcew36nkau/NGuN+jqsiqfRMXFDY0pw2c9n6ZMNZusJ9FPPivGevGBFi4vXstOrndvcmAZpJe0JzzuK/8KrtG08oXmKqfewKOD/Si691IyJ+Fx+Ui84GZAYfxiafro=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zzl5NDcRY+4ixvoK7X7K+XJMKaNBs+3yla1PakM7ynzoX9liCTKSCCkIvugztswoT3KGIwkZnNKB/A5yxuP6DHsDOyDR1LUxm+YJE4SHCSo3dbdxlSnCfZMnj0/yBlOBCdJpI78KPKQldcRolA02/C7lvlRVClbB04pnyn/P1jkjcHFYqb/W4WIcSlmTvw/gmv+9STbEUnwDtJcliGhXN+pMPCZXomEo8KBxLloCql2yRCGZBvKaTZ0FBh6QJ3FAnfJnpnWv0QNd/BUkLN6CTspPjmSMV6VWGl+JeuCVjsMo57MW2/l7SwWNbyzn/YVU5xlYiLX8cA17rDAs1Yz1DZH804Bmo5fKoO+B9vIElzFvFDWDLmtB88lQY2SleoTfs5MNN7HGiAZrrmMVF/AZU3Y6lKDpd+VvBsbR0Q6xshD9Hp6bwwoOXnGeOiboyk6L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 04:59:49.9369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b871fa4-72e4-4423-b497-08deb49a4a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

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
index 7524eb7ddf386..e6fc374302f79 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6421,37 +6421,15 @@ static void vmx_destroy_pml_buffer(struct kvm_vcpu *vcpu)
 
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
index 209eae67ab186..d1747c4e3858e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6746,6 +6746,37 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
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
index ca3c693bfb35e..7844f7a5644d1 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -803,4 +803,6 @@ static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
 /* PML is written backwards: this is the first entry written by the CPU */
 #define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
 
+void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, u16 pml_idx);
+
 #endif
-- 
2.48.1

