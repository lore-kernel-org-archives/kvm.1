Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602632B102;
	Wed,  5 Aug 2026 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898503; cv=none; b=uS96Ud08+WOj76LEpieunZ7NWgA/7WLH/H71IJxBhyb1gPOmYTDNIUJ+CiFYRb5a9GrsrwUmA8FdDnC0VLHUHPmmvAMUk5LxWRgf1MHD5jeNroSKhKZJWLGc7pqvTo6Ws2uHvyzB1nwYFlFiYWfPp9388HKMERSJPzfbt0DDF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898503; c=relaxed/simple;
	bh=xUqVuEEl1pLHa3LuHB0IcUilExz3VpoSNV1pmvO0MXw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m7EmnwrPsJzaBSOrF4cSv8oTDEe4Z5VXjJt3R6OFAj2q3aMNpljhcgvr6MZ+Ak9eo9C1LptG8QoKnN+fx0kJq86kN3fnMfK0XPzrxyJ2tkYIx0kIvLWUgv6z3FvBsYtY66OaQeaQKz/l38cPSsDkdOS/dSDsEF1cMbPUpdEVNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NAk9ksdP; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NAk9ksdP"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vdi5mjFGLxzBJDprHRtbgKopw2ksx9+dl6nmNXyzIYo=;
	b=NAk9ksdP3Misrtr7Y9BsVQpbsqpbOVGrQrHGWQX4SubuJsfoVQjbsRoHCF3GzpgYbeea6S3LH
	JQCJL3GFy/Om058OdQJkZOKzys3iGE2RHMtTkBf2xchPh/oQ+VOwL+S9Fw8qBvpSNtE81P4nLzD
	GlR8kqNXTyarL97GEjIEeeg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFFBh3S6fzKm6j;
	Wed,  5 Aug 2026 10:45:16 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 3334E40565;
	Wed,  5 Aug 2026 10:54:50 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Aug 2026 10:54:49 +0800
Subject: Re: [PATCH 2/2] hisi_acc_vfio_pci: fix VF BAR2 mmap on 64KB page size
To: Alex Williamson <alex@shazbot.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260803021857.2370179-1-liulongfang@huawei.com>
 <20260803021857.2370179-3-liulongfang@huawei.com>
 <20260804132745.2db9c897@shazbot.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <6b1351d6-2d7f-974e-dab4-69cc8574b848@huawei.com>
Date: Wed, 5 Aug 2026 10:54:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260804132745.2db9c897@shazbot.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500015.china.huawei.com (7.185.36.143)

On 2026/8/5 3:27, Alex Williamson wrote:
> On Mon, 3 Aug 2026 10:18:57 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>>     On HW_ACC_MIG_VF_CTRL hardware, VF BAR2 is split into functional
>> and migration register regions. When kernel page size exceeds the
>> functional region size (e.g. 64KB pages vs 32KB functional region),
>> guest mmap operations get rounded up to page size, causing the VMA
>> to exceed functional boundaries and fail validation.
>>     The solution aligns mmap boundaries to page size while maintaining
>> byte-granularity access control through hisi_acc_pci_rw_access_check()
>> for read/write operations and accurate region size reporting via
>> hisi_acc_vfio_ioctl_get_region(), ensuring migration registers remain
>> protected from non-mmap access while resolving compatibility issues.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 36490be7a61a..44b3e7d8fef5 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -1355,14 +1355,21 @@ static int hisi_acc_vfio_pci_mmap(struct vfio_device *core_vdev,
>>  	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>>  	if (index == VFIO_PCI_BAR2_REGION_INDEX) {
>>  		u64 req_len, pgoff, req_start;
>> -		resource_size_t end;
>> +		resource_size_t end, dev_len;
>>  
>> -		end = hisi_acc_get_resource_len(vdev, index);
>> +		dev_len = hisi_acc_get_resource_len(vdev, index);
>>  		req_len = vma->vm_end - vma->vm_start;
>>  		pgoff = vma->vm_pgoff &
>>  			((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>>  		req_start = pgoff << PAGE_SHIFT;
>> -
>> +		/*
>> +		 * The BAR2 functional region (dev_len) may be smaller than the
>> +		 * kernel page size. Align it to PAGE_SIZE so a page-rounded
>> +		 * guest mmap is not rejected, which would make the VF unusable.
>> +		 * The read/write path still truncates at the real functional
>> +		 * boundary, keeping the migration registers inaccessible.
>> +		 */
>> +		end = PAGE_ALIGN(dev_len);
>>  		if (req_start + req_len > end)
>>  			return -EINVAL;
>>  	}
> 
> You may still be restricting read/write access into the migration
> range of the BAR, but doesn't this give the user full access to that
> extended range through the mmap?  It seems they only need to access
> beyond the advertised region length through the mmap to bypass
> hisi_acc_pci_rw_access_check().
> 
> If they can do that, what are we even still protecting?
> 
> Alex
> .
>

Yes, the issue you mentioned is indeed a serious problem. We need to prevent this
type of security vulnerability where memory segments intended only for kernel access
are exposed to VM users.

Thanks.
Longfang.

