Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C61BD9C9;
	Thu, 24 Sep 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232249; cv=none; b=gqA/9xp9i+G2bQn7u/y5mzPu3Txp2PlgqR1WMXteShYYhl9YBTn3ti8wT7DH/R5Z775Hn1/W8npOfKJ5zER6kWIujlCojPQYfdCxsPC5Jkn53wHkIr3wXJ2tQGKUXYdhkMGndyctiB2T4Vc0+ziHNZ/7/5Q5ELfcBaoRaAxngdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232249; c=relaxed/simple;
	bh=oc1PuZ56didSF2FPZETYBwHsx2xqSZ5yvZY8vGFT8EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q46+pz1o1v1vYpzk1R3OCMfyAIXKhbHW8px2c9Z/AM4Ildys5DDWER0kRPvCgVthbKsIYZkPnEmckeE4T3IJsIxTSqSTugMwLjzWX/T9tH4+VWCCFNZtLI+qWkyzT7e+ht+3tSnOt/HMetbqUQVZl3oFYxmDJLtKbWlfDLs0myk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQL8ZG0O; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQL8ZG0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232248; x=1821768248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oc1PuZ56didSF2FPZETYBwHsx2xqSZ5yvZY8vGFT8EY=;
  b=SQL8ZG0OYBfrCSUGF64ZYe8+h8ZSxeyxWf3IJOz0qncx+7kGtRVMMLs6
   A3GS1qWDbU+WF1HFrFEC5r3M4kB7GXZZG9AU1nWM6IenQOoMZSGkelb8q
   Tv6+VCEdQ+iYCYhou4l6fOL1ooyZKPp2KDUjhGqA+yYovDviGnhoBidnd
   mdkjgWlTnddf21Ti8AP8FnnTQucQbhtxBeh7t13ShBOrDAv0nelnvc6S3
   jlU/VILstbCSrdKn7Teg0YaI2IgbXKbfq1sBjB9J7YYekRCTNcUr7b/RD
   8daNHyw6iNLxvTyVW/G3UgBCduOpY1evZUHLLpVAypKAXrI/nvDQVmtBo
   Q==;
X-CSE-ConnectionGUID: daZlu9oBQJSmUxL/gpNacg==
X-CSE-MsgGUID: 3HQUvithRt2XONVK5faOlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93884820"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93884820"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:44:08 -0700
X-CSE-ConnectionGUID: Xy/NdsjaRAm6c79+y8JZag==
X-CSE-MsgGUID: 43RQuU5cSoCsAkxokImRAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="5042744"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:44:04 -0700
Message-ID: <8c54782e-8c6c-4503-8379-d1ab4a181743@intel.com>
Date: Thu, 24 Sep 2026 14:44:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com,
 tony.lindgren@linux.intel.com, kishen.maloor@intel.com, dedekind1@gmail.com
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-3-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260917072548.2314491-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/2026 3:25 PM, Binbin Wu wrote:
> Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
> directly configurable CPUID feature bits, even though KVM doesn't support
> MSR_IA32_CORE_CAPS for TDX guests, to accommodate the legacy TDX module
> definition and userspace's stale knowledge of it.
> 
> Older TDX specifications define the CORE_CAPABILITIES CPUID bit as
> fixed-1, so userspace may expect the bit to be enabled for TDs.  #VE
> reduction turns it into a directly configurable bit, so leaving it out of
> the allowlist would make the bit impossible to enable once KVM starts
> validating userspace's CPUID input, i.e. would be a surprising behavior
> change for such userspace.
> 
> Reporting CORE_CAPABILITIES as directly configurable also lets userspace
> detect that the bit is no longer fixed-1, and thus correct its stale
> knowledge.
> 
> Keep MSR_IA32_CORE_CAPS unsupported for TDs, as no existing TDX user needs
> guest access to the MSR.
> 
> Note, CORE_CAPABILITIES is the only bit that is unsupported by KVM *and*
> changed from fixed-1 to directly configurable by #VE reduction, and no
> further #VE reductions are expected.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> v4:
> - Add #VE reduction related background to the changelog. (Kishen)
> - Add RB from Tony.
> 
> v3:
> - Drop the code for MSR_IA32_CORE_CAPS access.
> ---
>  arch/x86/kvm/vmx/tdx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 2b51a85c998e8..b34afc52b714e 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -165,6 +165,13 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
>  		TDX_CFG_F(AVX512_VP2INTERSECT),
>  		TDX_CFG_F(SERIALIZE),
>  		TDX_CFG_F(TSXLDTRK),
> +		/*
> +		 * KVM doesn't support MSR_IA32_CORE_CAPS, but older TDX specs
> +		 * define this bit as fixed-1.  Report it as configurable to
> +		 * accommodate the legacy TDX module definition, and to let
> +		 * userspace detect that the bit is no longer fixed-1.
> +		 */
> +		TDX_CFG_EXTRA_F(CORE_CAPABILITIES),
>  	);
>  
>  	tdx_cpu_cfg_cap_init(CPUID_7_1_EAX,

