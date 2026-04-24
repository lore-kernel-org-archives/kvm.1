Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4F3E51CE;
	Fri, 24 Apr 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052666; cv=fail; b=dcwXvhN9+84HKTAkgHBEErboyB3oISCX5OPWeEoYSo+HVUeFOrSdeHF960SWDrnpe1Xc86YLOv0HSXIq8b1oAg8989jeOy8rMs3shYVHfDpXVw31axJ5RgtgyLn/rdQBzANLHPbzUcvVr9qxVX8003VYB5VY5MTsmLAQ8mwCY8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052666; c=relaxed/simple;
	bh=ru49WWwQ/SvD+6Rih9tj+G4pL3EKWYYElme8/pwny8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaxXflTT3XnQVYmt+/im+R0rNAodAsHEJM1cbNxn614KM9Yun3JS9PTM0RpqKCyoGZo/iChI3pNVoWV9pb+cgMI+IYGiETn4DxBByPIK1p/CQ0Xf19ZXWGWk4t2+Ou2XZ7XS2kbYjVuXQUdFA5mzVZdcENf4Mk8aSIpMViZ/ybg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A3pRWlr3; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A3pRWlr3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObPjX4F7ti3vsbIn1EjIIeTntpxd9eKRwC9hznROZuUcq3e4JukJjHH2+XCYo0CarbsK8IKOmEwZTLRnSckypQHjPE6KzALk6LaXoCukcQZNlwzOs9+9K9zqYNocy1Gyogeh2ynvZPhyvSfn7ZtAw5E6pNVhioVGdR0z6JcwizS6mqA0ZBzjVi+TLKa5IcuFxfQn3a8qvRkTb8LOF+4+oZrezV+aFr1ODcaS5Pxhhb+8sx+tjPtmZshI1atF20dY148G8F8Ef6K8eEOMg8TDYkCrl5i3yWPVPFo0BQiZG++Rn3rv/GZ8oJa9DfHDpKHpnRQWKHOBKUiEv98FQuqQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQSAsg9kc+3egGHicWrwKCgL0Cg/oFKzxUcFVnVrWac=;
 b=PwUlUkZNFByoSmaY6iN+RTDhoWDC97Ahl+uGHz9NNqYGbbtipaWSEfuZlgoHZPrP7kx6xHiQ90y+8pXpzC2HpChiL8OWWI7WFo4K57Q8V5h6Y3DvilPWiya7jllgWPOY44z4HUjSucSJ2efQWYlkLjy6qyctt9W36jmv8V9Qs3xQqUugy2B2dNqDsQC6cAH6LxXuAJoOJnIesAV2kYd1H7pwHMO+ztSUjj98/6htK27fYMSU/ELIgpqqQ07TcqDHrsxi42m1d6+24FIP+aY6N0eMvKKyvhN0lrMYgUqlQKh01UPTvSDtvr8n0ZdC0fnm5SudOuTQpslf5M2MStZyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQSAsg9kc+3egGHicWrwKCgL0Cg/oFKzxUcFVnVrWac=;
 b=A3pRWlr3f64zUrb0r9nbhg7m5H4GkgzntiHALuIlwJYDELudoHqMuw3yCt7nxaGWtS6gkLRExF/O+AwVef0WnHtYy+Qvaij6ufQxQnojFEhhxi9y9s0GbuY1CDrbdPLpD/UNdTZr9W90Y0V14Pohk6aSeK8/eAe2GhzoF1egPAo=
Received: from BN0PR04CA0032.namprd04.prod.outlook.com (2603:10b6:408:e8::7)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 17:44:20 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::3d) by BN0PR04CA0032.outlook.office365.com
 (2603:10b6:408:e8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 17:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:44:20 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:44:17 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH v4 4/7] KVM: SVM: Inject NMIs when Restricted Injection is active
