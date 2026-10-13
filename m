Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD4535FA4;
	Tue, 13 Oct 2026 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917569; cv=fail; b=gNCAgcc7CEabcWZDfdCbbH129fjBknLRqYwqL4w+r82DriMF/jmaQtPzbkTIJmD0kOYlvh54YegjHxK8eEDOp4RYDU8rBqtqYR3vtauBwl6Sjuf9ud7HCnCHJNif79XRZVGMBvEGyH7DleO0kgOWdSd5HqUshFZS5WMOpXwlYW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917569; c=relaxed/simple;
	bh=kl4M/yOrjKrtLk6yC2FlA41wTFGsHpZuCeZCGURI/YQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMPxrpaR4QUCBDZdTkrGwAamIcEgA4lAqHp5vnUEDN1/vF4rdXUWKjA/nxlYv7oiMcggj7VKKvFT0QbvRryvGDGsjTX72Vs7MVc9JFhQkJh0QyjAShJEe+Y5lfl4Z290KAPAP7eQtBQMGDdUabnQBsNQJYcaJh2H90+r04/Bcms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5H8PbSQV; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5H8PbSQV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjwCNYVJ+A4oDB65zpq7fM+qMaFOSo92QtJPXXejnsapgFFILZVv1zcY5VBYHHAWLWTt3e0Tjmu19TfrrAiXvrqMB24imy/Di5uxQ8xLGlabbadojqfIIMr8johouJVJk/hbKMAD/kDZwWF5atposNBoZJUdssJuAVljdGpBKzRAY+LgX+bB5C5yXNJFagwFTrE/lFVwxys5zLrsE0Cg7Nn0inOaEkBceUYau7u7A5YmYVuVT08Evy4IHxfz95fMcBFgQMi/Ir9RhDYJWwteG91dHe+rz46PB/O201Xdu7pRXF156ZLxYBCAk8w8101oSFjq7nvPl5PMgA4u54zSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/upzzfB8RBXoo33N+YUokyoxaWLaG5GRKajen16teEM=;
 b=xd2n6bBh0W0cZbrW6x2vBIWGTuz50W5/Vhnyljp+qSDNh5RsJBph9qxX3vhA4nIxEmQB1++gIgFJZnlKOpiwVQW50dki0121qDSx6K3Y8dMP9B6DHNS8kzbvEi1T0qncLzhJsmVjkHvt7U3hrhLTAjnpzPIAlSOW0p/geof5pE2Nmnh8afU4EULgR73Zu9drOUG1UA43BjzaswmV70Jcv/dekoGAnIyVtco5zckM60k0KzdPkBDbBaJV5RcyrXN0XFI+EMDYu61Qi/s4y3cYUc7exBOr1v3AGJlg1YDMHikZVLScoqA/YyJ76LJLTwEeudF9irAn4XKg/6EorkOrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/upzzfB8RBXoo33N+YUokyoxaWLaG5GRKajen16teEM=;
 b=5H8PbSQVgDuT0D9J5VNh4MZTGkaQzLcb/njmohIx2/tIwMMf08sTX1PZHrDiU1v9CM0Anx+fI27GY16wc//vqQveI5ugOdtRMOsYcoUphUBEydgPcg16X3RuPdl7oCQRcnQYnWj9GMJHKM4ENfJqbmBOa3Zl11R9yL49oX/9/UA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 18:52:44 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 18:52:44 +0000
