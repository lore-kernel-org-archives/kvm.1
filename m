Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAB3E7BA5
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084615; cv=none; b=or45q0G+KO0jPsalPDXHS8/NTdKJwzNx9c5RM0HeufxPXj7qnAcMe0eVhFBm/BawE/IbOlvZ2OHNOeN+Dom3dxRPGZox8OMw4VgZ9LIpdIL6kku54t4MOMEZlfchcGYby5/AkCqGiz2sIH6hqeMl/K2OKzXLiycWvnxrpReaYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084615; c=relaxed/simple;
	bh=5uKyFr1sbXgKqsUA/5ktsfiBS3c2KcO03bm0tMp1WPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJpeanA9ScyALBxg+p8pp3XfKFSWEg6iQapKMDC9zDb2jU/rZuWs0LZkR7flPLObp0L3nRCplY0J9hIPVN1AJMIUtqIR+ORTrk+MXmn7S7HKDpDbpIMhbrq0K1ntG25WsgEa4HXDeNCgamF7GDwNvl9W4n19QOO76YIEeZwYOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZSH5gu2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UvHGzt0M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZSH5gu2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UvHGzt0M"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2LKd1912298
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L1FH1W5U1Zo+xcXwsO7uD2MIuU02K6pwTbQnTJHDcOU=; b=QZSH5gu2JZQUQ1o7
	m01rOZSkv3wqp3Z2WuW9qTn68Ihvqp9Tl+rZk2cS460yxXAnIaS6dhW4GupV1gcn
	fT3+rUdSn8eDCrUhN45CAo7LPMezrZCVp2zx0uSqIB0EbI5BFppWVHxObLy+Y93i
	IOnmZcyqOUzTuv5VYxKh6w7c1sPrdPspYid4GZYr/+Apvxu03Ce8iklEDI4S735D
	d6vMkCllrqT0AwIUgoLDcppJvPVuXTtMNrEIaWmrhRmk13U6o7VsjhXMfNLM86X5
	iqfyzJNsyiAeiBN3c3+ci6mux+fWyQdW1qQL1i2dxflKPhSHZYogyd87vjyU4EoZ
	4cT8FA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu523sq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:56:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304ea42b025so351412eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780084610; x=1780689410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1FH1W5U1Zo+xcXwsO7uD2MIuU02K6pwTbQnTJHDcOU=;
        b=UvHGzt0Me09rzeLu5hxpjSeGJlaepvQ1VkvRBD9Tq8j2d9tYW/4tFk4XatbNx/7U8c
         0befpbURSMb3pOPrbE5HGdZBSwOx/hn8HxxaxDUQE4UYNxC48iVmcsn0rnjhlVEN/SCt
         unhuRlhm1SEDxaH/vzkrAYLDx0lv++GXxavFf4orkKri05nh63rPhNhQaXKFzEIazYiA
         CFIsqh4R45VSvzYxd0tDX26jc2sRsr0w+zLzQk4+cxDF+k7IRTnlC0tSs6Ho/d+EY1h/
         Hxr221RGROJ1ewJadViVSTfeR8jXaE+Wnz40djN2zvvMP/FV3t/XLNqFDPLu9SmHw2Ww
         lE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084610; x=1780689410;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1FH1W5U1Zo+xcXwsO7uD2MIuU02K6pwTbQnTJHDcOU=;
        b=InLzGhMZqEZcOXp/fXNXSBN7JAzR3T5NDMWhF110UL0yeBu3FGlGw7uBiBmDNo4+8g
         DA0cxB0oyV5dgSc23U309mcq9BjWFRzDp951J/f2xsSXbaNgHH87QL5XqxhsL0bVi+oN
         BFovkHUVkTTIFu8H2pDp4pmRLAMfwErWHdID4Vd6xFbzg7smQrePxgr3v6Aw87hO6UkK
         WUv+EFcfIh58TXDWlErkuwHsr0F/0JVTUNUuhoy4Q0E7P8ZbNA2+e6NCeEAVwse/kae0
         H7HLgtFBKWZFz9OK2IZEwS+5m0pSHWAX8SNXrQiDcuRRJoZS1t8cpSu0TLVODUw9bUjl
         xlaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/vQ1MShuXZtIu2GWDniAB9Cwl8NBsALaTLq5sQunAMV1if5Noys6hmZMXfzHE6Awc0uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0H6v30dCoWHtO5b6WtCNBtWlxKa5hev7BciflybRmLeDHh1k
	A+CEgeUYyoXJEGqbZpm5Q7mMPBFRDDx8b0JNr0MySTrvzsujJIz8ARgbdQRbqjZ4SDJqOd9+12q
	4R/iWT7IXGWMghdw7MTDbiRAHdVPQwuHdCuuJH8wp+jUTVyno8DKqpog=
