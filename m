Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD03D3339
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924534; cv=none; b=bwqqWVmRcuqtAnSlTBtyvv5aYsYb51d7SZqchHm4YTn8+AN1YIQteyLiGLs+cSmdvJPrLNWHmZpNEhqqQ/WkLejklkK1kA+q4BQuriv+pWpTswx5RyebR5Vcy0CIARt5OZHPkvRfdzkDLtX7t3ZIyWYO/Q9mi663FHJgu+cZGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924534; c=relaxed/simple;
	bh=1y9g5qLBTxvzrCGzDqg/MwRo1XJNaHN1tYT9TtlPq1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srBrtEspVw471nP9r5NWrELuiTPoDD0bTUXFKs09hmc1xa9srRvu2n9CF4BqWtnx9XWNZ2YFGef7jvIdJVGe1u0yO1qnpfxMF8/OGiqs1mE0QokCDjjg04ZNMeKgDbnWgYetAg3KMGdNt2IQmuYeoPNxEEDmt9lZD7ZpD5iwdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQjJRAmH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQjJRAmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9188C2BCB0
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924533;
	bh=1y9g5qLBTxvzrCGzDqg/MwRo1XJNaHN1tYT9TtlPq1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RQjJRAmHlMbhsXzEGReOjeAgEb2ZNWIKtZTR+abQQaPL4qMHmFuXTBJtDy2S9X3Ek
	 FVibF2JfxfKtCS6usHTcXOkEZN4Vy+/YaBvpMK8RFVgAwel1ypVSlNEhpEqLSBw3nz
	 UX71Vpu9CNfF7PuoAehhyLYc5gYp9dYMRfJRdeqyBhwwMk+o2li/myVn38TosqBZtW
	 +nd6r6VmXCJSBnO+qtdpPcSdpyCy2BYKGH58pmG/wFW+6CB0ElJDvi3rcXaU7mlBRD
	 NKYk2B6pKgWUB83QnFH25FzmJlZ5nXw5jbnsaiH9oNkJHuZD6O8dhCLjzdAWqxC7Az
	 6WnmpGUiNvzBQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b982518b73fso62252166b.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 05:48:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiCruJ9KD5ufpUrPwWmdoEmAjIwOAqLJVK2JBIBMUWiij6oBAkT3i/HXEX0L+vt36imOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMIMePBnsEfwz/mwIhR8LYEruPnDD7v+mR+jd7w5ydeSIm6omR
	/mVsBdopJDmBU59TSvkPjHMGSq9wp/9uFKtvJeOVthVPoqReS0yVVlt6xqxMbdhWkOEr/sem0vJ
	AWvLObe7YucnNk//szHSvuZnQ56p6vug=
X-Received: by 2002:a17:907:2da7:b0:b90:e278:a09a with SMTP id
 a640c23a62f3a-b97f4a4d4dcmr549092266b.55.1773924532141; Thu, 19 Mar 2026
 05:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311085059.1040263-1-gaosong@loongson.cn> <20260311085059.1040263-3-gaosong@loongson.cn>
In-Reply-To: <20260311085059.1040263-3-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Mar 2026 20:48:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4DbH4M--eaozv5LpOxHFWKQnGPeMqvLWz6gKZC2yWDLA@mail.gmail.com>
X-Gm-Features: AaiRm50W0GQ7l2H0zC2B3uvYWadSVlqwF8RPL8n6xbuAn5bMLN_3Fr7U1baiyUE
Message-ID: <CAAhV-H4DbH4M--eaozv5LpOxHFWKQnGPeMqvLWz6gKZC2yWDLA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] LoongArch: KVM: Add dmsintc inject msi to the dest vcpu
To: Song Gao <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	kernel@xen0n.name, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Song,

