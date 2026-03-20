Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A4435F165;
	Fri, 20 Mar 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991636; cv=none; b=mzhs5LqLqcv+q6uD/nzflhAAdXvjZwtdDwNszDiQsbPN7iOeyLamzZ8+Inmq0BARwbbky4FMfhunMrSNsqK/pelarZ5L+DSUDg+VL0TNwi8+q2B+58V/m9c0Enx8J3yG1HrikcrslB0duPBfiJMgxV8aMRCpismxngDVLxDVkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991636; c=relaxed/simple;
	bh=kT2aUYUmCIScn4AgdIloo137i7IxPgPTkAa0f/IGs9w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LOF3rfulK/gLkX4gvpbboyzJxhLVNw7XJLfqsmDOc21sn0as1/YuuSHNp9kEP+6HXCYjCIixPwtU7TyuNXnMVy66/tsEKYYuXg4ajN1CBdOP+/HQGUkcK4jb+fbuCOWyeHUcfxFV24cr42RliH8cco0UeLBxQPcVx7nvZD3hUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8DxMMDR9rxp6fYcAA--.24461S3;
	Fri, 20 Mar 2026 15:27:13 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by front1 (Coremail) with SMTP id qMiowJDxB8HQ9rxpIz1ZAA--.25730S3;
	Fri, 20 Mar 2026 15:27:12 +0800 (CST)
Subject: Re: [PATCH v7 2/2] LoongArch: KVM: Add dmsintc inject msi to the dest
 vcpu
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, loongarch@lists.linux.dev,
 kernel@xen0n.name, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311085059.1040263-1-gaosong@loongson.cn>
 <20260311085059.1040263-3-gaosong@loongson.cn>
 <CAAhV-H4DbH4M--eaozv5LpOxHFWKQnGPeMqvLWz6gKZC2yWDLA@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <896825a9-aa54-07cb-1241-f559d2b2f58d@loongson.cn>
Date: Fri, 20 Mar 2026 15:28:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4DbH4M--eaozv5LpOxHFWKQnGPeMqvLWz6gKZC2yWDLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxB8HQ9rxpIz1ZAA--.25730S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WrWxtry3ZFy5uFWruF1xZwc_yoW3uFWUpF
	WDAan8uFWrJr17Xr92qw4q9r13Zrs2gr1a9Fy29a4akr1qvr15XFykJr9rCFy5GayUGF4I
	vF9xK3Wa9a1UtacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wN
	VDUUUUU==

