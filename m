Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF84ADD9D
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388602; cv=fail; b=a/DzoHTmjABgDUAKLQULFdO1n6lm661p67P2ln1rYkvp07vVWxZPsbrCoVHQcaRaNSxRMgOmdXBQjRs+yIsRDOSIMKr2c5h7WQW42m+59vrQoKlIgVRQMFE0tP8MmCmUr5CX6sv32/Zc876x0+4enRvtaUUJqz02xYCNmuoGV7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388602; c=relaxed/simple;
	bh=ZwHkeTvKFehfF7tc1jqamzPez/f5IqIgCPM3YusXNsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8JyVvpLGYaSIwlbyNOrveNK8KGnZWmEh1d1wiaVeW42J+cPdqAyEkjq0/guwaqM8P3N3UxvbmZJE6dC2VH29ViMXXx3L9UsheUbDPaW5HVIoGZuaOXwgpbQWJdAso5qRrnfxaomH3K/04/KJvdBitFzcS4uC8X6N8Br/bY8w6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZkPBiUH+; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZkPBiUH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+kbI0D6usEGewDfSieMkBFBpkJ8VrOvR0gYbaQW5jbOJcHSNQtwYDg2w56nDDJ3xTexZpuFGGyPgxVUUxuR2qTE1kETSCkvU7QEACCWJlQ0n0scQVL742NZPer/UTFJAZ7RO6XBgtspDRleRNHXuxaCgzV91iUOx6r66UxL2nE9lVwxeA9u5+Rq8fYxKXPhIridjKh9Q7GurSNMS9I07xAuRVT7cpMSrge5jhndi2v4Dtx2PCShq4fytKvRsQ0613ixX1BFavn2pNutqEzVAlMuEdoPIf+E5IUmJ3WfXF0Hhw009m6OKpke1WfTeJBHdVyq9ez7hbADze99+N/KGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD616F86GNKfPBpOL7ZEBohA+TRvrSisPDSRROpcjfI=;
 b=BBXZoz7HkuAEdzEup+/CSstYXv5k5thwYdZtFYCXbqB6Zb3Mva6teBe7hzKApbNWcJ+tYBL0+BEtbvdJUnOdgHCbba2K9BtYzTqC9T/qPkjJgOoDubwQ7/tFKAHijOVkNT682q8filUl2DtduERXf3yohQhxlbLs6wNZ5j8ZeOfd7/YzycdczRH1amLBT12D7uSrZ3oAmq+d62tWN9U3l1e7qiftQY59hj9X/tPE1+p1M0yt33bSfw6ppZW8ziuur5ImTF5uTaYkVml7ujI5tHdx5qiIpZiFhxfBbn/9+THs3yPA6OAjYy38i09Tt1s28DSwBPGhFLNG93sffCZPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD616F86GNKfPBpOL7ZEBohA+TRvrSisPDSRROpcjfI=;
 b=ZkPBiUH+tXgnKF8nsFoBmQLh50Thawai15/pNc2Sxl6kHu7cs3oVcAh8K7bs9Lw7Y75+IfVC/oGQ/A9Tr7u7G6+P4PLFmypOn5CDDDsgA16UNC5gCylZ6Kr7n1jJBTtyoPleNZeISEE1xQClDxxizZS7lqgWehPFJl/IT48qjB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 22:36:30 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 22:36:30 +0000
Message-ID: <f8bb9cf7-e6c7-45ff-8705-e11aefe4c3e7@amd.com>
Date: Wed, 2 Sep 2026 17:36:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/5] x86/sev: Add support to perform RMP optimizations
 asynchronously
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <a31fc8c6d3f6c6bbe50dc4542c7091b0899d3e1b.1788296083.git.ashish.kalra@amd.com>
 <20260902215748.E53081F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260902215748.E53081F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:610:5b::26) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a9ee78-35d7-4653-ba22-08df0942a235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|5023799004|4143699003|11063799006|10067099003|6133799003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	L9nvV/r8cKgXUiUBMedFaTbmljtL0jutekn4sZcR41PIABiUIYuGbljNAhjU940MMp9OHFfLxMLuhlcG6ZvKu4qOIpmHlzEeHKwUTFny3wMCjNRd9zfZcRXMmxNfzpbNqOiH3vqvd09ltDXTK/8ZD1sBeD7y4iADffXNpIHYUAWcZxik+qo3pVyUWo5TsG3WA/Pf5IHiO9IbrpUDAuiBEyolEHUwpvJa8zMzdZaY+3wEQgCQ9c7JVNZMzcaM86XV1j34GdDfWcP8Z+SuJBVWzCDVC2iEpwa/APDQDaaim+IZ9v2+XQpeY2S4OK/lSQUOYNROTzy/5Xunf9POolBT1QmGAvutY+UC+N/dIY07lA79ZT0a7NRQIXh1rj1uAxpR9dvm4SsvPAV7SC9lr3/f91E4pS1DoRW0YD/92F7/6UhuIaXNlOdnQmWkqKQaeL4afETxBkU0LElYvZEwPmWAVT2CqDyxKGdMFuDBpuLqorlKzgdEiScL69TBLrhl+ah7aTPydAeM2tmvS3K7PXMKneAimoFgBpDeVGgqVHpWPX29vffdNyCMZSZSkMrHpq4s71+HEoPzunLlSAABaKUyDBo1Qed1G1pQRM5paKMwIeJ3/qnEZ9SeBFbmiHb+/u8jHpj0SR6Ri4t6RkyAKKv/GV0laydZGlIUPnvlksQtXgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(5023799004)(4143699003)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHBMVUw3eGdYR3pDOWpsOSt0d1h0UGpURkhad1hIOWdtZjVzUDRoMFZ3b1BX?=
 =?utf-8?B?akZ0RmxmbmtaNXcvZ1U2eFJ3L1FIQ3BFazZmUG9UT2N2R2NQVkZveUxadTJw?=
 =?utf-8?B?ZXNmR0xHVXpwSlM3V1RXQnhxOHBjbE40TGxEa1Z2Vkc0YU5EVE5xRWZiRC84?=
 =?utf-8?B?SnNpcVpya1lzQm0xQ2pVK1QrancvYTFMOE4wTlFRVEYrSC9uNHNoa1BRaEVv?=
 =?utf-8?B?MmxEYkFLYTdvcUIyWlNpc1NuQXJOWVpUYlgrcjRSWmgrRzl4UWJtQkpKbnhM?=
 =?utf-8?B?RDVyaGJXVTZiamFkck80V1M2bDd6dkI4Y0Y1L1loTGtwVTMwTzNGVGpSU1lH?=
 =?utf-8?B?NUpudU93aWxuWVdZWHFEWVVGMVhPalNJbFo4VkRYMnh4SjFRRDhOdThMcXc2?=
 =?utf-8?B?TUZjZW96a2hYWElUT0hnaWlmUDF6TXdMUDlVODdmQXIzVVhmeU0reUpEMFVa?=
 =?utf-8?B?V0JRZTJsVERPSWFJRlRGS0RMc3RTWmdnckkwbElnNXhDVU5OWlVvOXZtWG5l?=
 =?utf-8?B?dTJwR1liU0xFdEFvRFZHVFdJV2hDdnZsVGpaMmF1Z1FOU3R2clZsM2Z2cGpL?=
 =?utf-8?B?UlVab0pzUmFqZHpWMjViWDF4VlUvQU9LVnduQkd6Vnp6RjBRbDlnbkxQNk4v?=
 =?utf-8?B?a0M2TXJRY0d5SE9kdTFpYmd2eWlqZUwvTGN3WWlackNNdStZR2JNRVVPVXl5?=
 =?utf-8?B?NHl5WGNzTk5OckMwQytHR3hwbnA4b1lrU29sQXp3MmNlRzJ3VThFVGtZcUpl?=
 =?utf-8?B?V2RQUW5PaGZmS21XN08yNkVwbmlWSmlkaXA4TEZ3WjRGdXY0MkpuVzFzMlRX?=
 =?utf-8?B?WmFkaHIxZ0VVWnFyajExdGZjUnNMd2poVlkwdTBGVEgyMGNSbTBHOTFmT3NU?=
 =?utf-8?B?eCtITGlVRyt4SEpsSUpJeVMvSnFlMTdqMUlCbEREVFk3ajBPRmpSYnk2Wmgz?=
 =?utf-8?B?SVkrWER0Si9VWUtXeFBCTTVpMDgxU2ZlZW9SRjBSRTY0M1N5VFF2TXBaN0pS?=
 =?utf-8?B?SFFtMEpMWG9ZalRtak5GTG9yS2pGOURoWTVQSUVTYW81TWJER0dMVkVKUE5F?=
 =?utf-8?B?VkxkZmp6ZnJRYmZwY1JtSW9kOGo4aVlTdWQzdGdtRWF4OTROTUxRcmQyTmNy?=
 =?utf-8?B?cEs1dzk2SGtqV0JFY0NGUnpsYU1qR0lxT3IxbnR5R1hDbi9yWkFqT2x5RU9T?=
 =?utf-8?B?L0R6eUhjZ3lVM2svM3hUa29IVzVQWi9LQ1NJeTdUZ0FIVHBma1pPeG5RTnY1?=
 =?utf-8?B?MmhpdURrcDBBUGZlT2kxdDJ6K2FMVUw2alpiVmtDd25uU1NULzBBeDdWdEdl?=
 =?utf-8?B?L3dORkwrZDk2WWxwNllPOFAyeGxGQ0htclFQaC80Q0djcm9FUDJjelN1K0J2?=
 =?utf-8?B?UWNsMEorSEU5WXYyVStvbXNseFVZcTd6S210MkJnamxGWFZVNGtUOEw2OGIv?=
 =?utf-8?B?TkNuYkNJUmhpTDN6ZFU0aW81QXRMNzkwaUNyWGU2d1VWdTJPa2pucGpLMXNl?=
 =?utf-8?B?MkpGUDlRdkxBb09VQ3hLRitqTnltN3VLTlhsU01VbTkyWloyUWwxNnZZTUF5?=
 =?utf-8?B?Q29ZN1hHSDNzL1QxVWNza3BUTHhzekx4bjlSU0xGTHZ6MER6cUtzK1R4cUF5?=
 =?utf-8?B?U0dmZ2dOcVNvN3VSc0pSS0N3aldMaWx5L3VFZ0JiSjFjYk9NZDN0bFRreXVi?=
 =?utf-8?B?aVFLSkdCMUxzSWdjV2QzeVRTNFAyelJ3Nys0VWVTTkpmSmo0c0tKOVJRNlFl?=
 =?utf-8?B?UEtZYURXajZ6amdnR3MwOTVBMjNXYlYweHlWc1l1MHdXd0xFSTZDV1F1dERm?=
 =?utf-8?B?ZWJCcm02TEZrMmVBZDVtemdBUG5LVXVSZ3Y3eUFpOUJPbnN6UUlsaE9EVnZF?=
 =?utf-8?B?ZnZPb240b3JVR2g2ZklXUDZ1U3I0L3VXQ3NpZlRnVW9ubUtpZjJZWDVZTUI1?=
 =?utf-8?B?MmRmZCs3LytPYXlGR2ZCL2pRNGJPVm9aTjI0OUJablBWeWtkS25lTlRzSjVu?=
 =?utf-8?B?NDRpdHZRSGtvZC9HWkd0NlBRYXVyRml0S3hqZU1vdm9UTEw0dm9taGpoY2V4?=
 =?utf-8?B?TWpGSTllc1JnYmZCRWNkMWhmZTBGTWt5SkR6V1RQRGRXaHNFbkJ5UzNScGs1?=
 =?utf-8?B?eUZ6T01mTUlxTXh3Q2tmYjNYMGlBY2p5QzFMUzFyZHlod2ZNbDRtK2ZxbTQy?=
 =?utf-8?B?RENNSk5OYm5IaUhVRHQ1Z2gyUmQxNmd3YkFpckR3eW1TcWt5ZmUrK3dkbE9L?=
 =?utf-8?B?Y0plUmRRUVY2ZHBsRHR3a3l5MXMyaTNaVmlaNmZVZEJ4Zk0rbCsyc1dSYk4z?=
 =?utf-8?Q?FCkGEeFzaeBn/Tr7ZQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a9ee78-35d7-4653-ba22-08df0942a235
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 22:36:30.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUyuEgwAyX/hvj6OwVkqTpKcPCZDMKjxi5CX7aYEvYuE6mfGhpTj7IXaLDC1/J+lZczerV/OHtW4BwXAhdNe9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117


