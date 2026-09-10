Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F52E7F39
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080375; cv=fail; b=OC+8xCWSXSv+ny5qgWu7TA7n5oXaTz1wsMs1EsTTiY9ahQkNNk96Ij/JfJHz1ssQWA60MyI2cve2eoLGQw2VP1WWzj9UgdqLZ5X5M1sykcV+PHqcoXm0knjwqS9g5NK8ePCl8vUKm9F7u8PMZaRziziIFuAcLAdOoSlpH4QGznw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080375; c=relaxed/simple;
	bh=ZubKA80yuK02JjNIyPTgdgwpRuTXGQgQ1y948HaaHTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+HBTVY/htUMt33cp725mR8DfNXlkwMG5EUcnsUOz2s+qT3DRzfWeGNGtixQ2CUtKNaAheksb+7QEWGrlzt1VkmztlfGxRkkCL8ri/QM3u1ydex+oDQWNZpxDBf7LjkaJOKc95Qm25JKjKRxdLvGxMNQ75LMHo2qoxr6XQxidDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OsR5KBnj; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OsR5KBnj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpgt8tcr8gxWaGlWlBxpga2zBQVgtcfoIGSm3DkJYSuyeEjJBrlMo8wCklwmZDhTtcMBwjx8lAk/WQ5gGgod/Pd0MXs13WCyIArQTh9wD9I5Muh/UkprBOq7uLCtuFzKW1OTKkLVngGSY/rVH1WhyiMSTnJnrLENNwIbVVgpVCbRoxa706CkRroLqcf2DIa1iBS3oern8J4GYLnnCWP3Zb27DQ6C1mYtZy7BwljeoXDMEwEzQfuL7+93azMpYMHyg+lSsb/UIT8+pt71chEJwKMwQz6xnjfrNR2J9JWHIiRIKHk9IgrzokPxf2waX91IBh0XGXAuQdN2hDn5xe6XWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC1ymHsLXRJwO2Es7w09jvqTSoilVP6AMn/Ksu6ykgk=;
 b=FbfMHSv4JhOt0H831fVG2JGpGb2EhFF+MHXDiMHgaNQRjP9vW8Uk2ID6Ju2MzTqHDbuZGKGZlp3xUolQIM9YcOrys9mNEF8tWD/a8CCaDh5yba430v0pNhM0eIx8XNkfu8O75sIK7YE7IMuA+KAo1OcIBX2zsYcEvFiPisYM51HC3lqMz0eYVVo2SfY0rHmN/dXvLLSFRJcU9/047ovaldQ3lacCJJXUSe1ko2IQEap0+S/1hVO9883FCfaY91o9smBDupHbfWErgttYz3YBjBa9r5DwC1nQ46PHO1SEO/1yG/qYDN7Jg8GO7mV7JNgp8ZC5pDThd+8f6ESQ8t+m8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC1ymHsLXRJwO2Es7w09jvqTSoilVP6AMn/Ksu6ykgk=;
 b=OsR5KBnjPJkle3PRLcgshxkxpg62pc0iUpMUoTdesdCTqB3NxGAauH3YmF/f9uQ0ROpheCcKYA39rWK4UROIaPkBBVOSjhYxeGY4+ni1MQPlzcTid/uNGhnbANLMn3vBLsECbezLghP55j4f61ASFNzUAxAi+YIZUVQHuWjEj9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 22:46:08 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 22:46:08 +0000
