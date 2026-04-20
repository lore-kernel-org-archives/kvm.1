Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896B3A783F
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695073; cv=none; b=mZ4rKI1oqsN5aatg2yJg7cV0YX/lhSgJvdU1uld/4upThQlPhQjVC2EudA5gUww+XsJPpbvIYDJaoeK3LbSoyeLrslOk/GObn+8x95N4/4jBvo8Kklbvxj1UJ3QzNJhrR0aWBWrF9eOzfFOvIv7tsyZG2XB26UMVOWln89uOaGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695073; c=relaxed/simple;
	bh=K4axnBw2XdfGBMQjAa3dRMsDtYN1apRStXVovoJ9BpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEGGbUJuHx655sunU2GI32Ov/y6SaAKMs5sII8yWeb6oWanUvoaQY13MoiMJYOd2uXxci3pNedoEKg125n62ok99n+nYT3+iySn7+eabLFGF9BAY04zg+Fx+TpdqRmy07NRzV5NX4Yf5bi3yQtt97QJuhoSOinQL6HzY4SXLX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gbIAk16o; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gbIAk16o"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K3n35a2948473
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 07:24:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jHgjOSRTsNN1GYyuO3MSsk5koDvTxzHyytSNDAilaTY=; b=gbIAk16oQ5qU
	z3BhAdIflZX19sFf3n6/z5t7PjU1da6ysj5DPBWDv9vytIwAMjErAQBiM1la8mmy
	+uCO8/1xMzaWvXNxjKQylYji2u/Yta0Uh7KiypQ2j9v5IfeseJk/NHV1ALdRu560
	c2rF+6pUsErjdG9JtblP5rzH/B4Ws2TPHaLVqOui4GsAGhqUTS0hryvEU2QDjY/s
	qzMCsAv6+91QyEClwUmyz434YnHh7T7SAPJhIOFfbjLzUgvfW4kjQKEvislOUH8p
	PEo+9i4L3jwzfRHyPB+6XhZkYn/dtN+3bObN01Cfpba4tK9NcDe3jhrjCLpR0062
	jfFdRokhUA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm5yyha2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 07:24:29 -0700 (PDT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12c8ccc7593so1344904c88.1
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 07:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776695069; x=1777299869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHgjOSRTsNN1GYyuO3MSsk5koDvTxzHyytSNDAilaTY=;
        b=jJcO7kWPTdLanrNrMcc5qrCuXwDHiilk+dNIbrBM+VSw9VE3hdo0NJzYGHHQFQRfNH
         2cxfFOG3FI9xucrE8IF5d1/fGHtbViB4/g2Zui6Oyrxz6iYv/GRxyOsPos7q9EZhgQIr
         MMlSpkKvkqVHwY1cOPlwXQAxhhiysLiG2NjeZ4HDsnURoKbNpbEQgoZiDHUQaVpdfA0/
         +QNolNbvGYyvPjPL0P0SXpmexSdhVWidFDALhmdBH3OA7BzD8bPvEq6J6YN4DHvHgniQ
         WKZ66ThQZh7Kn8ze2Ga9uhsGcqQMGGJ0voRkSS55KsfdbE8URxIwG9s84+m2ZimaVk2Q
         Arrw==
X-Forwarded-Encrypted: i=1; AFNElJ9mfAK2t50u1FaNjUTeodYWOiazUx3L6Bee/nEqzsYhOj8fjfwjuz+H8khK2h/992FHEW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsu2cFOGLvpghitsfR5S7JMOf2bLV20E0QdNu0TD2CqS/eS8V/
	4DhuIOVwYq1qRfLkQAD0zJC6/KJioBKQyACRF6/Z2miP2lt8/na8LmVfP25MrXuOSjWEsE8Kyym
	TyURfp1pq72LX8mDMCiketo3VYdmbITEgBIme2enIeYQOjYCJ1yB5I3dOe5W8
X-Gm-Gg: AeBDievOGmFftvO+ybAWQM0Oj7JY0RXu1PTxybZ0zMOCV/OVXfyVTJ9rJ5Ef+h5L3DZ
	fmJ4unJqF8meLwOeTTq3U/qH3X8Vx2VuqlcCisgvh5WEKKSi6nE5pmfBZMBJRwf8Y+JeKeR+cYo
	elY3yHodrWNC2yNPW5avQ125BFVUjiyCevoHwyaJZvf3qmpKpb+oUAT5QtB70631P0fUtQB+xbp
	jB/Wo62bn3bIA6VkioDnQN0G5OJx/miWLilF4XYQvbtEqxN2qT8nZqcOWFdf3J5NJBhFauhgAeb
	14MNyg7WW43YoHQcocw5kewvhivyDwxgZS7m00Uf4HnaPCA404QV8DHxcf/1rO54F8rJXOTd/dV
	XOSkQRzuStKSwWYXvl0jk5zPR/ts9lxahgXthUMRD
X-Received: by 2002:a05:7022:6b8d:b0:128:ca90:3301 with SMTP id a92af1059eb24-12c73f71963mr6986970c88.11.1776695068683;
        Mon, 20 Apr 2026 07:24:28 -0700 (PDT)
X-Received: by 2002:a05:7022:6b8d:b0:128:ca90:3301 with SMTP id a92af1059eb24-12c73f71963mr6986906c88.11.1776695067848;
        Mon, 20 Apr 2026 07:24:27 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20b9csm14777210c88.12.2026.04.20.07.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:24:27 -0700 (PDT)
Message-ID: <789793ec-8ee7-4cba-b20e-15f8bb6f494d@meta.com>
Date: Mon, 20 Apr 2026 15:24:21 +0100
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
        linux-kernel@vger.kernel.org, schnelle@linux.ibm.com
References: <20260415181623.1021090-1-mattev@meta.com>
 <20260416081138.GE361495@unreal>
 <2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
 <20260416131417.GF361495@unreal>
 <ed5d615f-5ba5-4045-ac45-79f06fd07a05@meta.com>
 <20260416154806.0c5cb10d@shazbot.org>
 <9a8b39c0-5c0b-4f32-88b4-225f16e8f3c6@meta.com>
 <20260417163151.18ac44bf@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260417163151.18ac44bf@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Q7DiJY2a c=1 sm=1 tr=0 ts=69e6371d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8
 a=Cql_KS6jiOXSXKHlHGoA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: I_0gzGowbK7o5iemBp5P3pyxsFMJ51RR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEzOSBTYWx0ZWRfX/vFCvyIaIZHb
 RzAN3pnCTUr1gAtnCZXY9+so3xdg7zRr0Ttv75F25rsBC12C6g7OpVy4L8ZgwQ1TZi0gGph9eF9
 GYkgaJvIEDQY19Bj43eEXVuZxvvPfNCQw9WWDtOf87TZFZPU+B4XsaSyAoi1PuxgWyMJRunnAFb
 d7ZcG5KOF0hcUX0rVIMXLdiQWfGIqY+Vb8lEU23Yv8Hvh2RdZDqG/K1k8pLfyVSRpcRjHCIkZTq
 25/E+nSnvOI5M+3FmCw0CDd7KjLKWPOUcWC50WnUaYKqGSM6lXFpRnTP2kxK4ifxpsA9+/4bg6V
 hHIFZi2G4yLb21kwy748XI6is787pxEWPXazT2B1AgF7m3Ur0mDlwxqZzFKh/pHrHFtA4h7Do40
 BQPZ9gZXaINBn4Gxy8Y79WnJvOyVvmwJonr1TZNlPTRbaYKYvGVBnYjE00fCY/B15MrpT55Jhga
 Xt60FgL3ycHu/Dh5QwQ==
X-Proofpoint-ORIG-GUID: I_0gzGowbK7o5iemBp5P3pyxsFMJ51RR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01

Hi Alex,

On 17/04/2026 23:31, Alex Williamson wrote:
> On Fri, 17 Apr 2026 15:25:07 +0100
> Matt Evans <mattev@meta.com> wrote:
>> On 16/04/2026 22:48, Alex Williamson wrote:
>>> On Thu, 16 Apr 2026 19:03:40 +0100
>>> Matt Evans <mattev@meta.com> wrote:
>>>> On 16/04/2026 14:14, Leon Romanovsky wrote:
>>>>> On Thu, Apr 16, 2026 at 02:05:30PM +0100, Matt Evans wrote:
>>>>
>>>> I don't understand your question, really sorry!  Can you rephrase it
>>>> please?  I want to make sure I answer it fully.
>>>>
>>>> Although mmap() fails for BARs that are unmappable (for whatever
>>>> reason), a DMABUF export for the same ones could in some slim cases
>>>> succeed -- because the checks aren't identical.  If export succeeds, it
>>>> could potentially allow P2P (or CPU via a future DMABUF mmap()) access
>>>> to something possibly unmappable, no?
>>>>
>>>> For the checks that vfio_pci_probe_mmaps() does (leading to
>>>> bar_mmap_supported[] = false), most have corresponding-but-different
>>>> checks reachable from DMABUF export:
>>>>
>>>> If a BAR is:		Then DMABUF export...:
>>>>
>>>>     size < pagesize	vfio_pci_core_fill_phys_vec() catches it
>>>>     Not IORESOURCE_MEM	pcim_p2pdma_provider() rejects it
>>>>     non_mappable_bars	... nothing?  Export allowed
>>>>
>>>> As a quick test, if I hack in non_mappable_bars=1 for my function, it
>>>> appears exporting a DMABUF from it works.
>>>>
>>>> We could add another check for non_mappable_bars, but my thinking was
>>>> that we don't want to keep adding to an independent set of DMABUF
>>>> checks, especially if a future quirk/etc. could create another scenario
>>>> where BARs aren't mappable.  I.e. we should reject DMABUF export in
>>>> exactly the same scenarios as mmap() would be rejected, symmetrically,
>>>> by testing bar_mmap_supported[].
>>>>
>>>> Hope that goes some way to answering the Q, hopefully I haven't missed
>>>> something!
>>>
>>> That's the concern as I see it as well, it's a choice whether to
>>> attempt to support sub-PAGE_SIZE mappings, but if a device is reporting
>>> non_mappable_bars are we're exporting those BARs through dma-buf for
>>> mmap, that's a problem.  Should pcim_p2pdma_provider() test this flag
>> rather than vfio_pci_dmabuf though?  Thanks,
>>
>> Do you mean "test this flag" to say 'non_mappable_bars' rather than the
>> 'vdev->bar_mmap_supported[]' flag?  (I think the former, as the latter
>> isn't as easily available down there, sorry if that's not what you
>> intended.)
> 
> Yes
> 
>> Testing non_mappable_bars in pcim_p2pdma_provider() doesn't feel quite
>> right:
>>
>> - IIUC non_mappable_bars is about preventing mapping to userspace, not
>> direct access/P2P/etc.  Splitting hairs a bit, but P2P to such a device
>> seems valid, so I think this check better stays within vfio-pci
>> (specifically limiting only userspace access).
> 
> Indeed the flag does specify userspace mapping in the comment, but I
> think it's more than that.  The only device that currently uses it is a
> device unique to s390x, where AIUI, there is no P2P DMA anyway.
> 
> Also, for "legacy" mapping of device BARs through the vfio type1
> backend, the mechanics of the mapping require the BAR can be mmap'd
> such that the user virtual address can then be used for the DMA
> mapping.  So as far as vfio has traditionally been concerned, there's
> an inherent dependency.
> 
> I could definitely see that p2p folks could balk and we need a separate
> flag... or since there's exactly one device that reports this flag,
> maybe we can tweak the description.

Thanks for explaining; with that context, ...

>> - But non_mappable_bars is just one kind of quirk, and couldn't there
>> possibly be more?  Good to avoid duplicating quirk checks in mmap() &
>> export places (so any future maintenance updates just one place and no
>> disparities arise).
> 
> I'm not sure what this is getting at, I think non_mappable_bars is
> meant to be the flag that quirks might set if for any reason we can't
> directly map the BAR.  I think "userspace" mapping is a bit of a
> red-herring, it's at least not mappable by the CPU, but I don't think
> the flag is actually meant to define a policy only for userspace.  If
> it's not mappable by the CPU... is that also enough of a restriction to
> exclude it from P2P mappings?

...and this, it makes sense then to just check non_mappable_bars, if 
it's not about userspace and has the semantic of "don't access this 
directly".

It'd be nice if it evolved to a per-BAR flag rather than per-function, 
BUT I acknowledge I was largely worrying about the shape of hypothetical 
future quirks and that isn't necessary just now.

>> All this to say:   The existng logic in vfio_pci_probe_mmaps() is the
>> right place to decide something is suitable for userspace/direct
>> mapping (mappable, non-zero sized, not IORESOURCE_IO), IMHO we just
>> need to be checking it consistently.  (VFIO export is less lenient in
>> terms of >= pagesize and imposes additional checks, and that's good
>> as long as the checks are an overlay rather than parallel
>> duplication.)
> 
> I'd actually take the opposite stance and say that vfio is not the only
> consumer of pcim_p2pdma_provider() and if a device has a flag that it
> shouldn't be mapped, the p2p subsystem should also honor that, not just
> vfio.
> 
>> (Maybe you're also flagging that there could be other checks saying "Is
>> P2P supported for this BAR?" and they could be done in a generic
>> drivers/pci place?  I think so;  VFIO export criteria be the
>> intersection of VFIO- and provider-based checks.)

(Typo, inadvertent talk like a pirate.)

> Yes (I think).  If we determine that non_mappable_bars means both CPU
> and device mappings (which is compatible with its current use case),
> then fixing pcim_p2pdma_provider() to honor the flag fixes all
> consumers.

OK, makes sense.  Seems OK to couple CPU mappings and P2P; I can imagine 
quirks (particularly for RCiEPs) where one works but the other doesn't 
but, until we've a concrete example, affecting both is safest.

For now, I'll do as you first suggested ( :) ), and if future 
more-elaborate quirks arise we can revisit.

>> I was thinking something like...
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 00cedfe3a57d..9bb8bd153e12 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -359,6 +359,9 @@ int vfio_pci_core_get_dmabuf_phys(struct
>> vfio_pci_core_device *vdev,
>>           if (!*provider)
>>                   return -EINVAL;
>>
>> +       if (!vdev->bar_mmap_supported[region_index])
>> +               return -EINVAL;
>> +
>>           return vfio_pci_core_fill_phys_vec(
>>                   phys_vec, dma_ranges, nr_ranges,
>>                   pci_resource_start(pdev, region_index),
>>
>> (I.e. leverage logic in vfio_pci_probe_mmaps(), catch bad DMABUF
>> mappings this way, allows sub-drivers to override .get_dmabuf_phys.)
>>
>> I'll repost that as v2 if this doesn't seem an outrageous start. :)
> 
> That's fixing the leaf driver rather than the subsystem, where
> pci/p2pdma really ought to honor its own flag indicating the BAR is not
> mappable.  The precedent is already there in rejecting IO BARs.  Thanks,

All good; I appreciate the discussion, thanks, and will redo with 
checking non_mappable_bars in p2pdma.


Matt

