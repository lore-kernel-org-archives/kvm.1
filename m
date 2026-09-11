Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325D5A9865;
	Fri, 11 Sep 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159177; cv=none; b=SZl5UwCqQPDwp000sfngzzIO4Pqllo66G4ZYMO2or74PlnJrxvX/ihFIRNkUFNoYTaU+HxyYo8LSI+wdzL2dd1uE/1iAXZLlVHUcR/1mxiPWx7k4gbXqShT3JM/cfOUthgY2O0+zP+NtRvv1jmgcl/Hurqco7b4iN/EzlVeJ3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159177; c=relaxed/simple;
	bh=9eQ70rrlm+UIzi69eXj0FMj8Lr8EIqnLrkhPp0RtJUo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=sHmSsuRIkpU/5pNKyCtkxJW8am1OeeTpFqLF1tQpt8fwvs3l/vrrsux27dmEXK22DW/68ZUH6wR/SVygCbk49MnQcMuAQSMyNlBGYHoe3YQklc1/59Tvwo7Q9b0DoE02JAHIF0qxUJfTD2ZDKaF1/1XKTtZNT+paplSzW/CZVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4GxQ/iE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4GxQ/iE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846F21F00893;
	Fri, 11 Sep 2026 20:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789159166;
	bh=M0d7x+HLiZhpQbzGJPmfrAYEQmdiGiQus6Ye9vtWVw0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=c4GxQ/iELZV2z0Q5qikbglgDYGDuhi5csYeLAy1KBpUv6k3wUYytRwsB1FbaHomWP
	 3NNUEo4p2aqXehTYsMkL78nTc4GtOPMw6zbNgKWCzoaoStNipCeuUa5MUjAQbemvzr
	 allPIaNdKDS1U8BrgPKBS9IKH/aRdhFQY1gOr581nxKp7vjtEfmht48gLdvk3+JzN5
	 Y3fA9IbNirW9CqRy5nKG8T9P71V8ixf+DW5vOLdCKr9RHhfsMVqwZ+zKBim+dkZ7GT
	 Rlgq5mmjyh7Tq57nSvoMRdfJ5+mVyyqxPj/thxd6DbiiZPvLlA5qT7e97X4nPbO0RW
	 0AYHoZUU/W6ag==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 22:39:16 +0200
Message-Id: <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Cc: <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <kvm@vger.kernel.org>
To: "Alex Williamson" <alex@shazbot.org>, "Jason Gunthorpe"
 <jgg@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
In-Reply-To: <20260905081116.106613-13-zhiw@nvidia.com>

Hi Alex, Jason, Zhi,

On Sat Sep 5, 2026 at 10:11 AM CEST, Zhi Wang wrote:
> NVIDIA vGPU VFs require their open, reset, and close lifecycle to be
> coordinated with the PF-side nova-core driver.

[...]

>  drivers/vfio/pci/nvidia-vgpu/main.c   | 253 ++++++++++++++++++++++++++

This is going to be a longer response; sorry about this in advance.

Looking at the FFI boundary introduced in the previous patch, I'm concerned=
 that
it translates the driver model relationships we've expressed through Rust's
ownership and lifetime model back into raw pointers and lifetime assumption=
s
that callers must uphold. It also introduces manual lifecycle management ac=
ross
the boundary, rather than preserving nova-core's RAII-based ownership model=
.

I think implementing the NVIDIA vGPU driver in Rust would let us preserve t=
hose
relationships across the interface, make lifecycle management less error-pr=
one,
and fit naturally alongside nova-core and nova-drm.

I did sketch up the necessary code for this in [1], which contains the VFIO=
/PCI
Rust infrastructure [2], a Rust implementation of the NVIDIA vGPU driver [3=
] and
the required PCI SR-IOV infrastructure [4].

This is PoC code; I focused on the general design, and I've tested the VFIO=
 bits
to a point that I can poke the character device from userspace. But it stil=
l
needs a bit of cleanup and probably a few additional new type abstractions =
over
primitive types, etc. As conferences are approaching and I have a bunch of =
stuff
to prepare I could only finish it up after LPC, but I hope that Zhi is also
interested in picking it up. :)

