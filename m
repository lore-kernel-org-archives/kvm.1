Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD05483BFA
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587490; cv=none; b=Y4fVWNuFCMbcR7TpdocS0jdPw1LPQdTSb2G1pCFAeeY3OXFjkkbQYN5rBkrzWw1TrSc9wnUdFhdbXbhPnJ6SO2lNxhoBFMRafn+9EIDAKCZIsKfISjEb2hyhGk+qWgcxvq55k0K7pOQnh43zkcatkaIrrkIjxUGxARFzkBJ+tro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587490; c=relaxed/simple;
	bh=HxNwpHe0nHsH16nYk3/3aMin7+3c9bVF1RTMSXmtCuE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LwvJs5LFOCeCMXOrVlLXjntwytg6XleyrfB4eTjrjSwNpQnG2096OSfmz2H8gUeSTA5zo1p+Etq9w1ahjg5NJs8YneQ0h5A3GG9lTDRZJErCA4oZh9AqZoeIe4hgarqu7hDsln+YkwPy9lLmickcziZHR1OLRteMjtsZ0hqrsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QPhpoxYS; arc=none smtp.client-ip=91.218.175.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QPhpoxYS"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HxNwpHe0nHsH16nYk3/3aMin7+3c9bVF1RTMSXmtCuE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790587486; v=1; x=1791192286;
 b=QPhpoxYSjKH3PdIbQuHd94yXAuuXcYNXhuJTievVvLsgidgeUB6Yx2iezKBuTOKxyeDE6X8C
 tE3Db+9hGuHrexhPl0s3XjqckRVyyc9zhe5J0gcQGS9mT2llMs9HHZEkI8EH13kzls2BARAOelb
 FAq1eZnqnLccQzLfhNa3pDFY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9c7b60c04c93c979;
	Mon, 28 Sep 2026 09:24:46 +0000
X-Mizu-Trace-ID: 9c7b60c04c93c979
X-Migadu-Flow: FLOW_OUT
Message-ID: <8531bc11-b191-42c0-829d-36f831f6288e@linux.dev>
Date: Mon, 28 Sep 2026 17:24:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: KVM: Guard against NULL irqchip in irq
 injection
To: Bibo Mao <maobibo@loongson.cn>, gaosong@loongson.cn,
 zhaotianrui@loongson.cn
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-3-cui.tao@linux.dev>
 <4b4aba4a-c609-93f5-51e8-3b70a8baf6ad@loongson.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <4b4aba4a-c609-93f5-51e8-3b70a8baf6ad@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/28 12:14, Bibo Mao 写道:
> 
> 
> On 2026/9/27 下午3:52, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> The irqfd injection path dispatches through the irq routing table
>> without the kvm_arch_irqchip_in_kernel() gate that protects
>> KVM_IRQ_LINE: kvm_set_pic_irq() and kvm_arch_set_irq_inatomic() call
>> pch_pic_set_irq(kvm->arch.pch_pic, ...) and pch_msi_set_irq() calls
>> eiointc_set_irq(kvm->arch.eiointc, ...) directly, so a routing entry
>> that outlives the corresponding in-kernel irqchip dereferences a NULL
>> (or, before the previous patch, a freed) device.
>>
>> Make pch_pic_set_irq(), eiointc_set_irq() and dmsintc_set_irq()
>> tolerate a NULL device.
>>
>> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kvm/intc/dmsintc.c | 3 +++
>>   arch/loongarch/kvm/intc/eiointc.c | 5 ++++-
>>   arch/loongarch/kvm/intc/pch_pic.c | 3 +++
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
>> index 63072595c01b..e27f448bb54f 100644
>> --- a/arch/loongarch/kvm/intc/dmsintc.c
>> +++ b/arch/loongarch/kvm/intc/dmsintc.c
>> @@ -70,6 +70,9 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
>>       unsigned int irq, cpu;
>>       struct kvm_vcpu *vcpu;
>>   +    if (!kvm->arch.dmsintc)
>> +        return -EINVAL;
>> +
> There is kvm->arch.dmsintc checking in its caller function pch_msi_set_irq().
> 
>>       irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
>>       cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
>>       if (cpu >= KVM_MAX_VCPUS)
>> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
>> index fe0a1918f26f..c68f9033638a 100644
>> --- a/arch/loongarch/kvm/intc/eiointc.c
>> +++ b/arch/loongarch/kvm/intc/eiointc.c
>> @@ -112,8 +112,11 @@ static inline void eiointc_update_sw_coremap(struct loongarch_eiointc *s,
>>   void eiointc_set_irq(struct loongarch_eiointc *s, int irq, int level)
>>   {
>>       unsigned long flags;
>> -    unsigned long *isr = (unsigned long *)s->isr;
>> +    unsigned long *isr;
>>   +    if (!s)
>> +        return;
> When is it possible that parameter s is NULL? There is kvm_arch_irqchip_in_kernel() checking in kvm_send_userspace_msi().
> 
>> +    isr = (unsigned long *)s->isr;
>>       spin_lock_irqsave(&s->lock, flags);
>>       level ? __set_bit(irq, isr) : __clear_bit(irq, isr);
>>       eiointc_update_irq(s, irq, level);
>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>> index 62c09b5f3937..88666425d800 100644
>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>> @@ -48,6 +48,9 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
>>   {
>>       u64 mask = BIT(irq);
>>   +    if (!s)
>> +        return;
>> +
> When is it possible that parameter s is NULL? I think that when in kernel irqchip is removed, there is no way to inject line IRQ in kernel side.
> 

Thanks for looking into this.

You're right. I rechecked the lifetime rules after your comments, and
my reasoning for this patch was flawed.

I had assumed an irqfd could remain active after the corresponding
in-kernel irqchip had been removed. In fact, that state is not
reachable. The irqchip devices are not destroyed during the lifetime
of a running VM, and during VM teardown irqfds are released before
the irqchip devices are destroyed. For DMSINTC, the rollback path is
already guarded by `pch_msi_set_irq()`.

So these NULL checks are not protecting a real execution path. I'll
drop this patch in the next revision.

Thanks,
Tao

> Regards
> Bibo Mao
>>       spin_lock(&s->lock);
>>       if (level)
>>           s->irr |= mask; /* set irr */
>>
> 

