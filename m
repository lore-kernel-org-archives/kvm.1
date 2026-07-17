Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A230100E
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307842; cv=none; b=U88uHJB9wwlkaChRnkIwoVjzjd5ziYK18WlZzRljpktQFGBmhcQiz7KbekIqI0AU2KBHnxX/5oNiVIHPa79LufuoIemqmpu627INkCEwvPO+6h0VqHCNTQTtvo1jipQrLbCBobpoG3BcqCDKyclUgxpz29Fy+LFSSjn/oXSYV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307842; c=relaxed/simple;
	bh=knIeDDtzWi/HNAJfoGWiKKGN20w1vIKoAn7qwXf87ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hxlR6K59NeHh5eYiB29MGPxSF8toCJobTy3iOr8YS/t5+nIhBMuWiKfrRrRBCmU5vbD4HPO4jH47+dYTSeaSz491uITVjYx69iXy1NmZTkdb7Fyah3p9ogPkzUBbydI8TVCzwQNGLzQo7H3pANuzOqmZdAN4OZT3eeJaRIUK0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2VoQ3Gy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2VoQ3Gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AF51F000E9;
	Fri, 17 Jul 2026 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784307841;
	bh=1c8mUe2hlQquhx5UwI2DWAe0MxjBj9HwoY6aNRnMwbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o2VoQ3GyFu+LOQdXHb2w2oNAjsZpyhYc72M1loZZFxaN0k3vR2z28UImVdy4sv9Qc
	 g45VfcEkt+DWmHCh5GgSvpTOKxS88Tz0MhZLycEtxPy4TaqjnmqIJ2oaMsa/XqZobd
	 eFJ/RgsKTjMwiUlG7UDsnfe7rYozbeHgxZ8oMzf6Haxd/qVwnOxbMTJgQNX1+Yv3SF
	 EGNDAJlHSKCB9sj90AofShIH+69mOF2ISOmxS1d4sz9sCH2H1ssY5+YaT699Mec8h3
	 IZd1Gb1Ft8uYLf+ktvR9WKSp110xem+lxFFiAaqxAIeH7NUhr9D7mfXUzKb0L8lzBK
	 yX/T7fgdK7MuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/11] vfio: selftests: Allow drivers to specify
 required region size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <7-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
References: <7-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:04:00 +0000
Message-Id: <20260717170401.21AF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The computed driver region size uses `getpagesize()` as the mini=
mum instead of `SZ_2M`, contradicting the commit message and altering test =
behavior.
--

--- Patch [7]: [PATCH v3 07/11] vfio: selftests: Allow drivers to specify r=
equired region size ---
commit 1aaddaa801402ac0c163d72d8dfe6ba18a6b7295
Author: Jason Gunthorpe <jgg@ziepe.ca>

vfio: selftests: Allow drivers to specify required region size

Add a region_size field to struct vfio_pci_driver_ops to let drivers
declare their DMA-mapped region size requirements. The core code will
round up and minimize the size to avoid changing test behavior.

> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/t=
esting/selftests/vfio/lib/vfio_pci_driver.c
> index 6827f4a6febe9..e13bbb7ee423d 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c

[ ... ]

> @@ -28,6 +30,11 @@ void vfio_pci_driver_probe(struct vfio_pci_device *dev=
ice)
>  			continue;
> =20
>  		device->driver.ops =3D ops;
> +
> +		VFIO_ASSERT_NE(ops->region_size, 0);
> +		device->driver.region.size =3D
> +			max_t(u64, roundup_pow_of_two(ops->region_size),
> +			      getpagesize());

[Severity: Medium]
The commit message mentions that the core code will "minimize it to SZ_2M
so as not to change any test behavior."

Does this code in vfio_pci_driver_probe() compute the minimum size correctly
by using getpagesize() instead of SZ_2M? This appears to shrink the allocat=
ed
DMA region size for existing test drivers down to the page size, which might
alter the test behavior the commit message intended to preserve.

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v3-76f117ad04f1+2=
8a90-mlx5st_jgg@nvidia.com?part=3D7
