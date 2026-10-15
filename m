Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD44EE85F;
	Thu, 15 Oct 2026 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105639; cv=fail; b=J77wLKqsYsWWaIgKRp+dKv7PrAv3AGb4QLVWUvzrOXpNBpQGgUuRVaiIF/2fGPFYl6NEP/soHf4WlRcHa3lMM7uPb747s047rlH8cJSbO4UJF43b9CKUth1geZql2ldbGoQCnbLYGJUB7/n/eoo9y1aCEqrAu3kslS48P9JfQP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105639; c=relaxed/simple;
	bh=TZQ/f60YA9CR+2a27GRzMy+syN6bxKak7KeO3OPzUUQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nfflV6xtlkv0QSY1YDbHOEMoONj5g2nq/aeMl9wAygEK6MQ4pR+wXFEw39XcB2GypgvLBYUvP8gM4iDALnSCEx/7L4LDagc40sYVj0DUP/iGn+aRb+sgNefyniUhZc2mfqunyOlNW9v3IydEm5FUISRD3TYUHmnZDTqf8up/GLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5YYB0sIC; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5YYB0sIC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+scjpEU6qDJMPRvKcx99karb8WFMVbhSzLrt9bnVIBdIvm7O8Mse5NKRBN7J2eJeyTkiJbjVsns0Vl71R0pplz0HkVPmmjfS+Gdj5OpmuCv9+F3X7Apqu7tiB8O/D/04EBYHB5hSY34/v5d7+YxecqQySMh24VQztUYkaCCMDWXobbwoOG6duveBdiZ7Pjs5iHJp1Z/NgCgh6trdyGElDgDaS8HAr1f8nkonRGdEAZb0OahZpQZ5SI9r1E8uQB5tVQKg5vktahuOYBjFrbVd5b9bBp8JSiDbFWEsNFRfbh+ZVuLAGC5GCxpJgcBTY3Ck3365y+LKWuvJt6YlS5Gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irZ8FDV3BI0fN5EgW2nxgU3ACiYxh9Rp+0mF0pf1WIA=;
 b=PvqVd1n5ORSRFn8txa4VmkJMQjmLORw8XINhi91srN0VTUTO+E+XPyFWevo4lHGOTA0lWOzLvwWxm4UEN/viL7tE8YXg9Ce+Z3eek2PJbG0kKbU0+OKfy+T9P0RprPCZV/j8jXZDzbVOTm3+YCMd2YvzSi0bx6TPo5jtDRshtVHBjC7LcRsVw8vKdESl9oh/dlaeQmh+htQtimTYkJ9MQLEaFUJnXxtwPcblJA+4Hw/LIw4xZB5+ke7JfphyjHELZntGQfAQX6oI1suje4TQw+sivY4+nceLiWM27A5CABKVWafSC7go6ih6iq+mUQhsSis+VdLevHWWdpYag/vlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irZ8FDV3BI0fN5EgW2nxgU3ACiYxh9Rp+0mF0pf1WIA=;
 b=5YYB0sICZ8zFYwwyuptpHCTYmmYXSUK6vCKts3xpX+sMUjcOKxSu4cgDmsMqShKr8N5eXYvoUUxm3uZsYaGHXa/miCtSVUU60kNGAZKmy9CUz6JcePRXfesN60A7MX2jSPpgWJcBteCSfewodv3YT5n7Q3k4XoPdVEDfneFLY7U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 23:07:14 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:07:14 +0000
Message-ID: <c557ea83-11aa-4747-b305-93d554d3fbc4@amd.com>
Date: Thu, 15 Oct 2026 18:07:03 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration definitions
 and data structures
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, ben.horgan@arm.com
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
 <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
 <bf4bd727-eac2-48ba-ad85-539a818524d6@intel.com>
