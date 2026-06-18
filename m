Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07633FDC06
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796489; cv=none; b=ahWwLf3M33hAbBJgdSA/E2ho6qt0JnsiV0UGAARHSerKFTT/pA1/jbf2jTGIlu+WUmpx7HKHlxXRUHJChZ04XE6pPjWiLMO4RymvEeU08Zj03TWGDzBh1WZlH+tIUCeXIHkiENPDlz3T6DSyK65I0y8HI9ma2drZhPO7gZ1rq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796489; c=relaxed/simple;
	bh=0QMdV0N5NpX2KPdHDqUOENxi6RazWZG2GolVOS2HIg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwQEdhOScfgpMw8vkwdyk0pv7A/V6+QF80ROJsIxRNmGLEI6RX1yQjkfXvFvxeLKzljqOdEzg8RB6lTGRMMvSgRt+kVUcSy+s/98z272qXuoqvsFVlhaaVtZlRqRxgoBKI1uCFz30qKLUzB0sLPk23I1VQFZi+4YcsejC/coO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NBInqi+J; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NBInqi+J"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8dd17d7308bso7047686d6.0
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781796487; x=1782401287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P63dWZztD1Zc0WqIHW+0U1XALCCx2pgBRGQ79zLsHtM=;
        b=NBInqi+JAujNXzMKGiwXcFTOVU8oJrCpUjPbk5ORGfwNsOAvPsQhQH2FrE9nmGqc7k
         1Cx7dAg/6z5zMmkqMOgVqPagM3lLX+df4tuCPrwVisb6t5vW7jczxhDrXi/5oLK46FgI
         +7v1k7VEChXkFP+oZ3p6NacM/u3iRShayPeqeQQXJbher9yX2eifqFdoafDEYRRPanB9
         GJAk/8VaWjHGTktOSlHcgVqUkjQ2BtRluhWL3Zi2WvY+1OtPgtBSF5sRDDjuXOyZxw81
         MaWYz8M0Fy6a+zK6rNnfI8+zzSGIk76uX3lXg0Gz+B8/pC3tphQ6+8GGWWZBteY6QSnM
         CtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796487; x=1782401287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P63dWZztD1Zc0WqIHW+0U1XALCCx2pgBRGQ79zLsHtM=;
        b=Lq8rQ/HWMTws4qreV5TTZgBMiigHMV7k+K1vhVCRt+e6oNImz9P6GwnqdoDNjTMt0f
         BFAuhil1lqEyO3ROXRSNEYYTYSwP1MNZDB+PpvJGeho+xTeCHwyKHWsHuZTikwzZbAFS
         5BVzRZGUenJV1NLewnzcJxnMFHo0eB/yGWe2nnSx1lHDemsF3i5AV9sIYfCTTPx9D6oF
         9FzqOVbunc24D4sLCu2yvdnrSQdZVtpLk7QWbA/LIlD/zDCuZagj2VhD3uD5r4zLy2WM
         QfkGs1MwvUVGVC+0QpViWMVdkaodpaR7ag/pjJaGtEsD4t9O68FrmquOqQeHJk42G5OU
         zKHA==
X-Forwarded-Encrypted: i=1; AFNElJ9jUBNFOmeq08eqjllAN0O7RVdRTfTrDQYgSGXGItVnd5Ksf0z+q2+EBIBc6nv/FK34Z9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmVwneJX4FkbqsNxCqo/CEWgfZcAK6dkM6DiWGYzRZzShNMCM
	mP9ZTf5fom9xbvJQA+zOR4EGBSgQheyOcDk4lcBYBY6c15GpfFtCaM7RW9Y/zgo55fo=
X-Gm-Gg: AfdE7ckZFvn+sMYZWqDyPiRHrfIrI0IADxe70eHWP7lbQ162pOP/avmucyB9SdfzoNO
	HvQz6XLRazJ1zS/A+lseNQjsKxhf1Vb1682dsdxhqiTgx27TAkvBJ8JkbXQTbGdMV8WQ7ydwDXq
	K+AUyxdxPxu2sr0TMlgYYpxhskE8spefQWaVPJGsAFsYY7pSlBibu7Aln1B6jOiaScTJA6ckU4A
	kssdeXQrHZoNobpFNNGnYk6V81gPlZz0Q7CA8DVBmm7nJfSJgEc2MeRrTg6iKTSkTc5zfK2RHww
	T5IFIYFupPfy6oNvY+LftzzvioZ33ir9eKQDONds8DZ6LAXspOrRULkPQJNhdFMq4OiXaBxQLe5
	aPP/Lvhrb4kzCYPGJ9zsZ7qo/aS7j8IxP1k9hDDkuQSxTFOSZKIbMa6Ae8+948aaahyB8q9Hzx4
	tRykNCwiOpXoXtnRbbNOxgBJXG2fAk5D7GUlA0PAKl/+vBkKuS2v3pifZ0ESUf7gStR5E=
X-Received: by 2002:ac8:58c9:0:b0:517:6fa5:94ef with SMTP id d75a77b69052e-519a90253edmr135623381cf.50.1781796486476;
        Thu, 18 Jun 2026 08:28:06 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb84188asm213419051cf.29.2026.06.18.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:28:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEez-00000002sf4-1fkX;
	Thu, 18 Jun 2026 12:28:05 -0300
Date: Thu, 18 Jun 2026 12:28:05 -0300
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
Message-ID: <20260618152805.GF231643@ziepe.ca>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQDVAu9b-LX8gUQ@lucifer>

On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > A pfn driver often has a single already known physical range that it
> > will use for the VMA and that range should drive the alignment
> > decision of the VMA.
> >
> > vfio in particular has common use cases where you want to mmap from
> > weird offsets, but we still want to achieve a VMA starting point that
> > has pa % PUD_SIZE == va % PUD_SIZE. It is impossible to do this if the
> > thing building info does not know pa.
> >
> > I do think it makes sense that no file provider should be computing
> > the VA area itself, I think I made that case when Peter was last
> > working on this. Now that we have Lorenzo's mmap changes maybe we
> > should be talking about supporting VFIO by having a callback to obtain
> > the starting pfn for the VMA. Usable only by drivers like VFIO that
> > are working with the pfn functions.
> 
> Can't we figure this out from what the driver tells us when it invokes an
> mmap_prepare action?

VFIO installs the pages via fault handler so there is not a naturally
existing way to pass in the pfn?

> Can't we figure it out from the PFN the driver tells mmap_prepare about?

Maybe it can pass the pfn anyhow and not have the mmap logic map
anything?

> > Maybe other users would prefer a 'max order' callback and then the mm
> > would assume the VMA will be popoulated with pgoff aligned folios up
> > to that highest order?
> 
> Not in favour of that, fear it'll be seen as a new go-faster stripe.  Ask
> somebody how many free pints they want and they may veer rather towards the
> upper bound :)

I think you need something, otherwise we will be aligning VMAs that
never have anything larger than a 2M THP to 1GB boundaries, doesn't
seem good.

Jason
