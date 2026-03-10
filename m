Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB533D1CB5
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122447; cv=fail; b=IWMl0fbNikabXaNSvDDdhJpklp0z3gSIo0Dyax5XeWECWQanC8ZrbhhtMh85LcrkqIY9j7FGV0d7A8NTOxFONPBEz1b7p9uzl3i1Jl2GvDsKxO6+Af9V8UADTJ5GqsPZkQp3CRzlzoRpmxFInaq5qLv1bFR7EjAFMsU4dfCejhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122447; c=relaxed/simple;
	bh=AWGUAAkWz9MVksZ0byRGzgPVDzEtqjrnoGD2+IWsFKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sm/UTxS7+YAUJuTQfHuHeNvR9ni4InSg6HJOtDDOexWYcXpPB4RrUvl+ah+o7ccia02oOHZR3P5Yxc7B+AyrJjdyfBYIxK+mHi9W9Xg6eSdKmUZJRKHCtvQnqRCxkQcT/2ZLAXlUailKibuGGrAF8vVSQUI/tEc884HvZ8W2HzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QlMVJBrh; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QlMVJBrh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvkWVyaImZ1TgCYfVnSy3Vu41VjMrqxfK/TVHL5AP5zyYsRin15huBrNTg+kq7UVx/AQlkmu9SuDFcJGuQUPKW3rjapFMzp+yh5IenQ11fcqeFGsjun2w8mPCR5AgOPIKSZpxLmduTfjct07/ruNjuDvNvyaBxMMB2i6/I9kWJCD1QzhvS/nm43aWevCCVC4oc/z2ZN4SQT5iLnPlGZwDkAL8GtnNU9+zyvsbCxclN65J8o+cT6QUyG1dpqanOI33BKZycMjxGMWl4yJXsJE4Uu9YBjFA4toG3uwNOrSOBbIIdGaSk5X/PnqvVwfuhkjDns6CLqRYc6P0PP4pIIpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWNZPoaK0jiqnN6ChvEFw061VNjzJqjHYpeKDOm41no=;
 b=Jqb8RMONXfNTBWV5A9rYH2Y7hOS0Mgf968ax5djFINRoQ2UgKXkPgy1g9QAbo48zqmOXaSE6Qnpz5abomGdADRShjIRfiJyWFeLIsgM4mezzvuDgGVrmUiMeceMPg2Ml84zsW0CWTPCJp0/YRiwtJqzcX+qjCJRvyWl+ZSeVzbztpUh9V39JBgvJkR9PwwwPe/DrpGDMIq3G1eLAFHlNS1ILy0pVwVz6ki2gW4MwJix/LLgr7aHnzcVfLNbPvXProQvFT9Qg664FhiJTglskHprvK0IBrqWT6owkYvsLwkZ10JjF2WysAM7p3Qz8bcVCsU8FpSXOtHYZb6aMXasgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWNZPoaK0jiqnN6ChvEFw061VNjzJqjHYpeKDOm41no=;
 b=QlMVJBrhWMKlyxvgjDXfhXTJ3aiZpqMpfZcrxl5iSymq+vGMedXesTEfKb6kmdXzo/ZpIy8i8bAC0r37cpXFV2phFhyVJX6dwQ3PZge7fByIviq9zm9ZiHdbuzC/FSV3xAZZq1XhklkojHemm0HzpCPk5nqBbxCygbXxQO6VrH4=
Received: from MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23) by
 SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:00:38 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::63) by MN2PR01CA0054.outlook.office365.com
 (2603:10b6:208:23f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:38 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:37 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 4/9] KVM: x86: Extend CPUID range to include new leaf
