Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794256542;
	b=s1RvdStsh79e6G8WO/3YF4c5XHwpN5E76OL5DZAEabviJ247KE8KXDpS6m3OMM1VcXmn
	 6v90IUTf2UnTL2LPyvvnaHXp9obX3+iEZrH26qQy4bN/uG/CnzL7v23kBTgSI2hGee+Nk
	 Am3+bqZgKHiIl5HD9d74lARc3lhb34f36pFnK/EkHEYwQnmMp+LcbGc7M/4x+j9fNZfQv
	 bwVe0t07i7bchFAjj7LVFOaru1x1Xf7i3LTYm+IHngIx6eXHbdOkXvrb5TBzsBKoEY+Ux
	 VHQWpPVjA+Ct235DUwVekgUpWULPUzJzCWrbCkCvb61kTbZBpOwSlOXFiMFiYMwGw/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256542;
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
	bh=AvxEkNz+R0EKBMy/ZPWOUuzXEa7ygYF+AOyw0TJPs28=;
	b=z7o+G4me0SlrqFLWWggOkkgQvR+UEkRAK/voPCzBuUjza007e+fYsAtLgnzuY9DziSDm
	 oFxECVGWnJwzqZ+E++ym8PWu0b7S5hQg6ybimoVuZq+mCxa4SAn1ZOX9paQkuL5dlXBNs
	 X9ugl7hVBOUtNCDsN0wnKcSvr8UWBTk/F+boqzHvoCN/onRcZhZI6jphTrdvaFvZKup90
	 jDTGbTDs20cwxFjHzxS6VKVGnOUEC7S9W7gQQXdTcUdScbYwOyV4Js8IF6d2vj9MV0q4y
	 rnbxMpWsKLVH8UzNifhKaD1JExd4t4nM0rTSrggAVsEQAL6JoNdC8P4G/h574ZYSYvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ttObC6Dt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.35
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009E606A31C;
	Mon,  9 Nov 2026 20:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7009E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ttObC6Dt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAwFqWeFLuZdIe9hE8M8gnPX+qn7p3jhSKMiXalH+psgwbAvAgaiA6bPPMAKupOZxAfDmSmse4A6X2bs8XnMuI3hco8NoW5AxPO/yi2TcyHic6vFB/XzgpwCZcgIT0mkn/FhSivVFEhnlTaTuGJT8OUaIq2uMyZSDX5sPjMLbwFMWz+gsuwO9Xv+GC74xbA62VBH04/8ZqdyVCtkWtTpKY9UsqaSCjNyd3W8/uxMWex9R9eZ6so3/Vv4/bKYBmr1LsfhF1uCAbOAo5cUeYOjE8r2A1775JkEFTZ67beGq1zLr79EtJT5nD8/FxOZatlrkT1LAz/hsgND/PGXTYtJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvxEkNz+R0EKBMy/ZPWOUuzXEa7ygYF+AOyw0TJPs28=;
 b=AvG3dpOXdGWQfKCxeh12guqDGF7ml5wMaH18sKKQwPhX8E55ig8s3/A0UcJ67xp9RUxleB5524GpYpN2z30GhhtaxowA9res+irTHLoN9Rgx6iAzCcQLOmyWQ1fqEygL+CUsRFAYs/6gkvTh5Epnsu5z3Uknmo6/iNHtDIGLlPT9505Vzn20wBKDYrK4x0lfrfNSzx7LCYt+JWWoJzyRyGXIoQ8xoYXnV2sl+FO/gf4JRISrxIQwIaUjIAosiSLVlVUL8MkvxWOBiasqlU2bN12UC46R6uqOHvT+o6w8jeZARR0W6pkdQqtlq1TPM14IOb4VJADVO11HaRGdcanHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvxEkNz+R0EKBMy/ZPWOUuzXEa7ygYF+AOyw0TJPs28=;
 b=ttObC6DtivS1dWzzpyxU7YN5ww4Bxl3Feg991lKlzTuTtOuOGrjfzzbbBcf5+mwHzggdLpjrOLW0P/3RZpRQel6jQ6B4MG8FZaS4MSV/TI5xcsPvRE7cqwYLDd2BkmgOHfQN9LclxNRiW2obXsilOWxzZvFPK0wubCcdmtpdbhU=
