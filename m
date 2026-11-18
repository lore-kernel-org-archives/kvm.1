Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969673;
	b=V4iM/aGev3pjry8FKWtVkWwBTbbEpHMc2Sq4ZoUkVwlsQv+dr0QHM5MhFeZBilcHSJpu
	 rQwDPVEQV86UN/8ofP0slkgMCK5lV0NTYgDiiZBRbweYX6dO1XiXbEfzIU4nr4+MjfdA8
	 KEZ/1house30HDrClMpXYDPvHv5S1xxRAgHUyDqjUyGc+aDpWSSfCP0aYrVrT1W9u8150
	 21o+6nImTjzPwEhByw1nkBeL6TG7wyvTn1wIYeUfxYmMoIY5gTW/mKtZ0tVS9TfkGfNEU
	 +g7R8L+fWz7ri6yxl2C0+3YIbriHvCZqgnIBk+0t2eG/onB1dbXdABj2sTEZ0wqs9Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969673;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6HDuddZYxiwPfkHKMQex0JGzsZG+GFTKn8vdoWJavzo=;
	b=xMOQ9x2KfJb4pHywkkWbi1qyTGzLrs6Cx338pbpehtM5o18MsHrWN9yHDNOee8p4Uibz
	 N0cjmtXkWgsZygrtTSE0vlkL8r1RV6S/OOOoFc61rdNb9nXsaZvvUFvlzP2mRhQ0t8Z2J
	 mnFOGBg6w7oeBI4lUMsMKQqlkFllbr6CXRFd2QoBGj/YlW/7KxVeA/gJlKXwxyt/OAl9F
	 r/IBp2v8NE0O4QLWgh+Kt9Dj8XUMBELklNCXZn5GxDZaJkNo2t1UdS5rmrAmNZa0sQGIR
	 sAjfzcF9wqdPFkS9v2tKBMlrvuhkFCLihqe+zTpFxA4xCIlbTQ4gPIzCfisMgl0quWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lG+nRkcP;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1F606A325;
	Wed, 18 Nov 2026 02:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E1F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lG+nRkcP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794969673; x=1826505673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMg6iADw9dsIPCjld7o8lZ1JKOgyBIjUEuX7ENSGD2w=;
  b=lG+nRkcP3P+3Yz7EbWLgZfF4BB0AbXKKMwt0qorG6Udj3l1BRfZLmFQP
   146u5zpNIyDW7rwCBGGj+tcnHKsLaVxC18LL2oXZnhUjw/lb3v3bPtzuV
   QxFd5LTRZLBPaUySI9/3be5y+ky8fVh97afihQdVrw6i3Oo3Y4pZ47t+Y
   5feN3QMRUFcIZonBtB9bt4CffQWkW6zTiihDrooA+V36kH5geDv9OUcA5
   2kUPz2sfrWh8DLUGvXVOrZBmQtb4EqG4EyRtKMAK1wkSin6B8IyUjEQSt
   NrC+vVZB+GKk5p127BXAa5kGKRliL6Hag3VnUhP5JGcNWAQ0cxknmP+ws
   A==;
X-CSE-ConnectionGUID: uWJOA1P7QgGm1f1sQY0HNw==
X-CSE-MsgGUID: aoqTmTKbSFuA2/RVsU80IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3783765"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3783765"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 18:41:12 -0800
X-CSE-ConnectionGUID: cTXYupeARFiSheAMT5+C9A==
X-CSE-MsgGUID: ZbebIHEUTF2aQGTzdp8fWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10370005"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 17 Nov 2026 18:41:08 -0800
Date: Wed, 18 Nov 2026 10:32:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com,
	kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com,
	sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
Subject: Re: [PATCH v5 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <av0OLVB/PMjYz5cS@yilunxu-OptiPlex-7050>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-3-c74f764abc3d@linux.intel.com>
 <3c82411b-dfec-4b26-9e7f-777c8f1ecb6d@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c82411b-dfec-4b26-9e7f-777c8f1ecb6d@amd.com>

On Tue, Nov 17, 2026 at 02:06:47PM +1100, Alexey Kardashevskiy wrote:
> On 11/11/26 14:48, Xu Yilun wrote:
> > TDX module extensions need memory for their execution environment to
> > serve SEAMCALL leafs. The TDX architecture implements the extensions
> > in such a way that they use the memory outside of SEAM range, so the
> > kernel should add the memory upfront at initialization time.
> > 
> > Introduce a new memory adding process backed by a new SEAMCALL leaf
> > TDH.EXT.MEM.ADD. The kernel queries TDX module how much memory needed,
> > allocates it, adds it to the module, and never gets it back. Note that
> > the process requires Dynamic PAMT backing. A subsequent patch adds the
> > support. This doesn't break bisectability cause the extensions can't be
> > enabled yet without a feature that uses them.
> > 
> > The TDX module accepts the memory in the form of an HPA array. This
> > array is passed via a single 64-bit SEAMCALL leaf parameter, which
> > encodes two values: the PFN of the container page holding the array, and
> > the number of entries in the array. Create a helper to encode this
> > format and name it after the TDX module term: HPA_LIST_INFO.
> > 
> > TDX module extensions consume tens of megabytes memory that will never
> > be returned to the host. Use contiguous page allocation to isolate these
> > large blocks entirely. This is a simple way to avoid permanent memory
> > fragmentation: requiring the full size to be contiguous is more
> > expensive than needed but should be good during the boot time. Print the
> > allocation amount on TDX module extensions initialization for
> > visibility.
> > 
> > The TDX module provides a metadata field "required_pages" to indicate
> > the required memory size. This metadata is meaningful only after the
> > add-on feature configuration. Don't read and cache the metadata in
> > tdx_sysinfo. Instead read it right before allocating memory for the
> > extensions, when it is guaranteed to be valid.
> > 
> > The original changelog was written by hand. AI was used to help correct
> > grammatical errors and polish individual sentences for better
> > readability.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> > Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > ---
> > An alternative solution is to use a loop that gives memory on a memory
> > error code - TDX_EXT_MEMORY_POOL_REQUIRED, add one page per iteration
> > until TDH.EXT.INIT succeeds. Something like:
> > 
> > 	do {
> > 		ret = tdh_sys_init();
> > 		if (ret == TDX_EXT_MEMORY_POOL_REQUIRED)
> > 			tdh_ext_mem_add(); //single page
> > 	} while (ret == TDX_EXT_MEMORY_POOL_REQUIRED);
> > 
> > This approach is slightly simpler as we don't have to query the module
> > for the total memory, no memory pre-allocation or segmentation math.
> > But allocating a single 4K page per iteration may cause permanent memory
> > fragmentation.
> 
> Why not allocating new memory in 2MB chunks, reducing fragmentation? Thanks,

Allocating & adding 2MB by 2MB reduces fragmentation. But we would end up
trying to add more memory than needed, then have to deal with extra error
handling about "memory pool full in the middle of the page list", which
defeats the purpose of "simpler".

An earlier discussion about the exact concern:

https://lore.kernel.org/all/e05f49c28a78de961130655a76f415b01774016e.camel@intel.com/

Thanks.
