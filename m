Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8F357CF4;
	Wed,  5 Aug 2026 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899749; cv=none; b=btmtn/PFqli0nDuN1eSuHe6/wDolj049gBMuyWuXlUeAKaEMZgbVXqQJRogpElRZpbEJY1F3P/bWdJzTbpYUnymSbAKrUgCgpkb0TfvZ+t81ua3kJ6VzZ3va/1hTqZwX51rDao9u9dz2vDatSktdVlSDG3E3bhRbPOH7SaklP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899749; c=relaxed/simple;
	bh=BgsxFqaCh2F5ejIZEshWuK3Guit+MyYwz42Dh9nPMC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr2Rq6bEmBbsYUaU83BseK8ylx5SDdj137OBCfkIq8uu/ALslQgImbsKuJu7kbDrc0Qgq/B1KK6lI7HawZfM/xJG6BoMryCdSrtuc9+aFbYyHjdu8BWtr/ngkhM0LcS3nnaWr5CwfRzieUJxIj6H2WIy1UByJnFCVQfDN0nQupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=g1uVMT8b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmPnKzqJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="g1uVMT8b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmPnKzqJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C73B5EC01D2;
	Tue,  4 Aug 2026 23:15:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 04 Aug 2026 23:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785899744;
	 x=1785986144; bh=OcGR3wadaB1zY2BxJhSb76nSp8wle+BdGrvp5Wer0A8=; b=
	g1uVMT8bNbYvLuFjzEoM9PV28e2TK+UmFXX4omyY0YvZfPdlttVXSyfM1VNmOibS
	RHR4+GFJ98UgEvjlB+y+dXTOKQK/WAvOTnK3K9/RleFNNAwBolAoYm/N9NOejt+n
	rgvblQB41gjkCbM/UMru2Yb/1CebUxeJQWg/xI1xniM5wa2x5MJcZf/iETAQoxVe
	QL+t3Eio2dOP9lGLFe3isA//XNYYe/ErXTp0lw4FCEzXXM/AdIoMFMFe2vGewH/S
	GMZy9H8GirmB6NpdcVPbJBjefPldLIPpYGDlTpt05he/vu8uNxWOgY/cB0P7MdfH
	hbbJQqkyMTmSOcD+5108vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785899744; x=
	1785986144; bh=OcGR3wadaB1zY2BxJhSb76nSp8wle+BdGrvp5Wer0A8=; b=H
	mPnKzqJfQRI6N0A0KYQAifzJ19KQmw7Et13UZbfeUjXfKGa3NG4dUc0J75KOz5Or
	mAFJlcEAAfJgHCewm5pz4aPxsqwOj0HS8/9o8B+IbAODzKF0jMGTfCvXN2cUYAYC
	6hRnA0kdmDdA/2IeXR3PkL6uE0uXaizdQDbs/T+YZIx9y3uOM7O+4d2IJz8wMBYk
	ArNmncMfTukzzP6V9bHEAorS2AoWp7kjBRVDz9xEDBGX9M/19VW3EqZoTZx5lzBW
	b1ajtGDltv4O6MwldMDBJDEnUei9LlJKX7jnMfBvjujgexbYDb5h2MI6kGfxhVPu
	0lDSCn8ux0jAnzHNyCg3Q==
X-ME-Sender: <xms:4Kpyamv5aaeJDVLUV2b4gSyDSQ4f7ZkXNaVe9M9cOn9Wo9tCPYJIvA>
    <xme:4KpyakzExhrLZ-gVJ_C_h_dJIznX_DG4P_Jbph15iIc6k17Nd5g9-9tGS6VNuaPmK
    NA6Iydm9oJgotdWAMQ-ISO-lLtC2XmFIm6AJqHVf6oEk3a9bO0cStI>
