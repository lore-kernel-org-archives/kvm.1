Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2418A6A8
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991362; cv=pass; b=W0rHrcjNB3GNweXXIvycvYAGp2+zasDxJ7yn4D7xtuDfJBo2Sc7nY6Eoqu+07uePlBwkWtJAnNs+VssoSSTsLiYd3WI35dihhG5n+kTM97wAllg9H8ta0/+XxamzX3O8HqnsjLJKwLGwnWyIt9WrqQL2EqQjxjoX+pp96wzwz7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991362; c=relaxed/simple;
	bh=2myBQ+FARJz3eN053ZTCz/sAD/d34ihStVvhthplU1s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzIqJxTA7TSoJ9VQPAvjiwg9UFDuDiHxT8/Bk7Au9f5sXZVJ/NxHsukugWdamFZQMHKEbQwZheFTYVjPaxDYeJvslB7uDrlXczaElwBMnt/Va6wG6ANGh5r+RTiblOUPRLSLhe0pX1mrZ/mMdQg/1kLeGnlI3pKyTIXD4uWpvEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3Xetrum; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3Xetrum"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1411813a91.1
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 07:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784991361; cv=none;
        d=google.com; s=arc-20260327;
        b=lWidfMaPIzlLuD+XHjmV6AC6SO9bwHbuAHZc6QAQflOCIYTk7nipGXVDRhxisc+Abj
         stwLDVBmMpweqwOxYlHIqScBvmeEN+M9FVD1pLkbFsuCD0mrP7tF6/UqhFoVO9970tAI
         slUV2u04lZ4xzWxCbga83PuRbtXLSfb34bg3NzOPd9UnnDSBRsB2Gb8Q8ZcB/ePFPggo
         T2d6Blg+k3HZKLN39KYbFZ+Yfe2acNNJrUeWoSoxiIKAX5xEs60qcoB/5dkajstoZIUQ
         Y2EUDWNenTt21bQ6Jnu2zlGuzmKeeyVDp5d25t+t6odfcldIiP+xhI20qegun2HmI2VL
         2Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Fx4c2Ff68ig/ktOTHYtIys92U2/JSUAhC7d454VqlfI=;
        fh=rwrYbFwf24hPID3nkl5yfZOxQTZWd//7Gp7H1M5VNFc=;
        b=U+jRlSVc48RsQH3CD2H0WL8yle0S1F+n38wkmK3iSwMWs4zjJWa/JKBVjVNn0CAqCQ
         g8xFNeqr03bNjsEaMNRDVnVXeNd8Q+Um+iwbEvcbW/1WjjZnbpbEv1MTRvvG/uxnhdp6
         J3Y1zcpuQW2Q9ofr7/k/Eg8lysUgQUnMZv8X6c4v/4As+W0JbYYdJQBAxS1O1C4C2QqM
         R+pjfVIWfHsFmCpKmLIlm2y8Kgz9Vvs5U3+7nrzi2IlEilwHDMzfxG34SdtC3cRa4IZe
         hI9DuCLk3s+vGeewSd9/bbF0CU6cWpTCH934Ohg+8PA0Zv8MdK3HEb17JW1/rSQMoSuO
         /FxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784991361; x=1785596161; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fx4c2Ff68ig/ktOTHYtIys92U2/JSUAhC7d454VqlfI=;
        b=s3XetrumdpZ/AaRU71wY9CQ8r7L1wRgweyRuQPlfjYkaNCRpcrXLSH6Q8HZsw1dB0V
         GkPWlP0t87L+lkMh1v/IBYZJUQSLgpPz6h1vc9C9SYDnXGPNfk/Ic4rpG7STtGaW8cGT
         vghaU86OybIpIqUyIQX7Dga0TvQIibhSWmJDTM8SSohYmiYfu7/EFv9aQOOa8g+jBeWS
         cve7QLEap08b0c5I7Oul8tUFuI0+rU2jqDzZiq88XAsf5GMaQ6gVUkZCwg0Qu92V1ZhC
         ATGxUfDvR7isp1trMxIrjnqAcbSfzTojRI3Kct3l6oETeWdQesUz41Ql3GFg2o8ASKj6
         s2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991361; x=1785596161;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fx4c2Ff68ig/ktOTHYtIys92U2/JSUAhC7d454VqlfI=;
        b=fM3oS9WB76MmZ213QmY4yYk71sVFqB4W2BSy2AFp33bJEyAgBOjezIQyyVyT/LhHQA
         M6MUQkMWl1tKCa6jajtk6WoZZSmX3wQ+f13xquWEZIJERYNmDnusOkh39DztwxfsSK1s
         H3iYJew8CX19HnLvg95XNzoZ231xk5O4/etmhBZoK0sVJtL77T+89OxN/uB4OeJw6cCl
         M8zY+RPyGb5XSAbtqmaX+wJ4y0QjxZkRFn1oMEyIDSReV9QKtti3+z7MUIFEUM+sNYve
         Nt6I0jTu+Q8wuyURQ65mb5aaP8kSX8G4J1nIOvm+J/2nqH0Y6gq3sIclupl+nV+7ftXD
         BKmA==
