Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D976345CAF;
	Wed, 11 Mar 2026 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261433; cv=none; b=f0TBvSxt3WCsjMGuLji2xC+hPly9aOPJwptOid54ffPcxegWw6CDJBapVn2CDnYGfba5Z+Xs8hU71QC1Hq9fCpvEHzjRp4eNXzL1wZFo0Pgec+mhczfAhMwoTHQX+05uWmOeo8Uc1eBeyyc1xDWE/ZGl/+BNnWoRnhGLnkH5xT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261433; c=relaxed/simple;
	bh=vzUrkheKR7QoaxVezyzPFB9dYygXqrYaS51yD3yo7ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJbmQnlNsHYEV4D+AcXjI7ltvqN+FNo/phmRMi9Smg8gzegtNOnnVk8gh6cFzmlnCBQZ3rWu2bN1272rKB2AgPQAMx+Xk94XzUJ74D3NnyTGIGpDWy1d5yaEtVQRQzXdRj0F0UKJsH2Bzm9kdGInRrPyGiDkt7fcbE9Ai0+Fe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=oM8F5fOD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1SUbR5lE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="oM8F5fOD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1SUbR5lE"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AF89EC0B07;
	Wed, 11 Mar 2026 16:37:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 11 Mar 2026 16:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773261429;
	 x=1773347829; bh=E7ek5mWLrWjVUBWgqKopP0NdS8Jsdmt5+Lc6K4+LiDo=; b=
	oM8F5fODGLxtavevjvXrO53yPGbZEnOKKuCy109aqUAyv1oJ2yDuri7vXBOPN6DX
	+YQSx94dGTIhzrt9SJCimz1KpLQUMihON67iGZn54HlzZ4V6kxsQPmZw6FJRegPt
	fyIXMqkm2Cq3hVKkBMI8nvVaKD6nhno7JrmPML8hhSTF9xFYVkjHMXUCSiJUNn5v
	SxfbPxdb/L2JGBIAAyNJRyqNlLrqiSw6QPKm2mUiyzEYfMFkUO250aUVi8XnFtnh
	0XDy/SZIfU3EhxEDF4uYQd3LeESXru86nZZiozrQ4tGTE8B5LDkvG5jPZe3I/8I4
	1Cd+2KlG0v8JJgBflrYJSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773261429; x=
	1773347829; bh=E7ek5mWLrWjVUBWgqKopP0NdS8Jsdmt5+Lc6K4+LiDo=; b=1
	SUbR5lEWJ0yTTNOa2/vVi/ffkMRyTV3suxW8v957OkpxpBQx+pZ8Kri3EgvjKbEP
	dicLCoZeJ9HabtpHBAYovO+NoIEZOz2On9kPAui+Hf4pIIehGK50OjHPLtMl2zg0
	CyxKStgN65fWz6BuRec6xWWJ3pGot5cH3oNoxMo78+NpkqjLgRUrv3UmFj/QSB7p
	+H6ARZZNF3UEQU0LIw6cuHd8ySHh8n5WGwZ976VqfYTUAWtcHGos9cHwAkbndCfF
	CF3UPA3rCcBBxlcRJQCIAis6xVLe+5BSieA1qz0LM8KBTtRYGal/zvRDLOwAEa7h
	z2fG3WQRlvwHuKtfSCYMw==
X-ME-Sender: <xms:dNKxaZVxe68u_LvebRWfTLJWK9nLLrFGkg7XKBYbh2WzH9cpoKPmlA>
    <xme:dNKxaeyBd7tjCuC0SNjBjqC9m-cLeWNeWoc9Uk7HVM_1rzkVkB9_Yf6uzgwy3sRfg
    Ow5uS_19g_mKGPUUbm_K1WEPWdxB9uQ-c3tZWoGLX_TKI_CCLUYJQ>
