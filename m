Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794B4DF4BA
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515890; cv=pass; b=JGHudLMJZTUNhhK/3lDqc1RooVu+lpWwwxLqVqLijS/9j6okWkys36CWOiTnFZXT6pBbyf+oEhlfC7qf2UtiwPp66ln0xv5glYVheyyziTjnnWv3tOXNFUbjnOv+hLjXR3rnjibolSylgirXg+gjo4yoGa/a/mQMZZAZaS+fTS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515890; c=relaxed/simple;
	bh=TqSdldQQLryc85OugYU8PhBQBy5+xKp2y2mlkv6Wji8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRWKKgSsmO5nvtiLkGQDuMwt81KP2IXi/jIqe2Y54akYVjtTtuXKjBMw55Rl2YggXZZNbryikmlcFvEUZ4t5coKpR2WjDS8EpqV+jP2wgAZJDxjA6aT9iYIkWah+xUiEU8YJToXioPNpR+7iLPz6C+++5q3QiTTC5IiIItwGLLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS5Q/sAE; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS5Q/sAE"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd7so29617385a.2
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789515887; cv=none;
        d=google.com; s=arc-20260327;
        b=GYDVoS2diYSGWGTi4WYXwa/d4QbTPne2j4rAowPoMGAcISpu22CZv+LjhgMGAi8WJl
         5WO75G9qZycCkMUrA46lIjpfVE2+/tYLDrjdOj0rUsNvYvqR4Q880tR8BwCdG0y9zDD8
         HSOf1nOjg2SLrMYKJkQiFNQwESzOQVvpAAefBxKonIHtAX3T0VsNGJAWHNOSlVvclkyH
         UKxLllwWQ6Bglq+ZLJjRP/FIpaGNXAZ46jPT0J7GAR0XmY64TYIjivn1ViUgPc5//xzl
         5yNA1UhW0NknmsGx3b5QLwgF+PSk88CEVs/YIHrfHU5mmDYCHbMC/UCIpjjMMcik23V4
         wB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B6TfHIrWcaSjlSaK3gzPKAx2S0waXFIvqZ2/ZSYC1nc=;
        fh=KtS8qulOBxRoLUq2UBXSjlUV7efM/osj59PqqPmCZLE=;
        b=dxIFyl49WIKgN8HAdMkU8ehVonsCs5ApRRNRw0j/iM7rKHZUSNMhqtfy6PQChG3wgj
         BfYad+CWe6aTPyxXkby+lpP/yF8/IDIZWmA3uGvAvHUpSAxRZX9ioSJziTbldgvO0iUA
         i51GunT7tqMYXMgsauPT06BicZyne45DirX3OACyMHIK92ACVDwsOitzzS9OhQVEBa7l
         0LbzDUEwsst3H5gEVwMcnXBKtJaYxHgRCgLNGbowYXIAWmK7DfGjDyOMWMStIhcugl4n
         j4eHm94iNa93Tq4JraDLFLUP6rplz7dtqpPXMAX1Q37FzoVeS4z3s89sf8qCx4n+LW8L
         JAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789515887; x=1790120687; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6TfHIrWcaSjlSaK3gzPKAx2S0waXFIvqZ2/ZSYC1nc=;
        b=gS5Q/sAE9j6RYviQyDziMdhhgCMTD/6aJn5mSegvtXazzzhE1VrXYkJAKJcWb1ewOk
         nqWCcvkU8zlR9HyqoKPC6m1JN6/7BwNFpKmJfoV9OQX9TSfLm37oqZYpeOjAyjWvnBUU
         tKU8hX+MP7ZKHly1oFr+SbyJlxmScbLqg+n11colrAuLnZjdhmjYddD9vJ88/3xPpmcA
         uOPZ2UVCyb8lg926KuqwFaK0ue9defKXeMLUECqA9XFhOQqRrZWFm0UXVnsLXXiEKvJn
         awRwhb3U+sKojL1Dl1qXfriFHyc3Rc40T+wfh791nYkyTHfBpMzPeYo/btWou6n7RXKv
         tCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515887; x=1790120687;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B6TfHIrWcaSjlSaK3gzPKAx2S0waXFIvqZ2/ZSYC1nc=;
        b=JOzMn55WAJqnnqZqhPprRG5Hwj3cL6EqVQVBQZRJGu/bHEYwPM5kxvaukmQtefOF0/
         Bkm+ZMMgtJwHim6w1ZFDjjOpxgwtA2WWKY8JngB2xHazz/fp0GwQjM9OpjEK73V2gNfE
         1+AxdtFNUvekqLQ3D8Vnp+hO7iZKCvvJtyu3onr3U9d3XVZBv9GNWBp97tyWghkt6gk5
         S6sPTVKzsv+uID2sG22tLnEW6eACMots5Zhyt3EIIDHD3iMrFRybTKrSg7NhfmAGyzZQ
         jaFSSOuq7Y8c4og2J5ku71dGJ+BxzZTz8xxtsIsFpIDDCHcZL7ZsEB9plV1CVBI6w5Hi
         TS+A==
