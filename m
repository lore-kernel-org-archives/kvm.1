Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64F49363E
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991718; cv=none; b=DoOxjuDWeRXDLVkcjZijcfurNw92C1e6c2wwTKFYlax6SH20JrFhPTHPrdMDcQrcMjCkfGhloAAks5Keact0ur8hYNI7Aose93WIW3iAFowfa19KrzDMkoxvLk22GF9/6dBGojBn2JfzXG/xsSzG0+FTDCh5fjoPAMhpmrWRoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991718; c=relaxed/simple;
	bh=x4ZR/35KD2CxuvtsQBW7vNL6jE8skBPQeFvOsLTptis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOv0zYqM/5DYFti4SgcdJD98XC2sknOFPqZYA+KbGUU4sf6hOXSr3l90JpwZOER1qTTIJ6UiO1XSHJ8MpvxKCgx53QEYYWwaT1M+D8PcGYjjz358QsKFL461JSyLffrBL92LTlTVDwdgsfMpPlnlvyUOLGlH6b3KXgbespzZ3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BwwZBE+0; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BwwZBE+0"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067cso304642185a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789991715; x=1790596515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qZHfowJU9Gcgjx9yDF775AN/BbRSMKh2T0yPRE0+ftE=;
        b=BwwZBE+0VUUSuKlhncHoA99Hh3+jh0/AtSRFx8rexSdZVXOmdfNhJyTUAPRUy63Fcg
         e+VHIynSPJI0LUk7JAlihyJ/DaoqPKDgX1Ap4mrpbrkccmb3fRWDzyx1OxL0lyn6+ksv
         8Q3rTaU3BfEhuj9cIzicGFCVIjPFs8JHg0Gl6zYRqdwi+/o9UKCFlDg3O9mahVlwFNSN
         M0l+TT069dtda7EXKCSUgcheXPI1CPILZBgQddgNRezHzIr3K1GWYE+Ul2HbtV5yh9fc
         9MV6EhvVRImM2evj7bjzYZxH+olDjNAemh7q3QSGkwqzcUfGh8QAQUWn7wo/sOCUyN6M
         lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991715; x=1790596515;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZHfowJU9Gcgjx9yDF775AN/BbRSMKh2T0yPRE0+ftE=;
        b=g3evKlP/hGzcx4ZvzLlmx0hMxTUr56HV9PIhFvzKXFDkiF62ReuuMYhfm2NBpWNNMq
         T5Vk2KrAexrf1uoXH+EwrcVmc7+6e+2vq1T0EDj7yk08EySb0GEPOPHL2qob8P/Z5J+W
         JhzTzqqNvZenF8JjTnC7fqFbLj+LP8KaEBzvJ85KmYOG0vGeDHedfIVrZ+RFxkwX5gj0
         XBZT3M8G2mzlN/UQoOYjADIm6EvXo7cPRN/rT9f8XaANT464oUZk4giWZLuei5izekZ/
         2dNHYcMmaHQN6Bkc4kcRlyiBGT3HDzWOdnAotSQvO5+NQSRkU5hV+8VeVZ1gHyL1P/V1
         INfw==
X-Forwarded-Encrypted: i=1; AKwUvBzZF1Ybq9kQ91Ucnk48gVp+zsKVWZVGKgTlbMyThw4XYx3ODYC3l8ZL9b5StRgxxSIDC78=@vger.kernel.org
X-Gm-Message-State: AFuF++nVa4cpIdH1oiws+TazNKeZopqvVWGm6R+8rQcq0HC94AgpaUPj
	tOzHzxXF7/VpbGw4ty9UHi+SG/13bQbT8ezLS3VviB4pO/feALx+Ypu7na5DC9Ug5pg=
