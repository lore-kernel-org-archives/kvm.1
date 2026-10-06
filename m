Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF62853FD;
	Tue,  6 Oct 2026 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261421; cv=none; b=Fy6ioIsZ04PnNZ4E9GuxU3h1vZjxKLeh72K6ew4eAVyp1/jnSnOJMd5eOpZosTJMq5zG1+d0bu3rMvgDlI7Fez97G0jFSNIQinVQvna7uzZPqPoZkcwupkwRk8b9q415GUpAQrWJ4+/TBF4yi8YmVHMHd/mmBWe+dJsyToCInH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261421; c=relaxed/simple;
	bh=WTL2BeKNotzn/h1QPZkSobi2zJginBeztB+bKqv7qaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSLGRCY4oy3wGVfw73Ooz4txRnvf15f88uzx8yTmh1AUxpNHB7J/UHkTDih09lddGAKM35onBmjKhCejF7n9lMMPWN1IMSBNNCK7x7ylM4BWMTCLmnftx8c1P4VAwPT+GgrS2R89As7MkOKS/OSOppK/dryrg7f9srJVLByJpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhTNmmER; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhTNmmER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791261420; x=1822797420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WTL2BeKNotzn/h1QPZkSobi2zJginBeztB+bKqv7qaI=;
  b=MhTNmmEROZZAmUDh9VeyPZygqgFmqMea7qdxD1eTenez3sWV88CIjG6l
   lvOVdUoYuz6//GcPRIowqfIadjWzDzY27FGci4ZbIsJtTySvZMBj6E1Qc
   gJ8LSr7+FHMe8OFFTNU727dFBXIHpDcQdPbyNuU/s4C4k0KTFzIQv1QGB
   2K+9UJu307eGsA9i7OrB7B9YjztHTlXJKvPqT/IdQpPMex1c3Dq/nFEIq
   YABeZcPmPnnLMZBz3PqXI7Qal6L0IXDkUjbrxglaIhKnrMV0gl+eoJjBi
   5NHxjX0F+qm++FXIRz5PSa7NsTDiJZ4mkNiuobhk/To0LsWqZ843ySfq7
   g==;
X-CSE-ConnectionGUID: 0N8SiqM3TQCs/qJ4b/3OEg==
X-CSE-MsgGUID: FNgnj5EWSxaHxyy0fwFttQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="117458466"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="117458466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 21:37:00 -0700
X-CSE-ConnectionGUID: RYtoPNqiQrWKBuJxouGwZA==
X-CSE-MsgGUID: OlyfK/cyRzS75K9kVD1HJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="315055538"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 21:36:53 -0700
Date: Tue, 6 Oct 2026 07:36:50 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com,
	kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com,
	sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	nik.borisov@suse.com
Subject: Re: [PATCH v3 6/6] x86/virt/tdx: Support DPAMT when adding memory
 for the extensions
Message-ID: <asR64ovVXEmTVgg6@tlindgre-MOBL1>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>

On Tue, Oct 06, 2026 at 01:41:50AM +0800, Xu Yilun wrote:
> The TDX module uses Physical Address Metadata Table (PAMT) to track some
> state for each page of physical memory that it might use. 3 levels of
> PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
> Dynamic PAMT (DPAMT) allows saving memory by allocating 4KB PAMT
> dynamically, while the 1GB and 2MB levels remain allocated on TDX module
> initialization. The kernel has helpers to install 4K DPAMT.
> 
> Although the memory for the extensions is tens of megabytes and the host
> allocates it in a large chunk, the TDX module accepts it at 4K
> granularity. Thus the host has to install 4K DPAMT for each page of it.
> 
> Call tdx_pamt_get() for each page before adding it to TDX module.
> Normally, these operations should not fail, and if they do,
> intentionally keep the error handling as simple as before - leak all
> pages, including the installed 4K DPAMT metadata.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
> v3:
>  - New patch
> ---
>  arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 5d5f9da1ab02..27a7039ee443 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
>  		struct page *chunk = page + added_pages;
>  		unsigned int i;
>  
> -		for (i = 0; i < chunk_pages; i++)
> +		for (i = 0; i < chunk_pages; i++) {
> +			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
> +			if (ret) {
> +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> +				goto out_free_hpa_list;
> +			}
> +
>  			hpa_list->phys[i] = page_to_phys(chunk + i);
> +		}
>  
>  		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
>  		if (ret) {
> 

How about just fold this change in into patch 3/6?
