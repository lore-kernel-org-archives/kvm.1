Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627872494D8
	for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827389; cv=none; b=mKbMoTn+5gSTfl8w9bNJ7/CSq683LXlfu9fmnll2101prGEQyh6vQ24mXjMhiCdsqsQ3rfyOqy4oBKD+AeUhP8rBjxfFhs2dlF51jzqJ8BMI20V+9cI272I51kzWaz8JjcxX6vtFAXfGy9CueS5M6q4nhSmqM3DsPh8Ar2gezIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827389; c=relaxed/simple;
	bh=u0WYsRXHNIjxUbP7kdzC3rZVDeQ2w0U45FdhSkNfSCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHnnB6uMU/nX+kwMiTYAQQUlptKCm+TQHViLWafAukGSsOL5SqHh2lHQ3ObFjn1rVi0+uminZrpuUvCoVN/24fNJg52/vClha9T5I4aroBvUF+nDxlvaeY9Alm6GfK4vtZtOobOA1sde+Iskb0C8DnjF2lhqr9Py3qid+pgDrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE3EB2yb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE3EB2yb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496411F00899
	for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789827388;
	bh=wC0IgvticFlMQ9Kl5TlBgRX/UoFk4VfI9ix50lxCtoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HE3EB2yb8qtW6gupLLMdMCXOc9H+ol5a9Uqcshc+g5eWawcEGNc+/MJoEo5HNBDno
	 R4jNtl+QVOkwjufNHLjdPxoZvBIb9qfku3aZ3I8bZAKar+txyM+SoUU1erLzEFwtLv
	 l+B2z8gAUk11xhW7aBXEESSPp+l0Jgh9bzwdyQHi3HnhQWnyd+kHGbdDti307ak8Vi
	 LPvPVxcYBK6iM28EPqIjrL/r+qhTUXpbSwvt4HtraJ+EYhVz7r5WpIdNJtos/llemJ
	 +67MEkLA3L1au3ayBm/LSbjtquqaVeLDrbMxJ/naFp+noJYIrE3rzfr7gF7lELlRcj
	 DaeVlS33kTnKg==
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso2862173a12.1
        for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 07:16:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzcJbPHiQHtFuZVfGh1dC94trA2aEcMpGxgAW9IW73NbakfbsuHAW/OQ+c4Pj8d6ZoU2No=@vger.kernel.org
X-Gm-Message-State: AFuF++nfE/z0wJjOLvIXO5iraiQdFEA5fcnVo5nDaFODqVq7SddQECvA
	Xw/FDMiBCzs+bjMpyWHh7pe/BWgdRvZYiFGMD3P0QYqmutNHSHWCmRjxmva+5lg8mvn9Cgsep/7
	HPcPIKqky1FCSBRnQrWvuqrxj1QnURo4=
X-Received: by 2002:a05:6402:2491:b0:6a7:ea54:383 with SMTP id
 4fb4d7f45d1cf-6aa53cf475fmr4340769a12.43.1789827386866; Sat, 19 Sep 2026
 07:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909083259.1910290-1-maobibo@loongson.cn> <20260909083259.1910290-2-maobibo@loongson.cn>
In-Reply-To: <20260909083259.1910290-2-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 19 Sep 2026 22:16:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59b2PJjJ3rGGQj1hhyK0-ustqNSzk=iaFd28-xtM8FDw@mail.gmail.com>
X-Gm-Features: AcwNN1UAURjFrjmT8YfxOIF2kRm69-YnqAUYwmK_ukFqbBRUWf37AYs_SLF3McQ
Message-ID: <CAAhV-H59b2PJjJ3rGGQj1hhyK0-ustqNSzk=iaFd28-xtM8FDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: KVM: Remove parameter line when inject MSI
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Wed, Sep 9, 2026 at 4:40=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> With MSI interrupt, there is intterupt set injection, no interrupt
> clear action. DMSI interrupt controller is specially for MSI irqchip.
> And there is checking with parameter level in most upper function
> kvm_set_msi() and kvm_arch_set_irq_inatomic() already, here remove
> duplicated line parameter checking in MSI injection leaf functions.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_dmsintc.h | 3 +--
>  arch/loongarch/include/asm/kvm_pch_pic.h | 2 +-
>  arch/loongarch/kvm/intc/dmsintc.c        | 9 +++------
>  arch/loongarch/kvm/intc/pch_pic.c        | 6 +++---
>  arch/loongarch/kvm/irqfd.c               | 6 +++---
>  5 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/in=
clude/asm/kvm_dmsintc.h
> index 7c0158764d84..e19b3f5b3c52 100644
> --- a/arch/loongarch/include/asm/kvm_dmsintc.h
> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
> @@ -22,7 +22,6 @@ struct dmsintc_state {
>  int kvm_loongarch_register_dmsintc_device(void);
>  void kvm_loongarch_unregister_dmsintc_device(void);
>  void dmsintc_inject_irq(struct kvm_vcpu *vcpu);
> -int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level);
> -int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm, struct kvm_vcpu *vcpu, =
u32 vector, int level);
> +int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data);
>
>  #endif
> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/in=
clude/asm/kvm_pch_pic.h
> index 887b0431fd20..19ed1494c114 100644
> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
> @@ -72,6 +72,6 @@ struct kvm_kernel_irq_routing_entry;
>  int kvm_loongarch_register_pch_pic_device(void);
>  void kvm_loongarch_unregister_pch_pic_device(void);
>  void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level);
> -int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry=
 *e, int level);
