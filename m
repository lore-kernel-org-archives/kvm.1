Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93EC328B62
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779057; cv=none; b=N8tTd0u8VwAiJn1c78UHodn5XPplrdyR7E4K2Q0jROFWrtDzwPWgDw8TxCs3Krqv51mq7EbJVNjst9Q6V/HBm39vQpy0tCP8PbofOq3IoWzsqIN2jrKsVtHh8iisMk+P59Lf+B5GLgXurj4iYrp5a3KiFBTmaWhM1g+tLIcRXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779057; c=relaxed/simple;
	bh=oRhC9ap/DPR+LRmOACS5BSfZvO0w8NpryTqtekTnKcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moYqVfTB569Yx0SQHRweIpMKi4UQNUHp7leFDqki9SSZ3dO/r9HytzCvCcD54t+DNydFF7g4JkIs4SeLDOsrSp3aEDwOXtFLp4w9Bl8KfyBTGp1kvQq21nz3L41y6sQTeZu0u221ZuCARfB3wAR0Ddh2NdpbFjcfcztTUUvRGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=URyjX9Cb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TdIuaa6r; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="URyjX9Cb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TdIuaa6r"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04C871400126;
	Thu, 14 May 2026 13:17:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 14 May 2026 13:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778779054;
	 x=1778865454; bh=PO56KD/Hrd384ZARZTR9tTuUmx9BraACvzCmjYWDAoE=; b=
	URyjX9CbOXF3dH5H1BMyNctpglO9ILQ9pJT7wV8CCffrCa+y+lS040Kj+K2bkFdi
	k7va9Uo8Lq/duhQKjwdgZt7IEonKk0+K1+E+8gEmXYQ2KrCXmPE0Z1F6BR3qYew3
	YOmvl9nD2BfnreITpzn/2VPAlZeK60V0f+adYUUDN74pXue4ei4K8FMmIb1zr9sw
	qf/RM9FUEcYntvJAfWSu3DwzY+GoOXRzBCNJmKgfxrOALma//mEeLEQ7E2vrsaJq
	v0gzRes55MLihObG7S0u7mS/r6ccuu1xfXBlBYBpheybMfcOJaolIKoHMS32Zav+
	x1WRWcdoPC1ufpNqzI/9Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778779054; x=
	1778865454; bh=PO56KD/Hrd384ZARZTR9tTuUmx9BraACvzCmjYWDAoE=; b=T
	dIuaa6rCGV+BgQ86sfPqUvs37OZv3VLY/xkpwTlpMUh0l0sCxJCuKguUxczxnXsu
	bsHxFitwdrqyQpk93OnMrZC8cQtIwMd6IhL1TpeqePVXte+uUhKj0WqHRoyaBG08
	8dWjbPD1OG6stu6DRTsy3B78rNlR8BOAnPIFoZYOKf5fErGR2Fud4HmzSlDq/A9+
	O+hdKW5dsBNnoHpCgbJBGdLXSnLWZwSQFrfuwTc+7DTVp2b3aXrGhimnRtTzKd3L
	vJLYeXCvx+r7VzV0+XWukZz1xCT0OWcLUDYvI5WWwQ7Yg6nawUcp5SAnX3wxj0+6
	n6T19N8nFhxZ5C3x5IlBQ==
X-ME-Sender: <xms:rQMGakIOhm3NtYkf3Z2ZrYKNYdjToKoenvEZzI5nEzumm-5TAPuQNQ>
    <xme:rQMGalqIXPkjpHuJvFPrjNv5nOhZL3p1RWJ9lhyZzjl3xf1RakDQFowQ4hbBqWO1U
    GXE2K-byvNhemp5XyuM3ycPPX-ftJGcM1zR-RovBOQcV5vSrAOpC58>
X-ME-Received: <xmr:rQMGakyn9EKOJGWSp9u-edG42j0OTNuCD2wrNeUMVXQbRKtvR0DBa6jiYkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeettdehhefguedtkedthfehvddtgeejffevvdeuvdeileffkeefffevhefh
    tdejteenucffohhmrghinhepghhithhhuhgsrdgtohhmpddtuddrohhrghdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthht
    ohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtthhopehovgdqkhgsuhhilhguqd
    grlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:rQMGahPdhXYp4YgXE-ADBUnEojpOWqq48zHXO6HJXAnkLSlG77nJug>
    <xmx:rQMGah57W1kJDKX3yB-lvtSle41j5QwZchLsenb1gHXfcxu2BwX3hQ>
    <xmx:rQMGaimhqbcUyrJzzVblpcnDiUDYyvj2d1BSXwdIfs-rUWuIJLUieQ>
    <xmx:rQMGaiTPkwKpng16eXFAs77jMXVkHGU9KMNfPeqwV0yHLCkvS3QkWQ>
    <xmx:rgMGamWzF-9R7po88eAlzGoQ15DD15LwVlyf6b5inCClY0DCWOEQzZQ1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 13:17:32 -0400 (EDT)
