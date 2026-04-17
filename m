Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A1285058
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435914; cv=none; b=Cu2WY/e00OYv/6xNb/vzaPil46gNmaJk9gQbsoPXona1eEjT/E/UXPbbhqqgAifngCiH3oZjPKuKWcAOIK6UZN8JXUBy+WR1YqBUFBQ/eFvWFOL2y+NCqs8HWpqbwOTYT5iGuLnxpypk/xKo2B0WBpNVCXBG/v4+9QzNUyyyxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435914; c=relaxed/simple;
	bh=dJc550c7lueHVrl6u97GO6FfFrVEV1/fzs6oj14ACaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=filRg+jgKrThP/EOgMhPkpDpZcyi8Kc8YCQvwCpuEMmG24w9vriP78eWg8Z0FOtbbzV8luuG51CAkoZS2LvE3Wl75VBs3e/LZux3+tq9pLnpDLuAyytaMbjFmQbUcJBjwCtzdgOPTQloAFEDKVeKGBO1euhHhC5rfQ9iDw8eYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rYjOsECW; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rYjOsECW"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GKVVpT2401856
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:25:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PtNdOLZEYxbJwkCHTykxSu6qPAeRe4NAMSCEL5W2MDQ=; b=rYjOsECW5g8q
	uTFq6b3PSaGWX8hH093Wsb1Lz6RfZZhxqcgDUIbm8+KeTwcJXjg2rJd/ZJc5E2pT
	R1O6gqfzamNYsJYdPnFkpis82KKXx165KzSRUivhoj0vDxvdUeRViJgfZOoSSGu5
	7Ds4NWR1B25u54hXY78QDbDTB549of7TvIXQwNBQFiOnpdLZadeh6dnF5+hISbz/
	OIGfsmKhgYzlEbLnBwJ+WKinI7txUE/T4iljoTis9cMPUCr2yMpYpCNcMur2k7XE
	8fHH4mqEGTrq6Q4APAGD7l4YDnwkb1jwIQPzDki3eQwuvv9N2BMLdHaIYXq9MXHR
	Ndk+Ki0hOA==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh864vjy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:25:11 -0700 (PDT)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836abfc742so6582545e9.0
        for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435910; x=1777040710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtNdOLZEYxbJwkCHTykxSu6qPAeRe4NAMSCEL5W2MDQ=;
        b=m2REAmDClL3/m+dNlxJalidBTXWxyheb66ZuIuxUxll8LfanA2S04lJ21mF7cWz8gu
         LxcgXAFZtq7onZ9Fm7RNm9maa2EXMM1N5Ln1g0AN9Reg7AAeMnaV/GGjxmzpcM544to4
         8w5NPhJOuvmopqzpPrpMdVYcZTXSnwR1xZL3Thw6zKwXgeVRsoOPs9HlRnzmBkh5ThbH
         kMfjQbQtbc+FnygMN4Dx0tWaQ65W6P++miaMm2O2lz+dV1wCNApHSuUegzIwtDqBTpXq
         duQBwwmwGJ2DDh5BMqdQc4VdvbbeuM7aqA7b0cV1O0Ny81F7NzcETf0QpOJ/oOjyf7St
         Esvw==
X-Forwarded-Encrypted: i=1; AFNElJ/8iNpN7iD0Myp55HgoEdad2pCprPpnLlSKGVrHb3ywNfXXi2CnEaNzd65Cu+0xHLD4CDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrpqIw02dyma1AyIlZEJs/c2f5l3OKedGhqCxEn+AxmkrVQ6T
	x1Nf7KnSEpPyVM4Z9SA5hil4Q6KS2wBiOggmh5sFfjKQ3b3IGWcAW/mLOmGReZkC6GiQmJl0JPX
	LJ1sJYdDu16NW/y9m4H01+ohMb1EOB0zX93PV3+iaCmojZX2O+EUf
X-Gm-Gg: AeBDieuccM1Gxin7BIUx+QO3zPZMlgCo/3IQMvWRMVHYUlmtM7K2lnbAPXdN65mp1u7
	NpTzu5ZvcLLUqxO9icdsUtb0g2QapQGbIhpLXs7bTf76QnPOynSC3IwmFr5+WmnFjIpGv9v/w2+
	pLAr8FvYIQJ41Ol99xiRPfRL87jqfRs7E7ahTBkwvfsodB0i+p/yH0BNdkaJVpy0saBbtaC8SZ0
	/ZGqjK+6DiN2DjxPUzCjEyjrgKZ6bHusTcfmymvJYYc2mXv/dFgE237zoLTDsL8d+YkYjgIVvFb
	W/jidoOVpJrlupqii2TbmgmhqASdAZUSgrGCSCd3PlQmSD8H9O87r2dhAsmA3IcYEiq7cNLA+IE
	iC5GatlTk9ffM6TUh+YgJ9B3ZFx3btRHvMCtrhhvj0j4TbqQA8oQ2upq4hfg4t1rjLxARzCjrrl
	Ow6UFyNzmTtCCIsefZQX2XCfKlBr0EUiLX+k4IQry32SMWVA0dBOLjzrW6V3+Gw4DZhJvvPtpF6
	BGOG6IJOL9thwFn7Msj1z9Ae2aPhVaxug==
