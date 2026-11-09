Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194377;
	b=PArEJ2UMN6Dngw5fUzXvDcpzRejtUBZBnk3wyk5OqdAoqbpgWqXOJzvrZ26C9Gnw36r8
	 Vj5bpkowxk8q3VJqHuagBqR62Lf4U+WnDEv9AGgn09ENHoOmuSRR49yH2GQhdlPf9Aygi
	 t4QF5rQ/vkrpGPBaQhWo0b6bg7ZZd7xpeGAmrK3z79tn7PK5uj/F7H0OnZHPYhv70x8Xo
	 29HbxMw8SM3DQZWGZyjs52dKl529MWpehUfmBA9+jQg3fveGTS8DguCtQDseQHODSJRCN
	 LmcEfm37rUJTs/G+K6yPx1YjhggXUwwFSjiEBYjD6qdrj3Hn0+OwNYA2r9FnVLKYQ9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194377;
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
	bh=d8RFusmL21fwUnf0o+m08qUXFwhauB7LVAgsI39pjSk=;
	b=uVTEJ1KUUtCgHku/E+vOMPI4aQ34ntsd4aQzLeAUOSNybFghNJuIIFmgPG51fHqWYM0y
	 PQG8GpmUvY6yMyereoQhnTZaiOrDSkL9gctDnXSlsF43SKcsQ6J92j11YdN1GXMDDW270
	 a3xlGDShfZPu+WH5SoyvJrvAjJY0JTTS14tRZ2h6E09v5737BxV2fmG2w1eWSb6THRCge
	 MkZZR+ZaFTfT/hn58Khv7J3C61GHhnyrb8i5dSmsv2GuMsuj3kk0G8xJJ47H6VHxcGLpK
	 X80SB3+vRPZdZlrvHZwz97R9yx1f4weSna0JZ4fwfAPL5INFLCKaaC0BJnCBo4WEkPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rxrfABTV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.32
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012032.outbound.protection.outlook.com [40.107.200.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E53606A335;
	Mon,  9 Nov 2026 03:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E53606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rxrfABTV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUd8Et1LZg6d8DVowXFLjRkd7de+rWPBJZ0/QMgHO2+6ded12eqCjWfgyTz258r30mIkxVHZ1BQkJB/LWFoXiI1WByU8dE/nxhnCmFVf0gZJUZ8rOaOvFOcTKk57Eiwzw9qRaCp5dtRSbO8mNP7nei6CPU5NAen0y8kZT/abJwO83Gr32r5K9wSSObGNi4ofInRbNO95lLXgi9E9W1kuahyzv6i2i4vQv+gy9+Qsxxp9Ig8t6nM/NN7IfAaxgKCOuuNQiFnnZJ1uNsH3+SGcLZA1a4IEF5CojUCKTapR0dDE2IMzWUMFHNdXJvDuxlrHb8kCIovF9myDxQ48anXDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8RFusmL21fwUnf0o+m08qUXFwhauB7LVAgsI39pjSk=;
 b=N2oemHUsAN06g+5ctMnDiHizkdJrHKO7yxKQni5OHeQhRxvDkkJVnHVCDivk+XdFg9GJ67x6pn5fpaeOKracFQifdQPO6SOaokVzTvKpJB/no+vWBW2hdteSVoaay22AeNWBTHANl+ujf009HV271POESrbwUR4aE11rOwq9M3pIOYzZc+AlddBCYUJNGpMhTi07ukdl7O+5h6kZJHcyQxgfJoh9Vp5ZIFCV8TQcbFKwKilloCiBQDdDo88dnLKRZOSoPoMBsPjknKZbFfBZNdP57wUqJMPq2IeM2sqp6hx0TSMquIib3ITvTeVNRJGzHJmaKQmBAV69R7gTymjVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8RFusmL21fwUnf0o+m08qUXFwhauB7LVAgsI39pjSk=;
 b=rxrfABTV3TEmmlIDz+VMSG9eNxgqeG/Q05DyDhUwSEkVPOPSKn4cUMfJezZ5k7b4XZ2/OXS3Awns3ZoH7C/IiKiQIA9KoMgoJ3eHVA8FbexzwrGe0req+J9MiTJ/EyItkq0/AmlAnHjrlzrCDNOIgBHmuY3ckU2vdwv343lh0Ts=
Received: from CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::23)
 by DS4PR12MB004847.namprd12.prod.outlook.com (2603:10b6:8:502::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:19:32 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::56) by CH5P223CA0006.outlook.office365.com
 (2603:10b6:610:1f3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:19:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:19:31 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:19:31 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>,
	"Thomas Lendacky" <thomas.lendacky@amd.com>
Subject: [RFC PATCH v5 3/8] KVM: SVM: Inject #HV when Restricted Injection is active
Date: Mon, 9 Nov 2026 03:18:35 +0000
Message-ID: <f871c2fe5ecca64bf9820d2b9628a52e57062916.1794171754.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DS4PR12MB004847:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d924cd-0b12-48b1-7589-08df3e1045b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021135927099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261102130727099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fapsYpAfpApxt0qO2MAHfVlXhJmzpehLUKub2STUMQaVxsN1RMPbEXrgDTIcfc8hR2pvggVFMaSFftA1EvhP621JQj/13XaN6JVzFDBZWryAqVJM1emu85riiAdCAYwhltMKCNDm7ZiSpIP58bPZtwQxeVnPgKpu2mtY00/Sb7vM/z5/+CYaPjN8RqRi/POBbHQ602CXbQUGW0JhX1Zh2KAHhr7omL9W3N6X4ObqGbDFGKGC4koevA9PX5/4iIKapGSKO7D0aDv4FACUJMdhxRdTZUOmTzKjRmI1zepl2AqUhYkl7DL1hSzO4FGL/bpgbdujci2BnFR6I/kgzPEUikYts0UaD+Q7sucU+efq9QNdxTL7+XkKOhsK9lOt+CGBjOG7YoXW/CgZNA+PAy+QeUvnqQupKiZuQe3OHG/U5EmLFnL2O8F2Ye2ZvoLMgYsIq512UAfe0kjOTLYBpIsnnqTLuwebtlpeTN5qxl2qfupCQ2g9NeKzDgHm20cA3i28mfxpY8BeA7ku1YOjJk6CMiDHiB29nI2ado7Ydi+eKaB2sDnr65c2QiG4rHKu3A+jzYfz9UkivmsJpLsyI1udOtizBkC7xM7IpxqbgYtxZPxN3xhvUz8aAg0M+iz94t5FKQZDOY0uzecUrIQedxEyjFU6eAhhB6siNJCNC79UQ0JwY/R+lmBMX/PRi2gCZjuXwp4hVtShU61IDroAPk5DLw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102130727099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UApe33Kswvz6JcMoobgMhsw3W7IsNDCByikLzKGxpXbu9lFYip2RNyUg2DBCHyaM65DZK656am0wfP+AGFhf+jOaSsiUhDFHmkprgcaYjAiKH+9+pLOP6rWGqxbWTl0hP2GCphzBHkmqszsKzpn6BhP4MKe/LNkeISWbqoBBGyxNzv+Hf/ons95A6oJFFhxvSflpD3OneMcMU49KkFkh1GAju6pZ5uZj3J3ejd6oUciXlRhJg1OZXg2Eqlq7XTbL5IjlIgtYHmGSSmHNsVe3Kk5YKAAZ5UjUvYQZxkp9JA3Agy25VqiA3tUTUlXiW+fbcOTPTPAKCbu1gfhwFbC9Hy3LS/BtVPJlZlaQu6T9ZkuGiGFoOXb81uWZnD57eZv4x2TXtuHDBYGwMkw64voKGu/ImiBCEcXdW6lK0lItEuz6IDOfiuej4Yy+QKiPuaaN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:19:31.9056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d924cd-0b12-48b1-7589-08df3e1045b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB004847

When Restricted Injection is active, only #HV exceptions can be injected
into the SEV-SNP guest.

Detect that, and then follow the #HV doorbell communication from the
GHCB specification to inject the interrupt or exception.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   2 +-
 arch/x86/kvm/i8259.c               |  45 +++--
 arch/x86/kvm/irq.c                 |  51 +++++-
 arch/x86/kvm/irq.h                 |   3 +
 arch/x86/kvm/lapic.c               |  34 +++-
 arch/x86/kvm/lapic.h               |   1 +
 arch/x86/kvm/svm/sev.c             | 253 +++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c             |  24 ++-
 arch/x86/kvm/svm/svm.h             |  28 ++++
 10 files changed, 421 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e213c9ae3e30..2074c2050c55 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -96,6 +96,7 @@ KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
+KVM_X86_OP_OPTIONAL_RET0(is_noack_required)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
 KVM_X86_OP_OPTIONAL(free_external_spt)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3af7395c2430..4de443140c53 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1618,7 +1618,7 @@ struct kvm_x86_ops {
 	void (*enable_nmi_window)(struct kvm_vcpu *vcpu);
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
-
+	bool (*is_noack_required)(struct kvm_vcpu *vcpu);
 	const bool x2apic_icr_is_split;
 	const unsigned long required_apicv_inhibits;
 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 6a942ac622d5..63853a612a83 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -229,7 +229,7 @@ static inline void pic_intack(struct kvm_kpic_state *s, int irq)
 
 }
 
-int kvm_pic_read_irq(struct kvm *kvm)
+static int __kvm_pic_read_irq(struct kvm *kvm, unsigned int *pending, bool ack)
 {
 	int irq, irq2, intno;
 	struct kvm_pic *s = kvm->arch.vpic;
@@ -239,32 +239,57 @@ int kvm_pic_read_irq(struct kvm *kvm)
 	pic_lock(s);
 	irq = pic_get_irq(&s->pics[0]);
 	if (irq >= 0) {
-		pic_intack(&s->pics[0], irq);
+		if (ack)
+			pic_intack(&s->pics[0], irq);
 		if (irq == 2) {
 			irq2 = pic_get_irq(&s->pics[1]);
-			if (irq2 >= 0)
-				pic_intack(&s->pics[1], irq2);
-			else
+			if (irq2 >= 0) {
+				if (ack)
+					pic_intack(&s->pics[1], irq2);
+				intno = s->pics[1].irq_base + irq2;
+			} else {
 				/*
 				 * spurious IRQ on slave controller
 				 */
-				irq2 = 7;
-			intno = s->pics[1].irq_base + irq2;
+				if (ack) {
+					irq2 = 7;
+					intno = s->pics[1].irq_base + irq2;
+				} else {
+					intno = -1;
+				}
+			}
 		} else
 			intno = s->pics[0].irq_base + irq;
 	} else {
 		/*
 		 * spurious IRQ on host controller
 		 */
-		irq = 7;
-		intno = s->pics[0].irq_base + irq;
+		if (ack) {
+			irq = 7;
+			intno = s->pics[0].irq_base + irq;
+		} else {
+			intno = -1;
+		}
 	}
-	pic_update_irq(s);
+
+	if (ack)
+		pic_update_irq(s);
+	else
+		*pending = hweight8(s->pics[0].irr) + hweight8(s->pics[1].irr);
 	pic_unlock(s);
 
 	return intno;
 }
 
+int kvm_pic_read_irq(struct kvm *kvm)
+{
+	return __kvm_pic_read_irq(kvm, 0, true);
+}
+int kvm_pic_read_irq_noack(struct kvm *kvm, unsigned int *pending)
+{
+	return __kvm_pic_read_irq(kvm, pending, false);
+}
+
 static void kvm_pic_reset(struct kvm_kpic_state *s)
 {
 	int irq;
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 871977288272..061a6fee9261 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -125,7 +125,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_has_interrupt);
  * Read pending interrupt(from non-APIC source)
  * vector and intack.
  */
-int kvm_cpu_get_extint(struct kvm_vcpu *v)
+static int __kvm_cpu_get_extint(struct kvm_vcpu *v, unsigned int *pending, bool ack)
 {
 	if (!kvm_cpu_has_extint(v)) {
 		WARN_ON(!lapic_in_kernel(v));
@@ -141,31 +141,68 @@ int kvm_cpu_get_extint(struct kvm_vcpu *v)
 #endif
 
 #ifdef CONFIG_KVM_IOAPIC
-	if (pic_in_kernel(v->kvm))
-		return kvm_pic_read_irq(v->kvm); /* PIC */
+	if (pic_in_kernel(v->kvm)) {
+		if (ack)
+			return kvm_pic_read_irq(v->kvm); /* PIC */
+		else
+			return kvm_pic_read_irq_noack(v->kvm, pending); /* PIC */
+	}
 #endif
 
 	WARN_ON_ONCE(!irqchip_split(v->kvm));
 	return get_userspace_extint(v);
 }
+
+int kvm_cpu_get_extint(struct kvm_vcpu *v)
+{
+	return __kvm_cpu_get_extint(v, 0, true);
+}
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_get_extint);
 
+int kvm_cpu_get_extint_noack(struct kvm_vcpu *v, unsigned int *pending)
+{
+	return __kvm_cpu_get_extint(v, pending, false);
+}
 /*
  * Read pending interrupt vector and intack.
  */
-int kvm_cpu_get_interrupt(struct kvm_vcpu *v)
+static int __kvm_cpu_get_interrupt(struct kvm_vcpu *v, unsigned int *pending, bool ack)
 {
-	int vector = kvm_cpu_get_extint(v);
+	int vector;
+
+	if (ack)
+		vector = kvm_cpu_get_extint(v);
+	else
+		vector = kvm_cpu_get_extint_noack(v, pending);
 	if (vector != -1)
 		return vector;			/* PIC */
 
-	vector = kvm_apic_has_interrupt(v);	/* APIC */
-	if (vector != -1)
+	if (ack)
+		vector = kvm_apic_has_interrupt(v);     /* APIC */
+	else
+		vector = kvm_apic_has_interrupt_noack(v, pending);	/* APIC */
+
+	if (ack && vector != -1)
 		kvm_apic_ack_interrupt(v, vector);
 
 	return vector;
 }
 
+int kvm_cpu_get_interrupt(struct kvm_vcpu *v)
+{
+	bool ack = kvm_x86_call(is_noack_required)(v) ? false : true;
+
+	return __kvm_cpu_get_interrupt(v, 0, ack);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_get_interrupt);
+
+int kvm_cpu_get_interrupt_noack(struct kvm_vcpu *v, unsigned int *pending)
+{
+
+	return __kvm_cpu_get_interrupt(v, pending, false);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_get_interrupt_noack);
+
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu)
 {
 	if (lapic_in_kernel(vcpu))
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index a74f03858004..2e917d089f1e 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -64,6 +64,7 @@ struct kvm_pic {
 int kvm_pic_init(struct kvm *kvm);
 void kvm_pic_destroy(struct kvm *kvm);
 int kvm_pic_read_irq(struct kvm *kvm);
+int kvm_pic_read_irq_noack(struct kvm *kvm, unsigned int *pending);
 void kvm_pic_update_irq(struct kvm_pic *s);
 int kvm_pic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 		    int irq_source_id, int level, bool line_status);
@@ -116,7 +117,9 @@ int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_cpu_has_extint(struct kvm_vcpu *v);
 int kvm_cpu_get_extint(struct kvm_vcpu *v);
+int kvm_cpu_get_extint_noack(struct kvm_vcpu *v, unsigned int *pending);
 int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
+int kvm_cpu_get_interrupt_noack(struct kvm_vcpu *v, unsigned int *pending);
 
 static inline void kvm_warn_on_lost_irq(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e1f3cea14765..037a4599d6f1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -757,6 +757,23 @@ void kvm_apic_clear_irr(struct kvm_vcpu *vcpu, int vec)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_clear_irr);
 
+static unsigned int apic_count_irr(struct kvm_lapic *apic)
+{
+	unsigned int count = 0;
+	u32 reg;
+
+	if (!apic->irr_pending)
+		return 0;
+
+	for (int i = 1; i < 8; i++) {
+		reg = kvm_lapic_get_reg(apic, APIC_IRR + i * 0x10);
+		if (reg)
+			count += hweight32(reg);
+	}
+
+	return count;
+}
+
 static void *apic_vector_to_isr(int vec, struct kvm_lapic *apic)
 {
 	return apic->regs + APIC_ISR + APIC_VECTOR_TO_REG_OFFSET(vec);
@@ -3172,7 +3189,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	return -ENOMEM;
 }
 
-int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu)
+static int __kvm_apic_has_interrupt(struct kvm_vcpu *vcpu, unsigned int *pending, bool ack)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	u32 ppr;
@@ -3183,11 +3200,26 @@ int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu)
 	if (apic->guest_apic_protected)
 		return -1;
 
+	if (!ack) {
+		*pending = apic_count_irr(apic);
+		return apic_search_irr(apic);
+
 	__apic_update_ppr(apic, &ppr);
 	return apic_has_interrupt_for_ppr(apic, ppr);
 }
+
+int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu)
+{
+	return __kvm_apic_has_interrupt(vcpu, 0, true);
+}
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_has_interrupt);
 
+int kvm_apic_has_interrupt_noack(struct kvm_vcpu *vcpu, unsigned int *pending)
+{
+	return __kvm_apic_has_interrupt(vcpu, pending, false);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_has_interrupt_noack);
+
 int kvm_apic_accept_pic_intr(struct kvm_vcpu *vcpu)
 {
 	u32 lvt0 = kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVT0);
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index bd1098c89d99..8530a6333bdd 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -127,6 +127,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu);
 void kvm_free_lapic(struct kvm_vcpu *vcpu);
 
 int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu);
+int kvm_apic_has_interrupt_noack(struct kvm_vcpu *vcpu, unsigned int *pending);
 void kvm_apic_ack_interrupt(struct kvm_vcpu *vcpu, int vector);
 int kvm_apic_accept_pic_intr(struct kvm_vcpu *vcpu);
 int kvm_apic_accept_events(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index da07fe476f3d..e4a074df7434 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -36,6 +36,8 @@
 #include "svm_ops.h"
 #include "cpuid.h"
 #include "trace.h"
+#include "lapic.h"
+#include "irq.h"
 
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
@@ -4387,6 +4389,8 @@ static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
 		kvm_vcpu_unmap(vcpu, &hvdb_map);
 
 		svm->sev_es.hvdb_gpa = hvdb_gpa;
+		svm->sev_es.pending_vector = 0;
+		svm->sev_es.no_eoi_required = 0;
 		fallthrough;
 	case SVM_VMGEXIT_HVDB_QUERY:
 		if (svm->sev_es.hvdb_gpa == INVALID_PAGE)
@@ -4396,6 +4400,8 @@ static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
 		break;
 	case SVM_VMGEXIT_HVDB_CLEAR:
 		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+		svm->sev_es.pending_vector = 0;
+		svm->sev_es.no_eoi_required = 0;
 		break;
 	default:
 		svm->sev_es.hvdb_gpa = INVALID_PAGE;
@@ -5474,3 +5480,250 @@ void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa)
 
 	free_page((unsigned long)vmsa);
 }
+
+static void prepare_hv_injection(struct vcpu_svm *svm, struct hvdb *hvdb)
+{
+	if (hvdb->events.no_further_signal)
+		return;
+
+	svm->vmcb->control.event_inj = HV_VECTOR |
+				       SVM_EVTINJ_TYPE_EXEPT |
+				       SVM_EVTINJ_VALID;
+	svm->vmcb->control.event_inj_err = 0;
+
+	hvdb->events.no_further_signal = 1;
+}
+
+static void unmap_hvdb(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
+{
+	kvm_vcpu_unmap(vcpu, map);
+}
+
+static struct hvdb *map_hvdb(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!VALID_PAGE(svm->sev_es.hvdb_gpa))
+		return NULL;
+
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->sev_es.hvdb_gpa), map)) {
+		vcpu_unimpl(vcpu, "snp: error mapping #HV doorbell page [%#llx] from guest\n",
+			    svm->sev_es.hvdb_gpa);
+
+		return NULL;
+	}
+
+	return map->hva;
+}
+
+void sev_snp_handle_ri_ack(struct kvm_vcpu *vcpu, struct hvdb *hvdb, int num_pending)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/* Guest ack interrupt, move it from irr to isr */
+	if (svm->sev_es.pending_vector && !hvdb->events.vector) {
+		kvm_apic_ack_interrupt(vcpu, svm->sev_es.pending_vector);
+		svm->sev_es.pending_vector = 0;
+	}
+
+	/*
+	 * no_eoi_required was set last time, means maybe an EOI is pending for the
+	 * interrupt it was just acked by the guest, if the guest cleared
+	 * no_eoi_requirement that means guest will not wrmsr EOI but let the hypervisor
+	 * send a EOI for it, this way, the VMEXIT which is expensive is saved.
+	 */
+	if (svm->sev_es.no_eoi_required &&
+	    !hvdb->events.no_eoi_required &&
+	    !svm->sev_es.pending_vector) {
+		kvm_lapic_set_eoi(vcpu);
+		svm->sev_es.no_eoi_required = 0;
+	}
+	/*
+	 * If there is only one interrupt pending in IRR, no_eoi_required should be set,
+	 * and the host should record it. If there is multiple interrupt pending in IRR,
+	 * no_eoi_required should not be set since some interrupts need to be delovered
+	 * immediately.
+	 */
+	if (num_pending == 1) {
+		hvdb->events.no_eoi_required = 1;
+		svm->sev_es.no_eoi_required = 1;
+	} else {
+		hvdb->events.no_eoi_required = 0;
+		svm->sev_es.no_eoi_required = 0;
+	}
+}
+
+static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb) {
+		WARN_ONCE(1, "Restricted Injection enabled, hvdb page mapping failed\n");
+		return;
+	}
+
+	hvdb->events.vector = vcpu->arch.interrupt.nr;
+	svm->sev_es.pending_vector = vcpu->arch.interrupt.nr;
+
+	prepare_hv_injection(svm, hvdb);
+
+	unmap_hvdb(vcpu, &hvdb_map);
+}
+
+static void __sev_snp_reinject(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb) {
+		WARN_ONCE(1, "Restricted Injection enabled, hvdb page mapping failed\n");
+		return;
+	}
+
+	prepare_hv_injection(svm, hvdb);
+
+	unmap_hvdb(vcpu, &hvdb_map);
+}
+
+
+bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!sev_snp_is_rinj_active(vcpu))
+		return false;
+
+	/*
+	 * Restricted Injection is enabled, only #HV is supported.
+	 * If the vector is not HV_VECTOR, do not inject the exception,
+	 * then return true to skip the original injection path.
+	 */
+	if (WARN_ONCE(vcpu->arch.exception.vector != HV_VECTOR,
+		      "Restricted Injection enabled, exception vector %u injection not supported\n",
+		      vcpu->arch.exception.vector))
+		return true;
+
+	/*
+	 * An intercept likely occurred during #HV delivery, so re-inject it
+	 * using the current HVDB pending event values.
+	 */
+	svm->vmcb->control.event_inj = HV_VECTOR |
+				       SVM_EVTINJ_TYPE_EXEPT |
+				       SVM_EVTINJ_VALID;
+	svm->vmcb->control.event_inj_err = 0;
+
+	return true;
+}
+
+bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!sev_snp_is_rinj_active(vcpu))
+		return false;
+
+	if (svm->sev_es.cancel_flag) {
+		__sev_snp_reinject(vcpu);
+		svm->sev_es.cancel_flag = false;
+		return true;
+	}
+
+	__sev_snp_inject(type, vcpu);
+
+	return true;
+}
+
+void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+
+	if (!sev_snp_is_rinj_active(vcpu))
+		return;
+
+	if (!svm->vmcb->control.event_inj)
+		return;
+
+	if (WARN_ONCE((svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK) != HV_VECTOR,
+			"Restricted Injection enabled,  %u vector not supported\n",
+			svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK))
+		return;
+
+	/*
+	 * Copy the information in the doorbell page into the event injection
+	 * fields to complete the cancellation flow.
+	 */
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb)
+		return;
+
+	if (!hvdb->events.pending_events) {
+		/* No pending events, then event_inj field should be 0 */
+		WARN_ON_ONCE(svm->vmcb->control.event_inj);
+		goto out;
+	}
+
+	/* Copy info back into event_inj field (replaces #HV) */
+	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID;
+
+	if (hvdb->events.vector)
+		svm->vmcb->control.event_inj |= hvdb->events.vector |
+						SVM_EVTINJ_TYPE_INTR;
+
+	hvdb->events.no_further_signal = 0;
+	svm->sev_es.cancel_flag = true;
+
+out:
+	unmap_hvdb(vcpu, &hvdb_map);
+}
+
+bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
+{
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	bool blocked;
+	int irq;
+
+	/* Indicate interrupts are blocked if doorbell page can't be mapped */
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb)
+		return true;
+
+	/* Indicate interrupts blocked based on guest acknowledgment */
+	if (type == INJECT_IRQ) {
+		irq = kvm_cpu_get_interrupt(vcpu);
+		if (irq < hvdb->events.vector && hvdb->events.vector)
+			blocked = !!hvdb->events.vector;
+		else
+			blocked = false;
+	}
+
+	unmap_hvdb(vcpu, &hvdb_map);
+
+	return blocked;
+}
+
+void sev_snp_update_ri_status(struct kvm_vcpu *vcpu)
+{
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	unsigned int num_pending;
+
+	if (!sev_snp_is_rinj_active(vcpu))
+		return;
+
+	hvdb = map_hvdb(vcpu, &hvdb_map);
+	if (!hvdb)
+		return;
+
+	kvm_cpu_get_interrupt_noack(vcpu, &num_pending);
+	sev_snp_handle_ri_ack(vcpu, hvdb, num_pending);
+
+	unmap_hvdb(vcpu, &hvdb_map);
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index da7abf0c39fe..601807a8f2fa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -397,6 +397,9 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	    svm_update_soft_interrupt_rip(vcpu, ex->vector))
 		return;
 
