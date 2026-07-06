Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2673AFD01
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364394; cv=fail; b=Q3ktoEBONHADCjrlEkw1CT4MSRk72fHWmWi6vpBg8W3wA1cD0S1UbIMrGpGiIHkipQ1ReMkNHqf6o2TsgS4Hfk8IQYkNE+Eb09hdOiI7B2EmPOnWUXBk6Bfa01uRK+g8stIPHaBcblw9iRt/VQksoUaT00/NArjUk0gHJuxvISQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364394; c=relaxed/simple;
	bh=IS6+xc8TrE3P1vMmiaGyIAE0A/xNAbOOvp1lzuRIT3M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K4Emvcr3uAbAvThaLQuw6QXJKugEVYq6joc+5gdcWStiIJWFMaMh6L/4jl6yBIEZIFCRYFwecapvVlyoMobu86xLNPg+O5nFT3oT6mCKhNS3fIIUhAU9idPzCo53uGpJ1+8guzExOUlV8MKjWQxe9YZB7SGzJYrYGdMUwHH3h2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gKmVEvPS; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gKmVEvPS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEltd0HxFtsb8Rh8gOdDjwEa2WcZ2GECq80RmB0aQ+UiWNbsctCfMji2uTh7fCdJKPA849U7cBCEu30WSYlGE0tkL+7+X1+sFBzdZ/6+UT3b2IQswmrrHXt+rgFmSsD2GGAr7WZZt0J8xDb4NLYkoa9bnFmZ6ea80Q97bgAEVYvWSuQ10tBXRkM5AN+FzA8Qz42140HTw9ldravRQbV3IMFZXOcgDvxZHDJ53gr6H0I9Y3L0nORCLUjlhEqFb7JUrnVMRZy5v8NSjkDznSggxDmnPzp2dVOXGwAMxyE9+FAUzuZeC8TWP8zDZNq7OTtGh50x29fZ3LK0FxQXb2W9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr9gtarAeAIR4xRQa+Ka4S8yWapVP2Uct4iWDXGJ52E=;
 b=N2/2b2XpnX4nTig4pk5Bfhkjlri1jtuxGdLzIXYbk+XpIDGeU7b9GvKnEhL0gXZaplVKrYPi6OwqO83QySWO4+o2dS/dsD3RhTIBHMFS2f+uOla0f9GmNqDAjM9o7DR6+p0h0r7LV5i3MLFa2q8W+BDh0ITtStxxgG990KbIHns54SXVx/X8WO+OsdfJ6QQjJLN2cHfaEd60CoD5RdCQtjxD37hf9j5lEZLorwbHMNr7yneoZ43NVVETj0FA7JGho3IRwHbdHeX2/uMz5CaTQrutXMVr4IWCuDAFBbQxbx9rXQZ9JRkNIl/85WilN1pKHN8uv/dTGHPgutLejl98wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr9gtarAeAIR4xRQa+Ka4S8yWapVP2Uct4iWDXGJ52E=;
 b=gKmVEvPST7Q9ulinEo4cZX1qbzQNp4EYfR9Pn6N737iFu4CFTjzqOzk8zQ5cKtK1L4QMbSDhGhAoEm1ciLBX6U4zzjgEzHw9xNk7pj/N/0lAvZhbRKjBtItJaeZPOrpCswhnjoCLglsZaqFg9zkMZ1zAat/QWHswVjovvu7PJN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 18:59:50 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%7]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:59:50 +0000
