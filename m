Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8A5038E6;
	Tue, 13 Oct 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898409; cv=fail; b=j2YKzC6xMWlh9fd3Q8C618VDdioxK5m5+T1/Lm2iQNaw6oxfXtlU8wZMD2689VoGUdpnkMHhlu+qgdzNGVIn3wjSsGzt1UKTpTy6Xe7GTgl+PBwzjU1Xq6xYy1iFIkUfHXx4INsqn7gEfGl15VtNYkh8fRkuMChBA/IuAkuuh08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898409; c=relaxed/simple;
	bh=XpiTXeHZBBIMkXRAtN4ZL2Xx7Y8fuB5nbsAtd2+k8BE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IDf74wlw1nxdGTwmURPwNkRGu2+MJAkjTCMCf66bvlMsC2p8QCUWL0uZwLtaGoqDOrCVZfjyDp1HcDMJTOPxXCz/zkGzVRAD0W2+lZupwYvqYKeGN663UIBWve56d1j+eYtJke33Ukty+FXwh9sz48ROTZuEqP5c1fZkQW3Quhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U+pV/wdA; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U+pV/wdA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNXi53PeyqfmG4LZlKbmT0kbD0U9a9QhOXQuLFlnPAinxrkPVunJZfOR5+La+uYvsWSzJNP84poK4EEe5tfY1hKtcjNcD2ZSnGFS8fELUyGtQN0lwwX6YDewB+qqI0Ysa7J+G0KKR6u3yx+1p988g9hZthhVWy3i8ThAz1dpb+ZF/N5hmdQx0FbqnTdWHOw8pLppYCssoyKb+ClX+xY2uJJ/YGkXxW5nGQpRuRLjwXn3oBuNuIx16KyNq2PKmfcTROMnd/EraTUCdV04sQDWuue4wk7jP178q8qZPdQxAhjDc9uZSnPCxdrNb2KnyEcNqdF1sDHfWxakCWd7wbrv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlWn3p1VUgC2IhL5FWsdoeBYkKYT1jzAsRNUE79n/d8=;
 b=mdg5ELYNfsrgm1iFG3N88H2n8/iLQb0ATHrxWy7v/VBBPewdYd0ufP7f1F63L4GnlUlZfxC3s4ZPuTdqfIB4Na6qxdJ73ij5WI6mQQvrk84uOw4Bl+xb0mgiDzQvAixBsyofKC49VnZvkTiaCnRSint/4cGFJ7mvrDEicKxii4AR3nH3ehKT+dTUolvKu+z0ZDgix/biZ80r3fMR+RdwuJo0DNop4URYmAwa78lYND2YaEkx4bedeZcb/8LcQI2+IyQU84kY1NyPsi3Q40bAzxTaqJhbUWABYnceqxWBJdzl+GIy1RxSLBsU2ro6j7DJZdQHu1N0chzCz90deN5ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlWn3p1VUgC2IhL5FWsdoeBYkKYT1jzAsRNUE79n/d8=;
 b=U+pV/wdAkdEP3uuCr15CcxXqS+yJXT9PzlcJMVzVTRSKJtof4jk75q77D5yleYvXBPmHwn7kULfS/WyOBAb4hQC6Z4PjaH2CWEzEurCXkL9khK1wAruLXJ4RkT6qK5HOyG1SImBwT5FGo0Eby94cl+JhnuolfAYzwcavliS2T00=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 13 Oct
 2026 13:33:24 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 13:33:24 +0000
