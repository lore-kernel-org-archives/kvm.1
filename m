Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD5380FD7
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000153; cv=none; b=hjEm/BG6WernEY2e82NdOV4tx77RbM9UBEPZA5epMx/pJJ5QapX4LXBdx+DwUlq1P0xHFjpHifRPEplKtV/IGIlYxZwtsw47N4UHOa3xEdXVdleBIrdHG/L4Q55uCiqtG7/eRjEH61TYcnCEy3IUpLexE441lvYVdwoBl4Yy42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000153; c=relaxed/simple;
	bh=wl55GbuMlw5Q0S2/n8T0Kv/iG6Tao90DvsUK9wz3pbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/PM+wzG3cP5Zglo/7ZUzPiYXT8BuCEAAQy0oEasYSsJw0jYEVKfwd+bmEq/dWOkivI+NkazLgEijbUchZry2Gy2Ndm3ktsTEaOi76FYwkF6Uo8nalbRc7qjt4OEeI5hS45GFfXta1xxse7GoEXJfKqgc0xzkbXBhgcQCLikkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgsgALTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgsgALTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9971F00898
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791000151;
	bh=iMFSXxk6HYOmOy5i1VOWuirUGgK10sB2pzScRWzaquw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CgsgALTjd492xye3HMPJyHah/VnmzAosdZCVbnmCR8aWvgXE3PbSoB1vl2H0jYcp6
	 zGbdGSP2ZO55nIgzYfoE6w4EsX6jBS5hej57QuT5dYC1LbhXEhT73rX5CChp/zyQWO
	 fk60Qj7nJ6ZL5ZClis0eGmjMSdaecYR1B4USAbpiZZItcsoTQgZcXOYbfD7g4/r2Cu
	 xqRsS7IJfCr27+eY87OZrazTl2RM666nH754iXY/a5CF4ScKc4Pa8tXsBx+LJOeQsv
	 rgcqmUxMwF3n3ymnX8O+/9QfiC2y6jORGFOZmbWbb+55TfwhZPV1qc+IgZIeTnYw43
	 X4X/sm004ZwRw==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a996c8adf3so144763a12.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 21:02:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxvV5ij/p2dC5BErrUBDV740JmSmVK/50LRChX9UkYUTcsr6MyykPmYIa1IRwI1k6jAir4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRQRPP6Lrpi13rTOMFK4QRA3dN625TdztYfbCjo/U7iad+9HKa
	uoEYMuIbCo8LWgNLGHS2chOj5Rw54ys9Mbt3rLwlo9toOk62xyLEYYJWGFWZIQFT41qsDmsBade
	OGJVJ3G++3eS7JpDkcSh/bTQUoTib7Nk=
X-Received: by 2002:a05:6402:46da:b0:6aa:e46b:2c3 with SMTP id
 4fb4d7f45d1cf-6af9e338188mr3128521a12.29.1791000149889; Fri, 02 Oct 2026
 21:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909085350.2046788-1-maobibo@loongson.cn>
