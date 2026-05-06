Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151F44D039
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085768; cv=none; b=VaGovEUXrQWDM+um/pwtkoBVOBtv9uS7swypkVPV5kJY8Whdx0bRNcWuvAR5kmph6Wr/TcW2xBbSTUMvasxp3uPZsJUrrTgNsK3ornzNZRugXynbouWjDZkDRHrphwp97KEEMPVN32JSIkKMfQBuWqMVtWKtiuSi8G8pI88k6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085768; c=relaxed/simple;
	bh=PIgsAxwjAni+ibNITbesgAa9yzG9WpIb9zhCZJY95/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLzWHcJVq9HBXd00HKHACIdPSQK3yzPIJm2bb8BnKI8tMz6KIq28sw8isyirC0xr2flkZmLG01mi3q6765DR6hxvIC/5e7xfs5j0tYvB3E6O7Rab3Q7WykgMAGvIp/eGC7C/SYmNlzZ/jlLkcC1WS9bw3dP/UL6h2ZnAYAWNWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LVK6U0wJ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LVK6U0wJ"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6463ck0b1334446
	for <kvm@vger.kernel.org>; Wed, 6 May 2026 09:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KvzelPFNcl7MU+TM0miXboxQSsRGRRlAbQLX3lQgau0=; b=LVK6U0wJ9iIb
	vlscmhtMH1uiKx6GtvkvD3PFd3zgD6F0pJGalLirUzyn7txEkM7B87H6hJ3gBB/R
	xy6LpmR0MAd+x0ZIqp8r0Hyc0y1/04XFD7dLYOiSF6fGh+E8tNIVi/vB/zavG3F8
	8TN42shcv5hTMVXNvb74VYPbCsICbn9zU0M4AXi1sq9f+h9zZCOy9fgdkWE+OWLN
	jvoNlSSljZ+OfTzxu3364d0Kvicl9FDoxbDiiEVrSaNxol0u2vIUnHyNPLDd0Ix5
	f5o4c4x9PCLCIVbSwzFZPTO6tjK7i7qWftyIVCUjJ+tCPZ9EmmMKHs9roWgbBdAX
	UkgXxMdO6A==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx1wgx6q0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 06 May 2026 09:42:45 -0700 (PDT)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso80781525e9.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 09:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778085765; x=1778690565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvzelPFNcl7MU+TM0miXboxQSsRGRRlAbQLX3lQgau0=;
        b=mO2FaX2Kfeh6yioPLOkmprjoYsbpB1N2lkXo5bvXg5UCSU5wv/jbX4kA2XOeKhAmOL
         24rBpr5Y6wr/tW9wqOMT2KgNDJp+vSdb5K3byK/pvSQrtnRNish5XLMUQ6ujecVOFfUR
         Y88dG0ZTSUj7FqyxhiCKZlj/s0vlHLHgjEsKS89iE/QBvrRug54axvBHP1+lI/8gIGve
         vlNaZOe0YnX1PS70RmLjIeHPzrTxRodqrYjcBJL4S5LZMgsHW9r8VdR2DrjFDrZwM8fz
         B5p5iTSVRs3JkQCg1Dp+/qAS3s99OU2Cg2w5DYA/epuSN64eDyCOufS53uU8Dv+SdA1G
         zy/w==
X-Forwarded-Encrypted: i=1; AFNElJ+yLLPaGY648geC9WtP+1gYSZMe23hCiYhrxcIpjyfMwy8DfnMRHFIE86QkSorN9A7lCqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdz+O2KxD+985fBQfCIQnxtKXhC9khKFWqKHZ9gwA6H624F1Gv
	NWbpb7DuwXgf2tUoz23q762SNXEBHEwJWuALlNpBCgKm3YgFfja5FIGlpndX3h2WSTQxM7n540W
	VFLjPHB/khcPyXZAkK4I8INywr1+GG8UtQg0fxsSJHc//N211YAzS
X-Gm-Gg: AeBDiesKEUdiAXtPuss7qPu860x6SR8KxkgTvGuaxsFJWzFRTRz0SRghMIVwEJ3Fq4h
	HtUwHMtleXnTWR/5zwCMxVgw2zpHpKytPXQEkIWJlQ2lX2hVEjy43Ybs/PcUvNKTYjgAD3QbFEf
	3WrNF2q0iJErdbNsgwMprNoKLrid+WVkqqfbeZDpYKyfcDY9wwTa6j+MsRIMJ9Tp1EprPP4avWq
	/W+kjeyZXeULlrMEnSJl5eFjJUh1/l+C2qXcU93C/p166PLAmrNQwqpSg+ZACCvS/DzR+5BGin3
	45x+7AjfpweelPtCTcfMPlMORffQ356B8hk9j1ZcZNRmguG2woQP/qvAYqPC/wnw+MhsWwJUSuP
	Z/93uASor67qepYhTw9RLUAdGFeEcl9tiQcQs9w7cX6v7/n3RaO7buhVgqUVoUqRNx+CdbfRk1Z
	AwsZ+XgAddGkRhIb8iVAXh3I7hUAmjZFenjEy+7l+EheRVLClkoQCRhHKYIa0URG1rwLmzcTWoA
	TpuaicbHzGWyVBRDbStpIty+Y0sYrjvBA==
X-Received: by 2002:a05:600c:2ed3:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48e51f427b3mr46111855e9.15.1778085764690;
        Wed, 06 May 2026 09:42:44 -0700 (PDT)
X-Received: by 2002:a05:600c:2ed3:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48e51f427b3mr46111525e9.15.1778085764222;
        Wed, 06 May 2026 09:42:44 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fb1a7sm113622555e9.9.2026.05.06.09.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:42:43 -0700 (PDT)
