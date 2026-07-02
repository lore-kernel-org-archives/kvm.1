Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F230FF05;
	Thu,  2 Jul 2026 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007902; cv=none; b=k2QpzCyjUGAbH5S23Shs4DfyS+T+Bsmhbx0nwfkCnTzFuxHfDhSkeBSe8owvfRZeY63rkgDAPB46chiEmDhlc1yqFFy3r0ywuOiRSpu+m8G+ZsmK14xgC6ikZL9q/srhLW9GsPNTSgwPTGfbKUx0R6aJgChOj/BpT3W0NEuAGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007902; c=relaxed/simple;
	bh=xhq9w/9tnMCDOgwOyF9DS0BAzJjyfTEchCrr31Xjyck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kItvvwT7JjZ6k15AJphduD6JbOPQE6zbLqy1r/7J6gRYssVyM5NNZ+gz2zJ+HX85YDA+OFcoQF1UftX9aXg2djKEdnWvisDkb5pGUk8mY8/rmwytXuwlxgZZI+X3iAIUZEjkEgugH4LSPnqzbGlwvRbMLQ0vMjDoPoUtxcwrJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gF6BhY6i; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gF6BhY6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783007901; x=1814543901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhq9w/9tnMCDOgwOyF9DS0BAzJjyfTEchCrr31Xjyck=;
  b=gF6BhY6ipZDLQzBkqgo294ccbppdlWx0dAr7+GZFLwuVyXZLH3ILzcyn
   Wg1udc34kHjSg554jh/lVg42LM5iIGM2T7JqBvR/uE89sCKoOsvsh+YqO
   BZvzwp/xnD76jJQD+GGDNwFyvP0INyPRAhLn4VRU0HcGYircvbWk2Nb70
   rMdn0pl9lKfcYzU+mQp6ICh77IYFU0ch1OmbLAob4oWIPe/EbOKxYauxb
   tOiRkfprtTIxvFCqXQ3Xdvb3PXZmiMI40w8sZdUcbgo58oAGzS7cqveE5
   zYTX+KuZHZDEdTM34gjxZ5Pw3d9GMfYPsL3WICR4GlhSjEKb+NdjsnZNX
   w==;
X-CSE-ConnectionGUID: P/tGptYkSWOL6rc3Q/WY3w==
X-CSE-MsgGUID: fiQom4IATZGRIxjYLH0ZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83633961"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="83633961"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 08:58:21 -0700
X-CSE-ConnectionGUID: 0DPksBsXS0m3jAoYuzXj2Q==
X-CSE-MsgGUID: rseT8zX9RNKYiUez3/JN9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="256483603"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 02 Jul 2026 08:58:17 -0700
Date: Thu, 2 Jul 2026 23:58:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <akaKmEZnTY4FO2gY@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
 <a8441214-1560-498d-ba01-0807502d0e28@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8441214-1560-498d-ba01-0807502d0e28@suse.com>

> > +
> > +	do {
> > +		r = seamcall_ret(TDH_QUOTE_GET, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> 
> nit: This pattern seems to repeat a lot, might be worth it to consider
> introducing a wrapper similar to existing sc_retry?

We didn't make the wrapper because TDX_INTERRUPTED_RESUMABLE can't be
handled in a unified way for all SEAMCALLs, I see 2 conventions:

1. Host should set a resume=1 parameter on retry, such as
   TDH_PHYMEM_CACHE_WB, and several migration SEAMCALLs,
   TDH.EXPORT.MEM, TDH.EXPORT.STATE.XXX

2. Host just refills the previous args (may have been modified by seamcall
   output) on retry. such as TDH_EXT_INIT, TDH_EXT_MEM_ADD,
   TDH_QUOTE_INIT, TDH_QUOTE_GET...

Making a helper that can't cover all interrupted resumable case may
cause more confusing. BTW, there are already many seamcall wrappers, we
need to carefully evaluate if it is worth adding new wrappers, for now I
don't think so. 
