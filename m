Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8230E85D;
	Thu, 26 Mar 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545149; cv=fail; b=cK8oco+rTOzFrf8CyllrqMrc+vE1Ij1+9ZrnUBnQ57v2hu9pO8HyLhjiPvt37RFuYEp1Hx4ax9gdFWgBCT/1vNA4QscwONvrKyIPWsAf6JYZhByGy6P7lfOkXTF+AcLkEJwkWxKxZvRqXgiXJG0wjXbQzJ/qh3hnYieuA5YACPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545149; c=relaxed/simple;
	bh=sGcRwVy7C9gkeMfaz5nnnfgKlhcty64HgF60O2hOA9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m4qbeKwUmlC051RN1nN4tsQPBYL03CHK6/EeX2ul9FAm+KxheIpM1U+nIpUHOOtBkOwB2R2hsuBgE90QSjGEQkS77iurOJBvM+WW0zti3uVFf6U00FmE9njwlNZM2kxki2xwwXk+42bgrX4aJTDA05NBh3BNyLlCUhcfOnT8fU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cKKPXVUU; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cKKPXVUU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDZi/eE3TIdRmApVT+/mbQoYy4nx8GO30O29s6kFM54bdn4VWqbqxGsUbl0Zj+oulDsuqGeVbr09vYkPczueA8sOfPwdEBEP5zL67eW7BCOuTRFkvhZyOoew8eeZeSsViZ5O4hXv/npA0Xl3XA1OGMAAuTcQ/d5MrosGVcUDeazWX8UDUTrdFMc6QKl2xTA2NrxlAbcip9ElIs8URQy9Xy3y2Iry8wlfL3fp077UsNS3N+1LQbCY6jhg4eNz8lqkxoDaqTGqPATu0cYBgDR5uk4AfPxWbURPc5c3EclmsztJX0nuNFk+BxGxyNnD+3i68ZthJWrC04dT7+plrXxqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L9ZUDQvO4BHcoJLuf5Mp0i2ABP/IA87K+jHiGKz454=;
 b=ftX0HaH+ubRnXo0pcpExBuX7RaeVrcmv0IwWjELjH2IBIrsFiz8pifSSQFlGZcin0deRCrChVlPHfnjo4TwU04dTORQXyciFWpcMwsfNhd3lWnbQ6Ag1u4R2XEaMH9nI1RUr8JTsU56GUhKHNTEB+YV7EcXi2R54HsnMSiHurYIpcluu9kFVsj4VhSL46ViwPaawR8jHJnQTfpzH5hpEvnmf1iG4lhMGVn+ivDThI2sthKkKjh8/WM6fZ47MR+GjnQE5K98L7PliKGI/gWFx4U34R4GH/nlKcXVf81jRS5TcioUgYSLypoYOVHPZIxTyrqGUwdP2MgIc9v5dUW1fZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L9ZUDQvO4BHcoJLuf5Mp0i2ABP/IA87K+jHiGKz454=;
 b=cKKPXVUUImdDkQSwlQWPU5RlU0AT5MqIFAjcBST6U+9Vfg/UmsgB00Ag6LvClGy5WQknu4Jcj5nHcybkBPnKYLhE5E+1S9LSkFnhe5ahdONMgwsqgxw4iEwzEdBS+BCf7hikFKz92ld0qUTDvwrszyawSrytm1XwoDbaccURqkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by IA1PR12MB6211.namprd12.prod.outlook.com
 (2603:10b6:208:3e5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 17:12:22 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 17:12:22 +0000
Message-ID: <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
Date: Thu, 26 Mar 2026 12:12:17 -0500
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
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:806:23::19) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: c802c3a3-baa6-42e7-7702-08de8b5ad7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18092099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ehR7AG7wL32zqzASPpcO6CEziOK0Yg/Ip+jzMDTiRlNq50BAqYtzXUsWsjJ06r9Rb8qZ/DQ5P7roovGK1wHuvEgRFaPfe8n8molmTzl64WsVJYI+DPQWnTIRv+kaO/ph4h8kXtQ4ScfR9ipKCV5Y6PRWVEFEc9xnug0r0uqZuYGwp2gGoE2fBWyfLjrFsKcAmfcc0hw/I21eEysf9eQi6nHXcDhJv4t1ag69NG0XXYCphNh6ICCvKHBNcXBtjlu9ha/UmLbL3+ll/ZR6Fs6bOWcJg9rFmRlPUN9pUJDFKJC6s/C9FG6eq4jKrYD/GDuX6DHMdfYCXf05pwT8bmecMbrKCqYmm72exOPOBjfbY6g2TlO3KmOCSw7EZToVygMLPwxGxSUY0zZAh0PI8oBjv6PD9OLjM+tCKe9S2+NVDcSAX64sPlG0FOZVE/FCrJJVIZqrsv8gyCHO/B+djDWAjZFKkz7kNrG9zZXkKxMLkf9K2CN7031/H4atBV7JV/cFNi3KxTQANp4b96UEMD4gf/mSdeiZcFNUZrao6L8Pa7j5t7NZdKxp9SlWS71vGZISUCPgj2MiEBAprXFWb4zQmt0sqAe1TlKJO42DBwnOJV2hfqmCSk/J124+h6CCNNXXk+rSu8almLQrtLfLyo9wFJ4jXLZSL6HqFSRoMvYzWqNdwXQCpZgjqg+ALyNGNWLn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18092099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHRPUUpWQ2dkSVBSekorMzRJOEFmL3JzVDJ5STV4R0p6KzNUOExpMjNwb1k0?=
 =?utf-8?B?QnRaSTFtOTlhalRjQmRHTGZXcGxScEdCWjZsSlVWTW9Hd0tWa05lM3Jlei9I?=
 =?utf-8?B?SE9aZjU1aG5xRkNOekl5MjZZajFTd28rT0JnRUN3Qkx2dFl3dnFoVE81eGVq?=
 =?utf-8?B?TDdBd1dLU1FyWHArUkdBUExnTmhpUy9lRk1mRXR2Y1NTZUM3aWtGaThFWlNq?=
 =?utf-8?B?bTNCUEVuNlF1VWdTeTNoWGIxb3FyeEt2MVp2RGlxZjZKWkIxTEhhNUo4OEJJ?=
 =?utf-8?B?cWRhbVg5UHFPWCs3RmhXRERyZnd3VHFUUTIyZVUzUFdlZ1RhRmdkOGo3MGlJ?=
 =?utf-8?B?VDVlMUJGTytkcDdxa1kraG91R1hINUxSV0FDaXp4aXozUm5Qc01CaFd0T0ov?=
 =?utf-8?B?UjBOaGtyS2Q4WWg1UEwrcHRPalRpQ2VxNFBFWkVIeUtPRUpDSjVoTlF5ZDRy?=
 =?utf-8?B?OEl1a0M2RXIvaWpFUFBxb1FjZ3JFTkFlNW83VUxxeVVSSVpUdFg3N2JTRllt?=
 =?utf-8?B?R09BSTlUSnN2dXcvUzhUT0FvdThkMnh4RHQvMjU2d3JVUnpsZGdUOEtuWG51?=
 =?utf-8?B?aDZ2Qkl3QUh5QXVjRm9wZEd1N3dCZUhIQzZNM3VrZXNIcDBGV0cyY2NqQkxJ?=
 =?utf-8?B?cGR6Tyt4NWdlZWw3dWI3eDFERDNDVUpRR0tNaU1YTktBWmtVdlNrMmJQNUhM?=
 =?utf-8?B?d2d2SmpjLytwVDhjVjBtRG1RWVh3Tmx6UEtpMzRNeWZyYWdUc2MyRTNiMkxM?=
 =?utf-8?B?YkZzYUxBNGI2c2M2N01IK2dIY2daVms1UGJpM0szTXJLSTlGZFRqOGUzcytu?=
 =?utf-8?B?V2tZSnJrK0tHWGFJanIxVld2S1hzVlQ4T29qd0RIUDE3cHkzWUlDSGxWNUl2?=
 =?utf-8?B?TjQxSEFSK2lta2hHUEQyVFpwbjFyT3g5MjlZRmFHbVlWV1Bjd1JacmxpalF5?=
 =?utf-8?B?RnowTW9hdS95U0wzU090eWRHYlpCdDBJdmVnZ0VUaHBNeEhHSDk0QUEvYm9z?=
 =?utf-8?B?aUhzZ3NsMGdZSEZMMlAzREtLYjlNMnRqTzBWVS9QeGFHOFQzNVVkY3FZODBw?=
 =?utf-8?B?dWJUTHhPNVphZ1JSbWVwSTZUSFpuVXIxcTY4U3cvZUwyMzJhVFVuV2YxTG9m?=
 =?utf-8?B?bU9NT1dRdzB3NnQzRVpOYVhKckp6dXNDbHhRY1YvanU2NzZ2MDBjYTVSVzdW?=
 =?utf-8?B?TWVicmNLc3JmODVJaXpBOHdQU1VhZUxuMm9FVXNlOElLSmtZYXdHdDNSRHpQ?=
 =?utf-8?B?Rkl4ak96QjhBZjhzK083WGdHd05tTVBzVng0VlcxL0tWd29GZzdUY3RuYi82?=
 =?utf-8?B?aDNoZkNqd2RpUmJiVjZkdFBHYnVONVN0QS9IaVVQcTQ5RGV1YWRkT0tWWHdB?=
 =?utf-8?B?clVuelpXSGRHN0dmSDFwRG8rbzFIUTJDYjA4SlVybVc3dWlDY2VWNGk3cmpV?=
 =?utf-8?B?ZnZZL2lpMlJXVkNQMndHSW1DVENOVDQ4VU51eFBpaG9ibTBBUjhCOHcyQnpR?=
 =?utf-8?B?R2poNk8rZTI0VFd0YTByVE1naHRBOU50OTZOUE93WnI1V1Fvd1ZZTjc0M2ha?=
 =?utf-8?B?emRuTDdHZnVVNCtETUZ0S1pORm9DWTk2ODdTbHROWE9uYzJmNGpjT3JKa1U5?=
 =?utf-8?B?L2tYYlpCZlpUQ0hxVnFiT1VETm5Ccy9nY1lqa3B1bmJmcmRsdHBrL0loY2E0?=
 =?utf-8?B?SFgzWTk5bVYwb2Y3eGh3YWIxYVJZSHV5SGNGazdDZ0htd05sSDRoWk5SZVBo?=
 =?utf-8?B?Ky85ZXUvYUdSQmRzOTUzd1oyVGdsRnk2QjFoT0ZIWjNzRWowdHZ6NCt5NDYr?=
 =?utf-8?B?ZmhMT2pMWnJabng0S0VnRlJHNDVYZkZNSTgyRFJXM1pmVUpOMzgxbEgvZ0Zx?=
 =?utf-8?B?eVppSTUwbTgyQU0ySWhNVnRFMkNDaHdTekkwTVl6T2hYbGRuRy9MZWhoY3g1?=
 =?utf-8?B?N3ZSdTkvTThQY0FIZVp5c3NKQW1pVDNYMUcwZHZJSkNkSlBSa0N2SmNzUDRv?=
 =?utf-8?B?Y3Qzak5oYVVZVVptejd5T1JGcTZnSklzR1BSMDBKbnFRSzg1Y2NmU2JsKzI1?=
 =?utf-8?B?eHIwWmFNTGZpRURWbHRsOFVZdCtETUg4Z01pVlkrQjVZMVpiRERaN0FPYitr?=
 =?utf-8?B?clFFNE95ZFhJRHdIVXNBd1VzbHVhOGR0ZGpkeUZMMGJ5SVJBeUUzT2p4RXl3?=
 =?utf-8?B?MlRwT0NtNnVEbG9QY0ZDTmFUNUJnRFJROFBNK0RHUjF4Y25MRUZUL1NYMnpI?=
 =?utf-8?B?Ymd5aTk1REQ5Sk4reStDc3EvZWN5bXR0YnlNRi9tNEpyOHdHT3lWV2VYZUJj?=
 =?utf-8?Q?FLCsmQMLiwfK0C3dZm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c802c3a3-baa6-42e7-7702-08de8b5ad7cd
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 17:12:21.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVosQgc997KI1VMlKFRkhxufWKG4O2tX+lp4HcSQuO9tWCDAd0FzpME3zs/Jcmuw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

