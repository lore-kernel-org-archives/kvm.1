Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905548CD77
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016004; cv=fail; b=Nl5K9VEU67sBt7PA6kXxkRLS0uUZTMpaQY7hTKFuIEQ9ZQeKhOHtbLedlU1xB5MecTy+vnNvhEubK/K/M1sc2NtXuHi0/OwMUswG3sa7tid9jxStzKrR73WSFFfFLUrW8MxYV8EomLTTpcRln6rf3nEpKcJ15GvvBzZTn/DfwM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016004; c=relaxed/simple;
	bh=649IYQWifXpxCsgxvgW+rr8y+2A88KegBaQWktTog1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtnOBOWE9Mn0JI7UhGbhf996YajvvLg1JerNnYfBgbhLFINGdMEl/rsX3xhtANe0U5MJ9fQNJMQ51cJUmgXgaDBkRD5oyMe2l46AyumCgqRca20BapQz03aKUdK1nbSDBqS1YrouTtvWMykeNsz0XSURb9umdmlqUR+rO3R+fLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1CXuyqV1; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1CXuyqV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iabKuYRTWUPmwPYODjJSgg8oH83VyC7WQAAZVznhX5bniN1cVpxjUC0GuiqRXl/cNdGsmoLNC2OXJrDX1Aog0eUx4Za7Ur64Pcd9V2TJrQ+mciGLbDRiY1xW0shJQiy02c8YNRuoCvxM+bfnEriOX8mdOX6iON4ADeA0qKckFjlP/OLlDHRcN1ZmPGZrQakJjNoXjLLbJKZvCiWTXhnvmD7R0T8C8DFfpXo1BWojf0c7BnUDev8fJ0duEc2SOGXR3AsLlClcGuQBbG8D7Blg2fZGILKDIzQzl2TKx2HCuCv4Wyn9Q9dqJHTCpHlAmAjgq1Ygc16Z+gzbSXZ0PoxL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6WfZIMt4cF2Z9zbpJ+c8NgPMyqm3ZYXqHJLjLmaWe0=;
 b=SIS/7NiC8lVrP2QibqYGbtzmxPXAyRNybe7BCg8rqArWo/4YppTVIOebEctU2Dz5VB551TQiml+u+6cHI2cVqNNi0Ud+X+g+pY0oa2k/Yat+yZAmU932V5jOKKa3RTOJ7mchprBoKezzRwZYhgG328CFF43qSaxCWqb3CS55tD3cERqv8vZ7hhE+Q5XXQNzfcpa6l4LTaUPLYao8vmTnSz7XwUNylqHr+xG8UKCELwPaoFeT7Ev3wF7n8dJDiOhgBwoJANxXaO8+1JochaBbYl74RHSG7Mg+9kduf2lcWd+JYQQ94YYBaif+7oAHi+m+/k4iSfViJI0/gDinSsy7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6WfZIMt4cF2Z9zbpJ+c8NgPMyqm3ZYXqHJLjLmaWe0=;
 b=1CXuyqV1GV7DvGny9gJs2V9AApnbeCBXBrBL0P+O1MBVBjkKZRQ+7Ez6+hZmmVya8OzjW6eqAokJ5Uj+22TA4+5Yz8GcjG+xwCTy1O3dOrFaygfh0F/5Mnrmyq7MZMXL3fB+nAPEuPm4oeFw46TjJwO9fjTVqCY8eoWYK9S2Lc8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 22:13:19 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%4]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 22:13:19 +0000
