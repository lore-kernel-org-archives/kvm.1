Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D22C1595
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649173; cv=none; b=IxhcUgTPta+NWDjFTVHrN0jA43Zgd+78C4+d6WDdbSHuenvyUGVISbwL8vyIJlApsQBGluwkefQhEwObP2y0dC6w1Eyl2d6aMY/79j8Fhh0yfBiCYXLAN5b0gXG9M29J2AvQk2KywcJxMw25kCiN2aMhd0Em6Gkd6zUbLSBtEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649173; c=relaxed/simple;
	bh=i3uvjnA/Op2m8oC34bB1I8n+/fBXvwYp2ed6h+OSNPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqtwj/jcSedV+y9K1uJPTvTrtGXFWcdG4XCWKSeBbqYNMdPqjOD7n08QeObbl2UEZvgb2+v4g3OLbpOrxhwq3JgR8yEuCX084erIzVSQysE/QTTXzRTV48C8WXMeLrXDVenMbQE3WcrCJVHxKpxbt31pvaoseQi+M/vHV1kHkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcoG2UaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcoG2UaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3608B1F00893;
	Fri,  5 Jun 2026 08:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649172;
	bh=ECOdBRY+tIJghnxpEsiNoGAZtgXxEoTZvYA3XXRttU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcoG2UaSzqosUDBbzHobMsCQ8BMLpsAhR8zM/yr52ckb9T7IkwUdTUWJavtFF/Yuo
	 wN6m0wg0rPEYE6PrprL2/xWO45/aL9XbnLwh4TM2WdjEnxWznR2Wq25094D4x59dOS
	 2hMEqxO6TcHEiqV32mAMvqaudvpfpezrhT10u1DMy+yOV3RNmI4V6+aIm4LyRKAJj/
	 FfA025GM/ZykB6gCp4Ty/8m8W3HXSLONXnmJkYylaKe0jm6je/o7loJ0SqiwskOvqa
	 fIqAQxA2v50rIE68CyhtHgaS3szvc9u8oPBvVE32/PYipXqvrwI5pip3nGy9VwtOYW
	 Jr/iBYjzkUbzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PTACH v3] LoongArch: KVM: Add missing slots_lock for IO bus
 device register/unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zeng Chi" <zeng_chi911@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605083108.2534481-1-zeng_chi911@163.com>
References: <20260605083108.2534481-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:46:11 +0000
Message-Id: <20260605084612.3608B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Device destruction callbacks free the device state but fail to=
 clear the corresponding `kvm->arch.*` pointer, leading to a Use-After-Free=
 if the device is destroyed.
- [Critical] Missing initialization check in `kvm_pch_pic_init` allows dupl=
icate IO bus registrations, leading to UAF during VM destruction.
--

commit 54efe4750d591583d326d010f7011322a7bf73f7
Author: Zeng Chi <zengchi@kylinos.cn>

LoongArch: KVM: Add missing slots_lock for IO bus device register/unregister

This commit adds the missing kvm->slots_lock around kvm_io_bus_register_dev=
()
and kvm_io_bus_unregister_dev() calls. This protection is added to the eioi=
ntc,
ipi, and pch_pic device initialization and destruction paths.

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index 2ab7fafa86d59..2b14485d14a70 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
[ ... ]
> @@ -667,8 +671,10 @@ static void kvm_eiointc_destroy(struct kvm_device *d=
ev)
> =20
>  	kvm =3D dev->kvm;
>  	eiointc =3D kvm->arch.eiointc;
> +	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
> +	mutex_unlock(&kvm->slots_lock);
>  	kfree(eiointc);

[Severity: Critical]
This is a pre-existing issue, but does this kfree() leave a dangling pointe=
r?

When userspace creates a device, the ops->create() callback saves the device
pointer into kvm->arch.eiointc. If the device is destroyed, this function
frees eiointc but leaves kvm->arch.eiointc pointing to the freed memory.

If a subsequent ioctl or guest interaction routes interrupts, could it
dereference kvm->arch.eiointc, such as in eiointc_set_irq() when it tries to
acquire the spinlock? Should we set kvm->arch.eiointc to NULL after
freeing it?

>  	kfree(dev);
>  }
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 1f6ebbd0af5c8..4fa0897d7bdb0 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -447,7 +447,9 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
> =20
>  	kvm =3D dev->kvm;
>  	ipi =3D kvm->arch.ipi;
> +	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
> +	mutex_unlock(&kvm->slots_lock);
>  	kfree(ipi);

[Severity: Critical]
This is a pre-existing issue, but is kvm->arch.ipi also left dangling here?

Like eiointc above, this frees the ipi structure without clearing the
kvm->arch.ipi pointer. Could this also lead to a use-after-free if the VM
continues running?

>  	kfree(dev);
>  }
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index aa0ed59ae8cf9..175a630aceb41 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -481,7 +481,9 @@ static void kvm_pch_pic_destroy(struct kvm_device *de=
v)
>  	kvm =3D dev->kvm;
>  	s =3D kvm->arch.pch_pic;
>  	/* unregister pch pic device and free it's memory */
> +	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
> +	mutex_unlock(&kvm->slots_lock);
>  	kfree(s);

[Severity: Critical]
This is a pre-existing issue, but are we leaving kvm->arch.pch_pic pointing=
 to
freed memory here as well?

Additionally, this is a pre-existing issue, but does kvm_pch_pic_init() all=
ow
duplicate IO bus registrations?

If userspace triggers the KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT ioctl multiple
times, it appears kvm_pch_pic_init() lacks a check to see if the device is
already initialized. This allows kvm_io_bus_register_dev() to register the
same &s->device pointer to the KVM_MMIO_BUS array multiple times.

During teardown, kvm_io_bus_unregister_dev() only removes the first matching
entry:

virt/kvm/kvm_main.c:kvm_io_bus_unregister_dev() {
    ...
	for (i =3D 0; i < bus->dev_count; i++) {
		if (bus->range[i].dev =3D=3D dev) {
			break;
		}
	}
    ...
}

If the device was registered multiple times, would the duplicate entries
remain on the bus after this function unregisters and frees the device?
Could subsequent MMIO bus accesses or the final bus teardown then
dereference the freed &s->device pointer?

>  	kfree(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605083108.2534=
481-1-zeng_chi911@163.com?part=3D1
