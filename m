Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F62765E2
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779757987; cv=none; b=fvMHZBCbPITNOVbroeRdrfBbsDf/dQpL7ayimRPXsIVuKqYn9m5vURM17scc6JVAwr2YGdqu0iaoDtLTcud8pIXogvjr4xzbEaIniGTkNVh6sx/z8KhKmRerx4z/ERkxdy0P0mAVwtZ9s63pOsRFgDKw5wBE+MGbglsFmpvER60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779757987; c=relaxed/simple;
	bh=Kb+rbdWGJ/fjAK7hdbUMol6lJalM2WddgjLrF5Oxfio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knBzHFar4R6+Wt39um+p7x++obokqn8CE+dfeR8nFvcDFkWZI0AYZhHOzr8+hV0+bEhSqTAPvF6SMG7VI2RGOAOz6PWh9LsqvXqYOUqpXELaGywqPLz8/Z8mFP81DS5AbL1TH9i12/+bKO5leydCOd+kw7tcE7JCBoL9SqghWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLMJPqQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLMJPqQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0681F000E9
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779757985;
	bh=Bew54oJ3uyqcMCWGRlDiIEbpvZSAxTNcu+iR+SM4f2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kLMJPqQessQldE2KyGArtNI3C1/0NGvNJ/RApKllKJh/qhw9laxIVPclAuLVwR4yU
	 5NBp2Yp852HZyGf2rzEvM6wFYSaj7y+n2DhMx0N0f/iO6stCmymo0C348wLf8vQImB
	 oXu2L+riYdCnH5STiHEz2XMKzd4lWkP+Bi3swJbyXYE6alUkU+iPPWnS7Je0OX0Hsf
	 t0oQlqxA3xhBO1sJJsZVTsawbeVthXIMC0fme5cluXDfpYP+8O7n7BVMq52owQvrt/
	 49KSGZqVqUECjEhZOYG7SM9ey5TrvmELmtAw/ejxaGpNAK5IK1tUYmImxrDVNFXdld
	 qJcoXCvOJ+QBQ==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso24034665e9.2
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 18:13:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ98Cy07/M9GjGRqc2zo2gosYdLnmn4k3YoPr90UiYdlpfMRkjqs7A14sQmJUKODJt6nAq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV29bA487xYIGJOB/WB4n5/CcJz7Sux1X853OhjgZdzrnEGIDV
	uXbk6OeJOvEULJYA/6Mpz/xJTYvkdzB+n4xTTRGC+pa3MgRhWCMyNUHCQ+cLfrmjbNeMa4SIVOG
	BJ4u/KC4zm3cfW5b0yp+2Io63BCtKN/c=
X-Received: by 2002:a05:6000:2589:b0:449:af52:614d with SMTP id
 ffacd0b85a97d-45eb367ecfdmr30856306f8f.11.1779757984362; Mon, 25 May 2026
 18:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com> <20260525094945.3721783-3-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260525094945.3721783-3-anup.patel@oss.qualcomm.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 26 May 2026 09:12:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTST9S5ojmvqvGZ7AekTKyN5JQJQZbW=Ruyg40ZRZmBtNQ@mail.gmail.com>
X-Gm-Features: AVHnY4KenUx-XpI4AhNVUd5--RfbQBXXNlzSfBQiI5FD317MJL-l7Cxgpo3tNgY
Message-ID: <CAJF2gTST9S5ojmvqvGZ7AekTKyN5JQJQZbW=Ruyg40ZRZmBtNQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] RISC-V: KVM: AIA: Make HGEI number management
 fully per-CPU
