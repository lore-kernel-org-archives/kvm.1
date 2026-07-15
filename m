Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE63CDBD6
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108984; cv=none; b=B2XWm2oOV/K2d2lETqqsJ2xJyBc9A02Nwz6pc15eIi+QTR5OoPEZqPPDOCw5nM7EQS8Vji/kXmk0sPeaRFVo3meEvv9mwdAnxQpLlDzQ1bJAgh7cb0nXGPXXXLGrqqLPV6f3rSv+EQiuqd5gslQHZV1OCIh175uCBuCDfZREoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108984; c=relaxed/simple;
	bh=S6nbHBojl/pUiZN4+YuDMBg9Vaac9COCsyFF0uiRKYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLTIGghT2hIVZ4iHOUZRNRiu/WCyYlchd/giMQkUvpR1vbvtbwrN8joLT/uVaCKzBE20HkeQZ6Xo2JqB6+yWcbehoiQ5f+SSgfPTaebCUXU3k5w2cRDPhDAY+CotY/aiRgD7CJfrTxvxoUec+d6aae9TbassaTXw1VapWrp7Dfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lhhePiW2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lhhePiW2"
X-Forwarded-Encrypted: i=1; AHgh+RrRDxTirXreI+bGyGnU3ldzQjQa/+qAfYeWdmv35mrAAD/FJ+Q2/dn4LP618fmbi53YaYM=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784108979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaOO1xk5MGN53k2jQQSJtobSR4VGJpXlLKSpbF+RqE4=;
	b=lhhePiW2990xGRD/N1zN7bCuorWhVpIRVEz5iD5EA0OtO4cxf80Xwj6l+vLlfhVdoADygs
	SdeCWeDbS6oRUHps63koE33tztupYZt1oNLT2JPAIxU2jaGOMkOU5s9i03bjF+SeVEIaDe
	v/dFQXqjwhO2DrXGBriUgXQRsufYnVQ=
X-Gm-Message-State: AOJu0YyOIE/SmRFMqIad3EftafVUzPWsyc1GCGpTLn7I8Q/r27wnoy+x
	/T50oFZiTj8dsD+VRHMegBsaDp1eb5ds2h/QBehQ1ZwbDWqs56HxJJLbOwfOlAXPnqey9CzrqfF
	Gflit5gFp8moU9OWKQVQwPmRI4DRln/4wEUUWUJxs
X-Received: by 2002:a05:622a:2585:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-51d712f8066mr25886061cf.0.1784108977191; Wed, 15 Jul 2026
 02:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
In-Reply-To: <20260714231015.3337831-7-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 15 Jul 2026 10:48:59 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxJr0OHXZZ0fnBMy0wySiJx-Cdv9ind+dX62Zo3S-iAZA@mail.gmail.com>
X-Gm-Features: AUfX_mxQbS7QJ13ua5M-v3HVKkKqCwPCXqoL7TL_aksBVHlYltwyV3ytNW5Lj44
Message-ID: <CA+EHjTxJr0OHXZZ0fnBMy0wySiJx-Cdv9ind+dX62Zo3S-iAZA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jul 2026 at 00:10, Sean Christopherson <seanjc@google.com> wrote:
>
> Smush x86's prepare() and invalidate() hooks into a common convert() flow,
> as they are effectively two sides of the same coin for SNP: they're invoked
> when private/shared memory is about to made accessible/visible to the guest
> or host.  I.e. prepare() is really "make private", and invalidate() is
> really "make shared".
>
> Using a single hook will yield more intuitive code when in-place conversion
> comes along.
>
> For all intents and purposes, no functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad



> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  5 ++---
>  arch/x86/include/asm/kvm_host.h    |  7 +++----
>  arch/x86/kvm/svm/sev.c             | 21 ++++++++++++++++++---
>  arch/x86/kvm/svm/svm.c             |  3 +--
>  arch/x86/kvm/svm/svm.h             |  5 ++---
>  arch/x86/kvm/x86.c                 |  4 ++--
>  6 files changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 736129db272a..76ce691de2f8 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -146,10 +146,9 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>  KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> +#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
> +KVM_X86_OP_OPTIONAL_RET0(gmem_convert)
>  #endif
> -KVM_X86_OP_OPTIONAL(gmem_invalidate)
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
>  #endif
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e7df537d36d5..f60fec14c61a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1724,11 +1724,10 @@ struct kvm_x86_ops {
>
>         gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>         void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -       int (*gmem_prepare)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> -                           kvm_pfn_t nr_pages, int max_order);
> +#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
> +       int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +                           kvm_pfn_t nr_pages, int max_order, bool to_private);
>  #endif
> -       void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>         void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index adc58138fdd0..b00623b2f26a 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5114,8 +5114,8 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
>         return false;
>  }
>
> -int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> -                    kvm_pfn_t nr_pages, int max_order)
> +static int sev_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +                                kvm_pfn_t nr_pages, int max_order)
>  {
>         struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
>         kvm_pfn_t pfn_aligned;
> @@ -5165,8 +5165,9 @@ int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>         return 0;
>  }
>
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +static void sev_gmem_make_shared(kvm_pfn_t start, kvm_pfn_t nr_pages)
>  {
> +       kvm_pfn_t end = start + nr_pages;
>         kvm_pfn_t pfn;
>
>         if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> @@ -5228,6 +5229,20 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
>         }
>  }
>
> +int sev_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +                    kvm_pfn_t nr_pages, int order, bool to_private)
> +{
> +       if (to_private) {
> +               if (WARN_ON_ONCE(!kvm || gfn >> (kvm_host.maxphyaddr - PAGE_SHIFT)))
> +                       return -EIO;
> +
> +               return sev_gmem_make_private(kvm, gfn, pfn, nr_pages, order);
> +       }
> +
> +       sev_gmem_make_shared(pfn, nr_pages);
> +       return 0;
> +}
> +
>  void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
>         struct kvm_vcpu *vcpu;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 91286d46d13a..8c5018c65dc5 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5438,8 +5438,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>         .vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
>         .vm_move_enc_context_from = sev_vm_move_enc_context_from,
>
> -       .gmem_prepare = sev_gmem_prepare,
> -       .gmem_invalidate = sev_gmem_invalidate,
> +       .gmem_convert = sev_gmem_convert,
>         .gmem_invalidate_range = sev_gmem_invalidate_range,
>         .gmem_max_mapping_level = sev_gmem_max_mapping_level,
>  #endif
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index e35419456648..57f692b5d709 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1009,9 +1009,8 @@ int sev_cpu_init(struct svm_cpu_data *sd);
>  int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
> -int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> -                    kvm_pfn_t nr_pages, int max_order);
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +int sev_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +                    kvm_pfn_t nr_pages, int max_order, bool to_private);
>  void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d484d8b509b1..e509d50c247c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10623,14 +10623,14 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>                           kvm_pfn_t nr_pages, int max_order)
>  {
> -       return kvm_x86_call(gmem_prepare)(kvm, gfn, pfn, nr_pages, max_order);
> +       return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, true);
>  }
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>  void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
>  {
> -       kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
> +       WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
>  }
>  #endif
>
> --
> 2.55.0.141.g00534a21ce-goog
>
