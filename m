Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83C36194D
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114449; cv=none; b=m+GkOV5ZWYJreDgbZ38TWAv2SrV2qQja+7SJkv5P9hyt1IicFjIKFKUV/JpK5lxkSLiXgFPCV72Hp6V/Qrh3xZ6dIyLiye63wt850wKdHRQSUZsQdsPAP7lGZ4u4bgQBrGjuvMf+mYgomCA7g550JP3b+CFqBXDS8NYH21taN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114449; c=relaxed/simple;
	bh=RXHBMYF+ArGpT60xtlOVBy0SV6IhtfS+HewDelhkD/U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FPFVb/8jCq3ThbpaB68Sy//bkvSdPzWxue0RrcVNwwN/eOvfp1IAP1VeNwVaTOIXKHdaPhmwSFxxFWwc1F4sIfazQp3B5wO9XfGScweTGG/p3/n8X84hEFy4AVGLafAG0RabdqZVhQQe7c98CaDlrKHK+GIXeBgTedDNSkFrxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RBhAguh3; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RBhAguh3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZyIgrw74LpGYaBfWJ0BOfkoqDNniv/AX8ccvXR25xrg=;
	b=RBhAguh32gPo6UqKesi61a8+GtS7FBqjSXn+vMNw4cJwFEkkqIfjUg0lATCKNOKVwnFHGv6NY
	0TbJUlPtknjVhXZXpYv3SOQWB+doaNA24vuXofg6360C7PKGShxYh6g/hM5hIctUrv6dMRNK9dj
	yKEGJFw+LuWXAcF9ZJZHOdM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hh6VN2lt4zRhTk;
	Fri, 11 Sep 2026 16:03:08 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 948D540579;
	Fri, 11 Sep 2026 16:14:01 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 11 Sep 2026 16:14:00 +0800
Subject: Re: [PATCH v3 1/3] hisi_acc_vfio_pci: fix live migration enable
 conditions for PF passthrough
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-2-liulongfang@huawei.com>
 <20260831093502.B58571F000E9@smtp.kernel.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <bf0be072-1e2d-7049-0df9-9474453c3d56@huawei.com>
Date: Fri, 11 Sep 2026 16:14:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260831093502.B58571F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/8/31 17:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `hisi_acc_vfio_pci_close_device()` accesses and frees migration file descriptors locklessly, racing with AER reset handling and leading to double `fput()` and Use-After-Free.
> --
> 
> commit 63de12e55959c8c98f32c474a3df763dbb67aa2c
> Author: Longfang Liu <liulongfang@huawei.com>
> Subject: hisi_acc_vfio_pci: fix live migration enable conditions for PF passthrough
> 
> This commit fixes live migration enable conditions for PF passthrough by
> adding validity checks for the PF QM pointer. It ensures operations exit
> or return an error directly when the pointer is invalid to avoid crashes.
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
>> +		else
>> +			dev_err(&pdev->dev, "PF QM not available for reset done\n");
>> +	}
>>  
>>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>>  		return;
> 
> [Severity: High]
> This is a pre-existing issue, but I have a question about how the AER reset
> interacts with device closing.
> 
> In hisi_acc_vf_pci_aer_reset_done(), the code eventually calls
> hisi_acc_vf_reset() while holding state_mutex:
> 
> 	mutex_lock(&hisi_acc_vdev->state_mutex);
> 	hisi_acc_vf_reset(hisi_acc_vdev);
> 	mutex_unlock(&hisi_acc_vdev->state_mutex);
> 
> Inside hisi_acc_vf_reset(), it calls hisi_acc_vf_disable_fds(), which reads
> and modifies hisi_acc_vdev->resuming_migf and hisi_acc_vdev->saving_migf.
> 
> However, in hisi_acc_vfio_pci_close_device(), hisi_acc_vf_disable_fds() is
> called without holding state_mutex:
> 
> static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
> {
> 	...
> 	hisi_acc_vf_disable_fds(hisi_acc_vdev);
> 	mutex_lock(&hisi_acc_vdev->open_mutex);
> 
> Can this lead to a race condition where a user closes the device concurrently
> with an AER reset?
> 
> If both threads call hisi_acc_vf_disable_fds() simultaneously, they might both
> see a non-NULL migration file descriptor:
> 
> static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> {
> 	if (hisi_acc_vdev->resuming_migf) {
> 		hisi_acc_debug_migf_copy(hisi_acc_vdev, hisi_acc_vdev->resuming_migf);
> 		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
> 		fput(hisi_acc_vdev->resuming_migf->filp);
> 		hisi_acc_vdev->resuming_migf = NULL;
> 	}
>         ...
> }
> 
> Would this result in a double fput() and a use-after-free on the migration
> file object since the read and modification are not protected by a common lock?
>

The subsequent patch fixes the issue introduced by adding the parameter check here.

Thanks.
Longfang.


