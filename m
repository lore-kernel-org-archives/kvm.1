Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09140249E5
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741223; cv=none; b=sD3A6fPjpEbRdhYRhqWCUNHg6nkWFoBvoiZKlw7kRl5sSzFKwD2HHW29BvKov1454OBy7Ac5GLq6at5CpmqSVua7uCFSxeYNpC/FYCCUifnAleEmq4uiJXUEi/R7FZ0+csCr+vXnd2PR1VGxl2eAEGz3xQS3xr5wBvbQdXAbS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741223; c=relaxed/simple;
	bh=jxsGXfzQ6lUcOQJPqistqbP61aBTn1yYtWklxnTrd2I=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sOz68hiuiKpHkFWzDIA1g/SKPicOZnRxo0c4HFqJuWmPaSyADqEtIpD6ljqs2ixj9nUXiZmXNVJYAG3DGM20gLglLUYrRkeN79Rw7Ebs75y38gKcyqakkSRIw4Twe4lc0mpRRrzIpL9L6ZkP5XHXJfQBztlie7uCEKbF2jMJozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j82Wv1e7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j82Wv1e7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE971F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741221;
	bh=oxHqKBe91ZMJVrsXubLJsuYSeeL36Mr9ljmzP2Xh728=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=j82Wv1e74wJGrgYWnghomBPgFS0TLIijKBxnb9SATXxKJUG94ZWxheMAw3hdxpXbH
	 WNaUNQh3uQAdnqwU5Akd1rw0yLpMbbTQ6IQd08WtBXQU4C+kZNjhPouTKctShkIfD2
	 HsaXTaT2H+Nj8ojGPeamrsGajufqkcQujyDaOhlvvlM7skfL2E1vpoMptLsScZVtlx
	 qsGtXqIGegK/fYHyosGh1YPpAF8WiLSMu4ZMkCs3vB5GKi2txJyprOjHZGUKx0v8pr
	 HurjPMH2aHmkJgdo3gk8BCETK4RqR/c7l/QsLUOsyO2I2VlY/Ym1V3YD2RCTvJm+To
	 MndRZEr0wQqUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] iommufd/device: Associate KVM file pointer with
 iommufd_device
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525154816.1029642-3-aneesh.kumar@kernel.org>
References: <20260525154816.1029642-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 20:33:41 +0000
Message-Id: <20260525203341.9FE971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Use-After-Free / Lifetime Mismatch due to borrowed KVM file re=
ference
--

commit e5661ddf7c17ac12b18e45c9b4e38b80511ba1c0
Author: Shameer Kolothum <skolothumtho@nvidia.com>

iommufd/device: Associate KVM file pointer with iommufd_device
   =20
This commit extends iommufd_device_bind() to accept the device's KVM file
and stores it in the iommufd_device struct. This provides TSM vDevice suppo=
rt
access to the KVM associated with a VFIO device.

> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/devic=
e.c
> index 170a7005f0bc8..718abdc0e627a 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -216,7 +217,9 @@ void iommufd_device_destroy(struct iommufd_object *ob=
j)
>   * The caller must undo this with iommufd_device_unbind()
>   */
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +					   struct device *dev,
> +					   struct file *kvm_file,
> +					   u32 *id)
>  {
>  	struct iommufd_device *idev;
>  	struct iommufd_group *igroup;

[ ... ]

> @@ -266,6 +269,8 @@ struct iommufd_device *iommufd_device_bind(struct iom=
mufd_ctx *ictx,
>  	if (!iommufd_selftest_is_mock_dev(dev))
>  		iommufd_ctx_get(ictx);
>  	idev->dev =3D dev;
> +	/* reference is already taken in vfio_df_ioctl_bind_iommufd() */
> +	idev->kvm_file =3D kvm_file;

[Severity: Critical]
Does this borrowed reference create a potential use-after-free regression if
the iommufd_device outlives the VFIO device?

If a concurrent ioctl on the iommufd device is maliciously stalled (for
example, using userfaultfd during a copy_to_user in IOMMU_GET_HW_INFO),
iommufd_object_remove() can time out after 60 seconds and return -EBUSY.
This would fail to remove the idev object, leaving it alive in the iommufd
xarray.

VFIO owns the KVM file reference and unconditionally drops it when the VFIO
device file is closed. If VFIO drops this reference while idev remains aliv=
e,
the file could be freed, leaving idev->kvm_file as a dangling pointer.

If the stalled ioctl is subsequently allowed to finish, a new
IOMMU_VIOMMU_ALLOC ioctl could look up the leaked idev and attempt to call
get_file(idev->kvm_file), resulting in a use-after-free on the freed struct
file.

Should this function take its own independent reference to kvm_file to
ensure the file remains valid for the entire lifetime of the iommufd_device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525154816.1029=
642-1-aneesh.kumar@kernel.org?part=3D2