X-Gm-Gg: Acq92OEPwRA7a+wMiAAZmAqoFUg1hBF8cwnCXWjFrF7m7BEjeVQx0hmH5hdDlGruAQz
	Kn/7agwRxvQuhLyPK+hjX1gGm3Sh0wKdcAl1wMKgdla7186u00d888gAyxG5mpvbWee84DXQbZY
	yuo+ivGpRASsrW8vTzwSV7zawOWdZcv8V/C1mkErW/dyOS8sqnh0kkI72ERRKGsUmxdQtXSZCUq
	bt/hXyuVfMH80rJuu5hCH40jNRfhI36577QoiUcToKHaEcCqRTcKpF1fInnf0kKA7LZorVZVGKe
	J/+FnUEAjPts5GquSlwvdrfzAmf3c7MP+eNn0VGyIoF/gZKHYgg/3MjSHKVzHP6zJXUMOrx8ioQ
	08xn4wEQ/Dv4VdbVSqojSBBHpTx0pwAgFnz9eBM2jXrtQPe41D9OvSLGGBxJZkQP89dhkt94a4z
	hGpfExRZLzltFEDBbd+JMxIb7U
X-Received: by 2002:a05:693c:620f:b0:2c1:82c2:bc31 with SMTP id 5a478bee46e88-304eb182e11mr1526495eec.10.1780084609596;
        Fri, 29 May 2026 12:56:49 -0700 (PDT)
X-Received: by 2002:a05:693c:620f:b0:2c1:82c2:bc31 with SMTP id 5a478bee46e88-304eb182e11mr1526455eec.10.1780084609020;
        Fri, 29 May 2026 12:56:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c3121sm2253871eec.5.2026.05.29.12.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:56:48 -0700 (PDT)
Message-ID: <748cc9e7-072a-45db-ba42-372669858f60@oss.qualcomm.com>
Date: Fri, 29 May 2026 12:56:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] accel: Remove need for AccelCPUClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
        kvm@vger.kernel.org, qemu-s390x@nongnu.org,
        Chao Liu <chao.liu.zevorn@gmail.com>,
        David Hildenbrand <david@kernel.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anton Johansson <anjo@rev.ng>,
        Claudio Fontana <cfontana@suse.de>, Eric Farman <farman@linux.ibm.com>,
        Alexander Graf <agraf@csgraf.de>, Chinmay Rath <rathc@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
        qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Reinoud Zandijk
 <reinoud@netbsd.org>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20260529194940.97143-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a19ef82 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Zsuq9JpdEuuag0fFG78A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: cF2TWLX-U7EYtBgWWag-Mzhy2ncRXwSr
X-Proofpoint-ORIG-GUID: cF2TWLX-U7EYtBgWWag-Mzhy2ncRXwSr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE5OSBTYWx0ZWRfX3FccCxtbf0bl
 Z0t5t84dVwXr69tzdpz8UIiYfboq2V4E1aEwpjXRmg6cfRbZKdZKoYPUQ1chECqb/YAIuqlTeka
 DW7d0toWveWerLLBTxwQH8FaJlGgyyNwmNFjhmeryR6T/9T3LKw7WJZv9l74/urbXl0fftNpnm/
 iz9bap8gxZ9H4Fp4rqt8Tvbhm+jcyt6/VvjHup4+nOl7Jils5CZWB0azSVUO5rxY45pYPrnPVrS
 1jREWvbPzr41VYmFRv0Xuj0xaL5UwCSzfC+JlYl0nRYREO5/U0kKvD4FscElFx5W8N/6VkSZjTS
 zeDRchutY0famoNIz9YajuYtKPxr7AaZ1DqW3V9NoBl84wXUGMCKYbeMRNBdZ/S/04KpRp7j4P5
 XvG0MuKFQkpn3GlrBONpCTyzUdZydrkN/xWLTkSIqaZtw9OjgpCVx2cEKZOaENE1ad618eQh2+l
 Pd1XSfNADEu6FL4RiMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290199

