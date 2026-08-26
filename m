Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF13B5305;
	Wed, 26 Aug 2026 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787784763; cv=fail; b=J8MfHVKjenOObgaavDsGLNSiN/2gy/BgSDAtwmdqc0do/ff27a/bh8GMfO6Jj2n+Q2EioAThPn4uBImRSg0OW+MCvDG1rb1A6E59Uw0D8FcXBaR9SNFfN+68MtnGV4PjTu1+Z/7Aj1VRbgzOJbIwljwkK9FsMaHj0QS1jpvGzMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787784763; c=relaxed/simple;
	bh=ADB4JQxfzU5Dky3RxvOda6q3B3ryFlMj/GCsn3RuJns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XMSlnRM+LsYcR+9yi/B9T1q5fDvciC0X9tOClWZwr+8SfX0GsmbHpjK+Jye7PPWBBm//pEE9JUbdDZ68z5qLHqdRTtXp1fSkddhJRYwi73mUIOO244NVCvXb+zWsh3qhFiEt9e3BTuP7UiXUx46E479BNrReFtr9ijjtlQMfYdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dms19mh4; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dms19mh4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ4dNgnMHBTR5xdf84YIgzd3Gy50mOB+INnpE3GJCmdh8vCXhG5iQaVgLCHahKGc7uwtCgDs/H5H035KNy2HNHsncgUJdg5Ot1HIEgq7NejL4V82/tflxOYwgHUUMLbjEHEzKn2Qq0zzknEwZB6SsGyAdvld4EAPWA+aoEu6G3JpKtl0vBN3aiyDECZgqqHes6U2mapd1SjGJ6Z/qKlhD18/dgFy0pvNRJVrPZQ9oRUKktH/3J/gffY563rl9WomSZHtF2Lth7FBgYTRx56PpsV3NiVafJVwmQtkP79zaw+O0QkQugpIbbb3IPtLiPNxnQEoJvYghiWzrtdnQVDkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0sbJO93B4X+/TTz9a/wUcXX6D2HvgNhA+mK6aJegzk=;
 b=ft3P0F5ZnOS7jWf9CmBNVfl8NvMBCwf6rVegUrlDBI3rwJroMMS9VGaZgnVSGxBZxtFArL5mF+awK1eDPYPjyuVfgCE/rgPJEd3X84wZHkMBtQPpF3SYD653ZpnxhAQd0S0q1UQQxDmzl4onYkvy9aOV+qltLhAYloi0bKIfVOm8PwxlhrRMvEMNnOMYyfDrgmmiN+X1Ru2yqpqzjN52T/l2tTWLt+fHNr7tLITkQUEsFO+a+QW+OED4EQKJYkzGBDLCRlvNvUL3jasJhBZSAgqcHvY+YPlA4h9PvHv4HqgF+1Xc59vzGSzRCaYo9ETBoEx8r9k8sEoZ9ObkmDBPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.90.133) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0sbJO93B4X+/TTz9a/wUcXX6D2HvgNhA+mK6aJegzk=;
 b=Dms19mh4FKnFqzCnRgZYAyoQGM2gpr6zuiCxROCTrm/kDCImtMA3Jqx1s2GZzwxnAi08kwFskrvlqdwo6JisIBDMATIH0hAUQRHJmi4MOYcy+nh0Ds8epa+KW1bZH+owrhiO9uxIdYnmQaTfTtBoXowElIxT/TbC/HisCUUC1XA=
