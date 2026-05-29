Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA143909BC
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079407; cv=none; b=LRjhqjRPrVzVeBMoQR5dkX1ljlO5QDkayye9j5ZjIvsb7a0SdGAQTKsBY84lCDI8epo2LnL5BG5THiAV1mWVTyU8voO8Keg532ROEnncRiaFbxkdD8VoscccOV8iYBX735WO3bAvlQLJ5jYNcaeF2kB66g5LceVshH8MYf4ZO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079407; c=relaxed/simple;
	bh=vMbERZW0AD7Lrx9oosjw1KG9NK5+8ucwgL9Jy+ZuDYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKFzKlbUFte4oL12+QCuS0b3MIAeiXbWPlErXOEOYAd0bk5aBd8+eAiSDbZLgUdHSlBEw2VW7jp1bM+63f89DgGuuGf5Pd3OSwlMeYTBmxNY7UiBPYH6ZqT3Ol/z0FRSU/5XlOnOqAecMxlRO6mEd6to3vD4aAmu9hJ5qm9SDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCL2LGLz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VDcp9VjK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCL2LGLz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VDcp9VjK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2IoB589656
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BASaeUV+sd6PCcE49dvGbjsSrGUAqcny0XRVjurx+GA=; b=UCL2LGLzVgojOtD1
	4RJUt1PKZtHOAIy8pTJllBQuCamUyxVpO+cy5eqqd/vWp/TNs26mnyQj7OZ4Tadg
	yC0G1ypIeDwsm/MNshuE45dX4uJMzLLcKsNUaPYyAPJdMGMaqgYVUc5+ayCRFCr2
	HxUJSFUcZb3tMuLVR/9uQ+uBapOUupHnKkWDqI/ye5wjrSk6ZceuilgZoxeM1Xk3
	+2Lehj9diRrPe8F9ljJ56P9urb1pHbLiQD9EftRUAopZ4wubmxVpu/2z0ru2JZHz
	2OtyhgXG0pGjaU2YyQbCtJgcbC0FvFgkkcIPZndDyFBMU6kNqS5L9oxD4mzj8N3Q
	7yfesw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rcjh68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:30:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304ea1eea05so2845248eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079405; x=1780684205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BASaeUV+sd6PCcE49dvGbjsSrGUAqcny0XRVjurx+GA=;
        b=VDcp9VjKcCwWTIeiv3W+JMfZQLZnmsBHSqeTZCBOjov+p3F3bplV5sUww9K2r7bn0k
         /H9HDIwfUd+Vb7Pyg/kaA+BpfY/IZWCoMg7D4srjfr2aWdSaNMYzpV/b7wQoOEtcPCnh
         riP2Zp1syWpOGn6OkPuE8DPAAobFTbDKO7iZCnOf3Dat+itHweY8VLgTUz+4QX95mGaB
         3SQXUyREMbO+mQgffdH+tPqPvP+6aIAIdpGgAkuDuTvQirdnVwR/8CwSQd5p2vZ70I8x
         qWbnbDFb1dD6g2g+S3rzA84jS0gEu06PtArAIZDVllwIplNOD9YEgATbBjL0/McoxDIw
         tebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079405; x=1780684205;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BASaeUV+sd6PCcE49dvGbjsSrGUAqcny0XRVjurx+GA=;
        b=ghiRwf+8CJn9vfXagXb5Qpjs/Dfe2EuMo3AbuksOPYk89kBR5AZtVRag0EH7bXxLps
         0qWJ90yS/5JX6a2D1aepKVG6xlur4cyirt28Q+QyN+0uXQQjBzYiaTGF2YUgqAUFySDP
         WqQPAUV8ZrSM4rodpISY0yJJQ9kyBFd6jUJBw5g/3PjMNNbB1G5XFu+YZ0yA5FwnjbHx
         ifoGLtK6wTWIXpJQUJUDUciGzvifoz0TRTulljUbgEwDaiA/TjEWKn5yAM4sZaX+tPBy
         3CWf2pyGhKsuUXhuxInGuJq5k/Frw4rjOXVbpNckBHUB6VefuYWtaEzHkhFjV0VT+NOY
         Claw==
