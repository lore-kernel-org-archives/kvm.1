Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C732FE056
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888829; cv=none; b=cn0HZOWWpxcv5pqpkGXVUW2nnXVnVnMwJb+MWg6MpBtefJbnpghgAWHI1tilPFSi3NDDuved447hhw+kXMJ2xsteSFGH4R1sGIhZq6FEZwgJovAYXpXCnl/Yf/fkBOkUVSSRrMzplJWNGhkwj5JAAvw8sFF9eb9YzlfSBCez+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888829; c=relaxed/simple;
	bh=GnPMB01G/wk66ArMYMaNyDwaZrGCRQhV7Zi3LSB05m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQLGKZ23yq8cvYYWyabCIJld3pyVRyXev+8L8dHAzAwP+FC0W5bZFLkZJQNyXMr8ta6iJjrs0/gFYpYMfr+Q3j3BlmWostH2Auf0T4u/zaxbQDvguo1BUt23+uV15oxjqlu+WDOLJRVd2j0Qp9XaYuaHFaZ7H5KDAiZpX2jP8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HWBh7PKQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HWBh7PKQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8de91c353eeso7811326d6.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781888827; x=1782493627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0p8Xg9lCiPpDoy4o3VOnxua9XkNhU5aTjFKL7L/TUUY=;
        b=HWBh7PKQkmqMzuzZ8wQNjJb0iJcjx51O8U90Utn8YYd/pXjKcqHxNqSXWzVDst7sYi
         S47gUav1FUIm2M+kCaDhLp43oW1kCp0VbuzV7I5emGg7Q3KzpbdTf6jEx43pfSGx/s8O
         Xa4T5yIreB29qHWeKdPmFfkVhtMPshXcWOGt5ihj4E9I/Skr5v7me2o4ICiud9bxHnuR
         XaP1k5HUKVp5UTHyQenhddGv2IfBy5HQI0+8LXveU/aNKwMCDPjeyKKwWLUrAvvR7SJ8
         b7UcXVkLZTl0JdHcv20uwP84ZGfe/AyY1orzVqVuRUk9QDiA8ejn+zAg/rChQduyckjS
         P3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781888827; x=1782493627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p8Xg9lCiPpDoy4o3VOnxua9XkNhU5aTjFKL7L/TUUY=;
        b=TGbDoDUTOx6yLabcb+nnPNAH2Y7iaoGAcyfXcCrS/owgZtUsuisajyDbUZBMXFQWst
         qEzfm+hmYz7SszQMhEkhfLZIFzWp6InRTrh5tvPE052JndJrIYruKs2A8+BdqKC/pBno
         eSTLSL7q6i+Rl7xLAStkrw5lu0yHB2VkJ81c3U8xLsKNIPnz/WwfEoJBNOIPSYXOKI+G
         P69EfsQss9kt5mjI7iOtNEM5ud4RyVYZtUjYvWUdXmH5UDTXJWYsnDMUHTR+W8WOg9t+
         fVuZ7OMETzBGpvW1Gc67IMFwpTeQ9TpsGwyKhpi9KaIRZnQ83p6QGiOdEnvm3+0oYsOC
         GZhg==
X-Forwarded-Encrypted: i=1; AFNElJ/+u6lQnfyzzdfyTqx/y3tnAtjoIoNwpSiqoDZDm3EZ/ExVvk+hx/WrEG+53UXu2fl/hH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aVY4zDFhzn9PYY5LNspBM81xSGey9s20mROrT4tb9dSqIDVA
	CM5WznYb+7SEg09IJnFXFTzJfNjD0NybEMsaAphsbIQVBc86IIgSWIIiUWBmJLkLMpg=
X-Gm-Gg: AfdE7cnQR9N2Dvg6cL2Tj9MxnVvfQYvkgHdloEuNDz97BHJ990d4i+V128JXmt+iziR
	/k9FUBxG2J9ccD5e2PRJ85VC89wA3TARNwDKsB3Ga+ql08o3VvFKa+iPbz+zy8bFQNK43DwgBnF
	E3K++aMWsoGBwNnR/d1qST+y/7SQXw5p/03gJc8pkM8BG/DjRn3iB8QqxmCiAB+Za3GxcS0HQ+5
	3T7s3PRTV/xYLyobJ24s4bDchqWMvCB3dJrPi/SQ3Sl6Uro2Nev61VZFp5qJrGwTfpgxkniWFd4
	WyH0qfwacpncFpHCcEyZ2T2b1QWQGhwrxMLYPCesJxbTfG8rFuWqj1L22yBWeR+gR89LqwgWlaa
	qXxxhrLEkKByOjWFKhS/xROiFhCq02q3mSRhlp/Vbschgcfs6GkaMMVqh2oHJ/y+I5V88ONCN+L
	5daxfZmuM09dtY6pDaW8VgCo7sZ5XE7Q8/kmW7Tdvm8YA9veuLIjLe1CKpNuqpaM5wBsEuDMcMO
	PvEUA==
X-Received: by 2002:a05:6214:600e:b0:8ce:abea:4735 with SMTP id 6a1803df08f44-8de42557067mr63574476d6.39.1781888827132;
        Fri, 19 Jun 2026 10:07:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdf302sm5331856d6.30.2026.06.19.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:07:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wacgL-00000004qqF-3F1f;
	Fri, 19 Jun 2026 14:07:05 -0300
Date: Fri, 19 Jun 2026 14:07:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Peter Xu <peterx@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	linux-kernel@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <20260619170705.GC1068655@ziepe.ca>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <20260618152805.GF231643@ziepe.ca>
 <ajVqRiAMG23QGseC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajVqRiAMG23QGseC@casper.infradead.org>

On Fri, Jun 19, 2026 at 05:11:50PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 18, 2026 at 12:28:05PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > > Can't we figure this out from what the driver tells us when it invokes an
> > > mmap_prepare action?
> > 
> > VFIO installs the pages via fault handler so there is not a naturally
> > existing way to pass in the pfn?
> 
> Is there an advantage to doing it this way?  I understand why we (eg)
> demand-page pagecache, that's obvious.  But I've never really understood
> the advantage to taking page faults for PFNMAP areas where we don't
> really do anything, just figure out which PFN needs to be installed.
> It defers page table allocation, I suppose.

VFIO has a model where the mapping can come and go, so it makes the
entire VMA SIGBUS from time to time. The only way to do this currently
is with faulting.

The mm also had races around populating the mmap in the mmap callback
and using zap on the inode, faulting avoids those too. Lorenzo may
have fixed that with the new interface though

Jason