Message-ID: <a68df2c1-9e5d-4318-a438-ca8e99876812@amd.com>
Date: Wed, 14 Oct 2026 17:13:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/sev: Only announce RMPOPT optimizations when
 SNP is enabled
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1792011434.git.ashish.kalra@amd.com>
 <5fbbf065e912fc011ec0f043db90f530b55c4517.1792011434.git.ashish.kalra@amd.com>
 <sashiko-outbox-171925@kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <sashiko-outbox-171925@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:806:121::25) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9c614f-281e-4dba-648b-08df2a405a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/cZ9IfW6VVXUtcyvGNaiyJdA9Yr8xcGBEaPed/N95HYG4K+iaNyn6n/pF2zUX3xqCG7noGrQFZ0YQN8HQnSFj5h/Thvao8tqTmKFGhW6NIzMWaf9EjNje4NdYfjNwExnYTRxWuSHOPJzwtvJgTEDkwVoAupIxgv6KszMPtAdgNYwqbAhjCWkMB//L/LWz2/Mj3nmZQaMb/ErVCvm5D4BHBameo6GZ8QFOaX077AdI5cUs1GSME+o0haKaaNY9Rbr9GuZC7+lX8laCna1lwhumImNCNkqUAiF33yzCh6iYDzKsBd8bJZnVrcROpCbas/HKiu3ZOmk2N0/di6UsMRXJEyFCiCCyU5Wk1KiQN5yV+R+KvJVA5v1CCtwoXabemQj1k3ZOIaK11VfT1jSCiRnxxCbLRBYaIe93fsbw2pQZ3S90M8Tl3WqDV9hkY40wdLjOC0qdWh4MurK6yrSQ6h+mxtPkLeD5fy48Fs9QM68yZCz3Cygd4VZN6A2wvFD7homt0M4LtRGxhD/Mlk2i0vHoK0XlemUiYRv8nApxtAK34uPIIzkGZPFYRP9qZMeXqCEzI+RrEvJ/REL+bMMSp3rnpfj2GzZGmJl+0TOg7+u13mTGWlBzaN+oyhDvfZL5UzjoPy4ApjTM7hkJK27SKq5Nd1IU9mb6fulmzBKyh240Lo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjFQL0QvWFYrNWtSeHl6SkRxb0hRK0JST0NZeGE4REk0clVQZUNoUUxmZVR4?=
 =?utf-8?B?VzlxMnVrNEJlQ09FbXg2VkVteWx5OFhhZ1k1aHk4RmtmYlNGSXZ6QnRXSTZZ?=
 =?utf-8?B?UVR4OUZIVkl5SWhCTjVQaURBbnh1dXROVG5BbWNGbWxsVVJCbVMvMVdIc1Ja?=
 =?utf-8?B?RS9HcDRRcXhaWFBxdEQ2SkJLeUMxNkI1R2RnczJhNVFsdWlPTDdiYkJkRUo5?=
 =?utf-8?B?ai9nTjQxWWtBLzJSS3k4c05rYnZXd2VaUExHUS9GRWdGcVRobFRIQmpSbGpD?=
 =?utf-8?B?NHRRZGl5UEV3cmFZM1dncDJvM3lZcW9uWEsyQmxnaWs2WisvVEhJcWk0L0l0?=
 =?utf-8?B?cXZvekwwR0Z4a1VHNS8xWklTZ0RoMzJydHpGRi9hNldMMEJya3RyT0RqYm1T?=
 =?utf-8?B?TWRtWHVPUnJKWDFWdXFTODRiM002MVBKMGFac09rQUZaUVhhRnJQcWE3WGFj?=
 =?utf-8?B?U3NNOTlMWmlleVJ4cHhtTDBzcmNXd0Q4bFQvbm5HTDhaWXYzS0NzTlpCUkZP?=
 =?utf-8?B?bExnU1AvQkNNSG1RSlBoVDRyenJETDZNcXBGUldnL3o2WFZnMG5SWmJRUlo4?=
 =?utf-8?B?NTBCSyt2aElTNEd5aXRpM0tKRW40WkhRUHhMaTdXaXFScUZPMzl4U0ovblZL?=
 =?utf-8?B?aWp5bllQVE1QaGk3SXdmSTZmVmFqSitmNFRDQWc1NE5rY01RQTJVeHMybzZz?=
 =?utf-8?B?cS9aVThIRE5yd2thUy9TNXM0NTJ6Z2JqODJTeHowb0U0N3RGeWhqSHQvVGVm?=
 =?utf-8?B?N2lLOEVGTVZGN0JvTTY5aDd0aDlPeWViM2FvWkZJTTl1N21Ccyt5NnphRGRP?=
 =?utf-8?B?THRZR1NhL09QUDVNN2lzcHEzUUh6eTNUaERicHZERWRIUUJNSEFhc3V1VXQx?=
 =?utf-8?B?eC92akNKK2pQaEJKeENZNUJKNExpUHBWYVJWMlhZWmNRSzN3aGRCK1hTUmZo?=
 =?utf-8?B?R2o2aWlHVUFzOWkrYkRzaGw0ekE3WWlEa0trL3h3aEZ5ZWhmWDV3U0FUOWtV?=
 =?utf-8?B?QU1wN3Vtb1JTTkk0QUFrZ3d5UXhZRlkraTFoOXBYVlZmb1pqbTQ4dHhDU0pT?=
 =?utf-8?B?VzU1em84ZkNPOFFnaUdtZnBWNmVJclY0QUM4R21HOFFMUWo5YXZZUkxkcURU?=
 =?utf-8?B?MmJ2T3pVK3hUZHpwTlJCV0dSTHY1QTB0dnVRRWhWTXY1TVdMTGt6a2svbXZh?=
 =?utf-8?B?aWtSKy9hbkFjazZBMUNNc3k1elVkRHowM2x0ay96aldFSHN1Snl2dE43dGs4?=
 =?utf-8?B?UVVMR1dXbHd2WnlnSmZrbXM1QTg2dUdCTmhjbzdDbWNwVFdBYVRhdGNrcVJk?=
 =?utf-8?B?ZmI4d282UzliaXFSeGVsNis5MTUxcDd4WThtSHcwbnBSdEFjblB0VEpwV3d2?=
 =?utf-8?B?aUlIdkp5OFpvS25iSmJzbmdLYzZuc09LUlJSaDM5RVV0ZkhXdXQ0ZXZXR1Fx?=
 =?utf-8?B?NStiY3F0VVppRUtmK2NJYUF5VkRqSm5FMFB5S0UyZm5rMEd3SHNudStRTFNI?=
 =?utf-8?B?SGljeDQrRDQxM3V0eVZCUWE2eUFBMDIrWmVxV2RoTG8rVjNDTVo1d2lPUkI0?=
 =?utf-8?B?K3pYc2crSXIrS1loYXI2L1RPZ1l6TVVTOWc1VXFMUkZEaXRadUliTmRHQUt6?=
 =?utf-8?B?TUpHQzBSN25raXVLNHhGa1VzYnZpajd5RktWY1hqVWI3cGlTTHgvMUc4cHlO?=
 =?utf-8?B?ZDJKUGU3OUlHaVBHVnkvS01zVXNvY2lJZ3J2NDNBR2thMlh0V21xN0ovOWwr?=
 =?utf-8?B?TlJXSWFvR240YStvNVBxMFBBeXdHaU9hZHRNM3FUbFJCS0JzQUFDQUFTM1lj?=
 =?utf-8?B?bGRQR1dXanlMbS9LN0FxUjE3eWR5b0FMM0JKN2ZSdVN3eWdkRG5MQmFIRU0w?=
 =?utf-8?B?dXdGSmdOMDgzaHpOdDliSy9YRkl4Ryt6NGNURllRVys0QmJvOGJCdUMveGFB?=
 =?utf-8?B?NE1Mek9ENGwyWWdpZkpObXoxMGYwbWdIZjhVWGZkazdaNFFCczVVMDNxcnh6?=
 =?utf-8?B?Q0RGVlRvV2FTR1M4OGdEdGRzOHM3TnVBL0JvK2NMVDZhbkk1WFFIeHBFM2lE?=
 =?utf-8?B?QUhtcnFGTUtQTWljRDZqdGg5N1dCWDJuT2w5aXVQYU1MZXdHb2ZlRU5BWkF3?=
 =?utf-8?B?VXBjVnFhVHkyd1pPcnZnVDdmbnFBTEoxaXZzcC94UzdRKzlyNHlvMnpQRU1j?=
 =?utf-8?B?MWhQS0dyZ0lhUXg2Q1B4OTd1eHdLVVBGa2w3VWJFc2hjemJXK2RXNVlqTlZm?=
 =?utf-8?B?Y3ZtZnZaUHpsRFFCSDN1WVNzREpLeDJFMHRBRmd0bmFXQ2V2TTNoMHdKd1h0?=
 =?utf-8?Q?RPInyI3FQS5/CiVTHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9c614f-281e-4dba-648b-08df2a405a64
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 22:13:19.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJi0QPjzlsEOrZFXHNM6krLauekc2E0Rpgl+AK4NgDanH6AQy8nnwdDd0VQMjTE5GxlWpC4kytLe/oUdYXZsHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556


