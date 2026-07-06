Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1A3DFC61
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324834; cv=fail; b=SEwfg2XQB20ZwDIDTqLzAZxdhq8AMt3PqynPSt69OA+V8gXv5XCGVDh6mXiGcPhKq36ptvTJCcD0h+iUhto2sHSrb0PyGzDa4LQdDoBVnYLST3KTqap5F0lG3da16REpTdYVhVZAmpwULxMrILoVdQEsadzkFESZxECM0+hDCrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324834; c=relaxed/simple;
	bh=2QAjf5y0ZsWKP4PmLFdAQsv6bOzeGA7GM3ZxaEiZ4+U=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SARPh+NAAKCmhDPpCq47UtfPIjJuN++wmAdJbSvqg4frzMqu1TnS8TvX0XiYfLphSwu7LeeiMMiR3xr+tEfQaP3dSDjSKxSk5UTE5pjLkFyJPaN9UbLJNR3HM2i0NgyUacohBpXEhdg1Wfec7HCSKro2o8KXu/M3+vzDX9F6P/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OsStJBKn; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OsStJBKn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjMXWQoeQYDzzR3H+yVcdoUHCnYTzO62fFwTBvhmHNZ3RlDa38qRstNpB6rd4dbxxmf+ceZb47/Tc53ZGUylwSnUdZ5ADyjrMovEfQFtfhsazmHb1AvuS1i4W8W/3tDOyxHWscH+zC8EDY5yoQXv1NOgBpWjGplh5nGqNy05/h6lq3CoxcQMIFL5f9Zj6E3j5H7HWkBV3CFzk7tZj9Egr3e8efoCXdCZmJ4FbodGzmWbbiiQDgQ3zvjuKby/M7CeX7PqISxpRYu4upxhvinGZqAqHpKQv8S8Iy1Wa59t6XpkX+P9fB0xaq0NIxUIkUmghtDs+HFPCAwI8DQrJRDeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvihzFsU6O0hNkZFyMg01KYL74kZouLiqxicoIhRco0=;
 b=B9pX/Nnm5wkkKCipYm8ny8Ki1q8GZVwZQrWA3eW7XpwiCcenZqR+PEnn6LjWUEBw0t3ZGOS9da+ZrOUYs0Os2e+6tM+jbwG+1s1T9vWIEw4y4lkn7h53e7VDL5V3JwTP+xgnffyVEo6iM1NlBNxu8VZUgAWg4yhulN++tpTm0SHfOf/+lEK3OF0AE2ANDQ1RluBxkirDYp2buWlgxhzhPmdn5A0SPrYwUzqNxzVdxucx0GoZ/tWVj+bGQGeZLkvZC7COZYh2X7YIdmgikVShvNr+roJo1okV0sglYMjJGFL8k0q8DFs+ExY1gciyIcJsxnHoNspKD7smIG6j5/j9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvihzFsU6O0hNkZFyMg01KYL74kZouLiqxicoIhRco0=;
 b=OsStJBKnfTeOUeB4Wce52/IgSJvVDTaLquzKf4S4hD00xCh+6NdPi8LmhckzihJAywYwjbGzjNkLlhFhsBVrjFXQaVAXKTHNM9mPBNYCVp66rBwKnAFEJGMtTne01IQxpxbeq3A/rKBxgbybSDLDh811tvl1qeDVhQ5fRKzSzN0=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:00:20 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::74) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 08:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:00:20 +0000
