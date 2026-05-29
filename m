Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FD423A8A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080640; cv=none; b=dygCikj5cIM5C9uPufvU2vK7c3jBIiCXw/CR9L4pOkVHBFvnMxBmg8kPVwtFovwb9CR03l4CiKsFx6WPlphIRuA7JghMLmEhdtTjgEDYvdkyMes0MzLagJv9VncYmMASey7QP8P1QzB5u05C0IrmHIKXQIrA3RRxDdc3rXKCJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080640; c=relaxed/simple;
	bh=3X//CwxZ7zaGq724Jhyg00cgvm5BYFTxuSDpoYV/p+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gr2MXTr/ZJmI4ZbsgBciXDQy5G1OD4v8qJubQVEdcP3WFiRpC/vgOFW5RwcNEBwpYaF28H/UOUUiEtpgxS3h95HTnyNKD5ohip/paxo7xOKsOBs7mY2gxLlYKweEsX62cad7eeldJ/WrtxMYmH22w+CcT3aohQPy+2lDbowmqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UiUuQjJj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiUuQjJj"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-459bf19e87bso8623368f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780080635; x=1780685435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXMhvEAYwVRlDEFfz0OuKhaYVQQQz+XTG6U4wXgza14=;
        b=UiUuQjJj7a92B9ubZgLLej0IbG6Y/7VNsbg3rMeBIGHVwMaT1hviPu7myON7KP1753
         lKdoONOqd+cCKHSxlw9x7ydfteQgQkyfT/dzcJSL34j3rP7dhMzCjTAfTTA7pEOZON1m
         LLFx++89qF8QUTRnJZsKVqFNdI1zukPbgj7o4LzpDipoyPWQHE3Pg/m6j7zkcZoB+mOx
         6djZ7GcQGcNdRcgqpiEiAUo75PiHiwXKNdujcvJ+BnX/c+ABPC+85CqwWMeR1IFY/rMu
         sWqA+0/+yN2ScM0j3YXkVtz/7B9+06zNGMCAp3XwIsYGRVsU6lDSNEZPIYH/CJsSKfd0
         vwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080635; x=1780685435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXMhvEAYwVRlDEFfz0OuKhaYVQQQz+XTG6U4wXgza14=;
        b=gDvoBUubyIFfff2qaX27CFuCeL0kkf7mjuj/IhazBjNfYunGH+aEM8TFaM1Mlv4JGA
         CxLOu/444JKNLZ8gy95AfN4GEHqoO6eavksWL8asEPeKHPEPkKcQ8WnqMYOnsbg9lgCN
         wsL2cj6Urpo8O5E+9POMtM23ZN6FOeRjmGvEq7dqVWNQSsavg62Z97bn9WB3g+45srz4
         DSSf5uGPjBGAINo7MrEROxfYZtvYUW+NF9ULqwVV7//JpkqOFhellGF2861CBH4GuYrv
         jcMEzNWilrvUrfqf/pYpys898Xe7bk+J4sx1mhtbzcvXBOohfHfiIZ3KUqdk8fBqTO/R
         Ai5w==
X-Forwarded-Encrypted: i=1; AFNElJ8Ohug81FKGe+S+9/3iBFBrobbIhcRoKE+R/+oraokOQD4D9vaz690kjrKF5D6x6nvYO3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWu1Kq7bwo98fyfijFxVIzBSMLpd0DBF36wH1RbHY/cWYisxB
	xyY619pvEuV/4awnT1rQ8ILx5pxKfC/Rwi0ZRS4Es589fwgs5tTGVXY1Jh89zHxSkfM=
X-Gm-Gg: Acq92OFWRFWHd2JydxtV/oKuOXBHhIdkOwp/gDAAZr1Q4KexyKaA0Zib5GZIihqUT4B
	e5stJOYbbKriobun3Jfl+8AJDrWuDPV1UdiSOEXE/uFGl2eHS/PwoxO8cyPccjNKmmyiM++JSSR
	KQ35VKvBKpWdZGHYWXc/pF05XsMcusadwNTWDjjTDfZB4Ii/KREhR6ARudLHyM72dfCqD9msrt9
	d63Jcnv3RLMI/9okE81NQMUMFz7irQYdX6yVa0PHEObqSEUBKSmzdLnY5yD8HFomSko5QlvndSU
	sOgSqOUhnaONbdGYXvi9JQhRrfYsNyGGa7qHj2l+eykURR0quNRjkAL8eZa0d82s0EmPBjmb2Bp
	OuydwDWEy1VtRWyWICixfo+Ck1fVyJN26KHiAdocpxV0OJqbF861Eq3mn9umlhY3Kr8v+YIbb/y
	nZatfS42K9hpqkVRJYmo3bxKy9mCDmPfQVtUS0Utq825sDPm5SRhkaySXq0NuK1TdFPJJjRUbKG
	y1r
X-Received: by 2002:a5d:598d:0:b0:45e:a19f:22c1 with SMTP id ffacd0b85a97d-45ef6b19af3mr1988327f8f.15.1780080634677;
        Fri, 29 May 2026 11:50:34 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a065esm5750714f8f.5.2026.05.29.11.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:50:33 -0700 (PDT)
