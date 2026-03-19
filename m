Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FB1386C9
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924522; cv=none; b=qjJU7gCHNEyJ05xOzg+ZYyq+muCIuInkW7+CdQI/xg3uS4mda3p1f3nD2L29uj1DD+qNCCWcbiiqkOjeRaaKBP64sVo0xKa6h4LFp0QtmFgFmeZ+nbRPlVxJ+NJ6SL+Id2M5NmHN3IJ6CbmGxw6VxVJNXz3k71PHzSd8Fjk/V3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924522; c=relaxed/simple;
	bh=PJU7t96fLEVBcYDoF/dUaar4KRDA/VGraZKP/igQX78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dr56UloPZEclvI/j77yf0bRwVcSdtN8ATfJZNTXyfCIKExgZmaojK2QCXMTR1fj7PDTrYBQ4saHirNGec9Zfrtm8uw3zI/mlpYi5qCcRrvcN4VKcdomiF3cpwPNKn5KG+E4PCvJQoQVDmVYvAV2BJT05n4Ve1zDJ7hR5FzH9o5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLbcCE3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLbcCE3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE31C2BCB1
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924522;
	bh=PJU7t96fLEVBcYDoF/dUaar4KRDA/VGraZKP/igQX78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZLbcCE3gICe1hM4VKVs6h2fMX2k4W6YCDxBKDExnyYPiQ7kD12oDMksBuyp8P+K/V
	 x9dP/qAdG/F751nY1KFqgKxLuLEuLoayGVTkFTbQKnCdqz2WwjqF7cqDtAKUCn/W8P
	 kJHVApHl8ebg9zPQV0mi/9hmS08qiQWcR0eKMWDYoUXrlCY+bS7rziUYJuUqbsJSjy
	 qi3FzyYk3SgoKR4L4VANbOf8FKFdDZX6LS7WFWRtHL8l4DkHxTFMl8xpdZAHlnm4Uk
	 v1Vmr6vBWHZeKYub3zrzSNmpfomzoOgeIuCrjDNCI93zIg5PvGRCsITDYr+CEEclTp
	 yrAwRTeHjuxiw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b97e6e48b24so146223366b.2
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 05:48:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJjuk3RplD8ViI6qSEvBMuH07Pu/JFpyVaICp59wZaLwsMhJyaK11Kthk8oltTAxJ48gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybxtFmeTVMSSOAIK9j9hiIKCrvZJuDjxMsEiRwGiGTo7ybw+tM
	GlAAf/PEmRI5aYPGfLclKdaWH54gm8z257B1Q2SEqtu7e3Vtn9PCSaZQ+2nx+I6RZGfPanlOAmQ
	9246yhLtl/Y6sgnEvhd0iLkGWC2o61PM=
X-Received: by 2002:a17:907:9348:b0:b97:b2dc:91d7 with SMTP id
 a640c23a62f3a-b97f480e6e1mr481987666b.16.1773924520443; Thu, 19 Mar 2026
 05:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311085059.1040263-1-gaosong@loongson.cn> <20260311085059.1040263-2-gaosong@loongson.cn>
In-Reply-To: <20260311085059.1040263-2-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Mar 2026 20:48:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WZj3LmghXxXY1hNUjEmihx1fjggOZLNRRDS5PN2s0kg@mail.gmail.com>
X-Gm-Features: AaiRm52XP76qHmwQYsJQMtONd2Xx1f_jwLbGH3XZD6N8WkBfD3ip5XK0tiyzCwo
Message-ID: <CAAhV-H4WZj3LmghXxXY1hNUjEmihx1fjggOZLNRRDS5PN2s0kg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] LoongArch: KVM: Add DMSINTC device support
To: Song Gao <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	kernel@xen0n.name, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Song,

