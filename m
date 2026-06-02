Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79183F54C4
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419735; cv=none; b=i+DUe6EbX2MLhKxG2OAjEpcvuIyul14mmqyqHXzXmVSADY2GULX7IuzUsaae6vdPX9IuOP4kvvYBhnE0AkLwnJbjE0eFNAVhao3qHpajUKx8gGhFlUIp0Ets3iOFHntxXOGn3HdGLkJFtdVqvx+YLKau7KiTmHlUHqaFQInsKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419735; c=relaxed/simple;
	bh=QoiZ5s3nsTX2RZ3lY2iPkpWmEx4y8HhzoqqHrMXAIKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CePv1XvjDUAPfbQSa3Kzt1QVO/UFLDIgtmaXAXdlxlYmm5xi+C/nkTZgGJ1E0x+Fe0cmW4uYSkx4m1KtuHjyfGyhh0PHD0yxyB2EPW5Q6eTCrH2u48AOQ1WnwVuaOvjXA25F8EflD2Z6oTfYOouSQPbuHUySmI70EGj2fwNsUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ViSjkENP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ViSjkENP"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652EP1rU1179018
	for <kvm@vger.kernel.org>; Tue, 2 Jun 2026 10:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mTYKb0c2954a2IzM1HRVxcz2DRIaoZF0Pm/6896rHzM=; b=ViSjkENPdpm0
	mTZGkLeQms53yzkIiUkChWZKbueQCaC0CVVr5v3wUjD9JtfJvfAgYgyrOB592R+A
	/bZE1g4JlV97pWTZtW73p4zAwtGYaJuoHguKhqmMls8WZM5RAWVICbV9o12oHqqH
	fSCO2Pow6M9ams+YOFrgXkoSXB/PSdHVD74/J1Vnyn1YfMPxiPwyYsNGqP6TDjDi
	a9PCxB4bp2qpV767oyL4NInphwB1EsRHtlXZ76MT/rtQVjOGW234X8S+JXrEsK5D
	uLFjUxKkJfTkNQkuwkg53EeakRUNJiGqR92u/jX9UL1s3qYS7lXzZvILIsXcWNgO
	Yxv8SPYXQA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej0wsh5cv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 10:02:12 -0700 (PDT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304c652be4eso4134081eec.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 10:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419732; x=1781024532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTYKb0c2954a2IzM1HRVxcz2DRIaoZF0Pm/6896rHzM=;
        b=GZH/vsXopQiNg7yytwc/R7Ll1QZkfMxRmGuQd+NrsjwfMZ3dEPDKJ5UlaOB61Eawed
         hPg2j99hXFQHUM3SpTeN7WGrpSe1W9kBKCC0ij15XCawZjpMPmwvR8I00xEW4KT1u2N1
         lcFDBw6NHTahS5jSCiK1pkzI9AN4IZ5/ZtQ5cg4/NcuZIvgIegGV3b+UrH6LGVk3rI9s
         pYb/hJLjVZshGwEj8tID/62oWTMiH10fakwgdsAIE8sXHS+85j9+7ZG4rFAELDZIZgQ4
         GgDb4SzMaYUm/ZMtgY/QPIfOQX2J8cVLk3TmJb1cOh5h096F2ZtFeX+/p98+WjSNfuUm
         XbGw==
X-Forwarded-Encrypted: i=1; AFNElJ+jLZb9L8+k46SN4r2PaXBbqpjUW34VAUMRbfQqcwM+xiO4aYVFGFsT8kuLdfIU48sdLnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaTkV32f+o6hHJVjDtES8FWL1YaPZwwRilegcYUwlzaWo9EvR5
	cp/7axRknuOOYS2vjqb6o9cEddfgp/66zICkyoRhah38fJFDZNd0fYGviFQ6BLiQi2Xy0tdfWOh
	UfdUqGdpurDs0TaqE9TNuez38Et/ZcvfnJj0qJQAVzsJCkIGRLWYj
X-Gm-Gg: Acq92OEMSK4phJFJRKCnOaqzLq7eEGLYqoCVPVmTGZpF0ISvZBmUdtbUiJQ8Xro301C
	DJyvERTiVRJhNvL5B84jaWhNx+FDEp1JDPsjwqQ94ShD7/hdNxMJ5zZHBbkAF7IOiVNe0qH484m
	t4wuB43eX7BpVhjgi5TyzZdYgSqFGe64+rLiYLIZJJUp/fKPZ+/Ok18DrCGYOT3m36lMcRTvbUt
	yR2+jwNQeQmaMEozkLodM+RbRYIrgXMxbeJvH1GhuZaJ1rkpTcVqWZPnAnxaABxM/uu+1OUDZoj
	HH6dEV7bmRDfCu0N3w5H9NCfszPVXI5L5Xhl490YTTFtd9ewQ+pdJ1BlLRUQyU4GZgvLKtjlr9F
	B+uFTJ+kYS0aKL0eMYibQkYxDVYDxIxs2PcNCTKqb
X-Received: by 2002:a05:7022:619a:b0:134:d3bc:b4b4 with SMTP id a92af1059eb24-137f589791bmr65298c88.4.1780419730938;
        Tue, 02 Jun 2026 10:02:10 -0700 (PDT)
X-Received: by 2002:a05:7022:619a:b0:134:d3bc:b4b4 with SMTP id a92af1059eb24-137f589791bmr65150c88.4.1780419728585;
        Tue, 02 Jun 2026 10:02:08 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f549bbefsm233306c88.4.2026.06.02.10.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:02:08 -0700 (PDT)
Message-ID: <cd3361a2-8d85-45f9-b6ee-ffd6cbb48f8f@meta.com>
Date: Tue, 2 Jun 2026 18:02:02 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] vfio/pci: Permanently revoke a DMABUF on request
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
 <20260527102319.100128-9-mattev@meta.com>
 <20260528171446.544fc486@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260528171446.544fc486@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aJfAb79m c=1 sm=1 tr=0 ts=6a1f0c94 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8
 a=yuPZ2VO11UlYrN-Tx1EA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: e-n8m9OqhGckjnERQxvETBfjZQxiwTH6
