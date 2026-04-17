Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF167301471
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453081; cv=none; b=onSK3j1TyzBibyGUj+J10g2PQyzXaEFnywOuqNJ3yaFOpn46SQzM/vCGLqWA3XnhA1SpCeB7f0Caot9CeG1x6ZKKz9YKhm+u3Noy7txOgpkrxn10c6XxUbZBQIxf76Mq3s2hQuZygJVtaQQqohTf4+iDIh44PT7KZ5vS6wZO7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453081; c=relaxed/simple;
	bh=EksppSzDvSsQ47uGzr1p+yvuq0K5vNjiJB08Vn6uppE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iY0pug4nk/PPAsok7luFsr3dC/3NQP1v3A3rxc2EKnyF/MgKEQbM0kB9Dtq9o8kurP1rbjtfzlYCK/nScdMC9ecn8ubLKdZoDLysKNDYtUrbJJ3SO4s4o8+jGJ7BSVfp8z6mt5T9N1YvXBatxo8exe/11no5XpUWlhqv/W49Dog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PETTrcFr; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PETTrcFr"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HEVPsZ2871747
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 12:11:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=o3IiKyLMZoDu+X3sU+tCyrGh2WzQ0LhvoZB3ShYXAMA=; b=PETTrcFrd5jp
	8oqZ/PWFlMifNFdW8CBPDyGkJPZmGlusiNeAQnLNRF2pWWoLC228XRJpa9VzsNhW
	1z3N9yP+YLBMC2NBR+XP+NUZ2s+SdZF77mBG7zlBaliHp59tNAeT6Sxf5B0PgAcU
	UTFL3E67DkV+B8jj1X1FTaTP9/43Qq2TUuHT674vm8lcU/xRgC7552dhQMSZ0T/S
	J0VlIuF/rbgGuU9m7wmvHZ7T8ZR4+x3B/jGjz4oAO+SD3UgkII1unfyEvxGLsorL
	xyfy7mHs/Fc4Y0PXxID4ppNK6T0S9ORx9tGfhw3xBVpx32/iL7WfZQNQiDMNSDy6
	9v15gBUoxg==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh85deett-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 12:11:18 -0700 (PDT)
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c768a9a9so6256355e9.1
        for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 12:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453077; x=1777057877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3IiKyLMZoDu+X3sU+tCyrGh2WzQ0LhvoZB3ShYXAMA=;
        b=UbauOpRdxxiJuaP+91qjPslnU66j4mawhgDOIAEjKBhi8QB1WnX/m67SjrAU9igi6j
         HKIuA4g/jrvxNJwDt89utbwPL3kHgM4z19N4SGrd3WkDKwo0QOYPeX1p/jOYgUE6mTu9
         EQ9y0xZZ/3er+8yB+nsqeAXWwdShXkUd3CvuJns85owji6bQE0q43EYRhEpV1JWujJU9
         p3wqRCV+gbn7nZg0gT+wbS2swsvVh+hSC9IOVnt5vSnuo/WzU2bdOUk6BAGaTgKhZt+9
         UcKfdOZJYnbSzSrCl04N8ohSuVyjXVFOMYqo7ny30EaERg91O0ta0tLNodDe65VR9t03
         S7jw==
X-Forwarded-Encrypted: i=1; AFNElJ8iMKXYymWSzGINqXyVfMcbockIf5gMgC3FBH1zTNrWZycuE5EbJwbJZe4XVeEPWP/rK9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTdvfTQ3X5otB8BMCJaY9JFA9shMdzI7u90HhFJ30Ze/wuQp2
	nlA5kITZolUk3IoinvLa0rQ5ToaI7PcmgSjREx3Q3DFeg6bwvTMTAS9eFawcV6ptU4Toa47POTy
	jouPyw5H2pPHgxalLXHwBy2S41u8lUEUNesn92JV7KjwQZgOGVtJH
X-Gm-Gg: AeBDietPkYCHbpYnDcd8aYbLLoybYLkGJlfSaLS3ySVDzM+kBGm+7hl2nmU3zGwEwLl
	LEsba/o3jjEMuL9dFwxVGGC0rRcVZePqZF3NTYbPPNhx56AsE7FI27y9hS4z8H17e9TKMnldxFm
	1r3B89wDOK2z8q+/OxPcNcbRXbR/nIP1/R1qpb6KocjHNiTKCpxUBvLMWdHFuesrXKmVSDF/Mck
	RTWx01ptuDgcoOZMnmesGhE4nwanvgU1HoBthrvPhmbsxMWKXWPeCN7IblMlLNG9YXxf22UGaDy
	Nq0bM8pLNUGBotQcMpFU6WqDtIEkupWqOEAEWiGg6BhzsLu5qT8wZxuD34M8cX4C7EkQDgsChB+
	uclVfiYyR+DbjarBGfMfAuOsiVhsBGh+ytKyZO9V6ODybMsLF4aNzeWmfk9F7jRin5csDVASQBD
	qmik4ppXieaFX7HgrbRMCA39aB4ZhSGAWwKLNelQryuoDHZw79b5ztyuPS2ZblM/l39cGSH34iT
	QBAy67K642Qvd0UfJnCCyP1GOeaZE1DUg==
X-Received: by 2002:a05:600c:c04a:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-488fb750840mr44340365e9.11.1776453077144;
        Fri, 17 Apr 2026 12:11:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c04a:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-488fb750840mr44339985e9.11.1776453076662;
        Fri, 17 Apr 2026 12:11:16 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm60219315e9.12.2026.04.17.12.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:11:16 -0700 (PDT)
Message-ID: <3fd01aa0-955d-44e3-aa4a-1918f9c42bb0@meta.com>
Date: Fri, 17 Apr 2026 20:11:15 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/pci: Set up VFIO barmap before creating a DMABUF
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>
Cc: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum
 <skolothumtho@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
        Kees Cook <kees@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
References: <20260415181423.1008458-1-mattev@meta.com>
 <20260416164406.7fb3bb0b@shazbot.org>
 <BN9PR11MB52768421EA5D79C469B899C18C202@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <BN9PR11MB52768421EA5D79C469B899C18C202@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE5MiBTYWx0ZWRfX2rbcJ2rR7wy+
 Ku0YVZxWUBKFPD0GaadnyuJxi7SxMawlV2QpwXhON0umdSCxZilmCSlTJmn0CSssrAjQmxnxiKA
 DInS0ntXuahvA8Prqmt/2u+dGAfS5tUFmXVhzUnTKHy1vRvxfOuXh76C8jFexj2hL90yE9RNVSn
 xpuxtmZnvu2I1+7UuKyMawfaSRORicaeW4ARwQLtbFvVWnOAAwqBQjpwIxXrZpYwq2LT5u41C0y
 0Ua07hNumPHFui7p5asuiAbGRmb9PVtMbeT2wlI+XJPktZ5QJLZWc6DkV8XAQmvkufTEKcFuJVO
 Vf9iNXijOzll86FtZxd3urormXb2UmwXDzj4PKgX8lasGoyYkcIRdrrToZowDZGPm6o8d1/iefm
 ngFTXMibg/VmETVy1bEv3fhHJZ9w5qRmhM0JPsIdLz32tCE6TvJbABhBwUXGhty2hw1prPOdz8t
 8lt4L9F3nc2ZQ9RMDpw==
X-Proofpoint-ORIG-GUID: OuWUBACBUSN7ljs1lLwAsDRczkeFskg4
X-Authority-Analysis: v=2.4 cv=Xfm5Co55 c=1 sm=1 tr=0 ts=69e285d6 cx=c_pps
 a=ocXdEHcuFBd2kx0v6vcWqw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=Nw9sHT1wb8GjpDreaWAA:9 a=QEXdDO2ut3YA:10 a=XRP02QYyWapGEjE7oHHB:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: OuWUBACBUSN7ljs1lLwAsDRczkeFskg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01

Hi Kevin, Alex,

On 17/04/2026 06:16, Tian, Kevin wrote:
> 
>> From: Alex Williamson <alex@shazbot.org>
>> Sent: Friday, April 17, 2026 6:44 AM
>>
>> On Wed, 15 Apr 2026 11:14:22 -0700
>> Matt Evans <mattev@meta.com> wrote:
>>
>>> A DMABUF exports access to BAR resources which need to be requested
>>> before the DMABUF is handed out.  Usually the resources are requested
>>> when setting up the barmap when the VFIO device fd is mmap()ed, but
>>> there's no guarantee that's done before a DMABUF is created.
>>>
>>> Set up the barmap (and so request resources) in the DMABUF-creation
>>> path.
>>>
>>> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO
>> regions")
>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>> ---
>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> index 4ccaf3531e02..fefe7cf4256b 100644
>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> @@ -272,6 +272,15 @@ int vfio_pci_core_feature_dma_buf(struct
>> vfio_pci_core_device *vdev, u32 flags,
>>>   		goto err_free_priv;
>>>   	}
>>>
>>> +	/*
>>> +	 * See comment in vfio_pci_core_mmap(); ensure PCI regions
>>> +	 * were requested before returning DMABUFs that reference
>>> +	 * them.  Barmap setup does this:
>>> +	 */
>>> +	ret = vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index);
>>> +	if (ret)
>>> +		goto err_free_phys;
>>> +
>>>   	priv->vdev = vdev;
>>>   	priv->nr_ranges = get_dma_buf.nr_ranges;
>>>   	priv->size = length;
>>
>> Wouldn't this get a lot easier if we just setup all the barmaps in
>> vfio_pci_core_enable(), conditional on pci_resource_len() just like we
>> use to filter in REGION_INFO?
>>
>> I don't recall if there's some reason we've avoid this so far, maybe
>> others can shout it out if they do.
> 
> I don't remember too. probably just because it's not a wide requirement
> then was made in this on-demand approach...
> 
>>
>> We already tear them all down in vfio_pci_core_disable().  It would be
>> a small patch to add that, which we would mark as Fixes:, then a small
>> follow-up on top of that that removes any then redundant or unnecessary
>> callers (all of them).  Thoughts?  Thanks,
>>
> 
> Agree. then the next patch fixing the racing conditions is also not required.

Oh, if we can do it earlier it's all much cleaner, agreed.  I'd naively 
thought there was a reason it was done lazily.  One benefit is truly 
huge TB-scale BARs don't get ioremap()ed until actually used by 
userspace.  I can't think of a good usage example that relies on open 
performance.

If you say fine, then great:  Ignore these, and I'll post a new pair of 
patches doing that (...with a cover letter this time).


Thank you,


Matt
