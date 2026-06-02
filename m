Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462F3C0611;
	Tue,  2 Jun 2026 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388020; cv=none; b=XhWO9DpHdYSU9MXRw2/2QGPDqoA+loCmaDgtW1grhkl3mh0QgVoWlQbzXJ5Z6U9x3HXaBbmF9B7R6GfUeeNfVmZu08PoJApiG9BCsISC7jfR1+VKAHcfc5r0h1wRcFxqEfslvu9KY7V8FvJsDToOMAixg8wzhTJCB2fjOvqZ/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388020; c=relaxed/simple;
	bh=7sLUEwrUFiiDVN7jqCTsPZBOjRwidmga203xP/8jh04=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=u7K3Cg28xVZehvp5AMbj67VhCZtNzusFpd1ejSQQS0g0I/Hfs1Agy9am0+DepNdyvp47Cp7z9qK0wvqGYPF3QOHsqZzIv+jYlQztLQUe8Ytp4w6QZcXnP6aqRScCLFoSu074LP1B7IZG00eswTA/ZuuH73QPgBRycm7QH8FkMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxhumvkB5qWqkPAA--.43735S3;
	Tue, 02 Jun 2026 16:13:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxjcKukB5q1RSZAA--.25614S3;
	Tue, 02 Jun 2026 16:13:34 +0800 (CST)
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Use existing macro about interrupt
 bit mask
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260526125256.2511876-1-maobibo@loongson.cn>
 <20260526125256.2511876-4-maobibo@loongson.cn>
 <CAAhV-H5Bkg1MrWr_8YcvCdHWAfX_-WLzdFGukJQVu330LoL5KA@mail.gmail.com>
 <d5722640-538c-4a97-7dff-bcec91a4c955@loongson.cn>
 <CAAhV-H6TfJ8c8SmLZ=9PtGPWWOjSTQD=utHVp5aoEa5ZoO71Cw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e228286e-7008-e66b-18b3-1140b2916f0e@loongson.cn>
Date: Tue, 2 Jun 2026 16:10:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6TfJ8c8SmLZ=9PtGPWWOjSTQD=utHVp5aoEa5ZoO71Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxjcKukB5q1RSZAA--.25614S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4kZryUJr1xAr45tF1fGrX_yoW7JFyUpr
	W8Ga4DWF43XF42gw1fK3Z8KFnrtrn7Jr4Igr9FgrW5JF9Fgw1fA3W8Krn8Crn2q395G348
	Wr98Zw13uF9xKrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jrpnQUUUUU=



