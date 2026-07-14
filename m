Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59A34CFCF
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042926; cv=none; b=hRy0qr9G9v3AonwwfOCWf6yE4ZJ7CATJ0zIUuMRd93j3bDUctzpNWVFmuqk/7S+e7CM+aqeVkX6cSCpaj3thlpHseTLkFfdORl7l7D++GLY5rvuK8ekCWcDJg7LPFJhQpe3N0t6wJsFlvHrggsvYUDNWwxqnVcoOdma2XxN3UNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042926; c=relaxed/simple;
	bh=DTTJiDg4DJ94Y6ojCtw9NE5WI8KhULEsn/AEX8heMa8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o/sml/jSsnLGqHHegahQBIqlOVkdMee9+zDXX4BklqfvIAj/UjCENcbGLgPugtpMIrP5SmkbdXg73dQxOVXP56kTvUg9OMuY2PvPErnSxyxN9XGBZOsWko7lT8gtUQRAKbkYfw/3IvCrLXLHOhfSytAKDuOkVdewKOtY4Wh9thE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afvw6KLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afvw6KLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA91F000E9;
	Tue, 14 Jul 2026 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784042925;
	bh=fZgFfa/HNE2LS0mF4nPiy6SPwiuqTyTP5w4/3/YsxpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Afvw6KLQsITkC7fNv/kqeRtcw5Q+LTH3/4ZvdnYPkdoaXArCry8Nvlok3GxFWh/A1
	 SYAhiX4iql1bDz0XzLVbJ+WqCLtlT6B+2HIoyOr8Md4wn26X3ztiUAoAQAKNlBgenG
	 aRYfnEVDNcwYHv/yLbAxlSYsREBi7UxReeIReFpGv5Jv0nXro37YTiFZt22Xis+VfV
	 P8LUULoPZ51REBc8PeG0JdNfs5k6/4rY2gsogUt1+WIHZ0BmGg5gzUTdnrc3eTYnUO
	 uYd08mlDbsU1VeIldo1BJ8TaBFLJQx7ykdMMEvQ0Ofmdc5HCgf2B4DWZX5wn67EUDJ
	 8X/pAU94eJvsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/20] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-12-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-12-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:28:44 +0000
Message-Id: <20260714152845.50CA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `pci_liveupdate_is_incoming()` is called but is neithe=
r declared nor defined anywhere in the kernel tree.
--

--- Patch [11]: [PATCH v5 11/20] vfio: Enforce preserved devices are retrie=
ved via LIVEUPDATE_SESSION_RETRIEVE_FD ---
commit 27d87a41631434a0adb6626f478ee97f35b6c917
Author: David Matlack <dmatlack@google.com>

vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIE=
VE_FD

This commit enforces that incoming VFIO devices preserved by a previous
kernel are retrieved using LIVEUPDATE_SESSION_RETRIEVE_FD. It adds checks
during device open and group device fd retrieval to return -EBUSY if
an attempt is made to bypass the preserved state.

> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index e4b72e79b7e3e..496180950eb6d 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h

[ ... ]

> @@ -461,4 +462,21 @@ static inline void vfio_device_debugfs_init(struct v=
fio_device *vdev) { }
>  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
>  #endif /* CONFIG_VFIO_DEBUGFS */
> =20
> +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	struct device *d =3D device->dev;
> +
> +	if (dev_is_pci(d))
> +		return pci_liveupdate_is_incoming(to_pci_dev(d));

[Severity: Low]
Does this code compile successfully when CONFIG_VFIO_PCI_LIVEUPDATE is enab=
led?
It appears that pci_liveupdate_is_incoming is neither declared nor defined
anywhere in the kernel tree.

Could a prerequisite patch adding this functionality to the PCI subsystem
have been left out of this series?

> +
> +	return false;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D11
