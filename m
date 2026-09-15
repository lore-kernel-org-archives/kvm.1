Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253624562A9;
	Tue, 15 Sep 2026 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507152; cv=none; b=Ts2HIaIIBerm3MpWF/BJDdhldXxePhD9Odo0ceLkaV/p94H7QOaTyNtPNc8jgQDsk6RqRYjq5BGeDpcyuQSqubniQ1aDvSPUZ6zDl8ueOFYfpEfKuweWb4O/ovDueUIs8hqt7S/UlCggX2Wl+yNlo9RxZaikOcPv8uZzP3bORgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507152; c=relaxed/simple;
	bh=OKqZ9LeTYZpcBo/ZETo7mVIss6ggTXnaMF7+84oZoLc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=TI50FuYISFBeF1fEJCFgF2IscNhAYBRAMs2K3Y3vsvylJnOOkkDX5ss03FER5esWWMxIfMkjqiv4YZQiuLWYiKbxOV2jgL9NSRTsMnEuI22xDj6DqcXnVbwqOymmIbNWPIK2FYx+EaE93GLDRQnahK9ON0vELfRH/gIHCnuMd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+CMwM6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+CMwM6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D061F000FF;
	Tue, 15 Sep 2026 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789507149;
	bh=2U/QLuurvslretB9I/twinObx3n+Se5WhEV5TaIx2pU=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=E+CMwM6M2FWVL3KtBmXv8v7OCHE603hiibZCHDlNM2t+Ug9OgHI8jxT1V+2CSIEYF
	 5gY2QQw47+MJhrOQeMum7rrGAsQy0zT32RNYutpNY03CZDJLWfVGREAnY+E+j8KSLV
	 FqAjIoyNtajy/Ejjy1O06M3gNDfIuuKnen0XuFBXGpmbSv3blL+mDXsPJKTZOARVW3
	 EBCrLVmcwuHCx+0v88rw+jxr19JyYAb4FlGc9qKpowpJP0udAirA9kb+pd0OG6IrQt
	 TJQZrPRYRnCdQ8TJfHQ9EMxtF+KueWGKf2b4VpZJxvpPie0aLXhmzzAN/8I4NbJClV
	 ZvpFW1in5nW8A==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 23:19:01 +0200
Message-Id: <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
To: "Alex Williamson" <alex@shazbot.org>
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
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
In-Reply-To: <20260915120148.7548a8ca@shazbot.org>

On Tue Sep 15, 2026 at 8:01 PM CEST, Alex Williamson wrote:
> On Mon, 14 Sep 2026 23:36:24 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Mon Sep 14, 2026 at 8:12 PM CEST, Alex Williamson wrote:
>> > Hi Danilo,
>> >
>> > On Fri, 11 Sep 2026 22:39:16 +0200
>> > "Danilo Krummrich" <dakr@kernel.org> wrote:
>> > =20
>> >> Hi Alex, Jason, Zhi,
>> >>=20
>> >> On Sat Sep 5, 2026 at 10:11 AM CEST, Zhi Wang wrote: =20
>> >> > NVIDIA vGPU VFs require their open, reset, and close lifecycle to b=
e
>> >> > coordinated with the PF-side nova-core driver.   =20
>> >>=20
>> >> [...]
>> >>  =20
>> >> >  drivers/vfio/pci/nvidia-vgpu/main.c   | 253 ++++++++++++++++++++++=
++++   =20
>> >>=20
>> >> This is going to be a longer response; sorry about this in advance.
>> >>=20
>> >> Looking at the FFI boundary introduced in the previous patch, I'm con=
cerned that
>> >> it translates the driver model relationships we've expressed through =
Rust's
>> >> ownership and lifetime model back into raw pointers and lifetime assu=
mptions
>> >> that callers must uphold. It also introduces manual lifecycle managem=
ent across
>> >> the boundary, rather than preserving nova-core's RAII-based ownership=
 model.
