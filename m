Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6139DBC9;
	Mon, 27 Apr 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279424; cv=none; b=pB1SP/bmCyyk5CBtHQzlf9/mMikDJOK7rpwKUICn1mmy4KRIVRg6w46KFUsr3CK1+4aSb0emAgBc43mn08zpkX8RyLhZGCIVzrVLJ082ospYtcOD7QfjDqNbKeKRikLEe8x+z/2EpQ4qOBF3OV7rvsBUEwuGFkAS88BAip6Y9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279424; c=relaxed/simple;
	bh=lL0wbsiMwJqrGNDBB7n4gDKdlPgBDlv5t3j7rft1zjs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BsB0P4ydqowLwnmE2hyLF3lYyiSd+pBukJD+gBK2eGrCgEhf7pSiqyKMArI6A3QrGpR4HFaFwZtny6Ts2YDEhWnMdTl3m3u8ruqNxoSnI16WA7y1eLRWJj5d2rICyN71JNZLquCt2wpMs11EFwVw5sNfcvZI9GmQmx78v7vRZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.126])
	by gateway (Coremail) with SMTP id _____8AxAuu5Ie9pCUwEAA--.14706S3;
	Mon, 27 Apr 2026 16:43:37 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
	by front1 (Coremail) with SMTP id qMiowJCxGOC2Ie9pG591AA--.26567S3;
	Mon, 27 Apr 2026 16:43:36 +0800 (CST)
Subject: Re: [PATCH V4 1/2] LoongArch: KVM: Compile the switch.S file directly
 into the kernel
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
References: <20260414113111.2997864-1-lixianglai@loongson.cn>
 <20260414113111.2997864-2-lixianglai@loongson.cn>
 <CAAhV-H6g41ah0xUxKJfe1=+xSMeaBcAbGnYya-xMAT3NtFUbgg@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <3c07246f-75d2-f138-94c3-8a71f749f443@loongson.cn>
Date: Mon, 27 Apr 2026 16:36:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6g41ah0xUxKJfe1=+xSMeaBcAbGnYya-xMAT3NtFUbgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxGOC2Ie9pG591AA--.26567S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3uw1kCFyDXry7tw18Kw1fZrc_yoWDZFyUpa
	srCFs5KF48Jrn3XryUt3WDZr9Iqrs7Kr1I9F12vayrCrnF9r1kXF1ktrWDuFyvkw4kGF10
	vFyrWwn3ZFyUtacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==

Hi Huacai Chen:
> Hi, Xianglai,
>
> After this patch I get:
> arch/loongarch/kvm/switch.o: warning: objtool: kvm_enter_guest+0x0:
> unreachable instruction
>
> But if I restore SYM_FUNC_START/SYM_FUNC_END for kvm_enter_guest, the
> warning disappear. So please make sure which one is correct.
Oh~ Here, we should use SYM_FUNC_START/SYM_FUNC_END. I also reproduced 
this issue locally.
After making the modification, the compilation did not notice this 
compilation warning.


Thanks,
Xianglai.

