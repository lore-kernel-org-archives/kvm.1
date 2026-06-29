Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990530EF64
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774520; cv=none; b=gTkALa9hTy8He6sPQvH4aDdziLH0nLdjlwwHdFWujrYJ+hTaP2bHbTs9syYjXs7dzvO+3BZ3vbmhSygBlUIiNDE8Q9ucxBrHYh9nKXwAn3rpDPbDFPlJ1u+KgOcRFZzm4h9/YbcFh3lnm8naQ1DacazuxNP+ntlC+WX3ro0DhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774520; c=relaxed/simple;
	bh=ePQTHDNpY2R2KegFIPxKmUpLYWCa/EqcQy9dkCVmXfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6d8QgrtNfVkrS2NLXV3bygQZfXVBO9Ju/3yW442zv57O9ikCRKl1RNS8RzVW3hdvyDFKZvcdHd05gmuxDNmj1saaqEeLJmWapoKYY2wJjv03ygfYQf1BswRR5GadS2I5+/ReDNJgpGHfJL8b2pI8mMu1ZcLCUxe9Qg3G8P4pgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5ZxtJvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5ZxtJvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1A61F000E9;
	Mon, 29 Jun 2026 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774519;
	bh=8fJblFV5Wq0SFjBpDUlIbFmAsUeIJkQwMnUkbhc2leY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5ZxtJvVZv9bobIoMBhqD2g2ul9aOGUbzlaEWjKILtTTUjuzJG/gTT49hayrIHgxO
	 YMtCgM5SbMno0ZIXIraLJSoai4DkaFrbVjXj9PpFvSZVDl4ULcUlZnSUuU3ocn9ISW
	 RAvphK6MumTIFQuh26ATq47m42SHzIsNu3CoUKtp8uw8kYNQFouqQ1AVDLXJ7cJbtU
	 vqVmNlS0RmFcpi/CsL4Fxk2+OsQPG4CEBj3RE4rM4RNF3cxZ87TtZwp8FS3BIUy2VO
	 37nhDgbQTPT3h1PtLzeseCGQvPArs90f4yB5A/44FGfl8j/Vf9OKMl+6pEDfwoNKpz
	 hc2moBrRUKUiw==
Date: Mon, 29 Jun 2026 23:08:37 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, kvm@vger.kernel.org, x86@kernel.org, yosry.ahmed@linux.dev, 
	jmattson@google.com, thomas.lendacky@amd.com, nikunj.dadhania@amd.com, 
	ravi.bangoria@amd.com, santosh.shukla@amd.com
Subject: Re: [RESEND PATCH v2] KVM: SVM: Add Bus Lock Detect support
Message-ID: <akL5VmXwhdvVrVfD@google.com>
References: <20260629081018.60618-1-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629081018.60618-1-shivansh.dhiman@amd.com>

On Mon, Jun 29, 2026 at 08:10:18AM +0000, Shivansh Dhiman wrote:
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
> MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
> Virtualization is enabled. Add this dependency in the SVM.
> 
> While adding Bus Lock Detect support, also fix DR6 handling in nested
> virtualization. Using DR6_FIXED_1 to prevent reset of BLD bit (bit 11)
> between VMRUNs. However, it preserves DR6_RTM, which is a reserved bit
> on AMD processors. So, DR6_RTM bit must always be set to 1.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
> Changelog:
> v2 --> v2 Resend
>  * No functional changes.
>  * Rebased on top of tag: kvm-x86-next-2026.06.24.
> 
> v1 --> v2
>  * Rebased and used guest_cpu_cap_has() instead of guest_cpuid_has().
> 
>  v2: https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/
>  v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com
> ---
>  arch/x86/kvm/svm/nested.c |  3 ++-
>  arch/x86/kvm/svm/svm.c    | 17 ++++++++++++++++-
>  arch/x86/kvm/svm/svm.h    |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index c1485c3e691c..4fdc58d38afe 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -808,7 +808,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
>  
>  	if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_DR))) {
>  		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
> -		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
> +		/* DR6_RTM is a reserved bit on AMD and as such must be set to 1 */
> +		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_FIXED_1 | DR6_RTM;
>  		vmcb_mark_dirty(vmcb02, VMCB_DR);
>  	}
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f..b4b0fa730916 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -884,6 +884,9 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>  			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
>  
> +	/* Bus Lock Detect depends on LBR Virtualization */
> +	enable_lbrv |= (svm->vmcb->save.dbgctl & DEBUGCTLMSR_BUS_LOCK_DETECT);
> +

A few lines above we have:

        bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
                            (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
                            (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));

We probably want to combine "svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR"
with the new added check, and use nested_vmcb12_has_lbrv(). Maybe
end up with something like this (you'll probably want to refactor in a
separate patch):

	bool enable_lbrv = false;

	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
		enable_lbrv = true;

	if (is_guest_mode(vcpu) && nested_vmcb12_has_lbrv(vcpu))
		enable_lbrv = true;


---

Completely unrelated to this patch, but we should probably just clear
SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() if the
guest vCPU doesn't have X86_FEATURE_LBRV instead of checking
X86_FEATURE_LBRV every time, similar to SVM_MISC_ENABLE_NP
and SVM_MISC_ENABLE_GMET.

>  	if (enable_lbrv && !current_enable_lbrv)
>  		__svm_enable_lbrv(vcpu);
>  	else if (!enable_lbrv && current_enable_lbrv)
> @@ -3160,6 +3163,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  			data &= ~DEBUGCTLMSR_BTF;
>  		}
>  
> +		if ((data & DEBUGCTLMSR_BUS_LOCK_DETECT) &&
> +		    !guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> +			return 1;
> +
>  		if (data & DEBUGCTL_RESERVED_BITS)
>  			return 1;
>  
> @@ -5591,9 +5598,17 @@ static __init void svm_set_cpu_caps(void)
>  	 * Clear capabilities that are automatically configured by common code,
>  	 * but that require explicit SVM support (that isn't yet implemented).
>  	 */
> -	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>  	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
>  
> +	/*
> +	 * LBR Virtualization must be enabled to support BusLockTrap inside the
> +	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
> +	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
> +	 * enabled.
> +	 */
> +	if (!lbrv)
> +		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
> +
>  	kvm_setup_xss_caps();
>  	kvm_finalize_cpu_caps();
>  }
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 716be21fba33..c65dc3acb5d1 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -783,7 +783,7 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>  
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +#define DEBUGCTL_RESERVED_BITS (~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
>  
>  /* svm.c */
>  extern bool dump_invalid_vmcb;
> 
> base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
> -- 
> 2.43.0
> 
> 
