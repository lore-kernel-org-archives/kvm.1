Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DF4B0495
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860896; cv=fail; b=jgX1wipNy9WxPRe0lcfeYcnG3Z4hErdduN7Yr4AGai2q0oc1ebHAUahXAAENJbYCrDuXjTD0XKSz4DJdDB6uDt2DyZR9ojxrvRcK86hRfqOXLoCygkb9KJt+vfMqGev71WbMat7RNiH0bpSqSJYrT2ImSNcEGzD/Wk475B80sKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860896; c=relaxed/simple;
	bh=cqVsdgKgSvTmjGXdmxEuPZ1V7Kq5v6L8YMXXn+QAPcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsVrsJKRn0+o0X5sXyKX2N94yr8+PsGbWQaZ7AXEKIwL0qwzt91ItaL/Uw1lj5iSvKg5pUXeS0zyyPaiglTfjUwLInQtPn14yctU9y+2KJFP6DOukYEf4BClubadpELpnEiNAvIDcyWRNyvSVoF9gGw3PxQBr89EOPRjQj4qET8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AZWHit8P; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AZWHit8P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut/F/8Nm88HmP7mccE6M/Qr8jvBH+sunvMLv3ZYYXGecXeQ3HLb+T2GXRvkNbtvFIX8LiQyZ4l2UFT7w7mbRDFEKZhPQ1M+k/8AqO+47Rx3cYqxgs36O3Ih13o1HCkDRAvqnJ1+2XbcwGDl41gSgB1CLKYP3QqhMKCkDUChMV74Gg4ZDJyu+AvK2vBK580ZbsOklkBltNKpZXrCKHFuBHVXR+Ofbt3IXK2oP3o+PPTg/QmrSKPsfA6EQ5g+xt24eTGtBritzSibRQ/jrf1lIzNT/jHnSNqJct5JpPFOol3Aie156rKCDL2ZcVRSNxnk/KP8Ghv9DAyTMDiD7zw5wwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iumje8MEGRLwq1nGbwNhtb3uxPU3crOX41+kWmxshLw=;
 b=mg8A703ereI4JBrtNooduQDdDG0zCvQrQLngQcTUqsDapmUWpVFaiwl9u8sRDvnvKWRtFvYPlG9IKUwyec7n3uMI/HMqi7ymXBEqXZVTCK4qXA7yWXl3BJOpx7XerT7ofQqacoF39XJtU8OgQH1/lEJ0m/WOSG3mJ/Efk+Pk3Ukllo9RKbwPqTkZnP/fOzOGhxVkR8puAbOfTvPoQKZhAp6foFilMXNclERaYkoiUPd7DA20DxmIwRSTPw6AI10rPn/kHA+lTs+CYiqpAYUMXaW5+5WyZg97Mr8L/9tFQV98wa4XkUwcDPvDIWBuHNwkiwKcyRPaBSQL8x2qiGwVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iumje8MEGRLwq1nGbwNhtb3uxPU3crOX41+kWmxshLw=;
 b=AZWHit8P6ZpT94BGaFlYPafbzrzxzcstRgx/h5wN79DPM+ELOOQkqTxXgTxsSyc4YnGTLEKVS1kQfP+Gc0B96nbwD00APRlvqwM0RA4sti9b0xYbTqusYJ1eZt0eeEZL9kfWeFUqp0TEU7J4dHrr5ZFyb8ZVYcemwKGZdopCmH0=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 13:21:25 +0000
Received: from BN3PEPF00022BD1.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::28) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Thu, 1
 Oct 2026 13:21:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD1.mail.protection.outlook.com (10.167.248.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:24 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:21:20 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 8/9] KVM: x86/pmu: Disallow PMU event filter changes for protected guests
