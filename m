Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C17387566
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440849; cv=fail; b=LfKN8qe/M9TQKKzNjUgxjLQKxzrl2NhlH7Ggf4h5ILgeeFELOa6BSMkSFppirLu3GGHqDHhSaWfgnA4M/+wGJROAIxToTBRcbqi0x1zjTnu6Ioza27TY+sMnDzftYFc0aC2Xh54KPCQmeXDj0diwevQZnX5xiAQnySJCclgq6fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440849; c=relaxed/simple;
	bh=/r5qZXHbq0A3Jm17oZL9Yg42VZ91MgSOvc52lV2OUEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c76IjWcaY5Pi6KDMQP6zxUPDbNtePINFESQqltMPoH9kjJwsazy/cVFZTULZvv0TeiBF4fTn1tE1x03jQHTel3ZIR+Q7zX9qBZTOVxiHcI/3T6pb+EM9RMko3HA5MKkA9g/+NoBOXiSkVv9/z2br2c2f/1J0iOfTI607mg8KIKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TTcF1pug; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TTcF1pug"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiiT7FXk6kMDeQpQoEh31ym4aQRSzmT9gM0TBF8LvRh8iGjN1xSfsPJjOTXsSb3kl2lcZ7h22NzyfSQpIUpJMTxavSx1eWYSGoP6F+RJum/lIbBUhs/htOknLwuUReObz0KszgxHuP2yvtQVIXQpb6FOM8zbY5A+9nymlbx3sALN+XQXHscRUpc2WUNUXBbNxcW9VjNY0qezBcxldWw/Eq2gFMjk1/xO/Yijd7mjkf0dEJE3zauRX23JUyTG36XAPZmgYFiT5eK051Ek84eKkkcbiGtKZlcJfFTkQ2b6fPhhldb8O52JsOwlc91XU5GbABUbbKSmtZcGW5q4yH42Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy594U2nuqwQW37tR/MUQDOOHUA5oaXAxCxlmtXvzPc=;
 b=NJyQbFl5UCppL49kgZU24TTggcTqibZ+y1PzNmTvdAaQ1GRFfNrAmkwZRbY48EbsT4A8cclyTJ02W7GHZcgbc/O5e/YM49nm2/oIJFods+Zc7Fah/lkV98ZROr46YnV6Xvy0QCuEJqP+oZvQZqfRnCvXFLdlKKZCVqREmenaRRlfhXFmgFbI7zf2wMvxewHrq0FSqBo9b5eOhgSIrc1my0jbBWIvwzzp3YTqoZs9ZO+K5Ee0MMLD9xFVrBi4XMEm4p5OtSwfKinfpHgH4zNvqAJo9XqlNG6IxEXU7chMS7Kq+hd16thkV02sUzIJL4qW1yjwIWIPGU1/QurhZT+V/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy594U2nuqwQW37tR/MUQDOOHUA5oaXAxCxlmtXvzPc=;
 b=TTcF1pugD39InPb7simeT7gFqeJxlRZPxur9xwyq9uiJw3thOwIdSf4lHC9ptpXF32gIW7jOVzsQC1lmdg2XGktv0d5wE1qEETi5acNFl0ydTwPpzVD5DM/+eBZ5spWD6pAspY5vwVN3s5OOX2DM+Rk0ysC3OWy4B9tCCOtCANA=
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 06:27:22 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a9) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Thu, 8
 Oct 2026 06:27:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 06:27:22 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 01:27:17 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2] KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept
