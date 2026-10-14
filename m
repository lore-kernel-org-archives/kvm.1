Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A52E7398;
	Wed, 14 Oct 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981171; cv=fail; b=ku7+4BqSyn1pIDAZybSP4t26Kv51KWhdhX0pjRjlUTU+XR5Yla9ZNgtJyFjRTbpJLV38oytevQkZrpFQc4mKD56VYcS0OaznvCZlTLhhtLXtGQy97yzoA2l2BUAcNuDIVMWZMXEuu+4Q1OVmkCnCqEe47BO6hiuO+4CaR6n80jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981171; c=relaxed/simple;
	bh=9KERG6xQcApiAhUUZI5PKkNFJ/+Z9/AKbc70aMg7fts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qgSWb+QOsr4RyIpWyW7Tw7USmP15bwggGIafR2tke8Rq3By8ES0nybIWVRcMmGmOL1f/MY7sfVcWCtnkmeSIAXAK4X/vk3GOuVmSecmucpD2Pbx44cLqxER+o6QK7Nh1Ord+XWx+7k6Q6vxgt2RmJ0LASqlglG+pGBuG6e/ZznA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PfE0xPQX; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PfE0xPQX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2CCTAt1qY06Cx4QRQc5AuDvSkE8SN8A6pObjwsKKhea5K2YfpsmQKYp+DdGASbubtLf5xHbqMfl0QstET7cVH9FnYVvpTUZx68BB10dTE+82xj1vu0e+cILAF9sOKSPMyrO2r6Y0sTZl7R9Qmm4vFMS5jW9h43XTzGf8dw7GrDncaga0/AfKc9gFYkLFiurDqjDIXZq+0asT4bjugVHTaLHj3vVvlFKJPeT3+MaAfzs48Z8uSMVylpPzsDB1mzGE96duPcjYJFzBhSPhzkUKMCT9XldvlLRk3yyPqotC+DODGbp1wPtuXfrYKmsIU6u7h3OxXiG8C1NgEBUksd0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALdwyK5oUCDKRVgrdTE7V4blHCwNjGgjYQinNHlyMuE=;
 b=JEAugojueUA0KidJFIdPRBqawuM9yF9+d1R5SF1fD0C+3OMP/oCLZbKqA713mzFBsncdecI2Y1Vo84ZLkjbuca/QXf5vc1L9/40mpeFwt5fWqbdWj4obLMEVDlv1AqmlyVKgJFByW4yiOK1BBrEl/MTDhp+jDUPbPL6z1Z+/6r8QhRrcQwsStOMYl0Yo6di4GikA+Qt3Bo1WU+7QGivMU08ZC+ThQ66IOSk+7ViUEsKxcHNAC/7Gj2aKqKgmtjg2llFRKyiU12ekkmoNACREAMdszxBfhRuEA1ZNXGznQK1gl1e9/f+8e88JjVgjbZlw2FXWRET0b+JwfMg8k5nc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALdwyK5oUCDKRVgrdTE7V4blHCwNjGgjYQinNHlyMuE=;
 b=PfE0xPQXM4M5thO3vD1ZxGM/CgWrXsnm/GyYaKAab7L7F2iinrBk1LlbP2pIxOFLkT6t8jGZA05Ov3Hc6M67d1rNgpJnM/4OjCBgqkEFxHLBHezkXBQ7WsQ5gp9ylAyCTfr2viM5q3Z0bCmIpL1tQEgZAtVX3rS3E18jrW5+hVI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 12:32:45 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 12:32:44 +0000
