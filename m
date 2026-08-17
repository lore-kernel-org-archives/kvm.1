Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D204477F1
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981562; cv=none; b=gxK4FjRkeovVOgVdwOBvxdwTf1mnUMPsbiJt/6afXAM5/uDXdCfwaqSQAD92MTCIJwraVxxotmMvP/GFseXNwUZKR42S/TCVwapJTCG4qSZBGU66atS9nl5V0ySZtE0MOrQgphUKPGm4Jotj3XBrqKcDbyPyseH5ti+UuMS49tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981562; c=relaxed/simple;
	bh=H39pSW3wbyNpUTB6edgbjtOHjKbTFgYYeEd7Sb0CKqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3zo/dPQxKOcetwFpiZcEcgSMtDP22NTCsvUJuIP1f3qqQTQrw1GdA7AY8jZF1MJyRB9c5WfFNQD1Of06mBZ/k71g8AzaEB1P419Ke/GFDCjaqjzXwfI2d3weqJnZ8Yf2dDzEScJhMe5riWWTmVh/3bYcfjMERV+iZFwtks4Phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXUq5vwN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzXzL+Xs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXUq5vwN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzXzL+Xs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYb243790476
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 15:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJomhp4E4/0nAHnYLCMRRJVWnnFs3olnM/6sAXdkmJE=; b=pXUq5vwNeT8UfXSD
	T3K3yFySmigWkvf1EeR40akxCNMUfY9WLs363VxnCtA9fp7uFnEs8Ae5iFi754yx
	FAIFeTzoI5IZsKuV1VR7rgKhGfDIk/KrdIy+eG59TTnMg/rXN+4YlI1Avkq92je/
	L9vPrp4p/RgHsRgd2aFVMlDU6+hhhBAUrKPi332a8gmMhn3/H158qaMS73kd0r4U
	QGCF2U7rAgRkB3wIyXms6HsrNqN6Zvrya9QGmvLPGIlv+xvBLmpdWu2tJa1rEoFU
	4xxbZa0layysLXr5Tsr3fVe7LgZeZ8lXr0SDzQUKMkmRcXVSwEe4rfUhg5W6uN5L
	hBKa1w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y7kskxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 15:45:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8efad04d884so65874526d6.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786981554; x=1787586354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJomhp4E4/0nAHnYLCMRRJVWnnFs3olnM/6sAXdkmJE=;
        b=DzXzL+XsNi2DCQKKp6R4+TXGKJ/uTZsNPyPfboSKQXSzexbSEUXohp/b7dd1hEoruT
         c0K2nHZ4n569EJMZM99LrSmVgcs5WM1xmxGqNcpQ4jW+6jXN89uCtsxUyC977H91+sEP
         LfKTm8Mks/8h2WnSipvLiV10eLL/tXGtKpK6ytO1y0owGYJbMc3HOxHyq5vQbW+2m5/i
         Xacn9vPP8YFmeVgh6besHPV59fFmPwWlU/jdep71kZ2Pz/8N/Gk6caJUSW14X9wyUuIP
         wtEKOfJLG8vam2XjLHSllp2l6VNxAFPLOmFNeRcski5BBHmVSCN/rwRmP65RQnEScFQU
         Szaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786981554; x=1787586354;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJomhp4E4/0nAHnYLCMRRJVWnnFs3olnM/6sAXdkmJE=;
        b=BDCNc2SNLdL8rw5wVms3tLDJaCIFy2gyBBZsDEHRRGMkzy4sTnJI+8b/WV+YY2vfua
         Cx14JlZoCHRaOcUrv0lcTVIi/Z2/J576K2Z2H3+xvBWdMz3EPLmbdTZNGG00agwt7Hee
         tYJH9sfdNdrOiCWbobU2rVvvuezn4PIREhEHCbYNB7r7uzXHf8pQ2/sJPb3Qf6/hkO33
         rT2yD/Z/v1yGhOl4aYIaaMcajhB/sd8pOFSbWdyn17UUG4k+hcJ9prX6gdYMN6YOsH07
         1fCdiqdXubNmvm2To6M1Ziuffvr1haVbQhdfKATCUZJKO53ZWN0rJMxR543a5shENyPT
         Jx8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpywKhWBr6gHGOWw6skL/pN1ynMz8c4PZPZ3JwLPi93drOZmxLzLEf8Jqjif7t6vaZdOj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGpWXlU7ljqc0+kmyLpKdiOBaYRnMjR1f6nIdk1lpuiTSxsDF
	sDltlJkSyZ9+XGi0CvguVf6+FCqEuxyxJPfodSx0P9kwjHHxN4Bd4n9fSPL70GIozFPstiwHjUt
	9DSSbfDQRnPZb/6d6JkqkP3UA1wEaXk/Y4GcdF02hPCfK1CS4cQd1MOg=