X-ME-Received: <xmr:4KpyapCrgz_dcChWtXf_dK-6XnS_EFEz3MUmJqF0zkccxTMboj8HK7N5lR3hsw>
X-ME-Proxy-Cause: dmFkZTEmKzawqWDKPpY99bgFcd8i5LxDGOhZ00vqTOjoQJiavs/8QjJ2XkhYxTfhoLHDJh
    c7qYmFcrtprlDpdB4VIzEXpJVk/Mjuq3+UaWehYOBRcd7hWISIiyGlINCsT50FbCp47bX+
    6mV7/RBqfezxKltXX23dzA+IO8FbUCtdeOBsuC0VZ2RTE0DwB/1rmvvUNLZ0qmzlXQVxhZ
    q/Nldm6CPcKxVY02Eaww1kcWO36bpWi9hvNautSCHi1LaNyz3Xqzqps+bESB5IwfcQbkx1
    GNj5xjIqz860TRhfWPS4GVqkRiFlyLcYKtwM/KBxQhtYJPOe4a3NYI/hqINXwQuDUCjxtd
    q6mG1J8Z9RS/OlCbNkXX2dDE+KeaCtnR4Q5fRoyhfQ8egJ4pNZ9GUrdFC2vMltq/ORPfn/
    GiXDgsBmyIBynUczOiyLUjm8SjkVphd2MR/HGMtXt/OnB6PYjqBy/9gKKu1oy9cDYcMfEW
    0Exh4Qbsa16ZCW2ipPQFE+6OLjoOEvlE/Vxxu1hrxg2u2lIPAMOHi8VnHOqzDr8M3NmP6L
    1jXxhMpNU/XzjkoI5Ei59Ar92QD19SaUEviUfecTJNuHbtGoJYj8AwG5KAcC2L9RIhM+a/
    vLZ37+ItcwMDzDKp1r5P7DyJhhZmRjIbtVAXbPtok7xnXvpxKuGzjioYpE8g
X-ME-Proxy: <xmx:4KpyaieLI-_1YS8HWPNbqeH5GDh47r4HhjJNR5JjtgPr2GCm_rMTeg>
    <xmx:4KpyajnAI-lDn5MjfRD28RPrqLa2KF6TBe9SvuZn_hUzEOd8pmYRog>
    <xmx:4KpyapESRgT0SWiXdnSSEiYYhivtPzLgNNgJ6xlIJrLZhiF8MWBbPw>
    <xmx:4Kpyar4JdI1zd5PeW6WGsBbsHnleUBRJ9kymhRUoQM9k41T50ymW6Q>
    <xmx:4KpyatSLSrtHZnvg00cJKE-S9EysxayiaNjH9Wk_sZnKPVtrGNPgPQMe>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 23:15:43 -0400 (EDT)
Date: Tue, 4 Aug 2026 21:15:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: liulongfang <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 1/2] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
Message-ID: <20260804211540.177d9d7d@shazbot.org>
In-Reply-To: <07d8a508-980b-0974-c793-b355be0a624f@huawei.com>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
	<20260803021857.2370179-2-liulongfang@huawei.com>
	<20260804132805.68023c24@shazbot.org>
	<07d8a508-980b-0974-c793-b355be0a624f@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 10:19:35 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2026/8/5 3:28, Alex Williamson wrote:
