Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DEB284690
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125079; cv=none; b=uRoHW6sRlRpp9PvVOr9Hor7e2Lq34i32Yac4rLng+XqEmfXOha1dqoIawmGOMaCqYMUdjBQofVj5JZs05oFc+TR7Phk6uEr0ks8hTGU2GVoE2YODUagPMeLIbtj7CqO9FBCJKso5qElRAuVA324g7hMZAfWL3Uq02J6Nb6PdWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125079; c=relaxed/simple;
	bh=KpidYZdXrR64JPhB2FTc4k/OIPlcrb+5ujZf2NetLA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUrzk+TvANm4FBCnIuWT+asbuekrdWCSIwkGH2E6E8aDFZuWNmdfiINRn18cSUwYocjYOh3TICfif1r6ND+tZZRuuO6y2rM6NTvnUcGHlEMG+RzXmhpCshwbMStNScIC0uLdwbxUKSMJyLJkWt9xucV4zahdtN18jA4PxzLV+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUgn2rh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUgn2rh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DBA1F000C6
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792125078;
	bh=BIUlkBgjdjbrG+MYn8ushJVDjtas9pFOnEXDesAHWzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eUgn2rh6qBb8SryBV4mUF+KaX6K8su9WvPnqcxYDRRjIkiZqr45/dOwsT6MTJO57i
	 K0kmB9qTCM5rnybWZ1W+lQb6hC5DC1yO6y2fDpWKLt+so6AA3UK5gOUUZzpyAMddMg
	 fH/KvitdcDPVPVLdU5ltAQTAqvOb9IB2lWzSFHnNbh2N+oHL39dzn01Bz8RxgWhETx
	 Wf028LerEYOB1PW7ZuERTxBD/X2mz9PCWWPagx5+E+89C6kTNNAQVWlcEORotnfHiT
	 72SpGuTC0WDc5ub+gAYtlf08mmNVg6mMY+n/OeKd48y0oJNodLhvLKn7WGMpdRX4j3
	 ZIqS/LUb6Uhxw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so3562167a12.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:31:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxoi8FunTsPDMWbKlg/KX5UYrthrD/ImYaPHX7fZH18IZ+wSEpcHu6/YghJBDW20T3xFrg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4kAyl2bCajn4+IFZf3Fg551Sjcz0iS/eqYIt7Lgbal0ZDg/vq
	RbGuCO/OKvta5v8KpBVsKAELci7tZstHThibLjzIwH3ETTlLZ4frXrIne5GBNMRCghrR84zYfN2
	TxK9W3XcxdCX50wnBwa6dgC3FWjI4ibM=
X-Received: by 2002:a05:6402:5187:b0:6b1:ecee:8e77 with SMTP id
 4fb4d7f45d1cf-6b1ecee91f6mr8509720a12.43.1792125077041; Thu, 15 Oct 2026
 21:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909085350.2046788-1-maobibo@loongson.cn> <CAAhV-H5uz3SM=tYG02Lz3WiN9stJocY7MQJFSKmVbNrNnz+9Gw@mail.gmail.com>
 <82f2c59a-59f5-8e49-f0c5-dc6feb4070df@loongson.cn> <CAAhV-H4U_-u-Tb1Hn69ahmS3gstDVswrmjby2QfHYvPtLo5cXQ@mail.gmail.com>
 <f86ec356-898b-1ff5-c2d3-182d3eaed14f@loongson.cn> <CAAhV-H51k23-1Bd+70kmmrF+OiLA=8x=z7PoKLzsz+ebhn4uEA@mail.gmail.com>
 <654d03ff-1690-a1bd-f126-f9d339c71e99@loongson.cn> <1374103b-931d-d068-8a9f-6f1fdc1ab1c1@loongson.cn>
