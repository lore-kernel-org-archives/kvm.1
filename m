Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610593;
	b=blIkAECQU343AEmxSweqvKVU1msHQ+QUD5+1kzMWlMOBtsOi14TP4XVFY/1xf//sOaZC
	 efFGigNsezQ/LKlQUricvZR5759GNEPFmOmJkggGqqBfDj9ZOtWADBGWZjLGIaNlus4Qx
	 rCC0a86PURd06DPpok6J9o2DyBKLenKLNprrcDIC9gti03NjF0l6ZzbJL44WP/yVrhgLc
	 LEjVyA6FWcebQ329xlInpM6+Xu9czIc6UqWrP8QaEPJdNi7QBiGCnUcfu3rRHyHXjsUV7
	 WaUsKNAOeMMm5IOfwJWqAsN+P7Rj1h8VrOT9TAo//884IUtbjR40eU+fBZcrBhmu6FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610593;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Soe9AbyJje/CanHZy+BPUS7HyCw3W/h9mWpxWG3+h70=;
	b=H+R+WgADzIrXfkoXzdUM19UGaOQnc4Ue17ZMOjOIX8w40OETdxydty4hIkQZAzbfbBoZ
	 CWYd5rcPx8AVoSuwRBL+WFk2eGHX/Tsibh3mjbRtshuw3e00y8/fn5FVhim5PeXlfKHO4
	 WHLYqnA/quYOl9VergJxE410RXZ3VAaLR6Q8TdSpXbbXp9d0+6aT46QP//WM+kWzWBkkQ
	 Leev+p7R5ROAxnnLh2iXUV3Izbm27qIAmlVXUh8+fJXDF0TlUP/jO5igBJQTkC1lQKknE
	 225P6ma8NhUJl/6sg3/SrhEITqm9XveIGsI017BTrWW+cFmbo5v87cwCece3IFhBasA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdfGlUQL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D1606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdfGlUQL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458571F000C4
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795610593;
	bh=Soe9AbyJje/CanHZy+BPUS7HyCw3W/h9mWpxWG3+h70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IdfGlUQLVdZd+HqGeJmpnmm6ZOvD2DCF88z9GcmsjUrKh5xMoOWAGEOagnXAmAYta
	 k5dXwiF8fnMKU/56Us9yLAAPPjZbLDyyIyN4SJwaz6ZYK/x07tMrfYIXK6AieI6mSB
	 d1AdCCTdQcqGyELTARAP/FzRjeNQGlDxqnuOgdfoKJ9MFiO7BSIcyxarVyn4QpJp5/
	 Te6SJK2tPRq87NZfNEoUCKt9Lc9PfZf9imw1XgFkYesMHxgV5ZIhH3PFZPEcykyjTn
	 BdRChy9Mk6ypZdqC9qPqHPRw/g6YkI8qu84PKcwRhIcA1Rxl6OclJCgqXskhY5I66W
	 DQPweoAUVnWBw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c158c4c15fso7014067e87.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 04:43:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGOokgMUNWfMucEWqPPY/5Glp8UpYspabo5AdDYt2tOhKwuYkxSJtoe7bCYfYF5mQEJB/E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uThgf1sqpivc7pBphJ7C8G8hGmm5Pp4mE/uGhpY+Ux9Czb3O0
	uMRB44gSphEUAf8xmXeYGJSNFAS5hC0x5nwQtUObdGuenlnOZ05Yh4WLwyaNklTVBvXK2n+MuqA
	Hf9XFXbtRtEBbzusSYsNoojxWzw1B9Zw=
X-Received: by 2002:a05:6512:3e1a:b0:5c1:4d49:cd84 with SMTP id
 2adb3069b0e04-5c1bc89a84emr4500196e87.17.1795610592062; Wed, 25 Nov 2026
 04:43:12 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com> <20261015142552.4128028-16-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-16-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 13:42:59 +0100