X-Gm-Gg: AR+sD10G2deo3YgjZGW+bMEytO8PsPx2SKHmAVKZQ1FAflv1y3aMFK/h+LdIX4cz+5l
	dlYuLW2jWmUueW0NyZPqiz2mYJt5yn+dCSRJpbtNWYDjeJ1gYD+jBl+zzIRqunBsMNG51JTBc+7
	qNpy9gVjUShgpFNCgN2ILBkmhf1kzNbUc6um6jUwam6+jRwFUACCriYcA5cO3D5QPds1b6Al/V3
	CN7vVCBo7Jx5z76VPlMhHsE1kwwtM/i/PSHOEQfcq5FOMWOPI2wegH9jh7pqGAUQlSW1bqyfIwK
	G18YWCt4CtEoAI6IqOkOBRFMTEqfzBgf9P/0O8NMQbDpzBao4ayWLffI/CaRnK/mdmLXWc6K4gt
	c37v+LZaP88z1SRjk8rVlTFQWkgoeUr46Hhs=
X-Received: by 2002:a05:620a:9445:b0:936:cf5a:6061 with SMTP id af79cd13be357-936d2341930mr1742760085a.45.1786981554036;
        Mon, 17 Aug 2026 08:45:54 -0700 (PDT)
X-Received: by 2002:a05:620a:9445:b0:936:cf5a:6061 with SMTP id af79cd13be357-936d2341930mr1742754585a.45.1786981553582;
        Mon, 17 Aug 2026 08:45:53 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610966dsm205095575e9.5.2026.08.17.08.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:45:52 -0700 (PDT)
Message-ID: <32b54253-a109-44b2-bbdf-ab6440814522@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 17:45:51 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] cpus: Improve qemu_cpu_kick_self() docstring
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Alexander Graf
 <agraf@csgraf.de>, qemu-ppc@nongnu.org,
        qemu-riscv@nongnu.org, kvm@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
        Magnus Kulke <magnuskulke@linux.microsoft.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-3-philmd@oss.qualcomm.com>
 <13c02cbb-79db-4ebd-9fa1-63ffeb0b43f4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <13c02cbb-79db-4ebd-9fa1-63ffeb0b43f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Kz3s9F48kg2CzBHDTyGi4KpkKSXb_JZv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX4UI/oqgyB1Jy
 ia9wK19JP46xhaPC4HhNoDLaNi/7UQpQngqxfOyjlDYBzuLxJHku8S5Am0k8HCafS5CiEWrehJ6
 FnK3iHZalkdUemKWLkJWGMTiNjTPi+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX14h7nEawhGOR
 6OeZS8uVlrpidyBIMNdyYXujUDGUBrekVhSFWfyNLEoSesWnLb9AMeKDmsz2fbE75oYlANvscBK
 cqeEwb2C5oj/o0kRdMoXucZyE4h81ki8IPUZRvcfxgUxlM6aKFyNJAine0q6/SzNFZWvwOYrB3T
 S+GlR1UK5EFdIVQD20nF6z5qogcbCUG52U8TMbJaTqZpBnpRRFmcibf+AL8H8m7UBkouKmcNkE1
 tKjdkCXASIgkY0/ReZrJbJm4T+c8Bxwba5kG1YFCWKW2TI3XzK63xmhbVZ1Dn8n+S7wi3FwPga9
 +WgL34gS1UbAd/fJPiIHYJjCM1yLaja3eiy/JFOWt+8XCFVTZ21RHMDzEhgRaBPsYmueLmIqg++
 4EHOg9+UDc64wEXg0iGcFYOC4xx63YLfGJceHpCfn1qOmAXzsBX0KPuPVd4Ai4eX4liUZKmkQ+a
 gJaHdwBzBMPq3zt8o8w==
