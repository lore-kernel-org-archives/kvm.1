Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402247;
	b=z9crNhsOObjJZbWJ6mvc5WjsiN4QokBzp1ARIPEOCdhrN15I0fH16A4gLTmDgSkMjVJc
	 HXahNS5GnhPtzfSxSGREvO14KhZ5LN35IBw5rTggJ4fvQU67x00HNIYlsvy/hMB8xB/A2
	 1z6SrLQZmR4nnJI2Vzr9bUAvXFxtgZwkRAhpbNuY4SWJsfGaFIeO4HGAfK8APT80T7ItC
	 RXsLl61SNdzWs7kROzf9EVG2Hw8vy9y8zZ1zEJkuSflskZGRoxsLXSYooO/CtFbYGIyU0
	 6ukK6FAm7+Tl9tDhOIjlGK5TvZkejLf1YehuY/Qf5pLL0Rxg1U4jsYaFercf2nL1zTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
	b=QcnTWHZQIzvaeexCffcd1oDD4vrcckIbnyd8kCON3CkinICGaacxOT5p7lGKUNXeuojE
	 ouxRkX2S5sqmQLor5Nu66I/MIc9TblzyOdcN1cPOcywG+wQXBcqbvB3tMxhigowWZO5S+
	 ndtNvleSV1/LWWPUabCw5pplaMXCDwvbLNPMPMJRSnJfrDVwmFyv2XYsMwj7nM49Gzwah
	 Ppj+346yVinCM/09ZyaqsJPGpIWRDjjIEWpqMUPmIcj34AhwSd0j5Aql3hWwUJMf8U20v
	 AdoLiyTGLuolGKzmClwqQ5PoDUOB3Fi8WzwBJt+BAcftH3Rlpz0giOyqdO26kJ3TZiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXQgzpip;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jnmU6mlw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3E606A32E
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B3E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXQgzpip;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jnmU6mlw
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYqUB2286471
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hXFO6nUxnCW4XbKSEmI+WWHT
	tNiBaotTU8OUh9DkrJ4=; b=ZXQgzpip5uTvPSftHjwaOcUkWjomKAoZGLBjeYPm
	o1VQ1fRKMILYH+E2uFvWC/UqY3Yc/4Q4Cqy7cnrDFiv4EcuAgnTv3xA+bwMUFWPo
	TOKcHIcBcPBQwTeI6WiNqonqVAiFrS98rjxib8gIQlgalfftVkLQgbSl5+8L9hzN
	2ojK22wdT3LQwRit1G1MrsSzRYQ9WRi5bskOADsWRZ+IDlHaN2bK9DM4sO2KqbBD
	n6fexJdluRTZPVh/Q0Ax3hc2fl3bhyCm3VDwbPe0oGwC43BtkpXpu+dDgqGY0ShZ
	vKLCnaMizQ98DjuFwWT3CLzuTlwV6efLjINJtlAuzKZipw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm98uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:04:05 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9806756ea40so2396970241.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 05:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402245; x=1795007045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
        b=jnmU6mlwjM6RjVwrQWFce3gHPDwoukmEvapXfyxL2PBBEWblmBVdB4NUzH1plEjUAI
         bN3VA2XV6UQGbfuYnmb70jm0QQPS8vxfu8VNiEsdK65rncjPfQg4KEmyXG1BYBCDaTdQ
         dShWmpD/uQ2wwNZn87slSujvUOOIagWLmp1Ty9063u2nCqheOEB8M1BcU2JbAT4JLP+A
         33RIXl6o8qFprArVF/8wl1SNkeHKVeGk3RPyDqxhZ8K1WK3jM8wRf1bR35V25/7tMQW3
         kv2ZFCu6W3JOL3MLKqw5foQXbIe5V0i7iHXcaTLZH9CIq7e1b6gngn6jVuMsha6FoFiV
         6ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402245; x=1795007045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
        b=Pt3uMineiLpAAVsU/dfhuqZ/ck9f0BcUdIEr6xIgZsvukmAZdZ52Vc30tQ/jpfLoic
         4JBGVhqEbOrU/i+MtTGrB7ocWcFigRGSPWU/2/M9zTj19DHVIZgczKDCqHuVmmCd9uDM
         RK7N20R4QlL/FfTXuvb8JXRlby3jwLSbHsOFTfMb/A4emrQx0DpV8SzwPZWrGjjXosP1
         sw2wwJMCJP8uoMmSPu/gPUn0QY6UMIzQpVlfXK2c+4wrLhV2EUkST5Y8GW7ETZHvln6C
         juYwUlze8lNQtNN+LvmYgu4LOD0h1GBuB4Z1T4f5BxxcqfQ/+uo4ZItljS+I3Jg29bcS
         atRg==
