Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C74388E4D
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081834; cv=fail; b=sWC9l+KGz93Mk1rN/Ohby09HzgxMKCGVOs+Tamo2HuqRufQ7RgnKqU3hNTuMlRebS0LyijAbWJZcDQbdliRgdeEtdcyTY5O/aOWfC119F9LAkmuy+L4ccXIJtFAfH69eERJh5q4v5maRzm4STpo/gofRNzRj/jJu03by6OMQFOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081834; c=relaxed/simple;
	bh=Yh+ZCFxoEdkr/6P297mXOzerXzaEcCn9dqbt+9cOIMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uxsF0HIE4J/mXPHMcnOwFfqM5dMnFV9cQ6ue3TfTlYsGEVnbSk54LQmC4bEyd6d8HKlOZIhZ9IYYxCrcWthcTJPFyCA4FB3yF3NYUSNocvrvRjuSMc1ScmpOKN4gC6O8JlPRRnzm/c2roSIc/s86oZWRWANvODKkjhZYMBSl3Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BSmNhDHO; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BSmNhDHO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY7Spq6A6C4M91VXxGeBLWMN4+TDyJspxpWZULxJ1ScujY3jQhnyfii4nfwrDZGKj5E8adC8HFmJSqSUDR/q10/dcgR9i/3718YSc+mCE8vna7aZqZ6bspECZ3rei7zDwF0+aoBMBvjxKzyhrDzBSRZqSHRTMzwRqm5TFSH9LDuU04jEicPxrM4AZM0U5ixixiy5Wfv4f3iVJ2YIcQVz4DWLVU/ct9j9MRKHbHnhSNLjepKYvfOo0dOX25dwttq49FG4budccoQPEV6hsVYhQA3OeL9TFhtlG/0X58VVA9dKiUAFOXnnFCidle2/qarmrogFiOeKmWZ3jB7Wwy3zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F0FBwKFT6F8g+s7YOGcPYhvet3O6Oy5To86n6RlJ7E=;
 b=ehkcYLFPSwlYge0wyD/Nt7MYJithcA2D7uAbkF8zGrsA++JwJhKz5+sYPBrUPah6giAo5WPF+RFbVER+mDijsxeHP5PuqMusne22vSIgNUvtasSDOJTN/wF9fXJKWvdjDJPDR6SR7hRtQFBBi4kGqFssUkWgfhf7dvM/KuDTsYoPd/qscY/HmaHqjrpeZsZavKJlZg3BxIrmZmn+ZC0ROUiuRLT4BHCf9r/5ttVTmKu0z/Ygs2CwEuiymq3K3zcxOhW0Q4Hmw/EnucXaFVEetxCRdF6erxN24Yx/Bk2iS+NjJF7Ngviqiif8CqPK8zEGfz4xb6ozvzgOC53oANy7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F0FBwKFT6F8g+s7YOGcPYhvet3O6Oy5To86n6RlJ7E=;
 b=BSmNhDHOj4+DE4ESbD4o+OnOj5cPXjfdKWVIt6p6IGF3mWdzcXCUURRjlu1oQeSSAHf2b+2iz6EHPeSo9+B3l8OXDJCoRgICMjYVS1+dNGsofBbhJ+wL+QnoCRj102GrGn5d1yD/RQZwWd3/h8At/wk4S89T6NMsNM3X4Uo90xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:10:30 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 23:10:30 +0000
