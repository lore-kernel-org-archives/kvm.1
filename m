Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42129EADC
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666021; cv=fail; b=SWIz0leiMcs8Mpw9QfB6iBXC+i3XAO43mZOwBWMhVrXgLc3BMcXopjXQaWK/UWJ4boIj3luXvETouN8v5VIJ1NFBRZGrMJwBNWzy06DouNoxvFYDww99jIGIqcv0NAlaJYkuBgqPxhHHaWZLjIuYlUeqNXJb934vOJ3B+WvXR8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666021; c=relaxed/simple;
	bh=2syXbdxx21cczJ4XtCaK/iznAvYJscrhL8UcS5ovrJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A0YVHf6JjhXeFCDeNqmMuHmx6wdoSkS9AUhcxycEJOQuYwumPejd9erCLSWOze83d94Tj65riLgtYBRqXPZB7OK00lWnJVMtwd/XT9jKm+rQyrTMQRATaZpzhAuLS+kyHuoe2F/pqLbRDhY85GNvlmcrJsBrbd6yhlrGvf0Fkh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3GiKaEcQ; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3GiKaEcQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhy+BKh0qgHViglhWNsKWpeGnHjVblYkV8YPRYsnRxRd0T+QXx7rWqdiBKGqhv+/YBa2XB5xR2j6rwdcBBHJc/mtcCtujvGtx2Wn2mlPK4uz5q3uWn1WcCv6XsJh5P8V9JJSfsKQ/xXki1nfkBN/icmyZQwWYLqpZ/VBGyveGoYJJ6BigVS7PfFZdM6aJiUGlRHlFMue2rnNPYsBgPaLLSXxYQ+KYQli19myNzK/DysHBXhQZmfn6ZU+WKKrUmIQ3ne/VANJEy4nnZOVtLR0U4vwJpoWmekO5RxPsoCiEifK5zbq0ia0OxLlfKfY6cW7MgMrJnn7H5NU7yRuCdyK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKlh5NL4N6f2HdSZ/HAfIx0ecxzstOmhWUFfZiqo3bg=;
 b=dQ0oaL2U3177DTH3KYGrS/vIpi9Ni+n9nGIU+cx6YxowAhTH66wKMQQWKD0t0r7Q/lyaSXAuTTykx3buFg4ngdUnP4/V2jjtbRA9HBizcD1bCMbxgC/F61AAw2EHlh7YGikZMys58qWgfs5iAOrJhc177PTDw4Bv0D6y8ZUi093UZ701bZyp20xPVQG32++2sopV+1XSj7pX6AV7yp6efB2g/lFEmsLBbCrm5ouN5Y2seU/IGAGO79GozynPDg/rQ+0a7YnBP51vpKMCm/2INqhUEZ2B31vhJ5Nhg31uOwNjwYGG7+TpVgv52q8IvZN1h0aFm6A7MyG8Gg0C1v4E2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKlh5NL4N6f2HdSZ/HAfIx0ecxzstOmhWUFfZiqo3bg=;
 b=3GiKaEcQQN6c1+ObDkl2TVONXef9TNPp6428+LSSU1punmHL8SM7lJnPO0U6LqG3ZSKtnT9Rj85i3eHVgtJfW57PH2gcRFETMzbBwSUTJoNx7dGmJk6grSO/hQlIHlJABz0PdDXM+9gk4eGwMxCUcZpPku/UOFkrjtP0lPuLXm4=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 13:00:10 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::9d) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 13:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 13:00:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 08:00:09 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 08:00:05 -0500
Message-ID: <4f0d5601-9580-4a11-9ca8-7f242d3f0c6c@amd.com>
Date: Mon, 16 Mar 2026 18:30:03 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] KVM: Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 for
 extended APIC
