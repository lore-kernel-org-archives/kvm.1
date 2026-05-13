Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C63F412D;
	Wed, 13 May 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683287; cv=none; b=WohOiKydCtS/RFdrTg9LsNu1WkBG9rzKikTDnYkNfFW6b4WS5yLLBVkFtln5dBm6/sit9oVrIvVi7/SdPOGWy4VVP0wM2brfHyuhMIbsS6J26n4jeqgiS4PYspBr2/Dk/lzOgRDHxmp4WswMVGtBS8kAtRgeiPOtcC+wH1GljeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683287; c=relaxed/simple;
	bh=sob6UMVPhuyiYaiXAZTac+hxeGFivuTVD/QWJuxOyZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0blS2LYK8QToRrowDvdrNiLqiVppswaneLsIGxdMVrVLg80CgoeEC0xeGKlt3dgUFCB47e6mternDx27Mav2KG9kvQu5gtlkwQkTsbX0jklbImHoGgMi70FiNNVy3pKYjz+pPZ7d2irBy0DlWJnOtaLkTtJMLnlnoEU8sQ1tew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8aMWKAI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8aMWKAI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778683284; x=1810219284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sob6UMVPhuyiYaiXAZTac+hxeGFivuTVD/QWJuxOyZk=;
  b=g8aMWKAIHf69NKF9duOSCHnNtoi+tXWoaUpCzOSl0UBMZaSS7FCESHHc
   Uefsr4BIP+vFN7waHQHr2Fk4R5qetkP+Nbo6SNxK15N1ujJXRDYTzpUOd
   z2GkkA+U0QvmPshSI4o2JtwsVarz/KrpHdWv+0Cdp7oDbGIzAQieCdIaj
   8v5xX3RbXLlJy0OfgMTbOIgFv6NSouH92va+0yMkWyzkU4pyuSq/18Kk+
   ZLtE4mPGxKe4+uWGkX2qbjL608PG0jNLt8/FMNVaE+wVFk7dWZFQ+a3eE
   IHXT09JqwvkG7GvdfVQCE1haM9R0JEDWfJ5IF/mWK8uiaIghfFAwkXeAw
   g==;
X-CSE-ConnectionGUID: F2xE+6iNTXCLgiqMCCMk/Q==
X-CSE-MsgGUID: Cc6WcmJlR5OiQpPHqEMCUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78757097"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="78757097"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:41:22 -0700
X-CSE-ConnectionGUID: Gh63vDGzS0adsC8b/O4hTw==
X-CSE-MsgGUID: oyiVVFn1RrOpnqAYDDhMTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="235425946"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:41:20 -0700
Message-ID: <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
Date: Wed, 13 May 2026 22:41:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 6:14 PM, Borislav Petkov wrote:
> On Tue, May 12, 2026 at 09:57:58AM +0800, Binbin Wu wrote:
>> hypervisor_present could be uninitialized if dis_ucode_ldr is true.
>> intel_get_platform_id() is also called during the normal cpu initialization.
> 
> Right, that needs more surgery. See if the below works instead pls.
> 
> We might as well do it - the question whether we run on a HV comes very often
> recenly - might as well make it an "official" variable.

Tested the diff by running as a TDX guest and it fixed the unchecked MSR access error.

Tested-by: Binbin Wu <binbin.wu@linux.intel.com>

> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 10b5355b323e..67dd932305db 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -733,6 +733,7 @@ bool xen_set_default_idle(void);
>  #endif
>  
>  void __noreturn stop_this_cpu(void *dummy);
> +extern bool x86_hypervisor_present;
>  void microcode_check(struct cpuinfo_x86 *prev_info);
>  void store_cpu_caps(struct cpuinfo_x86 *info);
>  
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index e533881284a1..5c0afae75e9f 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -322,7 +322,7 @@ static u32 get_patch_level(void)
>  {
>  	u32 rev, dummy __always_unused;
>  
> -	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && hypervisor_present) {
> +	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && x86_hypervisor_present) {
>  		int cpu = smp_processor_id();
>  
>  		if (!microcode_rev[cpu]) {
> @@ -714,7 +714,7 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
>  			invlpg(p_addr_end);
>  	}
>  
> -	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && hypervisor_present)
> +	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && x86_hypervisor_present)
>  		microcode_rev[smp_processor_id()] = mc->hdr.patch_id;
>  
>  	/* verify patch application was successful */
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 68a1a893246c..f6722c9618e0 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -57,7 +57,7 @@ bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
>  u32 base_rev;
>  u32 microcode_rev[NR_CPUS] = {};
>  
> -bool hypervisor_present;
> +bool __ro_after_init x86_hypervisor_present;
>  
>  /*
>   * Synchronization.
> @@ -118,14 +118,9 @@ bool __init microcode_loader_disabled(void)
>  	/*
>  	 * Disable when:
>  	 *
> -	 * 1) The CPU does not support CPUID.
> -	 */
> -	if (!cpuid_feature()) {
> -		dis_ucode_ldr = true;
> -		return dis_ucode_ldr;
> -	}
> -
> -	/*
> +	 * 1) The CPU does not support CPUID detected below in
> +	 *    load_ucode_bsp().
> +	 *
>  	 * 2) Bit 31 in CPUID[1]:ECX is set
>  	 *    The bit is reserved for hypervisor use. This is still not
>  	 *    completely accurate as XEN PV guests don't see that CPUID bit
> @@ -135,9 +130,7 @@ bool __init microcode_loader_disabled(void)
>  	 * 3) Certain AMD patch levels are not allowed to be
>  	 *    overwritten.
>  	 */
> -	hypervisor_present = native_cpuid_ecx(1) & BIT(31);
> -
> -	if ((hypervisor_present && !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
> +	if ((x86_hypervisor_present && !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
>  	    amd_check_current_patch_level())
>  		dis_ucode_ldr = true;
>  
> @@ -179,6 +172,11 @@ void __init load_ucode_bsp(void)
>  
>  	early_parse_cmdline();
>  
> +	if (!cpuid_feature())
> +		dis_ucode_ldr = true;
> +	else
> +		x86_hypervisor_present = native_cpuid_ecx(1) & BIT(31);
> +
>  	if (microcode_loader_disabled())
>  		return;
>  
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 37ac4afe0972..a4c0a0cf928b 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -138,6 +138,9 @@ u32 intel_get_platform_id(void)
>  {
>  	unsigned int val[2];
>  
> +	if (x86_hypervisor_present)
> +		return 0;
> +
>  	/*
>  	 * This can be called early. Use CPUID directly instead of
>  	 * relying on cpuinfo_x86 which may not be fully initialized.
> diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
> index 3b93c0676b4f..a10b547eda1e 100644
> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -48,7 +48,6 @@ extern struct early_load_data early_data;
>  extern struct ucode_cpu_info ucode_cpu_info[];
>  extern u32 microcode_rev[NR_CPUS];
>  extern u32 base_rev;
> -extern bool hypervisor_present;
>  
>  struct cpio_data find_microcode_in_initrd(const char *path);
>  