Content-Language: en-US
In-Reply-To: <bf4bd727-eac2-48ba-ad85-539a818524d6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::14) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d91980c-9b8a-4c05-bc16-08df2b110d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|10067099003|22082099003|3023799007|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ochB67sch8Auz/wYtM3Vmrx3VX2I3Lhb5O5hshlbcAu3UYYvCyMf8ZnO3Jp1JqLcqYQ7ionlswpPXEhK6XaU9/i0G4Jw9NyYSdx/hP4tGAoE2DOtmkIPtavFZ7YXOp61YpGJpdvEB/rj97xiZKcLAeDpeKkhii5dc7qRp+P76WnvOSA1OetxQeV6yceiuG9+eiYtn7i9r60pvGecVnzA62GcTc/hWkVhQuwN0oOs4lmsPwoUSW3Lunpw6dwALmMHgmnwVdJbNAKbJRHA1KQGHbLAwrqbYLtm6qlH1wpUEgMV4p+7Vs+tvyFeZXSASXUrNY2IgGSyv35EO5g5tyzx37czJZDuVphemxygg/SglCqWR+vI6VuzZe/jB/H/r/nh94yjgv7288kEY+aqu1dRFz4s7y7eBNleJ6C0u/DLldG5CFnVAgXKdpDbjG3klM8aFDRdS8M6797JpyVKfqkLttJ8q3iJyPfQ8yQcFJoWQrGjdcLVWMNhW70p5o6NkhkcpPg0gXTBQGGqKUKPxQ2XlWodCBxTfpKlUikZGqtbZ8aJ5lhT/8By7SHUL9ZuPS4GEMCzCJIzXnXqlaza9l32l8PFGZQu7K0EczRJGyr2oyKC0ACcmXDhB5Z4Osq/wY2vdtUw4MkWYw65ftZFajFkPHAL45DIkVJkvOIdWzRNe0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHJmcHB6cldUcFdGU2tpNmc5TEZyanR3RkdGaEhzYlVsMForclEzWUNRNVZm?=
 =?utf-8?B?ZDVIK1MvMlUwbGprVllCY0dhU2hyMHRNRXVpRGt4QWh3OC9nMFJ4clhoUmEr?=
 =?utf-8?B?d1AvbGRpRCt3YW9kRk03WXBleTF4a2dvaE4zTTRoOHdvR01KZkIzZ3JCNmYr?=
 =?utf-8?B?UDNMNmV0cGFKUVhhVjFlcjE2L1JzMmRHd1FWMU9VaWk2OGZWTGxKTUlTWVpw?=
 =?utf-8?B?bWsyVDhFRHRlOEtVNUpDTEtTc3htaHQ2UXU5ZHc4ekJJY1kxVURrNFgrdjZo?=
 =?utf-8?B?c3lmajFzQ2tVV2gyclh5d0N0NnhzbUVJTnJ3ZmZMM1hPS0F3VmRWUXJuZFdr?=
 =?utf-8?B?ZlhJRUdSTHZ4a1ZSWTZicG54VlVQSjJnNTBxbW1xMUpqQkJ6b3piNkcrTlZj?=
 =?utf-8?B?SmhkQktpWFExYVlUT3dUejRxcFdlUVZoQms4M1htN1ZHa3pwNzBpOGtnT2l1?=
 =?utf-8?B?THJwZzVhbmpKZHdWYXVTeWY1eGhkVUdoTmxpenJoZjBHMC9mOFliZ1BEN3ZL?=
 =?utf-8?B?V21jc0M2aDhXS0daaWJmd25hMEorUVlsZ1J4U3NTd0ROTnl6Z1B5K090YU91?=
 =?utf-8?B?bm1SRXY5cDUvTStxYzZXbmdmT0oxSzFGZWUvRlJnRmF1Q0RzV1FtQ3poeTBa?=
 =?utf-8?B?eE5RT3lnL3haYmdxUy8wbzBpRmFoNXNXKzBsUi9IY2E3STBmUGRBMDZLQmR6?=
 =?utf-8?B?ZXNEYzArMXZsdWNBWmZPL29rN0tRM1ZDYzRlV0pRU0VEQklUY2JHemxvL3A1?=
 =?utf-8?B?QjA0c2plcWczZld2U3JtVU1SKzQyQVR6WkpvWGpjUDZNYUhoNm1jQ3BKcFRK?=
 =?utf-8?B?R2E5WHp5Sk04d0NHQXNzejRXbU45aWFXUmQzR3N1LzZaVU1jak1yQmdHL2oz?=
 =?utf-8?B?V2g3VUtqcDFXeERTamo1K2Fsc2RMeFFmYi80SFhzL09EeVlVOTN4NVRIR0ZE?=
 =?utf-8?B?SUdhSGhIalFHYlV4TTA1SWhlV0FNYTRzelBaODkzb3N1bkRQWnl6ODJvVW9M?=
 =?utf-8?B?S3NaZmpIRnBZSEdZbWdMNUhwaENLTHl4eFA2bmNSTFViQS9Scnk5b2hrSCt6?=
 =?utf-8?B?Mi9OTjZmWWFNVG14c01GWUJwWWFEZjl5MEhsVTFTMHdxbjFtbzNCY1NtQ1pk?=
 =?utf-8?B?TGk1UThsaWpUaXE4UHB2endoK2VHR0NHaEk1NU5Ea0srWFZkRHg1N2tqeUs0?=
 =?utf-8?B?QTkrRGlSWWRzdEFPSmpsYlZsVEJaTkpic3JtZ2RSTW1zeXRweGJWT0VkaXJI?=
 =?utf-8?B?Zmg5cUNRZXZnRW1Ra3FsVzdtVW1VOTlOb1U5a2w0K24wSlkxb2g2NU51d3E4?=
 =?utf-8?B?cGZUVng3WDZ6YWVJY1prVjQ2blBISlFPYmxwODk3eFpWalQ3Q05JOVRJM2NZ?=
 =?utf-8?B?Z0pWeS8rbHZTRmZVd1VLNm1obmMvcVcwUkxXb2tUT0FDNXJVeFNpYTM0eG1L?=
 =?utf-8?B?Vys2WVZSUkpmMVc4RktWSk9rZjR4YUEzNWtDdGl3eHN6MGhHKzU5M3d2R1lT?=
 =?utf-8?B?cmhud1Z4NHYySW1uU1FEWlg4cnZQcHVQWVkzTjd5eERWSjQ4OC9BRHZHRW1k?=
 =?utf-8?B?T1Vyejd1c3kyTHdRU1d1cDBKektlZjIzenIzbjZRb2E1dTVEdzNkT1dkTmNV?=
 =?utf-8?B?ako1eTZXRzROYWFyNW5hZ3FuMGlsRWtaUDhnZjh1cFRFaVlsR2FKOXIrWVg3?=
 =?utf-8?B?TFlYQm50N29vRTZIcXU0a0VneDEzN3BpRzJaMFlsbStYdVVvcGNsSDBLamZO?=
 =?utf-8?B?ak16R2ZETWw2bS9LMGJkZE9mWGpLbS90SitITU85dFJsZ0p1SHdTYTh3VUs1?=
 =?utf-8?B?WDN0TGVRUjhPUnlJTGowTjB3ZzB3dWpIRU9ITGUva3IvRWg1K1Y2c3V3bXZk?=
 =?utf-8?B?NXpoeUtZVEYzZnE1bnpZeFlrNVJPS1I3SEhFaDVweklYQ3dibGVFSDE1QXl3?=
 =?utf-8?B?aXByL29Uc3p3V0JUYnlaRUpHK3lKaHFvK3RqZlJDZ2ZZNXYxOVlRYy9pZEtB?=
 =?utf-8?B?N3d6aEVvUVlwOHIrcTNHczlHYURCUlVsd0psL0EwZ2hOL3ZidENydTg0QnB4?=
 =?utf-8?B?dXBFN283cklvb1FrVXg1N0ZkdVNOVzBka1FYcmF5N2IyUHZKREVLRkFaRGxO?=
 =?utf-8?B?b2hoc3ZRK3U2MDVVOW5WaEQwZmpLaEVnelplM1c4ZGdVOS9OWklZZXlOL2ln?=
 =?utf-8?B?UkJ1ZzNLbDlnQ1krUUVGTzFzTWNhbmpQSDRvdXAxeGJlbWhKMzJsc1o5UEpD?=
 =?utf-8?B?ZTVIQ0taTmdpc250V1l3NHZDZTdKZ2dvTDFZdXdGTzQvY0RwU3JVYXRNZkg1?=
 =?utf-8?Q?SNmB3cJotfOkeQbqZ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d91980c-9b8a-4c05-bc16-08df2b110d0f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:07:14.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/fwGJW6UklGfy3I0OE/FSl2trWuiaXr4DUdROib0KggAtdI1otMletxoozWOyaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

