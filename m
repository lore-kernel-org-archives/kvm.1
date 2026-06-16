Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB662BE655;
	Tue, 16 Jun 2026 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645644; cv=fail; b=FSAtcVvKyOcjBwWKbBy8blYgqGVRZa998qB/REoevNJGw4srW2x2OYEC79MKGt1T5kcoBMiWDwsPApIgorwIDDiNJRuzCl3VVmjRJvRbLpngiH6xjsHQy7M/jOLXUnA9KVMy2hIdUJWiPExR/2NsiRxNr2Sx/Hk0FSpZgdvLuOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645644; c=relaxed/simple;
	bh=UXEVVwT/UHPCMToASyvLw6Go1ErsfkLZikd8tsmQKrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kLcpO6giOZ0emU2Vb2/xk6KCmTbIaHq3YM2LpucQMHLPfNHkHXbEBcA7Z9D3wXmQRsWEtXElL9VhgSYPoGq5Gu2k19qiK3maJzPDly9zCOd5LwQ+xy4BXC8Zj5uVhV5gISi3/31io1NdfOeDXLohRyupNW+wG9MmzVT52I1qo3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z2KyqZ1f; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z2KyqZ1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb+5vkaXFm8+wMYhjUtO8EAH4j3g4YGRFK8kuxId2Ghere24AlmjmjFaAat89ccAVln0yDDfrs4ipEo5c/8ocbk/b8nLrFp33zStS5lvwBGf3x9ylWhzVNhdv0LzK2ukUg7AtFYh9BayPYyYJ199WwaVPkrh37/GjkQCbey8yzCMPG+or8sEPvv0wneUWbhcp5AXTYXwqlUScfd97c4wM9D96LyQgcOILGg2aEjmUYC52bP9MWHwTNyuJdSIYKlbsrR4N09kN2qL0GZDyJ8u0Ei+iaT1LGCqdvqrIvJM16uZHDy/dVikPLqH9j7X+V5oP0kwa9s5o12F6nO2LBSFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3874bLORBLLFjvZdOMkoFkwgYBpRWzrHg+VfaMLv63w=;
 b=p+WghkvF2680cJYsco56Nrgoyg6nWYiQWuGaUHYDi0MLuok0AoL2wF8f48ZKNpoDUIe0caVZJTGJNOSxZTGPJMkZmjgtV/otH9aT2e4lIX2xNOB/001KIRl3iAU2zBl2pYfx7yzoxfi0ECJBAFyatPDO2fyFqjDufn1Cg5tGNd6XeDf/81jBwo773PO+hfRKwPTgXSbHRQ3ngQbQX3ROyvzMIw7Lw+ycELjFAzsL2NMO7DGSDympABlcgRwt+ahwOxykAlkfFqENhxrQN74VSmTQJY6tE5lWXzmRRATfUyFoMY3UeJwTbft8TxDuc4J8dkIEIcWHLMSU7xET6TYbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3874bLORBLLFjvZdOMkoFkwgYBpRWzrHg+VfaMLv63w=;
 b=Z2KyqZ1fIJZ32lg/XTg9HQ6SeHOpJnV23NewBIlCnbt8N3rbU7Pe2MLeVBwdNJ6ROHrBDwPXVMITTqkdejCRqeD6nPalQmF9nZvQUwVHXEDOwuu12zQkBaJnrm8U1WLzBMHEmKbtfIi9kiHypq0NYj/vg1tbT2vx4oHBKcsteUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 21:34:00 +0000
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2]) by SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 21:34:00 +0000
Message-ID: <50db7538-317d-478f-b897-e7b73c5ba094@amd.com>
Date: Tue, 16 Jun 2026 16:33:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kvm: svm: Defer VMSA allocation to LAUNCH_FINISH
 stage
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev,
 Joerg Roedel <joerg.roedel@amd.com>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-3-joro@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260611123528.572255-3-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:610:50::23) To SJ2PR12MB8136.namprd12.prod.outlook.com
 (2603:10b6:a03:4f8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8136:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 75744b24-1342-4640-c2e5-08decbeefa3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KQYezfRGWnPNnYs9YVYzHnma36T4Kuaiek8VukhCqwqh4JEVCKnwoJTetbSgCRx0kLKxerCXckkUArsP1VezKd1rlQeXCTaJbgi4iXZXJlX0T4So4tL2+Mjf2daAQ103ZzSzKEZWmhOTTbyJgFQI1mHq6iTwgjWTGviA2NPkBypQsgtflFCg+KtOP9fDM8fDVOuAW9r/LlxLaokQB1Lw9IXl3fLR4ZVR9eerGAdrMRNQR1k8uTyfcrSgh91uBVKT37fp+RS4FtJCE4Z8g52rmC0F1p2uEnp8/bdgTp0GVI4wH6PMDjvewyMh63rUZ5zdetegvoQRUBqTq1RH50cN3KAaqt4czNSG0VRkh0YsDdjhNrg9l5z6rtRUEUAPbqd1qXD+1hNczWwwcHXzYrJoOO83Yzz3mtiKVXnvZ6zTDOwnt7XjX+jMQWwgWOJlOUfbEf3iQUDXt0b9nmDb3iWoPUS3cW0ZCqA89tHHHv4vV4VNVUpMq9CTBaQQJ4pkjzv17AmtvbUQJ3lfES5mIOpHFzU0qZ97J1W7qDSmW2ZdQSKYSpsWQ6RxwzosRfTnU+sowXQPPcxWJTASKCmUExDKyJnZSsD3/W75E12/RTOahHnfSe0YMnR7VrIEqnWTkYjbqfEBMC0VwqajfN4pjoj0KBE9z1Z4ilDkQBCbrPRQ1rriO1uo97SOwx1w8HeTuD5n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1JwdDdBV2lqUjM5VnBhVnM4UlZRbk5IcGJTNDlMZWNEZnNocTgycFJhL1Ax?=
 =?utf-8?B?aUxycGVBa1BZMzZCMHNjT0I3VTBNMlM0NDgxRi9yZnRYZFhKcGtsa3lFdEE5?=
 =?utf-8?B?ZVQ1MHJiNXN6dHIwbmllM0VDM1Y0dWZiNEd0bjhRclZLckYzM0QrNDVTZ1li?=
 =?utf-8?B?V3lFOSttR011NTlPbC9WN0l5ZkZZUEpCb1hySmsxdGJERSs3bWN5QXg5TkNG?=
 =?utf-8?B?bW5Rd1ZhUWlFRnpTTzg5RmhldElLdFJTUmNQV3ptL1NPeVcxWmNGVFRsUmV5?=
 =?utf-8?B?eFBQTzZ5cWVONlZ3L0lhMVhwRFdPcGdGR0FPWHEyMWNOM3lNSGJVQnNFZDdK?=
 =?utf-8?B?SE8ySEovTzdtdXNqdlBIVUl4ZWloNUQ0cDhPUDNIc005Y20vcm9PcDNSN0du?=
 =?utf-8?B?MDh6M0N4NnF6M2dhRWFEcG5lVUlEaHpzQUtkZmk1NlhJNm9RV3NRR3hvWGhn?=
 =?utf-8?B?Y3lnNTdPQjFqZXZJQ0pFamJqekF3YUZ4cjhTVlVNdVdaT2IwR1cxZlFzZTRx?=
 =?utf-8?B?dmh3NWtHcVFrY2d5MlMwdnZSNGN2b3pVMGdoSWRNNS9FOHBVdnVWRkZZcndu?=
 =?utf-8?B?NlRZYjg5cDNxSDBMQkE3U3VyaGlkSFZ3ZjgwTi9mSFgyUzU3OStpTG8rOURP?=
 =?utf-8?B?REZZM210cXdDK3JtVkpFdjRIeWZqWnkxb3oxcTFYQUxUKzk5L1RLYnp0WHZG?=
 =?utf-8?B?WnRlclhuTGtnU3o3b0hYQyt3MXo1NndKYXlJS1FRcllqbGQyZUFJRFlGQ2Ry?=
 =?utf-8?B?ZzJpMGtnaXlBOHlISnBFZytZS2tVbkpjVGpQOWJ5SjNTV2duM1pQVzNNLzhx?=
 =?utf-8?B?UVhGVW9sQ2NUcW1TWElyT2hDVEk0SlBlSU9EdEdaMmNpMklZaWEwVWI1REl2?=
 =?utf-8?B?bzVITGwvRHZhRU0xWEppbjF2d21MTXJLek9NWGtpb3Y1YVY5TDNQQXNvMUJP?=
 =?utf-8?B?b29OMi9vdCtRcWFRQmt6d014Y21adktYNjlEQ01GVW8waFc0WlpJMmlnTTdL?=
 =?utf-8?B?MzVyblNaTENRRG5YWTZVaGZEUSttOFJqT0VWTWMwM0U0TkJyU0daU2JhT0NZ?=
 =?utf-8?B?dUdSUVh5eElMWlBHd2RVWlRBZG1aMWc2NDZyOUtrWU1xUG5MUDJ3MjVEWE5G?=
 =?utf-8?B?eHNWU1lTZVlBZzQ5Q25DRmxsL2VOOW1hSGpiTG14U0YycVRIVWRCQml1eG5v?=
 =?utf-8?B?T2RvQmpMRGI5Wk13dDRFeWlwVGYxdVRBOEhpTWRQdDNFRms5blI4cVZxMWdU?=
 =?utf-8?B?T1lqM1UzZXFmNDNpUUdGR0l5alNOTllETEErSCtOcG1OQVMwTDZPc0w1U0tH?=
 =?utf-8?B?SjV2d2g3cm8yQWVlMS85d2J0VEEzc3NKeTJ0ZHhwdDJwcng2UjFyTnQ5MSsx?=
 =?utf-8?B?SmtONjhEVGhWdkVOVTVLNFR1ZTZ0OVhqeGlIaFEyRTJWc1RISy9tZUhnRDZ3?=
 =?utf-8?B?VWNRcERUMElhZ2VyTGhOKzVXMUZLTEc0TjRDSWxuVTNJenYwaTdQSHZFRGZP?=
 =?utf-8?B?Rm5YN3U5UnJPL0w2N3I1MXpDM05tOGtxaWFHcmtDVVF6eStRUUhHdDgwYUhx?=
 =?utf-8?B?RW9qNzJsTVRReEZ3VndmZ05Gdnp1SlJYT0VON2NMMEhzbGlnb3p2RGJRS3p6?=
 =?utf-8?B?TFdmSENIcnpXc1dUa1Vxc0dEQnlINGxUNXozWjNoZHN0RkNVaEZTVU1JTHRz?=
 =?utf-8?B?dGs4UEJQQXZPL1JuKzlZc3YrdGpta2w5L3VRVGl3Ym1zUkVmSjZUZVJwR0Jy?=
 =?utf-8?B?OU9pWDdvQVJhNDdNUm91VHN0UUxSMnJtazVIQlB6NTltUmdCc0MwbjBZSmc0?=
 =?utf-8?B?ZkM1RXdDaHMrNUl1d01iYkplMll0Mit0dk13WHlQYzlGRVJEVE5EVW1PWFdu?=
 =?utf-8?B?OU9FRWF2aGZESE55QkZ0eHlNYUNMYkU1RlcvQlpiUmEvNmx2VWozNHBuQVhK?=
 =?utf-8?B?ZU9CWXNDMDlwRG05NjFSa1pCS0JzU1FIQXk2VlE1MStRcktQUFpST1YwZ1Rz?=
 =?utf-8?B?V00yZGd3UTFmU0p1QjU5emFVb09adWZvcm1jTkRiZ2NGbVpkVGlsZmNJdDlz?=
 =?utf-8?B?Q01pTG5oNnNGTDBPaFNyQ2tWZjVUL0J1dmVzNnBCU0syL1FGR3Jhck5pZUJT?=
 =?utf-8?B?VlpxVXkxRFlrbEY4cmp1cW1jb0VSdUx3ckRNQVdod0FyN3NnellxSlhDMmJY?=
 =?utf-8?B?b0thRzNVZ2dLdGk1NU1BRnNIVjB6NXg5alVkWGhGRHF0U3hBV3ZmUlA0VTdj?=
 =?utf-8?B?VmNrc2VUMHc2cnFDUFI1Nk01VWo2RWhKWWgrTHBNN1ViaFZvSDhwbG1mU2xX?=
 =?utf-8?Q?2oLfNO+B/ykw++CU4m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75744b24-1342-4640-c2e5-08decbeefa3a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 21:33:59.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUWgpNVD6cf3LlqCvmm/gRIpoAynNo/F9xI73yyj5f7p6X9iXFoeSNwrsGrKyKPrWQKy6i2VQXW5ZxsfySL3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921

On 6/11/26 07:35, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Do not allocate a KVM-managed VMSA for all VCPUs on VCPU creation,
> defer it to the LAUNCH_FINISH stage of SEV-ES and SEV-SNP. At this
> stage the VMSAs get used for the first time.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 9b1280222e20..350bb97c32c0 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1095,11 +1095,11 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>  {
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
>  	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
> -	struct sev_es_save_area *save = sev_es_vmsa_ref(vcpu);
> +	struct sev_es_save_area *save;
>  	struct xregs_state *xsave;
>  	const u8 *s;
> +	int ret, i;
>  	u8 *d;
> -	int i;
>  
>  	lockdep_assert_held(&vcpu->mutex);
>  
> @@ -1110,6 +1110,12 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>  	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
>  		return -EINVAL;
>  
> +	ret = sev_es_vcpu_alloc_vmsa(vcpu);
> +	if (ret)
> +		return ret;
> +
> +	save = sev_es_vmsa_ref(vcpu);
> +
>  	/*
>  	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
>  	 * the traditional VMSA that is part of the VMCB. Copy the
> @@ -1196,7 +1202,7 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
>  {
>  	struct sev_data_launch_update_vmsa vmsa;
>  	struct vcpu_svm *svm = to_svm(vcpu);
> -	void *vmsa_ref = sev_es_vmsa_ref(vcpu);
> +	void *vmsa_ref;
>  	int ret;
>  
>  	if (vcpu->guest_debug) {
> @@ -1209,6 +1215,8 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
>  	if (ret)
>  		return ret;
>  
> +	vmsa_ref = sev_es_vmsa_ref(vcpu);

Maybe just a comment above this that indicates if the sync was
successful then a VMSA has been allocated and only now can you get a
pointer to it ?
> +
>  	/*
>  	 * The LAUNCH_UPDATE_VMSA command will perform in-place encryption of
>  	 * the VMSA memory content (i.e it will write the same memory region
> @@ -1237,6 +1245,9 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
>  	fpstate_set_confidential(&vcpu->arch.guest_fpu);
>  	vcpu->arch.guest_state_protected = true;
>  
> +	/* VMSA encrypted - put it into the VMCB */
> +	svm->vmcb->control.vmsa_pa = sev_es_vmsa_pa(vcpu);
> +
>  	/*
>  	 * SEV-ES guest mandates LBR Virtualization to be _always_ ON. Enable it
>  	 * only after setting guest_state_protected because KVM_SET_MSRS allows
> @@ -2689,12 +2700,14 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct vcpu_svm *svm = to_svm(vcpu);
> -		void *vmsa = sev_es_vmsa_ref(vcpu);
> +		void *vmsa;
>  
>  		ret = sev_es_sync_vmsa(svm);
>  		if (ret)
>  			goto out;
>  
> +		vmsa = sev_es_vmsa_ref(vcpu);
> +
>  		ret = sev_es_vcpu_vmsa_make_private(vcpu);
>  		if (ret)
>  			goto out;
> @@ -2710,6 +2723,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  		}
>  
>  		svm->vcpu.arch.guest_state_protected = true;
> +
> +		/* VMSA encrypted - put it into the VMCB */
> +		svm->vmcb->control.vmsa_pa = sev_es_vmsa_pa(vcpu);
> +
>  		/*
>  		 * SEV-ES (and thus SNP) guest mandates LBR Virtualization to
>  		 * be _always_ ON. Enable it only after setting
> @@ -4914,22 +4931,11 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
>  int sev_vcpu_create(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> -	int ret;
>  
>  	mutex_init(&svm->sev_es.snp_vmsa_mutex);
>  
> -	if (!is_sev_es_guest(vcpu))
> -		return 0;

If you leave this here, it might make it easier to add things in the
future should something be needed. Just tack them on at the bottom. Not
necessary, though.

Thanks,
Tom
> -
> -	/*
> -	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
> -	 * contain the encrypted register state of the guest.
> -	 */
> -	ret = sev_es_vcpu_alloc_vmsa(vcpu);
> -	if (ret)
> -		return ret;
> -
> -	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
> +	if (is_sev_es_guest(vcpu))
> +		vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
>  
>  	return 0;
>  }

