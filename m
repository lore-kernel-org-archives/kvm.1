Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581865476FC
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657686; cv=fail; b=rUZsrr+Zt5FrDdsNJIUHC0WzeENV9Uw3NQveOCDYfEGOR4NmHqCrXUjSNjODtOpHWU3J9ytvtld4xvXoj8wm8g3EuGvtEkh0CXolHDZOAj330F0lS7Y2TEZO4EagFT183o5XYeeIxhRpw6OlPbLiYZbN9b+NNWGTAPfTd5Gweoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657686; c=relaxed/simple;
	bh=41p1Cfv3gekpUtFNVjnN9GHs0vyUNt8jjXXvj3QdBCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSEIql4qvFlyhcXlkipqFtwD4FA+5FgwZMaawm7UEyGQR/DGNjNfgyK8kJX4KN7vahhW+Yrtmf94pkNftRK0pUo3aEbTDmN6wYudIdYjSNoVVi1Ta13XHbDO1k/9fWkvZuMwH5MBTrwwXiWAS8mPahyUA2ddP3rkPomQVfnz8Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TRIrrU0T; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TRIrrU0T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvRYjcS4zkt+eDh/pa9g6i2LJaoeR/Ces56LTLuxlgVbu4M0xEMOcAiCYpyjpRLkjFAbd29rUFJJeGYjui6LwfiWB9qNuDVaIl8oWj8vTGS9tix9RxhkhwU7ee849G5r5itHCUqTu0SNcK7PcbWUmQX9w7xSty0PpdIQ1B6tsXQ+DeBQmY2jraYSPvZj7aeYXGLBg3sG/02uJfN/EPHsdHzU+M6ybnUdVP4qZivC8HqgimXhLmdeEczxpL379sw5EWMlo2NW7QK7NWDyV1tjCohHlfdzKI+LDcNRUNMEghCHh/53DstbIq0pqPgb0GO+Dvuds2mrHcyY2wPr87onuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HXkVrRORe1bu7HBDEia69j5JMx8TRMSckUvvBhPCtw=;
 b=TJgarkfprMi697QfTQF0w3EV1KCb1PDiQ/9Hnp2yaIoEc4/3lJ88j8/2RT+KR3xV/i+8Uum827vjpM4jbFovq9Hs8RNszSlznJW+i9euBBmuPr5ir/jJmWD7UZcoT/s1JjFs60KHJXP+cNyKaIxfNdHj0PMqAPdzyHjk9h3lQedDZ8pyvnjTzNaljxaHTYqeFPEDWg+C/vRczfB9LbGZnuYVh14zph12qvkEJTLdV/UM8BhWy5DNWEwksNFCtNbJrqgSaSnXbAhSKb6E6gNJD8VBVc7VYMyhGrpeye59OnnPNjmWPsdYO2uZEjivkq+uckABZjepBo3PwRp0JNbn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HXkVrRORe1bu7HBDEia69j5JMx8TRMSckUvvBhPCtw=;
 b=TRIrrU0TW2yXSAo9DitPSrUsIRKENSGkjnb0mS65w53y9b9JarEM6xgB4tgqouL32ydCCDNExNHb3fooQtZj50whk/cHA+RFfha8vgBE8wOUlr9roBtYylwxkBwrcUcCqjC75mt33Tw5q+ZMRvWxFtLa56swaDQITm+Ah4kwQ7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 15:07:29 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 15:07:29 +0000
