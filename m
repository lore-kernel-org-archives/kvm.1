Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2337DEAA
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617223; cv=none; b=YePU5M39NaDELH7wx0ModIDutmVs4+2NPG+Gb7EL07Mmi8n4nhH8C5FIP8ZDC11dPVrQnfBYYG108AlXrsPiWJ4CvPrclOgvyWQl7HNXWNQZgtnXK+gRy9eoRPwkn39PoU6u5tdUMZxU+5QI45y6/2w4YLgI1K8dchy7QC1TtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617223; c=relaxed/simple;
	bh=QdNfN0ISSUjgfW1QMFBsgvu7FhR36K/NVC/mvHq2uII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwrAgNIYdejtkjPFP1E03cw33mQnNm0J/rWk7CtKvhFUGfsq1zZWbVWqVGp1xxLiMJ1oeaI9IPDPIBnHJj3FyGWYQGjzmOGGW/cWND2nhJJZtmetfDF80FEBgD3QDPqreoFAg1z4wYOFBWK0ukaBUmdDYBr3K9EeBCOeucu6hGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=URnM+XHe; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="URnM+XHe"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5175eab3a93so9819791cf.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780617220; x=1781222020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmt/JkLWWliz/NxTk163pbkZkRgDeZpSMIwPpktcw8U=;
        b=URnM+XHeF3GIgHI0JrDMkcoPyQVgGv1eeIavxQNq6iwnFmOJYg1WoCOSHGOdc+jbZw
         kHWUpyMUdiZWW+CDM0AYs+HPR7RcmYbylCDI1buXGO7tyH9YPARVOdv2YnUXAhMLBFMm
         WW4vQJI30xOkHZBvzXGIRKe6evy15rjDAr7jcreOS6QSafAtbJ1QMLvigsKx1CzN9xK9
         mXX/3frjMWB6A65rRe9rmaCo/13iG+H3FpaArSvuwkGjwsbg7kUHs9xx5M0n1jVz//Vl
         Jjxt8sktw//wSz1cMx7X1YJiaQ9mtJKz5BuLBR/FHhOoRYVNNUnUAP07vQBTQXeDkV0C
         u/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780617220; x=1781222020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmt/JkLWWliz/NxTk163pbkZkRgDeZpSMIwPpktcw8U=;
        b=GeWTDH83GvhEjW+LjIMo4LVEI+f+lqPGropM9LdUAnn8ZHslp87PJFrt3h1Lh3e9w3
         lZIixcH+LyW3jvEuXBmM+pOWUu3VfPu6h4kb1cGaMlWFd/rhLUSuc07V/PV6dkoPBovm
         47r8cOuK0H4koKIDaQYvCLOQEfdbH8KEgirywq4oKn1RBUbilIDc0BhUG99zdISt+s3Q
         hlmCaqhQoLp1RPTMIQVhtmdlpRzIImxaT6Y9LnI4EGHD4z0+xjeop826N+DajXk+YEHR
         b8tMBDeSI5Sd1ub2nZ7rziEenMc+djWjzFCSpzSDxB/iFgYGB+rQv3xQtLsIAkQKV/TI
         E9fg==
X-Forwarded-Encrypted: i=1; AFNElJ/hqboN0rCtNJC1QMTU9EBGr0A4mXoARKhnWG7WvAFLLknGDdzsatwOw7/l291cNp67R2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6Y6n9WWw+K4EY38Qu3s6arx9YdMlFJiI7WbbdtsxZTsZzFsG
	degcTGQlht/7R6g3Atmmw92oe7TY+oyQpBRdj20kaowYfaCuG5h9xuSsh9fY0pW/MLk=
X-Gm-Gg: Acq92OE+DrXW3OfTxG7Zzn2rJuMzIzJufeJVMrM0uSePJMOrjUSTDcyVLXDQrds0CkP
	JMspPTXhVcw9cS1A5bYDF3yYCVPJvwQnpV/+fd1FU8ig434aRNlQx1DZjG+bqBqugM8IniUooSH
	+uT5kD1xmJcQL3k0XOa3Nrn9HIAIwPxUip9+ImjBu3rczG8Rp23ityaq7u7vSlN+/PtXHZ74RnI
	sPgXrRhbQy/mHKxMBC9BBUSyKPJPdWk75OfRNhn4YNl8rAuDtjk5ZvRAHm0NA5+lH06G0lSV707
	wwLLBTRGNVW+/rYrEeNIXJ/DTNqcTEFyM8UGoCsn3nBIk0ZVZaISZBSPfAZdnzajA9anNenZA2z
	1dxQpr8W0TbWU3H7VsJ6GleOkMCvpHcB3YzEYCH+sjcXOyPFVb7R0L08j4cMKaEvYODvuKoNljY
	2ATA2Bt6V6wPD1nudXv2t+NlMy7D0QbN8elaRL/ZClGpmNqe359Pce27ca8PrytsRG+NHvR/aZW
	YuouftpSKG2Vdt7
X-Received: by 2002:a05:622a:6187:b0:517:6b31:8048 with SMTP id d75a77b69052e-51795bccda6mr17320401cf.35.1780617220214;
        Thu, 04 Jun 2026 16:53:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051facsm64970176d6.32.2026.06.04.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:53:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVHsZ-0000000A3UP-0kpK;
	Thu, 04 Jun 2026 20:53:39 -0300
Date: Thu, 4 Jun 2026 20:53:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <20260604235339.GE2487554@ziepe.ca>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
 <20260604182031.GB2487554@ziepe.ca>
 <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>

On Thu, Jun 04, 2026 at 04:49:05PM -0700, Dimitri Daskalakis wrote:
> 
> On 6/4/26 11:20 AM, Jason Gunthorpe wrote:
> > On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
> >> With this patchset core enumarates the SIOV capability and can identify
> >> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
> >> To support device pass through, devices will need to add a vfio-mdev
> >> driver with IOMMUFD support (or something similar).
> > 
> > There is an enormous amount of missing work to do something useful
> > with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
> > components in this plan and there are some missing PCI SIG topics too
> > IIRC.
> > 
> > So, I'm not sure how much value there is in merging just the cap
> > discovery without a roadmap for the missing parts..
> > 
> > Also, I'm quite surprised to see this out of the blue, there is an OCP
> > workstream that was building out a standard that outlines how all the
> > different components have to act to successfully implement it.  What
> > is in PCI SIG was just some minor foundational adjustments without any
> > context on how to form them into a solution.
> > 
> > I think it is extremely premature to merge anything related to SIOV to
> > the kernel. Join the OCP work stream if you are interested. I think
> > the general feeling was there is not sufficient interest in the
> > industry to do this and it has gone quiet.
> > 
> > Jason
> 
> Hey Jason, thanks for the feedback. We (at Meta) are definitely
> interested in SIOV-like capabilities for device passthrough to containers.
> 
> For those scenarios, having PCIe transactions per RID plus IOMMU
> isolation is enough, but I can imagine hypervisors/VMs requiring more
> platform support.
> 
> I hear you on the broader support story being premature. But on the
> other hand, this series unblocks experimentation at the driver level
> for basic data path validation.

And you can do your experimentation OOT :)

Go to the OCP workstream and finish the standard if you want to get
something merged.

There is zero need for SIOV if all you want is containers. containers
do not require iommu isolation or unique RIDs.

Jason
