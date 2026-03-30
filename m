Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2F36BCC3;
	Mon, 30 Mar 2026 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896431; cv=fail; b=qVjHdmmji9m3BmnhSOlQwiVPp4PWEQ+rRULYys4PoBMBHptkxRtc5dU/qOzYfUUpmvUdG+/Cm/8e0t8hE9zG6PO+DlSW6cUaesaKB54vLOixn/RoV1qrWmu8qxel3J/Pik1PZJnzcfMJecLVARXCAwVsr15BPsRnWgodBmt+gkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896431; c=relaxed/simple;
	bh=jObivo/hu6o5KQVDX1Lopr180zhI8LmvtDnp98zoIhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNFtDua4rLJu2Lqb0VRK+9SFAut9JPv9SHf1BEIg8oKrhP6HBOxeFCOOmJGuHWZWAszNm6Nviouo21aYQZhUiJJokN9rku2eQh+T7B3gs2PXbc6J34ecgM0b5Xzr9A+9obs2jJl4Llh8vL2KgImgp4NY2cavNKST2RntFT3DZ1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dBSXlMsP; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dBSXlMsP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6hLzMWpsnWvIGsezyOvXcx5vJMtSSJmxyMXUIh2LGq++1RVzA1qHHy76av1mLmA0StfMRRjml47qbMP1gqWgb61tKQI7k7T1FwQ5bTVPStLElhcGpK6MsRDcSga6KklFOWFt6JJty4trr+qF6EavjtpFfhKmbcHSv+cfJRhoYyoN7GyWufs41vWoXyGmAAnSW2NJf8pzsANj/03g+CeNEvctKeECiE+u+YUAbTq0mhISZqi6flLjqapSPUN19TMQI7hIgSReceW7NDRcrsJzTdEPH1X0qPA4wLiuUdiz3teqF/Qwo2RF7YmOxfD0oKYSrzkF5gctwaOgn0zX5Un4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+eeNBkP9gTuOb8iy+lQFsINTUB+X8kGIJnkEcDUfbc=;
 b=GLAk8s2+qITRZfZmaxv7IizBfGkFGmKuNUE/cFKsU+mGPWesV8ryyCYG8b0O+Cnz6bUiHi/PuBWVHjvztPV7lxGbeGaZ/o6u1GXYr/7DI8nksWLuBhESH7a2UlQib10mt5ZQk4FwvTqLne0Kot6V3CONd9Y8TRlJupaV1isCnjHhG/8GqiqgQdXs3ZQ0N0aC2pQPObt+wmMa2mMhfne6XB3zjNztAFF7s765Bhjg/zZ1vo6cNIzSuWAEpw80Sw08hgRi0+fBxAzo2WFv/i5+Qthdoz4bl2+zdyxYW284Vw34WztLH9WEYCBeji5xgZSk3BMIslppB52gE6zetWIc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+eeNBkP9gTuOb8iy+lQFsINTUB+X8kGIJnkEcDUfbc=;
 b=dBSXlMsPWzaLlsU+Y1dbQ6HsaEalKjTlkze/G8OtlIHGyhRGa9xaQNYPZsiijSbvGvvLpheyMQkx+zZAEEwOw6+/oGS5twdhAvft2gqwftN9s6TT20PAnCqrUzypx8qA/E182v/jm9hKcsZ9ZBnv4iBcgmyHKPHWPTsQ9XXoZnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 18:46:59 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.011; Mon, 30 Mar 2026
 18:46:59 +0000
