Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C031D72E
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830004; cv=fail; b=QIkKGfPeVwiw9Rr7R73BfgMa23zFAifk7KOQKW9wdUKwbdxdWCadHRR7b2R8hTbVeP+Xij8ltnNC0+E0n8AgL01HzIaTByg/neFVWQEv1cw+DKyPtje3It8uzdY1zvoo8SL12olrTCkOj0zyB/xKvBbGYKYfB31e7dIH/wdTcfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830004; c=relaxed/simple;
	bh=nRPm5mdoHbF9mnYlRS1t6EYqK93O3hRSa7TqOSuCnU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm/EmEGhgMo5IO5ulN6auc7es3PqHCgvGHhC8bAVtEJBCSLBxwigh+iId06P7fIrF1evBU63mfC1dv7kF065jHz5ZzLFI6KTRbLspcTAJKy4W0gOPrRzyQo802g3Wzc1obnHvuSjjJweBVjQup7FUOQ/1Tpu7WKichax8yrQtik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XmrCLBQf; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XmrCLBQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5USbi4ItLJJC9vBLUfl6Ylu8eNg/Gn9ibuiaDN+CA5Tr/ardx9SEQS/Jyke3K1FviDYYaCwmob7Ht0QZIZOwdFVu92utNI4GHo7Ul1lmIg8tMq6wANZTvx8j0Rv9ih+H+mvP9FsfiP4PCuAhlsOTdv3NNZ8JBI0YcoCdg0VyWfng0Gnp619H1x54Q1CzAHsjXoPbel+i2pZfmJcBIgRm3MnPsj1x8h8e25baDlruOu18SH49gkiZivApofluTpYdfWI6+o0oLTGnKy9QqRrAaut6pU5aB8TgxyqPMJ7gXgV5RwXcKzp2HJY+LmjTo2paxI0KygtB4/gjOtYLnigGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgqMIjP62eeY+qyyduFd+3GVDeI8/IDjs+dFRxz0FWI=;
 b=bj/2ga7+MQvdsi1AaWFOWOttc1J8tYvYvJwH+uWBcdQJ16N8ZrIrNtWeKjjzHMSMjevhv/YDkwJTF8b9WEhjiRLn8e2cq9dQsDVJk+9qdEoc+g9U5gyeZy0XQZvFvV7dh+a4aB67fGXhhPEUjr1Ck+ucnsaaqmcMa+QWrXGvJjtnNYakMw7B9i3bw5kdfJcfxvqU3BwoSJ9RAts6cE4stBoELnzVF4m3kYwMPhsWmPdJYUefgg0RhAIEl5l498jkbIT7bkwMoPQFF6RAeIM6AaaXCDkjcn36tmoM4H7lIw6ukFI1lYqPAC1KKvrkoqSAaDnn5j4NA5IfTP1m9bp4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgqMIjP62eeY+qyyduFd+3GVDeI8/IDjs+dFRxz0FWI=;
 b=XmrCLBQfXNc6pbW6TXHZQ0IpBGHl2WnFkVwFrMX6iH84gAO2FnS4ZfqWRAWJuErY+798XAz0ftTIJmcgwiBEWNVRn5IRfW3EC9ooGFc5CiIJrR/KkhE1wgWYCTLsQQyfyGhwylTgyS89ks/4uVumSIbpek8lCZzzm2/qjDC1YpM=
Received: from BN9PR03CA0908.namprd03.prod.outlook.com (2603:10b6:408:107::13)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:44:38 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::88) by BN9PR03CA0908.outlook.office365.com
 (2603:10b6:408:107::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 04:44:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:20 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:16 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 2/7] KVM: SVM: Add VMCB fields for hardware-assisted PMC filtering
Date: Thu, 1 Oct 2026 04:43:46 +0000
Message-ID: <20261001044351.50535-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001044351.50535-1-manali.shukla@amd.com>
References: <20261001044351.50535-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b21cd9-48f9-4f03-a810-08df1f76a851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|260925022911599003|260925021311599003|260925021911599003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e9x4Yag0HMRmPfterPbwPBHapYmY7kNGLf+AAQSHc86c58XlwT/+NB7Ml/WeW+2gPTD+fyoUbVLLE4t17Qqq2vnwwuXKfF835YC7vBHuInsXvYjcOT/RD6nrlgoN23HJKGu9PA7jTplgJEKHtFrhTRwA0LKSDmQi1sCe3sNmKi4YMiffUNXOPK9HO+8k8xl6RlcHyOd+FGIOIM28alscQKQs0881SpmGrFXKnMwXveNb4zqVEyop0vdjXtq7sPB0sohU7u/YLNfy6H6iYycVpwrzhywNC0q6i0E13T+CHZJrgBpk+3Q1H4JOPpbQBSonmrOyZ3SIs0YExtQtORNIgfsltE++iMYj3OT4UkHexYMn/kb9/SiaQ25vRKpIW4n4CcFINlTuy8MN2NMrYW1zg5vE2CPw+khBx8BejqBcO/50RZ9O/I6ePmn/6psGsjilZAGVUuPXDDR71kZHoBx9GGYTy+inSl2UnyvYylqBvNqMXBzc8FUPsjAvy3HhfUacywFEG7hQBwlM97aqzPx49/pn3LqahCZ1sjdIM9rKO4iwJNWLo1rx2ytO5wOlRsK1dBRwoKWXyElMF8OQ2qobya+jdCIRrHQqweLKdM55E152PaLWW7d32Np97Jj9GPMgZhfcgHOdVm6c9r9ammy2yT2yMaBRzjPOy4H5Wzv/fclbg8LQ2qb3CMMu6mhQ1a/QSZyseSzpP6OtZLZjhX4KYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(260925022911599003)(260925021311599003)(260925021911599003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OEcknuJ3JdTKGLtI5fq+eKmY24fwqDNkehGxMGurbit9Q3pLNM6DRxr6YzggZzuQtRQKZzSoRRJ/6fJKFAWxHV+xJKZAkzZ3aa/WMD+WVploIC1p3QE2ichlBIp/v5prlrPAi/9PzjOjy1qZ/+ZYbWQRt2725il0pMahx2HnK45TofpNAQeM/PpKPk6sFR8bO5T9ju/YwJIDZAB9GL8XEPakGvJODBWg12UTLsc6GaaB7yDiYgg8rqFo/aDR+E0jRmj+Olqsuo5JqfXahhZ81e4+mgvkO9I8NUZUr7lFm0tv2bn91OFqVWHYJmlP+eNC3/u2bkf+Q32kBtFNg1L2rZHWQ+D+uUxJJUnCBgykFpXnQDSLHMIYScDaDhv4mvrSJuqaIw5z3TRP8vHqrzX3IZVOO9e1qNR9daT5z8cnBJtH89Cb+XBx2ocoid4vdDsa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:20.0003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b21cd9-48f9-4f03-a810-08df1f76a851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

Hardware-assisted PMC filtering, enabled by bit 5 of MISC_CTL2, checks
the guest's event-selects against an allow list in the VMCB control
area:

  * 180h	63:0	ALLOWED_PERF_CTL0
  * 188h	63:0	ALLOWED_PERF_CTL1
  * 190h	63:0	ALLOWED_PERF_CTL2
  * 198h	63:0	ALLOWED_PERF_CTL3
  * 1A0h	63:0	ALLOWED_PERF_CTL4
  * 1A8h	63:0	ALLOWED_PERF_CTL5
  * 1C0h	63:0	ALLOWED_PERF_CTL_MASK

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index e1c8a333e86fa..7208b910f2a56 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -165,7 +165,11 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u8 reserved_9[22];
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_10[664];
+	u8 reserved_10[56];
+	u64 allowed_perf_ctl[6];	/* Offset 0x180 */
+	u64 reserved_11[2];
+	u64 allowed_perf_ctl_mask;	/* Offset 0x1c0 */
+	u8 reserved_12[536];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
@@ -248,6 +252,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
 #define SVM_MISC2_ENABLE_V_PMC	BIT_ULL(3)
+#define SVM_MISC2_ENABLE_PMC_FILTER	BIT_ULL(5)
 
 #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
 #define SVM_TSC_RATIO_MIN	0x0000000000000001ULL
-- 
2.43.0

