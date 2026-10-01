Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B423D891B
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840943; cv=fail; b=JPgfwq+L/2UrR2NpwMazyaXsyS/uXjGasq6+buQcSupEEQZhobLwzBDQ1rRlkH+DF171+txtvhs1FWbny/LLiAG6Uhg9qNf3wIsf7FvYD4hTsKbZtslB7GGiKNCdxXLR648gNqt5AFMlk9lJ3kKjYTrP3Dk7HJCL3v/GKOsRSrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840943; c=relaxed/simple;
	bh=qO7MI//3NnllhfN+qlXPT603oSridKA7tOPzIExUsOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c2qJK43h5XXQ1JZS5ts7GBYadWNg38387XpcJOEeGGGbjJS8Xc4q42oW5kEcX3nX8Yuvoalow3Xmh1XdJftcXkvV24lsdElhS4afILBZ67mdWYOEiOAT/Bpj8BXb6uS6gzYTRqdtPt2J1LObRYOkNbRa5ZZ8r0cgf01iDtn0CCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfujHkLN; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfujHkLN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3hwJijFnZE+cSPcrsKhVKiVVhBqcgCJYTvBsV3EpS5IL8tKU1X+lT4LUOueZ74tWQXSNxeqQHHi64y+/hhEdiwnLWojiRzQ+0BM3xBumzFzsQFm2j5bO4SXRXhDfU5mm7cFRxNqYqmjfW+hQveb0gBW+X9lSZTXAq6ANgauX+1fk6BdoU8vn0Nv6VZl3MDE8DUeNut8+BWQQhnMTuU5GzNbvprVbpPjsqolWxGZ1++FKjIo4TKmaDmmrXf/wIggKd12dvZsqPoSakORWdir3LOyNe2pxJarXsy/QigBu0TCtrM3BD7vSCB3EXcmMsWvhum5s6DCShhRoK0GZZZiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7eWZEiZFYAi/Doj6kwv6E367tQJzA8Qdm8ZbD27vCw=;
 b=pdhiwIi412kgIPNIQI4jOCXjRNR1FPohlAoE7/qDATxt2IL09KARdQbmZh11N0of6y+EX9drAg6bQSB7/Gj7HAEQLbXKSZPy799P8+x6ttM2MhFmA6+021zuLCYk9dhlp+QCzn5+DJgLHM10yC+d11ADGPDV1L6V8+ZL6nAeuN4Sk0qvxXwRKEr6cawCLcSyDdYSx/DTttftMi6/nJoNUv3z3SjuwCRlj/UHDG8kqZedjM9rSV55Ar0xjCv1CLTCxveIe2X8+gzQ/3aX2CnzW5RZfokglmi9BoTW/YCal3pFd9dpcU5LncD7fznUiBE4B2z4NmyZKfXHA2iJ3H+8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7eWZEiZFYAi/Doj6kwv6E367tQJzA8Qdm8ZbD27vCw=;
 b=UfujHkLNYcA2JzMS6QCfXUtCKFvL9tXov9YydhiwrotnJQnbzwhnxMd4qJbbv6/nvVdv0K7FquNFi+EdWQ2vjbX0+ax9cCHPsdoQXHwRL6e/PUTkjBnHe41ZPvc7Uc0VCfRENJ2SShCBy+JxTe2sHdliJsVKAwwsoeOjvOsjoXA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 07:48:58 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 07:48:58 +0000
