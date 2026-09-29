Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2E4E36D0;
	Tue, 29 Sep 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718719; cv=none; b=TMXR2UgEIHQiCQ/j9yGAySvaqCXVR44ky8cBEQPvgjwLIi72zKDMhojtaifywPHTVI1Hsi51g3lsXQmoXfGKROBxa2Kyj1Sy6axilLslJhESrF/8C/1AX7b4g6Q2G8rrajW9FepO9EFttyXYiZ6ucYaPEbWOgT3r5xB7nRRchug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718719; c=relaxed/simple;
	bh=I9pY1IoWznAyc/oWMmr2UeDl/gpu16QXh6Bxu/D/w5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dbliklnrl/T8opW0Jk+i0f73FPndJm6ISJ0vxRJa4NXKpkGdeclYDZc3NDikF/U48GQbAfA3/YChmcCrRdLwwkehN4hqeXlCUpRrPwJN7zxWlLwyZCxwIASIrdXRA+SwlmXNS0Uicyzr2t+9Pugo11oV1R0AjHe4i2LbYn7NT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=6VV/ghU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwFyEqsH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="6VV/ghU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwFyEqsH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BA02EC00CC;
	Tue, 29 Sep 2026 17:51:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 17:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790718705;
	 x=1790805105; bh=ZbtwK0l5qQ5eG6SRqdfpyFCGFgCY6yDjNXmfj8ALrUo=; b=
	6VV/ghU+MSKOPD8Wxf9q99B7QNRZqNkGgXO58r0sMrjmvTK6GuAmqwSMzDTllP9W
	eZ9RbLE+h3aynoVlOgsLOw8OqslPIzOyXwf9X7V0fsJTxSedS4RZai75K8c/MCQ2
	RkP7G7twiBYyktnF3Mojf4YK+lWua2A9aQmK3yJprh6X4vH4YqNpLrl6T7cOvSgD
	Ll9L3p2l5Apertn210Aa/rXOQgqkAQAEGu7wJGU/PKSuALHuxpjuqGQhRiUi71EV
	k+QGWVly3ztRR8xBdbzaDy5F+ybX6oUkL2JTgqBevqxtZBDGfgpiAOvMUrrpMWIr
	R/FJHCz1TuwN7FjhMhWDwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790718705; x=
	1790805105; bh=ZbtwK0l5qQ5eG6SRqdfpyFCGFgCY6yDjNXmfj8ALrUo=; b=H
	wFyEqsHjPVFDVthnbjhJQxiRRnVxYsIi0nzDeZ4MYPCce4eykYwi/J+FsjfGcxsO
	kW1JHX16EzakQW3yYk0lzSSuD2C6WAfVgTt77AAk3KwjBWInqeS2hHsi+zrbE3DJ
	Q4fcpaNgKqLDb+RQzpkoz7mMsTvBw3vL00XT3/ft5KCicNyZl8cmRVE8CczyoYcH
	XIzsLv0srNrnYcDbaHd9iSI+6Z6QmDsPu552czjJhOX7wFPzPbfTr97on32UG4oR
	MKagXwJq9rDRFpccYXNFUb/PQVrPbispTilAXmn0lzOr7/ZfGKRoEu7oA01olyAL
	o+qNnzrL5//OJW4UiT8ew==
X-ME-Sender: <xms:8DK8av5wgl7vPrZHgl_XTMqIr8Zq0UanPNug6XOIODbERMT_xgoIEw>
    <xme:8DK8auO_I8H2npxi74rbmqUeVHPHLVN3YDCiXPxbUmOCoHUz4ZJ1Qd7aUZDTxPaYn
    56tNoOO2fXdr-avTSlGzxbjlIS2vY6VWFQTD3Xe47uxfBtsaTMYrpU>
