Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB113375C5
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342504; cv=none; b=BtHI5NqSPPV9k4+rOuRmHMjieXF+eoZquzdSTXFNujQJijbWlz7LMz52+D7hCVz8hOl08Vzrlf3mfTU4Kr7KIBic8XCN2o0ErIoXazKvzf7kU2AzUh5n1LWhMsMEZs1iJHh3yc6Q1fmo4vEbDlycPjZnXba+oCpfyso0gNb5XXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342504; c=relaxed/simple;
	bh=PHU/VkKjbvSzcsitbW8Sm017KmkW90HHXwiWkq+L/HE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBIb4PBfcXeymyLIPhRqpgvn8aGDuNqVRyAxY13jrtfyze+PZQn0ImmNpBnhEts2neYsRXaIryZj2HXTYRcExOaUcysD+viU5cb9frEqOKBm2ksHdV7q1iWsP2hsVfJ+DVQ9UkwQBD1Oesdm8B3QyOOBeAcxmZq1O5gLNZcANYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NAZRYLGU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ya1NmksN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NAZRYLGU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ya1NmksN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DB311D00159;
	Thu, 12 Mar 2026 15:08:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 15:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773342500;
	 x=1773428900; bh=YhqBzNmJdC6Q0Hiqs8L9/Ku2CqXVRprrSQO1RMsuIGY=; b=
	NAZRYLGUzCtmA4MFyuKYZP6fvCTuHy/9aEcLd+krdRRGE5rn5wnTjvYxe47SS5SR
	9td2Y2u/EvgNFSsMnm3DGYAAhUHNAnbhzDoL7UknZSyQlPEca+wTQLsDaLIzFh0p
	GKyE3yBLCpXV9xKZoat+hHWVjLlzA4BDwUduA6aM3V9yk+z6zm4vEVM3GOHxF1Xw
	wdgWEOP1O7iiHu2QHqzOATIEUQb8v4QKK1Q9jFv0qJwr9qIxSjGNhNSnuRZlWAr9
	E7GGPB6z0IGQCUaDKlHs2u2dXq3ejNNyht3KK81Lscu/1JnXW44nv6wU9YPYET+p
	7rh9gdyVi6zl1XMQcXNU6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773342500; x=
	1773428900; bh=YhqBzNmJdC6Q0Hiqs8L9/Ku2CqXVRprrSQO1RMsuIGY=; b=y
	a1NmksNm0WqKEm9opnDxgrnyGS8ZANuVHdq5rPKpDbEH7QM0kX6xGIRmpiESgqde
	G0Z3G3Ja86yaBKP/krVQ78pyoxgaplNtwNTQQvNKO6b0iwHnpqw4ksrIZmc5abZu
	XxcytnTpYNMqhhLH+UDqFYIq4A2/rGILzEZW6fCAbGnffuF/uDBKtLZ96vHKpOru
	ftGaC90moHhgWwvivHo8BomU7HXypEMzEbBbYJjxYTqOvN7HqhMxUObHzmVuj2OY
	0d6Q90Iw4C9cojLT9TMlmM4+iiwK+HsJ2eCxMO3tKJKgfVIeQXiGy720LhqXI7Bq
	blgHDGPLgkF7FLYy//vGQ==
X-ME-Sender: <xms:Iw-zadlfl7ICYH7Ia5r6kP5ODmXyJYPQxyGPWzGIdnvb-Wvir0j_jQ>
    <xme:Iw-zaQETFFx3e_z1NBhQZwZF_8aECnjEgnCCUOjvT1Ably3W0cSyTaiLp4kuan7ZP
    PKDSYRB2tK4XpfM9A2BkJxHkBfics6ct1nMt-EXXgK38XggxKF1>
X-ME-Received: <xmr:Iw-zaehEC9Evo-QcagGIlg9oo9uW2q17dtsFv4AHth2qVmqs65ETrjK1f5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohephihishhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhgghes
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphht
    thhopehjohgrohdrmhdrmhgrrhhtihhnshesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    eplhgvohhnrhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghorhhgsehnvhhi
    ughirgdrtghomhdprhgtphhtthhopegrvhhihhgrihhhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:Iw-zadhO__ZWxX1-X3Eq_f3xIqK372vTvshmveq52FG83SQlA8gx-Q>
    <xmx:Iw-zaRnhyCgI-vr3pngvrkRQM3fiqXWD90BH8w6I9ubQu3YfeQSREg>
    <xmx:Iw-zaRbhS-sX6_IplySRt2HYUSJM4r-ssAZQPzmMZG5_K7YNgYMMmQ>
    <xmx:Iw-zaUwasTB9_yOduttOatT22rbXAdyKYUCveklvK7m5JXtNKM3A8Q>
    <xmx:JA-zae7ir_sg0cWT08khmp-j7-bcTrgxSY0hc7X9-Ceqg-Z30vsIzKKT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 15:08:18 -0400 (EDT)
Date: Thu, 12 Mar 2026 13:08:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: Peter Xu <peterx@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, jgg@nvidia.com, kvm@vger.kernel.org,
 kevin.tian@intel.com, joao.m.martins@oracle.com, leonro@nvidia.com,
 maorg@nvidia.com, avihaih@nvidia.com, clg@redhat.com,
 liulongfang@huawei.com, giovanni.cabiddu@intel.com, kwankhede@nvidia.com,
 alex@shazbot.org
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
Message-ID: <20260312130817.69ff3e60@shazbot.org>
In-Reply-To: <abL5wKfPGzi88iBy@x1.local>
References: <20260310164006.4020-1-yishaih@nvidia.com>
	<20260310164006.4020-7-yishaih@nvidia.com>
	<abL5wKfPGzi88iBy@x1.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey Peter,

