Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299392;
	b=nvMqkFfEzRovQ2ymkAMC7vwh6KagYzKjihHfh17VCdJ23LsWirrDKHuEG52SFH3vwzWx
	 4tQ1XCGzCZfjKViWZn51yj5DvoTfFY5flhJKtttCV5Q7NrO+4dBC6TpHlktkWy4qtWuDv
	 GS1By8OKSQxWFF66wxku7+UqozXa9IEweNZRtaTl/ppU5JS4oRJgQVV1REk4ecAun/D2w
	 3ShKeJkJnBi7DwwcNaN/y1Sv2MTFmW3jRFoSi2u1/laDpyJoYcS03Big8H4w2oFQ4tLMy
	 uDLULI8LLlNPt0hzGwNW6dTS1mmP4FXxgHQ1VLd84/02fleKilmpymvV6Qyg2qbeUdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299392;
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
	bh=TsdNV5Gjgj29qumI2/bli3NuwPga4t+7w7n+gCt52kQ=;
	b=zfRoz/QBMv7Jyn9/4mfSixuLURIiD9czIp2tzEUTQKEtwqcjR6TU5xni7ORe7T6n6qvG
	 qU4ZiEnsi6/I7BXi4ev4zmadEEc7hWZ4ilotOgdhD5pusYHIvpozShy8I4oQnuuf/gwP6
	 V5EryNwgLzWq395vS4eJsuVMBGJXZE90Dvfk4L55Kc0gSam7WO9PV7ughuFa8kWxhMSRW
	 4CyE+cApx5XH1TmWIuxYuqFIrvSgvDGh+z1ntnuhUq9ybH61oCKPJ6MTSRb74mrGzxBlj
	 lgrKwYUvIPEtfJZfzEvB3ktQO9s+GeadyuuyHiKoQwmwGFqD2w52JY1lfuohy6JcxPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PkCAAxIm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.37
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761A606D020;
	Tue, 10 Nov 2026 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C761A606D020
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PkCAAxIm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/0YU/zvM42lE5+EoPANFpryrOqy6xHB3rWgNeGyomjZuYzzNt+cMRUR4/7/o0i3f89Qf2PjPgEGPcZfXC2zCtstztK/+Fxjt+gUm3sB1FT4CP7kLSDCmbT6+fcBxfJbf1ea4MnwFuWJka3ch5U7NK5mvy0zyiIzjGszOYdwhW/UuxSKhzgUjLrCM+lMHLNprbMxPs77g1Mw8TBzhTnGQKFeGRjqAhRthLBZv3AVxDEU7BXazhdex5WcXai8OVEjIbj22cBHLH/DInMkflprQplGjBSbi6ZD26Bqr5vSj1nXpf+hLz6mcrVnBe3sHyIzuYTEm/Ix6Osvl1XTnHblPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsdNV5Gjgj29qumI2/bli3NuwPga4t+7w7n+gCt52kQ=;
 b=IaJExPKlhwPbTLVMf0MNzI+AngvuKFVKESbRq079RGYrkbL/Ya3B1YKCNYRO0TmnjkITTzKsWq1tATPfpb0l3amh0pL0EIS0k3ltLUCl3lKg+c6XvCitVaJGf/x+BHFPf2htw7FG5yZUZmwPXF2KGvN3ud801NiTadc6v3W5vf6JUvj8t7i/+DawjqObT/3TZeGU14R1XP8vyuthFQyXKjAwYXPpmEN/A/rku60G+3AnPFj2PPXaGvjrfsSfBSfSfttVqfgs4n/eFV8MBjXG0RQW9mWXi8PsfURmaHC+/cTrVJdHPAr3bKsq4bo0u28G2sv32WhhRVLK38MliOkKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsdNV5Gjgj29qumI2/bli3NuwPga4t+7w7n+gCt52kQ=;
 b=PkCAAxImebc3WUK0r4Vwm4P/7DYyLWX+CFmCSp4lvU+E4ui3XL45xztEsZfG989sdYTvNnlGiYzVrlwDWLeuGa9973pZ2wIfxFRRY7HU7EEkxUt+ae4H404NMZEoD4E5XsWuFb+M2nwRfgj239opUOoU3EYTiuY1+T/BauVF11g=
Received: from BN9PR03CA0669.namprd03.prod.outlook.com (2603:10b6:408:10e::14)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 08:29:42 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::3a) by BN9PR03CA0669.outlook.office365.com
 (2603:10b6:408:10e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 08:29:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:29:42 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:29:41 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  3/9] KVM: SVM: Add Alternate Injection support
