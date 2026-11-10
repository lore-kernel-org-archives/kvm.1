Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299399;
	b=BgoUFmSEeqqPdkTpaQiqR9PA27u+HUza2AvnTladM+h1iSOjsHL8GGVgb+lScp414rpq
	 pw1OnLlIZ6RPZKi018dusaMcAfigv6YKFBEjY8TKOFqpCGg0V6BnrX64RKI4nOykAgXFg
	 3QlLOnfs8H/vmR6NbPBTO7gE5jiBFpzaO7kPyd9vjoXIaJZagW5OksyXfuy3wVKsBIhQk
	 h63lUjh7iLRAYIsWYgDVxbaSwi6n7Q7MVvztjtv/dbqooH9vPt4bbS+V4PSGZXnTNxKwc
	 7N/uiH7NnsC3YTpzA6xmQhFSNwqglGG123Y9kyosKOm1E65JC5V/JMd6rOVG337nBSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299399;
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
	bh=BKZUMEbQp9ZlgUN5pVsI5R5ej6aN7LOH4LlkuAfsI7E=;
	b=V7ECUqZqMYrKaU9PFD2YJZilqAQ+6tINhEaEXkvj+w4scegwPPBg7NjGIa4QLmXGGNPy
	 jQJfORGPL2J6/6Tp8tK47FDuhxWgsWTfhPg3Ll+DsqeOQuRIsWwjHfUCvHDJCgf3b999O
	 Z4Lh4c8T38uqYdLf1c7KeSQBJFh4PIcvUX8uUQvGXmkOIidyhlCPA5XuSnRQX7TKf4MUJ
	 BGxBgH3NEWFYyC58KOdFJ72lbVbPhUEYe5YzrXiBtstfgyZBTCqR1v0BhM6Ko22ky9FgE
	 b9IBh0dwL3j70JtKwCt3hO0qhjoBG2SzPuPEre+8TL/O+B5W8AFMVsVrjLR8ZMSVMTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2s5AsmoG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB0606A988;
	Tue, 10 Nov 2026 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBDB0606A988
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2s5AsmoG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvUi9BMAXs8w3rb/5VeItaIW6euH6Wxm7Y+tB1AnjbAzy5js0FPqNVmhdjm9S+pwAdX2jtWDlLmX+vLci7bCAsTa5NjCN7cZQxojRe3YzEJCa4A31ifHQWHdeR2hPIeP1JvEEA/GISWicix/OK/7g/TgEqDusyKIjL9pOOiQkIvqBN15j4fV/xKitrN/IjcAbS9tnA1qX4eQCZprccShOGiYGyEOBMDMpulQ9jmgJY1WOJ9gYI4tX0rY0Z5gjVZWDYtu1AirDayefPTuIOE90N3+VDV8D5r8mdvx2N4cZlXrCceOk5LCXUmLDLi2JVA/P/MLSCnRqbHc5afpxX2Oyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKZUMEbQp9ZlgUN5pVsI5R5ej6aN7LOH4LlkuAfsI7E=;
 b=FP8DdVei0fx/dWBxCJ3+erjKBEjBkpDl0dTbQVDRuSZWSBm3qEmzTryJ9SCDHTyHYNLHSB2322dGs2hLfZUit5uPgDePfv8Ir3mSCSVPvH4T6EOvpm6KCwfxjZ3pxsnlDIOsLrR2W+ZsMjC20PJ4yQ1fjUi3BNN5N/6PZWSz0Fsy1fQ+xjIjzgigmAj1PEG/6DCAYEr/eHSbyu6MGXlnm766bpI4W3Kcd9LLu4TvTAbUaW3ZNF4U4hL49oYphba95yCW2kEa/diVpdgwImOY5vVQmqBnlYZEcBrNVJhqW+G1T/j548ZXJNZOZQCD1S3Zg2kTKoYnYIvVAfq49ZDscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKZUMEbQp9ZlgUN5pVsI5R5ej6aN7LOH4LlkuAfsI7E=;
 b=2s5AsmoGIFdpjCp9nBWeUfs9zYdOXtbPeQ+FO5l1U7tEtizm32QnrtUeYY32Da6zNtNJ1CYx4oOMzcLSejf2nsoeuvJCC3WxR+PU8oiMPVg7ADrucKJDE45fJmXjaJX4Us7dpkT5XY6e2wyBxBUh0dIr5IZqQPTJp8UtkPnsvnE=
Received: from CH0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:610:11a::10)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:29:54 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::60) by CH0PR03CA0338.outlook.office365.com
 (2603:10b6:610:11a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 08:29:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:29:53 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:29:52 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  4/9] KVM: SVM: Add Alternate Injection path
