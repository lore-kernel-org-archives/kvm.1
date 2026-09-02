Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427E390239
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339153; cv=fail; b=RnBk58BybJHCMMpFcaJhONS44Irm8NhZBuU88CO2hjZoG8fjDC/IQkYHlgg78uQvGPjigmWqY5TA3WYE9XFRSAf1C6zRzI/RiByYNudGFD/T4AIlYu26c4dPxN4NdgTklA24h6k4O+wPigItHhq4miHCnozvNAc/4ioK6xCe5YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339153; c=relaxed/simple;
	bh=GiQNLHOdzkQcQAZ6RNWmKxGybCSaB3x/PiosSxDxbi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YhJwqoOKxWbm9uEYuGdZIKrHRFr/Z8BlbQupjg3xPSel+jW0E5hJOaR/G38Tcs/V3H2CMxxZgI8rvwpBoim9yzOCk6/R1pPCFgE2C6GqTrpbNXtd1H1w/KEGsb9xg81F1W3SU/JrERGneU8ub+njzCWz7wMJxdP+K7fOwHFztCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1l5Ea4Ue; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1l5Ea4Ue"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw4xf4Qcu9PsLJywboPRbEfuu0WhZj8n4EAD5Qmeg+HBi+ek1l6d/CDTmNC9LfFz7KnSPkDViuHTw8NB1l76N7WR/KmG5J21I3zVxr54iABJXW1z69I/gdMGS5WuqD5Y8MYY63Z3Okb/YDHPOiK57rEMXu3/JbnM5L6f6lI8MhYhK1NhSoeVoi9TU32Y3HxjMxhaa2/P828QnjQcQWcMQf1cbSH6w1aEOQLrmU6d3PDPQ9M4ec/GTaxWL+CC9fiM+S448Amxsd3J/sX0MeasHTMGoVXkGp7Yr3cz2HId/zvbjGrnUAYEJShVxkT54mL2vbey9fg4UnB5PcbhmYgqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqRkUcBEmLUSPz+4+f+mmumuAza+PeX/fRwfDJw8VSA=;
 b=LRvEyt3/Q4n3RG2RtpgU1GMJv7UkyYFP4Tjs5PWnTYESzBPeRscC2AhwlJv1CkqJVbDmy0JSbexwzjThNnXnFp2b8rFP9MDmffSL2dTzggVUaA1Exk9nn55AOscvGy+z5bVIHBVpkZrPFfrLsZMinDRoz5DMLByqlK0FBE9cASKSNN3FDBjNA5997k0RMZMlZgkl5FOTG6M4W70nC6RXhCA5klyKcG1JFcTZtqi8UFUYoimccIjCnn8TZBWi4zGf8FOQmt3e7P26sVNSLX4F91O9OVaCFNe09Bb4SRhzP+eyJdnsjIG3giuMFdDMIt24dFO3deE28GeB9pZ4j2XMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqRkUcBEmLUSPz+4+f+mmumuAza+PeX/fRwfDJw8VSA=;
 b=1l5Ea4UeESggSfqX9kyftUr+wDozlpZoKE1lQMXi5YY8d4hoYnKz/4/9G+LsHhNURdpDQ4wQIyOTtO48z9rCmswBi8LDIxuEE0h0iH5XwpE3i3HU+fIZutAhdtq/aokiFGyTqzwk1Tw1Py2zVoGRaZuQW5qAgLDm9HKfLc/J1u4=
Received: from BN9PR03CA0623.namprd03.prod.outlook.com (2603:10b6:408:106::28)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:52:27 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::3b) by BN9PR03CA0623.outlook.office365.com
 (2603:10b6:408:106::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 08:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 08:52:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 03:52:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 03:52:27 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 03:52:24 -0500
Message-ID: <6e22fa3d-b443-441f-8717-3c544f5aeb59@amd.com>
Date: Wed, 2 Sep 2026 14:22:23 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7.1] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<kai.huang@intel.com>, <kvm@vger.kernel.org>, <thomas.lendacky@amd.com>,
	<yosry@kernel.org>
