Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125581;
	b=qkj/PicPeBxQuJTY0oAa77Q6ZHmxIKOJSuI/3M4C1p6t9ZMcfBLKLOCjxu4+xxJKafBt
	 xwx2Uso3jw+9gRtn8TqlInuNgQn5Km9wZZEY+Y5RBJ/JQ+I8zVYMKWZy6hdzoPX7syBiT
	 LkRp+hkYWHeQh4TtgW+HwL8E3AenmNty2XuzclsW5SpgVfsEItjKUr2KGxV0+1peRpC4u
	 pRjK/6vYP1HZ/7+KXcsGkoGZwfcPdPkfdK8304itxMB66Jmsb7TbqP07IORbz7xuKEFF/
	 KC/rnSQVeC3XA3SnLdEtHS4mD1rj948uSEkN3LKl0IFmMzYaluJq5rZGbpjk/ugUdNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125581;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rqvwCdeTzalXFMsGrT6m3x8p0RbZtnSwh+wuiUwhRpU=;
	b=GaMc4zHfpQmS59Eoj3xr2J2yHuUa8IGAdL+qL9VRm0tZkzYQCgwHfPM37ekLmGkbfSjg
	 qWNhMk4gQ4GB0C3slIV1yVhqHmTN+CG+O1BrtUbwnubcU6bZAMcFNzcv8999fV2MEFJts
	 GiO1oPoggMRI+6qFgLukpV38dSmO9Lz0CyDsdWAwUfGCS5gfQPhMLTvYym9AiKO2hV2tk
	 cRagksvDpoPdYqL3FNglWWyL2NzeIt6KLqcDXP9PyZLsQURXAnjYM3lmnGWpSN3WXy8M8
	 Uaj4kieGkjMKfZ4Jg13GkDjXEPj97FrFab75rfjrhImIFJ8H5KHQnKfsZuDfCsJGpdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GaFTzCbc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HxyHNQDC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CB606A321
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GaFTzCbc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HxyHNQDC
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIHq6m2960506
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rqvwCdeTzalXFMsGrT6m3x8p0RbZtnSwh+wuiUwhRpU=; b=GaFTzCbcWdxFOmss
	X1hmR8YF6qkazqrBr89HLjt0dkNHrMsLmj3744a08FVuScFjDSrh90yi+m6ZeHCY
	0UU8XuK/tqDgKN3RSD51unGb7rW3rJME5p/5c9VYMUezsjXivQeV6CVILayDkRcq
	JLjRk9jyADcT2aDITWoEnGmWdrylCSBBaK0tddTBmypy5aWG+2SsEgLOKgWKl0Lb
	k7urQDtU6nDl3DhBQFdEpiDoVSYkUYp63o5VwexRSFmejyX3p9EUSdEMxhmVurEb
	BmDEPz4ceTwm795g/6NeGg2NqqIpv20jutiW1SkgQhCA4mSk+hSOSAthzCu+7L6b
	Dn8PDg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670mxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f20addba1so10826985a.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793125579; x=1793730379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rqvwCdeTzalXFMsGrT6m3x8p0RbZtnSwh+wuiUwhRpU=;
        b=HxyHNQDCAS+oAtNDD+/2VEzlNSijqK7SALk/BPTeo6fxJO6dcxgGFPfH6YDlZZPR+k
         nVvfWzbXZGGibb+9Hd/bf9pAKCFvYnGSnnCndSo+Hg0Wt2efq5USJzRvDV/wJf8mtvzc
         1VtUdzngJ+c7+EOy2wc26gMbzfCFJwVtDoAo7DK4mV3n990mThrTWmIMeBV8ZHugxfLA
         pAAe7yJOHSi7VozYs2wNEihsbUUEQz6bHiJlSXcvBQVh4yQyhTJz18hKqpvA+OYE31lU
         TLQXao9eCHnMeTK8rWmzffHWCTeui4WZUk0I0PPlOPMTkZ48kfKnM6YnfHC5XRiY9Hvk
         GJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125579; x=1793730379;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqvwCdeTzalXFMsGrT6m3x8p0RbZtnSwh+wuiUwhRpU=;
        b=Zh+TZ9Kr6oG6snlfV5q0widJo59cwXrKyrtuKCmCJS7iyGdQjzcZNDcTS3qdrpBF4m
         3cz1cSxcfqP4GfL9imjZ6g0c0RB4q6E/Fi+XvCJmdqbdTvRll8u/FP1kTYzdla9pabzu
         3UiztXY8zoTTaM5lDZjEhktCRTJCsht3pxDWs2Z2B2G4Dn+359/7TVaJy/j2FOInMU/Z
         mY+SyPOg+qCdpxnk/wvrnfKl6fXjIBPYDRz0X9KqhhtjD5SeJcD4Hq38oZcYFhn0EDOl
         CnWa/EzkLPg9eCW26uZoCuQlUoSqfQ1G2nHJF9lKkSSe746arbFPwZZGv6o5TCHgzC+w
         laEA==
X-Forwarded-Encrypted: i=1; AKwUvBzYc/9BzrPiqX/h0p9pFkNWR+2bTCCK/F9uVIY5F0lZga3lApfZAAlKwxrS4UzY67SNdt4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLf4qFKGQV36srp/41fyt5B/GbxjiPFBqEncA4eFPiliv4qkgoj
	j0J0b8ZImKI1yxQ9osh2SbKHXksH98E7R1qzg2x7/lcK2nSE2SalLjdiqzercH/zwm4HwWBvFdc
	h9rHwCm+p5K/IS4jRtDX62rb1qKgJig14DYnQ3bnZTblnh4vZITxOyTc=
X-Gm-Gg: AYBFou2C0kR346zEgowW0zJN6i7LHEr2KMNf/jhy4TeEZLOXdWsKX2IyIpRH8uLDApx
	lPXEjynWbFwHAcCCQttkqM1gC/5/rPwy5T+YMjmNJRvcyrdoDmR2VTw8d/KN2VNRRPSO59dFetY
	gr2yC2cJELAOCJAWgDP87YoHUmMaA5nEVI6aCB5SVE7nz5mNqK87Jkd5j/CHOvXF1aAXyxnw8L6
	f5+0/YjXmhnFKvmlvCRzEMk9qKbLtg6mL9Dp01J6xtqtD6LEFAaklzPLjZvqkECnW11vyOzfflZ
	jF9bpVf2x7AU84DJ/FBEQqoLBQ26UKB/eHr0djYASIMxVG754SbwnEe2kjqYRY+69SVLDxHWLa0
	pbOysAGEUqADnyhx7TDLmZ3JN63BSBAtYONFjn9MmyxzT8J2rS3OF9mX4HRc6+Zzb2L2SAoNzaF
	mgf5RCG9XfyFyUFBL7iL+pXcc=
X-Received: by 2002:a05:620a:4689:b0:93f:2e08:6420 with SMTP id af79cd13be357-940ef930089mr1680123085a.38.1793125579147;
        Tue, 27 Oct 2026 11:26:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4689:b0:93f:2e08:6420 with SMTP id af79cd13be357-940ef930089mr1680116985a.38.1793125578678;
        Tue, 27 Oct 2026 11:26:18 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net. [82.67.153.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94c021080sm519415e9.2.2026.10.27.11.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:26:17 -0700 (PDT)
Message-ID: <a7e54c98-bad8-4d2c-9e78-75297e772670@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:26:16 +0100
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
Subject: Re: [PATCH 11/11] accel/nitro: mark 'nitro' accelerator as secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li
 <liwei1518@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chao Liu
 <chao.liu@processmission.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        xen-devel@lists.xenproject.org, Sergio Lopez <slp@redhat.com>,
        qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
        Bibo Mao <maobibo@loongson.cn>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Xianglai Li <lixianglai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
        kvm@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Song Gao <17746591750@163.com>, Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
 <20261027181400.1752951-12-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027181400.1752951-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: itm2c8n1EdUABUOMP7PMtbk4sCzgqzKj
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0eccb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=nhBbSb_fY9f1tbuIA-YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX9o4hZP5UlNBB
 kNZkYJ9imAozt3VfoWxlHm/UIAH1D+w9yA5PM+6Q9LBW8ENekdTBXogALoMbeBChcJ9m1viadXC
 vc86Nk5JfGxzTfMVdQZr37Hdea4tieY=
X-Proofpoint-GUID: itm2c8n1EdUABUOMP7PMtbk4sCzgqzKj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX3PKMqni8keRy
 CVCL2Sd1tBdvQTRC68MuG57UUoPF6Hq2IaLreTCt3iKsvBSqlumEvyHTeCTeeZjGxM6jq9OSkhX
 AgH7zc6su8zlXnjdOHYcdAp2Ht3c8++enKxPQcUtK7td4YRVlO7eroooR6ihy1Rwx7gjT8v2GdN
 bCwhn4yQbMi1zbhDtSye8wPADv9XNB1noDyruG35xqP7WLvmRZ9g0siS5Y1A7QcxEIzw89IDcTx
 FAyXlH0Q3tFJxMo8sqVzvt6Of3MDF8FrnvdICeBLYO1sfkR5F0IXo0XLcnqrlC6UPbUBu8jZJNk
 ET9imLxGkjN+N92zcisGJm7Tlv7gjUu648ZKWnG5IP1JOWBSwA/0bj/YfZR+XbciqSBBKY4E1X4
 pNzX8A+5b1kMav3K3MZeiUKyk54QQAWqwafg6g9HZB6Mq5VQvN3YAUn8/lMz6+3v6rTAmfe+TO2
 5dzTKXEbFozDHuBxTIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072

On 27/10/26 19:14, Daniel P. BerrangÃ© wrote:
> The 'nitro' accelerator is used with a real AWS deployment and
> thus is considered to be secure.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   accel/nitro/nitro-accel.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
