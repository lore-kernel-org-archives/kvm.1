Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677E3C8708
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108303; cv=fail; b=S3oGbQgnuFtPPH87iGlrAU+g1UsCVaKMV1s2PAD71/Si56qs6Ab7c1CIt+1jYCKrv8Dk/j4YGXar2Heb+soFcFleYHl+mMdjUwz7oOJP44aBAaeAMw7Ol+19sx2+7S2GV9xBNbog6OCcCDI/HOeU1c1vqtipV0cfQgeqVwWetis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108303; c=relaxed/simple;
	bh=bs3YEiUcqGUCEoa16qGLOUomGnAO4ZJLHzg4QJaoNJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZpIn8XWBUy7wAfdeTrkN0+59S1dptqFa7IZOHLnPGxORo1rmnDW2KrtmLM6a+/HGQWM9bovCo34zSEynifuv/ZzlQr1X6jcFRU9BWSGrJ7hDjefZbW4nGOAJfOgigWvIJaEVxjmbgpQqWW1Ji0iLAIQ5WIObXoXJIyjd4p6LzM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xTUO2IHv; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xTUO2IHv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDzxigiMJ85TlfujtVA+1euxj2QefZR2LC/3OuxUnSL2P24GpCYSFyQEtOk5XaQMCIBNzoQSiRv4zasnenj4PNXSjtmYGdS0sYUMUJEFemKh5WwgFlObTdhz76nJPh+B/+I8oRjPMIrHtpbM3NHNZLt/y5L8tpsOPVubzf/Pi3y7pjAq0Xc3e3svLGO8FzE/gAYKhE6iuGm4WOnZPBr3DlrBW/2mLaFBuEnfUaEY4hq+L6MQX++SOGtKfYLEUC4g/WXjaAGii1oYATwvz6G4S6+a4/clXUsLbOWZ8k+NrbtOf7VLz+YVDQyrlSWCV/o8OYxnrh87Oby1bezfao+0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlCmkR/b+9BDnbreKMjPsH5BqgxPgpJiIFQLHSz3VV8=;
 b=h71GMJRBIKoHypbicvTyyMPNR2kGj7FdQ2Rois9kxtknoZEJSDwLDNzYvrqkuoGlx3ggGPlqKxoh/vLVpkyLiRqTK/Zv3lwp9Jr0DS73O+EfPcLlt04WSNobSV7663/9sB+We20LxhULhtgzAG/z4O8DLieSVSmCb/gt5z8I4u7VIZmJwb3m8XoofYuABnYsk8zydMs4gMyHVSqzueGknU7b1AGRtO4fEMemVVtwH+NYSXkMDHFe8vYyyrJ9cu83W37k2r2hO+5R/OqMwM6HOctmInogUXauxAUfEjiwRPWRXfaJVyGTihNQhQARgVLOlHUYdz+uh3oAe3dA0ARhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlCmkR/b+9BDnbreKMjPsH5BqgxPgpJiIFQLHSz3VV8=;
 b=xTUO2IHvMkdVAk2OdFQZFkeyQuCQkvWr29ch86QHPsJIQ0WsCXzSeykGD32UgRKaeqUUO6r+GV0HYGNAhb+V5Ax72cNEcrGeIOT/LN2AeKp2srKFO8cQMoxcRmGpUJQOS7BJnvzeaXKsBptnbEOwVwu+5cD/qt1s95tCeWEb1hs=
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by LV1PR12MB999304.namprd12.prod.outlook.com (2603:10b6:408:3f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 09:38:09 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::31) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 09:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 09:38:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 04:38:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 04:38:09 -0500
Received: from [10.252.195.157] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 04:38:04 -0500
Message-ID: <8786c93c-f27d-4543-9322-007054336cd2@amd.com>
Date: Wed, 15 Jul 2026 15:07:58 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits
 dynamically
To: "Nikunj A. Dadhania" <nikunj@amd.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<yosry.ahmed@linux.dev>, <jmattson@google.com>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-5-shivansh.dhiman@amd.com>
 <bdccb813-66f3-4002-a2a0-49ec6f093bb7@amd.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <bdccb813-66f3-4002-a2a0-49ec6f093bb7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|LV1PR12MB999304:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e60cc17-77b3-4fa7-dcfc-08dee254c834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Lzwl2c4jHyOheeYRZ8ZIvD6nLs2RqYHAImigIC7Gb2uEu7OEnb/Strhx50hqJ/Uc3RCtBTU2KiGfwgeSriYY76eh3sApRCUXpwMaJuWZ0hKKVqe2GbtyKOiYXK4e9E54kaFps+JYjLUF7b23JDIeVIW8cUkRZ+3HUA7zyPEZbY4KEJ/Qs7Rf1Z4OXH56+O6yjO8Pt/tL8S+LaGhuOx1SE1mCOYn4YjKtiUkxtz98t8tTa4ts/uF5qfWy0xpp9tNQxPWYvLTKtfm6zXhJX+sYXJoE4gsHNEbkfmE8/ELQutKTRy6wkHDpqeZTswCBaBPIFIbg1HIpoGv9qruXsIchkaKBjCtQHuFY7HA0hbTaHvrwNzyoqIL7tJc/G30/1rLI9/Lj2Etr2da/8g75AXQKkOA9tgrC9oxyJ+9fAvIAto61E2Vgqf7rd7JOb8JFIL7qS3o+70jJvEWoQE2wlE13SqMPXHGf6oK+SZ2bjTwJqN23iuQb1smjm89wQxcF843AfR2nvwe//QmQgEMJhRJO1wODpjdiI43v/7R4pEyErVskuTger6xz262urvdgN3mjgl9U3WBF6NH6s9wbVW1zm/1f53d9tWqZWtftd2jBNeVu7xyo+zHBz38UFjXaQRrpj1lXNPwC33Y7yijWFrzIExvGriYoexlSIh/8r9rm4ZpprvP8L+SCqC0qsWvWcNNNmhx+VGtvIVNcNk9z/kqvPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3YHFrZrbCiG8CuMGJ5MKDqnzfhsSFmyCJeSgdgkStkhPqs90XU40St7QYXhrr9mu9/Na1ttmQR1Dbcd/zq0bdhP3X5mM50P6opeEWA2WqLF60OSGBZ7kYPVpjz64ilp2pg4G0W+sDNy/fGsbzqt+52LDSTKw84K0ceWfiPnxr4QlwbCeWRsYIpzHHiRENb9bx3zopwDw7hXth/3C0BInc99qV63C3Fhdz1QoBBv+8dhKxfjLxyDSEqmLjvlENkO2XXbzp21fWvU9znwOmzXifEL/aacWUl+0mdzHanoG+DUuLvNTR//MtBleru1nT0QvAYaFbZGv4DhakzukQPyeSJ6i45tUdysimikZc4sYRG8GeOWl4z/YruUPyxJc0VnwoaSWpG3K8dXBTZNKSJ22lMSi4JCzPIGGP74qWP3rK8znRXS0w0PrZLn2ldksSIeJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:38:09.6527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e60cc17-77b3-4fa7-dcfc-08dee254c834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999304



