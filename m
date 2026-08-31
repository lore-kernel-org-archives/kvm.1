Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BF3DE43B
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168904; cv=none; b=opsS8ITtflMk7YA7pgLOewxZnr3AOADC6JftZlIoQVOgX2wXE318P4fsTar50FI9olON6bz3Itt7LoDuD5vMsRODbCET2anHwFwxQQNI+horJcXMLS1M1k15kOcTu8wIhW3KURfvDnGBkeMDaZl239Y3QuwcgYw0lKvFYT0+8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168904; c=relaxed/simple;
	bh=n5nN2ykCXwvizA3X+12ufvK/pxUqnM1DghJaN1jm2p4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d1qoOyOTMcS4IkLfXHkGI7GQuvG68GSp22QuxJyS09QZQxyrgNyT4FUo1kyaKfynLugSuk2bbhLmhmAFdrPotuw2lH/IfYiVmo0OiMIeqwFSbPqPq575y7DZkJdDkUidae/eV+wlzYF2c8chXZojA/2JUF+oo/dyx42r9Mg0XFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmnYyYqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmnYyYqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58571F000E9;
	Mon, 31 Aug 2026 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168902;
	bh=dl+aen0O2AB187crfEFMcUlNUpTD0p0C8NWb0MGJubo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AmnYyYqm7qRs7Kh87pf0Ay13FYeCos9mm1UFS0/Mpp2ji3Lj5sg0/BKcSidRaeeNc
	 0SIVky6Q79sCtu9y0XezcCXdQVkCcxI7NqoZfEQrlPfvveQsYa+mxL8ArktMfIdMeY
	 mFay8DIZeb9ub3WsRyApdk0uDBQ5iE4PwDyUCMh6uDM4i0OLVoOHZYGvipiINeI9P1
	 L3NJ0pomzSFbkfyEjTk192YeEij8eHTCCAHlWXwwgES6g8DMBYL201Iva7R0WV812X
	 ROh5vc0O5TbwrINapP0iLc6sOAK3NVKyQoGxx0akjPnYboOMMpmFuOqOpmqn2NtA/M
	 TtW339VdlKSwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longfang Liu" <liulongfang@huawei.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831090951.844569-2-liulongfang@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:35:02 +0000
Message-Id: <20260831093502.B58571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `hisi_acc_vfio_pci_close_device()` accesses and frees migration fi=
le descriptors locklessly, racing with AER reset handling and leading to do=
uble `fput()` and Use-After-Free.
--

commit 63de12e55959c8c98f32c474a3df763dbb67aa2c
Author: Longfang Liu <liulongfang@huawei.com>
Subject: hisi_acc_vfio_pci: fix live migration enable conditions for PF pas=
sthrough

This commit fixes live migration enable conditions for PF passthrough by
adding validity checks for the PF QM pointer. It ensures operations exit
or return an error directly when the pointer is invalid to avoid crashes.

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
> +		else
> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
> +	}
> =20
>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>  		return;

[Severity: High]
This is a pre-existing issue, but I have a question about how the AER reset
interacts with device closing.

In hisi_acc_vf_pci_aer_reset_done(), the code eventually calls
hisi_acc_vf_reset() while holding state_mutex:

	mutex_lock(&hisi_acc_vdev->state_mutex);
	hisi_acc_vf_reset(hisi_acc_vdev);
	mutex_unlock(&hisi_acc_vdev->state_mutex);

Inside hisi_acc_vf_reset(), it calls hisi_acc_vf_disable_fds(), which reads
and modifies hisi_acc_vdev->resuming_migf and hisi_acc_vdev->saving_migf.

However, in hisi_acc_vfio_pci_close_device(), hisi_acc_vf_disable_fds() is
called without holding state_mutex:

static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
{
	...
	hisi_acc_vf_disable_fds(hisi_acc_vdev);
	mutex_lock(&hisi_acc_vdev->open_mutex);

Can this lead to a race condition where a user closes the device concurrent=
ly
with an AER reset?

If both threads call hisi_acc_vf_disable_fds() simultaneously, they might b=
oth
see a non-NULL migration file descriptor:

static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_ac=
c_vdev)
{
	if (hisi_acc_vdev->resuming_migf) {
		hisi_acc_debug_migf_copy(hisi_acc_vdev, hisi_acc_vdev->resuming_migf);
		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
		fput(hisi_acc_vdev->resuming_migf->filp);
		hisi_acc_vdev->resuming_migf =3D NULL;
	}
        ...
}

Would this result in a double fput() and a use-after-free on the migration
file object since the read and modification are not protected by a common l=
ock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090951.8445=
69-1-liulongfang@huawei.com?part=3D1
