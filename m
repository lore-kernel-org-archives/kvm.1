Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001328;
	b=U+YigjKHtIF/LO2c3XpOn3K5wDeCmvim+cY7EL6w9+UJtxFzkDBgJj18f3Vyb7FkFMBh
	 pTqrRahPtTA5x53oeFVWqUtHWFLVRTvYgrVQqgqkiURGlkJtczr6obYzkWlH1EmULrJUg
	 s1fq8rL5uE40uEi1DOPf5h3zHeSUFhLqiDSErCn404S4cprDecTNI2zLFXyfkC/vAAGr8
	 lT1S4qZ3StGRxuGpG36w7rGuXWN4OViO01uJfb2mTISjoITwsj7zJsMO9MGNf1yzCJmNn
	 FMx6HOfxj2zeO6flT+SsF9QtglTZXMoCNYlzWHrGT65wB0OoRDDFp7SDrKBZHcylpIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001328;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
	b=pqi43TPPbktElEy13v1kl+yy0G9HLp3mL/IZOXpSDMXtCEjldcJE6uUf1k/vepK7KhHm
	 gAvt1Eo22HVEBxXRt+WflZydxGr50agn/kZfJa2eCtFVRg52sO45zKTJG3qmEeKGgMZVQ
	 bljzStVSs4uRQVBOn3+E95449jY7rp0zfUju6JALrd+jCCe6uQ7RzZgMuFu1JJlFCARdo
	 Hf8NJmbzKM3IvJOW0LAWLjbUjJuDTwTuSA8YuvS/GMJZImFZ6cQHfVYmNpQ4Nh7ORT3o0
	 njQTDsozZtnkJ6eifd8jFC2q/k53k7/FL7zskP9OPBakn4o8C9oX0uXYBTrqco2uwuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ntylGciU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NoTaO4RE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D330606A337
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 11:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D330606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ntylGciU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NoTaO4RE
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBL28c3282171
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 11:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=; b=ntylGciUuJZfpWf0
	c9UM6MyqepvVZTCUP0ikndK0p570RLatJXjQ8tNCA42mvik8m09Q7kgxjCpYLS5w
	3be24pUUqP+OfFXhNIl/dv7A8fLLeH6RfrBGHOO/30xV0aBqh2ZfzKxI677TTEDd
	KcbZ5VbENV+w640ft3HbjuEvm/246WpbBNMsmpm1min/ZK1eV/GhMmmg5YZH3KU0
	zAgVZSwH03j1TilDVNNqaeyEAJ8AqtYa9gTsWf9+netIh/R8bQgtN/NKSM5Ri6RX
	MunrHSIsDg22tgIDcwR6X4XJZb2Z0OVbk665hfMAIpeETNnFmWOLuL8vK6pqqlau
	GQpvbQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8tqqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 11:28:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1091604eec.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795001325; x=1795606125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
        b=NoTaO4REEb9T1/yy2aYwwQCVR409nQ7wTShxB4gtJ8U/OW5PfgaUONKvVLtTb2CVr1
         50RcLXlF9+Z4pz9bDGYoRvXFLT9/Y8aj2FBnBKaMtkXH0qsCjRnPXqezeEvlBJwb0IcT
         Yt82bwHCyTUFZmqrvjOc6iyS8ZyWip5ebCafzkfi+uzk8HYYl2U4gDjhEVnoz4einNBo
         QyoNokoRzRhxBRxU6L/w4hFCpMDKANZrvcN2XQV5GsCejOLwMCYtADaE2w2p0EGhurHq
         4MUcjK1AaEPZiYe2vQEm6S98XFI40IdBDf9a/UfWVDzjx+ltweHFBzx2XFz2FvjxyXct
         VVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001325; x=1795606125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
        b=HV5wX9s81HxWmlTOd1llg9iJcUuZvt5hXZMSH6pSK3TxvH+jDEl/CkqvbSJXZPCaQj
         czvWSWE1b6c8iOxA8iJjDFR3h3+Az567kWfZAh9TiVRqI1E+hoWs93q7qLwhgCfO23z8
         pCOiTmAZq8zwdREHhE4jQDCLESm/ufmtQSlwk8FmrdMkroo+QSjaRxNU4o7V3nLfDxC5
         RiIi9YyAPmXungymVse6q9HyJ5AKlo4KQypp95XbIo4I7Y+NWLnmfWkGsydxjSoU4b7V
         2YVLaLJzwP2AJR8SqGYagRY5aqxXOJz0REnvr4e92mItN2dPqLX6m98AB83ThUsr42bK
         vtxg==
X-Forwarded-Encrypted: i=1; AL+hErHOuHUIiNZMy7BGG6xk19hPkLFE5+9P64qG9VSI51OJcK/TeREhGVnPjkDmjU1kB6yqM/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jJQK+y9ivQqDrK1q7Yup/0d17PENjqrAgONjIH+7rVfAaanAw
	HeZnHzkQd0lkN8AB5pFwJiQDbSPKAk7U54Wb+P+xzKSij4DijUw6ha9UQzVG8xQVzd2sasFgfCN
	MXzWi8Phh4BSSWSWo6vVxJHw4UhABzFsGcyYpdFv9JOovZxo5Dt0EWlY=
X-Gm-Gg: AZFdTZcf9NG0iCyOJGXpXILWDQDRnFjlt62AY15zijuZEDhmceXLdDL503qNwelFyft
	ja6L8bxarm3GgEmNjx75ejb+uy22TIfLGihPvrDsh7mz0nqd0erYPiFU/kE+Mag/9OSGvsj6lP3
	RJp9ZAxqILW39D8Swkyc3zXle8tWhMXjCKw8dX2bBqF/GSL3IOusrFJPEsDI1LrFRQUVLuEM7y9
	p3/v+7e4vIMgKBrIPh5M+81mFVR5TMEAPkQ7y3WHUoo+P7pie73UjuE9pmUaul1suiTxPKPvj0L
	XRdF1+FuR0LNKhp8NY2uodIyQ6b/7nsErIDBtNQF/Zs6mJ/TiEzUDE4uLVo60l/0vcXe1DGGK3b
	kr4FBdTUJwPyxME/0hCbRWtekSZKpuKY5yHqPaqS7l7GB/Oku4KK3xG7nbvDzj5K5wJwI976e+f
	7bFLNgPQ==
X-Received: by 2002:a05:7301:18aa:b0:381:e45d:be08 with SMTP id 5a478bee46e88-38280a3c1e2mr2400870eec.21.1795001323987;
        Wed, 18 Nov 2026 03:28:43 -0800 (PST)
X-Received: by 2002:a05:7301:18aa:b0:381:e45d:be08 with SMTP id 5a478bee46e88-38280a3c1e2mr2400813eec.21.1795001323169;
        Wed, 18 Nov 2026 03:28:43 -0800 (PST)
Received: from [10.204.100.88] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm8539071eec.18.2026.11.18.03.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 03:28:42 -0800 (PST)
Message-ID: <1fcd89e4-feaa-4072-a5c4-56318b1d8475@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:58:32 +0530
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
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Joerg Roedel
 <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
 <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
 <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -9FEwo8gXvn4RvsbonJUlXVfH5QBrTVz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX0iTVXoLmK1jV
 Un7/g1EK1lQ8CcHaTuCc01UZSAsvbh296oDnHm7G5Tf3FToqWTAjWtr6+TVv/6bb3uhZXFItVBA
 F4S3WurL31V8uadYBBQ8OShTzEgNgYE=
X-Proofpoint-GUID: -9FEwo8gXvn4RvsbonJUlXVfH5QBrTVz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX2zrIAqmG8OqC
 sD5ZnAl9qtl21q4FPIgQSTl8opGijsfYwdkBLERMPX3SFOgoNhCXJBRMoce6V/p/xA0+T4OAmpu
 +C364BOU800TUe+toO1hFOrYKTDGwJPZ1RELQFpN+EtJM3yhY2zEogMxivqMq/7y2AXLCBdPHOe
 QFVq3f5MudQcOPU5kA3BdgyS+5IfrVSCSw60an4wesRzYCyHJdkK3BTkjaibJdG3JHUennvPmU1
 rZ6FI4iUF6v6mzAwKGIZGe+vyejK9Ck0AXcjxQ07+ZJW+aYzKjs/rRvprTVzCaI4Fbskf44auRm
 eNjnmR2a+n619Y/C8pOd7LW9KMGvX5TJLTdR8LVgnXfhR/9oXefP8UWSiIWLROw2sHra9f01Xhv
 AeXdS73Jz4vVbcaQ7HD01P94BzB/2OL15A25YCqhIhAXQlqnRIvop39GThnDX7B7P07lJCMBIl7
 fMSphEdnZUTJjb1J7wg==
X-Authority-Analysis: v=2.4 cv=NNVAaE6g c=1 sm=1 tr=0 ts=6afd8bee cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HfRq2NBFtK1Lh0_1ebIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180045



On 11/18/2026 2:32 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 12, 2026 at 07:10:38PM +0530, Vikash Garodia wrote:
>>
>> On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
>>> On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
>>>> The OF_IOMMU code relies on OF address parsing helpers, but the
>>>> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
>>>> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
>>>> annotation to handle configurations where OF_ADDRESS is disabled.
>>>>
>>>> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
>>>> preprocessor guards and __maybe_unused annotation.
>>>
>>> Why? What's the problem that you are solving? Why is the current code
>>> bad?
>>>
>>
>> The commit describes the problem as "The OF_IOMMU code relies on OF address
>> parsing helpers, but the dependency on OF_ADDRESS is not expressed in
>> Kconfig"...and instead the code had checks for config or __maybe_unused for
>> cases like sparc.
> 
> What is wrong with this approach? What is the problem? There is one, but
> please state it in the commit message. Something is wrong, otherwise you
> wouldn't be fixing it.
> 
>>
>> It was discussed in prior rev
>> https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/
> 
> That's fine, but the reason must be capturedd
> 

Ack.

>>
>> Regards,
>> Vikash
>>>>
>>>> The only architecture supporting OF without OF_ADDRESS is SPARC, which
>>>> does not use OF_IOMMU, so no functional change is intended.
>>>>
>>>> Suggested-by: Rob Herring <robh@kernel.org>
>>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    drivers/iommu/Kconfig    | 2 +-
>>>>    drivers/iommu/of_iommu.c | 4 +---
>>>>    2 files changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>
>>
> 

