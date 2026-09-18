Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABAB41A506
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737210; cv=none; b=aPRCldOXlPb6ywdeYy/BXa2rx5qCFCGJl/yE/0dGuCJnTPCzvQUX/RPRUQRAUOyhBk9BIhFjYtJ0N7clOVqNkpVHdnx/jFz6wV4pt3omjWKKQmxcJG5Kbz6bwllH0NXX0v/KgTLI8pt2avjKsU3bZ0YdrzT5ERzLH90LPxDGb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737210; c=relaxed/simple;
	bh=0e/Us3WlYuqZCrvqyucnYIvOewYG6+iESgxv213CRfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ra+QAl1uRJWWC6v9S+hOJ7oByISUZ5kqNUElkeElDYcm8WXgEsccS1VT4ssQMFPuV2LgxUglRtwc1zhtIM0vw0iwHqg5m6kl1CMF8UwMqPX5wLuaLJ9D4te3uj3aicL3nwYJyjZHYEVuR77xi0HucRIpjx5oF07f8xhHOvvK8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QymDbWPx; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QymDbWPx"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb767cc7fso6295621cf.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789737208; x=1790342008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RgJgP9V+TanXYXiwf33sE6+6RN244WVmbEbqLcX7cFg=;
        b=QymDbWPxT3LIIkAo24f4eqDGDQL8cnAxHXQdGvCMdYVBu9HuWti5/IeVLbVSeaAzl3
         WX2j58XQXmSLMksuVUzTfRpBaxjZne3SqE86c0anqQppyuEnL3qgemBbrX9XoY4+ejja
         4lOANYFlwqrV34QnNlaJrE+Us5d3DciOB6S0nU5dFH8UEOvAnzHGKHq7phwlBqMxNBm4
         Gq5PS6+VvQZSaEt2V1Z7FO+D2gk4HeOaQiOrpUv8a4bKLyo9s7uefYOgR8Ba4oPJjAYj
         ar6w1dcRwLdDGhC9sDIIcyM6rmKUOr1JmnHA8kIMQu/UZITv6qoxa28Yera2UJX3U8PC
         tBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737208; x=1790342008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RgJgP9V+TanXYXiwf33sE6+6RN244WVmbEbqLcX7cFg=;
        b=Q0JkK7eAKj6Dkpq8XX4atAJTrxw6G6JVPI5sCXAlWsnGFk68M3uIhhTnGXYnZtSKfN
         BBPLt7rEqFxlRB8E3hy1GtnU/CkufmptUfQfcoHTbnovgw7cZcfGR+VJN290G4chpdST
         p66Q8M/dZSyuL/ns9jzyK91fdmmFPSnv/pyezXPrD8XEvDaaLj1vo/CWgdraXe0QALnT
         /Xc7XVCAyuQMHZ5MqyeHGKi85YwffkTPXRqXQ2kOED16egOxrwwqECiOGOLj3cxnLbHz
         xzTNtkSlNNAGK32QMnDZPtW2y5MDZoEOGiePwbDKCgx77976xvstFYEkv9oElkS0iLV/
         xJyg==
X-Forwarded-Encrypted: i=1; AKwUvBwjWGapaqrZASZJRS8tGEVHtbd04fsooe0yhf7+1su9Dm7tAxoa8n9G1PuvOWEAcj5gWHc=@vger.kernel.org
X-Gm-Message-State: AFuF++kpZDBEXTbg1n+vy8N+atxXUeMQi1mVrd9k2pgXQp4Q9Lw/fv2H
	RgPntZ+ty9AlTLdRvwjYSxf2kDHhU9YyvI9cIujuQjdlcn79IdTl00//x5242JVFnZQ=
X-Gm-Gg: AYBFou3RxcYk9AMLZcFxbjDPKfJc/FZyxpPuk/5zte5pE5v9WQJanRQAsC2fWMpfJrC
	zCKZtmjj/r0pwHzVPaI1vtHCB56b5DTW5vnQWC+JTbfI+ggBpMkFqW9BPtUJPzWo0iUY4uiXTQR
	+bFaM1QfVwy1FOfqJ9gNjQlPyvA08UTJ0r8jdTSKtmTIHPDpC4nvfN890jt/8Bxj9l33McWkImd
	9zz+9rjHx8gI8wBcbH3/wlBz2FqeKNHm4KeqMZMvNToYV7dNNx/h8H8Ib3UsuW28BS1qwGVCWRb
	/qyVNqH//0+xP2CZIU0Mx5vZ1RVvePg4mwzeAdg2dyW1efHj+142GdPFTi8s0gUICSeOy55oyYT
	DFKTBPTO62HyCVkC31gXlzWKpHugT8U/aAviyM5I7Jvsgp+zyXzR5xYrg3I+Q6oldYsMv35WDS0
	fGLJpEljMqz265dIL7SkIUT4SgWtAtv/szHD+K3JAGFUiiGe5m51KLgUz8Ag0MF3aGYO++DMJUJ
	8veZH8EtXDpz/XGlzr3G2hctDQ4EtLqM++sTS28IOw4nJAsebWUB/rm
X-Received: by 2002:a05:622a:550:b0:532:a5a2:e652 with SMTP id d75a77b69052e-532a5a2f397mr15646941cf.79.1789737208228;
        Fri, 18 Sep 2026 06:13:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532aac41140sm3599291cf.5.2026.09.18.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:13:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7YP9-00000001CUD-0PCN;
	Fri, 18 Sep 2026 10:13:27 -0300
Date: Fri, 18 Sep 2026 10:13:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
Message-ID: <20260918131327.GB11599@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <f6fb7f1e-a296-4142-9b77-64420edabe64@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fb7f1e-a296-4142-9b77-64420edabe64@amd.com>

On Fri, Sep 18, 2026 at 11:09:29PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 18/9/26 00:01, Aneesh Kumar K.V (Arm) wrote:
> > A VMM needs to forward guest-originated TSM commands to the TSM
> > implementation managing an assigned device. The IOMMUFD vdevice
> > identifies that device within its vIOMMU and provides the appropriate
> > dispatch point.
> > 
> > Add IOMMU_VDEVICE_TSM_REQ to send an opaque request to a vdevice and
> > optionally return a response. Define common operation and guest
> > architecture identifiers for CCA, SEV and TDX requests.
> 
> iommufd_viommu_provider_ops already knows what architecture it is,
> why bother with these identifiers? Thanks,

At the uAPI boundary we want something like a strace to be able to
dump and inspect the system call without having to inspect hidden
knowledge of what is inside the FD. That's a huge PITA.

So saything 'this is an x86 format request that uses this coding' is
the right thing.

Jason