I'm aware that you may have some concerns about Rust code in VFIO and one o=
f
them might be maintainance. I already have a lot on my plate, but I'm happy=
 to
offer to take responsibility. It would also be great if Zhi were interested=
 in
helping maintain them.

In this context, I'd like to walk through the design and a few code example=
s
below. We can also follow up at LPC, perhaps as part of the Nova workshop. =
(Zhi,
would you be interested in preparing a brief session on this with me?)

In general, the VFIO/PCI Rust code is not much different from the FWCTL and=
 DRM
code that we have upstream already. In the end they are all the same design=
 in
terms of the Rust class device lifetime model.

Below is a PCI driver skeleton that implements a VFIO/PCI class device (str=
ipped
down version of the NVIDIA vGPU driver), with a bunch of comments.

	#[pin_data]
	struct NvidiaVgpuData<'bound> {
	    _reg: vfio::pci::Registration<'bound, NvidiaVgpuOps>,
	}

This is the driver's bus device private data. The driver core uses a RAII
approach for this, it creates the driver's bus device private data from the
initializer returned from probe() and calls the destructor of the driver's =
bus
device private data on remove(), which is the equivalent of a remove() call=
back
in C.

In this case it just contains the vfio::pci::Registration, which essentiall=
y is
a RAII type for vfio_pci_core_register_device() and
vfio_pci_core_unregister_device().

(I'm aware that that vfio_pci_core_register_device() currently requires the
driver's bus device private data to be set to a struct vfio_pci_core_device
pointer as a trick to support PCI bus callbacks, such as with
vfio_pci_core_aer_err_detected(). I fixed this up in [5].)

	#[pin_data]
	pub struct NvidiaVgpuRegData<'a> {
	    pdev: &'a pci::Device<Bound>,
	    api: NovaCoreVfApiHandle<'a>,
	}

This is the private data attached to the vfio::pci::Registration, which is
accessible from the callbacks in struct vfio_device_ops.

You may wonder why the private data is on the vfio::pci::Registration rathe=
r
than the vfio::pci::Device.

The reason is that the callbacks in struct vfio_device_ops are lifetime wis=
e
associated with the vfio::pci::Registration and not the vfio::pci::Device, =
so
the destructor of this data should be called when the destructor of
vfio::pci::Registration runs, i.e. directly after
vfio_pci_core_unregister_device().

Furthermore, it allows us to store device resources, such as a DMA coherent
allocation, within this data in the first place, as the Rust compiler will
ensure that a vfio::pci::Registration can't outlive driver unbind, since it=
s
lifetime is bound to the bus driver's bus device private data.

(This is also why NvidiaVgpuRegData<'a> can store e.g. &'a pci::Device<Boun=
d>;
the lifetime 'a is guaranteed to be shorter lived than the 'bound lifetime =
that
describes the lifetime of the driver being bound to a device.)

The vfio::pci::Device on the other hand is reference counted and has an
unbounded lifetime.

Note that in the end this is only a logical distinction for when the destru=
ctor
is called. The actual memory this data goes into does not matter too much; =
it
can be a new allocation, it can be the allocation of the struct
vfio_pci_core_device (as it is in C), since the struct vfio_pci_core_device
strictly outlives the vfio::pci::Registration, or it can also be the driver=
's
bus device private data allocation itself.

	kernel::pci_device_table!(
	    PCI_TABLE,
	    <NvidiaVgpuDriver as pci::Driver>::IdInfo,
	    [
	        (
	            pci::DeviceId::from_class_and_vendor_vfio_override(
	                Class::DISPLAY_VGA,
	                ClassMask::ClassSubclass,
	                Vendor::NVIDIA
	            ),
	            ()
	        ),
	        (
	            pci::DeviceId::from_class_and_vendor_vfio_override(
	                Class::DISPLAY_3D,
	                ClassMask::ClassSubclass,
	                Vendor::NVIDIA
	            ),
	            ()
	        ),
	    ]
	);

The device ID table. It has some nice compile time guarantees as well, but =
it is
otherwise not very interesting in this context.

