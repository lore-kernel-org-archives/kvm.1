Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A38390208;
	Wed, 27 May 2026 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865791; cv=none; b=DMwggTtNhelKnZrCwm7kjiVPgqbcpA/BOQZmTRu/oMQ8Km/mcr2Q5H9M26FrDnQ2dJhWlMtE9uaj8WRdOp/XBYqHW+A8MxQexX6c1mjQQhJdKmKF3tldkp+IEkypC3OV+rQNr2kbtvnOE3TzdYf1fbII35z8DZhSkeb8PZMga7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865791; c=relaxed/simple;
	bh=kMEWNbNoMAznJR7v7/mCHFXg3jmyA0+Zh4Ij7rjskU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow5nsb7aq+EJc8yjErZ/kjdz5MSJ4Lc9t7Mn1qDjltIMFdKh3VztLeIFfrcZBvTQXfhYsrLgAHRWult5Uglr0dYLFwpw0oRs9nAqQRsv6A29K3YYa+zHuLjCC3SM1nWSUsfPWuUjcPfNXnApc+xjd9DNaI0PETi9MTGQGhIoVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGSl9PNu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGSl9PNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779865790; x=1811401790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kMEWNbNoMAznJR7v7/mCHFXg3jmyA0+Zh4Ij7rjskU4=;
  b=eGSl9PNu6nAirMwLTnb0PW0oBcpPwqf2CU8INr0C/rJn7T/dRmTw6LWK
   iMIuLiOZPzB+V+XfhvPyLwtkPR5g20Ga3K7MqCHpAOMANMrs+ryTATlfx
   /Y0RpmdQg56kiR1SI/h8ifmTFztPfgzcRuZV51PT/OKXBusB+V1Y02Yyy
   X1wrDx5O7YZNFk+533fwLmBeXFQ+5P8UEw1aCFz3zBLV92MEwXJjSVEPV
   Y4nqz6YGLRD8l8+YdSIEOi1vfcSASChdHcdEQuDmHjPfFXWJBj9zPW13B
   HvtNEqYhV3noerXjVLsC6si8N+SqzwWs4WqvbbLQsxhRAvI1zXoXf7j+f
   g==;
X-CSE-ConnectionGUID: kIEveZoaQKqOfefZLin8eQ==
X-CSE-MsgGUID: 1QWV3zomRGGJQsjOAIaUmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="79836785"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="79836785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:09:50 -0700
X-CSE-ConnectionGUID: 2pMzrPZjTI6N4MJ6JtwUFQ==
X-CSE-MsgGUID: ttOAETmZQPybnsITKnKC8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="280275664"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 27 May 2026 00:09:46 -0700
Date: Wed, 27 May 2026 14:45:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com
Subject: Re: [RFC PATCH 14/15] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
Message-ID: <ahaTH+O8YGxEXSpz@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-15-yilun.xu@linux.intel.com>
 <90a4835f-bc11-4415-a7b6-84347f40861b@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a4835f-bc11-4415-a7b6-84347f40861b@intel.com>

> >   /*
> >    * TDX module SEAMCALL leaf functions
> >    */
> > @@ -31,7 +44,7 @@
> >   #define TDH_VP_CREATE			10
> >   #define TDH_MNG_KEY_FREEID		20
> >   #define TDH_MNG_INIT			21
> > -#define TDH_VP_INIT			22
> > +#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
> 
> how about
> 
> #define TDH_VP_INIT			22
> #define TDH_VP_INIT_V1			SEAMCALL_LEAF_VER(TDH_VP_INIT, 1)
> 
> and use TDH_VP_INIT_V1 below?

I'm trying to avoid a _Vx postfix if unnecessary. Don't make callers
have to choose between versions. The main MACRO should always point to
the latest version since later versions are backward compatible.

The next patch is an exception. I've found there is no public TDX Module
release available for TDH.SYS.CONFIG v1. I expect people just use the
un-versioned MACRO for development, but have to keep the explicitly
versioned _V0 macro for compatibility for now.
