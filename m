Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66431DC985
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985234; cv=none; b=Ebl3nlwEAwJXYYPFDrzeiXyC8J/UuR9+eHeHp1/6bmlyTLPs4LHWihTGJKZNPyAX0cj57LO+uD9kekPmpn1hJ4j5vWQVYgZmAI/Kf39YdtMOAZIidqTBDw/qGghovpBiiU7tErqC+zhWqy0kvvNYNN4hfAMPjo0z4lkZuJlk1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985234; c=relaxed/simple;
	bh=mBMqnuqIgym0XsMK+vXWaxKHTKQcf3JZcYF1Zl43iUY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MdIa5WwiWztQ4M4Qn6pQMLZb2/ANXIfHCTgkWrURKD/VK/cba/qJrt0vDRKFm0ukTphM4Y3H5jbTXRG+9PNfF5DrUL5SBf355e4tHcUXOMhYA4Cg5uxFiFd+h/E36Lse4+Cs91U2LqKbdsqLaWsv9JTa1+0mtqNvt9g+e55cM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dx8+nG+HNqt98KAA--.25637S3;
	Thu, 06 Aug 2026 11:00:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxbQfF+HNqslglAA--.1566S2;
	Thu, 06 Aug 2026 11:00:21 +0800 (CST)
Subject: Re: [PATCH v2 4/5] LoongArch: KVM: Implement vmid updating logic
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-5-maobibo@loongson.cn>
 <20260806023024.7ACCE1F000E9@smtp.kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4f1446f5-1972-897d-d116-cc9638d2b6e0@loongson.cn>
Date: Thu, 6 Aug 2026 11:00:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260806023024.7ACCE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxbQfF+HNqslglAA--.1566S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurWUAr1UAryfZryUJF4rCrX_yoWrAFWrpF
	W8C3Z0qa18CrnrX340qw4kXr1jg34xGr1xZFyaya4avrn0vr1kGF4vk3ykuFy5JryS9a1I
	vF15Kr9F9F1DCacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
	UUU==



On 2026/8/6 上午10:30, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Missing early return in `__kvm_check_vmid` for machines without guest ID support breaks VMID/VPID synchronization.
> - [Medium] Data race between non-atomic `cpumask_setall()` and atomic bitwise operations on `tlb_flush_pending`.
> - [Low] Dead code: `kvm_arch_flush_remote_tlbs_memslot` is a fictitious arch hook not called by KVM core.
> --
> 
> --- Patch [4]: [PATCH v2 4/5] LoongArch: KVM: Implement vmid updating logic ---
> commit 1626f2256d93ca3c5c607a6a950ca7531c03169a
> Author: Bibo Mao <maobibo@loongson.cn>
> Date:   Thu Aug 6 02:07:38 2026 +0000
> 
>      LoongArch: KVM: Implement vmid updating logic
>      
>      VMID calculation method is the same with ASID on LoongArch, it is
>      percpu vmid calculation method. For every physical CPU, VMID of
>      different VM is different, and it is the same for different vCPUs
>      of the same VM.
> 
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index c36e62ab0d917..72c1d23156e50 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
> [ ... ]
>> @@ -291,6 +316,20 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
>>   			kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>>   		}
>>   	}
>> +
>> +	cpu = smp_processor_id();
>> +	if (cpumask_test_and_clear_cpu(cpu, &vcpu->kvm->arch.tlb_flush_pending))
>> +		vcpu->kvm->arch.vmid[cpu] = 0;
>> +
>> +	/*
>> +	 * Check if our vmid is of an older version
>> +	 */
>> +	ver = vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
>> +	old = this_cpu_ptr(vcpu->kvm->arch.vmcs)->vmid_cache & ~vpid_mask;
>> +	if (ver != old)
>> +		kvm_update_vmid(vcpu, cpu);
>> +
>> +	vcpu->arch.hw_vmid = vcpu->kvm->arch.vmid[cpu] & vpid_mask;
> 
> [Severity: High]
> Does this unconditionally overwrite vcpu->arch.hw_vmid for machines without
> guest ID support? On machines like 3A5000, hw_vmid is set to match vpid
> above, but without an early return or else block, it falls through and gets
> overwritten here with a dynamically allocated vmid.
yes, early return is missing in if (!cpu_has_guestid) sentence.
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -315,6 +315,7 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
                         vcpu->arch.hw_vmid = vcpu->arch.vpid & vpid_mask;
                         kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
                 }
+               return;
         }
> 
>>   }
>>   
>>   void kvm_check_vpid(struct kvm_vcpu *vcpu)
>> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
>> index 714640a2e6142..80e7a8bdc344a 100644
>> --- a/arch/loongarch/kvm/mmu.c
>> +++ b/arch/loongarch/kvm/mmu.c
> [ ... ]
>> @@ -942,6 +943,22 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
>>   {
>>   }
>>   
>> +int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
>> +{
>> +	/*
>> +	 * Queue a TLB invalidation for each CPU to perform on next
>> +	 * vcpu loading
>> +	 */
>> +	if (cpu_has_guestid) {
>> +		cpumask_setall(&kvm->arch.tlb_flush_pending);
> 
> [Severity: Medium]
> Could calling cpumask_setall() cause a data race with concurrent atomic
> bit operations?
> 
> cpumask_setall() uses a non-atomic memset() internally, while
> __kvm_check_vmid() and kvm_handle_mm_fault() use atomic read-modify-write
> operations like cpumask_test_and_clear_cpu() and cpumask_set_cpu() on the
> same cpumask.
This is under investigation, if data of memset() is not lost or 
invalidated, it will send IPI to destination vCPU and check the flag again.

Regards
Bibo Mao
> 
>> +		/* Be sure that other CPUS can watch the changes */
>> +		smp_wmb();
>> +	}
>> +
>> +	/* Return 1 continue to send ipi to running vCPUs */
>> +	return 1;
>> +}
>> +
>> +void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
>> +					const struct kvm_memory_slot *memslot)
>> +{
>> +	kvm_flush_remote_tlbs(kvm);
>> +}
> 
> [Severity: Low]
> Is kvm_arch_flush_remote_tlbs_memslot() dead code? There does not appear to be
> a KVM core hook by this name, so this architecture-specific function won't be
> called by the KVM core during memslot updates.
> 

