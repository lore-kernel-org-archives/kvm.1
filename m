Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F83AF677;
	Thu, 14 May 2026 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739940; cv=none; b=YamHACNVYy/lkOPyay2F0aBQXtGx3mhxVizMPGl0q25KS4t9LER9Sv/hfDe76yy7j6fTS6DHkNUeBpBmgeFohhKO/M/NhBzWVvLrL3glftVv7hpdYlVDqaWkPXE/nl85weNbrF66ytGWlJ+da+8AhgdFh+/z0GXPj7T6BZD3fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739940; c=relaxed/simple;
	bh=Yto2uCOeGGtGXhQ2WnmbMOQRPUy3KMV/cfEwBmVjtlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7tU1Wy2qyQIMKVimLHmDBnX8CYW5DpHONxaGTySSVL3EwM91RPMxpJiqbk55Rf7Mbm+JFEGTDAB9WH9rW3cs0n9lAvyMawf79h2s0ywAPDI9lWmd2I+tt6zV0ArA9MusLWcnC4rVqFwQaox4wqVWkdp/VIlg8dHbZK387nN+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyjzWiB1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyjzWiB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778739938; x=1810275938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yto2uCOeGGtGXhQ2WnmbMOQRPUy3KMV/cfEwBmVjtlg=;
  b=UyjzWiB1T5f6h6Og8YhoRa+a312NQXnvn2tIpOuhofPiBOZy54v4oj1Q
   +Tj5ZtGeQlAH7aNflIo8wVIYxa9uhY4VbxnVAb+nDkNKLAxo6M5P++okS
   SrtJBpKNg67a3Osl9T9XL1lo/e6PbUUkK3G1a4GqRMv0SckMyAuWrG35K
   f+Jubk3OBtpiNG0ufdem0TjpzDZQFa8CqqVVrBCvW92R/NU7c7p1Hk/Fb
   Q+NW7ElJZlUiKPqlmNXkN/jkvf5PyWROD1iEhI3Hq5DlZgOCFCE8PynV0
   WIzp1bhEcYaYcp6RoCiL8oABSd4a7gFWw3OM9OoZp/HoLlM6nPz78LoV0
   A==;
X-CSE-ConnectionGUID: QvmkdPimRKKadSUhZlMygw==
X-CSE-MsgGUID: UIr3R19hSre/vIYy0Ipwfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79534647"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79534647"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:25:38 -0700
X-CSE-ConnectionGUID: /lRxqTEuTkOlVyD3R0zkaA==
X-CSE-MsgGUID: 735Ce/2tSVSyZ+1qk7u5aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="238413786"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 23:25:35 -0700
Message-ID: <7cb5e6ca-cddf-4fea-8d72-c73ed0563fee@linux.intel.com>
Date: Thu, 14 May 2026 14:25:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/cpu: Move intel_get_platform_id() to cpu/intel.c
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
 <20260513200713.GNagTZ8QI_BHBeZXXr@fat_crate.local>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513200713.GNagTZ8QI_BHBeZXXr@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/2026 4:07 AM, Borislav Petkov wrote:
> It is not only used in the microcode loader anymore and the platform ID
> is cached in the cpuindo_x86 structure so move the getter to

Typo:
cpuindo_x86  -> cpuinfo_x86 

> Intel CPU-specific code.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/include/asm/microcode.h      |  2 --
>  arch/x86/include/asm/processor.h      |  1 +
>  arch/x86/kernel/cpu/intel.c           | 35 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/microcode/intel.c | 36 ---------------------------
>  4 files changed, 36 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
> index 3c317d155771..8b41f26f003b 100644
> --- a/arch/x86/include/asm/microcode.h
> +++ b/arch/x86/include/asm/microcode.h
> @@ -61,8 +61,6 @@ static inline int intel_microcode_get_datasize(struct microcode_header_intel *hd
>  	return hdr->datasize ? : DEFAULT_UCODE_DATASIZE;
>  }
>  
> -extern u32 intel_get_platform_id(void);
> -
>  static inline u32 intel_get_microcode_revision(void)
>  {
>  	u32 rev, dummy;
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 67dd932305db..1a68a955863d 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -237,6 +237,7 @@ extern void early_cpu_init(void);
>  extern void identify_secondary_cpu(unsigned int cpu);
>  extern void print_cpu_info(struct cpuinfo_x86 *);
>  void print_cpu_msr(struct cpuinfo_x86 *);
> +extern u32 intel_get_platform_id(void);
>  
>  /*
>   * Friendlier CR3 helpers.
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index f28c0efb7c8f..3473b89e6907 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -199,6 +199,41 @@ void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
>  		c->cpuid_level = cpuid_eax(0);
>  }
>  
> +/*
> + * Use CPUID to generate a "vfm" value. Useful before cpuinfo_x86
> + * structures are populated.
> + */
> +static u32 intel_cpuid_vfm(void)
> +{
> +	u32 eax   = cpuid_eax(1);
> +	u32 fam   = x86_family(eax);
> +	u32 model = x86_model(eax);
> +
> +	return IFM(fam, model);
> +}
> +
> +u32 intel_get_platform_id(void)
> +{
> +	unsigned int val[2];
> +
> +	if (x86_hypervisor_present)
> +		return 0;
> +
> +	/*
> +	 * This can be called early. Use CPUID directly instead of
> +	 * relying on cpuinfo_x86 which may not be fully initialized.
> +	 * The PII does not have MSR_IA32_PLATFORM_ID. Everything
> +	 * before _it_ has no microcode (for Linux at least).
> +	 */
> +	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
> +		return 0;
> +
> +	/* get processor flags from MSR 0x17 */
> +	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
> +
> +	return (val[1] >> 18) & 7;
> +}
> +
>  static void early_init_intel(struct cpuinfo_x86 *c)
>  {
>  	u64 misc_enable;
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index a4c0a0cf928b..f55ff81682e5 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -120,42 +120,6 @@ static inline unsigned int exttable_size(struct extended_sigtable *et)
>  	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
>  }
>  
> -
> -/*
> - * Use CPUID to generate a "vfm" value. Useful before cpuinfo_x86
> - * structures are populated.
> - */
> -static u32 intel_cpuid_vfm(void)
> -{
> -	u32 eax   = cpuid_eax(1);
> -	u32 fam   = x86_family(eax);
> -	u32 model = x86_model(eax);
> -
> -	return IFM(fam, model);
> -}
> -
> -u32 intel_get_platform_id(void)
> -{
> -	unsigned int val[2];
> -
> -	if (x86_hypervisor_present)
> -		return 0;
> -
> -	/*
> -	 * This can be called early. Use CPUID directly instead of
> -	 * relying on cpuinfo_x86 which may not be fully initialized.
> -	 * The PII does not have MSR_IA32_PLATFORM_ID. Everything
> -	 * before _it_ has no microcode (for Linux at least).
> -	 */
> -	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
> -		return 0;
> -
> -	/* get processor flags from MSR 0x17 */
> -	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
> -
> -	return (val[1] >> 18) & 7;
> -}
> -
>  void intel_collect_cpu_info(struct cpu_signature *sig)
>  {
>  	sig->sig = cpuid_eax(1);

