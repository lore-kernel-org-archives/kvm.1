Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444122;
	b=153Zfk6Pum65slCrzwrevrE99OC4LRlJ03Q1t8GEkqxjkAARAiZg87Ii1yS416kPXlsu
	 Zr16ctcycyEvXQwLD8skOF1KkSnzVzFL8HNDxs7MJSKDBMBah3kl+6kcDmclXkk7L13PL
	 Of5IdYJnlIbnY6B0NYi7MmMb+ZP5XVzVf9bQo9YzmaAuNkZhOkGfe2qZVjUQeZIgAxJWd
	 L1Q0mi99ll5FxQBeOCx5RQHzzcL1yDsCX7VP7pZqCt7LMw5nWhd8ZMtXB6oCnCrh7NsVU
	 udSlAlbONk+Fla0U1olcG1PZmO4mBP5YKiWZv+OgATd4D3zBV00QNQ3bHCFgB6H8nWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444122;
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
	bh=+jg6vOIBosQdwIWzHemQ4Oe3hGKbHACVRQu+bOfh6vU=;
	b=2Ub/nTyvTHGGMMQ4Z254KIuw3QlLLwlT86ashuAJa+4ICYOv90szVblWGEk3SflPKwn5
	 yGSTxJa3ZZ2M6cQdUFMJXTu5w2mY3aEect4z3l4wujyGZpAgdlXs3JLeqGouKYV84H5mM
	 c2GJTb5Pabl10hPfkvsnC15eHHMQTAoME+jGsHMFib6ZSq+mGwk89opfQ4mILQTfGbGjy
	 C1GQhNcF2efWHdEvU6lHJ7RhOqOPeXa8+G46c3dWf/HlpHh9IfXg4G8iD1AOw5/MpOrQN
	 SgiU4Hokm2M4fOd4EMJlH9LbNfBD4RftzPz1knQMIL34qEJshVuRqjbCnL9kbnTrVWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OB3To85+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.33
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E46606A31B
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E46606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OB3To85+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gywrYvwyPGzL/YDVrrWkoFFBFTCaRHM9yl9cJmGfFE7x8elo04cQyYJW+kaVe/PbfBTduL6Y7UBEPgccqGc/f53UYVoKU2vZOxjEzX13xVgUAbiA4F7j+faICpuS4gF5TAfys+t+dBLd4k7mficDeF3afcE3dDBCNvK/fQzJeN6GPMbyx56wcUzs2N2ZsHJDOE9PT9MEOvJckc26pEuOpAWA+kRaJvEnSVW6aoIhMKBNs8kznbJUaC++8ssdyNFI1jEy+WeahcokO6Z6sPr8Bgskur+GtNFREgHSZw8KuAE+rgAyP3JVSkcuoXV3+yBiDFbfGCS4fkwXBsZ57JB2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jg6vOIBosQdwIWzHemQ4Oe3hGKbHACVRQu+bOfh6vU=;
 b=Bz0yCG8g2qUyWMh6cf/GQFzBUm6XEpJ/bujceIVuCUHBPHGwebKkswpGv/r06k82k+x4gwDGpaMmadBYUUxnvaW0cuCiw5lMeIrs0RODldd0lAbObZA4pgCRPhKGC1AfCNXQ17a5KsY/lx7ZAwgyUsgNoAGzLy5FkA0F3qYDlfIaCtdIqKd3hJ97vDJt9KtYjBE/ob5dHIiXBmUzkzxOpMUV52M0PgCGd4fOZ4bJBHVrXHB8WSMceV1T8DrWLg/EmqgZ32KnQQahYa1x3N0+dBRxK9XHqkkdd3HA5rdJqmlOrMEENDAkfD+gTZZ409MbafZifDkl6yXdS2KvNR3+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jg6vOIBosQdwIWzHemQ4Oe3hGKbHACVRQu+bOfh6vU=;
 b=OB3To85+l2ddsJDdSL1R63Tq23stv0Woveh9j9YQS0zsqd+P5og2Z3nIWDOpSmCDkm3koQY6VpM+TmdTlYD/S9Cz4d1257wv6nstjnuqgOwzBG8mK5+/67jVB7Czsinx4/5jQ0T0V5GeK4gQrCtV1BQN15qzesw7g0uG0vuPWhM=
