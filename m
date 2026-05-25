Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF45347516;
	Mon, 25 May 2026 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696364; cv=none; b=tmE0sItJ9/EY/qWeONNKwPK7fRTGRmVFDjEbxCJEH8qc8jvLOY6BqFioqni7dbFFiRxsvnB/mC2WRqoXHBiivdFBmTPSy39xHnqk++5pHOLMU2KBHOmfPJxImEIy8+CBLgij6j0ooe+74kAmBQt0UgBu3Z4Yv1fecCmEFXPGp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696364; c=relaxed/simple;
	bh=WuQyD1hPuF84erucIgGd6RKPm8N1Vpgg5Y/iU5DXlV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8DUjNAgVU3JP+ffCuscb73YtZ5BX82Vks5/BbIy8ri4ijpywgcSIz+j2EgUl0W7VhXp+JXzz6/g9odNGOvNhuTXeOLNH7MoI5KJVquU29UV2TqIV+2jiIHpix1J/eM4oHR3qdntH76onlHnxzxD+nwZCt/AYYNBbbIrjWel4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzO7a+4I; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzO7a+4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779696363; x=1811232363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WuQyD1hPuF84erucIgGd6RKPm8N1Vpgg5Y/iU5DXlV0=;
  b=YzO7a+4I88Rra5FgsmanBweKvR1zMvRHWsODnvM7lMUO4GAH5dPxZSaX
   ECxlC9iq7WxxZ/KMaoV4pnm0DVC5pKe3LcpMZNqnEOJy/O4F33yh8cO8O
   v9TW3R4GxD5Fy4TFQwHPk2DOSHKuzNnAg7dMkdG2gf6JKvOPdqW8sk0xs
   2AbYbiEmJL+wmC+7Zqhj5zScfl4xvzdi/OChkYKJHHcI7WGIKscXgQ9Ds
   Y56yyJHNbRuMGpI6yWOSyA2XVKRPhPhRDqqGWl3vgcgOQWlV7QhlA8/8+
   scJf6EtYi+A382Z4HwdiuLISvz/12Uwr6XLKWikFRwHK3kvlmD0y3oKVV
   g==;
X-CSE-ConnectionGUID: XvorEweBRrqoGKMPQOPNhQ==
X-CSE-MsgGUID: G8Qlk/oYRAeUeoGpLm+K3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="79547764"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="79547764"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:06:02 -0700
X-CSE-ConnectionGUID: YQ1sbaohS/+jh2A7czFVuQ==
X-CSE-MsgGUID: vLddJW+4SUeV+zZyTBWEsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="235179307"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.44]) ([10.239.158.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:05:59 -0700
Message-ID: <8590964e-e6aa-4300-8ef7-7f53d1399780@intel.com>
Date: Mon, 25 May 2026 16:05:57 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260522034128.3144354-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 11:41 AM, Xu Yilun wrote:
> The detailed initialization flow for TDX Module Extensions has been
> fully implemented. Enable the flow after basic TDX Module
> initialization.
> 
> Theoretically, the Extensions doesn't need to be enabled right after
> basic TDX initialization. It could be enabled right before the first
> Extension SEAMCALL is issued. That would save or postpone memory usage.
> But it isn't worth the complexity, the needs for the Extensions are vast
> but the savings are little for a typical TDX capable system (about
> 0.001% of memory). So the Linux decision is to just enable it along with
> the basic TDX.



> Note that the Extensions initialization flow will still not start if no
> add-on features require Extensions. The enabling of add-on features will
> be in later patches. Until then, the system hasn't consumed extra memory.

based on the above, how about putting this patch before patch 02 and 03? 
so that we can eliminate the churn of add "__init" and the 
"__maybe_unused " in patch 02.

To be more safer, we can even make the code as

static bool tdx_supports_extension(void)
{
	/* To be enabled when kernel is ready. */
	return false;
}

static __init int init_tdx_ext(void)
{
	if (!tdx_supports_extension())
		return 0;

	/* No feature requires TDX Module Extensions. */
	if (!tdx_sysinfo.ext.ext_required)
		return 0;
}

and after all the pieces implemented, we can change 
tdx_supports_extension() to

static bool tdx_supports_extension(void)
{
	/* To be enabled when kernel is ready. */
	return !!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT);
}

> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index ff2b96c20d2b..dad5ec642723 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1180,7 +1180,7 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>   	return 0;
>   }
>   
> -static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> +static __init void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
>   {
>   	u64 *entries = page_to_virt(root);
>   	int i;
> @@ -1193,7 +1193,7 @@ static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
>   #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
>   #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
>   
> -static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
> +static __init u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
>   {
>   	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
>   	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(root)) |
> @@ -1201,7 +1201,7 @@ static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
>   }
>   
>   /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
> -static int tdx_ext_init(void)
> +static __init int tdx_ext_init(void)
>   {
>   	struct tdx_module_args args = {};
>   	u64 r;
> @@ -1216,7 +1216,7 @@ static int tdx_ext_init(void)
>   	return 0;
>   }
>   
> -static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
> +static __init int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
>   {
>   	struct tdx_module_args args = {
>   		.rcx = to_hpa_list_info(root, nr_pages),
> @@ -1240,7 +1240,7 @@ static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
>   	return 0;
>   }
>   
> -static int tdx_ext_mem_setup(void)
> +static __init int tdx_ext_mem_setup(void)
>   {
>   	unsigned int nr_pages;
>   	struct page *page;
> @@ -1301,7 +1301,7 @@ static int tdx_ext_mem_setup(void)
>   	return ret;
>   }
>   
> -static int __maybe_unused init_tdx_ext(void)
> +static __init int init_tdx_ext(void)
>   {
>   	int ret;
>   
> @@ -1373,6 +1373,10 @@ static __init int init_tdx_module(void)
>   	if (ret)
>   		goto err_reset_pamts;
>   
> +	ret = init_tdx_ext();
> +	if (ret)
> +		goto err_reset_pamts;
> +
>   	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
>   
>   out_put_tdxmem:

