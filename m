Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A35190462;
	Fri, 16 Oct 2026 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121270; cv=none; b=TfzOWXjnyBuIkkA2hnsAQNoC90zC0zqFn3DlV4LET6tbduFl1t8pN0gEvG30y0GfTM+IMqCCua3KpG+H4oKRA3hzjmy9uHn6bF3nK4X0K/PeHu9GL4ENHK2OiEIsKRFlyaU4pcc9MJfQ431BDKtLHf+LMHfqFWOVgJjv9nN9KP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121270; c=relaxed/simple;
	bh=o2TjI++KBz4fSZ0VIw+tIna100ahCs3r5inIPvffBCw=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fAOMYFCUTf/ZSfiwEpCe8Ab7VDAKPYGYXhqjbor9Wsrn7auU0xIvwOT5kzk9oj6NOIwMM0esOk6bVLUh6KVzbBQj4RN6cqpxOh/9H2yaxKcAm6hML1a0s+XAYSqKOrYLvXrt6P/YAYkZuFuKlAi1K1E8pbawa7U4779GcBMtWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Ax29GymdFqnGAWAA--.65494S3;
	Fri, 16 Oct 2026 11:27:46 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAx1cyxmdFqcvosAA--.698S2;
	Fri, 16 Oct 2026 11:27:45 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260909085350.2046788-1-maobibo@loongson.cn>
 <CAAhV-H5uz3SM=tYG02Lz3WiN9stJocY7MQJFSKmVbNrNnz+9Gw@mail.gmail.com>
 <82f2c59a-59f5-8e49-f0c5-dc6feb4070df@loongson.cn>
 <CAAhV-H4U_-u-Tb1Hn69ahmS3gstDVswrmjby2QfHYvPtLo5cXQ@mail.gmail.com>
 <f86ec356-898b-1ff5-c2d3-182d3eaed14f@loongson.cn>
 <CAAhV-H51k23-1Bd+70kmmrF+OiLA=8x=z7PoKLzsz+ebhn4uEA@mail.gmail.com>
 <654d03ff-1690-a1bd-f126-f9d339c71e99@loongson.cn>
Message-ID: <1374103b-931d-d068-8a9f-6f1fdc1ab1c1@loongson.cn>
Date: Fri, 16 Oct 2026 11:29:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <654d03ff-1690-a1bd-f126-f9d339c71e99@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx1cyxmdFqcvosAA--.698S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWfJFyDur13Zr4UCrW7Gw48GrX_yoWkXFyxpr
	1kAF1DJrW5Jr18Ar1Utr1UtryUtr1UJw1jqr1UJF18Jrsrtr1jqr10qr1q9F1UJw48JF1U
	Xr15Jr17ZF1UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HS
	oJUUUUU==



