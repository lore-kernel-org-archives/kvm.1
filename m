Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C4383C87;
	Fri, 13 Mar 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390927; cv=fail; b=PoUUfgnPFaiT4SgBiZmjYt+dKy0sMuPRQ4BxNTzWEEV52ABjh03M9RXySwj7USkfikOiaDqepEREfqpnXkkGQzYgr/QaM3tVLv7Hqr2FwtiuDVyKEjErlkwZ++BXwfnYLVlKMRYI+zJlZHWLOm3sase8LyL/yXmqngQmsx/zbdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390927; c=relaxed/simple;
	bh=YkQ7nVg2QzMI97PZ73Ex3i8UdvZW9i2QxtLy+5lV+04=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h52y2rBUTN5EPmAnTHd5nWsfRyYzsA5sb5+GsTFyfzdzqk99fOqgSknxFYfTQLmVFTXButSvgXNjU1GVrZD1FVsy+bbKQZ1+0DKx91zpY2M04Bl970J4kqNJbxReZU+LtWYXriWegDKoxu03RNtnaCtkw7xg2FtFl5OKGWRoRnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jL/ZUhfT; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jL/ZUhfT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyzTmo3nQc6a1RJUCn7Spcy8V2gftXRC7CHXaTLO1SSHXGYXLf3ON2UChXHLiDtYlTWYGnLhkdcmKBJ8Py3FUpy3d0tSa9S/hIAVFr5UG14D8r8qR1/BYiuRthfqbi30MUhUaZoV1kHNmg8Ll8/E6EJVuei9FP2EtzvKU1Q4ybGVE7bPfXe64QBvo068vypwAUKCi77BMTJgRFOfUJNbTodmmgC9konebIPgntWZpGJlpg01Nr/LORC7x7ssny9yZKHa33suIEwRWgvNX3YY8lBgozyoCsO+f3hdNqEKNjbUBF02R4QJoiW1fw95J6u4GHmcjEvK1hcLkGOwjSd/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4koHCGQ3GGYCXVrEIJ0MM1rf2d/syKUJAiLg+JtjDvk=;
 b=xC9ndxBrRfy1usC5Gv17Z2qeJyYAGURub9QiPbMovjMyRQ1Y+/3oHimcH98btBl5SIrlCO5tZxPQUWrDz0vqr6dVWBRLg023BAxsHF1xRqmTctIjloPsN3O0D+2SsZvRR184VSusrB6AA2CtifbynnXh/Wd2oMhTWA626vIqp8l5Aa6Oom0k/pre66uavcBQi6R+cbW5Dg3GIUBsnfZiLvylaQKHpYUGVGpjFpPAaDacl3yrbtWtDznauMGjue2bkLvH9BF9uWYnnjWkJCHd0Cif/9zPk4YGUHAssvJx8z4BOab5iqdsQ6bgQ7/DpmjkTqdT0c3xFJLFtLYhSoOvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4koHCGQ3GGYCXVrEIJ0MM1rf2d/syKUJAiLg+JtjDvk=;
 b=jL/ZUhfTJ/egFVtSi8z/lYbH3JgNkVcKt/Beb47osN0qvhisSttxGP2WmNwy2AX1EoeMQnnQV7OQofiqkR0i23myJpDxKNqGLV25QPdcESea1/M72GdiT+VnQPxCw3Q9MTHMcCvpFY85LmHVkyvkT9VvrCRSUb9Ky7mUUXTMvWc=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 08:35:22 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::1a) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 08:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 08:35:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 03:35:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 03:35:21 -0500
Received: from [10.136.43.100] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 03:35:17 -0500
Message-ID: <1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com>
Date: Fri, 13 Mar 2026 14:05:16 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <jon.grimm@amd.com>
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
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <13f67190-b51c-4719-a409-13d813549d7c@intel.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <13f67190-b51c-4719-a409-13d813549d7c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: ed83908f-b29f-4325-5b53-08de80db770d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g0eBA1qDJvpUgNsZK7IWJcl7qBa10VXuuyQVdIeh2xn+VBfezIRnpqgRy83cPaMAkvrtc5rbzM9HWB33hqPFB5s4s9tct3l3byU87R+io3TzLyaFuhhBpkmE6OMUTT6fXVR7EayNdriZM6yBRJnbxJNKZrbWAK0O9F2NVW9J9+Ai4RBylhoC1/V7FPeR+wTKs7Ufo73oZuwgavJG8k6EelRcwRilH8tW6xo37hBZZNceE60QQIYSjPQCVt9/AsNH7o4O9OBWEp5jReYqFa8u7/NTehGBpqyCzhVJdugo2DVVBRBYvPLQPm3q0AZ72PgcbvcrRB4s7+N5MIiwWt8SDhF7/YQBetIxouRSvZr5Z9TN4p9YoRYNGs9wL78kM2VwkxYBYPdr4umsK8SrcaVyJ7ioFF5+Bj/zwAqIIsFCEQw4iwmR/yMJvTmSqHSD+VoJ+a3SSerFZAKamwN8KBiPI44hRtKsKofd8EdpMl36BiN6FkUR7BX3xXCkMDBillMX21/fNNAKVjr+8NvSyoDMtEmGE1JYQec+DmnxzY3a1Zyi3CgMxJGKJUu2NkrjUKjYEEE8IYxkSHwkesad202PCKEuj8mK4FQcIiWo8aAjCS1CdrVl4TY078NpyJlQgVzf5OjvhTPiS7drJB+uHXAyDVSLhuQzIT+vIj43j9VHLCNU8mQKcJwAaTd8i22kMWtlI/UjFzKDRqFNDT/WdbidndM9nzCezdcL5OlttoaSbaOhFEQOI3m2WCVvbbYpqZE9TLlem1pg5E2pa5bI7Mj+UQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	43mOYD98lG6p8jyJHgA6QzEjI6gZg3YyqyleyjAUajTDZdtZ9KCXMFZAO3tWx/lwV8oRmBCqkh/mkchkHRfCo3//anXmFtRXzHyqvR63Jewb1FEthrBpZxe/2+s5kRu23Cf5f/l5lGbyr7Zhlb8+Pvwo51c/X9alIHf3BU/uo5ocBUMIjY/lBjkIOy8t5xMN9QNx6CtjSDKyYu+GusPEfEYGd2Ux8f71PprIIr1iFZlxAklzoW/gqO6o8yY4ef9tVv09/4iJrAA9UYAprFV5vZq0kc2xio8ZG1Q9oOTG/LZWD0eVbmLV0Ia1Lk6MxSGh2sp8F4gMkDaPkw9UUQp3KY85L77Zv7QKcLfhJJQn+IFbxoYac2lJ3IpXwAViGUifiGn8qZft5+sp2zR451jjD1HLaa5Dg0/uOhHW8v9CxN8WQbR+P3oT2zxsBZZ5rrzq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:35:21.5887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed83908f-b29f-4325-5b53-08de80db770d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780

On 3/12/2026 11:39 PM, Sohil Mehta wrote:
> On 3/12/2026 7:08 AM, Nikunj A. Dadhania wrote:
> 
>>   1) Universally set X86_CR4_FSGSBASE in cr4_init() and call cr4_init()
>>      from trap_init() on the boot CPU
> 
> 
> cr4_init() seems like the wrong place to do this. I don't think this a
> primarily a CR4 issue. Deferring CR4 pinning maybe have uncovered the
> FSGSBASE issue.
> 
> But, essentially the difference lies in when we enable exception
> handling related features on the BSP vs APs. It involves setting a few
> other things than CR4 programming.
> 
> See:
> 
> /*
>  * Setup everything needed to handle exceptions from the IDT, including
> the IST
>  * exceptions which use paranoid_entry().
>  */
> void cpu_init_exception_handling(bool boot_cpu)
> 
> IIUC, anything that is needed to handle exceptions should be initialized
> here. As FSGSBASE is used in the paranoid_entry() code, should its
> enabling be moved to cpu_init_exception_handling()?

Good idea, thanks!

For the boot CPU, FRED is enabled via cpu_init_replace_early_idt(), and
cpu_init_exception_handling() is called later (before alternative patching).
FSGSBASE can be safely enabled in cpu_init_exception_handling():

start_kernel()
  setup_arch()
   cpu_init_replace_early_idt()
     cpu_init_fred_exceptions()             <-- FRED enabled here
  ...
  trap_init()
    cpu_init_exception_handling(true)
      cr4_set_bits(X86_CR4_FSGSBASE);       <-- Enable FSGSBASE here
  ...
  arch_cpu_finalize_init()
    ...
    alternative_instructions()              <- Patches code to use RDGSBASE/WRGSBASE

For secondary CPUs, FSGSBASE can be safely enabled before any exceptions
occur, and FRED is enabled immediately after:

  start_secondary()
    cr4_init()                              <- Code already patched, CR4.FSGSBASE=0
    cpu_init_exception_handling(false)
      cr4_set_bits(X86_CR4_FSGSBASE);       <-- Enable FSGSBASE here
      if (!boot_cpu)
        cpu_init_fred_exceptions();         <-- FRED enabled here for secondary CPU
    ...
    cpu_init()


diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..bd35e98d648d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2047,12 +2047,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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
@@ -2413,6 +2407,16 @@ void cpu_init_exception_handling(bool boot_cpu)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
+	/*
+	 * CPUs that support FSGSBASE may use RDGSBASE/WRGSBASE in
+	 * paranoid_entry(). Enable the feature before any exceptions
+	 * occur.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE)) {
+		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
+
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
 		/* The boot CPU has enabled FRED during early boot */
 		if (!boot_cpu)

Regards,
Nikunj


