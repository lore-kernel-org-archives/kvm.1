Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760340F8C6
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823593; cv=none; b=YF7ZKZeXJStzDWDU302tSFXabeswtQP8WrvwFImY7s+NVgkdD2oiWtzPnAF979iCXTKlHNUkeiuWPxsgZaQbaLY025017/QTkWHdHB/FLgihf7gceK+ji9X04F98pofCbbJOBmw/22W4DtKGddyYbYc6WvPWdy169FSXLvRxHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823593; c=relaxed/simple;
	bh=LOjEpkoZRwHdfuGyn4vfkIPJ0j24AraoSzsBg6t6qF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4O5ELLM4n09PNqA73FvEZZvha6bfXc+tt6LyBqrZX6ERtv0ZUuX2pRQnWr89AaVPHAxECYbho/q+15SDu3UQbo5Okssj1yP5n9wX3Ayc125zh0W7Xtc8NWrch38iIGbL11pTjmW6ez1r7U+cwyjBqOl7APtsXarxulBQ1CTJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ow6Wc6YX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ow6Wc6YX"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e4fd65b2bso171527585a.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782823591; x=1783428391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMWcMWjKS0wqXvKb/A7eCIYAkyOK+4MAXhS1U8rn/KI=;
        b=ow6Wc6YXOGCi+UDPAVkl3DSddtm0P2olIGy990Qy9UZCzhv4dln61ZVjJKNXWCVtYl
         B7N9pOYJyfSZvKSpiSd9m17KCQUjMO64Y1HBaTNiP7NAy5RbAutV73aU8epuynG6q7U7
         00HrC2qNRyCqdmULdxDRx6g2wvDyoI3vrynUKr/MVau9mJ2Jr6E8jcXc0SNiKmmCcWTY
         60EpOs8ZJ7+DZmnAvM1yM5CwGWhvJFWqhIq2wS2HtHUGqdefB1WBr0XbnUshg69sztC7
         4TnPq0jY6u+lCuR2pLTA29XI4DAjsWqemkiQXUkI95w8u5fDD9RNjlV/oIpt3XDP4Pat
         IGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823591; x=1783428391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMWcMWjKS0wqXvKb/A7eCIYAkyOK+4MAXhS1U8rn/KI=;
        b=q6EkkEKcQB/saRl05wXZZ8cyYueOTjbYvKD2PmfbhQIeiUi7uqAU0G4nxPm37G9zEz
         ipMZ2W9mKIGirMjD1fbZA/SQ5Ss+T70QpbKDiHait26y+WT2lfUQvHOMcurVYCVShn7n
         zIln1kKIQLKYfnQtkTEKhaHj2eqmx0fFxA1gX48iKalIdzPl/jk+IRjRpryMo7wqBkdL
         dbFi3AiuMOlRQD6NyxqkDRJhPUYq3WY8I+H6k7AZGXS5/9rx+w+KLTo5bYskkTFXLTTf
         f9aAkqPTNnMn1nrSFeN/5umlFJlLRbS1LcWL0YDdToeV2RWJr/GnB9LjwuYGOW1uG2B4
         Mbyw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZqdJZV+Zu+HsxQbSDixDLT1BsAMdczmhgv9zp6NAJMjFHFw6syxYIfE/5lcle+zu+vLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20XZ/ugW8C7TDYDa/iCcuA0RFIpKNJFeemVfaqsNSvVVjlJvr
	hZtDecpXXT8AnYnER1ZOuY7T78O3xnM9vms27E89abd6HWl+z0A2ZpTvP/l5C8U1XlY=
X-Gm-Gg: AfdE7cn9R8tNmjyQdv9b3uKKGCvFtvBpgGlvxM6eKBb+sxKLdDqOfCihufnUxdkvd4+
	Kg616qo0bt23t9qfylXz9j2M1aukI2D327cLZXErRTdpRFhZBYIj3/1pvL582foHOvDuUDf3OEQ
	weOqMTDXqojAMvcRZQp1boO7rS7atMNNpzEmTkjSwQAdPIkp2OkGPCArHkFJmWfmtJ0M7X13zQe
	n+DmUweNp2OuzZZbpNiSJK2Xe8AK25xua1tot7M8jAK9olw0pU2STDOGPhGopSLTlaGZKct3WIK
	+wu9RhWWUidTRsi25BMFnsfisHxeKal5FgLrJbrmN2mmFubx2Bf7zbjnjlVoLoe0lzSTKvWC7Ap
	CybYyIgSpQsnhffh3KajqtaryeB/NQ6Wrj2eGlU82KzfJZAwLS0gZiokUiezprt/vPsbKddnco6
	90E5ijzgwDmnX0yb4vmdT3T8qSr7sfnTjH9d2DT6K3O2K2JZdecR6I52nQachrjBqRNMQ=
X-Received: by 2002:a05:620a:3198:b0:92b:6805:919d with SMTP id af79cd13be357-92e6280f798mr528748785a.69.1782823590757;
        Tue, 30 Jun 2026 05:46:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622eb9d2sm233423485a.29.2026.06.30.05.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:46:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weXrB-00000001r2J-2EhA;
	Tue, 30 Jun 2026 09:46:29 -0300
Date: Tue, 30 Jun 2026 09:46:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	linux-kernel@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <20260630124629.GE7525@ziepe.ca>
References: <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <ajQI5jMJpxyNZCLN@casper.infradead.org>
 <20260618153049.GG231643@ziepe.ca>
 <ajQRY7tHShCEz8vg@lucifer>
 <20260619131658.GA1068655@ziepe.ca>
 <ajlnTdkbmEzy_uhe@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlnTdkbmEzy_uhe@lucifer>

On Mon, Jun 22, 2026 at 05:54:10PM +0100, Lorenzo Stoakes wrote:
> On Fri, Jun 19, 2026 at 10:16:58AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 18, 2026 at 04:56:06PM +0100, Lorenzo Stoakes wrote:
> > > > > What you're saying is that offset 0 of the opened file might correspond
> > > > > to a PFN that is not aligned in any way?  I had assumed that when trying
> > > > > to do the mapping of (2MB+4KiB to 64MB), that the offset specified to
> > > > > mmap was 2MB+4KiB.  But you seem to be saying that the offset in that
> > > > > case would be 0 and someone needs to know that it corresponds to a PFN
> > > > > that is misaligned?
> > > >
> > > > I do expect that the pgoff space is usually aligned to the pfn space,
> > > > most drivers do that or could be improved to do that. There will be
> > > > some off cases, but maybe we don't care, and VFIO should be fine.
> > >
> > > Some stuff has weird assumptions about pfn=0 at start of the range (DMA for
> > > instance).
> >
> > Do you have a pointer? I'm drawing a blank what "dma" is?
> 
> (I am obliged to link https://xkcd.com/138/... :)
> 
> dmabuf as in [0], where vma->vm_pgoff must be the page offset
> into the DMA buffer.
> 
> [0]:https://elixir.bootlin.com/linux/v7.1/source/kernel/dma/direct.c#L550

That's not "dmabuf" that is the DMA API's dma_mmap() interface, very
different thing. This could probably be reworked if it is some issue..

Jason
