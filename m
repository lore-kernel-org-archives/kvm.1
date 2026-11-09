Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194391;
	b=MbyB/zG0k8ipKDUdpkdndfVgftHB4xstqmJb6lr5SUeI26VM6WHTEoSiCzxwmRxZiiaF
	 VQVGxuG4+d8a7qsBn1tjJot15JcLlwLp9i9rHcFOl9FOWBAUAYbOC+U6ndimLfnaEFUNB
	 ZvUhaqTzDf5288YHWDFKsxJBfS2xSzg/qie34Yv+zeszy3YYcKpeG2Pg4+oXKhyFtIM5c
	 2qZoP7/JYqNS+yGhTn83a2bYiRLGDmnkvPGhSGOtlxqlX/TRQSVWzg4WgkN56OnuV7/UU
	 t0l92o1IDx9WVHLv8ZqS/i2femHcpIX003dVjDHup/sxsEx5732WVipdseaP6kKKunA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194391;
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
	bh=flCpr62fhZuHEycvWuVFW9ewZYisw+7x2jhCbMX6Sn8=;
	b=O3ZT0TE1RwwnKgrjWfoNgqjgcTUz3E3jgjOmcaUXHrekRffeK1OB+5TFnaPzCXczRlcl
	 Q/5uxp4GkCLuxfoDQVjbEIzd8kXzOEN1BDXWGbQpCMerKRohjTIgiY3D9bjEywBNTsjcZ
	 6BqoQuIqspRfUkUxBi8XKZ7qiKFt/7delg4wRvOvrtr8C/YoXsHBYJGpVe4NXIAakkJSB
	 SSa57PjvwbCJIItMEjephQX90WrN/kYGV/F5g+Do4MOweg/HfGUrFpCv9jvfNBNw/DP+x
	 31SgCBO0blTArFWGQvX9fp34qEoLQ4vWzcpsq/FekTjNGilpe06v5pwMfLMaG7YhsiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GMfxZAjq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.36
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023E606A31C;
	Mon,  9 Nov 2026 03:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4023E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GMfxZAjq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uobv9vjCPH7likNor2G/gr89i2XDenp0e/DnkULAZiPL8wwCsjV1KfqjOyU74aV6Dlyofpz7EHbuH5d5CG7wLaFWqDnysXHDiZkEDzIHEHeaoc2TBO4beKwWmy3ebNADRde/2zsESN9mLsRH119HYWXy4/mrQ3DE2r2igr2PgZvJe0feJqkJesgmJAB4SztvrRCfd6zSkydGO2Ak2yKtFlbZfUQAFySP7/AwMIMfGABLKEDGCraeaD7Ss/KMhWDjdT6ZexeYDiI9CY3YNrE7+RvQ7XLHeX23zTbRjs/+r+t6w/glL3NEVwynQmqV+HjJnDTrsUmskXln+uYKN2Bt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flCpr62fhZuHEycvWuVFW9ewZYisw+7x2jhCbMX6Sn8=;
 b=ov87tpOOjEPfS8NCW18CXoePOYSk5UzutDaya/eU0x0vAXZVEpSZnGyUnpG76uwpavnne4kkFkRCcTD5W9suKYwP1bygkuRV4/J8WqbVCwWhcq6vrbJMjqjBYLXMzPLmOZ6ELppLY53W1uH06vAKDBhS6KbDSp707XmlnPAxETcohdORf000BylREkKQd5E5PwXX3OFr5MpLyiR00Q65idAXN8loc7V7N3SAD/mf1DYd5RhG3VRq5Lyhbhv/VtGtTHRS5VuArs/3xC5gvt8xdGmjHdmE8ONIJhA7IlTk+Z25PuIT1eHnO1Y+QIW4UICNnoZCIZ96jg+y5bM9rxdP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flCpr62fhZuHEycvWuVFW9ewZYisw+7x2jhCbMX6Sn8=;
 b=GMfxZAjqs0R5QOoVO5kBrQt2UIgiUhz/29mxg5ut7cuS/KwlJUOE1Lv0XOpl4vLEx8nrfrGj0d63m+o845Go/LvV5u42UhcZLyB92Amg3VweXWYIZMWcYukArY24LDZF/edw3gG/W/0HxIhguAT1buSGRaL/GpzdI1r7QvHyXHY=
