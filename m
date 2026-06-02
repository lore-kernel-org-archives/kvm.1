Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB53148B5;
	Tue,  2 Jun 2026 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380070; cv=none; b=CjtrtEK2OvH7BtpQY2eMXnFttqsu/tQ/EUIq8wR0i3yu4MPtNk6sAudGfBpjY7zgBb19UnE8hJrVN8WXVdPU8pusT9IJdzGkYGvVbq+rXxLCymRWtj3zyHq7ICVEiqQGuT5Dw/g0Brh0aYHDNjub9cqbiFBmXjcJXmRQteky06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380070; c=relaxed/simple;
	bh=pNgS2OCC0Ed4TOkh14WQNKus8irm4qgY+K5P9XD1wx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkMGFjjap7/rT1B0tcPOKseguFkJhykWeegpBYvmTI+koSg2aNKLFOSY7cbKw/C1PqMWWivwNKgilC7zpCXyMYURIE9vu622DU9BbN7DoRiU89AuWSygjlJd7v8Lq4TkDFAUk0lKpVRxFKn+iiPehMzdg2815H3XqCH+J1CGRbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma8WPPeV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma8WPPeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780380070; x=1811916070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pNgS2OCC0Ed4TOkh14WQNKus8irm4qgY+K5P9XD1wx0=;
  b=Ma8WPPeVVEnBIWYc6NqMhddXZPqnieT/qvyirjkCB4996sp68pUt9edF
   epJ4cXXqUY41etrQK/Tqc1KSffgMhVafrxeJesbQMIhiuSnppG5RdKrWx
   J4b9terg2NDvgGLp4NI4wVezipcQQRutttGS3nBy11TBel3xaWeGlLAYe
   m4kkzDeYeG2nKoWNf4fMkq985jsCcziiryXe5gNCJwF1hmtRC9yWQQwEV
   ZaXD4bVzYCo53DCuUMC8pnvH2mymGSBoR5lfrgoqLFr1+EH8SGhwss+gX
   ORQe4AyYKBrlxgeULiIj0MPFtrO7Nk8RmB7Pu2N26CtXPgWFp4z8VahQV
   A==;
X-CSE-ConnectionGUID: fLS+3EydSYuLg2B2/fLKvw==
X-CSE-MsgGUID: JP0NkCDASeGKsW1cMFGbTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98576385"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="98576385"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 23:01:09 -0700
X-CSE-ConnectionGUID: BkDZzs+uR7aas4oRj6HItg==
X-CSE-MsgGUID: r8ptpBQxQWeMR7B2eV9QNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="239372311"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 01 Jun 2026 23:01:05 -0700
Date: Tue, 2 Jun 2026 13:36:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Message-ID: <ah5r9IMsVeYVnbQx@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
 <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
 <e9b8083b-6747-4adf-9e48-ffae70dc6508@intel.com>
 <ahfJ9MW+kJp+kE6A@yilunxu-OptiPlex-7050>
 <7fdc27cc-22a8-4442-9c9b-4bace9ee0d23@intel.com>
 <ah1SnuEHuFeX873m@yilunxu-OptiPlex-7050>
 <9e6107a9-71b1-4764-96f7-2d8e68060173@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6107a9-71b1-4764-96f7-2d8e68060173@intel.com>

On Mon, Jun 01, 2026 at 01:17:59PM -0700, Sohil Mehta wrote:
> 
> >>
> >> Let's say a future platform has a lot more features and needs
> >> significantly more memory. Wouldn't loading a legacy kernel with this
> >> default policy lead to excessive wastage?
> > 
> > A legacy kernel won't consume Extensions memory. The Extensions memory
> > is only required by TDX module when add-ons features are explicitly
> > configured via TDH.SYS.CONFIG [1]. 
> 
> So, the TDX module will only report memory_pool_required_pages for
> add-on features that have been configured by the kernel? This would be

Correct.

> good to clarify in the cover letter.

Will do.

> 
> > For legacy kernel, no add-on features configured so no memory
> > consumption.
> > 
> 
> I was referring to the first kernel that has support for one TDX
> extension. I am mainly trying to ensure that a kernel with support for
> one TDX extension only consumes memory for that feature (even when it is
> loaded on a hardware platform that supports multiple TDX extensions).

Yes. The first kernel that supports for one add-on feature will only
consume memory for that feature. The other HW/FW supported features
will not be configured so will not consume extra memory.

I think I should refactor the cover-letter and changelogs based on all
these comments. Thanks for all the inputs that help me see what missed.

> 
> > But yes, if the features grow rapidly out of expectation, may need new
> > options to switch something off. I think if we discuss later when the
> > need actually arises.
> > 
> 
