Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DC3E5A1F;
	Tue, 13 Oct 2026 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875266; cv=none; b=sREQ0XqndGp8W1dv6o8lj8UhfxL+oaR81mSuFE/LbQDLxyuNlNLMOKeq0eS2hI0vKnB8TbKwUGmPNQIlF/YUgZe9Mb0hbd9ENID2FPhHbt57mBJ5pHV4ALN+QZuN/E5pPPn6aAUwIM5+JyocNnAkJ9hkOeRjcHBlK8kx1VzV16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875266; c=relaxed/simple;
	bh=Pn967/eqQwyBVN+GHu2bnfF9gKLN2JEgQ0YBf7kGflo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pL/TfMXMy5GFC6Ajt9V6pt/Wp3gLTaKXD4J2NDqsXebm4tPEeYopnuzyDn64cgj6aG6zzThPNMum5ghfwnLYrpVzNR5ZDNHciPbSWED/kvu6fn7Dby2fsEhtxJxxUjv60Dwx1xmj4QQDd2NjLLS8uUAr5N9AMf8Cyx+SrKZGX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=szFg0u42; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="szFg0u42"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mOgLhHEHoKunpl8nP1FWG7wla8LV0YV8TyE4cUWpqzw=;
	b=szFg0u42l10gwol62GhAro0lkbYK4Ail0bAtK1wX8+6ssFINYqeolZDNiIatT29ZNTGKOSj1r
	MGgoiG1RuJaRV/iWqP/c6/9goE8zjJFZ6tBGYAaSCNXrfqWl0tRN0coU8TVS9k61GcaGbeml9rw
	7xbi33YXVAKIGz2h+fN4NMQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4j3lT65KPCzpT0R;
	Tue, 13 Oct 2026 14:55:06 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B1314057F;
	Tue, 13 Oct 2026 15:07:40 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 13 Oct 2026 15:07:39 +0800
Subject: Re: [PATCH v5 1/2] hisi_acc_vfio_pci: fix NULL dereference in
 reset_prepare on PF passthrough
To: Alex Williamson <alex@shazbot.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260923082551.1754351-1-liulongfang@huawei.com>
 <20260923082551.1754351-2-liulongfang@huawei.com>
 <20260929155141.24887140@shazbot.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <81364dc6-71e0-c6e3-7012-0c1cb6a9d157@huawei.com>
Date: Tue, 13 Oct 2026 15:07:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260929155141.24887140@shazbot.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/9/30 5:51, Alex Williamson wrote:
> On Wed, 23 Sep 2026 16:25:50 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> When a PF is bound to the driver via driver_override and passed
>> through to a VM, its pf_qm stays NULL. The PCI error handler
>> reset_prepare() runs during open_device through
>> pci_try_reset_function(), before the mig_ops gate, and dereferences
>> the NULL pf_qm for the timeout log, crashing the kernel.
>>
>> Move the mig_ops check to the entry of reset_prepare() and
>> aer_reset_done() so non-migration devices skip the QM_RESETTING
>> coordination. Also clear set_reset_flag together with QM_RESETTING
>> in aer_reset_done(); the flag was never cleared before, so a later
>> timed-out reset could release a foreign lock.
>>
>> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
>> Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 86362ec424a5..6a09252258b9 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -1157,6 +1157,9 @@ static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
> 
> Rolling back to one more line of context in this function:
> 
> 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> 
> As per the commit log, we're trying to fix a problem where pf_qm is
> NULL and dereferenced, such as in this next line:
> 
>>  	struct device *dev = &qm->pdev->dev;
>>  	u32 delay = 0;
>>  
>> +	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>> +		return;
>> +
>>  	/* All reset requests need to be queued for processing */
>>  	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>>  		msleep(1);
> 
> Further context:
> 
>                 if (++delay > QM_RESET_WAIT_TIMEOUT) {
>                         dev_err(dev, "reset prepare failed\n");
>                         return;
>                 }
> 
> So the added test exits before the inline dereference testing
> QM_RESETTING, but you're relying on the compiler to move the resolution
> of dev into the branch here.  The dereference bug is not fully
> resolved, it's only masked by the compiler optimization.
> 
> The easy solution is to either move the struct device deref into the
> branch where it's needed, or (better) just open code &qm->pdev->dev on
> the dev_err() call.  Thanks,
>

OK, your analysis is correct.
I will directly update the dev_err() call to use &qm->pdev->dev in the next version.

Thanks!
Longfang.

> Alex
> 
>> @@ -1174,12 +1177,14 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>>  	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>  
>> -	if (hisi_acc_vdev->set_reset_flag)
>> -		clear_bit(QM_RESETTING, &qm->misc_ctl);
>> -
>>  	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
>>  		return;
>>  
>> +	if (hisi_acc_vdev->set_reset_flag) {
>> +		clear_bit(QM_RESETTING, &qm->misc_ctl);
>> +		hisi_acc_vdev->set_reset_flag = false;
>> +	}
>> +
>>  	mutex_lock(&hisi_acc_vdev->state_mutex);
>>  	hisi_acc_vf_reset(hisi_acc_vdev);
>>  	mutex_unlock(&hisi_acc_vdev->state_mutex);
> 
> .
> 
