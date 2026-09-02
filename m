Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD04AFE0F
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788389130; cv=fail; b=uCWTeuj210fR6kh8sup0lgEOEYXuvNK5ZLqzA7yev5EPhGPvsAzOVxmb3yOUoKBM9oq7E2lwLSWeBmmxJA8Hplru1x1WWlCOvGL4czmDwd+ugFYl0usrerZ/4tzPcjsrWzi3gLUjSta8u+9F1KlTUvkySfBXR2dx9aOEUmZpcsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788389130; c=relaxed/simple;
	bh=V1h7x9o4BSDHE5iso+JrZN0RV5tstXxVDBneCLgn/EQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PEOVu2ZNFTiNrI/gVNW8qQYMwN2Bo9FIy4c7VMSFuyPu1GAJrTF1l9QnfpMAOZuE0cvP6y+0gLIlpvnITawQ4t7KY33XAM7KtTetcf6W5iNvyu71Cd0p10TXlRxk8PVoz9vL6iXfDo5VYPX/6kPVkkselzIxohGoQuDpqYh6jhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nhdks4xv; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nhdks4xv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/zcSW+upyBqkCgBpLX4tmon2Xx0RK+ZTD0JJg0cZElMplY+oCaQBszKHoLuK9Cq/Ns3q0kpJ9aO9AXClUy71l0Sm+9HiKJaRmt0+Q9AIx56gx/bPi8R8GlJx7NB4vTvcST9Cp3R8mX3ARbtUuBAN3XFG9fo9u6kVH9MyNfHCDNtVAqHofRKhdc/JPjq1j32cZZAbvn3OhV1hAS6UXXl/px9oUb6bXWfteZ4dcuA+TkCIzA1XJMNP3aB4n0OLuuxwiKLbgod63+EA9qbX5ry7ib5Mj6Shv1BDYtNohbmVBMoh5+35vjSvdd9Ok5IMvqhRkpi47OUNf01uZsEEJHePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAYNXb+dCS9A+PtOKaFGV7fcABxYEU7zpwpQllqUg1Q=;
 b=Cngj68eKcKhYO/h0FPWNcc10JV2/2NgS2X3B1n0662Y/ae/zF6lisCanLR4kbPhRQrSMarzCRzDp56dnZ88LgX2e7U62QlxHTcWnXQ5MOuHs6CkX3zeK7DxrH9PiAH4W2aLrev2R5RwMbCtME0a8umTB53NO09kMJ5NElud9YYuLKo+MPZC+ExW7z7Nv4nr04rBHAGI3EFdIqGftWrCpQ+wZphCdnff9G3sX6F3F9lFJ9nBY0IOuybVfI7/9racJXAy4JTZIGBt617Kcz4g1gnK4/aAC095yWHJgI0TfFZZ2hiY0b7PWxDy2HoZY5FDW9aARYMVyZLdpFc9ivlOInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAYNXb+dCS9A+PtOKaFGV7fcABxYEU7zpwpQllqUg1Q=;
 b=nhdks4xvgwFjDQat3KR3ec/4RqmLjbB0QyWBLi4eKgIYmWAaWsNfSoQ9va15MF96kokVjRHNmW+56BpA0eCqVsdPcyqulao0vvlA3LHtX8xiPRUcN57GGu+nbXJxlIHVeCk5YuK9ahMlLZTj+n84X7H7vijdAFotvRfCPYup+KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 22:45:16 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 22:45:16 +0000
