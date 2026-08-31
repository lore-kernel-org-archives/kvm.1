Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E173D25AD
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169565; cv=none; b=TyddQ1sFKvQpD4ydy1kcpOeTQnnCVyt3pBw4uWu++a55DkL4ggH/cDjvxSuqgCPHkTzlUHkZmoZJWu5OYe/ixQQQVfvpklbjWznw1JXUVfUPA33mt7JbA9VpW6pl728KiaQS0gi5/W3A+jX9ixi0gqsrb4C2uw3rb/PlJmCQj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169565; c=relaxed/simple;
	bh=PssIyGRpPn08r/pEnA7EQZ84lgHEHhpJhmPi/e+En0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S1cJkdrH1QgxV2KxlUW9hr233XJjCjLrM+mtduBt7H0EHuYpMp1PxSLxQbgqtnQyR3gmN7LQ9cylIHdCtc32udep66lILuovI63TqdKBi2U48OQ1F4IAFHIIkw0ELCfJnGj2CKBiwhlcuxyF2i7FIgB4i4Fy9E4pd2/8F9btuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXvmDsGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXvmDsGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC541F00A3E;
	Mon, 31 Aug 2026 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169564;
	bh=PFGZV6IvMjeTqtbxmnf2aXMui9eTI0Yb+fI5sq0DtMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IXvmDsGmYJyHIjnPPe/V9DWYTTiPwylePIreW0q9FChSjS+Qsl7Z5LhZO/VLBzKYu
	 M0YhLLP8IAEUMJNpuD5wlLgJ7RWLnz2XIBjjVkBn9h0TXNA8RFaRbSSkhE4ao2D5I5
	 E11zDkjzQT3tWSmwJKWx+LxOSA0PF5tZbSrsxL/8Jh3a0Vj93q/M0+vKMFGuj9qi8+
	 37b6uldozNgLImmkT+6THH43fh0zvZVYp0fEdVWBhUXpWlaXBFqNRDEERew3edgba3
	 8ayGMnwb0RLqxZLoLIbzW2LKkE45vlCnMOu52lqi81cUJQNswNwyOrPkS3n4n3qZ7T
	 xekWzfHlgtmkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] hisi_acc_vfio_pci: clear set_reset_flag after
 reset completed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longfang Liu" <liulongfang@huawei.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831090951.844569-3-liulongfang@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-3-liulongfang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:46:03 +0000
Message-Id: <20260831094603.CBC541F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete fix: `set_reset_flag` is not cleared on the error path =
when `qm` or `qm->io_base` is NULL.
--

commit 20e8953675b36be7d8bfc2a18cb44431bd40084a
Author: Longfang Liu <liulongfang@huawei.com>

hisi_acc_vfio_pci: clear set_reset_flag after reset completed

This patch attempts to make every reset cycle self-contained by clearing
set_reset_flag during aer_reset_done. It addresses an issue where a stale
latch could prematurely release a lock owned by another agent during a
reset timeout.

> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index e95d0ab0f11ab..4abed2e49986f 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1180,10 +1180,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct=
 pci_dev *pdev)
>  	struct hisi_qm *qm =3D hisi_acc_vdev->pf_qm;
> =20
>  	if (hisi_acc_vdev->set_reset_flag) {
> -		if (qm && qm->io_base)
> +		if (qm && qm->io_base) {
>  			clear_bit(QM_RESETTING, &qm->misc_ctl);
> -		else
> +			hisi_acc_vdev->set_reset_flag =3D false;
> +		} else {
>  			dev_err(&pdev->dev, "PF QM not available for reset done\n");
> +		}

[Severity: High]
Does this leave set_reset_flag persistently set if qm or qm->io_base
evaluates to false?

If agent A sets set_reset_flag to true and encounters an unavailable PF QM
during hisi_acc_vf_pci_aer_reset_done(), the flag will remain true.

Later, if agent B holds the QM_RESETTING lock and agent A attempts another
reset that times out, could agent A's aer_reset_done() see the stale true
flag and prematurely clear agent B's lock if the QM has since become
available?

Should set_reset_flag be cleared unconditionally in this function, regardle=
ss
of whether the PF QM is currently available?

>  	}
> =20
>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090951.8445=
69-1-liulongfang@huawei.com?part=3D2