Date: Tue, 10 Mar 2026 06:00:16 +0000
Message-ID: <20260310060022.15120-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060022.15120-1-manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: b8be2f88-cd20-4631-a8ae-08de7e6a5abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	z1b5gaedphLoB0AmNobpaUxuhUJ3wP7cQGRIo3Y5Jdl3mc9bcyVj3jt8qlLmTsJAgVPn7H55TitSieEJa0jq2tr4y02EIvGbmuqvcJLzQ1PkZTys9+5OO3CgKIMDTi3y93SbZyHhTG5U0KBy+BFcsrEoXOqb+qAXxpp5qjNX3USGHkZ4xSHogf5LZW0hfVk9l6JaYzQQ+s343y87zJBHf2KGKmFNIgjos51TXONxFkmwtpi0uKNDcl3mnTgrKN+GB2fmz7+jrFDgCNfPXYiNTSc2hJ2W1t23Gij4JyDlI7+VW6l0cGviaT8SNixLUVFdshukYFar+Y3J3SLVEIjrlP+LQ+MlFHYXSCSKZLzQHOk9TjaQBZslpoAx1qLof+pGKaoZrrT5pTd3Tm9SWciUGREcPaT5N86BNjdHKVaDy8r/Hr2Y1l7kJhKHhqZLcBobbA8AFyOTJwIz0+J7lWztsgkD8VToOP6Vl8/7v6JvHG6Mnfbo8LGEFGzGRlEScnTHJwLDAEITIEOhq5HOt0m5JIeOyHYgICX6LhV1mwDzArLQ6CzpI1UFmHuHOod574ViBSk5sY7eM07HQf7C2A5X8UjrPI8OlhvGBliaUp5cFyBmvNYAvu0WGF+WfX0wcVBGZ/IqSYm8cTOAlmcW//eCt2w4jqP18f0rAxsBuNRUS0E+AV8b73F4eCVgIfhQXOWR5CVbWS6PmFIg2TbYsuHRZ8uzkIjPVkrHRytdOKb6h3OaI/bTGnoV8C3ZYvMmP3X6a1uxiCf5uZ1pweqMk5+1wA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Wy7UADCihE3B+5xOlh0HZvwAE8V0vzFrMBAC734mT2+1IzLhL+oarrV4S15ZjK3Cvk5eE2wfAoQcPd95NJXNU/woeyh/GO3nNHyxtWkItncmT78Xe+wp+w81Hn1BRGmCAig1jbcK42DA6AHe1UsiAClWjkkUGDh1/E2cZ9dgC8OP2M9MPeFjwCLcYNTuTCEhjaL66756YcdlCIBFX7dzvzpx8SGNibIQNrsYasFl4bM3fvDn5WD8gwEIUG4+oMieP/taKXEFq1dNprTgxEfpuYR7saAcH7qTkL/HoxGrpKCswMXNwBqQyj8RhW+gSrnkSmNrF58kzscs8YPY+Endo3Y0DSus4ngzduqzLnp31KZK1NFT3AVWphlJAxWP/GyYp+ZLOhqUWOG8Vw/bFX1FkWVb0xbqEPXD9sIFHVNZdFBUyryUMVeBLHY8HTHvpch
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:38.6916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8be2f88-cd20-4631-a8ae-08de7e6a5abe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

CPUID leaf 0x8000001b (EAX) provides information about Instruction-Based
sampling capabilities on AMD Platforms. Add the new leaf to
kvm_cpu_cap_init() using F() macros, which automatically gate each
capability bits against raw hardware CPUID via raw_cpuid_get().

This allows vendor code to simply clear entire leaf when vibs is not
enabled, rather than reading hardware CPUID and calling
kvm_cpu_cap_set() for each capability bits inidividually in later
patches.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/cpuid.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 96a08a556543..4e626e77e6a6 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1226,6 +1226,22 @@ void kvm_initialize_cpu_caps(void)
 		VENDOR_F(SVME_ADDR_CHK),
 	);
 
+	kvm_cpu_cap_init(CPUID_8000_001B_EAX,
+		F(IBS_AVAIL),
+		F(IBS_FETCHSAM),
+		F(IBS_OPSAM),
+		F(IBS_RDWROPCNT),
+		F(IBS_OPCNT),
+		F(IBS_BRNTRGT),
+		F(IBS_OPCNTEXT),
+		F(IBS_RIPINVALIDCHK),
+		F(IBS_OPBRNFUSE),
+		F(IBS_FETCHCTLEXTD),
+		F(IBS_ZEN4_EXT),
+		F(IBS_LOADLATFIL),
+		F(IBS_ZEN4_DTLBSTAT),
+	);
+
 	kvm_cpu_cap_init(CPUID_8000_001F_EAX,
 		VENDOR_F(SME),
 		VENDOR_F(SEV),
@@ -1848,6 +1864,15 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = 0;
 		entry->edx = 0; /* reserved */
 		break;
+	/* AMD IBS capability */
+	case 0x8000001B:
+		if (!kvm_cpu_cap_has(X86_FEATURE_IBS))
+			entry->eax = 0;
+		else
+			cpuid_entry_override(entry, CPUID_8000_001B_EAX);
+
+		entry->ebx = entry->ecx = entry->edx = 0;
+		break;
 	case 0x8000001F:
 		if (!kvm_cpu_cap_has(X86_FEATURE_SEV)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
-- 
2.43.0

