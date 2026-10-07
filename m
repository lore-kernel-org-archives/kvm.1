Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34368345EA3;
	Wed,  7 Oct 2026 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416881; cv=fail; b=BQb+jqcO2bJQewz9pIITn70qy4ojMWWiqkJkiAEIxL9L581ti1ajVDvo/89iM165UhWf7HkA2C0jRgwb0KY60ywKe8hvjB4Uv9gm5eynuc1Qe5A+V0GGmH3B+W/qLGRDczSTp0yzs4T/IHfz/fTVBuvDL2hYiSCpi9Axtewrl2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416881; c=relaxed/simple;
	bh=CthJymEjpCX3k5Y6JWAbZHT8mfhd9NbryIwVurIv2Xk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cu/8djWWsP/dPfY074yrz/lsEXH8rz9cUdr0h4fOuWjPmDYsR65WvT5vBMzqX3jtKbPhC5vERQzRT+7wXY/0IieYmuttl+cGYCe1s42AhSXb+jFEHg3WSflio3v4xfRbLRApETieH4OaFsVFD8yeOM9SHc6J8CVDyotWdABORJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LHKqgYg3; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LHKqgYg3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEiUt5DfPLiGuj6+EWHSDzIJoyUGmf5NbRrtb+OyFKeW0YRDoyia6NUeGkyOGmyQcO4YwMTmmCUlYG2ngnFR9gzt3bz//B7LTUmj4M2X3C0/SqDw5Tgc36O+zRn/5LxWxIyoKpBGxbvuHjFdW9cVzF47/X89S/hqxdqsVsMYKX4ZRu4lJ9t1nJZyjOtAB0mNPL7p9tZLZCSvWo3Wh89gEH2wkRalC68E9w1NGtpoJnRbkoKtbb0PmFjb4T9MKtqSXrLdGeUqmnc9K2uozU9fvXHSwTAGP4Wzw2nBNG5c+LmQawZYCySoMrYX1WUioOM33zpXUsi+iJWlsQjvr0ENig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQc+/0F0x7Umts5o3UhfdLdofu7ULNJf/hfEOqmL0IA=;
 b=W7zYxJ15028ynXobuTp8AGRZkl/i2znneYaSyMCINNiCU3h9bH4ChXMURqD0O5YLhcUnRcvXrKRFXGlyvA1iihd5GwuDZMf2RnXHsqL8JiTWQJWsyr8rE341vyBKHkBtLF5RPQWGYOvsAJxuSwkktldgZHmx/lkOmCv0EHoosOoiooiFEVn/7Pv2T0PtjNTmGvlgh2IVXMI5cxTUQm4dCEQ7azHdPJ/22RH5YpykSgOkA/taYErfa7N73I4NDkudqFLcd0HW9WXdPxK1qHgn2hOSndU01UL2kv2X4beVAAOXaaEdJandYZEO2H2wKgU4jaSdkDVXOWmUWteZvV9X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQc+/0F0x7Umts5o3UhfdLdofu7ULNJf/hfEOqmL0IA=;
 b=LHKqgYg3FFeVwq6Vyc3+8mhpSyJBBGBW49iXOvpTdi/ROLcb/ptYWxDsRiPykAluczOK0FAvXwEwOcLZeQCG1i8RSJkcBUyVFk1Iun3Oo0McEDuVshrxXtS4fQIyIJkLXNWs/chJQh6WYMqSRy5gOTky8FrBMpN1PkAvVhLuJzs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 23:47:55 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 23:47:54 +0000
