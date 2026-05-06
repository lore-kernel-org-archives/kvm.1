Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B776026
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094195; cv=none; b=QtEgW+1rhozlLy+atEwiUhNnmWZTvqVWGljUz8VTBvo8PQ8rwi8hNTGTlvXc5bjOZdtsTEnRy85dVVnDJd1IC4exAhFEk7HCuZWnfPkGHNhukcjwSiskeSASmQek0CgFQkwk/IehIWOBqBy2ZPYou4zY9GhPtVC+IUBm66uu1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094195; c=relaxed/simple;
	bh=ucYbyvlYxaFLGts6RMyMVbsyam+NzGAJfA3NYBzz1MM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kDqqhIHgw9dNvwzDh6Iv7co4NDmo2huAhWELQMeCkcZQUr/HkyChLAH5OWQJA5fMBEb3U0u4ixB4vg4/GCPoBOisFXOKHY/pAsOi7Snflz56yHVHc95Fkqb3GUmsABpka/bRVpcBcWgdDd8/3Mmj/wl7tPtKbS+Yq7qmrU4xX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Z4RSZl73; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Z4RSZl73"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465xD7J1782252
	for <kvm@vger.kernel.org>; Wed, 6 May 2026 12:03:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=5ISWZb2UuFba0k6oi9EeUbt30lbvtpS4mraM2wLVkyY=; b=Z4RSZl73zxAx
	zZGJKjWbu3zTJO2Bsk7H+t9eLU0pGSMUd2EWPWWmTWTrjcXJW+t9cykPVmWT/6Na
	WhFVloj/P5riPIh99O4KiziEkw1rv5LZA/mZhy4TyD7T0ICAUcP4MGYeNRbK/nHE
	r9mAY5EM5AxyDLUb44A/sl+y/vDtcJn+m0fJvgbR80rNhdJ0BjHN943pa5tqCWng
	PbPABcZ9oR39oGQYRUmyHdfUR8kptlyAkWGNdDRXzAg9SW6Ud/2laX0vukK4dV7V
	GrqhUuFJxQOsbFydokpDYy0yIbLdkYADFwS9VzcXfG4iefkHSRTb5nZbsmrZvwQn
	GMozv0gGUA==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx2wdy3cj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 06 May 2026 12:03:12 -0700 (PDT)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d127eb013so161335e9.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 12:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778094191; x=1778698991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ISWZb2UuFba0k6oi9EeUbt30lbvtpS4mraM2wLVkyY=;
        b=JatWhiO+0cHxq1OW8POsjwHgA6mlc3In/GikcoJzQYG9Ys1qaU1kh8ysnuOuW23ajv
         NLnfuxmti2/a0Vx3f5uEY+Nn7sYTIfv6FMrA13qGrZM/Di9+rKiOAbrkgfAYUGMA40M1
         o1zXNXC8jum3yPRUlPQnUeiuvcRCn/LfUVBLLcC+O8547yc/7iyvSfkN5OQ3UXJzUqwR
         Jff60f+vrx+2hhhi5a2JYlwp0Asa2Nf9JzBEW8wV6nKcmfvrD6gmCLlM2XOzFAM4bmHD
         SW30+IYJZfVHuSmctou3X58OcDZjNPrlajtvzs4JvB8BxTHRJ2TX74yoJ+zHAspzXZWL
         f07w==
X-Forwarded-Encrypted: i=1; AFNElJ9nVjrs8rD35EeH9bdrszHFhKf2XRv8QDiIq5oy+1XVYF74RVYQ2WZHjfVWWXI26c69xJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPJIvEWdqlGzYy0HiOSIC1URPA6MjoefdIzmhYf7z+Pvig3Fe
	L8EVNw2a+aR2otbkrYY9JCluBG4Tb8OjIxqgA0ZcvagoCE4QDeWKUjIoLSh1qlOnkivVmZjrm66
	Ux1GeaOOZKY5p1QB+Ge42wrMfvWz7H7fZn9ieEap+2INaEczB0/Il
