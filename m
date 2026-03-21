Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01633F58C
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774065843; cv=none; b=QBp5c5tmNjlEo+rQ8UgNJtc1WkeT3sHzTgliXochQaIhV27zuRvPhRqlzdnYoLgse8y47Gno2GGUmhz5A8G0ca4+Up8odyczjwmr9rbOU+IdAQxe5XsrY0bM++RqXiComhO+ZB1tvjHDgrJs4H41/iPD0/hr7Vv2C+v3vWeB4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774065843; c=relaxed/simple;
	bh=b0yWP+jnQnggXLjaOAGZ5V0IjIcjL9QFW/0n5H1Mt2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVL3glfpqIrkn5Yoh0OMfF5LWRIwb7C0Lug6zLwcSaFoRJJiJ6do/OzMG5X/SyNfgNEwZ7eG8e0YhVNYdy6c7xnGv9kNcfYHvncA61SWwfFUMyg0DOuKGT3ufkYRxoF4U1X1IZ1phIn3uE/aTcMno3g60EGptidh371sFaEg9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJv0QG45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJv0QG45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3799C2BCB2
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 04:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774065842;
	bh=b0yWP+jnQnggXLjaOAGZ5V0IjIcjL9QFW/0n5H1Mt2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pJv0QG45CoUGa3E6Wc5cgBGejLWfXdpjuu7Zl8/KtTzeeBAhEOctqTUiRPKNUwT9P
	 nqwo67CrqRWSXhXaSG/5TfwJf4ixF6hDvz+YCJfldRJoUGoNgZ62mTiv8RzRjJqKSY
	 CTtMAKLsKfUlj+dVDfl+aWYZOIll11No6uYKITLceuc24KJWr0LaT3XMLpCqmuVZWA
	 OP2tY14DUwuAX/85BoxR465fVDMVG0WgQfeSdBhMbYDpbje+6mRZrDeZCNtKH2rQo8
	 YgF755N+n89g38JhJlu4EEU8ei2z2+out5wJV0RNYbmio+Tvi9r5PbEIgeCOdw3gOj
	 GN1JKudn4HZUQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-667acaeae82so3857934a12.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 21:04:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNBxdr6Bb2awnZ/mirUTmsTkFogoWRqrsl5JYrBxJXKXJpJdvKsIQ6XGdT6xN+g0RnZMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKK5nOZ7eC168V1JcoVN8hKTv+0AE2Q9be1xNC0vIiyMjcOtqW
	gforWG7Q1T0bLrgAp7KXe3RmRspzcXnN91+H3q5A3lIlwbFGdfnvrDm61ugSi2LNF+jGWfcIOt6
	v8ZwlFUy+mb62JG4E1vK1xa01yyyYmYE=
X-Received: by 2002:a17:907:1604:b0:b98:1b18:7840 with SMTP id
 a640c23a62f3a-b982f0bae96mr409044766b.11.1774065841135; Fri, 20 Mar 2026
 21:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311085059.1040263-1-gaosong@loongson.cn> <20260311085059.1040263-2-gaosong@loongson.cn>
 <CAAhV-H4WZj3LmghXxXY1hNUjEmihx1fjggOZLNRRDS5PN2s0kg@mail.gmail.com> <43459637-6aba-c31d-5840-ee4675712e0a@loongson.cn>
In-Reply-To: <43459637-6aba-c31d-5840-ee4675712e0a@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 21 Mar 2026 12:03:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7j=QgcQOOfduOFo_TSbij_aN+ZVbDwF-5PDb7qfLiQaA@mail.gmail.com>
X-Gm-Features: AaiRm51BhjkYUIx9Vk2lxK3LiKXx6LBouLb9aAaGHqJIjIvdNEODvNdKbah9EiQ
Message-ID: <CAAhV-H7j=QgcQOOfduOFo_TSbij_aN+ZVbDwF-5PDb7qfLiQaA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] LoongArch: KVM: Add DMSINTC device support
To: gaosong <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	kernel@xen0n.name, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 3:27=E2=80=AFPM gaosong <gaosong@loongson.cn> wrote=
:
>
> Hi Huacai,
>
> Thank you for your review and the insightful question.
>
>
> =E5=9C=A8 2026/3/19 =E4=B8=8B=E5=8D=888:48, Huacai Chen =E5=86=99=E9=81=
=93:
> > Hi, Song,
> >
> > On Wed, Mar 11, 2026 at 5:16=E2=80=AFPM Song Gao <gaosong@loongson.cn> =
wrote:
> >> Add device model for DMSINTC interrupt controller, implement basic
> >> create/destroy/set_attr interfaces, and register device model to kvm
> >> device table.
> >>
> >> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> >> Signed-off-by: Song Gao <gaosong@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/kvm_dmsintc.h |  21 ++++
> >>   arch/loongarch/include/asm/kvm_host.h    |   3 +
> >>   arch/loongarch/include/uapi/asm/kvm.h    |   4 +
> >>   arch/loongarch/kvm/Makefile              |   1 +
> >>   arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++=
++
> >>   arch/loongarch/kvm/main.c                |   6 ++
> >>   include/uapi/linux/kvm.h                 |   2 +
> >>   7 files changed, 154 insertions(+)
> >>   create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
> >>   create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
> >>
> >> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch=
/include/asm/kvm_dmsintc.h
> >> new file mode 100644
> >> index 000000000000..b04b89dd2a35
> >> --- /dev/null
> >> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
> >> @@ -0,0 +1,21 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2025 Loongson Technology Corporation Limited
> >> + */
> >> +
> >> +#ifndef __ASM_KVM_DMSINTC_H
> >> +#define __ASM_KVM_DMSINTC_H
> >> +
> >> +
> >> +struct loongarch_dmsintc {
> >> +       struct kvm *kvm;
> >> +       uint64_t msg_addr_base;
> >> +       uint64_t msg_addr_size;
> >> +};
> >> +
> >> +struct dmsintc_state {
> >> +       atomic64_t  vector_map[4];
> >> +};
> >> +
> >> +int kvm_loongarch_register_dmsintc_device(void);
> >> +#endif
> >> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/in=
clude/asm/kvm_host.h
> >> index 19eb5e5c3984..6a8d72cf8e4e 100644
> >> --- a/arch/loongarch/include/asm/kvm_host.h
> >> +++ b/arch/loongarch/include/asm/kvm_host.h
> >> @@ -22,6 +22,7 @@
> >>   #include <asm/kvm_ipi.h>
> >>   #include <asm/kvm_eiointc.h>
> >>   #include <asm/kvm_pch_pic.h>
> >> +#include <asm/kvm_dmsintc.h>
> >>   #include <asm/loongarch.h>
> >>
> >>   #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> >> @@ -135,6 +136,7 @@ struct kvm_arch {
> >>          struct loongarch_ipi *ipi;
> >>          struct loongarch_eiointc *eiointc;
> >>          struct loongarch_pch_pic *pch_pic;
> >> +       struct loongarch_dmsintc *dmsintc;
> >>   };
> >>
> >>   #define CSR_MAX_NUMS           0x800
> >> @@ -247,6 +249,7 @@ struct kvm_vcpu_arch {
> >>          struct kvm_mp_state mp_state;
> >>          /* ipi state */
> >>          struct ipi_state ipi_state;
> >> +       struct dmsintc_state dmsintc_state;
> >>          /* cpucfg */
> >>          u32 cpucfg[KVM_MAX_CPUCFG_REGS];
> >>
> >> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/in=
clude/uapi/asm/kvm.h
> >> index 419647aacdf3..c39b8ac7a90a 100644
> >> --- a/arch/loongarch/include/uapi/asm/kvm.h
> >> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> >> @@ -155,4 +155,8 @@ struct kvm_iocsr_entry {
> >>   #define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL             0x40000006
> >>   #define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT            0
> >>
> >> +#define KVM_DEV_LOONGARCH_DMSINTC_CTRL                 0x40000007
> >> +#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE                0x0
> >> +#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE                0x1
> >> +
> >>   #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
> >> diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
> >> index cb41d9265662..6e184e24443c 100644
> >> --- a/arch/loongarch/kvm/Makefile
> >> +++ b/arch/loongarch/kvm/Makefile
> >> @@ -19,6 +19,7 @@ kvm-y +=3D vm.o
> >>   kvm-y +=3D intc/ipi.o
> >>   kvm-y +=3D intc/eiointc.o
> >>   kvm-y +=3D intc/pch_pic.o
> >> +kvm-y +=3D intc/dmsintc.o
> >>   kvm-y +=3D irqfd.o
> >>
> >>   CFLAGS_exit.o  +=3D $(call cc-disable-warning, override-init)
> >> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/in=
tc/dmsintc.c
> >> new file mode 100644
> >> index 000000000000..1bb61e55d061
> >> --- /dev/null
> >> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> >> @@ -0,0 +1,117 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2025 Loongson Technology Corporation Limited
> >> + */
> >> +
> >> +#include <linux/kvm_host.h>
> >> +#include <asm/kvm_dmsintc.h>
> >> +#include <asm/kvm_vcpu.h>
> >> +
> >> +static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
> >> +                               struct kvm_device_attr *attr,
> >> +                               bool is_write)
> >> +{
> >> +       int addr =3D attr->attr;
> >> +       void __user *data;
> >> +       struct loongarch_dmsintc *s =3D dev->kvm->arch.dmsintc;
> >> +       u64 tmp;
> >> +       u32 cpu_bit;
> >> +
> >> +       data =3D (void __user *)attr->addr;
> >> +       switch (addr) {
> >> +       case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE:
> >> +               if (is_write) {
> >> +                       if (copy_from_user(&tmp, data, sizeof(s->msg_a=
ddr_base)))
> >> +                               return -EFAULT;
> >> +                       if (s->msg_addr_base) {
> >> +                               /* Duplicate setting are not allowed. =
*/
> >> +                               return -EFAULT;
> >> +                       }
> >> +                       if ((tmp & (BIT(AVEC_CPU_SHIFT) - 1)) =3D=3D 0=
)
> >> +                               s->msg_addr_base =3D tmp;
> >> +                       else
> >> +                               return  -EFAULT;
> >> +                       s->msg_addr_base =3D tmp;
> >> +                       cpu_bit =3D find_first_bit((unsigned long *)&(=
s->msg_addr_base), 64)
> >> +                                               - AVEC_CPU_SHIFT;
> >> +                       cpu_bit =3D min(cpu_bit, AVEC_CPU_BIT);
> >> +                       s->cpu_mask =3D GENMASK(cpu_bit - 1, 0) & AVEC=
_CPU_MASK;
> >> +               }
> >> +               break;
> >> +       case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE:
> >> +               if (is_write) {
> >> +                       if (copy_from_user(&tmp, data, sizeof(s->msg_a=
ddr_size)))
> >> +                               return -EFAULT;
> >> +                       if (s->msg_addr_size) {
> >> +                               /*Duplicate setting are not allowed. *=
/
> >> +                               return -EFAULT;
> >> +                       }
> >> +                       s->msg_addr_size =3D tmp;
> >> +               }
> >> +               break;
> >> +       default:
> >> +               kvm_err("%s: unknown dmsintc register, addr =3D %d\n",=
 __func__, addr);
> >> +               return -ENXIO;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int kvm_dmsintc_set_attr(struct kvm_device *dev,
> >> +                       struct kvm_device_attr *attr)
> >> +{
> >> +       switch (attr->group) {
> >> +       case KVM_DEV_LOONGARCH_DMSINTC_CTRL:
> >> +               return kvm_dmsintc_ctrl_access(dev, attr, true);
> >> +       default:
> >> +               kvm_err("%s: unknown group (%d)\n", __func__, attr->gr=
oup);
> >> +               return -EINVAL;
> >> +       }
> >> +}
> >> +
> >> +static int kvm_dmsintc_create(struct kvm_device *dev, u32 type)
> >> +{
> >> +       struct kvm *kvm;
> >> +       struct loongarch_dmsintc *s;
> >> +
> >> +       if (!dev) {
> >> +               kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       kvm =3D dev->kvm;
> >> +       if (kvm->arch.dmsintc) {
> >> +               kvm_err("%s: LoongArch DMSINTC has already been create=
d!\n", __func__);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       s =3D kzalloc(sizeof(struct loongarch_dmsintc), GFP_KERNEL);
> >> +       if (!s)
> >> +               return -ENOMEM;
> >> +
> >> +       s->kvm =3D kvm;
> >> +       kvm->arch.dmsintc =3D s;
> >> +       return 0;
> >> +}
> >> +
> >> +static void kvm_dmsintc_destroy(struct kvm_device *dev)
> >> +{
> >> +
> >> +       if (!dev || !dev->kvm || !dev->kvm->arch.dmsintc)
> >> +               return;
> >> +
> >> +       kfree(dev->kvm->arch.dmsintc);
> >> +       kfree(dev);
> >> +}
> >> +
> >> +static struct kvm_device_ops kvm_dmsintc_dev_ops =3D {
> >> +       .name =3D "kvm-loongarch-dmsintc",
> >> +       .create =3D kvm_dmsintc_create,
> >> +       .destroy =3D kvm_dmsintc_destroy,
> >> +       .set_attr =3D kvm_dmsintc_set_attr,
> >> +};
> >> +
> >> +int kvm_loongarch_register_dmsintc_device(void)
> >> +{
> >> +       return kvm_register_device_ops(&kvm_dmsintc_dev_ops, KVM_DEV_T=
YPE_LOONGARCH_DMSINTC);
> >> +}
> >> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> >> index 2c593ac7892f..713771a93d90 100644
> >> --- a/arch/loongarch/kvm/main.c
> >> +++ b/arch/loongarch/kvm/main.c
> >> @@ -416,6 +416,12 @@ static int kvm_loongarch_env_init(void)
> >>
> >>          /* Register LoongArch PCH-PIC interrupt controller interface.=
 */
> >>          ret =3D kvm_loongarch_register_pch_pic_device();
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Register LoongArch DMSINTC interrupt contrroller interface =
*/
> >> +       if (cpu_has_msgint)
> > I still have some questions here. If we always create dmsintc when
> > cpu_has_msgint, then kvm_guest_has_msgint() is completely useless.
> > Because there will be no guest without dmsintc while the host has
> > dmsintc.
> >
>
> I'd like to clarify two points:
>
> 1. Registration vs. Instantiation:
> In kvm_loongarch_env_init(), the call to kvm_loongarch_register_dmsintc_d=
evice()
> (guarded by cpu_has_msgint) only registers the dmsintc device type with K=
VM.
> This makes the device type available for userspace to create instances vi=
a KVM_CREATE_DEVICE.
> It does not automatically instantiate the device for every VM. The actual=
 creation of
> a dmsintc device for a specific VM is explicitly controlled by userspace =
(e.g., QEMU).
> Therefore, a VM may or may not have dmsintc depending on userspace config=
uration,
> even on hosts that support MSGINT.
>
> 2.Purpose of kvm_guest_has_msgint():
> This function is intended to reflect the userspace configuration for the =
guest,
> i.e., whether the guest VM has MSGINT enabled.
>
> With this in mind, the registration condition does not force every guest =
to have dmsintc,
> and kvm_guest_has_msgint() remains meaningful as long as it queries per-V=
M state.
>
> Please let me know if you have further concerns or suggestions.
OK, thank you for your explanation, no questions now.

Huacai

>
> Thanks.
> Song Gao
>
> >
> > Huacai
> >
> >> +               ret =3D kvm_loongarch_register_dmsintc_device();
> >>
> >>          return ret;
> >>   }
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index 65500f5db379..f2aa9d6ad7d3 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -1220,6 +1220,8 @@ enum kvm_device_type {
> >>   #define KVM_DEV_TYPE_LOONGARCH_EIOINTC KVM_DEV_TYPE_LOONGARCH_EIOINT=
C
> >>          KVM_DEV_TYPE_LOONGARCH_PCHPIC,
> >>   #define KVM_DEV_TYPE_LOONGARCH_PCHPIC  KVM_DEV_TYPE_LOONGARCH_PCHPIC
> >> +       KVM_DEV_TYPE_LOONGARCH_DMSINTC,
> >> +#define KVM_DEV_TYPE_LOONGARCH_DMSINTC   KVM_DEV_TYPE_LOONGARCH_DMSIN=
TC
> >>
> >>          KVM_DEV_TYPE_MAX,
> >>
> >> --
> >> 2.39.3
> >>
>
>
