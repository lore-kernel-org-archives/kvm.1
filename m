Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F583B774F;
	Fri, 11 Sep 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148257; cv=none; b=hA8mtVdhMJyILFCoTnM3LAKzzSQSLNJbI2/1PLWoNJaFuZR7uTQ+ice47SIAHQQEbTPLxTaIUDH866VN3oM8Wjs6SZxFB4veT/5dNoRqsxo5q8mydf+gg5eXWHukH5EUvcPrC/U+4EzbnzgLLbGiWpKtKZEx5wDpV0fPMiitB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148257; c=relaxed/simple;
	bh=IfUf5bhdsp3i58h20osRlj0QOHgnCdIwkD+fXvDHsSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h17k0XsbmbVJr1rY05sK83Uh910BV1UVMoJDCp8P2WaxodV/0/TF+fyN+bQzmA+hW9cWpcqT5MeKJ+yefYvGKbE41GZRxNLSW2GlMV+lKyIWgoGC2AIP0ti1sC907Zfr9PfNcQCpkqWr0DEliHm5L8wH6LG+OtYMfj1Bi3I1edM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kLCh+rhg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUdFzEqu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kLCh+rhg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUdFzEqu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 289AB1400105;
	Fri, 11 Sep 2026 13:37:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 13:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789148254;
	 x=1789234654; bh=dn+whNK9KW4i24+5IVCOlGsZ9V7xXiYoCVoWBTRHEg0=; b=
	kLCh+rhg5Jwm7GI9jy3Hg+7neNEDAWEnCGLYFWi/mbrg3Cbq0I+EdvqIurWszZCE
	G4URZyHu5sdWX8zAAtmzMGecqZxlM4yLbD5tOd4JLGPkrfTqONzeUP103eEDebzz
	isUV3ZXWS7oWu0VxGlQvjqlRz7xqnDf/w8o6K0jkDo1edCP0h/MtbnXS2XHx/rPq
	LVJeW5i9AhKlLPB0w7WJRS5QxxXVAVERKp9XAsIF77vBL0bzvZVr+jcymSSfAxYv
	kWGL4UGxzdlgx8XbPQJ/PqAVN0uOPxWuKsOm0abe5QDnV37FstZpzDm+IJQTii5P
	K7QWzG8jp9xPfh/YW6RT7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789148254; x=
	1789234654; bh=dn+whNK9KW4i24+5IVCOlGsZ9V7xXiYoCVoWBTRHEg0=; b=H
	UdFzEqu4Rp73UIQuuUbbuJ2yLmNlPoLrg8sAfDl1A2kPTosohsRzwLRnxpdxTCHQ
	aE+LeL/0VDsPtkRlLMyrDJNCRdkDusDhJYukCbbsPq8zvOa3WGF1IxykxRe9Mbuk
	+W8lNpUEhCMmWA/3Zn7QKaWlA19XuqlsNbAUEkwpUvazTIwhKg06/cl7khF/sU3f
	oC6DGngvhZm6K1Mo4G1L2WNAlqA17hjHMwOaTKUuETg9cuXIEhEaE9CAAhF2+Dau
	o48MAoaI1LU0apJIlIVOf1WAS9T4fH10IVTci0YC/9omXZ34ZKXSLI+jiVWIeDbL
	ZFChb6BEgWVIif/CPdwTQ==
X-ME-Sender: <xms:XjykaqCERV7XNCs5gOr8DAs42i9uvYxEOxU1q2SWlrwJdCyRmn_vgA>
    <xme:Xjykat2nLoBGwiPFIknvL5dMXxDkl0nrJ-zbNZnm4gt--7rVKXr5-dB5W3cYVyen1
    VacA6vpG3eBVONrKX_gFp2iG4U5dDFUo_iTQjcXu7atrRlC_QrdeA>
X-ME-Received: <xmr:Xjykak3W30qAqeJ7Bd5_4LQYH-O_vIfaZQGQ8CLQ1CuQS3hNixnmn0ne7d2DzA>
X-ME-Proxy-Cause: dmFkZTELuHWubJnO/bcf4GIqjr5C5hrBSy34IQGrjCXpQ41u01AFzYuVhs2L024veMtT0C
    srDYoAgF+BlWZc8PCxuwt11cQHZNF73Wj00inz7fgb8xPW5xkaEF8RdCfnNf3ab0fmzJMg
    C3PMs6E2obWspbzxrecHDABJMXKhj2m2LUbfBJLGKvAIMilK3SIEEld9CmK8NrHN7UmEot
    ZDJWS8bQa3+/CYg8WRv0V+ifvsiR7SODySMQ7EvyZ0JrB5yvK+i6KLkggdCFO+Mz2tp8u+
    YlMFidlUu+tKmNg2ZtEfHTreTEXQHa4EBtzEDuWkccElky+/dL+jlkx8u4q3GaxxltLfG9
    5PP2qk4duv6qdTx2qgiJXGfqLLV+7GY2vTUnd9pVffuyGqJyjkfnUSds6vSKMT1JuJ7ggb
    qN3zPuzg6wVuio7yLp2xf2s1yM3fxbKddPsotbWIpv707JdrRChvLCG7pOTr2WLxYwRefd
    FXpSl3O/mQ7s00lwIHMfDQPDO02gZ7b7Mn+/nEgyGuryHvfMWLIGe+aJFhM4RLxgMPpeYp
    e3DL7M+Q/v6P2yayoc/hhklYqf0Pjlwn+DAfwXidhgTucgrkKGUzPaKMMzJ58WTY7nObrM
    MPtzyFC6FWrEvT6KiF+mbdXQUM416umvW3LWMpieDWZKnlbxwtbMC5Q8f+pg
