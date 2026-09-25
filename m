Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1249B5B2;
	Fri, 25 Sep 2026 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336648; cv=fail; b=Qm6pKQux6l2tAeLkmjmeu4++BnJZgSFI/FqfGPIV3reWv8t2wU4sAOYSkwf7nWKsPyFSAgYIzQCShhtf6t7Ow58MI92AhwI5U+J/Y1pORy5onLOakCr2NnUI0lg4/qrSH/HoylKY4gdptrUB7KHxFUcNJ0FLBzJffgEvBWUPYG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336648; c=relaxed/simple;
	bh=W44YodWK5VsndJok5QoAAs/tOA1zKhrBYq4PhIrgxaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsvHmq4MPZz41WPMotY3OcyR1Bn2QXHFE2C4gFZQYNQ1yvtwmFNEm8rE2eY3ao5UUf94UxPYBAcWnUeZ2a+3uaABI6ycRhiEtSX1fX6qj7XuRzcD2UVaXF/uSfwjaQhjsnpkeYN3N065y4R/R1zHgqVKRY3jmzdqvcC885urqBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W4MLfU2k; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W4MLfU2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E79cbcFYdq8jCewCFWee4DrdoYt/caCzX+m/JMCXBBY6/o+/iiiw2po15ie61RUAindvAHZJVInXtk9W9BqLPR5yKXO2+hnz1sD/aShV6r4exq8WQru9RXOKoAe9Ekc4ZXe+EsCYv6APtQc2Y2qg6yjWsCwANY6rpzRoJe/vZUfx86i/ZzHRLG9eefEFYUrH/9mTTnAXJtqsFNNK1evTzvRZMg8hu4RRJUh1FTX8gw/e0xQ2UhMc37BkKIYBzu5INtyKQuPbmCr4ScJxZnujFMMOYT4Ms5K8k1iPE1GdQJMWiehHz9TltffbiuZObcn/U6Mj7hvaoHFaARsD/PPweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoVQYJ+iIidhK/P/Vegn6IpbylrT2LFG103h5mrY83w=;
 b=CmMAa0GGvdz7WSKGN6JnFq6z9qF/bYiwHOi05Tk19aX8jTtCAzwANIHbZAAW9cWkSMU6Bn/xKrFkAfWYiXRiF49+N2zYSBWmUG+Puuh0+WsgurfWjtLryCImiaXxaO0CQpwCx5a1+orDf/aexMImAxSuAeP6GIy0n8/Ib397NQDoA6lH5gBu2DKKtQCc++b3zKyOGzabf1PKheHEO8VF6CMCFxrufvZApTUbwopBntxA54H84rFifH0/372Q0L56sfhI5XHkXn0rvU0SGkhFxQ8hG6r0eHEzBwfSFDKsO93rCTZCr5Q3dRThfJiZZWnkQOxEvMdklZKisy2ZePc9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoVQYJ+iIidhK/P/Vegn6IpbylrT2LFG103h5mrY83w=;
 b=W4MLfU2klOhYqLxrukoFoBYm0Op9hi8AXqzSId+UM9n6FbnbSCb7NZjc7yhLYMHqqQ794ljh9vOZWE84arpaEaRRN+C1XsAgDyTwepXHz7tCRywPAjYweBMeuCnQbK2ZANpgsVM/4kARk4jhreInEBTaH/E3ignY2lV0u0gDn3g=
Received: from BN9PR03CA0274.namprd03.prod.outlook.com (2603:10b6:408:f5::9)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:43:29 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::75) by BN9PR03CA0274.outlook.office365.com
 (2603:10b6:408:f5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 11:43:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.5 via Frontend Transport; Fri, 25 Sep 2026 11:43:29 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:43:24 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 3/9] KVM: SVM: Save/restore FRED_RSP0 for FRED supported guests
