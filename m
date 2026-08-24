Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD913A425B
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560929; cv=none; b=A3OQ17zBZJKKocIxByiXiDtN91tZMQ2MvYP6zwXQwDefGNBZOEmRSMVatoNYqWwQY49kl9XujDIWgtBOeV1G83IXUodEzE7DpYkVbqnJYyKDwq8w5D21TWL+A9Xq3AkoZFT+VX4L+g5Sm9MQRKilgxYP8lvg+AT4VQGjlmzsPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560929; c=relaxed/simple;
	bh=SSoatR0Qxr/pJB0d/uWI8boqfK7BphGpzQJx9xDDd2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MiwSKdXgiQJXIzLbk/03Xd1zOSJhIaOkKSYDMu1aSIA70X4nyAAp/UXdvP3y8j12Es5JGwbJcTsY6mTRZyrp0lxKx3zjOzeuLaf8fsYny0IkNfpAH8geb+/82N9ww7AZvf3e8+ECxMCHxT1O5NWL1eLNf7gwgZj1qVNX1DswCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFX/bzZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFX/bzZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A391F00A3A;
	Mon, 24 Aug 2026 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787560928;
	bh=jfOT573wcz+GsaUlcDuqceb3m7PobcBDSxHllSie8qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFX/bzZDL/wYbnPLHKq8hMnT/dUulLTxM35p/9QsvoajT925+DFbjVXEjF1TLcImF
	 2x3jpaDHcNpgc7mzbd8MAz0NuawXHHt2tH3UgwTgbPxwmmxPN0TM5hIxQ12Hm/bvyZ
	 6iqWpsUfTN2YTLGkQqSjApZUu8HShZLp/l9Rbc0eDshKlqYnl5jLn5RumGiKoNXJWg
	 hNkaMFfbc4DMCIAuAhgZ19+QCgvUkSll+GflK7Vwod0/Gr/wcNFtoVoCdtSapQJw7X
	 1Nlt6MQmtijuxo6U5vzTrX4QjCUzHHquXQLpfeb9vDdciOkF9UCEgu73iTTpxWv+uE
	 Gq4B2PVcql/8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longfang Liu" <liulongfang@huawei.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260824082851.1436129-2-liulongfang@huawei.com>
References: <20260824082851.1436129-1-liulongfang@huawei.com>
 <20260824082851.1436129-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:42:06 +0000
Message-Id: <20260824084207.C8A391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `set_reset_flag` lock tracker is never reset to false after a =
successful lock acquisition, allowing subsequent failed resets to erroneous=
ly clear the global `QM_RESETTING` lock.
--

--- Patch [1]: [PATCH v2 1/2] hisi_acc_vfio_pci: fix live migration enable =
conditions for PF passthrough ---
commit e8e63b8a17edd44cc9b69e8ca3472ee6c656873c
Author: Longfang Liu <liulongfang@huawei.com>

hisi_acc_vfio_pci: fix live migration enable conditions for PF passthrough

This commit fixes a crash in PF passthrough mode by adding validity
checks for uninitialized PF pointers during device probe, error
handling, and migration initialization.

> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a50..e95d0ab0f11ab 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
[ ... ]
> @@ -1174,8 +1179,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct =
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
This isn't a bug introduced by this patch, but is it possible that
hisi_acc_vdev->set_reset_flag is never reset to false after a successful
lock acquisition?

If a prior reset succeeds, hisi_acc_vdev->set_reset_flag is left as true.

If a subsequent reset attempt times out in hisi_acc_vf_pci_reset_prepare()
because another agent already holds the QM_RESETTING lock:

hisi_acc_vf_pci_reset_prepare() {
    ...
    while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
        msleep(1);
        if (++delay > QM_RESET_WAIT_TIMEOUT) {
            dev_err(dev, "reset prepare failed\n");
            return;
        }
    }
    ...
}

The code returns early and leaves set_reset_flag as true.

When hisi_acc_vf_pci_aer_reset_done() is subsequently invoked by the PCI
error recovery flow, it observes the stale true flag and unconditionally
clears QM_RESETTING.

Does this prematurely clear the lock currently owned by the other agent?

> +		else
> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
> +	}
> =20
>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082851.1436=
129-1-liulongfang@huawei.com?part=3D1
