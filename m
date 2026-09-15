Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81382389E07;
	Tue, 15 Sep 2026 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495320; cv=none; b=gpzk6rf/vVbvHxaiiE2z/4F1xyskZgRDdR1tt1kX2swPExlBSoTHtOXoiJqj4W+W9uNjX81EFAX5+octfGUhggaPli7TxYQKmPiEzhzhgmQcwdxSlP6vpRFSvDqsVZWifnn/r8x6ztGEKaqfyET+nThiYqQSgHo33MIH8QqQH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495320; c=relaxed/simple;
	bh=fKdtexK2tjqwgZC6UBPDUwOYcj+8rOgQ3rItFKL5jBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El9GxQo/GRTQOgtZHiaYMcgpUS653ChUdViqvpTgF7Pyh5EmTrylcObzmfO8qAJx8BZ0X8pJ8uICDhq7sCl8XVvJl6yZvp7tHxJYx/PGE9bsbbTMeIK2rfePJSsKGYUiQ3b/I0QWtM7q6zJFpR/iVmmWb68AiOnyJajf4Dq3TqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=J7gCj3gQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYEx2CvT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="J7gCj3gQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYEx2CvT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4EFB7A01E7;
	Tue, 15 Sep 2026 14:01:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 15 Sep 2026 14:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789495315;
	 x=1789581715; bh=897+qm17sL3v0FP/MXszEOUStPXgIyHus6lgEd1AaDM=; b=
	J7gCj3gQ8T1YMxOrybpfM3eJeu+7dLzxdSPDUqlqdjUyj5dIiPAPu9txVyDp3UbN
	X8I1/ZvbguBtP24VYZxRirAX1PMsPkOzXlGGZ2hVGFG7tFzSn8TP8wQS/Qv0DiHi
	rkkAE9OpFNm1SlhiBv5OngbVZoiYCYba1z1VZ+3ocJdHc7yQDhr0l9zeVdWSpS1E
	I3sx2AfobqgcWvXNegog6h2BinwKSzIjS8AiaB9q67el/wlqf4pECTRuM26+9ay6
	NbMRtwbW9wsI069dmrWY079J1niPTavcNxqIbiSPv7Yqnv2iKvh/nDwsJjUrajHx
	swsiMsg3xHm0BSgzf+D24A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789495315; x=
	1789581715; bh=897+qm17sL3v0FP/MXszEOUStPXgIyHus6lgEd1AaDM=; b=G
	YEx2CvTQP99/MV3tTWrdbpaG43TPFrUVmjGrmZ1l2TLfzxnJkApW2mSArxA71Xih
	kVYcfXO1Jtl9yqOAqqtHQPmIQizeq5BBgClqJVJrwLfsR91ZzvvgvEY+HgQL7xVL
	Mg7UGOmysCbop4Ucqx/i8xT8JTPESeMG572F0lky66g/0TcfZQFn6oYHnPhBP8ol
	VaTsRGDdkTtiaMBtAoEfa+M/QedYgKznii4iIfUwe+qrx2njDBs25GGR8WP3RKU4
	6POk6qRErfFTWuluNxD3LTzrvLrbPTTbZX7E7nbPIZ2nHOAMdi3WFQBhqrScizTC
	4nSgRF4Q3jOvBpzdh2Exg==
X-ME-Sender: <xms:E4ipaopPeXZAXgWmXKzlDRjn6yffNqooY7ikhbvy33BcNRKRxm9crQ>
    <xme:E4ipag9-TgvcUMnXlWve1lI5bZ3KyqCTREQnUF6BJga1WpemDaof38xoRun1EXrvO
    7DBjSDJ35eTA6ZxR3j9d0HQ1495NU_w31VSCFxSjK1MSvhGtBQ--w>
