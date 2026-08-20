Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1E483BD1
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247713; cv=fail; b=TO6yDXosgZiJe0i1Gm/NvHqIxSST9JSjF5Bs6Bau83JWjETwqX+WO+lwoVWzudrNEZVdyWwQkRaO8DWK+pRZ6+WvG+Av9kW/+k43c2k0VdflvGrtmMqnl311X1HDuvlLY4sFIv7kVsMQVV/QGXt8Q+4vpq4k5tbMtlv6aGOZVsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247713; c=relaxed/simple;
	bh=6ySrbSh0OBlh+chYsokl5VWtndLobz6Ot9Ht/977NdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dHdMrcX45T4066reAOf7PaHmyRx9Qg+MX4S7E7Ze1NLtzP8WyLGw74lcg6T8PhwW9cCu7IJjxmZoj5aAyAOz2991eZlFXx5E85izG4ka8T8cm8geBzQhlCyULluk/Z4LMtwA3iUGgq2ES0ZT0vDQQldTKkmtihZcIFicD3wjQY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BImvgvk0; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BImvgvk0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfVCGsq0xsszz/mlEW7oxeDlROkFfvnWoAn8TSNNw0LB7tJkzIoMCwu5i7ePMEiqET7DsAU1MbJ6UJw/0beJ9JlNcvoV3l5IvMISUKRjZ34GxxkOFpo9JrSpokULPrtexOGV2HJ17COciZL3XkyY0gBd6pF1qJQGgxqVmTFl98ycmPp/nH7QxTFbE5bFdyFLU+QS1v2+V6CWTSSvLp8tO+OySe64qo9BntJ09iL5iY+rea+f5kl1W8hRWVSQFzHdIJB2+V8UNGwQYD8RnbNxtSghrHIO9bFiXs34Sptaga0DO1ypuEiHs/AHXgiB+sFR/HL55pbZx+Z7cRr6fzhb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvIgSxE8WErg0r23jt7MjbDdhjJxWQ0mloksL98qofc=;
 b=livE/rbTuFtBoqOWRKDE5svxp6JO3+zZ/Zax4QHFTJcXsAHTzyVDcUbBRNx3LDjs3GzjRvofxMO08H7YnRqGCBPKfJVbedPSxdE790kZxiPCb5xIAIngpJNayTTBCUmC5YV3+Wq52AWVJynhh//6vOl9hqzVI4FG+3gNJJ6lnLkJppCFpfq1+xamMviNPxVxjvuB78iR3xtnNgaIDlqDca13zfPsQuiW8ORYblmHOqmy7FP3gC1x2GK/rr3hDJewycpjKRh5XbFdbG6eY6WDHWWhNDNxMaf9TV5GXyQHE/dg8gygI+g/DP0hCpr4R09U1sux+jztmWtRfpwjYFTWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvIgSxE8WErg0r23jt7MjbDdhjJxWQ0mloksL98qofc=;
 b=BImvgvk0wzwvgTpohqTji8rRzYxIHQ1VnIoHeSbiZ08/sN1erz7OquzzqXLq6hVzxDq7Sph7gVwdRezQVkE4vPm5iFwU+soIV2Q/r04YVo+Kc4fJjIwFClBohtfu4n0eA4XJa0hXiccB4iFiOJCiOJXLUCZRPORsfbEntJ7+vf0=
Received: from BN9PR03CA0188.namprd03.prod.outlook.com (2603:10b6:408:f9::13)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 17:41:45 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::67) by BN9PR03CA0188.outlook.office365.com
 (2603:10b6:408:f9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 17:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 17:41:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 12:41:39 -0500
Received: from [192.168.1.8] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 12:41:38 -0500
Message-ID: <2874be2b-7a79-4279-a199-90ebaabef571@amd.com>
Date: Thu, 20 Aug 2026 23:11:36 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] KVM: SVM: Enable hardware-assisted LBR v2
 virtualization
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-5-shivansh.dhiman@amd.com>
 <20260724201741.A84851F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260724201741.A84851F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 585a921b-2b60-40c9-62b9-08defee24de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	H/UVsyUFn8VTBtTHSUTGuJYr9RFPb8e6wsFVbnZB7iJcmifDBClcmmMHrUVcNaK5CieZBgN7I9Lpzw1AEJWO9cUAXa2E6AVrRQ3eBy2R2lWtF9ZoCsshc4gmdIc4zLyIsmXCt6yRhtKgfVIZ5H97e/kjXI+SjE3GlQzQrqbkxrh+HnJnKRTNGUozsnhM8xI2iYjkl0Gy6YPntbZofu/f1xsC6RvRNsIqAwmeE/hpN23AFJejU/GuI2qqjHRLkjtGGuhELWGR4WYtrlAIfMxGciw8UfjMX93NQL2e6QLR94d3CNFppX2gKTk0J8E57uVDn3Mm0jBWQjiXJ/qOWRdOOz7nzIO3PPMEBxVOpPfNHfWy/5Pahi0gCzE+PtcvTV75ss+lKzs4YAraVLs4eFCtQqWsj67UH0k65Gg9Few14OWH+30GIcRWCUTRtyP1tdRNsP3TwJNZ7oz/MAytCKbCS8RzwyQ+uR7fOBbggAPX426vFoIEd6K1DctPclSa6yloIH7wBxWTyqV4qKQgsfiHvTHn1mc2oS2jLiZ33Svq2WsH/GIkI2Me15s07+vaACA7EhlLFRLC9OxWddv5gVK9qZxUaAdxIBTfCtwyKUohMrM2mLY0aZEEJKnaHv7F1yYno1V4X8QsD8KEge9ZyL4fEi4LotPSqklG2lt9Umftosf38FL9z3zyvlSgCACigyXEoDTX2YXXHsfdBIv8k/9xEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pIquacosHHf4u8W+fnyoMkmUd33+wogEKcLYUIUIrCD5egS+opp6ed4XdPqYeota5jy2/2oC6CzcrUrmuBm7yPDZHdMv5v2PacRj2UeDva1rCNx3zmbouBfWrdCsSA6ydjEdAwu/abF/9lKcajU3isjEF64R0ekPrvN7Qp16TnKzNrqN+K7MCky0SRnBsym7u9GS47f6l28FKC931U8Zfcuix74XzdYvrnIKalgi+aXnhHEMftKTM+m7BF5/1u9Q6ggBn8/BETVXYYvdiuO07FbCP7S6MYiOxfU7peW9wppN9aQ4pA0D0SmPqgMfafBZmpPoo276kqfoLDYBZgj1boMrHgUkbeblhS+nzmJYY+xAxnvkiyuRGtPEph59K+avFq2JbTSdHY/UGx0ibvXCgMDTAhMJJg7/cmAVJomkFShk3dRI9KvFiZJmziSbUTEt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 17:41:45.5497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585a921b-2b60-40c9-62b9-08defee24de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678



On 25-07-26 01:47, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] LBRv2 MSRs and MSR_AMD_DBG_EXTN_CFG are incorrectly intercepted for SEV-ES guests, causing a fatal hardware VMRUN error and exposing a KVM_BUG_ON to host userspace.
> - [High] Nested SVM breaks LBRv2 virtualization due to missing state copying in `svm_copy_lbrs` and missing MSRPM pass-through in KVM's merge array.
> - [High] The patch fails to enumerate AMD LBRv2 in KVM's supported CPUID capabilities, rendering the feature undiscoverable.
> - [High] The new LBRv2 MSRs are not added to KVM's MSR save/restore lists, breaking live migration.
> - [High] LBRv2 virtualization bypasses the global `lbrv` module parameter, allowing guests to enable hardware LBR virtualization even when administrators have explicitly disabled it.
> --
> 
> --- Patch [4]: [PATCH 4/7] KVM: SVM: Enable hardware-assisted LBR v2 virtualization ---
> commit ee1a6e59c9c7f66112084e471f36296d11c1b93d
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Subject: KVM: SVM: Enable hardware-assisted LBR v2 virtualization
> 
> This patch enables hardware-assisted LBR v2 virtualization in KVM for AMD SVM.
> It enables V_LBR to save and restore the guest's LBR v2 state in the VMCB,
> and lazily disables interception of the LBR v2 MSRs when the guest enables
> branch recording.
> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 13ac62604ca05..04e386b838d38 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -750,6 +750,41 @@ static bool svm_lbrv2_supported(struct kvm_vcpu *vcpu)
>>  	       kvm_vcpu_has_mediated_pmu(vcpu);
>>  }
> 
> [Severity: High]
> Is the F(AMD_LBR_V2) capability missing from kvm_cpu_cap_init()?
> 
> It appears F(AMD_LBR_V2) is missing from the initializers in
> kvm_cpu_cap_init(CPUID_8000_0022_EAX) in arch/x86/kvm/cpuid.c. Since KVM
> explicitly masks the host CPUID against registered capabilities, KVM will not
> report AMD_LBR_V2 as supported, making the feature undiscoverable by standard
> userspace VMMs.

This is already implemented in the fifth patch of this series, where LBRv2 is
advertised in kvm_initialize_cpu_caps().

> 
>>  
>> +static bool svm_lbrv2_active(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	return svm_lbrv2_supported(vcpu) &&
>> +	       (svm->vmcb->save.dbg_extn_cfg & DBG_EXTN_CFG_LBRV2EN);
>> +}
>> +
>> +static void svm_recalc_lbrv2_msr_intercepts(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	bool intercept = !svm_lbrv2_active(vcpu);
>> +	int i;
>> +
>> +	if (intercept == svm->lbrv2_msrs_intercepted)
>> +		return;
>> +
>> +	for (i = 0; i < 32; i++)
>> +		svm_set_intercept_for_msr(vcpu, MSR_AMD_SAMP_BR_FROM + i, MSR_TYPE_RW, intercept);
>> +
>> +	svm_set_intercept_for_msr(vcpu, MSR_AMD64_LBR_SELECT, MSR_TYPE_RW, intercept);
>> +
>> +	/*
>> +	 * DBG_EXTN_CFG stays permanently intercepted for non-SEV-ES guests so
>> +	 * KVM can observe LBRV2EN and lazily toggle V_LBR.  SEV-ES+ guests must
>> +	 * delegate LBR virtualization to the processor (per the APM), where
>> +	 * intercepting LBR MSRs can be fatal, so toggle it with the rest.  See
>> +	 * commit b7e4be0a224f ("KVM: SEV-ES: Delegate LBR virtualization to the
>> +	 * processor").
>> +	 */
>> +	if (is_sev_es_guest(vcpu))
>> +		svm_set_intercept_for_msr(vcpu, MSR_AMD_DBG_EXTN_CFG, MSR_TYPE_RW, intercept);
>> +
>> +	svm->lbrv2_msrs_intercepted = intercept;
>> +}
> 
> [Severity: High]
> Can this logic incorrectly force the interception of MSR_AMD_DBG_EXTN_CFG and
> LBRv2 MSRs for SEV-ES guests?
> 
> For SEV-ES guests, KVM's shadow copy of dbg_extn_cfg is always 0. Consequently,
> svm_lbrv2_active() evaluates to false, causing svm_recalc_lbrv2_msr_intercepts()
> to set intercept = true.
> 
> As documented in commit b7e4be0a224f, intercepting LBR MSRs when V_LBR is
> enabled triggers a fatal hardware VMRUN consistency check failure.
> 
> Additionally, because MSR_AMD_DBG_EXTN_CFG is intercepted, host userspace can
> write to it. Writing a value with LBRv2 disabled invokes svm_update_lbrv(),
> which then attempts to disable LBRV and hits a KVM_BUG_ON(is_sev_es_guest(vcpu))
> in __svm_disable_lbrv().

Currently, this series doesn't support LBRv2 for secured guests. I'll add this
as part in upcoming versions of this series.

> 
> [ ... ]
> 
>> @@ -886,9 +924,11 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>>  {
>>  	struct vcpu_svm *svm = to_svm(vcpu);
>>  	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
>> +
>>  	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
>>  			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>> -			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
>> +			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)) ||
>> +			    svm_lbrv2_active(vcpu);
>>  
>>  	if (enable_lbrv && !current_enable_lbrv)
>>  		__svm_enable_lbrv(vcpu);
> 
> [Severity: High]
> Are we bypassing the global lbrv module parameter restriction here?
> 
> Legacy LBR virtualization correctly gates enablement behind the global lbrv
> parameter.
> 
> Because svm_lbrv2_active() checks only the guest state, if a guest sets
> LBRV2EN, enable_lbrv evaluates to true. This unconditionally enables hardware
> LBR virtualization via __svm_enable_lbrv(), even when administrators have
> explicitly disabled it with the lbrv parameter.

Legacy LBR doesn't have a CPUID bit, which is why it is gated through lbrv
parameter. And LBRv2 can't be enabled because KVM capability is cleared in
svm_set_cpu_caps() when lbrv=0.

> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index f62bf19024cc0..01dae3828a7aa 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -363,6 +363,7 @@ struct vcpu_svm {
>>  	bool avic_irq_window;
>>  	bool x2avic_msrs_intercepted;
>>  	bool lbr_msrs_intercepted;
>> +	bool lbrv2_msrs_intercepted;
>>  
>>  	/* Guest GIF value, used when vGIF is not enabled */
>>  	bool guest_gif;
> 
> [Severity: High]
> Will the omission of the new LBRv2 fields from svm_copy_lbrs() and merge_msrs
> break nested SVM?
> 
> For nested SVM, svm_copy_lbrs() in arch/x86/kvm/svm/svm.h copies legacy LBR
> state but omits the new LBRv2 fields, leading to state loss across nested
> transitions.
> 
> Furthermore, the new LBRv2 MSRs are absent from the merge_msrs array in
> arch/x86/kvm/svm/nested.c, which defeats hardware acceleration by breaking
> MSRPM pass-through for L2.

Currently nested virtualization of LBRv2 isn't part of this series. Will add
that in upcoming versions.

> 
> [Severity: High]
> Are there missing entries in the MSR save/restore lists required for live
> migration?
> 
> The new LBRv2 MSRs are missing from msrs_to_save_base or msrs_to_save_pmu
> in arch/x86/kvm/msrs.c. Without these entries, they will not be included in
> KVM_GET_MSR_INDEX_LIST, which leads to silent data loss of hardware state
> across live migrations.

Already replied in reply to patch 3. Will add that in next version.

