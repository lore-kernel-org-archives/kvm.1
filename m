Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAC3DAABF
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186136; cv=fail; b=VdjgvC5mp8Mc1eJnSoPZbrBUEGFTpqx9z8IKxxxjl2+xIGICxEPwVszibcrB0Vl2KTePbOemi8ZHwkGOCjT8PZQYz45gh35ej4nkrtpHTWn8PbQ/y6AUNVzOtpl+IcWo8426wp01bL1rQJC597cUJO3PJ5OXdf6zvITIh+TjPCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186136; c=relaxed/simple;
	bh=Yzi9sf6wa6ohqZpbJq5wCYzNlIoTT6/2Q2BnfIMFCzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oaQRkX1Kd1s7NMDBoquTLEIenBhLpztZ/tMh2syQLKoD6DttcXVEfgl7MfCge7H6e4qNJmvBvOaN4WxthyueQ3OQNSX8dJQjWPnxO2iM3rQWwRACUJBqw8ZaudqEetj8MTPRnq9kG6PQUYf3CgGazUwzTI8mmheJzjupVaPirrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ihvHDFkG; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ihvHDFkG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQel8WH6mp1eqUAu54WV7xa12g5deemDMR0f02ASYHYpfWRzIYl0tufBmVoRivdfWa6CtfbFgTGojU111bg6BMZfcvLcGh/HuKF2+LscYQWhiPJBVO6c5yFZsyQ+J5xdRPXT2s/IFdxjA2NNYdLwd2OnfQyOlGn0WieKztNVZ6ev/BzL14hNNaGK5hBBZBbWP5IVL77BROHu7NSYZecSwnjgoVQ148V/a9xfkEhbmo8gT78ejs91W8vNlGfbwWdApfr4p4DFa+16DCmAHBCwMYBJpyUagqIlO3h7+F2oEGE0OB0L5bsadrxhUm40udcMtg3wJg9zavDG8Nnx6V8jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJvGWkiayKKQOs331Bu4jPhhiuZC1w+Pt5ITX7vvpVo=;
 b=jrdFhQ8ivtOWiutiVv6cbEZ+UbIhfJg7vX3/YYFxo3+6dnVfpW7VZ0hV69tiZZjK4n0ILTDthonLHPToYoi+3ztcWpLtFRKpf3RSACVnGwnmlKvb5Kaz2oy5BZ5mlLLxMEQ5ll+zHW4Mp9msm22gSp5X3kc+b/X33dRO2SOB6zmuoNgHp8dPXdEBoyhxXIqZvKh8BK3Ccg4zjJWzMCac9XCbwfDWEoc0ALK4mLwICTlOv0Th/p5DQxKpnioIPncNBUcVqpw4QRHzMMXN5t/87NXdjnKo+ju1fZzQMnmtt+UNyZ+9jNrgqkFtmp+zAjWGMkrCzLo5In/fLDx6Ed2TIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJvGWkiayKKQOs331Bu4jPhhiuZC1w+Pt5ITX7vvpVo=;
 b=ihvHDFkGoQWxN8zCK1JtmBLuKEvDf+AYnZTLu0YATfMOaYT2M7/sWjw+24ezCojbSUDA+5zxNaCuo0qYcG03YON5Dj/KnE8JjRbqGrRwtsbWXlOchkDxpMV2/ZT82s4MOzM2ldXc/Y8IloT55MeiopmElJJCwLaDhd+3mxPh5p8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CY3PR12MB9653.namprd12.prod.outlook.com (2603:10b6:930:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:02:07 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 21:02:07 +0000
Message-ID: <901413fb-fab2-4611-b948-da485778f6b0@amd.com>
Date: Mon, 27 Jul 2026 16:02:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/6] x86/sev: Initialize RMPOPT configuration MSRs
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1784844080.git.ashish.kalra@amd.com>
 <ff346ea1770cf996e1623270a085ac08d21888c6.1784844080.git.ashish.kalra@amd.com>
 <20260727192230.9ADC91F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260727192230.9ADC91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:610:50::11) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CY3PR12MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fb78b8-4005-4a27-ce7a-08deec225156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	bK9O9sr2x4E5UpEyER3TychCoLs9h4WELK5wJfayPqsxNI5FOphnpz+9s60mwDjII+PwjWvyertMw0JNqqq1bgmuCjbgG+qg3UiLYCdfNy3XqssfnOxsLQG6xZ+xzm2pWbQep4p3xVyeL2PH6EplG4TyEwxzt2cvZQojvyIODhDBO5yz9znwwDWsACTV3GtMqQ6FvAtHOY9fP+RkkkhA/8AwLSooMASNLLUcBr7KyUXdZtLCjJOLCG/5QoyfIpKpsCYApJkNqMMQ9a654lvNQuPPBk9PZOcpxJ0JT2ZbARvxmvd05dUA3pXawbStvLQ9sLNbO7kNVEWowh1K2gU6aFeDWF1YaDC1wRWxZE4SF/CqdYMgm3KXlX+5B0Z473DpQDjAzB8eCnE36XmIfos0dCH3t+ZNhIgAsTBFbBSqYZ8V7igcduP8b9of4CunULK/UwKEuXCwcsQaSTfry604+aWWL7MuilixOL4nqZvsmidmBbzGYO06ZZHRIILm0SGzKjsHnKZlzbUSVPWv519NA6EWPS5iIpO9MdG4BIPm8OsHGHK0qoRQTxB5F7KnHM86qGUycrkca+NsmcFhrPv6jXViPvkjD1AgmwO6pSx9awBorVyutRYn3oRoGwdaasMqMtsZmdegqF8w+LUjabmDMszyEKz0bSUjVGLHjs9OEcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXFnR2oweWdZeW9pMFpYRnRROERBdmhRQTR5aWFPL2RxbUxydEllK1ZGWTl0?=
 =?utf-8?B?c29IU0FXQXdTNlRVOXR4cHlYWVFJalRCVG9wRlJkOWRtN3Z6ZStnRGlsS3lr?=
 =?utf-8?B?dW1ZRGx6RWhDMytrdUFJVjc5dkpQdUw4U3kva3pIQ09Ea3NHZFMrdncrYXFr?=
 =?utf-8?B?c0N0ZjZyampaWGpSNzA3eVBwS3BrNUpJQml6OUltR1hzNExBWVJEbENGTjYv?=
 =?utf-8?B?emZWK0ROQnhaUXRPSkZkQ0V3UVNaUGU1SkZETC9JS1VCNHlFQndYWGxXT2to?=
 =?utf-8?B?K2pVS1UxSDBGNUJ3amdBVU8vYW4waDRRWDRRWFBRREV2eXppdnVXd0pJeUc4?=
 =?utf-8?B?cktCeEY2VlQ1UCsrNnFnQU12MzhXY3hTWHBhd1hpcHg0SVdudVA1NkltN3U2?=
 =?utf-8?B?NkFUWjhlWlhKS2g3VVM5dTVVRVRhSkQzRnBnM1hIVXBkMVFhd1V5aTd2c0d3?=
 =?utf-8?B?QzByckhrU2JJcTFaSVg5UUtUd0FnK0JYWXo5U21lN212U0dpVHF2OWVtQXJ6?=
 =?utf-8?B?RFB0M29Gc1NDbEF2VkxidVJFVk5qVE5tbml1S29JYnhqZXJlanNGU1picnBu?=
 =?utf-8?B?dlJGRzRQN2VONzhJMDZqRU90TWNLQlovdXlqNW5qYm1WSy82SEUxV0YwM0dt?=
 =?utf-8?B?MUNJQnE0bU9UWFl2TnEvc3F6c1ZENWtRYjNiMmdWS09iL05GakYwV2FiYldO?=
 =?utf-8?B?RTJMQ1Z0SEtoN2tiTEN3UUtTOE9KdisxWURESWtPSzVBTmtwVWV2QU5CbWR0?=
 =?utf-8?B?dGh5RTllckVJd21aWjk0SnQrWlJZWDYwQ2o2ZzIyY01NR3V2OXJtem5JejhP?=
 =?utf-8?B?M1VlNytXWnkrOGUwdm9ONEFJQW4rMG9hNTVsYWd1N3ZuN0VRaHViajB6SnlN?=
 =?utf-8?B?VFhuczJBSTVPNGk2ZGVNOEdjSGg1K3FINUFocFVKN0pkbVkzKzZBUVRTTVpS?=
 =?utf-8?B?cmNLb3BuejBxNzU2clU0UythRFVFUnU1RXJhSnJIYm9Qa0ZyeFB6ZG0zM3RJ?=
 =?utf-8?B?K3NuUkZ1NzZMVVNnbmVIQitYNGFwQWNNQmtvMU5UZlBIU3ZlNXlRMmFOOHI4?=
 =?utf-8?B?NUtmVVZLY0RHUzJNMElmYWI2N2RUU0VSWFE0cVhDY05zc2tkcUNzejd3a0JB?=
 =?utf-8?B?UStEckRCclpQa01iSVYxbHluU3lZTDcyOUtQcWVBdlN2WS9uZXQvRldlaUhy?=
 =?utf-8?B?Ym5CN0YxTDlXMTdPOXJkdzZZbC9aZ2k2S01EVm5Ub0ZsVzIvZmptRFpQVmNP?=
 =?utf-8?B?cmtyNjN4cS9zVjcwWVlDSFdlaTdUUHQ4L1dVWm5yR3F0L3ZHOFRiSWpBcU5G?=
 =?utf-8?B?ZnUrRGpVcmE3SmV6WEUwM1J2SzV5cUh1bE1MekNTWWVma0J4YkJuNGV2aDli?=
 =?utf-8?B?V2lPMDF3YUQ1VlpvV1NkQjhBeG9QM205bFFqWTFuaktvQ0NxeXhsRENOVVR4?=
 =?utf-8?B?MUl1L1JXZ2dEdnhtZmRkZjVJcis0LzJ2aTJLQUhWS3M0allldjBXdHBEMm5N?=
 =?utf-8?B?MktON2tkc01Eb1VualptR2dUR3Z4ekRyazZWVUsrR1U0TEJvazRCV2lGMmJl?=
 =?utf-8?B?ekNoTWljSVZsQW1KWnh6ZmdPNVJLSjRWQ3ZodTJOY0dxdjU5L3lkemZYTm1h?=
 =?utf-8?B?aERLZHV0TmtRbHhwQ3FXR0Qwbmtpdy9Wbng5d0VmUHFjVVRLVEhRaGlZQlN5?=
 =?utf-8?B?OEJxajVwbFI4cEdsMGYzdlpzSGg4cERaTzZESkNWV0tqemdWTVNXbGp3MUpm?=
 =?utf-8?B?YkdyNE5reTFGSWNZMHFBenAvbkZBZ08xREJvdTRzOEc3MUVXa0tObkU3ZTd5?=
 =?utf-8?B?Y3Q0VjBIdkczQmZGUi9yVWQ1V09ha3dKUitoOFBBanprVmRTQzFTOUtncSts?=
 =?utf-8?B?ZHBvSXdhNEtpU1lLbjUybFRHMzlVcnhKUGFGYXl6bmlJcm1DOWdYN0pQQWo0?=
 =?utf-8?B?eWNuOVVLVy9SMThRMW8vemJXTnAzd2JZM2VOekZVdFN4M2hPcDk4TmpOaVdU?=
 =?utf-8?B?dXZQNkJySmE3dG1CS29ZRUIwT0V5UGpWSWdTd1BEbnFlWUpwN3lKMFZubjlp?=
 =?utf-8?B?K0IrQjJGWGVKNlU1eVNPUWRIT3ZvK3JrbG14ZlorTEgrMEJsZ09tRVVmQXJl?=
 =?utf-8?B?VTVlRHc4NTg1ZFhaMUNCZklFd1dZSFRWaTI5RkpReEtabE5KOVJEdHNBdmdy?=
 =?utf-8?B?eHlrYkdEdlpzTDQydTBLcXovM0JlSmZsYVk5ZGY1U1NNSkFCS0cvdTlISDFK?=
 =?utf-8?B?Y1hXR0pzaTBBVjB2cGNTZnRUTHcvV0VyamRjNnJpSjFTVy9FeHA3dFpGZ1dk?=
 =?utf-8?Q?z/jQfOoBUUfH/IlVRn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fb78b8-4005-4a27-ce7a-08deec225156
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:02:07.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A9soziouN8OOt6SKo2CbMwqQZ6VVgUlpbIBIyk47yV9c9QdblAaRb09lefv+TLapSsVeHsH/I/JTBZYbrvk0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9653



