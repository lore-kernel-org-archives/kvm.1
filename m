Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E7433BA6;
	Thu,  6 Aug 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036667; cv=none; b=PzmqTFo/lQcOgCyFp6g5KO/eHYzdDnYqHB5738DMp936hq0xWfOLW6oxYJJF3L2MCNEXYBtzZv4y3/8SkSF3Gu3jJPbfFDpvVGb71CDVjWIm2omH1gk/DFsDsG6H0z2l7ATHpU4owCFSEqqeDS9cKzksDVF5REuVtGiiJFZ7bfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036667; c=relaxed/simple;
	bh=K1FnRBiNbYYnsYBbpxCVAZyEDLtZPc793DQLnfKoRgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGQCZ8IA1G12ysw7VLk05tUWsO9MvN0rrix4qGY+keYmrSmBoXm1PsH7tyTn7KHu8yVrLxS21SQDsJPTnwKxRu6oQwVx0R6Mom4tKkouS8abeWWn2K/ga0/dnjcnud9yPH2g/rCMSoppD8Tib0qfOyvx0EdQRogV5QAlrNp1VRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAOvmCM8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAOvmCM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786036664; x=1817572664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K1FnRBiNbYYnsYBbpxCVAZyEDLtZPc793DQLnfKoRgw=;
  b=BAOvmCM8TvE+0DFeP+wHr3KgOFjyeyT6bxQZMAdaLr01f2NGf2L9U5dq
   6eze1tLWqCtiCees7y2g9eCbOQqpVvUYMhbfdSQwf/sswVTONMHPh7RZ4
   +TGFBF3WzCYuNG4nDN1BZ4JoSltI8vog5M+gal5xvDxHeolBBAkb3+rd5
   dPyxmZRiUWFeQeOceTmze6dbJj0KUa6jTn9adn2Q52xdzyzMjjTb0r+Or
   zkcgJu3OnBGVBZTOxPd5vkjE0xcXwUtrETq5g6B8Nm+3VbR/eCBbG1x7w
   PuEBLccSAU2Qr0hfj599BRAe8Q7MkSqunvUtzZkgbuprU1akmD32lD2J5
   w==;
X-CSE-ConnectionGUID: p40Jfs11SGOpkNioI17dFw==
X-CSE-MsgGUID: wztKQl27TQCW1oXOPTcxrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86514622"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86514622"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:17:43 -0700
X-CSE-ConnectionGUID: KA7djey7SWOZTkXIQ08b0Q==
X-CSE-MsgGUID: 5Io8ssLRSk6k0Zlw6AffHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="265645903"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:17:43 -0700
Message-ID: <84deae0a-2922-4d69-9e8b-4b1b18968c6a@intel.com>
Date: Thu, 6 Aug 2026 10:17:42 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, bp@alien8.de, hpa@zytor.com,
 kas@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com,
 tglx@kernel.org, vannapurve@google.com, x86@kernel.org, chao.gao@intel.com,
 yan.y.zhao@intel.com, kai.huang@intel.com, tony.lindgren@linux.intel.com,
 binbin.wu@intel.com, sohil.mehta@intel.com
Cc: Hongyu Ning <hongyu.ning@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
 <20260806020850.1221381-4-rick.p.edgecombe@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260806020850.1221381-4-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> +/*
> + * Calculate the arg needed for operating on the DPAMT backing for
> + * a given 4KB page.
> + */
> +static u64 pamt_2mb_arg(kvm_pfn_t pfn)
> +{
> +	/* Arg value will specify a 2MB region of physical address space. */
> +	unsigned long hpa_2mb = ALIGN_DOWN(pfn << PAGE_SHIFT, PMD_SIZE);
> +
> +	return hpa_2mb | TDX_PS_2M;
> +}

/* Helper for building dynamic PAMT seamcall() arguments. */
static u64 pamt_2mb_arg(kvm_pfn_t pfn)
{
	/* Find the 2MB-wide DPAMT region for 'pfn':  */
	unsigned long hpa_2mb = ALIGN_DOWN(pfn << PAGE_SHIFT, PMD_SIZE);

	/* Talk about why the flag is needed... */
	return hpa_2mb | TDX_PS_2M;
}


