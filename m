Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33030499A;
	Fri,  8 May 2026 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210354; cv=none; b=HAspxCZKbuitlFWYDvIWLgfIevx0rPse0/trmw887Ep0Qi/URujhDXAubHT6V7PEI/K1eiacmcJ24C3uytYPEoHKZ1cMaJbd/2Mibkmga5z0uKbSEaXNUsRrJnfMSrHTyrEsrhX6fg2lfe0tDKMD2eiyx1bUiLqOJtgO1O44LmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210354; c=relaxed/simple;
	bh=FlfoQ+iUqK/P+mndJSB/WYV+qMqLFhR59Er7adSFt9w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tErKAb/M9EDgoe1uWNG4SulgWJ1SCmd7F01LsJk/gUkMWmvmykMtCkUXJB3blgxxdvvO1d01mSv/lovfPiReYkuJp/3oPTmhrx4KaLXGW41sU9plLFtq1QZns74NG9U8A3WqPhlQS3FCtwcV0Npcz+XNRLyILYfg10FS1DKLHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxJekqVv1pvcIHAA--.18869S3;
	Fri, 08 May 2026 11:19:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxGOAnVv1pMqt8AA--.40415S3;
	Fri, 08 May 2026 11:19:03 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Move some variable declaration to file
 paravirt.h
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260508013001.4107737-1-maobibo@loongson.cn>
 <CAAhV-H6dHM0GBFCh-6-q0fM3VSa49RTXSDz+YUvM0j7u_was1g@mail.gmail.com>
 <3d3bb8ea-34b7-b4da-deac-677ac272dd76@loongson.cn>
 <CAAhV-H44v2TcSAeq+mDiHy26k=mE4ykqjrvPsNurgpw4OhnNTg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <076bc4bc-54da-efb6-b1d4-e5e754bb580a@loongson.cn>
Date: Fri, 8 May 2026 11:16:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H44v2TcSAeq+mDiHy26k=mE4ykqjrvPsNurgpw4OhnNTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxGOAnVv1pMqt8AA--.40415S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1fArWkJr4DCF1fur1fKrX_yoW5KF13pa
	yDAF1kWa18Gr18AF42qFZIgr1Utw4kGr1IqFyUXFyUA39Fqw1kXr4kKryq9Fyqya1ktF40
	gFySgrZxuF1jvwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jYPfQUUUUU=



On 2026/5/8 上午11:11, Huacai Chen wrote:
> On Fri, May 8, 2026 at 11:08 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/5/8 上午10:56, Huacai Chen wrote:
>>> Hi, Bibo,
>>>
>>> On Fri, May 8, 2026 at 9:30 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> Some variables relative with paravirt feature are declared in header file
>>>> asm/qspinlock.h, however this file can be included only when option
>>>> CONFIG_SMP is on. There is compiling warning if CONFIG_SMP is off since
>>>> it is not declared.
>>>>
>>>> Move these variable declaration to header file asm/paravirt.h to avoid
>>>> compiling warning.
>>> Have you reproduced the warning? I cannot reproduce it in my
>>> environment with the config file from lkp report, so I also cannot
>>> confirm whether it is fixed.
>> yes, I can reproduce this and it is fixed. The warning is reported from
>> sparse tool, rather than LLVM.
>>>
>>> Another question:
>>> Is paravirt.h a better place than kvm_para.h?
>> en, here kvm_para.h seems better, will send V2 version in next time.
> Frankly, I don't know the difference between the two files. kvm_para.h
> is kvm specific and paravirt.h is generic? Or kvm_para.h is the
> hypervisor side and paravirt.h is the guest side?
kvm_para.h is shared by hypervisor and guest kernel, paravirt.h is only 
used by guest kernel. And option CONFIG_PARAVIRT is useful with guest 
kernel, CONFIG_PARAVIRT has no much meaning with hypervisor.

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
>>>> Fixes: c43dce6f13fb ("LoongArch: KVM: Make vcpu_is_preempted() as a macro rather than function")
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202605061313.O8Hswm2b-lkp@intel.com/
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/paravirt.h  | 4 ++++
>>>>    arch/loongarch/include/asm/qspinlock.h | 5 +----
>>>>    2 files changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
>>>> index 0111f0ad5f73..dbc64908017f 100644
>>>> --- a/arch/loongarch/include/asm/paravirt.h
>>>> +++ b/arch/loongarch/include/asm/paravirt.h
>>>> @@ -3,6 +3,10 @@
>>>>    #define _ASM_LOONGARCH_PARAVIRT_H
>>>>
>>>>    #ifdef CONFIG_PARAVIRT
>>>> +#include <linux/jump_label.h>
>>>> +DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
>>>> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>> +DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>>>>
>>>>    int __init pv_ipi_init(void);
>>>>    int __init pv_time_init(void);
>>>> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
>>>> index 0ee15b3b3937..fbfc6be82f26 100644
>>>> --- a/arch/loongarch/include/asm/qspinlock.h
>>>> +++ b/arch/loongarch/include/asm/qspinlock.h
>>>> @@ -3,12 +3,9 @@
>>>>    #define _ASM_LOONGARCH_QSPINLOCK_H
>>>>
>>>>    #include <asm/kvm_para.h>
>>>> -#include <linux/jump_label.h>
>>>> +#include <asm/paravirt.h>
>>>>
>>>>    #ifdef CONFIG_PARAVIRT
>>>> -DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
>>>> -DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>> -DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>>>>
>>>>    #define virt_spin_lock virt_spin_lock
>>>>
>>>>
>>>> base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
>>>> --
>>>> 2.39.3
>>>>
>>

