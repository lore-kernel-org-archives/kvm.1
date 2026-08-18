Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55C442B03
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045088; cv=none; b=H0nbWUEizQyWaeypdReiWVg6+fOfB7JcPIrlFBuJzaC5Q0qcXtf3q+Ch4UJ6vkJczLiY3sZd/tWszP2ecgadSLo9XoKhdlgeYt8K8caTu38TZcOBCeC7nAqVDGo7iIyQC1ngr2OSV7Dg1UslNt8ZvSswJngLzmotRoOAlQ4Ao9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045088; c=relaxed/simple;
	bh=x6rWf6O5h0rSOaZl8wT0WjQSIaeGNgBUes+mmy11ntk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAYW1IRsI766B7mwhvQ/ocR0uJHHp0BsJlyVMCZ8cb6V1ckUHPvDOjRipNDOooknns92t4Ezie/X8SuaMXJLqo98pnsuvCl9wKu6x3M2ze1Bzw2N+NeNk1k9pl2qYPg9TdhJrgtBpQfRI/OYonVCbQx72ysu23mVMu95+Sqxi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ypl8fmXv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fIyEZ67I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ypl8fmXv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fIyEZ67I"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BLPa310052
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HFG1xD/W6bg6YYmgkmDBDXih0WD7BOSMazuzc4renDc=; b=Ypl8fmXvtE83PsHn
	nQE+j+g3vS+x0HmkH1nct737tSFtsCeVJRiSs0Qug20Ww+E5gbcC6aPQnVo6HEcD
	Lr77lYT84nNp8uhnzHWxu7LSsulgMGI9YGnoEp9H4YyxkUEaj4AMTkfC7pcxUgzL
	uYcD+IqC6E1GZv8Nh0hYodpLsLCDY1wMmEbyRKBBqCz8koJnj0nCY9rL91WjV+J7
	QECXvbDsgHfqx1hr/vSuTEHZLGbq+VkAaHByXZDODiBiWjevomKV2EoW9FjJMSkB
	P3vQl06Lxra0Jp72RBrnDoOsQVspx7nwto8R5fzwr31ZqjFosJYMqgdxKl+EVxad
	vrbwXQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba9fgs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:24:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so475282985a.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787045085; x=1787649885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HFG1xD/W6bg6YYmgkmDBDXih0WD7BOSMazuzc4renDc=;
        b=fIyEZ67IOKDWtLHCFQ5qIVGY1INjl/vkiFDdC56I4zswodJyoPIEZXoR1Z17ORljgh
         lGRJip70Uus7ORx8+QnMYDgPSCCBSRd8u9DIWsBSbN0F3Oe1wfSGfUc16qDVUqWUdj4N
         02shggWsLnMciy7gqNxEfCDo/t9O+8EoCeu8ZWbymFH7D94MHtDDVu+j9bILm8DHUKTi
         3UYOS6jK9hU3/NrWbHaYmCZtO27MXRUwA3rqLkEiC5uKTUT/z1HOp3IwtgUK2HvaVho2
         cKqGGaDu2eCJK4SsDi8IdJO1zGeQxj6oa/EakNsnx5QZeHVQLfkZV2t3suQaQ+6bKmSt
         JeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787045085; x=1787649885;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HFG1xD/W6bg6YYmgkmDBDXih0WD7BOSMazuzc4renDc=;
        b=PmujGOn0/NNhiiGOgCWtg5vOYzQBsGJjZzz6Vv78ZLBYb3ERnVY2N4x8IVyjZlqh1T
         wKvaV+fP5hDMFF2OwYrMK69N5Gb9cCbkyZhE8kBNFiExbCQ0bv6nTt7E+gQJDtnRi0ls
         aeavoh4FyBD/HEnFiIr0NBo+09G7m57Af5T2rAqFDxzz6PJOPvY+NSHWKcpYmOsQP3K1
         txWnqi5luDRdSBJ2bC/NFEONTucVUD/XN6/ucUh0Ra7hRovu1Iqofgb+d3R6iQayD2nx
         uwhGUpYPihMUE6Cry07MYbOULmBw8FRtD+C7ntnuFqdUsSx1oz/lBCThRc/XPoqzbdEN
         MVXA==
X-Forwarded-Encrypted: i=1; AHgh+RrwyhfRo8W3CR1XY90PLZVLOvU9GGyxGO9K4x7NPRuQtTV20xrTuHb+d2x4PDxc9Xemfsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwmj2P3sjj/5oYlBmo217c8tgAIrZqbPhyISfqUrZvfC+uXq8U
	ALBrnbYQtXsVrrEnago3sFaRFVoFAV2ktYztdrsAmeIwXpxfvg3YQBtL23DR/gZLm3Djm3R1wAX
	3dl5wDnIGJhIxfJP5n/0kXCmugP+5UhRpk2cApVwx13zhCedHXtqPyLA=
