Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A12580F3;
	Wed, 23 Sep 2026 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145952; cv=none; b=OegT3oWQvnZFW0LaBM5xHDg+dYJe82VZfMmyObA/YglHFWaQFxnveHMnqo5dRlYRn058fpN5L6aghtf6ySd0yjmLXzBiSlTtYBcjAIYhZllAlGsO2wWAgk88y3vJ+9+keIMhFwMIG3R7M/1YHiTlTnNMw+wwAiTTh0VvH4Ztc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145952; c=relaxed/simple;
	bh=MLuL1g2afY6v8AIDThBP3sZOTU6cYHdmv52kPhLU+Yo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UGwK4rOkiWHUnOdF95cBaT9picMSdZxlMaOz1n9rtvM+//OVW0mVU3Z2ePvGcKrDr+mmGk1FrG+CnFYypOQxHxD/wqieGHxkbIlybE8G9WorjD6efS6Tnc1A0tLdsWj4NT3PrD1lwSkYAS1P55aKyJgFHy1kUN1llpTs4Zb5JXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NZ9Dwjjn; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NZ9Dwjjn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YhEYlQtke+vQduVm9Z6KEKMJC26Mh7lyGkZCjMz2Plw=;
	b=NZ9Dwjjn6QuFCf6eiSTTGGK88hLpBvw5wxl3s9wrodnYl/Hwm3J2GYkRvsuj7gM5uAZjpuo2E
	U6YC+xNraueOQ/QM9JjjraZ1bbA5t8MkG9Brcig34iIKgLleST/e6+ejVzd+Q9rkUnfSIUCAoEA
	0fXfaq7UMc9lVc4UwRUuImI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hqRyk6mRkz1cyPY;
	Wed, 23 Sep 2026 14:34:38 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 396A240572;
	Wed, 23 Sep 2026 14:45:41 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 23 Sep 2026 14:45:40 +0800
Subject: Re: [PATCH v4 1/2] hisi_acc_vfio_pci: fix NULL dereference in
 reset_prepare on PF passthrough
To: Alex Williamson <alex@shazbot.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260918084244.1485837-1-liulongfang@huawei.com>
 <20260918084244.1485837-2-liulongfang@huawei.com>
 <20260920082641.64d66616@shazbot.org>
 <f0a43a0f-b317-964f-207c-f96d1f0a6478@huawei.com>
 <20260922165928.5c062fc0@shazbot.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <9f9a061e-9309-fe6f-f3dc-968d92ad537c@huawei.com>
