Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C603128AB;
	Wed, 12 Aug 2026 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550411; cv=none; b=g+49iUXXVeHtZUFjdkfYdH98p1moYn+TiZWf0RHvRxxVEbxxGLbZFiT+gmW3zYfj2sx5RE3JeDNWJ397iqZp+kJwDdf9YfgtPAX22DA3RD2TZ6l9gerdzDnBl4Prs7Ty+S1NOw9JZN3xz+yPAzUoIqKk1RpyClcrd91P+ZaUgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550411; c=relaxed/simple;
	bh=ivO8JgoHooWAgnN/QKQlbLJawm0RyeqI+R+yHrKJaGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THz7EQK0hqW3EqTlOJdpBSOxg8POzshDnsEt9t/2nIwAsjc2ZnheuUSSSgO+RQRDzoayxQqh++qO6SjSSMG94p5OE2pcy5lHO1UzKZbbR0wk2G2J1cbdOyMP0nIe6kC99NbIbHVUeADo3DrA96EM5zHz5Fw9wjZd3GR9JEsus+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NLJkmsNH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxWIbJwt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NLJkmsNH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxWIbJwt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E387EC0247;
	Wed, 12 Aug 2026 12:00:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 12 Aug 2026 12:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786550407;
	 x=1786636807; bh=FvDyWH9NYxW6w+E8w9CVN6nT5ieu4qqykikKUH6CVts=; b=
	NLJkmsNHBkOAdl/gOJM15vxGnmsBtLNEJuv4W6wRCLTNNAMGjnsdipP8OKMnGLDS
	XNNmExEJwCSEusjrXOkymWmQoEuSo+oU/tbk1Tn3/YpktOM6Gn07sksHHvzOKw3r
	aT1KunRwi2kXPpmm/moOV+fyI9k598t5QoyDhPKsEAUy1z+rLeAQlX0XPKNgDlfq
	qCiJQb8ooSXY7HZrucRdL0iw/zwuO6H3aV1IXib8bA5FRudDaYcuOKZ35G0F8dc2
	nGS3qVWUBRQnvNLVwdDP7Xd0KZuHM4q2azgQRdPdvR14BLEGcoUo6/V1Xe7weCIB
	mOMaUTq3RHDKFI+KOGhbLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786550407; x=
	1786636807; bh=FvDyWH9NYxW6w+E8w9CVN6nT5ieu4qqykikKUH6CVts=; b=T
	xWIbJwt/9aIvKHGVWHhRrWyR8Su9fins8sSnVQFySm0H+B+rq/8SuJBWqcJHHuFS
	dvMrmLjN1zxBMjmGnVpP9q7wg837UhzinJqUxohjFJEX06Zz9ZI8o2jTQbb2bDcN
	z2df0S6QVfRTe+goO2ou6DMrLAQC4uFnpuc5XkSJLEqrTYB5zGVOZB9HNpjyyVs3
	BrW9EvoL3qeVHvP7mhKp53LbFto5YEXBJsDGRO50ub0/2lPT+5xqpagJf9VwXnAH
	DdlGWtZ5d2t7Amc8Dhlb5AMMQIY/8NDKM7e13MiI08sdnCsEPBQZr/7posbPk758
	LuJFpJ8nwqFB00Y/6WLJA==
X-ME-Sender: <xms:hph8arA6nE5UdeVGne7uQtEwfT-vqzXxfLynro3Nb3KryiWzwucPGg>
    <xme:hph8amfSC533uuP1g17F4MGRkhzLvnQIZiGjILdHeDSTL4MXKlLz9TALoMsibGzc3
    aNDQG_BtXbKeJIlx_Ms45gBFW7X2U_hBzACdYLr5aPLkbGKT1PsXo0>
