Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D002DF13F
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058462; cv=none; b=JsdhgaNw+uMGhlT9NLhL9MQlsuPkdUc+YD0Qft29bDacDStk0PLObBIWu8+nJHkF7HpuOjWiUC8sXXPiOYLrLO7vGOOvFEi4AlnyEkyPCumbBWf7YxRVCPAgr/YGMdpLxw3YLMCfT15P2kTO0W2ZqQczYnFxx0XbuGd/UHdnAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058462; c=relaxed/simple;
	bh=ps18D72+cUtJ/Sqd1CjxNmDmxnYjepxVo6De9/QsaBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVyPZsl5mSX/CdKmKRgyh6O0E/+h8T0cSYh0CXk5uwvhf7lUGBJLdoK1PSLeU46xhaW5P5n6nh5V4QmFzCSR3h6VzHVJhodDy8WIcjlKvcscramfmjCtrgxuRO2aRZHArgkswSGV4Sx7qODAlC/HozGdsm3sVkJJhOgRS/RHsWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=STgY3bJU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kTMCPyRm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="STgY3bJU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kTMCPyRm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABW3D068512
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OgOEJl8eizJEofXwS5JCE1z8JiDMTg4lwZsWuuP6CPs=; b=STgY3bJUZrtEymNY
	kULfTXP9APDUiG5dbN+Rhtj7fr93q20/q0nRlienxZuLlRZPWcnmFpIAkD6zAwhN
	mGyI1IH39JCmcZcOWJ89MtMhfXUJMuYWxGPxTBIkrv5cI0GoJU9J4+xdlEcP15MG
	p+/kXH+uyDZZZTXNhfgCSrdvYmt1tLBdeyhfb4fvedNSvs/tiQ6VAD4ihTKdE4LD
	SoOKkHUoE8gzKjP26D1BpkEhw57XKBkNiymEG3oqF5FrcRw1iXZ0pRICZuxs731t
	XMbrbG8YyFkPF4a4EkQVFWD4D0z9jZ8CQLcWn6YfBhXF/vxSBaF/iFUe5tEncGhs
	aghuUg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5pta77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:07:40 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97bf8ed9594so494380241.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787058459; x=1787663259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OgOEJl8eizJEofXwS5JCE1z8JiDMTg4lwZsWuuP6CPs=;
        b=kTMCPyRmCthNaAbmRWfjTYArvESbtCQpZt4kxL+EjF+yNnxpgGYVxt2XcePJMyk34X
         zFayCS3Gz4Bia4w0IPmPcZL+Eg9IVyN0AR1qWCYZJdlAXY3Z8/AUClekUoGET5rBcP4n
         x3miyRwP4uuFoYcBOX9A8L1Yhp0Wl2YKGFAKdFDK53ZoJ7FN53K8MvX1xiOSGT2jh1oz
         pzQ3EkTdH4yMzQzdSD4GXpx9tDzug/C3TN/XoSwDc18c97gJdNK/IdUvCKjzyR8rGCJN
         r4S7pzyuyvRLYVNP2Tc2+sIZJ3TXg8hoGmd5M3COzHaOkmC0dWIagiSJ6F8PqrGfBsH7
         enpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058459; x=1787663259;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OgOEJl8eizJEofXwS5JCE1z8JiDMTg4lwZsWuuP6CPs=;
        b=cWaF16Mfp0OFQIPez5EL1nOqAKfkwuNg7RD4RSjvMvZVOBgEmGY+Dh1qKE8MJfql0O
         xzFj0rOHvlpiHeZK2GAWwmS4s7Z0+Mpag+XsELg1WglMeGkUu9Gmb16qvKFoYAyJlFCL
         Ay3BRPoN3SVQ7K40ZmBgLfr9tpsvwODYuJzwHrL9NXys9AWehEefnwP6R8zOie3SW7u6
         EJZ2HCmkV54z8rVFivjT5dME2mT+dYRyEkNGAPqBTZQXNwTapScl7Pv+VNk23ZprFvWf
         uHWbPamNWFE+5DRDLaNBPTTRtdRMkSyvXPE0YGcW0RjCb4Wm95B//Sq6KofX2nqdT0ko
         y8lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpoy7fXrDvY/incIGnWFdf602XpI79kZXwXKThj1snCZqR0432KvCNHZmzQrvPomgbeYm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSO+GRvYNGna9jhOvLRYtA08QQsFsEKYCkdnCdtgc60GzoZyV
	qLcRdKNt0mKHVKSwRmI+DDb7tPAk4l1sVOZKxWcrCi6ol8lM9B6DrOI2t+KhGnsw6ViOvDNm34h
	4S0Vcezlz3Ffla9gE/91er6D/jHe6eRymE7cytxhhYyy4g5V4sQgKDwQ=