> Huacai
>
> On Tue, Apr 14, 2026 at 7:57 PM Xianglai Li <lixianglai@loongson.cn> wrote:
>> If we directly compile the switch.S file into the kernel, the address of
>> the kvm_exc_entry function will definitely be within the DMW memory area.
>> Therefore, we will no longer need to perform a copy relocation of
>> kvm_exc_entry.
>>
>> Based on the above description, compile switch.S directly into the kernel,
>> and then remove the copy relocation execution logic for the kvm_exc_entry
>> function.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
>> Cc: Bibo Mao <maobibo@loongson.cn>
>>
>>   arch/loongarch/Kbuild                       |  2 +-
>>   arch/loongarch/include/asm/asm-prototypes.h | 21 +++++++++++++
>>   arch/loongarch/include/asm/kvm_host.h       |  3 --
>>   arch/loongarch/kvm/Makefile                 |  2 +-
>>   arch/loongarch/kvm/main.c                   | 35 ++-------------------
>>   arch/loongarch/kvm/switch.S                 | 27 +++++++++++-----
>>   6 files changed, 46 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
>> index beb8499dd8ed..1c7a0dbe5e72 100644
>> --- a/arch/loongarch/Kbuild
>> +++ b/arch/loongarch/Kbuild
>> @@ -3,7 +3,7 @@ obj-y += mm/
>>   obj-y += net/
>>   obj-y += vdso/
>>
>> -obj-$(CONFIG_KVM) += kvm/
>> +obj-$(subst m,y,$(CONFIG_KVM)) += kvm/
>>
>>   # for cleaning
>>   subdir- += boot
>> diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/include/asm/asm-prototypes.h
>> index 704066b4f736..e8ce153691e5 100644
>> --- a/arch/loongarch/include/asm/asm-prototypes.h
>> +++ b/arch/loongarch/include/asm/asm-prototypes.h
>> @@ -20,3 +20,24 @@ asmlinkage void noinstr __no_stack_protector ret_from_kernel_thread(struct task_
>>                                                                      struct pt_regs *regs,
>>                                                                      int (*fn)(void *),
>>                                                                      void *fn_arg);
>> +
>> +struct kvm_run;
>> +struct kvm_vcpu;
>> +
>> +void kvm_exc_entry(void);
>> +int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
>> +
>> +struct loongarch_fpu;
>> +
>> +#ifdef CONFIG_CPU_HAS_LSX
>> +void kvm_save_lsx(struct loongarch_fpu *fpu);
>> +void kvm_restore_lsx(struct loongarch_fpu *fpu);
>> +#endif
>> +
>> +#ifdef CONFIG_CPU_HAS_LASX
>> +void kvm_save_lasx(struct loongarch_fpu *fpu);
>> +void kvm_restore_lasx(struct loongarch_fpu *fpu);
>> +#endif
>> +
>> +void kvm_save_fpu(struct loongarch_fpu *fpu);
>> +void kvm_restore_fpu(struct loongarch_fpu *fpu);
>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>> index 19eb5e5c3984..0bcdffc14c5f 100644
>> --- a/arch/loongarch/include/asm/kvm_host.h
>> +++ b/arch/loongarch/include/asm/kvm_host.h
>> @@ -86,7 +86,6 @@ struct kvm_context {
>>   struct kvm_world_switch {
>>          int (*exc_entry)(void);
>>          int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *vcpu);
>> -       unsigned long page_order;
>>   };
>>
>>   #define MAX_PGTABLE_LEVELS     4
>> @@ -356,8 +355,6 @@ void kvm_exc_entry(void);
>>   int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
>>
>>   extern unsigned long vpid_mask;
>> -extern const unsigned long kvm_exception_size;
>> -extern const unsigned long kvm_enter_guest_size;
>>   extern struct kvm_world_switch *kvm_loongarch_ops;
>>
>>   #define SW_GCSR                (1 << 0)
>> diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
>> index cb41d9265662..fe665054f824 100644
>> --- a/arch/loongarch/kvm/Makefile
>> +++ b/arch/loongarch/kvm/Makefile
>> @@ -11,7 +11,7 @@ kvm-y += exit.o
>>   kvm-y += interrupt.o
>>   kvm-y += main.o
>>   kvm-y += mmu.o
>> -kvm-y += switch.o
>> +obj-y += switch.o
>>   kvm-y += timer.o
>>   kvm-y += tlb.o
>>   kvm-y += vcpu.o
>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
>> index 2c593ac7892f..18800a38b150 100644
>> --- a/arch/loongarch/kvm/main.c
>> +++ b/arch/loongarch/kvm/main.c
>> @@ -348,8 +348,7 @@ void kvm_arch_disable_virtualization_cpu(void)
>>
>>   static int kvm_loongarch_env_init(void)
>>   {
>> -       int cpu, order, ret;
>> -       void *addr;
>> +       int cpu, ret;
>>          struct kvm_context *context;
>>
>>          vmcs = alloc_percpu(struct kvm_context);
>> @@ -365,30 +364,8 @@ static int kvm_loongarch_env_init(void)
>>                  return -ENOMEM;
>>          }
>>
>> -       /*
>> -        * PGD register is shared between root kernel and kvm hypervisor.
>> -        * So world switch entry should be in DMW area rather than TLB area
>> -        * to avoid page fault reenter.
>> -        *
>> -        * In future if hardware pagetable walking is supported, we won't
>> -        * need to copy world switch code to DMW area.
>> -        */
>> -       order = get_order(kvm_exception_size + kvm_enter_guest_size);
>> -       addr = (void *)__get_free_pages(GFP_KERNEL, order);
>> -       if (!addr) {
>> -               free_percpu(vmcs);
>> -               vmcs = NULL;
>> -               kfree(kvm_loongarch_ops);
>> -               kvm_loongarch_ops = NULL;
>> -               return -ENOMEM;
>> -       }
>> -
>> -       memcpy(addr, kvm_exc_entry, kvm_exception_size);
>> -       memcpy(addr + kvm_exception_size, kvm_enter_guest, kvm_enter_guest_size);
>> -       flush_icache_range((unsigned long)addr, (unsigned long)addr + kvm_exception_size + kvm_enter_guest_size);
>> -       kvm_loongarch_ops->exc_entry = addr;
>> -       kvm_loongarch_ops->enter_guest = addr + kvm_exception_size;
>> -       kvm_loongarch_ops->page_order = order;
>> +       kvm_loongarch_ops->exc_entry = (void *)kvm_exc_entry;
>> +       kvm_loongarch_ops->enter_guest = (void *)kvm_enter_guest;
>>
>>          vpid_mask = read_csr_gstat();
>>          vpid_mask = (vpid_mask & CSR_GSTAT_GIDBIT) >> CSR_GSTAT_GIDBIT_SHIFT;
>> @@ -422,16 +399,10 @@ static int kvm_loongarch_env_init(void)
>>
>>   static void kvm_loongarch_env_exit(void)
>>   {
>> -       unsigned long addr;
>> -
>>          if (vmcs)
>>                  free_percpu(vmcs);
>>
>>          if (kvm_loongarch_ops) {
>> -               if (kvm_loongarch_ops->exc_entry) {
>> -                       addr = (unsigned long)kvm_loongarch_ops->exc_entry;
>> -                       free_pages(addr, kvm_loongarch_ops->page_order);
>> -               }
>>                  kfree(kvm_loongarch_ops);
>>          }
>>
>> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
>> index f1768b7a6194..1a5636790ef9 100644
>> --- a/arch/loongarch/kvm/switch.S
>> +++ b/arch/loongarch/kvm/switch.S
>> @@ -5,10 +5,12 @@
>>
>>   #include <linux/linkage.h>
>>   #include <asm/asm.h>
>> +#include <asm/page.h>
>>   #include <asm/asmmacro.h>
>>   #include <asm/loongarch.h>
>>   #include <asm/regdef.h>
>>   #include <asm/unwind_hints.h>
>> +#include <linux/kvm_types.h>
>>
>>   #define HGPR_OFFSET(x)         (PT_R0 + 8*x)
>>   #define GGPR_OFFSET(x)         (KVM_ARCH_GGPR + 8*x)
>> @@ -100,8 +102,16 @@
>>           *  -        is still in guest mode, such as pgd table/vmid registers etc,
>>           *  -        will fix with hw page walk enabled in future
>>           * load kvm_vcpu from reserved CSR KVM_VCPU_KS, and save a2 to KVM_TEMP_KS
>> +        *
>> +        * PGD register is shared between root kernel and kvm hypervisor.
>> +        * So world switch entry should be in DMW area rather than TLB area
>> +        * to avoid page fault reenter.
>> +        *
>> +        * In future if hardware pagetable walking is supported, we won't
>> +        * need to copy world switch code to DMW area.
>>           */
>>          .text
>> +       .p2align PAGE_SHIFT
>>          .cfi_sections   .debug_frame
>>   SYM_CODE_START(kvm_exc_entry)
>>          UNWIND_HINT_UNDEFINED
>> @@ -190,8 +200,8 @@ ret_to_host:
>>          kvm_restore_host_gpr    a2
>>          jr      ra
>>
>> -SYM_INNER_LABEL(kvm_exc_entry_end, SYM_L_LOCAL)
>>   SYM_CODE_END(kvm_exc_entry)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
>>
>>   /*
>>    * int kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu)
>> @@ -200,7 +210,7 @@ SYM_CODE_END(kvm_exc_entry)
>>    *  a0: kvm_run* run
>>    *  a1: kvm_vcpu* vcpu
>>    */
>> -SYM_FUNC_START(kvm_enter_guest)
>> +SYM_CODE_START(kvm_enter_guest)
>>          /* Allocate space in stack bottom */
>>          addi.d  a2, sp, -PT_SIZE
>>          /* Save host GPRs */
>> @@ -215,8 +225,8 @@ SYM_FUNC_START(kvm_enter_guest)
>>          /* Save kvm_vcpu to kscratch */
>>          csrwr   a1, KVM_VCPU_KS
>>          kvm_switch_to_guest
>> -SYM_INNER_LABEL(kvm_enter_guest_end, SYM_L_LOCAL)
>> -SYM_FUNC_END(kvm_enter_guest)
>> +SYM_CODE_END(kvm_enter_guest)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_enter_guest)
>>
>>   SYM_FUNC_START(kvm_save_fpu)
>>          fpu_save_csr    a0 t1
>> @@ -224,6 +234,7 @@ SYM_FUNC_START(kvm_save_fpu)
>>          fpu_save_cc     a0 t1 t2
>>          jr              ra
>>   SYM_FUNC_END(kvm_save_fpu)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_save_fpu)
>>
>>   SYM_FUNC_START(kvm_restore_fpu)
>>          fpu_restore_double a0 t1
>> @@ -231,6 +242,7 @@ SYM_FUNC_START(kvm_restore_fpu)
>>          fpu_restore_cc     a0 t1 t2
>>          jr                 ra
>>   SYM_FUNC_END(kvm_restore_fpu)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_fpu)
>>
>>   #ifdef CONFIG_CPU_HAS_LSX
>>   SYM_FUNC_START(kvm_save_lsx)
>> @@ -239,6 +251,7 @@ SYM_FUNC_START(kvm_save_lsx)
>>          lsx_save_data   a0 t1
>>          jr              ra
>>   SYM_FUNC_END(kvm_save_lsx)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_save_lsx)
>>
>>   SYM_FUNC_START(kvm_restore_lsx)
>>          lsx_restore_data a0 t1
>> @@ -246,6 +259,7 @@ SYM_FUNC_START(kvm_restore_lsx)
>>          fpu_restore_csr  a0 t1 t2
>>          jr               ra
>>   SYM_FUNC_END(kvm_restore_lsx)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_lsx)
>>   #endif
>>
>>   #ifdef CONFIG_CPU_HAS_LASX
>> @@ -255,6 +269,7 @@ SYM_FUNC_START(kvm_save_lasx)
>>          lasx_save_data  a0 t1
>>          jr              ra
>>   SYM_FUNC_END(kvm_save_lasx)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_save_lasx)
>>
>>   SYM_FUNC_START(kvm_restore_lasx)
>>          lasx_restore_data a0 t1
>> @@ -262,10 +277,8 @@ SYM_FUNC_START(kvm_restore_lasx)
>>          fpu_restore_csr   a0 t1 t2
>>          jr                ra
>>   SYM_FUNC_END(kvm_restore_lasx)
>> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_lasx)
>>   #endif
>> -       .section ".rodata"
>> -SYM_DATA(kvm_exception_size, .quad kvm_exc_entry_end - kvm_exc_entry)
>> -SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_enter_guest)
>>
>>   #ifdef CONFIG_CPU_HAS_LBT
>>   STACK_FRAME_NON_STANDARD kvm_restore_fpu
>> --
>> 2.39.1
>>

