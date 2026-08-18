Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE443F0BF
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042896; cv=none; b=OdqVVO9Knq84XZUl74keX2QKjLIKex5N/Zhiny1b78OvJkcnsMeot206QfJYA4p3GpB2zQmeHsCV+uokpUHeq0k2KiUcOOWfBv6c1Y1YmYWNOs37ZvCSk5TCLCEzG7YKFHIAwLjjcjiJjp1eQznBpaL/wJ+yF8j093K2a16xV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042896; c=relaxed/simple;
	bh=m19gOfhgFfrNyx9gN1YI0FaqYSxQy0ynSHm84Udzlbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/2l5jJy2tldzlKGLGPpZl0aiq9KxZOZxCRvHqq4LROMSF6g2L37ZZwP5D+DQ0852NKnm0NuXUOW3w9ahI6c3izgFhMyovVsPIQSmPH1ldz2GxXN0mp8tp7rDj/l1P8A7+KEBu2V1HHVlrF7KYhT7Nqfsk7aavHPpQHhMS23Vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VW9S/1Pc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Si+sSUDG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VW9S/1Pc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Si+sSUDG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BF0U747614
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 08:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pXwYInvkmu8G0HskQ5AMBGpvs8HO0gTNnQT0ehKDGbE=; b=VW9S/1PcvukBaX1c
	Drso6g0D/d/vOFaNfI7unjbwudlDiVqY1jVY0RLlu7QgL8br8ozRgN696vQJizBX
	5ICGX01nLKiY2Awj/FnRiEOoTk7oW/xwcgrKcAa2pMWPuXJuxbJ6LT8yZvHlwXx9
	1nYAbCfD6Q7JeSC/H3std++KzodM8SG/YXYQ4pm0M+kr6WSOmJDbSqGA+WgTw4cF
	8Yr5VpudpKtvCZEupt3HWY3DHzsl9DbWbFmUyrrWKEu6434yMSjY2A4n6Lv3eBXa
	L2N8lKfDi2stJ5z8+S3V4r4PCEMEjEe9/2exGt4mNm5BByleOJhzMs3VOvkRpOBg
	1dCAjQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0ttcd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 08:48:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934979ee9f1so561175885a.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787042889; x=1787647689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pXwYInvkmu8G0HskQ5AMBGpvs8HO0gTNnQT0ehKDGbE=;
        b=Si+sSUDGy7mWXV7HWuQt/HrG23RA7Wq+ZgW7+316BTmlixHcgg+sB9cqNFrHE4Fs/v
         bJuJ3rLrCjz/T2uZUUy0Ab4XkHX6r5X7xxc5U/ewuuvkYax3HaANl2Dx6i0TDEuBm3lX
         FeExNLOUMA/3rxqzz6GsPBBDfU+z0KfHBn2dbPb0htF4lS363kVzTWX+6fRJscDXSENx
         b1OCpL2mHVPRTMpSQoAguUCI2HGs3Bvg0Tq5I3Ufdm+bI0QPCyKyRtYwSwJ77Tt597QB
         3s9RRJ/lwmuBKj/623Rl3tiaD7Z0HnfFwpdgc0xymntoO3GdWDr140MfV7efFKZebyHj
         dKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042889; x=1787647689;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXwYInvkmu8G0HskQ5AMBGpvs8HO0gTNnQT0ehKDGbE=;
        b=CsgOb5j3kE7dUoKo9xi3DkWPjTQpR7hmSHwdMCHQgVzgzNCTl9LxO01+RlUNIDvr18
         hqkk6jx9fvhU6s27FCyl0Od2c9htrfoL8PlDiVJmn2svXKeZr6DG9HqSpllgV3ACMIgc
         i1dKaUMwB8gfv9X3CleX4pzwaSFBzGt8eN5paH9RFOGt6a4/1Q2Fe3PhvF5HBKo0mQlk
         TgNEqRSrPLy0qihhykj5+AW1imJh18hOv35P3VXFCrEF7XkMdjwe+rKzZD2/zd08mKI+
         xQW+IY4fGvkS9uujzRRXsuGTKl2orqBFS8OltYhWhoVPBWQKgn1tnRIby4MHy3ZRVSbH
         S9KQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxWaFneTzK2MsRiJi3wLxem/V8RmT9N3egnCSG0BDzmWZ9dPkFIYt144P5llWgQRBeOmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqMk626/D/wGcZcYf/eW9mOZ6LwMMtZgpBmbvMbuG7UFjIjBt
	WRTdl7QDz7UBHnWfRXf6v/PXKQ/n8aIj5CIbR2hGWztUkIYwot4qtFBh9HVZOMqPvLpayMjRlyq
	hqD0NjkyE1YGH2t7B2GPA+Hlq0lz6sunj5I79NysoM2si9KjvEvsFjJ0=
X-Gm-Gg: AR+sD137mqaDOiH1qCIVsu4Rm3nAd5y90R7Q7ylvYmjNNd5my7UeIKK5IgjEpUOJ19+
	YIDwIfDhjk8ina6KFeABsPIzPjmQCEazNpa2iOPwycGYe62Uzfndof20e9iiGF4YC+4ZqTEWmtt
	2vosewdBsVH43/HxIKSpb1cmV8LAp5reQQiFTwQOe8d2wOaliNtT6enL+dJ6qAqKHOpbp/ZEEVZ
	gQK3RqdqhtZRJiRDu34jUhPmQxIBnBWAUZ/OcBJ6VrN4ckfaoUVCp3aVB9brbvbVpVVrD0S6ICT
	Ej9B2yt557BLjrDxvXpjztQYSv3IfQMNxdvGfFwDcJOHltOpmiRImgfcSN2XVpXKlFc9RSEIRzH
	qprZTZSwoTTuBk7LskQGl4tCRiaQL6D+cy3I=
