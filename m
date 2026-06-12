Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559712DEA61
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277453; cv=none; b=g5SLnLUnZ1D4UT+1mifSwYGrr4+s9uMT7sXfb2Min93fl1NZNYNHu+jl6Q1/Su6HnkzkjVpKhr/RzcrCovImdFb6yNg3xgvrokYaxiV3n3TXuHBGjpzJeHIuHw38pTNJDcI/TlE1iTtGRwt92glPCcfgXJsLzFGcIkqMExTzMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277453; c=relaxed/simple;
	bh=DqXswA747+6bYY1uTzSstZbbvVg2LEzGaCUeKcgc+fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7SYK04WcNN6QIoIay7ThUQ990pzbJK02WMi7bee9oAvlrqM6zfEwqOdgWngRKp++R/3vxwCavbByUyK+Jnop+h9yQIHXDHaDDTkzuf3cJwHAfzh108btP7XzYyYXC2HwNMt8QMv9KStbi41LWfjB+IdIS7U99ymC9B9hbmmX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DG9h1qWt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DG9h1qWt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf22c18ad3so130725ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781277451; x=1781882251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlOQuFqEcpnxb6HFkKMVShmOdVTUgHEmVlFieGLUVKw=;
        b=DG9h1qWtDqUFvH2jnGQe74cqO+Mcin3e9wQwaDNY/xVaRLarO/RzGty8crffvjcuX3
         fjjAujlbyBfomVuH3aTvXe4PyIGGLTEf5Xd1BYWNSkl45i8himGPka1QAQRW0q4DnD/r
         hySU40dZSNSKcT6AGED7fRPZmITyuanDN8vPi3kf+hb6KT1GeuV05mWAinSwOYpedFZ3
         kiKP+CAcnfRmjgnKc55xY+Z2azQOKILhjU8dvCrWPtR5FlrKBWoT8PvoueBCKOHeugFF
         TGKD6aH9kH+6pvkQPi+IE9xhG6gkXqD+kv2KRb/AZWjs/KeYbcgCH4rFOxqTD2ZP1TKq
         8CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277451; x=1781882251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlOQuFqEcpnxb6HFkKMVShmOdVTUgHEmVlFieGLUVKw=;
        b=qiokeqiD546YJCl4O6zjWref/csrcnJ4MEnbHdQHxrbMHGWm1Jl9UvRrwh0ePK29hF
         Qb/+qolrV6wtXPac0qRjV2X+ckRAAUeaDgujNhpRbKCASy6K5fVpkoy9tfUsj3OVqoLd
         fKgUL4hRtfQubr3Ah6SsobSFk9Ea2boezRXNw6yKKcAdGZKsLsFsCN3Ii9EAGuTsLs2n
         9RjYJfl1FfAaTt7FjQx5YUSrEot8bvyFwKq0dloGY8YzFtg3tix1zcsdZAJ0d+vwdiZ/
         Cu1QHIsFMJ2Pi6wG2k/bU2ftEDxRHoh/WXd7zw/HyWVMy1PaetV4fSt8aZ678gTCZWQM
         ynSw==
X-Forwarded-Encrypted: i=1; AFNElJ+rPjzUGB3pC1UMX8UFsTa/YhWfm9PXSt8uUaPePQfOnmyGHLCtomrwpzcxfFrt0Qwg0xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPLjRJMMAnpkU0tfY0pRMEdtdE7mHZZsFWqHEJiz8vUIGymEQ
	YFuADJx90cKkj8AJ/nn4r9lK9kRJ/DFFpT4+C5GzO/ojetjHeXwTBHomsVufuC8Lag==
