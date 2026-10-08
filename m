Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A517386441;
	Thu,  8 Oct 2026 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437843; cv=none; b=UhEJI53qDoXZJFC8OBhEOYpYvGkX9qR56Hk2f8XkCaKRvcc+skgSO382BMlw8kW3fJBvjiInmwffXZOpjyP8COgOJdwu3CHVRK1XUW1vrzfemU9VvRtK+2/zyin2K9jPBL4DfiAW8/adFE90anhL3nDW6NO9aioO5k2xRi5UDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437843; c=relaxed/simple;
	bh=fJt5VCR6RFeOImcOp90CEq3PYiag/6AUCCtg7ggIXaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbc/NJrYDz8bDlJIvUn0JbvF11/GoNVhQ9Vu+8zXLnhTsC94kzOGEdQhrYnWAihTbB7TOufWKtpOKE4QtaZwfQXtgUrhR0bHjCVdBsUbaJov1tCXZoi/ogfUOU/IAL1k/EBLnese6al180JEn6DIJPpLiXPgNi9u8LnnwSnSsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2+BOTRK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2+BOTRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791437842; x=1822973842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJt5VCR6RFeOImcOp90CEq3PYiag/6AUCCtg7ggIXaE=;
  b=j2+BOTRKvX+1R6Fwv/L3SJKucPvC0w0jdAnOgZJFjPyRAAdgHOh+0zs6
   Lnlj6iPJEBQGDC+v+3MD3ST4kglouRH60ef63cPNRqIQ6lQrHAufCmUY/
   Ul8rjPv/Hlii1M2FsdJ2mcxsXDy6BcvuQJQoYDXyt6QmocMIV9qALpU79
   AEZTj9Sdty+F0ASW0jk8iGfbYdT5C3HUMXhMnO0eJ5rCRe7a5Co4eQY/1
   cJqWU2SxbJCwRvdDwil/Z3I3q5Qel/DnSdapPS+n/3d59hfOBzUgjEiP0
   v+VsDJ3wNMssuoSu9+5SyaTF96apkMJEQ273lFBm70yVx/eqzGK7MmqJZ
   A==;
X-CSE-ConnectionGUID: SCAFBC9HQs2pqrtHPhsmrw==
X-CSE-MsgGUID: B+NpuBTaRXSTxlaDQ2QahQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="98572"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="98572"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 22:37:21 -0700
X-CSE-ConnectionGUID: CTW6e7MfShyeDR9tJHshhA==
X-CSE-MsgGUID: KeELzRUAQZ+a+HZVb/BL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="1668279"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 22:37:15 -0700
Date: Thu, 8 Oct 2026 08:37:12 +0300
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
Message-ID: <ascsCPcRUBpB32DH@tlindgre-MOBL1>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
 <asR64ovVXEmTVgg6@tlindgre-MOBL1>
 <asceeI8LD5ltEOje@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asceeI8LD5ltEOje@yilunxu-OptiPlex-7050>

On Thu, Oct 08, 2026 at 12:39:20PM +0800, Xu Yilun wrote:
> On Tue, Oct 06, 2026 at 07:36:50AM +0300, Tony Lindgren wrote:
> > On Tue, Oct 06, 2026 at 01:41:50AM +0800, Xu Yilun wrote:
> > > The TDX module uses Physical Address Metadata Table (PAMT) to track some
> > > state for each page of physical memory that it might use. 3 levels of
> > > PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
> > > Dynamic PAMT (DPAMT) allows saving memory by allocating 4KB PAMT
> > > dynamically, while the 1GB and 2MB levels remain allocated on TDX module
> > > initialization. The kernel has helpers to install 4K DPAMT.
> > > 
> > > Although the memory for the extensions is tens of megabytes and the host
> > > allocates it in a large chunk, the TDX module accepts it at 4K
> > > granularity. Thus the host has to install 4K DPAMT for each page of it.
> > > 
> > > Call tdx_pamt_get() for each page before adding it to TDX module.
> > > Normally, these operations should not fail, and if they do,
> > > intentionally keep the error handling as simple as before - leak all
> > > pages, including the installed 4K DPAMT metadata.
> > > 
> > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > ---
> > > v3:
> > >  - New patch
> > > ---
> > >  arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > > index 5d5f9da1ab02..27a7039ee443 100644
> > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
> > >  		struct page *chunk = page + added_pages;
> > >  		unsigned int i;
> > >  
> > > -		for (i = 0; i < chunk_pages; i++)
> > > +		for (i = 0; i < chunk_pages; i++) {
> > > +			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
> > > +			if (ret) {
> > > +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> > > +				goto out_free_hpa_list;
> > > +			}
> > > +
> > >  			hpa_list->phys[i] = page_to_phys(chunk + i);
> > > +		}
> > >  
> > >  		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> > >  		if (ret) {
> > > 
> > 
> > How about just fold this change in into patch 3/6?
> 
> I think patch 3/6 is already quite heavy. Is it good that I put this
> patch right after patch 3/6?

In that case you should describe that after commit XXX dynamic PAMT is
enabled and tdx_pamt_get() must be used. Otherwise it's not clear that
patch 3/6 will not work without this change.
