Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A73F483D;
	Tue, 25 Aug 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651611; cv=none; b=R521s7qd6b5b4LAYWgLaTPBJoAobRKhTj4J3HIa9xRbyb9Aausc7RUPI2ZzD+s4RzcX10ZixY1IVGPW+n9KZ/chb4ArugwEaIv2Rp0H2KRibg4UrJmuVluDR0679d0OxUg7bXBOFhf+ZyIiHlEce4W1mAC73pnt4KLiqfZX9oAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651611; c=relaxed/simple;
	bh=xXFJ2OghgRWnlCERXbp1/tM3INoGRMhXbL7aq8ytv0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9o9jTjNDI3+M3ngU75p5GZhU1UWVYWhAaVIUaQoL9hacBZi0zlDlXBBcsqWdBZ/z2gWDiqXS4ljvziomUBXCoKMVeeEd2smHSCwhjfIcl+VJalYF56BtSBy342jECAEM4s8PiT89lAf/UJ7bfxfYvMrTEAnrmOgk4ONNYtUgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnlcOzMe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnlcOzMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787651609; x=1819187609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xXFJ2OghgRWnlCERXbp1/tM3INoGRMhXbL7aq8ytv0c=;
  b=MnlcOzMeLOsYlr9j+4uGOGnw8qcUDSda4A206EiV2sxdp1ca4LAQZWr4
   zgFpRcxEYKNHPC+/Yw7vzqXJUI5DJcwvhQvZYGaxcvnapn+OGdCwMrl7f
   jYmq12OsLj0ZiNka1HkvC5k12ik+nLF+OQkC4pEpz6ArjbUfDh2JbfVeC
   0PiUUgWQ7LpCeNR9+TMmW34GE2ihHKy3gxFCvQ1z1AQScN/d7YFxdgIh/
   F4WHvP80KIA+3zz4dSfkPahxiu84f7cZF+TFWcF1KnZyI0jlemrNRrQcr
   4FRLpaQnYpUbhofE7/jkqvyjpglQiWwN+lVJPUEpsSErKrQweoNCtRzn6
   Q==;
X-CSE-ConnectionGUID: u0HiZSk6RSmOMoUlUiZgrA==
X-CSE-MsgGUID: zCsMazmPSLmWQMYz34pEpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91795601"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="91795601"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 02:53:28 -0700
X-CSE-ConnectionGUID: FrocIrwCT6K6K6H8W5Xisw==
X-CSE-MsgGUID: 1e3zZ4t7RbaV3FJOI0YjsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="266696773"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2026 02:53:24 -0700
Date: Tue, 25 Aug 2026 17:53:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Message-ID: <ao1mE3boGj0Tok2y@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-6-yilun.xu@linux.intel.com>
 <f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com>
 <aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050>
 <6ffb491ea0252acd60982330be1e7ca1e8dcb23a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ffb491ea0252acd60982330be1e7ca1e8dcb23a.camel@intel.com>

> Not specifically. Just wondering what it is doing. Like is it the big operation
> to prep the memory, and ADD just hands pages which sit on a list waiting the
> real work?

Yes, TDH.EXT.INIT is the big operation to prep the memory. ADD just hands
pages.


> Or more like a "we think we are good to go" notification from the
> VMM?
> 
> >  I can think of some case that TDH.EXT.MEM.ADD is not
> > needed but the extensions initialization is needed. For example: after
> > an compatible TDX module update.
> > 
> > I may ask the TDX module team to get a better understanding.
> 
> That this is also called during an update just raises further questions to me.
> If is doing initing of the memory, then what happens during an update? I'd
> expect memory would need to be persisted across an update, not initialized. Or

The update of the extensions is just like the basic TDX module update.

			TDX module			The extensions
			=================		=====================
execution memory	SEAM range			Added by TDH.EXT.MEM.ADD

binary loading		P-SEAMLDR.INSTALL		TDH.EXT.INIT

initialization		TDH.SYS.INIT/LP.INIT		TDH.EXT.INIT

resuming state		TDH.SYS.UPDATE			TDH.EXT.INIT
(consume handoff data)


The extensions memory is mainly for their own execution context, code &
data. During update, the execution binary of the extensions must also
be updated to match the new TDX module binary. That means the execution
context is re-built, the memory is re-intialized.

> it is doing something different when called after a TDH.SYS.UPDATE? Does it
> consume the handoff data?

So TDH.EXT.INIT does mostly the same after update, it re-builds the
execution context from scratch. The difference is that it then
consumes the handoff data if any.
