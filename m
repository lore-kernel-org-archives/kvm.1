Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCD3C277E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079902; cv=none; b=toZzrv5eyrCmStjO/YecO7n4jY51yW9O/T7t/y+z30VV9CT7NKgmYINsi+rhiga4V46lz9YfzvW4Va5nDEwPuITD2Hw38a8C3esLDiIlYZefe6TS6JeVfJl6gP2ct8RoYl0z6z04DWfAdKvyo92O51To0L0GZPth2t/p7GJ8BWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079902; c=relaxed/simple;
	bh=iRNWSLdASuJX2DIoXSBYLePKQxgv/xqx7Ka3wz8BJO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Unv+I4XjNfyM8XvZXbPErCgIg+mf3gQ2I+vH6Rim3vb47nA7n3SIHQFqJb7QD05h+HeXNPkZ+NwDAa44flbi4iI4+FTTQke1AQSJ88l5qaj7W4u5mJDE45RUeEsltO9HOPyplt+5WHbvhaRuHntXUeQZgiaVzisrdOTXTysElnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GW/xRJlM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aS6cj6eI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GW/xRJlM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aS6cj6eI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2HEW198938
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3zZ7sVCQ0xTCWhIQM453AbNsQTss553nVYj4rAnmItA=; b=GW/xRJlM9ZRr/mju
	lIrg/Dv7QgHIWZRVIGCDNsKz7wIG3uAWMkTmjwuesRxWc2K9EvLJEBQ2ICvZlASR
	mTjkRJ5GqDrXLCl4ot+nckUQkLl2s2cH08e18id3kJ2D351iErlfkj16/P8oFXSQ
	U5CUqzAsMJ4OYQppgrygbjny33clo01K/JzsdDEAtvCNTRmZAiQxpS/ZrwQMTypM
	qyrZg19uiwhPt1EAUlAggmZQ1Z4QVgBQbwSkP0kT9MQx10pW+XGaII+4bAjdf7Lg
	kwZ/6mnT1ZejOpRmGhufS4FPspd4OWkrG2yVfGrdbJDwLViM5DKKyBhU+JX76ypK
	xvkl8Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnh6s2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:38:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304ea1eea05so2865733eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079898; x=1780684698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zZ7sVCQ0xTCWhIQM453AbNsQTss553nVYj4rAnmItA=;
        b=aS6cj6eIrfD1PpzoFshGRzIhWJXW3J37UOn3dqwG4PLj1xPjM0ztV8WH5Zt7zxKA1o
         kbJoZIkh4xa/XGgGb75XfcbrUZOL1W2JOHP6ge7xieoIcgnpZozccRWLms1o5GiCk8PR
         yFqGNX9dEh0hSUtPaIqllnqf9yx8pA0Ziviy80M56vez6FpoA4XIUCgAHVK4VnNH9zeU
         rGnWum9jEpZ+mGsG/7qHulo4L52pkuey/lxoKzuTAqPj+ThrGxKetLaV68/Hc7khFRkj
         H2XF1KfLKOBsVqezqBTsLj9lkXsjukXlspRNzG9c7PtTEK4JPj5v9qC49eSug++39xdq
         waWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079898; x=1780684698;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zZ7sVCQ0xTCWhIQM453AbNsQTss553nVYj4rAnmItA=;
        b=YcsRSqhNgK4j4d/VnO/60dXKE6B7dhL01c0NeB7HuYaC99NDvDaqCzRagfex62GM4f
         P8hsPvEkirOzyrtuRbeL1bOVJu0YvvCuSivpVVaWOukNkAtnXMLNrR+X/9ujUKuXBa1r
         lEWI9nl1cpHcpBUONopbQI7SHbW8OucDuKR4ZNlncob53zcrnTdz9OFpsxDHEmJSgrP8
         qtSr+T00XcJwSSnl1EIDsN+JDwMPw1UqlOXP/3EYmPYSlsomDGRZz5fwefoJfG/86stS
         YlmpFBVWA8/iJ+6U43lO3Ayvei4vGibOQvKwEYrqlIu3H2achcUEa5QL53IgjwdHO1iR
         WGmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9c9+15cdAUtJRL99qcj20SsFDbam5QLuUQsjZ+boBiOYxuPnrwqZmoVxnx0//A5pXrDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86bWExRzpbhNa7LnmHZ9tX6QH9tvTXOaDMVCGHhclhILRsKLx
	vnO07ZwnkbdlyU+o8KIadg4XL/Vav+1zj2IMM0tRURZy9tY1vja2e8EXOADVS2RMz43xFoX8Sjh
	ESJUSdGDKiD3u2J3XTEVJSTJCzL0N6asSK6rt8yFiPUPioe+ZMBr2Kss=
