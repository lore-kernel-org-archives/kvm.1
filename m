Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE70B286413;
	Wed, 11 Mar 2026 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210782; cv=none; b=DnoE/GdRQC7+R91NLrDfRCaq5FZwVjIAizIXxqffbAm43JwqffV1rgt323gBRuSqhGwJY45gpxexI0Xh3s2MO0w2OF5us0EglhA7W88siRVAJ0LciZP9lIgs73g/3/mnX4o6JpyiQ/sIFbSxaBf+j7gIjeS6cBGwWthWZncJzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210782; c=relaxed/simple;
	bh=aP6NhZCXPpqc4cLW3SXt7kyLB0qbx8EGs0tig7xe0og=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TVBKERb283yrS2SIX8caIgWmnzA+3DUKgf62ekQUoFnZaaG9d6VgY4a74joFzuIi55SzEVfz+cUVJ+xymfkqw9SGyTbwt6wu+tXzO5awzniVg5W2RgPWaHyS0CsI+oZ7MhnkULHSSAg4m3DrsolMbkjf8ES27xIBdpMpFTvVf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxccCQDLFpX9IZAA--.16705S3;
	Wed, 11 Mar 2026 14:32:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxKMGNDLFp28hSAA--.13658S3;
	Wed, 11 Mar 2026 14:32:47 +0800 (CST)
Subject: Re: [PATCH 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro rather
 than function
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20260311031857.3591470-1-maobibo@loongson.cn>
 <20260311031857.3591470-4-maobibo@loongson.cn>
 <CAAhV-H6p=bArdYHkE-0s55Ogvm+Dtv8TVVCLAHGeqA-pnPOXwA@mail.gmail.com>
 <7f4c6ef8-b24f-88c5-82f2-e00d1629ae4c@loongson.cn>
 <CAAhV-H499qApb0sW-HcyrHQS1Sn2gDp9jHVFahNz-u0GoLCLng@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <a72cefd7-8da3-043b-67d2-39ff43f1934b@loongson.cn>
Date: Wed, 11 Mar 2026 14:30:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H499qApb0sW-HcyrHQS1Sn2gDp9jHVFahNz-u0GoLCLng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMGNDLFp28hSAA--.13658S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4kCFWDJF48JFyDXF1DJwc_yoW7JF1kpF
	y7CFnYya18Wr1xXw42qw4q9r98t397GFn7XFy7Ja4rAw4DtFnrJr10vryj9Fy0qw1kWF10
	qFn5WFW7WFyaywbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
	DUUUU



On 2026/3/11 下午12:38, Huacai Chen wrote:
> On Wed, Mar 11, 2026 at 11:51 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/3/11 上午11:35, Huacai Chen wrote:
>>> Hi, Bibo,
>>>
>>> On Wed, Mar 11, 2026 at 11:21 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> vcpu_is_preempted() is performance sensitive called in function
>>>> osq_lock(), here set it as macro. So that parameter is not parsed
>>>> at most time, it can avoid cache line thrashing across numa node.
>>> I remember that I had suggested you define vcpu_is_preempted() in the
>>> header file but you refused.
>> yes, I refuse then, that is a tragedy, I am sorry for that:(
>>
>> By some benchmarks, vcpu_is_preempted() is called in busy-loop method,
>> more obvious with more CPUs, it may be a bottleneck.
> I also remember that you said the static key and percpu steal_time
> structure should be EXPORT_SYMBOL, but you haven't done this patch.
Currently API vcpu_is_preempted() and its caller owner_on_cpu() is only 
used on files in kernel/locking/mutex.c, rwsem.c etc, it seems that it 
is only used by kernel. And there is no obvious signals for module usage 
with this API.

So I do not want to export the symbol this time, will export the symbol 
if there is actually usage for modules.

Regards
Bibo Mao
> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>
>>>
>>> Huacai
>>>
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
>>>> index 66244801db67..305afd37cdcb 100644
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
>>>> + */
>>>> +#define vcpu_is_preempted(cpu)                                         \
>>>> +({                                                                     \
>>>> +       bool __val;                                                     \
>>>> +                                                                       \
>>>> +       if (!static_branch_unlikely(&virt_preempt_key))                 \
>>>> +               __val = false;                                          \
>>>> +       else {                                                          \
>>>> +               struct kvm_steal_time *src;                             \
>>>> +               src = &per_cpu(steal_time, cpu);                        \
>>>> +               __val = !!(src->preempted & KVM_VCPU_PREEMPTED);        \
>>>> +       }                                                               \
>>>> +       __val;                                                          \
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
>>>>
>>
>>

