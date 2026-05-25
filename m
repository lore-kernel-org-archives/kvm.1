Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CA3E4C85;
	Mon, 25 May 2026 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699434; cv=none; b=GvvSnMCaUY/oOaE/BewfypRu1xpMrP+ZTRSkDvtGQjcbpttYxk6OTnDAzYJ3Bcxv6VmAvvHg3LebSROrY1qcmkXWYKLmIXe5p+LZV9Lu551EpFTwAyOZ/iEc/Ndq5hSZeWwTlV/iPsKSySOdsfJBOzyKFszz7FGT5keMcG3xF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699434; c=relaxed/simple;
	bh=FNmJkr18hkQRleN6yhR/+YbT2IAm8PbTRA+eulR9i8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+PnFqYWcjIfRCsTpm5Y0ypcuR8RMuXHMP8B8OwG9D7KpprfbBzR3eNz4zi8Wlsjhs5CYKjWOEm047PjJis5xN92iMESFnPM3dXXi1hmOQiDntH0NLac1OHo4SLdf8Zh19uo05qblYonzECnygjlEwe7zXj62ntsFjstOy6kQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9cSVrx3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9cSVrx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779699432; x=1811235432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FNmJkr18hkQRleN6yhR/+YbT2IAm8PbTRA+eulR9i8M=;
  b=L9cSVrx3TYXHJYwlevryPRd6Sxd9tSQiZniJa34Ei6tefJ2vA2XBX5ZF
   l/mYcxWiBVPyLKAk/bWxfrGCuFl2aadSz1Ab5NTP6aeQR63cZvI4ynw4y
   +DPsSyeotr1RHaqoq/NFQpM2CrUgqayKfZVqT95NFXxfpXXNlevJWAj2E
   qxKngblJTOIN8RXSiLamDe2nfBSJchx+nn0fFZ++zQv8hm9tqtKwK1Jqd
   HPYs9KqAgqKodxRzIeOPf+q/82RoM6r8Cp3hWAFKOGSMMlAvhxkf6BrdD
   fRqaQS8PcHXfaJcXfQgzGyhJY2qpSWokW3D8cKaHgY/g2gzMt4hPFw45H
   g==;
