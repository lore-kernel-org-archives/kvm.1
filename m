Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591447F774
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248439; cv=fail; b=jJzMBcbNkCi1viEE7nD8T1d1A4JI0dvlZyEBduV+jpC+zAJZkIlEto1M8504Rltoyu0esyc+cecSoqxhkGenhkfXyvqdQjs92pYD0GpfdC81Dp1EOPBH3Zo4S/kFsniFIGsNzC8IRTwuPAXGy3D+ecPTpKTjryvMCKiLlsjPypo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248439; c=relaxed/simple;
	bh=6XLCKYpi4nkAz2QhV2qdOfocYvi999K2+zrD66mnlNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V5aaeCXfHW4w+CaXvGWeGDwNDjt6GaYQKDutyeaNJYc52770c3dkeDfqna+CwjUe9c2cOMNeGZH1DPU4ooWfzloNbFrt/1I/CETZfVvN+n/qa3KQxpe5DQo8SLyqZ+VSydDIZMXqcygyV8aQlpj8CxPGtG0ssPR4FDJ5Qf+NiGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Do3ylpht; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Do3ylpht"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rorufl91kGdl958VIwJd20zqDe9zr4pbasvgAFDvOoa+iP5c0yZlJLVvfb6So56DQqFKrpShTHBge2LDXVdaNzuRqudeGyuPtToznsHj95kg2iRwgH7rhOSzDV4H4kFWvznbJK7zi4Ak8P3HHQEooM0uIxBfhB3uxisl7PtqfDWpAfnSEcT6PapKviV5dmt3xm0TSwPt3epbRDyB9XThhzi/tMuvrifR+UY+nta66QJW9EoD3P7Li4x5kgM/qpJ+NLu9Z8/lhN89LEuHhgKaRXzZ2iFgvc2mrTyifgsgrfKsmvlTmbEB4cuD1E3yt8Jw797dcnuxtPkqeenFfM4PCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtvRXU+2dXMne7nyXJuuEbksDuTggJWnNYDgOIaDNlo=;
 b=kmW3dwIUCcEk7tul5me83I/pL2pPG4bmYpGDe9eCqvb4YwSbsthvMyJnRii0uJ6brHjF9llGW3JmH08Op28ZdMeNxU+o1T/++5X3nWhwrbaLxSzM3XDaNOzfbI3WJtYHzahfd5UOL1u2E+rP1nN7AO+GJlkY1AoOtrLjBZP7olg0lbgYMeC0gkdikNs08gGKBiz5heXupCrjYLMyDEHLrvMXHwbvRnJBSkB13daJQwWeieboD2KhRInhsNktJMpQv/uFeqDKWHwSOQMfYRFUbgmxjEIlJjqcbU/j8mWdSWTq4bpsmE0aQDf0e189izC43EYOb/Qk3LDubstE4mDIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtvRXU+2dXMne7nyXJuuEbksDuTggJWnNYDgOIaDNlo=;
 b=Do3ylphtW0QEvX3XmewyC+iLAocaLadgocese2e3mgy6b6ynZpIHwMzPNH7kkhWxMMFOwyJMyvpFScOqHVbPBr7S7FDJwOsDJMLmTmNlW9nAR8s9WukRGgIrYBb9W1X9wRCC2YWrxgEdDYffBQ6RwPK/E82M8mUqX/tLkvQm+cE=
