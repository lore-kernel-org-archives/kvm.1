Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774A3F0756
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168925; cv=none; b=u2qeqEwvn4aZURW1BJbDTbvOPm7JLJilqaTEco/a6ul/UtRY1NqBdUNpOhqNSos4O/n14qi3mVFhxV2FR223cSoA2RQOQsW+J7n+gS3G/thj0kYL/knXvwpIknkHzsJf5r7udOMgSVEwsj3QekdyCel2l+SNa2qmDWD8pygQC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168925; c=relaxed/simple;
	bh=GcwBPowN4P6RoMaDk1tUv4KKhhKSQTt60LOhJgxFpC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEUkwbTUlymVNuZzYonm16YLW0Hh7tGWs3gV0RoYukbeWgJSlXhHfLoLoewRUdXUA7tbrTMQCieiNwvKcGiihyrSDJiVQnU6KyfKLxcSC84pCfFgzo8RfLW+sD7WPqR5dJKqvNd59o90+GC1RUkO7rPaCpWVt+astTPb7stkGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TBT8+x/D; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TBT8+x/D"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6477apLf540140
	for <kvm@vger.kernel.org>; Thu, 7 May 2026 08:48:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7ee0kKFk8CI3AWhXFM+kSfgli3u7LAWrP2aGxa36TIM=; b=TBT8+x/DyOnF
	/jQZcsP6J8KkrIiBxC1vYorXjlDpI2msIlIRN7YnrzQ7S97+CNmrwLuLnmCG39U6
	5WGItgxSXzSKsyUK5/JeGZHK3OSCo85kwy0yA/LYWhmAGPFxnmnfU922K3jm8nIT
	D6kZnU/Jc26lv9Pyx2qJeaEuyB19C8fGbHTaxmaWGRZrReTC5Bn+8kanDEjaxT8e
	olHoml38lvu+IzEADYEmLTw8bRp7+VgZp8YJuALcWXTrcq6+ZooeGRS9oF4bA1Wg
	pcN0TocQODFgyyMk36wtNUKOTOErT/R6G4ig4mssnIp5xVNowY0gRwIekSsw70xe
	6Mknw6Euhw==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwgjh8ceg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 07 May 2026 08:48:42 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso907627f8f.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 08:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168921; x=1778773721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ee0kKFk8CI3AWhXFM+kSfgli3u7LAWrP2aGxa36TIM=;
        b=Uj5QlRlD262rCCtyO6grIOyxWngVkwtldItZJKsGtWDdjyj89xCeSObNjOWpD5vPw3
         nH246WY7jBAkwUHeOo/3+ejgbXq49uOkqCf+jQ7YELhRNkoVJtTb6AoUy0T7fJZ5ghYI
         CxYkn9rY4q6JUJIDvKGdWPqrzaTkZJDOLO+MpmY3fnfkK8y/fIgD2KOBnY+i2MLC0P8X
         L5F647KrEygh8ntS4ExTWQ43d+BMDsr27iO7H2jMCHvjgusozpwwmegw8Ob2n74v8NjK
         RNg+Za9ZcvDBvXTudU2tPaeEK47PAq57+ukdXWWIcOqmZHS0kDNVhUHmIh3/1as+TZ81
         o2yQ==
X-Forwarded-Encrypted: i=1; AFNElJ+evwL80/Tc5lhW+5pL7GjTk1N5K1Rnlr3hccXgtWTUPSr9T9bAUAjqpHIdRXADyHxAat0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2NuGpt2jIPsaTJXyV29WBBE/gHNQXN5GaMwvf0BlIWM8TC1w
	GW8PFUf5V4RAmKzslNoiTDEl0JhL1GLEVA9npCuqBhjXPRCxn55JRWGqRD2WGGvB2RSCg6rGdB/
	+qJ9CgxuaMJ4NhzLqnjEpMEMaU84sXtgV4Ucbu0+3i+0KjJO8lvu7
