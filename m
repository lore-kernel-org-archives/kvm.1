Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792523414;
	b=5RNLD2T7neYTeY6EF9lAqq92+35ys2bgmVvIwsJlRKvFU5Adb73OUi1CxOz89ZVm2/fv
	 oJVJV7Zmz7F12/jNUlpj0TWYb/iFfzSY5+cKX3GcPNsd4y1sbbbJv9k1GfWY8aCfAcF7D
	 aFR7yvxtZB/G+4p/oRgHqcpGN6JJdmLbL9g3Bn25rE9VNqagiVRlswxcwEQ2O2eY0YQfR
	 fGbqIqdt7H8s6WMYhqCRK/LNklZq3ZEtI37cEs8e7949CpluhJlA49FR94Yx+NuhCaGXS
	 JHA541h4a5WnmR+RVFQgA6EpBmt1+becEToNjod7KP8sfiBBSMwx6PEV2vIfEI4qtPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523414;
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
	bh=P5MEcSz2Hh7W742EzaKx462f78/ns1c+MN6bdZqqygg=;
	b=2wHXUGoYkKRY5/1oekROqCO7Qy+E+eVUzpAzmGjEO5xeJSNuGnqT1hUvGIsUpFGwSCzu
	 XIJYQnUr6Gz7HqXtXApKQztSE9ajYuPN9JYmrjfQ44b49iTtwOKN0Ki/cT9DxTRi6bfxn
	 j8s6C17Z/XbPoWmJulSoCjjxUuL6xNpNqj93GrM1gHr/HhwDA3nDJ9oD9csMR24oVVn8C
	 oilI0rLTfMHQb2vsfPozqw6rw6np+t8xBwK0l469dPelFWfdLxaycTQSv8Za284PdJS4S
	 n3sJkfV/b81C8vzI4rTqcj4HtgQMPsde+iHGgxbm6V2mojCJb94la1ERTF5cUTrcKQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OpMTQY6I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.54
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A87606A319;
	Tue, 20 Oct 2026 19:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A87606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OpMTQY6I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDnrYcroJgHEHrccue3MF4/yLihZK8eFr+Va6zqb5owEurQjngQT2MWdyF0KY1HiNZ3CH7PMuwdfFwHo6osSE6nBh/XsdL8m3MHi6axoo09H8qIeJTdJslWKu0v3vZhoGMh1r8KU783pbcEiIMSJ79i1kNYgpVkg5A+2JSk7OS3AHjdQjhg9IEvscnGSAdf0LNhoOVlP6B+OLMmnMWjcXslSspsyH63hwZ4IxLYyFx1eFS1UGt+NxJDSGHyf+/4/Ek0SuIhefN273LbMNE+58ojfzhxHonxsfFaN9k3Qu5A2s5tHWJ/LU1tvJk86liY/JGA8tBVamhbONjoAJ+0NpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5MEcSz2Hh7W742EzaKx462f78/ns1c+MN6bdZqqygg=;
 b=LWHrxCJWtRg8JdNrLyTL4lqjdsBPUjJOSAlVdP+/Ukd7/6/pbfnCcBWN7dk7UJip6vS/zcJoaJGtNoFzIrS3ypZ62Brg3HC481m5xqhjKDB0JSJasn7z3GmhWcli3hyWhYmCgKZDm9TQPLOWcR5T3dIb1DKg5SQcy+TWOmQmUoM9FV74FuCxVhHB3L79aKL9vNSEsChhOcC6bB4Nqa0QSFhloUBpAlBnNSUMzvF+5Zl6msXUeNwBhqEvt4GzKUamUE13gsc1iqh5zFYpsebSDy3w/8u1uXPmDdE2d153CnmBtCzDL9GRRs4U17SXo01Y0hTU9FSGGUBkVkyFrRun3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5MEcSz2Hh7W742EzaKx462f78/ns1c+MN6bdZqqygg=;
 b=OpMTQY6IRBY3Au24VBdcdpTOPm4tA6fLi3f+dWsH/p9UZgi0HRZLPVlg47c9v9TJEK6XtiSeAzNMc9Y6COADSFiP+3ZrrFY9Tgv7jW1LHxosoYYviGjlo+724WZoujdDp6MazwHdPL7HDGOZld4oNztXQpGUq6ZaNTyHP3RGPYQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by FT1PR12MB798771.namprd12.prod.outlook.com (2603:10b6:170:1e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 19:10:10 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 19:10:09 +0000
Message-ID: <c100cb3c-7d48-4bb3-b25b-0fce88de0561@amd.com>
Date: Tue, 20 Oct 2026 14:10:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/18] fs/resctrl: Add support for hidden resource
 group files
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, tony.luck@intel.com, bp@alien8.de, ben.horgan@arm.com
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
 <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
 <0ad861e2-1dce-4179-986c-872a33eff38a@intel.com>
 <89715865-895d-4771-a700-f1a8aaa385cc@amd.com>
 <8b10c05f-eb3c-4ce3-8580-1cb034ad4e18@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <8b10c05f-eb3c-4ce3-8580-1cb034ad4e18@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:610:b1::15) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|FT1PR12MB798771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e398faa-7c57-47ce-b98a-08df2eddc24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|5023799004|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ybt8mDolTdCh+IcInJcxzGIM2jyj/5c6Te+GXoN4IYRkcdcFMufpudZTGFb7fJGL1PYahmA4X+VTeyr7mM+fbo4mj6rt/G5r9ZWhdI3PGHrRGtrVuj478QB+EPM4abTp8JaGvklGn2ZjbYD6vQM90QEimsm+nW56TIw1LhrdRIUM54qrV6QQWDO/OhBq3NY4qmloQ1iKBVcjkwGGT2vC5LymeG/kFxqLA1oTYI6xGtNEBTKyZDUEvT+v/7RhlUlcY5bFK63apNGn6wQ9Sa2XabHdYYrOvjos9H/rzCJpzrfZtRjwLAhLwS071VOeiLvtFPVmVkSdlCDIal4ayCjiyPTWrt50pwtAZwcaDp0nQKHTK318jmu5W4Ea5aObtLsXQvPqYfDsT2kWHiGv1H7WPcIpsLMaUaadj+rhYeiHMouNGuQjCZXGuTFgqTK+dzBF7c6fMBrGq53M8OmXjYKMjIFe1d5FPTFGzjXKkAmUWog5w2IeXGWseWVdYuVsQgCZx1F3lVG5kywN2dM66oRCMYwJGVksHclgOISL9ASgrhSyittXUkLD3lqJYFG078+Vy/h3PMSkz5zmPwPOlI2kx8sWSNvLfq6svo8XM5R8o1BqyKeWVuRHiYHBZH3II4iJFpAYgW2CUqB1l2Z/uu+PrX0Pw45uQDIUiFHjDA8QV+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9rNCtPUEQyTDBiaTJxaUdtYStLT0I4Mm5JWG5QVDN2U1QvOGZyY3J2eTVO?=
 =?utf-8?B?MVZYRHVIdVgxK1gwWVcrd1J3d1FqblA2M05GeE4zMTZKdGFzbW5yVzBZVlVB?=
 =?utf-8?B?ZUZQNndNY0RjK2FxRERYMWNLRkhSODF3TEN6UjBWT2RaeFE4WDVOOHFkbW5v?=
 =?utf-8?B?alBxUkdYcHpWZWdmOHhuRW8wb0IxSDRZeTM4eVhFcWZYSWpSUklDUC9qUjZQ?=
 =?utf-8?B?UW9kS0o1YkZoejVUY3VveHhMbGFWellYZkxlK2JFWXhma0ZLSnkrcktYeVhO?=
 =?utf-8?B?QnlWTFc1Y2dJQVE3WlVyRmxZUFhYdzc1cm9LMG8zWlRCeVlVaWdiZFA2dTRH?=
 =?utf-8?B?OWtCN201VVNyY0g1KzJSQmlMS0ExSG1xWTgyM0Y4ckMvaVZiNmtZUm9tTjNs?=
 =?utf-8?B?NHErcjJXRWtxazJpMnIvSVpGZzFGY1NqbTEweU9nbmxhcWVuT2IrTFlOUUFX?=
 =?utf-8?B?ZUVJRjVDYjVmQWMxZ0Y4V3ZFUGZ0eTZXTDh6YmFteXhOYWNYRytiYklGWDFU?=
 =?utf-8?B?NFQ5MUZtbHVFS01Gak4yczNucW5kWGZLUUJJQTRCazFGdEsyV2kvZW5ENmQy?=
 =?utf-8?B?SzhJMkl6bzRRQTFlVWdVTmZjZWNmTEh2elR2T0JPa2JtM013aHQrU0huaGNz?=
 =?utf-8?B?ajVIMkhSNnhEenZyRnBDZlJXK2NKaFBsUzRrZUU2ZFZFR3NJVG45SVljRUVI?=
 =?utf-8?B?M1BNSXovRGJqVDNON0REcHNUTHdFNEZIcHQvRENTU1o3bmFXamczd0ZRMjlq?=
 =?utf-8?B?eDJ6M1ZPN1k2YXowSzNUeENzek1iWW5XY2ludzdaN3QrRVBTVTRuVE5UK3B5?=
 =?utf-8?B?TnlJQmd0Rk82bTBUR0VPRGtSMkNoRmlyVmFyTlVOdlh2NzBQcmhWSjBneGta?=
 =?utf-8?B?cDUwZ0Z0ZGlJRG5TR2lIVk4vd0o5d0JYcS9TYXlyaGNrNTdTZGMrbDdiaVh1?=
 =?utf-8?B?WmZmVkVuNlI1QXBBZmZLWnpLYlUrMTlCR3RLVHU0OVBoMzJkdjlGdWdRZjdt?=
 =?utf-8?B?b3ZCY1dCUklSWUhsY3NQMk83SUVpRHdlZDJ3cStjMjRPMGs4NUY2b2VXN0lt?=
 =?utf-8?B?WU9BNDU4MENpQmlIVCtlSGVCRWFTWFhwU1QvVWhHMFptSElpNHBxSXJFRW9U?=
 =?utf-8?B?bTh0eVBybTVSMGQ5UEIyQktGMmpDNGRLaUswYXMyVm43eFdBMyszTzFONW00?=
 =?utf-8?B?aUdiOTQ4OVFleHdRWTZKN3RIa0Nra1pXVEhtRWd2MDJadXY1dlEyZTFEdkNR?=
 =?utf-8?B?ckZWMXlQaU9vNUgyVXRpZWhFZ1pnWlpDMllsanJDQU5uRXRPZ2dHY05FK3BE?=
 =?utf-8?B?Sm9aWFc3SHlUQ0t4dWJHT2pwdFZHQTAya1J0b2dldk43KzhXYjF6N3daVGtI?=
 =?utf-8?B?MVNLYXZHQi8wd1NCQjYrTFMvdG9sSEp2d0NIL0Uxb1N0MWtRdU9UZ1dxUE1w?=
 =?utf-8?B?SHRwZzlST00yOWlvSEhRK0dqUE1vTTRsZjNhRzNEUjVCUi9mS0IwbEZ4cytD?=
 =?utf-8?B?aitPUlFGTlh2emZTTDBBTXd5dnM0ei9aWW96OFhSbUh4a1RUWWQwaVhLYjVa?=
 =?utf-8?B?MFAxV3lGSU1TcnhRdDROZmR3bUR6M2laZjd0elFQc3lQSmxKOSthTTd6c0NI?=
 =?utf-8?B?d1NWdnpCYm1RMXZlWm1QaWN0MDkyQ3BFTDNsTktjUkhYbjJ4eTBlSEVUWWFa?=
 =?utf-8?B?ZTU2OGNlVDlVZW1qNTV3R3lORlZNQXN5OGo2QXdnUU50OWc5TzkyTHJscVNH?=
 =?utf-8?B?SXF0ZnlLYmVNYUV2WGZEK1dPOHI5K09ObERhcnhhRms4eGVXVnYxNjBEWXFO?=
 =?utf-8?B?Wk0rY29YUEZCaGJkMnhDbis4WmFmLzhEUW1KOUZtQU1BVFo3elQvZFVJazNo?=
 =?utf-8?B?aUZEQlRjdGlNYjRGNnErZzllUXZlZzQzSHZyWjFPQzEyNnJTb3VSRUpWWnE4?=
 =?utf-8?B?QzVCNHp4Qk1jVFdLc2VLOXBkSlowVkthZ3hYcndYVDFkekVJYWF1Nk8vdkor?=
 =?utf-8?B?aGNuRU9FWG8zdTlpWWRBSkFKRGUyUGRvcllOdU1qbHNOQ2Q2Y3lKRkJVa2Rj?=
 =?utf-8?B?dEZTUGdaZktTZy9CeStPdnVKSjZmamplVU1SQ25iU2ViOStCV1ZZdHVod2dO?=
 =?utf-8?B?NjZKbDVkaHc5MUQ2cUlYVm1OcXVybjdDTmhnTDdWQjloWFdUQmEzZk9nWmNY?=
 =?utf-8?B?eTBoNnNzV2xIQ3cwcWJKcVRPa24yd2R3OWhHWFdFbFptdDV3TWJzeGZrT1hL?=
 =?utf-8?B?WloweUdNZnVFTHMwdnBiVGdoN09BMmJaUTJlaXg1akx5aDRtVHZIcmtPNm9a?=
 =?utf-8?Q?74RLNfLpTx0NJognXL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e398faa-7c57-47ce-b98a-08df2eddc24f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:10:09.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLnq92i7ycuEXIG+GxFvvniSKBF7AAKEImjHcP/2vps52VTRl6UAEluTFxoFl5qP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB798771

