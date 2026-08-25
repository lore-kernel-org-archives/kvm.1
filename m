Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FF3D3D14
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643501; cv=none; b=SnbainWHbWhEC6VR1XkfHWF6BW5SAGb6zuJwV43BjQm/rIsZetJwDY3pjYhMP4MNVll5fmj9FoZa8BZoqZ2AK+fLA2+tkeqfCozX6IFIb1yQs2QiTcR1QnR9u7JJSTsg2MC0rOEAOWrS8YDRG5C2JlCh6HJO96Zju9Z8dEZcJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643501; c=relaxed/simple;
	bh=bVP40eq90ECJv96cWe7uOzircfK6Px2vNnwRuK9hyFE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BgPgD5JLb/e5FQf4JwKDfY2b7tiLRXUMxKLWQzdelXMvmVFSoZJBFa+6pGOWF9/zc9TMO/YuFguvcPpUnJN+r04CcM59dp4YCTMczuUETR9lKRxg87rkO7zrVs54acZRaT41qOFtH1IV2JwJgyCt6BFPypMDeCeMvKSAfk5lvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cBA4hRE1; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cBA4hRE1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EgaY3Knct4LZKRUc6oJxHCLQeLjGFOvfd65tQPQOrz0=;
	b=cBA4hRE1rrmDH+aO540jk0ugRby++QmEHkoEYKvhzLuYCHsgGe7MYEjbp1kixg3WWW/hn2t+O
	xYa6JTTJv/Qy76LAPjS/FWT+aZ4QiprVL04ZhYnMOyt2FOcJYlErST7+qEJZEMW+kfSzFIUqz+8
	nBmz8p6wpsIfraQfWc+xYPM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hTfWg1jm7z1T4Fq;
	Tue, 25 Aug 2026 15:27:59 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 0750E4056E;
	Tue, 25 Aug 2026 15:38:08 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Aug 2026 15:38:07 +0800
Subject: Re: [PATCH v2 1/2] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260824082851.1436129-1-liulongfang@huawei.com>
 <20260824082851.1436129-2-liulongfang@huawei.com>
 <20260824084207.C8A391F00A3A@smtp.kernel.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <e25014f1-31d5-4714-7b7c-1bb8f3c5b5c7@huawei.com>
Date: Tue, 25 Aug 2026 15:38:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260824084207.C8A391F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500015.china.huawei.com (7.185.36.143)

On 2026/8/24 16:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `set_reset_flag` lock tracker is never reset to false after a successful lock acquisition, allowing subsequent failed resets to erroneously clear the global `QM_RESETTING` lock.
> --
> 
> --- Patch [1]: [PATCH v2 1/2] hisi_acc_vfio_pci: fix live migration enable conditions for PF passthrough ---
> commit e8e63b8a17edd44cc9b69e8ca3472ee6c656873c
> Author: Longfang Liu <liulongfang@huawei.com>
> 
> hisi_acc_vfio_pci: fix live migration enable conditions for PF passthrough
> 
> This commit fixes a crash in PF passthrough mode by adding validity
> checks for uninitialized PF pointers during device probe, error
> handling, and migration initialization.
> 
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 86362ec424a50..e95d0ab0f11ab 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> [ ... ]
>> @@ -1174,8 +1179,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>  
>> -	if (hisi_acc_vdev->set_reset_flag)
>> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
>> +	if (hisi_acc_vdev->set_reset_flag) {
>> +		if (qm && qm->io_base)
>> +			clear_bit(QM_RESETTING, &qm->misc_ctl);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it possible that
> hisi_acc_vdev->set_reset_flag is never reset to false after a successful
> lock acquisition?
> 
> If a prior reset succeeds, hisi_acc_vdev->set_reset_flag is left as true.
> 
> If a subsequent reset attempt times out in hisi_acc_vf_pci_reset_prepare()
> because another agent already holds the QM_RESETTING lock:
> 
> hisi_acc_vf_pci_reset_prepare() {
>     ...
>     while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>         msleep(1);
>         if (++delay > QM_RESET_WAIT_TIMEOUT) {
>             dev_err(dev, "reset prepare failed\n");
>             return;
>         }
>     }
>     ...
> }
> 
Your analysis makes sense. After `reset_done`, if subsequent reset processing occurs,
`set_reset_flag` remains set to true. Therefore, the reset flag handling will be
executed regardless of whether `reset_prepare` succeeds or not,
which is unreasonable.

Thanks.
Longfang.

> The code returns early and leaves set_reset_flag as true.
> 
> When hisi_acc_vf_pci_aer_reset_done() is subsequently invoked by the PCI
> error recovery flow, it observes the stale true flag and unconditionally
> clears QM_RESETTING.
> 
> Does this prematurely clear the lock currently owned by the other agent?
> 
>> +		else
>> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
>> +	}
>>  
>>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>>  		return;
> 