Received: from CY8PR10CA0033.namprd10.prod.outlook.com (2603:10b6:930:4b::28)
 by DS0PR12MB999287.namprd12.prod.outlook.com (2603:10b6:8:424::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 20:35:37 +0000
Received: from MWH0EPF000D894E.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::7d) by CY8PR10CA0033.outlook.office365.com
 (2603:10b6:930:4b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 20:35:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894E.mail.protection.outlook.com (10.167.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 20:35:36 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 14:35:36 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v4 1/4] KVM: SVM: Re-queue events that were never injected
Date: Mon, 9 Nov 2026 20:35:11 +0000
Message-ID: <a523c8930e82f897d6fdfb4f05a283a6e2649414.1794244450.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794244450.git.prsampat@amd.com>
References: <cover.1794244450.git.prsampat@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894E:EE_|DS0PR12MB999287:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d42f1e1-8927-481d-be7c-08df3ea102dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|6133799003|10067099003|11063799006|261102123227099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|56012099006|261026121527099003|261022075727099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Htk1srT/L5Gm4Ip9YNXvUvJLDPAyl/t+lYtzzIXEBYzrZFC3uhPt/hZWEa4utrkjqq83oETbglVoUFitssHLAXzCdjNZ6Uq79WOUwpWfG8ae5G+7CgYnmj8gIkjDLvqx2JgTt/hrSReO6YiWpO9xsxZaa/7Ons3Bhw2hXT9umtk+EMo2RVLzUYNhSQPOajd1H7A+vZKOwbV/wk1GtPcVENW9U6qrUul38+NFVTJK1cvbWUCJGjb8el5Sd+udBwCoqr4xc8J5+ziEgd0GJCPP7g7+Rx3AWOSHHqZupciLIE/wYb/fi6UoWxV5sq+JsBio0Oqs+Ok704AKBcOquyoI/bpXLoke2LXYi3oSjv16rN7G1LoOb+x6voYhgLykR9RweD/JjhNPYWKyjCGN6VBesdz9mGhzCayqAMyINVyW0Ha94w71pTj9rBvUml4ET2CBvw5+Fih8MDEjOd5DIoAo81LSuPGDkh/XCWM8/9WsG70AE3ywmhfvF4tr8XO4MigLftnM8P1MPBurL8REdGGo05WvpkMIB1PkyELBKZNEBlSJ5gIG0J4ceZzHE7GcURP+rxrZbzf14o/myMyWwLM/Mp1o4dJb8m5lm3eHgCWKuzXqAkK50eOb8qJyPNOWNNsiameRZOVcVcZwFtTc9ziL0lVpHUBgtV29tjd2RHljTcvTiiwlqeTF5faJk/oQzQhq
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(56012099006)(261026121527099003)(261022075727099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	12U+RljakTsy2axzugOrnAfFRTXcK4U26Yz4pLkqbsGCK9PBBPYVRa8kf4637pHnQ4yQryDvvK5+D3+BPG5t7gSqdp//lKE/Af2E16vkqnFApa4OD0guP6KN9Kgp1xDENwhXn5OSp8ysW6wT3VioBho6iuo3rLamjUD4T36YAAOkSpnsUwEDN7IHzA25Gr6MXAcYWTma8x1c3IWh/xZsZjpz33i3hvgAdoYWWGU9ICgIkmucWS74sb5ie453EZcGXDnT3cmZTJgOzLBoECaeRK9KJoMWinf3ETDDNqzvSOEa/fBLhtw7Scq51DbSsrdJoaK0yGuIoY4FKhIF2BMb0nWWfP0BAfmW+0fpv+V0AKThJfzROrfpIjh+S28hPJCb500eOFCoyeA42UcuJ7EUtlaa2JPNGTjQvePFJXVe72equOwWHwYCDZeLQlXR8uqX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:35:36.7481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d42f1e1-8927-481d-be7c-08df3ea102dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999287

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
v3..v4: No Change
---
 arch/x86/kvm/svm/svm.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 581bc3a23c95..61e798d02db8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4459,6 +4459,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u8 vector;
 	int type;
+	struct vmcb_control_area *control = &svm->vmcb->control;
 	u32 exitintinfo = svm->vmcb->control.exit_int_info;
 	bool nmi_l1_to_l2 = svm->nmi_l1_to_l2;
 	bool soft_int_injected = svm->soft_int_injected;
@@ -4466,6 +4467,27 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
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
@@ -4529,11 +4551,14 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
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

