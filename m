Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD137FF40
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322885; cv=fail; b=BnHpTqvYV3UmsJEP1sYr0ZhnMBjaIs325yXSZJ7WfXTUPsb4cmuN5sb1S0RgeGg7HqX68l5wxbmvwvgFon3VZZcmo0Y93O2cp2rwhQred+/G1C6Y+gPGmJmE61zlBGZaLDvhZW4/Omqf+kFnlbX75yj9dZgTYf7lC68Yq9ZxzLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322885; c=relaxed/simple;
	bh=e0Gb59gCobWwGIb89hWlxE+aUGaGA8Ocy3lFIRwmFxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GJXwurGeTF9fPz2qm0p5ZjNNZS2LnXo/NIThAuT6XhS1ABrMSNRUrx8Arl7giztv0QKBeJECn/4ccnxrNacIjL73qiSTixUmscytUtyWuE6rnbX0OUUlquV7EFXCYbxcGHVMAut8FByUMbnoXINovCUOpMAbuUmePXGogPai3hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h1Wj6Sx3; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h1Wj6Sx3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjZJUFNzBRJrKUdbrWJtlsQEopH2oYNYC+dq6r7WqDGxY2Hsf6xKT0e4bGoh/QJ5y+/n+ko08kZRPANM9xihwk5rV/4945SSkfOhp/1bMmJol5zMnrIbqdwnYI/CJkrXVGXqLmZyczcTu7rDzXahWusDWbkpeedBQgoppuZk0NEzmyqbHE8+68GLuJVB5Tovrlyn4csevXBAxekNrStmlGRc3wMs2JKQ6eocpoZ02IKy/5LMAhZ8sOyudLXdqXtr5bNiWgpzpu8aR8Xa27vDnaaFdZd7OQOYxZzopzmoa0C2wqapU2XXTvb2zvC3gzt9pFJ8NZn7VFtIop6z7MrxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcpV95vxvhfIyYBWIp7j4ArWMZOOuH2/JT9MVCgZ/P0=;
 b=NPNzP3bYdQ39C6l9MCH8x755xnlevXra4ZYgfEhU5mV+F2eZXrCW2xNYs1pSQBedgr+puvbyloaPTI/4hxOd9LIUaDDzFq7Ksm0nIpw3I87LC/qBf30tjZcr4Lkm7m4fpiByIu7+5hFDD12mHFd48rD483c8OkNMTYs02/TMaO+YHK7SX3Q5q1sfBDPyXm1yP4CKzf6eT2xtEIJhAL6wEJee0Xvyp6FoAQrGHDkNeo+nH58XFPvFpQZ/yaLiX9/nK5q2nC6ZM8tfcI2f1h7IKpwRzdU/cwKzBv3452KrG52qhEKE1W9Fp/d2f/nVNZqmtEjaY7f/wbSmPiOm8Ru5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcpV95vxvhfIyYBWIp7j4ArWMZOOuH2/JT9MVCgZ/P0=;
 b=h1Wj6Sx3iTCyvSvZ6G5+KMajqkg1ma3U49G1uRw8BjSpUlNV2SkLSFp9iomJkJXq5QVE/nRWVAG3+obN+w4h5kFMFbCnHvEnNraKM0kdkSHYoyJF2miuNQOBy2kag6aQfRpjbPKFgY5bwGwxyBlPB9I5z0J6xAe+zD8AiIlsLgc=
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 07:27:53 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::68) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Mon, 6
 Jul 2026 07:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 07:27:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 02:27:52 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 02:27:48 -0500