References: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com>
 <20260529063833.1660791-1-nikunj@amd.com> <apdpQ4eUkXODO-bI@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <apdpQ4eUkXODO-bI@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 2caf9458-fa9d-444d-2cee-08df08cf840d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jYtutTZfUs9GXB2jIfQ48ki/Cb22ESTKSCrvUUbLW3BLJ4P9r1MHvMaw9FaZ0Ljrm2LrOaYpMItzakjTaXcdBv9wsxozL6tjBUc+tGAFfvSGz7pyyM7pkmrZcc/V1d2+ti2wnDPa8wN/BzOAi9qsK2msHbazOoxZ17oBadUR4Ln9CRPBSePn2BtnNvi1zG2BJEbD4ERcDFWthX18SEenAvyJucQ1VFHfaAluEL1XCC7sdLMC44AFdEtWYngC9FySZ9me3k4y0Jk6xi2OxWoJh6UCs9aN9Hc2JY5h9FRGh2fjzJVAGUeA0Zi5n99yDxqKL3kU5iw7yrBD4FeTfYv9D3TIib0+KJ/52rSISrBDFEiIMzxwLIwiOF8AIPklhqRcOpVZFhE9dQKJI8u3McZqtSjcjs3/q4fyKPrGSb6fxC5C4/MqvAgwi6B74XWdioM3VgjE5ANxipbTcH2CAafzCTxGtBbn9diMnuIfzvLfzhbNOXzz5Wmt6TdwHl5cYnHe2xWm2vZT2aBhJxD5T9E5QA5mJlbpD9msIyH6rqx5xNZEB10m5BoLv+OZ6Lypp6rr7quC7P6ok6V82raqKKRXdbpuCMVsmuXnHpbMvGNbQej+7UdrUKBZDUQwHaHPozkGeHUY5Z7eMJ9yDE9klbW+JdzCvTDz0n1doG+OZ3YGQkF94yxKGDrMeKsvKzx0UyJ4tn9qzA58i8sUW5c0x2tO9A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B9t5LcaYQX8UFipz0xuxT14qkNTpOKx5phqXmH09GopqFA1i6ppoOYLo+le26ooK0S5i7IsW+/SiD/6lN9TTPNp8S1XS1narrMG+JLZ1lA9PBdBgF1vAh09mfQdL6mmeRZ1fiF9ckQKwIL/Ctr+lgL1PBA8ne1Pv60oyHCd7d9Y3boeUDnuEsdeK3c/JhLKmLCfh8sVAP6wGtQoqtVeSrNqYM+JzMvUbl+CJG/uqjhEOZRHW3OHXwmRIpcipSa24t9iq62MlOMychmxl91O8APPyFr0GyLKOtleEi42GBUcP5suoybhJnrNYK9PqSj9yyAaOWsp7L4uuiHRoovA6z7XX0t7nO4eI1H53LaXxcmHz7Vnw0u+JheshMKlbfUshwDqttlsTAHIxYm9GyBZ+d3tyN6Zm2vN3vsLfC3Yb99rKlTBOXLf0maUBlwUDXp6r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:52:27.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caf9458-fa9d-444d-2cee-08df08cf840d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471

Hi Sean,

Thanks for the review!

On 9/2/2026 5:39 AM, Sean Christopherson wrote:
> On Fri, May 29, 2026, Nikunj A Dadhania wrote:
>> @@ -3331,6 +3364,53 @@ static int vmmcall_interception(struct kvm_vcpu *vcpu)
>>  	return kvm_emulate_hypercall(vcpu);
>>  }
>>  
>> +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> 
> This can be static.
> 
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	struct vmcb *vmcb01 = svm->vmcb01.ptr;
>> +
>> +	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> 
> This can/should be moved to common code.
> 
>> +		return;
>> +
>> +	/*
>> +	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
>> +	 * code, but in that case another update request will be made and so
>> +	 * the guest will never run with a stale PML value.
>> +	 */
> 
> Ditto with this copy+pasted comment.
> 
>> +	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
> 
> And this check.  E.g. (incomplete, needs to be split up)