On 2026/10/16 上午9:06, Bibo Mao wrote:
> 
> 
> On 2026/10/14 下午12:30, Huacai Chen wrote:
>> On Mon, Oct 12, 2026 at 8:55 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>
>>>
>>>
>>> On 2026/10/11 下午10:06, Huacai Chen wrote:
>>>> On Thu, Oct 8, 2026 at 9:50 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2026/10/3 下午12:02, Huacai Chen wrote:
>>>>>> Hi, Bibo,
>>>>>>
>>>>>> On Wed, Sep 9, 2026 at 5:01 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>>
>>>>>>> Now generic pvpanic is supported in Linux kernel which will 
>>>>>>> notify VMM
>>>>>>> with VM crash event. There is some limitations with pvpanic, such 
>>>>>>> as it
>>>>>>> requires good kernel stack or CPU hardware context and panic() C 
>>>>>>> function
>>>>>>> is in health state.
>>>>>>>
>>>>>>> Sometimes CPU hardware context or kernel/irq stack is corrupted. 
>>>>>>> Hypercall
>>>>>>> code is more direct and low-level crash method, which is useful in
>>>>>>> exception entry with assmble language, here add one hypercall 
>>>>>>> code to
>>>>>>> support VM crash function, so that VMM can capture CPU crash context
>>>>>>> in time.
>>>>>>>
>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>>> ---
>>>>>>>     arch/loongarch/include/asm/kvm_host.h      |  1 +
>>>>>>>     arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++++
>>>>>>>     arch/loongarch/include/uapi/asm/kvm.h      |  1 +
>>>>>>>     arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
>>>>>>>     arch/loongarch/kvm/exit.c                  | 11 +++++++++++
>>>>>>>     arch/loongarch/kvm/vm.c                    |  3 ++-
>>>>>>>     6 files changed, 31 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/loongarch/include/asm/kvm_host.h 
>>>>>>> b/arch/loongarch/include/asm/kvm_host.h
>>>>>>> index 65d91c3ce313..96f9f1317cad 100644
>>>>>>> --- a/arch/loongarch/include/asm/kvm_host.h
>>>>>>> +++ b/arch/loongarch/include/asm/kvm_host.h
>>>>>>> @@ -168,6 +168,7 @@ enum emulation_result {
>>>>>>>     #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) 
>>>>>>> |         \
>>>>>>>                                             
>>>>>>> BIT(KVM_FEATURE_PREEMPT) |     \
>>>>>>>                                             
>>>>>>> BIT(KVM_FEATURE_STEAL_TIME) |  \
>>>>>>> +                                        BIT(KVM_FEATURE_CRASH) 
>>>>>>> |       \
>>>>>>>                                             
>>>>>>> BIT(KVM_FEATURE_USER_HCALL) |  \
>>>>>>>                                             
>>>>>>> BIT(KVM_FEATURE_VIRT_EXTIOI))
>>>>>>>
>>>>>>> diff --git a/arch/loongarch/include/asm/kvm_para.h 
>>>>>>> b/arch/loongarch/include/asm/kvm_para.h
>>>>>>> index fb17ba0fa101..3b183bb1aaa8 100644
>>>>>>> --- a/arch/loongarch/include/asm/kvm_para.h
>>>>>>> +++ b/arch/loongarch/include/asm/kvm_para.h
>>>>>>> @@ -14,6 +14,7 @@
>>>>>>>     #define KVM_HCALL_CODE_SERVICE         0
>>>>>>>     #define KVM_HCALL_CODE_SWDBG           1
>>>>>>>     #define KVM_HCALL_CODE_USER_SERVICE    2
>>>>>>> +#define KVM_HCALL_CODE_CRASH           3
>>>>>>>
>>>>>>>     #define KVM_HCALL_SERVICE              
>>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SERVICE)
>>>>>>>     #define  KVM_HCALL_FUNC_IPI            1
>>>>>>> @@ -22,6 +23,7 @@
>>>>>>>     #define KVM_HCALL_SWDBG                        
>>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SWDBG)
>>>>>>>
>>>>>>>     #define KVM_HCALL_USER_SERVICE         
>>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_USER_SERVICE)
>>>>>>> +#define KVM_HCALL_CRASH                        
>>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_CRASH)
>>>>>>>
>>>>>>>     /*
>>>>>>>      * LoongArch hypercall return code
>>>>>>> @@ -161,6 +163,19 @@ static __always_inline long 
>>>>>>> kvm_hypercall5(u64 fid,
>>>>>>>            return ret;
>>>>>>>     }
>>>>>>>
>>>>>>> +static __always_inline long kvm_hypercall_crash(void)
>>>>>>> +{
>>>>>>> +       register long ret asm("a0");
>>>>>>> +
>>>>>>> +       __asm__ __volatile__(
>>>>>>> +               "hvcl "__stringify(KVM_HCALL_CRASH)
>>>>>>> +               : "=r" (ret)
>>>>>>> +               : : "memory"
>>>>>>> +               );
>>>>>>> +
>>>>>>> +       return ret;
>>>>>>> +}
>>>>>> Why this function has no caller?
>>>>> Currently we directly modify guest kernel and hard-code the hypercall
>>>>> instruction to debug. This inline function is only example for howto
>>>>> usage, the normal usage such as checking KVM_FEATURE_USER_HCALL 
>>>>> feature
>>>>> + kvm_hypercall_crash() is too complicated in exception entry assemble
>>>>> language.
>>>> There are no examples for KVM_HCALL_SWDBG and KVM_HCALL_USER_SERVICE,
>>>> I think KVM_HCALL_CRASH is no special.
>>>>
>>>> So if you agree, I will remove this example when applying.
>>> Removinge the example usage with KVM_HCALL_CRASH is fine to me.
>> Now all KVM patches for 7.4 is merged to loongarch-kvm. You can test
>> it if you want.
> Thanks. there is no problem from the code side, will test this in 7.4- 
> rc1 version.
My bad. There is problem which is pointed out by sashiko-bot. I had 
thought I have sent v2 version already. Will send v2 soon.

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

Regards
Bibo Mao
> 
> Regards
> bibo
>>
>>
>> Huacai
>>
>>>
>>> Regards
>>> Bibo Mao
>>>>
>>>>
>>>> Huacai
>>>>
>>>>>
>>>>> Regards
>>>>> Bibo Mao
>>>>>>
>>>>>>
>>>>>> Huacai
>>>>>>
>>>>>>> +
>>>>>>>     #ifdef CONFIG_PARAVIRT
>>>>>>>     bool kvm_para_available(void);
>>>>>>>     unsigned int kvm_arch_para_features(void);
>>>>>>> diff --git a/arch/loongarch/include/uapi/asm/kvm.h 
>>>>>>> b/arch/loongarch/include/uapi/asm/kvm.h
>>>>>>> index cd0b5c11ca9c..b222bfc48042 100644
>>>>>>> --- a/arch/loongarch/include/uapi/asm/kvm.h
>>>>>>> +++ b/arch/loongarch/include/uapi/asm/kvm.h
>>>>>>> @@ -106,6 +106,7 @@ struct kvm_fpu {
>>>>>>>     #define  KVM_LOONGARCH_VM_FEAT_PTW             8
>>>>>>>     #define  KVM_LOONGARCH_VM_FEAT_MSGINT          9
>>>>>>>     #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT      10
>>>>>>> +#define  KVM_LOONGARCH_VM_FEAT_CRASH           11
>>>>>>>
>>>>>>>     /* Device Control API on vcpu fd */
>>>>>>>     #define KVM_LOONGARCH_VCPU_CPUCFG      0
>>>>>>> diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h 
>>>>>>> b/arch/loongarch/include/uapi/asm/kvm_para.h
>>>>>>> index d28cbcadd276..bf1a0c826ca6 100644
>>>>>>> --- a/arch/loongarch/include/uapi/asm/kvm_para.h
>>>>>>> +++ b/arch/loongarch/include/uapi/asm/kvm_para.h
>>>>>>> @@ -16,6 +16,7 @@
>>>>>>>     #define  KVM_FEATURE_IPI               1
>>>>>>>     #define  KVM_FEATURE_STEAL_TIME                2
>>>>>>>     #define  KVM_FEATURE_PREEMPT           3
>>>>>>> +#define  KVM_FEATURE_CRASH             4
>>>>>>>     /* BIT 24 - 31 are features configurable by user space vmm */
>>>>>>>     #define  KVM_FEATURE_VIRT_EXTIOI       24
>>>>>>>     #define  KVM_FEATURE_USER_HCALL                25
>>>>>>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
>>>>>>> index 4f58e6e2cf86..3b6daa946c76 100644
>>>>>>> --- a/arch/loongarch/kvm/exit.c
>>>>>>> +++ b/arch/loongarch/kvm/exit.c
>>>>>>> @@ -911,6 +911,17 @@ static int kvm_handle_hypercall(struct 
>>>>>>> kvm_vcpu *vcpu, int ecode)
>>>>>>>                    vcpu->run->hypercall.ret = 
>>>>>>> KVM_HCALL_INVALID_CODE;
>>>>>>>                    ret = RESUME_HOST;
>>>>>>>                    break;
>>>>>>> +       case KVM_HCALL_CRASH:
>>>>>>> +               if (!kvm_guest_has_pv_feature(vcpu, 
>>>>>>> KVM_FEATURE_CRASH)) {
>>>>>>> +                       kvm_write_reg(vcpu, LOONGARCH_GPR_A0, 
>>>>>>> KVM_HCALL_INVALID_CODE);
>>>>>>> +                       break;
>>>>>>> +               }
>>>>>>> +
>>>>>>> +               vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
>>>>>>> +               vcpu->run->system_event.type = 
>>>>>>> KVM_SYSTEM_EVENT_CRASH;
>>>>>>> +               vcpu->run->system_event.ndata = 0;
>>>>>>> +               ret = RESUME_HOST;
>>>>>>> +               break;
>>>>>>>            case KVM_HCALL_SWDBG:
>>>>>>>                    /* KVM_HCALL_SWDBG only in effective when 
>>>>>>> SW_BP is enabled */
>>>>>>>                    if (vcpu->guest_debug & 
>>>>>>> KVM_GUESTDBG_SW_BP_MASK) {
>>>>>>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>>>>>>> index 6dabb227a732..e5d10ceb5e67 100644
>>>>>>> --- a/arch/loongarch/kvm/vm.c
>>>>>>> +++ b/arch/loongarch/kvm/vm.c
>>>>>>> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
>>>>>>>                    kvm->arch.kvm_features |= 
>>>>>>> BIT(KVM_LOONGARCH_VM_FEAT_PMU);
>>>>>>>
>>>>>>>            /* Enable all PV features by default */
>>>>>>> -       kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI);
>>>>>>> +       kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI) | 
>>>>>>> BIT(KVM_FEATURE_CRASH);
>>>>>>>            kvm->arch.kvm_features |= 
>>>>>>> BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
>>>>>>> +       kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_CRASH);
>>>>>>>            if (kvm_pvtime_supported()) {
>>>>>>>                    kvm->arch.pv_features |= 
>>>>>>> BIT(KVM_FEATURE_PREEMPT);
>>>>>>>                    kvm->arch.pv_features |= 
>>>>>>> BIT(KVM_FEATURE_STEAL_TIME);
>>>>>>>
>>>>>>> base-commit: df2908090cda368b01ff43709f51890076c56157
>>>>>>> -- 
>>>>>>> 2.39.3
>>>>>>>
>>>>>>>
>>>>>
>>>

