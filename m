Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792424878;
	b=C0ZXftxEospjxh/8eqU0woq/QQ7GjmnYks+dEWXHNrqA2pxDxRqgJTakSxUl2UDyyXA+
	 APTJSR8mnlw7zBgo4nZh7iLbtW6jcjfolYqhOHh+bNUjXrpWnM29CSD8NPrmzOY8g6PP5
	 iwyS9KRq3oag9A9xTkNCM2Jn+vBh0RcafG6cbqQG5YQPBa+zNV9QiGoMJ+TWXBuuh69YH
	 i4Mvrbf4RINiDb9bY9dqiBB4dcsBHRL71wxuJtnToPgbEO6Bgpkfxb8cznrLLePudyhTj
	 xa5ydq3je5In/WU7fwsPm+WLl99ZMT1vAe3Uzf7sedrNtApzpefn62lPrYQkbtsuzBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424878;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8PGE3p0sonSO4wIR8xXkFH5hBIV11o+vX3deO4y8bgM=;
	b=JI2VFgmoMCEJvqoXOzrcgEgw4g4ZjuvRroMCHAR39YinML8X0N+N8/7bb3rGKz/dg/GY
	 gE6rY1CDq97AWfMFf0XOY4FBiGTVYzC0Rw0rjLxe3+l9GiiLsP08ca15tRA9k5ure3kIL
	 tLlX/H5r6W8rW4zlBNDPrgCl7HRHo6h59Ijw7IyLeW+hHcgqzSPzHWXNpMg2DbZgqB56u
	 p6FhA7H5xGsDrk6tY0s0/9DKeaf2lPsnVQhsv6+8oMfTs17q0COyb2MpI0BOF4l+fzonW
	 FJmkSfnbLtepm318ojiY6fSfkMvn3JPE58Ok4utJ6C7Zlc6rXalt6m/CTRldI+JUhgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VkOqPnoD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3966083432;
	Mon, 19 Oct 2026 15:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F3966083432
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VkOqPnoD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaM3bU4wvWSl1+NcC3nwRZN2lRAWiFnva3oOJC3VmzQswy0ImUEZQ/cAc9mQg6Wu8xoIvyzHiqe5HrS606ms7WDp0bK9XAGn6gpxei17J30GSVJaWik7FX1NJm4NcCCKJh9aiOeTfwRX/HA0GYy/HClPQEQXeKAAAPTwtlObPcnKUOYDQUh2DfwmJNDRiVWNSP24V7Mgi89/PNwM8z5rPUp7LvWX5gsuSIQ9xSXaklOqD61vW2rlJAX8Byraj86yzblLHdpG2b37b49IeaHBBNYo5QvdwnPI9sFsZ8otxX1x9Q0r+rwfRlKUCkie0KJ9Q0tZFmdMWR1e40YCH2VYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PGE3p0sonSO4wIR8xXkFH5hBIV11o+vX3deO4y8bgM=;
 b=WWb68Sw7bJYmnByW7BqWecMUrbaWJjyAr2ZvYmKuyOio1KoihEcNuAVdfx4HknmuuU+7ag39Nqtkdm8un5SrULD4n3BRqJMTQlndZWBhrLbIcgQjfUVWrt1ZARIUkHfkU+kK14CJ3rEN943/lKELlr/1lU+TdIAOojelmo5wfoSznK310fms4zocM3pCfITyUEmCJyhlCTyszUJASAZRBVcM4E5ehsj2yugtKk9fTBMB2bKTyXeqH/1qBEW+WzWF7YSHjJIh7Vjv3jKV8GalZSl1z8JM+jy9n060FJ1+M4XknR04rZygZnGZ43pBYS6/jbr6WWdqkQByEKxigxS5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PGE3p0sonSO4wIR8xXkFH5hBIV11o+vX3deO4y8bgM=;
 b=VkOqPnoDTYoR/t6fjwRUyY1k549HkBekgT5IDYY/xryr9YKGZmbjCOg6IaTwYx56G73L8v4jzxWzaIEnAwL9HsuTKSzxVB1cUFdzf2HevC6vS4Zj9aUhOv5uZgeuJWSK9bJfqJEzBHaQCagEmiR104kOA3glsvFOaAO3L/QGITQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by AT6PR12MB932818.namprd12.prod.outlook.com (2603:10b6:170:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:47:52 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:47:52 +0000
Message-ID: <cabf7da5-e5ba-4a49-9edf-f801f344ded6@amd.com>
Date: Mon, 19 Oct 2026 10:47:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/18] fs/resctrl: Deactivate kernel mode associations
 when a group is removed
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
 <e9a2b05b2322acf51e16571d07bc7ee297613b3c.1790867441.git.babu.moger@amd.com>
 <08e1de88-cab0-4caa-87f2-94db0f698ba7@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <08e1de88-cab0-4caa-87f2-94db0f698ba7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:408:e6::20) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|AT6PR12MB932818:EE_