> > On Mon, 3 Aug 2026 10:18:56 +0800
> > Longfang Liu <liulongfang@huawei.com> wrote:
> >   
> >>     In the previous implementation of live migration support for
> >> Hisilicon accelerator devices, there was insufficient consideration
> >> for the fact that PFs cannot support virtualization live migration.
> >> If a user unbinds the PF device driver from the host and directly
> >> passes it through to a VM, then attempts a live migration operation,
> >> it will trigger a calltrace exception.
> >>
> >>     To address this, we conducted a detailed analysis of potential
> >> failure points. We added checks for all operations that depend on
> >> PF driver commands and incorporated relevant conditional judgments
> >> to prevent system calltrace exceptions when users attempt live
> >> migration after passing PFs through to VMs.  
> > 
> > I don't understand your core premise here.  hisi_acc_vfio_pci_probe()
> > sets the default ops to hisi_acc_vfio_pci_ops.  This ops structure uses
> > vfio-pci-core callbacks for everything except .open_device, for which it
> > uses hisi_acc_vfio_pci_open_device().  This function has exactly one
> > migration related branch, which is entered only when core_vdev->mig_ops
> > is set, but mig_ops is only set in the .init callback of the ops
> > structure supporting migration.
> > 
> > In order to get the migration ops structure, hisi_acc_get_pf_qm() must
> > return a pf_qm, the version of that object must be at least QM_HW_V3,
> > and the vf_id must be valid.  hisi_acc_get_pf_qm()'s very first action
> > is:
> > 
> >         if (!pdev->is_virtfn)
> >                 return NULL;
> > 
> > Therefore, how is a PF ever getting associated to the migration ops
> > structure?
> >  
> 
> This Hisilicon live migration driver actually utilizes two hardware-related
> configuration functions. The first is the PF control function, obtained directly
> through hisi_acc_get_pf_qm, which handles mailbox command operations, device health
> status checks, device reset verification, device stop commands, and other device
> control processes. The second is the VF configuration function, which is passed
> through via VFIO direct assignment and serves as the main entity for device live
> migration, responsible for current service device data migration and recovery operations.
> 
> The aforementioned issue occurs when users incorrectly pass the PF directly to this
> driver through driver_override. In this scenario, the vf_dev in the driver structure
> erroneously points to this PF. When the PF attempts to migrate itself, it will directly
> cause exceptions. Therefore, it's necessary to add pdev checks here.

This doesn't answer the question.  How does binding the PF to the
driver pass the existing is_virtfn test in hisi_acc_get_pf_qm() in
order to map the migration ops structure to the device rather than the
default vfio-pci-core wrapper ops structure?

vf_dev is ONLY set in hisi_acc_vfio_pci_migrn_init_dev(), which is
called through the migration ops structure.  If the PF is not mapped to
the migration ops structure it CANNOT set vf_dev.

Your own patch below gates the mapping of the migration ops on
is_virtfn, so we know this field is correct for the PF.  Therefore
hisi_acc_get_pf_qm() already returns NULL for the PF.  Therefore the
vfio-pci-core wrapper ops are used for the PF.  Therefore vf_dev is
never set and most of the functions being modified in the name of
correcting falsely advertised migration support on the PF (which seems
untrue) are not reachable.

Alex

