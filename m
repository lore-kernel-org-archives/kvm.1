Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF43B813E;
	Mon, 22 Jun 2026 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143307; cv=none; b=qhWOm41ZAOUhqQChlkrqMrj0LMEyA8Fp1dSeON2NvlCIzVyVHd35oW170JvgmPWNnhHNjZwTHjLYRSzy7YRc7RnqrphV+WACoDSTbxo+nOUPlhikuCzH9fnWbot7pez/XWPNpcDuP4zwLYMZfHIHSgsXiAFRJ+ve8RYr5PjmXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143307; c=relaxed/simple;
	bh=3dplIcanhOVWBZQ1EC/lpPSbAuLWj9dtJulwpT8Cwwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHDwCzIf0z6H8htGwxmZxy7/TAcCxIkADbxdmTRxzXVOt7yS3tkPpjH+3NUOZUE3FXK4uoypAavK7pU4D/02vo0qVIF9oI4f5XCVIK1StaZe76eL+UVTn9Lipm8mY6TCGarH9WnqvREWum/Ryg59Vle9kxAMI7tguiPZ8uu+PYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hksrf1sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hksrf1sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D1B1F000E9;
	Mon, 22 Jun 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143305;
	bh=ld9ijHTMZKBzCcjtyWIwxgIs4KRDg6NBq43WCQOREXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hksrf1slb3g0P8qdFp9lx8C3DXXPnzep8daVfJmQpnKp15/sNkWjHOIt3gOb+Xbif
	 iExQ8wnSkci/HJ5WfO7Lj9J/axGDVEz1fUpkJL6E1DmUOaKDtmuM1kxfIz8OTwo2vx
	 JDbKpAXikAa7mIV6Q6CSeXiox+ibTBzeqE5sl6fgHLpMIIn0TKnzgsvWTOhvAuhvKk
	 hrOLM2IF2HcaEsgVjBfVKYJAk8ZUNXsIof50IWoB4UG9K2wNkHhd4Mzas1OYK05nWm
	 44o2YO+Y/sx5J3pLQR5dPFwRaaF6Le/SM2dWyEhLFtM+XGMQGILDjPI6Fi5wANeqWx
	 npGxJ3Q/3rKDA==
Date: Mon, 22 Jun 2026 16:48:19 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Anthony Pighin <anthony.pighin@nokia.com>, linux-kernel@vger.kernel.org, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajlYwMYswMO1LUXk@lucifer>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <160f8cdf-0d26-43f3-b487-4181e6374782@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160f8cdf-0d26-43f3-b487-4181e6374782@arm.com>

On Fri, Jun 19, 2026 at 04:04:18PM +0100, Ryan Roberts wrote:
> On 18/06/2026 15:55, Lorenzo Stoakes wrote:
> > +cc Ryan for contPMD
> >
> >>
> >>> And maybe there's a CONTPMD architecture we should also consider?
> >>
> >> ARM HW supports "CONTPMD" but I suppose it is not implemented..
> >
> > Maybe Ryan has thoughts?
>
> Sorry not quite sure what you're asking so will give a generic answer:
>
> Arm arch does indeed support CONTPMD at level 2 in the same way that it supports
> CONTPTE at level 3, as follows:
>
> +-----------+-----------+-----------+-----------+-----------+
> | Page Size |  CONTPTE  |    PMD    |  CONTPMD  |    PUD    |
> +-----------+-----------+-----------+-----------+-----------+
> |    4KB    |   64KB    |    2MB    |    32MB   |    1GB    |
> |   16KB    |    2MB    |   32MB    |     1GB   |           |
> |   64KB    |    2MB    |  512MB    |    16GB   |           |
> +-----------+-----------+-----------+-----------+-----------+
>
> For HugeTLB, Linux/arm64 support all of the listed sizes today. For !HugeTLB
> (i.e. THP, large file filos) Linux/arm64 supports CONTPTE and PMD only. We could
> (and probably would) extend to support CONTPMD once THP PUDs are supported.
>
> Not sure if that answers the question?

Thanks, that's really useful!

I think Jason's concern was that we'd have to account for contpmd here, but
that'd only be w.r.t. THP rather than hugetlb, so we're safe for now I think!

I guess this would be a new >PMD sized mTHP size which... I really hope we have
the THP code in better shape once we come to that :)

>
> Thanks,
> Ryan
>
> >
> >>
> >> Jason
> >
> > Thanks, Lorenzo
>

Cheers, Lorenzo
