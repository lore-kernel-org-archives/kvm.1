Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C69490BF7
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327098; cv=none; b=igOX1j6s0oGCesrwL6ybwmOjfE2RUnFQIw1l4ZgoFpKtgnQuptdtY3ePF+V/TpH21LgdtdU0WrXsDZMsIT9eu5hV6rmVUEClGT+cHs7kX/n9N9RHqONozwjMm4nLNnfGzEYyTZWlx9Ri0dZiRpR5FTYQSCaz3JkLWhR9se437Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327098; c=relaxed/simple;
	bh=OsoLph1SijqA88dsgWO+jw8WttozWoXak+82IDO6mB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7ohU8Ova5fuoOR2QybcEqCMsDuRE6OxPfjSD19kRLUPCEZCNenpWCryNsLXRx4eCifR53ZqfMugFBOX3QALwy+9OgQFgrYI2wrolCL7ZLhEOOh2IUpSDrMPbD8yBFYwG5WBFL0lViJRXrLDgrgB3NwXLMn/z38rlxgMOe8Dlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su3TAQCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su3TAQCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3A01F000E9;
	Fri, 21 Aug 2026 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787327095;
	bh=0oH24vlTUI28ao9iU7cZQFNEJUxjn94w+7g2DRUlgUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Su3TAQCvfiajZNjcH6P8xj/NHwjODW43aex9Q7f8RkGHmtaAGADuAdptHRfBeaaTO
	 WGBBaOZeHDaLnRgWbMyekcGLTqRKMN3BxQdBjLYOHTcqfthkbYljAKm07fdBNQgXnJ
	 2JB2/zau509YnDTuLIfiCEgAkXRT5uEUDPIPOS4zghMykDAKrin4aZ+Pzf9uRL8hpn
	 YiiQkXUCojYg+PU4+sBySKxCHovdXSmE1jc7gw9eYxJKPLT9jYmggvddw/3AqzODCS
	 iYkSuhRVwJk+QagobriSjSGl4jTm4n0nwJnrRwpfuqdjO/+tfhIzOWfEXVqB6EkGw5
	 I9tGFsi9He/xg==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.ams.internal (Postfix) with ESMTP id C0C111980058;
	Fri, 21 Aug 2026 11:44:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Aug 2026 11:44:53 -0400
X-ME-Sender: <xms:cnKIavpQZKUhh2d9UmkWVr92DXNdWnq7s_HNxzgpC_n-nm5TTtFshw>
    <xme:cnKIao63611Bd1vOBAjgB4-IsRfM2FyaVcvK7WZY0W8fM7K5CVe8Mvuv6_j09GnnX
    27Kz1LDFdjBkpgkxiy7Q2LsBpolYtbnuZraRH18NhzMAgra73Wk86Mr>
X-ME-Received: <xmr:cnKIaoZQj11Uyc2gnbvUdohc_wQgRcREOyydMnDTnk6SnZ7dhjo7rq4A0PY>
X-ME-Proxy-Cause: dmFkZTFJCOZq+l9Jwl+NmtE/amVHIo/1yhQySBmIRev8CL343wxTKvuNnWPxevjkYdKloI
    y9w+Zy5rMdzuA9kIvfHxpnqoq0f96RhwhDKbCK63aGG+zG81f9P3svoES+0SDbc6NIbZjy
    858XvLuYJeLCHmcOgSdmnyIrblHCYuK7l7CFSs344+Xe9ccZfgdOBe3VbyINydkXyklEEq
    k6OBmOH/ZBGbKq9ga/BbfZEC06CJiOiNgGCpi5yMco4RYzjSiXvidj8lRWynvvMJ18TsbK
    tURakxBI5/tMLo35ODGt0lc0vBbvsYzmyErw9oJ+x4iq5EMZG3rM21+bXr3apD9nzR3ubp
    pdlnt/2sg9xQdm0Rg+qpQHrLPo77VOVb/hrv1VRIWdik0HSqUlNRMNV0GqdTcO702yzrpo
    6Y/VGihtbJeczAxSRRlaRdTHmrLNwI/QsaEgo2V4Tg/n2S7eL2Ry03xvppF1tJ2kUQpCVY
    Hrxr2/ozLgNQctarrHfN0X4tG7R1vyv4dgLkFoHY1dPYwXKAQEPTH8axzbppy/XZtFxbFB
    u2Q2kYm17xPfjCfRzPbz7Th3sW7z/LDs0G47yRi/8dnf7kjzOpumaUSEMBfOjhegCg7Wx4
    6/iMD6sU5gjb6IIMDC2XGFUQgAD6VyRWWZvBir8nO7fMiyIGzxwjUslx7e8A
