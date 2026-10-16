Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC6415F36;
	Fri, 16 Oct 2026 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189289; cv=fail; b=GeZU9Knr5Lg8lMuo4nRB3kBpBflUPx0JCrN1Kfk5SCMsFKe9i/lXuCiLw/1XcZm4fAkybAodzDuC+d0tPiSXOyUCw3JTuzAomMNo7n4cKTbXuWoMXaH0tiNpjSMcrBMgsP9VZkMwhCw3TufbCEur5NKvfy+b4/RnpHs93j+CGMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189289; c=relaxed/simple;
	bh=e0qJtFxuX2KlBvLOTzerGsWLSNqSDIPcDUH01GbOUHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/oQTUSMbonN50KWrfZ2qHpXGMPxDn+ZOy13zVwKhbP4ot4/p4oF7L9DjKAPBdVGMBScNOcopCC4XuYhCep61OPuna1WAN0wlyVpXuCcw09ysZRkOkuWgr1UuSeVw0zk6s9PrACZQ4KstqxxUyHO1aKR99fm1oI7ipuvdcmXhvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c0HkQym5; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c0HkQym5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhE9XjkMdfdwawr04D+5EQZGDaGa9thALv3Gml55vY2I4/koQKEZeaRdw9iDcDMJYC9dmuzoy1MSBhwe3CsfM7mOQ/K/Gk9PVxMgZkWtS+CwWu7erubU84yKoYXfPMv+TcB9b21bLVi6ExF9mhNtyTVFlrmrMAR6TQQVrhRucA87NGD0ypba7fPPLwsQkgESuwMyYG6NHMtWbbMK9w703Q6MF05nkHO8z7oBMwrdjD6ZR4/+aYmy65+c9A1BnMMF7nf9j+++3yZFiZxCekjajiR+whNFeQQzAwPr2rS5A4DVP3VSrk6nKcceqbCg4dq1s3RxJx3YQJ639Vm4S8ND2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXD8c2eg/o+C0VBRi3hVhJigZCjLvKpwofHKBWfbQCU=;
 b=ubaViCi31QdvwP8xNmsNvnMjrkpOuKbW1ly8q1xDT2Bw4xOPRtabTctcANH90qIwRC/Hm/8VP4WUWPN5jgC/oo0GdGrFYoqatpqdARYsFznOmGBdTriGS8uTfn/n+FxnqLBSTsHNb6nYTYfS23QmECEYm7Q7nXFBUslm0y6JDsarKQ5vqrIdzG98BalYaCPcol91vHoxTx8S99eh+uaYChmh2aan1KacktkXeD2fE1HsBXyX0h/goxiHn5Gt7QtElM2DeKA1cQ8Mun+C9uaeypzevPZpXaQ0wb3HUj8mo7xSV1Hy9EtGAnLS82pVl+iLQ3fxXNZ8T2oIDMSyYVTcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXD8c2eg/o+C0VBRi3hVhJigZCjLvKpwofHKBWfbQCU=;
 b=c0HkQym5X3o73AFlz35j8gBH+aGCstPUT5M8BFemZmdU0pUzjVNIJrzmhwfTp6yBrKR0jWUmKgmt36W5wE9kfRC/mdxUPqUozJ97pVkYf3vn+y303cu2u7dkGuAeWrhKl7xN2Uc0msHh960J7mMDE7LhcSNkBLz78cua6vJ2JPc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by PH8PR12MB999273.namprd12.prod.outlook.com (2603:10b6:510:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 22:21:24 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 22:21:24 +0000
Message-ID: <7cd528b5-3378-4973-8e5d-15dde78c25da@amd.com>
Date: Fri, 16 Oct 2026 17:21:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/18] fs/resctrl: Add CPU hotplug support for kernel
 mode associations
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
 <553a9ab0695fcb7a0c1e68737582663d6fb3c080.1790867441.git.babu.moger@amd.com>
 <6b9b241f-b459-41e2-a65a-2ae0b478b2c2@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6b9b241f-b459-41e2-a65a-2ae0b478b2c2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:806:28::9) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|PH8PR12MB999273:EE_
