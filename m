Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBD30F534
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418402; cv=none; b=VCJ4buCKD029o96ATmknXSdV9SptfLONcyS5sfeFPPuRM2rY8WC6VDzWdWYJMtWtIHGTrfxtEDmrnsl7Ncg2dFs0il7Uq3ARdO1308aqCHH4JQw5D/OcuXsPIBGS0Ff9sXP8i0sGOS1hFfaQgO1YIS/vfXdewLy1JZFjbo7W7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418402; c=relaxed/simple;
	bh=woTNv57IMQwTYrlreMeY3hXWvRabJQ4iemjU3w5kLjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6Wrsn/9eWakK8+TY5wqkf/N/1NSvuo1p9X8LbvAd+iVLUWtKegezOqUxG5k5a+h/ImWZoBKog3RhNjT3I3q673oy3MfQuUX4amooQcUNX4lFqvP5bY/MvbZ/1ieqUK8CDiURlQasLOPupysOE/s33CI5MCqYI2+4ROf9wvD59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HOg7qB1Z; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HOg7qB1Z"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652FSWrc2304651
	for <kvm@vger.kernel.org>; Tue, 2 Jun 2026 09:40:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=aQM+IzQj3ZxDY3ggA3owlA7d3KkShBiCJ4vlXvqOyDo=; b=HOg7qB1ZuQW4
	6lBSat61mKhK+MnCr8cVctmCY8FdH0jD5Vqo1SZjiJT1PXSaE6jJQVDirlh/htm/
	9o6dj/yg6WQlQu1Ag3gFjinhmPlncdZ+iDtruJCHvVEKqdsfNMXoAkXSrKPtLDTA
	3xX8W/GYXP0Aq5Gq6Ync/girYSkqCalmedMCwx9NdEVzNdCIolWzgFPcYbZtVZgO
	Jn4AyjLkjiJuARnKpqqzKSPyRW9JD8y2/mqfCdNwg8CHUTH8ACHXhAFYvzpVOmgy
	952MRLNOgD4wNbb/nZkLL1ZWSrP4TZejD+XKBEBOdJHJiP/7oON+DmOd/cec5Y2L
	4bhL4BgFWQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej1uhrhda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 09:40:00 -0700 (PDT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1353bfdbf99so8985876c88.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 09:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418400; x=1781023200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQM+IzQj3ZxDY3ggA3owlA7d3KkShBiCJ4vlXvqOyDo=;
        b=qbOaSCvqskHcYyK7Rw4VstmVEeNbkG5UdNEbbqszJ6ycum7YBUlExOn03U3oCDG2cQ
         qfnjkJrn5Vn3fWe9lbF5pRXa7EQCjtGULQRoUPcCpBBLrD3CH06hzWZtZDqkkfcyG/KA
         bPgTFMzlwy1U7WDokt+LMvM4kVMwCTb5VOzOGR2qIhxOXmQ0XeiWthAQkJ+nnLhPQ+oy
         uM9X7fe/ZKGbgj2K53QFCFN36nOdv4fFo0k4FKYNXLw0qHDDLca++Y68ZeH5S3fJjJ4B
         GHbdjBeZLn1KJyzW3lFxnpBTQzinYb8vsMkeZvLmI7ZwQlFDuNKQmsFKLuL2Hnp82oNQ
         WOTg==
X-Forwarded-Encrypted: i=1; AFNElJ9jjQQ58Musze+7SnVzwGkjzLe66tprq4hkrcildSHkvDVxKnX3rOta8KMAEhz7+jM5Nms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxEc/2S0xTS7llM20UAxEjHW+TaW7m98PJkn6Ej8s8HN9h9I2I
	ekH3C1YlPQ9+YWYsNvzhsnAswiCFtIwkHm1ev0uYVYiCj0ZuFA6wjIhw/fXo/4J+891qlzMZwUt
	4gfv6WaoTpI0ZtuLJvK3Ymzsqjx/VUyzHfD6xjtp4580ybLRCBbVS
X-Gm-Gg: Acq92OHCo1/ZPPRcQNkNkPcaFggGgCqr62fNNKfIqcdDqtrXi2mDQfu2bL7F+++io5z
	SiwAWOlCpQH5ZYuu6uRyZ1rkf3VVASiyf5QVdDqx7yQdeeDF6BF1dZEUxLo7MOK0/CmNXaPMEr5
	mV1H5jmmlcAJd+/XP4Kj1S0PCuloE0ySqk55RuX7oE7bMwZMgamkeqZR7j4yoR1AjZ4c9LQtViN
	oBbNh75O5ylEKPkh/wU97cRDFgGkXr48qWPxPzuGA9vrc1kFNMQr6ePLFHFIqFe6jldK7yuLQC8
	vu/+DvyCOVG8M9TPWv2ZjybnELpJ7cLW3qfQWrmOZ+wFyu/q0dgHNPdTH9UzNMI65ZjbLC0FoA3
	bze2bwNP4PlFcsYdEjutp5GigtFJ03X1K9NVmaXHO
X-Received: by 2002:a05:693c:2c0e:b0:304:e450:67e0 with SMTP id 5a478bee46e88-304fa4c81d5mr8098496eec.10.1780418400037;
        Tue, 02 Jun 2026 09:40:00 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0e:b0:304:e450:67e0 with SMTP id 5a478bee46e88-304fa4c81d5mr8098467eec.10.1780418399427;
        Tue, 02 Jun 2026 09:39:59 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm11553860eec.1.2026.06.02.09.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 09:39:59 -0700 (PDT)
Message-ID: <dfa4d88b-9182-499c-b2ba-dbde0fc32745@meta.com>
Date: Tue, 2 Jun 2026 17:39:54 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple
 <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-4-mattev@meta.com>
 <20260527165922.60a79fee@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260527165922.60a79fee@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cZuKRPEBvAGyBrrLiHgvBM3_ET5QoYr-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MSBTYWx0ZWRfX+ahT7U1lB9NA
 cDl8mrb0LYOKE45JpbkESExwq7eM9rTKU5iNYnyZKoEjTTg20ei6JOw1XdXOWKcRBI1IHrbBGp7
 laUlScn816O3jdYrb441JRz3bDaxDVWM9XZK42XEppUdBeAaForAKMUtHji2cycEF1WhI9+FsqU
 fD3kH1uhAzSZO+wtZvTyQDzsrOn/dIJDPWGLRYsuZDT5h8E3JEYvrNk/9eL1lZCrKtIn6GT7yLm
 ICyFZh0E4Q0iW9Wic5VN0KFfC0JEr+/lV7MqlUt97V/fhWQR9l3CzjN4KfjnChSf9AXzmWstYhk
 IrylqXBa+a3VlyfYL/B2JQNZz/WhYWPFuZFLAOpmyAy2K/ncskmy9wO1qqOljf99PwbBZyw4N+q
 E7eFr7pOHOmj/7ctE2saLZFuLCggOydwpRfpyYoD778PMFlZ9Q/sI6whr6V8Fds5+gFJL6Pvaky
 ZgNdXnYJ7TuANDr2uYw==
X-Proofpoint-ORIG-GUID: cZuKRPEBvAGyBrrLiHgvBM3_ET5QoYr-
X-Authority-Analysis: v=2.4 cv=UshT8ewB c=1 sm=1 tr=0 ts=6a1f0760 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=Dv35txUGz5gI0hTa:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VabnemYjAAAA:8 a=73EwkdylJAySbZmAXzAA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01

Hi Alex,

On 27/05/2026 23:59, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:06 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
>> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
>> commit by VFIO's ordinary mmap() path.
>>
>> This function transfers ownership of the VFIO device fd to the
>> DMABUF, which fput()s when it's released.
>>
>> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
>> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
>> this new VFIO_BAR mmap().
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 140 ++++++++++++++++++++++-------
>>   drivers/vfio/pci/vfio_pci_priv.h   |   5 ++
>>   2 files changed, 115 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 0d132c4ca95f..782408c08a5e 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -82,6 +82,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>>   		up_write(&priv->vdev->memory_lock);
>>   		vfio_device_put_registration(&priv->vdev->vdev);
>>   	}
>> +	if (priv->vfile)
>> +		fput(priv->vfile);
>>   	kfree(priv->phys_vec);
>>   	kfree(priv);
>>   }
>> @@ -222,6 +224,45 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
>>   	return -EFAULT;
>>   }
>>   
>> +/*
>> + * Create a DMABUF corresponding to priv, add it to vdev->dmabufs list
>> + * for tracking (meaning cleanup or revocation will zap it), and take
>> + * a vfio_device registration.
>> + */
>> +static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
>> +				  struct vfio_pci_dma_buf *priv, uint32_t flags)
> 
> s/uint32_t/u32/?