X-ME-Received: <xmr:E4ipar6DVKq4ItyMYgMbHwO2cMgvFa7fbhc9O5M9jjv-rN5qci2lJ6-CbydAZg>
X-ME-Proxy-Cause: dmFkZTFrwg/AmzJDC2h9TGXdHq7epJk+TWr6gcC4uNj3nLfncBMy7wyNCRNwIHDDhN2FMv
    HVj36YZNRMssben7AyJ2T9X7Y3vS6FzNIEartcApiYw9lKZsCKHE9I2peGX9yCt0OqJF6i
    ZYU8fjaMzSRXShG0SUxqzgcxzpeF6gRg5Ml2UeWGy8dlfZm1osMEVJr90fc5sqZuF3PE5A
    KfDhUypFxWvM32W7sGAKH/E7L6SX7fKOi2xJftKxUNrjmDdowJ6SLs7oemlmVIJ8gcdudX
    7YbGIqRnJE2550dwDamMuh/Li1OQbuet+YoML56aZV30RM2hx2MQ7j3kctY32rkBOOebjd
    Dp3Sri6n5D3cJO204Gl9ugI7DWMQDrjIQSY2B6vbxBuXgYX1F/JLSrJ8lxTo6rLj6IfDWJ
    vIJxXlsTEzgWwseolk6CCvnrRB9CvBD13/lkB5xHjYiVO7fj1Bwr5RdpuUhoNSWzuZM8zK
    fisTt0hvonavAf3gNHeB2PxiRoxY11ublPU2pXVxZsLDJKK03/IESTVZQJqSUR5ox9yfcx
    ptE3XlQ4R0oNA8U0jjAi7FvCshNtHd/muBXwgeSMtfpLwQPkppNUtq8pSHUrSMlcCXRJMp
    MK2ndT6YpfIksn48Sp1HmBE4jEAt/vAw5BB8Cm9q/PTbMPUdjvHrvYU5X0qg
X-ME-Proxy: <xmx:E4ipas3hrST8h-AwAsa-qI7ObI9eICSUQHV3MVNB_dgonZ9sB1YdaA>
    <xmx:E4ipalhvdGOocJQwexgRHqc2XNrqz2hVFUR44WB9mKTkjulbi-uU1A>
    <xmx:E4ipangojBnbKKm3-r-rAro-IDWMxq0tcLuyQXEpprsHtrwKyk3Q8g>
    <xmx:E4ipahIhHjbDseO8xs06MVHiIqbhEDYyIzw6froE5hhiM_cPc1yHMQ>
    <xmx:E4ipaoDcLUURKCOzO6J6ZHvyF9KmgQZFKhRAdUTpdZVlGzil6OQuuMM_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 14:01:52 -0400 (EDT)
Date: Tue, 15 Sep 2026 12:01:48 -0600
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
 <kvm@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Message-ID: <20260915120148.7548a8ca@shazbot.org>
In-Reply-To: <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
References: <20260905081116.106613-1-zhiw@nvidia.com>
	<20260905081116.106613-13-zhiw@nvidia.com>
	<DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
	<20260914121217.70fa0d93@shazbot.org>
	<DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 23:36:24 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Mon Sep 14, 2026 at 8:12 PM CEST, Alex Williamson wrote:
> > Hi Danilo,
> >
> > On Fri, 11 Sep 2026 22:39:16 +0200
> > "Danilo Krummrich" <dakr@kernel.org> wrote:
> >  
> >> Hi Alex, Jason, Zhi,
> >> 
> >> On Sat Sep 5, 2026 at 10:11 AM CEST, Zhi Wang wrote:  
> >> > NVIDIA vGPU VFs require their open, reset, and close lifecycle to be
> >> > coordinated with the PF-side nova-core driver.    
> >> 
> >> [...]
> >>   
> >> >  drivers/vfio/pci/nvidia-vgpu/main.c   | 253 ++++++++++++++++++++++++++    
> >> 
> >> This is going to be a longer response; sorry about this in advance.
> >> 
> >> Looking at the FFI boundary introduced in the previous patch, I'm concerned that
> >> it translates the driver model relationships we've expressed through Rust's
> >> ownership and lifetime model back into raw pointers and lifetime assumptions
> >> that callers must uphold. It also introduces manual lifecycle management across
> >> the boundary, rather than preserving nova-core's RAII-based ownership model.
> >> 
> >> I think implementing the NVIDIA vGPU driver in Rust would let us preserve those
> >> relationships across the interface, make lifecycle management less error-prone,
> >> and fit naturally alongside nova-core and nova-drm.  
> > [snip]  
> >> 
> >> If you've made it this far, thanks for reading through this long write-up. I
> >> hope you find it useful. Please let me know if you have any questions or
> >> thoughts.  
> >
> > I can't really say I made it this far with comprehension, but thanks
> > for the effort ;)
> >
> > The one piece here that I can actually review is [5], where
> > dev_get_drvdata() is replaced with a vfio-pci-core struct pointer
> > embedded in the struct pci_dev, which is a non-starter as far as having
> > a common PCI-core shared by various drivers.  
> 
> Well, that was just a quick hack to get it out of the way. :)
> 
> I think there are a couple of options.
> 
>   (1) Make the PM helpers take a struct vfio_pci_core_device * in the first
>       place and let the driver forward to the helpers in its own PM callbacks.
> 
>   (2) Provide an (optional?) driver callback that translates a struct pci_dev to
>       struct vfio_pci_core_device.
> 
>   (3) Provide a macro for drivers to define PM ops, letting drivers provide the
>       function that translates struct pci_dev to struct vfio_pci_core_device.
> 
>   (4) Give struct vfio_pci_core_device its own PM domain (which is probably a
>       bit overkill :).
> 
> I understand that the idea is to hide the PM handling in the vfio-pci framwork,
> but I think the existing implementation is a bit of a layering violation, since
> class device implementations shouldn't impose requirements on the bus device
> private data layout.
> 
> I also think that the approach to fully hide it in the framework is only really
> worth if it doesn't otherwise impose subtle requirements on the driver (such as
> the layout requirement of the bus device private data).
> 
> Thus, I'd personally just go with (1) as it is the most honest approach in terms
> of driver layering. But I think (2) is a good alternative that is not more
> invasive than asking drivers to set the bus device private data to
> struct vfio_pci_core_device *.

I'd position this more as a library convention than a class layering
violation.  vfio-pci was originally one driver, vfio-pci-core was
pulled out to enable device specific support, ex. migration, in a more
manageable way.  struct vfio_pci_core_device is not strictly a class,
it's the object used by the library that variant drivers opt to use
rather than re-implementing vfio-pci from the ground up.

The conventions of that library mean variant drivers get things like
VGA routing and power management for free, in adherence with how these
features are exported by the core, and can choose to opt-in to common
error handling.

The use of drvdata is part of that convention and audited by the core
such that failed compliance is rejected on registration.  Clearly we
could allow variant drivers to provide ops for their own callbacks and
export core helpers they can use, but only a Rust driver requires this
and we need to figure out how to do this without degrading the audit in
the core.

Turning vfio-pci-core into a proper class to be able to have a real
layering violation claim seems like a much larger project.

> > My concerns are of course who is going to review the Rust vfio-pci
> > variant drivers from a vfio perspective, not just a drm driver
> > viewpoint.  
> 
> I did put some considerations about this; I think Zhi would be a great candidate
> for this. :) And as mentioned I can also take some of the responsibility, but I
> also want to be honest about the fact that I have a lot on my plate already.

And that's part of the problem, there are bandwidth issues all around
and neither you nor Zhi are, as of yet, core vfio contributors.  Rust
may well be the better approach relative to the interface to Nova-core,
but it's not clear it's the right approach for a subsystem that can't
maintain or evaluate it and only has a sketch of what it looks like.