+	if (sev_snp_queue_exception(vcpu))
+		return;
+
 	svm->vmcb->control.event_inj = ex->vector
 		| SVM_EVTINJ_VALID
 		| (ex->has_error_code ? SVM_EVTINJ_VALID_ERR : 0)
@@ -3875,9 +3878,11 @@ static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 	}
 
 	trace_kvm_inj_virq(intr->nr, intr->soft, reinjected);
-	++vcpu->stat.irq_injections;
 
-	svm->vmcb->control.event_inj = intr->nr | SVM_EVTINJ_VALID | type;
+	if (!sev_snp_inject(INJECT_IRQ, vcpu))
+		svm->vmcb->control.event_inj = intr->nr | SVM_EVTINJ_VALID | type;
+
+	++vcpu->stat.irq_injections;
 }
 
 static void svm_fixup_nested_rips(struct kvm_vcpu *vcpu)
@@ -4052,6 +4057,9 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 	if (!gif_set(svm))
 		return true;
 
+	if (sev_snp_is_rinj_active(vcpu))
+		return sev_snp_blocked(INJECT_IRQ, vcpu);
+
 	if (is_guest_mode(vcpu)) {
 		/* As long as interrupts are being delivered...  */
 		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
@@ -4090,6 +4098,14 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return 1;
 }
 
