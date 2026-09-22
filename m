Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF52F6562;
	Tue, 22 Sep 2026 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118277; cv=none; b=omFP4HALrgWDnZtf7GitGw+kVk+veqMW1AZWGPEDpO0i+2l3LbNJWuFgMikOC+OHuhSHDUOJscB04reumv7whJy21EikdPwKKlWUdjQAgeBC7lRSHk/CqSOMd+Aa87y/4h/uxettsXYOlH5n0HbYE7+eBrKgsm3V3U1DhgljjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118277; c=relaxed/simple;
	bh=a36ndoT2KXdi47fIEqlJnPzaH5W24iqJ3yIzjEDCVRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7NFbdV9PpPNVm35opTvA1pAxjmXzBN5eOnPF7obBWjNtxAT/PyXDUjIvTGUoj6vTZKciTIYoI8Sft4DAtGw/y5qYsylXs1wPhkZxrvSTdO9DTiiLg1p20cgSK2QalAklgMt6wliChcfKXUDvIcyaQPBrA9NwWWPe1jUafeKn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=QF88XP9a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/Dy+Jha; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="QF88XP9a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/Dy+Jha"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00B73140010F;
	Tue, 22 Sep 2026 19:04:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Sep 2026 19:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790118273;
	 x=1790204673; bh=cBW+YkqIbYLpTLwVAWDZQjTjmZp4iLMIWYDVyIip3d0=; b=
	QF88XP9aLI7Vzx03rsAuhvraOT/wxi6JgxaOtqoO4ZCK9iefVhBafH0iKF4MfEG0
	WgY/lNaoO7ftDozNI+wfejpd9mlqQ1AqUXpMqzZ41sJ33nThX0LaX7HIzLmgR3+N
	0qYc/5OVZZC8MbYf7tPhM5PQm6H289+pP/yKctLXknAkYlMRgfEMrYQ/LDlJjLMr
	VAt1Zdq4dMcaO//CgmPVPmRSXSixFM8LLpqud6I2h2KQD/hMXlzyLCPG0cLD/aae
	C4K3bj7rUUXwcOwiGCjC3Iecvgxif+ULSUCyBAdyVq3SmQikGTbZ19lWw7Y55KCV
	follBxjn2vxfPRaQpwbOVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790118273; x=
	1790204673; bh=cBW+YkqIbYLpTLwVAWDZQjTjmZp4iLMIWYDVyIip3d0=; b=e
	/Dy+JhaqB/A+QK663+zlhbmxAY7U5iLhj8SL0/ZzbcJGtAIo6rVSAvrL2IGUfV9d
	Bj7wdTPCFPQgfbf/36L9eKNsIoGs/fd4mjZAqpSb+q8NfE/YG/B0R9tGg5/+ijDR
	97s2ykbE5b8lTj+14hVpNBz2HdbSxooqFAJri2GJ2SJ+aNWHobqlDyykKEpR+EBs
	6ChpOlA091WhA9/ZidkqaqrxpvZDWPok2Bdjb6qA11oE3a/7pYLTqYWrEoU9U4Se
	GvDAJSYuy99G0Vsv0WZwdae389ViSwa+uxD+Neh2Mt5gZDCntztcjU0oTWKqXzK/
	Crcwa+HGd2A7R4Rb9/h0g==
X-ME-Sender: <xms:gAmzanFmPwj-38xVDTRNydGPrNXK0UZvU9U5VvfROkm9mBB7zZdqeQ>
    <xme:gAmzatqTIcs7hx4UltWMH9mTy_H9AoGfv8sxqbzRExIQBB_iT7c7ruL4hBOvwLzu2
    off00qPtlVqr9Z5GZYA5lWhe6bwm_AdhKZo25ERZKLb7ZvkfPVkTNQ>
X-ME-Received: <xmr:gAmzagafj2ei-grSSPz9JNv5CQPSQSEej0RFmp9q9C9SiBRxBBJFxtIO5d2tRv4>
X-ME-Proxy-Cause: dmFkZTF0d/7UnB573iuzBQvCxGGSAalonrpJDLWCuwXKNO+W4h/hMcE5shzLltbAzl90aN
    yQ/SQwnM57UZHbhsb/qy0sGf+r3NTrrBvUAJKz7x8zBpOjdYUSc8i6Oh+KDMEpsS8Ffghd
    RcNjYm59Msk/PjcC4XRqrlv3ZtFV9t3RQnUgpbYZFSrmgcEz3W5ytMlMTwxeZSQ7fUf8v6
    NKoRLGEj2a7QP+qSfvoBMgXDkFx7CVMmicJb4r3dACxI+fT+0o1COWPj0/mrLD8ASstsmG
    RaukIVMSMkeCkryltw4Zeqng0HT5BiCmW9Z0+mbu1LMGY6mHkMo20XCbSzjqDREOQWY/l2
    eo1O7yNlaBfTDH/VjQFOWhFo+vm79T8C328TCn2QPemiyDY/X4zF9VSbeFzNHw2PWjY8CW
    Z9ZcVDFm1TNMGNOCuj+6TdXDnLxR321TXGkUWVBD3kct6W90rSPQVK/bcciXLYo8N0IPqq
    1YDaoQrxUK0XX1r94gRYy+nHtYmNYOQOj/s57W7UYGtP+YSHNq7Ro+0WQRJDAscbOWDRmO
    pzSnzOqul7eOYeIQitXhhRc5xn2cyteM8S4lWVQgRBt8fk7nrSWcfabJnwZCUIR9UfyLWv
    VRTp2KB91cvvz92Dikq7SYhyaESpIY+1godGXMbOfezx+eaI/jNE2zgUws6g
