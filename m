Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1C3CB91E
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383097; cv=none; b=XpnMs0XY34/ns8eJcJeytHzjlPXD5g6F8bgPL43JO8bTkVTj4J/0YRORJHPjv8NkqACvzFPbXvMiQHyNyZDaXnA9twM4WL0P46QhPjSPTp4LPMIrMd7vdgHRffWjtzSOuQYEDldhAMt2NCA4+JBIdg3KKlbc+GwylFB2sMjewoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383097; c=relaxed/simple;
	bh=Fp9FwB+mawhVq1TTdlwmgb6IroyHr/KVD/XE0PdV1N8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SicB8/HItnwN/XNegMBRh8fFAjes6zWXGV/Bl5b1QfRHzGpFz5WBN2sgFODevZ9+/YHrP+Y0uBQbg9boYfj4+F19VCt++JBtV5/72qexfSO4AgZ3HXZF4hQpuxLK76mAAPsWEBADeJl43+aXvsE1wcsmKcVwqUupcUyrO7AKbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rvSC0kaz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDA0jxnw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rvSC0kaz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDA0jxnw"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8042E1D000C8;
	Thu, 21 May 2026 13:04:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 21 May 2026 13:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779383091;
	 x=1779469491; bh=6OtnIFGwl3CB9NCZB/sWiqdi/XZ79bAlkkTY8RrrXJ0=; b=
	rvSC0kazkO0o9tPuc3D+E6vh/39O+a2D908FmN+2K2GOa6YDX3rUMHBIza8HTWpg
	D12JjwIgX8SRdgX173YoVEqNbZZtA8oOAOs85fEVYkUc21X28oTx5WLClWKHAGMg
	G2HjhDIKOlk6a5KKkbMxc2MuqC1zBk/NudbPjqQJ9h6illzyUGAR3/v8zT4tA/2q
	S3lYegBxnGT0hlbD6HkMg1ORLVsA+l6VdIXCLf9PbHNnpml+dMRBtEGNlYogvD0P
	OWRnznntbToO4K965COSsf+bv1FhmgANd1CtjhxPg+2OxOU48CclFZXLgrs/RXE+
	8yrf4e0ow+FpfqGcoXgd2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779383091; x=
	1779469491; bh=6OtnIFGwl3CB9NCZB/sWiqdi/XZ79bAlkkTY8RrrXJ0=; b=Q
	DA0jxnwZBskOLS+Yis8I0cY52xuo0WFTZ99lvlsQf8/Aij8+NuYaphajmVJOG4HQ
	c/oQ4dBH1meEB3wqA+2STyRqSYCWMrr3NQt4u3UUIcpwkMwDG+W398XTDyfVSK7m
	z61Aw7YQ4Xf32aSF7Q1axv8xpXCL9EWQk+OVMauKh217qTdY4qVpaoR0kQ38rg6N
	o/X5W8zw+Em/hyFDJnP/jGwUQAeNS5bR0uEkX1mgD9qHTBiGaHjh7APVw/23veN7
	rnJldsDRIr5Mmnr8yLBnNxyo+evN7il7egLwj1fUZ0wpyl6pBRJrOrDeU9g/SbI5
	72W/52pGER/2ysoXfzSTQ==
X-ME-Sender: <xms:MjsPat0youRIJiTCTn_5KOj_cV7mcmKLtK39wcjZ-CQSP51QIm7j9g>
    <xme:MjsPallgHyLYfZXepgocwVoWo1fCf6ptuf5JqM1IT9c1u9n8YsKHt71i0tzr9_Ti2
    2Fcs1fC5CnhnsaYCfECGArWt6IvKIbnBXr6lBjdafNgBP_fTqpe>
X-ME-Received: <xmr:MjsPat-4De1WL8c0fvGjpw12mGeY7oiyYS9jISl142Q47KSTVIYkziN0K64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeektdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeffudetuddtudekhfevjedvkeeufefgtdffgffhieefvddutdeulefggfel
    fefgleenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhurhhluggvfhgvnhhsvgdrtg
    homhdptddurdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthht
    vghvsehmvghtrgdrtghomhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtoheprg
    hlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:MjsPaqpqgBb_3AxBJH_NqoZjeFk2XXyj7pktKHUUic0-Xp90zXLdZg>
    <xmx:MjsPamlucwt7wIy9hyRwEROi-Hjfw1jy3q4RMjoGG2TZbesPhg_7nA>
    <xmx:MjsPahialWMoO0V2X9oHkkVigzMK1McN5B-xFwQ-xFGPYSB2zdoLtw>
    <xmx:MjsPaueGB_aIQfXfN-Eg_o_ya-EXk5izI-VKLrOFSjvptCwULN38rQ>
    <xmx:MzsPalD3FIRfEiUtJzGd7mb5gCl6BkVPR7Qt-awW3oSjpMqmzxkdhMg->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 13:04:50 -0400 (EDT)
