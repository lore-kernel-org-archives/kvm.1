Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4173672AF
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600303; cv=fail; b=oDy+sgViYvyGZDUukafGph/G/BH6ToKEiXNGgzoKtefdHyPWvR8L1Su5HIE4Ub1PzjIqikbSw6Ufp9OAmP7RI7+k4Km1+mVVwFceS1cHrb1NbrEfTu65+7duBwgX4QGxt2Va+pQt3Q3PcX/JVWU9icsAXx7drWkJ9nCeeTsgl/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600303; c=relaxed/simple;
	bh=MbTLEEVS3416TwXS0hntCq/eyMI9nbfE3epfMkxmpwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mh6WJipwSxU2fc2OLeqsKH7UfaUU7nKlgpuTdvr1+CVuQQYdsz9MpF+QyzWi2k9PykjkGHMUETBx/TF+r9jeJb5uOPgd/r1jNN03LQ1yNzq+pBhUCPzg9VFHWZT6yIBtIUQHT0jsDWoBgb7FSSGsDLayVQiWS3p2pqf3ugyQexw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HM3JrzlT; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HM3JrzlT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRpbKvmgjd0+Us0UNlshiCCeUgzuHHlAAK0iuQ3+w1hHEGjOXpxRio5M/foLGehceQBeC90NFoov2UvYw4Va+BDiIy0nGqGnVaDEan7fAaS3BuA6ZdxrWEfl9b2kWEsNMAUvDgbhdHySsqn2v5/R0zLDzdvu2MKqEameGJl/iQOClaP3pLg0cCOmNH5SqqTMMeql6coXBNSbeqhRIiaxPXdAYPMi1+gQaYtih9FyG9EMv3f0UULxBNUWz1riGtB/U0aWAWhI7alCAtv4mtPNTQiwrpOon0fYnL4vgJcY135BtjLXd04WAnlVMhdUwkqGkL640d/sU6BOcWsnw67tRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1VeMx4Q0LuF7iikiCzzVcl4qvWBa4TZi2yzdpX6EfQ=;
 b=PWLiL4OkOqHc/FE5wrQJnnjKsC2oBK/7LMcgAgvh2vOaNUcMhwsuBe1RW7F8Y/xdoK9ENvYj30GIMFtSWb5wVGhkp2gDT73w7hbyneP7fVKy+LTCyDl1cqSLxMl7nSioCTh4wFoCknwyGCs5ayHkgSPwplNQKhehYSqCZN6Txs05rXqk7n2C5gE8aQ2JvrYleLM07dsQH6pCdkp+KbsQ8SJYOQzLikXsx7FNH+27wQxxuYPRpZdvYnCj5WWWABQ0jfo3O4cz9FnfSVwWMiGBAlijRgR7WEIMkxrIU9Dpr+5pC1NNFMTrZtyx+YDKE160yJ4vgLD+iR2LSc2U9VCGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1VeMx4Q0LuF7iikiCzzVcl4qvWBa4TZi2yzdpX6EfQ=;
 b=HM3JrzlTTMEsvRXbZVsVFGXdNYor1rFwa9VSWFDcTpmM9LDHwUumafJ1hZW4HJSU8g/y/eYaeg8hAXNdfuvrYEevKF+HPo/rhAqvDDazULVg4gb71hh6Akyy3XbX4ngH1bBbRau+kyhSdwNnqomOmNddKozyG26+7vqgrpuCLEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 23:11:37 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 23:11:37 +0000
