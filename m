Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201DC31A7E4
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075619; cv=none; b=rVPNy76+mhQh/13SMvMBEOarX9JQ+oVCwv5QGwy7TbIENSzytKK0mDRjgjOpgbUyEYha5Vbdi1JW4Un82lxtrPp2wT9fpfr9yOJDIVnfboUCpOGu5jetBHXec7F1tWOHB9drg/MhUMx4guSjsYtqJbP9n330C08Z4RdP/Wo5/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075619; c=relaxed/simple;
	bh=Yf3p9DePpxrz1wRV7pVbqVJsbvljiS6iIc3Z+7d2LCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TepqcLRu1RDKPOyjIS3gXT5SdUGh5n97OTiVPbHumXb28V9izci+h0OiWca4QechhQU0LcyN55/a37WucF0kZBECztxMBK0b14doJI5EolKD3Awn0qaqahb9fjAhbhjWpxcjLIigPSSY3KhFjsofBTf4wcSHfN+uXzq+y2xSWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gW3xmhO/; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gW3xmhO/"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6467gsiv1815915
	for <kvm@vger.kernel.org>; Wed, 6 May 2026 06:53:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Wr10VTJN3duBxSrKADAl6R/6nUDyzwk22GvJwJKGKOw=; b=gW3xmhO/sRQz
	XJqsiB30MPqABfSYdPyLP0Gn/OezmfyWpq/Qzqjhz2ze7SQRMEXSQHa99g+b7Iir
	gFzVLc2FOh5mAKnK8IvSBVns4QA0YXbcRl87u0f1pieyGY90bP6vERpbS+L7g+P9
	DHCWf4PcInhjkxO+Gm7vkvPJ6GVW5B0TpH8Jp8xFidA4r6Hlogd/JJy3L8saGMRk
	15ap4MCtUXuicSVe2/hcNksNiN8B1EbtQCmsjgszWsFwGMWCoArp5Upp87gHiWGn
	78NOQtEVTH4koE76G93+00BqHzW9i4PIfjFdjf47b5lVOIeDazmu1SVOr2EArvRI
	msxzNEBCAw==
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx1wgvu8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 06 May 2026 06:53:35 -0700 (PDT)
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-66a3c95958fso5009210a12.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 06:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075615; x=1778680415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wr10VTJN3duBxSrKADAl6R/6nUDyzwk22GvJwJKGKOw=;
        b=GZ1IXvkC2QsaiQSVenzD4daq/tNY8jiNfV7OSqEYhdZYq6NUiM5hDk6ee7WRJta2vT
         0PtaW/MycOMKSRt3NCWkiIHc6FYwWULAP9dW6RaXfJ1i6OiL/wiCg7fTd5UB9hPx2Ieo
         iwXq07GH1E2ipEtzxZXocytBJYsg0KISzjy4+ApgXAp6rqsOUFYjxIO/ECHgNoAi3DVd
         bsat2Rjsd3/W0u60t6hVK4GBKIjPe19xIfs+k17Rl+W8htdDBqqAUZmYeVk3VOQDdTsi
         KBsU/Jk7/P6/InmqOgqhPjoQIsb2VAOm+Tr+b3u9O3hfPhbhMxTs4nLi3C22JKXp27tc
         MqYw==
X-Forwarded-Encrypted: i=1; AFNElJ+BQtSSRYcFGf2LPR21u+EixAwxrWmwmFvE44EgQGqhklRRD5ZjCUqqOCEZ10rrA1Tr2aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3H8sZcx5CnS1W1l09KtQ/69rBGBDBYE8+qiHIGiQM7uol3Y4
	nTFfCqXN2KqTfeKGqP4gPqlPyTmg5GD7BV8We98XRRUbJhFRs30bKd4E2krZAYtzApLGUAOpeMS
	FurSflAmawfZs07Ru23mgeKd2r+b5nAt6AfmvLklZWRprrQ1i8CAF
X-Gm-Gg: AeBDievEql7uz0pbs/M7AnWJUj5YkkrPDmIIalPL1yKuh7y9CLrEzNowfRCqU9bAL6r
	9xskaO0mViCUKCRqCpSWJvbcI1eSyG20N2UmAB6uvIvS7leDnC0PsZDXV4nQ0r84F+/KrlLK6Yt
	Cp9W+MP62+tOAaaSyjUbwGXPAoTFAakLwqAR6svwEXmETbgNtMCG2gIl2Dz8kNhWeRKWUMMeE5/
	u+BaEo/mV6krFo0NLVlnslviDkaaKm2PfaaG3Tc7a8XHZmkui2g2MATmpuSaQRiK9tLJ6pMWvYP
	fg5rP7W3Gv4aluArNmF57FUY6kPUQaLz9Wo0NamlYdzYv35lBJ1OoTVSFM0XkdG5dP7CrDrre2P
	fvEVTtfCipMexAQqHbBKRHa8ZZmzo738NrGY1fjNzrpKivGnOhvBpd0zt+aHNdx29Ul22okWCx+
	aVA4s98nLEVNbiZ/YiFrxl9/u0QXzYLneV4CwMBRU8Ti7C+vVRjStViy3vO+iL9irFTrdPex9Xq
	dUtDyI9yiro6V4egDVCX+pmid+//u3NUQ==
X-Received: by 2002:a05:6402:3788:b0:674:b1b1:d039 with SMTP id 4fb4d7f45d1cf-67d63db380emr1617979a12.11.1778075614656;
        Wed, 06 May 2026 06:53:34 -0700 (PDT)
