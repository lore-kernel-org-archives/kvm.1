Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1713F8DE5
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528816; cv=none; b=pE7qTieSM5NWutHICM0M+vlZuZJdC4uXGYYSszpsMRBHOWsAAx33aBxiZZWZ5diG/5Ct2bdEnD9pJKqxIN4ZKESWbfyH606q301PnyPH5JQdqLlLHZ4v9kuD14At9Nbi7Cmcg2YBCpRVp7a18mpLa+7Bjb9Hv3gUZSboBqsEpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528816; c=relaxed/simple;
	bh=XdwLuOs+MOooUYSe+ks/VcJ4OJqU9KOmfrBBGbeAzf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3fVTo//lkUvlrw7vdWfFPSHh/mkr9oqSmsZ8Ly2ugRNaDpfhTzTA5txvD+E6T+KCOAkmpPfQuUMwnQjdiLBv+AgD7NSJvuq6xFxP4XYGs3tPW73cywZIX9TFVrqOkF1INBS7w6vRDo5c22DRd98xwsxRSQyd3BoJCJ/21xUDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE1dIbpR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE1dIbpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F93BC2BCB3
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774528816;
	bh=XdwLuOs+MOooUYSe+ks/VcJ4OJqU9KOmfrBBGbeAzf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mE1dIbpRP8k3il7XHOI3zIwSueN6/qnZtimTF08TLzeOpd+3hLj2eO+Ul9gFrGEv8
	 lIewo+Z1dncCPDDjtLASZUvUqqtJwEQypM41f77uVYlBbqeL/YLEM0NMMgImxaPMYE
	 /DSUCPFeBQMkp14vjJImlgwGDA9TSis6dtkmrT9GwEDMDPnFZ79t2XhxD49j/2kGbw
	 EJV+zxsvBsl5Qd0XhnxXWEpS2XgoMN0amQ5CuwfRRNyqQg1OSY5vfD4C8DmOacOEZa
	 dZXW+ZP5Ui4GUm1bcLEuj+l4TPVX1S4a6m7OKiLvrU4jtw/sT8Y4jKW+AUEzONNqPi
	 CJ4ajRRYnN8UA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-667f8794e97so1667897a12.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 05:40:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfV8kBHFuG9mHrIiq5nK9Kj/K12+x5hhRIH4YmTP8+1B1Ct3wcDjlAfNSieFw5oHB0oQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4AYnlsXUrhr+7uR1Czph8Rv3YsUFj+vrcO7x7G/OdAr50Z6IL
	zRyr/uXCJY6tj5VZEGw/KJG/BlVfGIKxBQt2L/HpfZ3kOE9VYFzVCQw3Ua/lAfXB9E64bFYKIKa
	22dF4zO19Wwa/UPwbYyXplPqhsV+ihxw=
X-Received: by 2002:a17:906:a2d8:b0:b98:4c58:f499 with SMTP id
 a640c23a62f3a-b9a54253a96mr407705266b.28.1774528814483; Thu, 26 Mar 2026
 05:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324091521.2338235-1-gaosong@loongson.cn> <20260324091521.2338235-3-gaosong@loongson.cn>
 <CAAhV-H7y8S6G+kh+qZ_q7Ug4JtzoGQ-ehUuA3uE63=gCpXyCGQ@mail.gmail.com> <ee4faccb-5a46-93a9-edcd-4c2544d614b3@loongson.cn>
