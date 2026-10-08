Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7727280A;
	Thu,  8 Oct 2026 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434556; cv=none; b=Zll6TcrP8YwWEyV6NqKQJ5pcxIDmXgiWMggN3RgdMkOSUwUBTgudFd7Az32J7dKoS3QS84kYW7wns0V3eGvOHG7E9qBuS6An/TKM8SAnKGvz7Z/fyD0EF9pn5rGBIzRAxUxlUosx/W/UOydqjKsVvF65tCFZwJgEdrmXzsfw6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434556; c=relaxed/simple;
	bh=+XA/w6VxM2eofFf1OMi1Jh/SSAmMxhFgPC954APuTWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfIjJHRgSY//1FqRwdm3bnRnM5ev3uO8g7qAY+l6eGzuUw0kxBlWXWz6BL7IzPH1miFn5X+bG7LRQcTBf2wq3JpxYJPIJWP2ggL7iEOzeIC3LoUD4+mNi5C6aUx71gbKRzxWB90Fy170yUffWHhjQvAVuDBUTwKbt8YnuBRBPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIjOSyoz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIjOSyoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791434555; x=1822970555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XA/w6VxM2eofFf1OMi1Jh/SSAmMxhFgPC954APuTWA=;
  b=GIjOSyozSSTcCGj3a9GZy/lhQRvaskVB7ydLTHmoYd+fSBQ0T4jokrtq
   UifRmNw6Z1iTOKosoahbcQA2hrsbJI0h5XZsrCOpBqRJ3yuierSllcoct
   CswsL9wGNh1t3N7Uf05BHHx7mwj3bzUbHp0lcPAjJxW8ISv04UVdfqP0s
   qLj8oygnnnCrihi7mFwgasmkejWBw/KAkl7RwBRxJ0yuVGDphzeWuGzJE
   6a68fbMX019EWgf1oXjYqOTHmQYgWpC48MUBXeGpq6lQa3f27XkiFCbda
   5KpYhqieBc6mDKRyL8cni++00pBd7H0+87QBUmjRuJwxyKjHlQwd4NfLA
   w==;
X-CSE-ConnectionGUID: wFrWDkZ3TPyWt/P4NfnnLg==
X-CSE-MsgGUID: IR/tLFdJStu11BoMLp85FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="216563"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="216563"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 21:42:34 -0700
X-CSE-ConnectionGUID: RklQlDB1Qbyy1O5DV7LQsw==
X-CSE-MsgGUID: B/zUO1erSxeEvCWcJIO2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="251441"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 07 Oct 2026 21:42:30 -0700
Date: Thu, 8 Oct 2026 12:39:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
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
Message-ID: <asceeI8LD5ltEOje@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
 <asR64ovVXEmTVgg6@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asR64ovVXEmTVgg6@tlindgre-MOBL1>

On Tue, Oct 06, 2026 at 07:36:50AM +0300, Tony Lindgren wrote:
> On Tue, Oct 06, 2026 at 01:41:50AM +0800, Xu Yilun wrote:
> > The TDX module uses Physical Address Metadata Table (PAMT) to track some
> > state for each page of physical memory that it might use. 3 levels of
> > PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
> > Dynamic PAMT (DPAMT) allows saving memory by allocating 4KB PAMT
> > dynamically, while the 1GB and 2MB levels remain allocated on TDX module
> > initialization. The kernel has helpers to install 4K DPAMT.
> > 
> > Although the memory for the extensions is tens of megabytes and the host
> > allocates it in a large chunk, the TDX module accepts it at 4K
> > granularity. Thus the host has to install 4K DPAMT for each page of it.
> > 
> > Call tdx_pamt_get() for each page before adding it to TDX module.
> > Normally, these operations should not fail, and if they do,
> > intentionally keep the error handling as simple as before - leak all
> > pages, including the installed 4K DPAMT metadata.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> > v3:
> >  - New patch
> > ---
> >  arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 5d5f9da1ab02..27a7039ee443 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
> >  		struct page *chunk = page + added_pages;
> >  		unsigned int i;
> >  
> > -		for (i = 0; i < chunk_pages; i++)
> > +		for (i = 0; i < chunk_pages; i++) {
> > +			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
> > +			if (ret) {
> > +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> > +				goto out_free_hpa_list;
> > +			}
> > +
> >  			hpa_list->phys[i] = page_to_phys(chunk + i);
> > +		}
> >  
> >  		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> >  		if (ret) {
> > 
> 
> How about just fold this change in into patch 3/6?

I think patch 3/6 is already quite heavy. Is it good that I put this
patch right after patch 3/6?
