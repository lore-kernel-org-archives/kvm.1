Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54F3B6373
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164430; cv=none; b=mG9MVFOUCG9NxO7siZf0ij1QYFjZwi9DEJO/HqPgT6SROcI2rsv596mWdR4FjvytwSXcryNiVrTSRnEEmTcEozhDPILn+2CW+PKQAhIwWoZHElmGpWwtwW4fQA7JV6TyINvLz2zteeoz34WFPTcejexW6TWOzfmmdh2CVWLE+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164430; c=relaxed/simple;
	bh=w5fJXXFViFHwjzq9BUB3D362FLSO0k38Y9JnnTZC0h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rpb85452RGo34vc2bfX5ePXCraoQQQWTV4+kJjV4LJA9QCAET0Y5OoLWqKzb9/5BMsREfHrRIm0GfLWr1E5/Pk3XkjPMtPkGwKAj3UUT8ZDlR8ijfO9Xn/3fS/FgkxmPvWL/nOPAzp8I72BEaRKKtqOncaqYIDgBuib3HYUdWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=V3pk2QrO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VF3BAeK+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="V3pk2QrO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VF3BAeK+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C55821400230;
	Tue, 10 Mar 2026 13:40:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 13:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773164426;
	 x=1773250826; bh=vq/3Y8KvWXc09nwaRNWQnTA/9qZ0RrDKTkWFtHxLvLI=; b=
	V3pk2QrOSqxFXUj/64cU8s6bp2yCidvHgICOQRPXUsEiGtHwXJ/gWCyykico8qSh
	dUN3tQHkZOgqmoc+RgejTKBJYuv+V4EEE3GUyVm6wT1BkZ7FGes8WaTl5s2hYXNw
	FmGE1AOm/xKoDVyx4T9b9YGyCQ38hxRo35jO2wBG/VtCy1RuMOnbQEKprpiqyXKB
	KCE3qGPPehudbRsM6YyQjduHeC7mm/l7dyKgubeynW/GcQhOI/WbgnPNyDE508H8
	jjDnuvEY2ndn0i9H6RAVF3sUCvO7oqp6nQC5nSQX4znmvEGtD71hQxer7z4x0yus
	0hYdkBrKtrQ3sYdKuc3wgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773164426; x=
	1773250826; bh=vq/3Y8KvWXc09nwaRNWQnTA/9qZ0RrDKTkWFtHxLvLI=; b=V
	F3BAeK+6/ONUHtdD3hDLze1Cidic8VKuWilv9wzRish1wNw/1iuMOSsie9RRbmZl
	mov2MKqH9T3+swWAZIyoAMiRkpTWeFgQQ1y787q130Ml11c1hi9pdsnYWhmu2nbI
	dg+Em3CeoNDpY/TEjWPkbCI2ewstJBG6XF5312EiCfngs4pfAGcvkP65FsqEPhhu
	GHchXlbtiQ5h4HQtuuUWXuT70mjpnl6hAx1h1l4PGdlUHmaQoivW0kqASH0PyQAa
	FW2Zx9moCEqwr+XsCFIkgHWypZStgSB+KOsfa/c6OeCweMi7gcrRw1d1QqXj2kTQ
	Xfvmeqpl+H9agXu7dUAdg==
X-ME-Sender: <xms:ilewaabhKu8hsbSmGpB4KOFk_XO5HuM_6gxdDbgAs5CUoBQtz3We0Q>
    <xme:ilewaf8XuYd1PqdLTzSPxLPms1K_tVLb3WR64wReoIDWgmu_6lPn7vap_swWQ-XtP
    q4LxK7WAP1GJHSyEjmFCkVLPaiHySOb3X-jSaoEoeXOmlmyyulsmA>
