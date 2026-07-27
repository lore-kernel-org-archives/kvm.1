Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFB3FDBEF
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185404; cv=fail; b=Ped3rmNpPwkSo1VAQC58nASjekY6F8rQvDAPMgv4MMBYxplpGJGYRa7ny50eWdjmMzBtt3sAYMr8JqLrL8NOE4TZTrjtPxHM23NSRl423+s443vrPg+f2j31haZrKTVbBfUpVhOi5yf9G4cQvvMw0o+Yeh88rUvYEkax0a9LTHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185404; c=relaxed/simple;
	bh=E6Zh7ZLKeRnnAU6VyPfaibe7zJgYcIEfOYhSQflt0I8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iV1p8GRBxxCKTKMdNXP61BWI9kpowsjoRwplAGcBc8RIpP0R4C+PxXY71fvh1Za24we+LcJoEcwReZwZ+5JTnRjrYsr9NjHa4iIkBTYmutj7BsAIf0cWyT/RmxURjImJYT7lbQjDSav/xn2iBJ6rqiwGOZo+t12zQLBtB87uccY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xpBa4mC1; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xpBa4mC1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTmTOaE3VUXk7bMjch45wcSYJuNByG1BfSoLGFU3+GsPzS+bYtdFmwKvNjnfa8wUWUaw5o7pkuFEnP37GpUxmbrn44AZm3ukmGqGTRycEJZDIH337ZdjFv+d9gh032iPPQDXKMiHRZOrz9x0jA14RAiTeONu8TX7QAnWESWkGEWDdEiJOD27bCx57PCeT9XHmMbMGVtCTh9IHJmQE2OrAEw+cjvkxCvFnH0wPf0pJuX92gIsqgacLNF6ij37iqpwc5Uf8jXqXTRM9gzaRFj/3tWeRiwj7q85cDJEwPYkVxTXZUj+iCLVF8mAO11S9Ekw83Zodn303lLEPBtAfqW7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/d978wjXCs/3yUU4dTEAH6GGWFWC9zTRErZOwtNJaE=;
 b=E1KoSPRjGq4/4VYV7pHceLldw2vPci9Yt6Z3x7FfKiiyFNLCa73nEm9QN69uwdI40X8WQJEDu78mT+sJ1YgI4lwMVy6Odyrc3snIq3oivWsKAy4u3gn9OJMqgkgtTZvd8e9+9Y+tHQHKM0tXgylhVnzrW75nFOiG0w2DfpVbwN3xJL4s9sysrBwsWX9pu2hIpM0kqtpnAJU7VPCh/kAsYrcyUdwlCmO/fnlrS5n6m9cnj7e7+ql+j19TsuwS/I3HaIPiUWvqBPNa+RofENCfnDszZ159itKqby/87PaHLwPaR9wqGMw7vJh31iy4Qit1q+nYrstOxzNUmlaLmMB3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/d978wjXCs/3yUU4dTEAH6GGWFWC9zTRErZOwtNJaE=;
 b=xpBa4mC1Klw9W8+2B/m69ARkkFdf0/G9iv5T9m5Sy715m0Rk6dZFa1Xm4ZDP2eRiO3CwOUoH1LmNyCJLEPqojGRpa246s5GqtnlEz8YqNGNyIQvDzcKEQlzi1tgLisVEK1ggndgKtUEFdP1kpyEdsQd0178F75MYiCMH180774I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:49:58 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:49:58 +0000
