Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410711;
	b=fmtp+kRrT00MbaZPWhZkxSksn1K9xbvtt/u5jLLi1JeP+H3mEounbyraMnWyku2Z5V33
	 7nUqu9pjsNFmrxTtZpbJIaNECKKFaEFXzQ3aD9KPEZA7RE3JUJGr1dQ+5agIVV/c4E+p6
	 LUMS2ji4wJjp2RUOZulFdJwaSK6aV3PhzGpmVYGKO3CX9Tr+Z3R+6te/6BV0Kp1QFkdZQ
	 4G4cT+QhTwZHD8UimGQ6riLD+rKYzpIS3v8n9Smna0ZICbSUOSgntVTaZtolcEqdGS4ov
	 zqxkXTL4dU2RyOwIbudYprAr6SE2qA3cBPR3mc8Vz/KZ8f6NKgQD2EWcpkY8L4a+OIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/cxwPni+P9wf2++EZYWts5G6xuhgZ/5bqQwL0jI7EAs=;
	b=EtJUMCUUeIoFnQ8U6b1HG7Zk9nm3BVmbfm8l/07PmQ1vRnUsAeLQUYn3yKJf33rhpWhY
	 1r+hkFDLRyCGd92Q0J4oHgJhsY5QHPxlnfFzgUsnCw88oxEVwTpICI7J/BlM0voPZu39h
	 Jd5s/pQXr+anCtmS/ExafuXdS5oTeaL71ZgaeASlKt5rVtQkbu+SMFnsTiBrXix7Lc15C
	 O/C8JblaSZXndHaKKwLfRJop7B2NLisQLHpPnLwAez24Xyj0uM6WjaOefVv/SIIWgSXzc
	 WEt0yB6Ej3WssTHIRH9ZsvbqqLwp87q+kcR0M6ONrsK/y9XXJ8dU0HwIQBLNhWemhww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8xBUn+3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D36606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8xBUn+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C671F000D2;
	Mon, 23 Nov 2026 05:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410710;
	bh=/cxwPni+P9wf2++EZYWts5G6xuhgZ/5bqQwL0jI7EAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n8xBUn+3p2BpsDOmSNzxAN+cE3UqskjZfNbyPtJWkRc0i6LumE2N+pPzth0tmLYtF
	 Vc/IS1AhLQH/pyebxbiDnoRHSD75CoQ22/cgZEUbli7AU0fElxR4HGZJ6jJFjY8AvX
	 wQo+s8kJy/S/oHPGmsFHApk7p9jVQrVk+jDEKnZlM+6Al25/SI8Hgk0g1/J8bB2STR
	 7My96BeldrHz5tQ/xGdDBsSNDc7UVCg2P8YHULfU9ZDOHOjU/NbF4nL3888U1Vs0sr
	 SA4GS1nI+5miqAxinPc6IdlzrSA2R84fJ26cemQ1qVAR7epAAm8u5yj/FxvleTTZHt
	 4cVFzpXkUwJCQ==
Message-ID: <sashiko-outbox-228705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/18] iommufd/selftest: Add test to verify iommufd
 preservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samiullah Khawaja" <skhawaja@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261123044949.3610702-19-skhawaja@google.com>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-19-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 05:11:50 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] iommufd: race between iommufd_test_liveupdate_preserve_dev()
  and detach
--

commit f9841f2ccd5ea9e7ec8822d894220423dd77c296
Author: Samiullah Khawaja <skhawaja@google.com>

iommufd/selftest: Add test to verify iommufd preservation

This commit adds a kexec selftest to verify iommufd preservation across
live update, along with an IOMMU_TEST_OP_LIVEUPDATE_PRESERVE_DEV test
operation to preserve an iommufd device.

> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/sel=
ftest.c
> index 037e54f3d2ba6..d904482124e1f 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -2115,6 +2115,33 @@ static int iommufd_test_dmabuf_revoke(struct iommu=
fd_ucmd *ucmd, int fd,
>  	return rc;
>  }
> =20
> +/*
> + * Preserve the IOMMU state of a device bound to this iommufd, as a vfio=
 cdev
> + * preserved in the same live update session would. The iommufd must alr=
eady
> + * be preserved, so the HWPT of the device is preserved.
> + */
> +static int iommufd_test_liveupdate_preserve_dev(struct iommufd_ucmd *ucm=
d,
> +						u32 dev_id)
> +{
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommufd_device *idev;
> +	int rc;
> +
> +	idev =3D iommufd_get_device(ucmd, dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	mutex_lock(&ucmd->ictx->liveupdate_mutex);
> +	rc =3D __iommufd_device_preserve(idev, 0);
> +	mutex_unlock(&ucmd->ictx->liveupdate_mutex);

[Severity: Medium]
Can iommufd_test_liveupdate_preserve_dev() race with a concurrent
iommufd_device_detach() and leave idev preserved after its attachment is
removed?

In iommufd_device_detach(), igroup->lock is dropped between
iommufd_device_unpreserve() and iommufd_hw_pagetable_detach():

drivers/iommu/iommufd/device.c:iommufd_device_detach() {
	if (pasid =3D=3D IOMMU_NO_PASID)
		iommufd_device_unpreserve(idev);

	hwpt =3D iommufd_hw_pagetable_detach(idev, pasid);
	if (!hwpt)
		return;
	...
}

Because IOMMU_TEST_OP_LIVEUPDATE_PRESERVE_DEV runs on the iommufd file
descriptor without the VFIO device lock that serializes detach and close,
the two paths can interleave:

CPU0                                  CPU1
iommufd_device_detach(idev, ...)
  iommufd_device_unpreserve(idev)
    mutex_lock(&igroup->lock)
    /* !idev->liveupdate_preserved */
    mutex_unlock(&igroup->lock)
                                      iommufd_test_liveupdate_preserve_dev()
                                        __iommufd_device_preserve(idev, 0)
                                          mutex_lock(&igroup->lock)
                                          iommu_preserve_device(...)
                                          idev->liveupdate_preserved =3D tr=
ue
                                          mutex_unlock(&igroup->lock)
  iommufd_hw_pagetable_detach(...)
    mutex_lock(&igroup->lock)
    xa_erase(&igroup->pasid_attach,
             IOMMU_NO_PASID)
    mutex_unlock(&igroup->lock)

When the liveupdate session closes (or idev is later unpreserved),
iommufd_device_unpreserve() sees no IOMMU_NO_PASID attachment in
igroup->pasid_attach, triggers WARN(1, "IOMMU_NO_PASID attachment not
found"), and skips iommu_unpreserve_device(), leaking the preserved IOMMU
device state.

Unpreserving the device inside iommufd_hw_pagetable_detach() under the
same igroup->lock critical section that removes the IOMMU_NO_PASID
attachment would close this window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123044949.3610=
702-1-skhawaja@google.com?part=3D18