On 10/14/2026 4:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] x86/sev: rmpopt_init checks CPU feature instead of CC_ATTR_HOST_SEV_SNP
> --
> 
> commit 4dd9ce9c71a0a62c99cac5b242adafc6f676a4ec
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Only announce RMPOPT optimizations when SNP is enabled
> 
> This commit updates rmpopt_init() to check for X86_FEATURE_SEV_SNP in
> addition to X86_FEATURE_RMPOPT. The intent is to avoid allocating the RMPOPT
> workqueue and printing the enablement message when the host is not an SNP host.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 43e4945e6cdf1..81b9efd55c511 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -639,7 +639,8 @@ static void do_rmpopt_work(struct work_struct *work)
>>  
>>  static int __init rmpopt_init(void)
>>  {
>> -	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
>> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP) ||
>> +	    !cpu_feature_enabled(X86_FEATURE_RMPOPT))
> 
> [Severity: Medium]
> Will this reliably detect if SNP is disabled during IOMMU initialization?
> 
> If AMD IOMMU initialization fails to enable SNP (e.g., RMP initialization
> fails or IOMMU is missing), it dynamically clears CC_ATTR_HOST_SEV_SNP but
> leaves X86_FEATURE_SEV_SNP enabled:
> 
> drivers/iommu/amd/init.c:iommu_go_to_state() {
>     ...
> 		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
>     ...
> }
> 
> Since rmpopt_init() runs as a device_initcall, it executes after IOMMU
> initialization (which runs as a rootfs_initcall). By checking the CPU
> feature instead of the software CC_ATTR flag, it seems it will erroneously
> allocate the rmpopt_wq workqueue and print a misleading
> 'RMPOPT optimizations enabled' message on a non-SNP host, leaking an unused
> workqueue on a cold path.
> 
> Should this check use cc_platform_has(CC_ATTR_HOST_SEV_SNP) instead?
> 

Good catch — correct. The AMD IOMMU disable_snp path clears CC_ATTR_HOST_SEV_SNP on failure but leaves X86_FEATURE_SEV_SNP set, and it runs (rootfs_initcall) before rmpopt_init() (device_initcall), so the CPUID-bit check would miss that case. I will post a v3, which gates rmpopt_init() on cc_platform_has(CC_ATTR_HOST_SEV_SNP) instead — it reflects the final host SNP state (set at BSP init, cleared whenever SNP can't be brought up) and matches the gate already used in snp_enable_rmpopt().

Thanks,
Ashish

>>  		return -ENODEV;
>>  
>>  	rmpopt_wq = alloc_workqueue("rmpopt_wq", WQ_PERCPU, 1);
> 
