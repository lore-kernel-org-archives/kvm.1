Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C72489863
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724942; cv=none; b=DEMNXB51ii9EcjWOTDgtm1MjovBERecXmv2yLkzviBIgWn0vTnudc+wz4chWnXjxhY0u7emW3DYFwmc/D8gx5jqWKqc+OBty1EUaK8nrOeb2uPARTqbc6OlwlBgi5xviSKh1HZcuhssqIjf1dQzADro2af72d0sNPCJ53MUuyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724942; c=relaxed/simple;
	bh=KyFA94HH3rDgnOXKBdatglA1R3CTSM65990G7g1ZmKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mmvOE7xowSLx58axD3571Cg66ZJcrh7qU+Al8nTMR84WU/TEvML0BQfzvw5jSa8BecVeqU8Huap6oG/3p8G5Y3eh2c30OQhSMI/HvOGg01AkB2zlKXrZCov3YJbIgkYkJ7NW8F6VedS9r1nGyx4huxzQXiF4cWe+tShN9mHoZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ2udDEQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ2udDEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB9E1F000E9;
	Mon,  3 Aug 2026 02:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785724940;
	bh=TVoIOPt35BBhVk95nWGYNs1N2KvK/7Quh4V55Rl9/V4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZ2udDEQNaDnT3AfPotw693UsrhzGRTG2OVdhxPCHqO0ExsjgrMfX9eNUtMTgka+3
	 /VxvnspeMy0xXJJtogKqucL8PJS4UMv9S4cnIErpn+cqyorsAarnjBF8HgbUhLiK/K
	 QKpOHY1sv8BcCr0g8sBmqIPEFjE2qCG0HMONtbrRpWEfcX6DlKEQkEUzgNJq2di543
	 ByYvQisxYDvbwwR0fXqkyFYovRpB9q1EJEgX1dBboXINZAy7Tdi1ExJSHxHG5yjFbO
	 sAvGJN9jyOU/UNogaJ1FfVnPe2qp5ucaSmSaSP9Bs12jndJYIfKJJjjuP6OfXH8xD4
	 jYOWubEzA4aKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longfang Liu" <liulongfang@huawei.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803021857.2370179-2-liulongfang@huawei.com>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
 <20260803021857.2370179-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 02:42:20 +0000
Message-Id: <20260803024220.ABB9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to prevent a Use-After-Free because `pf_qm` become=
s a dangling pointer (not NULL) when the PF driver is unbound.
- [High] `set_reset_flag` is never cleared, causing spurious lock release d=
uring subsequent failed resets.
--

--- Patch [1]: [PATCH 1/2] hisi_acc_vfio_pci: fix live migration enable con=
ditions for PF passthrough ---
commit 2cccd4c0444989d0fd451c1227c40bde4c25acb2
Author: Longfang Liu <liulongfang@huawei.com>
Subject: hisi_acc_vfio_pci: fix live migration enable conditions for PF pas=
sthrough

This commit attempts to fix a calltrace exception triggered when a user
unbinds the PF device driver from the host and directly passes it through to
a VM, then attempts live migration. It adds checks across operations that
depend on PF driver commands to ensure the PF's QM structure is available.

> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a50..36490be7a61aa 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -378,6 +378,11 @@ static int vf_qm_check_match(struct hisi_acc_vf_core=
_device *hisi_acc_vdev,
>  	if (migf->total_length < QM_MATCH_SIZE || hisi_acc_vdev->match_done)
>  		return 0;
> =20
> +	if (!pf_qm || !pf_qm->io_base) {

[Severity: High]
This isn't a bug introduced by this patch, but since the patch attempts to
fix it here, does this check fully prevent a Use-After-Free?

When the PF driver is unbound while a VF is assigned to a VM,
pci_disable_sriov() warns but doesn't prevent the driver's remove callback
from executing, causing the PF's qm structure to be freed via devres.

This leaves hisi_acc_vdev->pf_qm as a dangling pointer rather than NULL.
Will the !pf_qm check fail to catch this, leading to a UAF read when
accessing pf_qm->io_base?

> +		dev_err(dev, "failed to match check for PF QM migration\n");
> +		return -ENODEV;
> +	}
> +
>  	ret =3D vf_qm_version_check(vf_data, dev);

[ ... ]

> @@ -1174,8 +1194,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct =
pci_dev *pdev)
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdata(pdev=
);
>  	struct hisi_qm *qm =3D hisi_acc_vdev->pf_qm;
> =20
> -	if (hisi_acc_vdev->set_reset_flag)
> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
> +	if (hisi_acc_vdev->set_reset_flag) {
> +		if (qm && qm->io_base)
> +			clear_bit(QM_RESETTING, &qm->misc_ctl);

[Severity: High]
This is a pre-existing issue, but should the set_reset_flag be cleared after
releasing this lock?

If hisi_acc_vf_pci_reset_prepare() successfully acquires the lock, it sets
set_reset_flag =3D true. However, when hisi_acc_vf_pci_aer_reset_done()
clears the lock here, it doesn't appear to reset the flag back to false.

If a subsequent reset occurs and reset_prepare() fails to acquire the lock
(e.g., due to a timeout because another VF or the PF holds it), won't this
function erroneously clear the QM_RESETTING lock that is actively held by
another context?

> +		else
> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
> +	}
> =20
>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803021857.2370=
179-1-liulongfang@huawei.com?part=3D1