Date: Thu, 8 Oct 2026 06:26:43 +0000
Message-ID: <20261008062643.1183018-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b0a45d-54ff-4ca7-cfd0-08df2505361a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|13003099007|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	5TzC1G2Q4xkMn3LuFjVS4/SSnIOrCVJUvKbh2D4X07equqSXFnE7ehsvKtH45KOf0ZGTjDUiFW9UJkEX1yHQLRCafH7i+Hi8CSBa3qImlVm3cYy3AnYHbLjsI3Ep5Q4DsKbUEnEXyQDdkaoGlKa2UEylhko6VnjQYiwf4HH9pO56A3yWNlvZ0VVqKBLwzmCC+c0IoLhx7Cqxkw7TPUpzq3zT+L0wFBAfyiK56yiCOmZtzn9PrDdg/O+Br72HybjbKj9hOl5/wTtjDsaRUgbcxXGgha8lV5lqCWbDEoOlEmyH/FMouk0gZI5qre9EIwKJACUmwc+sG/LLuFv7e2FYFtMEscMJCVsPZkt+5Q54dbCw6bpI/SDS3fPQhSzqLKXgrmnkMCpjZwQ0KC1PZRvMsm4djMIRaOCyWtCP7xIkkwENT0W7Ga0XsLQ/Okwvh32Bn7A85pnHPWc9V6shx8QeOMRSjHneL8hUpa7tThy7AfjhnoXfmPn9JbbjZEqfGODLB64XBlU0euR30SHcZigoIbPS2m+1iKynKC7KmZHSxmn8JekRuzPiRHCCdwD7OG58l+jFj0zomeW47iasJLzPmJstYWzvBlKBjkRyoZC/qH79E3rSple1RI2SeCb25oy7+9K9iR2ucmYMYxGsHEJUQCyMXDo0ROInhQLu6emB/1qDnWPGRcweEeRr+d/YhttOTuj1WsPqxIurX2tN5htSlg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(13003099007)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	97Fx9o5hj/wdARcFrpGCgNfoPe4v7MPAg1WXPt94rLj6Vr7oXXn/3cGXY9mqrCwAcfh9gHA5tiEfO5Bs6t7KSYfhaVRDWHCVkDxTq8WIGrYjzezQlvpSuNHVgrksHMjnZQlXHXHh5b3ycCrq676DI/VQnhX5sTNqqzowjO6tmqu67pP1twKDoO3QMs9qRVAy+aB3UFbMqcIvQIQw7VBsbzaQR1q4WQ33Uq5Ih9eI43BKj+maYmuHcQnfr3Oo/pv0wSrW2zFWHpnh6TRF5wPT/BLHiRUpBYwI8kri9Ca2BHe840FjFVGmPIh4TF+zYxvpgWiOATpnZuQO2iJnjA0xAQMNMMWVlsgWKSdNmCU2v+aGVWt+sWOxeKgdACcSryevx5D+0m0uEsvQioEACeHS6cy2bASgSZzchERlPRDQ7sX0OpOaKW8KtBWZ/DPZcCWS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 06:27:22.1413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b0a45d-54ff-4ca7-cfd0-08df2505361a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080

The AMD APM previously stated that after an intercepted shutdown, the
entire VMCB state is undefined. In practice, only the save area is
undefined and most of the control area remains valid. Revision 3.45 of
the APM now makes this explicit:

  "After an intercepted shutdown, the VMCB control area is valid (with
   the exception of offsets 60h, 61h, and 68h) and the VMCB state save
   area is undefined."

KVM zeroes the entire VMCB before INITing the vCPU based on the old
wording, discarding control area state that hardware preserves.

Clear only the save area and the three undefined control area fields
(int_ctl[15:0] and int_state) in line with the updated APM.

Also explicitly clear EVENTINJ. Hardware clears it on #VMEXIT, but only
if VMRUN fully entered the guest. Clearing it here should be
unnecessary, since a shutdown can only happen if the guest actually ran.
Do so anyway, as there is no reason to carry a stale event across the
vCPU reset, and the cost is negligible.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Explicitly clear EVENTINJ and EVENTINJ_ERR (Sean Christopherson).
* Rebased on kvm-x86/next.

v1: https://lore.kernel.org/all/20260824131824.6040-1-shivansh.dhiman@amd.com

---
 arch/x86/kvm/svm/svm.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..09ca864e5a38 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2213,18 +2213,31 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 
 
 	/*
-	 * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU to put
-	 * the VMCB in a known good state.  Unfortuately, KVM doesn't have
-	 * KVM_MP_STATE_SHUTDOWN and can't add it without potentially breaking
-	 * userspace.  At a platform view, INIT is acceptable behavior as
-	 * there exist bare metal platforms that automatically INIT the CPU
-	 * in response to shutdown.
+	 * The VMCB save area is undefined after a SHUTDOWN intercept, as are
+	 * control area offsets 60h, 61h, and 68h (int_ctl[15:0] and int_state).
+	 * INIT the vCPU to put the VMCB in a known good state.  Unfortunately,
+	 * KVM doesn't have KVM_MP_STATE_SHUTDOWN and can't add it without
+	 * potentially breaking userspace.  At a platform view, INIT is
+	 * acceptable behavior as there exist bare metal platforms that
+	 * automatically INIT the CPU in response to shutdown.
 	 *
 	 * The VM save area for SEV-ES guests has already been encrypted so it
 	 * cannot be reinitialized, i.e. synthesizing INIT is futile.
 	 */
 	if (!is_sev_es_guest(vcpu)) {
-		clear_page(svm->vmcb);
+		struct vmcb_control_area *control = &svm->vmcb->control;
+
+		memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
+		control->int_ctl &= ~GENMASK(15, 0);
+		control->int_state = 0;
+
+		/*
+		 * EVENTINJ is cleared on #VMEXIT, but only if VMRUN fully
+		 * entered the guest.  Manually clear the fields even though it
+		 * should be redundant, as there is no downside to doing so.
+		 */
+		control->event_inj = 0;
+		control->event_inj_err = 0;
 #ifdef CONFIG_KVM_SMM
 		if (is_smm(vcpu))
 			kvm_smm_changed(vcpu, false);

base-commit: 6bd2905303c58679e303941b7d8ae8c074cd95ce
-- 
2.43.0