X-Forwarded-Encrypted: i=1; AKwUvBxPoaGU8jrYlXCxls4dPMSFEstcNkEFeYzFT3CcC+gPiHwSvfWR9yLDw9uefoOul7PeYx4=@vger.kernel.org
X-Gm-Message-State: AFuF++kF9nrAsHCmrpo7INgQaeGBnyJ0i8dAIxUYBSMQDK30wsfMsr+t
	QImJE7OxqX3xzsRhejGXeiAUSEvOax6sNTV5PTHOmS/V7T4YSyZa7qTb6tR3dCCVj5o6eifTYPK
	gYJMf6lior54LnLq286oNxOnuU9vjUEg=
X-Gm-Gg: AYBFou3lpsnQIjwuYMxETMaoTIU10C2ApC0LKwTdJxJxos99t7mPa4E65J4QIwWQ8Qn
	roNhhkAWmoOq4BWp7CrhggpNOkOOkLn76FuHwji873rEUs5wTKQ5At9tdFiCmi70fiUSavhOcWp
	g3McchUnB+5izMDBdccFkawWwL4TLCXiaoZZopAna65/vg/h5qqXQcH2EG0fxYanfGhbInwd0yw
	tXIofA2zHw7v6E3EPnoxChgwQKCDYtvDtyQuHASMGIayMGxd7isgjtrZE5aILpi9pZhklk55jpQ
	8txQ4wyeTRikVHmxDNEuX6euWcrmEmNiblXXjcCHOxc+rmaKUQIKQF8aXYNnFfdHVUn+rGwt4cW
	kmrtNY9DMPBOJRW676qRrEccbaNjCXoxbdQvbStv90Q==
X-Received: by 2002:a05:620a:1714:b0:939:c71d:8d15 with SMTP id
 af79cd13be357-93bb77393c7mr73658085a.14.1789515887369; Tue, 15 Sep 2026
 16:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905081116.106613-1-zhiw@nvidia.com> <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org> <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org> <20260915120148.7548a8ca@shazbot.org>
In-Reply-To: <20260915120148.7548a8ca@shazbot.org>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 16 Sep 2026 09:44:35 +1000
X-Gm-Features: AcwNN1XzQ-BZPu-XH_LtSpgUCt0nAgXSDd_qK7yHBARKrtQdy7wMvT4f843zA9s
Message-ID: <CAPM=9tzwkNniadSABL-EfLn1hKyw3Am=seX7vJjJbXci_5vSUA@mail.gmail.com>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO variant driver
To: Alex Williamson <alex@shazbot.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	acourbot@nvidia.com, yishaih@nvidia.com, skolothumtho@nvidia.com, 
	kevin.tian@intel.com, simona@ffwll.ch, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, jhubbard@nvidia.com, 
	ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, 
	alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, nova-gpu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhiwang@kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sept 2026 at 04:01, Alex Williamson <alex@shazbot.org> wrote:
>
> On Mon, 14 Sep 2026 23:36:24 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
> > On Mon Sep 14, 2026 at 8:12 PM CEST, Alex Williamson wrote:
> > > Hi Danilo,
> > >
> > > On Fri, 11 Sep 2026 22:39:16 +0200
> > > "Danilo Krummrich" <dakr@kernel.org> wrote:
> > >
> > >> Hi Alex, Jason, Zhi,
> > >>
> > >> On Sat Sep 5, 2026 at 10:11 AM CEST, Zhi Wang wrote:
> > >> > NVIDIA vGPU VFs require their open, reset, and close lifecycle to be
> > >> > coordinated with the PF-side nova-core driver.
> > >>
> > >> [...]
> > >>
> > >> >  drivers/vfio/pci/nvidia-vgpu/main.c   | 253 ++++++++++++++++++++++++++
> > >>
> > >> This is going to be a longer response; sorry about this in advance.
> > >>
> > >> Looking at the FFI boundary introduced in the previous patch, I'm concerned that
> > >> it translates the driver model relationships we've expressed through Rust's
> > >> ownership and lifetime model back into raw pointers and lifetime assumptions
> > >> that callers must uphold. It also introduces manual lifecycle management across
> > >> the boundary, rather than preserving nova-core's RAII-based ownership model.
> > >>
> > >> I think implementing the NVIDIA vGPU driver in Rust would let us preserve those
> > >> relationships across the interface, make lifecycle management less error-prone,
> > >> and fit naturally alongside nova-core and nova-drm.
> > > [snip]
> > >>
> > >> If you've made it this far, thanks for reading through this long write-up. I
> > >> hope you find it useful. Please let me know if you have any questions or
> > >> thoughts.
> > >
> > > I can't really say I made it this far with comprehension, but thanks
> > > for the effort ;)
> > >
> > > The one piece here that I can actually review is [5], where
> > > dev_get_drvdata() is replaced with a vfio-pci-core struct pointer
> > > embedded in the struct pci_dev, which is a non-starter as far as having
> > > a common PCI-core shared by various drivers.
> >
> > Well, that was just a quick hack to get it out of the way. :)
> >
> > I think there are a couple of options.
> >
> >   (1) Make the PM helpers take a struct vfio_pci_core_device * in the first
> >       place and let the driver forward to the helpers in its own PM callbacks.
> >
> >   (2) Provide an (optional?) driver callback that translates a struct pci_dev to
> >       struct vfio_pci_core_device.
> >
> >   (3) Provide a macro for drivers to define PM ops, letting drivers provide the
> >       function that translates struct pci_dev to struct vfio_pci_core_device.
> >
> >   (4) Give struct vfio_pci_core_device its own PM domain (which is probably a
> >       bit overkill :).
> >
> > I understand that the idea is to hide the PM handling in the vfio-pci framwork,
> > but I think the existing implementation is a bit of a layering violation, since
> > class device implementations shouldn't impose requirements on the bus device
> > private data layout.
> >
> > I also think that the approach to fully hide it in the framework is only really
> > worth if it doesn't otherwise impose subtle requirements on the driver (such as
> > the layout requirement of the bus device private data).
> >
> > Thus, I'd personally just go with (1) as it is the most honest approach in terms
> > of driver layering. But I think (2) is a good alternative that is not more
> > invasive than asking drivers to set the bus device private data to
> > struct vfio_pci_core_device *.
>
> I'd position this more as a library convention than a class layering
> violation.  vfio-pci was originally one driver, vfio-pci-core was
> pulled out to enable device specific support, ex. migration, in a more
> manageable way.  struct vfio_pci_core_device is not strictly a class,
> it's the object used by the library that variant drivers opt to use
> rather than re-implementing vfio-pci from the ground up.

Not to be critical of an evolved design, vfio-pci-core should probably
be structured as a series of helpers that drivers can use, rather than
a midlayer. Midlayers plagued us in drm, let drivers drive and provide
the VGA/PM interfaces using standard vfio-pci-core methods rather than
forcing vfio-pci-core to own the pci device data.

Just because C let's us take shortcuts with struct layouts and
pointers, it doesn't mean it's a clean pattern we want to continue
with indefinitely. You can look at the rust use of the subsystem as a
chance to clean up some of the corners where layers aren't clean.

I just threw opencode at the refactor and for $12 of my massive budget
it produced

the prompt was:
"in linux/drivers/vfio/pci the vfio pci core decides that drivers must
install a vfio_pci_core_device struct to drvdata, this feels like a
layering violation, I'd like the vfio pci core to be a set of helpers
the drivers use instead of midlayering itself, can you plan that out
and then execute"

 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 54
++++++++++++++++++++++++++++++++++++++----------------
 drivers/vfio/pci/ism/main.c                    | 45
++++++++++++++++++++++++++++++++++++---------
 drivers/vfio/pci/mlx5/main.c                   | 39
++++++++++++++++++++++++++++++++-------
 drivers/vfio/pci/nvgrace-gpu/main.c            | 45
+++++++++++++++++++++++++++++++++++----------
 drivers/vfio/pci/pds/pci_drv.c                 | 34
+++++++++++++++++++++++++++++++---
 drivers/vfio/pci/pds/vfio_dev.c                |  5 +----
 drivers/vfio/pci/qat/main.c                    | 38
