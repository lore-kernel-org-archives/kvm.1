Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D76595752;
	Wed, 16 Sep 2026 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573122; cv=none; b=mllUXoEmHe20a8LbMTWOyFaXl/7ckYY9iagiN9P4NTiuz4nd/oLup7XLBAEgIXMRqsHmwYHvLuqjoBPr9H2ivZpAoJ1HyQ8Y9j+64E4D0kjlalfHHs2zDaNvzzdjWhQ+UkRi+NxDwmqA11Q0DavuFjWnH8lSmrnblKCUVqywAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573122; c=relaxed/simple;
	bh=LWBhLxxhDGLUgl9+FgGhc+1pFfsBdn5xXnETFiFtZWE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=kPQtD+6p2rcNuJM9TGAj6WPcrJOh7MFDj6EHv+6mtqoD7AdFaWgEcR1r2FNANzbfNZZYls9gUFqy/yi+VwVFpitA4RsVob9+vIPHRgqww3jMr+ddhu4UH5adaebDMkSFPYu0joDtR/R5CcuoFcrCzByLWc4KfjILHTx92CsLDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yka/rZnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yka/rZnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE7E1F0089A;
	Wed, 16 Sep 2026 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573109;
	bh=EPCONZRiEdb85UDk6nSXxb7+/XaFdek1rKB9RkHrd20=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=Yka/rZnhDxSsqObpBfY993AqhMd7JE15GrPhYGt74fIX3tJaxvt3M7uULOraogjXa
	 VYjBkjbnJFzyhSopg5joWrf0WS+y9Ftfm6p5WN93sdCMekjk5lBhepeGuyU2l3stb3
	 fmEMT+b7DsarJ4S/LODDsGXybv7+uQU5wHMfBzpyC6+imFB6LTVjJDTRPUebQnDslM
	 8g68hF3Qp6r54dnE6dZiTABtdHClX+FFoZkmHwyi9YIx2mjTBn5CDl5UM00lP8EXTi
	 4h1IySLZS2KKRwHPj89j6bO6dm1r82e+tO1I5/5YMewDcvSj7Q8CyuK7w8Nv4iphVq
	 eS9hOBxMnJBUQ==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 17:38:21 +0200
Message-Id: <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
In-Reply-To: <20260916141718.GU3968357@nvidia.com>

On Wed Sep 16, 2026 at 4:17 PM CEST, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2026 at 11:19:01PM +0200, Danilo Krummrich wrote:
>
>> The driver_data pointer in struct device is defined to be a pointer wher=
e a
>> driver can store *arbitrary* data for the duration the driver is bound t=
o this
>> device.
>
> There are places in the kernel where the drvdata of the bound device
> ends up owned by the subsystem, not the end driver.  Yes, an ideal
> driver + subsystem should never even need drvdatab beyond remove. Yet,
> things are not perfect..
>
> The fundamental issue is some kernel API surfaces that the subystem
> needs to work with only provide a struct device in their callbacks and
> the subystem has no option but to use the drvdata for its own purpose
> to recover the subsystem specific data.
>
> For example VFIO hooks into this nasty API:
>
>         ret =3D vga_client_register(pdev, vfio_pci_set_decode);
>         if (ret)
>                 return ret;
>
> Which doesn't provide a void * token to pass the core code's
> struct.=20
>
> Another is all the PCI callbacks which assume the op behind them uses
> drvdata to get its data.

This is where the class (i.e. vfio-pci) should instead take a driver callba=
ck,
as only the driver really knowns about the layering details.

Usually, class device implementations can't make assumptions of the underly=
ing
bus, because they have to work for any bus. I.e. there's no other way than
providing helpers and letting drivers do the glue code between the bus and =
the
class device.

> It is not necessarily easy to fix. Rrouting all those PCI callbacks
> through trampolines in every single driver is really not an appealing
> design. There are alot of VFIO drivers.

The reason this seems undesirable from a vfio-pci perspective is that it is
special in the sense that it is a class device that is specifically built t=
o sit
on top of a spcific bus device (i.e. struct pci_dev).

Since this is a rare (maybe even unique?) edge case, the driver core has in=
deed
no infrastructure in place to represent this.

> Maybe it needs a dev->drvdata and dev->subsystem_data, maybe it needs
> some PCI thing where the pm ops can get a void *, IDK.

It still makes me think that there should be some closer integration of vfi=
o-pci
with the PCI core, as it is specifically built for this bus.

In fact, what you say above is the generalization of my "hack" [1], which, =
the
more I think about this, seems actually less of a hack. :)

I would object a bit to the generalization with dev->subsystem_data as it
screams for abuse, but the thing in [1] seems more and more reasonable to m=
e.

(Another option would be to really split it up and have a virtual vfio-pci =
bus
on top of PCI, which would also allow for custom match logic, but that also
seems pretty overkill.)

>> As mentoined above, there are people volunteering now. Without starting =
it, it
>> can't scale further than that. :)
>
> There are lots of other vfio patches that need attention too, and it
> seems we are short of that more than anything. Now you need to do a
> bunch of C refactoring patches as well just to get things ready to
> show a bunch of rust code. It is a lot of work.

It's only the drvdata thing, what else is missing?

> I don't really understand in a nutshell why we should do this for nova
> the mails were so long... Can we not just ignore the lifetime
> imperfection for this?

I mentioned some points in the first two paragraphs of [2]. Besides that, I
don't see a reason why we should spend time and effort for working out the
inferior solution, where the better alternative is even less effort, contri=
butes
to better quality and stability of the whole driver project and also offers=
 a
chance for the vfio subsystem to gain new contributors and gather experienc=
e
with the language that has proven itself in many areas already.

I mean, there'd still be the option to make it an experiment and say let's =
add
the abstractions and the nvidia-vgpu driver and see how it works out for a =
while
before allowing more Rust drivers. And if it really turns out to be bad, it
should also be easy to rip it out, replace nvidia-vgpu with a C driver and =
throw
in a crappy FFI layer. :)

>> However, I don't really see the use-case; you can't load nvidia-vgpu wit=
hout
>> nova-core in the first place, so it would require to unbind nova-core th=
rough
>> sysfs force unbind, no?
>
> nvidia gpu is a more unique scenario, if you are building a general
> bindings it has to support the flows like this.

Sure, as mentioned, the code I sketched up should already be able to do thi=
s.

> I've wanted to rework the way the common ops are shimmed in for a
> while, you'd probably want to do that before rust bindings.

TBH, I don't think it makes a difference; having Rust abstractions is prett=
y
much the same as having another driver. I.e. it would be equivalent to sayi=
ng
"before we accept another pci-vfio driver we need to do some rework".

Actually, I even think it can be an advantage, as you could think of the Ru=
st
abstractions like a driver with built-in correctness checks, so it can help=
 to
validate the changes.

Of course, this requires the responsibles of the Rust code to help with tha=
t and
I think we have this commitment.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?=
id=3D76b3bfd6386a01f338780e1a37b5bad3f5a48d31
[2] https://lore.kernel.org/nova-gpu/DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org/
