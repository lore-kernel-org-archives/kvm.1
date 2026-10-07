Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D03E63AC;
	Wed,  7 Oct 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397022; cv=fail; b=VFKqbZd/CjrotGxMpClLKmXZTWx3O5zE7w3x7KTsIguCX5mLizUeN3XXhy4F+8OzkteY7criGFoS9ZaUBYgIptyW4Wac9PO+4f6IOXHM+dXWqd4PtYNaAI9j879Ivtkl5iTAjAtYdcN2Lyyyo1s130JscI3laAsXQ8tHhe9gfjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397022; c=relaxed/simple;
	bh=LfGvB7jXfZXSyW6TzrxEQ0owGskRe/xspqKX8UvbaBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nDf/sWrTDYhPsUyOZ8MAKfeWc8nfGPoUOZaCsBx23qN2mLKVT6XC6RL13+uogR2fwduXUesZ8j8uQpPUun0Eu8DJ566OPtWWqxV+eFDn7RIvevsVLIDHa1R09K/6vzdTCrVfniNNBHLTLcN56Soy02ERFJu6m+xm1lYndTEFX30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ld/2v0gf; arc=fail smtp.client-ip=52.101.193.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ld/2v0gf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSIMSc5qVvcHz2L/YTpk/D7Fi9bhKEhbKdOT9ine3ceL4QguMgmZnKzxlWA99I6F2nEHjOAgcGGKkPeSX7Hr8HbcuPwn+oIpZH6No2coNrhpX2DcODXPtLDRJJL3b4Iwi0VtzuKIIAkNOWiEyCBCrX5AkUiCRGnVTG4YeX49HGHZXCBqaTAL4PvrWZMN6P6Aktbf+WGONQZTDUanlYMi3vOIzVD9Gvtb4NxPFEsM0ItbTi6kN+V+l8OLAOIyvlW0U8OkKAH1/Xh+5UZRdkosqCe5b1dWUmC4tNileccuu399qpnGZJSqJV6WwRiCqOjroupvrYOoPSgyBrtxMap46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh79xDfY4U9dkCq8Iu8GxppgDnhflkxs3/XJIXWkBHM=;
 b=xOhDPRhBWMno2vrhRjr4t9RF2v1GBocx89K9/JnQRJgxIcpUJJzNREgwUGFsPBSZiu5nAtjUawTr5rWJ7sDYUIENrD+o8I0HwkSOxxLlbr5YOEnHFzVf4Za2iLJcDkCm0BqSVC5SzusCCZFC12DoLHejd5fFxkVEXvQUhLW/TmMiYhhiZlTw3u+FXU4k71dZctSiO9cJj101CjKz5Uh9TqrQhfzY8pVDr3/Y5QutbMbESr55XdPbBDPZDOINg7vLp4kC69sMSt8RYW9UThCnDTPcv11RHAgcuYbyOaM97LWj8bIlHie7sbziBIys7rNV2fYYiW5gys5ItIHPiuvtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh79xDfY4U9dkCq8Iu8GxppgDnhflkxs3/XJIXWkBHM=;
 b=Ld/2v0gfVB1P4SNsvzDM3J22taarL+w9dk6NrV79y8xUi710KoaCenvQoecAImBnYm3NbqKlpe2Jh7zOcQ3mMDcOtpNbM+oqq4JZAARpHKoR/ysbkM5RZqu1w8psuRYvIXm8Q+OFjhbWT8qnph86qoxzwxpo5WBwmatXs8gA/80=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 7 Oct
 2026 18:16:34 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 18:16:32 +0000
