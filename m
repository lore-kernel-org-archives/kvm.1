Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AC2BD5A8;
	Thu, 12 Mar 2026 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773300095; cv=fail; b=Qyyq/tt/fMWDiUi+AtQD5Juju60a+PDclKQrjwWLKY9KlpB0YuCg9ql1GQb81/bJQwdR6EDMo+CI5JBk8+sHxDshzbCGVZFtvpITLQBVyKl/Wo567H7VvkErP1jJ5iuyRNnsmH96FyZgB7vmazDGFu1JVtN4fg3+guYgSrQMreM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773300095; c=relaxed/simple;
	bh=OGRVJtTR/WkLKtXSuP0oZOv06vK1tZXWGqbXmLszU38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AURZSQzYf7otkuzY7E4QbWbebsKp5EjXflSl229b56EDt1yAdNj4/ANr7Du54euBBOM0tX0kvLggcK+82Y+gWae2uyN7tqRdKMYFElxo1liW9SlRMMGa8NkP0+60GyaL7fsCv/574x+T4Q4/TV+VtXbI7PcI4xKPn+KEya0flEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qm6GmOTD; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qm6GmOTD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6peXhfSyJzdEKkam/SNDaCCEKc80tyH5S1UBJjcDFBhqL5OJIwTRnZvjDm4OUdQb30uCu4/A3grdvYqw3FS9YdPcHOiWU+DHfqP6FBsR3Hor3qjY2xrqh3056VlWIYutT2BRgmVc15z2L7cb3kgFYh11GMI8aYD6v/exmztBgpVeR12ghW7laTylU/TZe2Ny2k1D7M8zlZTkNB9VVa/UhHDEqqHNYUavRDDrMtuNyqNdbCajwmSvxWV26X2GxMFZH9izs9ooexQ07IKZWAJw2E/rSamKGpdGOWdShvGkEmmNebsvqwa8wBICr0DeCyuQygir/MnCm1EUhOjiaZ9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdRWeK0PZzAzKAdjZZvCqbTlqLmnEAjsTlTCk2iPDW0=;
 b=fUyRpekiShXhD5n0xp0Mi66ow2dKao01RuU4uYPYw/WqYvXh6Y3dIgFbwdn4F0BbzsMtNkWTYOxIH7Go8RImrbGrYGMc6GLthNXW6fNjZ+8Ta6d5MYvK1pxYzCmPmDc5q0ZTruN69Wabsv0JxLuDy/DSnOZNclom3kJ3dYY89Y+dbBiiW4t4UTnc4UgIV7pnL6fBkHeeuK2jHK48OHqztYigjh6qLrweEWGUkhOEyuKyT4x7WWZbAQ0zIfv/m65YKBMs0mzogecw916Mwf9bO3IA++80nzf3pYp1k51DI2U0UzC1t3JDcvO3YhYKaVAy/hjlYcl1jJU9OpdYexTp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdRWeK0PZzAzKAdjZZvCqbTlqLmnEAjsTlTCk2iPDW0=;
 b=qm6GmOTD6ZFd2b7Iloa9/Vbkj0E1YqdYf81VsCkH8Yjm/sLZ+F18LKsOAFEWOyfHMBnSRD/Rz+LhwYUT56cH/XDvTJ1WDwGXL9O6zXnrWL172IZUhYtV4PxOAvulP59pagZgPDqnKNR+i/07CgZ/5SpmyVJaI3jGQh1Jo/WRG8o=