X-Gm-Gg: AeBDiesn7FVfnxWn1xaWSY/9NCYKfol+m6fPHl186Vd0llpgyl/dotojfACJ0SNR0y9
	6gPw5njk6Axb1IBR222ZrZi9JfBrnJcgmoSP7SFl9gnnSKergILfnvlIA1Ax7VldtliinUIiRlD
	tF89iBJ8OIla5+103ZSqbr1FU3WmtW3LWCCJ2rmZx0KxgyrqHnoOLf6slLTqhyWRlqJW+xH3PGo
	PNt7dIOQ0cIUpm5UsfG7nXFJUfp8CPGjECFytHYMpUwLUSSiZPaooShrGYU/goK5acZhdPgSCga
	nMrq2T8U8h/GIFOk5AipN7/vcV1a2bVancxd3r7cHCkxt4SWcsfJF6BE/S9pV2sNn0xdw0Vzsjt
	zwmQVCSCp1AOTtn8Az/kXQ7e/0kXYzib5MdZZQLAh4agxnjHcCeU3Hm+l93ZjDtir+foJxinNr7
	mgqWj4DjJQ3+p6sqUAzwbi1WzuvyaAiQaLCHZHOd2+YRBxAkylDgu8oOaCEJVwolZ6JLVG14gjR
	/Llnk6F4jAN9dypQtOH9QL1t/Q6XtUyKpwHwNk2tqz7
X-Received: by 2002:a5d:5f48:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-4515b056b4dmr13924634f8f.9.1778168920683;
        Thu, 07 May 2026 08:48:40 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-4515b056b4dmr13924574f8f.9.1778168920112;
        Thu, 07 May 2026 08:48:40 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2203csm21318765f8f.37.2026.05.07.08.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 08:48:39 -0700 (PDT)
Message-ID: <c746c3a7-37df-49a6-9000-a3b67ae206ab@meta.com>
Date: Thu, 7 May 2026 16:48:38 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
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
        kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-3-mattev@meta.com>
 <20260424181510.GF3444440@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424181510.GF3444440@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fcb45a cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8 a=PVx_5XRel0ZW2V4eVl8A:9
 a=QEXdDO2ut3YA:10 a=F7q00xkr9EfWfQvbdVXI:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: za-boCzsM-rpt75lfso5DHSXf4FT_R5k
X-Proofpoint-ORIG-GUID: za-boCzsM-rpt75lfso5DHSXf4FT_R5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1OCBTYWx0ZWRfX6hlUa+Mgds3h
 m7LbcsBc1qbIVKCF5mrwEKGM4xiCpYRJORS5944uwAVqmGSBNikZEWUNvj0gstCsxQpin7WGQGQ
 SKLhj+aP4up4aQhT1oHowD2d15TNk2cOBoPfJ01reqQYQn308AtGs+8cpgira28Q2jxAszrleck
 bq4oC3DGWRtEcHqOszpR/aZWCiMfj1P6bytbypLEEOjBhG/Z8CYpmw/SqrYCDNaTAcgH6E0veGZ
 fO2+4eaAME9Nm4zY9YfkAr23/YTKsoZxN9F2ItQk6R1KU2TAqHOQ99fXVqgjCrq1UH8PDbv+lPD
 ELw5a+9gm6olCpSOKfW/h7QznMkaJEagVqTSSF4FPw+P0ryfD/19lDhbafAc3nNKKSl+OoiR2Ih
 6L+GXKKvnSDRyK099bnl27e+Py/INHQ1QZwiM9lH4VslqNhpCa/psLaQOrH9Q06GaHaHDNnMOiU
 7PtUTjhLVkpJEiT9a5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01

Hi Jason,

