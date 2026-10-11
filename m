Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAA459AF9
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791727600; cv=none; b=a5uv8wNR9OSkMN/hDBOzezbvo6tkRUMlf/x9jXqV3vIKHJYlxFkOLxCOIi++f2K7g0eeGMwntqclMceZYGSa2v9Rd0NA3j2p0ycMQj+bi/X6Z2XwbxQg24s2Pm7CbY2VpnMVHtPMQK9AvOoWbZFZRjqF15cZ5wFDsoVNKItRguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791727600; c=relaxed/simple;
	bh=fJHSozjGZEQdPVvW4DhOG1+KWh2hbpMpTeyTPQL1k5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joNTEi/BD78Dmifb5blPMinsqRi0J0B+Zxmd4rElxc5IoRJDkGxzlsv6K2muOXyJZwnWJ8iZ6AQ07r45R5oOjzCvMMEwdjiW8r+4cYB9PnbXH/pqg8us4oi7rXsPHBTJCkRFBo3LyVr4i3drEqanUOOM9yYHX6kJNgLCBJD+ni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7BMjFst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7BMjFst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899681F0089C
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791727596;
	bh=gtqBQyfbliur+fbz3i+MZ8zOnVcztULQ5OwziTAn4fc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R7BMjFstDFj2YRf0qvXGSMawdkBCD1a6AHt+EhHsc8W1UCBBZ2EpVowA9uw820zX/
	 HQdbI5xJxsLksVoY3EtYiZgvQfSdV9GKpwh9r1pWPwAz9qlwQOd1tsf74AcArhD1L8
	 6npg0tWcaclRQC2u9AqkcDzUoONGRNEurF7bWMMyhLAMZD0CHhCYENVRZP5u+CuQGL
	 gpB+zCy/lGWxQE2nrQl2oQgmCnLuDQ9bm8JfQQoqFpQulSz7UeaxR0ElodHGrwmKc+
	 mSlWk+YsY7nov+04Kl9siRppIDmdqF2cESVfGZQGvJ8oDDuvtlV0GvOlIekTYN43S4
	 jz1lhZ1qx92oA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so1514070a12.2
        for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 07:06:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxis4pJutC7/OrzR3qFGgol57LozZphRlNcxdvGJ//SiflVonsNWvJQu6M0HEN09Nkx/W8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOdIBiKXn4K4jJ5BE3ZBugRjjV0AALpDEPAZ8/Q8tv6VinGJ2q
	VL5v90Q+mgXPyyaxRHb9Mz2xeFu4AUrUmmF4jXpw8yRMwQjL0ZC+0JZZ+uj3lTw6I+vSpWKwl9f
	yo/B3zM2hXJzp3isxJwh6tg0RUGIPV5k=
X-Received: by 2002:a05:6402:f0c:b0:6b1:b176:73a9 with SMTP id
 4fb4d7f45d1cf-6b1b1767781mr800741a12.27.1791727595203; Sun, 11 Oct 2026
 07:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909085350.2046788-1-maobibo@loongson.cn> <CAAhV-H5uz3SM=tYG02Lz3WiN9stJocY7MQJFSKmVbNrNnz+9Gw@mail.gmail.com>
 <82f2c59a-59f5-8e49-f0c5-dc6feb4070df@loongson.cn>
In-Reply-To: <82f2c59a-59f5-8e49-f0c5-dc6feb4070df@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 11 Oct 2026 22:06:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4U_-u-Tb1Hn69ahmS3gstDVswrmjby2QfHYvPtLo5cXQ@mail.gmail.com>
X-Gm-Features: AclHuK93qjD0qIBknY1CG7puAT7RifE8djAwxbcXuRkP4OeDm9mGLr7yPpV2Hy4
Message-ID: <CAAhV-H4U_-u-Tb1Hn69ahmS3gstDVswrmjby2QfHYvPtLo5cXQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 9:50=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/10/3 =E4=B8=8B=E5=8D=8812:02, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Wed, Sep 9, 2026 at 5:01=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >> Now generic pvpanic is supported in Linux kernel which will notify VMM
> >> with VM crash event. There is some limitations with pvpanic, such as i=
t
> >> requires good kernel stack or CPU hardware context and panic() C funct=
ion
> >> is in health state.
> >>
> >> Sometimes CPU hardware context or kernel/irq stack is corrupted. Hyper=
call
> >> code is more direct and low-level crash method, which is useful in
> >> exception entry with assmble language, here add one hypercall code to
> >> support VM crash function, so that VMM can capture CPU crash context
> >> in time.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/kvm_host.h      |  1 +
> >>   arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++++
> >>   arch/loongarch/include/uapi/asm/kvm.h      |  1 +
> >>   arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
> >>   arch/loongarch/kvm/exit.c                  | 11 +++++++++++
> >>   arch/loongarch/kvm/vm.c                    |  3 ++-
> >>   6 files changed, 31 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/in=
clude/asm/kvm_host.h
> >> index 65d91c3ce313..96f9f1317cad 100644
> >> --- a/arch/loongarch/include/asm/kvm_host.h
> >> +++ b/arch/loongarch/include/asm/kvm_host.h
> >> @@ -168,6 +168,7 @@ enum emulation_result {
> >>   #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) |      =
   \
> >>                                           BIT(KVM_FEATURE_PREEMPT) |  =
   \
> >>                                           BIT(KVM_FEATURE_STEAL_TIME) =
|  \
> >> +                                        BIT(KVM_FEATURE_CRASH) |     =
  \
> >>                                           BIT(KVM_FEATURE_USER_HCALL) =
|  \
> >>                                           BIT(KVM_FEATURE_VIRT_EXTIOI)=
)
> >>
> >> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/in=
clude/asm/kvm_para.h
> >> index fb17ba0fa101..3b183bb1aaa8 100644
> >> --- a/arch/loongarch/include/asm/kvm_para.h
> >> +++ b/arch/loongarch/include/asm/kvm_para.h
> >> @@ -14,6 +14,7 @@
> >>   #define KVM_HCALL_CODE_SERVICE         0
> >>   #define KVM_HCALL_CODE_SWDBG           1
> >>   #define KVM_HCALL_CODE_USER_SERVICE    2
> >> +#define KVM_HCALL_CODE_CRASH           3
> >>
> >>   #define KVM_HCALL_SERVICE              HYPERCALL_ENCODE(HYPERVISOR_K=
VM, KVM_HCALL_CODE_SERVICE)
> >>   #define  KVM_HCALL_FUNC_IPI            1
> >> @@ -22,6 +23,7 @@
> >>   #define KVM_HCALL_SWDBG                        HYPERCALL_ENCODE(HYPE=
RVISOR_KVM, KVM_HCALL_CODE_SWDBG)
> >>
> >>   #define KVM_HCALL_USER_SERVICE         HYPERCALL_ENCODE(HYPERVISOR_K=
VM, KVM_HCALL_CODE_USER_SERVICE)
> >> +#define KVM_HCALL_CRASH                        HYPERCALL_ENCODE(HYPER=
VISOR_KVM, KVM_HCALL_CODE_CRASH)
> >>
> >>   /*
> >>    * LoongArch hypercall return code
> >> @@ -161,6 +163,19 @@ static __always_inline long kvm_hypercall5(u64 fi=
d,
> >>          return ret;
> >>   }
> >>
> >> +static __always_inline long kvm_hypercall_crash(void)
> >> +{
> >> +       register long ret asm("a0");
> >> +
> >> +       __asm__ __volatile__(
> >> +               "hvcl "__stringify(KVM_HCALL_CRASH)
> >> +               : "=3Dr" (ret)
> >> +               : : "memory"
> >> +               );
> >> +
> >> +       return ret;
> >> +}
> > Why this function has no caller?
> Currently we directly modify guest kernel and hard-code the hypercall
> instruction to debug. This inline function is only example for howto
> usage, the normal usage such as checking KVM_FEATURE_USER_HCALL feature
> + kvm_hypercall_crash() is too complicated in exception entry assemble
> language.
There are no examples for KVM_HCALL_SWDBG and KVM_HCALL_USER_SERVICE,
I think KVM_HCALL_CRASH is no special.

So if you agree, I will remove this example when applying.


Huacai

>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >
> >> +
> >>   #ifdef CONFIG_PARAVIRT
> >>   bool kvm_para_available(void);
> >>   unsigned int kvm_arch_para_features(void);
> >> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/in=
clude/uapi/asm/kvm.h
> >> index cd0b5c11ca9c..b222bfc48042 100644
> >> --- a/arch/loongarch/include/uapi/asm/kvm.h
> >> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> >> @@ -106,6 +106,7 @@ struct kvm_fpu {
> >>   #define  KVM_LOONGARCH_VM_FEAT_PTW             8
> >>   #define  KVM_LOONGARCH_VM_FEAT_MSGINT          9
> >>   #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT      10
> >> +#define  KVM_LOONGARCH_VM_FEAT_CRASH           11
> >>
> >>   /* Device Control API on vcpu fd */
> >>   #define KVM_LOONGARCH_VCPU_CPUCFG      0
> >> diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h b/arch/loongar=
ch/include/uapi/asm/kvm_para.h
> >> index d28cbcadd276..bf1a0c826ca6 100644
> >> --- a/arch/loongarch/include/uapi/asm/kvm_para.h
> >> +++ b/arch/loongarch/include/uapi/asm/kvm_para.h
> >> @@ -16,6 +16,7 @@
> >>   #define  KVM_FEATURE_IPI               1
> >>   #define  KVM_FEATURE_STEAL_TIME                2
> >>   #define  KVM_FEATURE_PREEMPT           3
> >> +#define  KVM_FEATURE_CRASH             4
> >>   /* BIT 24 - 31 are features configurable by user space vmm */
> >>   #define  KVM_FEATURE_VIRT_EXTIOI       24
> >>   #define  KVM_FEATURE_USER_HCALL                25
> >> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> >> index 4f58e6e2cf86..3b6daa946c76 100644
> >> --- a/arch/loongarch/kvm/exit.c
> >> +++ b/arch/loongarch/kvm/exit.c
> >> @@ -911,6 +911,17 @@ static int kvm_handle_hypercall(struct kvm_vcpu *=
vcpu, int ecode)
> >>                  vcpu->run->hypercall.ret =3D KVM_HCALL_INVALID_CODE;
> >>                  ret =3D RESUME_HOST;
> >>                  break;
> >> +       case KVM_HCALL_CRASH:
> >> +               if (!kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_CRASH)=
) {
> >> +                       kvm_write_reg(vcpu, LOONGARCH_GPR_A0, KVM_HCAL=
L_INVALID_CODE);
> >> +                       break;
> >> +               }
> >> +
> >> +               vcpu->run->exit_reason =3D KVM_EXIT_SYSTEM_EVENT;
> >> +               vcpu->run->system_event.type =3D KVM_SYSTEM_EVENT_CRAS=
H;
> >> +               vcpu->run->system_event.ndata =3D 0;
> >> +               ret =3D RESUME_HOST;
> >> +               break;
> >>          case KVM_HCALL_SWDBG:
> >>                  /* KVM_HCALL_SWDBG only in effective when SW_BP is en=
abled */
> >>                  if (vcpu->guest_debug & KVM_GUESTDBG_SW_BP_MASK) {
> >> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> >> index 6dabb227a732..e5d10ceb5e67 100644
> >> --- a/arch/loongarch/kvm/vm.c
> >> +++ b/arch/loongarch/kvm/vm.c
> >> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
> >>                  kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT=
_PMU);
> >>
> >>          /* Enable all PV features by default */
> >> -       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI);
> >> +       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI) | BIT(KVM_FEAT=
URE_CRASH);
> >>          kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI)=
;
> >> +       kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_CRASH);
> >>          if (kvm_pvtime_supported()) {
> >>                  kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PREEMPT);
> >>                  kvm->arch.pv_features |=3D BIT(KVM_FEATURE_STEAL_TIME=
);
> >>
> >> base-commit: df2908090cda368b01ff43709f51890076c56157
> >> --
> >> 2.39.3
> >>
> >>
>
