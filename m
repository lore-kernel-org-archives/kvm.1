Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF93CDBA3;
	Wed, 27 May 2026 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883771; cv=none; b=Qr3QuVTJ5s4eplTXa3SBclbA9WvmxETne8V+58vCZJ7weeop9+wV7t4vDQ8f+he2t4h4Zq78qTgienQ7EEQU6VYyB5HwTmuw/hUuErQE3+o8DtJZcWutaOvi6/Htm38AtopBqrgs/vy6Fgx1NBKRkewqRyndQZIeXG+1A4Zy+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883771; c=relaxed/simple;
	bh=iTL19uWaS2bpLpnZA/tSxOng8jmAExz/yKTFG4Q2bx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpEsmaFlAU0QAo1wTs/e+iUOzxJMUR6xiZKduoSffhe1vDNxWEDOO/EbxOK5xEiRTPEZQOC1qQNi2jxAhcCaBxS2d8zzehDwIimn5knnSB9PekXPMNO3uAsa0d0kr5PgH4mgZ2Srtb2nvS1K16jCWXwTow8n4hgBYwf0eEO/0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k87H3KfM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k87H3KfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779883769; x=1811419769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iTL19uWaS2bpLpnZA/tSxOng8jmAExz/yKTFG4Q2bx8=;
  b=k87H3KfMwcuVqoAg6NnxwfXZeo47dFSkNZDaoqANxlqS1JgAWgvh7Qko
   7PT9bkzBFm0K3ZvkWx+NWYsWoamKeW7emmgLRn6XWxbmW7ne7js/7ZzPX
   uTM2KOKy791kJobJl64hmWGMmc8iIymrpVXcd5d+mCif9wLkaJ2wJ2DBn
   l8VWx6KPqi+yfkiEbihOoyHUqFLNq8IReaor6J5Bz0YpKrN1uumdsGMDA
   xbK0a1Urxbg7Ga0UBFpdf9Nw1Xj3MZ3voeCg8sEisVnZC12WU4ErWJCbC
   oKDgwm4+caozAvGxe7+IcFZHyzNwUt4vku8J+7GU5zwBEeUOQofAsFA4m
   w==;
X-CSE-ConnectionGUID: YjoeIstPSomxnN3cJ7QYUg==
X-CSE-MsgGUID: Hln9CIoSR1u+wCcYEao/nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80822424"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80822424"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 05:09:28 -0700
X-CSE-ConnectionGUID: +WqbmjKhRm2X7ZStNn9Brg==
X-CSE-MsgGUID: gyjroSBTQO23425isE3TMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="239629885"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 27 May 2026 05:09:25 -0700
Date: Wed, 27 May 2026 19:45:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
	x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	sohil.mehta@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com
Subject: Re: [RFC PATCH 14/15] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
Message-ID: <ahbZWT+El709Aaje@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-15-yilun.xu@linux.intel.com>
 <90a4835f-bc11-4415-a7b6-84347f40861b@intel.com>
 <ahaTH+O8YGxEXSpz@yilunxu-OptiPlex-7050>
 <df4eb3b2-a11e-4d73-b298-af1beb92d53f@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4eb3b2-a11e-4d73-b298-af1beb92d53f@intel.com>

On Wed, May 27, 2026 at 03:44:45PM +0800, Xiaoyao Li wrote:
> On 5/27/2026 2:45 PM, Xu Yilun wrote:
> > > >    /*
> > > >     * TDX module SEAMCALL leaf functions
> > > >     */
> > > > @@ -31,7 +44,7 @@
> > > >    #define TDH_VP_CREATE			10
> > > >    #define TDH_MNG_KEY_FREEID		20
> > > >    #define TDH_MNG_INIT			21
> > > > -#define TDH_VP_INIT			22
> > > > +#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
> > > 
> > > how about
> > > 
> > > #define TDH_VP_INIT			22
> > > #define TDH_VP_INIT_V1			SEAMCALL_LEAF_VER(TDH_VP_INIT, 1)
> > > 
> > > and use TDH_VP_INIT_V1 below?
> > 
> > I'm trying to avoid a _Vx postfix if unnecessary. Don't make callers
> > have to choose between versions. The main MACRO should always point to
> > the latest version since later versions are backward compatible.
> 
> I don't agree.
> 
> The later versions are backwards compatible, but the later versions might
> not be supported by the loaded TDX module.
> 
> Usually the callers will have to choose between versions due to the TDX
> module being used varies, just like the case in the next patch.

No, we don't choose SEAMCALL versions based on TDX module versions. The
next patch is an exception, if by the time of merging there are releases
support TDX_SYS_CONFIG v1, I'd rather delete TDX_SYS_CONFIG_V0.