On 15-07-26 14:30, Nikunj A. Dadhania wrote:
> 
> 
> On 7/9/2026 1:59 PM, Shivansh Dhiman wrote:
>> Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
>> svm_get_debugctl_reserved_bits(), that derives the reserved bits from the
>> guest's CPUID. This will allow DEBUGCTLMSR_BUS_LOCK_DETECT only when the
>> guest supports Bus Lock Detect, on both the MSR write and nested load
>> paths.
>>
>> Plumb the vCPU into svm_copy_vmrun_state() so it can pass it to the helper.
>>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
> 
> LGTM, this will be effective when BUS_LOCK_DETECT is enabled in the next patch.
> 
> With a minor nit below.
> 
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

Thanks for the review and Reviewed-by!

> 
>> Changelog:
>> v3:
>>  * New patch.
>>  * Replaced the static DEBUGCTL_RESERVED_BITS macro with a per-vCPU helper
>>    that gates the bit on guest CPUID.
>>
>> ---
>>  arch/x86/kvm/svm/nested.c |  8 ++++----
>>  arch/x86/kvm/svm/svm.c    |  6 +++---
>>  arch/x86/kvm/svm/svm.h    | 12 ++++++++++--
>>  3 files changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index 0a9e28a02692..4dfccc2deda8 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -821,7 +821,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
>>  		 * svm_set_msr's definition of reserved bits.
>>  		 */
>>  		svm_copy_lbrs(&vmcb02->save, save);
>> -		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
>> +		vmcb02->save.dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
>>  	} else {
>>  		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
>>  	}
>> @@ -1204,7 +1204,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>>  }
>>  
>>  /* Copy state save area fields which are handled by VMRUN */
>> -void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>> +void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
>>  			  struct vmcb_save_area *from_save)
>>  {
>>  	to_save->es = from_save->es;
>> @@ -1231,7 +1231,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>>  
>>  	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
>>  		svm_copy_lbrs(to_save, from_save);
>> -		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
>> +		to_save->dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
>>  	}
>>  }
>>  
>> @@ -2072,7 +2072,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>>  
>>  	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
>>  
>> -	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
>> +	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
>>  	nested_copy_vmcb_control_to_cache(svm, ctl);
>>  
>>  	svm_switch_vmcb(svm, &svm->nested.vmcb02);
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index cead8f99d856..a59389c322da 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -3164,7 +3164,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>  			data &= ~DEBUGCTLMSR_BTF;
>>  		}
>>  
>> -		if (data & DEBUGCTL_RESERVED_BITS)
>> +		if (data & svm_get_debugctl_reserved_bits(vcpu))
>>  			return 1;
>>  
>>  		if (svm->vmcb->save.dbgctl == data)
>> @@ -5037,7 +5037,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
>>  
>>  	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
>>  
>> -	svm_copy_vmrun_state(map_save.hva + 0x400,
>> +	svm_copy_vmrun_state(vcpu, map_save.hva + 0x400,
>>  			     &svm->vmcb01.ptr->save);
> 
> While at it, the wrapped call can be collapsed to a single line.

Sure, will do that in next version.

> 
> Regards,
> Nikunj
> 
>>  
>>  	kvm_vcpu_unmap(vcpu, &map_save);
>> @@ -5081,7 +5081,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
>>  	 * used during SMM (see svm_enter_smm())
>>  	 */
>>  
>> -	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, map_save.hva + 0x400);
>> +	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, map_save.hva + 0x400);
>>  
>>  	/*
>>  	 * Enter the nested guest now
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 8d77c10cf4f6..402a827f622d 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -783,7 +783,15 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>>  
>> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
>> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
>> +{
>> +	u64 debugctl = DEBUGCTLMSR_LBR;
>> +
>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
>> +		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
>> +
>> +	return ~debugctl;
>> +}
>>  
>>  /* svm.c */
>>  extern bool dump_invalid_vmcb;
>> @@ -873,7 +881,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu);
>>  void svm_free_nested(struct vcpu_svm *svm);
>>  int svm_allocate_nested(struct vcpu_svm *svm);
>>  int nested_svm_vmrun(struct kvm_vcpu *vcpu);
>> -void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>> +void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
>>  			  struct vmcb_save_area *from_save);
>>  void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
>>  void nested_svm_vmexit(struct vcpu_svm *svm);
> 

