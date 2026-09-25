Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0593EC68E;
	Fri, 25 Sep 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336660; cv=fail; b=rxR7Wl1uPwgpU7kcMW/Lj+OQSvNEL4I42Mssj93GgforM2/vO1Em0yMdQkl1CIeT7xNmWlpbxgswlfVmOyMKN6EaI4Gm0aphDaEXX8I8kDU/Z4YxiuHNAeBib0c70BfJ3VEZQmwJgJjxhzpn2ksAuiYv/Ndma8qJqET0TIm0jAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336660; c=relaxed/simple;
	bh=O0XgjGqn8mATQ5PFgVxXQrDNMVgItNzIAjQSHnJOqVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCYoJwY+wdDulyD/p87tPQodns4eTCPICaaE9zopIsyFeLHSjBQXhyKI6c7MOA7upnZjaV1soobho7eHc0XPG0eP/iv0DBj7FXZLy1BtINA6FDM4x46cKwnw9M8uAb1avwD7/Fjkh86vAL2IXxpMmTjS/gr/pOBZySQfABAMIn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J50OFA0U; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J50OFA0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JA8QyUFhpaRwwDTZWQ1Ggomsg8FxW3t7caiB3Ek2ERZw8Ar1Kn9080u35IOu+LWSo/YxyjYbHsR8TJKBldkRxpkZeoIRPmy3JaNQkSqPHa18jdQTAlnTytv2oWvnvcoVsJtqgkFdpVuM3NzFkcutRlb/Gm8YDbZAxK0DyS+ZYVRzZnV6bLK6uw+CzYGAHNUIADmA249aPNF5xkFsjrLivN/UkfzE9tf0Nh2Gy7h4bdFyD+jm445QVrNjItugU9/KJQGFZiEcq9znI8eOsiJvnDJHTmDZDzvKlg5x1sdswoWn2+/Eif+gaAM1n/EV7OFEyhySneGWTjDSgTKbkYzlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsYo/acIyAjX9UsxSIzKbiplZwqkaH7uiCXg9AAkVkI=;
 b=DPC1VyG/dusuDmTKp2ZK6qGxzLiEMA/BV4Edq8pTnTw28MdG9/t7ZD8KODRhBkwx49gSr3dDbl0yrT7kfVDU5myQpmlVhzJPIhFJofbpRAw2t1i/nkaYV7A+uWPefcXF9Un2T14QfUnMhpQpCaCaNivxSkaqZRkM/Xchg5Bszg8Tc1TeaNFR0IIJ9y/wBNo7u+2ALgmDk1fo0BFxzwqzVhKihizTKJVakIIIAMWtYnHLrEFPK2FqIZPRcMtZNMWegXhKeSjWoI6+pfhfsLG+t45Y2Dix5VAIdOngYKsR1XvboKAHi+dsl1Xe6bX3vc2Xn8fa/TTDwusT+X8qyhSq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsYo/acIyAjX9UsxSIzKbiplZwqkaH7uiCXg9AAkVkI=;
 b=J50OFA0UqcI6KFESnKmgbnabaIGWf0P2BSmlfAUSizwm+covO64V6yR28ZFHl6ZQ/YT+D64P4yz92mob/XlppgDgSW/LzxejjySzLAtSushTg9xyBeBbA4KtowaZB/jzLwOGzkKQV5qAeLaWFBZ0XbwurjwI9u8a/67b3HJwh9E=
