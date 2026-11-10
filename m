Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333383;
	b=e7OIUUzQkh65ctNtRJiYZ7EYY6HihNwZ+eiRGQ2gN3MDSdVLdibuQoEQGnOGM2twsANj
	 INv0+WSO0jd2e1TbH91/u4q4dPp5ctOBrszAmRUZTPdbz66QWe3kPm2l7uGR/KYx/g25p
	 1MYbZoC9y+j6ZwOEofYSaFARO/ht8lsYb09czT/+hCsVSZ3pyojeRQqJu6wb7c9mQKT6t
	 lnt0EuDonn7yrkWa7OljEU7x4Jv3yNGIAAqBzSBg72ZFSMSw7OFNq3yNIp7lDRtGuuYe6
	 krwFIrswefZlxh/f162wsleHTAp4fZzWN3HmI3/bgPf9yDYVjqK7ReAXgsyxaKc1R9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333383;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8h442lZ4wNJ1w4XsRGE4609ntkN6o+zH0apnUFRmJBU=;
	b=vmfmYiChDxUv9zqqyuIrc0FaiocmX9B3ZfHEYxDpE2FYptmS1V4wgNOtC571BO3FKoS0
	 t5SnE0bhSgR03TOfvOP7AzWqF4IHvcOEvu4UL1UwFFO4Sy1+lKJYS0cABogXCa/yVmb2d
	 +geLGmbQPgsfwYpSP17CA97Pu/pcSc+K7hRQBYxaTwYiCZVH9UZfxuoc0SmsHC1lEJATw
	 OwOWJ1fejjZ+Lwc2AsxhkgE10c5aTg37ZWG35G/BbaIGTKpWTJyDDB4vKXGwYPNgQ3rGu
	 liqDyqCYPJhT6BzDzMnIDG6b2SuPYrHuW58z5BmR2Gc7ksHrA5RN/J7NIr0HfaN0Fhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8bRuklk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1781606A21E;
	Tue, 10 Nov 2026 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8bRuklk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B45B1F008BC;
	Tue, 10 Nov 2026 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333382;
	bh=8h442lZ4wNJ1w4XsRGE4609ntkN6o+zH0apnUFRmJBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R8bRuklkb9RAyuJ2CAj13kJOBVYMMbTETIRTMFgHvnTltu0Y8W/lwpIfDbYNIA2NY
	 MSzhvbh8WavSS2Irslvhf1AKwbuBQaha/BKG3Wsr6c/Gy3wuZOD7kslc4hVmfNdG/s
	 1XfyhNXrqTIN0jDnMxlk8372e5Z/SZpDrdO2XxSWt2o68xMzqS4rHpCWtBo+C+TTs6
	 10M54nrrRBz5ZEa5iDuRiP0Q1lbU6D/7W3lXgkaVHfG3J2Mw+BQmuWK/Mkc+AgHPrR
	 i/0ZN1ye/X2Q8sbC84f+ijlKxcBAffAMGi4h6X8j4YsMeW9JvM8/v4+kyUhPO5g813
	 G2z/aSPnbQkmw==
Date: Tue, 10 Nov 2026 17:56:20 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, John Allen <john.allen@amd.com>, Chao Gao <chao.gao@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nSVM: Add missing CET VMRUN consistency checks
Message-ID: <avNYjOevOv5s2o5k@google.com>
References: <20261110004037.125692-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110004037.125692-1-jmattson@google.com>

On Mon, Nov 09, 2026 at 04:40:37PM -0800, Jim Mattson wrote:
> Per the APM, "Canonicalization and Consistency Checks,"
> 
>   [t]he following conditions are considered illegal state combinations:
> 
>    - CR4.CET=1 when CR0.WP=0
>    - Any reserved bit set in S_CET
>    - CR4.CET=1 and U_CET.SS=1 when EFLAGS.VM=1
> 
> Check these conditions in software before trying to VMRUN vmcb02, so that
> the illegal states result in a #VMEXIT to L1 rather than an exit to
> userspace with KVM_EXIT_FAIL_ENTRY.
> 
> Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/from vmcb12/vmcb02")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef678433d..20ede403b62d 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -469,6 +469,21 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
>  	if (CC(!__kvm_is_valid_cr4(vcpu, save->cr4)))
>  		return false;
>  
> +	if (CC((save->cr4 & X86_CR4_CET) && !(save->cr0 & X86_CR0_WP)))
> +		return false;

Why aren't we checking X86_FEATURE_SHSTK here as well? Do we know if
older CPUs that didn't support CET had the consistency check?

> +
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> +	    CC(!kvm_is_valid_u_s_cet(vcpu, save->s_cet)))
> +		return false;
> +
> +	if ((save->cr4 & X86_CR4_CET) && (save->rflags & X86_EFLAGS_VM)) {
> +		u64 u_cet = 0;
> +
> +		if (!__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_cet) &&

If X86_FEATURE_SHSTK is not enumerated by the vCPU, then whether or not
the consistency check is done depends on ignore_msr. If ignore_msr=0,
the MSR read will fail and we won't do the consistency check, but if
ignore_msr=1 the MSR read will silently return 0, so the consistency
check will be done but will always succeed.

Instead of this implicit dependency, should we check for
X86_FEATURE_SHSTK explicitly?

Also, if X86_FEATURE_SHSTK is enumberated by the vCPU, and the MSR read
fails, the consistency check will silently be skipped. But I don't think
this can/should happen. Maybe we should WARN in this case.

One last question, in the restore path, the MSR may have not been
restored yet, right? Can the consistency check mistakenly fail in this
case?

> +		    CC(u_cet & CET_SHSTK_EN))
> +			return false;
> +	}
> +
>  	if (CC(!kvm_valid_efer(vcpu, save->efer)))
>  		return false;
>  
> -- 
> 2.56.0.506.g506a7eabc5-goog
> 