In-Reply-To: <ee4faccb-5a46-93a9-edcd-4c2544d614b3@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Mar 2026 20:40:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H42ZD8jWq4QdEHcq31X0iHM8EwjWbSs8gobGMZ8YuGpyw@mail.gmail.com>
X-Gm-Features: AQROBzAfwfHNpsbS8OMB2muFvAZrxOGaKQcZlPdMsOvsr5CVDm6pWTxjiJe7fd0
Message-ID: <CAAhV-H42ZD8jWq4QdEHcq31X0iHM8EwjWbSs8gobGMZ8YuGpyw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] LoongArch: KVM: Add dmsintc inject msi to the dest vcpu
To: gaosong <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kernel@xen0n.name, linux-kernel@vger.kernel.org, lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:26=E2=80=AFPM gaosong <gaosong@loongson.cn> wrote=
:
>
> =E5=9C=A8 2026/3/26 =E4=B8=8B=E5=8D=883:52, Huacai Chen =E5=86=99=E9=81=
=93:
> > Hi, Song,
> >
> > I'm sorry but it seems there are still bugs...
> >
> > On Tue, Mar 24, 2026 at 5:41=E2=80=AFPM Song Gao <gaosong@loongson.cn> =
wrote:
> >> Implement irqfd deliver msi to vcpu and vcpu dmsintc inject irq.
> >> Add irqfd choice dmsintc to set msi irq by the msg_addr and
> >> implement dmsintc set msi irq.
> >>
> >> Signed-off-by: Song Gao <gaosong@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/kvm_dmsintc.h |  5 ++
> >>   arch/loongarch/include/asm/kvm_pch_pic.h |  4 +-
> >>   arch/loongarch/kvm/intc/dmsintc.c        | 73 ++++++++++++++++++++++=
++
> >>   arch/loongarch/kvm/intc/pch_pic.c        | 16 +++++-
> >>   arch/loongarch/kvm/interrupt.c           |  2 +
> >>   arch/loongarch/kvm/irqfd.c               | 11 ++--
> >>   6 files changed, 102 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch=
/include/asm/kvm_dmsintc.h
> >> index b04b89dd2a35..081ec8a7b874 100644
> >> --- a/arch/loongarch/include/asm/kvm_dmsintc.h
> >> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
> >> @@ -11,11 +11,16 @@ struct loongarch_dmsintc {
> >>          struct kvm *kvm;
> >>          uint64_t msg_addr_base;
> >>          uint64_t msg_addr_size;
> >> +       uint32_t cpu_mask;
> >>   };
> >>
> >>   struct dmsintc_state {
> >>          atomic64_t  vector_map[4];
> >>   };
> >>
> >> +void dmsintc_inject_irq(struct kvm_vcpu *vcpu);
> >> +int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm, struct kvm_vcpu *vcp=
u,
> >> +                               u32 vector, int level);
> >> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int =
level);
> > I think addr should be u64.
> Got it.
> >>   int kvm_loongarch_register_dmsintc_device(void);
> >>   #endif
> >> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch=
/include/asm/kvm_pch_pic.h
> >> index 7f33a3039272..5f49b1f82c56 100644
> >> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
> >> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
> >> @@ -70,6 +70,8 @@ struct loongarch_pch_pic {
> >>
> >>   int kvm_loongarch_register_pch_pic_device(void);
> >>   void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level=
);
> >> -void pch_msi_set_irq(struct kvm *kvm, int irq, int level);
> >> +struct kvm_kernel_irq_routing_entry;
> >> +int pch_msi_set_irq(struct kvm *kvm,
> >> +               struct kvm_kernel_irq_routing_entry *e, int level);
> >>
> >>   #endif /* __ASM_KVM_PCH_PIC_H */
> >> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/in=
tc/dmsintc.c
> >> index 1bb61e55d061..6837ccbb4473 100644
> >> --- a/arch/loongarch/kvm/intc/dmsintc.c
> >> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> >> @@ -4,9 +4,82 @@
> >>    */
> >>
> >>   #include <linux/kvm_host.h>
> >> +#include <asm/kvm_csr.h>
> >>   #include <asm/kvm_dmsintc.h>
> >>   #include <asm/kvm_vcpu.h>
> >>
> >> +int dmsintc_deliver_msi_to_vcpu(struct kvm *kvm,
> >> +                               struct kvm_vcpu *vcpu,
> >> +                               u32 vector, int level)
> >> +{
> >> +       struct kvm_interrupt vcpu_irq;
> >> +       struct dmsintc_state *ds;
> >> +
> >> +       if (!level)
> >> +               return 0;
> >> +       if (!vcpu || vector >=3D 256)
> >> +               return -EINVAL;
> >> +       ds =3D &vcpu->arch.dmsintc_state;
> >> +       if (!ds)
> >> +               return -ENODEV;
> >> +       set_bit(vector, (unsigned long *)&ds->vector_map);
> >> +       vcpu_irq.irq =3D INT_AVEC;
> >> +       kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
> >> +       kvm_vcpu_kick(vcpu);
> >> +       return 0;
> >> +}
> >> +
> >> +int kvm_dmsintc_set_msi_irq(struct kvm *kvm, u32 addr, int data, int =
level)
> > The kvm_ prefix can be removed.
> I will remove it.
> >> +{
> >> +       unsigned int virq, dest;
> >> +       struct kvm_vcpu *vcpu;
> >> +
> >> +       virq =3D (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
> >> +       dest =3D (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mas=
k;
> >> +       if (dest > KVM_MAX_VCPUS)
> > I think it should be "if (dest > KVM_MAX_VCPUS)".
> hmm.I'm not quite sure about here ,   or  ">=3D" ?
Yes, I mean it should be  ">=3D".

Huacai

> >> +               return -EINVAL;
> >> +       vcpu =3D kvm_get_vcpu_by_cpuid(kvm, dest);
> >> +       if (!vcpu)
> >> +               return -EINVAL;
> >> +       return dmsintc_deliver_msi_to_vcpu(kvm, vcpu, virq, level);
> >> +}
> >> +
> >> +void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
> >> +{
> >> +       struct dmsintc_state *ds =3D &vcpu->arch.dmsintc_state;
> >> +       unsigned int i;
> >> +       unsigned long temp[4], old;
> >> +
> >> +       if (!ds)
> >> +               return;
> >> +
> >> +       for (i =3D 0; i < 4; i++) {
> >> +               old =3D atomic64_read(&(ds->vector_map[i]));
> >> +               if (old)
> >> +                       temp[i] =3D atomic64_xchg(&(ds->vector_map[i])=
, 0);
> >> +       }
> >> +
> >> +       if (temp[0]) {
> >> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR0);
> >> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR0, temp[0]|old);
> >> +       }
> >> +
> >> +       if (temp[1]) {
> >> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR1);
> >> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR1, temp[1]|old);
> >> +       }
> >> +
> >> +       if (temp[2]) {
> >> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR2);
> >> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR2, temp[2]|old);
> >> +       }
> >> +
> >> +       if (temp[3]) {
> >> +               old =3D kvm_read_hw_gcsr(LOONGARCH_CSR_ISR3);
> >> +               kvm_write_hw_gcsr(LOONGARCH_CSR_ISR3, temp[3]|old);
> >> +       }
> >> +}
> >> +
> >>   static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
> >>                                  struct kvm_device_attr *attr,
> >>                                  bool is_write)
> >> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/in=
tc/pch_pic.c
> >> index dd7e7f8d53db..1c0ed0665736 100644
> >> --- a/arch/loongarch/kvm/intc/pch_pic.c
> >> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> >> @@ -4,6 +4,7 @@
> >>    */
> >>
> >>   #include <asm/kvm_eiointc.h>
> >> +#include <asm/kvm_dmsintc.h>
> >>   #include <asm/kvm_pch_pic.h>
> >>   #include <asm/kvm_vcpu.h>
> >>   #include <linux/count_zeros.h>
> >> @@ -67,9 +68,20 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, i=
nt irq, int level)
> >>   }
> >>
> >>   /* msi irq handler */
> >> -void pch_msi_set_irq(struct kvm *kvm, int irq, int level)
> >> +int pch_msi_set_irq(struct kvm *kvm,
> >> +               struct kvm_kernel_irq_routing_entry *e, int level)
> >>   {
> >> -       eiointc_set_irq(kvm->arch.eiointc, irq, level);
> >> +       u64 msg_addr;
> >> +
> >> +       msg_addr =3D (((u64)e->msi.address_hi) << 32) | e->msi.address=
_lo;
> > Define and evaluate at the same time.
> >
> Got it .
>
> Thanks.
> Song Gao
> > Huacai
> >
> >> +       if (cpu_has_msgint && kvm->arch.dmsintc &&
> >> +               msg_addr >=3D kvm->arch.dmsintc->msg_addr_base &&
> >> +               msg_addr < (kvm->arch.dmsintc->msg_addr_base  + kvm->a=
rch.dmsintc->msg_addr_size)) {
> >> +               return kvm_dmsintc_set_msi_irq(kvm, msg_addr, e->msi.d=
ata, level);
> >> +       }
> >> +
> >> +       eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
> >> +       return 0;
> >>   }
> >>
> >>   static int loongarch_pch_pic_read(struct loongarch_pch_pic *s, gpa_t=
 addr, int len, void *val)
