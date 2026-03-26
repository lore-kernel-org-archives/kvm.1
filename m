Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314C1B4156;
	Thu, 26 Mar 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550479; cv=fail; b=dAfHKuTi6DW77qMmPxY1rfvqmXgamLtjZs4UBGyYlKqVtK8XIHWBgxQwYUuxQyTDlobh287xZ31w5dDzuoLNjkIjuf+DLeLY1vWqjXcyjwDvmspVDbMjvjxLVvj1mxjgCFiwyq2PJ3tiY/QQaBw7GjZ43ZTdVWGRPBv3HsGw9EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550479; c=relaxed/simple;
	bh=dpTcOSdHat2mjMBOe2abNB93k2cl/fl7MK16Hh2p1BQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KTCXrSiIHLFyVxdLIvTaI4DN4hvPOaTqOY3tlRb9HZhgZPs6dvmPHn29tzpRdMd5O08Q8qv6EHDUEK55eRblQZRjWfLmosnoVxy5r6i4BZlmSeJmmQzUAXDDpxg15iwFje8EY8Z8fnP+8FWKL7F5R7vYs59zo9j568pcInSUucU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kthBkL1y; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kthBkL1y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLIdtuVMvJhrzGPvbGcfsEjgkUD/X/LOxaAfILWnlcM1tBBJMBIQb7yey58GCdFcdcBj2EUwwA1MRIuSTr2YbxCG3kXfEUi18a8G5Ia64xUpdVa0VAOfpxNx2e/IV0po7ak+FGV4uxfir/LG3i0poYD9NhMzXSpplT5v6GhYfdj9vfJWGp8jrhaEPEEpo6+j2iV+S7O7M3pVIicTXEj0DLz4r0DE1XLkVDwKmdjjWd0XidDAt8azil/z2NnkxMZEHdAVhGZ/+dsdq5sXt4hNdCCTQOY2ymrFhusiThyOGPuqeT2bYbGdFwggyzJtH4PXpMMvczFwfLHFMRm/azwuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8ZmNr/pi+mtfOBq5JYyz/Xy87DXW8FAmUcWDwusMv4=;
 b=TafYQJOszVhCh6RmXuD+TOiIgOW58ZFcZZSRWFpxtO3KJY2MkRNxfPiPs4HsE1WN3283xW0stX26tVUMCbjdsP7M23oEGJEE8o3urnJUFGvoLahHDxoYw2pAO33APaObvYJjz2978lsqctLyJTEGDGRJFwODxSPDJJAll6eeIbFtdfNiTPFGJm0mBH+kQ8nh7PvGM6ZFDtYNseOgLvXEDh6OKPqljDqHIFhX0iR3/h8N15STOFBdBEuVUU+fMNpR1knKli0W53iAVeYdk+mCDuBK2POgxbdSAXEDUiUyF+eXf8ZGGUlN0BX2QCsNj5Uc61VuvswL1lpfTYZeUn7b1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8ZmNr/pi+mtfOBq5JYyz/Xy87DXW8FAmUcWDwusMv4=;
 b=kthBkL1yMIvQ71HZ7V8Hzary/NSw/E4HKK4Gt6f8iVXHUSSWT/JVaoF1t73PM1WgZCiLFL5nXciGRXU7MXXc5Aouy80A4xfsKgOBCP9DdFTuII9RX/kVsb3gpy2BbjUX6737W8ra18/CBI3xnYA52jfJhmhYYQCCEGFG6B4o4kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DM4PR12MB6327.namprd12.prod.outlook.com
 (2603:10b6:8:a2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 18:41:12 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 18:41:12 +0000
Message-ID: <185527f8-e730-4111-8582-1f3418ca345d@amd.com>
Date: Thu, 26 Mar 2026 13:41:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] fs/resctrl: Add kernel mode (kmode) data
 structures and arch hook
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: skhan@linuxfoundation.org, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, akpm@linux-foundation.org, pmladek@suse.com,
 rdunlap@infradead.org, dapeng1.mi@linux.intel.com, kees@kernel.org,
 elver@google.com, paulmck@kernel.org, lirongqing@baidu.com,
 safinaskar@gmail.com, fvdl@google.com, seanjc@google.com,
 pawan.kumar.gupta@linux.intel.com, xin@zytor.com, tiala@microsoft.com,
 Neeraj.Upadhyay@amd.com, chang.seok.bae@intel.com, thomas.lendacky@amd.com,
 elena.reshetova@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, eranian@google.com, peternewman@google.com
