Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C03C554B
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829098; cv=none; b=gqGiiPsFyShZ8LJeSeFUvI7OBGvjUxFi8zQRm317I9bpBMfbxyOdfEzT1hpBsmagiDD2YgG+pvC+wn6iKa5KhkkwNRrdGDdfkdN/6mZtvj/7OMyQ0ceC/e4a7JXk0Cuu30T7MccOGjoHRX2uoWeYvUqL4HOVMZQJX80JPhe0Wy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829098; c=relaxed/simple;
	bh=O1/1iGPeFxkiNwtNKXgPqUazZGcSIykQmiesHZQPz8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTu92Aoz0EImGY3CixM9DoqfTEGZTsunYtzNDSIEJiPOyKyepXeLNtRjOzyNkjhClZaT3e7kt1xAmuBoKJV85657bnLfR605Z08WIskkhsTE9+FLMGnJTkVogybWkGL8IQgByantrlpZ+35A/nBVLamUum6wxx8fVCdh+fE6oBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pR6Q3OKt; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pR6Q3OKt"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a032383008so23896826d6.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775829096; x=1776433896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rjHMd7udH2co2NdrO+T+4XZB1IgcQV0KCt3Z2nuK+g=;
        b=pR6Q3OKtlc2dxes7+WnpA6JgJzqosd0FXFa8q/rx8YmQIKHNgRc2VkEXAgY4xMMBTb
         Eb9Kaoo/k6a/QFpxj3N7vIaDHknA1T/mrr4UjTRNl59z/4m9cr4g3qCcxWmueqefd7ai
         RPh/9LxVzwnYWg0+5S4U9h9RaDX51rRLhM0iz2ymepKhQ6Q2wT34FpGyqAA8YyHz4MVr
         mx1ZZHhRu11mknfSgk61WNhikPuvNLXN6Fru9x2n2gGHkGqYWo9azUedaQW9gro/WLsG
         QCtYEsraLhUv/a8NXfp4qU8Vy3hQBoyZV+re7s5PtpZrKEsnLXYo1Tbr/cnujlE+UsFL
         aI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775829096; x=1776433896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rjHMd7udH2co2NdrO+T+4XZB1IgcQV0KCt3Z2nuK+g=;
        b=P2theMogHuUD7mQECBi+qci77fXjENRk90x9zV/IC4urjChcOGwYkKXfTp93NeUzWK
         EyAtf58FERJc4oZOeN6E0Mxkak0hYwgHpRtK7DUIZQ8R4vFSO2QixTP+vfZhptIb7mya
         ZeRHqte07j7QvWKIIX2EIOfnUNFmiLt675f5aizFbG2NXAJ86HfLau6KcUGvYEIo0nxb
         pEDaWpjrzeXLIW8hVAy6f2dul4WG1QzdU/HbBCQTEgP9rW2/IaT9I1MHaI61sLHHe7o8
         6UWjANiQAXsg6UH2xls+tjkqHbwuHLrw7ydQ3Qqcr7xSazmQBMn3VIN4qvWii8J/jjpa
         Ka8A==
X-Forwarded-Encrypted: i=1; AJvYcCUTNMCQSf+me+XJydKJoeaun1e0hAfLINJzBKzfGSvoGJ8kvXhZAYMxap1J6vApTEpPMf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOl8dblwwwJU5gMXhmWnD+VNZCJuCdomBRuAt/gjCgu7sxlRA/
	pkHDeL9y42tDUIl5Ax5sB0H4Q9Q6MqL8b1cBGZf+fwzq++PpcPLNcu/a8QmE3gqYH8g=
X-Gm-Gg: AeBDieuU1lKdO5c1CR1erja+pOg3ckxnnh3rajTGn7UtwEnAwXWQufpfOb95Xoer1AO
	ixN3iyjlQOgI+VH/yCVphznXnXv+9LYrz8FFs6HWRiAGJxuGsJAl7g2SgK34rXxcDxFPERXpjLB
	t+YKUjyYsWyXLSxFrMWpsihex7W+5R/g+jb2NNfqKIjD2dhxiCMyeRfcBxfSt5xrOZz1eZ+Ez3n
	kCh2D8N4cBmW1JFQibaA0JdRRy0BHyFbBRnUBYZkkGZR4lSJf+jbe6gdDIwcWxEoNUaNnZDTUyy
	yl7eS0tWw3aTV9y9BUPo8PZVoposnmX1D6yzzciyqhZEr10m6ljveV5s9nfv2uYxrUoObvh/Zum
	t+NEKuKYb9h8NskOsXz4eDpLkmthqrgyki7xk2/3T4JW3MXe1bTQaLWlrSjbUjOQlSlRHo+WHsx
	Bfn8pegWLCmeVZgljtqVV55+JpqrFrL0ZYRNoeg17RbsB/jea73smoDdExESsTAMezUwY8SQ==
X-Received: by 2002:a05:6214:20a1:b0:895:498e:e9dd with SMTP id 6a1803df08f44-8ac86155e92mr44076496d6.2.1775829095763;
        Fri, 10 Apr 2026 06:51:35 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cc9b8esm22948046d6.41.2026.04.10.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:51:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBCGj-0000000EEOS-49Ri;
	Fri, 10 Apr 2026 10:51:33 -0300
Date: Fri, 10 Apr 2026 10:51:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
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
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <20260410135133.GT2551565@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <abHZdOKyLmmmHADz@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abHZdOKyLmmmHADz@google.com>

On Wed, Mar 11, 2026 at 09:07:00PM +0000, Pranjal Shrivastava wrote:
> > +	if (!obj)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&obj->lock);
> > +	BUG_ON(!kho_restore_folio(argp->data));
> 
> The use of BUG_ON in new code is heavily discouraged [1].
> If KHO can't restore the folio for whatever reason, we can be treat it
> as a corruption of the handover data. I believe crashing the kernel for
> it would be an overkill? 

There should not be any new BUG_ON's added at least they need some
better wrapper function or design so they are not in end-users like
this.

But these cases need to fail by preventing the kernel from leaving the
initial safe boot memory space (ie it is going to crash anyhow). If we
can't recover things then we can't guarentee memory is not being
scribbled on and we can't use it.

This is the general logic why these are made very fatal.

Jason
