Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68C38B7D4
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553578; cv=pass; b=H6BkoAPVNXamCnsvRvW6SXmDeEnDCDZZImWJQEAk3npcnCGSP++ODGQzECOC3GuYS49FjQZRBCmDuZ2OTMwOZp1V3hMzlt1dqpF3JgCRLn1b7cFmdSpYbwYANdma7ZOwBTTWlW01fm9lRetXiIHz1NQeDKYpAfssGM8VFvmJXNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553578; c=relaxed/simple;
	bh=QIHewWiQEd61HA7Mmg7KNN+mP4kdWOiZure+JhsBAgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxNdM6r4VJsx2Zdoxz0tyZsISouZ2SfOlSWmiSMR29gETAP8zvWPDbq/rbdfM5dBcljJZhECI3aCwLjeKTXmEq9H+UGHNHVF8drp4pzkBZIjjxwT4CgoWlumc+Wr8jXv2CVKiESjNesZYv1dchIQvrrHoCAwEqGcNaiZy6ysB9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=qQYRRXGY; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="qQYRRXGY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7872abb6so574695f8f.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786553574; cv=none;
        d=google.com; s=arc-20260327;
        b=ms2rcSuMpX8wtJwGT2wbFyDh1/P79fxRCWl9zNlupYWNhGwtbjfUL/+41udAxozwqK
         y6Mx3dNURazFcC4OM7G4xD8a9Gng26CyJmgmcR3u0h37BiDxi5us/KBKqXsgcWIGGnEx
         3P4MH7FXWq8+T8eGGC+rQQxzsQqjJdcScAvTxAfCgee4ncsqPWKRFHyPvjD3UtuHBysn
         MjDFhR5rcuXQRJZzIXlK/LY9eE/8wQsw95OZ+4cpC8jGVH9FOLrdNhTFZK1erKPrYD9b
         SDYF8mvLNPWKNkEzsZ4qD49xwsun6/DiEt6qdMHreymM30iKSecNdKx9VvDMROnLaHEY
         M6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p2tfGhzNtiYOtRkK4vl7+6QXSEzurfR+koaEcGL1jZE=;
        fh=G4G45agfqas8FCsFudQC96zEn2WrhBSelpj7Vxmdhcs=;
        b=IuXBb4CbqlfrD9Fga5xvph3e1Q5hDIN/N2Yi6X1mqcg6skeTy7WHWbGXZT06tVGvxe
         h/kqZ0N1Vq2RK36teAqSsZQIyfbZX8mRI16Oi+NZ36HzK4XALCjsS0jPg+yEw79tNrsQ
         zB1l5LRiF6BFZ3SMTVCjgYHtARJMzMETawWi8C5NP4WtyO685DQ9yUicYzUpIGWgANfQ
         Irrh4Ybo6rh+nKAnEmtzRp12UZ41eullXGTO04RqSiCQOkHt7fxzWH7XsV2XlXlvFz+T
         7Zg4I/NvbP7GTA0gljmh/QhYfxhSlx8+Q/HacU+5bCVgjLpBtdZLIJ+RDH9fWNTKQjGD
         MA1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786553574; x=1787158374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2tfGhzNtiYOtRkK4vl7+6QXSEzurfR+koaEcGL1jZE=;
        b=qQYRRXGY1q4YRzHEv8uOo4gVa4uzBPTmhB704IjhThT04Y0abcfVPUyBIqJ6zZNV4n
         fNu0QlPpiq+pTIAtxcBuFvsit45DpxYcY/ypPWJsq0JBjnv5xEAyx/US2qgocPVwo0xB
         2YIYgAmuGOVW7wCq6kR3jj7XssBjCdTFJTIhDef/BlxLp7AcMYmo12oZh70fEpQkrIaY
         zNCun80J48+wbkal+uemgz72+IlFRwhCHgpNi2F9/jmkxWgxazWxP+/utW6w09qMMRl5
         QQZh3Kbx+BKH02RNElZdV5XJa554M+8e7nKnMv9AWI+oAzteQpVbmbYi3vqUIRsRNS83
         WDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553574; x=1787158374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2tfGhzNtiYOtRkK4vl7+6QXSEzurfR+koaEcGL1jZE=;
        b=Sa4LIn3k+oYw5EoQPEHlHzmfvSiKBgENhpQd+y4LxhdYfXvdEcKbRgfBGRiP8622Gx
         MzixkZ5ycbtaRzhTDMmMQ6KsFrHrofhSy/yOF/Nop+j6CX1gzQ/aAqF6VmHlIPlwyGQk
         gQNrixjPWTafhUf4c5Ygnc0L5iYvOepmZGcIRikM58+y/9CwU8J8EKQKo6Ppl4+eyO2C
         kLCOTJJsly2RvjXpxVWRgipn0h9os4mb55Hq1viIxRrbBY9x+1xwdof1io1n3rje9toY
         OdxNL+SLQU3SJlVdifY7+N8dUiJAzCZdr+TN7/8hDzcaB+dHBb+EFJTgM/QJ3LWEqP6d
         S5kg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/hxAFudWE/UECcB540lQwmfip1olA4ZgI+kXKdAINft3uMESVXQAWik41wYttcK8nrno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo93RXlmFbb/x8HWLh1yK3uZqhXH2HyLdKjfoI6EVafBqy2poo
	ZirO2IRA5Yz+Luq8/uPYDjQqYE2uL8zvSjwJKC7uDOTMuOwgEeb3Qkb7p64CpLdvOG+I7OCAqjf
	ZqVgSBwx6eVNXCFJ+Uza0WyWh9cmffPO1KLrgXZPWag==
