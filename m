Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2793366548
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551646; cv=none; b=aMGnophZVqV+U8qvxGyjzm/3XQ4D2rok+Wu6OJkil6RPfpGps/0KlNlKXuUNKCpyVx9w2RxBkHjx5EfZKs9LMAZeKBNFxcEgoeQBHGW4v9xxD2qVfq/UKOSKbpZDeG8Az1NR5tOnegmWrrageDXV7IpBRXmbTpztnxJgwzomgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551646; c=relaxed/simple;
	bh=EMX7eP1+y08Y2A0pmpuFxZFElkLzlYO/Klb/lKDfEts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XINxwlO+EPwrfSHGpXPwHg/dehI6s2R6CYGObUZDkOsgqxC+g4H+7e0pI2rno90PBPgeTlMWoXNuDvkLXubZjFpKqBFIGvcMpV9sKcvY1aAZIt17cOPNNh9XPHM/jh2btX8A2Ix6r9Uoy3YotQN4ybI0Q8FhmirLBRh+mkbY/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNj8V4As; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNj8V4As"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2221F000E9;
	Mon, 15 Jun 2026 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781551645;
	bh=bMMANG+rQmMt6BXHpq2597Zpwp9xulf+zGdEObukHI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNj8V4AsYwne5ywBv8CToxKIiCE10+nKbcL4dOSmlHHfRLOv6DEiF0OJcy80NsME1
	 6zB80FMWeaJQ6iSeGEw7a1iLsFwL6wUgm38UOyrcGnhJiXTeV6onDfc434KViqJO89
	 YFMD0wUcsOod7GoKfMKmKc9AKN2AaTOEac+atZ56BJAnAx0oHdhoO5h0CcTHNUr4e/
	 dWmlg9Nz8lZPY4QbJ9wtLqJZNqFz55eCafyBxDdxCNl+gXdrpn1Ecp901AUAJEEMG9
	 GcUTIs+9x9EBvinYQOAxTca0XKEFkUOIbB831VNvrZ2ZSeEqRotygtKX9xIABjlEgv
	 O73lQstQhnnsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] vfio/pci: Expose latched module parameter policy
 in debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260615191241.688297-7-alex.williamson@nvidia.com>
References: <20260615191241.688297-7-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 19:27:25 +0000
Message-Id: <20260615192725.6A2221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free in debugfs via devm-managed seqfile private data du=
ring device unbinding.
--

commit 253a847be13fd59f8c265fb641107fa380c66e0c
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio/pci: Expose latched module parameter policy in debugfs

This commit exposes the per-device latched values of the nointxmask and
disable_idle_d3 module parameters via debugfs.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index db36d903dcd40..3f11a9624b9c0 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -97,6 +99,60 @@ static inline bool vfio_vga_disabled(struct vfio_pci_c=
ore_device *vdev)
[ ... ]
> +static void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
> +{
> +	struct device *dev =3D &vdev->vdev.device;
> +	struct dentry *pci_dir;
> +
> +	if (IS_ERR_OR_NULL(vdev->vdev.debug_root))
> +		return;
> +
> +	pci_dir =3D debugfs_create_dir("pci", vdev->vdev.debug_root);
> +	debugfs_create_devm_seqfile(dev, "nointxmask", pci_dir,
> +				    vfio_pci_core_debugfs_nointxmask);

[Severity: High]
Does this introduce a use-after-free during device unbinding?

When a device is unregistered, vfio_unregister_group_dev() invokes
vfio_device_del() before tearing down the debugfs entries.

Because vfio_device_del() eventually calls device_del(), it will trigger
devres_release_all() which frees the debugfs_devm_entry allocated by
debugfs_create_devm_seqfile() here.

Following this, vfio_unregister_group_dev() can block waiting for userspace
to close any open file descriptors for the device:

drivers/vfio/vfio_main.c:vfio_unregister_group_dev() {
    ...
	vfio_device_del(device);

	vfio_device_put_registration(device);
	rc =3D try_wait_for_completion(&device->comp);
    ...
}

Since the debugfs directory is not removed until vfio_device_debugfs_exit()
is called after this wait completes, the debugfs files remain visible.

If these files are read during this wait window, will it dereference the
freed devm-managed private data pointer?

> +	debugfs_create_devm_seqfile(dev, "disable_idle_d3", pci_dir,
> +				    vfio_pci_core_debugfs_disable_idle_d3);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615191241.6882=
97-1-alex.williamson@nvidia.com?part=3D6
