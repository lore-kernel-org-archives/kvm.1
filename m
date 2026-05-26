Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01938B7D4;
	Tue, 26 May 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783433; cv=none; b=iI8yQxVcLUO2G+QoJqeKIKznZq4A1VMjmdyVncvp7K/P8tdUGAnV4HLGjWUuLxxaZucU+xkjSFSCRuRFlitNZ8JVmF9cy6wMuK7fyBzJpa3xvHr2ojOpV8xq61AbPElfPrDEiU55X5UH/+YvN3O1uTsDm4WH5ve1xfxZfZlwETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783433; c=relaxed/simple;
	bh=M0mfDFHJT2nAKBd3dfdDyLMb4hLmSwVVUoW6SM6RNH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E7QpYW5xJtksZO2B77ukuokiQ0zY+tU113uUkLYC8gE9IvsSvNlkgoMaD9aREsk2iG7ITu6A5jATHD5NMPVckxXdacHVhuyQOzFos+o85j3wtj/mCjHgpHvddGopSfD49KJFMhD4cXJxV0IFGBno6uaVmPjHa/Ggo0Z575cSmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO7+7Ink; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO7+7Ink"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD931F000E9;
	Tue, 26 May 2026 08:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779783431;
	bh=XtT8eB3uOG2pvbTL+VDPcUfmFvilNUh9Z0zBZDl5COc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YO7+7InkZr+857qkhzANVesOWHzUWg9G++IwHx3h5HdftpPFmvW0xZgFt2cvXs2gs
	 MnnrgpAqMw+g8qL7Jh2wci1ghAWBGSRT0ng018leas/6Ky/fzFYblck+4KzJTcaeIX
	 YwnsRhoV2Yzb/s/8SfhUIsrr78TmKhDZbzjHJOTyCQyamoLJyq4FI83V5GHswfHLav
	 X007gbMdewc+8e7XFDtv1cU3Xf1h+g/BKSCTlbjbSYlGzyTgM/VQMr57BEuyr/n90y
	 YbWnxvwTIpFCRGj1vU3DSYmklfLSBWuZGfgqf76FTQC9fJ2YyLMg2+WkZg7EO7vCio
	 8tZEgPtxujNXg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iommufd/device: Associate KVM file pointer with
 iommufd_device
In-Reply-To: <20260525203341.9FE971F000E9@smtp.kernel.org>
References: <20260525154816.1029642-3-aneesh.kumar@kernel.org>
 <20260525203341.9FE971F000E9@smtp.kernel.org>
Date: Tue, 26 May 2026 13:47:07 +0530
Message-ID: <yq5av7cashz0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Use-After-Free / Lifetime Mismatch due to borrowed KVM file =
reference
> --
>
> commit e5661ddf7c17ac12b18e45c9b4e38b80511ba1c0
> Author: Shameer Kolothum <skolothumtho@nvidia.com>
>
> iommufd/device: Associate KVM file pointer with iommufd_device
>=20=20=20=20=20
> This commit extends iommufd_device_bind() to accept the device's KVM file
> and stores it in the iommufd_device struct. This provides TSM vDevice sup=
port
> access to the KVM associated with a VFIO device.
>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/devi=
ce.c
>> index 170a7005f0bc8..718abdc0e627a 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -216,7 +217,9 @@ void iommufd_device_destroy(struct iommufd_object *o=
bj)
>>   * The caller must undo this with iommufd_device_unbind()
>>   */
>>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>> -					   struct device *dev, u32 *id)
>> +					   struct device *dev,
>> +					   struct file *kvm_file,
>> +					   u32 *id)
>>  {
>>  	struct iommufd_device *idev;
>>  	struct iommufd_group *igroup;
>
> [ ... ]
>
>> @@ -266,6 +269,8 @@ struct iommufd_device *iommufd_device_bind(struct io=
mmufd_ctx *ictx,
>>  	if (!iommufd_selftest_is_mock_dev(dev))
>>  		iommufd_ctx_get(ictx);
>>  	idev->dev =3D dev;
>> +	/* reference is already taken in vfio_df_ioctl_bind_iommufd() */
>> +	idev->kvm_file =3D kvm_file;
>
> [Severity: Critical]
> Does this borrowed reference create a potential use-after-free regression=
 if
> the iommufd_device outlives the VFIO device?
>
> If a concurrent ioctl on the iommufd device is maliciously stalled (for
> example, using userfaultfd during a copy_to_user in IOMMU_GET_HW_INFO),
> iommufd_object_remove() can time out after 60 seconds and return -EBUSY.
> This would fail to remove the idev object, leaving it alive in the iommufd
> xarray.
>
> VFIO owns the KVM file reference and unconditionally drops it when the VF=
IO
> device file is closed. If VFIO drops this reference while idev remains al=
ive,
> the file could be freed, leaving idev->kvm_file as a dangling pointer.
>
> If the stalled ioctl is subsequently allowed to finish, a new
> IOMMU_VIOMMU_ALLOC ioctl could look up the leaked idev and attempt to call
> get_file(idev->kvm_file), resulting in a use-after-free on the freed stru=
ct
> file.
>
> Should this function take its own independent reference to kvm_file to
> ensure the file remains valid for the entire lifetime of the iommufd_devi=
ce?
>

I don=E2=80=99t think we need to handle this because closing a VFIO cdev wi=
ll
result in an iommufd unbind. That is, we should not find an idev that
outlives a VFIO cdev.

Shouldn=E2=80=99t iommufd_object_remove() failing to remove an object be
considered a bug?

-aneesh
