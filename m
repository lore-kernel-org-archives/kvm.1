Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317F434986;
	Thu, 17 Sep 2026 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625619; cv=none; b=dW1yad8xUpu31ESr+ouyJz9KTDCgcxl0wEbWyaP5KtkEIVWa/f9Zt4Dm0KngvFB18Jck7p6viuhpRG++knMS6Zl2bkn7CvlKx+i7vTP+tLrVy1cThS8o/O7OzD/2TtA6fsfi+81sL0OC/MhDVgUhSkrPsFa1GyDSGVc0tm7X/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625619; c=relaxed/simple;
	bh=/JvPCVYcXl7p/iq6mxm1B4BFVT3iK/+5CVJa/PpR6nc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TDBSc4xXxPrrcQz6EyLXnnCLGKLVswZgJQEAgTxVYOoWOId5WmbUZUvCjviRF7mrHNBYbPJ+2Bk2Xe5M5J4aiZGckAkl8ST5HTZR9vZJ07A1wHworTpm46XHx2kM/xHmHT2//uTrbIAyw6nLQjVPIDKR/noQeh9nPPAGDwfEF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GtXMfsE9; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GtXMfsE9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0roxkxbhkWM2LjDVDTpVOsVb4jTSJj0aVZM5Y12oSp8=;
	b=GtXMfsE9XtuFsh6HgogilZa1nD1olovhBwQ3AcQPyjUOf3r003JgqpMwnSsOoj/Z2AAaPDZGR
	G/SawffEhoBAMNLt5h1PLjjQAppLCF6ahakBTOXvgbbn4hUJglT/8WJ49/IcxChTuRqfarg9yyg
	GrbsGfvZKZrnOh9gRrnGmwI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hllXC6wt9zcb3J;
	Thu, 17 Sep 2026 14:02:19 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id EFEB24057A;
	Thu, 17 Sep 2026 14:13:32 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 17 Sep 2026 14:13:32 +0800
Subject: Re: [PATCH v3 1/3] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
To: Alex Williamson <alex@shazbot.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-2-liulongfang@huawei.com>
 <20260911113724.00d3f79a@shazbot.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <a6c00ec0-e7f8-35db-6856-ae35cd3abfc1@huawei.com>
Date: Thu, 17 Sep 2026 14:13:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260911113724.00d3f79a@shazbot.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/9/12 1:37, Alex Williamson wrote:
> On Mon, 31 Aug 2026 17:09:49 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> When a PF device is bound to the live migration driver in passthrough mode,
>> it cannot support live migration functionality, and key pointers will
>> remain uninitialized. Although most migration functions within the driver
>> are unreachable, low-level error handling callbacks may be triggered
>> directly, causing a crash due to null pointer dereference.
>> The fix involves adding validity checks at three entry points: device
>> probe, error handling, and migration initialization. If the pointer is
>> invalid, the operation is exited or rejected directly to avoid crashes,
>> while redundant internal checks are removed.
>>
>> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 24 ++++++++++++++-----
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 86362ec424a5..e95d0ab0f11a 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
>>  {
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>> -	struct device *dev = &qm->pdev->dev;
>> +	struct device *dev = &pdev->dev;
>>  	u32 delay = 0;
>>  
>> +	if (!qm || !qm->io_base) {
>> +		dev_err(dev, "PF QM not available for reset\n");
>> +		return;
>> +	}
>> +
>>  	/* All reset requests need to be queued for processing */
>>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>>  		msleep(1);
>> @@ -1174,8 +1179,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>  
>> -	if (hisi_acc_vdev->set_reset_flag)
>> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
>> +	if (hisi_acc_vdev->set_reset_flag) {
>> +		if (qm && qm->io_base)
>> +			clear_bit(QM_RESETTING, &qm->misc_ctl);
>> +		else
>> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
>> +	}
> 
> set_reset_flag is only set by reset_prepare, which per the previous
> chunk can only occur if qm && qm->io_base, so this chunk is redundant.
> Why not just promote the mig_ops tests in both?
> 
>>  
>>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>>  		return;
>> @@ -1565,6 +1574,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>>  	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
>>  	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
>>  
>> +	if (!pf_qm) {
>> +		dev_err(&pdev->dev, "PF driver not loaded, cannot enable migration\n");
>> +		return -ENODEV;
>> +	}
> 
> This function is only reached via hisi_acc_vfio_pci_migrn_ops, which is
> already validated in probe to have a pf_qm with version >= QM_HW_V3.
> 
>> +
>>  	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
>>  	hisi_acc_vdev->pf_qm = pf_qm;
>>  	hisi_acc_vdev->vf_dev = pdev;
>> @@ -1670,13 +1684,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev;
>>  	const struct vfio_device_ops *ops = &hisi_acc_vfio_pci_ops;
>>  	struct hisi_qm *pf_qm;
>> -	int vf_id;
>>  	int ret;
>>  
>>  	pf_qm = hisi_acc_get_pf_qm(pdev);
>>  	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
>> -		vf_id = pci_iov_vf_id(pdev);
>> -		if (vf_id >= 0)
>> +		if (pdev->is_virtfn)
>>  			ops = &hisi_acc_vfio_pci_migrn_ops;
>>  		else
>>  			pci_warn(pdev, "migration support failed, continue with generic interface\n");
> 
> This is not reachable as a VF:
> 
> static struct hisi_qm *hisi_acc_get_pf_qm(struct pci_dev *pdev)
> {
>         struct hisi_qm  *pf_qm;
>         struct pci_driver *pf_driver;
> 
>         if (!pdev->is_virtfn)
>                 return NULL;
> 
> 
> pf_qm is NULL, the branch is never taken for a PF.  Also:
> 
> int pci_iov_vf_id(struct pci_dev *dev)
> {
>         struct pci_dev *pf;
> 
>         if (!dev->is_virtfn)
>                 return -EINVAL;
> 
> So even the redundant test is already here.  What are you trying to
> accomplish in this chunk?  Thanks,
>

Thank you for the review. Regarding the first two checks in `aer_reset_done` and `migrn_init_dev`,
you are correct that they are redundant; we will remove them in the next revision.

However, the PF passthrough scenario still crashes. The calltrace we actually tested occurs on
the following path:


hisi_acc_vfio_pci_open_device
  ¡ú vfio_pci_core_enable
    ¡ú pci_try_reset_function
      ¡ú hisi_acc_vf_pci_reset_prepare   ¡û NULL pointer dereference


`reset_prepare` is a PCI error handler callback invoked by `pci_try_reset_function` inside
`vfio_pci_core_enable`, which happens before the `mig_ops` check in `open_device`.
At this point, the PF's `pf_qm` is NULL, and `reset_prepare` dereferences `&qm->pdev->dev`,
causing an oops:


Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
pc : hisi_acc_vf_pci_reset_prepare+0x34/0xc0
Call trace:
 hisi_acc_vf_pci_reset_prepare
 pci_dev_save_and_disable
 pci_try_reset_function
 vfio_pci_core_enable
 hisi_acc_vfio_pci_open_device
 vfio_df_open


This shows that the `vf_id`-based check in `probe` does not actually prevent the PF
from reaching `reset_prepare`;
the PF still triggers the calltrace through this path. The fix here will follow your
suggestion: elevate the `mig_ops` check at the entry of `reset_prepare`, and also
move the existing `mig_ops` check in `aer_reset_done` ahead of the `set_reset_flag`
handling.
The `is_virtfn` check in `probe` will be retained to maintain consistent semantics with
other vendor drivers.

Thanks.
Longfang.


> Alex
> .
> 
