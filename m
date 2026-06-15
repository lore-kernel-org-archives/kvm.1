Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2D7080D;
	Mon, 15 Jun 2026 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485179; cv=none; b=L/XBIADJTn50SVQ3LxMflHXt6zoFJyVCL4MfUjyRfQOzHpyRglURKtVsuyRMBV0pBKr5Mb25Qsvs73BRUyD9CHraeEDm44FBjUMPCPU5H87jWtuOk7ms1Octlklytm+OsSrNjoa/EtpJwo0GklSUdPJZR6u3IZDM+cREsPwp+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485179; c=relaxed/simple;
	bh=yC/BFsu7rOTj60DsdBxnueOEKAkiy69Q+7JMAXjOQnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VkjHSRBKGPXQYe+o3H15KKcVgPN8/pxUMrK5hRYXm9b+vpAdeXjigtXdKtxlx9PG/R3+h73kLrTM1IaFMawGZcj+/MmiVXqt0mrEA7Uh2nK83jxD00kbzg8MbznTRXqiayLLNYSIYNHSaPxWteIEfrt8zEW3FaP19Grntb3QDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AzLtbr/L; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AzLtbr/L"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Cfdw/mn+aegjQt779+hXZRE7+aiUd93avhGXNwuYSWM=;
	b=AzLtbr/LAc6GgglPpfKQUUdJyMF+Eig5aA07GxEb19kz3sbv/v3cGj2X+hw90589uoq40IQSk
	WIKPredsHFXdp1j4to/EdKTHTESZ0zG8aQjhAlnfR1tzl/AKaibLVAZsf0SWMLGW2Cm/vCR9a86
	kTqVFhcyeHVHkCv4OGqOYL4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gds3s5CpjznTbY;
	Mon, 15 Jun 2026 08:50:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E153640565;
	Mon, 15 Jun 2026 08:59:22 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 08:59:22 +0800
Message-ID: <28ce60f0-41d4-4f69-9069-8388bb4a8659@huawei.com>
Date: Mon, 15 Jun 2026 08:59:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio/pci: Latch all module parameters per device
To: Alex Williamson <alex.williamson@nvidia.com>
CC: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, <kanie@linux.alibaba.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
 <20260611213539.4100590-6-alex.williamson@nvidia.com>
 <06ade652-fc43-451e-a3ef-a8b6051e5c9a@huawei.com>
 <20260612081124.6228fdb8@nvidia.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260612081124.6228fdb8@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/12/2026 10:11 PM, Alex Williamson wrote:
> On Fri, 12 Jun 2026 16:40:37 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>>
>> Since nointxmask and disable_idle_d3 already have S_IWUSR and share the same
>> "latch per device at init" behavior, it would be better to also add S_IWUSR
>> to disable_vga for permission and behavior consistency.
>>
>> Runtime writes will only affect future devices, existing devices keep their
>> latched value, so no extra risk.
> 
> The difference is that notintxmask and disable_idle_d3 are typically
> diagnostic measures while disable_vga is a feature mask.  disable_vga
> has never supported runtime modification.  So, while I agree it's
> possible, this would expand the scope of this series from bug fixes and
> behavior restoration into feature enablement, which should have some
> actual use case in mind.  Therefore I don't intend to pursue it in this
> series.  Thanks,

Understood and agreed. Thanks for clarifying the scope.

> 
> Alex
> 

