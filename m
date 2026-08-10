Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82A1514F8;
	Mon, 10 Aug 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375951; cv=none; b=sxHmUzqczMUVUbqXdgIMXz9p3xPZcgZ1vnND8xfwsCjbDEFBaTrOGV+hhuzNkk2YrtF6u+vkF/SKEoyj72xoMGFZCWEI4awU93sb5aF0U54oC3olCCuRix5ogXNwKe5GVaa3cmuh1hZg2ebA5g2HN2wuOzKLDyjIFkOwQeIIHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375951; c=relaxed/simple;
	bh=N6+gKXJPXmhT3daZTrJy1XzSeaZlw3VbDa9MR8ypz8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okFZJzy+lI8esaqbAjYc6VVYkczsGwVxtZgPbAZxuqRHWrcYPRwxvUCvkk1qI7diWxjZDaHXDEQz9QLEfgQ2t3mIw1/CemBVqDdZXTkOpEInyQvA2FgWe7V3wcCFETMSJSA3v5NU4IPh7NaY2YCnHdEyBSMmhBm7LjUsT62bQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=iOmDnOPW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EI/Yv8bb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="iOmDnOPW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EI/Yv8bb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D39D27A0197;
	Mon, 10 Aug 2026 11:32:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 10 Aug 2026 11:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786375946;
	 x=1786462346; bh=ID+w4jyAMLOceNx6xVC1CsDjtjWiiAdbunVAg+DGrR8=; b=
	iOmDnOPWbLc2RJoBRvOFgDEvRW7G8Yj0rloywWitW5Mg35CXHiRvRbj2CGl9ct+2
	tqcKWCxUnkXOg0bA1hYw5r7VVY+JA0xMoKBUyOjMwQVrt5vMniFWKLSiNejntTvt
	G40DkXtFJRh7/9ycdcLrVJZ4Wh4YyV4/k3OvtNRAExg8U8ROZjl5OWVQLjNNs1G5
	W54f0ZjewZCJnZtJLNsUO2GTqLK8fybEM/2sszUbY3TZgYDDfyoUiZVmzQQOjxOl
	/zkylTs3mhazIE7VC7uZaLknZxHDKbvFKx5GxYgh7y8aMDIEOGudLjr+3Rgc2OvU
	FL9BdYIaoifr0CzkqI3PAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786375946; x=
	1786462346; bh=ID+w4jyAMLOceNx6xVC1CsDjtjWiiAdbunVAg+DGrR8=; b=E
	I/Yv8bbGzdYSlx457iKlRIdGiSFNKRrINBK08gIh0x2Tw44+XMg0CJgYYjnnr1Rb
	1c/m5IjWdZAHEunr/VUu+0ZCs5+Li6q7mcMp978gwiqNhR2D6VZE6mXimmCvEvyn
	VN7+1y1fiM9L2MfTIMg40gqMVMHx5rV8wOqoIrTmim4Tb13CWR0dxk+96ZP2JS2X
	/0a57BUmkUK4w1xY9iWRYj45RkaiK1OZtwBLuxl2K83+IhCZBSlMNSRT3mbDgAnu
	0WEh6dV9yb6HuvZL+vZjt6tmT7JfdfXGPwPuPbbpx3mXjSrnO+qahVuYGEV8LNVU
	/Ldklt169r2tSzi7Wk3Fg==
X-ME-Sender: <xms:Cu95atKtdhberxUVXGm8l3IMQMjFFH0VNnwgsjrtvVhAAcStUzhdTg>
    <xme:Cu95auFj15eoe6AiCL_7Xh1fLePbQ7u4kHSy6WriiRPFm3JARe_A9B8VF2h0koL4i
    yNCFU-7QABdV3PWiM2uood0PmWILCUKQTtmKwtveiODso3B-vwl>
