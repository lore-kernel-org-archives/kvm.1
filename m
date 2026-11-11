Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399724;
	b=v0YMNquW522PzHbMyo5PNCSCzJroJtoE0nkcX6JlpxaDUawaoaqL8n8U1xfzCMoDZB9t
	 R6Nn0SZ8phFdL6nDGTBvstGRnqSoyqhNzk4MtWUnIkkyRzmDwdGCopslEPOdWOrwM62YU
	 meyvjFGHP1zrdeGGuwtr2p42TZHdCy3TpBOjoFSBThGoG97CZukU1McLtckFozo7WclCB
	 ZUd1SGHL04yop56Vft4CaLpTBTkX4iYxHUIpo5oWKtTt5b7UNzW1PLoTsOLFPMReZVWhL
	 QugVvfTK+1HHEP4Pnn4E90p/sgR5dwc5J28f3/QWlpoHakwtJKmtD2nJ04LPPkFlTkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399724;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=8JPdXsScKDRO4V6wmZimadVOBHWu+41bQlh9Iz1/n3w=;
	b=wk9z7tracpwldRlwd22o+bV8q0N2rsvREz0pc0V3f8Qne4kbkdlCVW07gebtC09dwg2d
	 18PFS+QQegiPHGOFIY6yioXLppiBK7yC5Aj0fi68ZyWWVsV/+08V/XPNXP1aA/YK+LSHK
	 zBh8hGYNPzxIZWjpUncSGHBHcC4ZJMGsxtf92HPrgeipHtWA/zqGfRMAX2vJrWyCVojgJ
	 ObbND/MNpmdZWZS8CljE3N2filo9Hv1YwqW/xx3KzSZvEJyQ0TOiYJu4cpXrnms9nkzms
	 LHfYHz14FeOHU0Dc7DjjuHIa/7lNfl/iw8O71JA3GbMuTfdUhjhVrPtlV/Ucftn9zlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qWv5OuFS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.3
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03E606A332;
	Wed, 11 Nov 2026 12:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B03E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qWv5OuFS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/u+IkbTp25m6b9cAyEPLGFmVJKp4Gi35L8QrcjFcsN2GIHN1dSaxY+0y9fn/K4q1SRKBo4M4eD6p3W1zgRVATjwXWCgE4haJznjGvEOl7mRH3oCw3mEuBnW3wM+qGzYAEivXnICrIRATft91FrgoySBiGkkT7mUpPgO6de5QhjwDvCmE4CeeDv6SnkjwN1w9arnboirhxhHUX0khydQyXulp7abziA/Pq8As3+OJljWZH61PtzpSK7061hdZgZWfMNneHXWuhiR9KgsDCII9v1GQsJtciwjurbnZJvRDrffoMnR68gJsRkj8fPPZknJ9ShYYSIiAVXii8SjDW+YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JPdXsScKDRO4V6wmZimadVOBHWu+41bQlh9Iz1/n3w=;
 b=wghIj4Pk3VRIHSk6ytOungbnM1o5WTYG1Rb7vPnJpzts2MXya0UMphMcVBblhszjm9/q1DL7fjX9cqeTvtmgGCtfZC/Z3pWmVxd+rAS/rt534KwRpVSTMeOLiHLdTvpgtdtzExoHqd9ImUNt+Bs86w96CCjnYmAqMe+9cD1PGEEo2En8TVqghXacrgr0qw+xoBYmQvykAavYFoA1gycXTdFPRdNvU4wuHuGqZSC1VIIRryv9T2rWvaxihH4Oe3ExO9yyBa6LYTZ4TX9fp8z3Fq8YS0AyisfgVrPMevtQWUhod8wmuq2anH/h0dCoZcyVxXhOEC6UB/nPHBFS5ZqC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JPdXsScKDRO4V6wmZimadVOBHWu+41bQlh9Iz1/n3w=;
 b=qWv5OuFSJleD/3Ymv/pNLaiG3qeDurUGc5n6RuwlSEH102uEwnPmeGMWYrWrM0QGaWH181zYzaPOo1ihhxeSi6oCguFhgAQM+UKRPETrCrNFaEidHDeSbbrbT0W7E+uA179sr95TqIueqzg+4yylrt8HrTQw/et4qCaCgRLKuzQ=
