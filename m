Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75461355049
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080062; cv=fail; b=WbxbUTuXaBWQVoyMMgWMDPzqZkpzcCcgt7wBlfer2x0bkCET74WpX1pXFaUth3wTdph5sVkE8l1GWDKiWyanvK2KJnfQNoXJ4Ic2Z4TNOTKL1rXHGB2XwWhP72KwSUOROnZJptxdRmW5l2H7+FphBH838C3Rwk/HCboFeV4VfMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080062; c=relaxed/simple;
	bh=4MRrIJ8364l5GJaOCfGY02ie61OiM2dzXX/ruJXDz4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gCZ63q3cZzA01HPMbCwF0covGoYvvKVnbR9v+cynETUjfyhfzjX2lk8sqDUi8QAHZbatVa35rwo3dgIfgbCxNUcOGIvh+DUpgZsANzTtCeHQVZUFG8BoTA5YX7YBD5eRijSZrmsb3noXBCzAoIlJoHgt90xQkSswJ91JU+12Qic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t6fadDbC; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t6fadDbC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lg2vXmDSHCZaKf/diZvXrh5y0yzTW05xrViNZ8Yh0oHI5WotCbbrHhOZX85nV+Bv9VC8ONdnjUokW1n8Zhp+kgUj+10Byu9Qka5WDdls7xJq6qeOqFyz+Il5JGBROSKunlhmWgQJ27WUORIznRa223PVZKPZiXgBai712qE1iKP04E3xg1gfKjqe76SJqbbYyj4gpRPJ05MR3MIQXzbL+qZGALBOvjqikaauG2WjbuVO+6okm8kFILos/cydAteooG9oc6+GmjfTo6el3JwUl8tZ0KIw3assjKicLtCl3ivLUmmC7iWfiftIu2Vbvj+4P6WB1oseo17YvOCJ/xWN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7Ll5F0P6EGT8D/M+mPL3IKEFC4qZARwTLPwwS2Cccc=;
 b=Ds0VQomqbIvorNjB0db10SRXtxDMcxrE5k5NYuByL5eHfY7Y+B5YoO60K6Xxi0zEnGdpKMWxrXCaLZRpQPkUZBOxbyaPGhmHtYvcSJCETlYbLXwvLF8upoQkX9vhQ1jAscKCSszFsEAbuZIuHr5SZjYJm3YE3KA+seclPYN9y5sz5dQiTSsatwkDVCarNqGKuVDJ0ScfsrnEs265R4rjeqfg82H4NBcJ6ZQvJCC2Ls758+m6+gHb5EtyLHQzWoNzGx+KdnEHbHmaFFErvLKwr0ONHJ2kS09y4pTSHSHL2rI7N3wbFe681g0RM0NlLD3GxUapsFc9556FU3/1oruePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Ll5F0P6EGT8D/M+mPL3IKEFC4qZARwTLPwwS2Cccc=;
 b=t6fadDbC5T/phuZIKgQFvyajQxf+NlnVmW5Ym3za87aWEEUtNtf+X1wzbpOjCM8CvfLK3mMAnf8MwQJEcGMRqKi4FPypE7eykhvDyBUPKv6SI1SlCqrbI78Ym+nZRgZbVw9X5XdkbCcCKZB0CFLGIjMCqPXAYVw+OwNyTe5plSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 22:40:57 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 22:40:57 +0000
