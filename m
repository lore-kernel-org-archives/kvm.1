Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46DF313E15
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465718; cv=none; b=R+u7f6X0PVqptLWglLAQayhJxVP15Hk9lYDzZTgrK3oD7cKcG7x1NBvJKeGpv3N6Jphsvf0yCu0Mdt2S+2wyXvTIu40GlcJZpx23KcccQ5b7Yn7QK+uqE9RxJApJuRJ37R8LH8fV9HWfPrXLsKxHLzafygGYsQAUYhOCuy+Q5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465718; c=relaxed/simple;
	bh=RuKPNubONCAdbcGpb+4TkujB9DKqcRtbxLnmKogDOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grq9unFAVlGVkzDGL3bWPh1PVpFtbmPdnngQ7ibwPOW9zrxwlBTgpet1Uo9SVXaNxjRiMHDI992pMwYGUM9uPK3z+9dGqwJ3FIBokr55ph3P9NWvP/aelQUTGhX28wABEM7Ok0wYdp22dwfg+yo3qP9WvsKMNR9WjnN59G3am5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4ggAXud; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4ggAXud"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso7505ad.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779465716; x=1780070516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtKAVWQfKJfzzyI5JiK+IMb/6FsJieotyhYngLX2q4s=;
        b=f4ggAXudbarnx9T9qOgYRCdmHioO2KAV9XKX81EX5zOAACkJm/uqEvRKuP8jvNQ6vA
         S3/Tl+/YRFlQ2NWv9EVv11lV9ef3nKFAfk62tOhC/Odzt65xgCfQGEHVeQUCNNUUohLz
         cVAHA6zclmW9RuogeoGkiSq8qXrOH5ig6/8Bu5O/ifzWrAcFNWGHUbiU6xVc/3HdldHO
         aJGL7huuAlPnJqgUaR7Q3AA8vssHNUE0qbad1PZdS0Ij1x5zaRXJWSZ43R0H5jl/lCzm
         wAHd1y7rmT/S+Rmpa0hMX6YmBk3fOycjV4hts3C/iHQhfl+MgSHU6pZPOKWTr/HNMKMQ
         EuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779465716; x=1780070516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtKAVWQfKJfzzyI5JiK+IMb/6FsJieotyhYngLX2q4s=;
        b=YSbVWsu59I4MmqbEt7Nqv1qNoLV27Hej/DTnAuPnwRKNdnKuwdepryyaSgitYNP4SH
         N+USq12OiDE5VLNBiVuR2lgqt6/dpFZpctbu7cSjBNs5iE9MU1WB7hrdMrtz9OFJO3hJ
         qnmVTZL5rJzbHDdXjfT+DBI9BVFPezc5aykV9YwKOHjCIz641yaLnJc0xlReIvV6oFp9
         SlpltJscN1JQJsdB0enoIgDw5tb2t5xobrsmoJw+ELUvlyDBb1ywLoM2OjOd5vjHvx0K
         3/ApPJoWfbi/aGjme52/0+msoLxVODKeL1Zv4ZZomt0yHEkUAh7f64WeWZOfr2i0i8M3
         vP1A==
X-Forwarded-Encrypted: i=1; AFNElJ/Nez+q2qxs9MFwXbC/qvgFbAsdn0fEq1bhhXtAn72T5m6kPy7ieoz5QWFZ8a6zrfekoWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvLHB5W0S0k+syqpkyyv4vceMRqzZTjeVIaHa7T7rBG5oWvL1
	e0oNHNJkqCBM678mOn6Y35bVF00VTzJqv/qgfEGpHIrrUGUcGY6r0eZRVAJ/sjosIw==
X-Gm-Gg: Acq92OGQareVwPJ3V4AEnmX31SZmcItoMQY1SFzRqnu05OjWi7Vn21JXLjBwvVG/fcu
	zIhfZYAXa6tNFatu23X8dJ6GU+RbtaMZTKUtKXEHz75JiVjFTdyp/REFPUOOgmdJgrc5aADB5aY
	7GVTulZO2nb2Ldb20cOiAt+EQoIxhczRqi1HMCy+r48jPsoymJuGp+xGCgynGLpWlvyuIlWQ59V
	atZ47JaJHLUP2mdU18xeIbhPtHY46DOigujQzEC8JlNz0RXT5rla0KCBHtJsvbU51MLHbgzGYbR
	77c4hyuwWa84r3JumuI8pYwzADFI0cISewx7+pk7bewcUKPK9OroUv9TWFs29HXL3S/MM2bBsxK
	zl3HIRgnFGa2fpnUKUmIuwHmXxv0/e/377IPy6qUSrVzQeo4Gg5JWwZc6Ie61EOoDFpWZvyi+9l
	IBW9l9ELwNBv05A97BRnGdoOjXuYM7T6loxV3ytif/TCN0mp4n4Z/fFwCHvRekFU19a+WR//WPw
	XRWrLY=
