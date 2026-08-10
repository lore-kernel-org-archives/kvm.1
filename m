Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997F432BC2
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384788; cv=none; b=eP4V/N0INWp0VkK1PtxH/5cPMGX9yfKbrEdG/cS5a2v/V+o6/JgOM0RhXr/e6o1Ab75jrf2pVferWQZRqUhqMQAIGnq61pfwDa+qa1yD++z8w3I8kTGI3pIpjRHQ+3dWvFZpIqAMxObXjqKHzFi4plRpEN/Q6fMXj4glpDYGrqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384788; c=relaxed/simple;
	bh=jshTh5JB+/7VGuIDYbUMdVTS0P25FSA6MRRrjP4R9Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3E6CsFxEsSKnCBfb8CUMP3TeddZUoWO7t1ddtxihct5SIO0HKepS5tCW/fH2kLt8VLejzUAyRwUoTkUkTV+EBhBQTD0IlLFoDKMjDcQpWNUbo3MSa6nK781Gl1zWx/6RQ+EIjTU/JKXs+sJn0n3ShCpKtcgLj/wahNVNA0D3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQlIx58g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQlIx58g"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacef7d299so10315ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786384786; x=1786989586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lpTAXT6Y1ZP0dqnAfIHtJoG8pQyeKSS7NFanb0wNrm0=;
        b=UQlIx58gaSYAZ6hz6UprFzP9YjWMCGjh7/dWUqcvIJfoLijPtmOv2/S/vpeZOGomvl
         X17VUiwy3KP1G/kKPUCTl5PUGuT4W14hWbkAd+pgBn7U9qdOMa9io1a3ieM3TY4wpfNG
         +mv9JlmoKs+CQ+93YI+FZPPoCoWeBjjfoLOCzgwANyCwxKmeXOknefGnT+fjoVmcozxw
         D6GrOPF+BQAYZ+aaKXH5J9xDM/PumeEKh6TeSVEX20MFWgH0+YM+HwdXahxZqOJSmX3K
         fV8HHkixICnLP+T+1OstSyK3hO+7Oc/TZXa57sv0+O7Qh4BaYvnf+fSTfqvGlD2/qnz2
         +/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786384786; x=1786989586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpTAXT6Y1ZP0dqnAfIHtJoG8pQyeKSS7NFanb0wNrm0=;
        b=KfSooB1gOssUiO1qlId76fsqPIGriJitRdu7FjSQHpyEfNevQDN5MOWofLX23fKHvr
         0jsd1CUrNe2wlkkO1mf1Qbz/A0Tzngm5BFtxeGefPbH5LXnp9GQytOmfteYMBZeD26WH
         Z11Hq7b+UKk8iDC/5k2Wd1Y4nd+S0nkKYD+fA7DDouLY2j6nT8fY526P/u/kjpnJPf7K
         cALADfa/Hfym/pTC3f8pTKGoWFeC3BDSuSD+mQC/fvsONhzZSFveVPP1qm95xVTm3neC
         JyvZRauIzYobZlu7W9V6G8Jqr+HkOORynn16C4ZE6JnSdRI8U0fTviwAdoew5UlB4rGx
         OnuA==
X-Forwarded-Encrypted: i=1; AHgh+RozCgt9pNGj3E3dsSm8NYdBKsXQFjDCCBJA2XEQiFGA9gvZ9gqLpRXTJ47++ZE+wgKisWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0Sc3CnDFjBy9oFF98SKUl7TTSehO7fOX0P5yS6/35fOThomC
	EDZ5q90gu8k53odR+qyjD5rGcWJhpjAhAwjSqnQkE4gRWkNtqQN+88Xm5QQhvu3UZEmlncJxiBb
	SJRAJ3w==