X-ME-Proxy: <xmx:cnKIatrl1qPzWL_ZEZMjTqcmf3AnI10YOycGpDc3_fAjuOhJtZNg_g>
    <xmx:cnKIah5mPsNMnoUY8Krbw7yKsxG1Bc1ISBsnj3gwRVpDQWtmZkWkzQ>
    <xmx:cnKIaqSNN3f_hmCuNTpWLb0eck4PqeqGjaQUu-an241qUAufJMyLLw>
    <xmx:cnKIah2tyaMqDYUzm1SABvkhMtZtr3Mjv1ZLrK2kfCLW648RA2bteg>
    <xmx:cnKIah4Ljh4G7-Mtuds6X6XF1WC_5A_YZ8hq51Z-79Gtgtpg9c-t1GF0>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 11:44:49 -0400 (EDT)
Date: Fri, 21 Aug 2026 16:44:48 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, peter.fang@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com, 
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/virt/tdx: Add extra memory to TDX module for the
 extensions
Message-ID: <aohvlMO7ehqcVW96@thinkstation>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821032920.256225-5-yilun.xu@linux.intel.com>

On Fri, Aug 21, 2026 at 11:29:18AM +0800, Xu Yilun wrote:
> TDX module extensions need memory for their own internal state and data
> to serve SEAMCALL leaves. The TDX architecture implements the extensions
> in such a way that they use the memory outside of SEAM range, so the
> kernel should add the memory upfront at initialization time.
> 
> Introduce a new memory adding process backed by a new SEAMCALL leaf
> TDH.EXT.MEM.ADD. The kernel queries TDX module how much memory needed,
> allocates it, add it to the module, and never gets it back.
> 
> The TDX module accepts the memory in the form of a PFN array. This array
> is passed via a single 64-bit SEAMCALL leaf parameter, which encodes two
> values: the PFN of the container page holding the array, and the number
> of entries in the array. Create a helper to encode this format and name
> it after the TDX module term: HPA_LIST_INFO.

The array entries are physical addresses, not PFNs. HPA_LIST_INFO encodes
a PFN, the array does not.

