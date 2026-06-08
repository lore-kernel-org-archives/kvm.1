Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F982EEE9C
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883891; cv=none; b=WdNOyDyCm7KMwfUqtPHKOpIPVQruAyx5hMx2P7jEnIcsATVSjrqG7vNDP+E1LKb/AyHG88pdj9jgoeg8dofOePqGSDNYaTZFABSafS6SNCm3Xni74zIZ0YdJcagTwv/ZamBYzsnrQ+K1C79fOMIu9dNfNdbua7wJJS2H7BtleUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883891; c=relaxed/simple;
	bh=VHbAA4dACbS4J8bQSLCpVkalF+G8TmtZI2xmcKdhOKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNo4jWHYdFSjeAnaZGOrG2TSigzplCUj5FidMHFidFsTyZQ+JpJOSGPHj32az6dgo9/9cAdpHdQ2g1TgmGJtP69cI/7e+Yi6kgGm6qnFLGTQ0qsoj5i/SxKOovFc68mGdxQ+pPQA0a0JEUFlusoi674Vku0KHNQzT24245+Zo38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgVvuhFQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgVvuhFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780883890; x=1812419890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VHbAA4dACbS4J8bQSLCpVkalF+G8TmtZI2xmcKdhOKc=;
  b=DgVvuhFQ9gYqVBw64ZU0LNM4a15Qnmd3QCy+Gh5+p9fniUIvUAcCosLi
   vaPZKMSR78JDhSrzeRDELblFm/LupdveSgJHgW0M3LEIAkXpJTWevJjkg
   TmCRBnzm4j09Mo6kKS9Yh9TjtaMGecQovzgEtVpe90swujjvH3a2MTOhA
   wxCSY+Zp4ewLjMY+fo5dmEbp36+TOOKwHoheB/cEOxeXXj5c91PQsQ7Wz
   e3qc4e8OlYeSlsgW1Y9IrD75zdqydTDHMz3McWRD90mbuCw/TieWnymvF
   kaRI4Vp90QAXyvqhmfIXkinNmmrN+jH9FWesedeUOMgvSKHTb3NxAHoUq
   A==;
X-CSE-ConnectionGUID: Pspjh0IzSkGJ+BJ+W0wtlw==
X-CSE-MsgGUID: DIL+uPaVSYyzOIxuUSYovQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81591058"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81591058"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 18:58:10 -0700
X-CSE-ConnectionGUID: TX6ERq7nREe2M97yLif0MA==
X-CSE-MsgGUID: vwciNGlTSsqXwETIvLLZKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="244293266"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 18:58:08 -0700
Message-ID: <4e5b6b9c-4f7d-4d62-874a-4bcb745e9a47@linux.intel.com>
Date: Mon, 8 Jun 2026 09:58:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being
 applied to wrong sub-leaf
To: pbonzini@redhat.com, seanjc@google.com
Cc: kvm@vger.kernel.org, rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
 chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-2-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/2026 3:35 PM, Binbin Wu wrote:
> Guard the use of cpuid_func_emulated() with a check that the CPUID
> sub-leaf index is 0, as cpuid_func_emulated() unconditionally returns
> emulated features for index 0 and does not account for indexed leaves.
> 
> Without the guard, when iterating over reverse_cpuid[] entries that
> share the same CPUID function but have a non-zero index, e.g.
> CPUID_7_1_ECX (function=7, index=1), the emulated features for index 0
> are incorrectly OR'd into the wrong capability word.  For example,
> RDPID (CPUID.7.0:ECX[22]) gets erroneously applied to CPUID_7_1_ECX,
> which would allow userspace to set bit 22 of CPUID.7.1:ECX in the vCPU's
> capabilities.
> 
> This is currently benign as the affected bits in the non-zero index
> words happen to not correspond to meaningful features, but it could
> cause problems as new features are defined in those positions.
> 

Hi Sean/Paolo,

While the bug is currently benign, I still think it's worth fixing.

There could be two options:
- Considering cpuid_func_emulated() probably would not be extended
  in the future, still keep this simple implementation, but add some
  comments to cpuid_func_emulated() to call out only subleaf 0 is emulated
  as suggested by Xiaoyao.
  https://lore.kernel.org/kvm/fa47d520-1de9-4ddc-94ca-6bb53ac30f10@intel.com/
- Add the index input parameter to cpuid_func_emulated().

Any suggestion?


> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..25f582a8d795 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -399,15 +399,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		if (!entry)
>  			continue;
>  
> -		cpuid_func_emulated(&emulated, cpuid.function, true);
> -
>  		/*
>  		 * A vCPU has a feature if it's supported by KVM and is enabled
>  		 * in guest CPUID.  Note, this includes features that are
>  		 * supported by KVM but aren't advertised to userspace!
>  		 */
> -		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] |
> -					 cpuid_get_reg_unsafe(&emulated, cpuid.reg);
> +		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i];
> +		if (!cpuid.index) {
> +			cpuid_func_emulated(&emulated, cpuid.function, true);
> +			vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
> +		}
>  		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
>  	}
>  

