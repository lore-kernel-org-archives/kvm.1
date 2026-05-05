Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B03BE646
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004839; cv=none; b=pWiNuMw0F8Pb8kwD0Kxv8MebcrPzYdDQeH6nb7MDkXS4TLLn0/ERttKlppXPz7JA9Mq2YgfksRKn5EiTR3yJgEkv0nhqWdtdrqcypEZbmYIgdn0xI/pjQKE5W+9mkLL//7gh9KoEUZn5ew7oELQJvrfEgY+vSEU1sHqCVFWGVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004839; c=relaxed/simple;
	bh=3b27KxuKQlB4Xmy1kkKEdcO+WaPnuhruIPgcAT3CJvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPdjNRCGlZiajp6LaK3rxyOM9Vv2C/DyqgOhde/63m6f8UGiOeZKsyDQDAnfc4RkAqZ/59SkkMISSpMEhc9YJ4JmlOplwY6JjStusACzhpnxzhRTUappMjHVBhTJ2LQAUjaD7UGh7shSiCALGQoang5fThVbZaUbaQM4UhVDZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=s2knLRbe; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="s2knLRbe"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 645EFsSM3387585
	for <kvm@vger.kernel.org>; Tue, 5 May 2026 11:13:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=n/8Evrp0/Cs5xE91fVKhf/YUdfmd3rQjcqs7sGTTtLk=; b=s2knLRbegq9X
	RCpDDJ/hBxKjw2pRkecpdWzz2gHGLBfGVyowgs8mooCbRWX5MHpJSEhh8YVlH6AQ
	8RJ4/8+pU0ux8fOyIJoDPGbyaMfqNNhuUfCBWb+L+6lEdCNzSvCxg1fBEoqSc2+V
	EbmQz+k9tHe0F2aoDYv3pCDhVCvsHHbhW/6qRUBFrMHrkZVXCYrRkaY7BYYwJhni
	o1DNwr+CwfydLAJE+CuHn63B/ToXKcgo18Id141iN/gmxjPmOMMEzF5gNaollCf6
	s+rXyR2Cnq0QDf7k1BVwbMqmN9WyJoH39FmoZTvdqbFOhWUbt8KRnCrHywPFKfuB
	XIvDNHkjbQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by m0089730.ppops.net (PPS) with ESMTPS id 4dwcrntrgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:13:57 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f2d983d109so782007eec.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004836; x=1778609636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/8Evrp0/Cs5xE91fVKhf/YUdfmd3rQjcqs7sGTTtLk=;
        b=tSRqgVeWhJ5W69i3SzOH63wZIC6EhNmO/qjCUQmH3JPOp+2xCc5VLDbBrHA8+gCBnn
         n595Y0DeM+P77rNNTJd7w082GiyEFh8sOsBKjjwATTDyEuwKg2TlHFmioHdnBPnd+Jjx
         Akd6D2wSJoOP4VEQsarnXhfF1euu6ldErIsOANj4Gtx+uJvP1BjMoLBX15XpYo2+uYih
         RJcr3sqDmB2EuiUbA27ePkFmSuouUA2U48ar2aO9F0heGRHLFr7NXPU4jl2Hd7iddwWV
         HgpA0pA4+CMFvpiV0PqkbLond8V6zYGLqLTuryl1jp+R0mJcW5V99/KSUaPIKNRzG612
         z2sg==
X-Forwarded-Encrypted: i=1; AFNElJ/ixWaMBhots1i4eOOf1Hcn1Sd+YzW9j9j9A37dWmOw/QLBmCofScYr4VOCdXc2+1oaOy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRMU68s6BGAwk5RqjWXZNMdWTkj5aJoyw/CLRjyNS1ySBC5dL
	eUdAOGdGLQTLAUM6+8sPrp+YneY4NEdbJQOYZAiAvlb9RQDjMfV5HVJ3jaFbbJ+Jlj2ZUKTDqBc
	jmB7Bl4pjCH0BZuz701gaSKZqtD2s93z3GK1VECeYplY1asYi3DGY
X-Gm-Gg: AeBDieu3FcrcmVKLiMLQbsNG5g8Onvi24p1s57tDIMKna5UUcJZ1XS6fs33h02NHbwI
	aA7ErmCw/OPvjdGd+5UZPL34DYA0IK2mWx11lc0AfDvwLq4ICLHH6fZ8uXYrdGnLk24PxI/JPJa
	lWxZHJg4XWJgRHUmDESu9do8fhtSqWBwmf7iYouP/+768OV7agma8iOXDpvV3ORHfvZ3xiacnpY
	rwEXObiVraPfoRyu04btHLDz5UgM83+q2mjPT/6d5emZToQqwHh6xXmAumyPeAA0vUqmHXPMrzK
	c30bUjGrNjr2NzNDi3xfzDwCqtqnOy8i4RW19FaluLIl/JNT7jMepaHr9k2VNebJX4n46dLFOaM
	2nXAT0QZCi3a8wBkSMYn4HLnZDWon1bs6m8W4U9VQ
X-Received: by 2002:a05:693c:300b:b0:2f2:32bc:788a with SMTP id 5a478bee46e88-2f54b465ca5mr163902eec.25.1778004836039;
        Tue, 05 May 2026 11:13:56 -0700 (PDT)
X-Received: by 2002:a05:693c:300b:b0:2f2:32bc:788a with SMTP id 5a478bee46e88-2f54b465ca5mr163886eec.25.1778004835478;
        Tue, 05 May 2026 11:13:55 -0700 (PDT)
