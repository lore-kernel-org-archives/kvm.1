Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152C375F7B;
	Sun, 20 Sep 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789914409; cv=none; b=jxJ9UUWyGP/XM+R8wSPu6IoNdMJCUwvhtPE58CdLhpRxNAjWxm2xA+9JShRjRZEiLo9sllKGjZCtCE+g1g3SZlakK3dcwoeREE+8+5ib3ukZNHKH4Clh2WqVVpufmNVor7YCR/Zyed2ekX7WAKQ15YNb2C+cAammi+SpuH9kqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789914409; c=relaxed/simple;
	bh=pLxv4XzGTP6A2hwd+UTRK/B7f1I7CeNJE0ZqLRUOou0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pollQNuC7N4noMQIQyHRIWbDKFbZHC10W3tlXWveZHuu6WoLvQGo+wg83Is7v2p91gVfG0K0hG1xCwbVTuDFEiUm640zw546sRnYixYYI/bhoEf/IK359d6N8wnj22JAebozJs8XOXxr63C7wL8Xjr4JD1lRIq1q04WzvGaOG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=D3PvOlU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7xmx2Ob; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="D3PvOlU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7xmx2Ob"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C7667EC00CC;
	Sun, 20 Sep 2026 10:26:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 20 Sep 2026 10:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789914404;
	 x=1790000804; bh=ZZ9WhfGrBQCdKD1w2c0K2pd4Pn9iwIa5Ab+S7w7mvac=; b=
	D3PvOlU00ItPjefagyMs/LskoD9o2h9hLqW3sgtFz/QxipZ3eBuxi5KizNTBBuxQ
	vP0TKOOap22KQnPPo8I/ZmDlH2+G8IjrYtLhMEbB0sVgLzo54yR9At8kKxyOUlBa
	NA8dbXENvWjrCwtp9aUQmjyQ6OW76HKk/FWD92LSqKJRTZSZ+cANDeTAj9O5oYBN
	Qw6PlkfXDb1uRQb0ila+4RvO/PfIvPcY82baxQp170os0CDplO4y8IpfzNNU8fv6
	YoPOYI65e4Yz2ez6zkN9Tso4/PnuUxF3pruIoeskzLH4ex5EDeDt2+hinpeFjPhN
	5xcOmf2z3QcIw7zZOBFK3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789914404; x=
	1790000804; bh=ZZ9WhfGrBQCdKD1w2c0K2pd4Pn9iwIa5Ab+S7w7mvac=; b=l
	7xmx2ObjlE54jD2v9nSy51HqZ2g14GJ9U3HBTLZOVa0aQcKXemN10VdmLjpZTddP
	cA6/Q5Q+Q1XYtUoNGoARWWvWB8CnP+k9U6oTNDff45WU+OZlkGTuniSxNQ8s64kP
	vT07bvhAsZyj4Igku/TqMK56yvUAgKQI8CWKN27DvP1lSiG1+O9/VUl3WGB+Cn/f
	2LgPDRsFMfwdi6FD58uiA2FmYe6XT789X8a+PJiG2fcZIeiYK3hQeyX13uM0I9gL
	pg5L97sGihQADu0aGLn+yh1vBLh3yTkLeaFch4cOxMftLEJf63jx833WYNawHu8V
	19X4g9m47cDrhEQKbresQ==
X-ME-Sender: <xms:JO2vatQPq5_PUMUR9OAZf-ln3aI9XedtW5XBvw0vRGXBX3-tyuuMLg>
    <xme:JO2vagGla_84GiBdqwQFA04egMJjtDkmKTJRF6fcjPU_wpR78VShslZTVYT0NnyMx
    48pG_U_B9j2H5ej-t9Yxp3_5HzjLR61rFn4h4DF4-elSGPOEU9xVA>
