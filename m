Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0E38D
	for <kvm@vger.kernel.org>; Sun,  5 Jul 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783216463; cv=none; b=daISnzmNrkucZVPiY90Tf1BEPFO7qIY8TdRswwh0P4HDmCYV4ZVdFXJOsdBwlP5ZlsSOQoaiRljNSj6uOLmwn3EYRmW7FQrozNhV0MBYkexJ2qsTSdqy1nZ7KZ+UM4b2MUiO2k272tebWq/giQFVxLrui1beUJBNq9hEwcy0ICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783216463; c=relaxed/simple;
	bh=oV0d6T7tW4+MYkcxJT3WYR9Px6LT2PyyYf7GXMjwCV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RIHU1/05ufDcwFy+93xq4WvAIpG/ifDV0/xUGhqXpu3D3mCCXIxEd9p9hOh+9ilEgCh26qu8TLXLWpNIPM1+LUYnKs7UylKqvTIkMO8j02LRxhmHdmRNuJLJ2pBMWOJvGeFBE17oVjR5m/VTwDpl+4EEr9RVhZv7efOy3BIbQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8w9WFg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8w9WFg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E3C1F000E9;
	Sun,  5 Jul 2026 01:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783216462;
	bh=97/hDE14BNqwQ8y+WrNkhYPPs/CUkZB7jY7mcGN5IVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d8w9WFg0HmqeuM8U7wEJEbLS2Hss+4v0iCyommQ2KOtAdCFzQ2KImt6QJ97Le3RWT
	 rkLloN8TGBRf7ZKtDiNwS75h5uF4HxizcapGySxrz4aNU7ZtmCkcLyCaIr+zD4hyA6
	 d0OUxrAnpc7ZAxbUmluKIl1FNdsfsudNe06Nf9fe+2a+fHRK7rygd/rDOjMrTdEZA2
	 PCju2IgkA0z+MVnOWqWq/USxVTOIiTF7UpFzGnQb64YFSxN4I7vWs5uDS3x1l8lKyS
	 nxGdpawgdz0BqMzRNgOokXzZ6rR/OgS7JcwCZ++P/1YXXvM2JDqZ2LaEVJDfQvPM39
	 fC3utxo7bCfQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/pci: clear vdev->msi_perm after freeing it on init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Mei" <xmei5@asu.edu>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260705014010.1297885-1-xmei5@asu.edu>
References: <20260705014010.1297885-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 01:54:21 +0000
Message-Id: <20260705015421.C9E3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow in vfio_cap_init() and vfio_ecap_init() d=
ue to missing bounds check on capability length.
--

commit 5867deb8ee022404d313dea6794c1dc0a44460cb
Author: Xiang Mei <xmei5@asu.edu>

vfio/pci: clear vdev->msi_perm after freeing it on init failure

This commit clears the vdev->msi_perm pointer after freeing it during an
init_pci_cap_msi_perm() failure. This prevents a use-after-free and a double
free of the MSI permission table when vfio_config_init() fails.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..9914f3ac69aef 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1272,6 +1272,7 @@ static int vfio_msi_cap_len(struct vfio_pci_core_de=
vice *vdev, u8 pos)
>  	ret =3D init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
>  	if (ret) {
>  		kfree(vdev->msi_perm);
> +		vdev->msi_perm =3D NULL;
>  		return ret;
>  	}

[Severity: Critical]
This is a pre-existing issue, but there appears to be a heap buffer overflow
due to missing bounds checks on capability lengths.

In vfio_cap_init(), if a PCI device advertises a capability where the offset
'pos' plus length 'len' exceeds 'pdev->cfg_size', can this memset() write o=
ut
of bounds on the heap?

drivers/vfio/pci/vfio_pci_config.c:vfio_cap_init() {
    ...
		memset(map + pos, cap, len);
		ret =3D vfio_fill_vconfig_bytes(vdev, pos, len);
    ...
}

Similarly, in vfio_ecap_init(), extended capabilities are not bounds-checked
against the buffer size:

drivers/vfio/pci/vfio_pci_config.c:vfio_ecap_init() {
    ...
		memset(map + epos, ecap, len);
		ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);
    ...
}

This out-of-bounds write would then continue into vfio_fill_vconfig_bytes():

drivers/vfio/pci/vfio_pci_config.c:vfio_fill_vconfig_bytes() {
    ...
			*dwordp =3D cpu_to_le32(dword);
    ...
}

Should we validate that the capability length fits within the configuration
space buffer before performing these writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705014010.1297=
885-1-xmei5@asu.edu?part=3D1