X-Gm-Gg: AR+sD11XcNos8It5+qzC1pv1qQVPdOZZ78zMi/a8qlnejNlAZS/2B24wskLB27BNCJe
	nCTOglj/6cenKfb+tih7qt7ZfpjEuCxAj4iwLmzxPDFFiuq6jyo3AOiOPkhD2k83/9sxUxjj267
	xUmcfqAxXggAnmN9/c2rJsw59EYZjddb/aSEUvzcRg7dCWABppBvR2lcqvjzuLwv6R0Jh7Mq3UE
	HHz2IDtqi6+z67Gl/snnjltP9YyGYfhCyxicQXeuH7pwzxI/+VosneqXbQ6eyHUHjCnpdybmgnt
	+jnW/9HyKIXk6JjZUAkih41I9fqLOi6+2XNfwWluC5rgTQQTIZK6KXoFlJrANxYPxKL9ciXVQlc
	eil7Ulzmz/ijAusN0T1NSya13DPk2xDEFXxZl+ySAM38Zod4fYwM6EsGdYqTOXu4S
X-Received: by 2002:a05:6000:4011:b0:478:19e7:22a2 with SMTP id
 ffacd0b85a97d-48152c81df8mr8679672f8f.25.1786553573700; Wed, 12 Aug 2026
 09:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-kvm-cpu-pm-v5-1-6c9e4c95caf5@sifive.com>
