Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FEF3090CD;
	Thu,  2 Jul 2026 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959566; cv=none; b=IL+gkZNOYzKTTfiys/Ne4yq6jAeHOXJcCRT3nF8mPXK3qAGLmFg0tztVFZbXSn2mdOh8x3wfp1EIeo/jQAH0CjqvZBEFZOgiRdkB6i0akjkF2gZy0+dHpjtsq1Fkw7jJZlivZD4Kf63y4uQ7N06t79NSQJ0h6Skw/nls6iLULY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959566; c=relaxed/simple;
	bh=pIJ4GSadd5hirF0PGVlIyIEqHrXJCPyiGKzk6AbiiZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEcTr/+2xbqLpb/hzZ76jxQA43RTeKBuz/kSKhkRANCyQgIiBauff/mQGU3qIgtUV6kD2mOGN+U/FJ+5eI8UXb6z5hy4Tw5uiVXPPL6wo/+N3MjNkymUQCtBLe9Y6TQu4aZA89cCk8AJZ2tV5h74ve15UIvHpEAr4+1/EFiWc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlK0wwts; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlK0wwts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782959564; x=1814495564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pIJ4GSadd5hirF0PGVlIyIEqHrXJCPyiGKzk6AbiiZg=;
  b=AlK0wwtsegvtS5yxsGK2i85gEqv9jrxZXli1lPs5S/PK7kYDW8zuMmBd
   BBxAyxTFsrbJHKishtcRKw8x9XGv5sVcDfcn9gSitHI1qLu+dJkTGXm0V
   jpkicFAjxfgd7fhCq9/rC0LRORWIEtKI8OHQM+xlYrQ3C/NLKpSc2l+Nm
   Opz3aSMQXYIwvVO6TAWDU+HTbTI1O+yoQRpKhnqM3IN6NeF4mFbF2es+y
   UD/n7x0TXXmpw2xsVXiAmAiTLsd8koifi0BPVgJyDbnJ6eAmb2giSTTW6
   tsyHlUdgytvIE/fwkht8JCLnbIkw5zmUITqdYAbnMq4kSYODcGrbN8LEQ
   Q==;
X-CSE-ConnectionGUID: EWi9H7/TTnuqhT1/mpEqVw==
X-CSE-MsgGUID: hpIeKnvDSkmSBzOhz1FMWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="109249165"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="109249165"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 19:32:43 -0700
X-CSE-ConnectionGUID: NGXxF5KMS+aRrm1qGAyY3A==
X-CSE-MsgGUID: g4gMktRrRsyz6Drb6kEVmg==
X-ExtLoop1: 1
Received: from unknown (HELO [10.239.158.38]) ([10.239.158.38])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 19:32:40 -0700
Message-ID: <80e2cc6d-1d86-467b-bfcf-c43c719f0dcb@intel.com>
Date: Thu, 2 Jul 2026 10:32:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260630213711.479692-1-seanjc@google.com>
 <20260630213711.479692-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260630213711.479692-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/2026 5:37 AM, Sean Christopherson wrote:
> Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
> pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
> consistent between TDX and SNP (for LAUNCH_UPDATE).  EOPNOTSUPP was chosen
> to be a forward-looking error code for when guest_memfd supports in-place
> conversion, but even when in-place conversion comes along, it's an awkward
> error code as KVM is deliberately choosing to disallow virtual address '0',
> which is technically a legal userspace address.  I.e. it's not so much a
> lack of support as it is that KVM reserves address '0' to simplify KVM's
> internal implementation.
> 
> Opportunistically move the check so that it's co-located with the other
> checks on the userspace address, and so that it's more obvious that a NULL
> source address is explicitly disallowed.
> 
> Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/kvm/vmx/tdx.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ffe9d0db58c5..b0ec054732b9 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3198,9 +3198,6 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>   	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>   		return -EIO;
>   
> -	if (!src_page)
> -		return -EOPNOTSUPP;
> -
>   	kvm_tdx->page_add_src = src_page;
>   	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
>   	kvm_tdx->page_add_src = NULL;
> @@ -3247,8 +3244,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
>   	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
>   		return -EFAULT;
>   
> -	if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
> -	    !region.nr_pages ||
> +	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> +	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
>   	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
>   	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
>   	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT) - 1))

