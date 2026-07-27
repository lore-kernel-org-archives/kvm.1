Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF242B303
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185053; cv=fail; b=DOSX58xGDCPOm0fE20bwWwBJAa/NJoFVViWCclGEDw+7nltTQpBnbLf0HZpDoNYTTgTf0Btf1DknyFKkDI4Cqk0fbHKQ2xe7i/r5gle5g9thBLJp3CiNetcFW4skLn2fp7/tEbW3IsSGafBrgVCR8sSG4k4BMhfktcrR6ip+Ofc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185053; c=relaxed/simple;
	bh=70QAUoh5qlIFFJL8633WhfVWqD5seRdvbzleynZPlMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=INAteo0ORW9VA3Dk3OZjsi1JVKzlahF8A/O0ApapaZISWdGKHgXKBJ6d+bSkPtQ9CnAeyBsjoqhn2vwP+/VqfIKeB+WuJ+o15xfAJb9P/9azicHVdT2ftKlJsDraAn+BEUo6XXzdwr4M1Kb/QaE/VAZZLp/Y2P+j0rDOtAp/Wu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=il2n2cKt; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="il2n2cKt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkZxPqyn+gQM308gsIenGLtPm2E3XVu9gEezd5CxheddjrGb+PqUfRJ18gHBgN5khu2O2Ku/DRWg6lEnCuivIQJ+QbytKFo+v9pxmOVelwxAgn6YZKwFzAwdEuo7SyLA/cxgpio01byY5xZrQf32C+XQrJrQn5ppHAfIacbFVu70erti2hadh8t+MLgOsPDRn/0w8tDxQ9YF+J6MCkc5TGX9n8GZdJMoX5MDz8emTIAzok64HSuvNzqw7hyEOHS49Pa8SE/76GzGwepdZzQbl6VCDZ18XEPMgdMWfuffeOEWIlGL0WVKzVDWS8VKs9o4kL1mKitJ6KAaF6yPH7PJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFitPCOZm8+fn6cR3fFPV7viu8es24RZUru0nqg5FPg=;
 b=hF6P36aCC90YeECrb9pGE/ZobqtnsqjHaH2h685sl7wKV40aOPkXSGQ/LwZcyMma+Cp/rWginUZ0uMeTq9JZm1+eknWkArIr8TW3UC7tNwo0rGjtxzYUW8Du37tVLSWSwzbujs8Cdb7fiBJ3aGitmcht9YgnmRILj6u/Bnx55aFw2ZJxNDp+USaFuZOxmXgRv5ITI1ZymvO3xfePIS90Rx1lGVQ/wGli8CSN1tTvA43l+zVOBxIdchXVTWanWRXcaRGrun6UEak7kpo+wUIhkoSm/MwiII9XmSLBKc5HhQeT29YRgUL8dhQJicr3z4a4AqAVGRbrkTx4y5w/++xE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFitPCOZm8+fn6cR3fFPV7viu8es24RZUru0nqg5FPg=;
 b=il2n2cKtI8o6qOFmitdWUmZhHwhF6NOYH4G8qnEkyX230wwTcn90VD55oP1F1nOlirx/kCEjAd9AnawkyH79T008DaMe4JQAAP3I3/ap7fGsu52z/ArgYLuX/0VSe194+IsEIp9DI2AUk/uwm/fIBNSk+EZfXaHBXxODVwO8b5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:44:03 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:44:02 +0000