On Wed, Mar 11, 2026 at 5:16=E2=80=AFPM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> Implement irqfd deliver msi to vcpu and vcpu dmsintc inject irq.
> Add irqfd choice dmsintc to set msi irq by the msg_addr and
> implement dmsintc set msi irq.
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_dmsintc.h |  2 +
>  arch/loongarch/include/asm/kvm_pch_pic.h |  4 +-
>  arch/loongarch/kvm/intc/pch_pic.c        | 16 +++++++-
>  arch/loongarch/kvm/interrupt.c           | 37 ++++++++++++++++++
>  arch/loongarch/kvm/irqfd.c               | 48 +++++++++++++++++++++---
>  5 files changed, 98 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/in=
clude/asm/kvm_dmsintc.h
> index b04b89dd2a35..7046c66cac93 100644
> --- a/arch/loongarch/include/asm/kvm_dmsintc.h
> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
> @@ -11,11 +11,13 @@ struct loongarch_dmsintc {
>         struct kvm *kvm;
>         uint64_t msg_addr_base;
>         uint64_t msg_addr_size;
> +       uint32_t cpu_mask;
>  };
>
>  struct dmsintc_state {
>         atomic64_t  vector_map[4];
>  };
>
> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int lev=
el);
>  int kvm_loongarch_register_dmsintc_device(void);
>  #endif
> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/in=
clude/asm/kvm_pch_pic.h
> index 7f33a3039272..5f49b1f82c56 100644
> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
> @@ -70,6 +70,8 @@ struct loongarch_pch_pic {
>
>  int kvm_loongarch_register_pch_pic_device(void);
>  void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level);
> -void pch_msi_set_irq(struct kvm *kvm, int irq, int level);
> +struct kvm_kernel_irq_routing_entry;
> +int pch_msi_set_irq(struct kvm *kvm,
> +               struct kvm_kernel_irq_routing_entry *e, int level);
>
>  #endif /* __ASM_KVM_PCH_PIC_H */
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index dd7e7f8d53db..1c0ed0665736 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <asm/kvm_eiointc.h>
> +#include <asm/kvm_dmsintc.h>
>  #include <asm/kvm_pch_pic.h>
>  #include <asm/kvm_vcpu.h>
>  #include <linux/count_zeros.h>
> @@ -67,9 +68,20 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int =
irq, int level)
>  }
>
>  /* msi irq handler */
> -void pch_msi_set_irq(struct kvm *kvm, int irq, int level)
> +int pch_msi_set_irq(struct kvm *kvm,
> +               struct kvm_kernel_irq_routing_entry *e, int level)
>  {
> -       eiointc_set_irq(kvm->arch.eiointc, irq, level);
> +       u64 msg_addr;
> +
> +       msg_addr =3D (((u64)e->msi.address_hi) << 32) | e->msi.address_lo=
;
> +       if (cpu_has_msgint && kvm->arch.dmsintc &&
> +               msg_addr >=3D kvm->arch.dmsintc->msg_addr_base &&
> +               msg_addr < (kvm->arch.dmsintc->msg_addr_base  + kvm->arch=
.dmsintc->msg_addr_size)) {
> +               return kvm_dmsintc_set_msi_irq(kvm, msg_addr, e->msi.data=
, level);
> +       }
> +
> +       eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
> +       return 0;
>  }
>
>  static int loongarch_pch_pic_read(struct loongarch_pch_pic *s, gpa_t add=
r, int len, void *val)
> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrup=
t.c
> index fb704f4c8ac5..76a133adedc2 100644
> --- a/arch/loongarch/kvm/interrupt.c
> +++ b/arch/loongarch/kvm/interrupt.c
> @@ -8,6 +8,42 @@
>  #include <asm/kvm_csr.h>
>  #include <asm/kvm_vcpu.h>
>
> +static void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
> +{
> +       struct dmsintc_state *ds =3D &vcpu->arch.dmsintc_state;
> +       unsigned int i;
> +       unsigned long temp[4], old;
> +
> +       if (!ds)
> +               return;
> +
> +       for (i =3D 0; i < 4; i++) {
> +               old =3D atomic64_read(&(ds->vector_map[i]));
> +               if (old)
> +                       temp[i] =3D atomic64_xchg(&(ds->vector_map[i]), 0=
);
> +       }
> +
> +       if (temp[0]) {
> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, temp[0]|old);
> +       }
> +
> +       if (temp[1]) {
> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR1);
> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR1, temp[1]|old);
> +       }
> +
> +       if (temp[2]) {
> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR2);
> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR2, temp[2]|old);
> +       }
> +
> +       if (temp[3]) {
> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR3);
> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR3, temp[3]|old);
> +       }
> +}
Thank you for your rework, but after rework dmsintc_inject_irq(),
dmsintc_deliver_msi_to_vcpu() and dmsintc_set_msi_irq() should be in
dmsintc.c now.


