Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05FB81AA8;
	Tue,  1 Sep 2026 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226324; cv=none; b=sDjOfqyD6zMaFC13YHdVNpCIXAOemSin4KeIa582WzNpW3lgdBltA1hQQyhGyDp6Hcf0USC7xwWQ+xfjjzkE0zh5Q06Aivn3EP9TDtVyhnPI9OEUiradLRWjgihrMQhMDQW71lhsSIRq4O7d/gZWClGg81aUkSYT+xjQUbz/IvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226324; c=relaxed/simple;
	bh=SReFs3wf1VhykduuIf4GG9P8IgQwlFLj17mCrBt8usc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pELM8SUhRTnWQyQWFOg5v33DNHFbAgdoXopfYGnhzMeNzzOvG9NgwBY2FJbSa83YBKiWIgWxHWLrPP3qwpz1FU+S5CfVQe+Zt7e0locNJaPE1edSpC+cwcpmcvne2agy2lWWtwJ8wIliELUYSWiS3FOgUZl/EeywDMwLYxQGwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bxb9MQK5ZqEDgHAA--.20308S3;
	Tue, 01 Sep 2026 09:32:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAx2c0OK5ZqwpUYAA--.51990S2;
	Tue, 01 Sep 2026 09:31:58 +0800 (CST)
Subject: Re: [PATCH v3] LoongArch: KVM: Fix TOCTOU race on pv_features
To: Huacai Chen <chenhuacai@kernel.org>, Tao Cui <cui.tao@linux.dev>
Cc: zhaotianrui@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260814094738.2552440-1-cui.tao@linux.dev>
 <CAAhV-H73i_hH75rNL_eKQWrxu3HTWhMgJpbkYqueoc4qb97TXQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5a94c1f2-899a-f7b4-1757-615acfc40db0@loongson.cn>
Date: Tue, 1 Sep 2026 09:31:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H73i_hH75rNL_eKQWrxu3HTWhMgJpbkYqueoc4qb97TXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx2c0OK5ZqwpUYAA--.51990S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1kAFWxXFy5Aw1kWFWUZFc_yoW5CF45pr
	9ruFn5Gr4rKr1IyFyqqwnF9rWjvw48Gr12vF9Iqa4UAF1Y9r9xXr10krZruFyqqw4rWa1v
	qF1fJas0vF15tacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2026/8/31 下午10:07, Huacai Chen wrote:
> Hi, Bibo,
> 
> What do you think about this?
Thanks for your reminder, I forget this in flooding mailing list :(
It looks good to me.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> 
> 
> Huacai
> 
> On Fri, Aug 14, 2026 at 5:47 PM Tao Cui <cui.tao@linux.dev> wrote:
>>
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> The check-then-set on kvm->arch.pv_features in
>> kvm_loongarch_cpucfg_set_attr() is lockless, so two vCPUs can race
>> past the validation and set different values.  Add a spinlock to
>> serialize it.
>>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>
>> Changes in v2: use a spinlock instead of a cmpxchg loop (Bibo Mao).
>> Changes in v3: rename the lock to pv_setting_lock and place it next to
>> phyid_map_lock (Huacai Chen).
>>
>> v1: https://lore.kernel.org/all/20260810081321.157258-1-cui.tao@linux.dev/
>> v2: https://lore.kernel.org/all/20260813232542.2098930-1-cui.tao@linux.dev/
>>
>>   arch/loongarch/include/asm/kvm_host.h | 1 +
>>   arch/loongarch/kvm/vcpu.c             | 6 +++++-
>>   arch/loongarch/kvm/vm.c               | 1 +
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>> index 23cfbecebbd7..3538a199aac6 100644
>> --- a/arch/loongarch/include/asm/kvm_host.h
>> +++ b/arch/loongarch/include/asm/kvm_host.h
>> @@ -125,6 +125,7 @@ struct kvm_arch {
>>          unsigned int  pte_shifts[MAX_PGTABLE_LEVELS];
>>          unsigned int  root_level;
>>          spinlock_t    phyid_map_lock;
>> +       spinlock_t    pv_setting_lock;
>>          struct kvm_phyid_map  *phyid_map;
>>          /* Enabled PV features */
>>          unsigned long pv_features;
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 20c207d80e31..e47fa463a8be 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -1165,10 +1165,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>>                          return -EINVAL;
>>
>>                  /* All vCPUs need set the same PV features */
>> +               spin_lock(&kvm->arch.pv_setting_lock);
>>                  if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
>> -                               && ((kvm->arch.pv_features & valid) != val))
>> +                               && ((kvm->arch.pv_features & valid) != val)) {
>> +                       spin_unlock(&kvm->arch.pv_setting_lock);
>>                          return -EINVAL;
>> +               }
>>                  kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
>> +               spin_unlock(&kvm->arch.pv_setting_lock);
>>                  return 0;
>>          default:
>>                  return -ENXIO;
>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>> index 1317c718f896..86ba7d54e81f 100644
>> --- a/arch/loongarch/kvm/vm.c
>> +++ b/arch/loongarch/kvm/vm.c
>> @@ -76,6 +76,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>                  return -ENOMEM;
>>          }
>>          spin_lock_init(&kvm->arch.phyid_map_lock);
>> +       spin_lock_init(&kvm->arch.pv_setting_lock);
>>
>>          kvm_init_vmcs(kvm);
>>          kvm_vm_init_features(kvm);
>> --
>> 2.43.0
>>