Hi Reinette,

Thanks for the review comments. Will address one by one.

On 3/24/26 17:51, Reinette Chatre wrote:
> Hi Babu,
>
> On 3/12/26 1:36 PM, Babu Moger wrote:
>> This series adds support for Privilege-Level Zero Association (PLZA) to the
>> resctrl subsystem. PLZA is an AMD feature that allows specifying a CLOSID
>> and/or RMID for execution in kernel mode (privilege level zero), so that
>> kernel work is not subject to the same resource constrains as the current
>> user-space task. This avoids kernel operations being aggressively throttled
>> when a task's memory bandwidth is heavily limited.
>>
>> The feature documentation is not yet publicly available, but it is expected
>> to be released in the next few weeks. In the meantime, a brief description
>> of the features is provided below.
>>
>> Privilege Level Zero Association (PLZA)
>>
>> Privilege Level Zero Association (PLZA) allows the hardware to
>> automatically associate execution in Privilege Level Zero (CPL=0) with a
>> specific COS (Class of Service) and/or RMID (Resource Monitoring
>> Identifier). The QoS feature set already has a mechanism to associate
>> execution on each logical processor with an RMID or COS. PLZA allows the
>> system to override this per-thread association for a thread that is
>> executing with CPL=0.
>> ------------------------------------------------------------------------
>>
>> The series introduces the feature in a way that supports the interface in
>> a generic manner to accomodate MPAM or other vendor specific implimentation.
>>
>> Below is the detailed requirements provided by Reinette:
>> https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
> Our discussion considered how resctrl could support PLZA in a generic way while
> also preparing to support MPAM's variants and how PLZA may evolve to have similar
> capabilities when considering the capabilities of its registers.
>
> This does not mean that your work needs to implement everything that was discussed.
> Instead, this work is expected to just support what PLZA is capable of today but
> do so in a way that the future enhancements could be added to.
>
> This series is quite difficult to follow since it appears to implement a full
> featured generic interface while PLZA cannot take advantage of it.
>
> Could you please simplify this work to focus on just enabling PLZA and only
> add interfaces needed to do so?
Sure. Will try. Lets continue the discussion.
>
>> Summary:
>> 1. Kernel-mode/PLZA controls and status should be exposed under the resctrl
>>     info directory:/sys/fs/resctrl/info/, not as a separate or arch-specific path.
>>
>> 2. Add two info files
>>
>>   a. kernel_mode
>>      Purpose: Control how resource allocation and monitoring apply in kernel mode
>>      (e.g. inherit from task vs global assign).
>>
>>      Read: List supported modes and show current one (e.g. with [brackets]).
>>      Write: Set current mode by name (e.g. inherit_ctrl_and_mon, global_assign_ctrl_assign_mon).
>>
>> b. kernel_mode_assignment
>>
>>     Purpose: When a “global assign” kernel mode is active, specify which resctrl group
>>     (CLOSID/RMID) is used for kernel work.
>>
>>     Read: Show the assigned group in a path-like form (e.g. //, ctrl1//, ctrl1/mon1/).
>>     Write: Assign or clear the group used for kernel mode (and optionally clear with an empty write).
>>
>> The patches are based on top of commit (v7.0.0-rc3)
>> 839e91ce3f41b (tip/master) Merge branch into tip/master: 'x86/tdx'
>> ------------------------------------------------------------------------
>>
>> Examples: kernel_mode and kernel_mode_assignment
>>
>> All paths below are under /sys/fs/resctrl/ (e.g. info/kernel_mode means
>> /sys/fs/resctrl/info/kernel_mode). Resctrl must be mounted and the platform
>> must support the relevant modes (e.g. AMD with PLZA).
>>
>> 1) kernel_mode — show and set the current kernel mode
>>
>>     Read supported modes and which one is active (current in brackets):
>>
>>       $ cat info/kernel_mode
>>       [inherit_ctrl_and_mon]
>>       global_assign_ctrl_inherit_mon
>>       global_assign_ctrl_assign_mon
>>
>>     Set the active mode (e.g. use one CLOSID+RMID for all kernel work):
>>
>>       $ echo "global_assign_ctrl_assign_mon" > info/kernel_mode
>>       $ cat info/kernel_mode
>>       inherit_ctrl_and_mon
>>       global_assign_ctrl_inherit_mon
>>       [global_assign_ctrl_assign_mon]
>>
>>     Mode meanings:
>>     - inherit_ctrl_and_mon: kernel uses same CLOSID/RMID as the current task (default).
>>     - global_assign_ctrl_inherit_mon: one CLOSID for all kernel work; RMID inherited from user.
>>     - global_assign_ctrl_assign_mon: one resource group (CLOSID+RMID) for all kernel work.
>>
>> 2) kernel_mode_assignment — show and set which group is used for kernel work
>>
>>     Only relevant when kernel_mode is not "inherit_ctrl_and_mon". Read the
> To help with future usages please connect visibility of this file with the mode in
> info/kernel_mode. This helps us to support future modes with other resctrl files, possible
> within each resource group.
> Specifically, kernel_mode_assignment is not visible to user space if mode is "inherit_ctrl_and_mon",
> while it is visible when mode is global_assign_ctrl_inherit_mon or global_assign_ctrl_assign_mon.

