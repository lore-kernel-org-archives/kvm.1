Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795D4908CF
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969330; cv=none; b=bLpOsufTahvKZLh435rbC6pNIpe2YffAhtYY2Sq6oKy4pTwg0V4+uDlROt4c31NvgCGZ8NJtFe0ZBhkobPbfuxvjckA3/7lYEMHWNbn2Dt0Kgv6AKIxR66fEkW9xyktZVrJ+nT27ccZ7cJjPTxUN6hJGZUenVNNxefxH4idSUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969330; c=relaxed/simple;
	bh=4EINSdAn+bnE/1hfeqOfLcUaOfOMhfOZYPAjnIoMyYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1DPgs73WhuSnNRwTKiEO9kTS7eYMj5hfA1RAKdKiB5n2kc7UMumxU7VbUXUYbPy+7CMoUxdNY6h0OOHl0ifE/uLOAPdNRNQaSmX05InVy97mboJYZyFNIU80OEXKaAv1RhKI+b/VyVDa0eYq7ynhsEvdivdBn7+QqKSSQbZ+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f6YAeAdj; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f6YAeAdj"
X-Forwarded-Encrypted: i=1; AHgh+Rq4xYYbARfuyaBeDDHhKl8Len3z+zYTCK04sCi3A8gbgTIp4zCPbAxVvDzgUGUS4JNdqhQ=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784969326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1n4UiLV1+MdfKf/+aNDXAGLFrtFceFuhblYq7KZBz4Y=;
	b=f6YAeAdjzLMtDpjfz0EmOAzGSkDfndxz2aRwtjIvN3keV/EHj3/QJwoYuJ+7kkGvG8lxUM
	D8M4xh+aKFzejybi/qgE0hVDG+ZCIDqy3tgdnkK6LaZNoJbWm6WV48ozaLMZu5PiVyJCnR
	59LyHUFQ9M/TuvlLAqyFxAZY/KI7goA=
X-Gm-Message-State: AOJu0YxNPoh++L9JSdiNSehmGEdG95mLe9jnT3T0nVHfiguVv6Vn8Qof
	Xa2GGnLVeV3tyNE4vCzgEjt+iudob1gXNwGWY1zcWAbDdRntjIRedbAVkRonwmslNBanB4Qh2g6
	8BbTmvKsuxYtuNU2czT202Pp5cctOOkCqFzzHYKFf
X-Received: by 2002:a05:622a:354:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-529a5f15b56mr11214351cf.8.1784969324084; Sat, 25 Jul 2026
 01:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-8-seanjc@google.com>
In-Reply-To: <20260723210811.72720-8-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 25 Jul 2026 09:47:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzGmojb+4bzVh9Nf2a5YN58re5pC9YmPgJ_5BnDFrEQzw@mail.gmail.com>
X-Gm-Features: AUfX_mxjXxrXxr6fqycepQ_yObqCIcbhVXMiqCYsnoNgoz1zZ-yiV18ZNsbfKnM
Message-ID: <CA+EHjTzGmojb+4bzVh9Nf2a5YN58re5pC9YmPgJ_5BnDFrEQzw@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] KVM: guest_memfd: Rename prepare() hook and
 Kconfig to make_private() / CONVERT
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Thu, 23 Jul 2026 at 22:08, Sean Christopherson <seanjc@google.com> wrote:
>
> Rework guest_memfd's prepare() hook into a more accurate make_private(),
> and rework its Kconfig from PREPARE to a more generic CONVERT.  This will
> allow x86 to share (pun intended) a kvm_x86_ops.gmem_make_shared() hook
> between the "convert to shared" and "reclaim" flows, which are one and the
> same for SNP.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 4 ++--
>  arch/x86/include/asm/kvm_host.h    | 4 ++--
>  arch/x86/kvm/Kconfig               | 2 +-
>  arch/x86/kvm/svm/sev.c             | 2 +-
>  arch/x86/kvm/svm/svm.c             | 2 +-
>  arch/x86/kvm/svm/svm.h             | 2 +-
>  arch/x86/kvm/x86.c                 | 6 +++---
>  include/linux/kvm_host.h           | 5 +++--
>  virt/kvm/Kconfig                   | 2 +-
>  virt/kvm/guest_memfd.c             | 4 ++--
>  10 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 210cb95d0a0b..a4d872ddef9d 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -146,8 +146,8 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>  KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +KVM_X86_OP_OPTIONAL_RET0(gmem_make_private)
>  #endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>  KVM_X86_OP_OPTIONAL(gmem_make_shared)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4dc8a03c829a..4be57157136b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1724,8 +1724,8 @@ struct kvm_x86_ops {
>
>         gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>         void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -       int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +       int (*gmem_make_private)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  #endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>         void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
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
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4aa8330d5b2d..0ecba768c153 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5114,7 +5114,7 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
>         return false;
>  }
>
> -int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
> +int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
>  {
>         struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
>         kvm_pfn_t pfn_aligned;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index b8c9967dd0de..d5a08f1db84b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5438,7 +5438,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>         .vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
>         .vm_move_enc_context_from = sev_vm_move_enc_context_from,
>
> -       .gmem_prepare = sev_gmem_prepare,
> +       .gmem_make_private = sev_gmem_make_private,
>         .gmem_make_shared = sev_gmem_make_shared,
>         .gmem_invalidate_range = sev_gmem_invalidate_range,
>         .gmem_max_mapping_level = sev_gmem_max_mapping_level,
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index b2acb5ab7c26..ad849edcacc7 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1009,7 +1009,7 @@ int sev_cpu_init(struct svm_cpu_data *sd);
>  int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
> -int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>  void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 249267ed2a9d..e7865b28d37b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10619,10 +10619,10 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>         return !kvm_arch_has_private_mem(kvm);
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
>  {
> -       return kvm_x86_call(gmem_prepare)(kvm, pfn, gfn, max_order);
> +       return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
>  }
>  #endif
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0b5b9cb022ba..9cf01429281b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2579,8 +2579,9 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GUEST_MEMFD */
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +                              int max_order);
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
> index f64cd87ec8b0..466f611ad4b7 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -73,11 +73,11 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>                                     pgoff_t index, struct folio *folio)
>  {
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>         kvm_pfn_t pfn = folio_file_pfn(folio, index);
>         gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
>
> -       return kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
> +       return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_order(folio));
>  #else
>         return 0;
>  #endif
> --
> 2.55.0.229.g6434b31f56-goog
>