Message-ID: <8bd1c37e-df79-4c3d-8fad-cfa9443239b2@amd.com>
Date: Wed, 7 Oct 2026 18:47:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1790976400.git.babu.moger@amd.com>
 <b969687be3162715e10242424b5a489857d67f2a.1790976400.git.babu.moger@amd.com>
 <200d21ee-3041-40f2-9032-18e8544a7030@intel.com>
 <c2ca9eec-57f2-41b2-b8fa-4ed193b5b2dc@amd.com>
 <a76ccccb-7070-43aa-8bf6-1db8091824ed@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a76ccccb-7070-43aa-8bf6-1db8091824ed@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::9) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dfc9b0-63ea-4cdd-48ca-08df24cd67e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hmneDCFuZN9QmPrnSLyyexa7JVnaF+JFBr19bW/e5OBB7z2vlQs0Z3AK8ERbwRTs6MBeip0+GWiD2SHf+rz+iZJOuk7GziOK9aN00Ktwntkyao5XY0XU7NpL/5lwmeb5t3yZa0QGRSr/nPn6oUNo2Y/8Yrss9j2sZOh86yguwBygHHSz5shxUwdfI00rawnigDKZ99NtNj234jAVAxULCIQ6PouBpu4nugWaorgm+hGDn//WtJESD4U1fSjstTDaC3Y1+qNg1XiqSgFdgpzgcgQARqk/FlnXX7gabVzUdayDvir7x/0lgeUIHCHrTFz1mVxMATFOjNqyefSA++NImy1GlUAPVCFff/o9IfSnQ5c3gFGZkAKG5GzJ6MhPN4hFWZF7H1R9oBCN3IL2VrdGcjnbi3oL3OHnRP7nFuTrssEDi9l9dWB+GLtuvVgRcUfcyUOlk3BjpDTl9ltmcMDSsiiKNlVB4eofb0c06OABpRYB/QFpIGEoaZTXnE9NJb5YChzaGE7CbJWaUewQPwRIP1FjUbWEvfEliJkhDU2K0sLwyDa85bxwnzJIXfCPHZ8+BV1lqMT2v1UBuLQz/yo0IwvYvuE3yLX/XlieRn6DcaiGcpSQQKfDpBIDhB4bMA0Nr/210oni+lcqhfFX/mMnD8OtAQHN7s7z5mk2CzYOYww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWI2TmZQLzF6aTdQRFNBZDlmUmxYSjZrOWJ3SnIyenhIb2h0SkptaW96YjND?=
 =?utf-8?B?Y0I1RXlXUjFwQmQveUllYkhXQUxZK2NESVFtTmY2SllaZzBULy9jaFpRWkdY?=
 =?utf-8?B?RE1MaGc1QnVlNXMveXBncXRSRk5xK29FVnVwQVBmUDk3bEFGMXpZRHhXckpy?=
 =?utf-8?B?L2xJb0V3bnEwNWs1TnZmYlR6NitIZ1JPcENnN1ZGNG9Bc2E1ekUrQWlTVSsv?=
 =?utf-8?B?UUFCeVhPK3B1VHYxWGxTWUYrckFtc29rS0lXQjc3WC9ZSnNzbE44d3Rvbnly?=
 =?utf-8?B?UHBRVXNNU1E2djd1VnF4RmMvWVo4bWtHM2RKQUdzSkdkL0NBZnYxV01OTTJI?=
 =?utf-8?B?aWhCTk5taWdicnArbmVmWjRvUXVTaE81MTl2c0pkcWF6aXdtTFJHYzZ4S3Bn?=
 =?utf-8?B?NW9lbmVkVnIybGV1OHBrVWxOODlLbWpIS1ZlT0g0U3p1MFdvRG43enlSUXhH?=
 =?utf-8?B?ZjBBbUtwa2lXcVQwU3dUY1BYYTRDUnhDSnVuZmd6SFZpTEhYd1dyVEZGbzlp?=
 =?utf-8?B?cWFmQzV6SzhCYUFsYWQxclhIWFRoNVpJTHpKaHZlSWc2NGFYTlhMRkliRm45?=
 =?utf-8?B?bUNxV0JWWTdRTWpyTzFYU1B6dFo2bXV5a2Q2ZVd6YldwRDA4L09aVlU4dVlm?=
 =?utf-8?B?ZlNaR2xkaDV4Q0RTOStmV1oxWnlDTTNDd2YzYXlFcE1oSXkreWNocTZCR0wr?=
 =?utf-8?B?MjRGVVhDNkxrSW9Xd1BNdVI4QnZSZGZ5Rm9GeUVUZGp6cGFBWWpwaE9hRVAw?=
 =?utf-8?B?L0ZMa3dFN1BTWGhmdzdXZ3J0YktiL0N5alZNVUF6cnBOT2toaXNkN2xuQnkz?=
 =?utf-8?B?bXNoZnNiaXhFSXpSdklSY1NWSmxkZGhYbS8rbERGUGZVaDh2OXNhV1pVMFJ1?=
 =?utf-8?B?VW8wSlZGekhoREl0RDI3aWMvMzBkeGVteFZHVjhRU0I3QjB0dEdCdzlRUHEx?=
 =?utf-8?B?ZVlNSk8zdkpQZEVKQWxZWHBPM2JQU2JPYzRKK2gyeE9yd2wxdmZQT2s5bkpY?=
 =?utf-8?B?RTFJR0ZUeTduZGtVcUtURlRvc3NmTUJnRFROUytMKzljam11Tnd1TEN3WnJB?=
 =?utf-8?B?Q2p4Z0FBTE9mZXRtMVBONkIyMHZvRHpIenVvQjRwNW14S1A4b3VsV2RlaDZ3?=
 =?utf-8?B?cUkwVUNKTTBGVXRNTStSL2tLSlJ6WUNWS1FFNUpvaHN3bDJqQmUrMnRjdjRW?=
 =?utf-8?B?ZGRoS1Q0ZjBwMnU1N3htclJYVDNEaDhra0wwQkk3Q2RqK3RlY3V4VHRZR09S?=
 =?utf-8?B?azM2RmVwZ1NiR2E2VTZ1cUQxRmhuUWU1U0N3dmFUQTJ0SVg4SithZkptMDBy?=
 =?utf-8?B?dGtWclZMS0o3eVZzMlBYdFg2aDZxbHgwQ0ZrSUcyNFFlYjI2OUxJbWFlTEtQ?=
 =?utf-8?B?UVRERHFXSUdxVlVBSUZ2RjI4VmwvcW51eHBlZlZBWW9oUnNkSGNodHl1VlI5?=
 =?utf-8?B?QTBnWmxUbzErKzh5WlJody81K0V4TDI0M0xsNmUrc0c5VzRYUXpXQkMyWGpJ?=
 =?utf-8?B?VnhPbFZhNzc5MEVSY1I1Y1RLcXl3ZmxzTlAwSndCQ1hMTGo3bWMyR1Z5MklL?=
 =?utf-8?B?Qll0RkkvaGIwS2ZGYnVBY1hreklEbWxMTERGMGdZY0pIa0dNR1l1aFp2c3FZ?=
 =?utf-8?B?VlJYSkpocEZNdlJDU2IyNkFxbHFBUFlXZE5YSGlVVEdHSWh5RitnM0dZUnFy?=
 =?utf-8?B?Z0dSK091ME5MQ1dDeHJqM0JTT1VWaFM2bm5jUFBtd2FlSERZRDdyaVcxQmJS?=
 =?utf-8?B?eEpCdDRQSm5DcE9pZE41UjhEMFVxL2xib1duUW96R3dGZ1JSY1ViQ3NGMmxm?=
 =?utf-8?B?VytueVFGRE9helJ6VW8vRUFnWEhPT1B3SjNQcVJxSFlZQUsxb0w3cjAzK2Vs?=
 =?utf-8?B?L09PWklQS0lXc1cxVmJMemp4OHMwVFJhNUpUdnVFcmp4Mm9TNnljclNHRHp5?=
 =?utf-8?B?c0J5NjJaSnpORHRqZVpyMUp2azlCTkx1RXh0NjNsaVE1MXNFUGhzd0RGYkFt?=
 =?utf-8?B?Mk9rU3A4MmxJN3M4d1VNNzVTdk1Wc2t5aU9KTWt4MVRmdjVHS0RyRUNMbGMv?=
 =?utf-8?B?VE9RelpMNHVMVWxVOFU1V09lK3VvUk8rb0tWVzArcnJLc0g1VDhkaktaSnd0?=
 =?utf-8?B?UkdMV3dxNEFLczBzenBrR1I2dEs0Qmk0cHZZaU54dUpleE9GWmN2alBsZWNV?=
 =?utf-8?B?VXA0WjdhRHNUbVVNSDI4Z2FIYkdvVU81LzlIUnhMalZHT0VER3JZekR6MGJL?=
 =?utf-8?B?WmJvOExZcEpUVXpPMytIcmxnS1BsVzNSekxzREswVnZxY3BrM2oxK2l1ZGtB?=
 =?utf-8?Q?oFPNRgM26RG4UIQ3Co?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dfc9b0-63ea-4cdd-48ca-08df24cd67e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 23:47:54.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stnD3LGBZ1QAyp4h/sxnH/+DBZVRXLuQcytnaTMWdX+Trf/59s3T90+IlIz5Th5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