Sure. Will do.

>
>>     currently assigned group (path format is "CTRL_MON/MON/"):
> The format depends on the mode, right? If the mode is "global_assign_ctrl_inherit_mon"
> then it should only contain a control group, alternatively, if the mode is
> "global_assign_ctrl_assign_mon" then it contains control and mon group. This gives
> resctrl future flexibility to change format for future modes.

This can be done both ways.  Whole purpose of these groups is to get 
CLOSID and RMID to enable PLZA. User can echo CTRL_MON or MON group to 
kernel_mode_assignment in any of the modes.  We can decide what needs to 
be updated in MSR (PQR_PLZA_ASSOC) based on what kernel mode is selected.


>
> We should also consider the scenario when it is a "monitoring only" system, which can
> happen independent from what hardware actually supports, for example, if user boots
> with "rdt=!l3cat,!l2cat,!mba,!smba". In this case I assume CLOS should just always be
> zero and thus only "default control group" is accepted?

Yes.  It depends on how we want to implement like we mentioned above.


>
>>       $ cat info/kernel_mode_assignment
>>       //
>>
>>     "//" means the default CTRL_MON group is assigned. Assign a specific
>>     group instead (e.g. a CTRL_MON group "ctrl1", or a MON group "mon1" under it):
>>
>>       $ echo "ctrl1//" > info/kernel_mode_assignment
>>       $ cat info/kernel_mode_assignment
>>       ctrl1//
>>
>>       $ echo "ctrl1/mon1/" > info/kernel_mode_assignment
>>       $ cat info/kernel_mode_assignment
>>       ctrl1/mon1/
>>
>>     Clear the assignment (no dedicated group for kernel work):
>>
>>       $ echo >> info/kernel_mode_assignment
>>       $ cat info/kernel_mode_assignment
>>       Kmode is not configured
> This does not look right. Would this not create a conflict between info/kernel_mode
> and info/kernel_mode_assignment about what the current mode is? The way I see it
> info/kernel_mode_assignment must always contain a valid group.
Yes.  We can do that.
>
>>     Errors (e.g. invalid group name or unsupported mode) are reported in
>>     info/last_cmd_status.
>>
>> ---
>>
>> v2:
>>       This is similar to RFC with new proposal. Names of the some interfaces
>>       are not final. Lets fix that later as we move forward.
>>
>>       Separated the two features: Global Bandwidth Enforcement (GLBE) and
>>       Privilege Level Zero Association (PLZA).
>>   
>>       This series only adds support for PLZA.
>>
>>       Used the name of the feature as kmode instead of PLZA. That can be changed as well.
>>
>>       Tony suggested using global variables to store the kernel mode
>>       CLOSID and RMID. However, the kernel mode CLOSID and RMID are
>>       coming from rdtgroup structure with the new interface. Accessing
>>       them requires holding the associated lock, which would make the
>>       context switch path unnecessarily expensive. So, dropped the idea.
>>       https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
>>       Let me know if there are other ways to optimize this.
> I do not see why the context switch path needs to be touched at all with this
> implementation. Since PLZA only supports global assignment does it not mean that resctrl
> only needs to update PQR_PLZA_ASSOC when user writes to info/kernel_mode and
> info/kernel_mode_assignment?

