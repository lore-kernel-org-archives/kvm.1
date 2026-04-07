Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD5E3890FA
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543607; cv=fail; b=cGqetHmx7B7vzn1FGNAO1R9JJ4vYHInFC9sHnJErnf74YyrI4hCLgr8vyWrcW68jwUjCyQUHSDwwIaLkNQ6eLy3LhewkdwUpfJi6PhIMFHrRmEtCfK8B5NHP/mBG0vA+ngy8oHmNS62PErqbdHXUcotmyXZJBIYi0/ttGemjeSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543607; c=relaxed/simple;
	bh=dmPYPY/CCSM1xkGcV1DHaWJRNmFeKb3GIzX1rrsZ4Ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFOO+36yjQHB2EG9BeAnoK7+ted3m2RktJ/6YP56wTOezCjXtS1bEHN1Mfde9e4s90aWy0eb8KiDgd8BIU+u8EeQ6Od6N7qQudz0Ecm6ovr/qIgxn+ZcKi/LleGpLAomLHnl3xsfAReVHTRxttaNKVEF4eo5HjMwsreml6/eDvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vrFD/4UR; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrFD/4UR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdT0MTFea59BLhEFubjj36IjP6OxqnkewpXp/3n4cwjiUceoFAe2Sj9KzvqGDo40me7sZ2cLUlYIzyPff3mdH+kJtQAIwQTI4VlOnlHIX/GhybO8taw5+nvhy3gRQbBJ9AISBjphetG0NIg91YTYOL4raAVZmQulFn1/pbIT9KmQRStMNbjnyD+ICM5057QPxNKVniutTzt73TuMwPNlzhbjZj22OJBV3pToT5XU0nqSnIcWGpFW02tZvbW0wLKCmHZiqaYvBj7zrOTOFoxf6aD9wd3iJkHCX7pzLGxPdK9FXT9F+mHtDuK8jdUZyF2DQZKj35O9jBc3k6xoPJ7IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNgetCO8gT7/zxSpilc+TMnUcv1tcQ1XL8y/Zuj7spE=;
 b=iyX4/GN+Oc+7pWGEEG+D6nRCegd/R4wiFBB0XQsREkaEdCEeX4X7AgsrVsaAwW0OJfO/dazLh/TaTZE26+KumAkbeQxtaM2xgIL2vl4QiSjtKJjqooqV2Aft4OkjRvkiBsz07pPf+WqRtXMWiYKROXaSswK1yr0GonDA53z/uOMt3GIqiOv/09TcUVD6kxrUKbI5RODRprNrErGhq0wYNDNXdtIuyB512+yI7Bco4D2HZ2PTc1+1CYw4H5CAkVpqGVHaTB5uynKKkZ+6a5j9jUsr7/+cksuJS8Km17sxGXZXBJCYBka/xJ1/Ntz3USliaG734VhiaruniUrozvR2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNgetCO8gT7/zxSpilc+TMnUcv1tcQ1XL8y/Zuj7spE=;
 b=vrFD/4URmwIun0fLhOKpKpdrFBcK2q5Xe96WvBmWR9KeUlW9WT+OHgcgJ8k8tqAFctmHxiLsk1M/Tys8gcQR8g0+7te9HB24fMnGC0xEsf8GWSvvoqgbjyOiXZYW5kyx1211/JBftny0BqFEuk4d0vVTSBFeouyJDx3kXdC7yD8=
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 06:33:21 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::47) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 06:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 06:33:21 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 01:33:17 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>
Subject: [PATCH v6 1/7] KVM: x86: Carve out PML flush routine
Date: Tue, 7 Apr 2026 06:32:39 +0000
Message-ID: <20260407063245.2755579-2-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8b7178-20c3-4e91-d85f-08de946f9007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fS76ANsuu7U+7qM7RSZX9njezDbIq8V1FsKNl53+k8IYFVyjVZMRRfu3j6DXNmh3qLohGT9B3o1B0yLhYk9ZCEe0RZFk7RKy+RNFwVWuRT+Tfd8shQyYpNnhrC+aiq2G/aIx8tRZSRwTpCNs09PNJF9+Ne0TWQ7xFupTiqDF9ccjOEjpW9cpzQTW+kS4ggwFoVhO3EAz+ILpOLcr2bi7E+RcLV9/P1A2F48/dnXPT2FMEfD/oc6zEDf0uX+n8wx7ApM8ZN0e6p6uBITc8GwDDkKjlX4yuJ7Zh3UbjLBeHS2444o/LJoCQPA5EoWeJn8cM549ZK8gdM9RHf/sUtrJybueMUwM3z+zh7oynshKWL6s31ck+pqPDKownnk4K7mxl0zkP6K+S4Fs3N/ua+wmI9ZoBoA5K34QuotgQkHW0HZGShJINOP5orFP0GOG4ayMkVpxdpM1UY4ciZUNJT3FSTui78xEcKx68X2mCxD0uy5Ah6+wxF9hJDMLyW/dGAiZqtIzKVKUZ2rK0aDWZLtgHiB/oBeVBKGFthMeZhccp3ujbvjAzBQZPJIb473r29lJA+VbPCXMRIdZKUsJxDQE+1pLl3gYro4LqdP4EIalNS7ykXNpj3cd5x1U9bq5sKfBBaAtV460A8InPcWLCSfSgLhlNLqWImbg/r+kpAqarkfsbZnDYjzJX9oyT4z0Dkudh/9FbIrZVmftkm2YH6eHeBjV2Tflqn5A8+vzP5JNU+pF+7h+O/qiE6QsxgI0Dq8vak1lfYqtMWXoo6wl1/Y7sg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pF9BrYwr8KunW3lqKBYq9XkJRx3q869K6HBwEthxmpsb6xz79sHljK2eI2PGWSc9D9iuWuX3OY+s1rM4d2y08avNwRqGAsq1siQt+1JAm97CocpztOmdEkDJ+34MfyuPRpH0fZufJP2DVDm5VWl6ria2Op+nUV+NTRrTXk8krbyvHpY9OaSbhD1cHq2vQxCxvJQDxas30EGkn03UnGQx8YuiDWUODYE1Y47iphhJDmUE87GtLCiD1CTc6l8mNr25cG70jdIym0lIopeMr84GZRA3Uo4odp53aeO11C/SAwV1nPkdkkFkxkEhG0MS0ok+2ZcKUt3Hj1oi4gOoGrEk5bzRZ7REPUz8sG/IDsn53fMzdOP76tlPYaI9YwvOW8yO4uUxQWHj/YMcR9SU+lavakfHwz1PkuOw5Yu3nZ/vfqwAn0OzdpFckXhNxKCAjTQg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:21.0556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8b7178-20c3-4e91-d85f-08de946f9007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167

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
 arch/x86/kvm/vmx/vmx.h |  5 -----
 arch/x86/kvm/x86.c     | 31 +++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h     |  8 ++++++++
 4 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8b24e682535b..b77750a2efc2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6502,37 +6502,15 @@ static void vmx_destroy_pml_buffer(struct vcpu_vmx *vmx)
 static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
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
-	pml_buf = page_address(vmx->pml_pg);
-
-	for (i = PML_HEAD_INDEX; i >= pml_tail_index; i--) {
-		u64 gpa;
-
-		gpa = pml_buf[i];
-		WARN_ON(gpa & (PAGE_SIZE - 1));
-		kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
-	}
+	kvm_flush_pml_buffer(vcpu, vmx->pml_pg, pml_idx);
 
 	/* reset PML index */
 	vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 70bfe81dea54..9b0c5dde9437 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -262,11 +262,6 @@ struct vcpu_vmx {
 	unsigned int ple_window;
 	bool ple_window_dirty;
 
-	/* Support for PML */
-#define PML_LOG_NR_ENTRIES	512
-	/* PML is written backwards: this is the first entry written by the CPU */
-#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
-
 	struct page *pml_pg;
 
 	/* apic deadline value in host tsc */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b593..628b6f51d2be 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6720,6 +6720,37 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
 		kvm_vcpu_kick(vcpu);
 }
 
+void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, struct page *pml_page, u16 pml_idx)
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
+	pml_buf = page_address(pml_page);
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
index 94d4f07aaaa0..3b2cc2756033 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -763,4 +763,12 @@ static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
 
 	return true;
 }
+
+/* Support for PML */
+#define PML_LOG_NR_ENTRIES	512
+/* PML is written backwards: this is the first entry written by the CPU */
+#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
+
+void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, struct page *pml_pg, u16 pml_idx);
+
 #endif
-- 
2.48.1

