Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86A3F4DE7
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585936; cv=fail; b=P7Zw1btnyZ0iVp/ycvWzH4Icfgo78INM8Bd2OwoqTu80oEDdfFScAv5Rs9yaK8DjKvoOkzvmRyoFzQdip+XUt+kiBlaHw13SIXfTkxTeLXIzXO5rUOm/4CQW34GhQUAXB/uH2dLMpC/hBb3hLM6eciBxXfF73a8tCJINvmSjw3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585936; c=relaxed/simple;
	bh=W97ZQDkAqodYuKERGdFA5NAlKjJECIEzTMdAN2aBSLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD8m4atsI9Ict+466TxuxgL7ENrqFnrquDuK8AStTX/nO9bs9AYtljuPVQh7UiQyJMD3j7fZG7CVkvYhg0hmCps3IQbBhEOQXnarUzypph7Gwabs5Qndkl7mxMUvBKH7lYwFrlCIP5LQrDIlAjdVX68bHE3MsHBnk5SSrx3svmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YnAQtQOC; arc=fail smtp.client-ip=52.101.193.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YnAQtQOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIcsuG4V7rbg5oedUBYIsiyGFgTdLKsEJMR8MKjaB1SbGDnT587kmF0AKgRDJIZXq5C+qyN+C6OMI7U9rMKGsI5/doXWsRG7oll7ImLoEo24x86eJipBi9YBJry7iEK3ZvIYd4VKSIE4yl8JnovGYqSoiZ3HplhnbAPWsytmoy5HP89WreVO+xMWg5HbWIKfaUrnzCgIYtVJVxccXwGUdPaUMQ5rwOxrBwwJnDbTRsnyHivwr059e+UqIOxc+iqqWsuqJqXMfnMXXrPW7+5QZWvZBsW8xuQZIc8haXrNBg1OxSmymb+TxIpHQqW3hduqrMf4aByuVA4b5N/wFzHYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYi4OrILclYe7yOSCDtYITeH4xsL0KTtssp0Goc4VHs=;
 b=Oe3o2wWJMbkj7uvoplZaUx3qIuavPkb5Tlp4rrFTKrbEoIQg3boIMcgHUO27srhQ2ZfNsSoDGTxm+paTVDSMIQB19B5fb95FNlb4pBCkiDwiBD9hLc5a3j4VIq6lbW7KKCuks9Gyi9IyYZ97XgLqH/D3aRNN9JVA2gISzSGqrmGW5YuyB9hrpzRjTdgTvQpYBnZ8t1tnvSgYtpKgnglTunns1Qlz3r4PO/GF96WcrLlBV2z8lJ50BbB2VIXuyggaGXcP32dpKtXjK/A7jxnBcVsatFBmrJ38doJJts+duCMqf1Gp8y9vTax5jtAfnKqFMCJQbvgYd0n7z/v6PjKqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYi4OrILclYe7yOSCDtYITeH4xsL0KTtssp0Goc4VHs=;
 b=YnAQtQOC0skOwnPxfjNIuqfsRbX6WWl6MTJyFXESY3zs6fymW8piKCC1Jh3t+gUyuBcnvRfZYOlW/KPePbqQPd4oFLESS1dpfsY9nU12a32IT+PfzU+xjjtYd9BmCJFT04Y0p9sxDA1d6o/tJyAgVIvZc7w6v/x8caLohJkTWBM=
Received: from PH7PR17CA0051.namprd17.prod.outlook.com (2603:10b6:510:325::14)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 08:32:09 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::7) by PH7PR17CA0051.outlook.office365.com
 (2603:10b6:510:325::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 08:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 08:32:08 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:32:05 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 3/5] KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
