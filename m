Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6E221540;
	Thu, 26 Mar 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528008; cv=none; b=qCHyy4QdeXtBpDXH8rg/t6yZlFff8OuPdGpwSmN6opjvqjCCwpVscNyoFiPYmgLvRG+TIKbvzSi0hFfgtwqQFiLCoqF6hcT3qouWZ9bJ6JvpVSRvqOEGKWEvd1c1nbq6+i9CVyY9Jid0selVLnsFrZA1koTij6mIyN35/krWAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528008; c=relaxed/simple;
	bh=jSJ4Yxh4o1N5Cc+OocdOG5vI0t88TTfl1PI9H58CunM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HafXwCH2QpiNVKaZDiSV6nMA2kbMfpemBnPMi1k0DpGVLkliOiuuD9RqRhNRR0ZRtQgfXm1pCAfhi2N67rEriMx88o6FRGJ38Yb5qmNVRslRtb1I7KZN47c3NtDOoaeNNmaTUvoaqEDs+0QMCbxVr5mtD/mCoLpSoQFk+Y1R57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8DxPMMBJsVppuUeAA--.22659S3;
	Thu, 26 Mar 2026 20:26:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by front1 (Coremail) with SMTP id qMiowJAx28H9JcVp7_JdAA--.47009S3;
	Thu, 26 Mar 2026 20:26:40 +0800 (CST)
Subject: Re: [PATCH v8 2/2] LoongArch: KVM: Add dmsintc inject msi to the dest
 vcpu
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 kernel@xen0n.name, linux-kernel@vger.kernel.org, lixianglai@loongson.cn
References: <20260324091521.2338235-1-gaosong@loongson.cn>
 <20260324091521.2338235-3-gaosong@loongson.cn>
 <CAAhV-H7y8S6G+kh+qZ_q7Ug4JtzoGQ-ehUuA3uE63=gCpXyCGQ@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ee4faccb-5a46-93a9-edcd-4c2544d614b3@loongson.cn>
Date: Thu, 26 Mar 2026 20:28:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7y8S6G+kh+qZ_q7Ug4JtzoGQ-ehUuA3uE63=gCpXyCGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAx28H9JcVp7_JdAA--.47009S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyrCF43WF1xKrWkuF1Dtwc_yoW3tF1fpF
	WDAan8uFWrJr17Xr92qa1q9r1avrsagr1a9Fy29a4akrnFvr15XFy8Jr9rCFy5Gay8GF4I
	vF9xK3W3ua1UtacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==

在 2026/3/26 下午3:52, Huacai Chen 写道:
> Hi, Song,
>
> I'm sorry but it seems there are still bugs...
>
> On Tue, Mar 24, 2026 at 5:41 PM Song Gao <gaosong@loongson.cn> wrote:
>> Implement irqfd deliver msi to vcpu and vcpu dmsintc inject irq.
>> Add irqfd choice dmsintc to set msi irq by the msg_addr and
>> implement dmsintc set msi irq.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_dmsintc.h |  5 ++
>>   arch/loongarch/include/asm/kvm_pch_pic.h |  4 +-
>>   arch/loongarch/kvm/intc/dmsintc.c        | 73 ++++++++++++++++++++++++
>>   arch/loongarch/kvm/intc/pch_pic.c        | 16 +++++-
>>   arch/loongarch/kvm/interrupt.c           |  2 +
>>   arch/loongarch/kvm/irqfd.c               | 11 ++--
>>   6 files changed, 102 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/include/asm/kvm_dmsintc.h
>> index b04b89dd2a35..081ec8a7b874 100644
>> --- a/arch/loongarch/include/asm/kvm_dmsintc.h
>> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
>> @@ -11,11 +11,16 @@ struct loongarch_dmsintc {
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
>> +void dmsintc_inject_irq(struct kvm_vcpu *vcpu);
>> +int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm, struct kvm_vcpu *vcpu,
>> +                               u32 vector, int level);
>> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int level);
> I think addr should be u64.
Got it.
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
>> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
>> index 1bb61e55d061..6837ccbb4473 100644
>> --- a/arch/loongarch/kvm/intc/dmsintc.c
>> +++ b/arch/loongarch/kvm/intc/dmsintc.c
>> @@ -4,9 +4,82 @@
>>    */
>>
>>   #include <linux/kvm_host.h>
>> +#include <asm/kvm_csr.h>
>>   #include <asm/kvm_dmsintc.h>
>>   #include <asm/kvm_vcpu.h>
>>
>> +int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
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
>> +
>> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int level)
> The kvm_ prefix can be removed.
I will remove it.
>> +{
>> +       unsigned int virq, dest;
>> +       struct kvm_vcpu *vcpu;
>> +
>> +       virq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
>> +       dest = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
>> +       if (dest > KVM_MAX_VCPUS)
> I think it should be "if (dest > KVM_MAX_VCPUS)".
hmm.I'm not quite sure about here ,   or  ">=" ?
>> +               return -EINVAL;
>> +       vcpu = kvm_get_vcpu_by_cpuid(kvm, dest);
>> +       if (!vcpu)
>> +               return -EINVAL;
>> +       return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, virq, level);
>> +}
>> +
>> +void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
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
>> +
>>   static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
>>                                  struct kvm_device_attr *attr,
>>                                  bool is_write)
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
> Define and evaluate at the same time.
>
Got it .

Thanks.
Song Gao
> Huacai
>
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
>> index fb704f4c8ac5..32930959f7c2 100644
>> --- a/arch/loongarch/kvm/interrupt.c
>> +++ b/arch/loongarch/kvm/interrupt.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/errno.h>
>>   #include <asm/kvm_csr.h>
>>   #include <asm/kvm_vcpu.h>
>> +#include <asm/kvm_dmsintc.h>
>>
>>   static unsigned int priority_to_irq[EXCCODE_INT_NUM] = {
>>          [INT_TI]        = CPU_TIMER,
>> @@ -33,6 +34,7 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
>>                  irq = priority_to_irq[priority];
>>
>>          if (kvm_guest_has_msgint(&vcpu->arch) && (priority == INT_AVEC)) {
>> +               dmsintc_inject_irq(vcpu);
>>                  set_gcsr_estat(irq);
>>                  return 1;
>>          }
>> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
>> index 9a39627aecf0..308ef08b634c 100644
>> --- a/arch/loongarch/kvm/irqfd.c
>> +++ b/arch/loongarch/kvm/irqfd.c
>> @@ -28,10 +28,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
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
>> @@ -71,13 +68,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
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
>>