>> >>=20
>> >> I think implementing the NVIDIA vGPU driver in Rust would let us pres=
erve those
>> >> relationships across the interface, make lifecycle management less er=
ror-prone,
>> >> and fit naturally alongside nova-core and nova-drm. =20
>> > [snip] =20
>> >>=20
>> >> If you've made it this far, thanks for reading through this long writ=
e-up. I
>> >> hope you find it useful. Please let me know if you have any questions=
 or
>> >> thoughts. =20
>> >
>> > I can't really say I made it this far with comprehension, but thanks
>> > for the effort ;)
>> >
>> > The one piece here that I can actually review is [5], where
>> > dev_get_drvdata() is replaced with a vfio-pci-core struct pointer
>> > embedded in the struct pci_dev, which is a non-starter as far as havin=
g
>> > a common PCI-core shared by various drivers. =20
>>=20
>> Well, that was just a quick hack to get it out of the way. :)
>>=20
>> I think there are a couple of options.
>>=20
>>   (1) Make the PM helpers take a struct vfio_pci_core_device * in the fi=
rst
>>       place and let the driver forward to the helpers in its own PM call=
backs.
>>=20
>>   (2) Provide an (optional?) driver callback that translates a struct pc=
i_dev to
>>       struct vfio_pci_core_device.
>>=20
>>   (3) Provide a macro for drivers to define PM ops, letting drivers prov=
ide the
>>       function that translates struct pci_dev to struct vfio_pci_core_de=
vice.
>>=20
>>   (4) Give struct vfio_pci_core_device its own PM domain (which is proba=
bly a
>>       bit overkill :).
>>=20
>> I understand that the idea is to hide the PM handling in the vfio-pci fr=
amwork,
>> but I think the existing implementation is a bit of a layering violation=
, since
>> class device implementations shouldn't impose requirements on the bus de=
vice
>> private data layout.
>>=20
>> I also think that the approach to fully hide it in the framework is only=
 really
>> worth if it doesn't otherwise impose subtle requirements on the driver (=
such as
>> the layout requirement of the bus device private data).
>>=20
>> Thus, I'd personally just go with (1) as it is the most honest approach =
in terms
>> of driver layering. But I think (2) is a good alternative that is not mo=
re
>> invasive than asking drivers to set the bus device private data to
>> struct vfio_pci_core_device *.
>
> I'd position this more as a library convention than a class layering
> violation.  vfio-pci was originally one driver, vfio-pci-core was
> pulled out to enable device specific support, ex. migration, in a more
> manageable way.  struct vfio_pci_core_device is not strictly a class,
> it's the object used by the library that variant drivers opt to use
> rather than re-implementing vfio-pci from the ground up.
>
> The conventions of that library mean variant drivers get things like
> VGA routing and power management for free, in adherence with how these
> features are exported by the core, and can choose to opt-in to common
> error handling.
>
> The use of drvdata is part of that convention and audited by the core
> such that failed compliance is rejected on registration.  Clearly we
> could allow variant drivers to provide ops for their own callbacks and
> export core helpers they can use, but only a Rust driver requires this
> and we need to figure out how to do this without degrading the audit in
> the core.

The driver_data pointer in struct device is defined to be a pointer where a
driver can store *arbitrary* data for the duration the driver is bound to t=
his
device.

This is an API contract the driver core provides for the struct device stru=
cture
when used in a bus device (such as struct pci_dev), i.e. it is an API contr=
act
between the driver core and drivers in general.

It is *not* the Rust driver core code breaking a convention here. The Rust
driver core code just relies on its own subsystem's API contract.

The fact that the vfio-pci-core forces vfio-pci drivers to only ever store =
a
struct vfio_pci_core_device pointer there re-defines the driver core's API
contract and therefore is a layering violation.

> Turning vfio-pci-core into a proper class to be able to have a real
> layering violation claim seems like a much larger project.

What you are describing rather sounds to me as if struct vfio_pci_core_devi=
ce
wants to be two things: a bus device layered on top of a PCI device and a c=
lass
device around struct vfio_device. But in this case it should implement a re=
al
bus on top of the PCI bus.