Received: from [10.0.40.29] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bc6a79esm25025486eec.26.2026.05.05.11.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 11:13:54 -0700 (PDT)
Message-ID: <2d0eb275-64ef-4710-806b-36f6b32f7122@meta.com>
Date: Tue, 5 May 2026 19:13:46 +0100
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
 <c598a21e-ee50-42d9-98dc-2959e84ace50@meta.com>
 <20260430171106.GA6829@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260430171106.GA6829@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8GAiikBrPFRxLWXEyDN26GNcHYImhRe6
X-Authority-Analysis: v=2.4 cv=Db8nbPtW c=1 sm=1 tr=0 ts=69fa3365 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=Dv35txUGz5gI0hTa:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=znC_9Zf_qiuKpCydwTIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3NyBTYWx0ZWRfX8KpO+ykymwzB
 6OodYueR4AWFro1c0sZB1JfldcC8S+BprNUOwvXJtmJykv6m6qyRJOG51Oh4Xtg1SJAoZTg+N6h
 sg0TliCI2MLDOc8yoFmcTWNkYyDlDwS+t7+A62FqTi1RlJaNfCJDbVrj9KCdUPB+GflxOpRbsXX
 v4p5KtyTsnqYYD3eIfa2RfPc16YH6/Y0gb7XYN7qbsmcgueYK6sLrmFcfkTBU4PHln0uQSa9lgm
 4BKSnZ/KRIIMi4uWeYWrmVqIeF++18ZHXzVVEfxSJmnUHeO2LBpAd2c7xTZHNBIqTaAnZGe3Skv
 uCqdj4Xzh7UviNZmP6L89yVreyNRh5Vt1H3G9bTEcRkdhgcrUbdllYcFMkoxn7aT1ZJKFhzlRlz
 MxT1iSlFSq66kUEfHFlZMAsauNLQjIIDj7l4Gjh+wZoMbYB3u8Q7D7vwYcJyIWMubPHnxWSxugM
 Dj2P1w3RxwX/JobsPOw==
X-Proofpoint-GUID: 8GAiikBrPFRxLWXEyDN26GNcHYImhRe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01

Hi Jason,

On 30/04/2026 18:11, Jason Gunthorpe wrote:
> 
> On Thu, Apr 30, 2026 at 05:47:49PM +0100, Matt Evans wrote:
>>> On Thu, Apr 16, 2026 at 06:17:46AM -0700, Matt Evans wrote:
>>>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>>> +				   struct vm_area_struct *vma,
>>>> +				   u64 phys_start, u64 req_len,
>>>> +				   unsigned int res_index)
>>>> +{
>>>> +	struct vfio_pci_dma_buf *priv;
>>>> +	const unsigned int nr_ranges = 1;
>>>> +	int ret;
>>>> +
>>>> +	priv = kzalloc_obj(*priv);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>>>> +	if (!priv->phys_vec) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err_free_priv;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * The mmap() request's vma->vm_offs might be non-zero, but
>>>> +	 * the DMABUF is created from _offset zero_ of the BAR.  The
>>>> +	 * portion between zero and the vm_offs is inaccessible
>>>> +	 * through this VMA, but this approach keeps the
>>>> +	 * /proc/<pid>/maps offset somewhat consistent with the
>>>> +	 * pre-DMABUF code.  Size includes the offset portion.
>>>
>>> I'm not sure I understand this comment?
>>>
>>> For the old path vm_pgoff for byte 0 of the bar starts at some large
>>> offset
>>>
>>> For the new path vm_pgoff for byte 0 of the first range starts at 0
>>
>> Glad you asked.  :)
>>
>> This is trying to achieve keeping /proc/<pid>/maps (or similar) somewhat
>> as informative as pre-DMABUF BAR mmap, in terms of keeping the VMA
>> vm_offs column useful.  Before this patch, say you mmap() two slices A
>> and B of the same BAR:
>>
>>   struct vfio_region_info bar_region;
>>
>>   vm_a = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0);
>>   vm_b = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0x4000);
>>
>> ...you'd see something like this in /proc/blah/maps:
>>
>> fffff4000000-fffff4001000 rw-s 10000000000 00:07 148     /dev/vfio/devices/vfio0
>> fffff5000000-fffff5001000 rw-s 10000004000 00:07 148     /dev/vfio/devices/vfio0
> 
> 
>> then the VMA's vm_offs would need to be thunked back down to 0 (since
>> the fault handler then treats vm_b + 0 as the first byte of the DMABUF).
>> That works/adds up, but then the vm_offs of both VMAs A & B both have
>> offset 0, and it's harder to differentiate in /proc/blah/maps.
> 
> Yes, and that would be correct.
> 
> The VMA output of lspci should show the exact pgoff passed to mmap and
> nothing else. Do not mangle it for "debugging".
> 
> pgoff is not to be used to show random internal FD details..
> 
>> We could possibly stash the original offset somewhere and then render it
>> in the name string, but the name's already about the max size and using
>> the existing vm_offs column is nicer IMO, doesn't need a new field, etc.
> 
>> I need to work on this comment then!  What this is trying to say is that
>> the DMABUF is made artificially larger than the part that is visible
>> through the VMA.
> 
> Yuk, that's another reason not to do this.

OK, fair enough.  I'll rework this and remove this one weird trick, 
thanks for the input.

Matt