Date: Tue, 10 Nov 2026 08:28:48 +0000
Message-ID: <289ff0f00c83ae1a6bc851ba96d2d464e1102d0a.1794295647.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0c9724-2824-49d7-7c9a-08df3f04c4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|6133799003|10067099003|11063799006|261009223027099003|261102123227099003|261026121527099003|261028144727099003|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	sbscGMJyGl3w8NCDHB7BPX5yAy2yIAOvFXd/58fxrqVQqkkk+LuaPMDnclLbCMCHTSgr9cl6Pned5QypN2Q07cdrwyPWU6OLtVmvmUhdt3AhS6zq2dhnTTgth01xI+SFduwsR7/MOiVwIi+MGy2AmYNQ9TLuVvy20OltIhkfZxfF4OPDwzBwO8JPenZHhzmtVKTVRgoZs6omSBPRsrewFrfyqydsZhGjhAGFK3f4t9viu+KB+mvs07BndQsyAzuVVPYWM/OGol544tx/LxRcRHOG8mTwh1LQZ4k1XRztIM2RcEZAHZikIkNemGRcfkSsKsStxXjG7zwsTme86CCSQoC1rzF5O92CoqcWC44JWdkdeCK1r87WHa0qphV/aLkPCxkgG17o9o9Ar8V6sHLol03IIMfHBIagh9lWRU5Zk11/0B3/CiJdLwjrkBlxP93X/Zs7Mf7awOolbUiBcTbxiLyhICMQNPI+TBqYaZVNTYeN1gImSNzZ3fz28ZCzgHHFHDmqSH+ZpVbUPmvD4ViHPQOTjUInXN1vVSTJRcYzLn44JGnzhMzQOsqFmpEBLvnBb9rNeSZfCErHGnEkjQWtbEmq+qsaMIn7qn0rsiD67bDrjsTEGuYmKRg/5FFxoXTnoacRaVW2GIzToNUYZOu5U5NtNSS82mHKenW3VAtKS0XPAHL3ZPscs9n7kM53fSxGKH/9pjCP8QNjjQBLMEwzTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261009223027099003)(261102123227099003)(261026121527099003)(261028144727099003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	owmdsYCezG1nFEbVrw8SRyaaWgr0XYMIt0VGj++Ixjt3CSIaF8lZSmTjgKyJC8rxdfnH7lxUV2f3WB5UuqfO5hXimPyQ9fDF5c0MC62KCcBIq64GLKGVoPpGi35AQ3XAToPXW2u3Hfeq1J6MPCcBPjQLR0kdu2VgvJSWnHqVaM0lsbppauETVJJuS5D/M9bacfQdXrAHDVCsuTr+TZvxeLreYX7pny3Z8SiQRUj+vJ3X8abKrnKVmtogTwt9Bu7MAfr3oiX3+8T4P898c43mptuyINUiAV9AoZg+cfEgiyZOBeHbVVlTGEUS2lbe2IZbBufMPyQMTsmxQ4pLLrdktGzgssmwSBwtJ4iB/yjsAYxyAcV7Bvk5+6oGAEmOVdBcwur+7lGkjVd185eI2l8uGKA/JpMnh2nwzRgbL06xaDlQgiGx67kRcemCAk8y8TYF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:29:42.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0c9724-2824-49d7-7c9a-08df3f04c4e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555

To avoid breaking the other guests without Alternate Injection, add
new paths for Alternate Injection, which will isolate Alternate
Injection from other interrupt injection path.

Add new functions which supports Alternate Injection.

No functionality changes yet

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/kvm/irq.c     |   1 +
 arch/x86/kvm/svm/sev.c | 279 ++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c |  34 +++++
 arch/x86/kvm/svm/svm.h |  27 ++++
 4 files changed, 339 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index abce6cf24cb5..5f7e5f3e5528 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -165,6 +165,7 @@ int kvm_cpu_get_interrupt(struct kvm_vcpu *v)
 
 	return vector;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_get_interrupt);
 
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 924c1b968fdc..78b8487627ed 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5741,6 +5741,120 @@ static struct hvdb *map_hvdb(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
 	return map->hva;
 }
 
