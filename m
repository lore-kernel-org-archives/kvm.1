Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7984426D0A
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770194; cv=none; b=nzPSM0OTD5o8y4UGvsjn3xA/SYwiw6NNcglu1YGMNP2xa690nph7ktPQRD3jcAw/DVeoTmJQGZoGW335JoDveHPPno5D3ndc5Z0cs9l7DBv+a9MtPTV8gmwoOsRkke/xF7VxO7b4U/IeyDtc0mXhDBh3yd6hlEhDItbtpCSiGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770194; c=relaxed/simple;
	bh=/3hUJWqSjrgt6H2/5pLiezpPh0BF+4h08jBSKJG3X9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Q29pfI38j6mcFEx9k2wGVqMC3JtGBbDuc/F3mxZj/IdAYaQ3E2JpsElLFr8lPiQ0dEBmCthp0ahk4+h0YxlnOvrcpvF7Nb+26CYaVkx2Eb2GFUigC2QubOyi7D4aYhhCmi2t6OZf24Fvab1ytN8ElTg4VDkZe42Z5Bo64UPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvvky2eA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvvky2eA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF279C2BCB3;
	Thu, 14 May 2026 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778770194;
	bh=/3hUJWqSjrgt6H2/5pLiezpPh0BF+4h08jBSKJG3X9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvvky2eAnsaxxqzONOe0nE4EhzXjaP/JNzUe6UkCg7yttWQJmffxohC7u7Oqxkw3Y
	 rI2r8DkMjbqgoCzOcgAOXHodOBQ0XWCVRx7NG3cNhCu+jjaiBke1VpRU8606xwnuk6
	 LUsgoDmswezPlDXw5XQbeXzi4JhDAxN3gvF46bTSpvjJHwdT8rmvFwNNXITmmqskGR
	 w1FefOAV2OvFnbB7rROjWTSXobQiwrQlq1m34NdivgoQ/+ZNa4ooG9bJCx5ItAZbNZ
	 ZXl9nhPkRF5r58vJuLvVKXAya9SP0LqtXE9tfb0nDEpJ8P4239DP0Wx6eGZMU6T1+u
	 49ommb083/fhw==
Date: Thu, 14 May 2026 20:18:28 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 7/9] KVM: x86: Emulate Extended LVT registers for AMD
 guests
Message-ID: <agXfdJ_gnujR3k8Z@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-8-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-8-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:50AM +0000, Manali Shukla wrote:
> From: Santosh Shukla <santosh.shukla@amd.com>
> 
> Emulate reads and writes to AMD Extended APIC registers: APIC_EFEAT
> (0x400), APIC_ECTRL (0x410), and APIC_EILVTn (0x500-0x530).  Without
> emulation, Instruction Based Sampling (IBS) driver fails to initialize
> when it tries to access APIC_EILVT(0).
> 
> Extend the LAPIC register read and write paths to allow accesses beyond
> the standard 0x3f0 offset when the guest has X86_FEATURE_EXTAPIC.  The
> valid range is determined by kvm->arch.nr_extlvt, which userspace
> configures via KVM_CAP_LAPIC2.
> 
> Initialize extended APIC registers in both kvm_vcpu_after_set_cpuid()
> and kvm_lapic_reset().  The initial kvm_lapic_reset() occurs before
> userspace configures CPUID via KVM_SET_CPUID2, so extended LVT registers
> can't be initialized until X86_FEATURE_EXTAPIC is set.  Handle the
> initial setup in kvm_vcpu_after_set_cpuid() and subsequent resets in
> kvm_lapic_reset().
> 
> Initialize APIC_EFEAT to report the number of extended LVTs (read-only).
> Initialize APIC_ECTRL to zero (read-write).  Initialize APIC_EILVTn
> entries to masked (bit 16 set), matching hardware reset behavior.
> 
> Please refer to Section 16.4.5 in AMD Programmer's Manual Volume 2 at
> https://bugzilla.kernel.org/attachment.cgi?id=306250 for more details
> on Extended LVT.
> 
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/include/asm/apicdef.h | 18 ++++++++++++++
>  arch/x86/kvm/cpuid.c           | 10 +++++++-
>  arch/x86/kvm/lapic.c           | 43 ++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/lapic.h           |  8 +++++++
>  4 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
> index be39a543fbe5..5c5e9db1e27d 100644
> --- a/arch/x86/include/asm/apicdef.h
> +++ b/arch/x86/include/asm/apicdef.h
> @@ -148,6 +148,24 @@
>  #define		APIC_EILVT_MSG_EXT	0x7
>  #define		APIC_EILVT_MASKED	(1 << 16)
>  
> +/*
> + * Initialize extended APIC registers to the default value when guest
> + * is started and EXTAPIC feature is enabled on the guest.
> + *
> + * APIC_EFEAT is a read only Extended APIC feature register, whose bits
> + * 0, 1, and 2 represent features that are not currently emulated by KVM.
> + * Therefore, these bits must be cleared during initialization. As a result, the
> + * default value used for APIC_EFEAT in KVM is set based on number of extended
> + * LVT registers supported by the guest.
> + *
> + * APIC_ECTRL is a read-write Extended APIC control register, whose
> + * default value is 0x0.
> + */
> +
> +#define		APIC_EFEAT_MASK		0x00FF0000
> +#define		APIC_EFEAT_DEFAULT(n)	((n << 16) & APIC_EFEAT_MASK)
> +#define		APIC_ECTRL_DEFAULT	0x0
> +