References: <cover.1773347820.git.babu.moger@amd.com>
 <c3381fbbce357b00895252572907645a92cd9718.1773347820.git.babu.moger@amd.com>
 <57c72d52-e62a-44f6-a08a-891a354058e5@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <57c72d52-e62a-44f6-a08a-891a354058e5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::27) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b18707-0831-42a1-c91c-08de8b6740f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jLXHcX1FTAX+lblt4Uhwpru1wMJzZLOf+FZosNY6Io50CkkTPrChvHAU59W2PeKWpj+iJeH4c5e54Knq1L0wYCdKQW4bK5nAfvJiBlYHLFcBkoMxw+msHwGxdFe7xKJRvhMpb/Ro5XGOue8HcgryUOgzkiw+6chN0T89b06FUAMCSdQ+esFPM11L8LvzrYO2khE6op9WY4mdomqZRXRwEe1D9L7ERSKNNjcnfjn4UAX06vjQhfe3l7HC8THTE+dBo6RZ4dRkgiUMzlUHPquG4fQIUGWT+KV5bF7k+VKrmdc7ehJ4lhwquCWZEvZSwFahMcnzkvXEFoKDOJVLmfHhMQcJoDPV5Dgl8P8eKWqWH/kbNITjIB9YiNdEjlFa1kV32yjhNgy7WqT2Wv+/i1zwWcJAT45Z8CLI491Ge57cfo2yXq9iZgdMQUmjxNXiK0b7gf8G5KFf2dZ2epjTnyk595V0hBgMARQHZKjCdsYA0HZr6tSsclC8FKCh6cNoyMzHDWUb4bhUhmPQLHTKXAkc9n+sCwSJpeZVyM8is/COYQx2KYnYckuGxpWVxMzuuR8bzxpC27gbrGYJlkWkSkmi+rqQlSXfHOj3ocdBjnPVnhN6koK6YVWNmH7GcuuL/xHBTfcqpBEsZh1Cn5TDY8P05OnyYAjso2IblzR/7DnK+K8nnnFxOys21aWJS10rjW00dE33XFLlIo5PZoTf5vELKXm5NIqRpk0P7xAidLb0nAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y29jVjZqSHBiNDhiSUtvNWxRa0hKSWkxSVZRN1VQMm1CTGhtY1RLUkZNZHQy?=
 =?utf-8?B?N0hvOE9zN2VHeWN2MWhGK0VaRlpYWStiWFFpZ1ROQ1VZTk5MRVFuaE1kc0Vv?=
 =?utf-8?B?SmNlZjdyV045bDZXL2g1SHlaSm94MVlVWEk3YUh6SVpnTlh2VFdpR0JPcVZW?=
 =?utf-8?B?eUhSM2dPYVZRZ1A5Qi9Mb202VEkrMjByR25xaG8vL2RCUy8wM2Y4YksxQnQy?=
 =?utf-8?B?eEJDU0p3R1RRbUN6bzNuZDJjMFN2cmZwS2N6Vkk0NGRMMytNa0N4SWl2OUJG?=
 =?utf-8?B?cWFPc1JESlBNaUdOMjZ0L2Jvc25kN1hydU53eVZMOXBGR3RBejFxMXpiMlV5?=
 =?utf-8?B?OXptV0hKaWptVk5hSmFMeTU4ZWZQTC94Y2NwZlRLSkV3bnVZSjR0Y3hxajRF?=
 =?utf-8?B?VVNOQ3k5MFRVSHNDaG11Z0hOZXdKV3pFZExvdThwMEd6R0hEd3VZeUFVWG10?=
 =?utf-8?B?VUxRUGh1aU1RMHBFdUFEMXlRVzhJL2s2aU9US0o1Rm9vRkY4QzAySmJqUEdY?=
 =?utf-8?B?Z2dpUVhZVlJwcEMxSFBiTnNSUzJ1SkhvakpyQWZxRmdOa3g1WlZmMTRGNjZP?=
 =?utf-8?B?cmhhdVhvTkF3Zm45T1BCaXQ4TlV1RU1PZUx3aTducDE2QjlEdW5xVFFzZDBU?=
 =?utf-8?B?Q2swdnUxU0pldVRmOGh2V3VFTDQ4RXhtRFc0MUxFeVRiUUVWMTJJZkJBQk9M?=
 =?utf-8?B?ekNhNkZEL1pMTmQ5bFExTmZmWURIbjgvVGV4WXFQZ2h0ajVaZXRVWDFGaFk4?=
 =?utf-8?B?MnVXUVhQNVYybVlKMUlVOTROUkNFMTlsblRJcVQzYTVxVUswRHhxQW51NkYx?=
 =?utf-8?B?YVdPZitDcU4rVlR1WnhXbUZsRVRuWFg3UXIzOTVGck5WTXhpVHROOUdrUnFr?=
 =?utf-8?B?THNsZ3dURVRNMkVJVmNDdDFSVVlBOCsya2VSYkVyNkhPV1RmdWpFS1lzMUtL?=
 =?utf-8?B?QXJhOHVVNlkvditSdTk0ZnpuYndwWTVjMEJ4T1Y1aXV2ejhWZ0ZxdFUybnp3?=
 =?utf-8?B?NGRlS1ZYR2hWenIzempoRklOb3Bra2k5ekUyRnFzOGp3L1NSdlp0WERvMy9X?=
 =?utf-8?B?OERBb0dKeVNtNGFKcktWbCtWMEpXWUxRTmxMZjRrZHBWYUwvTHZvcDlwOHBi?=
 =?utf-8?B?dnVUNHhXSHcxRXlORjYwVjlvSU13dzJaaTlRbEVaK1R0dWxXNkw0S01CVUdo?=
 =?utf-8?B?YWVGNGNPZEFXRDFLemhvd0J5OC9CdGhxYy95anFhcE9sQk1IVWJZSnlEN3FI?=
 =?utf-8?B?L1l3VmJGbHJ0OEp0MERINnB6dEVONTVxVDUvMC83Sm9abjN4TEFqQzZMcXpN?=
 =?utf-8?B?VjNONW9oT01SQVRVYjBuRmtSUzE4Zm1lb2h5RW5iU1JHWmw3QUVnVDd1anY5?=
 =?utf-8?B?Yjg2Wk90aWs2aitaZFhjKzNnakFudHYyYWZFTC9JOXJpZkluWFQzbVFkQnlV?=
 =?utf-8?B?dW5zVVZjaFQra2hyaEhqNHlmY05hN2ZYSGNBMm9rMWI2TzdGRW9yK3VqbE42?=
 =?utf-8?B?ZUFDREN6dlpsYjV4NFpIMEl3eEV4RTdOczJDRytFcEFZbkNLWktVZ3VhZjJU?=
 =?utf-8?B?MlcyYWsyUUdiYUxJY2p4a1cwUGg2azJlQ1Npekk5UUl0MThaS1lMUm9lVitj?=
 =?utf-8?B?STIySjBIZmpyZXRzS3RGMUkvcGVNOU51ZVhaQnBPekNPOTdaUU9sTnlzQyt4?=
 =?utf-8?B?V0dBZXZac2dZSzJpY2lsVjJ5SlpsejNCekRoMy9kWDVZWFphbU1JZ0FpKzJ2?=
 =?utf-8?B?TU56aHlSc21jaXEzNEpoTTZzYmozTjlLbndjUnNRK0x3SkgxWVl6elIvdzFG?=
 =?utf-8?B?VlVLWExCTC9vWnRIS0pydVpMbTBxZ0dQY3ZpQWpYd0tNV21kZGRHRGlDdTNV?=
 =?utf-8?B?T0hxQ0IxVTFvbHRVY3ltT016RUMzbmo4bnFoeDl3T01yTlJncVZyN2ozaito?=
 =?utf-8?B?K2pDZlIrZGo5QlF6TXdzSWpMZDh0dmVhV0JNd1gxejNValRwR25kNzhpK1Ez?=
 =?utf-8?B?VUE3VE52M204c0VqMEs2ek9FOHJ6aDQ3THROMXkzRmZDNkJVZGRqNFMvYjdM?=
 =?utf-8?B?ZG5MaU5rcDJxZUg3SnlNVW9QUEhEQStaOStDR1RyMW1QaUp6ZmJGS3ltTnQ0?=
 =?utf-8?B?N1BiV3F2d2JkY3lYTTArT0hOd1JFd1djRDJQenI2VWFSUWZXM2pUU0pMNTlm?=
 =?utf-8?B?dG9BaE9haTI3NXgxYUptZ2h6M2tBMTdQQjloaVB4WThJS0NqMEkyNVV2Q3o1?=
 =?utf-8?B?T2l4Z2J5T21tbWxxbk5rT0FldkxVT0FqdHFUTWhJN2VzWFEvZEo4bUdUaFRB?=
 =?utf-8?Q?sY/FqWE9I1lXm8Py8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b18707-0831-42a1-c91c-08de8b6740f3
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 18:41:12.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEtnRNPfAwLCXcIJOWkzVTdhbIpQhuR8nEyqmVxLBE41CBSrHRk9Y9F1lidPm8r5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