X-Gm-Gg: AeBDieu9fH98v/PpKMOa0oH89JC38TeuKZXF1EHfKnBRCiipY//eV24V6iN20abqP6X
	tXb5QsZK5KsewN//tho43az4ad/NjdbM2X/jESY3wILS9ngagjVAUuoSAJHLzi0eeOIeVxrmN4Z
	vdmritbYbGnAEx+H2JO2uq2JgbD2W3EaGMA3R9IwVh0Nc1scRdl6Te3TV2rwifnd4fGFGEh6l1z
	AClsBQgBzREnqeAKXMho/DKjSJXSu0LuffWeAC5OSmASsQVn/ay5ivOoYf0Wm5kdWZdXIO70u9s
	XfNTaz+HB7td7GwXo712AB76f33uu+R00OP3p7+xw/3OMgMV548zf5EmlNTFbEb9fLeQxm3I/QT
	0gyIsTkcrR42U6ryRN6VfbeYETAQ//JzPMYIDa56zpekrzpzoxiilVsKezVyhEkwlpQPdeZZkb1
	Jh1i3uYBxjhpK/NQdP+/TeUS6OdZ9eD3OHOt/62/V89zznVGYRoss/TpdK/NwyeexBp/2gp28BP
	mkhTd+YSwE5sCCne2TNslZRAlP8zF4wXw==
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e51f183demr77118385e9.5.1778094191039;
        Wed, 06 May 2026 12:03:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e51f183demr77117815e9.5.1778094190534;
        Wed, 06 May 2026 12:03:10 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fb19csm62944065e9.11.2026.05.06.12.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 12:03:09 -0700 (PDT)
Message-ID: <52162da4-e1cc-4f90-a95a-218d6089cd71@meta.com>
Date: Wed, 6 May 2026 20:03:08 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
From: Matt Evans <mattev@meta.com>
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
 <2d0eb275-64ef-4710-806b-36f6b32f7122@meta.com>
Content-Language: en-GB
In-Reply-To: <2d0eb275-64ef-4710-806b-36f6b32f7122@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fLsJG5ae c=1 sm=1 tr=0 ts=69fb9070 cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=Dv35txUGz5gI0hTa:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22 a=lFmndaL0naqy_eS1C0EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Ng9YvVcppn9CIdWre3nD:22
X-Proofpoint-GUID: 4dEjPEMj70ZPSZXOa_V3y1EHDeNn7xdz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4NyBTYWx0ZWRfXxYQu8/9i9Ayk
 zaqMKenf2UID05PR3SvX1/OE1Tee4KgUkkfdmhzg7TpuMqtwPArl0Z6Fu4oLPsVzPy45IwTBmtE
 hJ3AkanhV6+pFhmfuF1lIq+UX8GG2dgm4Vf/J5cIBPXeREJgrGnsbU/kX/2qvuJi9T9X2JqYH9D
 r/l8+QtY5JQ4CsKGGvRaQzFLoaCpGMBlTgvc4XvjC8POrGXumiHNgf/kijZegWktFxtBPIlg8WR
 coV4lDlFZxbVUVdV4dCxU174o9d9eLPq9PKV3cFq/au7s+ukYUmh+4WwDeNSB3ZSsDAbFd8ngXD
 Jh8xw8J1eLesraNGPRsWP7E7M6ZqfQogSpB3w7A9ZaSVeia0gXaQHbgH1vLvY+nmdg/I0hHYNfE
 hnayqD1fzrnLTITuFOFCCk4ZMMike7zZrG29GkYV+MD5RDiUQNY/s+sseqoXpB29B5CdL9v/k9n
 SVy/p71cdnBcMO8QkFA==
X-Proofpoint-ORIG-GUID: 4dEjPEMj70ZPSZXOa_V3y1EHDeNn7xdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01

Hi again Jason,

On 05/05/2026 19:13, Matt Evans wrote:
> Hi Jason,
> 
> On 30/04/2026 18:11, Jason Gunthorpe wrote:
>>
>> On Thu, Apr 30, 2026 at 05:47:49PM +0100, Matt Evans wrote:
>>>> On Thu, Apr 16, 2026 at 06:17:46AM -0700, Matt Evans wrote:
>>>>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>>>> +                   struct vm_area_struct *vma,
>>>>> +                   u64 phys_start, u64 req_len,
>>>>> +                   unsigned int res_index)
>>>>> +{
>>>>> +    struct vfio_pci_dma_buf *priv;
>>>>> +    const unsigned int nr_ranges = 1;
>>>>> +    int ret;
>>>>> +
>>>>> +    priv = kzalloc_obj(*priv);
>>>>> +    if (!priv)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>>>>> +    if (!priv->phys_vec) {
>>>>> +        ret = -ENOMEM;
>>>>> +        goto err_free_priv;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * The mmap() request's vma->vm_offs might be non-zero, but
>>>>> +     * the DMABUF is created from _offset zero_ of the BAR.  The
>>>>> +     * portion between zero and the vm_offs is inaccessible
>>>>> +     * through this VMA, but this approach keeps the
>>>>> +     * /proc/<pid>/maps offset somewhat consistent with the
>>>>> +     * pre-DMABUF code.  Size includes the offset portion.
>>>>
>>>> I'm not sure I understand this comment?
>>>>
>>>> For the old path vm_pgoff for byte 0 of the bar starts at some large
>>>> offset
>>>>
>>>> For the new path vm_pgoff for byte 0 of the first range starts at 0
>>>
>>> Glad you asked.  :)
>>>
>>> This is trying to achieve keeping /proc/<pid>/maps (or similar) somewhat
>>> as informative as pre-DMABUF BAR mmap, in terms of keeping the VMA
>>> vm_offs column useful.  Before this patch, say you mmap() two slices A
>>> and B of the same BAR:
>>>
>>>   struct vfio_region_info bar_region;
>>>
>>>   vm_a = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0);
>>>   vm_b = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0x4000);
>>>
>>> ...you'd see something like this in /proc/blah/maps:
>>>
>>> fffff4000000-fffff4001000 rw-s 10000000000 00:07 148     /dev/vfio/ 
>>> devices/vfio0
>>> fffff5000000-fffff5001000 rw-s 10000004000 00:07 148     /dev/vfio/ 
>>> devices/vfio0