X-MS-Office365-Filtering-Correlation-Id: a29a1f73-f166-45c1-f41e-08df2df855d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XeqRYou1d5UzSj9rWJ8C6sn1G2womXCMPPuZI9J+aoW+m6CEfQLFNMSu51sljZME+rD1XJwwf0Luo82K0NoNSLS0+L1u9s9tp2oYyzQfNmJ2pXlW5WwtSdttootsQHbvUd4QcDetDAUsFKLDAkNdsaB5zEfhFWhT1O4lISTzRp16PBF0K+U1dEM0B4eXzHFadSZl4wtX84FuO7GLIAFTSxMqS6V6NKi6d7RAlCkhW1WLpPJFZqn+O05Ts4BkrqjrJAy0RyiN4hGNwkDpsIHVbAajKojXnlSU9c/EisnRjP5R3rpWfV7PlBUDTF6FT0ZPeYj9t1JM8gPWhEMtUDqciRsFR+2K7rp5KJB/MHMdtLdEV/gw97VRnZ5Cfx7XBr1CgJVfryLXtyhvpchaU+LdBU/OT7+e0vVaGCaNSjduemELbcZTpjwo4Fa6vNoaACHUhAndpZ3NWHXlQ7DO/o74yRiAVevnrYksz+/jZxIaM8Tz+0GO4qw2pZv5fxH8qEEFxh45hRAgZwvoA7o/jjLdU+oWQWWAQnU+DEzqP3xd8WBeJx+vzYNgDWs/gbhuz/oXWD585lR1cH7j9Mutt1+TcKKO24qa4Cc4VjLBU4HQlpqeF/nv+dWVqTy7GBse2nWMLVrdkR94yrchwnK3hTMxWiFcDzrQjegDV28YWca/uEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkJ0Sk9oRitYTGpQZ1dCb2JpbUxLN0VMZEx1SlIzeVB5Wmh4bDgrOHZqczQz?=
 =?utf-8?B?c3pPNm9CMEE1Z3Q3UDNvNGtTOStHbUx6TlFaMUR0VE1vZWs3SXlyKzgzUFZr?=
 =?utf-8?B?Y0x0UjFxNWZZWTMzQnVhak8xbEQrd2RrOS9rYUlhQzZJdVpFa200U3NLcGps?=
 =?utf-8?B?eEVtSTBIaThJOWRGdk1jb1p4UWt3RExyT3ZpSmdVUTJLWmh4a2pDUjJ3OUo1?=
 =?utf-8?B?REJVR0V5M3R5b2wra21SZ25oT1dhdWQ0SDlZd0djTG5XNWNPUStHdm9UN2Zu?=
 =?utf-8?B?RUFaclFCQ0o2eHIrb2dVMlhEVTQ0Nmh2QUh6cExueWFvNGx0T3JuV2xGQloy?=
 =?utf-8?B?VHJzdlRHdm1sTHkwbXcrODY0QTYrdSs3ZWtGdmY4WThSUzNIa3FjNUljMnVQ?=
 =?utf-8?B?V2dvRktMbDZtMUswRHI1aTVMMTU4L1hJNWh3ekhCMDNoQXprSVBSZVpBUEZq?=
 =?utf-8?B?cnZyVzdGVTgyQjZwTWdKMmtHNjhDSGRCMVl3ZHVvU3QzeXRUWjlEdXQ3Sndz?=
 =?utf-8?B?eGE2OWlVNG9FVi8vZ2JpelVNTjVLa3lNZWJ6ZGdVbnpxWTZBS29vcTllTzlS?=
 =?utf-8?B?UVpJMncrOVNTdTM2bGJaekJhVVpQZllQRnJ1dC8wL1NWRm9EMjM3Tk9DamtQ?=
 =?utf-8?B?aFBFeHZiYWR0WXNOTkI1UXFEVkw4VFl1ZHFhL28rb0xkN2FXMWJGRDRpcWsz?=
 =?utf-8?B?UkxsbThzZUpkd09XNitVNmVUOGJibkJsRFA3aUdoTm04ZjNrUDdZNzlUMTll?=
 =?utf-8?B?elBQV3N1aDBiSjcvQngwSzkwVGlJZDZBQmdQaWJjOUxZUGJKcnlNb0lQN1V3?=
 =?utf-8?B?MVoxbDh4dmp0UDFzSHBMZFRLbUJVbG1kV3BuaW5CTmw0UkQxcHpDeVVOYWln?=
 =?utf-8?B?UCtjWDhRaFgyQ3YrR3hJaXBuT1h1bm5ZVGFOZDhibHE3OEN3eU80MnNTTjVw?=
 =?utf-8?B?QmVXTXdGSWEzcDNhVzMrNGNSbno4cXdFUzJjSWl3QzhUVUNWbVYveWhXR2pn?=
 =?utf-8?B?RnAvY1hLcnRURDlZTGd1dldmbmE4UHZjbk1JWmM0L3pERHd6a2llT3BlSll1?=
 =?utf-8?B?WmZRVFl3OXB2T2NxSUoxWVRyY0lKcHZ0WDFOT0xKSjRYVXNSOWZNUHVkb1Nh?=
 =?utf-8?B?L2k4bkJhVlErRXo2amJUcy96SXl4eGNodUt6QTBxWkFTZlJUdmpzeS9qWnZs?=
 =?utf-8?B?alJVbVhuVnEyTEtBZloyVlFMeUZBOHozQ0t0Z1E2WTdDSUJZUVBzZFhTYTIw?=
 =?utf-8?B?d2ZSeGlra1dleVM3R0l0Y1JhMjNYZjgybkZHQVVETjVVMEkyVXJLWkk4amd4?=
 =?utf-8?B?cmJsUXU1WWRDSE5iSE5lbXBmODZNNmxscTkxeHoydXdWMzQyUW9BeVZ2K3lJ?=
 =?utf-8?B?azlnTVYvTEhtMlJkRVhIMzVtMEJkVHp1cGEzaUJrUXRSY3h6VmhHd2tzWXp1?=
 =?utf-8?B?NUtLbHIrL1djMGVIazhsa2g0cFRCWmgreHBjZklFUmdiOTQ2ang0RlBoZTJO?=
 =?utf-8?B?Y1UzazNuOXZoSmZQNFVIUEh6Q1pvNjlFc0liZmtYYmc2Y092UVowYXNQeFJN?=
 =?utf-8?B?cUNmclpvUkRFbFNwblUrT3I1ejBDSFlUOFV5NnJldElRMWMxRVdhZFhFZlQ0?=
 =?utf-8?B?bVVvVnQ1a3hJVE5QU2F6WGJlN1V4OEQ1d21KWnFiNFAxdjQxZWtMOVc4TFFW?=
 =?utf-8?B?WVdPVW1GM2lsalI3NE01TTd3ellLV1I3cHAvYklzeUxiN2RINnF0ZzA1eUha?=
 =?utf-8?B?Y0JuZDYxOXEvdWNzZjRCTVg2M3JjZDl3b2ppaDArTm9rU01XcWswWjI1eXNP?=
 =?utf-8?B?T20vTjNkbDlxb2JIN0RxdjJPOVVTbXpPNGV6QTBnNHhvS1lXblY2bldDRnBK?=
 =?utf-8?B?MFZoUnBXT21aS1FGZFlOQjYyS3lkUXEvN3lPaHhNNmN0N3VqdDljamQzZys2?=
 =?utf-8?B?OTkwNXRmbDQ4b2FDZkpWMlNtT09xMVpTcGtRNlJucEhWcHd4RythbnRGQkk0?=
 =?utf-8?B?OHprc25Gb1o1UFNxeHFPNE1hNWhDems0aEhEZ3oxazFHRlZVdFhhZnJES0RD?=
 =?utf-8?B?bXEyK1FjVmV5VDJwM2RYYlNrcDdKbVRtUzE2SW83R01kL3NBWkdGR24zN1ZT?=
 =?utf-8?B?REZVVDA3OTZZOGdOS3ZjaDh2eExoc3JsMHUyQVArdjdBalVqZ05sQ3MxUXJj?=
 =?utf-8?B?RC9oTzJqS3ZFWVBFVnFXYjE3RmNzYzcvRldmVi8zK3RhbkVhZVBkTUhNYmpE?=
 =?utf-8?B?VTFZc1RwQklUTFZqWVlNd0VXamRXR1UvMS82bUZmTFhhaHFoSGs4WW9VV01y?=
 =?utf-8?Q?rLCBFJevbk0XpKZ+VV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29a1f73-f166-45c1-f41e-08df2df855d4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:47:52.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgC2H3GxOphT4AvOdAklk7pr4jTfZd+2Y9ASyZuJJCN6JK+l9bLcwhqetYnUH7gs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB932818

