Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91911314D1A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108931; cv=none; b=DSJHK7Dz54AlkQEMCB+umgtPUH4j0gGOjJAwDVKUd09ic7FwI15yCeogNbH0SzxK0oUkD4LDYNrIaMGP9cdmCWo+KKLIMnwYB3Dvs8cSC/er7syjErs+tsl512X1aEsB7ecNIrUbCR1PNpFqIqMr0X/nZWNbfBeywAgXHMHLgJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108931; c=relaxed/simple;
	bh=oNtJLGUkWCaRM3PrOBCSWnEFF8AV6QL1YRj/wcqe5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1b/0P6Kf/VjOVDWN42xA8VEKYerEIMxDuJC6B4R19NuXL4zoJqi2XseH9QGhoAjuk7PyTKFGJ/+rsW7XiO+v8kTwICuGiK1JdTtth/sgJ1tYgWIKwOXW0w2T1tQ908O+v4XAyZKXZHAbhrooyuto147DJd6dZaNT9wKt/QxxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HHqd+2Ox; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HHqd+2Ox"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5174a3a025aso70199981cf.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781108929; x=1781713729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNtJLGUkWCaRM3PrOBCSWnEFF8AV6QL1YRj/wcqe5Nk=;
        b=HHqd+2Oxxgfstvd/wG7ueC47k9AaXG6HUc5jm1vsWWMzobtt2kxh0bE1kJobuLGFkn
         C4UkRIdfPNS+oDSPxCUfu2WzD63r6SmUCCiU9m+hRhDZEbGPJMpfzMa1F5+e1mZLqCRp
         g8TLpkzlMiZr+us2QE1wKo/uGSRpHRdPa4+4YeZ0uYgEigi8lVzd6IQWV8tnUUF7pLh3
         h+xEpxrkrhBbvVUrY+hTXaSnD97UwE8QRtfrtBlVQ6WnImcz4jq61s89DyRtB8EqxNiA
         9dZhEWoZNAhri5PzbUze1hF37Yz72zuQeoUV5/sEixNc0cIChevlf6TnLSCxaWjYLb6M
         oSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108929; x=1781713729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNtJLGUkWCaRM3PrOBCSWnEFF8AV6QL1YRj/wcqe5Nk=;
        b=O7DKCnxrMcXMhilUpX6YCZ8mlIXs9+3IkjcG935rnNBuSMl4tX6yfmOHb8nUi+jhpH
         X7TEyciQeTn/yl/lJuGqgpMhshL7qebJhLmrlVW13VMt4PWbRGtY7UX+LwaiMVbYOiT/
         nSb5eEEs4OqD/s2W47JJOwFiLKLvK+DuCFhhTGcOO5KrZDzto6q4Rv9Uzuh7RUBVe/yx
         N9raLgO8jSKZn98OO205/GcX/4nKcLDBkr704kjtfiLxnAOnQJoe41WXTlL8cXNhc6QY
         3JNp+6vCoQdfimu1ulr+GVNkt9M1af0upzIC7eLDASKN/JjPfcLBQNKdYALxfjxzgxOs
         1F9A==
X-Forwarded-Encrypted: i=1; AFNElJ+U2j8q7P4BL59pARJ1f1DLLOYSgib/U6Z89DgTGFnV9Hp45q08K2OnT9dEBqyh4Lb256s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrJfUG8BSy23tOkbvqb+y6jYJBYuWsUjsGTNddSZJSweu1OCr
	+Wu87SbF1cfOX6oE8Tb+iFmiPT3YmVJxEaoEs32G8VjsEQGbFIxdxLv2eVG993dwjbE=
X-Gm-Gg: Acq92OF5r25/aY31NWcgH64Ht7wwMA74B1cAZEQNppVFRBUNbQpqZJ7TfDQcNYlwPTW
	Fsho3cR2aMUbYkkuqyG4ZAKBXF6MvcgKozmByFjxxfFNB0JyZLqGQVvHqhPOH7Q8bL162TLM6x5
	bvB6NdRrtz2YEU+tcZJCqP8bvo1VBuqKFIaRF2gODo15Q2jrnKAHUECbfavaDZhSgmBpdUtWJxI
	oYVdBIXqdgThwAq7S8vDAmvsQ52jDnS9nm4TwP9sMXIS9PJhNWombZi+TWwZ9pZwl1BHv6ArRII
	3APttBlB9H07qFoz9tBem+ccF2AtTt0PVyDGsdY3Yw7OghkXEvKEgTG3gBXQwRiTP4+xCCCUwxP
	aW2m5CkgUDAqMY5ENR9batLXW9Cd8/7/nCnBvYXdo5L6RB5RWmbrThgLmhSVXwfSlHbrfUyvwXH
	SMzb9lGYINFyOmv03IO1XCnaND6b0c/KIPhFuzzRMP8+4Y8TEeMAT4gRP+/oZM43WqeL894Z48q
	KBL7ENBO/EN1tq0
X-Received: by 2002:a05:622a:5b0a:b0:517:7faf:bafb with SMTP id d75a77b69052e-51795bfd7d2mr326551591cf.40.1781108929553;
        Wed, 10 Jun 2026 09:28:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c60dedsm214392091cf.13.2026.06.10.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:28:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXLnM-000000047em-15sV;
	Wed, 10 Jun 2026 13:28:48 -0300
Date: Wed, 10 Jun 2026 13:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shivaji Kant <shivajikant@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <20260610162848.GO2764304@ziepe.ca>
References: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610151853.3608948-1-praan@google.com>

On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:

> Users utilize the standard sysfs p2pmem/allocate interface for managing
> memory slices once a BAR is registered.

I'm shocked someone wants to use API, what are you expecting to do
with it??

> An alternative implementation has been explored which integrates with the
> ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
> registering a BAR as a system-wide P2P provider, VFIO optionally
> allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
> new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.

That's probably more sensible but you can't have a DMABUF mmap
actually install non-special memory. The native vfio mmap still can,
but not mmap on the dmabuf fd. That's still workable, just keep in
mind.

What do you even intend to do with this? With the new work to tie
dmabuf directly into io_uring I really wonder if this is worth doing
for VFIO?

Jason