+bool sev_snp_doorbell_has_injectable_vector(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *vcpu_plane0;
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	bool ret = false;
+
+	vcpu_plane0 = vcpu->common->vcpus[0];
+	hvdb = map_hvdb(vcpu_plane0, &hvdb_map);
+	if (!hvdb)
+		return ret;
+
+	if (hvdb->events.vmpl2_irq)
+		ret = true;
+
+	unmap_hvdb(vcpu_plane0, &hvdb_map);
+
+	return ret;
+}
+
+bool sev_snp_ai_update_doorbell(enum inject_type type, struct kvm_vcpu *vcpu,
+				int vector, int trig_mode)
+{
+	struct kvm_vcpu *vcpu_plane0;
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+
+	if (vector < FIRST_EXTERNAL_VECTOR && (type == INJECT_IRQ))
+		return false;
+
+	vcpu_plane0 = vcpu->common->vcpus[0];
+	hvdb = map_hvdb(vcpu_plane0, &hvdb_map);
+	if (!hvdb)
+		return false;
+
+	if (type == INJECT_NMI) {
+		hvdb->events.irqs[1].nmi = 1;
+	} else if (type == INJECT_MCE) {
+		hvdb->events.irqs[1].mce = 1;
+	} else {
+		struct ext_irq_desc *vmpl2 = &hvdb->events.irqs[1];
+		unsigned long *bit_vec = (unsigned long *)vmpl2->interrupt_bit_vector;
+
+		if (!hvdb->events.vmpl2_irq) {
+			/* Only one interrupt is pending, queue it. */
+			vmpl2->si_vector = vector;
+			vmpl2->multi_interrupts = 0;
+			vmpl2->trigger_mode = trig_mode;
+		} else if (trig_mode && vmpl2->trigger_mode) {
+			/*
+			 * A higher prio level-triggered overwrites a previous,
+			 * lower prio, level-triggered one.
+			 */
+			if (vmpl2->si_vector < vector)
+				vmpl2->si_vector = vector;
+		} else if (trig_mode) {
+			/*
+			 * Level-triggered takes the single vector slot from the
+			 * pending edge-triggered one, which - if there still is
+			 * a single one - moves to the bit vector.
+			 */
+			if (vmpl2->si_vector)
+				set_bit(vmpl2->si_vector - FIRST_EXTERNAL_VECTOR, bit_vec);
+
+			vmpl2->si_vector = vector;
+			vmpl2->multi_interrupts = 1;
+			vmpl2->trigger_mode = trig_mode;
+		} else if (vector != vmpl2->si_vector) {
+			/*
+			 * Edge-triggered: set mult only when the new vector
+			 * that's being queued is not the currently pending one.
+			 * The already pending vector, if any, gets a bit too.
+			 */
+			set_bit(vector - FIRST_EXTERNAL_VECTOR, bit_vec);
+
+			if (vmpl2->si_vector)
+				set_bit(vmpl2->si_vector - FIRST_EXTERNAL_VECTOR, bit_vec);
+
+			vmpl2->si_vector = 0;
+			vmpl2->multi_interrupts = 1;
+		}
+		hvdb->events.vmpl2_irq = 1;
+	}
+
+	unmap_hvdb(vcpu_plane0, &hvdb_map);
+
+	return true;
+}
+
+bool sev_snp_ai_inject(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *vcpu_plane0;
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	struct vcpu_svm *svm0;
+
+	vcpu_plane0 = vcpu->common->vcpus[0];
+	svm0 = to_svm(vcpu_plane0);
+
+	hvdb = map_hvdb(vcpu_plane0, &hvdb_map);
+	if (!hvdb)
+		return false;
+
+	if (hvdb->events.no_further_signal)
+		goto unmap;
+
+	prepare_hv_injection(svm0, hvdb);
+
+unmap:
+	unmap_hvdb(vcpu_plane0, &hvdb_map);
+
+	return true;
+}
+
 static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5769,8 +5883,10 @@ bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (!sev_snp_is_rinj_active(vcpu))
