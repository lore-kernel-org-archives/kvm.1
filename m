Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6026266576;
	Tue, 30 Jun 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856229; cv=none; b=kdvg9VCtps5i2PH1bOgB+WRYQNU+AX91C1xz8WkDdc9TcrYyQy4LdVXts5L2uXGRL2u0HHr0Xm2/DMbVoIMXZVxhDf7PqmcVzeQBg07ol7/MCFJxevMR2s6j3CBR/ZAHP8KzHj++GRyw3PkIliE7EyjLnQoPMVtyPTXdUdsqLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856229; c=relaxed/simple;
	bh=BhdtcsOh1lYT90bHtO7li9mFb6os8tAJZTfI3aV4eUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6mvXbZzAgxphlhm6lKJw5l8hBX5e/t0CgNz3xA3bYw+SsePo9/J0STjv4KJiewFnsEswjCpjTBxwhXf67JZUHODwcIpMS81q10+p/lDCgFwbxhmDnvi8W9Wx+OxtcmV1UrFIVEiE4z+Wa0H/BHIRocoVRXP75oxOOLZ+fOOj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=DuLE3Llc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ry7ea02b; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="DuLE3Llc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ry7ea02b"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C03BB7A0133;
	Tue, 30 Jun 2026 17:50:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 17:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782856225;
	 x=1782942625; bh=FtW04vCW3OqAUmDv/lvhOw4gBZ2rhR+DzNAJYuMHVCM=; b=
	DuLE3Llcvu+U5PelESVKc0RwCn3jPX/Rk/MFY/29olija77xAQcLhOxvdfOVJAL0
	ze2lgBPN8r3uRQLWfnhvU/9S0NwEUk45Hqghp+1JhVvs6i3an9EVS5jp67b4voaJ
	DrsZXocOAkfAMAGx2ODAZyzP/+0RexRCniVXY+T3HSnze3Hgvp7AbM7izERq5x+H
	LNUCB6fqCuSmVEn58zO3w273maqC0P3S/Vewl3JcLZ5IyrZ0/W5VoEqck9QfvOJa
	vJdhzYCpehLkOnkb8x9XHrXE+6WhvUWtFhKkaaozeavlEGj2KqMSwkKksRcdbRll
	tMUeu49sR2uPvNsbYqKMgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782856225; x=
	1782942625; bh=FtW04vCW3OqAUmDv/lvhOw4gBZ2rhR+DzNAJYuMHVCM=; b=R
	y7ea02bUAqmJBN7Pg+cDnYvZkbGzIwq+/RQ0aeALbO/XO3SrWHz+CXuSXR8FSAVm
	CMeF3Bn0zEcsJnaEbqUX5lPOKCeUSB/B1T/7dD2yo6ws72iQN9TBefgz82v5VqqR
	7rjcZoOh7aDfAprxmvWXbtUIz5eIQ/CltkMinV3BH9vMuWWIBnSfHU4oJJQ1GIeP
	5DqQpk7xlZ6xMTy6pjyS7NnwNX1RNl6l6vV83wnlrmxSUoZ5Po1RbbNN/VsN6g5L
	9eO1Tq7JjA2WAuf08Zrau6ksuXO5mQfK3fbK1p8dWCW2NA9eSDyqyaYnFta/Bc1X
	gyRto5s17AcFlReLXF4Yg==
X-ME-Sender: <xms:ITpEamzgobfB5qg6AaaDCvV35cJ0Hb7anZGl5Dj0PmBYi9CWIdMCyg>
    <xme:ITpEai8EzbkNNwjut4L54JusyqWo-7c54apUG4_LZT9hGxB66eYTKCEGKbEreCgXt
    tiXnGG_RVXe_lvvoMKRH68t2CMvbSbZsDkJWkiHZimioRMLAAau6A>
X-ME-Received: <xmr:ITpEamjWFTODTBrKsXiPWIpCJlxPk3T1_CF8fM_yRiTjQ7mDxpPmX6BWuX0>
X-ME-Proxy-Cause: dmFkZTEfzDn5iE36M7bC7fO+VDKjXDAZq/6tQa9vlTO5s0o42UsGE9XeU9fcrEUs4o3ymk
    8heez+YYyFyvdfpd77/APi38vZv/r4d8q/XRst/ibcJRPYvn6N1yV9ehqIo8KORLBvE0yC
    7Kl9ubL/Cut1Ko/x9AndpQ39zOAWQaNDbdtY6ncSdOiURYxJztOecd31H/lJWT/wkVQpqJ
    jKKd2dOmKx5/n2oJBtSuLY6C++zyejkYvedIG/mtwL6XPCPwY16CmAjAT+xgcA708tXpfG
    ZCKp9pMHm235wLYY8BLBvs7cm5cDaCaWut4klOKKeKMRfHqF+E8Z7vT+vurKnO63UnMzev
    eq7VBdbIWTszzB86QU4KIX6y06HUYBpokVjnxaSA2OgyZXTfdXLd9K2Uzec3DMYgszMV/O
    CBfZDbusyIKx4EPY04CQFGcCYExzl80mJd6hW04UBGypnlblRLdudq64xEIGWRVb/kPkII
    dUevUSKHMsrJ2gHUlExq/CKkkw939XuVFeUAGxv5jOXV+vVM/HN0C4rh5ZBdZT3duLq3N9
    jH44kz2/jHBSDVY8J/8eyJkNCTNgiv1ELVrUWXk1JgmeD54pFZNn0WGQTS3qvMkx9XhQnu
    Xpy4l4sriPegl23rD+6wcEdKDTlH7JRUALq055+JsL+7sMcdWi/C32HmIl6g
X-ME-Proxy: <xmx:ITpEahEaG4lvEif7iexyzf5SH8uhR_gj_eQYTD6R1jle7LulNybZIA>
    <xmx:ITpEat-6e_ONzo2xZvNJ_cQmYXwwI3v61lybLFdRSpwfKTPWk3auew>
    <xmx:ITpEagzmjwt-KrqdpGFs2TteAlvPcRLE4rOuf4QHqBNpWtzInJrZ4A>
    <xmx:ITpEahN5kEMbcOjW0eWiFbNoTZe-ghyH3YCXWu7kN6ezaF0r-4AG5A>
    <xmx:ITpEanR7tjMO7t-z2bwm2pbzCCJXrmYyq2Fyc_R4cJRrCPmfkjaBRkRD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 17:50:24 -0400 (EDT)
Date: Tue, 30 Jun 2026 15:50:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>,
 Vipin Sharma <vipinsh@google.com>, alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Add luuid to libvfio.mk's list of
 libraries, not to the Makefile
Message-ID: <20260630155023.2ffb3226@shazbot.org>
In-Reply-To: <akQ4p3sPdNzSnAc9@google.com>
References: <20260630212805.474418-1-seanjc@google.com>
	<akQ4p3sPdNzSnAc9@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 21:44:07 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-06-30 02:28 PM, Sean Christopherson wrote:
> > Link to the uuid library as part of libvfio.mk instead of as only linking
> > it via VFIO selftests' Makefile, as the whole point of providing libvfio.mk
> > is to allow linking the VFIO library functionality into KVM selftests,
> > without KVM selftests having to know the gory details or duplicate code.
> > 
> > Cc: Raghavendra Rao Ananta <rananta@google.com>
> > Cc: David Matlack <dmatlack@google.com>
> > Cc: Vipin Sharma <vipinsh@google.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Fixes: e65f1bf8a2db ("vfio: selftests: Extend container/iommufd setup for passing vf_token")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>  
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> 
> > ---
> > 
> > I would either like to land this in 7.2-rcN (ideally rc2 or rc3), or take it
> > through the KVM x86 tree for 7.3, as it's blocking a KVM selftest[*] that's
> > been in the works for more than a year.  I can throw the IRQ selftest in its
> > own topic branch, so even 7.2-rc5 would be "fine", but I would much prefer to
> > get this (or an equivalent fix) into Linus' tree sooner than later.
> > 
> > [*] https://lore.kernel.org/all/20260626213534.3866178-1-seanjc@google.com  
> 
> Sounds good to me. Alex can we take this in one of the next RCs?

I'm intending a pull request this week with the bitfield and module
option latching fixes that are currently in linux-next, I'll pull this
into that as well.  Thanks,

Alex
