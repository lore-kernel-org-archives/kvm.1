Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACB38F624;
	Fri, 29 May 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076651; cv=none; b=gr1NH5V96gosWd4tkYRnLR8LsX4EtYYEvTlabenkEIlW3k0zIJg50igUCIQ88/zhdAg5+LDc+3Jna0pny+jMWIJmwA2kL9CsySgTLEWR3vdiccxv1rAiojUfbZBtznDZmCzrJQiuw8If9G1WvWNBXx6y55lPVRc3tg1qpjmN5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076651; c=relaxed/simple;
	bh=FKc+svRO19HrATmI3eqJ+7EYqXRQ0rpZ18W/mWBDKXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLFnS+NszYcLdgZsJ3RuD+ePvJB+JvBs7Ae9EYedbn9jWz53Mei8u21zUujVn3T2BRLhUWHmE+GNkWUluuL7abE+ScW4BnFzYNm1yJZ/brE0oturWjY/A5vh76C938iSPJM4KCSt4OzLVR7MJ+AnyFSHv8T2iRmUsb8Gx1bYqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIVSFkA+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIVSFkA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780076650; x=1811612650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FKc+svRO19HrATmI3eqJ+7EYqXRQ0rpZ18W/mWBDKXI=;
  b=VIVSFkA+9WV2O6X1vK+JngwQ3N+FwGBHKL1bdVZ2PR0RWy4wqxsdkUOh
   7wMVNThAABr/l/sqnbcyw5Q0ikq2RWNLjWyWaLtG1QLAixwgVFAeaEIi9
   HgH9LHRLJjdwSL7VD4EQClILWdfZErW0YhdDdLHrH2mhIiJGLJ951Jnjf
   oClDf/MzW3TQED4CeyXHuKwaXvL3Cr75CVZAgVKkXsyCYZ4p6HIalnr5h
   Xdz6ctksj6yJsDa3/af8Xn4iFFhRTB20+Y7P5jP2vHSIM+h5VxMd1/IsZ
   MPilbGabBF79ElXoSx9Rrdy7aeU0PQbI+m9XuCF7p06DfL2d9zpqaof9X
   w==;
X-CSE-ConnectionGUID: dtsGZSbFQpevl0aB01CgEw==
X-CSE-MsgGUID: Ei8F4BCcQX68ZqPLnax6mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91506904"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91506904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:44:04 -0700
X-CSE-ConnectionGUID: GgOjd1jETSOrwO5g/k5bAg==
X-CSE-MsgGUID: grdO315CT0CshYA8goA0cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246917066"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 10:44:01 -0700
Date: Sat, 30 May 2026 01:19:57 +0800
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
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
Message-ID: <ahnKvbKoLH9Dp8xG@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
 <280fdea480922ad843e738b14f0b32cd977734a3.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280fdea480922ad843e738b14f0b32cd977734a3.camel@intel.com>

On Thu, May 28, 2026 at 09:32:08PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-05-22 at 11:41 +0800, Xu Yilun wrote:
> > The detailed initialization flow for TDX Module Extensions has been
> > fully implemented.
> > 
> 
> I'm not sure what this means exactly. Why "detailed". Is that important?

It's not important. I should re-phrase, The entire initialization flow...

> 
> >  Enable the flow after basic TDX Module
> > initialization.
> > 
> > Theoretically, the Extensions doesn't need to be enabled right after
> > basic TDX initialization. It could be enabled right before the first
> > Extension SEAMCALL is issued. That would save or postpone memory usage.
> > But it isn't worth the complexity, the needs for the Extensions are vast
> > but the savings are little for a typical TDX capable system (about
> > 0.001% of memory). So the Linux decision is to just enable it along with
> > the basic TDX.
> 
> The Linux decision is whatever this patch turns out to be after community
> review. So for the patch log we just need to justify why it's a good idea, not
> not make an argument to defer to authority.

Understood. I'll re-phrase this paragraph according to all the comments,
especially the last sentence.

> 
> > 
> > Note that the Extensions initialization flow will still not start if no
> > add-on features require Extensions. The enabling of add-on features will
> > be in later patches. Until then, the system hasn't consumed extra memory.
> 
> Hmm, this patch reads like we are finally doing the initialization up until this
> point. Then it turns out we don't actually light up the new code yet... 
> 
> A lot of this diff is adding __init to the function added in the earlier
> patches. Do we need to do this? Why not add them as __init in the original
> patches?
> 
> 
> I think we maybe want to say instead that we are setting up to enable extensions
> at TDX module init time, and do the explanation of why. Then without the __init
> stuff, the patch is just about the init time decision. Which seems about right
> sized.

Yes. Since the patch doesn't actually light up anything new, I think it
could just be the first patch of Extensions so add __init at the first
place.
