Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F863B14C4;
	Sat, 10 Oct 2026 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603694; cv=none; b=YrOqBfdb4OKHmd3pPlI5dj9tHSDLuqnT2UY8leRReZWQPtslL/spg/2hwpkKDfBXqDm5CdeT2CSWzAS0zsmrORwF82qhWIZqxceH6sSbId6npmlcr0rtxE3jYhpHhbUrQpKQF7Zx6VGlEF2qq4UaRrKi5SO2K7rapjJzOuXLALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603694; c=relaxed/simple;
	bh=1/SZOvUxJPVAklKg/0T2y39fh1+kBupLWOuf8mMxNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdmXlrg8G5Ku+Wu4uPMQR31os4Z624iVTMWSMapaM4eW/IDA+X1feT6IJZQnXi6nKKTxJflBqusmgzZtaBsv7p5yO4hvJThDPTSL0EujfD0hmpIkdx2o0YsIQQku1i5FoKDBW1J9wv0MVsnoAHcLZ2jZH21Xjbvq1b5hA28+YHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1MtqeH1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1MtqeH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791603693; x=1823139693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1/SZOvUxJPVAklKg/0T2y39fh1+kBupLWOuf8mMxNTQ=;
  b=D1MtqeH14F8InIddLnZZxtTz8FUS/DAdFFjPKvT76eIN72iW1azzqVSD
   fN85T0JWxTD3w5bN6kytaOjh93Pp/WqqOw9D5zRps8pGSbkBl84LlpABf
   Pmfnl1FpkJdr3u23qA63Q6bL7XeScyKlvupp4oh6G118ZAKRNQgFArhiA
   lfWA+1hgoaiY0RjWGlHJ6sIFYqQOyzRT5qPXVOI7zHJ8Z70TlfRcRASew
   AJri5kDFYCLhYgss6GPK4AEYPYcSs+VIq7C2BR/IBmtnW2uLASbu7TC4g
   +gmPiVKdLMs5WysBPQBF0G1PGqkI/b01MJf91uC9Ai6n3mbu6vnaDL1om
   w==;
X-CSE-ConnectionGUID: LfRvJHsUQLm1+ttsaLvmqg==
X-CSE-MsgGUID: XohRf/lVT0WoVuFroI+f1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="280863"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="280863"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 20:41:32 -0700
X-CSE-ConnectionGUID: RolorA4tTGGuCfEP8NrhAA==
X-CSE-MsgGUID: rOH0JdrxRQi2GpUAw/Vv0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="437819"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 09 Oct 2026 20:41:28 -0700
Date: Sat, 10 Oct 2026 11:38:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>, x86@kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
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
Message-ID: <asmzGnpjrDKmFLLP@yilunxu-OptiPlex-7050>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
 <asR64ovVXEmTVgg6@tlindgre-MOBL1>
 <asceeI8LD5ltEOje@yilunxu-OptiPlex-7050>
 <asjrTLfebkjDzB9F@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asjrTLfebkjDzB9F@thinkstation>

On Fri, Oct 09, 2026 at 02:28:34PM +0100, Kiryl Shutsemau wrote:
> On Thu, Oct 08, 2026 at 12:39:20PM +0800, Xu Yilun wrote:
> > On Tue, Oct 06, 2026 at 07:36:50AM +0300, Tony Lindgren wrote:
> > > On Tue, Oct 06, 2026 at 01:41:50AM +0800, Xu Yilun wrote:
> > > > The TDX module uses Physical Address Metadata Table (PAMT) to track some
> > > > state for each page of physical memory that it might use. 3 levels of
> > > > PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
> > > > Dynamic PAMT (DPAMT) allows saving memory by allocating 4KB PAMT
> > > > dynamically, while the 1GB and 2MB levels remain allocated on TDX module
> > > > initialization. The kernel has helpers to install 4K DPAMT.
> > > > 
> > > > Although the memory for the extensions is tens of megabytes and the host
> > > > allocates it in a large chunk, the TDX module accepts it at 4K
> > > > granularity. Thus the host has to install 4K DPAMT for each page of it.
> > > > 
> > > > Call tdx_pamt_get() for each page before adding it to TDX module.
> > > > Normally, these operations should not fail, and if they do,
> > > > intentionally keep the error handling as simple as before - leak all
> > > > pages, including the installed 4K DPAMT metadata.
> > > > 
> > > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > > ---
> > > > v3:
> > > >  - New patch
> > > > ---
> > > >  arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > > > index 5d5f9da1ab02..27a7039ee443 100644
> > > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > > @@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
> > > >  		struct page *chunk = page + added_pages;
> > > >  		unsigned int i;
> > > >  
> > > > -		for (i = 0; i < chunk_pages; i++)
> > > > +		for (i = 0; i < chunk_pages; i++) {
> > > > +			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
> > > > +			if (ret) {
> > > > +				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
> > > > +				goto out_free_hpa_list;
> > > > +			}
> > > > +
> > > >  			hpa_list->phys[i] = page_to_phys(chunk + i);
> > > > +		}
> > > >  
> > > >  		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
> > > >  		if (ret) {
> > > > 
> > > 
> > > How about just fold this change in into patch 3/6?
> > 
> > I think patch 3/6 is already quite heavy. Is it good that I put this
> > patch right after patch 3/6?
> 
> But that breaks bisectability, no? Even placed right after 3/6, that
> commit fails TDX module init on a machine with DPAMT and extensions
> whenever the module asks for a non-zero pool.

It will not. Any patch for extension-backed features should be applied
after this series. So the pool will always be zero until something like:

 /* List all kernel-supported add-on features0 bits here */
-#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0   (0)
+#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0   (TDX_FEATURES0_QUOTE)