Message-ID: <c6c912b1-7727-4aa7-9412-8f09793d9c18@amd.com>
Date: Mon, 27 Jul 2026 15:49:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/6] x86/sev: Add support to perform RMP optimizations
 asynchronously
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1784844080.git.ashish.kalra@amd.com>
 <7f582569acea933c3045be604a81975e29b5ee2b.1784844080.git.ashish.kalra@amd.com>
 <20260727192256.7EAD31F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260727192256.7EAD31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::17) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d84c39-2193-4483-b8bd-08deec209ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fbjRAQaaBnNnFJ6aXckYSOUrgdxDOQ/7hHMw3FRQcgEJwXmS1/fsIpQRv222osdTjaX7FkKQlYaQ3RQf6CWNIgT78mLtwIajmHweEvgkmQTehLe/6XIeoLCOiC061JZ9znxt6l+j6hTlLpyV8qnYHbP0CDvF46Nsr+fvkkpHKJa1Pbmb8CySRdKVu7nUgLyQILgTYNBNs1oU1/L2rtBvfwJ37w/Buuuq/AZZsGNRpwLw09ju7UAXjSdSKvyfL/t7qRX8ooUXzW9QtmPApEzpXpp8bG66sNfsR6Y1nmeKoGgEH0kupCMOgO6y4naQVPwnlRDDqVRc3XTxyfOIhodnJJ5rxnLBhZim3qR2iXYYxWPnn3pChUohUIDXzdu1W0SxbelNC4EJ/7SlZWxWQpZV2Nq6ZrmRrwJFUvP7ZDVOV+RLb7buQhDo3JkK3WbNGVifrfDBiT1yC9r9MtNqAFyxWEejPXWlaAZIe7kGodA/GdKIgLz6LIoSsO5t1h08gFBPsqG8bEic/Bvbs1Nc1st9QA5gbshY/ESc03u1iMiqyt5BjaFpAkfZkXPknPkJnLDtwDXzTVSApXBx5Ai/EoAeZkE5CvaS4YNitmk1QtwXRoLwFPCzZFslIrDOGwHIbK+rQRWagIHeZRvX+XS9XV9nE42G5V4FivAzWYb6ogtpZ4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnNMVUk1RkUzbi9tdU9oV1p6eU5QOExTZlV6SnRLTzZscXJ5YXA0ZzU1bFVm?=
 =?utf-8?B?L0QwVmptMk1rVDJCOEdKQUdwNjJIN3JyT3YzQnRwUFhLYlNycnVXRU9iUHhJ?=
 =?utf-8?B?NHoxb1hZOXNCVXBmKzd1S3Y1clFrUFY0emF3Z2V0SUMzSkljNFhxNHcrSjh6?=
 =?utf-8?B?bklFcnlWNk5JeER1L2pEcjBGM3pWcHBZdUdtRmQ0MmVrdlRPcVNCdkRnc3Qy?=
 =?utf-8?B?d2V4czVHY0prOUl0SCthRE03U3o1U2ZiOEFVeVBncVdSUERnWWUyN3Rxa0FW?=
 =?utf-8?B?YVlaRUdjSmYxWFlEZDZGZDJYK1F2SXQzWW5nMWs1Wjd3eEFEdmZzNURzWHhG?=
 =?utf-8?B?UGRQYytwc0RvMlZSdUNlbG04UXdWK256VjJ4a0phcGdKOUx2dWVJTzRxZnEr?=
 =?utf-8?B?UkY0R2p5OEVPYlVkRWJtWWFTZGZ5TTd6U2tDMndvTkdvVFZ3MW9XYVJ5aDdU?=
 =?utf-8?B?YnBqeEc3SEhZSFVYZVliWmJnK2VISm4zWFVkM2VRdldtemV1ZEl5YTlta3Zq?=
 =?utf-8?B?dFg4Q1l4eTNtK2R2YkZieTlIeHo5UGc3WC9mMXZ1WU5ySG9EMTFGbnZjdDk3?=
 =?utf-8?B?TXBkOWJNQjVxamc4c0RiMFhMb1krU1lYSWwyRHVFT0hpWkRmOHFkSDNiV2R6?=
 =?utf-8?B?L0ZDNlQvRnh3d2hRbStERk5lWWFzSE5vUmI2cDl5OWtteENEb0V5bzBrNWlS?=
 =?utf-8?B?MERPQnpyMElac2JUa0NhSzZURktyTXp4dDZsNUZFdWJHcTN5cENMV2tFT1RT?=
 =?utf-8?B?aldnYzRodmJFNjM1NUNRUUtNVFRqZU1tNjAxek1jdFBYb1gxRWRBWEdJQkM3?=
 =?utf-8?B?d1lzRkVUWFVaS1gvU1VKaEFZSm54L0hOWFBsbDFDN0t6cDdIUEhmd2E1RC9p?=
 =?utf-8?B?VWk4RU1TL0tyU0dlZDNqYkdVWFZQcFN6NUUvNG1qNm91MXVFR0tTR0MzZFpv?=
 =?utf-8?B?Y3dxbGVXRSt5eEhuN3JLbzJBaTBQd0ZkNWZoWnZ3OW0yUllUekZLVFJldHBI?=
 =?utf-8?B?SnRnVnJNckZUamdlS2R4VTBZUlpyMDRtbXUzajBJeWxNSllwVnlhMzRnVm55?=
 =?utf-8?B?NkJjOG5XLzViZCtCU0RnWDE0Y1pSTEJVQnpYQks3dUxJNUdqL0JjSnBGbGpk?=
 =?utf-8?B?ajRMMVZuaGhRNG5Sc3QrSmc2a3owQi81MjYwYXVqYTRtZjBtM3lvZ2gvNWl2?=
 =?utf-8?B?bEY0SnNMZ2oxaDMrNGNuaU5uakhQMHVvMmtiYVFKaVhFTE90b0FyYTJMUDBD?=
 =?utf-8?B?RG5ZbjZjcGFPRmtRelh1by9hUGlRVmUva0NqMU9DTFh4a2dnVCtUczkyRVVr?=
 =?utf-8?B?WWJUcTBWdE1idzlPbmMxQkpiQnFERFRLcmsrSW5uOTlVZEpkSU1JQ29GcVRR?=
 =?utf-8?B?TDVpZXVMOHVxYm1ld1ZQRUtXNW5BQkk4b1AyWitJM0d3cGZQc0VvVmZIaU1E?=
 =?utf-8?B?QUl2K3FpcXd1ZDN4NUFDK05tZ1B5eU1Sa1h1UGFVK1VuRW1NWlpiVWZBb1Jz?=
 =?utf-8?B?TEpaM1IyRXdLcHExbC9QR09zSjQxdVFYUWhJdzBtUXZySnVTTjQ5aThDcWRy?=
 =?utf-8?B?R0ljbmE1TlM2RU9DTXJWTDJGSEg1c1g4b0pDa0N2L2FHN0dZdFpDZnd4UlE4?=
 =?utf-8?B?NEhuV21LenZjUDZrb2d0MjVBaUU3aUs0VFdPUHJzUmNvekN3M3VQcTFhYnRJ?=
 =?utf-8?B?aStHeno3RjZBWkNtL1hSZm9hWTJCeFJVYXFaNm9ZM09idndjQXdXUkNUd2pD?=
 =?utf-8?B?Ymh0UENtSUJ0aHRDUFVGNmtTVGNGMU9YK1dKcXhRdktoSkduOWlocDRzdzE5?=
 =?utf-8?B?b1JpZm9NSEpFc1R4NkR5SWdiOStwb0x6U2Iwa0JCWjVHQ1dPUUZqVnEzeXJ1?=
 =?utf-8?B?ZisxYndoUXdHdi9Tc3k5YjlRYmJURDNBN09HcnAwZ3dHWmVJQ3VCTFVFSlU4?=
 =?utf-8?B?NTRnL3E5VUl5U3lWSW1IajJyRVlhTWNiQU5wclR1VXU3eXhlWW5lc0xIcDBh?=
 =?utf-8?B?bFdreHZ2RUE5ZzRMbnBhSTdXOVJ6YkJNaHNHV2o2ZmQ0cGxrOEtNNmFyRDgy?=
 =?utf-8?B?S2o0YWtIK2pSSVBXa0ZCeHhISU9WWFlNYnBpSUhkUWpzN2p0TmhWYlA5dno2?=
 =?utf-8?B?YkZYYVltMCtMZTNTSXV4RDdwRi9MOUdIa3ljT3dpVlE0WFFOdTZ3WVJDc1Nq?=
 =?utf-8?B?ZTZua3gwMDJPWFpHTWpzbUNMSmJNZnZzTnNIN2YyVGh4U0EwWTlqWEorcldV?=
 =?utf-8?B?dkFRZDFGQzBjaGxmV2JsTUR6enkxK2t1dUthalovTXYzNjVKcWRlcEpGWUJh?=
 =?utf-8?Q?B5TTlK1KYn7Owz0ujM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d84c39-2193-4483-b8bd-08deec209ece
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:49:58.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Agrok505WY5JOdoAL8JVwMsm0vqskko/QpukT8WsEaXjRyamXRGinfkldKLIY3lrEUsfFDjxEczhDavSkDkHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629


