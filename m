Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1A3CEBB5
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339229; cv=none; b=Dxn/e6BR9V4my8fSZRZ8N8cqEPjiLXPkLBGAeGRIIbeSfXboh/FpaHIf8zojlvt7b4l/v1Q+DOIhHYaf6ol0P+x1i9qhjN/NHibadrbJ0y3LEHeS/D2csTEOWZvBDm1vMvkMgIjHqwYeWS1kMLNglpHCJXiu1SM24Y/ZAGldsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339229; c=relaxed/simple;
	bh=Ekhb+qCQy2ym84BjGnRnJ9+llgn8+iN3NBF0eKdAvnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tOGMSaW6TGyPAk7ZtkOYKCWoN7Ii9+ZaTVe2DdmnwBhH1dCUg75sA7+I3UNoqvACTMAW4eflHJnQCkgHgK1w8cJJXXfBcwGRH2jB9I/yFg1oS3ZhA35SmKzWtYqOBZDVh4wfKEHnvTp09WRxkPm7jRGNQkDuk9Lj6rXilLLmd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFJnzWur; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFJnzWur"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae3badc00dso14987325ad.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773339226; x=1773944026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zIIF1a0OywISACpCkGA6XhGEw2fktBd7kbIM2f4eTQ=;
        b=kFJnzWurhURG97FuIolNSu7cDADItUDHqjcJfdrQs6kcN8jmqwDPiILlyZ3bD1g7R2
         TYfKBkfW3J0eu4O6FizCbewr/EqY+5PfBIevwoluyl2qM0Rzo13SfmmmIITuikdr0HYA
         FYvNllBbCaxZNDSprcXS2jHCb/Q2gQmH0MbrGa6aO+ClqAHEbSwi1LbagA4BgEKjNHCC
         AUmkufZ7LEdb6ic+dzXP2Ye2R6pS8kCegLdHGpV4ZbHTKNvn/z4/jcKqcrjpDRNuFIuO
         Kh7Km3QSOvJ+3VP1hCt42Y8o9QRXjyxgtqknKpFGh1QjzJhD7gwyOENvFXJPlIURcuBg
         vPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339226; x=1773944026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zIIF1a0OywISACpCkGA6XhGEw2fktBd7kbIM2f4eTQ=;
        b=upNtrRAxlGqg3OUNhIFL7mKtJfUJAJsQEq2zmZhHx4fVr9vlp04ly6+PaQFPkUV5UC
         6WFFJr4kVKv6TNTAODwgsEHjMvi4TQVFGxXam73kF0qlpqrXyt0NL99ca/Fh4hhSvotJ
         wyi/mmishpxiX7Q+SFZTPzuTVmMG52LhLsuz9TuXGGniXCQ3d6iy3OgxS0yGEz7LO2+U
         GaXZwkGgYx0z1ZeRC8GaKVm2BpOEpz5Su2Wk902x8orKj13I5ah4zW+ab89RhLaho17h
         MbWAj2BZbrDA3Yvwr3YuJJSFEjMcfpRsBcWsCAVeLqRh2kxMqi/b7Xm5M8wNXA9gOXnt
         Uxaw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Nc2fEa5Y7hGqLRtphB8PE394ilsnCtHPzz15gJa/OXrteBOOMA8IIcTOthOxHW9lCNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHq6dNPF4GXQCYbQOUCTY0tm4K/qcb96ErlHSXymE3CUOYztzD
	plrOglo2Y1206RTgBzBgObfuMDu/+gcr2IRSX3b16wEnNpU3Jj5fx4ix8Vs2kbkFBB5QkPRYCe+
	w7yYY0Q==
X-Received: from plbke13.prod.google.com ([2002:a17:903:340d:b0:2ae:48ed:5526])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce11:b0:2ae:c34d:8c4e
 with SMTP id d9443c01a7336-2aecaa9e9c0mr3694775ad.38.1773339226471; Thu, 12
 Mar 2026 11:13:46 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:13:44 -0700
In-Reply-To: <20260306210900.1933788-3-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306210900.1933788-1-yosry@kernel.org> <20260306210900.1933788-3-yosry@kernel.org>
Message-ID: <abMCWGOoIvob2bTv@google.com>
Subject: Re: [PATCH v2 2/6] KVM: nSVM: Simplify error handling of nested_svm_copy_vmcb12_to_cache()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> nested_svm_vmrun() currently stores the return value of
> nested_svm_copy_vmcb12_to_cache() in a local variable 'err', separate
> from the generally used 'ret' variable. This is done to have a single
> call to kvm_skip_emulated_instruction(), such that we can store the
> return value of kvm_skip_emulated_instruction() in 'ret', and then
> re-check the return value of nested_svm_copy_vmcb12_to_cache() in 'err'.
> 
> The code is unnecessarily confusing. Instead, call
> kvm_skip_emulated_instruction() in the failure path of
> nested_svm_copy_vmcb12_to_cache() if the return value is not -EFAULT,
> and drop 'err'.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>

FYI, I'm going to grab this right now to make it slightly easier to resolve the
merge conflict with Paolo's SMM fixes (the ret vs. err stuff is so confusing).

> ---
>  arch/x86/kvm/svm/nested.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index b191c6cab57db..6d4c053778b21 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1079,7 +1079,7 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
>  int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> -	int ret, err;
> +	int ret;
>  	u64 vmcb12_gpa;
>  	struct vmcb *vmcb01 = svm->vmcb01.ptr;
>  
> @@ -1104,19 +1104,20 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>  		return -EINVAL;
>  
>  	vmcb12_gpa = svm->vmcb->save.rax;
> -	err = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
> -	if (err == -EFAULT) {
> +	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
> +
> +	/*
> +	 * Advance RIP if #GP or #UD are not injected, but otherwise
> +	 * stop if copying and checking vmcb12 failed.
> +	 */
> +	if (ret == -EFAULT) {
>  		kvm_inject_gp(vcpu, 0);
>  		return 1;
> +	} else if (ret) {
> +		return kvm_skip_emulated_instruction(vcpu);
>  	}

I strongly dislike the if-elif approach, because it makes unnecessarily hard to
see that *all* ret !=0 cases are handled, i.e. that overwriting ret below is ok.

The comment is also super confusing, because there's no #UD in sight, but there
is a #GP. 

This is what I have locally and am planning on pushing to kvm-x86/next.

	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
	if (ret) {
		if (ret == -EFAULT) {
			kvm_inject_gp(vcpu, 0);
			return 1;
		}

		/* Advance RIP past VMRUN as part of the nested #VMEXIT. */
		return kvm_skip_emulated_instruction(vcpu);
	}

	/* At this point, VMRUN is guaranteed to not fault; advance RIP. */
	ret = kvm_skip_emulated_instruction(vcpu);

>  
> -	/*
> -	 * Advance RIP if #GP or #UD are not injected, but otherwise stop if
> -	 * copying and checking vmcb12 failed.
> -	 */
>  	ret = kvm_skip_emulated_instruction(vcpu);
> -	if (err)
> -		return ret;
>  
>  	/*
>  	 * Since vmcb01 is not in use, we can use it to store some of the L1
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
