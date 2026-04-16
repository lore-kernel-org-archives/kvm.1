Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB622A4FC
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344736; cv=none; b=PG5nyocFlkS7Mdwf+qDRv2B2yjhnXI+aKXqhhb2s7kxcw0kEzn4K9rXChQN3Bsxwb7aNHxAa/7S9or0EBopBXY7rPbmRJPJsEPx6417xIf+zdbRirnnafAEBS4qJI9/O57GXSDhgxI6UaZx3N/LTJTbtdNjWKjW/BHnKP057svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344736; c=relaxed/simple;
	bh=SCMoLzRRm/am+EPpkcihG51tsn4nZMSuZANwEsceUmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUt2Q6jQ38LzKFvqwa0RPUXerUHLLQiNyneB4kRkF9ki/cPB3pHrN1yG5hbVpYxYRlb8O2cBWOojYIT48A6l67Hd0ggPUYjVK6fLMNrwLMhlaegc+yqACvszyGTemZWksrnw/r3uce3Vlp917Ty6ywT8GjQ7UFbaDkiUsyqqatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=a53n0f48; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="a53n0f48"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G98Bxt3364987
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 06:05:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FTTuJ0UV3YsBUN+IlV0raVkqijIy0kyzWGZIIZN1vFc=; b=a53n0f48BW1Q
	26ExwsS57p42+B27uocKfzZgL4tRNDCCprMOty6celB2WogGLAlaMy4HcIxBlG6r
	ziWtO3YCW2barioHwpaED1ZMCGChydSN45JwilJd/15Fl5eC/HkUEK0lOombNtH6
	EIHm5CDMOSTZNfB9tQCQoI5J858zSm/9hVuytYpqWHHA97mfeG8ERop9Q80rtEId
	JldktzeAI1uqjz9G7THaMlvcsC27bENRCS++p2JhUImv4A0S5slnFfFwecNKqKXo
	W04ttJezg7dpWe6+OGF5e+Qw655RuFMc0yHfiuuFTLCqrYIsTt2Ndc75w3eXqXLV
	YITjltYLaw==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84v1w1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 06:05:33 -0700 (PDT)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so51814415e9.3
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 06:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344732; x=1776949532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3Y50d3WB0A+F8Lb7pbybXM0P/H14xPD65MY8eqtg/s=;
        b=Nd/1RSFlSG2kDCTX7peR/WL2rbCEFUbag7mlc9HjsbrrQYIQ+B/KeNeTfhQlHh6oNk
         Tef7tKAVsQEcY0ep08i0FexUZisx33p4RszyqAwO4lN+5+8E8f0idORVwqyM/5AHZWA2
         FeLvhM06TQlje73Sp+m7R0scUQCltg//We2YFTLtUb1UdEJllfMOwQpGMOMs/3CaYX80
         gBYW7hhDRyxPlN+NneVurU2mN3Wo95EC3uBvxjZQpyus0TF23SxbYYzTMXp7h1mgdk+b
         dJYS8EUCrVV7ch80+x6bFVJi+RTys42J8w0kKDx71vDw4kdcwZR2G7x+47bQq7OyOrK1
         Q6rA==
X-Forwarded-Encrypted: i=1; AFNElJ8rSTORoZlSkqbymVTr1YUTCcqA56AEpwvWLW6xz32FyqUKD8mRQb4jhtFFYaHLkJJPLRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dJK9/GwVUeiqmU9ON5vZqejSGLcUpw2vTSB1oy4q0QK9y1Te
	HUBsiSctL3hwyseNUeW3VgeU9FS59B2DjH0JPAL2jcRR9+KaNxeWoJjpUpAKQ6I1sk8bmc+ybMB
	Hx040mc3zembXY6DitBsauv2g8n+/d1guMEp9NF1mnTe3vjozlGGz
X-Gm-Gg: AeBDiet3TAJe6ZF3NqsP/EHmLgaswFjPUQ1ZllWH0z+71MkwEeMIwt3MaYWxXOphzdS
	92/6qZT9iuk7pjLZKsQNznEHg+sNX9Fz+5QlwGRHMbqKwUuSvQwnCYlSmC9oZA1xd5san2AgeUX
	2poJccG9A2fSwDkXJDyp9IS1/QwOF/SN9e+BCQz4WsCCDfDKEKbpyFI+ROns2IOC4yB9if3S2eG
	bOfwqs2hMZekAvNqOeQQELqoPGX6798rcibOffrkXL+lJBRIYHiUUQNvi7EPkmuMcNFVQm2GnDm
	Gvbl3Edw13Y6vLwoT7+4pscrXqTbX/tObMMgRTlGWp+Rc+tMcgF6SD+iZIvoskl8dFc/GkmwQ+X
	xfBzd18jD0jZPbmCQ1RAeZ4PhndDhgeDJ2RGJWAOK92nE3+4i4Vggu/V58OCltTVY0r4R3pqKSQ
	Y9uWLwVEtlWuWLmDCGxGEDEogiJl95ephPTMUqNZ0ax5tifbcZGrJuWP2GDpg5qy5q1+NQhcJq1
	Lp9sp3B/VTjI1bVZk2aCMk=
