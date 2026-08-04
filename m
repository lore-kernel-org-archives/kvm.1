Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1894495534;
	Tue,  4 Aug 2026 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871694; cv=none; b=pNspNLU1G5Mdxil0lB9LabQjMQ0EiZ9pPs7K70JW+peumLleFZzQ8Go+Mp57W6GUwzdni3MLtGKv1sSlwBudAq7mR0AKRCD868c9FhI6tAPVSZrffvVVIrrfIo0nP3+Z0mXQWwFQGaXibAlvmYqnooUN7ZSKyeHx88m/usaXGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871694; c=relaxed/simple;
	bh=PNNXlruDmni9GPgiHLbPt1tI703q7GHMmYSFTZJb3Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMIV9SafB9ONaJEebNX55K2z1X6S77F6JNBZK4nWvygbz/lwcylYuctx+V3Id7vGL6NuzTu2JMS6OoRNJFiJq5OQwKuLBJJQDWQQrVy0aXnqJ+/U4V7zfFsopTqFG15w1A+8mrVqmy4/BaXBcyg+A7rQ5PHx1DgZHcZ8R4GOlNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=YuqGq5km; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcJLyLpl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="YuqGq5km";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcJLyLpl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D9F7EC012C;
	Tue,  4 Aug 2026 15:28:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 04 Aug 2026 15:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785871687;
	 x=1785958087; bh=Y5i62mozwF9gqWLVrS7PP3On4BNAGHB1IoHRhD8XNjk=; b=
	YuqGq5kmerjoFBdXt3+Z5hP1wHOifGVqxu/+sWcuGXuQ8JAuO/53KeiCIO/Quwdi
	m3Ue98He23dNbnOenu2Eg+mVtxmvv5PU6jx9X1649HsHmv077bdt4bhOZfKEEbJK
	OadMwm5NjUQmWDYrgAIw6uCHGXK1HlbqVwIT+gjPyFOtyl4XPqaR/sXv1E7O2Ehd
	cEESASmt/5bp2znNWKBH3Dt1aPJHQF4k8nXNHonPete9ZjY6E2o/z+bT3MCAY+Sp
	lR5EOD825GYiFxJLTvljI2FJlDODFVf51ZFilwICJrmDzARUcWmDhO9hW8k2/ruC
	WIQy+2phE9q2Wji0kOoOMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785871687; x=
	1785958087; bh=Y5i62mozwF9gqWLVrS7PP3On4BNAGHB1IoHRhD8XNjk=; b=C
	cJLyLplonozpZOdcY1QhRj4Bz1kohjchxVyCWh7P/5kdjPji0C9fLK6rsjvKRqvy
	3Tgx+9s40QqAhFuXpx6lQOdLOSOltFiWkJ1bPbuOqucGTQ1v8/1EgTunWeoOBHCr
	0Tt72BRi/Qv2WPPw2f4rcgXEWfuIIAnuqxeaDLMV2rG1aPV/3yWiyXIWUPNFRRgy
	t2AaZdoz4WgFlP/TGfyi9XpjZ0cZHsdgEBZOIxbDJRur5525Qc6XVdYpbJXSr3pJ
	2GOhWz88CUoAbv/1mov24oXdCvCFiQTMCk6xLP7FT9qmPMVX60fDuW0sdJJzCGs+
	uOHGE4Zr0tPI90L6foa3Q==
X-ME-Sender: <xms:Rz1yaoXUQJKuVsv9qaPsNiITLkz83JL3gUo88iIXIo2k4ObkecdklQ>
    <xme:Rz1yal5qE6mxM3yGazUww3u78DVaqFxgQ4yzbDAGH1L3mQN-u-zmq62WgTfOQSne7
    4RHPsMEgCr7ZF78zM8i7-f9JM06VQaYI0g1pnzM8ozhuweqFn3a>
