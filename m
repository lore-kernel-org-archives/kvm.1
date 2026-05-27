Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5544D00A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902018; cv=none; b=PRfcPiOhjsYBGqtwg7T65FntFj2Pi3ba9p5XQSJhgthEOZzSl1i69FRokquuNMlhd5qvK877s7wXYGC2d6KINnuH+dSQNfrRpfaCEWcu/ChOnGhhsL8baH8jhVxGvrDTK5pBkC9jaaa3xWFBvEPODD6zAOt+FzfUqW8wnC+oWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902018; c=relaxed/simple;
	bh=sUh2qgnb1rvjNwwYWycAZ+HszzMtG96sy5yb7iUgUrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rsce91MJAcO/h5oN4tZyr9nsYm8KS7/B3vrB+52G0hU1pMz8Pthp6b0v2ZXQYcdmrWLaW4nO0zcYQOg+N2FQFigjsDL2JYHxLGw6LLyd2R4zGO1zZXIR4FoxuT6gvwdLeuMCa9EeTHW/sNmtBdKkFiX5eQapRCsnvsC3Fnt1bbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kbPRowui; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kbPRowui"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R6QYfq2300349
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mF5ddP6Uato8c/uzw9iXykGIYPHqrtpIex8OCXzcenM=; b=kbPRowui4ML0
	YT114Vj1aVyNdnJJnjW848sZsqDgsQYxXf2af4lfe3yF9FH23tSklBFjrFv+o1wO
	ucJMCKwm9TylaOZQY0BhdJmQkngp6DAyA55R8lVRUQsexRgIwmUgj+H/mCR04y4k
	/GAEdHJqvYT6gQSouuHInLdwLedo/MVWAuYOky/jMujuavyWL/YFHal9G71FuvZm
	tUxMcxI1AwosqBr40clgGXAGZXRDcjjOD1Jq/WacVJpLsQehhEaY4Ed2cuHf56jB
	IOS9EOaVolYK/24AqeQ1zfm7jhCYBImKoLNKwH7NA+wFXFoDOJcUcF7lf4ehsFGn
	OeD1ICtoLg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4edubfu96w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:13:32 -0700 (PDT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1353bfdbf99so12673564c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779902011; x=1780506811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mF5ddP6Uato8c/uzw9iXykGIYPHqrtpIex8OCXzcenM=;
        b=YKLgJTBVe0miyVM+m07FaKc1iGs7rLm0tdni0yXtTfJIZQWxObFkLiUkCofAcJneX0
         hlRIXv0NSiZcv+E4u7BXFQRNai5HXJRblPqUpB94wY3lbx4CmsaeugD0n3m+LByTjNcF
         nBALIFaMHatStFGSe7pEg6PR4fLIDB+UZj/hRA1xGYR5lwWnxayk5KYYfK654YfPybZe
         OnImBys5Wzf2r5TRgmT9cERfzld0QBQJCR3Db1HjiWhfD1PgOu0ngHV3NszivE7NVJCU
         d7cVJzFfJbzkhxVs9yxYsEk+51hXC2630I94sbc5r58dcfc92wA+oRD6o5mCec9/nSkT
         blrA==
X-Forwarded-Encrypted: i=1; AFNElJ+gvIsrofaqUwY1uN0vQoiFiqk/Kg1Ye27bgCrpWKQPDaqT+X5/Bd3xlCSIrOPF/EKevjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvRUZygZKXe/KXi+ZnAmbRi/U+2f5GyOThph8KGGilK3a2y2t
	ixueVKbQ+wohh+vLiCUHo8P9bAuB/ynBm7r+Jfibd1SbXsvErN7Ut1677koPN1BzlJ2vwVLN/3L
	CSn+QfMEGN2MFXQE1IOEggF2HOHPwTQ8ap44M3kVmKVk5OtqZ5+9u
X-Gm-Gg: Acq92OF7kmao48gUl6bvWaO1QCXVnUUfevWRCkynJjuZQCha+W5Sc8+1yTByZZoCwp9
	6065ghGbdooqkriDNjT4B769G8+3wySotbFDz2IgvToobvWGmQ6cJ7W/fHaGPZAKGVeYPBa473d
	UuYklMB3bxVA37tnNnara5DOwOED8ZAwaZ5f6pk1wfdZqTN26Zq0LQzg7wOdkWv60VCE0WqolRp
	O6o5g4Toyok+X3DD+l7XDNEr8KIZioeivcQi3tp+Hj9e34dcHBKWOvtfyW/K5C8z4ZBSeRaCbHx
	/irR5Vhr+c3MGyz4rsnKI3GPsomy2IQGg+WiIfQNKP0Ih/cPGWkidM9k8TDFfb2Y4Gl2o+g5TX4
	wuHS6ZHhCBy1/iZ8C6MoSiQEHLQFzqusv8zU=
X-Received: by 2002:a05:7022:913:b0:135:e814:d03f with SMTP id a92af1059eb24-1365fc7d7e9mr8777517c88.36.1779902011328;
        Wed, 27 May 2026 10:13:31 -0700 (PDT)
X-Received: by 2002:a05:7022:913:b0:135:e814:d03f with SMTP id a92af1059eb24-1365fc7d7e9mr8777489c88.36.1779902010729;
        Wed, 27 May 2026 10:13:30 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-136b3706ad6sm9223289c88.13.2026.05.27.10.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 10:13:30 -0700 (PDT)
Message-ID: <1f1b9967-7182-401c-ac30-373b73216e81@meta.com>
Date: Wed, 27 May 2026 18:13:25 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson
 <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
 <843e8525-5927-45b5-a3e2-a5ec16234398@deltatee.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <843e8525-5927-45b5-a3e2-a5ec16234398@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 10K1mTZ-bAHuKc8tfzNAvGLt0QQE-05n
X-Proofpoint-ORIG-GUID: 10K1mTZ-bAHuKc8tfzNAvGLt0QQE-05n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3MiBTYWx0ZWRfXyMJKWtYkAvxS
 YQ4KDaXbb6y9Wy2I4aaPXwF5oaSuqSNDOeIRIxOLtXKCzzTdHMgqDpB2YkemI9Z3sW9tN1nQy+E
 xmtjN5R6JiwjMAlGe2zinQGvsR8CmI513k01V74zAbkdOrStnZpWTLHR9BtTwzY56c8RWag2wTy
 JEHXM+t9tt+hTpDIk/TadFtzCnGM2pGr30RU7kj16Cr0/12h/QV3EWkIG8sPiWxs0CMk6pBbXaZ
 bF3dLf1u0bsH5OJO1onRosNYpJvXsjxoegQ6aCJox/SPvqYLnDE6Yfax7UPy3i1fy/EG7EEiQyd
 Zcw89s9sux3ltQc+dgY8N1IDJBNkEdAvaaGXn4Tvum/04ZtUxYPkEE0yaTybz0afnuPsCNNR5p2
 lr59qhXs8s3VYMEWCBCH8kTExzbFgLSizzMxxuNckr+SaMLL6ImI+lNFcclmo+hgNFYXqeONsRT
 rtGuu/HuxOPVCmKVtFw==
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a17263c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8
 a=gXLdhW2jAAAA:8 a=1nsJja_hzN5yKYYIz30A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=gKebqoRLp9LExxC7YDUY:22 a=Dn9eIPSr_RzuO0KTJioD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01

Hi Logan,

On 27/05/2026 17:07, Logan Gunthorpe wrote:
> 
> On 2026-05-27 04:23, Matt Evans wrote:
>> The P2PDMA code currently provides two features under the same
>> CONFIG_PCI_P2PDMA option:
>>
>>   1.  Locate providers via pcim_p2pdma_provider()
>>   2.  Manage actual P2P DMA
>>
>> Other code (such as vfio-pci) depends on 1, without having a hard
>> dependency on 2.
>>
>> A future commit expands the use of DMABUF in vfio-pci for non-P2P
>> scenarios, relying on pcim_p2pdma_provider() always being present.  If
>> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
>> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
>> when P2P is not needed.
>>
>> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE which contains the
>> basic provider functionality to make it available even if the
>> CONFIG_PCI_P2PDMA feature is disabled or unavailable due to
>> !CONFIG_ZONE_DEVICE.  Users such as vfio-pci can enable their own P2P
>> features based off the original CONFIG_PCI_P2PDMA (available when
>> CONFIG_ZONE_DEVICE is set).
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
> 
> Largely this looks good to me. I have one minor nit below that you can
> apply or not. Either way, feel free to add:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> 
>>   static void pci_p2pdma_release(void *data)
>>   {
>>   	struct pci_dev *pdev = data;
>> @@ -241,11 +251,13 @@ static void pci_p2pdma_release(void *data)
>>   		synchronize_rcu();
>>   	xa_destroy(&p2pdma->map_types);
>>   
>> +#ifdef CONFIG_PCI_P2PDMA
>>   	if (!p2pdma->pool)
>>   		return;
>>   
>>   	gen_pool_destroy(p2pdma->pool);
>>   	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
>> +#endif
>>   }
> 
> I'm personally not a fan of adding #ifdefs inside functions like this.
> This instance is small and easy to understand, but it can quickly become
> a bit of a mess if we start adding more features. I probably would have
> created a pci_p2pdma_release_pool() helper which does the inverse of
> pci_p2pdma_setup_pool(), it would be called in pci_p2pdma_release() and
> an empty implementation would be provided in the case where
> CONFIG_PCI_P2PDMA is not set.

That's cleaner, I'll do that.  Thanks for the review.


Matt

