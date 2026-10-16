Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E973F1046;
	Fri, 16 Oct 2026 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186408; cv=fail; b=qUnnQR+Xb7K2vh7VLMKccxUlhAVcH+gsRcO2L+lm6gELAu+OC7JVe61g+sfDCzoER0x4dvaPKstJ7xbqTlzeqsXRBhRs86eC6RlGHzSv0YnxTuY9zLW14XQKXvHkH0VBeWqKbWjWYVUr1g8vJfAQT9Ks2ZhJrMysSUvyNXAwhrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186408; c=relaxed/simple;
	bh=+5h2ULNN/hZLwy12Y7wiUXQIkO8IIc3cr+Gjx5EU92w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=naq+JH0sldjgDL/NYVODEmTf41yzWPh8yzcybQvEufh2X2iCcyG5psxQrYo5LYCmxGMDL/G9HojV0Vvd0Z61Pu0Yr54kuf8xooKNaPoUEd1qnO2YcBAjxTbatTJDssnI1vheJkxsyyPEdg6L88G5eSnNjZXze9Q1hHwcMZlqIuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v+PxE4PB; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v+PxE4PB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq3SOVTM6J2uA4088izoYMXO8sggc2nETScvv85gbF86tsZdCEvyDNisIsRXmR9R2XptY9qrDC8ORAUgbIUoxK6QbLjmsqqxGteYkDgcox4yRVb9W0SIqnrrjQRmWv3oOhw2ePDtEqWzCM3OLZ+zQ2IKl5I2N/AeP9Wx6pm/+319sCI1x/aSp89HbbHeQC9/X0lmI6BWl0PGA+1R++xkiqtX5n4yZcnjwDLdJwrl31YSGiswXI6MfvYe18X4ZndpyS0+IzfXP+6S0m8RWV5vGhdbeba87JpEm1XnArfkqR02rcxNwzcQo9GZuz1Ut9teW6faKSl/aKzZVwLh3NMNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWCmXYUgzja27WQRclz7GDyB4RO872xsPlU51jh879Q=;
 b=kYPNwpPGICx53xdKWlMU2nHUetDoyw+xVD/bjGdpZNTAgqVvXwePpkyDUwl8id24xyNH4bcP5J8EwjkkxocidMef66R5EZjTjBnhFEOeACqWT4bvEnEhbej+JD1Pzrdgf8hz+p9cDeg7eWnrKGc6uIDyoCMXHPZx/0Cq1oEYXkTV/Lbh5PKJ7JDKVy/DRkQCDra+b8+OZQOEoOBMeG+ja/gxJGq4Nkr6V/npH6T29aJiSlUzgaaSr1vNSKsnidJvpxR3WiVEAxlL+M0oQGqXRgFV+fkQgor3NJqhu3MmgXhxZ3JyIrH0XTmBatesTh4mX8P8naGdBoDt86c8n1PvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWCmXYUgzja27WQRclz7GDyB4RO872xsPlU51jh879Q=;
 b=v+PxE4PBUWRYzoD5rODcMMA7/nKwJ3WLjE39qBlIT3BXXFgjJICth3vnok7OY7Wv0BC7l30q6HEmrR4/4o4KVBMQ2/DvS6BLyKp9J7pr7AjWeoikx62QkSZJIkC3dOqZ00oXI7tiq2rfCkUDIPmjlIeKHMyifg4Aky5avgO57Bs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 21:33:20 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 21:33:20 +0000