Date: Tue, 10 Nov 2026 08:28:49 +0000
Message-ID: <b4e39bf2b0f13d1fa112692212e4edf5f5ce941a.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 725076b7-2d06-4f52-008c-08df3f04cb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|11063799006|56012099006|22082099003|18002099003|10067099003|261102130727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	j5xvxHPUSb7RRAavpFI8P2FtPqGzqCH4LWcX/dn2EVHz+Odxr0g33TQHBRFs8Tya3kU0gMzgxNU+bPLUTpqDUfdPW5hM/xypa2/h58h2CFHp72Wsi0wT32Pvr6wfn1CbBefv7dPj4bCDP3Cxz26w5WEFMWdeF1EsgOuVnEppuWCAMWk8vY1YViAMsxZAfNmqevB+8iiYiXh/YKYwD/jilUX6+cgibIirAZcc0hTuNZ9tFIfksjKB0LtqFGO5n224islODJMywfzb/vR4PIWYvjNbRYFYg6gtkLNChnEvy1oS8KSr7QHwUjZGR2ElfWyxAviTpnzJ1TZDpRL1q5X4Y+ALQ+jM9KQ72lENS95lLiCxOdpeElUgrjbeVpS1hKg6qCPQzhX+/yHzwI0wHypqY+eyg2Oqe1gXOh+qZlL1Qnhy5M0VHZ9+jDzOa9F4+49lZVn14pW6x8/cEfUvcK4xLumXjPlY3nE+eFfbJ7uXLdDhVCmZcHaaUIDKbXCy1waogc7wcam0IMAur821Zw3zW5uGpTEN6uMnR0QLJqxbEaD0PXmDAZ1eHR4xnyNw+D1hx6cpu8B22DS5yveQ+I2jCI3fYXzA0E3wtkjnw73M96T15S6nScbVLuCzKJa52jUfFDjPJnm7qW7GMzV8kW8P75XygOxmNO6mMLaxkRhA4L1rMRRc3oLmBXSsPG31G6nhrIrqAdQa6dPMfQXIr+5dzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(261102130727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O7sEX99/Fv/D0wfhn/56kMKV4Y0+kzlt6vHrtqNTFTdS+luT5SYtcowFFXgcOTmb5m8xUH9JCbFV0ozsq/+QE/A4EAWS1exHG/AJxZMcHfHgt+CXq056jrzjkQVHt8r8/Qiu5MsVpAnPb2y8jbFNj2o86YnF2exDlwEzUzSgaH9pVhn1DNJwzvLzRf9gHtB5W8tD8MtU4n2JcZD9EMId1tQ0gMKSq/cfwC1XhLUfB81nVCVWw5U0FHNYS/QI7UmQQC/uUN2u8bBi0W7n+Is06G0Byb2HBYLZ9X9wJp4Ewa1H+asPhugAuHuUyI8o111+KoJufxhjIx+RqLh15PKeO5j5KD936L2+mJA8ACZ2ouxagspdSVy2v6M5k+1tmyNQArVhT3jk2DYhlklAltQ01qe4i6UCdJL3IHM6UXI9ihte81Zoa/Z3BL+mbI3BY7iQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:29:53.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725076b7-2d06-4f52-008c-08df3f04cb91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

Now that everything is in place, add the Alternate Injection path to
KVM's interrupt handling flow.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/irq.c                 |  3 +++
 arch/x86/kvm/svm/sev.c             | 30 +++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c             | 17 ++++++++++++++++-
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 4f96090c04c9..16da6d1678e5 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -95,6 +95,7 @@ KVM_X86_OP_OPTIONAL(sync_pir_to_irr)
 KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
+KVM_X86_OP_OPTIONAL_RET0(has_interrupt)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL(link_external_spt)
 KVM_X86_OP_OPTIONAL(set_external_spte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bfa0188d372f..985d7f4d7140 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1873,6 +1873,7 @@ struct kvm_x86_ops {
 	u32 (*get_interrupt_shadow)(struct kvm_vcpu *vcpu);
 	void (*patch_hypercall)(struct kvm_vcpu *vcpu,
 				unsigned char *hypercall_addr);
+	int (*has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*inject_irq)(struct kvm_vcpu *vcpu, bool reinjected);
 	void (*inject_nmi)(struct kvm_vcpu *vcpu);
 	void (*inject_exception)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 5f7e5f3e5528..c781ce916fbd 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -111,6 +111,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_has_injectable_intr);
  */
 int kvm_cpu_has_interrupt(struct kvm_vcpu *v)
 {
+	if (kvm_x86_call(has_interrupt)(v))
+		return 1;
+
 	if (kvm_cpu_has_extint(v))
 		return 1;
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 78b8487627ed..543851bfb94d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5958,7 +5958,7 @@ bool sev_snp_ai_queue_exception(struct kvm_vcpu *vcpu)
 	return true;
 }
 
-static void __maybe_unused sev_snp_ai_inject_irq(struct kvm_vcpu *vcpu)
+static void sev_snp_ai_inject_irq(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic;
 	int irq, trig_mode;
@@ -5981,12 +5981,32 @@ static void __maybe_unused sev_snp_ai_inject_irq(struct kvm_vcpu *vcpu)
 
 bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 {
-	if (!sev_snp_is_rinj_active(vcpu))
-		return false;
+	struct vcpu_svm *svm = to_svm(vcpu);
 
-	__sev_snp_inject(type, vcpu);
+	if (!vcpu->plane_level) {
+		if (!sev_snp_is_rinj_active(vcpu)) {
+			return false;
+		} else {
+			__sev_snp_inject(type, vcpu);
+			return true;
+		}
+	} else {
+		if (sev_snp_is_ai_active(vcpu)) {
+			if (svm->sev_es.cancel_flag) {
+				svm->sev_es.cancel_flag = false;
+				return sev_snp_ai_inject(vcpu);
+			}
+			if (type == INJECT_NMI)
+				sev_snp_ai_update_doorbell(INJECT_NMI, vcpu, 0, 0);
+			if (type == INJECT_MCE)
+				sev_snp_ai_update_doorbell(INJECT_MCE, vcpu, 0, 0);
+			if (type == INJECT_IRQ)
+				sev_snp_ai_inject_irq(vcpu);
+			return sev_snp_ai_inject(vcpu);
+		}
+	}
 
-	return true;
+	return false;
 }
 
 void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 96d31fabb292..7c4b3d05ae88 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -395,6 +395,9 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	if (sev_snp_queue_exception(vcpu))
 		return;
 
+	if (sev_snp_ai_queue_exception(vcpu))
+		return;
+
 	svm->vmcb->control.event_inj = ex->vector
 		| SVM_EVTINJ_VALID
 		| (ex->has_error_code ? SVM_EVTINJ_VALID_ERR : 0)
@@ -3976,6 +3979,9 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
 	if (sev_snp_is_rinj_active(vcpu))
 		return sev_snp_blocked(INJECT_NMI, vcpu);
 
+	if (sev_snp_is_ai_active(vcpu))
+		return sev_snp_ai_blocked(INJECT_NMI, vcpu);
+
 	if (is_guest_mode(vcpu) && nested_exit_on_nmi(svm))
 		return false;
 
@@ -4011,6 +4017,9 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 	if (sev_snp_is_rinj_active(vcpu))
 		return sev_snp_blocked(INJECT_IRQ, vcpu);
 
+	if (sev_snp_is_ai_active(vcpu))
+		return sev_snp_ai_blocked(INJECT_IRQ, vcpu);
+
 	if (is_guest_mode(vcpu)) {
 		/* As long as interrupts are being delivered...  */
 		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
@@ -4054,6 +4063,9 @@ bool svm_mce_blocked(struct kvm_vcpu *vcpu)
 	if (sev_snp_is_rinj_active(vcpu))
 		return sev_snp_blocked(INJECT_MCE, vcpu);
 
+	if (sev_snp_is_ai_active(vcpu))
+		return sev_snp_ai_blocked(INJECT_MCE, vcpu);
+
 	return false;
 }
 
@@ -4065,7 +4077,7 @@ static int svm_mce_allowed(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int __maybe_unused svm_has_interrupt(struct kvm_vcpu *vcpu)
+static int svm_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	int ret = 0;
 	unsigned int state;
@@ -4413,6 +4425,8 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 	sev_snp_cancel_injection(vcpu);
 
+	sev_snp_cancel_ai_injection(vcpu);
+
 	control->exit_int_info = control->event_inj;
 	control->exit_int_info_err = control->event_inj_err;
 	control->event_inj = 0;
@@ -5431,6 +5445,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_interrupt_shadow = svm_set_interrupt_shadow,
 	.get_interrupt_shadow = svm_get_interrupt_shadow,
 	.patch_hypercall = svm_patch_hypercall,
+	.has_interrupt = svm_has_interrupt,
 	.inject_irq = svm_inject_irq,
 	.inject_nmi = svm_inject_nmi,
 	.is_vnmi_pending = svm_is_vnmi_pending,
-- 
2.43.0

