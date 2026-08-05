Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710001B3925;
	Wed,  5 Aug 2026 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896387; cv=none; b=TmX/tGFuU1TgVi4QJweZLL2IUBmPpCPwGiYCDrHE7cbm2jczvyFjfRwaKvQcv8tZGoxFChq2aQlW49l6VDgZwKMfMJFe3OP5MiFXAy0TfWKgB6uO5riqeOwp2HxTxR5cL5QB2hAEeCyRcSDKOOm2qJcYD9i9WDWKP/9m67obfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896387; c=relaxed/simple;
	bh=4dXq908M3GQGImzf0rsQntjUjdm+blYz7prHaKkyC+4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UIChPIM6NCVLjjft+jRBPfWTshXX6W9NDeau7GHr/X+Tg71RBurhPkGsXGRa8blNxa+/Ys+aF4w9IofVuHd9qb7iWp1mgasNmXX8CbBZH9E9O7HuibEE07mmt4kN2buFEex/UQTqQsZ39uYMGV+qadaCDKE92F1Tza5wNCODVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jaxmMh0s; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jaxmMh0s"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OZ8QOqsCWTkfIgYT+Zson2kkujl0gOR9TX2BEPrSJTw=;
	b=jaxmMh0sDmbqwFR7oor7uJErCATMnHEgzvdtaQOtjyPa1xzDHjbO8Pw52oPSkGkIqTmDqFsIg
	2Ltuya3s8wuM1ZR7Bj4jmR9xaPXrtdNBma6peBNjoi4Gea6KGvTdSq2x4lkI2OMU1bIIXBSbPpu
	EhFmJmwj4XaUlt4e8keaVlI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hFDQ54HZGzmV7C;
	Wed,  5 Aug 2026 10:10:05 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id EFBCD4056C;
	Wed,  5 Aug 2026 10:19:36 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 10:19:36 +0800
Subject: Re: [PATCH 1/2] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
To: Alex Williamson <alex@shazbot.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
 <20260803021857.2370179-2-liulongfang@huawei.com>
 <20260804132805.68023c24@shazbot.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <07d8a508-980b-0974-c793-b355be0a624f@huawei.com>
Date: Wed, 5 Aug 2026 10:19:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260804132805.68023c24@shazbot.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500015.china.huawei.com (7.185.36.143)

On 2026/8/5 3:28, Alex Williamson wrote:
> On Mon, 3 Aug 2026 10:18:56 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>>     In the previous implementation of live migration support for
>> Hisilicon accelerator devices, there was insufficient consideration
>> for the fact that PFs cannot support virtualization live migration.
>> If a user unbinds the PF device driver from the host and directly
>> passes it through to a VM, then attempts a live migration operation,
>> it will trigger a calltrace exception.
>>
>>     To address this, we conducted a detailed analysis of potential
>> failure points. We added checks for all operations that depend on
>> PF driver commands and incorporated relevant conditional judgments
>> to prevent system calltrace exceptions when users attempt live
>> migration after passing PFs through to VMs.
> 
> I don't understand your core premise here.  hisi_acc_vfio_pci_probe()
> sets the default ops to hisi_acc_vfio_pci_ops.  This ops structure uses
> vfio-pci-core callbacks for everything except .open_device, for which it
> uses hisi_acc_vfio_pci_open_device().  This function has exactly one
> migration related branch, which is entered only when core_vdev->mig_ops
> is set, but mig_ops is only set in the .init callback of the ops
> structure supporting migration.
> 
> In order to get the migration ops structure, hisi_acc_get_pf_qm() must
> return a pf_qm, the version of that object must be at least QM_HW_V3,
> and the vf_id must be valid.  hisi_acc_get_pf_qm()'s very first action
> is:
> 
>         if (!pdev->is_virtfn)
>                 return NULL;
> 
> Therefore, how is a PF ever getting associated to the migration ops
> structure?
>

This Hisilicon live migration driver actually utilizes two hardware-related
configuration functions. The first is the PF control function, obtained directly
through hisi_acc_get_pf_qm, which handles mailbox command operations, device health
status checks, device reset verification, device stop commands, and other device
control processes. The second is the VF configuration function, which is passed
through via VFIO direct assignment and serves as the main entity for device live
migration, responsible for current service device data migration and recovery operations.

The aforementioned issue occurs when users incorrectly pass the PF directly to this
driver through driver_override. In this scenario, the vf_dev in the driver structure
erroneously points to this PF. When the PF attempts to migrate itself, it will directly
cause exceptions. Therefore, it's necessary to add pdev checks here.

Thanks.
Longfang.

>> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 48 +++++++++++++++----
>>  1 file changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 86362ec424a5..36490be7a61a 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -378,6 +378,11 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>>  	if (migf->total_length < QM_MATCH_SIZE || hisi_acc_vdev->match_done)
>>  		return 0;
>>  
>> +	if (!pf_qm || !pf_qm->io_base) {
>> +		dev_err(dev, "failed to match check for PF QM migration\n");
>> +		return -ENODEV;
>> +	}
>> +
> 
> This function is called by hisi_acc_vf_resume_write(), which is part of
> hisi_acc_vf_resume_fops, which is set as the file ops for the migration file created in hisi_acc_vf_pci_resume().  The call path is:
> 
> hisi_acc_vfio_pci_migrn_state_ops.migration_set_state (hisi_acc_vfio_pci_set_device_state())
>   hisi_acc_vf_set_device_state()
>     hisi_acc_vf_pci_resume()
> 
> hisi_acc_vfio_pci_migrn_state_ops is mig_ops.  It's never set for a PF!
> 
>>  	ret = vf_qm_version_check(vf_data, dev);
>>  	if (ret) {
>>  		dev_err(dev, "failed to match ACC_DEV_MAGIC\n");
>> @@ -423,10 +428,15 @@ static int vf_qm_get_match_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>>  				struct acc_vf_data *vf_data)
>>  {
>>  	struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
>> -	struct device *dev = &pf_qm->pdev->dev;
>> +	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
>>  	int vf_id = hisi_acc_vdev->vf_id;
>>  	int ret;
>>  
>> +	if (!pf_qm || !pf_qm->io_base) {
>> +		dev_err(dev, "failed to check PF QM available!\n");
>> +		return -ENODEV;
>> +	}
>> +
>>  	vf_data->acc_magic = ACC_DEV_MAGIC_V2;
>>  	vf_data->major_ver = ACC_DRV_MAJOR_VER;
>>  	vf_data->minor_ver = ACC_DRV_MINOR_VER;
> 
> This is called from opening the migration save file.  Prove how a PF
> can get here.
> 
> 
>> @@ -601,9 +611,14 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>  	struct hisi_qm *vfqm = &hisi_acc_vdev->vf_qm;
>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>  	struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
>> -	struct device *dev = &qm->pdev->dev;
>> +	struct device *dev = &vf_pdev->dev;
>>  	u32 state;
>>  
>> +	if (!qm || !qm->io_base) {
>> +		dev_err(dev, "failed to interrupt state check for PF QM!\n");
>> +		return -ENODEV;
>> +	}
>> +
>>  	/* Check RAS state */
>>  	state = qm_check_reg_state(qm, QM_ABNORMAL_INT_STATUS);
>>  	if (state) {
> 
> This is called from hisi_acc_vf_stop_device(), the same set_device path
> as above.  A PF cannot get here!
> 
>> @@ -1154,9 +1169,14 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
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
> 
> Finally, something that matches the fix this patch claims, a function
> reachable by the PF!
> 
> Is this actually the issue you're trying to fix, not a migration
> induced fault, migration isn't reachable by a PF, but an error handling
> bug?
> 
>> @@ -1174,8 +1194,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
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
>>  
>>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>>  		return;
> 
> Another, but notice you've already accounted for the non-migration case
> here.  Can they be combined?
> 
>> @@ -1193,6 +1217,11 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>  	struct pci_dev *vf_dev = vdev->pdev;
>>  	u32 val;
>>  
>> +	if (!pf_qm || !pf_qm->io_base) {
>> +		dev_err(&vf_dev->dev, "PF QM not available for init\n");
>> +		return -ENODEV;
>> +	}
>> +
>>  	val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
>>  	if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
>>  		hisi_acc_vdev->drv_mode = HW_ACC_MIG_PF_CTRL;
> 
> Unreachable by PF.
> 
>> @@ -1565,6 +1594,11 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>>  	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
>>  	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
>>  
>> +	if (!pf_qm) {
>> +		dev_err(&pdev->dev, "PF driver not loaded, cannot enable migration\n");
>> +		return -ENODEV;
>> +	}
>> +
>>  	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
>>  	hisi_acc_vdev->pf_qm = pf_qm;
>>  	hisi_acc_vdev->vf_dev = pdev;
> 
> Unreachable by PF.
> 
>> @@ -1670,13 +1704,11 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
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
> Redundant to the test in hisi_acc_get_pf_pm() which would have returned
> NULL, so we can't even get here.
> 
> Please do better.  Thanks,
> 
> Alex
> .
> 
