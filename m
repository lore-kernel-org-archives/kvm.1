Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED53EFFD7;
	Tue, 25 Aug 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652177; cv=none; b=Ho8OeAOX3AUvPchJ6QLulpHuolWdpoE2etN80wvkVGmnJP4QdJKPk4cE4Rft+lSFqu+ZvE/jEsd90p6j3ZUJKNP+RsgzleDNss1FrMHD13V38dhVtMKgReZ9MuoYZTApR7LviwgqTRfFtK0O7QYPwHTNNJSssofZxo0Op5OFuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652177; c=relaxed/simple;
	bh=umoMD7pUegKRkmbc+H5XgwphilE1QXb0fWCCgjQ9etc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhhZvuFwGsdw3jQm//6DOrFdETBLHFqLvYYlwhrvYQRV8rZt1CVK4QO1rZ7GAYFY6fmJwjrHOXgXpdScEx3mOZrSc4mvmHYSYwSNFFZ7N6nLHFhW5hbjs86oz/71E4lro8zrA2YRsJBmo/GZM5Om0Vn/0O5BKJ8CsoQ85q1eZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8/VEAVs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8/VEAVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787652176; x=1819188176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=umoMD7pUegKRkmbc+H5XgwphilE1QXb0fWCCgjQ9etc=;
  b=k8/VEAVsU4LJpqaGOyNDonE017wQtdJENyEotJx0dSUh1ldLvgZ8D+iE
   3ZxnOxpE/pWxAxzocLnStVbpfuotb2ewIa9s0ifeC0aqIWt6f28b4708B
   fYqsx5pJWMgizm9Oehte2+uAY6SJC0Ftduq/7ql0O01296Hibnty55Cj6
   QiqqqCXB17CX0smfVA82OE3iFA2n6bCS1/Mtgnqcaqnjs0xw+Y+KHvWbC
   H1cDJX3BbPyiS/8CAzjhhuWzWtm9cpxa08nSqiLihFZe36uJjYOe+Ah8g
   QlZw32MIi7RtTucUZx9C6a27J54RPJXF5AwZzcMb+81oVJoSvrCeGSqWS
   A==;
X-CSE-ConnectionGUID: NbOuc/A2TW+dMrxrxsLtLQ==
X-CSE-MsgGUID: Nof6qemIRhKpLsOeZzLQJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88132080"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88132080"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:02:56 -0700
X-CSE-ConnectionGUID: vS29JKjeTXCctD5eeK/0fw==
X-CSE-MsgGUID: Fvx40Ri2S+Slakyim30eFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="261114727"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 25 Aug 2026 03:02:52 -0700
Date: Tue, 25 Aug 2026 18:02:51 +0800
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
Message-ID: <ao1oS3HPP3mEjou6@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-6-yilun.xu@linux.intel.com>
 <f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com>
 <aox8DgpnSnhZRfCv@yilunxu-OptiPlex-7050>
 <e05f49c28a78de961130655a76f415b01774016e.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e05f49c28a78de961130655a76f415b01774016e.camel@intel.com>

On Mon, Aug 24, 2026 at 05:58:07PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-08-25 at 01:14 +0800, Xu Yilun wrote:
> > > If that could technically work, I guess the benefit of the current approach
> > > is that it allows to use contiguous physical allocations. Not sure if you
> > > think that simpler snippet would actually be that simple in the real world.
> > 
> > I think there are several simplifications here, let's break down:
> > 
> >  1. Forget about the 512-page limitation for hpa_list_info, always add 1 page
> >     at a time.
> >     This can also be applied to current flow. So put it aside.
> > 
> >  2. The loop strategy:
> >     - read total memory size	vs.	- loop on error code
> >     - prealloc all memory		  - alloc a page
> >     - loop on size			  - memory add
> >       - memory add
> > 
> >     The main saving is that we don't read memory_pool_required_pages any more.
> >     Others are similar lines of code.
> 
> If we don't read memory_pool_required_pages, then the only real option is to add
> 1 page at a time. Or I'd think you end up giving extra memory. Unless
> memory_pool_required_pages is rounded up to some higher page order? I think no.
> 
> But otherwise, if you are going to add pages many at at time, you need to read
> memory_pool_required_pages to make sure you are not going to give extra memory.
> At that point doing the allocation upfront (before the error code) is simpler.
> Hence, the design in this patch.
> 
> So I'm not suggesting to change the design in the patch. Just that if 1 and 2
> are really slightly simpler, it's worth justifying the design in this patch as
> for the purpose of reducing fragmentation. Otherwise it looks unnecessarily

Good to me.

> complicated.
> 
> > 
> >  3. But we'd better keep reading ext_required. I tested when ext_required ==
> > 0:
> >       - tdh_sys_init() returns TDX_EXT_MEMORY_POOL_REQUIRED,
> 
> If we don't config any extensions, tdh_sys_init() returns
> TDX_EXT_MEMORY_POOL_REQUIRED? Seems like a bug.

Maybe. But it also indicates calling tdh_sys_init() when ext_required == 0
is not architecturly defined now, we should not rely on that.