X-ME-Received: <xmr:Cu95ap_cXd1E1-K0XpyEca27fj0od3HthoZUTTWnEbpgx-TKdQoPus6wpHWDag>
X-ME-Proxy-Cause: dmFkZTFaoRm3BrLSjHI2x7YUS7OdIgak/XncRdR/aqYztwN7oNZEBk4ood28n5POfrP3Xd
    sb09aIwAqBSj80a4B4vfQ8ffvFryIEJtliIleIfWOVvgur9//58Zn6tCIgeaFseaVVAIlR
    q5UGdI1Pr922DZpqfujKJ5v3Uy9EbdAhyuXVbU/iAIFQgueCyU/+nTUmpanyIv1QgAUuMh
    6fbfvcK/iapRxJPvwG+CXLwoLTtEhI1wcLGsOpkAv+7Mb9czbnyCv3nUEGz0rqJi6DdnxR
    A2qTDP++6y1oFosKKM+MqCtDymseie+Xnir+RBpx1JENztfb4YBE3YWIGon5sQvUpr4Qsc
    M8skD17o4fQHCq3TlAuToW4HpLkM2TMtjBtNAbHGlZ+2ao4wPAziB2oQoGkLYCFtUP0PUi
    JBnqYVgjrHvuuJ2FBTEgcYnzLQ0XejeN1EyBNVvMuRehQpxD8GZ7zAaAvL03hbTdIoIqkM
    O6M4zyRPApZW03WtDw4Crmxf7GrK1WAcNkbA7OMn9hw+XF10pcEzSce7sM6WHiRZLlcr2F
    xsVxv3WjEHEAD6zG58p+uUvEMm2r12mmA6i0FIlEvUm43mNu4QC1av0kiEBitMPxp5SGCx
    7XTzedulfPTIjQzS5RlnE9ll1mmlxx4b+XjvQ3cGfJkCp6k+68SSn6X2mpjg
X-ME-Proxy: <xmx:Cu95auJ_Y-vJsBxwf96r9ZrL1-f1ks_dhchujyC3k3mqYBCC_ez8ig>
    <xmx:Cu95ant7oUfINdItw33ZgODyROVKb4u7qcwFSxTSHY_IEvj7vNlvfg>
    <xmx:Cu95alD84YvCVgrXqBxwN9Th2lpOnsXAif_zl-C7-UjSPgwvp0PsCQ>
    <xmx:Cu95avOGTgUbc2H4mKO2A_RVmYYXhB4o6kpKs0IXbZQalQBmR2E5gg>
    <xmx:Cu95amDLw1znDMFiJlYSAUwwhQS6zYnwp1ES9JeVV_luMf6oeH6_t5p9>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 11:32:25 -0400 (EDT)
Date: Mon, 10 Aug 2026 09:32:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, bhelgaas@google.com, Kevin Tian
 <kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>,
 dmatlack@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <20260810093223.50dbc8d0@shazbot.org>
In-Reply-To: <20260806194739.GH28508@ziepe.ca>
References: <20260805003355.728299-1-skhawaja@google.com>
	<20260805003355.728299-2-skhawaja@google.com>
	<20260805090323.01b1a36f@shazbot.org>
	<20260806194739.GH28508@ziepe.ca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 16:47:39 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Aug 05, 2026 at 09:03:23AM -0600, Alex Williamson wrote:
> > On Wed,  5 Aug 2026 00:33:55 +0000
> > Samiullah Khawaja <skhawaja@google.com> wrote:
> >   
> > > When userspace closes a VFIO device file descriptor, the vfio driver
> > > performs a hardware reset on the PCIe device to ensure it is returned to
> > > a clean state. However, if the closed device is an SR-IOV Physical
> > > Function (PF), it may have instantiated Virtual Functions (VFs) that are
> > > actively bound to host kernel drivers (or other vfio instances).  
> > 
> > Wait, what?  We actively try to prevent VFs from a vfio-pci owned PF
> > from being bound to host drivers other than vfio-pci.  You need to
> > overwrite the imposed driver_override to make this happen and you're in
> > a very precarious security model to have the VF owned by a trusted
> > in-kernel driver while the PF is owned by userspace.  
> 
> Maybe, it really depends on the device. I can easially see someone
> using a device where this would be safe. mlx5 for instance is pretty
> OK.
> 
> So I don't really mind someone doing this, we should block it and warn
> it and so on, but like noiommu and the other vfio insecure modes, why
> not give an opt in?