Currently it really is a wrapper around struct vfio_device (and therefore a
class device) which is bending the purpose of the driver's bus device priva=
te
data pointer to make a connection with the real bus device underneath.

>> > My concerns are of course who is going to review the Rust vfio-pci
>> > variant drivers from a vfio perspective, not just a drm driver
>> > viewpoint. =20
>>=20
>> I did put some considerations about this; I think Zhi would be a great c=
andidate
>> for this. :) And as mentioned I can also take some of the responsibility=
, but I
>> also want to be honest about the fact that I have a lot on my plate alre=
ady.
>
> And that's part of the problem, there are bandwidth issues all around and
> neither you nor Zhi are, as of yet, core vfio contributors.

That is true, but I suggest to also see it from the perspective that this e=
ffort
is a good chance to get more people to engage with the VFIO subsystem in th=
e
first place and eventually become experts that also contribute to the C cor=
e.

For the Rust abstraction, there are two competencies needed: knowledge abou=
t
writing a VFIO driver (which Zhi clearly covers) and knowledge about the dr=
iver
model and its Rust implementation specifics as well as the Rust ecosystem i=
n
general (which is why I offered myself to take responsibility).

Remember the VFIO abstractions are translating the C VFIO driver APIs to Ru=
st
APIs for Rust drivers. They don't need to mess with VFIO internals.

>> > Who is going to be responsive when the interfaces break and
>> > monitor vfio proactively to prevent such breakages, and how do we avoi=
d
>> > derailing feature development in the core code base. =20
>>=20
>> In practice we shouldn't see any breakages with the Rust code that would=
n't also
>> break the C VFIO drivers. If this would be the case it would mean that t=
he Rust
>> code relies on guarantees that none of the C drivers rely on, which woul=
d likely
>> mean that is was never a guarantee that was actually promised by the VFI=
O core
>> code.
>
> s/practice/theory/

As mentioned above, the abstractions are translating the C VFIO driver APIs=
 to
Rust APIs for Rust drivers. I.e. they don't use other API than the C driver=
s
use. Thus, code breakages should be limited to what I mentioned below.

>> There may be cases where Rust code breaks, and C code won't, but those s=
hould be
>> mechanical things, such as a type mismatch where Rust is more careful, e=
.g. if
>> we'd change a CPP define to an enum, etc.
>
> This seems like a very optimistic outlook.  I don't have experience
> with Rust to claim otherwise, but I do have general software experience
> to be suspicious of anything sounding so clean.

I maintain some subsystems that have Rust code, and I also maintain Rust co=
de of
subsystems I otherwise do not maintain. I haven't seen anything break so fa=
r
other than for the reasons already mentioned.

Of course, that doesn't mean that mistakes can't happen. For instance, we c=
ould
have the case that the Rust code makes assumptions that the subsystem never
guaranteed in the first place. But that'd be something that could also happ=
en
for any other driver and it would be a bug in the Rust code that the mainta=
iners
of the Rust code have to take responsibility for.

>> > Can a Rust vfio-pci variant driver be self-contained, or to what exten=
t does
>> > it impose on the framework, such as the drvdata idiom. =20
>>=20
>> As mentioned above, I think this one is more of a layering violation in =
the
>> vfio-pci-core; class devices shouldn't impose layout requirements on bus=
 device
>> private data.
>>=20
>> The reason C drivers can get away with it more easily is e.g. that C rel=
ies on
>> procedural cleanup and that all responsibility for managing lifetimes si=
ts on
>> the drivers themselves, so it is easier for them to adjust. But in gener=
al, it
>> wouldn't work out if all class device registrations or other core primit=
ives
>> would have the same expectation.
>>=20
>> For Rust specifically it is that the driver core controls the lifetime o=
f the
>> bus device private data, which is a fundamental requirement to e.g. repr=
esent
>> registrations as RAII types. E.g. the vfio::pci::Registration has to be =
stored
>> in the bus device private data, such that it is guaranteed to be correct=
ly
>> destroyed on driver unbind.
>
> I see, so driver core has its own convention for how Rust drivers must
> use drvdata.