Message-ID: <2dd84890-3c21-4942-a9e4-8e07408620d3@amd.com>
Date: Thu, 1 Oct 2026 13:18:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] x86/pmu: Treat all AMD CPUs as having
 instruction/branch overcount errata
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
References: <20260930210201.3482775-1-seanjc@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260930210201.3482775-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6faf5d-be5b-4955-2b53-08df1f907363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4SX+UcNJOIJSBPP/UpV5QteaDnESdmT5kNj5rMgeEehGUDm0JYMHr1hDdwHpJ28zrAyJTGXGpurVv2aubT4iNH4FsBOfYdwPdiepAD5KmuAihCuctJiggKIJAMkjqN+3g8+LqDogd9WNgYdkK2tgFdlqwANDwl7GAFx04LP3jOP1plaawfG7E4TV5FrH/He4NUOZ8bzgriczlcYJIjCEWn/XsrnqQFgWND1JL8konlDAhEAQ/Mpe+wbNFezByDmUiCfhPnE2EKnCrlVUcAL92N+1rLKLRaqZq7tkGcHJBGsfcUDtFuK1YwJ61gGMwqluTt4dhyvUKqXkvngvsT389jW2u02T6z5u1srBS6g5WHVRwl04FgMiDG6UzbuR1wwXYgjgc8S7ZBg+iQN1/rDicJAyHqEbK1MlRDnxaLXy6UUMKRDtSLlb8KNKRvGqnaZ6AUAg8UmzKBm+/xz4T1f0HgqEkjLFwa2pHjVCkHiikuA2rZe8YGtQR0aNnhQVEeVND7pMdrEQHOP1dLivR23bV81qbNFASqInQCbPM6Quq++zWo5FPRe6yhWvtRYL8vibx/9q6XPHDLFgKf1hJJhk6jXW3rh0hr4iLP4WE3CF0WYCHiAEf5qKFR4rFG9tdLlp/CGa1RcPFazvvXfM0QueiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TndWbHhQZ2xEc1R3QzFPTktsWU5DbmVha0FsaUQrcVo4TGdnTklXOUIrLzA5?=
 =?utf-8?B?WXhWbm9NVnJVMXFDS0Vnc1J4L0YrRW1iT1dIeDRBUERKcW5hdktQSjEzNERI?=
 =?utf-8?B?bzNmWmJCV3AvQzZ3YUxHWW9xeEtzc09FeVhoTU5VVlAwQ0JmbnUrbnFXVzhp?=
 =?utf-8?B?eDZKV2RMMWtHSTdvRGg1RUUxYUNjb2t3WFVROE1DMGw5S3BCMTlvTk1YV1pU?=
 =?utf-8?B?enZwSjRrN1hudEtTY1JrMVhaTm9xRlA1UTM1VWRwZS9RUGNFLy8wSkFEVnpV?=
 =?utf-8?B?ck5zUmRhd0hFTjNiVzBucnZUb3BXeG1xL2IxTWw2cHliTnIveWMzUlJTVjU3?=
 =?utf-8?B?elhvYkRCaGxvbFBmbTJjcEhUcDhPVkJNSjE3dW8zTFA1Y1hudGhMU1VHWlBT?=
 =?utf-8?B?U0t1bGUyeEJ3M0FEbFREWGxkR0plYjhsWGQxMHdwTXpDRktXSzNhcWJ1aG9u?=
 =?utf-8?B?VlpXaXpNejd4NTRiTHgySUZDV09mTStkRUV0TklNOC9kNjh1ZU9rbzR4WTNi?=
 =?utf-8?B?d25GRnVlS2d5ZzRpSDJDZUNWMVhzSGJKM2FGY3BuV2QrWmdLOWhBSzRHNXhs?=
 =?utf-8?B?SzdlTmtYVFNEdWlRbXlJRFl5b2tjUlZWd2tLTy81K0xnUUMvYWxqV1hiZEdz?=
 =?utf-8?B?NHpjZldKZGtlSW1SeFEyWlVwQjlOVFByak1rMXY4bDF1UmhBeHZNME9GUDV6?=
 =?utf-8?B?RXZRc1hrQ1lRZG5mTm5HTkZ0c0hKdzJWcWlyV2pnUHI1bVVYSTZhUHFubDBu?=
 =?utf-8?B?S21zUDFBbUNzaXRZd3RFMWlXSU5wTmh4elo2M0VSK2RPZFN4LzhDUDJsbXZ0?=
 =?utf-8?B?K1hxZTFYcFdEVU5rN1FaMXd5Zmd4TGprcDQyNElLK0dYMWNuTmFkZURaVnMv?=
 =?utf-8?B?eERGaUNYRURvS3RkR2oxTThuYzRPdThmdWhkWW13UnUweVVyK2JFV1I1OHds?=
 =?utf-8?B?WWZocDUxb00vaUhxaWNPU1R2MmtXYk5WSlYrYUVhT2kwM3VBMFF4TFhFU3VU?=
 =?utf-8?B?NXRGb3BxRk9PcVpla3pGaVVxYUwxZ1ZQbUdQaEtDbXVDaHh6aU14cU9tUEtk?=
 =?utf-8?B?SlZFejBNSW15L3p1TEhOVUtLS3FsNGpnRy9VVytUTlRYeHc3MG1aQnYwTzB0?=
 =?utf-8?B?STZydFd6dnZYMUViSzFHVENuZm5aR2NlR1RmbXRCcXE5QWVod1EwMnFoQ2pm?=
 =?utf-8?B?aFU5WVJyd2RtbkVJZEU5T3ErNkZhZ1pyeXJ2VkRJQmhoTERNSE52NjBiUkQx?=
 =?utf-8?B?R2VualhxeGdwT1NSME1RMWt2SVFJZEpjeHJ1NnJ4ZVZMUnJOVVV6TW5GR3Fu?=
 =?utf-8?B?ZEVXaG43Rm8zV1J5dEZpT0pDcXh2UTM0SHpNeVZBd1Jkd0cvRnRlbHlCS2Vr?=
 =?utf-8?B?TXpCUzgyK2NaVmZwWFdlNzdUbEVnYVlpSHllU1dDNWJqNWhzd0VoTTlMbnFq?=
 =?utf-8?B?Q0ZPdXdMcEFUVUZ4MnEyeWRDKzF6YzFYbEkramkrdUhkbHdNN2ZiaXhERFN2?=
 =?utf-8?B?VVJUcDlSK1ZDSXIzRDFPV1lpeW5FTDY2dTdDQThXY2srNzk0VGQ3WjJ1L1lu?=
 =?utf-8?B?NWovMDZieVpiMnNKbmM2eWprUGdVRkRoVEw2WXdoNU9ObUxKQ3YyQURJdTRD?=
 =?utf-8?B?OXc3OEVzM2J3clJad3JKckJqTVdyLzY3U3I0UEV3WHhPQlZodlRVem9ISUdu?=
 =?utf-8?B?ZUY3SXB0amI2bUJmZzMwOFpqK3lrWlFHK0s0aDcxZTVBQTBBS2tUOG5kOXJC?=
 =?utf-8?B?eGgrMUxxVHNHMTNxSS8yY3M0Q3BUZUhXaGV6TVZ4Vzd4SjhTdmx0dk1HUXNH?=
 =?utf-8?B?MlJCWEV1QmRSMEdSbUZOZi8yWWxDTjF4RWVFWU5RejlReDJTbzhYSFZKU1RC?=
 =?utf-8?B?N2ZNd1h6cVZmOTdSRmJLcHdzMTQ2WkhkMjVLU3dxamlJR05RdHVKbmlFTFJt?=
 =?utf-8?B?RmY1c1JCN2JGcVlFV01MOXE1UDBSNUxJYkVVRVBHYjZ5WDJjQ05QUkxwall5?=
 =?utf-8?B?L3dZSzRtdWhGbzlXNnVVT1hVSXBNdVlSU0RwNHlyQkNuQTVCckdJdDlINWEz?=
 =?utf-8?B?TTZheGhTK0ZKNlp3NUNSUDFESXJvQjRjdDZiSndGSC9HK0xiRmVaMitVMkha?=
 =?utf-8?B?enh0MVA3eG1xa2JwQjVFN2tNbnFBRURPWk9udkF6Zk5rMUpDaFh4YW40M3Rq?=
 =?utf-8?B?R3JHWXZrWU90YVlYN1BwcURXUkRDRXJ6a1NWKys5b1JlWS9NWjJNODVBUEc5?=
 =?utf-8?B?ZUZscm5nNHR3REwvd1RKTCtHekpCSElITUEwTE1YRTZCaHJ4UlprWVNra0hH?=
 =?utf-8?Q?2i41fzx/vXVI5b8NRo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6faf5d-be5b-4955-2b53-08df1f907363
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:48:58.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sOb8HuE+mNJClJzNGYQ9LHijpXSrSbUBGBK4xWpaZF7DrLbhnEZLGqvxFaDlOvnKcWNnIbXnkSAojgbKdd88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637

