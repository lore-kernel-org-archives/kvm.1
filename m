Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EC34FF62;
	Mon, 14 Sep 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421794; cv=none; b=EDGho1rXS1wXh/zpWUrXxOJL7knxSTLKCaGGf4Lte3P9BP1CFjhLQBvHWZzSyBDwfwmAZKZHxwaQ+sUb13v9kCbj3VPIdp7m0fhZPDykeDqYhZIdBQSftbyans281xH+lSGuLDX6TCdfEMOB8VbW1mUnInmRXWRHiofWjmkuJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421794; c=relaxed/simple;
	bh=AnioWw7q1Gk2OEdqO4xBIuDiSoQ7HvvRHJTuqvLxoB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=GFP8ecsqhCoYogLkFKBfr9VweTX2cPZ/pv+PxGC0QS6x2DGu/Z8iz4vL6UlScUDvlehZavAoGfFEpgqOZEOCgGcsGwrzbbHHyaGfgwDz7Og7ypYJ1q+/ztjeASjDYjfzLe0WZ3cPpuescfOY8Rt0CDWGRLNcQQkQyKoE6W+PYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5uiOsww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5uiOsww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5871F000FF;
	Mon, 14 Sep 2026 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421792;
	bh=tQzlvkSE667FYsd0AwWi8kICrxDPwt/zZjbSRh9Bvy8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=a5uiOswwrGMnm188QxTrMBCppuSlD/7C0DdN+z2NdFU4PWYyMlHit0j52O5I3unHy
	 dt6uQPeRwVCCKnvnYMS9vVRPS4DyTnm+ZaBQnTS7+ZPVFrLW3imAR/VPv2p6b0SPMH
	 hu9favz5sXbNMZkEcq5HUyCjbGq7MQF8PLBiQeIp8Sxasjey54diJJ/AfqlOa5Xxcp
	 Zn38QUqqT0qLJEH2UOE61kvwIGlbhXAzrzyZxgh6wDaAMioNEpubPKQY2wJJcihhKe
	 pHuW5Uz/IUXRpKpKDnwz8ALNIgax2rYPnItTXSwAal4+8YnDGuJr+RmItQl7Ue6+a2
	 4WmWMvtK0vBaQ==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 23:36:24 +0200
Message-Id: <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
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
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <kvm@vger.kernel.org>
To: "Alex Williamson" <alex@shazbot.org>
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
In-Reply-To: <20260914121217.70fa0d93@shazbot.org>

On Mon Sep 14, 2026 at 8:12 PM CEST, Alex Williamson wrote:
> Hi Danilo,
>
> On Fri, 11 Sep 2026 22:39:16 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> Hi Alex, Jason, Zhi,
>>=20
>> On Sat Sep 5, 2026 at 10:11 AM CEST, Zhi Wang wrote:
>> > NVIDIA vGPU VFs require their open, reset, and close lifecycle to be
>> > coordinated with the PF-side nova-core driver. =20
>>=20
>> [...]
>>=20
>> >  drivers/vfio/pci/nvidia-vgpu/main.c   | 253 +++++++++++++++++++++++++=
+ =20
>>=20
>> This is going to be a longer response; sorry about this in advance.
>>=20
>> Looking at the FFI boundary introduced in the previous patch, I'm concer=
ned that
>> it translates the driver model relationships we've expressed through Rus=
t's
>> ownership and lifetime model back into raw pointers and lifetime assumpt=
ions
>> that callers must uphold. It also introduces manual lifecycle management=
 across
>> the boundary, rather than preserving nova-core's RAII-based ownership mo=
del.
>>=20
>> I think implementing the NVIDIA vGPU driver in Rust would let us preserv=
e those
>> relationships across the interface, make lifecycle management less error=
-prone,
>> and fit naturally alongside nova-core and nova-drm.
> [snip]
>>=20
>> If you've made it this far, thanks for reading through this long write-u=
p. I
>> hope you find it useful. Please let me know if you have any questions or
>> thoughts.
>
> I can't really say I made it this far with comprehension, but thanks
> for the effort ;)
>
> The one piece here that I can actually review is [5], where
> dev_get_drvdata() is replaced with a vfio-pci-core struct pointer
> embedded in the struct pci_dev, which is a non-starter as far as having
> a common PCI-core shared by various drivers.

