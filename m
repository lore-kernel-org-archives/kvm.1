Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C27270EC3
	for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883179; cv=none; b=kHoCWLii14/y6By4XDcT36CgJPLXc0J6N1XCV7A+OXD3g6Rd/O7JSecRpJRCh1y+IXz4TNYZEV4CzC0RTJDMqUVbnbVpiZhyQq6lENWqEbarZuEL3GIsazQlMMBB7pcK4TQVCo0xFl7rY/GWOaQLHyHGcMihT4j7sK13xUsH1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883179; c=relaxed/simple;
	bh=ViKDE5xZPK1FfMg2IN/ZNZ/G2QheaLPjQdDCJszeehI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBFDJQxRtQfsMHTBTXMkaHvQlKAmyNuuTXrgI2HqD3darNeYortqEOiZ5yWxerHZOIqDq3A1ZTFusQQg9LipLPsFMngaDPU/80jxvXoc5m2BeFCvucEiUpgqSKAmpXRGN8Jr6dV9ZTfdkcRIOCRwoNBGxN1Ymo6yvTGd6MTjXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IAq2tdgd; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IAq2tdgd"
X-Forwarded-Encrypted: i=1; AHgh+Rplbx9zC0NgwPEWdWUVYYy+z99LBxV4HrVEiDRxS2DWcS5l9j7SoYg82clcQJBynaVosV0=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783883172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WeYz/OWnsE6RgWqN60WFRF2gm3rBujCwWPtV+yefOUQ=;
	b=IAq2tdgd4v6K/z0+IqRVDBThLc+GALM9JsoN7NfhOGU0U/mOdG+4+r8EfzBi5TholCWPrG
	k2TknlPrNnL+nYwKJ1163Jd80/oyw8Nsn37YFOZ4rhLnNWtBEjjOYT2HGAdyO5MfutNDsS
	jrabXNxxZSYPWuKewL4CsIpf3cvNmpo=
X-Gm-Message-State: AOJu0Yx47QB0jub9O5mU74tFTaQEIzWgzvOUV3QoB0ZL44docPbPfUCT
	MQa67f81aizdsp+uOGpVdf0tGw0u1bJgeTyewAQa4fEiNpaqQ3GffPyVOMdewJfZNdecZDhQkeQ
	7p8MBNU41jr0qMr2cSRp5PJylTwdjL+guAgBpistY
X-Received: by 2002:ac8:5c92:0:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-51cbe27a7e5mr11469411cf.12.1783883154673; Sun, 12 Jul 2026
 12:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
In-Reply-To: <20260709204948.1988414-19-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sun, 12 Jul 2026 20:05:17 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxJMfiGoJGetvsOWXeHjFQexFh=sdQ_kvSQT86uztAaLQ@mail.gmail.com>
X-Gm-Features: AUfX_mzla8OQnQ9QlEtdN_ghSLfn-Zwwj4XsT6icgUeOIwn4edKy-3SeT4FqlnU
Message-ID: <CA+EHjTxJMfiGoJGetvsOWXeHjFQexFh=sdQ_kvSQT86uztAaLQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Thu, 9 Jul 2026 at 21:50, Sean Christopherson <seanjc@google.com> wrote:
>
> Smush guest_memfd's prepare() and invalidate() hooks into a common
> convert() flow, as they are effectively two sides of the same coin: they're
> invoked when private/shared memory is about to made accessible visible to
> the guest/host.  I.e. prepare() is really "make private", and invalidate()
> is really "make shared".

That holds for SNP, where both paths end in rmp_make_shared(). It doesn't hold
for pKVM: conversion has to preserve the page (same physical page, no
encryption, which is the point of in-place conversion for us), while teardown
has to scrub it, so that a malicious host can't read a newly reclaimed guest
page.


