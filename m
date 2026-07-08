Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F12D23B9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531201; cv=fail; b=MigKMBOvNSHbaDteO3tAhhjZeun0JpHq2lrjCfHIIk78rBYlsUPUcZPPyTIIO02AACNE+qa+fIPEFVJ9sjRhGrOSU5VI4eaKD4fsrrS6KG24mCXlGzbQbdo5hD/rhM2jo77OuwdEmRk+yw/EDH8JMvigVQvvzToLj7hOTnYVIhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531201; c=relaxed/simple;
	bh=WjnUzTDEk9VEhcPwqr3Cn4hYL2PUoc4xXmTH/x69zDg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=XcYzIUTClOtWccL63SktD2Pwct31omYLSJLX2/bqMqqc/Lk0L0yiCaGdGmG4pc/xMaaQmNSCyXFSP2Tp2Z9dQCkXDWzGkX/e7pGnz9vdmDTHGJgryPaVOMAST8+iZVQ2PuNqU24lFGMasS0AXvsHXx6Jn0JmHKAXLcw2V+slAxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t84wdbvH; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t84wdbvH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEybInjBit2Pa6A6N+iL8yuTanYohzOgRbWlqZrD/E/R7UW9lorhK7DwW+REG/dl5BMCj+8xF1GLsK4lOIcbV5XvMLO8wDcqQjCaJGM7Y+pdsPxjw7vGDu3OTCM/DgU15dm1y5gKCV209l6xoHfuGJJgbvgU8rexankvfuE4VegslI3aG4jO60e1+wpxySpGE+nGPnztvN8iZnJXoX9byfeSpcG1w2yBJJ37ayxYf96dSraHeu/K7/Y1QeAR8cmCqiN2+WpdBAOZMfYwbyE0HFb51r4gtregSf3g+jntfnEwJbLdSieHEF1h/gPErugLaHr7LrTUswuSeyd4ddv09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFerGGWe6D5cClE+MleDboNW4kZqUCjOubEmsZnMQO4=;
 b=uQSQ6rYhDjA6yBQmbc8Sl94VLpkIPR6WwC/XMNMLJfbmUhEQoZ+j+ZeAXjZdRR7biKwoZkn26StvvBbRf3IrhtSmf+TNMhv19eu+uPuTdvirSUVsjdSc1pxblM1P5GrGtMP10qRu/7R2ayjHlnJLz9IZRHUnQcIT4OBBrgJCwtPmzKs3W29QaW0ZIedx1UyIVGFb5RTNLuxQil0DI4B7JfCfZ85fanBZ1TvQTphbPieaZoFOB+uj6Madnmuc7soC2gH8Wzc+FL1UKLP80FrhrlbOAVN+1jeCrn/HjHub6XEEhM8Adapb5S+WcLf2jdvV8yGgS+o9IvqomA0jACiLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFerGGWe6D5cClE+MleDboNW4kZqUCjOubEmsZnMQO4=;
 b=t84wdbvHclPUnxPrEGxEgD4xt88KDUeg7io+PyRzONxCTk8cC520YSo9QTjNodoAkj4ECtA2VAwwYeI6XYTEWxPQc0KzhPj96gaWorSDamjwowCWg/DJegqrjQG1ITklzd1OrVoyyDnvEhadyLHNhMfmBZnvd32wNSIywtQDIv4=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Wed, 8 Jul
 2026 17:19:54 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 17:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 17:19:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 12:19:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 12:19:53 -0500