On 7/27/2026 2:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Inline assembly for __rmpopt fails to specify EAX/RAX as a clobbered or output register, risking an infinite loop.
> - [High] Missing CPU yield in long-running RMP optimization loops leads to soft lockups on non-preemptible kernels.
> --
> 
> --- Patch [4]: [PATCH v11 4/6] x86/sev: Add support to perform RMP optimizations asynchronously ---
> commit 9b1e0ac7d870b3ba02472132010185afc997e02d
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Add support to perform RMP optimizations asynchronously
> 
> This commit adds support for performing RMP optimizations asynchronously using
> a dedicated workqueue. It introduces a new RMPOPT instruction to skip RMP checks
> for 1GB regions not containing SEV-SNP guest memory. Optimizations are enabled
> for up to 2TB of system RAM starting at RMP initialization time.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 8bfd802848361..04b19e64f8329 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> 
> [ ... ]
> 
>> +static inline bool __rmpopt(u64 pa_start, u64 op_type)
>> +{
>> +	bool optimized;
>> +
>> +	asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfc"
>> +		     : "=@ccc" (optimized)
>> +		     : "a" (pa_start), "c" (op_type)
>> +		     : "memory", "cc");
> 
> [Severity: High]
> Does this inline assembly need to specify EAX/RAX as a clobbered or output
> register?
> 
> If the RMPOPT instruction modifies RAX (as AMD SEV-SNP instructions like
> RMPUPDATE typically return an execution status code in EAX/RAX), the current
> specification of RAX as input-only ("a" (pa_start)) could allow the compiler
> to optimize the loop counter into RAX and silently overwrite it.
> 
> This could lead to an infinite loop during rmpopt_work_handler() execution.
> 

