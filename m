Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E333DD86F
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942959; cv=none; b=mhVeafG0MRuKfeJYzwmOD4W6VUtIr+qdvtBezuYimUb1zLKLcYf6D4b0PqFg952T2RP5PlGQqOixx4sQP+XPXozCJHRPaILufg4lyebNUj4fCMwdTwzgr0Qao2tykvOhfEfdtz3SlBL0nE/odLCltCKrvzTcPcsuABZzbbKbLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942959; c=relaxed/simple;
	bh=2Tw6d79+RZj0yB4HhQNDfDoy/A/ckujvR3JQH2oMqc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BrAK+Gkmi22LXEb3BN1PoXIE4HDIT1mI3Uxq86CU80WZI8Qq/NqJd5CpbJdVmBwFoJBy/Rn8D57gGG8ln5H62RgvOZ7klbEwE8avRfUpuQ0xYXa6SRh+mY2+4+wMKX2Kc4Z13ApP1S40fZAWXRwO7wR0BWYWbg/YGXgRI5a6keM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRlpQ7S9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRlpQ7S9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844651F00893;
	Mon,  8 Jun 2026 18:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942957;
	bh=0fKGuESUc2X53r4T4ZWo3SfPVcILKaf4yDCzLSOSETU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRlpQ7S9C585L+GRQ8sK3WniE+hhyKtfIDb1e/rX1OV0gZaqlXYJDQU56fLx3hbDM
	 NXtBYRyJ4CJ85uy6QDWT0QQcWGT9rR9jHf+FqfMZ0PEvsgqpv/q2/KhO6hcG/EsQJk
	 dbg1bP03aslBRpgipAlwFu0LS6ZYK/KRYHnW9phAfDLTJ+bHpDXqOFDn2CbnCb0nfo
	 lx78Y+koaFzxp2mo72QzWnogghkjUgMQ1PTvcHZ23HBnKRV0HnaQT74tMLJdwGQeLz
	 FcaHffN6G3id1qPSKEPLlRkQFh+d/TYuC4gHIpfbByllliqTICFvFsmoImj7XbcYsv
	 JPmDoPQGWdUxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608171850.62829-4-oelghoul@linux.ibm.com>
References: <20260608171850.62829-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:22:37 +0000
Message-Id: <20260608182237.844651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The UAPI structure `vfio_device_feature_zpci_fmb_read` uses a `voi=
d __user *` pointer instead of an `__aligned_u64`, breaking 32-bit compat u=
serspace execution on 64-bit kernels.
- [Medium] Double enabling the FMB succeeds and silently resets the state, =
violating the explicitly documented UAPI contract that specifies it should =
fail.
--

commit 3703a22be992c7a39e18f49c3a21771a62d41260
Author: Omar Elghoul <oelghoul@linux.ibm.com>

vfio-pci/zdev: Add VFIO FMB device features

Introduce new VFIO features for zPCI devices to provide FMB passthrough to
userspace. Allow the user to enable or disable the FMB using the SET-only
feature VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read
the latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ.

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index 0990fdb146b78..09454495ee230 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
[ ... ]
> @@ -167,3 +167,60 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core=
_device *vdev)
[ ... ]
> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, =
u32 flags,
> +				     void __user *arg, size_t argsz)
> +{
[ ... ]
> +	if (fmb_enable.enabled)
> +		return zpci_fmb_reenable_device(zdev);

[Severity: Medium]
Does this violate the explicitly documented UAPI contract?=20

The UAPI documentation for VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE states that
the feature "fails on attempt to double enable/disable". However,
zpci_fmb_reenable_device() unconditionally succeeds and resets the hardware
block if already enabled.

Will userspace applications expecting an error on double-enable instead
silently lose counter data?

> +	return zpci_fmb_disable_device(zdev);
> +}
> +
> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u3=
2 flags,
> +				   void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
> +	struct zpci_fmb fmb_temp =3D {0};
> +	int ret;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeo=
f(fmb_read));

[Severity: High]
Can this check reject valid 32-bit process payloads on 64-bit kernels?

Because vfio_device_feature_zpci_fmb_read defines data as a pointer type,
it has different sizes for 32-bit and 64-bit userspace (4 bytes vs 8 bytes).
When a 32-bit process computes argsz and passes it to the ioctl,
vfio_check_feature() computes the minimum required payload size based on the
64-bit kernel structure size (8 bytes).

Since the 32-bit process provides a smaller 4-byte payload size, will this
cause the ioctl to unconditionally fail with -EINVAL and break compat
userspace execution?

> +	if (ret !=3D 1)
> +		return ret;
> +
[ ... ]
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..3988e8690e0b3 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
[ ... ]
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI=
 device.
> + *
> + * enabled is treated as a bool, so any non-zero value evaluates to true=
. This
> + * feature fails on attempt to double enable/disable.
> + *
> + * Returns: 0 on success, -1 and errno set appropriately on error.
> + */
> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 13
[ ... ]
> +struct vfio_device_feature_zpci_fmb_read {
> +	void __user *data;
> +};

[Severity: High]
Is it safe to use a variable-sized pointer type in a UAPI structure?

As mentioned above, this pointer will be 4 bytes for 32-bit userspace and
8 bytes for 64-bit kernels. Should this UAPI structure use a fixed-size type
like __aligned_u64 for the pointer instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608171850.6282=
9-1-oelghoul@linux.ibm.com?part=3D3
