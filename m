Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C842DFEB
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079847; cv=none; b=jDHL1DvJ3gfWfRi3dnF2hiP6QkMKyr+hEhZ6HPEXJ/OeeWBru5Oyue3V8qECr7JUQNXg1OcVJlB6ouihMBOgeBjuHOw4JpkOjoTn//Z5XPM+iD90Y/7IG3tCK0gDvVLlt1BOG+K0jfLQsSpI624ikYl0h7zGOnShDFrL1W01zVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079847; c=relaxed/simple;
	bh=IN3wr8L6vimuEGUHbBPNECPQxGleba3kG2cOUGT/muo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm7W0rXEkzRBqyfSQE+oULwfioQQ5IgeqV7+HCQ6vJIE8lFKueeA9DvBCytfXJGndO+yz4oeolqUYa6w3nM/J4nXZQb0ExeAz5yNbLIjxbu7D002DWjm30ASIEfASu5jaSg+fYVVLthYH0pKWyLNq7fR0c+uibibcsBMkF45pU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nSHaOJ2I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sl+SxgRa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSHaOJ2I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sl+SxgRa"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2IAv3915226
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vXI6UfcbTRBwXOG1ckDEU3+hF/6cF/O5Mft8nRuMTQk=; b=nSHaOJ2I6+dsVc0h
	ShoSNqz8UpAB2l8afXCIMdTEBQpMDKSmdxDsJBDhLbzWBwkTzzqnO+iNZiotZr2y
	F6noYLScfLfHL2/wmiE0NIgP4NuwCrj4ejxKbMImeGXxXgdJTpXVFVZfQ/bdI3BM
	RUDrptD0xyimFKaiItLr1uXhK8IUzObm/dqYc6rk9sc7Hy7hCkm9EMsb7fx5aXEP
	S64PDCxAxnvu9my5AvassB+AasZE8AYYZ9cFqIFSDdHhM03JbMAvw3qlSflciMQr
	FBgr5H1+HEGOWfFp19E5PmLmMC5gKnD0lCFEfeoK/tPPci51wNASG8e3vKk0ahli
	C8mM8Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef015cn1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:37:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304f23c55b2so861491eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079842; x=1780684642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXI6UfcbTRBwXOG1ckDEU3+hF/6cF/O5Mft8nRuMTQk=;
        b=Sl+SxgRa1H2DEuhs4f9a6I4pBvrF88oz/iPqOnNa3aPBgd6P1doE4BtxSC+3FwGMNN
         GVwsWAYKgRNhRcuuMggM+zrRiGUEpzDb2ElPnnYOjJ50PHuxs78/KzuwdPdUdXht/6lY
         9eCLwhoWXl3N5q1/iXP26lb43VldCalPs7OCyoDIQNYKTFIOCglELVgyiKdgPsbIW/sb
         u3YYtgzU0YxTOdlKNma4EbUyfoxiHfgUGZzaXTZ9Dxj29ulTXorsiddJP9dnHIlAPuYv
         Q5uCn9f64EPkcJSi/0rSlW6uaq16FFFkdU9o/2QxOvJmhiCJLUYZ4O8gmX204YD6bBtr
         VZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079842; x=1780684642;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXI6UfcbTRBwXOG1ckDEU3+hF/6cF/O5Mft8nRuMTQk=;
        b=aeX+Avs6RR5cfNkalovXgFtmBEmO+/l8IxWN8iap8IjniJkFtoQhbpKuOiDL/ZoV1w
         BOhLZ9e1A4+QH8pjCO/zA/oWI+ehPD4bQ/pP7GT4lOju9niYw00PUVU+dyByoUV7Q+YL
         mdOgtJu82UcTEfH5URE7hunB5XUN+5qDmRpvkmzCW97DAm05pPG+j9Gv6sfeZ/OSxSiO
         jetdLmY+p4m9YZ+mFBdVzGJPryYb3Crhm/g24ldvlchNa7lOp56J3kYEESjyE3wtbt1J
         UnDxMvNlP1nQquPxJywrvAqKv8BgM0Zc9yv85XcibTCsS/QX6mnyFtyOZiGxKJZXE8Lw
         B7tQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mHet5mjLPeA8d7B0jFMADsjonNWbTZ123SQ4lyWiVVTqWTjyx+m3FAkpnBOzHVEC4FGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8T/MQV4weSnPubHKKH2t4RyNVACXxPLJaQWeyj8PhJHAeR+V2
	m8OlLiU7vRedpZAtqKY+KDA/LDELjP167Lr87k3IutXWGfttlgv0ZwXCDxpTdKLrGzUS0Dc7sVD
	AGE1lq33/vKcmIGDqfPJjIWWb/7srpxDo17iZth2zSbjKqfB6Y+nTF6Q=
