Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1C36A364;
	Tue,  1 Sep 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245096; cv=none; b=l3PgskVSFibA/lPHWQ9SU+nqhqIaRlOgoAJVBR+tpHH6DpRYHAd1AK6736XOB76k2nfjEmHLOm0d9VFFRJSGYHRHRu97EruZcstr0RT44CUWW5dJZ9VToQuI01pd8mRnuwsBetdwn7tz2trhbBz9I2plEGxiyXHfSj4QwRtyWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245096; c=relaxed/simple;
	bh=U8vUq2DpjqqWmIlTz2QJ9BYO790IlZXenRz93ip+T/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfrEvajG6ezq3ZN/rirs8fIvTeE//w5SpkMXor/MTjUXm7+d+um8VCVNZz+vRdD8SpVl+XTrORKOHs76EqMZqLVgRifBGVQ1g9udmQJBY7nnIBaJhvwhvkoo3IAg0SJ3f+SvqtoqJLuQb39xT3dc3QVf2xkV3jnWXQJUDIu6/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnj1ER1C; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnj1ER1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245094; x=1819781094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U8vUq2DpjqqWmIlTz2QJ9BYO790IlZXenRz93ip+T/k=;
  b=cnj1ER1CDDvOmtdmDnbNYGxPUfZA5QSBEHO1RkkHnhCtri0/D3P++f8w
   o1ZCxSppiNZ1YCJlmS5Uc2tcdZP+4LWM2FNkggIbP81XzurBap2uHEaC2
   GmmKySW4hKPIOEvVTdTEY++AREnVR89K5HeWAHCv8FffH0kdIchJGyfB3
   1YgMLaAVsFm/RRYoKvBnVTy7n9GhtGIzTEC0CFpw5ao0ByFpQ+uEk0sn5
   prqFsSUG6Sjl9MNTZWvSbdo83vtRU5cn/VPKHjVJlO3DCi1fG4dieGP8S
   o2y75owqn4qq+Z0hSEVh/04NtOtfmu1/3Br4iWzBO5V95bY2vpnXDYzDN
   g==;
X-CSE-ConnectionGUID: nHzUvP3nQvalTIlLymBmFw==
X-CSE-MsgGUID: zQB8HpKMT3iC1VHrxAjcKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106184655"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="106184655"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:44:53 -0700
X-CSE-ConnectionGUID: EFAsMcPARg+CvkwVhzGcYw==
X-CSE-MsgGUID: wVXZeex5QAqx2e1buA7i+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="265762163"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:44:50 -0700
Date: Tue, 1 Sep 2026 09:44:47 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v3 3/4] KVM: TDX: Filter configurable CPUID bits
Message-ID: <apZ0X8J31bVCoc9E@tlindgre-MOBL1>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-4-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827031837.2863609-4-binbin.wu@linux.intel.com>

On Thu, Aug 27, 2026 at 11:18:36AM +0800, Binbin Wu wrote:
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
...
> +static u32 tdx_cfg_non_feature_mask(u32 function, u32 index, int reg)
>  {
> -	if (has_tsx(entry))
> -		clear_tsx(entry);
> +	/*
> +	 * For a leaf/subleaf/register that will never be repurposed to hold
> +	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
> +	 * leave the TDX module's CPUID config mask intact.
> +	 */
> +	switch (function) {
> +	case 1:
> +		if (reg == CPUID_EAX || reg == CPUID_EBX)
> +			return TDX_CPUID_ALL_ALLOWED_MASK;
> +		return 0;
> +	case 4:
> +	case 0x18:
> +	case 0x1f:
> +		return TDX_CPUID_ALL_ALLOWED_MASK;
> +	case 0x24:
> +		if (index == 0 && reg == CPUID_EBX)
> +			return GENMASK_U32(7, 0);
> +		return 0;
> +	case 0x80000008:
> +		if (reg == CPUID_EAX)
> +			return TDX_CPUID_ALL_ALLOWED_MASK;
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}

How about rename the above to something simpler like tdx_get_cpuid_bits()?
Sorry I don't have anything better to suggest for naming.

> +static u32 tdx_cfg_feature_mask(u32 function, u32 index, int reg)
> +{
> +	for (int i = 0; i < NR_KVM_CPU_CAPS; i++) {
> +		const struct cpuid_reg *cpuid = &reverse_cpuid[i];
> +
> +		if (!cpuid->function)
> +			continue;
> +
> +		if (cpuid->function == function && cpuid->index == index &&
> +		    cpuid->reg == reg)
> +			return tdx_cpu_cfg_caps[i];
> +	}
> +
> +	return 0;
>  }

And then the above to tdx_get_cpuid_feature_bits()?
  
> -static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
> +static u32 tdx_get_allowed_cfg_cpuid_mask(u32 function, u32 index, int reg)
>  {
> -	return has_tsx(entry) || has_waitpkg(entry);
> +	u32 non_feature_mask = tdx_cfg_non_feature_mask(function, index, reg);
> +
> +	if (non_feature_mask == TDX_CPUID_ALL_ALLOWED_MASK)
> +		return TDX_CPUID_ALL_ALLOWED_MASK;
> +
> +	/*
> +	 * It's possible that a CPUID register contains both feature and
> +	 * non-feature bits.
> +	 */
> +	return non_feature_mask | tdx_cfg_feature_mask(function, index, reg);
>  }

And then tdx_get_cpuid_mask()?