On 9/2/2026 4:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Declare %rax as clobbered or output in rmpopt() to prevent infinite loops.
> - [High] Schedule work in process context; executing on_each_cpu_mask triggers hard lockups.
> - [High] Use ALIGN_DOWN for rmpopt_pa_end to prevent out-of-bounds RMP table reads.
> --
> 
> commit 0121e9d5bd127536db9548e1a9f202c9576ef5ff
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Add support to perform RMP optimizations asynchronously
> 
> This commit introduces support for asynchronous RMP checks on 1GB physical
> memory regions to optimize performance on hardware supporting RMPOPT. A
> dedicated workqueue triggers the optimization process during SNP
> initialization and after legacy shutdowns.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 07f178eb76c7e..a4c0fe49b9ec7 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> 
> [ ... ]
> 
>> @@ -595,6 +621,44 @@ static bool rmpopt_capable(void)
>>  	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>>  }
>>  
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
>> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
>> +		     :: "a" (pa_start), "c" (op)
>> +		     : "memory", "cc");
> 
> [Severity: Critical]
> Does this inline assembly need to declare %rax as an output or clobber?
> 
> Since the RMPOPT hardware instruction returns a status code in %rax, could
> GCC assume %rax is unmodified because it is only provided as an input? If
> rmpopt() is inlined, GCC might allocate %rax for the induction variable pa
> in the calling loop. This would cause the loop step to compute incorrectly,
> potentially resulting in an infinite loop during boot.
> 

