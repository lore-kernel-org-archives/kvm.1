Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783285;
	b=lJ1NBkodQP5uD4ZTC7dc0S4LEBCsZMHw/wEZDtoNEGjmVo3NPyf0avmxc+MydqBMgvD8
	 BO9ZR8a0kngywsxsg10qsC1sIGTNckOxs+tFOqGmfoALrMjKfK9NOHBGWBOWf0XcGyzZq
	 b4nUSuydMCern7K9cwZKTN0Qvkrbxds71OFcGNS/FeGWQ4KdMnqOzLT56lHeC2mubZ7cq
	 Jsl2hRGxsYj9H4+0etHIeVN6ZGRFvHkMSHyogdGI3e06Ng7GBnGvvj9KMzJNHUEt5IzCs
	 lOZ6DiMpYa9oaniZmsuokgo37HBI8vd+vMQZZRmFwa/irNgE/DMAjKe7KA+QE9GmJSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783285;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
	b=VMpb6j7ClcmRBZbvfhdbbBcSY5sLS7nfz5Z7OQMOuplduh8clMJVJ1URvmpPo7EjcjSW
	 DqIOJJR5hGA4iNCcoZf+b+zVoFnGfz1nGlHl1imWIMrnCaVtsh5sLRKQPc12hrDFBVJoa
	 I2bbFK4iwZox/bmA6cy90q1MD177bd45XYdl6vaOZvCVQcajST4HCNennyjT1AOl4Mq80
	 MiZyU6Og2r+Oxg2OZ0PANdq94hzNnwwSFz/LRpKVrACyaCib9gUKNMd7HN8SWsMFGJZZn
	 99VvAWGjjvNqHraHg3QKdUzKZn8U2KdLe0WotWNqeJfsXjG7Qnv3u3S4S23FI6X0+6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwtlwXbU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ViQDMJoh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315660A262E
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D315660A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwtlwXbU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ViQDMJoh
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAsHGq3609882
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=; b=UwtlwXbUzcwW4iI6
	hSK5ad+HFd/+LYW/fiw1EDNV8nDTBBJmMejo3/qPeWqAnAfb/gBvTp020QIvbkWJ
	2VATnaKNOoa8+APXE/rXKdilHmVdEmCCERYpBFi2Btvw5U/G27VHDc3Xcgj9VUP7
	fbI1uj5gyWF0hF2tzOBXTJPCjXyjIcs1PUaNE0R3YJ+hEf1Hg1gzEiFP2prZ/cNx
	xbdDguTT0krxp26OPzDuEeNf4NkOFhjXDf4iGLtrDhv0+jB8j+VoT72k1JLWeSJD
	A+afRBX8eRb0k5++huxb/J9hnFPnrzshqHJnQWVXUdV9u8/OD7Wu3hB3WIkpQKan
	migdWQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73dh9neq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:41:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386a0f79047so8677205eec.1
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795783279; x=1796388079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
        b=ViQDMJohWOkii98SgMb8tVx4fQ0FB0evAogm5qHkrPol8mKaK/GnYE+eEwxXqLpj/1
         c4PFdBjaVIqHPLxD/6xSTY5ZfLhaPkAhP90B2mlvZXH8liz2m3eMs98nKqRpJpmibv5n
         IZfZaRuDkD+a6rZ0hR0rBCKNR9JYlOdRiVMq+DCfEsryAvQSMBqS9kmbFxNtperSMufq
         S6JTT/V16JQ3FZWS7wZnHN0Ew+2ifCNcLWQ5ZIwg/+CPsl8NgwLZVpVMno0RWSd19meJ
         AEzaXY4cjsE3y5AvdCNqtdtO6E6Gb9azAijwkAmwAPgmhYV20LCxN5kymjmOfcOgeW5X
         wm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783279; x=1796388079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
        b=UVF8Rd5cZM+YXBy/1SQtIOavUQ8XXabCz0XC4vqndsmRLnbDIvdLNMmM7jiWzamYJJ
         arO7ZrWz+4J4PG/CW6A4ZDHof0lMWOfrXtHo/lWKqRp4mUnIk0DtsS7L46bc8RZ2G3HU
         Hq8HBNZLGkxSwEzIzHYrjvhcqIb6vMukolQrWHMBcEmBQGKVaPcaFzQOgGIgPNHMF8oG
         T6tMmbXz4VLKXhPH0eIfGWHpr4cakWQ8+zjML5CcAEfLPwiY8hBPNTSAi5fq0C2cYl0z
         xpmrJx8hjUof7IG86EUjY6vMiIS6mMG7WXSlOfxU+ueAbX1BikwYe/Un+z0SxOX3tPla
         WJ/g==
