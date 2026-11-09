Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194419;
	b=zWLW/mkUQZaHf8WF/skUC38nr80dy0Kx8ic7qTt48X+Ls2aYXhUuPmQME+RB0D/I6asF
	 85j/53cb+MIXfOvuhDO2nxJUNlWIdZcpje17SUi7pRHEyoivUuy3Tbs/nWnYP8jnTJxm/
	 T5H6XUuBEzJEFNFHtqBT9M+WsAjL6KS0RikfcrTtFaExlvlW/nb5v0kNHJICDk8556WRv
	 0Rc93ZhGHP62Lun6YHYN+ULaKRIfM1EWshIRHIiX6fzLxhLEBkYx9yI5NXIsflLd1Dkt8
	 2pUp9HjxfQURDJddXfPXyTBJUripTBfEtQAB+BPXBXfT7hRQDqlK8xOtvuALG4gM5uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194419;
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
	bh=WMP7bl4nqbNRbY0adMAUAk4CyeD4e0DeAIf2EQvBDrM=;
	b=AHoQzAirbBqqWQiUe8THfvwqZgSvR1420MlIq/HQsdH2/lr9JbuWfczqXd7jOckQ0Oe8
	 21/Y1VfEImbl6staW4vdZpta4zWA1Didvale7smT9PUpockRHSRrUIvZ7yDgma3LbpfVH
	 HodQ+uy4o8u3WX9xC7DuGcWqfAM6cbPsUPm52KHEIyV8T8U4z0yEMeaeCQwUDQpWa3Frp
	 aNza9yDi9aJP2vIc+7iUKuuwa7oIU0ebzh/GxPw+TaOdP72Lp4A9MoplZwnA9TR1j+Rd3
	 MLQIBmII542ZzfFa22HbUcNmJNCiRQO2AgvKFouxPiai5FNbRJQ+zujQqEOrNn1Jt8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cxFvtpoC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.44
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C62606A320;
	Mon,  9 Nov 2026 03:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C62606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cxFvtpoC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib66QAB0Lzne0R5/IPFUYA73f8kGoG7HBMs062nQQ7XwhFnwpFPIm2aqadHOsoyLQO1dRahvNuHpr2f+uVNi7HynTItxbFK4lDqbLphpuZRDl7LEvPZWISupQLxCKFvG44aW0XYQletRKdzDcE3H1BkcOBFG12Fdp2iy6ceHzWdhrAAu95aRV0qcKl2008Kokfko9C2NAsvjY9oK+XrHLb1GrRELQXT276a8i+WFSCI0bWyC//mhyi8+ySGSmEmIiUKT3HiokQ0efPMbwvR8TVI0OBKCD7fDbRufdfW2IvI5WiBB1aOmsl3iXmn3NEqX5QvFxEJ8RWuI8o06GvdRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMP7bl4nqbNRbY0adMAUAk4CyeD4e0DeAIf2EQvBDrM=;
 b=GPSJeF/JfPVWHDfWItN+oZ7XMv2LgYXX8WZcIBrS89/apY6hIIFWq8XMcXV05pQYnW/xx4599GVcQYKsy9n4+7AziZt+IrjGZHskuyYYW05oMyKjDD2DkRFdv6uZ/h+0tp/jGxt+woluOUbONxWFcNHsxesAzTUHtt5VvfFM+EOXNOHDbYROjC+j9ml0f8uPx/XkyVv5MQdmzXcQY0asRSGFRWbZDVH35w5uYlvNkPy0e0AhUE6O85mztKRqK7RNLyHerEpxwSE2/PiisUvxW0s++X2cAT5io6SxJAB146drHW4bY/iKVYj8P4LR/fQ83XrQcNOuVslYP3jxZ0TUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMP7bl4nqbNRbY0adMAUAk4CyeD4e0DeAIf2EQvBDrM=;
 b=cxFvtpoCA/otUeLVI0BrjsVRt4vpTbtUsFzVMU7deniChNHeqrN/Ph+aBWbRMcWmHhPfLp9/Rw5mAlzz16108VwtPfT4DlsEZ7f6YD9YzG0dEqO3486/m42zD2cOQ0pW9/1v0cCGXRNa1V+Y+XAFa3dg+FOuW2jO6U+nMj2nsbM=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 03:20:12 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::6b) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:20:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:20:11 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:20:09 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH v5 6/8] KVM: SVM: Handle HLT intercept when Restricted Injection is enabled.