Message-ID: <77e56212-95cf-46db-852c-6ceb0b9589bc@amd.com>
Date: Wed, 2 Sep 2026 17:45:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/5] x86/sev: Re-enable RMP optimizations on SNP guest
 shutdown
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <e8a8d0ec63bda2db61cde7cf298a4ccb6a502c20.1788296083.git.ashish.kalra@amd.com>
 <20260902220140.BE6131F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260902220140.BE6131F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS1PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:8:44d::11) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: dee42114-bd20-4078-1a1f-08df0943dbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|3023799007|6133799003|18002099003|22082099003|56012099006|10067099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	YG4EgA1IH1+hIjf60bf49G4M/ugT6Eq7VPXkAVIXLpB9L+jYlUzu+u0t0SwhuIyKSxGdRhdoH/9gkFdn9ngggr3xejkUCIhs4dx1ALwWEbJXbzVUqPTfK8CnjYF8QdGD7Ce4NWKjef7eR70+SDlvfIrU1lnWB9KhHHxsrwQqdjPzMaTnnC7RlIKnkuRTXY2tU9w6zcvJXnIaVdev5RldXjq1R7Zq0s7GnjbWsi8XFfqeq3UHN36/IhqBeOa4bYuh6hCAawWGjmPG6dfonptrvLsuzRP4ftt8kj30TcnjgXNKubv2CThQUP/V1K1OJewvjgmswOUIe9Bgag49gyMam51VhE020lDGpaljvGXc4IYQ33+atsubAtvHkYIRPJmrQ+nw7Tdc23rk2W9M92a8DcLeQpXwx+p2kbewrqJ5hb/ek2dWB0hQFASLCDaCdoMwgplmP2wv5JJEcs+m9K61PXnvDD0W3KsvrPdkvFL9iOBJ35hLZ5Tdal4SFAgCqU6YqQoQVcuqOse5zNi1vyd93ZmOJE6UiPjOaVu3qEKLJKlQTGqfiTEOvX4Gk9Ug/95hzEIJ+2iP70Ox0i+Xu/xqrejCpvW0N2X9JTWxyDyTCZ6NK28w7gbOylu9H2av2SMbKlNLouBJhnoKbrazXAnWaO0Dqk/HW7uoXqqtmAFJxL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDJabHBiQXdtU0t6OGFsY25vMzNvZmwraWgyV01sNkUyNHgwenJBV2NMREty?=
 =?utf-8?B?K0ZiZHQzVVVnZmMxVk8zMzV6c29SbFlhdVBwTXpvR0ZOVWZyRk1kRTRudklO?=
 =?utf-8?B?am9EenhUQ04zK21NNTFlaXFnejlrTnVBaEp2NmxPYmh6QldQcVZoRDU4S0dp?=
 =?utf-8?B?S3JuYzhtcFpCV3YrK2pOdC8vWkFLck80ZFJnZXhhR3E5aVQ0bHllMWlyVURG?=
 =?utf-8?B?SE1ucW5DdTFGZHl2M2NBZXRmQ2h4cWNJZlRwK1ptZ2RuWlk0ajA4SHhGQlgy?=
 =?utf-8?B?Smx6OVM5ckJJSnAzbUxuN0pzZWxHUHFISE9KaEVydzdlNExLSXoyZ3dHRDhW?=
 =?utf-8?B?bjU1ZHZNZWFxSUdkVmtKa0V2bkVPZEt3NDh1bVlPZXFCNHpwUEZkdG15Wnkv?=
 =?utf-8?B?RDVXU2xwelh1WVB3aGRUUXNwNndzZi84QTVBVWJyV20zaEp2czAvVDY4SVRN?=
 =?utf-8?B?OHNWbjNoTWJINzBUK05FdmJ6b0s1MHlObm52U1Z4Y2hQbHBGOXlTVG9kRjJp?=
 =?utf-8?B?SEJIb2NFRzAwTzhEYzRsVU9KK0p0aDRUd0szajRXV0p3T1dFL0k4S3M3Q1Az?=
 =?utf-8?B?N3pjZXRJRzlQUGdXTlB2VUM3cDh1d3VXbXlTbHFFK2ppUkt1OE9jMlRYYmta?=
 =?utf-8?B?SEU0dkF5bGkraWZnMmlnaEo4UmtnM3c3MW9aUEFZU2gzOG5SMFllMW00WVV6?=
 =?utf-8?B?UEdrMm43dHNSMldzc0pnQWFoZCtnSy90R3paMlRUVGRJRkZaZG5JcWZyVUhz?=
 =?utf-8?B?KzVTSW9wZC85N1NKd0pJY1V2YndhNHJYSXV5aWZ4TVZYWEZiZVZQd3lFRHNL?=
 =?utf-8?B?QUphZyswK1U0OUhYbnlBSUZqcFJRR0IrSkJvNElCNW4zeFZsV2YxTWk3Z3dm?=
 =?utf-8?B?YXJGRU5VZlJsOE42Y0FvMHlZVnZIWnE3VWljRFp4d3JxbVZ2a3BjTGF6Z2Jm?=
 =?utf-8?B?RjYzVHRGN2traG0vWmNpSHhhSnBIZkVSRHo1VXVUMUMwakg3THNESzZrNmR0?=
 =?utf-8?B?d1BjMVlWRFBSMlplb2tEem4rMEJQZEVXd2FTTCs5Z0ZRRlJVOTN3bjV5Vnk0?=
 =?utf-8?B?eTFxYjI3VlhDSkhNMENSYmcxN0hxWFdMeGxHSlozd2lGb2w1UkJvVVd3Q0pQ?=
 =?utf-8?B?WEl6aVBFQjQ2QTcwNjY0N3RkaUUvUnJCeURTazZBMnJHT0d6NkNtSmNkQ3pD?=
 =?utf-8?B?ZmloQ05VeFJ1T0djYWI2b2xEQUFxYzYrUkcwNk9lZ0wxc2lnWVQ3a3B0bUw3?=
 =?utf-8?B?VmhmYnBMRFlrUE0vMlFtTm9rMi92NjNidjN4Ymk0VmdZV0g4a085OTFSSFFi?=
 =?utf-8?B?b0Vjc2ZyMWhWZ2JvSFA4UUw1Wk9wVW9RdEdUektqWDVKaEU1clVrZjdsQ04y?=
 =?utf-8?B?TUN3RllhSHlGSnpQcWlTY3hSdy9kTTB2aDFLaGtxS21OakRHZTNTbTlGMUNm?=
 =?utf-8?B?cXQ3UFBZdE8xeW4xZ0NuV2NJL0hjN3RVeDBHbjVMSVo0bm51M09BYUQrSjJW?=
 =?utf-8?B?SWdXOE9TSGduNUFSY1AvT2xpckU4RW9ONlBWWWJKN0dYZXBBY0kreWNldFZ6?=
 =?utf-8?B?Z1J5UXRhQ3o2Vkl3Um5DRUEzaHJ4eWJ3S3BVWmt5ZUlwUGZFVnlMb21JWWZT?=
 =?utf-8?B?T2xOMDN5RzZFMTZFdnBUaU5LSGFWUnk3YkxzbVpQZXdYb2NEdG5XUTNNMW5S?=
 =?utf-8?B?cTZQV3o1K20xN0tUNjlVa1REekhwS2h2TkNtYllaakVQVk5QbnhMcnJ5bGkv?=
 =?utf-8?B?Uk9pamhISVZnM2dPTXdCc01zSEh3Zlk4Mk5ndjliVUVTa1g0Y3M4VVlYc2xX?=
 =?utf-8?B?NXA5aXltNWNTWHVDUS9BQlh4bFkzVEhmNG9kVVVoVG80c0VqcDJKOTFPbS9M?=
 =?utf-8?B?UG03SmlBRkc0TjRWNWJWSnBWdFFVS2duekx2Z25MRmJPQjJKcTBnYnJyK2lE?=
 =?utf-8?B?TlZHRHdMSmRSS3cyNFc4U3l2RXA4Y2g3T01lOGNUWFRDaUgyanM2aFJiYzg1?=
 =?utf-8?B?SGtuRUVjRmJOK3lPaDFMVlQ1Q0R2ZHI5VzA1d3A2UGJzMllDT0Z4OEEzVXYx?=
 =?utf-8?B?N3dZc3Vzc2FIUWYzWk81ZXBrenBQSy95K0FqZE01cVRheWlqRnBySWxSUG03?=
 =?utf-8?B?RmRLZjFxWnF2eVFCdjRDSXZReGxSQVpDbkNOVWQ3eXo4dVkwd1VWc2hrS3R0?=
 =?utf-8?B?eDBvZCt6SW1iNnJhMHNkR0RYM1BJbVhmY1pORDNIUmo2aHZINy9Cd3BQQUha?=
 =?utf-8?B?YWxpRXhuNDliemZKUCtaeHVPc01vMGdsQnR4RmYvb3VsS1JZS2pXUFFRRk1z?=
 =?utf-8?Q?5j6KzLX2zGxUwQtAVd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee42114-bd20-4078-1a1f-08df0943dbd0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 22:45:16.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9xXLhN5sftwUTeqc6Vnx6qiPc5grgEM1w2mhEROMIxHapnFMBF1kHLSqY4YDqt/neY4s9N4I5/j8og/YLkqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647