Message-ID: <4d095cd6-a716-46aa-aff2-e7533d1511b0@amd.com>
Date: Thu, 10 Sep 2026 17:46:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/5] x86/sev: Disable CPU hotplug while SNP is active
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1788984053.git.ashish.kalra@amd.com>
 <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1788984053.git.ashish.kalra@amd.com>
 <20260910222518.AB5191F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260910222518.AB5191F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:610:11a::24) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: ae51ef44-d58e-466c-05d8-08df0f8d4e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|10067099003|5023799004|4143699003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	cW+6xiAx1lgrlfNjUkSVxsh9DyNFwYxVL7EYBUtbJQBszUar3G1tMu/30hLWL/lJ7pkS+Mh2v4q629XgFU5vj6J4btaT0Ol5AnFzxw6HKrsypjFV3hU5dbre2pMXKS/ZP4HTqQgt99YHhGnWJnXuRCgovOPsSEaLQQK/BfyV0hP1uEV2/GOSuSqqSagI8hnjw6XSG4YoJnsmwJppqSuayzMjR+zpfYbnMTU5wqZKDX96fBbg9LBYkf8PXOdqkPWY5GKS9Y5kEk3C7F7TbtN/KLJP9qSqcnTLxdfDAqFqmJqmayEQih/qFJOsmQGqe7mCpmZFPuD4E4cEko8sqm47hXNOrcqkfKN3kkQrNJwXQTxy8sClNWRtDLgxPSmFsbMIK2t0H+3d/J26cEd2FQwSGxUQrlDe2EDJ0BdPHMf8GlQiszEDNMiUtI8hSxfH5zYRQK7Ci0EkVNHywC+1I00vCmoe1Me0KjsdN+bujo28PTj/EbC17kICqQaNEvj3EWsqiCiPxNqwayt3TLNY9sME0BAgO8ghfwI+eWAFkOflLDdG3WwxiqBnV8BLxSwuZg/Vc15RstDsTARi81UPT0PlLtXYzpz66xwLdpks2xkaJcaCYorfVcivzds3brk1ZcI/XZukC2jTRxYYUZcjLzL4PEZI2NTYroMwAwdCACaWLSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(4143699003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpJT2NjYVgrcVNyekh0YkxrNkZsMjU1bUZZL2FaWk5SWXp4S3hCcFRNUTZT?=
 =?utf-8?B?SERIeUVsRzhWWjU2VjJDTTZlRStNNWU2eWc0QnJENkdMc3lTTWJybHFHUGJa?=
 =?utf-8?B?Vk5QU0FRYk5GMGFhNWlwc1RGeURvbGpGc2IrTWVKYU1XTDF1WkRtM3B2QTFy?=
 =?utf-8?B?QWE4WHB0eDFBWGJ6VWxBMDRzbFpRSWR0d3lsWk1xdlV5UEFQRVF5YUZpb0U2?=
 =?utf-8?B?Q25PdmFFSmphUmg3emp6WHBFTGVDYWw3L3ZuNzJLdDI0WHBhTTA5WnlObGJr?=
 =?utf-8?B?YW1WbUNGMGtNMlpWNDZTZ2V1QnhMU2ZEdzVQRHJWdit4SlZ5cE5RK2N3Vkh4?=
 =?utf-8?B?RHRGV3dNTXgrRVhjOFNMdW90dGZyUURHWkZsSHJUaTNDVU5CN0ZFdGtGOEZi?=
 =?utf-8?B?aXkzQmJuTnQxZTA2NHAzNXE1UlFWTG11Y1IzcllWL0MyNlNydEQwdWtleVl0?=
 =?utf-8?B?aHdXYlIzRGphbzRCbURZeWRUWDkzQXF4ejVqWjJSRURLTjZWRG9uaU5kNmhT?=
 =?utf-8?B?M1dlOEc2cERQUkc3ZjVlek1ZeDNzOTV1d0hSNWNwOTl3ZzFycGhWYzdRbFlj?=
 =?utf-8?B?TU1YV0hBQVA5c3NwWFdRUVpOSGVpYysxUS82c01uMnI1bHFVKytOK0RGZ1pp?=
 =?utf-8?B?VzEyMmhDUWU3eXJrd2hxa25zcENvNW5UUm8vR1pGaU1ZQ3dWTGNOdXQwOUVl?=
 =?utf-8?B?NCtGRjVwaXRndVBLbmFoVXQ0c01nQVVJb2ZHaU16L0ZFK25KclcxcnN1Wng2?=
 =?utf-8?B?cnY5L2p2ZG5Gak5aZ0xVVS96TW94c20wYTlUTUw1UjlLUFdmbEZMYUhvRTVE?=
 =?utf-8?B?Mlg3QTRzQUoxVUZpQlN1eUZLRk9tSnV2c3F4Uk5hT08wZC9PVFNUMjh4eWFn?=
 =?utf-8?B?YUpSK25hS0FiaFpGaGgzRzI3Q2JjcWx2RTVGZkoxNi95elZwOGcwZXRlMEhW?=
 =?utf-8?B?a2dsTFNsckhBbEozYzl0OUJEVTEvZVVQa3p3UEpiU0JsdW10RTRpRUtCaDI0?=
 =?utf-8?B?VkRHUFVrbDU3cDJZdnpzOXIvS21nY2YvMkpURmIzNmx4OUQvNlVBTXIrRlhX?=
 =?utf-8?B?bThlSWVlVmgzUmY2TnVZZGE5Szk2NXNZblg1UWE2aVpGT0s0TmwxeDNQTWkz?=
 =?utf-8?B?bFB4UEZHN09rWHdZN05PUXBkR08wVExYSmlxK0lPZDFCb2JWaldGUGtDZDhZ?=
 =?utf-8?B?SGt6SFRoSTlhVzZqaTlGKzRvY1Uya3Z6dC90YXFvSHRlQ1hidjcwbVV1Si9t?=
 =?utf-8?B?S3B3cDkraHNDeGIwMjFtUm1LSjVtcHl3TWhTalZjbTlLTEFOcTdHdSt6UnVT?=
 =?utf-8?B?YzY4d0pTR0JjU003S1ZvenJjZmhBVW1vbzNFS1VYVGMrMmYyNmNlRnlsZXhk?=
 =?utf-8?B?dlh6cjRWbHdjMDdvQWVyWFV0SjU3c1c3OE92MWc4UXlrQVk2TmpoOXNVa3dv?=
 =?utf-8?B?NU44MXJBZlFCUkFOVEZOdTFNUCt0R2lFb1lQN0RscU0zQ2RGQ0lUNERrZzJZ?=
 =?utf-8?B?N2phUVFFVlp5SlBKOGcvNFVDdXAxMmtvU0NBTG5ad3o4VjZVNnl3dExaaFoz?=
 =?utf-8?B?SjY4OW1FWmJrSnJjQ2twdnNMM2V4ZVNOUVVTL2ZTc2N4MmRTa0p2T3dxY1ZR?=
 =?utf-8?B?clVwTEZKcHZEYjZmOU9VNWw4OVVOd0QycHBORVc2VXdCVC9Tdmg3c09QWGlO?=
 =?utf-8?B?c3pTSHcvTlFHdG5VeFJ5K1B5L2syalpVOGdScHN2czQ3ZXB1VWtDdXQvczFL?=
 =?utf-8?B?RmV5VVJoM1ZNcTR2MkdmSGRXSlFaUkRmRTlLMEhJRUpQYnJpb1pXRi9adjRw?=
 =?utf-8?B?OWtxWHRoQXltTkFBU29sZ2NUemlERTl3ckdYUW01VkRFcnUxZ2NWMXg1d09O?=
 =?utf-8?B?MkpPWEo4ZFc2N2FKWCszWHJmTFM5THRmYyszYUdqcGFpeFZHZ1NRdnErM0lk?=
 =?utf-8?B?WlpMK1k4VXo5N2NBR3BoM05SNkUwQ3VYSEZSYTQyYU1NK0F3U2ROdWcrc2VC?=
 =?utf-8?B?bTBYaGVHR211RUpkR1ZoemsxS1ZWdFVia1VrSGdaZmlmdmdpN2M2TkZkdWxP?=
 =?utf-8?B?Z28wUWJJSWk1TmIwU3ZsWTZSaXZtVVhteEV4bytMRHNHZDJmYThkY3c2TUZa?=
 =?utf-8?B?c3p0ZlRIR3l3MGhUMWpNaXozS3cydkVTVjd0cEk4UXhyb1ZZRFVoeEE2enhw?=
 =?utf-8?B?eThLRG01TzdzQzB5MFNYQ09aMTNMQ3ZndlpwUks3UzhKYmRCL1NOSGgzTXBS?=
 =?utf-8?B?ZDhKUEFPZzk0MGs0NjU1WEJtMzdFd0JNdDRDUExKd3B2eWRGNVlHTWdyV3Bj?=
 =?utf-8?Q?yAEg/kL4hBXbtFVv+y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae51ef44-d58e-466c-05d8-08df0f8d4e44
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 22:46:08.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSWSeIaQ5SSl94THMw8YVWK5P+w9rcV8Rw0HQC2kQwrAihGCt+keqxHJjidutY+gLdVCVsV66BmkLvh6xIlWmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856



On 9/10/2026 5:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] System suspend/resume bypasses cpu_hotplug_disable() and brings CPUs online without SnpEn set, breaking the SNP invariant.
> --
> 
> commit 0243c46e8f299e3de42fbcddbc4c7bd93fb68c65
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Disable CPU hotplug while SNP is active
> 
> This commit disables CPU hotplug while SEV-SNP is active. This ensures no
> CPU can be brought online without the SnpEn bit set in MSR_AMD64_SYSCFG,
> which is required for hardware RMP checks to function correctly.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index cff285d8ad8e3..558f7924a3f85 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -526,14 +525,18 @@ int snp_prepare(void)
>>  
>>  	clear_rmp();
>>  
>> -	cpus_read_lock();
>> +	/*
>> +	 * No CPU may come online without SnpEn while SNP is active; disable
>> +	 * hotplug here and re-enable it in snp_shutdown().
>> +	 */
>> +	cpu_hotplug_disable();
> 
> [Severity: High]
> Does system suspend/resume bypass cpu_hotplug_disable() and bring CPUs online
> without SnpEn set, breaking the SNP invariant?
> 
> If the host initiates an ACPI system suspend (e.g., S3), freeze_secondary_cpus()
> offlines all secondary CPUs via _cpu_down(), which bypasses the
> cpu_hotplug_disabled counter incremented by cpu_hotplug_disable().
> 
> Upon resume, thaw_secondary_cpus() brings the CPUs back online via _cpu_up().
> Because CPU MSR state is lost during power-off in suspend and snp_enable() is
> not registered as a CPU hotplug callback, the secondary CPUs wake up with SnpEn
> cleared. This would allow them to bypass hardware RMP checks.
> 

You're right that the suspend path bypasses cpu_hotplug_disable() — freeze_secondary_cpus() uses _cpu_down() directly and ignores the cpu_hotplug_disabled counter. But this is neither introduced nor affected by this patch, and does not apply to SNP hosts:

1. This patch does not touch the suspend/resume path. cpu_hotplug_disable() holds the online CPU set stable against the regular (sysfs) hotplug path while SNP is active. The cpus_read_lock() this patch replaces did not gate the freeze/thaw path either, so suspend/resume behaviour is unchanged from base SNP.
2. SNP hosts do not support system suspend/resume. It is not a supported configuration for an SNP‑enabled host, and there is no path today to re‑establish the per‑CPU SNP state (SnpEn) on resume — snp_enable() has never been registered as a CPU‑hotplug/resume callback. That is a pre‑existing property of base SNP, independent of this series.

Thanks,
Ashish