> > Who is going to be responsive when the interfaces break and
> > monitor vfio proactively to prevent such breakages, and how do we avoid
> > derailing feature development in the core code base.  
> 
> In practice we shouldn't see any breakages with the Rust code that wouldn't also
> break the C VFIO drivers. If this would be the case it would mean that the Rust
> code relies on guarantees that none of the C drivers rely on, which would likely
> mean that is was never a guarantee that was actually promised by the VFIO core
> code.

s/practice/theory/

> There may be cases where Rust code breaks, and C code won't, but those should be
> mechanical things, such as a type mismatch where Rust is more careful, e.g. if
> we'd change a CPP define to an enum, etc.

This seems like a very optimistic outlook.  I don't have experience
with Rust to claim otherwise, but I do have general software experience
to be suspicious of anything sounding so clean.

> > Can a Rust vfio-pci variant driver be self-contained, or to what extent does
> > it impose on the framework, such as the drvdata idiom.  
> 
> As mentioned above, I think this one is more of a layering violation in the
> vfio-pci-core; class devices shouldn't impose layout requirements on bus device
> private data.
> 
> The reason C drivers can get away with it more easily is e.g. that C relies on
> procedural cleanup and that all responsibility for managing lifetimes sits on
> the drivers themselves, so it is easier for them to adjust. But in general, it
> wouldn't work out if all class device registrations or other core primitives
> would have the same expectation.
> 
> For Rust specifically it is that the driver core controls the lifetime of the
> bus device private data, which is a fundamental requirement to e.g. represent
> registrations as RAII types. E.g. the vfio::pci::Registration has to be stored
> in the bus device private data, such that it is guaranteed to be correctly
> destroyed on driver unbind.

I see, so driver core has its own convention for how Rust drivers must
use drvdata.

> To get back to your question, a Rust vfio-pci variant driver should be
> self-contained. The interface sits in the abstraction that translates the C
> driver API to a Rust driver API. It sometimes can help quite significantly (e.g.
> in terms of how complex the Rust code needs to get in order to actually be safe)
> if the C code does a minor adjustment, but it shouldn't be necessary.

It's not clear to me to what extent these abstractions hinder our
ability to evolve and refactor the C code.  It may not "lock in" the
core API for variant drivers, but it seems it raises the bar that any
significant code refactor likely needs to refactor the abstraction
layer, potentially the Rust variant driver itself, which imposes a
burden on the vfio community that has so far not introduced Rust into
the code base.

> For instance, the only addition to the driver core we have is an additional
> callback in struct device_driver, and in the future an additional pointer in
> struct device_private; none of those couldn't be worked around in some way
> though.
>
> On the other hand there are examples where the Rust introduction motivated
> design improvements on the C side, or bug fixes for issues that were caught
> while writing a safe abstraction. For instance, we recently had some fixes
> around dyn IDs in the PCI and USB core, which both were motivated by Rust code.

I have no doubt that integration with a more structured language would
lead to various improvements.  However, it doesn't seem there are
resources to support it in the short term.

> > FWIW, AI can only go so far to support reviews.  Having the code
> > insight to ask the right questions is essential.  A human in the loop
> > is a requirement.
> >
> > Additionally, if we can't narrow the device matching to only the
> > Nova-core supported VFs,  
> 
> Agreed, and I think that should be possible. Is there a particular case you
> think of where this wouldn't hold?

The modalias scheme only matches on vendor/device ID, subsystem IDs,
base/sub class, and interface.  Nothing in the PCI spec requires that
the VF device ID is different from the PF device ID.  Variant drivers
will often present a larger match surface to avoid the ongoing
maintenance overhead of listing explicit device IDs.  Such an approach
here would put us in the position I noted in the previous reply where
the Rust variant driver needs to fully support these devices via
vfio-pci-core on day one.  Binding GPU PFs to vfio-pci is a current,
valid use case (VFs for some vendors as well).  Thanks,

Alex