On Thu, 12 Mar 2026 13:37:04 -0400
Peter Xu <peterx@redhat.com> wrote:

> Hi, Yishai,
> 
> Please feel free to treat my comments as pure questions only.
> 
> On Tue, Mar 10, 2026 at 06:40:06PM +0200, Yishai Hadas wrote:
> > When userspace opts into VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2, the
> > driver may report the VFIO_PRECOPY_INFO_REINIT output flag in response
> > to the VFIO_MIG_GET_PRECOPY_INFO ioctl, along with a new initial_bytes
> > value.  
> 
> Does it also mean that VFIO_PRECOPY_INFO_REINIT is almost only a hint that
> can be deduced by the userspace too, if it remembers the last time fetch of
> initial_bytes?

I'll try to answer some of these.  PRECOPY_INFO is already just a hint.
We essentially define initial_bytes as the "please copy this before
migration to avoid high latency setup" and dirty_bytes is "I also have
this much dirty state I could give to you now".  We've defined
initial_bytes as monotonically decreasing, so a user could deduce that
they've passed the intended high latency setup threshold, while
dirty_bytes is purely volatile.

The trouble comes, for example, if the device has undergone a
reconfiguration during migration, which may effectively negate the
initial_bytes and switchover-ack.

A user deducing they've sent enough device data to cover initial_bytes
is essentially what we have now because our protocol doesn't allow the
driver to reset initial_bytes.  The driver may choose to send that
reconfiguration information in dirty_bytes bytes, but we don't
currently have any way to indicate to the user that data remaining
there is of higher importance for startup on the target than any other
dirtying of device state.

Hopefully the user/VMM is already polling the interface for dirty
bytes, where with the opt-in for the protocol change here, allows the
driver to split out the priority bytes versus the background dirtying. 
 
> It definitely sounds a bit weird when some initial_* data can actually
> change, because it's not "initial_" anymore.

It's just a priority scheme.  In the case I've outlined above it might
be more aptly named setup_bytes or critical_bytes as you've used, but
another driver might just use it for detecting migration compatibility.
Naming is hard.
 
> Another question is, if initial_bytes reached zero, could it be boosted
> again to be non-zero?

Under the new protocol, yes, and the REINIT flag would be set indicate
it had been reset.  Under the old protocol, no.
 
> I don't see what stops it from happening, if the "we get some fresh new
> critical data" seem to be able to happen anytime..  but if so, I wonder if
> it's a problem to QEMU: when initial_bytes reported to 0 at least _once_ it
> means it's possible src QEMU decides to switchover.  Then looks like it
> beats the purpose of "don't switchover until we flush the critical data"
> whole idea.

The definition of the protocol in the header stop it from happening.
We can't know that there isn't some userspace that follows the
deduction protocol rather than polling.  We don't know there isn't some
userspace that segfaults if initial_bytes doesn't follow the published
protocol.  Therefore opt-in where we have a mechanism to expose a new
initial_bytes session without it becoming a purely volatile value.
 
> Is there a way the HW can report and confidentally say no further critical
> data will be generated?

So long as there's a guest userspace running that can reconfigure the
device, no.  But if you stop the vCPUs and test PRECOPY_INFO, it should
be reliable.

> > The presence of the VFIO_PRECOPY_INFO_REINIT flag indicates to the
> > caller that new initial data is available in the migration stream.
> > 
> > If the firmware reports a new initial-data chunk, any previously dirty
> > bytes in memory are treated as initial bytes, since the caller must read
> > both sets before reaching the end of the initial-data region.  
> 
> This is unfortunate.  I believe it's a limtation because of the current
> single fd streaming protocol, so HW can only append things because it's
> kind of a pipeline.
> 
> One thing to mention is, I recall VFIO migration suffers from a major
> bottleneck on read() of the VFIO FD, it means this streaming whole design
> is also causing other perf issues.
> 
> Have you or anyone thought about making it not a stream anymore?  Take
> example of RAM blocks: it is pagesize accessible, with that we can do a lot
> more, e.g. we don't need to streamline pages, we can send pages in whatever
> order.  Meanwhile, we can send pages concurrently because they're not
> streamlined too.
> 
> I wonder if VFIO FDs can provide something like that too, as a start it
> doesn't need to be as fine granule, maybe at least instead of using one
> stream it can provide two streams, one for initial_bytes (or, I really
> think this should be called "critical data" or something similar, if it
> represents that rather than "some initial states", not anymore), another
> one for dirty.  Then at least when you attach new critical data you don't
> need to flush dirty queue too.
> 
> If to extend it a bit more, then we can also make e.g. dirty queue to be
> multiple FDs, so that userspace can read() in multiple threads, speeding up
> the switchover phase.
> 
> I had a vague memory that there's sometimes kernel big locks to block it,
> but from interfacing POV it sounds always better to avoid using one fd to
> stream everything.

I'll leave it to others to brainstorm improvements, but I'll note that
flushing dirty_bytes is a driver policy, another driver could consider
unread dirty bytes as invalidated by new initial_bytes and reset
counters.

It's not clear to me that there's generic algorithm to use for handling
device state as addressable blocks rather than serialized into a data
stream.  Multiple streams of different priorities seems feasible, but
now we're talking about a v3 migration protocol.  Thanks,

Alex
