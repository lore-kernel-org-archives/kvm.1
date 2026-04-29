Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D683750B9
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457876; cv=none; b=NskAI/kI1TqjfX1xUQ3b7QYiNQjHmoU9pJMuBVeMdxAgOIH8Gw/1oz9ze2/ZIhlLTkWhiitmEj5qUU2+4LooqjZ37N89VrzaP/HfK5yI2KbcIW1nwLovZ2br/0Vx7yP3hX2P1e3l14c0l10Pnp4aUb4Xxdsajy8RlIK/DR8WojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457876; c=relaxed/simple;
	bh=Hvppf1MWyfS3as7jeN/6m10Lw5zLo3BkYizAxj3louc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlDcOpYplw3Gv5zO9PkIJwJVCW4FY6U0ctbVkdjOMkjhOuY8jyFDZChcVqNn8rQaE23GGZcQ/KX7jW+2M24LE7aqZxLSqDH91pZl1Z/OJ5XDC11DCv988xFWGxWfT7/2EZHqALTynZqgdJXBZkHl3rbBcpoRY4Q8lKX3ppRvOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VhYl5xqX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VhYl5xqX"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SIjUqw1474920
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:17:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7yJqq3a04kcSDFbt2GTsDnPI5s5xDilbsLSAdvfilyw=; b=VhYl5xqXuBK4
	elmpHl+yTYS2osrmlQFZy0ISq5MRcXpkz5wMjmPejblNLYk7nUaoHgYbfUa9gLjc
	kuvjfatsN60mkJZfx6EirnJcNcYYTpPz8nmSLnRhGJPMXKQ85tYOqGF8qd4gFrFA
	hTTwILf1Z/HDbw5Ahl+ry6ERfnskTDLQbLoWkaR5IAjl9rG8js+o5gOCD8Reo1Xt
	ps20tdFxtKCIqE9axe1gvdu+UuQKrJCE4fepXLNidhg6conlzjs6BtuFlfuW8QYS
	QAggP2BEO8f7Q+YGoR4MokTb3AHa1aiiVezyYQkPKGZV11J9IbYxQtuS82EBRQes
	N40r2nmyfw==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drrx5sb5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:17:49 -0700 (PDT)
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a1f9601so8517011f8f.0
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777457868; x=1778062668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhqacqCsOEkZm6rZuptvAn6IpvZgDy/PZABzqjx+5ns=;
        b=q8m9wW162CRi5BgqiaqE7hcQHi0Pksm3KH4ppBZH9nPy9bKlKaLtQLPgoFzl3vm5pS
         y8wnnDToqiHNOPu6pF8ZVPGmOqpA8Fr80rMWtmGY3sjeRKWvTgGLPhss8IAl/gPKUtc8
         x9EdfRNC+chdl5vQ7xhtTCtjIYNc49HY3emSxOAejsTnPE2FNSXjCEtnacF+ZcY0e7jI
         klBW/P8jMWZyBjy2hbZbOpN4XlbshhZ1LlKkBb4oZjisXl6lJNJObV1RTgRpQ0rdVhG6
         mpIfeiv+TCISZliXyQLdE6lUJ10cAQUlgBhY6C578CH41/mnphnIo23IzvMt5t2OseKQ
         sWWA==
X-Forwarded-Encrypted: i=1; AFNElJ9yr2eGl98ptOxhYzq4BoCGKV/Eosy19FyQiqlDbU24blk0ZkpzAGjA/i93LAu0rJHH84k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Xfq085ZDXHLzvSF/3V4Y3UCpavtrAQVtXwtEgMQE00ptEXyz
	tErWs8wDsPh0RxG5zy6miGv+TJbMa8LW03MYMDAUCLizSyES3fQOQyBLuUqQ5CTPSufJLYPWdyC
	bUYNTVbSRn1VzzJwbStSAIkD41jGDFpjNXTl1+7XLzYV0GPVw0oK8
X-Gm-Gg: AeBDiesXqZkdc8h1LWQe/QmVBHCPJMjKl7m/jMMECOOPGCUqvAf83p3CM/Aw5OIn8fE
	0xFdT0JGdHRISmPXpYugGKNvZxBdqGmDNHB3r7vBAILVffcqPNm+gfIbKm97o5IiamoL1qfQbYm
	8+iACTXN/GNySpuw/Wg/5c5XGbsTsq+iu556JDyFOt5pdhLqAH8NSOnhuo7HoXw9KVCMaCVYPlv
	410+r3WPmgpPMUrusl4GlM2b+LWGDpa1u3UNZVPeMghZKiv4XR+ivFrqCZheueUtb5BZecInigZ
	U2a3SOxaCtqqdA99xz4Bxht1Rjqyx8gxLAzVyH7vOfmoWLgRPOgti02tOENvl+amZj08MaZ9q1I
	voWmLKoFhPxYv4I+iP21Hfyf8vfKqcqlozCqLkwdxUTOLDmRzj0R3j2wgnCG0mn1F4dxx3FJ7+A
	==
X-Received: by 2002:a05:6000:2083:b0:439:c661:3245 with SMTP id ffacd0b85a97d-4464b2acac8mr12680061f8f.34.1777457868156;
        Wed, 29 Apr 2026 03:17:48 -0700 (PDT)
