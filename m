Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F25348458
	for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448404; cv=none; b=pcpSGRM2Mwf2S9HRxLFruekkJBOv/wSis4cndD2pOd9c4f5rhQLOrVVLUYz6YzFoD+S5QU/WnHGzk9AvCIHNCUD6l35LXMZ69490s84jcWaBNsVJ0G3xrLwI1xkOJv07Ogbk+LUVLANFWDtDObU+YyGBRFiBy3Y+csgcLGx7cC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448404; c=relaxed/simple;
	bh=3rieSb1MLS2AWN6xXHqEUMG3nsi9HN9Z3YzWuQsRPaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E3puWyLcjFEHqFRV6NznNt7BnbLtcGg8JgHgJiCdBsq7rVE4qmVglRbALYEcHebpxe5x70lkhXPOyIt9KQzAyKN8nc7cQZ97/hyCFU6dVLacdhZpuQ9MpVd/wQ74TPHcnFUckXHNP7rysobMtFkVhQYhTyymbW6GxoDqzsT7Mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxQ0nV9s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxQ0nV9s"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c72d23dfso1066730a91.2
        for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 13:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771448402; x=1772053202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsG+1lVvry8sAt+yZ2U5iF+8eZh9cfdyLiVCQKXrJX8=;
        b=UxQ0nV9sQUekjYdXu1GKmQl8lAzqhLU6GI4M3bCuyurKgsEk0EBTgQLs/7HHvuHS2B
         zGap1OewiPSRfr5WB0Bu+0dwJmHLPVUclP9wQz4lE6QgDtL/4e4R5nWJscerlQdYhfrI
         m4TsRH3MjlZM2CWVQII7MgCvnbQ6O3stkkkXnsvA7nPKnbcGZvijsIloD76W3psbFuhk
         0CSBEhuNghnaDVcNz/HoyJhXO5LhGbAaJ18M0s54IHxwmBJATeklAj+THoHxY9yiKths
         HwM7AaxGgeEwMfLxPEyljKKUDWJYiUhdDG0LxKYHppEUzNbSnztXDd2JsR9jSxlqRiFC
         5+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771448402; x=1772053202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsG+1lVvry8sAt+yZ2U5iF+8eZh9cfdyLiVCQKXrJX8=;
        b=oBI09j+couahBQYHEbCMx9Xnck+oD56ehnI+OcUniQHKBUadKhV2SY+fo5u7CprKdm
         VXvPTTGVBrrsg7mY8T2dWHwTrEwLnSnZ+e3fNlP6ApLfD/Fm9mvOd7kKtM0Eg35B0sWI
         7xTd7ZISHQquhtYLwVJ2k9wxG6lPNRmD+bdhefd8PHeSovCM3nQ+zrro/2Orn0o5YBvb
         kCOofnjwxQUxIEjkwTypOsFzHDr2pjVYgBtT0u+Cy6PjoJfx0f+jmra0Y6ppZKoxo7/9
         HDJPsLMOMhAjc1WUoIf/iq8hMoZ+nvlB/oNYuxyDgazM7gFjo5+Xi1YInu9zjUUmVJfD
         9elQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhjuGi7PGdf6ruwmCWkuJhlQfUVAKd98YGmlCKtK03oo2kIOYtXDQahiZojEnyKdYamz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl29iDUVaAiplXmg8tsZDLC5eTtKqiqiYf3xVumHCU6WGwnZqT
	sQfFV6tKbKKRPHwRzrVkSm4NxpnxtKhkcMW58T++pLvg/f8aUJWKuPwyAsRH09rLFNo82usyzXs
	I1l2Dwg==
X-Received: from pjm13.prod.google.com ([2002:a17:90b:2fcd:b0:354:bde2:b529])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4f:b0:34c:fe57:2793
 with SMTP id 98e67ed59e1d1-35889183210mr3062017a91.20.1771448402130; Wed, 18
 Feb 2026 13:00:02 -0800 (PST)
Date: Wed, 18 Feb 2026 13:00:00 -0800
In-Reply-To: <20260218082133.400602-10-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218082133.400602-1-jgross@suse.com> <20260218082133.400602-10-jgross@suse.com>
Message-ID: <aZYoUE7CmrLg3SVe@google.com>
Subject: Re: [PATCH v3 09/16] x86/msr: Use the alternatives mechanism for WRMSR
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	llvm@lists.linux.dev, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 18, 2026, Juergen Gross wrote:
> When available use one of the non-serializing WRMSR variants (WRMSRNS
> with or without an immediate operand specifying the MSR register) in
> __wrmsrq().

Silently using a non-serializing version (or not) seems dangerous (not for KVM,
but for the kernel at-large), unless the rule is going to be that MSR writes need
to be treated as non-serializing by default.  Which I'm fine with, but if we go
that route, then I'd prefer not to special case non-serializing callers.

E.g. in the KVM code, I find the use of wrmsrns() intuitive, because KVM doesn't
need the WRMSR to be serializing and so can eke out a bit of extra performance by
using wrmsrns() instead of wrmsrq().  But with native_wrmsrq(), it's not clear
why _this_ particular WRMSR in KVM needs to use the "native" version.

There are a pile of other WRMSRs in KVM that are in hot paths, especially with
the mediated PMU support.  If we're going to make the default version non-serializing,
then I'd prefer to get that via wrmsrq(), i.e. reap the benefits for all of KVM,
not just one arbitrary path.

> For the safe/unsafe variants make __wrmsrq() to be a common base
> function instead of duplicating the ALTERNATIVE*() macros. This
> requires to let native_wrmsr() use native_wrmsrq() instead of
> __wrmsrq(). While changing this, convert native_wrmsr() into an inline
> function.
> 
> Replace the only call of wsrmsrns() with the now equivalent call to
> native_wrmsrq() and remove wsrmsrns().

...

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3799cbbb4577..e29a2ac24669 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1473,7 +1473,7 @@ static void vmx_write_guest_host_msr(struct vcpu_vmx *vmx, u32 msr, u64 data,
>  {
>  	preempt_disable();
>  	if (vmx->vt.guest_state_loaded)
> -		wrmsrns(msr, data);
> +		native_wrmsrq(msr, data);
>  	preempt_enable();
>  	*cache = data;
>  }
> -- 
> 2.53.0
> 
