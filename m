Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69421DC9B3
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551463; cv=none; b=tmucdGwRnECmaii1kOWCXeWXXCYykOtv6gwBWPLpanacMtkGZjSFXRgQ5nABMobq+i/y4Paq1q50BrYLcXdd8tN4knELXaM2efAHreELYQXb/6IlFcjyDnjPyhDzBeIN/5A3lTGtawpgZ3pW+p43ddqB79+mdZaR4NuYPI/HJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551463; c=relaxed/simple;
	bh=XquCwDNh5hsz8TEY31plU+ZX/bRYUutRHY6ODn7EXLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMBQLBEZcrc/ct32WbrzLl3jV0SrpbkDQyVqrKw1ILcb3UarsruUNZzTfWmEXp1hXJXNXrMI8HWbHsukQLHbxumHiRrI+UHHj68OBJgMrgAy8NJNfotzrKkNtTG+/zmRbdSgHu0t5NOY7YqFH0UiOe+cFU5UYR3DNRprQpnq+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n048Kxjr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n048Kxjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780551462; x=1812087462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XquCwDNh5hsz8TEY31plU+ZX/bRYUutRHY6ODn7EXLw=;
  b=n048Kxjreycxse/pdhgTMgruWnofU2/c4zr1sNa/XmRaO104MCgF5Ptm
   If56W59fg+mLQ9L5lcr5ARTy5gDLpIIPjCE6dSLic92ILo7yEnfrGJRlb
   m6iTnDT45lN19UvYMq9LSMU4rRtgRjgZBDbM+0z4FQOEqgyuKQQL5ZFLN
   cz6aTCoAwmGaNoNoRkwfmAkk2vYK7rKjjzf6CW7rdSdJWv+b2J3lhbWhB
   gFEjBLk/Stnz1MgW3Su5CyH3OgHtYCyUshnTnRQKcRweZFEOmEWLr49/I
   Qwe9y+3UtgJwzdgeVqeFeUev5v3eKeDkoeP/g9rOHW8SjdQLQdUMXf8aD
   A==;
X-CSE-ConnectionGUID: DAtQuJbwRvaAS8MlHQ+NIA==
X-CSE-MsgGUID: 0mQDW1u1TvycwzzyOv/pLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="83948060"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="83948060"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:37:41 -0700
X-CSE-ConnectionGUID: nstRqhw0RwqIOUu6LeE4/g==
X-CSE-MsgGUID: msCjksH0RQeOUa7Z0LVf5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="249367100"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:37:40 -0700
Message-ID: <5dc40153-1617-4f06-8433-a9f0064367c4@linux.intel.com>
Date: Thu, 4 Jun 2026 13:37:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] KVM: x86: TDX: Track supported configurable
 CPUID bits
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260604023314.3907511-2-binbin.wu@linux.intel.com>
 <20260604024425.4923D1F00893@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260604024425.4923D1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 10:44 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `tdx_cpu_cfg_cap_init` macro is highly fragile and relies on the caller providing a mandatory trailing comma, which will cause obscure syntax errors if omitted.
> --
> 
> commit 8aa0677abade944ac536d7acccef89b12ace7386
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: x86: TDX: Track supported configurable CPUID bits
> 
> This patch introduces an allowlist for TDX directly configurable CPUID bits
> supported by KVM. It tracks the supported bits by statically initializing
> multi-bit fields and dynamically populating feature bits during hardware
> setup using a new initialization macro.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index b8c3d3d8bbfe5..028d54c76b81e 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
>> @@ -52,6 +52,178 @@
>> +#define TDX_F(name)					\
>> +({							\
>> +	tdx_cpu_cfg_caps |= feature_bit(name);		\
>> +})
>> +
>> +#define tdx_cpu_cfg_cap_init(_func, _index, _reg, feature_initializers...)		\
>> +do {											\
>> +	u32 tdx_cpu_cfg_caps = 0;							\
>> +											\
>> +	for (int i = 0; i < ARRAY_SIZE(tdx_kvm_supported_cpuid); i++) {			\
>> +		struct tdx_supported_cpuid_reg *r = &tdx_kvm_supported_cpuid[i];	\
>> +											\
>> +		if (r->function == _func && r->index == _index && r->reg == _reg) {	\
>> +			feature_initializers						\
>> +			r->mask |= tdx_cpu_cfg_caps;					\
> 
> [Severity: Low]
> Is this macro design relying on the caller providing a mandatory trailing
> comma?

Yes.
It adopts the same style as kvm_cpu_cap_init() in cpuid.c

> 
> Because feature_initializers expands to a list of statement expressions
> like ({ tdx_cpu_cfg_caps |= feature_bit(name); }), omitting the trailing
> comma in the macro invocation would result in a syntax error immediately
> before r->mask |= tdx_cpu_cfg_caps.
> 
> Could TDX_F be redesigned to return the bitmask directly so they can be
> combined using bitwise-OR, avoiding the strict trailing comma dependency?
> 
>> +			break;								\
>> +		}									\
>> +	}										\
>> +											\
>> +	WARN_ON_ONCE(!tdx_cpu_cfg_caps); 						\
>> +} while (0)
>> +
>> +/* Only for TDX directly configurable CPUID feature bits */
>> +static void __init tdx_initialize_cpu_cfg_caps(void)
>> +{
>> +	tdx_cpu_cfg_cap_init(0x1, 0, CPUID_ECX,
>> +		TDX_F(MWAIT),
>> +		TDX_F(TSC_DEADLINE_TIMER),
>> +		TDX_F(AVX),
>> +		TDX_F(F16C),
>> +	);
> 