X-Proofpoint-ORIG-GUID: e-n8m9OqhGckjnERQxvETBfjZQxiwTH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2NCBTYWx0ZWRfX9M40GP3tPqD0
 5kRT8hefmd+pEIRALWZdNQ4PSemjH983m3WHFuQN+Cuq3h9q6BRq7ITivNWAYik9Ie2OpDARcW9
 DsL6JsmZSxqoEUirSaEJxGZOgS7cLTx/P8CcToyJeVZMYsE4PG3sIEDlXL5TtZR6JQswAHD8peF
 K1gFSUd4wZbenl+Pa5TzMC355BOBhj0o2EhNuDOTtUrf5osnPAmlJw7EWbLHMfezHhekg6fCbJO
 ZrWaPITasPZmDM+RrGw9mmv8UWdqtGnZUs2BJ2ceCNLDqFdXAMAW16dwUQasTnoj37fqRNNvbFS
 yRFHkNgJamgNo1qiHwQX1a6zz3h0hJPD9TwIz5cLbgzZDoLjBPvdrVrKKaAMtjoxh81EieUvPlY
 Vzo6x5V55gWQQzcO2lFDOAZWi2nU9Ob/kafXF6W0fGqVoq6jm5Z6KOlPpMKdYRT5Yy3eGBQDryi
 jGEZBF3rXrts5Gbudhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01

Hi Alex,

On 29/05/2026 00:14, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:11 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Expand the VFIO DMABUF revocation state to three states:
>> Not revoked, temporarily revoked, and permanently revoked.
>>
>> The first two are for existing transient revocation, e.g. across a
>> function reset, and the DMABUF is put into the last in response to a
>> new ioctl(VFIO_DEVICE_PCI_DMABUF_REVOKE) request.
> 
> The DMABUF is created via a VFIO_DEVICE_FEATURE ioctl and you next
> patch is setting attributes via another VFIO_DEVICE_FEATURE, why would
> the REVOKE operation not also be a VFIO_DEVICE_FEATURE?

I was possibly reading too much into VFIO features tending to have 
GET/SET semantics (accessor-like) rather than DO_THING.  But sure, a 
revocation SETs a new buffer state so it makes sense.

I've converted the revoke operation to a SET on a new 
VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE, and looks more nicely contained.

