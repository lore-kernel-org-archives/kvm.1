Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E8381B1D
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419014; cv=none; b=hXVajcNoHmGzwiGDWL/WhddyijPYivTBC+OijN6EX6B0vR3An5zgStmLjYOTJS33o0PK+2C5EeCFsxOJTfzEG4tqyzs+D0+QpYXWOwgjE0gZ2H+IAkBxdW74w7VtPsDOZXwIOm3w/D5N8NrvklUfW2Va0x2uq+urAd1DUEH7ZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419014; c=relaxed/simple;
	bh=xJpWp35UujKn6aZ1uwABuJdgM/gDwYMqTXRsfQGf2rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhxkKckfNNsmybt1bn/cgOm/lRvxOfgQmg4xK7mUH3eqZrOpCy1q+T9B5jrJOENehI/kNHl9pmXtlqciABjSNDEvQGyofi378sCFWE5VZ5jmSOe08ONnQRlHw02uFc4V8VvqnUw2w/9Q3OftBRiQ0o5T4+CVtweGZq9CN8ONxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=V2+ukKat; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="V2+ukKat"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 652EQsb71102090
	for <kvm@vger.kernel.org>; Tue, 2 Jun 2026 09:50:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Yehd4DhbieHxqdnPFx+C2OZiJ4/oV9ani65AADLGU2M=; b=V2+ukKatNizu
	elNZjAgnTJky/aEUl851SsfasBCLobh+ZDQjIOfSlk7ulp81uEr2qiqIi8rDoBnt
	PFCu9cCWfZiv5iVBCkHFwxzJYWXdPOCqvYZEJm6yxIEADifa8DEp9d6Zhh4Sc9l4
	qNOdk8XUXOh/y6W4+mbWPkGWXzneORHc7Ej68i7Xa1Ada9Z0rzjxMRJSNbzTsVGK
	GlH2FNXqkyjDSnbYFMKxFS1wKy5Imi6pQ/UkKMaq+ZL92H2ZwiHfIHKuvijOOzKp
	A3yaXbnjvyXNruLNrhzDR73+Rzb+NbwSVBoPUexboFCeDpBM2JfqeTLcC4BHbnmF
	q3CwwTF7eQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ej0xp11th-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 09:50:11 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304f23c55b2so4189994eec.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 09:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419010; x=1781023810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yehd4DhbieHxqdnPFx+C2OZiJ4/oV9ani65AADLGU2M=;
        b=BGMAPPCtXs759uSlW4bzmas+t0fFMWC9JmmJrYdiHdPLMv1zlHnvQRuYIRdAwbUiHv
         QJsiguThzfqROEihABNW5ophFiAsHUvCgKXIQE65CYBawtfUKIPwykYpxWW242w3NLhY
         WErLID/DGAfZ6puzZNZF0TCnV8mm2t0Ngm2Bmrn9Gaf/DN1OF713RSPzuO2pakT9T09U
         SpWWi62yZspDdaCuefBHHl3QR79MrDikpABxrzjLY7n/ZbkS2PNFvxbb3+CfTNFFbExg
         L1SSRqdRN/FcmzgQQTedN1wNP7PBHchVGcl35KaaVe92u9iXB5ku/+yIlSpeokEaQpeD
         oTSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BgLtE0T1f67IN6NNjyrf2DPRXVjH2DLmohgg7ymPg7RfQSzTEwEOLq9z3HheWfUFPJ/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuL789lHsld7In0UmYIG9tMMHoc/UJvQmVqBhH6vjnlZqDIjMh
	WOYus2mCRk+5L1tzx7JWI+qfXpcvpICkMG1tcLoHwLQMTIb7Te9OCjFIcqhv1oOzp1pzWrOv8hM
	KwsRP8ebuaBMQZnNUl9GiKcWiV7SqF/fVwrwn99cJIz8+Gnvqy9mYkDBZgx5w
X-Gm-Gg: Acq92OFKDRB3Eifz+mHBM6lR2JJO+CKUeXnnUaTHw3oVUYECBSA6nLw+IlBlw8gDpAX
	S6GZYZSs+Wt+Z6IkJua+C8X/ckTJ7Lbk/3b6LDXCc9niLFuvzHdWR39BWnQ/TitckxGbEILKmnN
	BKtdRVySRF/WLkLs+m+QD9u/3A3mDAZCuwgx2rpJlE3WtXV0s+8dN9SE0T0ElbGvzPB8kLGnnbn
	iWIK/0DCBdWzFBWI9CPQf6yX4i7z6fNvsWKkILUpAKWAcZq13BwQpszvMtL81E+6BaMrCNzjm3j
	AvIFiT/IFmgb7z5+PXP4VKiDSij5xXIeICRTFh9MFvnNVac0uMJHhAHf/kV4/NNWgF9O1xbqChU
	bdBJg2A3gTFPiLH7GwZD3Y2OtXQuJkVIVRQ/F+pNE