Hi, Huacai.
在 2026/3/19 下午8:48, Huacai Chen 写道:
> Hi, Song,
>
> On Wed, Mar 11, 2026 at 5:16 PM Song Gao <gaosong@loongson.cn> wrote:
>> Implement irqfd deliver msi to vcpu and vcpu dmsintc inject irq.
>> Add irqfd choice dmsintc to set msi irq by the msg_addr and
>> implement dmsintc set msi irq.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_dmsintc.h |  2 +
>>   arch/loongarch/include/asm/kvm_pch_pic.h |  4 +-
>>   arch/loongarch/kvm/intc/pch_pic.c        | 16 +++++++-
>>   arch/loongarch/kvm/interrupt.c           | 37 ++++++++++++++++++
>>   arch/loongarch/kvm/irqfd.c               | 48 +++++++++++++++++++++---
>>   5 files changed, 98 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/include/asm/kvm_dmsintc.h
>> index b04b89dd2a35..7046c66cac93 100644
>> --- a/arch/loongarch/include/asm/kvm_dmsintc.h
>> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
>> @@ -11,11 +11,13 @@ struct loongarch_dmsintc {
>>          struct kvm *kvm;
>>          uint64_t msg_addr_base;
>>          uint64_t msg_addr_size;
>> +       uint32_t cpu_mask;
>>   };
>>
>>   struct dmsintc_state {
>>          atomic64_t  vector_map[4];
>>   };
>>
>> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int level);
>>   int kvm_loongarch_register_dmsintc_device(void);
>>   #endif
>> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
>> index 7f33a3039272..5f49b1f82c56 100644
>> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
>> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
>> @@ -70,6 +70,8 @@ struct loongarch_pch_pic {
>>
>>   int kvm_loongarch_register_pch_pic_device(void);
>>   void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level);
>> -void pch_msi_set_irq(struct kvm *kvm, int irq, int level);
>> +struct kvm_kernel_irq_routing_entry;
>> +int pch_msi_set_irq(struct kvm *kvm,
>> +               struct kvm_kernel_irq_routing_entry *e, int level);
>>
>>   #endif /* __ASM_KVM_PCH_PIC_H */
>> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
>> index dd7e7f8d53db..1c0ed0665736 100644
>> --- a/arch/loongarch/kvm/intc/pch_pic.c
>> +++ b/arch/loongarch/kvm/intc/pch_pic.c
>> @@ -4,6 +4,7 @@
>>    */
>>
>>   #include <asm/kvm_eiointc.h>
>> +#include <asm/kvm_dmsintc.h>
>>   #include <asm/kvm_pch_pic.h>
>>   #include <asm/kvm_vcpu.h>
>>   #include <linux/count_zeros.h>
>> @@ -67,9 +68,20 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
>>   }
>>
>>   /* msi irq handler */
>> -void pch_msi_set_irq(struct kvm *kvm, int irq, int level)
>> +int pch_msi_set_irq(struct kvm *kvm,
>> +               struct kvm_kernel_irq_routing_entry *e, int level)
>>   {
>> -       eiointc_set_irq(kvm->arch.eiointc, irq, level);
>> +       u64 msg_addr;
>> +
>> +       msg_addr = (((u64)e->msi.address_hi) << 32) | e->msi.address_lo;
>> +       if (cpu_has_msgint && kvm->arch.dmsintc &&
>> +               msg_addr >= kvm->arch.dmsintc->msg_addr_base &&
>> +               msg_addr < (kvm->arch.dmsintc->msg_addr_base  + kvm->arch.dmsintc->msg_addr_size)) {
>> +               return kvm_dmsintc_set_msi_irq(kvm, msg_addr, e->msi.data, level);
>> +       }
>> +
>> +       eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
>> +       return 0;
>>   }
>>
>>   static int loongarch_pch_pic_read(struct loongarch_pch_pic *s, gpa_t addr, int len, void *val)
>> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
>> index fb704f4c8ac5..76a133adedc2 100644
>> --- a/arch/loongarch/kvm/interrupt.c
>> +++ b/arch/loongarch/kvm/interrupt.c
>> @@ -8,6 +8,42 @@
>>   #include <asm/kvm_csr.h>
>>   #include <asm/kvm_vcpu.h>
>>
>> +static void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
>> +{
>> +       struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
>> +       unsigned int i;
>> +       unsigned long temp[4], old;
>> +
>> +       if (!ds)
>> +               return;
>> +
>> +       for (i = 0; i < 4; i++) {
>> +               old = atomic64_read(&(ds->vector_map[i]));
>> +               if (old)
>> +                       temp[i] = atomic64_xchg(&(ds->vector_map[i]), 0);
>> +       }
>> +
>> +       if (temp[0]) {
>> +               old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
>> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, temp[0]|old);
>> +       }
>> +
>> +       if (temp[1]) {
>> +               old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR1);
>> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR1, temp[1]|old);
>> +       }
>> +
>> +       if (temp[2]) {
>> +               old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR2);
>> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR2, temp[2]|old);
>> +       }
>> +
>> +       if (temp[3]) {
>> +               old = kvm_read_hw_gcsr(LOONGARCH_CSR_ISR3);
>> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR3, temp[3]|old);
>> +       }
>> +}
> Thank you for your rework, but after rework dmsintc_inject_irq(),
> dmsintc_deliver_msi_to_vcpu() and dmsintc_set_msi_irq() should be in
> dmsintc.c now.

