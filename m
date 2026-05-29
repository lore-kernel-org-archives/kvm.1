Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051540963C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079729; cv=none; b=B/jWR2PZn+EVhpAPW7FQX4kBlvjXNdIRKrHINKJq3yU8lGMMm7jolS4X7qCpq+nz6lqo8Cw73IDt+fsX8nxvjb+0QcQDb6vsidM8j5zcldOYAP2PKAxrmfOFXWmxvmzMWDoZzXwRKhBfzxA/2k9ubCWwtFwpYU7cUDnLGUuU3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079729; c=relaxed/simple;
	bh=VoLjx81WDEN+2GxgYWBhcOoalsmwJuM3HrY92aH3+BA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=abppg/BZuvL/X7h9a7eqbdtVwZQOYSyl5NozGaF20dd6oANnUZCKKQ9qrS8GdEqoJLlESJnRt3ikxmhykMsch4yqGv4KkS2CQwM19Mz1ZXzNvGb0UDLuqS9y9ADIGeqJmZRdhS7pPuE+btl/QOqiz61ElkZd3MZtuX2cnATJTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jexp0ArB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LOlizQxV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jexp0ArB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LOlizQxV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TIQe60877141
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UCcuDhd/yYEud3f9ZIoVNZvSDJ2OwXA/S56pjq8bWkY=; b=Jexp0ArBlLbAzrhu
	/TrmzAj8kVFtwkyP2ij2V4EIGWIzHIxxETvfXsYww/f0C1rQY6FzaJHT3Mnpjff5
	c+VQDMuoCfcKBCmCYYo0TX21gJAsam8Rlyc72FgTy342+p0u1NGiyjgL0KJFcHZf
	Eokfy9MgL6S2Zmtm4oR+CJYs26yLo3T0KAPjR0g6gKWOjGrlFDAMNOD841VgT1Ab
	aHXGxffz7WgoOyobqR7HPKm6LTGVVzWTu21mcGK21MpgamUh96X80MwNyjs/xFq/
	NPyePIJKM5bcFa56opOgxBpt5z/S3RCTmAr9QHFgCBAluDraVktFtT405FXs9Fxj
	Cw83uA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg340285-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:35:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304d8e9563eso507454eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079722; x=1780684522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UCcuDhd/yYEud3f9ZIoVNZvSDJ2OwXA/S56pjq8bWkY=;
        b=LOlizQxVgpQgRb/vbS443ZEzOHtTI51AgV1urnDm5U8L0491O3a8iTJRgkbeKbXWxp
         O0zKq0yr+ZEmeg2LmgEbTz80NKIqbPyz4ceMmpYdkl049LfVytgqgziVW06r1dZ0Xpoh
         7GxlcVPDYUS63GZLX4mZNyuQ9Tsp5Hs6eplM1LGPOHKTx6m5RfJvwWWKZHbeFGbtHlWz
         i93Zq+mo4bAUZ/rvpxzid+bD+0M/BKpg1cheKB2B1kjuiJAvpbq329VDDGBE1laoSpax
         C2bSYpKPYB/IAIJYZ5LeAlxTM+8yQTjyuzBjNItJBJVeDzdFHAEvOclB1GgHq92cEBGg
         kHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079722; x=1780684522;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCcuDhd/yYEud3f9ZIoVNZvSDJ2OwXA/S56pjq8bWkY=;
        b=GC75vvMuk5Vlj7dPd3twgUvBBFPiX1rI+AJnqDiwcgXlvmDx7+Dw7ajILmvp9P0dd5
         LulkMRHJkW9x9oIIP/ySMDfNzIdI3KS+Z7/W6GkuslcJEvJ03eraDrELewRF3Ku6aDFp
         qF7hWPjPPR0vmCLxRTAlek8SxLMMsZAnVmDP801gX6Om+m0HLvp5HbUL2AEnYBIS/Eu2
         vhYl14b9fnbHZwGgL727DOONKQZWxpVr/8GrCH7QzuTJRwES3QzIq6iKVaWp70J6TlBR
         hztiO3rn/KhbGOVGybAvk+nZv7KvJyl0mjzabLHi5UnuZBm1Orv6lt7KQiecS+PSM6WR
         9K8w==
