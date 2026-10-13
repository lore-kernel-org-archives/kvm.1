Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F633F5A8;
	Tue, 13 Oct 2026 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853408; cv=fail; b=k7aXd8dKJflFtRY3QSnpWITAVEYa1aOc9u6DaPrepD01J7/m+qABe+A/o12zLLwIx2BEPeKYv1+wl6TiAcbs+A5DzY2Zvo9OkF5uKvDXZNYlzMtZKsOBFUFoqemyCV334Bx/F3kXJVVMOi62WtPjtla7UBlpNLnljwe0o7V9P9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853408; c=relaxed/simple;
	bh=TEIxNzUrt3Yi+4UlREEqRNnbSATiaxftgFxzxXQm9FY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NzfpoTnPm+KGo3HRf3YswYkPu1ZUNl3R42mjF4VsymtAsYq+MuynEKdcYi5QtYNSaBP6L+B+SW8C8U1aGivfrcJsOMsb4RcX7GBlCguNUdcQpGNh40iFTJKQQPuzKf0mBCyp++pNEMsaDbUOjxLDumRNcG8EaPoob/oI6jY19hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxtFW1U9; arc=fail smtp.client-ip=52.101.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxtFW1U9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg2lRwDrANdhY5/mKTir8b8KvQg3OKGMPCcF3a+r3h0NC1kd8MxrjVEUPXNg/oQjZB0VrHzvSZ0p1SHhTgSdXLCC7CzM9QiFHA9Y+xLDy28rhMjsL6J2VNBK2a7tpStf1cmUiVpAhupcdg04Bvu8L0v0rbFGaW2C7XRB9QTPFypNCL3oEuaM3weIsNetsauQt8dnQYGBZvOlhfIY0XYHTR/WVzPgf9XHKVzvaOCRrHjaoeQCkc72U/88mJr8iGaQH6S5on08yRhBlS4Aio0UhfmzM0UrtxEoVYl4njKT13hMsWse4OkTF2cFqWoGb53P8zH9J8WJd7FydZJVZb9gKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXhnxElK55TeC6ud6fAbbj2VILw49UDPe4NY99Af0go=;
 b=ypYA5fhuOrpFkHCf8QmYWFrOVLSzw0emI7iaQWJvMsc7JNgRBewdvyYtKGKQQfiQeGjUIKTZTWKhpWIgAI9jWnIyWOoMDFZEieERpdCl44ZJePNLRUVqLC7VTV7IROcBOoEaJRR3ZM2xsiKUT8XWc2038kn9B189SJbAPktvQE/u+QNLKsRYLbyUBQ6KDs8HcM6AnT0YJyacXAdAbaPC24HjqdX/+wNup69MDtn92B9xlVF87T7FunQ9Snq3qNfdSLI0VCbmzrvLPvDjkniuKvPxxVgXrW3pM/kEIi/htqe0ELdVhybniMj1Cloz9RUxBzjGCI5eAfUEvzKu5ZyyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXhnxElK55TeC6ud6fAbbj2VILw49UDPe4NY99Af0go=;
 b=bxtFW1U9ONrP+ipUakS0pHFgcPcJRNzRRBOf5acp5xSK2Ecs7YPt7Rg6mbThcpB/sHvjJJc3x+EM8INuNmLzKtR1o5T9Tfb5bgQAUvvsTYchobehKcknLrjU9cOZ0mdT+sktWBszZhyIlazLQ4hkYq2RPTgXO2gGrEFhaDsjTs4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:02:22 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 01:02:22 +0000
