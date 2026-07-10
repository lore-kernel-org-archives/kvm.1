Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C638B14C
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722825; cv=none; b=ECcgTbvKpK7/IXZpqITxn+qx3Mpvg3oNx7PAmRkv6OV5N6L2xUqZDL0sMVxzVmgpZgpQ/t1GbJm1lTU9BXK8zv/NuSwrxabeP6P/c3d0LhXQOGzeyoo7UdfMude+n52vTYXViTtcYso3YQy5FCUM3JYs9P3XpQagX3UaXiUqRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722825; c=relaxed/simple;
	bh=L82BID3n4OoGF6lFF+644GNv3DgbXjMK2z/7FRen4UA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VL2zBoAkp75QusQEyxvt0IRQBT5zFK48ntQ0YFG+qLf6MPUV+5CWhSY5IGLqWZzYvBsDNRZK95wuOX5HEuJyhAKopR8sV/g5Tiv+r1PKUNplrFXb8Sdz8lXXf+CmtZFGZQwKcIP/H9toMhoU7bV4qdwSNgHXyy0y2mkxJLv1SVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpJ2bzx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpJ2bzx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ADF1F00A3A;
	Fri, 10 Jul 2026 22:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783722823;
	bh=WVnLyHbnzrn/wv9wqDEsuMqTx+yf61okAKTxmPx6Gqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JpJ2bzx92QiylaW1r1R6ArO+BuYqYuWjrhCpTTCRAM/ZVi0Bsx3XatVMtBbOGaEy7
	 walIGxrQ6zVP1vqrwsbSK3M0PPeoX0/lJPES08/5n6TPf3nzSj7c2mkJrywzjARK+y
	 qHhMVZkq6MxmKESSs3mIUIf+emAtCcCSPGuh8xzj08VYA7ibWls062g7iZgvY7FdNx
	 IB3Pv8sU1vLU3ZhTZjyGNrWp620V1ru42zK1vZy/P5XICSvAaqZMiVLnG/HSFrA9nx
	 My7TAu5WBwCDDQdUvsfiJOkJOnadKDvCcCXjLEPN8CHdY/i9ynNaHDXbJa9kzqs/ew
	 Bzr0H1ZdnAlgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] vfio: selftests: igb: Recover after DMA-read
 faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260710-igb_v3_b4-v4-9-56e7e2576cc1@google.com>
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
 <20260710-igb_v3_b4-v4-9-56e7e2576cc1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:33:42 +0000
Message-Id: <20260710223343.65ADF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using a fixed heuristic delay before `vfio_pci_device_reset()` c=
auses test flakes due to `ioctl_assert` failing on `-EAGAIN`.
--

--- Patch [9]: [PATCH v4 9/9] vfio: selftests: igb: Recover after DMA-read =
faults ---
commit 774200982f984c4b603b9d07688586c25dcf8c58
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio: selftests: igb: Recover after DMA-read faults

This commit adds a mechanism to recover from DMA-read faults in the igb
selftest by issuing a VFIO_DEVICE_RESET. It introduces a 10ms heuristic
delay before the reset to allow PCIe/IOMMU/AER error handling to complete
and release the device lock.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
[ ... ]
> @@ -490,7 +512,28 @@ static int igb_memcpy_wait(struct vfio_pci_device *d=
evice)
[ ... ]
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
Since the 10ms delay is a heuristic, what happens if asynchronous PCIe AER
recovery (which can involve link resets and training) takes longer than
10ms?

If the device lock is still held when igb_error_reset_and_reinit() calls
vfio_pci_device_reset(), the underlying ioctl will return -EAGAIN.=20

Because vfio_pci_device_reset() internally uses ioctl_assert() which expects
a return value of 0, returning -EAGAIN will immediately abort the test
program, resulting in a flaky test if the timing is missed.

Would it be more robust to explicitly retry the VFIO_DEVICE_RESET ioctl on=
=20
-EAGAIN instead of relying on a fixed sleep and an unconditional assert?

> +
> +	return -ETIMEDOUT;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-igb_v3_b4-=
v4-0-56e7e2576cc1@google.com?part=3D9