X-Gm-Gg: Acq92OFVXMwky2nWZg5knAe+ZGV5mY00OwgRSgUR3EhsK00SIb4e2FRfhH5S5HLVU1b
	/jiX7NPVFoBsQvk2Fus1LBsMB74zF3gQOUG1XMAhT9HVwvPz23fniZtFpMbxpYQiTid9whCc14T
	6qPsviMH/WFVmoPcYolLD8spW/CCG8g6PXWKwlcz7xTIeuperscBX/Six/+ANCIr583Zb6xe6Jz
	2xdzYDekjmTjXisSOaeEiTKpTcfqnoZ5mPkChBzS59G6ouIAYYNN+LBhVL3jeT6zqPOapj3dq/j
	FQrRvscYxo/0puCsVMg4phT0ZbsFtiIo3a4b70QzljGQ8X7m1rVpc4KABU5hZCYTYMRnBGPxSgM
	8IA7bGwAKBb8wlOTrHH+AsXKkyvFLWQbQ+R1OJ4BsVG5ERTCWRD5dbkJ0dmFgqU3Bmg3tdNUzNk
	pGnAfB3ei9mrnGiXHL+B2t1bfS
X-Received: by 2002:a05:7301:2926:b0:2da:2ec2:64fe with SMTP id 5a478bee46e88-304fa67ab4amr482929eec.24.1780079841816;
        Fri, 29 May 2026 11:37:21 -0700 (PDT)
X-Received: by 2002:a05:7301:2926:b0:2da:2ec2:64fe with SMTP id 5a478bee46e88-304fa67ab4amr482915eec.24.1780079841314;
        Fri, 29 May 2026 11:37:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c154fsm1873641eec.3.2026.05.29.11.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:37:20 -0700 (PDT)
Message-ID: <3e9be52f-58ee-4751-9d17-9de23b930283@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:37:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] accel/kvm: Convert AccelCPUClass ->
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
 <20260529142434.87880-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NusCdmtM6wFce_Jv5V21TpPXU9MuPizR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfXzEzTDAozqLPh
 HOhxEIreYCRh8ViqP99QnSFybYig+0J2RjdLRU5MbL0kiapzIwOTDAXYW/2+kk+lM5YEx1sljB7
 kuzGQi9qCgCLf6iJwAgdVf6mLkg4gkVOp/Z01KoVOp4zmVeGqpqBqPvf/7j/yRWPe8bKrZUoKLu
 Crazc/+f7Wm8RkkFLEM4FTjXmyRYJyyV+0/Sn2aN50r0IWAtcjxm3B1h34XF84ykuLg1dyfWFKh
 asUhOvGcFRyYIF+otGtOXxi1c1Lo1iqM4H4fJVEygphMwGisWg3O41K2Ggr21Q3mirZzFVGY3ri
 XiezhmAnlkydqypoMUpaiF7/Iugm7AvHYsY4OLAIAYQg4D9eVbbBD9RRij0j5QOp7lC24Sod2nk
 Qls326VjKRLnBRzpFBoDLWIqVI66XbpPU6x7RuOm12UkWwrQLndXpYzGrZu3Vi5rH+BvkT1kZ52
 aJxxx7Apc4/A2hLm9tg==
X-Authority-Analysis: v=2.4 cv=DIG/JSNb c=1 sm=1 tr=0 ts=6a19dce2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QHjEocJm63N4ICSh5zwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NusCdmtM6wFce_Jv5V21TpPXU9MuPizR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Expose kvm_arch_cpu_instance_init() and register it as generic
> AccelOpsClass::cpu_instance_init hook.
> 
> Both X86 / RISCV's ACCEL_CPU_NAME("kvm") TypeInfo are now empty,
> remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/system/kvm.h       |  1 +
>  accel/kvm/kvm-accel-ops.c  |  1 +
>  target/i386/kvm/kvm-cpu.c  | 22 +---------------------
>  target/riscv/kvm/kvm-cpu.c | 23 +----------------------
>  4 files changed, 4 insertions(+), 43 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