RMPOPT's only output is RFLAGS.CF; it does not modify RAX. RAX is not modified and cannot be clobbered and
so the loop counter can't be corrupted. (RMPUPDATE differs: it returns a status in RAX, hence "=a".)

>> +
>> +	return optimized;
>> +}
> 
> [ ... ]
> 
>> +static void rmpopt_work_handler(struct work_struct *work)
>> +{
> 
> [ ... ]
> 
>> +	migrate_disable();
>> +	this_cpu = smp_processor_id();
>> +
>> +	cpumask_andnot(follower_mask, rmpopt_cpumask,
>> +		       topology_sibling_cpumask(this_cpu));
>> +
>> +	for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G)
>> +		rmpopt(pa);
> 
> [Severity: High]
> Does this loop need a cond_resched() to yield the CPU?
> 
> This loops up to 2048 times doing an expensive hardware scan inside a
> migrate_disable() block. On kernels with CONFIG_PREEMPT_NONE or
> PREEMPT_VOLUNTARY, preemption is not implicit.
> 
> Without explicitly yielding the CPU, this could cause severe scheduling latency
> spikes or trigger a soft lockup watchdog panic.
> 

Dropped intentionally: since commit 7dadeaa6e851 x86 has no non-preemptible model (PREEMPT_VOLUNTARY/PREEMPT_NONE aren't selectable), 
so cond_resched() is a no-op and the loops are already preemptible — migrate_disable() pins the CPU but doesn't disable preemption.
No soft-lockup risk.

>> +
>> +	migrate_enable();
>> +
>> +	/*
>> +	 * Followers: run RMPOPT on the remaining cores.  cpus_read_lock() is
>> +	 * intentionally not held here: CPU hotplug is disabled for the entire
>> +	 * time SNP is active (see snp_prepare()), and this work only runs while
>> +	 * SNP is active, so the follower set stays valid across the whole scan.
>> +	 */
>> +	for (pa = rmpopt_pa_start; pa < rmpopt_pa_end; pa += SZ_1G)
>> +		on_each_cpu_mask(follower_mask, rmpopt_smp, (void *)pa, true);
> 
> [Severity: High]
> Could this secondary follower loop also need a cond_resched() to prevent
> CPU monopolization?
> 
> This loop iterates up to 2048 times broadcasting IPIs via on_each_cpu_mask().
> Similar to the first loop, without a yield, this could lead to soft lockups on
> non-preemptible kernels.
> 

Dropped intentionally: since commit 7dadeaa6e851 x86 has no non-preemptible model (PREEMPT_VOLUNTARY/PREEMPT_NONE aren't selectable), 
so cond_resched() is a no-op and the loops are already preemptible — No soft-lockup risk.

Thanks,
Ashish

>> +
>> +	free_cpumask_var(follower_mask);
>> +}
> 
