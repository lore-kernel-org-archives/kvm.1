Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63B3E3C59
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249660; cv=none; b=V2TAROjlWdGQkXadEJ9Dd37jpepN5t3Vz41TphTLAF1WoMuuzDquhe9GpW6mX44nr74ArHBKS7YLyTXGl9KAPfBHiN5ZuwOPTHyWfbT7XckdRa4Hs26/tWrdwOI2DFDTFSNT7oFSMTcjhw9WIe4kS+zPL6aIXQHViEn+rAH4WVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249660; c=relaxed/simple;
	bh=24cKQhOrBdz+r1y3wY10db8gYpkzl3/JjPY0IbCGpfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2nvAvde+kcMiHSavJfKe0nEk7RMsEQbB0mUGNUJp2cfXUWjoTEQ6ef5tc9//4JK5yv4rS6H4S4aUqxVafZ2L9b0jdM1pOSNo8DsqVLA7kAEbpaK6jqEFbVp5cz9BY2/uTvA1s9p26rFEto2jEREoZ5zkTMaBOI/GREOmfr4qr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b27WmIR3; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b27WmIR3"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6489piHi138258
	for <kvm@vger.kernel.org>; Fri, 8 May 2026 07:14:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mrh0IGSdaH5nB6dwvFScuHiJhqbtAaLgOW6ti3reoAo=; b=b27WmIR3RMZj
	LJXRE1ouqBpqp6DzsvWlufBBycGimzV0cLtBYAoLiVWnTJ6IMMKNIS+C2LNrL3MU
	Yc7Nev9C5I4ylrz2YgK3KMPy+8qSvZyhduJ0yRBEZAM3omjZ6EAHFeZHsHlKuSez
	r2PUYwplTlmzghZZD78anBqZ1tveq9UD+OssE7Vhm+ohq1vrVEyxrBSJp1I51LTY
	m3QEaQzJk7XoR8sOTMKl9cg5K/ovtdhsmFVXstnh62XiYnBpryl2vEWhz7wkbUK3
	zgnGrXGraTtQN99jbcvwGgXuvxd2seWnM3Jb0086tNsFAquNONj70dMWNA1GGOiY
	A0PNI6zPvQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e1djqw4rv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 08 May 2026 07:14:17 -0700 (PDT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so9406661eec.0
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 07:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778249657; x=1778854457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrh0IGSdaH5nB6dwvFScuHiJhqbtAaLgOW6ti3reoAo=;
        b=Z0B01iF1gDHOSmPQDD0oNcI4mGZ1Z70UBGjKbwptxp1dqMHKx8tzpEQonD6yhrF2Z/
         n2YwecmhXT29lwP25CRnRfGMb9WPaNKzjpUTtR1DxI5CtOppkvqFHiUqg25Mx/9NMJQR
         e+xywuisKlOQD+2qvuIbrg/mc7Edofdy0Y4dtWL4F8HUtCGEaLsSueCx4PXl/0z6wh4K
         WHpZ+KW2PMGNdsFjxHNMo8SuqNxZ4z018zKLml2nBlG6cxVOIoGargVph14x2Kn1GUk2
         um3L3GGMOvm83UAzEGfJMAJhDufKoqhlSCpr4Pr0fh9bsmAUBqPdajJ+Bt95H1NNHfQk
         98Qg==
X-Forwarded-Encrypted: i=1; AFNElJ9oZDaFmx5bdZAwVnq98xC5UOpxutxlNn+Y29494nEmRGNTl+VpHEEllhHr1c5Ho006go4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOzat7CO4AclxYi3D1beV/RX4ko1iqSJg5KTTQwcDnWedGTLl
	q8SC7n3AvCwah17/KinXLzf81gRSOTdeZNLUYMLUqKU/zZ0tcqwhQZZ/ChqqccChAI/rQ3slRW6
	3yMWz9Vm0+OPZFZx7azU0em9v6v3SK9hF+j4hquGQOuTyRG+dFSR5
X-Gm-Gg: Acq92OFNzqo6CaV2PaNtHnr1afAw30dxEbls0QG8Lt1AD3Z/tFsnQ1v+p/oUZQzxRC2
	BGSD/ZJTG7ZmoyWBy+dJuRE88LoNEIyRE3jYB2iQAcdZdg+aeKqvBtlxpCn5PgQGfG4xGm3aNFd
	nuUQIQaEvhPbujs/k2hWoKdKxY8Cgp5r8TuTG0+GLF1Ta3slTrfaM6mHuI3IJboVfMFAV8tGTm/
	uLIMzQrYufZJqXzvbvwBzABdMt0eTvcXK4SstOtdACkGnSUFAdlwI4U/63c+z/yzABuCvxhhx9J
	qpb8FzMgFnemCp1NC/zWxVf8sYw7Rm6DCRSE2+P8SWNtohSLPZ1FDyU8eUvAxYLuBm2Dsu94uSF
	wIBfcnXQwF6FRcEpV4AVSPS3JPAjt7QWnfyw=
X-Received: by 2002:a05:7301:1018:b0:2f1:6252:f8fe with SMTP id 5a478bee46e88-2f548a995afmr6407727eec.3.1778249656999;
        Fri, 08 May 2026 07:14:16 -0700 (PDT)
X-Received: by 2002:a05:7301:1018:b0:2f1:6252:f8fe with SMTP id 5a478bee46e88-2f548a995afmr6407696eec.3.1778249656361;
        Fri, 08 May 2026 07:14:16 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f885edb83fsm2292720eec.7.2026.05.08.07.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 07:14:15 -0700 (PDT)
Message-ID: <339b4e0c-7c41-4585-83a3-a2cd9e7003ee@meta.com>
Date: Fri, 8 May 2026 15:14:10 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] vfio/pci: Set up BAR resources and maps in
 vfio_pci_core_enable()
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260505173835.2324179-1-mattev@meta.com>
 <20260505173835.2324179-2-mattev@meta.com>
 <20260507162116.3b9cbd98@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260507162116.3b9cbd98@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0MiBTYWx0ZWRfXyg49mloj6ypj
 b9esghIf3WcSIYW1dUzVPdmQo8bQJC7UGQz7y8ORZE3xzAN7NUS6Z1kBhnAmrMAKwttSq1F4uld
 /pceLHZRqF511AVWwVos5hApyqE2LlyPIyaoKEu8gUlPYAJ5fzTIH9cXmvBIl1zODCGdZOy+j4n
 qTKR1xziA+aB8GOCTx6Xt7L0GnjGN2lxO35zIo4+kC1l46PNhp5uxPH/Cb8Ao7ULdrjt8/YnYAT
 gCz/+bb0wepVevKfc3MHoaEGQs4BWVdRliSsivTUujIvjLpBGlAfb2/+1lrr6c2w8h4cuMygO6m
 0mk50eshG1RZUNpUmHd4cP8CVpJc92ObTrA9lp+Tmpy1hMnEDPzZMXqA5RlT9ajUvlE6NtU+2zn
 AovKJgcb+XMAn/F3TzrtNEEj0Tdlf2zZMMdL25tm3miD9ZgVMnsMxr9dQ2hKnV1rQKR2vZfw/kb
 67iBMI06r9u/FSxKjsw==
