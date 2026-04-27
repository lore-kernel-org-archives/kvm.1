Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986939022B
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276552; cv=none; b=JTxNvSs1hvBh8zXjFFYXW5FSjaWxuLBfiQq0YM9xE7ZOGUFAxyxyHvg9Wp+IY3W7OWSzgup/9yIOKJGhk9CK+U/olGTfChITmYTwhVnpiOTH2/dMnCg8snRKwiVi7+XJMIk8vvE/jYqQd3amJX5O2cU4GvQ6iJQCZxI93EZR8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276552; c=relaxed/simple;
	bh=AA97YxQ92X1wowII0q7zfF7kp5Gbnl4LF6jl/AHc7hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSj4svbYFLhMQLOQa8HQKznVTbhdESlacFjWyhwIFEZ0XZk57hu364Z7j8Ad4ET0gwsW+xbKJsi5+jsbvcjLtoVoG13pe1Zf4VG/YZ8m2fIBasNE/TeT9Hs/PVknuUKBtDXC96pS/xhtp8pQheLZrLa5vBxf5E/1tlSsGwJtDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+uF/I0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+uF/I0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46654C2BCB9
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 07:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777276552;
	bh=AA97YxQ92X1wowII0q7zfF7kp5Gbnl4LF6jl/AHc7hE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B+uF/I0b1dPNTaEd5wQAqw/mpYlsYpFAmjPAEvMRM88DzIME/P9MNqoopdrRI0uOn
	 VS+/M1trM0aTnOoQMNzgALMiIyuEjnrFF7EzCwH/14jmLeJOKCWG7cSdMyxB4Ku6Zd
	 Yd2MuU9742uniIWb9Eu2h9YcJ6Vj646LG4cxEmJLlrLjqVolPEkZKFr0BBRmZwg+nj
	 p+gpVNwLHJl5zQ9hGh35D6RgRmh2m5exqRcirqv3p+N1K7xD5oICJRA5CcsKAcPrEM
	 SBZltKxLJwR5DeWEi//BA1vKqjNzq31BM5Cf97qqsDQOZpxPH5TmrZoXAQJbFydJOw
	 ZWIVpdkncNugQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bad54961385so593137466b.2
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 00:55:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8fAPf4pREf2yGvgEGW/QuPp8QbJWYknE18AshhdSMpiaxaDsZgcW3NXYP/MJG1ZA71LVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpjNe/IA+mkX8z4c0AwJAxATZX/mVJdQf7TdLKUGqoK52rnUH
	jwQE3PfWX7+Nvmn14LCrSIPZ/xrKn0jSSMcGj9LJj1Im51bP4cTxZnt/NxLw22h/MvjqS9An8XD
	c7KnHqEW8WbL/6B6ft/8sKCK8Rm5EPE0=
X-Received: by 2002:a17:906:ef07:b0:ba7:e3ee:47a1 with SMTP id
 a640c23a62f3a-ba7e3fd9970mr1680449066b.4.1777276550695; Mon, 27 Apr 2026
 00:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414113111.2997864-1-lixianglai@loongson.cn> <20260414113111.2997864-2-lixianglai@loongson.cn>
In-Reply-To: <20260414113111.2997864-2-lixianglai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 27 Apr 2026 15:56:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6g41ah0xUxKJfe1=+xSMeaBcAbGnYya-xMAT3NtFUbgg@mail.gmail.com>
X-Gm-Features: AVHnY4LKvjWWwTd1Y2Flfj2PhKKKue-_vW1WftHRXP-uqm6HKW7q6rfpxi0NF6M
Message-ID: <CAAhV-H6g41ah0xUxKJfe1=+xSMeaBcAbGnYya-xMAT3NtFUbgg@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] LoongArch: KVM: Compile the switch.S file directly
 into the kernel
To: Xianglai Li <lixianglai@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Xianglai,

After this patch I get:
arch/loongarch/kvm/switch.o: warning: objtool: kvm_enter_guest+0x0:
unreachable instruction

But if I restore SYM_FUNC_START/SYM_FUNC_END for kvm_enter_guest, the
warning disappear. So please make sure which one is correct.

Huacai

