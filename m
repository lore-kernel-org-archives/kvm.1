Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794548219;
	b=TagKjmH9WF4TzJosa2x5BgSFr3lm4MW96jXhYFqTtRObEHyAGqwvvGn9iESu/1nFifFS
	 0OopGkeN2fh+7St5K8YGULNW1Y3TaStp2nhN6z95nj2UMY5e2ZoTPFRbZZ9WCAQs20gpq
	 9s+o5x6aaHhs38M9IDCK2i4ARkaFyAnse6gfC+KlDfy8EJDTbtBMirIpzMjAJ6YE41SGk
	 Jed/TV7wkdJPVttBkmuzFtQrd5ZzpzASoVs6C4g4bc/ysvpdQoV2EuXSFMFyDXd5nC967
	 C4LNjPSHykliI5fL2zuJuQ6mOvx23l9bme+T2sPYTEa9106a0Trn0A5pqs9ErPA1dUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=T2Ks1icqV7sc4HD6DCoye7tArv6/S0Ygu8r9B8v/4m4=;
	b=qcIUzdVrMDfbFx4XRRZgV5VPzpZR7zjRUryHxGaJFzN7co0pU7utZIoRlNUDJNtT28SL
	 uyzUc0i/rGf+1u3ATBpCv4wqIuj76VIdFMNdWCyZ8fhcTSTaDt3HxmcvkDXXpHQPIgJeO
	 3mOCYMwmwZzmaNcbzpvkJSYnHyv2w8b1v4s3ceZ0nwaKRK2QSnNGjV7yNzKUBIuooOaox
	 gI1c93ILn6miMhH07slW69R92gJus3buNBruG89Kv4oE9KVuOKzCbrzlexba8A7kPqZTU
	 OzwOK/CUqJK+5Gv5hNeG7QX7sFUkIYArLON94WulRIv1NGD66jmZsi7GedzrZBOwkJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=daViEFRR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2706606A32A
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2706606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=daViEFRR
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-497614c95f0so216995f8f.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:36:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794548217; cv=none;
        d=google.com; s=arc-20260327;
        b=RzwhUaXEY/ZefmfY534dQiSMUJzSVxfOHpvgZbKqwrwxYxNhw5BZRmNmF4t0QC3WaW
         IZOPdWfQb0QuQMyPY0VcrIvyTuwZJ/ipwqI0b7xTlakiOlocjEJCDWe70bvaxNSbAOo0
         +lyt34b8zdmW+mA2lJ2g7PGGri1gvFRu2mkzknHGNMP6X4YLadx44oPa2BUBayBjxtQU
         dF7ULIZg3q9e9AJaiOnh1/RoiOG++iVuorQ8zYEeZxy13yWm4WmE61UN0jm15gO/Zy5V
         PxmxCWC+eCdTL4xsSEZ37sr/uuokG7AC43jBmXGoDWuo/sMqOsEmKX66gJFZfJnISnKf
         bC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2Ks1icqV7sc4HD6DCoye7tArv6/S0Ygu8r9B8v/4m4=;
        fh=ck+TRRi8mZ/LQH0eEG18qEI8vs4mYxWbRz6CuRxza0o=;
        b=Xn+cxIy/uoKry5qWRIl2mAMAMWCJ4rq440lWKpPwvw53wEZ80I3E1baPZ1EyTgz1ja
         8YtcKmPWdwq5mbZQD79LqQ3sDf/RSRDqZcPDZJgpG7wHcYmowv2z99qTB+nzaPIz8tHr
         OdpBmuotJ4Ouys1eZasATbYYnDxXXeXPbDsEViFbvFV4v0QFG+469shP4S/B1d0/Zn6J
         02afHBScKe6ok0Kk5i7PZtdwzIqeiCjhTXgnAoQDPDwX8Nevi/vKv/cVl3Bvld/64M2Y
         cPyd3omLMIDUmMdE/9hJmW7fBqUnL7BGsvUIXfjiNE3C1mmMWMmSx35URkkOYFrWnT4O
         6FKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794548217; x=1795153017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T2Ks1icqV7sc4HD6DCoye7tArv6/S0Ygu8r9B8v/4m4=;
        b=daViEFRRlWgxegdlfyazsl4lEgVfhqcGvlV/y5M0IjgUnYqzJ//Y20Yc9YpHSs4zVy
         WbvX3qgm7ZvLNdp3JZDq4N+VFOt3ZM6jGzHHQl1ukfrRmZfcCrI2O61SB6h9kvw3pXzh
         GvK1U4P5pHcYRskVC75iH2ZLtqujiDzWmv3+4xS3WrXX9TkkH5N7bTy9I/UN7Z9Oosj/
         j60DQlu7EI2ji/GMEHLpd2jaLjF7qOvTArp9GrpmSlFiBG8Hi601kRuSgSRPPRZ9275A
         oY0p43gKjd8PzFPH69nb4j6r0qYBA8ZYqnjlgIuNqrnfuiA8rSR7705M96Qa7jbXOpPO
         0Mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548217; x=1795153017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2Ks1icqV7sc4HD6DCoye7tArv6/S0Ygu8r9B8v/4m4=;
        b=Uwiug1n854nJLui8yOW05/W8mtOisDn0MP1y05jKnf7RUC/PVk/kBx+rey498cu/Vv
         uXPdoQNYEAGzt/mbJ2D6Q9EBJdoC1qEiC/t4PTpibestbD0lC2oQ5oDoHEiyutTfDxZN
         UhNYm3aaX6BI6GD/W9wCIc/7IRneCV7YEqouIPSg41ahvoqVMElsuIu8tIvSQnSMNLSN
         mNJOwnUtPUjC0If+1bnay3VbpaPTX1ks6HcRVXvvhws7LhmJh5hKYfOpCFbsNO7UmYHN
         n8r+vtUDaf1MTqpzzlYOnGHPHScloFoG1S99zYDo1gGtlrZswfjHOJcj36//mLZY7zUv
         cZLg==
