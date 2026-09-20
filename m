Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481D3B9D8C;
	Sun, 20 Sep 2026 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871546; cv=none; b=hWK74xHpZOwlcn4tyZ/8k4J1hI2xz2ioFmOwOGsxVyalHXKT+yPeOdT5YKxPsD83OdY9Pw6ru9ye0iLy8AIuF1hcoEsgPLeDA50aN8k0IjkpBEiUMv4ltoytIhisFS5yxQeIHg+BgzHkTZfocU5GdUzf0xJY+mYOwdVc3AmDzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871546; c=relaxed/simple;
	bh=2kt9Z9XJu68P+aUSJI8169QEZxK+LyidalzO0qxWBjA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ex95Co5yy86Iggq9jD834qxS2F2GDQUY2Ro848DAWRveSvCBoHJGxJDEa6Lpf4KiIhMC7ni0HGaWhlLiIVurxx35ap70Ci6q5Re0SEVv/RaYosMr7k9ZjheZj2CrfPus1kaCunEe9L47A7jmkfyJocZnpcsK4buxzM08n/U+dJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxD9OsRa9qm9ENAA--.40607S3;
	Sun, 20 Sep 2026 10:32:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBx5cyrRa9qltQiAA--.47387S2;
	Sun, 20 Sep 2026 10:32:12 +0800 (CST)
Subject: Re: [PATCH 2/2] LoongArch: KVM: Remove duplicated checking with DMSI
 irq injection
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260909083259.1910290-1-maobibo@loongson.cn>
 <20260909083259.1910290-3-maobibo@loongson.cn>
 <CAAhV-H53LrCzgA=4eB=2NCKp+fCHW85i09gZzESY_knViyV=gQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5bb46144-863e-b97f-30d1-857bcdd63ce0@loongson.cn>
Date: Sun, 20 Sep 2026 10:31:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H53LrCzgA=4eB=2NCKp+fCHW85i09gZzESY_knViyV=gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5cyrRa9qltQiAA--.47387S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw48tFy7XFyUJFyxJFW8GrX_yoW8Zw4xp3
	y3Ca4q9rW8XFy7uwsFgFn09rZFkr98tr18WFy2ga45CrZ8KFn5Jr18J393ZFy5Way5Cr40
	qa13Aa43Za1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALU
	UUUU=



On 2026/9/19 下午10:16, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Wed, Sep 9, 2026 at 4:40 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> There are some duplicated error checking in DMSI interrupt injection
>> function, also vcpu::arch::dmsintc_state is structure rather than pointer,
>> NULL pointer checking with dmsintc_state is not necessary, here remove
>> these unnecessary checking.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kvm/intc/dmsintc.c | 10 ----------
>>   1 file changed, 10 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
>> index 79e56e330aeb..cd2cd7a5c01e 100644
>> --- a/arch/loongarch/kvm/intc/dmsintc.c
>> +++ b/arch/loongarch/kvm/intc/dmsintc.c
>> @@ -14,9 +14,6 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
>>          unsigned long vector[4], old;
>>          struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
>>
>> -       if (!ds)
>> -               return;
>> -
>>          for (i = 0; i < 4; i++) {
>>                  old = atomic64_read(&(ds->vector_map[i]));
>>                  vector[i] = old ? atomic64_xchg(&(ds->vector_map[i]), 0) : 0;
>> @@ -47,11 +44,6 @@ static int dmsintc_deliver_msi_to_vcpu(struct kvm_vcpu *vcpu, u32 vector)
>>   {
>>          struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
>>
>> -       if (!vcpu || vector >= 256)
>> -               return -EINVAL;
>> -       if (!ds)
>> -               return -ENODEV;
>> -
>>          if (!kvm_guest_has_msgint(&vcpu->arch))
>>                  return -EINVAL;
> Now dmsintc_deliver_msi_to_vcpu() is significantly simplified, please
> open-code it into dmsintc_set_irq().
Will move code of dmsintc_deliver_msi_to_vcpu into dmsintc_set_irq().

Regards
Bibo Mao
> 
> 
> Huacai
> 
>>
>> @@ -69,8 +61,6 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data)
>>
>>          irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
>>          cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
>> -       if (cpu >= KVM_MAX_VCPUS)
>> -               return -EINVAL;
>>          vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
>>          if (!vcpu)
>>                  return -EINVAL;
>> --
>> 2.39.3
>>

