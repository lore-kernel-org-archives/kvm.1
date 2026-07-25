Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB728258EF3
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784967925; cv=none; b=ODF/TilihauZNuroIbtuwQiB2FNasoHZOZGELgTeUwVFQu8TQ1+z79yRlEOYW1IxQ8yRAQakkRbw20sxu+uD2sIKgLzZTzTTIliCKZOfi/UYBjzWEuk5XQolVztJ8ftSIJP+2ZJEhriv4iuL1il9G9hvziQmaE5xVDl51yEXaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784967925; c=relaxed/simple;
	bh=gbvBhzoK1NdPw7wExNoLcEeqnBrb8ffavmBPWAF9OvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxpARJ7B4rldoTWJ8T68Gl8D6L836QkVI/k4u9QaVbXYclcdnWpmHH206lZzWh/nVVwr8NkbkCzAhDft5s0oOJYRhYuQdBatd7iByVg+beG36xnNS3HRHkXEI0CV8nJ9ox8VWEBPTGpic7mrxUdnC7Km5aXnNuyEapWYgzrJTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n636+7iy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n636+7iy"
X-Forwarded-Encrypted: i=1; AHgh+RoZ6MJGBfM6X27dmHONVnR95LxWlbqc83hfz8W31GbRruiwMz1TSkbOAH4Aobxf/E2I7CY=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784967920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Snsb2bh2isPPVbe6mWFguhaLek1NG4c7MFM22qAnYmk=;
	b=n636+7iyGz0VQtYz8jyBpIteRjIizyZiM/CoWaCOEtL2rbOZNaUy2VYZJFVhZz4rXMdiFJ
	9y3ZYrANM2HqDRSG1Szx1C1KQ6avFWACsdwx/GdccQwrzr6s9/rSlXlzgfUxXpLMWqD+fW
	NywXD9S9JgBuQfihZzOMTHyyEOA3FI8=
X-Gm-Message-State: AOJu0YxF65XKOe3PDOqAODccnWOTxDujEKsNqPQ029AABYsGMlEJvi5W
	TG/q8wFQPum10/VB+NqcHYIU9oBwbDKsfF+vpt8QXdYHC79LyP+hxqVv9XDxxAtOBFiwv6NNCG3
	VqI9g4tszTfguwmXopqgxVXISqRY5mLY+IY7QsPAo
X-Received: by 2002:a05:622a:1f85:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-529a5db6ae5mr12075401cf.2.1784967917029; Sat, 25 Jul 2026
 01:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-4-seanjc@google.com>
In-Reply-To: <20260723210811.72720-4-seanjc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 25 Jul 2026 09:25:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxHwbpWRP8mxD0A2Sw+iicYfTjugHukCoi56KkdrbY6kg@mail.gmail.com>
X-Gm-Features: AUfX_mwESCgpCzP2UQ0cHu12CCSTCpEKc-Audfkqgfk4M4ACjsD7PH3skt8Vnzo
Message-ID: <CA+EHjTxHwbpWRP8mxD0A2Sw+iicYfTjugHukCoi56KkdrbY6kg@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to gmem_make_shared()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Thu, 23 Jul 2026 at 22:08, Sean Christopherson <seanjc@google.com> wrote:
>
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

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
>  arch/x86/include/asm/kvm_host.h    | 4 +++-
>  arch/x86/kvm/svm/sev.c             | 2 +-
>  arch/x86/kvm/svm/svm.c             | 2 +-
>  arch/x86/kvm/svm/svm.h             | 2 +-
>  arch/x86/kvm/x86.c                 | 2 +-
>  6 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 736129db272a..210cb95d0a0b 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -149,7 +149,9 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  #endif
> -KVM_X86_OP_OPTIONAL(gmem_invalidate)
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
>         int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>  #endif
> -       void (*gmem_invalidate)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> +       void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
> +#endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>         void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>  #endif
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index e6987351dc04..4aa8330d5b2d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5161,7 +5161,7 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
>         return 0;
>  }
>
> -void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
> +void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>  {
>         kvm_pfn_t end = pfn + nr_pages;
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 91286d46d13a..b8c9967dd0de 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5439,7 +5439,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>         .vm_move_enc_context_from = sev_vm_move_enc_context_from,
>
>         .gmem_prepare = sev_gmem_prepare,
> -       .gmem_invalidate = sev_gmem_invalidate,
> +       .gmem_make_shared = sev_gmem_make_shared,
>         .gmem_invalidate_range = sev_gmem_invalidate_range,
>         .gmem_max_mapping_level = sev_gmem_max_mapping_level,
>  #endif
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index cf8fb3d6a100..b2acb5ab7c26 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1010,7 +1010,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> -void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
> +void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>  void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 71c1f3e9044e..249267ed2a9d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10629,7 +10629,7 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>  void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>  {
> -       kvm_x86_call(gmem_invalidate)(pfn, nr_pages);
> +       kvm_x86_call(gmem_make_shared)(pfn, nr_pages);
>  }
>  #endif
>
> --
> 2.55.0.229.g6434b31f56-goog
>