Message-ID: <655152e8-2076-4558-916c-d55f88f0f1ed@amd.com>
Date: Tue, 13 Oct 2026 13:52:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Reinette Chatre <reinette.chatre@intel.com>,
 Ben Horgan <ben.horgan@arm.com>, tony.luck@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
 <171f92a3-fa2e-44fb-b0d1-1250c72e31d1@amd.com>
 <4af177a1-7602-4b0a-a8ba-81575f1ec80f@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <4af177a1-7602-4b0a-a8ba-81575f1ec80f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::6) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2b369a-741d-4ef8-98ca-08df295b2aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|10067099003|22082099003|18002099003|260925022911599003|260925021911599003|260925021311599003|13003099007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LemZtAZVLHDmqygzDFAwO8GDuFPnVTg5iwwWVW/eDqO3F01YOFg9POWhw5LnBj+tdS4ylYzpSrKVFqg1y+ojntMp8LHxspw4lthzq6Urs4aYBv0gfrziiREpO7Cb8TN/YjVpXoL/OXUItMV6uwHnRH6KSceVaSfqn13LVgsrbdLO4j2X6yl8cT2OLM+qopivQ3IrRrH7L9/lLSbJqk26wP5YWNX7INSg/rcOBRZ9CFgMK+QAmmUmZdCO9mz98vFDWiAk5Rs1a3e09Vxxy4FdECx+fVGhp7q5oYYLkofY6s9dtMhUFtskzsTo5ciG3UTWMK2vICfWJd7LKFi/a76GSBbZkq49GusFB84+KrqtIhwCo6uYjSTrRNW/4jsihyTGFpRdIsedZGnEph8FrF9Cd1xA8oLdJ05otqpIlOA4+vvECbo9cClN6x4B5HHHdlRpcES7LewLNyjtxBQYCU6kg6kJkrK68JHBknX5M9BNndn00vYFf6MUcQxlIndNDvvisFZKkIx/wu/L4FuPghe3bP3/ZgCjGo+0/EVGMW/rdy4RjC0VwBCqVlVMrYvFLvK7lbs3fGeXk4BAPxsBoD9+LGN4HzQt3XYUVEoa+3mHf9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(260925022911599003)(260925021911599003)(260925021311599003)(13003099007)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ErblFVd200alhIZXI4QkV6Z0c0TUxmSkdJY0pKa1JDMTdEWXc5WE1ybjRV?=
 =?utf-8?B?VUxsZkthNWlLaDcwS0RPcGJSaHpCL0IvbVdDWGNSRFNsNmhWV1RwRit2UHBv?=
 =?utf-8?B?Ylgyb0NKNzh2SkhZeEtLWFZ3cExCSXhEeVkwd0I1Qmo5RUVheTYwWDFsQWhK?=
 =?utf-8?B?Z04wNStmS3RCMGRuUWhvOEsyVGsxMFY5RERDNnpkOFNIMWxVeCsrVUJac0tr?=
 =?utf-8?B?ZEhGMDU2Qjg0SXpmU09JUUZHV0kxWkFvTjVCQ0ljSlRvNDVsOHVhY0tXMGFX?=
 =?utf-8?B?Ykhrb0ZnVnJUMisrbjJINko4RktNRFhUNWhDcmluZTYvWUJkOHk1RlhoSkpI?=
 =?utf-8?B?NjJpL0xRNEZUOVkycnhRbnptRnZxQU54R1JEaXp1eExVd1FiUTBLd2F2WWFl?=
 =?utf-8?B?Z296czB1dHpwdTM3NUZSRVpoOEZydGdZbUdrejlnRktpMmdFeVhReXNCNmNN?=
 =?utf-8?B?cVQzZEUyQTJQWDFyWjdidE9IQTl4V3A0WnEzWTBBRjQ2RTBCaVNoZDV4K0Ir?=
 =?utf-8?B?bXpkSGxjYzhGbkdYRHlBeUhwclpGbzh1N3gxZmZ6dTlSNkZXcWNtak1vdFF0?=
 =?utf-8?B?UnVtOWF1RG5ZWmltZFhIYmpxckt6NVUrMENTWkg3Lzc1bnk5SzFrVFN0dTlQ?=
 =?utf-8?B?Z28xcmZPRWZMUGZFeUZjZUN3Yk1pR3lqUUFmU0NHU2dCQmNTRUtVN1NUTUdu?=
 =?utf-8?B?bE1aSmoxQURtSVZHUGpORlNYSm1MZy9zYXprT0NPTUVmMHdKb1liU3prbFNw?=
 =?utf-8?B?VGI4NXNYMkgyMjRFUlBrODNrazFicU5BeW1vS2VmNWNTOStOQUxSZXQwY0p2?=
 =?utf-8?B?dFFqSHErc1VXd3V5VjVRTGQwTnUzZnRRYnptN2h3bTBlM3U5WVV5WHdWU2VD?=
 =?utf-8?B?UlZCcjlISjU2MlNnTE9qV2wxTGFDM1FQOVcvQ2xwQ3pzdWVOZlBWWXR2RjNl?=
 =?utf-8?B?RE9CSjNDZWxUMERSQ2d6ZlNNMm5nU1JubVlIUjh2K3NjQ2QvODFCTHNZRGxK?=
 =?utf-8?B?U0dheVpEanJMaVUrMDQzeFFPSVNRb01YUWlSeFYvdEErRy9OcjJjR1l3Rmor?=
 =?utf-8?B?Tm1yMDJoSEpFVnJ6bDdMRlQyVmJBMGNERTQrKzdwVjVSTGNmTkUxSGJXUVZD?=
 =?utf-8?B?SzFKODZabXlsTk1BTFVJSEUzSjMwcXlwTERNeCtCM01adEg0d0cwV09jTlA4?=
 =?utf-8?B?QkpxWGE2UUhrc0JpVzVYS3UvdTdVOUpWV2pPL3VSekFyUlRTK1BWUmlGbEYz?=
 =?utf-8?B?aWtkdXJjRzFrYlBzR2hWSnBEbG0wdHJJUDBwdkxuL3ozYWJsWmJ3Umduakd2?=
 =?utf-8?B?WHhtVHBwU0pzTGNYQk5abG5mclNvTDhhbXBIczNPcEMyMmo1TUVaN0o0eDZ3?=
 =?utf-8?B?dm5rNUVLREMzdzQ5NFc1dXNtdUtMZGN6M3RHdk5DYTNsQWRyTnR2K0JCeFIx?=
 =?utf-8?B?VXFRVjhya2pPUS9WU3Rqc1R1d2hDanhKNTc5bzlFak5vejFadWFwM0Ntdm5a?=
 =?utf-8?B?SFExdEc3TzFaTXpIZ0YxTU1lSXN5dVo1UU9MZUtBRHZNdmlTa1d4eENTdG4r?=
 =?utf-8?B?K3Y1UWoramRwdk56VW9VYXNkaWdmdHVySFYwak5hbGtoZ0Jnb3ZRNk4vUVV2?=
 =?utf-8?B?YUF5Mkgzd3RGUE8rZlpTWjV5MFZaak4xUDB1M0E1U0pXTEkzZVNpQlN3NWIy?=
 =?utf-8?B?Sm92L0t4aFVLVVRwRmFVbkRSdExlU2N4cmZ0VGgrY1ZsbW5WSVB6cFVVVW1q?=
 =?utf-8?B?NkQ2NmVJenJLM0dPemtZRmZOenBtQ2lTWG00THlZRUVxZXhsY1dXNWdlQ2M4?=
 =?utf-8?B?M2FrMjRyZFdrS0EwamJucXVFM3VELzJ2SnVTZEIzQ3VtWFdOMFBLdzMwZ2NC?=
 =?utf-8?B?SU5Zemtvdk51SDlPMmkxd0xYdXJZdGVES3hxQkUxa0thQ3ZYVEI3blhEeHNS?=
 =?utf-8?B?ZGVPbmtvWnk5aUlGL0I3YWh6SU1CZDNhNlkzNHZLUHVFNlBxZFJLSDFzeEhN?=
 =?utf-8?B?MTExTUZMTEJOUVIyalhlUjRueCt3S1VrQ3JlRm1adnp4K2VrdnNkdTljemF5?=
 =?utf-8?B?bWdNT0R0ZkMySWYxYnNFN3Z0MHgvbUgwazFMRjZRK2w4SlAxaEhCblpTOFRE?=
 =?utf-8?B?ODlUMm9iU0FSM3BVanJiRkpkSFZ1T3JSbDR2R1REQ3VrWHV2aURLVlc0NWhE?=
 =?utf-8?B?RURNOWtRdS9BN3BWdGhvdi9FMksxMFhnS25qN0hLZUljN2doU3I1c0dPdzB4?=
 =?utf-8?B?cGpBbkhWTWN2V1pDR1lDZTZ0eWhETjdvQXdkZDF2enBrUzNxSlJDNExJVENm?=
 =?utf-8?Q?oL+5gRBkMSaFTJgjWF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2b369a-741d-4ef8-98ca-08df295b2aa0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:52:44.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg8B4TMbARcJ03ZTxCWU0E3QcePrHNvybzlz7lBobCXIWCCSFH76fJucXgsdJavD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744

