Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75C3803C5;
	Fri, 29 May 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075425; cv=none; b=AxblnkE5KsZHKbJNRpjVc/eYnTrIN4POv4fBY732je8wY8TGYkyJ2HHTD245yBPo+yNYozsZWbVV6ftGij2LQYkmSrKV2KjVbFR+3hafUtgJ2Zqhwke3eG16gvg0ybFBxE4GsTJbLW4E/2LBTKnyv5EXEMzk4DHxAcgv0YzzJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075425; c=relaxed/simple;
	bh=KQs35uPOA5phiqR06qwJF6YJyYn7SQLehtvTLXeqTn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiZVGVVtM72iFtxUm/MuY2QuSjJbhXCIQb+/DaxBpWO58IQrfVyHFGmBtBi6sWVOi8V2S9+ejgaL+ALQp/YVTPYOFTbOoaKjIGbXxzdmx+uhLEqW5vALdubHI0g9nlZarHCgWSP+pNxPBc9lSa/qXDjBwJQtDDjmDYi2ifg8XCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVkND6ZR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVkND6ZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780075424; x=1811611424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQs35uPOA5phiqR06qwJF6YJyYn7SQLehtvTLXeqTn0=;
  b=HVkND6ZRFS75q6+GD1+H9S3eSSPoi5QDdIlH36jRsTpD3hJbj19DkvJ6
   iwdD0LDKrwu5rnG9hQNOGnZXt8WhSdSLOwruqAYbfY8VCpqRAb3FC4uVR
   TnGVmcow5bxBvqLDxTuRu9EbZIpOouZbVNBxc8td/7XsXUDOMtJCXxs5l
   bxULDXJsG5kUJqWZjxnEDWs0ZC2lobWdGF0F8KpciZMPoKn88KbH2EKkV
   SO7Pjw8hkbRRyiPYC3EktK56ylmSeJRV3KbArkyCFboPPnh1vWrEhnI25
   i3tzcS0pRab/x2wEg1+kbi8cb3jYLZxln7T4ju038y4VDVppZSFMwuobQ
   g==;
X-CSE-ConnectionGUID: gcdiKzsDQ6mTMbnL6ndK5g==
X-CSE-MsgGUID: q5Veps2fRj6S4HND+btMPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="92405682"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92405682"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:23:38 -0700
X-CSE-ConnectionGUID: YuW2+6n1TbK8t9cQpEE5mQ==
X-CSE-MsgGUID: fTvvJfaBTAK0SYAMJ3cKww==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 29 May 2026 10:23:35 -0700
Date: Sat, 30 May 2026 00:59:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Fang, Peter" <peter.fang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <ahnF9Zwj7IgG9s6d@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <fd3f9e1f70babe97f98852f2a705341b86ed1132.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd3f9e1f70babe97f98852f2a705341b86ed1132.camel@intel.com>

On Thu, May 28, 2026 at 09:00:12PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-05-22 at 11:41 +0800, Xu Yilun wrote:
> > +struct tdx_sys_info_ext {
> > +	u16 memory_pool_required_pages;
> 
> > +	u8 ext_required;
> 
> The docs say this is a bool.

mm.. OK.  We don't have to follow the auto-generated format now, so bool
is good to me.

> 
> > +};
> > +
> 