Message-ID: <d14a3c91-feed-48c5-9bde-3f0cfe3a8f9a@amd.com>
Date: Wed, 16 Sep 2026 18:11:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/5] x86/sev: Initialize RMPOPT configuration MSRs
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1789594774.git.ashish.kalra@amd.com>
 <7fdf0f5b1be4b561c884c5200d6606a947cbc09d.1789594774.git.ashish.kalra@amd.com>
 <20260916222644.E513D1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260916222644.E513D1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0399.namprd03.prod.outlook.com
 (2603:10b6:610:11b::18) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d74e67-d84c-450d-74f5-08df1447dbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|3023799007|10067099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CriuO/bS8SDdBR9+QgXj/GBVY++8Gw7nKxr5bBYwprUCnH07naYo6KhE80o3Y9fPDExmXj6+cWgr2j5Z6RR56Rw4k9hOLXyOyCKI2sO27NfEQohvbGTDhzWAFdmkEJPEDP75bBQLl8Zb29bkcZ4nGSQ7KEIkLkx7gLd2leKKE0evgk5BEGUy4W+eWLmyYtmJpVBhlAYEktn6lf3RtSXEtzIsCUsghsqjoPkK8ye+Iu57wGhsMcUSmxtGZW9TZYDynnJjN9F5nce00UpmA7QIe1Aug7dbd2qiQ/GRZMKH0VH1j9TH9c3GPR/hNFPd9MD7BtinhWENhZwTNOmV5a5HhGyJWVEzariUuebH2FkNV7E+iOW+BBEf6pKJZ66uWQg9jyTrSFPAXUQwLOf7DRQLwWiUJorjRV87mVAWsfctTOciTJkeLZwLJ3EXgPNudj5klgA4H3ErXQG/nhf9AHJyTKqgrm1baW6AVDvOCswQEpvDV3CId43wJzO/qXJynqMSGriqqqdu+XtTvEE1IN2pVhJh5am4N0NB7oi6oej6fkcMMQkH14/q0sd6e3onlzUDyHIJdmv8BO70Kr5SpV/eT0z/9oUzGiY4jAzemPq0fxXG/aIHLKDwnN8DncrRD8JyVdwfOS9PBY5BWsFIMAa4MRJMv0whATdv+pjy0+yim2E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUVjeGw5L0NzcTU2cS9NM1dWSm00SDJlTlk5UXlZejR4VE02aTFlTnk2MnFG?=
 =?utf-8?B?cW1hcDhnbDh3ODBtTTZQeUYxd2MzczdnY0pxVkRQR3FZOFN0U2pTeTdJcnFS?=
 =?utf-8?B?UEIvZVozb3hUNnpjaG53M2E0WjJ4czRRY3YrRkdBcjdBbVYra1UwMTk4N1Iv?=
 =?utf-8?B?UzV4Tk9oSmdoZ2hVT0IralNpbVJjcmJ1aDFQMitHSHRNRWRCamlZVURZYzBn?=
 =?utf-8?B?NENXZmMyYTJqN1JldHJFTEdOVzhPamxZYWZ1SHFqSGVsT01uU3NaZzdVeUh2?=
 =?utf-8?B?Rm9ZUm11bHM2cWhWN2doT3hXY3BRejZneHVSU3NDaFRzZk8ranZSSG9PTkdl?=
 =?utf-8?B?NDJiUmhabmxYaGUzb3dwWnFpc25OZUc5OG5SblZqQVhBdW45cDhxQzJOeGZu?=
 =?utf-8?B?NW5xdGU2ZUtUeVVsZGE5VlgxbTZnc1d5SlJ2UXBKdG53emFmY3hpOVF6eU5s?=
 =?utf-8?B?WTh1YzEwR3RyQzVyaW5mUnBPK3A2bkxnakFFUndKVzBzS05iQTFnU2JFUCto?=
 =?utf-8?B?VlBYYzNhbnNLZnNIdVlCWTk0L3k5MEFDVWEyeklaK1V6VmJxQUJFNnNTdm94?=
 =?utf-8?B?K2F3UHBmU3NkUklxTjBUTnpuNEx0MlNDLy9MR3RKaFhuRmY3ekVJQjZkd2hR?=
 =?utf-8?B?SHRjbU5ZVEU3YU9FVzVQeDdFL3RSSSsrcU1mVUtYT1lsN0RtYjJpQWtGa0hM?=
 =?utf-8?B?Z1R3N0FURXpoM2EzM3Z0QmZzUkZORXY0NHZpWTZpdHZBVDZkRWNvUzh3eE5Y?=
 =?utf-8?B?aFVmSXpFL3hPd211OFpid21wams1YTUvcmNTWDY2QjgrMi9TbkMwUlpzd2dy?=
 =?utf-8?B?L0NJMnhaYTJZd2FhOEpFMGR1WXdRVVBMNUFxS0s2ZTNZVnVqanJjWVF0dVJT?=
 =?utf-8?B?TWgwSEdTTjB2MkdTbjVwMy9Tc0lRd096dVlmM2xLVFlJbFRCckxTVHJtSU1o?=
 =?utf-8?B?QVdTM2VPRHdvd1JFUDJCNXFiY0J6bG1OVVdBSEJCWE5nckhNeWlsaE9CK0pl?=
 =?utf-8?B?OVpFenkwb01KdHR5MlBudHZHWUlwaDF6TkVCME53SmpkTTE2RUhhS21HdEtq?=
 =?utf-8?B?L0pkTFNITHcweko3bDRSVXdRNWFoSHd1dGZWK3VpWGlZdE9VbXBab3pmQVlX?=
 =?utf-8?B?WGZRV2xjYi9ad3J3V2hoUHk3VkFtbVZZVUpEYW0vMCthY1BtdVpnNG51a3lD?=
 =?utf-8?B?NDFxREU3bnlhZ3R3cnRrbVNsajhtbExPcXllU3pJQXFZQmFsNjFiK3hSNENE?=
 =?utf-8?B?SEluZ3Z5SmVTUlByRFY3R0tCSDFMTjlzbDJaWnM4dVFTMTFuNnB0RGNyb3VF?=
 =?utf-8?B?WWYyTmdXSHB1aHFkaEhmYzRlVmh4MHl0U2tPdzdqenZFRGhGdzJVNmp0REdL?=
 =?utf-8?B?eUtLRm5jdCt6M2x5Vy91c0JhS0lqOHM3NDNJT0dVa3ZGUGx1dVlrenMvVzFJ?=
 =?utf-8?B?TDAydkxqWVJ4SjFheVRuajJ5Z1FCMDVtaklNeFRVOGhsTEJMeGZwNklPekpW?=
 =?utf-8?B?cFpvQnhJNk5zQ08wYUoybjN1bWpZK1NjK002d0NQcEZIQTlobmRQL2Jjc2tU?=
 =?utf-8?B?OE9Zcm1IZXZTTFA3R004eUhEdUU2bk44bE5pdURHdGw0U3hYMGxZS21TNkVl?=
 =?utf-8?B?dHVTQVR4K3V0aTVaTW4xeHgvZ3JEcHZRUGdRUllsNDVqQWVwQ3ZqMTNycFlq?=
 =?utf-8?B?a1hOdTRwT09TZVh2VzNYNnE3MXlJenJ2U2pUOEJncUFuM1o2YkZpMHNoSTlN?=
 =?utf-8?B?Q2VCRzRxTnlrVW03UFFTdFphUUMzQmc3MlBCMWgxeWhTOXMxRnNRR3VrMHpq?=
 =?utf-8?B?bHhOalhJZjA2UFNMVG5Id1BicFlUWE5JK1ZoZGdoeXBOTFBCaXJEWGNha0VL?=
 =?utf-8?B?M2VzY01iRncrbk1nb2hqRXo5NStaQUVsVkVFMXlIbGxxZnpFWmpDaXA5UTV3?=
 =?utf-8?B?eW5JV1duQjNzNzJpR3U4TlNqdXhiMUFDTzV2K3BxWHFJWDJjZGptTnBRM0Zy?=
 =?utf-8?B?STZaOW5ZWW1MS1lNbFBOd3hVOWp1TVpSR0hLNEFHeHF3N0tQSTdyblZEK0xk?=
 =?utf-8?B?WG16aWpTZUhlVE5ScFVwd2hQOUxIQ0M5MWtFU2dyQVJEQmxFN1V4RTNUNGNN?=
 =?utf-8?B?WENQN2J6NW9SWnFhMFVrWWJOSUd6YmJSK1d5TTNSbE9KY1FmUmVCdWFYb1J0?=
 =?utf-8?B?bE5mdVNxZ0liK29yWVphL2VwdUR5S21yOEhGcGRYY0N2NkhjWFREUmtqdzB2?=
 =?utf-8?B?b2RHUW5KSmJYcGlIR2hPcVpmQ2U0SDc1MXFPZEFXYlpGdU9hY1FDOC92ZEM0?=
 =?utf-8?Q?CwZI4wQO6oPBO5gDHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d74e67-d84c-450d-74f5-08df1447dbb4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 23:11:37.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDEbxjOeE3bzFXmf7Z9BWgYEg+VVLWkjl8jAA0y9WECNJcOPYndc5xHdWeC7JCDOhEGUsydxCie52Gd8VABhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872


