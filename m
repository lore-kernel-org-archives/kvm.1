Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F024428314C;
	Wed,  5 Aug 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896434; cv=none; b=iRNEJPFKC7v/JLHm9Av4WP7zVPmG1+/rvpfgasxi0OS5zcurgd1TSB7Hi2iQtLxTOSc7ryE5M2jfkNr+e2qi9jm7aFB4oTDd4ZWdw1eGeQiPH99nnzd8cqfLC5JA45ayBrJEJqZc4iQvM2OHv4l8ArKlZgFrlILIO8svToN8snQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896434; c=relaxed/simple;
	bh=/KhJUy5z63IL9mVD0kb1U6UNd4lVrK4bNzt+ERSwiMk=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RoOrImIcDzn0Q7/x8DYZBKHMZ+iqqcmM9Cyljx/NYrqu8BR8sngSY7dZc5TSBPcOflDyRF2gz45Uuy8hXhz/G8KxESiRxNVsFIAto/arBTy+8pmKc2T1/J9Ae0FWJZEyXaaGML9TjwtXQ/ayDU/EIavD/C/c9jVw76ff8fAJcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxuvDmnXJq8IAKAA--.34203S3;
	Wed, 05 Aug 2026 10:20:22 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPsfanXJq8SskAA--.3589S2;
	Wed, 05 Aug 2026 10:20:13 +0800 (CST)
Subject: Re: [PATCH 1/6] LoongArch: KVM: Add vmid support for stage2 MMU
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260727072109.2151675-1-maobibo@loongson.cn>
 <20260727072109.2151675-2-maobibo@loongson.cn>
 <CAAhV-H6sEXa6XM-4=OTuPw=gNKgVxC7ZwqO6T-F81pvt_gBN8Q@mail.gmail.com>
 <dc67eb43-adb2-c26b-a54f-ccd52ce910eb@loongson.cn>
 <CAAhV-H7C+NbBOWtypwaLrn5Ehc6kv=W2jABz=r4O941QjAWhvQ@mail.gmail.com>
 <ba9ef849-65c7-b377-e5f5-9c6ca4a712c7@loongson.cn>
 <6fe4816a-5b78-3d58-cb7b-3ac817791104@loongson.cn>
Message-ID: <56a9a272-d8e5-75e8-0cca-b109a663a6c9@loongson.cn>
Date: Wed, 5 Aug 2026 10:19:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6fe4816a-5b78-3d58-cb7b-3ac817791104@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPsfanXJq8SskAA--.3589S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr18CFy7Jw4xGFW7tryUtwc_yoW3Zr4kpr
	ykAF1kJrWrGr1kJw1jqw18Xryjqr1UKw1UXr1UJFy8JrsFqF1jqr48Wr1q9F15Jw4rJF10
	qr15Jr17ZF1UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU



On 2026/8/5 上午9:27, Bibo Mao wrote:
> 
> 
> On 2026/8/5 上午9:21, Bibo Mao wrote:
>>
>>
>> On 2026/8/4 下午10:14, Huacai Chen wrote:
>>> On Mon, Aug 3, 2026 at 9:21 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/8/2 下午10:11, Huacai Chen wrote:
>>>>> Hi, Bibo,
>>>>>
>>>>> On Mon, Jul 27, 2026 at 3:29 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>> LoongArch KVM hypervisor supports two-level MMU, vpid index is used
>>>>>> for stage1 MMU and vmid index is used for stage2 MMU.
>>>>>>
>>>>>> On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
>>>>>> may separate from vpid. If vcpu migrate to different physical CPUs,
>>>>>> vpid need change however vmid can keep the same with old value. Also
>>>>>> vmid index of the while VM machine on physical CPU the same, all 
>>>>>> vCPUs
>>>>>> on the VM can share the same vmid index on one physical CPU.
>>>>>>
>>>>>> Here vmid index is added and it keeps the same with vpid still.
>>>>>>
>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>> ---
>>>>>>    arch/loongarch/include/asm/kvm_host.h | 3 +++
>>>>>>    arch/loongarch/kernel/asm-offsets.c   | 1 +
>>>>>>    arch/loongarch/kvm/main.c             | 1 +
>>>>>>    arch/loongarch/kvm/switch.S           | 5 ++---
>>>>>>    arch/loongarch/kvm/tlb.c              | 5 ++++-
>>>>>>    5 files changed, 11 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/loongarch/include/asm/kvm_host.h 
>>>>>> b/arch/loongarch/include/asm/kvm_host.h
>>>>>> index 23cfbecebbd7..ec7b0c402385 100644
>>>>>> --- a/arch/loongarch/include/asm/kvm_host.h
>>>>>> +++ b/arch/loongarch/include/asm/kvm_host.h
>>>>>> @@ -189,6 +189,9 @@ struct kvm_vcpu_arch {
>>>>>>           unsigned long host_tp;
>>>>>>           unsigned long host_pgd;
>>>>>>
>>>>>> +       /* vmid info for guest VM */
>>>>>> +       unsigned long vmid;
>>>>> Put it near vpid?
>>>> yes, it it better to near vpid. will do this.
>>>>>
>>>>>> +
>>>>>>           /* Host CSRs are used when handling exits from guest */
>>>>>>           unsigned long badi;
>>>>>>           unsigned long badv;
>>>>>> diff --git a/arch/loongarch/kernel/asm-offsets.c 
>>>>>> b/arch/loongarch/kernel/asm-offsets.c
>>>>>> index 1b861cbc5e10..32ef6adfc8dd 100644
>>>>>> --- a/arch/loongarch/kernel/asm-offsets.c
>>>>>> +++ b/arch/loongarch/kernel/asm-offsets.c
>>>>>> @@ -300,6 +300,7 @@ static void __used output_kvm_defines(void)
>>>>>>           OFFSET(KVM_ARCH_HSP, kvm_vcpu_arch, host_sp);
>>>>>>           OFFSET(KVM_ARCH_HTP, kvm_vcpu_arch, host_tp);
>>>>>>           OFFSET(KVM_ARCH_HPGD, kvm_vcpu_arch, host_pgd);
>>>>>> +       OFFSET(KVM_ARCH_VMID, kvm_vcpu_arch, vmid);
>>>>>>           OFFSET(KVM_ARCH_KVMPGD, kvm_vcpu_arch, kvm_pgd);
>>>>>>           OFFSET(KVM_ARCH_HANDLE_EXIT, kvm_vcpu_arch, handle_exit);
>>>>>>           OFFSET(KVM_ARCH_HEENTRY, kvm_vcpu_arch, host_eentry);
>>>>>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>>>>>> index 3e1005526f4b..6e3e8efa1dc2 100644
>>>>>> --- a/arch/loongarch/kvm/main.c
>>>>>> +++ b/arch/loongarch/kvm/main.c
>>>>>> @@ -223,6 +223,7 @@ static void kvm_update_vpid(struct kvm_vcpu 
>>>>>> *vcpu, int cpu)
>>>>>>
>>>>>>           context->vpid_cache = vpid;
>>>>>>           vcpu->arch.vpid = vpid;
>>>>>> +       vcpu->arch.vmid = vcpu->arch.vpid & vpid_mask;
>>>>>
>>>>> I think both vpid and vmid need "& vpid_mask".
>>>> vpid used in function kvm_check_vcpuid() includes version information
>>>> also. vmid here is hardware id directly used by LOONGARCH_CSR_GTLBC in
>>>> arch/loongarch/kvm/switch.S.
>>> I'm not sure, but it seems both vpid and vmid have a sw version and a
>>> hw version? The hw version will be written into register so its width
>>> is limited, while the sw version is 64bit. If I'm right, I think the
>> yes, it is.
>>
>>> "& vpid_mask" is only used when writing registers, in other places
>>> they are full 64bit (in other words, they need the same treatment).
>> If vmid includes version, it requires one extra shift operation when 
>> writing to real HW in file arch/loongarch/kvm/switch.S.
>> -       /* Mix GID and RID */
>> -       csrrd           t1, LOONGARCH_CSR_GSTAT
>> -       bstrpick.w      t1, t1, CSR_GSTAT_GID_SHIFT_END, 
>> CSR_GSTAT_GID_SHIFT
>> +       /* Set VMID for gpa --> hpa mapping */
>> +       ld.d            t1, a2, KVM_ARCH_VMID
>>           csrrd           t0, LOONGARCH_CSR_GTLBC
>>           bstrins.w       t0, t1, CSR_GTLBC_TGID_SHIFT_END,
>>
>> vpid is per-vcpu and it is represented with *vcpu->arch.vpid*, vmid is 
>> per-vm,it is shared by vCPUs and represented with 
>> *vcpu->kvm->arch.vmid[cpu]*. Instead arch.vmid is special for HW 
>> register writing with LOONGARCH_CSR_GTLBC, if there is misleading, how 
>> about renaming it with hw_vmid?
> hw_vmid is strange, I am ok with vmid with version information, so that 
> the name is clear, one shift assemble code is not too much. Will change 
> in the next version.
Sorry to response too hurry. If vmid represents software version, it is 
hard to write with assemble language such as:
+  /* Set VMID for gpa --> hpa mapping */
+       ld.d            t1, a2, KVM_ARCH_VMID
+        ld.d            t0, vpid_mask
module variable vpid_mask need export and put in structure kvm_vcpu_arch.
+        add             t1, t1, t0
         csrrd           t0, LOONGARCH_CSR_GTLBC

Regards
Bibo Mao
> 
> Regards
> Bibo Mao
>>
>> Regards
>>
>>
>>>
>>> Huacai
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>>
>>>>>
>>>>> Huacai
>>>>>
>>>>>>    }
>>>>>>
>>>>>>    void kvm_check_vpid(struct kvm_vcpu *vcpu)
>>>>>> diff --git a/arch/loongarch/kvm/switch.S 
>>>>>> b/arch/loongarch/kvm/switch.S
>>>>>> index 936e4ae3e408..af972394fd55 100644
>>>>>> --- a/arch/loongarch/kvm/switch.S
>>>>>> +++ b/arch/loongarch/kvm/switch.S
>>>>>> @@ -66,9 +66,8 @@
>>>>>>           ld.d    t0, a2, KVM_ARCH_KVMPGD
>>>>>>           csrwr   t0, LOONGARCH_CSR_PGDL
>>>>>>
>>>>>> -       /* Mix GID and RID */
>>>>>> -       csrrd           t1, LOONGARCH_CSR_GSTAT
>>>>>> -       bstrpick.w      t1, t1, CSR_GSTAT_GID_SHIFT_END, 
>>>>>> CSR_GSTAT_GID_SHIFT
>>>>>> +       /* Set VMID for gpa --> hpa mapping */
>>>>>> +       ld.d            t1, a2, KVM_ARCH_VMID
>>>>>>           csrrd           t0, LOONGARCH_CSR_GTLBC
>>>>>>           bstrins.w       t0, t1, CSR_GTLBC_TGID_SHIFT_END, 
>>>>>> CSR_GTLBC_TGID_SHIFT
>>>>>>           csrwr           t0, LOONGARCH_CSR_GTLBC
>>>>>> diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
>>>>>> index ebdbe9264e9c..38daf936021d 100644
>>>>>> --- a/arch/loongarch/kvm/tlb.c
>>>>>> +++ b/arch/loongarch/kvm/tlb.c
>>>>>> @@ -23,7 +23,10 @@ void kvm_flush_tlb_all(void)
>>>>>>
>>>>>>    void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa)
>>>>>>    {
>>>>>> +       unsigned int vmid;
>>>>>> +
>>>>>>           lockdep_assert_irqs_disabled();
>>>>>>           gpa &= (PAGE_MASK << 1);
>>>>>> -       invtlb(INVTLB_GID_ADDR, read_csr_gstat() & CSR_GSTAT_GID, 
>>>>>> gpa);
>>>>>> +       vmid = (vcpu->arch.vmid << CSR_GSTAT_GID_SHIFT) & 
>>>>>> CSR_GSTAT_GID;
>>>>>> +       invtlb(INVTLB_GID_ADDR, vmid, gpa);
>>>>>>    }
>>>>>> -- 
>>>>>> 2.39.3
>>>>>>
>>>>

