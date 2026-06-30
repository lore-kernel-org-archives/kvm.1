Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99E3E274E
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795463; cv=fail; b=pueqqgsPDaR16Dtay0uILzFOTYa2JShgZSPoHYSGd64+3iAOiI1kIEVEmtyHAEpEb86Dr+Z+9xuyjq97TdSXd77rxq3FFyu+sq9dP9AFc2MU2tkFr3bsu19yWrhFuICkH31g6Gs4vPnITjJTea/ZEnVj5Wp7gxUpCR4TRW92xO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795463; c=relaxed/simple;
	bh=9hiLOa3rI2A9q9uPQtq2rWZytT2DhpBLumH6XsBvuVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CS4/yKBmnWVIgxP7xy4k3Dp4NSzF7TI4R2/OFIRlB8FHKikveG7PJM7Jd2/oatIdkH5cDNtzXqK6r1FE8ROCIjpiCHxgdqNr3KEiURhT31V4pZ+l0bGqu0GO3fCXkfD54IWzelb9dD+ZmkXoRfDKMFaedjspzZJF7yMiZXi02DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W2LpWHLR; arc=fail smtp.client-ip=52.101.57.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W2LpWHLR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgZCRANm+BI1yVUhLcEu3cybHizf94AVYGX3H45EMjKHZzi8tkTzarMTRsASNIYus+zP9JYlss/vyoDxTyCovJCN3R5/6TYAWNIVcO9BkcJM2KTprBOd4LvXUtkieMB1R1PqiMvs4+2MttAzobcNGG4qgsKGDWQ50azUEjMuh3WOgwnJTN8jrMoZJp8h6VzFkwvp1YcAErrptxApbkYqIlyOPJA+3cobCkXgmpr5i+xdtBmwNiXRN5ReLkSlW3hEzu1dctyrZfz36e4yFupEsPOc3/2cgOtVugZMsGC0ypVLzbvGnt4lDK4fevLc9snI2ZqSr/RbBIdxVmmrgH5xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq2kAOJMnIDbHrdpNHwGVrmmkrwwtGfM0JfX/K8jNe0=;
 b=UmDQBMa49yu/UlIvhQ+HeaK5OcRwsoI2ZAkHbmNzNaaOJJ//qvyacIsQHX8Olmkr4p7QmRj70HjTdV+e0+r9sLwE5LMQVMJDstQGO+pVtwdNp6v5tCAfVlkC0VCAQ7spk6etKO6a6UCBk+3/ndHcxlGPDeYqhEr9OZIjv83Y9fLbzkEAcNYlEXWvl7/tN4RuhEsFXMDHJfLjMSFKCDGs65YNlBfPdez18vmNz3hAdmzXY4HF6Vv/pYrF3T5Kh3ggfzogpEWXVGc6dTRrjFnXKa2INqjufGXiI5b3WAACnQBykBq4qRtNKZqF99By2eRg8AGQ35sKHVoWtYR/g1lD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq2kAOJMnIDbHrdpNHwGVrmmkrwwtGfM0JfX/K8jNe0=;
 b=W2LpWHLRdOmIDReZAHnV5Tm5XMnVvBowjtUF7gvkNVSbuM09+xae5SBQwfPUiROPU8V7eMabpyFVD9PvxcD1LlUxvfYMHPyzN+lwhVt8Wc4CixgcinS9QU0YWfOeI/DQQn/w3i5UOv+ZuysywZIYuKfemAEWenECKRdkj/mM6nY=
Received: from SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35)
 by DSVPR12MB999174.namprd12.prod.outlook.com (2603:10b6:8:389::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 04:57:36 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::81) by SJ0PR03CA0210.outlook.office365.com
 (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:57:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:57:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:57:35 -0500
Received: from [10.136.43.195] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 23:57:32 -0500
Message-ID: <a66a5dc7-2bdf-48ab-860a-d35ef1aefb92@amd.com>
Date: Tue, 30 Jun 2026 10:27:31 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] KVM: x86: Refactor APIC register mask handling to
 support extended APIC registers
To: Naveen N Rao <naveen@kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<dapeng1.mi@linux.intel.com>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-2-manali.shukla@amd.com>
 <agXEIbwLFOPJH0y2@blrnaveerao1>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <agXEIbwLFOPJH0y2@blrnaveerao1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DSVPR12MB999174:EE_
X-MS-Office365-Filtering-Correlation-Id: adc6692b-88c2-497b-e107-08ded6641a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	P2jU9zyXILVjULb0n9c9D2wabarsuxZMhXA7AfHj5Xq9x5XN4HqWKT3BaFH8xPUKIRaovzU/rW+xkeczp3wAZ3XGD8c172A6sqwIvDtoCykvUPodk83cyNSHhcZDQMRxvuyWBMxsG+PI2dtwgAa3R6f7F4yK2KNv/NfDaGiplGkLrfKnUjxxHA8koAI/71nVBwidaQBbtUOobCr/Gt9G6ts77IbRTQQ1TBVRn/gIg6jXvCMtD+LfwE+WpTTznK/XDOPqIBTZkNIABHRbK0vJ2cRr/PQ0yocSI0NjJ8CsZkOE9uFX+aVrX6gdgMMLpEFWb8F78dov8V7N8UJ4tlIWMiHVRUIITUrG6SwhnjB+5s7xtKQf+kYzWR2S9b7rylr4zGySpOF0+XvzSCJ//b6wBcEDQ0fGip3a8P7SvlNHCxXe7wmH62bKPBiDNFPELIiryxvhNtrEp9p9XNUl3ATTRYrGeHXOSlzYBflaxqSn4MCceNh532jlf2D97/MLNx2u5hzLlirhueOip8ZOD41T5oGJWxEPdveXwt8eTGsAbxuLKFiZSiCv/eKGDAsup7gxMesthF9LaROC4E2k8vpzN8h4fNbpPRNPLAhnsu1BB320oeqJ91UnxVE409MoX6hzYOPh2J8z3UBXWKX5RWHg/7x4jBF/Oh/VXnd6yXvQh2lh+8f/GWzwOCsUPa70gzgxy1yeGa3gQCDOyeSlUIx0LQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	skbFU/enFEX1OhnWsuxmi25I/kiOkJDSAwn2HeOIG4SU4cTGto9f9aNYOisDgXy7KCFpv7Pn4owkF+Sgf5rRVHE3+O3hWqG4iTM08CUf6rfZN42C/qrU67lvZC41B84ZuyJGQWQTpehUzk40O/lRae5+DenxpyVXkF7iVgSvGYFiz3vki5oHPDHzYMUXtelmBV30M4qss72CxhUMwDvouYw0BSYZInVyKIaRuenAT/YACrdukRvnmhpJxgMyiNLZ1GtzfRSNKjkW+tHUm9+La9wu9EKTPKNXLGVvE9kU5o17LN66hUxGv+7c9/YcvPIL9zTJb24ftOJPwcOTA+IqVaxWXHGM5egfl0uf29n63Iy2TXVlhMtjmmrau9+BMPe60/EYBFY8gsmjJZRQCCeWCkAMtD+s91b4Jv1z+99S9WXgoWrf9OMqPzbIDScxN6de
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:57:36.1560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc6692b-88c2-497b-e107-08ded6641a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999174

Hi Naveen,

Thank you for reviewing my patches.