On Wed, Mar 11, 2026 at 5:16=E2=80=AFPM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> Add device model for DMSINTC interrupt controller, implement basic
> create/destroy/set_attr interfaces, and register device model to kvm
> device table.
>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_dmsintc.h |  21 ++++
>  arch/loongarch/include/asm/kvm_host.h    |   3 +
>  arch/loongarch/include/uapi/asm/kvm.h    |   4 +
>  arch/loongarch/kvm/Makefile              |   1 +
>  arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++++
>  arch/loongarch/kvm/main.c                |   6 ++
>  include/uapi/linux/kvm.h                 |   2 +
>  7 files changed, 154 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
>  create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
>
> diff --git a/arch/loongarch/include/asm/kvm_dmsintc.h b/arch/loongarch/in=
clude/asm/kvm_dmsintc.h
> new file mode 100644
> index 000000000000..b04b89dd2a35
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kvm_dmsintc.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __ASM_KVM_DMSINTC_H
> +#define __ASM_KVM_DMSINTC_H
> +
> +
> +struct loongarch_dmsintc {
> +       struct kvm *kvm;
> +       uint64_t msg_addr_base;
> +       uint64_t msg_addr_size;
> +};
> +
> +struct dmsintc_state {
> +       atomic64_t  vector_map[4];
> +};
> +
> +int kvm_loongarch_register_dmsintc_device(void);
> +#endif
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 19eb5e5c3984..6a8d72cf8e4e 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -22,6 +22,7 @@
>  #include <asm/kvm_ipi.h>
>  #include <asm/kvm_eiointc.h>
>  #include <asm/kvm_pch_pic.h>
> +#include <asm/kvm_dmsintc.h>
>  #include <asm/loongarch.h>
>
>  #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> @@ -135,6 +136,7 @@ struct kvm_arch {
>         struct loongarch_ipi *ipi;
>         struct loongarch_eiointc *eiointc;
>         struct loongarch_pch_pic *pch_pic;
> +       struct loongarch_dmsintc *dmsintc;
>  };
>
>  #define CSR_MAX_NUMS           0x800
> @@ -247,6 +249,7 @@ struct kvm_vcpu_arch {
>         struct kvm_mp_state mp_state;
>         /* ipi state */
>         struct ipi_state ipi_state;
> +       struct dmsintc_state dmsintc_state;
>         /* cpucfg */
>         u32 cpucfg[KVM_MAX_CPUCFG_REGS];
>
> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/inclu=
de/uapi/asm/kvm.h
> index 419647aacdf3..c39b8ac7a90a 100644
> --- a/arch/loongarch/include/uapi/asm/kvm.h
> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> @@ -155,4 +155,8 @@ struct kvm_iocsr_entry {
>  #define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL             0x40000006
>  #define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT            0
>
> +#define KVM_DEV_LOONGARCH_DMSINTC_CTRL                 0x40000007
> +#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE                0x0
> +#define KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE                0x1
> +
>  #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
> diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
> index cb41d9265662..6e184e24443c 100644
> --- a/arch/loongarch/kvm/Makefile
> +++ b/arch/loongarch/kvm/Makefile
> @@ -19,6 +19,7 @@ kvm-y +=3D vm.o
>  kvm-y +=3D intc/ipi.o
>  kvm-y +=3D intc/eiointc.o
>  kvm-y +=3D intc/pch_pic.o
> +kvm-y +=3D intc/dmsintc.o
>  kvm-y +=3D irqfd.o
>
>  CFLAGS_exit.o  +=3D $(call cc-disable-warning, override-init)
> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> new file mode 100644
> index 000000000000..1bb61e55d061
> --- /dev/null
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/kvm_host.h>
> +#include <asm/kvm_dmsintc.h>
> +#include <asm/kvm_vcpu.h>
> +
> +static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
> +                               struct kvm_device_attr *attr,
> +                               bool is_write)
> +{
> +       int addr =3D attr->attr;
> +       void __user *data;
> +       struct loongarch_dmsintc *s =3D dev->kvm->arch.dmsintc;
> +       u64 tmp;
> +       u32 cpu_bit;
> +
> +       data =3D (void __user *)attr->addr;
> +       switch (addr) {
> +       case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_BASE:
> +               if (is_write) {
> +                       if (copy_from_user(&tmp, data, sizeof(s->msg_addr=
_base)))
> +                               return -EFAULT;
> +                       if (s->msg_addr_base) {
> +                               /* Duplicate setting are not allowed. */
> +                               return -EFAULT;
> +                       }
> +                       if ((tmp & (BIT(AVEC_CPU_SHIFT) - 1)) =3D=3D 0)
> +                               s->msg_addr_base =3D tmp;
> +                       else
> +                               return  -EFAULT;
> +                       s->msg_addr_base =3D tmp;
> +                       cpu_bit =3D find_first_bit((unsigned long *)&(s->=
msg_addr_base), 64)
> +                                               - AVEC_CPU_SHIFT;
> +                       cpu_bit =3D min(cpu_bit, AVEC_CPU_BIT);
> +                       s->cpu_mask =3D GENMASK(cpu_bit - 1, 0) & AVEC_CP=
U_MASK;
> +               }
> +               break;
> +       case KVM_DEV_LOONGARCH_DMSINTC_MSG_ADDR_SIZE:
> +               if (is_write) {
> +                       if (copy_from_user(&tmp, data, sizeof(s->msg_addr=
_size)))
> +                               return -EFAULT;
> +                       if (s->msg_addr_size) {
> +                               /*Duplicate setting are not allowed. */
> +                               return -EFAULT;
> +                       }
> +                       s->msg_addr_size =3D tmp;
> +               }
> +               break;
> +       default:
> +               kvm_err("%s: unknown dmsintc register, addr =3D %d\n", __=
func__, addr);
> +               return -ENXIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int kvm_dmsintc_set_attr(struct kvm_device *dev,
> +                       struct kvm_device_attr *attr)
> +{
> +       switch (attr->group) {
> +       case KVM_DEV_LOONGARCH_DMSINTC_CTRL:
> +               return kvm_dmsintc_ctrl_access(dev, attr, true);
> +       default:
> +               kvm_err("%s: unknown group (%d)\n", __func__, attr->group=
);
> +               return -EINVAL;
> +       }
> +}
> +
> +static int kvm_dmsintc_create(struct kvm_device *dev, u32 type)
> +{
> +       struct kvm *kvm;
> +       struct loongarch_dmsintc *s;
> +
> +       if (!dev) {
> +               kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       kvm =3D dev->kvm;
> +       if (kvm->arch.dmsintc) {
> +               kvm_err("%s: LoongArch DMSINTC has already been created!\=
n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       s =3D kzalloc(sizeof(struct loongarch_dmsintc), GFP_KERNEL);
> +       if (!s)
> +               return -ENOMEM;
> +
> +       s->kvm =3D kvm;
> +       kvm->arch.dmsintc =3D s;
> +       return 0;
> +}
> +
> +static void kvm_dmsintc_destroy(struct kvm_device *dev)
> +{
> +
> +       if (!dev || !dev->kvm || !dev->kvm->arch.dmsintc)
> +               return;
> +
> +       kfree(dev->kvm->arch.dmsintc);
> +       kfree(dev);
> +}
> +
> +static struct kvm_device_ops kvm_dmsintc_dev_ops =3D {
> +       .name =3D "kvm-loongarch-dmsintc",
> +       .create =3D kvm_dmsintc_create,
> +       .destroy =3D kvm_dmsintc_destroy,
> +       .set_attr =3D kvm_dmsintc_set_attr,
> +};
> +
> +int kvm_loongarch_register_dmsintc_device(void)
> +{
> +       return kvm_register_device_ops(&kvm_dmsintc_dev_ops, KVM_DEV_TYPE=
_LOONGARCH_DMSINTC);
> +}
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 2c593ac7892f..713771a93d90 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -416,6 +416,12 @@ static int kvm_loongarch_env_init(void)
>
>         /* Register LoongArch PCH-PIC interrupt controller interface. */
>         ret =3D kvm_loongarch_register_pch_pic_device();
> +       if (ret)
> +               return ret;
> +
> +       /* Register LoongArch DMSINTC interrupt contrroller interface */
> +       if (cpu_has_msgint)
I still have some questions here. If we always create dmsintc when
cpu_has_msgint, then kvm_guest_has_msgint() is completely useless.
Because there will be no guest without dmsintc while the host has
dmsintc.


Huacai

> +               ret =3D kvm_loongarch_register_dmsintc_device();
>
>         return ret;
>  }
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 65500f5db379..f2aa9d6ad7d3 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1220,6 +1220,8 @@ enum kvm_device_type {
>  #define KVM_DEV_TYPE_LOONGARCH_EIOINTC KVM_DEV_TYPE_LOONGARCH_EIOINTC
>         KVM_DEV_TYPE_LOONGARCH_PCHPIC,
>  #define KVM_DEV_TYPE_LOONGARCH_PCHPIC  KVM_DEV_TYPE_LOONGARCH_PCHPIC
> +       KVM_DEV_TYPE_LOONGARCH_DMSINTC,
> +#define KVM_DEV_TYPE_LOONGARCH_DMSINTC   KVM_DEV_TYPE_LOONGARCH_DMSINTC
>
>         KVM_DEV_TYPE_MAX,
>
> --
> 2.39.3
>