This probably belongs in the KVM headers.

>  #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
>  #define APIC_BASE_MSR		0x800
>  #define APIC_X2APIC_ID_MSR	0x802
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index baa1cf473d45..4574149d137b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -435,6 +435,14 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		kvm_apic_set_version(vcpu);
>  	}
>  
> +	/*
> +	 * Initialize extended APIC registers after CPUID is set.  The initial
> +	 * reset occurs before userspace configures CPUID, so extended LVT
> +	 * registers (which require X86_FEATURE_EXTAPIC) can't be initialized
> +	 * until after KVM_SET_CPUID2.
> +	 */
> +	kvm_apic_init_extlvt_regs(vcpu);
> +
>  	vcpu->arch.guest_supported_xcr0 = cpuid_get_supported_xcr0(vcpu);
>  	vcpu->arch.guest_supported_xss = cpuid_get_supported_xss(vcpu);
>  
> @@ -1076,7 +1084,7 @@ void kvm_set_cpu_caps(void)
>  		F(LAHF_LM),
>  		F(CMP_LEGACY),
>  		VENDOR_F(SVM),
> -		/* ExtApicSpace */
> +		F(EXTAPIC),

Shouldn't this be VENDOR_F()?

>  		F(CR8_LEGACY),
>  		F(ABM),
>  		F(SSE4A),
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4ed6abb414e4..a04c808289c3 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1687,6 +1687,7 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
>  	test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
>  
>  #define APIC_LAST_REG_OFFSET		0x3f0
> +#define APIC_EXT_LAST_REG_OFFSET(n)	APIC_EILVTn((n))
>  
>  void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2])
>  {
> @@ -1722,6 +1723,12 @@ void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2])
>  		APIC_REG_MASK(APIC_DFR, mask);
>  		APIC_REG_MASK(APIC_ICR2, mask);
>  	}
> +
> +	if (guest_cpu_cap_has(apic->vcpu, X86_FEATURE_EXTAPIC)) {
> +		APIC_REG_MASK(APIC_EFEAT, mask);
> +		APIC_REG_MASK(APIC_ECTRL, mask);
> +		APIC_REGS_MASK(APIC_EILVTn(0), apic->vcpu->kvm->arch.nr_extlvt, mask);
> +	}
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_readable_reg_mask);
>  
> @@ -1739,6 +1746,13 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
>  	 */
>  	WARN_ON_ONCE(apic_x2apic_mode(apic) && offset == APIC_ICR);
>  
> +	if (guest_cpu_cap_has(apic->vcpu, X86_FEATURE_EXTAPIC)) {
> +		u8 nr_extlvt = apic->vcpu->kvm->arch.nr_extlvt;
> +
> +		if (nr_extlvt > 0)
> +			last_reg = APIC_EXT_LAST_REG_OFFSET(nr_extlvt - 1);
> +	}
> +

We should be able to eliminate the need for this if we have 
kvm_lapic_readable_reg_mask() work with the full 4k APIC page:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 8f4b63c9807b..ed20e0b21be7 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1736,9 +1736,6 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
 #define APIC_REGS_MASK(first, count, mask)     bitmap_set(mask, APIC_REG_TO_BIT(first), (count))
 #define APIC_REG_TEST(reg, mask)       test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
 
-#define APIC_LAST_REG_OFFSET           0x3f0
-#define APIC_EXT_LAST_REG_OFFSET(n)    APIC_EILVTn((n))
-
 void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, unsigned long *mask)
 {
        bitmap_zero(mask, APIC_REG_BITMAP_BITS);
@@ -1785,7 +1782,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_readable_reg_mask);
 static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
                              void *data)
 {
-       unsigned int last_reg = APIC_LAST_REG_OFFSET;
        DECLARE_BITMAP(mask, APIC_REG_BITMAP_BITS);
        unsigned char alignment = offset & 0xf;
        u32 result;
@@ -1796,19 +1792,12 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
         */
        WARN_ON_ONCE(apic_x2apic_mode(apic) && offset == APIC_ICR);
 
-       if (guest_cpu_cap_has(apic->vcpu, X86_FEATURE_EXTAPIC)) {
-               u8 nr_extlvt = apic->vcpu->kvm->arch.nr_extlvt;
-
-               if (nr_extlvt > 0)
-                       last_reg = APIC_EXT_LAST_REG_OFFSET(nr_extlvt - 1);
-       }
-
        if (alignment + len > 4)
                return 1;
 
        kvm_lapic_readable_reg_mask(apic, mask);
 
-       if (offset > last_reg || !APIC_REG_TEST(offset, mask))
+       if (APIC_REG_TO_BIT(offset) >= APIC_REG_BITMAP_BITS || !APIC_REG_TEST(offset, mask))
                return 1;
 
	result = __apic_read(apic, offset & ~0xf);


- Naveen

