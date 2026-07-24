Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095044D6A1
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922772; cv=fail; b=EvGJJu0Z5kb7mLfCb5aqi9j2gDrJAPsPaTuJT4XyQHZBFNc6JgKSOOzP7OSS9LGMm22biadkc6mI/LSpV3bn8OXIQ0KSA87Y5644C/HGRW7n+iim/T8Tq0i9oRnB7EfXdwgzQBpoGWvEFjKI0/rJviWx0SlvByzqLl1b4RV4JFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922772; c=relaxed/simple;
	bh=6wNe8Bjmr5AT1LqihAgisiA2kYRAOiAc+AkMsTviSAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chZWCQZP2FRh0pdrz9q+HhjE0AhkCTumVUg30BHddPKZjs4qVIsiDs2NP9orNI/7bQscERsesXQnUHF3CQcURK4QUynrcZ6Du939gU700+cd8NMwXgGWJZAr4XdpCR1vc9taPo8QBFe7OAACrZs5aD85mixSDO1UEDJvJRbQSfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W2CTA66w; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W2CTA66w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwTRTGv3YntwAEjIQinT1RRu2QuCfjovRxecxHi4L4z9klhJP95JDu0S9QLLQAHh/LaabUMvT33V74VlNCJ80SDvTnIqzQNWG7WCx2jYjVWrOYqkydPm+T/wFzc370cgkA+09tKMDCTw9sr6jDMTaLY/esoFW3SBfzva5PSa4u4UJELkns0HUTgXd2ezZ5zhz0Nv0xZ8jgg1eSllAXSdpAfNWEFfubanJGoiJGglYbRXgFV0vRcRBAcqWwdxm8K8kNx3gxAAFHYd2zgzyfLT2mDogLrj0/iXhPuYdUL3UwMqJDimidMA1BgcmJ2aCSd0JrxbWXvUsOXMW8VfGo+bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55XsyNcJIs6RD8T6BQZN86YMdB7xjhMNWxurvTQJ0MU=;
 b=LR+57amBsSiSuHc9EQyQHG2BC34Yg3kUyos71j0EFbab8b9HjZfe7vpvC25cKXLtW20dylLXTvIPLjMHp0o9jJ0CLJyDwIhwBLjoreVSMQQNfPTa5G58lTuGr+2FRvO2A24J9EVvs5ALozs1TO8CgY5zte5MZd6PhgAromXBCnAhg8a7HIC/6LNEtE+s3YNjZvqAjOKxVujJfVqaqUv8WCilYdQqnWVTPY88x2UTsmn0MB0NOJ4DvYSze0inWih9e+0cxQsQ4iKn9s+xzyVqSeJ3qs/zj1cV8ahiv1CJXS11J/0Rh6An7ZpKYweB9ybu1itceuP6pxJ2NsoxJ92MsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55XsyNcJIs6RD8T6BQZN86YMdB7xjhMNWxurvTQJ0MU=;
 b=W2CTA66wV0TbGgs736rfevhJ7HZT8YzgUEwiF4X1+AusQ3qmiKDyL0PRcKvruT+T78l5bg8DmX3r3jXuZQI8ewjtHR53vxjm2hePjdmQmmPosECWu7U9jJf0M1LEX1BMVUBHVKQB8cg3P++E4/nrLkNvdUQY4i6zw4PGf60nq4o=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:52:46 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::66) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 19:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:52:44 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:52:40 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 2/7] KVM: SVM: Add capability for LbrExtV2