Date: Thu, 14 May 2026 11:17:31 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [awilliam-vfio:for-linus 3/4]
 drivers/vfio/pci/vfio_pci_core.c:499:35: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <20260514111731.5ef8faa4@shazbot.org>
In-Reply-To: <202605150023.lXFibOM0-lkp@intel.com>
References: <202605150023.lXFibOM0-lkp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 00:39:50 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://github.com/awilliam/linux-vfio.git for-linus
> head:   a8a3ce989a94db08f77968a4e75b34eaa6d40c9a
> commit: a975fd177726e110f30b561dd0707b78f21ffe66 [3/4] vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
> config: parisc-randconfig-r134-20260514 (https://download.01.org/0day-ci/archive/20260515/202605150023.lXFibOM0-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 8.5.0
> sparse: v0.6.5-rc1
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150023.lXFibOM0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605150023.lXFibOM0-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/vfio/pci/vfio_pci_core.c:274:33: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:274:41: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:278:25: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:278:43: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:278:56: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:278:65: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:283:25: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:283:44: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:283:57: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:283:66: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:291:39: sparse: sparse: restricted pci_power_t degrades to integer
>    drivers/vfio/pci/vfio_pci_core.c:291:58: sparse: sparse: restricted pci_power_t degrades to integer
> >> drivers/vfio/pci/vfio_pci_core.c:499:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@  
>    drivers/vfio/pci/vfio_pci_core.c:499:35: sparse:     expected void [noderef] __iomem *
>    drivers/vfio/pci/vfio_pci_core.c:499:35: sparse:     got void *
>    drivers/vfio/pci/vfio_pci_core.c:506:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>    drivers/vfio/pci/vfio_pci_core.c:506:43: sparse:     expected void [noderef] __iomem *
>    drivers/vfio/pci/vfio_pci_core.c:506:43: sparse:     got void *
>    drivers/vfio/pci/vfio_pci_core.c:514:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>    drivers/vfio/pci/vfio_pci_core.c:514:43: sparse:     expected void [noderef] __iomem *
>    drivers/vfio/pci/vfio_pci_core.c:514:43: sparse:     got void *
>    drivers/vfio/pci/vfio_pci_core.c:1736:9: sparse: sparse: cast from restricted vm_fault_t
> 
> vim +499 drivers/vfio/pci/vfio_pci_core.c
> 
>    484	
>    485	/*
>    486	 * Eager-request BAR resources, and iomap them.  Soft failures are
>    487	 * allowed, and consumers must check the barmap before use in order to
>    488	 * give compatible user-visible behaviour with the previous on-demand
>    489	 * allocation method.
>    490	 */
>    491	static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>    492	{
>    493		struct pci_dev *pdev = vdev->pdev;
>    494		int i;
>    495	
>    496		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>    497			int bar = i + PCI_STD_RESOURCES;
>    498	
>  > 499			vdev->barmap[bar] = ERR_PTR(-ENODEV);  

I think we just need to convert these three ERR_PTR()s to
IOMEM_ERR_PTR().  Agree?  I can fix it in the branch.  Thanks,

Alex

>    500	
>    501			if (!pci_resource_len(pdev, i))
>    502				continue;
>    503	
>    504			if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
>    505				pci_dbg(pdev, "Failed to reserve region %d\n", bar);
>    506				vdev->barmap[bar] = ERR_PTR(-EBUSY);
>    507				continue;
>    508			}
>    509	
>    510			vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
>    511			if (!vdev->barmap[bar]) {
>    512				pci_dbg(pdev, "Failed to iomap region %d\n", bar);
>    513				pci_release_selected_regions(pdev, 1 << bar);
>    514				vdev->barmap[bar] = ERR_PTR(-ENOMEM);
>    515			}
>    516		}
>    517	}
>    518	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