> Using a single API fixes the wart where invalidate() isn't actually doing
> invalidation, avoids adding yet another gmem Kconfig, avoids having to come
> up with a name to describe the "make shared" behavior, and will yield more
> intuitive code when in-place conversion comes along.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  5 ++---
>  arch/x86/include/asm/kvm_host.h    |  7 +++----
>  arch/x86/kvm/Kconfig               |  2 +-
>  arch/x86/kvm/svm/sev.c             | 21 ++++++++++++++++++---
>  arch/x86/kvm/svm/svm.c             |  3 +--
>  arch/x86/kvm/svm/svm.h             |  5 ++---
>  arch/x86/kvm/x86.c                 | 15 ++++-----------
>  include/linux/kvm_host.h           |  7 +++----
>  virt/kvm/Kconfig                   |  2 +-
>  virt/kvm/guest_memfd.c             | 25 ++++++++++++-------------
>  10 files changed, 47 insertions(+), 45 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 736129db272a..6091987860bd 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -146,10 +146,9 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>  KVM_X86_OP_OPTIONAL(get_untagged_addr)
>  KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +KVM_X86_OP_OPTIONAL_RET0(gmem_convert)
>  #endif
> -KVM_X86_OP_OPTIONAL(gmem_invalidate)
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
>  #endif
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3e34435f7e4e..3b4311048926 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1903,11 +1903,10 @@ struct kvm_x86_ops {
>
>         gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>         void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -       int (*gmem_prepare)(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> -                           kvm_pfn_t nr_pages, int max_order);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +       int (*gmem_convert)(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> +                           kvm_pfn_t nr_pages, int max_order, bool to_private);
>  #endif
> -       void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>         void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 801bf9e520db..52e75d83a4d2 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -160,7 +160,7 @@ config KVM_AMD_SEV
>         depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>         select ARCH_HAS_CC_PLATFORM
>         select KVM_GENERIC_MEMORY_ATTRIBUTES
> -       select HAVE_KVM_ARCH_GMEM_PREPARE
> +       select HAVE_KVM_ARCH_GMEM_CONVERT
>         select HAVE_KVM_ARCH_GMEM_INVALIDATE
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>         help
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3e7792afbab4..b7f0d688f699 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5112,8 +5112,8 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
>         return false;
>  }
>
> -int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> -                    kvm_pfn_t nr_pages, int max_order)
> +static int sev_gmem_make_private(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> +                                kvm_pfn_t nr_pages, int max_order)
>  {
>         struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
>         gfn_t gfn = gpa_to_gfn(gpa);
> @@ -5164,8 +5164,9 @@ int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
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
> @@ -5227,6 +5228,20 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
>         }
>  }
>
> +int sev_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> +                    kvm_pfn_t nr_pages, int order, bool to_private)
> +{
> +       if (to_private) {
> +               if (WARN_ON_ONCE(!kvm || gpa == INVALID_GPA))
> +                       return -EIO;
> +
> +               return sev_gmem_make_private(kvm, gpa, pfn, nr_pages, order);
> +       }
> +
> +       sev_gmem_make_shared(pfn, nr_pages);

free_folio is the only to_private=false caller today, but the cover
letter sketches the other one, a private->shared conversion through
kvm_gmem_make_shared(inode, start, end). Once that lands both reach
the hook with to_private=false, and as far as I can tell, the only
thing separating them is kvm == NULL / INVALID_GPA. That isn't
documented as a contract, and nothing in-tree reads it on that branch
(the kvm/gpa check is under if (to_private), and
sev_gmem_make_shared() doesn't take a kvm at all), so nothing would
catch it regressing. The sketch is also inode-scoped, so I'm not sure
the conversion path passes a non-NULL kvm at all; if it doesn't, the
two aren't distinguishable.

> +       return 0;
> +}
> +
>  void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
>         struct kvm_vcpu *vcpu;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index dd51df74c2dc..f462ac9bbc93 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5450,8 +5450,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
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
> index 45a9e2d5417c..aa12e6a80e83 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1009,9 +1009,8 @@ int sev_cpu_init(struct svm_cpu_data *sd);
>  int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
> -int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> -                    kvm_pfn_t nr_pages, int max_order);
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +int sev_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> +                    kvm_pfn_t nr_pages, int max_order, bool to_private);
>  void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a167f42bb1af..f51303ff3a1e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10589,18 +10589,11 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>         return !kvm_arch_has_private_mem(kvm);
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> -                         kvm_pfn_t nr_pages, int max_order)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> +                         kvm_pfn_t nr_pages, int max_order, bool to_private)
>  {
> -       return kvm_x86_call(gmem_prepare)(kvm, gpa, pfn, nr_pages, max_order);
> -}
> -#endif
> -
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> -{
> -       kvm_x86_call(gmem_invalidate)(start, end);
> +       return kvm_x86_call(gmem_convert)(kvm, gpa, pfn, nr_pages, max_order, to_private);
>  }
>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 469c22b551ee..eb5a3349381c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2572,9 +2572,9 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GUEST_MEMFD */
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> -                         kvm_pfn_t nr_pages, int max_order);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
> +                         kvm_pfn_t nr_pages, int max_order, bool to_private);
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> @@ -2608,7 +2608,6 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
>
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 794976b88c6f..53803c5777a4 100644
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
> index 4082cde3f3fc..d780ea0494d2 100644
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
> @@ -90,9 +90,9 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>         gfn = ALIGN_DOWN(gfn, nr_pages);
>         index = kvm_gmem_get_index(slot, gfn);
>
> -       return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
> +       return kvm_arch_gmem_convert(kvm, gfn_to_gpa(gfn),
>                                      folio_file_pfn(folio, index), nr_pages,
> -                                    folio_order(folio));
> +                                    folio_order(folio), true);
>  #else
>         return 0;
>  #endif
> @@ -517,14 +517,13 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>         return MF_DELAYED;
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>  static void kvm_gmem_free_folio(struct folio *folio)