Huacai

> +
>  static unsigned int priority_to_irq[EXCCODE_INT_NUM] =3D {
>         [INT_TI]        =3D CPU_TIMER,
>         [INT_IPI]       =3D CPU_IPI,
> @@ -33,6 +69,7 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsig=
ned int priority)
>                 irq =3D priority_to_irq[priority];
>
>         if (kvm_guest_has_msgint(&vcpu->arch) && (priority =3D=3D INT_AVE=
C)) {
> +               dmsintc_inject_irq(vcpu);
>                 set_gcsr_estat(irq);
>                 return 1;
>         }
> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index 9a39627aecf0..4788705ddf9f 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -6,6 +6,28 @@
>  #include <linux/kvm_host.h>
>  #include <trace/events/kvm.h>
>  #include <asm/kvm_pch_pic.h>
> +#include <asm/kvm_vcpu.h>
> +
> +static int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
> +                               struct kvm_vcpu *vcpu,
> +                               u32 vector, int level)
> +{
> +       struct kvm_interrupt vcpu_irq;
> +       struct dmsintc_state *ds;
> +
> +       if (!level)
> +               return 0;
> +       if (!vcpu || vector >=3D 256)
> +               return -EINVAL;
> +       ds =3D &vcpu->arch.dmsintc_state;
> +       if (!ds)
> +               return -ENODEV;
> +       set_bit(vector, (unsigned long *)&ds->vector_map);
> +       vcpu_irq.irq =3D INT_AVEC;
> +       kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
> +       kvm_vcpu_kick(vcpu);
> +       return 0;
> +}
>
>  static int kvm_set_pic_irq(struct kvm_kernel_irq_routing_entry *e,
>                 struct kvm *kvm, int irq_source_id, int level, bool line_=
status)
> @@ -16,6 +38,21 @@ static int kvm_set_pic_irq(struct kvm_kernel_irq_routi=
ng_entry *e,
>         return 0;
>  }
>
> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int lev=
el)
> +{
> +       unsigned int virq, dest;
> +       struct kvm_vcpu *vcpu;
> +
> +       virq =3D (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
> +       dest =3D (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
> +       if (dest > KVM_MAX_VCPUS)
> +               return -EINVAL;
> +       vcpu =3D kvm_get_vcpu_by_cpuid(kvm, dest);
> +       if (!vcpu)
> +               return -EINVAL;
> +       return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, virq, level);
> +}
> +
>  /*
>   * kvm_set_msi: inject the MSI corresponding to the
>   * MSI routing entry
> @@ -28,10 +65,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e=
,
>  {
>         if (!level)
>                 return -1;
> -
> -       pch_msi_set_irq(kvm, e->msi.data, level);
> -
> -       return 0;
> +       return pch_msi_set_irq(kvm, e, level);
>  }
>
>  /*
> @@ -71,13 +105,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
>  int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
>                 struct kvm *kvm, int irq_source_id, int level, bool line_=
status)
>  {
> +       if (!level)
> +               return -EWOULDBLOCK;
> +
>         switch (e->type) {
>         case KVM_IRQ_ROUTING_IRQCHIP:
>                 pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, level)=
;
>                 return 0;
>         case KVM_IRQ_ROUTING_MSI:
> -               pch_msi_set_irq(kvm, e->msi.data, level);
> -               return 0;
> +               return pch_msi_set_irq(kvm, e, level);
>         default:
>                 return -EWOULDBLOCK;
>         }
> --
> 2.39.3
>
