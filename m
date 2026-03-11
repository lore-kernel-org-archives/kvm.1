Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29525CC79;
	Wed, 11 Mar 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234426; cv=fail; b=pCfKA0FWcvy0Jn2x+DHn2Cp7YSWmrLOlVPEW88yUZ5Lf80LNF6HG3INYaO31hbhU7tNA50k8dGoZaWAmHd+RskL5pDnoDrpQXZr0kWR1pOCjxUZ1+StY/oO+uCWWORVIatT2Z1VrBxDpxTPjnx3NWpMIoaGvtwW/bHWNs0Wa87A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234426; c=relaxed/simple;
	bh=0Qm9+mIQoyQAHckK+dUAEdUFkLeZgUy9oE5Z6GHtJ14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkMI1W2UtvpVCyCa2+LvU/zm9f21ZvTsL582T7UhHO1lmuZSocz0yqOdBkbXhPEgp40u7ZDEo3GaeBgyGG/UHvx54NcYl3MMU77N0yrH07+e+tDPGF13rzJhQGqVc8TTSNm5Kzb5WzRoe3Sb2JJpfTOVwwADrPo1KRk45x2PqEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3+PLT+h; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3+PLT+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/QSwOnrDb72f05RAdh4Q1olWhM8v5NZQsYjR19FbliPvJPTj5D8fL7ITeBEv1/J1Begz7wA5jy3ifvTxFNxAPI/6VM7xgTWVcMhGVki/Ip6gNV6lzW9w3MGHGMAtqwErJFEEj+xRaNQ9hTOwoiekhnKGKNih8DW8CKw5OfEwoS1p4oOTp71brCZODe7zWl2SMf7zQjdG/7QAUbW9A1P9IJLsj1bGgcYCNsdQJDdD6mME+WNGMr/2AIb7UhMu/XDE+t7cwMJCHb6+lHJxZDcLuvIJcp0Ktb6hYTn6o2WX5Is+FIha0EGy++QbWC15dzzyjOCwT5cluHY5RuMbNpr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNtHA3j09gnR9g+GqDMWKRTgLYr5+iztJI3r49XE4EM=;
 b=Lje3fsaML5wNZQUu4jdyZ8jLZtHGpXCPTvBthoXMZxcyW54gJHuG13x/TBKrnj7PfleDMtoj4s38e97s/VxX1MmKlvKHzR/73iKttHbFDj9IoFkrIsZ7IqU9PnmY8YBCrpiq9XooL3xq8zOfzLm5GloFrM6lV5IylH8fHyj6dRuazOiX38F8fGaOGMnuO9/KWIswSHzRv8igdAywY9QuSR1qL837lPktdBoV8xcR64no60T8db1OK50iUHqcgh+gAkcEqvQj8BpFq3hd0YxrcHZlPgDxmP6b31JP+xpygH+w9go4qSY9TYDao0qZM7M3UK1Furjs7lsnevwpHUtAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNtHA3j09gnR9g+GqDMWKRTgLYr5+iztJI3r49XE4EM=;
 b=d3+PLT+h3aSUiect0lhPs23S1MSeDcHE+JveSAuoDN2eFw2fr0pk+q+zyRtL93mf8l3SL1zGl0e+2Le+16Q75ZfQ7N9yOQC14HG3np3pI6Ny7+PkQwvdyuHlC/eDhVg9rUO74vVknyysJ7zfYBgP6RpGtlZHYadFwF2DSNwZAWY=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 13:07:01 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::c9) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 13:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 13:07:00 +0000