On 01-10-2026 02:32, Sean Christopherson wrote:
> Apply the instructions and branches overcount errata to all AMD CPUs, which
> count VMRUN as a retired branch instruction in guest context.  I.e. any
> asynchronous #VMEXITs during any measurement will result in an overcount.
> 
> Reported-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  lib/x86/pmu.c | 7 +++++++
>  x86/pmu.c     | 7 +------
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/x86/pmu.c b/lib/x86/pmu.c
> index 67f3b23e..3231ce2d 100644
> --- a/lib/x86/pmu.c
> +++ b/lib/x86/pmu.c
> @@ -72,6 +72,13 @@ void pmu_init(void)
>  			pmu.msr_global_status_clr = MSR_CORE_PERF_GLOBAL_OVF_CTRL;
>  		}
>  	} else {
> +		/*
> +		 * All AMD CPUs overcount instructions and branches retired, as
> +		 * they count VMRUN as a branch instruction in guest context.
> +		 */
> +		pmu.errata.instructions_retired_overcount = true;
> +		pmu.errata.branches_retired_overcount = true;
> +
>  		if (this_cpu_has(X86_FEATURE_PERFCTR_CORE)) {
>  			/* Performance Monitoring Version 2 Supported */
>  			if (this_cpu_has(X86_FEATURE_AMD_PMU_V2)) {
> diff --git a/x86/pmu.c b/x86/pmu.c
> index b262ea59..35f8a818 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -222,13 +222,8 @@ static void adjust_events_range(struct pmu_event *gp_events,
>  	 * If HW supports GLOBAL_CTRL MSR, enabling and disabling PMCs are
>  	 * moved in __precise_loop(). Thus, instructions and branches events
>  	 * can be verified against a precise count instead of a rough range.
> -	 *
> -	 * Skip the precise checks on AMD, as AMD CPUs count VMRUN as a branch
> -	 * instruction in guest context, which* leads to intermittent failures
> -	 * as the counts will vary depending on how many asynchronous VM-Exits
> -	 * occur while running the measured code, e.g. if the host takes IRQs.
>  	 */
> -	if (pmu.is_intel && this_cpu_has_perf_global_ctrl()) {
> +	if (this_cpu_has_perf_global_ctrl()) {
>  		if (!pmu.errata.instructions_retired_overcount) {
>  			gp_events[instruction_idx].min = LOOP_INSNS;
>  			gp_events[instruction_idx].max = LOOP_INSNS;
> 

Commit 61a7ee521d ("x86/pmu: Handle instruction overcount issue in overflow
test") makes measure_for_overflow() always return 1 - LOOP_INSNS (-10000016)
when pmu.errata.instructions_retired_overcount is true. For runs without
"perfmon-v2" on a Zen 5 system, I see that the overshoot from this preset value
is between 125 and 135, which makes the following condition in
check_counter_overflow() fail.

	report(cnt.count == 0xffffffffffff || cnt.count < 7, "cntr-%d", i);

How should we handle this?

Restrict the condition in measure_for_overflow() to return 1 - LOOP_INSNS
if (pmu.is_intel && pmu.errata.instructions_retired_overcount)

or, accept a larger overshoot.

diff --git a/x86/pmu.c b/x86/pmu.c
index 35f8a8183a..74e30b149d 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -584,6 +584,8 @@ static void check_counter_overflow(void)
                        else
                                report(cnt.count == 1, "cntr-%d", i);
                }
+               else if (pmu.errata.instructions_retired_overcount)
+                       report(cnt.count == 0xffffffffffff || cnt.count < 150, "cntr-%d", i);
                else
                        report(cnt.count == 0xffffffffffff || cnt.count < 7, "cntr-%d", i);
