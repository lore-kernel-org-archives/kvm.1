Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391400;
	b=lzw+lcWPmkrVmYRVwzsVJcJmY+UCUbiGu0gyFCPKUWbCKh+EsjY9wRSBQ0Id4WFF6zQI
	 b5brjG8UJx3fGo2v4WZDtzJXNKRbXntkYxJJu2dsEHcacv1T+YZVb97XffoL22MJWLp3c
	 8E7DdpFLb6TzRl+1N/of9xtBX+6cmIpZBfPcGyNEYscYZF7bCOheEQdPH6rvhj4Mc7nV/
	 6vFg/JIdLLOl6BbfvkWXCRAiZjr0CYGckISHseHPT5wiP0/oF8qXs7fzDc8cfQPC+syTI
	 ItDirKS3jwIFORCQHh42E8E1CK9aLhpjzgMal+58OGPLQlewo/hAhOpOWBOA8uPeHFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391400;
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
	bh=/+NX2yKuQDALUUU1wyPskGBzHnH8uRRukydv+keUaZA=;
	b=kRQe6t+UfMVk1ZU1q9kcBLUMikfV7m8A49FyzBNxGrRmbcCf+1AxQ9Ni/qmtx6qh1lSl
	 t537AI5BDbPxeHoS2WfqbYFftZ0KOnpbkIqmHMs/byvyS3FcSLaUYQAxavZ7tL0ALQnOd
	 e6ITzb+pFYR4/+URArkggg6pEKAl/WYeB59iqydZVHl/GXmNLzgxOQqnXJ6Xx53f3plL6
	 +jMjH7drvbgPU6CVzRZpqae5bcY7Wg7EERWAK1jU5StP6PgjE9QW9fG6eHVvjUO3hASJj
	 NGE2aOEjvy3q89Fv1hhP1T2r22sbtTYQ/+wUtQoayEH3uxb0EOdW5hD1EGHRoMX8pwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CdrmedQS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.24
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9D606A321;
	Wed, 11 Nov 2026 10:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB9D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CdrmedQS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQerkBRB9rE9B+Ws/GOVCZSCY+tF7DX0wzorZZ5HJCFIkNK74TSaIrRvvQq9PQXKFwkd4AAO3CvgW2IpP7gAm7cQYY6vhLXc8X89kTjLWSOzgOytsO0jRC2mDJM0iLOORuxSxroy1UhUPPjCHKBMVgFYv5pnLh0BVUf5IlMihk8bfLquyimhzeftDqMLSopUY1TBYkSlgjVj+J7ZTFmOrnVis0HZBx9fC5YEsFxuBxrFGtBgm5gYnUvXC0gbz0be4+bRxea/Q8gYBf1DAtlIjAJ59A8J2c5VHgp9QG2KdXWImqpBZMlrLh+d2VJW7d82+1T4iRz4jrAf2ARYTog1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+NX2yKuQDALUUU1wyPskGBzHnH8uRRukydv+keUaZA=;
 b=AarlkDYkdI4ixdS6ceYWwuBPsOCXhjmonWJyFiBGFHwV0uCEJve1maBnyxvoYjF899umbk6jBS5U65H8nMcPnEq7MD8haeroYne3vpexAkkpYbco3hxtqZxtg2ns/q5/NwtFLHUc8EDGHpHK1h9oA7N1V0NfnlRHt7kAT8ePzr29MGbLTbmbEE1+lkB5wg6svW4HiXRkRUVbNhwOhO6cc7JdI/mmxd7q2wlZkyiL9UTXdRFpB7dL+QiDgVcVmvRKM4WCiJSq1km6ae3yIpmrHxScuHUGHdQmeTStHJCPL3EvnHlheVTLIQ96rzdhSCMnCV6961mnguXtGnP5DXN27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+NX2yKuQDALUUU1wyPskGBzHnH8uRRukydv+keUaZA=;
 b=CdrmedQSclV2+T41gFK6YbY3gXUIrZCPrLdPIe3zGN6/b3lgU7QRVH9PpF1PCIanEblPvt83OvZvAjt2ffw/o7EINb3R2u2uo4lUds4e69kBqKcNLHWhD8dN2x2pOnSz3LjvAWl168DWUyIOT4hQblsXzZdJFsyy76cDkS27BEw=