Message-ID: <67697da1-1620-4ae1-974d-831b8166bd9b@amd.com>
Date: Thu, 10 Sep 2026 18:10:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] x86/sev: Re-enable RMP optimizations on SNP guest
 shutdown
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1788984053.git.ashish.kalra@amd.com>
 <a2dace70da1ea687b81a237372d4b7b6e82f1cd3.1788984053.git.ashish.kalra@amd.com>
 <20260910221259.085AC1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260910221259.085AC1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:610:74::23) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c71f0e-d9cd-460d-ec07-08df0f90b525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|3023799007|6133799003|11063799006|56012099006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aXFE58D6kiwgPePPIZWgNV6uZ2SonxWr4DmVy2Y8MujIJFV5MayXLq1t6EN/SSeUeTBka9g/h0GwVrNpHq1YHUOVZejVXajskd9LMlr0Bwu3iiTel5Xms7+w+traXmU8C4vXhgd/z8NJ9oS1ZD9Sxkjbve77zZ8kHayasSIRAN0sF2s85lVb7auofSG4VJU7lh/By8wmQjqSqKE6VbDg85BnliAIGYC2degWb+9xFxxAjw2IRd0g9xmvyc4bEFso9HPNuPe0LUWJW/Ql/3jsz0m21CMDugi/TlhBP/4u/FdzMdFc3LsFtlTno4agqKR6lDPRrzgtYXQCyW+POQDq65zIUIuFj6DW42g2GE+Wb1siVsDFKqnNw3/9Mj9VbfDG0Rd5Y0c+DEkEGSRi7crBvnQvn7mJ/CMIQLVC89TElYph99Gd3FwDaodBfwrFxibfU2hzSe5z/7ipWcZcrAEJW+dz+fk0e6E5L2nNEnJR1pXVbW9IcQ17ubE05aStucawdkNv311R/LmJRJdHVZswI7NR8HqoXv+B2LhtctaIJqGuHyO/dO5QE0+efWjoL7vI+mwgzNpviv+i9yzXrG5YYSU68MaEahUnZeNuirobRhrwdJjljP9ODl1t/MZktIEli4ucm9V+gFpL5mZAeXoKFT9dpGWz/kXvUx8DlQFZsVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnF0M2dIVHNRTE03RE80ODJuTjJMYTJwUXRWUzlROVVDbGpoU25SRnhhQ2gy?=
 =?utf-8?B?NGQrVzc3NXBMbk1MRWlWSG8zQlZhMzZ4bEEwcURVc2R2ZDFGRy8vaWhxZkNW?=
 =?utf-8?B?cW4rK1VDSGNtcjFwMnBXUklPTHJ4NDNFbExaS2pzRWJnenBxMHBLclpPamd0?=
 =?utf-8?B?THRJeHM3QkpqUHdYc0UzRUVhQ0YwekJEcjNrZzBHWEgxeUpmbHBtNDh1OE5G?=
 =?utf-8?B?WENPN1VhaHg1V3VDZkV6MW4xMGp2S0JIdjM2SUpETVVRL0lWQnphbXNIM080?=
 =?utf-8?B?cDlaVmFZL05yd2pBR0dBN2hSYm1JQzhzUHFZN2dHK3JXYlMvRFdJMVhHOHhq?=
 =?utf-8?B?MXd6WGlWWWl5cmFveXRkUVR1c0RKWm9FMEVpVHpib3FVMG1mKzYxMXc4dTZw?=
 =?utf-8?B?YWlMYTBvZC9nMGpNWVk1bksyQ0kwclBCNHJYK0cwYUNCTVp2UHJMdlFZamkr?=
 =?utf-8?B?WTl4WWY4S2JBMG0zVS9ydXRQbUxlU2ZrMUc3WTFEM1Z2SUcrNythVjY5cndF?=
 =?utf-8?B?Q3Z6MGMxa1ppdjZ0dVJiQTlBcHdIQVREZ0NpY3BxeXJuN3k2V3RkLytkRktm?=
 =?utf-8?B?RG9LcWt0MzNYMDBjVDIrcVFaL0gyZ0crOVhhNkN3dCtPSnRMSzF2SFFuL3Ew?=
 =?utf-8?B?TnFlSm80clQwQS9JZU5jaUxySnVFcHd3YUkxU1ZhNzlHcjFzMGtrU1ZUZkFG?=
 =?utf-8?B?Um5lejkwOXdDUExMbkcxMFZ6RUVxTmhwWWgrYThVeUZzSG9kQnVMakFLbStS?=
 =?utf-8?B?b3Y3V3dkdFBwdVROMUozaVc3dWs3T0Q2L2JhSCtXODhVV0hkS05ZaXVGVExG?=
 =?utf-8?B?b1Z6Z0FZeEduRW9uQjRUc2h1VExUZ3NLMXJhSkF0K3BFRHBGb01SKzcyU2Mr?=
 =?utf-8?B?Y2YyWUMzN1d6NitmYWRabEVKaS82eDR2amxJZTl3c2c5VDFrdUlhN0ZxOEdX?=
 =?utf-8?B?SEF5ZWN5dEJXSnhoYXdxZWRDZmFHbm5IN0oxNHNIK0EvOTdNOGlTMzFSVVJW?=
 =?utf-8?B?aW1SUTV6cHlHQlEvQlNWUGYrWVVYM1dPMC8rZkNVck0xNEpQWHFlT2tvK040?=
 =?utf-8?B?NXNXQ0srVk8rckJVdTVGV2VsaGpvY1VreVMvQ0tRd0Z3NEVGd1ZZb1lYYVBn?=
 =?utf-8?B?SVAyRHNnSEd1WVNqV3llRTU5MnlmTUhpbDdjcVQweVoxL2l2bnhKQmdkQ3ls?=
 =?utf-8?B?aUZOMUZnUWwrQ2RadWZ3MVhKZnZiQW1nZkQyMVFMQi9pOVpFQnV0VFJKWTBV?=
 =?utf-8?B?SnA4TGdETXV5YmorSUNsdTJYR3h5YUlzSlo0MnpvKzNYclExVDdBMVh4Nk5j?=
 =?utf-8?B?Z0RVVUc4UXFpZHR4K2xEdEdnM1puWkY3QWkzL1Fib2ZnNWxNZlU5Um11S1Ar?=
 =?utf-8?B?RVQvSTZ6YjU5ejkwUFpzZVBiNXZaQTlWN1ZYOVdvejdybzN6M09HdnNMS0ZT?=
 =?utf-8?B?ZkY4eHBLV016MTcvNkZnMWFPeXRNbEFrd0lpUUZjRW91MGp1cWw3ZjNza0lE?=
 =?utf-8?B?dGFDZ1hJaTFURWtwbVV1a2J1OFVrcWlaL0tRSCtuZVQ1YmF6VkQ4emFmSG44?=
 =?utf-8?B?am94V3pYWG1ScTRrYXNLWnM2MXFIbGRCT01FeUUwTHdCa0pNTmlUN3dZa3Iw?=
 =?utf-8?B?YWFHRUFxVG5MZy9oemVyeUNDQmlBTFZiYjBWeThoY3hjZm1PcDhUTFk1bk1r?=
 =?utf-8?B?MnV5Yy8rMkliZko3UDU1bmhmOHYrMEVxT1UrQTNkS1ZqNzZxa05hZ3BZcHpB?=
 =?utf-8?B?ZGVSb1JKMG1MaVV5Y2lvblRkRlYzclREWUowUEZhMUM1SFR3bmp3QjNuZ0xO?=
 =?utf-8?B?djdIWG5QMjNJU3dXNHlhZ1BMaTJjc2F3aDFSTDVJOGhTM0x3eVFwbitsbm1B?=
 =?utf-8?B?b3N2Z0I5bitQUUZVZTR6Z0R3UE5OWjEzdFNTcmhCZVg2UFVYQXNBREt0WWhT?=
 =?utf-8?B?ZHNLZXhBSW1wQkNSbml6bzd4ZnB2RldRMHVKU2ZQY2Ezc2RZZDE3bTV0U3ll?=
 =?utf-8?B?K0hYaGVqWkZqWUk2bUVMckFnTDBvM0lGTkQwZXY1Ym5mdms3dm9jSHhmSWVk?=
 =?utf-8?B?UUQrN1pMVHp1Vm10TWhNOWNZT0kzTUkwT0g3NTZYR0ZTRXdJQzQ2STE2L0h4?=
 =?utf-8?B?dmRkR1ZGS0IxUEh1S1c5M0tvakZudThZbW1YMm5GU0hpNmp6Y3d4UDhlMC8v?=
 =?utf-8?B?VXE1ZmhQZ3ZvZ2tBUzkrRjV5REtIbzB4cnR5ZlVlZXRkclFpZ3JDMVd2SDVZ?=
 =?utf-8?B?OXlSVWZxcDA2bUtuVHgydENMLzZHakpjSU9XcUoxemdwT2FTaGdjOTRLQXMw?=
 =?utf-8?Q?FBP9hIc/txAt5kFhWC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c71f0e-d9cd-460d-ec07-08df0f90b525
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:10:29.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+3zGZ8+p+ZHSlokfmd5PT2Mp3RcVnmp1H0OVfh/FlB/1ODt7qeqPLZXVm7kIWtv0xWAc/m0fNhKz7MCB5qYGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956


