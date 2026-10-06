Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7846C4DD;
	Tue,  6 Oct 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305734; cv=fail; b=YuzhyjIQVHwhMHGeT5WrdTD22AArtoG2x4NtgtWRp7rbyNYDEhqlrYk13uX+QJRsuwLR+0JHmukabhhQmCSdR7WLrsE2NXsXfrE4AgRdEkie/eo60kht8yQKWCpkQ4Hdj5/KFMAM3FDLBdCoXJ0lUtEgQPbG8n6SzPjJGb7duOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305734; c=relaxed/simple;
	bh=T/c1vE4eAJls3gTgWxsf7igFIKFdrSYPB/Rtop9gQ94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCCOV3CGve+OxHrUvDzoP4Amfms/FfRZ1X3UjWJUeP0g9mR/XCt1+uuf44NINgH4V9z7bnKrgWcH5Cg9TQH7RTN41Pe0AaUbcRb8K1CIuPhzdO1tAzdrshz4Y9Si9zJ/YChZDyfrKoiPGa5a1KLm4DTf6ST+Ly+Go15xlKokFCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ffcoa+5h; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ffcoa+5h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbA8wkNxf7bDXwizCQ46TfDJ4UsGvW1y0BcnbjiiXCPXohUiO6EGFaM4TgUac7a3hq5bOlDoHdxesSuWKp7OLuCkrtVc/3d28ylFICNofHpMoO2rcJI6z8P0nxaX7EzL3lTRmX4yYo7euJXVPgNV5k5nkn+eymjVNcIv8he2EAsr1vNPfROfqSALnKVFzanuHfgVp/R34E64ESug/s19XmlCo+nFkXLuSEsmOliZbWZB9vFKuupyAs/kFYhI21T88Aiip04I4zF8va92CcZ6IjNQ0ZH3zHt0P3XkpMvbSonmtZ2lDhP+/wB8RExdJIx5Fg1vZ21G9ak7iq0WUqWZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f24Zf06aaul7+NfH9q/sNjKoCRiT9f3pFPMtOW4+Ro4=;
 b=M2PCX10UZ8q6Qq8+g9pbmmAfIVVi7/xYHq88GzbQKpUyVyo7jsPk1diBqk6lTLXDEBEQqzOiZwiBuudNdvbX0PXYJzWozhOHsMxCwt6WzVZtlA7XD85h8B+4UgaYH1B2UiUoF5NeAczLWaG9yr8AW+A70tddREknFV++kTaNmTzxvsJdF9lvQot4KApFcaDZjQIVy7QzpRNUOCoV7goIcSe6gnolxWayLgcdOvPvyPTq8CyKaN9v/Tjs5VQw1DJKsFgZBDGWxGNjTWIpXfysc7KMWaVNH2HxlMGWOE6KskR5JLXpHLgr11aqc/5wm5tQs09oVCsPbiTD7ALbwduVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f24Zf06aaul7+NfH9q/sNjKoCRiT9f3pFPMtOW4+Ro4=;
 b=ffcoa+5hkzLUlmd1Ei7fQRpRefMrDeXiK66Ev8Dm10P+HkctIkvY8w3rO+vOgT7PYXyC63pfbL6pWXcW1/pdeB9ujkByxUdzKpcfqmSmYJkMo4A5WFHIG0bc68321oQB5+3lCRsC7uIs7iceEjQF/W6W2vey1r7z3CC0baDYcsU=
Received: from SJ0PR05CA0198.namprd05.prod.outlook.com (2603:10b6:a03:330::23)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 16:55:18 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::4) by SJ0PR05CA0198.outlook.office365.com
 (2603:10b6:a03:330::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 16:55:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 16:55:18 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 11:55:16 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v2 1/4] KVM: SVM: Re-queue events that were never injected
