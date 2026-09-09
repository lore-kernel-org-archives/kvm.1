Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFA3F107B
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946297; cv=none; b=rKLuUR8vtuHp7nzjgu7JlnblhDG2uQ4Sek6NL8ecv+6r+6ws2UpjubzI3kBgWwJtHcdKKFPmMl8zSBFNJsfGnLzpUFRK7EQTtrkvBjD75uzhN4ITPt2nUiEtfyLeZCKibcO215G60HQX7y5nhOBRKFnVR0QAMjggJ6czVrr6GjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946297; c=relaxed/simple;
	bh=fuoAB2W9w/LNlrG/Jj51Au8lymZ1Gmb1S0kRWD6QVYY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jSzTQ1RUr8LqTlS6xjS/fre8/OqINM4B5HeVNgMBvuvK9pFQ578xNoWEQ5tLLdNFx3efYmOekS53XuDz7mt3vmCqSnO2iLblN/osD/q5/Vdz97coJyKIuOg2ku8AQ7MjORU/KFQZCN3iVUfuljicd2d3MvDCwxLtfnK6Op+WzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxS_BpJ6FqBCEKAA--.29410S3;
	Wed, 09 Sep 2026 17:31:21 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxmM1lJ6FqDtwdAA--.63355S2;
	Wed, 09 Sep 2026 17:31:17 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260909085350.2046788-1-maobibo@loongson.cn>
 <20260909091354.7FBC71F00A3A@smtp.kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <1c3461bb-f99b-12c8-9cee-5b50b27b1487@loongson.cn>
Date: Wed, 9 Sep 2026 17:30:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260909091354.7FBC71F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM1lJ6FqDtwdAA--.63355S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurWUXw4DKrWfCr45uF1rAFc_yoWrXFW5pF
	1xAF4kGrWfGr1xCan5J39F9w4UZFn7Cr1FgFyjkrWfAF4Y9FyrAr1Fyr4DCF90qw18Wa40
	vFnYk39Iv3Z8twbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
	VUUUUUU==



On 2026/9/9 下午5:13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The KVM_LOONGARCH_VM_FEAT_CRASH capability cannot be discovered by userspace due to a missing case in kvm_vm_feature_has_attr().
> - [High] The KVM_FEATURE_CRASH capability is silently enabled by default, violating KVM cross-architecture rules and breaking live migration with older VMMs.
> --
> 
> commit db8910e8d85912033e28dc04e11026a25b4bdbb8
> Author: Bibo Mao <maobibo@loongson.cn>
> 
> LoongArch: KVM: Add hypercall crash support
>      
> This commit adds a generic pvpanic-like hypercall for LoongArch KVM to
> notify the VMM about VM crashes. It provides a direct, low-level crash
> method that is useful when the CPU hardware context or kernel stack is
> corrupted.
> 
>> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
>> index cd0b5c11ca9c2..b222bfc480427 100644
>> --- a/arch/loongarch/include/uapi/asm/kvm.h
>> +++ b/arch/loongarch/include/uapi/asm/kvm.h
>> @@ -106,6 +106,7 @@ struct kvm_fpu {
>>   #define  KVM_LOONGARCH_VM_FEAT_PTW		8
>>   #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
>>   #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
>> +#define  KVM_LOONGARCH_VM_FEAT_CRASH		11
> 
> [Severity: High]
> Does this omission prevent userspace from discovering the capability?
> 
> This feature is defined here, but it appears to be missing from the
> switch statement in kvm_vm_feature_has_attr() in arch/loongarch/kvm/vm.c.
> If a VMM queries this via KVM_HAS_DEVICE_ATTR, won't it hit the default
> branch and return -ENXIO, falsely indicating the feature is unavailable?
yes, one line patch is missing in kvm_vm_feature_has_attr(), such as
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index e5d10ceb5e67..9bf4b3bb8f25 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -164,6 +164,7 @@ static int kvm_vm_feature_has_attr(struct kvm *kvm, 
struct kvm_device_attr *attr
         case KVM_LOONGARCH_VM_FEAT_PV_IPI:
         case KVM_LOONGARCH_VM_FEAT_PV_PREEMPT:
         case KVM_LOONGARCH_VM_FEAT_PV_STEALTIME:
+       case KVM_LOONGARCH_VM_FEAT_CRASH:
                 if (kvm_vm_support(&kvm->arch, attr->attr))
                         return 0;
                 return -ENXIO;

> 
> [ ... ]
> 
>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>> index 6dabb227a7321..e5d10ceb5e67f 100644
>> --- a/arch/loongarch/kvm/vm.c
>> +++ b/arch/loongarch/kvm/vm.c
>> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
>>   		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PMU);
>>   
>>   	/* Enable all PV features by default */
>> -	kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI);
>> +	kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI) | BIT(KVM_FEATURE_CRASH);
>>   	kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
>> +	kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_CRASH);
> 
> [Severity: High]
> Could this regression break live migration with older VMMs?
> 
> Currently, KVM_FEATURE_CRASH is unconditionally enabled for all new VMs.
> If an older VMM that does not support the crash hypercall runs on this
> kernel, and the guest executes KVM_HCALL_CRASH, the VMM will receive an
pv_features is enabled by default, VMM can detect kernel capability and 
set pv_features before booting VM.

Regards
Bibo Mao
> unrecognized KVM_EXIT_SYSTEM_EVENT of type KVM_SYSTEM_EVENT_CRASH.
> 
> This usually causes an older VMM to ungracefully abort the VM. KVM
> cross-architecture rules require new guest-visible features and exit
> reasons to be off by default, relying on explicit VMM opt-in during
> capability negotiation.
> 
>>   	if (kvm_pvtime_supported()) {
>>   		kvm->arch.pv_features |= BIT(KVM_FEATURE_PREEMPT);
>>   		kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
> 

