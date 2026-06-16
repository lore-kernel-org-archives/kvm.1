Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1A3EEAE9
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591907; cv=none; b=SWmlPPJB+LFCTTVnX2yexmAPHeOZMwIRghuZISkgIxHCahAwmZa0jgdlujOSvZAiu+YUkE4ewAhFhZ7SZvqrWqlO7k6jETfNk46zNdEPDh+ndSsVIVLLza+45BEHGALq50/9AUt29wKQbDN5Z7uF3g08Ux/KQiRUGETT3uX+fEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591907; c=relaxed/simple;
	bh=EnxOCa15sZX3oEek17FpEAqKawL7WEZTyWucBlcjikg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPz8GBnB9XnBV+KCd0xXATmvIHOFOXiKw+lOAcDZuUtQNLyS2O8KiBO2RLRr9B2EaZLmeA7bgtjJBV47N8ADNauqYWQ+L0zv8SJXnseYkSVFrQ0Ylsf8CGF4p0XBptB0p/g1BxrYFWBy7JajhNVGbQA9OXGdt5VLG7dA13Vmfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9YNOphC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9YNOphC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf22c18ad3so35725ad.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781591903; x=1782196703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFz9lxRroKDDcTb/8ZfQJSCQqH8dCC3UQeivoDCOLsY=;
        b=Q9YNOphCFZZzWi37RFXsyfJkuN6xPhsL2EHamixCuR8nYfQxSirjTFq6YCytklhyAM
         eMyu3s0iw2LpUrrjXGvSArTOBoUrx+vjnEuy8PIGIHDzchmBIcEQn96X9tEXgCrJNUVR
         Vw1pbkn2smntXzDV9l7hzJniIyANjNt9b/548gyVPnYnHcfvo5bYoiQcoMELAUQAxgvw
         /O88/RAwb5CZ/EuVj6HRoM3PiOHKo4oYhviUHfhAnW/Lfk3qP3nVB5ibdJEZwdM1zt2c
         Bhl/4Rhxp6DM5zFPnQBNnB+BiiHDjiCAu5dFhuttkkkblwm+fM8XYmB4kVv8GJ4dVNHr
         c7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591903; x=1782196703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFz9lxRroKDDcTb/8ZfQJSCQqH8dCC3UQeivoDCOLsY=;
        b=tO5j+0HDgJASYELvk6V13v/2x61W+gWJD+cdKwzyyWCUh7zE/5DsFwbDJHqzeFVeHJ
         G5ILxuo8zKjKGOJJMrv4AmWDKC7VESk9+VDvqhX34Wc+hqM+Dep/OlWWial5iYoFpo60
         83FB5NNdgHaEJPqma5JSHeeBccoXzpIiLz2wN2sjlI9LY2QUTHr+b9wGwho/SYCsA3YD
         OGrQuHGNJDVPTDLwwnT5+QjM3PLglpQ3pky55O9LvOJGMI16ML+ULnI1d5YHjYaScQhz
         jAYMzSttIrcH+ZH/jwsfPlA/LJPjZi7QSJtQ04yoYpayf8iJnxuVrs/Szooa8zR9k+J/
         afRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xPLiayapV3+n+KSCcR7V9YcGoHVb1iYVZoKzf7LztsSNKxByb/UAxHKgwYOiLK/sWwnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJx1rNupnNM30Z9Afb1iy6J6rS0ADxikqdsK23U1lTocg/8YM
	0rs5j0MZb3scQMFxbzNHk48TZy6+noy8L2LJZ4F57Rny9rXMQ4Urcyd+M+bbDufkiQ==