> >> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 48 +++++++++++++++----
> >>  1 file changed, 40 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> index 86362ec424a5..36490be7a61a 100644
> >> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> @@ -378,6 +378,11 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> >>  	if (migf->total_length < QM_MATCH_SIZE || hisi_acc_vdev->match_done)
> >>  		return 0;
> >>  
> >> +	if (!pf_qm || !pf_qm->io_base) {
> >> +		dev_err(dev, "failed to match check for PF QM migration\n");
> >> +		return -ENODEV;
> >> +	}
> >> +  
> > 
> > This function is called by hisi_acc_vf_resume_write(), which is part of
> > hisi_acc_vf_resume_fops, which is set as the file ops for the migration file created in hisi_acc_vf_pci_resume().  The call path is:
> > 
> > hisi_acc_vfio_pci_migrn_state_ops.migration_set_state (hisi_acc_vfio_pci_set_device_state())
> >   hisi_acc_vf_set_device_state()
> >     hisi_acc_vf_pci_resume()
> > 
> > hisi_acc_vfio_pci_migrn_state_ops is mig_ops.  It's never set for a PF!
> >   
> >>  	ret = vf_qm_version_check(vf_data, dev);
> >>  	if (ret) {
> >>  		dev_err(dev, "failed to match ACC_DEV_MAGIC\n");
> >> @@ -423,10 +428,15 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> >>  				struct acc_vf_data *vf_data)
> >>  {
> >>  	struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
> >> -	struct device *dev = &pf_qm->pdev->dev;
> >> +	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
> >>  	int vf_id = hisi_acc_vdev->vf_id;
> >>  	int ret;
> >>  
> >> +	if (!pf_qm || !pf_qm->io_base) {
> >> +		dev_err(dev, "failed to check PF QM available!\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >>  	vf_data->acc_magic = ACC_DEV_MAGIC_V2;
> >>  	vf_data->major_ver = ACC_DRV_MAJOR_VER;
> >>  	vf_data->minor_ver = ACC_DRV_MINOR_VER;  
> > 
> > This is called from opening the migration save file.  Prove how a PF
> > can get here.
> > 
> >   
> >> @@ -601,9 +611,14 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> >>  	struct hisi_qm *vfqm = &hisi_acc_vdev->vf_qm;
> >>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> >>  	struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
> >> -	struct device *dev = &qm->pdev->dev;
> >> +	struct device *dev = &vf_pdev->dev;
> >>  	u32 state;
> >>  
> >> +	if (!qm || !qm->io_base) {
> >> +		dev_err(dev, "failed to interrupt state check for PF QM!\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >>  	/* Check RAS state */
> >>  	state = qm_check_reg_state(qm, QM_ABNORMAL_INT_STATUS);
> >>  	if (state) {  
> > 
> > This is called from hisi_acc_vf_stop_device(), the same set_device path
> > as above.  A PF cannot get here!
> >   
> >> @@ -1154,9 +1169,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
> >>  {
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
> >>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> >> -	struct device *dev = &qm->pdev->dev;
> >> +	struct device *dev = &pdev->dev;
> >>  	u32 delay = 0;
> >>  
> >> +	if (!qm || !qm->io_base) {
> >> +		dev_err(dev, "PF QM not available for reset\n");
> >> +		return;
> >> +	}
> >> +
> >>  	/* All reset requests need to be queued for processing */
> >>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
> >>  		msleep(1);  
> > 
> > Finally, something that matches the fix this patch claims, a function
> > reachable by the PF!
> > 
> > Is this actually the issue you're trying to fix, not a migration
> > induced fault, migration isn't reachable by a PF, but an error handling
> > bug?
> >   
> >> @@ -1174,8 +1194,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
> >>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> >>  
> >> -	if (hisi_acc_vdev->set_reset_flag)
> >> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
> >> +	if (hisi_acc_vdev->set_reset_flag) {
> >> +		if (qm && qm->io_base)
> >> +			clear_bit(QM_RESETTING, &qm->misc_ctl);
> >> +		else
> >> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
> >> +	}
> >>  
> >>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
> >>  		return;  
> > 
> > Another, but notice you've already accounted for the non-migration case
> > here.  Can they be combined?
> >   
> >> @@ -1193,6 +1217,11 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> >>  	struct pci_dev *vf_dev = vdev->pdev;
> >>  	u32 val;
> >>  
> >> +	if (!pf_qm || !pf_qm->io_base) {
> >> +		dev_err(&vf_dev->dev, "PF QM not available for init\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >>  	val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
> >>  	if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
> >>  		hisi_acc_vdev->drv_mode = HW_ACC_MIG_PF_CTRL;  
> > 
> > Unreachable by PF.
> >   
> >> @@ -1565,6 +1594,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
> >>  	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
> >>  	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
> >>  
> >> +	if (!pf_qm) {
> >> +		dev_err(&pdev->dev, "PF driver not loaded, cannot enable migration\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >>  	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
> >>  	hisi_acc_vdev->pf_qm = pf_qm;
> >>  	hisi_acc_vdev->vf_dev = pdev;  
> > 
> > Unreachable by PF.
> >   
> >> @@ -1670,13 +1704,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev;
> >>  	const struct vfio_device_ops *ops = &hisi_acc_vfio_pci_ops;
> >>  	struct hisi_qm *pf_qm;
> >> -	int vf_id;
> >>  	int ret;
> >>  
> >>  	pf_qm = hisi_acc_get_pf_qm(pdev);
> >>  	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
> >> -		vf_id = pci_iov_vf_id(pdev);
> >> -		if (vf_id >= 0)
> >> +		if (pdev->is_virtfn)
> >>  			ops = &hisi_acc_vfio_pci_migrn_ops;
> >>  		else
> >>  			pci_warn(pdev, "migration support failed, continue with generic interface\n");  
> > 
> > Redundant to the test in hisi_acc_get_pf_pm() which would have returned
> > NULL, so we can't even get here.
> > 
> > Please do better.  Thanks,
> > 
> > Alex
> > .
> >   