X-Received: by 2002:a05:600c:3e05:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488fb78049amr47995515e9.23.1776435909988;
        Fri, 17 Apr 2026 07:25:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3e05:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488fb78049amr47995055e9.23.1776435909428;
        Fri, 17 Apr 2026 07:25:09 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1ce408sm43261755e9.14.2026.04.17.07.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 07:25:08 -0700 (PDT)
Message-ID: <9a8b39c0-5c0b-4f32-88b4-225f16e8f3c6@meta.com>
Date: Fri, 17 Apr 2026 15:25:07 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260415181623.1021090-1-mattev@meta.com>
 <20260416081138.GE361495@unreal>
 <2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
 <20260416131417.GF361495@unreal>
 <ed5d615f-5ba5-4045-ac45-79f06fd07a05@meta.com>
 <20260416154806.0c5cb10d@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260416154806.0c5cb10d@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GKY41ONK c=1 sm=1 tr=0 ts=69e242c7 cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8
 a=Wnk4YwcsESJXKludE4MA:9 a=QEXdDO2ut3YA:10 a=nJq5_VNI1X7IEIKzvdHs:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 5zzzvvCgWKB9oOZy6Ycke7DszICXXKlD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NCBTYWx0ZWRfXxskE1VXyX1Ay
 rR3SusoE6ZlqqKvC2XDmzwIhMvH7XFAduXnWtL7I6DRIaMJkrZi8kvwCR0Pp5nzJfQPmvabx8UP
 piwus+WK7CCgmZiAg4i2vAGUbOZGiGbSDgPj6V/F3DbzO/QSk94IhK1WggHvmz17oECwGdPBXPp
 M41Ny3WMFrS3BcSIICc4S8UVPn1nw6Mm8Vjxij771M28dcgarawLhp0KXIKn+Chw8FJi2OwnlNA
 uS6RXJtSiPQFysIn/GyEUzQsFtgDCD6QVo/S4ly+shDFftrIb1UetzSRSyz4H9jiC7lQPEv/B63
 q5JG9nXFTY11j95mlbMcgcroH2we1lCJbBvgcDbdGa13OICrujTQDD1wBMz8kuidCeTPT99Lu8P
 UmkPno+oC47vPQDheA6gYqwrJvki9Z+Zz0i3EVDtfLrYIlj74w+azipgYz9jahSZNE7Ok2Xd4o0
 NrsllYu/NL70qBEat/g==
X-Proofpoint-ORIG-GUID: 5zzzvvCgWKB9oOZy6Ycke7DszICXXKlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01

Hi Alex,

