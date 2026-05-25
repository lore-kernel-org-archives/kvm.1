Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338933E367
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703924; cv=none; b=h8a5o//ToiEM5tsV49obouMJXpDzE+J9UHCA0yZn/Qa270RcrDm1v2rKsBj/tMOOR5TsshQ1pDfPuSzp1yHMmXsODjwdSexfn18AqFcJsScNJTrD2rxUdvzBPK0jWidIvrwr9AUlWwASh+ajZQ/RolxDGB9JLKc3SFU+3/uKNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703924; c=relaxed/simple;
	bh=VGwTMWT39R9BAyiNPZ4hQgQ4TYpWAM+0yGx122L/U2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TNEpyHVR6EWn0OFMkry2GS+Ms82a0bSERLe97rpHZuKLgfH5ctykDksX+1ts6pMDc2Ezpv2tuWgdrPwTsa2UrnA2weTtFSr+NrltB8CYX1m8oWyn9gETFfeux63/y2uT+6fmqsFKdDaKUgmTJv1Q57GuUgwiQhJM1cuQeUU31e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNzLBFNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNzLBFNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FF21F000E9;
	Mon, 25 May 2026 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779703922;
	bh=FnMAJ5cKJ0PIrix/hhvkZQMdXAxiguU0pErf0q03J40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNzLBFNyZypVQi2KBdlbNA7C33ibhs10i6Gl4GEsJON7EFk0YtZ1SaRrYFe8wHURB
	 zJE63uyhDV2HvnF+mLsafkcYGrp4sNxhERZFkY3bF1QLzaT/TLpEw/QfGsnfXnCkJT
	 PQXf9IQReQldI6iEK58jF4Iz5ZLRf/gan5nPeVmgZ6m86hYYii6a0qVh0SfF/LAr/C
	 U27q0ESr0gUpK/xYWTjIhfmbh4r9rDoXO/eo26E/8z7MthLNlGtFyecC5AMpEIQMXE
	 kMdLN5zU2zVMywSJq810cj40wiPHimwXsuXXKH5Xo7CiQ/QyQH9H1Fa6lSo+Jw2oMP
	 oO61r0HXF1ujg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net] LoongArch: KVM: Add missing slots_lock for IO
 bus device register/unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zeng Chi" <zeng_chi911@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525092633.1706633-1-zeng_chi911@163.com>
References: <20260525092633.1706633-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 10:12:02 +0000
Message-Id: <20260525101202.B9FF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Device destruction callbacks free the device state but fail to cle=
ar the corresponding pointers in the `kvm->arch` structure, enabling an exp=
loitable Use-After-Free.
--

commit 42b850769c4b9c6a7cd2f75195e998f622a6c28d
Author: Zeng Chi <zengchi@kylinos.cn>

LoongArch: KVM: Add missing slots_lock for IO bus device register/unregister

This commit fixes missing slots_lock protection around IO bus device
unregistration in the LoongArch KVM interrupt controllers.

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
>  	kfree(dev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is it possible that this lea=
ves
a dangling pointer in kvm->arch.eiointc?

If anon_inode_getfd() fails during device creation (for example, due to file
descriptor exhaustion), kvm_ioctl_create_device() will call the device's
destroy callback. This function frees eiointc, but kvm->arch.eiointc is nev=
er
set back to NULL.

Could this allow a malicious userspace program to trigger a use-after-free
later? For instance, if the VM continues running and userspace successfully
creates the other IRQ devices (ipi and pch_pic), kvm_arch_irqchip_in_kernel=
()
could return true based on the dangling pointer.=20

A subsequent KVM_IRQ_LINE ioctl might then route to pch_pic_set_irq() and
dereference the freed memory via eiointc_set_irq().

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 1f6ebbd0af5c8..4fa0897d7bdb0 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c

[ ... ]

> @@ -447,7 +447,9 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
> =20
>  	kvm =3D dev->kvm;
>  	ipi =3D kvm->arch.ipi;
> +	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
> +	mutex_unlock(&kvm->slots_lock);
>  	kfree(ipi);
>  	kfree(dev);
>  }

[Severity: High]
This is a pre-existing issue, but does this face the same dangling pointer
risk as kvm_eiointc_destroy() above? We free the device state but do not cl=
ear
kvm->arch.ipi.

> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index aa0ed59ae8cf9..175a630aceb41 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c

[ ... ]

> @@ -481,7 +481,9 @@ static void kvm_pch_pic_destroy(struct kvm_device *de=
v)
>  	kvm =3D dev->kvm;
>  	s =3D kvm->arch.pch_pic;
>  	/* unregister pch pic device and free it's memory */
> +	mutex_lock(&kvm->slots_lock);
>  	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
> +	mutex_unlock(&kvm->slots_lock);
>  	kfree(s);
>  	kfree(dev);
>  }

[Severity: High]
This is also a pre-existing issue, but similarly, should we clear
kvm->arch.pch_pic here after freeing the device memory to avoid leaving a s=
tale
pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525092633.1706=
633-1-zeng_chi911@163.com?part=3D1