Each thread has an MSR to configure whether to associate privilege level 
zero execution with a separate COS and/or RMID, and the value of the COS 
and/or RMID.  PLZA may be enabled or disabled on a per-thread 
basis. However, the COS and RMID association and configuration must be 
the same for all threads in the QOS Domain.

So, PQR_PLZA_ASSOC is a per thread MSR just like PQR_ASSOC.

Privilege-Level Zero Association (PLZA) allows the user to specify a COS 
and/or RMID associated with execution in Privilege-Level Zero. When 
enabled on a HW thread, when that thread enters Privilige-Level Zero, 
transactions associated with that thread will be associated with the 
PLZA COS and/or RMID. Otherwise, the HW thread will be associated with 
the COS and RMID identified by  PQR_ASSOC.

More below.

>
> Consider some of the scenarios:
>
> resctrl mount with default state:
>
> 	# cat info/kernel_mode
> 	[inherit_ctrl_and_mon]
> 	global_assign_ctrl_inherit_mon
> 	global_assign_ctrl_assign_mon
> 	# ls info/kernel_mode_assignment
> 	ls: cannot access 'info/kernel_mode_assignment': No such file or directory
>
> enable global_assign_ctrl_assign_mon mode:
> 	# echo "global_assign_ctrl_assign_mon" > info/kernel_mode
>
> Expectation here is that when user space sets this mode as above then resctrl would
> in turn program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
> 	MSR_IA32_PQR_PLZA_ASSOC.closid=0
> 	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
> 	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1
>
> I do not see why it is necessary to maintain any per-CPU or per-task state or needing
> to touch the context switch code. Since PLZA only supports global could it not
> just set MSR_IA32_PQR_PLZA_ASSOC on all online CPUs and be done with it?
> Only caveat is that if a CPU is offline then this setting needs to be stashed
> so that MSR_IA32_PQR_PLZA_ASSOC can be set when new CPU comes online.
>
> The way that rdtgroup_config_kmode() introduced in patch #11 assumes it is dealing
> with RDT_RESOURCE_L3 and traverses the resource domain list and resource group
> CPU mask seems unnecessary to me as well as error prone since the system may only
> have, for example, RDT_RESOURCE_MBA enabled or even just monitoring. Why not just set
> MSR_IA32_PQR_PLZA_ASSOC on all CPUs and be done?
>
> To continue the scenarios ...
>
> After user's setting above related files read:
> 	# cat info/kernel_mode
> 	inherit_ctrl_and_mon
> 	global_assign_ctrl_inherit_mon
> 	[global_assign_ctrl_assign_mon]
> 	# cat info/kernel_mode_assignment
> 	//
>
> Modify group used by global_assign_ctrl_assign_mon mode:
> 	# echo 'ctrl1/mon1/' > info/kernel_mode_assignment
>
> Expectation here is that when user space sets this then resctrl would
> program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid=<rmid of mon1>
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
> 	MSR_IA32_PQR_PLZA_ASSOC.closid=<closid of ctrl1>
> 	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
> 	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1


