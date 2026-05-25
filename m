Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64D3DC4C0;
	Mon, 25 May 2026 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699507; cv=none; b=qEBNSynDDcDC0nEO6v1cxxisphF7OOKRcqQgKiUuKOaQtIp8hL3KkRpGYBOwIaHDHhdKDlKe4FgsH1z6VRXSrgjLxPbT70mWrMDq1JHGByN6J4m9Iq2PiOOS8kTCDV/7QX9uGSGrBPij1LezsxKjlVDilKT7vYVVr6IuqgZjNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699507; c=relaxed/simple;
	bh=ZmqdEN18LFX2BjdvqVD2+BC/V/zCH9QODJMMa/OyKtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxzEVJ+bWnnMKn1oTZTlJ7E6vjqzkkJ/hXe6E+LhUch6T8Vx+rgY0efpTb0NTyXPSXRaxQ/QCVk1+X44rleIOLvZIa3XDc415vmnZT8AmlNo1V0R5mH8n1JaCeOISBPlW8xFN0ZxFMp/CYR9edIeQUWWbSaUznvDmtU+3hYpPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9XVOtum; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9XVOtum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779699505; x=1811235505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZmqdEN18LFX2BjdvqVD2+BC/V/zCH9QODJMMa/OyKtA=;
  b=i9XVOtumpGEzRDDvzp89RKyqD8p9M0PXhHp8UTJ8eaoxPKQwLo+98nal
   /ZuLfAVw6zOeNqbWHA9ZMKyhWVhef9Bb32QGDamrPXR+J4AAB3RiSofWg
   +hXmBgTdXbgXmakT0w/0Jqkgq4wt6ZuoVhS2WVjiUxtip8H8W8Jp2HOOj
   ++ZVcJPuPHmYpTUo8P6YI9F8Pj0M9UWwCcMHvtxh2hsmMChwMkUweJiZU
   WZLVs0Yvze4L9HtDY0FF7jgCQWHP4cq8eWTjA6A4z28FLIjZemWcrcgu/
   +LAtinTMgHTejE5McLdJcaEicQC4hbWkGWtBjl4zfQAIF2a7obc8rdvzY
   A==;
X-CSE-ConnectionGUID: 7GanfyOaRGq5vXYBhYvONQ==
X-CSE-MsgGUID: RjtolvXTS7GNEfuacvutPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91209696"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91209696"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:58:24 -0700
X-CSE-ConnectionGUID: Fx0HRCeoTWeFiOLt8pdYSQ==
X-CSE-MsgGUID: Fjf8dzmcTSmWtjla7ZunJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="240709685"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.44]) ([10.239.158.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:58:21 -0700
Message-ID: <7f2662fc-6d35-4e40-9913-35834394ef4f@intel.com>
Date: Mon, 25 May 2026 16:58:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] x86/virt/tdx: Make TDX Module initialize Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-4-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260522034128.3144354-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 11:41 AM, Xu Yilun wrote:
> After providing all required memory to TDX Module, initialize TDX
> Module Extensions via TDH.EXT.INIT, so Extension-SEAMCALLs can be used.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   arch/x86/virt/vmx/tdx/tdx.h |  1 +
>   arch/x86/virt/vmx/tdx/tdx.c | 24 +++++++++++++++++++++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 2335f88bbb10..c5bffd118145 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -46,6 +46,7 @@
>   #define TDH_PHYMEM_PAGE_WBINVD		41
>   #define TDH_VP_WR			43
>   #define TDH_SYS_CONFIG			45
> +#define TDH_EXT_INIT			60
>   #define TDH_EXT_MEM_ADD			61
>   #define TDH_SYS_DISABLE			69
>   
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 622399d8da68..ff2b96c20d2b 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1200,6 +1200,22 @@ static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
>   	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
>   }
>   
> +/* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
> +static int tdx_ext_init(void)
> +{
> +	struct tdx_module_args args = {};
> +	u64 r;
> +
> +	do {
> +		r = seamcall(TDH_EXT_INIT, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r != TDX_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
>   {
>   	struct tdx_module_args args = {
> @@ -1287,6 +1303,8 @@ static int tdx_ext_mem_setup(void)
>   
>   static int __maybe_unused init_tdx_ext(void)
>   {
> +	int ret;
> +
>   	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
>   		return 0;
>   
> @@ -1294,7 +1312,11 @@ static int __maybe_unused init_tdx_ext(void)
>   	if (!tdx_sysinfo.ext.ext_required)
>   		return 0;
>   
> -	return tdx_ext_mem_setup();
> +	ret = tdx_ext_mem_setup();
> +	if (ret)
> +		return ret;
> +
> +	return tdx_ext_init();
>   }
>   
>   static __init int init_tdx_module(void)

