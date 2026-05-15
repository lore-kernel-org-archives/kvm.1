Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9C42B726
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835805; cv=none; b=TmZOJzBbSQ0B69ut0E3kZTXtgQs1VQnJ6OSxd6hJa2SiZ2mUpTQqaQUv4qYjWy5wlu68PK2+pYThad9Hgmm6UgquCbREYrAsyHPJkkv6ZWvj8Ld1c/vNDceBq7hiFKm9M/fyNufFO+utoxmNnFVHkUSvWOp+u+i+veNlcD3u+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835805; c=relaxed/simple;
	bh=jf2+E4yIw5mc26mWM18tpZZpHRQcEN8PIN7/Ab9CcDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJc+I/zwMdxEsI8OknVUrsvnq41iruRJztSmO7lt5fyGysRyYJPn+cK3F0gW0c5KL7Xp1zIR1aBL9OgI24V+xIPw5aMHWEPZRxdnRmhv+hJj8WFuxIHQM5wC2jiXgJ/6byi9w7XqrbZHZ9CpA8ce5et529+2rgK/x4cTZ++Zja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akDB14aY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akDB14aY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778835804; x=1810371804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jf2+E4yIw5mc26mWM18tpZZpHRQcEN8PIN7/Ab9CcDk=;
  b=akDB14aY2cNjtqBmNpMMSgGZuum1JbMRmlznPjwUQuvohUK+8NjLrFkk
   L4ayXEyLr4dJGM+IZoJhxHjZunGUpvufWyD1tPCOvBUnd8O0oraXMXiBJ
   chRuN6PN3R6Py0VBYHLbwh+5QpHa6IfnW2F3BzjxcubrK1GgWOJAlNkmT
   V1+N8E4PaGBKLcfJm/fPllw3vNLyPdUWZR9R5F03JihjX7M7fx+jtHRnJ
   +79kKjd7IKRYd716CIE4ND6skLeFUw1oap5CEZDt022bTFthjuRcJ9Wjl
   312JV+byJSvo15unswZM8cJ4PEK2VcNgZIInKbAFLJPlt+vF+faIujgbf
   A==;
X-CSE-ConnectionGUID: dmx3uoxQTdqYM6TlUHdwxw==
X-CSE-MsgGUID: K4mVMPV6SRe8IWEfa50SLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="105247144"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="105247144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:03:22 -0700
X-CSE-ConnectionGUID: 3ivDejnJTdePN6ZVon+jyQ==
X-CSE-MsgGUID: vj1wAF3XTMyIu9pOd6SU2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="240453564"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:03:20 -0700
Message-ID: <db11b4df-d5f8-49b5-91dc-daa103f94223@intel.com>
Date: Fri, 15 May 2026 17:03:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being
 applied to wrong sub-leaf
To: Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-2-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260417073610.3246316-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>   arch/x86/kvm/cpuid.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..25f582a8d795 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -399,15 +399,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   		if (!entry)
>   			continue;
>   
> -		cpuid_func_emulated(&emulated, cpuid.function, true);
> -
>   		/*
>   		 * A vCPU has a feature if it's supported by KVM and is enabled
>   		 * in guest CPUID.  Note, this includes features that are
>   		 * supported by KVM but aren't advertised to userspace!
>   		 */
> -		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] |
> -					 cpuid_get_reg_unsafe(&emulated, cpuid.reg);
> +		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i];
> +		if (!cpuid.index) {

Instead of such a temporary fix, I would prefer adding the index 
parameter to cpuid_func_emulated() and split this patch separately.

> +			cpuid_func_emulated(&emulated, cpuid.function, true);
> +			vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
> +		}
>   		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
>   	}
>   

