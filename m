Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCA43603EF;
	Mon, 27 Jul 2026 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146358; cv=none; b=bEzDq97qEiInD/+WLgyajI9sHKh0XCVb49q/QGdnOy6cmZYuKu+s6/j9FNnvufD/+C9U1ULjHa6iOnH0BM/gTMHhbzm2l6XOisH2OE34pRe1p/4GUdxy4LJqZmM5UxHuVlEvbuqId7c8Z81Yy9q6qAX3anbRhEPdWBq2TTsfF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146358; c=relaxed/simple;
	bh=s4ZX8G5ffJDZ2BHUWtggHuMFJCFa58hAWbdwTq2dB6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd1fPgY2HPlKOD+R+TvVMkNN+Ea7OQfzW9cw0SUEFQKRE1CC0m+sGFQzkjoQDsywgPgwYp3muE0BbXVEJsuHga1G3Jl3VMQk7ZnfzGv7pJAGqKB39ulX3BrXIAeG1xZzlu+2mmMORqwnbv9IM3gceFISZ4estpeEZYc9bjmLJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPKSx9yL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPKSx9yL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785146356; x=1816682356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s4ZX8G5ffJDZ2BHUWtggHuMFJCFa58hAWbdwTq2dB6A=;
  b=OPKSx9yLvUlyZrbrJakBuvq9HxtFs/yvOlgWCmQ6I1M33XzWsyQ+u2l7
   gq/vlUIDL8MuxBOpkKsYm0pNVlqPNoSbrDdsBdXoreQhWVh3V9pYj1Sae
   dzD1GixWXjApGwNkrKwFl+Ic0/C1ECOPVWLeaI0AyI7BnpNDo2GK6YGgw
   zNTuYFxN+eaQWQtID5HjcVRFZwgZ2DyZTYS+VxoVRCdnuKxzz0o72C/Mf
   seGM6civmQAlEnPRJU85P6jJgctLvtrXb5xqwgtSQ1XQbI/jXUsjES2L5
   R9/+VzI/OMbW7/G/xxbcVYGBqhLlnEy8W2Fna4G9fpGnasfTLef+2HJCG
   g==;
X-CSE-ConnectionGUID: N7OCEQKzTlu1atLTQymEsQ==
X-CSE-MsgGUID: KAH738mWTAeiznRSZUMeMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103122402"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="103122402"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:59:16 -0700
X-CSE-ConnectionGUID: xEq+1seuQfaKHsVJ9Fbl9Q==
X-CSE-MsgGUID: DA8s/r6xT6mClbOipl8APQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260014714"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:59:14 -0700
Message-ID: <927f1c20-440a-42cf-b26f-c0fa8280e068@intel.com>
Date: Mon, 27 Jul 2026 17:59:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] KVM: guest_memfd: Explicitly pass number of pages
 to make_private() hook
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>,
 Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
References: <20260723210811.72720-1-seanjc@google.com>
 <20260723210811.72720-9-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260723210811.72720-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2026 5:08 AM, Sean Christopherson wrote:
> Tweak the guest_memfd make_private() hook to explicitly pass the number of
> pages to align with the signature of the make_shared() hook, and because
> the existing code is outright broken if a guest_memfd folio is comprised of
> more than one page (which can't happen, yet).  The SNP code *tries* to
> create a corresponding huge entry, but if the RMP must use 4KiB entries for
> whatever reason, KVM will only convert the first pfn, and not the entire
> range of pfns that will be mapped into the guest.
> 
> Alternatively, @max_order could simply be repurposed as _the_ @order, but
> that will fall apart when in-place conversion comes along, at which point
> KVM will need to deal with conversions that aren't bound 1:1 to a folio.
> I.e. the number of pages to convert may not be exactly be a power-of-2 (and

one redundant 'be'

> folios don't strictly guarantee power-of-2 pages anyways).
> 
> WARN in the SNP code if the number of pages to prepare is anything other
> than '1', i.e. if guest_memfd is trying to prepare/convert more than a
> single 4KiB page, as sev_gmem_prepare() doesn't actually handle conversion
> greater than order-0 folios.
> 
> Opportunistically swap the ordering of @pfn and @gfn params for
> kvm_x86_ops.gmem_make_private() to match kvm_arch_gmem_make_private().
> 
> Fixes: b85524314a3d ("KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is passed to the guest")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/include/asm/kvm_host.h |  3 ++-
>   arch/x86/kvm/svm/sev.c          | 27 +++++++++++----------------
>   arch/x86/kvm/svm/svm.h          |  2 +-
>   arch/x86/kvm/x86.c              |  5 +++--
>   include/linux/kvm_host.h        |  2 +-
>   virt/kvm/guest_memfd.c          |  2 +-
>   6 files changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4be57157136b..230267b2203b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1725,7 +1725,8 @@ struct kvm_x86_ops {
>   	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
>   	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> -	int (*gmem_make_private)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +	int (*gmem_make_private)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +				 kvm_pfn_t nr_pages);
>   #endif
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>   	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0ecba768c153..bf7f94d1d7f9 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5090,15 +5090,7 @@ static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)
>   	return true;
>   }
>   
> -static u8 max_level_for_order(int order)
> -{
> -	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> -		return PG_LEVEL_2M;
> -
> -	return PG_LEVEL_4K;
> -}
> -
> -static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
> +static bool is_large_rmp_possible(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>   {
>   	kvm_pfn_t pfn_aligned = ALIGN_DOWN(pfn, PTRS_PER_PMD);
>   
> @@ -5107,14 +5099,14 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
>   	 * PFN is currently shared, then the entire 2M-aligned range can be
>   	 * set to private via a single 2M RMP entry.
>   	 */
> -	if (max_level_for_order(order) > PG_LEVEL_4K &&
> +	if (nr_pages >= KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) &&
>   	    is_pfn_range_shared(pfn_aligned, pfn_aligned + PTRS_PER_PMD))
>   		return true;
>   
>   	return false;
>   }
>   
> -int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
> +int sev_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>   {
>   	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
>   	kvm_pfn_t pfn_aligned;
> @@ -5125,6 +5117,9 @@ int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_ord
>   	if (!sev_snp_guest(kvm))
>   		return 0;
>   
> +	if (WARN_ON_ONCE(nr_pages != 1))
> +		return -EIO;
> +
>   	rc = snp_lookup_rmpentry(pfn, &assigned, &level);
>   	if (rc) {
>   		pr_err_ratelimited("SEV: Failed to look up RMP entry: GFN %llx PFN %llx error %d\n",
> @@ -5133,12 +5128,12 @@ int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_ord
>   	}
>   
>   	if (assigned) {
> -		pr_debug("%s: already assigned: gfn %llx pfn %llx max_order %d level %d\n",
> -			 __func__, gfn, pfn, max_order, level);
> +		pr_debug("%s: already assigned: gfn %llx pfn %llx nr_pages %llx level %d\n",
> +			 __func__, gfn, pfn, nr_pages, level);
>   		return 0;
>   	}
>   
> -	if (is_large_rmp_possible(kvm, pfn, max_order)) {
> +	if (is_large_rmp_possible(pfn, nr_pages)) {
>   		level = PG_LEVEL_2M;
>   		pfn_aligned = ALIGN_DOWN(pfn, PTRS_PER_PMD);
>   		gfn_aligned = ALIGN_DOWN(gfn, PTRS_PER_PMD);
> @@ -5155,8 +5150,8 @@ int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_ord
>   		return -EINVAL;
>   	}
>   
> -	pr_debug("%s: updated: gfn %llx pfn %llx pfn_aligned %llx max_order %d level %d\n",
> -		 __func__, gfn, pfn, pfn_aligned, max_order, level);
> +	pr_debug("%s: updated: gfn %llx pfn %llx pfn_aligned %llx nr_pages %llx level %d\n",
> +		 __func__, gfn, pfn, pfn_aligned, nr_pages, level);
>   
>   	return 0;
>   }
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index ad849edcacc7..a327bf751ecd 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1009,7 +1009,7 @@ int sev_cpu_init(struct svm_cpu_data *sd);
>   int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>   extern unsigned int max_sev_asid;
>   void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
> -int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +int sev_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>   void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
>   void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>   int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e7865b28d37b..511830d1b6f3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10620,9 +10620,10 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>   }
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> -int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
> +int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +			       kvm_pfn_t nr_pages)
>   {
> -	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
> +	return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages);
>   }
>   #endif
>   
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9cf01429281b..97cedf8b89c5 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2581,7 +2581,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>   int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> -			       int max_order);
> +			       kvm_pfn_t nr_pages);
>   #endif
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 466f611ad4b7..255860c472ee 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -77,7 +77,7 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>   	kvm_pfn_t pfn = folio_file_pfn(folio, index);
>   	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
>   
> -	return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_order(folio));
> +	return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_nr_pages(folio));
>   #else
>   	return 0;
>   #endif