An opt-in to what currently?  We generate a warning, but nothing
actually prevents the re-bind to an in-kernel driver.  Whether that's
sustainable in eliminating this reset gap is yet to be seen.

Binding a VF from a userspace owned PF flips our model on its head in
two important ways.  First is the security inversion.  An in-kernel PF
driver is considered trusted, we absolve ourselves of issues related to
whether the PF has access to VF data or interrupts VF operations and
state through reset.  Second, the vf_token model explicitly defines the
trust and coordination boundaries for the userspace SR-IOV ecosystem.
An in-kernel bound VF lives entirely outside of that boundary.  For
example, one mechanism we might use to prevent an MCE around PF reset
would be to zap VF mappings and invalidate dmabufs.  Reinstatement of
those mappings would require userspace coordination, which the vf_token
model would define as an implementation detail in userspace relative to
vf_token coordination and trust.

So we haven't done anything that explicitly blocks or taints this mode,
yet, but correctly handling reset could be a tipping point.

> > It's possible there are gaps that closing the PF can interrupt the VFs
> > and we need to defer a reset until the VFs are closed,   
> 
> Oh definately, when running in a SRIOV mode it is really problematic
> for the PF to reset while there are any active VFs. The PF controls a
> number of shared items (MMIO, ATS, etc) and when it blips everyone is
> at risk of unexpected fairly catastrophic system crashing errors
> related to the shared items going away.
> 
> So resetting the PF device unconditionally when vfio closes is
> definately wrong in principal. I can see it maybe working for simple
> systems, especially ones that don't MCE..
> 
> I don't think we can skip the PF reset on close because of dev_set
> reasons and leave a rouge device for the next user, so the thing looks
> somewhat troubled?

This is what our vf_token model would handle, if we could use it.
Re-open with VFs in use through vfio-pci requires the vf_token
proof/opt-in.  Re-open with no VFs in use could reset the PF, but we
can't account for VFs bound to in-kernel drivers.
 
> Adding the sriov disable here at least makes it defensibly safe, that
> we do still clear the PF on close, and we don't take risks that the
> active VFs will crash the system during the FLR blip.
> 
> Though I understand it was not the original intention, I feel we have
> ended up in a strange place with the SRIOV PF feature ..

I think we have 3 potential options for PF reset:

 a) All resets are blocked or deferred while SR-IOV is active.

 b) VF mappings are zapped/invalidated at PF reset and require
    coordination to be reinstated.

 c) VFs are torn down on all PF resets.

Option (a) is complex and doesn't look like stable material.  A deferred
reset on .close needs to materialize on .remove or .sriov_configure
(and of course .open), but to allow in-kernel VF drivers we can't rely
on vfio usage counts, or even our vf-token trust boundaries, which is
what leads to the .sriov_configure hook since we need to take advantage
of every opportunity to issue a deferred reset when SR-IOV is not
active when we can only rely on the PF state.

Option (b) is potentially more simple, it implements the blocking of
access on reset in the kernel for enforcement, but defers the
coordination of reinstantiating mappings to userspace, which is really
how the vf_token model is intended to work.  This is incompatible with
in-kernel VF drivers, which I think means tainting on VF unbind from
vfio-pci and those working outside the model would tread carefully.

Option (c) is the more heavy handed approach, it means that a PF driver
cannot fail or exit and re-attach.  We have existing logic that handles
a PF driver re-opening the PF device with active VFs and authenticating
the vf_token (logic also broken by in-kernel VF drivers that bypass the
vf_token mechanics).  There also appears to be significant locking
challenges in this approach, ex. the inversion of getting the device
lock for SR-IOV teardown from the ioctl, config space, and .close
contexts.

I'm open to suggestions, PF resets with live VFs is very much a gap
that I'd like to close in the vfio-pci SR-IOV model.  Thanks,

Alex
