Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DB342CB0
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567678; cv=none; b=Yy09Y7xh3hy+zmdQUMD4WWLR1tGEANY1+W/bG8Kk5/sK8zL+ymMkRHirzzHXKrruzQvEFhBsLAcncTxflGFEozuqSnpZ0Mw3cTRFkIoRpH60KniTZ5xaLah5i7RisCDR/dBTpBHEDanofRwQtGQJV6xzjEDEyDdvqOYtWhfR6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567678; c=relaxed/simple;
	bh=cSGNZ8wgbO7X87rwVZjWUPh3PFb7JnuVVs+4c9CzkS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SicY7uwk3xhN6pL09WcGhrTedQ5gb7j5kEE5Lz08cNSEGNmJ4mVojFNMjmlf9ux7MG/tQ/N910g2eXXuNm/YgjmBU43Xr44ypJuB0GnRmUSabRGj/oiEr/sF2e00hpgeFHwcFDRsfhxHdgrWeyxNnz8xEy7aEHec4b1ksoAmoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VmzmDuLo; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VmzmDuLo"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UDB8P84182341
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 09:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CXvj6rmLtU+yqG7K5nb8uAhPCFMrTB1Lg0tTO/8UY38=; b=VmzmDuLofwCN
	XcDBoa+sLJlHhfy6vjpvEjX9zOHYSohipMJKuWABb0/tFAgCYvUKYRmq1VYJYrm+
	YyffbepmXjCagGPySLIrmaJ5SWJEIM+OBHitW/S1gBzRFsRT6oc2SxOGzvzDzjUw
	92vNwrtouQ3cYeinUfudEAWZWLyl6zwoda8rflkF4cjAWAFZesr61T3Px2BTqwDf
	hF6OXYCAbJd2TYHTf+LHNX+8OiYQxHtTHKnZa33UUllCmQi1/95LKvMZ1J2xd6Ve
	2O6g8ywmcBylHs0F9CFe3Ys6hZVRNSwGu5ttT4tnlutyOtT7x9qVVAEtvsvTkoVC
	pXi+P7srPw==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drsn3behs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 09:47:55 -0700 (PDT)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso7860825e9.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 09:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567674; x=1778172474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXvj6rmLtU+yqG7K5nb8uAhPCFMrTB1Lg0tTO/8UY38=;
        b=Be+aRVk0V7YJIsbQO+6BY9lATwG/PP+fe5c6v8/7vwKQWxZ8sM5LVc9lSy3lZzcmso
         sXR5Kx1x5HfU/ThTrJapF5ZbZFGplGBBpUIAeSzUH4tqsofztOtCq8E/+gN3Zr32dhM6
         WbNtsriypMdDbWcGoTqrCQC8zwuRQQ3WuQ2Rhj1AywVPUejrHeu1k0iFyZcxvX08BGRX
         d6j6o59SePjyDMY9Oon+8XtHDOHTtkGdAEnIsSZBEN8NskPJJ7iJLS4eWv2HDYJG9HWE
         jmMR1LjGaNO1qbNdMYH4m3VIZ+Gu5uiABGP63M+7QUC7JoVvfLAZMt1em+rhit9Lqae/
         00Vw==
X-Forwarded-Encrypted: i=1; AFNElJ9tamvSlzYrS7ITloVtrgcIFixDQZ0o0rxM4lg0010lVA1Pr7NpdfglPlBp3Uyz1ZJNCNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1DfSTsVq0t9FHsXoB1r71EC9u/HSLT29pHSulJxYY0+L06P9
	FHFS3yp17CI9RP4WK8xuOKGye/x0u3L/NLgcBQ4qzVNQtItnbHkKQcUWuOQMCdIrr1bZ9o+2PTY
	P7IXGaiR13/BBG3HQ8AoihPHRJLW35ZRA5bfJbsZ/b8a1lEggRRge