Date: Fri, 24 Apr 2026 17:42:08 +0000
Message-ID: <4ffbc51b5793aedc56f0be34e727ad7621ee0598.1777048608.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|SA5PPFB29794CA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b9c1e4-7eaa-469b-7a5d-08dea2291d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RyD4sl3EInua3oTRzalPq3AMp7TD1JeBBDOCp7mKSHKUetDSn1jaq397PexhOYsKiBKmVew0r7tH7Ql3Y8L8KxadFbNrJQz52/BKJh9G7At93xnsFmNQ3NJe1O/17H+mwtLLSSBUh4PBbkpuaOBN2ert7SMPKw9fLqFb3qThQVOCrQ1rUJp6d828vsehHT8cMnvWuClzsQ8pw1xdMxBpoNLutlkC+Mf9ZI3ffq/a7mm7LyUNe5sVl6Dd1d+0pMIpWVwMxxJpnh5l2gXRXCrk1EkTs2Q0g7waDGxmtews5K826PeRfwv9XhWw4dwhFgXv9BGDyz/9nfKNEzNS8wtuaoOYrpshsfnkHNFv6Plh48ZmgXWZoXuSTyT1LwaioQPedlLBdfj/Jr9C6yPtW4jwEWHYXL9QDO96kdiyNhEvIhaYhtinCztd5RaBmxdlB4fCuyBQBcL68xqPWmmZPIM5fqyLFh1Xqlzxsz/q/SgHZACWzKXc6k+cLM9NlB51idLFbqDZnKtID+QLhv/Uzeby1X/xLg9EMRpbjnXq3GETywekoxiqU6U6y8HvfyFsFkOBcCqG4nB66zkk+xGmGuZ3/8Ud2worptSypB3/ctHky8aL0WEpKzGvmy5v0GPnsItWbosDjXD7nVgZzfH6yzrSYe9ei0xFyEtBoh7sZQb0dvtq1I4jxIgPUbM3tCvF9kfx9nmu8inXV0PEZUtSmQYzg1U5+Vww7uZUfYtwNAq+nFtTSjQbt19mZYHYV889HeNF+vF7qB4W1BenV8u9Iq9TtA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qOfAPICP8vGYl5Ggw/vJwlOBRxwT7tAgo9Wt/pIXC19VZ29LeJ3wignuFDQI6YjbjnoT1PK0ER7oelbo0vV+UJpbuZOHd3w15xxxSjzQN1tQXpDti5sGYzKxfB8nYtgH1YhjAMPZG9TSF1bl2apBoqBlrH3llEkawWKbpAzP8zeCiONgtwyDBfErPlhNvIRn5xyf1Dl85wNS+42q7AWxAJW1pjzZR0GBIZ2y3bojHSGzW/6YXsdywLC0yLdFgxdsOiqaQhlq++jVTZRW8yzSrPCfBfxVFEWLU0HWF4UExSuvtxsmDpy5lmWPr/d+jXj1tRo9j+1jaKXkrgID5zpeK2luTL6ADQcjamZ8Fp98FUNjA4NTHsjlkEuYHxiu9/cjMTzgOobyBNuHcaaUXm2E8/dIV9eVEKfIsHfnH8xvMYDyZXYVsGsjC6Vk+xgCdQ2o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:44:20.2843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b9c1e4-7eaa-469b-7a5d-08dea2291d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1

When Restricted Injection is active, only #HV exceptions can be injected
into the SEV-SNP guest.

Detect that, and then follow the #HV doorbell communication from the GHCB
specification to inject NMIs.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/kvm/svm/sev.c | 19 ++++++++++++++++---
 arch/x86/kvm/svm/svm.c |  8 ++++++++
 arch/x86/kvm/svm/svm.h |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 509a4f8b5073..61e1e54deb07 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5369,7 +5369,10 @@ static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 		return;
 	}
 
-	hvdb->events.vector = vcpu->arch.interrupt.nr;
+	if (type == INJECT_NMI)
+		hvdb->events.nmi = 1;
+	else
+		hvdb->events.vector = vcpu->arch.interrupt.nr;
 
 	prepare_hv_injection(svm, hvdb);
 
@@ -5449,10 +5452,17 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
 	/* Copy info back into event_inj field (replaces #HV) */
 	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID;
 
+	/*
+	 * KVM only injects a single event each time (prepare_hv_injection),
+	 * so when events.nmi is true, the vector will be zero
+	 */
 	if (hvdb->events.vector)
 		svm->vmcb->control.event_inj |= hvdb->events.vector |
 						SVM_EVTINJ_TYPE_INTR;
 
+	if (hvdb->events.nmi)
+		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_NMI;
+
 	hvdb->events.pending_events = 0;
 
 out:
@@ -5478,8 +5488,11 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 	if (!hvdb)
 		return true;
 
-	/* Indicate interrupts blocked based on guest acknowledgment */
-	blocked = !!hvdb->events.vector;
+	/* Indicate NMIs and interrupts blocked based on guest acknowledgment */
+	if (type == INJECT_NMI)
+		blocked = hvdb->events.nmi;
+	else
+		blocked = !!hvdb->events.vector;
 
 	unmap_hvdb(vcpu, &hvdb_map);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 739cffe12cd1..925e284374b6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3727,6 +3727,9 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	if (sev_snp_inject(INJECT_NMI, vcpu))
+		goto status;
+
 	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
 
 	if (svm->nmi_l1_to_l2)
@@ -3741,6 +3744,8 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
 		svm->nmi_masked = true;
 		svm_set_iret_intercept(svm);
 	}
+
+status:
 	++vcpu->stat.nmi_injections;
 }
 
@@ -3957,6 +3962,9 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
 	if (!gif_set(svm))
 		return true;
 
+	if (sev_snp_is_rinj_active(vcpu))
+		return sev_snp_blocked(INJECT_NMI, vcpu);
+
 	if (is_guest_mode(vcpu) && nested_exit_on_nmi(svm))
 		return false;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index b4627884c36f..16cb76b9fdd5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -57,6 +57,7 @@ extern struct kvm_x86_ops svm_x86_ops __initdata;
 
 enum inject_type {
 	INJECT_IRQ,
+	INJECT_NMI,
 };
 
 /*
-- 
2.43.0