Date: Mon, 9 Nov 2026 03:18:38 +0000
Message-ID: <d9490eaad48062f0e8cd1a0e4f6312d04d012095.1794190621.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794190621.git.huibo.wang@amd.com>
References: <cover.1794190621.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: a673b746-2a8d-41d6-98cd-08df3e105d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|11063799006|56012099006|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	e+QOPUOBQgThymIjIFEiWGphIv70rKPUdlb8QdZ+dSuNXuQde7QkqjjeP2VTkVDMEfFp/TDe8QbP+4uKnNzynfYwo8IRDlBR+xXm22ipmWbAjDPB0Pu+ZyPIgw64bQMWo+FRzQjroKKUzHw3BEDyD5R4gjWehcDn+ERYzw8mp66ENkCa7JFaQbVfO/73CX8ZWayMDhCA3KWR30+t7gP/YqZkw0hsmU4mr1eVdxAelmm7uFWRTIrr9MWLVGXGGsvsB6/lgNOPIqc0uc3Rp0A91X/6aAMgCoxVux/q9sCJdVdZK+BPbPXOreOnT+ILIHHKEGL6FXTSuuxbZFyXtTHKDD9jXLwRiMQ4rUcK1p8jEeSjyHUYzvo+5qoD4VjLeeRdjppukEYvYWSh2eXUOnYRVtsYUzvppcrZHWCotJjs/+e3fKUBzgZjLivU0fLMU4KQtA//XT2b7TY/YdxDHwxQeQgq+pUCZ0SQkx/8qZ4GKtFOFhZBR07yyFtwwqDpen81ehP+CGa5+sO5FnuWsT+xR4CZobeC05DY1tL2bGBoHSdtXsw4qqwn8STLyzfhtyyEBWVMEQnb0d4iC+HorjIkDdm6WCiDrxShmaotzN67E2qmRo5QifjoTNKEXaZwfU7ykisFTAn/6FouseRRQ7kJr3u6MuzwPT11tfHM9H0m3+sWEar4fsR3eX4gEeQ0dFEUVYkUMPy1bb4w/eQf+Dshkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fMIPVsRc7tUQue4Tr8H+I/DOpWUA3huUJnnsItMKkvbFYvVwSwpuA2KdKwnTP/WE6Zh0XV1/XCclzoGZJQXDDH9V5YgKKijPHZmt3owtyVJ8IJsTFS5JWJUXBNANdpQu33JJpVfOF3LLwWxJjAUBJ80dLoVlj11KqdLYqD6Xa2XftDkTlBhGPbgIVvya2UJ5U6Lg3dnfO6OidKQpX3dUEwR/hHksjLH0D/dPZ84x5PrDhCwi0k/1LmHA7GneYJR+uMyetHKjzBGm+6n/TEMFIGwWwVxBtHGy4+T8DrTgXVooPWmNMelwwprhtcJHjWxTu2/Y/U/WBO8KmqVjSNLq/VdHTrjzQBi66SCGj9Q/DV5v66aEeijpnhVwQHx2PvsYWU47uFfRTpBOfvm70PF91zwi77tWCxXlpnE/r10+7YXm4M0ls1Y1okPZisaCBZgA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:20:11.8566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a673b746-2a8d-41d6-98cd-08df3e105d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901

With SEV-SNP Restricted Injection enabled, #HV events are delivered
without regard to interrupt shadows, causing guests to lose control over
the interaction between HLT and interrupts. Under this convention,
a guest entering a halt state executes HLT with interrupts disabled
rather than checking pending interrupt state or enabling interrupts
first. If the host intercepts HLT while the guest has any interrupts or
non-maskable events pending, KVM must immediately re-enter the guest.

Intercept HLT when Restricted Injection is enabled, immediately re-enter
the guest if any pending events including the pending events in the HV
doorbell page exist.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/sev.c             | 19 +++++++++++++
 arch/x86/kvm/svm/svm.c             | 44 ++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h             |  2 ++
 arch/x86/kvm/x86.c                 |  3 ++
 6 files changed, 70 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e3da9fb0b2b6..9396e2c661ab 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -98,6 +98,7 @@ KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
 KVM_X86_OP_OPTIONAL_RET0(is_noack_required)
+KVM_X86_OP_OPTIONAL_RET0(hv_doorbell_has_events)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
 KVM_X86_OP_OPTIONAL(free_external_spt)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fa83477ebcab..f3690a5dc953 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1620,6 +1620,7 @@ struct kvm_x86_ops {
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
 	bool (*is_noack_required)(struct kvm_vcpu *vcpu);
+	bool (*hv_doorbell_has_events)(struct kvm_vcpu *vcpu);
 	const bool x2apic_icr_is_split;
 	const unsigned long required_apicv_inhibits;
 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6a1262c274ff..9aafa6167ae6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5748,3 +5748,22 @@ void sev_snp_update_ri_status(struct kvm_vcpu *vcpu)
 
 	unmap_hvdb(vcpu, &hvdb_map);
 }
