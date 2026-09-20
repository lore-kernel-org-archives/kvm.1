Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C293C3F4E;
	Sun, 20 Sep 2026 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871824; cv=none; b=rzS1mTvXQ1RTRPB9uIzKV5PrR1jJ8vT63EQJR3XauC/02zbDd66nFPmPA1xWm3SlcDhU+g602zgaFaoyf9U9QVPCkjXpBE1z+ZPJ9KgNWzViOhfZRGua7NkTUyfS9PS17Wu96WU0QdUn9gNpOH3xXmxXmrUVi0a4NygVKpkqcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871824; c=relaxed/simple;
	bh=Qxv/HYT2EJ1TtRwAjZglOghCSoM6WpzDjceU6hGwD9I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XfgFxmeQEmy1xMWJFsibGsMyFfi6biI+g5I8s+WvaLX+WLCT2cb2CHw1OULWhTjafsiwwnc87ojRxVZ4vTXN8yCey2n9B6pOht1wfEldEHsFqoMLIUecn8RWeBlQbAqpDarPT+CwgZ63zMktSw7cSLjQSctRf386N6KYqWfYkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxS_DKRq9qDdINAA--.40657S3;
	Sun, 20 Sep 2026 10:36:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxmM3JRq9qWdUiAA--.7735S2;
	Sun, 20 Sep 2026 10:36:58 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: KVM: Remove parameter line when inject MSI
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260909083259.1910290-1-maobibo@loongson.cn>
 <20260909083259.1910290-2-maobibo@loongson.cn>
 <CAAhV-H59b2PJjJ3rGGQj1hhyK0-ustqNSzk=iaFd28-xtM8FDw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <36713a35-2e9c-3d34-41e9-c77111849f60@loongson.cn>
Date: Sun, 20 Sep 2026 10:36:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H59b2PJjJ3rGGQj1hhyK0-ustqNSzk=iaFd28-xtM8FDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM3JRq9qWdUiAA--.7735S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WrWrXFyrXF47Ar13Xw4rCrX_yoWxGF1rpF
	Z8Ars8uFWrJr1UXrZ2gw4Duryavrsagr1S9a429asxCrnFvr1UJF1kAr9rZFy5GayUGr4I
	qFsxG3Wava1Ut3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18U
	UUUU=