Message-ID: <264ee78b-de9c-4529-ac75-e93e68bb9b8d@amd.com>
Date: Mon, 6 Jul 2026 12:57:47 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] KVM: SVM: Add Bus Lock Detect support
To: Yosry Ahmed <yosry@kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<yosry.ahmed@linux.dev>, <jmattson@google.com>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260629081018.60618-1-shivansh.dhiman@amd.com>
 <akL5VmXwhdvVrVfD@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <akL5VmXwhdvVrVfD@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f4a103-9f57-4e60-8609-08dedb30178e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|13003099007|22082099003|56012099006|18002099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Tmo/Wug3/GXbiBCVHN4IeBdadkMT3Y6quSADLiDkf0cBDFhMl5SZOg395SYKSvyhQVhBX7HUrnZo/37+XSH7fhFZzztjodigA+wpmRg+2HOpi00aglfSJVa6gvPyKQBnYs3qnO1yUhCpk4VlneHXdj1YlL4BjcvYQ6Uv0TnJ2Ahd6sJkJtfvHZcQwxwf/v0GQuL/8A5j1Kd3mfygi/yPdPApvgTOAGtUQkBODTUKx5r9+4nEJ4HdyYlBfsL9na1HZS6/nzOHfYaHrdGhtzskM1dh+i0vUHSJaFm++NnKgcRZxbgQFBFVQ0Fr/daYMi4y+nQtdd6BIhvK7JuyJxDMbW6yMQrr6/1stVqQ5DUl3n9YVMrV+W289x5Q8+JXZLPN7L0GaxuY2baMn2IcU7Q8FM6WH0a8YlJLGrJ+sCnil3Jyrem9SZ0KP+ODvo6O4HgZ3SLG+Kthc0TydrN4V9t4LssqYkBP3ytb1VMU8LUmlUvkZZxXyP/eeg8GW4i55Z/+r/X5z7m4bymcXnO2f4KXmwfpbdeC4FFO5Xc1sSsOymeverQGZiIYpNqessWn15bQblSB4eumtqTxbMotSt8iqLUaSHxmhkQNtvAXj7KE7/7Rz/fR8BGDHZVHuOp8Qy1la9VWN2I/0iwir69RgqS/EgxAL/tD5W4J3rU7H9bV6w5p7TR8Dyvj89R/dQDY45qprTuRUocvDb9Qox8s/45eEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(22082099003)(56012099006)(18002099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mDpVdU62BfyTKhsPQmMiizbqLAUduS4ktmlnC4IMJAWkQvAR2hx1W9xgA7N1vMBEESfhqSGfySS5bEpyO4T6ZiRANQsvKwffrIj1lVRA+Pd3D6hgbz5MRARnr1eaTJO1+2YWUQp7Y+EkoIwx/bGq41AhY5HG0CN26wbmUwjWHRqTYq1kfrxru7N5Qz+N6Y7qzl486wVCwXHJOBSrnXnR2V8OEluMG0aFHxOsHPpfmP1O9Vio4TAaAzqXh7xf1N3yx5msa/OlFd3BOsKjkuvOOdBY73ikIoQPWtkwK4iL7vjmdiRyzspTkprc7GNkJ/aSZdTdil5Tzi495udzvLJ9EewM0oIQN1GU+a2+jxGWlQHYdadQXH1ogcCIDBnwb+oAu1aLzdB7Xg1C35JDKLTOOkK016iOFVMamBJPwU37SOUgXc7eIAWV61i3fPcs0fOX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:27:53.2896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f4a103-9f57-4e60-8609-08dedb30178e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120


On 30-06-26 04:38, Yosry Ahmed wrote:
> On Mon, Jun 29, 2026 at 08:10:18AM +0000, Shivansh Dhiman wrote:
>> From: Ravi Bangoria <ravi.bangoria@amd.com>
>>
>> Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
>> MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
>> Virtualization is enabled. Add this dependency in the SVM.
>>
>> While adding Bus Lock Detect support, also fix DR6 handling in nested
>> virtualization. Using DR6_FIXED_1 to prevent reset of BLD bit (bit 11)
>> between VMRUNs. However, it preserves DR6_RTM, which is a reserved bit
>> on AMD processors. So, DR6_RTM bit must always be set to 1.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>> Changelog:
>> v2 --> v2 Resend
>>  * No functional changes.
>>  * Rebased on top of tag: kvm-x86-next-2026.06.24.
>>
>> v1 --> v2
>>  * Rebased and used guest_cpu_cap_has() instead of guest_cpuid_has().
>>
>>  v2: https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/
>>  v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com
>> ---
>>  arch/x86/kvm/svm/nested.c |  3 ++-
>>  arch/x86/kvm/svm/svm.c    | 17 ++++++++++++++++-
>>  arch/x86/kvm/svm/svm.h    |  2 +-
>>  3 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index c1485c3e691c..4fdc58d38afe 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -808,7 +808,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
>>  
>>  	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
>>  		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
>> -		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
>> +		/* DR6_RTM is a reserved bit on AMD and as such must be set to 1 */
>> +		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_FIXED_1 | DR6_RTM;
>>  		vmcb_mark_dirty(vmcb02, VMCB_DR);
>>  	}
>>  
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index ef69a51ab27f..b4b0fa730916 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -884,6 +884,9 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>>  			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>>  			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
>>  
>> +	/* Bus Lock Detect depends on LBR Virtualization */
>> +	enable_lbrv |= (svm->vmcb->save.dbgctl & DEBUGCTLMSR_BUS_LOCK_DETECT);
>> +
> 
> A few lines above we have:
> 
>         bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
>                             (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>                             (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
> 
> We probably want to combine "svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR"
> with the new added check, and use nested_vmcb12_has_lbrv(). Maybe
> end up with something like this (you'll probably want to refactor in a
> separate patch):
> 
> 	bool enable_lbrv = false;
> 
> 	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
> 		enable_lbrv = true;
> 
> 	if (is_guest_mode(vcpu) && nested_vmcb12_has_lbrv(vcpu))
> 		enable_lbrv = true;
> 
> 

Agreed. I'll split this into a separate refactoring patch before the
Bus Lock Detect change in v3.

> ---
> 
> Completely unrelated to this patch, but we should probably just clear
> SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() if the
> guest vCPU doesn't have X86_FEATURE_LBRV instead of checking
> X86_FEATURE_LBRV every time, similar to SVM_MISC_ENABLE_NP
> and SVM_MISC_ENABLE_GMET.

Makes sense, I'll add that as a separate patch too.

Thanks for the review!

> 
>>  	if (enable_lbrv && !current_enable_lbrv)
>>  		__svm_enable_lbrv(vcpu);
>>  	else if (!enable_lbrv && current_enable_lbrv)
>> @@ -3160,6 +3163,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>  			data &= ~DEBUGCTLMSR_BTF;
>>  		}
>>  
>> +		if ((data & DEBUGCTLMSR_BUS_LOCK_DETECT) &&
>> +		    !guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
>> +			return 1;
>> +
>>  		if (data & DEBUGCTL_RESERVED_BITS)
>>  			return 1;
>>  
>> @@ -5591,9 +5598,17 @@ static __init void svm_set_cpu_caps(void)
>>  	 * Clear capabilities that are automatically configured by common code,
>>  	 * but that require explicit SVM support (that isn't yet implemented).
>>  	 */
>> -	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>>  	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
>>  
>> +	/*
>> +	 * LBR Virtualization must be enabled to support BusLockTrap inside the
>> +	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
>> +	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
>> +	 * enabled.
>> +	 */
>> +	if (!lbrv)
>> +		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>> +
>>  	kvm_setup_xss_caps();
>>  	kvm_finalize_cpu_caps();
>>  }
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 716be21fba33..c65dc3acb5d1 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -783,7 +783,7 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>>  
>> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
>> +#define DEBUGCTL_RESERVED_BITS (~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
>>  
>>  /* svm.c */
>>  extern bool dump_invalid_vmcb;
>>
>> base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
>> -- 
>> 2.43.0
>>
>>

