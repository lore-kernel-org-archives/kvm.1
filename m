Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD94191F91
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362628; cv=none; b=JOBajgQA3MduwWTJzFjsxix7T05QGLJ+cefViL58MQcw2+i/15EbR9SvrOcdU7NB94+6t2LCKb/t/2yxXhf5/+PrmmKltUPsTE89wtjkE0Ksid82OF3Y774AcskejLePyqpofqsq2rXfYaOr+lboqSJU4d4ARJZR+sEmziZIwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362628; c=relaxed/simple;
	bh=2GFL7VB0cRgFFnQbEkqUx5fd6HPHx7ACEWYneTUtHv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEvkHI+VXsFnrLmQnY2jGPnf6xL/W2tYjVBoBjIqsUKNWWaNV99GZfUJ4DONlZ5DXMJZnvgaJPymrAe/+1lYfbBQWziwsvXbD0p5uUfB40r7lTGYQimf66g1P5dIVtJSyYP7VaTKyxMk3to9jGn5Qmj8QfyMOGCNoiLzsgHkJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EoLxV8Tt; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EoLxV8Tt"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GCHnmZ4149405
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 11:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zCV6QPUTe0ssrZC3JFQw+rrD1aQfezLGRz11FC3KHW4=; b=EoLxV8TtXF+v
	y2CGmOD96u45PSbUUgbaSvdxJZomeK+msMnl6Pl6XMdlEdIwFS8yhKKS/Uay6T7s
	hVGgKV10OHDNXFnj2UPfnMaC0RuXYxuQ+lI9V7L2IDyf94kAjwz5yA8+Z/7rHiUU
	yuWs5FU8VIMvfL2fzhjRzz2mo33P95oHjMo7g7fiEb/wf0fsHfqnWdpn2VJbsOhJ
	++DpbhMXneHucglec4BrRfTq4QLpm1P6zEaURoNLsM4QRpXtig8pMLOURg/bwWXf
	UHz9CKTvEK4y5OuHmrbxZrmJHlZZdh1RayuJsgrQKbllhZB4zRrwR4uMgfQsXpb1
	L+IsVwfCBQ==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh8553vup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 11:03:44 -0700 (PDT)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836abfc742so63956595e9.0
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 11:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362623; x=1776967423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCV6QPUTe0ssrZC3JFQw+rrD1aQfezLGRz11FC3KHW4=;
        b=H64KNAb6sjQB0cgYDMEzgua8bP+lH+zN70b9lTBna+4TVzAUPYsEaviOKFftctNhyb
         Y5rKiasiV/FY2eIcX6VJJN8HiklXnl4I0MyGSqR2ZP+TgiHeO63Q2m/ShE5GTP3V17Lx
         0VCTq8nm++GzgLV58xxVr4dZwG5gm+UY9+YEhBxFcTuI9NXp9I5HbHT7qfI4s4a5PxZs
         MBc4EeiSTStQmwS3fzbY1W0N3HT6aeV7ozz9MpFuYbIq6WW4dXk6ibZXXMDCt4BwR4hE
         TtVlXsqaaMPU/uBOIm8BFiBynXQCLKZgHg1XdjU6hI43ss5TRZQ5xdlSLxhCUCdCtN/H
         M7XA==
X-Forwarded-Encrypted: i=1; AFNElJ/Hzv2yRE0uC+YxB8OEbmKZQL6AyLW8G9QUFGgiiL+Q5Uok3zeNz7CUTxCLBOKz+76WJhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2qm1nv4Pbuh0d06JaJZcKSpq7xIP7dnvRq0oKIVs4fE0tEoJ
	fd9sLWVY0f3rBvhHceFEDgH/rinUoU5V6fxf1wo2DMwrIOhAN/R0Cnjk3w8ETff4sI0aUaMDp1K
	5iv4Gb7qVR8MhOgZ+mPIHNW7OWe6vbUcCNzIDFVtQmbriTEDug9h4
