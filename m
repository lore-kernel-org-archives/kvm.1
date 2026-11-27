Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783307;
	b=YopeVAy1pHaKmc3NA6zovpEgaz73CIpipJHmPwjMcyJ30KvYShAOt8zqCvL0R59NDhRT
	 W7QqUC6EqthzD+X/0OwArudz8S6JY9cF24N95CId11HxhQwCaCDjF7iy6Cen3r7uHGC4s
	 +1euVWZTIA7wJnvdJRuLFz2Cm47fAO3quYtKYIqx5Yriu9qHWFRAgOiG+FbcKSxRu/N4w
	 CwqS7JVTCac/NE3Nq2wLcM+FL6nLMmS/ANx6rVKZA7eBThvty/uvM+aozDslhUcqx19x1
	 LIsWnP7e8HQgnudLir9HO70eE+aelnwAZUcqw5nPy/gVxjLcll/W/jlxTnue/LFU4RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783307;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=;
	b=ufe8Ga0NfVWOAvVlO29i3feIQvuNkLIOCmAdLLL0qujiHGYeVrmML3qpN6/ZBsm32wXk
	 +a56fEWGEgB6dRPvKD6WiQyIZ+t+BVAH05Wyj4g0NwXV9CJ2IJmARdFwrE+r5URtrh02d
	 Mmlwu7VN0JPe07a6LjrGs310G5TIkKdbFo2EJGRIIlqGfc+eOi5+UbMiVRV7YmRHR0kb/
	 AfG7hyvjfcGflPsLvZbxY1wv+jJ8JNUTT/l1ndhmN0CbcNy0Xi5eMggy8adCNu5Aihg/d
	 OEXml8mCjkJFX/c5uoOK6ddz6IWrugE0XHTodtt6xXQiUOFuk/j0EofmojXPx2AOjNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ksYuS3+N;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jEjY+FC8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C94606A32D
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C94606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ksYuS3+N;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jEjY+FC8
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApD7L2677321
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=; b=ksYuS3+NdQcAkupq
	UqtxonlxKl8nzWLPnjJ2cnDy4QMEFs8ukuo/xtyLmhlxavYzxHwouTzgqhYBoMbE
	2FA5UbMyhVHF5c3ODFPVYbg9DjA9YSOu5EszWDVtsLgLG//r1U/pSoNXMRgZtA68
	ePQQjJsazCF4H78cHmZmgZXN5kEbalgR4Q+rqk8JgnK5Wg7nRJAauY1hDBqouPYA
	jrWUDUIIiP9xyUTXioJvgDZga74UZUqQzVAjVdS2/KZ9qzKXIXJHo162KVnU/xX+
	c8g80b8Zvlp70HFSnj+8i8A9z5BKRrOev4mB8d/T1F6sBjKs22r5tNsBrlTg3Afa
	Zgo9/w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gh9dys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:41:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386ad819860so7471672eec.0
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 04:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795783305; x=1796388105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=;
        b=jEjY+FC8/F6SyJENSeH/5Ipor9xyWqnnr0kYQ0vAXgWx6l39ZWH45sesJV9MrMRRRq
         F4ZbARA7aUR+WmMqkpreph7pteI3BAyzoLIL6qIvSApjUESpkAWSO6kwuIqAZXzfrFvK
         Um0Bf67ehWLPUavx8SKe8KnzjBP3E6ifMurS9Mj1DDcRiWGtsufEEI2r/p6FBCaDOacK
         1Rl+uhpiTsR1WGDmIT9VGpmS8OJf/OEsoRvj6pO5E4qS8KJqlxkep7+fB0YdmaYpmZSO
         LemZ+n+ryUjf80EDvuqcYBrycC5igh+nZx6t+2X+ivcZ5v8w4GFDXWeDQFz8Phl+Y22H
         rXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783305; x=1796388105;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=;
        b=bh4jBjgQuSQbeIGUvZkbwo8/FFMBsre5sOP9PUDHilTlDil77IzFuvMlHPsD3ljagD
         XwEyDiojCwutVmzXi9IvO6/PRg6x5NUkV8o8pvtojBMsxPrpJW7Pgqp9c9YcgH4gIOun
         yJsfX8gcfkDp9JoE0byB5KKkiiGVWxNpcrxZn3Fjt3mgvtztfOPKFmeTIYlCmFMpYIbD
         2hUzpgE2YHUx+4rK4ABUn8CMQwtnSFYT0s9qwMiw16pqi8OLm7aVD8P2VYrCOGuWz8Xf
         JWYOGa99UahAZSVUKcNOZAbUWSdZP2DsdQ2IYwzCgoN4FPFKfEiowJ2ksujWZGGbMA/H
         JH4w==
