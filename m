Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847A3D9542
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106034; cv=fail; b=UPWAnWROyvbXZaywHRETK6Q9cEvpXt7xF+brQoqS6z10y+zYzmYm6dteM+8W3+r0tjwvtQjZmvEX+SC0nCz9/tyRejf8crOWJffq3iNgC7TJ2l+AiXkQTFdx8hBtZAIT/mydysADp4E+lBzrjz8aTEasCnqB0xPvDeDIRED9o/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106034; c=relaxed/simple;
	bh=gnjtEhKllffonXolLVLECL6AbZn2KbQs9nQBR52c+Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZtdtKRKe7NEmcF94GmjX+FhfaeNDddbo187BJM5blrNrz+1PFivYNp62w73bUEqYrRGdWM45jcJPT7PpXO/f+XYxxLr7OoT5MRVG6upjlKTXxOWKhsc3KPCfU3+caepq3TQzdI7ctIW0mhAR8cvG0cOYPvVPewbHIpzoz9rHsnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E+22Z6/d; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E+22Z6/d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUJIWrjGymGcPKVOfK9EhI2UDwhUxQqNMIj1Shb1QWte7DsS9sdv9NnP3uCBcjtz17QchP+P11r/vzGpxRUti/xNFWJSnCGTpxf2DUgF+JrE5AWOV8bFJGRXGdaWoEniVckUzt9qwrz5r3jfI01cC0CdIXz1Mi5HDDJnrFlbx4PbuNCSuNIb2ha74GiCkYylpGwS13vn8tTt2P6sZA6zxtyp397FTVP37SY0K1GTckgVcHZEqAD51TlnM0oaUjrcC4q6shTXIVRVOAB+isAI62KO4li0TnW0Yh4TqA2RQP4+J7Q6ZXoKqkNIGOym4w0zqTdGlnNNxkp93cOevq192g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxYeFp63DGwg4AtqPX4h3HtUS8b6+nmn3Kw2XTuv/sw=;
 b=kAGB0ChwtTROEgVfdFm0j/vlfmFw5e/jq76cCOzxMQWY+YH1HVHVszqqqpR7Ccg/8aQLZ9W1G6n82yU9pw5fvYPT6h4LSBuELr60+m4OnXHSAwzP+thZQ9kXmq2MjQtQTbGnZXX2w0AJ0p9XcBgjfSfvIl3t+Bi89AxW1W6Sap0SgvxNCNfQuQzWWBYl08O0Q/MEVybvZJvoqMakchot+/T7y+7q4yxR7Lt3KWMFHgWBbrrzom43Kqpy0ea1yfcitYKHxvDfWIbjnEUUD0aTLA78iyQtMMJH56C2dhfZfgRixp6tsrdtHXp1n+J5U8j3twdA0/7xUoTmqqYMObPXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxYeFp63DGwg4AtqPX4h3HtUS8b6+nmn3Kw2XTuv/sw=;
 b=E+22Z6/dcEn2W5RuNn6f2f4NK1Ef2VU0O1BcrNLxFhSnFo/5JPwbrMrJZxpg/lyL6qZh8dhXG3bLWqHGGVgE02nDtj9wCXc4u1iJSAofgyBsGT2YqVPCITI6vwAtB4FfqXASg6andYXGBmXEi+pNgHZu65KmbjrpDNWXHpmuM6s=
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 09:00:23 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::20) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 09:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 09:00:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 04:00:23 -0500
Received: from [172.31.178.83] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 04:00:18 -0500
Message-ID: <bdccb813-66f3-4002-a2a0-49ec6f093bb7@amd.com>
Date: Wed, 15 Jul 2026 14:30:17 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits
 dynamically
To: Shivansh Dhiman <shivansh.dhiman@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-5-shivansh.dhiman@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260709082953.69434-5-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: c578b911-7997-4161-cb24-08dee24f8169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|4143699003|11063799006|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5kI6Xt0ex06g75UAZi9aC2FP9X3HlwNnIopn5JgXVL45BIUaFf4BUqb34jBNVyAXB4UMHEE5/eqc2yZRwEtnCxHHmMjPP03W1KJvrdQvE+EtDh/CI43wWp80cFm8VaGHJxp68wbydpKjSZNieyjUh+px3UC4RqYUlsqjy3PKyvLLYHCBCpiVsPK1C2Ji06ztuLsgCMhR8xmwbyWfzrE/0oBsw3xSECZkZ3RlELLqSmBfzoweWS4GaDMCnwTdTsPHYwTDAvlzKz22t8cHRBsEXa0HyNTIUAoQUfk6Vx/EktKuxJQ7oN3xUJVsc5/jlgY//2gXWy4nSMJFz0mPtpjMXoBFrfTjEEtw6S2WFANi6LnpPhFLRyuO4+YzK2+H5wU72CbQY6BPFjbsy/JsO49uuEYHTCUSNBUKSELhy0rkhhIfwqmC4sBHU03FkyZ6z6JQH9qsaCKptq/RsufKxkgBG93G9T0A9NJbcou83Idb6NcMYTz/FDl7aRVFIIStSdOhjkzVAX7dun2zNw1MAfr35vZEdhc4VG0OXt7b8S8Jcg+1N0ZGJ4m8uuKM9eYbHN/pw3Gl9WdcnbcHDkVpyOtVoSrLoYQ+DdWtyoHkm7eLd/H0e3EEfS52ClDIexVbzycrQXtaBr4SMqIfVkiBh5ok/x90wnWVIDLaFD2Va4CWCZg0qs7Tglnx4sp469sP2Ht6gyMOO2kAUmU0YZILdEE46g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JiaO1wGXckDCrLtRMwwxsZcZymDhYZab/OcrLTZ+XjapIq+PK0VINe1e5i8dIY5Py8H9u3yZePXr06Ba+eVsDh+UUXjvK08V0ws05rwNm4tFYqULDEWFSaC3Mh0AUP0eRtRPkjC8DSUfTcxzZpjSoeV7ITG484LD1O3zjHaEEkSYSADhP2ZCWp+PiqGCAZ8UF+byqmiVzWJJ+dMHzSH08mizp/rRXKI1mOeOV3/yah8oQKbvPxGzTZTn4o+UYjt8g29scOxu+k/oJFuMDem/9JklgE7niPpuA2NexqpE1debWdXabR/uNZQk7AbQr8kILY0+BSHq9pusdqEGlOlxLXPJRLCxCSPN77RtuPYFyaDjyfMmuUYUq4EOw4bhJcJ09vbINo6BE1zwn6Gd4KNLPKlYxTA3Lk3iFMbyXqQtbyBZCxN2dwdJMCMI9lVwGPbT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:00:23.4285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c578b911-7997-4161-cb24-08dee24f8169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032