In-Reply-To: <20260909085350.2046788-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Oct 2026 12:02:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5uz3SM=tYG02Lz3WiN9stJocY7MQJFSKmVbNrNnz+9Gw@mail.gmail.com>
X-Gm-Features: AclHuK8egJCrzKReQ8HThYHWadmJwczivsCbqUm_Z_x0HVwe9UuKbBrRS6-WG4U
Message-ID: <CAAhV-H5uz3SM=tYG02Lz3WiN9stJocY7MQJFSKmVbNrNnz+9Gw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Wed, Sep 9, 2026 at 5:01=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Now generic pvpanic is supported in Linux kernel which will notify VMM
> with VM crash event. There is some limitations with pvpanic, such as it
> requires good kernel stack or CPU hardware context and panic() C function
> is in health state.
>
> Sometimes CPU hardware context or kernel/irq stack is corrupted. Hypercal=
l
> code is more direct and low-level crash method, which is useful in
> exception entry with assmble language, here add one hypercall code to
> support VM crash function, so that VMM can capture CPU crash context
> in time.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_host.h      |  1 +
>  arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++++
>  arch/loongarch/include/uapi/asm/kvm.h      |  1 +
>  arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
>  arch/loongarch/kvm/exit.c                  | 11 +++++++++++
>  arch/loongarch/kvm/vm.c                    |  3 ++-
>  6 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 65d91c3ce313..96f9f1317cad 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -168,6 +168,7 @@ enum emulation_result {
>  #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) |         \
>                                          BIT(KVM_FEATURE_PREEMPT) |     \
>                                          BIT(KVM_FEATURE_STEAL_TIME) |  \
> +                                        BIT(KVM_FEATURE_CRASH) |       \
>                                          BIT(KVM_FEATURE_USER_HCALL) |  \
>                                          BIT(KVM_FEATURE_VIRT_EXTIOI))
>
> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/inclu=
de/asm/kvm_para.h
> index fb17ba0fa101..3b183bb1aaa8 100644
> --- a/arch/loongarch/include/asm/kvm_para.h
> +++ b/arch/loongarch/include/asm/kvm_para.h
> @@ -14,6 +14,7 @@
>  #define KVM_HCALL_CODE_SERVICE         0
>  #define KVM_HCALL_CODE_SWDBG           1
>  #define KVM_HCALL_CODE_USER_SERVICE    2
> +#define KVM_HCALL_CODE_CRASH           3
>
>  #define KVM_HCALL_SERVICE              HYPERCALL_ENCODE(HYPERVISOR_KVM, =
KVM_HCALL_CODE_SERVICE)
>  #define  KVM_HCALL_FUNC_IPI            1
> @@ -22,6 +23,7 @@
>  #define KVM_HCALL_SWDBG                        HYPERCALL_ENCODE(HYPERVIS=
OR_KVM, KVM_HCALL_CODE_SWDBG)
>
>  #define KVM_HCALL_USER_SERVICE         HYPERCALL_ENCODE(HYPERVISOR_KVM, =
KVM_HCALL_CODE_USER_SERVICE)
> +#define KVM_HCALL_CRASH                        HYPERCALL_ENCODE(HYPERVIS=
OR_KVM, KVM_HCALL_CODE_CRASH)
>
>  /*
>   * LoongArch hypercall return code
> @@ -161,6 +163,19 @@ static __always_inline long kvm_hypercall5(u64 fid,
>         return ret;
>  }
>
> +static __always_inline long kvm_hypercall_crash(void)
> +{
> +       register long ret asm("a0");
> +
> +       __asm__ __volatile__(
> +               "hvcl "__stringify(KVM_HCALL_CRASH)
> +               : "=3Dr" (ret)
> +               : : "memory"
> +               );
> +
> +       return ret;
> +}
Why this function has no caller?


Huacai

> +
>  #ifdef CONFIG_PARAVIRT
>  bool kvm_para_available(void);
>  unsigned int kvm_arch_para_features(void);
> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/inclu=
de/uapi/asm/kvm.h
> index cd0b5c11ca9c..b222bfc48042 100644
> --- a/arch/loongarch/include/uapi/asm/kvm.h
> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> @@ -106,6 +106,7 @@ struct kvm_fpu {
>  #define  KVM_LOONGARCH_VM_FEAT_PTW             8
>  #define  KVM_LOONGARCH_VM_FEAT_MSGINT          9
>  #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT      10
> +#define  KVM_LOONGARCH_VM_FEAT_CRASH           11
>
>  /* Device Control API on vcpu fd */
>  #define KVM_LOONGARCH_VCPU_CPUCFG      0
> diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h b/arch/loongarch/=
include/uapi/asm/kvm_para.h
> index d28cbcadd276..bf1a0c826ca6 100644
> --- a/arch/loongarch/include/uapi/asm/kvm_para.h
> +++ b/arch/loongarch/include/uapi/asm/kvm_para.h
> @@ -16,6 +16,7 @@
>  #define  KVM_FEATURE_IPI               1
>  #define  KVM_FEATURE_STEAL_TIME                2
>  #define  KVM_FEATURE_PREEMPT           3
> +#define  KVM_FEATURE_CRASH             4
>  /* BIT 24 - 31 are features configurable by user space vmm */
>  #define  KVM_FEATURE_VIRT_EXTIOI       24
>  #define  KVM_FEATURE_USER_HCALL                25
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index 4f58e6e2cf86..3b6daa946c76 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -911,6 +911,17 @@ static int kvm_handle_hypercall(struct kvm_vcpu *vcp=
u, int ecode)
>                 vcpu->run->hypercall.ret =3D KVM_HCALL_INVALID_CODE;
>                 ret =3D RESUME_HOST;
>                 break;
> +       case KVM_HCALL_CRASH:
> +               if (!kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_CRASH)) {
> +                       kvm_write_reg(vcpu, LOONGARCH_GPR_A0, KVM_HCALL_I=
NVALID_CODE);
> +                       break;
> +               }
> +
> +               vcpu->run->exit_reason =3D KVM_EXIT_SYSTEM_EVENT;
> +               vcpu->run->system_event.type =3D KVM_SYSTEM_EVENT_CRASH;
> +               vcpu->run->system_event.ndata =3D 0;
> +               ret =3D RESUME_HOST;
> +               break;
>         case KVM_HCALL_SWDBG:
>                 /* KVM_HCALL_SWDBG only in effective when SW_BP is enable=
d */
>                 if (vcpu->guest_debug & KVM_GUESTDBG_SW_BP_MASK) {
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 6dabb227a732..e5d10ceb5e67 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
>                 kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PMU=
);
>
>         /* Enable all PV features by default */
> -       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI);
> +       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI) | BIT(KVM_FEATURE=
_CRASH);
>         kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
> +       kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_CRASH);
>         if (kvm_pvtime_supported()) {
>                 kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PREEMPT);
>                 kvm->arch.pv_features |=3D BIT(KVM_FEATURE_STEAL_TIME);
>
> base-commit: df2908090cda368b01ff43709f51890076c56157
> --
> 2.39.3
>
>
