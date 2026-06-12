Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B46375F82
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293428; cv=none; b=uaOa7Z2S/00z92Je1KH7PEUhn8gaGLfa7y8U/6ksZmlWkJX1e+Hs35szskrLea+WLc1NqGxpWlJIztOttVNtmab1TFQxvfO3f1eI190zTZpvs/9YGcjmQp4zd+6SVDMjdIH0xn61dBtUoseTWci2MBFruSJCPXHlvOub9LT61CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293428; c=relaxed/simple;
	bh=ctVsIEK619yB+e8eeMBvrKbCjaLRX//402crCsbTUkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE7y+KgkCemw03yVF+lsbejuCsY8YlbqDsZ0CJ5+xBkUpLeiK8Wb78022Iy2wkEQ/0Dra569lICKBJDOVcJGpwemliJx9rdQ9XIablzLWSBjeGCIF5wHYhvVL98uU1005+9zUt0nX3zTMvRBf1WAhhx7p3Rn0LuITRQpd4Fpm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsGUDtTO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsGUDtTO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b1a48855so18345ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781293426; x=1781898226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmA9t8+wOUfRjPLThtQlARMdWkr4H2MHT+OyHJTFhU8=;
        b=fsGUDtTO45P+NRjG+CcHjCXH494gMK5P3HDul++b9R6g0lMudtbV2WoMrIuAjuDfdi
         6/3JDanfyCpyNkslzcpF8oJJLmFQ8ohKczDn2aPVvQE7ZOqq7KwcpXaaAAsNNyd9iSGs
         5eX7ynw4GWPbHuSnPO/pkL1ZYGm3izhx6gVNK/hMWDed7/etAFnXcqnS4RhD6xhU6YHH
         +OL9LcgPJSAD+Zedfaq38HAsVcWXIQgLsz1GDSqQr26sjNS40hWxLZos18lcZaLfG2Nx
         fM0dluFpJSFUm74FUomaojJu0mZ+G5X0QLWhHQi6mrcgCDCWdG5P3NqqA/BZ26WTVuxi
         UQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293426; x=1781898226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmA9t8+wOUfRjPLThtQlARMdWkr4H2MHT+OyHJTFhU8=;
        b=snGtgz7SmTdclmr4ZqQvEFg/qyLxyHJusCF3eNCEcihCYSjA7K5UD04Fczja0RfxlA
         TRuxI6Zm8d009ljzB3qBVeiqBNHGfqq7CSalgTbbJd2h3t9LT4Kj746hdmTAP75fz3yv
         E1RL/pplezSkztLOysqb4D80X6NIZ+yp2MusFBmNEjkfNsPenH12beX1L4TMCpvtWWOG
         4OsRbBIHFZW+5P54c7HgcbTvTbXU/ZSyf6XcA4TNshnqLlmqkUu5h2lqgkENMgjQz7E4
         kccZmWbpD+UkdnGgCPMafNgC77cwMkxnCAjCAIvBMhWlcr9L0rip8TcGF75MHYAovmZc
         MEHA==
X-Forwarded-Encrypted: i=1; AFNElJ+qiDQ0VcCCWPUFd7eJtJw1l8tbckNAVhBX0ayqCoRbIbXYRfgdN1VdmRV4+mLZ3W8hQ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMk/IhMDweCQLwuRL4o3zoeVCJMTdaYII6GHocbU1XccGf820Z
	hSTibOj4j5czmrT7xd0EVD1Q8Ai4pEZcvjyZkuqTO5wvVMjGbgercF9TTnEBTOECLA==
X-Gm-Gg: Acq92OEmuSALC9uFObAJouZmtejTSLOTbtlDiduRS1093gpRDJlYE0wXj+0IJT8H3WR
	81lElco1Lq57QoSh+hA1UF2rzr+mrW99iwOpkM/xVS8TSVhSzOQaecfQJA9ZOjvahxzjnixLD6l
	nPC6GMFWO4/FSweDxr4olc6zsfWG0rVkM7Mg/y3Hg1h09GqBEb/JDZlUmyywYN0xvLn7qJoVr3G
	NB5Tl7TS9w1LdlrterNDqZ6QaEe2zy9GeVu0XnPrvAoCOC+UHeTwq+dgUlUeC228y4lJL+3ZQ9I
	8CEc6PYYt9cFYOhDDIEGAUYADy8zMzy/EReDl67srpNsA/gLwbIigaOOaUlCwv+m77Uitm3E5hf
	/0hTSD8CTrO4m3Je/G7IUjse2N4S0TPjZsENS9OU/qnpKh85KfuMc6vpVIIeIv1gFeZCRiu6+eS
	H6KlSM//ByO4gwOEF9dU9Rr8Dzr2EU1AxT/9COw5P6SkypNH93x4TJE/N4ijoE
