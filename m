Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8D310784
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953929; cv=none; b=vAFWAGYDzoqRLg8Ksm8fg1+kjxm+F9LHHlaqbfm81cLBI7j0NfgrM3FP8loI69EmyiwAHcySbV82FknHzxjcKpK5/Rw+XIu7ndpsdRf6EbWDH/oYMKsiivv4z5q5w4C9SMbY3ansFZeiYJ/qIYMVuJ2/tabM9PXpbIdBWO19R0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953929; c=relaxed/simple;
	bh=LSJOTkRvgDMochGAG2u+xvbWFmTWnSE6qQ3xJqtS+t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWbjQMIPgbynnEuSm9XKix5//+i5pMzTqpXTX1Ijc8CDLxTD+HQDouLB/+Ka+Xee5LLNOtRrgDh58fK9/7pgq+SkB1txEGs8gbw0woe26bQB2JJzG7lEO1umrOmVdxD7bBmsEqiEEtM6xjlcT9+1LeZMvUrY7Cc5FIGjXDvmQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v+MJo+HS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="v+MJo+HS"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MJib474169397
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=e95FCMfWZPIOflPX9x4B7yDZMlPKVoCcJEUwN6OatrI=; b=v+MJo+HS/N5D
	fQTCqX9AVRisJuiPh225WBruwA/jUDdds5TjN78vSY40xglltHw7sbQxw5AvTPSf
	nPNNM3WRIeid0dKheMQdeG8V/Zsqw5XBZbUjxDocbW6JXMdsO0ExGuQXsyiu5ZOS
	waD0d7hALvvqpIT/jXEzxvGKRcxR/ZF0HenovdWMeIjCo3droUW9GqF4RFw5i0+T
	W3QLbIBISHFR9/4kZMCfze6WsQB4VbHOKS9fq7FV0uPvSa0NrkT8vjGtC59ZtvUa
	H+Ti/O/LRiHpB22D0rTaVbUaftTG0yfsQSLTtvhLG53LWfHSgk45XjxI9zS4kC5L
	+JBDLK+TLw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepacuwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:18:46 -0700 (PDT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12c87ba0890so18442837c88.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953926; x=1777558726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e95FCMfWZPIOflPX9x4B7yDZMlPKVoCcJEUwN6OatrI=;
        b=sdMpVohWoIJOFWNCpEs3fH4OwQiChGZ10ungWvllApUTXPBeqyO2MwXMQKMhmnZ2+/
         U25q1eo2x/n/kmbs2ek780UTzJc01RSMStj48OdU86A2Twl/lzWqWPPgWzxx5YJsQhKp
         jF8pmugdiBamAToBUNxHaNSRf5KsSMveuGKrngWnHCMZZJI/B8g0gU/0Vt/y+F3/Kx7w
         Cc1vzEZ8abAFNDW587f7yq5mGX0v0ZuEakLLgob4T5H14FLYxFnPBJ4n0uE0hHCDKipv
         SOvaZZAjHzQCvMBU76TSQOclxhpSVigBGXNFYJ4Ufx5R8M/QHJ7vC6n9p2/fh9l7ZR6z
         J+dQ==
X-Forwarded-Encrypted: i=1; AFNElJ+D4HYWuy0BFkxtH4wXgKt2fhAtnBlE8+wNs+iIKb5PkLWW0QPg1i26vNTfDm4tuMn37BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRHBEZXzssFYkrXtMOmZG//RQJeoRLDsKnsLU1mwlHNPjfntd
	lQYpGJw7272waRrR2jvPB4/dQ1Dd+ti7wJIiBNTLVn9djovlUHtfs7BFj5McAjhWhiMPBfV3m30
	YQJhHx+zQEg09OvantKy/kG5AyvW6w6URyhTd8jfx2DTBdMF/qUE9
X-Gm-Gg: AeBDietThnT7pi8pNJq5MwNNQFrULz0YUhkK0wBs3vqh7OlWIpxQTrUmO2YHOnnDpOu
	EgXooClLqjIceds9lUm4/CZCBa5/FkuKEm+oxu/K7mhARC6+rUol0LA7bKJgNMdMIh/rI5sMCLF
	sssYPvzUnlXpEEG4FUS9o4MTaWaJ+BDziS1cZPI5JfsK5aVF3CL58RtCz885/q9iQiwB0w2mJ1N
	As4wabixx403lsID+Lo/yzh8XDQp82g9/GUT14SE4+vUtb06U6Aesx5wP56paQpZO71NtSChuCw
	XaTqNNdClbHZghFd9oVLhunex3+sgEJUAeOqJwHK1K/qCnUDM+GNQrkzi/5Xdsufo3qsLwjrkQt
	8pj0q7zTZU+B+js0gTwaVRZpTWnayL1S7MSvBWOIf
X-Received: by 2002:a05:7022:e22:b0:128:cedb:33c6 with SMTP id a92af1059eb24-12c73f9759emr16988864c88.16.1776953925414;
        Thu, 23 Apr 2026 07:18:45 -0700 (PDT)
X-Received: by 2002:a05:7022:e22:b0:128:cedb:33c6 with SMTP id a92af1059eb24-12c73f9759emr16988839c88.16.1776953924605;
        Thu, 23 Apr 2026 07:18:44 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm41524610c88.10.2026.04.23.07.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:18:44 -0700 (PDT)
Message-ID: <1500fb01-3046-4d82-8cb4-3469dc2c848c@meta.com>
Date: Thu, 23 Apr 2026 15:18:39 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/pci: Set up barmap in vfio_pci_core_enable()
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260421174143.3883579-1-mattev@meta.com>
 <20260421174143.3883579-2-mattev@meta.com>
 <20260421133123.36fc0353@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260421133123.36fc0353@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UtREwhRxEAeWmgaSC-aTTtFGB8CUoa20
X-Authority-Analysis: v=2.4 cv=KMxqylFo c=1 sm=1 tr=0 ts=69ea2a46 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8
 a=iNyBAbhlopIjzdoupJ0A:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfXwkBF/TAO5ZoC
 XJixvARKzpJbiMW5K1NtKpNCuoBCuBdt/Ch2L9VSAXR9Z5zh9Zfq/2/0m4PvjJorxtmMiZrBIcC
 QJyh0lpBSZfTRHFrXc/bC/EMT2PwZHK+hZVhIFZga+SeOoBxvNLGWpbxf5xy5+4lU/TaGme3O8e
 xJ35FU6M1ajWKvMDscpxikbaHXwoUeayfJ2xsuiHECielYiDvDceNWYS8SL6DQrzA7fDbbcXyDB
 8j/cZm0aWT81gxo4G7TpOImBC4uCRjx1/zpo2uEC4hq5dB3YrB616XC2zR1JPTPBdNECuQHpoZe
 txJPFErt4FJSFTlZ2aj4f7QGuxUkal2tk9P6qE9YVTSK29TjgZ1Riv5ZcocLf/DXIDjhpajRDUf
 pUq439xjczQtSfnvhmNWXzNGwGpbfVVXN58SZ6HpYwSVJXV5UQEg3+D2/vQndAG5EqfsJFWRbVg
 ti958fmIrBw/dZP/vXg==
X-Proofpoint-GUID: UtREwhRxEAeWmgaSC-aTTtFGB8CUoa20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Hi Alex,

On 21/04/2026 20:31, Alex Williamson wrote:
> 
> On Tue, 21 Apr 2026 10:41:40 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> The previous lazy-setup of the barmaps provided opportunities to
>> forget to do it (for example, DMABUF export).  Since all users will
>> ultimately require BAR resources to have been requested, request them
>> in vfio_pci_core_enable.
>>
>> Existing calls to vfio_pci_core_setup_barmap() are now benign, but
>> remain because some callers use it to validate a BAR index.  This
>> fixes at least the case where DMABUF export could succeed before
>> resources were requested.
>>
>> This keeps resource request and ioremap() done at the same time, but
>> in future the ioremap() could be done on-demand (not all VFIO users
>> need it).
>>
>> Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
>> Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 63 +++++++++++++++++++++++++++-----
>>   drivers/vfio/pci/vfio_pci_rdwr.c | 25 +++----------
>>   2 files changed, 60 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f8d093aacf8..4a314213f3ae 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -482,6 +482,55 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>>   }
>>   #endif /* CONFIG_PM */
>>   
>> +static void __vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int i;
>> +
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int bar = i + PCI_STD_RESOURCES;
>> +
>> +		if (!vdev->barmap[i])
>> +			continue;
>> +		pci_iounmap(pdev, vdev->barmap[bar]);
>> +		pci_release_selected_regions(pdev, 1 << bar);
>> +		vdev->barmap[bar] = NULL;
>> +	}
>> +}
>> +
>> +static int __vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	/* Eager-request BAR resources (and iomap) */
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int bar = i + PCI_STD_RESOURCES;
>> +		void __iomem *io;
>> +
>> +		if (pci_resource_len(pdev, i) == 0)
>> +			continue;
>> +
>> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>> +		if (ret)
>> +			goto err_free_barmap;
>> +
>> +		io = pci_iomap(pdev, bar, 0);
>> +		if (!io) {
>> +			pci_release_selected_regions(pdev, 1 << bar);
>> +			ret = -ENOMEM;
>> +			goto err_free_barmap;
>> +		}
>> +		vdev->barmap[bar] = io;
>> +	}
>> +	return 0;
>> +
>> +err_free_barmap:
>> +	__vfio_pci_core_unmap_bars(vdev);
>> +	return ret;
>> +}
>> +
>>   /*
>>    * The pci-driver core runtime PM routines always save the device state
>>    * before going into suspended state. If the device is going into low power
>> @@ -568,6 +617,9 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>   	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>>   		vdev->has_vga = true;
>>   
>> +	ret = __vfio_pci_core_map_bars(vdev);
>> +	if (ret)
>> +		goto out_free_zdev;
> 
> Beyond simply changing to a preemptive mapping scheme, this hard
> failure makes me concerned about regressing userspace.  With the
> current lazy scheme, we only claim the BAR if the user accesses it and
> the failure only occurs in the access path.  That means we could have
> BARs that are never mapped.  With a hard failure here, with might be
> uncovering some latent issues, and if those latent issues are with BARs
> that we never cared to map previously, we're causing trouble for no
> gain.

Thanks.  Hm, so for example a valid non-zero-sized BAR but the 
pci_iomap() hitting ENOMEM.  Good point, that could be annoying if the 
BAR was otherwise unused.

> I'd suggest setup should be a void function that generates pci_warn()
> on conflict or iomap error, but doesn't block the device.  Each usage
> path (including mmap that gets removed in the next path) still needs to
> validate the mapping is present for the given BAR and fail the call
> path otherwise.

I'd hoped to be able to assume resources have been successfully 
requested, since we've at least one example of forgetting to do it 
explicitly (DMABUF export), but no worries.  I'll re-add explicit checks 
to usage paths (incl. for DMABUF export) to make failures consistent 
with current behaviour.

> There's also a subtle range check added in the virtio driver in the
> next patch, is that fixing a bug or paranoia?  Do we need a helper that
> does a range test and barmap test?  Thanks,

That'll be nicer, I agree.  Given the point above, two tiny helpers make 
sense for the two "uses":

- Was resource X requested successfully?   (For DMABUF, mmap, etc.)
- Get X's iomapped base address.  (For rdwr, virtio, nvgpu-grace.)

(The motivation for the range check was just robustness, not a specific 
bug.  It's cheap to sanity-check and Pretty Bad if the index is ever out 
of range.)

Reposting... Thanks,


Matt

