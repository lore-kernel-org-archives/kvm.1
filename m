Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7083164B7
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455194; cv=none; b=S4p5+fe51SctQScE3r5F4b8EgeaLpe6RYUTqDY4NxN/byepYeMFu+MYTTKEsfLCZPLZgzHFyO4CQigzRo2OOZFi5L54qwu2naSn2YPEaqgvz7Ztsl2J6n6WYwc7iIvreHZg/Qiip3XrDAQGFy2CoBE0NZNf/SsGHGXe9m5Q6lBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455194; c=relaxed/simple;
	bh=Ln1jlzi3WQz91J6b01M0oc7ialqdIAYVqkYf2SXuK6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SrObMYdhJdEi+Vjx+mx71dLRW/nq2ATE9oKPzBKhPOxCAoNwzQfanlqaB+6avWWo66Tpe8hpCAaRkJmBVFtXsadQAlVmcvdw0E0ax7Xsur2sEN2kK4B1oPKkBAeJ+WE3h7LAljctu6V9rnroIg1yisGMBbd2BUhcjWPIBMwXpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvs1JtT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvs1JtT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735CA1F000E9;
	Thu, 30 Jul 2026 23:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785455192;
	bh=sqRoKDuVvnjEbPCUpiusDxKzLbexOMLf3ffGqOGKC7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hvs1JtT1W9zGlOp2tvIPx70c5IXpMxAiZvcyMEqfs2oA62f9m9K2N1JmeO8hNflLl
	 a9gXQjHeSr5YGGEBKBzxPcIElAWZ+FxS41lC2hclld7JVJBbhZ4RYccz38kb4e/BfO
	 NVlWvAlTDeXWgSzPI4LroIJ12HW6nNuS/7kUZG93uyhx3ANpJnFXujf+4L+2FzKhVj
	 Eo9W9zAqDf5ZObrX36U/3QmHrYQTebu/xTPTs+/aOnrdcHVmTx8IWRStYpCbJ1wy6h
	 Tcms3TzAyKihugOm+5bNxOBLCtq6nu/xJm1UmgMHe5TYeJPL56yUjan7Cuh9wiE7XD
	 gWmW4fZ8kWgpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/5] vfio: selftests: igb: Add driver for Intel 82576
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730-igb_v3_b4-v9-1-9e4d8682437e@google.com>
References: <20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com>
 <20260730-igb_v3_b4-v9-1-9e4d8682437e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 23:46:31 +0000
Message-Id: <20260730234632.735CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing hardware reset after DMA timeout causes subsequent tests=
 to fail
- [Medium] Hardware padding causes out-of-bounds DMA write when memcpy size=
 is less than 60 bytes
--

--- Patch [1]: [PATCH v9 1/5] vfio: selftests: igb: Add driver for Intel 82=
576 device ---
commit f22aea9f4ebf7f7ccc5b90889e5d76147edb84ff
Author: Josh Hilke <jrhilke@google.com>

vfio: selftests: igb: Add driver for Intel 82576 device
   =20
Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
(IGB), specifically targeting the 82576 device. IGB is fully virtualized
in QEMU which makes it easy to run VFIO selftests without needing any
specific hardware.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> new file mode 100644
> index 0000000000000..2f7e5cb26271c
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c

[ ... ]

> +static void igb_init(struct vfio_pci_device *device)
> +{
[ ... ]
> +	rctl =3D E1000_RCTL_EN |       /* Receiver Enable */
> +	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
> +	       E1000_RCTL_MPE |      /* Multicast Promiscuous */
> +	       E1000_RCTL_BAM |      /* Broadcast Accept Mode */
> +	       E1000_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only =
*/
> +	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> +	igb_write32(igb, E1000_RCTL, rctl);
> +	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN | E1000_TCTL_PSP);

[Severity: Medium]
Does enabling E1000_TCTL_PSP cause out-of-bounds DMA writes when the memcpy
size is less than 60 bytes?

By setting E1000_TCTL_PSP, the hardware automatically pads short packets to=
 the
Ethernet minimum frame size of 64 bytes.

When igb_memcpy_start() submits a transmission with a small size, it gets
padded by the device. On loopback receive, the MAC strips the 4-byte FCS and
writes the remaining 60 bytes into the destination buffer via DMA.

If the destination buffer was allocated exactly to the requested size, this
will write up to 60 - size bytes past the end of the buffer.=20

Could we ensure the destination buffer is always large enough to handle
the padding, or disable the hardware padding?

[ ... ]

> +static int igb_memcpy_wait(struct vfio_pci_device *device)
> +{
[ ... ]
> +	if (status & 1)
> +		/*
> +		 * Ensure the test code doesn't speculatively read the DMA
> +		 * destination buffer before we have verified that the
> +		 * descriptor writeback is complete.
> +		 */
> +		rmb();
> +
> +	igb_irq_clear(igb);
> +
> +	igb_irq_enable(igb);
> +
> +	return (status & 1) ? 0 : -ETIMEDOUT;

[Severity: Medium]
Will this leave the device permanently wedged if the DMA times out?

During intentional invalid-DMA tests, unmapped IOVAs cause IOMMU faults whi=
ch
halt the DMA engine. This function will then time out and return -ETIMEDOUT.

Because this error path doesn't reset the device or reinitialize the
descriptor rings, the driver state and hardware remain out of sync. This
causes all subsequent tests in the suite to fail.

Should a hardware reset and reinitialization be performed before returning
on a timeout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-igb_v3_b4-=
v9-0-9e4d8682437e@google.com?part=3D1
