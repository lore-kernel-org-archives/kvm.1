Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683413955D4
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608310; cv=none; b=PNpFlcB9zH/NA+ITBmbtrj/J8KOcbg8XyyKOGdoQ2yJSZf7c1R7KllykXfPAX/KCik8zvLFKkj+WMyvCo2Ra0B8Ut7Vw42QjZhCL23RLvR41nGkzf4szSP0+DrQT0gnzinRdJBkM4/XgoPcOxbvo5N7De7GzBeHSdBSFUw9FP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608310; c=relaxed/simple;
	bh=hk8PB4pvcDliKDLD84Bz+1ES7jV4sJ8MBbCGzhd/rfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlC08Aary6qKsDF/5vSVKYbu6VE+6HEfKk7eo/9QLHz/kZBovD7iA40Rl8Wa3Fp2lkHjLhWN3uJt0q84MHIvMSXf4Hr/Kg0RB/UoOnIF0y1mGwLIPhZxnlCebyHnMI6Q0GHojvwqNj/4aYRND/R98n3KmCSPGQsmuOdGYts+9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EExxnns3; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EExxnns3"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C4UHCs1647796
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 10:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sf+Rn+/zlE/3t2At5IGAJ+WyeFpgS59mk9gpV5fg5Bg=; b=EExxnns32Xp5
	12a+7JZj4UeiKq2uMxYppv3vd0ZzsVG+jW9paFI2gTQDUpJ3vaSe7cbARrwIEwoZ
	y383o8nxsaU3WmH7xqF6yid/vBMEqlE1f5m15nEqEVIjAn6WwIRPawNhYdsH9wDC
	2ntA1fgLCD9kG5bI6KgfgDbYzqY/t+gGgGI4gjgZUuY7aUaUkfuzpY/Dfe2GXWDB
	hXZqgpCjNQuYIyEiYSUfvrBAaOCuWL5tvv0vnqMrX6RoQja+7tcx/afVV+elfC0M
	PpWIl7ehb364TmuyvB2TuJWqcyb7SkijecRSPc5SDF7Ju4Ee/PXYCRtdMQm8TSwm
	X/JaxiPHfA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvqam7v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 10:51:47 -0700 (PDT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso4703665eec.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608307; x=1779213107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sf+Rn+/zlE/3t2At5IGAJ+WyeFpgS59mk9gpV5fg5Bg=;
        b=ANhcRQPcPqHgNDqALA06LS4khRug8G5qPrj3l+fkDSU+lHXYOPCkPs/UQ/EUk9J2QS
         wNQM6bZ6oAhYh+LI3+Csvl6lP3SWRXDGysC4w2w43l1RHjyagEWMuSYRo9f2OaBfFYeA
         f/zpTJEn0Pej2Kr3TlDmapHpSB8tsH/3RmP188TUfAw3hCWqRNtvZ363qXWp+Rxff9UZ
         wMZM2xccMm0x6xc8uQ7fTABv2KFVHi298xlB4gBewJrL29u5y8NuQ5/Q6TKkq0Xg/3Xt
         fGW/ZPVthzFo/bztFR+tA4K0PJwLoRHkQBTH2A25rbkJhFnxWnrEDx/r4YUzhJTVNn8a
         4tOw==
X-Forwarded-Encrypted: i=1; AFNElJ8goJXAfwYj5T8KwqKhNecwLp4vmRxNjtqnADoHcrkWaM7yAoq/mjUP7X1q9PfUTUINvGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3G5S0RtdivWDCDZ62KvZ5IGJmPoXnoQKNgYsQnZmo79VQ2MK
	mEf4pN6MHbvHAEAXkl0YlqpjTOk8zO7q7hSs5vELjm6WO+IG6Z9QBJZoDxTIbkNQonzBH/ACUY1
	Pq3TuYjLXU/juP3jqlCbZJo415vjAz2ARC045p7WyLhth+xTLRaFM
X-Gm-Gg: Acq92OGjboAo0AyrXSneuMRWV+RMBlIluLqhPhVYpx7GQHrgBSplCyqea0YzyKre/n6
	FYEinLdaIQ8cEFnEJ849JgpWv3Z8GtxCXlt2HaZR2ovzaAbF5BgqeTFTQify1jsrYl8JpGsNc/8
	ngQdSy09XcQjtrH+/YdGYlkuE/a6h+3f8qsiCJ8PQ1dOsemlXKchPjdHz34uMsMzVkJFtJG6S3b
	jkedTNQLXnYQCbYm2yUhPRTyOqwIQPH9E4nJeqH3gqpVxaIFU5VQoMWjnu79v4eybHiFprM1Ppw
	/Nx0eRqcU+uXyAfladDky0baYpMRb1feqXXuhiBwjjLC9hzmQx4y4no0J/puhGRMhBBvBGyax1K
	d/bQc7I+SfXOPKXi5iYz+b8rQ
X-Received: by 2002:a05:7300:ed85:b0:2f8:1f2b:bb5d with SMTP id 5a478bee46e88-30119f6d66dmr42243eec.25.1778608306619;
        Tue, 12 May 2026 10:51:46 -0700 (PDT)
X-Received: by 2002:a05:7300:ed85:b0:2f8:1f2b:bb5d with SMTP id 5a478bee46e88-30119f6d66dmr42218eec.25.1778608306019;
        Tue, 12 May 2026 10:51:46 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859e8389sm18884568eec.3.2026.05.12.10.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 10:51:45 -0700 (PDT)
Message-ID: <4af0c788-22cc-4fb1-9276-ab35439fb7c8@meta.com>
Date: Tue, 12 May 2026 18:51:40 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com> <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
 <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
 <20260511140957.25eb5d9d@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260511140957.25eb5d9d@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4NiBTYWx0ZWRfXzKUag+6oAjVd
 XQf9trAg8ab/yhoib/qYMAg1GodG9FGvNHiEvmo/yuLlFHm4bX83Uh96iemdAcPxeikYSYWp6Lv
 AUXOikx377hJjZWGhiDn5YKS936rpPeSo9f6eLT6pK+AVCyGsuYrTCSeFw8H5NUbBU1/Gy5HWAi
 p3mCfz6fj+0YTqAQKqHRK57uhZutJ4C7sDgPOc3udQuFv0PmHoQR/LVCPz6bq5Y6PesAPIXTtnM
 uo25rdQfwcDxITG5CNNO9+y8zvQbWCO+a0DCi2jzi9ZMHKyoBhpZUXmzCyfEAvRW2QGKh1bxBYs
 BpK5ccQNbrk3lFzNApnrx00uHmo79IDD/59WcKKZspbH7sg24wWvBzrZhMSLOB1jLng27DOcdVI
 F8X5ClYOQbP8ZuBV/rbvwwpRzdZDMqsXTPIgVSM9dbS/EcydKnGAOup5GpU7TVreF3XkbiK2/gS
 4wOINA/D+PqsDmU7vcA==
X-Proofpoint-GUID: ixORctpSzis20GaEcJohhRj3wLVNfMgs
X-Proofpoint-ORIG-GUID: ixORctpSzis20GaEcJohhRj3wLVNfMgs
X-Authority-Analysis: v=2.4 cv=TfKmcxQh c=1 sm=1 tr=0 ts=6a0368b3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8 a=h_Mwey2iunVtOOa4NVUA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01

Hi Alex,

On 11/05/2026 21:09, Alex Williamson wrote:
> 
> On Mon, 11 May 2026 16:30:39 +0100
> Matt Evans <mattev@meta.com> wrote:
> 
>> Hi Alex, Leon,
>>
>> On 27/04/2026 15:36, Alex Williamson wrote:
>>>
>>> On Sun, 26 Apr 2026 13:52:15 +0300
>>> Leon Romanovsky <leon@kernel.org> wrote:
>>>    
>>>> On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
>>>>> On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
>>>>>> A new field is reserved in vfio_device_feature_dma_buf.flags to
>>>>>> request CPU-facing memory type attributes for mmap()s of the buffer.
>>>>>> Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
>>>>>> PTEs for the DMABUF's BAR region.
>>>>>>
>>>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>>>> ---
>>>>>>    drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
>>>>>>    drivers/vfio/pci/vfio_pci_priv.h   |  1 +
>>>>>>    include/uapi/linux/vfio.h          | 12 +++++++++---
>>>>>>    3 files changed, 23 insertions(+), 5 deletions(-)
>>>>>
>>>>> Nice and simple
>>>>>
>>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>>       
>>>>>> @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
>>>>>>    struct vfio_device_feature_dma_buf {
>>>>>>    	__u32	region_index;
>>>>>>    	__u32	open_flags;
>>>>>> -	__u32   flags;
>>>>>> -	__u32   nr_ranges;
>>>>>> +	__u32	flags;
>>>>>> +	/* Flags sub-field reserved for attribute enum */
>>>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
>>>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
>>>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
>>>>>> +	__u32	nr_ranges;
>>>>
>>>> Alex,
>>>>
>>>> The TPH proposal extends the flags field in a similar way, but I suggested
>>>> a different approach to conserve bits. At the moment, we spend three bits
>>>> on a single feature, which feels wasteful.
>>>>
>>>> What do you think?
>>>> https://lore.kernel.org/all/20260409120415.GF86584@unreal/
>>>
>>> I already proposed a very different interface for TPH that decouples
>>> the dma-buf creation from setting the TPH values:
>>>
>>> https://lore.kernel.org/all/20260423132016.4a25e074@shazbot.org/
>>>
>>> This is overall less intrusive than the TPH change proposed, but it
>>> could still make sense to align this as an operation on the dma-buf,
>>> that can be probed as a separate feature.  Thanks,
>>
>> I'll add a VFIO_DEVICE_FEATURE_DMA_BUF_ATTRS in a v2 instead to get in
>> line with the TPH work, no worries.
>>
>> For the benefit of future hackers, how would you describe the criteria
>> for adding flags to this existing field?  What hypothetical feature
>> characteristics would be appropriate?  (Maybe it's that these attrs &
>> TPH add scalar fields in several bits rather than a simple boolean.)
>> Two of us have independently added something that's turned out to be
>> inapproriate so some guidance would be good.
> 
> I think the question of how we actually expand an arbitrary grab bag of
> "ATTRS" is the central question in whether we should implement the
> interface. 

> If we follow the direction I suggested for TPH, maybe this
> is just a VFIO_DEVICE_FEATURE_DMA_BUF_WC, where it supports only PROBE
> and SET, with SET taking only the dma-buf fd to implement the one-way
> promotion from UC -> WC.
> 
> If we support a generic SET ATTRS feature, we really need to map out how
> flag bits are indicated as supported and how a user untangles failures
> from trying to set various attributes.  If we end up with a feature
> indicating each ATTR is available, we might as well have just
> implemented a feature for each attribute.  Thanks,

Agreed, that's key.  Alhough, the aim of this patch is for attrs to be a 
memory type enum rather than a bag of possibly-concurrent and 
possibly-conflicting boolean flags.  Maybe 'memory attributes' would be 
a better feature name.

I'm not sure about the feature-per-attribute.  Say we do a 
VFIO_DEVICE_FEATURE_DMA_BUF_WC and then later support a second, 
VFIO_DEVICE_FEATURE_DMA_BUF_UC_WEAK (like, say, Arm Device-nGRE).  Then 
we have to specify that these two VFIO feature types actually 
interact/override somehow.  I doubt we'll end up with a dozen but it's a 
bit tiresome having a few features that interact.

At least if it's a single DMA_BUF_MEMATTR feature taking an enum, we 
just encode the N different (mutually-exclusive!) valid states and done. 
  I don't feel having a new feature for each keeps things simpler.

Discovery of support for a specific future attribute is OK with a single 
ATTR too; we can take an enum attribute argument to a GET and -ENOTSUPP 
for any we don't like.

(We could also add orthogonal DMABUF flags (can't think of a good 
example...) but I'd suggest _those_ as semantically-grouped different 
features, with the same issues of specifying conflicting cases versus 
existing features.)


Cheers,


Matt

