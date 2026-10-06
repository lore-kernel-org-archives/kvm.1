Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359136494B
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276079; cv=fail; b=apYQInMxs10jDhm6Mz0IUZTsQmiX8U0o7OuZbxCe7Xj8c88x8ucvOE3bSqVIre++nsksbD+LH6T4gnjvGS4+N23ZTuIa1OEkZJcXrH7LxCUCZFMQehGf1hmbR6d9U9nrzwnxf2jWrp25oz6orXqkx7j0qkzN4JGAugcrl1QzAIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276079; c=relaxed/simple;
	bh=PrqX6s9D3A5qNIxdx1fTrHUw21KHzJNHoGRtjVsTtIs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=py6ikb3T1yNmzGwKzRmSMY5fYKM6+NdG60augbkksM3hX8Tazgsu9gbdl/2H1YHxZ9OY5LVLV3jIvTzcGBCCf0z9vvuBJ48b4MGrZYz10dEDB7hPqap0OGXUbbumuGU3q7YjVm1Ei0VSeLTZBh2DHMk600s3WwY0VR6q4DOUdUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EXurkic3; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EXurkic3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POlj+5J6xZwkevEtdwdUFfZm1wBcTyUOciCHbowFtQzF/EK7AYyONVjVZJZQXcupo1qjhLOXrOhHj1ELQNF/n/7XWtTDmWu78oEPx5rEt67kX8Bvmyb68N7+Tlxs1plkG3qpWB+1kpxk+AAzR1ZCCRFRTgc1OvZgp3weD5MI8gS+po7h7OMwbJSnygQhW4w6fWG7xF/oaaN3IUIXPB1m/J3eYQ9y/vXXwmfcW5FHQTUr5jRZhbAGlJ2JM8HsLhb2WOi8aIOM97NuN0njynQsokCz2xvd9cnFGDFUlprFdBh61W+qfN9U7F+0kqceII62W1pUPSG5GK1clSD8/q7Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXijBlzlcpBK/eniWgQjp5mI8hns2Y3u3xJBFPWgNrM=;
 b=EdxasBXtlDU8uTQRVYj5qeRqfxonwYXb4FHvloxQdLYoIZJm7NwX65kQb/6l7Q9vh/SENJzt13Gv0L+WmPdUVOuUS0GzxQ2jw7prMumjZl+JhcDNa1Yhii5e03TFuikOQDTVk1NG6G8pQdU+SFlIBdj398KmKUdQqA/YqWGchY0xk/q/cn/2KSHx7Q7/isD3nz2YDEtqeDFslnWQn0KK2gqjskWplwYjGq23BXiQPJneQj7tnHkhdAEaczpjIH5wMdRxrO6Fv1juerKg+C5KbDE5PfauFa9xdjWWauzhiC9NY/3GrCsRKDkDdlu+0nbSB60VvvWSLgMy4+37lza6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXijBlzlcpBK/eniWgQjp5mI8hns2Y3u3xJBFPWgNrM=;
 b=EXurkic3YWefSxQ0Nn9Ae+V9JgRU6IwCJMiSGlXKTdvOoI2N2R8SfkPN7RRbDukHY5ksKKI+Y5PT90xo0oYwQsW6nFz2aP4N5AhHsmY8a5IGplFMl7WxTuivu4JwaCb30GReAdpBM76y2PAXx8eZRXL86QNRsaHwc7szy+YsorU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:41:15 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 08:41:14 +0000
Message-ID: <84b5b038-e32f-4765-9d23-9f6ecbf382c0@amd.com>
Date: Tue, 6 Oct 2026 14:11:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
From: Sandipan Das <sandipan.das@amd.com>
To: zhao1.liu@intel.com, Dongli Zhang <dongli.zhang@oracle.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
 <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
 <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
 <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
 <502e4c1f-3f5a-462d-87c3-076612935784@amd.com>
Content-Language: en-US
In-Reply-To: <502e4c1f-3f5a-462d-87c3-076612935784@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::6) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: 150f4230-eb5d-4dd9-3528-08df238594b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DuLgQaJiPfKIoh++g8rIZKzRcXhuNyD1BMTs70Uc9AZ3RGzqukM4RvPM6/pg1/cbVSU6mKfICjr/r7d5zhGZgXepLHZw6VVM3C8Xzj2Qq+uE4ghlpGuJeJO3kiHt2uZ47z3bk2SnKAOPDTSc03pJuZ5e4C9xSttpOXmDPXC1/isV/W4WykOz3z0jXKygJcJJ/ylyF3ZmSv8PNjW8DRXNm3uB88LcMqRHrm+oYFkpiXZQK8Yn0spQfyFQdi5UwxH6pX099WNHuvzK5XD4vnyz0MejxMGI4R+gyqNM4rVdKAm4ezWIjUVpeLPkZN1IZghys0TOx0TGxF5zCfhf0rmcsBiGZVl9Pszq8ZL/cm7FB8NeI46wPnh/HS3yLiXK7sIZtegnyK+VE5pdISIcdOXFGV8tmTvsSIN5jQetu8qTB2dqICYWqRGWSdQ9jXG4J7+fsiYgkI95C9CbQs+gnR4HbnHyiC8pPo4bi5WqkHRekQXofpk6aRa6rk4+OK+wnQffDKJMifSBIG2EKaAKupamYS+J6ErGDuhELx9kQLCRFWuSvb9jAYI2czwD4AmLFFUOfCdgncHAIRLRlS1UPoBY0878xbpSKuxTzpBMEwVsy+NViubIu9X08SECDGpw7HvP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGwzcXdYU1RSZFhJeXJPMzcxM3k2Y3pqM0dHQTdES3U0K2NmL0owZTFwSm5M?=
 =?utf-8?B?VW9NRitWcThiNXdPVERja2JIOEd0RnZROFZmeVVONmJzTEV0SVdxS015TzNX?=
 =?utf-8?B?aXFXR29XR0RONTRuMHNnMS9BcmNnNUlLUjZPUXgrWG1jVHAxMGNRYlBJMERt?=
 =?utf-8?B?Zmh3cWxzTjU4WURvYjlZTU5hKzk5eFhiQTdRZlJVVkpwUVluRDFYZlFETkk1?=
 =?utf-8?B?MURnSGc5a2sxcjg0YVpKTURjU2Zsc1BuaXRBc2ltTS9CUjFLVHhBNzJ5UnEy?=
 =?utf-8?B?Y3M0eUo3SzE3a3Z5cGM0L1F2Z0drQmJ1NURtSExISGM2SFFuRTNDdWVuejZF?=
 =?utf-8?B?bDViWGwyUGlWZjQrZGtvNGRWTjBXVVZBODVjdnRnYjdvaVdOUFovM1hlaVdH?=
 =?utf-8?B?elo2QWNmK1EyaFlWeFowWWdsbnVYWFVwUC8rTkh4cHlKdmNrMjF5WXlzV2Rv?=
 =?utf-8?B?a2hCSXVKRUE5Yld6eEVwY3YyUnpMZ1pOMTI3SnlkMnlaRVpMRW5sRzJBOFEy?=
 =?utf-8?B?emk3b1JGVWZCUWxyM2Y3aXdUOHkyT2lETFM2L1VoZnFOWk9oblMrR2xzZmJ2?=
 =?utf-8?B?YkVKbkJPeUZReVhqcTEzOFFPQ2ZUd1RGMFNJZTA4QjhoWVVIL0drckdNWWtZ?=
 =?utf-8?B?UVM1N0ZGSFFPS1hrZmFMRW5mTHBzMnYzUUFMRU5XQzdtRS9yL1NJekY4d21Q?=
 =?utf-8?B?aTlTZXhweFNPWFBRdHhpaVJSeTZoSFJzSThNTTlCRXNYVlc3UVg3SnpiNTlt?=
 =?utf-8?B?bStVMGtYUGJ3ck9FRlFCQWt4OEVNZExRamZ4a0RDcjlsMXV1dXRXMTdwWUp2?=
 =?utf-8?B?QS80RjhyQ0Y4aHYxVVhjaDlOQXQxMDBiWXRWNExCc1JsdG5sajIwcDFyaUxt?=
 =?utf-8?B?Wm55R0UyYW5RYzZJUmpjc2dXOEU1SzZNMjQrMVBtR2orTzlSVE5MZnkxZ3NX?=
 =?utf-8?B?NTdnZzBISi9kS2REdzlMcmFoSXlkZUszZ3hqQ2cvTHNqMUxYQ3NXMzFGTFRm?=
 =?utf-8?B?SEhvUWtPMFlYY1l1d25mTjhmTzU3YTkvMVhVZFZVUFdIOWpOTE9HL0MyUm9D?=
 =?utf-8?B?RkFJUjlWc003YVRrTFhCTE0ySmZZOEhmTHlqeXhqVFV5cXZiallrNTNyTDRj?=
 =?utf-8?B?dXNwZFJpTDhZb2EwY3JVY3Urd0VJZGZKZUEzMStJU3I1WmFzSjN5cUFIMlF2?=
 =?utf-8?B?bjZ5NWFrekx5RVUyNnV0VVNCU2FGeDFIcjZ6NmN4TDlOeHpLd2txZDBwaFNV?=
 =?utf-8?B?eU9rTFVjcDI0Q3NGdzdDdGNHVVpWN2Q3OW9EWG13cTVUN0U2bUlBd0VvRDdi?=
 =?utf-8?B?VUlVZWMrWjQzMVM0Z0tBRmZrc0lsWElWS1VzMExRazZJRkc2TzcwNkRubmpm?=
 =?utf-8?B?VFZhb21BM2ovN2cvbENVTjYraE1EdjNXR0phY1IxVlNVdUZvWlF2WTlPYitK?=
 =?utf-8?B?Y2w1WmZ3L2ZiWVcxYWxJRmF3eDBJaC9XWG9YMlZWOEU3OXBWQmFaY3AzSjZU?=
 =?utf-8?B?cGphNnEzNE5uZjNzUWNvZUVzcWNIa2pVbWpuRUxKckNXSjhZSWpFVVcvbENE?=
 =?utf-8?B?NkxtYkZFZjdaNnhFL1RScTJmYUZTdXNTdUxnZDhhRU1QVC83RVNxMU4vbFo5?=
 =?utf-8?B?eUFhRnRIS1pFd3AxWmVOUEJtVkZTdXJRei9OdVN6Z3h1YzlpR2Q3TERVcDdV?=
 =?utf-8?B?Yk5hYkpGTHZxQjB3WTllVHVOQWIrTEtFWUU2TncxUGRxWWhUbjRHdkYzRXdp?=
 =?utf-8?B?TzlJdS9NQ2hxTk9rZkJSeHVOM0tYNCsycWJMVXVMUEl4ZHcxYm94bTZtMmtQ?=
 =?utf-8?B?YnM0d1JBWEF3eVdtZDM1V3ZpeGVQc2IvS1doMmVGR3ZGclhqYmJ3WFgxNzNr?=
 =?utf-8?B?aXVzbWxwRWdwYm1tY0gxbGtPWWxTNjA5U3RUTVdBeWk5aWFtbFY4dHBDWlpN?=
 =?utf-8?B?YzNWWDY5UWpCTlZrTWNNbmxsR2lYd1VvSlJjaWF0c3RwM1ZqU2wyd1BROU9r?=
 =?utf-8?B?b29wM2ZMUm5IeEJZWmNSUEVyOFN3MmJSQ0Q2clhFZkRBMmI3aHM0U1NPN0JB?=
 =?utf-8?B?TmtiT1prRFVFdEhUWThXOFMrS243eUg5NVZjY09hYTllbk56aDNJYlJMbHk4?=
 =?utf-8?B?TDJsRy9kL0JBcE43d2s4MG12MGdRRlduaDFrdGEwcVRaOU1TRHpwME5vMXQw?=
 =?utf-8?B?ekJlU3RzQ3JnTFdEcEtHODVZTU4rREhaQ0ZDaER1R09rVXllZzdSK2Q5c1Ji?=
 =?utf-8?B?VnYyRjdNakxsVVM5dnJLZERMK1JSeDg4R0hCblptNGpJa3Zob1VpU1ZiUFI5?=
 =?utf-8?Q?oez1mMNBB/hOtjA7l9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150f4230-eb5d-4dd9-3528-08df238594b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:41:14.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf49uZMDjNgMdKXe6SVAIbaqZQCHM0r9htxid0Nc6k+zfqKuvQiqlQQMHwhuAny1kCGY00avGsPiL+HpYUI6Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203