X-Gm-Gg: AeBDieuy9YyZJ+tTmjSc3r3uanKW2Mrp0EQN6sMGzChIhud80cAgv3fIQh763elODmh
	IgRhjEb8ZmRPMeGbPTlCHjUE802r4Vw5AdsU3eWj1QtUgDUh3IzhReImisjHpn0RCr62DQ09XYs
	S0HHKBfsbXKs1Njh5TB9/CSjlSe85sl7H8gq0VANciAbCJo2+cnTlU7K1pHLrXr3rVh3m95sd+3
	vkgrED6f+qrd4a8wvr97UCCtL8bgwFrND7vqn6MNe0DZ8mQjNsSJ23WFH7e2ZW6DdQmoGdAm7kJ
	Q1mFthJAlf1U/YQjy1KtlNkrd+cOwrI8AZoTP5ozPstd1HY+R1yOaYDapTHBGvn7uUMi7oynRc+
	NrBtFdk7O/ZQaRU9uCnU/LT+tuaULH5d2CqbbuGD8vC1nEvfBpsxBVWFko8hwfCo0z04V3cQUvl
	nh
X-Received: by 2002:a05:600c:8483:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48a83d73324mr65498765e9.8.1777567673953;
        Thu, 30 Apr 2026 09:47:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8483:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48a83d73324mr65498015e9.8.1777567673394;
        Thu, 30 Apr 2026 09:47:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:10fb:be93:502f:b7be? ([2620:10d:c092:500::4:5cf3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822c82f2sm75353315e9.11.2026.04.30.09.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 09:47:52 -0700 (PDT)
Message-ID: <c598a21e-ee50-42d9-98dc-2959e84ace50@meta.com>
Date: Thu, 30 Apr 2026 17:47:49 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
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
 <20260416131815.2729131-4-mattev@meta.com>
 <20260424182426.GG3444440@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424182426.GG3444440@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE3MiBTYWx0ZWRfX94YEu9II3EVS
 v2rkmzDolTeHMCSmJVf1QtM6FaetcZFoSfHV3wIjIMBN6rcqjGrbKnGyyCoE6I1r97hz3oijKus
 l66zT5K7NIK+TlhTWmStgxOjBtldRlA1sQ1GUuS/LneXUDi3poktC2m+Xun4fRBR+XaccVblDr/
 F6UWyK//eyyhCuo1cd5SYUlgsZu8QhQdY9Jx7dsvs0ebhTcO5fQTgEDXByGTCP4xpQmpg5HnPWe
 IqFtqWc8N1Y3Ob9VkMoO2Oq+PsztEntk2yCIOlF3b8FEjMwfvgKCd7jHkm8AEfw8JDoZFT6fwEz
 /Q3fNUBRs8ru5jE3419ONeEpdNg0qUj9dmwCdeaN8ZCiFnPKj/o8nI1vA7pjPWUPAVaLgRCINTy
 xOjJTT6tM4Krto0vIx+uPIpDwbWhv9I2B3l09u50FNiePpFKp/kS0N4m45uYhSBEm2xHXCzmhPv
 gGRZ1+0dhUsnnvcJndQ==
X-Authority-Analysis: v=2.4 cv=NoDhtcdJ c=1 sm=1 tr=0 ts=69f387bb cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=Dv35txUGz5gI0hTa:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=nxdftAbHouV8PAc5HfQA:9
 a=QEXdDO2ut3YA:10 a=nJq5_VNI1X7IEIKzvdHs:22
X-Proofpoint-GUID: v4i32CaDZNCejJ504Av6tAG7-1GoWh-F
X-Proofpoint-ORIG-GUID: v4i32CaDZNCejJ504Av6tAG7-1GoWh-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01

Hi Jason,

On 24/04/2026 19:24, Jason Gunthorpe wrote:
> 
> On Thu, Apr 16, 2026 at 06:17:46AM -0700, Matt Evans wrote:
>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>> +				   struct vm_area_struct *vma,
>> +				   u64 phys_start, u64 req_len,
>> +				   unsigned int res_index)
>> +{
>> +	struct vfio_pci_dma_buf *priv;
>> +	const unsigned int nr_ranges = 1;
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
>> +	 * The mmap() request's vma->vm_offs might be non-zero, but
>> +	 * the DMABUF is created from _offset zero_ of the BAR.  The
>> +	 * portion between zero and the vm_offs is inaccessible
>> +	 * through this VMA, but this approach keeps the
>> +	 * /proc/<pid>/maps offset somewhat consistent with the
>> +	 * pre-DMABUF code.  Size includes the offset portion.
> 
> I'm not sure I understand this comment?
> 
> For the old path vm_pgoff for byte 0 of the bar starts at some large
> offset
> 
> For the new path vm_pgoff for byte 0 of the first range starts at 0

Glad you asked.  :)

This is trying to achieve keeping /proc/<pid>/maps (or similar) somewhat
as informative as pre-DMABUF BAR mmap, in terms of keeping the VMA
vm_offs column useful.  Before this patch, say you mmap() two slices A
and B of the same BAR:

  struct vfio_region_info bar_region;

  vm_a = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0);
  vm_b = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0x4000);

