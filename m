Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9063DA5CD;
	Fri, 10 Apr 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840040; cv=none; b=uV6g8pV+f73gMn92v2Vv+yibGOyP3Adxs72tKnwkFNchXzOA9dDjDqh2UJWklIjlxlgPJO9xrx7el7cS9OBFL89LLDLXWC07j8Q5oqS6HT/6bmtc99ncZNteeQX3VE675CVO7mVKnJYJAkDNsSrAjVTSgFkiY3AASeAn1akQ8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840040; c=relaxed/simple;
	bh=mhE+1mSbh+4Kr7lBtfldyZ1vjqw7BhOEKQ24xmpiJJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtFBdLOTxl7WwfjZ3D7kbITHACZjU8U+4doS0ZwfC9zr39ptbBpUYCRsUOYswXYCuAyswS0YJHdRUDVItGeYgGfJbbMeTC/nISWffhWQhT++54wHoqXxgJhAMmZEeoCHis6Wc2azXJjJUAm4PncAmDU2fKiCk9FOxoqe0EJbIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=PAOAcVXr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NLYKsvS5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="PAOAcVXr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NLYKsvS5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F1A3FEC01AE;
	Fri, 10 Apr 2026 12:53:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 12:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775840031;
	 x=1775926431; bh=3fBI9WMOUO1EO/kfMEUY/GAzjXfL/09wFjMyrH7hKwY=; b=
	PAOAcVXrHORrYg2lR6oIW6gDMTRqCSR2R/pTyBdAfNbsLc3pK2dZkb9bir3c5gFh
	ACtfO66P/cbo4avRxAf18cU381hiY83NpomSIEX8JVZt1YdhvefoHFK1Q87I9Eqh
	f32/jx50Xxm0B89WQahxxQXRXC3v6hRyaiuKAyyFu9zBoB02yyh0HdeGxYApSocO
	3LgVW0LkYtRLfX4Jj/KwdUwF/lJnjnb1dqZir0kDQz9dWzQEJdj9vlSgDodiPXL7
	lyl5n/PMeop6+B1NvlvAn7WXhM4V5z1dwdQQ3Q1zBisgedmwiLyPOvIxDt9Um8ES
	rETU/oBmmr0Ec3dthdoy7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775840031; x=
	1775926431; bh=3fBI9WMOUO1EO/kfMEUY/GAzjXfL/09wFjMyrH7hKwY=; b=N
	LYKsvS53OZrcZKQBpGU1ll6DiGGHUMo4ufh/HYtd6thjrHMOXEVdhPGK8Sc7r59D
	R9MrDnpLbslciECe0UfZoAnDv4NKVxvXY5vbyILpU6Fv4D0SzZJtMnra8cJ2C+sh
	N21bzHfD0d7MSuGXF70Qb3y+cg6hZnvj9gYukzQdUMXzQcJD2ORc4clkXzKX6Xy8
	+gOMwsQO4s88myeb9v6uuqnZrbJt+UMFhLYOuADbpoOz2z8YM4buHgREHQYWd55N
	w4OMJVk+yASTmWfYY9xgmffI4IiEv+uuEEukpraHHBYzcY4zrbv/trIRX1uuLzu6
	bPFnM4lEKRsJFIGNlw/LA==
X-ME-Sender: <xms:HyvZaaihIzs-hCUoq461znd5pRrCQ4Sj7bWFHxuzo-va2AVJIkY6Rw>
    <xme:HyvZacju6W1Bis5Tduql0QEN-EeMgNVY_PxhpXnEPKvLLyHXLutHvMsq5YcOK8XoX
    fXcrBIWWCSnuYRoEXOpDPBnvlnb9Hz6CEXnblQIhCjW1NBzCfhNYew>
X-ME-Received: <xmr:HyvZaSIYmL7eRpxNlF6-Jf0KP9jHZ7knTb6KE7O2diskrIr8_5Z0U-zF9n8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsrdhlohhnghhrohhssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghlvgigrdifihhllhhirghmshhonhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:HyvZaTEsxYtJMnvkCUhR1kcoFt_P2y2YBDAyMyT5SGF-r_vSaXHL7g>
    <xmx:HyvZaeQeDTpIIwIvCkm193XRvJuYF2QpMc9Xz52m9Y_A_dO8sBrdTA>
    <xmx:HyvZaXdA-Kqh4NA9CGeWzXE0vQvj9glWHYcfwn9MekV8eEp_J2BC8w>
    <xmx:HyvZaVq3Fb44XpJOAJ5G02EGXcftBBLflw-96LsY9SnxdV5YUM_DaQ>
    <xmx:HyvZaaBzC9llKAPXtlgS_3mrJAyLI1asSxXcuWeDLBYmP9XCFewpvx_e>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:53:51 -0400 (EDT)
Date: Fri, 10 Apr 2026 10:53:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Christos Longros <chris.longros@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] vfio/pci: sanitize bogus INTx interrupt pin values
Message-ID: <20260410105348.6b5e504c@shazbot.org>
In-Reply-To: <20260404181436.754390-1-chris.longros@gmail.com>
References: <20260328230126.73230-1-chris.longros@gmail.com>
	<20260401165920.373e7584@shazbot.org>
	<20260404181436.754390-1-chris.longros@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Apr 2026 20:14:36 +0200
Christos Longros <chris.longros@gmail.com> wrote:

> Hi Alex,
> 
> The RTL8852CE reports a valid interrupt pin (INTA = 0x01) under
> normal operation. The 0xFF only appears after a VFIO bus reset
> bricks the device -- at that point the entire config space reads
> 0xFFFFFFFF, not just the pin register.
> 
> Since the root cause is the device bricking on bus reset, I think
> the right fix is a PCI quirk rather than the generic bounds check
> I proposed here. I have a quirk_no_bus_reset patch ready for
> 10ec:c852 (RTL8852CE) -- I'll send that as a v3 instead.

Seems like the better solution.

> Should I drop this VFIO patch entirely, or is there value in
> keeping a safety net for the pin register? The PCI spec limits it
> to 0x00-0x04, so anything outside that range is invalid, but I
> understand if you'd rather not add checks for scenarios that
> shouldn't happen with functioning hardware.

The pin register is a bit arbitrary.  We're talking about a scenario
where the device has gone fatal while it's in use.  Is it vfio-pci's
job to sanitize every config space access to prevent userspace from
crashing in such a condition, or does QEMU need to apply a bit of
sanity itself?  Maybe QEMU should detect the state of the device after
reset and perform a surprise removal if it's in a broken state.  Thanks,

Alex