-		return false;
+	if (!vcpu->plane_level) {
+		if (!sev_snp_is_rinj_active(vcpu))
+			return false;
+	}
 
 	if (vcpu->arch.exception.vector == MC_VECTOR) {
 		__sev_snp_inject(INJECT_MCE, vcpu);
@@ -5799,6 +5915,70 @@ bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+bool sev_snp_ai_queue_exception(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm_current = to_svm(vcpu);
+	struct kvm_vcpu *vcpu_plane0;
+	struct vcpu_svm *svm;
+
+	vcpu_plane0 = vcpu->common->vcpus[0];
+	svm = to_svm(vcpu_plane0);
+
+	if (!sev_snp_is_ai_active(vcpu))
+		return false;
+
+	if (vcpu->arch.exception.vector == MC_VECTOR) {
+		if (svm->sev_es.cancel_flag) {
+			svm_current->sev_es.cancel_flag = false;
+			return sev_snp_ai_inject(vcpu);
+		}
+		sev_snp_ai_update_doorbell(INJECT_MCE, vcpu, 0, 0);
+		return sev_snp_ai_inject(vcpu);
+	}
+
+	/*
+	 * Restricted injection is enabled, only #HV is supported.
+	 * If the vector is not HV_VECTOR, do not inject the exception,
+	 * then return true to skip the original injection path.
+	 */
+	if (WARN_ONCE(vcpu->arch.exception.vector != HV_VECTOR,
+		      "restricted injection enabled, exception %u injection not supported\n",
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
+static void __maybe_unused sev_snp_ai_inject_irq(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic;
+	int irq, trig_mode;
+
+	apic = vcpu->arch.apic;
+
+	irq = vcpu->arch.interrupt.nr;
+	trig_mode = !!(apic_test_vector(irq, apic->regs + APIC_TMR));
+	sev_snp_ai_update_doorbell(INJECT_IRQ, vcpu, irq, trig_mode);
+
+	do {
+		irq = kvm_cpu_get_interrupt(vcpu);
+		if (irq < 0)
+			break;
+
+		trig_mode = !!(apic_test_vector(irq, apic->regs + APIC_TMR));
+		sev_snp_ai_update_doorbell(INJECT_IRQ, vcpu, irq, trig_mode);
+	} while (true);
+}
+
 bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 {
 	if (!sev_snp_is_rinj_active(vcpu))
@@ -5863,6 +6043,70 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
 	unmap_hvdb(vcpu, &hvdb_map);
 }
 
+void sev_snp_cancel_ai_injection(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *vcpu_plane0;
+	struct vcpu_svm *svm0;
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!sev_snp_is_ai_active(vcpu))
+		return;
+
+	/*
+	 * AI is enabled for vmpl2 so supposed that the interrupts are
+	 * only for vmpl2, so cancel only for vmpl2
+	 */
+	vcpu_plane0 = vcpu->common->vcpus[0];
+	svm0 = to_svm(vcpu_plane0);
+	if (!svm0->vmcb->control.event_inj)
+		return;
+
+	if (WARN_ONCE((svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK) != HV_VECTOR,
+			"Alternate Injection enabled,  %u vector not supported\n",
+			svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK))
+		return;
+
+	/*
+	 * Copy the information in the doorbell page into the event injection
+	 * fields to complete the cancellation flow.
+	 */
+	hvdb = map_hvdb(vcpu_plane0, &hvdb_map);
+	if (!hvdb)
+		return;
+
+	if (!hvdb->events.irqs[1].ext_word0) {
+		/* No pending events, then event_inj field should be 0 */
+		WARN_ON_ONCE(svm0->vmcb->control.event_inj);
+		goto out;
+	}
+
+	/*
+	 * When the injection is cancelled, since the #HV is set in Plane0's
+	 * control.event_inj, clear this field, and copy the information back to current
+	 * Plane so it will be reinjected, but keep the data in the doorbell.
+	 */
+	svm0->vmcb->control.event_inj = 0;
+
+	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID;
+
+	if (hvdb->events.irqs[1].multi_interrupts || hvdb->events.irqs[1].si_vector)
+		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_INTR;
+
+	if (hvdb->events.irqs[1].nmi)
+		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_NMI;
+
+	if (hvdb->events.irqs[1].mce)
+		svm->vmcb->control.event_inj |= MC_VECTOR | SVM_EVTINJ_TYPE_EXEPT;
+
+	hvdb->events.no_further_signal = 0;
+	svm->sev_es.cancel_flag = true;
+
+out:
+	unmap_hvdb(vcpu_plane0, &hvdb_map);
+}
+
 /*
  * sev_snp_blocked() is for each vector - interrupt, NMI and MCE.  It is
  * checking if there is an interrupt handled by the guest when
@@ -5895,6 +6139,37 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 	return blocked;
 }
 
+bool sev_snp_ai_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
+{
+	struct kvm_host_map hvdb_map;
+	struct hvdb *hvdb;
+	bool blocked;
+	struct kvm_vcpu *vcpu_plane0;
+
+	vcpu_plane0 = vcpu->common->vcpus[0];
+
+	/* Indicate interrupts are blocked if doorbell page can't be mapped */
+	hvdb = map_hvdb(vcpu_plane0, &hvdb_map);
+	if (!hvdb)
+		return true;
+
+	/* Indicate NMIs, MCEs and interrupts blocked based on guest acknowledgment */
+	if (type == INJECT_NMI)
+		blocked = hvdb->events.irqs[1].nmi;
+	else if (type == INJECT_MCE)
+		blocked = hvdb->events.irqs[1].mce;
+	else
+		/* With Alternate Injection, there is a bitmap to save all of interrupts,
+		 * so no need to block any interrupt
+		 */
+		blocked = false;
+
+
+	unmap_hvdb(vcpu_plane0, &hvdb_map);
+
+	return blocked;
+}
+
 int sev_snp_max_planes(struct kvm *kvm)
 {
 	return vmpl_levels;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 705063c7f0f0..96d31fabb292 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4065,6 +4065,40 @@ static int svm_mce_allowed(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int __maybe_unused svm_has_interrupt(struct kvm_vcpu *vcpu)
+{
+	int ret = 0;
+	unsigned int state;
+
+	if (!sev_snp_is_ai_active(vcpu))
+		return ret;
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
+	ret = sev_snp_doorbell_has_injectable_vector(vcpu);
+
+	return ret;
+}
+
 static void svm_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d2e397542a84..1ec0a045b1ea 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -288,6 +288,7 @@ struct vcpu_sev_es_state {
 
 	gpa_t hvdb_gpa;
 	u8 hvdb_ai_vector;
+	bool cancel_flag;
 };
 
 struct vcpu_svm {
@@ -1002,6 +1003,13 @@ bool sev_snp_queue_exception(struct kvm_vcpu *vcpu);
 bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu);
 void sev_snp_cancel_injection(struct kvm_vcpu *vcpu);
 bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu);
+bool sev_snp_ai_queue_exception(struct kvm_vcpu *vcpu);
+bool sev_snp_doorbell_has_injectable_vector(struct kvm_vcpu *vcpu);
+bool sev_snp_ai_update_doorbell(enum inject_type type, struct kvm_vcpu *vcpu, int vector, int trig_mode);
+void sev_snp_cancel_ai_injection(struct kvm_vcpu *vcpu);
+bool sev_snp_ai_blocked(enum inject_type type, struct kvm_vcpu *vcpu);
+bool sev_snp_ai_inject(struct kvm_vcpu *vcpu);
+
 static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sev_info_plane *sev = &to_kvm_svm_plane(vcpu->plane)->sev_info_plane;
@@ -1009,6 +1017,18 @@ static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
 	return is_sev_snp_guest(vcpu) &&
 		(sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION);
 };
+
+static inline bool sev_snp_is_ai_active(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *vcpu_plane0 = vcpu->common->vcpus[0];
+	struct kvm_sev_info_plane *sev0 = &to_kvm_svm_plane(vcpu_plane0->plane)->sev_info_plane;
+	struct kvm_sev_info_plane *sev  = &to_kvm_svm_plane(vcpu->plane)->sev_info_plane;
+
+	return is_sev_snp_guest(vcpu) &&
+		(sev0->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION) &&
+		(sev->vmsa_features & SVM_SEV_FEAT_ALTERNATE_INJECTION);
+}
+
 int sev_nr_vcpu_planes(struct kvm *kvm);
 int sev_snp_max_planes(struct kvm *kvm);
 #else
@@ -1055,6 +1075,13 @@ static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
 static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
 static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { return false; }
 static inline unsigned sev_snp_max_planes(struct kvm *kvm) { return 1; }
+static inline bool sev_snp_ai_queue_exception(struct kvm_vcpu *vcpu) { return false; }
+static inline bool sev_snp_doorbell_has_injectable_vector(struct kvm_vcpu *vcpu) { return false; }
+static inline bool sev_snp_ai_update_doorbell(enum inject_type type, struct kvm_vcpu *vcpu, int vector, int trig_mode) { return false; }
+static inline void sev_snp_cancel_ai_injection(struct kvm_vcpu *vcpu) {}
+static inline bool sev_snp_ai_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
+static inline bool sev_snp_ai_inject(struct kvm_vcpu *vcpu) { return false; }
+static inline bool sev_snp_is_ai_active(struct kvm_vcpu *vcpu) { return false; }
 #endif
 
 /* vmenter.S */
-- 
2.43.0

