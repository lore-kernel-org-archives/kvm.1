Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAD3C0A02
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111482; cv=pass; b=L+vNEwIL75No/U6aB8jHnINV9hK38PynxdNjev0h6UzpTXE9hIKGWNRyr2ADu7ZdcGvdRkbgnv9SHa+p8s66qcvkFobfYfJhnyCJUj5KvkGt73bLMPfNXi8iuvezjDx5jT/qMheBhF1/0y9wswKDSHY02yQk75tEWisaaqWcF4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111482; c=relaxed/simple;
	bh=TNb5YfolWFz/KzCtpoOSTFh7E8/Z2BMjU6+AO4iMnDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/yA0l8o9YdQbe3zCB6s4BZ7mZFT/K26fOiTlX0CyWzZoxbU9GhnhkJCNBwCYKkHRHR74DQvuQkkCcwINDPWEx7Ac8LHaRixiNImUWJIfPanBbgzCUBcr9H3a9yEKaW2ksLrcuXw8XYFWc9CD00xmVpzDFkGoWkKe4qhRQKJQ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=dfxfX0Ic; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="dfxfX0Ic"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-486e934b0c9so134886f8f.2
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 00:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789111474; cv=none;
        d=google.com; s=arc-20260327;
        b=r1RkE4CRXhugNomIZcOwAK35iKhBm9XqG1oif1FWodlQBEpy2sitoDXY421vHIUw6u
         qX79BTxTlCjhgkdNZ2Zrc8eSqZCk4rP7dH3Wrr9OmeScz/qnPEiJLvjotALnzEk+MFuI
         cfWRAPTNILPz71BHLk1KtXxpndIm+UoI6YcQ1OOHPDMNd6n7F+YjOXq2gV/p2QG4KC0I
         FA436VprqMGQwC6pxUSl1tkkYR/aDiLx6jFiRm2Kzl99kAS2zUgN7t5s4EH9OOE3KXkw
         moKtyy88rMdVG2LwwvJC/rd5xPeHsUQcEe0MkyxQKC09rj0pHWNcLd2AOi45NaYqQRi3
         CjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fGXL6SW2PjuwJeBInmK3rjKWbFZ1WqS2BCjkSdFQSww=;
        fh=gsj83ph+nY8YCL1CndvIldzbyHuUH7UaxxkeJiitCiQ=;
        b=sfI2EKruwgONG1XtooWt/Gkhk8LFTFUVrhdll3RJJGNlpuy7whHAbbeN488tDauCn1
         VHALb420vYy6TVtCaY5N9MqLwWLC4BC2JwNSsY3+asQkoHf6HC35eK0k537/RRlov+oU
         M8eVSB522CdQufkhdu92J5pimCXdAPFe1O2YyVwKku+HmQ2LYcOTJaOrhceEBAofeJ+y
         cq7Od2vhOVwG3IfTeyI9Qr21h7z4ee8rCQlEYvgh1Q1/rI80nJ8b4bIxIHSVNxB9ZnSY
         jDNPcV77orIDdcR6GCyzTTXbGSG9AbpJ/uouFm1X585pAcDnGn4BRBhQ811cz4VAb9rh
         3cyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789111474; x=1789716274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGXL6SW2PjuwJeBInmK3rjKWbFZ1WqS2BCjkSdFQSww=;
        b=dfxfX0IcuFdIvk9FoFjZYAokF6XmCG5j3qAsP8xMOiTdbKH/Dz8d9Mg5lqt0/cOzRK
         MsYMsLhvhZqSLmcnJ0v1qgxUGVb+t8EltjLPWSNaCyAsc8jHXjoYswBiBuS7hgJaeaIe
         /6fyzBlZylB8d08mQZjwD2mqcJwILxdDyLntw3P2XwOu7JiYBPt54MHPWonv+Wj7TZlk
         KFCL7Sg1GPoU4UKaP43bmmifb8mN5IBkgjP2cRfMunXK1INaV4ipyk55zQ3cPro1cccM
         PfLrQhZ+vrJRaMsfWJOQa6EgfkLC/n+5JcmoPdq96ZKQ91lVeFuwiba9FntxNcFPp3cA
         QJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789111474; x=1789716274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGXL6SW2PjuwJeBInmK3rjKWbFZ1WqS2BCjkSdFQSww=;
        b=QTPVjOe7xY8X9TD70bkrHcamSPRQOynVLGjrigfuOx9TEYTfBMOzn9wkEhqNfhg6ki
         uQpBwitZMiv8MhNUh0Fvzb2EN9wjYhTmCFF5cZLEsNtx+AJdCOnhKbBx5FugRglU8HZF
         etsmb8Gx39TWcWt1YDtvO6NcVFY8j7aOOs/IdLu9JeJpTi94TUaMd2URbLj/u7Ztn/GE
         e75vz0L//K5qR23YTbMj1MhJgqMIJZE+2zLKjd9W2oLCrsY2aZxrurRZPkNXrMxsr8h9
         oTqjcQDw4VN5v1XSFwlP3BYy7WzpZt/S27rH4QUtk7eK0r6jRzu0neHrcN5wNTdyMpxj
         M9hQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3MNW5yCUzKNiWWwPN2xFV/E10JuCOOSsNWX7tk/qaczaKCRk0fAB/QQ9/Bu6w4Koy2Gk=@vger.kernel.org
