Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FE1A9F82
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482528; cv=none; b=BNSW6pd1b0XIekXlSdAclDQqV83SmByO+MVubVrwre0ROvy6Elg8X3Efe/GJm9OIk+mTeDOX+BnOhmrY0jBr7GsKVWgMDQi12Jj/AHVV24aUdQKPms45EBQS8peLKED964AY4ERhIIEbR1F5ONqDyJLxIqVEMvRtGtK0A/ZeAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482528; c=relaxed/simple;
	bh=92U6MO2FI8mTqbjEKBsGekq6Pn6Z+sLxECqjp262TKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kn2XN+1rwvUEKypb+y74o3kYxxYLz58zQgzezDfyxDBdYYfNeNutMgxATaClbXSRz5LSxqWbs0kH7qMea8BQr3jsYz2FtDS4hRnyDQyRwW02ncNVZ94UHyLxkuLovrARTetKs/pQ0CigRa8jUEagawEXdslDKXIkKEqj4CH+rWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKFIf3+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKFIf3+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD9C1F000E9;
	Wed,  8 Jul 2026 03:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482527;
	bh=xP5qE1TAgAkq+sX5e0fxVVWdycbxhPTayDxs6juYPyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKFIf3+IDLfBWUMvY9+2QC9YnyTzJHEOjFQb11/1buQdu4GMeKmwigLTF7eWIDHBp
	 aCVEKrtRzS5LpZ09h6k/6I5mf96TwBre5IPX+uGU6kq/4icasADDh/iyZOAgB1ovwk
	 a0PPHRsx/B6xk/kN6yc1JcA9tdq+ROmemYkVSPTYf3myqA/Dr4wqMlx99h8zEg7BsN
	 K0DrVcOZNuGIh06TKHx0joHrdkT/xm5aU1qXqPXGyVlzANAdkojyauBDN3aS+jndDS
	 b7ViOtBSRby19XN+NZyWPZHCWLedVp847WY7os/m/0gkuuEi9fL8DQvaDMNdNdN4X9
	 rLJhXnGidMN9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/17] KVM: device: Add test device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-10-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-10-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:48:46 +0000
Message-Id: <20260708034846.BDD9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] `kvm_io_bus_unregister_dev` is called without holding `kvm->slots_=
lock`, which can lead to a lockdep splat and data races.
- [High] Passing a `struct kvm_device *` to a function expecting `struct kv=
m_io_device *` causes silent unregistration failure and a Use-After-Free.
- [Medium] Off-by-one bounds check in `mmio_read` and `mmio_write` incorrec=
tly rejects valid memory accesses at the upper bound of the device.
- [Medium] Missing `.release` callback allows userspace to leak memory and =
exhaust IO bus slots.
- [Medium] Concurrent lockless reads and writes to the shared `mmio_test->c=
ache` buffer result in data races.
- [Low] Undeclared variables `ret` and `kvm` in `mmio_test_create()` cause =
hard build failures.
--

--- Patch [10]: [PATCH v3 10/17] KVM: device: Add test device ---
commit 245981a653b22b71de31531543fae6c504801423
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

KVM: device: Add test device

Create a KVM test device to help verify mmio reads and write emulation.
This is a simple device that will store the data in a buffer on writes
and echo back that stored data on a read.

[ ... ]

> diff --git a/virt/kvm/mmio_test.c b/virt/kvm/mmio_test.c
> new file mode 100644
> index 0000000000000..bd5f21a43ba87
> --- /dev/null
> +++ b/virt/kvm/mmio_test.c
> @@ -0,0 +1,104 @@

[ ... ]

