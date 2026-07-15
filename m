Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5022931C2
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109263; cv=none; b=Qk/PG89yuX7p9b8UiGjK9u3vD+TsJEhPzp001v1r6iYWmrMuTnuWiE4tqquH+iSp479qrxVCiYM9Fed7+oIupqSeubMWmN0ZGa8UpZ1d7HgZHEhQBqAzWJ73csu0L6YKysygSKgyGWdmBxDZKijmvJnFsPh9HhWqoFpVLO/pzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109263; c=relaxed/simple;
	bh=b2LrokT+U4MOL+GWe9GCXonXnp3HAtPYXoEd08UYSjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z92iWBHV+FfD5abaBJs2Hmo3ItgXfuYMZcnXroz919FBb+0X+DvTWduG8VIELzNTJPKUlNNhky4gWMkUHrTW2PcHQayVALJ8fGLaSMaqDOj5YbQ5d0NT4iyXmTkhwaQv3jMxeyGT+uck+e2dZkiTxxfUXDj/uRr2COf87ot2u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ghv2G2/z; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ghv2G2/z"
X-Forwarded-Encrypted: i=1; AHgh+RpuLdF5g1Djkia32ATX7iuzlUODuRxSMhMm+5WWUvzCKmv8yju2kLh2EpesHLC1bJ9qCL4=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784109259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SDTSPyD15lloQEoJjcCZcTvVtsVKbK7tIq07bCtlKTk=;
	b=Ghv2G2/zbovKQVERK3isWMMKxBnssXR2JJDp6En0T9oDpxtB6OZaotNqpZ6JQKKOWWDuao
	iyrkvQ/xOEwYmJvv9kPGdlDJG5oY1aHXkiKqlQQsROMK6uedNJPs+GlXM7zO3Bo3uzatXP
	Czd+qEUCMTUOA5chTeHYqA7KFLUTIAw=
X-Gm-Message-State: AOJu0YwGPEgJ1B7/9zDt0v8QBKv6LGw6j1swU05slX4Xjzd3pJfH39fE
	NkKKjJY4sf+cX59DVRd/Y17Nlpu0ZPvVlTTSYlkpETo7mZjRAlwrqw5wC3adh5xffGvLHAUCVNy
	C/DozPcJ7de3V3wMz9s7V9bdynjO0ZtHMlR5FZXmW
X-Received: by 2002:ac8:7fd1:0:b0:51c:9ad:d76 with SMTP id d75a77b69052e-51d7c6a8b03mr25082111cf.19.1784109246277;
 Wed, 15 Jul 2026 02:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-8-seanjc@google.com>
In-Reply-To: <20260714231015.3337831-8-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 15 Jul 2026 10:53:28 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwrPVWymFF1N73EOTg6sacEE9SKYBfL8czr+q0wbF1uoQ@mail.gmail.com>
X-Gm-Features: AUfX_mzUjyC6YUh-IT7klcv1xtTituhy4MFRU-l0Va9GA5uBpSaMebNPWO9gOrA
Message-ID: <CA+EHjTwrPVWymFF1N73EOTg6sacEE9SKYBfL8czr+q0wbF1uoQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jul 2026 at 00:10, Sean Christopherson <seanjc@google.com> wrote:
>
> Rework guest_memfd's "prepare" hook into a more generic "convert" flow in
> anticipation of supporting in-place conversion, at which point KVM will use
> the hook for both to-private and to-shared conversions, not just to
> "prepare" PRIVATE memory.
>
> Opportunistically rename kvm_gmem_prepare_folio() to kvm_gmem_make_private()
> to better reflect its role.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  2 +-
>  arch/x86/include/asm/kvm_host.h    |  2 +-
>  arch/x86/kvm/Kconfig               |  2 +-
>  arch/x86/kvm/x86.c                 |  8 ++++----
>  include/linux/kvm_host.h           |  6 +++---
>  virt/kvm/Kconfig                   |  2 +-
>  virt/kvm/guest_memfd.c             | 12 ++++++------
>  7 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 76ce691de2f8..1764bad03b17 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -146,7 +146,7 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>  KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> -#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
> +#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_convert)
>  #endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index f60fec14c61a..08c4af487fa1 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1724,7 +1724,7 @@ struct kvm_x86_ops {
>
>         gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>         void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> -#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
> +#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
>         int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>                             kvm_pfn_t nr_pages, int max_order, bool to_private);
>  #endif
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index e0e7ad015839..538ed1e80332 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -160,7 +160,7 @@ config KVM_AMD_SEV
>         depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>         select ARCH_HAS_CC_PLATFORM
>         select KVM_GENERIC_MEMORY_ATTRIBUTES
> -       select HAVE_KVM_ARCH_GMEM_PREPARE
> +       select HAVE_KVM_ARCH_GMEM_CONVERT
>         select HAVE_KVM_ARCH_GMEM_RECLAIM
>         select HAVE_KVM_ARCH_GMEM_INVALIDATE
>         select HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e509d50c247c..11017f49b94a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10619,11 +10619,11 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>         return !kvm_arch_has_private_mem(kvm);
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> -                         kvm_pfn_t nr_pages, int max_order)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +                         kvm_pfn_t nr_pages, int max_order, bool to_private)
>  {
> -       return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, true);
> +       return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, to_private);
>  }
>  #endif
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0a06234a8a8b..fdbd697d0337 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2579,9 +2579,9 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GUEST_MEMFD */
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> -                         kvm_pfn_t nr_pages, int max_order);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +                         kvm_pfn_t nr_pages, int max_order, bool to_private);
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 617876993225..c3c0ee253fc7 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -107,7 +107,7 @@ config KVM_GUEST_MEMFD
>         select XARRAY_MULTI
>         bool
>
> -config HAVE_KVM_ARCH_GMEM_PREPARE
> +config HAVE_KVM_ARCH_GMEM_CONVERT
>         bool
>         depends on KVM_GUEST_MEMFD
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 0f6745f3b919..173a7ed008d1 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -66,10 +66,10 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>   * On successful return the guest sees a zero page so as to avoid
>   * leaking host data and the up-to-date flag is set.
>   */
> -static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> -                                 gfn_t gfn, struct folio *folio)
> +static int kvm_gmem_make_private(struct kvm *kvm, struct kvm_memory_slot *slot,
> +                                gfn_t gfn, struct folio *folio)
>  {
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>         unsigned long nr_pages = folio_nr_pages(folio);
>         pgoff_t index;
>
> @@ -90,8 +90,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>         gfn = ALIGN_DOWN(gfn, nr_pages);
>         index = kvm_gmem_get_index(slot, gfn);
>
> -       return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
> -                                    nr_pages, folio_order(folio));
> +       return kvm_arch_gmem_convert(kvm, gfn, folio_file_pfn(folio, index),
> +                                    nr_pages, folio_order(folio), true);
>  #else
>         return 0;
>  #endif
> @@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 folio_mark_uptodate(folio);
>         }
>
> -       r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +       r = kvm_gmem_make_private(kvm, slot, gfn, folio);
>
>         folio_unlock(folio);
>
> --
> 2.55.0.141.g00534a21ce-goog
>