Hi Reinette,

On 3/24/26 17:51, Reinette Chatre wrote:
> Hi Babu,
>
> On 3/12/26 1:36 PM, Babu Moger wrote:
>> Add resctrl_kmode, resctrl_kmode_cfg, kernel mode bit defines, and
>> resctrl_arch_get_kmode_cfg() for resctrl kernel mode (e.g. PLZA) support.
> We should not have to start every series from scratch.
> Documentation/process/maintainer-tip.rst. Always.

Sure. Yea. I did not focus on that aspect of patch submission in this 
series. Will do next revision.


>
>> ---
>>   include/linux/resctrl.h       | 10 ++++++++++
>>   include/linux/resctrl_types.h | 30 ++++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 006e57fd7ca5..2c36d1ac392f 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -699,6 +699,16 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
>>    */
>>   bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
>>   
>> +/**
>> + * resctrl_arch_get_kmode_cfg() - Get resctrl kernel mode configuration
>> + * @kcfg:	Filled with current kernel mode config (kmode, kmode_cur, k_rdtgrp).
>> + *
>> + * Used by the arch (e.g. x86) to report which kernel mode is active and,
>> + * when a global assign mode is in use, which rdtgroup is assigned to
>> + * kernel work.
>> + */
>> +void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg);
> This interface does not look right. Would it not be resctrl fs that determines
> which resource group is assigned? This cannot be set by arch. Why does arch decide
> which mode is active? Is this not also resctrl fs? Should arch not just tell
> resctrl fs what it supports?
Yes. Sure. Let the arch tell what is supported.  Let fs decide what is 
default.
>
>> +
>>   extern unsigned int resctrl_rmid_realloc_threshold;
>>   extern unsigned int resctrl_rmid_realloc_limit;
>>   
>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
>> index a5f56faa18d2..6b78b08eab29 100644
>> --- a/include/linux/resctrl_types.h
>> +++ b/include/linux/resctrl_types.h
>> @@ -65,7 +65,37 @@ enum resctrl_event_id {
>>   	QOS_NUM_EVENTS,
>>   };
>>   
>> +/**
>> + * struct resctrl_kmode - Resctrl kernel mode descriptor
>> + * @name:	Human-readable name of the kernel mode.
>> + * @val:	Bitmask value for the kernel mode (e.g. INHERIT_CTRL_AND_MON).
>> + */
>> +struct resctrl_kmode {
>> +	char    name[32];
>> +	u32     val;
>> +};
> There is no reason why this needs to be in a central header exposed to archs. Could
> this not be a static within the only function that uses it? Something like
> rdt_mode_str[]?
Yes. I think so.
>
>> +
>> +/**
>> + * struct resctrl_kmode_cfg - Resctrl kernel mode configuration
>> + * @kmode:	Requested kernel mode.
>> + * @kmode_cur:	Currently active kernel mode.
>> + * @k_rdtgrp:	Resource control structure in use, or NULL otherwise.
>> + */
>> +struct resctrl_kmode_cfg {
>> +	u32 kmode;
>> +	u32 kmode_cur;
>> +	struct rdtgroup *k_rdtgrp;
>> +};
>> +
>>   #define QOS_NUM_L3_MBM_EVENTS	(QOS_L3_MBM_LOCAL_EVENT_ID - QOS_L3_MBM_TOTAL_EVENT_ID + 1)
>>   #define MBM_STATE_IDX(evt)	((evt) - QOS_L3_MBM_TOTAL_EVENT_ID)
>>   
>> +/* Resctrl kernel mode bits (e.g. for PLZA). */
>> +#define INHERIT_CTRL_AND_MON		BIT(0)	/* Kernel uses same CLOSID/RMID as user. */
>> +/* One CLOSID for all kernel work; RMID inherited from user. */
>> +#define GLOBAL_ASSIGN_CTRL_INHERIT_MON	BIT(1)
>> +/* One resource group (CLOSID+RMID) for all kernel work. */
>> +#define GLOBAL_ASSIGN_CTRL_ASSIGN_MON	BIT(2)
>> +#define RESCTRL_KERNEL_MODES_NUM	3
> I think it will make the code much easier to understand if the different modes are described by an
> enum. For example,
Yes. Sure.
>
> 	enum resctrl_kernel_modes {
> 		INHERIT_CTRL_AND_MON,
> 		GLOBAL_ASSIGN_CTRL_INHERIT_MON,
> 		GLOBAL_ASSIGN_CTRL_ASSIGN_MON,
> 		RESCTRL_KMODE_LAST = GLOBAL_ASSIGN_CTRL_ASSIGN_MON
> 	};
> 	#define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
>
> The supported kernel modes can still be managed as a bitmap with intuitive API using the
> enum that will make the code easier to read. For example, __set_bit(INHERIT_CTRL_AND_MON, ...)
> or BIT(INHERIT_CTRL_AND_MON). The naming is awkward at the moment though, we should improve here.
> 		

Sure.  Yes. We need to think about naming.. Let me think about it.

Thanks

Babu

