Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8AE41166E
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823916; cv=none; b=SJWeDQCSDGEMezIN1fo1s4UAIPMNEURt/cfdh7fJiGojvmU5Uhz5xZVSZ8gg+09W7ins9G+8pqMYLRs+vLQ6UTOS2OVzd0OFNRabGgyaw+VLhoyyRjnMWa5SKUWILfzK8F8f6ozFjWpjGP56d82yq7hHIFdNGm33k5+62tyPGrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823916; c=relaxed/simple;
	bh=KkjSRZwQGGVo3DftR4Qh1W68WKiHOoHdOTGnPqJZXQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjeacA7xGXxYr0ROV23iJj265Q+zg4jxua0zYOZQTs67ljgHw5OXmcheCE7iMxM+Kp8b0iDUQaH9qSCXZzUpCB+NuGlrlSFbMNm6FncOAcDEpNGrrOy4rtNtY/+nkxe0Nak/9FLHCeAzWAF9PQBsz41B6AC4D9P+h5/mLxnvlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jlkVhz71; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jlkVhz71"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so25516796d6.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782823914; x=1783428714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yl758QqeVKhY4n2MCSMwX4uj2krX7F6fWmmpzTHj8k=;
        b=jlkVhz71w6vfwh/eTuvupCcg/ZBIXRCTTTmgUrzBCnAC8vqnGPVSaGSpQmoqhsbEoa
         5Gfd6I9Qyrl9oojo7d/BDSb0aNZPer2Ofkl/P3dc9feqw/LqQiNkwySEQjzYe3MZsdDo
         Gd+8bBPAr4vDeYfhFeOUNRu/tXhw56uhCVr1ipzL2/lQTFyzHzRc7e0o2ijmHg+/ZORM
         LQ/wnZeNYh2RM+8l90sSrDr64NoZzsy4w3rbX/CG6PV8nPoYSLuPJwV5OHUjdxC1J4+V
         mRY/EZQOXYXMP7+/TA93oiZ4WOyWqNVMdbqI69+if0cDtiR/XgeXLI8W1k3zkcepe32k
         e2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823914; x=1783428714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yl758QqeVKhY4n2MCSMwX4uj2krX7F6fWmmpzTHj8k=;
        b=ZNGWBwgQ+y1YAw+LGxAIp9rtn8+7D4pYEUMzIqTlA0wt+UWr0SPhD/oKZrIAaZXqAW
         vGKrqbWjcwjUK4eFAPhlJorUVW5nbu5g7KbVMalGFg3jymO6vGHRZlHO9gUYth6JGk33
         Zaz3Yivtovcc+H+QAbv6e8Wixss+hQumhWhNnWnvu33najUQFleCtzXimcI4ktCCX7FU
         ufQN9pDyjmYrvGHEvX5lAwfFkyMCeXqJ5NbUAyQ93kPJhIF5hzSrtrHag7oD2EATV+Nq
         yrM+ZvApiXF2GLeUS8hVfQ3NAzC/yznjmpkDNAsdhVR2VExVTFxamwrVX7NR3UPjYvWk
         IsXg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4z1HVLuO5+Rif2cbjYG0VXoFWRRFO6mQk1A5h4g9ZjDZc1bddkXBQpSareAz11EeMOQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IHvG4tLMmo81h+an3lbDXnlu824mg6PKeSJ4YOhRPcs8xL3/
	DiRZXJKrU5wILsfpLHcWDfpYxWu4/Hc/ElBqi5OF7Fj9hJy9oG4UxUIUFE78iwAuiW4=
