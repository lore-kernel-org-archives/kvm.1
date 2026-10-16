Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA81385503;
	Fri, 16 Oct 2026 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164489; cv=fail; b=SM43fUAJGGPylYN54WTuGud0RAuDSUPvI5bRtOKIwzbDm8CbsH8MGV2fHNHSNGKHoSdExvQ0GmVmdeIgVh9XngaCIxc42Oyr7n2552sGqvNwRXSvIE7pI88K+Y/eb0Be2iis9P/hQUgkeJZock9RLmlpGgz+pVGfQoGOLYVSwCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164489; c=relaxed/simple;
	bh=Qnh2ek9frZBr4WHMshrJsbIWR7j9C/kCw3O/0ygJYag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+wseY+fnXpNm9fTdhRubKyekuGxLVr4PXtRvaH3G2IqgGWbbjesPoMWFbqK1K+KOlLStRtKvcdHGq6/5ZRH6NCcFMnEhqnJu9RlN+i5k+/ZQrHZCHC9eLI560+6QbPMD1h2tbRy+zv6bG30JOkmD3YRWf7XJ5K/gOoD0+Pyc8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a5BN4DDY; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a5BN4DDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpL+/kOM9dJN1sShF99nNgdudwojfRSjLkr3GxtcD/6IV/oZau9eEpAb5YsxbsCreHKNbnv0qSCeVxUvGRQFxjrqvd7AADfGeS0jPsN+LRZGP6KJaUYbJsvGAuxzBNnGfdy+ourhOZDPlixRo4b45H1EjGiJ4ZZp+KXwDl1Rn6MFrSNMd+RfOLWess/IMP1x/wHJ0vIPZSCrlfYsoMIXCPC2HcMz5roZ7B35k1K3618/Tzr4kxTEEZKbxSbxo5DZCRjmzp9GcRcL/+U27ul8gBqAvG+U02Dme4CZASJl+aKMA51NewXe48AlLaWNeo6pA3ghCh/urQdafj0HL/oUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip+kk13ECM3ix5X+ciy55F752z0fxd2ninxsftojlwc=;
 b=TFdhIQPo/3ofjCabHgZ5Xx30jcKrZD2tg+q5PAQ87w5iJz5909p8QUwiD67i+eWPtf6lAeCKvsMACLPcOcZe0htpf9dCCBLwWiHbon0huFM8szOUdzQMkWOtIBR1RzrO6JsLBVn3IeuAskcVyyNLkkpTZv+40tuiP2vPObNUQp+QsWGAf2NxYF8VzazZrsKpzVHGgENJMZUaKNG2UYFyh/u7Qsv1+zc5ONmD00vXxPnzeI7iBaCGm1xGdsTi9paWio536PiIQ3VeawMx4DVug+ceMCGb7eKQloxmsccT74B7SzTqXYDCTiunFztKZdIyL8C2FrujjlXLkd29SymyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip+kk13ECM3ix5X+ciy55F752z0fxd2ninxsftojlwc=;
 b=a5BN4DDYdYlmEhZEKFYdaYbKyauCXs5thoLmREU1v68RC7QLQ/KOkHDt0d4gSJQBPkvyPsYIgt/BryapiDbUnNnh5MbKV2bFNyHo7yGydNtDJvQctgk0tbjvK6K8K+0sg/oBigCn/+2zIXYosKPg8M6T00b8+j3mexgYcoPeXnc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 15:28:00 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:28:00 +0000
