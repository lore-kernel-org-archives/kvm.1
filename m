Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B5368D78;
	Mon, 14 Sep 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404994; cv=fail; b=sAO9hYF3OwP0Ug5In2FAMKwNRDWCaHgKkQMcpqmSQUpAO6Ql2CIQF3aAeFG5eHevHPJFAhRGRoR+5I6/MuGqVmW0UUWD3ScJ0yd2klH0gAzc+w+NH5TTwSiKZE9QMQ5dJOfExJwe2EyXtEBSHY8ftVxEX8H3D7AbU8GIcd9t9B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404994; c=relaxed/simple;
	bh=Ui7VIvjIV+RHDSey7wNahJIkWEm+xamfVqsxqbqvimY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scf82XYDDV4c9GbsT9bbfBOUmfkInGLVBuoy51HRsGvxV1a3pQHWkHFzykBhrGbWStQIGFFSqfdTlYNusBz9TaA5Hpxbi8hdxTm6OYD8DnT3Fq/93/rnQkm9EKw4MLSAVErZ6OZxA8r/CbXlh1ozJmgyFHeVkpz5El5MMi/gj48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIWqtENc; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIWqtENc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K40+FtOMOes/IL266q2+3b+SVXwsf3rGLFH94YCHGA8NrPEmMkyE7eO1dt/zqXhXPT/EPRVVaK3BONmXkPmkV1qIGs1+0IaGxwIrOLjSo5L0X867olK6pA1fPqtOoKG7G31055DTTyA/YcOear2CH2dHJ+resBvcQnnD/jqsF6sZGfGKh/tUmfIpGl/29e7bjAWDJhtWvFPL+3fbJbfALJIkxSq4BQG/Xb+oaADrjFoaCKgpnaEKqwz2LwTLTQ3/LXb2i9FW3D9l6K4B5FAoRPDLyX+YaW+M8lsmJRicONTYq9Dgigw2p/Gza02wxf1nP0nuVwdmbi93CHjACi9i/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR4GnGANxOd5rtPRsfK2P5S+Pl1hIXMDS0UXM5ecoWE=;
 b=GYGJ48XV0H2uJ7F5wuXS2tCMJilXfhF5wzRvRJH3OtSWChNV978TkcOJ0XCKsXcKufWLyGBdhhrFkK0j2+26IQPQGOWvbZjuQHXeYgaOxgH5MjbgJN852+yUagvub7tTBgCyn8azm/34Nl2bTVdbf+BnKRoA1tcdrSqDnoVUtpQa9cUe8sizWkzSphCgE9EGfar3/BkkgC5EsqHNiiXoBEUbhptCUau2b/vhvCcZiniJOu/GEdUtuXakcn5qWuohc+/+2kiUfciyTFd3fVAQFB3cqSigWSS3jA68s+d8hNaOBQWTIqpE+2642NvIVhtOFqlfOU5qKpePg++p8g2EYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR4GnGANxOd5rtPRsfK2P5S+Pl1hIXMDS0UXM5ecoWE=;
 b=cIWqtENcGOmbHiym2cxuUeNpz0YNCC7Whhix+C4OSYSJ25/39ZzAPlGV4d4MBw5wb5j6c/MWz8s13gRP09u0nankXLz2y5ZgYa3GrsyxRdDaEwmH+S6ED8M6XPGUZq6dETzExDpuPIRLF0L7G9Qry2tbDvv/oxgADSy+sxp1+BI=
Received: from CH2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:610:60::17)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:56:20 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::92) by CH2PR14CA0007.outlook.office365.com
 (2603:10b6:610:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 16:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 16:56:19 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 11:56:18 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [PATCH 1/3] KVM: SVM: Re-queue events that were never injected
Date: Mon, 14 Sep 2026 16:55:54 +0000
Message-ID: <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789399214.git.prsampat@amd.com>
References: <cover.1789399214.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: d3af7068-ebaa-49bd-ee0a-08df12811933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	s9Ga2uRbRcn5Gc6yg13SSpGu/hHR6kJh1XfDW8Kvei3jHRReesVp9bXt+Kul2ibejLwpr9vayt2/Np3+nmoCHnJxSqbLGzzbvFNUpaUqibZQXRIVYjcHoINDPi2G6oGgwmzOob3iPM7IJRDTcjoHzhwK+vA94/XyKhYCfOYiTY1VKLaEvmmISNeSkraD/YM4lgWZmKlcoxd4BQIPAog548xTIgLT0pV8xbDJ3pfVZWqyZtQt7FW6Dm8OMZbCBlUj9slSWLMEKgU8vGrlVQhsJMfOy9YvW4a3jsX5TfA5TBVnSFDYgFn6J9uS78WZ8sqAOJgbTCdA1AUwEM7CHVsyu52F4a5cnHZSz+1uVQJZt6QmTU8rlwRkr2kM5zVfvndW5S6h7mhFi2G8xyXPc3El+islrbk4Q0aEtKI+eB6IPiaeqJi75sGl3PT6odD0Oe4TlgXQSHM9PA5OSu/lgwXYtaqgIwYz+EHLY5E7+cdz8AZLIOPbJkcQNcDKBMZhbMW91Gzvrll/OZrN7OvQaXe85r0qLXzrsSGoSud29x672LIXHa5Zgx29ZHQ5jc+GO3N6C8ogNCYmiYiGELpKkb/JIgAdw/Q07OO3IdXHEmVJOwkdK3mHK3B96J6j5X36umSxHNAxG/vcmpgVaLTQEoULAlkXruDSqwBARIn18Ggx15APhaCxA/4XVugmOMJrFdObkALywcopWmAbW1q7tyg6Sw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NrKEGPwn5k3FhzwU7qza7aRiwntB7TKKgKg/m/m6LLUyLhf11JLjRtYBODxOplAb+lnWfXtjldYKw5YJ39gzCorf9w6BESoy8Q+61hgbz1NKaVmg5QBSkVK5EXcpX3VK8OuSlxZjVjYpq2DxEeQtWtRARacVywSlsBDBeS6kQGNwW38RKAhg7bDoJ902xFLDORPsoSE5AtZVdD72r3n0scqlEVk18+RD5SgCVCo8TVXfqGvVQPWBziAbmHxZwOpwbqUWmTjG3Uy3MqGVJzidz0pdhTODPH3Fzur+G0/r2EebgEa6NJ3c86lA2NjOJpj74pJ4C2WUEz65NQctZwJto4Hlsot+rVFePO8GAxfAzaUcPCwYBI5r6CerxgU79R5JmcNXpD5njMR7hBpIsIMo0Z0SlKDEC+qES2m6/CVyTB6X27Hq6h39OYGqceLHzCXa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:56:19.2376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3af7068-ebaa-49bd-ee0a-08df12811933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

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
is never delivered and lost forvever.

Therefore, in preparation for ESMTP support, accommodate for potentially
lost interrupts by detecting an undelivered injected event and
re-queuing it so as not to lose the event.

svm_cancel_injection() already recovers a staged event this way and
becomes redundant, so fold it in.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
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

