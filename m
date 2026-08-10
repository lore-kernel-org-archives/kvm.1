Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821F3B5311
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357086; cv=fail; b=r13IANXLEA36X9x7BGIQ+zjX9sCAPaJR8UhZ3CVW1+hGA6E7aXIQu5J1UXvD2IeZQANzOp4qqCePkOAEM0FbzbKVjbvU5uOoxoFzhQhLegU77sG+SVCZh7m5gz2IpgGhssrKb3l1w4pw/E7dTEJkmRdb+Ub9oBAmxsv+6Jv5Xqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357086; c=relaxed/simple;
	bh=a9Y/LjJUspftz40QrN7biDagHlNNiu9RMyC09VgUfWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiggJTw8vDI+MToTnv9IjwYdaY82sJYsfhe7EkTloaPOmR1Lay3V0XVNf5UIEQ3RB0fRCmcpw3yfCEIZ7XUi8sDN1HrmIYfPzYalKdS/iCNrSqkxy/tExNGkuC3EJs6oyW3bzFHJLhfLcFW8wCO/hEvbXLwwjc9g62ELEabLA8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zfi4nk7v; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zfi4nk7v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQPxcEZ5r2gQoCzLtgjq9Z6f8PVqXgtlVcvNz0e7Z4JoLiByO+vDHDdvHLjMhqSGk8ZKpN/DjxgKvcGlWmjKUhR9/Hm1mP3+T8mLk5Mq/pyDrdwdpvRU9VgSe9D4cTiAbX3uqIeFGufR4p9xpaol99X9zYU6Jna3/6y0fWvz7Njn10/q1TTK4X7MPonnDIV0fYfnsYgVm1berk7PwkWpu7HZjryZkQVbWaKWLIhc2ZoWpTHQGxo8aWD7kdKdDqFgRSPIDBMPeLW/03TiJvT4Ctlb2DlRMDwp+p7DKkKgpfLAaYODrsgZjJ2Qvd0rALO7Pj7JCDL57/FkCg5rUzsJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMfBCZvO1wjfHH1Cw76AtPAM+49TVwMLkHx9s77SfOQ=;
 b=E9ZXLuHZ8SGj12fLteBRiIB0G/dRBHaV9cQyHrj2Eb/sI9rtWkvDF1NVf58sLn4z17R2VzPt6jyD+KzPH8HNFRN70cq8ywVxZVTonaurohobaVWc7moXYWjPciMVXpBd77DrS400h2MyqDM/ShR+QN3VT+fFEP8TrcnbzCTX74w1pn5noGaClrbTHMIQCzgPEf4/KRz8TLLzl4anXRgxyUB2Q+pMet5UL1XT6ISSPeJdwOpW8vbaYGmij1aoVEeEURUibB3pD4rc6f5yLBSLuVIaWl1qmvonPfFjtJ8Wqd/RlK4eRs396eVHOg4ncG1z7m3WsjrXAwAgY1CD+q5OJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMfBCZvO1wjfHH1Cw76AtPAM+49TVwMLkHx9s77SfOQ=;
 b=Zfi4nk7vuiacKTCY/SywaXGxoFN8ncRPDhTzkUD2vTKWdHn3FsuGTfqZ/DHyCILPf/wqxc5eQXXXsmVjdTesVWuMonzNuBmn8F3XhHNl/9t1QhsgxG5irPX5NlLxa9OJ5MzkelbHTMEL0/KaDhTCzI1rbq4cAKh3rm0BbwpUw4o=
Received: from PH8P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::25)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 10:17:57 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::80) by PH8P221CA0007.outlook.office365.com
 (2603:10b6:510:2d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:17:56 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:17:52 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 8/8] KVM: SEV: Disallow the use of hardware-switched PMU
