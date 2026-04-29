Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA953C1961
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456009; cv=none; b=Y4kOBrHRrHTJwde/TlfqV7kLd81TqhkGb9iWkQUX3NtIT7AUGSusN5ysc9so8D2xgFxSxxv6gPgAlLuiZ6fRTwoT6ha44Y3oKmohXkN6rBnhhLes7ZugiVm15DYxWFf9ARWyolKZD0bA9WJte+3AzMVKOUfdnuu4JkIaQkPs6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456009; c=relaxed/simple;
	bh=YivOqpbC6U8+TsEhc7jUS1ECCgD6n52Dv/x+pUxWY4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzriqYbZTTjzkWxAi4TC9/wql5XJ3u4c1PyeUVnAJ32Yw/W/W6B4aOXSS5WBJqmTGCmT0UCfG8INjZydvx6ReJb5vWiaLlPw+hvpJTYE8mAcF/61lifna1mqoCUDvV7tNLllL1qn2FtiydocCpJGC6z+rw28KZ6QPZzKfPj02bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4DIHlEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4DIHlEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E140C2BCC7
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 09:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777456009;
	bh=YivOqpbC6U8+TsEhc7jUS1ECCgD6n52Dv/x+pUxWY4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t4DIHlEP2AFA3VsT1leqGAv8+rnkD8K5ZKU6jCo412t+LopFofOffzmVvWmzghv6c
	 rTiOgAueurjnrf/VHVpHdU4T8wmbjuRhKkk05McNAmeQV11V9qmI4l6lw2zYCht63r
	 M5ciwlstWMjYT2m9dXBm7CcsqRNA505+71cPWebmG2yguGZnRksN4D6HuQLPI6IL1u
	 DPNIzhBVJhsqaUbxocs9DYaR7x7QV/X+pJH5jtZl7/Nph8TE1SYlPqhyNDdtAd3QNi
	 QzgY3I2cOZNZzPAY5R/YjwqpJV8Kz2qsWkAt9h9/vmJPA7k2zQbXQNBdEdXkXfZBoF
	 jg6q5m864wMhg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so2090710766b.1
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 02:46:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+6pY/cdHCej8kuFxPuSd3914cxTMxOo1e6NznGiD2KzisMgWbhCytVyAGusD3xvP69RmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaih5H06eJS8+J7RfxJAR1jxiBHAzq1+cL6lWc4oQHzZ0e+Hj
	85ZwKWyenW04uTBMVV6e1bocpvEX7WdLd3xEP2S6rQmAVXmzWRyHrYTp4yKx7g0FCLAX0hHwLkL
	y3xFmspHspqTQQOv6kIxUDvGWrtYW/KY=
X-Received: by 2002:a17:907:c91f:b0:ba8:4dc2:a661 with SMTP id
 a640c23a62f3a-bb8015ef71amr279439566b.7.1777456007929; Wed, 29 Apr 2026
 02:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414113111.2997864-1-lixianglai@loongson.cn>
 <20260414113111.2997864-2-lixianglai@loongson.cn> <CAAhV-H6g41ah0xUxKJfe1=+xSMeaBcAbGnYya-xMAT3NtFUbgg@mail.gmail.com>
 <3c07246f-75d2-f138-94c3-8a71f749f443@loongson.cn> <CAAhV-H43UxunddHJOnONmXNtJbk1vriiXjWk5XU7M9e8gKr+tg@mail.gmail.com>
 <259eb913-0667-a16a-f916-5bc9725037ae@loongson.cn>
In-Reply-To: <259eb913-0667-a16a-f916-5bc9725037ae@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 29 Apr 2026 17:47:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4g_ioUykfRnEPShjwNxtJrVKNWny4on7h+CmKTTALLzw@mail.gmail.com>
X-Gm-Features: AVHnY4IYdT9LIwEXxPVsETVqZoWWlvZoNYyXueh9bpyS1G-FYELDxv4m7HcKUnI
Message-ID: <CAAhV-H4g_ioUykfRnEPShjwNxtJrVKNWny4on7h+CmKTTALLzw@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] LoongArch: KVM: Compile the switch.S file directly
 into the kernel