Received: from PH8PR02CA0039.namprd02.prod.outlook.com (2603:10b6:510:2da::26)
 by BL4PR12MB9483.namprd12.prod.outlook.com (2603:10b6:208:590::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 21:08:35 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::9b) by PH8PR02CA0039.outlook.office365.com
 (2603:10b6:510:2da::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:08:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:08:35 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:08:32 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 09/12] KVM: nSVM: Propagate LBRv2 state across nested transitions
Date: Mon, 19 Oct 2026 21:05:29 +0000
Message-ID: <20261019210532.378628-10-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|BL4PR12MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 065abbd9-76b8-4f05-7a19-08df2e252358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|1800799024|36860700016|6133799003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sdFzxf0/6lUff6roNR1u5l/rLvsN3Mbi/WHyWMyL75WG0B/mgU725riLXrfNmAxPYLdJY1zGAG7OOqO1glHa9pdnPguCtEyn2c6s4TJcP8NQrLVeWx+smu2E1Ef98moYHWArCSRRTIgEAwJggr5HUC4ra8IkFeB6XtvPu8prPdUcxLmXt52kZsQHsmuFU2WW94hSJTY4do4AGsq/6sqyUi+j53UHwCHemg4a6WRPTUbav8XLU3xM3wtHxeMZemYa4A9hTduFto2G3uuS42lQhNa2ihqwx21w+CURA+cqlixOlE3xo+fxRMVYvZdM+ffKgNCuXr7sZQw2jmEDOk3o7/W+Y8f+ApytFVvZYsjB08SzzTxvkAXFpFqAfv8L7Rp3uE6j+06BZxN47Tk1q2mKL+12x8xftigRjhtSDAit0cZhshJycKn+NXv3prvIlDPfl/+9JrgNycOD8YsvS7GCGtofCHZx61qVreTNnF3T9r+Ki7854AJp8PU1P+VbzY10uY69ZAgBBjiXTk6vzvqiLGUKgq0dmMDywm92lWR9S3x2Glwi+bKYOj6ZHh5KLUJrJ/bZm//XVp0iWJFtk+4w+wylUKunwpLlFcP5GGAC3ekObZXS1T2cv11IGry4TqEkeW9ReexoWHoneAAO2saiDw4eXT4nXWWltfWxM/SrTEDmxpNb9Hr58hdagkt9g9YLeWQZOgKme3EsP3klM2pkcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FBOluC/YVgE6dePG+TbcePwn4/4ubmnXVmYbkKJYvXvzmUkRrbGcKoRnwsrPp3sMOP8/gMm0pBYG1w2FtT6Nny/JhgOexYvMIqaaxFf8+fwz2BgQbsdlMCMOVU0UOFqtN8NFhwAOKThxPtpFmlFUZT7Gdsc2IL8iyqsaPxNwc5XdfusGYsEJmkNBxKU7pIIlPINQNHECUompMBxQimaGrarPoZSYxhFIEGCVCwHTqmitKngUVCaU7CsLh4YX2zLCteV4SMFUYmeZ02k7kv7/rtlWZOnv511xH8CNL80DrSK/Ffw3dOAjfMzKkiVCHYxiaBvvyuI/mJL7ju56NQYh4SUzuezdWiULYEMW5SX8C8w2NWrsofdDZkckBowmzU7RIiOAFlQzgXD6IsSuv/MgDUqvqUXnV3V/X4av7s8N1cauT4jmVPWd19q5WohedRly
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:08:35.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065abbd9-76b8-4f05-7a19-08df2e252358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9483

Copy the LBRv2 state on nested VMRUN and #VMEXIT just like the legacy
LBR state. If L1 enables V_LBR for L2, L2 has its own LBRv2 state in
vmcb12. If L1 does not enable V_LBR, L2 uses the LBRv2 state of L1.

