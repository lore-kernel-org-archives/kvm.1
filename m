Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD0340A47;
	Mon, 25 May 2026 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779686264; cv=none; b=XblfAQHfdgonIsroAIBDgJE2KM+R4Bxb7bH5YI1+M+LBRclELpLQHLwlDNbe3nxZFAQ/kLAgY4UTjTIMqHkLOsv76pAWrtWBj8fQXxlYMEoJyvj2mXAQdkmQKKcO6bDZUTCdYfvD/M/0JFAql3NDggGExHzB57A4BTbhTnSbJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779686264; c=relaxed/simple;
	bh=2JJ0cFDif1e+mCqups5FCWkp2Ud2RUi9EoKvpd6rEfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxFjjuow2wNoCTlRIdO3z4Yxdn+CQnb44c0KiPUWeWdWPkrLVyxbWSmP1VbS19U6NsqxCnBksiyaj7J0V1Ni/i8CSm2wDdUlBZgPCWsj/uoYJHHmEQA1kvM6n0KS88L4aEdcDhkiFo7+hPSEMCV6th+4ZpvYpWqanU/x9sGWGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COLeuQur; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COLeuQur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779686263; x=1811222263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2JJ0cFDif1e+mCqups5FCWkp2Ud2RUi9EoKvpd6rEfg=;
  b=COLeuQurwlICn6d5YsmCrA7fhzTXflB3RhuNArh3Id6QLxaEdiRzyUOD
   /N6Ix8fZBJfZBAS5jMQJQdylDsGwLtQQdr7NlnFtMfaRU0SS6dqGCWThA
   +h36qGc3zwRNn1Q3aC3VjdF2frHgqAPDEZ3jj04dQHJjNRvIJDr8epcGd
   FYIUR45CT/Muz499ynZlLmlt948pB4kOuATEJiov0dEWiLGTrZB36Q79S
   7DEWVjNR8savwoc60Zl+KF+jQDKM5b8EOt546M78KWVC+3dGU07+V9LqT
   wVQdW925ZFZIOssKVmRO7W6VM5A+X1ZswVL0LIbox33WRMszqWAp9frxG
   Q==;
X-CSE-ConnectionGUID: w6c1KXaETXuh0RKglqX0bA==
X-CSE-MsgGUID: p4ORsl4uSQ+MpQbJRYHLJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91892746"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91892746"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 22:17:42 -0700
X-CSE-ConnectionGUID: 1iQ4TVDMRN25AtYbIXRFfw==
X-CSE-MsgGUID: vQhmM6fTRI6NINMsfY3fpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="265341647"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 22:17:38 -0700
Date: Mon, 25 May 2026 08:17:35 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
Message-ID: <ahPbb1Ws9hBruJ2d@tlindgre-MOBL1>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522034128.3144354-16-yilun.xu@linux.intel.com>

On Fri, May 22, 2026 at 11:41:28AM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> TDX Module updates global metadata when add-on features are enabled.
> Host should update the cached tdx_sysinfo to reflect these changes.

This should be made clearer IMO. How about mention that get_tdx_sys_info()
needs to get called again to reload the TDX module global metadata?
 
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1049,6 +1049,7 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
>  static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
>  				    u64 global_keyid)
>  {
> +	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
>  	struct tdx_module_args args = {};
>  	u64 *tdmr_pa_array;
>  	size_t array_sz;
> @@ -1074,8 +1075,22 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
>  	args.rcx = __pa(tdmr_pa_array);
>  	args.rdx = tdmr_list->nr_consumed_tdmrs;
>  	args.r8 = global_keyid;
> -	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
>  
> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE) {
> +		args.r9 |= TDX_FEATURES0_QUOTE;
> +		/* These parameters require version >= 1 */
> +		seamcall_fn = TDH_SYS_CONFIG;
> +	}
> +
> +	ret = seamcall_prerr(seamcall_fn, &args);
> +	if (ret)
> +		goto free_tdmr;
> +
> +	/* enabling TDX Quoting may change tdx_sysinfo, update it */
> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE)
> +		ret = get_tdx_sys_info(&tdx_sysinfo);

The comment above helps, but the change in the handling will be easy to
miss.

> +free_tdmr:
>  	/* Free the array as it is not required anymore. */
>  	kfree(tdmr_pa_array);
>  

So I think it would be good to also add a comment to get_tdx_sys_info()
to make it easier for folks to follow that it may get called multiple
times.

Regards,

Tony