Let's look at the pci::Driver trait, which provides the callbacks (such as
probe()) and associated constants and types instead.

	impl pci::Driver for NvidiaVgpuDriver {
	    type IdInfo =3D ();
	    type Data<'bound> =3D NvidiaVgpuData<'bound>;
	    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
	    const DRIVER_MANAGED_DMA: bool =3D true;
=09
	    fn probe<'bound>(
	        pdev: &'bound pci::Device<Core<'_>>,
	        _info: Option<&'bound Self::IdInfo>,
	    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {

Note the 'bound lifetime in the signature of probe(); it represents the lif=
etime
of the driver's bus device private data and hence the lifetime of the drive=
r
being bound to a device.

	        let vdev =3D vfio::pci::Device::<NvidiaVgpuOps>::new(pdev)?;

This represents a struct vfio_pci_core_device and is typed over an
implementation of vfio::pci::Operations (i.e. a struct vfio_device_ops), bu=
t is
otherwise not very interesting.

=09
	        try_pin_init!(Self::Data {
	            // SAFETY: The registration is dropped when the PCI driver is =
unbound.
	            _reg <- unsafe { vfio::pci::Registration::new(
	                pdev,
	                &vdev,
	                try_pin_init!(NvidiaVgpuRegData {
	                    pdev,
	                    api: NovaCoreVfApi::handle(pdev)?,
	                }),
	            )},

Here we create the vfio::pci::Registration (i.e. call
vfio_pci_core_register_device()).

It takes three arguments, a &vfio::pci::Device, the private data and a
&'bound pci::Device<Bound>.

The vfio::pci::Registration captures the lifetime ('bound) of the &'bound
pci::Device<Bound>, such that it can't outlive driver unbind. In practice t=
his
is ensured as the compiler won't allow the vfio::pci::Registration to be st=
ored
anywhere else as in a place that is either the bus device private data itse=
lf or
something else that is strictly shorter lived.

The call to

	 NovaCoreVfApi::handle(pdev)?

calls into nova-core, which will provide a handle to the nova-core API
representation. This handle ties back to nova-core private data that by its=
elf
is shorter lived than nova-core's 'bound lifetime, but longer lived than vG=
PU's
'bound lifetime. IOW, the data is guaranteed to be valid for the full lifec=
ycle
of vfio::pci::Registration and hence can be stored within its private data.

I will come back to how this guarantee is upheld below. For now, let's have=
 a
look at how vfio::pci::Operations (i.e. struct vfio_device_ops) is represen=
ted.

	        })
	    }
	}
=09
	#[pin_data]
	struct NvidiaVgpuOpenData<'a> {
	    instance: VgpuInstance<'a>,
	}

This type (yes, Rust loves new types :) represents data that lives from
open_device() until close_device().

Note that the implementation below does not have close_device() at all, as =
the
destructor of the OpenData already represents close_device() as a RAII type=
.

This is also what makes the API with nova-core much better, since...

	impl vfio::pci::Operations for NvidiaVgpuOps {
	    const NAME: &'static CStr =3D c"nvidia-vgpu-vfio-pci";
	    type RegistrationData<'a> =3D NvidiaVgpuRegData<'a>;
	    type OpenData<'a> =3D NvidiaVgpuOpenData<'a>;
=09
	    fn open_device<'a>(
	        _dev: &'a vfio::pci::Device<Self>,
	        rd: &'a Self::RegistrationData<'a>,
	    ) -> impl PinInit<Self::OpenData<'a>, Error> + 'a {
	        try_pin_init!(NvidiaVgpuOpenData {
	            instance: rd.api.open(),
	        })

...here we can just call into nova-core via the API handle and obtain a
VgpuInstance<'a> struct from nova-core. Where nova-core can just store all =
the
objects that should be destructed on close_device() in the VgpuInstance str=
uct.

This way we avoid an API contract where we have to translate a RAII based d=
esign
into procedural cleanup and vice versa.

Also note how we can represent that OpenData is strictly shorter lived as
RegistrationData and the driver's bus device private data, in a way that th=
e
Rust compiler can ensure this.

	    }