Message-ID: <d8bf2738-6eff-4b0b-a045-ff1134090bdf@amd.com>
Date: Tue, 13 Oct 2026 08:33:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, tony.luck@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <918780dd-30ad-429d-ac35-25d79d47450d@intel.com>
 <92529635-c9be-4edb-842d-7817fafd5523@amd.com>
 <3e7f1507-2a82-44a1-a06b-52b6a49d971c@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <3e7f1507-2a82-44a1-a06b-52b6a49d971c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::24) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4e540b-fb3d-485d-22ce-08df292e8e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|11063799006|261009223027099003|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ewarPAD9l2EeBRbhMKaeocoFOpz2l3flqNK0nPLZdJ7XAEBF4kuQLRDcI0rKlpgKnch2nID67Bf6eDDE8OGk269cnA4KJoiCq+pJSHMfqdL5h7rfzZWK+2FgBMHiMD9Hl1dysgBIgvgY5l+HENLxVPzXMJk10ffUmsDERrR5Jz5Au/h26UGX7DWcRAtSjturqfwEPhKoOSWZgRKLXbZG87FOr9AUN8jCRkzUh2wn9lRs9sdYLlJK0u143l0vaAq7AGdfrCosnmNHN78JwHVt2dwtG66nsvBtTeglhR/QT2iN5Ly+Gzf3/1pRePRhrNDrrrcLlGuqxgbxd929jDb0HyuMIsXHUQTEN+kUyC3UrMM7DfWTw+nQ7WuGd4fucNQDB67r/W/+G30iY3OESFjwcaiYhPyserZVfbpyTToYW+QHtoxefgCuG9s8rPqcki/3/oLsq1KQgoyDMImFLYsT9uJq36L+lR25zeN0FyCZBtJFMl3FDw7TuUCaSlLeNmaFV8O+Z7OKZviuqh2vi0BRUlZuU+5kkkPl6b1vTugELw092Iy/0FRgIm+Z3/7c1LqN7z0g50Mai91KMGBcUNm1ERQ0PkIDfAJP/n6j15C3Dp5qWbCmpYK41sYoA/3JXTLgJT75MhPc5ZEHLuSVZDbryn3B/xoz/mFUhJ/rovm+tjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZhekphUHZpQ0o3MWFPTU5JSHVtcGRsVjBiNytKanh2RlUwdEhqNXo2K3hK?=
 =?utf-8?B?M2JFbE5JT08xbWZEbDBMbEo4ck1QY0NqTVJWdDhYRk9PVVVsNUs2bVh0c3hv?=
 =?utf-8?B?TlpJaWJsWHlOT2V3ajEzblhVdHNFbGxyYTlCa3F4ZjBzU3hQWnVqQldzcks0?=
 =?utf-8?B?QmQyRlEzZWxxTUtPZjYrMXpkYVdEbjk3WXhiMFFlL3d4L2xMczJqU1ZkbVZ6?=
 =?utf-8?B?OGlLbU9NOVo1L1VsVngrcDNVd0xNOG54NWovM216bElKYlNHaHUxSWtTREJ6?=
 =?utf-8?B?ekcwTkNobFpUeUI0Vjd0OWUxd3VCbVNyWm8ramppS3hzUWNCemtKWmI1WEhr?=
 =?utf-8?B?SFZCSW1iaDlwdHluK2ROdyttdVU3djRTbkhBdzRnVmRzWnh4Njh5MXBOdHhO?=
 =?utf-8?B?NFlrOFV0U01OQmsyU1dSRVh6VFd4K0k2dkJWdXM1aDZWTHhzazJPSkY1ME9s?=
 =?utf-8?B?cStJSGxNanc1eHBSeWl2RVBvNFVCZ1BHbTZyR0RtSk9jODJzWUNTektoWHlZ?=
 =?utf-8?B?bGYxWFYzZEZkRVN6RUFZd0hQL3oyTndEYXNPRWI4Wk9vY1kxeHhaL2IwOEN4?=
 =?utf-8?B?c0I1OThMc1pYclJzaytKOVl6Wmk5Vkhvc0hOcTVUN0FUQkswd0RIcGNYdmxM?=
 =?utf-8?B?ZnB6bDdHMmZmdGNURkk4NDFlcVAyQVJTK1lpTEFMRXc1SDJZVDJJcnUxcVZO?=
 =?utf-8?B?eFRGWGZiRHV4UTc1MjNMYmdtUDFaSnROeUhNczFIUGtGODl0YzExKzlQYzZr?=
 =?utf-8?B?ZVA0RmhCRUFnMHhWNEEvTnZTVjZWV0pnOU1jQmZ0bDRNc0Qzd1JoVVZwWjAr?=
 =?utf-8?B?eFhuQmhINFpRRW1ZZHhiNVB6V1FaSG9wNUJ0QkhYaWp5eUJFWDB6VmZiMXN1?=
 =?utf-8?B?Mmx1UW4xL2NzYnlIR1NvUWI1Z2hKZUFMMkhlVzRwMHVUQVZZcHRoZjc0ejVU?=
 =?utf-8?B?bHJMMGFDN0x1NmhrcDVpWC9lNnNQZ21LNkdnQ1lFek1zVUZVdVpSa0JBTkpN?=
 =?utf-8?B?NWQ5K3N1c21OaVlIcForcVlsRHhmcENqTFhJS1pYRG02QTc2T1RXSmhZaWly?=
 =?utf-8?B?SExISGkxL1hlWDBDZHRuQ0NKbUdlMysyVnhXb2V1TGs1bmlLeXRFUHVoVWd3?=
 =?utf-8?B?eVYvMk1oMGYvRDRHT0VGQWRMMVJYU3NtNXFXMHFQaWZyZ28ybmZFL0NsQWZj?=
 =?utf-8?B?cEJlUFFKdDhjRnZZTlIyQ3kwVHEyYm9jN0NKd0RPRTRJZ0ZVcUtGeFVYU0Y0?=
 =?utf-8?B?NlZYdVN0Nk93SkQ1NEczV3JqN0tBYVZYUDFYS05IOEw2TjNNL3lkK04rcmJI?=
 =?utf-8?B?Q1dUZHgzdUR1UDlMTmd5WEsvaDRxeXU3aFY0UmkxdXhWQTc3a3FROHpkVXgw?=
 =?utf-8?B?VmR1SUJMajVpNXp4TGx0bkpMY2liWkIxUTdPUnpTU3dybHIwSFJUSG1ZNWdC?=
 =?utf-8?B?dmprSmJNSTI3dkUzY1I2YldGTFhmTlFlZGozNUdhcDR2aHk4TnZMS1ZxeDNn?=
 =?utf-8?B?bE5kaldPSitTM2h2SEkzNE1aaGFBTC9rRkY1K05KTHJid3I1UUp3MndXZ0ZL?=
 =?utf-8?B?MWxEZVdJVGRLWHdnblAwdlU1QmhTVjBWaHVtRjRWQ0xkN0FhaWt1VFNKNHov?=
 =?utf-8?B?ajdKeHVQelo4S2FROXBuV3dlNXJpS2NzQnZCOHFDcXI2enlzeUhrcFhXT2xO?=
 =?utf-8?B?am94VXgrdktuNUVsS1JnOVdBZ05GSHJOV3JXUy9YdVhZWXBFK3Y2QnNXWHVi?=
 =?utf-8?B?NW5IQnZnQ3FuM2hTVmFhTEhhbzArU2t1M0xLOGpyS3hlV1pBUzd2UkVNNU9y?=
 =?utf-8?B?YXRkRUdTSEgxQkRXOUlPMXR1SWpUaUo3THZOdDkxV2dtQVJVdzh5cEx4cFdw?=
 =?utf-8?B?dlRYNm81ZFdObHFPSGhlcklTN01hdEYydjFYUkxCWWlZZFlkS2dDT09ESUpl?=
 =?utf-8?B?UGtiTkUxK3h3NktBUjg0Tk9XQU55UmhocWhZenlpZGJoNVF2TzVOcDZqV2Yw?=
 =?utf-8?B?MlBGWXBlK2NRZHFvenlCaVhQVVRDNU12ZXcvUitXOHJQekFCVzVEcHk3Nkps?=
 =?utf-8?B?SXQ5c3RvOTZZdnppVEljdkFSRFJ4U3UwUy8xazZMbkFGOVozYkpoM3JCZFhI?=
 =?utf-8?B?QTdwMkVEd1NQbGp3T2Z3cllyK1hHOW1JVHpnQ2U4bEcyK2RvdUMyUXdRSUs3?=
 =?utf-8?B?ZVFrZFJETjJaQjZraS9uUzQzc2ZnNXNDZHY1MnpzU1Bsdm00UkgyS2ltbnoz?=
 =?utf-8?B?cmtlNFU4Y2F0QjZxajdzR1IrSUwvaWJFekdjOEtDTmxzaEtPa3BpYzVKdHJ2?=
 =?utf-8?Q?wfpWXKiS2krPgmWVGo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e540b-fb3d-485d-22ce-08df292e8e38
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:33:24.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs4ZmyAnaJ5bRPkUrDMAxptjXobBRQ382O+uIkb66ZhIcHx4pbV1lfBTwkXL+QV6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

