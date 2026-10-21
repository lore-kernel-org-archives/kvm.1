Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792594992;
	b=IiA7HUGm4eMCs8GgNHupZYAFZsqAB+xVhwU29FDUMVcCM0wveCMTS2Uy3hO75HUAUKvQ
	 pe7LViT+QcIQ/hXeA7HcCLBs7wr2Yy2ufZg99mRG/U57v+q7xtsBbld7ot3o40aFXVMKg
	 FYCPcgg+Ddegm5BBgC5Sd0dIXmXpEVMgIFei76XVJ3NuQMIJGyHmybt7vJrbXi3lYYYgD
	 vqF7LYQNnAeLUgWzcG+QAW2gqEbZ2l3MOaW0nP/fg9g0nORdDoUeg6SEqOuqbWKgfdGgh
	 uZybpyPKaQAGMJdlnGx2YmL4jRyhs+JIRisRbY/5GisGM1pAurqzxlmGkEEx9T0UKKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594992;
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
	bh=DnU2Uw1Rw+wTtO/YIJQzgsXD4e0OCo9FgakRQ+6Wsms=;
	b=NHtf8B6cuAJ5tfX7EliWSYAk7myN3UgXI/5vvCqVk6Q6S7NVh1lOEbIokR0O4bX+vChm
	 Uwucx4Tj+18F+/9fUzTTGsEkxszl3jiw2oqICg6f60K4Qr06dMQAUQ6wu8DVAZCgomY65
	 /w1fZUkUdTZHbX5ae+525arQGwxsV4VFrXLcZrGGfxduvuzLZ5YK8Gfysc3GKwFGCNnOL
	 NWb8BH5OVC7QwVBmh/YU1Ox9A1DJJYZziq9zb/VtqvH0RHtbis4cIQTaaWn5LBwy/Nh1v
	 M6yrM9s0TL5phPImmrFJ5Yp0fMv1M4Z+kSKj+ySHIWmf0LGxXoDPsCSbIgkeQBJHejw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RmmxbwFW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.63
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9929606A319;
	Wed, 21 Oct 2026 15:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9929606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RmmxbwFW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmAxSbg0GNIOXdJwunI//XF+C34bPRsAge0pXaNbaWF/Y2VFcSg2xQCcvue9QpN5saaki5w2PcacqcmigCK3TDDA+j87YReiiO2/RiM7za9r3feLXNS0TsvN3kn39e1AS2m8igtNiYlC0JT2HTJUSadCj6JoC3hFb2sy565/SpMasezxGwJXxwVnEaHW8FnDVEMY7G4kgdWHHFtM2TYa55LBBPvHnmJ8GD6vwPEzvEP215dCZZlaO+Sz5qTrJARr1fPnz3UYzS0bTZZ2oxYutwUyKf6Ai6tZhdL+ZvenHo7fbWvel+AZelvPFbvgQIOEIcNKjapBJjI1L/A2HjzJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnU2Uw1Rw+wTtO/YIJQzgsXD4e0OCo9FgakRQ+6Wsms=;
 b=QhdwFHk20qxQitzYBEGFLeU4DyeCwR1WC/iL1Lh4hdOmzrJLW6hu4XcDYwUzAzhelKbOjY6sdXG6zKgaP8d/dj0buuHaOl81YjuXkTDAGKbzCufXLo3hGyU3PAIFFN8oud/vDq3CHrfzSisGx/Eyk3jKfyq5nkLiAJfFfuY11QiDw0zRKwOKMSvv1TlVy+YRNlC6YI/Hc48uBsmH0pOQE4rxM+S3Gg9Grmz+vJ7fT+fOvu7GpZNp64n5eo4ruzG7NXKyr0mSvDjl8ckBn4vel1sSfruSjd3Z/tgjynJEJO6SSinYDnN+6+Tgx9WyMa3CltlW2TdJtrRA0Jrb5hsF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnU2Uw1Rw+wTtO/YIJQzgsXD4e0OCo9FgakRQ+6Wsms=;
 b=RmmxbwFWblnaT0RDUBnz07wbLxcWzW7PMS/cNzWe34qH0Gs4KgKYA73kk5SiI6J9lYWJ7KAy2AqlCQ9xCcDOd0LktmqMcj6JSNkbkK9HBr7tlTMeHNFhe2O0IO0SxbvbPqMHpX0iZv2gikNZgrs8MbxafkSMmS3FwV9Jxxbdjtk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:02:59 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:02:59 +0000
