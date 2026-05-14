Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2113959D
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763052; cv=none; b=nTagjvQYeStU4r9TrjSCvvyTwPtZVXlcvxomQlP+ZmtYSCsy+5LB8SLD381NSj++CJuNbpQb8GOk3JDssdr6RY3idFEA1z7xiiPLLjJPmtOmn0mcp3+XbJiXZsDFV99E9H3JAd9iAu0NJ1c/redae3A91732ijyI1ay81aY9ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763052; c=relaxed/simple;
	bh=HBuGITxbFt+8+omoeCmi5JNhtvLaSzQSHfJ5qdqmP/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3EEM4r1x2xigFo7qqnHEL2azJqVA+AGc0orAVH7N6lHVqwf/EtcO9BQb9/Ja8FAqB1yaCUH+7O6e3jPdlcaNgWJ5jZHPCZWKqb3W5BWA6qXfUBXhaM7jUH1i3/stXHfHB2Ii5VWIJq1TWqKm4uiF5Bdgl2U3Uvcml/wWCwG0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5nqTVJj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5nqTVJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E387C2BCB3;
	Thu, 14 May 2026 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778763052;
	bh=HBuGITxbFt+8+omoeCmi5JNhtvLaSzQSHfJ5qdqmP/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5nqTVJjxJCjtp/sPiQV+A9RbhmguIBJszwCMPjIU66ql5J6gSnA3/rso3GyksssP
	 2gh0EKQJfMwfSnbrDsq54tky3c46BGDSUuKPXWz2LHKQR6NTFGaHLtIdlLZoI6tUQA
	 RdRBI44Iw9OWypNSxtxYTQ+XhivK6uu6bMKhMktvdVAn3u2HOkjHKgGmMsukvwW9Y1
	 F8ht8+GSfUR62iEVxwL/Gq/n1RMwHd2HKlgnykI1bbGR5j1GZz+Mq3I1qHUtyISYyi
	 2SkLmw6wZTooz+SqvWyCW+bQo1aM/sox8BLedIzKwj6CEQsDYX/ATiyTSFAoJqs51a
	 FB/CbRVUfNlJQ==
Date: Thu, 14 May 2026 18:18:10 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 1/9] KVM: x86: Refactor APIC register mask handling to
 support extended APIC registers
