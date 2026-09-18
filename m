Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CCB33B6EF;
	Fri, 18 Sep 2026 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701065; cv=none; b=rjAe5Z5K3T229776UWevRxwTS9e7OFObkjvqpoHKxY6ftcgKMdKMgpDv+6bz8BKM/6rywDDFJRGqTnxQo/1K+/w1fAm7zlWRGgTsFbbODIuYKSF48evjJ/I/7ylupLBsrb4rW6KJeOZSd5KeGWss1FQEJkM27W0egVoUJnjD5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701065; c=relaxed/simple;
	bh=cWsZjHPODxkzALF6XdxHZpXQzjPr502KEy+UqG1zUhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcGNWOLaZNj90a/HNBkt4Fz6V+RjYH1fZgT+fMPLJ2vY4wjRQroLgksNKcxYy1LjOXBsyJ4Thx1pLuowqAUpJBXNg0c3kuu6gTz3VXlq2DATPTUaLugX6qT722s++LQnhxLJB7Wz5DvINQKMApEiXh7QgL3bLcAilUQY+s4AL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=aiYTDtqe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=grns34at; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="aiYTDtqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="grns34at"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 64ADCEC0281;
	Thu, 17 Sep 2026 23:10:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 17 Sep 2026 23:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789701057;
	 x=1789787457; bh=PT8EMO0q9WKCt7s01ka0L342K9uRX/K4DhkF511+4R4=; b=
	aiYTDtqeOHmdTEPbIQaisU1g3qZ0+Kz0XDs3mLLx5DeqsoUMkQI0o3o4q3LkovCQ
	WDbj+ZnCxdyUcniOfKy05WXXsrPHm2EPpRe8XbRbJdMBOBX7lVBN29gZTwVs3di2
	Xc9DLHcg7hsZ3NxqRk+xiMrirSXpo3HKKEytJcDe+lwJX1oWvVUJYOZXQwKwsXtI
	so8j98ZKMhU+UByJhmFxsdW/gOzxeSI/BQNjrkvVoQ6fiBxRPugmszjSRPCoZJMT
	Plk1ZkhdwOZgGgSSRfuvq7IsLHxLjW6qfASrzOB/KLx8efHugME2vncRsZxAKnp/
	AKberjxMlMVX7iPUNA/k7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789701057; x=
	1789787457; bh=PT8EMO0q9WKCt7s01ka0L342K9uRX/K4DhkF511+4R4=; b=g
	rns34atQU47jV/ZaezxrYTM1Ez6RG2jyCA+lDT5Z9lqgDc/tId5cVrUtaMMC9ZSZ
	ykZd2N+Bv/9ZAf3dIc/ijHSca2NfNCpu8KW1mPuuN5Z6A0pe+8/hiz9opg080n4/
	9vBKAmq+u8l2k3aRrWEuVn+2+q48lWtn/kBpBT83uZKMTroy0HqJqkMmJ0DX12GR
	NDkrhKW4iAzIjfbvPG11cGs9QsDtJw6Z/ODloO9i0M9BXjLkSFUmcK95I34OlbDn
	GdP1RIrQYHgIHOqtrS//DD/LMFyOKu17rCxuxT4LPydK5IO1xkTG2vdqKTa+XTsY
	YoIMEH2XQPG7f/vmY/0Fg==
X-ME-Sender: <xms:wKusah2y5EObcoG4WSBjxHB3WK_kVklyeRdpJzTJhvzhWpfxUjG_Uw>
    <xme:wKusahZUD51OIq_3NL6HAyJQfmvcc-ypQH0KFODik7gE4dyRkL_geEQPtitRWYqx0
    4m13Z3rZQ9rUaVv3ncKfiuk-k_u_A4xvoHif_jAn57JaG3zN42C2ac0>
X-ME-Received: <xmr:wKusapJg0KPZrW2io5YT9ZsttMUSrKyFl28vg_ht-ib-_WT-mPywigiOLtOfwA>
X-ME-Proxy-Cause: dmFkZTEqhr5mPjO69/HD0mUZI8gNlmMEJtjZmVTne4kzAI3uiWbDIzCRlnB6uBDbhJo7Ag
    7SwBLQ0lrqnu5z6MfAUSSCgpM2u2NexzTUE51VvbIpPGZKxxi2zjShyBayPgfYfKOlvMl5
    Hn9seB7LX1evxHXJfrX4/ZTAXh19wUFrMDaIssLOkUVd2h5WuugKmZ4zNVmxZnR2EgWseP
    IvmP+fQs4IpUtkC/ChOFLV3Ayz+qHxwt+dbzLxgWWE1S+zvf/m8nf2INrZuDnbI/+/i2sK
    AgMjpkNWUDWMM9gq+HHcN7BXtVod+tgROXtpR1RHejKiFNANWPvTgeZRF1AMLAc/heTUFo
    D3sK/0LIDydhDqjzDDFJzrqjiXNkCKr4c/qi3Y8BzKh3r7omnfGc2OflTGgKm2ftucF6UA
    rBFormhZBpnJkxpCJJyLgr3GK6oMYtp9vRozL2mJ1OiDQkgJyQvsQScW4L5kYrwYH3wmvO
    QGl8CwtGXptyrKGRAhNoNzFce7RFDfmAUMn9qGSNj1KZxDNjzdPCseBnqwpMVOE2WJuaIE
    gx58ZAaHriFja2iGeg6AXID7rFZxGZlg/sMngNfnSdqUd20zew1lQQkHTB7GEu3lEx5Gt6
    xj3k8fPke1eoFyAxaF+O88fVM7O+9TqH6MC8IH2d6lPY4eHthJFQw64ZsMwQ