X-ME-Received: <xmr:ilewaYkmkN1ulID9Kk_vaoZ_BxL2JaiZ2RdsDFJR-PKKMwG8PVp6TMmyk-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    hovhgrnhhnihdrtggrsghiugguuhesihhnthgvlhdrtghomhdprhgtphhtthhopehsuhhm
    rghnrdhkuhhmrghrrdgthhgrkhhrrggsohhrthihsehinhhtvghlrdgtohhmpdhrtghpth
    htohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohephihishhhrghihhesnhhvihgu
    ihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtg
    homhdprhgtphhtthhopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphht
    thhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhgrthdqlh
    hinhhugiesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdr
    ohhrgh
X-ME-Proxy: <xmx:ilewacwz2DrJI2cUCmsDAaOlJDuDBGix6ziQC1ozO6Q5i3C4lzVqfg>
    <xmx:ilewaa6FJ3ZDSqJEEhGxam2PNnxbAPmuEGjRbxgJonZVq6mFf3GnOA>
    <xmx:ilewaUX19wJ8ZG-pfliJpHsDzg-7G_d0ksXNYJz6jrhRXRIR39kD0Q>
    <xmx:ilewaaJoksQ_kcg4_JW-3gxuOTNhQBOtmJCl68Mmz_suHOMxbmsOaA>
    <xmx:ilewaYfQs-icpnDr3X2gsaHnMnIHdZLaDmjItrCU-bzou8WLMoNSTtti>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 13:40:25 -0400 (EDT)
Date: Tue, 10 Mar 2026 11:40:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
 <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <kvm@vger.kernel.org>, <qat-linux@intel.com>,
 alex@shazbot.org
Subject: Re: [PATCH] vfio/qat: extend Kconfig dependencies for 420xx and
 6xxx devices
Message-ID: <20260310114023.0492c743@shazbot.org>
In-Reply-To: <abBUfvkca4XU02FH@gcabiddu-mobl.ger.corp.intel.com>
References: <20260213091403.72338-1-suman.kumar.chakraborty@intel.com>
	<20260309170247.2bd96b78@shazbot.org>
	<abBUfvkca4XU02FH@gcabiddu-mobl.ger.corp.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 17:27:26 +0000
Giovanni Cabiddu <giovanni.cabiddu@intel.com> wrote:

> On Mon, Mar 09, 2026 at 05:02:47PM -0600, Alex Williamson wrote:
> > On Fri, 13 Feb 2026 09:14:03 +0000
> > Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com> wrote:
> >   
> > > From: Vijay Sundar Selvamani <vijay.sundar.selvamani@intel.com>
> > > 
> > > Currently, the QAT VFIO PCI driver can only be configured when the 4xxx
> > > QAT driver (CRYPTO_DEV_QAT_4XXX) is enabled. This is too restrictive as
> > > the VFIO driver also supports VFs from the 420xx and 6xxx device
> > > families, which share a compatible migration interface.
> > > 
> > > Extends the Kconfig dependencies to allow configuration when any of the
> > > supported QAT device families (4xxx, 420xx, or 6xxx) are enabled.  
> > 
> > 420xx seems to be device ID 0x4947:
> > 
> > drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> > #define PCI_DEVICE_ID_INTEL_QAT_420XXIOV 0x4947
> > 
> > We don't currently have that in the ID table for the vfio qat driver:
> > 
> > static const struct pci_device_id qat_vf_vfio_pci_table[] = {
> >         /* Intel QAT GEN4 4xxx VF device */
> >         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4941) },
> >         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4943) },
> >         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4945) },
> >         /* Intel QAT GEN6 6xxx VF device */
> >         { PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4949) },
> >         {}
> > };
> > 
> > Are we missing support for this device and is this Kconfig change
> > therefore a little overeager?  
> The PF-side live migration support for the 420xx VF (0x4947) was added
> in [1], however the qat_vf_vfio_pci_table in the qat_vfio_pci driver wasn't
> updated to include that device. I'm going to send a patch to add that.
> 
> Do you prefer both changes (Kconfig and table) on the same patch?
> 
> [1] https://lore.kernel.org/all/20251120163023.29288-1-giovanni.cabiddu@intel.com/

A separate patch is fine.  Thanks,

Alex