Fixed.

>> +{
>> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>> +
>> +	if (!vfio_device_try_get_registration(&vdev->vdev))
>> +		return -ENODEV;
>> +
>> +	exp_info.ops = &vfio_pci_dmabuf_ops;
>> +	exp_info.size = priv->size;
>> +	exp_info.flags = flags;
>> +	exp_info.priv = priv;
>> +
>> +	priv->dmabuf = dma_buf_export(&exp_info);
>> +	if (IS_ERR(priv->dmabuf)) {
>> +		vfio_device_put_registration(&vdev->vdev);
>> +		return PTR_ERR(priv->dmabuf);
>> +	}
>> +
>> +	kref_init(&priv->kref);
>> +	init_completion(&priv->comp);
>> +
>> +	/* dma_buf_put() now frees priv */
>> +	INIT_LIST_HEAD(&priv->dmabufs_elm);
>> +	down_write(&vdev->memory_lock);
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>> +	priv->revoked = !__vfio_pci_memory_enabled(vdev);
>> +	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +	up_write(&vdev->memory_lock);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>>    * It allows the two co-operating drivers to exchange the physical address of
>> @@ -340,7 +381,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   {
>>   	struct vfio_device_feature_dma_buf get_dma_buf = {};
>>   	struct vfio_region_dma_range *dma_ranges;
>> -	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>   	struct vfio_pci_dma_buf *priv;
>>   	size_t length;
>>   	int ret;
>> @@ -400,34 +440,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	kfree(dma_ranges);
>>   	dma_ranges = NULL;
>>   
>> -	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>> -		ret = -ENODEV;
>> +	ret = vfio_pci_dmabuf_export(vdev, priv, get_dma_buf.open_flags);
>> +	if (ret)
>>   		goto err_free_phys;
>> -	}
>> -
>> -	exp_info.ops = &vfio_pci_dmabuf_ops;
>> -	exp_info.size = priv->size;
>> -	exp_info.flags = get_dma_buf.open_flags;
>> -	exp_info.priv = priv;
>> -
>> -	priv->dmabuf = dma_buf_export(&exp_info);
>> -	if (IS_ERR(priv->dmabuf)) {
>> -		ret = PTR_ERR(priv->dmabuf);
>> -		goto err_dev_put;
>> -	}
>> -
>> -	kref_init(&priv->kref);
>> -	init_completion(&priv->comp);
>> -
>> -	/* dma_buf_put() now frees priv */
>> -	INIT_LIST_HEAD(&priv->dmabufs_elm);
>> -	down_write(&vdev->memory_lock);
>> -	dma_resv_lock(priv->dmabuf->resv, NULL);
>> -	priv->revoked = !__vfio_pci_memory_enabled(vdev);
>> -	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>> -	dma_resv_unlock(priv->dmabuf->resv);
>> -	up_write(&vdev->memory_lock);
>> -
>>   	/*
>>   	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
>>   	 * will be released.
>> @@ -438,8 +453,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   
>>   	return ret;
>>   
>> -err_dev_put:
>> -	vfio_device_put_registration(&vdev->vdev);
>>   err_free_phys:
>>   	kfree(priv->phys_vec);
>>   err_free_priv:
>> @@ -449,6 +462,73 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	return ret;
>>   }
>>   
>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>> +				   struct vm_area_struct *vma,
>> +				   u64 phys_start, u64 req_len,
>> +				   unsigned int res_index)
>> +{
>> +	struct vfio_pci_dma_buf *priv;
>> +	const unsigned int nr_ranges = 1;
> 
> Why, versus priv->nr_ranges = 1; below?  Thanks,

Hm, a vestige from a simpler time when it was a different shape and 
unnecessary now, fixed as per suggestion.


Thanks,


Matt

> Alex
> 
>> +	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
>> +	int ret;
>> +
>> +	priv = kzalloc_obj(*priv);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>> +	if (!priv->phys_vec) {
>> +		ret = -ENOMEM;
>> +		goto err_free_priv;
>> +	}
>> +
>> +	/*
>> +	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>> +	 * start of the VMA corresponds to byte 0 of the DMABUF and
>> +	 * byte (vma_pgoff << PAGE_SHIFT) of the BAR.
>> +	 *
>> +	 * vfio_pci_dma_buf_find_pfn() reverses this offset using
>> +	 * vma_pgoff_adjust, so that ultimately a fault's offset from
>> +	 * the start of the _VMA_ has a consistent usage whether the
>> +	 * VMA originates from an mmap() of the VFIO device here or a
>> +	 * direct DMABUF mmap().
>> +	 */
>> +	priv->vdev = vdev;
>> +	priv->size = req_len;
>> +	priv->nr_ranges = nr_ranges;
>> +	priv->vma_pgoff_adjust = vma_pgoff;
>> +	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>> +	if (!priv->provider) {
>> +		ret = -EINVAL;
>> +		goto err_free_phys;
>> +	}
>> +
>> +	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
>> +	priv->phys_vec[0].len = priv->size;
>> +
>> +	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
>> +	if (ret)
>> +		goto err_free_phys;
>> +
>> +	/*
>> +	 * The VMA gets the DMABUF file so that other users can locate
>> +	 * the DMABUF via a VA.  Ownership of the original VFIO device
>> +	 * file being mmap()ed transfers to priv, and is put when the
>> +	 * DMABUF is released.
>> +	 */
>> +	priv->vfile = vma->vm_file;
>> +	vma->vm_file = priv->dmabuf->file;
>> +	vma->vm_private_data = priv;
>> +
>> +	return 0;
>> +
>> +err_free_phys:
>> +	kfree(priv->phys_vec);
>> +err_free_priv:
>> +	kfree(priv);
>> +	return ret;
>> +}
>> +
>>   void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>>   {
>>   	struct vfio_pci_dma_buf *priv;
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index c8f6f959056a..06dc0fd3e230 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -30,6 +30,7 @@ struct vfio_pci_dma_buf {
>>   	size_t size;
>>   	struct phys_vec *phys_vec;
>>   	struct p2pdma_provider *provider;
>> +	struct file *vfile;
>>   	u32 nr_ranges;
>>   	struct kref kref;
>>   	struct completion comp;
>> @@ -133,6 +134,10 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
>>   			      unsigned long address,
>>   			      unsigned int order,
>>   			      unsigned long *out_pfn);
>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>> +				   struct vm_area_struct *vma,
>> +				   u64 phys_start, u64 req_len,
>> +				   unsigned int res_index);
>>   
>>   #ifdef CONFIG_VFIO_PCI_DMABUF
>>   int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> 

