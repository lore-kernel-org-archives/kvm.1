Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2028D8D0;
	Mon,  3 Aug 2026 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720180; cv=none; b=kIcnf4hWdQ3+bCuc0VXadZ0/+b/kuoJlkvN1Qzb2/aLC/Z9AuheP7nY0cBDwo1SaTq0Jm7C6TQsP33eAWIIm5R7AwE1CBHpv5O6qbnDeUJnztQHz/g4VVpMg3NmulaWMB9WVJG4xnsxsVb480D9Nwhy7b1qldwsq3NbrbnHKxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720180; c=relaxed/simple;
	bh=4SVKUQ5C+RNfPmLQmFOmDmypMPHE4pEDV8h36DJoUuE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mkVV1MrdlhpKevmF94VRsImDzy5BPieqMJe1QpzSfMopAu7yicOdXjXQr8v2rl1AC6f6jg2dO3H4WYa4u6P/ny7FgwDy2nLK4IszdGWOIgaTc3NfXawsywE+LC8R3OzDO1yaBAVXqPutJAWctGKTWd+aovUBkkSZdPyzlUP+qGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxKfBw7W9q9MMJAA--.32275S3;
	Mon, 03 Aug 2026 09:22:56 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxu8Rv7W9qE5QhAA--.64560S2;
	Mon, 03 Aug 2026 09:22:56 +0800 (CST)
Subject: Re: [PATCH 2/6] LoongArch: KVM: Add separate vCPU and VM id update
 function
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260727072109.2151675-1-maobibo@loongson.cn>
 <20260727072109.2151675-3-maobibo@loongson.cn>
 <CAAhV-H7dydcNDNh32cZS5=HhHPE01hdZzEy-vj=5cBEA_b7Xug@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <28ff9029-050d-1e19-d2f9-19a30418c55f@loongson.cn>
Date: Mon, 3 Aug 2026 09:22:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7dydcNDNh32cZS5=HhHPE01hdZzEy-vj=5cBEA_b7Xug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxu8Rv7W9qE5QhAA--.64560S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWDWF17ur15Wr15GF1fZrc_yoW5Jry7pF
	yxu3WYga1kZr13C34Utr1vgFn0v3ykKr17ZFy7GFy5Jr1ktrnrKrWkG3y5ZFy5JryFka1S
	vF1rtF13CF1qkacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU



On 2026/8/2 下午10:12, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Mon, Jul 27, 2026 at 3:29 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> There are two-level MMU on LoongArch KVM system, the first level (stage1)
>> MMU is mapping for GVA --> GPA, the second level (stage2) is mapping
>> for GPA --> HPA. Similar with ASID, there is different ID management
>> to support multiple VMs and vCPUs. The stage1 MMU is called vCPUID, and
>> the second MMU is called VMID, the corresponding ID management function
>> is kvm_check_vcpuid() and kvm_check_vmid().
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kvm/main.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index 6e3e8efa1dc2..c1e1d8424fa7 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
>> @@ -223,10 +223,9 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
>>
>>          context->vpid_cache = vpid;
>>          vcpu->arch.vpid = vpid;
>> -       vcpu->arch.vmid = vcpu->arch.vpid & vpid_mask;
>>   }
>>
>> -void kvm_check_vpid(struct kvm_vcpu *vcpu)
>> +static void kvm_check_vcpuid(struct kvm_vcpu *vcpu)
>>   {
>>          int cpu;
>>          bool migrated;
>> @@ -254,7 +253,6 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
>>                  kvm_update_vpid(vcpu, cpu);
>>                  trace_kvm_vpid_change(vcpu, vcpu->arch.vpid);
>>                  vcpu->cpu = cpu;
>> -               kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>>
>>                  /*
>>                   * LLBCTL is a separated guest CSR register from host, a general
>> @@ -280,6 +278,23 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
>>          }
>>   }
>>
>> +static void kvm_check_vmid(struct kvm_vcpu *vcpu)
>> +{
>> +       unsigned long vmid;
>> +
>> +       vmid = vcpu->arch.vpid & vpid_mask;
>> +       if (vcpu->arch.vmid != vmid) {
>> +               vcpu->arch.vmid = vmid;
>> +               kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>> +       }
>> +}
>> +
>> +void kvm_check_vpid(struct kvm_vcpu *vcpu)
>> +{
>> +       kvm_check_vcpuid(vcpu);
>> +       kvm_check_vmid(vcpu);
>> +}
> I think the previous naming is a little better:
> 
> +void kvm_check_vpid(struct kvm_vcpu *vcpu)
> +{
> + __kvm_check_vpid(vcpu);
> + __kvm_check_vmid(vcpu);
> +}
function name kvm_check_vcpuid() is actually strange, will do in this way.

Regards
Bibo Mao
> 
> 
> Huacai
> 
> 
>> +
>>   void kvm_init_vmcs(struct kvm *kvm)
>>   {
>>          kvm->arch.vmcs = vmcs;
>> --
>> 2.39.3
>>