Received: from BN9PR03CA0084.namprd03.prod.outlook.com (2603:10b6:408:fc::29)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 11:44:15 +0000
Received: from BN7PEPF000000A1.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::3f) by BN9PR03CA0084.outlook.office365.com
 (2603:10b6:408:fc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Fri,
 25 Sep 2026 11:44:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A1.mail.protection.outlook.com (10.167.248.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:44:14 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:44:09 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 5/9] KVM: SVM: Populate FRED event data on event injection
Date: Fri, 25 Sep 2026 11:40:13 +0000
Message-ID: <20260925114017.2208531-6-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A1:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 3415cb33-4cb5-4083-fbd2-08df1afa5330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zdcWrgRDPeI7+yD57YxgNZWVPoKT88pkyk66dmQGefSXkS5JORZqD8p32QeMrbx3rOSGqi9c2TqCL9dJkmwn1FeQ4v5nOhJqI4N0/zgSrhfCnGHf+4kNz0eI40SoYXfIrqFt80aKe0v12nJ1WjuiApINNmnySf5WC1c3pgLKLCaneJFbdVLfQkwdSSyDZM6k6YD1sam1qglWTclX9WkJ5TE7eP/kwFCiPpUAf3u5pDGNxsbLjXG5oyJM7Q/ufW07ZE82+C7eTDlovl2MmI3u9cZTXLSUh5O8x03wvol6VlQfVcS9/VGu0fJdfYJnIy89TSuW1V9kN2wXxxallxYG9JRGwA2bMrva8t4PzVX/6YKmLqAR2768WcjNsEOs5tmEEXpWY7KyUGQPpBRMWXI9+Rt3MiGv0Hy449qzqOenlVHDBMWuOzdUGXiqQPlro9eg/NvApJaJO3bW9A2zoKoDfQ5Pi5sba0737aIiTDPvalTe8vVKkQVTvspkFF/HzPFxfHO4wNfX4WtV0OYG9JguNfn5DEUMjEIwjdyBFpEmuNSJyzEjhKapNLN6+FTYS7aPPppt25twjj0A/C+IqB/xfD7B+iw2P7wy5CEgVjuulU/wrZ6nE1mK0HK1BYnJmGMPf43QjlFtTRHhfpJCNVa1xxdo/pw1rEtCAO5JzttJhQchkg5tUKv9ufgL1ghFcRaVQe82mOZASH4brdZdr82BPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qQEQRqhbkcPR0a+Bx84RQipNwsYvPhx62J6dPKJZGEP5wWfSi7oGBUcHYW336euxAnFQ8bRtceb5O5hwVV2OROd9FJiU3xWnf5FQSglX/nkhyiX9MdhiTQpLJHfetV4aOC5tkb55S9tp3gi5gjQNXcXOwFTn1WgiQFhrFYeecHBEEz+o6/GFOZ/pu8vmkTiv7yr4rzABoFNut35fchixfOjDQs1Ixl9x+53uFeUYxrqhjr1rkp8mcVPHUUla3V9gLDwKn+usNKd8bEy1elcLbeNtnLd8jew2cNPRD0CNfNUijGWmWUUFWVAOkcMSwgqZ9raH8/yqJGMvXDu8X9XhiD6dRLzZAYAFqotRp3VGW5iuuhDDl/qbbA3pPH+vShC+fx33MMRrit9yZG/MNL58BMrEFeFdJNGCsHgM5/M94AxjSDEoD/uRCq7OQvRTz9DC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:44:14.9340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3415cb33-4cb5-4083-fbd2-08df1afa5330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Set injected-event data (in EVENTINJDATA) when injecting an event,
use EXITINTDATA for populating the injected-event data during
reinjection.

Unlike IDT using some extra CPU register as part of an event
context, e.g., %cr2 for #PF, FRED saves a complete event context
in its stack frame, e.g., FRED saves the faulting linear address
of a #PF into the event data field defined in its stack frame.

Populate the EVENTINJDATA during event injection. The event data
will be pushed into a FRED stack frame for VM entries that inject
an event using FRED event delivery.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v3:
* Rebased, no changes.

Changes in v2:
* Removed the need for a new function parameter 'reinject_on_vmexit' in
  svm_complete_interrupts() (Paolo Bonzini).

---
 arch/x86/kvm/svm/svm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 72d49c6daee7..6c15e8480d25 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -401,6 +401,10 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 		| SVM_EVTINJ_VALID
 		| (ex->has_error_code ? SVM_EVTINJ_VALID_ERR : 0)
 		| SVM_EVTINJ_TYPE_EXEPT;
+
+	if (is_fred_enabled(vcpu))
+		svm->vmcb->control.event_inj_data = ex->event_data;
+
 	svm->vmcb->control.event_inj_err = ex->error_code;
 }
 
@@ -4478,6 +4482,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 		break;
 	case SVM_EXITINTINFO_TYPE_EXEPT: {
 		u32 error_code = 0;
+		u64 event_data = 0;
 
 		/*
 		 * Never re-inject a #VC exception.
@@ -4488,9 +4493,16 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 		if (exitintinfo & SVM_EXITINTINFO_VALID_ERR)
 			error_code = svm->vmcb->control.exit_int_info_err;
 
+		/*
+		 * FRED requires an additional field to pass injected-event
+		 * data to the guest.
+		 */
+		if (is_fred_enabled(vcpu) && (vector == PF_VECTOR || vector == DB_VECTOR))
+			event_data = svm->vmcb->control.exit_int_data;
+
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code, false, 0);
+				      error_code, false, event_data);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
@@ -4512,6 +4524,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 	control->exit_int_info = control->event_inj;
 	control->exit_int_info_err = control->event_inj_err;
+	control->exit_int_data = control->event_inj_data;
 	control->event_inj = 0;
 	svm_complete_interrupts(vcpu);
 }
-- 
2.43.0