X-ME-Received: <xmr:JO2vaqH2ddiILJrntabZxMOu4cpca6AnjjNXhc_jDc0GS_ZbotQISQjPK5GGWg>
X-ME-Proxy-Cause: dmFkZTE1p7SKTICFtOQTXEJqa4o9j4y3CC92KP87/SfBi+SVgiV2Idp33XejySp20EJpj3
    iW7vP1Qlb8yIWEhuajflvwn/yxcdlTicL3yVRAgLSCj62ph1smor9e3WVRiwAXCxfniCPU
    TmH8NpH4eXHmEqC+v7Zkao1oF7E/kKULKhdR6TjLw+Ma33mJsYHC+d75XoGbnk2/4+ggVo
    /qBXg8088yvrVSS3AMCWqXpIqfjf15Z+yo8EeKvmT0Vis+Wp3S2PZkUZOq77KAMQVEV/VV
    FkI1/ieldFcuMGBAA7qynuKgXIMtGI+RKgD2Ocon0t2ygghfUJfnimhzuBt/39W2YXbrnP
    tVmpmU+bGgXs0JNIrJkAHxQtYyiEEq7dZSDrKc/0qc6cZoWKNcB3KChJmO40wInOzlLAvK
    pvKoPy/wZmWxmLpHv/pmdjm3Eidxyn4XIBzh2ascBc+mQLoktrGOuJiKU8eSPOH+pXFbfb
    9kACPmmJ5RdMyux45zEKSc7Jx8ZmgoHmnxgIxLuNkkiLyndpkbeQT/cwc11RUUhlyTHBFd
    3PrK4ndYEJEnNwQItiUn+eStlu5cWVifCTBnbynGllhsSlgmbZa/uk6HFOXwqna5ju53r8
    AiFzclMptVL3LfpsS4DWFu8z5J1jngXppRxDAOtnHQ0WXZ92shyX4BKALsFg
X-ME-Proxy: <xmx:JO2vamTHaq_-2RfhaTfgGjb3zLzrxTmxWvBOZgQES-oHkDN-AdPCeg>
    <xmx:JO2vajI00zUBKCNpcDcQW2Leyb7oaBdfWqvgNZQSEIc9I6e0y6hC7A>
    <xmx:JO2vapYpuCR6mbC8tOxOqXfnatNgCMaWigdDcQUmOD7oUIYmMnsYjg>
    <xmx:JO2vat9UUm3jcsbv0u8kEUabawhkqRJ4OgbZvRh2qVYTyl2FXHi-pw>
    <xmx:JO2vandBSjJn3EhxUlOarpiXTtMW2Vb1KjjiKsMXOvKflFHaJNyT8Hqp>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Sep 2026 10:26:43 -0400 (EDT)
Date: Sun, 20 Sep 2026 08:26:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v4 1/2] hisi_acc_vfio_pci: fix NULL dereference in
 reset_prepare on PF passthrough
Message-ID: <20260920082641.64d66616@shazbot.org>
In-Reply-To: <20260918084244.1485837-2-liulongfang@huawei.com>
References: <20260918084244.1485837-1-liulongfang@huawei.com>
	<20260918084244.1485837-2-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 16:42:43 +0800
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
> timed-out reset could release a foreign lock. Replace
> pci_iov_vf_id() >= 0 with pdev->is_virtfn in probe() for clearer
> on-VF gating.
> 
> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a5..8ff69c8d1ff7 100644
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
> +	if (!hisi_acc_vdev->core_device.vdev.mig_ops) {
> +		dev_err(dev, "device not support migration\n");
> +		return;
> +	}

Why is not supporting migration worthy of a dev_err()?!  Resets are a
normal operation.  Generating a log to nag the lack of migration
support on every reset is unacceptable.

> +
>  	/* All reset requests need to be queued for processing */
>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>  		msleep(1);
> @@ -1174,12 +1179,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
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
> @@ -1670,13 +1677,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
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

I still reject the redundant is_virtfn check here.  I don't find
support for the claim that it's a convention among variant drivers, nor
does it do anything here or to the next patch.  pf_qm is
deterministically NULL for pdev->is_virtfn.  Thanks,

Alex