Received: from PH7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:510:339::27)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 17:53:56 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:339:cafe::6f) by PH7PR03CA0010.outlook.office365.com
 (2603:10b6:510:339::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 17:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 17:53:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 12:53:19 -0500
Received: from [192.168.1.8] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 12:53:17 -0500
Message-ID: <de9c1174-eea8-4441-b01c-4d37e1fb1c88@amd.com>
Date: Thu, 20 Aug 2026 23:23:16 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] KVM: SVM: Add LBR/PMC freeze support
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-7-shivansh.dhiman@amd.com>
 <20260724201344.3816C1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260724201344.3816C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 0682e3b8-a059-4118-9cb3-08defee4006c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|56012099006|10067099003|11063799006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z3UpBT/nZTibEk9wjMe2xfINLfCR2mv0+hEXDmvxdDXQCIaYD23BlsP4zOoBroU0zlVLw2cUodkICeBfR1Dcehg3PGMgqXDRLH+Fl1bsmlA+Ryv7NWgSjbzgZ9V7w5XHzthOYqHG2yI9H3mJeP4HAkNX34EM5fwSMT05afRybaSpGB5y0jD+J7vDQAmmY4f+uMkTjhOAL749vdvJCRbUstvwDjpkFTG1lp5w8uaijn4O10xxvEbzECJe1mEQQer9XLw16O9dzMMfYT65agdInNTdxBVrqvElY6c2ahO0Otk9VDbzhTy2cLqrcrFsiH6ELdNL1d2vm/nio4oq5pyZ/SWFHvqpmUuCQs1dIfB6MyJI8edYNDHTczMKaTrLehXFBk85gBz9xfph7rc89M3pR5lKfnm/NKqVFT5RBIOwGImSeuZi9wDiCYud9UwbXQmtcP0ZepZTgmg2VNuFnVgrUdR7NmYiLuQEfPOSJjKDANyPmSMML+zw8vljfLgV7x/Ap4Kv1hRX/Uc6CMLTv+XUbZskiN0WIPzQJEJFz/OC/GLLnX8n94Z44rUm4vzGCZA5mYFmIjYWuVdcufW8HefLp8jWM8dh1LVyMZE+OCkH+DopICAq4W3P7gL1lLexTV2rddqanrmxg1xHJ2jg5tn+MHl3+fVR8aQu7GFfpDLtny+5ii+gR+fJIGfBki6G7PntslYjFdxG+PI8etrdXd7aWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	va/L8RU3hvqXC42EgIeX8/YoPYttckrBmyW6KVqes83UADS9ov16fNFipUB6i2a0AOFTgqAAiue8YkM5huEVJq45DR6YXzzazepuEg3PCVMpr1ePvvdWlVFyiW1Mg7D3b6B5NkgYltHirWXL3ALHSl7+T+ApAHFbC2ErtOkmJE3E7ykLMQfz9L/uhRw7omg158P7okko0fnxRLM2RYCltR1qcfbce5kVUz5EJwOWeMpsIZXHg+xRT7s96Tm0W79tZrnkO5QiOQQzvsOXRfGrgdibO5COH6gO425DHhHoDfgb2YNwuGlcs7kXWmU51tF3wtyKoMtQrATx8X4YcgrQyUsRN2MzirTvYjTMSKkEnLm6OLjrNPTI1CeSDMt2R9bv+Te0aJGOZM8IJZoyXLooV6SVFfrj+9nL8QyIeIg0wThprn0bFNSAGIMMM5mBv2iE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 17:53:54.4931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0682e3b8-a059-4118-9cb3-08defee4006c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512



On 25-07-26 01:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] KVM incorrectly advertises AMD_LBR_PMC_FREEZE to the guest even when prerequisite features (mediated PMU or LBR virtualization) are disabled, leading to broken PMU state.
> - [High] An L1 hypervisor can bypass CPUID capability checks and enable LBR/PMC freeze bits for L2 by injecting them via VMCB12's DEBUGCTL.
> --
> 
> --- Patch [6]: [PATCH 6/7] KVM: SVM: Add LBR/PMC freeze support ---
> commit 8a4ef61c23eb3f96d674c17183bad9ad198a18dd
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> KVM: SVM: Add LBR/PMC freeze support
> 
> This commit adds support for the LBR and PMC freeze-on-PMI feature.
> It updates CPUID initialization and allows the guest to set the
> corresponding bits in DEBUGCTL if the feature is advertised.
> 
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index d450a5b2499d9..03501b3145eb0 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1268,6 +1268,7 @@ void kvm_initialize_cpu_caps(void)
>>  	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
>>  		F(PERFMON_V2),
>>  		SCATTERED_F(AMD_LBR_V2),
>> +		SCATTERED_F(AMD_LBR_PMC_FREEZE),
>>  	);
> 
> [Severity: High]
> Will this feature remain advertised to the guest even when prerequisite
> features like mediated PMU or LBR virtualization are disabled?
> 
> Looking at svm_hardware_setup() in arch/x86/kvm/svm/svm.c,
> X86_FEATURE_AMD_LBR_V2 is dynamically cleared when prerequisites are missing:
> 
> if (!lbrv || !enable_mediated_pmu ||
>     !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
>         kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);
> 
> If X86_FEATURE_AMD_LBR_PMC_FREEZE is not cleared similarly, a guest might
> see the feature in CPUID and attempt to use it. If the host administrator
> configured KVM with lbrv=0, svm_set_msr() silently ignores writes to
> MSR_IA32_DEBUGCTLMSR without injecting a #GP, which could break guest PMU
> functionality.

Right, I'll add this in v2.

> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 01dae3828a7aa..105a71d69d68a 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -784,7 +784,9 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>>  
>> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
>> +#define DEBUGCTL_LBR_PMC_FREEZE_BITS	(DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |	\
>> +					 DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI)
>> +#define DEBUGCTL_RESERVED_BITS	(~(DEBUGCTLMSR_LBR | DEBUGCTL_LBR_PMC_FREEZE_BITS))
> 
> [Severity: High]
> Does modifying this macro globally allow an L1 hypervisor to bypass CPUID
> capability checks for its L2 guest?
> 
> In arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save(), VMCB12's dbgctl
> is masked directly against DEBUGCTL_RESERVED_BITS:
> 
> vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> 
> By unreserving the freeze bits globally here, an unprivileged L1 hypervisor
> with LBRV enabled could write DEBUGCTL_LBR_PMC_FREEZE_BITS into its
> vmcb12->save.dbgctl. Since KVM copies this to L2's VMCB without checking if
> L1 actually possesses the X86_FEATURE_AMD_LBR_PMC_FREEZE capability, this
> appears to allow a nested capability bypass.

Will add this as part of the nested implementation of LBRv2.

Thanks.
