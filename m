Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444038;
	b=aOz1yiIDJ0dRCY/hg7gdRqjtAYf4Ho8MrnzT2kKwrdLABaB9ZsH9N2+W7vG9Ccz73L3o
	 dLqqR/O2GaJRrBQaCfXanoj+EM5jEka7rcpiWRY/MQcv8m+6Ca7S8yJsNH+ousjZfYibd
	 6rZ4lEDYHmRPbd8B1n929z17vE0LvQAognRUYtUfXyUM4md1QPslmY/gICbUwusg5iQNq
	 vAwy0OFhlL3abBn5ddm2WvlSMRPoKhH7wHT8eZ4Qts4BcwfVHgSA4L+Drbm+UHQwV8Qcy
	 WCnlmIxl7C2Bhr7hwq7dwOlvW6oAbKHso8dmqA9NyUDjlQ9oL/EUj+AOk2jRJBD4Nbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444038;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2dn6PwYAoy7sYOXb86iOtefdjDyL75cVMCbRqnQNhlc=;
	b=PBZws53r6RL9l2PxjuJb9IyXr+iuhmFoyF+cpPXgNfcqVnjszIyAnr2sXFRZHl2ZAzOq
	 /KzvGrws1sfZxlHA71UAI1sQZuX/j898SW0AuJJfWgpnKKq5sycnsVy0Ce1oSAbYY8iHM
	 6YDbobx5l9ugavXfKFPtGisX/sQHj9OdGPnGzskzcugT98298skqPtxYg/Uvu1K4T9Dgr
	 32wQntrp5d2JhTjUIVqm08UR9UtUjJf/NZCI7VDa8PEcsgAPleKnJK3c02vfnEgnj6r3V
	 mDyOgP/8hUa89T+zRKdlDJaYK8hmfEtny5hSV09X73K7my3Fo+tHfAGDdivVwuR6fPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OL7tJuWv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE89606A319
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE89606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OL7tJuWv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz20/YD2LEzHEvJ/itxFOhU9SuCPZatDfvpzjbR9JOIRs0NtKdHRq4kPxsiI26snBuJsNAsLu+M6i+AslLf4t7l+/hDt7aJOvGYPwXsozAjRL4UqNu87NwtmVz+l16VoLFWeOFqKAekk1RWFwUJ9C73uRk8bLdwt8XOxMFH6hdnD4efIRl8/ov/iDOyjNMfO+JgA7urllO7oVEuoNEw9sbeDPvY8lymHFYB8B3CcY6vM5VtTCHyt+kH3ADUrjCfDQz9rh3DuiNDlcXvZ47HcZmmuCj3SktLr09QIx7suHfLQTY4foSvoucrH09/LOrbqr22OsWU6W8DYnmFH+sFFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dn6PwYAoy7sYOXb86iOtefdjDyL75cVMCbRqnQNhlc=;
 b=bor4rvl8v1zlCKruYJSfGS3nHjB94qpHyRCxWF5zbWFbXG26FawczuPpTMWOPZCi1qon6VK6nQifAOJ9kPS6sneG8K97IOpf7ax4z93ohkiyMKAEVB5VE8VdFHTGvwEJpj3i8o0wQq4u4vI/FqU2nz76uvQ/rAJEGEQ8Mu54R40lGXrBzyJcqi3/73eGgkWPOyFbsAPy0Eg80VyF6I8WqEpf1X8lKy/c71Zu7UzAoliA0AyglwYz6JBf0C8saW52KPUrRZbq5QPNR0cIu6LJwtU/MuN0p1QMcLq1MI2E0WwmQUXNN38bGp5fXAxMGJyAHJPOZP6X3tcJq+bgbh1S4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dn6PwYAoy7sYOXb86iOtefdjDyL75cVMCbRqnQNhlc=;
 b=OL7tJuWvrvw6EIAk+5hU9pVzx85/j9FRjXmJe7n4ynEA6jGy7vMWC9Flt0riXGU3cYygK9kRPYJuygfv0Ar//IS2NPGYFALP346LHuH0OGIYohtPiAsyHBsu/kO0v/172VzJBxB2tKSHHHb0jnPzOKvSJ8N1TVHXeDOfcoRnHi8=
Received: from CYZPR02CA0008.namprd02.prod.outlook.com (2603:10b6:930:a1::15)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:07:12 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::22) by CYZPR02CA0008.outlook.office365.com
 (2603:10b6:930:a1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:07:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:07:12 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:07:09 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 04/12] KVM: SVM: Enable hardware-assisted LBRv2 virtualization