Date: Wed, 23 Sep 2026 14:45:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260922165928.5c062fc0@shazbot.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/9/23 6:59, Alex Williamson wrote:
> On Mon, 21 Sep 2026 16:15:12 +0800
> liulongfang <liulongfang@huawei.com> wrote:
> 
>> On 2026/9/20 22:26, Alex Williamson wrote:
>>> On Fri, 18 Sep 2026 16:42:43 +0800
>>> Longfang Liu <liulongfang@huawei.com> wrote:
>>>   
>>>> When a PF is bound to the driver via driver_override and passed
>>>> through to a VM, its pf_qm stays NULL. The PCI error handler
>>>> reset_prepare() runs during open_device through
>>>> pci_try_reset_function(), before the mig_ops gate, and dereferences
>>>> the NULL pf_qm for the timeout log, crashing the kernel.
>>>>
>>>> Move the mig_ops check to the entry of reset_prepare() and
>>>> aer_reset_done() so non-migration devices skip the QM_RESETTING
>>>> coordination. Also clear set_reset_flag together with QM_RESETTING
>>>> in aer_reset_done(); the flag was never cleared before, so a later
>>>> timed-out reset could release a foreign lock. Replace
>>>> pci_iov_vf_id() >= 0 with pdev->is_virtfn in probe() for clearer
>>>> on-VF gating.
>>>>
>>>> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
>>>> Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
>>>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>>>> ---
>>>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 19 ++++++++++++-------
>>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>>>> index 86362ec424a5..8ff69c8d1ff7 100644
>>>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>>>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>>>> @@ -1154,9 +1154,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
>>>>  {
>>>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>>>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>>> -	struct device *dev = &qm->pdev->dev;
>>>> +	struct device *dev = &pdev->dev;
>>>>  	u32 delay = 0;
>>>>  
>>>> +	if (!hisi_acc_vdev->core_device.vdev.mig_ops) {
>>>> +		dev_err(dev, "device not support migration\n");
>>>> +		return;
>>>> +	}  
>>>
>>> Why is not supporting migration worthy of a dev_err()?!  Resets are a
>>> normal operation.  Generating a log to nag the lack of migration
>>> support on every reset is unacceptable.  
>>
>> How about changing it to a dev_info() then? Since users will notice errors when initiating
>> a migration, an explicit log is necessary to pinpoint the cause and facilitate subsequent
>> troubleshooting.
> 
> No, reset is a normal operation, it has nothing to do with migration.
> Migration support is discoverable.  If you want something in the log,
> it should be there once, at probe time.
>

OK, I'll add a dev_info() log in the probe function.

>>>> +
>>>>  	/* All reset requests need to be queued for processing */
>>>>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>>>>  		msleep(1);
>>>> @@ -1174,12 +1179,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
>>>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>>>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>>>  
>>>> -	if (hisi_acc_vdev->set_reset_flag)
>>>> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
>>>> -
>>>>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>>>>  		return;
>>>>  
>>>> +	if (hisi_acc_vdev->set_reset_flag) {
>>>> +		clear_bit(QM_RESETTING, &qm->misc_ctl);
>>>> +		hisi_acc_vdev->set_reset_flag = false;
>>>> +	}
>>>> +
>>>>  	mutex_lock(&hisi_acc_vdev->state_mutex);
>>>>  	hisi_acc_vf_reset(hisi_acc_vdev);
>>>>  	mutex_unlock(&hisi_acc_vdev->state_mutex);
>>>> @@ -1670,13 +1677,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>>>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev;
>>>>  	const struct vfio_device_ops *ops = &hisi_acc_vfio_pci_ops;
>>>>  	struct hisi_qm *pf_qm;
>>>> -	int vf_id;
>>>>  	int ret;
>>>>  
>>>>  	pf_qm = hisi_acc_get_pf_qm(pdev);
>>>>  	if (pf_qm && pf_qm->ver >= QM_HW_V3) {
>>>> -		vf_id = pci_iov_vf_id(pdev);
>>>> -		if (vf_id >= 0)
>>>> +		if (pdev->is_virtfn)
>>>>  			ops = &hisi_acc_vfio_pci_migrn_ops;
>>>>  		else
>>>>  			pci_warn(pdev, "migration support failed, continue with generic interface\n");  
>>>
>>> I still reject the redundant is_virtfn check here.  I don't find
>>> support for the claim that it's a convention among variant drivers, nor
>>> does it do anything here or to the next patch.  pf_qm is
>>> deterministically NULL for pdev->is_virtfn.  Thanks,
>>>  
>>
>> Even if left unchanged here, a later patch will anyway replace this complex logic with an is_virtfn check
>> to handle the pci_resource_len inspection during probe.
> 
> Are you talking about patch 2/2 that leaves it like this:
> 
> 	pf_qm = hisi_acc_get_pf_qm(pdev);
> 	if (pf_qm && pf_qm->ver >= QM_HW_V3 && pdev->is_virtfn) {
>

OK,  I will remove pdev->is_virtfn in the next version.

Thanks.
Longfang.

> Where once again I quote the source of pf_qm:
> 
> static struct hisi_qm *hisi_acc_get_pf_qm(struct pci_dev *pdev)
> {
> 	struct hisi_qm  *pf_qm;
> 	struct pci_driver *pf_driver;
>                 
> 	if (!pdev->is_virtfn)
> 		return NULL;
> 
> Please stop wasting time on this.
> .
> 
