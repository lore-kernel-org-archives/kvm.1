Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3A4CA26D
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203470; cv=none; b=d8VqcXB0mJJL7fSr8tnOWDonzB6UIB9L3SZNr/4bKmcMlC+EER5kf3C93Rdzrxxw9KS9jm8E1WFzoJlNzQhSpcefaHkr86wUlaz+wmPl9P1MoWnDV7Asw8ywleghiDbuTQN2iyF7ix+RBS5M22Bgkyz0JXyuGMvLKlVeIGnuGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203470; c=relaxed/simple;
	bh=LYdnaXHyTagO2uobdTrKSjAFhOBSdBTnE6NzK95gbJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dCVs2K+Te58Z03rALPMWuDl3UMzUHTlCSOP6qXTtnfz8nZ9yTa/gqiIp3sn4MtglUlaOC9Pram384cTGTg9oYYNxwM4R4KoB2xEY5x3C0QHRTDOljTN0h78QZgg+SKwtsG/pv8f7g5lj3XNhLvNMDgwr1yJGkQlC1wOZbS9mqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1uwN2V8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1uwN2V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16441F00A3A;
	Thu, 11 Jun 2026 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781203468;
	bh=wplxPWyNtrv42NmNJJyWX3dIpzW4dxhWAKQdmgR0Ue0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1uwN2V8QuAsvNRIS9KrlX+5cX+s6DBx9YisuX69QXdAlIg7gc/HzeSPmSiYRsoxN
	 E1aDDCDi/F/SGWiDPDMwN+b50BQPIg78rfVC8EfyVVM0jOtIf/T4VDTTRXSaMq/pyM
	 ZoLhyvA5zJWmwTkQnb1HCIq62UrQZuYbZG2vMqOcKLll4cVNugA8vN1kSw6dHJkwJr
	 Y5kPqqxgL5accZeiwhReVK0OpJZAhEBjSCqT2qaucu7W7mIyyutOSTQ8r1tkUA4rP1
	 wlJuH3b5S6pZQzzzvRAYHBAMxrsEmBxtFimxyllo6llW2DN7QvRxKaCpNB6dUI7Reg
	 sBuLJM9pAvLxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vfio/pci: Latch all module parameters per device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611182528.4004073-3-alex.williamson@nvidia.com>
References: <20260611182528.4004073-3-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:44:28 +0000
Message-Id: <20260611184428.C16441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] VGA Arbiter NULL Pointer Dereference on Error Path

Pre-existing issues:
- [High] Bitfield data race breaking device interrupts and Runtime PM
--

commit 26787ee0fbb65453cacc903b9b0170155208490a
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio/pci: Latch all module parameters per device

The vfio-pci module parameters of disable_idle_d3, nointxmask, and
disable_vga latch vfio-pci policy into vfio-pci-core globals each time
the vfio-pci module is initialized. The disable_idle_d3 parameter has
already migrated to a per-device flag in order to provide consistency
for refcounted PM operations for the lifetime of the device registration.

Pull the remaining vfio-pci module-parameter policy out of vfio-pci-core
into per-device flags set at device initialization.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 9f71eae0cc947..61cf1a1996b0d 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -111,11 +107,12 @@ static inline bool vfio_vga_disabled(void)
>   */
>  static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool singl=
e_vga)
>  {
> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
>  	struct pci_dev *tmp =3D NULL;
>  	unsigned char max_busnr;
>  	unsigned int decodes;
> =20
> -	if (single_vga || !vfio_vga_disabled() || pci_is_root_bus(pdev->bus))
> +	if (single_vga || !vfio_vga_disabled(vdev) || pci_is_root_bus(pdev->bus=
))

[Severity: High]
If vfio_pci_core_register_device() fails on vfio_register_group_dev(), the
error path skips calling vfio_pci_vga_uninit():

	out_power:
		if (!vdev->disable_idle_d3)
			pm_runtime_get_noresume(dev);

		pm_runtime_forbid(dev);
	out_vf:
		vfio_pci_vf_uninit(vdev);
		return ret;

This leaves the device registered with the VGA arbiter. After the probe fai=
ls,
the driver core clears the drvdata.

Will the VGA arbiter later invoke this callback, causing dev_get_drvdata() =
to
return NULL and vfio_vga_disabled(vdev) to panic when dereferencing vdev?

> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 27aab3fdbb91d..74b950d73aef0 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h

[ ... ]

> @@ -128,6 +128,8 @@ struct vfio_pci_core_device {
>  	bool			pm_intx_masked:1;
>  	bool			pm_runtime_engaged:1;
>  	bool			disable_idle_d3:1;
> +	bool			nointxmask:1;
> +	bool			disable_vga:1;
>  	bool			sriov_active;

[Severity: High]
This is a pre-existing issue, but this patch extends the bitfield block that
has a data race.

vdev->pm_intx_masked and vdev->pm_runtime_engaged are adjacent bitfields.

In vfio_pci_core_runtime_suspend(), pm_intx_masked is updated without holdi=
ng
vdev->memory_lock:

	vdev->pm_intx_masked =3D ((vdev->irq_type =3D=3D VFIO_PCI_INTX_IRQ_INDEX) =
&&
				vfio_pci_intx_mask(vdev));

Concurrently, userspace can call __vfio_pci_runtime_pm_exit(), which takes
vdev->memory_lock and updates pm_runtime_engaged:

	if (vdev->pm_runtime_engaged) {
		vdev->pm_runtime_engaged =3D false;

Because these bitfields share the same memory byte and are updated without a
shared lock, will the read-modify-write operations race and potentially lose
one of the updates, permanently breaking device interrupts or low-power sta=
te
entry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611182528.4004=
073-1-alex.williamson@nvidia.com?part=3D2