X-ME-Received: <xmr:dNKxaYzhlr0G7aAE_U3PllEyozD4sGT2JfAsfuspr-9pOf1F5uic3eNPWMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepvhhsvghthhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehjghhgsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehmohgthhhssehnvhhiughirgdrtghomhdprh
    gtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopehskhholhhothhhuhhm
    thhhohesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghjihgrsehnvhhiughirgdrtg
    homhdprhgtphhtthhopeiihhhifiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhj
    rghjuhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:dNKxab0PEDuKJBO8nQkB9QrY0wLUBhUaY1UfUsICi2S0ygZ8QK0EgA>
    <xmx:dNKxaeoUst7x1UM_G6c2ZgwRrIqbw9AJpj8ST2_eIYw0lloJ4D5Tvw>
    <xmx:dNKxaZCjNUV3_idRVxvTLsgmFJPMcXv7EmR8mHD6D253vyy-qDGZvw>
    <xmx:dNKxaXqVRZSIdLCFO9R416O3DLNs0pFy7jxMr0gI2Tn7sbdAoIJ7MA>
    <xmx:ddKxafDkwr30C_jkHZJ9QEX2o4a4VSh-fnh4mhUKOyUbvvtB_xUcmgeO>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 16:37:07 -0400 (EDT)
Date: Wed, 11 Mar 2026 14:37:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Vikram Sethi <vsethi@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, Shameer Kolothum Thodi
 <skolothumtho@nvidia.com>, Neo Jia <cjia@nvidia.com>, Zhi Wang
 <zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH RFC v2 00/15] Add virtualization support for EGM
Message-ID: <20260311143706.2095a547@shazbot.org>
In-Reply-To: <SA1PR12MB719904F9ED153FF4BA4EFA28B047A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260223155514.152435-1-ankita@nvidia.com>
	<20260305103335.74fb8141@shazbot.org>
	<SA1PR12MB719904F9ED153FF4BA4EFA28B047A@SA1PR12MB7199.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 06:47:12 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Thanks Alex for the review.
>=20
> >> The patch series introduce a new nvgrace-egm auxiliary driver module
> >> to manage and map the HI/EGM region in the Grace Blackwell systems.
> >> This binds to the auxiliary device created by the parent
> >> nvgrace-gpu (in-tree module for device assignment) / nvidia-vgpu-vfio
> >> (out-of-tree open source module for SRIOV vGPU) to manage the
> >> EGM region for the VM. Note that there is a unique EGM region per
> >> socket and the auxiliary device gets created for every region. The
> >> parent module fetches the EGM region information from the ACPI
> >> tables and populate to the data structures shared with the auxiliary
> >> nvgrace-egm module.
> >>
> >> nvgrace-egm module handles the following:
> >> 1. Fetch the EGM memory properties (base HPA, length, proximity domain)
> >> from the parent device shared EGM region structure.
> >> 2. Create a char device that can be used as memory-backend-file by Qemu
> >> for the VM and implement file operations. The char device is /dev/egmX,
> >> where X is the PXM node ID of the EGM being mapped fetched in 1.
> >> 3. Zero the EGM memory on first device open().
> >> 4. Map the QEMU VMA to the EGM region using remap_pfn_range.
> >> 5. Cleaning up state and destroying the chardev on device unbind.
> >> 6. Handle presence of retired poisoned pages on the EGM region.
> >>
> >> Since nvgrace-egm is an auxiliary module to the nvgrace-gpu, it is kept
> >> in the same directory. =20
> >
> >
> > Pondering this series for a bit, is this auxiliary chardev approach
> > really the model we should be pursuing?
> >
> > I know we're trying to disassociate the EGM region from the GPU, and
> > de-duplicate it between GPUs on the same socket, but is there actually a
> > use case of the EGM chardev separate from the GPU? =20
>=20
> It is not just de-duplication. The EGM is a carveout of system memory
> logically and physically separate and disconnected from the GPU. The
> uniqueness here is that the information (SPA, size) of the region is pres=
ent
> on the GPU ACPI tables.
>=20
> >
> > The independent lifecycle of this aux device is troubling and it hasn't
> > been confirmed whether or not access to the EGM region has some
> >dependency on the state of the GPU.=C2=A0 =20
>=20
> The EGM region is independent on the state of the GPU. One can plausibly
> bootup the VM with just the EGM memory chardev as the backend file and
> no GPU.