Message-ID: <6aca748d-f1c4-4646-8df2-bda17e33041a@amd.com>
Date: Wed, 14 Oct 2026 07:32:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
 tony.luck@intel.com, bp@alien8.de
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
 <655152e8-2076-4558-916c-d55f88f0f1ed@amd.com>
 <e91c9cc1-02cf-41ad-b636-8356e93b5dcc@intel.com>
 <9202bea3-7746-4a24-8070-3f472198d3cd@amd.com>
 <aff2576f-adbf-4775-9aa7-e9f20844da86@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <aff2576f-adbf-4775-9aa7-e9f20844da86@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::14) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fd7e6e-19a6-42ef-5447-08df29ef3f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|56012099006|11063799006|4143699003|261009223027099003|260925021311599003|260925021911599003|260925022911599003|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	t38RP7WWTlkHBeXNdHwr478A9J6MR0dsHD2G4ihKfBk/mvJvyeXwFsAofjkFyp57FSlm1WeLO70kqty/+dgHhrasS7pMMzXuEGlk+9Y4V4smFYz+YnQzsg/XvhEvHiJrqUvsYLgVUirRRDLOCK9AvfRqWC/yA8LS5JYi3lYBhqrdhIbblzYc5S+7CnxKzMh3VE9iVbsg7kkNh+XduV+6/ATR3g2XlwgQmAhl8ZwPFNDy4dnthjCipwUtsmyqFQV9bgPhqxIoejHSK83XIwlXhvEOxjo8PRJAhipt38jD8Lp/Ky4AN01pOE59hf/bO+RPECdKzv0s+7GLpSE6YKh54ZCGkuVhM+XSNGpaAWz5tEDLUd+14BwX2ZBGFxaKMvHMVFsW3wXHTyTy/UDyW8Rtey98VoaWl+A3fEo+6bNY79SHPFeLQgknqI1bc4Ymgoy/xtpXm+9Yi8M5IxaO04P7mnCEbUNyQGnowmseKumy/yzR+QI3c5lieNVbSnVGFTskun79VD3k4+44Fs6tuTzs74zeorTxW6qKD+0yuyqVlOokeDjUnOm8eub/A1nzNGshVN0ftQ09qZsefogjjsnr+2aL0Y+JuAREWgb3lQAjKxU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFBNHJ2cFZML01wbmxnbmtsYkpHQzBaZjJ1L2dlVWJQZVcxZEl5N0JVYVRE?=
 =?utf-8?B?U1J4QXkrS0RoVnZjbkJuckpORk9Yc0ZDRVNZanY2ZmtxSTk0aVVQQnh4TnR4?=
 =?utf-8?B?eEJFM1owWlRwV3BMZHVBcE92bWZWMVZTRSszem5BaHRKK2wyWmlid3JZZVRJ?=
 =?utf-8?B?ejJkTm9DRkx5NEhyZjVXWmpjbjJBR09EVkluL2hTRlFKaVVQWHhnQWJzQnQ3?=
 =?utf-8?B?Qm4wUUdvSXJBT3k5V3Q3aFNWZUdRdTYwcnllbjFqQXVYd3c0Q29GbDJHUnJQ?=
 =?utf-8?B?TGV4d2dqQmQvT0wySk9vM3d6eUFkb0xlaU5lSk9CR3FxVmpHMnQwZEhmY04v?=
 =?utf-8?B?UEpCWXJFaE5RWnZHNGpsOFdZdCtacUFaMnkzank2OVpvVTZVVFMwa2g1d3Fp?=
 =?utf-8?B?RSt2UVZzaWFtU0xHK0pjVGJYdFFlWXZaSnduRVhDZEhYbUNINXBmWUJDSU16?=
 =?utf-8?B?ODBkS2NSOWR2Y0J3QnZHTTFLK0pSZjd0SEJMWlFOWURMNFhFYVRNbzltRDZV?=
 =?utf-8?B?NVRiUHQ0R2U5U1RTVW1iTVhiWHB5Q0xQamRaQkNwc2pnOEYwWStjTjNVMWJW?=
 =?utf-8?B?QVlaeVZmcE5JdmhDQUxMN3F1NEpKTjNUTHRQZlRWRUQweEVFeGNmdTlmYmpC?=
 =?utf-8?B?UFZLK21tRndTanVKaTdKZjFhNnVtYWF2K2tlQXBnSlduelZvMUVQL0lVdnBL?=
 =?utf-8?B?Tkg0V0ZnditUa3o5N2Y4eWVsaGJ5K0ZwWm1MbEFoRllrTG5IOWtSWFVNZ0I0?=
 =?utf-8?B?eHYvb0VwVjVhSmFzZGtVTFRkcGg2NVo4OUJSM0k2Wko1NGtPa0UvWnV3WEdT?=
 =?utf-8?B?Tm40RjZVK3UrTXZCNHpLTnF4bmlYUWFEcTJrdFltUEJIa05DeFhjYjk4dFg0?=
 =?utf-8?B?cEYzRnNjKzhGS01IaW44NkpSSWZxcDg4Ykt2WkRuMy9zK0lyb3VwMDRDbEdL?=
 =?utf-8?B?UU54dXl1RzhGeTVGT0RIMC9FcXcrVlVQQmh3OWJSVEVIV0RUYVhPVWtxSzJ6?=
 =?utf-8?B?eGpqWUU4K01yT1MzelJqYXA4Qjc3VTg3aTNvekZiWHBoWDBFRi9sSm0rV05w?=
 =?utf-8?B?VVFxWmt1amE1N3Avd1FDUEN0bit5a0VTWnBHYXo0aDBpS0w3d0ZOVTFDRHpQ?=
 =?utf-8?B?Mm5Eakg1cUhic3l1RVlsOExpTEJsSUVsV3FBVVRGRGxXMVdrVkdDaEN5QkpN?=
 =?utf-8?B?eFdjZlFLMGVDK1VFQVpUNmpsZ3p3VEh4a01nVytKbmN5cElrZ1oxeC9tV3hH?=
 =?utf-8?B?a2dpZFA3enNzRTBGWWwzQnhhQ2F1RUQ4RDBMQXc2K3gwQktzNWdUOFV5SFYv?=
 =?utf-8?B?NFk5YjlpUWhCTlVHd2ZUUjVKVlFjaE1wWElrbjNOc296NmVOTVpmNXd1RTVh?=
 =?utf-8?B?YTQ5Y09iaG1uQk5ZQi9Hdi9vQWYrcjZyTTlFaWlkeGZPeTMraVd5SFNHWEpm?=
 =?utf-8?B?L2dFSjBuQ1JXbk0vejFRdENENnBIUkNJS29neFpHYktOK1BZQUNXNW50T3Nh?=
 =?utf-8?B?WnN1M09zS1NpbklsbWNMK01Xejg5V1psOUhsWWViTXRzK240Q2RzS3hDY09Q?=
 =?utf-8?B?dHgyUHIxY3hTWS94OXNoeUNWVllaTTkyN3Bhd0p2REg3ZGhKSWJFSGNwTTlr?=
 =?utf-8?B?ZDk0M29vSTFKZFdTTm56RzNFb0VTTW4wdzBTdmJwYVVySFlKZWNROUEwQ0hy?=
 =?utf-8?B?WXpXbGc1cnpodjBUaklQeHFYeW9kNGpucUY0S1IwdWtWYzFNK2JSS3JBanQ5?=
 =?utf-8?B?UWFmN1ZSV0Z0NnVNL05nYkw0UVFacS9yRklRV1BweEFTSDVoa3JVREUrRUdV?=
 =?utf-8?B?cmFObDc0SnJvTXFaM0Q5Y25EYkpHU0dYZVpoM2ExTzVUS29tMms1ekYxUVA2?=
 =?utf-8?B?YTdzalMyNFozS1ZyTEQxRDFxOG9rN1EzdmJnbVBXdHZsYitQTmRtd2k0d0Ri?=
 =?utf-8?B?WVFoT211WjNEV1Y1VU82dE81UHZ3YkZkZTBFclRYb1plcHozbndXN2E3bEls?=
 =?utf-8?B?UklIYXV1eHBSUVpESGJSeTRoQkpRWHdIM1RwZStnTlFEaUhIRFdLVnRpSmo3?=
 =?utf-8?B?ektqVE1GYnhhaW9qZ3MrZGJWRFdQWGJrR0crVDljYWZ5blhUMUtET2NmSFJq?=
 =?utf-8?B?bWpzczVleWpJUFJqSlhFeUFYZzUxZitLL1lWcUZmS1BUSDhMcUo5THA0MlVa?=
 =?utf-8?B?Z0YxcU01UDRpOWpqa0xEMVBCL1NrVnAzUjFRbDRNMElzY05OVkxnTVRlZmo4?=
 =?utf-8?B?ZDQ0cXpzeXhqZDc4MjhnNjhyUDZ6UGc1T2RqbjRkaXQrejF1cFc0U1pFbmwz?=
 =?utf-8?Q?jeFrYlQJ37aB/YVhSC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fd7e6e-19a6-42ef-5447-08df29ef3f1c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:32:44.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbV8LVtvWYmrzJXpKGecJNdOhC3uVsLhF7MSDL58vcIFqidbnInzoRE9tccnnEVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108