=09
	    fn ioctl<'a>(
	        dev: &vfio::pci::Device<Self, Ioctl>,
	        _rd: &Self::RegistrationData<'a>,
	        open_data: Pin<&Self::OpenData<'a>>,
	        cmd: u32,
	        arg: usize,
	    ) -> Result<isize> {
	        // Handle driver ioctl.
=09
	        dev.core_ioctl(cmd, arg)
	    }
=09
	    fn read<'a>(
	        dev: &vfio::pci::Device<Self, Read>,
	        _rd: &Self::RegistrationData<'a>,
	        open_data: Pin<&Self::OpenData<'a>>,
	        buf: &mut vfio::UserBuf,
	        ppos: &mut vfio::pci::Position<'_>,
	    ) -> Result<isize> {
	        Ok(0)
	    }
=09
	    fn get_region_info<'a>(
	        dev: &vfio::pci::Device<Self, GetRegionInfo>,
	        rd: &Self::RegistrationData<'a>,
	        open_data: Pin<&Self::OpenData<'a>>,
	        info: &mut bindings::vfio_region_info,
	        caps: &mut vfio::InfoCap<'_>,
	    ) -> Result {
	        Ok(())
	    }
	}

The rest of the callbacks is not too interesting. The main thing to note is=
 that
the type state on the &vfio::pci::Device in e.g. ioctl() allows us to ensur=
e
that dev.core_ioctl() can only be called in ioctl() as it is only implement=
ed
for &vfio::pci::Device<_, Ioctl> and we only ever give out a
&vfio::pci::Device<_, Ioctl> in ioctl().

In the VFIO/PCI code I only implemented the callbacks the NVIDIA vGPU drive=
r
needs; all other callbacks can just remain the default trampolines for now.

Now, I promised to come back to how the following call works.

	NovaCoreVfApi::handle(vf_pdev)?

As mentioned it provides a handle to the nova-core API representation, whic=
h is
shorter lived than nova-core's 'bound lifetime, but longer lived than vGPU'=
s
'bound lifetime (and therefore always valid).

This is ensured by how I think we should implement the handling of the PF a=
nd VF
relationship on the PCI bus. Let's have a look at nova-core's probe() for t=
his:

	impl pci::Driver for NovaCoreDriver {
	    type IdInfo =3D ();
	    type Data<'bound> =3D NovaCore<'bound>;
	    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
=09
	    fn probe<'bound>(
	        pdev: &'bound pci::Device<Core<'_>>,
	        _info: Option<&'bound Self::IdInfo>,
	    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
=09
	        try_pin_init!(NovaCore {
	            _enable: {
	                let enable =3D pdev.enable_device()?;
	                pdev.set_master();
	                enable
	            },
=09
	            gpu <- Gpu::new(pdev, pdev.iomap_region_sized::<BAR0_SIZE>(0, =
c"nova-core/bar0")?),
=09
	            // SAFETY: `NovaCore` is dropped when the device is unbound.
	            _reg: unsafe {
	                auxiliary::Registration::new_with_lt(
	                    pdev.as_ref(),
	                    c"nova-drm",
	                    AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
	                    crate::MODULE_NAME,
	                    NovaCoreApi { gpu: gpu.get_ref(), pdev },
	                )?
	            },
=09
	            // SAFETY: `NovaCore` is dropped when the device is unbound.
	            _vf_reg <- unsafe {
	                let total_vfs =3D pdev.sriov_get_totalvfs().map_or(0, |v| =
v.get());
	                pci::VfRegistration::new(
	                    pdev,
	                    total_vfs,
	                    total_vfs > 0,
	                    NovaCoreVfApi { _gpu: gpu.get_ref(), pdev },
	                )
	            },
	        })
	    }
	}

Similar to vfio::pci::Registration and auxiliary::Registration, we have a
pci::VfRegistration, which can only be constructed once by a PF; for VFs it
fails to construct.

This pci::VfRegistration returns an initializer and lives within the driver=
's
bus device private data allocation. The constructor of pci::VfRegistration =
takes
the private data type that should be shared with VFs.

IOW, we do not share the whole driver's bus device private data with the VF=
s,
but just a defined container within the driver's bus device private data.