Message-ID: <8aaf5794-e052-4a19-ad28-b3c75752dfa1@amd.com>
Date: Mon, 27 Jul 2026 15:44:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/6] x86/sev: Disable CPU hotplug while SNP is active
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1784844080.git.ashish.kalra@amd.com>
 <e1631971b3862bcd6043199feba3df51f3ba336c.1784844080.git.ashish.kalra@amd.com>
 <20260727193729.7D8E21F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260727193729.7D8E21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:8:243::12) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 832d9677-59fb-4b9c-af09-08deec1fcad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|4143699003|10067099003|11063799006|6133799003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kel8zh5yQeACgwIRAcPaVky0p2x3tC0OZJcSlmWaeX3iNHrSEDDSd5oibbjHzxJ9inZWU5kkOWVhjI+I7J+Ql9FUElXW2RU08SwAmwT5SJL7FNsG/a0zb/MmD/R3qyxMwgRwrKRia8kQekwvHQxsiZhs8Tn9yha31JTWR+jN+1ccLlkcdhfKkZqd84uCF0zg0Rsja09ZEkn/hVdzljxKYQUEUmxUuPhvlsPCPcTQKNzDHG5iGocNYIh2X8bYQA3YNvulkHDB+lNweIEoKkpZxMODyjpkIh+VQTgnHB9o0DmhcCDPJBNo3Mj6PaT5BFVGkZmB+vgqRKRkIFvFEoCZj+8YzUxTRix6yQ8LBBNUxuQiWC9+q4DFWdNTQE9Q5piSTYJAAI1fkXQn6kJTKlcByGqDw6LTdbvH+S/2BWg0fGi/I9nyQ70iYKWhg74Z2IjcMXpsHu2iDRsgZQPnRLQ5vPnZ9zIuciAiTIR6UZjfvivrunef0yDLCUdYbyMUjA2vnT/Hz7epc8f86fCsJiOVH7Ny9JD6hgf1CB7tHJPGb+YvmXLk79NzISmXw+bVDLgQOdFQwvNsSlE4308L3rKvf5IWMAK457rmDs0Ill1pFdyWtmM/eqqvhMzsue5m0TtfS3Mo2Pu1LZH8ZbbtGm9tLAxQhXfrIsbsfftKfIcYp8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFNGZmZ6NVE5OHFRV3pBbWkzcHUyVWorb3ZTRC81aW9OM0VSbktubzIzeFpx?=
 =?utf-8?B?bHZVUkcvbHJvdlpRYlBkNTBGelozQ1hMaWRsRk9mLzg3d25haHNkY20yWFlP?=
 =?utf-8?B?VzBIUGlFc1dsTUpic2lScDBIUXVoTXdxQ0lQeSs4VFdxYUFhaU9iaXhiWVdK?=
 =?utf-8?B?MmI1Qk5RZC9LYzFzOE82TlVyNDJYajdwb2Nkem5iOTJFa0h5NGRuMUZPamRr?=
 =?utf-8?B?TEN6U00rMGQ2RnVqVDVYcE1NNG9ONlRYWmRFcXlSb0h6ZnJjdTdlYWNiNlIw?=
 =?utf-8?B?bWdMNlBOV0FLY0pVVlBiNmZjUUtRajZBMHJydTI3cG54K0ZVK2lxZ1hXSUVz?=
 =?utf-8?B?Z04xU21qMWJENnpOeWsvN0RJczNzaWdVaC9Jak15MDdFb3k2RU4yMkgzTXJO?=
 =?utf-8?B?bG9iQ1JjeVppbXRLUitEWGF3bHBuN0tuNVZMVFlsejV5ZG5zbzZ3a0NpeFB3?=
 =?utf-8?B?VGxqcUhmbE1kQ1hZdWphU1p6QldiVitLREFIVHcvdGtiMjFjUnZLNEdDcko3?=
 =?utf-8?B?SWtYWXBIcGljYTZXK2t2VTNaUWN4OVdBaUxobXhLaHpEZUhFRktoQy9vQXpz?=
 =?utf-8?B?empUazY3TFNHY3JLazQ5cWt2OCthdmZrSFFQTUhUYzgzNG1BbTVRMkoxdXRV?=
 =?utf-8?B?TktHbHhmbnJZUlNlVDlKUU9JSVBpN05oMDdodm5tSnZUNGlmUlR6bmEySDFT?=
 =?utf-8?B?cy9iVHQ1RHE4OUR1aGhmNXRUcXV6aFYvWU5mNWhFVTJ2b0JIbXYrelF6Rjg3?=
 =?utf-8?B?aUErQlhML0piZHV1M2k5RlZzVXBrQkxLVGEwYmZqekhLNHk2bENNMXlmQ0JL?=
 =?utf-8?B?d21jNTlQaDI2S3dQYXRQUW5ia1E2UW50Y01ERlBxTVBudnhuU1RZQ2tkUExX?=
 =?utf-8?B?THdlbEwxK21iSUpGeWFFVThRVkVzclJBWUZJak1pWkVSUnIxbkRkYnovdnFX?=
 =?utf-8?B?ZDk0MExFWU01cmdsblZTZlVTLzhZUE5zYXBlSFFJdGxDRjVZaU9DdmtDOFIx?=
 =?utf-8?B?amQxbDlhYUp2V1ZLWkM1QnZTd1VnQ1dhN2Nib0JZc0JXLzArcVMwRVJ0bm9O?=
 =?utf-8?B?YVhiSTZ1TFUyeGlmN1QzUzJZREtieC9rZU40TFVvdGowT1NqdDg5djRPbEcx?=
 =?utf-8?B?bTl2SmdDWnJGWExuaUpMRFJOY3JYQXFsQWR2a2wweUF6Uy84dXJ3OTRhUHVJ?=
 =?utf-8?B?aCsydUlYMVhQTnNnOEVTMWJJZDVpa09TT01MZlNTY0w2MnlYdjNCSHRBVFg1?=
 =?utf-8?B?SEpNRjJlbWFnNTEwZm95eTFBWjVaYTJXZkVxVHNtZWxsSGN1VHhQSGl6Vmxz?=
 =?utf-8?B?dk55ckRjNjZJQmxUeDJyZ2hxUmQrekZkTmIyRVJZVVNtRUFZRnBTVk9DbFQ0?=
 =?utf-8?B?LzYrSEErY3lJL3ZxeW9lNWdYNGhCaGFKYkZzUThIQjRtemhwY21PcFFqQ0pZ?=
 =?utf-8?B?b3VpTUcwd1E4UUF3WFZiWmNMOVpXTjcvYVN0NUtkVVR4QVYwS3Bjekp6SEZ6?=
 =?utf-8?B?NGJydnJtQk90cEZhcnVRVXhUTVg4ZjkvVEJVSE9HS0RJdVQ0M2kvNTlxbGI3?=
 =?utf-8?B?Z2U5NzRZRlJLTm9PTDRKMlhBU2o0ZXpRSE8veFhyU0dLaCtFaktua0tRUkwy?=
 =?utf-8?B?Y3JyT3ZadWRZa1ZoajF5SzFkOXhwSEU5bEUvR0FlRGo5Vks3MTFnZjZ2VzVw?=
 =?utf-8?B?YXNQaXFkNWJ0dDZmSS94Skh3a3lYQUgrdFdwODR3N1JGU2JDZE9qcnZjSXBL?=
 =?utf-8?B?SFMvVkJhaVgzNnZFeVFLbzJoOFlLUC9FSWU5ZERrcVNCb2lUdGt2dHRJWlFW?=
 =?utf-8?B?NkhKdDBiakxVNEd0RkZKOVRSQ1VwSWVhVEY2VnVyUEtvMkw2NjJCQVFyOGRv?=
 =?utf-8?B?YW9YdjIxaFlxREI0OW5kaEVkZWwwbGg2WU9tRjVYdkloTFFwM3IwSzRSNVVp?=
 =?utf-8?B?WjRydXBBMDRFemFPNzhTLys4RUhpeWhSY3ZlR3BYdUpaeGFKUkpGNk03dHZC?=
 =?utf-8?B?YnAydzZOWlZVc0I0K0I0ZlA4VDh1c2JqOVk5Y2hCRnBaUVhHd0Z3SVNHYWov?=
 =?utf-8?B?aDJtaEpkYndGZFphWkptUGJ5bnVJdkE3cFN0WGN3V0MvdVVqNU9SMXlRMWpv?=
 =?utf-8?B?OG5vVDY3QzkyK2ZaenE1a0Y0aStlQ2VkVSs3MFNPa3dkcnczV1l1MHdaVDBU?=
 =?utf-8?B?Z0tMVis5dW1WQ1lXQzJFUFZZejUrUmJzUnc2UDh5RmJPVWVuZnh3WGoxMSt5?=
 =?utf-8?B?S1A1allQdS8wdHZ2dGJlVlBxKzZkVzU2Z0Ywa0xyWnhydXNDVk4wQkpnSCtv?=
 =?utf-8?Q?0hiANHfi+Eo0VMwFL1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832d9677-59fb-4b9c-af09-08deec1fcad2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:44:02.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLh12lN7AvA5hAA+tMa2W4L+8IxNrMdJpG/26l3jTJjPgVfyWbMRGSCWBoLvwx6x5McukzjJ/di/LSb/tfsMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034


On 7/27/2026 2:37 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] System suspend/resume bypasses `cpu_hotplug_disable()`, causing secondary CPUs to come online without the `SnpEn` bit set.
> --
> 
> --- Patch [2]: [PATCH v11 2/6] x86/sev: Disable CPU hotplug while SNP is active ---
> commit 2ca360619d15fed203ba00f43d20453130503df3
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Disable CPU hotplug while SNP is active
> 
> This commit replaces cpus_read_lock() with cpu_hotplug_disable() in
> snp_prepare() to prevent CPU hotplug while SEV-SNP is being enabled. It
> additionally keeps hotplug disabled as long as SNP is active to ensure OS CPU
> hotplug does not diverge from firmware expectations.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index cff285d8ad8e3..e2f69fba09389 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> 
> [ ... ]
> 
>> @@ -526,14 +525,21 @@ int snp_prepare(void)
>>  
>>  	clear_rmp();
>>  
>> -	cpus_read_lock();
>> +	/*
>> +	 * Disable CPU hotplug before enabling SNP: no CPU may come online
>> +	 * without SnpEn while SNP is active, and none may go offline during
>> +	 * enable.  This keeps cpu_online_mask stable for the check and the
>> +	 * on_each_cpu() calls below, so cpus_read_lock() is not needed.  It is
>> +	 * re-enabled in snp_shutdown() once the firmware disables SNP.
>> +	 */
>> +	cpu_hotplug_disable();
> 
> [Severity: High]
> This is a pre-existing issue, but does cpu_hotplug_disable() reliably
> prevent secondary CPUs from coming online without the SnpEn bit set?
> 
> System suspend and resume transitions bypass the sysfs hotplug locks. During a
> suspend and resume cycle, freeze_secondary_cpus() and thaw_secondary_cpus()
> directly invoke internal routines that offline and online CPUs, respectively.
> 
> Because snp_enable() is not registered in a CPU hotplug callback, if a
> secondary CPU is thawed, it appears it would wake up and come online without
> the MSR_AMD64_SYSCFG_SNP_EN bit set. Would this leave the system vulnerable
> by allowing arbitrary host access to SEV-SNP guest memory, since no RMP
> checks would be performed by those CPUs?
> 

Pre-existing base SNP-host behaviour, not introduced here (as tagged). An SNP host doesn't support suspend/resume: 
SnpEn is set on all CPUs once at boot, immediately followed by SNP_INIT, and that state can't be rebuilt on resume without a full re-init.
So a CPU coming back online without SnpEn can't occur in a working config.

Thanks,
Ashish
