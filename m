Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93E44E04A
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922810; cv=fail; b=uKuYnPjwWMSz7XOexx/V34OyCpMelT+4o91iGTYvGjLmdrEjCHLcxnjtuXYBLzl+tobxqMGGxGYwAEkaz4UJuVTm6AKBn3CdWtghEbDMjtdHNB1q9Ft6Hjh1lg1IBxLX3O0wlumuyYMqJ6tWUc650Vad0x3gGMioPhtAyKY7bAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922810; c=relaxed/simple;
	bh=WSJHr0j65Rj4KnqEX37ddXf+gFSqwnY1DMUKjZ8hP94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwnYH12dFKnitj7te5EWaYBQ4CjZtNS4TTyzcRcKdaNDWZnB8lxaQtfyxIkI2o6mNBfEohAvZTv+BcWj4mtLAQdadSUlpC66DPLOCcBCAkoXlWMfFRX+uw+FfCt4BY/45tsBNb4IzSIx0qPvM1rJ1EXngQlJgW/65cgrNHNsElc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e4PLLUeY; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e4PLLUeY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCqPyA2Bufl+0pUPh6PVnD4tkE/hC5RRE/Syssbt1OS6il1f33g8ZH8DfJLWwky0hiJHLvh41OBYsoII5BcSAYHXQcYl9lekAriBq1z+sRLMeHl/YC1JW1FWIockENcRL5jJHVWu+p6hGl7Z5Dl4jKePt+tdskORKv6twRkyxFshCA5I23CldDNHAcweWaZN7SAWiaHFqjFUtJJqJp53PiYaVQvlOsqTF6U0ZPEFONdrAnRpGYog/XEHqZi5ArYHzgYb8/SzDVeUIfJbH53rSgIvNf8M5ytU1kJ/tnKtLb1mVEmasPhLkVwFZRhstKb/7htw3pf95jE7/DTDU0Wp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKjlIxGqyuPcLBRkAhr599jhdtfI8XTFAkV7pznRxLw=;
 b=P4aQ5YxaWQPy+v+QRPnH8txsPC8VYb8jLK7dCuymSjfeeBcZfKL8R56uy1Oo4EOKGT5Os7hLGQgiPRQRnx8aAOJ3/MIRpPHKBbntFwQiHKoQ9gNM/Y+GiBTZsqPQBpHvHS7s/L3AIkLyswqKTLJojYu+gBto1W4PZ1a5bFMoIrKoJ3XAxcKI62XAhuwgwlk6Dr9AIb4mQtVFWqBpeTxaOcIer2vxYcHsJXEEXRLDcHGtuHq6u3ZxrzTYs3IDDNJZxhPkJd8blrBxiFRp3m9DJ7fwG48szwzKu7fU2bX2zhiLxjHb860FtLDT9x8hda/I1U9wpMzh8tSjmWBdCyiyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKjlIxGqyuPcLBRkAhr599jhdtfI8XTFAkV7pznRxLw=;
 b=e4PLLUeYUYo4rY651Fv4bVoBbBY2BcE7cf6O18im1bBdqXggvt9rGi7ERLho3bzGSi8wSBq5b1DiuAJakh13Wl67rhsrABVFLoDV8xMQV4Fyk87emQ3aQEpGwCBwPiypeYchgsevBH55uJS+AYtjoQBqvj9YPbzJ0PjHfWSv4es=
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 19:53:23 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3e) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 19:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:53:22 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:53:18 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 4/7] KVM: SVM: Enable hardware-assisted LBR v2 virtualization
Date: Fri, 24 Jul 2026 19:50:37 +0000
Message-ID: <20260724195040.630468-5-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724195040.630468-1-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4ca461-ae74-4886-4b92-08dee9bd3798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zxcyV8vVoCxq8STogVhMuBSk50qf+g91BOz0gDC4hmcGek5Nu3D8vk4LRRlYbKJ0RUtbnj3Wkqa3Jnsf4utvj0HI9E2ZNYNPjqqMWsaydZRU4rPNQfprD1d6X/DKC3yGE9gmn1ecmQ1WRifNW07Ay9S07M1RcqvE1isAPVJ/ZSc/CS1FyRYKSVSYIWSFgeSkwz2pGvBLFhzrpZELOQrRlaYZu2Y8wrbeMca/SWiuXhHGAG+/EqpmZ5AT1YkqYsFMjDy7q5RCxfwIyDEsqkMu7fMdCCglzanVciCf68mRi7uiBq4M0QhMNBTnMP6uvlz9zhZb7pkM6Ojy4jQCTVvlD3jUNHcAvZmma5FymkA6W5FxOUJxYappQJK9TjR/Pug4EBGvZbs+rum19DalDyHGRvc2gtZ8ThVM02ZNW9JxS2YKUaGWYz347NC93pNSwyw6tYHeVfd83wS0aJ676yGS5sj0HHro087ReK5n3nClAz2m+cTnjGUneNIBGDga1EvXL+W0jWc1IvCd0vWvAQKFyqOUod2ADndoXOkj0Dsk9CP20V6n44Lsg/D0URYdrdPy/BYOwm36DocQex88/uUQL2WoVVu3BEt8/K4QuzpZW87OEsMwVCcgXqmiT1YrvfKciEXYKoJ/5H66XL/cOg7uDDnM3E797Gn38qOYOI046nlF9ZZh8jM4u3+608g2xIBaLVVDpKxDJxINlodK7jZQiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xHggy76feSnO+vApSwOVPvcRUFDV/hRQeo9foIBMlOiaZLuJLuRrqgawO4AK1oq9qgjfm696OhuKJ8e8gpOjjwQDivj1x+gUeCO4Xv2Bxq2yytgXSEuPHQFWJm1AzEzxMwfm4Wo+g9I/kOseYPyHFPmYAKBJSu+Nph16k7uzVUfPP1Mjd3vRP1CiA7ffc2uNctFQeOms/nUANsU7DnDbognTkGoBxGWsafZ8J2wMbPGiCbQ4Npi5OLpxgp77atysPCsbgIgCYoK1UTywEtaEpvnVWAmq+tF3TFVEdTQiMjS9KqimUPs/Wxv/eC0zgHabD/XTcq1tWaM0eZHGVktpfYnZXYIa9JN02iKZ1YqwBI5ayYeE+EO9s91wi7tdlbw3DWhV03/WdkkvKSXDCdIPibkTs5fWZX7/HrBw77gb8pvDDrTjEgq9NMYzvNf9nNxO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:53:22.2668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4ca461-ae74-4886-4b92-08dee9bd3798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A

