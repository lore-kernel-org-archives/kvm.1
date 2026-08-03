Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DD1FFC48;
	Mon,  3 Aug 2026 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720396; cv=none; b=TDRRmtJZ2xvbW0XWF/pl4jKUO9TvYDtoZLtD0m6Wd3/va0AnGVIxd60d3Dq7TjFelZegV5GH8ddDY79UI0Qatmb6eBu/sFCcGwrurjMhhj4xzvd0j2lGkP5eSvGZ9rh8uG9BPgik03Cdt8ejGKae1cg72bVkXkTn9bH2IdFOeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720396; c=relaxed/simple;
	bh=8ILm0spJYr+SRR0E44DKXFSzW3Y5RThqkAFqb9vxXKk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cB/H+NCefl5CSTGy8VOfUdH3igOy97SMFYVU96gj29lcjv+RHJ5nOtnNde/b59jBXjWaGj7x88mv/xGVkmgqQdsBjnRK0tgJFxCLJ18Bt9NG4gSBgEtad+pdvUF8WTugvOC7fSK/DLZ322wDf3jlWChC5D55Xf78GaisdmMsMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxJOhJ7m9qUMQJAA--.9240S3;
	Mon, 03 Aug 2026 09:26:33 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxDcdF7m9qupQhAA--.50067S2;
	Mon, 03 Aug 2026 09:26:32 +0800 (CST)
Subject: Re: [PATCH 6/6] LoongArch: KVM: Enable separate vmid feature
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260727072109.2151675-1-maobibo@loongson.cn>
 <20260727072109.2151675-7-maobibo@loongson.cn>
 <CAAhV-H46JoQpPx4Eg1eGT010Gq_4OnLNExhVrgjkdXkeoHESCA@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <92446f9b-3484-880b-5871-4ebfe26feb81@loongson.cn>
Date: Mon, 3 Aug 2026 09:26:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H46JoQpPx4Eg1eGT010Gq_4OnLNExhVrgjkdXkeoHESCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDcdF7m9qupQhAA--.50067S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFyDKr47Ar4kGryfJw47trc_yoW5Kw43pr
	yUAFsrJrW8ur93Ga4qqwn5Xr98XrsFg3W2gFn7Ja4FyFnFgFW8tF1kK3s8ZF15Ww4xtFyF
	9F9Yka9IvFsFy3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU



On 2026/8/2 下午10:14, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Mon, Jul 27, 2026 at 3:31 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
>> feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
>> this feature if cpu_has_guestid is true when LVZ is enabled and the LVZ
>> version is 2.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/loongarch.h | 2 ++
>>   arch/loongarch/kernel/cpu-probe.c      | 7 ++++++-
>>   arch/loongarch/kvm/main.c              | 4 +++-
>>   3 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
>> index 2a6bc99177d8..4c4249446a61 100644
>> --- a/arch/loongarch/include/asm/loongarch.h
>> +++ b/arch/loongarch/include/asm/loongarch.h
>> @@ -350,6 +350,8 @@
>>   #define  CSR_GTLBC_TGID_WIDTH          8
>>   #define  CSR_GTLBC_TGID_SHIFT_END      (CSR_GTLBC_TGID_SHIFT + CSR_GTLBC_TGID_WIDTH - 1)
>>   #define  CSR_GTLBC_TGID                        (_ULCAST_(0xff) << CSR_GTLBC_TGID_SHIFT)
>> +#define  CSR_GTLBC_USEVMID_SHIFT       14
>> +#define  CSR_GTLBC_USEVMID             (_ULCAST_(0x1) << CSR_GTLBC_USEVMID_SHIFT)
>>   #define  CSR_GTLBC_TOTI_SHIFT          13
>>   #define  CSR_GTLBC_TOTI                        (_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
>>   #define  CSR_GTLBC_USETGID_SHIFT       12
>> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
>> index 74d31f260dfd..cbf1dafac0a0 100644
>> --- a/arch/loongarch/kernel/cpu-probe.c
>> +++ b/arch/loongarch/kernel/cpu-probe.c
>> @@ -135,7 +135,7 @@ static void set_isa(struct cpuinfo_loongarch *c, unsigned int isa)
>>
>>   static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>   {
>> -       unsigned int config;
>> +       unsigned int config, version;
>>          unsigned long asid_mask;
>>
>>          c->options = LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR | LOONGARCH_CPU_VINT;
>> @@ -221,6 +221,11 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>          if (config & CPUCFG2_LVZP) {
>>                  c->options |= LOONGARCH_CPU_LVZ;
>>                  elf_hwcap |= HWCAP_LOONGARCH_LVZ;
>> +
>> +               /* Separate VMID and VPID with LVZ version == 2 */
>> +               version = (config & CPUCFG2_LVZVER) >> 11;
>> +               if (version == 2)
> I think ">1" judgement is better than "==2".
I am ok with "> 1" and it is better from software side, only that it 
requires that HW keeps compatible with later LVZ function. Will discuss 
this with HW guys.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>> +                       c->options |= LOONGARCH_CPU_GUESTID;
>>          }
>>   #ifdef CONFIG_CPU_HAS_LBT
>>          if (config & CPUCFG2_X86BT) {
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index 86b1af823e2b..43f5b40786f2 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
>> @@ -365,7 +365,7 @@ int kvm_arch_enable_virtualization_cpu(void)
>>          write_csr_gcfg(0);
>>          write_csr_gstat(0);
>>          write_csr_gintc(0);
>> -       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
>> +       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);
>>
>>          /*
>>           * Enable virtualization features granting guest direct control of
>> @@ -388,6 +388,8 @@ int kvm_arch_enable_virtualization_cpu(void)
>>
>>          /* Enable using TGID  */
>>          set_csr_gtlbc(CSR_GTLBC_USETGID);
>> +       if (cpu_has_guestid)
>> +               set_csr_gtlbc(CSR_GTLBC_USEVMID);
>>          kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
>>                    read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), read_csr_gtlbc());
>>
>> --
>> 2.39.3
>>
>>