X-Gmail-Original-Message-ID: <CAD++jL=h8iMU1sxjopoGBuniv_vsi2uhggJNQiyoWaTsOV+-Tw@mail.gmail.com>
X-Gm-Features: Aa3M54pGhuvz2evFxcjQ_z7LSxF4iu4SVrSPElv7BkwMOHJcq9BoFVwsp0UZH2I
Message-ID: <CAD++jL=h8iMU1sxjopoGBuniv_vsi2uhggJNQiyoWaTsOV+-Tw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/15] misc/arm-cla: Add vfio-mdev user interface
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan, Jean-Philippe,

this patch series now moves into the virtualization stratosphere where
my knowledge doesn't even reach the level of "a little knowledge
is dangerous", people versed with virtualization need to review this.

A few general remarks though:

On Thu, Oct 15, 2026 at 4:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> From: Jean-Philippe Brucker <jpb@kernel.org>
>
> Implement an interface to assign CLA devices to KVM guests. To creates a
> CLA instance:
>
>     uuid=3D$(uuidgen)
>     echo $uuid > /sys/class/mdev_bus/<pdev>/mdev_supported_types/arm-cla-=
pl1/create
>     cla_cpu=3D$(< /sys/bus/mdev/devices/$uuid/cpu)
>
> This creates a user interface in /dev/vfio: a VFIO group in
> /dev/vfio/<n>, discoverable by reading the symlink
> /sys/bus/mdev/devices/$uuid/iommu_group. Although CLA does not use an
> IOMMU, VFIO relies on IOMMU groups as an assignable unit. Here they
> correspond to CLA domains, whose devices communicate through a private
> bus.
>
> The CLA device gets assigned exclusively to the first VMM that opens the
> VFIO group and device. To launch a VM with a CLA attached to vCPU #4,
> with kvmtool:
>
>     lkvm run -k Image --console virtio -c 8
>         --vfio-platform $uuid,type=3Darm-cla,vcpu=3D4
>         --vcpu-affinity 4=3D$cla_cpu      # Bind vCPU 4 to the CLA's CPU
>
> Opens the group, gets the device fd, mmaps the frame, and launches the
> guest. The given vCPU thread is pinned to the CLA's CPU.
>
> Pinning vCPUs is not guaranteed. If the host decides to power off the
> CPUs with assigned CLAs, the guest application can't access the assigned
> device anymore. It would now access a RAZ/WI memory region.
>
> For DMA, because the TLB entries tagged with VMID+ASID are shared
> between CPU and accelerator, we pin the VMID. The stage 2 page tables
> are shared between CPU and CLA. CLA reports DMA page faults directly to
> the user, who performs the access from the CPU to handle both stage 1
> and stage 2 faults.
>
> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>

I understand the patch as this:

The CLA register window of the CLA attached to one certain CPU
can be exposed to a virtual machine by way of VFIO, that is, this
virtual machine can see that memory as if was its own.

This makes me ask the following questions:

1. Is the intended user of that VFIO window a kernel driver or
"some userspace mockery", i.e. a plain old userspace driver just
using the hardware from userspace. This is something I have
seen in code trees from the likes of SpaceX, where VFIO is
used for antenna array hardware and handled with userspace
drivers (and the userspace driver
is run with realtime priorities for high responsivity usecases).
The use case matters for the design of the VFIO exposure,
because if in-kernel users of the same hardware from the
host can be expected this could become less than elegant.
I don't know for sure, it may make perfect sense if the user
is some userspace process doing some computation I need
not worry my head about.

2.The affinity story again: certainly this VM must be pinned to
the CPU exposing the CLA and the VM will see *one* CPU
in its world, or this would never work, right? We are not doing
any multicore virtualized machines because then you would
need each to expose a different VFIO window for each CPU?
(I think I saw the kvm usecase only allowing for one instance,
no domains, so I guess yes.)

I don't know how much VMs migrate on a running system.
But if a "normal" VFIO window pertains to the "normal"
physical address space I suppose this is not a problem, you
can move the VM to another CPU and everything else
remains the same. But not so with CLA! So how do you
intend to impose this restriction?

Yours,
Linus Walleij
