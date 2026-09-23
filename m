Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65856C651;
	Wed, 23 Sep 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193932; cv=none; b=eaxTsaCl3Jwr2C9RHWh+Azpldytrl3c5xP5IhfhQmD8UufSHfx3/MQKJdBZb9mIgfWTD5ajipQR5idkS3BVmYb1jkywXxkyAph2yg8LeEUA2d8dBYY+U7bEuZMD2JcTVgTyoTeq0zKDf2vaC7karJ7gm5JArgHdZXc7WhVDW2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193932; c=relaxed/simple;
	bh=UThFQqE2nFbGVGXVivJEy6xsdCtKSR8oOWel8XxMWs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcu00PQe5M4MbueGiTaaQrzE07cbEbqcD55QjCVzw9B4cHj7qN14utsSFHb05YxhEek5jBBhLGloi6YqlG7G88uHX3eV65zy2QZU8ftqr2mRWSHPLUYnx7+osXO4okkXbnhGk0n2uisLWGwyxCKSY7Mrl046wDrN0qA1SusqrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ZbAdGQxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q1/FY4qD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ZbAdGQxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q1/FY4qD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D8ABBEC00CC;
	Wed, 23 Sep 2026 16:05:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 16:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790193928;
	 x=1790280328; bh=JUwLwolmgzoYkr0jKNKZ779s9mSH2rxnP/9sdt8jqGA=; b=
	ZbAdGQxSkA2mHJIQdiZGQnpOXxNybNglJjNbF7RMCpAJs5VRcUI72J/ViT6RzEpR
	WRoHSsmZb3IyvAH0jft5GVzgIE9EZz2Tnl/2iLK82iwBVLzIlvThtMjjeU7EdgKy
	2pCP1efixRn9hJ8uOBCmyE0cx6hq1dzmLJ7t+ocEWw0PfnuljFLv+/sPHU1KZHTj
	E679FOSa7RsINEkAqUOb043E94WNXgdakXmPLVTzZMVjgup0et4oLWhPcZFvdG3F
	bNooSnCoWTIqjOPvgGHPWUhVFhsXcHBchw8PWjIzgB/dlpB0gxEcA68lTa612cLK
	U7llEkvOjBnaLv96wMUXiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790193928; x=
	1790280328; bh=JUwLwolmgzoYkr0jKNKZ779s9mSH2rxnP/9sdt8jqGA=; b=q
	1/FY4qDb0A+YxToOOP4iHReDhjS7JWTJ/E0ZofWhdjmI0f6HVNwIhP2irzKoN+1R
	DerQ4oc3DADQgz8yKJ7LOqUCtUPE2MMqIY2p5B+clNhQ2NbtluX/7klJbIYV3x6N
	cmpCez7oxuA7o3ZysrfzhcimbFyxgkbF8ILN2FNUX+ckFjbZN9z2AsPdO+/jdOg0
	2q05irA37EWzGzPjtE13GAvB0CpZdGzNfd0uA5K3qVwr+mgFNFOZeUTBBVjCX7q2
	eL7sYWI4cqLYs5pmJkyLDq7klnELvbe+BxHkNRxvSBUcNEmagX15ydjkoLWeM8C3
	eLFUzkvh3TJnsgEwx4wBg==
X-ME-Sender: <xms:CDG0auGNTePmPgQ-G9omMqR9AwVIsb0IZTDbzLgFL02ERxaTu2rk_g>
    <xme:CDG0apt2Wv3NC5DBtN3tOs_ha1zM3O2TrYXGieorEmyf18LVZVyA2Y4TXWHbZoSHZ
    q_nTadSxXS4pTcYLgJKtDXlWpZMaNPBmC8vjgRA1bdOin-f8GidrA>