Message-ID: <e2bff854-eda3-46c1-9ecc-c1aab1e7b33e@amd.com>
Date: Fri, 16 Oct 2026 10:27:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/18] fs/resctrl: Introduce
 resctrl_set_kmode_support() to register supported modes
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
 <50333925a56037a0ea82c49f25e76be6271d299a.1790867441.git.babu.moger@amd.com>
 <0b633c57-2938-42c9-a6ed-863d88d2be63@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0b633c57-2938-42c9-a6ed-863d88d2be63@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0105.namprd15.prod.outlook.com
 (2603:10b6:930:7::13) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3c033a-2ef6-4161-7fe1-08df2b9a100b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|6133799003|18002099003|10067099003|22082099003|11063799006|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WNjYMs++Ba9jXkIaKzgHdkcm3Z24qMm+mwlDnMZXxkelkDkwC9ZHsUsevD5Vjy0BmqrueobtHawDaa3HvQpVV70A7a6ZBF3P4xxFkejwrvR4MOt/vhYn10pKvQil9Phse6xJws56ZOt1sXyL2NeOVd/9HVM3fl495spi+QfmEw4SD9Tx9Ti01Ebg1k5EmJVYZybUq+q9oXDwbu0uu9oZ6tZLL/A1dnVzWkgSyy1VtO9vVV5F45OqKRGxQ7cth7yADJw0XltvFh50q0F6Rs7WjJcLIHTLZcYjQv1fARIrA9o14YaE2sig0VPjgqlXufxDtrw0gAIbvk/W675yW7KPljgnPeX8p7FZmLDQzz5mEYARoqcHnSqPxB14Q+zATqJH8HmziwTzVKwjJpHtfoLA7qIcxuvG1fkTG3elYWgSdb5Zv0kF9zLq7VFrA/Tlm0Y1NL+/3QjPJiHE5yn/M+WHyQv6pOLMoOoqhXF+B0rRehul5JxZZAFv4RZRcoQ2YHENUsxRysuiGDcmkTkRhUolpaHAzhsvFPxxdUz0t+lJnLjL2o5WiALRc/s4i1OCx76XLcQPm0Mr8zUA389VfilG87+D3zbcfuj+e9RDzSxitF8JLvH3gzx+lvZO27XhaEhbZOMXKVEGgcpVWjg9wILlp5F2U2cLfaMlEvnNw+/VTlo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(5023799004)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVZqY2Q0L1Q0L3E1dmtFVFpRYmpLY3JoeE1WM2NpQnN1eFlGeXNwS3BLam9U?=
 =?utf-8?B?OHBVOURqbjRMRnhNWFBpSHpHRFVCSTFMMzhYMjdscjFHbU02M2JHODRhZ01Y?=
 =?utf-8?B?cEFwU0hPSXIvZjhqSXMzRUFteWdOcDFZV3c3cjlLYmRBZlFsQ2tZeGUvREsv?=
 =?utf-8?B?SWd2MnVrNkRVWlZydWJPZmVyQlNsQXlGTVlkQjJpM1VOWnFoOVBOa2NvM3Zu?=
 =?utf-8?B?dUtpcDJ3SmQ2RjE0djJFWUV0NUthblNpRloyTzExbS9rbk9KMWFaYnYwSW81?=
 =?utf-8?B?S2VZY0FyQml0UCtKL0lSY0hJeUp5OGdXbGdqS3U0TVQxQU5xU1FMZHJQSUJm?=
 =?utf-8?B?dDFBdW5mbXhiWDdlcnJpRFJueThIZFp1bGExVDgwYnhnWXJudURiNFk2VlNN?=
 =?utf-8?B?dHdlZDZBNFRNSUtXbGIzalk5U2dMbFFHY0h3dWUwb0M3ZUhBMkN6NjFhSGh3?=
 =?utf-8?B?dFR3WjRwN3FtSlV1YzhYcUNUMEVQN0FMSHFwVlRvNzBVUUVUaDRsYlpNWCtS?=
 =?utf-8?B?L3RDWlhVVkhodSs0aFJidEI5TElWcUljVHpFdDQ4SlpNVTlKdmFCWit6UjAz?=
 =?utf-8?B?dUdzQnRhQXorNjJEN3pvcTduVUJCU09zSStoOUVIb21vUlNlQitCb2wwU040?=
 =?utf-8?B?aUt5RTB4YVFRTmJJeWsxUkxmSWlLNk1OK0hsdDRBRWpTOGdVQThLZHZrYmgy?=
 =?utf-8?B?OTQ1bUxoTUhKQzhLamU3dFVjdG80TzFxY0pOV2h2QU1OT2FudkN2NHo3a3pM?=
 =?utf-8?B?UDRkNkw3MzBFS1ZmZFRacCtPMSthN3d2ako4UG8rU1JucXI0aEw1d2VqaERh?=
 =?utf-8?B?aXU1ZjdoSzUrZzdXUEp4WllkMmNpa3dTYTYvZWFnZzJjNUF5aEcxNjRPWHNZ?=
 =?utf-8?B?cE95YXFSVnFWeUZ3MUJrS2g0WmRla3pOR1EvM0pBam9ubDd3TzdoakRzQkZp?=
 =?utf-8?B?RmlFdzV2WHo0V1pYZzM0NmRPVmVYSnJzaXZyZEU3bThwZi9tL0VBZlc1Z3Jt?=
 =?utf-8?B?WTBaTlE1VUl6OEN4MjRxZG1SWGRDWmxWVTB2V2w3SUdLN0RoQTZNMVh3bTNL?=
 =?utf-8?B?bXFYZTFDeTlDYVZPaWsydTl5eWJrRGNFR2Vpa08xNFJQZ2dqcHZ0L0xNb0Q1?=
 =?utf-8?B?Z0c4dDl6YXpIM21kVUJ6ekl5QWw2a2cvN0p6VDRXdUplV0VsWTJSb1RCZWsx?=
 =?utf-8?B?LzVWOUhKT2czTkxhT3Y3ZnNRdUZsR3k4SnNXMnNPdjZFNEtmSnRFck1DcWgx?=
 =?utf-8?B?b1cwOTJ0SFBBN015Wk92MXJ5cTVYU3M2YlZwbnpBMEE2V21xMVE5Y0tBZjFx?=
 =?utf-8?B?eGZXOGFETyttcHZGSzR5blFzZk92L2NWc2lSUmFKK3dZRUo4MzNwN3RxWXcv?=
 =?utf-8?B?eThnQ2NRYjE0dW8vOHc2Y2dIb1BpZHFEZUo4Ry9XZ3hnT1hWcngzcFQ4bUZ5?=
 =?utf-8?B?d1pIRm1yMUxyaEE0MEVlckpEakJxRjdSMmo5L3JZVjROZzc0dVZwQ0xubUI0?=
 =?utf-8?B?ZzRIeTdVaEVZVFRSZjY4WTZFSU1kTGFVNWxCU3NJRis0VWN4YmFDTytPV2lI?=
 =?utf-8?B?WncrYWJTVUxuK0tTRW5BMlloL0xOZ3hsQlBRdHpJVy9lR2F4NnhXZjJhZmYr?=
 =?utf-8?B?WGFjaHZleTBXZFc5L3NQdFhQenAwQU9sS0FaRmg5eW82b3JaUUpGVWoxRjhS?=
 =?utf-8?B?bGlxRmpTaXZjTWNrTTI5QXNObit4ZU52eXVGUHh1cTBkbklDWDc5UmZxL3FJ?=
 =?utf-8?B?eWJUOWdCTmtna3dMQjYxSnZKVmRObEprRVhuVHkzNzR6SDhWdUJwUEFjUnpY?=
 =?utf-8?B?M3FOWC9CbnFyOGpCWlErQW5xWFpISUpjNEtBSTkyVWFGYnhja1pRYVhHNjA0?=
 =?utf-8?B?Mk9MNi94VlE4OGxSVXhsNVVTZGlHL2JIVkhtc0pSaFpQRVZuTmo2L0E4Y2lB?=
 =?utf-8?B?bGkwMFVvWThZRVFyMXBCamM2Y0djT05UTkJRNVBqd2tiNThCelhVZ0ROeklK?=
 =?utf-8?B?Z2tjbEZSeis1ais1MWM1NElUZ3NQeW5JVGNvK3NBNFBjRzc1aTJxNXgwSUVu?=
 =?utf-8?B?dVIzQlcvVGF2dEJ6THVaYkhZc0Q5aHMwTnpXWXNheExJTUJyYlBqTmw2NDN0?=
 =?utf-8?B?aFhYVXZQL3pnNDhmUklHRGozQkIwSE9iMjB3ZUVJUXZYM1RZV3R6dW9nMFhv?=
 =?utf-8?B?eThNWFl5bGw4TFNLY0NUOHFhaWJ4eDV4M3lpYlV4bENyQm0yWmxTTVJRSk4v?=
 =?utf-8?B?WERVdlZxc2F0SkxtMEQrM0pUOWxOQ0JmUlV4cWd1SHBKV3h6cVgrWW8remxF?=
 =?utf-8?Q?Y315Oz3XMvDZD9+7KF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3c033a-2ef6-4161-7fe1-08df2b9a100b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:28:00.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLf/K240RxnfoM1ibgSl9s9AumYdM+N/3lFlhkuroElRTILwG3/ong7W58k3OOGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649

