Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB763EEACF;
	Mon, 27 Jul 2026 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145932; cv=none; b=V7xA1xR/ZhGedHN6fRTs/k/BPxd+YEmxEsHwHSDgmKgwmZbLq9jJk3pipbyFp+ocnVq6t3Gkc2U5AFxrwqkiBpI6QdTMM60jcRgFMK3IaZ2h06f2Q32cfeCmPa46h0XEnbRIiiji+BfzsdP905pQQyYNVLjO7wzx7teKX8a36WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145932; c=relaxed/simple;
	bh=lSXdY3uxqJ2DyifYj1oNP27UKmO6OiF1OleiIjgYXeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWpkfZsT5rRYnPt8GDiLJs4ubmjS5uR5+r3DLSA4GSlzaepEbRhSlPT7Bbh4V7NKNz/cNROHu/7f9/y3Y4xUU3deef7as/cfyervNNtUrubR11ciagiIX0OWlAEh4N8bl/VxX5K+4GazwJBxXOGdDtLGBhTPoxJJrFePiF8SAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGQdeQ1L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGQdeQ1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785145929; x=1816681929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lSXdY3uxqJ2DyifYj1oNP27UKmO6OiF1OleiIjgYXeA=;
  b=cGQdeQ1Lgl040+GEldDS1ZjwyKnxvHGw5iQ2cTqI+nKWSVxqXD/9+Iqq
   3D5G2oBBhqcP9LcI5BqWSdH+7ZKmVxNSKf9e690yPCDU8tqqozr2AAcdU
   8crGmRy1Wch3FuynOWeSkAiiGKafn1xxq/m9Exa235HaandxUYHazLv/O
   evrYAjDgTXfLySknYgMHkWlPSn2hfn7f7RYalzkHlwGyRzp+SESoSzncQ
   pwQb46nop5z4BeXMIlnYlI3XTdDhiwbIB/4aaXO/M+Ncx0/wcSR524Mx1
   06lg0GioQovPOuDwdqj1+EHCpjAVUpKZGv6Z80w2wAJ+XwY0ujeFztU11
   Q==;
X-CSE-ConnectionGUID: JsrHORlpSuyZA9dP9u2QhA==
X-CSE-MsgGUID: bLLQC61dQYak6Un+Z3OSaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103121995"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="103121995"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:52:04 -0700
X-CSE-ConnectionGUID: ripdlDjITuGWf6+dAsfeUg==
X-CSE-MsgGUID: 2Npk8i5bQbCgYsK9CYnLFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260012677"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:52:02 -0700
Message-ID: <627eda4b-c084-4cd8-ad3a-3b3793feae0d@intel.com>
Date: Mon, 27 Jul 2026 17:51:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] KVM: guest_memfd: Rename prepare() hook and
 Kconfig to make_private() / CONVERT
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>,
 Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
References: <20260723210811.72720-1-seanjc@google.com>
 <20260723210811.72720-8-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260723210811.72720-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2026 5:08 AM, Sean Christopherson wrote:
> Rework guest_memfd's prepare() hook into a more accurate make_private(),
> and rework its Kconfig from PREPARE to a more generic CONVERT.  

> This will
> allow x86 to share (pun intended) a kvm_x86_ops.gmem_make_shared() hook
> between the "convert to shared" and "reclaim" flows, which are one and the
> same for SNP.

Does it mean in the future we will introduce something like below?

#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t 
pfn, int max_order)
{
	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
}

+int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
+{
+	return kvm_x86_call(gmem_make_private)(pfn, nr_pages);
+}
#endif


> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/include/asm/kvm-x86-ops.h | 4 ++--
>   arch/x86/include/asm/kvm_host.h    | 4 ++--
>   arch/x86/kvm/Kconfig               | 2 +-
>   arch/x86/kvm/svm/sev.c             | 2 +-
>   arch/x86/kvm/svm/svm.c             | 2 +-
>   arch/x86/kvm/svm/svm.h             | 2 +-
>   arch/x86/kvm/x86.c                 | 6 +++---
>   include/linux/kvm_host.h           | 5 +++--
>   virt/kvm/Kconfig                   | 2 +-
>   virt/kvm/guest_memfd.c             | 4 ++--
>   10 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 210cb95d0a0b..a4d872ddef9d 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -146,8 +146,8 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
>   KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>   KVM_X86_OP_OPTIONAL(get_untagged_addr)
>   KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +KVM_X86_OP_OPTIONAL_RET0(gmem_make_private)
>   #endif
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>   KVM_X86_OP_OPTIONAL(gmem_make_shared)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4dc8a03c829a..4be57157136b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1724,8 +1724,8 @@ struct kvm_x86_ops {
>   
>   	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>   	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +	int (*gmem_make_private)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>   #endif
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>   	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index e0e7ad015839..538ed1e80332 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -160,7 +160,7 @@ config KVM_AMD_SEV
>   	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>   	select ARCH_HAS_CC_PLATFORM
>   	select KVM_GENERIC_MEMORY_ATTRIBUTES
> -	select HAVE_KVM_ARCH_GMEM_PREPARE
> +	select HAVE_KVM_ARCH_GMEM_CONVERT
>   	select HAVE_KVM_ARCH_GMEM_RECLAIM
>   	select HAVE_KVM_ARCH_GMEM_INVALIDATE
>   	select HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4aa8330d5b2d..0ecba768c153 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5114,7 +5114,7 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
>   	return false;
>   }
>   
> -int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
> +int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
>   {
>   	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
>   	kvm_pfn_t pfn_aligned;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index b8c9967dd0de..d5a08f1db84b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5438,7 +5438,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>   	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
>   	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
>   
> -	.gmem_prepare = sev_gmem_prepare,
> +	.gmem_make_private = sev_gmem_make_private,
>   	.gmem_make_shared = sev_gmem_make_shared,
>   	.gmem_invalidate_range = sev_gmem_invalidate_range,
>   	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index b2acb5ab7c26..ad849edcacc7 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1009,7 +1009,7 @@ int sev_cpu_init(struct svm_cpu_data *sd);
>   int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>   extern unsigned int max_sev_asid;
>   void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
> -int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>   void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>   void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>   int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 249267ed2a9d..e7865b28d37b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10619,10 +10619,10 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>   	return !kvm_arch_has_private_mem(kvm);
>   }
>   
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
>   {
> -	return kvm_x86_call(gmem_prepare)(kvm, pfn, gfn, max_order);
> +	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
>   }
>   #endif
>   
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0b5b9cb022ba..9cf01429281b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2579,8 +2579,9 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>   }
>   #endif /* CONFIG_KVM_GUEST_MEMFD */
>   
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> -int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> +int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +			       int max_order);
>   #endif
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 617876993225..c3c0ee253fc7 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -107,7 +107,7 @@ config KVM_GUEST_MEMFD
>          select XARRAY_MULTI
>          bool
>   
> -config HAVE_KVM_ARCH_GMEM_PREPARE
> +config HAVE_KVM_ARCH_GMEM_CONVERT
>          bool
>          depends on KVM_GUEST_MEMFD
>   
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f64cd87ec8b0..466f611ad4b7 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -73,11 +73,11 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
>   static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>   				    pgoff_t index, struct folio *folio)
>   {
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>   	kvm_pfn_t pfn = folio_file_pfn(folio, index);
>   	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
>   
> -	return kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
> +	return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_order(folio));
>   #else
>   	return 0;
>   #endif

