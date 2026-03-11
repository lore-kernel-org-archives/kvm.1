Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C22DC32A;
	Wed, 11 Mar 2026 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205011; cv=fail; b=SVsSMpM7zVSZo9Sr5sVKsdKY/qRYap07rSPI48LQoJ6hq0Ypku55SEVHBSBeE7LUR7mh/0UswT21FjAqWYsBJWTLZwsOSQhY3oowLaGx3HPn0XwkU91+WUe3k2/aA9ihxoYebgcb3qu8KPL4FPs2BeO5G5Ah7Oxtb6nNRuu2Vc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205011; c=relaxed/simple;
	bh=C311zijsCCkFQROh1XL6dwWx1c2YZhS3VtKrrxuX9Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dMEcZTKvNFyDNRlC0vuTie/pDHlDFN3Sw6hNvRQM2XRvznlu0BSeGg+1GERlL5EbM9indlKfmD+ccjcDLj9700FN03BYrwdgc49YQZobNmjikBqFcmNg0vDyKgpPKTlBqGWjrd4tOEvb/Lom6ET5NvR0SgEaiC/dh2EuKJpDiJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s2IvjDzl; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s2IvjDzl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHyhb+A9jxYl1RjvliCVST73UnrTK5icAU5QyZPxSV5+V5OEdbOSxO5sGXXImeiLIKXiHdQ8grF6ISh9QgF/M3qwzPXW279k9sJvQBB1UHHB/kTFctYR74iR7CVki3EGz3W3liOAF2ujR7Fr00BQCu1Di0IXFQ26IQIiy0p86xKAsdwrn3s/P1ORsxijtO1K+NuNugeGavv1p5/G9nM/z9swNZl+dEuAxRzRwbqmyuRIpDA+gkRG50MzDRovlOuYb1ge5yQh8izSNB+ROObuz/SmMDY2QKA4cWHK2ASnlbROURt0B4pwKbCPiMpVESHUFahoz0+gJxqEUDMM7jNBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLY2OOkAR45fS5k862J2pSwfztlCK9QZUgZ3bRMsOhU=;
 b=i2hC/JKJWSgFq2OQTvb8NTsfe/uDVwdR2obZOG14vwOcsHO+7wUzrPf1H7HBzweUBMPOymRCWHkfQLLg/wXZS+ADJNnmo2ynzdZK5OJC300A+yVuW5539eXZGeUH6aQ8BYF8HgJyVEzaunMPHaizdD+4EN4NNMG5gwFWG1zVx+pHuSNdK/HgMTrzOZKrpPa48WuS+L17EWBBagFixHVD0iTrs8O2J5bIA93bI/+iJRFhP1F2eb+ojvMmUx0NA6SsISTppYhUIMNm1uqhY9uGR/mH+oCiJGr+5xLOfUxrNZFFjJkwpXFq/jZiH4w1JAVGhpfY0ealCudxSFmR7g8ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLY2OOkAR45fS5k862J2pSwfztlCK9QZUgZ3bRMsOhU=;
 b=s2IvjDzlf65LH0OtF70nCOPkgDk48hXGiz/z4zzfK0G+X1/EsI2eJOAwmWe+lOo6/CYHsIjAnAPplzbaNnkLDx13ETjGB0qeZjbL2YGPUedhNIklQloHJKW4vfzb5vA+oug0SMsC33gb8Vvt7Szcl5Rm1jcrm3B8DHdijQhVFTI=
