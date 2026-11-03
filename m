Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665859;
	b=LN3EQvEc643dVV3+7dUjs8VKcc1GhqVd1ezovG52FUsGCF8tWFj8NMXCYtj0sIX80O/n
	 rGXn9DsU/RRI3NxualOLarSYWTV0MNK68pV6nqup23KQRdBVvWgt/sG5TEgK/eNL/tmV0
	 tl2XzmJMuy+CK3F3kI9VNOOI/aHyVOjWJf6kJFc34K2T65ayH2/0UaVy1Pttim+ikAaNR
	 Sj4XRt1WVY9jEGSpa7dPCDzHoEqe+FXl9dgmBIN+UM66S3/l0W1rc1mriQg2DYsXDbpNp
	 a7l3DGRPjtzRIvr+LFxZd7YHoAZHhI4fKM3jNnUevYivCcUrwsMgZ37NkbOWyMEYJiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665859;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ntLTTunZKtoEAt81mI9nkVCq18xQNiiC79lo7rCkZcU=;
	b=CQI1LrNK/zyFTDMQ9QKPdNQ84t0xrrWRkKE8YRF0A9ldyNA8hIOSreZtX4dQg7uCv91M
	 wk6tYb+ihfhLqMuCfP7dwnqNXMdzJJ0/JEQ6gCkYdntAKOq6Kfv8ZntefBlnBcwvVsf4g
	 01++Ny+7eKswXC3LThTma6O/GO6eFB5gL2ijxM4VkuPLPxDlQ9I7FAx+W1eApt8JLJPVe
	 kuPWh2WKouZ8EUNtuSEkuibIQv9sdP6ic9TJAmlMJGTJ9UBHLUPSmBzHM3SiJ4xv+QYPA
	 bcmmcaeVNaSadpU+rVQfWwI9xDrNdZrzzC9TaV+adgPcr6X/SNK6/7JqNxfAYD1Qqyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFIxYTeE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E4606A324
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFIxYTeE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289AC1F000C1;
	Tue,  3 Nov 2026 00:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665858;
	bh=ntLTTunZKtoEAt81mI9nkVCq18xQNiiC79lo7rCkZcU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CFIxYTeE+AvWNYsAHeb8sIu9s79AA4JK2dSN4RHH3XUiS58mW1MTkVRdWyhCMIMuh
	 7T58jW4z2Zf018OLzEJevfmVyFkcWMqbtO8GvstqxSjjI/IPtyC94kwbPeZ0LKiiYU
	 HIia9gyq+2ZlJZ5IF75wh4ZSx0AEhUKro92Qvv9CyW3So25LIUAI3o3YgeKAhY7HgO
	 EMjx1HAou7DQ92bpCz0Wm0y4PMq+5o/KrBZTJ2B1cbW2CbdIMCKD/XyDcYytox2pIX
	 evw+wlUY54m1UOr7/Hkfuc8KDc12vB3VGJNkND/gujWxyyhMWY8nWW9sZH+BXTMr+4
	 59syW8yFVUoJQ==
Message-ID: <sashiko-outbox-194380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] vfio: selftests: Skip tests when the IOMMU mode
 is not available
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kvm@vger.kernel.org
In-Reply-To: <20261103002205.3348519-3-dmatlack@google.com>
References: <20261103002205.3348519-1-dmatlack@google.com>
 <20261103002205.3348519-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:30:57 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vfio: selftests: iommu_mode_is_available() misses CONFIG_VFIO_GR=
OUP check
--

commit 254a1695e07cd0eb0e8a8f399f3d939f79af60d2
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Skip tests when the IOMMU mode is not available

This commit adds iommu_mode_is_available(), iommu_mode_unavailable_msg(),
and SKIP_IF_IOMMU_MODE_UNAVAILABLE() to skip VFIO selftest variants when
the requested IOMMU mode is unavailable on the system.

> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/sel=
ftests/vfio/lib/iommu.c
> index 0393536370e79..526bb21f27666 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -111,6 +111,26 @@ static const struct iommu_mode *iommu_mode_lookup(co=
nst char *iommu_mode)
>  	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
>  }
> =20
> +bool iommu_mode_is_available(const char *iommu_mode)
> +{
> +	if (!iommu_mode)
> +		return iommu_mode_detect();
> +
> +	return iommu_mode_probe(iommu_mode_lookup(iommu_mode));
> +}

[Severity: Medium]
Can iommu_mode_is_available() return true for iommufd_compat_type1,
iommufd_compat_type1v2, and NULL when CONFIG_VFIO_GROUP is disabled (for
example on a cdev-only VFIO kernel with CONFIG_IOMMUFD=3Dy and
CONFIG_VFIO_DEVICE_CDEV=3Dy) or when the vfio module is not loaded?

In tools/testing/selftests/vfio/lib/iommu.c, iommu_mode_probe() only checks
for /dev/vfio/devices when !mode->container_path:

	/* iommufd mode requires VFIO device cdevs (CONFIG_VFIO_DEVICE_CDEV). */
	if (!mode->container_path && access("/dev/vfio/devices", F_OK))
		return false;

	fd =3D open(path, O_RDWR);
	if (fd < 0)
		return false;

	available =3D !mode->container_path ||
		    ioctl(fd, VFIO_CHECK_EXTENSION, mode->iommu_type) > 0;

For iommufd_compat_type1 and iommufd_compat_type1v2, mode->container_path
is "/dev/iommu". Because drivers/iommu/iommufd/vfio_compat.c is compiled
into iommufd unconditionally regardless of CONFIG_VFIO_GROUP, opening
/dev/iommu and calling VFIO_CHECK_EXTENSION succeeds whenever iommufd is
present.

However, vfio_pci_device_init() and device_init() in
vfio_pci_sriov_uapi_test.c route all modes with a non-NULL
mode->container_path through vfio_pci_container_setup() ->
vfio_pci_group_setup(), which opens /dev/vfio/<group_id> and asserts on
failure when CONFIG_VFIO_GROUP is disabled.

Should iommu_mode_probe() also verify that VFIO group support is available
(such as checking access("/sys/class/vfio", F_OK) =3D=3D 0) when
mode->container_path is non-NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103002205.3348=
519-1-dmatlack@google.com?part=3D2