X-Authority-Analysis: v=2.4 cv=Yoc/gYYX c=1 sm=1 tr=0 ts=69fdefb9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=c92rfblmAAAA:8
 a=VabnemYjAAAA:8 a=xTlyUr2g16H8L6VawkwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 3k59TAXKHbrsc45oekr9q8zFrcyjmA1Z
X-Proofpoint-ORIG-GUID: 3k59TAXKHbrsc45oekr9q8zFrcyjmA1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_01,2025-10-01_01

Hi Alex,

On 07/05/2026 23:21, Alex Williamson wrote:
> 
> On Tue, 5 May 2026 10:38:29 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Previously BAR resource requests and the corresponding pci_iomap()
>> were performed on-demand and without synchronisation, which was racy.
>> Rather than add synchronisation, it's simplest to address this by
>> doing both activities from vfio_pci_core_enable().
>>
>> The resource allocation and/or pci_iomap() can still fail; their
>> status is tracked and existing calls to vfio_pci_core_setup_barmap()
>> will fail in a similar way to before.  This keeps the point of failure
>> as observed by userspace the same, i.e. failures to request/map unused
>> BARs are benign.
>>
>> Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 36 +++++++++++++++++++++++++++++++-
>>   drivers/vfio/pci/vfio_pci_rdwr.c | 26 +++++++----------------
>>   2 files changed, 42 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f8d093aacf8..62931dc381d8 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -482,6 +482,39 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>>   }
>>   #endif /* CONFIG_PM */
>>   
>> +/*
>> + * Eager-request BAR resources, and iomap them.  Soft failures are
>> + * allowed, and consumers must check the barmap before use in order to
>> + * give compatible user-visible behaviour with the previous on-demand
>> + * allocation method.
>> + */
>> +static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int i;
>> +
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int bar = i + PCI_STD_RESOURCES;
>> +
>> +		vdev->barmap[bar] = ERR_PTR(-ENODEV);
>> +
>> +		if (!pci_resource_len(pdev, i))
>> +			continue;
>> +
>> +		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
>> +			pci_dbg(vdev->pdev, "Failed to reserve region %d\n", bar);
>> +			vdev->barmap[bar] = ERR_PTR(-EBUSY);
>> +			continue;
>> +		}
>> +
>> +		vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
>> +		if (!vdev->barmap[bar]) {
> 
> Sashiko notes[1] correctly that we need to release the requested region
> here.
> 
> [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260505173835.2324179-1-mattev@meta.com__;Iw!!Bt8RZUm9aw!75pHBGTcV8AYGiGGjzomqZLfDp7iR_j2JC6qCiJufoo7TxJTPuViQZjqp7I3ZRPPxwj1YtYSNQ$

Hnnng.  Right, fixed.

  -Matt

>> +			pci_dbg(vdev->pdev, "Failed to iomap region %d\n", bar);
>> +			vdev->barmap[bar] = ERR_PTR(-ENOMEM);
>> +		}
>> +	}
>> +}
>> +
>>   /*
>>    * The pci-driver core runtime PM routines always save the device state
>>    * before going into suspended state. If the device is going into low power
>> @@ -568,6 +601,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>   	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>>   		vdev->has_vga = true;
>>   
>> +	vfio_pci_core_map_bars(vdev);
>>   
>>   	return 0;
>>   
>> @@ -648,7 +682,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>>   
>>   	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>>   		bar = i + PCI_STD_RESOURCES;
>> -		if (!vdev->barmap[bar])
>> +		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
>>   			continue;
>>   		pci_iounmap(pdev, vdev->barmap[bar]);
>>   		pci_release_selected_regions(pdev, 1 << bar);
>> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>> index 4251ee03e146..3bfbb879a005 100644
>> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
>> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>> @@ -198,27 +198,15 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>>   }
>>   EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>>   
>> +/*
>> + * The barmap is set up in vfio_pci_core_enable().  Callers use this
>> + * function to check that the BAR resources are requested or that the
>> + * pci_iomap() was done.
>> + */
>>   int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
>>   {
>> -	struct pci_dev *pdev = vdev->pdev;
>> -	int ret;
>> -	void __iomem *io;
>> -
>> -	if (vdev->barmap[bar])
>> -		return 0;
>> -
>> -	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>> -	if (ret)
>> -		return ret;
>> -
>> -	io = pci_iomap(pdev, bar, 0);
>> -	if (!io) {
>> -		pci_release_selected_regions(pdev, 1 << bar);
>> -		return -ENOMEM;
>> -	}
>> -
>> -	vdev->barmap[bar] = io;
>> -
>> +	if (IS_ERR(vdev->barmap[bar]))
>> +		return PTR_ERR(vdev->barmap[bar]);
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
> 