X-Received: by 2002:a05:620a:408d:b0:923:45bb:a95c with SMTP id af79cd13be357-936d1fd9bdemr2856006385a.10.1787042889431;
        Tue, 18 Aug 2026 01:48:09 -0700 (PDT)
X-Received: by 2002:a05:620a:408d:b0:923:45bb:a95c with SMTP id af79cd13be357-936d1fd9bdemr2856005085a.10.1787042888909;
        Tue, 18 Aug 2026 01:48:08 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm103963505e9.5.2026.08.18.01.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:48:07 -0700 (PDT)
Message-ID: <9e83f348-0d27-49a0-babf-789a8817d78b@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:48:06 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] target/arm/hvf: Lock BQL outside of the vCPU inner
 execution loop
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
        "Scott J. Goldman" <scottjgo@gmail.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-14-philmd@oss.qualcomm.com>
 <3fa59521-1420-49e3-9d73-652148f946ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <3fa59521-1420-49e3-9d73-652148f946ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2NCBTYWx0ZWRfX3my7YDXMg3uw
 IPns7oY7JNE1cJNu6Xh9IByT+dskc3ia7GpsWpjY3PvqgUZ8hP0D84T4fv4xJl7vrJijFuCae+g
 xKRBAs5ppdfUz94hWwTgURluEXH16GI=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a841c4a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mLG9MJvJpvtZyw53qYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 2iw_IuWUwd5l5--btJzZq1NeVLU1Bqyl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2NCBTYWx0ZWRfX2cMYci6J0aeU
 SiPHwB4jz3VsJaxaB5jbWcAkLmkmdm/OQ+S2NfmPK4Cyo9+wEE43u8Yh21mZk210OE+w+CCOA4j
 1qGjO3gK2aR4xM3v/4G8Fl0N9EYQTWMJFRSgKR0lNi9i720TeWDFHoiVV8o3moDwjtQ4jk7Q3eM
 FwF9fEnz1IUBQTO2igUC9ZZoihUR/YkLCyGqXQyTQY5rX2hEKaBAcJinhtSzm6HTqzOSJ5pZNtZ
 I4TbxcY1vElFYyT9CwqPKv7YR7wKcWDqJheL+AhDI2nVRaaFxUx8OpSNOjAw6feD0WGI3NoWvzW
 JkSrik56R2JG7mvUR+6y7zawvve7TxS940zeBUnSsqY4AfyjqQO2rUdKZHsxjzwLcnGq38wH7Pk
 kCr26SP7/pTH3LRIP5vQMElxG3L0ml9pJrLBPgdtLxgo6tcL5xdkiBF3up1DlNWLUDze/PypHxG
 JWw+6gVFeEHskL+I7mA==
X-Proofpoint-ORIG-GUID: 2iw_IuWUwd5l5--btJzZq1NeVLU1Bqyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180064

On 17/8/26 18:11, Paolo Bonzini wrote:
> On 8/13/26 20:16, Philippe Mathieu-Daudé wrote:
>> Reduce lock contention by acquiring / releasing the BQL
>> outside of the entire vCPU inner loop.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/arm/hvf/hvf.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index c14ea54a67f..9c6408d2e25 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -2598,20 +2598,20 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>>           }
>>       }
>> +    bql_unlock();
>> +    cpu_exec_start(cpu);
>> +
>>       /* Inner vCPU loop */
>>       do {
>>           if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
>>               hvf_inject_interrupts(cpu)) {
> 
> It always return zero, so you can make it void and change to
> 
>            if (!(cpu->singlestep_flags & SSTEP_NOIRQ)) {
>                hvf_inject_interrupts(cpu);
>        }
> 
> However, a bigger question: who calls cpu_reset_interrupt() here:
> 
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_FIQ)) {
>          trace_hvf_inject_fiq();
>          hv_vcpu_set_pending_interrupt(cpu->accel->fd, 
> HV_INTERRUPT_TYPE_FIQ,
>                                        true);
>      }
> 
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
>          trace_hvf_inject_irq();
>          hv_vcpu_set_pending_interrupt(cpu->accel->fd, 
> HV_INTERRUPT_TYPE_IRQ,
>                                        true);
>      }
> 
> and can this be changed to do something like arm_cpu_kvm_set_irq() instead?
> Having the function called only with level == true is a bit unsettling...

Digging further this other change from a86024eb2df56f looks dubious:

  int hvf_arch_vcpu_exec(CPUState *cpu)
  {
      int ret;
      hv_return_t r;

      if (cpu->halted) {
-        return EXCP_HLT;
+        if (!cpu_has_work(cpu)) {
+            return EXCP_HLT;
+        }
+        cpu->halted = 0;
+        if (!hvf_irqchip_in_kernel()) {
+            timer_del(cpu->accel->wfi_timer);
+        }
      }

> 
> Paolo
> 
>> -            return EXCP_INTERRUPT;
>> +            ret = EXCP_INTERRUPT;
>> +            break;
>>           }
>>           flush_cpu_state(cpu);
>> -        bql_unlock();
>> -        cpu_exec_start(cpu);
>>           r = hv_vcpu_run(cpu->accel->fd);
>> -        cpu_exec_end(cpu);
>> -        bql_lock();
>>           switch (r) {
>>           case HV_SUCCESS:
>>               ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
>> @@ -2624,6 +2624,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>>           }
>>       } while (ret == 0);
>> +    cpu_exec_end(cpu);
>> +    bql_lock();
>> +
>>       return ret;
>>   }
> 
> 