Message-ID: <28e2e7c6-8ca5-415a-b5ca-6e872a32ac9f@amd.com>
Date: Mon, 6 Jul 2026 13:59:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/6] x86/sev: Add support to perform RMP optimizations
 asynchronously
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1782841284.git.ashish.kalra@amd.com>
 <ada64cdc976b98a70687b3a347bca0c25c89eb09.1782841284.git.ashish.kalra@amd.com>
 <20260630182808.6860E1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260630182808.6860E1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::6) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b09364-dc2b-4416-22c9-08dedb90c150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	gdENZBx8DAV2pCA73MjnEwKDflcwp7SVbQGyCiJg33eLKyHdwZ2/0dsSmn0eZ3jOLfOGgM9C4RT3Mi9advtIOg5GCK6upCAoxcr40+HADO5M0vi04xtSB9Kjk5kl/W+KLj4GcSUoF87DIzoA9/DNvllUSvwd4ee2m1Vpnc5e4mwfv/q1UjpZajjD04/VjsqzfK9iMCzSoyONsi1dZpFSJNWVP3WvRCxoQb/d2t9KDnvnoVJNg7hRagTU+Ix27Tr4pEhtqdHAgF5Kp0pMJOk1yV+i43DFqr+F80z/G4tYzSt6mLqRVsoZJk0N9gAZNZc1kn4GocTu0tUxMbryF6YOABGKpNkegSZfsYw+PaP02lOmgIUTTsqlSjP6xBw4WVupQvi4uLUuj077lVB1TpSWCpGCtubkHYcDEgRWtC0fv20Zhau7TnY3mY7PBqZkCIsMYmz2l7jb1CQSu2aKdAt8V+kfSlAMHLil9Hr4r3mzfOhUsLP4xMPebXgg1R+VDmd4TbD4VRA+0y+K8qFOjhA65r/L+U3op6dTRwt5LXgSZzShY7fud7B0carQ1JzsVlsBHJFT5pZ6FACy/Tzt4tfgAGF1/FJ2S88Yexs2Jpiv9SR6ISA0GDGBkQSU6UlS6n90iM8975kzg6gOJQCIIJqgnairHcEvEa5jW5kjtnMjfuk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0g5L2JiTyt5bHdsc3RIRFJkbkhnLzRiKy9za05WMi9iTEZZSFhUYkgvRi8y?=
 =?utf-8?B?UHZVZXliZkhDZ3BXeW8xRXVJSW5SUEwwcWtvRldSWWRudHp1d0VBNUp4ZVpV?=
 =?utf-8?B?U1VtL3hNQjdpOUhvRFp2Q1dwd3RFMHpsczNaV09qRWZGYlgvTGM0VUJZWXJF?=
 =?utf-8?B?SzJaTCtrRkhVNXRNSzJhS1JmYVdWZWc5Q0Y1VzNRWUpvZVZFaFUwSEVMcGRS?=
 =?utf-8?B?NW9ESm5TT0tIZXo1MUJyOHJBRGl5blc3Y0tRTzNXS2xtU3ZPeWM3L1Y2STJk?=
 =?utf-8?B?dTZaU0tvRVR6cnVvWG1CK1dSY3JEWXdiUVN1bTlNOTJkMHFCUllDUjJqUyt1?=
 =?utf-8?B?WVh5MFpHdmxnemxyZnE3cWNjcGlJUXBmWTB4aFJITjJOazhNTVVra0hoVGJk?=
 =?utf-8?B?V3lxVmNHVG5kUHZGMndwcHcvSHhXM1JDRXRuYThzNDZoajFXQzAydy9wR0My?=
 =?utf-8?B?a3gxVVJDbkh1MzV2V3lBclpabExLbkhhUFVoL0tEWU1FWEYybDQ2Nkl2WEhB?=
 =?utf-8?B?YXdSNWZDcUxrOGRRN3I1TStFSWhZM0xRMEh0Zy84dHJNNE92SkJsZmcxQnJu?=
 =?utf-8?B?SmNvU25IdlBIbVdibmpJVTZUNkRBb2k0NlhPTEI0RnRqNUxlOU1tdnNGWlNa?=
 =?utf-8?B?bFFiL2R5amxHWGgzMWRnYTdGTEw3alFjVkwvdU1XUFFXMFozTURVWFJFWEdS?=
 =?utf-8?B?a2pOY3IzTlZGQjRvdVhPWC84Nlh0b3NLTXRMMmt1NjBJS3dtTFVuSUpiMklX?=
 =?utf-8?B?OGljYVBUbEJYOXZUTjkyNHdKVlN5ZmpaM2FDRXlyMFRrbWlDMmVFOTZvRWdm?=
 =?utf-8?B?QXIwRytwaG9RMDlkQ2Nzbm1MTEwxOC9GaGh6WVRKeHlRbUtST2Ixd0gxQWhl?=
 =?utf-8?B?WmtFZER6TFhiTm1kN1pnb2puNU85OVZTSGNCdXcrTXVxbTY2ZFhwbTlqcDNP?=
 =?utf-8?B?WmpFdHVWdzhBN3ZMYU9Nd0dxT2drVHdyUEFKclZJNTMwcDRxWlhBN29DTmpm?=
 =?utf-8?B?TCt4WGs3QnFTVDl0aEtMazA5U0R0T0U3SmpHNGtoR3FhM0FYTE5tRTc3ZTdp?=
 =?utf-8?B?MytzdDFxaFVJN2dSOTdwRnR5d1ppQW1XbUNmVytSaEYydXlqQVFFYVJxMHZx?=
 =?utf-8?B?TGRsbkthSkorQVAxZ012UTFUWTBwV0kzUTFBQzR5L0N3STFBMTVsblRUbEhF?=
 =?utf-8?B?S0p5cXRTQ3ZOQ1dwOE9NbDMzV2hobnhVbncxRWwvOEhMa1lnNUVGaEpoM1Nw?=
 =?utf-8?B?UFVhSlB4NFRtdEcvdGVvcXpTOHhPWlRZR3M4TzR0NURMOWU3dVRXOG4vTE9Q?=
 =?utf-8?B?eDNmSyswSlFXS2RvK2o0Y0cwYms0QVRCSi9uTDFuZmh4SW15enA1QnJYdFpr?=
 =?utf-8?B?VVNsVS9VRU5OVDNhbW56eTJiOEFiRUk1enVTMkErVUtiaDdqUTNwOWY4WnBD?=
 =?utf-8?B?VTBhYktlUW9ZUVhFU0JxVW54bTJDWFY2WFA4Tmh5amloWTZ2MVh1YXRPbHQ5?=
 =?utf-8?B?cDRjcCtMU3EwaEp2M21GQXVPUmF5dUtSWkRBSmJySWFFaHp4UHdqRXlUb0li?=
 =?utf-8?B?ZUJnUnBMMlN5bkZVV2tiU05Nc0FjdkdRa0JocnlUN1o0aVQ4YmNDS3hKd2o5?=
 =?utf-8?B?K3N4TjArblhBZ0hIWHB6OE5VeE5qNmNUcDMvaTE1OTNQbmNRZlYxdUkwV0Ni?=
 =?utf-8?B?dzVGT0w5MmNKL0tsSWVYSGFWM2ZhZXJhRkxPUFNDUUtVODVZM0dtOTMzb0NB?=
 =?utf-8?B?dWxmZ24zbkNuK0lUYlc5Vkx0bHBFYUxob3RoaklFN0k3MFBLa0h1V3NwbHJE?=
 =?utf-8?B?UU51WUtWOGZ5S0Nhb3RzU1VKdzNza2NXRDZ1a0hFOS9VU2FVa0xGMVV6YWNZ?=
 =?utf-8?B?bnVPRmVRc3J5ME9zcDVyaENTNnhtODZOSlQvRVdZZmErQ3hMYkhydXFqU1I4?=
 =?utf-8?B?NzdZa0Q0Y2tJeGMwdWV2Q0U3WXBGOU1lQi9KTVNLNS8vL242VzE5ZVNTL0d5?=
 =?utf-8?B?TEIyRWJHaDZWRnJUT2pwSEI0UTMyRW04dmE2MVV0UUkvSVY2ZFRKd1JQUUxU?=
 =?utf-8?B?QzdEZlZ1dGlZSWEvZllReFlEZ2lBQkpuWEpKTUlvWHpqaEEveTAvcTRwaGRE?=
 =?utf-8?B?eG0rTFF0QllQVEFzNEVPMngyMm9RRWEzUEZNOHdKMlV5YTJqNFo1RFdqd3Fy?=
 =?utf-8?B?Z285WW9GZFFlTytXdDRpYXNEdDNsUjlBclhuWWlRQzRGa0MzakRJY0JRbnBj?=
 =?utf-8?B?SWFObHNuc1BaS1FNSjcra2UvdWZzNnE0cHFNZGMxY0p6ZkZGK2xwSkF3ZG1h?=
 =?utf-8?Q?OLhUuNqaRea3iLIB0n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b09364-dc2b-4416-22c9-08dedb90c150
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:59:50.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqcXWZJ1ITGSjTg9Ps+SHio+NoaxeoL8fSVaby0xncVhNuuTXkkojsbKKLMA27iweohlwRa/icxE3NeydluWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194



