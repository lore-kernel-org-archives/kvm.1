Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A384BA9E5
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601096; cv=fail; b=G7ZCjvBfMJL5kI5ZWEJeO2NUztupybhs7udzpGSWZ7UyrBimtqTHw7ljVdIROfbwKwp95xxTRYuKyU/NVlsc4InAjlftJcA9zljSJYeGLTDdK9faG2Uzg/1vHFr+ML871B2e2GBM/576nVbW7E4vY6+V2p2DIkGIHpDKV9dov7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601096; c=relaxed/simple;
	bh=F5EChaO25VM+VJAcslgmpSe4uFEjmdSTUCjn96uXRFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FK+vrLQWwY12lhRzPJ71i+rnDBWXfTaTHFQGD2dV1o72dSsMyAm9GiRJzOcinR09qhAPYhV9iYKX4fOZm50vRPU5rIVFYRUdNzze2NMg/ngobF2zIo/nEUeqqkUrvfsJXmbdyKobmv4Zi5l+OBe/zPk+0uaRPuRCTlStDdYmP1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CXOmFl7l; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CXOmFl7l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmezIfuJhd8hAzMbMgKaEGwk+83540NO18mj8On2bdTInmRZyrqfOxh80UFaRKiFVd3aulRmQhxctX0QOSRMTGcn9BTBJeNX3nJkEMVbQuAZZ8zrxOuwM7wZTRSQUcn6AKlXmOR2wyXekKs3ylw1iIScXDOzmeZ7JKgpjg1RW9xPFtVn7JyhBnUBwTx8WzrEz9v+oEKol9ELywjE/qG76x2EuDn+OPsWT7cvATi21nKk4yp2in6MIXXZ1fIr4k2203Rye1incJP2YCCyI4Ly2Ra0k3HXxv5XwiclW/KWeQsxihgMXndv/Bj+kJRsm4ojncMhIcNwu3Bze+djC6tlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V04BEqx6YO+eiO/RkYoPzdIY9BUbWLhCeZnXBve/HGU=;
 b=QC0qS5Nafb/1ZR24bDES9T8c2BWj4EMHN2vUN5SWX6+r7rhXUQ5J6KQmBECHcsAIpwB7evx6gS2gtYiG5hg8/1qX5EF9RJQqpjE0vLwqov3FXAJvSIw+3NQx11JjHyo1aglS/6LfnzUOPSAx7P+3bMQh2BF2hpo3lsawhuGXmE0yHWDYiJCDUlhKKW2CY2e09bNAcp72insmqOHfmgIsRdtNfJVYyb0W1/y+r1vstuN9zlJXkYC4eFBoZENjp/BZEuJ0umIQF4CyoQSEXNOEaeGKKFQr6/QmUbcgTht/7OEU99HJdTxDOcURRoKw7F4QlLmHvGLGj62OHPAM5RrHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V04BEqx6YO+eiO/RkYoPzdIY9BUbWLhCeZnXBve/HGU=;
 b=CXOmFl7lCynCt8blowwg2W6v0ptrnwSWl/P3kzSFy/S9qlRPxF9BKgBavCdjeXHAKgC0In/4eXjVmVo5RUCWEKvkyDLSm01L0AoONcCHxIb4tDsQglt3l3mREY73wcfLLLARFpz7Thfh7qqTNK/vEN+6dF2D75AG42b09xqc5QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 23:24:52 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 23:24:52 +0000
