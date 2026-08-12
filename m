Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A768468C36;
	Wed, 12 Aug 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555190; cv=none; b=cnGzXgL0+xlEK3d0FyzBf8Xjqfrll1YHNEbj4n/HRMcoZsEeuXDp92EZv0WSe99lccqDvdLRSPfvajF794rsh9BieVtyIi+TqmnADFlN9vCUaVbTDz8/t7jUnNqe9VfP5qO4WuEpcnw3lCBnYzZePIPtT97lAnT3hV6yN2y74KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555190; c=relaxed/simple;
	bh=vV+iFHhOcKMR2wsm2kBUMaHXfqyYOqZX0tyoDOk+Zas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLk/L9z7P4I05k4QsYA47yPdUf3x1rBUGn4G2TFYBpfJGJ4ufQ5GgpO2HoiXkqX5x/r/OLkw4yldUICXVhuzQT4TreifC81C7iYjpodS9/l1CRwloIFhb4AlVgaJISdTQFNR/GZZnMrMnBXvfdLih2IdhMC+wNgldzq6o+UUMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kfe2hQ3N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NLFwZLHu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kfe2hQ3N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NLFwZLHu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 674371400036;
	Wed, 12 Aug 2026 13:19:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 13:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786555186;
	 x=1786641586; bh=DqEzTheIjqZHkO4lsXKH6Je4BNnU++YXXpF3d1lJCG8=; b=
	kfe2hQ3NcDb15kVlCUjLmBRzbjtak12BcCKuZcE/5BX+Xdwjse4NwjdX1VoZN3jr
	ug/ZZpUgVT+fY33QbBjhwQkc40xuTWYnyyqvUsPJo36yHGXligFSF5feYhDAPD5+
	u19Dvhzhut5BRKWo+BBX12ScYvkxsXRkBOoO9S3iJkUgP7Ev++bPfFNeQDQPA/mJ
	XhT53E54kXeuSgOnDzXwwcNjrG+tn+LmiWYbFJbjHHxyNM7FR9zL/qgibxIjvVR8
	LwWMZalNGsgC6GC9otQS7ePLCGKRD4OnuxbZV8TbX+ER3uMefoLsP/Xp2/UJVlu2
	Xe4xHQTGsWWn2r2LIuw0+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786555186; x=
	1786641586; bh=DqEzTheIjqZHkO4lsXKH6Je4BNnU++YXXpF3d1lJCG8=; b=N
	LFwZLHuKOTmGtN8e1lM3skirIR0NASeVKorUKnyxgmQaGK3oe/CT1JIOeyeMRr5F
	C/YWQ4alYjt9CDVmlOnz0V08P8IVB6ASKoWfOfC4/6GgYHTI0DthjuhndLQlbPWQ
	u7Odos9LxklcEAjvzxly0+cGAwy/DI5ZM91GkENsQ5uIWWaMivO4Yc1IlYIvqBZB
	NyIZGsELPZIxYxiNOJAziQkoFWjCscCTlsnZrsFPj1l/LeWUbQ6etmYja51CGWZE
	nJwsW3i23AVfkkLSLmQO4S+aPQRU3MpioBQNLz51coq/FldEoKZt1FEBk+L6+aOl
	lWUzPTcfMnSFOAJc0hLsw==
X-ME-Sender: <xms:Mqt8ag9vfymItHstl9PjPJj0oZNnWzKxj3vU05ZqMX9NOgL8q07FBQ>
    <xme:Mqt8atp4appUs34Q6lIz4B9EIAGKTwoqU2hYH5v4ECtrabOfNz-OqnIOrr12gavua
    4AyucG3T9kyGXoDtxl1IC3doO8F9_Eq92gvSEYuAewQ5yYKUXfG6w>