Message-ID: <71285fd5-6094-4114-a0f0-7d55c049edd9@amd.com>
Date: Wed, 21 Oct 2026 10:02:54 -0500
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
 <cabf7da5-e5ba-4a49-9edf-f801f344ded6@amd.com>
 <f7a56c83-b732-4959-9f31-6273d25963d1@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <f7a56c83-b732-4959-9f31-6273d25963d1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:610:cc::23) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8086df74-027b-44cf-ee97-08df2f8464df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|10067099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	USELC3FRD1EvcSri5OvQ0V9TcU7Tb1/hp6XMPVYw8Q2B9rDlX4Hw5kG8OZ36dfzx5jCuPfrEZqXBLVIkyKwbmTfjp5MyJh91EOVzxeTDCAohitm6KZFwZAtyQ5Rf+qws1im9MQge6Wvp48j4g5wjUdxS0C6wCUxRVVprXLuEekZdEvht/VC4dhLWwIqG6WRIOY9WnrQPaBX2Lg4i5Ko2MYir6T4TSqZ8KVJIJtHqcFiyxbsU/3OsofKLDVbInhO1G74/IC/itg4+JwheQ3U4vdpgpgghTB+oIxNC5/l3UWRVfTDZbuA6gA3dlN7mHjTk5JnpYXTx12H4MWQ7PL/YzlITl2jPWf/4xMq03uZ9d3c28Turba0TTjmcIJh5T8lk4ODFclpogpytUnRfnkVLeLdcU0iW2OGejtspAgnmvh8jObYmPREQsmGTfsWUR4D/C1Hb7P/q03iBrrv4VJ3DIJw7k2oiUUgkLheJc3AW3rg/96aTx41DI6f4eHXlhB2cXvkpKLt2S0+Ydngjr2f0cyQYLl7y2JtAguedJaCkJdw3xycUR8lxb43yUwNvhSm9Yoh3bQRZcmEN2Eb8embv4qJqDRnWcpVqz1MPRivgcB7vtvF1CdIcJu1KZB7SWEYqTPrTCqd87AIg/gC3TxR4D8J/c5K1TokLFUHgoVpWT4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFBzSFNJOU0vL0FYb3d5Y3B0ckp3WVFXWnBGT0FNMWU4UC84bFRTOUFnYW1h?=
 =?utf-8?B?TnMvMTFPVTlCVzE3dStyOUFiQ3o0VGxxN3VtazVzZ2RORy85TW9zUWo5QTE2?=
 =?utf-8?B?Y0ltcW5OSG1kN1N1bmVlcVNGaytvOTBGVWYrdW5BN1M3dmFkdXZFZzUvazZW?=
 =?utf-8?B?NDlYdVNBTXV5Y0E3ZG02QVllVWhlc1pOUWwvZjV3QXdUOGZ0SERaS2g5dVA1?=
 =?utf-8?B?MmVsQkFvbTlaazlkSjJRSUxtcWdoWVpqcE9hK2gzeHpBVzBlZkZmV3NaWlk0?=
 =?utf-8?B?YjhyeEN1d3ZBVVd5aDZDSXNGUHoyQUZLUFB3dU1uUDVIZkxXc0s1OGZTQkFD?=
 =?utf-8?B?dTlmWm9FTGY0NEw5c1IyM1BXRUczR1VybFF3VnlpS1FNYk4yVmo5Tm5sWWJF?=
 =?utf-8?B?NTNpUGE0MU1NUzM0Q0YwUlhtOFF6OTVaZnMyY0QyUDlDZnRXbnFsaVJsdnM2?=
 =?utf-8?B?aHB6djF5TnljVFh4a0E2SU52UHRqcUp0N014VWlCWjFnUlh1VFpuU3djTzg5?=
 =?utf-8?B?eUZnYTlXdXVtYy95cWVnejNRMUNCbXZQbSthWWJEVzcwV3VRSnIyM3Zlbm40?=
 =?utf-8?B?SmV6RTF2ZTVqdEZmdG5oS3ZQamlMQW9TN3pha01wMU1TWTVVRWZOYVpRMDFr?=
 =?utf-8?B?WGZGUHUrWERsZ01OcVFQMjFMbDZXL3VyZXVDb0NtT0NCakppMit5MUlPTUdx?=
 =?utf-8?B?UTFZUFlxZ2I2bWREcUlTbUhlNGZmN3MwYTRNUm9xV2Y4WGpkYWhhdjFyNHZo?=
 =?utf-8?B?ZXJRSnloZVpCUjA2SGJ2SzVMMzZsbnVzQ1NJVU1pb3M4WFVSMzFzbmM5VXlY?=
 =?utf-8?B?cWV1MDVqQ1hUajRYSmhDdVFUK3h2VnZrMnp0TE0zUHJzS1NTbUhnNGMyU3hB?=
 =?utf-8?B?L3dMTFhURm5hVElkOEFCV1ZqNjFSZ3dVbFEvb1FlQzh5ejVlQWlJeWk5SDlD?=
 =?utf-8?B?cWJnZitqRDZyeTZrSlUxZUl1NEw0am1MT2F0OG1GSVppSEdSQTZnSmQ5cFA3?=
 =?utf-8?B?R0lZbVA1SnJROGYvWGpESnNlMndycmdDT1pWUXJVbnBOY05PR2Z6U1hiVEU0?=
 =?utf-8?B?WjY5U3JmOUp5TUl6cjFmR0gzWkpadUdGODF3UVpucEhxWThkcmpINGZqcFhx?=
 =?utf-8?B?aENsZVREVXdTZ1BKVldiKytoMkVBaWVOdENneDE0WEZIQk9tMFpjRC9FbURx?=
 =?utf-8?B?M1FuaHNkWWgyZDVqdkFiajVCY2Y4dFpmc2lEUXREN1BxeTJBWWtrWTZtY2NV?=
 =?utf-8?B?cGJQTGFoOGVtamxhZmFLSUQ5UjZabFJUb2x5dUdrUSttMU1NOGZEUlUxeXBJ?=
 =?utf-8?B?QlIzZjJMYjBsNW5oWlhZTVluZUg1OG4vZThyNDRGYmpuNitFV1V0WXRSOERF?=
 =?utf-8?B?aWs2Uk0xN2RabUVHZnVhaW9KK1lITjNOT3JiNU9JVEdhOWZVSVI2Z2tnUEt2?=
 =?utf-8?B?b2djcU5SQUl1SDZncVQ3dW9LeExaUUc1ejRlRi8zWmp1RlF1dSsyV0EyWjZt?=
 =?utf-8?B?WEJFUkZmMEtDSmdLMFNTUjZGOUovTGdidGovQmpjdlVWdUp5akpPSmZPUWl1?=
 =?utf-8?B?QTYzZGxqc0t1NU9ZcTkxZlRmTmdEb1JZcmlMUnlsYjY3dkxMQU14bEJwcjRK?=
 =?utf-8?B?TFljRGdsYWRlczdNMVAwTGlETnczRUYrSy9MVlU2c21WeUVrdHdrUzZuZlEx?=
 =?utf-8?B?Mkp1elVhQVVRbTdNMEdyZm84cURGYU1Zd09ZbXRkM2tNd2crbkpuaXZuaFVu?=
 =?utf-8?B?K2gwbWo5d0c5TmRNYXdUSTlEL1ZsVy8zbGdLMzI1ZjFTYXpBRDRUcWNEWWlq?=
 =?utf-8?B?dkFpeWxLbC9KdVZXQ2lnU2RuNnBWSTllcGx0Nk12aHBhOHhaT2cwMWFFNHdM?=
 =?utf-8?B?aDNNbXNFSGlkNDBIbVdtNjJIQlVQdVo4NExIYy83K1prNlFFWUVhaTRpbENJ?=
 =?utf-8?B?WTcyT2Jhb210cFB4V05uVU40a3JKaUtRWVRzUlJhd2VlNng1RkwzbkxiMWQ1?=
 =?utf-8?B?ZVhMbGdhd3ltWDdZdzY4SFVXeTY1SU1heXhuMDQvVnZUOGdNQlBRS09vT3lC?=
 =?utf-8?B?Y2l3aDNRNlhRWFRhM1NBRTZRU3JEbmxlMEpOdm1QVy9nU1pPM1dMb2paZTEr?=
 =?utf-8?B?YWR4am1TZEhuTEU5VFpEbytZRWp5OVNzZFNwK3kwSkFGZVZzWHRIZzRyVnZs?=
 =?utf-8?B?OW1tY0tJYmtjb0hlSlM0SVlaVFN3SkFyZE1Fb0tnTnZLN2dvbGpSUzhVYkxR?=
 =?utf-8?B?N3phZkx2ZWpsRnMySVpROUhRZ3RXUEZYMFFRUUhTWTlKaHpBYzNXc21wY2wz?=
 =?utf-8?Q?C3OmHFssaI1nCEDKiK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8086df74-027b-44cf-ee97-08df2f8464df
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:02:58.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN8ViIWUzC7qUW4g6/xDN55g0L+TGU5b5U98qkvoOd8V+wE1PMiKvvpYL8GTnN/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152

