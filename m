Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50213CB918
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103378; cv=none; b=MhyFAmdxszB/nKwYjRWq4fyIcFbI7HeV3g+E0OrW05AMRYFEay0h2rb0AELwivfVql+wePX4LBuFkPEUPxHR6htSwwr+ukDBbxxJZ3AJ56BJJF8y6norLUsCwP0dR9D5xNPJln/72bjQNccDSKEWnx9Ay0MoXUQAc9UG2wBmp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103378; c=relaxed/simple;
	bh=iM2lFgpaEeftMaOmGUmZb24aXBY27UDHmiD6vsYhnbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCdMJHrQ9hx3H+5uVB+pi5V0gYWA4kiu1ZvSvLlg3Lj5idcGHpak2uLnXe+TteVQphehIX5JAKYDFmmWxlSfyB+yEH+zOARM5U7AgwCBt2LgUZuyYI/XlY1CHYUYftsvaAirH3PGDkyFwdCY1POR6DuIbASjy3+06DUO5g/dsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xsgf+Gbk; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xsgf+Gbk"
X-Forwarded-Encrypted: i=1; AHgh+RrJ8203kvOfUFOA7cWXWR5anClPln71jFudpOy+29VyNeTg6q+Z6a4TdmTJ813m0wmM0yw=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784103374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u5OhqlZJmCqfdfQFQmFzst115rcNLH7EtMRkp6F4shU=;
	b=xsgf+GbkOP6te49CIbB7kAGbBJjDxV8wAMmYugJsSUo2+yODVxotV/cpjqDW0rOmVr0LiV
	0kVxYguFOpTdIb7pq/eUKxNOLZpGIFir20Azuuv1aSFOECn0QhGQ1CfsvL1amgKTnxMqod
	XjFyffjJldYFozLNdIhOrINOnluf7io=
X-Gm-Message-State: AOJu0YwuHyWfPJI70GpVg38/SDZCGZEkwSjR81FRw0hGkxEVPuqu7hGi
	h1r/n/UjJJvRrQkjIEdFkcwdNddFlqevLliICHa+Qbp46S9aQCvq6L/s7b+qn1uzXD30BxGXAiu
	/UKh0pN/02BkgwEmK6mxXIbgNpw9vrodhPjRtJKps
X-Received: by 2002:a05:622a:11d5:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-51d71390395mr23797331cf.0.1784103361925; Wed, 15 Jul 2026
 01:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-2-seanjc@google.com>
In-Reply-To: <20260714231015.3337831-2-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 15 Jul 2026 09:15:25 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyymGPjSQKv5YKFeBPWAU5g+bq6zw6mjjMUYbKXeePaEA@mail.gmail.com>
X-Gm-Features: AUfX_my3irx__1K-vOX_9h1iV-XHlNA8efEJbB8MOGP7d-c7LbA99cRoeNeVwrQ
Message-ID: <CA+EHjTyymGPjSQKv5YKFeBPWAU5g+bq6zw6mjjMUYbKXeePaEA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] KVM: guest_memfd: Plumb the number of pages and
 max order into .invalidate()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jul 2026 at 00:10, Sean Christopherson <seanjc@google.com> wrote:
>
> Plumb the number of pages to "invalidate", i.e. reclaim, along with the max
> order with which the pages can be mapped.  This will allow x86 to combine
> its vendor-specific implementations for conversion and reclaim, a.k.a.
> preparation and invalidation, into a single hook.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c       | 4 ++--
>  include/linux/kvm_host.h | 2 +-
>  virt/kvm/guest_memfd.c   | 7 ++-----
>  3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1f5dc685f049..a2cbf6fae118 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10627,9 +10627,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
>  {
> -       kvm_x86_call(gmem_invalidate)(start, end);
> +       kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
>  }
>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9db6eb4023c4..996b39ebdb68 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2614,7 +2614,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
>  #endif
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int order);

nit: the declaration names the last parameter "order" here, but the
definition in arch/x86/kvm/x86.c calls it "max_order".

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

>  void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 171a9da1b685..99c070bfd446 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -530,11 +530,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
> -       struct page *page = folio_page(folio, 0);
> -       kvm_pfn_t pfn = page_to_pfn(page);
> -       int order = folio_order(folio);
> -
> -       kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +       kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio),
> +                                folio_order(folio));
>  }
>  #endif
>
> --
> 2.55.0.141.g00534a21ce-goog
>