X-Gm-Gg: Acq92OHnmLFpohrnArCRM/08hn4sCtpUmEKshgnjU4eENc5A2gRBnY4Dc9TYOtkM7+8
	8aFxsWGg8/PNBkzIOOVWZZ5QegAvM7dExGC3OoemgD/UMQ479mL2W1clq461n1crpDSA7He07A3
	UK6QSInEwlTTDIYvKbSiZ+8zBM46ErBk1TocuCMIYWnbstTsxxpqC7hFKk/O1dtR9OCJfsoN1kP
	7U18mwnhiYdxJzS1oVeyaErdbAYK9f3fawSoDQdvttnqm+CgWixjwCeR2/f7kIJmzzc+cAd9lcB
	0PJLSxw3W9qW05vItqB3HhmgVaWmGClIwKl7W71zMAvWgQH6Ul6GrtKK0OKl6IViqv3sUlH0gOZ
	zcXDTBzglSLHlnCLsP9YkbcR/PNOZMRdlc3khgYfG/ZbZQoZ3/6QG6mRq/oa9NYL8AgfpgLIMCb
	333iB99JbWvNqJhHYRSWkTW01B
X-Received: by 2002:a05:7300:e58b:b0:304:d32e:65f9 with SMTP id 5a478bee46e88-304fa5295f3mr502792eec.6.1780079898263;
        Fri, 29 May 2026 11:38:18 -0700 (PDT)
X-Received: by 2002:a05:7300:e58b:b0:304:d32e:65f9 with SMTP id 5a478bee46e88-304fa5295f3mr502763eec.6.1780079897797;
        Fri, 29 May 2026 11:38:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed30a012sm2190193eec.10.2026.05.29.11.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:38:17 -0700 (PDT)
Message-ID: <80e2736d-f1cb-4249-b80a-89856ee17661@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:38:15 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] accel/tcg: Convert X86 AccelCPUClass ->
 TCGCPUOps::cpu_realize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
        qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
        Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
        kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
        Chinmay Rath <rathc@linux.ibm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX2U+h3J9ZcBi9
 wh+8oqJu0nPBxmQIgOlE3FrcizXFSAHVVW2iJV0g+6VR0qhovtKTqzCiGHoOVhCBoQ+9MnsvwgM
 Z+mIg+ZH6qgyESGGSJK52cNSB3ee+FZufR5CHKI0NEmIon2UitZlwOXj4JvnRY9Zy8dJ70T5gAh
 7On6TdXo0CZJOzl70L9ba/61d7spEAcIXoaExDh5PcPIXyvzaeeHmyDHOXffjLW6Ry9mA/7GIzx
 0Hazqe4vUKctu1EyLH17EibV0zVbkMnUFYRe0LvjnRZXKG+tOZQtH1+RT6XgA1h2bc5gfaL3Yrd
 Y9SJhMlD9LB7MN3LJ9dk9Jva3wOSLdqCjZD07no83jqsXMzsNwZeYeSG8/wCNtcdURIZfvyz2aG
 fC3LJn/fAWWAG4QF8cfXmROUBWrWAVDqlx/SsEL5PwSDuODkK+p6ZoBAgyk3hR8uJ7lm7DNPTxV
 n50Vs61aiv8FIufCBdA==
X-Proofpoint-GUID: q6ssz0L4fBKGT4MyB_RouyFrXyjVS3L_
X-Proofpoint-ORIG-GUID: q6ssz0L4fBKGT4MyB_RouyFrXyjVS3L_
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a19dd1b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_zWEW-5a1clIKPNZquMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Register AccelCPUClass::cpu_target_realize as x86_tcg_ops::cpu_realize.
> X86's ACCEL_CPU_NAME("tcg") TypeInfo is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/tcg/tcg-cpu.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