> +static int mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
> +		     gpa_t addr, int len, void *val)
> +{
> +	struct mmio_test *mmio_test =3D kvm_to_mmio_test_dev(dev);
> +
> +	if ((addr - mmio_test->start + len) >=3D mmio_test->size)
> +		return -1;

[Severity: Medium]
Does this bounds check incorrectly reject valid memory accesses?

If an MMIO read ends exactly at the size boundary, the offset plus length
would equal the size, causing the greater-than-or-equal check to fail.
Should this be a strictly greater-than check instead?

> +
> +	/* Write back cached value */
> +	memcpy(val, &mmio_test->cache[(addr - mmio_test->start)], len);

[Severity: Medium]
Can concurrent lockless reads and writes to the shared cache buffer result
in data races?=20

Multiple vCPUs performing concurrent MMIO reads or writes to the same
physical address might cause torn reads or corrupted states.

> +	return 0;
> +}
> +
> +static int mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
> +		      gpa_t addr, int len, const void *val)
> +{
> +	struct mmio_test *mmio_test =3D kvm_to_mmio_test_dev(dev);
> +
> +	if ((addr - mmio_test->start + len) >=3D mmio_test->size)
> +		return -1;

[Severity: Medium]
Does this bounds check improperly reject legitimate writes?

Similar to the read path, a write ending exactly at the boundary evaluates
to true for the greater-than-or-equal check and is rejected.

> +
> +	/* Cache value */
> +	memcpy(&mmio_test->cache[(addr - mmio_test->start)], val, len);

[Severity: Medium]
Are writes to the shared cache susceptible to data races from concurrent
vCPUs accessing the same device region?

> +	return 0;
> +}
> +

[ ... ]

> +static int mmio_test_create(struct kvm_device *dev, u32 type)
> +{
> +	struct mmio_test *mmio_test;
> +
> +	mmio_test =3D kzalloc_obj(struct mmio_test, GFP_KERNEL);
> +	if (!mmio_test)
> +		return -ENOMEM;
> +
> +	mmio_test->start =3D 0x20000000;
> +	mmio_test->size =3D 16;
> +
> +	dev->private =3D mmio_test;
> +
> +	kvm_iodevice_init(&mmio_test->dev, &mmio_ops);
> +	mutex_lock(&kvm->slots_lock);
> +	ret =3D kvm_io_bus_register_dev(dev->kvm, KVM_MMIO_BUS, mmio_test->star=
t,
> +				mmio_test->size, &mmio_test->dev);

[Severity: Low]
Will this cause build failures due to undeclared variables?

It looks like kvm and ret are not declared in the scope of mmio_test_create.
Should this be dev->kvm->slots_lock and a local int ret declaration?

> +	mutex_unlock(&kvm->slots_lock);
> +
> +	if (ret < 0)
> +		kfree(mmio_test);
> +
> +	return ret;
> +}
> +
> +static void mmio_test_destroy(struct kvm_device *dev)
> +{
> +	struct mmio_test *mmio_test =3D kvm_to_mmio_test_dev(dev);

[Severity: High]
Does passing a struct kvm_device pointer to kvm_to_mmio_test_dev lead to
silent unregistration failures and a use-after-free?

The kvm_to_mmio_test_dev function uses container_of expecting a
struct kvm_io_device pointer, but dev here is a struct kvm_device. This
calculates an invalid pointer base.

> +
> +	kvm_io_bus_unregister_dev(dev->kvm, KVM_MMIO_BUS, &mmio_test->dev);

[Severity: High]
Is kvm_io_bus_unregister_dev being called without holding the required
kvm->slots_lock?

Modifying the KVM IO bus without the required lock can corrupt the shared
bus array or cause lost RCU pointer updates.

> +	kfree(dev->private);
> +	kfree(dev);
> +}
> +
> +struct kvm_device_ops kvm_riscv_mmio_test_device_ops =3D {
> +	.name =3D "kvm-riscv-mmio_test",
> +	.create =3D mmio_test_create,
> +	.destroy =3D mmio_test_destroy,
> +};

[Severity: Medium]
Is it intentional to omit the .release callback here?

Without it, userspace might leak memory and exhaust IO bus slots by repeate=
dly
creating and closing test devices using the KVM_CREATE_DEVICE ioctl.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D10