Received: from MN2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:208:120::28)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 07:21:30 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::96) by MN2PR10CA0015.outlook.office365.com
 (2603:10b6:208:120::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 07:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 07:21:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 02:21:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 00:21:29 -0700
Received: from [172.31.177.76] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 02:21:25 -0500
Message-ID: <81046249-09e2-4c39-8b77-992de916a7ba@amd.com>
Date: Thu, 12 Mar 2026 12:51:19 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Dave Hansen <dave.hansen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <cb492a37-3517-4738-b435-73311402e820@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7786c054-ce98-4b9f-908e-08de8007fb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2SEptjRlVPvBRr0HfygOVNcTNUumRx/f8ptz+xqSUaAQ56+8d6p5ySYCY0r0I26BAAB9tofI8PvXQ04FCReHBC5ERk/aaK2PkC5joo0n9YpaoIZ4lYecZGpefEBnNbQTGKeWP2+KqwTKGfTSE7YyNQ/W/gldJ/DwqWuYW6RiPjjB/SH/5A3ugAX+zM+JSMEDCHnP2ROKmnF0abDakQKXv4WNZMv6hNYV2Rs32Z61rS7UA7TNx+sA3ksyvi9ePZKRSMU+8zs/SYVGSWBqh/qa0kmFuDCaT9IEchzC/AZntICsp0LpOijxKNsMwDljLAt6Jxh8U5ZGlWoEHmdYerKX7kkI4qRIBT1crXCqYws9H7qHPk+gW49tE0szcgsufZ15cJVL4GmTaQk8sSGM6FbpSCLqye6XXvCEbDL8po+/3lh7RYcSryZsqsAzXCMGqBEV54RbKwxpuMpOPmk+mMPggY0gxxsCCJLRRSIQKstp7wtl4ltVgAEnH4IU0KLCDdf3gTFz5C4SFX5YwZpeopf0ZJ2QT6l/8M5PRdvUaOGvHziHRH1r5CnmerghLQUVdtizxUKL3CJUQfvpkruiRZwEU5a3x06B7ReAjqr1N6HCbHaKlv1XBFVL7Tr4p8Wc6Vs183qf0gXN5fzElAMQEJpLnh2RVj8w2l9l7zNwbkCaDGL869Hh8ujTm7p4m/ng674xQQCV4GDpsI/yVRHEQ29hyU9e8UIv7hIIAWOplZtqqL2MeOfs9Z/GbMXRmWCfp4745R+K+zuQt8Mo9FFGWhGi6Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4PyxUJLmFuhAvHIBs/+Oi5+Yyb47A3OJ6DR/t+cQwS/wXt2IFuq+riDWfCJToc7aG2lN9k8DRJnK0hp0B1n9fCNbAj/qfmZGI186ygBZO7FQgVLlvQN9trDQGbnGtkG37B/R9mJZf29GgyKUJUWz9DOO3nnArxGZQFnnpxB4nURaj3PxS60JBo1igqm4jIpksgPuN8B2Y9odY8B+VyvNwKODD/T5AkNxcoc4o0vuuACXho8hAX4qE+6xjuqfW1rdLI8orxrKyRekohVTnN15t5Tur8R2R8R2JrNRu6wLgNAOA4fbjGq21+lM9zC+6vTxd0DMmKyc8CD9DHaf0FyrV/u+/Ai5ScUKF4ANpFHxxwyHYnDAzWoeT3Vk0B/gocPsqygyUDUtHBpB6fY94fvIuKNOcenMfMs+7PLnDz3OyJlAIq2zo8xwcUY+Cb2CFw9k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 07:21:30.1917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7786c054-ce98-4b9f-908e-08de8007fb4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511



On 3/11/2026 10:58 PM, Dave Hansen wrote:
> On 3/11/26 08:42, Nikunj A. Dadhania wrote:
>> -void cr4_init(void)
>> +void cr4_init(bool boot_cpu)
> 
> I think the "pass a bool to a function" pattern is really not great.

The reason I introduced it was to avoid double-enabling PCIDE on the boot 
CPU. The boot CPU already enables PCIDE via setup_pcid().
 
> The problem isn't actually setting CR4 twice. The problem is having two
> different code paths to set it. Doing the 'bool' doesn't eliminate the
> code path, it just makes the whole thing more complicated to reason
> about and further bifurcates the boot and secondary CPU bringup paths.
> 
> We want to unify those, not bifurcate them.
> 
> Why don't we just universally set X86_CR4_FSGSBASE in cr4_init()?

Right, this approach becomes much simpler with the boot_cpu:

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..6c0493eaf813 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -502,6 +502,17 @@ void cr4_init(void)
 
 	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4 |= X86_CR4_PCIDE;
+
+	/*
+	 * CPUs that support FSGSBASE may use RDGSBASE/WRGSBASE in
+	 * paranoid_entry(). Enable the feature before any exceptions
+	 * occur.
+	 */
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE)) {
+		cr4 |= X86_CR4_FSGSBASE;
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
+
 	if (static_branch_likely(&cr_pinning))
 		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
 
@@ -2047,12 +2058,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 	setup_lass(c);
 
-	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		cr4_set_bits(X86_CR4_FSGSBASE);
-		elf_hwcap2 |= HWCAP2_FSGSBASE;
-	}
-
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4dbff8ef9b1c..0a2b129bda03 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1685,6 +1685,13 @@ void __init trap_init(void)
 	/* Init GHCB memory pages when running as an SEV-ES guest */
 	sev_es_init_vc_handling();
 
+	/*
+	 * Initialize CR4 early, before cpu_init(). This ensures features like
+	 * FSGSBASE are enabled before exception handlers run, avoiding double
+	 * initialization later.
+	 */
+	cr4_init();
+
 	/* Initialize TSS before setting up traps so ISTs work */
 	cpu_init_exception_handling(true);