Message-ID: <5c8ec619-1911-46bc-aa70-c0970a2b2c52@amd.com>
Date: Wed, 16 Sep 2026 18:24:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 4/5] x86/sev: Perform RMP optimizations asynchronously
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1789594774.git.ashish.kalra@amd.com>
 <daa513fbe8f0672b00bc5e026e4399244be6dc72.1789594774.git.ashish.kalra@amd.com>
 <20260916222948.EA32C1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260916222948.EA32C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::24) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 076d2d62-98f2-46a6-d85e-08df1449b576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	K4bksS0smW3CNZfRD/HUhOdlYJmiuWs5RLbqoXOJ5R8MCA+1tboHVirlwAPu3r8IPnLZA4NYtp/EAnUks7QkE5D35Bv2e78lZ6s64+5WIb5hG6/3jUYAV9g2Sx6ppa4sN7h4xonI+rJ9KZ/5mV5uIiJTTZo0umShhdkT2o70lukR+S1C3M2iNKjjrmI8KvhvaqhRHG6sXk5XGjK9LCsZnNQOHU7J7TCmUJb+5ljqFPcDegFORvYxU4ApQaJVpFlWgI5/Pj2/wY5FJSXVb3+75e2SmNfpsDNjpKL5t46MVgW0dekt8LSY58ozMbxHW1G/4VPEVJUGicP7IXWNSmR8IvuBSfj1GWmlraZYaMal/nPDqLzqtRqrIWJp82GyjZ+5153mJtU5HqpqnWhs9ApGIZHSs8F8JzA04EUEk9g3Mu2s2wstg53Q/xIltcPCWACHaWeFWeUMXarjTfIjGe0OJN8IRKHW4SIVlex6HHDbiQUqJXa3Mm3ccy6Y2xOuoVQRLAzUCoDf3G3GqObME++OgL0gbqnJ5D63waiRKWh3W6V9x3R32M2mbAVGWx7v7iZcYu0iIVf7ecYAkvhdw1x16k9qCcA1dbpjKQbK+4X4j42moBMCwE6R/VFGwtgH900IQ0CxFden3EpkF4YXh8mincGiWUDUc1J3pB5WuNxWBK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(5023799004)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1ZxbTFiM0Z5cHdGOW9yRlFxV01rQjYxdnczUHNMMHpPWmwzUlFXSXZoK1V0?=
 =?utf-8?B?UHJlMHJLc0xDYm0ybmdSaC92Qng4bWxzRzAvU2RBbjBDVE9mVmlDWkdOd014?=
 =?utf-8?B?ME16bFJOWmJQd1NQNTArcnc4SDJVYWUwUkluU0RhNFFXSU9BcEFHc1pMRGl5?=
 =?utf-8?B?b21zclZUbFlPYW95M1NZQzJaeUlwREhyMmNvdmhrQWFqOFJ2OXdycmdWV2pD?=
 =?utf-8?B?YnN6ak1mVFVJN0tXa2huWXRRZWlpTU41WU5TblRYT1dkcXU3Z3lGU1RtZzhy?=
 =?utf-8?B?ZEFBWWZNcFlycVc1ZjhRS3R0VmFFR005cFlkWFYwenVtNnNVdU9XYUdDK0E3?=
 =?utf-8?B?dE9QREhpRjZSWFgrVm1WdjBWY3dScWVWV3pTL0RvMzVUZysyUVo3bElqWVhK?=
 =?utf-8?B?MGlWQS9CV2o3bEFkcGdwUGVxRkQrTk1iUkRkU2ZjRlhQUlFiSUR1RmJnNlVR?=
 =?utf-8?B?dUN3a3lSOGQxaTVadlh3S0JaazBSdW84QW1PRHA5M0FwRjRkK005SWdBOGhU?=
 =?utf-8?B?UkhibjZZMUs1REhLSWpGM3Jmc3VPbkhoOFlaYXQzdFhLYWo1L0JHUEhyMFY3?=
 =?utf-8?B?RFBZSE5IQ0tZamg2U29OeXg4NFplZ1k5MmV6OGVvQ05ibm1OZFFJRVRySXpF?=
 =?utf-8?B?RUpyczdOT0pHMEd4VEZEd3MrZjNnUnlGMnNvdkxveWh6WUlWaDJaNDdIYXMv?=
 =?utf-8?B?N3NzSldlMXpHVXFVZDZoU3dvVlhBRTZzc1MvK3ZDMXh4aHJ4WGhjUS9iektQ?=
 =?utf-8?B?Vml1N053Skt2YzlZOXBNU0g5QkhOQllmSGpJUXd3Y29DeVRSbGRpTnJpUXdC?=
 =?utf-8?B?c3JpOS9hU2RXa295UWxhYnVEZUc0ZWtIWWtzZU5xOTVYQlZ1ZnpOWERMS1ZJ?=
 =?utf-8?B?b0tFZko1ZG0xYkNEVTc3LzdpbkpROEtnY1VlQS9Ra0pTcjdvdWFUbXRkbklE?=
 =?utf-8?B?Z1JnMFNITFFWcVg2WEFnazBrSjRMZU5va3czVDhEYUk3bGl2RFVUT09ES2dF?=
 =?utf-8?B?WlFCQkt1KzRrUk1iZzlyUmlaNkN2YWZTTFN1ZU5WUmZ0YjBDT1RQdjJKNC9X?=
 =?utf-8?B?RDM1clA4VDFqbEV1dDZTd05ueGYzYlJoYkJ0M05BTHEydytWaGU5enAxdlVN?=
 =?utf-8?B?eGdFeU1Qcnp1aU9YK3dzRGEwaUtGQ1VWa1duTzRXOVY4VEFnL29nbUN1YjRL?=
 =?utf-8?B?a3R6UjlacFFubjFWcytWNWovY0hWZVRocExFSFhzbEI4aTNidnMraHFzM2ha?=
 =?utf-8?B?NHNiaEMwcVNveThzWjFFNENLTlZpZzBHQlZGdTVyb0RTNEF0aC9QZDZOMm5p?=
 =?utf-8?B?d2pucDdFM1JRdldRaHJXdklKS0EwVmxZbURrVGtYN0tScVdzbzZzUkZrQ0NN?=
 =?utf-8?B?SGgwV3JrYmd2TWdvV21qUzJrOVE4TFpiYUNDSGthdlppV3M1UENQN0d5VE42?=
 =?utf-8?B?amhlUVNVRnFadkZNSTlkcGNURUUyNHQvVzhMQWh0dUNFNU9ycVZVMkFEMHhG?=
 =?utf-8?B?b3pYMUZUR3JYWlB5U1ptNDBIODRlUC9OV2I2UG8wOVNvN2VCM05DSVJzVDgw?=
 =?utf-8?B?ZkR5bW9iRXV4Mmp0Y2JKSDZtbVM0cWplNWtlVEVOYVAwYXZGeWxvcWVucldi?=
 =?utf-8?B?T1hRQ0k5K2orR2UxQ21TSHFJUUtWWXVXOHdMZ1FIZFEzRmRyYVVFWWpzRzA0?=
 =?utf-8?B?b3RkWC9rT29iVUtmdmhPZS8wU3hDK0w2UlJtNVlwUEorcHEyTkRTbWxRTEFR?=
 =?utf-8?B?cnRneXBieG1IMDRXTVVTdXV4OGxWbFpvUlRGcXNKU3dkT2NBRVhjUWhDSFRP?=
 =?utf-8?B?TFZLMHJoaFB4Z3FmaXNhd2ZXWk9MNXJhT2pCcFlRcTY1K0VvTlBMeENyaUc2?=
 =?utf-8?B?TnA3enFSUXIvaFJQc3hQY1ZQQldQUWttc0NBMmRQclBLL2ZyNXkyM2RDSGd2?=
 =?utf-8?B?dDNZd2hCNzZqRGpGWmFIU2lRUHVMSDQvMG5iaFd3MnkvNlNCS1o3cU54MGty?=
 =?utf-8?B?dm85ajZnOUxFR3V6VE1OZnFxYjZjUHphazZ4RzVwNnlGZUZpNTI1aTZjcmZa?=
 =?utf-8?B?WVhLSTl3amZGNFdzSFNQamxpTjU4Y2VsUmVUSy9RQ3Q2VmZLUWM2Q1A3WC8w?=
 =?utf-8?B?cjA2NGlHd2VHNVZMZHJwN3U4MnN1UHpHb1E0M0thcVNkNWsrMm1ObE12ZHgy?=
 =?utf-8?B?dG9qQU9lQmpvbVQyVUdmUkltcCsrYm5NMGcybVlIdlQ0VDArcGVMVXVnb29r?=
 =?utf-8?B?YkhrZVhYa2lmU0l0VUlWQ011OHJ3NTFaaVlvejZQQkY4QlVPNmFXRXFKQmYv?=
 =?utf-8?Q?QDUkp1OGWkB47fpz1A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076d2d62-98f2-46a6-d85e-08df1449b576
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 23:24:52.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw1S7W6C+WN63RiBvKcWILQGXdNAEoEpTxFAaTkIojteIZxTZz5wDgXMNF/UciGTyHsyxhEfehNgvt878tiy8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820


