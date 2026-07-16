Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB036DA0D;
	Thu, 16 Jul 2026 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185753; cv=none; b=snf0RZiWR0D5NX7U6MsyTE7FVVX8AYMNHwpWuDHIta0UGpp7XNiAfPzcBijmm0gaMnZ88x4Lf9N7R+Qo5/EgjqeL223ceOHVhgUYeffrGDL0UX5ok5kfisJDmC8m9DhMIqWWX3KEwSce2cz9fF5mSk32hCPEr2xG9dfzJVxEAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185753; c=relaxed/simple;
	bh=0MQYMuSV7ey4CUrrdinJnEBdkedGJTI0uAiiHSV7qk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IC7rN12U9QZe1pI1UEBOSpAGUbfDljXuVoflI8PIA9QBbsy60EGsTprLJtw+Y7hCBD3hh4CxBCSN8kyYn3DUoAbNqfOPvhYR2Zf0MK3FBlHRhYWejOVbM9q+yC78So2KWFeYJVsNFcIU4kH/eyjVTY0xVK78WlsW0rjEyZnR4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LapOqcoq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LapOqcoq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784185752; x=1815721752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0MQYMuSV7ey4CUrrdinJnEBdkedGJTI0uAiiHSV7qk0=;
  b=LapOqcoqdmbwxMZj4ItlHjIyLixRiGNSkfH7+AeVB0c9aKADtQpWzgh6
   SMTebVARvr0q3GBdfvffV2Vt0IupgBr4PBWaBFMLIFvfIPcBfZMINp/kh
   PONkEHBxvDuTyXfIETSJNoulp/gRQpqPxqsEXFOYIZsZ6NGSNDSv7/tFi
   EyV15mwa+mte3CgMNjYk1vv7ncTIu3KeoIkiy5AqJyIKDQ1IGRzHCfZsc
   hMcZoDvjKFJic+W8WjswtFYQbDx6NKtcSFgJWbgF4xnnFNqiKq9Hu3h9l
   bB+lvC9VEJkEmW5I/wrI4QbLCvrVraMXrfuBwU298GVVCSefGWdaCeMNG
   g==;
X-CSE-ConnectionGUID: udavNQb+SzK8eijWmyNJoQ==
X-CSE-MsgGUID: gKHJicqQTPCFKYPUasYZUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96202906"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96202906"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 00:09:11 -0700
X-CSE-ConnectionGUID: zrHJbmTbQeuRnZ2fUpyMSQ==
X-CSE-MsgGUID: VBqviI8hQx2bTcFI8TJXhA==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 00:09:09 -0700
Message-ID: <56ff8019-f30c-4fb9-a3b9-b81dcb98eb96@intel.com>
Date: Thu, 16 Jul 2026 15:09:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] KVM: guest_memfd: Plumb the number of pages and
 max order into .invalidate()
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260714231015.3337831-1-seanjc@google.com>
 <20260714231015.3337831-2-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260714231015.3337831-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2026 7:10 AM, Sean Christopherson wrote:
> Plumb the number of pages to "invalidate", i.e. reclaim, along with the max
> order with which the pages can be mapped.  This will allow x86 to combine
> its vendor-specific implementations for conversion and reclaim, a.k.a.
> preparation and invalidation, into a single hook.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c       | 4 ++--
>   include/linux/kvm_host.h | 2 +-
>   virt/kvm/guest_memfd.c   | 7 ++-----
>   3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1f5dc685f049..a2cbf6fae118 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10627,9 +10627,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>   #endif
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)

why use 'kvm_pfn_t' as the type for nr_pages instead of 'unsigned long'?

(I guess just because you kept the original type for @end)


