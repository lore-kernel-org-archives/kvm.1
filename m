Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6353537F9
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114075; cv=none; b=Ldmd1pxeyfE3k7aYFKk272fpKYUBqRVsvhwhLQiqGABZ0WqA8FhoMrxnvlHX5WbXklJUe6hb37XC9dAN064HxD547snrALbuL77uXVSKewNoS+gYoa2i2AvbXngX4a2/p5WCMc++IOJNLDuN23OyZOu9Km69bCI6J+Ox5fWJfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114075; c=relaxed/simple;
	bh=jvyOy01vAkypBiKCfDxXI3IFg+Ekrz2bqtiAn88fR34=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M+gz33txVVFjwFXNrWTWDFCq8L0X9grVIaxqMJM/AMYWgg+6o43MeeLtI4sD9JQivYomSDjnhF9bqCk+nBNNA8Fpze28bl2PdR/EfD7dVrN9nZ5wTFCQR8Xp7TIDmvQ98q0OpmAkI1GS+BjTK+YPpnZgSNPzp6ndJ+7l/+cJIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=auWoUSgn; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="auWoUSgn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3OcWSb7rINc8kkkBwhicFl9BkZD+veV8lSiPLA9C21A=;
	b=auWoUSgnH170InbwPMGQ6sY+zY8s6+HquhzdFsXQbgJY9U9HQcJZSpMGgnvuh1VTflD3S/nRS
	x2htdvrAWILnaJwf4ma92G/QkgMTxRofPjLGBKtETuurQLLwJwUPRDosEGdqzTeY1cey0lD3oN+
	A5EoZ0jqFW2mvDtlf92wE8M=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hh6LG3Bc7zpT0s;
	Fri, 11 Sep 2026 15:56:06 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F77C4058E;
	Fri, 11 Sep 2026 16:07:43 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 11 Sep 2026 16:07:42 +0800
Subject: Re: [PATCH v3 2/3] hisi_acc_vfio_pci: clear set_reset_flag after
 reset completed
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-3-liulongfang@huawei.com>
 <20260831094603.CBC541F00A3E@smtp.kernel.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <1011aab0-1604-deb3-bba0-0e0ada949581@huawei.com>
Date: Fri, 11 Sep 2026 16:07:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260831094603.CBC541F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/8/31 17:46, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Incomplete fix: `set_reset_flag` is not cleared on the error path when `qm` or `qm->io_base` is NULL.
> --
> 
> commit 20e8953675b36be7d8bfc2a18cb44431bd40084a
> Author: Longfang Liu <liulongfang@huawei.com>
> 
> hisi_acc_vfio_pci: clear set_reset_flag after reset completed
> 
> This patch attempts to make every reset cycle self-contained by clearing
> set_reset_flag during aer_reset_done. It addresses an issue where a stale
> latch could prematurely release a lock owned by another agent during a
> reset timeout.
> 
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index e95d0ab0f11ab..4abed2e49986f 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -1180,10 +1180,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>  
>>  	if (hisi_acc_vdev->set_reset_flag) {
>> -		if (qm && qm->io_base)
>> +		if (qm && qm->io_base) {
>>  			clear_bit(QM_RESETTING, &qm->misc_ctl);
>> -		else
>> +			hisi_acc_vdev->set_reset_flag = false;
>> +		} else {
>>  			dev_err(&pdev->dev, "PF QM not available for reset done\n");
>> +		}
> 
> [Severity: High]
> Does this leave set_reset_flag persistently set if qm or qm->io_base
> evaluates to false?
> 
> If agent A sets set_reset_flag to true and encounters an unavailable PF QM
> during hisi_acc_vf_pci_aer_reset_done(), the flag will remain true.
> 
> Later, if agent B holds the QM_RESETTING lock and agent A attempts another
> reset that times out, could agent A's aer_reset_done() see the stale true
> flag and prematurely clear agent B's lock if the QM has since become
> available?
> 
> Should set_reset_flag be cleared unconditionally in this function, regardless
> of whether the PF QM is currently available?
>

The current handling is correct and has been verified through testing.
The flag value should not be unconditionally cleared.

Thanks
Longfang.

>>  	}
>>  
>>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
> 
