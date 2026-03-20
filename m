Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322218DB37;
	Fri, 20 Mar 2026 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773975690; cv=none; b=MAqXgcV4WgKx7r6AozwysADRxpeh+jIbGdeMsP1cRF8c3oSVSWrBCfWXTUVgbWoWXhZOX9AfY1rib7Xh6yaT9cBBeYM5l9tRC0BukmUquzCXS9v8CG2xZNLGklg74m/XgAxwvaK/v6iZSf/q7ic6YTUepqD1NmA2U7heOxDY/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773975690; c=relaxed/simple;
	bh=mKfhNpE6jU7cB40T0n/mgleQ4I5cG+GPuLuZLNrXGPI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tsFjkOABCEVEiRQQ0xH/bp619CLRV+NTgzR7Gbkq00t4vSkEvMFzy0C5TLwCJawzgROea7Gb6FMLvXzGM5UStRNiiI/mcA0YcjOyMNqH/ppzMNGFkXYgZKviqvdBsoL0BjvHumfL0EcYw1OwrA9DMu4o6B2YsVZTBLfgtPuITXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Ax_6mFuLxp6ewcAA--.24298S3;
	Fri, 20 Mar 2026 11:01:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCx+8GEuLxp6BhZAA--.38652S3;
	Fri, 20 Mar 2026 11:01:24 +0800 (CST)
Subject: Re: [PATCH v2 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro
 rather than function
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20260317092911.1400248-1-maobibo@loongson.cn>
 <20260317092911.1400248-4-maobibo@loongson.cn>
 <CAAhV-H5aKoTTdjwzco6Yv84SJgtt0Eq9xXNp6PkcDaxM+H9gZw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <6118cbb5-f895-e04d-7b76-91f9e9ad3b05@loongson.cn>
Date: Fri, 20 Mar 2026 10:58:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5aKoTTdjwzco6Yv84SJgtt0Eq9xXNp6PkcDaxM+H9gZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8GEuLxp6BhZAA--.38652S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1rtFy5tw18GF4UWFWDJrc_yoWrCry8pF
	9rCFnYva18Wa4xua9Ivw4Dur1Yqws7W3Z29a43Ga4rAa1qqr1ktr1vgrWj9FW2q34v9a1I
	qF95Xr4xu3ZIy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
	UUUU=



On 2026/3/19 下午8:48, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, Mar 17, 2026 at 5:29 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> vcpu_is_preempted() is performance sensitive called in function
>> osq_lock(), here set it as macro. So that parameter is not parsed
>> at most time, it can avoid cache line thrashing across numa node.
>>
>> Here is part of unixbench result on 3C5000 DualWay machine with 32
>> Cores and 2 Numa node.
>>            origin    with patch    CONFIG_PARAVIRT disabled
>> execl     6871.9    7134.2        7190.8
>> fstime    425.5     959.9         956.1
>>
>>  From the test result, with macro method it is almost the same with
>> CONFIG_PARAVIRT disabled, and there is some improvment compared with
>> function method.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++-----
>>   arch/loongarch/kernel/paravirt.c       | 15 ++------------
>>   2 files changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
>> index 66244801db67..b5d7a038faf1 100644
>> --- a/arch/loongarch/include/asm/qspinlock.h
>> +++ b/arch/loongarch/include/asm/qspinlock.h
>> @@ -5,8 +5,10 @@
>>   #include <linux/jump_label.h>
>>
>>   #ifdef CONFIG_PARAVIRT
>> -
>> +#include <asm/kvm_para.h>
>>   DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>> +DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
>> +DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>>
>>   #define virt_spin_lock virt_spin_lock
>>
>> @@ -34,10 +36,25 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>          return true;
>>   }
>>
>> -#define vcpu_is_preempted vcpu_is_preempted
>> -
>> -bool vcpu_is_preempted(int cpu);
>> -
>> +/*
>> + * Macro is better than inline function here
>> + * With inline function, parameter cpu is parsed even though it is not used.
>> + * This may cause cache line thrashing across NUMA node.
>> + * With macro method, parameter cpu is parsed only when it is used.
> What is the test result with inline function? If it isn't
> significantly worse than with macro, we usually prefer inline
> functions.
In the beginning, I had the similar thoughts. And inline function is 
better to maintain, however here is obvious performance gap between 
inline and macro method.

Here is part of unixbench result on 3C5000 DualWay machine with 32
Cores and 2 Numa node, based on 7.0.0-rc4 kernel version. 
vcpu_is_preempted() is implemented with different methods.
          origin (function)   inline        macro
execl     7025.7             6991.2        7242.3
fstime    474.6              703.1         1071.1

Regards
Bibo Mao
> 
> 
> 
> Huacai
> 
>> + */
>> +#define vcpu_is_preempted(cpu)                                                 \
>> +({                                                                             \
>> +       bool __val;                                                             \
>> +                                                                               \
>> +       if (!static_branch_unlikely(&virt_preempt_key))                         \
>> +               __val = false;                                                  \
>> +       else {                                                                  \
>> +               struct kvm_steal_time *src;                                     \
>> +               src = &per_cpu(steal_time, cpu);                                \
>> +               __val = !!(READ_ONCE(src->preempted) & KVM_VCPU_PREEMPTED);     \
>> +       }                                                                       \
>> +       __val;                                                                  \
>> +})
>>   #endif /* CONFIG_PARAVIRT */
>>
>>   #include <asm-generic/qspinlock.h>
>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>> index b74fe6db49ab..2d1206e486e2 100644
>> --- a/arch/loongarch/kernel/paravirt.c
>> +++ b/arch/loongarch/kernel/paravirt.c
>> @@ -10,8 +10,8 @@
>>   #include <asm/paravirt.h>
>>
>>   static int has_steal_clock;
>> -static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
>> -static DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>> +DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
>> +DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>>   DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>
>>   static bool steal_acc = true;
>> @@ -261,17 +261,6 @@ static int pv_time_cpu_down_prepare(unsigned int cpu)
>>          return 0;
>>   }
>>
>> -bool vcpu_is_preempted(int cpu)
>> -{
>> -       struct kvm_steal_time *src;
>> -
>> -       if (!static_branch_unlikely(&virt_preempt_key))
>> -               return false;
>> -
>> -       src = &per_cpu(steal_time, cpu);
>> -       return !!(src->preempted & KVM_VCPU_PREEMPTED);
>> -}
>> -EXPORT_SYMBOL(vcpu_is_preempted);
>>   #endif
>>
>>   static void pv_cpu_reboot(void *unused)
>> --
>> 2.39.3
>>

