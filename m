Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5373BED74;
	Mon, 30 Mar 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865609; cv=none; b=I/YxyAu+FTQmM17T4ahy/cOwz3/ihBpZ4+92lNEzsm37aqjyOGDN/4ReNKSqVsMYg8JFJHt3v1BpgwzLLxWIsiDdjW9q+DzQvYn8ZGjdtGCjrURa9Hy1dVpqZglQU2/2KCDKJv7wgkW3RcCUG25IoF/c8eBkWonGaEpvKmCmZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865609; c=relaxed/simple;
	bh=02iaw6UdM2pgji2fbxQdTw6RH+O3+yK4hzLaQ0plBWE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lAQnHYSJ3onXsTN1Yg5trmwl6f6WZrHKg7uniDlcEL1V+ckyWhb3u1vfZpdGIhE2Awmw1srPG76AyO2wbdymIV1ytzezcbBkhMueR5KwetbfqXdPN5MSisUCJxu5Csif0Zw5gCSe+kEg1vpbpD81n9sSKJNLFklyYeuiRaYKEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bx28LETMpp3e4fAA--.25013S3;
	Mon, 30 Mar 2026 18:13:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDx6+DATMppZrJgAA--.54687S3;
	Mon, 30 Mar 2026 18:13:22 +0800 (CST)
Subject: Re: [PATCH v2 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro
 rather than function
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20260317092911.1400248-1-maobibo@loongson.cn>
 <20260317092911.1400248-4-maobibo@loongson.cn>
 <CAAhV-H5aKoTTdjwzco6Yv84SJgtt0Eq9xXNp6PkcDaxM+H9gZw@mail.gmail.com>
 <6118cbb5-f895-e04d-7b76-91f9e9ad3b05@loongson.cn>
 <CAAhV-H5J-jaej47xSq6F8_Y6nTSJW3pJ=kd9sTAUxdKegmG+Yw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <ab101f57-39d5-fb3e-f8a7-612838c1fbe5@loongson.cn>
Date: Mon, 30 Mar 2026 18:10:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5J-jaej47xSq6F8_Y6nTSJW3pJ=kd9sTAUxdKegmG+Yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx6+DATMppZrJgAA--.54687S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw4xAw1DZF1kXw1ftr48Zrc_yoW7CrWUpr
	yUCFnYyF48Ww1xG3y2qw4jkrn0vwn7GFn7X3W3Ga4rAa1DtFnrJr1UtrWj9Fy0qw1kKF10
	qF95Xr4xuFyaywcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==



On 2026/3/30 下午6:00, Huacai Chen wrote:
> On Fri, Mar 20, 2026 at 11:01 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/3/19 下午8:48, Huacai Chen wrote:
>>> Hi, Bibo,
>>>
>>> On Tue, Mar 17, 2026 at 5:29 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> vcpu_is_preempted() is performance sensitive called in function
>>>> osq_lock(), here set it as macro. So that parameter is not parsed
>>>> at most time, it can avoid cache line thrashing across numa node.
>>>>
>>>> Here is part of unixbench result on 3C5000 DualWay machine with 32
>>>> Cores and 2 Numa node.
>>>>             origin    with patch    CONFIG_PARAVIRT disabled
>>>> execl     6871.9    7134.2        7190.8
>>>> fstime    425.5     959.9         956.1
>>>>
>>>>   From the test result, with macro method it is almost the same with
>>>> CONFIG_PARAVIRT disabled, and there is some improvment compared with
>>>> function method.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++-----
>>>>    arch/loongarch/kernel/paravirt.c       | 15 ++------------
>>>>    2 files changed, 24 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
>>>> index 66244801db67..b5d7a038faf1 100644
>>>> --- a/arch/loongarch/include/asm/qspinlock.h
>>>> +++ b/arch/loongarch/include/asm/qspinlock.h
>>>> @@ -5,8 +5,10 @@
>>>>    #include <linux/jump_label.h>
>>>>
>>>>    #ifdef CONFIG_PARAVIRT
>>>> -
>>>> +#include <asm/kvm_para.h>
>>>>    DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>> +DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
>>>> +DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>>>>
>>>>    #define virt_spin_lock virt_spin_lock
>>>>
>>>> @@ -34,10 +36,25 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>>>           return true;
>>>>    }
>>>>
>>>> -#define vcpu_is_preempted vcpu_is_preempted
>>>> -
>>>> -bool vcpu_is_preempted(int cpu);
>>>> -
>>>> +/*
>>>> + * Macro is better than inline function here
>>>> + * With inline function, parameter cpu is parsed even though it is not used.
>>>> + * This may cause cache line thrashing across NUMA node.
>>>> + * With macro method, parameter cpu is parsed only when it is used.
>>> What is the test result with inline function? If it isn't
>>> significantly worse than with macro, we usually prefer inline
>>> functions.
>> In the beginning, I had the similar thoughts. And inline function is
>> better to maintain, however here is obvious performance gap between
>> inline and macro method.
> Strange, try __always_inline to replace inline? Maybe inline fails for
> some cases?
__always_inline is the same with inline.

With the following sentences in osq_lock(). With inline method, 
parameter node_cpu(node->prev) will be parsed and put in temp register 
in the beginning before the inline function is called, so that there 
will be one memory access.

And I ask with LLVM guys, they say that LLVM framework does this, not 
LLVM arch specified. inline is different with macro actually.

However with marcro method, parameter node_cpu(node->prev) will not be 
parsed until virt_preempt_key() is set with true.

if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
                                vcpu_is_preempted(node_cpu(node->prev))))

Regards
Bibo Mao
> 
> 
> Huacai
> 
>>
>> Here is part of unixbench result on 3C5000 DualWay machine with 32
>> Cores and 2 Numa node, based on 7.0.0-rc4 kernel version.
>> vcpu_is_preempted() is implemented with different methods.
>>            origin (function)   inline        macro
>> execl     7025.7             6991.2        7242.3
>> fstime    474.6              703.1         1071.1
>>
>> Regards
>> Bibo Mao
>>>
>>>
>>>
>>> Huacai
>>>
>>>> + */
>>>> +#define vcpu_is_preempted(cpu)                                                 \
>>>> +({                                                                             \
>>>> +       bool __val;                                                             \
>>>> +                                                                               \
>>>> +       if (!static_branch_unlikely(&virt_preempt_key))                         \
>>>> +               __val = false;                                                  \
>>>> +       else {                                                                  \
>>>> +               struct kvm_steal_time *src;                                     \
>>>> +               src = &per_cpu(steal_time, cpu);                                \
>>>> +               __val = !!(READ_ONCE(src->preempted) & KVM_VCPU_PREEMPTED);     \
>>>> +       }                                                                       \
>>>> +       __val;                                                                  \
>>>> +})
>>>>    #endif /* CONFIG_PARAVIRT */
>>>>
>>>>    #include <asm-generic/qspinlock.h>
>>>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>>>> index b74fe6db49ab..2d1206e486e2 100644
>>>> --- a/arch/loongarch/kernel/paravirt.c
>>>> +++ b/arch/loongarch/kernel/paravirt.c
>>>> @@ -10,8 +10,8 @@
>>>>    #include <asm/paravirt.h>
>>>>
>>>>    static int has_steal_clock;
>>>> -static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
>>>> -static DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>>>> +DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
>>>> +DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
>>>>    DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>>
>>>>    static bool steal_acc = true;
>>>> @@ -261,17 +261,6 @@ static int pv_time_cpu_down_prepare(unsigned int cpu)
>>>>           return 0;
>>>>    }
>>>>
>>>> -bool vcpu_is_preempted(int cpu)
>>>> -{
>>>> -       struct kvm_steal_time *src;
>>>> -
>>>> -       if (!static_branch_unlikely(&virt_preempt_key))
>>>> -               return false;
>>>> -
>>>> -       src = &per_cpu(steal_time, cpu);
>>>> -       return !!(src->preempted & KVM_VCPU_PREEMPTED);
>>>> -}
>>>> -EXPORT_SYMBOL(vcpu_is_preempted);
>>>>    #endif
>>>>
>>>>    static void pv_cpu_reboot(void *unused)
>>>> --
>>>> 2.39.3
>>>>
>>
>>