To: Jinyang He <hejinyang@loongson.cn>
Cc: lixianglai <lixianglai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 8:06=E2=80=AFPM Jinyang He <hejinyang@loongson.cn> =
wrote:
>
> On 2026-04-27 16:48, Huacai Chen wrote:
>
> > On Mon, Apr 27, 2026 at 4:43=E2=80=AFPM lixianglai <lixianglai@loongson=
.cn> wrote:
> >> Hi Huacai Chen:
> >>> Hi, Xianglai,
> >>>
> >>> After this patch I get:
> >>> arch/loongarch/kvm/switch.o: warning: objtool: kvm_enter_guest+0x0:
> >>> unreachable instruction
> >>>
> >>> But if I restore SYM_FUNC_START/SYM_FUNC_END for kvm_enter_guest, the
> >>> warning disappear. So please make sure which one is correct.
> >> Oh~ Here, we should use SYM_FUNC_START/SYM_FUNC_END. I also reproduced
> >> this issue locally.
> >> After making the modification, the compilation did not notice this
> >> compilation warning.
> > Jinyang,
> >
> > What's your opinion? I remember you suggest to use
> > SYM_CODE_START/SYM_CODE_END here.
> Yes, I'd prefer SYM_CODE_START/SYM_CODE_END here.
>
>  From Documentation/core-api/asm-annotations.rst, SYM_FUNC_* is for
> C-like functions with standard calling conventions, while SYM_CODE_* is
> for special code with non-standard conventions (interrupt handlers,
> entry/exception code, trampolines). The kvm_enter_guest is like a
> trampoline which ertn to guest.
>
> But if changing to SYM_CODE_* causes other issues with the current patch,
> perhaps we can be flexible about this for now.
OK, applied, thanks.

Huacai

>
> Thanks
> Jinyang
> >
> > Huacai
> >
> >>
> >> Thanks,
> >> Xianglai.
> >>
> >>> Huacai
> >>>
> >>> On Tue, Apr 14, 2026 at 7:57=E2=80=AFPM Xianglai Li <lixianglai@loong=
son.cn> wrote:
> >>>> If we directly compile the switch.S file into the kernel, the addres=
s of
> >>>> the kvm_exc_entry function will definitely be within the DMW memory =
area.
> >>>> Therefore, we will no longer need to perform a copy relocation of
> >>>> kvm_exc_entry.
> >>>>
> >>>> Based on the above description, compile switch.S directly into the k=
ernel,
> >>>> and then remove the copy relocation execution logic for the kvm_exc_=
entry
> >>>> function.
> >>>>
> >>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> >>>> ---
> >>>> Cc: Huacai Chen <chenhuacai@kernel.org>
> >>>> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
> >>>> Cc: Bibo Mao <maobibo@loongson.cn>
> >>>>
> >>>>    arch/loongarch/Kbuild                       |  2 +-
> >>>>    arch/loongarch/include/asm/asm-prototypes.h | 21 +++++++++++++
> >>>>    arch/loongarch/include/asm/kvm_host.h       |  3 --
> >>>>    arch/loongarch/kvm/Makefile                 |  2 +-
> >>>>    arch/loongarch/kvm/main.c                   | 35 ++--------------=
-----
> >>>>    arch/loongarch/kvm/switch.S                 | 27 +++++++++++-----
> >>>>    6 files changed, 46 insertions(+), 44 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
> >>>> index beb8499dd8ed..1c7a0dbe5e72 100644
> >>>> --- a/arch/loongarch/Kbuild
> >>>> +++ b/arch/loongarch/Kbuild
> >>>> @@ -3,7 +3,7 @@ obj-y +=3D mm/
> >>>>    obj-y +=3D net/
> >>>>    obj-y +=3D vdso/
> >>>>
> >>>> -obj-$(CONFIG_KVM) +=3D kvm/
> >>>> +obj-$(subst m,y,$(CONFIG_KVM)) +=3D kvm/
> >>>>
> >>>>    # for cleaning
> >>>>    subdir- +=3D boot
> >>>> diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loon=
garch/include/asm/asm-prototypes.h
> >>>> index 704066b4f736..e8ce153691e5 100644
> >>>> --- a/arch/loongarch/include/asm/asm-prototypes.h
> >>>> +++ b/arch/loongarch/include/asm/asm-prototypes.h
> >>>> @@ -20,3 +20,24 @@ asmlinkage void noinstr __no_stack_protector ret_=
from_kernel_thread(struct task_
> >>>>                                                                     =
  struct pt_regs *regs,
> >>>>                                                                     =
  int (*fn)(void *),
> >>>>                                                                     =
  void *fn_arg);