X-Received: by 2002:a05:6000:2083:b0:439:c661:3245 with SMTP id ffacd0b85a97d-4464b2acac8mr12679996f8f.34.1777457867712;
        Wed, 29 Apr 2026 03:17:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:18:b9f9:127f:ecc1? ([2620:10d:c092:500::4:fbdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca64ffsm5099429f8f.37.2026.04.29.03.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:17:46 -0700 (PDT)
Message-ID: <393f65a8-75c3-401c-b983-5814e1bfcba2@meta.com>
Date: Wed, 29 Apr 2026 11:17:43 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with checks for resource/map
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260423182517.2286030-1-mattev@meta.com>
 <20260423182517.2286030-3-mattev@meta.com> <20260426110517.GB440345@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260426110517.GB440345@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwNCBTYWx0ZWRfX3BG86JObWh6V
 5ClEJ3aOdx7vXHne+cMkZMh9gFov2PW6TigJL0glvXCW4B/rn1emgHoMzWa0sKVoMciNQewc2/h
 0mMy+wD3bVbgcaL6WKFX98k89AYOlCs/nxkDwRuTuNTEg+24VlIH6+o6J5F8MW7dLQkG0gPLN1/
 Ru1MIsdE19K7ftOcsriH8v2tzChoHJLhliaA6bFFX+nJ8sjyQQWbh++rPKBJWXd2kgmZfIYJnrM
 b2IcZg0ZsPdRSTFlq25btuw4hoYZ3W4KJPjOWmntR2h62jwUZDs7/LJCpxOgyyOesma3gqvgZsN
 gsyGGScdy+tpnL2p5Qu4DTbnqEwwqjEbw1tUKDgk9SYur7kBHKRT3njXU2ezKXvUjAkxVvAfHqb
 QQIRj40J6rWrbV0DS45aNErrv8T/Op877XqvIlcNHcQz2yfocXe7RS5MFQZG2WJYA+WIIKK0NWs
 jWbkWCb1Ri7P5Yj1mhg==
X-Proofpoint-GUID: 2XOeF7OA5PM2b_ZPp_8FNKHbTInTgZSX
X-Proofpoint-ORIG-GUID: 2XOeF7OA5PM2b_ZPp_8FNKHbTInTgZSX
X-Authority-Analysis: v=2.4 cv=ZZUt8MVA c=1 sm=1 tr=0 ts=69f1dacd cx=c_pps
 a=I6ewnrIBtnKHmb6SxpX7Vg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=iaFi8TtKhGdbX_SpOFsA:9
 a=QEXdDO2ut3YA:10 a=MqNruPmfsT8GavliLQMe:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01

Hi Leon,

On 26/04/2026 12:05, Leon Romanovsky wrote:
> >=20
> On Thu, Apr 23, 2026 at 11:25:08AM -0700, Matt Evans wrote:
>> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
>> resource request and iomap for the BARs was performed early, and
>> vfio_pci_core_setup_barmap() now just checks those actions succeeded.
>>
>> There were two types of callers:
>>   - Those that need the iomap, because they'll access the BAR
>>   - Those that need the resource, because they'll map/export it
>>
>> This replaces vfio_pci_core_setup_barmap() with two helpers,
>> vfio_pci_core_check_barmap_valid() and vfio_pci_core_check_bar_rsrc(),
>> to make it clear which behaviour is required in each caller.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/nvgrace-gpu/main.c |  8 +++-----
>>   drivers/vfio/pci/vfio_pci_core.c    |  5 ++---
>>   drivers/vfio/pci/vfio_pci_rdwr.c    | 22 ++--------------------
>>   drivers/vfio/pci/virtio/legacy_io.c |  4 ++--
>>   include/linux/vfio_pci_core.h       | 23 ++++++++++++++++++++++-
>>   5 files changed, 31 insertions(+), 31 deletions(-)
>=20
> <...>
>=20
>> +/* Returns 0 if vdev->barmap[bar] can be accessed, otherwise errno */
>> +static inline int
>> +vfio_pci_core_check_barmap_valid(struct vfio_pci_core_device *vdev, int=
 bar)
>> +{
>> +	if (bar < 0 || bar >=3D PCI_STD_NUM_BARS)
>> +		return -EINVAL;
>> +	if (vdev->barmap[bar] =3D=3D 0)
>=20
> I understand this line was copied from an earlier implementation, but
> barmap[bar] is a pointer, and it is set to NULL when it is released.
>=20
>   if (!dev->barmap[bar])
>     return -ENOMEM;

Absolutely.  Fixed in upcoming v3, thank you,


Matt

>=20
> Thanks
>=20
>> +		return -ENOMEM;
>> +	return 0;
>> +}
>> +
>> +/* Returns 0 if BAR has a valid resource reserved for use, otherwise er=
rno */
>> +static inline int vfio_pci_core_check_bar_rsrc(struct vfio_pci_core_dev=
ice *vdev,
>> +					       int bar)
>> +{
>> +	if (bar < 0 || bar >=3D PCI_STD_NUM_BARS)
>> +		return -EINVAL;
>> +	if (!vdev->have_bar_resource[bar])
>> +		return -EBUSY;
>> +	return 0;
>> +}
>> +
>>   static inline bool is_aligned_for_order(struct vm_area_struct *vma,
>>   					unsigned long addr,
>>   					unsigned long pfn,
>> --=20
>> 2.47.3
>>