X-Forwarded-Encrypted: i=1; AL+hErGWFYMeg/mhYi/jFhsV6rKY7ZuDVvhqX8s9wcfs8W+TgSGp4xICjVWeugKq+Ebmj4yugPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zSaEzRU1YDJxF1RmwY7KEXoOcl0hQGdZgLlTLn8+HzjpC7KXi
	wKbp4YHAkYLQeFxV9diGqo/M7y027zo8XU4dprMU35u7E33qyMiywly2NqxXNEGTwnYFWoqPF/C
	ABUvCKAfDcwEdBBeRnQrwyrAfmmI0f7356HUaRIL1g7GrkSiduijeEdQ=
X-Gm-Gg: AZFdTZfSVZcCK7wXDZCzAEeDFum8fz93/MmSRA55uGXp1I2f5gXX3QmRiO22t181n4v
	eJ8BDAQ27fjzcGyDo9yXAwajEwBwwSFvqfZbDwERda4VKGGeUGNKx0s3HsumFJRvBeB2La5rYV/
	aqWOOKAPvwaqciTC2rUHuvCJd2pJ59mpcFXn/Vc979Dwsv1jTnx/zHpF9cB7iqyJY5Vvsqsl0SD
	5opGB84wEgFpwqS9GGtiSBEi8geepsVsNnaXt0dwk6QI7xvmEKWCv5MIbtAc8tSt8cr6bC30Zs7
	MK5tmZR4KsRDR2OrZg69A6X7uw7N9gVOfJNbWJB+cw0VI6xfGHImPPgiUeE9zSQ94Pn0ewaR7sv
	9iPO0rk37g2/mnq92Bh1T9U5DHkMUA5hzDxPezkdatwyTssH2AYjL7mE3rquAEXWQ3RNVW5mpB7
	GFyEGClg==
X-Received: by 2002:a05:693c:65c3:b0:386:e9bb:d9d3 with SMTP id 5a478bee46e88-386e9bbda7dmr2871223eec.28.1795783305042;
        Fri, 27 Nov 2026 04:41:45 -0800 (PST)
X-Received: by 2002:a05:693c:65c3:b0:386:e9bb:d9d3 with SMTP id 5a478bee46e88-386e9bbda7dmr2871178eec.28.1795783304400;
        Fri, 27 Nov 2026 04:41:44 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm74177848eec.28.2026.11.27.04.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:41:43 -0800 (PST)
Message-ID: <1ea0310d-b25a-4e34-930e-7998eec03605@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:11:35 +0530
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
Subject: Re: [PATCH 2/4] media: iris: use dma_iova_size() to check the
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
 <CGME20261127115900eucas1p268ca3a6688c2fd99513317dfc99dbf59@eucas1p2.samsung.com>
 <20261127115849.2780625-3-m.szyprowski@samsung.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261127115849.2780625-3-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfXwAsDxrykJsf+
 eCjrze00ro35qQTanSqmhcHPSCHEbIA+xOZPWi/83TGB2EcxuHbDnGXvT9IfJiNaavTlTzyzitb
 Q7RmJ+ILyuCu+Mh83wfZnkqQ0ABWIdk=
X-Proofpoint-GUID: o1MrpZP_pA4kLm8pYGfLkuTBhHatuejm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX6Nu8vAt2gGri
 LTC3ANzutBsnGZXBiqRH9H7fi0g2PRxQXOQ6TkEylwKywDFC9ushcVwbs05O4bWSAe8R2zBs9UV
 m4wQqMsEOL/Iidl1SIHMfM0BORMunj8QMV+tt9ZF2T9ZNDD1JwwnWDo4Pod5hfTveQh/S3vryYU
 3otg+FBEoi3gV/HjDytxCQ0YrLcpm4fjCb2wjhTbDlnH0YGiBCA0745n5kUvTDtnUJgSIkP+1Tu
 RKqtMAhXe+bnfO3J0CnSsg7XKTpvhtpj/NtDT0cr0wwzN87+1fKPnQiMPvw/hZDDYzqbnWfXbvU
 DGZIqjDSR+FzkdF9kuDm94lHr9Se9x+nUfway9wRTXyS3Lynj2agDQ8mEsf2GJbmG1JuBEdSBZN
 ZFLxT8IYbeed+0fpAiMr0OPldguFTWDwiT5RkYJuW0ZwhUGr9ZW2/QchStI0w8DA7Kc1X98BX+B
 gJvQ2jSUe0l3Myop1cQ==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b097a8a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=umoC_DmSGuEwgYlhGCYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: o1MrpZP_pA4kLm8pYGfLkuTBhHatuejm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270050


On 11/27/2026 5:28 PM, Marek Szyprowski wrote:
> The IOVA reservation code compares dma_iova_state::__size directly with
> the requested chunk size. __size is internal to the DMA IOVA API and may
> carry flags in its upper bits, so use the dma_iova_size() accessor
> instead.
> 
> Fixes: 200473c198b2 ("media: iris: Fix iova allocation from restrict region")
> Cc:stable@vger.kernel.org # v7.4+
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> ---
>   drivers/media/platform/qcom/iris/iris_probe.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
