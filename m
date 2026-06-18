Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB23E47B
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796662; cv=none; b=AfSbWJhUDV71QQ9Vq00ijDkcjGUvcgbTSMXxWj+HiJuXcvkbnjAfkjkt/8du55AVkA/3Hb9bwzIaGbCvLVQZ1k6xqejmG6hzM0wSYp+5OjX+01uQcw3nFHLgFezNUGlKXMl1u+dIgzoBoD+DtDciwYdACAVhZuNaPRRiNacwV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796662; c=relaxed/simple;
	bh=eGQggG7i7VbSA0hSDcFTISaARbLDieURyHfGv233He0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+/RdAiO1CuJGOvz90NK0KQGiiufk0H9NxsyEU66ePLCPyqoziGlKNIJDRXg7LA4jq5iqrUxW0UZrnm8b5wZJr21LKrCWSaYCCp2SbPER9D4cBQdtFYm6Lijw0NqeSYSyzsSg5YElAMhAEY0hZtYmtMtTaYQSY8wlJGS5jo/1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VBPM4wxV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VBPM4wxV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-517dc520840so10905671cf.3
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781796660; x=1782401460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2YbFlGbsb/BC3pB5tDgDJVPXhu01tr5a7yfMtRUunQ=;
        b=VBPM4wxVgTdmBOrYm86eoEMcJdaSFNX+4RJHxUNmzLWdVh3tSkp5XHf/bbDGMJ4wx+
         xsN5tpvznynT3ThgzqrPt7K+cIbWv9bhUTMGkgdB1wjjOFiKDG253d2w9aZTFE/hM73f
         gMWqbow0Ud75VJmZ1Q+BCxEqdFx456HQli9VzYGr1zEAH1IipV9ZnQSeHrbemtLJxNVS
         hsUJm3FhSB9uV0L3nkthcBBCdr3qwHJb9/lOFPxVpAjuNjHIT2WxFmiKXHTrNN6DC3au
         Nd8iOUrBujfvdR+Gig8O+3IefR7x6/Wth46jTB+/RDSumyTMb1gqcEC6zRvzmBgpd92w
         KMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796660; x=1782401460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2YbFlGbsb/BC3pB5tDgDJVPXhu01tr5a7yfMtRUunQ=;
        b=ZFzpMOnYNe+Hper+9ZeA/tG8AfYpBrwGBdtVp553+kNMldT8pe669JEJ888AUXW8fa
         RG9y5+bV3zObUFtprZcT24CMZ2zN8cyGBofl7UueYmbJrH+Ta/Rz3GGLi2OuY8gL2HP9
         DUW0WJf/MpTq8gz678494GetsRpYphfP9S44YgklI3oSzLEbfVzMPjA0ZXgDQ6BLSlyR
         SJK3mJDDgBiD9XTOhQ6zh1QBYbJp8wMhYxXCrrGo+7zQ0uSktSDqRxV3/sUq/EnWS2PJ
         pOosEk/ttaePSletwKZdw5Eyvd7ZVQJBWdvUAVXjKH9fEP0GWk1zH2vlj5djo39/ebsJ
         VVjg==
X-Forwarded-Encrypted: i=1; AFNElJ8zAOwlkBujzqmCkZV7jkht58t67AzeSLxmIdNX+rDA6mXFCrnDb66k2vkbWPwa3nObyvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjmbW6x3fyRZYgf8AWMj03cZZF5HYW0ggYZvE2kaholIFSlTr
	1LlhEedJod/YRGU6N85Aj/7qeyUImlCGyz9l7c+Lpcok2E149thqKOUnh45v+X+Tx7g=
X-Gm-Gg: AfdE7clrLFxCEJMmIv5rRZKkMITTl3z/WI/Zj7ew9KwdO8udu2Z7Pm8+SoAbDMmiqnu
	jZXwpOIyeMjuLIs1UDAK6adEcK/1RCx8V/+hYv2dtwau5krJ/wGEXDHJyqi7xnkA/XKdMZw2C4w
	d3AbJDKT28FrP1gzawH2ODjF5/H11XhspLeU6Oie4XxleotXmJTOpGUmKk4XvofQKRftfvJCqRG
	iPjmJuqJSaeSgr9EyUsNebnoGKm0M55QdUfQxwrbp9Df9jfUzf5YBQIzoJSSyI80EKsCA6Buljm
	PufOTwGwgnTpq1hAq1w54hUPnk53qv+BWDHbaQUNuRmsTy5l3fMY1HPzezvsjYcACZxbn3rJ11l
	J9JEGFRCBXyRNODLK1hkGwCsXZzrIYKzwaxhFsRknso4zleWFN6W4CqfWdzAvdjJDx9e5uvFl4K
	nQpn0ojkN7Lk0hvN+YYYR2eqI2wEaZtMjw1HkOipfj/RWfzbBNTFxzzApqTdgHHFsHsETSEM5XG
	faA4A==
X-Received: by 2002:a05:622a:514:b0:517:875a:d634 with SMTP id d75a77b69052e-519c6d110b0mr56448271cf.2.1781796650715;
        Thu, 18 Jun 2026 08:30:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7e8900sm221236521cf.23.2026.06.18.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:30:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEhd-00000002syZ-1gad;
	Thu, 18 Jun 2026 12:30:49 -0300
Date: Thu, 18 Jun 2026 12:30:49 -0300
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
Message-ID: <20260618153049.GG231643@ziepe.ca>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <ajQI5jMJpxyNZCLN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQI5jMJpxyNZCLN@casper.infradead.org>

On Thu, Jun 18, 2026 at 04:04:06PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > On Wed, Jun 17, 2026 at 04:29:28PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 17, 2026 at 07:34:06PM +0100, Matthew Wilcox wrote:
> > >
> > > > I don't see this as being something that drivers should be involved with
> > > > at all.  The MM should be able to get this right without any hints from
> > > > the file-provider.  Yes, that means I also want to get rid of the setting
> > > > of get_unmapped_area in ext4/xfs/other filesystems.
> > > >
> > > > Looking at generic_get_unmapped_area_topdown(), I think we can do this by
> > > > making an additional call to vm_unmapped_area() before the existing two,
> > > > setting info.align_mask and info.align_offset appropriately.
> > > >
> > > > Now, what's "appropriately"?  I think it's based on length (>= PMD_SIZE,
> > > > then >= PUD_SIZE), but we should also take CONTPTE architectures into
> > > > account.
> > >
> > > The info.align_mask and info.align_offset do need information from the
> > > driver based on what it intends to map into the VMA that is being
> > > created.
> 
> What you're saying is that offset 0 of the opened file might correspond
> to a PFN that is not aligned in any way?  I had assumed that when trying
> to do the mapping of (2MB+4KiB to 64MB), that the offset specified to
> mmap was 2MB+4KiB.  But you seem to be saying that the offset in that
> case would be 0 and someone needs to know that it corresponds to a PFN
> that is misaligned?

I do expect that the pgoff space is usually aligned to the pfn space,
most drivers do that or could be improved to do that. There will be
some off cases, but maybe we don't care, and VFIO should be fine.

That is certainly an easier place to start.

Jason