X-ME-Proxy: <xmx:gQmzamU4vn00jXRegs857cLMEwFHSg4IMzSxiHf97nHIuN88IfOonQ>
    <xmx:gQmzap83zRHkm87n7lp-WrQETAP91jmIHqoF7AgCsbsz9BW_14BTnQ>
    <xmx:gQmzav-MuxvndJdg9UE0eZ325dFrkBkzQDAT9EknInJ2k08T-PML2g>
    <xmx:gQmzapT-31eafk6fm3Qo6E6g2wEprGI4dFhc8FUkLysd659UvVbe-w>
    <xmx:gQmzamw_FLIKleOreDLvngNkEiXwE7KV3_wQQt_o8TGUspmY-enwEpbY>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 19:04:31 -0400 (EDT)
Date: Tue, 22 Sep 2026 16:59:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: liulongfang <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v4 1/2] hisi_acc_vfio_pci: fix NULL dereference in
 reset_prepare on PF passthrough
Message-ID: <20260922165928.5c062fc0@shazbot.org>
In-Reply-To: <f0a43a0f-b317-964f-207c-f96d1f0a6478@huawei.com>
References: <20260918084244.1485837-1-liulongfang@huawei.com>
	<20260918084244.1485837-2-liulongfang@huawei.com>
	<20260920082641.64d66616@shazbot.org>
	<f0a43a0f-b317-964f-207c-f96d1f0a6478@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 16:15:12 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2026/9/20 22:26, Alex Williamson wrote:
> > On Fri, 18 Sep 2026 16:42:43 +0800
> > Longfang Liu <liulongfang@huawei.com> wrote:
> >   
> >> When a PF is bound to the driver via driver_override and passed
> >> through to a VM, its pf_qm stays NULL. The PCI error handler
> >> reset_prepare() runs during open_device through
> >> pci_try_reset_function(), before the mig_ops gate, and dereferences
> >> the NULL pf_qm for the timeout log, crashing the kernel.
> >>
> >> Move the mig_ops check to the entry of reset_prepare() and
> >> aer_reset_done() so non-migration devices skip the QM_RESETTING
> >> coordination. Also clear set_reset_flag together with QM_RESETTING
> >> in aer_reset_done(); the flag was never cleared before, so a later
> >> timed-out reset could release a foreign lock. Replace
> >> pci_iov_vf_id() >= 0 with pdev->is_virtfn in probe() for clearer
> >> on-VF gating.
> >>
> >> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> >> Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 19 ++++++++++++-------
> >>  1 file changed, 12 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> index 86362ec424a5..8ff69c8d1ff7 100644
> >> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >> @@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
> >>  {
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
> >>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> >> -	struct device *dev = &qm->pdev->dev;
> >> +	struct device *dev = &pdev->dev;
> >>  	u32 delay = 0;
> >>  
> >> +	if (!hisi_acc_vdev->core_device.vdev.mig_ops) {
> >> +		dev_err(dev, "device not support migration\n");
> >> +		return;
> >> +	}  
> > 
> > Why is not supporting migration worthy of a dev_err()?!  Resets are a
> > normal operation.  Generating a log to nag the lack of migration
> > support on every reset is unacceptable.  
> 
> How about changing it to a dev_info() then? Since users will notice errors when initiating
> a migration, an explicit log is necessary to pinpoint the cause and facilitate subsequent
> troubleshooting.

No, reset is a normal operation, it has nothing to do with migration.
Migration support is discoverable.  If you want something in the log,
it should be there once, at probe time.

> >> +
> >>  	/* All reset requests need to be queued for processing */
> >>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
> >>  		msleep(1);
> >> @@ -1174,12 +1179,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
> >>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
> >>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> >>  
> >> -	if (hisi_acc_vdev->set_reset_flag)
> >> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
> >> -
> >>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
> >>  		return;
> >>  
> >> +	if (hisi_acc_vdev->set_reset_flag) {
> >> +		clear_bit(QM_RESETTING, &qm->misc_ctl);
> >> +		hisi_acc_vdev->set_reset_flag = false;
> >> +	}
> >> +
> >>  	mutex_lock(&hisi_acc_vdev->state_mutex);
> >>  	hisi_acc_vf_reset(hisi_acc_vdev);
> >>  	mutex_unlock(&hisi_acc_vdev->state_mutex);
> >> @@ -1670,13 +1677,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
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
> > I still reject the redundant is_virtfn check here.  I don't find
> > support for the claim that it's a convention among variant drivers, nor
> > does it do anything here or to the next patch.  pf_qm is
> > deterministically NULL for pdev->is_virtfn.  Thanks,
> >  
> 
> Even if left unchanged here, a later patch will anyway replace this complex logic with an is_virtfn check
> to handle the pci_resource_len inspection during probe.

Are you talking about patch 2/2 that leaves it like this:

	pf_qm = hisi_acc_get_pf_qm(pdev);
	if (pf_qm && pf_qm->ver >= QM_HW_V3 && pdev->is_virtfn) {

Where once again I quote the source of pf_qm:

static struct hisi_qm *hisi_acc_get_pf_qm(struct pci_dev *pdev)
{
	struct hisi_qm  *pf_qm;
	struct pci_driver *pf_driver;
                
	if (!pdev->is_virtfn)
		return NULL;

Please stop wasting time on this.
