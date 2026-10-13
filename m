Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2363A1A21;
	Tue, 13 Oct 2026 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853786; cv=fail; b=FIwl1UXnriWtNaM+M7jvzmNct4DlCWAnwm478cF1XpG93BEbyPYsoqEyVDy3wUo3yr3DCQvefiHwZL5ivrUk5lTD7SRlWwzhhFgO9V7NncsKcy4njHxpzlLWD2o3dLiKr9usRnH7mkJ9h3V1IxB53dXN/02RS+msN3w810bUlc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853786; c=relaxed/simple;
	bh=BRxq4iay6rSjTmhgkY1XbCTQY/c+i7k3SrDLPraaRNM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/n7+MqcOQgy5j1hqb2oUbZL6zaLIT3q+YNC3XZs9N9BjkvYHLzAYMIWVPqzmt3M+tCpEgIdsm/36AyPQ69Qh0uuhLR9zjtdV4bDtsBP2gtDElJi++6w4VvRWkJ2FpUXKxMVB4z4DprQ9e6q0XQsIGXHowwymZH6vmijJHkBNnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cg7gIHfY; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cg7gIHfY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWS+Q4YTz2RuPe+A8iACJ4a8dpkjmtkEBzQ08L4YIrRppsvO0FcXjETG4JwZWJDBkODGjG6IHbgg62aHFXUUnZGzTRyM01fUNa5n4y8QxaheyLz4n2gV55JlaIhzl5YcbLYGnRdYiqXH3u6beVvo258Q6czWOox5rV/xsWVtJURiD4enfnOiYqDXdmD7x2QGelghxljnZqqU++EPW6QtO8pOsMpKICkzMAeMraszRtPxP3xGkIb+o6qKxuZmd+v7emMZEFtsPoyIXNyCmBrCrRACNqEY3gBiT3IGXqoIIyKvS/ZM2T8mLFi6WMOT68l/rRRXTG/HlBFIxO3T2YA07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFuiQbsFXY1ajRwpfJdslDaXet7BCIrC8H6A1yEye/Q=;
 b=ayBOXs9Lj61DCl+UcgI8c2E7qVCMcZon4yShVAwJj1qAtd57IVsjGHyyX9h7PGyass101JbCn9cQdEJomjl17QNx2cgeFSkYyNGMcmVM2Xef32aFgrLBI5zdqr6JLW/b4rBXZ1wMkVn/1Q2jZSq7xwVoKGTdh+WbaqSnw6HTBQrUiesA0qjjtAM6HRnxevv1FuJnEOp/jlcMzTZh7gVNA4PoPR7v+/+ZniwgQz+2lcN+xZDZ1dGy3ISEhzx1xdWaJjQiyVvn3nPhjYcANa2hDrAZF5r5KSCxDO/Al82/F3sVwrzRz232QtjHpXpjC6JnD1SNB5BW+49Wdjiox7vo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFuiQbsFXY1ajRwpfJdslDaXet7BCIrC8H6A1yEye/Q=;
 b=cg7gIHfY2P9+ZNQN6fg+JM9iBkpHxl5PJc/15ZAw3ym+2oBV/KzWmFe+31kFMvPutISNmHQ1fh8NztE3EhMbPCOk3bOp2qOOALAPAs6AEndpHh1/ffF/0WmIqPuRps51oLqLcUxemLO2NzjjVmns0YXw38u6yrGPUAMq9IWHZjU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:09:42 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 01:09:41 +0000
Message-ID: <6e0280d9-88e3-459e-893b-80bc9f6cdc31@amd.com>
Date: Mon, 12 Oct 2026 20:09:37 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <fb62d29c027514fbd371bd932f098d119625acfd.1791589412.git.babu.moger@amd.com>
 <f979d477-9beb-4e24-8e51-4a5cbaf75aa4@intel.com>