X-ME-Received: <xmr:hph8aq1PhUcHFH1L0unl7FA-nEXQTvEAcwdbKGDbiFfoqP9tl7kQszdSGBxn5g>
X-ME-Proxy-Cause: dmFkZTETO7FEfGZ1zn66HWUtEoeJP0PzsDeGvLzJslmFv3X8DrRm4YGM8IYn89/onlTw1p
    VfvkYU/U0FRnkNk38qxpaHv6kKPg4nWqGfvz7hcsM3xzoABC+O6yXECJl8X8TmxZ7kt5Fe
    OKFbBu8CHW5hVmoki7dESLwaMzlR0FSsvBkWQtocIsHvsNO7fqJ0dAU1UYw9HOi1lxYAD/
    h2P+3YYL0Fg62ToppIVFKFt+KMVu4f4mGL6wzZuEsIQ5jsQj3TF183dzqbYi6TgFopDUjX
    /IqII75p1eV4nLw0Q+faY52zpKKKkgi/ODsaBOKf5ZBGhW8Gs67ds7M585NBo+XAfMUPKi
    EZbRlB6kGNesiuupzqT0KugvkCBA72jLgkVU3fVbEyZybvvx9GcT8T9wnyYt1U+bCCubIe
    Ljr5I0nfEGeZGZdxgYcnA5Ao2ucYhSDXbmJodwuN8fD4RGH4/azY8k6+75Vb0vwcV/LvVu
    s8PHq6nsGkP2iiaQ5ErTgLVEiiJGFfwK6eN7G+e/oShKZiNbbw/NfzLDfvv0tgr/eXAggA
    8X41PDWbpFdYM1ZyeBI/P0L1rmsW64gDuIxEYf+/hKvmbr4CFuSixPUaQKFRDeMnlNM6Fs
    /8tTi7zPSZWd209DCzzvo4HkG6JCfvX7L+FqQiZaWbfY0LPhJnteKY16uljw
X-ME-Proxy: <xmx:hph8atgQdsTY6R1UuZAeL4uvN-VtGwciROr1I5O8hQrKpspxcjnVBg>
    <xmx:hph8ajk4jlnk9v2elgcS3aJMuNHinBOQMpMBbtAmV933j__PNQLF1w>
    <xmx:hph8ajYNaaKQ2QZagrGQeoJNmXiyc-YUGMcM9uCYOx8qVC3HBjrPrg>
    <xmx:hph8auFcB_47s6BTJPYPGSwQ27oJcdnemaB4kl_YZZJRGR_jAy_D5Q>
    <xmx:h5h8ajZgZLcnvppvHTLEuU_2ekNDNRnVCRLliJ_0zIbh3qUU4JgvHuRS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:00:05 -0400 (EDT)
Date: Wed, 12 Aug 2026 10:00:03 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Samiullah Khawaja <skhawaja@google.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leon Romanovsky
 <leon@kernel.org>, "dmatlack@google.com" <dmatlack@google.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <20260812100003.7e276faa@shazbot.org>
In-Reply-To: <CO1PR11MB48350170CB4BDC89DB1FF96F8CDD2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260805003355.728299-1-skhawaja@google.com>
	<20260805003355.728299-2-skhawaja@google.com>
	<20260805090323.01b1a36f@shazbot.org>
	<20260806194739.GH28508@ziepe.ca>
	<20260810093223.50dbc8d0@shazbot.org>
	<CO1PR11MB48350170CB4BDC89DB1FF96F8CDD2@CO1PR11MB4835.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 09:52:37 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex@shazbot.org>
> > Sent: Monday, August 10, 2026 11:32 PM
> > 
> > On Thu, 6 Aug 2026 16:47:39 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >   
> > > Adding the sriov disable here at least makes it defensibly safe, that
> > > we do still clear the PF on close, and we don't take risks that the
> > > active VFs will crash the system during the FLR blip.
> > >
> > > Though I understand it was not the original intention, I feel we have
> > > ended up in a strange place with the SRIOV PF feature ..  
> > 
> > I think we have 3 potential options for PF reset:  
> 
> Is there any coordination between in-kernel PF driver and in-kernel VF
> drivers regarding to reset? At a glance looks that requesting FLR on PF
> via sysfs would silently affect active VFs anyway...

