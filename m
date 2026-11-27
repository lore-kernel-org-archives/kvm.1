Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796988;
	b=T/QEWfVflHLVuG4xJMAO2pjOo1NBkicnF7wPV6hTEhiIv97UxnNK7AXFm/8vwNy0HEWQ
	 2IYP8+rOcfd87HBKb9HMkvjfPDjXapnyP8/QiuXdAVYl+HlJyzGJPspXALMOp+9l3nNvL
	 SxytmfHs76XwGyKrevQR0vA+QSiWIhzDjCKzURgVD0sY0KVwjCK8RiYe6vARnsGbOyCEb
	 uG2T1CPPdFF6Ly0koBctppNE4oEV4hWfUmsDz4D//q/Loel17cnV6HFsu/PU0mvAsA+NS
	 YsrIQZg5cllV8qc+k7QdayvQCVa2TcMr+RujvPmHCKBPjElJ9iUH/zo+RyAdm/6ueLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796988;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=fskTL15wnb1o0Xx+IZq2KDKqa5bO2z7H3uOd3UTFjjo=;
	b=5OftS53ecjDxzLYA/9Fqada5S7NsY7r1eMFY7+S9MI4HdVhJSCvnjNPIHMAlcNiJpHte
	 pPrAn40SteF19UYv8hjQI5C1IuYRnTQmPewn8f7ePnCbMxrVVj00S0P8d26x6ZloJOfzo
	 NyaeCkdmFfSKCS9G5PP9CwTPO4OL73OXKL4+x5if5DQNXJIFD7/nhHX1RbSbi+Zvp73xf
	 waj85FNXvneg6SO9JSV5LLtkFK6x0pDiQzfCuudb+tFtQZyBaoYX8uuNK+lrLZc6qb1em
	 45CHBvof9qZggIP23PQ22RaCXxm3Sb/8QjJq6dWg0eBMfcaWiZ1B7GsFOAD81GMxKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=dQ6L40eg;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC0D606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 16:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=dQ6L40eg
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261127162944euoutp023c1ed111a4a7aef814373877a9c45543~r89fgs5aq2223522235euoutp02I
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 16:29:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261127162944euoutp023c1ed111a4a7aef814373877a9c45543~r89fgs5aq2223522235euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795796984;
	bh=fskTL15wnb1o0Xx+IZq2KDKqa5bO2z7H3uOd3UTFjjo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dQ6L40egfVigO5T6FlJni35+Jp68j+lHagaeh179VYPbpc3ae0mUelEupkmesuKXZ
	 rKt9U6Xyk8Bl4qNnb5RdJhUHu6oNqQN5c6mR0MPUOeD9uvI8IUBlmE5DGO84mmCcRX
	 KAjfZPbKz2NY4cwW2yxyXY053kgPtdf1PJHKJXwY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261127162944eucas1p20258c79e44d891dc99d178f690906ef2~r89fFj1xM3022230222eucas1p25;
	Fri, 27 Nov 2026 16:29:44 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261127162942eusmtip180948ab3b1d37be87c3161bd7750304d~r89drFbc71011010110eusmtip1I;
	Fri, 27 Nov 2026 16:29:42 +0000 (GMT)
Message-ID: <99691ff4-7652-4050-adca-3ec941dde4b2@samsung.com>
Date: Fri, 27 Nov 2026 17:29:42 +0100
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
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261127151717.GO114472@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261127162944eucas1p20258c79e44d891dc99d178f690906ef2
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

On 27.11.2026 16:17, Jason Gunthorpe wrote:
> On Fri, Nov 27, 2026 at 03:45:15PM +0100, Marek Szyprowski wrote:
>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 0e329ecd7dfa..106da975bf0f 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1892,11 +1892,12 @@ static void __dma_iova_free(struct device *dev, struct dma_iova_state *state,
>>   */
>>  void dma_iova_free(struct device *dev, struct dma_iova_state *state)
>>  {
>> -       struct iommu_iotlb_gather iotlb_gather;
>> -
>> -       iommu_iotlb_gather_init(&iotlb_gather);
>> -       iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;
>> -       __dma_iova_free(dev, state, &iotlb_gather);
>> +       /*
>> +        * Nothing is linked any more and every dma_iova_unlink() has already
>> +        * invalidated the IOTLB synchronously, so there is no deferred
>> +        * invalidation to wait for and the IOVA can be reused right away.
>> +        */
>> +       __dma_iova_free(dev, state, NULL);
>>  }
>>  EXPORT_SYMBOL_GPL(dma_iova_free);
> That makes sense, but I'm a little lost why we needed the
> DMA_IOVA_USE_FQ ?
>
> If any queued gather was ever created then the ultimate free has to
> also be queued. But the comment implies that queued gathers were never
> created in this case?


Indeed there is no point caching domain->iova_cookie->fq_domain once the
dma_iova_free() doesn't use the gather. Now fq_domain can be directly
checked in dma_iova_destroy(). This simplifies things a lot. I will send v2
soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