On 01-10-2026 16:42, Sandipan Das wrote:
> On 01-10-2026 16:35, Michael Tokarev wrote:
>> On 10/1/26 13:43, Sandipan Das wrote:
>>> On 01-10-2026 15:30, Michael Tokarev wrote:
>>>> On 10/1/26 11:54, Sandipan Das wrote:
>>>>> On 01-10-2026 14:02, Michael Tokarev wrote:
>>>> ...
>>>>
>>>>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>>>>> guest enters tight CPU loop while displaying a boot screen, before
>>>>>> it starts showing up the rotating circle (which shows boot progress).
>>>>
>>>>
>>>>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
>>>>
>>>> With that, it boots fine, just like before this patch.
>>>> I checked current master too - same, +pmu fixes it.
>>>>
>>> A guest OS cannot expect a functioning PMU if the hypervisor has disabled
>>> it. Linux runs a basic sanity test to determine this. See:
>>> https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c#L268
>>
>> So.. what do we do with all this?  :)
>>
>> I kinda see the intention of the original change, but it results in
>> non-bootable systems (linux too, as I think you demonstrate above).
>>
> 
> Because of the sanity test, Linux will boot but not register the "cpu" PMU.
> Perhaps others should also run a similar sanity test on PMU hardware rather
> than making assumptions and failing to boot.

After looking at kvm_msr and kvm_cpuid traces, I see that Windows is indeed
getting #GPs upon accessing MSRs 0xc0010200 and 0xc0010201 but it is not at
fault here since it expects these MSRs to be available as guest CPUID
0x80000001[ECX].PerfCtrExtCore is set. This feature bit should have been
cleared by QEMU when "pmu=off".

It boots up when "pmu=off" is combined with "perfctr-core=off" and
"perfmon-v2=off". The missing pieces here are the following:

https://lore.kernel.org/qemu-devel/20251111061532.36702-2-dongli.zhang@oracle.com/
https://lore.kernel.org/qemu-devel/20251111061532.36702-3-dongli.zhang@oracle.com/

Dongli, Zhao,

I see a discussion about compat array at
https://lore.kernel.org/qemu-devel/aUEXkDDOba+oZ4v+@intel.com/

Is this ready for the two patches above to be pulled in?
