Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD51A23A4;
	Fri,  7 Aug 2026 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065053; cv=none; b=mv/sejhYkQt1cTlqUTd3tV/3NCTll5z3HbfJcww6OkogANNbmTJw1nVRZAm3xHVjR+lYGAmpahOCbwytjubdwjl+EZ1wR6QR502HYvV31DO1+pB+97pOVcpu2bdHo9fDWo+echxNo6Q0qxXk8Hbt5GRAK002VrgFjlqpuTraqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065053; c=relaxed/simple;
	bh=teQJ+jrgR228ke7WIo9s2oh2+qyd8E6hI2RKbFS4GtY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O2kvRpUHw4eP3x9nbHg7fXAwzgYDFQ3cEZAvrBhZWZCoQd7sFyO2xPWqj2/AElEepYCvl8R+eCLNdSnNoG54scW66g94odTO7XVmzCCnYprDm8aaQQ5fhpX1niW4E6tCg8f0g2maL9A5j9uECHwgdqGzN1XHKqlG6muunb2hgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axx+qXMHVqLSoLAA--.35791S3;
	Fri, 07 Aug 2026 09:10:47 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxPcWWMHVqqG0mAA--.9407S2;
	Fri, 07 Aug 2026 09:10:46 +0800 (CST)
Subject: Re: [PATCH v2 5/5] LoongArch: KVM: Enable separate vmid feature
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-6-maobibo@loongson.cn>
 <CAAhV-H6cTtqzCGfr5aZNgpPBpG1YLkmZ9axq45ViAf2_x69fjg@mail.gmail.com>
 <ae64693c-0c99-9de9-c4d9-ed5ab6e55506@loongson.cn>
 <CAAhV-H72fu7_WysWr1XWbFUbnw2cwcCUMgT1AZGnABpAgAd6xg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <97a73cc5-6ad2-9019-23e1-f79101e4ab2b@loongson.cn>
Date: Fri, 7 Aug 2026 09:10:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H72fu7_WysWr1XWbFUbnw2cwcCUMgT1AZGnABpAgAd6xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxPcWWMHVqqG0mAA--.9407S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW8Kr18Gr1DGr43Xr47trc_yoWrZF17pr
	yUAFyDJrWUuryfG3WqqwnYqr90q3s7K3W2qFn7t34FyrnIgFWxJF1Dtr9rCF1rWw4rJry0
	9FnYkFsI9FZrt3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=



On 2026/8/6 下午9:03, Huacai Chen wrote:
> On Thu, Aug 6, 2026 at 8:55 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/8/6 下午8:39, Huacai Chen wrote:
>>> Hi, Bibo,
>>>
>>> On Thu, Aug 6, 2026 at 10:15 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
>>>> feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
>>>> this feature if cpu_has_guestid is true when LVZ is enabled and the LVZ
>>>> version is 2.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/loongarch.h | 5 +++++
>>>>    arch/loongarch/kernel/cpu-probe.c      | 6 ++++++
>>>>    arch/loongarch/kvm/main.c              | 4 +++-
>>>>    3 files changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
>>>> index 2a6bc99177d8..a20fb68d8ac4 100644
>>>> --- a/arch/loongarch/include/asm/loongarch.h
>>>> +++ b/arch/loongarch/include/asm/loongarch.h
>>>> @@ -138,6 +138,9 @@
>>>>    #define  CPUCFG6_PMBITS_SHIFT          8
>>>>    #define  CPUCFG6_UPM                   BIT(14)
>>>>
>>>> +#define LOONGARCH_CPUCFG8              0x8
>>>> +#define  CPUCFG8_VMID                  BIT(8)
>>>> +
>>>>    #define LOONGARCH_CPUCFG16             0x10
>>>>    #define  CPUCFG16_L1_IUPRE             BIT(0)
>>>>    #define  CPUCFG16_L1_IUUNIFY           BIT(1)
>>>> @@ -350,6 +353,8 @@
>>>>    #define  CSR_GTLBC_TGID_WIDTH          8
>>>>    #define  CSR_GTLBC_TGID_SHIFT_END      (CSR_GTLBC_TGID_SHIFT + CSR_GTLBC_TGID_WIDTH - 1)
>>>>    #define  CSR_GTLBC_TGID                        (_ULCAST_(0xff) << CSR_GTLBC_TGID_SHIFT)
>>>> +#define  CSR_GTLBC_USEVMID_SHIFT       14
>>>> +#define  CSR_GTLBC_USEVMID             (_ULCAST_(0x1) << CSR_GTLBC_USEVMID_SHIFT)
>>>
>>> Other fields in GTLBC is TGID, so it is better to name it
>>> CSR_GTLBC_USETGID, just use vpid/vmid for software purely.
>>    - clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
>>    + clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);
>>
>> There is CSR_GTLBC_USETGID enabled already which it bit 12 :)
> Emmm, what is the difference between bit 12 and bit 14?
CSR_GTLBC_USETGID is choice to use TGID/GID in host mode, including 
refill exception of stage2 mmu or generic host mode.

I agree that vpid/vmid is purely software, and I will find the latest 
manual and check whether bit 14 is updated or not.

Regards
Bibo Mao
> 
> Huacai
> 
>>
>>>
>>>
>>>
>>> Huacai
>>>
>>>>    #define  CSR_GTLBC_TOTI_SHIFT          13
>>>>    #define  CSR_GTLBC_TOTI                        (_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
>>>>    #define  CSR_GTLBC_USETGID_SHIFT       12
>>>> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
>>>> index 74d31f260dfd..fc68f695d49c 100644
>>>> --- a/arch/loongarch/kernel/cpu-probe.c
>>>> +++ b/arch/loongarch/kernel/cpu-probe.c
>>>> @@ -241,6 +241,12 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>>>           if (config & CPUCFG6_PMP)
>>>>                   c->options |= LOONGARCH_CPU_PMP;
>>>>
>>>> +       if (c->options & LOONGARCH_CPU_LVZ) {
>>>> +               config = read_cpucfg(LOONGARCH_CPUCFG8);
>>>> +               if (config & CPUCFG8_VMID)
>>>> +                       c->options |= LOONGARCH_CPU_GUESTID;
>>>> +       }
>>>> +
>>>>           config = csr_read32(LOONGARCH_CSR_ASID);
>>>>           config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
>>>>           asid_mask = GENMASK(config - 1, 0);
>>>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>>>> index 72c1d23156e5..712b078db0d5 100644
>>>> --- a/arch/loongarch/kvm/main.c
>>>> +++ b/arch/loongarch/kvm/main.c
>>>> @@ -359,7 +359,7 @@ int kvm_arch_enable_virtualization_cpu(void)
>>>>           write_csr_gcfg(0);
>>>>           write_csr_gstat(0);
>>>>           write_csr_gintc(0);
>>>> -       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
>>>> +       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);
>>>>
>>>>           /*
>>>>            * Enable virtualization features granting guest direct control of
>>>> @@ -382,6 +382,8 @@ int kvm_arch_enable_virtualization_cpu(void)
>>>>
>>>>           /* Enable using TGID  */
>>>>           set_csr_gtlbc(CSR_GTLBC_USETGID);
>>>> +       if (cpu_has_guestid)
>>>> +               set_csr_gtlbc(CSR_GTLBC_USEVMID);
>>>>           kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
>>>>                     read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), read_csr_gtlbc());
>>>>
>>>> --
>>>> 2.39.3
>>>>
>>