> +/* Add PAMT backing for the 2MB region surrounding the given pfn. */
> +static u64 tdh_phymem_pamt_add(kvm_pfn_t pfn, struct page **pamt_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = pamt_2mb_arg(pfn),
> +		.rdx = page_to_phys(pamt_pages[0]),
> +		.r8 = page_to_phys(pamt_pages[1]),

Super nit:          ^ should be vertically aligned

> +	};
> +
> +	return seamcall(TDH_PHYMEM_PAMT_ADD, &args);
> +}
> +
> +/* Remove PAMT backing for the 2MB region surrounding the given pfn. */
> +static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = pamt_2mb_arg(pfn),
> +	};
> +	u64 ret;
> +
> +	ret = seamcall_ret(TDH_PHYMEM_PAMT_REMOVE, &args);
> +	if (ret)
> +		return ret;
> +
> +	/* Copy PAMT pages out of the struct per the TDX ABI */
> +	pamt_pages[0] = phys_to_page(args.rdx);
> +	pamt_pages[1] = phys_to_page(args.r8);
> +
> +	return 0;
> +}
> +
> +/* Allocate PAMT memory for the given page */
> +static int tdx_pamt_get(kvm_pfn_t pfn)
> +{
> +	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> +	u64 tdx_status;
> +	int ret;
> +
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return 0;
> +
> +	ret = alloc_pamt_array(pamt_pages);
> +	if (ret)
> +		return ret;
> +
> +	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
> +	if (tdx_status != TDX_SUCCESS) {
> +		ret = -EIO;
> +		goto out_free;
> +	}
> +
> +	return 0;
> +
> +out_free:
> +	free_pamt_array(pamt_pages);
> +
> +	return ret;
> +}
> +
> +/* Free PAMT memory for the given page */
> +static void tdx_pamt_put(kvm_pfn_t pfn)
> +{
> +	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
> +	u64 tdx_status;
> +
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return;
> +
> +	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
> +
> +	/*
> +	 * Don't free pamt_pages as it could hold garbage when
> +	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
> +	 * there is no risk of data corruption, but do yell loudly as
> +	 * failure indicates a kernel bug, memory is being leaked, and
> +	 * the dangling PAMT entry may cause future operations to fail.
> +	 */
> +	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
> +		return;0

Whose fault is the bug here? Probably the TDX module?

> +	free_pamt_array(pamt_pages);
> +}
> +
> +/*
> + * Return a page that can be gifted to the TDX-Module for use as a "control"
> + * page, i.e. pages that are used for control structures for a given TDX
> + * guest, and thus obtain TDX protections, including PAMT tracking.
> + */
> +struct page *tdx_alloc_control_page(void)
> +{
> +	struct page *page;
> +
> +	page = alloc_page(GFP_KERNEL_ACCOUNT);
> +	if (!page)
> +		return NULL;
> +
> +	if (tdx_pamt_get(page_to_pfn(page))) {
> +		__free_page(page);
> +		return NULL;
> +	}

Here's where I start to get lost.

What are the rules around tdx_pamt_get()? tdx_alloc_control_page() is
obviously for one 4k page. But tdx_pamt_get() does an allocation for 2MB
regions. So it has to be able to fail to actually add PAMT in some
cases, gracefully.

Right?

How does that happen?

I know the changelog tried to hand wave this away a bit. But the
comments in here need to say something about tdx_pamt_get() being
unusable on its own. The normal convention would be to __ it, too.

> +	return page;
> +}
> +EXPORT_SYMBOL_FOR_KVM(tdx_alloc_control_page);
> +
> +/*
> + * Free a page that was gifted to the TDX-Module for use as a control

Nit "TDX Module" for consistency.

> + * page. After this, the page is no longer protected by TDX.
> + */
> +void tdx_free_control_page(struct page *page)
> +{
> +	if (!page)
> +		return;
> +
> +	tdx_pamt_put(page_to_pfn(page));
> +	__free_page(page);
> +}
> +EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);
> +
>  void tdx_sys_disable(void)
>  {
>  	struct tdx_module_args args = {};
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index bdfd0e1e337ac..a886c54decaad 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -48,6 +48,8 @@
>  #define TDH_SYS_CONFIG			45
>  #define TDH_SYS_SHUTDOWN		52
>  #define TDH_SYS_UPDATE			53
> +#define TDH_PHYMEM_PAMT_ADD		58
> +#define TDH_PHYMEM_PAMT_REMOVE		59
>  #define TDH_SYS_DISABLE			69
>  
>  /*