Message-ID: <d7ba6551-adfc-4078-abd7-0f016d7a5dfa@amd.com>
Date: Fri, 16 Oct 2026 16:33:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/18] fs/resctrl: Introduce kmode_cpus/kmode_cpus_list
 per rdtgroup
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de,
 ben.horgan@arm.com
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
 <54b0c60041902accde067b48bc3178c6756294d6.1790867441.git.babu.moger@amd.com>
 <0096fb82-4104-429a-bd69-7f733624c664@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0096fb82-4104-429a-bd69-7f733624c664@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:806:f2::32) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: de15c6bb-5762-4262-4f4d-08df2bcd192b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|6133799003|10067099003|18002099003|22082099003|3023799007|4143699003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ATarEq0qekcuJ3PgPg5XDJd3vtJSTrVJ62JBdBi45de0B1l2MXSIKQJxrb1nxGtyBhUl+UkwGEppM2U0iyHb4hwHSdtTTNhEVF3U3KgLCuuCIzk+/utDxwdzTFHJsfhvW33Fiuhe22QdxsFCpf8j7iswjgIdzPXOWR+6zMKnKcYpcqv1D5cSRkJ96Zouoi6nH9GhkpG/SFiPJeSlOvudb9azPlEqbLDNNmifC5szXYGD73Vo7Vgem+D4SMBH1O1JIM9y045PwbgcfUVPDZKvmy/sniSapUms9I/jQfRSRGEc7E54ZPHH1hmhnjSbUXEXBagogIAWKxilvmSSDdvlUXIDFgHkCOJmTVy1aFORAaf9fSOh8CrIXlZwdInapDNNDJxo13zdaqNKEUw0fTbJ7iCfUsvWVefn9ytURJKYzL2LZJSxyX03hCpzIMg2OnXSqNG4u2+3h29a8y1acNZw4tXWeKmkn3SwqpnqStd0HlIKUioJqseet2nAgfu1bYd+A0S17lrIT8ZVwl0hUjKF/Yf+mYYvKhhpGm+C7Gh1ytg2QZw1qizy7rERv0Bjxtfc4h/D8b2T3C0PLhabvpmbTZGA10w/eLomohvzJMo0ZYR79c6n/u04+ssag5spOh19HFybEwK1xo2HFsBac0p72it1bVI8/dLmLwJMDd9dE50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDlVYldSMEFZb2lkekpDeTlhbHVEMTJoWWVqdG5XbWg2K2s1bFUwekVWcGsy?=
 =?utf-8?B?SnVqdkZXYnF3SFZkaitrc0VXM1c3LzllZEY3NUVwbHRTbk5QZjlianpmVi9F?=
 =?utf-8?B?MWoyeG91UFpHQ1FURXF6ejByaUNJS1pLOHcyL21qTUZVenV4RjUvWWo4MDY3?=
 =?utf-8?B?MENIYk9ubGdsNmo4NGZaSXVHQkNxZERrdDRNdWMzaysxNGdtK0hOUkhqdE95?=
 =?utf-8?B?OEgzRnhSdWZBb05Ib2hXTnNaYTVTeDJGbUpISXZYV1o2Ky9UWFRWVjVjMkFh?=
 =?utf-8?B?QVAwRnpOVjZadVFpOTJHaEE2RVhiZzhQT1prRGQwb3ZPaXlpeWt3U1VqdUtv?=
 =?utf-8?B?Z2dYbkZPaVRhbUtCZ1E2bVpUWWZwRzN1TVluUHdXUXl1SHdFaGFaWDROWnZm?=
 =?utf-8?B?emJsb2N4bjRKTE9NeDU2UmVrNngyRWo0VWMyVXJSekJUUlp0Z1lmNFVhQkVX?=
 =?utf-8?B?b2pPb1FYc1JVb0RxdVNFczV2bmt0ZldkY1VjTHhkRDJWaVJsNVc0dHpXck4v?=
 =?utf-8?B?MkQzakpBaWlidHdBeGUrRnJxdkFKSFZLNlNWRXpsd1kyMDRlMmtrb0ViNUJt?=
 =?utf-8?B?ZkFmNUNXUkk1Z2lWNWEySTZRY1BVY3kxM04vWEk3MTdnbHU2ZEdSSDA2aWlj?=
 =?utf-8?B?dnpUVXozRGxWMDhIYXNiNUVQQTh6dGhFU0hFSnNtM0FvNzJGam84UTYxMGFn?=
 =?utf-8?B?L1lWM0xOZEhXSnBSL2J1ejNLaXRBZis3ZlAvVTlIVW9tRGN6d2VIcENJSDNB?=
 =?utf-8?B?WEJ1KzgzZ1phTm43MnA2eW10ZGNJUzl4MndrVXA0RzJaSS9OOEVwYTNMZXY3?=
 =?utf-8?B?eGlaeDROTzU3R1BtR3BtSklRUTFML3M4dEhPZkhya2FOUTA5S2ZoVjNoSFlx?=
 =?utf-8?B?TmNxQWV3dzRXWFQ5djlzZW92blJ3MzEycHVlQmZHRzVkSHR6dXlVRTZ5a01M?=
 =?utf-8?B?bjcxcjBGK0EzSlNlcFBGekowRUhCNDR2L0lLSExUOTkwc0NvWDRzelBuanRv?=
 =?utf-8?B?c1NsL01DUFZzRmlBa3FzN1NwSUFhRDlzQW82SitDWGtVeGx1Y203SVBoWHlx?=
 =?utf-8?B?eU1JMUdhdGFNYTNsZjA5VXZBS2ZrYUJuNUdvNGoxT3NrTk9NVWkzM2dBK1FR?=
 =?utf-8?B?N0QyMlhTdHoxdUxhcndWSXRwNENFL1pjQ0VlTUs4eDlhWllpbzRJemQvZ0pU?=
 =?utf-8?B?Q0tKcE5vZm5lZnBuV1pmd0ZzUk1lOVI0YUpqUG5yK1huVWNiRkw4by9mVFhD?=
 =?utf-8?B?d2d4WjArb0FoQWMwZ0hYandDdmduQllDUklKZ0ovT29hTkdFMElDVTNrSTdl?=
 =?utf-8?B?eEVYYk4zbFY4S1BWYmJZTGl5bk5hKy9mZTB4VlFLV2pNdlVBUjFmOFpTT0No?=
 =?utf-8?B?NWNQMzVtSmFuVE9MQldIaUIxdWRQQnR6NkFkWDRvK00wRFhGVU9QSW9xLytP?=
 =?utf-8?B?NUF6Q0wyVUh1ZFc1WTZackQ3dlNYMC90dVo5aWpyejlxT1M1VUoxUTE0ZUlZ?=
 =?utf-8?B?aUJTR2hnbG1LLy83a0lsNWRXeGZQanZFSHhUN0hSZEhVdmVJdVdWM2NDTVNs?=
 =?utf-8?B?TFdYakJDZHU2WEVPVFgrNHcvQ1BLRVhzSzNqL2Ftbm4wanhPUEhYVWlxeUhV?=
 =?utf-8?B?RFlSNlRpc0tPWHdPUmI3WE45Mml4NHpLMTJGVDdFb0hvZUQ5Q2RtZHZaZHdN?=
 =?utf-8?B?NWd1aG5RRG1xKzFDcTU5UTdqUHl2ZmJNMzBxTk9XS2MyZStLNWFrS09zanRk?=
 =?utf-8?B?RGJqSS9aVTlzcEV0bHVGUlNZN2x1eiswc2llVkdraVErenVxSEkwbjZDMUoz?=
 =?utf-8?B?SC9nVDRpWlNyanRzbE54aU1uR2VwMms1RjBtZ0NCejhBOU1abFNtL1hoLzFB?=
 =?utf-8?B?U1RtK0lGaG40aGthQ1JxcUFBRCt6a2NlSVhMcWJkZHJEclc4WUhtVWt2Ym9q?=
 =?utf-8?B?azZFV0x4QnJkQ1hpNkR6bkNrUnFueGdMK0ZNbU1saFFpMU5OK0NYc0hhUmxv?=
 =?utf-8?B?UWM5RVdZSHI3T09hQzFhcCt0ekFyaGtkS3hkamRtUzRFcnRMT2RXZUhBL0pn?=
 =?utf-8?B?NWtDT21aUktxY2lwOG4zMlU5RG9iZGJmaURVaXBkTVdjM21JOGFESmJ3c2JV?=
 =?utf-8?B?ak1pODlXaDZnZkhxbnNKdUpkUXkzR3lIT2ExZThqQ0FuMk1SNzlWYjFBOXRp?=
 =?utf-8?B?NDlRQTd3a1YwWHo2d1phekJCcDlMSEVMTEZpZXN5RzhQUDRHNzc3eVNsVis3?=
 =?utf-8?B?ZDhtNm1hTldXeCtyMnc0TTQ3dkVQSGhoeHNsSVp3R1NIb2ZQVCtSWVR5dGVK?=
 =?utf-8?Q?fC+d54r8x7BHUeJ1u+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de15c6bb-5762-4262-4f4d-08df2bcd192b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 21:33:20.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlGhyetg0c3gyKuzLzvjYegLjyL/1wmje2ZAjdWqvS3kjYybK0bkGk2ZJdfrJjZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577