This is also what we do for all other kinds of registrations, such as
irq::Registration, which has the advantage that it fundamentally prevents
ordering issues. For instance, when constructing an irq::Registration the I=
RQ
private data container is guaranteed to be fully initialized before the fir=
st
IRQ is received, whereas the rest of the driver's bus device private data m=
ay
not be initialized yet.

For the pci::VfRegistration this isn't a concern, as it would be valid to e=
xpose
the entire driver's bus device private data, but it is still cleaner if a P=
F
does not need to expose its whole bus device private data to the VFs, but j=
ust
the intended API type.

The required lifetime guarantee comes from the fact the pci::VfRegistration
lives in the driver's bus device private data, and serves as a guard that c=
alls
pci_disable_sriov() in its destructor.

This way we also do not need the patch in [6]. I still think it would be
reasonable to have this, but the pci::VfRegistration approach is cleaner. I=
n any
case, it's not an either-or, we can have both.

Coming back to nova-core's probe() above, we can see how this perfectly ali=
gns
with how the API between nova-core and nova-drm works via the auxiliary bus=
.

Implementation wise the API on the nova-core side looks like this:

	pub struct NovaCoreVfApi<'a> {
	    pub(crate) pdev: &'a pci::Device<device::Bound>,
	    pub(crate) _gpu: &'a Gpu<'a>,
	}
=09
	/// Closure-based handle to the nova-core VF API.
	pub struct NovaCoreVfApiHandle<'a> {
	    vf: &'a pci::Device<device::Bound>,
	}

	/// An active vGPU instance, closed on drop while the VF binding is still =
valid.
	pub struct VgpuInstance<'a> {
	    api: &'a NovaCoreVfApiHandle<'a>,
	}
=09
	impl NovaCoreVfApi<'_> {
	    /// Obtain a [`NovaCoreVfApiHandle`] from a VF registered by nova-core=
.
	    pub fn handle(vf: &pci::Device<device::Bound>) -> Result<NovaCoreVfApi=
Handle<'_>> {
	        NovaCoreVfApiHandle::of(vf)
	    }
	}
=09
	impl<'a> NovaCoreVfApiHandle<'a> {
	    fn of(vf: &'a pci::Device<device::Bound>) -> Result<Self> {
	        vf.vf_registration_data_with::<ForLt!(NovaCoreVfApi<'_>), ()>(|_| =
())?;
	        Ok(Self { vf })
	    }
=09
	    /// Activate a vGPU instance, which is closed on drop.
	    pub fn open(&self) -> Result<VgpuInstance<'a>> {
	        VgpuInstance::new(self)
	    }
=09
	    /// Access the [`NovaCoreVfApi`] through a closure.
	    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&NovaCoreVfApi<'b>>) =
-> R) -> R {
	        self.vf
	            .vf_registration_data_with::<ForLt!(NovaCoreVfApi<'_>), R>(f)
	            .expect("TypeId was validated in NovaCoreVfApiHandle::of()")
	    }
	}
=09
	impl<'a> VgpuInstance<'a> {
	    fn new(api: NovaCoreVfApiHandle<'a>) -> Result<Self> {
	        // TODO: Create the vGPU instance object via `api.gpu`.
=09
	        Ok(Self { api })
	    }
=09
	    /// Reset this vGPU instance.
	    pub fn reset(&self) -> Result {
	        Ok(())
	    }
	}

(Don't worry too much about the NovaCoreVfApiHandle::of() and
NovaCoreVfApiHandle::with() stuff. Those are helpers we also have in the
nova-drm API to deal with invariant or non-covariant types respectively.)

If you've made it this far, thanks for reading through this long write-up. =
I
hope you find it useful. Please let me know if you have any questions or
thoughts.

Thanks,
Danilo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Dpoc/vgpu
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?=
id=3D484316d855e3d61873122c295feb9a7457eeca21
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?=
id=3D6292c1de7f0758dd31496a454b4034507f38bd40
[4] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?=
id=3Defac2cec97eab36edd01a2fe79aea67a04bd8842
[5] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?=
id=3D76b3bfd6386a01f338780e1a37b5bad3f5a48d31
[6] https://lore.kernel.org/lkml/20260303-rust-pci-sriov-v3-1-4443c35f0c88@=
redhat.com/