Message-ID: <639ea1d1-76d5-415c-93f4-e516d6873718@amd.com>
Date: Thu, 17 Sep 2026 11:07:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: SVM: Add host support for Enhanced SMT
 Protection
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1789399214.git.prsampat@amd.com>
 <df22a9879871f5f926ff74b203e06b58ed505503.1789399214.git.prsampat@amd.com>
 <20260914171316.43BC41F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <20260914171316.43BC41F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0125e761-75b6-4566-b2fc-08df14cd642c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|6133799003|3023799007|11063799006|22082099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	4CliXO7oFBcfGDlsQ+lH2EsDHlhyxBE/onV6gHY7Io9MJKgF1AAsVZvDW/Z76T37cEfnobiSE2Zau97c/yT1j975JDhhyWU12VPLk2JKLAY7rbzmUBpvlmlNpkmF1OT6cbIWVk2Cfd8E4qojQMJi+AxYqT+vSh2ftf7NL1zqy4KXrXhDqTQ2ecFHUdd9f+H9BzFjuZwLTHg5QGlaOf6cH8TG/HXXao2Y3Wci3Zui87BjBcpr9+q1AcTepHmhBLR5/5jZYYRR7bU1i6q0d1Asntw4vSv95BmEGi9b6LylOA2S9A/Tp53FgvMpcqdk2lLANeErudGz7CwaC0hPF1avcfwU7Sac8JSAvRwzMC9IXqpvgHqlsE9hqq1rf9lp0qZyC8m+Wgf+AB8oW6ujIYhFqnLP+lhPPkXZVGSWznHIApbkVq30jQP83/oeOFxUwpIVC6fxUGkenkgI0v/lGkATrKJSvBpYyBLDFI/alCpvXs5s+8w2hwoSZ9Q+ndnIy9hqXrZ1AnCnVkecZkxVI+NEAcyUl7M55BiaGR1irIwwVCQUupSjlgXEiooAmygJ3cxI1DUlF34zPeXfee9QSfZGpkszxLJqS4bSU6YfgIWVChc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(6133799003)(3023799007)(11063799006)(22082099003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmdQMm14SmE2bzlFV25abG8zMmJ0RXhFM3F4bjBxdGZKb2wyNSt0ZnFpRlZt?=
 =?utf-8?B?dy90ZE5MU1JmUEZEbHEyeFRVSWcyUzRDUXFWQXBabi9JbHJra2lBY0F4VFBP?=
 =?utf-8?B?dk9ObktlaTRoeG1TcGJEZXUwSmZ1UnB5cGI4UmZvRno5ZCsySXhiNGttYUpU?=
 =?utf-8?B?eCsyWUh5U2tKenBkcGYvRlIrREZ1dUVrbGpTOXNjMUd0bjJwd0F1QU96NlhF?=
 =?utf-8?B?RDVBY05Hb3RUblJhRHFBUWhWVmxqWjlYclhOUDZvZEdWTVUwTml0bEFNM2RN?=
 =?utf-8?B?dThzVC9DTjlmT21LNTBkTGt0TDNHT2Y3SHJXdWE3NWUzbEtqZFJJZzlpQ0tQ?=
 =?utf-8?B?SGVPNVJCKzlwRGt1dDQ2VXR0UDNwbmVQMzlpMzlTU3BGajFVbERLT1poWC80?=
 =?utf-8?B?UVdLTFFGWUlFa3gyREJwUkxQdWNsdlJ0UmFBaHArcU1tMm5qQkhsT0w3VFdx?=
 =?utf-8?B?UHkycThHVEJhM2NJUUJYNVRmcnZZTE9mNUszS0dkSzZNOGpjWWNVNjlSaGxn?=
 =?utf-8?B?THZzZUJhVEpqOHoyNFYrSVlIZCs1QXFpVzljSldJVy9WOG1adXNJVW81UnB0?=
 =?utf-8?B?VVdVSjNrTS9VZG5mRFBTQ2pnZFdnSmxhUzl4SkVzaE1jZllGS1M5ZE40QmhX?=
 =?utf-8?B?K3ZlVkd4OW5LZkZRak5XRDNEckNDU1lGUHJkYUx5cEcvN1Zna0JVU1hmUENI?=
 =?utf-8?B?NjkrT2RiVFVObHBRNndqQ3V5YXg0VWxocSs2SjhsNm1sWCtnaVB4dVZ1amxL?=
 =?utf-8?B?VUdsbG9MbXEwdllVRXJxVk5JcExYQTdBS0dscm9GZHJEanB5SCszWFFrR3VS?=
 =?utf-8?B?eGp3NzVBVmFnQy9jbGJUODNvSWtZc0pnbHBLaDhDcE9KdkxWeUdnelFUWVRh?=
 =?utf-8?B?b0xpby9DS09naDRDU2NUWURGd1NObFh1QkMvZlo2QnJFbGJXUUxuZThkTlpG?=
 =?utf-8?B?TExBT3BnaUVMbEhiSzZES2EzcGxmVXFnM2g4WDV1b2VRWmhLZ01qWDZSeVE4?=
 =?utf-8?B?VE5QdFFIcjNzd2JZT0RvOHA0bFp6ajdyN0c0aHR3d3FNdVdZYUIwWEpFeXBH?=
 =?utf-8?B?cmdXUXV3aThMU3pVQW8wZ1ZYOWJ3Sk9rY0FxZzVhV1NhNlZDdVFtQXZtdENK?=
 =?utf-8?B?Q1VabE9VRHdySkdKT29uakI0VHNzaG9halZERTBMSHRSQ3ZWUnRIR2tBUUZ3?=
 =?utf-8?B?WU5hWktRMFFKZmk3RFlINXRJdUVGNitLb3ZoMWcrbTJ1eDl4S2lORG0xb2RM?=
 =?utf-8?B?Zy9yZDd5M1doSkE4KzJqOHZQNDJHU3VwZzRzdWl5Zkw3VFRIa3dNcFErV3Z2?=
 =?utf-8?B?L0pYVmhDRHIyWEtYNkxtY3U0aXVhVnQzWU03U1pDNjZXTzBDYmlWMnljMjhz?=
 =?utf-8?B?cjFTaVNla255WTR5bmVpeUlBMnpVZzIvQ2YzU1hkb0JpQVhCT1FQbjd2NmZr?=
 =?utf-8?B?eFEwVFIwempxRWV2YWdyOHlHV3JLaUp2M2ltN0J6cHV2R0RYb0lxd09RTzNC?=
 =?utf-8?B?N1VoSXQ5UUxla0Q1VnA5V0ZQeUtYK2JrYlltMVBpeTlEOFRWQWs0clR2Wk51?=
 =?utf-8?B?RkE1cWhFekRwd0JBUlJsMjF2NDFwRW9KMTl6SkNxelFpYkpQOTZYWEZjRW5S?=
 =?utf-8?B?UEp1SlNyZFpqRzFjaGIzS05Td1RMc2VhVWtMbWlvRUNyQ01tTUdqY2R6UWVL?=
 =?utf-8?B?UDhITEpUVC9aM0VId0o0STNVbTI4aGpselBDQjJGdWEvU2NuVzlqVS9UZVQ4?=
 =?utf-8?B?dUg3WEU1WTVRbHpIcjBGYUNTSndIKzVtejQ0M21JckxkMi9tKzVmTUF5T2Ro?=
 =?utf-8?B?QWpVTnh0RGlWeC94bk1UUWhIRFEybzBmVUNWSmE5RStyR1Z4RGlGeEJUSDA4?=
 =?utf-8?B?UDB3cEY0MzRPeGsrKzV6ejB1cmFwY1hVSjgrWkE1N2pjby9MeTgvd2pBK0k0?=
 =?utf-8?B?N2Y2RlQ5TjdEM21pb0hGVHN6SGdZZEwxU3FHNWMvTEFFeXREcTJEeDZFSGlX?=
 =?utf-8?B?TlZNbzhvOGNpYnFZalM4Q2VKSEUvK3BabGNpM3pqQnUxSG85bUhBVW5uOWRY?=
 =?utf-8?B?RFZ0WWhNVWx4eko1ZzliMCtRYWpCajhOOS9nQmJYa2Joclgxbk5sb3BQSkN5?=
 =?utf-8?B?emFjMTV3RWplMDlvZFhsbWVsMVNVMUNSdW83aGRPMmk2WkFBemhaUWR2bHEv?=
 =?utf-8?B?bGovRG9oOG5qY05uVjNJUytsbnFXS3VaYkFCM0ZLQ001eXlRL2ovdExrTU9O?=
 =?utf-8?B?akRjTGpXQWw1dmkxZktYUTNqcE5iY0F0QmYvVDJCcVIxMGNrQytBWnJUejB5?=
 =?utf-8?Q?efByf4WQ0tzze9SHOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0125e761-75b6-4566-b2fc-08df14cd642c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:07:29.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA/uzeftzjsMtJzgzt8p/PMNu+RKSfT/ikiQmAmz1ih4CgvZb+G2zu4+xMTTr8/kl7oWcZ3wJvaEI48G5rEDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955



On 9/14/26 1:13 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] MSR_AMD64_IDLE_WAKEUP_ICR is only programmed for online CPUs during module load without CPU hotplug locks, breaking ESMTP on hotplugged CPUs.
> - [High] Immediate retry on ESMTP_ILLSIB and ESMTP_TIMEOUT exits with cond_resched() causes a kernel livelock and violates SRCU locking invariants.
> - [Medium] Missing teardown of MSR_AMD64_IDLE_WAKEUP_ICR on KVM module unload leads to permanent spurious IPIs.
> --
> 
> commit 6679aa4cd87f7de484f6cabf547ea6d6220bfceb
> Author: Pratik R. Sampat <prsampat@amd.com>
> 
> KVM: SVM: Add host support for Enhanced SMT Protection
> 
> This commit introduces support for Enhanced SMT Protection (ESMTP) to protect
> SEV-SNP guests from SMT side channels. It adds logic to program the host's
> wakeup IPIs and handles three new non-fatal VMRUN exits (ESMTP_ILLSIB,
> ESMTP_TIMEOUT, ESMTP_RETRY) by yielding the CPU.
> 
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 944aaea6501f2..9bafb671a8b7f 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
> [ ... ]
>> @@ -3045,6 +3059,30 @@ static const char * __init sev_str_feature_state(bool is_supported, bool is_usable)
>>       return is_supported ? is_usable ? "enabled" : "unusable" : "disabled";
>>  }
>>
>> +static bool sev_esmtp_setup_wakeup_icr(void)
>> +{
>> +     unsigned int cpu, sibling;
>> +     bool wrmsr_success = true;
>> +
>> +     for_each_online_cpu(cpu) {
>> +             for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
> 
> [Severity: High]
> Could this break ESMTP on hotplugged CPUs?
> 
> This loop only touches currently online CPUs during module load and does so
> without holding cpus_read_lock(). Because this is a one-time invocation
> during module init, any CPU brought online after the KVM module is loaded
> will lack the required MSR programming.
> 
> Hardware will then fail to wake the sibling upon CC6 idle, causing VMRUN
> to indefinitely stall and trigger ESMTP_TIMEOUT exits on those hotplugged
> CPUs.


Having is in the svm_enable_virtualization_cpu() probably makes sense.

> 
>> +                     u64 icr;
>> +                     int ret;
>> +
>> +                     if (sibling == cpu)
>> +                             continue;
>> +
>> +                     icr = (u64)per_cpu(x86_cpu_to_apicid, sibling) << 32;
>> +                     icr |= LOCAL_TIMER_VECTOR & 0xff;
>> +                     ret = wrmsrq_safe_on_cpu(cpu, MSR_AMD64_IDLE_WAKEUP_ICR, icr);
>> +                     if (ret)
>> +                             wrmsr_success = false;
>> +             }
>> +     }
>> +
>> +     return wrmsr_success;
>> +}
>> +
>>  void __init sev_hardware_setup(void)
>>  {
>>       unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> [ ... ]
>> @@ -3221,6 +3259,10 @@ void __init sev_hardware_setup(void)
>>
>>       if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
>>               sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
>> +
>> +     if (sev_snp_enabled && cpu_feature_enabled(X86_FEATURE_AMD_ESMTP) &&
>> +         sev_esmtp_setup_wakeup_icr())
>> +             sev_supported_vmsa_features |= SVM_SEV_FEAT_ESMTP;
> 
> [Severity: Medium]
> Will this lead to permanent spurious IPIs when the KVM module is unloaded?
> 
> MSR_AMD64_IDLE_WAKEUP_ICR is programmed globally on all online CPUs to send a
> local timer IPI when a CPU enters CC6 idle. However, I don't see a teardown
> path (like in sev_hardware_unsetup) restoring this MSR to zero.
> 
> After the KVM module is unloaded, the CPUs will permanently continue sending
> spurious local timer IPIs to their siblings upon idling, which could cause
> host power regressions and prevent deep sleep.
> 

Described this way is likely not possible. If the KVM module is unloaded, an
ESMTP enabled guest cannot be spawned. The ICR only fires when a VMEXIT routine
of a guest with ESMTP enabled, when a sibling thread is still executing guest
code or still trying to complete a VMRUN.

I could clear the MSR in svm_disable_virtualization_cpu() but I don't think
that is needed.

>>  }
>>
>>  void sev_hardware_unsetup(void)
> [ ... ]
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index e2be2cd86c320..0b128f7911348 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
>> @@ -3732,6 +3732,13 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>>               return 0;
>>       }
>>
>> +     if (svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_RETRY ||
>> +         svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_ILLSIB ||
>> +         svm->vmcb->control.exit_code == SVM_EXIT_ESMTP_TIMEOUT) {
>> +             cond_resched();
>> +             return 1;
>> +     }
> 
> [Severity: High]
> Does this immediate retry create a kernel livelock and violate SRCU invariants?
> 
> If the runqueue has no other tasks (TIF_NEED_RESCHED is false), cond_resched()
> does nothing. The vCPU immediately attempts VMRUN again, hits the exact same
> hardware conflict, and exits again. This creates a tight spin loop that can
> peg the host CPU at 100% utilization.
> 

Right, the retry can spin, but mainly only for ILLSIB. This also seems more
likely to occur when vCPUs are pinned. RETRY and TIMEOUT are transient by
construction.

Having said that, I was toying with the idea of having bounded number of
consecutive retries and that would fix it entirely.

> Additionally, if a task is pending, cond_resched() yields the CPU while
> holding KVM's SRCU read lock, because svm_handle_exit() is invoked within
> the vcpu_enter_guest() SRCU critical section. This would stall
> synchronize_srcu() indefinitely and bypass KVM's safe
> xfer_to_guest_mode_handle_work() protocol.
> 

Yeah, cond_resched() seems like the wrong thing to do here. Although probably
for a different reason. It consumes NEED_RESCHED with kvm->srcu held, so the 
outer unlock-then-schedule() path is skipped.  It is a worse preemption point 
than the one KVM already has. I will drop it and plain return 1 instead.


>> +
>>       if (exit_fastpath != EXIT_FASTPATH_NONE)
>>               return 1;
>>
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1789399214.git.prsampat@amd.com?part=2

