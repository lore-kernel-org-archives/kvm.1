Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566442;
	b=zcNlysjlp047u/Qy/r9DH3m3Oo/C+R3L3m5EDgc5yzG3us5I7Q1KLhNdTsPqiADn9JIA
	 T+RXhdKHhdUfzSkTn+Gp9DLrFhPLPxmMQnwTTJxBbfbaqfZtzE+ncTf7RzkSSzkc5aEu4
	 4z//sIDaHd70KQ2NUA8SiRpqetg2iC8YC912xT+IyuRtByrii4p8BzBhb8tvWL9aDcrLU
	 aJhFTcdLUpAHSN015j1HFl6f7XccXYIhqYEibJpNF34EwLTdG29M2TooSI9HWNmQ9ADnU
	 g+5aaFb+jib8l7vzAHvhsBAd5RmTaaKmTbYCKMLfJh2GAvcEtitRco7TWaC7cWVDbpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566442;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=h7OwuuzEGK0GsNEjfvtNjCAItG3is7gkcrr8kxucvR8=;
	b=Jc1GmcqpTzj4kg41FChOrXab9MG3bMbMw0rWhuHlgbl0LnCdVIJh+vfg/MJ3U7CmxQyY
	 4oWVOywVKZJSFAh5jZzL59r9+BiJ7D2LiIBmOd6cq/8wSab9/lB2xabpRsw552V5sHF0B
	 7m2SaI/v3Nc/tuBDbUF2ZIyFd9u+UK5+DpmCjIPtZ7Rk/cyPtL+GBXhnNXAxOr1kUbIt9
	 G7PZslXWu1iweDIZG5hRYSb1vr6zX1992293dL80EuaZSzxVi+w4Ey+kXxILTeTgjNTkg
	 zNP9itqhnM/4VMj8qNxHGKTlms/kG+YxzRhHDJs93q0OJ7V7OlyZyFrqt96lyKw+kGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVs7QFj8;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE4606A319;
	Wed, 21 Oct 2026 07:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44BE4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVs7QFj8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792566442; x=1824102442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=33sFa1VVCxqh6L2mZz6k1cwCn073Z6lg/9bmMIT8aoc=;
  b=cVs7QFj8H6siUQmQjDZqkMY73n9uHksjT9XEocF+IVV5AI+WHx5EaPZd
   3jle88CJfCCqS1FYLmvhK9+7H/kXKCBy29qrJYrQeKsKQ7LVWg3/uD6kT
   PtJfxuFGe6+eVry28GlZEYNDpsHMISdXcUtyn49Qb4/51PPTlxZ8fdm9B
   0agFigqefz2gXMYjN+eQ1mkuO8PCZEDFzjb2v21Q5FadK6OeLsr5Q7xNl
   HFhfa5VpirWgmvpLKecZRQFlIpXvcNGp8W6eI0BepmnA4g7YYYigpK05c
   GbzsmaF0t+URFyNy0tkz7AVLWFUajProAqX8mmodVzYwJwM59kg1b8d1r
   w==;
X-CSE-ConnectionGUID: h5mVjIcaQcSllTX9X+f5ew==
X-CSE-MsgGUID: wP35dnqoRN+IESh3C6jrKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1182780"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1182780"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 00:07:21 -0700
X-CSE-ConnectionGUID: NjK7ub33SvWge1oxIDmOhA==
X-CSE-MsgGUID: JXCp1o9tScesjjNKW286gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3416821"
Received: from unknown (HELO [10.238.0.97]) ([10.238.0.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 00:07:18 -0700
Message-ID: <4217cec4-2988-41a9-b6de-cce0708ec830@intel.com>
Date: Wed, 21 Oct 2026 15:07:16 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: always make in-place conversion a compile-time
 constant when possible
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Shivank Garg <shivankg@amd.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
References: <20261020131447.122096-1-pbonzini@redhat.com>
 <20261020131447.122096-4-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261020131447.122096-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/2026 9:14 PM, Paolo Bonzini wrote:
> Remove the unnecessary static call indirection and make
> gmem_in_place_conversion a constant if CONFIG_KVM_PRIVATE_MEMATTR_VM
> is false.
> 
> Require that CONFIG_KVM_PRIVATE_MEMATTR_VM is y only if
> kvm_arch_has_private_mem is also defined.  

This reads like the patch is going to make such a requirement. However, it doesn't.

> This way, the three
> possible cases can be expressed without nested #ifs.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>  include/linux/kvm_host.h | 13 +++++--------
>  virt/kvm/kvm_main.c      | 13 +++++++------
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 09c57d31d153..e7fc94e2910a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2585,15 +2585,7 @@ bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
>  #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>  
>  #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
> -static inline bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
> -{
> -	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> -}
> -#endif  /* CONFIG_KVM_PRIVATE_MEMATTR_VM */
> -
> -#ifdef kvm_arch_has_private_mem
>  extern bool gmem_in_place_conversion;
> -
>  typedef bool (kvm_is_private_gfn_t)(struct kvm *kvm, gfn_t gfn);
>  DECLARE_STATIC_CALL(__kvm_is_private_gfn, kvm_is_private_gfn_t);
>  
> @@ -2601,6 +2593,11 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>  {
>  	return static_call(__kvm_is_private_gfn)(kvm, gfn);
>  }
> +
> +#elif defined kvm_arch_has_private_mem
> +#define gmem_in_place_conversion true
> +#define kvm_is_private_gfn kvm_gmem_is_private_gfn
> +
>  #else
>  #define gmem_in_place_conversion false
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 3e35766f5c7e..a356a29be985 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -104,11 +104,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
>  static bool __ro_after_init allow_unsafe_mappings;
>  module_param(allow_unsafe_mappings, bool, 0444);
>  
> -#ifdef kvm_arch_has_private_mem
> -bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_PRIVATE_MEMATTR_VM);
>  #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
> +bool __ro_after_init gmem_in_place_conversion = false;
>  module_param(gmem_in_place_conversion, bool, 0444);
> -#endif
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>  #endif
>  
> @@ -2705,18 +2703,21 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>  
> -#ifdef kvm_arch_has_private_mem
> +#ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
>  DEFINE_STATIC_CALL_RET0(__kvm_is_private_gfn, kvm_is_private_gfn_t);
>  EXPORT_STATIC_CALL_GPL(__kvm_is_private_gfn);
>  
> +static bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
> +{
> +	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +}
> +
>  static void kvm_init_memory_attributes(void)
>  {
>  	if (gmem_in_place_conversion)
>  		static_call_update(__kvm_is_private_gfn, kvm_gmem_is_private_gfn);
> -#ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
>  	else
>  		static_call_update(__kvm_is_private_gfn, kvm_vm_is_private_gfn);
> -#endif
>  }
>  #else
>  static void kvm_init_memory_attributes(void) { }

