Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBE4ACC8B
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387180; cv=fail; b=ZMqrkBeYzqCNhpJQa7Zsb0BHelGj4T162MnKr5T2pY92LrpypnapL+SymyKOJvbRlQIFuvLi8iQjrU78+Yhq2OZFqa5OVFNtMCRxTdeTUXKJyw+/XrfZ9UPNXJTVBWxEVzGUX3fo4J5WFmmoP+K+1Uu+atAd0hRnFMZa6mmCbyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387180; c=relaxed/simple;
	bh=wyBtPe8grutvULb5DpCSHjN7d/xh0vj+VUFgDVF9lm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=of++34GpnwcIVzp+qmYp4/J2xBwoQ2Z/I0LYPeCGJ4orXMF9CkzgdwzBs5EwNIyet+/Kys9sKuueYUkRf6M69VYr6wbuuMBMHYv4GUKuZL8xACoVqhJ0nW7aOEfnclF0UgHftJUgW1s9zdU89s0BU/Tj0tS9UblsCG8FGhBhl0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mwZkxNXi; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mwZkxNXi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euRUFjspEBQwyd8EANWScdv05wE1blVhzw154Pt7i+dBH8+cljogFbzCUFpjO10+mI4vVAJkMAnyXXQaSohB0wL1OK8xPKSFaHQBnCTGkHtZYcnigcfMTuxmGj9gCGKUTsM/AB5Aot9KVS2zExM+dnR/0QImfFdVi8b6CKxnuZg2P2z+MqIchYGF1nKdhmAiM+nrx05qovZHs8XqmvvboqGazE/GQDgaaW+0v8Cs4o+AwNNlZsoiu+MzvCkyS9wf8km12eieIlolux/FiR2GsJ1Xe1GZGxAMUUAr14+nophYrbXLufwpur9KzAkMmD9R5FL1DDP2CMgQNgMl/WmixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWSkmghqk//PkT+JFlRTtEJODcdx1P9my8nCZ2hBiJw=;
 b=Eb4mo38T8yO9+2/Ho92QpY3LOcVsk2iTyUOmlMRv+oeNmoXT64nlXICdt6nTNG/Fn1UbGFA3g9VJIlOgs6YJ+loEzmjrHxLBB4dCDoEYwmID07tiMISgc4RDBNP76CJKqD4CrxKBdf6hpZt47TonnedeZ6aAE0k//IOJZ34U7IGdpOv52Tfb17x4nhWYPOZrH/yvL/hOVZX6W+l6Xua8DNJwitrXKrdEhfFFPc7KsaLRNqGXzE7BnqGKd7Ab6n9/jzd1bk6VwNlbks5MVr36aqxbEk5QiTV6VjEj38H9c47GlEWQeUonLEiPe04QEVt+OmSaD8FDKnEbTS/OcoqERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWSkmghqk//PkT+JFlRTtEJODcdx1P9my8nCZ2hBiJw=;
 b=mwZkxNXiphZoycNzSqZqRKsct5WUu7dijUSHE3ygkey6cqnzPN5uXUK8hKt9mVJE67V6bJ6s0E58FcuxHBLeK3OQK5/V4/TVxR2E0sXImsx21Bkqpp9jTjeOrWBpBXdBdSZMyk4Tj6Eq5HfD3jYa+xTOobv5LDRK0l11O9unoQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 22:12:43 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 22:12:43 +0000