X-Forwarded-Encrypted: i=1; AFNElJ+FC7oAVWtLwjt6Yxl+rFWr7BgehZwPazv26O0IOJbMmTWIYN2T3DOXggIjx0p6Wf2iHS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNFKKH0HwJX9gkyMTQ7IrIEDb8Ku1idwG2mdRKEgqamUoGTgP
	ezj/byVc3TxJ3hUy177A6IKeDj6qovv6FQipeKk8BjO/vhLjZEBhV6b3PJbGs/qhTjqBwrZWAFw
	I4M4np5YO+TiCrimvE/YyzlVq9q3tCGnGRCUVUDsup87DvNyfeNUvisk=
X-Gm-Gg: Acq92OHJF8/Nf7dry+UmuCNzfFcnhUiTh3TEJhmlwz5fMO5MuKWxfpg2xBBIGxq4szO
	LO0X0ckBmmvCebNdam1q/rQOHCEl2Bswb+HfsCGPxnfX0uEJVcwPtZYyYuGCGOpupkzqHJz5Hg/
	RL9WL9+HMHksafs6cp2z026OTothFY8RzgRKHEMD88ZvYJVZv3KNJW2y15ybilgejuGWYPrwKYV
	x1Es6bTkwVdo/hr0OdYbwVmUNTJ026jRWIw649TkQFeLB6K0IvmA2RtAh28WfWCehLGiq9n66q+
	TT0k4XsoOwxuk+jC3r43v/uAUBOTXCcsIhyLl2Do30AxurlUAu0XXJapVliQjqt+Vx59/CYS9ET
	syTm9KqM/740cr1xOwKjd808YBTF0vgeAhkWyYr4KId8v3weIs04u7Ql0DUwWJfaedtXdMGywc1
	nU64GSqJa1pZCc7IpJ7BOq4I/C
X-Received: by 2002:a05:7300:7495:b0:2db:2089:460f with SMTP id 5a478bee46e88-304fa5eb2e3mr516705eec.19.1780079722116;
        Fri, 29 May 2026 11:35:22 -0700 (PDT)
X-Received: by 2002:a05:7300:7495:b0:2db:2089:460f with SMTP id 5a478bee46e88-304fa5eb2e3mr516664eec.19.1780079721461;
        Fri, 29 May 2026 11:35:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed130dafsm1975612eec.0.2026.05.29.11.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:35:20 -0700 (PDT)
Message-ID: <d85a57cd-0f90-4930-9bd7-1f29c2526a25@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:35:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] accel/kvm: Remove need for
 AccelCPUClass::cpu_target_realize
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 <20260529142434.87880-6-philmd@linaro.org>
 <179357ae-8d50-49e5-abc5-8abf670be847@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179357ae-8d50-49e5-abc5-8abf670be847@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xMdxt3quQsIv4CoLc3WK_rAYxlJQbuTV
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a19dc6b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kOTYBn2Tj0T_yd3JnKoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xMdxt3quQsIv4CoLc3WK_rAYxlJQbuTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NSBTYWx0ZWRfX+CiBInT6rWxI
 saz3pExvD8Pu15WRiNn1IZnMG/OhnuwMNeNbXA96Wdy3PKOJJ0LntGhnEgNSiD5DPuNO56Dg476
 Ebmlm704F3J80P3wD1iHjfsxGfqNGPrj7X6xXAkEH9ARCdlACr3xy5ktogp02fiHDObkN58t+0v
 4Gru6eM/WJavRPAF51J1WlNJwYhaaX9IwGxIfkiTKW2lPlgEqsEFAU0YyaDEw1LPphmgmdy25TK
 Do5z3r/SczvqLZvSLWW0/Jl5I46o8Knnn8GB3sE8zq8tV+Ra+juMEvBdI5gGu7PJLwmr8zU9vSX
 1gJ5jFUORLf1UQ3cN4kIsrnvaYfuPcHmqF4BE9nAwKNwxRKCd/9CMshGzsndesqneDqC6FMUnIE
 eBeh3Qv0ybqym3YMcvtNN+y5ZC0MhBOnkK6DMCCdbGONF3V0JfS/i++eLsMi4zdUmxPOs8XUZDK
 p64E+Hl1imkN7cWOIZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290185