Hi Reinette,

On 10/12/26 21:16, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/12/26 6:02 PM, Moger, Babu wrote:
>> On 10/12/2026 1:44 PM, Reinette Chatre wrote:
>>> On 10/9/26 4:44 PM, Babu Moger wrote:
> 
> ...
> 
>>>> @@ -1611,6 +1627,19 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>>>>                mbm_cntr_free_all(r, d);
>>>>                resctrl_reset_rmid_all(r, d);
>>>>            }
>>>> +
>>>> +        /*
>>>> +         * Counters were freed above, so both new groups (via mkdir) and
>>>> +         * the groups that already exist need assignments. Groups created
>>>> +         * while in "default" mode have no counter assigned, including the
>>>> +         * default group created when resctrl is mounted. Assign counters
>>>
>>> This patch refers three times to how "default group" receives counters during auto assignment.
>>>
>>> How important is it that the default group is assigned counters when switching to "mbm_event" mode?
>>>
>>> This patch implies that auto assignment will always include the default group but that cannot be
>>> guaranteed since the default group is always at the end of the rdt_all_groups list. This means
>>> that when traversing rdt_all_groups in resctrl_assign_cntrs_allrdtgrp(), whether default group
>>> receives counters would depend on how many other CTRL_MON and MON groups there are.
>>
>> Good point. I recreated the problem. It is not always guaranteed that the default group gets the counter with the current logic.
>>
>>>
>>>
>>>> +         * to them so that enabling the mode leaves the same assignments
>>>> +         * that mkdir would have made.
>>>
>>> Related to previous comment is that the changelog mentions "same per-group state that auto-assignment
>>> would have produced" that repeats a similat claim made above that states "same assignments that mkdir
>>> would have made". This behavior assumes that a CTRL_MON group is created with all its MON groups before
>>> the next CTRL_MON group is created *and* that enough counters are available for all groups. If
>>> there are not enough counters then the most recent CTRL_MON groups will receive counters first potentially
>>> leaving the first "mkdir" created CTRL_MON groups without counters.
>>>
>>> It is not clear to me whether default group requires counters. Separately, I do not see whether resctrl
>>> can or should support the same ordering as what "mkdir" would have produced. If these are not actually
>>> requirements then the patch is fine but the comments, documentation change, and changelog need to change
>>> to match the code.
>>>
>>> If the default group does require counters then we either need to change how groups
>>> are added to rdt_all_groups or how resctrl_assign_cntrs_allrdtgrp() traverses the list.
>>
>>
>> We have always treated the default group as a special case. I think
> 
> In general I think the special treatment results from the default group
> always being present. It is not clear to me that this implies that the default
> group needs to have counters assigned when switching to mbm_event mode.
> 
> 
>> we should ensure that the default group gets counters before any
>> other group. How about adding logic to give the default group
>> priority when assigning counters?
> 
> I do not find there to be a strong motivation for this assignment but it
> should be fine to establish such expectation at this point. Just to confirm, you
> explicitly only consider the default group and not also the monitoring groups
> belonging to the default group?

It is just the default group. Not the monitoring group under the default 
group.

> 
>> How about something like this?
>>
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 9e705eafe873..5f3711d78a19 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1339,8 +1339,10 @@ static void resctrl_assign_cntrs_allrdtgrp(void)
>>   {
>>          struct rdtgroup *prgrp, *crgrp;
>>
>> +       rdtgroup_assign_cntrs(&rdtgroup_default);
>>          list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> -               rdtgroup_assign_cntrs(prgrp);
>> +               if(prgrp != &rdtgroup_default)
>> +                       rdtgroup_assign_cntrs(prgrp);
>>
>>                  list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
>>                          rdtgroup_assign_cntrs(crgrp);
>>
>>
> 
> ok. If you go this route, please add a small comment to highlight why the list
> traversal is done in this unexpected way. If you do so, please take care with
> potential duplicate comments between this function and its caller.

ok.

> 
> I do not have a preference about which groups need counters assigned when
> switching to mbm_event mode. Please just ensure that the documentation (resctrl.rst,
> changelog, code comments) match the behavior and explains why.

Ok.
Thanks
Babu
