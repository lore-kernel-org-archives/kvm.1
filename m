Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2F4C77BA;
	Thu,  3 Sep 2026 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447954; cv=none; b=n42TdGxoTBN7my5J2FMCUTb5kD4vOK2jRoewLt9k5EI3ZVHbbIVeE6rM5ob9VNR+z1eAhn6ivE59tvdroSCernHGP7M/sCEtviVNuST22MTuitv5IeDUot/DzUavJVB2H6QrCpAc0nqo3pEzU/+SyUhoZsu7h5h0jeKla+haZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447954; c=relaxed/simple;
	bh=eazYFU1WdrM+maaWAMQSZUR5F1W/1naSEK3ISWsJw9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed4dahbEhPsqtVv0XScjfDQZpX+0ht73ADeuZt+bNyA8xyOzuwGon33rx/YiL0/sYwD+n0WXHBsDooGSqnHAtt41tGvbgDoGOOvyssUZncYR4ZvNcmm57Z6vg4B+abbRM+MBBbCGRlIGdXV1zAVmyF4wdMZ07TeRSMIlzKAS9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkunYjW4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkunYjW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788447953; x=1819983953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eazYFU1WdrM+maaWAMQSZUR5F1W/1naSEK3ISWsJw9g=;
  b=nkunYjW4ZXrMXFoA3qHRxctlymXH74swhnXAWzC8bs5jOQ1JsbMU042F
   akGlisa/rq71bx9/Zs4poHO+v79luQP0Cc23iYmuy2/E92tX1bYsz6PtG
   LD2rVUl32Gey4F7Yhuxl/VtOPq1fwmjrP8ugsKG3L2u/8ul3/Jx881rIr
   ja2iFFFmxZgDry8slIXQmd3BcKP+nq+Dbj7wMNJBg9E0KrE9Yhu+IFgVX
   2hJDUw4pfM/MZHtex0H4ZLjA/0EbYuUAtwxy/KumSHWxUnIVsml5rRVlD
   pKHgenbznEpK5KTPe6uTjsQPBlTIl1+/3aMPKo3lUY7Z1/+mCOJGu0Q6R
   A==;
X-CSE-ConnectionGUID: dYjHVmSFTJOhB8xvZgZtNw==
X-CSE-MsgGUID: nK1HFtxNSXqBRkAJDeQwCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91444127"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="91444127"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:05:52 -0700
X-CSE-ConnectionGUID: b9clsSjjR3Sg112bFYiWDg==
X-CSE-MsgGUID: AFsP3Y7ZSLW+/Fjlausx/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268443987"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa010.jf.intel.com with ESMTP; 03 Sep 2026 08:05:48 -0700
Date: Thu, 3 Sep 2026 23:05:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: david@kernel.org, linux-mm@kvack.org, x86@kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/virt/tdx: Add extra memory to TDX module for the
 extensions
Message-ID: <apmMy9610sunPJeE@yilunxu-OptiPlex-7050>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
 <aohvlMO7ehqcVW96@thinkstation>
 <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>
 <apE8yHrGx/bfifV9@yilunxu-OptiPlex-7050>
 <apf6WFKun8z4ejG8@thinkstation>
 <aplOhHWvaxqUJDqu@yilunxu-OptiPlex-7050>
 <aplSf00ESix5s6Ak@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aplSf00ESix5s6Ak@thinkstation>

> > > What matters for fragmentation is not contiguity, it is how many
> > > pageblocks are left partially occupied by unmovable pages that are never
> > > freed.
> > > 
> > > So you can ask one pageblock at a time with
> > > 
> > > 	page = alloc_pages(GFP_KERNEL | __GFP_NOWARN, order);
> > > 
> > > with fallback to lower order if you must.
> > > 
> > > It also fits the ABI: pageblock_order is 9 on x86, i.e. 512 pages, which
> > > is exactly TDX_HPA_LIST_MAX_NR_PAGES. One allocation is one full HPA list
> > > is one TDH.EXT.MEM.ADD, so the allocation loop and the chunking loop
> > > become the same loop.
> > > 
> > > But alloc_contig_pages() might be a good enough approximation for
> > > per-pageblock allocation if we do it during the boot when fragmentation
> > > is low.
> > 
> > IIUC, you mean alloc_contig_pages() also gives good de-fragmentation
> > that we need. But it would be slightly easier to fail cause it requires
> > extra contiguity that we don't need.
> 
> alloc_contig_pages() can be more expensive than needed (or fail) since
> you ask for the full allocation size to be contiguous, where you should
> be okay with a set of pageblocks regardless where they are relative to
> each other.

I see.

> 
> > Multiple alloc_pages(order-9) meets our requirement exactly but the
> > falling back to lower order may create more fragments. And we can do
> > this because of the ABI definition - an HPA_LIST could happen to hold
> > an entire pageblock.
> > 
> > If I have to choose, I prefer alloc_contig_pages(). It doesn't have to
> > depend on HPA_LIST ABI details.
> 
> As I said before, as long as you do it once during the boot, it should
> be good enough.

Yes. Thanks for your detailed explanation!

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