X-ME-Received: <xmr:Mqt8aqSAYV6A3tF1Vp-wOcuzooNRq0HCG6zEsNkK3_o7EuQ5Xbkj53FoT1jfIQ>
X-ME-Proxy-Cause: dmFkZTGlk2U3cmazbXTMqtnLUfzkoZ2LhSWd2iDnp/nXlbGjdRGd6yXyG6goPPvCjd9mE3
    EjLhRvwL4+HZb/CzVlLkOIEeBwVEbWQ2OddsFBmtoBIm685INsO2fso8tFH7BH1KE95F18
    otYRa9+DZPgbDpRGwpc9HCe7oDyV7Z98TlRaLaH8gonG2fTphKgI4OpxxQrejc9YNOkguw
    vUznQsnVOLQnRRamiI7ZqswXKXEBm365l8uwZOaYeW4uNQQo85S/MO66ikZfPf8X9is0j5
    /cxuwTliKQLKOa55p3J6rjqe4x6Gl+sBfmLrKapXbGN/pCj9QvVTjWfqvnkRjV4Mm39cO/
    534LxsIp+15DUX+ur3SdI/J+rl4GLUOr7UqPCn7EcizGn5yH4h1ogtBUAw1V7cKwiD1ICf
    ZgREqPdHJoFAiST1doSYQWMY6kSTh6S8KYWlkuY7JN53q4JRDL6xhVyryibnZURao/bsc5
    C4cskpvpB2DgtY7JEN8wg5zWF8y2S00LhKkqL27PAi65kU0dEkasjyFLVVnKpHoXc+qefL
    JKfyjREU0gw96+/ihGa9MYjjF0EE7gyl5vqIjKkac1VR3Fb6zNhMfPQ4fx2e9kO3rh+z7J
    NOjhjadCmFupecxMWF9wFtihfTVXKflX3h6JyD6R+TPTD2w3Yy0Ovwowp1/g
X-ME-Proxy: <xmx:Mqt8agPU6Km8gGSo4NYvhqcQBcVBWbVZf1cV6gin__FfWAuHWnZJbw>
    <xmx:Mqt8aojzZ1yXxCYSefWSaJYeOSZO_L8X1YX8IzOa2AiUwpAaVj_SGA>
    <xmx:Mqt8atnHOqZ_41mWYcTnqHsUx7dvsnuBogFnlSsF5zApVzmVn3Cd-Q>
    <xmx:Mqt8akhGRnRibv4gjVe8Gg5ovZ-a3O3OJmd5PLO06XyER-7UfvdfWA>
    <xmx:Mqt8alG0YTgynmURv0AmK2mvScAMMZgRjVXQBUkjw1XFWzTMm92f0tEj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:19:45 -0400 (EDT)
Date: Wed, 12 Aug 2026 11:19:43 -0600
From: Alex Williamson <alex@shazbot.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, bhelgaas@google.com, Kevin Tian
 <kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>,
 dmatlack@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <20260812111943.31cf9cea@shazbot.org>
In-Reply-To: <anpJrnR6Lbmgqad-@google.com>
References: <20260805003355.728299-1-skhawaja@google.com>
	<20260805003355.728299-2-skhawaja@google.com>
	<20260805090323.01b1a36f@shazbot.org>
	<20260806194739.GH28508@ziepe.ca>
	<20260810093223.50dbc8d0@shazbot.org>
	<anpJrnR6Lbmgqad-@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 20:31:49 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> On Mon, Aug 10, 2026 at 09:32:23AM -0600, Alex Williamson wrote:
> >On Thu, 6 Aug 2026 16:47:39 -0300
> >Jason Gunthorpe <jgg@ziepe.ca> wrote:  
> >> On Wed, Aug 05, 2026 at 09:03:23AM -0600, Alex Williamson wrote:  
> >> > It's possible there are gaps that closing the PF can interrupt the VFs
> >> > and we need to defer a reset until the VFs are closed,  
> >>
> >> Oh definately, when running in a SRIOV mode it is really problematic
> >> for the PF to reset while there are any active VFs. The PF controls a
> >> number of shared items (MMIO, ATS, etc) and when it blips everyone is
> >> at risk of unexpected fairly catastrophic system crashing errors
> >> related to the shared items going away.
> >>
> >> So resetting the PF device unconditionally when vfio closes is
> >> definately wrong in principal. I can see it maybe working for simple
> >> systems, especially ones that don't MCE..
> >>
> >> I don't think we can skip the PF reset on close because of dev_set
> >> reasons and leave a rouge device for the next user, so the thing looks
> >> somewhat troubled?  
> >
> >This is what our vf_token model would handle, if we could use it.
> >Re-open with VFs in use through vfio-pci requires the vf_token
> >proof/opt-in.  Re-open with no VFs in use could reset the PF, but we
> >can't account for VFs bound to in-kernel drivers.  
> 
> I think even with this a PF reset blip can be catastrophic for the VFs
> in some usecases or devices. Maybe we need an opt-in where the PF driver
> can specify that keeping the SRIOV enabled during PF reset is
> catastrophic for it and so the reopen is not preferred by it?

AFAICT, there's really no case where a VF can be operating
independently from the PF that a PF reset is not catastrophic.  Per the
PCI spec, the default SR-IOV capability state is disabled, so
post-reset the PF is effectively bringing up fresh, scrubbed VFs.

