Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A681314B77
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259666; cv=fail; b=aNXBjyLjPh9xNN+zJLB0m7A6sqlneqNvHzr6ujlccZEdD7XrsnpdLke03ZzPBj4HSXSFb0okDiEMfb4bELEUe/ftvlyAAyH9m2oxZSvCP2TxAeexhoU4tLbUM9itgw6OQ+aY71Fk5DURN5vGiLFoU5rc1WNc09VIQn7e92IF6To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259666; c=relaxed/simple;
	bh=hua4zreFSn7UtbH2q3IwaujOnf9vrsq59Ojg4Z1QrKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ja5VKALHgHa7vFc67sZZZmqbHKow8JzMlLe2acPg1VuobgcYYm8oBMVaLcookwmpnThQkvXyLqNQPYZmhw89lwvtbAKS6/Dixs9/I2FLCdPKxT01/I6IaE1A8DwL5d0ZYG9lCmBUSQsJy/HtRq/M1DHUtSFoN8V38Byejpkq4to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kscN8Qvh; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kscN8Qvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcAFHbnkAfiUWhjzyY/zjo7jYLUquDVOvsG2DtHRetaVOokYK8BZAemDNKPWoc06v5/EM7/AiyAqqlvTaSDKs5t3k1KLQ+8hg0ecXq7C7pEwIm8RuALdtpTcDDqFS3SdjrYTViD2iKKSzoTAvHhAXbUDKCvpu1R1kViDAmA5e7pjF6q3r456l/Q3lltKEPuCrNrhTIxvLu0pMv7XoN/g8of78DNYgViFxVWJl1aHBel1Jssw6Cpou7+P5hRZDxNlz8F0tqWsLWUbLfEsV3lK3k8zg7Yfe51mjbIvq8jz75OFvqghxyBd2ExFlw4HdxY6qqkuaClfGaeZ6SRQ/vQ+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nez0rf3CY8ZSPjbZ4TkVXWCkgd+PbkMQFZ+uC+H4rnk=;
 b=rI6cVMM5YGWh40PG7zBp6IR4QF9zTjJy9o4lfoY1IfTZYIo5zhSm6xaRD4XJ2ZNdbTjqwlV6xtJaX9CWPnsuIk92LgmXwbgNftlNsUMPXxwChYEqlgwbW2XdTAPmpFvvQGBs5MDl4UoEfM41eMo3oSw+BwG32l/6ScC/QpgW7tlEuKCBD7CFqUaLjUOTYrPRoFt9zM01TphTUdwjPlvW7L2hz/OSHL/wq9CDVvaZ791k+z7T3c7Z+P1fFyfWXn21Rzcr5e8sqId2wLAiRwBQS8ozE01xHn7JNAhgkvZGtHt8KIpEuzAKHpEvWqe/ctDBb+jEt4y+0ScQG/IHxSnzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nez0rf3CY8ZSPjbZ4TkVXWCkgd+PbkMQFZ+uC+H4rnk=;
 b=kscN8QvhLF7l0L82tBycdDJn2qDQ15etcMDwITlQ3UFpFJVpfVgEV4WGT3+yqj4mrwr6PgpuCFA3bcHdnxDqgSKdM4R9qO+PAlrOA6kKXbqAoep2afDespcaGZfhWXmGrDFPutN8LrCJdLxcglf8cWKuOF/7jek/uy6uyfVARs0=
Received: from CYZPR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:8a::8)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 21:01:01 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::9) by CYZPR10CA0024.outlook.office365.com
 (2603:10b6:930:8a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 21:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 21:01:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 16:00:59 -0500
Received: from [192.168.1.8] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 16:00:58 -0500
Message-ID: <5a44f60f-aee7-4076-a5b2-ab06afcfaa93@amd.com>
Date: Fri, 21 Aug 2026 02:30:52 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] KVM: SVM: Advertise LbrExtV2 to userspace
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-6-shivansh.dhiman@amd.com>
 <20260724200623.15C411F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260724200623.15C411F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: d58dd6c5-b13e-4cbb-4f5e-08defefe242c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	5h7wi1gzi6PNx9aLi8LKMRRBmrlhFt7N0J5Hzu5yIREiNuDu0fIB799SbrTDnWDCzN4hc1SE4TR0vpWwuHGyx5YysoOQpElHYkaR/lwDWk+vMetFL/VJZIUcL1EFp7WcFfuTvu1/4FXoQB2kDv8XIUiHVYldZ5QilnIkNfHaRksFkt0cUIAKuvWFRan2cM4v9YZhVpgooWFKNUS55vN1JgdlTbZfgCraXtm+z2MPa6szz3c0fcxNP0rfhfPAQf7MrGRRtacrcBlTF0KIWUbg+iXmbinGCebAl1eM/DJdE2NAnshZl2iMKdBh/IPzdFezlSNqRP8laJ/OvM3XPJH8D29wIC43t/PxE0Wc98Essr2h0TCtsd+HUJqpm4cr9CTF/r+EFXHtd8R5X8WCegRwIgdpyMun4fUrrJwgbJuzcWxOaoDYpoU0D1yb0L/Jxclh6yPwD97G+cpzZ4w9TEaFMTKK0MiQXwnGJU5RtJPz/lSE9i3u+H0ck2+7npCsdLrqeE2eZjNuu0rWECDLJKkhpJjAOWfmbIw1oauvXIX7MdA1VVlIR7PEJ50bQWDUlNHJ09kvN2p3boOhtfckQoMJMdfbU6ofUiU0ZJ62dB3jlsgOTmUsa+rcCnGBt9djk4DlfQBUAsFKZYsAqpeKpjAmQooVyYLeOBdF4CZcvZ6ngzOfI1ChYJeG/zIxTEFD9FfSCsMh2Mx/yKU8JDSO/FSe4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7A4oBegdpZc2bMjfAWsFmO/arXAfHvqumiaRH4qccbegw1K/PgzTsvDAOoMMsOTMVEFzhf0onz6/DWFVvj8CFOewLb2F/kQo1IF1vrDG+fv6iLfPTrUSsvmPP7dsVtAlEv+QsSX1mKa0I/lypUAWyv2BKK++y3BBStbStAOw4vma+gD2xusJZuHnn/wjGjetoKkz9lrc4AUd8PVIgXaw+/JizabUwC0hHfNZ40UpyvNK5W2ZSBeS330fDbBlZ5/6hiOynUw5cHvslQ/fumQch8GRRSYGK6fvhEbwyBAii+26Qq8OnqcYl5l4RnokB4v8Th6eBHA1254AQbNmPmiNkspym9sQl5TiuymsYRHwIbNtow0I9TG8/7GM7iBPRjS1OuuMbLOYo9NPOXisaL6iQWBXPV/DdgLBQfOHiXKYY6nt1P+Y605xo/Yhuh3rAKcq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:01:01.4758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58dd6c5-b13e-4cbb-4f5e-08defefe242c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964