In-Reply-To: <1374103b-931d-d068-8a9f-6f1fdc1ab1c1@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 16 Oct 2026 12:31:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4NoXQu=eCrU_=WMsLYfEr4EEAYrQ_KEpkuwn=26LiCVg@mail.gmail.com>
X-Gm-Features: AclHuK8wbQV0D5DJe0VyA8EuqUUojIxc5T5IaVUenGf9oDjRfrfUDBFdvGWPeoA
Message-ID: <CAAhV-H4NoXQu=eCrU_=WMsLYfEr4EEAYrQ_KEpkuwn=26LiCVg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:27=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2026/10/16 =E4=B8=8A=E5=8D=889:06, Bibo Mao wrote:
> >
> >
> > On 2026/10/14 =E4=B8=8B=E5=8D=8812:30, Huacai Chen wrote:
> >> On Mon, Oct 12, 2026 at 8:55=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>
> >>>
> >>>
> >>> On 2026/10/11 =E4=B8=8B=E5=8D=8810:06, Huacai Chen wrote:
> >>>> On Thu, Oct 8, 2026 at 9:50=E2=80=AFAM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2026/10/3 =E4=B8=8B=E5=8D=8812:02, Huacai Chen wrote:
> >>>>>> Hi, Bibo,
> >>>>>>
> >>>>>> On Wed, Sep 9, 2026 at 5:01=E2=80=AFPM Bibo Mao <maobibo@loongson.=
cn> wrote:
> >>>>>>>
> >>>>>>> Now generic pvpanic is supported in Linux kernel which will
> >>>>>>> notify VMM
> >>>>>>> with VM crash event. There is some limitations with pvpanic, such
> >>>>>>> as it
> >>>>>>> requires good kernel stack or CPU hardware context and panic() C
> >>>>>>> function
> >>>>>>> is in health state.
> >>>>>>>
> >>>>>>> Sometimes CPU hardware context or kernel/irq stack is corrupted.
> >>>>>>> Hypercall
> >>>>>>> code is more direct and low-level crash method, which is useful i=
n
> >>>>>>> exception entry with assmble language, here add one hypercall
> >>>>>>> code to
> >>>>>>> support VM crash function, so that VMM can capture CPU crash cont=
ext
> >>>>>>> in time.
> >>>>>>>
> >>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>> ---
> >>>>>>>     arch/loongarch/include/asm/kvm_host.h      |  1 +
> >>>>>>>     arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++=
++
> >>>>>>>     arch/loongarch/include/uapi/asm/kvm.h      |  1 +
> >>>>>>>     arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
> >>>>>>>     arch/loongarch/kvm/exit.c                  | 11 +++++++++++
> >>>>>>>     arch/loongarch/kvm/vm.c                    |  3 ++-
> >>>>>>>     6 files changed, 31 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/loongarch/include/asm/kvm_host.h
> >>>>>>> b/arch/loongarch/include/asm/kvm_host.h
> >>>>>>> index 65d91c3ce313..96f9f1317cad 100644
> >>>>>>> --- a/arch/loongarch/include/asm/kvm_host.h
> >>>>>>> +++ b/arch/loongarch/include/asm/kvm_host.h
> >>>>>>> @@ -168,6 +168,7 @@ enum emulation_result {
> >>>>>>>     #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI)
> >>>>>>> |         \
> >>>>>>>
> >>>>>>> BIT(KVM_FEATURE_PREEMPT) |     \
> >>>>>>>
> >>>>>>> BIT(KVM_FEATURE_STEAL_TIME) |  \
> >>>>>>> +                                        BIT(KVM_FEATURE_CRASH)
> >>>>>>> |       \
> >>>>>>>
> >>>>>>> BIT(KVM_FEATURE_USER_HCALL) |  \
> >>>>>>>
> >>>>>>> BIT(KVM_FEATURE_VIRT_EXTIOI))
> >>>>>>>
> >>>>>>> diff --git a/arch/loongarch/include/asm/kvm_para.h
> >>>>>>> b/arch/loongarch/include/asm/kvm_para.h
> >>>>>>> index fb17ba0fa101..3b183bb1aaa8 100644
> >>>>>>> --- a/arch/loongarch/include/asm/kvm_para.h
> >>>>>>> +++ b/arch/loongarch/include/asm/kvm_para.h
> >>>>>>> @@ -14,6 +14,7 @@
> >>>>>>>     #define KVM_HCALL_CODE_SERVICE         0
> >>>>>>>     #define KVM_HCALL_CODE_SWDBG           1
> >>>>>>>     #define KVM_HCALL_CODE_USER_SERVICE    2
> >>>>>>> +#define KVM_HCALL_CODE_CRASH           3
> >>>>>>>
> >>>>>>>     #define KVM_HCALL_SERVICE
> >>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SERVICE)
> >>>>>>>     #define  KVM_HCALL_FUNC_IPI            1
> >>>>>>> @@ -22,6 +23,7 @@
> >>>>>>>     #define KVM_HCALL_SWDBG
> >>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_SWDBG)
> >>>>>>>
> >>>>>>>     #define KVM_HCALL_USER_SERVICE
> >>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_USER_SERVICE)
> >>>>>>> +#define KVM_HCALL_CRASH
> >>>>>>> HYPERCALL_ENCODE(HYPERVISOR_KVM, KVM_HCALL_CODE_CRASH)
> >>>>>>>
> >>>>>>>     /*
> >>>>>>>      * LoongArch hypercall return code
> >>>>>>> @@ -161,6 +163,19 @@ static __always_inline long
> >>>>>>> kvm_hypercall5(u64 fid,
> >>>>>>>            return ret;
> >>>>>>>     }
> >>>>>>>
> >>>>>>> +static __always_inline long kvm_hypercall_crash(void)
> >>>>>>> +{
> >>>>>>> +       register long ret asm("a0");
> >>>>>>> +
> >>>>>>> +       __asm__ __volatile__(
> >>>>>>> +               "hvcl "__stringify(KVM_HCALL_CRASH)
> >>>>>>> +               : "=3Dr" (ret)
> >>>>>>> +               : : "memory"
> >>>>>>> +               );
> >>>>>>> +
> >>>>>>> +       return ret;
> >>>>>>> +}
> >>>>>> Why this function has no caller?
> >>>>> Currently we directly modify guest kernel and hard-code the hyperca=
ll
> >>>>> instruction to debug. This inline function is only example for howt=
o
> >>>>> usage, the normal usage such as checking KVM_FEATURE_USER_HCALL
> >>>>> feature
> >>>>> + kvm_hypercall_crash() is too complicated in exception entry assem=
ble
> >>>>> language.
> >>>> There are no examples for KVM_HCALL_SWDBG and KVM_HCALL_USER_SERVICE=
,
> >>>> I think KVM_HCALL_CRASH is no special.
> >>>>
> >>>> So if you agree, I will remove this example when applying.
> >>> Removinge the example usage with KVM_HCALL_CRASH is fine to me.
> >> Now all KVM patches for 7.4 is merged to loongarch-kvm. You can test
> >> it if you want.
> > Thanks. there is no problem from the code side, will test this in 7.4-
> > rc1 version.
> My bad. There is problem which is pointed out by sashiko-bot. I had
> thought I have sent v2 version already. Will send v2 soon.
The pull request has been merged.

Huacai

>
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index e5d10ceb5e67..9bf4b3bb8f25 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -164,6 +164,7 @@ static int kvm_vm_feature_has_attr(struct kvm *kvm,
> struct kvm_device_attr *attr
>          case KVM_LOONGARCH_VM_FEAT_PV_IPI:
>          case KVM_LOONGARCH_VM_FEAT_PV_PREEMPT:
>          case KVM_LOONGARCH_VM_FEAT_PV_STEALTIME:
> +       case KVM_LOONGARCH_VM_FEAT_CRASH:
>                  if (kvm_vm_support(&kvm->arch, attr->attr))
>                          return 0;
>                  return -ENXIO;
>
> Regards
> Bibo Mao
> >
> > Regards
> > bibo
> >>
> >>
> >> Huacai
> >>
> >>>
> >>> Regards
> >>> Bibo Mao
> >>>>
> >>>>
> >>>> Huacai
> >>>>
> >>>>>
> >>>>> Regards
> >>>>> Bibo Mao
> >>>>>>
> >>>>>>
> >>>>>> Huacai
> >>>>>>
> >>>>>>> +
> >>>>>>>     #ifdef CONFIG_PARAVIRT
> >>>>>>>     bool kvm_para_available(void);
> >>>>>>>     unsigned int kvm_arch_para_features(void);
> >>>>>>> diff --git a/arch/loongarch/include/uapi/asm/kvm.h
> >>>>>>> b/arch/loongarch/include/uapi/asm/kvm.h
> >>>>>>> index cd0b5c11ca9c..b222bfc48042 100644
> >>>>>>> --- a/arch/loongarch/include/uapi/asm/kvm.h
> >>>>>>> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> >>>>>>> @@ -106,6 +106,7 @@ struct kvm_fpu {
> >>>>>>>     #define  KVM_LOONGARCH_VM_FEAT_PTW             8
> >>>>>>>     #define  KVM_LOONGARCH_VM_FEAT_MSGINT          9
> >>>>>>>     #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT      10
> >>>>>>> +#define  KVM_LOONGARCH_VM_FEAT_CRASH           11
> >>>>>>>
> >>>>>>>     /* Device Control API on vcpu fd */
> >>>>>>>     #define KVM_LOONGARCH_VCPU_CPUCFG      0
> >>>>>>> diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h
> >>>>>>> b/arch/loongarch/include/uapi/asm/kvm_para.h
> >>>>>>> index d28cbcadd276..bf1a0c826ca6 100644
> >>>>>>> --- a/arch/loongarch/include/uapi/asm/kvm_para.h
> >>>>>>> +++ b/arch/loongarch/include/uapi/asm/kvm_para.h
> >>>>>>> @@ -16,6 +16,7 @@
> >>>>>>>     #define  KVM_FEATURE_IPI               1
> >>>>>>>     #define  KVM_FEATURE_STEAL_TIME                2
> >>>>>>>     #define  KVM_FEATURE_PREEMPT           3
> >>>>>>> +#define  KVM_FEATURE_CRASH             4
> >>>>>>>     /* BIT 24 - 31 are features configurable by user space vmm */
> >>>>>>>     #define  KVM_FEATURE_VIRT_EXTIOI       24
> >>>>>>>     #define  KVM_FEATURE_USER_HCALL                25
> >>>>>>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.=
c
> >>>>>>> index 4f58e6e2cf86..3b6daa946c76 100644
> >>>>>>> --- a/arch/loongarch/kvm/exit.c
> >>>>>>> +++ b/arch/loongarch/kvm/exit.c
> >>>>>>> @@ -911,6 +911,17 @@ static int kvm_handle_hypercall(struct
> >>>>>>> kvm_vcpu *vcpu, int ecode)
> >>>>>>>                    vcpu->run->hypercall.ret =3D
> >>>>>>> KVM_HCALL_INVALID_CODE;
> >>>>>>>                    ret =3D RESUME_HOST;
> >>>>>>>                    break;
> >>>>>>> +       case KVM_HCALL_CRASH:
> >>>>>>> +               if (!kvm_guest_has_pv_feature(vcpu,
> >>>>>>> KVM_FEATURE_CRASH)) {
> >>>>>>> +                       kvm_write_reg(vcpu, LOONGARCH_GPR_A0,
> >>>>>>> KVM_HCALL_INVALID_CODE);
> >>>>>>> +                       break;
> >>>>>>> +               }
> >>>>>>> +
> >>>>>>> +               vcpu->run->exit_reason =3D KVM_EXIT_SYSTEM_EVENT;
> >>>>>>> +               vcpu->run->system_event.type =3D
> >>>>>>> KVM_SYSTEM_EVENT_CRASH;
> >>>>>>> +               vcpu->run->system_event.ndata =3D 0;
> >>>>>>> +               ret =3D RESUME_HOST;
> >>>>>>> +               break;
> >>>>>>>            case KVM_HCALL_SWDBG:
> >>>>>>>                    /* KVM_HCALL_SWDBG only in effective when
> >>>>>>> SW_BP is enabled */
> >>>>>>>                    if (vcpu->guest_debug &
> >>>>>>> KVM_GUESTDBG_SW_BP_MASK) {
> >>>>>>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> >>>>>>> index 6dabb227a732..e5d10ceb5e67 100644
> >>>>>>> --- a/arch/loongarch/kvm/vm.c
> >>>>>>> +++ b/arch/loongarch/kvm/vm.c
> >>>>>>> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kv=
m)
> >>>>>>>                    kvm->arch.kvm_features |=3D
> >>>>>>> BIT(KVM_LOONGARCH_VM_FEAT_PMU);
> >>>>>>>
> >>>>>>>            /* Enable all PV features by default */
> >>>>>>> -       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI);
> >>>>>>> +       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI) |
> >>>>>>> BIT(KVM_FEATURE_CRASH);
> >>>>>>>            kvm->arch.kvm_features |=3D
> >>>>>>> BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
> >>>>>>> +       kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_CRA=
SH);
> >>>>>>>            if (kvm_pvtime_supported()) {
> >>>>>>>                    kvm->arch.pv_features |=3D
> >>>>>>> BIT(KVM_FEATURE_PREEMPT);
> >>>>>>>                    kvm->arch.pv_features |=3D
> >>>>>>> BIT(KVM_FEATURE_STEAL_TIME);
> >>>>>>>
> >>>>>>> base-commit: df2908090cda368b01ff43709f51890076c56157
> >>>>>>> --
> >>>>>>> 2.39.3
> >>>>>>>
> >>>>>>>
> >>>>>
> >>>
>
