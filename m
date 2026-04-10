Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6633CCFB5
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830439; cv=none; b=DLVwVx5XtY32ubbmIoMoT1IH0B2kj4bxXXzbAbvukuI87UBag00uUdO0XTqlLT6oe9w0BT+4iC8yYzP+7ynXDxLoBlmhk9XrbaXVTKecpgxSs/BxQ89d0ydf3aDtG4G9h0cd9wxBAWJR5Kyhdgdc6jSogsC4EfUt6kVL2QUfwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830439; c=relaxed/simple;
	bh=iPhEiy24SS6DLk7/lMwIEBiaN0YnL4HabWYQJpkGR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7bbPXkcbExpiG79koVN6H4k/4RrBjAXe3ObnkPqWI78Hc9R7SZSQo6rsJJMLD5ym6ix8R9srcRif8gCEsJehd4035vsFGmY1KXtTEkvKQlqjfs9rWx8GpxKkfRxfwvwG4JkX1DYXpA/+8ugg8yQ4eJMbhLXOull9STbCUPrrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bR7X++FP; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bR7X++FP"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9540bb77b1aso1131387241.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775830437; x=1776435237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPq9o9pk0JN/SIH/9GYQOf/hDgTAKyNjdrn/YjKiJAs=;
        b=bR7X++FPjuDNNsXVTF07S0Sp6ZyECUBwv3lb1QS+Vje3JD8gBtlDT5FHqVSC/+9Yya
         snjJEnbM0/FHXmLlJsvH/Ed/U/MUijO5okYEWFaX8LVrOSlmaBpZMU+tA2gwdzoGkB3j
         GXX8HHBTvV+OK7GEc2jsUhG/anaMVChqLPJcHxBlSnzJdkdG1pdnRu8oJFiM9BgmWMFe
         oAxKW1qImGmYQkoQi/y9nj5zFwkMkGw4lwDj6K7YDObaJExrHR6U6hUvEqQ+iWRkWKqk
         9xsFCLoVcCe8gBne7Jhcl2NgoY43Tvjr9CeOQu//GdDyfS0Opj5M+HsIVwGgVUr5SvP2
         qqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830437; x=1776435237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPq9o9pk0JN/SIH/9GYQOf/hDgTAKyNjdrn/YjKiJAs=;
        b=r7v2XM+JLjA2nCAy2v3KdzOJ8lIT0heZajbCAVFGzgkMVV8KNuwlKpCwqAPp7ykGpq
         BSTevaPlr+zYuD1AIo/cl8EwMP3vvKCyBbL7ypVFWQl+Hj/lGrcCVcMnJrHQhQpanuDc
         8JTol+13frXbE+zm7I7KzReu1rpIoVrEeY/1TiTKqcLyniH2iVDtApdNr4kybvbyTMU/
         UOcNCqus9zcyOBlJaQc7ghH0xZSrPyVhewjQzyhXQQs4heftW2TR1QKbkNgZPErTseX0
         ssCkTjJdYw1IhAJ2VH5vNzYniOrqQv8GRN0wTgCskA+k2vsI+kX7KfyyljH/Ea1Vg7jp
         YTvg==
X-Forwarded-Encrypted: i=1; AJvYcCWio1EMcOWbSWAJj+foYD+Oi4DrlxFUGj86J/oN2iHXxBx5WKTAfw18pDn/U6gsGYuj6YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQQx6dPo7BfVpB82Bacy73gNkQzyo6Urm3N0gHzl4CalbuUG2
	ex6Cihcq9vYbX3XFgJqZgT1XLsR43eJA6RHVF9feVlbIvt0bOjZa7WKcNcWO4BfY1/U=
X-Gm-Gg: AeBDieuymc5qlXPhX/zdEYIlKfTjIUAeGDtRtjOM0KWn8bshwuBGSkV81woUtL/Zm+a
	ZsA22UlkHH+ceWufZC9yPt63LL1ZX0H7sbeEimfymP6kl/YCpsScqwLV7twL/ncOB5tWS/enBTt
	WB4W0amTv/sVEAovpmBzPIXeh5zXeItw+2A5fsuQWV4OJva+LPCusVysIJeCIxl7MTt0JL2cN0+
	zBWe3m+6qjuD88M4SMCysxbSuHxb6vScCM5EB1Vo/F7xDwcUp6jeRniD6pMnSFemvs3h6+MuY8A
	CsojiH1yIucGS5gAtzlRCoc/Cw4DtsFjRxjiIq9MjOaf3q7ABqKlTz4hjV5RIvC7IjCoTmaD97Z
	ruO153uonZb4Y87cMWjgTLLP3m/1Ufmc4R+Q1NOUGVA2ZZopwuHYymLBlJKa0Yw4NWHIgRJm+z9
	XcpMDRvCUWkPOqFIdrBrm6z5JNf/L4ItYCcIXGG3cAGCDPL6AatsZe2Z3o1DCOBcuOXUd7vQ==
X-Received: by 2002:a05:6102:458a:b0:5ff:cb2c:a04c with SMTP id ada2fe7eead31-609fe8a59b3mr1426468137.1.1775830436845;
        Fri, 10 Apr 2026 07:13:56 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c464a4sm24186486d6.28.2026.04.10.07.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:13:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBCcN-0000000EKCb-2LBT;
	Fri, 10 Apr 2026 11:13:55 -0300
Date: Fri, 10 Apr 2026 11:13:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <20260410141355.GU2551565@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
 <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
 <ab2Dkn605sRbpK5S@google.com>
 <ab2KDEatYbSZJVfC@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2KDEatYbSZJVfC@google.com>

On Fri, Mar 20, 2026 at 06:12:28PM +0000, Samiullah Khawaja wrote:
> > > > > +void iommu_restore_page(u64 phys)
> > > > > +{
> > > > > +	struct ioptdesc *iopt;
> > > > > +	struct folio *folio;
> > > > > +	unsigned long pgcnt;
> > > > > +	unsigned int order;
> > > > > +
> > > > > +	folio = kho_restore_folio(phys);
> > > > > +	BUG_ON(!folio);
> > > > > +
> > > > > +	iopt = folio_ioptdesc(folio);
> > > >
> > > > iopt->incoherent = false; should be here?
> > > >
> > > 
> > > Yes this should be set here. I will update this.
> > 
> > I'm wondering if we are silently losing state here. What if the
> > preserved page was actually incoherent in the previous kernel?
> > I understand we likely need to initialize it to false here because we
> > don't have a dev pointer for DMA sync operations at this low level (though
> > x86 uses clflush).
> > 
> > But when is it set back to "incoherent" again? I don't see that
> > happening during the driver re-attach phase?
> 
> This can be done during restore_domain as the domain has a reference to
> the dev when it is recreated. I will updated the walker and add this in
> the next revision.

The only reason for this tracking is for DMA API debugging. It might
be better to just remove the DMA API from this path and use a direct
cache flush. Then you don't really need to care, the successor kernel
never writes to this memory so it can just free it in a normal way.

Otherwise you have to remap it on restore so you can unmap it on free.

Jason
