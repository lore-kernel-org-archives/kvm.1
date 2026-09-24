Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC43E8695;
	Thu, 24 Sep 2026 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790225104; cv=none; b=C6zUUJ8MdoJL5IBjGNo/E2ovvkE035ZXZL3cKmozlpsxNfkZRznGTnAOutWQ05IcCUIiIFQm+PL/TlMN9ynYouRt6a8m4r/kC8DgQJyGXvOnk5/JGNB6asA6RpoIr77NYvE/L7X+EJNBWPThiCLsWOt/dqaydiWegUII8+qwTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790225104; c=relaxed/simple;
	bh=agPT9SlH6VsmrBH4jjTpvmlysrIOaMt+zgXF12oTtrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0eWIV7sopXko8/tR1DdsyvAzlZHOL+ARYEU3ohDuXZ0fnmoh4pszsnJAfG1Kqy3pJbpfIuq7m52NpRapnmLvex0m19WEG+q+eXkHcFkbktCUvBqZ6upMAb2L4LKSRy52bLrvsg6eif8YJpDxQzKnbmLLD9EWNhxzSm7tLiKHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsIuuX/k; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsIuuX/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790225102; x=1821761102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=agPT9SlH6VsmrBH4jjTpvmlysrIOaMt+zgXF12oTtrY=;
  b=NsIuuX/k0yfn0ozHm2EcTy64skt1izvOXg0GjQVc0nUu4UyCGx7pnbGN
   /xJM/zbED8kFavZU1NaUuzfvo/xUSO2AMRupy/1pBnNdURA4U3b+D+Bdh
   xoqBV2oY78JQP0vFe3sn/nv0Hf/Yfv3DrssyKuuIxYfY2fmDn7YzX3zeb
   gzs7fMN1pfmS2OUNQVb762EpdXaQvtDjmiRNfpcZmbMW81CM6PTCOvwfI
   GMvqOCnhKJ+DT3inDzmljgQ9z7r/MEnYH+mWNHwPn4WA5Iz/j6FH8iNYe
   IuEWFyGqBUEDikhPgq39hsYEjRBt2gYlitoDJuMeH6V5or6wHDBQC2GQu
   A==;
X-CSE-ConnectionGUID: zus0JETvRFS2E1dAz/WYEw==
X-CSE-MsgGUID: 92Q4MU74RVS8qGR/tzo45w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="107370642"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="107370642"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 21:45:02 -0700
X-CSE-ConnectionGUID: YdJJONx7TyGiYfCjBYG97Q==
X-CSE-MsgGUID: HdADNIECQj+gHNskzbeoRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="272510957"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.13])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 21:44:57 -0700
Date: Thu, 24 Sep 2026 07:44:54 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>,
	"Wu, Binbin" <binbin.wu@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Message-ID: <arSqxhfuBXA1nDkr@tlindgre-MOBL1>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
 <arOEHVklXn3VGBQt@tlindgre-MOBL1>
 <9b5b78ff72d263e43e49b18b0035c0aea8846d51.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5b78ff72d263e43e49b18b0035c0aea8846d51.camel@intel.com>

On Wed, Sep 23, 2026 at 03:50:10PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2026-09-23 at 10:47 +0300, Tony Lindgren wrote:
> > On Tue, Sep 22, 2026 at 01:52:14PM -0700, Rick Edgecombe wrote:
> > > In practice this bit has never been set by any TDX module, so flushing
> > > is unneeded. Going forward the TDX docs will be updated to clarify that
> > > CLFLUSH_BEFORE_ALLOC will never be set in any future TDX module either.
> > 
> > Should there be a separate patch first before these two patches to bail
> > out if the TDX module TDX_FEATURES0 CLFLUSH_BEFORE_ALLOC bit is ever set?
> > 
> > Then dropping the related code would be safe to do without having to
> > ponder if it's safe to do.
> 
> Eh, I don't think we need it. If docs are updated to say TDX will never set it,
> then we would really be sanity checking the TDX module specs. Doesn't seem worth
> the code.

OK. Maybe just say this bit has never been set for a TDX module to make it
clear. The "in practice" gave me an iffy feeling if it's safe to do.