Received: from BN9PR03CA0567.namprd03.prod.outlook.com (2603:10b6:408:138::32)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 22:52:36 +0000
Received: from BN3PEPF00022BDB.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::57) by BN9PR03CA0567.outlook.office365.com
 (2603:10b6:408:138::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 22:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BDB.mail.protection.outlook.com (10.167.248.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:52:33 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:52:28 -0500
Message-ID: <ef5e8d6e-f1b3-4fe2-a1ba-a93c240b3f36@amd.com>
Date: Wed, 26 Aug 2026 17:52:28 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] cpu/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Naveen Rao
	<naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <stable@kernel.org>, kernel test robot
	<lkp@intel.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-3-kim.phillips@amd.com>
 <20260818232204.GBaoTpHK8k7wD9mMk4@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260818232204.GBaoTpHK8k7wD9mMk4@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDB:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4d81e9-6071-4635-e931-08df03c4b732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|23010399003|36860700016|13003099007|6133799003|10067099003|11063799006|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/8nU4/W6Xo2d8nseS3F3LB+1LnKjkKVyDptAY/2aL940S1DAtkz26VToBVJ5V997GDiNPXfeGvWcVh5ge9EMGZ5zb2fiOwuumLZsodvPj6ivCeDTzYhA6EZ6iiaLpmqd75CtOCITp2ri59kCk5toQFZKJbwsyi387Q0FQOPHcIDzgvbV+OI/hSTv38S1a3HIhb2OKOTiCSUduMJGzG9r+SYVoolwBMQcQ/Z7qBbBRLcXZ2q+OPUqdLdoplCCJY6IW/hyccTqVvcS7NTeiN/TFpbe7Q2lEBF643J0FwnE+OKpgnaQgDaCUrKi5bLPxfglGLhnPS505N1Xv0dGLs1vStNyPXm8xX0js57mn3KSPyinIVk68PtCcV/Z6B3zElN/d5E/1ft8et/NaUOvPvbXqipw3k98bH5pOneH6tyObMxuxUEL07hWazxO6c7cfS//uSXLlboGnWdt0NF3BMXTUGox+FUmwDFs5+80ZmQd0Mw6iMV1EGlKX7ONU2+pwdlYQa0KS5XDE5ONP+AhIKuQ8bb2MXVOLp14nNEIQLAngx42iGNr8QMxVddEaio+5fe84OoiwrF2c4Dzs5Jm1wTDzb6WT4hXOeQKvXPYeH1bEuaw1uG8T3Ai+COjoQNL4xUg13B4EnEVWM6J3j8G6aWgiUr5E/wfRjSN2JRTK0GqZ+xfkcSqPrULUG3A8hdy3I+6a2rvfu5tZiK0K/abxsxiBg==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(13003099007)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8tZ5GS9Bxk8IHON5nNrAlg7rNGh5ukp/AJu/v0HBvbgbKj+qqzD6tJ2wL3N6jRH1V7+Ad3OCQ0kXhHdyv0J9DHi7u4nupbI7vTMCw1Lg9xYsrGsCvnq6AqffhIAvtfgRV1ewl5cKK+ZnKVEuelcNmmjxJIw7K1/A+5cotiZyAU1SnptucEpmdy81W+haCijihSoww4JnngpvVf3UmsB9qi/XlvxVhfp1NXBAMI9+A7TeBo8U/2zXBnObguB/dWhfAbz14xfLsd0r5NIlCGes8IIa4NthfDSKaL9H7wu3t2JUC70gA3mdz0I9W3wI74o8tecWEozFGkNBJ9I+ufWE1PMRD44RSOceNPbX3gnrvptpam2YN2Mlj6aeOJBz8SSft7orQpXO2wYYgkRDoogmhKgf2hc8hzL+FWz+x6v/I4oOr+jNzVqh7rkCUF1XCOBT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:52:33.0155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4d81e9-6071-4635-e931-08df03c4b732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BDB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

On 8/18/26 6:22 PM, Borislav Petkov wrote:
> On Tue, Aug 04, 2026 at 06:56:03PM -0500, Kim Phillips wrote:
>
> Please fix all your subject prefixes: it should be "x86/bugs:"
>
> The tip tree preferred format for patch subject prefixes is
> 'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
> 'genirq/core:'. Please do not use file names or complete file paths as
> prefix. 'git log path/to/file' should give you a reasonable hint in most
> cases.
>
>> spectre_v2=eibrs currently enables retpolines when SNP is enabled,
>> instead of AutoIBRS (EIBRS) because the commit that disabled
>> AutoIBRS if SNP is enabled stopped short of enabling
>> X86_FEATURE_IBRS_ENHANCED.
>>
>> Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
>> decision to switch to retpolines in the default/"auto" case in
>> spectre_v2_select_mitigation().  This allows the existing
>> spectre_v2=eibrs logic to work as intended.
> So this whole hoopla is just to be able to select =eibrs in SNP guests, *and*,
> in doing so, cause a performance loss. I.e., shoot oneself in the foot.
>
> Or is there another, better reason which wants this?
It's not in guests, it's in the hypervisor, and in addition to making 
spectre_v2=eibrs work as advertised, it also fixes emitting the 
misleading "EIBRS selected but CPU doesn't have Enhanced or Automatic 
IBRS." on AutoIBRS-capable CPUs.

Shooting oneself in the foot is subjective depending on what performance 
users want and whether in userspace or not, esp. considering this series 
also enables spectre_v2=ibrs on SNP hosts.

>> Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
>> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Borislav Petkov (AMD) <bp@alien8.de>
>> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: stable@kernel.org
> Definitely not stable material. If at all.
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202603121136.bc8zNsHS-lkp@intel.com/
> It doesn't close that - that link points to something which is not upstream.
>
These get dropped in v5 - please switch to reviewing v5 now:

https://lore.kernel.org/lkml/20260826223510.3669875-1-kim.phillips@amd.com/

Thanks,

Kim
