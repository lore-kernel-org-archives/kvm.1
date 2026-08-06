Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5F244692;
	Thu,  6 Aug 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020093; cv=none; b=rliNvQYF1U2T2NABuDXvrofn2U0N3xlZIOeo+DPAlhZxryi8zWr9nkm4Twwvnl6pQRpKgGTlC9h5EPX13FeGt5KJhUAb9239WlwfW8QYVCSGugXGHULC1K3CRI7YRVq5oanLRA7DqU5eMC8FmOo3RCtzC1caDrdrzD51n3ImC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020093; c=relaxed/simple;
	bh=7/79YcPWnsZaTFlF+zGJP4vx3dPwpCHlA3yoxEeiqb0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TbEeLUxZnNke5DSjUXSieyk+eo3jegYsLt/tGwG+PyiLFXOYsJ0pVR3RQDlWa/BJb5j1qMHu34ZLqEIO/DUAKpyagbqyQCS+gNgBnX0fOxCsqjSI/Pn7rZU3m/b5u+j1w4hBVAB6AYjZaAVuG3UNsGCKj2YgXqd5v9WHYNIZvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cxg+jwgHRq1vwKAA--.12310S3;
	Thu, 06 Aug 2026 20:41:20 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxu8TvgHRqoMolAA--.21814S2;
	Thu, 06 Aug 2026 20:41:19 +0800 (CST)
Subject: Re: [PATCH v2 3/5] LoongArch: KVM: Add separate vmid feature support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-4-maobibo@loongson.cn>
 <CAAhV-H5vPyKNR63hzxWkyZzyEJ09DtuudqTaiQHCfxai6S23DQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <348e08a8-0e3b-5879-fe6f-155f02b69c41@loongson.cn>
Date: Thu, 6 Aug 2026 20:41:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5vPyKNR63hzxWkyZzyEJ09DtuudqTaiQHCfxai6S23DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxu8TvgHRqoMolAA--.21814S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW8AFy3tw13Zry5uw4xXwc_yoW5CFy7pr
	97C3ZYqr4FkrnrXa4Iqwn0qr4jv3yDKr1IvFy2vFy0kr1qqrnYka1kCrZ8ZF15J34rCF4I
	vF1rtFnIvF1DC3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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



On 2026/8/6 下午8:23, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Aug 6, 2026 at 10:15 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Feature cpu_has_guestid is used to check whether separate vmid/vpid
>> is supported or not. It is disabled by default, add this feature
>> checking, there is no function change.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kvm/main.c | 14 +++++++++-----
>>   arch/loongarch/kvm/mmu.c  |  6 ++++--
>>   arch/loongarch/kvm/vcpu.c |  3 ++-
>>   3 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index ac804e77e844..c36e62ab0d91 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
>> @@ -218,7 +218,8 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
>>                  ++vpid; /* vpid 0 reserved for root */
>>
>>                  /* start new vpid cycle */
>> -               kvm_flush_tlb_all();
>> +               if (!cpu_has_guestid)
>> +                       kvm_flush_tlb_all();
>>          }
>>
>>          context->vpid_cache = vpid;
>> @@ -282,10 +283,13 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
>>   {
>>          unsigned long vmid;
>>
>> -       vmid = vcpu->arch.vpid & vpid_mask;
>> -       if (vcpu->arch.hw_vmid != vmid) {
>> -               vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
>> -               kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>> +       /* On some machines like 3A5000, vmid needs the same with vpid */
>> +       if (!cpu_has_guestid) {
>> +               vmid = vcpu->arch.vpid & vpid_mask;
>> +               if (vcpu->arch.hw_vmid != vmid) {
>> +                       vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
>> +                       kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>> +               }
> Merge Patch#3 and Patch#4, then __kvm_check_vmid() can handle both
> cpu_has_guestid and !cpu_has_guestid cases together.
will merge Patch#3 and Patch#4 together in next version.

Regards
Bibo Mao

> 
> 
> Huacai
> 
>>          }
>>   }
>>
>> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
>> index e104897aa532..714640a2e614 100644
>> --- a/arch/loongarch/kvm/mmu.c
>> +++ b/arch/loongarch/kvm/mmu.c
>> @@ -929,8 +929,10 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long gpa, bool write, in
>>                   *
>>                   * With SW PTW, invalid TLB is added in TLB refill exception.
>>                   */
>> -               vcpu->arch.flush_gpa = gpa;
>> -               kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>> +               if (!cpu_has_guestid) {
>> +                       vcpu->arch.flush_gpa = gpa;
>> +                       kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>> +               }
>>          }
>>
>>          return 0;
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 20c207d80e31..0b2355aec932 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -210,7 +210,8 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
>>                  return RESUME_GUEST;
>>
>>          if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
>> -               vcpu->arch.vpid = 0;  /* Drop vpid for this vCPU */
>> +               if (!cpu_has_guestid)
>> +                       vcpu->arch.vpid = 0;  /* Drop vpid for this vCPU */
>>
>>          if (kvm_dirty_ring_check_request(vcpu))
>>                  return RESUME_HOST;
>> --
>> 2.39.3
>>