+
+bool sev_snp_hvdb_has_events(struct kvm_vcpu *vcpu)
+{
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	bool has_events;
+
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb) {
+		WARN_ONCE(1, "Restricted Injection enabled, hvdb page mapping failed\n");
+		return false;
+	}
+
+	has_events = hvdb->events.vector || hvdb->events.nmi || hvdb->events.mce;
+
+	unmap_hvdb(vcpu, &hvdb_map);
+
+	return has_events;
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ad99b2b1b07b..ff22a79e0ddd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4130,6 +4130,49 @@ static int svm_mce_allowed(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static bool svm_hv_doorbell_has_events(struct kvm_vcpu *vcpu)
+{
+	unsigned int state;
+	int irq;
+	unsigned int num_pending = 0;
+
+	if (!sev_snp_is_rinj_active(vcpu))
+		return false;
+
+	/*
+	 * Evaluate vCPU events before the #HV doorbell page, as
+	 * kvm_vcpu_has_events() bypasses them under Restricted Injection.
+	 */
+	irq = kvm_cpu_get_interrupt_noack(vcpu, &num_pending);
+	if ((vcpu->arch.exception.pending && vcpu->arch.exception.vector == MC_VECTOR) ||
+	     vcpu->arch.nmi_pending || irq >= 0)
+		return true;
+
+	/*
+	 * Mapping the #HV doorbell page via kvm_vcpu_map() can sleep (e.g.,
+	 * on page faults). In the HLT fast-path, local IRQs are disabled, so
+	 * invoking kvm_vcpu_map() there can trigger a panic. To avoid sleeping
+	 * in atomic context, assume an event is pending during the fast-path
+	 * and defer the actual check until re-entering outside the fast-path.
+	 *
+	 * A related issue occurs during normal vCPU block polling:
+	 * kvm_vcpu_block() sets the task state to TASK_INTERRUPTIBLE before
+	 * calling kvm_vcpu_check_block(). If kvm_vcpu_map() sleeps during that
+	 * check, waking up resets the task state to TASK_RUNNING, causing the
+	 * subsequent schedule() to return immediately instead of blocking.
+	 *
+	 * Therefore, avoid calling kvm_vcpu_map() from
+	 * svm_hv_doorbell_has_events() unless the task state is TASK_RUNNING,
+	 * preventing both sleeping with IRQs disabled and livelocks during
+	 * vCPU blocking.
+	 */
+	state = get_current_state();
+	if (irqs_disabled() || state != TASK_RUNNING)
+		return true;
+
+	return sev_snp_hvdb_has_events(vcpu);
+}
+
 static void svm_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5452,6 +5495,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.enable_irq_window = svm_enable_irq_window,
 	.update_cr8_intercept = svm_update_cr8_intercept,
 	.is_noack_required = svm_is_noack_required,
+	.hv_doorbell_has_events = svm_hv_doorbell_has_events,
 
 	.x2apic_icr_is_split = true,
 	.set_virtual_apic_mode = avic_refresh_virtual_apic_mode,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e19b398a3df5..2d4996445b78 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1035,6 +1035,7 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu);
 bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu);
 void sev_snp_update_ri_status(struct kvm_vcpu *vcpu);
 void sev_snp_handle_ri_ack(struct kvm_vcpu *vcpu, struct hvdb *hvdb, int num_pending);
+bool sev_snp_hvdb_has_events(struct kvm_vcpu *vcpu);
 static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
@@ -1076,6 +1077,7 @@ static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
 static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
 static inline void sev_snp_update_ri_status(struct kvm_vcpu *vcpu)i {};
 static inline void sev_snp_handle_ri_ack(struct kvm_vcpu *vcpu, struct hvdb *hvdb, int num_pending) {};
+static inline bool sev_snp_hvdb_has_events(struct kvm_vcpu *vcpu) { return false; }
 static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { return false; }
 #endif
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1492a06a6935..f8295c5ffb50 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8515,6 +8515,9 @@ static bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 
 bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 {
+	if (kvm_x86_call(hv_doorbell_has_events)(vcpu))
+		return true;
+
 	if (!list_empty_careful(&vcpu->async_pf.done))
 		return true;
 
-- 
2.43.0