Message-ID: <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
Date: Mon, 30 Mar 2026 13:46:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
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
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <88eebfac-5286-4788-b244-911c659c0439@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::21) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 83aa9b6a-ae60-4b29-bad1-08de8e8cb99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|56012099003|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	Zy5oPq1pkUZ27etwZMS2GQQn3Hl/znJts6f6Jk9tAXQMiIzpKNfpXLYsJY+Mi+qymrkXtbBmmIJ9JMXJya4op+nqM6QDhv+POr0T5au/TTD4HR24laS/h+yLaC+GSRjlPpl5tmm9OEswJWhVtLk7YQ68jA0okGtN77C21w4Y5O0gOYJCIb6eJbk+NzQFemw2SdkDT2ZCmLw+pXMCNDX2pOqIpGM7fqSZSfcVc6Q1pLD/GrqZGPRuYXRYF5ThKi8jQ2h2gR4N6xI6gq0cQDmX8SYpKlZIdQ9iziqkBP/WZ0r94z/4lqZhUWz0Q/anTZabim7y2wfWuNLNw+No8XLzz1BIjv27HLlGgrpeYEkmSFDqbYVTGqCKiHPxveaC5qIOJXyZ/Xk4YuhurbUsretpUiKDH53Ek0a0dazOaW2ZA2MrHB/jvv6afQpkL9mTR2XX+7LHrB3KrTfJf4L1HFGWLWH71xjnBw+z8Lh1Uroyq8JBZZrDJokbaLbiULkY4GbLk8HbSNeJtst8uvbwBMBGeiKVsOALQueY9e6uyYqKIs+7GwETKcV70oaxC18DU9xaCUezlQwGyCraIcqyQFFJJiyiGQCg0wE1wxC7Y1bk3zX6Zpdqkk1cz6YgFq0ijEAtUca9mHROli61OzMax2d6BYXtiKH/cE86TR/ehYUPLPlp9FnhIyeW+HQneQwBgXH/mSDT7vPQLy3wz5lM3oSbwi/2l2z9Jzgh7DkS1p0sn31GWyhYDym3g+aOXcNpH4ym
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(56012099003)(22082099003)(18002099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUZua3Q2Q1JPV1loSURpaHJrU2pvRzNXei9aWVhFUnhLWWdPSWxtU2ppZkV1?=
 =?utf-8?B?cnp2ZGtVTFZEam84VXZVTTFuTFZKampCRldhYVhWRXFadElyakY1WHNFakM3?=
 =?utf-8?B?SGl2dG1FeUptMDJlTWQ4cWl6bjhNMkhKL3REUXF4UStjNTNqYk1yNXk4RGlm?=
 =?utf-8?B?N2pmYVVTdXNmR3JhMURpU2c0OG1wYy9qQWVKdTVoc2JxSnFLMmtIa0tQa0JH?=
 =?utf-8?B?ck9kNkRPS1FzdDJwYmgxUEQyNXNkaW1ZbndMOVk2S1FMLzZ2c0o4WmI4L0FW?=
 =?utf-8?B?bDZESTUxeXUwTGUvWEFlWjhzanNWNzBSTGhiSklhVitSeUgzWXg2Q3hZWTNx?=
 =?utf-8?B?aWJVU1A1aFpYMWI5SGE1Y3h3RHQ1TmNEWUN0djgwVkZCS3dXTG5VYzNiaGNz?=
 =?utf-8?B?SUVESS9iTUpEOTMyWXZlby9uRCt4Qm1xWXFtVHNaeVA3N0RWUTA0d2FvWGZu?=
 =?utf-8?B?UG9vdnRtRWFTK0d0bExKOTl3eVBIak83V05EQ29DVEdNcXgySjBiZG5xNmow?=
 =?utf-8?B?dFhRdE9adEJLN0hraFNXQkdxckNsaXZrOWlXN1pjL3JwcHU3QVhwY1FPVkNs?=
 =?utf-8?B?Qk5kWGpzUmZjYlQ5UllKNEFpU1ZqY0xVNFBuRjVXTE5TcFJ3bmlJMmNET0Y5?=
 =?utf-8?B?RE5NTWlMQXJsc3VEZmIrUyttQzc0UXROWUpNQTUzeGgzd2wxdkVENWpYZmZv?=
 =?utf-8?B?cDFLd3B6U0pDQVpOTUtmOGJhSGtqQVdzQ1loZm4xTXZvckZwZi9iZTg2RFM3?=
 =?utf-8?B?Yi9kRTQ3dFNsdENjRnlvWXZRUWw1aWUxdm1LU3Zud2JiK29lSE90REpNWnRl?=
 =?utf-8?B?MW9hZXRpSXdxZTBQWHJkNGNjWjkvemNDQkQ2K2lZSkE3dVRac0p6Q3JoWVor?=
 =?utf-8?B?QldiaU9iZUR4S05kZFF3eEhVRTZlb0xGTmFiaGhTV3pDVit5VzNackdRZmJ6?=
 =?utf-8?B?L1hoSmNwdFRDTml5SWlWOEJ0Vk43QUtHSHBpekVsa1RzSHhCOFQxVFF4cGt6?=
 =?utf-8?B?VlRRRjJPZ0FuQkFvSDNKU2VvZ0JuTWxtd0wrZ3lVUmo2c3hyQnlaQkRUMHNX?=
 =?utf-8?B?eWQ2UUlTZU92dDBnWldBazVUcUppaDQvMjJ6YzZIU2xCckJ5QWhCUzBMSUxu?=
 =?utf-8?B?Wkg2TEVCMUthL3lnRHduMW1rTzZZT25lbW9JckM4eTgwWG9Idy9yVVpDTmpx?=
 =?utf-8?B?MWhTa3hnZ0lsQU1LeDQ4aDlTNXRxU3M1Qk5HUlIzeU01eUI5UWhMWHV6L0l2?=
 =?utf-8?B?NUlKdzZLZ2JzRHdvL2VnVjg0ZHFVNFl4Y2tLL0YxdTYzOXJtTld2bXdWMkRJ?=
 =?utf-8?B?b2lzdStWMGJGVHRNTlJFYlVKQ3ptNkpnSXg1RkNWUDdmVEpic1NBTWtSSHBO?=
 =?utf-8?B?Z3paemo2amdvdWVCWUNXTDhOcW9vMkd1TWd4d1BVQTVsS3A4NmtXL1NUblRz?=
 =?utf-8?B?LzVlNERtOW5XSkIxYnFhY1N6ZGJYL1YxT0RSZjdiYm40SnZVZnduK0xaNkNM?=
 =?utf-8?B?SGU1UHhnbGdsTXBXdWJrbU5SaWozMXFNOWFIRGd4czRCZEVzRWw3LysvejFk?=
 =?utf-8?B?b1NxQk82UkMzc0dLMFVXS2JNeXBQUUJMRnVLL1FFR1dBK1N3cVROU3dEdVJK?=
 =?utf-8?B?TWVXUDlHVUMrVHVCODFXYlpLeW1uVmpvKzBBckFyYmcrb1E5RWRrMW41Ymt5?=
 =?utf-8?B?UTZ1YWNLakpQT3d4UlFkYUdzTFRNKzhxWktCcWJ0YVYwM3Rnb3Q2c1BhQi8z?=
 =?utf-8?B?NHViVVdNQmhsNm9aY2hGOFFsS3NxanAwbXlWWi9FNEhtOHVBNVY5dFJCNGV6?=
 =?utf-8?B?eHdwb1FqK3dyNnVHaEt1dU92Uk1za3M4TktCSVB3c3BXZHRQRGFxQ3dsWWdF?=
 =?utf-8?B?ZlNkU3hBamRlYkdFQVpNVFlsMlNnYmxkOTllaEdYMklHbi9IdzRjdnBrRmhm?=
 =?utf-8?B?Q0prbkxZSy9kcWo3aDkvNlpOM2YvbFVtVjErdGtnblZ4cDRrVXRFSzN3TTFt?=
 =?utf-8?B?elcrRkFnVnBWWGlMNmtUSUwzMDB6WUEzdVlta2NmcElIa1A3L1kvU2xiRHA1?=
 =?utf-8?B?bmxUZS9NTzdodTNURjVkMlBsbUpqMWhkU1JFTzNJcUhCeFNvdFV4Yi8wZU9V?=
 =?utf-8?B?aytMUmJSWXlFcExyOUl6VmhoRFNKbStzNmRVWWs1ejhrRkFRTW5UM2hRcjFV?=
 =?utf-8?B?RHRtR0RsRk5yQ2FWbkk2WFFISmVFam5mcGxEbktFUEsyNUpkVnBaVHl1YVp0?=
 =?utf-8?B?eExZSWZYOTNOd3N3KzFkR1JIV05YMWNiVlg5L3hQZnJYWHB6cENQSEkzYUVE?=
 =?utf-8?Q?dvUXd4fZ9KgK91xJX2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83aa9b6a-ae60-4b29-bad1-08de8e8cb99b
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:46:59.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKvelSfs4L90gn2LLoKMy3hmXVo9KUJmMItuSCFqvQc/btUX/a5Xh0cvXFU4tms3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

Hi Reinette,

On 3/27/26 17:11, Reinette Chatre wrote:
> Hi Babu,
>
> On 3/26/26 10:12 AM, Babu Moger wrote:
>> Hi Reinette,
>>
>> Thanks for the review comments. Will address one by one.
>>
>> On 3/24/26 17:51, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 3/12/26 1:36 PM, Babu Moger wrote:
>>>> This series adds support for Privilege-Level Zero Association (PLZA) to the
>>>> resctrl subsystem. PLZA is an AMD feature that allows specifying a CLOSID
>>>> and/or RMID for execution in kernel mode (privilege level zero), so that
>>>> kernel work is not subject to the same resource constrains as the current
>>>> user-space task. This avoids kernel operations being aggressively throttled
>>>> when a task's memory bandwidth is heavily limited.
>>>>
>>>> The feature documentation is not yet publicly available, but it is expected
>>>> to be released in the next few weeks. In the meantime, a brief description
>>>> of the features is provided below.
>>>>
>>>> Privilege Level Zero Association (PLZA)
>>>>
>>>> Privilege Level Zero Association (PLZA) allows the hardware to
>>>> automatically associate execution in Privilege Level Zero (CPL=0) with a
>>>> specific COS (Class of Service) and/or RMID (Resource Monitoring
>>>> Identifier). The QoS feature set already has a mechanism to associate
>>>> execution on each logical processor with an RMID or COS. PLZA allows the
>>>> system to override this per-thread association for a thread that is
>>>> executing with CPL=0.
>>>> ------------------------------------------------------------------------
>>>>
>>>> The series introduces the feature in a way that supports the interface in
>>>> a generic manner to accomodate MPAM or other vendor specific implimentation.
>>>>
>>>> Below is the detailed requirements provided by Reinette:
>>>> https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
>>> Our discussion considered how resctrl could support PLZA in a generic way while
>>> also preparing to support MPAM's variants and how PLZA may evolve to have similar
>>> capabilities when considering the capabilities of its registers.
>>>
>>> This does not mean that your work needs to implement everything that was discussed.
>>> Instead, this work is expected to just support what PLZA is capable of today but
>>> do so in a way that the future enhancements could be added to.
>>>
>>> This series is quite difficult to follow since it appears to implement a full
>>> featured generic interface while PLZA cannot take advantage of it.
>>>
>>> Could you please simplify this work to focus on just enabling PLZA and only
>>> add interfaces needed to do so?
>> Sure. Will try. Lets continue the discussion.
>>>> Summary:
>>>> 1. Kernel-mode/PLZA controls and status should be exposed under the resctrl
>>>>      info directory:/sys/fs/resctrl/info/, not as a separate or arch-specific path.
>>>>
>>>> 2. Add two info files
>>>>
>>>>    a. kernel_mode
>>>>       Purpose: Control how resource allocation and monitoring apply in kernel mode
>>>>       (e.g. inherit from task vs global assign).
>>>>
>>>>       Read: List supported modes and show current one (e.g. with [brackets]).
>>>>       Write: Set current mode by name (e.g. inherit_ctrl_and_mon, global_assign_ctrl_assign_mon).
>>>>
>>>> b. kernel_mode_assignment
>>>>
>>>>      Purpose: When a “global assign” kernel mode is active, specify which resctrl group
>>>>      (CLOSID/RMID) is used for kernel work.
>>>>
>>>>      Read: Show the assigned group in a path-like form (e.g. //, ctrl1//, ctrl1/mon1/).
>>>>      Write: Assign or clear the group used for kernel mode (and optionally clear with an empty write).
>>>>
>>>> The patches are based on top of commit (v7.0.0-rc3)
>>>> 839e91ce3f41b (tip/master) Merge branch into tip/master: 'x86/tdx'
>>>> ------------------------------------------------------------------------
>>>>
>>>> Examples: kernel_mode and kernel_mode_assignment
>>>>
>>>> All paths below are under /sys/fs/resctrl/ (e.g. info/kernel_mode means
>>>> /sys/fs/resctrl/info/kernel_mode). Resctrl must be mounted and the platform
>>>> must support the relevant modes (e.g. AMD with PLZA).
>>>>
>>>> 1) kernel_mode — show and set the current kernel mode
>>>>
>>>>      Read supported modes and which one is active (current in brackets):
>>>>
>>>>        $ cat info/kernel_mode
>>>>        [inherit_ctrl_and_mon]
>>>>        global_assign_ctrl_inherit_mon
>>>>        global_assign_ctrl_assign_mon
>>>>
>>>>      Set the active mode (e.g. use one CLOSID+RMID for all kernel work):
>>>>
>>>>        $ echo "global_assign_ctrl_assign_mon" > info/kernel_mode
>>>>        $ cat info/kernel_mode
>>>>        inherit_ctrl_and_mon
>>>>        global_assign_ctrl_inherit_mon
>>>>        [global_assign_ctrl_assign_mon]
>>>>
>>>>      Mode meanings:
>>>>      - inherit_ctrl_and_mon: kernel uses same CLOSID/RMID as the current task (default).
>>>>      - global_assign_ctrl_inherit_mon: one CLOSID for all kernel work; RMID inherited from user.
>>>>      - global_assign_ctrl_assign_mon: one resource group (CLOSID+RMID) for all kernel work.
>>>>
>>>> 2) kernel_mode_assignment — show and set which group is used for kernel work
>>>>
>>>>      Only relevant when kernel_mode is not "inherit_ctrl_and_mon". Read the
>>> To help with future usages please connect visibility of this file with the mode in
>>> info/kernel_mode. This helps us to support future modes with other resctrl files, possible
>>> within each resource group.
>>> Specifically, kernel_mode_assignment is not visible to user space if mode is "inherit_ctrl_and_mon",
>>> while it is visible when mode is global_assign_ctrl_inherit_mon or global_assign_ctrl_assign_mon.
>> Sure. Will do.
>>
>>>>      currently assigned group (path format is "CTRL_MON/MON/"):
>>> The format depends on the mode, right? If the mode is "global_assign_ctrl_inherit_mon"
>>> then it should only contain a control group, alternatively, if the mode is
>>> "global_assign_ctrl_assign_mon" then it contains control and mon group. This gives
>>> resctrl future flexibility to change format for future modes.
>> This can be done both ways.  Whole purpose of these groups is to get CLOSID and RMID to enable PLZA. User can echo CTRL_MON or MON group to kernel_mode_assignment in any of the modes.  We can decide what needs to be updated in MSR (PQR_PLZA_ASSOC) based on what kernel mode is selected.
> The "both ways" are specific to one of the two active modes though.
> PLZA only needs the RMID when the mode is "global_assign_ctrl_assign_mon".
>
> Displaying and parsing monitor group when the mode is
> "global_assign_ctrl_inherit_mon" creates an inconsistent interface since the mode
> only uses a control group. The interface to user space should match the mode otherwise
> it becomes confusing.
Ok. That is fine. We can do that.
> ...
>
>
>>>>        Tony suggested using global variables to store the kernel mode
>>>>        CLOSID and RMID. However, the kernel mode CLOSID and RMID are
>>>>        coming from rdtgroup structure with the new interface. Accessing
>>>>        them requires holding the associated lock, which would make the
>>>>        context switch path unnecessarily expensive. So, dropped the idea.
>>>>        https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
>>>>        Let me know if there are other ways to optimize this.
>>> I do not see why the context switch path needs to be touched at all with this
>>> implementation. Since PLZA only supports global assignment does it not mean that resctrl
>>> only needs to update PQR_PLZA_ASSOC when user writes to info/kernel_mode and
>>> info/kernel_mode_assignment?
>> Each thread has an MSR to configure whether to associate privilege level zero execution with a separate COS and/or RMID, and the value of the COS and/or RMID.  PLZA may be enabled or disabled on a per-thread basis. However, the COS and RMID association and configuration must be the same for all threads in the QOS Domain.
> Based on previous comment in https://lore.kernel.org/lkml/abb049fa-3a3d-4601-9ae3-61eeb7fd8fcf@amd.com/
> and this implementation all fields of PQR_PLZA_ASSOC except PQR_PLZA_ASSOC.plza_en must be the
> same for all CPUs on the system, not just per QoS domain. Could you please confirm?

Sorry for the confusion. It is "per QoS domain".

All the fields of PQR_PLZA_ASSOC except PQR_PLZA_ASSOC.plza_enmust be set to the same value for all HW threads in the QOS domain for 
consistent operation (Per-QosDomain).

>
>> So, PQR_PLZA_ASSOC is a per thread MSR just like PQR_ASSOC.
>>
>> Privilege-Level Zero Association (PLZA) allows the user to specify a COS and/or RMID associated with execution in Privilege-Level Zero. When enabled on a HW thread, when that thread enters Privilige-Level Zero, transactions associated with that thread will be associated with the PLZA COS and/or RMID. Otherwise, the HW thread will be associated with the COS and RMID identified by  PQR_ASSOC.
>>
>> More below.
>>
>>> Consider some of the scenarios:
>>>
>>> resctrl mount with default state:
>>>
>>>      # cat info/kernel_mode
>>>      [inherit_ctrl_and_mon]
>>>      global_assign_ctrl_inherit_mon
>>>      global_assign_ctrl_assign_mon
>>>      # ls info/kernel_mode_assignment
>>>      ls: cannot access 'info/kernel_mode_assignment': No such file or directory
>>>
>>> enable global_assign_ctrl_assign_mon mode:
>>>      # echo "global_assign_ctrl_assign_mon" > info/kernel_mode
>>>
>>> Expectation here is that when user space sets this mode as above then resctrl would
>>> in turn program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
>>>      MSR_IA32_PQR_PLZA_ASSOC.rmid=0
>>>      MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
>>>      MSR_IA32_PQR_PLZA_ASSOC.closid=0
>>>      MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
>>>      MSR_IA32_PQR_PLZA_ASSOC.plza_en=1
>>>
>>> I do not see why it is necessary to maintain any per-CPU or per-task state or needing
>>> to touch the context switch code. Since PLZA only supports global could it not
>>> just set MSR_IA32_PQR_PLZA_ASSOC on all online CPUs and be done with it?
>>> Only caveat is that if a CPU is offline then this setting needs to be stashed
>>> so that MSR_IA32_PQR_PLZA_ASSOC can be set when new CPU comes online.
>>>
>>> The way that rdtgroup_config_kmode() introduced in patch #11 assumes it is dealing
>>> with RDT_RESOURCE_L3 and traverses the resource domain list and resource group
>>> CPU mask seems unnecessary to me as well as error prone since the system may only
>>> have, for example, RDT_RESOURCE_MBA enabled or even just monitoring. Why not just set
>>> MSR_IA32_PQR_PLZA_ASSOC on all CPUs and be done?
>>>
>>> To continue the scenarios ...
>>>
>>> After user's setting above related files read:
>>>      # cat info/kernel_mode
>>>      inherit_ctrl_and_mon
>>>      global_assign_ctrl_inherit_mon
>>>      [global_assign_ctrl_assign_mon]
>>>      # cat info/kernel_mode_assignment
>>>      //
>>>
>>> Modify group used by global_assign_ctrl_assign_mon mode:
>>>      # echo 'ctrl1/mon1/' > info/kernel_mode_assignment
>>>
>>> Expectation here is that when user space sets this then resctrl would
>>> program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
>>>      MSR_IA32_PQR_PLZA_ASSOC.rmid=<rmid of mon1>
>>>      MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
>>>      MSR_IA32_PQR_PLZA_ASSOC.closid=<closid of ctrl1>
>>>      MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
>>>      MSR_IA32_PQR_PLZA_ASSOC.plza_en=1
>>
>> This works correctly when PLZA associations are defined by per CPU. For example, lets assume that *ctrl1* is assigned *CLOSID 1*.
>>
>> In this scenario, every task in the system running on a any CPU will use the limits associated with *CLOSID 1* whenever it enters Privilege-Level Zero, because the CPU's *PQR_PLZA_ASSOC* register has PLZA enabled and CLOSID is 1.
>>
>> Now consider task-based association:
>>
>> We have two resctrl groups:
>>
>>   * *ctrl1 -> CLOSID 1 -> task1.plza = 1   : *User wants PLZA be enabled
>>     for this task.
>>   * *ctrl2 -> CLOSID 2 -> task2.plza = 0   : *User wants PLZA
>>     disabled for this task.
>>
>> Suppose *task1* is first scheduled on *CPU 0*. This behaves as expected: since CPU 0 's *PQR_PLZA_ASSOC* contains *CLOSID 1, plza_en =1*, task1 will use the limits from CLOSID 1 when it enters Privilege-Level Zero.
>>
>> However, if *task2* later runs on *CPU 0*, we expect it to use *CLOSID 2* in both user mode and kernel mode, because user has PLZA disabled for this task. But CPU 0 still has *CLOSID 1, **plza_en =1* in its PQR_PLZA_ASSOC register.
>>
>> As a result, task2 will incorrectly run with *CLOSID 1* when entering Privilege-Level Zero something we explicitly want to avoid.
>>
>> At that point, PLZA must be disabled on CPU 0 to prevent the unintended association. Hope this explanation makes the issue clear.
>>
> A couple of points:
> - Looks like we still need to come to agreement what is meant by "global" when it
>    comes to kernel mode.
>
>    In your description there is a "global" configuration, but the assignment is "per-task".
>    To me this sounds like a new and distinct kernel_mode from the "global" modes
>    considered so far. This seems to move to the "per_task" mode mentioned in but
>    the implementation does not take into account any of the earlier discussions
>    surrounding it:
>    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
>
>    We only learned about one use case in https://lore.kernel.org/lkml/CABPqkBSq=cgn-am4qorA_VN0vsbpbfDePSi7gubicpROB1=djw@mail.gmail.com/
>    As I understand this use case requires PLZA globally enabled for all tasks. Thus
>    I consider task assignment to be "global" when in the "global_*" kernel modes.
>    If this is indeed a common use case then supporting only global configuration
>    but then requiring user space to manually assign all tasks afterwards sounds
>    cumbersome for user space and also detrimental to system performance with all
>    the churn to modify all the task_structs involved. The accompanying documentation
>    does not mention all this additional user space interactions required by user
>    space to use this implementation.
>
>    I find this implementation difficult and inefficient to use in the one use case
>    we know of. I would suggest that resctrl optimizes for the one known use case.
>
> - This implementation ignores discussion on how existing resctrl files should
>    not be repurposed.
>
>    This implementation allows user space to set a resource group in
>    kernel_mode_assignment with the consequence that this resource group's
>    "tasks" file changes behavior. I consider this a break of resctrl interface.
>    We did briefly consider per-task configuration/assignment in previous discussion
>    and the proposal was for it to use a new file (only when and if needed!).
>
> - Now a user is required to write the task id of every task that participates
>    in PLZA. Apart from the churn already mentioned this also breaks existing
>    usage since it is no longer possible for new tasks to be added to this
>    resource group. This creates an awkward interface where all tasks belonging
>    to a resource group inherits the allocations/monitoring for their user space
>    work and will get PLZA enabled whether user requested it or not while
>    tasks from other resource groups need to be explicitly enabled. This creates
>    an inconsistency when it comes to task assignment. The only way to "remove"
>    PLZA from such a task would be to assign it to another resource group which
>    may not have the user space allocations ... and once this is done the task
>    cannot be moved back.
>    There is no requirement that CLOSID/RMID should be dedicated to kernel work
>    but this implementation does so in an inconsistent way.
>
> - Apart from the same issues as with repurposing of tasks file, why should same
>    CPU allocation be used for kernel and user space?
>
Yes, I agree with your concerns. The goal here is to make the interface 
less disruptive while still addressing the different use cases.


      Background: Customers have identified an issue with the QoS
      Bandwidth Control feature: when a CLOS is aggressively throttled
      and execution transitions into kernel mode, kernel operations are
      also subject to the same aggressive throttling.

Privilege-Level Zero Association (PLZA) allows a user to specify a COS 
and/or RMID to be used during execution at Privilege Level Zero. When 
PLZA is enabled on a hardware thread, any execution that enters 
Privilege Level Zero will have its transactions associated with the PLZA 
COS and/or RMID. Otherwise, the thread continues to use the COS and RMID 
specified by |PQR_ASSOC|. In other words, the hardware provides a 
dedicated COS and/or RMID specifically for kernel-mode execution.

There are multiple ways this feature can be applied. For simplicity, the 
discussion below focuses only on CLOSID.


      1. Global PLZA enablement

PLZA can be configured as a global feature by setting 
|PQR_PLZA_ASSOC.closid = CLOSID| and |PQR_PLZA_ASSOC.plza_en = 1| on all 
threads in the system. A dedicated CLOSID is reserved for this purpose, 
and all CPU threads use its allocations whenever they enter Privilege 
Level Zero. This CLOSID does not need to be associated with any resctrl 
group. The user can explicitly enable or disable this feature. There is 
no context switch overhead but there is no flexibility with this approach.


      2. Group based PLZA allocation :  PLZA is managed via dedicated
      restctrl group. A separate resctrl group can be created
      specifically for PLZA, with a dedicated CLOSID used exclusively
      for kernel mode execution. This approach can be further divided
      into two association models:

i) CPU based association
CPUs are assigned to the PLZA group, and PLZA is enabled only on those 
CPUs. This effectively creates a dedicated PLZA group. MSRs 
(|PQR_PLZA_ASSOC)| are programmed only when the user changes CPU 
assignments. This approach requires no changes to the context switch 
code and introduces no additional context switch overhead.

ii) Task based association
Tasks are explicitly assigned by the user to the PLZA group. Tasks need 
to be updated when user adds a new task. Also, this requires updates 
during task scheduling so that the MSRs (|PQR_PLZA_ASSOC)| are 
programmed on each context switch, which introduces additional context 
switch overhead.

I tried to fit these requirements into  the interface files in 
/sys/fs/resctrl/info/.  I may have missed few things while trying to 
achieve it.  As usual, I am open for the discussion and recommendations.

Thanks,
Babu