X-Received: by 2002:a05:6402:3788:b0:674:b1b1:d039 with SMTP id 4fb4d7f45d1cf-67d63db380emr1617931a12.11.1778075614040;
        Wed, 06 May 2026 06:53:34 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd904fe68sm1337174a12.0.2026.05.06.06.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 06:53:33 -0700 (PDT)
Message-ID: <9304aada-ee84-4cf2-a1d7-82313eda07aa@meta.com>
Date: Wed, 6 May 2026 14:53:31 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
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
        kvm@vger.kernel.org, =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-2-mattev@meta.com>
 <20260501131236.278ac431@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260501131236.278ac431@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jt/Bas4C c=1 sm=1 tr=0 ts=69fb47e0 cx=c_pps
 a=Tczdrg5if7+wQeIJmxD/XA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VabnemYjAAAA:8 a=CQcdbiei6IkXp1Z0tZsA:9 a=QEXdDO2ut3YA:10
 a=1oAhN8tkTtOBK6_UvoHx:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNiBTYWx0ZWRfX5HLM33mEdoij
 UogLJ6w90Q9kZeRN27dMyqfrRhDq6c4L0nYTBFeRqgQncUDFTaX0A61IaAAauR9lCFyD0JqPrMo
 uUX9KP5AKH8J6wGpK8zw4FtGPomqvH9oZ65cjQMULD9oaoSvjNpBYwY5G8U8ZlMfoyTvgQAAZNE
 48CxZnFaycpbZYvfu8hlRQhXx/19bkWE1BfKs6rAVsqUAFLV8sjjEoYmO436CD36iUf3b0KLi3Y
 emiTsjfqP5C5KlC01ve48o/qtSkVyWodD7prhcp4qVOW4legc2HpXPjtyNOjUccR3s8wBeNBlzX
 A7Q0OFytcpbRIKGAWRuW/GAuBujK+RtbeTydy86Fnp9f8dIatQQocCIdMo9oliVziZpW7zgY7oy
 gbQPS4P+uStPM/olklxxu6Kb7aKb8MkOmuzGMuXOUfwdHLAsJwgrO5Z8RQd5sjGzmaidHbB8hUU
 4V2sHZf8Yxlp6/iERDg==
X-Proofpoint-GUID: D6DZ0BOOWHBabQP2IvdZ4iSYxFfVGaCm
X-Proofpoint-ORIG-GUID: D6DZ0BOOWHBabQP2IvdZ4iSYxFfVGaCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01

Hi Alex,

On 01/05/2026 20:12, Alex Williamson wrote:
> 
> On Thu, 16 Apr 2026 06:17:44 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
>> revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
>> the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
>> second/underflowing kref_put() then wait_for_completion() on a
>> completion that never fires.  Fixed by predicating on revocation
>> status.
>>
>> This could happen if PCI_COMMAND_MEMORY is cleared before closing the
>> device fd (but the scenario is more likely to hit when future commits
>> add more methods to revoke DMABUFs).
>>
>> Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>
>> (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
>> and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
>> context, so including in this series.)
> 
> We really need a fix for this split out from this series, It's already
> been shown[1] that this is trivially reachable.  Carlos proposed[2] a
> similar solution to the one below.  I was concurrently working on the
> issued and suggested an alternative[3].  Let's pick a solution for
> 7.1-rc.  Thanks,

It looks like [3] is progressing, so I'll drop this one when I can 
rebase onto it.

I noticed [3] removes the dma_resv_lock(priv->dmabuf->resv) around the 
priv->vdev = NULL, and this series' vfio_pci_mmap_huge_fault() relies on 
vdev only changing whilst resv is held to resolve a race between a fault 
and cleanup (see patch 7 of this series).  The handler takes resv so 
that it can stably test vdev in order to take memory_lock.

Must your fix change vdev outside of holding resv?  I'm still sketching 
alternatives; at first glance perhaps the fault handler could rely on 
vdev being valid if !revoked, which can be tested holding [only] resv.


Thanks,

Matt

> 
> Alex
> 
> [1]https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
> [2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
> [3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/
> 
>   
>> drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 281ba7d69567..04478b7415a0 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -395,20 +395,25 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>>   
>>   	down_write(&vdev->memory_lock);
>>   	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>> +		bool was_revoked;
>> +
>>   		if (!get_file_active(&priv->dmabuf->file))
>>   			continue;
>>   
>>   		dma_resv_lock(priv->dmabuf->resv, NULL);
>>   		list_del_init(&priv->dmabufs_elm);
>>   		priv->vdev = NULL;
>> +		was_revoked = priv->revoked;
>>   		priv->revoked = true;
>>   		dma_buf_invalidate_mappings(priv->dmabuf);
>>   		dma_resv_wait_timeout(priv->dmabuf->resv,
>>   				      DMA_RESV_USAGE_BOOKKEEP, false,
>>   				      MAX_SCHEDULE_TIMEOUT);
>>   		dma_resv_unlock(priv->dmabuf->resv);
>> -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
>> -		wait_for_completion(&priv->comp);
>> +		if (!was_revoked) {
>> +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
>> +			wait_for_completion(&priv->comp);
>> +		}
>>   		vfio_device_put_registration(&vdev->vdev);
>>   		fput(priv->dmabuf->file);
>>   	}
> 

