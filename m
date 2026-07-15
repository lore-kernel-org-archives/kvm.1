Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E918332EA0
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103618; cv=none; b=lClwdZkk0wnN7XTmqs/X7/2dSPh8NFF724gC8TB8rF7ftaSofBOl8JO2dpScniOhrX3PCNcAC9Ik4+yMEr6g5ocXL6qj55hi6C42eP0s4WPFxuSswSdDF/I1z0GE/IDFYimGam1+tKVH6kbBcUNp155wvEk1I70iaOI2EyuMRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103618; c=relaxed/simple;
	bh=jJh9ZuW9O24494+EjWpfeIWqXU4Q5c6Sd18SAT2vPCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuMIdjhXyCRU3gAUvD9No331wdsdX09Q+vzjpwurJ0H6xX1WSPycucagxV26pzhxEqroUI/vtEigfP57R4gNty9gmoSf0IrekNPehivjVZwmY1JKWgKYK3iyxv/8T+eQQNi082Ui0rom/wEDSVxWpTxpgUznjcgjzJZuC1+h08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OSKIk56H; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OSKIk56H"
X-Forwarded-Encrypted: i=1; AHgh+RqeByT5g7Uy4Mc3xoS69k80U23VCHGsoGXtOiffm7g1DdSX4gASqbvB50IURgFAHtaqtsg=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784103615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDsSNRYgWi7Q6S4uf8pA831JFQj+lOxREwiJnCsNV3Q=;
	b=OSKIk56HnkyTH7HeU89ABRLl7LRLDkYomznvJSEnYI2Id6lxRP8OyNZJSOJqVKARNm7GqO
	H5Bqd/9LpxiOT4C+WNCJm073TWQCRtWbIMzxoSngukDkiMjr/gzLgNYsdGOdxUKqyMNEKe
	XMXCU7dVQSupQRApCKE3+myHs8Sc5NU=
X-Gm-Message-State: AOJu0YxjPsTCUBhAv8z3U89P4CVGNsPSUJHcGTAR8VcXR4zVROpA0YCh
	soZMTKSHA5TjFG7lmQBmuqDyZbI3g1OCtXtMMxi0mMO3hSb4SViHOeHpOb0+VhMCiEjhiCnEKOJ
	CLKD9OnPz1JKNGF19DrCN7UEb5a503T/U222BJnQW
X-Received: by 2002:a05:622a:53cb:b0:51c:7a90:a79a with SMTP id
 d75a77b69052e-51d83860d08mr25112831cf.26.1784103601210; Wed, 15 Jul 2026
 01:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-3-seanjc@google.com>
In-Reply-To: <20260714231015.3337831-3-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 15 Jul 2026 09:19:24 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx-NB22a94VJ7hkLbNjsZcPepse-WLDsvjPNsStDTpALQ@mail.gmail.com>
X-Gm-Features: AUfX_mw4GKRUAJ8S64_Nm0B4rbykpDyNFmtmVXTIWudHD5lqNgjl9FCCydt76C4
Message-ID: <CA+EHjTx-NB22a94VJ7hkLbNjsZcPepse-WLDsvjPNsStDTpALQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] KVM: guest_memfd: Rename invalidate() arch hook to
 reclaim() and isolate it
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jul 2026 at 00:10, Sean Christopherson <seanjc@google.com> wrote:

>
> Rename guest_memfd's invalidate() hook to reclaim() and isolate it via its
> own RECLAIM Kconfig, as the hook is called when a folio is freed, which is
> far too late and lacks sufficient information for KVM to actually
> invalidate its usage of the memory.  E.g. SNP uses the hook to convert
> memory back to SHARED so that it can be safely accessed by the host, there
> is no invalidation of guest mappings anywhere.  Isolating the hook will
> also allow pKVM on arm64 to opt-in to reclaim() without also having to
> differentiate between reclaim and conversions to shared for active VMs.
>
> Keep guest_memfd's trampoline, even though it would be trivial to wire up
> .free_folio() directly to an arch callback, to avoid bleeding guest_memfd
> internals into arch code (specifically, avoid referencing folios in arch
> code).
>
> Leave the kvm_x86_ops hook as-is for the moment, as the hook can be dropped
> entirely ("reclaim" on SNP is the same as convert-to-shared).
>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks Sean, this matches what pKVM needs: we'll select
HAVE_KVM_ARCH_GMEM_RECLAIM and implement kvm_arch_gmem_reclaim() only,
without the convert hook, so teardown (which for pKVM must scrub the
page before it returns to the host) stays distinct from a
private->shared conversion (which must preserve it).

Same nit as patch 1 (order/max_order).

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  arch/x86/kvm/Kconfig     | 1 +
>  arch/x86/kvm/x86.c       | 7 +++++--
>  include/linux/kvm_host.h | 5 ++++-
>  virt/kvm/Kconfig         | 4 ++++
>  virt/kvm/guest_memfd.c   | 8 ++++----
>  5 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 801bf9e520db..e0e7ad015839 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -161,6 +161,7 @@ config KVM_AMD_SEV
>         select ARCH_HAS_CC_PLATFORM
>         select KVM_GENERIC_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_PREPARE
> +       select HAVE_KVM_ARCH_GMEM_RECLAIM
>         select HAVE_KVM_ARCH_GMEM_INVALIDATE
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>         help
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a2cbf6fae118..08d24c6fffa4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10626,11 +10626,14 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  }
>  #endif
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> +void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
>  {
>         kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
>  }
> +#endif
> +
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
>         kvm_x86_call(gmem_invalidate_range)(kvm, range);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 996b39ebdb68..ee87ddd3294f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2613,8 +2613,11 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
>                        kvm_gmem_populate_cb post_populate, void *opaque);
>  #endif
>
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> +void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int order);
> +#endif
> +
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int order);
>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
>
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 794976b88c6f..617876993225 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -111,6 +111,10 @@ config HAVE_KVM_ARCH_GMEM_PREPARE
>         bool
>         depends on KVM_GUEST_MEMFD
>
> +config HAVE_KVM_ARCH_GMEM_RECLAIM
> +       bool
> +       depends on KVM_GUEST_MEMFD
> +
>  config HAVE_KVM_ARCH_GMEM_INVALIDATE
>         bool
>         depends on KVM_GUEST_MEMFD
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 99c070bfd446..d5d227476cda 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -527,11 +527,11 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>         return MF_DELAYED;
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
> -       kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio),
> -                                folio_order(folio));
> +       kvm_arch_gmem_reclaim(folio_file_pfn(folio, 0), folio_nr_pages(folio),
> +                             folio_order(folio));
>  }
>  #endif
>
> @@ -539,7 +539,7 @@ static const struct address_space_operations kvm_gmem_aops = {
>         .dirty_folio = noop_dirty_folio,
>         .migrate_folio  = kvm_gmem_migrate_folio,
>         .error_remove_folio = kvm_gmem_error_folio,
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>         .free_folio = kvm_gmem_free_folio,
>  #endif
>  };
> --
> 2.55.0.141.g00534a21ce-goog
>