On Tue, Apr 14, 2026 at 7:57=E2=80=AFPM Xianglai Li <lixianglai@loongson.cn=
> wrote:
>
> If we directly compile the switch.S file into the kernel, the address of
> the kvm_exc_entry function will definitely be within the DMW memory area.
> Therefore, we will no longer need to perform a copy relocation of
> kvm_exc_entry.
>
> Based on the above description, compile switch.S directly into the kernel=
,
> and then remove the copy relocation execution logic for the kvm_exc_entry
> function.
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
>
>  arch/loongarch/Kbuild                       |  2 +-
>  arch/loongarch/include/asm/asm-prototypes.h | 21 +++++++++++++
>  arch/loongarch/include/asm/kvm_host.h       |  3 --
>  arch/loongarch/kvm/Makefile                 |  2 +-
>  arch/loongarch/kvm/main.c                   | 35 ++-------------------
>  arch/loongarch/kvm/switch.S                 | 27 +++++++++++-----
>  6 files changed, 46 insertions(+), 44 deletions(-)
>
> diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
> index beb8499dd8ed..1c7a0dbe5e72 100644
> --- a/arch/loongarch/Kbuild
> +++ b/arch/loongarch/Kbuild
> @@ -3,7 +3,7 @@ obj-y +=3D mm/
>  obj-y +=3D net/
>  obj-y +=3D vdso/
>
> -obj-$(CONFIG_KVM) +=3D kvm/
> +obj-$(subst m,y,$(CONFIG_KVM)) +=3D kvm/
>
>  # for cleaning
>  subdir- +=3D boot
> diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch=
/include/asm/asm-prototypes.h
> index 704066b4f736..e8ce153691e5 100644
> --- a/arch/loongarch/include/asm/asm-prototypes.h
> +++ b/arch/loongarch/include/asm/asm-prototypes.h
> @@ -20,3 +20,24 @@ asmlinkage void noinstr __no_stack_protector ret_from_=
kernel_thread(struct task_
>                                                                     struc=
t pt_regs *regs,
>                                                                     int (=
*fn)(void *),
>                                                                     void =
*fn_arg);
> +
> +struct kvm_run;
> +struct kvm_vcpu;
> +
> +void kvm_exc_entry(void);
> +int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +
> +struct loongarch_fpu;
> +
> +#ifdef CONFIG_CPU_HAS_LSX
> +void kvm_save_lsx(struct loongarch_fpu *fpu);
> +void kvm_restore_lsx(struct loongarch_fpu *fpu);
> +#endif
> +
> +#ifdef CONFIG_CPU_HAS_LASX
> +void kvm_save_lasx(struct loongarch_fpu *fpu);
> +void kvm_restore_lasx(struct loongarch_fpu *fpu);
> +#endif
> +
> +void kvm_save_fpu(struct loongarch_fpu *fpu);
> +void kvm_restore_fpu(struct loongarch_fpu *fpu);
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 19eb5e5c3984..0bcdffc14c5f 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -86,7 +86,6 @@ struct kvm_context {
>  struct kvm_world_switch {
>         int (*exc_entry)(void);
>         int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *vcpu);
> -       unsigned long page_order;
>  };
>
>  #define MAX_PGTABLE_LEVELS     4
> @@ -356,8 +355,6 @@ void kvm_exc_entry(void);
>  int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
>
>  extern unsigned long vpid_mask;
> -extern const unsigned long kvm_exception_size;
> -extern const unsigned long kvm_enter_guest_size;
>  extern struct kvm_world_switch *kvm_loongarch_ops;
>
>  #define SW_GCSR                (1 << 0)
> diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
> index cb41d9265662..fe665054f824 100644
> --- a/arch/loongarch/kvm/Makefile
> +++ b/arch/loongarch/kvm/Makefile
> @@ -11,7 +11,7 @@ kvm-y +=3D exit.o
>  kvm-y +=3D interrupt.o
>  kvm-y +=3D main.o
>  kvm-y +=3D mmu.o
> -kvm-y +=3D switch.o
> +obj-y +=3D switch.o
>  kvm-y +=3D timer.o
>  kvm-y +=3D tlb.o
>  kvm-y +=3D vcpu.o
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 2c593ac7892f..18800a38b150 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -348,8 +348,7 @@ void kvm_arch_disable_virtualization_cpu(void)
>
>  static int kvm_loongarch_env_init(void)
>  {
> -       int cpu, order, ret;
> -       void *addr;
> +       int cpu, ret;
>         struct kvm_context *context;
>
>         vmcs =3D alloc_percpu(struct kvm_context);
> @@ -365,30 +364,8 @@ static int kvm_loongarch_env_init(void)
>                 return -ENOMEM;
>         }
>
> -       /*
> -        * PGD register is shared between root kernel and kvm hypervisor.
> -        * So world switch entry should be in DMW area rather than TLB ar=
ea
> -        * to avoid page fault reenter.
> -        *
> -        * In future if hardware pagetable walking is supported, we won't
> -        * need to copy world switch code to DMW area.
> -        */
> -       order =3D get_order(kvm_exception_size + kvm_enter_guest_size);
> -       addr =3D (void *)__get_free_pages(GFP_KERNEL, order);
> -       if (!addr) {
> -               free_percpu(vmcs);
> -               vmcs =3D NULL;
> -               kfree(kvm_loongarch_ops);
> -               kvm_loongarch_ops =3D NULL;
> -               return -ENOMEM;
> -       }
> -
> -       memcpy(addr, kvm_exc_entry, kvm_exception_size);
> -       memcpy(addr + kvm_exception_size, kvm_enter_guest, kvm_enter_gues=
t_size);
> -       flush_icache_range((unsigned long)addr, (unsigned long)addr + kvm=
_exception_size + kvm_enter_guest_size);
> -       kvm_loongarch_ops->exc_entry =3D addr;
> -       kvm_loongarch_ops->enter_guest =3D addr + kvm_exception_size;
> -       kvm_loongarch_ops->page_order =3D order;
> +       kvm_loongarch_ops->exc_entry =3D (void *)kvm_exc_entry;
> +       kvm_loongarch_ops->enter_guest =3D (void *)kvm_enter_guest;
>
>         vpid_mask =3D read_csr_gstat();
>         vpid_mask =3D (vpid_mask & CSR_GSTAT_GIDBIT) >> CSR_GSTAT_GIDBIT_=
SHIFT;
> @@ -422,16 +399,10 @@ static int kvm_loongarch_env_init(void)
>
>  static void kvm_loongarch_env_exit(void)
>  {
> -       unsigned long addr;
> -
>         if (vmcs)
>                 free_percpu(vmcs);
>
>         if (kvm_loongarch_ops) {
> -               if (kvm_loongarch_ops->exc_entry) {
> -                       addr =3D (unsigned long)kvm_loongarch_ops->exc_en=
try;
> -                       free_pages(addr, kvm_loongarch_ops->page_order);
> -               }
>                 kfree(kvm_loongarch_ops);
>         }
>
> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
> index f1768b7a6194..1a5636790ef9 100644
> --- a/arch/loongarch/kvm/switch.S
> +++ b/arch/loongarch/kvm/switch.S
> @@ -5,10 +5,12 @@
>
>  #include <linux/linkage.h>
>  #include <asm/asm.h>
> +#include <asm/page.h>
>  #include <asm/asmmacro.h>
>  #include <asm/loongarch.h>
>  #include <asm/regdef.h>
>  #include <asm/unwind_hints.h>
> +#include <linux/kvm_types.h>
>
>  #define HGPR_OFFSET(x)         (PT_R0 + 8*x)
>  #define GGPR_OFFSET(x)         (KVM_ARCH_GGPR + 8*x)
> @@ -100,8 +102,16 @@
>          *  -        is still in guest mode, such as pgd table/vmid regis=
ters etc,
>          *  -        will fix with hw page walk enabled in future
>          * load kvm_vcpu from reserved CSR KVM_VCPU_KS, and save a2 to KV=
M_TEMP_KS
> +        *
> +        * PGD register is shared between root kernel and kvm hypervisor.
> +        * So world switch entry should be in DMW area rather than TLB ar=
ea
> +        * to avoid page fault reenter.
> +        *
> +        * In future if hardware pagetable walking is supported, we won't
> +        * need to copy world switch code to DMW area.
>          */
>         .text
> +       .p2align PAGE_SHIFT
>         .cfi_sections   .debug_frame
>  SYM_CODE_START(kvm_exc_entry)
>         UNWIND_HINT_UNDEFINED
> @@ -190,8 +200,8 @@ ret_to_host:
>         kvm_restore_host_gpr    a2
>         jr      ra
>
> -SYM_INNER_LABEL(kvm_exc_entry_end, SYM_L_LOCAL)
>  SYM_CODE_END(kvm_exc_entry)
> +EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
>
>  /*
>   * int kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu)
> @@ -200,7 +210,7 @@ SYM_CODE_END(kvm_exc_entry)
>   *  a0: kvm_run* run
>   *  a1: kvm_vcpu* vcpu
>   */
> -SYM_FUNC_START(kvm_enter_guest)
> +SYM_CODE_START(kvm_enter_guest)
>         /* Allocate space in stack bottom */
>         addi.d  a2, sp, -PT_SIZE
>         /* Save host GPRs */
> @@ -215,8 +225,8 @@ SYM_FUNC_START(kvm_enter_guest)
>         /* Save kvm_vcpu to kscratch */
>         csrwr   a1, KVM_VCPU_KS
>         kvm_switch_to_guest
> -SYM_INNER_LABEL(kvm_enter_guest_end, SYM_L_LOCAL)
> -SYM_FUNC_END(kvm_enter_guest)
> +SYM_CODE_END(kvm_enter_guest)
> +EXPORT_SYMBOL_FOR_KVM(kvm_enter_guest)
>
>  SYM_FUNC_START(kvm_save_fpu)
>         fpu_save_csr    a0 t1
> @@ -224,6 +234,7 @@ SYM_FUNC_START(kvm_save_fpu)
>         fpu_save_cc     a0 t1 t2
>         jr              ra
>  SYM_FUNC_END(kvm_save_fpu)
> +EXPORT_SYMBOL_FOR_KVM(kvm_save_fpu)
>
>  SYM_FUNC_START(kvm_restore_fpu)
>         fpu_restore_double a0 t1
> @@ -231,6 +242,7 @@ SYM_FUNC_START(kvm_restore_fpu)
>         fpu_restore_cc     a0 t1 t2
>         jr                 ra
>  SYM_FUNC_END(kvm_restore_fpu)
> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_fpu)
>
>  #ifdef CONFIG_CPU_HAS_LSX
>  SYM_FUNC_START(kvm_save_lsx)
> @@ -239,6 +251,7 @@ SYM_FUNC_START(kvm_save_lsx)
>         lsx_save_data   a0 t1
>         jr              ra
>  SYM_FUNC_END(kvm_save_lsx)
> +EXPORT_SYMBOL_FOR_KVM(kvm_save_lsx)
>
>  SYM_FUNC_START(kvm_restore_lsx)
>         lsx_restore_data a0 t1
> @@ -246,6 +259,7 @@ SYM_FUNC_START(kvm_restore_lsx)
>         fpu_restore_csr  a0 t1 t2
>         jr               ra
>  SYM_FUNC_END(kvm_restore_lsx)
> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_lsx)
>  #endif
>
>  #ifdef CONFIG_CPU_HAS_LASX
> @@ -255,6 +269,7 @@ SYM_FUNC_START(kvm_save_lasx)
>         lasx_save_data  a0 t1
>         jr              ra
>  SYM_FUNC_END(kvm_save_lasx)
> +EXPORT_SYMBOL_FOR_KVM(kvm_save_lasx)
>
>  SYM_FUNC_START(kvm_restore_lasx)
>         lasx_restore_data a0 t1
> @@ -262,10 +277,8 @@ SYM_FUNC_START(kvm_restore_lasx)
>         fpu_restore_csr   a0 t1 t2
>         jr                ra
>  SYM_FUNC_END(kvm_restore_lasx)
> +EXPORT_SYMBOL_FOR_KVM(kvm_restore_lasx)
>  #endif
> -       .section ".rodata"
> -SYM_DATA(kvm_exception_size, .quad kvm_exc_entry_end - kvm_exc_entry)
> -SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_enter_gue=
st)
>
>  #ifdef CONFIG_CPU_HAS_LBT
>  STACK_FRAME_NON_STANDARD kvm_restore_fpu
> --
> 2.39.1
>
