Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D740355055
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952231; cv=none; b=WQEpqTvoTv14Vmtj32XbafWheCravqgcHNnrnALM7VeMlHeKd+FbhRc0X05wtw4//Jtbw3NnHvTz5wAUsV4YtQFtdA5PMvR3qTdDcAuKWTY98gNrLCnlrHFljNu/X+zC/7NrG/3d0VJO27+dkM4sVYnLvzcCN5JQM1VrlO4gStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952231; c=relaxed/simple;
	bh=IZRPpgBU9ru84OPiInX27uPC+b8bHkdgmq8waLknuZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb4cRR0DVl2DqoqbNBK11GfmYWZ61v/unCEqvzlz5/25sBxzZ5FmadYo7PJL7EjkzmIzjhH+0cNWxt58VXzE1o6+M/rbWdLf1RaHz+z4/O2Yr8fhr0wSdwLQxRnOk5gh3VxYxnHtA6f6yD9z9UCOuR/Mi9ujsTzNJPx4Fu1uPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il9fRqWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il9fRqWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99451F00893
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791952228;
	bh=6GlT1qNrSlF8ti4czw9hlM88sHfivRTAFu6pOYVX2Zs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=il9fRqWoA/6wcpsHFfPB3XVqp4kbxMt5LhzX1JTmrhpRGOT2f7YI7nAXfOia9Sgax
	 qxrzm9ZBN9PF5dkmndz0soz4HQRoshNHDfQheRzZeboGdI35dZtHDQknmyUANFjyS9
	 lGwqWOfsQhbKbfRRHUOBVGFLUE+2YLy6mOE2iuZt/tFThwNxJXBA/Q4y0uCPI5QGbE
	 Qsl9UIV3pfNnC6UiiZaR2rqHBYycISRC/SKNX06tRzJae+4YkiSsxbNmkMVL60JPQ/
	 dED6Tz5TJMMN+OkpjzqLw6NP6oeHyOrM2GpxevbQb9qHV11Z1B73visPB81IWTQXI1
	 G5g1rw5g6n7lA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso5735593a12.0
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 21:30:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwskolI9qruG15QdVrd0gi2tIjYLGnGAM1uwLhKrHd+0+6+kIpMHYvf6VNPq02Kbm8wUco=@vger.kernel.org
X-Gm-Message-State: AFq9FYKogdQztA1hg8SkBA4T4OTwVMq+Ngp2SJe/AH+a/7e5uopOCV+j
	eZ1oVWGliOwYFvvBudIF9gMG5boH45s1oHUYbjGHfKsFg+QPoDZ9+lofUW0yNrkLovnPbV78t8b
	3scicGZL8QN/fvLNK8WjCSqXnujZATgY=
X-Received: by 2002:a05:6402:3547:b0:6af:8a4b:7aad with SMTP id
 4fb4d7f45d1cf-6b17c29f7cdmr13405638a12.28.1791952227373; Tue, 13 Oct 2026
 21:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909085350.2046788-1-maobibo@loongson.cn> <CAAhV-H5uz3SM=tYG02Lz3WiN9stJocY7MQJFSKmVbNrNnz+9Gw@mail.gmail.com>
 <82f2c59a-59f5-8e49-f0c5-dc6feb4070df@loongson.cn> <CAAhV-H4U_-u-Tb1Hn69ahmS3gstDVswrmjby2QfHYvPtLo5cXQ@mail.gmail.com>
 <f86ec356-898b-1ff5-c2d3-182d3eaed14f@loongson.cn>
In-Reply-To: <f86ec356-898b-1ff5-c2d3-182d3eaed14f@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 14 Oct 2026 12:30:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H51k23-1Bd+70kmmrF+OiLA=8x=z7PoKLzsz+ebhn4uEA@mail.gmail.com>
X-Gm-Features: AclHuK9WrmoCHrxortkbZXw7u9H2FmANIoALDhEPrnGke8LeKX3OxdYwbM6nx-8
Message-ID: <CAAhV-H51k23-1Bd+70kmmrF+OiLA=8x=z7PoKLzsz+ebhn4uEA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:55=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/10/11 =E4=B8=8B=E5=8D=8810:06, Huacai Chen wrote:
> > On Thu, Oct 8, 2026 at 9:50=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/10/3 =E4=B8=8B=E5=8D=8812:02, Huacai Chen wrote:
> >>> Hi, Bibo,
> >>>
> >>> On Wed, Sep 9, 2026 at 5:01=E2=80=AFPM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>> Now generic pvpanic is supported in Linux kernel which will notify V=
MM
> >>>> with VM crash event. There is some limitations with pvpanic, such as=
 it