To: Manali Shukla <manali.shukla@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <santosh.shukla@amd.com>,
	<nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-7-manali.shukla@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260204074452.55453-7-manali.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5b1a24-61b0-40b5-094e-08de835bf4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nTKQt0fdVudZAldcW/qnqSeTBGe5RpH+1jJwTyTvf6ixBfBwYU9Y7QOWaaD7KjnEDu3CPkiZ6eryQRzY0IVY2jS+QOIsYHbOU8KWncV26/aOSugB4A3ecivSUVKJFdmPaR1UIX1zo0Tx152u79mEMdqxEI8DhbH0i/OCTh7EoOlxcmcMAuM6ikeIdjvAQ+0g3O7cfLQonPOukC+NiL6J/DshZlw9Dgp1v1oNEnulpwg8KaTyKAMSnuCSnMCOzih03uHUmw78oR4XznhNiRqoyokufnHcK24BKD2k0dn44/iH+RYUC5KnXFMr3tV3IKQQtyh+s/jPJEWQwUnICPoSWs1/g87wDjGR5R+kgI/1xZbwKZHzOHs6Y8nnT3biSy0sBkVLfKZ5H3nQnYTc8AjaDYd7iUb+SfAw6p1gbM4N9EPT/8fkTTRuk/O+mHJZ1bP7GeZswBxPBz/cldVBK8jtz7+Kw4FLxSSIEZgJtariWSb2W+u8l8iwZVySBgFNcXUWGcUr4tazOVS0hZqEJ/pzf846lbz5wHO8c8bNgdTrxDl+PBGYsCCZYsSMqBUcaNUOI+mIvJldYBMubaqB42FN0y1Fi0fgYEeo1lEQkxSMe9tMNKLKR13JUQG5qbwAaEh34FExSVY2F5eOXLpkqWiA9qyoX2vxSjvhV/7UjhZLqgvVV6YphzBYwY6sydMQjbAoXm9RY/gzetdDDKMzN+BeWxN4ERFhyc7aJ6l9vRO4qJY1oybirTOdqR+mCmPPTMp+pDip4JJ0whxacWH+AFz4cw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ov/Py8UP4D9wFh5eGePnH67R4lVILIGZhlOLQkx0SGq36+VR1oY2eI//pLhmDZM88YvjitFrEWp477nAoEMvwHfb0+4H5KDr6d3DfkGjsdRLugD6H5ZMP+eDNlSVBHlNiUu/bNS3fgRZqOsLmdpHgObI6E1yRH6otHUX+pArpaVIa0Wy4yXbn2r4Ke5wQwDODzb/as36SrePNE+tTPSptI/ewK3+5EjTZy/NUlsc7Gln5wa/lJkMp5ah398D5T91OgVuQJsEuWiLGN1DupCdVVXLqT3W1pXcQXI+dDVwxwZWRvvYAQdygjLUiwi7pCRM5dUiLWzPM76GFcRqMWgJ3OvPl1CsCg1qPHUIwvFsecf5DPhXeQm0bB3v7iCRh7B/D41+ebzRQbGOnTJDUQn54e1mEfoYCXAR7hvspeXJ+haPh2JOivBTuXtq+69F8GWm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:00:10.5070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5b1a24-61b0-40b5-094e-08de835bf4d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189