X-Gm-Gg: Acq92OFbpKvHi4Y2nT+kCQOCSOd5/DqoHFvg5YIIF8AYiGnT7lLOMmVnO0H4PIjHwRS
	SVx7KkFjflw+2Tz49G/CQc7aPgnyM0QiIixy3myHpMZQk00njuU4tCpilW+oUajjZZ+bNAWQ56N
	BaRpY5wOGt3yuDK1TmESHeT1GXKdbyhyoLv3iLiyLp7FopVabKeMCbpbOYa4Vzez3C5lK5Vc+Hg
	KRb35N3ptx1JNlYZnV/z4UyAf5CTYxdP46g7s1wUz10Mipwm5fR9KRBHKPL3gzsQtv/TzosEf+G
	cRJ8AoVNGh9j3e3gsi9rQYY2qls7zFfiN/rKaNwKZ6B2QzZzdaQginFmjih2zLfQYR67jcakYLC
	6mzJA4kJh+auInjs9QJrKXVgX0ajqK/mliH7qcJWE58aysFA2g8XIZBPTZLOpEKPgPafZeH3sTj
	CKhdJA0Vh3kRIrlcySKIHnyT3HUphlv7tWe91AcVBy8oxHrQVXwtsZI2pVo84UXLpWlTlPCdY=
X-Received: by 2002:a17:903:2a84:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2c69a26dea7mr49405ad.2.1781591903036;
        Mon, 15 Jun 2026 23:38:23 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866519f0a6sm10345718a12.22.2026.06.15.23.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:38:22 -0700 (PDT)
Date: Tue, 16 Jun 2026 06:38:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <ajDvV4mOkaL9NMII@google.com>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
 <airI0VIb563jHTcy@google.com>
 <20260611221447.GH1066031@ziepe.ca>
 <aiwcquSgAonkh_6L@google.com>
 <ajCaTmrYQvKDoP_I@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajCaTmrYQvKDoP_I@google.com>

On Tue, Jun 16, 2026 at 12:42:19AM +0000, Samiullah Khawaja wrote:
> On Fri, Jun 12, 2026 at 02:50:18PM +0000, Pranjal Shrivastava wrote:
> > On Thu, Jun 11, 2026 at 07:14:47PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jun 11, 2026 at 02:40:17PM +0000, Pranjal Shrivastava wrote:
> > > > On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
> > > > >
> 
> [snip]
> > 
> > Yea, that's going to be tricky.. I'm thinking if we can have a zap model
> > there somehow? If the device is gone / going through a reset, we can
> > handle the refcounts accordingly?
> 
> IIUC zapping will only work if userspace is using these, but if you feed
> this memory into another device through NFS and the pages are pinned by
> gup (or that device) then the dmabuf move_notify/revoke logic on device
> reset will be tricky as now the pages for that device BAR are pinned.

Yes, it would be tricky. However the zap is still needed since userspace
is the entity creating the file I/O leading to those pins. The user would
mmap the BAR and pass the buff into a POSIX read() / write() where the 
filesystem (like NFS) would extract the iovs and call GUP to pin them.

By zapping the userspace mappings first, we prevent the any new 
read/write() calls and halts the creation of additional GUP pins.
(Note that if GUP doesn't see a PTE for the page, it manually invokes
the page fault handler and waits for the page fault to be serviced, where
it would then block on the vdev->memory_lock held by the reset thread).

I agree it will be tricky but we just need a multi-stage sequence. The 
standard workflow is: userspace mmaps the BAR and passes the buffer to
filesystem via the POSIX file API. Filesystem then pins the pages via GUP
for the duration of the synchronous DMA.

My plan for RFC v2 is as follows:

a) Zap the userspace mappings first to prevent new requests
b) Wait for In-flight DMA: Just as we currently use dma_resv_wait_timeout
   to wait for HW fences, we'll first wait for the page refcounts to drop.

   An important thing to note is that filesystems can't pin these pages
   for long term, i.e. FOLL_PCI_P2PDMA and FOLL_LONGTERM can't be
   requested together for a single pin as mandated by gup [1]. Thus,
   filesystems using ZONE_DEVICE memory (via ITER_ALLOW_P2PDMA) simply
   hold the pins for the DMA duration.

c) Once the refcounts hit zero do we proceed with move_notify and the
   hardware reset.

This is going to be the first stab, I guess it'll definitely evolve
further. I'll try to implement this in RFC v2 and attempt to address 
these concerns 

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc6/source/mm/gup.c#L2538