Date: Fri, 25 Sep 2026 11:40:11 +0000
Message-ID: <20260925114017.2208531-4-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
References: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: edee89d1-f432-442f-6d6c-08df1afa3823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|11063799006|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iDV7kLEHzXueZF6JqttZE2NzYZxhUTmQ5X83P6JrbrEHYK/GeL8cWsjxRUGTdAF6cFLmDLbfjpngUZ+cgjpwxDwmHkfLWKhb2bAFm5k8ZOJ+C8sYc+Lv4lJAGY6qIOmWKAHWMgPXurWK2ZMaJDyF63sYoDnO5D9Bz3ZSIznIe80czTPoCzooH89C7Bxh7Iu7S4W4mfljLIoSa6Myc9bORmX+Kjjwm6xe6icCke9CrXa6vykrEYilGYpSacY8J2HJ5Bu9fHKDvy6Zd7+xsUHGGpk8tyLfezf++fTvaZPZ5JJLvXK41XABGDdTTSgS5o4WOet1l9XQjmuHMbV1XOh320/UGvAQrFGvf3+aNOROdanwTeeKW9jIyKydn7kCKDOUB9iJ1o3SZVDmRSteXjp6JJXmmuefnLyHqW1MzeEEtWaxa3px19yTSkwp5QTZ3T+EMbskyR8tTopDhFWXLybzRMlRmxWiWslFTke6Je1+cEvumqmWiTJFCvwud+3dFJvpIc91vrQXIWPMlXafs7JbjjkDvhMtziMZ90s8i/4+Ovx+eWOAJVOv6kB+eIBF7up9sgH+SHn47I3yxukfrTWnSUu0e/ZFCrVO/Hj3O9txysOD5Cr131Fc/JZKQq9YurGGhZO7tazD4RMSwFhCfsQoXAgKyybM42s9CY6VRZaTNdWg+6vVHec4aL0x5YDk533a9EJ30bMQJ/EH3an8W/KCiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BUJq0Vj8iIwR6u1FTFWq5U1C+vvy5Pzs3PzAAPrfe5wfze7Y79+XF2mdWdKVx2D5iSp/M08mZx5IEOJ2yABX9X0EV0nE/maKWr5rRiMyrJQ87OywcTRNZZtj3ymmCQCv/ZrP/Z1pvoAyZtF5CmgZAG/rYinHgD+Xdaos1ObClvZ8bo8zHyKI4alYuKpQ3R9o3K++hm8RaQcZp4rZVwis6Jik2Jm74LklLJ9SaEldvqzcR5NwLERBq9uze6QqMZ9tv6GAAVyqOZJflYRRYhO0ZjU1APWqaClNqE8+z+KKN9aD7tqFaEZqDyXa68IoO81i5vFMkxFvJ6kTPNutQLg4evQ0dLPjpjur2VqHV47rL+nRT+G8kHTMfZZwP2XnTebHNOI9p1LunWWYRF2LiqxcXDNM3XtM427v2GPqV7HJ47GwFEDeG1v+kCmBV8V392P8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:43:29.5451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edee89d1-f432-442f-6d6c-08df1afa3823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

Hardware does not save/restore FRED_RSP0 for Non-SEV-ES guests. Save it
in svm_prepare_host_switch() and restore it in svm_prepare_switch_to_guest()
so that the correct physical CPU state is updated.

Also, synchronize the current value of MSR_IA32_FRED_RSP0 in hardware to the
kernel's local cache. Note that the desired host's RSP0 will be set when the
CPU exits to userspace for servicing vCPU tasks.

Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v3:
* Keep the guest's FRED_RSP0 in a new vcpu_svm field, msr_guest_fred_rsp0.
  The VMCB has no FRED_RSP0 field for non-SEV-ES guests.
* Zero msr_guest_fred_rsp0 on RESET.
* Added the svm_manages_fred_rsp0() helper.

Changes in v2:
* Moved FRED MSRs save/restore logic from svm_vcpu_enter_exit() to
  svm_prepare_[host_switch/switch_to_guest]() to reduce some MSR accesses.
* While switching to host, added a safety check on guest_state_loaded.

---
 arch/x86/kvm/svm/svm.c | 28 +++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h |  2 ++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e212f53d262a..c1263a3b3e73 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1234,6 +1234,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	save->idtr.limit = 0xffff;
 
 	if (!init_event) {
+		svm->msr_guest_fred_rsp0 = 0;
 		save->fred_rsp1 = 0;
 		save->fred_rsp2 = 0;
 		save->fred_rsp3 = 0;
@@ -1458,6 +1459,11 @@ static void svm_srso_vm_init(void) { }
 static void svm_srso_vm_destroy(void) { }
 #endif
 
+static bool svm_manages_fred_rsp0(struct kvm_vcpu *vcpu)
+{
+	return !is_sev_es_guest(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_FRED);
+}
+
 static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1495,12 +1501,32 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 		sd->bp_spec_reduce_set = true;
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
 	}
+
+	/* Hardware does not save/restore FRED_RSP0 for Non-SEV-ES guests. */
+	if (svm_manages_fred_rsp0(vcpu))
+		wrmsrq(MSR_IA32_FRED_RSP0, svm->msr_guest_fred_rsp0);
+
 	svm->guest_state_loaded = true;
 }
 
 static void svm_prepare_host_switch(struct kvm_vcpu *vcpu)
 {
-	to_svm(vcpu)->guest_state_loaded = false;
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!svm->guest_state_loaded)
+		return;
+
+	/*
+	 * Hardware does not save/restore FRED_RSP0 for Non-SEV-ES guests.
+	 * Also, sync hardware MSR value to per-CPU cache. This helps in
+	 * restoring Host RSP0 when exiting to userspace in fred_update_rsp0().
+	 */
+	if (svm_manages_fred_rsp0(vcpu)) {
+		rdmsrq(MSR_IA32_FRED_RSP0, svm->msr_guest_fred_rsp0);
+		fred_sync_rsp0(svm->msr_guest_fred_rsp0);
+	}
+
+	svm->guest_state_loaded = false;
 }
 
 static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..581289cc6e0b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -362,6 +362,8 @@ struct vcpu_svm {
 
 	bool guest_state_loaded;
 
+	u64 msr_guest_fred_rsp0;
+
 	bool avic_irq_window;
 	bool x2avic_msrs_intercepted;
 	bool lbr_msrs_intercepted;
-- 
2.43.0