Date: Mon, 10 Aug 2026 15:44:56 +0530
Message-ID: <c88cd7d448c7ff998efae53979624b5b08a045c1.1786345201.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: f77fd26e-eefb-4bce-8dbf-08def6c8a5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Za4mOsy77OPfXDi9mj+he/WFAkq4ohbQkZ74fZSsGYcbXBZBBqUpmhGPUv4kXHZdE0pfgSEjH/pOfPWXrJZFJewRU8l8J7tHnXOvFot7cKAVCjAXBY6y1iZJYRHwAFo1V7yMvPZrGUzsjxaxXw7wkQ7KQUaAJ3K3waZOhspKXho6eStOp8IoK7OtE2l7WHeZ3/Ef1UnqJ/KdppKXqiLFM904vqJkgWXiavFIX+9J+lgmvxgjMcwnPWajXu3Z0iIy5sr56OwtGwkie+4uT1Cqa29oyoHSGvniQ392jsvFXUZ4v4uwtn5XTeRAwrUz840VPUjGkHZg5PIoNRkSId2fRr5KpwVema7AwciPRlRNiLLRiAQMj0hzBEp/oBETwTMiRuXf+HqCXYW1JPx72kI5U7rmcry1rL3N0tlgABql+FNyJVi+Qge/7hxaONrsGsfaffr6kFsgEKyAcdMZmN3LLL/V8a/eCdVxUKq7ryN+lM1erxAFBiYUSvR6f0b5tBxg4biGvF5jFbG2Z/aFYA0Z56bbvHZ5frExFPXsu+wxiwMiCZScQ6Z6gcR74yVfPXjbFTzWzVBOCUMkNRgr13Hn3inhX6VopOXvyk7FTtzZQ9tATzTpo41sQShIY1uIrV5TaCoUI+fuyXfvA9Zs4T2C5wret2y7wI8Jb7BRhU97pLfjxJzgOyz2pAJmohL8ROZMoq0CKbRkat6FgmYWLfIXHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fDNBreY9GE4yHw3c5UHAEJi0GJmVoWXHEkVrO6FursPB2lWVzn+Q8jVnBqHRsP4bGoUV6jFOl0++AA1FQuK1BZAgJPRm43vosOSD46bmgaVpTDRSBDJbnTYxAnTTz2QNDG8bE1+v9uJcOBBNZpEy/dAymrdEx8vRI5kgjCq4WgJ281QvFgbLnpkwHPFjEHrYqixlDE+8vZw2MP/CQFZMiOG7dtjddUYkMcq5OtRM3MkuTYxkGSquuIbY45eUhaViCzHxWYK0zkQb/kuKh9cvZ1L4t0dD1fRdT8Ouqu93TNX55V/BUkX33UE5PwcjBEyOM9EwdrNlvEMDMyHg7fdnqjgAuWi0b9bdsuC9UH0MvFo2DaJtrTahwiu0qfONXPHzZYAJvU1zdlPWxri2XsaRx9amw+AAFUfrn0kQ+osWfjAxfY9i1MARnqpNdgiKwmY6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:17:56.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77fd26e-eefb-4bce-8dbf-08def6c8a5e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

For hardware-switched mediated PMU, the guest PMU state resides in the
VMCB save area instead of struct kvm_pmu. To inspect or modify that
state in software, KVM uses the vendor state sync PMU ops.

When SEV-ES or SEV-SNP is used, these ops cannot work as the guest PMU
state resides in an encrypted VMSA that KVM can neither read nor write.
Clear KVM_MEDIATED_PMU_CAP_HW_SWITCHED for such guests so that they
fall back to the software-switched mode.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/svm/sev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fcb41dfde4c0..8e8cd4feb16a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -534,6 +534,9 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	if (snp_active)
 		sev->vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
 
+	if (es_active)
+		kvm_clr_mediated_pmu_caps(kvm, KVM_MEDIATED_PMU_CAP_HW_SWITCHED);
+
 	ret = sev_asid_new(sev, vm_type);
 	if (ret)
 		goto e_no_asid;
-- 
2.53.0