As mentioned above, the driver_data pointer of struct device is specificall=
y
reserved for drivers to store arbitrary data while they are bound to the de=
vice.

The only difference is that in C it is a convention and drivers call
dev_set_drvdata() themselves, whereas in Rust we do it in the driver core c=
ode.

Note that clearing this pointer is also done in the driver core in C in
device_unbind_cleanup().

>> To get back to your question, a Rust vfio-pci variant driver should be
>> self-contained. The interface sits in the abstraction that translates th=
e C
>> driver API to a Rust driver API. It sometimes can help quite significant=
ly (e.g.
>> in terms of how complex the Rust code needs to get in order to actually =
be safe)
>> if the C code does a minor adjustment, but it shouldn't be necessary.
>
> It's not clear to me to what extent these abstractions hinder our
> ability to evolve and refactor the C code.  It may not "lock in" the
> core API for variant drivers, but it seems it raises the bar that any
> significant code refactor likely needs to refactor the abstraction
> layer, potentially the Rust variant driver itself, which imposes a
> burden on the vfio community that has so far not introduced Rust into
> the code base.

In general, if the refactor does not affect C drivers, it shouldn't affect =
the
Rust API either.

If the refactor affects C drivers, it will also affect Rust drivers and the
change in the Rust abstraction could also be more complicated than the chan=
ge
required in the C drivers.

The reason is that we design the Rust APIs at minmum in a way that any arbi=
trary
usage can not produce undefined behavior. Beyond that, we also always try t=
o
design them in a way that it also at least encourages correct semantical us=
e.

So in theory, it could happen that we need to figure out a new way to abstr=
act
the C API in way that can't produce undefined behavior.

But if that happens it should be something minor, e.g. a new callback which
requires a new type state, an argument that requires a new type carrying so=
me
invariants, etc.

The biggest part of the abstraction is the integration in the driver lifecy=
cle,
which is a repeating pattern. For instance, if you look at the fwctl Rust c=
ode
it looks almsot the same.

From my experience maintaining both C and Rust code I can also tell that go=
od
design is pretty straight forward to abstract in Rust to produce a safe API=
; bad
design isn't.

Where good design means APIs with defined ownership, clear lifetime
relationships, and a consistent API surface. Whereas APIs that have unclear
ownership and lifetime relationships and inconsistent API surfaces are a hu=
ge
pain in the butt to abstract.

The reason is that Rust needs to get those things straight somehow in order=
 to
provide a safe API surface. I.e. an underlying bad API design (as defined a=
bove)
needs the Rust implementation to make quite some stretches.

>> For instance, the only addition to the driver core we have is an additio=
nal
>> callback in struct device_driver, and in the future an additional pointe=
r in
>> struct device_private; none of those couldn't be worked around in some w=
ay
>> though.
>>
>> On the other hand there are examples where the Rust introduction motivat=
ed
>> design improvements on the C side, or bug fixes for issues that were cau=
ght
>> while writing a safe abstraction. For instance, we recently had some fix=
es
>> around dyn IDs in the PCI and USB core, which both were motivated by Rus=
t code.
>
> I have no doubt that integration with a more structured language would
> lead to various improvements.  However, it doesn't seem there are
> resources to support it in the short term.

As mentoined above, there are people volunteering now. Without starting it,=
 it
can't scale further than that. :)

>> > FWIW, AI can only go so far to support reviews.  Having the code
>> > insight to ask the right questions is essential.  A human in the loop
>> > is a requirement.
>> >
>> > Additionally, if we can't narrow the device matching to only the
>> > Nova-core supported VFs, =20
>>=20
>> Agreed, and I think that should be possible. Is there a particular case =
you
>> think of where this wouldn't hold?
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

My understanding is that in order to support PFs being bound to the variant
driver the only thing necessary would be to fall back to the vfio-pci-core
callbacks. If that's the case, my PoC code can already do that.

However, I don't really see the use-case; you can't load nvidia-vgpu withou=
t
nova-core in the first place, so it would require to unbind nova-core throu=
gh
sysfs force unbind, no?