Date: Thu, 9 Jul 2026 08:29:51 +0000
Message-ID: <20260709082953.69434-4-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709082953.69434-1-shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 011c749b-eb4d-4f31-8857-08dedd9490ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3UgYU3TOSSTTqFVM5o1ZeYv2B+WuyCM+sgNBztBw9VtqhF7pkWDwlkvjsJzu3rb/y4JmAcmAGOKHYiqsJQVjT1XPCRVt3RxUNAYrCfr1EbQ6l2OKRVvG2Ym9Kb1TKbMjRpSy4cPgmLtPmUSlR478GsqqqiKcL9cOyWPQRPiIn7lNE/GaL11AESaYpr34D6tc3a2Fl3w5b6QqLcEuHd35JVAMu8qh0/lUDgVniXlb0pNLA7kkmPirEDaAfhzBPa6+UPz01ChP8TJymQ86up5mFC+msHsNL3mF16kh9GVZsHz+bR5vGsaFDkROkXO4uzMU8TKhraqLknbDjqdKv6C9nrZNDfvC/zDN4JdaH4Sq/eWA0y6XM5eWRG5hdNjgo2300gLPCTu7oaQ+5f2oU/OyKuObpSOul80hS8rfrMxPtqGCaoIvI4Ed64Pc/SG6QDJdL54plkafeI66rmVPDRJIGC7nBqoA2gOrTzF4Gbi4xl52EzEiHRTD3cB8JnAexn1tlLys0bgT/O/cL7Su+0eo74uNPeX8yHhonw/rwTnSg8MhhleblszvAu28zWGLawxmOui0I1MranzARbvyiOiZt2zhMTviChOY77bfpi+tc5JSvif1spEbW+OlN0n6LWIdp1vsvAQ1+DClevkctnIIxpmw3NhMeonTG0ra0mh/ggTcx3Adh3aKBYnCk/iKw9BsN6zCpfg3FbW14SlTl0ifGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YqR95m7iW2GSHP9vgNS3Jyx0uvkPn6pX8tnKwskTcoOD7S9+GCNMmPLGgtd/q2VPpR4pSK2aeTjTfi+DiRngg4ApSYLojpUyrgUoxJTn9ZAtCn1dnqxy7qhrM00nXVtyfE9fDsTKenjh0/f6/ibmi28ydT3zquPnCEzZH4NjtWw2SrEFhZKWCdUhA4yacucM52majQ1iuTgIJ4y2PZRnIgDnkzcUoGQ8z6I+TQeIx663TxGmzXRi2+Ivsq31+xAeaFiJ2kL4zBn3MU+kqL/+nPIYKSDAJBCGFKOGtvTVWU2Uqbf39G/10h8Ox5Vk8OoKNHlRPCX5kMcYu387DtzSWde5z3LmKJOIVZ5uUdkf4jXknAvqJaGNDtJJTZyYEYcSFH5w8GdTiiQgj+NcP1hPCXqbecRLLbI4DqHojrY2+QOZGTWRCsPaovEoUJJLmEkM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:32:08.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011c749b-eb4d-4f31-8857-08dedd9490ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053

When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
(DR6_BUS_LOCK) to 1 unconditionally.

Use kvm_dr6_fixed() instead, which forces DR6_RTM and DR6_BUS_LOCK based on
the guest's CPUID. DR6_RTM is a reserved bit on AMD and is thus always set
to 1. DR6_BUS_LOCK is left writable once the guest supports Bus Lock
Detect.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v3:
 * New patch.
 * Use kvm_dr6_fixed() instead of open-coding DR6_FIXED_1 | DR6_RTM.

---
 arch/x86/kvm/regs.c       | 3 ++-
 arch/x86/kvm/regs.h       | 1 +
 arch/x86/kvm/svm/nested.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index d2caf5a67dba..1b5dfa765140 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -764,7 +764,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
+u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
 {
 	u64 fixed = DR6_FIXED_1;
 
@@ -775,6 +775,7 @@ static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
 		fixed |= DR6_BUS_LOCK;
 	return fixed;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_dr6_fixed);
 
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 {
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 94fd86728fed..e85c3ff3e120 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -23,6 +23,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
 int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
+u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu);
 unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 84248e6665cf..0a9e28a02692 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -811,7 +811,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
 		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
-		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
+		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | kvm_dr6_fixed(vcpu);
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-- 
2.43.0