Received: from gaul.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 08:06:59 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>
Subject: [PATCH v2 3/3] KVM: SEV: Add support for SNP BTB Isolation
Date: Wed, 11 Mar 2026 08:06:11 -0500
Message-ID: <20260311130611.2201214-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311130611.2201214-1-kim.phillips@amd.com>
References: <20260311130611.2201214-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: f60cb558-4284-4b53-bc02-08de7f6f153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7p65Q3/HI1+X8FKpWz95a2qCegTKEWiLkl8v0D1YivtHBEJM+RThEg9DxiBZLz69bU8J0RbGPKdoTWg6l2bPW3r6Fs6Qp8jTpdJPeRfmuaZLCn3jK+8ZIIO+0XDJA3LtDlLPCg7vbcW6zf9AI7/ASoQEESPcXLWKguoqSzaQYRnOp73G9YbsYb4m0tqD6B5sRWqmsRpLBz6ruY1W2aFd2yQwOOcXTLUkbD0rTPkBYwGByQCwOZWmIbEs/Gr1NUHVrdLEiA54GKeHaDsGUZPyf/KxsE6jE/1ozZKgmCaCUne9gd7977GJAsQJkleI9U6K7JJLtfGobGW1ocZyTNYFHHpdaNaSc6719RGd7expCON3M8qYufs8SYyTLKdQkQJDgTFH5br+jJJsdxtueUUJO3E9QhCS/YiPwiH0oyttl84z8+wJguzt0pcXr0mgzuS+lxX6py7PL4AeB13Ks2aoWvstExG2JMGNzdFgzZdjiDLzaA0i3nfl18RpvTlBIjxpizw48kfuj58yTgTmJVqLeh2VM3nObFRDxhThI3+6biOIea3vhGtnCA3xcStZpd1fqb4RmKxAPkP+ir5fTS60bSmc/kcJDNbTXDcPB8SXhw7XFv9BqmD3nqgpDJbfYL56YvOmixBMrAMS3C35EelhIWPa5hZkL1lKQkzENGHxpXpkz6zGiv1G9YPiHJpfmZP+G8q5/oi+SC8VciKXeTFeQC2D+BK9H506RSjXaMEVpTg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LqvMq4CPmRmIcwdhEadY9IaHogoRc1khLK2/vxh9RYT2HcndS6Vxj7RXLqucPmADLabGAGIMVrX5915oSsn0b3hpKH9hN2t6A1JrI6sYo6bOqFLDuCUO8+NVsVQ0Bccp50IBodkrOGn3pQwURR7VShO5AdteHZX9UnwWgnFFgCqP8st+TUe4JeLeCPq7J8g7dViVwbqbxm/+XLOkAyBf83XSOg7ZSe4hcd9J+yNv8OwtdKyG5TtTZKUfizbTYDvzJ80xhb9OY+oN2pdwcSksLt2PzDsgbytYsfHz1LDsktBaJhPRj/xXQS/ZcvMEYh5reeIdFxv+bElSY2Lmu8yayQuU+lxsbmvQrVp2YX5z8Q+6bP+bkPghCez/Fk1DoKem8Yp2z0gKQFihL6LqLso5zdsx+Zz0trPMFjr1d68MgiHj4bRE4oaThfLT+icVAsjB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:07:00.7163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60cb558-4284-4b53-bc02-08de7f6f153c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412

This feature ensures SNP guest Branch Target Buffers (BTBs) are not
affected by context outside that guest.  CPU hardware tracks each
guest's BTB entries and can flush the BTB if it has been determined
to be contaminated with any prediction information originating outside
the particular guest's context.

To mitigate possible performance penalties incurred by these flushes,
it is recommended that the hypervisor run with SPEC_CTRL[IBRS] set.
Note that using Automatic IBRS is not an equivalent option here, since
it behaves differently when SEV-SNP is active.  See commit acaa4b5c4c85
("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
for more details.

Indicate support for BTB Isolation in sev_supported_vmsa_features,
bit 7.

SNP-active guests can enable (BTB) Isolation through SEV_Status
bit 9 (SNPBTBIsolation).

For more info, refer to page 615, Section 15.36.17 "Side-Channel
Protection", AMD64 Architecture Programmer's Manual Volume 2: System
Programming Part 2, Pub. 24593 Rev. 3.42 - March 2024 (see Link).

Link: https://bugzilla.kernel.org/attachment.cgi?id=306250
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v2: No changes
v1: https://lore.kernel.org/kvm/20260224180157.725159-4-kim.phillips@amd.com/

 arch/x86/include/asm/svm.h | 1 +
 arch/x86/kvm/svm/sev.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index edde36097ddc..2038461c1316 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -305,6 +305,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
+#define SVM_SEV_FEAT_BTB_ISOLATION			BIT(7)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f9c1aa39a0a..ac29cf47dd08 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3167,6 +3167,9 @@ void __init sev_hardware_setup(void)
 
 	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+	if (sev_snp_enabled)
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_BTB_ISOLATION;
 }
 
 void sev_hardware_unsetup(void)
-- 
2.43.0