Hi Reinette,

On 10/15/2026 9:40 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> The resctrl subsystem tracks kernel mode configuration. Architectures need
> 
> resctrl tracks nothing at this point. This is preparatory work to enable resctrl
> to do so.

Yes. That is correct. Hope this looks ok.

Architectures may support different kernel modes that need to be
exposed to resctrl.

Add resctrl_set_kmode_support() to allow an architecture to register
its supported kernel modes. This is preparatory infrastructure for
future kernel mode support in resctrl.



> 
>> to register the supported kernel modes.
>>
>> Add resctrl_set_kmode_support() so an architecture can register supported
>> kernel modes.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   fs/resctrl/rdtgroup.c   |  6 ++++++
>>   include/linux/resctrl.h | 15 +++++++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 7c39792be1fa..75b81d07a247 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -2320,6 +2320,12 @@ static void resctrl_kmode_init(void)
>>   	resctrl_kmode.mon = KMODE_ASSIGN;
>>   }
>>   
>> +void resctrl_set_kmode_support(enum resctrl_kernel_mode kmode)
>> +{
>> +	if (kmode < RESCTRL_NUM_KERNEL_MODES)
>> +		__set_bit(kmode, resctrl_kmode.kmode_sup);
>> +}
>> +
>>   void resctrl_file_fflags_init(const char *config, unsigned long fflags)
>>   {
>>   	struct rftype *rft;
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index dcb0beb847b6..5553f6301bd4 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -752,6 +752,21 @@ enum resctrl_kernel_mode {
>>   
>>   #define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
>>   
>> +/**
>> + * resctrl_set_kmode_support() - Register a supported kernel mode
>> + * @kmode:	Kernel mode supported by the architecture.
>> + *
>> + * RESCTRL_INHERIT_USER is registered by resctrl_kmode_init() and does
>> + * not need to be registered again.
>> + *
>> + * Architectures use this interface during resctrl initialization to
>> + * advertise supported kernel modes. Registration of a mode indicates
>> + * architectural support only. The final decision to expose and enable
>> + * a mode is made by resctrl based on system capabilities and
>> + * configuration.
> 
> The last sentence is not clear to me. There is no filtering of any modes
> before it is exposed to user space. It is the architecture that sets the
> modes based on the "system capabilities", this is not something the filesystem
> decides?

Yes. Will remove last two lines.
Thanks
Babu
