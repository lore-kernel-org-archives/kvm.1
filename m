Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41E281503
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840900; cv=none; b=mv+YDEpXIsVMrk+sGn9cyjtS2H+E3O4i1ckE8GVF4AvXjTZu2nxUkuj52w8OLLEMSZH+kHUTqFG+boKCZ8dFvuNIPiI8WNkWQmcxI04Ge7Fis+zAELU1xyAPbg7AN27mERs0SQfUScR2mJWCwJkknJH5kgnVyneT/EDZDPGqs7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840900; c=relaxed/simple;
	bh=pL6h1NE6DWf/rU/VsSnUx9/aHjKQK/2KaZNdL60mM3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8JrnAxP4b88gyNy6f8zIaYze2PyiLFIHgTXnbPvWfdgLvsE016RI7PijNCk5FVmFA1lxw+ll0kd70a+mPJNpztrygqkboGCk+RtCzE7ejXbE0jAhm1HBo2QEFLdcxQOqa+Kenac7Hocf08AoXiZIFKa/v5USyUvL8CKZMEXURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OayA1gDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OayA1gDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A771F000E9;
	Wed, 27 May 2026 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779840884;
	bh=YEqzKzc0ORxC1DtmDx+EGiqoz+8JVRqlubpGLdh0X6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OayA1gDVOa47FrnsKBLaxTH6zVdeItC1RN4aBjYNUv7u1TJdlL5qvdFINvhtz62pZ
	 IiLirFd+YdpLEKxNvgj6x75UX/v75JUPHsxahkq6WTv3lAbeowVh+fHAbFyJqqS9of
	 uVze1S6hbpRAvEnQr61uAJHS7tbwou0X9YVVbbLQUntuQPOeR8NmRIlS+6l1mp2xnW
	 FwqIeaiIMWxoKs6g9O13kIUtuje2peis8PXvS+0wf/N4BJHhsN+oKK53vsqrd+KKHP
	 XVAwWHWkQmjWogUgJmLTWGxyQizh0gFP3J4URL4+Gvap+knCY23Ax6gn9YmWDVPu3B
	 d23vo18hoNXTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] selftests/vfio: igb: Use advanced TX and RX
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526235417.2058313-4-jrhilke@google.com>
References: <20260526235417.2058313-4-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 00:14:44 +0000
Message-Id: <20260527001444.69A771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Overwriting IGB_SRRCTL0 clears the BSIZEPACKET field, setting th=
e receive buffer size to 0 bytes and violating the hardware specification.
--

commit dc2cc67e8a6e2c641907cee5129b78515c56abca
Author: Alex Williamson <alex.williamson@nvidia.com>

selftests/vfio: igb: Use advanced TX and RX descriptors

This commit updates the igb selftests driver to use advanced descriptors for
transmit and receive. It configures SRRCTL.DESCTYPE to the advanced
one-buffer layout for receive and sets up advanced data descriptor fields
in igb_memcpy_start() for transmit. Legacy CMD macros are removed.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> index 5bbc6fca75189..c0f9cefb23e59 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -226,6 +226,17 @@ static void igb_init(struct vfio_pci_device *device)
>  	igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_desc));
>  	igb_write32(igb, IGB_RDH0, 0);
>  	igb_write32(igb, IGB_RDT0, 0);
> +
> +	/*
> +	 * Select the advanced one-buffer descriptor format.  Per 82576
> +	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
> +	 * value other than 000b for the 82576 to write back the special
> +	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
> +	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
> +	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
> +	 */
> +	igb_write32(igb, IGB_SRRCTL0, IGB_SRRCTL_DESCTYPE_ADV_ONEBUF);

[Severity: Medium]
Does writing directly to IGB_SRRCTL0 unintentionally clear the BSIZEPACKET
field?

Because this is a direct write rather than a read-modify-write, all other b=
its
in the register are cleared to 0, including BSIZEPACKET (bits 6:0).

The Intel 82576 datasheet dictates that BSIZEPACKET sets the receive buffer
size in 1 KB increments and explicitly forbids setting it to 0. A 0 value
leaves the hardware with no space configured for DMA, causing it to drop
incoming packets.

This behavior remains present in subsequent patches in the series, where
the macro is updated to E1000_SRRCTL(0) but the BSIZEPACKET field remains
unpopulated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526235417.2058=
313-1-jrhilke@google.com?part=3D3