The Kconfig now couples them too: an arch can't take teardown without also
taking conversion. pKVM wants teardown and not conversion, so that's a problem
for us today, not only once the second caller lands.

This is the same ground as v8 15/46, which ended with the two split under
separate Kconfigs. Suzuki confirmed CCA disables both; pKVM wants teardown only,
since our conversions are guest-initiated and EL2 has already done the
transition by the time the host runs the generic path [1].

I'd rather keep the free path on its own callback. If you want a single hook,
passing the caller explicitly instead of leaving it implied by kvm would work
too. Merging the two conversion directions is a genuine cleanup, it's the free
path I'd like to keep separate.

Thanks,
/fuad

[1] https://lore.kernel.org/all/CA+EHjTwLRzrq0vY0-OosENJ2Gkknerux53aVBj0zGRQUkRQP=A@mail.gmail.com/

>  {
> -       struct page *page = folio_page(folio, 0);
> -       kvm_pfn_t pfn = page_to_pfn(page);
> -       int order = folio_order(folio);
> -
> -       kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +       WARN_ON_ONCE(kvm_arch_gmem_convert(NULL, INVALID_GPA,
> +                                          folio_file_pfn(folio, 0),
> +                                          folio_nr_pages(folio),
> +                                          folio_order(folio), false));
>  }
>  #endif
>
> @@ -532,7 +531,7 @@ static const struct address_space_operations kvm_gmem_aops = {
>         .dirty_folio = noop_dirty_folio,
>         .migrate_folio  = kvm_gmem_migrate_folio,
>         .error_remove_folio = kvm_gmem_error_folio,
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>         .free_folio = kvm_gmem_free_folio,
>  #endif
>  };
> @@ -802,7 +801,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                 folio_mark_uptodate(folio);
>         }
>
> -       r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +       r = kvm_gmem_make_private(kvm, slot, gfn, folio);
>
>         folio_unlock(folio);
>
> --
> 2.55.0.795.g602f6c329a-goog
>