Date: Mon, 19 Oct 2026 21:05:24 +0000
Message-ID: <20261019210532.378628-5-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb0e563-42cf-4aef-5598-08df2e24f1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NmxrPQqJmCegZ/kcf8fl1RKehLXQFMUy2d4IAgRs0bRd8R5ZeG3w/QRrZcnnD8kKPfgoqXuebci3Nt7oTxJPV8otTH7pzOcopZe/bLZJLwe5c2NSZBKyy985ehle8zoOMgZXC+M5SOcEW2j9pgQrAv+mNppBOJTU1iOIy47mWpDPaDOfsoKZ0z/l4SSnDvBxFzzoxW0QsuWU4P+ubJLn0zQj1BiTjyfaIM4FEjhk4CbNv3GMhJqDnXOYohwxXwwDt396AudBFlUu5xqPrbSotd0BrWnEPH6lqtRB2tKhdnRhd3VRihdVCbunRTPvCN3fZKb8JijlYWDuNXj6cKw3RYx5fOnwM48/Soh2U8EMqFYxeR9Bhmbb2aYZJ3eqm5neRLv9vC2uc6b9yY28GEH/1F50100roy82pK5waRH4keYvkI9I/xf/tuV7UYifzUBR2bR8zcBv8UxxGYRyZa51xYsJnZwWasmDy0AotToVOUk0eYPh+f1+y9Jw/vskhbDnnLTBvoHCuKoNiAxpuZT3Yq9XnpaNbCBZQC+2FwubWsBMl5zk+NAMpkSAYigmuxap1eJW5Yf/AbDXcv/C2qi7tMnhAZ3b+aLWw8RejVavx7nMxOu8B1T0b4Py0uhLhU1cPJdBw/mSy+TcTZ9T8JDVrvR/Tlpy09Hy8HD+BkPtt+0vNRNQyse9LCBdVg6t/DKb71+5fKGJweMikDfGgLNsgw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oWR0T8xNzJprgFOePsZWywgxDTynhu9Otd2EGfRPk1txXcIGNUD1QU8sKNx8KgKTDF/5wLsTqvO4VBuZ5jI4/l2APX6AneoktEEws6aSuCtCzX43KPSNN+v/B7R/kJeAnTKcP+KGgTWYU7lhr82W79SIG0ua76gVZPqbX3pXG3j0mqE87xf3oGZq978lHrui1CsUeposTfLk6888Zm2DQaCFg1t1v1N91zFgAx3Nz7W1ricv9elwavJ8U+OZ5Wf4RG4RqPhKL9qrlw0x413DUud2fJPMHDD0f1aekdyOMQ3Fr6I8PipKQ5v/g6zufXqOp0RAlrZR5NZZrfMp61GYj5ljItKwUfJCAY0iYRW19LRmzT8freAxn3Swdo4AVun3Fs50Cai4ryInankQS0mPfbjIETyaC9vjAdQRjAop3nIFB9EUd4M0HsF7vPJi0vhq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:07:12.2493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb0e563-42cf-4aef-5598-08df2e24f1fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

Enable V_LBR so hardware saves and restores the guest's LBRv2 state in
the VMCB, and pass the LBRv2 MSRs through (by disabling interception)
to the guest while it is set. V_LBR is enabled lazily, only once the
guest turns on branch recording, just like legacy LBR keys off DEBUGCTL.

Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Check svm_lbrv2_active() in svm_need_lbr_virtualization(), which is
  a newly added function.

---
 arch/x86/kvm/svm/svm.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 428c95d7ef21..69f9ea746bb6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -758,6 +758,41 @@ static bool svm_lbrv2_supported(struct kvm_vcpu *vcpu)
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
@@ -813,8 +848,10 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm_disable_intercept_for_msr(vcpu, MSR_SYSCALL_MASK, MSR_TYPE_RW);
 #endif
 
-	if (lbrv)
+	if (lbrv) {
 		svm_recalc_lbr_msr_intercepts(vcpu);
+		svm_recalc_lbrv2_msr_intercepts(vcpu);
+	}
 
 	if (cpu_feature_enabled(X86_FEATURE_IBPB))
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_PRED_CMD, MSR_TYPE_W,
@@ -882,6 +919,7 @@ void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 {
 	__svm_enable_lbrv(vcpu);
 	svm_recalc_lbr_msr_intercepts(vcpu);
+	svm_recalc_lbrv2_msr_intercepts(vcpu);
 }
 
 static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
@@ -897,6 +935,9 @@ static bool svm_need_lbr_virtualization(struct kvm_vcpu *vcpu)
 	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
 		return true;
 
+	if (svm_lbrv2_active(vcpu))
+		return true;
+
 	return is_guest_mode(vcpu) &&
 	       (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
 }
@@ -919,6 +960,7 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 	 * do, so always recalculate the intercepts here.
 	 */
 	svm_recalc_lbr_msr_intercepts(vcpu);
+	svm_recalc_lbrv2_msr_intercepts(vcpu);
 }
 
 void disable_nmi_singlestep(struct vcpu_svm *svm)
@@ -1383,6 +1425,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	svm->x2avic_msrs_intercepted = true;
 	svm->lbr_msrs_intercepted = true;
+	svm->lbrv2_msrs_intercepted = true;
 
 	svm->vmcb01.ptr = page_address(vmcb01_page);
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index cde6bef61dcd..72f19053fb4c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -366,6 +366,7 @@ struct vcpu_svm {
 	bool avic_irq_window;
 	bool x2avic_msrs_intercepted;
 	bool lbr_msrs_intercepted;
+	bool lbrv2_msrs_intercepted;
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
-- 
2.43.0

