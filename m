Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E442E435;
	Thu, 17 Sep 2026 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625613; cv=none; b=MmKGOuUrXjE5RPD4Kn50EQhoh2jREnwCC+Eh/HFLX8YdhHdQcmbrXHvayx6oAKKRpW/YLZVMtL+Ucwq3YuCr2Yj0vAA/MqbsPfMlTv73vSjyNA/kUNf1s3SKYf/1knr4ymPAiGNGOGNaNTnWPLeWHOa1sc8Fu2TWFwHzNLAfI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625613; c=relaxed/simple;
	bh=MqiypOQyvg65fl1wg8Vha67UqTVYBaFX3L2CNr86y6M=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k08ONNfGR7shVAjpcY4u1NkTRu6slKMsuFPX4YquhqWdIHLRuVC4U7843D84fZS9kCP9yBoD9xfR3lCZcylRRI9PfjS6DNnju4qkFO22tndvcBpSPd8q234k+sYvtr1h+CIpB4HGfGtXlnnVSTk+G1tqW8GiuylckeM5ow7yRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3K1/2rQE; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3K1/2rQE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=exQ8lANud7QLqdPPLKJFIW+0uw5bdHtTYIGtM/RmATU=;
	b=3K1/2rQEXaRl6DeWt6jZ2wgHm4VQnkiBa0lzqWt0CpFcRLaqSGRBg2CtTpp8ne9kxJgzZ9a+4
	7w3X5I2AKPLmS47xKdxIlG4w97pGq7K9MHY2YxC5NEx4R5epJ3WDeXJgV6ti/1My5eZQ8wLW3Qe
	HE/Dce4oYnm1qKQvcYnT9ok=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hllX91xZ5z12LF9;
	Thu, 17 Sep 2026 14:02:17 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id ED5A82017D;
	Thu, 17 Sep 2026 14:13:24 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 17 Sep 2026 14:13:24 +0800
Subject: Re: [PATCH v3 3/3] hisi_acc_vfio_pci: reject live migration on 64KB
 page with QM_HW_V3 hardware
To: Alex Williamson <alex@shazbot.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-4-liulongfang@huawei.com>
 <20260911113721.35d7383d@shazbot.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <ecb52830-2900-a018-67f0-24b4829e722b@huawei.com>
Date: Thu, 17 Sep 2026 14:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260911113721.35d7383d@shazbot.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/9/12 1:37, Alex Williamson wrote:
> On Mon, 31 Aug 2026 17:09:51 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> In the scenario combining QM_HW_V3 hardware with 64KB large pages, the
>> device functional region and migration registers share the BAR2 physical
>> page, resulting in a lack of isolation that triggers security issues.
>> More critically, since KVM does not support the specific 16-byte read/write
>> instructions used by the guest driver, operating under the KVM emulated
>> device scheme will lead to Guest kernel calltrace issues.
>> To prevent Guest exceptions and avoid security vulnerabilities, the
>> driver directly disables live migration functionality in this scenario.
>> This ensures the system fails cleanly with an error early during startup,
>> while other configuration modes remain unaffected and can still utilize
>> passthrough functionality normally.
>>
>> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 4abed2e49986..4f12cab96545 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -1210,6 +1210,23 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>  	else
>>  		hisi_acc_vdev->drv_mode = HW_ACC_MIG_VF_CTRL;
>>  
>> +	/*
>> +	 * On VF_CTRL hardware, BAR2 holds 32KB functional + 32KB
>> +	 * migration registers. When the host page exceeds 32KB, the
>> +	 * two share one physical page and cannot be isolated by mmap.
>> +	 * Reject the open so QEMU fails cleanly at startup.
>> +	 */
>> +	if (hisi_acc_vdev->drv_mode == HW_ACC_MIG_VF_CTRL) {
>> +		resource_size_t func_len =
>> +			pci_resource_len(vf_dev, VFIO_PCI_BAR2_REGION_INDEX) >> 1;
>> +
>> +		if (func_len < PAGE_SIZE) {
>> +			dev_err(&vf_dev->dev,
>> +				"migration not supported on 64KB pages with QM_HW_V3\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
> 
> Sashiko correctly identifies that this breaks any assignment on 64K
> pages, which is contradictory to the comment that indicates this is
> only intended to disable migration support.  This should instead be
> invoking the non-migration path in the probe function.  Thanks,
>

It is a reasonable approach to directly select the non-migration ops in the probe
function based on the logic check.
I plan to implement this in the next revision and complete testing and verification.

Thanks.
Longfang.

> Alex
> 
> .
> 