X-MS-Office365-Filtering-Correlation-Id: f80e0698-d157-448f-07bc-08df2bd3d023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zRKLop81/Tfopo366CPVybwAtH0evU0BvmlNEJ60lySj2G+XkIGL5tA2pnHtYIBFcSUZwYisk1BnxFQ1bxOef9YQPp2+DDwPRoirDu47+00SK3hnaa3pZPEhTxIiv/SnLiP90ptFi0ji6G0YF3szAVr2pozagFbnMq2gUpvQXzRZfE7ylr2KwS1XY/fIHWfrbEiXjVLBHVr/2NTYCZSfEHLetm3RBXKymM9C/EF0axbcUGooelbzTI1NnvIx54O6MRdoVGZBQgSWmGCWtBB65O8Ej1oK9NIYJigs0/Zg5+yBYqKHX0517ABTK/lQ7ZQ12zA07rl0DvIBWwnrqh8n18nrTQxrfIAkQ9qmnLYi9VHLV7W9ILXQvKkwJ5QS9kz7nzBoCQrCP1s4pqTxxO9imCV9S/DLJR6B8Lrk3R70mEQid+9zuRLkJE6dFC7J/zCRG243FcHcDxzFd3nGWDE/Wkjs0Zq9nfn5YLzRgO1rI/dH9Y70Bac3TKilmvYj6kovFQebG0PEDEE2DbsTuCMOgXzzKNIn6hjYxOaLeUTh8UEYIaaeDq822eYmMFrf5OgPX63HI1FXQyWcUgxKEh6aD16JVTgxNge9NHMJP8FfWOeKfwl49reKnBdzSxSfK8c24A7v2CDQWFlgFKRkW76vLUPS6YqBGaaiev0xGw0eYTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2IvNkVkQ3FYUC95eEdsK2hDZGkwa3lYbE5ram02ajBUQmo0a1J3UDhOd3hR?=
 =?utf-8?B?WE1lRy9qdW5mNXJnV3l0aGxvUnhtMHI5bkV4Qlp5amVvSnZpVllwb0FBWVNi?=
 =?utf-8?B?UlpudFhWa0drYnE0anVkbXZrT3hKdVJvNzVRWTF1dmUxT29SeUJNclI3ZVo1?=
 =?utf-8?B?SGNxUktRTXlSM042TlpKTTFEUzk4ZWtNQmdHdHg4Qm9JNHZsQXg3a0QyZlJ0?=
 =?utf-8?B?a2pDUlBhUHppVW5yNHNNMUVacnBxQ2RqWXIrNm5zSXJkSGdtOTNYOGdqMlUw?=
 =?utf-8?B?VmU1OXhqeWdrUjlKMEVKU0FmQ2lzdlBWKzZBSTVabUdKM0Q5VkhwVnFyOTVk?=
 =?utf-8?B?SDRWcnZZSWtaZFFsRE02SFE4QlZhRmNEb2hqUndKTlBqUjlzUTlJOW1xbzJT?=
 =?utf-8?B?RVJZN2tUTDFtQWl2d0FYSzFIMUZyd0Z3ZzNoMG1SeU5YY0k2b0hKUDVldGNj?=
 =?utf-8?B?c2ZObXpQYVFVeHBmci8vQThESUlndUFlcllUekVSOWdXRWxOd21jN3FqM0dR?=
 =?utf-8?B?SjdZc2Jabkt1Nkx6QnVOSk5ROTVodTRSSjNYVUY1cXpIazlhSXF4cjZrNHFX?=
 =?utf-8?B?MFN2cmtCUGUrYlR5UkYreENoMXhuRlh2WFEvbUZKcFgxRDVkcHAyUktVemF5?=
 =?utf-8?B?WE1zME9tVGhYMGxzdzQyeFA1aS9Fc3lWcTd4L0xMVXFqc3dVWEsxUzNWYlJV?=
 =?utf-8?B?TVNBNHRWZktyK0Z1aFJPNDFwYlk5Y2FDTldIaHNJbCtoQ282M3ovZkU1Skho?=
 =?utf-8?B?amdkcWJtK0NaSG5aSWZTalpUMnlDeTVvMUV0dmJ3ZDg3MUZWTkhYc2RiU1Zw?=
 =?utf-8?B?SmlSOU9wRGJwYWE1U3hzblhvdWVRa3NZWHVaK3B2M28ydWovRDBZYmo4WEQ0?=
 =?utf-8?B?WTZKTUlaUWpWSkRNZXdxTUdPMkpPd01BZEMzb2RkRGFQM2VvaUNnb1VRY0tn?=
 =?utf-8?B?WXRNYklEUDZUVVEvYWo1VmNsS3pBem5Vc3docWh6M3RKU3lIN2ZBM3pzQzAy?=
 =?utf-8?B?WWhMaUxtbEhXUXFTTlN2aFVRalZKTCtjSEZqOHp0VlVyTkxTYTNQRDM4TVBs?=
 =?utf-8?B?bUtuV3E1eE1iVUFqa2ptTXJFSzFpcHVCN2Fad1FUemFSTTdzTnhkTWQ3Um5U?=
 =?utf-8?B?eUpKSWw5WWhQM2ZFL3dyQ0k3Z3ZNVnZOcTMxUVUxVE0yb1lDK2dmSm9OZGlk?=
 =?utf-8?B?bGFoVCtqV1Y1WnVzcUJPbXFJMU5PSWt2MmI4R1pnMTcvRnUzenVmVDI4dkgr?=
 =?utf-8?B?MUE0NnFiQWdNNHJsbkp6SnRyVjEvcHZCVFR2QWtWYVlaQmF3UzhuV1VSUkk5?=
 =?utf-8?B?eUZtc1c1OVpMWDMyMDNCM2E4eTQzZjNnVEVaSiszRmJjNFYwRHlUdkFmeFdh?=
 =?utf-8?B?NXUrNUNCL2NOQ1JQcFNMMVk0SWxWb0pSWFlxMWEwSnllZTBVbTdyYUM4Q3JQ?=
 =?utf-8?B?Q01jNSszR2FBYWlUQnlrQTczcXlDQnMrbTdxdWw0amczb29IMHVPSnpuNjR1?=
 =?utf-8?B?U2FSTXlETmlTdk9zamFtNU5INEwzYU5ZOHFpYXdxMkZIWS9ZbEo4NjF3OTVR?=
 =?utf-8?B?bkFYeHZNc3BvL25aSXhoZ0ZFM2laT3p1MVgvTWRkZXljTHZ0eGpsUVRlclRM?=
 =?utf-8?B?SFpJY3pidXFkenIwZVZTY0UzYnBHZUl0U3g3czJSQkR6M1hLQ0hZYzhFb0F1?=
 =?utf-8?B?UnFwUUl3QmlGRzc2bXdQRHI1aGxVNzF3UTlRRmFyRllFZHl5TnFrL3BUZkpE?=
 =?utf-8?B?aTcvUWllNE1BdW1JaXQzVHk1eGROMTVjdzhFUEdCWFdiN3JQUlZ6MCtLUk5B?=
 =?utf-8?B?SmY4VnNQRDRBWTJHSFowQ0dtM1R0TUlFVDNpWUdhV05pSjRTWE45NHA0T3Vq?=
 =?utf-8?B?cHNlaGpDS0FqOGRKR1NSZDlWNUY4QUF6cXhsZnluL01NbEZoTW9LYnp2UlBn?=
 =?utf-8?B?WGhnREZWZC9aQUo0YkhMQ3daYkZKNCtUOTJLMmVnL3I5aUxpQmsyWmsvY0hH?=
 =?utf-8?B?Z05hRWxYUGhUczRUeWh6REpIUURqT2RGbEZ5VzRjVTFVRWxTTDg2NC9GMlR1?=
 =?utf-8?B?UVlBWUF1MzhUaFNRQ1p5VTY3TWUxRHUrRGZoOGVZcWtRUzRDYXArR0FLUnlV?=
 =?utf-8?B?ODA3b0pFYlBwNnhNSXAwVVRSTTh4YXNNblBkSng3UEk2WnFDQ1Z1OFJLK09w?=
 =?utf-8?B?SHdmbXFzcVo3KzlwYjllNXByVlJJcTJTTW1XcEx5RUduclJldGxRVUpmL1JV?=
 =?utf-8?B?V1F2ejdQSkhKWU9BbnkyR3U3Zk1tS1o1YzFYa0NZdUFPQ3pzU3NMOXhhQVFy?=
 =?utf-8?Q?k+F4BvU2UhFlNE1Stm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80e0698-d157-448f-07bc-08df2bd3d023
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 22:21:24.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xmrbotRXyGNy7ou9sIf0DFjh/MYbI6Kr7cctlb8VKrm2r+SJxz2fDerDZrBlHg4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999273