Yes, and this is a key aspect that the RFC I sent last night tackles.
pci_reset_function(), and it's exposure through pci-sysfs, is intended
to have function level scope.  We could walk the VFs, save and restore
their PCI state, and trigger their reset callbacks, but this is a
destructive operation relative to the VFs and their drivers.  A better
fit of our scope model would be if we simply declare that while a PF has
active VFs, the PF does not have a function scoped reset.

This immediately, and cleanly, makes the open/close, config space, and
ioctl resets in vfio-pci inaccessible for PFs in this state.  We can
then further push the vfio-pci hot-reset interface to require SR-IOV is
first disabled on any affected PF devices, as the VFs are not currently
accounted for in the set of affected devices.


> >  a) All resets are blocked or deferred while SR-IOV is active.
> > 
> >  b) VF mappings are zapped/invalidated at PF reset and require
> >     coordination to be reinstated.
> > 
> >  c) VFs are torn down on all PF resets.
> > 
> > Option (a) is complex and doesn't look like stable material.  A deferred
> > reset on .close needs to materialize on .remove or .sriov_configure
> > (and of course .open), but to allow in-kernel VF drivers we can't rely
> > on vfio usage counts, or even our vf-token trust boundaries, which is
> > what leads to the .sriov_configure hook since we need to take advantage
> > of every opportunity to issue a deferred reset when SR-IOV is not
> > active when we can only rely on the PF state.
> > 
> > Option (b) is potentially more simple, it implements the blocking of
> > access on reset in the kernel for enforcement, but defers the
> > coordination of reinstantiating mappings to userspace, which is really
> > how the vf_token model is intended to work.  This is incompatible with
> > in-kernel VF drivers, which I think means tainting on VF unbind from
> > vfio-pci and those working outside the model would tread carefully.
> > 
> > Option (c) is the more heavy handed approach, it means that a PF driver
> > cannot fail or exit and re-attach.  We have existing logic that handles
> > a PF driver re-opening the PF device with active VFs and authenticating
> > the vf_token (logic also broken by in-kernel VF drivers that bypass the
> > vf_token mechanics).  There also appears to be significant locking
> > challenges in this approach, ex. the inversion of getting the device
> > lock for SR-IOV teardown from the ioctl, config space, and .close
> > contexts.
> > 
> > I'm open to suggestions, PF resets with live VFs is very much a gap
> > that I'd like to close in the vfio-pci SR-IOV model.  Thanks,
> >   
> 
> Before closing the open on reset, does it make sense to first fit it into
> the coming trust infrastructure [1]? e.g. initially set to TRUST_NONE
> for any VF with a PF owned by vfio-pci, preventing any bind to
> in-kernel VF drivers. Then opt-in is allowed to promote the trust of
> such VFs to TRUST_ADVERSARY, allowing driver binding but also put
> it in precaution with IOMMU protection. So a malicious userspace
> PF driver cannot indirectly affect VFs to do dma-based attack.
> 
> somehow VFs in this scenario feel akin to Thunderbolt devices...
> 
> [1] https://lore.kernel.org/linux-coco/20260705220819.2472765-10-djbw@kernel.org/

That certainly puts a more cohesive driver-core story around binding VFs
from a userspace owned PF to in-kernel drivers.

We currently have our own hand-rolled version for the PF/VF use case.
Each bound PF registers a bus notifier that monitors actions for VFs
whose physfn is the vfio-pci bound PF.  On BUS_NOTIFY_ADD_DEVICE we
write the VF driver_override to the PF driver name, preventing any other
in-kernel driver from binding the VF without a userspace override.  We
also then monitor BUS_NOTIFY_BOUND_DRIVER and generate a pci_warn() if
a VF is bound to any other driver.

So semantically, it still requires an administrative opt-in, but once
opt'd in, the receiving in-kernel driver has no idea the device is
driven by userspace.

Maybe the trust level of the device becomes more evident with an
adversarial tag, but coordination between drivers relative to things
like reset still seems like an orthogonal topic.  Thanks,

Alex
