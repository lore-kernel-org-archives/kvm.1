Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C031F982
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174279; cv=none; b=pXogg8R4hH5ZPo8EonZb86SIw8LZxcT5mCVTBJqVpjiVp/AhwF3F4F1T5eiWYfiqqNOsjOWmBm2qup3FA1bspcHpULWJCAWx0PyJfLFCTQUsnjJafn41jAlbqds7tRxpLr4hzkCYV8s01el0LgCP09yKxY3vax70cJgVh5kUOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174279; c=relaxed/simple;
	bh=U69rHVcbDuR5mmmicSB4hQ3en+h1EfcsrBH5MCfaye8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HNFa+cpogh/QNlfDehdp5rFL8PBbN8rhoNxCqKIm2yFWKzdEE4eg2mGrRl/AUeK6mQdXYgWPhjhXd8zrUzPWTwfkPMut5D8vX6nYY0fvedcybPAi/ylqAS4B99BRzl6eKY61npFzKCcVlVw/kFbQxoC09D/tIreVjsQ361pgs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Qg6qXUNE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Qg6qXUNE"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646Mc7Xp3432042
	for <kvm@vger.kernel.org>; Thu, 7 May 2026 10:17:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2hseHusJHq4MxssvE9ph720WJzKkL0PdIQg2ntbbJzc=; b=Qg6qXUNE89L6
	+1ES/JHEoLIWulvpYZjGL9eLFRE+al8XgZoQ8YL/vXchbQbFrgU8ECcnx8vgaMhB
	GTxqwgWBviFZw2PcYYNaT1rfZofblWJNgGXEXTjDIybxE43ZtWQSvsNvmlX7vFO/
	0go7Uor9MuOCWiXaIbGZ2PKGWUYx60XssWozr1TyEmBZvoY/X8vkn1lSceRGZPfQ
	Su8oMk6xG+FtN054DdH+1h2blHvZqaHvayI8GoSnX83+ToBjab/+284lAwtmgqEG
	07naHNI1aSQw11PSjpb1QTqodKmpaVbNohVKeOsctRjkWzSfSxiMMguFRx/xw9th
	HExpZMTmKg==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwf37hg0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 07 May 2026 10:17:56 -0700 (PDT)
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d9ace59efso729997f8f.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 10:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174275; x=1778779075;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hseHusJHq4MxssvE9ph720WJzKkL0PdIQg2ntbbJzc=;
        b=HRuB9Sf5sArw5DNmwAFWsTDiPZJ9ANbw2mKvC5iVirYDnJBNf2Lln37lrm5KMmGrId
         tBDJHd1se5/BVYCT0Q1eXPb/TMuspRTPfftIyJi9WuGHMNVqHMQ4wJdQDoHiQ3UMWXaR
         sSO5oH+AXfXIR2GD1edObCXD64L5gymXhD1swYdfWJoXLb9Coea+RrfKjESGmL+wByZB
         wySdIo2BK77k314So417hjFYMzp0ViozBnSsnSyb1wcmi7A5dwUoPvG7M9gTaNhQOJTQ
         9S7Xuseu0rwsRG/1Cw86Uj3LghGz3C0jT8B0zQ0h0LSyNZH1AR71lxU73HEkaJJMUEV9
         S80Q==
X-Forwarded-Encrypted: i=1; AFNElJ/oo7WVRWEGUGr+mulelwREWXwlzLTrptoPbshsZCEqozP8fQv8jlEK+NQbVo2c9H+rWy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNE67+oiQ73IJUYc50In5rSMNl+0O0H/RdPHPLXq/L9yrE0I1f
	UvQ1OdOECPpDq7nF9S2kVbUTbmpBsAoGIfmyBziiNK/k2U+Yhe3m8BoUWVMSCKauIgcTSa3DxUw
	WaIVGGecwCuKJupSheU5Ju2nHGkpTnzjV4vNK1ia2rwjzlQHEbvj3
X-Gm-Gg: Acq92OF4Aaq6tXOkPnosCRX50JZqxj6TEBsAij8YtB2ARjIQfzFrrrId6Q6lDnSHo6F
	T9gzuHYoQeRc8MWZn97M4c/U39s6twHs9LXHB1xbQ2ZXZw/ln2SgQ1HFQapNSHXaFlJ8kFpwFON
	gGX4JVCIlwyvCUqixVQc4+JJ1zk90IapyQZ3M+Z7f6fK/LNf/JCguvBX75m2/X33rGevQrofjhB
	2fk8TnbKHIw2sAiCt9AG/nxNsA/zS4BYPfrLrpJCSauPXsdaboE4M9gV2lAHMP9AAf6DlWKpT2I
	oF3QDTLCSyKE4hjU0Cc+Tud3QRhXGI0W8wq5zeqUoE/1GVSNMNHTuvoFTaAg8fcXFUrCIu3Phc0
	jn6SO2CA7EgS5nk/X0Ypi3JwRBTbMe6dsS323fBYhhz+JvdRT+ti+ow3fY/cov2e4DTJ7GGENdH
	vnwF8Ba+2IAdZ5s8Zqt7bS2rEnrXBT4HuDIY6GqMUz2D93RICwGL4PwNIOa7sO9zN1GRxV5xxUv
	QVAm5uPD4qqlKAaIS8e4q+mWfUMNiJ3CA==
X-Received: by 2002:a05:6000:2903:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-4515b9f322fmr14370575f8f.18.1778174275504;
        Thu, 07 May 2026 10:17:55 -0700 (PDT)
X-Received: by 2002:a05:6000:2903:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-4515b9f322fmr14370521f8f.18.1778174275013;
        Thu, 07 May 2026 10:17:55 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4541282046esm408713f8f.8.2026.05.07.10.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 10:17:54 -0700 (PDT)