On 5/14/2026 6:18 PM, Naveen N Rao wrote:
> On Wed, Feb 04, 2026 at 07:44:44AM +0000, Manali Shukla wrote:
>> Expand the APIC register mask infrastructure from a single u64 to
>> a u64[2] array to accommodate both standard APIC registers (0x0-0x3f0)
>> and extended APIC registers (0x400-0x530).  Current AMD processors
>> support four extended LVT registers; future processors may support up to
>> 255.
>>
>> The existing single 64-bit mask can track at most 64 registers (with 16-
>> byte granularity), which is insufficient for the extended APIC register
>> space.  A 128-bit mask (u64[2]) provides coverage for both standard and
>> extended register ranges.
>>
>> Convert the bitmask infrastructure to use kernel bitmap APIs.
>> APIC_REG_MASK now sets bits in the u64[2] array via bitmap_set(),
>> APIC_REG_TEST checks register validity via test_bit(), and
>> kvm_lapic_readable_reg_mask() populates the expanded mask as an output
>> parameter instead of a return value.
>>
>> Update all callers, including vmx_update_msr_bitmap_x2apic() in VMX, to
>> pass and utilize the new two-element mask array. Currently, extended
>> APIC registers are only supported for AMD processors.
>>
>> No functional change intended; extended APIC register emulation will be
>> added in a subsequent patch.
>>
>> Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
>> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/kvm/lapic.c   | 96 ++++++++++++++++++++++++++----------------
>>  arch/x86/kvm/lapic.h   |  2 +-
>>  arch/x86/kvm/vmx/vmx.c | 10 +++--
>>  3 files changed, 67 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> index 2e513f1c8988..66819397e073 100644
>> --- a/arch/x86/kvm/lapic.c
>> +++ b/arch/x86/kvm/lapic.c
>> @@ -1664,53 +1664,74 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
>>  	return container_of(dev, struct kvm_lapic, dev);
>>  }
>>  
>> -#define APIC_REG_MASK(reg)	(1ull << ((reg) >> 4))
>> -#define APIC_REGS_MASK(first, count) \
>> -	(APIC_REG_MASK(first) * ((1ull << (count)) - 1))
>> -
>> -u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
>> -{
>> -	/* Leave bits '0' for reserved and write-only registers. */
>> -	u64 valid_reg_mask =
>> -		APIC_REG_MASK(APIC_ID) |
>> -		APIC_REG_MASK(APIC_LVR) |
>> -		APIC_REG_MASK(APIC_TASKPRI) |
>> -		APIC_REG_MASK(APIC_PROCPRI) |
>> -		APIC_REG_MASK(APIC_LDR) |
>> -		APIC_REG_MASK(APIC_SPIV) |
>> -		APIC_REGS_MASK(APIC_ISR, APIC_ISR_NR) |
>> -		APIC_REGS_MASK(APIC_TMR, APIC_ISR_NR) |
>> -		APIC_REGS_MASK(APIC_IRR, APIC_ISR_NR) |
>> -		APIC_REG_MASK(APIC_ESR) |
>> -		APIC_REG_MASK(APIC_ICR) |
>> -		APIC_REG_MASK(APIC_LVTT) |
>> -		APIC_REG_MASK(APIC_LVTTHMR) |
>> -		APIC_REG_MASK(APIC_LVTPC) |
>> -		APIC_REG_MASK(APIC_LVT0) |
>> -		APIC_REG_MASK(APIC_LVT1) |
>> -		APIC_REG_MASK(APIC_LVTERR) |
>> -		APIC_REG_MASK(APIC_TMICT) |
>> -		APIC_REG_MASK(APIC_TMCCT) |
>> -		APIC_REG_MASK(APIC_TDCR);
>> +/*
>> + * Helper macros for APIC register bitmask handling
>> + * 2 element array is being used to represent 128-bit mask, where:
>> + * - mask[0] tracks standard APIC registers
>> + * - mask[1] tracks extended APIC registers
>> + */
>> +
>> +#define APIC_REG_BITMAP_WORDS   2  /* 2 x 64-bit words = 128 bits */
>> +#define APIC_REG_BITMAP_BITS    (APIC_REG_BITMAP_WORDS * BITS_PER_LONG)
> 
> Since we are going for the full 4k page with [G|S]ET_LAPIC2, it's 
> probably simpler to have this cover the full range.
> 

Sure. Makes sense to add the full 4k page.

>> +
>> +#define APIC_REG_TO_BIT(reg)		(((reg) < 0x400) ? ((reg) >> 4) : \
>> +					 (64 + (((reg) - 0x400) >> 4)))
>> +
>> +#define APIC_REG_MASK(reg, mask) \
>> +	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(reg), 1)
>> +
>> +#define APIC_REGS_MASK(first, count, mask) \
>> +	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(first), (count))
>> +
>> +#define APIC_REG_TEST(reg, mask) \
>> +	test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
>> +
>> +#define APIC_LAST_REG_OFFSET		0x3f0
>> +
>> +void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2])
>> +{
>> +	bitmap_zero((unsigned long *)(mask), APIC_REG_BITMAP_BITS);
> 
> You can have this function take an unsigned long pointer, which will 
> allow much of this to be simplified.
> 
> Untested, but something like this?
> 
> 
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 6b6083aa50b6..552d416e5fc6 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -44,6 +44,9 @@ enum lapic_lvt_entry {
>  	KVM_APIC_MAX_NR_LVT_ENTRIES,
>  };
>  
> +#define APIC_REG_BITMAP_WORDS   	4
> +#define APIC_REG_BITMAP_BITS    	(APIC_REG_BITMAP_WORDS * BITS_PER_LONG)
> +
>  #define APIC_LVTx(x) ((x) == LVT_CMCI ? APIC_LVTCMCI : APIC_LVTT + 0x10 * (x))
>  
>  struct kvm_timer {
> @@ -157,7 +160,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
>  int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
>  void kvm_lapic_exit(void);
>  
> -void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2]);
> +void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, unsigned long *mask);
>  
>  static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
>  {
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 5a0e8195206d..8f4b63c9807b 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1731,27 +1731,17 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
>   * - mask[1] tracks extended APIC registers
>   */
>  
> -#define APIC_REG_BITMAP_WORDS   2  /* 2 x 64-bit words = 128 bits */
> -#define APIC_REG_BITMAP_BITS    (APIC_REG_BITMAP_WORDS * BITS_PER_LONG)
> -
> -#define APIC_REG_TO_BIT(reg)		(((reg) < 0x400) ? ((reg) >> 4) : \
> -					 (64 + (((reg) - 0x400) >> 4)))
> -
> -#define APIC_REG_MASK(reg, mask) \
> -	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(reg), 1)
> -
> -#define APIC_REGS_MASK(first, count, mask) \
> -	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(first), (count))
> -
> -#define APIC_REG_TEST(reg, mask) \
> -	test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
> +#define APIC_REG_TO_BIT(reg)		((reg) >> 4)
> +#define APIC_REG_MASK(reg, mask)	bitmap_set(mask, APIC_REG_TO_BIT(reg), 1)
> +#define APIC_REGS_MASK(first, count, mask)	bitmap_set(mask, APIC_REG_TO_BIT(first), (count))
> +#define APIC_REG_TEST(reg, mask)	test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
>  
>  #define APIC_LAST_REG_OFFSET		0x3f0
>  #define APIC_EXT_LAST_REG_OFFSET(n)	APIC_EILVTn((n))
>  
> -void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2])
> +void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, unsigned long *mask)
>  {
> -	bitmap_zero((unsigned long *)(mask), APIC_REG_BITMAP_BITS);
> +	bitmap_zero(mask, APIC_REG_BITMAP_BITS);
>  
>  	APIC_REG_MASK(APIC_ID, mask);
>  	APIC_REG_MASK(APIC_LVR, mask);
> @@ -1796,9 +1786,9 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
>  			      void *data)
>  {
>  	unsigned int last_reg = APIC_LAST_REG_OFFSET;
> +	DECLARE_BITMAP(mask, APIC_REG_BITMAP_BITS);
>  	unsigned char alignment = offset & 0xf;
>  	u32 result;
> -	u64 mask[2];
>  
>  	/*
>  	 * WARN if KVM reads ICR in x2APIC mode, as it's an 8-byte register in
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 063e56abac35..6915f1392dff 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4138,10 +4138,10 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
>  	 * mode, only the current timer count needs on-demand emulation by KVM.
>  	 */
>  	if (mode & MSR_BITMAP_MODE_X2APIC_APICV) {
> -		u64 mask[2];
> +		DECLARE_BITMAP(mask, APIC_REG_BITMAP_BITS);
>  
>  		kvm_lapic_readable_reg_mask(vcpu->arch.apic, mask);
> -		msr_bitmap[read_idx] = ~mask[0];
> +		msr_bitmap[read_idx] = ~bitmap_read(mask, 0, 64);
>  	} else {
>  		msr_bitmap[read_idx] = ~0ull;
>  	}
> 
> 
> - Naveen
> 

Ack.

-Manali