...you'd see something like this in /proc/blah/maps:

fffff4000000-fffff4001000 rw-s 10000000000 00:07 148     /dev/vfio/devices/vfio0
fffff5000000-fffff5001000 rw-s 10000004000 00:07 148     /dev/vfio/devices/vfio0

It's nice being able to tell the actual BAR offset (within the
VFIO_PCI_OFFSET_MASK, i.e I _don't_ mean the synthetic region index
offset).

For vm_b, if we create the DMABUF to begin from the start of the
actually-mapped slice

   phys = pci_resource_start(pdev, index) + (vma->vm_pgoff << PAGE_SHIFT)

then the VMA's vm_offs would need to be thunked back down to 0 (since
the fault handler then treats vm_b + 0 as the first byte of the DMABUF).
That works/adds up, but then the vm_offs of both VMAs A & B both have
offset 0, and it's harder to differentiate in /proc/blah/maps.

An example from the later patch "vfio/pci: Provide a user-facing name
for BAR mappings" naming is:

ffffb8070000-ffffbc040000 rw-s 00030000 00:0b 5         /dmabuf:vfio0:0000:00:03.0/1
ffffbc140000-ffffbc240000 rw-s 00000000 00:0b 2         /dmabuf:vfio0:0000:00:03.0/0

We could possibly stash the original offset somewhere and then render it
in the name string, but the name's already about the max size and using
the existing vm_offs column is nicer IMO, doesn't need a new field, etc.

I need to work on this comment then!  What this is trying to say is that
the DMABUF is made artificially larger than the part that is visible
through the VMA.

I.e. the DMABUF starts at the beginning of the BAR and so an mmap for
offset +0x4000 for 0x1000 bytes starts at 0 and the VMA sees
0x4000-0x5000.

>> +	 * This differs from an mmap() of an explicitly-exported
>> +	 * DMABUF which is an arbitrary slice of the BAR, would be
>> +	 * created with the desired offset+size, and would usually be
>> +	 * mmap()ed with pgoff = 0.
>> +	 *
>> +	 * Both are equivalent and vfio_pci_dma_buf_find_pfn() finds
>> +	 * the same PFNs.
>> +	 */
>> +	priv->vdev = vdev;
>> +	priv->nr_ranges = nr_ranges;
>> +	priv->size = (vma->vm_pgoff << PAGE_SHIFT) + req_len;
> 
> And why is size being calculated from pgoff ?

This is the part that makes the size the requested size plus the
invisible portion before the VMA starts (equal to an extra 0x4000 in the
example above, distance from offset 0).


Thanks,


Matt

PS: Thanks also for the other reviews!