Message-ID: <agXEIbwLFOPJH0y2@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-2-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:44AM +0000, Manali Shukla wrote:
> Expand the APIC register mask infrastructure from a single u64 to
> a u64[2] array to accommodate both standard APIC registers (0x0-0x3f0)
> and extended APIC registers (0x400-0x530).  Current AMD processors
> support four extended LVT registers; future processors may support up to
> 255.
> 
> The existing single 64-bit mask can track at most 64 registers (with 16-
> byte granularity), which is insufficient for the extended APIC register
> space.  A 128-bit mask (u64[2]) provides coverage for both standard and
> extended register ranges.
> 
> Convert the bitmask infrastructure to use kernel bitmap APIs.
> APIC_REG_MASK now sets bits in the u64[2] array via bitmap_set(),
> APIC_REG_TEST checks register validity via test_bit(), and
> kvm_lapic_readable_reg_mask() populates the expanded mask as an output
> parameter instead of a return value.
> 
> Update all callers, including vmx_update_msr_bitmap_x2apic() in VMX, to
> pass and utilize the new two-element mask array. Currently, extended
> APIC registers are only supported for AMD processors.
> 
> No functional change intended; extended APIC register emulation will be
> added in a subsequent patch.
> 
> Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/kvm/lapic.c   | 96 ++++++++++++++++++++++++++----------------
>  arch/x86/kvm/lapic.h   |  2 +-
>  arch/x86/kvm/vmx/vmx.c | 10 +++--
>  3 files changed, 67 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 2e513f1c8988..66819397e073 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1664,53 +1664,74 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
>  	return container_of(dev, struct kvm_lapic, dev);
>  }
>  
> -#define APIC_REG_MASK(reg)	(1ull << ((reg) >> 4))
> -#define APIC_REGS_MASK(first, count) \
> -	(APIC_REG_MASK(first) * ((1ull << (count)) - 1))
> -
> -u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
> -{
> -	/* Leave bits '0' for reserved and write-only registers. */
> -	u64 valid_reg_mask =
> -		APIC_REG_MASK(APIC_ID) |
> -		APIC_REG_MASK(APIC_LVR) |
> -		APIC_REG_MASK(APIC_TASKPRI) |
> -		APIC_REG_MASK(APIC_PROCPRI) |
> -		APIC_REG_MASK(APIC_LDR) |
> -		APIC_REG_MASK(APIC_SPIV) |
> -		APIC_REGS_MASK(APIC_ISR, APIC_ISR_NR) |
> -		APIC_REGS_MASK(APIC_TMR, APIC_ISR_NR) |
> -		APIC_REGS_MASK(APIC_IRR, APIC_ISR_NR) |
> -		APIC_REG_MASK(APIC_ESR) |
> -		APIC_REG_MASK(APIC_ICR) |
> -		APIC_REG_MASK(APIC_LVTT) |
> -		APIC_REG_MASK(APIC_LVTTHMR) |
> -		APIC_REG_MASK(APIC_LVTPC) |
> -		APIC_REG_MASK(APIC_LVT0) |
> -		APIC_REG_MASK(APIC_LVT1) |
> -		APIC_REG_MASK(APIC_LVTERR) |
> -		APIC_REG_MASK(APIC_TMICT) |
> -		APIC_REG_MASK(APIC_TMCCT) |
> -		APIC_REG_MASK(APIC_TDCR);
> +/*
> + * Helper macros for APIC register bitmask handling
> + * 2 element array is being used to represent 128-bit mask, where:
> + * - mask[0] tracks standard APIC registers
> + * - mask[1] tracks extended APIC registers
> + */
> +
> +#define APIC_REG_BITMAP_WORDS   2  /* 2 x 64-bit words = 128 bits */
> +#define APIC_REG_BITMAP_BITS    (APIC_REG_BITMAP_WORDS * BITS_PER_LONG)

Since we are going for the full 4k page with [G|S]ET_LAPIC2, it's 
probably simpler to have this cover the full range.

> +
> +#define APIC_REG_TO_BIT(reg)		(((reg) < 0x400) ? ((reg) >> 4) : \
> +					 (64 + (((reg) - 0x400) >> 4)))
> +
> +#define APIC_REG_MASK(reg, mask) \
> +	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(reg), 1)
> +
> +#define APIC_REGS_MASK(first, count, mask) \
> +	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(first), (count))
> +
> +#define APIC_REG_TEST(reg, mask) \
> +	test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
> +
> +#define APIC_LAST_REG_OFFSET		0x3f0
> +
> +void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2])
> +{
> +	bitmap_zero((unsigned long *)(mask), APIC_REG_BITMAP_BITS);

You can have this function take an unsigned long pointer, which will 
allow much of this to be simplified.

Untested, but something like this?


diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 6b6083aa50b6..552d416e5fc6 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -44,6 +44,9 @@ enum lapic_lvt_entry {
 	KVM_APIC_MAX_NR_LVT_ENTRIES,
 };
 
+#define APIC_REG_BITMAP_WORDS   	4
+#define APIC_REG_BITMAP_BITS    	(APIC_REG_BITMAP_WORDS * BITS_PER_LONG)
+
 #define APIC_LVTx(x) ((x) == LVT_CMCI ? APIC_LVTCMCI : APIC_LVTT + 0x10 * (x))
 
 struct kvm_timer {
@@ -157,7 +160,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_exit(void);
 
-void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2]);
+void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, unsigned long *mask);
 
 static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
 {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5a0e8195206d..8f4b63c9807b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1731,27 +1731,17 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
  * - mask[1] tracks extended APIC registers
  */
 
-#define APIC_REG_BITMAP_WORDS   2  /* 2 x 64-bit words = 128 bits */
-#define APIC_REG_BITMAP_BITS    (APIC_REG_BITMAP_WORDS * BITS_PER_LONG)
-
-#define APIC_REG_TO_BIT(reg)		(((reg) < 0x400) ? ((reg) >> 4) : \
-					 (64 + (((reg) - 0x400) >> 4)))
-
-#define APIC_REG_MASK(reg, mask) \
-	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(reg), 1)
-
-#define APIC_REGS_MASK(first, count, mask) \
-	bitmap_set((unsigned long *)(mask), APIC_REG_TO_BIT(first), (count))
-
-#define APIC_REG_TEST(reg, mask) \
-	test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
+#define APIC_REG_TO_BIT(reg)		((reg) >> 4)
+#define APIC_REG_MASK(reg, mask)	bitmap_set(mask, APIC_REG_TO_BIT(reg), 1)
+#define APIC_REGS_MASK(first, count, mask)	bitmap_set(mask, APIC_REG_TO_BIT(first), (count))
+#define APIC_REG_TEST(reg, mask)	test_bit(APIC_REG_TO_BIT(reg), (unsigned long *)(mask))
 
 #define APIC_LAST_REG_OFFSET		0x3f0
 #define APIC_EXT_LAST_REG_OFFSET(n)	APIC_EILVTn((n))
 
-void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, u64 mask[2])
+void kvm_lapic_readable_reg_mask(struct kvm_lapic *apic, unsigned long *mask)
 {
-	bitmap_zero((unsigned long *)(mask), APIC_REG_BITMAP_BITS);
+	bitmap_zero(mask, APIC_REG_BITMAP_BITS);
 
 	APIC_REG_MASK(APIC_ID, mask);
 	APIC_REG_MASK(APIC_LVR, mask);
@@ -1796,9 +1786,9 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
 			      void *data)
 {
 	unsigned int last_reg = APIC_LAST_REG_OFFSET;
+	DECLARE_BITMAP(mask, APIC_REG_BITMAP_BITS);
 	unsigned char alignment = offset & 0xf;
 	u32 result;
-	u64 mask[2];
 
 	/*
 	 * WARN if KVM reads ICR in x2APIC mode, as it's an 8-byte register in
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 063e56abac35..6915f1392dff 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4138,10 +4138,10 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 	 * mode, only the current timer count needs on-demand emulation by KVM.
 	 */
 	if (mode & MSR_BITMAP_MODE_X2APIC_APICV) {
-		u64 mask[2];
+		DECLARE_BITMAP(mask, APIC_REG_BITMAP_BITS);
 
 		kvm_lapic_readable_reg_mask(vcpu->arch.apic, mask);
-		msr_bitmap[read_idx] = ~mask[0];
+		msr_bitmap[read_idx] = ~bitmap_read(mask, 0, 64);
 	} else {
 		msr_bitmap[read_idx] = ~0ull;
 	}


- Naveen