Enable V_LBR so hardware saves and restores the guest's LBR v2 state in
the VMCB, and pass the LBR v2 MSRs through (by disabling interception)
to the guest while it is set. V_LBR is enabled lazily, only once the
guest turns on branch recording, just like legacy LBR keys off DEBUGCTL.

Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/kvm/svm/svm.c | 46 ++++++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 13ac62604ca0..04e386b838d3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -750,6 +750,41 @@ static bool svm_lbrv2_supported(struct kvm_vcpu *vcpu)
 	       kvm_vcpu_has_mediated_pmu(vcpu);
 }
 
+static bool svm_lbrv2_active(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	return svm_lbrv2_supported(vcpu) &&
+	       (svm->vmcb->save.dbg_extn_cfg & DBG_EXTN_CFG_LBRV2EN);
+}
+
+static void svm_recalc_lbrv2_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	bool intercept = !svm_lbrv2_active(vcpu);
+	int i;
+
+	if (intercept == svm->lbrv2_msrs_intercepted)
+		return;
+
+	for (i = 0; i < 32; i++)
+		svm_set_intercept_for_msr(vcpu, MSR_AMD_SAMP_BR_FROM + i, MSR_TYPE_RW, intercept);
+
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_LBR_SELECT, MSR_TYPE_RW, intercept);
+
+	/*
+	 * DBG_EXTN_CFG stays permanently intercepted for non-SEV-ES guests so
+	 * KVM can observe LBRV2EN and lazily toggle V_LBR.  SEV-ES+ guests must
+	 * delegate LBR virtualization to the processor (per the APM), where
+	 * intercepting LBR MSRs can be fatal, so toggle it with the rest.  See
+	 * commit b7e4be0a224f ("KVM: SEV-ES: Delegate LBR virtualization to the
+	 * processor").
+	 */
+	if (is_sev_es_guest(vcpu))
+		svm_set_intercept_for_msr(vcpu, MSR_AMD_DBG_EXTN_CFG, MSR_TYPE_RW, intercept);
+
+	svm->lbrv2_msrs_intercepted = intercept;
+}
+
 void svm_vcpu_free_msrpm(void *msrpm)
 {
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
@@ -805,8 +840,10 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm_disable_intercept_for_msr(vcpu, MSR_SYSCALL_MASK, MSR_TYPE_RW);
 #endif
 
-	if (lbrv)
+	if (lbrv) {
 		svm_recalc_lbr_msr_intercepts(vcpu);
+		svm_recalc_lbrv2_msr_intercepts(vcpu);
+	}
 
 	if (cpu_feature_enabled(X86_FEATURE_IBPB))
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_PRED_CMD, MSR_TYPE_W,
@@ -874,6 +911,7 @@ void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 {
 	__svm_enable_lbrv(vcpu);
 	svm_recalc_lbr_msr_intercepts(vcpu);
+	svm_recalc_lbrv2_msr_intercepts(vcpu);
 }
 
 static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
@@ -886,9 +924,11 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
+
 	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
 			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
+			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)) ||
+			    svm_lbrv2_active(vcpu);
 
 	if (enable_lbrv && !current_enable_lbrv)
 		__svm_enable_lbrv(vcpu);
@@ -902,6 +942,7 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 	 * do, so always recalculate the intercepts here.
 	 */
 	svm_recalc_lbr_msr_intercepts(vcpu);
+	svm_recalc_lbrv2_msr_intercepts(vcpu);
 }
 
 void disable_nmi_singlestep(struct vcpu_svm *svm)
@@ -1347,6 +1388,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	svm->x2avic_msrs_intercepted = true;
 	svm->lbr_msrs_intercepted = true;
+	svm->lbrv2_msrs_intercepted = true;
 
 	svm->vmcb01.ptr = page_address(vmcb01_page);
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f62bf19024cc..01dae3828a7a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -363,6 +363,7 @@ struct vcpu_svm {
 	bool avic_irq_window;
 	bool x2avic_msrs_intercepted;
 	bool lbr_msrs_intercepted;
+	bool lbrv2_msrs_intercepted;
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
-- 
2.43.0