Add svm_copy_lbrs_v2() macro to copy this state. Keep it separate from
svm_copy_lbrs(), because the LBR stack is 256 bytes and KVM copies it
only when LBRv2 is supported.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch.

---
 arch/x86/kvm/svm/nested.c | 28 +++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h    | 18 ++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..b356a091e320 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -608,6 +608,9 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
 	to->g_pat = from->g_pat;
 
 	svm_copy_lbrs(to, from);
+
+	if (kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2))
+		svm_copy_lbrs_v2(to, from);
 }
 
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
@@ -819,8 +822,17 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		 */
 		svm_copy_lbrs(&vmcb02->save, save);
 		vmcb02->save.dbgctl &= svm_get_supported_debugctl(vcpu);
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2)) {
+			svm_copy_lbrs_v2(&vmcb02->save, save);
+			vmcb02->save.dbg_extn_cfg &= ~DBG_EXTN_CFG_RESERVED_BITS;
+			vmcb02->save.lbr_select &= ~LBR_SELECT_RESERVED_BITS;
+		}
 	} else {
 		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2))
+			svm_copy_lbrs_v2(&vmcb02->save, &vmcb01->save);
 	}
 	vmcb_mark_dirty(vmcb02, VMCB_LBR);
 	svm_update_lbrv(&svm->vcpu);
@@ -1236,6 +1248,12 @@ void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
 		svm_copy_lbrs(to_save, from_save);
 		to_save->dbgctl &= svm_get_supported_debugctl(vcpu);
 	}
+
+	if (kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2)) {
+		svm_copy_lbrs_v2(to_save, from_save);
+		to_save->dbg_extn_cfg &= ~DBG_EXTN_CFG_RESERVED_BITS;
+		to_save->lbr_select &= ~LBR_SELECT_RESERVED_BITS;
+	}
 }
 
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
@@ -1305,9 +1323,13 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
-	if (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)
+	if (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR) {
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2))
+			svm_copy_lbrs_v2(&vmcb12->save, &vmcb02->save);
+	}
+
 	vmcb12->control.event_inj	  = 0;
 	vmcb12->control.event_inj_err	  = 0;
 	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
@@ -1384,6 +1406,10 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 
 	if (!(svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)) {
 		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2))
+			svm_copy_lbrs_v2(&vmcb01->save, &vmcb02->save);
+
 		vmcb_mark_dirty(vmcb01, VMCB_LBR);
 	}
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 72f19053fb4c..01be2fc05d70 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -176,6 +176,12 @@ struct vmcb_save_area_cached {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
+	u64 dbg_extn_cfg;
+	struct {
+		u64 lbr_stack_from;
+		u64 lbr_stack_to;
+	} lbr[SVM_LBR_V2_STACK_SIZE];
+	u64 lbr_select;
 };
 
 struct vmcb_ctrl_area_cached {
@@ -820,6 +826,18 @@ do {								\
 	(to)->last_excp_to	= (from)->last_excp_to;		\
 } while (0)
 
+/*
+ * Kept separate from svm_copy_lbrs() as the branch record stack is 256 bytes,
+ * i.e. is only worth copying when LBR v2 is exposed to the guest.
+ */
+#define svm_copy_lbrs_v2(to, from)					\
+do {									\
+	BUILD_BUG_ON(sizeof((to)->lbr) != sizeof((from)->lbr));		\
+	(to)->dbg_extn_cfg	= (from)->dbg_extn_cfg;			\
+	(to)->lbr_select	= (from)->lbr_select;			\
+	memcpy((to)->lbr, (from)->lbr, sizeof((to)->lbr));		\
+} while (0)
+
 void svm_vcpu_free_msrpm(void *msrpm);
 void svm_enable_lbrv(struct kvm_vcpu *vcpu);
 void svm_update_lbrv(struct kvm_vcpu *vcpu);
-- 
2.43.0

