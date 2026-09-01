Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0F2737FC;
	Tue,  1 Sep 2026 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250988; cv=none; b=ZMKO5ezYXSiWTMEh9VSv87Fii/EnZb6+oUoFt8Q7/PKcy/opOShWnBXGclKaAq3SYLTxfCD+oaR0Z4oUEU0ZXJCMbxyPmIirHG1UX3C2zIU5umHXwbqsiaIdgpbl03jc8TJZUcTtjTW4J+uLn87yn/dVJz98C339KdpY4gtbYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250988; c=relaxed/simple;
	bh=+zD1ISdn8Sm8YlAQaJ0VYyrx+pk0Qh0WxRYq3+OCQ6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSbUZv7i9kur+g+ByiUqM2CYEK6XVKvt6XXsWN2A3B2EIAmfXq2Ni+RolNSVpu8kXV/O3K/3/7osTHGgwbkYZMlT6vZd8m7H7bIz2DNFPjSbOU7RF48OOMRwBvt2KU1C9nDnJYjXaRi6qYZVLrNSeeVgyKL+/WLuhF3DDOy1DtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlZUFjAv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlZUFjAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788250986; x=1819786986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+zD1ISdn8Sm8YlAQaJ0VYyrx+pk0Qh0WxRYq3+OCQ6E=;
  b=BlZUFjAvUXPV3iiPj0YfQUP3uUEGBAvTqIIMn6eVZw3y7qqoH5GuhONx
   dbVbHeLAtFuenAmwK0+xeCxYvdMiRXSClPMjaduo6I21ExLimdvi9SPzq
   zkq9VVsC77FxbzyIxgESnV6/fTGDr3olMinTLqSPiVbzlKQro7jCEtoUi
   ToHB3DKcvxCddVnRAkaqOVLlUrEHlJKPhEm1OlVt79Y0ogNgj22KB2qrL
   MO7INoPx7roRdYQUP6o71t0tyqQ1m36hBBl6D8g7Jn24I6ca9jQS7d0+9
   /5QMgOyVe+tmaPoglVSq9neMCqDp3OIBQDmca93OKGK2Fl3kHoVaIxIfT
   g==;
X-CSE-ConnectionGUID: s8zeMx99SDKvhKKfqc50dw==
X-CSE-MsgGUID: VxpZPHtFTIGn0gn8SzSicA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99007546"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99007546"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:23:06 -0700
X-CSE-ConnectionGUID: uy/jDMfgQvOmnVotqrrapA==
X-CSE-MsgGUID: w8nYtCvxRW2qdvBioV6QtQ==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:23:02 -0700
Message-ID: <0d1a90e9-8ada-4b82-9ec7-2c8bff9caedd@linux.intel.com>
Date: Tue, 1 Sep 2026 16:23:00 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <apZw3G2volNpLiBD@tlindgre-MOBL1>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <apZw3G2volNpLiBD@tlindgre-MOBL1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/2026 2:29 PM, Tony Lindgren wrote:
> On Thu, Aug 27, 2026 at 11:18:34AM +0800, Binbin Wu wrote:
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -52,6 +52,149 @@
>>  	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
>>  		     a1, a2, a3)
>>  
>> +static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
>> +static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
>> +
>> +#define TDX_VALIDATE_CPU_CAP_USAGE(name)			\
>> +	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=	\
>> +		     tdx_cpu_cap_init_in_progress)
>> +
>> +/* For feature bit that KVM advertised through kvm_cpu_caps[]. */
>> +#define TDX_CFG_F(name)					\
>> +({							\
>> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
>> +	tdx_cfg_caps |= feature_bit(name);		\
>> +})
>> +
>> +/*
>> + * For feature bit KVM allows for TDX guests even though it is not advertised
>> + * through kvm_cpu_caps[], e.g. MWAIT.
>> + */
>> +#define TDX_CFG_EXTRA_F(name)				\
>> +({							\
>> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
>> +	tdx_cfg_extra_caps |= feature_bit(name);	\
>> +})
>> +
>> +#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)		\
>> +do {									\
>> +	const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;	\
>> +	u32 tdx_cfg_extra_caps = 0;					\
>> +	u32 tdx_cfg_caps = 0;						\
>> +									\
>> +	feature_initializers						\
>> +	tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |	\
>> +				 tdx_cfg_extra_caps;			\
>> +} while (0)
> 
> How about make some of the above into just static functions for easier
> readabilyt?

Thanks for your review!

This deliberately mirrors the existing kvm_cpu_cap_init() / F() / XXX_F()
pattern in arch/x86/kvm/cpuid.c.

Similar to kvm_cpu_cap_init(), tdx_cpu_cfg_cap_init() takes a variadic list of
statements that mutate two local accumulators (tdx_cfg_caps, tdx_cfg_extra_caps). 
That's inherently a macro-scoped construct.

> 
> And then drop the __maybe_unused for tdx_cpu_cap_init_in_progress?