Hi Reinette,

On 10/7/2026 5:21 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/7/26 11:54 AM, Babu Moger wrote:
>> On 10/6/26 12:53, Reinette Chatre wrote:
>>> On 10/2/26 2:26 PM, Babu Moger wrote:
> ...
>>>> workflows that monitor a subset of groups at a time and rotate
>>>> assignments as needed.
>>>>
>>>> resctrl enables the "mbm_event" mode by default on hardware that
>>>> supports it. That breaks the pqos tool [1], which assumes the historical
>>>> default mode. pqos treats a non-numeric event read as zero bandwidth. It
>>>> creates 16 or more monitoring groups and uses two counters per group.
>>>> On a platform with 32 counters per domain, that consumes the pool, so
>>>> further groups read "Unassigned" and pqos reports 0 MB/s for them:
>>>>
>>>>     $sudo pqos -m all:0-4
>>>>     CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>>>        0        0.69         16k       192.0         0.0         0.0
>>>>        1        0.40          3k         0.0         0.0         0.0
>>>>        2        0.44          1k        64.0         0.0         0.0
>>>>        3        0.39          1k        64.0         0.0         0.0
>>>>        4        0.43          1k         0.0         0.0         0.0
>>>>
>>>> Leave mbm_assign_mode in "default" mode during initialization. Default
>>>> mode uses one counter per monitoring group. On existing AMD platforms
>>>> that pool is 64 counters and may be larger on newer hardware. The
>>>> "mbm_event" mode uses two counters per group, so 32 counters cover only
>>>> 16 groups.
>>>>
>>>> Deployments within that pool receive accurate bandwidth measurements
>>>> with default mode. The hardware supports 4096 monitoring groups. Beyond
>>>> that pool, readings may be misleading or "Unavailable", with no
>>>
>>> At this point I am lost because the word "pool" is used to mean three
>>> different things. It is used for the number of "ABMC counters" as well
>>> as the number of "non-ABMC counters" that exist on the same platform,
>>> above it seems to be used for number of RMIDs (number of monitoring
>>> groups) also. Could you please add some context at beginning of
>>> changelog to introduce the various counts applicable to the description,
>>> associate unique terms to these counts at that time, and then use
>>> those unique terms in the rest of the changelog?
>>
>> Sure.
>> I can name as "ABMC counters pool" and "default active counters pool"
> 
> hmmm ... "active counter" is new term that, when grepping this series,
> fs/resctrl/*, and arch/x86/kernel/cpu/resctrl/*, does not appear a single
> time.
> If this new term is needed then please include a definition as part of the
> changelog context that makes it obvious what it refers to.
> 

Sure. Will do.
Thanks
Babu
