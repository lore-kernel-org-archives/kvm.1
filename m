Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63514F70
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926342; cv=fail; b=otNhXGvBZRk6gULiYiAMBTj0MYHeyxe4Cvrl2BMTQNWktSXHsxDxDt+2Ve+cNgGM2RoO6Mq8yCvmhbUB7uOLSC9ECXoll1crmX05P6ej+YZAEiY0aaAliAkkHDcUKy7Hnc9EFQxn0uO49TUeLNRYXOrheirrvLfcAPDw+vyvI18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926342; c=relaxed/simple;
	bh=pMpJF4xg71UQMJ00SsHbRlSQNicILt83+ReDqryfDF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=towioHSoYuacxcP9VVCEZ+EAMuv3hmOX49M0ZKYkYOKCseBH8Nj74UJCVxEzdLPEE1zMpDCE/s8W2DFMihrWqSkkOIj+/QDV05YtfzIo4agq6TxhP8edc1sHNBjlESNZlovd3hlijQvG7rtV19Gadcg764Wk9AdsmWGBzs6j7sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YuDz3w57; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YuDz3w57"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqlMFW07r7PCLDTC3fzJOCyfpSsxkrPBuvNRcTt9w50Rrb4zoXVLazy7aBqFuoVGEoPhph2RjI3uS23NUzF9nIZ3MS6d7M59fUurmazX2+RmLlcRVbfyU93nvV1cqh5TlfJEIB5dISlFjwiBuxiBhvJOtoJXwLfZykfsV0q64fOOwoc/o0outHVBwupjPdGGXFgOceJG7vtWk3sqC79uRs+KXRszxhSuTIXZqEoDlH5B1Y0HmoIY7oJS+03/aeIjTDA8zl2fO1aqz3eeAvPhkDDbdilsHbakPC77yF8RT6PlDCtgzSBXiEN29c3VPj2s7dPj9AWy60W6UlDPG9IjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSDiGlK/o6x24rHtGC9Ntt5XhmtWHvh5yzjoPkHEQPc=;
 b=P5Bqdu2uompu/2z9NSuAtxLvc+ILHPUn8EqEHIOXlWHzmGlCu9N7kNcthTAL7sbUSuP65xZXvj0sHzwyOgA/fw8b/Yt1zoDvu054l/bn18q986JXBIlPKtE9ovBwDKFMNZ1cr2fucI3zeja2Zd8XK08GDxX4AGRmD1MHGcqRdk9pXbzok+pT4H1QaApC5eaW5HTFb3QQL9ZnOMclTKrs6+WUHxM8PvzLoCrRLlTD/OQ/vPKvKHSnUnjxBkzvWBfzBOYTlDdNDWppv8TEkFmw+mn4G4s6ySBO9DRUAcyMscNie3SN2mYcO6D9MWD51LIhhuVpDqYN9FdtBLR9UmAddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSDiGlK/o6x24rHtGC9Ntt5XhmtWHvh5yzjoPkHEQPc=;
 b=YuDz3w57R7Mtdpz9VL5e41pvS+as227+vIDJ+qAxItYrC3QeKQzljZGaC2vfYusLLoB+65OsmxczVrdSsN3eJ6zKbH+qKlSsqYkAJFOWYDVNjzwMwRI1yOCP+BEz/x68JWqS6Wr7UufG2h0CL/JubzxoA6AVmilJYGF60jDry+k=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:05:34 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::59) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 07:05:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:05:33 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 02:05:32 -0500
Message-ID: <336baf70-d8a3-45f3-b72e-5c5662b34244@amd.com>
Date: Mon, 13 Jul 2026 12:35:31 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits
 dynamically
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-5-shivansh.dhiman@amd.com>
 <20260709084459.6F23B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260709084459.6F23B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bbec19-7126-4d93-4ed7-08dee0ad221b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|3023799007|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	K1hp9q3pVEXBTdXJUfCHQl8lXDpdlDXdOhLM7K5dG8ZMX/eubgUBqfIvekaJy2ocZ6CsXUVxX2GN4Uzzfn3sKHmqiIMlWxddfgunsFKgCH6vJYQbLO8E3YUvOVs9FBaWa/pHkjF05br+pNeEP579bvineaex2JEY0Q0q+3WLtC8jCG27Vi3pn6khfJVZlPji9FIrvW/PmPsHawVVrrtF/Nk6kNl4rR5SYhtAQCB1RR/OLUEN1Ko5lkYMisQw8F7JJzOVPncMn4+l0KmHvhPG3L0LEdvqilaRUbp6jGRyO/NlWhhz9HZFlNaBJ+71TNwTkCJ1xgM6UJj1nBY2nB7juXafpA9bCr8AcBmfu3rj+ISwczZnvpiFfj5CD1lrZWRxLYroK0M3gKTcetQW2m8x7ZbjtRpY1IMlvtuUTgjAk0yWZFlwA3P511OgQP15eKFVBtK1iml7axKhDWXS34xlfkND5ysugAgSESJRzHVl/iZvdgMflC0HyC026XoNtXELjbp3vJ6wj1gK7JlUCSRY6sSquFokkMF+t5CX6Pm4DXa5w6ZSUpm/568ojmcTFv2eYughDltWSBZADKTAFrPQ/HtR/pZSMm39glttVFqoV/FyjRrv3KEg5FtYXpLWqBJsM2htBi4pZEv1yYs4Rg/kjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(3023799007)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DZir6hXhpDj08ybhxtCcYmOH6w4WRgGxDsJfVZzb4kSbE4n0lqeX409p1lUiXrUpBNC6aOX7MFOf0E0T6EoeE/UH7ohKfmZpP0yAhokWgHs9VAA5wOx06gOTl3NwyKRw6dAhbsNg8eXs3wD9An2AUmsjumMMsRSmxkjFkTrTiZQw25uB6FSVPjukbakBQj+hXhbWJCPZfazbS1q1nDsqw+ile4M1q3BJokml9tdY1oq0DxP5oiXcWcbHCI0Cprx/edpcTIu6eN2HTM+H1P8OoMS1pxFTT7AQp3JGlVABHoOcMsXzdUWBugbQvPM65fEd1qfBkHDgYjqWWitgmeTOThP+OFdLSfQSVha2v/dqty/DDV974b3CoaRqtCnAxmFzh+9gJ4dwZ8BGA6K7JH06GNlHT55b9OKWUSIvTeBSbd4NVvD2vXZ48XrMy0xgMhCr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:05:33.9003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bbec19-7126-4d93-4ed7-08dee0ad221b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139