> >>>> +
> >>>> +struct kvm_run;
> >>>> +struct kvm_vcpu;
> >>>> +
> >>>> +void kvm_exc_entry(void);
> >>>> +int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
> >>>> +
> >>>> +struct loongarch_fpu;
> >>>> +
> >>>> +#ifdef CONFIG_CPU_HAS_LSX
> >>>> +void kvm_save_lsx(struct loongarch_fpu *fpu);
> >>>> +void kvm_restore_lsx(struct loongarch_fpu *fpu);
> >>>> +#endif
> >>>> +
> >>>> +#ifdef CONFIG_CPU_HAS_LASX
> >>>> +void kvm_save_lasx(struct loongarch_fpu *fpu);
> >>>> +void kvm_restore_lasx(struct loongarch_fpu *fpu);
> >>>> +#endif
> >>>> +
> >>>> +void kvm_save_fpu(struct loongarch_fpu *fpu);
> >>>> +void kvm_restore_fpu(struct loongarch_fpu *fpu);
> >>>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/=
include/asm/kvm_host.h
> >>>> index 19eb5e5c3984..0bcdffc14c5f 100644
> >>>> --- a/arch/loongarch/include/asm/kvm_host.h
> >>>> +++ b/arch/loongarch/include/asm/kvm_host.h
> >>>> @@ -86,7 +86,6 @@ struct kvm_context {
> >>>>    struct kvm_world_switch {
> >>>>           int (*exc_entry)(void);
> >>>>           int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *v=
cpu);
> >>>> -       unsigned long page_order;
> >>>>    };
> >>>>
> >>>>    #define MAX_PGTABLE_LEVELS     4
> >>>> @@ -356,8 +355,6 @@ void kvm_exc_entry(void);
> >>>>    int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
> >>>>
> >>>>    extern unsigned long vpid_mask;
> >>>> -extern const unsigned long kvm_exception_size;
> >>>> -extern const unsigned long kvm_enter_guest_size;
> >>>>    extern struct kvm_world_switch *kvm_loongarch_ops;
> >>>>
> >>>>    #define SW_GCSR                (1 << 0)
> >>>> diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefi=
le
> >>>> index cb41d9265662..fe665054f824 100644
> >>>> --- a/arch/loongarch/kvm/Makefile
> >>>> +++ b/arch/loongarch/kvm/Makefile
> >>>> @@ -11,7 +11,7 @@ kvm-y +=3D exit.o
> >>>>    kvm-y +=3D interrupt.o
> >>>>    kvm-y +=3D main.o
> >>>>    kvm-y +=3D mmu.o
> >>>> -kvm-y +=3D switch.o
> >>>> +obj-y +=3D switch.o
> >>>>    kvm-y +=3D timer.o
> >>>>    kvm-y +=3D tlb.o
> >>>>    kvm-y +=3D vcpu.o
> >>>> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> >>>> index 2c593ac7892f..18800a38b150 100644
> >>>> --- a/arch/loongarch/kvm/main.c
> >>>> +++ b/arch/loongarch/kvm/main.c
> >>>> @@ -348,8 +348,7 @@ void kvm_arch_disable_virtualization_cpu(void)
> >>>>
> >>>>    static int kvm_loongarch_env_init(void)
> >>>>    {
> >>>> -       int cpu, order, ret;
> >>>> -       void *addr;
> >>>> +       int cpu, ret;
> >>>>           struct kvm_context *context;
> >>>>
> >>>>           vmcs =3D alloc_percpu(struct kvm_context);
> >>>> @@ -365,30 +364,8 @@ static int kvm_loongarch_env_init(void)
> >>>>                   return -ENOMEM;
> >>>>           }
> >>>>
> >>>> -       /*
> >>>> -        * PGD register is shared between root kernel and kvm hyperv=
isor.
> >>>> -        * So world switch entry should be in DMW area rather than T=
LB area
> >>>> -        * to avoid page fault reenter.
> >>>> -        *
> >>>> -        * In future if hardware pagetable walking is supported, we =
won't
> >>>> -        * need to copy world switch code to DMW area.
> >>>> -        */
> >>>> -       order =3D get_order(kvm_exception_size + kvm_enter_guest_siz=
e);
> >>>> -       addr =3D (void *)__get_free_pages(GFP_KERNEL, order);
> >>>> -       if (!addr) {
> >>>> -               free_percpu(vmcs);
> >>>> -               vmcs =3D NULL;
> >>>> -               kfree(kvm_loongarch_ops);
> >>>> -               kvm_loongarch_ops =3D NULL;
> >>>> -               return -ENOMEM;
> >>>> -       }
> >>>> -
> >>>> -       memcpy(addr, kvm_exc_entry, kvm_exception_size);
> >>>> -       memcpy(addr + kvm_exception_size, kvm_enter_guest, kvm_enter=
_guest_size);
> >>>> -       flush_icache_range((unsigned long)addr, (unsigned long)addr =
+ kvm_exception_size + kvm_enter_guest_size);
> >>>> -       kvm_loongarch_ops->exc_entry =3D addr;
> >>>> -       kvm_loongarch_ops->enter_guest =3D addr + kvm_exception_size=
;
> >>>> -       kvm_loongarch_ops->page_order =3D order;
> >>>> +       kvm_loongarch_ops->exc_entry =3D (void *)kvm_exc_entry;
> >>>> +       kvm_loongarch_ops->enter_guest =3D (void *)kvm_enter_guest;
> >>>>
> >>>>           vpid_mask =3D read_csr_gstat();
> >>>>           vpid_mask =3D (vpid_mask & CSR_GSTAT_GIDBIT) >> CSR_GSTAT_=
GIDBIT_SHIFT;
> >>>> @@ -422,16 +399,10 @@ static int kvm_loongarch_env_init(void)
> >>>>
> >>>>    static void kvm_loongarch_env_exit(void)
> >>>>    {
> >>>> -       unsigned long addr;
> >>>> -
> >>>>           if (vmcs)
> >>>>                   free_percpu(vmcs);
> >>>>
> >>>>           if (kvm_loongarch_ops) {
> >>>> -               if (kvm_loongarch_ops->exc_entry) {
> >>>> -                       addr =3D (unsigned long)kvm_loongarch_ops->e=
xc_entry;
> >>>> -                       free_pages(addr, kvm_loongarch_ops->page_ord=
er);
> >>>> -               }
> >>>>                   kfree(kvm_loongarch_ops);
> >>>>           }
> >>>>
> >>>> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch=
.S
> >>>> index f1768b7a6194..1a5636790ef9 100644
> >>>> --- a/arch/loongarch/kvm/switch.S
> >>>> +++ b/arch/loongarch/kvm/switch.S
> >>>> @@ -5,10 +5,12 @@
> >>>>
> >>>>    #include <linux/linkage.h>
> >>>>    #include <asm/asm.h>
> >>>> +#include <asm/page.h>
> >>>>    #include <asm/asmmacro.h>
> >>>>    #include <asm/loongarch.h>
> >>>>    #include <asm/regdef.h>
> >>>>    #include <asm/unwind_hints.h>
> >>>> +#include <linux/kvm_types.h>
> >>>>
> >>>>    #define HGPR_OFFSET(x)         (PT_R0 + 8*x)
> >>>>    #define GGPR_OFFSET(x)         (KVM_ARCH_GGPR + 8*x)
> >>>> @@ -100,8 +102,16 @@
> >>>>            *  -        is still in guest mode, such as pgd table/vmi=
d registers etc,
> >>>>            *  -        will fix with hw page walk enabled in future
> >>>>            * load kvm_vcpu from reserved CSR KVM_VCPU_KS, and save a=
2 to KVM_TEMP_KS
> >>>> +        *
> >>>> +        * PGD register is shared between root kernel and kvm hyperv=
isor.
> >>>> +        * So world switch entry should be in DMW area rather than T=
LB area
> >>>> +        * to avoid page fault reenter.
> >>>> +        *
> >>>> +        * In future if hardware pagetable walking is supported, we =
won't
> >>>> +        * need to copy world switch code to DMW area.
> >>>>            */
> >>>>           .text
> >>>> +       .p2align PAGE_SHIFT
> >>>>           .cfi_sections   .debug_frame
> >>>>    SYM_CODE_START(kvm_exc_entry)
> >>>>           UNWIND_HINT_UNDEFINED
> >>>> @@ -190,8 +200,8 @@ ret_to_host:
> >>>>           kvm_restore_host_gpr    a2
> >>>>           jr      ra
> >>>>
> >>>> -SYM_INNER_LABEL(kvm_exc_entry_end, SYM_L_LOCAL)
> >>>>    SYM_CODE_END(kvm_exc_entry)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
> >>>>
> >>>>    /*
> >>>>     * int kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu=
)
> >>>> @@ -200,7 +210,7 @@ SYM_CODE_END(kvm_exc_entry)
> >>>>     *  a0: kvm_run* run
> >>>>     *  a1: kvm_vcpu* vcpu
> >>>>     */
> >>>> -SYM_FUNC_START(kvm_enter_guest)
> >>>> +SYM_CODE_START(kvm_enter_guest)
> >>>>           /* Allocate space in stack bottom */
> >>>>           addi.d  a2, sp, -PT_SIZE
> >>>>           /* Save host GPRs */
> >>>> @@ -215,8 +225,8 @@ SYM_FUNC_START(kvm_enter_guest)
> >>>>           /* Save kvm_vcpu to kscratch */
> >>>>           csrwr   a1, KVM_VCPU_KS
> >>>>           kvm_switch_to_guest
> >>>> -SYM_INNER_LABEL(kvm_enter_guest_end, SYM_L_LOCAL)
> >>>> -SYM_FUNC_END(kvm_enter_guest)
> >>>> +SYM_CODE_END(kvm_enter_guest)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_enter_guest)
> >>>>
> >>>>    SYM_FUNC_START(kvm_save_fpu)
> >>>>           fpu_save_csr    a0 t1
> >>>> @@ -224,6 +234,7 @@ SYM_FUNC_START(kvm_save_fpu)
> >>>>           fpu_save_cc     a0 t1 t2
> >>>>           jr              ra
> >>>>    SYM_FUNC_END(kvm_save_fpu)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_save_fpu)
> >>>>
> >>>>    SYM_FUNC_START(kvm_restore_fpu)
> >>>>           fpu_restore_double a0 t1
> >>>> @@ -231,6 +242,7 @@ SYM_FUNC_START(kvm_restore_fpu)
> >>>>           fpu_restore_cc     a0 t1 t2
> >>>>           jr                 ra
> >>>>    SYM_FUNC_END(kvm_restore_fpu)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_fpu)
> >>>>
> >>>>    #ifdef CONFIG_CPU_HAS_LSX
> >>>>    SYM_FUNC_START(kvm_save_lsx)
> >>>> @@ -239,6 +251,7 @@ SYM_FUNC_START(kvm_save_lsx)
> >>>>           lsx_save_data   a0 t1
> >>>>           jr              ra
> >>>>    SYM_FUNC_END(kvm_save_lsx)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_save_lsx)
> >>>>
> >>>>    SYM_FUNC_START(kvm_restore_lsx)
> >>>>           lsx_restore_data a0 t1
> >>>> @@ -246,6 +259,7 @@ SYM_FUNC_START(kvm_restore_lsx)
> >>>>           fpu_restore_csr  a0 t1 t2
> >>>>           jr               ra
> >>>>    SYM_FUNC_END(kvm_restore_lsx)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_lsx)
> >>>>    #endif
> >>>>
> >>>>    #ifdef CONFIG_CPU_HAS_LASX
> >>>> @@ -255,6 +269,7 @@ SYM_FUNC_START(kvm_save_lasx)
> >>>>           lasx_save_data  a0 t1
> >>>>           jr              ra
> >>>>    SYM_FUNC_END(kvm_save_lasx)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_save_lasx)
> >>>>
> >>>>    SYM_FUNC_START(kvm_restore_lasx)
> >>>>           lasx_restore_data a0 t1
> >>>> @@ -262,10 +277,8 @@ SYM_FUNC_START(kvm_restore_lasx)
> >>>>           fpu_restore_csr   a0 t1 t2
> >>>>           jr                ra
> >>>>    SYM_FUNC_END(kvm_restore_lasx)
> >>>> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_lasx)
> >>>>    #endif
> >>>> -       .section ".rodata"
> >>>> -SYM_DATA(kvm_exception_size, .quad kvm_exc_entry_end - kvm_exc_entr=
y)
> >>>> -SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_ente=
r_guest)
> >>>>
> >>>>    #ifdef CONFIG_CPU_HAS_LBT
> >>>>    STACK_FRAME_NON_STANDARD kvm_restore_fpu
> >>>> --
> >>>> 2.39.1
> >>>>
> >>
>
>
