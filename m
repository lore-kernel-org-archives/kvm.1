Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6013A453A
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043390; cv=none; b=athIs3ugnqKRKU+qWzr3O1rK3DwDOGvqQdiL7lCcecE/DwTqd3Fs81r0E7/OUZI7RtY6JuSFDfXIdRYG7QmXYhvQUlPhRG2Jo+TWTlWs3CO48ctyS4TncEzO+O+TNiaxT22NrfcFUiH6/9oM39Js+awxEF9M1TblJoLS9x3vHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043390; c=relaxed/simple;
	bh=/qCBGrXv41s6b4frSW2ryaj7rGwwHaSgF6p0tdar0DY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WEeFv+iXUCTfvpnLYZOGDWzz2QsT4hBjbOua39fgvODyVA9eEFuvOE1cnE5Vn1tFcc2Z8glp/H5Wy6t8hcxBhhbtLiZNjSq06mZg0fTD7INyviKrFPktOJdBqPf53UgvJgC1z/Zy/iCnAGGW27x1iNpcZsZlTrIN5k+5fJVNVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ2BgLYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ2BgLYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAADD1F000E9;
	Tue, 14 Jul 2026 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043389;
	bh=GNA2yqhwmI8y+6cIgrAvPRxXf7D3K5tOuob7KWEjzuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQ2BgLYoPGVctAr/DZKvOoG+gExgz53IYGHzB65rt8GNZ45jYRPbFLzYeY7kd8mqJ
	 DzG14vYW4D+5RNyXgpRZ4IOrqCth/CtOFySmz0zNBhDGbQvNr/H1ePBHCS1Q2IXD5J
	 KsNHvDHlLyHW/hPLGJcRcY3BHKL6WSj7pXNiqRADcc0smIJ0iEI3PtKiUkNMwp9rYN
	 16AnGvUCOtu6NwLMNFkufviHk+x3sMu/AZTdSrd3qMFaxOqJEJoKJJSVolGABrWteP
	 Zv2nHSbM31HXZgqrsq27K5KFPkbLCtqSYlxx1MuZGwmGfx6HLz8Ij4u22hKNiJMUXQ
	 j34AYpl94CnMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/20] vfio/pci: Preserve vfio-pci device files
 across Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-7-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-7-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:36:28 +0000
Message-Id: <20260714153628.CAADD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lockless checks of `vfio_pci_dev_is_frozen()` in IOCTL and read/wr=
ite handlers allow userspace to bypass the freeze state, breaking kexec han=
doff guarantees.
- [Medium] `vdev->liveupdate_frozen` is never cleared and `unfreeze` is uni=
mplemented, permanently bricking the VFIO device if a kexec aborts.
--

--- Patch [6]: [PATCH v5 06/20] vfio/pci: Preserve vfio-pci device files ac=
ross Live Update ---
commit 03e42ce3ade0f06aa286a1a8cacc4d3f5d2537c0
Author: Vipin Sharma <vipinsh@google.com>
vfio/pci: Preserve vfio-pci device files across Live Update

This commit implements the Live Update file handler callbacks to preserve a
vfio-pci device across a Live Update. It serializes device state into
vfio_pci_core_device_ser and resets the device during the freeze phase.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index f31e59e5badb4..c312b0eaf7d00 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1513,6 +1516,9 @@ long vfio_pci_core_ioctl(struct vfio_device *core_v=
dev, unsigned int cmd,
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>  	void __user *uarg =3D (void __user *)arg;
> =20
> +	if (vfio_pci_dev_is_frozen(vdev))
> +		return -EIO;
> +

[Severity: High]
Can a userspace thread race with the freeze operation here?

If a thread locklessly evaluates vfio_pci_dev_is_frozen() as false and then
blocks waiting for vdev->igate or vdev->memory_lock, couldn't
vfio_pci_liveupdate_freeze() concurrently acquire those locks, freeze the
device, set liveupdate_frozen to true, and release the locks?

The ioctl thread would then wake up, acquire the lock, and modify the frozen
device's state.

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vf=
io_pci_liveupdate.c
> index 803528c9f1b27..e6eb7f6b53d7f 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
[ ... ]
> @@ -6,28 +6,221 @@
> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *ar=
gs)
> +{
[ ... ]
> +	/*
> +	 * Userspace cannot use the FD correctly now irrespective of liveupdate
> +	 * freeze failing or succeeding. They will have to reinitialize the VFIO
> +	 * device to continue using it as reset might have loaded default PCI
> +	 * state. Disable ioctl, read, write and mmap access to the device.
> +	 */
> +	smp_store_release(&vdev->liveupdate_frozen, true);
> +	return 0;
> +}

[Severity: Medium]
Does this permanently brick the VFIO device if a kexec aborts?

The liveupdate_frozen flag is set to true here, but it looks like there is
no corresponding clear on device close/open or kexec abort.

Because the unfreeze operation callback in vfio_pci_liveupdate_file_ops is
unimplemented, the flag would remain set. Userspace attempting to recover
by closing and reopening the FD would continue to receive -EIO until the
driver is unbound.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D6