Hi Reinette,

On 10/13/26 13:22, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/13/26 9:51 AM, Babu Moger wrote:
>> On 10/13/26 10:57, Ben Horgan wrote:
>>> On 10/10/2026 00:44, Babu Moger wrote:
>>>> When the user switches counter assignment mode by writing "mbm_event" to
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>>>> counters, resets per-domain RMID state, and enables counter auto-assignment
>>>> exposed to user space as mbm_assign_on_mkdir.
>>>>
>>>> Even though counter auto-assignment is enabled, groups that already exist
>>>> at the time of the switch, including the default group created at mount,
>>>> are not assigned a counter. All MBM events read "Unassigned" until the user
>>>> assigns a counter by hand.
>>>>
>>>> Walk every existing CTRL_MON and its MON children after the reset and
>>>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>>>> same per-group state that auto-assignment would have produced. There may be
>>>> fewer available counters than MBM events across the existing groups; in
>>>> that case stop assignment when no counters remain. Events in the remaining
>>>> groups read "Unassigned", matching the behavior of creating a group when no
>>>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>>>> comments to account for the new callers.
>>>>
>>>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>> v4: Changelog update (Reinette's input).
>>>>       Function comment update for rdtgroup_assign_cntrs().
>>>>
>>>> v3: Changelog update.
>>>>       Code comment cleanup.
>>>>       Added Cc to stable.
>>>>       Added Reported-by and Closes tags.
>>>>
>>>> v2: New patch.
>>>>       This patch addresses the Sashiko comment about documentation issue where
>>>>       counters are not assigned automatically when mode is switched to mbm_event.
>>>>       https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>       In fact, it exposed a real issue. When switching to mbm_event mode, existing
>>>>       monitoring groups should be assigned counters whenever counters are available.
>>>>       This provides a smooth transition between modes and aligns the behavior with
>>>>       the existing auto-assignment mechanism.
>>>
>>>
>>> Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
>>> on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
>>> treating this as more of a general auto assignment should the assignment also be done when a resctrl
>>> domain is brought back online.
>>>
>>> For illustration on an MPAM model I see:
>>>
>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>> mbm_total_bytes:2=e;3=e
>>>
>>> # offline one domain
>>> /sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>> mbm_total_bytes:3=e
>>>
>>> # bring the domain back online
>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>> mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?
>>>
>> Interesting.
>>
>> We don't know the previous state. What if it looked like this before the CPU was taken offline?
>>
>> /sys/fs/resctrl# cat mbm_L3_assignments
>> mbm_total_bytes:2=_;3=e
>>
>> In that case, forcing auto-assignment may not be the right thing to do.
>> Since we don't know the previous state, we can only speculate.
>>
>> It may be best to leave this decision to the user.
> I think this raises an important point. To get a better idea I looked back at the original
> bug report referenced by the "Closes:" tag and I do not think this is a relevant fix for
> that bug.
> 
> Let me elaborate ...
> 
> The bug reported by Sashiko was in response to the patch that added a step to
> "Examples on working with mbm_assign_mode" to switch to mbm_event mode from default
> mode. The rest of the example was not changed to accommodate the assign mode change
> and the documentation thus reflected the state of a system that was in mbm_event mode when
> the resource groups were created, not in the new default mode.
> 
> In this new version of the series the documentation change looks different - it does
> not imply that the system started out in default mode and thus does not imply any
> mode under which those resource groups were created.
> 
> I agree with your final statement "It may be best to leave this decision to the user.".
> It is not possible for resctrl to know how user intends to assign counters. Why not just
> leave them all unassigned when switching to mbm_event mode?
> 

That is a good point. We can do that.

Should we treat the default group as a special case and handle it 
differently?

Thanks,
Babu