RMPOPT does not modify RAX — its only output is the carry flag (RFLAGS.CF),
which the asm already covers with the "cc" clobber. RAX (the 1GB-aligned
SPA) and RCX (the op type) are inputs only and are left unchanged, unlike
RMPREAD/PSMASH/RMPUPDATE which do return a status in RAX. So the input-only
"a"(pa_start) constraint describes RMPOPT correctly; GCC may keep the loop's
pa in RAX and the loop step is correct. (rmpopt() intentionally discards CF
on this path; only the debug/report path reads it, via a separate asm with a
"=@ccc" output.)

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
>> +	 * RMPOPT caches the results of a RMP table scan in reserved processor
>> +	 * memory, allowing future invocations to skip such costly operations.
>> +	 */
>> +	migrate_disable();
>> +	rmpopt_scan_range(NULL);
>> +	migrate_enable();
>> +
>> +	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
> 
> [Severity: High]
> Could executing on_each_cpu_mask() here with wait=true trigger hard lockups?
> 
> This call runs the rmpopt_scan_range() loop synchronously on all primary
> threads in an IPI context with hardirqs disabled. Since the loop can
> iterate up to 2048 times invoking the slow RMPOPT hardware instruction,
> is it possible for remote CPUs with cold caches (like on multi-socket
> systems) to stall for seconds inside the IPI handler and trigger an NMI
> watchdog panic?
> 

The fan-out is reached only after the single warm-up scan that precedes it:
do_rmpopt_work() runs rmpopt_scan_range() once on the current CPU under
migrate_disable() (interrupts on, preemptible), which does the expensive RMP
scan and stores the result in the RMPOPT table. All primary threads are
programmed with the same RMPOPT_BASE, so that table is shared; the subsequent
on_each_cpu_mask() therefore issues only cache-hit RMPOPTs — reads of the
already-computed result, including on remote sockets — not re-scans.

Measured over a 2 TB window: the cache-hit fan-out is ~0.32 s per core — 
~30x under the 10 s NMI watchdog even with ~2048 iterations and cold data caches. 
The IRQ-disabled window per follower is bounded by the cache-hit cost, not the
scan cost.

>> +}
> 
> [ ... ]
> 
>> @@ -612,6 +704,23 @@ void snp_setup_rmpopt(void)
>>  	 */
>>  	for_each_cpu(cpu, cpu_primary_thread_mask)
>>  		wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, rmpopt_base);
>> +
>> +	rmpopt_pa_end = ALIGN(PFN_PHYS(max_pfn), SZ_1G);
> 
> [Severity: High]
> Should rmpopt_pa_end be calculated using ALIGN_DOWN() instead of ALIGN()?
> 
> If max_pfn is not 1GB aligned, aligning upwards creates a hardware scanning
> range that extends into unbacked physical memory. When rmpopt_scan_range()
> processes this final 1GB block, could the hardware instruction attempt to
> read RMP entries beyond the allocated RMP table and cause a Machine Check
> Exception or memory corruption?

RMPOPT does not read outside the RMP table in a way that can fault. It only
reads RMP table entries to determine whether the 1 GB region is entirely HV-owned;
for any address in the region that lies outside the RMP table's range, the
instruction simply treats that address as HV-owned. It does not raise a #MC
and does not perform an out-of-bounds access.
  
Rounding rmpopt_pa_end up with ALIGN() is therefore intentional and safe: it
lets the final, partially-populated 1 GB of RAM be optimized — the backed
part is checked normally and any tail beyond the RMP table is treated as
HV-owned — with no risk of reading past the table. Using ALIGN_DOWN() would
instead leave that last partial-1 GB region un-optimized for no safety
benefit, so ALIGN() is deliberate here.

Thanks,
Ashish
> 
>> +
>> +	/* Limit memory scanning to 2TB of RAM */
>> +	if ((rmpopt_pa_end - rmpopt_pa_start) > SZ_2T) {
>> +		pr_info("RMPOPT coverage limited to 2TB; memory above 0x%llx not optimized\n",
>> +			rmpopt_pa_start + SZ_2T);
>> +		rmpopt_pa_end = rmpopt_pa_start + SZ_2T;
>> +	}
> 
