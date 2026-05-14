Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7333F5B9;
	Thu, 14 May 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739732; cv=none; b=FoSQ+saAz5SzUpxcxmEWyVe0JsRadpdvEbwaR+Z26x7PEz4MS9R9Clb/+eoqanCtM73UC/mPpe7MG4XtkEgOldNw4kiei3i/Eug27kJwnLQclLbrpAHoURXKlOAHqv+Cv98BzEwbZTshBoc9dpqGAIqEk0iMCxDEnQamrmV5Dmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739732; c=relaxed/simple;
	bh=MmXcM3BPSvaPgBoQwcn2J6cPoOZ5bAzRcCHHU3OoExI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfjPmI8MkYbHiR2L2SQMH9mByr1bbOH7Gwei9dk9Q7ITbbWptg8x/ns2LG2iJIGd7Rq0RSQYFH3pkppqXnjh46yTXEP0Goo2kDEkcIWEbi/2gtAooSX7G9wpJ1CRv0+XT6IArjZRsu552uRNBLqNtgezDegJQYg260XY/a2nJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7b2fBc6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7b2fBc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778739730; x=1810275730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MmXcM3BPSvaPgBoQwcn2J6cPoOZ5bAzRcCHHU3OoExI=;
  b=C7b2fBc6DOd0YTAis8VGdFlHY2yQusLeeOIICE8hyBNrsknH6zTlp1FH
   C+H4HnHDeLxNU1YdW4goD5vfE7fs5IOLbKyzNX4li6MB6ouAberwpCQhj
   FF5C90H4vlQXcKt7Dlj/XAwaFzIH68QFmKhktyV/BXb1d5M7WTTYjZT5+
   vJAfnIEqP5GH80PR26cVgDksK4Yvnorki57dvzxCQFzXRgAZCCtjh1CvV
   XP0sulaaHqm2GbrghxSZiQ00FKegfkFqFh95v5OdhHjLCZE7DMd7vuOCK
   V/KhHUlKd4MiXKb2AtGmH+Gp3Qokh8iDdNq2atf7VJTNysrVpWd+YycN1
   w==;
X-CSE-ConnectionGUID: kdsPOU+lQqSH8p32IpbsmA==
X-CSE-MsgGUID: YDd3LlLWT+GF0+PjNLvitQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79534449"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79534449"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:22:09 -0700
X-CSE-ConnectionGUID: MTPQTRCsQ+6HaenEibacGg==
X-CSE-MsgGUID: LMYNDLPWQFi1Mer4mAP3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="238413238"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:22:07 -0700
Message-ID: <7e8c7907-5237-4287-9ccc-ec22e15a7415@linux.intel.com>
Date: Thu, 14 May 2026 14:22:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode: Do not access MSR_IA32_PLATFORM_ID
 when running as a guest
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
 <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>
 <20260513200601.GMagTZqT_CT6EvN1Uz@fat_crate.local>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513200601.GMagTZqT_CT6EvN1Uz@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/2026 4:06 AM, Borislav Petkov wrote:
> Patch in Fixes: causes the usual:
> 
>   unchecked MSR access error: RDMSR from 0x17 at ... (intel_get_platform_id)
>   Call Trace:
>    early_init_intel
>    early_cpu_init
>    setup_arch
>    _printk
>    start_kernel
>    x86_64_start_reservations
>    x86_64_start_kernel
>    common_startup_64
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
>   load_ucode_bsp ... -> get_microcode_blob ... -> intel_find_matching_signature
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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]

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
> +	 * 1) The CPU does not support CPUID, detected below in
                                                         ^
Nit: 
"below" is a bit ambiguous, maybe "earlier"?

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

