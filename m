Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FEC463B61;
	Mon, 24 Aug 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591701; cv=none; b=KrJ8rNS5HSNYuJjZWnULpe5UozljuNBEV+DiZO73Vv1ZIybrnhPBqC7SEXOdU3aixp+bIBsVK/ASk8VuczSudtLAqcA9ryd1/ANCBzT5WWNtx1ao+bvlBh6mKHk/c+Sx/1X+VOwM+KNwVd0iVrBrf7IBeE/c3c3iXb6yOe6sAkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591701; c=relaxed/simple;
	bh=QmqdTCE6fEYSX638NUEaLqW3WzInBpyiUdRNOMh+8xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1pRJtmeMve8z/zpafkO3bdD9akrb/hVV3uD0xE+ePQJfXmCpTiVkjsuKTdsooShYHPbkLJq5JlfkmT3m1KUvoQ/Yqx9L00f2RjhtztOD3N4dAn76xpmepjRqkk8X3QdTUSPqhvuQz/+kRftgBnJLzCrDRfxs3nTyAdBqAS2JA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkGxaowx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkGxaowx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787591700; x=1819127700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QmqdTCE6fEYSX638NUEaLqW3WzInBpyiUdRNOMh+8xg=;
  b=PkGxaowxxMSWLVhX+nF4/KFd+t3mHEHX2U80M/uV28hxE9BhBaibD7+0
   migv3N2S/IM7MJPurL9UQOV6PwO6uWkP4j7cZWoZYqx9cZK0Nwf//ScI8
   HRB8ssGYws0tpPfkaXJaGGCUslF5jobHvnC2HqqeNT7xxc4SPX5puv3lo
   3tMTfqQH8eZb6Ae4zt3y2Rx8ngbUvPARF0QZRxkRt86WSRgfN9yUXR61M
   qzG4QAYYQlZgYBJmeisODIzdb5Z/Josl3MxIeJzHUTtf3pqjL7nPwgRTi
   tXXvgknFrY86BOTrXOoKiaL95J7ZFVlcUHmG4pwg4ugLkpMuBjpmFynVY
   Q==;
X-CSE-ConnectionGUID: u0u0EbTNTteCljsSl1+V+Q==
X-CSE-MsgGUID: AKrtNL2vQQeX6eV3lIKJQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98726029"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98726029"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 10:14:59 -0700
X-CSE-ConnectionGUID: njDjaWqwT6+u91Ef1GhkkQ==
X-CSE-MsgGUID: RZdMKDE3Roa7WI1mPeuFmA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa003.fm.intel.com with ESMTP; 24 Aug 2026 10:14:55 -0700
Date: Tue, 25 Aug 2026 01:14:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Message-ID: <aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-6-yilun.xu@linux.intel.com>
 <f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com>

> > After providing all required memory to the TDX module, initialize TDX
> > module extensions via TDH.EXT.INIT
> > 
> 
> What exactly does TDH.EXT.INIT actually do,

The SPEC just said it "initializes TDX module extension". My
understanding is that it builds the SEAMCALL execution context by
setting up its internal data on the memory added by TDH.EXT.MEM.ADD

> and why can't whatever that is
> happen during TDH.EXT.MEM.ADD?

Do you mean why can't the extensions initialization happen on last
TDH.EXT.MEM.ADD? I can think of some case that TDH.EXT.MEM.ADD is not
needed but the extensions initialization is needed. For example: after
an compatible TDX module update.

I may ask the TDX module team to get a better understanding.

> Not saying we need to jam anything in awkwardly.
> Can we say this is analogous to TDH.SYS.CONFIG but for the extensions? It only
> exists because SYS.CONFIG gives the features to enable before the memory is
> there to actually do it. So it needs a second call?

I'm not sure I understand the question. But I think extension memory is
more like PAMT, and TDH.EXT.INIT is more like TDH.SYS.TDMR.INIT, is it?

				PAMT			the extensions
				====			==============
add memory			TDH.SYS.CONFIG		TDH.EXT.MEM.ADD
init memory for functionality	TDH.SYS.TDMR.INIT	TDH.EXT.INIT

> 
> 
> > , then those add-on features can use
> > their SEAMCALL leaves normally.
> 
> Out of curiosity, what happens if you don't complete these steps and call one of
> the extension seamcalls?

They return the error code - TDX_EXT_NOT_INITIALIZED.

> 
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Code looks good. Except that it leaves me wondering if this could have all been
> a while loop around tdh_sys_confg() that gives memory on a memory error code.
> Actually it looks like we have a TDX_EXT_MEMORY_POOL_REQUIRED error code to use.
> 
> Consider something like this:
> 
> do {
> 	ret = tdh_sys_init();
> 	if (ret == TDX_EXT_MEMORY_POOL_REQUIRED)
> 		tdh_ext_mem_add() //single page
> while (ret == TDX_EXT_MEMORY_POOL_REQUIRED)
> 
> If that could technically work, I guess the benefit of the current approach is
> that it allows to use contiguous physical allocations. Not sure if you think
> that simpler snippet would actually be that simple in the real world.

I think there are several simplifications here, let's break down:

 1. Forget about the 512-page limitation for hpa_list_info, always add 1 page
    at a time.
    This can also be applied to current flow. So put it aside.

 2. The loop strategy:
    - read total memory size	vs.	- loop on error code
    - prealloc all memory		  - alloc a page
    - loop on size			  - memory add
      - memory add

    The main saving is that we don't read memory_pool_required_pages any more.
    Others are similar lines of code.

 3. But we'd better keep reading ext_required. I tested when ext_required == 0:
      - tdh_sys_init() returns TDX_EXT_MEMORY_POOL_REQUIRED,
      - tdh_ext_mem_add() returns TDX_EXT_MEMORY_POOL_NOT_PENDING,
    So we need a weird return code combination to identify "extensions not
    required" then skip. And I don't know if the combination is stable,
    it is not specified in SPEC.

 4. If we still need to read at least one extensions metadata
    (ext_required), saving a memory_pool_required_pages read is not
    significant.

So generally I don't think the snippet would be that simple.

> But if we
> are basically building all this to help fragmentation, we should say it.
> 

[...]

> > +static __init int tdx_ext_init(void)
> > +{
> > +	struct tdx_module_args args = {};
> > +	u64 ret;
> > +
> > +	do {
> > +		ret = seamcall(TDH_EXT_INIT, &args);
> 
> What happens if no init is needed? Does it return success or error? I'm

It returns error - TDX_EXT_MEMORY_POOL_REQUIRED

> wondering if we need to really check ext_required and can just call TDH_EXT_INIT
> unconditionally. We need to check for TDX_FEATURES0_EXT in any case. But do we
> need both checks?

As mentioned above, we need a weird return code combination to identify
ext_required, so I think we should retain ext_required checking.
