Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CD49552A
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082937; cv=none; b=IpcRnAh7VYeab+njiuBYwEXiMi8KMjtenkDRMKpGCvmf4MaciH3NDUesuDWQ7JJcsYasryzRpK4b1JOwc2qgqigSiuDY0XIc3qGiPvsih8gGVPkdyBikGXIqMjgqepwllMraBc2nrQodMsu9BR4BDUda0uKXgBlAHtyqWtUV+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082937; c=relaxed/simple;
	bh=yAE/Ym57GFy/KISCQT6Y8a/+2nm5BztVchD6EC2QOxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUAoBulBS+Xh1nw7cSUosS9kAT2eRiE3+ahPcpK33zM1I10ObSR7q7MsTCI4K3YUXrE6Qhc8C/oX880+TIIVVBXYBUsErao93bX+BcqaxKYsUGtMFxCcvBDhW97a8tS4byK1MLVY8L5kK9K3iwYYjZj8voFx71eIkv494WuGC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=V5KJ2Qsv; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="V5KJ2Qsv"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6466OYiK2865632
	for <kvm@vger.kernel.org>; Wed, 6 May 2026 08:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Utn027AUC8UDDUJXMpqeQ33wB0VHRXSGiBE+zdS1lww=; b=V5KJ2QsvDqXI
	jsaAHALFGR6sjzWQOy2R8fDT1m2z8Vp+BEzdkIo2E0PzKZT3MoRqQ2oxFN/cf+RI
	zNdxXgZ/yC9TXtV3oASmSQ58occoBlUXUmIfLY3rEyKedGP+G26q9XfNbpy/cyyL
	ATxSfUlKU+0cbiv5isn7bvGMH98bzLSc6Cor0iZ7DZsrSsJL5Y4HlAHYbDQh47an
	JgHWaoOdPrg/9kinsjy7I1FZDdWBQ1dYEjz8FgwQ2xDR3PrtkNygxgXG3PaHOc5k
	UAwldnK7l+6FDmkB2j0Yjq5S7uSzqNd6Utnc2cINNmewbNDHUuno2cDWgkWZsFdm
	9itz8d4OIQ==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by m0001303.ppops.net (PPS) with ESMTPS id 4dwcx9sdu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 06 May 2026 08:55:31 -0700 (PDT)
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-441243ba35fso6478242f8f.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 08:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082930; x=1778687730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Utn027AUC8UDDUJXMpqeQ33wB0VHRXSGiBE+zdS1lww=;
        b=EMjKb69UzHQF9iJCFCBE1nQGlMz5tgeODYtk5BDb+BnUfrIdkg6E0mQxTHAzN3+IMu
         yk9mRGeMbJZMbPsC4lutI/M1TVoZU8W5XehtkH0fB+s+yKSAROLeEpNsjccAqOPfCidI
         fQhUX04whHXFTiwRRkppnjvfJjvFjP5uzkcEz4VH+E4EIhbugHjFm2CYink7fwYp5rM5
         7wIs5jJKvi+8zKrjIcD9pIspiM0sqcXTg9LxaFx34YqTVwpCn5fzktTREqczHLQrhimK
         1fzsUvRHSpbYLydJNqubDaxVBxdox6sihno9ZIzg6I0GT29PNRflglZtnB0fQKxQ2DTe
         Gc1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/+PBDozsuTTd2oPMfg01u2BSgarmoW6nYbjotzWtzmyrHd4SIVmnWhnK+UfuDhgG02HUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhce6VCY1U2HCAEyFcWi5IAWP1E7UYclyF45wuyawUxxQsZblc
	SVqfOpeN2S9ImNJm1IO7HzoWy9ZlW4frkVTGQEWF57k03DaDdOWq5mmTSw0YZvA39YzBGK6jL4q
	1Jx0Ety2cjQTrNcBBXdV/d6muXtG9SETQhywtCiWBy5T9LrCMmL14
X-Gm-Gg: AeBDietTJCIHAOX3NCytmqwF17hdARAXeiyx9NCL8t8IiMY90nW9lOpFsZW+SdiDy6P
	eX5RE6XlrazcC/yMhJ8xGWS58VaIa4Wy+8Q7anaQHDnMrbRbebXoGz2Nj6T9zmTn69BhkB5Qeae
	tbuQ8y/cuIT86N6fgP/ctGzLSOt1g/C1FNIn8Q85GVSeAxm5VbwrLugxHwnNgUMcc1TlgK/wEZY
	X27t7WUUOTu9P+wVX8bsvhSyTkq0cmHp492y4/TpSffrDKAYuwUy0Em8EYthq8Z38oMkoa+UUs4
	bpHxYxPRWgFC5g6V7t7mEznvUsnF7KDThYwxlQnJMq8A9zBKFwQ0m7OtxvPTUHjI9Fj44AzG5/2
	oJVu0Ju71t0wid66c1oY2fvvhhaP/g26SoXQjB2YWmP057ESPuoa1JoiKUFHMuzj0PC/QedXAVN
	Kbl99TXbWa0jKqypx6W4kB9G2b+DQVfcymF67OJieZxPvzCnmrFd0iwnRta5hz/rWIXQrNpLGpR
	Z1GpGNbeCujMZssOPebulprgQlU8bsz9Q==
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4515da967c3mr6651398f8f.37.1778082930003;
        Wed, 06 May 2026 08:55:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4515da967c3mr6651329f8f.37.1778082929442;
        Wed, 06 May 2026 08:55:29 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm13251331f8f.7.2026.05.06.08.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:55:28 -0700 (PDT)