Sure, will refactor into a common kvm_update_cpu_dirty_logging()
wrapper in x86.c as suggested in a separate pre-patch.

> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 0a8ef0b4ddda..73564619a61e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3377,20 +3377,12 @@ static int vmmcall_interception(struct kvm_vcpu *vcpu)
>  	return kvm_emulate_hypercall(vcpu);
>  }
>  
> -void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> +static void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct vmcb *vmcb01 = svm->vmcb01.ptr;
>  
> -	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> -		return;
> -
> -	/*
> -	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
> -	 * code, but in that case another update request will be made and so
> -	 * the guest will never run with a stale PML value.
> -	 */
> -	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
> +	if (enable)
>  		vmcb01->control.misc_ctl |= SVM_MISC_ENABLE_PML;
>  	else
>  		vmcb01->control.misc_ctl &= ~SVM_MISC_ENABLE_PML;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0052446e04d9..828a51418d83 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8416,21 +8416,13 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
>  }
>  #endif
>  
> -void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> +void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  
> -	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> -		return;
> -
>  	guard(vmx_vmcs01)(vcpu);
>  
> -	/*
> -	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
> -	 * code, but in that case another update request will be made and so
> -	 * the guest will never run with a stale PML value.
> -	 */
> -	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
> +	if (enable)
>  		secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_ENABLE_PML);
>  	else
>  		secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_ENABLE_PML);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 33715236afc9..4443796c4426 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8073,6 +8073,21 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
>  	kvm_x86_call(set_apic_access_page_addr)(vcpu);
>  }
>  
> +static void kvm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
> +	 * code, but in that case another update request will be made and so
> +	 * the guest will never run with a stale PML value.
> +	 */
> +	bool enabled = atomic_read(&vcpu->kvm->nr_memslots_dirty_logging);
> +
> +	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> +		return;
> +
> +	kvm_x86_call(update_cpu_dirty_logging)(vcpu, enable);
> +}
> +

One subtle ordering change for VMX: currently guard(vmx_vmcs01) is
taken before the atomic_read; with this refactoring the atomic_read
happens in common code before guard(vmx_vmcs01) is called.
The ordering flip looks harmless to me.

>  /*
>   * Called within kvm->srcu read side.
>   * Returns 1 to let vcpu_run() continue the guest execution loop without
> @@ -8238,8 +8253,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		if (kvm_check_request(KVM_REQ_RECALC_INTERCEPTS, vcpu))
>  			kvm_x86_call(recalc_intercepts)(vcpu);
>  
> -		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
> -			kvm_x86_call(update_cpu_dirty_logging)(vcpu);
> +
> +		/*
> +		 * Note, nr_memslots_dirty_logging can be changed concurrent
> +		 * with this code, but in that case another update request will
> +		 * be made and so the guest will never run with stale PML state.
> +	 	 */

Looks like the comment got put in two places; will retain it only in
kvm_update_cpu_dirty_logging().

> +		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu)
> +			kvm_update_cpu_dirty_logging(vcpu);

...

>> @@ -5465,6 +5570,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>>  	.gmem_prepare = sev_gmem_prepare,
>>  	.gmem_invalidate = sev_gmem_invalidate,
>>  	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
>> +
>> +	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,
> 
> Please keep the ordering somewhat similar to the other declarations, i.e. don't
> just put this at the end.  This seems like the least awful place:
> 
> 	.handle_exit_irqoff = svm_handle_exit_irqoff,
> 
> 	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,
> 
> 	.deliver_interrupt = svm_deliver_interrupt,

Ack, will fix.

>> @@ -832,6 +833,8 @@ static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
>>  	svm_set_intercept_for_msr(vcpu, msr, type, true);
>>  }
>>  
>> +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
> 
> And this goes away.

Ack.

Regards,
Nikunj