Message-ID: <afd17112-5d59-4a68-88ac-903616ed7dfd@meta.com>
Date: Thu, 7 May 2026 18:17:53 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] vfio/pci: Provide a user-facing name for BAR mappings
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
 <20260416131815.2729131-6-mattev@meta.com>
 <20260501164430.5d3ea683@shazbot.org>
 <7d370a5d-3730-42f0-8656-14ad9c0da682@meta.com>
Content-Language: en-GB
In-Reply-To: <7d370a5d-3730-42f0-8656-14ad9c0da682@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3MyBTYWx0ZWRfX00ft6cuYqV8X
 Jtj1CIOdPLsGhR2U1UhsR2mMgiBp5gVQ74E8WVo2tAw0dyPC0qZ6D1QpQ0IgfrI59z4kgWxG2Az
 uxS+nPIQ6qjAS+1GRllcEjSWC/YM19WDelszxqKJE8Y0em37DZVcVFvxBwGOHXlhuqJNl4tebTx
 9od23I/zcfpeiuhFLX/COVQXcoQw+tPoTnBnOu/SRAAR4nnRh1j7XYRk0WGNXClLav9z64tN0ld
 GxYfjMf9HEVpjcb3vmul2/dtY/NoeH1MIrWUV9TYUiIi/UWdXcH/z4nBRK5/4kS7LpNJxWYyRv7
 9au1xWXNgXUtAV9HVVyiv6DQXEHc0SzNJBHfUp8ydGheKIIDsTxvYrob8LYjuJ7xc1DlBxjbRQ1
 gzuaP7Cu+HxvNuOjS+0uwyWZ24hZ2lZfndYOYrUeZpylvZA2H6d/wfw7sHVApKQK9cZDRoCFIsx
 nfcppsqF9p0h0Egfjlw==
X-Proofpoint-GUID: CRvdkIexsXPIliAQyvqgD4ZGxTt74tnG
X-Authority-Analysis: v=2.4 cv=GKs41ONK c=1 sm=1 tr=0 ts=69fcc944 cx=c_pps
 a=pX1sPZUoWPGeQgUnKQNIgA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=gEb6E3g4VIbv0AVgNvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XGGHjNwGSpTZ5T66x7Ix:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: CRvdkIexsXPIliAQyvqgD4ZGxTt74tnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01

Sent too soon, :|

On 07/05/2026 17:56, Matt Evans wrote:
> Hi Alex,
> 
> On 01/05/2026 23:44, Alex Williamson wrote:
>>
>> On Thu, 16 Apr 2026 06:17:48 -0700
>> Matt Evans <mattev@meta.com> wrote:
>>
>>> Since converting BAR mmap()s to using DMABUFs, we lose the original
>>> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
>>> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
>>>
>>> This applies only to BAR mappings via the VFIO device fd, as
>>> explicitly-exported DMABUFs are named by userspace via the
>>> DMA_BUF_SET_NAME ioctl.
>>>
>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>> ---
>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 27 +++++++++++++++++++++++++--
>>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/ 
>>> vfio_pci_dmabuf.c
>>> index a12432825e5e..04c7733fe712 100644
>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> @@ -4,6 +4,7 @@
>>>   #include <linux/dma-buf-mapping.h>
>>>   #include <linux/pci-p2pdma.h>
>>>   #include <linux/dma-resv.h>
>>> +#include <uapi/linux/dma-buf.h>
>>>   #include "vfio_pci_priv.h"
>>> @@ -467,6 +468,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct 
>>> vfio_pci_core_device *vdev,
>>>   {
>>>       struct vfio_pci_dma_buf *priv;
>>>       const unsigned int nr_ranges = 1;
>>> +    char *bufname;
>>>       int ret;
>>>       priv = kzalloc_obj(*priv);
>>> @@ -479,6 +481,20 @@ int vfio_pci_core_mmap_prep_dmabuf(struct 
>>> vfio_pci_core_device *vdev,
>>>           goto err_free_priv;
>>>       }
>>> +    bufname = kzalloc(DMA_BUF_NAME_LEN, GFP_KERNEL);
>>> +    if (!bufname) {
>>> +        ret = -ENOMEM;
>>> +        goto err_free_phys;
>>> +    }
>>> +
>>> +    /*
>>> +     * Maximum size of the friendly debug name is
>>> +     * vfio1234567890:ffff:ff:3f.7-9 = 30, which fits within
>>> +     * DMA_BUF_NAME_LEN.
>>> +     */
>>> +    snprintf(bufname, DMA_BUF_NAME_LEN, "%s:%s/%x",
>>> +         dev_name(&vdev->vdev.device), pci_name(vdev->pdev), 
>>> res_index);
>>
>> Comment suggests 9 is the max res_index that can be printed, but mmap
>> only directly supports standard BARs 0-5.  Comment also uses a '-'
>> while the code uses a '/'.  Thanks,
> 
> Right you are.  Fixed, but, since...
> https://lore.kernel.org/kvm/52162da4-e1cc-4f90-a95a-218d6089cd71@meta.com/
> 
> ...I'm keeping the resource index encoded in the vm_pgoffs and as that's
> in /proc/<pid>/maps it doesn't need to be in the name. I.e., an example
> mapping of BAR 2 looks like:
> 
> ffffa9330000-ffffad300000 rw-s 20000030000 00:0b 12 / 
> dmabuf:vfio0:0000:00:03.0

BUT, the name's visible via paths other than just /proc/<pid>/maps, e.g.
/sys/kernel/debug/dma_buf/bufinfo or /proc/<pid>/map_files which don't 
have the vm_offs, and so back to plan A.  Just made the comment consistent.

Matt