Received: from [172.31.37.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 03:00:11 -0500
Message-ID: <84113ba5-ddb8-47aa-abe0-c6968feb3fea@amd.com>
Date: Mon, 6 Jul 2026 13:30:08 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260706063035.1139-1-sarunkod@amd.com>
 <20260706063035.1139-2-sarunkod@amd.com>
 <20260706065212.CCD741F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260706065212.CCD741F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 577123a1-1a9f-4110-b04c-08dedb34a064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|18002099003|3023799007|13003099007|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	TSqL25JiPtqJY+L+Ow9wOQJ5IiDesE7Bl2owuCuQqKhe2AwLBX9Ltk0IWoigKIRHO68imVtJZAwrirTxhBX+8dfbEx+yNh8SoCO0ZMCgdcEzq8odJxKQFR55J15snMZHJ2NAV+O5Z3qQq6RCgYn00IxgCKHSsrPQXCj/Babgph85OuILGv3uyv5InJKBVkRr8TOS8ovwausvU3Dc++2rkkv1vjpgLq7QHk/2yQpwmP+zlSFfOKW48SxNvA5HiFY2yoNMoKt9WZO0Wu35TXSyQsKdlFrn3ktyzanaPQdqWxpfC4niW65xsIt1ovoodr2/aIzvwBqj9yfyv4hPgAy5gpcG7oChK1N4K4UfKn7Q48oPf0uR+JKplBJINQUwxffFor/e/23v5kHzOLV4cBQYNi0j5a+HC9p0tlU9qaJOIEzkl8H7XbMSD8ssxlTTUuMzuXY2EyeBV5DJqHSiKiU7Jg6ZraFBGOllKsuNRKbaBBP5Ro5oKANdbAVexSbpPLOPXJZnJCqs2YzQabAznERaeHPHEt/ygXvEJX2GddgRoGL8J8Z9s/tis1940yPlzjZ4EyLjs3PtQdXvuf5mueDIzU3sEaf3VG8J0odCBBp77Ws2PRofdPGSWZMuicLwJM5P8YQCN812ze0YQz8xV+zocg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(13003099007)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	narb/dwar8y4wRlCIVlSC/J1WKUbUo22WHS8Il3JNGZXK7g8tHqopPUEMckp9+/tspWej0BHUOOuq+T55fwfxFqT6GgUh7SAMpQLB/93VZANFjJ85rsWYvQv6iWKEkCVC4dqwSrLdejO2af0YksQFdfvHWeMdNoyyHc66VjIGG/Hbo4goMiP7zobfqlXLbbX6jvL7SINAq7QCWGgNzthMxWZ7qzKmFtfiD5so6WqlGE9QbhYgC2aTqCtjXcbYBqMef8TyuXB/fSAISLKM5KZWsqge1FYmUBSEQ2189fdgz8qWnDB1MC+iax2aCS1qcfPSGR3D+X49qXB5mxc+aiAfLE+NeCigtbo2Ddp1LJDJcQ8+BIEvGVmRVmO3jSj8dawn0NEdg3LCxlp98LQuSWJHtgcA2U4+rnV06jgQVTsFx3BmXBHZKskJA+GNb99Pl15
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:00:20.7653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577123a1-1a9f-4110-b04c-08dedb34a064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926



On 7/6/2026 12:22 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The 32-bit stub for `__try_cmpxchg128_user_asm` incorrectly evaluates to 1 (success) instead of 0 (failure), silently skipping emulation while falsely signaling a successful memory update.
> --
>
> commit 11b4c82317b376374b32df0435151f876d6239e5
> Author: Sairaj Kodilkar <sarunkod@amd.com>
>
> x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
>
> This commit extends the user CMPXCHG helpers to support 16-byte operands
> on x86-64 using the cmpxchg16b instruction. It also adds a 32-bit stub
> that is intended to always return failure since cmpxchg16b requires
> 64-bit GPRs.
>
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>> index 367297b188c39..123755d471099 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
> [ ... ]
>
>> @@ -551,11 +594,18 @@ do {                                                                            \
>>
>>   extern void __try_cmpxchg_user_wrong_size(void);
>>
>> -#ifndef CONFIG_X86_32
>> +#ifdef CONFIG_X86_32
>> +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmpxchg16b
>> + * instruction).
>> + */
>> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
> [Severity: Medium]
> Does this 32-bit stub correctly signal failure?
>
> Since this macro evaluates to 1, won't the surrounding unsafe_try_cmpxchg_user
> macro treat this as success (true) rather than failure (false)?
>
> This could cause the wrapper to negate the value and return 0 (success) to the
> caller, falsely signaling a successful memory exchange without actually
> updating memory or the old value. Even though there are no current 32-bit
> callers using a 16-byte operand, should this evaluate to 0 instead of 1 to
> ensure theoretical future callers don't encounter a silent atomicity break?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706063035.1139-1-sarunkod@amd.com?part=1
Hi,

Right, It should return 0 instead of 1, will rectify this in the next patch.

Thanks
Sairaj



