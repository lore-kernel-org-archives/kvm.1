Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE8288AD;
	Fri, 24 Apr 2026 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052695; cv=fail; b=sSvQ3qKdkH5uwWYLWrMmBlQWy8zyl7EqXy+MZP5D1pLVN8ui7r01vwJFueyFTNdQkCw7Rgi2PDF6OJupu3YbJzs9SVGcBms/d4rFkSBY/NQkj126B5bT9mMfGOIfKicmCb4nu7PJ+GRXAFV1XkTVzImEslDl8+rjHhxuazKlin4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052695; c=relaxed/simple;
	bh=Qp87BENs8m7xnRm9JzX/gcUG7CdahfuN2Vy2jGRJnBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tf+jmolnZ9rmAe/g2jkby3ba0NCTdnX+YE8LXBI8VJcQyhKaqMph7mXU84/tRi3qNNb7baRuS9Cy3ompumEJh/vlqknQrDvJfL58EczAJjZDLIsLBTx/wc52GOBLVwq7ocgq07CR67kl20CEzdxjC55VvGb4YiAjW/HLgsCREUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wamKIKsD; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wamKIKsD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs6qw4+cH4n2/aa9FVcoDnsFIfDYJI5X98Vdmas3SOkUzHs6edCzZC4ekNnRhhfr6qPCkcAWM/0BPP/I4ol815byqQ68cJriCK1O2S+qPJqF/ZKSAqNs/lLie/ONFL8no0tZT3idnvLR4qCpJHw2z0wDbQfHYeLCnoxay14Gkvk6Y/2SOWqjRkQD7QZQovoLrc7U3T/ssj1C4ec4XCPO/Xlnd1m5l0SXsEhzRE5uePKNCJ7aMaGsQmEUWeAq7RLSJCGeJ/C9SDH/nR8i1uISrkgWCopOKb2c8JD6RA7nfFKv1SytQPhv5JvgjxVkdWBNN3F+lSByle8znU+pbxsGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9dYgZREWi/ysJKxhXtLOcsxMtzFN0nw5MnVYYm82aU=;
 b=rb212UAHPgA27jo90ZEJbBVtPbn4ewJX5ayNUVllsO4pGy0fqDD7mFVduxYvy//WVGLbiu7zhzETE4pCub3NCmXiq0ql4WEwghhmDGYIJvnyFFLRIK6Vp0uHBpZFlQjk6xrQs3eDNCFHGPOGYiLeEX5qjxRCGqoIne3Z0BDiQEiFE3n8CNMaj7IKSo4+APAYt6l4ug1MNg54RB5qZ8BOujDd1sUNBYzy2kAOFZNBMaTnFY8b+EjizMG/DWEkvNG17PK7GbR9Pff7426Ra3vkv/lzPo69FTuOuZAws7DGJcCoRGTe7Ew54CIeW6zMf/WH4fWFcTxWP2/Mm4FhxVyVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9dYgZREWi/ysJKxhXtLOcsxMtzFN0nw5MnVYYm82aU=;
 b=wamKIKsDJT2wnKdmxP8y4aDHn1skDTQOamfGNpwO9DFpHHdLrl+uE51USZ7d+0+Tm+ZjbnVOGRehz4326EIgO5W/Gs8+fEzr/UOMEkwwY26pwvL5Nft6iZbW9Nm2bAS/WxjEIQb+uXh0cR9QhrOR4doOZRyHHiAYvYzrP0rvgWs=
Received: from MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:44:49 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::b3) by MN2PR16CA0049.outlook.office365.com
 (2603:10b6:208:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 17:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:44:48 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:44:47 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH v4 5/7] KVM: SVM: Inject MCEs when Restricted Injection is active
