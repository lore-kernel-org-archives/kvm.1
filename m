Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CC3793B8
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216091; cv=none; b=LiPlhi090U47euT++8fw+9YJsLj/z9NxyEmcrqhUBfqNRdfWnBGO+myJ697sTTE4cbbbQkvcPO5dTVElMJ1301D46+phBnKCgnS48NBuKtIrPyFMZbOnS9kIzxQ8wdElvUv4lJpWPUW/jwrET8mT4zV+HgIG0DKe++7OWMldnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216091; c=relaxed/simple;
	bh=driLtFFPc2/aFa5tQeIQT0kqHjSvzncIJmA5n8m8Ti8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujYFzKo4kgyJYYRyB1QdLVbh85e5K48HLtXwhjT0ldWDiCrL3rRptrX4WBcLtv1tFmWWATRma2d3fDdgPqN30Wxwc14t/37IDrZeO5qk81CkOUs5mBZVrlTH6FO/UwZeMJGppZ/5ilUsyZKTSc0zoyOwPlRR2+cYVFkIzDabbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hk6EukkN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hk6EukkN"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5174a3a025aso3137661cf.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781216089; x=1781820889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TU5lI+UtOlVYfDvzN8n1Q1p4EuEL8icx+G3TWgzZwc=;
        b=Hk6EukkN3JgY5a2y/WCgOZ5Ku02LMoqvT+bOkn8NbqlM6cSDWQcxUfBiTm/CBediGe
         koRdsbmPyWxuBFHdpGyHrLF1imrx41vycYoesSI9qpdWKsyZddRVSzxFMEJhHhX0MYgq
         RnEWYFDA7CjfI9E6JvQmlwaKD+Wo9EiNUsZAjfgjaUcudUtB7czxcbyb7Zv0GHLDoCzi
         G1OjPNieqq0gJA7dWkVXNvYGBKn3THrN9GRe7RL0FW17qUIwwzmEaq7qX10sypeVxnOz
         HfxhuczJdW4eKzmy0ZVaz2+RBLNXOQvEsWKkPCEsGvyk9oG4MwqVuJaTvOO7XKrCLxlI
         xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781216089; x=1781820889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TU5lI+UtOlVYfDvzN8n1Q1p4EuEL8icx+G3TWgzZwc=;
        b=E3nmlVEONtzVpaes3QzusMIPP5QSknbg0HwpV4NT/KlgMhKOySeNmXz+wOxt1weZXn
         xElqNy6m+nlLF86ZC9bPu+fvs7gbm7TdG1Fvpr0tjJrM9viERmIGbyNcX9w8n4QvgJmn
         kDVY2W1jRqQyWF7f+0yj1wWUPoKfbrfSgGFXD2cPtat4Wzcy6MGp5t42cwLWskrgnZTW
         UPOeWhNrHZ0UXU0EippHZoipZgNkQCRszS4Ia8ghkUUznXRqlV/WI/BYcp8PkOU6rneM
         ZtHaLF2NOJnRqMW3dTLTzIPO/PwB378JxFN0Cv3OZPIGM5Y/xo56Rv3Cwie7oqpImQ4j
         gxCw==
X-Forwarded-Encrypted: i=1; AFNElJ+cJu7zWPh/CVWYmnBNFoJKvMmVsQWXou93aGscfc+SEyxpzWRu2E30HTULDv72dg1eWCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygy4lbws4e9E3jik1K0VP/ebFla+ESLgOSk2HDQSFsGAg0rhxC
	i5+Y355NNPSMILjV6FUOJViv/ZXzgusa1mXloRKrVOUzZAZiGZuTfR1elRknHALs4Uw=
X-Gm-Gg: Acq92OH2blb6wI6Dt64ivfqt82P1KC0kfYiLldJphCPQJzZ5N6WK48ZlwP47UaIf21L
	GhVz+rIwRgYX7Lz6CNl3G/7/7mh2FpaThxTA/V/wXxMCrmskLl6WSGas3Mgzj6gZbGfx3+3s8/Z
	0l4W86043KeCWneiKkTqLJ075UBSltpUkJLzNe7pfQllBjy9kO6B84KHkPy1jojvJ8b1HoOf0Qi
	pNXACofA7aJtSkcZoGsEqCWGv/Ub+r5+3mtH+D2hdtYiCqBZOWVrXi7tsH/YHe8D2X2DhAQS909
	I49WVjS2UgZNAFGqpLfQrsx0XwCOvL5QJF8LXOuSedC2J2MCX7FnfNq3cGwVODAM6jA4qGIzATz
	hjaSmRrk/pIbtYfiTX2M/378IPzM1/akxj0IgIdfKfNHsUMd9sp8NroePGY2O+ybOuEF6z5jEFp
	FEwbPOTMLppDq2TbQ53ZzVDRo7gBl3xStB2zGZAtgcyo+N1F/yOKxxzvV7QBcXiVyhnrmYvpe3X
	/djiw==
X-Received: by 2002:a05:622a:90d:b0:517:d869:427b with SMTP id d75a77b69052e-517fe4ecf87mr871481cf.29.1781216089450;
        Thu, 11 Jun 2026 15:14:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a00desm5011991cf.19.2026.06.11.15.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 15:14:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXnfj-00000006bNK-2S4X;
	Thu, 11 Jun 2026 19:14:47 -0300
Date: Thu, 11 Jun 2026 19:14:47 -0300
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
Message-ID: <20260611221447.GH1066031@ziepe.ca>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
 <airI0VIb563jHTcy@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airI0VIb563jHTcy@google.com>

On Thu, Jun 11, 2026 at 02:40:17PM +0000, Pranjal Shrivastava wrote:
> On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
> > 
> > > Users utilize the standard sysfs p2pmem/allocate interface for managing
> > > memory slices once a BAR is registered.
> > 
> > I'm shocked someone wants to use API, what are you expecting to do
> > with it??
> 
> Our primary use-case is PCIe BAR (DDR / HBM) -> NFS via P2PDMA while the
> PCIe device is managed by a user-space driver based on vfio-pci. While
> kernel drivers (e.g.drm) can register BARs with ZONE_DEVICE natively to
> enable this, VFIO currently lacks an equivalent mechanism.

I mean the weird sysfs mmap API. It is only useful if the device is
basically pure memory with no functionality. You can't even learn what
MMIO offset the returned allocation gives so it is almost completely
useless.

nvme could use it because CMB is pure memory and you reference it by
its MMIO address, but that doesn't apply to VFIO..

> > > An alternative implementation has been explored which integrates with the
> > > ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
> > > registering a BAR as a system-wide P2P provider, VFIO optionally
> > > allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
> > > new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.
> > 
> > That's probably more sensible but you can't have a DMABUF mmap
> > actually install non-special memory. The native vfio mmap still can,
> > but not mmap on the dmabuf fd. That's still workable, just keep in
> > mind.
> 
> Ack. I guess, we could have a separate mmap path in case of BARs that are
> struct page backed which doesn't go through the dmabuf exporter.

The dmabuf export is perfectly fine, you just have to think very
carefully about the mmap path.

I suppose if you build the proper revocation fence for zone device
pages as part of the vfio implementation it would be OK for dmabuf
mmap to expose them as well since it would have the right lifecycle
model.

That's the tricky thing with zone_device, you have to be careful to
wait for all the page references to be put back at all the right
times.

Come to think of it, since the sysfs API cannot do that in the way
VFIO wants I actually think you can't use it..

Jason
