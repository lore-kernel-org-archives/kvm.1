Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F4175A9D
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125161; cv=none; b=Pthb0AVxg3YzwE7WSP1Hqw5zXOZaupck4OZkLL8RQCkUWsfrKlkYKWOU1NajmXsbcxCWZbLXD8IyR6SLvrWVuuttJMbvSl8AseM23T6G0+A9hAOeOxeir6LVNSuHekT1CNWj8NHWaOgXIIaxc4OfJf075dhjCMnlBwN3TzvdjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125161; c=relaxed/simple;
	bh=8gm/xNZWj137jI+WyVOXD+1H8KjiETwaRv2YAJq9JfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCBRjQT5lTJvXZjm/utAIJOOl5DMEDt1Q29Cs+zDYPvSidhIbBtjpxqaG2Tlak+EXlO+eDhkvLeeLrOoG0qvLNsWOtEG1Ph2ntqKlWAmyFKGrEvJa58caacJFbjIHK8XaccA8OB3MayuPx8Wzf4odxpQhbId0KuQ17J9Nt78syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Giwr7aVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Giwr7aVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7401F000CC
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792125160;
	bh=PwbK8SYC1ZEQNlvUhIXmwaU5JC4Zh216Jdo1LscWnaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Giwr7aVvCCIqRiKBMocWFz+zWWtrBdThRhVd3gqi/oxGOED2xeXbwq1LYNFEyOCdU
	 QO+aH3Ug7WJBLGYSsL0FL+/HiphbdjKFiWJzWg11rduHVn8o6y1tDSwuXccmbyDOYU
	 IcMBA3n8M3J2t5uhPEQ/3uFrTGgMmGQST53o12AVyHubZOlGWq80t0Yz2KCt+ri6Ma
	 uldrttxoL3zu18FfbcMVemfqn5QGYGE3oxJ6sqPIl56wrzk17N3FqpaMiFg9siCJNq
	 /cWIRfszgNrBF54DPHD+V/OLhGMXYNjsc9U2JA/mDIT7TB6oOnOr0Nve7ce4dkKl2d
	 GjfxEIekhquNQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so5781743a12.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:32:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByVwBprohMT0TxS2RdhxDVd4nLAz+LFDtgk+SSDttttOzv/PRNBn0w+JKGncXlTPZwH0OA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJR+AyszoPo7/HOzCdguZoBmJLKxcaOheDweEoSadxqnghUKlgx
	0SFttq8fcfLrZTagRqp4Az601+seMAFA3iKufZNSjwfT5Qh051y+wk67aQAljX294Jf8ENTrJY6
	SOKX9qJbUJAnaztXr6f4Uwo30Ba9TXe8=
X-Received: by 2002:a05:6402:518d:b0:6af:f8c6:7859 with SMTP id
 4fb4d7f45d1cf-6b17c28bef2mr16575301a12.41.1792125158583; Thu, 15 Oct 2026
 21:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016034245.3002859-1-maobibo@loongson.cn>
In-Reply-To: <20261016034245.3002859-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 16 Oct 2026 12:32:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7JeBurcvmqPm1icKvSmGTnTP9HifRhdz6PqLhhtkcYKg@mail.gmail.com>
X-Gm-Features: AclHuK_0-kUlwX9AwZ0OMfgXWPPvZPXghZa1NQsl1lZ94Ri2oskyrrYkZQRP2pQ
Message-ID: <CAAhV-H7JeBurcvmqPm1icKvSmGTnTP9HifRhdz6PqLhhtkcYKg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Add hypercall crash support
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

V1 in the pull-request has been merged.

Huacai

On Fri, Oct 16, 2026 at 11:43=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
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
>   v1 ... v2:
>   1. Add VM feature checking with KVM_LOONGARCH_VM_FEAT_CRASH from VMM
>      user space.
> ---
>  arch/loongarch/include/asm/kvm_host.h      |  1 +
>  arch/loongarch/include/asm/kvm_para.h      | 15 +++++++++++++++
>  arch/loongarch/include/uapi/asm/kvm.h      |  1 +
>  arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
>  arch/loongarch/kvm/exit.c                  | 11 +++++++++++
>  arch/loongarch/kvm/vm.c                    |  4 +++-
>  6 files changed, 32 insertions(+), 1 deletion(-)
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
> index 6dabb227a732..9bf4b3bb8f25 100644
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
> @@ -163,6 +164,7 @@ static int kvm_vm_feature_has_attr(struct kvm *kvm, s=
truct kvm_device_attr *attr
>         case KVM_LOONGARCH_VM_FEAT_PV_IPI:
>         case KVM_LOONGARCH_VM_FEAT_PV_PREEMPT:
>         case KVM_LOONGARCH_VM_FEAT_PV_STEALTIME:
> +       case KVM_LOONGARCH_VM_FEAT_CRASH:
>                 if (kvm_vm_support(&kvm->arch, attr->attr))
>                         return 0;
>                 return -ENXIO;
>
> base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
> --
> 2.39.3
>