X-Forwarded-Encrypted: i=1; AFNElJ+xryoNecKuSvZGShjoUfW3qMZYtmG6nM8JvLJGS7IAwipd40Eje7udRaNI8U9t/ArqAu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oy/iC1+Py9wXpT7We1zLUHv4Lxnes2f7AypdwCdAAOYWW0Nh
	uQFUf4GUptpU0u/AlT4NoWDk/eUkPBOPlIhYfAtq6Vo70lEWzLxI+pZoEtjrl9xX05SVyxuy9eI
	wLmDfykLqctm36LmpXPCdckPVpt6TuL1eFDXplpZG9eYq/zGGCd4YH78=
X-Gm-Gg: Acq92OH8EUdYf/YAI6G8q8ztKkMnR64Z2jbxbo/lgEu+kSGdG6RaPeu39G1CNGOLnlV
	jkYcFMNC+1d77zXWwfcEcuLG/rSuVrlH3pjcCjEyT7A4hAcu9cilmv8Y/2omhQQxvINUbktuhB4
	MQfMnYgW8GcdvgZISp/iIYDMuZOGkfA4TroNSRJ54lVNbIVusAbgwq2ZY/gLlxRuSmX9NNir62U
	Nzoy3GHStW3yRYasN2K0lNUNtGtPlwRbOikgujqzx9u/uhlXUoujGG5iyXa/LtAFBIaZEP5/dwb
	xUDlcuJ9/07N990RezPqyBu8I5G/4z7vX6THuWIDK/V3qtzJC6tEhWSfm3t4Peinb09Z0mB/AsK
	4WVVAla+EfZjbUAxcjA2HeCRr4ihgSdKRjg2G64cWPhgEI2AXwHK8mAuOkfWq39dSc1009nVI95
	pKrJSOtf2Tzhh4OkKnuy/rXJGU
X-Received: by 2002:a05:7300:2201:b0:304:e7ca:4b62 with SMTP id 5a478bee46e88-304fa5293a8mr473961eec.3.1780079404444;
        Fri, 29 May 2026 11:30:04 -0700 (PDT)
X-Received: by 2002:a05:7300:2201:b0:304:e7ca:4b62 with SMTP id 5a478bee46e88-304fa5293a8mr473923eec.3.1780079403901;
        Fri, 29 May 2026 11:30:03 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm2047126eec.9.2026.05.29.11.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:30:03 -0700 (PDT)
Message-ID: <305c1c53-1a3a-4413-a365-11792b5155b1@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:30:01 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] target/loongarch: Remove unused
 'accel/accel-cpu-target.h' header
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
 <20260529142434.87880-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IEvUSf1JSUwca_g7Ye4z7zayhxjW1SJO
X-Proofpoint-ORIG-GUID: IEvUSf1JSUwca_g7Ye4z7zayhxjW1SJO
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a19db2d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=oVxXrErn6vik3ZSoqHYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NCBTYWx0ZWRfXywsEhoBvv3BU
 yxG9GOMv1j6PhkSNhv4JbSALLX9gW3e3Si83jBZi1eYscU0t1k9CqNzSmgEIsHHoTPDeOizxW2b
 9ylRE7Vx7au8jmnUsdGHobtS22Ir3eAIfr2RlJJ0IGVqzyhhzJTSEYFbMk9hbKxe5UUw/DeAvvG
 Rp+9s0o668Rz5mcE9I465meXYNYowWGM8BA4nVOODTmGHeWrHRBEB1GG+ulhfcFLhJZqkXiE9MK
 Ur+TXXmFvM7hL9+sonJLSwGsB6ezsaCRu9j0Ja9qw6hnqh4NH2llcFPmexB4B+C9EmOSaB71ToF
 6/+9dU+qEhdnJ2r3/a3ze6MJ5o9BsGhd2j39wAspzixlKVapKUEBpb4hCVo7tG9ku4ukxU9NsOg
 3XFg7w9OWmVvAjOkV4SrDPRHBn7/JvBzJbJVwMP5AQRjVoQXo9vALZWmhIhdNhah6YDVF4bcGxc
 tfs9KOs5ywYcfB7+sZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290184

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> "accel/accel-cpu-target.h" is to register accelerator target
> specific hooks via TypeInfo::ACCEL_CPU_NAME(), which LoongArch
> TCG frontend does not. Remove as unused header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/loongarch/tcg/tcg_cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