X-CSE-ConnectionGUID: xDpm5ChCTD6tbVfUneIJyw==
X-CSE-MsgGUID: QpLFOGTGQ3aVCvLV3q8AGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91209593"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91209593"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:57:05 -0700
X-CSE-ConnectionGUID: sKcvyruMTgyREcnQtfg3ZA==
X-CSE-MsgGUID: 69p7EsRgShet5KXDEee7AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="240709399"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.44]) ([10.239.158.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:57:02 -0700
Message-ID: <7139c55b-b949-415d-ab82-fca1b1cc3880@intel.com>
Date: Mon, 25 May 2026 16:56:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260522034128.3144354-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2026 11:41 AM, Xu Yilun wrote:
> TDX Module introduces a new concept called "TDX Module Extensions" to
> support long running / hard-irq preemptible flows inside. This makes TDX
> Module capable of handling complex tasks through "Extension SEAMCALLs".
> Adding more memory to TDX Module is the first step to enable Extensions.
> 
> Currently, TDX Module memory use is relatively static. But, the
> Extensions need to use memory more dynamically. While 'static' here
> means the kernel provides necessary amount of memory to TDX Module for
> its basic functionalities, 'dynamic' means extra memory is needed only
> if new add-on features are to be enabled. So add a new memory feeding
> process backed by a new SEAMCALL TDH.EXT.MEM.ADD.
> 
> The process is mostly the same as adding PAMT. The kernel queries TDX
> Module how much memory needed, allocates it, hands it over, and never
> gets it back.
> 
> TDH.EXT.MEM.ADD uses a new parameter type HPA_LIST_INFO to provide
> control (private) pages to TDX Module. This type represents a list of
> pages for TDX Module to access. It needs a 'root page' which contains
> the list of HPAs of the pages. It collapses the HPA of the root page
> and the number of valid HPAs into a 64 bit raw value for SEAMCALL
> parameters. The root page is always a medium, TDX Module never keeps
> the root page.
> 
> Introduce a tdx_clflush_hpa_list() helper to flush shared cache before
> SEAMCALL, to avoid shared cache writeback damaging these private pages.
> 
> For now, TDX Module Extensions consumes relatively large amount of
> memory (~50MB). Use contiguous page allocation to avoid permanently
> fragment too much memory. Print the allocation amount on TDX Module
> Extensions initialization for visibility.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.h |   1 +
>   arch/x86/virt/vmx/tdx/tdx.c | 118 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 119 insertions(+)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index a5eec8e3cc71..2335f88bbb10 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -46,6 +46,7 @@
>   #define TDH_PHYMEM_PAGE_WBINVD		41
>   #define TDH_VP_WR			43
>   #define TDH_SYS_CONFIG			45
> +#define TDH_EXT_MEM_ADD			61
>   #define TDH_SYS_DISABLE			69
>   
>   /*
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index c0c6281b08a5..622399d8da68 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -31,6 +31,7 @@
>   #include <linux/syscore_ops.h>
>   #include <linux/idr.h>
>   #include <linux/kvm_types.h>
> +#include <linux/bitfield.h>
>   #include <asm/page.h>
>   #include <asm/special_insns.h>
>   #include <asm/msr-index.h>
> @@ -1179,6 +1180,123 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>   	return 0;
>   }
>   
> +static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> +{
> +	u64 *entries = page_to_virt(root);
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		clflush_cache_range(__va(entries[i]), PAGE_SIZE);

Is the page flush only needed when CLFLUSH_BEFORE_ALLOC is true?

If so, it inherits the same decision to always flush as what 
tdx_clflush_page() did. Then, any chance we can use tdx_clflush_page() 
here so that we have a single central place of the comment to explain 
the kernel design decision.

> +}
> +
> +#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
> +#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
> +#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
> +
> +static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
> +{
> +	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> +	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(root)) |
> +	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
> +}
> +
> +static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = to_hpa_list_info(root, nr_pages),
> +	};
> +	u64 r;
> +
> +	tdx_clflush_hpa_list(root, nr_pages);
> +
> +	do {
> +		/*
> +		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
> +		 * override/update input parameter RCX, so the caller doesn't
> +		 * have to do manual parameter update on retry call.
> +		 */
> +		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r != TDX_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int tdx_ext_mem_setup(void)
> +{
> +	unsigned int nr_pages;
> +	struct page *page;
> +	u64 *root;
> +	unsigned int i;
> +	int ret;
> +
> +	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
> +	/*
> +	 * memory_pool_required_pages == 0 means no need to add pages,
> +	 * skip the memory setup.
> +	 */
> +	if (!nr_pages)
> +		return 0;
> +
> +	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!root)
> +		return -ENOMEM;
> +
> +	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
> +				  &node_online_map);
> +	if (!page) {
> +		ret = -ENOMEM;
> +		goto out_free_root;
> +	}
> +
> +	for (i = 0; i < nr_pages;) {
> +		unsigned int nents = min(nr_pages - i,
> +					 PAGE_SIZE / sizeof(*root));
> +		int j;
> +
> +		for (j = 0; j < nents; j++)
> +			root[j] = page_to_phys(page + i + j);
> +
> +		ret = tdx_ext_mem_add(virt_to_page(root), nents);
> +		/*
> +		 * No SEAMCALLs to reclaim the added pages. For simple error
> +		 * handling, leak all pages.
> +		 */
> +		WARN_ON_ONCE(ret);
> +		if (ret)
> +			break;
> +
> +		i += nents;
> +	}
> +
> +	/*
> +	 * Extensions memory can't be reclaimed once added, print out the
> +	 * amount, stop tracking it and free the root page, no matter success
> +	 * or failure.
> +	 */
> +	pr_info("%lu KB allocated for TDX Module Extensions\n",
> +		nr_pages * PAGE_SIZE / 1024);
> +
> +out_free_root:
> +	kfree(root);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused init_tdx_ext(void)
> +{
> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> +		return 0;
> +
> +	/* No feature requires TDX Module Extensions. */
> +	if (!tdx_sysinfo.ext.ext_required)
> +		return 0;
> +
> +	return tdx_ext_mem_setup();
> +}
> +
>   static __init int init_tdx_module(void)
>   {
>   	int ret;

