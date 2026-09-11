Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A092F5A0E
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113748; cv=none; b=IK8lvQgu6sKe5V0pRgifWERAXsBtowM6iEN5laKng5H/Znmk47jficfB/ZqwnYkUzPg/Q+vyIWQiW0VE8/AW2T8tsV3F5tvjVxE1JrJSkfIpQGkgYDPikhXI83ZafQpNhE3PqU1ehUwYDOs15qHIZjnLJDwaDLJAiJRewSSaqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113748; c=relaxed/simple;
	bh=kWye7oczxb+xHn8UZoHsc7rHqnfcjPMoegPUUkruFfI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ksRmGLIpozGKWOHl5RmiJq0hsaWbqEQ/YQ3FN5bPSJYmI01iwEzKo8ltNKCcf5DnhuufPGDqRPW+bVHxJLVxLnm8ACH3OzAYxMrdv51yKlKCXkH98fEFmjmtQ8wC1BAnb2KRvZM30VoPFvblrfLh2i0M+3zCQJyjj0pFuS4PeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HA4oEFiC; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HA4oEFiC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dyuY+e6KhIRbp1sqltg9xR+i0CBP0mQMEq4WQEvfMac=;
	b=HA4oEFiC8znxJydKC3KAHAtUr7/aOhg7dKOBOA38HUyUBAgNDM5MK37C36x9RASME3GTY/Ex0
	TSzzqLHkiX2XCmrB+L7aBzH1PHkHexlpd1DWCYdJYHf0OrFZGYdWKWYiaLPFrfRlqXNv6oeY8p7
	7KAih2VuU4lbY5T1XYp+b3o=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hh6Dh2L4czKm5t;
	Fri, 11 Sep 2026 15:51:16 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 80B1B4057A;
	Fri, 11 Sep 2026 16:02:15 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 whupemk100014.china.huawei.com (7.152.184.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 11 Sep 2026 16:02:14 +0800
Subject: Re: [PATCH v3 3/3] hisi_acc_vfio_pci: reject live migration on 64KB
 page with QM_HW_V3 hardware
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260831090951.844569-1-liulongfang@huawei.com>
 <20260831090951.844569-4-liulongfang@huawei.com>
 <20260831100023.0155B1F000E9@smtp.kernel.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <7e77dab0-ede4-527c-e5ec-9056f48ecd73@huawei.com>
Date: Fri, 11 Sep 2026 16:02:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260831100023.0155B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100014.china.huawei.com (7.152.184.20)

On 2026/8/31 18:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch completely breaks VFIO passthrough for this device on 64KB page hosts instead of gracefully falling back to generic operations.
> --
> 
> commit e0bfdb6998df9e209e0b7358693ec17f21c25bfe
> Author: Longfang Liu <liulongfang@huawei.com>
> 
> hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware
> 
> This commit aims to prevent security vulnerabilities and guest exceptions when
> combining QM_HW_V3 hardware with 64KB pages by disabling live migration. It
> returns -EINVAL during device initialization if the host page size exceeds
> 32KB.
> 
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 4abed2e49986f..4f12cab96545e 100644
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
> 
> [Severity: High]
> Does returning an error here completely break VFIO passthrough for this device
> on 64KB page hosts?
> 
> Since hisi_acc_vf_qm_init() is called during device open, returning an error
> causes the entire operation to fail. This results in users completely losing
> passthrough functionality for QM_HW_V3 devices on 64KB page hosts, rather
> than just having migration gracefully disabled.
> 
> Could this be handled earlier in hisi_acc_vfio_pci_probe() instead?
> 
> The driver currently assigns migration operations unconditionally:
> 
> drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:hisi_acc_vfio_pci_probe() {
>     ...
>     if (pf_qm && pf_qm->ver >= QM_HW_V3) {
>         if (pdev->is_virtfn)
>             ops = &hisi_acc_vfio_pci_migrn_ops;
>     ...
> }
> 
> If the 64KB page limitation was checked during probe and fell back to the
> generic ops instead, normal passthrough would continue to work correctly.
> The generic VFIO implementation safely maps the entire BAR2 region without
> KVM trap-and-emulate issues.
>

Our goal is precisely to disable live migration for passthrough on 64KB page systems.

Thanks
Longfang


>> +		}
>> +	}
>> +
>>  	if (hisi_acc_vdev->drv_mode == HW_ACC_MIG_PF_CTRL) {
>>  		/*
>>  		 * On hardware platforms greater than QM_HW_V3, the migration function
> 
