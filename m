Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D831D5174;
	Tue, 28 Apr 2026 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356079; cv=none; b=U4VZs+Sf1fKKjEeJ1i+tI38UYNrAT3hOJ4zyRnfRJsnTIMKafSosEvCh9054S05SDBQz9VifDIs5xxwBNFYMC2I+TvtTy39qN73Z8Allq01b3KoTN69BbpN51Axu8wF+cvelOAktP6iZU3pHDaZSjQ9aZKTKKvlAs9CiP4r/w8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356079; c=relaxed/simple;
	bh=IXgwrUDtjUnTRZ0Fxv1JRyKKGVkikZ+8gVY+RKQtnUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdUEiBvWtyGnxDGi+v1CfuyyyEQ9bDHMHG89l9dpTwWew4vKdxnFIl97EQ1OOdL+mn4ZNhiZqEU2hXgP1aVQcnE4dDQ39qMCgO5PjqhbiqgPSNS6AuBXLqwFjGyrSGd1gx9UkYNk01TtYxPC+xU5u6JlHI+xr/S0lmmXgZYoo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fauUTMjH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fauUTMjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777356079; x=1808892079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IXgwrUDtjUnTRZ0Fxv1JRyKKGVkikZ+8gVY+RKQtnUk=;
  b=fauUTMjHQBjnjg8RthNCk1OWa7o7LYFjmIZTZGgh6WH6UUEHapb9vroQ
   caMc2pfskMlHHpU62PY91eDv3qpMJB1U6OREt45+2+UIxhKSmgnV2SkJW
   13rSddbH9a3eA027nCL+HYv3BbEecKp0wlFzI/oNggHwhG9WqllXmO/a8
   OGhNzav0mDEPyYUSp257p8ybHqSiqOSf89SFJktU1r/x5Mvos2zSFRFPQ
   L2kElnu3vAv5Z4lJGycRukU4YOm1jFwRM7bYwbXcd/Gtum56YhRdoeneY
   NrsZNGSILnKsfsdgZmtTLtvu7z2sTmDG4qDKCJMF9uIqjEFDk5xA1XH/x
   g==;
X-CSE-ConnectionGUID: 0Eupdf18Qr6hFuX7GKrS8A==
X-CSE-MsgGUID: Izk0ZFj1STW/NGEaVv8HPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="81862172"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="81862172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 23:01:18 -0700
X-CSE-ConnectionGUID: CbcSBTyqSfCX2J6EGY/vtA==
X-CSE-MsgGUID: RaqFVa6QSXu/g7mcKQi8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233751013"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 23:01:15 -0700
Message-ID: <36c64a53-0041-4638-b6cd-7deff38bd37d@intel.com>
Date: Tue, 28 Apr 2026 14:01:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
To: Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, dave.hansen@intel.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 chao.gao@intel.com
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
 <20260428024746.1040531-3-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260428024746.1040531-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2026 10:47 AM, Binbin Wu wrote:
> The Linux kernel now reads MSR_IA32_PLATFORM_ID during CPU init.  When
> running as a guest, if the underlying hypervisor does not emulate the
> MSR, the RDMSR from 0x17 in intel_get_platform_id() can trigger an
> unchecked MSR access during early boot.
> 
>      unchecked MSR access error: RDMSR from 0x17 at rIP: 0xffffffffba38d6fc (intel_get_platform_id+0x7c/0xb0)
>      Call Trace:
>       <TASK>
>       ? early_init_intel+0x28/0x2c0
>       ? early_cpu_init+0x9b/0x930
>       ? setup_arch+0xbf/0xbb0
>       ? _printk+0x6b/0x90
>       ? start_kernel+0x7f/0xaa0
>       ? x86_64_start_reservations+0x24/0x30
>       ? x86_64_start_kernel+0xda/0xe0
>       ? common_startup_64+0x13e/0x141
>       </TASK>
> 
> Currently, KVM does not support guest reads of MSR_IA32_PLATFORM_ID for
> TDX.  This should be fixed in the hypervisor, but for compatibility with
> newer guests running on older KVM hosts, skip reading MSR_IA32_PLATFORM_ID
> and return 0. It's meaningless to read MSR_IA32_PLATFORM_ID since guests
> are not allowed to do microcode update.  cpu_has_old_microcode(), which
> uses platform ID for CPU match, also skips checking whether the microcode
> is old or not in a virtualized environment.
> 
> Since intel_get_platform_id() can be called early before cpuinfo_x86
> is fully initialized, check whether it's running in a virtualized
> environment from CPUID and opportunistically add a helper.
> 
> Fixes: d8630b67ca1ed ("x86/cpu: Add platform ID to CPU info structure")
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>   arch/x86/kernel/cpu/microcode/core.c     | 2 +-
>   arch/x86/kernel/cpu/microcode/intel.c    | 4 ++++
>   arch/x86/kernel/cpu/microcode/internal.h | 5 +++++
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 651202e6fefb..ee204c8a90bf 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -135,7 +135,7 @@ bool __init microcode_loader_disabled(void)
>   	 * 3) Certain AMD patch levels are not allowed to be
>   	 *    overwritten.
>   	 */
> -	hypervisor_present = native_cpuid_ecx(1) & BIT(31);
> +	hypervisor_present = x86_cpuid_has_hypervisor();
>   
>   	if ((hypervisor_present && !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
>   	    amd_check_current_patch_level())
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 37ac4afe0972..cb93e4ea410e 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -147,6 +147,10 @@ u32 intel_get_platform_id(void)
>   	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
>   		return 0;
>   
> +	/* Don't try to read microcode bits when virtualized. */

The platform ID is not only used by microcode update. I don't think 
calling them microcode bits is proper. It's also stashed in struct 
cpuinfo_x86::intel_platform_id and used in x86_match_cpu() as a factor 
as the generic FMS (Family, Model, Stepping) bits.

We skip things due to hypervisor is set usually when the thing is known 
unable to be virtualized. From the perspective of microcode update, it's 
OK to skip reading it due to hypervisor bit. However, from the 
perspective of generic platform ID, it seems not that reasonable to skip 
reading it due to hypervisor bit. Especially KVM has supported this MSR 
for normal VMs.

So how about using the safe version of RDMSR, if we want the enhancement?

> +	if (x86_cpuid_has_hypervisor())
> +		return 0;
> +
>   	/* get processor flags from MSR 0x17 */
>   	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
>   
> diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
> index 3b93c0676b4f..0233e074d76b 100644
> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -100,6 +100,11 @@ static inline unsigned int x86_cpuid_family(void)
>   	return x86_family(eax);
>   }
>   
> +static inline bool x86_cpuid_has_hypervisor(void)
> +{
> +	return native_cpuid_ecx(1) & BIT(31);
> +}
> +
>   extern bool force_minrev;
>   
>   #ifdef CONFIG_CPU_SUP_AMD