Well, that was just a quick hack to get it out of the way. :)

I think there are a couple of options.

  (1) Make the PM helpers take a struct vfio_pci_core_device * in the first
      place and let the driver forward to the helpers in its own PM callbac=
ks.

  (2) Provide an (optional?) driver callback that translates a struct pci_d=
ev to
      struct vfio_pci_core_device.

  (3) Provide a macro for drivers to define PM ops, letting drivers provide=
 the
      function that translates struct pci_dev to struct vfio_pci_core_devic=
e.

  (4) Give struct vfio_pci_core_device its own PM domain (which is probably=
 a
      bit overkill :).

I understand that the idea is to hide the PM handling in the vfio-pci framw=
ork,
but I think the existing implementation is a bit of a layering violation, s=
ince
class device implementations shouldn't impose requirements on the bus devic=
e
private data layout.

I also think that the approach to fully hide it in the framework is only re=
ally
worth if it doesn't otherwise impose subtle requirements on the driver (suc=
h as
the layout requirement of the bus device private data).

Thus, I'd personally just go with (1) as it is the most honest approach in =
terms
of driver layering. But I think (2) is a good alternative that is not more
invasive than asking drivers to set the bus device private data to
struct vfio_pci_core_device *.

> My concerns are of course who is going to review the Rust vfio-pci
> variant drivers from a vfio perspective, not just a drm driver
> viewpoint.

I did put some considerations about this; I think Zhi would be a great cand=
idate
for this. :) And as mentioned I can also take some of the responsibility, b=
ut I
also want to be honest about the fact that I have a lot on my plate already=
.

> Who is going to be responsive when the interfaces break and
> monitor vfio proactively to prevent such breakages, and how do we avoid
> derailing feature development in the core code base.

In practice we shouldn't see any breakages with the Rust code that wouldn't=
 also
break the C VFIO drivers. If this would be the case it would mean that the =
Rust
code relies on guarantees that none of the C drivers rely on, which would l=
ikely
mean that is was never a guarantee that was actually promised by the VFIO c=
ore
code.

There may be cases where Rust code breaks, and C code won't, but those shou=
ld be
mechanical things, such as a type mismatch where Rust is more careful, e.g.=
 if
we'd change a CPP define to an enum, etc.

> Can a Rust vfio-pci variant driver be self-contained, or to what extent d=
oes
> it impose on the framework, such as the drvdata idiom.

As mentioned above, I think this one is more of a layering violation in the
vfio-pci-core; class devices shouldn't impose layout requirements on bus de=
vice
private data.

The reason C drivers can get away with it more easily is e.g. that C relies=
 on
procedural cleanup and that all responsibility for managing lifetimes sits =
on
the drivers themselves, so it is easier for them to adjust. But in general,=
 it
wouldn't work out if all class device registrations or other core primitive=
s
would have the same expectation.

For Rust specifically it is that the driver core controls the lifetime of t=
he
bus device private data, which is a fundamental requirement to e.g. represe=
nt
registrations as RAII types. E.g. the vfio::pci::Registration has to be sto=
red
in the bus device private data, such that it is guaranteed to be correctly
destroyed on driver unbind.

To get back to your question, a Rust vfio-pci variant driver should be
self-contained. The interface sits in the abstraction that translates the C
driver API to a Rust driver API. It sometimes can help quite significantly =
(e.g.
in terms of how complex the Rust code needs to get in order to actually be =
safe)
if the C code does a minor adjustment, but it shouldn't be necessary.

For instance, the only addition to the driver core we have is an additional
callback in struct device_driver, and in the future an additional pointer i=
n
struct device_private; none of those couldn't be worked around in some way
though.

On the other hand there are examples where the Rust introduction motivated
design improvements on the C side, or bug fixes for issues that were caught
while writing a safe abstraction. For instance, we recently had some fixes
around dyn IDs in the PCI and USB core, which both were motivated by Rust c=
ode.

> FWIW, AI can only go so far to support reviews.  Having the code
> insight to ask the right questions is essential.  A human in the loop
> is a requirement.
>
> Additionally, if we can't narrow the device matching to only the
> Nova-core supported VFs,

Agreed, and I think that should be possible. Is there a particular case you
think of where this wouldn't hold?
