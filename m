Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6E36A008;
	Fri, 24 Jul 2026 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882571; cv=none; b=AH9dzxCqEQft8fFpOOF9S7GzuNOH4miwnLHsBZ9Ftm3/Iuv5Giq+m/y++6RAz94Kr95Lm96jNFE94DmzO7aQdxueQ1toW3PN1RwUBaw6J2lG+ByOks9mu4QL2uuLnqBxuWfMV6z6Zt9EXJxfmWDxRRKz0t9UhtJlFQkVtTIQWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882571; c=relaxed/simple;
	bh=hRSm7jiyOYfohYCrTk3ZEiRVEGIGDBaGa/v63ohX9/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S334rlh8LY/nMiDupTdWH1p7LS8dTE9jaGI/c6gc9qwfOTqk2xkrWcR5gMS2mAJvx+t+dc0daklIZqJe60BJnQrBcJ7spdc3Q6eUXe8UhSm7cQzY6cWzJ6ZpNEfOWdvfRrnxrLWGXQXb2K7WfcM74TdG5VW8TBGN1VFBhASZKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jklYGXFu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jklYGXFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784882570; x=1816418570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hRSm7jiyOYfohYCrTk3ZEiRVEGIGDBaGa/v63ohX9/M=;
  b=jklYGXFujGgRtRGSAChtG/fKy6SzFuxmRkr0O2lUtIKLKgq8KOHTo3zR
   1OXaZBgFWrdEfMNtyZ4+/OLaHsAhw85GhKNkJNTKTSGtr1ueBz2PerV5d
   ejmvWivxOezbWatt33LDOz7meRT/255M744moVLOS6PmSvE5CtN7SwNgG
   Ju0xYt7oQmq9FUrYnZMyXzxZBgiy0esfT+n3nWhYtUbta/YW/zryJFU7T
   1CHD4fgAbPnlPrwjJY10l7LmGerOMAgibSx80f+GUz5yAWt9i8pxpirBi
   E8RHMtOvoiHyduG4F+rzJfEz+JFbIFIQT/gRQaCGxNhgHBjL8EalgrXHt
   Q==;
X-CSE-ConnectionGUID: gY1UhyDSQUuHWK1GxBCx4w==
X-CSE-MsgGUID: FBv0v81sQUK2UWi8vl1nAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96139770"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="96139770"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 01:42:41 -0700
X-CSE-ConnectionGUID: mWet0KbFQkW1MgaDfRiiEQ==
X-CSE-MsgGUID: tnBE7GY9SLaS0HfMdkfIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="263629192"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 01:42:36 -0700
Message-ID: <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>
Date: Fri, 24 Jul 2026 16:42:33 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: djbw@kernel.org, kas@kernel.org, rick.p.edgecombe@intel.com,
 yilun.xu@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com,
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 dave.hansen@intel.com, dave.hansen@linux.intel.com, seanjc@google.com
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618081355.3253581-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/2026 4:13 PM, Xu Yilun wrote:
> TDX module extensions support extension SEAMCALLs that are preemptible
> and resumable, unlike normal SEAMCALLs that run to completion while
> monopolizing the CPU. 

This is not true. There are some normal (non-extension) SEAMCALLs also 
are preemptible and resumable. For example,

- TDH.PHYMEM.CACHE.WB
- TDH.SYS.DISABLE
- TDH.MEM.SEPT.ADD with version 1

(There might be more. I didn't check all.)

> This allows for higher-level API constructions,
> so better supports some add-on features that implement higher order
> security protocols.

I think we don't need to explain this? Just that some add-on features 
require the functionalities of TDX module extensions is enough?

> Add infrastructure to initialize TDX module extensions. Introduce the
> initial step of this process by detecting if the extensions are required
> by checking:
> 
>    1. If the extensions are supported via TDX_FEATURES0_EXT.
>    2. If any TDX add-on feature needs the extensions via a boolean
>       metadata field ext_required.
> 
> Currently all metadata fields are read at the very beginning of basic
> TDX initialization and stored in a global var. However, ext_required is
> only valid after the add-on feature configuration, making it
> incompatible with the existing metadata reading method.
> 
> To resolve this lifetime conflict, add a dedicated runtime metadata
> reading interface for the extensions, call it when the extensions
> initialization starts, and leave the field out of the global var. In
> this way, there is no confusion of when the metadata should be read.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/include/asm/tdx.h                  |  1 +
>   arch/x86/include/asm/tdx_global_metadata.h  |  4 ++++
>   arch/x86/virt/vmx/tdx/tdx.c                 | 25 +++++++++++++++++++++
>   arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 14 ++++++++++++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index e5a9cf656c07..5fbf89d5317c 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -35,6 +35,7 @@
>   /* Bit definitions of TDX_FEATURES0 metadata field */
>   #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
>   #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
> +#define TDX_FEATURES0_EXT		BIT_ULL(39)
>   
>   #ifndef __ASSEMBLER__
>   
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index 41150d546589..83fc657a438e 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -52,4 +52,8 @@ struct tdx_sys_info {
>   	struct tdx_sys_info_td_conf td_conf;
>   };
>   
> +struct tdx_sys_info_ext {
> +	bool ext_required;
> +};
> +
>   #endif
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 92305b5ea90d..6f3596f11d25 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1166,6 +1166,27 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>   	return 0;
>   }
>   
> +static __init int init_tdx_module_extensions(void)
> +{
> +	struct tdx_sys_info_ext sysinfo_ext;
> +	int ret;
> +
> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> +		return 0;
> +
> +	ret = get_tdx_sys_info_ext(&sysinfo_ext);
> +	if (ret)
> +		return ret;
> +
> +	/* Skip if no feature requires TDX module extensions. */
> +	if (!sysinfo_ext.ext_required)
> +		return 0;

There was the discussion around it in [1]. I agree with the point to 
make kernel code simple. But it requires change/clarification from TDX 
spec, right? So will TDX spec change?

If so, you would need to mention it somewhere.

[1] 
https://lore.kernel.org/all/9c00b87b7b69470ad1e7b1d2788414002b9a1c77.camel@intel.com/

> +	/* TODO: add the extensions enabling steps here */
> +
> +	return 0;
> +}
> +
>   static __init int init_tdx_module(void)
>   {
>   	int ret;
> @@ -1220,6 +1241,10 @@ static __init int init_tdx_module(void)
>   	if (ret)
>   		goto err_reset_pamts;
>   
> +	ret = init_tdx_module_extensions();
> +	if (ret)
> +		goto err_reset_pamts;
> +
>   	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
>   
>   out_put_tdxmem:
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index e49c300f23d4..b9e1c011a990 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -131,3 +131,17 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>   
>   	return ret;
>   }
> +
> +static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> +{
> +	int ret;
> +	u64 val;
> +
> +	ret = read_sys_metadata_field(0x3100000000000001, &val);
> +	if (ret)
> +		return ret;
> +
> +	sysinfo_ext->ext_required = val;
> +
> +	return 0;
> +}

