Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA23BFACA;
	Thu, 16 Jul 2026 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196287; cv=none; b=FuMksDWvmXkL/Nv9x7pYj/jixrunIYHKbsEVdCmNeVLB8TUlnvGWV2ScEtn5yToguG8eRgM/bDEvLgOH/f8O53+5FF5hZWKnaszgYH/sd2IaR9MWCFvRR76Vvg6Wr0CLK2+b7bCirSycw2j9ibh37zHuubA4UaDJa/0+yacdUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196287; c=relaxed/simple;
	bh=ce/RRqUddOgw7zkNrkSmqdOltk3lABI9Oq+oRLglth8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W64I1eDJa5zHrg7CZqXaQRa4ZH3TWG8OfOtSavbeAhdOGyzLN8rF7SMqDskZqmBgw8HSM7PxL+CmAqXoZXddcUG+TBMfga36mwG5J7hEV30dT8/BxwottTaV+isU1dHh9Kqara6vaTym5XdKG1gMb7a7M/uhtEkrWYg2fUtOIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYSXSidT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYSXSidT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784196287; x=1815732287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ce/RRqUddOgw7zkNrkSmqdOltk3lABI9Oq+oRLglth8=;
  b=SYSXSidT+BTFfsKriPp24oxXUIl4I1fz1PytMpPqY7O2ECzv8ixF2muf
   iybgm7aXscSoEtT8zT3A80OiIIMRBtmMZgDrKdAeKzcx+Fn0Qp2dyF8m9
   TfklWrooMu1fZDXTHj11Eut7ZCJxyopJTTBHVzRTnFU9lnNlfTSsBFP/c
   //DP2+EReLzCPJLLvkDCcYiHNL9MCPA0DgDm0nvZv1SzAn4SzVDaI8stk
   9VrRlI4/tZ71igSxy63OgGVSnR1wtETeaLcvXZ/YMPYnmCg+9oCheKDug
   56IX46TRgTM0efr9NzamZ6rpY6f4ARjV7aEyF0VEU93+rHUfoCESTrW9n
   Q==;
X-CSE-ConnectionGUID: ZPwem7ieQ7SIiZqUalCZ7A==
X-CSE-MsgGUID: 8wPrkAfcT4yDYcumQsI6tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96365518"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96365518"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:04:46 -0700
X-CSE-ConnectionGUID: xHqs0uEPQaGplfbjiSVJcg==
X-CSE-MsgGUID: xJ5ZSSxuQraz6pm38KQemQ==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:04:43 -0700
Message-ID: <e873559c-5533-4c7b-82e3-3c457b6e7cd1@intel.com>
Date: Thu, 16 Jul 2026 18:04:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] KVM: guest_memfd: Rename invalidate() arch hook to
 reclaim() and isolate it
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260714231015.3337831-1-seanjc@google.com>
 <20260714231015.3337831-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260714231015.3337831-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2026 7:10 AM, Sean Christopherson wrote:
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
> ---
>   arch/x86/kvm/Kconfig     | 1 +
>   arch/x86/kvm/x86.c       | 7 +++++--
>   include/linux/kvm_host.h | 5 ++++-
>   virt/kvm/Kconfig         | 4 ++++
>   virt/kvm/guest_memfd.c   | 8 ++++----
>   5 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 801bf9e520db..e0e7ad015839 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -161,6 +161,7 @@ config KVM_AMD_SEV
>   	select ARCH_HAS_CC_PLATFORM
>   	select KVM_GENERIC_MEMORY_ATTRIBUTES
>   	select HAVE_KVM_ARCH_GMEM_PREPARE
> +	select HAVE_KVM_ARCH_GMEM_RECLAIM
>   	select HAVE_KVM_ARCH_GMEM_INVALIDATE
>   	select HAVE_KVM_ARCH_GMEM_POPULATE
>   	help
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a2cbf6fae118..08d24c6fffa4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10626,11 +10626,14 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>   }
>   #endif
>   
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> +void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)

The kvm_pfn_t for nr_pages still catches my eye, but it's not the 
business of this patch.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