Message-ID: <d40a16dd-2e3f-49b4-a36e-33b0ca8adf3f@amd.com>
Date: Wed, 7 Oct 2026 13:16:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1790976400.git.babu.moger@amd.com>
 <09f0e27da685476211c43fa8ed85b49646305078.1790976400.git.babu.moger@amd.com>
 <4afdd80e-45cd-4d42-b871-fb25e1fd5fa9@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <4afdd80e-45cd-4d42-b871-fb25e1fd5fa9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8974d2-c803-4a69-b04f-08df249f1d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|260925022911599003|260925021911599003|11063799006|6133799003|260925021311599003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	luq6jfiulj3oXDCzSW4uRzbNcXZmzTVsumhiiYyULtGTnrxMIMcvPyT/SJESCUjmVFvVPgXUP0WgOxgiBLahwxxd7nUUcGEYhUdw/+4wHtusj5q+LC6vwTWTYFX4Jyzecxu1d8BX/jOZM463TjmH+Ig3UVMwOQVrQuJFD6TUbky4FyAQPKxI7DWpN7b+Ix4m5pekZ7LIgFrdN4m7Bb3dlAoaonORT9yHz4iT/ZJ/dt0xF5t5fWyMDUPh5+y9i6awxieEOn1QSILCpVwY4FAulsdE/BlVYX9TMrelHgsGyoUZxKhQ1+6XIKpD28iBOJvg1p8xTRNrbCUREMPkajUkmA+AkOV1PqqzKGxpVf4yRvgZmpe3f7dKYK14w6yTO+q9W0rVMoliN+TA/CuOjjU1HKcJaMYurE3DYxOjWEkvZrzPJTyhqvmU8O01ye6ra3EAzES0/jffeSRWtcYugzZ1w6M2CnyK47eRglpLYlBZLttnV3Xd7nLTGBhGUoeG2zFNtuK4vFtwTJQs9usEv+xSPAa/3GslHMTi+SLk+zz2t4r2sjxo0DquafynGfqSLCeDFAfvKBwnQi5y1PGfVY3a1TT/UIRnkcp4KgEmyxAYhJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(260925022911599003)(260925021911599003)(11063799006)(6133799003)(260925021311599003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djZQS0hMWHNwcG4yR25udkRUenp4c3lCNytTVWR1cExMcjcyeXhGdlRKYnpl?=
 =?utf-8?B?eTIybUt0N2dla21BOStHUW8vWFVKNDROWTd2TlBDRGxheWpvMTBXUFBSdWF6?=
 =?utf-8?B?MEwzalZqUWo2ZVpGZEdBSjhQSVdhOXhpNVlhNWtDZVlkR2lCbHJZTGpGOWxR?=
 =?utf-8?B?SUQzMzNIZTlLcEo1T2hycEdJNXZDMEovVEJaRUM4aFJXM3I0WmI3ZDIwTW4r?=
 =?utf-8?B?OHdyY3FrNFp6dWNHMDFSSG4raTJGZ2NVMXlUMGhjaUlRTVEwYjRKN0dKTXlW?=
 =?utf-8?B?SUlySzQzYmIxSXowdXZrMWJ5WnRhSWRXMndIdDVMUlRuQUhPMnh5blUreFpM?=
 =?utf-8?B?dDJPbjVvZXdHYlozeFJFZG1RbWZpQmlaTk5KUnV3TGlwQUlTZkhLMkNFQmpQ?=
 =?utf-8?B?Lzk1em40S29KZVBXVDBZMFlmTmphVUFocGQxanUwc2wvQlI2UTlyRSs2UStj?=
 =?utf-8?B?RUNTZzg1RHNjaTFZd09HUFlQNittTTFPRGpZYTEvMjNIZkF3anAyaG43SXhL?=
 =?utf-8?B?bFJlZSttMEtNQjhIc25uaVk0WDdPQlkzR283d1MvRFUwbk5oZk1qRFJFOWRV?=
 =?utf-8?B?U01Oamg5ek1TVE1saFIvRDZNUlp2Zk9raWQ5c05ZRHBLaDJUa1FDdDdpbkpD?=
 =?utf-8?B?MmFhRW16bmRvZkt0SVh0alVRUXdGZXBnR2RFVVhZd2dwdEF2WHFNMzhCRFhM?=
 =?utf-8?B?SmwvcXNvMVVSeU54ZC9DRjBVSVZjdHowV24rbXJhYlZUcVZxWG9Ya1BSMHRo?=
 =?utf-8?B?VkR0V1lSM2pNS2JaRXBNRDUyVG9jYmQ5YS9xbmY1ZU95VkowUTVqWHRjZHZo?=
 =?utf-8?B?cmErcEd2dGxIY3I0YXFhQWJ3ZzJwc0gyR3J0b0FuREI1K2JlWUZIUDFmTkpa?=
 =?utf-8?B?dXhldTNZWEE5WEVoODFVcURhc3g5b2hobHkzWFN4V2JMOGx5ZlpSM1dRSUVU?=
 =?utf-8?B?SkVGc1J2OW5mWjBQcHI0ayt0T1ZVTjgrbVRBait2NEU4eUk3VUpBWDJ4ZFNJ?=
 =?utf-8?B?anNPdzg2UzNuY0d0ZkFoRHQ5Z0VKYTR5ellSaGlxazhSMVBWV3hIcVRPQzE2?=
 =?utf-8?B?WmZEZVRWN1NDRlROR2kzcFZnREJrOURIQnpOUngyNURBR0paWm9JQmVkeVcx?=
 =?utf-8?B?WFdOaWdUd3Y4L3p0OEg4ejNPQS85MUR3WFIrY3VnRlFUVVUrNXFEMmdJdkow?=
 =?utf-8?B?SU1JY1B5ZkdVcGdCNk43OCt2cnB5WDNWMUtESjlVMUordTFEOXhnNmFub2VF?=
 =?utf-8?B?elpTWTVDdDBFWHF4ZEp5ME0yNDVtdjVwSTU4eTZkM0hNQ0dJcE5NTjNtM3Bu?=
 =?utf-8?B?Nk9QbTU5ZFRKUXNvUVVHVTFDV29jMDVoVFpUbmFrVllZekUzVCtobkJ6Skhj?=
 =?utf-8?B?VGtkZjVYTlI4SzJXVFZnZnYxMFdVM2JEZFY4MitQWFFYNmlCbnF4eDVxVGpH?=
 =?utf-8?B?eHpxazJET1ZlMXpWWjEvdXBvTXVnWDF5bG80ZitnOHh1dXJtenU1T0lxY3RB?=
 =?utf-8?B?RG4xVk9QYkdwZkRkakJVZ3ZQUCswSDVIRy9kUmhhMytUVkNHd1F1OUhqa1ds?=
 =?utf-8?B?OXdvb09TTGVheWF1dHcxSDZwVjVxVi9lTEh0UnhXMlFQNkN0dzh6YUZ6anpD?=
 =?utf-8?B?cGRqVWRrWVlGVWNEVXMxWk5MdjZlVGx1emRtOU1kWktMdGNiNlYwRS9qTE8z?=
 =?utf-8?B?eDJydUFYT0dyamplQXE1cEdRSzdubWF3eWMyeWlUcEFKamJwMDhFYW00T0U5?=
 =?utf-8?B?NmZJRmk3RmJKOVBCb1VvZWhkZTlPQjJZOWNVaFNiVmNYallpbVVMWmZQZzVP?=
 =?utf-8?B?cDR6MWJCbXI1WkdjTEtQWkRQTXBYNzQ5L0NxWlpFNk9kUEEwZVp3NDZBYlpq?=
 =?utf-8?B?cmZLbWN0OHZoQ2RYbkNPTWlXU3IzLzI5OFE2cnpiU1JCYnBScVg4L0t2cm8v?=
 =?utf-8?B?SlRReGh6YlhMeFJZalhvT0RDNGVCenpKbWFnTDl3QnJQUGJKcERRbTZWQWov?=
 =?utf-8?B?NzNmbkluVC9JTUZjSTR3OHJ2S0NRMkRLM0VHQmVkU2RVN0R0S0xEdUQzR29Y?=
 =?utf-8?B?VmhSRHBpUEo4LzFtdXZuNW1qZ0J2WnNFa09DWXZpdHFOS01oaXdES0lqdXJO?=
 =?utf-8?B?cEpZb0Z6cEZVVm9FQlBhQTZldVdnSFg0a2hmWEZqc0ZybnRNeGh6SWVsOG8r?=
 =?utf-8?B?QVpTWkhuR04xTXVkanFXYUFONyt5Y3liek9HSUlVMTFKb3k5MjUreUV2WXk2?=
 =?utf-8?B?Q1BESWVpQ0hXcDJLMUJoZEcyQ083WWY3VytOb2tJRXNSd1JwZGQrTGdiNk56?=
 =?utf-8?Q?tn/2fSeeadtDILYq4m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8974d2-c803-4a69-b04f-08df249f1d94
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:16:32.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMn76K0/k/geVl4EIsUZZrNGcGuTqi9TuGMUiE13//GGn062hvgwWdy1cH7cniF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

Hi Reinette,

On 10/6/26 12:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/2/26 2:26 PM, Babu Moger wrote:
>> When the user enables counter assignment mode by writing "mbm_event"
>> to /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl resets all
>> monitoring state and sets mbm_assign_on_mkdir for subsequent mkdir, but
>> does not assign counters to groups that already exist, including the
>> default group created at mount. The counters of those groups return
>> "Unassigned" until the user assigns counters by hand.
> 
> Above summarizes the context and then below follows with the change,
> what makes this deserve a "Fixes:" tag? What is the issue needing fixing?
> 
> 
> Consider, for example:
> 
>        When the user switches counter assignment mode by writing
>        "mbm_event" to /sys/fs/resctrl/info/L3_MON/mbm_assign_mode,
>        resctrl frees all assignable counters, resets per-domain RMID
>        state, and enables counter auto-assignment exposed to user space
>        as mbm_assign_on_mkdir.
> 
>        Even though counter auto-assignment is enabled, groups that
>        already exist at the time of the switch, including the default
>        group created at mount, are not assigned a counter. All MBM
>        events read "Unassigned" until the user assigns a counter by hand.
> 
>        Walk every existing CTRL_MON and its MON children after the reset
>        and assign counters to their MBM events. Enabling "mbm_event" now
>        leaves the same per-group state that auto-assignment would have
>        produced. There may be fewer available counters than MBM events
>        across the existing groups; in that case stop assignment when no
>        counters remain. Events in the remaining groups read "Unassigned",
>        matching the behavior of creating a group when no counters are
>        available.
> 

Looks good. Thanks

>>
>> Enable mbm_assign_on_mkdir and assign counters, while there are some
>> available, to existing CTRL_MON and MON groups so the switch matches
>> mkdir auto-assignment. An event left without a counter reads
>> "Unassigned".
>>
>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>> Cc: stable@vger.kernel.org
> 
> tip tag order places "Cc:" after author's SoB.

ack.

> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> 
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 73413cb128ea..fca0734bf346 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1300,8 +1300,7 @@ static int rdtgroup_assign_cntr_event(struct rdt_l3_mon_domain *d, struct rdtgro
>>   }
>>   
>>   /*
>> - * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
>> - *			     a new group is created.
>> + * rdtgroup_assign_cntrs() - Assign counters to MBM events.
> 
> This patch adds another caller of rdtgroup_assign_cntrs() and above thus correctly
> updates the function comments to not just mention the original caller ...
> 
>>    *
>>    * Each group can accommodate two counters per domain: one for the total
>>    * event and one for the local event. Assignments may fail due to the limited
> 
> ... but the detailed function comments trimmed here still considers original
> caller as the only use case and uses original caller to justify why it does not
> need to return an error.
> 
How about this?

/*
  * rdtgroup_assign_cntrs() - Assign counters to MBM events.
  *
  * Each group can accommodate two counters per domain: one for the total
  * event and one for the local event. Assignments may fail due to the 
limited
  * number of counters. However, it is not necessary to return failure.
  * Users have the option to modify the counter assignments later if needed.
  */

Thanks
Ban
