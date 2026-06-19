Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0F2853F3
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881610; cv=none; b=LW+Yha1hSyESpr31rqkhYGd+3WrI35vSdfLq6m4e1PPy83vig30TgT2C0n5kH6H4id6e6j+Z83FaeLhFzd/BbLXpmrgc9l/mdNHrQiweLUDNreKU6jA+EdbuHbxbteknUnP2nV/3o2ld+nU3TIZEJua2u7rogqHthyHxhzQ/Tq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881610; c=relaxed/simple;
	bh=6pKJbGXD3BjzZ6jiJgE2wbpszsCFCKqrbr9eZJ+4bJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2BPEA+emLFYc9oXkItv2NP0PezyHywH1Wnsmq9UcH2qFzJNGtMytcETYmhJUQM86W7f5nCSFqhI/ERQOWwgQFapgbH2DpBjPG1mK3fPyIKtzZKr/mxnVhaTcSbuS+JdSICpRtKQ0pxlpWydiFcB47EaRP7f5OHBhIYrcUZk/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml5PIyXh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml5PIyXh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4601949975dso372728f8f.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881607; x=1782486407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5kDXUnyJJXjz/qiqqJglYFwJpL0mExjzODZMSDh1B8=;
        b=ml5PIyXhow2fCugjtwMLgU11fcd5bblay2/DgtT+1CODVIBs5aRxXlnE6nfh3J2qup
         rQKY+poOgZhKmNGa3W9cDzJWOPIZhE3AkSZ88L9y+6SVWjfBdpLd69HG6O2P70ZW6Nuh
         o6AascNR2h5VnSDkoNBNrP47+SEXgJxn9SstXN+7U0YOeX8A1J4CByEhKd5on/wr3Yuv
         nheJQqumv7GENKqVsy2MHofZ5E25dzKVOp5vH/H5UQsoHnP+NAOPQGZciCtq0UDMyBr7
         la/kLxMX1s6WLnTOSE7mQzblr97QVeNF5FJm/vM9aNZ+zlNefR5jjBtviHNmd0/M92lh
         sVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881607; x=1782486407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5kDXUnyJJXjz/qiqqJglYFwJpL0mExjzODZMSDh1B8=;
        b=iP9yrvKyXk3NMLzjPdjiNYpwJFRYwvOSZTxnvT8HRg3Ol4EJTnlFW6d8mWLC1H67CQ
         tidV3g36YwYrY816Hew0o/68kAIoEkndBB2PdYhCOl2yxi1ucqAmrlLo43OgJDAgpot6
         xA2Xray3aubB0e2eFemMmSzOxP16cD2Jhj6s0GtePJGm2oTwofedmQYiyJase6Jf50lX
         /W/jUuXZW8iFyANsfsfQHhY/lEA4lKXjgBG5JLitiP49mHGQ5Uhg7sDoyuPcqTdESxm2
         iuB52NFSAkKSvbsLgLBIY+miGSxNpuYQdbU+IULgyRSw9fnNmosngaIvUhHU91Lvccj9
         CP3w==
X-Forwarded-Encrypted: i=1; AFNElJ92pl9Vy4mneenycgJvcGG1udUgn0K92Z6Ncif0vsiTIr4zKtVJF+6knoiOXImgfiNPzZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88sw/sh1SNgLkk/BJ1kznv28reSBxl/YIWHPpg8UgFQF6sE1o
	uzPT0gY5X7YjXKp/1oCWWf5JZ6i+SjsHEVCkxobqJD42ZnJR45V8cvpX
X-Gm-Gg: AfdE7clkolNFFmLKdbhKmKDppote8ZaFD7clSirKkYM+JVL1hIYEHIJoVLAjBYW7VjV
	xm6sFQhQEvn7AzH9ZmlCMVcS2pOW/IsTVt1RbbcsxZz0CPoX4BZRblIT8goyLLVK7+k1DJ+Vu5c
	pvD6f3bUPzHxqxxxU8QY+Rj+4JSE7N0dJe5DD4hA2pgZ+yDH6XZ+SOqt9V0iQnEbjzYmWnhBIUT
	dhlCET1bZA54pljE64eo91dApR4iC9StZCpQ7zXCv33o/247YSnWguCgwk71/EjTiJXpFGdldVS
	lyIqouFYgNaTdxDEsYyPNR06FPl9WnmpErOtO+6mQy8hqEgGQgK6r4ts6zGl3hrYuxqH8r41lpv
	0FKUW0uaUiQYTJxT8eCS7yP3u6zLsz7ciONWpe2nE9cIVshPSOpiaqPeiS/qXvHGDVa8Ytl3OSy
	tUc5Ny7F26p4e7icWXo2r34lQuSh2vpxGBu4Rt0RCVWPECE0ezLQ==
X-Received: by 2002:a5d:5f96:0:b0:462:d07e:4bc4 with SMTP id ffacd0b85a97d-4656d643ccamr4620478f8f.7.1781881607111;
        Fri, 19 Jun 2026 08:06:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a0473bsm10004425f8f.1.2026.06.19.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:06:46 -0700 (PDT)
Date: Fri, 19 Jun 2026 16:06:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Replace BUG_ON() with WARN_ON_ONCE() on "bad"
 nested GPA translation
Message-ID: <20260619160645.57f4e325@pumpkin>
In-Reply-To: <20260618185746.2023283-1-seanjc@google.com>
References: <20260618185746.2023283-1-seanjc@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 11:57:45 -0700
Sean Christopherson <seanjc@google.com> wrote:

> If KVM attempts to translate what it thinks is an L2 GPA with a non-nested
> MMU, simply WARN and return the GPA, i.e. trust the MMU more than the
> caller, as there is zero reason to potentially panic the host kernel just
> because KVM misused an API.

Except that PANIC_ON_WARN stands a reasonable chance of being set.
So it makes little difference.

	David

> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 3 ++-
>  arch/x86/kvm/vmx/nested.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 9aedb88c832d..3e6c671a8dc2 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -2152,7 +2152,8 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct kvm_mmu *mmu = vcpu->arch.mmu;
>  
> -	BUG_ON(!mmu_is_nested(vcpu));
> +	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
> +		return gpa;
>  
>  	/* Non-GMET walks are always user-walks */
>  	if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 3a293640d58c..6957bb6f5cf7 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -7470,7 +7470,8 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
>  {
>  	struct kvm_mmu *mmu = vcpu->arch.mmu;
>  
> -	BUG_ON(!mmu_is_nested(vcpu));
> +	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
> +		return gpa;
>  
>  	/*
>  	 * MBEC differentiates based on the effective U/S bit of
> 
> base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced

