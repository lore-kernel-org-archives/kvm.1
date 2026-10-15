Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000837A834;
	Thu, 15 Oct 2026 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105756; cv=fail; b=If9FhQsW42rqdW3VSLMzpI8G6vH/HP1Qf6pzy3invkvRvRLbDZQOIWNd+vJSYWiLaNZzOk+eD03DhJchQofzeGClZd6xeKhDEvNZMBdzEGNuWDxwo0cdCMLyxEDRrUBOEii88dZvr1qXc2K1C6j8nwFeVQd+1WX2cGC+SfRhAqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105756; c=relaxed/simple;
	bh=PKUsau2X7n2HVTMOBxpwetORt1uGrHijU84XO/iFpA4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pMXxAhWqnC684HPSl4xeN91/uq5zoSOnY7zbOIoRDsztxK93wl3k8U4wDZVRQ3Je0RpEhn7w6VkEW8TEC6FxQxTnhKicjYM9kS4RwitL6JxEEZF97zg37abZcAB3lYr4Id5Kb1ihMr2hJ+oFwZhMtEpKLYL0NE+2ie+rz8eMJiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mohQxT/O; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mohQxT/O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmewtPPPKoI5f6KM/FIB+CtYXsBnzlu33TLRT4DcSRgOFp+a2xDuKNlNgXrVhkRnoBK0mQsiPgAFmSl2f06s1MowWEcxUBqLV3KLxZDr70uJQEQP/08+mkIkZ+prOEmNhY8TOwUs61lWeRWYjGSfnAQfRgl2UrM0t8fqvD+y/TXUj0CsjSYzCM2ffZ9exEAc3MdxbB0K3WloNcqlo8IW8wOoOFYUu/mZa0xPfm0pgq0hP68SxFi0Dqep7th5B5ijEtfVw+1J8WhnizKp2rrpPTE5oUQbBG6CvUKvw1PTVPC2ipAWBzXVQuTlRqkeo73Uj8YPQzsIg+UF3a4Y8n6/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGotTAAm43k5QZvAShXpLkMiOZMlMOFL2MuOkfBr8h8=;
 b=n0Tuog1CwMMxJQ2kNscJ4UWtpZ1xielJ5GjkQpkxO7F5WMRl0gb5QZrAMTill1IPgKd2wANBq6dTNSX81fdjuwhMF9TPeLVu2Dx1sNRQD0psdwqjSFyPEDPqxTAtycX75YjqOu3UHYocL+d+5k316Ok/oeQdN6BCTG6XitzIA03kuhe1x2DiTzp5mH0866PG87PIkhf9wl1luS/qnZfYqj2mxkUt3sYbw650cavpcd+KheYCANT+8mTYz6GQKzkIWM/IU2NZ0BJYL9Pi8ianLJBSjVHScuDvVCJ18ExvNYPRXMoJ3qRl5GhK4Ck960qCpaWgL/+jbHgj+l3bjK4ZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGotTAAm43k5QZvAShXpLkMiOZMlMOFL2MuOkfBr8h8=;
 b=mohQxT/ObQJOpk5X+ww/kDbRACYo0F1i8/eHdVbfR+QmNGpDN6n6VNt7cvpeSjbIHO0i1dTeW8VmyYT6MdcOyRk7iM7B4SiNw3xoSmVcaab5pp0WQnCkjpXV7Kg7b8IxjeMVbLMSfO8zyvrPsfa0MMsz2gIMlwS8bimD35Ot6QI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 23:09:11 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:09:11 +0000
Message-ID: <a23f9f1a-3c5e-4166-8956-86c3063a9e64@amd.com>
Date: Thu, 15 Oct 2026 18:09:02 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 04/18] fs/resctrl: Introduce kernel mode enum
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <66efcdc1bf71c1cb47c546b1d1299b58594bd30d.1790867441.git.babu.moger@amd.com>
 <6764525f-0245-4cd3-b35c-c2bbf4e65733@intel.com>