To: Anup Patel <anup.patel@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:49=E2=80=AFPM Anup Patel <anup.patel@oss.qualcomm=
.com> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Previously, the number of Hypervisor Guest External Interrupt (HGEI)
> lines was stored in a single global variable `kvm_riscv_aia_nr_hgei`
> and assumed to be the same for all HARTs. This assumption does not
> hold on heterogeneous RISC-V SoCs where different cores may expose
> different HGEIE CSR widths.
>
> Introduce `nr_hgei` field into the per-CPU `struct aia_hgei_control`
> and probe the actual supported HGEI count for the current HART in
> `kvm_riscv_aia_enable()` using the standard RISC-V CSR probe technique:
>
>     csr_write(CSR_HGEIE, -1UL);
>     nr =3D fls_long(csr_read(CSR_HGEIE));
>     if (nr)
>         nr--;
>
> All HGEI allocation, free and disable paths (`kvm_riscv_aia_free_hgei()`,
> `kvm_riscv_aia_disable()`, etc.) now use the per-CPU value instead of
> the global one.
>
> The global `kvm_riscv_aia_nr_hgei` now represents the minimum number
> of HGEI lines across HARTs and can be used to check whether HGEI
> support is available or not.
>
> This makes KVM AIA robust on big.LITTLE-style asymmetric platforms.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
> ---
>  arch/riscv/include/asm/kvm_aia.h |  2 +-
>  arch/riscv/kvm/aia.c             | 88 +++++++++++++++++++-------------
>  arch/riscv/kvm/aia_device.c      |  4 +-
>  arch/riscv/kvm/main.c            |  8 +--
>  4 files changed, 60 insertions(+), 42 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kv=
m_aia.h
> index b04ecdd1a860..c67ec5ac0a14 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -79,7 +79,7 @@ struct kvm_vcpu_aia {
>
>  #define irqchip_in_kernel(k)           ((k)->arch.aia.in_kernel)
>
> -extern unsigned int kvm_riscv_aia_nr_hgei;
> +extern atomic_t kvm_riscv_aia_nr_hgei;
>  extern unsigned int kvm_riscv_aia_max_ids;
>  DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
>  #define kvm_riscv_aia_available() \
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 5ec503288555..bafb009c5ce5 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -21,13 +21,15 @@
>
>  struct aia_hgei_control {
>         raw_spinlock_t lock;
> +       bool free_bitmap_initialized;
>         unsigned long free_bitmap;
>         struct kvm_vcpu *owners[BITS_PER_LONG];
> +       unsigned int nr_hgei;
>  };
>  static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
>  static int hgei_parent_irq;
>
> -unsigned int kvm_riscv_aia_nr_hgei;
> +atomic_t kvm_riscv_aia_nr_hgei;
>  unsigned int kvm_riscv_aia_max_ids;
>  DEFINE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
>
> @@ -452,7 +454,7 @@ void kvm_riscv_aia_free_hgei(int cpu, int hgei)
>
>         raw_spin_lock_irqsave(&hgctrl->lock, flags);
>
> -       if (hgei > 0 && hgei <=3D kvm_riscv_aia_nr_hgei) {
> +       if (hgei > 0 && hgei <=3D hgctrl->nr_hgei) {
>                 if (!(hgctrl->free_bitmap & BIT(hgei))) {
>                         hgctrl->free_bitmap |=3D BIT(hgei);
>                         hgctrl->owners[hgei] =3D NULL;
> @@ -486,26 +488,18 @@ static irqreturn_t hgei_interrupt(int irq, void *de=
v_id)
>
>  static int aia_hgei_init(void)
>  {
> -       int cpu, rc;
> -       struct irq_domain *domain;
>         struct aia_hgei_control *hgctrl;
> +       struct irq_domain *domain;
> +       int cpu, rc;
>
>         /* Initialize per-CPU guest external interrupt line management */
>         for_each_possible_cpu(cpu) {
>                 hgctrl =3D per_cpu_ptr(&aia_hgei, cpu);
>                 raw_spin_lock_init(&hgctrl->lock);
> -               if (kvm_riscv_aia_nr_hgei) {
> -                       hgctrl->free_bitmap =3D
> -                               BIT(kvm_riscv_aia_nr_hgei + 1) - 1;
> -                       hgctrl->free_bitmap &=3D ~BIT(0);
> -               } else
> -                       hgctrl->free_bitmap =3D 0;
> +               hgctrl->free_bitmap_initialized =3D false;
> +               hgctrl->free_bitmap =3D 0;
>         }
>
> -       /* Skip SGEI interrupt setup for zero guest external interrupts *=
/
> -       if (!kvm_riscv_aia_nr_hgei)
> -               goto skip_sgei_interrupt;
> -
>         /* Find INTC irq domain */
>         domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
>                                           DOMAIN_BUS_ANY);
> @@ -529,25 +523,60 @@ static int aia_hgei_init(void)
>                 return rc;
>         }
>
> -skip_sgei_interrupt:
>         return 0;
>  }
>
>  static void aia_hgei_exit(void)
>  {
> -       /* Do nothing for zero guest external interrupts */
> -       if (!kvm_riscv_aia_nr_hgei)
> -               return;
> -
>         /* Free per-CPU SGEI interrupt */
>         free_percpu_irq(hgei_parent_irq, &aia_hgei);
>  }
>
>  void kvm_riscv_aia_enable(void)
>  {
> +       const struct imsic_global_config *gc;
> +       const struct imsic_local_config *lc;
> +       struct aia_hgei_control *hgctrl;
> +       unsigned long flags;
> +       int aia_nr_hgei;
> +
>         if (!kvm_riscv_aia_available())
>                 return;
>
> +       gc =3D imsic_get_global_config();
> +       lc =3D (gc) ? this_cpu_ptr(gc->local) : NULL;
> +       hgctrl =3D this_cpu_ptr(&aia_hgei);
> +
> +       /* Figure-out number of bits in HGEIE */
> +       csr_write(CSR_HGEIE, -1UL);
> +       hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> +       csr_write(CSR_HGEIE, 0);
> +       if (hgctrl->nr_hgei)
> +               hgctrl->nr_hgei--;
> +
> +       /*
> +        * Number of usable per-HART HGEI lines should be minimum of
> +        * per-HART IMSIC guest files and number of bits in HGEIE.
> +        */
> +       if (lc)
> +               hgctrl->nr_hgei =3D min((ulong)hgctrl->nr_hgei, lc->nr_gu=
est_files);
Great! You correct that.

> +       else
> +               hgctrl->nr_hgei =3D 0;
> +
> +       /* Update the number of IMSIC guest files across all HARTs */
> +       aia_nr_hgei =3D atomic_read(&kvm_riscv_aia_nr_hgei);
> +       do {
> +               if (aia_nr_hgei <=3D hgctrl->nr_hgei)
> +                       break;
> +       } while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia_nr_hgei=
, hgctrl->nr_hgei));
> +
> +       raw_spin_lock_irqsave(&hgctrl->lock, flags);
> +       if (!hgctrl->free_bitmap_initialized) {
> +               hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ? GENMASK_ULL(h=
gctrl->nr_hgei, 1) : 0;
> +               hgctrl->free_bitmap_initialized =3D true;
> +       }
> +       raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +
>         csr_write(CSR_HVICTL, aia_hvictl_value(false));
>         csr_write(CSR_HVIPRIO1, 0x0);
>         csr_write(CSR_HVIPRIO2, 0x0);
> @@ -588,7 +617,7 @@ void kvm_riscv_aia_disable(void)
>
>         raw_spin_lock_irqsave(&hgctrl->lock, flags);
>
> -       for (i =3D 0; i <=3D kvm_riscv_aia_nr_hgei; i++) {
> +       for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
>                 vcpu =3D hgctrl->owners[i];
>                 if (!vcpu)
>                         continue;
> @@ -628,26 +657,15 @@ int kvm_riscv_aia_init(void)
>                 return -ENODEV;
>         gc =3D imsic_get_global_config();
>
> -       /* Figure-out number of bits in HGEIE */
> -       csr_write(CSR_HGEIE, -1UL);
> -       kvm_riscv_aia_nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> -       csr_write(CSR_HGEIE, 0);
> -       if (kvm_riscv_aia_nr_hgei)
> -               kvm_riscv_aia_nr_hgei--;
> -
> -       /*
> -        * Number of usable HGEI lines should be minimum of per-HART
> -        * IMSIC guest files and number of bits in HGEIE
> -        */
> +       /* Set initial value of IMSIC guest files across all HARTs */
>         if (gc)
> -               kvm_riscv_aia_nr_hgei =3D min((ulong)kvm_riscv_aia_nr_hge=
i,
> -                                           gc->nr_guest_files);
> +               atomic_set(&kvm_riscv_aia_nr_hgei, gc->nr_guest_files);
>         else
> -               kvm_riscv_aia_nr_hgei =3D 0;
> +               atomic_set(&kvm_riscv_aia_nr_hgei, 0);
>
>         /* Find number of guest MSI IDs */
>         kvm_riscv_aia_max_ids =3D IMSIC_MAX_ID;
> -       if (gc && kvm_riscv_aia_nr_hgei)
> +       if (gc)
>                 kvm_riscv_aia_max_ids =3D gc->nr_guest_ids + 1;
>
>         /* Initialize guest external interrupt line management */
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index 3d1e81e2a36b..be83c2d5fc30 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -71,7 +71,7 @@ static int aia_config(struct kvm *kvm, unsigned long ty=
pe,
>                                  * external interrupts (i.e. non-zero
>                                  * VS-level IMSIC pages).
>                                  */
> -                               if (!kvm_riscv_aia_nr_hgei)
> +                               if (!atomic_read(&kvm_riscv_aia_nr_hgei))
>                                         return -EINVAL;
>                                 break;
>                         default:
> @@ -628,7 +628,7 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
>          */
>
>         /* Initialize default values in AIA global context */
> -       aia->mode =3D (kvm_riscv_aia_nr_hgei) ?
> +       aia->mode =3D (atomic_read(&kvm_riscv_aia_nr_hgei)) ?
>                 KVM_DEV_RISCV_AIA_MODE_AUTO : KVM_DEV_RISCV_AIA_MODE_EMUL=
;
>         aia->nr_ids =3D kvm_riscv_aia_max_ids - 1;
>         aia->nr_sources =3D 0;
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index cb8a65273c1f..0924c75100a2 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -168,10 +168,6 @@ static int __init riscv_kvm_init(void)
>
>         kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits(=
));
>
> -       if (kvm_riscv_aia_available())
> -               kvm_info("AIA available with %d guest external interrupts=
\n",
> -                        kvm_riscv_aia_nr_hgei);
> -
>         kvm_riscv_setup_vendor_features();
>
>         kvm_register_perf_callbacks();
> @@ -182,6 +178,10 @@ static int __init riscv_kvm_init(void)
>                 return rc;
>         }
>
> +       if (kvm_riscv_aia_available())
> +               kvm_info("AIA available with %d guest external interrupts=
\n",
> +                        atomic_read(&kvm_riscv_aia_nr_hgei));
> +
>         return 0;
>  }
>  module_init(riscv_kvm_init);
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren
