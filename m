Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9528F5
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789895434; cv=none; b=ojg/MJCjnA47Y7zzC+bYMiRbtKnTrivTWINJtHPkdKBl6Adux6Fd7582jh0TSBjQWVGQGRhVPFKPKof5Ot+/gapBojyC+7qJLR/hAoB9fOumkyVNVg5jcH9g9eK0hscXcI+Sa+bTGTcGlokBDyr5yk45ewEsqJKhsaqylAPmoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789895434; c=relaxed/simple;
	bh=QyOwJtRTeP4qZg9gddfrA5i98FC8a07q3cbLqSJAAkM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JrUxipe+M4GSHsP0KRTU3fZheD3EUcNaxdO9JpAG06DYXKojbMY2UHthQtt6gp/uyEwYs7+tDIQZB3HsoUEHUeiq7IU4IIqvbRkU28CGiVEwSI8up/58TtdiwG62GtK0YIkmGrBMVw8Gg3rzfxubbedRYRef6I/MxQvhAe2JOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xXr9g1g+; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xXr9g1g+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cg3yH9rbmRxsBX/h/+D2hh1xBu40od0GLs4xKpx4KOQ=;
	b=xXr9g1g+Uosytyg4XEeQgr4RaZx9G5/+i9SVljgj8trmHsGX78L/Cv7URabtIl7PNCHpmJYR8
	B74IpUssHUIovrGkihZ86RU9CCywsRpgsKDpuJAWNlSDDSGLTrJ02gJkDlwjYi/PNkFhilmC+vV
	bD2dR3ksQa+mx/v/eOi1og4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hngJz4vFhz12LF9;
	Sun, 20 Sep 2026 16:59:15 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D0A720333;
	Sun, 20 Sep 2026 17:10:21 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 20 Sep 2026 17:10:20 +0800
Subject: Re: [PATCH v4 1/2] hisi_acc_vfio_pci: fix NULL dereference in
 reset_prepare on PF passthrough
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260918084244.1485837-1-liulongfang@huawei.com>
 <20260918084244.1485837-2-liulongfang@huawei.com>
 <20260918085735.A40551F000FF@smtp.kernel.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <24bee66f-7e0a-83c3-0cd9-e619d706be0f@huawei.com>
Date: Sun, 20 Sep 2026 17:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260918085735.A40551F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/9/18 16:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] vfio/hisilicon: unprivileged userspace can spam kernel log via VFIO_DEVICE_RESET
> --
> 
> commit 232c524b0aed2e92588a217b15d2d609373f3ea0
> Author: Longfang Liu <liulongfang@huawei.com>
> 
> hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough
> 
> This commit fixes a NULL pointer dereference in the PCI error handler by
> checking for migration support at the entry of reset_prepare() and
> aer_reset_done(). It also properly clears the set_reset_flag in
> aer_reset_done() and updates the VF checking logic in the probe function.
> 
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 86362ec424a50..8ff69c8d1ff71 100644
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
>> +	if (!hisi_acc_vdev->core_device.vdev.mig_ops) {
>> +		dev_err(dev, "device not support migration\n");
> 
> [Severity: Medium]
> Could this dev_err() be used by an unprivileged user or guest VM to spam the
> kernel log?
> 
> Since a non-migratable VFIO device (like a PF or older VF) is a valid state,
> an unprivileged user repeatedly invoking the VFIO_DEVICE_RESET ioctl might
> trigger this path continuously through pci_reset_function(). 
> 
> Should this be changed to a debug log, be rate-limited, or return silently
> to prevent potential denial of service via dmesg flooding?
>

This error log is only printed once during VM startup. Once it appears, the function
returns, providing the basis for the subsequent VM startup to report an error that
live migration is not supported and exit the VM launch.
Moreover, after this log appears, the VM will not support migration and will exit.
If a user deliberately calls VFIO_DEVICE_RESET to trigger this kernel log, it can
actually serve as a record that an unauthorized user is intentionally attacking the
system.
Furthermore, the ioctl operation itself is inherently slow; printing one line of log
per invocation will not lead to a DDoS-like issue.

Thanks.
Longfang.


>> +		return;
>> +	}
>> +
>>  	/* All reset requests need to be queued for processing */
> 
