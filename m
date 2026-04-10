Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EFD3DF005;
	Fri, 10 Apr 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840025; cv=none; b=UmZTyfjQXPBJnstL5wlre/0lp8+hywMQJyiKoJEG8Op0/rJKUXFOp4F+oDPxoP2OG4aIa5sMSwgaArq8FY8CYyDpjunKtcbuGJfRuFdaAv3d/OqbbGBJmb9S0MNW/zfyy2G9I7SohAB5JS706evuYwMEZJwKeRX+ZD9YSbxuvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840025; c=relaxed/simple;
	bh=Rr2TI3xHLheEIwXhvAIw+gge4nU9TgGcERxkQIHxh0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNOb1rwbG2iO2vqFpD7/ZzRF69MTt2ryoiekSdqONAmnQfNoFDE3RsjcDEgNE07d3tsABLJydsEn7mD3u2JNEi6IKN034fQ4zToNpIzEiOzto6AhPBlGI/8xI1zbtK0w8diVCPiND4w66WtLoJLW4NjDti7ZQ7rdAXKgXBH9hTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZuhRbT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZuhRbT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C582C19421;
	Fri, 10 Apr 2026 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775840023;
	bh=Rr2TI3xHLheEIwXhvAIw+gge4nU9TgGcERxkQIHxh0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZuhRbT+8VW6djDVcZ4QekXloFVtXoGM0vBGtu6UxjPwkjkji8z0t5PGIBu60ej3j
	 wbrOB5kRd0bMkuagSgJ2IAlIzw/mjdG3a8jTDvIndiCO3EJDDrFst/ab5zCgedZHo2
	 Eoon7qYX9b4loFtiGV/lSvhhjg+y0Oh5g/jjz8DsckfoKRcLmP9WVYk1nAhH+b0WYf
	 WaO/79qvk2zB9/jJpt/mIWbEPIXQACfslY90oHhAxJhok5cAkVWllLcvZP46LKBXQe
	 GBgW4Nnbwpr6NA/PtRDo1XB3X8PkgzmFEd4vurlNJsm1hIKHXTAK08owlGdq7znWcm
	 Vqz2UeP28vdyA==
Date: Fri, 10 Apr 2026 22:15:39 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs
 KVM actually supports
Message-ID: <adkl4wFdk4JrM3T-@blrnaveerao1>
References: <20260409222449.2013847-1-seanjc@google.com>
 <20260409222449.2013847-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409222449.2013847-2-seanjc@google.com>

On Thu, Apr 09, 2026 at 03:24:47PM -0700, Sean Christopherson wrote:
> Fix multiple (classes of) bugs with one stone by using KVM's mask of
> readable local APIC registers to determine which x2APIC MSRs to pass
> through (or not) when toggling x2AVIC on/off.  The existing hand-coded
> list of MSRs is wrong on multiple fronts:
> 
>  - ARBPRI, DFR, and ICR2 aren't supported by x2APIC; disabling
>    interception is nonsensical and suboptimal (the access generates a
>    #VMEXIT that requires decoding the instruction).
> 
>  - RRR is completely unsupported.
> 
>  - AVIC currently fails to pass through the "range of vectors" registers,
>    IRR, ISR, and TMR, as e.g. X2APIC_MSR(APIC_IRR) only affects IRR0, and
>    thus only disables intercept for vectors 31:0 (which are the *least*
>    interesting registers).

:facepalm:

We seriously need better selftests for these. Also on my list has been 
to cook up something for your other fix where AVIC gets inhibited for 
non-zero vCPU IDs (with x2AVIC disabled):
http://lore.kernel.org/r/20260112232805.1512361-1-seanjc@google.com

I started looking at Alejandro's series adding AVIC-related binary 
stats, but had to switch to other things. Last I looked, I felt that 
your suggestion to add an "exits" array accounting individual #VMEXITs 
would in particular be helpful:
https://lore.kernel.org/kvm/ZmMjHwavCLk0lRd7@google.com/

Though I'm not sure how standardizing this across VMX and SVM looks 
like, and/or if it will be truly helpful -- we may be interested in 
specific exits, such as AVIC-related exits for some of the tests...
Thoughts?

> 
> Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> Cc: stable@vger.kernel.org
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index adf211860949..df974ee290d0 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -122,6 +122,9 @@ static u32 x2avic_max_physical_id;
>  static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
>  					     bool intercept)
>  {
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
> +	u64 x2apic_readable_mask;
> +
>  	static const u32 x2avic_passthrough_msrs[] = {
>  		X2APIC_MSR(APIC_ID),
>  		X2APIC_MSR(APIC_LVR),
> @@ -162,9 +165,15 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
>  	if (!x2avic_enabled)
>  		return;
>  
> +	x2apic_readable_mask = kvm_lapic_readable_reg_mask(vcpu->arch.apic);
> +
> +	for (i = 0; i < BITS_PER_TYPE(typeof(x2apic_readable_mask)); i++)
> +		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
> +					  MSR_TYPE_R, intercept);
> +

Yet to test this series (will get to it next week in more detail), but I 
suppose you meant to use `for_each_set_bit()` or such?


- Naveen

