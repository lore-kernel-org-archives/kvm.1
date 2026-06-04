Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892573CAA2F;
	Thu,  4 Jun 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589160; cv=none; b=L/SbUkgxtGVnoKPs6A2fRKnfvf4jNcr/ZrmFN3X0/v8p+xVq45gzpLAlrcQASw1/CitdvsVvD9jyJD2aV5wDKRGHbPxAhU5FspDYPf9GOwZMZz4wsuIKaZKxLLVIWVQjQWCfAP3b8KDQcRbCPujE/pWFrIR7ZA028Xn2CUv+PyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589160; c=relaxed/simple;
	bh=C+3/Y8UM+QF4b+fxUP6DMkOPxlSgLT2Ew0IkUAd7ZBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSzhWwZBwayWA0y1JXlzM0MK0LJoT/cJQwaTsEaAa9rPU+fX8PoNk3U6+smAU25xQnmkmAwhE2WCXt5fI76wj/Jemy9sI2MQmr0v5ra2wo8wWzLNxQGHu+O0CZ7c+/cvvPWxPJlFXILaXrI9kgcIVMRmbTpQEytd4u9TPqQpDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U53n/eYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U53n/eYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69841F00899;
	Thu,  4 Jun 2026 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780589157;
	bh=yVTz1uwL1NNB95GiENNhSXV/zvAW1QB+RQh5yDivS9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U53n/eYJFU+DltQIrh9jMR7xb6PYWBeAX+OJQ1QBCVtMnXdVZYyQ10H28CIt0yCjm
	 NHvqDaLvs/8UZd06nXwa2/uPJsdYD7u3mKcH5pwnzWsg7qFRkQYLg3k5y2psbko+Rn
	 0zCw6GA0Nv4+9W1VuJChafZzGAJlmOooCLVD14SegCTCGA7YBf8JuPNNbudHXFYnPj
	 tHkUTUI5rXwhUCHjUBCbk7UJZDDdHjF2gx5bpQCJyOP2B+H6GDV3Rq3uo0ZxesHR79
	 7OyMSbOYZjE08zq3KXmiB2yAwbhIz4XikTPR+RsF2F+hCDU7tXurawk5WknddQUXjK
	 ffV3j2deZfdEQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id ED797F40072;
	Thu,  4 Jun 2026 12:05:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 12:05:55 -0400
X-ME-Sender: <xms:Y6IhahnHXc09KilZvFzUSBZgTSLIkEVygC0kGisdcxVNEKWyRMxGBw>
    <xme:Y6IhaqtBr2N5Ps4cgjVM-Im_rzv11AUNqNFez-P-R_haS4tzA3BMK62krcfnL0STb
    2nMO5pkdjsKaKlgK95VqrzoeZWJ8bBKa5PIoiyvL4EWo-gzF_vR8w>
X-ME-Received: <xmr:Y6IhagsMGGZ5nB454xWyFruYQrqtm5hAUF4aEe9Cx4QsVtL1cF2LpHxL1bd0wA>
X-ME-Proxy-Cause: dmFkZTFWOXm/HbsQkCfZ0JEDY7FJu/nVG/x0j3OWWRZksOqWO2cAdoQsNzQcvJeAF7T6wu
    yw3RhoVAzGLCcdWmON5DYz2p1qN+phCm6+K5u7cpldS1sgAmg2ww0rqmwunmD4tc32uiSL
    OJaP+3cfqmhdriIifqpvM3rYkemJiIJaAuqZ/bYJu+yFHX1aUPGas+wSyV/YCgyg3apGfX
    jeBZRQGpawV2oGEvl7OINeHp115YYqmyGZWnP4M8hNrIQs2UnHEAqSJAlDGkYGO06OF/AS
    ipoLNMUWYA+g7PheK5gtmnLK0LaLiJvuy7PRw7r52HFPk19FLjXZ1XO2UKefyecs9Ox5kx
    SZY8ocoNDU7HkqYDwAc+EvaIYPL/5dX42cdazX4XSGrW37W6+LpwvoM0cTUE1ZR+oVIQ3O
    pN0C8RDxcNuWfZuqWqK+z/gGuJRPc5EM3LhvlI6/XN+IBB3bsmYZW7wdR4zvcwVsUz5J5B
    XG+u49B2DvY0QFy2A+Pq2Ora3d5Gc1xpJyb8+SP03RID8WNfP7ZQi1VUd7u/FqJ33+MNPO
    Jr6x9KlODIKyeQ1uSXXpMvuszK0ldcqOx3UOj0R+0f+pWmn/jqKctW8XfbLmm4WlW+N51V
    f66QJpT5ZSKg10X+S+QoRl1Hod8ihzmmcD5TJKkG7W/O1vPBmThgYvLF7fNQ