Content-Language: en-US
In-Reply-To: <6764525f-0245-4cd3-b35c-c2bbf4e65733@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: f51a2449-5e8c-4c82-303d-08df2b1152d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|10067099003|22082099003|5023799004|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	W3GszMlpSjPl50JHD7Hl82hCYt9PPGw0DkZ5rwIeK5OMoopAUbFSmAgZEAB/SaEwjsLnTV3QZUWDmRWre9+qq76rbPZh4HozTSSzcLnos+KltzZ8LS9uxQKoM3MkmdQO9a0C5wtMKx3Q8xyku0ZTSHvEkRTVfGzIFMTYmFThCZuCzeDS9mJMVlB7zo4RWqFgsth7mVvBQ9ziIAfo3WatEIPy/o22fXzMDxP03JBYL4HqkKut4SIvM9IQ9moXe16B6qMcVbq+z+O6wJqoVJY5PoXqZNHKoiRa0phBsI7LTE1RxM/9EGpdw2QwwhcepGMeyxixRZwEZJAk16Yd1NfS96YBBPFcKhl/fiy7R17lulol/blqIyY7WEWjgS7vVoEeJuiKfimgHpjGF7kgcY7bqRJFXNv2iNlhN+c+DetdQzD2bL/fqC2AK3+kbVFFgmpaICDlOjSbwoOZRLkhS7GGV6rDQN5gs3vqIWo/wMGg2SAlovsFV9GeeqqqJ0iRkSk/L5Ul5BlWMxnX8f+yJCxkafpgDDeM8qmOm+Vt/limL2hVo7GN0KLtxk5TcFMmel1nmMI5PjehLWui9wigVWa3yoykHYlIEfVTNHNpUIKgtaPeKbdiT6pXOBqLiTI9nFjlTTT/5kKiUxVFQCvB7SW7Nh3g8+mILIkHQSGoulkJwt4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(5023799004)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmQzR1BpZGpVclZWR1RMY25kN0xtalBkMDdSMlZUWDRtYVBzS1dPOFl2L0pZ?=
 =?utf-8?B?VXhUbG5KOVZPQk1TWnRnNlVZVWMrbjNzQ25mSGI1RU1IMmNGOXRvSjJVM2pl?=
 =?utf-8?B?dEdFU2VlT21yV05pUG9rNHRoOHl6alNaSE5kR0QxaUZrTWx0QUt2djNJTlBM?=
 =?utf-8?B?NmRFQ0Y2SGw1V01mU0Iyb0hlZkgwTG1nVXJ0K2cxVjMzOCtKU1lacUE4bHlW?=
 =?utf-8?B?Lzc3VTM0VHl2ZTdyaDMyYllmcDVXS1VjS2djRmtlbmRVTEVQRW16R25ad2Nk?=
 =?utf-8?B?aXVEV3dEalo4amhHRWxpdW5QVitVaVc0UWJEZnl3UGROVjZ0ZHEwRms5Ry9v?=
 =?utf-8?B?ZDFxUi9LZ1k5aXhhNnBnbUZuZ3VFamliTzZBZDF2Z0E3Z09teS82SWhDd2wx?=
 =?utf-8?B?T3lUNkVaVTR6am5FYzAwaU5YWnpFL3E3MWhManZlMFZJTk9YeWVyWlNoc1k2?=
 =?utf-8?B?eHJ2alF6RXZXTjhrUTFyUTNxSTJWSUJjMmMwT05OWmwvam5Bdm9WcWQvcDFZ?=
 =?utf-8?B?Y2RFYkhLN3ZvOHlZNGVEWUQyV3J0RVIwVE0wNVhXQ3ptNXI4VWp1NlQvT0xB?=
 =?utf-8?B?OTRLS2dCWXBpZEYyTURodXVaR1pzVlZSd2RwMVRDaDhIOW1SRUpFUVhqNFNh?=
 =?utf-8?B?UEdzZXR2UEVLZW45TFplQVo3V3ZWc1NTbUp6RVdBUW9jbGxQSzh2M2d5Zk1h?=
 =?utf-8?B?dGdRd1NBMXYycmppTzExbjFqTkx3TXFaSlhYcmM5ekg2T29XYmtzT0prRHJi?=
 =?utf-8?B?NzJjL1gxTzV5dEpwSm9qZm9VRDhCK0lMOVJjNHg0QmdNaERwQ1RVS2c0Rmhw?=
 =?utf-8?B?V0dQZWppM2RidlRGaVFjRFN2aWpqUDVYM0xDSFZQNE9lem1XaTd3YXdDTmxl?=
 =?utf-8?B?QXRxQTNjN09IaEQ3M2N3MzJZS1h2SGpqWEVaNHhKTWYwRjNyemtIdlQ4dktI?=
 =?utf-8?B?VnZrT3hLTnUzeHFSUWx6cmExbzIvdFZxQ1RMRGVDaEhjWXhFVU8zYytQaGt1?=
 =?utf-8?B?NjBBcCszQThvbXhJOUYrb3JGRTJFakgrZDFKQ0Y5c296azBOWEVjK2JzWEU0?=
 =?utf-8?B?RVpHajQ5NVFPNWErWWw0L1U0ZDNadmxtS2U5S3c4Vlp2SFY0OVRLNUNsaThC?=
 =?utf-8?B?Nmdtd0NLVUFLcm9ObGo4OHFDejJFMjZKbFRNVkJleW1NQjVpdE5HeCtGZkVv?=
 =?utf-8?B?cVRSZmpTWTVZUDl3MEpDalEraEFiUUc1M2RBdWdMMm5LS00vQ0w3bWtCdFk4?=
 =?utf-8?B?aWhpOXlTOEZpZE9nazY0ZkNMVGhLY1U2dmpYeFZVeDFEM0F0dDlvUFd4VlhK?=
 =?utf-8?B?Mzdqc2Nrc3hsd1Fwc2xtZFg4cVZwOXpEc2paRU04djdJUU1ValNHMzNNckp4?=
 =?utf-8?B?UVd1VEc2LzFXaDd5cjVjNXhISTlpTlowcHRzcXI2TWtGL0xEaHJpZ2s1QW5P?=
 =?utf-8?B?TWl5anVubDNPUkEyTlN2N3VYcS9nQnhQOEJnT3FrNmNUb3g3Qm1GejhHUjVz?=
 =?utf-8?B?Y2tzSEZRdFZEaE9obEhPSW5vMHIvbVlOV2k4SVBYNnh5OXp2UXgrbUErcmlL?=
 =?utf-8?B?OE9xY09TNldmSmJBT3Q4L3NLNVJva0NHQXVCL3kxeEdIYWZWRkl3Q2IvdTg0?=
 =?utf-8?B?UTFnS0VYSmtaZE8yRVgrdHNDRjg3bXNNSXFGUG9MQkdLMUluQkIwdHVmTEpp?=
 =?utf-8?B?N3B3TjQxQVNmcFJtb2tNTjJJMEpvbUNSbUxETHZ2K2JFVTJaRGVwZ2pOdXZM?=
 =?utf-8?B?VjAvU2NnNnlGWFJiYTV1YU85Vjc0eDAzdEF4RFN4Q25hei81c1Q1S204UEFa?=
 =?utf-8?B?VXBBVGlGTXdRMWt5TEFDQWRjdXBKek1uVVRVN05WUVhIdTJEMC9FdTl0Ukx1?=
 =?utf-8?B?S2FCa0YvZGUrcUZhb3RiN0Q0WC9wbDBoTTdxblBaT2tDVUgxcThwbGc5SjdJ?=
 =?utf-8?B?UklFOTFTL3o4ZXo5MU9OM1U3MXA0OThJNmJPMnRtRkptQkFEVGQ4YmN1K2Z5?=
 =?utf-8?B?VDZJWUJVZmRGVCtiTDBqaEtuQ1hVYmdTSmswZFRmUUpNUDhUQ2Z2OXo4NDZG?=
 =?utf-8?B?RGtyaTc1WFRDd3crR25KR1p2dThhL3BRbXBiSm5zcDREUjlnWVdTYW9ET0R4?=
 =?utf-8?B?ckR0N0FOMHZiUStkaWQvSlZpNWNVTmpMM1RLRWYvSGg5US9IWjk5V3BCc2dq?=
 =?utf-8?B?aEx1YW9QSUt2MExZK1NMNlY2eG50WXlrUDJ4S05hUEFOMXArMTRHZmlHOTN6?=
 =?utf-8?B?U0xHYjJKaTBlMktXMmRBcmNSSVlOeWtXR0RTUGlnMkNUMkEzMkpaRjB0RVM0?=
 =?utf-8?Q?NSivoh3CotNDObrGQc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51a2449-5e8c-4c82-303d-08df2b1152d6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:09:11.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp5N2dKaA7lUE/G7ECUcZUIcDod4JbKHOy9HiKlqGpD2RzAhIo9AI2mnwW1hUZik
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