Hi Reinette,

On 10/13/2026 6:23 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/13/26 4:05 PM, Moger, Babu wrote:
>> On 10/13/2026 3:25 PM, Reinette Chatre wrote:
>>> On 10/13/26 11:52 AM, Babu Moger wrote:
>>>> On 10/13/26 13:22, Reinette Chatre wrote:
>>>>> On 10/13/26 9:51 AM, Babu Moger wrote:
>>>>>> On 10/13/26 10:57, Ben Horgan wrote:
>>>>>>> On 10/10/2026 00:44, Babu Moger wrote:
>>>>>>>> When the user switches counter assignment mode by writing "mbm_event" to
>>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>>>>>>>> counters, resets per-domain RMID state, and enables counter auto-assignment
>>>>>>>> exposed to user space as mbm_assign_on_mkdir.
>>>>>>>>
>>>>>>>> Even though counter auto-assignment is enabled, groups that already exist
>>>>>>>> at the time of the switch, including the default group created at mount,
>>>>>>>> are not assigned a counter. All MBM events read "Unassigned" until the user
>>>>>>>> assigns a counter by hand.
>>>>>>>>
>>>>>>>> Walk every existing CTRL_MON and its MON children after the reset and
>>>>>>>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>>>>>>>> same per-group state that auto-assignment would have produced. There may be
>>>>>>>> fewer available counters than MBM events across the existing groups; in
>>>>>>>> that case stop assignment when no counters remain. Events in the remaining
>>>>>>>> groups read "Unassigned", matching the behavior of creating a group when no
>>>>>>>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>>>>>>>> comments to account for the new callers.
>>>>>>>>
>>>>>>>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>>>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>>>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>> ---
>>>>>>>> v4: Changelog update (Reinette's input).
>>>>>>>>         Function comment update for rdtgroup_assign_cntrs().
>>>>>>>>
>>>>>>>> v3: Changelog update.
>>>>>>>>         Code comment cleanup.
>>>>>>>>         Added Cc to stable.
>>>>>>>>         Added Reported-by and Closes tags.
>>>>>>>>
>>>>>>>> v2: New patch.
>>>>>>>>         This patch addresses the Sashiko comment about documentation issue where
>>>>>>>>         counters are not assigned automatically when mode is switched to mbm_event.
>>>>>>>>         https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>>>>>>         In fact, it exposed a real issue. When switching to mbm_event mode, existing
>>>>>>>>         monitoring groups should be assigned counters whenever counters are available.
>>>>>>>>         This provides a smooth transition between modes and aligns the behavior with
>>>>>>>>         the existing auto-assignment mechanism.
>>>>>>>
>>>>>>>
>>>>>>> Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
>>>>>>> on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
>>>>>>> treating this as more of a general auto assignment should the assignment also be done when a resctrl
>>>>>>> domain is brought back online.
>>>>>>>
>>>>>>> For illustration on an MPAM model I see:
>>>>>>>
>>>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>>>> mbm_total_bytes:2=e;3=e
>>>>>>>
>>>>>>> # offline one domain
>>>>>>> /sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
>>>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>>>> mbm_total_bytes:3=e
>>>>>>>
>>>>>>> # bring the domain back online
>>>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>>>> mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?
>>>>>>>
>>>>>> Interesting.
>>>>>>
>>>>>> We don't know the previous state. What if it looked like this before the CPU was taken offline?
>>>>>>
>>>>>> /sys/fs/resctrl# cat mbm_L3_assignments
>>>>>> mbm_total_bytes:2=_;3=e
>>>>>>
>>>>>> In that case, forcing auto-assignment may not be the right thing to do.
>>>>>> Since we don't know the previous state, we can only speculate.
>>>>>>
>>>>>> It may be best to leave this decision to the user.
>>>>> I think this raises an important point. To get a better idea I looked back at the original
>>>>> bug report referenced by the "Closes:" tag and I do not think this is a relevant fix for
>>>>> that bug.
>>>>>
>>>>> Let me elaborate ...
>>>>>
>>>>> The bug reported by Sashiko was in response to the patch that added a step to
>>>>> "Examples on working with mbm_assign_mode" to switch to mbm_event mode from default
>>>>> mode. The rest of the example was not changed to accommodate the assign mode change
>>>>> and the documentation thus reflected the state of a system that was in mbm_event mode when
>>>>> the resource groups were created, not in the new default mode.
>>>>>
>>>>> In this new version of the series the documentation change looks different - it does
>>>>> not imply that the system started out in default mode and thus does not imply any
>>>>> mode under which those resource groups were created.
>>>>>
>>>>> I agree with your final statement "It may be best to leave this decision to the user.".
>>>>> It is not possible for resctrl to know how user intends to assign counters. Why not just
>>>>> leave them all unassigned when switching to mbm_event mode?
>>>>>
>>>>
>>>> That is a good point. We can do that.
>>>>
>>>> Should we treat the default group as a special case and handle it differently?
>>> I am missing why the default group is special here. As I understand user space
>>> can allocate counters to the events belonging to the default group just the same
>>> as any other group. Could you please elaborate what sets the default group apart here?
>>>
>>
>> As you know, the default group is the "catch-all" container for the
>> system, and users may expect it to report valid bandwidth
>> measurements. That said, I'm not sure those considerations alone
>> justify giving it guaranteed counter assignment.
> 
> The current documentation states following about impact of switching to mbm_event mode:
> - "Changing the mode may cause all counters on the resource to reset."
> - "Moving to mbm_event counter assignment mode requires users to assign the counters
>     to the events. Otherwise, the MBM event counters will return 'Unassigned' when read."
> 
> The second is clear about expected behavior and there is no "except default group" caveat.
> 
> At this point I do not see a motivation to change the existing behavior.
> 
> My vote is for this patch to be dropped.

Sure. Will drop this patch.

Thank you,
Babu