X-Received: by 2002:a05:7301:60b:b0:304:d32e:65e7 with SMTP id 5a478bee46e88-304fa2fc9e6mr8158002eec.0.1780419009996;
        Tue, 02 Jun 2026 09:50:09 -0700 (PDT)
X-Received: by 2002:a05:7301:60b:b0:304:d32e:65e7 with SMTP id 5a478bee46e88-304fa2fc9e6mr8157955eec.0.1780419009260;
        Tue, 02 Jun 2026 09:50:09 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm16956690eec.21.2026.06.02.09.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 09:50:08 -0700 (PDT)
Message-ID: <8854824e-06c2-43b3-86c2-8c2c28f9ad63@meta.com>
Date: Tue, 2 Jun 2026 17:50:04 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
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
 <20260527102319.100128-10-mattev@meta.com>
 <20260528171432.771a1a30@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260528171432.771a1a30@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZPHnX37b c=1 sm=1 tr=0 ts=6a1f09c3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8
 a=xAQEHcCOs6QKEQvX3i8A:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 0GYmJuaSYLgFPZmkzr0s1Fwz-CAMf--2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MyBTYWx0ZWRfX2UUHsPiVTE3F
 Lfsqi+9gftYkIQCXVw+gDwGug7d3IaAPzZtiOQruxT3dLZ+MEOdY47C9STmq/tcv3lCMeJvrsP0
 c+169gGE3Wp1BnK4rB0M2Zy8C6KVX2VJ5w834q+8VU91wsj2tyBkeTKwgSvUn+16zcB3RfQJMt2
 konomfvI6vbeCCSyBjSrUYzbCgjV1vQGY++TIuN4Z2e8yYCDtoRwjqvYKkJHHuAxSdRquiBxbw9
 GRUWGhrcHW7Rfh+7+AAIU6TJJV4WuDf48luo0E7mLQl3bqmjlv4YFIz2m6TaFOnDEzxrlpndsXv
 bFqk4RyOG8X4/rhp32mD7jmIi8rOhg/uwoOOhzagWO3p6yW+JqkSlsP/4BkAOkH2lYQEbXkA85s
 c3F7Hy/tzge+ZVfSLg/BA0rL5jKeq1gScuHTTYXktmR+2dB/X1kTlg34nIVzQYHak2o/nH53+m3
 9GM/UIJc7XMRcG5/wpA==
X-Proofpoint-ORIG-GUID: 0GYmJuaSYLgFPZmkzr0s1Fwz-CAMf--2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01

Hi Alex,

On 29/05/2026 00:14, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:12 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> A new VFIO feature, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR, is added to
>> set (and get) CPU-facing memory type attributes for a DMABUF exported
>> from vfio-pci.  These are used for subsequent mmap()s of the buffer.
>>
>> There are two attributes supported:
>>   - The default, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_UC
>>   - VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC, which results in WC
>>     PTEs for the DMABUF's BAR region.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c   |  2 +
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 70 +++++++++++++++++++++++++++++-
>>   drivers/vfio/pci/vfio_pci_priv.h   | 12 +++++
>>   include/uapi/linux/vfio.h          | 27 ++++++++++++
>>   4 files changed, 110 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 5184b3cac160..e256a925e7ce 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1590,6 +1590,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>   		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>   	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>   		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR:
>> +		return vfio_pci_core_feature_dma_buf_memattr(vdev, flags, arg, argsz);
>>   	default:
>>   		return -ENOTTY;
>>   	}
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 3fa14760898f..db8b95ddbe18 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -42,7 +42,10 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
>>   	 * contained within the DMABUF size before calling this.
>>   	 */
>>   
>> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +	if (READ_ONCE(priv->memattr) == VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC)
>> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>> +	else
>> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>   	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>>   
>>   	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
>> @@ -464,6 +467,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	priv->vdev = vdev;
>>   	priv->nr_ranges = get_dma_buf.nr_ranges;
>>   	priv->size = length;
>> +	priv->memattr = VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC;
>>   	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
>>   					     get_dma_buf.region_index,
>>   					     priv->phys_vec, dma_ranges,
>> @@ -731,4 +735,68 @@ int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev, int dmabuf_fd)
>>   
>>   	return ret;
>>   }
>> +
>> +int vfio_pci_core_feature_dma_buf_memattr(
>> +	struct vfio_pci_core_device *vdev, u32 flags,
>> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
>> +	size_t argsz)
>> +{
>> +	struct vfio_device_feature_dma_buf_memattr db_attr;
>> +	struct vfio_pci_dma_buf *priv;
>> +	struct dma_buf *dmabuf;
>> +	int ret;
>> +
>> +	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz,
>> +				 VFIO_DEVICE_FEATURE_GET |
>> +				 VFIO_DEVICE_FEATURE_SET,
>> +				 sizeof(db_attr));
> 
> I don't see why this needs to support GET.  Are we solving a userspace
> problem that doesn't exist?

Possibly, I'm a bit twitchy about unobservable/write-only internal state 
so added GET out of habit.  However, no worries, removed it and this 
function is now much lighter.

