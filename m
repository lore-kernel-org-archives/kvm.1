Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F59409DEA
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079517; cv=none; b=b2AyLtmbq4GkIjCrHG3xwIux+tmr28yV/PFiZSWB6tstKvcB8rAwiCzGdzcInekOwK9KV/IpujH5OBzcN+Wpnkuo/Q0ogFoFv9P/91kvkcT/5Blxm2PADXro8sUzfxOg3q+7PGf/Wonk/dAQrSRAo81mbVIPONgUfZB9EBybxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079517; c=relaxed/simple;
	bh=IHPrvYkdu5KhKtm1f4TEIcaZH1bTWWnyd6Tk939vDnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbKLuQCAFnwu41s7XGdn7rbg9aM7s4WWaH6lEVvx9ceI8yo/QsHaZ3uXa7vPRX2dko+17nZ6IoNIPJcNeP+sy39YxvbSLmDMwqvWd93TcMMI7/B/JstM8nCzaQYYcbbHhQY5FHaundxTIODvHVwUQwNOVjpVkOfpKwO1Stq99SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+8BjOW8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V6PZUqcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+8BjOW8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V6PZUqcx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2HwV198947
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fZdOUyDKUIE6R7VAX/E0rIaldfJFcrWncy/w5G9RArY=; b=j+8BjOW8TDT+9kHB
	z7zAmFlZjajL219JNx9CGoIHin3ciyxlyL9vmu1g/Z7+GRtJ3SuA26nUjLKog1ny
	fZ+ciiw4h62tiWBBlkjakIIdnj4Ty2c9PcxnJuEGyk+ijy2p4qK0tnBVArKlg9EX
	ehAFu06WjW6yhJCwvGldbgKT3VAadt9jtIlwyQqQP7/R5PFc7kyglC/qTOGD/XnI
	oosF03XAun+SPVnKuKwdR/qos5sz5M7rTWDkWCj32noEOGPM7aFgWew5GzVdgiAk
	9TaaR7h7mWurMBo4CVaR1QzzGHhn4hVrI9Wf3NCZ3BA8e7xBWZlvn1lxk3dLWsDR
	In+8Zw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnh5fb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:31:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304e7fbfaf5so4543786eec.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079515; x=1780684315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZdOUyDKUIE6R7VAX/E0rIaldfJFcrWncy/w5G9RArY=;
        b=V6PZUqcxvj8zE1ZB/xx8csmdnLFFgnWFVrdHjqSX4EtgjpTELSeDgAcqSjnqZh7qPS
         0rucGKiObd3jJPvOgeMh2B8g3rjgBaSZA8NnPP5ZIrczS3xxdHrs1QEOx6o+DVPPY4//
         xtwLSLwSr1DKj39Ke3FTQa7HNUzRzZ9zmmqJCGTGbICYdzO4Vazzg94qzf7svA7rGKan
         k5ybLg35CEFPBnf8TzUwhVxfYsSC87PjLvJWrcl+VQZfKYzSpoHYn8K0teQG7IJG98bt
         6s76Jx8HkNxgBdG6RV1DbDSXq/2mu9iJZBHSIPdyI/9+n67HHsRyEqnvbHtrGSltUoXO
         1MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079515; x=1780684315;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZdOUyDKUIE6R7VAX/E0rIaldfJFcrWncy/w5G9RArY=;
        b=hPCCafrm2wja7pqJ9N1Ri6GqlneNM4ClquayswwVz+g1UPEosqQyvglEJDzzumCeAi
         ZzRvY1U7VRddjeI9+tn56McRRGJHYPwAMtph+V7v+U29pm+m1mY/SYIeyCF685HCpT7q
         Q1RWQZ9yyzqzevLleF7RM5QxaLe+9dwTN/Wo3jIEmK74DxfaLpZQBR6VEnYxn22fWHBV
         OTFx44nV9oDCfnzcVNPUZpgu7sFAcELAOVeFqQBQV6ximHVX2R5LNQdnKLM/vOonHJDo
         5fU5BvH1PCee2MUueEULdaDPLZKLEjz7B8+a70N/mnT8bxuJcQA96B7mHJotmJIP7ani
         hEPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rZ1hYybUookNUKUuCxrBAQB4RenlsMwMPok08Tjn5NZ1CpoXmfpX52rWTwEy6y/9rs2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVD766Pci+/gwDvwtNnDkl5Q+Ckg6DvA1bkmdH2NHnyEETZbAY
	arCD+pAY2PNyyF6egQAW+crRKi3G9i/fcFqcV/4IenZkmZWEYWYS+66psO+ydYudwR1bXwCOcWW
	evZda5vyJBCU/N9CcZE6JChAqvA8rg+7+5ho3VmtltmGjjZpBgieOado=