X-Received: by 2002:a17:902:c952:b0:2b0:be7d:a25e with SMTP id d9443c01a7336-2beb1a59b6emr2468155ad.18.1779465714686;
        Fri, 22 May 2026 09:01:54 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841648a2bf2sm2145075b3a.0.2026.05.22.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:01:52 -0700 (PDT)
Date: Fri, 22 May 2026 16:01:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 13/16] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <ahB957SICkiVzZBv@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-14-skhawaja@google.com>
 <agz5rFcl27H8yzTY@google.com>
 <ag4DzYZ4ToDcyfn3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag4DzYZ4ToDcyfn3@google.com>

On Wed, May 20, 2026 at 07:40:05PM +0000, Samiullah Khawaja wrote:
> On Wed, May 20, 2026 at 12:00:44AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 27, 2026 at 05:56:30PM +0000, Samiullah Khawaja wrote:
[...]

> > >  #include "double_span.h"
> > > @@ -1421,6 +1422,7 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > > 
> > >  {
> > >  	struct iopt_pages *pages;
> > > +	int seals;
> > > 
> > >  	pages = iopt_alloc_pages(start_byte, length, writable);
> > >  	if (IS_ERR(pages))
> > > @@ -1428,6 +1430,11 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > >  	pages->file = get_file(file);
> > >  	pages->start = start - start_byte;
> > >  	pages->type = IOPT_ADDRESS_FILE;
> > > +
> > > +	seals = memfd_get_seals(file);
> > > +	if (seals > 0)
> > > +		pages->seals = seals;
> > > +
> > 
> > Can caching memfd seals create a TOCTOU issue?
> > IIUC, iopt_alloc_file_pages happens at map time, However, the userspace
> > is allowed to map a memfd and then apply the F_ADD_SEALS via fcntl()
> > later in its setup sequence? For example a sequence like:
> > 
> > 1. VMM creates a memfd. It has 0 seals.
> > 2. VMM calls IOMMU_IOAS_MAP_FILE. IOMMUFD caches pages->seals = 0.
> > 3. VMM finishes its setup and calls:
> >   fcntl(fd, F_ADD_SEALS, F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL).
> > 
> > 4.VMM initiates Live Update.
> > 5.check_iopt_pages_preserved looks at the cached pages->seals
> >  (which is still 0), sees the seals are missing, & kills the LiveUpdate
> >  with -EINVAL, even though the file is properly sealed..
> 
> This is true and it is intentionally this way to make sure that the seal
> is applied during mapping otherwise user can apply the seal after
> resizing the memfd and preserve IOMMU mappings that are pointing to
> unpreserved pages. Consider following:
> 
> 1. VMM creates a memfd and seals is zero.
> 2. VMM maps memfd into ioas/hwpt.
> 3. VMM resizes the memfd.
> 4. VMM seals memfd
> 5. VMM preserves the memfd (it only preseves the current size).
> 6. VMM preserves iommufd and it succeeds as memfd is sealed.
> 
> But the pages being referred by the iommu mappings are refcounted in
> current kernel, but not preserved.
> 
> Check the comment in check_iopt_pages_preserved() also. I will add a
> comment here also.
> > 

I understand the intent to enforce a policy to Seal-at-Map to ensure
consistency. I am wondering if this policy is a little too restrictive. 
Should we consider performing a dynamic i_size check during preservation
instead? I can't think of a good use-case as of now.. (maybe let it be?)

However, if we decide to keep the current policy, we should probably 
check for the required seals during the IOMMU_IOAS_MAP_FILE ioctl itself. 
If the seals aren't present, we could pr_warn("Don't expect liveupdate 
preservation for this memory, bad seals") to let the user know that this 
specific mapping will be ineligible for Live Update preservation later. 

Thanks,
Praan