X-Gm-Gg: AeBDievSbD/KwGE9XDPptDyE3SSkNC3Q8kQzoPu5VktKD3PO+VpsJiP47aYLfs/i5I3
	ebNTnpm0OxBFidDwnwrBEK4o+0XE8JprL2A989T8LKlF2BiAdkhGLMKlBT1JXPC+BYVBZOu7ArZ
	OPLiUBWIzfrsm5dtVu/tU8O19e+Yj65tjfGlEsHLp30lUxhEwRDsrBVFrkZFn+c5goxXJ3GGOBK
	k68pDo+T8KsRMZHkH0h4bW00Dc9SVU/g671jUXxDQnQyz5GlSt5zE/9dIHFaqK+STiXKnjH6KHr
	85br579o5n6RkxoOWCPG/Tn6jBgXgyrMkMqvVKdbdUaGgzSPNJpxI0f6wd+I76XnBqypPEgZdz1
	YMTEXeL6gDKx+rtuy49BZJbPA6TMOq1nXzua9IoY3FtyfLM4XJH72Ce2UfMIc8+LN73Q1lKskYd
	v+Yi2DHkn1P0BixR9oDgV7AAcoHk9x9UtagkyV6aNfrjgj7t2zF93AGeInnZC2nS8Dcbj+mw+Yo
	nYc4dOhehv+F79EqoFTCRLXaeUQ38SScg==
X-Received: by 2002:a05:600c:528c:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-488d68c2bc6mr343298055e9.20.1776362622771;
        Thu, 16 Apr 2026 11:03:42 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-488d68c2bc6mr343297615e9.20.1776362622276;
        Thu, 16 Apr 2026 11:03:42 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581b9fbsm68548305e9.5.2026.04.16.11.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 11:03:41 -0700 (PDT)
Message-ID: <ed5d615f-5ba5-4045-ac45-79f06fd07a05@meta.com>
Date: Thu, 16 Apr 2026 19:03:40 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260415181623.1021090-1-mattev@meta.com>
 <20260416081138.GE361495@unreal>
 <2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
 <20260416131417.GF361495@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260416131417.GF361495@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Fuw1OWrq c=1 sm=1 tr=0 ts=69e12480 cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8
 a=lGc5rnHzrJZDjf1Vz5UA:9 a=QEXdDO2ut3YA:10 a=Ng9YvVcppn9CIdWre3nD:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: s4mCZ-h9SLqQE9qZhmmROdPXnDqa7o54
X-Proofpoint-GUID: s4mCZ-h9SLqQE9qZhmmROdPXnDqa7o54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE3MiBTYWx0ZWRfXzzsiJnL8L0ML
 ubUAHz2O/7bvgh5mDVy6X4J2neD3KCgbGYZC3l8hPg0grY6+rGvMgvVq3+3wo7RH5rTGu8T3hqA
 yfIQs44dtA/oGsdO0DBCTdIEB1aVnKEisfwsB0Y5biU/pauV+UEku6cLQFpCwaaLNl4SE0bzsqk
 us+Lplb+gNeXOyQjqo+l01R7PbC69cCvf5RSi7WAWgvpbWae3OaCl7Jo3f+fHv55mZA7LbNkMYR
 l2Dg4Da5Z/qH8WReZ6C9imaEkeAQKVHE/mu0/EKLtMdgO3Y3OzWh98hdNzijS3x964jsaVYBcJo
 +RmPGNNDV7qtiRozMwBw/+naQIGhc5cPcIduzBKBs/gLqwD7YVwB4fGv9PrkZfdC5wk41rU+gj6
 lbZKaX+mLCuQ/aiWrDzyMKUPL0XudWFkqZguARbVSW7GQA28l8aGHQ5y5kNTtdAmZ1GFFB6Jnf9
 XCxdaABgBsLYQdCmSQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01

Hi Leon,