X-ME-Received: <xmr:Rz1yajqN8me1sK3vuyxtpNkLLljXewcnpvm9ggGD89wLECiPpjEXrI3f38mcdQ>
X-ME-Proxy-Cause: dmFkZTE27WQxm8iGxfAFFUEwq2ylm6DYMQNwBiTxFGcsGILXGopQmV9WyF+yS5fm/iW2yV
    HdtKvOj80o8zg1HZ9YBPnD2eUSKJ9B3+eUVcPrtKrKEfvS19bA4szxIDC3aS65Y8B/TjJN
    8awqKchy9FHr0S4xgFm6J+JPSGg6QoQ2fx3VbIF/y8HiSEDs1IOMADDRK7EHcske27ki5n
    rW/m85FCL9d1A5/U0L8eB8XxXzEFTgQSW9Itu7z3x+hNTq93PI3D2wqbCG++GfOPZXC41+
    GrUiU9FaBN+xx04+XBSTRmcHcAh/I9H+CQbqH3rSPF9jfVFbBKOz/J5yVjFlir6UgE99Z6
    ngzQZAUz8fvXLCquhP8oxD6/WZk6ujKkFBf+ScULk2ciiUj+gW2QtjJr3enPByUmfCDxsv
    e70KZkHdWahCFUpX5iU0WJUxVDkVtXsls93lGxoj9mQ8Qc3j3iYfkEoMW59zR57Li3VlDm
    iSDuPqR/JF6zzZ7memzaoLIcwn2Fc95PEWR7IaKCMn5P8EAfMG5dQmvUQviPBJaxf7n6xD
    N9Lvr1zhAM19RjsDZFwY7++UtFUCIFBP5IuqB16g0ZGKv6qmHvbufHMRdm3kRNYEwnk/85
    r8506bSfpzbb81xCaydvi9cir/ItK7Xvpb5uJDUpVT3GoCtRQsK19tonfmXw
X-ME-Proxy: <xmx:Rz1yaolc0Dn5ZrOxraJm218gh6IMUAlIfZHAUdKormy6K9NK1y6G5w>
    <xmx:Rz1yavPyLvskF5SVbEhWhMX1uOU3rNgc1MxWy-zygajkuw7guqX5aQ>
    <xmx:Rz1yasPHFdJ-yqglDJkmRgcFwE0eHxtrfNIZZSFWkWsG0H5N9svBDA>
    <xmx:Rz1yaggcxzH7h8rKh_gW9JvNMrDHypuM4xh02bmTAZKOUapER-prtw>
    <xmx:Rz1yatYHy6P6hEXvJP7ibnthrVMNsHme0_KUujrUhm-TimjJUdFawJQo>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 15:28:06 -0400 (EDT)
Date: Tue, 4 Aug 2026 13:28:05 -0600
From: Alex Williamson <alex@shazbot.org>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 1/2] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
Message-ID: <20260804132805.68023c24@shazbot.org>
In-Reply-To: <20260803021857.2370179-2-liulongfang@huawei.com>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
	<20260803021857.2370179-2-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 10:18:56 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

>     In the previous implementation of live migration support for
> Hisilicon accelerator devices, there was insufficient consideration
> for the fact that PFs cannot support virtualization live migration.
> If a user unbinds the PF device driver from the host and directly
> passes it through to a VM, then attempts a live migration operation,
> it will trigger a calltrace exception.
> 
>     To address this, we conducted a detailed analysis of potential
> failure points. We added checks for all operations that depend on
> PF driver commands and incorporated relevant conditional judgments
> to prevent system calltrace exceptions when users attempt live
> migration after passing PFs through to VMs.

I don't understand your core premise here.  hisi_acc_vfio_pci_probe()
sets the default ops to hisi_acc_vfio_pci_ops.  This ops structure uses
vfio-pci-core callbacks for everything except .open_device, for which it
uses hisi_acc_vfio_pci_open_device().  This function has exactly one
migration related branch, which is entered only when core_vdev->mig_ops
is set, but mig_ops is only set in the .init callback of the ops
structure supporting migration.

In order to get the migration ops structure, hisi_acc_get_pf_qm() must
return a pf_qm, the version of that object must be at least QM_HW_V3,
and the vf_id must be valid.  hisi_acc_get_pf_qm()'s very first action
is:

        if (!pdev->is_virtfn)
                return NULL;

Therefore, how is a PF ever getting associated to the migration ops
structure?
 
> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 48 +++++++++++++++----
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 86362ec424a5..36490be7a61a 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -378,6 +378,11 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  	if (migf->total_length < QM_MATCH_SIZE || hisi_acc_vdev->match_done)
>  		return 0;
>  
> +	if (!pf_qm || !pf_qm->io_base) {
> +		dev_err(dev, "failed to match check for PF QM migration\n");
> +		return -ENODEV;
> +	}
> +

This function is called by hisi_acc_vf_resume_write(), which is part of
hisi_acc_vf_resume_fops, which is set as the file ops for the migration file created in hisi_acc_vf_pci_resume().  The call path is:

hisi_acc_vfio_pci_migrn_state_ops.migration_set_state (hisi_acc_vfio_pci_set_device_state())
  hisi_acc_vf_set_device_state()
    hisi_acc_vf_pci_resume()

hisi_acc_vfio_pci_migrn_state_ops is mig_ops.  It's never set for a PF!

>  	ret = vf_qm_version_check(vf_data, dev);
>  	if (ret) {
>  		dev_err(dev, "failed to match ACC_DEV_MAGIC\n");
> @@ -423,10 +428,15 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  				struct acc_vf_data *vf_data)
>  {
>  	struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
> -	struct device *dev = &pf_qm->pdev->dev;
> +	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
>  	int vf_id = hisi_acc_vdev->vf_id;
>  	int ret;
>  
> +	if (!pf_qm || !pf_qm->io_base) {
> +		dev_err(dev, "failed to check PF QM available!\n");
> +		return -ENODEV;
> +	}
> +
>  	vf_data->acc_magic = ACC_DEV_MAGIC_V2;
>  	vf_data->major_ver = ACC_DRV_MAJOR_VER;
>  	vf_data->minor_ver = ACC_DRV_MINOR_VER;

This is called from opening the migration save file.  Prove how a PF
can get here.


> @@ -601,9 +611,14 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	struct hisi_qm *vfqm = &hisi_acc_vdev->vf_qm;
>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>  	struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
> -	struct device *dev = &qm->pdev->dev;
> +	struct device *dev = &vf_pdev->dev;
>  	u32 state;
>  
> +	if (!qm || !qm->io_base) {
> +		dev_err(dev, "failed to interrupt state check for PF QM!\n");
> +		return -ENODEV;
> +	}
> +
>  	/* Check RAS state */
>  	state = qm_check_reg_state(qm, QM_ABNORMAL_INT_STATUS);
>  	if (state) {

This is called from hisi_acc_vf_stop_device(), the same set_device path
as above.  A PF cannot get here!

> @@ -1154,9 +1169,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
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

Finally, something that matches the fix this patch claims, a function
reachable by the PF!

Is this actually the issue you're trying to fix, not a migration
induced fault, migration isn't reachable by a PF, but an error handling
bug?

> @@ -1174,8 +1194,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
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
>  
>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>  		return;

Another, but notice you've already accounted for the non-migration case
here.  Can they be combined?

> @@ -1193,6 +1217,11 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	struct pci_dev *vf_dev = vdev->pdev;
>  	u32 val;
>  
> +	if (!pf_qm || !pf_qm->io_base) {
> +		dev_err(&vf_dev->dev, "PF QM not available for init\n");
> +		return -ENODEV;
> +	}
> +
>  	val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
>  	if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
>  		hisi_acc_vdev->drv_mode = HW_ACC_MIG_PF_CTRL;

Unreachable by PF.

> @@ -1565,6 +1594,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>  	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
>  	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
>  
> +	if (!pf_qm) {
> +		dev_err(&pdev->dev, "PF driver not loaded, cannot enable migration\n");
> +		return -ENODEV;
> +	}
> +
>  	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
>  	hisi_acc_vdev->pf_qm = pf_qm;
>  	hisi_acc_vdev->vf_dev = pdev;

Unreachable by PF.

> @@ -1670,13 +1704,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
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

Redundant to the test in hisi_acc_get_pf_pm() which would have returned
NULL, so we can't even get here.

Please do better.  Thanks,

Alex