X-Received: by 2002:a17:903:37c8:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2c6650d52a7mr471235ad.18.1781293425288;
        Fri, 12 Jun 2026 12:43:45 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651aef27sm2802598a12.30.2026.06.12.12.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:43:44 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:43:36 +0000
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
Subject: Re: [PATCH v3 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <aixhaJoPQrNjhLwD@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-5-matt@ozlabs.org>
 <aiviYEi17tewEQg0@google.com>
 <42cf4ad9-f094-4f94-88e6-6d2cb6eb6437@ozlabs.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42cf4ad9-f094-4f94-88e6-6d2cb6eb6437@ozlabs.org>

On Fri, Jun 12, 2026 at 04:22:12PM +0100, Matt Evans wrote:
> Hi Pranjal,
> 
> On 12/06/2026 11:41, Pranjal Shrivastava wrote:
> > On Wed, Jun 10, 2026 at 04:43:18PM +0100, Matt Evans wrote:
> >> Convert the VFIO device fd fops->mmap to create a DMABUF representing
> >> the BAR mapping, and make the VMA fault handler look up PFNs from the
> >> corresponding DMABUF.  This supports future code mmap()ing BAR
> >> DMABUFs, and iommufd work to support Type1 P2P.
> >>
> >> First, vfio_pci_core_mmap() uses the new
> >> vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
> >> representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
> >> callback is updated to understand revoked buffers, and uses the new
> >> vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
> >> fault address.
> >>
> >> Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
> >> zaps PTEs (used on the revocation and cleanup paths).
> >>
> >> CONFIG_VFIO_PCI_CORE now unconditionally depends on
> >> CONFIG_DMA_SHARED_BUFFER and CONFIG_PCI_P2PDMA_CORE.  The
> >> CONFIG_VFIO_PCI_DMABUF feature conditionally includes support for
> >> VFIO_DEVICE_FEATURE_DMA_BUF, depending on the availability of
> >> CONFIG_PCI_P2PDMA.
> >>
> >> Signed-off-by: Matt Evans <matt@ozlabs.org>
> >> ---
> >>  drivers/vfio/pci/Kconfig           |  5 +-
> >>  drivers/vfio/pci/Makefile          |  3 +-
> >>  drivers/vfio/pci/vfio_pci_core.c   | 75 +++++++++++++++++++-----------
> >>  drivers/vfio/pci/vfio_pci_dmabuf.c | 12 +++++
> >>  drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
> >>  5 files changed, 67 insertions(+), 39 deletions(-)

Hi Matt,

[...]  
> >>  int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> >>  				   struct vm_area_struct *vma,
> >> @@ -532,6 +538,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >>  	struct vfio_pci_dma_buf *tmp;
> >>  
> >>  	lockdep_assert_held_write(&vdev->memory_lock);
> >> +	/*
> >> +	 * Holding memory_lock ensures a racing VMA fault observes
> >> +	 * priv->revoked properly.
> >> +	 */
> > 
> > Nit: This comment should appear before the lockdep_assert_held_write()
> > Also, it is slightly verbose.. (not against it though).
> 
> Right, I'll move it.  Agree it's wordy but if anyone changes that I want
> them to "think faulthandler".
> 

That's fair I guess.

> >>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
> >>  		if (!get_file_active(&priv->dmabuf->file))
> >> @@ -549,6 +559,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >>  			if (revoked) {
> >>  				kref_put(&priv->kref, vfio_pci_dma_buf_done);
> >>  				wait_for_completion(&priv->comp);
> >> +				unmap_mapping_range(priv->dmabuf->file->f_mapping,
> >> +						    0, priv->size, 1);
> > 
> > Have we run this series with lockdep enabled?
> > I guess it'd be nice to check with lockdep once..
> 
> I've (generally) always run testing of this series with lockdep.  (No
> issues (anymore).)

That sounds good! Thanks for confirming! :)

Praan