On 16/04/2026 14:14, Leon Romanovsky wrote:
> 
> On Thu, Apr 16, 2026 at 02:05:30PM +0100, Matt Evans wrote:
>> Hi Leon,
>>
>> On 16/04/2026 09:11, Leon Romanovsky wrote:
>>>> On Wed, Apr 15, 2026 at 11:16:23AM -0700, Matt Evans wrote:
>>>> Although vfio_pci_core_feature_dma_buf() validates that both requested
>>>> DMABUF ranges and the PCI resources being referenced are page-aligned,
>>>> there may be reasons other than alignment that cause a BAR to be
>>>> unmappable.
>>>>
>>>> Add a check for vdev->bar_mmap_supported[index], similar to the VFIO
>>>> mmap path.
>>>>
>>>> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>> ---
>>>>    drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> index f87fd32e4a01..4ccaf3531e02 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> @@ -249,6 +249,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>>>    	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
>>>>    		return -ENODEV;
>>>> +	if (!vdev->bar_mmap_supported[get_dma_buf.region_index])
>>>> +		return -EINVAL;
>>>> +
>>>
>>> And it looks like AI has valid concern about this line too.
>>> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260415181623.1021090-1-mattev@meta.com__;Iw!!Bt8RZUm9aw!5DxsN8cDUviPIZqEjG0pZ_VYYbl_RdmWucTGdTZ3ZzlVP_Ysb0n7ykr0eXwFXdpuqvZH2FK3$
>>
>> Ah, Sashiko has a point, and I think its suggestion of checking lower down
>> in the default .get_dmabuf_phys (vfio_pci_core_get_dmabuf_phys()) and
>> preserving driver overrides is decent.  Will revisit.
>>
>> To your other question:
>>> I noticed this check in vfio_pci_core_mmap(). Isn't that sufficient?
>>
>> The scenario in mind is doing a DMABUF-export for BARs that you haven't
>> necessarily noticed can't be mmap()ed, and both paths should be checking.
> 
> I added the validation checks that matter on the kernel side, but mmap is
> primarily important for callers. What I am missing is an explanation of
> why the kernel should impose this restriction on itself.

I don't understand your question, really sorry!  Can you rephrase it 
please?  I want to make sure I answer it fully.

Although mmap() fails for BARs that are unmappable (for whatever 
reason), a DMABUF export for the same ones could in some slim cases 
succeed -- because the checks aren't identical.  If export succeeds, it 
could potentially allow P2P (or CPU via a future DMABUF mmap()) access 
to something possibly unmappable, no?

For the checks that vfio_pci_probe_mmaps() does (leading to 
bar_mmap_supported[] = false), most have corresponding-but-different 
checks reachable from DMABUF export:

If a BAR is:		Then DMABUF export...:

  size < pagesize	vfio_pci_core_fill_phys_vec() catches it
  Not IORESOURCE_MEM	pcim_p2pdma_provider() rejects it
  non_mappable_bars	... nothing?  Export allowed

As a quick test, if I hack in non_mappable_bars=1 for my function, it 
appears exporting a DMABUF from it works.

We could add another check for non_mappable_bars, but my thinking was 
that we don't want to keep adding to an independent set of DMABUF 
checks, especially if a future quirk/etc. could create another scenario 
where BARs aren't mappable.  I.e. we should reject DMABUF export in 
exactly the same scenarios as mmap() would be rejected, symmetrically, 
by testing bar_mmap_supported[].

Hope that goes some way to answering the Q, hopefully I haven't missed 
something!

Thanks,


Matt

> 
> Thanks
> 
>>
>> Cheers,
>>
>>
>> Matt
>>
>>
>>>
>>> Thanks
>>>
>>>>    	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
>>>>    				       sizeof(*dma_ranges));
>>>>    	if (IS_ERR(dma_ranges))
>>>> -- 
>>>> 2.47.3
>>>>
>>