Message-ID: <9a7e51bc-351d-4ca0-8080-fd9e0265f3a0@meta.com>
Date: Wed, 6 May 2026 17:42:42 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
        kvm@vger.kernel.org, =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-2-mattev@meta.com>
 <20260501131236.278ac431@shazbot.org>
 <9304aada-ee84-4cf2-a1d7-82313eda07aa@meta.com>
 <20260506152937.GJ11063@unreal>
 <c0bd0e23-712c-483e-a809-47126ab6e9e9@meta.com>
 <20260506161441.GK11063@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260506161441.GK11063@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jt/Bas4C c=1 sm=1 tr=0 ts=69fb6f85 cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8
 a=uIBLic6oc_-Le5kNHd0A:9 a=QEXdDO2ut3YA:10 a=Ng9YvVcppn9CIdWre3nD:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2MyBTYWx0ZWRfX0TsciYMO3pt4
 Zjd9wj3wNz4sfcNe2sJMV/4bMB+mu8U/l1uIZJsUZ2pAkfpEHrgvqNes+6B3I2hHXD1YLJHInGW
 leTjAVSlrA8gXKqPa/hridok2PD7K8nuCZMLqI0wrNF9SNHGlRghW3i8Njk45J9CnW2h/aTPpsN
 TxVFO1vjWFRAtkVnXKaRFjf/Zsg1r80rN+GLvQTydY173lCX3bmsiQF0HGVMw+ppOsYUTy5a532
 NWmErpIJUipZBqWMMQxWjO5tS7okoRTmydvb8DZ/xXI0tFiv08dw/bL7WxWSSxto5UtGLFkJjGE
 sWxoHiYL+bzU1kztmzhH2V8h4PM2nAte2GKg1K5KSDlq4852OF/V45QSLKmu31cqtB96fWajMDd
 A2DAZ+j/kRBufRahPf/SDUyjJ3B+KwOPQGOJXz+vZt4Io4xgiAfMrd9zilmumVMtn2BIpxQ0oI7
 J5QqlD4MuAWfzb5KXgw==
X-Proofpoint-GUID: eYbdqZIgnUG1USTIbXS1qC6BMIcYctFg
X-Proofpoint-ORIG-GUID: eYbdqZIgnUG1USTIbXS1qC6BMIcYctFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01

Hi Leon,

On 06/05/2026 17:14, Leon Romanovsky wrote:
> 
> On Wed, May 06, 2026 at 04:55:27PM +0100, Matt Evans wrote:
>> Hi Leon,
>>
>> On 06/05/2026 16:29, Leon Romanovsky wrote:
>>>
>>> On Wed, May 06, 2026 at 02:53:31PM +0100, Matt Evans wrote:
>>>> Hi Alex,
>>>>
>>>> On 01/05/2026 20:12, Alex Williamson wrote:
>>>>>
>>>>> On Thu, 16 Apr 2026 06:17:44 -0700
>>>>> Matt Evans <mattev@meta.com> wrote:
>>>>>
>>>>>> vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
>>>>>> revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
>>>>>> the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
>>>>>> second/underflowing kref_put() then wait_for_completion() on a
>>>>>> completion that never fires.  Fixed by predicating on revocation
>>>>>> status.
>>>>>>
>>>>>> This could happen if PCI_COMMAND_MEMORY is cleared before closing the
>>>>>> device fd (but the scenario is more likely to hit when future commits
>>>>>> add more methods to revoke DMABUFs).
>>>>>>
>>>>>> Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
>>>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>>>> ---
>>>>>>
>>>>>> (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
>>>>>> and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
>>>>>> context, so including in this series.)
>>>>>
>>>>> We really need a fix for this split out from this series, It's already
>>>>> been shown[1] that this is trivially reachable.  Carlos proposed[2] a
>>>>> similar solution to the one below.  I was concurrently working on the
>>>>> issued and suggested an alternative[3].  Let's pick a solution for
>>>>> 7.1-rc.  Thanks,
>>>>
>>>> It looks like [3] is progressing, so I'll drop this one when I can rebase
>>>> onto it.
>>>>
>>>> I noticed [3] removes the dma_resv_lock(priv->dmabuf->resv) around the
>>>> priv->vdev = NULL, and this series' vfio_pci_mmap_huge_fault() relies on
>>>> vdev only changing whilst resv is held to resolve a race between a fault and
>>>> cleanup (see patch 7 of this series).  The handler takes resv so that it can
>>>> stably test vdev in order to take memory_lock.
>>>
>>> I think that you should rely on priv->revoked and not on priv->vdev.
>>
>> Needs both unfortunately, as the fault handler ultimately needs to take
>> vdev->memory_lock.
> 
> One can argue that if priv->revoked == True, all accesses to device
> should be denied and treated as priv->vdev == Null.

I agree, the handler will early-exit when a buffer is revoked.  Though 
when it _isn't_ revoked, it still needs to go through a careful set of 
steps to keep vdev around long enough to take the lock (and ensure it 
still isn't revoked, etc.).

I think the sequence in patch 7 still works (with Alex's patch in [3]), 
since the invariants still hold:

- if not-revoked then vdev is still valid (IOW, vdev = NULL only happens 
after revoked = true)
- revoke is only changed when holding priv->dmabuf->resv

OK, [3] doesn't seem to break this series (just context/rebase).  Sorry 
for the thinking out loud, it'll be good if someone sees a flaw in my 
reasoning though.

[3] was https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/


Matt