> >>>> requires good kernel stack or CPU hardware context and panic() C fun=
ction
> >>>> is in health state.
> >>>>
> >>>> Sometimes CPU hardware context or kernel/irq stack is corrupted. Hyp=
ercall
> >>>> code is more direct and low-level crash method, which is useful in
> >>>> exception entry with assmble language, here add one hypercall code t=
o
> >>>> support VM crash function, so that VMM can capture CPU crash context
> >>>> in time.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>    arch/loongarch/include/asm/kvm_host.h      |  1 +
> >>>>    arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++++
> >>>>    arch/loongarch/include/uapi/asm/kvm.h      |  1 +
> >>>>    arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
> >>>>    arch/loongarch/kvm/exit.c                  | 11 +++++++++++
> >>>>    arch/loongarch/kvm/vm.c                    |  3 ++-
> >>>>    6 files changed, 31 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/=
include/asm/kvm_host.h
> >>>> index 65d91c3ce313..96f9f1317cad 100644
> >>>> --- a/arch/loongarch/include/asm/kvm_host.h
> >>>> +++ b/arch/loongarch/include/asm/kvm_host.h
> >>>> @@ -168,6 +168,7 @@ enum emulation_result {
> >>>>    #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) |   =
      \
> >>>>                                            BIT(KVM_FEATURE_PREEMPT) =
|     \
> >>>>                                            BIT(KVM_FEATURE_STEAL_TIM=
E) |  \
> >>>> +                                        BIT(KVM_FEATURE_CRASH) |   =
    \
> >>>>                                            BIT(KVM_FEATURE_USER_HCAL=
L) |  \
> >>>>                                            BIT(KVM_FEATURE_VIRT_EXTI=
OI))
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/=
include/asm/kvm_para.h
> >>>> index fb17ba0fa101..3b183bb1aaa8 100644
> >>>> --- a/arch/loongarch/include/asm/kvm_para.h
> >>>> +++ b/arch/loongarch/include/asm/kvm_para.h
> >>>> @@ -14,6 +14,7 @@
> >>>>    #define KVM_HCALL_CODE_SERVICE         0
> >>>>    #define KVM_HCALL_CODE_SWDBG           1
> >>>>    #define KVM_HCALL_CODE_USER_SERVICE    2
> >>>> +#define KVM_HCALL_CODE_CRASH           3
> >>>>
> >>>>    #define KVM_HCALL_SERVICE              HYPERCALL_ENCODE(HYPERVISO=
R_KVM, KVM_HCALL_CODE_SERVICE)
> >>>>    #define  KVM_HCALL_FUNC_IPI            1
> >>>> @@ -22,6 +23,7 @@
> >>>>    #define KVM_HCALL_SWDBG                        HYPERCALL_ENCODE(H=
YPERVISOR_KVM, KVM_HCALL_CODE_SWDBG)
> >>>>
> >>>>    #define KVM_HCALL_USER_SERVICE         HYPERCALL_ENCODE(HYPERVISO=
R_KVM, KVM_HCALL_CODE_USER_SERVICE)
> >>>> +#define KVM_HCALL_CRASH                        HYPERCALL_ENCODE(HYP=
ERVISOR_KVM, KVM_HCALL_CODE_CRASH)
> >>>>
> >>>>    /*
> >>>>     * LoongArch hypercall return code
> >>>> @@ -161,6 +163,19 @@ static __always_inline long kvm_hypercall5(u64 =
fid,
> >>>>           return ret;
> >>>>    }
> >>>>
> >>>> +static __always_inline long kvm_hypercall_crash(void)
> >>>> +{
> >>>> +       register long ret asm("a0");
> >>>> +
> >>>> +       __asm__ __volatile__(
> >>>> +               "hvcl "__stringify(KVM_HCALL_CRASH)
> >>>> +               : "=3Dr" (ret)
> >>>> +               : : "memory"
> >>>> +               );
> >>>> +
> >>>> +       return ret;
> >>>> +}
> >>> Why this function has no caller?
> >> Currently we directly modify guest kernel and hard-code the hypercall
> >> instruction to debug. This inline function is only example for howto
> >> usage, the normal usage such as checking KVM_FEATURE_USER_HCALL featur=
e
> >> + kvm_hypercall_crash() is too complicated in exception entry assemble
> >> language.
> > There are no examples for KVM_HCALL_SWDBG and KVM_HCALL_USER_SERVICE,
> > I think KVM_HCALL_CRASH is no special.
> >
> > So if you agree, I will remove this example when applying.
> Removinge the example usage with KVM_HCALL_CRASH is fine to me.
Now all KVM patches for 7.4 is merged to loongarch-kvm. You can test
it if you want.


Huacai

>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>>
> >>> Huacai
> >>>
> >>>> +
> >>>>    #ifdef CONFIG_PARAVIRT
> >>>>    bool kvm_para_available(void);
> >>>>    unsigned int kvm_arch_para_features(void);
> >>>> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/=
include/uapi/asm/kvm.h
> >>>> index cd0b5c11ca9c..b222bfc48042 100644
> >>>> --- a/arch/loongarch/include/uapi/asm/kvm.h
> >>>> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> >>>> @@ -106,6 +106,7 @@ struct kvm_fpu {
> >>>>    #define  KVM_LOONGARCH_VM_FEAT_PTW             8
> >>>>    #define  KVM_LOONGARCH_VM_FEAT_MSGINT          9
> >>>>    #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT      10
> >>>> +#define  KVM_LOONGARCH_VM_FEAT_CRASH           11
> >>>>
> >>>>    /* Device Control API on vcpu fd */
> >>>>    #define KVM_LOONGARCH_VCPU_CPUCFG      0
> >>>> diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h b/arch/loong=
arch/include/uapi/asm/kvm_para.h
> >>>> index d28cbcadd276..bf1a0c826ca6 100644
> >>>> --- a/arch/loongarch/include/uapi/asm/kvm_para.h
> >>>> +++ b/arch/loongarch/include/uapi/asm/kvm_para.h
> >>>> @@ -16,6 +16,7 @@
> >>>>    #define  KVM_FEATURE_IPI               1
> >>>>    #define  KVM_FEATURE_STEAL_TIME                2
> >>>>    #define  KVM_FEATURE_PREEMPT           3
> >>>> +#define  KVM_FEATURE_CRASH             4
> >>>>    /* BIT 24 - 31 are features configurable by user space vmm */
> >>>>    #define  KVM_FEATURE_VIRT_EXTIOI       24
> >>>>    #define  KVM_FEATURE_USER_HCALL                25
> >>>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> >>>> index 4f58e6e2cf86..3b6daa946c76 100644
> >>>> --- a/arch/loongarch/kvm/exit.c
> >>>> +++ b/arch/loongarch/kvm/exit.c
> >>>> @@ -911,6 +911,17 @@ static int kvm_handle_hypercall(struct kvm_vcpu=
 *vcpu, int ecode)
> >>>>                   vcpu->run->hypercall.ret =3D KVM_HCALL_INVALID_COD=
E;
> >>>>                   ret =3D RESUME_HOST;
> >>>>                   break;
> >>>> +       case KVM_HCALL_CRASH:
> >>>> +               if (!kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_CRAS=
H)) {
> >>>> +                       kvm_write_reg(vcpu, LOONGARCH_GPR_A0, KVM_HC=
ALL_INVALID_CODE);
> >>>> +                       break;
> >>>> +               }
> >>>> +
> >>>> +               vcpu->run->exit_reason =3D KVM_EXIT_SYSTEM_EVENT;
> >>>> +               vcpu->run->system_event.type =3D KVM_SYSTEM_EVENT_CR=
ASH;
> >>>> +               vcpu->run->system_event.ndata =3D 0;
> >>>> +               ret =3D RESUME_HOST;
> >>>> +               break;
> >>>>           case KVM_HCALL_SWDBG:
> >>>>                   /* KVM_HCALL_SWDBG only in effective when SW_BP is=
 enabled */
> >>>>                   if (vcpu->guest_debug & KVM_GUESTDBG_SW_BP_MASK) {
> >>>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> >>>> index 6dabb227a732..e5d10ceb5e67 100644
> >>>> --- a/arch/loongarch/kvm/vm.c
> >>>> +++ b/arch/loongarch/kvm/vm.c
> >>>> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
> >>>>                   kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_F=
EAT_PMU);
> >>>>
> >>>>           /* Enable all PV features by default */
> >>>> -       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI);
> >>>> +       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI) | BIT(KVM_FE=
ATURE_CRASH);
> >>>>           kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_I=
PI);
> >>>> +       kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_CRASH)=
;
> >>>>           if (kvm_pvtime_supported()) {
> >>>>                   kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PREEMPT=
);
> >>>>                   kvm->arch.pv_features |=3D BIT(KVM_FEATURE_STEAL_T=
IME);
> >>>>
> >>>> base-commit: df2908090cda368b01ff43709f51890076c56157
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>>
> >>
>
