Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7D4D2EC5
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203070; cv=none; b=DNHndH8QwBHVWRODG9UwesR+zCo4Qg0ACs16nHCmBDK5GNSsTRNBySBAHOUz9RlP8vaTpEnp2c9dMxu/ZuHPmhE0xnK5rZX4TEUprse3ASyWlbIjAdUdq00+ngWaD7knCIipSIQvlpG2xoVoZYwDphwr4E0gryZphjlVp5ubXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203070; c=relaxed/simple;
	bh=oPRuHZd15dUUmcqh2bABeoIFDALTVfx3kPDHeu3o98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMCe0BBFidihx5WKNdrt2jL7+Dlgo4CKi2LQeTNnGpLqq4KTw86h8gicgicHsQreA1VuMPZbTXk+VyXTb++X+m8GEPp6hn8bL9X69A+WeUMMfU6rieq/1ySUx6gyrzZvZMXVQMxE6BXeccMU1KRPcBjhw2rMIjkpWngw3fBHPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aW+atQ5M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aW+atQ5M"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2d865383so14775ad.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781203068; x=1781807868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TFfh87PJEUZx1rJ8R/E1mrJDSDu5E1AnG3uHnDgisU=;
        b=aW+atQ5MKBCMrL3cI29ayyN3oAsACp17FOk7gijyVhzYqKclTp+UDt1gJuoUhaHCCF
         hOHgiLxI9aGfjbLtJhyCNgtG9DCTWToTXgOHlYRwYI/UbcQCSI+45XzLljlA+ZR8FNQE
         axHiTD7XOwIqH6PPMtj6OJFNPo0ZYmh+/CQVd7hLBzK5LtpUfU1PvlzzZVgaDPnX9xir
         o8gCHO6qvuiQ27V2YT/kfPPiI5NxNbMbs1c2j5a3cEU7Z5mO5/UaU+47H7nFF0tbhBlS
         6Wd3T3OedpWYP2sGa+g4bU15eX360oaUmhaYZiK/yYuuHnZ9Cswu3CKwOCxJ9Z+h+mLh
         Iarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203068; x=1781807868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TFfh87PJEUZx1rJ8R/E1mrJDSDu5E1AnG3uHnDgisU=;
        b=hCOZWJMYKFMOTxbE5c7KT2ykNQl7keofVlCKQQGb8cJ/rWEHMELfD0qKVFxjzaNM3C
         v2NKJ2FYOM4i9YXj2/BHoD0sy6XLiDSyJ9BpgBirmYfKmmOzp91JOgPv/1oPz/Ht5wJ8
         poAtoLwXG+qbjcpOkvLzdf7HqcdrPT1JAyvS1CykSXPIenJQK02EddAsls94x3frlVIs
         IZcYKE2D0NjTfeSwvj9Ga6Ve2VLf0RjMKbTHR+xSlOpsyKsakk9O1Kjtup8PGUGWkeib
         p01+qtjqiU31w822AXq77m/wNJ0279lzPRwPotOvAclLSvC7Spj0ofkYTOd6QZ2CFhE6
         mzEw==
X-Forwarded-Encrypted: i=1; AFNElJ+CSkXxkzF6koST34P48qNOustonTDTt81cu95YYZGtExgRlGNA8D7RIUXtwm+cqItNQv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIrPGcAHKTKp1tre+rh625KlOQ2aZqLJNRAZQCfhxyCzcuKNU
	eYCaNTnM4cKp4oUV6bmD45gQLEDbVqgivWo/a3qKVXo9CGZ28YXZs5gyW4TZVCtaEQ==
X-Gm-Gg: Acq92OF7th/T6cG6Kb96OLz+zjFmUEJBKeibR1l1xid08okeiHiZDojjDWniolYLRLl
	W5Qodnc+bJpDE8J0PnfDrFF26xWQS7n+lHVmy1Pkl+7DhE8ZEHqLRC418h1O6ir8QRKud9nnw9p
	I0Ieb81exqYLAF+DaHgG8qeAXdaFn64E8OgaZ7yXrQy9x2zkz9Yl7f7Z0xK6HOhABdumPTr8wYD
	WRxKj6cF3VbAOMyno/q0QiSljjYSfvcAmeK7vLllIZE9QaDvBNTn0GTcPc4XjGbw9o3sxPpFAlF
	z4COfFe59PhUyeP71+xKPxmFFHnv0HKJQzeWl/LqtUbAmJqyHldqTStoiE4rXt4Nbc8yfDWzHiY
	SvybArTdATWBAvRVM0YwKpVnJD3/S51tEcT3d8V+ttu+jDueezRak9JBNa1vQNVX7y/JbltYMyJ
	yhDNUHIz3Vmhdyketw7bSEpb8YWN3PA3ns1pI7O2eweSmiwX6+MB8+lQCa18/N
X-Received: by 2002:a17:902:ce02:b0:2bf:b01:2b4c with SMTP id d9443c01a7336-2c3e3f69092mr255655ad.9.1781203067344;
        Thu, 11 Jun 2026 11:37:47 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865880c00dsm2085451a12.24.2026.06.11.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:37:46 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:37:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <aisAc1HRn2Wa4F9p@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-2-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-2-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Some drivers (such as vfio-pci) depend on 1, without having a hard
> dependency on 2.
> 
> A future commit expands the use of DMABUF in vfio-pci for non-P2P
> scenarios, relying on pcim_p2pdma_provider() always being present.  If
> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
> when P2P is not needed.
> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE).  Then, drivers can enable any
> additional P2P features with the original CONFIG_PCI_P2PDMA (available
> when CONFIG_ZONE_DEVICE is set).
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  MAINTAINERS                |   2 +-
>  drivers/pci/Kconfig        |  10 ++--
>  drivers/pci/Makefile       |   1 +
>  drivers/pci/p2pdma.c       | 109 ++--------------------------------
>  drivers/pci/p2pdma.h       |  29 +++++++++
>  drivers/pci/p2pdma_core.c  | 118 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |  24 ++++----
>  include/linux/pci.h        |   2 +-
>  8 files changed, 174 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/pci/p2pdma.h
>  create mode 100644 drivers/pci/p2pdma_core.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c6d79275c6..b21523b3bd8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20617,7 +20617,7 @@ B:	https://bugzilla.kernel.org
>  C:	irc://irc.oftc.net/linux-pci
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
>  F:	Documentation/driver-api/pci/p2pdma.rst
> -F:	drivers/pci/p2pdma.c
> +F:	drivers/pci/p2pdma*
>  F:	include/linux/pci-p2pdma.h
>  
>  PCI POWER CONTROL
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 33c88432b728..59d70bc84cc9 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -206,11 +206,7 @@ config PCIE_TPH
>  config PCI_P2PDMA
>  	bool "PCI peer-to-peer transfer support"
>  	depends on ZONE_DEVICE
> -	#
> -	# The need for the scatterlist DMA bus address flag means PCI P2PDMA
> -	# requires 64bit
> -	#
> -	depends on 64BIT
> +	select PCI_P2PDMA_CORE
>  	select GENERIC_ALLOCATOR
>  	select NEED_SG_DMA_FLAGS
>  	help

Nit: Did we drop depends on 64BIT intentionally here? I guess the full
PCI_P2PDMA stack still selects NEED_SG_DMA_FLAGS? IIRC, NEED_SG_DMA_FLAGS
doesn't select 64BIT?

With the nit (and Bjorn's comments addressed)
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