X-ME-Proxy: <xmx:Y6Ihai1gRVJqQDK-wAYgh4IVoPsfpj0WIZDWQoKtMJqeZkEwh9WgJg>
    <xmx:Y6IhaoNjkt5jhap18TBFNnPFBYtRR6zhU4y2qrAm_sZeBfUjr3q9Ag>
    <xmx:Y6IhaoWiwMRCKigm9wIuXI3pCgSjGuZgviC77oMPa72wIXF0dLSU-A>
    <xmx:Y6IhaoYvxw-HXITfeaxlQuluR8fwJzGepU7zG1IqMj670gSDQ0Qt_Q>
    <xmx:Y6IhajvO5uppJzHZ_sZztkh5Ssr3Q2CM6UlAyFYU0bB2iKgWAhO6cD0L>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 12:05:53 -0400 (EDT)
Date: Thu, 4 Jun 2026 17:05:48 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Message-ID: <aiGheH8YceumotUU@thinkstation>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-2-rick.p.edgecombe@intel.com>

On Mon, May 25, 2026 at 07:35:05PM -0700, Rick Edgecombe wrote:
> For each memory region that the TDX module might use (called TDMR), three
> separate traditional PAMT allocations are needed. One for each supported
> page size (1GB, 2MB, 4KB). These store information on each page in the
> TDMR. In Linux, they are allocated out of one physically contiguous block,
> in order to more efficiently use some internal TDX module book keeping
> resources. So some simple math is needed to break the single large
> allocation into three smaller allocations for each page size.
> 
> There are some commonalities in the math needed to calculate the base and
> size for each smaller allocation, and so an effort was made to share logic
> across the three. Unfortunately doing this turned out unnaturally tortured,
> with a loop iterating over the three page sizes, only to call into a
> function with cases statement for each page size. In the future Dynamic
> PAMT will add more logic that is special to the 4KB page size, making the
> benefit of the math sharing even more questionable.
> 
> Three is not a very high number, so get rid of the loop and just duplicate
> the small calculation three times. In doing so, setup for future Dynamic
> PAMT changes.
> 
> Since the loop that iterates over it is gone, further simplify the code by
> dropping the array of intermediate size and base storage. Just store the
> values to their final locations. Accept the small complication of having
> to clear tdmr->pamt_4k_base in the error path, so that tdmr_do_pamt_func()
> will not try to operate on the TDMR struct when attempting to free it.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Couple of nits below.

> ---
> v6:
>  - Drop {} by moving a comment (Binbin)
>  - Log tweaks
> 
> v4:
>  - Just refer to global var instead of passing pamt_entry_size around
>    (Xiaoyao)
>  - Remove setting pamt_4k_base to zero, because it already is zero.
>    Adjust the comment appropriately (Kai)
> 
> v3:
>  - New patch
> ---
>  arch/x86/virt/vmx/tdx/tdx.c | 93 ++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 967482ae3c801..487f389f52f4b 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -516,31 +516,21 @@ static __init int fill_out_tdmrs(struct list_head *tmb_list,
>   * Calculate PAMT size given a TDMR and a page size.  The returned
>   * PAMT size is always aligned up to 4K page boundary.
>   */
> -static __init unsigned long tdmr_get_pamt_sz(struct tdmr_info *tdmr, int pgsz,
> -					     u16 pamt_entry_size)
> +static __init unsigned long tdmr_get_pamt_sz(struct tdmr_info *tdmr, int pgsz)
>  {
>  	unsigned long pamt_sz, nr_pamt_entries;
> +	const int tdx_pg_size_shift[] = { PAGE_SHIFT, PMD_SHIFT, PUD_SHIFT };
> +	const u16 pamt_entry_size[TDX_PS_NR] = {
> +		tdx_sysinfo.tdmr.pamt_4k_entry_size,
> +		tdx_sysinfo.tdmr.pamt_2m_entry_size,
> +		tdx_sysinfo.tdmr.pamt_1g_entry_size,
> +	};
>  
> -	switch (pgsz) {
> -	case TDX_PS_4K:
> -		nr_pamt_entries = tdmr->size >> PAGE_SHIFT;
> -		break;
> -	case TDX_PS_2M:
> -		nr_pamt_entries = tdmr->size >> PMD_SHIFT;
> -		break;
> -	case TDX_PS_1G:
> -		nr_pamt_entries = tdmr->size >> PUD_SHIFT;
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -		return 0;
> -	}
> +	nr_pamt_entries = tdmr->size >> tdx_pg_size_shift[pgsz];
> +	pamt_sz = nr_pamt_entries * pamt_entry_size[pgsz];
>  
> -	pamt_sz = nr_pamt_entries * pamt_entry_size;
>  	/* TDX requires PAMT size must be 4K aligned */
> -	pamt_sz = ALIGN(pamt_sz, PAGE_SIZE);
> -
> -	return pamt_sz;
> +	return PAGE_ALIGN(pamt_sz);
>  }
>  
>  /*
> @@ -578,28 +568,21 @@ static __init int tdmr_get_nid(struct tdmr_info *tdmr, struct list_head *tmb_lis
>   * within @tdmr, and set up PAMTs for @tdmr.
>   */
>  static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
> -				   struct list_head *tmb_list,
> -				   u16 pamt_entry_size[])
> +				   struct list_head *tmb_list)
>  {
> -	unsigned long pamt_base[TDX_PS_NR];
> -	unsigned long pamt_size[TDX_PS_NR];
> -	unsigned long tdmr_pamt_base;
>  	unsigned long tdmr_pamt_size;
>  	struct page *pamt;
> -	int pgsz, nid;
> -
> +	int nid;

Add a newline here?

>  	nid = tdmr_get_nid(tdmr, tmb_list);
>  
>  	/*
>  	 * Calculate the PAMT size for each TDX supported page size
>  	 * and the total PAMT size.
>  	 */
> -	tdmr_pamt_size = 0;
> -	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
> -		pamt_size[pgsz] = tdmr_get_pamt_sz(tdmr, pgsz,
> -					pamt_entry_size[pgsz]);
> -		tdmr_pamt_size += pamt_size[pgsz];
> -	}
> +	tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
> +	tdmr->pamt_2m_size = tdmr_get_pamt_sz(tdmr, TDX_PS_2M);
> +	tdmr->pamt_1g_size = tdmr_get_pamt_sz(tdmr, TDX_PS_1G);
> +	tdmr_pamt_size = tdmr->pamt_4k_size + tdmr->pamt_2m_size + tdmr->pamt_1g_size;
>  
>  	/*
>  	 * Allocate one chunk of physically contiguous memory for all
> @@ -607,26 +590,18 @@ static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
>  	 * in overlapped TDMRs.
>  	 */
>  	pamt = alloc_contig_pages(tdmr_pamt_size >> PAGE_SHIFT, GFP_KERNEL,
> -			nid, &node_online_map);
> +				  nid, &node_online_map);
> +

