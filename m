Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796BF2641FC
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956576; cv=none; b=hrEzy/iT+VCPolBTXlcne5XuY0Quk7wyeC/CAGJ8zD7Gy/VuCPZZE5pnjd9D4pKeuJumjFD/aMXhpYP1HPzmCvqIzXNfn0RpIVSw88disq7CfTKi2h4XrQtaTYpU5KzAlbilfIdaSlKCMI8AvpDUZprFR+4Ih3hOc8KtTXc9Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956576; c=relaxed/simple;
	bh=d02zNtUO+5FtTf5siuQqNfsH5GUsKZAiLI9HCKNW+fM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UJBsjo/PqI7IbN4AG4NfzkFrwUhGa93UQElNJ2LO26UaJxRWNf/jPUi9MTQa1lkMSmUkn0RxqLBI3TJo2y4yMqqr2n+481BUkXKG8OexDvWepjPhrjYQx7eL9KhCAN9vKDjMXMkT0pPlluvnTvffBLDnwvdK7bWzZuMsdf2Cz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMVVVH/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMVVVH/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DC61F000FF;
	Wed, 14 Oct 2026 05:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791956575;
	bh=PoK0hVS/GeRKWyLyUlGGfN7tPVhtNwXT1R8hln8LvXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XMVVVH/G77JixejyJqR4WrOWNZgKfKHv43hZXjpnlKo6ci539lT2NVWsuAboJujxl
	 oLVDP0Jsb5iRCFpRzaGc4Gc7IOU7J9H54PDhKmvGQQEsGCt0EgFeb0mA9dsjRk6Rmb
	 j7gn+mcGJUnFBYe4bNa8JjvMenkbJQ6ElV85uCO1t50O5W6Kq1yLOkXk/Gw7YU361F
	 DMBwkrRZb0iFVFNPFIng4ZBwNBquNeraGskGetSAprphHHYDTCou1nPh3+eIj50xPY
	 d35CGly1P8iO6dJpevjB6L5ksWUFyReyRdCE/An4YfzQNhZvi6GwzFst/Hwv22wM0R
	 CmQ7CnocaE4tw==
Message-ID: <sashiko-outbox-170842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] LoongArch: KVM: Clear device pointer in irqchip
 destroy callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261014052933.723303-2-cui.tao@linux.dev>
References: <20261014052933.723303-1-cui.tao@linux.dev>
 <20261014052933.723303-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 05:42:54 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] kvm: UAF window in dmsintc due to kfree before pointer clear
- [High] kvm: TOCTOU UAF and NULL deref in lockless IRQ injection
- [High] kvm: loongarch: unsynchronized device teardown leads to NULL point=
er dereference in irq injection
--

commit adcfcba3d5e2b9e1058d8d66cd600edc9fa04efd
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Clear device pointer in irqchip destroy callbacks

This commit aims to fix a dangling pointer vulnerability by explicitly
clearing device pointers in the destroy callbacks for LoongArch KVM irqchip
devices.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index bb7285c49df3a..4bd98b888e3f1 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
[ ... ]
> @@ -166,6 +166,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *de=
v)
>  		return;
> =20
>  	kfree(dev->kvm->arch.dmsintc);
> +	dev->kvm->arch.dmsintc =3D NULL;

[Severity: High]
Since the pointer is explicitly freed before it is set to NULL, does this
leave a race window for concurrent lockless readers?

If anon_inode_getfd() fails during device creation, this destroy callback
runs while the VM is still active. A concurrent interrupt injection could
read the pointer right after the kfree() but before it is cleared to NULL,
leading to a use-after-free.

>  	kfree(dev);
>  }
> =20

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index 84d84bd432d74..9a8498c5deb9d 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
[ ... ]
> @@ -675,6 +675,7 @@ static void kvm_eiointc_destroy(struct kvm_device *de=
v)
> =20
>  	kvm =3D dev->kvm;
>  	eiointc =3D kvm->arch.eiointc;
> +	kvm->arch.eiointc =3D NULL;
>  	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
>  	mutex_unlock(&kvm->slots_lock);
>  	kfree(eiointc);

[Severity: High]
Could clearing the pointer and freeing the device here without SRCU
synchronization lead to a use-after-free or NULL pointer dereference in
lockless IRQ injection paths?

If a concurrent thread is injecting interrupts (e.g., via KVM_IRQ_LINE) whi=
le
the device is being destroyed, it drops kvm->irq_srcu and locklessly calls
pch_msi_set_irq() or similar helpers. If it evaluates
kvm_arch_irqchip_in_kernel() before the pointer is cleared, it might pass
the dangling eiointc pointer to eiointc_set_irq(), which then blindly
dereferences it. Without a call to synchronize_srcu(&kvm->irq_srcu) before
freeing, this appears to result in a use-after-free.

Similarly, if the injection path reads the pointer exactly after it is set
to NULL, it passes a NULL pointer to eiointc_set_irq(), which will crash
when calling spin_lock_irqsave(&s->lock, flags).

>  	kfree(dev);
>  }

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index e7b77705c516a..5d046a1cab4e2 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
[ ... ]
> @@ -480,6 +480,7 @@ static void kvm_pch_pic_destroy(struct kvm_device *de=
v)
> =20
>  	kvm =3D dev->kvm;
>  	s =3D kvm->arch.pch_pic;
> +	kvm->arch.pch_pic =3D NULL;
>  	/* unregister pch pic device and free it's memory */
>  	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
>  	mutex_unlock(&kvm->slots_lock);
>  	kfree(s);

[Severity: High]
Does unsynchronized device teardown here lead to a similar NULL pointer
dereference in the IRQ injection path?

If KVM_IRQFD or KVM_IRQ_LINE is called concurrently, kvm_set_irq() looks up
the routing and calls kvm_set_pic_irq(). The helper unconditionally reads
kvm->arch.pch_pic and passes it to pch_pic_set_irq():

arch/loongarch/kvm/irqfd.c:kvm_set_pic_irq() {
        pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
        ...
}

If the pointer was just cleared to NULL by this destroy callback, it results
in a deterministic NULL pointer dereference when pch_pic_set_irq()
immediately calls spin_lock(&s->lock). Should there be synchronization
against concurrent IRQ routing here?

>  	kfree(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014052933.7233=
03-1-cui.tao@linux.dev?part=3D1