X-ME-Proxy: <xmx:XjykaqCLA-BFmmlbQsKBHslOiR7AjL66daix5L-hM01aX3cCOTpVjA>
    <xmx:Xjykar6pfBYZIiRoEpEJPTOO7MbE9-1pwDrYozcceRiaVHFoUn3qpw>
    <xmx:XjykajL-itHlkHujTYIvwx-EZ9qPw94A5ll9d3-rIETyDPldcVYwXQ>
    <xmx:XjykaksD67UPaOVyoiYPJcUBHdx6iJdLwSD0DL1kViBTA4Ipe3qPHw>
    <xmx:Xjykah1AWBbnpf7FImYxk8ve0LUc01dEC-aFPxptssvw-Y1itnp13fZg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 13:37:33 -0400 (EDT)
Date: Fri, 11 Sep 2026 11:37:24 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v3 1/3] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
Message-ID: <20260911113724.00d3f79a@shazbot.org>
In-Reply-To: <20260831090951.844569-2-liulongfang@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
	<20260831090951.844569-2-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 17:09:49 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> When a PF device is bound to the live migration driver in passthrough mode,
> it cannot support live migration functionality, and key pointers will
> remain uninitialized. Although most migration functions within the driver
> are unreachable, low-level error handling callbacks may be triggered
> directly, causing a crash due to null pointer dereference.
> The fix involves adding validity checks at three entry points: device
> probe, error handling, and migration initialization. If the pointer is
> invalid, the operation is exited or rejected directly to avoid crashes,
> while redundant internal checks are removed.
> 
> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 24 ++++++++++++++-----
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a5..e95d0ab0f11a 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> -	struct device *dev = &qm->pdev->dev;
> +	struct device *dev = &pdev->dev;
>  	u32 delay = 0;
>  
> +	if (!qm || !qm->io_base) {
> +		dev_err(dev, "PF QM not available for reset\n");
> +		return;
> +	}
> +
>  	/* All reset requests need to be queued for processing */
>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>  		msleep(1);
> @@ -1174,8 +1179,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>  
> -	if (hisi_acc_vdev->set_reset_flag)
> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
> +	if (hisi_acc_vdev->set_reset_flag) {
> +		if (qm && qm->io_base)
> +			clear_bit(QM_RESETTING, &qm->misc_ctl);
> +		else
> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
> +	}

set_reset_flag is only set by reset_prepare, which per the previous
chunk can only occur if qm && qm->io_base, so this chunk is redundant.
Why not just promote the mig_ops tests in both?

>  
>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>  		return;
> @@ -1565,6 +1574,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>  	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
>  	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
>  
> +	if (!pf_qm) {
> +		dev_err(&pdev->dev, "PF driver not loaded, cannot enable migration\n");
> +		return -ENODEV;
> +	}

This function is only reached via hisi_acc_vfio_pci_migrn_ops, which is
already validated in probe to have a pf_qm with version >= QM_HW_V3.

> +
>  	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
>  	hisi_acc_vdev->pf_qm = pf_qm;
>  	hisi_acc_vdev->vf_dev = pdev;
> @@ -1670,13 +1684,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev;
>  	const struct vfio_device_ops *ops = &hisi_acc_vfio_pci_ops;
>  	struct hisi_qm *pf_qm;
> -	int vf_id;
>  	int ret;
>  
>  	pf_qm = hisi_acc_get_pf_qm(pdev);
>  	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
> -		vf_id = pci_iov_vf_id(pdev);
> -		if (vf_id >= 0)
> +		if (pdev->is_virtfn)
>  			ops = &hisi_acc_vfio_pci_migrn_ops;
>  		else
>  			pci_warn(pdev, "migration support failed, continue with generic interface\n");

This is not reachable as a VF:

static struct hisi_qm *hisi_acc_get_pf_qm(struct pci_dev *pdev)
{
        struct hisi_qm  *pf_qm;
        struct pci_driver *pf_driver;

        if (!pdev->is_virtfn)
                return NULL;


pf_qm is NULL, the branch is never taken for a PF.  Also:

int pci_iov_vf_id(struct pci_dev *dev)
{
        struct pci_dev *pf;

        if (!dev->is_virtfn)
                return -EINVAL;

So even the redundant test is already here.  What are you trying to
accomplish in this chunk?  Thanks,

Alex