Hi Reinette,

On 10/15/26 10:43, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> The active kernel mode association is backed by either a CTRL_MON or
>> MON group.
> 
> This context does not reflect the code at this point in series but what
> behavior will be after entire series is applied. It is also written as
> general but specific to the global per-CPU kernel mode.
> 
>> When the backing group is removed, or when resctrl is unmounted, clear
>> the programmed association and restore the default settings.
> 
> Please provide more context to user and help reader to understand what the
> patch does without needing to decipher the patch.

"The global per-CPU kernel mode, RESCTRL_GLOBAL_ENABLE_PER_CPU, allows 
kernel work to use allocation and monitoring associations that differ 
from those of the originating user task. When the mode is active, 
"info/kernel_mode" displays the backing mode. If the backing group is 
removed, or resctrl is unmounted, the association becomes invalid.

Clear the programmed association and revert the kernel mode to the 
default "inherit user" behavior. This ensures that kernel work continues 
to use the allocation and monitoring associations of the originating 
user task until a new kernel mode association is configured.

Document this user-visible behavior in resctrl.rst."

> 
> For example, "restore the default settings" is a very vague way to
> describe that removing the group backing the global per-CPU kernel mode
> automatically switches the kernel mode to "inherit user". Please explain
> at high level what the code does and why. As a hypothetical, why not
> keep the kernel mode as "global per-CPU kernel mode" but switch the assigned
> group to the default group? This would match most other similar resctrl behaviors,
> no?