Message-ID: <c0f425af-dfee-4f75-aff4-764e45c8e987@amd.com>
Date: Thu, 10 Sep 2026 17:40:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/5] x86/sev: Perform RMP optimizations asynchronously
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1788984053.git.ashish.kalra@amd.com>
 <1e3d0edb6b275e33fa6f76b0c31db9e999d9a270.1788984053.git.ashish.kalra@amd.com>
 <20260910221118.4FCF01F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260910221118.4FCF01F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0333.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::8) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7567a34d-9924-4072-6804-08df0f8c94b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|6133799003|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rHp7ZG17wEekgJ6e7ChyDSg0rQntqD+vGzvuIWIJnlxejE0Ahjvn2Qd0gyM2E4gAlyoJYhrlR3Et5yPy3zk+SeevTRh6+yb47gzFdHz67ruXDWmmCRy12Lol80AmWmB1cGs7mJYHq/4534JJMKqMUvXfDKr5f0TBHR3PpAkWV4mAWQw9Ze+6fJ8P+vtdvY5lTPWMQMPMEJkzMV0QoIuVUz7lm4LO4D/cZbO0ijzv6XZZOmZil41s0okQSwyolvnfAM7yYmOGR9mIy626c7D70diQRflIpA46qrH0X/mGNgh+j+vSIuGsQDK9Y1m57i/T9CF+1Y6T1IEPPBzu+SeuZDWnOA6kN9qlCcaCwlONHGU8srzHY9mOn7onxSV8Cb4PcdQHIQuOo8/WahZMVrKZURiNCzYHPXTuTOpRIp1HVa17cDd01N9jLSULQHtJow8ik4JqoJgMRuKOMuleXwGdgv5G2cvTXiVv3thRpcTdLcMcPFl+IbSbI4vu0WS5UvW+xkl7fk9XPVeIZqiaTPIR52rKWGPJ154C1VPZ4H2MeCtb2uRa5Lw4J/6fWeAtnbs4McvSzNIaTB5fb+dsYFtMQOGgXOlW1Brqx1IdPtakvb+N7cdnKkfGjfwdnya63mhMJPYYvJ5/X6qzRyizaiPC0rkxF/BFtuoQ4H2qb+6TRmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGNZZUZwYUp0ei9qb2ZGSlQyM3YycmpTL2hkNkVVem1PaTFkQUg0WThHdFd1?=
 =?utf-8?B?REpyd3NqRCt6YURIUmFpaEFHd3UxWnNDWmc1Z1VSYTlHKzN0bnNyWHhqVlUx?=
 =?utf-8?B?eU9rMzF4VXQrdHBSY0EyNmZMdytsMTQ2dnY4YWVyakh0UTA2SDZrWCtjVHAz?=
 =?utf-8?B?VjV0SzNNNXQ3TjVObkFEbXFqUDlFRVRPRDJDT2QrcE0xODVTZlhQU044MCtV?=
 =?utf-8?B?TEtOMk92N3NMN0RMdmZ0WSs5RHJ0MzM1VzRTMlYzM21wWG1HZVl5STh3elVX?=
 =?utf-8?B?NGQ0d3JDNTF1TXczVnV4eGp0UmVNbDFuWjMvM2VTOUFydVgzY2lTVzErWmRD?=
 =?utf-8?B?dlRlNEtEYXprRjBMQ3BkcmpzV3FIbDcwM1pvOU9CUGxjdE5YbjVRYUNGOW1J?=
 =?utf-8?B?QTBNVGsxNmZGZWtNMTUrOHV1Q01SRjFWY2I4bVJTUCtCemQ3S2U4U01mbzdv?=
 =?utf-8?B?UlNSbDBJL1lHL0p5TXMzM2Y1aDlDTUZGSUFSN3BIZzNRaU0wTjh4YkR2dHMv?=
 =?utf-8?B?ZmI4cktZR09Oc1ZOV0xkbEVNaEtNOXRXemVvWE5KNWJVTE5ONkcyRkh3Z295?=
 =?utf-8?B?bCt1OG1vbmFjWmFQb1J5bmFrSi9XMStOSmNCdytsQWpWdzFKVWR4UFkxdmpC?=
 =?utf-8?B?YXI4a2cxOXFFYm5GVEFLN1dqYUJ2b1YrZDcxRmhSME9xRlkzc3lMdFZpcU1X?=
 =?utf-8?B?OGljV2ZEa0J6STBFc1JHYjhrdkdhTk1UbUgwbEVXS1N4c1pFRmFiaGx6UFF2?=
 =?utf-8?B?RDhWRWNTdFRYazB6akpqNlBUYWNtdXlvZjdSY1NrZ0hoTldDY2YxUnJKcmpQ?=
 =?utf-8?B?a1JTaktZZit4VStDZDZNNFVDaXEzaHFQUU5vUkwrR09UVlJ1dm9na3N0YXNH?=
 =?utf-8?B?T2hhS24zT2o3THpKRVY1SnpuQUpSWm5zNFM3ZnkzZlRIcm9NY1BXWkl1bUd6?=
 =?utf-8?B?dW12MDBzQXBKT1JGMXJsYXU4V2xWcGVYY05QQVI3NlJqdWY4YSswM1UzN24v?=
 =?utf-8?B?NWNDV1FjRE16NFQ3Q0tXSjh1NFV2QlZrOUlnR2V4eGtPYmg2bTd5NWxuV3B1?=
 =?utf-8?B?SUZHR2k5c3VsYWs5NHUwWlJlQXhQTnl4RHF6eTZmbEJ6eS91d0NtZHZjamNv?=
 =?utf-8?B?Mmg3Y2tpOVRnSzllSmMvWWxvMERHMnJUN0FOaW1HVHRVa3dTeUZZMWl1WFlz?=
 =?utf-8?B?RGIxUVh0T2xXNHQvb3dsQndFc3g4T1prTDRPZXFuM2ZZalY4Zk5pcFpobXBH?=
 =?utf-8?B?OW9OV3JtcnJpWVVwNHRNeXdHQkdGTGdsaXBFaENYR0hXeXJieURkcGtBcGFU?=
 =?utf-8?B?UFpuUVg3WXltRVJZTUdCRmZGdWJpQVFCbU5TVEdoaUdRa05SdXhzUUNvTGp4?=
 =?utf-8?B?V3dnd0hydkw1bFJtVTExSW96c1lSNkFkUThNbFRxa2FoUEJraGhEUCtMK21y?=
 =?utf-8?B?azBFdDVMRkFlSWhsZXpnZVJzWGFlTkFxbWx5QmIxNFhzd0t5UnZmTXJ1WVgw?=
 =?utf-8?B?TnRCakFFTVVBWHZuQitRS043OTdxWHRxTTJTTXFOVnZyNUhxY2tJeWd6eHBM?=
 =?utf-8?B?clZNQ25Ma0tMdG80REZJdlh6eVNrTVVscWtQMnZKamlyYVFmTUIyakt5TGE0?=
 =?utf-8?B?TGNNVThmTXRRcTNJa2k4K2ZoajdyaE9pTEtyQVlWV1lNNGlEL0Rkc3ZtMzNs?=
 =?utf-8?B?N0pwajFBT25WWnlTRU1zUXdFOERBR3YrOUpoMTlMbzlUcDR0YTJrMEd5QUFK?=
 =?utf-8?B?TVkrU0tGOEo4N2NFTTBteXlqaTdsYnNPZWdBMnB4TmZ3b3FURlZvRXlmVC82?=
 =?utf-8?B?Ymc3bWR6WDlyakhzVFlOSjhlV1UrdjNVcitObjEyU1M2QjkvemJ6R1lmTSs4?=
 =?utf-8?B?MW4xR1g3YjZScEZPSzlZUDVPMHRNd1hTcHVzUSsxSHJQOWJZZCtBbXQvZnNs?=
 =?utf-8?B?QmpHU0hrTlNKdXhSNGVVcmY3L0NsaXVzR0pNaTY0c3ZKSWdJREJnVi9HdnRW?=
 =?utf-8?B?MTl5djc0WlVJWW1xcHgyQ0FScHNMaWdhL0FsUkJaZHhPN0kzOWtOZzNkT1li?=
 =?utf-8?B?TVNjOHNBTk9PMkcrb1FNYW4zL1ByOW50VGdGRnloamhpTzZtS2hjWThLQXdR?=
 =?utf-8?B?TkFWVTRDRTFweVYvaWtaQ1RNQ0kvVmlXbzUvTi9paXJ4aVlUekY2L1lGRkNZ?=
 =?utf-8?B?ZDZkU2FvRWdxakRpWDhKVnFleXdzR0p3NHBLVGVLU2hHQ3VzTkRVWEVmQkoy?=
 =?utf-8?B?MHNNNlpuNzdvUytSUy96TVlBWUE0QnphYXZLcDBCaVVzdEpvM2lwZ3JPcE1s?=
 =?utf-8?Q?6uwXqdxRWAF7J38bsv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7567a34d-9924-4072-6804-08df0f8c94b9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 22:40:57.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6lOM9uuBzY59QUy0H7DVSrGKX1kr9rSHsZNO/PHrpRQi3EKMio3JdppPYkWZJZhZAEr6WOjpsTAkCsQkKjwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454