On 5/29/2026 11:32 AM, Pierrick Bouvier wrote:
> On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
>> accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
>> then ops->cpu_realize.
>>
>> Rather than having one handler for each host architecture, use a
>> single host-specific method (prefixed with kvm_arch_* like other
>> similar KVM methods). Register it once as AccelOpsClass
>> cpu_target_realize handler.
>>
>> PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>  include/system/kvm.h       |  2 ++
>>  accel/kvm/kvm-accel-ops.c  |  1 +
>>  target/i386/kvm/kvm-cpu.c  |  3 +--
>>  target/ppc/kvm.c           | 23 +----------------------
>>  target/riscv/kvm/kvm-cpu.c | 10 +---------
>>  5 files changed, 6 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>> index 5fa33eddda3..fd7175ea9f5 100644
>> --- a/include/system/kvm.h
>> +++ b/include/system/kvm.h
>> @@ -364,6 +364,8 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
>>  int kvm_arch_init_vcpu(CPUState *cpu);
>>  int kvm_arch_destroy_vcpu(CPUState *cpu);
>>  
>> +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>> +
>>  #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
>>  void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
>>  #else
>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>> index 6d9140e549f..4294c7a9514 100644
>> --- a/accel/kvm/kvm-accel-ops.c
>> +++ b/accel/kvm/kvm-accel-ops.c
>> @@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>>      AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>>  
>>      ops->create_vcpu_thread = kvm_start_vcpu_thread;
>> +    ops->cpu_target_realize = kvm_arch_cpu_realize;
> 
> cpu_realize

Ignore, I was wrong, confused that with AccelCPUClass.

> 
>>      ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
>>      ops->cpus_are_resettable = kvm_cpus_are_resettable;
>>      ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>> index c34d9f15c7e..36634ec8929 100644
>> --- a/target/i386/kvm/kvm-cpu.c
>> +++ b/target/i386/kvm/kvm-cpu.c
>> @@ -39,7 +39,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
>>      }
>>  }
>>  
>> -static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>  {
>>      X86CPU *cpu = X86_CPU(cs);
>>      X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>> @@ -237,7 +237,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>  {
>>      AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>  
>> -    acc->cpu_target_realize = kvm_cpu_realizefn;
>>      acc->cpu_instance_init = kvm_cpu_instance_init;
>>  }
>>  static const TypeInfo kvm_cpu_accel_type_info = {
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index b94c2997a07..013f5e852e1 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -49,7 +49,6 @@
>>  #include "elf.h"
>>  #include "system/kvm_int.h"
>>  #include "system/kvm.h"
>> -#include "accel/accel-cpu-target.h"
>>  
>>  #include CONFIG_DEVICES
>>  
>> @@ -2353,7 +2352,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>>      }
>>  }
>>  
>> -static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>  {
>>      int ret;
>>      const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
>> @@ -2995,23 +2994,3 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>>  void kvm_arch_accel_class_init(ObjectClass *oc)
>>  {
>>  }
>> -
>> -static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>> -{
>> -    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>> -
>> -    acc->cpu_target_realize = kvmppc_cpu_realize;
>> -}
>> -
>> -static const TypeInfo kvm_cpu_accel_type_info = {
>> -    .name = ACCEL_CPU_NAME("kvm"),
>> -
>> -    .parent = TYPE_ACCEL_CPU,
>> -    .class_init = kvm_cpu_accel_class_init,
>> -    .abstract = true,
>> -};
>> -static void kvm_cpu_accel_register_types(void)
>> -{
>> -    type_register_static(&kvm_cpu_accel_type_info);
>> -}
>> -type_init(kvm_cpu_accel_register_types);
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 17ba38403a3..7c4440d0025 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1990,14 +1990,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>>      kvm_riscv_add_cpu_user_properties(obj);
>>  }
>>  
>> -/*
>> - * We'll get here via the following path:
>> - *
>> - * riscv_cpu_realize()
>> - *   -> cpu_exec_realizefn()
>> - *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
>> - */
>> -static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>  {
>>      RISCVCPU *cpu = RISCV_CPU(cs);
>>      int ret;
>> @@ -2120,7 +2113,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>      AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>  
>>      acc->cpu_instance_init = kvm_cpu_instance_init;
>> -    acc->cpu_target_realize = kvm_cpu_realize;
>>  }
>>  
>>  static const TypeInfo kvm_cpu_accel_type_info = {
> 
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Regards,
> Pierrick

