Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341062E11A6
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793605; cv=none; b=R45ntpRF8wuEgcRde+YL0yFxuN+rX/iw8SCOXcmv7C092ayaeQyhfGfKDRAyglLAXyIZrdNLfSv1Oh5/yXTiVoII9+TCxWfFH84rD6mDKrYi4HiKKVFOKRh8UjBngcc6wzgdEoq4+Yo2Q4nEJyGtVnO/xWb2gKLTkTx3YeSTvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793605; c=relaxed/simple;
	bh=8vGdUImmVndSByYxSgCmRaPsbh+IZA/1RgMErXMR+l0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fBvDqzsyteSGa3a+v9LHF8BOlY2WBXWBk+77IX1XZuf9Qk6mId39MfccNPI8zPA2mf8AAEeEsK6bpMeGWX4VZCdR+L2Kv9lRxV8q3gQEx+9ymuNcrnxJEBOWK2PqnT2mKVhqsq4ybBPh1W5gBljNUu9vyu2hY9sQHeA1Wov0mFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GmPfULKj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GmPfULKj"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L5Mtiw1984756
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zp70A21mqS9OtIIFTeWLYnfSrJjIB0JKsjmb1qYZRO4=; b=GmPfULKjUvwt
	PY56+BlSmwG67QGE+ZkNqZy4a0MhnMPTHDGfXKb+7o7rle/OGnvbS8eYQrQTQCRB
	br4F2TKCzChLfZDWENXQl7DoYI5SQwq+OXUcWT8t4h3C7Mj5c1r52KmY19Bn8DNx
	I1GfZSO8LoZOtexFq8VPachCbnMwxol2xbr/57g1ycVdxTxQEurevOiYFQRWV7k3
	iYVUd4pqivyq8iug7ZLAGy6xHXX+8W8Lo5BIBCTgnn1WD6/1H3ihC8wzBBuKlkE8
	Rfe4/XKeFXTtYw+fbmtYEwo4u2XwGp/ND329n+i14lEau5pIaJuie8gVQPboNhmL
	tC2xfkMlYQ==
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm7fb1us7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:46:42 -0700 (PDT)
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso37723325e9.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793601; x=1777398401;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp70A21mqS9OtIIFTeWLYnfSrJjIB0JKsjmb1qYZRO4=;
        b=g05ef+M9O40Ad2DtjDJhVWUZw2vPIF7C1As2KMBx2hpgNSBLo7gHXdy4RmemvGQw8K
         CwyWUxwMSM9DuTyocN11gCIr4df2NbgcDAo6zdN660EfQoQYoiIefCTX76buNlTqTXZo
         PheYdNGnuj46osXH5zaCg1E/VD0Hv5KDNmEScLu2ac+Rlr/4I2D7MxTNIl3rN0u2kqKW
         FRWDPVUbe/2OnlN38GNb9X3ob83mG8xm9SYDn+1YsPOJqZ32bzK/gI0vj0ufVA15zIDU
         timuwk+qrs79P+toZqDwdMxMHIe6Sj1hX2Mm7LwY5vPNrhM4FGqurQQFEQ/Mo7tfyWBy
         ioxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hunT+wrmdp0kNGsqrXFmXOovVimwSYf+wZX8Zgn97kc2T/B+O7VY7UCmYs6XOCOipDiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpGVPPwSYT/te5mbnSw7x1ynDFffgtU9iy2rzhFQdnTqBLBSV
	/QcvGuopOsY+Zqlqsqz7eZiCwYK+jp5sRuxFvo4ZxIjjYTSisdf+JgEKDfevowO7N0pPaDudFKk
	RTNUhBGlkKvrYywuxhRaPA1vm7AJnUAnK56/YlaDeg4LvfQP3yvx3
X-Gm-Gg: AeBDievfXhymlPSAmPS46rjJSNBOAxEWEJiR+YX1RRxZreu7/hfC0EygMMPG8GMrVc4
	FE+/aeWFwtunCpbFWK+JLMNwIyM0tk+FEzLQOd5eh8kE9o1jMDSWL9TShCMahSv9sBje8GT1CxK
	iKt3SROuyTszmPLSqOROwB9MT6SYiWZkz1WFFS/xvCUy7jSvAgVu2AhTW78B7Vg0QrFb6TBBWke
	ZK1lgjKLQjf77fKJIpoRoYtrWXqegu0xQjBaU/hJ+WdCjfpmzJIJUA+JqAj945lyipYJas167ik
	KYjPbHlLVo7MY4ll4+Z9CvIZBjmqCkuI7+bc+Cg6kfR7FbGl8WWe/q65d08KXFwGZxI6WF8Ki/O
	0AV2d7uvH6tp/vZMjMQqP/1Cpsl3CK6P10Cqa5SAa7Dgpbx8mO2Po6Lpesjqv+TKdy0WW/aIQAo
	0N+IPbrdlVa5M1jaI2gMMN9niU3zu/MkWm3K/oRIQRc/mxSlugpe62gCxXsDGk0Gc8TDtdv+eWQ
	TY7AKP03J/1NOZVtGmQHSzxZEEIy6kgBw==
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr279278765e9.21.1776793601217;
        Tue, 21 Apr 2026 10:46:41 -0700 (PDT)
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr279278265e9.21.1776793600637;
        Tue, 21 Apr 2026 10:46:40 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf7besm135201705e9.34.2026.04.21.10.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:46:40 -0700 (PDT)