X-Received: by 2002:a05:600c:8907:b0:488:c744:49b with SMTP id 5b1f17b1804b1-488d67d2cfcmr259487055e9.7.1776344732209;
        Thu, 16 Apr 2026 06:05:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8907:b0:488:c744:49b with SMTP id 5b1f17b1804b1-488d67d2cfcmr259486385e9.7.1776344731617;
        Thu, 16 Apr 2026 06:05:31 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f585cea1sm52398755e9.15.2026.04.16.06.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:05:31 -0700 (PDT)
Message-ID: <2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
Date: Thu, 16 Apr 2026 14:05:30 +0100
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
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260416081138.GE361495@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNSBTYWx0ZWRfX1gAmn+tpqsCH
 qrSEeJdQ04yPiWwUaOpZnffb6ZgDIpaqHfqCY2OO4dJhlit90nYYS1PL6wAeMJrJCv13Lbytczz
 cgKOglfYh1l2YxgeuTmAMaTWQJwAxYNQnbW392/a6XHQSC/sN6iDVCbb7yGbRcgcpoJ/wHVyXye
 WM+UUrfVqMblUwkZ/suBXI5kBAuWsFfBDSq8KHGBW35CmJvLmyQI+x4EsbmWZorZs8HZEAaEiVg
 mu31A0e8Qr/9Jnh9MEA9ZTNQ7au6sRZR5WJBvjLj6ddQnmKyysxg2ycvrhiSKLpEEcRwY7k7mEg
 4kKqjLrndoxe/zsJz6HUMw+s0bAN2itzRkF3fT5eKo6zrKAhorW3rhZEoT++D6dJ+hZT+bnbWjK
 jXqdkhyIZP8ZZN/KiyWysyiMTvDpG6QNmrfJbpsntFopXu3hz8MQ4crvWu7QO/vOhv35sqZHWFa
 RYFkN2jYNW4aEWlMq+Q==
X-Proofpoint-GUID: 3Daw78h5F-rO_Ew7ldromie5A7D6ol9U
X-Authority-Analysis: v=2.4 cv=NfLWEWD4 c=1 sm=1 tr=0 ts=69e0de9d cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8
 a=OifCM7uklORgZM6vcRMA:9 a=QEXdDO2ut3YA:10 a=nJq5_VNI1X7IEIKzvdHs:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 3Daw78h5F-rO_Ew7ldromie5A7D6ol9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01

Hi Leon,

On 16/04/2026 09:11, Leon Romanovsky wrote:
> >=20
> On Wed, Apr 15, 2026 at 11:16:23AM -0700, Matt Evans wrote:
>> Although vfio_pci_core_feature_dma_buf() validates that both requested
>> DMABUF ranges and the PCI resources being referenced are page-aligned,
>> there may be reasons other than alignment that cause a BAR to be
>> unmappable.
>>
>> Add a check for vdev->bar_mmap_supported[index], similar to the VFIO
>> mmap path.
>>
>> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO reg=
ions")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_=
pci_dmabuf.c
>> index f87fd32e4a01..4ccaf3531e02 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -249,6 +249,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>>   	if (get_dma_buf.region_index >=3D VFIO_PCI_ROM_REGION_INDEX)
>>   		return -ENODEV;
>>  =20
>> +	if (!vdev->bar_mmap_supported[get_dma_buf.region_index])
>> +		return -EINVAL;
>> +
>=20
> And it looks like AI has valid concern about this line too.
> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260415181623=
.1021090-1-mattev@meta.com__;Iw!!Bt8RZUm9aw!5DxsN8cDUviPIZqEjG0pZ_VYYbl_Rdm=
WucTGdTZ3ZzlVP_Ysb0n7ykr0eXwFXdpuqvZH2FK3$

Ah, Sashiko has a point, and I think its suggestion of checking lower=20
down in the default .get_dmabuf_phys (vfio_pci_core_get_dmabuf_phys())=20
and preserving driver overrides is decent.  Will revisit.

To your other question:
 > I noticed this check in vfio_pci_core_mmap(). Isn't that sufficient?

The scenario in mind is doing a DMABUF-export for BARs that you haven't=20
necessarily noticed can't be mmap()ed, and both paths should be checking.

Cheers,


Matt


>=20
> Thanks
>=20
>>   	dma_ranges =3D memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ran=
ges,
>>   				       sizeof(*dma_ranges));
>>   	if (IS_ERR(dma_ranges))
>> --=20
>> 2.47.3
>>