My assuption, you are not asking me to change it to "global per-CPU 
kernel mode" when the group is removed.

> 
> This is also user visible behavior that should be documented in resctrl.rst.

Will add a line under "inherit_user" documentation.

> 
>> ---
>>   fs/resctrl/rdtgroup.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index f5c7790f7970..0cdc868a55b1 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1167,6 +1167,36 @@ static void resctrl_kmode_global_offline_cpu(unsigned int cpu)
>>   	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, false);
>>   }
>>   
>> +/*
>> + * Disable the association on @rdtgrp's kmode_cpu_mask, clear the mask, and
>> + * hide the group's kmode_cpus files.
> 
> "hide the group's kmode_cpus files"? Does not match the code below.
> Even so, the comments just narrate the function.

Yea. Will remove  "hide the group's kmode_cpus files"  detail.

> 
>> + */
>> +static void rdtgroup_kmode_global_deactivate(struct rdtgroup *rdtgrp)
>> +{
>> +	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, false);
>> +	cpumask_clear(&rdtgrp->kmode_cpu_mask);
>> +}
>> +
>> +/*
>> + * rdtgroup_kmode_global_detach() - Detach @rdtgrp from the global per-CPU mode
>> + * @rdtgrp: Resctrl group being removed or torn down.
>> + *
>> + * If @rdtgrp backs the active association, disable it, clear kernel mode
>> + * state, and restore RESCTRL_INHERIT_USER.
>> + */
>> +static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
>> +{
>> +	if (resctrl_kmode.rdtgrp != rdtgrp)
> 
> Please do not use tests on resctrl_kmode.rdtgrp as synonym for
> resctrl_kmode.active == RESCTRL_GLOBAL_ENABLE_PER_CPU.

Not really. This was a check to make sure kernel mode is pointing to 
correct group that is being removed.

> 
>> +		return;
>> +
>> +	rdtgroup_kmode_global_deactivate(rdtgrp);
>> +
>> +	resctrl_kmode.rdtgrp = NULL;
>> +	resctrl_kmode.kmode_cur = RESCTRL_INHERIT_USER;
>> +	resctrl_kmode.ctrl = KMODE_ASSIGN;
>> +	resctrl_kmode.mon = KMODE_ASSIGN;
>> +}
> 
> There seems to be some duplication between rdtgroup_kmode_global_detach() and
> resctrl_kmode_switch(). Since the contract is already established that
> disabling RESCTRL_GLOBAL_ENABLE_PER_CPU enables RESCTRL_INHERIT_USER, could this
> reset to RESCTRL_INHERIT_USER not just be done in rdtgroup_kmode_global_deactivate()
> without duplicating it in rdtgroup_kmode_global_detach() and resctrl_kmode_switch()?
> 
> With that done, it looks like rdtgroup_kmode_global_detach() could just be
> dropped if rdtgroup_kmode_global_deactivate() gets the check to ensure the
> group needs removing?
> 