Hi Reinette,

On 10/15/26 09:22, Reinette Chatre wrote:
> Hi Babu,
> 
> nit: subject claims multiple "definitions" while only adding one #define.
Will change it to:

x86/resctrl: Add PLZA configuration register and data structures


> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> Privilege Level Zero Association (PLZA) enables the kernel to switch to
>> a different CLOSID and/or RMID than those used in user mode when entering
>> kernel mode. CLOSID and RMID selection are independent and can be
>> configured separately.
> 
> That CLOSID and RMID are independent on x86 is clear to me. That they can be
> configured separately is not clear to me in this context. What does this
> "separate configuration" refer to? Looking at the later patches kernel
> mode allocation and monitoring associations are always configured together
> and written to same MSR at the same time?


Good point. Its confusing.  What I meant is that allocation (CLOSID) and 
monitoring (RMID) associations are independent PLZA features and can be 
enabled independently in hardware. For example, a platform may enable 
kernel mode CLOSID association without enabling kernel mode RMID 
association, or vice versa.

Yes. The kernel interface configures both together because they are 
carried in the same IA32_PQR_ASSOC MSR update.

How about?

Privilege Level Zero Association (PLZA) enables the kernel to use a 
different CLOSID and/or RMID in kernel mode than in user mode. 
Allocation (CLOSID) and monitoring (RMID) associations are independent 
PLZA features and may be enabled independently by hardware.