Message-ID: <760fed23-d799-49c4-af0b-3af688bfde3c@amd.com>
Date: Wed, 2 Sep 2026 17:12:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/5] x86/sev: Disable CPU hotplug while SNP is active
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1788296083.git.ashish.kalra@amd.com>
 <2c97a61a22a4808d422367e50db7ee0103a49860.1788296083.git.ashish.kalra@amd.com>
 <20260902215130.260101F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260902215130.260101F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ROAP284CA0066.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:a9::17) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e53650-8b35-4938-e371-08df093f4f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|3023799007|4143699003|56012099006|6133799003|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	scEjNItR8GswpNNDyb4fb8fvHh5814vYNpsZ3uCJsRYlr7NyH7djMU8NZD1me0yy4sm2vxlzpLQSeDqVXxwTQ4B1U7aaOBNGYrhsO+Jgh7GJHN6Udp3judRn+enOZZkN8DU9DIfxc9sWe+9yQV/iJMtjvYUlwBWAwzzCeOSjz1Yx6/uhwsg795FiRxCskbG7alzRkNE7W3Vj59ks8gBz2iRfJtuZT6J99Ui+k30nDyiXS2QFk5NjaCl7dA6HwQm6tCiie9bHmH8mBz9kKVtXhcORh4qfT+rmFXjM5hg2xoxBb+dRC3klzkLTRpIz41xgMh2yst2bo5LmU+wI68d3fQwiysSRZad2y7HqtsAj6fxxI11G0afzp/X50eypeNh+OkaB3gDFM0Bq653b2sc1km1TO5mIFE0W2upY/I+EaX0xHVtTFUpJosu/I8UcpsvmvzewAb0r+8vsy0vdXAU+Ljb+BDojWew0SohknGDRHSG/cZMKcr+52+mE4kOFoPZbScaSAgx5TqbFOM3+2xRWgWR7jtuHgvRWWQedrAUK/4OkfzjWmWkpckH39QlYWGlCa3SYxuqhLVtmzwHU6CI9R7tyAON5R5Lj1XbcyZ8W21oE+kzPEFbKKB76hyoH2JLKiGrLPpDI3B+qHleynFhzWIX+tP6c7+BxFf4qJsTC6KM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(6133799003)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THdiWERnejRlWC8vSitBVithcURFTkJGWS9PUURpYW5oejBDV0xYdWlDcnJV?=
 =?utf-8?B?eE5zbGd0RkZIUUZEU0ZQL2JJVU50UzcrMXVrWHkrVjRSNGl0bHRCVnA1VVk4?=
 =?utf-8?B?WDM4ekc0Vy9IOWlMOWNJTXdTUm1FNm5OSmttRVgwRXlvMysrdW9VNFlhL1ZI?=
 =?utf-8?B?c1loNWw0YkdWZ0ZmNklDQWFWSCtZQXdiaW80NFVIb3YycjBhbTExWE41R2xR?=
 =?utf-8?B?cE5OdFBnL1pZR1RXb0xQQXhEQnJKR1FUTUhkaFc3M0l2Z211UXliNFF0UjhO?=
 =?utf-8?B?YzVxaHoxWFZPMVZJaXp2KzJhT0ZuM1dBVE4xdkwxYjlDM3ZvdU1OU2pLTG5E?=
 =?utf-8?B?dXkzRVlzWWxtUFpNYkJyWG8yckpjZCsrU1Q5NXl4NUVXOTFFVVBQSktORWJF?=
 =?utf-8?B?dDdOWjNwT0JYd2E1VzhOc0xycktjZm1SdnBMQ0xpaGhwckhBc1NHbjJCaTQy?=
 =?utf-8?B?SWVoaVpNL280ZUprcHZqS2djRXVlL0V5Q204ejVCOVAxVUpYWjJrYWsyTStz?=
 =?utf-8?B?Wmg1WHdPYTB0L0lUNGVoVUI4RVZtZnlNWTF2eDVlQUpibXRNZ1BKTjhlZXRZ?=
 =?utf-8?B?OUxhVS9xNGZpVis1Q2I5cnE0SUwxUlBacmM4a1EvYmRVa3BCa25xclR1Zkxx?=
 =?utf-8?B?RGFFNDNicmhnMXFad25DcHZGYkhrOUhPZEcxVE9zck5LUStHb1MzYjM4N0R2?=
 =?utf-8?B?akZpeFlYNzVaVUw4bkNhcmg5QnBYa3dya2szemQ2M3NxbnZzZHBLSmFTUm5D?=
 =?utf-8?B?RVdlNlRiTXd0ZmFXMXFBYkwvY3RZRDZUdVgwNDdpcS9sMVZXc2xpSC9LNm9D?=
 =?utf-8?B?aGl5ZTljVExKSFFoZm54d3NmQ25CUFpPQzI2S0gxa1A5T1ZnTlhVWkp4WFdL?=
 =?utf-8?B?NkloN3QwQmRGeXFaLzl0ZG5VRmdDRHJOWTlSZ2pXOURVcGFRTjVUZE1INnps?=
 =?utf-8?B?cnZTK28yejl2a05Dd1BRVU1HbktVM21XamxnYW0ybzJtU3FPYXJ2aUFLbTdX?=
 =?utf-8?B?ei9Sa2JoQmtoNEI1dTBBdE5nNlN6dndPTS8vYjc4UmZzY0tVcURJMFF2ZjR2?=
 =?utf-8?B?L2llRDdnMjkwblR1d3pwREFNNytJT1JXMy9FYkk3RGJ6REJFaXJoNFd1aHMv?=
 =?utf-8?B?KzdrZ2QyYjJXWEhERmFLM3BPZnJMMW80UDZvcVY2UERIVTZtTkdPK0s5MzMv?=
 =?utf-8?B?YU00Y1FPcnRUQjluWHZSbVV6R280QkxPWUVZTmtkUnJWYjQ3UlQyQU1GVWVB?=
 =?utf-8?B?cjJGVzU5TEY4ZVBQRU1HMmJOeHF3WS9FWUwxK2MzZGpyalJtZmFiZ3FiajQr?=
 =?utf-8?B?Y0hYOXlkQWdsUGZwSVk3ZDgxNDFnTll1QWVoYWo3ZW1iVkZVWXorVjBxS3FM?=
 =?utf-8?B?RzdESGVDOHIzdGxnWUpkbG41M1dJZEFaL2hKUEpQcVVuV0Z4K1RCWEVMOWpr?=
 =?utf-8?B?NGp5WEVhdmR2RklDS1JTNGM5aDZxYVZ0dnBGRm14eGh6MjRQcTlxYmUxYW9t?=
 =?utf-8?B?VEt1bU1IN2F1SUtBaGdUUVpVa09IMW5KQkpuNURwc0VqMW1YS1l2NjVqbUlM?=
 =?utf-8?B?TXRDRzZZdzNhZzZaZUpyN0hxVGlEbGFKVG5idUZnbjI4eGNmMEw1V1RHME94?=
 =?utf-8?B?M0JjazVBdXJNVXFNUmQwak5DQWI5VXRmM1lNdGEvZmwyVGtRbTczbkpWK1pi?=
 =?utf-8?B?SkpRdWFVYzJnM25PN0ZxT2FtWGNCZTdJNnNkK3ErbUUrVE1ZUW9tL3BEOFJo?=
 =?utf-8?B?Slp2cUQyUUtzUWZrV2VEWUJJeXd0RU0xaWZvWHJkYXJVd3FoS3ZGaXM4MWlC?=
 =?utf-8?B?Wnkxa0tLWmtOVjVGRnJsQlhUVVZreWhoR0RrbXFRUW5UZytHQk03REM4MTN3?=
 =?utf-8?B?blMvUUgrK3pkcGIrbUo5cWlhcVZOVm5oRXhDNzBrS2V6d0dkRlFvTUNXYkti?=
 =?utf-8?B?T3p4TmR2TTFzT3ZCZnJIM2tMWHdRMVk3MEI1dTBkOG1ldTEzaGg3bk0wY0Vr?=
 =?utf-8?B?T1ZQQmh4U3lxKyt5RTllUnU0emV0TmVXai8yRE9NL1l5Y2VMV1FhQkFVVUpa?=
 =?utf-8?B?QitDMEFjZW9ld3Uvamt2ZlJXTUNabS91Tng3dHhFYm5MWEJjVmptUy9zSDEx?=
 =?utf-8?B?bzg3bDlhaXI0cUlCVStxY3VMM3ZmU3VlYXdBZUJhMlBmSldqOEpxTThad2to?=
 =?utf-8?B?aXZZMnUyK2VkVXZLbHdTN2lUWW8wNVlMNE45ZzNQSVhySmpRZzdSZHIxeXg1?=
 =?utf-8?B?Qi9YVzh3V3RCUGd2dWUzaHpkNHIwQ2JaRTFpb2RpU1hNNmsvZ1A0ZUJRalFh?=
 =?utf-8?Q?SgDbbCup5CoZC2B+3g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e53650-8b35-4938-e371-08df093f4f70
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 22:12:43.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsppiTUrQgRZjiUUIoVJjIvJdONrE3df3vw6GVQ9iRWwtmohM0WvvzRZUbV59tasO7r0rcF6zJBj2ARKL124DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277


