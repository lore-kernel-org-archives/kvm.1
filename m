Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222734F498
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101638; cv=none; b=DYg07s6i/umuPVIDkgKsadcgXjFzcw6/RY2qcfcbJngZnUs9+IQkZ1jQVJBks2yfYSbiqhCclN9n3NbVqyBuGAd5+3k5aZ0QpR71iD1ZVJzcKfK6jbcMV4H/1yg9U+kli4f7NBrU5MsxlhJoz6lTZ+GCYiKF62hNJ/lzHuljk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101638; c=relaxed/simple;
	bh=kBkkjOgcUtMoxYER4emMeXHkatQJ+6+2LxH/ED+8ftQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tM0+98B7PDDASmGJG2DSfR62QaxWO13qLwAuEY98FIOwiiE7Xa1Ulx0LbJtaXWjagIVGJ5IEX7cueFgyyq492P8r4xOLOsFODDdBKCY1w78auTz4XHBtFffxIMJlfpHzbFO29P+XyrooQKgAzTiknKBoAMFN7wFbF1/AvSgEgRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3uzEpAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3uzEpAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA31F000E9;
	Mon, 22 Jun 2026 04:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782101636;
	bh=aId6Tjq2xVlrrwcqKUhKNf6Ww6GLKRpnwWbBu4hLgp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3uzEpASLo5mc/CLlsCxYAgydWfmGNmCMF9a1i5mTz63kgvc0E6J+tLbG2jIdNsJO
	 8AWctVJ2dUZhF/RYq/9GTwZPEXHdIzp8K2PSpeA6EydQM3M1kDHpTP8E1ir21D0rzS
	 qwyCSpm6r8iQ3ELaJeRfUMiegRrsQ5PwLaZEwIqNXR3w3tLB6mZRoV8JZ9QYTuJjk+
	 nds3DI8Zjm9wZBXlj9Fc8527gn2TrITTQYz45Yhacgropv6ULmr+OU7uGDydBTSxb5
	 EK7YiESuwnaixaAPjMuPRKLHQks2svFei1jO4ylY46CgA1JkBjyfOCLrifzKmxmGuA
	 XM1R3pIWlvfGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/16] KVM: device: Add test device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-9-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-9-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:13:55 +0000
Message-Id: <20260622041356.B8AA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Guest-triggerable out-of-bounds memory access in mmio_read and=
 mmio_write due to invalid size constraints and missing length validation.
- [Critical] Use-after-free vulnerability due to missing IO bus unregistrat=
ion during device release.
- [High] Registering the KVM IO device without holding `kvm->slots_lock`.
- [High] Memory leak of the parent `struct kvm_device` in the device releas=
e callback.
- [High] Ignoring the return value of `kvm_io_bus_register_dev()` leaves th=
e device silently non-functional on failure.
- [High] Incorrect error handling sequence in `kvm_init()` leads to a resou=
rce leak of VFIO ops or uninitialized teardown.
--

commit 9fe1265e6415d3c7d4c794808d6fc306d06a4e0e
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

KVM: device: Add test device

Create a KVM test device to help verify mmio reads and write emulation.
This is a simple device that will store the data in a buffer on writes
and echo back that stored data on a read.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 881f92d7a469e..d9bbe570eddd5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -6559,6 +6564,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_alig=
n, struct module *module)
>  err_gmem:
>  	kvm_vfio_ops_exit();
>  err_vfio:
> +	kvm_mmio_test_ops_exit();
> +err_mmio_test:
>  	kvm_async_pf_deinit();

[Severity: High]
Does this error handling sequence leak VFIO ops or tear down uninitialized
state?

If kvm_mmio_test_ops_init() fails, the code jumps to err_mmio_test, which
only executes kvm_async_pf_deinit() and skips kvm_vfio_ops_exit().

Conversely, if kvm_vfio_ops_init() fails, the code jumps to err_vfio and
executes kvm_mmio_test_ops_exit() before it was initialized. Should the lab=
els
reverse the initialization sequence perfectly?