>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	if (copy_from_user(&db_attr, arg, sizeof(db_attr)))
>> +		return -EFAULT;
>> +
>> +	dmabuf = dma_buf_get(db_attr.dmabuf_fd);
>> +	if (IS_ERR(dmabuf))
>> +		return PTR_ERR(dmabuf);
>> +
>> +	/* Verify DMABUF: see comments in vfio_pci_dma_buf_revoke() */
>> +	priv = dmabuf->priv;
>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops || priv->vdev != vdev) {
>> +		ret = -ENODEV;
>> +		goto out_put_buf;
>> +	}
>> +
>> +	ret = 0;
>> +	scoped_guard(rwsem_write, &vdev->memory_lock) {
> 
> Why?  This doesn't serialize against mmap.  Just use a WRITE_ONCE() to
> match the READ_ONCE() on mmap?

Ooops, good point.  Fixed.

>> +		uint32_t old_attr = priv->memattr;
>> +
>> +		if (flags & VFIO_DEVICE_FEATURE_SET) {
>> +			switch(db_attr.memattr) {
>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
>> +				priv->memattr = db_attr.memattr;
>> +				break;
>> +
>> +			default:
>> +				ret = -ENOTSUPP;
> 
> -EINVAL

I'd like to push back on this one; ENOTSUPP distinguishes trying to use 
a wild attribute value from all manner of other screwups such as
trying to GET (with it no longer supported), passing an fd that isn't a 
DMABUF, etc.

I'm not wed to the value ENOTSUPP, just something distinctive versus the 
other errors userspace might see, and that value seems appropriate.

>> +			}
>> +		}
>> +		db_attr.memattr = old_attr;
>> +	}
>> +
>> +	if (!ret && (flags & VFIO_DEVICE_FEATURE_GET)) {
>> +		if (copy_to_user(arg, &db_attr, sizeof(db_attr)))
>> +			ret = -EFAULT;
>> +	}
>> +
>> + out_put_buf:
>> +	dma_buf_put(dmabuf);
>> +
>> +	return ret;
>> +
>> +}
>>   #endif /* CONFIG_VFIO_PCI_DMABUF */
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index a1e0f4fcb1dc..8067be45beb0 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -41,6 +41,7 @@ struct vfio_pci_dma_buf {
>>   	struct kref kref;
>>   	struct completion comp;
>>   	unsigned long vma_pgoff_adjust;
>> +	u32 memattr;
>>   	enum vfio_pci_dma_buf_status status;
>>   };
>>   
>> @@ -154,6 +155,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>>   int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   				  struct vfio_device_feature_dma_buf __user *arg,
>>   				  size_t argsz);
>> +int vfio_pci_core_feature_dma_buf_memattr(
>> +	struct vfio_pci_core_device *vdev, u32 flags,
>> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
>> +	size_t argsz);
>>   int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev, int dmabuf_fd);
>>   #else
>>   static inline int
>> @@ -163,6 +168,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   {
>>   	return -ENOTTY;
>>   }
>> +static inline int vfio_pci_core_feature_dma_buf_memattr(
>> +	struct vfio_pci_core_device *vdev, u32 flags,
>> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
>> +	size_t argsz)
>> +{
>> +	return -ENODEV;
> 
> -ENOTTY

Gotcha, fixed.  Yes, that's quite conspicuous versus the chunk above, 
unsure where I got that from.


Thank you,


Matt


> 
> Thanks,
> Alex
> 
>> +}
>>   static inline int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev,
>>   					  int dmabuf_fd)
>>   {
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 02366e9f8e16..9b0b68f8a1ef 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1564,6 +1564,33 @@ struct vfio_device_feature_dma_buf {
>>    */
>>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>   
>> +/**
>> + * Given a dma_buf fd previously created by
>> + * VFIO_DEVICE_FEATURE_DMA_BUF, GET or SET the memory attribute that
>> + * will be used by future mmap()s of that fd.  SETting a new attribute
>> + * does not affect existing VMAs.
>> + *
>> + * The default, if no previous SET has been performed, is NC.
>> + *
>> + * Return: 0 on success, -1 and errno is set on failure:
>> + *
>> + *  ENOTSUPP: The given memattr is not supported.
>> + *  EBADF, EINVAL: dmabuf_fd is not a DMABUF fd.
>> + *  ENODEV: The dmabuf_fd does not match this VFIO device.
>> + */
>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR 13
>> +
>> +/* Valid memory attributes for the memattr field */
>> +enum vfio_device_dma_buf_memattr {
>> +	VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC = 0, /* pgprot_noncached */
>> +	VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC = 1, /* pgprot_writecombine */
>> +};
>> +
>> +struct vfio_device_feature_dma_buf_memattr {
>> +	__s32	dmabuf_fd;
>> +	__u32	memattr;
>> +};
>> +
>>   /* -------- API for Type1 VFIO IOMMU -------- */
>>   
>>   /**
> 

