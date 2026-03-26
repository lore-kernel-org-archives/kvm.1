Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E7312815;
	Thu, 26 Mar 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552257; cv=fail; b=ptdssEjDx2e8YxPPFRyh4cAW94isAIZyiv60NUW1/JxA4ePazIZ9twLTTXXSlbLVfHgUhgL4LhsfpjJi3DEKdpZjtYWtLxoIh3SagW7bNDtu+rfIQmuvxbMp2PFsUPM71i1M7TE4tpepkHG4h/j2x4HAX5l2pimEYuYpZfRD25I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552257; c=relaxed/simple;
	bh=EzFgYl8dhLQlSQD3c6xJazQoRKhIA9M4UPn7HXw2aBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GveIOLGcJRtfGDqk7YAvViUWGVOBENcW/gW4ClviP+JKzky6VEn2inK2B1OoLtFYfOMnbT6b+32yV6vQQyMdRicctdscngFs79/WfGhAeoR+l5F95h503i5qYrNLXxvCDeb2IX665J+5tasQkaeNvD6mXndHkpLx61E21a6CZn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZWpD8YVG; arc=fail smtp.client-ip=52.101.57.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZWpD8YVG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwqFQVXroUAjJhvgfz6FQY+pP0amjqh6HRoUBblb4dlBsYkI/RUGgyf4w8cUhmBokHWUzSeg2NjLbor+kkIsKmPW1yfVc19b5WavvSKPXi4GhqOeL/wed2Pn4FzL6BfQLBvQGXTDtL1xU3N7O6b5aP/nIFc3zZbsMgQ6pi4vRdd2l01kdkFTanJloLVdEyvMhPDzLpizKy6QQWCVosNQMTImnx7jgN2NT9+znnyttIsSygvugVtgAmbqA6Mt2auezr/IJqeI7aaktJekfgOl3xYHL0TRT15Gb2lIGpp/kAdj9oUtRzykZnBaaYLczDiGMq4kfrjBbEU7X1sJ0+rxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaIv2RWCKTeJgtalFRXFZ8b+nFsVCnNgOu5figTpBaQ=;
 b=ZVRAXkNPCnN/IKHFWpBZNT6KE9L6chyGoRP8Kssf1HXg3HUYt9buslRz+43OdKJ+tJAeJeVf9MjvFdlWnIf5F8R192NWCC2GjifGE9iR90eKUcv5b3h+km/VEpjn0tCTybncltwKEOEVx/YrsRCjAkJqKCJ/WBBmG31t1l43O85BJ2eqO00zGgT7k5PUQmIBNszx6Y7W8i/20uKf8au9vs8FB/O3bgfx+e0T3JD4sJa1LQwl5ERtA+KKWVDedad1U2DZc4aaHBEm0TsE/FEVFsb9pvOZV6olWpHPfUbBi7rOW2Smhy+m9jGiOXcZ6rpvQpnsQLmWknJYoRfKWSqMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaIv2RWCKTeJgtalFRXFZ8b+nFsVCnNgOu5figTpBaQ=;
 b=ZWpD8YVGIEqe/jOtGKlVqXMWSnOuG0QyHjk98qP3oWq4VXijCa/+IOFOJfl5jSWaMJmCDC9xAUUgJ9BIarkXjUv7hfskX5V71GGlj2gnTmFkcS0CL4Btr5eLbMjatFB++3Uj7GuCQ7NFaFz4hf2dOUurNz3B1tg+MDUjTYJSFqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB7259.namprd12.prod.outlook.com
 (2603:10b6:510:207::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 19:10:50 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 19:10:49 +0000
Message-ID: <e769f655-6aad-4f00-b978-868ec3a9cc42@amd.com>
Date: Thu, 26 Mar 2026 14:10:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] fs, x86/resctrl: Add architecture routines for
 kernel mode initialization
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
 <72315f83ddf35b0de53fb911f46623782d95f507.1773347820.git.babu.moger@amd.com>
 <3ef56c9c-cfe4-4e3c-8598-f2217e538c8c@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <3ef56c9c-cfe4-4e3c-8598-f2217e538c8c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:806:125::24) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 60deef3e-f822-4d49-cb26-08de8b6b6472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yKkUqcqF/USO0bgbDot0+IJAte5Yb/LlNzwpt0nWfriFgsP22XmT+Q+DdbAkwEt83NuUZJX06gBKSFuVQ3p9HqpP402fbHBid8hePEHFVwf2sVuSM3nr2E2Obm6kCW+MLV4no9ihKp0xB0JkUHtS/jMG4p+HPmVtQqLIWD84NkdZEJQdi5tHos1k36paId9T+lsp2UwPsNnyVGxD09FgNsUOj+OuCkglVIA7gUqshyqClJISnrI/3O+Hs3yA4r5ozh/LVHwthIz/iRd+Ab4cmVO3Vu2gyddGnBaS2EAL0/rISrqT5h+AvdjLCOySHE5uvGLuW/uok2Re0j/lHUPHiPTUgAUafV8nFEbv84IMAdLVQmem04bN2/NE63lGSWIsPNBwvEBMaGwdCEuF0T38U/hLSlQeNZMBiE3uO9VrHLSOgjijC9AdDz4sewFDEu4NuIHTdCz44iDD5rJ03/qegb7ZbTm0RnYBSrPZHtU2r731rEe8IETyQo5GGbCr16EBXUgyOCf8O00Ck6QT7+uaVK8S8mIyCugswIhDwUK6YSwbex/gl5B6+PjjiupkPp2XkdUyEHaCe6gMTHLTt+0n8bEp65wTOrpzJkYfj5grX+LTo1LtrVJkb4lcXJkbW0vrB0ufT4Shmbexrv66FeIpHvxhJlqM/qjwt8RxflZ1a13vfpgyEJAvE7sxi8pY7+1i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJKa1ZhRVRPRjBiMVNLK3NIMkVTUjNseFU1ZS90YzVxdzZkSG1uWGFiaWli?=
 =?utf-8?B?Qk5PMzZiSHBCb2hHRzZXS0VWMUJJNFp3aVU4ZS9rdzlDTTRxdlBvTXdKR3lS?=
 =?utf-8?B?c3E3MmxIQ3VMRVc4aFhFTm9OeVJvRkVYTTU2dmFWbXZybGV2NkpFRkFPUFRZ?=
 =?utf-8?B?RjRQVTRJL0xVdHdKRlpHQ015bitmL1AwVkM5Y3BNRENzUmc4NUhjYStMWFkv?=
 =?utf-8?B?OURYQzEweEYzTGlEdERRd1N4WnlaUVRnRjlBOGlvMisyR0ZkbGJub3greGov?=
 =?utf-8?B?aU1iazFqRURqZ0x1UXJ4UnVlS2tFelhGRGE3RDFtbHI1VGZzMTdKQTlhQWpo?=
 =?utf-8?B?VzB2VkZFTFVVZXIxKy9hT0ZoSE9ua25FTCthZ2I1T0JaYXZrVkxxZDhlMkw4?=
 =?utf-8?B?Z2FUUWNHVk8rRUJCYUpuUEtkOVZZNDd0eUJPMUhJWUtZdUhTMjE2YmtEck9a?=
 =?utf-8?B?RjRZbFJTSUI4Z01UL2c3THVDbzJMOUR5SDgrdWU4MXhMWkJuZ0JuNzlNdDc3?=
 =?utf-8?B?dWVMcWJhM1czenVteTdmMnRrWG1XSGRnaDB6ZWVBVXprem1Xdm0zb2tiNFY4?=
 =?utf-8?B?YjBZcHl6VGtvUlJvZ3UxT2s0UHl0emFIS0pRV29STzRwUzF3ZW11aU05Ymp2?=
 =?utf-8?B?N0syYlFjTUFSM0FUUlhaa2JJMUdZU1hpTjF6bUxLNUJkVkRxVUtLRVh6dUVn?=
 =?utf-8?B?MlV3dHRCZ1hKZVYxbmM0VHhyZlR2am9BR2ZIekdVa0hWZ0lrQVg3UjRjS29N?=
 =?utf-8?B?MXpaaU1TV3VRd1VqQm52VHM5RzJSRytma1NnZ0UrSlVlUTJtdVJzY0pHcXAz?=
 =?utf-8?B?ZE9hMVZsbTNvbUFZbzIvVDIwZzF1V0QwTm9pS3BjLzhrN0lQUS9BUXdwazVi?=
 =?utf-8?B?Z2d2VkVaeVYyaFNkTW1oQmpPdldBS0drZDM4U1RucjkwUnE3TSthbS9KUXFn?=
 =?utf-8?B?V0hsYWM4MEFIWStJWmJkUlFmVHR6b3RRNWRQYyszd1I0SXdUamRPRm1TMTY4?=
 =?utf-8?B?M05NL1BseDJpblR0U1ZIZFNJaW5BUk5Ka2Y1VUpUR3hoOU8wcllxK1hFL0Rp?=
 =?utf-8?B?RGdXTmFoeDhmektiTDByL3pOWUIrdlV1ejUrQVFYZU9IYTE5VDF2RVNCOVEr?=
 =?utf-8?B?ZWU3TEFqVEpQSGtHUnRiVVAydzJQRkRoSnEyR1c5QkdRaFFlS0cvemcyUGRS?=
 =?utf-8?B?OG5UOEdGMDZSYW1NbVB2cGFjSHNrSk4wZURrSUlzZlc0YU9wTkJPRkk4dEVZ?=
 =?utf-8?B?bWYrKzJVU3Ayb3UxUW5GYkg3bWhKT0U1NWlFWngwTG9QZGRnTGNlcVQrMmNa?=
 =?utf-8?B?QjRLeWQxVGdISDRGZytveUxrTWxoR3daaCtQTXNrTi9FSEI4alZEOTNDTlR0?=
 =?utf-8?B?Z2dsckp4WnFkVDRtRzRvaUg1RW5BTzFvM1ZSQkk0VGhwSnJwTnNqUnJzaTg4?=
 =?utf-8?B?azBHNnA2SXdFeEpzeDliaysvbFpUQm1WY2lyaVBLczQvYlc5UEhKV3h4enhY?=
 =?utf-8?B?clFYUUtmOW5tVitSTmwyQWhYVmVSeUZYRFBlUjJoVzVabG0yODgxamZNRWIz?=
 =?utf-8?B?N2xJTlZuZHQrOWhnbnM5NEd5NDlXK21HdVpDUi93Z3RUbmR1VFNhVHE0VDFO?=
 =?utf-8?B?aFU4VVZYOE04OEdTbmQ1SFRhN1NGTDlyRDNyMGo2a2doK1ExTHB2QXAyS0k1?=
 =?utf-8?B?RkY4UXhUc1NTQ0NEOVJ3SVhZamN4aXRTeHZYVlB3UlVjNE4zbTE4V2s4a0hZ?=
 =?utf-8?B?WFQ3S2tYb1oyTnJ3MzRkK0ZxY044bUZTcE5zdHRlZEQyeXlycjNkZVVoZ2hI?=
 =?utf-8?B?WjJmdUZIV3J3cmZndURmczZyck1POThlU1pVdGViMHZXSWNCVEM1QU1UaVVO?=
 =?utf-8?B?WGZwSEhrd3h2bjl3ZWZyNFdiSWwzZzFZWGZsSW4xVjF4NThSaVNFa0hWWGtU?=
 =?utf-8?B?YUxVTjY5KytvcDRpMC8zN3FqNGdrbnBBUk52Z3U4eEQzYzlacFc5QmVRcDJm?=
 =?utf-8?B?dW4vaElPMUNXcHIrUkpjVVJiQmtpaVFMNVJBVWxvc05ZbmtpNDNHVTViNkR6?=
 =?utf-8?B?VXlkdGNhblhOU1l3aG5XWUhwdTBlWXhaZlUwUGJLRnB5ek1LQkNYNWgzdmdl?=
 =?utf-8?B?RURxcHJrNnhoN25nbkU4VE9DL2JnTmV3T1JJU080UEErWVJ4cXFBdWRqUGQx?=
 =?utf-8?B?MXVXUk5OcGp3VkFFeUpGSWpjR2xraUlRVlpsNWhrMFNPeURLaXUvVGVPL1hI?=
 =?utf-8?B?TFRkM3JpZFNwNTNhYlJVTmpQTG9BNnVZbndhdjUyL1dOTEZheTVyeVhMRnlL?=
 =?utf-8?Q?o726SqYbShy1xdizw1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60deef3e-f822-4d49-cb26-08de8b6b6472
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:10:49.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yy+VhXusILnQosy9mquBLxHewCGC5p9UwBCOnYHGoEAQTou418pUCuhn8II7B2Mi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