X-Gm-Message-State: AFuF++miR/ne/xtVOEmY6TYm3WYlon/EdaQPcUh0KZ4Ev0OXNV2VJyXB
	hORBFhoZSw6G6NwQVA6beqaY0N/comQ3difg0iY/Ape6pZpPvBLiQ1e2c1z/psI08qB3MYC2yfe
	et1deW+qFmFHkNkM4a8fR7CAo1vCpQJ32GYGKnnaq0w==
X-Gm-Gg: AYBFou2crFw1os3deY7DrXSW+ypl88mMZf2+IplYBcuJMSDvOv9n0q2LOQB0vqkbeal
	x3qsfhduoeX+Zhz+rgPJF/yeD/6vTLa+/miq0P+2NvmqvF4NY/ozJjoA2EZMauI5bFnh6WNEQz3
	BdZQ+IeAhoFvo7t76j/A3CiWuvPWA5lCVAINxaQiYVVlzkyg7hsRwERB+vZwdI7FPC75vi1y+UM
	WATL2rdDnSQ1UOskMwelIVga6zzwuG7JeKDgO3rFjcz2zVebF90x/eVxAy/HWI0k5gLtLfrHtt/
	IE9Myt4PCujFfIZ1bsK0C6JQ2XdWp4hLoZNTjNJyALHC1Ap8LVQNVPOrqmYtUc46maBnwPDByL+
	EFD7KkCiwSWAZD30lvD3nSVyEEKglYvw+/nilgdszc1LkdiYT0ydO5lXYAm2TyWQSUpRU11bMGA
	==
X-Received: by 2002:a05:6000:2c10:b0:486:e8ec:f999 with SMTP id
 ffacd0b85a97d-486eafd5fbdmr3215110f8f.6.1789111474165; Fri, 11 Sep 2026
 00:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786512671.git.pengpeng@iscas.ac.cn> <38f87205419f328693bc6ab25ae78f021c2dd003.1786512671.git.pengpeng@iscas.ac.cn>