Date: Tue, 6 Oct 2026 16:54:58 +0000
Message-ID: <06cc309d12d59aed6d4b36688d8ef37fe8b089ea.1791302373.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791302373.git.prsampat@amd.com>
References: <cover.1791302373.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 245c3005-9fa2-4992-3a73-08df23ca9a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|56012099006|6133799003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8+FV2iyoQyVwWDJ9h1S4R8R8x9qk0iEgm8zpzJRZWlnePfiSsM9gsxJYMwm9GcXMvkQ8YMy7J8idHSKFB808Epkf94JLlBjxsfz/NjH2xObAQJYU982uwMIJD44XsMf2rwWQYzb8C9eFGOORJ8C+MeDmnyvXrcoRQW3GMmcaRoyHBWEHUddTxEBHuVEUVIfyxxuD/wE3UowDYER3et4oRPIlb+h6HaOHpjSlUWbZiJ6yX56SBYjl8IQJqUexi8PAe67b6wvq9PkWjmdqnEPTrHAcVCl420lWvPvUG9B06i8GxiFheo6sFBbdvAIf8zyzZ2IBB7Z/VlOzmrWoSBdV5ckqgflviUPMgfJb+SbFhuorDnG20XduOlFakIqkP0tBIGR5RA08WfYtwi3fJ+apVlXc2uDoPyzOo0uxtU+pRMZ9csRXyIqNTD2XiMnJiZEBWwy4rH/ppThs2NkWgKoaJxLWhPnuTukgLCVVy6rSei7E2WCzED33o8cRZcjs5czYJ1i7rqoTnRpI3IDjA/YSRKxmDnq2qqqJQfCMdAtUT9m4Ihes91XTPFUZcGP1DPwMA1l5+zOdSXYtTPipby1/ch+Yxh9GGRu5FXyzBuZlRCJVQOF7hRAnyDtdYWGYKUFQ75c60BThXF7/bXPdb1whaUF8cGpnfQclCexMcRjgGI60+p1CmnGcjcZRXaUrxU8r
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(6133799003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nwV0TasQ75WWVNzvJ8Tf9s/Tf01r4jMMTTdjalnDUWCi4MWGi2CNsFrYpbcnJI2gZ4D5UBL17vJSrSzOzkefHIkG4ShYGwgKTwB8Fo5GWfIYLZGUM9iPZ0Tfl6Ah5JMGJ9X9huS4mnt9dWJpEaSwxALcmGcL0DsoJuEKF9uHppn4Lym8U0gwVojEJ4i+KeK+kKsOLCot0LF5+NBQYytmB3pB9rLiF55qpL8cPBHfGLSuqT8O57Twbk3tdI/c2okhc0T+3/XDayTDRcALc68Ems+f4cx50dHqKdyLLq9SgPKDMIIQdXUS4NvYMktbNyJ0uQ57xz5APP6O8bwbUP3DEjGZETs19GI4L5wzHIRvBqjbajkPq/6FXdkVKrnA6zgxdRJeZStTFEwQYzpCgoagSA2ozmOfzJPRyMudW6ex0/JPZRgbaWzGhXiaHsBoo7yc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:55:18.5200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245c3005-9fa2-4992-3a73-08df23ca9a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411

When injecting an event into the guest via the event_inj field, a
non-zero event_inj value on #VMEXIT means that the hardware was not able
to inject the event into the guest.  This used to only occur for the
VMEXIT_INVALID intercept code, which was a fatal error and resulted in
the guest being torn down.

Enhanced SMT Protection (ESMTP) invalidates that assumption.  When ESMTP
is enabled, VMRUN doesn't enter guest mode immediately; it stalls at a
synchronization point until every sibling thread is either idle or has
executed VMRUN for a legal sibling vCPU.  If an ESMTP timeout / illegal
sibling exit / interrupt arrives while VMRUN is stalled, VMRUN can now
terminate with the corresponding #VMEXIT intercept code, without
entering guest mode, and thus without injecting the event.

For example, on a 2-way SMT core running vCPU0 on thread 0 and vCPU1 on
thread 1:
  Thread 0 (vCPU0)                         Thread 1 (vCPU1)
  ----------------                         ----------------
  Interrupt A injected to the guest             in host
  VMRUN                                           |
    |                                             |
    v                                             |
  Stall waiting for sibling                       |
    |                                             |
    |  host INTR arrives on thread 0              |
    |  while it waits                             |
    |                                             |
    v                                             |
  #VMEXIT                                         v
  Interrupt B injected to the guest              idle
  VMRUN

In this case injecting interrupt B clobbers the last event. Interrupt A
is never delivered and lost forever.

Therefore, in preparation for ESMTP support, accommodate for potentially
lost interrupts by detecting an undelivered injected event and
re-queuing it so as not to lose the event.

svm_cancel_injection() already recovers a staged event this way and
becomes redundant, so fold it in.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v1..v2: No changes
---
 arch/x86/kvm/svm/svm.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d59d301e1e5..5d15c706e43b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4340,6 +4340,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u8 vector;
 	int type;
+	struct vmcb_control_area *control = &svm->vmcb->control;
 	u32 exitintinfo = svm->vmcb->control.exit_int_info;
 	bool nmi_l1_to_l2 = svm->nmi_l1_to_l2;
 	bool soft_int_injected = svm->soft_int_injected;
@@ -4347,6 +4348,27 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 	svm->nmi_l1_to_l2 = false;
 	svm->soft_int_injected = false;
 
+	/*
+	 * Hardware clears EVENTINJ field when it injects an event.
+	 * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
+	 * mode, and thus that the event was never delivered.  Migrate the event
+	 * to EXITINTINFO so that it's requeued instead of being dropped.
+	 *
+	 * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
+	 * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
+	 * without having injected that event into the guest.
+	 *
+	 * Clobbering EXITINTINFO is safe precisely because the vCPU never
+	 * entered guest mode.
+	 */
+	if (control->event_inj) {
+		control->exit_int_info = control->event_inj;
+		control->exit_int_info_err = control->event_inj_err;
+		control->event_inj = 0;
+
+		exitintinfo = control->exit_int_info;
+	}
+
 	/*
 	 * If we've made progress since setting awaiting_iret_completion, we've
 	 * executed an IRET and can allow NMI injection.
@@ -4410,11 +4432,14 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct vmcb_control_area *control = &svm->vmcb->control;
 
-	control->exit_int_info = control->event_inj;
-	control->exit_int_info_err = control->event_inj_err;
-	control->event_inj = 0;
+	/*
+	 * EXITINTINFO is stale as it holds the event from the previous #VMEXIT
+	 * (or from the last time the current VMCB was run).  Invalidate it so
+	 * that svm_complete_interrupts() requeues if and only if KVM staged an
+	 * event in EVENTINJ.
+	 */
+	svm->vmcb->control.exit_int_info = 0;
 	svm_complete_interrupts(vcpu);
 }
 
-- 
2.43.0