On 2026/9/19 下午10:16, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Wed, Sep 9, 2026 at 4:40 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> With MSI interrupt, there is intterupt set injection, no interrupt
>> clear action. DMSI interrupt controller is specially for MSI irqchip.
>> And there is checking with parameter level in most upper function
>> kvm_set_msi() and kvm_arch_set_irq_inatomic() already, here remove
>> duplicated line parameter checking in MSI injection leaf functions.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_dmsintc.h | 3 +--
>>   arch/loongarch/include/asm/kvm_pch_pic.h | 2 +-
>>   arch/loongarch/kvm/intc/dmsintc.c        | 9 +++------
>>   arch/loongarch/kvm/intc/pch_pic.c        | 6 +++---
>>   arch/loongarch/kvm/irqfd.c               | 6 +++---
>>   5 files changed, 11 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/include/asm/kvm_dmsintc.h
>> index 7c0158764d84..e19b3f5b3c52 100644
>> --- a/arch/loongarch/include/asm/kvm_dmsintc.h
>> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
>> @@ -22,7 +22,6 @@ struct dmsintc_state {
>>   int kvm_loongarch_register_dmsintc_device(void);
>>   void kvm_loongarch_unregister_dmsintc_device(void);
>>   void dmsintc_inject_irq(struct kvm_vcpu *vcpu);
>> -int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level);
>> -int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 vector, int level);
>> +int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data);
>>
>>   #endif
>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
>> index 887b0431fd20..19ed1494c114 100644
>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
>> @@ -72,6 +72,6 @@ struct kvm_kernel_irq_routing_entry;
>>   int kvm_loongarch_register_pch_pic_device(void);
>>   void kvm_loongarch_unregister_pch_pic_device(void);
>>   void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level);
>> -int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int level);
>> +int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e);
>>
>>   #endif /* __ASM_KVM_PCH_PIC_H */
>> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
>> index 89f980d867be..79e56e330aeb 100644
>> --- a/arch/loongarch/kvm/intc/dmsintc.c
>> +++ b/arch/loongarch/kvm/intc/dmsintc.c
>> @@ -43,13 +43,10 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
>>          }
>>   }
>>
>> -int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
>> -                               struct kvm_vcpu *vcpu, u32 vector, int level)
>> +static int dmsintc_deliver_msi_to_vcpu(struct kvm_vcpu *vcpu, u32 vector)
>>   {
>>          struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
>>
>> -       if (!level)
>> -               return 0;
>>          if (!vcpu || vector >= 256)
>>                  return -EINVAL;
>>          if (!ds)
>> @@ -65,7 +62,7 @@ int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
>>          return 0;
>>   }
>>
>> -int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
>> +int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data)
>>   {
>>          unsigned int irq, cpu;
>>          struct kvm_vcpu *vcpu;
>> @@ -78,7 +75,7 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
>>          if (!vcpu)
>>                  return -EINVAL;
>>
>> -       return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, irq, level);
>> +       return dmsintc_deliver_msi_to_vcpu(vcpu, irq);
>>   }
>>
>>   static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>> index 2b63b0c2c7ce..220fc23ffe8c 100644
>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>> @@ -68,20 +68,20 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
>>   }
>>
>>   /* msi irq handler */
>> -int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int level)
>> +int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e)
>>   {
>>          u64 msg_addr = (((u64)e->msi.address_hi) << 32) | e->msi.address_lo;
>>
>>          if (cpu_has_msgint && kvm->arch.dmsintc &&
>>                  msg_addr >= kvm->arch.dmsintc->msg_addr_base &&
>>                  msg_addr < (kvm->arch.dmsintc->msg_addr_base + kvm->arch.dmsintc->msg_addr_size)) {
>> -               return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
>> +               return dmsintc_set_irq(kvm, msg_addr, e->msi.data);
>>          }
>>
>>          if (e->msi.data >= EIOINTC_IRQS)
>>                  return -EINVAL;
>>
>> -       eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
>> +       eiointc_set_irq(kvm->arch.eiointc, e->msi.data, 1);
>>
>>          return 0;
>>   }
>> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
>> index 40ed1081c4b6..686097ca5906 100644
>> --- a/arch/loongarch/kvm/irqfd.c
>> +++ b/arch/loongarch/kvm/irqfd.c
>> @@ -27,9 +27,9 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>>                  struct kvm *kvm, int irq_source_id, int level, bool line_status)
>>   {
>>          if (!level)
>> -               return -1;
>> +               return -EINVAL;
>>
>> -       return pch_msi_set_irq(kvm, e, level);
>> +       return pch_msi_set_irq(kvm, e);
>>   }
>>
>>   /*
>> @@ -78,7 +78,7 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
>>                  pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
>>                  return 0;
>>          case KVM_IRQ_ROUTING_MSI:
>> -               return pch_msi_set_irq(kvm, e, level);
>> +               return pch_msi_set_irq(kvm, e);
> Please also consider the KVM_IRQ_ROUTING_IRQCHIP case. If
> pch_pic_set_irq() also doesn't need level, please remove it; if
> pch_pic_set_irq() needs level, please move the checking from head to
There is level == 0 requirement with pch_pic_set_irq() since it is 
called by kvm_set_pic_irq() also, however with function 
kvm_arch_set_irq_inatomic(), I think that there is no such requirement.

Regards
Bibo Mao
> the KVM_IRQ_ROUTING_MSI case.
> 
> 
> Huacai
> 
>>          default:
>>                  return -EWOULDBLOCK;
>>          }
>> --
>> 2.39.3
>>

