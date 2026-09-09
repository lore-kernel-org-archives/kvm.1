Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC3583AAC;
	Wed,  9 Sep 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963388; cv=none; b=RJps9qNcELEg/3uh7Yyl7x4ktuBR+9j4XqSAbNSHhGmq0VS5Sy1+0tz83gO2G4XLgn69BF+Fo9ez0mqUp+RW6CrEqvPi/tFcxwL6V3vWOUrNTqr7RL7C2HsB8iONj5cqwSoXMpuzmz9uQxla63USbLESdBztcL8DPYbCkKxr3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963388; c=relaxed/simple;
	bh=Ajz1rJ5KBJT1yIFYYR2VWa+5UalEnz9sbBhzO/i/5EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLD+MetkW2jd8IXxcE5TZF7/hDX/JQpmhSIyKjYUhJTnzBVk0zFFeXjwrcU+minxho6CzC8o37ZY5dQ9WwEWSmYrNC4a8oYJ29H57W1TIV+FCjZUNV+0cx+OYcq+52b3Ogl2lUEOt2/WvE946dQdlt9PvRhQbkiL3wQxjYkjh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9mVS/hk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9mVS/hk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788963386; x=1820499386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ajz1rJ5KBJT1yIFYYR2VWa+5UalEnz9sbBhzO/i/5EI=;
  b=k9mVS/hk+Av88zZ+eK0b4AHIK5v2hRlUoMHsu0qa12bhk26mmhZ5L2bA
   wSpML87t+LAYtjhI6FAJW+k5tZBmrUYGm8dAcVGqZb76VB3CDT+z+k0F2
   rlLkEC4HRUKQhJ1Zgb9rLlaay+4qfE5cxTip1//YvT7gATw1yOO/D7jCd
   l25QSlhmAKZBRfk7ETrEKlrAYbn9tdbdl3lFSowFYPRX6TgZJ7kjVfmLb
   rVK33aKtAd2/J34MqGSWdn6ga4BfSXNrn7AksfKVX668rGzJl6aDf3M3o
   ExKDtI75vN3HKRLifBgbqAMyCTCgRmcmph6VJO7PM9WUvKrvfK+9qiXn3
   A==;
X-CSE-ConnectionGUID: 7C7ykG/fQQaG3O91jxsVjw==
X-CSE-MsgGUID: 3XuLat8aSd2nXxK6PKm9rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93083954"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="93083954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:16:26 -0700
X-CSE-ConnectionGUID: /TQ4Gg0HQv61WSeSli/eWA==
X-CSE-MsgGUID: Y843hWh1TxmAwZoMh6dxyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="276558245"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:16:23 -0700
Message-ID: <a0a748f2-50fb-4605-9f35-ce534d378361@intel.com>
Date: Wed, 9 Sep 2026 22:16:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] KVM: VMX: Explicitly track TDX VMs' root level
 instead of guessing it from CPUID
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang
 <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20260902230932.2760127-1-seanjc@google.com>
 <20260902230932.2760127-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260902230932.2760127-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 7:09 AM, Sean Christopherson wrote:
> Explicitly track the root level for TDX VMs instead of trying to infer the
> depth of the paging tree based on an individual vCPU's CPUID information.
> Applying KVM's existing logic to select the root level to TDX is flawed as
> nothing *requires* userspace to fill in the correct guest.MAXPHYADDR for a
> vCPU's CPUID.  Guessing at the correct root level is also ridiculous given
> that userspace has already told KVM the root level during TD initialization.
> 
> Relying on userspace to set the expected/correct CPUID lets a misbehaving
> userspace trip the KVM_BUG_ON() in tdx_load_mmu_pgd() by configuring guest
> CPUID to use an "incorrect" guest.MAXPHYADDR.
> 
> Don't use kvm_gfn_direct_bits() to infer the mirror root level, as the
> connection between TDX's one and only "direct" bit and the predetermined
> root level is a TDX implementation detail.  I.e. avoid baking in the
> assumption that there is exactly one "direct bits", that the one bit is a
> pivot between normal and mirror roots, and that the pivot bit is the most
> significant bit of the effective GPA space.  For the same reason, set the
> root level and direct bits in TDX code, i.e. don't provide a helper in the
> MMU, because from the MMU's perspective, they are two separate concepts.
> 
> Keep gfn_direct_bits even though it can be trivially derived from
> mirror_root_level as saving a whole eight bytes per VM is meaningless,
> keeping the TDX details buried in TDX would require a kvm_x86_ops hook, and
> the value is queried fairly often and in hot paths.
> 
> And for the moment, keep the S-bit sanity check in tdx_load_mmu_pgd(), even
> though it really only needs to ensure the incoming level matches the
> preconfigured mirror root level.  Because KVM manually configures the
> S-bit location, there's technically a risk that the S-bit location and
> mirror root level could get out of sync.  That can be addressed by more
> programmatically computing the S-bit, but that doesn't need to be done now.
> 
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Fixes: 20d913729c11 ("KVM: x86/mmu: Taking guest pa into consideration when calculate tdp level")
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> Tested-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