On 2/4/2026 1:14 PM, Manali Shukla wrote:
> Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 ioctls to save and restore APIC
> state using a 4KB buffer (kvm_lapic_state2).  The larger buffer allows
> saving additional APIC registers beyond the standard APIC registers
> supported by the existing 1KB KVM_GET/SET_LAPIC ioctls.
> 
> The 4KB buffer size matches the LAPIC2 capability, which enables the
> full APIC register page including extended APIC registers for AMD
> processors.
> 
> KVM_GET/SET_LAPIC continue to work as before for backward compatibility.
> Document the new ioctls in Documentation/virt/kvm/api.rst.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  Documentation/virt/kvm/api.rst  | 45 +++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/kvm.h |  5 +++
>  arch/x86/kvm/x86.c              | 59 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h        |  2 ++
>  4 files changed, 111 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 71b4d24f009a..c49cf3104b2c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6517,6 +6517,51 @@ the capability to be present.
>  
>  `flags` must currently be zero.
>  
> +4.144 KVM_GET_LAPIC2
> +----------------------
> +
> +:Capability: KVM_CAP_LAPIC2
> +:Architectures: x86
> +:Type: vcpu ioctl
> +:Parameters: struct kvm_lapic_state2 (out)
> +:Returns: 0 on success, negative on failure
> +
> +Reads the extended Local APIC registers, including both the standard APIC
> +register space (offsets 0h-3FFh) and the extended APIC register space (offsets
> +400h-500h and beyond).
> +
> +This ioctl is similar to KVM_GET_LAPIC but operates on a 4KB APIC
> +register space that includes extended LVT registers available on AMD processors
> +with the ExtApicSpace feature.
> +
> +::
> +
> +  #define KVM_APIC_EXT_REG_SIZE 0x1000
> +  struct kvm_lapic_state2 {
> +      char regs[KVM_APIC_EXT_REG_SIZE];
> +  };
> +
> +4.145 KVM_SET_LAPIC2
> +----------------------
> +
> +:Capability: KVM_CAP_LAPIC2
> +:Architectures: x86
> +:Type: vcpu ioctl
> +:Parameters: struct kvm_lapic_state2 (in)
> +:Returns: 0 on success, negative on failure
> +
> +Sets the extended Local APIC registers, including both the standard APIC
> +register space and the extended APIC register space.
> +
> +This ioctl is similar to KVM_SET_LAPIC but operates on a 4KB APIC register space
> +that includes extended LVT registers for AMD processors.
> +
> +::
> +
> +  #define KVM_APIC_EXT_REG_SIZE 0x1000
> +  struct kvm_lapic_stat2 {
> +      char regs[KVM_APIC_EXT_REG_SIZE];
> +  };
>  
>  .. _kvm_run:
>  
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 7ceff6583652..516d4a0be25a 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -129,6 +129,11 @@ struct kvm_lapic_state {
>  	char regs[KVM_APIC_REG_SIZE];
>  };
>  
> +#define KVM_APIC_EXT_REG_SIZE 0x1000
> +struct kvm_lapic_state2 {
> +	char regs[KVM_APIC_EXT_REG_SIZE];
> +};
> +
>  struct kvm_segment {
>  	__u64 base;
>  	__u32 limit;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 669c894f1061..ccd16bdff56a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5331,6 +5331,17 @@ static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
>  	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
>  }
>  
> +static int kvm_vcpu_ioctl_get_lapic2(struct kvm_vcpu *vcpu,
> +				    struct kvm_lapic_state2 *s)
> +{
> +	if (vcpu->arch.apic->guest_apic_protected)
> +		return -EINVAL;
> +
> +	kvm_x86_call(sync_pir_to_irr)(vcpu);
> +
> +	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
> +}

Should this function verify that KVM_CAP_LAPIC2 was enabled for the VM?
The KVM_CAP_LAPIC2 documentation states "This must be called before
creating any VCPUs" which implies userspace must explicitly enable the
capability. However, this ioctl doesn't check kvm->arch.nr_extlvt or any
flag indicating the capability was enabled.

Looking at how this interacts with kvm_apic_get_state() in
arch/x86/kvm/lapic.c:

    int kvm_apic_get_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size)
    {
        memcpy(regs, vcpu->arch.apic->regs, size);
        ...
    }

The function copies 'size' bytes from vcpu->arch.apic->regs. Since
sizeof(struct kvm_lapic_state2) is 4096 bytes and apic->regs is allocated
as a single page (also 4096 bytes), this works. But if the extended APIC
capability wasn't enabled via KVM_ENABLE_CAP, should userspace be allowed
to read the extended register space?