Date: Fri, 24 Jul 2026 19:50:35 +0000
Message-ID: <20260724195040.630468-3-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724195040.630468-1-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 503277eb-e2f1-45b0-612e-08dee9bd2120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lGnwReDFJnvxHO+1JNXF0BTTqlhT7MlN6jgbyhWPIbIk9AZYMmFf1KOgZSuFoPqdy1bOld2bQ5eSauz8l+fKUSoQ4BcqDHI/HpofAveh0got1to51p5hYPq8wcrtJGWjC1d6hkYjpAK684LSNugKf3iCBEVCB2HunhkD61ygK8tqWP3o/u0CgHZLdyh7fShJ+qBeLkwLQV3Y9AvF3zLxZsbsX/2XV2+xOVq8LUk3CUv5wf3Fn79EICk/T69roOmZ5im/0w3ZZjyANqcYJ+c8Z9U8jV+jHDX5L3occzGBHRN4OCmE19+/Z5+xll9CmjjymHbYk4XXzXCegJXCflrPZTeDkAKAg/6PHLP7i9dPvZfF6XFpe1Yk+Kz/6reflwjsYqavDlbHa8JHUlYJlAzCmsrpRbXMlLa9cPCna1kn7rftAcYBLysWYpDLbVN5yYdqu2bBn2nRXx1ehlk62UX+MPrWv+itr9M4iphxA8JGM8/uvz+9rgZWpXyZjYpsWUGT9reSluZvHwe0DVno8B5umneqfWUmLhYJm5fTWpS8V0J2W3foIDo8Vg+m+b6GtwIk7bVaXvoiBVhF8yDkbNvTBP+mcZkNWUT+JC5oCMat5YXcLeU/qYhF1q+WWmk/oWS2aZerYz1LAIMbawPNFWxuf3iI/TRs3OBWNOKMyQYnWBcpyjheApCfokBy0gWHHPKFSooGY71JMpd8GYvAEW3HdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d8D6d+wr+PvcnEyBGSv4A61Zrzq1rs5qSfj52Eo4GWCXKA/xyIZWn627jQIiyTpY2/C8Bsy/p5ytlrdCus4ymZq5htmNuxT3ofz/i6Q+j5Q0WCHpKwvcUTJgIlnhEJ8b5zBpXZHwWlMKMRi2f5ShvRfo7Oil++oYfKf7SHEwNWqDsg6nElt8hmoE9dYFL5i8fs71BNT7x+eHlVxh7h/HCP+wFGmoAfwjF4O1aqKyIRuh0LiG8MLvhN8bR2daKRhLGpYl6+3sAKIsPqZV0JSPFZWWC+IzZThPoURIdBqKxqLn/oZJxJuuS1UPoYY7LXA6cbE1BnmGLrJze92LP/hRlJqzJIBfWlNxMGwJF8IkYsCPVlWlCBEyc5F06WXLLZ7U25aPLumUTN3EO/DnfuFkTWNUyKnDYl4x45OSjUxP+Ip1gB3wpMdQV9mn9vQm6UX6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:52:44.5722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503277eb-e2f1-45b0-612e-08dee9bd2120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564

Define the LbrExtV2 KVM feature (CPUID 0x80000022.EAX[1]) and plumb the
host LBR stack depth out of the core PMU driver, so KVM can later report
the depth the hardware actually supports rather than assuming a value.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 arch/x86/kvm/reverse_cpuid.h      | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4b9e105309c6..4acbca1a88a1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3138,6 +3138,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
+	cap->num_branches_lbr	= x86_pmu.lbr_nr;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
 	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 }
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1eb13673e889..f18cf0986e12 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -306,6 +306,7 @@ struct x86_pmu_capability {
 	int		bit_width_fixed;
 	unsigned int	events_mask;
 	int		events_mask_len;
+	int		num_branches_lbr;
 	unsigned int	pebs_ept	:1;
 	unsigned int	mediated	:1;
 };
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 657f5f743ed9..b4abd839af1d 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -71,6 +71,7 @@
 
 /* CPUID level 0x80000022 (EAX) */
 #define KVM_X86_FEATURE_PERFMON_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
+#define KVM_X86_FEATURE_AMD_LBR_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 1)
 
 /* CPUID level 0x80000021 (ECX) */
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
@@ -146,6 +147,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(SGX_EDECCSSA);
 	KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
 	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
+	KVM_X86_TRANSLATE_FEATURE(AMD_LBR_V2);
 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
-- 
2.43.0

