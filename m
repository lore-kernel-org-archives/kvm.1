Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708E3FBEC7
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513449; cv=none; b=DenTq9lC1mVLQSFllhHfTiR9FlIS8jeGPM4iJ5hAliQAApi46VhBcJ7alZ5lRQUs1ZdEeSssQk6l4OaYaWED5N8hAICeEPjQasLL4Yh1lLKPqIexbnEy8jicr4qhVuHs+pEDvmc4/BS0PbYR2kD0YOEPf3FhfZitcuwL4K3OSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513449; c=relaxed/simple;
	bh=F7atxy0xKM8DpXLajI6bmHIyh5YuV4M5ES3nif002jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZE5wYCbTMM2m2ZkHtekGpYVyMysnKepZrSlLIhX2hZXqmfFuVQ8cD20S9kUeSg05AsECL5SQuXy1sYX7FhRzv9RjX+jmY3guI+HmPZ7fsHQSwgv7/v3jOzTYdWWV/GSK+9vMDRIeSune65RbligYOLMMHzmCRjoBYGv51VW3aG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=l5CJ9j8P; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="l5CJ9j8P"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BEw4vO941872
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bO0OT5HbP3xMB9H1AybFAyJkqZoplUb3t4HsCcdmo+w=; b=l5CJ9j8Pt4jd
	oo2WjP8zAaxDoOQtii5Xv4O/D6fdD0hd4ART8sIyryLJf8dOqBTz/yQ+uerxGOHZ
	KqdDkk5BUPra4La+lrsGoib67wFEHFUXUYKoT5+8hWBy9OIx+D9V8sE2QmHW+yMT
	h35Kt8l9MYRDqqlmJv0WkUYcqwdMG9jVc7x0RKu6oILOR1twr/YLgUwLpnf350vz
	+GJ1mWfeupTHI+JMhKWxRZCtBSmD+//ybC+8KUEpo8p5QU7ZNmMMdXXRB4OqZre1
	WwVJheJnIclwhharvAmggbk7AX/pj+QZFuYaS5iSYZGy3zEuDg1zR03BUoikGeZS
	XDLlFw4U2A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e221d2s20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:30:46 -0700 (PDT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c8ccc7593so9482695c88.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513445; x=1779118245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO0OT5HbP3xMB9H1AybFAyJkqZoplUb3t4HsCcdmo+w=;
        b=itxjmpjO66ICM/fkoiWnklew5N2eyMnZGUPu6+m+JefZD/HnZ3WukQQ30M5CLGslnb
         IsrBVzpN89Jh8wgwktPoYxr8LZIliKIUAM+9QzY1Kj7L97QihIsjudopaxeBV4hphVw6
         ZmcFF4hVLNwAcNqcUltVPrFRtDmV8k0Ytqubvy5D6BaHdsuDn2FRwhmVweqn1oghoj6h
         +H4t0vlAFU7vjtUnwDqeWtQ7te3Ag9oiw+J93qghjJuuZTgBfMNFf8hXDnJLka6Zj7mF
         6ta0iN1KL9Ud5IiRc55yII0umyuCeY//A5Hs3uKOK709btOzP3opR2sxEdv6Se0QFIwH
         3X4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LERC0WFJF9sgTTmc+Q1riTQUHuCrRckQNhc97K9wvIkqDiDuZDQu7ceqp21ntcoucYMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uEMIRoIuRMFTSsPEVfjXaq/2kqcsWSsuS6xcM4OTlfmQHFkN
	wsLUCgp4b9oKilfaBApUkqno3/DOY640kdpodIvUMPl2vM/b6uk8UofQbREWNgBhVB2XBzu7FF5
	Pj3hW3Z1TNP3CzFwDy67Ffe4sNDf6J4aQRnVYRGdxPHZvQxmGxd8P
X-Gm-Gg: Acq92OGc5zPfPgbo3hvH14Amu+8rPXZDJGAyEoRIyHSRDwAM2p1kzblQi6os8DTAcbZ
	wxuQKRSnpQtwunA6SNJ0hZ80TyYgx2RcPudYVlev9yxNTv+BBB/ILUzVLFUNMVy0fr3lzEcCyDE
	qtszBN5UHgVZc0/z/zxov3ntSB47SUHK4pLd1WWqUP9xPaUiwZtySct7Pv8JRfRx39u4MtAHzMG
	ixQTl7OJ7FHRB5qSFKrnvZ+Ilt19oN6GpbsAH7VycCfsTKaRDDGAGxuvBr2PKA46m6NMYb4zNeT
	Zu14qHMuVAqg+Rfumzuj5MqOYUBeumu51IZiZMgh/znHQYZ/JKYV1eOFUbmio9Jv3Fxad8JN/QM
	Vmfc3wye0zK2z8v9BIGjUXmx0
X-Received: by 2002:a05:7022:2399:b0:12d:d27f:d817 with SMTP id a92af1059eb24-1318550ae20mr12188192c88.19.1778513445374;
        Mon, 11 May 2026 08:30:45 -0700 (PDT)
X-Received: by 2002:a05:7022:2399:b0:12d:d27f:d817 with SMTP id a92af1059eb24-1318550ae20mr12188121c88.19.1778513444549;
        Mon, 11 May 2026 08:30:44 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ff4dsm14644541c88.3.2026.05.11.08.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 08:30:44 -0700 (PDT)
Message-ID: <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
Date: Mon, 11 May 2026 16:30:39 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com> <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260427083644.4ee174cd@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YJuvDxGx c=1 sm=1 tr=0 ts=6a01f626 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8 a=02ciemoj1X7HeLU9vPcA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: MhHDSOaQZLXR7lxukaOFj-Vz8WouVjQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2OCBTYWx0ZWRfX99WNlmHbChfq
 uHZKNaMmZ/49jfIJQV0Kts06QBzQDaJw2eJi9K+pespBr/9zkURgI7FKBeN0zhhfls318QTsmWm
 OxFgf4proHJGPbq4DFb8NM3HkiDNP94cPmVrODfI17oZ8PFYfTnvwPSBsrslW0kqvFWqs8lahSd
 JyVYkgGSWqakC3JNEIyjNx6LapiOIoguriVng+ZcSLFgoGPVv9r4Z5fIB+e/EUs/Cvu0/zEHVcC
 fP0Y6l2S5f7lIPVnZumiCEcPhui5gX2xk0SkJ6rQSu44oUREMDRS2x/JzkbZWG7JnVcHrU9QIW8
 vuoUZSr4CNoCpmjI+SL2kEO+iUf8UlnmgTdfYE0M8KXzNhW3+RLyFclVws5QWHtdIgXEsybrxIS
 PRFxk06jj7bUE5ZbFLIFr01xIRw65pOQ5p466BlQfQCT73HtoSQda7QmvkgTZugmixZUvwgiLPu
 VgZXYtvFMHlYKDcgNyw==
X-Proofpoint-GUID: MhHDSOaQZLXR7lxukaOFj-Vz8WouVjQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01

Hi Alex, Leon,

On 27/04/2026 15:36, Alex Williamson wrote:
> 
> On Sun, 26 Apr 2026 13:52:15 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
> 
>> On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
>>> On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
>>>> A new field is reserved in vfio_device_feature_dma_buf.flags to
>>>> request CPU-facing memory type attributes for mmap()s of the buffer.
>>>> Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
>>>> PTEs for the DMABUF's BAR region.
>>>>
>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>> ---
>>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
>>>>   drivers/vfio/pci/vfio_pci_priv.h   |  1 +
>>>>   include/uapi/linux/vfio.h          | 12 +++++++++---
>>>>   3 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> Nice and simple
>>>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>    
>>>> @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
>>>>   struct vfio_device_feature_dma_buf {
>>>>   	__u32	region_index;
>>>>   	__u32	open_flags;
>>>> -	__u32   flags;
>>>> -	__u32   nr_ranges;
>>>> +	__u32	flags;
>>>> +	/* Flags sub-field reserved for attribute enum */
>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
>>>> +	__u32	nr_ranges;
>>
>> Alex,
>>
>> The TPH proposal extends the flags field in a similar way, but I suggested
>> a different approach to conserve bits. At the moment, we spend three bits
>> on a single feature, which feels wasteful.
>>
>> What do you think?
>> https://lore.kernel.org/all/20260409120415.GF86584@unreal/
> 
> I already proposed a very different interface for TPH that decouples
> the dma-buf creation from setting the TPH values:
> 
> https://lore.kernel.org/all/20260423132016.4a25e074@shazbot.org/
> 
> This is overall less intrusive than the TPH change proposed, but it
> could still make sense to align this as an operation on the dma-buf,
> that can be probed as a separate feature.  Thanks,

I'll add a VFIO_DEVICE_FEATURE_DMA_BUF_ATTRS in a v2 instead to get in 
line with the TPH work, no worries.

For the benefit of future hackers, how would you describe the criteria 
for adding flags to this existing field?  What hypothetical feature 
characteristics would be appropriate?  (Maybe it's that these attrs & 
TPH add scalar fields in several bits rather than a simple boolean.) 
Two of us have independently added something that's turned out to be 
inapproriate so some guidance would be good.

Thanks!


Matt