X-Gm-Gg: AR+sD12lchbIJUaUEJWpHdhiUsrxDwD/YsGNA2SbzrjdFxFj17cTigzqyKj4k0v2v+9
	EIj7lUUuxztGLK3jLEhpVWr8YbuUH1b4gDJyYCosSYV8TR4zLMdIpl3Zl1jChwmv/DtBegxFcIN
	SAfuhnMHZXziukKmOYVA+ApMDJtWmC34HmULITs+5I1y00pxMRihiZ4S6JFwd4FHcsbs9veinzy
	moB+e52Bja3qJ9V7MPSNaSIsHHi9XEA8Q9gJVQjNEKuZqdK9BXDWCj5TD4gasoIFLWEQkNa4r0S
	MepgsfsXAx+uHSmYHFaBimM8uLxZyQaU2rJynCQlcre4DKnP8maSQ1OcRFBBQoFlhngpP3u+91F
	/18QxVjWeoI7209pZQ0l6PoGmjsbmN3AkrskcF1PryWbZ6nw6YqyFc4YT8ihiCM0sLctnzUqx2k
	aOVNdr9bx0q4nQpYB6oxxh6Y5Xy+BGatVFjszHuB34nXJWEXwinbUPFQ4ZX76sqXe3tqb58gdR6
	XcDiv/aj1aT6VBG9zZkVjWctw==
X-Received: by 2002:a17:903:1aa7:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2d3105d4b0dmr814415ad.6.1786384785937;
        Mon, 10 Aug 2026 10:59:45 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e99asm4247058b3a.33.2026.08.10.10.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:59:44 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:59:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	Matt Evans <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Jacob Moroni <jmoroni@google.com>, David Hu <xuehaohu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/1] vfio/pci: Revoke BARs and DMABUFs during
 sysfs-triggered PCI reset
Message-ID: <anoRidZ_fdeIx1vs@google.com>
References: <20260807201405.3717430-1-praan@google.com>
 <20260810100352.1e2004c8@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810100352.1e2004c8@shazbot.org>

On Mon, Aug 10, 2026 at 10:03:52AM -0600, Alex Williamson wrote:

Hi Alex,

> On Fri,  7 Aug 2026 20:14:04 +0000
> Pranjal Shrivastava <praan@google.com> wrote:
> 
> > Introduce PCI .reset_prepare and .reset_done handlers to safely revoke
> > active userspace mappings and exported DMABUFs during sysfs-triggered
> > device resets.
> > 
> > We are seeing a situation where system health and monitoring daemons 
> > (at times erroneously) issue device resets via sysfs for devices bound
> > to vfio-pci:
> > 
> >   echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
> > 
> > However, because vfio-pci does not implement the .reset_prepare and
> > .reset_done error handlers, this hardware reset occurs completely unnoticed
> > by the VFIO driver.
> > 
> > Consequently, active traditional userspace BAR mappings and exported DMABUFs
> > are never zapped or revoked. Importers of the DMABUFs (e.g., RDMA drivers)
> > continue to issue DMAs (such as PCIe Memory Writes) toward the Endpoint. 
> > These transactions are silently dropped by the root port or trigger CTOs 
> > while higher-level actions (e.g., RDMA reg_mr) continue to succeed.
> > 
> > We'd like to fix this by implementing the PCI reset ops for vfio-pci
> > that revoke the DMABUFs and zap the BARs while holding the memory lock
> > allowing concurrent user accesses to sleep and fault back in once the reset
> > completes.
> 
> That sounds like a nice, serene solution, but that's not actually what
> happens.  Due to the write vs read memory_lock semaphore, CPU faults
> are stalled.  On the other hand, DMA mappings via IOMMUFD/dmabuf are
> lost.  They require the userspace driver to be involved to perform the
> unmap/remap.
> 
> Potentially this is all better than letting the device generate a
> machine check as it's still trying to run across the reset, but let's
> not pretend this is just a hiccup for the device that will continue
> running after the rogue reset.  Thanks,
> 

I tend to agree. My intention is definitely not to pretend this is a seamless
hiccup or allow the device/user to carry on as if nothing happened. In fact,
the very problem today with exported DMABUFs is that the user/importer *does*
silently continue to register DMABUFs with the RDMA subsystem and attempts
issuing DMAs to a reset device because nothing told them the state was gone.

I don't mind permanently tearing down the CPU mappings as well along with
revoking the DMABUFs. That way, we fail loudly and force userspace to unmap
and re-initialize (with a dev_warn() explaining that an out-of-band reset
occurred).

What do you think about that approach?

Thanks,
Praan