>> This VFIO device fd ioctl() passes a DMABUF by fd and requests that
>> the DMABUF is permanently revoked.  On success, it's guaranteed that
>> the buffer can never be imported/attached/mmap()ed in future, that
>> dynamic imports have been cleanly detached, and that all mappings have
>> been made inaccessible/PTEs zapped.
>>
>> This is useful for lifecycle management, to reclaim VFIO PCI BAR
>> ranges previously delegated to a subordinate client process: The
>> driver process can ensure that the loaned resources are revoked when
>> the client is deemed "done", and exported ranges can be safely re-used
>> elsewhere.
>>
>> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
>> function common to move and the new ioctl path.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c   |  21 ++++-
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 146 +++++++++++++++++++++--------
>>   drivers/vfio/pci/vfio_pci_priv.h   |  14 ++-
>>   include/uapi/linux/vfio.h          |  30 ++++++
>>   4 files changed, 170 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 41e049fa9a8a..5184b3cac160 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1500,6 +1500,21 @@ static int vfio_pci_ioctl_ioeventfd(struct vfio_pci_core_device *vdev,
>>   				  ioeventfd.fd);
>>   }
>>   
>> +static int vfio_pci_ioctl_dmabuf_revoke(struct vfio_pci_core_device *vdev,
>> +					struct vfio_pci_dmabuf_revoke __user *arg)
>> +{
>> +	unsigned long minsz = offsetofend(struct vfio_pci_dmabuf_revoke, dmabuf_fd);
>> +	struct vfio_pci_dmabuf_revoke revoke;
>> +
>> +	if (copy_from_user(&revoke, arg, minsz))
>> +		return -EFAULT;
>> +
>> +	if (revoke.argsz < minsz)
>> +		return -EINVAL;
>> +
>> +	return vfio_pci_dma_buf_revoke(vdev, revoke.dmabuf_fd);
>> +}
>> +
>>   long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
>>   			 unsigned long arg)
>>   {
>> @@ -1522,6 +1537,8 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
>>   		return vfio_pci_ioctl_reset(vdev, uarg);
>>   	case VFIO_DEVICE_SET_IRQS:
>>   		return vfio_pci_ioctl_set_irqs(vdev, uarg);
>> +	case VFIO_DEVICE_PCI_DMABUF_REVOKE:
>> +		return vfio_pci_ioctl_dmabuf_revoke(vdev, uarg);
>>   	default:
>>   		return -ENOTTY;
>>   	}
>> @@ -1792,7 +1809,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>>   	dma_resv_lock(priv->dmabuf->resv, NULL);
>>   	vdev = READ_ONCE(priv->vdev);
>>   
>> -	if (priv->revoked || !vdev) {
>> +	if (priv->status != VFIO_PCI_DMABUF_OK || !vdev) {
>>   		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
>>   				     __func__, vmf->address, vma->vm_pgoff);
>>   		dma_resv_unlock(priv->dmabuf->resv);
>> @@ -1815,7 +1832,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>>   
>>   	scoped_guard(rwsem_read, &vdev->memory_lock) {
>>   		/* Revocation status must be re-read, under memory_lock */
>> -		if (!priv->revoked) {
>> +		if (priv->status == VFIO_PCI_DMABUF_OK) {
>>   			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
>>   							     vmf->address,
>>   							     order, &pfn);
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 4b3b15655f1d..3fa14760898f 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -19,7 +19,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>   	if (!attachment->peer2peer)
>>   		return -EOPNOTSUPP;
>>   
>> -	if (priv->revoked)
>> +	if (priv->status != VFIO_PCI_DMABUF_OK)
>>   		return -ENODEV;
>>   
>>   	if (!dma_buf_attach_revocable(attachment))
>> @@ -32,7 +32,7 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
>>   {
>>   	struct vfio_pci_dma_buf *priv = dmabuf->priv;
>>   
>> -	if (priv->revoked)
>> +	if (priv->status != VFIO_PCI_DMABUF_OK)
>>   		return -ENODEV;
>>   	if ((vma->vm_flags & VM_SHARED) == 0)
>>   		return -EINVAL;
>> @@ -72,7 +72,7 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>>   
>>   	dma_resv_assert_held(priv->dmabuf->resv);
>>   
>> -	if (priv->revoked)
>> +	if (priv->status != VFIO_PCI_DMABUF_OK)
>>   		return ERR_PTR(-ENODEV);
>>   
>>   	ret = dma_buf_phys_vec_to_sgt(attachment, priv->provider,
>> @@ -287,7 +287,8 @@ static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
>>   	INIT_LIST_HEAD(&priv->dmabufs_elm);
>>   	down_write(&vdev->memory_lock);
>>   	dma_resv_lock(priv->dmabuf->resv, NULL);
>> -	priv->revoked = !__vfio_pci_memory_enabled(vdev);
>> +	priv->status = __vfio_pci_memory_enabled(vdev) ? VFIO_PCI_DMABUF_OK :
>> +		VFIO_PCI_DMABUF_TEMP_REVOKED;
>>   	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>>   	dma_resv_unlock(priv->dmabuf->resv);
>>   	up_write(&vdev->memory_lock);
>> @@ -318,7 +319,7 @@ int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
>>   		return -EOPNOTSUPP;
>>   
>>   	priv = attachment->dmabuf->priv;
>> -	if (priv->revoked)
>> +	if (priv->status != VFIO_PCI_DMABUF_OK)
>>   		return -ENODEV;
>>   
>>   	/* More than one range to iommufd will require proper DMABUF support */
>> @@ -585,6 +586,63 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>   	return ret;
>>   }
>>   
>> +static void __vfio_pci_dma_buf_revoke(struct vfio_pci_dma_buf *priv, bool revoked,
>> +				      bool permanently)
> 
> If the underscore prefix is mean to imply the lock semantics, that's
> explicit with the annotation below and can be dropped.
> 
> The double bool args are not very intuitive to use and the [false,
> true] combination is rather invalid.  Why not an enum:
> 
> enum vfio_pci_dma_buf_revoke_action {
> 	VFIO_PCI_DMABUF_REVOKE_RESTORE,
> 	VFIO_PCI_DMABUF_REVOKE_TEMPORARY,
> 	VFIO_PCI_DMABUF_REVOKE_PERMANENT,
> };

That's a fair comment.  I've reframed this helper as setting the 
revocation state, and callers pass in one of the existing enum 
vfio_pci_dma_buf_status values which neatens it up a lot.  (See '^^^' 
below.)

>> +{
>> +	bool was_revoked;
>> +
>> +	lockdep_assert_held_write(&priv->vdev->memory_lock);
>> +
>> +	if ((priv->status == VFIO_PCI_DMABUF_PERM_REVOKED) ||
>> +	    (priv->status == VFIO_PCI_DMABUF_OK && !revoked) ||
>> +	    (priv->status == VFIO_PCI_DMABUF_TEMP_REVOKED && revoked && !permanently)) {
>> +		return;
>> +	}
>> +
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>> +	was_revoked = priv->status != VFIO_PCI_DMABUF_OK;
>> +
>> +	if (revoked)
>> +		priv->status = permanently ? VFIO_PCI_DMABUF_PERM_REVOKED :
>> +			VFIO_PCI_DMABUF_TEMP_REVOKED;
>> +
>> +	/*
>> +	 * If TEMP_REVOKED is being upgraded to PERM_REVOKED, the
>> +	 * buffer is already gone.  Don't wait on it again.
>> +	 */
>> +	if (was_revoked && revoked) {
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return;
>> +	}
>> +
>> +	dma_buf_invalidate_mappings(priv->dmabuf);
>> +	dma_resv_wait_timeout(priv->dmabuf->resv,
>> +			      DMA_RESV_USAGE_BOOKKEEP, false,
>> +			      MAX_SCHEDULE_TIMEOUT);
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +	if (revoked) {
>> +		kref_put(&priv->kref, vfio_pci_dma_buf_done);
>> +		wait_for_completion(&priv->comp);
>> +		unmap_mapping_range(priv->dmabuf->file->f_mapping,
>> +				    0, priv->size, 1);
>> +		/*
>> +		 * Re-arm the registered kref reference and the
>> +		 * completion so the post-revoke state matches the
>> +		 * post-creation state.  An un-revoke followed by a
>> +		 * new mapping needs the kref to be non-zero before
>> +		 * kref_get(), and vfio_pci_dma_buf_cleanup()
>> +		 * delegates its drain back through this revoke
>> +		 * path on a possibly-already-revoked dma-buf.
>> +		 */
>> +		kref_init(&priv->kref);
>> +		reinit_completion(&priv->comp);
>> +	} else {
>> +		dma_resv_lock(priv->dmabuf->resv, NULL);
>> +		priv->status = VFIO_PCI_DMABUF_OK;
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +	}
>> +}
>> +
>>   void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>>   {
>>   	struct vfio_pci_dma_buf *priv;
>> @@ -593,44 +651,13 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>>   	lockdep_assert_held_write(&vdev->memory_lock);
>>   	/*
>>   	 * Holding memory_lock ensures a racing VMA fault observes
>> -	 * priv->revoked properly.
>> +	 * priv->status properly.
>>   	 */
>>   
>>   	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>>   		if (!get_file_active(&priv->dmabuf->file))
>>   			continue;
>> -
>> -		if (priv->revoked != revoked) {
>> -			dma_resv_lock(priv->dmabuf->resv, NULL);
>> -			if (revoked)
>> -				priv->revoked = true;
>> -			dma_buf_invalidate_mappings(priv->dmabuf);
>> -			dma_resv_wait_timeout(priv->dmabuf->resv,
>> -					      DMA_RESV_USAGE_BOOKKEEP, false,
>> -					      MAX_SCHEDULE_TIMEOUT);
>> -			dma_resv_unlock(priv->dmabuf->resv);
>> -			if (revoked) {
>> -				kref_put(&priv->kref, vfio_pci_dma_buf_done);
>> -				wait_for_completion(&priv->comp);
>> -				unmap_mapping_range(priv->dmabuf->file->f_mapping,
>> -						    0, priv->size, 1);
>> -				/*
>> -				 * Re-arm the registered kref reference and the
>> -				 * completion so the post-revoke state matches the
>> -				 * post-creation state.  An un-revoke followed by a
>> -				 * new mapping needs the kref to be non-zero before
>> -				 * kref_get(), and vfio_pci_dma_buf_cleanup()
>> -				 * delegates its drain back through this revoke
>> -				 * path on a possibly-already-revoked dma-buf.
>> -				 */
>> -				kref_init(&priv->kref);
>> -				reinit_completion(&priv->comp);
>> -			} else {
>> -				dma_resv_lock(priv->dmabuf->resv, NULL);
>> -				priv->revoked = false;
>> -				dma_resv_unlock(priv->dmabuf->resv);
>> -			}
>> -		}
>> +		__vfio_pci_dma_buf_revoke(priv, revoked, false);
>>   		fput(priv->dmabuf->file);
>>   	}
>>   }
>> @@ -662,3 +689,46 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>>   	}
>>   	up_write(&vdev->memory_lock);
>>   }
>> +
>> +#ifdef CONFIG_VFIO_PCI_DMABUF
>> +int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev, int dmabuf_fd)
>> +{
>> +	struct vfio_pci_dma_buf *priv;
>> +	struct dma_buf *dmabuf;
>> +	int ret = 0;
>> +
>> +	dmabuf = dma_buf_get(dmabuf_fd);
>> +	if (IS_ERR(dmabuf))
>> +		return PTR_ERR(dmabuf);
>> +
>> +	priv = dmabuf->priv;
>> +	/*
>> +	 * Sanity-check the DMABUF is really a vfio_pci_dma_buf _and_
>> +	 * relates to the VFIO device it was provided with.
>> +	 *
>> +	 * If the DMABUF relates to this vdev then priv->vdev is
>> +	 * stable because this open fd prevents cleanup.
>> +	 *
>> +	 * If it relates to a different vdev, reading priv->vdev might
>> +	 * race with a concurrent cleanup on that device.  But if so,
>> +	 * it points to a non-matching vdev or NULL and is unusable
>> +	 * either way.
>> +	 */
>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops || priv->vdev != vdev) {
>> +		ret = -ENODEV;
>> +		goto out_put_buf;
>> +	}
>> +
>> +	scoped_guard(rwsem_write, &vdev->memory_lock) {
>> +		if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED)
>> +			ret = -EBADFD;
>> +		else
>> +			__vfio_pci_dma_buf_revoke(priv, true, true);
>> +	}
>> +
>> + out_put_buf:
>> +	dma_buf_put(dmabuf);
>> +
>> +	return ret;
>> +}
>> +#endif /* CONFIG_VFIO_PCI_DMABUF */
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index db2e2aeae88f..a1e0f4fcb1dc 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -23,6 +23,12 @@ struct vfio_pci_ioeventfd {
>>   	bool			test_mem;
>>   };
>>   
>> +enum vfio_pci_dma_buf_status {
>> +	VFIO_PCI_DMABUF_OK = 0,
>> +	VFIO_PCI_DMABUF_TEMP_REVOKED = 1,
>> +	VFIO_PCI_DMABUF_PERM_REVOKED = 2,
>> +};