Hi Reinette,


On 10/15/2026 10:33 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> Kernel mode allocation and monitoring associations are maintained on a
> 
> wrt "Kernel mode", this is specific to only the "global per-CPU kernel mode", no?

Yes.
> 
>> per-CPU basis. Extend the kernel mode infrastructure to integrate with
>> CPU hotplug handling, allowing kernel mode state to be managed as CPUs
>> enter or leave the online set.
>>
>> Introduce resctrl_kmode_global_online_cpu() and
>> resctrl_kmode_global_offline_cpu(), and hook them into the existing
>> resctrl_online_cpu() and resctrl_offline_cpu() paths.
> 
> Above just narrates the diff. Please check all changelogs to match
> tip changelog expectations. So far they are light on context/problem/solution
> and many miss an answer to "why".
> 
> It deserves a mention in the changelog that the active kernel mode is automatically
> enabled on a new online CPU followed by why this is done. This is a big design decision
> that will be user visible but I missed where this is highlighted and motivated.
> 
> Changelog should help reader to understand the patch. In this series the changelogs
> provide little help.

Will rephrase:

"The global per-CPU kernel mode enables kernel work to use different
allocation and monitoring associations than the originating user task.
The mode is enabled and disabled on a per-CPU basis.

A newly online CPU inherits the active kernel mode configuration to
ensure consistent kernel mode behavior across the system. Likewise,
kernel mode state is cleaned up when a CPU goes offline.

