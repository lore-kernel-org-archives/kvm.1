Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F8394EB7
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941938; cv=none; b=HNLtJrspwHV5raVvz9VR6OXDS2d5CBFhU0BkkND1S8h2sWsimDylZbJKXZ+/ahwZ9rfOwjlRrmEOl6wz5Jv3lr0EJyxuY3CGl3RwvSoMKcMlruQ20M4rLiVia/CboedAFXn1JSqNrQCro8W1dU5PEUyPESscW2MHj6N+33L3A8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941938; c=relaxed/simple;
	bh=s3SRCVocvxtBq/BBjpyMKtPRDxFAsPXDOITHXqUnO4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jupPeUjviMjOgjJ1aGwLBJUHekiFDIugqMGbwGtP1lClDJMZLXOCkBPYccoO6Lm/O5oaUE/UADHVBZ28EcX797nsOSG0nhS3AzsHyJxCZ9I+o7yq2rOjOlrgoZh2jETXZgPSV9V1M6+KmzHIi7tcukMFDlvG2IuEg/RSuc0QEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYZHQ0FZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYZHQ0FZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9a700dc0eso9797565ad.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782941937; x=1783546737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRkq9jmjNuS5m4BJgbbAEXZCpunnA1N0v1XvrStDBgY=;
        b=jYZHQ0FZXAGO1JEGSty/T2GCc1OXGTQApUcOJesNOIlH8l85iNchenlCCV/1DZdGoT
         ksIP9vNV78wNEvoOdkfuVCk6HMJpet5vE+JYsUm2vMRnZSVKK+VjR8H5InwAYOPHBbc1
         aaJNkmEDURJ64lc302othmdm5JZAy42dA9ZCFHGr9qu9CrPaRnRwtS3P9Atu6psHqXVV
         JrnvTWDS98Y8L0Ll9o+oukfL5b0Id9i/dljxhUWkxi5cia+UxSpSDi9ntkDAhZMITm4O
         WOAVy5C64JRZJT5tOn8mcx2DNNJSYvpif1Q3nkBbkuEKGWAOgnzxXw/pAWQrh3tafiBr
         L2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782941937; x=1783546737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRkq9jmjNuS5m4BJgbbAEXZCpunnA1N0v1XvrStDBgY=;
        b=oNTuKCRsG8Sm+Tb9vbLbuz1YRspPW6Szid5Rz4wG4XEwYwbMMc9NS3pAeyMV5HhRdw
         yVlEk9s/hPpQFzMi6GeEA8ZbnsIqr5m/mYkP0mVE58/ZMLYo+pq8lmy5AjyqsLs1c/JB
         M5Dlhqkujli7j+O/6om/hA/VTUjjX9f0imzNsTdSHh5D3JJyUPA0Vv9rrQCH5BuUH+qz
         oX78CQegPVqUtQLDKk8tsja7/BCNe6ovKPdQ1CLKkkqQJiJJvlp/1z0B6uGrw4O9d13d
         dCZKSvKkaPVKoA9NbN1wJ+IhJ8RNdSXjSvomCQnK1WHfsxW4N0Z7HmhFQ/jgJSkhY4Cf
         yVzw==
X-Forwarded-Encrypted: i=1; AHgh+Rptb7+loBe+kxEmFQBGD8uD6BBWvTQ/hV2Hosu5PImFp/EspMX795R9ypO3mXNWHFwOA8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWeppYmAb9s+jv8e6Eh3fLijDI+Erq36Q7GoTyHgb1jTbXBzY
	uDXFPlk+uVcrbpmnhetqYjxfa4xHYJGPh927JGFMwK0clpRbfjGYlXe7H5CiEFDPNHBUBYZy7hS
	o72TsrQ==
X-Received: from plbka15.prod.google.com ([2002:a17:903:334f:b0:2bd:9574:2958])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c2:b0:2c9:fa36:ab73
 with SMTP id d9443c01a7336-2ca7e6f0b6emr36500665ad.8.1782941936636; Wed, 01
 Jul 2026 14:38:56 -0700 (PDT)
Date: Wed, 1 Jul 2026 14:38:55 -0700
In-Reply-To: <20260608145455.89187-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260608145455.89187-1-dwmw2@infradead.org> <20260608145455.89187-7-dwmw2@infradead.org>
Message-ID: <akWI72WrPKy-PBqo@google.com>
Subject: Re: [PATCH v5 06/34] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 08, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> KVM does make an attempt to cope with non-constant TSC, and has
> notifiers to handle host TSC frequency changes. However, it *only*
> adjusts the KVM clock, and doesn't adjust TSC frequency scaling when
> the host changes.
> 
> This is presumably because non-constant TSCs were fixed in hardware
> long before TSC scaling was implemented, so there should never be real
> CPUs which have TSC scaling but *not* CONSTANT_TSC.
> 
> Such a combination could potentially happen in some odd L1 nesting
> environment, but it isn't worth trying to support it. Just make the
> dependency explicit.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> ---
>  arch/x86/kvm/svm/svm.c | 3 ++-
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e7fdd7a9c280..7817752533fe 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5546,7 +5546,8 @@ static __init int svm_hardware_setup(void)
>  				     XFEATURE_MASK_BNDCSR);
>  
>  	if (tsc_scaling) {
> -		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
> +		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
> +		    !boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
>  			tsc_scaling = false;
>  		} else {
>  			pr_info("TSC scaling supported\n");
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a29896a9ef14..ed207cc7692d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -8672,7 +8672,7 @@ __init int vmx_hardware_setup(void)
>  	if (!enable_apicv || !cpu_has_vmx_ipiv())
>  		enable_ipiv = false;
>  
> -	if (cpu_has_vmx_tsc_scaling())
> +	if (cpu_has_vmx_tsc_scaling() && boot_cpu_has(X86_FEATURE_CONSTANT_TSC))

We should clear SECONDARY_EXEC_TSC_SCALING in setup_vmcs_config().  Failure to
clear the vmcs_config bit will advertise the feature to L2 and allow it to be
enabled in vmcs12, but KVM will ultimately not honor the scaling in vmcs02:

	if (kvm_caps.has_tsc_control)
		vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio);

This series kinda sorta gets there with "KVM: x86: Remove pvclock_gtod_data and
private timekeeping code", but that change looks misplaced?  And I think clearing
the bit this late will lead to false failures in vmx_check_processor_compat() due
to the golden config clearing the bit, but the local config having it set.


>  		kvm_caps.has_tsc_control = true;
>  
>  	kvm_caps.max_tsc_scaling_ratio = KVM_VMX_TSC_MULTIPLIER_MAX;
> -- 
> 2.54.0
> 
