Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929F30569A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727675; cv=none; b=pBr0iOBfOL6cEV0iop1ZU46hA12NXpIE6ZhYHT/nH8xA6HvLMw/W7SMmUuPEPY50ZoFxoLGhBtrp2jc2qmwHy5+UMwyV50Ph1WZsGo66/O9+a630W7gvvKOw+neJgERaU4DjCcYfRmLczPCFWv4OPUcwVJ606og1oCZl7khlJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727675; c=relaxed/simple;
	bh=wr2y0omAPpvFKFpHpdz+M1NH03xCsAoxHHDxLRXl+68=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ID/Htb/uRckS5LPZVjwzMjC38GZIHYu9y84w3flg7UuoV2pvMMrggV0jGmCtoQdqey618F7tluqQTSi9pyQBBdoJPtoD3VkNzAdERXdDoGM30ZKPrS2F1TZWjbKSBbKYRmXyn9PzvP3DekU6GJ1GgNKKYDDcZJ/OOJkMy3Gb4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DurtztWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DurtztWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54191F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727674;
	bh=o+lwS5IVPmAKAAb/oAIMnJVatIEb2MCvSpxELZnEZq8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DurtztWzdiW+ugmCq0yUyUrUYXr01kS02gyYv9m+VeWB+GUDZqN8RI3juJUSLVf5M
	 pL4RqHo6F47RCBYy1LMEgQrsPiIqpRXEuHRVhtMCilUvD6lZ/ZqYx87oAd42M+V+Rx
	 CSFtmLpR4TjN17SlwDkLoJiDMvlZy/0UuJvexgXVt4P/PVdYLLZQx+/lAgF2Ey+XwH
	 Nliz/FFIQsJI7neoD2pFLqANnA0Un9IgAx2QtceZ/LGIUC8XDi+QhNEMZ1OUH0BfsA
	 xMmYYgr8Ib6ySlipDQ7TERS2h1hcOh6Sb2N/F+7NIqkK8w22/TgzXY/TtLSuJ1sdBw
	 Jh4XL3DrLC5CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] vfio: cache KVM VM file references instead of
 raw struct kvm pointers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525154816.1029642-2-aneesh.kumar@kernel.org>
References: <20260525154816.1029642-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 16:47:53 +0000
Message-Id: <20260525164753.E54191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent BIND_IOMMUFD ioctls on multiple cdev file descriptors f=
or the same device unconditionally overwrite device->kvm_file, leading to r=
eference leaks and Use-After-Free.
--

commit 9a5907f1fb1069cc250703cfb404e5a7be33bf23
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

vfio: cache KVM VM file references instead of raw struct kvm pointers

This commit switches VFIO to track the VM's struct file instead of raw
struct kvm pointers to manage the KVM VM lifetime. This change allows
VFIO and iommufd to use normal file references for VM lifetime rather
than relying on KVM's internal refcounting.

> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 54abf312cf049..ca75ab8eb7bd7 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c

[ ... ]

> @@ -133,10 +133,10 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_=
file *df,
>  	}
> =20
>  	/*
> -	 * Before the device open, get the KVM pointer currently
> -	 * associated with the device file (if there is) and obtain
> -	 * a reference.  This reference is held until device closed.
> -	 * Save the pointer in the device for use by drivers.
> +	 * Before the device open, get the VM struct file currently
> +	 * associated with the device file (if there is one) and obtain a
> +	 * reference. This reference is held until the device is closed.
> +	 * Save the file in the device for use by drivers.
>  	 */
>  	vfio_df_get_kvm_safe(df);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditionally
overwrite device->kvm_file if concurrent BIND_IOMMUFD ioctls are called on
multiple cdev file descriptors for the same device?

If a user opens a VFIO device cdev twice, getting two distinct file
descriptors (df1 and df2) for the same device, and successfully binds df1
to IOMMUFD:

- device->kvm_file is set (with an extra refcount)
- device->open_count increments to 1

When the user attempts to bind df2, the check for df->access_granted only
checks df2, so execution proceeds.

Calling vfio_df_get_kvm_safe(df2) will overwrite device->kvm_file with
df2's KVM file. Could the previous file reference from df1 be leaked because
no fput() is called?

If vfio_df_open(df2) then returns an error (because device->open_count is 1=
),
the error path jumps to out_put_kvm and calls vfio_device_put_kvm(device).
This drops the new reference and clears device->kvm_file to NULL.

This leaves df1 bound and functional, but its KVM association is destroyed.
When df1 is eventually closed, hardware drivers like vfio_pci_zdev that che=
ck
vfio_device_get_kvm() will see a NULL pointer and skip their KVM
unregistration hooks. Can this leave KVM hooked to a closed device,
potentially leading to a use-after-free when KVM accesses it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525154816.1029=
642-1-aneesh.kumar@kernel.org?part=3D1