X-Gm-Gg: AfdE7cnlfepR2Al9Mg0J2QI6kV3uUkvMFVZiXcmW9bz34jcKSC7n9MSDN2AR44y+VeR
	pvjNkv1xg8MeC2WnvswiMC5aKRn6Z8HtoA6hEjeJIKqu+/9NCVYirbTbYJBLLHtcYAHEFEDqY0/
	vmPlNhixyOv9GvwiVGQ/yd6Nr8U6BTwx6Pi9/AZoeIPdXvhKr4hJpIadyS16QQ7xtO3VX6mRDeT
	CbdqfY7n+N6jhrGKvsqXnk7I/gRxJrCZumEvOhI/HH12GRhmrMAx0k8WBoGOGdUtIqpBmyGN4qP
	lI0OWRGj847NLx2QN5yS6YQlCzO0DkOyjj3R9AM08Su8ppwfJbjuanjS2LSa6s5v5vrv+h6cA++
	6r02UdaylwGS3mEnxpEFuE016eR3WpmdwukD2h4R5kzbYZQ5L3SDaGDMbXfIvN923LyXWGOjwZ1
	BadwliYee45gNZKP79Y1L1Trs1zF4x+0ALbtI88UBIqLar+OlJxxv42YQpYEiDYmd1Los=
X-Received: by 2002:a05:6214:4e04:b0:8ee:6e1e:e38e with SMTP id 6a1803df08f44-8f2d13426acmr4770576d6.34.1782823914291;
        Tue, 30 Jun 2026 05:51:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm23571706d6.31.2026.06.30.05.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:51:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weXwP-00000001rWO-0UMp;
	Tue, 30 Jun 2026 09:51:53 -0300
Date: Tue, 30 Jun 2026 09:51:53 -0300
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
Message-ID: <20260630125153.GF7525@ziepe.ca>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <20260618152805.GF231643@ziepe.ca>
 <ajVqRiAMG23QGseC@casper.infradead.org>
 <20260619170705.GC1068655@ziepe.ca>
 <ajlW-Lf_tSBMccw1@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlW-Lf_tSBMccw1@lucifer>

On Mon, Jun 22, 2026 at 04:42:13PM +0100, Lorenzo Stoakes wrote:
> On Fri, Jun 19, 2026 at 02:07:05PM -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 19, 2026 at 05:11:50PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jun 18, 2026 at 12:28:05PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > > > > Can't we figure this out from what the driver tells us when it invokes an
> > > > > mmap_prepare action?
> > > >
> > > > VFIO installs the pages via fault handler so there is not a naturally
> > > > existing way to pass in the pfn?
> > >
> > > Is there an advantage to doing it this way?  I understand why we (eg)
> > > demand-page pagecache, that's obvious.  But I've never really understood
> > > the advantage to taking page faults for PFNMAP areas where we don't
> > > really do anything, just figure out which PFN needs to be installed.
> > > It defers page table allocation, I suppose.
> >
> > VFIO has a model where the mapping can come and go, so it makes the
> > entire VMA SIGBUS from time to time. The only way to do this currently
> > is with faulting.
> >
> > The mm also had races around populating the mmap in the mmap callback
> > and using zap on the inode, faulting avoids those too. Lorenzo may
> > have fixed that with the new interface though
> 
> Well, you can't populate the mmap in .mmap_prepare, we do it for you.
> 
> I guess the issue there is an race with an rmap walker? I did add a (slightly
> hideous) hack^Woption that keeps things rmap-locked until after the 'mmap
> action' is complete (action->hold_rmap_lock).

Yeah, I think that is partially right, if something wants to use zap
then there must be some kind of locking that guarentees after zap
there are never any stray PTEs. So if you race zap with mmap() the
mmap must complete and the PTEs must always be non-present.

Certainly rmap locking is a part of this, but you also need locking to
not populate the VMA in the first place.

   Driver CPU 0                       Zap CPU 1
   ============                       ========
 mmap()
    driver lock
      if (zapping)
        do nothing
      else
        remap pfn
    driver unlock
                                      driver lock
                                          zapping = true
                                          unmap_mapping_range(inode)
                                      driver unlock
    <no present PTE may exist in inode>

IIRC the current race is the mm calls the above pattern's mmap() prior to
setting up the rmap, so the remap_pfn succeeds, the
unmapping_mapping_range is a NOP, and we leak mapped VMAs.

But the ideal thing would be to allow the driver to populate such that
it is after the rmap is setup, under the driver lock, and optional so
an in-progress zap can be handled.

Jason