In-Reply-To: <38f87205419f328693bc6ab25ae78f021c2dd003.1786512671.git.pengpeng@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 11 Sep 2026 12:54:22 +0530
X-Gm-Features: AcwNN1Ui109i9ET6WVNBUkTgCCDwwsHevBU9WciGYkKXECocq96-TkdibME6zPA
Message-ID: <CAAhSdy1vDFrNQAT4vfDrfAVmztt0qvKhL3SeTOab3DBHmxC4-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: KVM: Validate AIA MMIO address ranges
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Guo Ren <guoren@kernel.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:09=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> Userspace supplies the APLIC and per-vCPU IMSIC base addresses through
> the AIA device API.  The address setters currently reject only
> misaligned addresses.
>
> The regions are later registered on KVM's MMIO bus with fixed sizes.  An
> aligned base near U64_MAX can therefore wrap when the range end is
> formed.  A lower base can still place the range beyond the selected
> guest stage-2 physical address space.  kvm_io_bus_cmp() assumes that
> registered ranges do not wrap.
>
> Validate the complete interval when an address is stored.  Since
> KVM_CAP_VM_GPA_BITS can change the selected GPA width before AIA
> initialization, validate every address again before registering the
> first MMIO device.
>
> Return -EINVAL for misalignment or arithmetic overflow and -E2BIG when
> the end exceeds the stage-2 GPA limit, following the arm64 VGIC
> address-validation convention.
>
> Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irq=
chip")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  arch/riscv/kvm/aia_device.c | 79 +++++++++++++++++++++++++++++++------
>  1 file changed, 66 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index efc7c0bcfba9..e969dbdc4b97 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -10,7 +10,9 @@
>  #include <linux/bits.h>
>  #include <linux/irqchip/riscv-imsic.h>
>  #include <linux/kvm_host.h>
> +#include <linux/overflow.h>
>  #include <linux/uaccess.h>
> +#include <asm/kvm_gstage.h>
>  #include <asm/kvm_isa.h>
>
>  static int aia_create(struct kvm_device *dev, u32 type)
> @@ -142,17 +144,37 @@ static int aia_config(struct kvm *kvm, unsigned lon=
g type,
>         return 0;
>  }
>
> +static int aia_check_addr_range(struct kvm *kvm, u64 addr, u64 alignment=
,
> +                               u64 size)
> +{
> +       u64 end;
> +
> +       if (!IS_ALIGNED(addr, alignment))
> +               return -EINVAL;
> +
> +       if (check_add_overflow(addr, size, &end))
> +               return -EINVAL;
> +
> +       if (end > kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels))
> +               return -E2BIG;
> +
> +       return 0;
> +}
> +
>  static int aia_aplic_addr(struct kvm *kvm, u64 *addr, bool write)
>  {
>         struct kvm_aia *aia =3D &kvm->arch.aia;
> +       int ret;
>
>         if (write) {
>                 /* Writes can only be done before irqchip is initialized =
*/
>                 if (kvm_riscv_aia_initialized(kvm))
>                         return -EBUSY;
>
> -               if (*addr & (KVM_DEV_RISCV_APLIC_ALIGN - 1))
> -                       return -EINVAL;
> +               ret =3D aia_check_addr_range(kvm, *addr, KVM_DEV_RISCV_AP=
LIC_ALIGN,
> +                                          KVM_DEV_RISCV_APLIC_SIZE);
> +               if (ret)
> +                       return ret;
>
>                 aia->aplic_addr =3D *addr;
>         } else
> @@ -166,6 +188,7 @@ static int aia_imsic_addr(struct kvm *kvm, u64 *addr,
>  {
>         struct kvm_vcpu *vcpu;
>         struct kvm_vcpu_aia *vcpu_aia;
> +       int ret;
>
>         vcpu =3D kvm_get_vcpu(kvm, vcpu_idx);
>         if (!vcpu)
> @@ -177,8 +200,10 @@ static int aia_imsic_addr(struct kvm *kvm, u64 *addr=
,
>                 if (kvm_riscv_aia_initialized(kvm))
>                         return -EBUSY;
>
> -               if (*addr & (KVM_DEV_RISCV_IMSIC_ALIGN - 1))
> -                       return -EINVAL;
> +               ret =3D aia_check_addr_range(kvm, *addr, KVM_DEV_RISCV_IM=
SIC_ALIGN,
> +                                          KVM_DEV_RISCV_IMSIC_SIZE);
> +               if (ret)
> +                       return ret;
>         }
>
>         mutex_lock(&vcpu->mutex);
> @@ -191,6 +216,40 @@ static int aia_imsic_addr(struct kvm *kvm, u64 *addr=
,
>         return 0;
>  }
>
> +static int aia_validate_addr_ranges(struct kvm *kvm)
> +{
> +       struct kvm_aia *aia =3D &kvm->arch.aia;
> +       struct kvm_vcpu_aia *vaia;
> +       struct kvm_vcpu *vcpu;
> +       unsigned long idx;
> +       int ret;
> +
> +       if (aia->nr_sources) {
> +               if (aia->aplic_addr =3D=3D KVM_RISCV_AIA_UNDEF_ADDR)
> +                       return -EINVAL;
> +
> +               ret =3D aia_check_addr_range(kvm, aia->aplic_addr,
> +                                          KVM_DEV_RISCV_APLIC_ALIGN,
> +                                          KVM_DEV_RISCV_APLIC_SIZE);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       kvm_for_each_vcpu(idx, vcpu, kvm) {
> +               vaia =3D &vcpu->arch.aia_context;
> +               if (vaia->imsic_addr =3D=3D KVM_RISCV_AIA_UNDEF_ADDR)
> +                       return -EINVAL;
> +
> +               ret =3D aia_check_addr_range(kvm, vaia->imsic_addr,
> +                                          KVM_DEV_RISCV_IMSIC_ALIGN,
> +                                          KVM_DEV_RISCV_IMSIC_SIZE);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static gpa_t aia_imsic_ppn(struct kvm_aia *aia, gpa_t addr)
>  {
>         u32 h, l;
> @@ -244,9 +303,9 @@ static int aia_init(struct kvm *kvm)
>         if (aia->nr_ids < aia->nr_sources)
>                 return -EINVAL;
>
> -       /* APLIC base is required for non-zero number of sources */
> -       if (aia->nr_sources && aia->aplic_addr =3D=3D KVM_RISCV_AIA_UNDEF=
_ADDR)
> -               return -EINVAL;
> +       ret =3D aia_validate_addr_ranges(kvm);
> +       if (ret)
> +               return ret;

No need for this change.

>
>         /* Group index bits must not overlap guest and HART index bits. *=
/
>         if (aia->nr_group_bits &&
> @@ -263,12 +322,6 @@ static int aia_init(struct kvm *kvm)
>         kvm_for_each_vcpu(idx, vcpu, kvm) {
>                 vaia =3D &vcpu->arch.aia_context;
>
> -               /* IMSIC base is required */
> -               if (vaia->imsic_addr =3D=3D KVM_RISCV_AIA_UNDEF_ADDR) {
> -                       ret =3D -EINVAL;
> -                       goto fail_cleanup_imsics;
> -               }
> -

Don't drop this check.

>                 /* All IMSICs should have matching base PPN */
>                 if (base_ppn =3D=3D KVM_RISCV_AIA_UNDEF_ADDR)
>                         base_ppn =3D aia_imsic_ppn(aia, vaia->imsic_addr)=
;
> --
> 2.50.1 (Apple Git-155)
>

Regards,
Anup