> diff --git a/virt/kvm/mmio_test.c b/virt/kvm/mmio_test.c
> new file mode 100644
> index 0000000000000..fa84c2b4c5fcf
> --- /dev/null
> +++ b/virt/kvm/mmio_test.c
[ ... ]
> +struct mmio_test {
> +	struct kvm *kvm;
> +	struct kvm_io_device dev;
> +	unsigned long start;
> +	unsigned long size;
> +	char cache[16];
> +};
[ ... ]
> +static int mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
> +		     gpa_t addr, int len, void *val)
> +{
> +	struct mmio_test *mmio_test =3D kvm_to_mmio_test_dev(dev);
> +
> +	if ((addr - mmio_test->start) >=3D mmio_test->size)
> +		return -1;
> +
> +	/* Write back cached value */
> +	memcpy(val, &mmio_test->cache[(addr - mmio_test->start)], len);

[Severity: Critical]
Can a guest trigger an out-of-bounds read of host memory here?

The cache array is 16 bytes long, but mmio_test->size is configured to 0x16
(22 bytes) in mmio_test_create(). The boundary check permits accesses up to
offset 21.

Furthermore, is there a check to ensure that the access offset plus len
does not exceed the bounds of the array?

> +	return 0;
> +}
> +
> +static int mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
> +		      gpa_t addr, int len, const void *val)
> +{
> +	struct mmio_test *mmio_test =3D kvm_to_mmio_test_dev(dev);
> +
> +	if ((addr - mmio_test->start) >=3D mmio_test->size)
> +		return -1;
> +
> +	/* Cache value */
> +	memcpy(&mmio_test->cache[(addr - mmio_test->start)], val, len);

[Severity: Critical]
Similarly, can this allow a malicious guest to trigger a heap buffer overfl=
ow?

Without a check verifying that the access length fits within the remaining
space in the cache array, a large or offset write could overwrite adjacent
host kernel memory.

> +	return 0;
> +}
[ ... ]
> +static int mmio_test_create(struct kvm_device *dev, u32 type)
> +{
> +	struct mmio_test *mmio_test;
> +
> +	mmio_test =3D kzalloc(sizeof(*mmio_test), GFP_KERNEL);
> +	if (!mmio_test)
> +		return -ENOMEM;
> +
> +	mmio_test->start =3D 0x20000000;
> +	mmio_test->size =3D 0x16;
> +
> +	dev->private =3D mmio_test;
> +
> +	kvm_iodevice_init(&mmio_test->dev, &mmio_ops);
> +	kvm_io_bus_register_dev(dev->kvm, KVM_MMIO_BUS, mmio_test->start,
> +				mmio_test->size, &mmio_test->dev);

[Severity: High]
Does kvm_io_bus_register_dev() require kvm->slots_lock to be held?

The function modifies RCU-protected bus arrays and has a lockdep assertion
for kvm->slots_lock. This is called under kvm->lock but appears to be missi=
ng
the slots_lock acquisition.

[Severity: High]
What happens if kvm_io_bus_register_dev() fails here?

The function could return -ENOMEM or -ENOSPC, but its return value is not
checked. Could this leave the test device reported as fully instantiated
without being able to receive MMIO traps?

> +
> +	return 0;
> +}
> +
> +static void mmio_test_release(struct kvm_device *dev)
> +{
> +	kfree(dev->private);

[Severity: Critical]
Does freeing dev->private without unregistering the io device create a
use-after-free?

When the file descriptor is closed, the device state is freed, but the
embedded kvm_io_device remains registered on the KVM MMIO bus. Any subseque=
nt
guest MMIO access to that region would route the request to this freed memo=
ry.
Should this call kvm_io_bus_unregister_dev() first?

[Severity: High]
Is the parent kvm_device leaked here?

When a KVM device implements the release callback instead of destroy, it is
responsible for freeing the core kvm_device object allocated by KVM core.
Should there be a call to kfree(dev) before returning?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D9