X-Authority-Analysis: v=2.4 cv=HYEkiCE8 c=1 sm=1 tr=0 ts=6a832cb3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=NSIYWwr6F1QkDLxMasYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: Kz3s9F48kg2CzBHDTyGi4KpkKSXb_JZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170119

On 17/8/26 17:28, Paolo Bonzini wrote:
> On 8/13/26 20:16, Philippe Mathieu-Daudé wrote:
>> Be a bit more descriptive than "Unblock cpu" :)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   include/system/cpus.h | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/system/cpus.h b/include/system/cpus.h
>> index 508444ccf1c..ade13e068eb 100644
>> --- a/include/system/cpus.h
>> +++ b/include/system/cpus.h
>> @@ -30,7 +30,15 @@ void resume_all_vcpus(void);
>>   void pause_all_vcpus(void);
>>   void cpu_stop_current(void);
>> -/* Unblock cpu */
>> +/**
>> + * qemu_cpu_kick_self - Force vCPU to re-enter to its inner main loop
>> + *
>> + * Signal the current vCPU thread to exit any blocking operations and
>> + * re-enter its inner execution loop to process pending requests,
>> + * possibly returning to its outer execution loop.
>> + *
>> + * Must be called from within the vCPU thread itself.
>> + */
> 
> Neither is correct.

"Must be called from within the vCPU thread itself." is because of
the assertion:

system/cpus.c:452:void qemu_cpu_kick_self(void)
system/cpus.c-453-{
system/cpus.c-454-    assert(current_cpu);
system/cpus.c-455-    cpus_kick_thread(current_cpu);
system/cpus.c-456-}

>  What it does is force the vCPU not to enter the
> accelerator, and immediately exit again to process events.  This is only
> needed because KVM doesn't want you to process events because KVM allows
> you to do so.

I got confused by this comment in accel/mshv/mshv-all.c and interpreted
too much:

/*
  * The signal handler is triggered when QEMU's main thread receives a 
SIG_IPI
  * (SIGUSR1). This signal causes the current CPU thread to be kicked, 
forcing a
  * VM exit on the CPU. The VM exit generates an exit reason that breaks 
the loop
  * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the 
system
  * will shut down. For other cases, the system will continue running.
  */
static void sa_ipi_handler(int sig)
{
     /* TODO: call IOCTL to set_immediate_exit, once implemented. */

     qemu_cpu_kick_self();
}
> 
> I'd rather have something like:
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 83cbd120a84..e5d068e341f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3292,7 +3292,7 @@ static void kvm_cpu_kick_self(void)
>       if (kvm_immediate_exit) {
>           kvm_cpu_kick(current_cpu);
>       } else {
> -        qemu_cpu_kick_self();
> +        cpus_kick_thread(current_cpu);
>       }
>   }
> 
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 8a1af35ed32..b9b1ee39850 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -753,7 +753,7 @@ nvmm_vcpu_loop(CPUState *cpu)
>   #if NVMM_USER_VERSION >= 2
>               nvmm_vcpu_stop(vcpu);
>   #else
> -            qemu_cpu_kick_self();
> +            cpus_kick_thread(current_cpu);
>   #endif
>           }
> 
> and get rid of qemu_cpu_kick_self() completely.

OK I'll take that route.