On 7/27/2026 2:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] `snp_cleanup_rmpopt()` unconditionally dereferences `rmpopt_cpumask`, causing a deterministic kernel panic on shutdown if the mask was never allocated (e.g., on CPUs without RMPOPT support or if allocation fails).
> - [High] If SEV-SNP firmware initialization fails, the error path returns directly without cleaning up the state set by `snp_prepare()`, leaving CPU hotplug permanently disabled.
> - [Medium] Re-initializing SEV-SNP after a legacy shutdown leaks the `rmpopt_cpumask` allocation because the old pointer is overwritten without being freed.
> --
> 
> --- Patch [3]: [PATCH v11 3/6] x86/sev: Initialize RMPOPT configuration MSRs ---
> commit e4623d49ab6201adc5b609f5a6043ed6dfb7f55c
> Author: Ashish Kalra <ashish.kalra@amd.com>
> Subject: x86/sev: Initialize RMPOPT configuration MSRs
> 
> The new RMPOPT instruction helps manage per-CPU RMP optimization
> structures inside the CPU. This commit initializes the per-CPU RMPOPT
> table base to enable RMP optimization for up to 2 TB of system RAM.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index e2f69fba09389..8bfd802848361 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> [ ... ]
>> @@ -558,6 +561,17 @@ int snp_prepare(void)
>>  }
>>  EXPORT_SYMBOL_FOR_MODULES(snp_prepare, "ccp");
>>  
>> +static void snp_cleanup_rmpopt(void)
>> +{
>> +	int cpu;
>> +
>> +	for_each_cpu(cpu, rmpopt_cpumask)
> 
> [Severity: High]
> If rmpopt_cpumask was never allocated, does this macro dereference a NULL
> pointer?
> 
> In snp_setup_rmpopt(), if rmpopt_capable() is false, the mask remains
> unallocated. When snp_shutdown() subsequently calls snp_cleanup_rmpopt(),
> it iterates over the mask without checking if it is available.
> 
> Can this cause a kernel panic on system shutdown or module unload for
> systems without RMPOPT support?

Can't happen in the full series: patch 4 adds if (!rmpopt_wq) return;, and rmpopt_wq is non-NULL only after snp_setup_rmpopt() succeeds.
On a host without RMPOPT it stays NULL, so rmpopt_cpumask is never dereferenced.

> 
>> +		wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, 0);
>> +
>> +	free_cpumask_var(rmpopt_cpumask);
>> +	rmpopt_pa_start = 0;
>> +}
> [ ... ]
>> @@ -578,6 +593,46 @@ void snp_shutdown(void)
>>  }
>>  EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>>  
>> +static bool rmpopt_capable(void)
>> +{
>> +	return cpu_feature_enabled(X86_FEATURE_RMPOPT) &&
>> +	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>> +}
>> +
>> +void snp_setup_rmpopt(void)
>> +{
>> +	u64 rmpopt_base;
>> +	int cpu;
>> +
>> +	if (!rmpopt_capable())
>> +		return;
>> +
>> +	if (!zalloc_cpumask_var(&rmpopt_cpumask, GFP_KERNEL)) {
> 
> [Severity: Medium]
> Does this unconditional allocation leak the previously allocated cpumask
> when SEV-SNP is re-initialized?
> 
> During a legacy shutdown, snp_shutdown() returns early when the SnpEn
> firmware bit is still set, skipping snp_cleanup_rmpopt():
> 
> arch/x86/virt/svm/sev.c:snp_shutdown() {
> ...
> 	rdmsrq(MSR_AMD64_SYSCFG, syscfg);
> 	if (syscfg & MSR_AMD64_SYSCFG_SNP_EN)
> 		return;
> ...
> }
> 
> A subsequent call to __sev_snp_init_locked() will invoke snp_setup_rmpopt()
> again and overwrite the old pointer without freeing it.

Handled in the full series: patch 4's re-init guard (if (rmpopt_wq) { queue_delayed_work(...); return; }) re-queues the pass instead of re-allocating,
so there's no leak.

> 
>> +		pr_err("Failed to allocate RMPOPT cpumask\n");
>> +		return;
>> +	}
> [ ... ]
>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>> index f833cb7e4da36..0b40d23a26b45 100644
>> --- a/drivers/crypto/ccp/sev-dev.c
>> +++ b/drivers/crypto/ccp/sev-dev.c
>> @@ -1630,6 +1630,9 @@ static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
>>  	}
>>  
>>  	snp_hv_fixed_pages_state_update(sev, HV_FIXED);
>> +
>> +	snp_setup_rmpopt();
>> +
> 
> [Severity: High]
> If the SEV-SNP firmware initialization fails, does this leave CPU hotplug
> permanently disabled?
> 
> A global cpu_hotplug_disable() call is made inside snp_prepare() right before
> we reach this code. If the subsequent firmware command fails in
> __sev_snp_init_locked(), it returns the error directly without cleaning up:
> 
> drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked() {
> ...
> 	rc = __sev_do_cmd_locked(cmd, arg, error);
> 	if (rc) {
> 		dev_err(sev->dev, "SEV-SNP: %s failed rc %d, error %#x\n",
> 			cmd == SEV_CMD_SNP_INIT_EX ? "SNP_INIT_EX" : "SNP_INIT",
> 			rc, *error);
> 		return rc;
> 	}
> ...
> }
> 
> Since sev->snp_initialized remains false on this error path, snp_shutdown()
> is never executed on teardown, meaning cpu_hotplug_enable() is never invoked
> to release the lock.

Intentional. snp_prepare() re-enables hotplug on its own failure (before SnpEn is set); once SnpEn is set, hotplug must stay disabled — 
a CPU coming online without it would break RMP-check consistency and any SNP_INIT retry (which needs SnpEn on all present CPUs). 
Documented in the commit message, and the triggering failure is already logged.

Thanks,
Ashish

> 
>>  	sev->snp_initialized = true;
>>  	dev_dbg(sev->dev, "SEV-SNP firmware initialized, SEV-TIO is %s\n",
>>  		data.tio_en ? "enabled" : "disabled");
> 