X-Forwarded-Encrypted: i=1; AL+hErGBQOQHSJYjpC8IsMAosrS5+BXhKvFf0oZWgz6V74zhdmOcnh2a9U5WxI5AJZAW1tCBlss=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CUmGBigAskfA/70KbPDCs5gl4TUJdXzcsvrJutvXDIzwKkiEM
	m/h7yqqRBkNNyfv3b5vDi3u0AlbFgISVi2XhKgItUNGUUZ1LKfj7QIFX84Yez8Cl8qJS26jBg/E
	FUiC7Ut9WDPm1hU5L6GsKsmZS5MkSMBnclVxLjCKJHhq28kxuuke/1ok=
X-Gm-Gg: AYBFou2RunDojMZbzRqOPWpx9vISQLjEg2H8bqvxDZLQlW0ZUGDzZKqWxeG+CJrLoYN
	KPZ6C7EaPGPyaOIr8/6h6JK8D2A67q1PVavxJTjcV0fE2wdYAz6DhiDaANXRgDzepdrC2k2/yA3
	tEG5BT4KOalrW5O3FnP8QS7rzLzVhQgWQQpTS8c/CR+EwaV5mhBz8VP0hHrkjdv6kEIancM3aHf
	UyrcpCC+RAVOEZcmul8ygH66ygVOXae8Ix54E+wcaeuLnmDIEdOX+3lW/ThrydjcX9WFnrqNmg0
	t15Fo6ZBHSnEtQbwAfhgP9gnBqaV7ktoF8Jk9Dldw9EXwsUqlPI4Gccr4YGWnoDLVspUdSZxPA0
	ucfukVmOhtEggmqJ73HJKvaNGRIUGPDQNpw8V1DG5KQjTUFKWWHismK+UcDzMDHH+5ZLnXGJLqY
	87kO7f1WMgjVp/o3h9zgiIWIBcQmrze92heloRasrMAZwHhzy9VXT8KOJKu/rzMw==
X-Received: by 2002:a05:6122:1d8b:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ee1c490338mr604725e0c.21.1794402244044;
        Wed, 11 Nov 2026 05:04:04 -0800 (PST)
X-Received: by 2002:a05:6122:1d8b:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ee1c490338mr604634e0c.21.1794402243470;
        Wed, 11 Nov 2026 05:04:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bb758esm944566e87.67.2026.11.11.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:04:01 -0800 (PST)
Date: Wed, 11 Nov 2026 15:03:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
Message-ID: <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-GUID: DmkQ0X7FPc52m5HccE2bj9hh8aPHi1AH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX7uqL1wvbcecK
 UIJSLiWJ4691vryAMgwb1xNixepzSezV1VEz70Y9GvttZTw4pBLxiHD6sG5v19wZlUUJxj8tvU1
 q28ibzfTXZn1mUAN+qDtrReCqySfKo8mF3Kc5BmFIu8Uw4EvU4tIPsLls8bWk75hemUHHc1ow/w
 5rzK0McpWudL770iOoeT65MHZG5kr5QJEqDc32LXVrzY4uvwW8l+UVSUqqGGePk9jMAHjViXmP9
 FgZNPmfz2a31NTuvXMDe7kLBQ0ZNQwxmHjvA6/O9GCmSLmq5ew/GrR8l2+yx+9veVstmG4EhW+z
 iXPfwx0NOPatNahtuVRV7cXWOOubHjq4GbHIV9wMV6du0FNsVo95Fu1masJoT+OKeZEC2D3Kfk3
 UjL+xgIFDBZYSSp5VSHlxWgFPOcZlfOGAnpsO1YP/uSPKT/5LVlm06b31WBhXOcNQIUAx8Md5TN
 +8GWj4vpaSbHdVnGlPA==
X-Proofpoint-ORIG-GUID: DmkQ0X7FPc52m5HccE2bj9hh8aPHi1AH
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af467c5 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=icXyEQzqa7ihQCE8Zv4A:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXxYBNmcNVoMay
 Bqo7EknrfkGPqM+EzqnQxC9hD8T96upAb1Ml02kzrXJeBiBGprfMKJ+1fp8bPzTkoVPEFIcvMdl
 8IuuOsxA5mB2Jf/ok7ZeK7RQFkyiTJ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
> The OF_IOMMU code relies on OF address parsing helpers, but the
> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
> annotation to handle configurations where OF_ADDRESS is disabled.
> 
> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
> preprocessor guards and __maybe_unused annotation.

Why? What's the problem that you are solving? Why is the current code
bad?

> 
> The only architecture supporting OF without OF_ADDRESS is SPARC, which
> does not use OF_IOMMU, so no functional change is intended.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/Kconfig    | 2 +-
>  drivers/iommu/of_iommu.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry
