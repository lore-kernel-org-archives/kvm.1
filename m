Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB02E7BD3;
	Wed, 10 Jun 2026 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069897; cv=none; b=VWALJW5bkawEOWPC+8NviN5k2NLJwn763w9zKrLc6SFVpjxVw1TQb6Wp81FKKrLHL13Pf/Hw7s43x+qU5R8Kg1+OZYK9D1IXeYTGz430mX4MEJT0RWUhr8B5DTOh1poJLd51WaKpk0IBK5QR+QwhOSqlrGtvPBAAPjBgN7utSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069897; c=relaxed/simple;
	bh=lguz+8GE2iaSvo/721gTDmTxQ23dKCNk7jm8lbT+Wyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8WhwCUH4asHLNEFAaBQD0qvvfnpIqOGrCJG7FH2Yi+MYKxtvsc+K66Wb3JWrWBGARnmaJCLCMaX1wZZGIqomCSI+FdUctju30AgqeNXlPvAwaW8DptxQrtOhHfx1P1Z00Dtm/xgZhtUGKymOhdCE54Z1gyiuy1pbuv6H1z+Cqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bM6aRGes; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM6aRGes"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781069896; x=1812605896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lguz+8GE2iaSvo/721gTDmTxQ23dKCNk7jm8lbT+Wyk=;
  b=bM6aRGesAJQFht0ewvI2Whb6Fm9H60d+gERwsP2goHe3NzSatjryW1CY
   H8NXu84hWOdKVA74vZ9dWGscrF63HkpSUL44UyeCGQPUbTS14nsKFSf7v
   K6poAGib0ftZUDJ0YBvbsULrzRDoBlEuZs0v95JpzReXDXRs8K2pVY1oZ
   zMx1BULaop12Q7vDwcBMogOlmdciN6Kqj10X1jJy+JQyG2EVgMbK/XGZm
   QlwjiyMbdinWYbK322cKjND2LpgdtGhIC0jqDlwM2l9w6bZw3n7Iazw3b
   b9clQa3gBiBD7v/3dpmbpCQudM1lU5wJC0roMZ+EaQd5ltu74ZAsZtjH5
   g==;
X-CSE-ConnectionGUID: eMkK39mYQB+ZhQ+x+SiVJQ==
X-CSE-MsgGUID: S/cr6QhOSJW2drBV7+laDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="82045878"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82045878"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 22:38:16 -0700
X-CSE-ConnectionGUID: V7BGkkc6TIa82trgQ9B33Q==
X-CSE-MsgGUID: S22ud4m3TFSyywdgibCbNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="249995694"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 09 Jun 2026 22:38:13 -0700
Date: Wed, 10 Jun 2026 13:13:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Message-ID: <aijygJ9YqskIOvB3@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <f7238ced-73a0-44f3-8a50-23eb5a2da5dc@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7238ced-73a0-44f3-8a50-23eb5a2da5dc@intel.com>

On Tue, Jun 09, 2026 at 04:38:31PM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > +static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rcx = to_hpa_list_info(root, nr_pages),
> > +	};
> > +	u64 r;
> > +
> > +	tdx_clflush_hpa_list(root, nr_pages);
> > +
> > +	do {
> > +		/*
> > +		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
> > +		 * override/update input parameter RCX, so the caller doesn't
> > +		 * have to do manual parameter update on retry call.
> > +		 */
> > +		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> Kishon already mentioned checking only the status

Could you elaborate on why we should mask? I assume the mask is only
needed when the lower bits ([31:0]) are defined to contain extra
information. TDX_INTERRUPTED_RESUMABLE is not the case so we could make
the code change simpler.

And if some non-zero bits appears there, it is a Module bug that we
should not skip.

> 
> > +
> > +	if (r != TDX_SUCCESS)
> 
> Similarly could this also be TDX_EXT_MEMORY_POOL_FULL?

I don't think we should pass the case. The Module provides the number of
required pages via metadata, host follows and feeds pages but the Module
said "Sorry, I'm already full". This is inconsistent behavior that we
should call out.

> 
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> 
