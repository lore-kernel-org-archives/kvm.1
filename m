Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EB3491D0;
	Thu, 16 Apr 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345263; cv=none; b=ubsEIqrEa974NszPfL0S/hb3v09NbRDrrryRIARpj6jauGYtqBx0oBeKYYsuLyDVqElUiaL7ev0ZIfoVElxP6fMndtpPkjeAs3QA6bMvmOb4aQ5LU9lZC7TBcteZiwcL5QoUP8JD9ceqRhGjeJP7m9RnCbCN2h+oSfvbJjd0jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345263; c=relaxed/simple;
	bh=sPKnP71zb9YilBEEQ5Tq+KgRZiI1TsYmkKTaWM6H1xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFwgMgjgL4PULQf7HnUDshCD/74P8NgJsJC2xZjhg75UMksbFz30i7Y0NmNmReiFMhydkaNITlcLTcpmY4zumGLoy9dJnESpgfXMG2+fF0mywT5G2sGzm/k2WzcMPvJ9T/AGY8nQ9GDfJIgqknJrf7cUlit4J+KXE/oKwCokl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jugNryfG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jugNryfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CB7C2BCAF;
	Thu, 16 Apr 2026 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776345263;
	bh=sPKnP71zb9YilBEEQ5Tq+KgRZiI1TsYmkKTaWM6H1xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jugNryfGz2KGhuk0ZX5atc1buCfydKOSnrbZSfQ/f7GhZOz3QIg0nrSPXWFCyI0cs
	 eZZyL6mOYruOF3eHwZ/G6ohc2XvfK0iWgf1MlATMC+42FJy2hHGK3ZXx2RNa5gVp84
	 f8Od1gFqyq+kMJYKBPVddZkKIn0ebBB8cVKC/f7jGVjnR9bSUdUKMqXBYDrFDGNA0X
	 B2iCVdezNHLUhs3DhNB8TNZ/ydr3VlYbnKWPLD9SYLh0PbxGdWDqJDhnYy1WM6Uzt/
	 BjIlKgzrZqbFc6r25c/iKbGnHW1Fm9POF0FifmwGzZw91XYamq2oT6CS1P8CRdxyUI
	 A8tqWmOpTo4Rw==
Date: Thu, 16 Apr 2026 16:14:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Message-ID: <20260416131417.GF361495@unreal>
References: <20260415181623.1021090-1-mattev@meta.com>
 <20260416081138.GE361495@unreal>
 <2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>

On Thu, Apr 16, 2026 at 02:05:30PM +0100, Matt Evans wrote:
> Hi Leon,
> 
> On 16/04/2026 09:11, Leon Romanovsky wrote:
> > > On Wed, Apr 15, 2026 at 11:16:23AM -0700, Matt Evans wrote:
> > > Although vfio_pci_core_feature_dma_buf() validates that both requested
> > > DMABUF ranges and the PCI resources being referenced are page-aligned,
> > > there may be reasons other than alignment that cause a BAR to be
> > > unmappable.
> > > 
> > > Add a check for vdev->bar_mmap_supported[index], similar to the VFIO
> > > mmap path.
> > > 
> > > Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> > > Signed-off-by: Matt Evans <mattev@meta.com>
> > > ---
> > >   drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > index f87fd32e4a01..4ccaf3531e02 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -249,6 +249,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> > >   	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
> > >   		return -ENODEV;
> > > +	if (!vdev->bar_mmap_supported[get_dma_buf.region_index])
> > > +		return -EINVAL;
> > > +
> > 
> > And it looks like AI has valid concern about this line too.
> > https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260415181623.1021090-1-mattev@meta.com__;Iw!!Bt8RZUm9aw!5DxsN8cDUviPIZqEjG0pZ_VYYbl_RdmWucTGdTZ3ZzlVP_Ysb0n7ykr0eXwFXdpuqvZH2FK3$
> 
> Ah, Sashiko has a point, and I think its suggestion of checking lower down
> in the default .get_dmabuf_phys (vfio_pci_core_get_dmabuf_phys()) and
> preserving driver overrides is decent.  Will revisit.
> 
> To your other question:
> > I noticed this check in vfio_pci_core_mmap(). Isn't that sufficient?
> 
> The scenario in mind is doing a DMABUF-export for BARs that you haven't
> necessarily noticed can't be mmap()ed, and both paths should be checking.

I added the validation checks that matter on the kernel side, but mmap is
primarily important for callers. What I am missing is an explanation of
why the kernel should impose this restriction on itself.

Thanks

> 
> Cheers,
> 
> 
> Matt
> 
> 
> > 
> > Thanks
> > 
> > >   	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
> > >   				       sizeof(*dma_ranges));
> > >   	if (IS_ERR(dma_ranges))
> > > -- 
> > > 2.47.3
> > > 
> 
