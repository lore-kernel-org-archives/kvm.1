Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187011EB1AA;
	Fri, 16 Oct 2026 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187672; cv=fail; b=s/h96/bJ+jHnY5c5ULj4/hpIRXXwM42ou3j+bsYiSZKymFg/han0hNCjMWlka1Vr62tFaEvw854kXF4uDq5U/4X3CD83TsPGrbAAiJxJFNCQie5XZvP8/vHnObW3XYM3JJtJw9AS3e9n++3o6gY+SMOrsugl0dgx8fS+/aXsgXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187672; c=relaxed/simple;
	bh=N+vmJmZY76JLuVst3v93gFyHDx4xu+00a6OBuKQC470=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V79qRBQVuizj9US/hVlbb7abubxtoNN9Wn6oTyQNys3wK2I623G9NDSbmE+G9V3iLtuIiGYh3+2BffDlIwEsJ5g0k6kY8v4w5pbiQb2Vhp0EMKymbV7mEPo+WiIu8Hlj132ER7jj0kQZdJemHN1vCbzAE0f7lY+sKDJUYVI7P6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fOjVtsjV; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fOjVtsjV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vu8heMZzvOvWM4prOP89mD7XByuqZOapoHiIMBcn6eGf+yW/YY+bhGk3zmmLC+66abThP3aVWgFD6bITQ+eTYJ67O7l7kE4Vr+n71eQJsDUFsLHBKM8huYuP9A/JDAEson/h4VubpiIgVuAzSoXGoryNaDDlaOo1aPf4iF8en1dQHJ5Un2uJkitjjeaH+e1Tp9el3pD/+PSDEapNmyPx1K9/aCzkvenEKNhPjc/1qg091PUtq9N9SWUOHUXGrA/WnhcT7tLd02x5B8CjiKFZD6rGW74Nl+mRM+xcdbLzN7Yd2mcu+TWBuRkRK4yfE8LAmDxyX8Wbf7gi5690gAL8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGVCcHwsmajvrZHU63BVW0NKBhelIJJK+WIPVH/X1a4=;
 b=WI75TR/2ZKwFLgVcIuQorr1YDcXqeAiWT8Aq9IlCth2d1G7IHItEAMg+uSG90X3tmxjx3iI7PplXUxMXxiPNkM7axYlka2WRgBP9GSfM0QaH7nhLiTE+vI4GouFfImxXsNkgrPXEG50bus9jLVdqHhDXIzH5QBLdQ41cnNIO/mjhLDSugyz4VAmFAFtqpwqHkNd2hJezzmIHUHwHP7vQ2NlxluF/hXfdaYV43FIvyuWjDZzMHd4B1Cn0fXYSDtTAZM2coDB1qj9RtLrfcmmwYpa+ZFpMReZw3w3U6/JvCqBh5WZTV/woO4PyVn7xPWXZg7iPTbPymzJM2V90EGQrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGVCcHwsmajvrZHU63BVW0NKBhelIJJK+WIPVH/X1a4=;
 b=fOjVtsjVvuF6V9JmSU62Fq9wRFXu8q/u0BGWbHH0/W4U4pjlAmW8LH+/gqdZKSkMSRWu4+K0je/eTr8FphNtjbVEU0z6i5DjxkOYZEY3PulLwBfC8wxw8yUWDZBNINWiP+DQlXjxBiemusRTiGhFM7BqSwIlTaplkHlc6VtwbgM=
Received: from BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 21:54:26 +0000
Received: from PH7PEPF00000008.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::81) by BY3PR04CA0016.outlook.office365.com
 (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 21:54:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000008.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 21:54:25 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 16:54:17 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v3 1/4] KVM: SVM: Re-queue events that were never injected
Date: Fri, 16 Oct 2026 21:54:04 +0000
Message-ID: <905ffc25da83b1af51698fe4544d361203578a80.1792184487.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792184487.git.prsampat@amd.com>
References: <cover.1792184487.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000008:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c8d36c-1dd9-4fb9-634e-08df2bd00b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	J+Gbi9FKdVQpCfmDuZ668HIZdxWELRU3DXXhjWePMXsplNX+YZTk9IjBRJXT0vGEnnoxCgxSsxGlvs92yQ5Nyz39EjldD88PgXpRJVNJ4GDoP0d12+v7pFVTFvEyX8tuWMgvUV/+V8VNJvez9e69MTdJ/Hy3XUBAEfd9RE5S+EUIotaJ2IPeUhwyvgONWX2GtV6dYr8X9sAwNmWqGN0HAGOtH7QUtQefIMFCvJqjKiOoFmB+VtIuiAwJLzbrC32VMqTRY3DymJejsT2h8TsxVUduGaq5J2bS3N2GQZQ8XWSEqCjLxotQQJCYqQjLILdtYrsyuDrG2DDQpm95SurczH1HgosBeUKD7HTWTH6wL9RczdSF1bouZtNtixqrJyIOaiMW3sG6XPaB/afKszrE/WE+vWNnucUnUzoBoxSbgUKbyRTjH/0U4AwPIXmmLZ2NJaVS/2YUS3RVcE5wCLTSTPRN+57EtJEeTpUXlab+kthR2yCbG7kHU3M+UM0ZW1xsvbEjGCK63SHTL5zQj4cDFjlkt9NZVvFO7YeekuJl2u9OFLLD4KCL2vXJB30IYz29zRiiE5VD9qF3EBf1HLWxMxk/+ViP0KIhskrJi7arrdchNEybDG7MG8rdNRTimyNKIsP/d3r/tvMEVCRTWmzx7Uj2J78l5F4jQJgGZo7Mjyw8aB2AlqsFctc3ydR4SO0b
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fpVofqrmmfo1xCah+jsEwb4AghVvHbeL0PQN8lFrQe43Z+BiR/e6DycCN7RFBDOCJb3mD3+mZTOWYrtqE42ZKFYgA/BLi6Wbbzl+6kOiOwTzPLgOThFeVMPO8NMgMZQy+Ha862RpfNfs/xoSsflRJrAqLy8NAT0exG+DyxvIC2Z4TUTbPTR3b5cAoNTJm2BstX6184wkbGX/QMxjRMmZzL5QYvT0h48QY9kv36rVzzt94yz7p8J1lv6zRiOkAX9lZQhVqvLw2dbTKM69Z3pt6BkJI4ZiodTrkwPuVukDOd2iS0SoMuY9VlYR7cSEe5wOszz7+Uu1roIylH+HCNkTsH9Z/1OX8+2HNrGj3x0IxqiYXIGCalHsOH6QVnt8mcCa/nSkdiaA89TXMfnTqzP4R1BeJMD+MXRk1Y9GhjA9MfFV9F30Q3YReM+y6Sj8Kk+q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 21:54:25.1994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c8d36c-1dd9-4fb9-634e-08df2bd00b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000008.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

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

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v2..v3: No changes

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