Hi Reinette,

On 10/15/26 09:44, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> Kernel mode work can use different allocation and monitoring associations
> 
> Here I think "different allocation and monitoring associations" means
> different CLOSID/RMID, while other places "different allocation and monitoring
> associations" means different MSR_IA32_PQR_PLZA_ASSOC.closid_en and
> MSR_IA32_PQR_PLZA_ASSOC.rmid_en?

That is correct. Hope text here is fine.

> 
>> than the originating user task. On x86, Privilege Level Zero Association
>> (PLZA) enables the kernel to switch to a different CLOSID and/or RMID when
>> entering kernel mode.
>>
>> Architectures need a common way to name kernel modes before resctrl
>> can report what is active or what the platform supports.
>>
>> Introduce enum resctrl_kernel_mode:
>>    - RESCTRL_INHERIT_USER: Kernel mode work inherits allocation and
>>      monitoring from the user task.
>>    - RESCTRL_GLOBAL_ENABLE_PER_CPU: Kernel mode work uses allocation and/or
>>      monitoring associations that differ from the user task.
> 
> As written this is not accurate because there is nothing that prevents
> the "kernel mode group" from being the same as a task's own group?

Yes. That can happen.

  - RESCTRL_GLOBAL_ENABLE_PER_CPU: Kernel mode work may use allocation 
