Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB93CC7DF;
	Thu, 16 Jul 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196329; cv=none; b=MABSGxsVxX+j4KJn4agCvV49zJG/2aQTWqTiMjW081/F/TtA1keSBUt1BivbFvHXRuHzdV4Hdoa5QZAERc1c1PVVrIeMY18z29q6wmcxR+KaBSenn7tDn7SV36U4gYGEqxnLjoyazFINfLx7D18LIo27DcVX4JkSGJmYMu6FpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196329; c=relaxed/simple;
	bh=v2BPZwnXmF22RXL/VjHtWzCyXdlbktgx6fL2lw//kkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t59yvcDWitkMjjswn55raRKjvgVnOAdH024G+fLDQ1RMdRzxxG5BhaDWGPbcN/gdhajmeSvsXVAfHSZlA1HoWD3vpcib2eWp8jx5clHGR8qanY4Mp2ia/AtZRzEsFEw+eSZSDwkKwyYVW5OeBRyc795uX37dbv+uB0iiM9wfiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUossjHW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUossjHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784196329; x=1815732329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v2BPZwnXmF22RXL/VjHtWzCyXdlbktgx6fL2lw//kkg=;
  b=RUossjHW1KwgH/vswx7JYqiZPXRYoZoEms/N0Qzs/SRUxBxcvEuugvGu
   yZ1DinB+iDVTX7gVbF+moqAAjAA5Q/YKHhtKCOBUfnHIudp507lqX7iZ5
   Z4pOngdWYAK4mxN2FrUaHD7nCmTu4Bbs4IF8qcF+Nd4jus6y5VwtGDnmW
   gearvbQw9oFBrWLRxSbGaoI4Ldz9MvwLqSyUS9rZdAgcNL+aDEqBqWQ8j
   U9XuoE2oCtkTjwoGMR0pwck8zNy+8Uj8GBtoSYokjGj74UGFP4lqxC8Km
   OCJw7FmZKLaqYRlYBgoWuoQMS6HPwX2FbuISn8frrFZpvHBFjxAA7/4zP
   g==;
X-CSE-ConnectionGUID: 4nAS+QYzQ7eYI1MgtSYfww==
X-CSE-MsgGUID: akCPKJIKSXK3sBMQ0SkGOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96365601"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96365601"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:05:24 -0700
X-CSE-ConnectionGUID: 0z+HCuetQzOxu4lyctjEFQ==
X-CSE-MsgGUID: N+V5ncrZSV20XqFdhJRcGA==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:05:20 -0700
Message-ID: <87a7acb9-8a00-409f-86d3-b15c28f41a4c@intel.com>
Date: Thu, 16 Jul 2026 18:05:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] KVM: guest_memfd: Drop the redundant printk on
 arch gmem_prepare() failure
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260714231015.3337831-1-seanjc@google.com>
 <20260714231015.3337831-4-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260714231015.3337831-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2026 7:10 AM, Sean Christopherson wrote:
> Drop guest_memfd's ratelimited printk to log "preparation" failures, as KVM
> SNP alreads logs more precise messages in all error paths, and whether or
> not failure to convert the pfn to private is "unexpected", i.e. warrants
> logging, is firmly an architecture specific detail.
> 
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   virt/kvm/guest_memfd.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d5d227476cda..62c2c157f0c1 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -66,15 +66,11 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
>   	kvm_pfn_t pfn = folio_file_pfn(folio, index);
>   	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
> -	int rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
> -	if (rc) {
> -		pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
> -				    index, gfn, pfn, rc);
> -		return rc;
> -	}
> -#endif
>   
> +	return kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
> +#else
>   	return 0;
> +#endif
>   }
>   
>   /*

