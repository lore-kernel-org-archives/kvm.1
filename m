Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335573A1A3C
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856184; cv=none; b=uIopuLQ3kMKq3O80lmNED5Szb3SXTY3w0fOcZSOm9Tv0CDkCHnE0lfqGL1z3L6yLUpufyCqwUQJnsl9pHwTACrX1IlXjA9HJ9wTHMxjXd1NDgCEsxUnLDS87PM5M+X81pkGLyCgLzzFOnjFaPmZ9dFTbGIKNmZaMaOw/Brzo/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856184; c=relaxed/simple;
	bh=f9jM18+SAShTiSNZ4K7Q9s/Oivzb5sar1hceHC4/fR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KmXrvjdAaukgYFx3sP3B7i06bZT8moKv2Ar4jmHPKtd7bhrtHnf8rGmmwWiwOg+mEy3HoIzaycM0zBHw+VKt4pUImRXVj033AA6cDswFMs4ePePF/mX42B4T2b3ao+uUwkJKp1vHP1pjUj4NHwRvBBAi/5o2Iu/d7B5ivqsSu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQiia3oi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQiia3oi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CAF1F00A3A;
	Tue,  8 Sep 2026 08:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788856182;
	bh=NTpaQvRqHuaX4wLlft9vz84kF/m0x0hM/zUV4qwEufo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQiia3oiPqbhlo6ll8C7jtsYBMuVdrNcAVeWjf7UhaVrus9yhJThMTBx4KCPamWY8
	 hkUM6MzeCcVN4wB3JjTxPBaL12bR4/HTwc5kHb/EgRENCc+cGaZKxzRSNNSIiUADRi
	 9DXYx1Ni4stbGorBifxc6CnBUyoM7sw1A4M/bi5IwE+w50EhZLoi6Fj6+oJM85q1Uc
	 Cw9IGtl00FY94l1yHyo7xs4Fb95BBX2UT8Kr56K1+07MEAmKBCnEauhgFKJ2YvyyNE
	 m97GU7z5yKIBHpJux9jNYBbJXAQF3c1CPirHVQ75W/5gcp1jmLjlqTbnEQpPI3MqXm
	 fWzQHJmY1rAPQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] vfio/pci: Block for the upstream bridge lock in
 vfio_pci_core_disable()
Reply-To: sashiko-reviews@lists.linux.dev
To: YuanShang <YuanShang.Mao@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260908080946.2235849-1-YuanShang.Mao@amd.com>
References: <20260908080946.2235849-1-YuanShang.Mao@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:29:42 +0000
Message-Id: <20260908082942.B1CAF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing pci_dev_trylock(bridge) with a blocking pci_dev_lock(bri=
dge) introduces a 3-thread AB-BA-CA deadlock.
--

commit 170de39cb1fd30df6e523a31c390c9881837b836
Author: YuanShang <YuanShang.Mao@amd.com>

vfio/pci: Block for the upstream bridge lock in vfio_pci_core_disable()

This commit changes vfio_pci_core_disable() to take the upstream bridge lock
blocking instead of with a trylock. This is intended to serialize concurrent
resets of virtual functions under the same bridge.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 6757054e9d875..01f0238057c76 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -791,8 +791,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_devic=
e *vdev)
>  	 */
>  	if (vdev->reset_works) {
>  		bridge =3D pci_upstream_bridge(pdev);
> -		if (bridge && !pci_dev_trylock(bridge))
> -			goto out_restore_state;
> +		if (bridge)
> +			pci_dev_lock(bridge);

[Severity: High]
Does this blocking lock create a deadlock cycle with PCI device removal and
bus reset operations?

Replacing pci_dev_trylock(bridge) with a blocking pci_dev_lock(bridge)
introduces a 3-thread AB-BA-CA deadlock. This can freeze the involved threa=
ds
and lock the PCI bus subsystem, leading to a hung task and an unusable syst=
em.

Could this sequence occur?

Thread 1 (driver unbind): Triggers driver removal. device_release_driver()
acquires device_lock(&pdev->dev) and calls vfio_unregister_group_dev(),
which blocks waiting for the device's open file descriptors to be closed
(waiting for device->comp completion).

Thread 2 (PCI bus reset): A concurrent bus reset calls pci_bus_lock(),
which acquires pci_dev_lock(bridge) and then iterates children to acquire
pci_dev_lock(pdev) (which uses device_lock(&pdev->dev)). It blocks waiting
for Thread 1.

Thread 3 (userspace close): Userspace closes the VFIO device FD. In
vfio_device_fops_release(), the driver calls vfio_pci_core_disable(), which
now blocks on pci_dev_lock(bridge) waiting for Thread 2.

Because Thread 3 is blocked, it never reaches vfio_device_put_registration()
to signal device->comp, causing Thread 1 to wait forever.

This race condition seems triggerable when an unprivileged user closes an
open VFIO FD concurrently with a root-initiated driver unbind and/or PCI
bus reset.

>  		if (pci_dev_trylock(pdev)) {
>  			if (!__pci_reset_function_locked(pdev))
>  				vdev->needs_reset =3D false;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908080946.2235=
849-1-YuanShang.Mao@amd.com?part=3D1