You are absolutely right. These functions are indeed specific to the DMSINTC device and
should reside in dmsintc.c for better code organization and maintainability.
I will move them accordingly in the next version.

Thanks again for pointing this out.

Thanks.
Song Gao

>
> Huacai
>
>> +
>>   static unsigned int priority_to_irq[EXCCODE_INT_NUM] = {
>>          [INT_TI]        = CPU_TIMER,
>>          [INT_IPI]       = CPU_IPI,
>> @@ -33,6 +69,7 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
>>                  irq = priority_to_irq[priority];
>>
>>          if (kvm_guest_has_msgint(&vcpu->arch) && (priority == INT_AVEC)) {
>> +               dmsintc_inject_irq(vcpu);
>>                  set_gcsr_estat(irq);
>>                  return 1;
>>          }
>> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
>> index 9a39627aecf0..4788705ddf9f 100644
>> --- a/arch/loongarch/kvm/irqfd.c
>> +++ b/arch/loongarch/kvm/irqfd.c
>> @@ -6,6 +6,28 @@
>>   #include <linux/kvm_host.h>
>>   #include <trace/events/kvm.h>
>>   #include <asm/kvm_pch_pic.h>
>> +#include <asm/kvm_vcpu.h>
>> +
>> +static int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
>> +                               struct kvm_vcpu *vcpu,
>> +                               u32 vector, int level)
>> +{
>> +       struct kvm_interrupt vcpu_irq;
>> +       struct dmsintc_state *ds;
>> +
>> +       if (!level)
>> +               return 0;
>> +       if (!vcpu || vector >= 256)
>> +               return -EINVAL;
>> +       ds = &vcpu->arch.dmsintc_state;
>> +       if (!ds)
>> +               return -ENODEV;
>> +       set_bit(vector, (unsigned long *)&ds->vector_map);
>> +       vcpu_irq.irq = INT_AVEC;
>> +       kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
>> +       kvm_vcpu_kick(vcpu);
>> +       return 0;
>> +}
>>
>>   static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
>>                  struct kvm *kvm, int irq_source_id, int level, bool line_status)
>> @@ -16,6 +38,21 @@ static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
>>          return 0;
>>   }
>>
>> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int level)
>> +{
>> +       unsigned int virq, dest;
>> +       struct kvm_vcpu *vcpu;
>> +
>> +       virq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
>> +       dest = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
>> +       if (dest > KVM_MAX_VCPUS)
>> +               return -EINVAL;
>> +       vcpu = kvm_get_vcpu_by_cpuid(kvm, dest);
>> +       if (!vcpu)
>> +               return -EINVAL;
>> +       return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, virq, level);
>> +}
>> +
>>   /*
>>    * kvm_set_msi: inject the MSI corresponding to the
>>    * MSI routing entry
>> @@ -28,10 +65,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>>   {
>>          if (!level)
>>                  return -1;
>> -
>> -       pch_msi_set_irq(kvm, e->msi.data, level);
>> -
>> -       return 0;
>> +       return pch_msi_set_irq(kvm, e, level);
>>   }
>>
>>   /*
>> @@ -71,13 +105,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
>>   int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
>>                  struct kvm *kvm, int irq_source_id, int level, bool line_status)
>>   {
>> +       if (!level)
>> +               return -EWOULDBLOCK;
>> +
>>          switch (e->type) {
>>          case KVM_IRQ_ROUTING_IRQCHIP:
>>                  pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level);
>>                  return 0;
>>          case KVM_IRQ_ROUTING_MSI:
>> -               pch_msi_set_irq(kvm, e->msi.data, level);
>> -               return 0;
>> +               return pch_msi_set_irq(kvm, e, level);
>>          default:
>>                  return -EWOULDBLOCK;
>>          }
>> --
>> 2.39.3
>>

