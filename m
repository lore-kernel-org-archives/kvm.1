Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD5376A01
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274964; cv=none; b=T0S8PRIcUUJiDSKu5E1nUHkEqCL6TqOYngQFHZbyUqlUCqupkbWjA9ZUeBaI/mXNS7nHpdtjeA6uEJZy1G9IjWLAUyidjVYDvOpVxTuMbbA6p0IQgYcQfzEwZQ+C3zKuhBSF9v+scdjPWSyIyUUZEWGI7W2AaL0YfDybkQm5b8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274964; c=relaxed/simple;
	bh=+7+/q8LAlMzLlWk1znO+lD248Sp+weOvZS73ENKy0kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or5q3aBvO3aaCWSS9BPs8Pzn2sPLzX8Z7OmpbcP0mPkBaIcx7F2VKRbEs6Hx+A0zOJLi6Hfai64UtEQ2T9jq0mubJ4+eGzDIUud12vTHcj0ExHVKHVgYgcr0XChG/nrjYncBDpVeDRgVkw8kquq1X91SB/i8YNBYk02RvWdhJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=klKpCENe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="klKpCENe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0DEE175A;
	Wed, 20 May 2026 04:02:34 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CFCC3F85F;
	Wed, 20 May 2026 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779274960; bh=+7+/q8LAlMzLlWk1znO+lD248Sp+weOvZS73ENKy0kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klKpCENeYWVeS8V9assoUHjXrxQPA4+oCwfz857IRdqVxqQLfPyvVl4yqxb4K/YcR
	 fEAdP4ISyjfLCwKMIuGSjsfMn8k/s7nhn3wy486zgkUtepNstLit8PmKt82OUaqZZy
	 R8egHGygvWRT9MV+aNt4Zpb9/HXcanyY8pZkV9n4=
Date: Wed, 20 May 2026 12:02:31 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v2 2/2] KVM: arm64: nv: Don't save/restore FP register
 during a nested ERET or exception
Message-ID: <20260520110231.GA4005903@e124191.cambridge.arm.com>
References: <20260520085036.541666-1-maz@kernel.org>
 <20260520085036.541666-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520085036.541666-3-maz@kernel.org>

Hi Marc,

On Wed, May 20, 2026 at 09:50:36AM +0100, Marc Zyngier wrote:
> When switching between L1 and L2, we save the old state using
> kvm_arch_vcpu_put(), mutate the state in memory, then load the new
> state using kvm_arch_vcpu_load(). Any live FPSIMD/SVE state is saved
> and unbound, such that it can be lazily restored on a subsequent trap.
> 
> The FPSIMD/SVE state is shared by exception levels, and only a handful
> of related control registers need to be changed when transitioning
> between L1 and L2. The save/restore of the common state is needless
> overhead, especially as trapping becomes exponentially more expensive
> with nesting.
> 
> Avoid this overhead by leaving the common FPSIMD/SVE state live on the
> CPU, and only switching the state that is distinct for L1 and L2:

To make sure I understand this part:
	
	L1 sets up L2's FP state live on the CPU 
	L1 erets
	eret traps to L0/host
	preemption disabled
	kvm_arch_vcpu_put()
	    kvm_arch_vcpu_put_fp() <-- actually saves the state of the live registers
	.. set elr etc ..
	kvm_arch_vcpu_load()
	    kvm_arch_vcpu_load_fp() <-- doesn't actually restore state, but ensures
                                        the CPTR trap will be set
        .. returns to L2 (traps on first use of FP and state will be restored)
	
So this patch is (effectively) removing the put_fp()/load_fp(), because the FP
state is common/shared between L1 and L2, so whatever L1 put into that state
before the eret, L2 was going to see.

If my understanding is correct:
Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey

> 
> - the trap controls: the effective values are recomputed on each entry
>   into the guest to take the EL into account and merge the L0 and L1
>   configuration if in a nested context, or directly use the L0 configuration
>   in non-nested context (see __activate_traps()).
> 
> - the VL settings: the effective values are are also recomputed on each
>   entry into the guest (see fpsimd_lazy_switch_to_guest()).
> 
> Since we appear to cover all bases, use the vcpu flags indicating the
> handling of a nested ERET or exception delivery to avoid the whole FP
> save/restore shenanigans. SME will have to be similarly dealt with when
> it eventually gets supported.
> 
> For an EL1 L3 guest where L1 and L2 have this optimisation, this
> results in at least a 10% wall clock reduction when running an I/O
> heavy workload, generating a high rate of nested exceptions.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/fpsimd.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 15e17aca1dec0..aca98752a6e42 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -28,6 +28,20 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
>  	if (!system_supports_fpsimd())
>  		return;
>  
> +	/*
> +	 * Avoid needless save/restore of the guest's common
> +	 * FPSIMD/SVE/SME regs during transitions between L1/L2.
> +	 *
> +	 * These transitions only happens in a non-preemptible context
> +	 * where the host regs have already been saved and unbound. The
> +	 * live registers are either free or owned by the guest.
> +	 */
> +	if (vcpu_get_flag(vcpu, IN_NESTED_ERET) ||
> +	    vcpu_get_flag(vcpu, IN_NESTED_EXCEPTION)) {
> +		WARN_ON_ONCE(host_owns_fp_regs());
> +		return;
> +	}
> +
>  	/*
>  	 * Ensure that any host FPSIMD/SVE/SME state is saved and unbound such
>  	 * that the host kernel is responsible for restoring this state upon
> @@ -102,6 +116,15 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long flags;
>  
> +	/*
> +	 * See comment in kvm_arch_vcpu_load_fp().
> +	 */
> +	if (vcpu_get_flag(vcpu, IN_NESTED_ERET) ||
> +	    vcpu_get_flag(vcpu, IN_NESTED_EXCEPTION)) {
> +		WARN_ON_ONCE(host_owns_fp_regs());
> +		return;
> +	}
> +
>  	local_irq_save(flags);
>  
>  	if (guest_owns_fp_regs()) {
> -- 
> 2.47.3
> 