X-Gm-Gg: AR+sD12QGuBzrNgcKUYG2dxiV9zEk9PJIIWNaqgTT0k39P0BjrOn2ON96rrHDaz2cTO
	Cq8E6D4EoyR2/h4wkepQIITfmKK5dlFghRDXDFo7L7y4vpREI+y7TzOtkX6Essz90XgkvLpxrsM
	Mhv1mXEaxleVILXXmMblw4oPWsucUDYEKCEsLdp6sAML0t8V1R2gIhZc8h6ZhL+qopib4xV2lGj
	kyjysrSQ3hNtFP1ykq97/7cpcANx5sL+im1k0z98FnYsnhJ8WqeVisUhkd9u+39bwpA5gKEbTFi
	HYXaU3tYjHcpq7Jk1eXGqs2gREKN0L2goa+A2iqbJJC/gvqU70RnJi5oOyG1WJ8WIVcMlXE3+7u
	Hc2Qcf1AYlW8l3GT338Il78Zdl51PUB/JZ8M=
X-Received: by 2002:a05:6102:3fa8:b0:76d:154:7f42 with SMTP id ada2fe7eead31-76f2b2fa5dfmr5922215137.5.1787058459585;
        Tue, 18 Aug 2026 06:07:39 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa8:b0:76d:154:7f42 with SMTP id ada2fe7eead31-76f2b2fa5dfmr5922177137.5.1787058459089;
        Tue, 18 Aug 2026 06:07:39 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b203cfsm296961215e9.3.2026.08.18.06.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:07:38 -0700 (PDT)
Message-ID: <b268acef-e255-4c13-8db8-09f2974e7218@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:07:37 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] accel/kvm: Consistently return CPU halt state from
 process_async_events
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Alexander Graf
 <agraf@csgraf.de>, qemu-ppc@nongnu.org,
        qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
        Magnus Kulke <magnuskulke@linux.microsoft.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu@processmission.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-12-philmd@oss.qualcomm.com>
 <55cc8357-daeb-4315-9f3a-8be7a59c355b@redhat.com>
 <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
 <CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a84591c cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KFLP8JxMXue_9hLRhRUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3yJOUMhMuA3Z9KCUa1QaobMj1DRCEGOV
X-Proofpoint-ORIG-GUID: 3yJOUMhMuA3Z9KCUa1QaobMj1DRCEGOV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5NyBTYWx0ZWRfX11yLkN1H+RHo
 gaHo7EnFhWA1c4fO+sr13k0SVom4CDtUqehffsX3EAjoQgk++kHMptvIldzlSHE/BDLPhALdnRB
 xmpt5nFfC8CkYyz7dlcwJfSR92IodLdOW/IGmJSfdgq1QLTNlDhnUhun9sIGcxRcgcxDFfOqDH7
 5eldGQjuaTCcSVTVTu4Grv7IVMKsDgGDMJZf3ornoNvdz3HfCJvO4Nw71Lbp/jbZs8yhrgFwl6w
 BDu7v4VEQdsa73klYMQv6IEn8S0Hz3OeQZJl9rF6epK0mU8qTL9YAn2jApV7mJqsVTNjH3NqGRO
 PmCD1AbJDDdvlq4skpInUV8oXHMq8MOSgcYTMmapIKz3vP16N99tRlPO2blb8oq8DzPULm/npX0
 v/hccoredv8wYHBevM2HEcG5uokqGy/rbLrfV1lSMeayORpw/GoEbCsM6SyPaDakMqnPrQdgKAT
 L0kP3Lp+du/DVPJ0RuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5NyBTYWx0ZWRfX2dxRPgMnR89G
 dXGr6i+TYximTQay89ijQ0XYTtu3gbeA6aZulSDRj9/MYNqrkIkNj9WTiuwmS+QdwFUt2sbmKkr
 bwlz3EAb6ogrDdScbb/uewzBBF+VoVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180097

On 18/8/26 12:30, Paolo Bonzini wrote:
> On Tue, Aug 18, 2026 at 11:24 AM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>> Your patch is correct because, even if cpu_thread_is_idle() sees cpu-
>>>   >halted == false, the flag could become true during
>>> process_queued_cpu_work() because it releases the BQL.
>>>
>>> However, I think the better fix is to remove the return code, and check
>>> cpu->halted in kvm_cpu_exec().
>>
>> Looking at it, even better would be to move *process_async_events()
>> from inner loop to outer loop for all accelerators. For HW accels it
>> seems quite trivial; for TCG I need to figure if it is safe to call
>> icount_prepare_for_run() with the BQL taken, due to the replay_mutex
>> uses -- here the win is cpu_handle_halt() ends restricted to system
>> and we can remove the odd EXCP_HLT handling in user emulation.
> 
> Makes sense, but probably it would be a series of its own. :)

Good, right.

(FYI the motivation behind these cleanups and documentation is to
get hybrid-acceleration, so a consistent vcpu_thread_routine between
accelerators:
https://lore.kernel.org/qemu-devel/20250620172751.94231-10-philmd@linaro.org/)