In-Reply-To: <20260810-kvm-cpu-pm-v5-1-6c9e4c95caf5@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 12 Aug 2026 22:22:40 +0530
X-Gm-Features: AUfX_mzH10RZ48YkvPdeMAY0SaYWsaG_1mHWBKUjmW_GgUEzsEPe5bFnM0PU-Hs
Message-ID: <CAAhSdy1MSUV_A7Fgrtwa4YgdmETdvCFPXnx6BX2_noJtrR=Cpw@mail.gmail.com>
Subject: Re: [PATCH v5] KVM: RISC-V: Add CPU PM notifier for non-retention
 idle states
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Jinyu Tang <tjytimi@163.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:49=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> Register a CPU_PM notifier to restore hypervisor CSR content during CPU
> non-retention idle states. When a CPU enters a deep idle state that
> powers off the CPU domain, hypervisor CSRs and VS CSRs lose their state
> and must be saved before entry and restored after exit.
>
> This completes KVM's power management coverage for RISC-V:
> - CPU hotplug: handled by kvm_online_cpu/kvm_offline_cpu (cpuhp callbacks=
)
> - System suspend: handled by kvm_suspend/kvm_resume (syscore ops)
> - CPU idle (retention): no action needed, CSRs are retained
> - CPU idle (non-retention): handled by this CPU_PM notifier
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM. I have renamed "saved_value" to "saved_hgeie" at the
time of merging.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
> Changes in v5:
> - Remove patch1 as it was merged.
> - Add per-CPU virtualization state tracking (sashiko)
> - Rename CSR helper functions (Anup)
> - Introduce dedicated PM functions for AIA (Anup)
> - Fix module exit sequence (Anup)
> - Link to v4: https://patch.msgid.link/20260721-kvm-cpu-pm-v4-0-146bf9425=
47d@sifive.com
>
> Changes in v4:
> - Remove the system_state checking (sashiko)
> - Link to v3: https://patch.msgid.link/20260626-kvm-cpu-pm-v3-0-be051aafe=
9ba@sifive.com
>
> Changes in v3:
> - Remove the error kvm_riscv_nacl_disable() call in kvm_riscv_csr_disable=
()
> (sashiko)
> - Unregister CPU PM notifier first in riscv_kvm_exit() (sashiko)
> - Link to v2: https://patch.msgid.link/20260626-kvm-cpu-pm-v2-0-478e5ef8d=
c9b@sifive.com
>
> Changes in v2:
> - Add patch 1 force restore VCPU after power state transitions (sashiko)
> - Added CPU_PM_ENTER_FAILED event handling (sashiko)
> - Optimized HGEIE save/restore with saved_value field (sashiko)
> - Fixed HIE CSR restoration in lightweight idle resume path (sashiko)
> - Link to v1: https://patch.msgid.link/20260624-kvm-cpu-pm-v1-1-52088e127=
a55@sifive.com
> ---
> To: Anup Patel <anup@brainfault.org>
> To: Atish Patra <atish.patra@linux.dev>
> To: Paul Walmsley <pjw@kernel.org>
> To: Palmer Dabbelt <palmer@dabbelt.com>
> To: Albert Ou <aou@eecs.berkeley.edu>
> To: Alexandre Ghiti <alex@ghiti.fr>
> To: Radim Kr=C4=8Dm=C3=A1=C5=99 <radim.krcmar@oss.qualcomm.com>
> To: Andrew Jones <andrew.jones@oss.qualcomm.com>
> To: Nutty Liu <nutty.liu@hotmail.com>
> To: Jinyu Tang <tjytimi@163.com>
> Cc: greentime.hu@sifive.com
> Cc: vincent.chen@sifive.com
> Cc: zong.li@sifive.com
> Cc: kvm@vger.kernel.org
> Cc: kvm-riscv@lists.infradead.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/include/asm/kvm_aia.h |   3 ++
>  arch/riscv/kvm/aia.c             |  42 ++++++++++++++++
>  arch/riscv/kvm/main.c            | 106 ++++++++++++++++++++++++++++++++-=
------
>  3 files changed, 133 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kv=
m_aia.h
> index c67ec5ac0a14..ab03f853e507 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -165,6 +165,9 @@ int kvm_riscv_aia_alloc_hgei(int cpu, struct kvm_vcpu=
 *owner,
>                              void __iomem **hgei_va, phys_addr_t *hgei_pa=
);
>  void kvm_riscv_aia_free_hgei(int cpu, int hgei);
>
> +void kvm_riscv_aia_pm_exit(void);
> +void kvm_riscv_aia_pm_enter(void);
> +
>  void kvm_riscv_aia_enable(void);
>  void kvm_riscv_aia_disable(void);
>  int kvm_riscv_aia_init(void);
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 9a653b4ad40a..0de9b8852ed2 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -25,6 +25,7 @@ struct aia_hgei_control {
>         unsigned long free_bitmap;
>         struct kvm_vcpu *owners[BITS_PER_LONG];
>         unsigned int nr_hgei;
> +       unsigned long saved_value;
>  };
>  static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
>  static int hgei_parent_irq;
> @@ -553,6 +554,47 @@ static void aia_hgei_exit(void)
>         free_percpu_irq(hgei_parent_irq, &aia_hgei);
>  }
>
> +void kvm_riscv_aia_pm_exit(void)
> +{
> +       struct aia_hgei_control *hgctrl;
> +
> +       if (!kvm_riscv_aia_available())
> +               return;
> +
> +       hgctrl =3D this_cpu_ptr(&aia_hgei);
> +       csr_write(CSR_HGEIE, hgctrl->saved_value);
> +
> +       csr_write(CSR_HVICTL, aia_hvictl_value(false));
> +       csr_write(CSR_HVIPRIO1, 0x0);
> +       csr_write(CSR_HVIPRIO2, 0x0);
> +#ifdef CONFIG_32BIT
> +       csr_write(CSR_HVIPH, 0x0);
> +       csr_write(CSR_HIDELEGH, 0x0);
> +       csr_write(CSR_HVIPRIO1H, 0x0);
> +       csr_write(CSR_HVIPRIO2H, 0x0);
> +#endif
> +       csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
> +       /* Enable IRQ filtering for overflow interrupt only if sscofpmf i=
s present */
> +       if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF)=
)
> +               csr_set(CSR_HVIEN, BIT(IRQ_PMU_OVF));
> +}
> +
> +void kvm_riscv_aia_pm_enter(void)
> +{
> +       struct aia_hgei_control *hgctrl;
> +
> +       if (!kvm_riscv_aia_available())
> +               return;
> +
> +       if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF)=
)
> +               csr_clear(CSR_HVIEN, BIT(IRQ_PMU_OVF));
> +
> +       csr_write(CSR_HVICTL, aia_hvictl_value(false));
> +
> +       hgctrl =3D this_cpu_ptr(&aia_hgei);
> +       hgctrl->saved_value =3D csr_read(CSR_HGEIE);
> +}
> +
>  void kvm_riscv_aia_enable(void)
>  {
>         const struct imsic_global_config *gc;
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 350e4f097d6e..20b516e84e60 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -10,11 +10,14 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/kvm_host.h>
> +#include <linux/cpu_pm.h>
>  #include <asm/cpufeature.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
>  #include <asm/sbi.h>
>
> +static DEFINE_PER_CPU(bool, kvm_riscv_virtualization_enabled);
> +
>  DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>
>  static void kvm_riscv_setup_vendor_features(void)
> @@ -33,14 +36,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
>         return -EINVAL;
>  }
>
> -int kvm_arch_enable_virtualization_cpu(void)
> +/* Initialize hypervisor CSRs - called during CPU online and non-retenti=
on idle resume */
> +static void kvm_riscv_csr_init(void)
>  {
> -       int rc;
> -
> -       rc =3D kvm_riscv_nacl_enable();
> -       if (rc)
> -               return rc;
> -
>         csr_write(CSR_HEDELEG, 0);
>         csr_write(CSR_HIDELEG, 0);
>
> @@ -48,16 +46,11 @@ int kvm_arch_enable_virtualization_cpu(void)
>         csr_write(CSR_HCOUNTEREN, 0x02);
>
>         csr_write(CSR_HVIP, 0);
> -
> -       kvm_riscv_aia_enable();
> -
> -       return 0;
>  }
>
> -void kvm_arch_disable_virtualization_cpu(void)
> +/* Clear hypervisor CSRs - called during CPU offline and non-retention i=
dle entry */
> +static void kvm_riscv_csr_cleanup(void)
>  {
> -       kvm_riscv_aia_disable();
> -
>         /*
>          * After clearing the hideleg CSR, the host kernel will receive
>          * spurious interrupts if hvip CSR has pending interrupts and the
> @@ -70,10 +63,69 @@ void kvm_arch_disable_virtualization_cpu(void)
>         csr_write(CSR_HIDELEG, 0);
>
>         kvm_riscv_clear_former_vcpu();
> +}
> +
> +int kvm_arch_enable_virtualization_cpu(void)
> +{
> +       int rc;
> +
> +       rc =3D kvm_riscv_nacl_enable();
> +       if (rc)
> +               return rc;
> +
> +       kvm_riscv_csr_init();
> +       kvm_riscv_aia_enable();
> +
> +       __this_cpu_write(kvm_riscv_virtualization_enabled, true);
>
> +       return 0;
> +}
> +
> +void kvm_arch_disable_virtualization_cpu(void)
> +{
> +       kvm_riscv_aia_disable();
> +       kvm_riscv_csr_cleanup();
>         kvm_riscv_nacl_disable();
> +
> +       __this_cpu_write(kvm_riscv_virtualization_enabled, false);
> +}
> +
> +static int kvm_riscv_cpu_pm_notifier(struct notifier_block *self, unsign=
ed long cmd, void *v)
> +{
> +       switch (cmd) {
> +       case CPU_PM_EXIT:
> +       case CPU_PM_ENTER_FAILED:
> +               /*
> +                * Only restore hypervisor state if KVM virtualization is
> +                * enabled on this CPU. This prevents unintentional re-en=
abling
> +                * of virtualization after it has been explicitly disable=
d.
> +                */
> +               if (__this_cpu_read(kvm_riscv_virtualization_enabled)) {
> +                       kvm_riscv_csr_init();
> +                       kvm_riscv_aia_pm_exit();
> +               }
> +               return NOTIFY_OK;
> +       case CPU_PM_ENTER:
> +               /*
> +                * Only save and clear hypervisor state if KVM virtualiza=
tion
> +                * is enabled on this CPU.
> +                */
> +               if (__this_cpu_read(kvm_riscv_virtualization_enabled)) {
> +                       kvm_riscv_aia_pm_enter();
> +                       kvm_riscv_csr_cleanup();
> +               }
> +               return NOTIFY_OK;
> +       default:
> +               break;
> +       }
> +
> +       return NOTIFY_DONE;
>  }
>
> +static struct notifier_block kvm_riscv_cpu_pm_nb =3D {
> +       .notifier_call =3D kvm_riscv_cpu_pm_notifier,
> +};
> +
>  static void kvm_riscv_teardown(void)
>  {
>         kvm_riscv_aia_exit();
> @@ -174,17 +226,31 @@ static int __init riscv_kvm_init(void)
>
>         kvm_register_perf_callbacks();
>
> -       rc =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> -       if (rc) {
> -               kvm_riscv_teardown();
> -               return rc;
> +       /* Register CPU PM notifier for CPU idle non-retention states */
> +       if (IS_ENABLED(CONFIG_CPU_PM)) {
> +               rc =3D cpu_pm_register_notifier(&kvm_riscv_cpu_pm_nb);
> +               if (rc) {
> +                       kvm_err("Failed to register CPU PM notifier: %d\n=
", rc);
> +                       goto err_teardown;
> +               }
>         }
>
> +       rc =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> +       if (rc)
> +               goto err_unregister_cpu_pm;
> +
>         if (kvm_riscv_aia_available())
>                 kvm_info("AIA available with %d guest external interrupts=
\n",
>                          atomic_read(&kvm_riscv_aia_nr_hgei));
>
>         return 0;
> +
> +err_unregister_cpu_pm:
> +       if (IS_ENABLED(CONFIG_CPU_PM))
> +               cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
> +err_teardown:
> +       kvm_riscv_teardown();
> +       return rc;
>  }
>  module_init(riscv_kvm_init);
>
> @@ -192,6 +258,10 @@ static void __exit riscv_kvm_exit(void)
>  {
>         kvm_exit();
>
> +       /* Unregister CPU PM notifier */
> +       if (IS_ENABLED(CONFIG_CPU_PM))
> +               cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
> +
>         kvm_riscv_teardown();
>  }
>  module_exit(riscv_kvm_exit);
>
> ---
> base-commit: dfdf1374fdeccb5b7e3d35186228e01ec5ea5f01
> change-id: 20260624-kvm-cpu-pm-94141aecd5fa
>