Message-ID: <92529635-c9be-4edb-842d-7817fafd5523@amd.com>
Date: Mon, 12 Oct 2026 20:02:18 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <918780dd-30ad-429d-ac35-25d79d47450d@intel.com>
Content-Language: en-US
In-Reply-To: <918780dd-30ad-429d-ac35-25d79d47450d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:d3::29) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5a8200-17f0-44ba-db38-08df28c5a334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|260925021311599003|260925021911599003|260925022911599003|10067099003|261009223027099003|11063799006|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GSayCM9zT/gwF7wB1xyi7AOT+7FqJh6rXf1rSNHBkTEJtq+lfrgEaT6RjqCdSzNbA6lJIFLz4qw0U3FtoN5wtLQT11JtT7agw7Hrdpyoog0qMnZfbnt2VfSCJaPuvF9NHhcautUkAor2eQsYr3DR86Q6ulSTrq7eys8QBeB5V6HkH7onAEHaFxh5FB1tQ1aDgddjSwFButgbVPuro7gudAj/1GVZYv44Ve5WifS7yeZtMlO4xsUeP9i3haKo+k3nSE264nAGdddKTNiIfAPZtgVNS07PvpOlKTv1mwcV60AjcMrWQ1UzarLuO4E5c/i9E/ZPHvDNHDCjc8pIbDTbtKxHcP+B3zZO2vZl9KdqR9ItvucXxfYMuVtrUgWucCqykuTie/7J/yxjTsqU9lAA8Bsewy5yyjDYLiSw1AllkZ7BPYflo1wW2dOglcbdlrgXQmcilppJQgNl8BCO03RrPVss49LYn+QsWuPRtJkN5ShOzE6HEFJR6J2MR2oJz+B4e9JoEHYNj5q4br8oByUCG8nqj20zjW1KUuT/Rp7DSvHNSKEXzqzntphFgn6CiJv47ptJwdjKHSxwatjMGlwKAQFljRWH6HJVT+KOtOsG6PI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(261009223027099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cStyYzhyOFdpWjZPTXgxdTMxUzZ3L1BlckFBYXdWQmt2M0FueStJN08xZlV5?=
 =?utf-8?B?Y2o0Yk1wYStEVmkySDB0OFJZUzNhOE9jZlUrZ1hqTFlBK2g0YnMzbjVXampn?=
 =?utf-8?B?UVloaHA3cURFbXVKVUo1OTBKL0lQWjdvUFRoZ0ZTUkRGcjNabWlrK0ZqbEFk?=
 =?utf-8?B?UktqZHdUMXlXZHJSM2dab2RvQW9qa0ZFMFpFL3JHdHpnTHBVR0s0MC8vUUd3?=
 =?utf-8?B?cFc2ZjdPNEJYYjVJK1FVVURIQU5DWVVnalJ5dFg4NHZNNlJlZEVoMm05S2xK?=
 =?utf-8?B?d1ZTT1dBdXFFc2dTQ0p5a1diVzhPK0Mrd2ZKdVkzTHNHTi85cXpJTUtpTEJF?=
 =?utf-8?B?U0ljSGtoSzFqd0tRRFJGZ2xQKzA5bzdibDRaSDlCQmVSdk9VNUxPb1FBbGJn?=
 =?utf-8?B?QVc1OW9uU0pUeTZvbEtVTUZCMWJ0R052aFI1ajNvQzZJbEZzWEV5REg1OTdu?=
 =?utf-8?B?V0ZuK2VpVFBFM1J6aFVETy9yRkZTNFFyMXV4RHZTSzBZRDgyZHVDNXdsKzFn?=
 =?utf-8?B?MmdtTDlGRWswMW5TL2paQVdNUlRtZURnR2tqNU05WTdmRWhrK1VTc0hneUVH?=
 =?utf-8?B?eG83dWdMK3lhWlk0c0V2bkVYK3N6QXNsekY5ckQrRGFjMFY3YUN5QStqY1Fw?=
 =?utf-8?B?dlp0VU1aQkRVZnJlbHppSVVWZlpmb01ySUZjNkoxTE04dVRySFIrNGJaVDEr?=
 =?utf-8?B?K05uM0kxNWpHOHhMaHJXTTB6MmxyRjZFSDB1SVRXa2YzTzhGUVF6bDg3bGVh?=
 =?utf-8?B?ekFSL0ZxNFJhTUVuaEI0OWdOWU1PU0plZmNzZ2VhL0RSMytGVGJiT1d3dVd2?=
 =?utf-8?B?MDBReTdkL0tGUzF3MTdoWDdHNXcxMmpUaUkrWFRrdng2V3dEM3JQNUVXSUt4?=
 =?utf-8?B?YzJrQnd0S1QrbjFwSlhScEhMeGRHVTF5ZHlXQTJLWGV6UFFkVlgvbDFSNXoy?=
 =?utf-8?B?ME1MMnB5ZGd6UFVFTGJGYTVzZVI4aFNWRjVZRHc5VzhkdzRjV2Q0QnFLRWhm?=
 =?utf-8?B?Mm1rdUNBbG0wZXZUc2txN05LUXV4VllnejA3d1llTWR6OHRFNExRcHd0WE5O?=
 =?utf-8?B?eFF1UWdaTHhZaUw2VFlCOXl1VXlKanVVR3hWN3gybGZ2TmhoVlNXTHpycUVU?=
 =?utf-8?B?Z1hLaENKQXIwdUVDaFRDVzdmdVFtZFErT1pXYkcrekxSdUZKR3kxMVNTL203?=
 =?utf-8?B?RlZtUGxQZXV1c1VpdE01S2xxV2lyelZiUHVmWkNQM2QvMmM4YjdqeEFCSDB6?=
 =?utf-8?B?TytOZkVCTkRqb25IVnh3ZmhRSWJVREQwWlBFRy9mdUFoNHIyTmE0UUFidDI2?=
 =?utf-8?B?RnZoWkhoNnI2aUpSbTRZQTZ3blFtRDNxNDV1a0lla2h3K0xtSkEzVzJrSG82?=
 =?utf-8?B?aDExdkszQjZsZVM4bi9aWUdTYjJvUG9YNmsyS1g1cmxNNyt1cWxZRit1ZFA1?=
 =?utf-8?B?VVVZOHIvWFg3c0J3bXZOcXhiVy91enVnSXdLRmZRMXkrV29SN2lvQnRlTWRx?=
 =?utf-8?B?Vkd6NDh6bDlOdG83NzBweEZvMnR2VDhmalNoT3J6TmtJbktmY3Jjbmt0N2xo?=
 =?utf-8?B?clJraXBOdzUzL201MFBxSUF2cElVcW1MWEp6cUg3MDJYOHNBYVB3Q3VnWEdk?=
 =?utf-8?B?TlN3NnEyWndxcnVGa2dkekJoZGgranNiZTIrKy9GSXRuaGNRbTJHdGlmcFl0?=
 =?utf-8?B?VFNqQWQ5QmxGbVZOZGRVVE1zSC9hSGdiaFRaZnFtaXpjSUl2M3JLT2p4Y1dD?=
 =?utf-8?B?RlNMa0JkYW9EU29tVWV5dGRMTnE4Tzl2QndVSGorOU4wb2xaNzMvTVJGaTRi?=
 =?utf-8?B?V1ZWalBmRVR1QWRWcDBXb2FpSFBxUCtNRWIxS3NtaTNWcW1iTGNrenFlUFds?=
 =?utf-8?B?YlpDZTNxVTRiYjNlOS90VEZhNHdsSjZhNU9kWkx3TGRLc01FV21OR1FkTTFi?=
 =?utf-8?B?QWZ2QUpQcTErUWhGeExLNGlHZVMyN29vU1ZFT3lKbTBTY1dOaFVrZUxFRS9n?=
 =?utf-8?B?S00yTjFoK1ZsdlpLaGo2SVNxdmxqV2M2REw5b0lrQmhLTC9UNWk4RHp0Vk1B?=
 =?utf-8?B?WGwwZThnWEdGeXljTGQ0VDBpZWlSWE5pNDNFWUpNNi9JK0JyS3lBb1VMTjRR?=
 =?utf-8?B?VHMveERXNmhVeUE1TEtHa2dDVW5LdDN1WTlTdW5Xek1vVnU1QXUvQjB2NHQ0?=
 =?utf-8?B?TjN2ODNuaTNoSUNyd0E5YTBYekUxaG81Um5VZXlYRmgzK1BDQ0lvSG1qS2Zv?=
 =?utf-8?B?YXFjbFpVOENweWNsUnpkTjJCcFBmSWt1YXZGOFlHbnkzdzRXb1hvQnhvU002?=
 =?utf-8?Q?HIawD9jxt0Q3c1tkno?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5a8200-17f0-44ba-db38-08df28c5a334
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:02:22.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pEsatLRtS3Z7WKvRICqFsTsEd0TAoXmfKMkjOWT/WAQW11GE72F/Ed6/7HuK/n/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

Hi Reinette,

On 10/12/2026 1:44 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/26 4:44 PM, Babu Moger wrote:
>> When the user switches counter assignment mode by writing "mbm_event" to
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>> counters, resets per-domain RMID state, and enables counter auto-assignment
>> exposed to user space as mbm_assign_on_mkdir.
>>
>> Even though counter auto-assignment is enabled, groups that already exist
>> at the time of the switch, including the default group created at mount,
>> are not assigned a counter. All MBM events read "Unassigned" until the user
>> assigns a counter by hand.
>>
>> Walk every existing CTRL_MON and its MON children after the reset and
>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>> same per-group state that auto-assignment would have produced. There may be
> 
> nit: Related to more detailed comments later the above "that auto-assignment
> would have produced" may not always be accurate. If the patch behavior is
> maintained (more later) then one way around this may be to just instead say
> "that auto-assignment could have produced".

Ack.

> 
>> fewer available counters than MBM events across the existing groups; in
>> that case stop assignment when no counters remain. Events in the remaining
>> groups read "Unassigned", matching the behavior of creating a group when no
>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>> comments to account for the new callers.
>>
>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org
>> ---
> 
> ...
> 
>> ---
>>   Documentation/filesystems/resctrl.rst |  7 ++--
>>   fs/resctrl/monitor.c                  | 47 ++++++++++++++++++++++-----
>>   2 files changed, 43 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index b52795e03303..c8507580474a 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -370,8 +370,11 @@ with the following files:
>>   	of counters available is described in the "num_mbm_cntrs" file. Changing the
>>   	mode may cause all counters on the resource to reset.
>>   
>> -	Moving to mbm_event counter assignment mode requires users to assign the counters
>> -	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
>> +	Moving to mbm_event counter assignment mode enables "mbm_assign_on_mkdir" and
>> +	assigns counters to the events of all existing monitoring groups, including
>> +	the default group, while counters remain available. Consult
> 
> This also adds the "including the default group" caveat that I will refer to later.

ack

> 
>> +	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
>> +	assignment states of all monitoring groups.
>>   
>>   	The mode is beneficial for AMD platforms that support more CTRL_MON
>>   	and MON groups than available hardware counters. By default, this
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 04e4ea612b7c..9e705eafe873 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1302,14 +1302,17 @@ static int rdtgroup_assign_cntr_event(struct rdt_l3_mon_domain *d, struct rdtgro
>>   }
>>   
>>   /*
>> - * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
>> - *			     a new group is created.
>> + * rdtgroup_assign_cntrs() - Assign counters to enabled MBM events of a
>> + *                         resource group
> 
> nit: please fix alignment. This patch inconsistently uses tabs vs spaces for this
> alignment. That is not major since this file itself is not consistent in this
> regard, but the file does consistently align the description irrespective of
> character used.

Sure.

> 
>>    *
>>    * Each group can accommodate two counters per domain: one for the total
>> - * event and one for the local event. Assignments may fail due to the limited
>> - * number of counters. However, it is not necessary to fail the group creation
>> - * and thus no failure is returned. Users have the option to modify the
>> - * counter assignments after the group has been created.
>> + * event and one for the local event. Assignments may fail due to the
>> + * limited number of counters.
>> + *
>> + * Intended to be called in auto assignment scenarios ("mbm_assign_on_mkdir"
>> + * enabled in "mbm_event" counter assignment mode) where counter assignment
>> + * is not required to succeed. Thus no failure is returned. Users can modify
>> + * the counter assignments afterwards if needed.
>>    */
>>   void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>>   {
>> @@ -1328,6 +1331,22 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>>   					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
>>   }
>>   
>> +/*
>> + * resctrl_assign_cntrs_allrdtgrp() - Assign counters to the MBM events of
>> + *				      every existing group.
>> + */
>> +static void resctrl_assign_cntrs_allrdtgrp(void)
>> +{
>> +	struct rdtgroup *prgrp, *crgrp;
>> +
>> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> +		rdtgroup_assign_cntrs(prgrp);
>> +
>> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
>> +			rdtgroup_assign_cntrs(crgrp);
>> +	}
>> +}
>> +
>>   /*
>>    * rdtgroup_free_unassign_cntr() - Unassign and reset the counter ID configuration
>>    * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.
>> @@ -1601,9 +1620,6 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>>   									   (READS_TO_LOCAL_MEM |
>>   									    READS_TO_LOCAL_S_MEM |
>>   									    NON_TEMP_WRITE_TO_LOCAL_MEM);
>> -		/* Enable auto assignment when switching to "mbm_event" mode */
>> -		if (enable)
>> -			r->mon.mbm_assign_on_mkdir = true;
>>   		/*
>>   		 * Reset all the non-achitectural RMID state and assignable counters.
>>   		 */
>> @@ -1611,6 +1627,19 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>>   			mbm_cntr_free_all(r, d);
>>   			resctrl_reset_rmid_all(r, d);
>>   		}
>> +
>> +		/*
>> +		 * Counters were freed above, so both new groups (via mkdir) and
>> +		 * the groups that already exist need assignments. Groups created
>> +		 * while in "default" mode have no counter assigned, including the
>> +		 * default group created when resctrl is mounted. Assign counters
> 
> This patch refers three times to how "default group" receives counters during auto assignment.
> 
> How important is it that the default group is assigned counters when switching to "mbm_event" mode?
> 
> This patch implies that auto assignment will always include the default group but that cannot be
> guaranteed since the default group is always at the end of the rdt_all_groups list. This means
> that when traversing rdt_all_groups in resctrl_assign_cntrs_allrdtgrp(), whether default group
> receives counters would depend on how many other CTRL_MON and MON groups there are.

Good point. I recreated the problem. It is not always guaranteed that 
the default group gets the counter with the current logic.

> 
> 
>> +		 * to them so that enabling the mode leaves the same assignments
>> +		 * that mkdir would have made.
> 
> Related to previous comment is that the changelog mentions "same per-group state that auto-assignment
> would have produced" that repeats a similat claim made above that states "same assignments that mkdir
> would have made". This behavior assumes that a CTRL_MON group is created with all its MON groups before
> the next CTRL_MON group is created *and* that enough counters are available for all groups. If
> there are not enough counters then the most recent CTRL_MON groups will receive counters first potentially
> leaving the first "mkdir" created CTRL_MON groups without counters.
> 
> It is not clear to me whether default group requires counters. Separately, I do not see whether resctrl
> can or should support the same ordering as what "mkdir" would have produced. If these are not actually
> requirements then the patch is fine but the comments, documentation change, and changelog need to change
> to match the code.
> 
> If the default group does require counters then we either need to change how groups
> are added to rdt_all_groups or how resctrl_assign_cntrs_allrdtgrp() traverses the list.


We have always treated the default group as a special case. I think we 
should ensure that the default group gets counters before any other 
group. How about adding logic to give the default group priority when 
assigning counters?

How about something like this?

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9e705eafe873..5f3711d78a19 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1339,8 +1339,10 @@ static void resctrl_assign_cntrs_allrdtgrp(void)
  {
         struct rdtgroup *prgrp, *crgrp;

+       rdtgroup_assign_cntrs(&rdtgroup_default);
         list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-               rdtgroup_assign_cntrs(prgrp);
+               if(prgrp != &rdtgroup_default)
+                       rdtgroup_assign_cntrs(prgrp);

                 list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, 
mon.crdtgrp_list)
                         rdtgroup_assign_cntrs(crgrp);


> 
>> +		 */
>> +		if (enable) {
>> +			r->mon.mbm_assign_on_mkdir = true;
>> +			resctrl_assign_cntrs_allrdtgrp();
>> +		}
>>   	}
>>   
>>   out_unlock:
> 
> Reinette
> 

Thanks
Babu