X-Gm-Message-State: AOJu0YzL6/ItVdx8EYmqbwVKgZMnjPLGb4Xf/BakdGaibBssW3fDFhP8
	nNZMgYRFCl4Ry9jdOvhU6sSoXhbUGRuasqgUSLbK2sSGCn17Vs0axSF4zTq0uqKEClbO0x0LxT8
	Gi6J/slrvBcF9guTKlS0on1KoVNPOvlpcLf1d8yBv9JiUjfgvrn8K6slnvw0=
X-Gm-Gg: AR+sD10hO7sbbRDswe7EApNDryvzxbvH2c2CpwobVFl/sQnMufTGqO9dx8bDagSHNpq
	g9BYMfhwSwaWpp5ETq/p619Jlh3SecwKyd9KRXxlxXnUdWXD80VlkGAgYDh+AahK9a792UoCcvC
	kVa5VGSRvemcbwYaDHa6kZDb8JmNQn8i0VzsNkM8iQ3nOMYJi6Wx5N+c9khVsNfLsFpml95HvCe
	YrhwqbTjwuzkCNjoahJ40Z7VYDM40iHu+0Z2ErXrjpbB5uNvMbx0xOa5/ZBgCxUdnZtvLvtutLH
	eJkiy4w2ILGEJPVlgYdKV2FoxKf1xDZGZQwcCmM=
X-Received: by 2002:a17:90b:17c4:b0:38d:dc13:6f94 with SMTP id
 98e67ed59e1d1-38f2977c1b9mr2799418a91.37.1784991360102; Sat, 25 Jul 2026
 07:56:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 07:55:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 07:55:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260723210811.72720-4-seanjc@google.com>
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 Jul 2026 07:55:59 -0700
X-Gm-Features: AUfX_mzd0S9EbAub7fa8gCwf_hvBAm4kexADw1zVICVbSm7JGpo7XDVouZK0eV8
Message-ID: <CAEvNRgGQ+JQ7UQ4HfNCwE3o2YJCFexkqVhzVLDoFwyEnTCrrFQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to gmem_make_shared()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Rename kvm_x86_ops's gmem_invalidate() hook to gmem_make_shared(), as the
> hook doesn't invalidate anything, and so that KVM doesn't need to add yet
> another vendor callback to support "convert to shared" once in-place
> conversion comes along.
>
> Opportunistically wrap the ops declarations with a GMEM_RECLAIM guard so
> that attempting to wire up a .gmem_make_shared() hook without selecting
> CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM will result in a build failure.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
>  arch/x86/include/asm/kvm_host.h    | 4 +++-
>  arch/x86/kvm/svm/sev.c             | 2 +-
>  arch/x86/kvm/svm/svm.c             | 2 +-
>  arch/x86/kvm/svm/svm.h             | 2 +-
>  arch/x86/kvm/x86.c                 | 2 +-
>  6 files changed, 10 insertions(+), 6 deletions(-)
>

This works well for the conversions series (will post soon, bit of
testing to go).

> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 736129db272a..210cb95d0a0b 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -149,7 +149,9 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  #endif
> -KVM_X86_OP_OPTIONAL(gmem_invalidate)

I updated the next line (for conversions series) to

#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) ||
defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)

> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> +KVM_X86_OP_OPTIONAL(gmem_make_shared)
> +#endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
>  #endif
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8c96999f49a0..4dc8a03c829a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1727,7 +1727,9 @@ struct kvm_x86_ops {
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  #endif
> -	void (*gmem_invalidate)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);

And this next line too

> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> +	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
> +#endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index e6987351dc04..4aa8330d5b2d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5161,7 +5161,7 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
>  	return 0;
>  }
>
> -void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
> +void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>  {
>  	kvm_pfn_t end = pfn + nr_pages;
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 91286d46d13a..b8c9967dd0de 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5439,7 +5439,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
>
>  	.gmem_prepare = sev_gmem_prepare,
> -	.gmem_invalidate = sev_gmem_invalidate,
> +	.gmem_make_shared = sev_gmem_make_shared,

And no change here, because this is gated on SNP-ness, and SNP is linked
to the GMEM callback CONFIGs by Kconfig. :)

>  	.gmem_invalidate_range = sev_gmem_invalidate_range,
>  	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
>  #endif
>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
