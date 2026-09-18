Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B44D17A7
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721862; cv=none; b=UkiIvmhYQRXOlv3uf3G8KJEWWSE3PzvjUO+OXRiJ1xedxm/w/driDeQeHB88lf0RMDjiWGkZ9J9BxHNvExn8XzB1GAp0a2xX+bsvYXnB6Rr3LXAIH+M7xe4946c/PaOwwHbVtoylc0FoA8bQDoo0wy+ViZsrsTHWDmndeHwB+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721862; c=relaxed/simple;
	bh=d3ctCbbKs4/foyl6mej8xeW2JzTPtEEDeCMKhoLhmZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uF1w584XrDpq/79UbAFPzdzF+sanf0sDGrrQW+R7t8UP+Y7ze1qoE3XUXoeOKt//8cujBcWpw1rADJ86+kiBIKjXO946r3UvcPhup3Iq2/Kj54FLrd8n0DMAFJObGtvloQBXnnJjS0PmXKTCCpFFSzfYCcmdIWVTTF5tn8Sjh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbI3JGko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbI3JGko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40551F000FF;
	Fri, 18 Sep 2026 08:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721855;
	bh=GZbeXl4El0MaPjqQkMuyXb9nPGRKS9WIysLh1KsNfkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fbI3JGkol/gP6Z113CIBcEQPzEOciIiKEuoF7254D/2ZuSu8UhPKK1uMx51CoP77X
	 bq7GDd6pPRlKbNlL7GwdPRvTEoysPxGmtAiCMvzBBmhTTD/z3RjJNGPPCyQMxFcvvr
	 8xCSEdR8DKWpoeDAHhqEXjKzBdcw8/e1RelzLoIPCjKCP8CV0v5IYtjvNFzgIerN1F
	 NyRrIFhIB7+TRyLpaZdNVQGszIvCR8fNFyAfW+GnAW5GN7Q6NdX55BezK1BBZKTmO5
	 OiRAqSrpkubnEijMFQj3b2DYQBIi/prtlYsjriNlsa2ziWm/abR007F92mP9opRiD8
	 qqDMwzhWl7UCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] hisi_acc_vfio_pci: fix NULL dereference in
 reset_prepare on PF passthrough
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longfang Liu" <liulongfang@huawei.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918084244.1485837-2-liulongfang@huawei.com>
References: <20260918084244.1485837-1-liulongfang@huawei.com>
 <20260918084244.1485837-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:57:35 +0000
Message-Id: <20260918085735.A40551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vfio/hisilicon: unprivileged userspace can spam kernel log via V=
FIO_DEVICE_RESET
--

commit 232c524b0aed2e92588a217b15d2d609373f3ea0
Author: Longfang Liu <liulongfang@huawei.com>

hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough

This commit fixes a NULL pointer dereference in the PCI error handler by
checking for migration support at the entry of reset_prepare() and
aer_reset_done(). It also properly clears the set_reset_flag in
aer_reset_done() and updates the VF checking logic in the probe function.

> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a50..8ff69c8d1ff71 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct p=
ci_dev *pdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdata(pdev=
);
>  	struct hisi_qm *qm =3D hisi_acc_vdev->pf_qm;
> -	struct device *dev =3D &qm->pdev->dev;
> +	struct device *dev =3D &pdev->dev;
>  	u32 delay =3D 0;
> =20
> +	if (!hisi_acc_vdev->core_device.vdev.mig_ops) {
> +		dev_err(dev, "device not support migration\n");

[Severity: Medium]
Could this dev_err() be used by an unprivileged user or guest VM to spam the
kernel log?

Since a non-migratable VFIO device (like a PF or older VF) is a valid state,
an unprivileged user repeatedly invoking the VFIO_DEVICE_RESET ioctl might
trigger this path continuously through pci_reset_function().=20

Should this be changed to a debug log, be rate-limited, or return silently
to prevent potential denial of service via dmesg flooding?

> +		return;
> +	}
> +
>  	/* All reset requests need to be queued for processing */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084244.1485=
837-1-liulongfang@huawei.com?part=3D1
