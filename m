Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484231716A;
	Mon, 12 Oct 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766555; cv=none; b=WJG59B/8WHxiRYfz9h+CGzEfnQzluThzrOOKgjRaK92q+h/MOgcLXinP12TLGSgwP5upeUPqAcideqxptBcWjTxawghEFMT2Wtucav1o+H1mR9U0b4MuFugLdkJflZwE2rk7dZSso7aSIJmm2U/4cX1Id5WGfYYw5RjrjKR6GY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766555; c=relaxed/simple;
	bh=0CNcZKjbQsiWhy99cjgvyC3eghbqlrLAmMYvxBlPEO0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cW7sIt8iGcw+RLOYrGEfbbD+Jm2KNN7JH3bNbIXdbv2pS0CqoCTLmbwFvqJHkBJk1Vm3LaCd93SVrzHqs2yTZXZB/6pgMsO5oUWop7ng941mfKkZCY8PCgZmGAWohgLASviKE36pQ8rCRANAgM1RcUYwHnF5SCKnhCbUw+0ajCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxztIVMMxqs8YUAA--.59952S3;
	Mon, 12 Oct 2026 08:55:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxmM0UMMxqDT8rAA--.24843S2;
	Mon, 12 Oct 2026 08:55:48 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260909085350.2046788-1-maobibo@loongson.cn>
 <CAAhV-H5uz3SM=tYG02Lz3WiN9stJocY7MQJFSKmVbNrNnz+9Gw@mail.gmail.com>
 <82f2c59a-59f5-8e49-f0c5-dc6feb4070df@loongson.cn>
 <CAAhV-H4U_-u-Tb1Hn69ahmS3gstDVswrmjby2QfHYvPtLo5cXQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f86ec356-898b-1ff5-c2d3-182d3eaed14f@loongson.cn>
Date: Mon, 12 Oct 2026 08:57:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4U_-u-Tb1Hn69ahmS3gstDVswrmjby2QfHYvPtLo5cXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM0UMMxqDT8rAA--.24843S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JF43XFWfCr13Wr1DAr17XFc_yoWxKw17pF
	yvyFs5GrWUGr1fCwsaq3sIgr9xKrsrGr1IgFy2grW8AFn0qFnxZr18tFyDCFn8X348Xa40
	vF9Yg343ZFW3t3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
	U