Date: Fri, 24 Apr 2026 17:42:09 +0000
Message-ID: <51f8c478c5fc09b3bdeb8329c682a01fbe0ea5db.1777048608.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777048608.git.huibo.wang@amd.com>
References: <cover.1777048608.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 48930d4d-88b4-4413-cf32-08dea2292e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qPUVZ/3wVXbrn4uLTj8nDTYi9yFzjChYXFaXnf83tttMbcniaWASGK9/sYFa4fPyJlFryMiCGsLyl7cw3iJhcRxeA/COdSPrwzxumnue1HJ+jOuD7yCymOJGGQWiqXcmsmBDHnrpxtpxXM4Ms9QDw86gG3+egLoMESw7K8xI1EVpv5wCquFY1DadeddGNj4e1VzqP/kBrJDjFPDLyFfoKG+g3vp4yEqcBFGCWZrmMyPjI6hoM2Z6eHh3AAfLN4wW38zRRR5wC/JrkvQshQYsupr/jAmcq7LFmLfpelHQCiEN4EyBAtxd2rofvbBEEx50x0lrO3qDR5N8lc7ggVRq0zRhD2vqyFgPNZdSEQbVH5AyK7zi0aC/u8e6PbfTktAVn66cvo0U42bueqSB6uHHS3JXzjLKvriN9gltohKcbWLVSvLAP2duGA8R0K27aJAqVAN7+qbGt5Id1xIxGkO1Bfro26k77nfRyVpsOZepVM53QS5RgEUOpAf6p0fYmAtfco851OvWI96TFpwwfCOI38oKZZVQcs5nbSPJuOIVlOAJ1mEYaz+OD+WKLw8Bov/jjVWp7X4rWIr2ABUWWysuKySWMMXTzx54grRQpFKLmqWRnq/gtzi3zze7RVWNLa8A9nyJkeB6QaDWxS1vLzPmR+pNdrZAaXAS7BcH4foiDsXsr9sqH4qdhGd8SKylihXdA1d5Yfk43J0u4J6a5xiThyeBsah+QEc57InWLz0XmCafzANGmv66PTj+sw3k/Cw0PrFnAmkU7ULKfSgnpJpG5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k0ECEmdyf3eu3E3kFYpHoPfmzi52jLIQeM7fwnbFYSXLuho+7f+mB+j/xj5QqEkdXbcqdUzOVoOKhiMEXqqjp+BZXhU49L07WG3iOf1wbNJIomgxsFv6eWJW84eyq0O1m/rmF93ggQgTgl2lQUm786lyZm6KdB1BmxCY/6nHV75vuskZPwBd9HO9TcKdvOw5pFe8mRZXSgMErkfgFnzzi4K2zAACqdERiH01dH/JzFmTkE8B9gP/7WbljqJ85QwLyGylhJ+AyU5OXk+RPqx4WJ0gZSHBoM21T7yf0IkCQDAa79hODXc9Du/upFx0D+b9iTNg3VnY6JION5HgfTNyOF4/nWLEoMdwJCHxc39MMqd/Q+LSHo3Ce1zOkOTR5+QMpvMT1M3DsfSMWyVm+f5vWQWeIxvgPSpDKfYdw1iQ+0JbYLozeE69IPpL8cQw3g9+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:44:48.7679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48930d4d-88b4-4413-cf32-08dea2292e57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

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
 arch/x86/kvm/svm/sev.c             | 16 ++++++++++++++--
 arch/x86/kvm/svm/svm.c             | 17 +++++++++++++++++
 arch/x86/kvm/svm/svm.h             |  2 ++
 arch/x86/kvm/vmx/main.c            | 10 ++++++++++
 arch/x86/kvm/vmx/vmx.c             |  5 +++++
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 |  7 +++++++
 9 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 3776cf5382a2..c8bff1e9325e 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -79,6 +79,7 @@ KVM_X86_OP(inject_exception)
 KVM_X86_OP(cancel_injection)
 KVM_X86_OP(interrupt_allowed)
 KVM_X86_OP(nmi_allowed)
