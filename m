Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824136B928
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784966568; cv=none; b=GUT4sZmRxU8tNrcanbnHeOopA5oucgGu1/+7mfaKBd3R1aTCBdgq0OFzg2ulTpYtXlvylp0ttZJ/PuKRm1uTQfa0K5mN7vztQoF1qhNzM5Q8g92TYYTirA4WsijJlZY3OtT68zIqa8rT0bTNmhCxUB2zaw6yEvXj55GIf3sD5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784966568; c=relaxed/simple;
	bh=zx74btcFYXVZwC7ignGvcn2p4eiPQL9ccC8MOGndyG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWuYvN+ngYG2knPxIR7eSV+G+iA0B+HSN4Vzs4ckEBl9yqIherE5ePB8QjQ7vfGp6p2t8zZM6d/DhwbCqnckcpf/WjmEM6YJNc7LH60hcqUsbz7STmdjmfv0/ZRxGW+oQ6pjA4dNcrh+NytOZr6fQZypj/dDEpabAdCtg+U0JD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LCermjLP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LCermjLP"
X-Forwarded-Encrypted: i=1; AHgh+RoUjFw5QWCz5X5w2smhgcKRoIeylhorNauSNyUmMCzoM/CMUA/072u2wJ+DezF/VP5GfdQ=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784966564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qwee9KUj78E7wvIWOD1dfBhb3BCPCtR9hPhrKxdDkcI=;
	b=LCermjLP8omnNzvv/x4cQW+SQKZewXJCDe+eOfDcUvqYa92/w4DZED8STqiWbS/jrOy+Io
	SK9+IarIR+ZTraFXCG0PDW6vnMfwRUuKSUxwMJUm/sRNLknnKtw9aKlBP0d1HW0nTCifNI
	LT2jUv3kaAMji9jhkfejJC0r164wTb4=
X-Gm-Message-State: AOJu0YxSiFLMh4tn9HqO9SRihr72HEvJLhTvW77Rl1tjD8gFVTT3P3Jc
	K+JYHMhEQMTWvsSD6IMrwJTCo0OIgMSNbwTeO2GaWVodoDNTnNzBTqzi0TDwchkkuA3ZDs6Do2j
	qHamBGoMJG4bSHAf+8ZR/a2rQ3HoEZ5OHAyz9BTvK
X-Received: by 2002:a05:622a:1308:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-529a7705cb6mr8811091cf.11.1784966560810; Sat, 25 Jul 2026
 01:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-2-seanjc@google.com>
In-Reply-To: <20260723210811.72720-2-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 25 Jul 2026 09:01:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy85zZdDnvKFzkDq+Uu5bcYQyny=7GdUDYCjZk9iK9V1w@mail.gmail.com>
X-Gm-Features: AUfX_mxVrXN5L5Xw9vyyEDnbp7ehJNejs1DjTkAzV8kPFMVhm3oudKg67fWgmKc
Message-ID: <CA+EHjTy85zZdDnvKFzkDq+Uu5bcYQyny=7GdUDYCjZk9iK9V1w@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] KVM: guest_memfd: Pass the number of pages instead
 of the end pfn into .invalidate()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Thu, 23 Jul 2026 at 22:08, Sean Christopherson <seanjc@google.com> wrote:
>
> Pass the number of pages to "invalidate", i.e. reclaim, instead of the end
> pfn, as a first step towards aligning the function prototypes between the
> de facto "to private" and "to shared" arch hooks.  Eventually, the goal
> is to end up with kvm_gmem_arch_make_{private,shared}(), and in both cases,
> providing the number of pages makes the call sites slightly nicer, and also
> avoids any confusion over whether the end pfn is inclusive or exclusive.
>
> Opportunistically rename "start" to "pfn", again to align with the expected
> signature of make_private() (which needs to pass a starting gfn as well, at
> which point the "start" becomes noise).
>
> No functional change intended.
>
> Cc: Fuad Tabba <fuad.tabba@linux.dev>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/svm/sev.c          | 8 ++++----
>  arch/x86/kvm/svm/svm.h          | 2 +-
>  arch/x86/kvm/x86.c              | 4 ++--
>  include/linux/kvm_host.h        | 2 +-
>  virt/kvm/guest_memfd.c          | 6 +-----
>  6 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 58f156ae31e7..8c96999f49a0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1727,7 +1727,7 @@ struct kvm_x86_ops {
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>         int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  #endif
> -       void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
> +       void (*gmem_invalidate)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>         void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 82b983484af2..e6987351dc04 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5161,16 +5161,16 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
>         return 0;
>  }
>
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>  {
> -       kvm_pfn_t pfn;
> +       kvm_pfn_t end = pfn + nr_pages;
>
>         if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>                 return;
>
> -       pr_debug("%s: PFN start 0x%llx PFN end 0x%llx\n", __func__, start, end);
> +       pr_debug("%s: PFN start 0x%llx PFN end 0x%llx\n", __func__, pfn, end);
>
> -       for (pfn = start; pfn < end;) {
> +       while (pfn < end) {
>                 bool use_2m_update = false;
>                 int rc, rmp_level;
>                 bool assigned;
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index af25e4b56212..cf8fb3d6a100 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1010,7 +1010,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>  void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1f5dc685f049..65bcad3d0264 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10627,9 +10627,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>  {
> -       kvm_x86_call(gmem_invalidate)(start, end);
> +       kvm_x86_call(gmem_invalidate)(pfn, nr_pages);
>  }
>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9db6eb4023c4..911c3f08b3a2 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2614,7 +2614,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 171a9da1b685..ca1d93fb2495 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -530,11 +530,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
> -       struct page *page = folio_page(folio, 0);
> -       kvm_pfn_t pfn = page_to_pfn(page);
> -       int order = folio_order(folio);
> -
> -       kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +       kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio));
>  }
>  #endif
>
> --
> 2.55.0.229.g6434b31f56-goog
>
