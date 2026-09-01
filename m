Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93F46C838;
	Tue,  1 Sep 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251285; cv=none; b=idqbJJ1bhAk57aR1oLKOy8LSMswC62UlJ1TMbOmg0izlZdn3xuH4lzA49cHfWCHjS8GtguDuEV92Vb66ohc21eBVBldAs0Rr9OTZ3TTnOZNbaVFaNfphIM8C2vtyH8vm3QHu6+QVkyAydCyahXZiZod3eSIC+gX7/29Wiwtn9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251285; c=relaxed/simple;
	bh=hleEjYPfqFEBLCARm2sQTGnwfh0JoVgAn8WRk1JfNqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUsK5LvNEhHk5XlWTC4jFWg/Aj5IUH7SJUr+qD2/YhAmhJwFjg2cQG2uBO3d3J/Pdm3qBNFCcdwGr1xKq8UepXy0gUxivYup4RAflVE/A01nd0wiD5cNl26pBBA+xmLTrVwfC3ObzoxYvziBmGLbxemfreznAqAmiD7R1RwMDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y//tAZWi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y//tAZWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788251284; x=1819787284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hleEjYPfqFEBLCARm2sQTGnwfh0JoVgAn8WRk1JfNqI=;
  b=Y//tAZWiaDqdJ1UFwbQ3nHZlBzZ/n2RDRaqrXsncaVOSbLOAJJxgZUDa
   w1Qo5d0/ZS89gJffLSwhuZHasFte78QlZC1BrEN5o//G3Idf2M0QWTrxJ
   cc4BKfCnDoe6eH0wse1ICFmX1DertVXTfMEIswzPkgZFPucUc63yiBM16
   1iVcysabRQVYV5CPkVQ/qXJUas0RcqqR9vDbHBziT2Z74w/mZfJkz4dAn
   4syIOm678IOpfz/ofnkVHFFVCtIsLre+ZJOOzpdsJB/ZuFV5lFiyX4FNB
   lqOes5ffXaCMg9wAeurlBEWMMgzJ9N0JgWzi+4nejXi3IJs/MvNiXWB47
   g==;
X-CSE-ConnectionGUID: rPS6t9HqRda8AL3xn+4edg==
X-CSE-MsgGUID: gTv36zfuQsWnq1nQi6ZHjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="91186623"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="91186623"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:28:03 -0700
X-CSE-ConnectionGUID: 80CGQDCnTLmQe2YaAC/EpA==
X-CSE-MsgGUID: cQhgNP0kTWyCWQ318hE2gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="307244930"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:28:00 -0700
Date: Tue, 1 Sep 2026 11:27:56 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Message-ID: <apaMjOzUb35SnoTt@tlindgre-MOBL1>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <apZw3G2volNpLiBD@tlindgre-MOBL1>
 <0d1a90e9-8ada-4b82-9ec7-2c8bff9caedd@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1a90e9-8ada-4b82-9ec7-2c8bff9caedd@linux.intel.com>

On Tue, Sep 01, 2026 at 04:23:00PM +0800, Binbin Wu wrote:
> On 9/1/2026 2:29 PM, Tony Lindgren wrote:
> > On Thu, Aug 27, 2026 at 11:18:34AM +0800, Binbin Wu wrote:
> >> --- a/arch/x86/kvm/vmx/tdx.c
> >> +++ b/arch/x86/kvm/vmx/tdx.c
> >> @@ -52,6 +52,149 @@
> >>  	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
> >>  		     a1, a2, a3)
> >>  
> >> +static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
> >> +static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
> >> +
> >> +#define TDX_VALIDATE_CPU_CAP_USAGE(name)			\
> >> +	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=	\
> >> +		     tdx_cpu_cap_init_in_progress)
> >> +
> >> +/* For feature bit that KVM advertised through kvm_cpu_caps[]. */
> >> +#define TDX_CFG_F(name)					\
> >> +({							\
> >> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> >> +	tdx_cfg_caps |= feature_bit(name);		\
> >> +})
> >> +
> >> +/*
> >> + * For feature bit KVM allows for TDX guests even though it is not advertised
> >> + * through kvm_cpu_caps[], e.g. MWAIT.
> >> + */
> >> +#define TDX_CFG_EXTRA_F(name)				\
> >> +({							\
> >> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> >> +	tdx_cfg_extra_caps |= feature_bit(name);	\
> >> +})
> >> +
> >> +#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)		\
> >> +do {									\
> >> +	const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;	\
> >> +	u32 tdx_cfg_extra_caps = 0;					\
> >> +	u32 tdx_cfg_caps = 0;						\
> >> +									\
> >> +	feature_initializers						\
> >> +	tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |	\
> >> +				 tdx_cfg_extra_caps;			\
> >> +} while (0)
> > 
> > How about make some of the above into just static functions for easier
> > readabilyt?
> 
> Thanks for your review!
> 
> This deliberately mirrors the existing kvm_cpu_cap_init() / F() / XXX_F()
> pattern in arch/x86/kvm/cpuid.c.
> 
> Similar to kvm_cpu_cap_init(), tdx_cpu_cfg_cap_init() takes a variadic list of
> statements that mutate two local accumulators (tdx_cfg_caps, tdx_cfg_extra_caps). 
> That's inherently a macro-scoped construct.

Ah OK thanks I now noticed the feature_initializers.