On 25-07-26 01:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KVM fails to gate the advertisement of AMD_LBR_V2 on a 16-entry host stack, violating the KVM CPUID API contract and causing a guest #GP upon PMU usage.
> --
> 
> --- Patch [5]: [PATCH 5/7] KVM: SVM: Advertise LbrExtV2 to userspace ---
> commit 9dead9faa6c004cfaa9aa0580ca255569674a36b
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> KVM: SVM: Advertise LbrExtV2 to userspace
>     
> This commit advertises AMD LBR v2 to userspace and reports the LBR stack
> depth in CPUID. It aims to gate this advertisement on LBR virtualization,
> the mediated PMU, PerfMonV2, and a 16-entry host stack.
> 
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 2698fa42cd971..d450a5b2499d9 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
> [ ... ]
>> @@ -1883,6 +1884,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>>  
>>  		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
>> +
>> +		if (kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2))
>> +			ebx.split.lbr_v2_stack_sz =
>> +				min(kvm_pmu_cap.num_branches_lbr, SVM_LBR_V2_STACK_SIZE);
>> +
> 
> [Severity: Medium]
> If the host has kvm_pmu_cap.num_branches_lbr < 16, will this advertise an
> unsupported stack size to userspace?
> 
> The commit message indicates the advertisement should be gated on a 16-entry
> host stack, but it appears the host stack size is not checked before
> X86_FEATURE_AMD_LBR_V2 is set.

See below ...

> 
>>  		entry->ebx = ebx.full;
>>  		break;
>>  	}
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 04e386b838d38..4b84498e93be7 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
>> @@ -4846,6 +4860,10 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>>  	if (guest_cpuid_is_intel_compatible(vcpu))
>>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
>>  
>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_LBR_V2) &&
>> +	    cpuid_query_lbrv2_stack_size(vcpu) != SVM_LBR_V2_STACK_SIZE)
>> +		guest_cpu_cap_clear(vcpu, X86_FEATURE_AMD_LBR_V2);
>> +
> 
> [Severity: Medium]
> If userspace configures the vCPU with the advertised CPUID (where stack size
> is less than 16), will this silently drop the feature internally?
> 
> If the internal capability is cleared but the guest-visible CPUID remains set,
> would the guest receive a fatal #GP when attempting to access the LBR MSRs
> that it thinks are supported?

See below ...

> 
>>  	if (is_sev_guest(vcpu))
>>  		sev_vcpu_after_set_cpuid(svm);
>>  }
>> @@ -5692,6 +5710,10 @@ static __init void svm_set_cpu_caps(void)
>>  		if (kvm_pmu_cap.version != 2 ||
>>  		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
>>  			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);
>> +
>> +		if (!lbrv || !enable_mediated_pmu ||
>> +		    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
>> +			kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);
> 
> [Severity: Medium]
> Should there be an additional check here for the host stack size?
> 
> If kvm_pmu_cap.num_branches_lbr != SVM_LBR_V2_STACK_SIZE, it seems
> X86_FEATURE_AMD_LBR_V2 is not cleared. This appears to lead to the issues
> mentioned above where KVM advertises a configuration it cannot faithfully
> virtualize.

Agreed, the set/clear logic is bit ambiguous. In v2 I'll gate the cap once
in svm_set_cpu_caps(). Emit the size unconditionally, and drop the
per-vCPU revoke that caused the cap/CPUID mismatch.

if (!lbrv || !enable_mediated_pmu ||
    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2) ||
    kvm_pmu_cap.num_branches_lbr != SVM_LBR_V2_STACK_SIZE)
	kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);