X-Gm-Gg: AR+sD10/8bl2m8OvFNmZFp9+F0NhU274TEkmjsOnYIl2t8QZjPQbwVAgvCN0Rdmtt6L
	2EWqv/IaO1ZvIpLXN540WDj1CrcuGiGD59efJymtsS8yus9VgElhIsgo50GUNfk65M/sGg8bnDw
	fh2mKix4ZLHh7HkRTYlh5cAtCLqPwLoQOYk2zjdKG8Zg3E3R4pqe+5Tf8Jok/PVR/0jcXavWhh0
	uHXO37hVmpJr8cD8Q2u4nK9GpEJ6WnfFTkjNOT48T0fjZB2O8H34eMV0y3dDKnYWLuEUa9Oxn3l
	GiMszL/0tCq8UoysUljWH+aBPpE70uas8MmhGP8rsCzFILgz65GoeSBGQL6t1KfDy/m9VlbOYZh
	YxWoHgGvL7bp6LZes/dbFmLG/Ek+98HE5v6w=
X-Received: by 2002:a05:620a:8084:b0:936:883d:89c6 with SMTP id af79cd13be357-93704b7d0e8mr704378485a.28.1787045085469;
        Tue, 18 Aug 2026 02:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:936:883d:89c6 with SMTP id af79cd13be357-93704b7d0e8mr704375485a.28.1787045085074;
        Tue, 18 Aug 2026 02:24:45 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm174896245e9.10.2026.08.18.02.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 02:24:44 -0700 (PDT)
Message-ID: <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:24:41 +0200
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <55cc8357-daeb-4315-9f3a-8be7a59c355b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2OCBTYWx0ZWRfX9LvC4raknpsj
 g2vSlSI9amskv5j6ke61OvfMwDo4OC3U1hYXHrQ3g6/J4NK/oVkwA1sOdSiXUnd0zs3f7LmDmRF
 EMh/O+OH8jwmrNrJ2qqQFTnCyn/xqBE=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a8424de cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=9aCaMZ_IbkuWgEbMIRYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: DJEwfl89ix8_2ZeLREdcQo3ggvPI7Wdq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2OCBTYWx0ZWRfX7NKtJXTquiY2
 ihTZJjun9UT0WfMFQuIbFlZHWV1N3aGxixFOVRldax6xhrIJTHWWJiyp+BkNyEHw9BmwfunOknr
 lO2suVMImSEHjhjnocEgAs1gdn8rKv3RWWY7a1C15mHcdsy5A1R39/73jegCBHRqNq0Q+xVnhFk
 dbIiIdeygij4mo64dTxEWqDajpt/sRuTcj6sTmRc2GK7SgB6gm6CcXQoMMPnl5YJzCCpDknXRKr
 ny3hXQhkJiv+SsvqEsCLZxDdQgxrCClLJgYv2LzHyW6gdczo1iNbw9PQQr/WVLosqNaOuZ1CYuu
 mVwU+YLAa+Gfm9XjYKJXpM94BIYBCFO7XVaFqf9jpwzFxz96jlfSrraCAvtH+FtqSWCBu3q9F/J
 euHi0e3FeE4t0mmRYOLcIeUwP0+sNAOTWwBjXpEuuYqgQYuReywoK01wgArBzBycKKn2xc91ErG
 ooNpc/BpnH2VyEomD3w==
X-Proofpoint-GUID: DJEwfl89ix8_2ZeLREdcQo3ggvPI7Wdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180068

On 17/8/26 17:59, Paolo Bonzini wrote:
> On 8/13/26 20:16, Philippe Mathieu-Daudé wrote:
>> When comparing the KVM implementations, RISCV and ARM differ
>> from S390x / PPC and LoongArch. The caller expects a non-zero
>> value to return pausing execution with the EXCP_HLT exception:
>>
>>    3427 int kvm_cpu_exec(CPUState *cpu)
>>    3428 {
>>    ...
>>    3434     if (kvm_arch_process_async_events(cpu)) {
>>    3435         return EXCP_HLT;
>>    3436     }
>>    3437
>>    3438     bql_unlock();
>>    3439     cpu_exec_start(cpu);
>>    3440
>>    3441     /* Inner vCPU loop */
>>    3442     do {
>>    ...
> 
> Your patch is correct because, even if cpu_thread_is_idle() sees cpu- 
>  >halted == false, the flag could become true during 
> process_queued_cpu_work() because it releases the BQL.
> 
> However, I think the better fix is to remove the return code, and check 
> cpu->halted in kvm_cpu_exec().

Looking at it, even better would be to move *process_async_events()
from inner loop to outer loop for all accelerators. For HW accels it
seems quite trivial; for TCG I need to figure if it is safe to call
icount_prepare_for_run() with the BQL taken, due to the replay_mutex
uses -- here the win is cpu_handle_halt() ends restricted to system
and we can remove the odd EXCP_HLT handling in user emulation.

> 
> Thanks,
> 
> Paolo