Hi Reinette,

On 10/19/26 11:37, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/19/26 8:47 AM, Babu Moger wrote:
>> On 10/15/26 10:43, Reinette Chatre wrote:
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> The active kernel mode association is backed by either a CTRL_MON or
>>>> MON group.
>>>
>>> This context does not reflect the code at this point in series but what
>>> behavior will be after entire series is applied. It is also written as
>>> general but specific to the global per-CPU kernel mode.
>>>
>>>> When the backing group is removed, or when resctrl is unmounted, clear
>>>> the programmed association and restore the default settings.
>>>
>>> Please provide more context to user and help reader to understand what the
>>> patch does without needing to decipher the patch.
>>
>> "The global per-CPU kernel mode, RESCTRL_GLOBAL_ENABLE_PER_CPU, allows kernel work to use allocation and monitoring associations that differ from those of the originating user task. When the mode is active, "info/kernel_mode" displays the backing mode. If the backing group is removed, or resctrl is unmounted, the association becomes invalid.
>>
>> Clear the programmed association and revert the kernel mode to the default "inherit user" behavior. This ensures that kernel work continues to use the allocation and monitoring associations of the originating user task until a new kernel mode association is configured.
>>
>> Document this user-visible behavior in resctrl.rst."
>>
>>>
>>> For example, "restore the default settings" is a very vague way to
>>> describe that removing the group backing the global per-CPU kernel mode
>>> automatically switches the kernel mode to "inherit user". Please explain
>>> at high level what the code does and why. As a hypothetical, why not
>>> keep the kernel mode as "global per-CPU kernel mode" but switch the assigned
>>> group to the default group? This would match most other similar resctrl behaviors,
>>> no?
>>
>> My assuption, you are not asking me to change it to "global per-CPU kernel mode" when the group is removed.
> 
> Not specifically, but since the behavior is different from the typical resctrl behavior that,
> for example moves a removed group's tasks etc. to the default group, it would be valuable to
> know *why* this behavior was chosen.

