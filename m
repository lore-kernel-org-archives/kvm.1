Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799902;
	b=xLMJcE4E+6oIr07RM2ppL9WGkOw7RJHdTE5dHxNHnkyjjbgj4kZxjoyo8dGfgVLf8Ju0
	 sZhV/I/ucbJUDtfWA2B/yklguQQ3lOD0qrY+aKS4B7d1iGgkBoos9WvOWVtdY1s5VkKKN
	 gUKxK0ZLNBO/tCoQm2eSD0N9Yi+4rKWeb95gFADAImbUB7lnP5YttN9QN/WrtY8KHxugX
	 9W9lQvj1aCrtIOrjF0kXR0L0pxI3sKLQpAHkdduGlwqzZ7J4Pt6jGIUVfezT7tZ9c0izu
	 HxL3Xm/yxfPGeO3iSpLbYlpD6pi7gwGilmm/4vpn8eHoiIKapqw/p+4Gm0Vws4pZfQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799902;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 Content-Language:In-Reply-To:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:X-CMS-RootMailID:
	 References;
	bh=voUMY1GaUDXkX3vPxokQ2znp4MO0CTCoKzygoZVc09Q=;
	b=oFsli5/YNjvQk2K672UrozEsStGKWHfRSF+r84jGvCUrKHfyQmX7s4q5CN5sw9gVn0t/
	 GT0e3IplcL32K7qVYcfc+gqpZGlcG2AcrYzPP+SUDMZPY0dZvAtjRtAKxl8loCGeiZkV2
	 MRe/U2vPMOlal1g6I3xVkRE2TqjDHm51yPbhfHGulv6kOjKpdByz1Qhmrrxmt9e01h5N1
	 6ELodB3vpM+C3ZJzyBeIVn6NzWDaaLTZdSVITQECO7QcIFWGGqHIi+DsLLKAuDXsDybm3
	 qybPUCrI/KS9oiI1T2fqjMRKzc5oABUddIr2F/ak+OziFoLXbbB1/pNd2E3XtT5OKyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=jI0ai4bJ;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6968606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6968606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=jI0ai4bJ
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261127171819euoutp01986aca8573f5cf507954cb36a7cb5081~r9n5y1-z_1497914979euoutp01a
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:18:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261127171819euoutp01986aca8573f5cf507954cb36a7cb5081~r9n5y1-z_1497914979euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795799899;
	bh=voUMY1GaUDXkX3vPxokQ2znp4MO0CTCoKzygoZVc09Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jI0ai4bJOus2xhl1HnoujUy8gcnJckv+rFOhrxqQSH8OJTjO9oXa7bFHA83A0ix7R
	 553bRwuI0dFuGBzPBsXQyWb5ZQlXpO+yYWz0IgDzIrfEJYf+UGYxW8pWSfRrKZsgI+
	 ff6p5YUlQQc8fFIapRUMkkYNKp83VnyiE7v8cLqg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261127171818eucas1p10aa9f7ade3733cf0942e20c59b2aff6e~r9n4-L99Q2544625446eucas1p1Y;
	Fri, 27 Nov 2026 17:18:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261127171816eusmtip1898b94a17878c71daae117811be597c2~r9n3FZf9i0715007150eusmtip1B;
	Fri, 27 Nov 2026 17:18:16 +0000 (GMT)
Message-ID: <141643fa-b595-4354-8eda-2fccff09a7ce@samsung.com>
Date: Fri, 27 Nov 2026 18:18:15 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 4/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Honglei Huang
	<honghuan@amd.com>, prakash.gupta@oss.qualcomm.com, Alex Williamson
	<alex@shazbot.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho
	Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,
	stable@vger.kernel.org
Content-Language: en-US
In-Reply-To: <99691ff4-7652-4050-adca-3ec941dde4b2@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261127171818eucas1p10aa9f7ade3733cf0942e20c59b2aff6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a
X-EPHeader: CA
X-CMS-RootMailID: 20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
	<CGME20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a@eucas1p2.samsung.com>
	<20261127115849.2780625-5-m.szyprowski@samsung.com>
	<20261127143740.GM114472@nvidia.com>
	<feec2436-ad15-4aa6-a53f-800869bfac21@samsung.com>
	<20261127151717.GO114472@nvidia.com>
	<99691ff4-7652-4050-adca-3ec941dde4b2@samsung.com>

On 27.11.2026 17:29, Marek Szyprowski wrote:
> On 27.11.2026 16:17, Jason Gunthorpe wrote:
>> On Fri, Nov 27, 2026 at 03:45:15PM +0100, Marek Szyprowski wrote:
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 0e329ecd7dfa..106da975bf0f 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -1892,11 +1892,12 @@ static void __dma_iova_free(struct device *dev, struct dma_iova_state *state,
>>>   */
>>>  void dma_iova_free(struct device *dev, struct dma_iova_state *state)
>>>  {
>>> -       struct iommu_iotlb_gather iotlb_gather;
>>> -
>>> -       iommu_iotlb_gather_init(&iotlb_gather);
>>> -       iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;
>>> -       __dma_iova_free(dev, state, &iotlb_gather);
>>> +       /*
>>> +        * Nothing is linked any more and every dma_iova_unlink() has already
>>> +        * invalidated the IOTLB synchronously, so there is no deferred
>>> +        * invalidation to wait for and the IOVA can be reused right away.
>>> +        */
>>> +       __dma_iova_free(dev, state, NULL);
>>>  }
>>>  EXPORT_SYMBOL_GPL(dma_iova_free);
>> That makes sense, but I'm a little lost why we needed the
>> DMA_IOVA_USE_FQ ?
>>
>> If any queued gather was ever created then the ultimate free has to
>> also be queued. But the comment implies that queued gathers were never
>> created in this case?
> Indeed there is no point caching domain->iova_cookie->fq_domain once the
> dma_iova_free() doesn't use the gather. Now fq_domain can be directly
> checked in dma_iova_destroy(). This simplifies things a lot. I will send v2
> soon.

v2:

https://lore.kernel.org/all/20261127171529.2917893-1-m.szyprowski@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