Hi Reinette,

On 3/24/26 17:53, Reinette Chatre wrote:
> Hi Babu,
>
> On 3/12/26 1:36 PM, Babu Moger wrote:
>> Implement the resctrl kernel mode (kmode) arch initialization.
>>
>> - Add resctrl_arch_get_kmode_cfg() to fill the default kernel mode
>>    (INHERIT_CTRL_AND_MON). This can be extended later (e.g. for PLZA) to set
>>    additional modes.
> I do not think this is something that the architecture should set, at least
> at this time. Every mode has different requirements and this just lets the arch set
> it without any support for what configurations it implies. For example, if
> arch sets a different default mode than INHERIT_CTRL_AND_MON then PQR_PLZA_ASSOC
> needs to be programmed as the CPUs come online and this does not seem to
> accommodate this. This implementation appears to have significant assumptions on
> what architecture will end up setting since it is only considering PLZA.

Sure.  Let the arch report what is supported. Will change it to set the 
default in fs code.

Users can change change modes from FS code.


>
>> - Add global resctrl_kcfg and resctrl_kmode_init() to initialize default
>>    values.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
>>      https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c |  7 +++++++
>>   fs/resctrl/rdtgroup.c              | 10 ++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 7667cf7c4e94..4c3ab2d93909 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -892,6 +892,13 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
>>   	}
>>   }
>>   
>> +void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg)
>> +{
>> +	kcfg->kmode = INHERIT_CTRL_AND_MON;
>> +	kcfg->kmode_cur = INHERIT_CTRL_AND_MON;
>> +	kcfg->k_rdtgrp = NULL;
>> +}
> I already commented on the arch vs filesystem settings.
>
> When using an arch helper this forces all architectures to support this helper. Is a
> helper required? Is it perhaps possible for arch to set a property instead? For example,
> how enumeration is handled?
> I think the assumption here is that INHERIT_CTRL_AND_MON is the default and expected to
> be supported by all architectures. I do not see why arch should set this as default but
> instead this should be from resctrl fs. At the same time it is expected that the
> architecture supports this mode so there needs to be a failure if an architecture does
> not support this mode?

I will change. Arch sets the supported modes.  FS sets the default. 
Users can change it to required mode later.


>
> I'm going to stop here. I think the comments so far may result in major changes already
> making further detailed review of patches unnecessary.


Based on my comments below you may need to re-look at the some of the 
patches.

https://lore.kernel.org/lkml/47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com/

I am fine otherwise also. Let continue that discussion.

Thanks

Babu


>
> Reinette
>