On 2026/6/2 下午1:01, Huacai Chen wrote:
> On Tue, Jun 2, 2026 at 9:39 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/6/1 下午9:50, Huacai Chen wrote:
>>> Hi, Bibo,
>>>
>>> On Tue, May 26, 2026 at 8:53 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> With interrupt post, register CSR_GINTC and CSR_ESTAT is used, and
>>>> CSR_ESTAT is used for percpu interrupt injection and CSR_GINTC is for
>>>> external hardware interrupt injection.
>>>>
>>>> Here use existing macro about interrupt bit of register CSR_GINTC and
>>>> CSR_ESTAT, rather than hard coded constant value.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/kvm_vcpu.h | 43 ++++++++++++++++++---------
>>>>    1 file changed, 29 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
>>>> index 3784ab4ccdb5..efe26b04b35f 100644
>>>> --- a/arch/loongarch/include/asm/kvm_vcpu.h
>>>> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
>>>> @@ -10,22 +10,37 @@
>>>>    #include <asm/loongarch.h>
>>>>
>>>>    /* Controlled by 0x5 guest estat */
>>>> -#define CPU_SIP0                       (_ULCAST_(1))
>>>> -#define CPU_SIP1                       (_ULCAST_(1) << 1)
>>>> -#define CPU_PMU                                (_ULCAST_(1) << 10)
>>>> -#define CPU_TIMER                      (_ULCAST_(1) << 11)
>>>> -#define CPU_IPI                                (_ULCAST_(1) << 12)
>>>> -#define CPU_AVEC                        (_ULCAST_(1) << 14)
>>>> +#define CPU_SIP0                       BIT(INT_SWI0)
>>>> +#define CPU_SIP1                       BIT(INT_SWI1)
>>>> +#define CPU_HWI0                       BIT(INT_HWI0)
>>>> +#define CPU_HWI1                       BIT(INT_HWI1)
>>>> +#define CPU_HWI2                       BIT(INT_HWI2)
>>>> +#define CPU_HWI3                       BIT(INT_HWI3)
>>>> +#define CPU_HWI4                       BIT(INT_HWI4)
>>>> +#define CPU_HWI5                       BIT(INT_HWI5)
>>>> +#define CPU_HWI6                       BIT(INT_HWI6)
>>>> +#define CPU_HWI7                       BIT(INT_HWI7)
>>>> +#define CPU_PMU                                BIT(INT_PCOV)
>>>> +#define CPU_TIMER                      BIT(INT_TI)
>>>> +#define CPU_IPI                                BIT(INT_IPI)
>>>> +#define CPU_AVEC                       BIT(INT_AVEC)
>>>> +#define KVM_ESTAT_IRQ_MASK             (CPU_SIP0 | CPU_SIP1 | CPU_PMU | CPU_TIMER \
>>>> +                                               | CPU_IPI | CPU_AVEC)
>>>> +#define KVM_ESTAT_HWI_MASK             (CPU_HWI0 | CPU_HWI1 | CPU_HWI2 | CPU_HWI3 \
>>>> +                                               | CPU_HWI4 | CPU_HWI5 | CPU_HWI6 | CPU_HWI7)
>>>>
>>>>    /* Controlled by 0x52 guest exception VIP aligned to estat bit 5~12 */
>>>> -#define CPU_IP0                                (_ULCAST_(1))
>>>> -#define CPU_IP1                                (_ULCAST_(1) << 1)
>>>> -#define CPU_IP2                                (_ULCAST_(1) << 2)
>>>> -#define CPU_IP3                                (_ULCAST_(1) << 3)
>>>> -#define CPU_IP4                                (_ULCAST_(1) << 4)
>>>> -#define CPU_IP5                                (_ULCAST_(1) << 5)
>>>> -#define CPU_IP6                                (_ULCAST_(1) << 6)
>>>> -#define CPU_IP7                                (_ULCAST_(1) << 7)
>>>> +#define GINTC_VIP_DELTA                        (INT_HWI0 - CSR_GINTC_VIP_SHIFT)
>>> Don't use too many wrappers, just use INT_HWI0 instead of
>>> GINTC_VIP_DELTA in this series is perfect. In other places INT_SWI0 is
>>> also used for shifts.
>>
>> The above macro definition is a little complicated, I do not know how to
>> optimize it. do you mean remove GINTC_VIP_DELTA just use 2 such as:
>> #define CPU_IP0                       BIT(INT_HWI0 - 2)
> CSR_GINTC_VIP_SHIFT is 0 and GINTC_VIP_DELTA is equal to INT_HWI0. I
> mean remove the GINTC_VIP_DELTA definition and use INT_HWI0 instead.
For macro definition such CPU_IP0, GINTC_VIP_DELTA can be removed. And 
define it as follows directly.
#define CPU_IP0                       BIT(0)

However GINTC_VIP_DELTA is still useful, because bitmap with HWI0-HWI7 
in estat register starts from INT_HWI0, however with register gintc it 
starts from CSR_GINTC_VIP_SHIFT.

For example with _kvm_getcsr() API, it is to get interrupt status. Here 
is the example code.
gintc = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC)& KVM_GINTC_IRQ_MASK;
estat = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) &~KVM_ESTAT_HWI_MASK;
*val = estat | (gintc << GINTC_VIP_DELTA);

Remove GINTC_VIP_DELTA and use INT_HWI0 directly, it will be
*val = estat | (gintc << INT_HWI0);

I do not know what is the meaning about "gintc << INT_HWI0", especially 
if the value of CSR_GINTC_VIP_SHIFT is no zero.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>>
>> or something like this:
>> #define CPU_IP0                       (CPU_HWI0 >> GINTC_VIP_DELTA)
>>
>> Regards
>> Bibo Mao
>>>
>>>
>>> Huacai
>>>
>>>> +#define CPU_IP0                                BIT(INT_HWI0 - GINTC_VIP_DELTA)
>>>> +#define CPU_IP1                                BIT(INT_HWI1 - GINTC_VIP_DELTA)
>>>> +#define CPU_IP2                                BIT(INT_HWI2 - GINTC_VIP_DELTA)
>>>> +#define CPU_IP3                                BIT(INT_HWI3 - GINTC_VIP_DELTA)
>>>> +#define CPU_IP4                                BIT(INT_HWI4 - GINTC_VIP_DELTA)
>>>> +#define CPU_IP5                                BIT(INT_HWI5 - GINTC_VIP_DELTA)
>>>> +#define CPU_IP6                                BIT(INT_HWI6 - GINTC_VIP_DELTA)
>>>> +#define CPU_IP7                                BIT(INT_HWI7 - GINTC_VIP_DELTA)
>>>> +#define KVM_GINTC_IRQ_MASK             (CPU_IP0 | CPU_IP1 | CPU_IP2 | CPU_IP3 \
>>>> +                                               | CPU_IP4 | CPU_IP5 | CPU_IP6 | CPU_IP7)
>>>>
>>>>    #define MNSEC_PER_SEC                  (NSEC_PER_SEC >> 20)
>>>>
>>>> --
>>>> 2.39.3
>>>>
>>>>
>>
>>