On 16/04/2026 22:48, Alex Williamson wrote:
> 
> On Thu, 16 Apr 2026 19:03:40 +0100
> Matt Evans <mattev@meta.com> wrote:
> 
>> Hi Leon,
>>
>> On 16/04/2026 14:14, Leon Romanovsky wrote:
>>>
>>> On Thu, Apr 16, 2026 at 02:05:30PM +0100, Matt Evans wrote:
>>>> Hi Leon,
>>>>
>>>> On 16/04/2026 09:11, Leon Romanovsky wrote:
>>>>>> On Wed, Apr 15, 2026 at 11:16:23AM -0700, Matt Evans wrote:
>>>>>> Although vfio_pci_core_feature_dma_buf() validates that both requested
>>>>>> DMABUF ranges and the PCI resources being referenced are page-aligned,
>>>>>> there may be reasons other than alignment that cause a BAR to be
>>>>>> unmappable.
>>>>>>
>>>>>> Add a check for vdev->bar_mmap_supported[index], similar to the VFIO
>>>>>> mmap path.
>>>>>>
>>>>>> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
>>>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>>>> ---
>>>>>>     drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>>>> index f87fd32e4a01..4ccaf3531e02 100644
>>>>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>>>> @@ -249,6 +249,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>>>>>     	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
>>>>>>     		return -ENODEV;
>>>>>> +	if (!vdev->bar_mmap_supported[get_dma_buf.region_index])
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>
>>>>> And it looks like AI has valid concern about this line too.
>>>>> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260415181623.1021090-1-mattev@meta.com__;Iw!!Bt8RZUm9aw!5DxsN8cDUviPIZqEjG0pZ_VYYbl_RdmWucTGdTZ3ZzlVP_Ysb0n7ykr0eXwFXdpuqvZH2FK3$
>>>>
>>>> Ah, Sashiko has a point, and I think its suggestion of checking lower down
>>>> in the default .get_dmabuf_phys (vfio_pci_core_get_dmabuf_phys()) and
>>>> preserving driver overrides is decent.  Will revisit.
>>>>
>>>> To your other question:
>>>>> I noticed this check in vfio_pci_core_mmap(). Isn't that sufficient?
>>>>
>>>> The scenario in mind is doing a DMABUF-export for BARs that you haven't
>>>> necessarily noticed can't be mmap()ed, and both paths should be checking.
>>>
>>> I added the validation checks that matter on the kernel side, but mmap is
>>> primarily important for callers. What I am missing is an explanation of
>>> why the kernel should impose this restriction on itself.
>>
>> I don't understand your question, really sorry!  Can you rephrase it
>> please?  I want to make sure I answer it fully.
>>
>> Although mmap() fails for BARs that are unmappable (for whatever
>> reason), a DMABUF export for the same ones could in some slim cases
>> succeed -- because the checks aren't identical.  If export succeeds, it
>> could potentially allow P2P (or CPU via a future DMABUF mmap()) access
>> to something possibly unmappable, no?
>>
>> For the checks that vfio_pci_probe_mmaps() does (leading to
>> bar_mmap_supported[] = false), most have corresponding-but-different
>> checks reachable from DMABUF export:
>>
>> If a BAR is:		Then DMABUF export...:
>>
>>    size < pagesize	vfio_pci_core_fill_phys_vec() catches it
>>    Not IORESOURCE_MEM	pcim_p2pdma_provider() rejects it
>>    non_mappable_bars	... nothing?  Export allowed
>>
>> As a quick test, if I hack in non_mappable_bars=1 for my function, it
>> appears exporting a DMABUF from it works.
>>
>> We could add another check for non_mappable_bars, but my thinking was
>> that we don't want to keep adding to an independent set of DMABUF
>> checks, especially if a future quirk/etc. could create another scenario
>> where BARs aren't mappable.  I.e. we should reject DMABUF export in
>> exactly the same scenarios as mmap() would be rejected, symmetrically,
>> by testing bar_mmap_supported[].
>>
>> Hope that goes some way to answering the Q, hopefully I haven't missed
>> something!
> 
> That's the concern as I see it as well, it's a choice whether to
> attempt to support sub-PAGE_SIZE mappings, but if a device is reporting
> non_mappable_bars are we're exporting those BARs through dma-buf for
> mmap, that's a problem.  Should pcim_p2pdma_provider() test this flag> rather than vfio_pci_dmabuf though?  Thanks,

Do you mean "test this flag" to say 'non_mappable_bars' rather than the 
'vdev->bar_mmap_supported[]' flag?  (I think the former, as the latter 
isn't as easily available down there, sorry if that's not what you 
intended.)

Testing non_mappable_bars in pcim_p2pdma_provider() doesn't feel quite 
right:

- IIUC non_mappable_bars is about preventing mapping to userspace, not 
direct access/P2P/etc.  Splitting hairs a bit, but P2P to such a device 
seems valid, so I think this check better stays within vfio-pci 
(specifically limiting only userspace access).

- But non_mappable_bars is just one kind of quirk, and couldn't there 
possibly be more?  Good to avoid duplicating quirk checks in mmap() & 
export places (so any future maintenance updates just one place and no 
disparities arise).

All this to say:   The existng logic in vfio_pci_probe_mmaps() is the 
right place to decide something is suitable for userspace/direct mapping 
(mappable, non-zero sized, not IORESOURCE_IO), IMHO we just need to be 
checking it consistently.  (VFIO export is less lenient in terms of >= 
pagesize and imposes additional checks, and that's good as long as the 
checks are an overlay rather than parallel duplication.)

(Maybe you're also flagging that there could be other checks saying "Is 
P2P supported for this BAR?" and they could be done in a generic 
drivers/pci place?  I think so;  VFIO export criteria be the 
intersection of VFIO- and provider-based checks.)

I was thinking something like...

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c 
b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 00cedfe3a57d..9bb8bd153e12 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -359,6 +359,9 @@ int vfio_pci_core_get_dmabuf_phys(struct 
vfio_pci_core_device *vdev,
         if (!*provider)
                 return -EINVAL;

+       if (!vdev->bar_mmap_supported[region_index])
+               return -EINVAL;
+
         return vfio_pci_core_fill_phys_vec(
                 phys_vec, dma_ranges, nr_ranges,
                 pci_resource_start(pdev, region_index),

(I.e. leverage logic in vfio_pci_probe_mmaps(), catch bad DMABUF 
mappings this way, allows sub-drivers to override .get_dmabuf_phys.)

I'll repost that as v2 if this doesn't seem an outrageous start. :)

Matt