This works correctly when PLZA associations are defined by per CPU. For 
example, lets assume that *ctrl1* is assigned *CLOSID 1*.

In this scenario, every task in the system running on a any CPU will use 
the limits associated with *CLOSID 1* whenever it enters Privilege-Level 
Zero, because the CPU's *PQR_PLZA_ASSOC* register has PLZA enabled and 
CLOSID is 1.

Now consider task-based association:

We have two resctrl groups:

  * *ctrl1 -> CLOSID 1 -> task1.plza = 1   : *User wants PLZA be enabled
    for this task.
  * *ctrl2 -> CLOSID 2 -> task2.plza = 0   : *User wants PLZA
    disabled for this task.

Suppose *task1* is first scheduled on *CPU 0*. This behaves as expected: 
since CPU 0 's *PQR_PLZA_ASSOC* contains *CLOSID 1, plza_en =1*, task1 
will use the limits from CLOSID 1 when it enters Privilege-Level Zero.

However, if *task2* later runs on *CPU 0*, we expect it to use *CLOSID 
2* in both user mode and kernel mode, because user has PLZA disabled for 
this task. But CPU 0 still has *CLOSID 1, **plza_en =1* in its 
PQR_PLZA_ASSOC register.

As a result, task2 will incorrectly run with *CLOSID 1* when entering 
Privilege-Level Zero something we explicitly want to avoid.

At that point, PLZA must be disabled on CPU 0 to prevent the unintended 
association. Hope this explanation makes the issue clear.

Thanks

Babu

>
> Enable global_assign_ctrl_inherit_mon mode:
> 	# echo "global_assign_ctrl_inherit_mon" > info/kernel_mode
>
> Expectation here is that when user space sets this mode then resctrl would
> program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=0
> 	MSR_IA32_PQR_PLZA_ASSOC.closid=0
> 	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
> 	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1
>
> 	# cat info/kernel_mode
> 	inherit_ctrl_and_mon
> 	[global_assign_ctrl_inherit_mon]
> 	global_assign_ctrl_assign_mon
> 	# cat info/kernel_mode_assignment <==== returns just a ctrl group
> 	/
>
> Modify group used by global_assign_ctrl_inherit_mon mode:
> 	# echo ctrl1 > info/kernel_mode_assignment
>
> Expectation here is that when user space sets this then resctrl would
> program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=0
> 	MSR_IA32_PQR_PLZA_ASSOC.closid=<closid of ctrl1>
> 	MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
> 	MSR_IA32_PQR_PLZA_ASSOC.plza_en=1
>
> 	# cat info/kernel_mode_assignment <==== returns just a ctrl group
> 	ctrl/
>
> Enable inherit_ctrl_and_mon mode:
> 	# echo "inherit_ctrl_and_mon" > info/kernel_mode
>
> Expectation here is that when user space sets this mode then resctrl would
> program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid=0
> 	MSR_IA32_PQR_PLZA_ASSOC.rmid_en=0
> 	MSR_IA32_PQR_PLZA_ASSOC.closid=0
> 	MSR_IA32_PQR_PLZA_ASSOC.closid_en=0
> 	MSR_IA32_PQR_PLZA_ASSOC.plza_en=0
>
> At this point info/kernel_mode_assignment is not visible anymore:
>
> 	# ls info/kernel_mode_assignment
> 	ls: cannot access 'info/kernel_mode_assignment': No such file or directory
>
> >From what I understand above exposes and enables full capability of PLZA. All the other
> per-task and per-cpu handling in this series is not something that PLZA can benefit from.
> If this is not the case, what am I missing? Could this series be simplified to just support
> PLZA today? When next hardware with more capability needs to be supported resctrl could be
> enhanced to support it by using the more accurate information about what the hardware is
> capable of.
>
> We also do not really know what use cases users prefer. This may even be sufficient.
>
> Reinette
>