X-ME-Received: <xmr:CDG0ajtD0YJSxJ-w4iWCayrkBBQrF1xM3UmAwHXihfQHfM9VBy4mcLBRlimWwA>
X-ME-Proxy-Cause: dmFkZTE99ioZg8PG1u/Lino5tKLa9aVNVWGU06n/wTa0B3sKfMwnM4kcsu8D3pzwQpGVLG
    pw6n0QH07tKGTiHMH/ysrTzxxqmYHWncsTkTQd02CX0Dgxn4kpyZiL7E1vwIzwGpUDBoP0
    6Kgw9cu27Mp8rTWQv9gsdhTS/Hnq24kPXUEr9buaOHqjJY1u8sDy2OxHajrOpip/NR11t1
    kr0f8gBhcBSHKv93lGsuIvXcY6IokGZCMJ26okZSGj8LEu4N4WBD+YWOZhiMtUBtzB0RF4
    Da+tPf9Rv5e/MoP+z6RyZ1uCcGaS0a88XvEYVIdkr98M42pcuiQA4KlNQ7TjrVrnRj8vlI
    ARI7tgJ49LrQeMSzDn++bJjHmKImKDJi6T/8xXujy6PE4FGMdr2ldu1AUVfmMlbBCnRAMn
    AUDpcEWoVefErF+ACGL9MTFDOhGxaRGJt21B/u4dMl9ZCdyLIwE94YNRmrp/4kv+q0itJ4
    pWUDoR5Yq2BDdKkY/Khv4znGt5Mdv5wKT18N8DRvnBNjotjghj638QgkLFHH6nSleIXrOh
    kUjMg/OpWVEyef56f8AYcKVxN7eeJ0wcpisKrBK20C5O0dDzNXrvIIrLa/K6vMIc8TNyM2
    a7DXfVmQtQDszRniNXVR7TtdHSUXkDnPlAm4iLu3ps3fA+YIq1J0e9PrHTkw
X-ME-Proxy: <xmx:CDG0aiFdhCc7XPldMWKu413HiCiaRysPExNh_DTmqxuk9qz4u9fnYg>
    <xmx:CDG0auLeqwb_kChf1eLIJerrtUl0ZXVqtejU06nNSbUeCxk6p2QGkw>
    <xmx:CDG0aqa-7IdZRaFr_9o62XFrRnvPnOfVfgxJalEi5iaAcnmYnGn2TA>
    <xmx:CDG0aroIBlLQlpNkXlzI3oB7DiOpHdxKa9GuHZNi98sVoImc66ZEQg>
    <xmx:CDG0avbie63RuYOgdqg40gJ-OXcF0zpzZSIZJ4BfLPjtJxzHK0OA9qZP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 16:05:24 -0400 (EDT)
Date: Wed, 23 Sep 2026 14:05:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>,
 <kvm@vger.kernel.org>, alex@shazbot.org, "Simon Song (SW-GPU)"
 <xinmengs@nvidia.com>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Message-ID: <20260923140520.5cbea0c7@shazbot.org>
In-Reply-To: <DLHV4FKD31CX.3JEB9FLV2327F@kernel.org>
References: <20260914121217.70fa0d93@shazbot.org>
	<DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
	<20260915120148.7548a8ca@shazbot.org>
	<DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
	<20260916141718.GU3968357@nvidia.com>
	<DLGUPX9KPFKF.12CU304YAST79@kernel.org>
	<20260916162817.GW3968357@nvidia.com>
	<DLGXS4SCP3VT.28XXX09BL963U@kernel.org>
	<20260917132829.GA3968357@nvidia.com>
	<DLHOBJB1NYJA.3FCP9OLPBVRZA@kernel.org>
	<20260917171056.GF3968357@nvidia.com>
	<DLHV4FKD31CX.3JEB9FLV2327F@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 22:09:58 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Sep 17, 2026 at 7:10 PM CEST, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2026 at 04:50:07PM +0200, Danilo Krummrich wrote:  
