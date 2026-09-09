Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F099566C42;
	Wed,  9 Sep 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962945; cv=none; b=r9+tpx/6Q+bMOd5gzR0bOIAbRzLwVVXDOM5xxAmTs6frGzlVlbrx26unfCNk0LVDTB1+EEFnsdAJqjLBLrhaie/fnlKbAqi1YvMGq2x+v8MV6MSRUr59N3BxNodo2Wys6ofpMdSGes9uifacsXFh8ei7hNJA238mOhtqsFPJcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962945; c=relaxed/simple;
	bh=P3EfSrpuAdYfCz60uI/5joMJf29OS8uCpi4UP3UQYXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWuLVU6YMSvnCDYku7wwYtV5b7uOWFn5zJ+2fI91YtuAk3g11v9hy4dEvlQd0oTGVGPx01SEbxkV3MxkE1uxfv8XjqeRapxlFy2Us+MttYBOnbI5J5RX4u7ADMAAH1TEQQ5t+Di8+EZkfPyBPKhqiPGdr4yB8uJy7JaRL057K0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFQSIBtr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFQSIBtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788962945; x=1820498945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P3EfSrpuAdYfCz60uI/5joMJf29OS8uCpi4UP3UQYXk=;
  b=GFQSIBtrWOL8e1Lkdo9k2d12HUm8X/EXsBLcGIu/aZlxdEN0s/2carxB
   awXYQJiSGJyZYqnAGDa0+WqqfwPhz91OQp7OGCIy6Niy3u077JGzsqqjs
   d8yt3vu1E4qYkipn2MEqWgraBiSYVn1gywcfY135H+UOnkB6+qXlv/4d6
   b3Cy3C4CSBjXEDYLdYhpSrXUC/myjQDvuK9YlR743oG9FPYp03lYT66X6
   /2dpecPZYcleN/p19KjYMMLD8BOTdSLs8o1Cc2NlSVMidyjyopx+NZtQg
   3mMJbDOI/EK3a5G2mZUOmBtg74MTQsXBJzmWO+9t7NxsGl//qLdsZyZRS
   w==;
X-CSE-ConnectionGUID: BzFBkH+xRF2vAxVfeYdHww==
X-CSE-MsgGUID: /XfDsCy+RRyViWB2kbA6yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93083011"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="93083011"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:08:52 -0700
X-CSE-ConnectionGUID: r4WLywhwSs+kYXhZGw3FPA==
X-CSE-MsgGUID: DsJDVKgmRdWDHpKT7+9YQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="276556725"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:08:49 -0700
Message-ID: <1e311e04-6632-40f8-b73e-69773b9201aa@intel.com>
Date: Wed, 9 Sep 2026 22:08:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: x86/mmu: Use KVM's max TDP level to determine
 need for 32-bit TDP root
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang
 <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20260902230932.2760127-1-seanjc@google.com>
 <20260902230932.2760127-2-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260902230932.2760127-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 7:09 AM, Sean Christopherson wrote:
> When checking to see if KVM needs to allocate a TDP PAE root that's 32-bit
> addressable, query KVM's overall max TDP level, not the vCPU-specific TDP
> level, as the logic is specific to using NPT on 32-bit hosts.  Querying the
> vCPU's alleged TDP level is flawed and confusing, as KVM selects between
> 4-level vs. 5-level based on the guest's MAXPHYADDR, and MAXPHYADDR isn't
> yet configured (via CPUID) when the vCPU is being created.
> 
> I.e. as is, it would *appear* that KVM is violating its own rules with
> respect to changing guest CPUID (see kvm_mmu_after_set_cpuid()).  In
> practice, the flaw is benign as the goal is purely to see if KVM needs to
> use PAE-paging; whether KVM will use 4-level vs. 5-level is irrelevant.
> 
> More importantly, avoiding kvm_mmu_get_tdp_level() during vCPU creation
> will allow hardening KVM's handling of S-EPT mirror root level.
> 
> For all intents and purposes, no functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b926..c9a684151420 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6834,7 +6834,7 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, struct k
>  	 * other exception is for shadowing L1's 32-bit or PAE NPT on 64-bit
>  	 * KVM; that horror is handled on-demand by mmu_alloc_special_roots().
>  	 */
> -	if (tdp_enabled && kvm_mmu_get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
> +	if (tdp_enabled && kvm_mmu_get_max_tdp_level() > PT32E_ROOT_LEVEL)
>  		return 0;
>  
>  	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_DMA32);