On 6/30/2026 1:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Re-initializing SNP after a partial shutdown bypasses the RMPOPT optimization pass, leaving the new RMP table unoptimized.
> --
> 
> commit 2d85f8f029da9849b60d0154807adccc997f6502
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Add support to perform RMP optimizations asynchronously
> 
> This patch introduces support for the RMPOPT instruction to minimize performance
> overhead by skipping RMP checks on 1GB memory ranges known not to contain
> SEV-SNP guest memory. It adds a dedicated workqueue to perform these
> optimizations asynchronously.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 04a58ac4339cb..40b06e959ee87 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> 
> [ ... ]
> 
>> @@ -625,14 +743,42 @@ void snp_setup_rmpopt(void)
>>  	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT) || !rmpopt_capable)
>>  		return;
>>  
>> +	guard(mutex)(&rmpopt_wq_mutex);
>> +
>> +	/*
>> +	 * Guard against re-initialization.  When SNP_SHUTDOWN_EX is issued
>> +	 * with x86_snp_shutdown=0, snp_shutdown() is not called and
>> +	 * rmpopt_cleanup() is skipped, but snp_initialized is still cleared.
>> +	 * A subsequent __sev_snp_init_locked() would call snp_setup_rmpopt()
>> +	 * again, leaking the existing workqueue, delayed work, and cpumask
>> +	 * state.
>> +	 */
>> +	if (rmpopt_wq)
>> +		return;
> 
> [Severity: Medium]
> Will this early return prevent the initial RMPOPT optimization pass if SNP is
> re-initialized after a partial shutdown?
> 
> If a partial shutdown occurs where rmpopt_cleanup() is skipped, rmpopt_wq
> remains allocated. When snp_setup_rmpopt() is called again during
> re-initialization, returning early here skips the queue_delayed_work()
> call at the end of the function.
> 
> Does this mean the system will run without RMP optimizations on the newly
> initialized RMP table, incurring RMP check overhead until a later event
> triggers a rescan?
> 