On 9/10/2026 5:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Race condition between KVM VM destruction and CCP unbind allows RMPOPT work to be queued after SNP shutdown, leading to a potential kernel panic.
> - [High] System lockup due to broadcasting a cold-cache memory scan to all CPUs with interrupts disabled.
> --
> 
> commit 5610134a51dd4a088684e2eb5968c3e869f5727c
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Re-enable RMP optimizations on SNP guest shutdown
> 
> This commit re-enables RMP optimizations on SNP guest shutdown by scheduling
> a delayed work pass. It introduces snp_rmpopt_all_physmem() to queue the scan
> 10 seconds after a guest termination. The delayed work batches multiple guest
> teardowns into a single optimization pass.
> 
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 5705723f1f412..d8e6b8a08b79f 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
> [ ... ]
>> @@ -3032,6 +3032,8 @@ void sev_vm_destroy(struct kvm *kvm)
>>  		 */
>>  		if (snp_decommission_context(kvm))
>>  			return;
>> +
>> +		snp_rmpopt_all_physmem();
> 
> [Severity: High]
> Does this create a race condition with CCP unbind that can lead to a host panic?
> 
> If the CCP device is unbound or shut down, snp_shutdown() is invoked, which
> disables RMPOPT by cancelling pending work via rmpopt_disable(). However,
> rmpopt_disable() does not set rmpopt_wq = NULL:
> 
> arch/x86/virt/svm/sev.c:rmpopt_disable() {
>     guard(mutex)(&rmpopt_wq_mutex);
> 
>     if (rmpopt_wq)
>         cancel_delayed_work_sync(&rmpopt_delayed_work);
> }
> 
> If KVM concurrently destroys a VM, it calls snp_rmpopt_all_physmem() here.
> Because rmpopt_wq is still valid, the background scan is blindly re-queued.
> 
> When the delayed work executes, it will issue the RMPOPT instruction while
> SNP is disabled in hardware (SYSCFG_SNP_EN == 0), causing an Invalid Opcode
> (#UD) exception and panicking the host system.

The concern is valid in principle. In practice, though, it requires an unsupported configuration:

- A full SNP shutdown (SNP_SHUTDOWN, which clears SnpEn) only succeeds when there are no active SNP guests. The only way snp_rmpopt_all_physmem() can re‑queue the pass after SnpEn has been cleared is if the CCP/SEV platform is being torn down (driver unbind/removal or system shutdown) concurrently with an in‑flight SNP guest teardown.
- Tearing down the SEV platform while SNP guests are still being destroyed is not a supported operation.

Given that, we keep the RMPOPT setup/teardown minimal — set up once, and re‑queue the pass only on re‑initialization — rather than add persistent "enabled" state solely to guard an unsupported teardown ordering.

Thanks,
Ashish

> 
>>  	} else {
>>  		sev_unbind_asid(kvm, sev->handle);
>>  	}
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 35678b1f535d4..c16f826423903 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -640,6 +640,37 @@ static void do_rmpopt_work(struct work_struct *work)
>>  	on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
> 
> [Severity: High]
> Can this cause a system lockup by broadcasting a cold-cache memory scan to all
> CPUs with interrupts disabled?
> 
> When an SNP guest shuts down, it queues rmpopt_delayed_work. The worker
> function do_rmpopt_work() attempts to warm up the cache first:
> 
> arch/x86/virt/svm/sev.c:do_rmpopt_work() {
>     rmpopt_scan_range(NULL);
>     on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_scan_range, NULL, true);
> }
> 
> Because the RMPOPT hardware cache is per-CPU, running rmpopt_scan_range()
> locally only warms up the cache for the worker's CPU. The subsequent
> on_each_cpu_mask() forces all other CPUs to run the scan with interrupts
> disabled.
> 
> Since all other CPUs have a cold cache, they perform a massive memory scan
> (up to 2TB) while IRQs are disabled, which can cause immense latency and
> lead to host lockup (exceeding NMI watchdog or RCU stall timeouts).
> 

The RMPOPT optimization results are held in shared memory, not per‑CPU caches, so after the local warm‑up the follower CPUs read the already‑computed results from
shared memory and short‑circuit. Measured via follower_timings, the worst‑case follower IPI callback is ≈1.3 ms (1,341,505 ns) — ~4 orders of magnitude under the soft‑lockup/NMI/RCU‑stall thresholds. 

Thanks,
Ashish

>>  }
>>  
>> +/*
>> + * Delay, in milliseconds, before the RMP re-optimization pass runs after an SNP
> [ ... ]
> 