Integrate kernel mode handling with CPU hotplug to apply the active
kernel mode configuration to newly online CPUs and remove it from CPUs
that leave the online set."


> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
> 
>> ---
>>   fs/resctrl/rdtgroup.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 0e638dc654c1..f5c7790f7970 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -410,6 +410,17 @@ static int rdtgroup_kmode_cpus_show(struct kernfs_open_file *of,
>>   	return ret;
>>   }
>>   
>> +static void resctrl_configure_kmode_global(const struct cpumask *mask,
>> +					   struct rdtgroup *rdtgrp,
>> +					   bool enable)
>> +{
>> +	resctrl_arch_configure_kmode_global(mask, rdtgrp->closid,
>> +					    resctrl_kmode.ctrl == KMODE_ASSIGN,
>> +					    rdtgrp->mon.rmid,
>> +					    resctrl_kmode.mon == KMODE_ASSIGN,
>> +					    enable);
>> +}
>> +
>>   /*
>>    * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
>>    *
>> @@ -1114,6 +1125,48 @@ static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * resctrl_kmode_global_online_cpu() - Program kernel mode association for @cpu
>> + * @cpu: CPU that has just been brought online
>> + *
>> + * When global_enable_per_cpu is active, @cpu joins that association and is
> 
> Please consistently use the enum name in comments and code to help grep find
> how/where it is used in the code.

Sure.

> 
>> + * programmed on.
> 
> What does "is programmed on" mean? CPU is already online.
> 

* When %RESCTRL_GLOBAL_ENABLE_PER_CPU is active, @cpu joins the active
* association and is programmed with its kernel mode configuration.


>> + */
>> +static void resctrl_kmode_global_online_cpu(unsigned int cpu)
>> +{
>> +	struct rdtgroup *rdtgrp = resctrl_kmode.rdtgrp;
>> +
>> +	if (resctrl_kmode.kmode_cur != RESCTRL_GLOBAL_ENABLE_PER_CPU || !rdtgrp)
>> +		return;
>> +
>> +	cpumask_set_cpu(cpu, &rdtgrp->kmode_cpu_mask);
>> +
>> +	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, true);
> 
> Shouldn't CPU be added to mask *after* it has been configured? I understand that
> configuration cannot fail but having the order set makes it easier to make changes
> later.

Will change the order.

> 
>> +}
>> +
>> +/*
>> + * resctrl_kmode_global_offline_cpu() - Clear kernel mode association for @cpu
>> + * @cpu: CPU being taken offline.
>> + *
>> + * When global_enable_per_cpu is active and @cpu is in kmode_cpu_mask, the
>> + * association is disabled on @cpu and @cpu is removed from that mask. A CPU
>> + * outside the mask is left unchanged.
>> + */
>> +static void resctrl_kmode_global_offline_cpu(unsigned int cpu)
>> +{
>> +	struct rdtgroup *rdtgrp = resctrl_kmode.rdtgrp;
>> +
>> +	if (resctrl_kmode.kmode_cur != RESCTRL_GLOBAL_ENABLE_PER_CPU || !rdtgrp)
>> +		return;
>> +
>> +	if (!cpumask_test_cpu(cpu, &rdtgrp->kmode_cpu_mask))
>> +		return;
>> +
>> +	cpumask_clear_cpu(cpu, &rdtgrp->kmode_cpu_mask);
>> +
>> +	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, false);
>> +}
>> +
>>   void *rdt_kn_parent_priv(struct kernfs_node *kn)
>>   {
>>   	/*
>> @@ -4896,6 +4949,7 @@ void resctrl_online_cpu(unsigned int cpu)
>>   	mutex_lock(&rdtgroup_mutex);
>>   	/* The CPU is set in default rdtgroup after online. */
>>   	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>> +	resctrl_kmode_global_online_cpu(cpu);
>>   	mutex_unlock(&rdtgroup_mutex);
>>   }
>>   
>> @@ -4939,6 +4993,9 @@ void resctrl_offline_cpu(unsigned int cpu)
>>   		}
>>   	}
>>   
>> +	/* Clear any active kernel mode association on this CPU. */
> 
> Above comment can be dropped, it just duplicates the function comment.

Sure.
Thanks
Babu