On 9/16/2026 5:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] x86/sev: fatal #GP on blind RMPOPT scan across MMIO holes
> - [High] x86/sev: soft lockup via IRQ-disabled IPI for cold RMPOPT cache
> - [High] x86/sev: fatal #UD race between RMPOPT and firmware SNP shutdown
> --
> 
> commit 62479bc981175bad2d66a2cbd0e76b01cb89e84b
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Perform RMP optimizations asynchronously
> 
> This patch adds support for performing RMP optimizations asynchronously using
> a dedicated per-CPU workqueue. It scans physical memory up to 2TB and
> executes RMPOPT to skip RMP checks for 1GB regions that do not contain SNP
> guest memory.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 25cb486ff61b6..bd97135cacc22 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> [ ... ]
>> @@ -557,6 +576,12 @@ int snp_prepare(void)
>>  }
>>  EXPORT_SYMBOL_FOR_MODULES(snp_prepare, "ccp");
>>  
>> +static void rmpopt_disable(void)
>> +{
>> +	if (rmpopt_wq)
>> +		cancel_delayed_work_sync(&rmpopt_delayed_work);
>> +}
>> +
>>  void snp_shutdown(void)
>>  {
>>  	u64 syscfg;
>> @@ -565,6 +590,8 @@ void snp_shutdown(void)
>>  	if (syscfg & MSR_AMD64_SYSCFG_SNP_EN)
>>  		return;
>>  
>> +	rmpopt_disable();
> 
> [Severity: High]
> Is it safe to cancel the worker here?
> 
> When SNP is disabled, the CCP driver sends SEV_CMD_SNP_SHUTDOWN_EX to the
> firmware, which clears the SnpEn hardware state. The driver then calls
> snp_shutdown(), which calls cancel_delayed_work_sync() here.
> 
> Between the firmware clearing SnpEn and the work being cancelled, the
> background worker or an IPI can concurrently execute the RMPOPT instruction.
> 
> Executing RMPOPT while SnpEn is clear causes a #UD exception, leading to a
> kernel panic.
> 

snp_shutdown() runs only at full host SNP teardown (reboot, kexec, ccp removal), which is supported only after all SNP guests are torn down. RMP re‑optimization is a per‑guest‑teardown event, so in a supported configuration the two don't overlap: by the time the host disables SNP, guest teardown is complete and rmpopt_disable() drains any pending pass. We don't support disabling SNP underneath an in‑flight guest teardown. 

>> +
>>  	clear_rmp();
>>  	on_each_cpu(mfd_reconfigure, NULL, 1);
>>  
> [ ... ]
>> @@ -580,8 +607,69 @@ EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>>  static bool rmpopt_capable(void)
>>  {
>>  	return cpu_feature_enabled(X86_FEATURE_RMPOPT) &&
>> -	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>> +	       cc_platform_has(CC_ATTR_HOST_SEV_SNP) && rmpopt_enabled;
>> +}
>> +
>> +/*
>> + * RMPOPT optimizations skip RMP checks at 1GB granularity if this range of
>> + * memory does not contain any SNP guest memory.
>> + *
>> + * @pa is a system physical address; RMPOPT operates on the containing 1GB.
>> + */
>> +static void rmpopt(u64 pa)
>> +{
>> +	enum rmpopt_op_type op = RMPOPT_OP_VERIFY_AND_REPORT_STATUS;
>> +	u64 pa_start = ALIGN_DOWN(pa, SZ_1G);
>> +
>> +	/* Supported by binutils 2.48+ */
>> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
>> +		     :: "a" (pa_start), "c" (op)
>> +		     : "memory", "cc");
>> +}
>> +
>> +static void rmpopt_scan_range(void *arg)
>> +{
>> +	u64 pa;
>> +
>> +	for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G)
>> +		rmpopt(pa);
> 
> [Severity: High]
> Does this iteration skip non-system RAM such as the PCI MMIO hole (e.g.,
> 3GB-4GB)?
> 
> This iterates over the entire physical address range from min_low_pfn to
> max_pfn in 1GB steps. Executing the RMPOPT instruction on addresses not
> backed by valid system memory causes a #GP.
> 
> Since the rmpopt() inline assembly lacks an exception handler, will this
> result in a fatal kernel panic when executing on MMIO holes?
>