Good point — the early return skips the initial optimization pass on re-init. It's performance-only (RMP protection is unaffected) and self-heals on the
next SNP guest teardown via snp_rmpopt_all_physmem(), which re-optimizes.
  
In practice this path doesn't arise on RMPOPT-capable platforms. RMPOPT is supported only on newer platforms, which use the x86_snp_shutdown shutdown
path, that calls snp_shutdown() -> rmpopt_cleanup(), which destroys and NULLs rmpopt_wq, so a subsequent re-init re-allocates and re-queues the initial
pass as usual. The partial-shutdown case this guard covers (x86_snp_shutdown=0, rmpopt_cleanup() skipped) is legacy-firmware-only and effectively
doesn't occur where RMPOPT is available. So I'll leave this as-is, the guard just prevents a resource leak in that unlikely legacy re-init, and
correctness (and, on RMPOPT platforms, the initial pass) is unaffected.

Thanks,
Ashish

> [ ... ]
> 
>> +	/* Limit memory scanning to 2TB of RAM */
>> +	if ((rmpopt_pa_end - rmpopt_pa_start) > SZ_2T) {
>> +		pr_info("RMPOPT coverage limited to 2TB; memory above 0x%llx not optimized\n",
>> +			rmpopt_pa_start + SZ_2T);
>> +		rmpopt_pa_end = rmpopt_pa_start + SZ_2T;
>> +	}
>> +
>> +	/*
>> +	 * Once all per-CPU RMPOPT tables have been configured, enable RMPOPT
>> +	 * optimizations on all physical memory.
>> +	 */
>> +	queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work, 0);
>>  }
> 
