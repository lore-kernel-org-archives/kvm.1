Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C25361DAD;
	Wed, 30 Sep 2026 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734478; cv=none; b=PVGPBnN3w2XozcMVH83RpYnduzdKBQhh6+vb+ugCCKwT3CBkUxBHoEWj7DaY0gzPpqCZ76eDTCYfBUKd9clg4zjquiCLsRRu3h+zHphyePOZYPqXjggBBN1C3xRBDSff/ZXdsc7nUTmSQQiEKdGPrJby55fYuj7THZak7x86Bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734478; c=relaxed/simple;
	bh=gm7s9UPTHND2+HomYLE+IuFQ6JOBsyJ37RVyfNq9y3I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JnCt8ZQqwNfNLMatAi9e9P/SdwVrR3ZqYabB7xToiPS8RAXyXVZrPmd7YsRA+rpWewF5VSzCLjAYwG+dZRmQZaiJbsfzHIb8NOVBEDNNeri2iQffQiiz5A93mJ4uOP3fADipkBOPyBDQ8frDqCJVbXy9yGN5mrlz2UTYhaHedrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bx69GKcLxqmjMRAA--.50079S3;
	Wed, 30 Sep 2026 10:14:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCx9cyEcLxq888mAA--.54465S2;
	Wed, 30 Sep 2026 10:14:30 +0800 (CST)
Subject: Re: [PATCH v2 2/4] LoongArch: KVM: Load dmsintc pointer once in
 pch_msi_set_irq
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn,
 zhaotianrui@loongson.cn, loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260929102821.36112-1-cui.tao@linux.dev>
 <20260929102821.36112-3-cui.tao@linux.dev>
 <6bc45b7c-88d8-f134-426a-b556fb867b41@loongson.cn>
 <CAAhV-H5cBHvpJa0vgGqapQfeoUyVz2N6zW_DgTcCqwuuG7Utkw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f8ccaf5f-46b8-392c-d56e-6dc3be5fa3b8@loongson.cn>
Date: Wed, 30 Sep 2026 10:15:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5cBHvpJa0vgGqapQfeoUyVz2N6zW_DgTcCqwuuG7Utkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx9cyEcLxq888mAA--.54465S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF13Jw1DZF47ZF47CFWUJrc_yoW5tw4kpr
	W7Can09rW8XryUA392ga4q9r1Iyrn7Wr13Wry29FyjkFn0qr13tFy8J347uF98Wa1UGr40
	q3W3Ga4SvF1UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU



On 2026/9/30 上午10:08, Huacai Chen wrote:
> On Wed, Sep 30, 2026 at 9:41 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/9/29 下午6:28, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> pch_msi_set_irq() reads kvm->arch.dmsintc several times: the non-NULL
>>> check and the address-window comparison each reload the pointer, so a
>>> concurrent device removal can be observed between them and the
>>> following dereference hits a freed object.
>>>
>>> Load the pointer once at the top of pch_msi_set_irq() and add a NULL
>>> check with a local snapshot in dmsintc_set_irq().  Both loads use
>>> READ_ONCE() so the compiler keeps them single.  This closes the
>>> reload race; a narrower window where removal happens right after the
>>> load remains, as the injection path takes no lock against destroy.
>>>
>>> Fixes: 03de5eecb0f0 ("LoongArch: KVM: Add DMSINTC inject msi to vCPU")
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>> ---
>>>    arch/loongarch/kvm/intc/dmsintc.c | 6 +++++-
>>>    arch/loongarch/kvm/intc/pch_pic.c | 7 ++++---
>>>    2 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
>>> index 41c8b597b5bd..91a163698c3c 100644
>>> --- a/arch/loongarch/kvm/intc/dmsintc.c
>>> +++ b/arch/loongarch/kvm/intc/dmsintc.c
>>> @@ -69,9 +69,13 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
>>>    {
>>>        unsigned int irq, cpu;
>>>        struct kvm_vcpu *vcpu;
>>> +     struct loongarch_dmsintc *s = READ_ONCE(kvm->arch.dmsintc);
>>> +
>>> +     if (!s)
>>> +             return -EINVAL;
>> NULL check with kvm->arch.dmsintc is already done in its caller function
>> pch_msi_set_irq(). It is not necessary here.
>>>
>>>        irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
>>> -     cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
>>> +     cpu = (addr >> AVEC_CPU_SHIFT) & s->cpu_mask;
>>>        if (cpu >= KVM_MAX_VCPUS)
>>>                return -EINVAL;
>>>        vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
>>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>>> index 62c09b5f3937..30a8c65c7609 100644
>>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>>> @@ -71,10 +71,11 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
>>>    int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int level)
>>>    {
>>>        u64 msg_addr = (((u64)e->msi.address_hi) << 32) | e->msi.address_lo;
>>> +     struct loongarch_dmsintc *dmsintc = READ_ONCE(kvm->arch.dmsintc);
>> what is usage of READ_ONCE() here?
>>
>> If you want to simple the usage of kvm->arch.dmsintc in multiple places,
>> just *struct loongarch_dmsintc *dmsintc = kvm->arch.dmsintc* is enough.
>> And it is not fixup patch, it is code cleanup.
> I completely don't think this patch is necessary.
yeap, I have the same feeling about this :)

> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>>
>>> -     if (cpu_has_msgint && kvm->arch.dmsintc &&
>>> -             msg_addr >= kvm->arch.dmsintc->msg_addr_base &&
>>> -             msg_addr < (kvm->arch.dmsintc->msg_addr_base + kvm->arch.dmsintc->msg_addr_size)) {
>>> +     if (cpu_has_msgint && dmsintc &&
>>> +             msg_addr >= dmsintc->msg_addr_base &&
>>> +             msg_addr < (dmsintc->msg_addr_base + dmsintc->msg_addr_size)) {
>>>                return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
>>>        }
>>>
>>>
>>

