Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BC23BD06;
	Thu, 14 May 2026 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762311; cv=none; b=QjpFYMVz7K4FDXzS1sMfenJoLv84TSNVcapmBUbIVYsrb4SSlPifrEgSrF9d6pMXfzfD4NP5TDnrlClX7Yg9zUbf3vgKSbSao8RxHlyeEeRVWOm7MzJ3WwblSp1Q9Hiv9Aul5W8tJUUmGo0ht7PfPMWnhFmoB7Wx+5a6EjX2uGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762311; c=relaxed/simple;
	bh=xpMPJvehGCdhSRvGdDBmO4yx2QxFdpqiaaj9bFMRkKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWy2hfIiIhvdbPi3Z6DFEdtMTyBMCgnUs52oZgld3gcRIOKM0oa5+MIrnXSpp+8J0s27/VV1pGUFulCQiruZa2ci14Gcwi07CfZAfPlTHK4bhSDRqRy5JsJzI1ZdTSkEnSKwsVBIv2qWlASn0GYDMJz++NQGw6hmps7kpMQvstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egpJZHXY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egpJZHXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778762309; x=1810298309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xpMPJvehGCdhSRvGdDBmO4yx2QxFdpqiaaj9bFMRkKU=;
  b=egpJZHXYyD1qzcOV4GUWCvjO8M4D2GGcXKx8OmliQ/pkHNPDbXpkbO/U
   E0SMwPUfyVRtHeDDbqbkTOWvChnDaTrjQxEp5mWYQGpgnHxD94D7x4UUn
   CROw1w7brpk/WDu8kujaoVC863tHSCBWU4VtSPPq0c0KIURTzlvA/JhcD
   2kilLxnBuhs1q/OWTXKFcufkYg95Ad15T5C78c9ew2/MJrAlyNTUTkJ+I
   uypgcWZrwrQ/+BAI6uA/2wvc2E6cVNzeOqppDRBPxQEeJCJ3+hqJ0HLYv
   +HAqVHuMwA5pypMDJ3ekSEWA43BtW6AF+WZU7ebXX/MIJbkfPxbJv/i24
   A==;
X-CSE-ConnectionGUID: na4FhYfFTXS8dipeqVlgUg==
X-CSE-MsgGUID: Pxu2k89oTwOL3kRuU9F+lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="78727200"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="78727200"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 05:38:28 -0700
X-CSE-ConnectionGUID: YnPB+F/hQWqJpLIteSKxEQ==
X-CSE-MsgGUID: 6DTJYTAgTpSTzrvqxh4yuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="276454061"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 05:38:24 -0700
Message-ID: <2df97245-c1e7-4d72-9ab3-6c186b6c030f@intel.com>
Date: Thu, 14 May 2026 20:38:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode: Do not access MSR_IA32_PLATFORM_ID
 when running as a guest
To: Borislav Petkov <bp@alien8.de>, Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 chao.gao@intel.com
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
 <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>
 <20260513200601.GMagTZqT_CT6EvN1Uz@fat_crate.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260513200601.GMagTZqT_CT6EvN1Uz@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/2026 4:06 AM, Borislav Petkov wrote:
> Patch in Fixes: causes the usual:
> 
>    unchecked MSR access error: RDMSR from 0x17 at ... (intel_get_platform_id)
>    Call Trace:
>     early_init_intel
>     early_cpu_init
>     setup_arch
>     _printk
>     start_kernel
>     x86_64_start_reservations
>     x86_64_start_kernel
>     common_startup_64
> 
> because the kernel is booted in a guest.
> 
> In order to avoid it, this MSR access needs to be prevented when running
> virtualized. That is usually done by checking X86_FEATURE_HYPERVISOR but
> for this particular case it is too early yet.
> 
> The platform ID needs to be read as early as when microcode is loaded on
> the BSP:
> 
>    load_ucode_bsp ... -> get_microcode_blob ... -> intel_find_matching_signature
> 
> and by that time, CPUID leafs haven't been parsed yet.
> 
> The microcode loader already has logic to check early whether the kernel
> is running virtualized so make that globally available to arch/x86/. The
> query whether running virtualized is getting more and more prominent in
> recent times so might as well make it an arch-global var which the rest
> of the code can use.
> 
> Fixes: d8630b67ca1ed ("x86/cpu: Add platform ID to CPU info structure")
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Binbin Wu <binbin.wu@linux.intel.com>
> Link: https://lore.kernel.org/r/20260430020953.1405535-1-binbin.wu@linux.intel.com

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> @@ -179,6 +172,11 @@ void __init load_ucode_bsp(void)
>   
>   	early_parse_cmdline();
>   
> +	if (!cpuid_feature())
> +		dis_ucode_ldr = true;
> +	else
> +		x86_hypervisor_present = native_cpuid_ecx(1) & BIT(31);
> +

IIUC, the reason why move the initialization of x86_hypervisor_present 
from microcode_loader_disabled to here is to make sure 
x86_hypervisor_present is always initialized, right?

But initializing x86_hypervisor_present by load_ucode_bsp() depends on 
CONFIG_MICROCODE, which depends on CPU_SUP_AMD || CPU_SUP_INTEL. So when 
both CPU_SUP_AMD and CPU_SUP_INTEL are not enabled, 
x86_hypervisor_present will always be 0. It's not a problem for now, we 
can solve it when x86_hypervisor_present is going to be used by CENTAUR 
or ZHAOXIN.