RMPOPT does not fault on physical addresses not backed by system RAM. It inspects the RMP entries for the 1 GB region — which reside in the RMP table (itself RAM), not the target memory — so an MMIO hole is never accessed. The RMP covers the entire physical range up to the top of RAM, so holes below that top (e.g. the 3–4 GB PCI hole on systems with RAM above 4 GB) have default hypervisor‑owned RMP entries and RMPOPT reports them optimizable; there is no #GP/#MC/OOB for non‑RAM regions in the scanned range. Confirmed on hardware: the test host has RAM above 4 GB (hence a 3–4 GB hole inside the 0..2 TB scan) and the full pass completes with guests booting normally.
 
>> +}
>> +
>> +static void do_rmpopt_work(struct work_struct *work)
>> +{
>> +	/*
>> +	 * Warm up the RMPOPT cache on this pinned per-CPU worker with interrupts
>> +	 * enabled, so the IRQ-disabled fan-out below only issues cache-hit RMPOPTs.
>> +	 */
>> +	rmpopt_scan_range(NULL);
>> +
>> +	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
> 
> [Severity: High]
> Could this IPI cause severe scheduling latency or potential soft lockups?
> 
> do_rmpopt_work() calls rmpopt_scan_range() locally to warm up the RMPOPT
> cache, then uses on_each_cpu_mask() to run it on all other CPUs via IPI.
> 
> Since the RMPOPT table is per-CPU, local warmup on the worker CPU does not
> affect remote CPUs. The IPI forces all other CPUs to execute the scan with a
> cold cache.
> 
> Executing up to 2048 cache-miss hardware instructions inside an IRQ-disabled
> IPI handler seems likely to cause severe latency issues.

The RMPOPT optimization state is a shared in‑memory table (all cores program RMPOPT_BASE to the same address), not a per‑CPU cache. The warm‑up scan on the worker populates it, so the IRQ‑disabled fan‑out issues only cache‑hit RMPOPTs. Measured worst‑case follower callback is 1.34 ms — well under the soft‑lockup/NMI‑watchdog thresholds. 

Thanks,
Ashish

> 
>> +}
> 