and/or monitoring associations that differ from the user task.

> 
> Could the description of RESCTRL_GLOBAL_ENABLE_PER_CPU be made more specific
> to include that (a) it is a single (global) association that applies to *all*
> user space tasks, and (b) it can be enabled/disabled on each CPU? With these
> two additional details reader will more easily understand why the name of this
> mode is "RESCTRL_GLOBAL_ENABLE_PER_CPU".

Sure.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   include/linux/resctrl.h | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 10dfdca7f4bf..f6adff7f4e1f 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -723,6 +723,35 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
>>    */
>>   bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
>>   
>> +/**
>> + * enum resctrl_kernel_mode - Kernel mode control and monitoring association.
>> + *
>> + * @RESCTRL_INHERIT_USER:
>> + *     Kernel mode inherits both allocation and monitoring associations
>> + *     from the user-space task. On x86, the kernel uses the same CLOSID and
>> + *     RMID as the user-space task.
>> + *
>> + * @RESCTRL_GLOBAL_ENABLE_PER_CPU:
>> + *     All kernel mode work uses the same allocation and/or monitoring
>> + *     association via an assigned CTRL_MON or MON group. The mode can
>> + *     be enabled/disabled per-CPU. When the mode is disabled on a CPU
>> + *     then the kernel work on that CPU inherits the allocation and
>> + *     monitoring association from the user-space task, effectively the
>> + *     kernel mode becomes RESCTRL_INHERIT_USER on that CPU.
>> + *
>> + *     All online CPUs are included by default. A subset may be selected
>> + *     through the resctrl group interface, and a CTRL_MON or MON group
>> + *     may be assigned to this mode. On x86, CLOSID and RMID are configured
> 
> The sentence starting with "A subset ..." repeats what is described in the
> first paragraph so it could just be dropped? This leaves the first sentence
> of second paragraph out of place, how about merging it into first paragraph
> like:
> 
> 	The mode can be enabled/disabled per-CPU, all online CPUs are enabled
> 	by default.

Sure.
Thanks
Babu