Received: from SA0PR11CA0180.namprd11.prod.outlook.com (2603:10b6:806:1bb::35)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 04:56:45 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::84) by SA0PR11CA0180.outlook.office365.com
 (2603:10b6:806:1bb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 04:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:56:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 23:56:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 23:56:44 -0500
Received: from [10.143.197.5] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 23:56:42 -0500
Message-ID: <52031d70-b194-44bf-892d-85f667b9869e@amd.com>
Date: Wed, 11 Mar 2026 10:26:42 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: selftests: Verify SEV+ guests can read and write
 EFER, CR0, CR4, and CR8
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Naveen N Rao
	<naveen@kernel.org>
References: <20260310211841.2552361-1-seanjc@google.com>
 <20260310211841.2552361-3-seanjc@google.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20260310211841.2552361-3-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sraithal@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae39774-8868-4a44-30c3-08de7f2a984f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	oNWJsbwCtmAefaXxrPREG83u7gYBAvMqj1d+czF/32gB9slKRF54UeUbjtzJtAj0RbHAy3JiKiJkTdwuqnlkNR19RKvXucgwUGvnN92a5ZajiB030mDB67Eek/25K7Rg4ehscw9zYa9a/eE5L92a0v7Q7L2m8jHFbNAO6rGPP3mBdAX/cWMteDWQOjPWIW/IIceTfZMMuFTl+gVbLo/xb+ZCUQiNmjNyVM+iEJjECBOb/+kQivV/EWO9M89qJd2AOKaZJzykuhL2LOG3QVeJ53fGTbDo8naqzuDDE9dDbNlcHkGScg80H+vrjXOcu1Ir+yWjhj1a7lG34ysZr16+kp+sdVY8+l0X0cr2NupBWuoWEkzQVfn1OzCRIZqDhTo+oUkEsi5O14EATj9oTXcHysCGi++yJIEV0tdYbzO0Mztfa9A47u/u4v7SodTpyJu0LxXmVF3AY34eACaM1RJjt5m8Ve3zVU9DSnPO9D9T5U5iF6xUiZ9qMDzBzzzutsEuyOGGQnjbJpjt9lRn46Q8gf4iP97NRI/lySNDezVpcYB1tT2FWL2pXLGZr6IjYMyd8dupI28UWUjH+KpEZ2ZqAz138S4ahlVaW/bdGEqw+haWrpN6cCp+R03RgiTvjOCGJqwTmg165DJdrAd9+KHkT5ogIM1g592cbl+rXl9J7H8efWfh/Rf9jKtmkaN3F0fPyDKgC9CeXbVToap7/wu+qt3JlwEGufb+ek7KP3/Lv8bSc/ChwLEghpYPZlQu49KyRUMRbbX+sFa0Zx8ocUc5gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vD9EKBf5CGRbvC3ifO9/h3cno9+9hyamcezOV68Y4GpjH14Z1hJE1I45bA2HBb3LTzjjX27gM/LKMPhIartq2Jc/Ky1rSdRqf0oPf8s2KVW/fHs4fY2zwyuMKT9tgMUMn7SbPQPxHDYhLPYaDh+yms5BsO74pqpmj0PduFrN3uswz6ogZZT1zWsVArJpDYJPAifKr2HiUKEm9dBdnlctmQ+HQk/Ye24Q/n2ZsaJrOVmbWHHLclhZqyW+968hTUtqD8DuRNaf1KVtvCz4hBvkIfRQrlqjHENEI9sBB+85kK4Nq5ErgwPBIT1ByAs2H3EpPGXMDKAYXu6l4BPck71MdAL+ctyoLZc7pqYucryilDZASREq0KPhFMZQKXJUt8MoORoXbtYxLRtwPwf0iA3cK3sHluS4ooStSGbZOsnDR/g4oWGu+lNLHdG0e7mN5r8b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:56:45.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae39774-8868-4a44-30c3-08de7f2a984f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541

On 3/11/2026 2:48 AM, Sean Christopherson wrote:
> Add "do no harm" testing of EFER, CR0, CR4, and CR8 for SEV+ guests to
> verify that the guest can read and write the registers, without hitting
> e.g. a #VC on SEV-ES guests due to KVM incorrectly trying to intercept a
> register.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   .../selftests/kvm/include/x86/processor.h     | 23 ++++++++++++++
>   .../selftests/kvm/x86/sev_smoke_test.c        | 30 +++++++++++++++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 4ebae4269e68..469a22122157 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -557,6 +557,11 @@ static inline uint64_t get_cr0(void)
>   	return cr0;
>   }
>   
> +static inline void set_cr0(uint64_t val)
> +{
> +	__asm__ __volatile__("mov %0, %%cr0" : : "r" (val) : "memory");
> +}
> +
>   static inline uint64_t get_cr3(void)
>   {
>   	uint64_t cr3;
> @@ -566,6 +571,11 @@ static inline uint64_t get_cr3(void)
>   	return cr3;
>   }
>   
> +static inline void set_cr3(uint64_t val)
> +{
> +	__asm__ __volatile__("mov %0, %%cr3" : : "r" (val) : "memory");
> +}
> +
>   static inline uint64_t get_cr4(void)
>   {
>   	uint64_t cr4;
> @@ -580,6 +590,19 @@ static inline void set_cr4(uint64_t val)
>   	__asm__ __volatile__("mov %0, %%cr4" : : "r" (val) : "memory");
>   }
>   
> +static inline uint64_t get_cr8(void)
> +{
> +	uint64_t cr8;
> +
> +	__asm__ __volatile__("mov %%cr8, %[cr8]" : [cr8]"=r"(cr8));
> +	return cr8;
> +}
> +
> +static inline void set_cr8(uint64_t val)
> +{
> +	__asm__ __volatile__("mov %0, %%cr8" : : "r" (val) : "memory");
> +}
> +
>   static inline void set_idt(const struct desc_ptr *idt_desc)
>   {
>   	__asm__ __volatile__("lidt %0"::"m"(*idt_desc));
> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> index 86ad1c7d068f..8bd37a476f15 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -13,6 +13,30 @@
>   #include "linux/psp-sev.h"
>   #include "sev.h"
>   
> +static void guest_sev_test_msr(uint32_t msr)
> +{
> +	uint64_t val = rdmsr(msr);
> +
> +	wrmsr(msr, val);
> +	GUEST_ASSERT(val == rdmsr(msr));
> +}
> +
> +#define guest_sev_test_reg(reg)			\
> +do {						\
> +	uint64_t val = get_##reg();		\
> +						\
> +	set_##reg(val);				\
> +	GUEST_ASSERT(val == get_##reg());	\
> +} while (0)
> +
> +static void guest_sev_test_regs(void)
> +{
> +	guest_sev_test_msr(MSR_EFER);
> +	guest_sev_test_reg(cr0);
> +	guest_sev_test_reg(cr3);
> +	guest_sev_test_reg(cr4);
> +	guest_sev_test_reg(cr8);
> +}
>   
>   #define XFEATURE_MASK_X87_AVX (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)
>   
> @@ -24,6 +48,8 @@ static void guest_snp_code(void)
>   	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ES_ENABLED);
>   	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_SNP_ENABLED);
>   
> +	guest_sev_test_regs();
> +
>   	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
>   	vmgexit();
>   }
> @@ -34,6 +60,8 @@ static void guest_sev_es_code(void)
>   	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
>   	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
>   
> +	guest_sev_test_regs();
> +
>   	/*
>   	 * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
>   	 * force "termination" to signal "done" via the GHCB MSR protocol.
> @@ -47,6 +75,8 @@ static void guest_sev_code(void)
>   	GUEST_ASSERT(this_cpu_has(X86_FEATURE_SEV));
>   	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
>   
> +	guest_sev_test_regs();
> +
>   	GUEST_DONE();
>   }
>   
Tested this on my machine:

# selftests: kvm: sev_smoke_test
# Random seed: 0x6b8b4567
ok 81 selftests: kvm: sev_smoke_test


Tested-by: Srikanth Aithal <sraithal@amd.com>