Date: Thu, 21 May 2026 11:04:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org, kernel test robot
 <lkp@intel.com>, alex@shazbot.org
Subject: Re: [awilliam-vfio:next 11/13]
 include/linux/vfio_pci_core.h:247:31: sparse: sparse: incorrect type in
 return expression (different address spaces)
Message-ID: <20260521110448.4df82912@shazbot.org>
In-Reply-To: <ef311ad6-3563-4251-85d0-0f8f03aa55a9@meta.com>
References: <202605211601.U1OvmuqY-lkp@intel.com>
	<ef311ad6-3563-4251-85d0-0f8f03aa55a9@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 17:59:03 +0100
Matt Evans <mattev@meta.com> wrote:

> Hi Alex,
> 
> On 21/05/2026 09:07, kernel test robot wrote:
> > 
> > tree:   https://github.com/awilliam/linux-vfio.git  next
> > head:   b9285405c5f6144f4444f97bf3048d865e11cc1d
> > commit: 859dc0f6253b0d65fd4d79e29aa29b3d939c51a9 [11/13] vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()
> > config: alpha-randconfig-r132-20260521 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20260521/202605211601.U1OvmuqY-lkp@intel.com/config__;!!Bt8RZUm9aw!-MeA4YCZqVD1LgfRaoW0lgRz_bEdlvVRk8RWaDsMsFVUXAfMxQ3YFOteZOcWJ88tWRlbPA$ )
> > compiler: alpha-linux-gcc (GCC) 8.5.0
> > sparse: v0.6.5-rc1
> > reproduce (this is a W=1 build): (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20260521/202605211601.U1OvmuqY-lkp@intel.com/reproduce__;!!Bt8RZUm9aw!-MeA4YCZqVD1LgfRaoW0lgRz_bEdlvVRk8RWaDsMsFVUXAfMxQ3YFOteZOcWJ8-nGduJOw$ )
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202605211601.U1OvmuqY-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> >     drivers/vfio/pci/vfio_pci_core.c:274:33: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:274:41: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:278:25: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:278:43: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:278:56: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:278:65: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:283:25: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:283:44: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:283:57: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:283:66: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:291:39: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:291:58: sparse: sparse: restricted pci_power_t degrades to integer
> >     drivers/vfio/pci/vfio_pci_core.c:1736:9: sparse: sparse: cast from restricted vm_fault_t
> >     drivers/vfio/pci/vfio_pci_core.c: note: in included file (through drivers/vfio/pci/vfio_pci_priv.h):  
> >>> include/linux/vfio_pci_core.h:247:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@  
> >     include/linux/vfio_pci_core.h:247:31: sparse:     expected void [noderef] __iomem *
> >     include/linux/vfio_pci_core.h:247:31: sparse:     got void *
> >     include/linux/vfio_pci_core.h:250:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
> >     include/linux/vfio_pci_core.h:250:31: sparse:     expected void [noderef] __iomem *
> >     include/linux/vfio_pci_core.h:250:31: sparse:     got void *
> > 
> > vim +247 include/linux/vfio_pci_core.h
> > 
> >     235	
> >     236	/*
> >     237	 * Returns a BAR's iomap base or an ERR_PTR() if, for example, the
> >     238	 * BAR isn't valid, its resource wasn't acquired, or its iomap
> >     239	 * failed.  This shall only be used after vfio_pci_core_enable()
> >     240	 * has set up the BAR maps and before vfio_pci_core_disable()
> >     241	 * tears them down.
> >     242	 */
> >     243	static inline void __iomem __must_check *
> >     244	vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
> >     245	{
> >     246		if (WARN_ON_ONCE(bar >= PCI_STD_NUM_BARS))  
> >   > 247			return ERR_PTR(-EINVAL);  
> >     248	
> >     249		if (WARN_ON_ONCE(!vdev->barmap[bar]))
> >     250			return ERR_PTR(-ENODEV);  
> 
> :(  Yep, these need to be IOMEM_ERR_PTR() also.  What's easiest for you 
> given this is in your `next`?  Should I repost a new version of the 
> whole series (even though the 1/3, 2/3 went in via the 7.1 RC?), or a 
> one-off repost of this patch, or..?  Sorry for the silly Q, IDK what's 
> best practice here.

No worries, I should have caught it too.  Just send a follow-up patch
against vfio next or linux-next.  Thanks,

Alex