+KVM_X86_OP_OPTIONAL(mce_allowed)
 KVM_X86_OP(get_nmi_mask)
 KVM_X86_OP(set_nmi_mask)
 KVM_X86_OP(enable_nmi_window)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..2e445fbc6796 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1860,6 +1860,7 @@ struct kvm_x86_ops {
 	void (*cancel_injection)(struct kvm_vcpu *vcpu);
 	int (*interrupt_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
 	int (*nmi_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
+	int (*mce_allowed)(struct kvm_vcpu *vcpu);
 	bool (*get_nmi_mask)(struct kvm_vcpu *vcpu);
 	void (*set_nmi_mask)(struct kvm_vcpu *vcpu, bool masked);
 	/* Whether or not a virtual NMI is pending in hardware. */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 61e1e54deb07..2483357bdd97 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5371,6 +5371,8 @@ static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 
 	if (type == INJECT_NMI)
 		hvdb->events.nmi = 1;
+	else if (type == INJECT_MCE)
+		hvdb->events.mce = 1;
 	else
 		hvdb->events.vector = vcpu->arch.interrupt.nr;
 
@@ -5386,6 +5388,11 @@ bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
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
@@ -5454,7 +5461,7 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
 
 	/*
 	 * KVM only injects a single event each time (prepare_hv_injection),
-	 * so when events.nmi is true, the vector will be zero
+	 * so when events.nmi is true, the MCE and vector will be zero.
 	 */
 	if (hvdb->events.vector)
 		svm->vmcb->control.event_inj |= hvdb->events.vector |
@@ -5463,6 +5470,9 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
 	if (hvdb->events.nmi)
 		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_NMI;
 
+	if (hvdb->events.mce)
+		svm->vmcb->control.event_inj |= MC_VECTOR | SVM_EVTINJ_TYPE_EXEPT;
+
 	hvdb->events.pending_events = 0;
 
 out:
@@ -5488,9 +5498,11 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 	if (!hvdb)
 		return true;
 
-	/* Indicate NMIs and interrupts blocked based on guest acknowledgment */
+	/* Indicate NMIs, MCEs and interrupts blocked based on guest acknowledgment */
 	if (type == INJECT_NMI)
 		blocked = hvdb->events.nmi;
+	else if (type == INJECT_MCE)
+		blocked = hvdb->events.mce;
 	else
 		blocked = !!hvdb->events.vector;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 925e284374b6..68bf30ab3a12 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4038,6 +4038,22 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return 1;
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
@@ -5351,6 +5367,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.cancel_injection = svm_cancel_injection,
 	.interrupt_allowed = svm_interrupt_allowed,
 	.nmi_allowed = svm_nmi_allowed,
+	.mce_allowed = svm_mce_allowed,
 	.get_nmi_mask = svm_get_nmi_mask,
 	.set_nmi_mask = svm_set_nmi_mask,
 	.enable_nmi_window = svm_enable_nmi_window,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 16cb76b9fdd5..9254a463041a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -58,6 +58,7 @@ extern struct kvm_x86_ops svm_x86_ops __initdata;
 enum inject_type {
 	INJECT_IRQ,
 	INJECT_NMI,
+	INJECT_MCE,
 };
 
 /*
@@ -798,6 +799,7 @@ void svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 void disable_nmi_singlestep(struct vcpu_svm *svm);
 bool svm_smi_blocked(struct kvm_vcpu *vcpu);
 bool svm_nmi_blocked(struct kvm_vcpu *vcpu);
+bool svm_mce_blocked(struct kvm_vcpu *vcpu);
 bool svm_interrupt_blocked(struct kvm_vcpu *vcpu);
 void svm_set_gif(struct vcpu_svm *svm, bool value);
 int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index dbebddf648be..f9c4703dda54 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -812,6 +812,15 @@ static void vt_cancel_hv_timer(struct kvm_vcpu *vcpu)
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
@@ -945,6 +954,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.cancel_injection = vt_op(cancel_injection),
 	.interrupt_allowed = vt_op(interrupt_allowed),
 	.nmi_allowed = vt_op(nmi_allowed),
+	.mce_allowed = vt_op(mce_allowed),
 	.get_nmi_mask = vt_op(get_nmi_mask),
 	.set_nmi_mask = vt_op(set_nmi_mask),
 	.enable_nmi_window = vt_op(enable_nmi_window),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..7aa728c1e946 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5210,6 +5210,11 @@ int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return !vmx_interrupt_blocked(vcpu);
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
index d09abeac2b56..b75dfe7f039d 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -92,6 +92,7 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu);
 void vmx_cancel_injection(struct kvm_vcpu *vcpu);
 int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection);
 int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
+int vmx_mce_allowed(struct kvm_vcpu *vcpu);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
 void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 void vmx_enable_nmi_window(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..420f1ec0dcfb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10789,6 +10789,12 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			kvm_update_dr7(vcpu);
 		}
 
+		if (vcpu->arch.exception.vector == MC_VECTOR) {
+			r = static_call(kvm_x86_mce_allowed)(vcpu);
+			if (!r)
+				goto out_except;
+		}
+
 		kvm_inject_exception(vcpu);
 
 		vcpu->arch.exception.pending = false;
@@ -10796,6 +10802,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 
 		can_inject = false;
 	}
+out_except:
 
 	/* Don't inject interrupts if the user asked to avoid doing so */
 	if (vcpu->guest_debug & KVM_GUESTDBG_BLOCKIRQ)
-- 
2.43.0