X-Gm-Gg: AYBFou0Ys8+4a7ciExcgVuzm4M7jLN/+yL4Txxb/n7gagBMUG7kg2qseTCz7HWSx42O
	/0vY1hTGYLIQpZ6jsPz0lGV1bW5YDmcRWcPHUoJc5t3ic29lshznRs0ZSBdGLlKQECLQkcwbRMZ
	awxXiucJL09HeKyB4haRUYCwTtEmAfvZ8NdeDcek3c5wXBhQFZv1yYb8qn9Wa/0svPEwI3hlAAq
	rMgnrua+NrKqb3CLsWeMwpwNv8bMYBguH7r8qkLiPwyS63UN1NGCPTib8Jx82dQ3Yu23txdylHG
	d4qZ+8pBuxAWEGBMaeFmuZSUuVr1R9h72hl2QvCVuRmU76S14xC64+y/aK1PhyUKyJ/c75wRo5F
	+bLTbgZor4j6gthZB9vFsQ3ZLtZWpkYyXaW6DFkf0C0vW8fTj88Xi3ywydkxAyz2lUCIN2/Or9d
	ojxZt2R5v8RsJo2aYpjCLVdpj6AEd4H1BKVXFdEsvqwpqxzX8sAQ9KyucwQXm+LpohDMJ5b+6pM
	ETSqimMvLnjfBrnNewY/QFylNs6dcLY1jcd1fbA39Eoh+CLiT3VomEz
X-Received: by 2002:a05:620a:4492:b0:93b:c22a:e98a with SMTP id af79cd13be357-93c15d9e687mr22451485a.2.1789991715373;
        Mon, 21 Sep 2026 04:55:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93beda70a1esm612157385a.11.2026.09.21.04.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:55:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x8cc5-00000006EDj-1rtR;
	Mon, 21 Sep 2026 08:55:13 -0300
Date: Mon, 21 Sep 2026 08:55:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>, kevin.tian@intel.com,
	alex@shazbot.org, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu: Reserve PCI host bridge MMIO windows for
 IOVA
Message-ID: <20260921115513.GK11599@ziepe.ca>
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
 <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
 <a82c3113-cee1-4e27-8c10-b7616f860a93@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82c3113-cee1-4e27-8c10-b7616f860a93@arm.com>

On Mon, Sep 21, 2026 at 12:24:13PM +0100, Robin Murphy wrote:
> On 21/09/2026 11:39 am, Guanghui Feng wrote:
> > The DMA IOVA layer reserves PCI host bridge MMIO windows via
> > iova_reserve_pci_windows() to keep IOVA allocations from overlapping
> > those address ranges.  As commit fade1ec055dc ("iommu/dma: Avoid PCI
> > host bridge windows") explains, a host bridge may interpret addresses
> > falling within its MMIO windows as peer-to-peer DMA, leading to
> > faults, data corruption, or DMA transactions being misrouted to the
> > wrong PCIe device.  This is especially dangerous when a device sits
> > behind a PCIe switch and ACS Upstream Forwarding is not fully enabled.
> > 
> > Passthrough paths that let userspace pick IOVAs did not honour these
> > windows: VFIO type1 and iommufd only excluded IOMMU driver-level
> > reserved regions (RMRR, unity maps, MSI), not PCI host bridge MMIO
> > windows.
> 
> This was intentional - I forget where the exact discussion happened, but at
> the time we decided that exposing reserved regions for entire windows was
> the wrong thing to do, as being pessimistically inaccurate might be OK for
> the internal DMA API, but restricting userspace is another matter, and I
> think the consensus was that it wasn't really the IOMMU layer's job to get
> deep into PCI details anyway. Such "accidental" P2P can only happen within a
> group that's assigned to VFIO as a whole, so IIRC the conclusion was that
> users should already have enough information at the VFIO level to avoid BAR
> addresses if they need to.

Yes, but we never did a a very good job to make the information
visible to the VFIO userspace level, and I don't think anyone ever
implemented some sysfs parsing to try to get it.

It would be a nice improvement to expose these pessimistic ranges to
userspace through iommufd so it can choose to opt into them if it
wants. Some kind of helper that the dma-iommu.c and iommufd can call
perhaps.

Jason
