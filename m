Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510E2475D0
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170424; cv=none; b=TwOfsaRwLz4xUJ5m/pXIQaHtIMxP56rHzJM0Qio2KZkwWr1Xg8T53HbLX31ttlexsibZ1Tj1JTd9mTnxffOwiEgUKMugKP7uTCJ/G98s0k5e2s+TjaHLiEgpxcWbfAcEcezrVaA7mXFANH06y065rz8ywhmUabU+f6EAPFxs90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170424; c=relaxed/simple;
	bh=OM48rFp00GcDzDPpOaH+UclFgMi7HtgNnaK9R6vwuE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgD5I7dN0qbFTSGlTlESShoCRLzr30z23gHDa0Dzr0D3F0I6aVBMVyQl8BTfJyi7tI9xkF7WC8whyMutPvlswKkbqpt7DLPYWekc8L7bOC5i17rNfe5ZYuttBw534p6EWRURJORJQvSHPzvRVy+DQSGJGy6B5J/dy1PwwQbIH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKrmc3zI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKrmc3zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0155B1F000E9;
	Mon, 31 Aug 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170423;
	bh=/mERWFw6S3wa4CtMSoguppmggIqa26weVsXS6S9ZYMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fKrmc3zIM1gcOwzd6t79Ych5fkSF0hpQxCuagifK4dmxL270we0SwYwtLCDB1kq+w
	 ujY3OI9WCp5XU/D+hGsUtVtB8b7QO/yodzoTx8A5zMwbAopbhUrmmQuF3DggBxJP6G
	 tOahOb7nWuW33cA82og1SFl4MvGwuFapIYiCeA6Atb4q/agbq9knTxx/HmXWu+JRF1
	 9SP7nm6wRYibnSe5WC05zkpv3qjhbma0oYEH8hq9Nd9nIS+kYkwGAi58Es9nLUABIp
	 cHuCPmgC2uyqnz2hw3obxx0U32xC5UHqnlEdA01c3XDobrLJVP2zOWtHIaQ05Oi1al
	 LXO/mgm1nDxAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] hisi_acc_vfio_pci: reject live migration on 64KB
 page with QM_HW_V3 hardware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longfang Liu" <liulongfang@huawei.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831090951.844569-4-liulongfang@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-4-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:00:22 +0000
Message-Id: <20260831100023.0155B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch completely breaks VFIO passthrough for this device on 64=
KB page hosts instead of gracefully falling back to generic operations.
--

commit e0bfdb6998df9e209e0b7358693ec17f21c25bfe
Author: Longfang Liu <liulongfang@huawei.com>

hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware

This commit aims to prevent security vulnerabilities and guest exceptions w=
hen
combining QM_HW_V3 hardware with 64KB pages by disabling live migration. It
returns -EINVAL during device initialization if the host page size exceeds
32KB.

> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index 4abed2e49986f..4f12cab96545e 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1210,6 +1210,23 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_=
core_device *hisi_acc_vdev)
>  	else
>  		hisi_acc_vdev->drv_mode =3D HW_ACC_MIG_VF_CTRL;
> =20
> +	/*
> +	 * On VF_CTRL hardware, BAR2 holds 32KB functional + 32KB
> +	 * migration registers. When the host page exceeds 32KB, the
> +	 * two share one physical page and cannot be isolated by mmap.
> +	 * Reject the open so QEMU fails cleanly at startup.
> +	 */
> +	if (hisi_acc_vdev->drv_mode =3D=3D HW_ACC_MIG_VF_CTRL) {
> +		resource_size_t func_len =3D
> +			pci_resource_len(vf_dev, VFIO_PCI_BAR2_REGION_INDEX) >> 1;
> +
> +		if (func_len < PAGE_SIZE) {
> +			dev_err(&vf_dev->dev,
> +				"migration not supported on 64KB pages with QM_HW_V3\n");
> +			return -EINVAL;

[Severity: High]
Does returning an error here completely break VFIO passthrough for this dev=
ice
on 64KB page hosts?

Since hisi_acc_vf_qm_init() is called during device open, returning an error
causes the entire operation to fail. This results in users completely losing
passthrough functionality for QM_HW_V3 devices on 64KB page hosts, rather
than just having migration gracefully disabled.

Could this be handled earlier in hisi_acc_vfio_pci_probe() instead?

The driver currently assigns migration operations unconditionally:

drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:hisi_acc_vfio_pci_probe() {
    ...
    if (pf_qm && pf_qm->ver >=3D QM_HW_V3) {
        if (pdev->is_virtfn)
            ops =3D &hisi_acc_vfio_pci_migrn_ops;
    ...
}

If the 64KB page limitation was checked during probe and fell back to the
generic ops instead, normal passthrough would continue to work correctly.
The generic VFIO implementation safely maps the entire BAR2 region without
KVM trap-and-emulate issues.

> +		}
> +	}
> +
>  	if (hisi_acc_vdev->drv_mode =3D=3D HW_ACC_MIG_PF_CTRL) {
>  		/*
>  		 * On hardware platforms greater than QM_HW_V3, the migration function

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090951.8445=
69-1-liulongfang@huawei.com?part=3D3
