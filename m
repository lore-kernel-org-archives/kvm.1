Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4356280335
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063526; cv=none; b=IYr4rSrh9wzRJa8LJN2+l6m3pYvioIa+gzHzeva+XUYeyp1lqFyacCIkrcBjiKHJTOsmOT7vrQBCdsypdw3A0i4PWFTJmUNPTk08QHUUn7bMB33qY5B0s+MnlCK4e1q6s6QZTnEs2LIql4ChnjUhJDtn5RilHn7bdCaTyKGG+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063526; c=relaxed/simple;
	bh=0QY7qJPYs3UJczYBXGSC+8njk5fzrSOQ43sO9TlOrro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgXozBN3XPhwKcz4vGK/wM8IfgE9wBdTs2QKACPtUi9sa1chKKJ2EwRkl4CnJ870lIeu6pZJCrgmFFDYgYfH5F+reffVRwyNpe+FLoHoyMxqll1PnFmMHrfZm25VzKG8y7V2Y+h7fNIeyPA71B4rH2a6Mr4QGpFouXy+5pO8b7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZcOT2ea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZcOT2ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437281F000E9;
	Tue, 14 Jul 2026 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784063524;
	bh=5Mtat8eyMreNKpiV+d6/6np9KqMhSY6jdAUTDrevUPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZcOT2ea6sG8tOuswaidKPQdsMAEN2eBlEZMXRm7+H8MXtwr/digVXtKWw8GixEQf
	 rqaCJ7sZakGbYFUmq0WB/wGnWr7XrJbWW39Kn6iCa/AALWottOpnhKqmQQ6RReZf7w
	 m9Wir05hMMsOaWz2Ym1EsV3YLWpwCtguP6IZcgkfT8z7FTeaUIVBGP9+ijEwiC6Bk7
	 ZTT/D+gQJlj4M0ROrRhau94fvSxPqBazGvByZCR2idN1/EJRVw4vYHfR5fw3yYtS/p
	 Ks/S0hCRN/CjfWZ2Jf8BvAOrpxGcnLf0rrpqPh6QUCfTyhxO6OUz8unPqkka1sHpRn
	 8NNcRMpZs4BWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read
 faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714-igb_v3_b4-v5-5-91503eddb98b@google.com>
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
 <20260714-igb_v3_b4-v5-5-91503eddb98b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:12:03 +0000
Message-Id: <20260714211204.437281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test flakiness due to fixed heuristic delay instead of polling o=
n EAGAIN during VFIO_DEVICE_RESET
--

--- Patch [5]: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read =
faults ---
commit a631c99ce1be37dbbdda0314b730b2c6bd947b50
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio: selftests: igb: Recover after DMA-read faults

This commit adds recovery logic to the igb selftest when an intentional DMA
read fault causes the device to hang. It introduces a reset and re-init
sequence using VFIO_DEVICE_RESET, including a 10ms delay to allow kernel
error handlers to release the device lock.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c

[ ... ]

> @@ -500,7 +522,28 @@ static int igb_memcpy_wait(struct vfio_pci_device *d=
evice)
> =20
>  	igb_irq_enable(igb);
> =20
> -	return (status & 1) ? 0 : -ETIMEDOUT;
> +	if (status & 1)
> +		return 0;
> +
> +	/*
> +	 * The descriptor never completed.  On real 82576 hardware this
> +	 * typically follows a DMA-read fault from one of the intentional
> +	 * unmapped-IOVA tests; the fault leaves the descriptor engine
> +	 * unable to service subsequent valid descriptors.  CTRL.RST alone
> +	 * reinitializes the queue registers but leaves the engine wedged
> +	 * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
> +	 * is required.
> +	 *
> +	 * Delay before requesting reset so PCIe/IOMMU/AER error handling
> +	 * triggered by the just-observed DMA fault can release the device
> +	 * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
> +	 * heuristic.  The current memcpy still fails with -ETIMEDOUT;
> +	 * recovery only ensures the next memcpy starts from a usable state.
> +	 */
> +	usleep(10000);
> +	igb_error_reset_and_reinit(device);

[Severity: Medium]
Will this fixed heuristic delay cause test flakiness under heavy load?

If the kernel's PCIe/IOMMU/AER error handling takes longer than 10ms to
complete (for example, when KASAN or other heavy debugging options are
enabled), the device lock might still be held.

Looking at the kernel side in drivers/vfio/pci/vfio_pci_core.c:
vfio_pci_ioctl_reset(), lock contention causes pci_try_reset_function() to
return -EAGAIN:

	ret =3D pci_try_reset_function(vdev->pdev);
	if (__vfio_pci_memory_enabled(vdev))
		vfio_pci_dma_buf_move(vdev, false);
	up_write(&vdev->memory_lock);

	return ret;

Since igb_error_reset_and_reinit() calls vfio_pci_device_reset(), which
asserts that the ioctl returns 0, would this lock contention cause an
immediate test suite failure?

Should this code explicitly poll for -EAGAIN from the ioctl instead of
relying entirely on a fixed sleep?

> +	return -ETIMEDOUT;
>  }
> =20
>  static void igb_send_msi(struct vfio_pci_device *device)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-igb_v3_b4-=
v5-0-91503eddb98b@google.com?part=3D5