> 
>>
>> PLZA associations are programmed on a per-CPU basis through
>> MSR_IA32_PQR_PLZA_ASSOC (0xc00003fc), which contains the kernel RMID and
>> CLOSID values along with their corresponding enable bits.
>>
>> Make the register and its field layout available so kernel mode allocation
>> and monitoring associations can be configured independently.
> 
> Could you please also elaborate what "configured independently" refers to?
> At this point it specifically refers to kernel mode and from what I understand
> kernel mode of allocation and monitoring are configured together.

Yea. it is not clear. Let me change. Remove the text "independently"(Its 
already in the earlier text).

Make the register and its field layout available so kernel mode 
allocation and monitoring associations can be configured.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   arch/x86/include/asm/msr-index.h       |  1 +
>>   arch/x86/kernel/cpu/resctrl/internal.h | 49 ++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 82ca6356dc62..1331291f7a36 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1304,6 +1304,7 @@
>>   /* - AMD: */
>>   #define MSR_IA32_MBA_BW_BASE		0xc0000200
>>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>> +#define MSR_IA32_PQR_PLZA_ASSOC		0xc00003fc
>>   #define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
>>   #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index e3cfa0c10e92..44ecde20b1b4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -222,6 +222,55 @@ union l3_qos_abmc_cfg {
>>   	unsigned long full;
>>   };
>>   
>> +/*
>> + * Privilege Level Zero Association (PLZA) is configured via
>> + * MSR_IA32_PQR_PLZA_ASSOC.
>> + *
>> + * @rmid		: RMID programmed for PLZA.
>> + * @reserved1		: Reserved.
>> + * @rmid_en		: Enable RMID for PLZA.
>> + * @closid		: CLOSID programmed for PLZA.
>> + * @reserved2		: Reserved.
>> + * @closid_en		: Enable CLOSID for PLZA.
>> + * @reserved3		: Reserved.
>> + * @plza_en		: Enable PLZA. When enabled, PLZA applies to the
>> + *			  given CPU.
>> + *
>> + * The MSR_IA32_PQR_PLZA_ASSOC must be programmed on every CPU in a QoS
>> + * domain. Each domain supports a single PLZA CLOSID and/or RMID
>> + * association, and all fields except @plza_en must be programmed
>> + * identically across the domain to ensure consistent behavior.
>> + *
>> + * CLOSID and RMID selections are controlled independently. When PLZA is
>> + * enabled (@plza_en = 1), CPL0 uses CLOSID and RMID values from
>> + * MSR_IA32_PQR_PLZA_ASSOC depending on the corresponding enable bits. When
>> + * PLZA is disabled (@plza_en = 0), the CLOSID and RMID are always taken
>> + * from MSR_IA32_PQR_ASSOC regardless of privilege level.
>> + *
>> + * - @rmid_en = 1: use the RMID from MSR_IA32_PQR_PLZA_ASSOC if @plza_en = 1.
>> + * - @rmid_en = 0: use the RMID from MSR_IA32_PQR_ASSOC.
>> + * - @closid_en = 1: use the CLOSID from MSR_IA32_PQR_PLZA_ASSOC if @plza_en = 1.
>> + * - @closid_en = 0: use the CLOSID from MSR_IA32_PQR_ASSOC.
>> + *
>> + * This allows PLZA to override only RMID, only CLOSID, or both. If both
>> + * rmid_en and closid_en are clear, the effective behavior is the same as
> 
> nit: rmid_en -> @rmid_en, closid_en -> @closid_en

Sure.

Thanks
Babu