Looking at this again, I/we got this backwards and I mixed up two things:

The goal of this patch _is already_ to make sure the VMA's vm_pgoff 
(whether viewed in /proc/<pid>/maps or elsewhere) still matches the 
mmap()'s offset.

(For a mo, ignore the resource index encoded into the offset.  Consider 
just the offset into the BAR itself, inside the VFIO_PCI_OFFSET_MASK. 
I'll come back to the index encoded into the upper bits.)

>>> then the VMA's vm_offs would need to be thunked back down to 0 (since
>>> the fault handler then treats vm_b + 0 as the first byte of the DMABUF).
>>> That works/adds up, but then the vm_offs of both VMAs A & B both have
>>> offset 0, and it's harder to differentiate in /proc/blah/maps.
>>
>> Yes, and that would be correct.

Why?  This paragraph was outlining a hypothetical alternative 
implementation that creates the DMABUF the size of the VMA and starting 
from an offset into the BAR based on vm_pgoff, and then compensates by 
setting vma->vm_pgoff = 0 so that the fault doesn't re-apply the offset 
again.  That would make byte 0 of the VMA access correct:

   BAR_start + (vma->vm_pgoff << PAGE_SHIFT)   [1]

But it would...

>> The VMA output of lspci should show the exact pgoff passed to mmap and
>> nothing else. Do not mangle it for "debugging".
 >>>> pgoff is not to be used to show random internal FD details..

...definitely break this property, no?

This patch is supporting that property by instead creating the DMABUF so 
that the VMA's vm_pgoff (which is maintained and the same* as passed 
from mmap()!) indexes the DMABUF so that byte 0 of the VMA accesses the 
same address above in [1].  The DMABUF spans from the start of the BAR 
so the fault handler maths (which indexes the DMABUF by vm_pgoffs) is 
common for all buffers.

  a = mmap(0, 0x10000, ..., device_fd, 0x4000);

          +0           +0x4000
          +------------v------------------------------------------+
          |               BAR                                     |
          |                                                       |
          +------------^------------------------------------------+
          .            .
          .            +--------------------------+
          .            |  VMA                     |
          .            |  vma->vm_pgoff = 4       |
          .            +--------------------------+
          .            .                          .
          +------------+--------------------------+
          | invisible  |  DMABUF                  |
          |            |                          |
          +------------+--------------------------+

Same* externally-observable behaviour as the old mmap().

>>> We could possibly stash the original offset somewhere and then render it
>>> in the name string, but the name's already about the max size and using
>>> the existing vm_offs column is nicer IMO, doesn't need a new field, etc.
>>
>>> I need to work on this comment then!  What this is trying to say is that
>>> the DMABUF is made artificially larger than the part that is visible
>>> through the VMA.
>>
>> Yuk, that's another reason not to do this.
Apart from the yuk part, do we have a specific concern with the 
invisible portion?  Perhaps if one could fish out a DMABUF fd somehow 
(it's a file, but no scalar fd is returned to userspace) then the lower 
BAR addresses could get mmap()ed.  Isn't that at worst as permissive as 
a "closed" VFIO device fd which could get fished out, e.g. 
/proc/<pid>/map_files, and mmap()ed again?

I went through other approaches, but they either need special-casing in 
the fault handler or DMABUF-to-PFN helper, or as above would modify the 
vma->vm_offs.  This seemed best overall though, as ever, open to ideas.


*: Region offset:

OK, so this patch strips out the high bits of the offset early, so 
that's disappeared from /proc/<pid>/maps etc.  You're right to point out 
that the resource index could be carried such that the vma->vm_pgoff 
really is identical throughout.  I'll restore that so that the VMA's 
vm_offs is identical to that passed via mmap().

Does that seem reasonable?


Thanks,


Matt