X-Gm-Gg: Acq92OEPeqq4Z9Hrds0qAq3xZ/SQEHFtGhXfl4JJqX7hm4RaPXmUAFKUirWQ7Vz4vJv
	5K2ghPon2CUqjpiB+qhd6CNDlwdS1iCyYj3CUc9UfvK6hLPb1gH1yfFBwyCNvOOmRkijU5z/ppq
	xrMFvt3u1eec5NwGz3mPutl/vsCNvJ7KGD0hPeph494lK7h368pFJ2Z105jE1GmbS1naa6jZiu0
	IgPradu+Fr2+8iq9FHOEkxUvGc5tSpR1L0KdjfgyilG49L1IYQQZoStc5F8Wyvn9/0yOnQzdbuu
	TYehOzMxM3NjEc38pMEadmLe1zpiG/MqVkv8UADkSxecNDsHDdlhBBKkOEzjXgdcBhPgLhT9iYD
	rttviBkKdko8X5+A0QN2xyXwj3LXdN+7xDoC0W28xxoORHH0X+TQFPzRYkA9qeXaLLYthVzoGO1
	8FsDZedBTFlEAkohEaJh9wBZJM
X-Received: by 2002:a05:7300:80c6:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-304fa4c81bfmr524491eec.11.1780079514698;
        Fri, 29 May 2026 11:31:54 -0700 (PDT)
X-Received: by 2002:a05:7300:80c6:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-304fa4c81bfmr524459eec.11.1780079514192;
        Fri, 29 May 2026 11:31:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd6fdsm1766111eec.23.2026.05.29.11.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:31:53 -0700 (PDT)
Message-ID: <1468c9b8-44e5-4ec6-98d4-d846498720ce@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:31:51 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] accel/hvf: Remove need for
 AccelCPUClass::cpu_target_realize
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
 <20260529142434.87880-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NSBTYWx0ZWRfX4YRsjHZML5QQ
 Wjh/iIBinisT35p5Mm2OYU2reVdRWNeDFMu16rF7QWahSz7kakKR4CmGjH76K4PuIcVVPW4dWJA
 rkeH3pUOowW+zeMTWyzvJ6kCqd58kpTxM3Op6sXNc02kGWdUgI9Q5JN/HFziIGtLvyorgecwo9g
 ba0QxlCnK478jA5bGKvOZPg1yH+ZsOe5hrUaXwh5VItz+M7h1P9VvWveGbHPK924NlSypCDs1dT
 bnZA7BdPC00Cb+VZ8FZc7eZVsKDAMs59lHfQ9VnxcSGUvkhpwSP4G6q0x3X8leHCMsbFl+CZVE6
 Pc3tRoibaHiFUqMM36dFnmcVzswOPxVLTNeoKQte3PxPcQEPgxnTiyolmrUuGVKOfFUip6gZjJo
 Xbr8C1ozVSlTiCdYTN5hoD70cIXwUiTVM2OdRv5ePVRJwZMZdCKpjS4yyqoL8c3FxA4xIdZJs+i
 Yc5OP9uuNdnNG4iPxvg==
X-Proofpoint-GUID: iGvtJBZilFEqO9KNh9HEeD6u1sMPnhe0
X-Proofpoint-ORIG-GUID: iGvtJBZilFEqO9KNh9HEeD6u1sMPnhe0
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a19db9b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=S1AAxW5niS9ldcQwnDQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290185

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
> then ops->cpu_realize, which is set to hvf_arch_cpu_realize() on HVF.
> 
> We want to remove accel_cpu->cpu_target_realize, so have
> hvf_arch_cpu_realize directly call HVF AccelCPUClass target_realize
> handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/hvf/hvf-cpu.c | 6 +++++-
>  target/i386/hvf/hvf.c     | 5 -----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 

Need to update commit description with new cpu_realize name as Richard
noticed also.

Regards,
Pierrick
