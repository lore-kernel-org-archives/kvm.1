Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF734E7815;
	Thu, 17 Sep 2026 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675816; cv=none; b=QKFYaijWnsQtl7RBJVp6qOPvxX2ba5f9EPl8dGQFTxBpTm32zKdyXUvlghQoAxzv8i9+NQ3IWn9Wup2LWyhEEWVOiA93JpknvKXcfm+q11lF2TdVigrWVxPeO7n1Q4yo2inCULyiZNeZ8iYpv2+lbjQ9u6gSXKeeWThHsnL27sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675816; c=relaxed/simple;
	bh=MnlQLlGevuZVP81RDZeAwGxXWBL2kolyVjYGLCwaxxo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Or0vV3sH00OxPM+mcA4xQ0xbLcwAYrUSgOoc+PQrYeJkJLbRbJSYm9rMxXN14e6E5qhMxYc0sdMw1mnYmW9yH0oPeUQvwx+Mhebx+6e/YO04woLCm/r54Oc57cg8nxUajMBmnb0VhQhhBtrThi7owi9HgviS2ddjkmWNMSfOmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JopKv19W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JopKv19W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267A51F00893;
	Thu, 17 Sep 2026 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675807;
	bh=MnlQLlGevuZVP81RDZeAwGxXWBL2kolyVjYGLCwaxxo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=JopKv19WRUWkE41hJ70SX3HyRVeng/Kbsm4nIx+iLweaUt/wP5WcMBBMjWRpsEcfe
	 +IfG99GXJUvS0fp7yN4RzcExK5CnbdNbPPuPpAfvQZHL8ltdLCRHutAhSgcNE1tAw4
	 MEHGK1+IFwwyDEuEo3tzH/JSSvTmua4TaFormbGx2hPZXMJeJ/jI4HqSBSPRQzK4EK
	 xZvA+BiHaY1ClhqVA4fe3VTvBurWQvU7zg/n9DYrk2Wq8JsBTKCVe2hWzAVwbNMkMr
	 oIuMX7SOuOIh9xcZiK4OgyJ+cggL3pIoIuFRwuAGpY+jFdUBYTagB9vJUKmR7YPC4H
	 As5RPYcAbZgsA==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 22:09:58 +0200
Message-Id: <DLHV4FKD31CX.3JEB9FLV2327F@kernel.org>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Cc: "Alex Williamson" <alex@shazbot.org>, "Zhi Wang" <zhiw@nvidia.com>,
 <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <kvm@vger.kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
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
In-Reply-To: <20260917171056.GF3968357@nvidia.com>

On Thu Sep 17, 2026 at 7:10 PM CEST, Jason Gunthorpe wrote:
> On Thu, Sep 17, 2026 at 04:50:07PM +0200, Danilo Krummrich wrote:
>> On Thu Sep 17, 2026 at 3:28 PM CEST, Jason Gunthorpe wrote:
>> > On Wed, Sep 16, 2026 at 08:02:17PM +0200, Danilo Krummrich wrote:
>> >> >> TBH, I don't think it makes a difference; having Rust abstractions=
 is pretty
>> >> >> much the same as having another driver. I.e. it would be equivalen=
t to saying
>> >> >> "before we accept another pci-vfio driver we need to do some rewor=
k".
>> >> >
>> >> > Well, it is, but thats the point when judging effort..
>> >>=20
>> >> So it seems that we agree that there isn't really a difference betwee=
n adding a
>> >> new C or Rust driver in this regard.
>> >
>> > To be clear I was trying to say I think you are are underestimating
>> > how much work this is and how long it will take. Including all the
>> > preconditon C reworks has to be included when considering how much
>> > work is involved.
>>=20
>> I'm not sure I follow what you mean by "preconditon C reworks".
>
> Rust bindings often seem to need C code rework for Rust, drvdata here
> is an example.

I can assure you we can set this concern aside. The driver core code, auxil=
iary,
platform, PCI, DMA, scatterlist, DRM, firmware loader, IRQ, I/O and fwctl, =
to
name just a few, did not need any changes. And from the top of my head I ca=
n't
think of any case where changes were needed.

For VFIO I already wrote the code, and no changes were required either, exc=
ept
for the drvdata things of course.

But, as discussed, this is an existing layering violation. The Rust driver =
code
code simply relies on its own subsystem's API contract. Please let's not fr=
ame
this as a Rust issue.

Plus, it is trivial to address, so it luckily is not a huge problem anyway.=
 :)

>> Or do you refer to other C core reworks people are working on? If so, th=
ey are
>> only relevant if they affect the drivers. And if they affect the drivers=
,
>> there's not really a difference between adding a new C driver and adding=
 a Rust
>> abstraction.
>
> A new C driver should not need reworks?

If a new C driver is not affected the Rust abstraction won't be affected ei=
ther.
They are just users of the same APIs the C drivers consume. So, that doesn'=
t
seem to be a concern then.

>> > I cannot forsee rust bindings for vfio until sometime in 2027.
>>=20
>> What is different in 2027 than is now?
>
> I mean I think that is how long it will take to merge something like
> that, given how many other vfio series there are, the lack of
> expertise, and some general expectations. There are already lots of
> series for vfio that are in front of something like this in the queue.

The same would then be true for an nvidia-vgpu driver written in C, no? Aga=
in,
the Rust abstractions are nothing else than a driver in the end. They only
consume the driver facing APIs and translate them to a safe Rust API.

> And then we end up with what will be one of the most complex drivers
> in a form nobody familiar with vfio can review.

I think this isn't the case; the people you refer to can still review seman=
tics
and vfio design specifics. It's not like everything is different.

For instance, there's still a get_region_info() callback on
vfio::pci::Operations where people can review whether this semantically mak=
es
sense.

And for the language specifics we have a lot of Rust familiar people around=
 who
will review the code and help to improve it.

Why not see this as a chance to scale on both ends? More people on both end=
s
will get familiar with VFIO and Rust at the same time.

Thanks,
Danilo