X-Gm-Gg: Acq92OGgoemZPwrCQ/zyjMa3x4eOeBGSdSnU+Q1527QamGus1cJo9Z0rAZqAqEN2kx4
	N0lkwNSKasyZcTB9rwJ7Qg2vd6CDkjNlE89BivKS2pZk/2NWqO5iltzf1h3r7d8k3AwvHD873GB
	GYl5gEZ/1+fn9l75c4485TQOvuaVjEK3a4S5NgIUbTMpAy9/DwIm6VSmMVWYp6pPsXdKCJVCc29
	Q+6KLyFK8A0/XD6XgJwgZRTcfT5T73l5Oofj84RK+iGCxdLNtpmfguV/X9g2ykwVVjQiukcUhE/
	2CYV18WJJ7mfxH5E0AYkMMowHLfVostSStP9wHxKfn9pO1If8iuMPOu3ZE+VKS4h3iQ2Zw0Va7M
	aOO6wLCuNT8zHFhIMYMRqS256NXCigdXWYKGc66e4aVVO/C+viR2py/ISstJFpvu6AUhb9ApF0I
	ROt5iBJ028OP/aDgT7ROyeOvbT6UHv/orU2d/Giy6bwnknk76CyWGZ9uk7VI/utGZp44Bkl2o=
X-Received: by 2002:a17:902:e805:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2c3e1160718mr2635095ad.8.1781277450033;
        Fri, 12 Jun 2026 08:17:30 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c14sm22623545ad.43.2026.06.12.08.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:17:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:17:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] vfio/pci: Add mmap() for DMABUFs
Message-ID: <aiwjAbFVhPkkj-6U@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <DM6PR11MB3690A65EA9D8A9B77AF93E198C182@DM6PR11MB3690.namprd11.prod.outlook.com>
 <9812ae0f-8f22-4d62-a706-4c7232a5656b@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9812ae0f-8f22-4d62-a706-4c7232a5656b@ozlabs.org>

On Fri, Jun 12, 2026 at 04:11:50PM +0100, Matt Evans wrote:
> Hi Kevin,
> 
> On 12/06/2026 09:27, Tian, Kevin wrote:
> >> From: Matt Evans <matt@ozlabs.org>
> >> Sent: Wednesday, June 10, 2026 11:43 PM
> >>
> > [...]
> >>
> >>  vfio/pci: Support mmap() of a VFIO DMABUF
> >>
> >>    Adds mmap() for a DMABUF fd exported from vfio-pci.
> >>
> >>    It was a goal to keep the VFIO device fd lifetime behaviour
> >>    unchanged with respect to the DMABUFs.  An application can close
> >>    all device fds, and this will revoke/clean up all DMABUFs; no
> >>    mappings or other access can be performed now.  When enabling
> >>    mmap() of the DMABUFs, this means access through the VMA is also
> >>    revoked.  This complicates the fault handler because whilst the
> >>    DMABUF exists, it has no guarantee that the corresponding VFIO
> >>    device is still alive.  Adds synchronisation ensuring the vdev is
> >>    available before vdev->memory_lock is touched; this holds the
> >>    device registration so that even if the buffer has been cleaned up,
> >>    vdev hasn't been freed and so the lock can be safely taken.
> >>
> >>    This commit makes VFIO_PCI_CORE depend on PCI_P2PDMA_CORE
> >> (commit
> >>    1) to bring in (only) the P2PDMA provider code.
> > 
> > the last sentence is stale as the dependency is now added in patch4.
> 
> Right, will fix.
> 
> >>
> >> End
> >> ===
> >>
> >> This is based on VFIO next (e.g. at b9285405c5f6).
> >>
> > 
> > Sashiko failed to apply this series. Is there dependent work in vfio-next?
> > 
> > otherwise getting a Sashiko review is helpful here.
> 
> It _did_ depend on (at least the context of) some fixes in vfio-next.
> Looks like it'll rebase on master now those are merged.  I should've
> re-checked this for v3, oops. :|
> 
> (FWIW, I had Robot Claude Opus 4.8 to review several times up to v3.
> But I agree, Sashiko would be interesting too.  Can it be manually
> triggered with branch guidance?)

I guess relevant steps to run locally are here:
https://github.com/sashiko-dev/sashiko/blob/main/README.md

Additionally, we can try providing a base-commit (which points to a
public commit). 

Thanks,
Praan