Content-Language: en-US
In-Reply-To: <f979d477-9beb-4e24-8e51-4a5cbaf75aa4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:8:44a::12) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc07600-483f-462d-8db0-08df28c6a932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003|260925021911599003|260925021311599003|260925022911599003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	Jsx4SB9TVs8MbxRMo1/3iizpZkRP/Cvgmt1uymLqGF0jg8nbMLMuuJYCmXdTi2KSNjJe52JPrzeOlwe5Yv/Wt7wRyqOOdjlimRAUC7GsdqheQwSx6duFQW94DyYk+PTDTEyNcn1/FLggMi20DC0Yq1It7Ze4FZew4ERDqYZ5ISU+qAxbdbWtcP6q9OOgsEE3+vZh2D2e+cI9ODJmtMYmNc6QJJBBqmpIZ2NmVIGZEYbqwbr/1GeAs7ZLl3hr4EFbM6wRfUhZRPttqTS1L1mWk7MaK0mH9eX4EaR7wYnwQKHAj5ads0QFh0M/fYHb6sAlnimajn8b3GXizaF3CGlj/L06jNEVM0Nu7d3tLnNS75PZkHCAlUr1zFUVyU4mKrokeD+V+3hrFXgu2CxbJ5jjHECATzAzMyfq/Fi+wg4PWN0U+WmN40MBVcCcDhcEd5jJqaXCbkGNbCfdv70fJPiPfopO/9+/4v0O7v33agr8xdfFffF5+5xKCmz9jwo4YFvMvF1Bctu2aATHQzFOj+9t1dEd6NenKiRBVOXh6uv7JQjE+5jUUTjFTpa+rYJtVSIehboctcJ55pNN8Hzsr3lqSY6jrnnktTr9ObjJonO+PW7wARzV0iqcz8mxUzV9xAIIbrmTFL/Knla0FnqdE+pB6qVHGG5Uxb7Wq2oU1c0vvRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(260925021911599003)(260925021311599003)(260925022911599003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlzVEdoSjNHZGN4U1g1L3dNUHZFMTREd2EyTEFnSmlDQ1RJdnhMTGwyOEdU?=
 =?utf-8?B?clRQOXZlUHhnVExkZlpuVGhyNktXUTIyelhuVHRBNC9xSlB0THlCMXV6dngv?=
 =?utf-8?B?LzdkbmFYbDV6cDhLdVEwV2VqY0EzS2J2V1hBZFNzd1c0N0Qxc0s1SllEZzZU?=
 =?utf-8?B?b2VnTWdZTTJUajc1T3RvR09QL3gzcm9oQVVEMUVveUhiQWJkTWZWb0hpTVps?=
 =?utf-8?B?NGlQc1BtOE9OckpyWWpyQTB3OHhzRk1BM0dMMTlEbFZPMDg4UnViejgyalQ4?=
 =?utf-8?B?L0htOVhaT2tld1dpcm0xYlZtdDV6N0lkcWE4QlNWbGlCY3JVNWN1YStTZXJV?=
 =?utf-8?B?SDdNM3dVWXFCTWQzRHdOODlFK0x3cGlrVlFwajZXaDI3VUVsYys2SE5ZajlD?=
 =?utf-8?B?WUl5Ulp6MkRpbFJqcWM0aXptbm9TSjIwcWdKRFVhVnZPd1RTMURYWE5MQm9B?=
 =?utf-8?B?NUUzNUFZeVRoazZyTEV6VzVmMXNUazg5K1VOY3U4WFhSOFVwTkhDTk10Unpy?=
 =?utf-8?B?amthWXlJbzJialRGZ0dKbEhHaFFQRWhPUGxlanQvUHFGRGlyQmFRRTlMUlFS?=
 =?utf-8?B?YUVmWTRXdmVDQjVhbjNYQnBSZ3c5czg0dlEyaG95V0NlRTJEcG9TSUZjS2lj?=
 =?utf-8?B?Zng3L0YzRGY1ZzExeUlqSXlteWRNeUZBUkxMdVNtY1hpeFhXemQxcmhZd0N4?=
 =?utf-8?B?MUgzVS9WcnhEZWpWN1Rmd3MvL3phZHhnbzNTY0lxNkJxcjZZVXRSZExFelJT?=
 =?utf-8?B?MXZ5eG9hUlFpM1J3ZmlOcE1YWlNobDE4WklFYVlLNHJ5WUVnM0p2YzZXQ0xS?=
 =?utf-8?B?UGtCWWdnKzF1cmRZTEUxZk00TlBZcFJYTHd2UW5ZbW1KZEVnTzlwSE9BRnVX?=
 =?utf-8?B?dG1ReW1vN0JjTGtJVDB4MWpVT1VYRGtjeXBJM0FNZWlBUlViWmpQYkZWYmti?=
 =?utf-8?B?d0tBVWlOdC9FVkcxR2MyVG84OGVDTkdseHpMN1FMOWNIa0JDR0tOUExsNlpt?=
 =?utf-8?B?ZXVNeTNRMFVieVRhSWdJb3ZURU5YN0VEbjZVT2hoczBZTUIwQVdOTTh1Ukx5?=
 =?utf-8?B?R0JzOHJqN0RYVFVGSWxzYllYMDUxQ3l1bVdnUGxRSmtRMWpUeEVrZVRsYlZx?=
 =?utf-8?B?UW9TaWJTTTZNNDFJeGtvdVhQNU83N3dlZkhYSC9lMk5hWmtlVEFPcE5SQ0R1?=
 =?utf-8?B?WnlsTStxQlg1Q01LRUVYaDRQREcraDVQb213R3FGbDNSeDlBS2lkQWErZWQv?=
 =?utf-8?B?bTRYMm1pUWdLLzZSOFNDcWpHVkdXVm5BcXQzcnhwbEpzeDNFVFZ1bkZEVWR3?=
 =?utf-8?B?UU1kUFUrMTdTZGlxY0ZpQ2dWeVZHWkIzMW1Pd3Y0bXlST3ZUVkRLc2JGcUZD?=
 =?utf-8?B?S3dpTFd6WjZsVlBLVzZJb1g3ZjQwaE51enBldDl4d2I2R2hTaHZZT2pRUkZV?=
 =?utf-8?B?Y1BrcEdHcm55WHJyS2dEbm1KUnlpQThrZzc2NGZrTThQd256T0VraVNMUDlO?=
 =?utf-8?B?ejMvUVM0bW12cSsvMWFuaTJJWHNacmRMbHRMMzFwa1ZJdzNFTC9KQ2JGUmx2?=
 =?utf-8?B?cXRaN2pLcldqNGdBamN3NmNBd0dVZWpVUnNLRzJlUGFCZVN3OGtEYWhSVUtC?=
 =?utf-8?B?MUs3YTB2ZnhUMzNrd3N6Q2tENTc1TkFCY2JoOGtlNXp3SlVia01mdERHRW9C?=
 =?utf-8?B?TWJLS3BobytQSStJTGJhalk0cE9NeERaOWd2YTVkYTJKd25TRDRraHlmZ1VH?=
 =?utf-8?B?SHY1dEhTV2RiMkYzOHBHK3ZDU0NEcXNLYVllWnVZdWxtWEhDK3JGbTk1b29U?=
 =?utf-8?B?SHIwZncvbHM5QXhxWklNay9TczNOb2l6OFpNVUcyMVVqNm9XUHd5anE2UkJV?=
 =?utf-8?B?NXpXVXVtNE5Gb2tQWGlFYUpsUGsvSWJBTTBSY1QyQVVleEh0WEZPYnhVR3pY?=
 =?utf-8?B?MkM5Zkl5ZnNjdzREdkRuREwwWXFPa1BZVjZPYUFYU0xTbUp4U2ZrV0FaNksy?=
 =?utf-8?B?T3VRdzFIVHZuT29DS2U0Rmh4bzJpSFFkODJYL2prczhRUENoYUhUREIzaWxv?=
 =?utf-8?B?dUgwOElZSUpBc092czRLUmR1amNWNHc4ZHhGUlRQaEV4cm05ZzRrb2lXbm5n?=
 =?utf-8?B?L2J2bHZXRkM3NDJva1NyaWwvWjVtV09hMXlhc3BFV2ovc0pWU2Fydmp1WFRX?=
 =?utf-8?B?TDEzQ04vQjhrckNoOFUvcXlNNmx5UjNQVVh2WDZNRXN1VVJOWEVjVlZjK1dL?=
 =?utf-8?B?a3Z6Slg3b240eTdzMHp1VDZ5ajltSFc3YTNFTnF1UjRZaktyaHJ4NnM1U0cw?=
 =?utf-8?Q?fTkFsJGgByBKcvn/wt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc07600-483f-462d-8db0-08df28c6a932
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:09:41.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3yxFQUN+XCWEL7j64KpMq0McuJRWCBmMvEnucu8zkQpNAtIJV/bPaIPiMw14GBD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

Hi Reinette,

On 10/12/26 13:47, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/26 4:44 PM, Babu Moger wrote:
>> The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
>> It is intended for deployments that need to manage counter assignment
>> on platforms where the number of monitoring groups exceeds the available
>> hardware counters. Hardware counters are scarce on these platforms, so
>> mbm_event mode suits workflows that monitor a subset of groups at a time
>> and rotate assignments as needed.
>>
>> resctrl enables the mbm_event mode by default on hardware that supports
>> it. This breaks the pqos tool [1], which assumes the historical default
>> mode. It creates 16 or more monitoring groups and uses two counters per
>> group. On a platform with 32 counters per domain, that exhausts the
>> mbm_event counters pool, causing additional groups to read "Unassigned".
>> pqos interprets a non-numeric event read as zero bandwidth and reports 0
>> MB/s for those groups:
>>
>>    $sudo pqos -m all:0-4
>>    CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>       0        0.69         16k       192.0         0.0         0.0
>>       1        0.40          3k         0.0         0.0         0.0
>>       2        0.44          1k        64.0         0.0         0.0
>>       3        0.39          1k        64.0         0.0         0.0
>>       4        0.43          1k         0.0         0.0         0.0
>>
>> Leave mbm_assign_mode in default mode during initialization. Default mode
>> uses one counter per monitoring group. On existing AMD platforms, the
>> default active counters pool is 64 and may be larger on newer hardware.
>> The active counters pool is the number of counters that the hardware can
>> actively track in default mode.
>>
>> Deployments within the active counter pool receive accurate bandwidth
> 
> nit: "active counter pool" -> "active counters pool"
> (to be consistent with all the other instances)

Sure.

>> measurements in the default mode. Users can create more monitoring groups
>> (4096) than there are active counters in the pool. Beyond that pool,
> 
> Unexpected where the hardcoded 4096 comes from. Could this be "(for example,
> 4096 on current hardware)"?

