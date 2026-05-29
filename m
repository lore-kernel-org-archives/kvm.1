Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F742EEAC
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079776; cv=none; b=OGFEZhRpUZC2vyT7Fus1BaBexaHIg01YOL25RiATG4gh9O6+F7Y3+GW4Htbc22lQNHXRJaLMMbflyRZEAUWrexPhXZqkd/5DiyXnJe4+F+uIgxLNMfw8T1zzAPAKuhNHhhNEl3YII4qZ9zXwhzPySdGo026GxKuiirAUyTmx6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079776; c=relaxed/simple;
	bh=chX+Z1DMlWh/pzlN2TRT1KqDSCC+ohBtMbGwSch2Rco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKCM1YIDpasb+p/zz+4Jvue/vxwNCKAvjk8DHe0XocIZrGQRzY29Cm5bK2awcQ+pKuJbgFvLqZkXBJH8pr1Sx0mYtwLR75vRWeEDS2AuwUpuNx6EEESMpBCQ453KBecJNHNIFlnaNvhHKZiGc21q4OzgRXVRr28K1U1LkK3uy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CTxpL2d7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FSLYQywj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CTxpL2d7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSLYQywj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2Qs1313038
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8G1AA+C5l7p2QDuZF+PCm2sMqEcpPOuS/PaVjzqSEX8=; b=CTxpL2d7y6Ocz8mH
	HQRbe8DMj+GapAuyHenAR7kh50OG5DZ9vwlP0gQ4x6jkyks843d3f9QVUcSe4r4j
	qKWbdzXB8bNkEvKV6Yh92DNfQlA5+swlqBG5MVoEW/BMyVLKok4g+bKV2C5g7563
	4HAyLgPoC4bEuxPVmy7evW5dReNLqxj8t6XlLFGgShd8UWtAUi4/1SEF+0isohG0
	3adI42c3Jo7IMKRMa/Oh1rswXLE4I0DrDr6jqDi0aCHyMpX/BF8zNFx5151bLgq1
	v/5TYosztN830/fGAN19I3tci1dFyw9X5T1I9lja/oKLPkQwGQS0FfSEeSGYi2WA
	4hn7Vw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m56h6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304d2447962so1346073eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079770; x=1780684570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8G1AA+C5l7p2QDuZF+PCm2sMqEcpPOuS/PaVjzqSEX8=;
        b=FSLYQywjnhKrdLNsdsgcPYhOukiWKdjfbnKVcEu3fGR3zYmAUOGAUcN/pHuHfk+cIT
         mgl6Ry2EJ+dkHz4L9Khr671G+vMWJg6fJMbQ5ovCAariErwdyLQcRWob0T5Mn3sUY8Ss
         dleftU6lCRIRYXUcPMUsYiQeHv0pyhh3/B9PWCDaKJDXeRhd5N/qUaTGR5133OLsc1T8
         iqeg1b7IOaGrTIZzxNMHaf5Xw1PZoMT1Rksmsn6cvAV4Luw6A3e6X8SIdvnpMAb4mjek
         cjDXtc89zQYLJO7/mb9dYBXf7Vj+Fy0cbTBHDldnZaTgkOc1QHyvHRUXf8A0CvZPiemg
         w5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079770; x=1780684570;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8G1AA+C5l7p2QDuZF+PCm2sMqEcpPOuS/PaVjzqSEX8=;
        b=F6J692wUyH1rSRdRxd8R+chaqcAIL8y6/0DOboj+E6WBf2ENr2NqizxmbZI1EwHeXK
         rTJbZ3nYROXZacrQMrjYA2Fs+urfIdvrtycmd+r0ey1g6twf6BthGSPbv2YxwGmu2ekC
         8dXXRH6CjgS5cKYKLcTyapyqPDku8aA4Dq47D2GjEb9EIxhls/LQhzZ8xsvvyixPD6r1
         Zr8XbaTnDsHM2TDlf9IJahmqFxjCSl5Cze/agiHPg/+w0VyPQDTj8bG9qBeiaWrIkYNx
         5mlQXB6npiZXV/S3MpVMB2clIhj3nINjbD5wj7ZwXwLpukDoWqg8hCZpHVHvvJkqhmpl
         90WQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xW1elUQaocb+Sershi3HvSF8vb9zhT5JdUd9n5fMcUklqqNw2U8Pj+N88reRGNMs3v38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGX1XOwsHlr1DfgAfkllFC00TMC/VcLQ6NEMPzt+Pl3H/R/6uC
	fyszU9GaABNDQ2m/Hq+/PD4CvuVKXv11O6qPM5bBQTbljYwc6dyEKWhU15RLbb1Za1vbuuc34FH
	MS/5EGmO3kPtkfoPKiHYWejX5j9whiyKvW69G9JQRcq+u4ldSYxl8vWo=
X-Gm-Gg: Acq92OG8ZDcPfT7iqIiCCkipchiArL1sQIHP136D+QRLVGk1hXwZDusw0iw6xCr8GZG
	PxzguCt3wQflkEVTAwcC5yU5lKE5n+oAWsdmSl87E2CCGYA3oY0xm+7dlVyTDx36FstqxNYDFO1
	pwbklrlDDRIMiDK/TPgX+ndIPgrY57t20jqaOv4us3RLfyAYPXb66BBhhon2Z13z2yQ/s/bk1ru
	egsJT44KePrDQawc+AkQ4/IQUtSE6YJjmy4LL/2kK45xbFuk34earBEvoIZW/a2TL3LTf6j2F/8
	+3kwVcxQ45kgRfjil+oxwrlsGBLhU4HkCxvHRi8CSwZNLdeFTknKvFRe9kW0u9ATrJo9pQH1rHr
	yWi7ushisBA4I+5WfH+eDiWvJGoQbmd7ftamFA6FWu+7RPuhU0pYASN9/Bd62XJTQ1zxo6dwoPc
	WVUOTDV5AcRT6S43lbHk4fpVTx
X-Received: by 2002:a05:7022:4384:b0:12c:aae:7b43 with SMTP id a92af1059eb24-137aeb9d821mr1740960c88.24.1780079769805;
        Fri, 29 May 2026 11:36:09 -0700 (PDT)
X-Received: by 2002:a05:7022:4384:b0:12c:aae:7b43 with SMTP id a92af1059eb24-137aeb9d821mr1740923c88.24.1780079769224;
        Fri, 29 May 2026 11:36:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f316sm2009480eec.19.2026.05.29.11.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:36:08 -0700 (PDT)
Message-ID: <5dd15866-c5d4-4a2a-b126-3f97700459d5@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:36:06 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] accel/whpx: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
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
 <20260529142434.87880-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NSBTYWx0ZWRfX2YHbyGw5m3DI
 eZTvYEtXtWuMqYjDcstxrRW/+YKs9aCh4GA5jpZsUfSb50xwbN0F7gG18X1sbvzhOfRvXn9D1GO
 5+WIn4VIiEPIjF/+QkW7hBEqblbHhQnYqBDwtjebms2RQ3iETusflc4DJjZE26hJJ+ws/CnGLDD
 k0em+/+TBKvioAM8jvjS2iBqsKrODcQHJXbZH36FDFRopVP6Nrn3ZW97eFEp/Qz2xXo29cXBj6Z
 0HWGIZHQyNYzbtIRQ89D3FRgQGcrZ+SWma1fVgFF24snBdqbaW/9GmujkhW7Th2L+yTMNNtEgRY
 Lg35wE/E7fFbOXBB6WTFVpGmjcvnTEFUrzYbXCmPZzJg2caQ9I5JtcKld32TOdXV3j6484vP+ZP
 BGfyjn5veONHxRiLO9qOcvqUP0dzZg8VYs6MzkE7TKMPqHqjnUVJdGItvvw60h5mHcknnr0X8Is
 u6wPQMIa1ubqo86potg==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a19dc9a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-KmILrV31RuDUJHzopoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dDolFlqcJhKK41OAh4ENMSj2XzuzMjU2
X-Proofpoint-ORIG-GUID: dDolFlqcJhKK41OAh4ENMSj2XzuzMjU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290185

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Register the new AccelOpsClass::cpu_instance_init hook.
> 
> ACCEL_CPU_NAME("whpx") TypeInfo is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/whpx/whpx-accel-ops.c |  2 ++
>  accel/whpx/whpx-common.c    | 17 -----------------
>  target/arm/whpx/whpx-all.c  |  1 -
>  target/i386/whpx/whpx-all.c |  1 -
>  4 files changed, 2 insertions(+), 19 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
