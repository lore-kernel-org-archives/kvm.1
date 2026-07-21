Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E652BE7DD
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610404; cv=fail; b=c1wSY7a+P+53RBvQxV7ho2bkovoDa5LBR1RBpIPfFPf+C77Tucw0DUS+sOITa1y2ShKeM3PC7kismAlciOJDbnsRGpRGQM1a7PGeD9AAGtUPU26X1JT6+bHs1NI0hFtGM8xWXk5yi2OxlEPZ5v3XqKkwx5MPoUcrrIvtUxFEzSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610404; c=relaxed/simple;
	bh=Taf+Y91vKaGnI8kUpou4eRJ6yoFvvd0IAtPdpK+qmfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFhuX1K77LoK+5kaBlnq7Dd5WeE9wDuTlaRXjOEzAjL5Ok2+XG9w2L8OSfgbkxgtWNnQl2SexLppM48QbZlba0tMMRb1CNMAuNPNVrzSjiN9lgT5NcDFft7FevzXm5efAXEAniSnUfuYjxgUfHD+L5n5OZLTohm4uAR9XT1xodw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GdxUX6yq; arc=fail smtp.client-ip=40.93.195.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GdxUX6yq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5dwyrPw3WQKCZp8EG4o6m8wfGLwo0t/bRZuPPpS5jXsQGuJXCX0y/jiSYilZz4T7frUSH9mNtkgb0f2uCQPrh3xjxOtMVKXfo98Ql+UPVtTRohii96V+JEmUb/U//5RdLbSRBYK4LCbKQg/SzQGjKLeONfIRdyHsD1uyfpSyP3Aw0+DTpkIbw5NIkSeshqQPmfr50VpWXNvZZOhjXcSu8H2iYHvP1ryU5F/G6N5+8Uw0FPKtdaMLrAEfukjY/4u1hwQeF4iiQc4bcXAsws48gzbRbBgqkY+GLtjs1v4aJTDgK5we8IAfWTCQhwjuSwC/4ivQo1T3TfsMDCczVRgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjWZ4JCxv6bpDpRKx9DZ1RDku9XKwgkVnGvrVdaTz3g=;
 b=ewl0VJsFeN21P06K890mcKhLJIxNaM+yDxvqTCiSe6u+oNvJUbLvddEjKmP4MNHiYtD5qwmMEicOxAS+QK6yejx2MPK64hCbGiKkvDP/58jGcsLwdarJRClygAid7QMEC5qfeEx9/Qb04TydLt3qk4+yeE3FOMRt8m9tdgXiSZ7i9HyrWP1ktiZ9Z3bM7+WBUCeJ29M24Ud0Nx1jAz1fhcBUgpvEt/q8gJS6CRwinJ1FtsjHEtHhjHu36NYyD/EpfB+4I77DmNb0lBIKfHW1uneUzHRJjKi3XpccfMCuiET9YdLEZkXTXT7NLfylrl3cLccmBGmm4zaTHqEMimjaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjWZ4JCxv6bpDpRKx9DZ1RDku9XKwgkVnGvrVdaTz3g=;
 b=GdxUX6yqcjlDQPD7S+culC95Uqu5VxZicC68nxZMTWDWOHLaX6LVGIYAShsrsXmh/soDe5rQ+uL26LOIDIrfxUlJifWqhNL+lfwi3xn60uz5kwxgUbI3+FIBwMstpbY+2piS88LczTbLY/7wneOKE3TK8afw5brVAizOQiYzKfA=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:06:33 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::56) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.17 via Frontend Transport; Tue,
 21 Jul 2026 05:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:06:33 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:06:29 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v4 1/5] KVM: SVM: Refactor svm_update_lbrv()
Date: Tue, 21 Jul 2026 05:05:56 +0000
Message-ID: <20260721050600.87268-2-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721050600.87268-1-shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 809e4462-c836-4d78-d72a-08dee6e5d55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	UHM8u+hktVISqknwu7qWdw7nEG6D2NvRVe5giZIO3SPNUJHWvKg5+ycig3h6+ruPXaPKr95RKLFN20DSAPiYWJ2v/L0x2dEZkDdWQe5pP0JMPKGY2efjceFdcx9FHRrlPxvPKjpR+v+sThjjkIeWr13D6Hb4c84GmFy25dKa91Q6pcV/B9RPhk8LCGEBWRBMgoH4T+eZBpsL50Tq5xd5mESM8kpIHkup+8Dsf8ealWM8QscRul6voX8fxY7yfsD3Zg7wzBIgWSg6sVJWrijsalRLZiEvfltnGPcZx2egonhOSlP81FzRzvgGW6NHKftcMHCL/s0M50cSqjzA9Q/fHJTXe4HSyr5JjFdenI0zbYASOvKCW2goYCpTsyFG3GugHv6kAMAB/BbN7BKiEXVlGYof3pAZzcUWjhthcmOvsAQViglEI/INe5rGthaIEkf8zzY/w2Js0ul2qhayIfyKTwa8YmQfPmcyj4llVoMK8F4nlTkjS5BYcVLMtVPBMThg7xNN9hw/yCH3EZ1RvqVqODqNKz6SPnvYTP8Kz0PjQY/L2/Xh2m2AdrfOdBBrlKe/VnU7ZR7PVVOKCwv3GHbgZm+CNHdrXIrAmSzTMnSG2bmcISg9ezSDwQ+imVz663lb0RkfKf8Gx4sa5KC8SR4YGLujIKkd3aLajpdWfopjG0mYqiiNB2mKhqXYr4QrSH1npYZ8Y0lIwuBc1e4arRqE0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yDBN9q6tsy4ptp+earsQmuCpZjQypHYa2XpYCRmfsk1mcLY2vd5BBuSLQuegqSBhliJkSfr89seZ7M5bbxKvYCfpiEVq8u74fbBquzj6kHg90yOI9AE98+BBaLIW5QIt269IvWOTTvJdOZfCxwom0hcYl1ytQQ2B0xrMLBjW3zsyI9kAHPEycsMTqhBDNM/aoDdjTEPRUxQxW2YLFERLWKXvl9y4Re8Tn0ZuaFj1YuDqpXxXDUz6M73Ou+PPXgg7KZKEbsCoMEROdVZl4EYYlccRN/g6ZdhUycOAqCDHdIOs8hkq/j/RIq0CQSZdO6pj7xyDrMmK/xCk0igI0mt/mweNvNaTKzTwiLOf5W/hlC4KKHvIzvpEt+QslYjDVkG3a/b5ZrcO95jtpEdiMDKEUStyCaf9/COyladJkqMU6IPerEubEdJa6tLOMSlk0P2D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:06:33.4006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809e4462-c836-4d78-d72a-08dee6e5d55b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
'if' statements. Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled(),
expose it, and use it instead of open-coding the nested LBRV check.

No functional change intended.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
---
Changelog:
v3 -> v4:
 * Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled() (Yosry).
 * Collected Reviewed-by from Yosry.

v3:
 * New patch.
 * Refactor the enable_lbrv computation into 'if' statements (Yosry Ahmed).

---
 arch/x86/kvm/svm/nested.c |  8 ++++----
 arch/x86/kvm/svm/svm.c    | 10 +++++++---
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c1485c3e691c..52b8d0f9b139 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -736,7 +736,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	return 0;
 }
 
-static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
+bool nested_lbrv_enabled(struct kvm_vcpu *vcpu)
 {
 	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
 		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
@@ -812,7 +812,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-	if (nested_vmcb12_has_lbrv(vcpu)) {
+	if (nested_lbrv_enabled(vcpu)) {
 		/*
 		 * Reserved bits of DEBUGCTL are ignored.  Be consistent with
 		 * svm_set_msr's definition of reserved bits.
@@ -1301,7 +1301,7 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
-	if (nested_vmcb12_has_lbrv(vcpu))
+	if (nested_lbrv_enabled(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
 	vmcb12->control.event_inj	  = 0;
@@ -1379,7 +1379,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (!nested_exit_on_intr(svm))
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
-	if (!nested_vmcb12_has_lbrv(vcpu)) {
+	if (!nested_lbrv_enabled(vcpu)) {
 		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
 		vmcb_mark_dirty(vmcb01, VMCB_LBR);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..e9f2456982d4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -880,9 +880,13 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
-	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
-			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
+	bool enable_lbrv = false;
+
+	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
+		enable_lbrv = true;
+
+	if (is_guest_mode(vcpu) && nested_lbrv_enabled(vcpu))
+		enable_lbrv = true;
 
 	if (enable_lbrv && !current_enable_lbrv)
 		__svm_enable_lbrv(vcpu);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..d52010e4de97 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -899,6 +899,7 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
+bool nested_lbrv_enabled(struct kvm_vcpu *vcpu);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 
-- 
2.43.0