Sure.

>> readings may be misleading or report as "Unavailable", with no user-visible
>> indication.
>>
>> Default mode is still limited once the number of monitoring groups exceeds
>> that active counters pool. After hardware re-allocates a counter, a read
>> may return "Unavailable". pqos still treats "Unavailable" as zero.
>> Successive reads can be a count, "Unavailable", then another count. pqos
>> treats those jumps as wraparound and can report an inconsistent rate:
>>
>>    $sudo pqos -m all:0-4
>>    CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>    0        0.76         60k        32.0         0.0         0.0
>>    1        0.45          1k        32.0         0.0         0.0
>>    2        1.57        107k        64.0         0.0 17592186044184.9
>>    3        1.62        276k      4928.0         3.2         0.5
>>
>> Users that need stable measurements beyond the active countes pool should
> 
> "countes" -> "counters"

Sure.

> 
>> use mbm_event mode and rotate assignments as needed. Enable it with:
>>
>>    $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
>> Closes: https://github.com/intel/intel-cmt-cat/issues/311
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org
>> Link: https://github.com/intel/intel-cmt-cat # [1]
>> ---
> 
> ...
> 
>> ---
>>   Documentation/filesystems/resctrl.rst | 43 +++++++++++++++++----------
>>   arch/x86/kernel/cpu/resctrl/monitor.c |  1 -
>>   2 files changed, 28 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index c8507580474a..a896bcae3319 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -354,8 +354,8 @@ with the following files:
>>   	::
>>   
>>   	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> -	  [mbm_event]
>> -	  default
>> +	  [default]
>> +	  mbm_event
>>   
>>   	"mbm_event":
>>   
>> @@ -376,20 +376,35 @@ with the following files:
>>   	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
>>   	assignment states of all monitoring groups.
>>   
>> -	The mode is beneficial for AMD platforms that support more CTRL_MON
>> -	and MON groups than available hardware counters. By default, this
>> -	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
>> -	Monitoring Counters) capability, ensuring counters remain assigned even
>> -	when the corresponding RMID is not actively used by any processor.
>> +	It is intended for deployments that need to manage counter assignment on
>> +	platforms where the number of monitoring groups exceeds the available
>> +	hardware counters. Hardware counters are scarce on these platforms, so
>> +	mbm_event mode suits workflows that monitor a subset of groups at a time and
>> +	rotate assignments as needed. The mbm_event mode ensures counters remain
>> +	assigned even when the corresponding RMID is not actively monitored.
>>   
>>   	"default":
>>   
>>   	In default mode, resctrl assumes there is a hardware counter for each
>> -	event within every CTRL_MON and MON group. On AMD platforms, it is
>> -	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
>> -	events between reads resulting from hardware re-allocating counters. This can
>> -	result in misleading values or display "Unavailable" if no counter is assigned
>> -	to the event.
>> +	event within every CTRL_MON and MON group. This mode is enabled by default.
>> +
>> +	On AMD platforms that support more CTRL_MON and MON groups than hardware
>> +	counters, hardware dynamically shares a smaller pool of counters among
>> +	RMIDs. One counter from this pool is used per monitoring group and counts
>> +	every MBM event of that group's RMID. The size of the pool is not
>> +	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
>> +	much larger. For example, 64 counters in this pool monitor 64 groups.
>> +	Newer hardware may provide a larger pool.
>> +
>> +	While the number of monitoring groups does not exceed that pool, a counter
>> +	stays attached to each RMID and readings remain accurate. Creating more
>> +	groups than the pool can cause hardware to re-allocate those counters
>> +	between successive reads of an event. Bandwidth values may then be
>> +	misleading, or a read may return "Unavailable" if no counter is allocated
>> +	to the RMID. There is no user-visible indication when this begins.
>> +	Users who need stable readings beyond that pool should switch to mbm_event
>> +	mode, if supported, and assign counters to the groups of interest
>> +	(rotating assignments as needed).
>>   
>>   	* To enable "mbm_event" counter assignment mode:
>>   	  ::
>> @@ -1787,11 +1802,9 @@ View the llc occupancy snapshot::
>>   Examples on working with mbm_assign_mode
>>   ========================================
>>   
>> -a. Check if MBM counter assignment mode is supported.
>> +a. Check if MBM counter assignment mode is supported and enabled.
>>   ::
>>   
>> -  # mount -t resctrl resctrl /sys/fs/resctrl/
>> -
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>     [mbm_event]
>>     default
> 
> After the above doc changes the mbm_assign_on_mkdir description still reads
> "Enabled by default on boot". This is still technically accurate, but this patch
> makes it unobservable by user space. Fine with me if you intentionally decide to
> keep it but I would just like to confirm that you considered it?

Good catch. I noticed that a while ago, but it slipped my mind.

I also see that the MPAM driver initializes it to true at boot. I would 
expect that to be harmless.

Thanks
Babu