Looks like unrelated whitespace change. Is it intentional?

> +	/*
> +	 * tdmr->pamt_4k_base is still zero so the error
> +	 * path of the caller will skip freeing the pamt.
> +	 */
>  	if (!pamt)
>  		return -ENOMEM;
>  
> -	/*
> -	 * Break the contiguous allocation back up into the
> -	 * individual PAMTs for each page size.
> -	 */
> -	tdmr_pamt_base = page_to_pfn(pamt) << PAGE_SHIFT;
> -	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
> -		pamt_base[pgsz] = tdmr_pamt_base;
> -		tdmr_pamt_base += pamt_size[pgsz];
> -	}
> -
> -	tdmr->pamt_4k_base = pamt_base[TDX_PS_4K];
> -	tdmr->pamt_4k_size = pamt_size[TDX_PS_4K];
> -	tdmr->pamt_2m_base = pamt_base[TDX_PS_2M];
> -	tdmr->pamt_2m_size = pamt_size[TDX_PS_2M];
> -	tdmr->pamt_1g_base = pamt_base[TDX_PS_1G];
> -	tdmr->pamt_1g_size = pamt_size[TDX_PS_1G];
> +	tdmr->pamt_4k_base = page_to_phys(pamt);
> +	tdmr->pamt_2m_base = tdmr->pamt_4k_base + tdmr->pamt_4k_size;
> +	tdmr->pamt_1g_base = tdmr->pamt_2m_base + tdmr->pamt_2m_size;
>  
>  	return 0;
>  }
> @@ -657,10 +632,7 @@ static __init void tdmr_do_pamt_func(struct tdmr_info *tdmr,
>  	tdmr_get_pamt(tdmr, &pamt_base, &pamt_size);
>  
>  	/* Do nothing if PAMT hasn't been allocated for this TDMR */
> -	if (!pamt_size)
> -		return;
> -
> -	if (WARN_ON_ONCE(!pamt_base))
> +	if (!pamt_base)
>  		return;
>  
>  	pamt_func(pamt_base, pamt_size);
> @@ -686,14 +658,12 @@ static __init void tdmrs_free_pamt_all(struct tdmr_info_list *tdmr_list)
>  
>  /* Allocate and set up PAMTs for all TDMRs */
>  static __init int tdmrs_set_up_pamt_all(struct tdmr_info_list *tdmr_list,
> -					struct list_head *tmb_list,
> -					u16 pamt_entry_size[])
> +				 struct list_head *tmb_list)
>  {
>  	int i, ret = 0;
>  
>  	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
> -		ret = tdmr_set_up_pamt(tdmr_entry(tdmr_list, i), tmb_list,
> -				pamt_entry_size);
> +		ret = tdmr_set_up_pamt(tdmr_entry(tdmr_list, i), tmb_list);
>  		if (ret)
>  			goto err;
>  	}
> @@ -970,18 +940,13 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
>  				  struct tdmr_info_list *tdmr_list,
>  				  struct tdx_sys_info_tdmr *sysinfo_tdmr)
>  {
> -	u16 pamt_entry_size[TDX_PS_NR] = {
> -		sysinfo_tdmr->pamt_4k_entry_size,
> -		sysinfo_tdmr->pamt_2m_entry_size,
> -		sysinfo_tdmr->pamt_1g_entry_size,
> -	};
>  	int ret;
>  
>  	ret = fill_out_tdmrs(tmb_list, tdmr_list);
>  	if (ret)
>  		return ret;
>  
> -	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list, pamt_entry_size);
> +	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.54.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