On 24/04/2026 19:15, Jason Gunthorpe wrote:
> 
> On Thu, Apr 16, 2026 at 06:17:45AM -0700, Matt Evans wrote:
>> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
>> find a PFN.
>>
>> This supports multi-range DMABUFs, which typically would be used to
>> represent scattered spans but might even represent overlapping or
>> aliasing spans of PFNs.
>>
>> Because this is intended to be used in vfio_pci_core.c, we also need
>> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 124 ++++++++++++++++++++++++++---
>>   drivers/vfio/pci/vfio_pci_priv.h   |  19 +++++
>>   2 files changed, 130 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 04478b7415a0..8b6bae56bbf2 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -9,19 +9,6 @@
>>   
>>   MODULE_IMPORT_NS("DMA_BUF");
>>   
>> -struct vfio_pci_dma_buf {
>> -	struct dma_buf *dmabuf;
>> -	struct vfio_pci_core_device *vdev;
>> -	struct list_head dmabufs_elm;
>> -	size_t size;
>> -	struct phys_vec *phys_vec;
>> -	struct p2pdma_provider *provider;
>> -	u32 nr_ranges;
>> -	struct kref kref;
>> -	struct completion comp;
>> -	u8 revoked : 1;
>> -};
>> -
>>   static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>   				   struct dma_buf_attachment *attachment)
>>   {
>> @@ -106,6 +93,117 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>   	.release = vfio_pci_dma_buf_release,
>>   };
>>   
>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
>> +			      struct vm_area_struct *vma,
>> +			      unsigned long address,
>> +			      unsigned int order,
>> +			      unsigned long *out_pfn)
>> +{
>> +	/*
>> +	 * Given a VMA (start, end, pgoffs) and a fault address,
>> +	 * search the corresponding DMABUF's phys_vec[] to find the
>> +	 * range representing the address's offset into the VMA, and
>> +	 * its PFN.
>> +	 *
>> +	 * The phys_vec[] ranges represent contiguous spans of VAs
>> +	 * upwards from the buffer offset 0; the actual PFNs might be
>> +	 * in any order, overlap/alias, etc.  Calculate an offset of
>> +	 * the desired page given VMA start/pgoff and address, then
>> +	 * search upwards from 0 to find which span contains it.
>> +	 *
>> +	 * On success, a valid PFN for a page sized by 'order' is
>> +	 * returned into out_pfn.
>> +	 *
>> +	 * Failure occurs if:
>> +	 * - The page would cross the edge of the VMA
>> +	 * - The page isn't entirely contained within a range
>> +	 * - We find a range, but the final PFN isn't aligned to the
>> +	 *   requested order.
>> +	 *
>> +	 * (Upon failure, the caller is expected to try again with a
>> +	 * smaller order; the tests above will always succeed for
>> +	 * order=0 as the limit case.)
>> +	 *
>> +	 * It's suboptimal if DMABUFs are created with neigbouring
>> +	 * ranges that are physically contiguous, since hugepages
>> +	 * can't straddle range boundaries.  (The construction of the
>> +	 * ranges vector should merge such ranges.)
>> +	 */
>> +
>> +	const unsigned long pagesize = PAGE_SIZE << order;
>> +	unsigned long rounded_page_addr = address & ~(pagesize - 1);
> 
> ALIGN_DOWN(address, pagesize);

Oops, right, fixed.

>> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
>> +	unsigned long buf_page_offset;
>> +	unsigned long buf_offset = 0;
>> +	unsigned int i;
>> +
>> +	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
>> +		if (order > 0)
>> +			return -EAGAIN;
>> +
>> +		/* A fault address outside of the VMA is absurd. */
>> +		WARN(1, "Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
>> +		     address, vma->vm_start, vma->vm_end);
>> +		return -EFAULT;
>> +	}
>> +
>> +	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
>> +					vma->vm_pgoff << PAGE_SHIFT, &buf_page_offset)))
>> +		return -EFAULT;
> 
>> +
>> +	for (i = 0; i < vpdmabuf->nr_ranges; i++) {
>> +		size_t range_len = vpdmabuf->phys_vec[i].len;
>> +		phys_addr_t range_start = vpdmabuf->phys_vec[i].paddr;
>> +
>> +		/*
>> +		 * If the current range starts after the page's span,
>> +		 * this and any future range won't match.  Bail early.
>> +		 */
>> +		if (buf_page_offset + pagesize <= buf_offset)
>> +			break;
> 
> No overflow check on this +? If we are worried order is so large that
> the first needs a check then this would too..

In the earlier check it's not order being large but the vm_pgoff, but 
yes an overflow check wouldn't hurt here.  Added.

I've found (my) choice of variable names here awkward, and have renamed 
them to make it a bit clearer as to what's the page being searched for 
and what's the range, etc.

>> +
>> +		if (buf_page_offset >= buf_offset &&
>> +		    buf_page_offset + pagesize <= buf_offset + range_len) {
> 
>> +			/*
>> +			 * The faulting page is wholly contained
>> +			 * within the span represented by the range.
>> +			 * Validate PFN alignment for the order:
>> +			 */
>> +			unsigned long pfn = (range_start >> PAGE_SHIFT) +
>> +				((buf_page_offset - buf_offset) >> PAGE_SHIFT);
> 
> (range_start + (buf_page_offset - buf_offset)) / PAGE_SIZE;

WFM, done.

Thank you,

Matt