X-Forwarded-Encrypted: i=1; AL+hErEFCtlHVJREZ0Is6J5d4AtJ+yc5w0SFBXoednuPJNVhfXtKMA90+UCtZfxcozWCi5mcOWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iMgJNwlNoHbhOOAbFGeuaCVa8Tr0o1yNMSwdSj1Vos2f5M8ey
	+cksAxFXMLp9aDZbnttFhdc9lIDsMqdtmn6MnhzQJIHRxSExJ9v0jgY6KgZZPVpYuyl83QJwuvr
	WnXKGFwFjj24dK0dOsEVA8f6qHqCs+LbrLNt1YlGF2dRrEDnY07NbRto=
X-Gm-Gg: AZFdTZetI9VPE6EKhcEImB6dh6baNFzOPjhmwmg3/AKe91Gnelj2cEROWqMY/eQdkQW
	o9hGUVv/JGAKR7dhDUfSQ8THkaM0EBBodhd9TXb5Ht9KWvICxL/ai7Wr1aMQmS/f6mcEYUHyVkH
	CthVCXYHvuEU/MJplwUOkjexHMzxwwMPCbzwIr/JN6toMzdjZ+i1i/tDX9ahZrtM0Pz4lRqnQ/u
	Q14bRe9k7/VPOcZjElnfYe3nsm8EbUVtc+/8jgp/RwJaQ6FLpn6r2UYlFPDZ7qw9kAThbndKUJR
	P2E2w9lOsYFxwrBnXsAamxxc4m4LaTgEhx0U7wNMfypv2tOh0eR2AqwywSfkIQVK8i1+QrhOHXl
	/ke/5xQBCI7NfNAi0fxJG4jkwV5TGOG/RTr5bLkes/yH5GJGcasO7Kc8KlZXzgygH79QcqVzPRE
	s7JqRWTw==
X-Received: by 2002:a05:7301:160c:b0:382:c1cf:163b with SMTP id 5a478bee46e88-38571419d38mr22800268eec.32.1795783278702;
        Fri, 27 Nov 2026 04:41:18 -0800 (PST)
X-Received: by 2002:a05:7301:160c:b0:382:c1cf:163b with SMTP id 5a478bee46e88-38571419d38mr22800239eec.32.1795783278184;
        Fri, 27 Nov 2026 04:41:18 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm82044382eec.26.2026.11.27.04.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:41:17 -0800 (PST)
Message-ID: <fdc9fdd9-1b76-440f-94d6-c6c982884878@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:11:09 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sibi Sankar
 <sibi.sankar@oss.qualcomm.com>,
        Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
        Alex Williamson <alex@shazbot.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261127115849.2780625-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX+us9jC8GX7pW
 OGYHHrgc3UuixuHvZZsviL4czf2/GJd1sAIWC6M1Lb16CQs8ItavicjDAQkal0wngu9gjH3OGgR
 JHsddBK7jgLDVDYPOA1ngwfndcyl1GNqYBlnTaiMWztEqSjdADK8Oz0bx+2GbI8t5C2jJpShA+9
 HV9T6KAgQ/I8iJrBEYoAse7AAUy2sI9lOcoT8V9zTI3H7p5ybtBPGbhs3BnAnOKxmNgt0x4KrEN
 A9jjSx8TeaFID7goIhpn7GkoD6hL9j5dgH6ENvqa41dRjSSD7+WTehP784XjtlEcKtiEHxO/sDu
 ZoQp98o2c4IDGFzS41qMcFlZG9jhccu2YXaDFrReyqcBhOg1Pbguu3//f+Ety2jdgud9FL4oJRa
 7BjYqen/8ghPL+dzm9YMC3EItgNGk1n8u8ZUGF18AeZGW0+morqEFSocEiCKq43HXwdv94uowHs
 ZVT901xne36GjZ6T96A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX686EQL7RczfB
 s8PZtJD1CRbMn43GjQz5Kqsrp1L9JanZuY0mwC/faBmwaoCU6l51jKraAcD8zw2+cXEMzJwKZ8v
 VkTEOUxUbRqI7V9xWG47d69x7fTDPXQ=
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6b097a6f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=umoC_DmSGuEwgYlhGCYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: I0DWtVPYA9Jvya2Csu6ZnuGkZ25hvY8e
X-Proofpoint-ORIG-GUID: I0DWtVPYA9Jvya2Csu6ZnuGkZ25hvY8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270050


On 11/27/2026 5:28 PM, Marek Szyprowski wrote:
> The IOVA reservation code compares dma_iova_state::__size directly with
> the requested chunk size. __size is internal to the DMA IOVA API and may
> carry flags in its upper bits, so use the dma_iova_size() accessor
> instead.
> 
> Fixes: 953439251b59 ("media: venus: Fix iova allocation from restrict region")
> Cc:stable@vger.kernel.org # v7.4+
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> ---
>   drivers/media/platform/qcom/venus/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