On 7/9/2026 1:59 PM, Shivansh Dhiman wrote:
> Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
> svm_get_debugctl_reserved_bits(), that derives the reserved bits from the
> guest's CPUID. This will allow DEBUGCTLMSR_BUS_LOCK_DETECT only when the
> guest supports Bus Lock Detect, on both the MSR write and nested load
> paths.
> 
> Plumb the vCPU into svm_copy_vmrun_state() so it can pass it to the helper.
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---

LGTM, this will be effective when BUS_LOCK_DETECT is enabled in the next patch.

With a minor nit below.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> Changelog:
> v3:
>  * New patch.
>  * Replaced the static DEBUGCTL_RESERVED_BITS macro with a per-vCPU helper
>    that gates the bit on guest CPUID.
> 
> ---
>  arch/x86/kvm/svm/nested.c |  8 ++++----
>  arch/x86/kvm/svm/svm.c    |  6 +++---
>  arch/x86/kvm/svm/svm.h    | 12 ++++++++++--
>  3 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 0a9e28a02692..4dfccc2deda8 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -821,7 +821,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
>  		 * svm_set_msr's definition of reserved bits.
>  		 */
>  		svm_copy_lbrs(&vmcb02->save, save);
> -		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> +		vmcb02->save.dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
>  	} else {
>  		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
>  	}
> @@ -1204,7 +1204,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>  }
>  
>  /* Copy state save area fields which are handled by VMRUN */
> -void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
> +void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
>  			  struct vmcb_save_area *from_save)
>  {
>  	to_save->es = from_save->es;
> @@ -1231,7 +1231,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>  
>  	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
>  		svm_copy_lbrs(to_save, from_save);
> -		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> +		to_save->dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
>  	}
>  }
>  
> @@ -2072,7 +2072,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  
>  	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
>  
> -	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
> +	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
>  	nested_copy_vmcb_control_to_cache(svm, ctl);
>  
>  	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index cead8f99d856..a59389c322da 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3164,7 +3164,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  			data &= ~DEBUGCTLMSR_BTF;
>  		}
>  
> -		if (data & DEBUGCTL_RESERVED_BITS)
> +		if (data & svm_get_debugctl_reserved_bits(vcpu))
>  			return 1;
>  
>  		if (svm->vmcb->save.dbgctl == data)
> @@ -5037,7 +5037,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
>  
>  	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
>  
> -	svm_copy_vmrun_state(map_save.hva + 0x400,
> +	svm_copy_vmrun_state(vcpu, map_save.hva + 0x400,
>  			     &svm->vmcb01.ptr->save);

While at it, the wrapped call can be collapsed to a single line.

Regards,
Nikunj

>  
>  	kvm_vcpu_unmap(vcpu, &map_save);
> @@ -5081,7 +5081,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
>  	 * used during SMM (see svm_enter_smm())
>  	 */
>  
> -	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, map_save.hva + 0x400);
> +	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, map_save.hva + 0x400);
>  
>  	/*
>  	 * Enter the nested guest now
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 8d77c10cf4f6..402a827f622d 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -783,7 +783,15 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>  
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
> +{
> +	u64 debugctl = DEBUGCTLMSR_LBR;
> +
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> +		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> +
> +	return ~debugctl;
> +}
>  
>  /* svm.c */
>  extern bool dump_invalid_vmcb;
> @@ -873,7 +881,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu);
>  void svm_free_nested(struct vcpu_svm *svm);
>  int svm_allocate_nested(struct vcpu_svm *svm);
>  int nested_svm_vmrun(struct kvm_vcpu *vcpu);
> -void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
> +void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
>  			  struct vmcb_save_area *from_save);
>  void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
>  void nested_svm_vmexit(struct vcpu_svm *svm);