Received: from CY5P221CA0134.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::20)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 10:03:15 +0000
Received: from PH2PEPF00048918.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::40) by CY5P221CA0134.outlook.office365.com
 (2603:10b6:930:1f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 10:03:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048918.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 10:03:14 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 04:03:10 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>, Sairaj Kodilkar
	<sarunkod@amd.com>
Subject: [PATCH]  x86/kvm: Use RCU for svm_vm_data_hash
Date: Wed, 11 Nov 2026 15:32:46 +0530
Message-ID: <20261111100246.4425-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH2PEPF00048918:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: f66e87df-71ea-4288-a505-08df3fdb0083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|921020|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261022105027099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mE2VXXkizKs4AqIuR7UUlGCIHgo/l3YNAx1XeZQO2BTC4I1DD1zaG81zAXwdGzICKosokQvv8Q5NBNl50c7HckhvUwEsmK1vobNUz85ot6iI1ETtLM3w25sIpMhlKaP3FZ7c4ori6S9DNOoOh3Mo3Ybd5Gd3iwIGRgV+VQlSf+SHyhDz6YsfZ7xoblbZbMLSqCuD6pcXG3cZ35nWnvrGbEJZ+MsWwI2FKB23jcli1LbQBVIp584oiFtPWuZip1H+Sn7oHwDtcA4mQ+klmbrmT3PkBdL9XHj5pBa99jx1qzW4xSWDy4I20GxWJMxHQ+c+Su/wJDzwszn86oKNVHCvLPpqT8lS/oPEwWv5wOY3zVkeIbdHUxoOeCJ6RgTXlqGqNlbSlAkFpRrJO4wDmWpBqK9FaJeLtT7gBwY+bYn/JCqTtP8VL2/6Ti8sX3J0DSnrlLdDu0zPT8pGwTinZmCFRNx+Xyavz4fpLGItzbjQT/7NbNa8OcBX71speP4I866cP+UDkPaf0kXEu/m2pIWQH4+QkVMFlTS5gYqbWWx5wcgCMtYCcfqPvP4aWuJD4DBF15fpueGRIVCoFMdXkSERrX+IgZFrbDHjJUsdAnIf+3z17SEizk0Ow2XNZanprBiBXvFZYLg9ggsLBApidI7eayU5wkT2ott44L1BkPxQSeJDo8EGmmpr6hXgSW042H06B1pNFwyBoPCdJC0eWpTJbmzaHePsix9F1ZZA1wzIkTj/sHvGg87Fph+H2tIko4j2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022105027099003)(261028144727099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7GG/cNssCIoQoWichmp9G8A9YHsCiCHzFxjpt3qjZAksCdNzNuX5xHjt5h/GvDFtPX3ZiDvo5Vof472SD9pKITySG/xM2vHONtoRjtijye6MuppYdzhuqi8+l3q7qmst6DiPk5Nbm6dRIQI6TNU2wdWsKag5osX0C9sehXZYhzkYNX7PWP9pUfdYxlR5cDwS3dh/k7ddBeu1ghQJ9le0e30dfpxEHjyC0ynLN755ZWvgnPI7g4d3qJlQlEQonCpX/HLOjwKkJN8sfGxQ4Fs20mwJdeSH5SO3ZnCQZNK7qRzZxumszB5DJSrEwo76EKJ41Wz37Ff1z4xCp25R/mH3F+TplfZ/9S8guFvnlKJTXUgMIULTPF35fJSTQKH4CeCyHEIAdFwO9fBKfMH8Dpka5ZFL6Uxs5oG91HVGXUulV6ejHUOuWrLdstsFTuNczwYq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:03:14.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66e87df-71ea-4288-a505-08df3fdb0083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH2PEPF00048918.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77

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

---
 arch/x86/kvm/svm/avic.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 96ca39c0045f..9e2c11d60798 100644
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
@@ -259,14 +258,14 @@ static int avic_ga_log_notifier(u32 ga_tag)
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
+	rcu_read_unlock();
 
 	/* Note:
 	 * At this point, the IOMMU should have already set the pending
@@ -319,13 +318,14 @@ static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 	struct kvm_svm *k2;
 	u32 vm_id;
+	unsigned long flags;
 
 	lockdep_assert_held(&kvm->lock);
 
 	if (kvm_svm->avic_vm_id)
 		return;
 
-	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
+	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
  again:
 	vm_id = next_vm_id = (next_vm_id + 1) & AVIC_VM_ID_MASK;
 	if (vm_id == 0) { /* id is 1-based, zero is not okay */
@@ -340,7 +340,8 @@ static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
 		}
 	}
 	kvm_svm->avic_vm_id = vm_id;
-	hash_add(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
+	hash_add_rcu(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
+	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 }
 
 int avic_vcpu_precreate(struct kvm *kvm)
@@ -369,13 +370,14 @@ int avic_vcpu_precreate(struct kvm *kvm)
 void avic_vm_pre_destroy(struct kvm *kvm)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
+	unsigned long flags;
 
 	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
 		return;
 
-	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
-
-	hash_del(&kvm_svm->hnode);
+	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
+	hash_del_rcu(&kvm_svm->hnode);
+	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 }
 
 void avic_vm_destroy(struct kvm *kvm)
-- 
2.34.1