X-ME-Proxy: <xmx:wKusagFpRCif_mRO6HYpv3r2XP9BkeuAX6FNfFlFcejmz3ZCKznQ5w>
    <xmx:wKusagsSbFRu9JT838DKLYgnS11SOPsUhj7fhYwnUGoF9XStcxaWWQ>
    <xmx:wKusavuUKzUTjG2P7cYynHhe8M-oTXvsNOBgaqCndBWOr8KyQZWCsQ>
    <xmx:wKusauDMD7jBoGXBwZLH7Vp5v2xByZicz46Hm63Et7VPKLVz6JCrNw>
    <xmx:wausarhk7Gjed-GArEhSRrTQCmp-hKJ_mgeCLBtkmnMo_VfLUupQ3QJJ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 23:10:55 -0400 (EDT)
Date: Thu, 17 Sep 2026 21:10:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: liulongfang <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v3 1/3] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
Message-ID: <20260917211052.5166a8c7@shazbot.org>
In-Reply-To: <a6c00ec0-e7f8-35db-6856-ae35cd3abfc1@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
	<20260831090951.844569-2-liulongfang@huawei.com>
	<20260911113724.00d3f79a@shazbot.org>
	<a6c00ec0-e7f8-35db-6856-ae35cd3abfc1@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sep 2026 14:13:31 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2026/9/12 1:37, Alex Williamson wrote:
> > On Mon, 31 Aug 2026 17:09:49 +0800
> > Longfang Liu <liulongfang@huawei.com> wrote:
> >  =20
> >> When a PF device is bound to the live migration driver in passthrough =
mode,
> >> it cannot support live migration functionality, and key pointers will
> >> remain uninitialized. Although most migration functions within the dri=
ver
> >> are unreachable, low-level error handling callbacks may be triggered
> >> directly, causing a crash due to null pointer dereference.
> >> The fix involves adding validity checks at three entry points: device
> >> probe, error handling, and migration initialization. If the pointer is
> >> invalid, the operation is exited or rejected directly to avoid crashes,
> >> while redundant internal checks are removed.
> >>
> >> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live mig=
ration")
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 24 ++++++++++++++-----
> >>  1 file changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/=
vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> index 86362ec424a5..e95d0ab0f11a 100644
> >> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> @@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struc=
t pci_dev *pdev)
> >>  {
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdata(p=
dev);
> >>  	struct hisi_qm *qm =3D hisi_acc_vdev->pf_qm;
> >> -	struct device *dev =3D &qm->pdev->dev;
> >> +	struct device *dev =3D &pdev->dev;
> >>  	u32 delay =3D 0;
> >> =20
> >> +	if (!qm || !qm->io_base) {
> >> +		dev_err(dev, "PF QM not available for reset\n");
> >> +		return;
> >> +	}
> >> +
> >>  	/* All reset requests need to be queued for processing */
> >>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
> >>  		msleep(1);
> >> @@ -1174,8 +1179,12 @@ static void hisi_acc_vf_pci_aer_reset_done(stru=
ct pci_dev *pdev)
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdata(p=
dev);
> >>  	struct hisi_qm *qm =3D hisi_acc_vdev->pf_qm;
> >> =20
> >> -	if (hisi_acc_vdev->set_reset_flag)
> >> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
> >> +	if (hisi_acc_vdev->set_reset_flag) {
> >> +		if (qm && qm->io_base)
> >> +			clear_bit(QM_RESETTING, &qm->misc_ctl);
> >> +		else
> >> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
> >> +	} =20
> >=20
> > set_reset_flag is only set by reset_prepare, which per the previous
> > chunk can only occur if qm && qm->io_base, so this chunk is redundant.
> > Why not just promote the mig_ops tests in both?
> >  =20
> >> =20
> >>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
> >>  		return;
> >> @@ -1565,6 +1574,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(str=
uct vfio_device *core_vdev)
> >>  	struct pci_dev *pdev =3D to_pci_dev(core_vdev->dev);
> >>  	struct hisi_qm *pf_qm =3D hisi_acc_get_pf_qm(pdev);
> >> =20
> >> +	if (!pf_qm) {
> >> +		dev_err(&pdev->dev, "PF driver not loaded, cannot enable migration\=
n");
> >> +		return -ENODEV;
> >> +	} =20
> >=20
> > This function is only reached via hisi_acc_vfio_pci_migrn_ops, which is
> > already validated in probe to have a pf_qm with version >=3D QM_HW_V3.
> >  =20
> >> +
> >>  	hisi_acc_vdev->vf_id =3D pci_iov_vf_id(pdev) + 1;
> >>  	hisi_acc_vdev->pf_qm =3D pf_qm;
> >>  	hisi_acc_vdev->vf_dev =3D pdev;
> >> @@ -1670,13 +1684,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_=
dev *pdev, const struct pci_device
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev;
> >>  	const struct vfio_device_ops *ops =3D &hisi_acc_vfio_pci_ops;
> >>  	struct hisi_qm *pf_qm;
> >> -	int vf_id;
> >>  	int ret;
> >> =20
> >>  	pf_qm =3D hisi_acc_get_pf_qm(pdev);
> >>  	if (pf_qm && pf_qm->ver >=3D QM_HW_V3) {
> >> -		vf_id =3D pci_iov_vf_id(pdev);
> >> -		if (vf_id >=3D 0)
> >> +		if (pdev->is_virtfn)
> >>  			ops =3D &hisi_acc_vfio_pci_migrn_ops;
> >>  		else
> >>  			pci_warn(pdev, "migration support failed, continue with generic in=
terface\n"); =20
> >=20
> > This is not reachable as a VF:
> >=20
> > static struct hisi_qm *hisi_acc_get_pf_qm(struct pci_dev *pdev)
> > {
> >         struct hisi_qm  *pf_qm;
> >         struct pci_driver *pf_driver;
> >=20
> >         if (!pdev->is_virtfn)
> >                 return NULL;
> >=20
> >=20
> > pf_qm is NULL, the branch is never taken for a PF.  Also:
> >=20
> > int pci_iov_vf_id(struct pci_dev *dev)
> > {
> >         struct pci_dev *pf;
> >=20
> >         if (!dev->is_virtfn)
> >                 return -EINVAL;
> >=20
> > So even the redundant test is already here.  What are you trying to
> > accomplish in this chunk?  Thanks,
> > =20
>=20
> Thank you for the review. Regarding the first two checks in `aer_reset_do=
ne` and `migrn_init_dev`,
> you are correct that they are redundant; we will remove them in the next =
revision.
>=20
> However, the PF passthrough scenario still crashes. The calltrace we actu=
ally tested occurs on
> the following path:

I didn't argue this fact, I only noted the .reset_done fix is redundant
and suggested a better ordering.

>=20
> hisi_acc_vfio_pci_open_device
>   =E2=86=92 vfio_pci_core_enable
>     =E2=86=92 pci_try_reset_function
>       =E2=86=92 hisi_acc_vf_pci_reset_prepare   =E2=86=90 NULL pointer de=
reference
>=20
>=20
> `reset_prepare` is a PCI error handler callback invoked by `pci_try_reset=
_function` inside
> `vfio_pci_core_enable`, which happens before the `mig_ops` check in `open=
_device`.
> At this point, the PF's `pf_qm` is NULL, and `reset_prepare` dereferences=
 `&qm->pdev->dev`,
> causing an oops:
>=20
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00000000010
> pc : hisi_acc_vf_pci_reset_prepare+0x34/0xc0
> Call trace:
>  hisi_acc_vf_pci_reset_prepare
>  pci_dev_save_and_disable
>  pci_try_reset_function
>  vfio_pci_core_enable
>  hisi_acc_vfio_pci_open_device
>  vfio_df_open
>=20
>=20
> This shows that the `vf_id`-based check in `probe` does not actually prev=
ent the PF
> from reaching `reset_prepare`;
> the PF still triggers the calltrace through this path. The fix here will =
follow your
> suggestion: elevate the `mig_ops` check at the entry of `reset_prepare`, =
and also
> move the existing `mig_ops` check in `aer_reset_done` ahead of the `set_r=
eset_flag`
> handling.
> The `is_virtfn` check in `probe` will be retained to maintain consistent =
semantics with
> other vendor drivers.

I don't see this provides any consistency with other drivers, only the
virtio driver has a is_virtfn test and it is the fundamental test that
driver uses to select the migration ops.  It's not comparable to this
use case.  Thanks,

Alex