On 9/10/2026 5:11 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Re-initializing SNP after a CPU hotplug cycle skips programming the RMPOPT_BASE MSR on the newly onlined CPU, leading to an Invalid Opcode (#UD) exception when executing RMPOPT.
> - [High] The inline assembly for the RMPOPT instruction fails to declare `%rax` as an output constraint or clobber, leading to silent register corruption and unpredictable loop behavior.
> - [High] The RMPOPT 'warm-up' executes on a single CPU, causing the subsequent cross-CPU IPI to execute millions of slow RMPOPT instructions with IRQs disabled on all other CPUs with cold caches, triggering hard lockups.
> --
> 
> commit e2c3ac4ab3639e4c47a6c85a3acca0d88b6fb5a3
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Perform RMP optimizations asynchronously
> 
> This patch introduces asynchronous RMP optimizations by scanning and
> optimizing up to 2TB of system memory at 1GB boundaries using a per-CPU
> workqueue. When SNP guests are launched and regions are allocated, hardware
> clears the optimizations, so the workqueue asynchronously reapplies them.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index a059327dc1071..35678b1f535d4 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> [ ... ]
>> +static void rmpopt(u64 pa)
>> +{
>> +	enum rmpopt_op_type op = RMPOPT_OP_VERIFY_AND_REPORT_STATUS;
>> +	u64 pa_start = ALIGN_DOWN(pa, SZ_1G);
>> +
>> +	/* Supported by binutils 2.48+ */
>> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
>> +		     :: "a" (pa_start), "c" (op)
>> +		     : "memory", "cc");
> 
> [Severity: High]
> Does this inline assembly need to declare %rax as an output or clobbered
> register?
> 
> Since RMPOPT_OP_VERIFY_AND_REPORT_STATUS instructs the hardware to return a
> status code in %rax, the compiler might allocate the loop counter pa to %rax
> in rmpopt_scan_range(). If hardware overwrites %rax, the loop counter would
> be reset, potentially causing an infinite loop.
> 

RMPOPT's only output is the carry flag (RFLAGS.CF); it does not modify %rax. The VERIFY_AND_REPORT_STATUS result is returned in CF, not %rax — unlike RMPREAD/PSMASH/RMPUPDATE, which return data in registers. Since RMPOPT leaves %rax unchanged, the input‑only "a" (pa_start) constraint is correct and no output/clobber for %rax is required; the loop counter cannot be corrupted.

>> +}
>> +
>> +/* on_each_cpu() callback: optimize the whole RMPOPT range on this CPU. */
>> +static void rmpopt_scan_range(void *arg)
>> +{
>> +	u64 pa;
>> +
>> +	for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G)
>> +		rmpopt(pa);
>> +}
>> +
>> +static void do_rmpopt_work(struct work_struct *work)
>> +{
>> +	/*
>> +	 * Warm up the RMPOPT cache on this pinned per-CPU worker with interrupts
>> +	 * on, so the IRQ-disabled fan-out below only issues cache-hit RMPOPTs.
>> +	 */
>> +	rmpopt_scan_range(NULL);
>> +
>> +	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
> 
> [Severity: High]
> Could this fan-out cause significant stalls on other CPUs?
> 
> The RMPOPT cache is warmed up locally on the current CPU, but because the
> caches are strictly per-CPU, all other CPUs will still have a cold cache.
> When they receive the IPI, they will perform the full up to 2TB scan in
> hardirq context with a cold cache, which seems likely to trigger NMI
> watchdog timeouts across the system.
> 

The premise that the RMPOPT caches are strictly per‑CPU is not correct. The RMPOPT optimization results are held in shared memory, not in per‑CPU caches. Once the warm‑up pass on the local CPU — run with interrupts enabled and preemptible — has verified and recorded the 1GB regions, the follower CPUs read those already‑computed results from shared memory, so their RMPOPTs short‑circuit instead of re‑scanning the RMP. This is why the fan‑out is cheap: measured via the debug follower_timings node, the worst‑case follower IPI callback completes in ≈1.3 ms (1,341,505 ns) — roughly four orders of
magnitude below the soft‑lockup/NMI‑watchdog thresholds— confirming the followers do not each perform a cold up‑to‑2TB scan in hardirq.

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
>> +	guard(mutex)(&rmpopt_wq_mutex);
>> +
>> +	/*
>> +	 * Set up once: the workqueue and RMPOPT_BASE MSRs are left in place on
>> +	 * shutdown, so a later re-initialization just re-queues the optimization
>> +	 * pass rather than redoing the setup.
>> +	 */
>> +	if (rmpopt_wq) {
>> +		queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work, 0);
>> +		return;
> 
> [Severity: High]
> Is it safe to skip programming MSR_AMD64_RMPOPT_BASE on newly onlined CPUs?
> 
> If a CPU is hot-unplugged and hot-plugged back, its MSRs are reset to their
> defaults. If SNP is disabled and re-enabled during this cycle,
> snp_setup_rmpopt() will see that rmpopt_wq is already allocated and return
> early. This skips the MSR programming loop for the hotplugged CPU, which
> would lead to an Invalid Opcode (#UD) exception when executing RMPOPT on it.
> 

CPU hotplug is disabled the entire time SNP is active (patch 2/5), so a CPU's RMPOPT_BASE can only be reset by a hotplug cycle that occurs after a full SNP shutdown has cleared SnpEn and re‑enabled hotplug.
RMPOPT is set up once and left in place; re‑initialization simply re‑queues the optimization pass rather than reprogramming the MSRs. Guarding against a full‑shutdown + CPU‑hotplug + SNP‑re‑init sequence is outside the supported flow, so the setup is intentionally not re‑done on re‑initialization.

Thanks,
Ashish

>> +	}
> 
