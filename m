Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194403;
	b=3XFi+oG8w02OGXo9/KZqNJGukYzg0EYf95utX4XVWlql1DNvJymY2H+0Sx9CC/ljFtsK
	 XAvYLGrN/Joq97ZvhHNQt8VcUE6si/g5lLDgRN0xMSdYstusRwgkLMwZN4rXzENAFbLgn
	 9Uywqy+VhOihOHPS4LKNVW+SJx7zIcb3q/DWNsvEYJlJO6ObFKVlegRg2uJ6v5B2Gaqn6
	 dXHS11GS9qHbWXTCqY5YMm4saKC13AnPfq7exnIZCrl/1RVS4ADAViMVfIapoxs7gDUVQ
	 +PAle9oqAdDCIdEdnTFKevnVwN4YdlXA03Qlyr+1oxA3ocjatu/LHGvWEDyDtHpNFcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194403;
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
	bh=eUV6yM/+it46zvPqrJxG0t/mrgTIXj3lEHxYi/m0+Ug=;
	b=2B0itZV3zV+6ADGKByIJHXZRq2mv71g+z1buWCoAeL7wCCPJTK8MKb2a3sKxc3p1QjEL
	 KJE9FQIR7See/rEV9QmjNJH1JnF2o/NTRhlnyEXzVLIRGzfT6PuEI8pquhR+a/UCLz05d
	 JHsfI/FYBz3qQHO5yV3wS8kOP6R81S1pJZTsBNBfCgKfhpLlV+7OeTzrEv30Mfzd489N8
	 hRsP8SbxF6cpfmUzbTHQ2mU10HjaWqN7LCmAYl4kI9kHmlcmo8JSiT/HNVdN2tfxbGuVE
	 s2f+MU/Pyc0NzMMoEbhj3IzXGIDiH85nGMc413yHRZO4nQzkuf+bO7mcZg55rwtHdog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PGX3goSl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.6
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2FA606A332;
	Mon,  9 Nov 2026 03:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF2FA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PGX3goSl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnKnKQ6vRtiKP8YBdSNBsMtJbrrsXJb7/dyh0lDy2P1oipH3s38xZtHRkAP2wOIco1PZ/osYj8IeC2EKIp23Uu1iptm7wvnq8xtMGyT5Xj5iNLReGjE7QskfqGM++jrSPc26pIsYR4CMdALngD3qv431VUnjuLQbgg5ITQfcc/1Q4369XXww9y+8wFuBaFKuhFBbk/uxvNkBQhiGrxa669LM+Ulx2xe/J8b3AodZGH9KK0HbNaI7jMMToKGFeiWTsLH7KqJR/aAUWLImKrA0INZd/dx8P5j6/AmzVWP3KpBqMtv2CaGxCXlqUUcPTv2Ac4EmC91x1nplo7mA67HHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUV6yM/+it46zvPqrJxG0t/mrgTIXj3lEHxYi/m0+Ug=;
 b=k8/tacVmssVDae4ER7nJaN9Q+5NbPAXLrr8ksyGqmAhOPQk8rJ50y+gqYnWqhjuS7BUHS06pFgpy1lyX7HSS/A6ok9ocsfdMDng5yZdZM5FEN5sAI9Vs11gjznORGsMWIAJw/rWq7UNsNIHMdqbpu9H8s4EXCEfL9KMRiD+LDnh4KgpL2Qi3Jm1pArQCqZ+zfIeaXd7BYUiuEowtLT1rThkoD1yyAihwvG8mPkrdeh0kOkfMqQSjaXUkM8/ETkNbN1/nGZPhgG81obyNqhH89DzFhRgs3FHZkWZ3vzdULCFVUkkyzFy7MUJgSR0IlE82qTX00bfy37om4cD0sjIyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUV6yM/+it46zvPqrJxG0t/mrgTIXj3lEHxYi/m0+Ug=;
 b=PGX3goSlEfPNM/NaSBtBzmV0lx15TnAijLYF3Qkgqh+rEsj0YzO17sreyQbb64LpDIp9p4kWIop+VugEWPLakGTZOJweyZVUC7U00eh2hY6eO1cbhbMGInVjBmq6lI8tcggKNZ8TEs2BYgJpdG/8pl38E92Wubl9ta0XpBk30hk=
