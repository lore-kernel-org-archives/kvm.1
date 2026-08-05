Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42017A305
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891794; cv=none; b=oYyYM0OgYvH4SKOtH6jyQoyJKcapUYaxphWpu+Fr5xW43Ew1HkMoTltCbqs6uLNbxO7A8uer3wto3l/yEj08QMe72Ewmm+YDrrek+2rTyg8Emm059pbW6RTCW1H4B/ovMVMnhzPCzS8tSu1p4sUR5jj+px0l+l9LG7aU83QZciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891794; c=relaxed/simple;
	bh=QVj27sZg1ZhkFfNnzqgZUOZwlUX4dGsL53JRMD+3C/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAOzTHfM5dd6lq7GT1SNhnOYl9T+RKJ6h18inkwvxlF/nPtOivTI4yHbnikwoXIoDG7A+I601bzR1SGaWSGM282iaEi3F/QbAntDhK3qMic/koU4lnzjtlTNSpG0Fk/G9H9+l+Do963l252b3uANI5sxFCR6T7c1zTYQH+8ez7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuWNDKjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuWNDKjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403391F000E9;
	Wed,  5 Aug 2026 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891793;
	bh=Cs4JgPNb0P4OwwXvEZMWNrNtu/42fhjT0LFu23P1vvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AuWNDKjH+fmpjVjeuFLdvW3CAN0ov1ASKn8/OHEqYKMNClvFXMQd4eDJWtwhYj7cS
	 +rdFfIhm+t1iNghstvnQ+GQMq5PiOaaU2ScjYULNkalqjXNo/lhGxwTPa4h/z+MzB8
	 oynPoVX7520t5aphYgIuqNexINRCQNjTpRWB3u47oYkmU6g/85tayS8mEw29U2GcMJ
	 Df48dOBT5gp3nqKZntvXMPobXcKMQ9OTLoWGVO47JIAyzNGsGYRx7TjhSEDsUwmAw6
	 TzlQTGXkP7ole+gqFD09CXSYYF2gvVMU4w72tmg8A/XvpdOl5UHhCZzhktOuoyHl/W
	 n32wx/Cq2g7/A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samiullah Khawaja" <skhawaja@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805003355.728299-2-skhawaja@google.com>
References: <20260805003355.728299-1-skhawaja@google.com>
 <20260805003355.728299-2-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:03:12 +0000
Message-Id: <20260805010313.403391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Acquiring `device_lock()` inside `vfio_pci_core_close_device()` in=
troduces a guaranteed AB-BA deadlock if the device is unbound from the driv=
er while still in use by userspace.
- [High] Synchronously tearing down SR-IOV VFs from the PF's `close_device`=
 path deadlocks if any VF is actively in use by VFIO.
- [High] Calling `pci_disable_sriov()` without holding `pci_rescan_remove_l=
ock` causes an immediate lockdep splat and races with PCI bus enumeration.
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) races around `device_lock(=
)` allow VFs to be enabled immediately before hardware reset, defeating the=
 purpose of the patch.
--

--- Patch [1]: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close -=
--
commit 996eca93815cca91725d215b78730f993e057c49
Author: Samiullah Khawaja <skhawaja@google.com>

vfio/pci: Disable sriov on PF device close

When a user closes a VFIO device file descriptor for an SR-IOV Physical
Function, the device is reset. This reset disrupts the VFs without notifying
the core PCI driver model. This commit disables SR-IOV prior to issuing the
PF reset so VFs are torn down gracefully at the software level.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index a113c55845e10..b36c77eb3c407 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -826,6 +826,13 @@ void vfio_pci_core_close_device(struct vfio_device *=
core_vdev)
>  #if IS_ENABLED(CONFIG_EEH)
>  	eeh_dev_release(vdev->pdev);
>  #endif
> +
> +	if (pci_num_vf(vdev->pdev)) {

[Severity: Medium]
Is it possible for VFs to be enabled concurrently right after this check?

Since pci_num_vf() is evaluated locklessly before acquiring the device lock=
, a
concurrent sysfs write to sriov_numvfs could enable VFs immediately after t=
his
returns 0, causing the teardown to be skipped.

Additionally, because the device lock is dropped before the hardware reset =
in
vfio_pci_core_disable(), a concurrent sysfs write can acquire the lock,
successfully enable SR-IOV, and release the lock before the reset occurs.

Could this recreate the exact hardware state mismatch the patch attempts to=
 fix?

> +		device_lock(&vdev->pdev->dev);

[Severity: High]
Does acquiring the device lock here introduce an AB-BA deadlock during devi=
ce
unbind?

When a device is unbound, the PCI core acquires the device lock in
device_release_driver() and invokes the driver's remove callback. For
vfio-pci, this calls vfio_unregister_group_dev(), which blocks indefinitely
waiting for userspace to close all active file descriptors.

When userspace closes the device fd, vfio_pci_core_close_device() is invoke=
d.
Because this patch tries to acquire the device lock, the fd release thread
will block forever waiting for the unbind thread, and the unbind thread will
wait forever for the fd release thread to finish.

> +		vfio_pci_core_sriov_configure(vdev, 0);

[Severity: High]
Can tearing down VFs from the PF's close path deadlock if a VF is actively =
in
use by VFIO?

When vfio_pci_core_close_device() calls pci_disable_sriov(), the PCI core
synchronously removes all VF devices from the bus. If a VF is also bound to
vfio-pci and currently opened by userspace, removing the VF triggers
vfio_pci_remove(), which blocks indefinitely until the VF file descriptor is
closed.

If a single process holds both the PF and VF open and exits, exit_files()
schedules the fput() for both file descriptors sequentially. If the PF is
closed first, the thread hangs here waiting for the VF to close, preventing
the VF's fput() from ever running.

[Severity: High]
Does this code trigger a lockdep warning by manipulating the PCI bus topolo=
gy
without the required lock?

Calling vfio_pci_core_sriov_configure() here ultimately calls
pci_stop_and_remove_bus_device() to remove VFs from the PCI bus. That funct=
ion
enforces a strict locking requirement via
lockdep_assert_held(&pci_rescan_remove_lock).

Because this global mutex is omitted, closing a PF with active VFs could ra=
ce
against concurrent PCI hotplug or sysfs rescan operations.

> +		device_unlock(&vdev->pdev->dev);
> +	}
> +
>  	vfio_pci_dma_buf_cleanup(vdev);
> =20
>  	vfio_pci_core_disable(vdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805003355.7282=
99-2-skhawaja@google.com?part=3D1