> TDX module extensions consume tens of megabytes memory that will never
> be returned to host. Use contiguous page allocation to isolate these
> large blocks entirely, avoiding permanent memory fragmentation and buddy
> allocator efficiency loss. Print the allocation amount on TDX module
> extensions initialization for visibility.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
> v1:
>  - Fix return value for SEAMCALL helpers (Chao)
>  - Print SEAMCALL error code for SEAMCALL helpers (Xiaoyao)
>  - Rename local vars to make the ext memory adding loop clear (Rick)
>  - Remove input parameters for tdx_ext_mem_setup() (Kevin)
>  - Add a Macro for tdh_hpa_list size.
>  - Change the SEAMALL helper parameter type,
>    struct page *hpa_list => struct tdx_hpa_list *hpa_list
>  - changelog & code comments
> ---
>  arch/x86/include/asm/tdx_global_metadata.h  |   1 +
>  arch/x86/virt/vmx/tdx/tdx.h                 |   1 +
>  arch/x86/virt/vmx/tdx/tdx.c                 | 118 +++++++++++++++++++-
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c |   6 +
>  4 files changed, 123 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index fe3fe91de71f..43b8761c0854 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -45,6 +45,7 @@ struct tdx_sys_info_handoff {
>  };
>  
>  struct tdx_sys_info_ext {
> +	u32 memory_pool_required_pages;
>  	bool ext_required;
>  };
>  
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 63e3acfb5d0c..52888424fe7d 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -48,6 +48,7 @@
>  #define TDH_SYS_CONFIG			45
>  #define TDH_SYS_SHUTDOWN		52
>  #define TDH_SYS_UPDATE			53
> +#define TDH_EXT_MEM_ADD			61
>  #define TDH_SYS_DISABLE			69
>  
>  /* TDX page types */
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index a0c370894c0b..8c2fdaf0b8c0 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1175,6 +1175,120 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>  	return 0;
>  }
>  
> +#define TDX_HPA_LIST_MAX_NR_PAGES	(PAGE_SIZE / sizeof(u64))
> +
> +struct tdx_hpa_list {
> +	u64 phys[TDX_HPA_LIST_MAX_NR_PAGES];
> +};
> +
> +static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);
> +
> +#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
> +#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
> +#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
> +
> +static __init u64 to_hpa_list_info(struct tdx_hpa_list *hpa_list,
> +				   unsigned int nr_pages)
> +{
> +	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> +	       FIELD_PREP(HPA_LIST_INFO_PFN, PFN_DOWN(__pa(hpa_list))) |
> +	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
> +}
> +
> +static __init int tdx_ext_mem_add(struct tdx_hpa_list *hpa_list,
> +				  unsigned int nr_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = to_hpa_list_info(hpa_list, nr_pages),
> +	};
> +	u64 ret;
> +
> +	do {
> +		/*
> +		 * The TDX module overwrites RCX to track progress when this
> +		 * SEAMCALL leaf is interrupted. Use seamcall_ret() to save and
> +		 * pass the updated value back on retry.
> +		 */
> +		ret = seamcall_ret(TDH_EXT_MEM_ADD, &args);
> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (ret != TDX_SUCCESS) {
> +		pr_err("TDH.EXT.MEM.ADD failed: 0x%016llx\n", ret);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static __init int tdx_ext_mem_setup(void)
> +{
> +	unsigned int required_pages = tdx_sysinfo.ext.memory_pool_required_pages;
> +	struct tdx_hpa_list *hpa_list;
> +	unsigned int added_pages;
> +	struct page *page;
> +	int ret;
> +
> +	/*
> +	 * TDX module uses the metadata memory_pool_required_pages to indicate
> +	 * how much memory is still needed. This value decreases each time
> +	 * memory is added via TDH.EXT.MEM.ADD.
> +	 *
> +	 * On first time initialization, a value of 0 before any memory is
> +	 * added is unusual. But host makes no assumptions. Skip the memory
> +	 * setup and let subsequent steps catch any actual errors.
> +	 */
> +	if (!required_pages)
> +		return 0;
> +
> +	hpa_list = kzalloc_obj(*hpa_list);
> +	if (!hpa_list)
> +		return -ENOMEM;

to_hpa_list_info() expects hpa_list to be page-aligned. It happens to
work with kmalloc for PAGE_SIZE allocation.

Maybe it is better to allocate it with buddy allocator instead?

> +
> +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> +				  &node_online_map);

Why contiguous? TDH.EXT.MEM.ADD takes a list of page addresses and the loop
below writes every one of them out separately.

alloc_pages_bulk() fits the chunking that is already here, and a short
return can be handled per chunk. alloc_contig_pages() isolates and migrates
to get its range and fails TDX init outright when it cannot find one. PAMT
needs it because the TDMR ABI describes each PAMT as base+size. This does
not.

> +	if (!page) {
> +		ret = -ENOMEM;
> +		goto out_free_hpa_list;
> +	}
> +
> +	added_pages = 0;
> +	while (added_pages < required_pages) {
> +		unsigned int chunk_pages = min(required_pages - added_pages,
> +					       TDX_HPA_LIST_MAX_NR_PAGES);
> +		struct page *chunk = page + added_pages;
> +		unsigned int i;
> +
> +		for (i = 0; i < chunk_pages; i++)
> +			hpa_list->phys[i] = page_to_phys(chunk + i);
> +
> +		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> +		if (ret) {
> +			/*
> +			 * This SEAMCALL leaf shouldn't fail, and if it does,
> +			 * things are broken enough that complex error handling
> +			 * isn't worth it. Intentionally leak all pages,
> +			 * including un-added pages.
> +			 */
> +			WARN(1, "Fatal: TDX module rejected memory for extensions, stranded all pages\n");
> +			break;

It supposed to be
			goto out_free_hpa_list;

No?


> +		}
> +
> +		added_pages += chunk_pages;
> +	}
> +
> +	/*
> +	 * Memory for TDX module extensions is never reclaimed and can be tens
> +	 * of megabytes. Print the amount so users know the cost.
> +	 */
> +	pr_info("%lu KB consumed for TDX module extensions\n",
> +		required_pages * PAGE_SIZE / 1024);
> +
> +out_free_hpa_list:
> +	kfree(hpa_list);
> +
> +	return ret;
> +}
> +
>  static __init int init_tdx_module_extensions(void)
>  {
>  	int ret;
> @@ -1194,9 +1308,7 @@ static __init int init_tdx_module_extensions(void)
>  	if (!tdx_sysinfo.ext.ext_required)
>  		return 0;
>  
> -	/* TODO: add the extensions enabling steps here */
> -
> -	return 0;
> +	return tdx_ext_mem_setup();
>  }
>  
>  static __init int init_tdx_module(void)
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index b9e1c011a990..720cdaf76492 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -137,6 +137,12 @@ static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
>  	int ret;
>  	u64 val;
>  
> +	ret = read_sys_metadata_field(0x3100000200000000, &val);
> +	if (ret)
> +		return ret;
> +
> +	sysinfo_ext->memory_pool_required_pages = val;
> +

Why above ext_required read? Is it even valid to read it in such case?

>  	ret = read_sys_metadata_field(0x3100000000000001, &val);
>  	if (ret)
>  		return ret;
> -- 
> 2.25.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