On 9/16/2026 5:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] x86/sev: missing MSR configuration on CPU hotplug cycle due to local check
> --
> 
> commit f73eea5b303a29d64f9efe740eeba6e570bac844
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Initialize RMPOPT configuration MSRs
> 
> The new RMPOPT instruction helps manage per-CPU RMP optimization
> structures inside the CPU. Initialize the per-CPU RMPOPT table base to
> the starting physical address to enable RMP optimization for up to 2 TB
> of system RAM on all CPUs.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 558f7924a3f85..25cb486ff61b6 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> 
> [ ... ]
> 
>> @@ -575,6 +577,42 @@ void snp_shutdown(void)
>>  }
>>  EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>>  
>> +static bool rmpopt_capable(void)
>> +{
>> +	return cpu_feature_enabled(X86_FEATURE_RMPOPT) &&
>> +	       cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>> +}
>> +
>> +void snp_enable_rmpopt(void)
>> +{
>> +	u64 base;
>> +	int cpu;
>> +
>> +	if (!rmpopt_capable())
>> +		return;
>> +
>> +	rmpopt_pa_start = ALIGN_DOWN(PFN_PHYS(min_low_pfn), SZ_1G);
>> +
>> +	/*
>> +	 * Per-CPU RMPOPT tables cover at most 2 TB.  Program each core's
>> +	 * RMPOPT_BASE with the start of RAM to optimize up to 2 TB.  The MSR
>> +	 * can only be written after SNP is enabled, so this runs from the ccp
>> +	 * SNP init path (and again on guest teardown) rather than an initcall.
>> +	 *
>> +	 * The loop below programs RMPOPT_BASE on all primary threads.  RMPOPT_EN
>> +	 * cannot be cleared while SNP is enabled, and CPU hotplug is disabled
>> +	 * while SNP is active, so once programmed the MSRs stay set on all CPUs
>> +	 * until SNP is disabled.  A set RMPOPT_EN on the local CPU therefore
>> +	 * means the programming has already been done, so skip it.
>> +	 */
>> +	rdmsrq(MSR_AMD64_RMPOPT_BASE, base);
>> +	if (!(base & MSR_AMD64_RMPOPT_ENABLE))
>> +		for_each_cpu(cpu, cpu_primary_thread_mask)
>> +			wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE,
>> +				      rmpopt_pa_start | MSR_AMD64_RMPOPT_ENABLE);
> 
> [Severity: High]
> Could this local CPU check cause hotplugged CPUs to miss MSR configuration?
> 
> If SNP is shut down, CPU hotplug is re-enabled but the MSR remains intact on
> existing CPUs. If a CPU is offlined and brought back online, its MSR is reset
> to the default. 
> 
> Later, when SNP is re-enabled, the local CPU executing snp_enable_rmpopt()
> might still have its own RMPOPT_ENABLE bit set. Will it erroneously assume
> all CPUs are programmed and skip the wrmsrq_on_cpu() loop, leaving the
> hotplugged CPU unconfigured?
> 

This requires a runtime SNP teardown, a CPU offline/online cycle, and an SNP re‑init (rmmod/modprobe ccp with a hotplug in between). SNP hosts run with a fixed CPU set — CPU hotplug is disabled the entire time SNP is active, and the only window to cycle a CPU is a full runtime SNP shutdown. Bringing SNP back up with a CPU hotplugged while it was down is outside supported SNP host operation, so this sequence does not occur in practice.

Thanks,
Ashish

>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(snp_enable_rmpopt, "ccp");
>> +
> 
