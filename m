Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F74A21
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109137; cv=none; b=iu/AJioX4INmGI7MEJPnMqMJ2c8RYs4YsEj9PzMuzkMD9zvu9r6AOh0VXdsp3jJJKHI8BBHHjBj/hI/MS1gGvq5VSbO2n1wq/AWX5/XVL1Vn3SsL2rFORQO4W6Yj8ZSuW3Lz+1eYa8DJehAS+o6UP7NGmG/dzayjRS15dHehT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109137; c=relaxed/simple;
	bh=lVMJOr8k4NC7cvEVROI7e9cLzXjzf8H4JDLSX4qT5YA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=grgAV0ep7CXmHcBr8iwSwnsE7xq0vgdrh4FpwW+tbknQ4Bo+zug2EL5gI7gh5HKmYb5VF6sd8H3Dx+rGPu1bQcUTQFgZG9gynnK17nb+yZ2udwl0VCj5nXDr1sQQBJKTpdfj2KXs0nfqo/u6FZLDmeskkl1y3RuNbO6igYUGZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOgKT5po; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOgKT5po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A271F000C4;
	Fri, 16 Oct 2026 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109136;
	bh=tydoap3XLCF0EdAhwMqIPJL7IQ9h/YCyYKEDLqlh6y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOgKT5pogov4qYMpvODtRy/PvTa+3j87dzLFSoyLpbcMeTEGKJR23Whk4Jku4exQr
	 Hox33PeuWWL0nwWSbWsbTM/iPEmWFTE0HJ8fa5oMMJrDKDZ5t0SYEA3qdHSVxEb0bO
	 7fh8uRgopRjZN0VDbRxj+rZQSc16W7Von/JM/5giRlDksy0Gl8nJL/e2QH75dBHeCK
	 mEpigc8yHoj4f3081VRBZTrK6KNWLnni9HjFVVae+S7uG/QnEAb+uYpwgyr5aY3V/C
	 u5fObsDSf9XmnNp1s5T3q0VHTWIz3q1GxvxhDyoJx2EOAuwTx2h7bnEa1NqXS+tQuT
	 DndLnwND+j9kw==
Message-ID: <sashiko-outbox-173505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] LoongArch: KVM: Clear device pointer in irqchip
 destroy callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015234638.1077815-2-cui.tao@linux.dev>
References: <20261015234638.1077815-1-cui.tao@linux.dev>
 <20261015234638.1077815-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:05:35 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: loongarch: UAF in irqchip teardown due to missing irq_srcu sy=
nchronization
- [High] kvm: loongarch: NULL pointer dereference in IRQ injection paths
--

commit 2f10d82f92df54fcbd750081f5d2c1a3283f66b9
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Clear device pointer in irqchip destroy callbacks

The destroy callbacks of the four irqchip devices free the device
structure without clearing kvm->arch.{ipi,eiointc,pch_pic,dmsintc},
leaving a dangling pointer. This clears the pointer when destroying.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -146,6 +146,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *de=
v)
>  		return;
> =20
>  	kfree(dev->kvm->arch.dmsintc);
> +	dev->kvm->arch.dmsintc =3D NULL;

[Severity: High]
Does this sequence free the structure before setting the pointer to NULL?
This could leave a globally visible dangling pointer during the race window.

If KVM_CREATE_DEVICE fails during anon_inode_getfd() (e.g., due to a process
hitting RLIMIT_NOFILE), this destroy callback executes immediately. If a
guest concurrently issues KVM_SIGNAL_MSI or KVM_IRQ_LINE ioctls, can they
race with this teardown?

Without calling synchronize_srcu(&kvm->irq_srcu) before kfree(), concurrent
IRQ injections holding the SRCU read lock might access the freed memory,
leading to a use-after-free.

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -675,6 +675,7 @@ static void kvm_eiointc_destroy(struct kvm_device *de=
v)
> =20
>  	kvm =3D dev->kvm;
>  	eiointc =3D kvm->arch.eiointc;
> +	kvm->arch.eiointc =3D NULL;
>  	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);

[Severity: High]
Can this modification introduce a NULL pointer dereference in the IRQ
injection paths?

When kvm->arch.eiointc is cleared here without SRCU synchronization,
concurrent IRQ routing callbacks might see a NULL pointer. Functions like
eiointc_set_irq() or pch_msi_set_irq() currently dereference
kvm->arch.eiointc unconditionally:

arch/loongarch/kvm/intc/eiointc.c:eiointc_set_irq() {
    ...
    spin_lock_irqsave(&s->lock, flags);
    ...
}

Additionally, since eiointc is eventually freed in this function without
waiting for synchronize_srcu(&kvm->irq_srcu), could concurrent injections
also hit a use-after-free if they managed to read the pointer before it
was set to NULL?

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -483,6 +483,7 @@ static void kvm_pch_pic_destroy(struct kvm_device *de=
v)
> =20
>  	kvm =3D dev->kvm;
>  	s =3D kvm->arch.pch_pic;
> +	kvm->arch.pch_pic =3D NULL;
>  	/* unregister pch pic device and free it's memory */
>  	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);

[Severity: High]
Similar to eiointc, does clearing kvm->arch.pch_pic without SRCU
synchronization expose concurrent IRQ handlers to a NULL pointer dereference
or use-after-free?

If KVM_IRQ_LINE is called concurrently, kvm_set_pic_irq() reads
kvm->arch.pch_pic and passes it to pch_pic_set_irq() without validation:

arch/loongarch/kvm/irqfd.c:kvm_set_pic_irq() {
    ...
    pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
    ...
}

arch/loongarch/kvm/intc/pch_pic.c:pch_pic_set_irq() {
    ...
    spin_lock(&s->lock);
    ...
}

If the caller reads the pointer after it is cleared, it will dereference
NULL. If it reads the pointer before it is cleared, the subsequent kfree(s)
at the end of this destroy callback could cause a use-after-free, since
there is no synchronize_srcu(&kvm->irq_srcu) to protect the read-side.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015234638.1077=
815-1-cui.tao@linux.dev?part=3D1