++++++++++++++++++++++++++++++++------
 drivers/vfio/pci/vfio_pci.c                    | 34
++++++++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_core.c               | 66
+++++++++++++++++++++++-------------------------------------------
 drivers/vfio/pci/virtio/main.c                 | 34
+++++++++++++++++++++++++++++++---
 drivers/vfio/pci/xe/main.c                     | 34
+++++++++++++++++++++++++++++++---
 11 files changed, 322 insertions(+), 106 deletions(-)

It seems to be correct code, and makes things look more like drivers
owning the outer structs. I did look for this pattern elsewhere in the
kernel and it's not common at all, in fact my quick search couldn't
spot any other instances which again suggests it's not a pattern we
should be leaning into.

As for the rust stuff, I think for vfio your drivers are just not that
much of a horror show or refactoring often enough that rust will be
anything but a blip on your radar, having Zhi/Danilo and access to any
sort of LLM will generally make most refactors trivial, lots of
maintainers keep bringing up the same concerns about refactors and
interfaces and breakage, but I'm not seeing the problems, and most of
the refactors that are rust driven are make the C code clearer.

Dave.


>
> > > Can a Rust vfio-pci variant driver be self-contained, or to what extent does
> > > it impose on the framework, such as the drvdata idiom.
> >
> > As mentioned above, I think this one is more of a layering violation in the
> > vfio-pci-core; class devices shouldn't impose layout requirements on bus device
> > private data.
> >
> > The reason C drivers can get away with it more easily is e.g. that C relies on
> > procedural cleanup and that all responsibility for managing lifetimes sits on
> > the drivers themselves, so it is easier for them to adjust. But in general, it
> > wouldn't work out if all class device registrations or other core primitives
> > would have the same expectation.
> >
> > For Rust specifically it is that the driver core controls the lifetime of the
> > bus device private data, which is a fundamental requirement to e.g. represent
> > registrations as RAII types. E.g. the vfio::pci::Registration has to be stored
> > in the bus device private data, such that it is guaranteed to be correctly
> > destroyed on driver unbind.
>
> I see, so driver core has its own convention for how Rust drivers must
> use drvdata.
>
> > To get back to your question, a Rust vfio-pci variant driver should be
> > self-contained. The interface sits in the abstraction that translates the C
> > driver API to a Rust driver API. It sometimes can help quite significantly (e.g.
> > in terms of how complex the Rust code needs to get in order to actually be safe)
> > if the C code does a minor adjustment, but it shouldn't be necessary.
>
> It's not clear to me to what extent these abstractions hinder our
> ability to evolve and refactor the C code.  It may not "lock in" the
> core API for variant drivers, but it seems it raises the bar that any
> significant code refactor likely needs to refactor the abstraction
> layer, potentially the Rust variant driver itself, which imposes a
> burden on the vfio community that has so far not introduced Rust into
> the code base.
>
> > For instance, the only addition to the driver core we have is an additional
> > callback in struct device_driver, and in the future an additional pointer in
> > struct device_private; none of those couldn't be worked around in some way
> > though.
> >
> > On the other hand there are examples where the Rust introduction motivated
> > design improvements on the C side, or bug fixes for issues that were caught
> > while writing a safe abstraction. For instance, we recently had some fixes
> > around dyn IDs in the PCI and USB core, which both were motivated by Rust code.
>
> I have no doubt that integration with a more structured language would
> lead to various improvements.  However, it doesn't seem there are
> resources to support it in the short term.
>
> > > FWIW, AI can only go so far to support reviews.  Having the code
> > > insight to ask the right questions is essential.  A human in the loop
> > > is a requirement.
> > >
> > > Additionally, if we can't narrow the device matching to only the
> > > Nova-core supported VFs,
> >
> > Agreed, and I think that should be possible. Is there a particular case you
> > think of where this wouldn't hold?
>
> The modalias scheme only matches on vendor/device ID, subsystem IDs,
> base/sub class, and interface.  Nothing in the PCI spec requires that
> the VF device ID is different from the PF device ID.  Variant drivers
> will often present a larger match surface to avoid the ongoing
> maintenance overhead of listing explicit device IDs.  Such an approach
> here would put us in the position I noted in the previous reply where
> the Rust variant driver needs to fully support these devices via
> vfio-pci-core on day one.  Binding GPU PFs to vfio-pci is a current,
> valid use case (VFs for some vendors as well).  Thanks,
>
> Alex