> +int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry=
 *e);
>
>  #endif /* __ASM_KVM_PCH_PIC_H */
> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index 89f980d867be..79e56e330aeb 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -43,13 +43,10 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
>         }
>  }
>
> -int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
> -                               struct kvm_vcpu *vcpu, u32 vector, int le=
vel)
> +static int dmsintc_deliver_msi_to_vcpu(struct kvm_vcpu *vcpu, u32 vector=
)
>  {
>         struct dmsintc_state *ds =3D &vcpu->arch.dmsintc_state;
>
> -       if (!level)
> -               return 0;
>         if (!vcpu || vector >=3D 256)
>                 return -EINVAL;
>         if (!ds)
> @@ -65,7 +62,7 @@ int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
>         return 0;
>  }
>
> -int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
> +int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data)
>  {
>         unsigned int irq, cpu;
>         struct kvm_vcpu *vcpu;
> @@ -78,7 +75,7 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data=
, int level)
>         if (!vcpu)
>                 return -EINVAL;
>
> -       return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, irq, level);
> +       return dmsintc_deliver_msi_to_vcpu(vcpu, irq);
>  }
>
>  static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index 2b63b0c2c7ce..220fc23ffe8c 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -68,20 +68,20 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int=
 irq, int level)
>  }
>
>  /* msi irq handler */
> -int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry=
 *e, int level)
> +int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry=
 *e)
>  {
>         u64 msg_addr =3D (((u64)e->msi.address_hi) << 32) | e->msi.addres=
s_lo;
>
>         if (cpu_has_msgint && kvm->arch.dmsintc &&
>                 msg_addr >=3D kvm->arch.dmsintc->msg_addr_base &&
>                 msg_addr < (kvm->arch.dmsintc->msg_addr_base + kvm->arch.=
dmsintc->msg_addr_size)) {
> -               return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level)=
;
> +               return dmsintc_set_irq(kvm, msg_addr, e->msi.data);
>         }
>
>         if (e->msi.data >=3D EIOINTC_IRQS)
>                 return -EINVAL;
>
> -       eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
> +       eiointc_set_irq(kvm->arch.eiointc, e->msi.data, 1);
>
>         return 0;
>  }
> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index 40ed1081c4b6..686097ca5906 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -27,9 +27,9 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>                 struct kvm *kvm, int irq_source_id, int level, bool line_=
status)
>  {
>         if (!level)
> -               return -1;
> +               return -EINVAL;
>
> -       return pch_msi_set_irq(kvm, e, level);
> +       return pch_msi_set_irq(kvm, e);
>  }
>
>  /*
> @@ -78,7 +78,7 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_rou=
ting_entry *e,
>                 pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level)=
;
>                 return 0;
>         case KVM_IRQ_ROUTING_MSI:
> -               return pch_msi_set_irq(kvm, e, level);
> +               return pch_msi_set_irq(kvm, e);
Please also consider the KVM_IRQ_ROUTING_IRQCHIP case. If
pch_pic_set_irq() also doesn't need level, please remove it; if
pch_pic_set_irq() needs level, please move the checking from head to
the KVM_IRQ_ROUTING_MSI case.


Huacai

>         default:
>                 return -EWOULDBLOCK;
>         }
> --
> 2.39.3
>