> >> On Thu Sep 17, 2026 at 3:28 PM CEST, Jason Gunthorpe wrote:  
> >> > On Wed, Sep 16, 2026 at 08:02:17PM +0200, Danilo Krummrich wrote:  
> >> >> >> TBH, I don't think it makes a difference; having Rust abstractions is pretty
> >> >> >> much the same as having another driver. I.e. it would be equivalent to saying
> >> >> >> "before we accept another pci-vfio driver we need to do some rework".  
> >> >> >
> >> >> > Well, it is, but thats the point when judging effort..  
> >> >> 
> >> >> So it seems that we agree that there isn't really a difference between adding a
> >> >> new C or Rust driver in this regard.  
> >> >
> >> > To be clear I was trying to say I think you are are underestimating
> >> > how much work this is and how long it will take. Including all the
> >> > preconditon C reworks has to be included when considering how much
> >> > work is involved.  
> >> 
> >> I'm not sure I follow what you mean by "preconditon C reworks".  
> >
> > Rust bindings often seem to need C code rework for Rust, drvdata here
> > is an example.  
> 
> I can assure you we can set this concern aside. The driver core code, auxiliary,
> platform, PCI, DMA, scatterlist, DRM, firmware loader, IRQ, I/O and fwctl, to
> name just a few, did not need any changes. And from the top of my head I can't
> think of any case where changes were needed.
> 
> For VFIO I already wrote the code, and no changes were required either, except
> for the drvdata things of course.
> 
> But, as discussed, this is an existing layering violation. The Rust driver code
> code simply relies on its own subsystem's API contract. Please let's not frame
> this as a Rust issue.
> 
> Plus, it is trivial to address, so it luckily is not a huge problem anyway. :)
> 
> >> Or do you refer to other C core reworks people are working on? If so, they are
> >> only relevant if they affect the drivers. And if they affect the drivers,
> >> there's not really a difference between adding a new C driver and adding a Rust
> >> abstraction.  
> >
> > A new C driver should not need reworks?  
> 
> If a new C driver is not affected the Rust abstraction won't be affected either.
> They are just users of the same APIs the C drivers consume. So, that doesn't
> seem to be a concern then.
> 
> >> > I cannot forsee rust bindings for vfio until sometime in 2027.  
> >> 
> >> What is different in 2027 than is now?  
> >
> > I mean I think that is how long it will take to merge something like
> > that, given how many other vfio series there are, the lack of
> > expertise, and some general expectations. There are already lots of
> > series for vfio that are in front of something like this in the queue.  
> 
> The same would then be true for an nvidia-vgpu driver written in C, no? Again,
> the Rust abstractions are nothing else than a driver in the end. They only
> consume the driver facing APIs and translate them to a safe Rust API.
> 
> > And then we end up with what will be one of the most complex drivers
> > in a form nobody familiar with vfio can review.  
> 
> I think this isn't the case; the people you refer to can still review semantics
> and vfio design specifics. It's not like everything is different.
> 
> For instance, there's still a get_region_info() callback on
> vfio::pci::Operations where people can review whether this semantically makes
> sense.
> 
> And for the language specifics we have a lot of Rust familiar people around who
> will review the code and help to improve it.
> 
> Why not see this as a chance to scale on both ends? More people on both ends
> will get familiar with VFIO and Rust at the same time.

This thread has gone cold for a few days and nothing really seems to be
dissuading from the direction of implementing the Nova interfacing
vfio-pci variant vGPU driver in Rust.  Zhi has been investigating the
gaps and bugs in the PoC, and afaik, nothing stands out as a blocker.

I'll do my best to use LLM assisted reviews on my part, but the
expectation should be that I won't be merging any Rust code without
formal reviews on list.  Over time I hope to be able to contribute from
that perspective, but the Rust community is going to need to hold their
end of the bargain as well.  If meaningful reviews are not provided,
the driver can be orphaned and removed.

The Rust community also needs to be proactive in supporting the vfio
community such that abstractions and interfaces between C and Rust
don't become a barrier for C-based development.  Keeping the Rust code
working when the C code changes is the Rust community's job, we
shouldn't expect more than "best effort" from the existing C-focused
community.

I also want to be clear, I'm not endorsing Rust as a pattern anywhere
beyond this individual vfio-pci variant driver.  Any other proposals
would need to bring a comparably sized community to sponsor them.

Dave's approach to make vfio-pci-core a stateless helper with respect
to drvdata, with a dash of Jason's macro idea to minimize the driver
boilerplate for the common cases, seems like the right direction to
remove that convention.  I've handed off my own LLM generated version
that does this and it should be refined and posted soon.

So, unless there's an aspect we haven't considered, it seems the Rust
variant driver should be the direction here.  Thanks,

Alex
