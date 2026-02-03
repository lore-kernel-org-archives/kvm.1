Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257133B8D78
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132798; cv=none; b=AW1/X6dD21+nH4XDvRh5Kw3iEYLmxkF2T3UJj35eGeb4Cy5nkt4i/fgaJ8+QlbVmjVaHhtR2ST3NHlQnL/NDh/L1fZH16A/XRgJpqv4Qi69yr8ao0BD/3T7LLRsv2xFZwUF69CdzXSuwqrDKzXGwHowrbaokjdFGQ83z/1nrACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132798; c=relaxed/simple;
	bh=1kU69wHPyjLKVU4YZ+SoBV59+DzMkPq6ExF+frYFuFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGXzyS3opWmczaTkbu7sJkynyRx4mcSj3CG2JnPTjOJhQss+R2DraGEwmueGcR3cj9iyTIZhPRE838S03+r9C8qO4H0XL6PdHt8WacbijEQDHqHX/Do2OsL0sWy6Sb9HxuDfspV+hkyONHxUAP15kqbwOJdSOBMkoa9OuO+8wtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UxkMKtVH; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UxkMKtVH"
Date: Tue, 3 Feb 2026 15:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770132785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JrFQbxGr0f1+y9GygjFv+b2rwrXeutjSJRNGD2Gwr6Y=;
	b=UxkMKtVHPTvXSb8Bd1253ZtJTGIjf2zio73JFyd39lXBZM5jZZ3TlX8TWlt5MFudJVEo3r
	YTZ+NUqEE9oKAFJWKPSh8rLWJr4HHQy62okK0fHyz4g6AtgiOEz5xvkkEyiHx4MyENgRGE
	1xHijeIC5bdbno9ZDgvxSy0BVlgPkM0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on
 nested #VMEXIT
Message-ID: <cw6rwvvu57bt7i4pi3exmw6tdmbevegvlitqlmaycughua5sgn@4qdxkte6yxcz>
References: <20260203011320.1314791-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203011320.1314791-1-yosry.ahmed@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 03, 2026 at 01:13:20AM +0000, Yosry Ahmed wrote:
> KVM currently uses the value of CR2 from vmcb02 to update vmcb12 on
> nested #VMEXIT. Use the value from vcpu->arch.cr2 instead.
> 
> The value in vcpu->arch.cr2 is sync'd to vmcb02 shortly before a VMRUN
> of L2, and sync'd back to vcpu->arch.cr2 shortly after. The value are
> only out-of-sync in two cases: after migration, and after a #PF is
> injected into L2.
> 
> After migration, the value of CR2 in vmcb02 is uninitialized (i.e.
> zero), as KVM_SET_SREGS restores CR2 value to vcpu->arch.cr2. Using
> vcpu->arch.cr2 to update vmcb12 is the right thing to do.
> 
> The #PF injection case is more nuanced. It occurs if KVM injects a #PF
> into L2, then exits to L1 before it actually runs L2. Although the APM
> is a bit unclear about when CR2 is written during a #PF, the SDM is more
> clear:
> 
> 	Processors update CR2 whenever a page fault is detected. If a
> 	second page fault occurs while an earlier page fault is being
> 	delivered, the faulting linear address of the second fault will
> 	overwrite the contents of CR2 (replacing the previous address).
> 	These updates to CR2 occur even if the page fault results in a
> 	double fault or occurs during the delivery of a double fault.
> 
> KVM injecting the exception surely counts as the #PF being "detected".
> More importantly, when an exception is injected into L2 at the time of a
> synthesized #VMEXIT, KVM updates exit_int_info in vmcb12 accordingly,
> such that an L1 hypervisor can re-inject the exception. If CR2 is not
> written at that point, the L1 hypervisor have no way of correctly
> re-injecting the #PF. Hence, using vcpu->arch.cr2 is also the right
> thing to write in vmcb12 in this case.
> 
> Note that KVM does _not_ update vcpu->arch.cr2 when a #PF is pending for
> L2, only when it is injected. The distinction is important, because only
> injected exceptions are propagated to L1 through exit_int_info. It would
> be incorrect to update CR2 in vmcb12 for a pending #PF, as L1 would
> perceive an updated CR2 value with no #PF. Update the comment in
> kvm_deliver_exception_payload() to clarify this.

I forgot the best part:

If a synthesized #VMEXIT to L1 writes the wrong CR2 (e.g. right after
migration), and L2 is handling a #PF, it could read a corrupted CR2.
This could manifest as segmentation faults in L2, or potentially data
corruption.

Cc: stable@vger.kernel.org

> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 2 +-
>  arch/x86/kvm/x86.c        | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index de90b104a0dd5..9031746ce2db1 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1156,7 +1156,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  	vmcb12->save.efer   = svm->vcpu.arch.efer;
>  	vmcb12->save.cr0    = kvm_read_cr0(vcpu);
>  	vmcb12->save.cr3    = kvm_read_cr3(vcpu);
> -	vmcb12->save.cr2    = vmcb02->save.cr2;
> +	vmcb12->save.cr2    = vcpu->arch.cr2;
>  	vmcb12->save.cr4    = svm->vcpu.arch.cr4;
>  	vmcb12->save.rflags = kvm_get_rflags(vcpu);
>  	vmcb12->save.rip    = kvm_rip_read(vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index db3f393192d94..1015522d0fbd7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -864,6 +864,13 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
>  		vcpu->arch.exception.error_code = error_code;
>  		vcpu->arch.exception.has_payload = has_payload;
>  		vcpu->arch.exception.payload = payload;
> +		/*
> +		 * Only injected exceptions are propagated to L1 in
> +		 * vmcb12/vmcs12 on nested #VMEXIT. Hence, do not deliver the
> +		 * exception payload for L2 until the exception is injected.
> +		 * Otherwise, L1 would perceive the updated payload without a
> +		 * corresponding exception.
> +		 */
>  		if (!is_guest_mode(vcpu))
>  			kvm_deliver_exception_payload(vcpu,
>  						      &vcpu->arch.exception);
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