On 5/29/2026 12:49 PM, Philippe Mathieu-Daudé wrote:
> Could get re-review: 4 & 5
>

Looks good, thanks.

> Move cpu_init/realize hooks from AccelCPUClass to
> AccelOpsClass. Specialize them for TCG in TCGCPUOps.
> 
> This drastically simplifies the need of per-binary QOM
> types per accelerator per target (see also the nice
> diff-stat).
> 
> Based-on: tag single-binary-20260528
> 
> Ignoring checkpatch.pl:
> 
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>     accel/accel-target.c
>     include/accel/accel-cpu-target.h
>     include/accel/accel-cpu.h
> 
> $ git backport-diff since v1:
> 
>   [----] : patches are identical
>   [####] : number of functional differences between upstream/downstream patch
>   [down] : patch is downstream-only
>   The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
>   001/      17:[----] [--] 'target/loongarch: Remove unused 'accel/accel-cpu-target.h' header'
>   002/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_class_init()'
>   003/      17:[----] [--] 'accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()'
>   004/      17:[----] [--] 'accel/hvf: Remove need for AccelCPUClass::cpu_realize'
>   005/      17:[----] [--] 'accel/kvm: Remove need for AccelCPUClass::cpu_realize'
>   006/      17:[----] [--] 'accel: Introduce AccelOpsClass::cpu_instance_init handler'
>   007/      17:[----] [--] 'accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>   008/      17:[0002] [FC] 'accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>   009/      17:[0002] [FC] 'accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>   010/      17:[0016] [FC] 'accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
>   011/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init'
>   012/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_instance_init()'
>   013/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize'
>   014/      17:[----] [--] 'accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize'
>   015/      17:[----] [--] 'accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize'
>   016/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_target_realize()'
>   017/      17:[----] [--] 'accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h''
> 
>   diff --git a/include/system/kvm.h b/include/system/kvm.h
>   index 2c31fa6019e..a249f076763 100644
>   --- a/include/system/kvm.h
>   +++ b/include/system/kvm.h
>   @@ -225,0 +226,3 @@ void kvm_irqchip_change_notify(void);
>   +void kvm_arch_cpu_instance_init(CPUState *cpu);
>   +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>   +
>   @@ -367,3 +369,0 @@ int kvm_arch_destroy_vcpu(CPUState *cpu);
>   -void kvm_arch_cpu_instance_init(CPUState *cpu);
>   -bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>   -
>   diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>   index 113a23f2384..edad3c1acea 100644
>   --- a/accel/kvm/kvm-accel-ops.c
>   +++ b/accel/kvm/kvm-accel-ops.c
>   @@ -101 +101 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>   -    ops->cpu_target_realize = kvm_arch_cpu_realize;
>   +    ops->cpu_realize = kvm_arch_cpu_realize;
>   diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>   index 7d194ea112b..0f1a98b430f 100644
>   --- a/target/arm/kvm.c
>   +++ b/target/arm/kvm.c
>   @@ -1785,0 +1786,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>   +void kvm_arch_cpu_instance_init(CPUState *cpu)
>   +{
>   +}
>   +
>   +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
>   +{
>   +    return true;
>   +}
>   +
>   diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
>   index 5d74ca6fd56..536bcecd7d2 100644
>   --- a/target/i386/hvf/hvf-cpu.c
>   +++ b/target/i386/hvf/hvf-cpu.c
>   @@ -58 +58 @@ static void hvf_cpu_xsave_init(void)
>   -void hvf_arch_cpu_instance_init(CPUState *cpu)
>   +void hvf_arch_cpu_instance_init(CPUState *cs)
>   diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
>   index 10ab7b2a4dc..2973e28122a 100644
>   --- a/target/i386/nvmm/nvmm-all.c
>   +++ b/target/i386/nvmm/nvmm-all.c
>   @@ -1214 +1214 @@ static const TypeInfo nvmm_accel_type = {
>   -void nvmm_arch_cpu_instance_init(CPUState *cpu)
>   +void nvmm_arch_cpu_instance_init(CPUState *cs)
>   diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>   index 9d844c4905a..167fdd515be 100644
>   --- a/target/loongarch/kvm/kvm.c
>   +++ b/target/loongarch/kvm/kvm.c
>   @@ -1497,0 +1498,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>   +
>   +void kvm_arch_cpu_instance_init(CPUState *cpu)
>   +{
>   +}
>   +
>   +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
>   +{
>   +    return true;
>   +}
>   diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>   index 013f5e852e1..894962d509f 100644
>   --- a/target/ppc/kvm.c
>   +++ b/target/ppc/kvm.c
>   @@ -2354,0 +2355,4 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>   +void kvm_arch_cpu_instance_init(CPUState *cpu)
>   +{
>   +}
>   +
>   diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>   index 2e4f435c537..46730e72a92 100644
>   --- a/target/s390x/kvm/kvm.c
>   +++ b/target/s390x/kvm/kvm.c
>   @@ -2613,0 +2614,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>   +
>   +void kvm_arch_cpu_instance_init(CPUState *cpu)
>   +{
>   +}
>   +
>   +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
>   +{
>   +    return true;
>   +}
> 
> Philippe Mathieu-Daudé (17):
>   target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
>   accel: Remove AccelCPUClass::cpu_class_init()
>   accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
>   accel/hvf: Remove need for AccelCPUClass::cpu_realize
>   accel/kvm: Remove need for AccelCPUClass::cpu_realize
>   accel: Introduce AccelOpsClass::cpu_instance_init handler
>   accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init
>   accel: Remove AccelCPUClass::cpu_instance_init()
>   accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize
>   accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize
>   accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize
>   accel: Remove AccelCPUClass::cpu_target_realize()
>   accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'
> 
>  accel/tcg/tcg-accel-ops.h         |  1 +
>  include/accel/accel-cpu-ops.h     |  3 +-
>  include/accel/accel-cpu-target.h  | 31 --------------
>  include/accel/accel-cpu.h         | 23 -----------
>  include/accel/tcg/cpu-ops.h       |  2 +
>  include/system/hvf_int.h          |  1 +
>  include/system/kvm.h              |  3 ++
>  target/i386/nvmm/nvmm-accel-ops.h |  2 +
>  accel/accel-common.c              | 68 ++++---------------------------
>  accel/hvf/hvf-accel-ops.c         |  3 +-
>  accel/kvm/kvm-accel-ops.c         |  2 +
>  accel/tcg/cpu-exec.c              | 15 ++++++-
>  accel/tcg/tcg-accel-ops.c         |  1 +
>  accel/whpx/whpx-accel-ops.c       |  2 +
>  accel/whpx/whpx-common.c          | 17 --------
>  target/arm/hvf/hvf.c              |  4 ++
>  target/arm/kvm.c                  |  9 ++++
>  target/arm/whpx/whpx-all.c        |  1 -
>  target/i386/hvf/hvf-cpu.c         | 25 ++----------
>  target/i386/hvf/hvf.c             |  5 ---
>  target/i386/kvm/kvm-cpu.c         | 25 +-----------
>  target/i386/nvmm/nvmm-accel-ops.c |  2 +
>  target/i386/nvmm/nvmm-all.c       | 19 +--------
>  target/i386/tcg/tcg-cpu.c         | 28 ++-----------
>  target/i386/whpx/whpx-all.c       |  1 -
>  target/loongarch/kvm/kvm.c        |  9 ++++
>  target/loongarch/tcg/tcg_cpu.c    |  1 -
>  target/ppc/kvm.c                  | 27 +++---------
>  target/riscv/kvm/kvm-cpu.c        | 33 +--------------
>  target/riscv/tcg/tcg-cpu.c        | 28 +++----------
>  target/s390x/kvm/kvm.c            |  9 ++++
>  31 files changed, 95 insertions(+), 305 deletions(-)
>  delete mode 100644 include/accel/accel-cpu-target.h
>  delete mode 100644 include/accel/accel-cpu.h
> 