> >> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/inter=
rupt.c
> >> index fb704f4c8ac5..32930959f7c2 100644
> >> --- a/arch/loongarch/kvm/interrupt.c
> >> +++ b/arch/loongarch/kvm/interrupt.c
> >> @@ -7,6 +7,7 @@
> >>   #include <linux/errno.h>
> >>   #include <asm/kvm_csr.h>
> >>   #include <asm/kvm_vcpu.h>
> >> +#include <asm/kvm_dmsintc.h>
> >>
> >>   static unsigned int priority_to_irq[EXCCODE_INT_NUM] =3D {
> >>          [INT_TI]        =3D CPU_TIMER,
> >> @@ -33,6 +34,7 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, un=
signed int priority)
> >>                  irq =3D priority_to_irq[priority];
> >>
> >>          if (kvm_guest_has_msgint(&vcpu->arch) && (priority =3D=3D INT=
_AVEC)) {
> >> +               dmsintc_inject_irq(vcpu);
> >>                  set_gcsr_estat(irq);
> >>                  return 1;
> >>          }
> >> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> >> index 9a39627aecf0..308ef08b634c 100644
> >> --- a/arch/loongarch/kvm/irqfd.c
> >> +++ b/arch/loongarch/kvm/irqfd.c
> >> @@ -28,10 +28,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry=
 *e,
> >>   {
> >>          if (!level)
> >>                  return -1;
> >> -
> >> -       pch_msi_set_irq(kvm, e->msi.data, level);
> >> -
> >> -       return 0;
> >> +       return pch_msi_set_irq(kvm, e, level);
> >>   }
> >>
> >>   /*
> >> @@ -71,13 +68,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
> >>   int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e=
,
> >>                  struct kvm *kvm, int irq_source_id, int level, bool l=
ine_status)
> >>   {
> >> +       if (!level)
> >> +               return -EWOULDBLOCK;
> >> +
> >>          switch (e->type) {
> >>          case KVM_IRQ_ROUTING_IRQCHIP:
> >>                  pch_pic_set_irq(kvm->arch.pch_pic, e->irqchip.pin, le=
vel);
> >>                  return 0;
> >>          case KVM_IRQ_ROUTING_MSI:
> >> -               pch_msi_set_irq(kvm, e->msi.data, level);
> >> -               return 0;
> >> +               return pch_msi_set_irq(kvm, e, level);
> >>          default:
> >>                  return -EWOULDBLOCK;
> >>          }
> >> --
> >> 2.39.3
> >>
> >>
>
>