Seems like we have the wrong model then to base the lifecycle of the
aux devices on the state of the PCI driver if EGM is fully independent
of the state of the PCI device.

> > nvgrace-gpu is manipulating sysfs
> > on devices owned by nvgrace-egm, we don't have mechanisms to manage the
> > aux device relative to the state of the GPU, we're trying to add a
> > driver that can bind to device created by an out-of-tree driver, and
> > we're inventing new uAPIs on the chardev for things that already exist
> > for vfio regions. =20
>=20
> Sorry for the confusion. The nvgrace-egm would not bind to the device
> created by the out-of-tree driver. We would have a separate out-of-tree
> equivalent of nvgrace-egm to bind to the device by the out-of-tree vfio
> driver. Maybe we can consider exposing a register/unregister APIs from
> nvgrace-egm where a module (in-tree nvgrace / out-of-tree) can register
> a pdev and nvgrace-egm can use to fetch the region info.

Ok, this wasn't clear to me, but does that also mean that if some GPUs
are managed by nvgrace-gpu and others by out-of-tree drivers that the
in-kernel and out-of-tree equivalent drivers are both installing
chardevs as /dev/egmXX?  Playing in the same space is ugly, but what
happens when the 2 GPUs per socket are split between drivers and they
both try to added the same chardev?

> > Therefore, does it actually make more sense to expose EGM as a device
> > specific region on the vfio device fd?
> >
> > For example, nvgrace-gpu might manage the de-duplication by only
> > exposing this device specific region on the lowest BDF GPU per socket.
> > The existing REGION_INFO ioctl handles reporting the size to the user.
> > The direct association to the GPU device handles reporting the node
> > locality.=C2=A0 If necessary, a capability on the region could report t=
he
> > associated PXM, and maybe even the retired page list.
> >
> > All of the lifecycle issues are automatically handled, there's no
> > separate aux device.=C2=A0 If necessary, zapping and faulting across re=
set
> > is handled just like a BAR mapping. =20
>=20
> The EGM memory (which becomes the system memory of the VM) cannot
> be connected to the GPU reset as it is unrelated to the GPU device. We wo=
uld
> not want that to happen to system memory on GPU reset.

It's not the state of the EGM/system memory that I'm concerned about,
it's the fact that the routing to access that memory traverses two
GPUs and both the backplane and c2c NVLink connections.  If access
through that channel is 100% independent of the state of either GPU
then GPU resets are irrelevant.

However, I'd then ask the question why we're associating EGM to the GPU
PCI driver at all.  For instance, why should nvgrace-gpu spawn aux
devices to feed into an nvgrace-egm driver, and duplicate that whole
thing in an out-of-tree driver, when we could just have one in-kernel
platform(?) driver walk ACPI, find these ranges, and expose them as
chardev entirely independent of the PCI driver bound to the GPU?
=20
> > If we need to expose the EGM size and GPU association via sysfs for
> > management tooling, nvgrace-gpu could add an "egm_size" attribute to the
> > PCI device's sysfs node.=C2=A0 This could also avoid the implicit
> >  implementation knowledge about which GPU exposes the EGM device
> > specific region.
> >
> > Was such a design considered?=C2=A0 It seems much, much simpler and cou=
ld be
> > implemented by either nvgrace-gpu or identically by an out-of-tree
> > driver without references in an in-kernel ID table.
> >
> > I'd like to understand the pros and cons of such an approach vs the one
> > presented here.=C2=A0 Thanks, =20
>=20
> We didn't consider it as a separate BAR / region as the EGM memory (part =
of the
> system memory) is unrelated to the GPU device besides having its informat=
ion
> in the GPU ACPI table and becomes the system memory of the VM. Considering
> it as part of the device BAR / region would connect the lifecyle of the E=
GM region
> on the GPU device. Also we cannot consider zapping/faulting across GPU re=
set
> as it is system memory of the VM.

It's curious why the EGM description is associated to the GPU ACPI
object if it really is fully independent.  It seems like perhaps it
should be a unique ACPI object in that case, which would make claiming
it via a platform driver easier.  Maybe we don't need to be tied to
that firmware decision in the design of the software driver though.
Thanks,

Alex
