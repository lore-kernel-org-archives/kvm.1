Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20212D780C;
	Tue,  2 Jun 2026 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364394; cv=none; b=O7WhOoysFg6fY2kB3CxctIZ5Ex8jEXTW/EWwMcF6Cr+KlsDBggzpEiHByXRj1gYiDQQtgIZkC12B0ikneh9qFZXoM4l9Sphffb/7Qh59ruUyp8s2hM5knSWx7yuHqtHQmuYaQzx5npFa0Zo4BEPKE5xB4QoHJ7Hw3mYtzA3SPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364394; c=relaxed/simple;
	bh=VmcIYlZoYPFajcd/yR2kOvmYKBN3ND0KvsxZst/Gwxs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XdagSX5/grQ6NjbiPsTmkJ9X75HWz/H60OC2ZzuIuIwg15zHZtVb2yBAFGqLg9Jor/2TO6xAjEQ6KCGAV/iJhVfrHECeOxgDckjVX18tSqUiOGawWyYByGiapligHtj4gDfgl2/yi/7wIGJbUsLTN0eamLe9FBmfzmWVvWEj4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxCHlkNB5qvZAPAA--.18858S3;
	Tue, 02 Jun 2026 09:39:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxpsBiNB5qnsWYAA--.58591S3;
	Tue, 02 Jun 2026 09:39:48 +0800 (CST)
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Use existing macro about interrupt
 bit mask
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260526125256.2511876-1-maobibo@loongson.cn>
 <20260526125256.2511876-4-maobibo@loongson.cn>
 <CAAhV-H5Bkg1MrWr_8YcvCdHWAfX_-WLzdFGukJQVu330LoL5KA@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d5722640-538c-4a97-7dff-bcec91a4c955@loongson.cn>
Date: Tue, 2 Jun 2026 09:36:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5Bkg1MrWr_8YcvCdHWAfX_-WLzdFGukJQVu330LoL5KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsBiNB5qnsWYAA--.58591S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArWxZFyDWF1fGr4xuF18Xrc_yoW5KrW5pr
	W8uas8XFW5XF42gw1Sk3Z8K3W7tr4kJr12g3sFgrs8JF9Fgw1Sv3WrKws8A34vq395G34I
	gr98Z3WYqF9xKrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjwZcUUUUU=



On 2026/6/1 下午9:50, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, May 26, 2026 at 8:53 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> With interrupt post, register CSR_GINTC and CSR_ESTAT is used, and
>> CSR_ESTAT is used for percpu interrupt injection and CSR_GINTC is for
>> external hardware interrupt injection.
>>
>> Here use existing macro about interrupt bit of register CSR_GINTC and
>> CSR_ESTAT, rather than hard coded constant value.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_vcpu.h | 43 ++++++++++++++++++---------
>>   1 file changed, 29 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
>> index 3784ab4ccdb5..efe26b04b35f 100644
>> --- a/arch/loongarch/include/asm/kvm_vcpu.h
>> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
>> @@ -10,22 +10,37 @@
>>   #include <asm/loongarch.h>
>>
>>   /* Controlled by 0x5 guest estat */
>> -#define CPU_SIP0                       (_ULCAST_(1))
>> -#define CPU_SIP1                       (_ULCAST_(1) << 1)
>> -#define CPU_PMU                                (_ULCAST_(1) << 10)
>> -#define CPU_TIMER                      (_ULCAST_(1) << 11)
>> -#define CPU_IPI                                (_ULCAST_(1) << 12)
>> -#define CPU_AVEC                        (_ULCAST_(1) << 14)
>> +#define CPU_SIP0                       BIT(INT_SWI0)
>> +#define CPU_SIP1                       BIT(INT_SWI1)
>> +#define CPU_HWI0                       BIT(INT_HWI0)
>> +#define CPU_HWI1                       BIT(INT_HWI1)
>> +#define CPU_HWI2                       BIT(INT_HWI2)
>> +#define CPU_HWI3                       BIT(INT_HWI3)
>> +#define CPU_HWI4                       BIT(INT_HWI4)
>> +#define CPU_HWI5                       BIT(INT_HWI5)
>> +#define CPU_HWI6                       BIT(INT_HWI6)
>> +#define CPU_HWI7                       BIT(INT_HWI7)
>> +#define CPU_PMU                                BIT(INT_PCOV)
>> +#define CPU_TIMER                      BIT(INT_TI)
>> +#define CPU_IPI                                BIT(INT_IPI)
>> +#define CPU_AVEC                       BIT(INT_AVEC)
>> +#define KVM_ESTAT_IRQ_MASK             (CPU_SIP0 | CPU_SIP1 | CPU_PMU | CPU_TIMER \
>> +                                               | CPU_IPI | CPU_AVEC)
>> +#define KVM_ESTAT_HWI_MASK             (CPU_HWI0 | CPU_HWI1 | CPU_HWI2 | CPU_HWI3 \
>> +                                               | CPU_HWI4 | CPU_HWI5 | CPU_HWI6 | CPU_HWI7)
>>
>>   /* Controlled by 0x52 guest exception VIP aligned to estat bit 5~12 */
>> -#define CPU_IP0                                (_ULCAST_(1))
>> -#define CPU_IP1                                (_ULCAST_(1) << 1)
>> -#define CPU_IP2                                (_ULCAST_(1) << 2)
>> -#define CPU_IP3                                (_ULCAST_(1) << 3)
>> -#define CPU_IP4                                (_ULCAST_(1) << 4)
>> -#define CPU_IP5                                (_ULCAST_(1) << 5)
>> -#define CPU_IP6                                (_ULCAST_(1) << 6)
>> -#define CPU_IP7                                (_ULCAST_(1) << 7)
>> +#define GINTC_VIP_DELTA                        (INT_HWI0 - CSR_GINTC_VIP_SHIFT)
> Don't use too many wrappers, just use INT_HWI0 instead of
> GINTC_VIP_DELTA in this series is perfect. In other places INT_SWI0 is
> also used for shifts.

The above macro definition is a little complicated, I do not know how to 
optimize it. do you mean remove GINTC_VIP_DELTA just use 2 such as:
#define CPU_IP0                       BIT(INT_HWI0 - 2)

or something like this:
#define CPU_IP0                       (CPU_HWI0 >> GINTC_VIP_DELTA)

Regards
Bibo Mao
> 
> 
> Huacai
> 
>> +#define CPU_IP0                                BIT(INT_HWI0 - GINTC_VIP_DELTA)
>> +#define CPU_IP1                                BIT(INT_HWI1 - GINTC_VIP_DELTA)
>> +#define CPU_IP2                                BIT(INT_HWI2 - GINTC_VIP_DELTA)
>> +#define CPU_IP3                                BIT(INT_HWI3 - GINTC_VIP_DELTA)
>> +#define CPU_IP4                                BIT(INT_HWI4 - GINTC_VIP_DELTA)
>> +#define CPU_IP5                                BIT(INT_HWI5 - GINTC_VIP_DELTA)
>> +#define CPU_IP6                                BIT(INT_HWI6 - GINTC_VIP_DELTA)
>> +#define CPU_IP7                                BIT(INT_HWI7 - GINTC_VIP_DELTA)
>> +#define KVM_GINTC_IRQ_MASK             (CPU_IP0 | CPU_IP1 | CPU_IP2 | CPU_IP3 \
>> +                                               | CPU_IP4 | CPU_IP5 | CPU_IP6 | CPU_IP7)
>>
>>   #define MNSEC_PER_SEC                  (NSEC_PER_SEC >> 20)
>>
>> --
>> 2.39.3
>>
>>