Received: from [172.31.188.211] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 12:19:52 -0500
Message-ID: <5feb5ceb-bf6c-4628-80d6-6db7ce6234ce@amd.com>
Date: Wed, 8 Jul 2026 22:49:46 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
Subject: Re: [RESEND PATCH v2] KVM: SVM: Add Bus Lock Detect support
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260629081018.60618-1-shivansh.dhiman@amd.com>
 <20260629083158.C175D1F000E9@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260629083158.C175D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba0dfd2-1280-48c6-9034-08dedd15207a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|13003099007|5023799004|18002099003|11063799006|4143699003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	J/JlsdCJtgTExCXT1Tss4t4/LLRmctz6oITcByI9EiIG7YI2ooXRsDAsSTvNvI/z7emuYPN5765h3JbOTHZhggx2TaoekQbgQ3SgUJ8H2MnDBBujL9lEM9J5nL1lwgi0uStfnlTTu5X102W7yssWzQ6wmM/4M2z8AEV4GMDi7ZSdq2d9JWVRTwrJq3WTnjCjvuGZ7K7NXF9w6/YXOr7heoinrEdlFvDegJlNKNBuPyL2mSjlzQsIFwfoq0Kp7Vo/hcmztFyQQmysZxwa8dHHDoxTvyt1J8nPxJmup/+O25OrOE6YwTY3bIGLqAiGGyjES+sah3LuG0ox3y+emzpJTKsHwCqszRJ0i48a51XFuyZP+Pj88vepRYkL9sao8JpaauIDnCbP7oqHkYWtsW76dwdkynYj3bEv1pWuCD9OHQC/b4EmgQFo3Ijhf3/pT/x5Ddry0Zkuu+sy3SdAFoD3uezobRnKt7R4EnQAW5dvIc8iUusyRUvw9eUZ/X6qtGYFbZlDjaSOeHO47wgTju73UpLsjt8PCUHxM7gG2DwWqaSToVKHpw6GXQGduS7eemzm5BLfjqOZRH+jUOvVO1pYxZ8uf4iVGX4Cz9A9OxSU6yjU+3sDEYlsO1s/uzE0sLLZJre8qC70mlXWXFDOG009bg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(13003099007)(5023799004)(18002099003)(11063799006)(4143699003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cFaRm2kGEOs4B7IPXjkw8589/1350kkcyyCzVpHNdBS349Qisj5tquzVcGZdRRI1zlsEvnHQ7EZGXB7RWfdzGy/iWBrFQ1n8C/mgzTR6rst0AsAS0x/1pNBPtrJoDwKQAhA9Ev7QvJ+cCnEqqaexH1OWD2TKwHZ1JIFK6KeozfkAJ6+WE7qtHXClm8ih1Eyaj+jk/VSaIuWO6HEfcC8LUQpHt2IPTMFXF91QWu05oz6mRQrxvXumoyfXCaBVTxoc8pQkCsYsFefUAczEwTT3KdY/Q4WFd349vQ7nm68WlSASAn+/Umtc1Bg2O9tDGv4ehpw7fhqKssy+2PYeokIgcibLLHSSnJVvT31A3TIIMXuQ7Uqb8GZdJOLOT2qG0twgeYYJao0YZnlF9XHQBCn2mrh87DL1HzGm5UBYjDmZXiBIkKFydcq105tKen2ghR8Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:19:54.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba0dfd2-1280-48c6-9034-08dedd15207a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3



On 29-06-26 14:01, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Nested DR6 fixed bits are manually calculated incorrectly, breaking architectural invariants for Bus Lock Detect.
> - [Medium] L1 guests can bypass CPUID limits and enable Bus Lock Detect for L2 nested guests via the nested VMCB, even if X86_FEATURE_BUS_LOCK_DETECT is disabled for L1.
> --
> 
> commit 859bd7557c537342acbc2ffe091acc01a0a180b9
> Author: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> KVM: SVM: Add Bus Lock Detect support
> 
> Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
> MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
> Virtualization is enabled. Add this dependency in the SVM.
> 
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index c1485c3e691c4..4fdc58d38afe0 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -808,7 +808,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
>>
>>       if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
>>               vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
>> -             svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
>> +             /* DR6_RTM is a reserved bit on AMD and as such must be set to 1 */
>> +             svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_FIXED_1 | DR6_RTM;
> 
> [Severity: Medium]
> Will this assignment cause an L2 guest to incorrectly observe DR6 bit 11 as 0
> if the guest lacks the BUS_LOCK_DETECT feature?
> 
> By bypassing kvm_dr6_fixed(vcpu) and hardcoding DR6_FIXED_1 | DR6_RTM, it
> appears KVM fails to force bit 11 (DR6_BUS_LOCK) to 1. If an untrusted
> L1 guest without X86_FEATURE_BUS_LOCK_DETECT runs an L2 guest and writes 0
> to bit 11 of vmcb12->save.dr6, won't the L2 guest read DR6 and incorrectly
> see bit 11 as 0 instead of 1?
> 

Good catch! The DR6 should be sanitized depending on whether Bus Lock Detect
feature is available or not. I'm thinking of using kvm_dr6_fixed(vcpu) for this.

>>               vmcb_mark_dirty(vmcb02, VMCB_DR);
>>       }
> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 716be21fba335..c65dc3acb5d1d 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -783,7 +783,7 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>>
>> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
>> +#define DEBUGCTL_RESERVED_BITS (~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
> 
> [Severity: Medium]
> Could this redefinition allow an L1 guest to bypass CPUID limits and enable
> Bus Lock Detect for L2 nested guests, even if X86_FEATURE_BUS_LOCK_DETECT
> is disabled for L1?
> 
> Looking at nested_vmcb02_prepare_save() in arch/x86/kvm/svm/nested.c, it
> copies the nested guest's dbgctl MSR value directly into the hardware VMCB
> using this mask:
> 
>         svm_copy_lbrs(&vmcb02->save, save);
>         vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> 
> Since this mask now allows the bus lock bit unconditionally without validating
> against the L1 guest's CPUID limits, could an untrusted L1 guest with
> X86_FEATURE_LBRV write DEBUGCTLMSR_BUS_LOCK_DETECT to vmcb12->save.dbgctl
> and successfully enable the feature in L2?
> 

Better to sanitize the debugctl too, and allow enabling Bus Lock Detect only
if it is available.

>>
>>  /* svm.c */
>>  extern bool dump_invalid_vmcb;
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260629081018.60618-1-shivansh.dhiman@amd.com?part=1