Received: from BN9PR03CA0331.namprd03.prod.outlook.com (2603:10b6:408:f6::6)
 by BN7PPFDE2ACDA69.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:19:58 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::7b) by BN9PR03CA0331.outlook.office365.com
 (2603:10b6:408:f6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:19:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:19:58 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:19:58 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>,
	"Thomas Lendacky" <thomas.lendacky@amd.com>
Subject: [RFC PATCH v5 5/8] KVM: SVM: Inject MCEs when Restricted Injection is active
Date: Mon, 9 Nov 2026 03:18:37 +0000
Message-ID: <25119b0f9a4e7278d7bfe7cea64de114046ab5b0.1794171754.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: f8849aa2-5eff-4e0a-bfde-08df3e1055b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|5023799004|56012099006|261021135927099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	u0H8e0RDrI2XhaaPD8GLfAsMxk1mz/TgMQykL6cZJ1ghforVsXDkQGbSFWE/txapIDrbCmWFcR2TBZ1c5AYNizjLAp9uuGDXp1j49qwvjAByzkBGWC/we9ofcsOKGyfYLQymyP54xID0U8vrGV1iWgxfdtT33BHvqVeZgvQMGyjGvVyBt8ca7N6uPoFWbMK4bN+jBQYcNh7pc52h61eg75rygn7JyVgIGqYnVa1O6gKqCacw0iar8yIOU+xPisbtNbKmlHmfg1wJCXB/s/Jx28ZOPUEY874ZQDNfZTyvjHiPiSw9wQzDEQ0wXy2cugAVos/O3Y/U5zEOcmkFa/oOr/Zopp/EBWsZ+pczWTcf7JpiNaAMGciHT5PqPT5+PY9CTYAw4EKzW9K0d8eKrzHu4gwZfMpd6sJRrQRkHPd5H8xSUiXJTxqW5sNdNQgivgwSf0Tswrepmy8fl4/gmPQ2BknUgp3naJbSt7qgtZquHBbZJaJKRlqRB9oFO5OBx2lH1YjZzT8qupiQ6rsCdIJffBBNLYMo0u+f+hC0nweeKKOBHGIpjM51MFK/qCWLdfirS+oKu581s+TrJ4K9syo58icrNBwnRL7SJ0AWK95kq4Lgg0N4omt9P+WDTFY147Q9XStAEHNBfTiCfokpDhH35w0ry4bOaXZNVFbxUZtXO4wb22ErO6SH11rgwRFex39plckevjTCUGeUTODhYYnmgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(5023799004)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PSNcQkrPDicRTul9Hka23TVrE34uGdZJrYSg3TpRAi+/4ZRvh06wEnW6LPSndqYw1gk+E8lz0BuU3SOceizHlV/hdY4Ud6rehzBHquOAnNha/0pMEgG/kPz1/XcxR/KY8NarWXhhqYgjBTI6BkW3AEOulKZcLCMlg8rtO+gJ24cMveloqRMxI3sVShl74qfCSlvY80zmJi0WiDmb9Nj/HcaiqasFLesolqfzRtg6XlYpni9luYbcscDNmwpmVJYeYxgSWVi/u/JR8uke3Dr7hQ4Uz5wplTNSAQL//bMB6MqsRnw8iGtAd3kZ2BnrVS27gS21+gHT1IQWAoGqHyoRrL8RzzDSixTaNPl3V5vpkfV8y/PJnocZf1ZK75s0h5sdcp7Ir5PFLifOZ/lL9Nu5Iz3nbJbAQdgNBH0UCJU74NlORA/OiPDbUVD0OsdkW2RS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:19:58.7894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8849aa2-5eff-4e0a-bfde-08df3e1055b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69

When Restricted Injection is active, only #HV exceptions can be injected
into the SEV-SNP guest.

Detect that, and then follow the #HV doorbell communication from the
GHCB specification to inject the MCEs.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/sev.c             | 17 +++++++++++++++--
 arch/x86/kvm/svm/svm.c             | 17 +++++++++++++++++
 arch/x86/kvm/svm/svm.h             |  2 ++
 arch/x86/kvm/vmx/main.c            | 10 ++++++++++
 arch/x86/kvm/vmx/vmx.c             |  5 +++++
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 |  6 ++++++
 9 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 2074c2050c55..e3da9fb0b2b6 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -80,6 +80,7 @@ KVM_X86_OP(inject_exception)
 KVM_X86_OP(cancel_injection)
 KVM_X86_OP(interrupt_allowed)
 KVM_X86_OP(nmi_allowed)
+KVM_X86_OP(mce_allowed)
 KVM_X86_OP(get_nmi_mask)
 KVM_X86_OP(set_nmi_mask)
 KVM_X86_OP(enable_nmi_window)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4de443140c53..fa83477ebcab 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1606,6 +1606,7 @@ struct kvm_x86_ops {
 	void (*cancel_injection)(struct kvm_vcpu *vcpu);
 	int (*interrupt_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
 	int (*nmi_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
+	int (*mce_allowed)(struct kvm_vcpu *vcpu);
 	bool (*get_nmi_mask)(struct kvm_vcpu *vcpu);
 	void (*set_nmi_mask)(struct kvm_vcpu *vcpu, bool masked);
 	/* Whether or not a virtual NMI is pending in hardware. */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f80dfd876d5e..6a1262c274ff 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5565,7 +5565,9 @@ static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 		return;
 	}
 
-	if (type == INJECT_NMI) {
+	if (type == INJECT_MCE) {
+		hvdb->events.mce = 1;
+	} else if (type == INJECT_NMI) {
 		hvdb->events.nmi = 1;
 	} else if (type == INJECT_IRQ) {
 		hvdb->events.vector = vcpu->arch.interrupt.nr;
@@ -5602,6 +5604,11 @@ bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
 	if (!sev_snp_is_rinj_active(vcpu))
 		return false;
 
+	if (vcpu->arch.exception.vector == MC_VECTOR) {
+		__sev_snp_inject(INJECT_MCE, vcpu);
+		return true;
+	}
+
 	/*
 	 * Restricted Injection is enabled, only #HV is supported.
 	 * If the vector is not HV_VECTOR, do not inject the exception,
@@ -5682,6 +5689,10 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
 	if (hvdb->events.nmi)
 		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_NMI;
 
+	if (hvdb->events.mce)
+		svm->vmcb->control.event_inj |= MC_VECTOR | SVM_EVTINJ_TYPE_EXEPT;
+
+
 	hvdb->events.no_further_signal = 0;
 	svm->sev_es.cancel_flag = true;
 
@@ -5702,7 +5713,9 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 		return true;
 
 	/* Indicate interrupts blocked based on guest acknowledgment */
-	if (type == INJECT_NMI)
+	if (type == INJECT_MCE)
+		blocked = hvdb->events.mce;
+	else if (type == INJECT_NMI)
 		blocked = hvdb->events.nmi;
 	else if (type == INJECT_IRQ) {
 		irq = kvm_cpu_get_interrupt(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 75e86592f1c9..ad99b2b1b07b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4114,6 +4114,22 @@ static bool svm_is_noack_required(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+bool svm_mce_blocked(struct kvm_vcpu *vcpu)
+{
+	if (sev_snp_is_rinj_active(vcpu))
+		return sev_snp_blocked(INJECT_MCE, vcpu);
+
+	return false;
+}
+
+static int svm_mce_allowed(struct kvm_vcpu *vcpu)
+{
+	if (svm_mce_blocked(vcpu))
+		return 0;
+
+	return 1;
+}
+
 static void svm_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5429,6 +5445,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.cancel_injection = svm_cancel_injection,
 	.interrupt_allowed = svm_interrupt_allowed,
 	.nmi_allowed = svm_nmi_allowed,
+	.mce_allowed = svm_mce_allowed,
 	.get_nmi_mask = svm_get_nmi_mask,
 	.set_nmi_mask = svm_set_nmi_mask,
 	.enable_nmi_window = svm_enable_nmi_window,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2909f57508de..e19b398a3df5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -61,6 +61,7 @@ extern struct kvm_x86_ops svm_x86_ops __initdata;
 enum inject_type {
 	INJECT_IRQ,
 	INJECT_NMI,
+	INJECT_MCE,
 };
 
 /*
@@ -826,6 +827,7 @@ void svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 void disable_nmi_singlestep(struct vcpu_svm *svm);
 bool svm_smi_blocked(struct kvm_vcpu *vcpu);
 bool svm_nmi_blocked(struct kvm_vcpu *vcpu);
+bool svm_mce_blocked(struct kvm_vcpu *vcpu);
 bool svm_interrupt_blocked(struct kvm_vcpu *vcpu);
 void svm_set_gif(struct vcpu_svm *svm, bool value);
 int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4c52ab8d0786..e083e2965cd9 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -828,6 +828,15 @@ static void vt_cancel_hv_timer(struct kvm_vcpu *vcpu)
 }
 #endif
 
+static int vt_mce_allowed(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return 0;
+
+	return vmx_mce_allowed(vcpu);
+}
+
+
 static void vt_setup_mce(struct kvm_vcpu *vcpu)
 {
 	if (is_td_vcpu(vcpu))
@@ -962,6 +971,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.cancel_injection = vt_op(cancel_injection),
 	.interrupt_allowed = vt_op(interrupt_allowed),
 	.nmi_allowed = vt_op(nmi_allowed),
+	.mce_allowed = vt_op(mce_allowed),
 	.get_nmi_mask = vt_op(get_nmi_mask),
 	.set_nmi_mask = vt_op(set_nmi_mask),
 	.enable_nmi_window = vt_op(enable_nmi_window),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..2b391c282b51 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5273,6 +5273,11 @@ int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return 1;
 }
 
+int vmx_mce_allowed(struct kvm_vcpu *vcpu)
+{
+	return 1;
+}
+
 int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 	void __user *ret;
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 054fd14bb2e1..f68316638f21 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -93,6 +93,7 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu);
 void vmx_cancel_injection(struct kvm_vcpu *vcpu);
 int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection);
 int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
+int vmx_mce_allowed(struct kvm_vcpu *vcpu);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
 void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 void vmx_enable_nmi_window(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..1492a06a6935 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7673,6 +7673,12 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			kvm_update_dr7(vcpu);
 		}
 
+		if (vcpu->arch.exception.vector == MC_VECTOR) {
+			r = static_call(kvm_x86_mce_allowed)(vcpu);
+			if (!r)
+				goto out;
+		}
+
 		kvm_inject_exception(vcpu);
 
 		vcpu->arch.exception.pending = false;
-- 
2.43.0