Message-ID: <415ce99a-4f43-4ad4-b5f4-9839e74a62ea@linaro.org>
Date: Fri, 29 May 2026 20:50:24 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] accel/kvm: Remove need for
 AccelCPUClass::cpu_target_realize
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Nicholas Piggin <npiggin@gmail.com>,
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
 <d85a57cd-0f90-4930-9bd7-1f29c2526a25@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d85a57cd-0f90-4930-9bd7-1f29c2526a25@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/5/26 20:35, Pierrick Bouvier wrote:
> On 5/29/2026 11:32 AM, Pierrick Bouvier wrote:
>> On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
>>> accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
>>> then ops->cpu_realize.
>>>
>>> Rather than having one handler for each host architecture, use a
>>> single host-specific method (prefixed with kvm_arch_* like other
>>> similar KVM methods). Register it once as AccelOpsClass
>>> cpu_target_realize handler.
>>>
>>> PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/system/kvm.h       |  2 ++
>>>   accel/kvm/kvm-accel-ops.c  |  1 +
>>>   target/i386/kvm/kvm-cpu.c  |  3 +--
>>>   target/ppc/kvm.c           | 23 +----------------------
>>>   target/riscv/kvm/kvm-cpu.c | 10 +---------
>>>   5 files changed, 6 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>> index 5fa33eddda3..fd7175ea9f5 100644
>>> --- a/include/system/kvm.h
>>> +++ b/include/system/kvm.h
>>> @@ -364,6 +364,8 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
>>>   int kvm_arch_init_vcpu(CPUState *cpu);
>>>   int kvm_arch_destroy_vcpu(CPUState *cpu);
>>>   
>>> +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>>> +
>>>   #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
>>>   void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
>>>   #else
>>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>>> index 6d9140e549f..4294c7a9514 100644
>>> --- a/accel/kvm/kvm-accel-ops.c
>>> +++ b/accel/kvm/kvm-accel-ops.c
>>> @@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>>>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>>>   
>>>       ops->create_vcpu_thread = kvm_start_vcpu_thread;
>>> +    ops->cpu_target_realize = kvm_arch_cpu_realize;
>>
>> cpu_realize
> 
> Ignore, I was wrong, confused that with AccelCPUClass.

No, you are right.

> 
>>
>>>       ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
>>>       ops->cpus_are_resettable = kvm_cpus_are_resettable;
>>>       ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
>>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>>> index c34d9f15c7e..36634ec8929 100644
>>> --- a/target/i386/kvm/kvm-cpu.c
>>> +++ b/target/i386/kvm/kvm-cpu.c
>>> @@ -39,7 +39,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
>>>       }
>>>   }
>>>   
>>> -static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>>   {
>>>       X86CPU *cpu = X86_CPU(cs);
>>>       X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>>> @@ -237,7 +237,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>>   {
>>>       AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>>   
>>> -    acc->cpu_target_realize = kvm_cpu_realizefn;
>>>       acc->cpu_instance_init = kvm_cpu_instance_init;
>>>   }
>>>   static const TypeInfo kvm_cpu_accel_type_info = {
>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>> index b94c2997a07..013f5e852e1 100644
>>> --- a/target/ppc/kvm.c
>>> +++ b/target/ppc/kvm.c
>>> @@ -49,7 +49,6 @@
>>>   #include "elf.h"
>>>   #include "system/kvm_int.h"
>>>   #include "system/kvm.h"
>>> -#include "accel/accel-cpu-target.h"
>>>   
>>>   #include CONFIG_DEVICES
>>>   
>>> @@ -2353,7 +2352,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>>>       }
>>>   }
>>>   
>>> -static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
>>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>>   {
>>>       int ret;
>>>       const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
>>> @@ -2995,23 +2994,3 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>>>   void kvm_arch_accel_class_init(ObjectClass *oc)
>>>   {
>>>   }
>>> -
>>> -static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>> -{
>>> -    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>> -
>>> -    acc->cpu_target_realize = kvmppc_cpu_realize;
>>> -}
>>> -
>>> -static const TypeInfo kvm_cpu_accel_type_info = {
>>> -    .name = ACCEL_CPU_NAME("kvm"),
>>> -
>>> -    .parent = TYPE_ACCEL_CPU,
>>> -    .class_init = kvm_cpu_accel_class_init,
>>> -    .abstract = true,
>>> -};
>>> -static void kvm_cpu_accel_register_types(void)
>>> -{
>>> -    type_register_static(&kvm_cpu_accel_type_info);
>>> -}
>>> -type_init(kvm_cpu_accel_register_types);
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index 17ba38403a3..7c4440d0025 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -1990,14 +1990,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>>>       kvm_riscv_add_cpu_user_properties(obj);
>>>   }
>>>   
>>> -/*
>>> - * We'll get here via the following path:
>>> - *
>>> - * riscv_cpu_realize()
>>> - *   -> cpu_exec_realizefn()
>>> - *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
>>> - */
>>> -static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>>   {
>>>       RISCVCPU *cpu = RISCV_CPU(cs);
>>>       int ret;
>>> @@ -2120,7 +2113,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>>       AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>>   
>>>       acc->cpu_instance_init = kvm_cpu_instance_init;
>>> -    acc->cpu_target_realize = kvm_cpu_realize;
>>>   }
>>>   
>>>   static const TypeInfo kvm_cpu_accel_type_info = {
>>
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Regards,
>> Pierrick
> 

