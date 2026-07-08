Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648A21CA02
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553486; cv=none; b=Pm4lytDXNNg9PErL7ttwE1h69CJlvVg/wLJ+9canipGWKMa71pfWuMiBfPsK0GKC7zFFaJ58Q8EHvsO8mW90vfWbzY+29qzlnd3HVTtmcCJ0uzy4bSBJA94rXuo8E8cG66RZR9z1QbnRbFT6wzs3nfwnODhVpUmbkeRWtuiQ+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553486; c=relaxed/simple;
	bh=dbf8PHd7tQp2u2IT/aBiFT9gEwF7gZvosSQHlDpgqNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UBLKqF5uIicM9jOyWwn3jdJNpIM4IYInjQuIfifadNK3lHQs83cq/9eWaDkKLUyORlu5d4UPuYxTOWOeZhfVBoeOMk8rGT5IILRalhcwYxRaBelQ9Ig6XPlveevhehHtW90FqfBa/CZnjD+RANZBx97nGNSdzVMr3p7QXvc7EMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqzVp3GA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqzVp3GA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EEC1F000E9;
	Wed,  8 Jul 2026 23:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553484;
	bh=BIXDEsZfsxGTgLgqYY9lDTXIzHqaVZcAJ2v1qkmiWrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqzVp3GAgXacY4I+rfTCgTZYFcOL/fOJIgQ60ymQ2xEC99GDQqGLQ33rzOhownBe8
	 gOG28EUDmyxzg3Y7Su3Hy51EqakPjdQ4RLxT0RBdfT1bDMmg0VoKiTfsVVOuXSax/A
	 3Z7W3bzE+u7RIT84BB2FGTdvI4mPRrEHnSiGkZXRa9REF1x5K+0c9MU7v9KJq94K0Z
	 0dOUt+wv8At9uXBBY3eT5B0FzzCzwuIwgN2fx+wphMw7f+9E2Iuj1Ijzo2lsNzPdbA
	 U24HL17oGMABGpMl+VX+Uwn7s5ZUDe4qqdpFeDE/JspW//bkkR2h7tmMSoX9jC/C11
	 i4wSg9LMCPdng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] vfio: selftests: igb: Disable PCIe completion
 timeout retries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708-igb_v3_b4-v3-6-1272650ca614@google.com>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-6-1272650ca614@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:31:23 +0000
Message-Id: <20260708233123.F2EEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing SW/FW synchronization semaphore when accessing PHY regis=
ters via MDIO.
- [Medium] Missing DMA read memory barrier (dma_rmb) after descriptor compl=
etion polling.
--

--- Patch [6]: [PATCH v3 6/9] vfio: selftests: igb: Disable PCIe completion=
 timeout retries ---
commit b47012b45a463be841715f383fb27408df2c020e
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio: selftests: igb: Disable PCIe completion timeout retries

The mix_and_match test intentionally submits TX descriptors with an
unmapped source IOVA so that the DMA read fails.  By default the 82576
re-sends the request after a PCIe completion timeout (datasheet section
8.6.1, GCR.Completion_Timeout_Resend, bit 16, initial value 1b).  On
real hardware this turns a single fault into a stream of retried reads,
keeping PCIe AER and IOMMU error handling busy and interfering with
reset recovery.
   =20
Clear GCR.Completion_Timeout_Resend during device initialization so a
failed read fails once and stays failed.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> index 1848be6cd46c9..a7a30660b23ed 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -219,6 +219,18 @@ static void igb_init(struct vfio_pci_device *device)
>  		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
>  	}
> =20
> +	/*
> +	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
> +	 * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
> +	 * mix_and_match test intentionally submits descriptors targeting
> +	 * unmapped IOVAs; with the default (set) value, the device keeps
> +	 * retrying the failed read indefinitely, which keeps PCIe AER and
> +	 * IOMMU error handling busy and interferes with reset recovery.
> +	 */
> +	ctrl =3D igb_read32(igb, E1000_GCR);
> +	ctrl &=3D ~E1000_GCR_CMPL_TMOUT_RESEND;
> +	igb_write32(igb, E1000_GCR, ctrl);
> +
>  	/* Configure PHY internal loopback for testing. */
>  	igb_setup_loopback(igb);

[Severity: Medium]
Does writing directly to the MDIC register on real 82576 hardware risk
colliding with the firmware or BMC management engine?

When running tests on physical devices, accessing PHY registers without
acquiring the E1000_SW_FW_SYNC semaphore can cause corrupted MDIO
transactions or hardware hangs.  For example, in igb_write_phy():

	mdic =3D (((u32)data) |
		(offset << E1000_MDIC_REG_SHIFT) |
		(1 << E1000_MDIC_PHY_SHIFT) |
		E1000_MDIC_OP_WRITE);

	igb_write32(igb, E1000_MDIC, mdic);

[Severity: Medium]
Can the CPU speculatively read the destination DMA buffer before the hardwa=
re
descriptor writeback is architecturally complete?

In igb_memcpy_wait(), the code polls the status bit via READ_ONCE() but
returns without issuing a dma_rmb():

		status =3D le32_to_cpu(READ_ONCE(rx->wb.status_error));
		if (status & 1)
			break;
		usleep(1000);
	}

	igb_irq_clear(igb);

On weakly-ordered architectures like ARM64, the test runner's subsequent
memcmp() reads on the DMA destination buffer could be speculatively
reordered before the loop's status poll finishes, resulting in stale
data reads and sporadic test failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-igb_v3_b4-=
v3-0-1272650ca614@google.com?part=3D6