Message-ID: <c0bd0e23-712c-483e-a809-47126ab6e9e9@meta.com>
Date: Wed, 6 May 2026 16:55:27 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
 <9304aada-ee84-4cf2-a1d7-82313eda07aa@meta.com>
 <20260506152937.GJ11063@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260506152937.GJ11063@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: u8h7bZ4_Pe5eN4AvDmbGdnWuKYD0GlNq
X-Proofpoint-GUID: u8h7bZ4_Pe5eN4AvDmbGdnWuKYD0GlNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1NiBTYWx0ZWRfX0gPhbycorcGU
 QByrrl/AyRK0F458aFUn643aTQlfDfMfsSGpKEhYMip89YNbusgoIit5/XaQEtcwVwdXIU9qx/X
 MltPUb+EjC+9M5QiOToQ9jzYY0vBhx7PNLKnkV7r8nA3JgwFQfCJrvTjEj0G8JPqgGO6CJNJI1L
 afK10pEEQULMKTIgzWcEUL+2BaxQGHbkRMhNYTMpa6TQ2G7HFDkA3DqoL7lIwmpfs4QxKCfJflS
 cHZPX/61urf1P/wSzY6Akuml17wb/GQeF1/ppAjAwOKLvbojr8zwlzVUyOY5k8lR8MA/+9oucw8
 uLtPQkh07O/3TYExQXhHvckBuO86YVQTxMFUbUhnPYvvUNYkNOw3QWyY0EQOablme7aAQ0SeX3x
 VEIqLeDJt/7D80uAZyeQvm/27zMnr7wNYCVKMbHBbHIOAWXbanC9COqDqMy05DOzp9DDG43UIny
 gvcIVl7TDxoz77Mpeeg==
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=69fb6473 cx=c_pps
 a=pX1sPZUoWPGeQgUnKQNIgA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VabnemYjAAAA:8 a=bm6tUXqWTanbjDFH1akA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01

Hi Leon,

On 06/05/2026 16:29, Leon Romanovsky wrote:
> 
> On Wed, May 06, 2026 at 02:53:31PM +0100, Matt Evans wrote:
>> Hi Alex,
>>
>> On 01/05/2026 20:12, Alex Williamson wrote:
>>>
>>> On Thu, 16 Apr 2026 06:17:44 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>
>>>> vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
>>>> revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
>>>> the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
>>>> second/underflowing kref_put() then wait_for_completion() on a
>>>> completion that never fires.  Fixed by predicating on revocation
>>>> status.
>>>>
>>>> This could happen if PCI_COMMAND_MEMORY is cleared before closing the
>>>> device fd (but the scenario is more likely to hit when future commits
>>>> add more methods to revoke DMABUFs).
>>>>
>>>> Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>> ---
>>>>
>>>> (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
>>>> and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
>>>> context, so including in this series.)
>>>
>>> We really need a fix for this split out from this series, It's already
>>> been shown[1] that this is trivially reachable.  Carlos proposed[2] a
>>> similar solution to the one below.  I was concurrently working on the
>>> issued and suggested an alternative[3].  Let's pick a solution for
>>> 7.1-rc.  Thanks,
>>
>> It looks like [3] is progressing, so I'll drop this one when I can rebase
>> onto it.
>>
>> I noticed [3] removes the dma_resv_lock(priv->dmabuf->resv) around the
>> priv->vdev = NULL, and this series' vfio_pci_mmap_huge_fault() relies on
>> vdev only changing whilst resv is held to resolve a race between a fault and
>> cleanup (see patch 7 of this series).  The handler takes resv so that it can
>> stably test vdev in order to take memory_lock.
> 
> I think that you should rely on priv->revoked and not on priv->vdev.

Needs both unfortunately, as the fault handler ultimately needs to take
vdev->memory_lock.


Matt

> 
> Thanks
> 
>>
>> Must your fix change vdev outside of holding resv?  I'm still sketching
>> alternatives; at first glance perhaps the fault handler could rely on vdev
>> being valid if !revoked, which can be tested holding [only] resv.
>>
>>
>> Thanks,
>>
>> Matt
>>
>>>
>>> Alex
>>>
>>> [1]https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
>>> [2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
>>> [3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/
>>>
>>>> drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> index 281ba7d69567..04478b7415a0 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> @@ -395,20 +395,25 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>>>>    	down_write(&vdev->memory_lock);
>>>>    	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>>>> +		bool was_revoked;
>>>> +
>>>>    		if (!get_file_active(&priv->dmabuf->file))
>>>>    			continue;
>>>>    		dma_resv_lock(priv->dmabuf->resv, NULL);
>>>>    		list_del_init(&priv->dmabufs_elm);
>>>>    		priv->vdev = NULL;
>>>> +		was_revoked = priv->revoked;
>>>>    		priv->revoked = true;
>>>>    		dma_buf_invalidate_mappings(priv->dmabuf);
>>>>    		dma_resv_wait_timeout(priv->dmabuf->resv,
>>>>    				      DMA_RESV_USAGE_BOOKKEEP, false,
>>>>    				      MAX_SCHEDULE_TIMEOUT);
>>>>    		dma_resv_unlock(priv->dmabuf->resv);
>>>> -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
>>>> -		wait_for_completion(&priv->comp);
>>>> +		if (!was_revoked) {
>>>> +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
>>>> +			wait_for_completion(&priv->comp);
>>>> +		}
>>>>    		vfio_device_put_registration(&vdev->vdev);
>>>>    		fput(priv->dmabuf->file);
>>>>    	}
>>>
>>