Hi Reinette,

On 10/19/26 11:22, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/16/26 1:53 PM, Moger, Babu wrote:
>> On 10/15/2026 10:27 AM, Reinette Chatre wrote:
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> Some per-group resctrl files are only meaningful once a resource group
>>>> has an active kernel mode association.
>>>
>>> Could this elaborate more about how the files depend on the kernel mode
>>> and why they may not always be meaningful?
>>>
>>>>
>>>> Creating them only at activation would complicate group setup and
>>>
>>> Why would it complicate group setup and teardown? I think it would
>>> rather complicate mode activation and de-activation but since there is
>>> no detail about how this will complicate group setup it is difficult to
>>> compare. It is difficult to reason about a patch when the motivation is
>>> vague.
>>>
>>>> teardown, while exposing them on every group would show empty files
>>>
>>> "show empty files" - technically these files, as they are implemented,
>>> will not be empty but return errors
>>>
>>>> with no clear purpose.
>>>>
>>>> Add a hidden property to struct rftype to hide files at creation.
>>>
>>> Missing a "why".
>>> This can append to describe how this adds the foundational support in
>>> preparation for features to restore visibility when the feature's files
>>> need to be exposed to user space.
>>>
>>
>> Will rephrase the whole changelog:
>>
>> "Some per-group resctrl files are only applicable to resource groups
>> with an active kernel mode association. Accessing these files before a
>> kernel mode association is established would result in errors and does
>> not provide useful information.
> 
> What does "and does not provide useful information" refer to? Does this
> mean that the errors are not useful?

Hmm..  One more attempt:

"Some per-group resctrl files are only applicable when a resource group 
has an active kernel mode association. Exposing these files before the 
mode is activated is not useful because they have no meaningful 
information to provide, while reporting errors on access offers little 
value. Dynamically creating and removing the files as associations are 
activated and deactivated would add complexity to the mode management path.

Add a hidden property to struct rftype so the files can be created with 
the resource group and exposed only when applicable.

This provides the infrastructure needed to control file visibility for 
future kernel-mode-specific resctrl interfaces."

> 
>>
>> Creating and removing these files when a kernel mode is activated or
>> deactivated would add complexity to the mode management path. Add a
>> hidden property to struct rftype so files can be created with the
>> resource group and exposed only when they become applicable.
> 
> Please separate the problem and solution descriptions.
> 

Ack.

Thanks
Babu
