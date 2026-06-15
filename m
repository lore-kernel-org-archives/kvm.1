Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418CB30BB8A
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551764; cv=none; b=XVMmgYC9CLYXdDDwdHg8U1KfwJN8Y/imnZKgnqbw/K+Ud9EB1PXGK8JInJmKxagYvqjPVEs8VC4Y4hReOlZUxZScXPFFkKBA8Zrp/smaKym717XfOKaREIogSUI7/w5WLZLgVmrsipNUN/6NVYvm47kkUz6HIVet9wm+9ujVRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551764; c=relaxed/simple;
	bh=nRii/QIOpTWi5JDuCGHslYGToz4Wovn0rtTfWiOoxRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fDOCGd5UJS3SQTF9/LAx5w42q8fu0N6ijxHh6g66faeGiZXIv6BtLFzblVDi1p16F9/0p6+9yQTrvG72LRNQk+lBTlikOFXfSHOXgDjn2gCR2vYeZU5qglH1poRxAlbGXVrCIzltbf5Z9bSu9YPyNSOJ7+PJqISsDTvhNp+57jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLU0bakq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLU0bakq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79CE1F000E9;
	Mon, 15 Jun 2026 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781551762;
	bh=/BgjgBLSNwfKouMAdNIDEjjEN2Ji5lb+2Pm+tDuyVC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLU0bakqgnqHtszomUptTeYJprdutviIXWw/jykJt5hFQGd0M/agwThoYNoYelzZP
	 HBdfozt1gWQcVpXpVuIk7hpbzhOX3eeFcJzIic+J4QIBgp1yWBmmUF6ik2BlisLPQY
	 q4Gj9j/DxIe6qU2/rM0g947/VVLex+JJTyckNm82XIXnSe6P+ocPpXPdXIK8rSfgCX
	 PFieYSS8SuwtXU/VAKwLjlyGgNbE7VflC99LQGvCfHyN0s2vI72lKwFhSV8yfFfejs
	 zVpFvgSL/GB7+tCtG5AnGkix9DzukCpVlG+MO/hLHKBFqZg3TLpH96DHyhKnwlC80T
	 28vhZ7Gx7TmEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] vfio/pci: Latch disable_idle_d3 per device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260615191241.688297-2-alex.williamson@nvidia.com>
References: <20260615191241.688297-2-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 19:29:22 +0000
Message-Id: <20260615192922.A79CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver's runtime suspend callback does not call synchronize_ir=
q() before powering down the hardware, despite using a shared interrupt.
--

commit a79806f5080762f4f8088e2fb816e867d4b78d1c
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio/pci: Latch disable_idle_d3 per device

This commit resolves unbalanced PM operations by latching the disable_idle_=
d3
flag into vfio_pci_core_device at initialization. This ensures the device
operates with a consistent value rather than relying on a global variable t=
hat
might change at runtime. It updates usages across the driver to use the
per-device flag.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index a28f1e99362c1..f8d1755de2ce0 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -2239,7 +2241,7 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
> =20
>  	dev->driver->pm =3D &vfio_pci_core_pm_ops;
>  	pm_runtime_allow(dev);
> -	if (!disable_idle_d3)
> +	if (!vdev->disable_idle_d3)
>  		pm_runtime_put(dev);

[Severity: High]
This is a pre-existing issue, but does the runtime suspend callback for the=
se
PM operations need to call synchronize_irq() before returning?

The driver requests the INTx interrupt with IRQF_SHARED (via
vfio_intx_enable()). According to the Power Management subsystem guidelines,
drivers using IRQF_SHARED must call synchronize_irq() in their runtime
suspend callback before allowing the PCI core to power down the hardware.

Without synchronize_irq(), an interrupt handler executing concurrently on
another CPU could continue executing and attempt to access the device's PCI
configuration registers (e.g., inside pci_check_and_mask_intx()) after the
device has transitioned to the D3hot (powered off) state.

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_core_runtime_suspend() {
    ...
    vdev->pm_intx_masked =3D ((vdev->irq_type =3D=3D VFIO_PCI_INTX_IRQ_INDE=
X) &&
                            vfio_pci_intx_mask(vdev));

    return 0;
}

Could accessing registers of a powered-down device cause SError panics or
Target Aborts on some architectures, crashing the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615191241.6882=
97-1-alex.williamson@nvidia.com?part=3D1