X-Forwarded-Encrypted: i=1; AL+hErGpX37+Xl3Eqov/Le2i8shpSQd9MQNXq/LGrrUpb7mEG7inhLzXmSltVW+bQRSrHjz4zEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e3nIgNRMs2zB9YYf+SBUP38ng2Z3KHAgNIgFL7BGUciYem3eP
	jdLmuAVSUpuahDeeuAq+JzpATLkFtVGJJOYwaqFMjR1n3N88CFZN4/cs0SjeU1VulmC4Y0BbmSx
	Jue+oaDmq2AsC18/SwMk4+rEGHWJ7fHWZppYERGrkDA==
X-Gm-Gg: AYBFou1PglGQBCSS4o7+uzfMZKnfvfbgKgSKEmm0zdUl11VZIWEg8CApRIsUhSzZf0J
	4v19u2grZZ9qwwxQDbCjRjBp5f+az0bpIjt+PU4kx/xAVrdCNghkzIy4iMGxD+Mj5SrM0fBa2Bl
	ve6Rg7ucdg2WXD3Uq7uADVplnEISuleSobHkqanuTewnSOu81s8s6r/Lu9rDslh1whEhbrNs7Dj
	L1OChuulbnhudxeJ4sEVZEEAby4qMe3HvqYka12BwSg0E8B4S5dcQCvEBwfLeirdJ+3hYisjlyB
	8PkAOUefco0PHkxF3k9FQNIJMeukcXfSrHDuU0m0QYRro+nfw1YQWWiCIEL332uRvwqUakAqXZJ
	UTBSXcHpcCDhsXd4HdLlG7e5lleSjiuEAKojPoONZUBB7QqDjcbKqJmYp3Mz1LX53vajjI6w4Dr
	FC4rShpwky/UEoLEl4ZEcn2mzSweGbo75D30VE24h1ItJM02k2mgWrYuI7/A==