Received: from CH0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:610:b2::33)
 by PH6PR12MB338919.namprd12.prod.outlook.com (2603:10b6:510:3dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:21:59 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::51) by CH0PR13CA0058.outlook.office365.com
 (2603:10b6:610:b2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Wed, 11
 Nov 2026 12:21:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 12:21:59 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:21:54 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>, Sairaj Kodilkar
	<sarunkod@amd.com>
Subject: [PATCH v2] x86/kvm: Use RCU for svm_vm_data_hash
Date: Wed, 11 Nov 2026 17:51:28 +0530
Message-ID: <20261111122128.12998-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|PH6PR12MB338919:EE_
X-MS-Office365-Filtering-Correlation-Id: c7527deb-48b4-4741-a13f-08df3fee6268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|18002099003|10067099003|921020|11063799006|261028144727099003|261102123227099003|261009223027099003|261021121427099003|56012099006|261021123027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	iFk1wMs0xWWd1QiBQ/Y8oafLvvgkKit9lP5F7Oa7WiSVgbTPZNGnECPggckNjqsII4wFf/nTCqXLK8m5CwVoFkiKGpnZiz0q9jNOY9RdpbI3OaZuMDoDEe43sZllXmJXS6NTFs8E96Ajp9I9GyiXOfPFVg+1ZZqZCZXY7hCe9jwL85hj6a0tun3JW4YJKIMty7HMnHiGKsN1ryowamibFZj8ub3w6wiwUwmeTOCz5xpgYr08DGkkcPvtBn0Pnk1Fxxco/eDc//Maqq1JH79atR3EEwCvG0iP3sbgFl/cKfmfSAy10ca2bYYLGf6yQFZiOHYUsDDNKhaA2bZFFijV3J02sCf/NOPVj8P7EOipcwncFgnwldW1CahHFmas0wzEXUCbRFwCkoKqzJtksookPr8GKS+x37vxcAXSPVqPFp0fJcXmgERJleGIApmoDEXlq2iRKOPsZKAe5aR9IPXaUjMu2WlhYok47l4nhZRU5LmjvS1mzlaFQXstUCOXifDGfntZ5YNEIjVfYdapbqEnMwGajqT5QRB6P3mvEnguV6dovzr3C75sxe3RlcdIvNfXXvE1LfcAMnxqrEGwEFGCLS5+WWhxWufGo2+2PHS2JUaGgmU33MS5L1YbR/Vbu8o324ifEkkhbFvQr6+kb+eBc2J92sFv9EysbvUJr5h1i6oexqF/g0NhRAeU/sephDWj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(921020)(11063799006)(261028144727099003)(261102123227099003)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BDuY2oiykiaOSDoVtpQ7YepKy/jFqUstGD7BwpCLi6LYiSTtp+mq1ZPMzhpQKxRxEG8cDZQDZDOktCXSf9CbXSQnJI65LrxmNS9jPvCryliC0LGR911aCLe9Z3Hz/7pPTPTE5vDXd+sauwZW4CD8WbhyfKQH9fw6M7p+Pz5NNGiLx2/Ld0fjnie2fuPssAMH1Bfd3eSa4d9hoy0s/YUe2vD5kquZektmtQIX6B7UHmTZbcBgI7HFsY/ZR7bwdpCEgvunGTCouKb2h/ehfNF6H99Zk2VVpsn4DSzzz9S/cZeHY9CBxIYEvKKrsdaYQ3p38Sa51g/dU8BLKc9s/c/gTbcB3+EWTFhd1Gh4wWfCCGX1EVTknFCiTlfvWafQAmKiHiRyU6P+acLjpoxBhC6KPj53sqdXjOwCR8b+UaaL15HU4n9KFAtycF1ZXRgFv/hN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:21:59.5127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7527deb-48b4-4741-a13f-08df3fee6268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB338919

GALOG notifier iterates svm_vm_data_hash to find the `struct kvm_vcpu`
for the given vm id and vcpu id. Holding spinlock is not ideal here since
it allows only a single reader to iterate over the hash. This degrades
performance when interrupt rate is high and large number of readers are
waiting for the spinlock. Hence replace spinlock with the RCU.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---

Tested on a 2-socket AMD EPYC 9965 host against the same kernel without
this change:

  - 12 VMs, each with 32 vCPUs and one passed-through NVMe device
  - vCPUs pinned NUMA-local, at 1:1, 1:2, 1:3 and 1:4 pCPU:vCPU
  - fio in each guest: randread, bs=4k, iodepth=32, numjobs=32,
    ioengine=libaio, direct=1, 60s

Time spent in the hash lookup in avic_ga_log_notifier(), measured with
a temporary tracepoint around the lookup, averaged over 12 VMs and
3 runs:

             |         mean           |          p99         |
             |------------------------|----------------------|
  pCPU:vCPU  | spinlock  |     RCU    | spinlock  |     RCU  |
-------------|-----------|------------|-----------|----------|
  1:1        | 409.8 ns  |  132.6 ns  |   960 ns  |  750 ns  |
  1:2        | 977.3 ns  |   21.9 ns  |  3530 ns  |   30 ns  |
  1:3        | 747.5 ns  |   23.7 ns  |  2150 ns  |   40 ns  |
  1:4        | 614.8 ns  |   23.5 ns  |  1610 ns  |   40 ns  |

Total IOPS was unchanged at every ratio.

Changes since v1:
================
https://lore.kernel.org/all/a2a4c5e6-8264-47e1-80de-375dc2eac048@amd.com/
- Restore spinlock guards.
- Use synchronize_rcu() in destruction path.

---
 arch/x86/kvm/svm/avic.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 96ca39c0045f..84a0e8d406e4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -250,7 +250,6 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
  */
 static int avic_ga_log_notifier(u32 ga_tag)
 {
-	unsigned long flags;
 	struct kvm_svm *kvm_svm;
 	struct kvm_vcpu *vcpu = NULL;
 	u32 vm_id = AVIC_GATAG_TO_VMID(ga_tag);
@@ -259,14 +258,13 @@ static int avic_ga_log_notifier(u32 ga_tag)
 	pr_debug("SVM: %s: vm_id=%#x, vcpu_idx=%#x\n", __func__, vm_id, vcpu_idx);
 	trace_kvm_avic_ga_log(vm_id, vcpu_idx);
 
-	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
-	hash_for_each_possible(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
+	rcu_read_lock();
+	hash_for_each_possible_rcu(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
 		if (kvm_svm->avic_vm_id != vm_id)
 			continue;
 		vcpu = kvm_get_vcpu(&kvm_svm->kvm, vcpu_idx);
 		break;
 	}
-	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 
 	/* Note:
 	 * At this point, the IOMMU should have already set the pending
@@ -276,6 +274,8 @@ static int avic_ga_log_notifier(u32 ga_tag)
 	if (vcpu)
 		kvm_vcpu_wake_up(vcpu);
 
+	rcu_read_unlock();
+
 	return 0;
 }
 
@@ -340,7 +340,7 @@ static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
 		}
 	}
 	kvm_svm->avic_vm_id = vm_id;
-	hash_add(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
+	hash_add_rcu(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
 }
 
 int avic_vcpu_precreate(struct kvm *kvm)
@@ -373,9 +373,12 @@ void avic_vm_pre_destroy(struct kvm *kvm)
 	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
 		return;
 
-	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
+	{
+		guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
+		hash_del_rcu(&kvm_svm->hnode);
+	}
 
-	hash_del(&kvm_svm->hnode);
+	synchronize_rcu();
 }
 
 void avic_vm_destroy(struct kvm *kvm)
-- 
2.34.1