Yea. I may have to re-organize few things. I can do everything with 
rdtgroup_kmode_global_deactivate() and rdtgroup_kmode_global_activate().
And remove both rdtgroup_kmode_global_detach() and  resctrl_kmode_switch().

> 
>> +
>>   void *rdt_kn_parent_priv(struct kernfs_node *kn)
>>   {
>>   	/*
>> @@ -3228,6 +3258,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>>   
>>   	head = &rdtgrp->mon.crdtgrp_list;
>>   	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
>> +		rdtgroup_kmode_global_detach(sentry);
>>   		rdtgroup_unassign_cntrs(sentry);
>>   		free_rmid(sentry->closid, sentry->mon.rmid);
>>   		list_del(&sentry->mon.crdtgrp_list);
>> @@ -3265,6 +3296,7 @@ static void rmdir_all_sub(void)
>>   		cpumask_or(&rdtgroup_default.cpu_mask,
>>   			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>>   
>> +		rdtgroup_kmode_global_detach(rdtgrp);
>>   		rdtgroup_unassign_cntrs(rdtgrp);
>>   
>>   		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
>> @@ -3360,6 +3392,7 @@ static void resctrl_fs_teardown(void)
>>   		return;
>>   
>>   	rmdir_all_sub();
>> +	rdtgroup_kmode_global_detach(&rdtgroup_default);
>>   	rdtgroup_unassign_cntrs(&rdtgroup_default);
>>   	mon_put_kn_priv();
>>   	rdt_pseudo_lock_release();
>> @@ -4395,6 +4428,8 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>   	u32 closid, rmid;
>>   	int cpu;
>>   
>> +	rdtgroup_kmode_global_detach(rdtgrp);
>> +
>>   	/* Give any tasks back to the parent group */
>>   	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
>>   
>> @@ -4442,9 +4477,18 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
>>   
>>   static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>   {
>> +	struct rdtgroup *sentry;
>>   	u32 closid, rmid;
>>   	int cpu;
>>   
>> +	/*
>> +	 * A monitor group uses its parent's CLOSID. Detach a child that
>> +	 * backs the association before that CLOSID is freed.
> 
> Why does this have to be done before the CLOSID is freed? The monitor groups
> are cleared later from free_all_child_rdtgrp() that will call
> rdtgroup_kmode_global_detach() for every monitor again.

Yea. May not be required. Will remove.

Thanks
Babu