X-ME-Received: <xmr:8DK8att0WIDaKdGEFBFOUKypIJzeQq-KJtJXvRCOqIXeEu_mO5RFUOQNixjLAA>
X-ME-Proxy-Cause: dmFkZTEkUiyrlmXQHPIEmTXmdbFhTsEnigV/MXyW+ClpmXqaHNF4IRdhO3BcuOAm3SyODE
    59+j3gc4UlRDf/y3npZoGJLHLV6vnnF60rLVpP1WNsSGSqQ9VN0XoZfu9KoQaGFMcEsfY1
    8U6yA8bvhQDsRXzFlAwYUUTR+uqyKAujsyUY+Bpfd1uL50pnP3DFQyUHbVxKVG5QAvcmGJ
    fXJZ1jGq3hvoyk/KpWdJVXgX4pTPiywZdWOzQSt7LweLM/gep2/SDrSdR7i/Tlz21BatnC
    lS9RKQAPYD30VIknyU6WN4Ss/fWv76pnxr6+5N+HAYEhw3vmsH8WPru5dIUxFn+9TjBmmO
    POdaCjcXWm/vxO3CpPYkaX+Gyono5lR3UhjJqckSuAvDjSW+Dzd1+1KVh4ZKj3WeOY7zBe
    KAssMhLu6kH4UtgMwMai/M3lrB6ObWXoXjkUCTIut1xG6grwezPuF2jMDTdeE63x0HpoB8
    Hgu24k8YVw1cSH7hOTGJd3yhmuECWby8Z5f5fz8iVif+Dlxhd0NVotrnCYOSaUurSzMGTS
    rzmAHKn0J7Oiwu2VAufaXBVqo5rmm4qAXkZ+iD4HfnC7/Hd1A+2IzQ0GUIjliMn6P6YuMS
    7W+bRnzDFZ5DlnsVztmh7xeJesX90RBnG0ZACfTN/Vm2Q7L0+Tic1Rm1eWbw
X-ME-Proxy: <xmx:8DK8ahaiulE9l1icByxVs07jwhOQY2M26S3uMOvRSBujslz63XRxvg>
    <xmx:8DK8avw9Zwg5cXVxgEDFms15niJvlYbinX1YCFFAezik3sr836ArtQ>
    <xmx:8DK8apjQwwDryFfcRTNFFiDodO_Fs1-kjvsGVgQwAhONMaqtYPm73A>
    <xmx:8DK8ark8LEj5vXh7O7fm1v5pUhxXY18pyhOc7kvLAPvofKussIEJHA>
    <xmx:8TK8anNvQI3zHFXw-ryyYrXbLyLZF61Ax8HZGpbKFQiuq6xErCtQRZnO>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 17:51:44 -0400 (EDT)
Date: Tue, 29 Sep 2026 15:51:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v5 1/2] hisi_acc_vfio_pci: fix NULL dereference in
 reset_prepare on PF passthrough
Message-ID: <20260929155141.24887140@shazbot.org>
In-Reply-To: <20260923082551.1754351-2-liulongfang@huawei.com>
References: <20260923082551.1754351-1-liulongfang@huawei.com>
	<20260923082551.1754351-2-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 16:25:50 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> When a PF is bound to the driver via driver_override and passed
> through to a VM, its pf_qm stays NULL. The PCI error handler
> reset_prepare() runs during open_device through
> pci_try_reset_function(), before the mig_ops gate, and dereferences
> the NULL pf_qm for the timeout log, crashing the kernel.
> 
> Move the mig_ops check to the entry of reset_prepare() and
> aer_reset_done() so non-migration devices skip the QM_RESETTING
> coordination. Also clear set_reset_flag together with QM_RESETTING
> in aer_reset_done(); the flag was never cleared before, so a later
> timed-out reset could release a foreign lock.
> 
> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a5..6a09252258b9 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1157,6 +1157,9 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)

Rolling back to one more line of context in this function:

	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;

As per the commit log, we're trying to fix a problem where pf_qm is
NULL and dereferenced, such as in this next line:

>  	struct device *dev = &qm->pdev->dev;
>  	u32 delay = 0;
>  
> +	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
> +		return;
> +
>  	/* All reset requests need to be queued for processing */
>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>  		msleep(1);

Further context:

                if (++delay > QM_RESET_WAIT_TIMEOUT) {
                        dev_err(dev, "reset prepare failed\n");
                        return;
                }

So the added test exits before the inline dereference testing
QM_RESETTING, but you're relying on the compiler to move the resolution
of dev into the branch here.  The dereference bug is not fully
resolved, it's only masked by the compiler optimization.

The easy solution is to either move the struct device deref into the
branch where it's needed, or (better) just open code &qm->pdev->dev on
the dev_err() call.  Thanks,

Alex

> @@ -1174,12 +1177,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>  
> -	if (hisi_acc_vdev->set_reset_flag)
> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
> -
>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>  		return;
>  
> +	if (hisi_acc_vdev->set_reset_flag) {
> +		clear_bit(QM_RESETTING, &qm->misc_ctl);
> +		hisi_acc_vdev->set_reset_flag = false;
> +	}
> +
>  	mutex_lock(&hisi_acc_vdev->state_mutex);
>  	hisi_acc_vf_reset(hisi_acc_vdev);
>  	mutex_unlock(&hisi_acc_vdev->state_mutex);