^^^ Here ^^^

>> +
>>   struct vfio_pci_dma_buf {
>>   	struct dma_buf *dmabuf;
>>   	struct vfio_pci_core_device *vdev;
>> @@ -35,7 +41,7 @@ struct vfio_pci_dma_buf {
>>   	struct kref kref;
>>   	struct completion comp;
>>   	unsigned long vma_pgoff_adjust;
>> -	u8 revoked : 1;
>> +	enum vfio_pci_dma_buf_status status;
>>   };
>>   
>>   extern const struct vm_operations_struct vfio_pci_mmap_ops;
>> @@ -148,6 +154,7 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>>   int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   				  struct vfio_device_feature_dma_buf __user *arg,
>>   				  size_t argsz);
>> +int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev, int dmabuf_fd);
>>   #else
>>   static inline int
>>   vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>> @@ -156,6 +163,11 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   {
>>   	return -ENOTTY;
>>   }
>> +static inline int vfio_pci_dma_buf_revoke(struct vfio_pci_core_device *vdev,
>> +					  int dmabuf_fd)
>> +{
>> +	return -ENODEV;
>> +}
>>   #endif
>>   
>>   #endif
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..02366e9f8e16 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1321,6 +1321,36 @@ struct vfio_precopy_info {
>>   
>>   #define VFIO_MIG_GET_PRECOPY_INFO _IO(VFIO_TYPE, VFIO_BASE + 21)
>>   
>> +/**
>> + * VFIO_DEVICE_PCI_DMABUF_REVOKE - _IO(VFIO_TYPE, VFIO_BASE + 22)
>> + *
>> + * This ioctl is used on the device FD, and requests that access to
>> + * the buffer corresponding to the DMABUF FD parameter is immediately
>> + * and permanently revoked.  On successful return, the buffer is not
>> + * accessible through any mmap() or dma-buf import.  The request fails
>> + * if the buffer is pinned; otherwise, the exporter marks the buffer
>> + * as inaccessible and uses the move_notify callback to inform
>> + * importers of the change.  The buffer is permanently disabled, and
>> + * VFIO refuses all map, mmap, attach, etc. requests.
>> + *
>> + * Returns:
>> + *
>> + * Return: 0 on success, -1 and errno set on failure:
>> + *
>> + *  ENODEV if the associated dmabuf FD no longer exists/is closed,
> 
> These actually seem to map to EBADF/EINVAL.  Thanks,

OK, these go away when moving to use a VFIO feature for revocation.


Thanks,


Matt


> 
> Alex
> 
>> + *         or is not a DMABUF created for this device.
>> + *  EINVAL if the dmabuf_fd parameter isn't a DMABUF.
>> + *  EBADF if the dmabuf_fd parameter isn't a valid file number.
>> + *  EBADFD if the buffer has already been revoked.
>> + *
>> + */
>> +struct vfio_pci_dmabuf_revoke {
>> +	__u32 argsz;
>> +	__s32 dmabuf_fd;
>> +};
>> +
>> +#define VFIO_DEVICE_PCI_DMABUF_REVOKE _IO(VFIO_TYPE, VFIO_BASE + 22)
>> +
>>   /*
>>    * Upon VFIO_DEVICE_FEATURE_SET, allow the device to be moved into a low power
>>    * state with the platform-based power management.  Device use of lower power
> 

