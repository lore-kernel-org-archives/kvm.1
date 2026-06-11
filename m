Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9D3FBB4D;
	Thu, 11 Jun 2026 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182516; cv=none; b=Nl5fBh68N3jz58HiMn9UQPZZ71EQpnjzUqOksfhYRsKKBcZH25np0bQzptTNV752M5lKh+yxagmhYrw8Hy4VuUH2zeyl1JNKgXV6sEhLBd0PqKBhM7bD2cTtJTwIy3apa9wuMouGlrGEXv4OW5lUy1MtOU7HbihH3LeoVAq83LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182516; c=relaxed/simple;
	bh=ZKi6ha5TuwUYlr7Pm+HTi0FHmtxK+pCSSMucOZXLmyA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T0x5BaICeYWqYlqlFiusI+9rTEGJsdyHc/i9zED54Fo9Lt2eTFdIlNbkm8nGhb2L0Hiz0W0rWVf8eVHkLEXo0lYtZMjqEKrd6/UsftVMwAFGI7fd38eo7YEkBaR0m9IDgRyfC9JxfZgnmiZR1U6LyC1llVcibwv3bMWi6SC8XJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cx3sAssCpqUBMTAA--.26869S3;
	Thu, 11 Jun 2026 20:55:09 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxvsIrsCpqQ+6iAA--.46630S3;
	Thu, 11 Jun 2026 20:55:08 +0800 (CST)
Subject: Re: [PATCH v6 5/6] LoongArch: KVM: Add valid bit check when set ESTAT
 CSR register
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260611065815.1439154-1-maobibo@loongson.cn>
 <20260611065815.1439154-6-maobibo@loongson.cn>
 <CAAhV-H7vMq+-nm8f8aL2CvmNYivaHgWj1cTuyv0BTfPQRKpSJA@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <00f28be5-3805-90d1-d2a5-69734b3d0a03@loongson.cn>
Date: Thu, 11 Jun 2026 20:52:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7vMq+-nm8f8aL2CvmNYivaHgWj1cTuyv0BTfPQRKpSJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvsIrsCpqQ+6iAA--.46630S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF17GF4kJFyDGry8tr4rCrX_yoWrJF4rpr
	yUKa4UurW8KFyqk3Wrtrs0vr4YvrWfKw4xZrZrKFWayryqvry3GFWxXr98Ary5u34fXF1I
	vas5JrZ3uF4DJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2026/6/11 下午6:10, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Jun 11, 2026 at 2:58 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> When set ESTAT CSR register in function _kvm_setcsr(), valid bit check
>> is added here. Also interrupt CPU_AVEC is checked by msgint feature.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kvm/vcpu.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index e986146d2272..4f67eefbd4f1 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -602,7 +602,7 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *kvm, int cpuid)
>>
>>   static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *val)
>>   {
>> -       unsigned long gintc;
>> +       unsigned long gintc, estat;
>>          struct loongarch_csrs *csr = vcpu->arch.csr;
>>
>>          if (get_gcsr_flag(id) & INVALID_GCSR)
>> @@ -621,8 +621,9 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *val)
>>                  preempt_enable();
>>
>>                  /* ESTAT IP0~IP7 get from GINTC */
>> -               gintc = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) & 0xff;
>> -               *val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) | (gintc << 2);
>> +               gintc = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) & KVM_GINTC_IRQ_MASK;
>> +               estat = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) & ~KVM_ESTAT_EXTI_MASK;
>> +               *val = estat | (gintc << VIP_DELTA);
>>                  return 0;
>>          }
>>
>> @@ -637,7 +638,8 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *val)
>>
>>   static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
>>   {
>> -       int ret = 0, gintc;
>> +       int ret = 0;
>> +       unsigned long gintc, estat;
>>          struct loongarch_csrs *csr = vcpu->arch.csr;
>>
>>          if (get_gcsr_flag(id) & INVALID_GCSR)
>> @@ -648,11 +650,16 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
>>
>>          if (id == LOONGARCH_CSR_ESTAT) {
>>                  /* ESTAT IP0~IP7 inject through GINTC */
>> -               gintc = (val >> 2) & 0xff;
>> -               kvm_set_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
>> -
>> -               gintc = val & ~(0xffUL << 2);
>> -               kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, gintc);
>> +               gintc = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) & ~KVM_GINTC_IRQ_MASK;
>> +               gintc |= (val >> VIP_DELTA) & KVM_GINTC_IRQ_MASK;
>> +               kvm_write_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> I think read & write can be combined, which means it can be simplified as:
>                  gintc = (val >> VIP_DELTA) & KVM_GINTC_IRQ_MASK;
>                  kvm_set_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> 
>> +
>> +               /* only set valid ESTAT bits */
>> +               estat = val & ~KVM_ESTAT_EXTI_MASK;
>> +               estat &= CSR_ESTAT_IS | CSR_ESTAT_EXC | CSR_ESTAT_ESUBCODE;
>> +               if (!kvm_guest_has_msgint(&vcpu->arch))
>> +                       estat &= ~CPU_AVEC;
>> +               kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat);
> I think write csr may lose bits from the original value, so
>                  kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat)
> should be
>                  kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat)
> 
> If you agree, I will change it when I apply because all others look good to me.
At the beginning, it is kvm_set_sw_gcsr() with CSR_GINTC/CSR_ESTAT, 
later I change it with kvm_write_sw_gcsr(). With kvm_set_sw_gcsr() API, 
it is only set new interrupt, however does not clear the interrupt. So I 
change it with kvm_write_sw_gcsr() which will overwrite the interrupt bits.

At the same time, bit field CSR_ESTAT_EXC | CSR_ESTAT_ESUBCODE is not 
suitable for bit set, overwrite its value is more suitable.

Regards
Bibo Mao

> 
> Huacai
> 
>>
>>                  return ret;
>>          }
>> --
>> 2.39.3
>>