On 2026/10/11 下午10:06, Huacai Chen wrote:
> On Thu, Oct 8, 2026 at 9:50 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/10/3 下午12:02, Huacai Chen wrote:
>>> Hi, Bibo,
>>>
>>> On Wed, Sep 9, 2026 at 5:01 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> Now generic pvpanic is supported in Linux kernel which will notify VMM
>>>> with VM crash event. There is some limitations with pvpanic, such as it
>>>> requires good kernel stack or CPU hardware context and panic() C function
>>>> is in health state.
>>>>
>>>> Sometimes CPU hardware context or kernel/irq stack is corrupted. Hypercall
>>>> code is more direct and low-level crash method, which is useful in
>>>> exception entry with assmble language, here add one hypercall code to
>>>> support VM crash function, so that VMM can capture CPU crash context
>>>> in time.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/kvm_host.h      |  1 +
>>>>    arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++++
>>>>    arch/loongarch/include/uapi/asm/kvm.h      |  1 +
>>>>    arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
>>>>    arch/loongarch/kvm/exit.c                  | 11 +++++++++++
>>>>    arch/loongarch/kvm/vm.c                    |  3 ++-
>>>>    6 files changed, 31 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>>>> index 65d91c3ce313..96f9f1317cad 100644
>>>> --- a/arch/loongarch/include/asm/kvm_host.h
>>>> +++ b/arch/loongarch/include/asm/kvm_host.h
>>>> @@ -168,6 +168,7 @@ enum emulation_result {
>>>>    #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) |         \
>>>>                                            BIT(KVM_FEATURE_PREEMPT) |     \
>>>>                                            BIT(KVM_FEATURE_STEAL_TIME) |  \
>>>> +                                        BIT(KVM_FEATURE_CRASH) |       \
>>>>                                            BIT(KVM_FEATURE_USER_HCALL) |  \
>>>>                                            BIT(KVM_FEATURE_VIRT_EXTIOI))
>>>>
>>>> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
>>>> index fb17ba0fa101..3b183bb1aaa8 100644
>>>> --- a/arch/loongarch/include/asm/kvm_para.h
>>>> +++ b/arch/loongarch/include/asm/kvm_para.h
>>>> @@ -14,6 +14,7 @@
>>>>    #define KVM_HCALL_CODE_SERVICE         0
>>>>    #define KVM_HCALL_CODE_SWDBG           1
>>>>    #define KVM_HCALL_CODE_USER_SERVICE    2
>>>> +#define KVM_HCALL_CODE_CRASH           3
>>>>
>>>>    #define KVM_HCALL_SERVICE              HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SERVICE)
>>>>    #define  KVM_HCALL_FUNC_IPI            1
>>>> @@ -22,6 +23,7 @@
>>>>    #define KVM_HCALL_SWDBG                        HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SWDBG)
>>>>
>>>>    #define KVM_HCALL_USER_SERVICE         HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_USER_SERVICE)
>>>> +#define KVM_HCALL_CRASH                        HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_CRASH)
>>>>
>>>>    /*
>>>>     * LoongArch hypercall return code
>>>> @@ -161,6 +163,19 @@ static __always_inline long kvm_hypercall5(u64 fid,
>>>>           return ret;
>>>>    }
>>>>
>>>> +static __always_inline long kvm_hypercall_crash(void)
>>>> +{
>>>> +       register long ret asm("a0");
>>>> +
>>>> +       __asm__ __volatile__(
>>>> +               "hvcl "__stringify(KVM_HCALL_CRASH)
>>>> +               : "=r" (ret)
>>>> +               : : "memory"
>>>> +               );
>>>> +
>>>> +       return ret;
>>>> +}
>>> Why this function has no caller?
>> Currently we directly modify guest kernel and hard-code the hypercall
>> instruction to debug. This inline function is only example for howto
>> usage, the normal usage such as checking KVM_FEATURE_USER_HCALL feature
>> + kvm_hypercall_crash() is too complicated in exception entry assemble
>> language.
> There are no examples for KVM_HCALL_SWDBG and KVM_HCALL_USER_SERVICE,
> I think KVM_HCALL_CRASH is no special.
> 
> So if you agree, I will remove this example when applying.
Removinge the example usage with KVM_HCALL_CRASH is fine to me.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>>
>>>
>>> Huacai
>>>
>>>> +
>>>>    #ifdef CONFIG_PARAVIRT
>>>>    bool kvm_para_available(void);
>>>>    unsigned int kvm_arch_para_features(void);
>>>> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
>>>> index cd0b5c11ca9c..b222bfc48042 100644
>>>> --- a/arch/loongarch/include/uapi/asm/kvm.h
>>>> +++ b/arch/loongarch/include/uapi/asm/kvm.h
>>>> @@ -106,6 +106,7 @@ struct kvm_fpu {
>>>>    #define  KVM_LOONGARCH_VM_FEAT_PTW             8
>>>>    #define  KVM_LOONGARCH_VM_FEAT_MSGINT          9
>>>>    #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT      10
>>>> +#define  KVM_LOONGARCH_VM_FEAT_CRASH           11
>>>>
>>>>    /* Device Control API on vcpu fd */
>>>>    #define KVM_LOONGARCH_VCPU_CPUCFG      0
>>>> diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h b/arch/loongarch/include/uapi/asm/kvm_para.h
>>>> index d28cbcadd276..bf1a0c826ca6 100644
>>>> --- a/arch/loongarch/include/uapi/asm/kvm_para.h
>>>> +++ b/arch/loongarch/include/uapi/asm/kvm_para.h
>>>> @@ -16,6 +16,7 @@
>>>>    #define  KVM_FEATURE_IPI               1
>>>>    #define  KVM_FEATURE_STEAL_TIME                2
>>>>    #define  KVM_FEATURE_PREEMPT           3
>>>> +#define  KVM_FEATURE_CRASH             4
>>>>    /* BIT 24 - 31 are features configurable by user space vmm */
>>>>    #define  KVM_FEATURE_VIRT_EXTIOI       24
>>>>    #define  KVM_FEATURE_USER_HCALL                25
>>>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
>>>> index 4f58e6e2cf86..3b6daa946c76 100644
>>>> --- a/arch/loongarch/kvm/exit.c
>>>> +++ b/arch/loongarch/kvm/exit.c
>>>> @@ -911,6 +911,17 @@ static int kvm_handle_hypercall(struct kvm_vcpu *vcpu, int ecode)
>>>>                   vcpu->run->hypercall.ret = KVM_HCALL_INVALID_CODE;
>>>>                   ret = RESUME_HOST;
>>>>                   break;
>>>> +       case KVM_HCALL_CRASH:
>>>> +               if (!kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_CRASH)) {
>>>> +                       kvm_write_reg(vcpu, LOONGARCH_GPR_A0, KVM_HCALL_INVALID_CODE);
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
>>>> +               vcpu->run->system_event.type = KVM_SYSTEM_EVENT_CRASH;
>>>> +               vcpu->run->system_event.ndata = 0;
>>>> +               ret = RESUME_HOST;
>>>> +               break;
>>>>           case KVM_HCALL_SWDBG:
>>>>                   /* KVM_HCALL_SWDBG only in effective when SW_BP is enabled */
>>>>                   if (vcpu->guest_debug & KVM_GUESTDBG_SW_BP_MASK) {
>>>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>>>> index 6dabb227a732..e5d10ceb5e67 100644
>>>> --- a/arch/loongarch/kvm/vm.c
>>>> +++ b/arch/loongarch/kvm/vm.c
>>>> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
>>>>                   kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PMU);
>>>>
>>>>           /* Enable all PV features by default */
>>>> -       kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI);
>>>> +       kvm->arch.pv_features |= BIT(KVM_FEATURE_IPI) | BIT(KVM_FEATURE_CRASH);
>>>>           kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
>>>> +       kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_CRASH);
>>>>           if (kvm_pvtime_supported()) {
>>>>                   kvm->arch.pv_features |= BIT(KVM_FEATURE_PREEMPT);
>>>>                   kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
>>>>
>>>> base-commit: df2908090cda368b01ff43709f51890076c56157
>>>> --
>>>> 2.39.3
>>>>
>>>>
>>