On 09-07-26 14:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The dynamic reserved bit check for DEBUGCTLMSR_BUS_LOCK_DETECT is dead code because KVM explicitly clears the feature from SVM's supported CPUID capabilities.
> - [High] Hardware silently ignores the guest's Bus Lock Detect configuration on VMRUN unless the guest also enables LBRs, due to AMD SVM requirements for loading DEBUGCTLMSR.
> - [High] Bus Lock Detect support is fundamentally broken because DEBUGCTLMSR state management is strictly gated by unrelated LBR Virtualization parameters and host capabilities.
> --
> 
> --- Patch [4]: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits dynamically ---
> commit 8b16c8234c21a39b440d6a7688ffcc624702cdf8
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> KVM: SVM: Compute DEBUGCTL reserved bits dynamically
> 
> This patch replaces the static DEBUGCTL_RESERVED_BITS macro with a
> per-vCPU helper that derives reserved bits from the guest's CPUID. This
> allows DEBUGCTLMSR_BUS_LOCK_DETECT when the guest supports it.
> 
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
> 
> [ ... ]
> 
>> @@ -1231,7 +1231,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>>
>>       if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
>>               svm_copy_lbrs(to_save, from_save);
>> -             to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
>> +             to_save->dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
> 
> [Severity: High]
> Does Bus Lock Detect incorrectly depend on LBR Virtualization being supported
> and enabled?

This dependency is architectural, and has to be honored.

> 
> Here, the guest's dbgctl is only copied if the host supports X86_FEATURE_LBRV.
> 
> Similarly, in svm_set_msr(), writes to MSR_IA32_DEBUGCTLMSR are unconditionally
> rejected if the lbrv module parameter is disabled:
> 
> svm_set_msr() {
>         ...
>         case MSR_IA32_DEBUGCTLMSR:
>                 if (!lbrv) {
>                         kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
>                         break;
>                 }
>         ...
> }
> 
> And earlier in nested_vmcb02_prepare_save(), L2's dbgctl is replaced with
> L1's dbgctl if L1 does not explicitly enable LBRV for L2:
> 
> nested_vmcb02_prepare_save() {
>         ...
>         if (nested_vmcb12_has_lbrv(vcpu)) {
>                 ...
>         } else {
>                 svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
>         }
>         ...
> }
> 
> Will this break Bus Lock Detect for guests when LBR features are unavailable
> or disabled?

[...]

> 
>>       }
>>  }
> 
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
> 
> [ ... ]
> 
>> @@ -783,7 +783,15 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>>
>> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
>> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
>> +{
>> +     u64 debugctl = DEBUGCTLMSR_LBR;
>> +
>> +     if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
>> +             debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> 
> [Severity: High]
> Is it possible for a guest to actually have this feature under SVM?
> 
> In svm_set_cpu_caps(), KVM unconditionally clears the feature:
> 
> svm_set_cpu_caps() {
>         ...
>         kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>         ...
> }
> 
> Because of this, guest_cpu_cap_has() will always evaluate to false,
> rendering this new logic dead code. Guest writes to enable the feature
> will inject a #GP.
> 
> [Severity: High]
> If the dead-code issue above is fixed and KVM accepts the write to
> DEBUGCTLMSR_BUS_LOCK_DETECT, will the hardware silently ignore the guest's
> configuration on VMRUN unless the guest also enables LBRs?
> 
> AMD SVM only loads DEBUGCTLMSR from the VMCB save area during VMRUN if LBR
> Virtualization is enabled. In svm_update_lbrv(), KVM disables V_LBR if the
> LBR bit is not set:
> 
> svm_update_lbrv() {
>         ...
>         if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
>                 enable_lbrv = true;
>         ...
>         else if (!enable_lbrv && current_enable_lbrv)
>                 __svm_disable_lbrv(vcpu);
>         ...
> }
> 
> Could this create a state desynchronization where KVM accepts the feature
> but the CPU ignores it?
> 

All these issues stem from AI reviewing the patch in isolation. The Bus Lock Detect
feature in SVM is enabled in 5th patch of this series, so, the hunks in this patch
are not dead code.

>> +
>> +     return ~debugctl;
>> +}
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709082953.69434-1-shivansh.dhiman@amd.com?part=4