On 9/2/2026 5:01 PM, sashiko-bot@kernel.org wrote:
> Pre-existing issues:
> - [High] Redundant and costly RMP optimization scan in hardirq context causing severe CPU stalls
> --
> 
> commit f95e55ff4f3219c5a1e0b2d2fc34fde539f227f7
> Author: Ashish Kalra <ashish.kalra@amd.com>
> x86/sev: Re-enable RMP optimizations on SNP guest shutdown
> 
> This commit introduces a mechanism to re-optimize memory on SNP guest
> shutdown using a delayed work queue to batch multiple terminations.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index a4c0fe49b9ec7..fb66a1aa6fc35 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> [ ... ]
>> @@ -659,6 +659,33 @@ static void do_rmpopt_work(struct work_struct *work)
>>  	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
>>  }
>>  
>> +/*
>> + * Delay, in milliseconds, before the RMP re-optimization pass runs after an
>> + * SNP guest is torn down.
> [ ... ]
>> +void snp_rmpopt_all_physmem(void)
>> +{
>> +	if (!rmpopt_capable())
>> +		return;
>> +
>> +	guard(mutex)(&rmpopt_wq_mutex);
>> +
>> +	if (!rmpopt_wq)
>> +		return;
>> +
>> +	mod_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
>> +			 msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));
>> +}
> [Severity: High]
> This is a pre-existing issue, but queueing the do_rmpopt_work task upon guest 
> teardown exposes the host to severe CPU stalls.
> 
> Looking at do_rmpopt_work, it broadcasts an IPI to all primary threads:
> 
> arch/x86/virt/svm/sev.c:do_rmpopt_work() {
>     ...
>     migrate_disable();
>     rmpopt_scan_range(NULL);
>     migrate_enable();
> 
>     on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
> }
> 
> The IPI handler rmpopt_scan_range executes the rmpopt hardware instruction 
> in hardirq context over up to 2TB of memory:
> 
> arch/x86/virt/svm/sev.c:rmpopt_scan_range() {
>     ...
>     for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G)
>         rmpopt(pa);
>     ...
> }
> 
> Since rmpopt is a very slow instruction, does iterating it over massive 
> memory ranges inside an IPI handler lead to soft lockups or host denial of 
> service, especially if frequent VM churn repeatedly tears down SNP guests 
> to trigger this scan?

Two things bound this:

1. Coalescing. snp_rmpopt_all_physmem() uses mod_delayed_work() with a 10 s
delay that is reset on every call, so a burst of guest teardowns does not
queue one scan per teardown — the pass runs once, 10 s after the last
teardown. Frequent VM churn is coalesced into a single pass, not amplified.

2. The IPI does not run an uncached scan. do_rmpopt_work() first runs
rmpopt_scan_range() once on the worker's own CPU under migrate_disable()
(interrupts on, preemptible), which does the expensive part and populates
the shared RMPOPT table — all primary threads share the same RMPOPT_BASE.
Only then does on_each_cpu_mask() fan out, and those RMPOPTs are cache hits
(reads of the already-computed result), so the IRQ-disabled window per CPU
is bounded by the cache-hit cost, not the scan cost — measured at ~320 ms
over the largest configuration tested, well under the soft-lockup/NMI
thresholds.

> 
> Additionally, because rmpopt_wq is created as WQ_UNBOUND, the worker 
> thread might run on an SMT sibling. If so, wouldn't the initial local scan 
> execute on a CPU where MSR_AMD64_RMPOPT_BASE was never configured, 
> potentially leading to undefined behavior or faults?

MSR_AMD64_RMPOPT_BASE has core scope, so programming it on each core's primary
thread configures it for both SMT threads of that core. A WQ_UNBOUND worker
that happens to run on a secondary thread therefore still executes RMPOPT
against a validly-configured RMPOPT_BASE (its core's), and since CPU hotplug
is disabled while SNP is active, every core stays configured. There is no CPU
on which RMPOPT_BASE is unconfigured, so no fault or undefined behaviour.

Thanks,
Ashish