On 9/2/2026 4:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] PM Suspend (S3) bypasses CPU hotplug disable, leading to security breakdown
> - [High] CPU hotplug remains enabled on kexec boot if setup_rmptable() fails
> --
> 
> commit c91487bb659a8ce73e581c086c8aa1aa19f4b9aa
> Author: Ashish Kalra <ashish.kalra@amd.com>
> x86/sev: Disable CPU hotplug while SNP is active
> 
> This patch disables CPU hotplug while SNP is active to ensure no CPU comes
> online without the SnpEn bit set. It ties hotplug to the SNP-enable bit by
> disabling it in snp_prepare() and re-enabling it in snp_shutdown().
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index cff285d8ad8e3..558f7924a3f85 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> 
> [ ... ]
> 
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
> [Severity: Critical]
> Does this sequence prevent CPUs from being onlined without SnpEn set during
> power management transitions?
> 
> While cpu_hotplug_disable() blocks sysfs-initiated hotplug operations, it
> appears that system suspend (S3) and hibernation (S4) bypass this mechanism.
> During suspend, the PM core uses freeze_secondary_cpus() and
> thaw_secondary_cpus(), which explicitly call _cpu_down() and _cpu_up()
> regardless of the cpu_hotplug_disabled counter.
> 
> Additionally, MSR_AMD64_SYSCFG is not included in the list of MSRs saved and
> restored during PM transitions in arch/x86/power/cpu.c.
> 
> If a system with SNP active goes to sleep and resumes, will the secondary
> CPUs wake up without the SnpEn bit set, potentially breaking the SEV-SNP
> security model by failing to enforce RMP checks?