> >> Adding the sriov disable here at least makes it defensibly safe, that
> >> we do still clear the PF on close, and we don't take risks that the
> >> active VFs will crash the system during the FLR blip.
> >>
> >> Though I understand it was not the original intention, I feel we have
> >> ended up in a strange place with the SRIOV PF feature ..  
> >
> >I think we have 3 potential options for PF reset:
> >
> > a) All resets are blocked or deferred while SR-IOV is active.
> >
> > b) VF mappings are zapped/invalidated at PF reset and require
> >    coordination to be reinstated.
> >
> > c) VFs are torn down on all PF resets.
> >
> >Option (a) is complex and doesn't look like stable material.  A deferred
> >reset on .close needs to materialize on .remove or .sriov_configure
> >(and of course .open), but to allow in-kernel VF drivers we can't rely
> >on vfio usage counts, or even our vf-token trust boundaries, which is
> >what leads to the .sriov_configure hook since we need to take advantage
> >of every opportunity to issue a deferred reset when SR-IOV is not
> >active when we can only rely on the PF state.  
> 
> In my cover letter I pointed out that this problem probably exists in
> the in-kernel drivers (or PCI core) level also. For example an SRIOV PF
> driverA can reset the PF while VFs are bound to driverB. This makes me
> wonder whether we should fix this at PCI core level to maintain the same
> policy for all drivers when it comes to PF/VF lifecycle?  Basically,
> 
> option1) On PF reset when there is SRIOV enabled, PCI core returns
> -EBUSY from the reset API.
> 
> option2) On PF reset, PCI core disables SRIOV. This might be tricky as
> some drivers might block this waiting for VF driver tear down and
> remove.
> 
> We probably cannot do this as default policy as it will break the
> vfio-pci model where the PF can be reopened as you mentioned above. I
> think if we go down this route, we would need some way of establishing
> trust and lifecycle rules?

The PCI-core level change is the same conclusion I came to and posted
in the RFC[1].  I think our only practical option is (1), function
scoped resets must be rejected on PFs with SR-IOV enabled.  This is
compatible with the re-open scenario, but leans on the fact that resets
are best effort.

The vf_token continues to form the boundary of trust for VFs operating
within the vfio framework.  The adversarial device support Kevin
referenced could influence the security posture of the driver taking on
an untrusted device like this, but I don't currently see much
opportunity to introduce coordination between vfio and non-vfio drivers.

[1]https://lore.kernel.org/all/20260812045325.2733631-1-alex.williamson@nvidia.com/

> >Option (b) is potentially more simple, it implements the blocking of
> >access on reset in the kernel for enforcement, but defers the
> >coordination of reinstantiating mappings to userspace, which is really
> >how the vf_token model is intended to work.  This is incompatible with
> >in-kernel VF drivers, which I think means tainting on VF unbind from
> >vfio-pci and those working outside the model would tread carefully.  
> 
> While this might solve the issue for scenarios where the MMIO of these
> VFs is mapped or exported (dmabufs), this might not be enough as the
> software still remains out of sync as compared to the state of the
> device.

This is the same problem as the .reset_prepare/.reset_done hooks,
invalidating the dma-buf only prevents the machine check, it doesn't
necessarily allow for ongoing operation.  This gets back to the point
that all PF resets are catastrophic for the VF driver.

> >Option (c) is the more heavy handed approach, it means that a PF driver
> >cannot fail or exit and re-attach.  We have existing logic that handles
> >a PF driver re-opening the PF device with active VFs and authenticating
> >the vf_token (logic also broken by in-kernel VF drivers that bypass the
> >vf_token mechanics).  There also appears to be significant locking
> >challenges in this approach, ex. the inversion of getting the device
> >lock for SR-IOV teardown from the ioctl, config space, and .close
> >contexts.  
> 
> I think this can be a reasonable opt-in option that the PF drivers can
> use to indicate that on PF reset keeping the VFs alive is catastrophic
> for it and it does not want to reconnect to the VFs. If we want to go
> for this one, I can maybe try figure out a way to break the locking
> issues.

My exploration of this space suggests the locking issues run pretty
deep with this approach.

> Or we could certainly do this in a deferred way that is somewhat similar
> to the option (a). Basically PF openers can opt-in to not reset the PF
> on close if the VFs are enabled, and teardown the VFs on subsequent
> .open or .remove. This at least gives the system administrator (or
> scripts) opportunity to teardown the VFs in a proper way.

But VFs can be enabled before the PF is opened.  If we're strictly
within the vfio-pci model of using VFs, VFs cannot be opened until the
vf_token is known, which requires a PF driver to set the token.
However, binding VFs to in-kernel drivers entirely removes them from
that ordering and coordination.  The disposition of the VFs is changed
without PF driver involvement.

I don't see how we really have an opportunity to create an opt-in
beyond a module level global opt-in, but even then it's not clear
what the opt-in can realistically choose.  Thanks,

Alex