X-Received: by 2002:a05:6000:25ec:b0:490:83b9:7888 with SMTP id
 ffacd0b85a97d-49c74959580mr2860493f8f.52.1794548217360; Thu, 12 Nov 2026
 21:36:57 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1789872556.git.hppiscas@163.com> <3046cfd67c5f962014cd38e49a0e8bf28b6fb53f.1789872556.git.hppiscas@163.com>
In-Reply-To: <3046cfd67c5f962014cd38e49a0e8bf28b6fb53f.1789872556.git.hppiscas@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 11:06:45 +0530
X-Gm-Features: AclHuK9biTLZxhI1tcdlqfU4imHZdhgp5Hgs9a4lcq-e0JhTebZNZ8Ov0xT5swk
Message-ID: <CAAhSdy3-ArOtVWGzzpM3pxi7_+8bhD5L-_WvGL-MFwRLH1xzAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RISC-V: KVM: Validate AIA MMIO address ranges
To: Pengpeng Hou <hppiscas@163.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>, 
	Fangyu Yu <fangyu.yu@linux.alibaba.com>, Guo Ren <guoren@kernel.org>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 6:39=E2=80=AFPM Pengpeng Hou <hppiscas@163.com> wro=
te:
>
> The AIA address setters check alignment but not the complete fixed-size
> APLIC and IMSIC MMIO regions. A range can therefore wrap when its end is
> formed or extend beyond the selected guest physical address space before
> it is registered on the KVM MMIO bus.
>
> Check the complete range in both setters. Return -EINVAL for alignment
> or arithmetic overflow and -E2BIG for a range beyond the selected GPA
> limit, following the arm64 VGIC address-validation convention.
>
> Recheck only the APLIC range during initialization: userspace can set
> its address and then change KVM_CAP_VM_GPA_BITS while the VM still has
> no vCPUs or memory slots. An IMSIC address, in contrast, can only be set
> for an existing vCPU, which already prevents subsequent GPA-width
> changes. No additional pass over the vCPUs is needed.
>
> Keep the existing required-address checks and IMSIC cleanup path.
>
> The issue was found by our static-analysis tool.
>
> Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irq=
chip")
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
> ---
> Changes since v1: https://lore.kernel.org/r/38f87205419f328693bc6ab25ae78=
f021c2dd003.1786512671.git.pengpeng@iscas.ac.cn/
> - Keep the original APLIC and per-vCPU IMSIC required-address checks.
> - Drop the separate pass over all vCPUs during initialization.
> - Recheck only APLIC, whose address can be configured before GPA width
>   becomes immutable; IMSIC setters already require an existing vCPU.
>
>  arch/riscv/kvm/aia_device.c | 42 +++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index efc7c0b..4490015 100644
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
> @@ -248,6 +273,15 @@ static int aia_init(struct kvm *kvm)
>         if (aia->nr_sources && aia->aplic_addr =3D=3D KVM_RISCV_AIA_UNDEF=
_ADDR)
>                 return -EINVAL;
>
> +       /* The GPA width may change after setting APLIC's address on an e=
mpty VM. */
> +       if (aia->nr_sources) {
> +               ret =3D aia_check_addr_range(kvm, aia->aplic_addr,
> +                                          KVM_DEV_RISCV_APLIC_ALIGN,
> +                                          KVM_DEV_RISCV_APLIC_SIZE);
> +               if (ret)
> +                       return ret;
> +       }
> +

We should also check IMSIC addresses one more time in aia_init(). I will
take care of it at the time of merging.

>         /* Group index bits must not overlap guest and HART index bits. *=
/
>         if (aia->nr_group_bits &&
>             aia->nr_group_shift < (IMSIC_MMIO_PAGE_SHIFT +
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.4-rcX

Thanks,
Anup