> +
>  static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
>  				    struct kvm_lapic_state *s)
>  {
> @@ -5347,6 +5358,22 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
>  
> +static int kvm_vcpu_ioctl_set_lapic2(struct kvm_vcpu *vcpu,
> +				    struct kvm_lapic_state2 *s)
> +{
> +	int r;
> +
> +	if (vcpu->arch.apic->guest_apic_protected)
> +		return -EINVAL;
> +
> +	r = kvm_apic_set_state(vcpu, s->regs, sizeof(*s));
> +	if (r)
> +		return r;
> +	update_cr8_intercept(vcpu);
> +
> +	return 0;
> +}
> +

Ditto, shouldn't it verify the capability was enabled before allowing writes
to the extended APIC space?

>  static int kvm_cpu_accept_dm_intr(struct kvm_vcpu *vcpu)
>  {
>  	/*
> @@ -6203,6 +6230,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	union {
>  		struct kvm_sregs2 *sregs2;
>  		struct kvm_lapic_state *lapic;
> +		struct kvm_lapic_state2 *lapic2;
>  		struct kvm_xsave *xsave;
>  		struct kvm_xcrs *xcrs;
>  		void *buffer;
> @@ -6243,6 +6271,37 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_vcpu_ioctl_set_lapic(vcpu, u.lapic);
>  		break;
>  	}
> +	case KVM_GET_LAPIC2: {
> +		r = -EINVAL;
> +		if (!lapic_in_kernel(vcpu))
> +			goto out;
> +		u.lapic2 = kzalloc(sizeof(struct kvm_lapic_state2), GFP_KERNEL);
> +
> +		r = -ENOMEM;
> +		if (!u.lapic2)
> +			goto out;
> +		r = kvm_vcpu_ioctl_get_lapic2(vcpu, u.lapic2);
> +		if (r)
> +			goto out;
> +		r = -EFAULT;
> +		if (copy_to_user(argp, u.lapic2, sizeof(struct kvm_lapic_state2)))
> +			goto out;
> +		r = 0;
> +		break;
> +	}
> +	case KVM_SET_LAPIC2: {
> +		r = -EINVAL;
> +		if (!lapic_in_kernel(vcpu))
> +			goto out;
> +		u.lapic2 = memdup_user(argp, sizeof(*u.lapic2));
> +		if (IS_ERR(u.lapic2)) {
> +			r = PTR_ERR(u.lapic2);
> +			goto out_nofree;
> +		}
> +
> +		r = kvm_vcpu_ioctl_set_lapic2(vcpu, u.lapic2);
> +		break;
> +	}
>  	case KVM_INTERRUPT: {
>  		struct kvm_interrupt irq;
>  
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index cb27eeb09bdb..f45d313e30ae 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1339,6 +1339,8 @@ struct kvm_vfio_spapr_tce {
>  #define KVM_SET_FPU               _IOW(KVMIO,  0x8d, struct kvm_fpu)
>  #define KVM_GET_LAPIC             _IOR(KVMIO,  0x8e, struct kvm_lapic_state)
>  #define KVM_SET_LAPIC             _IOW(KVMIO,  0x8f, struct kvm_lapic_state)
> +#define KVM_GET_LAPIC2            _IOR(KVMIO,  0x8e, struct kvm_lapic_state2)
> +#define KVM_SET_LAPIC2            _IOW(KVMIO,  0x8f, struct kvm_lapic_state2)

KVM_GET_LAPIC2 and KVM_SET_LAPIC2 reuse command numbers 0x8e and 0x8f.
While the _IOR/_IOW macros encode the structure size into the ioctl
number, this still seems unconventional compared to other KVM ioctls
that use unique command numbers: for e.g. SET_CPUID / SET_CPUID2

#define KVM_SET_CPUID             _IOW(KVMIO,  0x8a, struct kvm_cpuid)
#define KVM_SET_CPUID2            _IOW(KVMIO,  0x90, struct kvm_cpuid2)

It would be clearer to use unique command numbers like 0x92 and 0x93.

>  #define KVM_SET_CPUID2            _IOW(KVMIO,  0x90, struct kvm_cpuid2)
>  #define KVM_GET_CPUID2            _IOWR(KVMIO, 0x91, struct kvm_cpuid2)
>  /* Available with KVM_CAP_VAPIC */

Regards,
Nikunj