Received: from BN9PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:fb::17)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:19:48 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::a9) by BN9PR03CA0042.outlook.office365.com
 (2603:10b6:408:fb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:19:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:19:47 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:19:47 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>,
	"Thomas Lendacky" <thomas.lendacky@amd.com>
Subject: [RFC PATCH v5 4/8] KVM: SVM: Inject NMIs when Restricted Injection is active
Date: Mon, 9 Nov 2026 03:18:36 +0000
Message-ID: <2dcaae0e2b1333e57c3599d504b24b1a69b034ac.1794171754.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794171754.git.huibo.wang@amd.com>
References: <cover.1794171754.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 86405f26-85dd-4dbf-a24f-08df3e104f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|10067099003|11063799006|261102123227099003|56012099006|261021135927099003|261021121427099003|261021123027099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	gGLG+KQXxBea2xzq11WrIDVWyK0BBI/1px6Z4UOYFqKqMl/6oVY1yDywUw7+PjtjKoVEC/B8jXYiYj/U6lTSXMtjzBYcTUyfs4l9y4CxyolPdnyE69O9P0BaoM7wflyEdeJ7oJNSExf+4f893L5YnjDGTKCR31gTp6JFPUzA+e4un3aoGpz49VNEAYB2SFKMyAoHinThSoakWrtlSS9tvzgdbhD+DPqobPmO9G7+0jQLhnmdBMczBs5Vc/H6YMgghHG3w1LO+FnC/wWaik5wRQMmB/B8/mexdjTzQJhIOseeca3I5wjhACzOSZjIHF+tMdowDnV7AzesdpaCt59TuwyDIlzRMlxPandR/HBJ3XwMqKN21dYpN3+4JKsFNS4Fbavg3LD6wCuaHgVrgZ51CayamEOzLZaLbFCMxOX6FZCm0046DjucmgM2gwDbobQctn1YmkFHM9nhWTbXPJXx04gwfEiCZQwgUXKhPCmbF4znt3wC1oo4brrY/jw6Km6wenDewjkCekHx2miZccler69jRaMYhS3AfhvaInfyI0SUUFu7b/alKXntXuT9zsi4I+yT8NCrtw7sVzkeToknqqUsP4cacr9M6coJp6GWw1GXQuY9g4rIZQgD/t4FMkSGZG74A0x6Ek1YXbZ3OldyY5Ks40N+vgxQOb1TOJxM3F0N05dWUvuyeXmnBX61gIDr/N9wpvdGU2dZeLkrztVa8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261102123227099003)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hSYOohBvmqQDFgiugEz5Ri2WcnGdG20H9cbJ3L5mweLTa9ql0GFhWJXiNnS64P2LBgPgoHl9SAhosNG1Zs4FbaRks/W2bDNa5kYvZZysKhYAXv0pW5quWTyEB5VmVO20++tSdCMiI+/q7zGCaO90B2m5byQfY6IZw9p3zkMWaD1VAub9JPZHQNkNCtcYphMCB4ZrfZkaGX+EAVz5s3HlA6BYMo67r2S8p4oF09x7kLfJMoyUysdnjhJUlVIEe7e2xDzhauFJzWDzSQR+rPiohTdhTIp2ImeJAlDMoQf2y6bNyQxovsQu2pzr5CykrO8sZHRBD8QsUUE2Q4EjNi3kTjw/Eu5/fT0Vy11iFzUSb2zjp4z7lCWU+DHOL5KY/1gP5EMIEt3DXglTYXg+7be2aJOYaezbl9tuTGauYT6OrZK3akflbOB40K/b2KXTzCDW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:19:47.8708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86405f26-85dd-4dbf-a24f-08df3e104f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454

When Restricted Injection is active, only #HV exceptions can be injected
into the SEV-SNP guest.

Detect that, and then follow the #HV doorbell communication from the GHCB
specification to inject NMIs.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/kvm/svm/sev.c | 14 +++++++++++---
 arch/x86/kvm/svm/svm.c |  8 ++++++++
 arch/x86/kvm/svm/svm.h |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e4a074df7434..f80dfd876d5e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5565,8 +5565,12 @@ static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 		return;
 	}
 
-	hvdb->events.vector = vcpu->arch.interrupt.nr;
-	svm->sev_es.pending_vector = vcpu->arch.interrupt.nr;
+	if (type == INJECT_NMI) {
+		hvdb->events.nmi = 1;
+	} else if (type == INJECT_IRQ) {
+		hvdb->events.vector = vcpu->arch.interrupt.nr;
+		svm->sev_es.pending_vector = vcpu->arch.interrupt.nr;
+	}
 
 	prepare_hv_injection(svm, hvdb);
 
@@ -5675,6 +5679,8 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
 	if (hvdb->events.vector)
 		svm->vmcb->control.event_inj |= hvdb->events.vector |
 						SVM_EVTINJ_TYPE_INTR;
+	if (hvdb->events.nmi)
+		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_NMI;
 
 	hvdb->events.no_further_signal = 0;
 	svm->sev_es.cancel_flag = true;
@@ -5696,7 +5702,9 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 		return true;
 
 	/* Indicate interrupts blocked based on guest acknowledgment */
-	if (type == INJECT_IRQ) {
+	if (type == INJECT_NMI)
+		blocked = hvdb->events.nmi;
+	else if (type == INJECT_IRQ) {
 		irq = kvm_cpu_get_interrupt(vcpu);
 		if (irq < hvdb->events.vector && hvdb->events.vector)
 			blocked = !!hvdb->events.vector;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 601807a8f2fa..75e86592f1c9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3795,6 +3795,9 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	if (sev_snp_inject(INJECT_NMI, vcpu))
+		goto status;
+
 	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
 
 	if (svm->nmi_l1_to_l2)
@@ -3809,6 +3812,8 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
 		svm->nmi_masked = true;
 		svm_set_iret_intercept(svm);
 	}
+
+status:
 	++vcpu->stat.nmi_injections;
 }
 
@@ -4025,6 +4030,9 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
 	if (!gif_set(svm))
 		return true;
 
+	if (sev_snp_is_rinj_active(vcpu))
+		return sev_snp_blocked(INJECT_NMI, vcpu);
+
 	if (is_guest_mode(vcpu) && nested_exit_on_nmi(svm))
 		return false;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f0db48d62fcf..2909f57508de 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -60,6 +60,7 @@ extern struct kvm_x86_ops svm_x86_ops __initdata;
 
 enum inject_type {
 	INJECT_IRQ,
+	INJECT_NMI,
 };
 
 /*
-- 
2.43.0