Sure. Will add explanation for that.

> 
> ...
> 
>>>> + */
>>>> +static void rdtgroup_kmode_global_deactivate(struct rdtgroup *rdtgrp)
>>>> +{
>>>> +    resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, false);
>>>> +    cpumask_clear(&rdtgrp->kmode_cpu_mask);
>>>> +}
>>>> +
>>>> +/*
>>>> + * rdtgroup_kmode_global_detach() - Detach @rdtgrp from the global per-CPU mode
>>>> + * @rdtgrp: Resctrl group being removed or torn down.
>>>> + *
>>>> + * If @rdtgrp backs the active association, disable it, clear kernel mode
>>>> + * state, and restore RESCTRL_INHERIT_USER.
>>>> + */
>>>> +static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
>>>> +{
>>>> +    if (resctrl_kmode.rdtgrp != rdtgrp)
>>>
>>> Please do not use tests on resctrl_kmode.rdtgrp as synonym for
>>> resctrl_kmode.active == RESCTRL_GLOBAL_ENABLE_PER_CPU.
>>
>> Not really. This was a check to make sure kernel mode is pointing to correct group that is being removed.
> 
> The problem is this "global per-CPU kernel mode" specific function is called without ever
> checking if "global per-CPU kernel mode" is active. Instead it uses one of the parameter
> values as synonym for whether the "global per-CPU kernel mode" is active. What is a future
> developer to understand from this? This implies there are two *interchangeable* ways to determine
> whether "global per-CPU kernel mode" is active ... sometimes
> resctrl_kmode.active == RESCTRL_GLOBAL_ENABLE_PER_CPU is/should be used and sometimes the value
> of resctrl_kmode.rdtgrp is/should be used. How should somebody interpret this? Are these
> two interchangeable tests (and thus making one redundant) or is the test dependent on the scenario
> (which is not explained anywhere).

Understood. I will try to fix in the next revision.

Thanks
Babu