Message-ID: <e44ba83a-bbfb-4c80-aaee-ab16026c666b@meta.com>
Date: Tue, 21 Apr 2026 18:46:38 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/pci: Set up VFIO barmap before creating a DMABUF
Content-Language: en-GB
From: Matt Evans <mattev@meta.com>
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
 <3fd01aa0-955d-44e3-aa4a-1918f9c42bb0@meta.com>
In-Reply-To: <3fd01aa0-955d-44e3-aa4a-1918f9c42bb0@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NiBTYWx0ZWRfX+leb+R0k4GY3
 FXxxksUKqTPz+JfOuaWRpT5iD2AC+NWeRbPgIQ+2d2QjdcKKIcRamjo4PIA4g6uyUhfcIC+OK7r
 zJTe3ob/nvOrW6yhiLdcna3HCdsuM3jKu5aP7eLcMsGvVPehWho1HFxxKIJ2PrKkAX1ZFy6cDLs
 HYEZgM+Y1B+LnCPAuN+SUZbSGOVqihTwh15qhiF3N7S/QlqANhUdg2qt6ioHUiQt6+nxIDg70Ux
 2ufwUMuKQUbBVd+MBXOcy8ew0Cd6uO4i/DX0SORM/Lrf4C+jyX/l2gotBhn3yb9sB43nSYR/MgH
 qbsuhy/sDWdP4iOHTbp8rsaC5BRnV+snV+y0rNq0RhYrgnYQe0tybjqe4+BpVFvhrJB0L+74k3z
 JOrIMM6pVfYCfSIuUmEFYVljDRfGFrtHT3uy+K7j2boLi+/4DHsDhb0+cstnpsssZAsPQ6KoxIG
 wfek8tK/ugORWiP6+5w==
X-Proofpoint-ORIG-GUID: vQilgqjBI4zSl5IgrPC7zRsNcg-OCFsZ
X-Authority-Analysis: v=2.4 cv=VevH+lp9 c=1 sm=1 tr=0 ts=69e7b802 cx=c_pps
 a=Ech0Gv1thIkdqUNjVc2Ehg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8
 a=ydsvmwYgiboQMSsmNQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cZgK7WzY9ta9U-6s7oqD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: vQilgqjBI4zSl5IgrPC7zRsNcg-OCFsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

Hi,

On 17/04/2026 20:11, Matt Evans wrote:
> Hi Kevin, Alex,
> 
> On 17/04/2026 06:16, Tian, Kevin wrote:
>>
>>> From: Alex Williamson <alex@shazbot.org>
>>> Sent: Friday, April 17, 2026 6:44 AM
>>>
>>> On Wed, 15 Apr 2026 11:14:22 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>
>>>> A DMABUF exports access to BAR resources which need to be requested
>>>> before the DMABUF is handed out.  Usually the resources are requested
>>>> when setting up the barmap when the VFIO device fd is mmap()ed, but
>>>> there's no guarantee that's done before a DMABUF is created.
>>>>
>>>> Set up the barmap (and so request resources) in the DMABUF-creation
>>>> path.
>>>>
>>>> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO
>>> regions")
>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>> ---
>>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> index 4ccaf3531e02..fefe7cf4256b 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> @@ -272,6 +272,15 @@ int vfio_pci_core_feature_dma_buf(struct
>>> vfio_pci_core_device *vdev, u32 flags,
>>>>           goto err_free_priv;
>>>>       }
>>>>
>>>> +    /*
>>>> +     * See comment in vfio_pci_core_mmap(); ensure PCI regions
>>>> +     * were requested before returning DMABUFs that reference
>>>> +     * them.  Barmap setup does this:
>>>> +     */
>>>> +    ret = vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index);
>>>> +    if (ret)
>>>> +        goto err_free_phys;
>>>> +
>>>>       priv->vdev = vdev;
>>>>       priv->nr_ranges = get_dma_buf.nr_ranges;
>>>>       priv->size = length;
>>>
>>> Wouldn't this get a lot easier if we just setup all the barmaps in
>>> vfio_pci_core_enable(), conditional on pci_resource_len() just like we
>>> use to filter in REGION_INFO?
>>>
>>> I don't recall if there's some reason we've avoid this so far, maybe
>>> others can shout it out if they do.
>>
>> I don't remember too. probably just because it's not a wide requirement
>> then was made in this on-demand approach...
>>
>>>
>>> We already tear them all down in vfio_pci_core_disable().  It would be
>>> a small patch to add that, which we would mark as Fixes:, then a small
>>> follow-up on top of that that removes any then redundant or unnecessary
>>> callers (all of them).  Thoughts?  Thanks,
>>>
>>
>> Agree. then the next patch fixing the racing conditions is also not 
>> required.
> 
> Oh, if we can do it earlier it's all much cleaner, agreed.  I'd naively 
> thought there was a reason it was done lazily.  One benefit is truly 
> huge TB-scale BARs don't get ioremap()ed until actually used by 
> userspace.  I can't think of a good usage example that relies on open 
> performance.
> 
> If you say fine, then great:  Ignore these, and I'll post a new pair of 
> patches doing that (...with a cover letter this time).

New series posted:

https://lore.kernel.org/kvm/20260421174143.3883579-1-mattev@meta.com/

(Titles/semantics very different, so didn't send as a v2 of this.)


Matt