SEV-SNP hosts do not support suspend-to-RAM (S3) or hibernation (S4). The
SNP security state that would have to survive a PM transition — the per-CPU
SnpEn bit, the RMP table, and the SNP-locked AMD IOMMU — is not saved and
restored across suspend/resume, so a resumed SNP host would be in an
inconsistent state independently of CPU hotplug. (That is also why
MSR_AMD64_SYSCFG is not in the PM save/restore set.)

This patch does not change any of that. It replaces the existing
cpus_read_lock() in snp_prepare() with cpu_hotplug_disable(); neither
touches the PM suspend/resume path (freeze_secondary_cpus() /
thaw_secondary_cpus()). The patch's purpose is narrower: to stop a runtime,
sysfs-initiated CPU online from bringing a CPU up without SnpEn while SNP is
active. The S3/S4 vector is pre-existing.

> 
> [ ... ]
> 
>> @@ -577,6 +582,8 @@ EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>>   */
>>  int __init snp_rmptable_init(void)
>>  {
>> +	u64 val;
>> +
>>  	if (WARN_ON_ONCE(!cc_platform_has(CC_ATTR_HOST_SEV_SNP)))
>>  		return -ENOSYS;
>>  
>> @@ -586,6 +593,15 @@ int __init snp_rmptable_init(void)
>>  	if (!setup_rmptable())
>>  		return -ENOSYS;
> 
> [Severity: High]
> If setup_rmptable() fails and returns -ENOSYS early, do we leave CPU hotplug
> enabled even though the hardware might still have SNP enabled from a previous
> kernel?
> 
> When booting via kexec from an SNP-enabled kernel, the CPUs retain the SnpEn
> bit in MSR_AMD64_SYSCFG. If setup_rmptable() fails here (for example, due to
> a memremap failure), the function exits before reaching the new check that
> disables CPU hotplug.
> 
> Because the function failed, the kernel clears CC_ATTR_HOST_SEV_SNP. If a CPU
> is subsequently hotplugged via sysfs, the new kernel will not set SnpEn on
> it, resulting in a state where boot CPUs have SnpEn set but the hotplugged
> CPU does not.
> 
> Could this early return be moved after the MSR_AMD64_SYSCFG_SNP_EN check to
> ensure hotplug is disabled whenever the hardware indicates SNP is active?
> 

On any platform that supports RMPOPT (which requires a segmented RMP), a
kexec performs a full SNP shutdown: the CCP driver's .shutdown handler
clears SnpEn (SNP_SHUTDOWN via __sev_snp_shutdown_locked). So on a kexec
boot of such a platform SnpEn is already clear — snp_rmptable_init() reads
it as clear and the machine takes the normal path, where snp_prepare()
disables CPU hotplug. The "SnpEn still set from the previous kernel" case
does not arise here.

That case only happens with legacy firmware that leaves SnpEn set across a
kexec shutdown, and those platforms do not support RMPOPT. On such a
platform, if setup_rmptable() additionally fails, SNP is not brought up at
all — snp_rmptable_init() returns -ENOSYS and CC_ATTR_HOST_SEV_SNP is
cleared — so no SNP guest runs. The SnpEn-set / hotplug-enabled state there
is pre-existing SEV-SNP behaviour (snp_rmptable_init() did not touch CPU
hotplug before this series), not a regression introduced here.

Thanks,
Ashish

>> +
>> +	/*
>> +	 * On a kexec boot SNP may already be enabled (legacy firmware leaves
>> +	 * SnpEn set across shutdown), in which case snp_prepare() bails without
>> +	 * disabling CPU hotplug, so disable it here.
>> +	 */
>> +	rdmsrq(MSR_AMD64_SYSCFG, val);
>> +	if (val & MSR_AMD64_SYSCFG_SNP_EN)
>> +		cpu_hotplug_disable();
>> +
>>  	/*
>>  	 * Setting crash_kexec_post_notifiers to 'true' to ensure that SNP panic
>>  	 * notifier is invoked to do SNP IOMMU shutdown before kdump.
> 
