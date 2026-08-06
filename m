Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CEF2C3768;
	Thu,  6 Aug 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020944; cv=none; b=aLhffZ5yVnDnHSwRXC3wlMrb53oXaWEmayClW+od9sjTc2nM53pUSwHiObPO7EcJh5maD3PpL4UhtYZBGun8N0dqyrE0mwwyKTUoL34hATqG2vGVfOeo187ao125z2S1Pi7Wmzy+BBHEx2E2jfHmu3/xteRoullOuxK1TBQgMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020944; c=relaxed/simple;
	bh=Zst489Id8XlIVDJUcBN3aY+wige+2/itL+QAeIOG1yc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jshTXJuhUb+AIQXdlR1oNKgwVq7W/Sx/WsKnOfUaI8U94IxG6r4XN/YBWxzNNNuFIHfELHs2ZdEmdlq0xfxxe6QD+tg2wQQaFz2FJvFmo1xUeatxifK72GuRFeS5m70quIX2yMAFbUPCxBe9ysqO9bKrfUxLvfFg9FQe2JlPSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cxg+hLhHRqpv0KAA--.12319S3;
	Thu, 06 Aug 2026 20:55:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxDcdIhHRqEM4lAA--.7143S2;
	Thu, 06 Aug 2026 20:55:38 +0800 (CST)
Subject: Re: [PATCH v2 5/5] LoongArch: KVM: Enable separate vmid feature
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-6-maobibo@loongson.cn>
 <CAAhV-H6cTtqzCGfr5aZNgpPBpG1YLkmZ9axq45ViAf2_x69fjg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <ae64693c-0c99-9de9-c4d9-ed5ab6e55506@loongson.cn>
Date: Thu, 6 Aug 2026 20:55:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6cTtqzCGfr5aZNgpPBpG1YLkmZ9axq45ViAf2_x69fjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDcdIhHRqEM4lAA--.7143S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrWUuFyDZr4UKw43Aw1DurX_yoWrJFWkpr
	yUAF9rJrWUuryfG3Z0qwnYvr98Xws2g3W2gFn7ta4SyFnIgFW8tF1kK3sxWF15Ww4Fyry0
	9rnY9FsIvFZFy3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2026/8/6 下午8:39, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Aug 6, 2026 at 10:15 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
>> feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
>> this feature if cpu_has_guestid is true when LVZ is enabled and the LVZ
>> version is 2.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/loongarch.h | 5 +++++
>>   arch/loongarch/kernel/cpu-probe.c      | 6 ++++++
>>   arch/loongarch/kvm/main.c              | 4 +++-
>>   3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
>> index 2a6bc99177d8..a20fb68d8ac4 100644
>> --- a/arch/loongarch/include/asm/loongarch.h
>> +++ b/arch/loongarch/include/asm/loongarch.h
>> @@ -138,6 +138,9 @@
>>   #define  CPUCFG6_PMBITS_SHIFT          8
>>   #define  CPUCFG6_UPM                   BIT(14)
>>
>> +#define LOONGARCH_CPUCFG8              0x8
>> +#define  CPUCFG8_VMID                  BIT(8)
>> +
>>   #define LOONGARCH_CPUCFG16             0x10
>>   #define  CPUCFG16_L1_IUPRE             BIT(0)
>>   #define  CPUCFG16_L1_IUUNIFY           BIT(1)
>> @@ -350,6 +353,8 @@
>>   #define  CSR_GTLBC_TGID_WIDTH          8
>>   #define  CSR_GTLBC_TGID_SHIFT_END      (CSR_GTLBC_TGID_SHIFT + CSR_GTLBC_TGID_WIDTH - 1)
>>   #define  CSR_GTLBC_TGID                        (_ULCAST_(0xff) << CSR_GTLBC_TGID_SHIFT)
>> +#define  CSR_GTLBC_USEVMID_SHIFT       14
>> +#define  CSR_GTLBC_USEVMID             (_ULCAST_(0x1) << CSR_GTLBC_USEVMID_SHIFT)
> 
> Other fields in GTLBC is TGID, so it is better to name it
> CSR_GTLBC_USETGID, just use vpid/vmid for software purely.
  - clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
  + clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);

There is CSR_GTLBC_USETGID enabled already which it bit 12 :)

> 
> 
> 
> Huacai
> 
>>   #define  CSR_GTLBC_TOTI_SHIFT          13
>>   #define  CSR_GTLBC_TOTI                        (_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
>>   #define  CSR_GTLBC_USETGID_SHIFT       12
>> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
>> index 74d31f260dfd..fc68f695d49c 100644
>> --- a/arch/loongarch/kernel/cpu-probe.c
>> +++ b/arch/loongarch/kernel/cpu-probe.c
>> @@ -241,6 +241,12 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>          if (config & CPUCFG6_PMP)
>>                  c->options |= LOONGARCH_CPU_PMP;
>>
>> +       if (c->options & LOONGARCH_CPU_LVZ) {
>> +               config = read_cpucfg(LOONGARCH_CPUCFG8);
>> +               if (config & CPUCFG8_VMID)
>> +                       c->options |= LOONGARCH_CPU_GUESTID;
>> +       }
>> +
>>          config = csr_read32(LOONGARCH_CSR_ASID);
>>          config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
>>          asid_mask = GENMASK(config - 1, 0);
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index 72c1d23156e5..712b078db0d5 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
>> @@ -359,7 +359,7 @@ int kvm_arch_enable_virtualization_cpu(void)
>>          write_csr_gcfg(0);
>>          write_csr_gstat(0);
>>          write_csr_gintc(0);
>> -       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
>> +       clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);
>>
>>          /*
>>           * Enable virtualization features granting guest direct control of
>> @@ -382,6 +382,8 @@ int kvm_arch_enable_virtualization_cpu(void)
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