Date: Thu, 1 Oct 2026 13:20:20 +0000
Message-ID: <20261001132021.254270-9-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001132021.254270-1-manali.shukla@amd.com>
References: <20261001132021.254270-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD1:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 9432a95f-175a-4199-792e-08df1fbee493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K46+HH/W6Uk6eYYAgMDaWJGhOYGFyE60yfajdvec8c53SQJdwWRPlFkO9LpNBHf7rt0Yg/8Dd+JiATLQnrZ9t+tb7cZaU+wZmj8Te5Emx99LkS5uMsbVO2aDCtx2Rbkb5jZarT4aZ+Y5T43ZY2ZjoE/F05zTUoYeJoqvyURjTNbN3pQWHtcJwB2alEWHFL8OlVJnXFKCtnJKGbFnfD4vOFUp4syed34shxkf/3ZrRYuKrDrdswuCUwcJpF+ZrtqMMuiujWXNGmw+ZbekXIq55ejzi/51PfifUzSXpqA43o0lDHVzmBoOFRR+EViKRkXMcFyu4nmFrGUKMKoCm6pJhc6PYFnlSA2BNeQmA88kz2ekroyIVwi+9L+fHxiyHFpUY/DdRtu5s5lJENHeqSAlylcfsUI4oO3t/q/+bxvb18cFYJpdRHJz9PILy/2orRe/1nJVsZ15lcG17izxeqT+NCcnmsY4aaGhRYHnoh2TPhH2CtSoa0j9uinrFcYi0vMFRasQZRmX1i4Rk+0Uk3wVKy3NcvZqDfASMtKbESQpdO91y/nxnnukLyt1VjuRQcau9bDR+0h3f1o0kRRXnmE6QsciYUx5JglKNDuNT5QU1vzKkeEhKLk8mu53SAe40Y+/2zIQe7xwsgnw5iMdXd5IDUYxb/W2DnW1uA1RrQIbyUDtC+zcwBNmB9/gd/SMCZPahy0L7dLRj99ckojIPreuWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5cgx43ATO8nGXDD3Ee1VdESBOKtvcU50QCzqElPhNAmdABsvo0HazuCbbvRz/B+fLb8EUIlnhjqdQplDKXMjvZnteUCh/eQIdisH9UO32hMATx9zZqelTt48Fro9xjVzzcMP6nWv1NzeOXoNHJDEIZJsz7fP1KV3VoBeBx9MzMOnDQ9itIfBLeA3TN3k9+Owe829WifKooaFdFU7eQYbs/HLCCy3e4QyMb/pcAwLJT79JET7Nc29hmyeK2NZeD0OS0Xq723qMq/wxINQncPpOhvdENC2lQPKM8mud2lxQH+OWIBIAR0hU7gzBLplaxGdbKt0Qx9sBhH+1NrReY6CYJdPTUFbl1+7QxLtR3NB5A1LQxn9T2/GcfJsA4KULzI3Y1Z/8Ox4cexoihbHCeOpWW4ZejNijKrUvcbzf/UAlaSq43KidyIdeO+It9YMHQV8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:24.7963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9432a95f-175a-4199-792e-08df1fbee493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871

With hardware-assisted PMC filtering, a protected guest programs its
event-selects itself, and KVM can't read or change them.  If the PMU
event filter changes while the guest runs, KVM can't stop an event the
new filter denies, or restart one the old filter denied.

So fail filter changes with EBUSY once the VM has vCPUs.  The guest then
always runs with the filter it started with.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/pmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 23d439ad182c6..b3115c63f5c45 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1388,6 +1388,17 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
 		goto cleanup;
 
 	mutex_lock(&kvm->lock);
+	/*
+	 * A protected guest's event-selects are in its encrypted VMSA, KVM
+	 * can't re-vet the counters it runs against a new filter.
+	 */
+	if (kvm->arch.has_protected_state &&
+	    (kvm->arch.mediated_pmu_caps & KVM_MEDIATED_PMU_CAP_HW_FILTERED) &&
+	    kvm->created_vcpus) {
+		mutex_unlock(&kvm->lock);
+		r = -EBUSY;
+		goto cleanup;
+	}
 	filter = rcu_replace_pointer(kvm->arch.pmu_event_filter, filter,
 				     mutex_is_locked(&kvm->lock));
 	mutex_unlock(&kvm->lock);
-- 
2.43.0