Hi Reinette,


On 10/15/2026 10:31 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode allows tasks to use different
>> allocation and monitoring associations when transitioning from user mode to
> 
> Could "different allocation and monitoring associations" just be "different
> CLOSID and RMID" (in places where this is what it refers to)? Being specific
> and consistent with terms would make this so much easier to understand.

I avoided using CLOSID and RMID terms in filesystem specific code. If 
you are ok with that then I will use these terms.

> 
>> kernel mode. The mode is enabled/disabled on a per-CPU basis.
>>
>> Add kmode_cpus and kmode_cpus_list to display the CPUs associated with a
>> kernel mode. These files are exposed only when the global_enable_per_cpu
> 
> 
> "a kernel mode" -> this is specific to RESCTRL_GLOBAL_ENABLE_PER_CPU kernel
> mode node?

Sure.

> 
> This switches from "RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode" to
> "global_enable_per_cpu mode" mid changelog.

Will change it.

> 
>> mode is active.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...> ---
>>   fs/resctrl/internal.h |  2 ++
>>   fs/resctrl/rdtgroup.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 986b9c942fb2..6b8d14c4bd83 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -216,6 +216,7 @@ struct mongroup {
>>    * @mon:			mongroup related data
>>    * @mode:			mode of resource group
>>    * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
>> + * @kmode_cpu_mask:		CPUs in this group's kernel-mode association
> 
> Could there be a caveat that the value is only valid when the resource group
> is backing the RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode?

Sure.

> 
>>    * @plr:			pseudo-locked region
>>    */
>>   struct rdtgroup {
>> @@ -229,6 +230,7 @@ struct rdtgroup {
>>   	struct mongroup			mon;
>>   	enum rdtgrp_mode		mode;
>>   	enum resctrl_event_id		mba_mbps_event;
>> +	struct cpumask			kmode_cpu_mask;
>>   	struct pseudo_lock_region	*plr;
>>   };
>>   
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 46b2cafd9411..0e638dc654c1 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -385,6 +385,31 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>>   	return ret;
>>   }
>>   
>> +/*
>> + * Display CPU masks for the kernel-mode associated resource group.
> 
> nit: "masks for" -> "mask of"?

Sure.

> 
>> + * Supports both "kmode_cpus" (bitmap format) and "kmode_cpus_list"
>> + * (range list format); the output format is selected accordingly.
>> + *
>> + * Returns -ENOENT on error.
>> + */
>> +static int rdtgroup_kmode_cpus_show(struct kernfs_open_file *of,
>> +				    struct seq_file *s, void *v)
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +
>> +	if (!rdtgrp || rdtgrp != resctrl_kmode.rdtgrp)
> 
> Could the changelog please help reader understand the patches better?
> For example, the additional "rdtgrp != resctrl_kmode.rdtgrp" check is
> subtle but very important to maintain synchronization, but it is
> never mentioned why this is used.

Will add a line in changelog about this check.

Thanks
Babu