+static bool svm_is_noack_required(struct kvm_vcpu *vcpu)
+{
+	if (!sev_snp_is_rinj_active(vcpu))
+		return false;
+
+	return true;
+}
+
 static void svm_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4415,6 +4431,8 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_control_area *control = &svm->vmcb->control;
 
+	sev_snp_cancel_injection(vcpu);
+
 	control->exit_int_info = control->event_inj;
 	control->exit_int_info_err = control->event_inj_err;
 	control->event_inj = 0;
@@ -4646,6 +4664,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	svm_complete_interrupts(vcpu);
 
+	sev_snp_update_ri_status(vcpu);
 	/*
 	 * Update the cache after completing interrupts to get an accurate
 	 * NextRIP, e.g. when re-injecting a soft interrupt.
@@ -5407,6 +5426,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.enable_nmi_window = svm_enable_nmi_window,
 	.enable_irq_window = svm_enable_irq_window,
 	.update_cr8_intercept = svm_update_cr8_intercept,
+	.is_noack_required = svm_is_noack_required,
 
 	.x2apic_icr_is_split = true,
 	.set_virtual_apic_mode = avic_refresh_virtual_apic_mode,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f212f2e68d87..f0db48d62fcf 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -58,6 +58,10 @@ extern int tsc_aux_uret_slot __ro_after_init;
 
 extern struct kvm_x86_ops svm_x86_ops __initdata;
 
+enum inject_type {
+	INJECT_IRQ,
+};
+
 /*
  * Clean bits in VMCB.
  * VMCB_ALL_CLEAN_MASK might also need to
@@ -278,6 +282,9 @@ struct vcpu_sev_es_state {
 	bool snp_has_guest_vmsa;
 
 	gpa_t hvdb_gpa;
+	u8 pending_vector;
+	u8 no_eoi_required;
+	bool cancel_flag;
 };
 
 struct vcpu_svm {
@@ -1019,6 +1026,19 @@ void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
+bool sev_snp_queue_exception(struct kvm_vcpu *vcpu);
+bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu);
+void sev_snp_cancel_injection(struct kvm_vcpu *vcpu);
+bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu);
+void sev_snp_update_ri_status(struct kvm_vcpu *vcpu);
+void sev_snp_handle_ri_ack(struct kvm_vcpu *vcpu, struct hvdb *hvdb, int num_pending);
+static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
+
+	return is_sev_snp_guest(vcpu) &&
+		(sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION);
+};
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1046,6 +1066,14 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 	return NULL;
 }
 static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
+
+static inline bool sev_snp_queue_exception(struct kvm_vcpu *vcpu) { return false; }
+static inline bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
+static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
+static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
+static inline void sev_snp_update_ri_status(struct kvm_vcpu *vcpu)i {};
+static inline void sev_snp_handle_ri_ack(struct kvm_vcpu *vcpu, struct hvdb *hvdb, int num_pending) {};
+static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { return false; }
 #endif
 
 /* vmenter.S */
-- 
2.43.0

