Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827A2EB5A6
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786207132; cv=pass; b=GGTmLqvdQ7dMzz/FPyZjMMEWrjAT94qCH3vySHDdlTDcyOZz7HcnLtUezlxEXWQ8VF1+p5aUAzETvoRFUIqgYGOOzTHVljZ4S/oobKO1gXT+I7ZtzM0xBo+TGirdRFPoTRvYupD7VGaA8l0rA5N1ktF4N29ZU1ilcH0mniZ1b2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786207132; c=relaxed/simple;
	bh=V3mwCSOisuOAFKSJ/hNU/2iDOft5AgqCog5vkHBJwdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzQIitoBdRpTyGwnc7gfgcymXsJe92kIwGk1CnzM9nwM2qZJqbtR7tYg+fSGuO6zVLE8ER1/ZUZlBEuwJ7DgD3mt/gcBK28GVsc7FmTmvhu6nGe4G83Q06GPn7a3+QAihCVV3y135Z+qfPGVrISPsV0gIj4T8fZRic40+MDqRec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=p+bWrxly; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="p+bWrxly"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-496b7622a83so4199795e9.2
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 09:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786207129; cv=none;
        d=google.com; s=arc-20260327;
        b=f8XJ5Vbp2aPhP42EtK6YsoVGcMqXWB+WJlXC+bOs+yio8ejppMJez3Li1iG5Yzb+D3
         Fn5RlJ8V+Yf3pq6ScWqejMOiVggBEIh4RdGbvb+YwzaQhh4dSRH1iyYouDqT7Nvhl1Oq
         bYC9ZJGo0DW3lYVcDTHciN+/CBVl+drWe9oUJCU/zAObS/9b4Ec24Naw+Zmj8Vzk40og
         OahCnV/PPdjEfFlj97BSwoYIa5OcB0CyCqjyN1qxAjK6+Zacw6RL4vQQG2y9fReXnRHQ
         7sEiLOJ8gN7F5bdIkPs72SwBdjSH7vNq4f8NQ8cCflbnpEodpxPHsC321vn4dhrk5Wpm
         EYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1JLOSWUS7VC6SfFf4AueEFN6CHwegsOiH8rdZzB9W1o=;
        fh=fxfMCFUOoVVUFbPsArFc6L/3iQO5DHOHyxpDMihpReE=;
        b=Avd96bHd3LQqDWB6DFfmxbqb9P4sX53h8sbtsjDPMshcbHq1QvREqFe+PjYKpxaH+v
         FkmqB41HkpyYAni6SesL7DJVJsbtoZVkrO+Qf84BDl4Ex/w1JPRgUUE71JN21V5CzZSH
         l/IOf3Ubfq/zvGP2ehzB2iW/t0VRrARXlsOOZeGDDsW2hklE7y8M5yuPzhHBWB22j2vw
         1Y9zTQbBkdePrxoz930ucHNLodx7H/oUowZbVQolLLWIUar9wmlFQtJZmyaofKPh+rb8
         sgrdxKBsv7zyMZKZEHOqxloB0wAlXbaoRMUNpq//vUgRgFOJCnt8yP4RVtIBAAXGzPHs
         UdSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786207129; x=1786811929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1JLOSWUS7VC6SfFf4AueEFN6CHwegsOiH8rdZzB9W1o=;
        b=p+bWrxlyW94aGKRvPYMkfTuZKdWS7Of/Q3lynmeB7WyXv9yo1MceBrNu4kblZBIv4Z
         vfkPKCDyubcebJGxNhsIJTMwjsUeSb4Qn6uGBlSMxhriZdlaQm5U3L7O0V/1Z/KHfS+Y
         aE1BtqlpMRdW42hpJYO14cS1m7O18fRELlJRW9y07d1N+fOz2nmvY2MIZpX8Ji2srqZi
         wvfUamocG6UjjXJIi12bLM524s8wB9bKT9PgtMRaf9iZ6MS/HyVGMqo59g58eyT2DmwM
         K4xJfmrbMGsctGFa0tFH9F8aESeG+AAjCyGriiDUX+bbPkQ0hZI8/klzTN88Ll601brU
         Gptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786207129; x=1786811929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JLOSWUS7VC6SfFf4AueEFN6CHwegsOiH8rdZzB9W1o=;
        b=jcSrxEvk5NaJkyyglt20WbWSopQwjvYKylMOVFAvOqyf8h9Wpoi7QgTl5kHpkNCtl6
         7BP+CwOH/pnkhqxLbK1xSgtKCiRZ5DdOOcrMbaKpp/ZXSQjYSgz/skKNHqM1lrh0wn7w
         EV2r7GP1xTewPe9sYD0yMJzNgtpQMfYNBCC2WRa5jQ61WNgaOkIqU2L2m2TsOTZodGTy
         4dva0V8E/0DxrZUqYi16cP7dpm5GGltcIy7qsuHSpXVPcBdAuclt1VdKKd2qznaIN0ZY
         kqWBv1TXeIpLiAJRZF0yJGRJAKzS0HBqPJ8J1YoTTmNAawUy9j8WmshQ7jrPOz6nkikv
         CKxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGoq3fMOrBRDxLnW6EAaJl/M8BeOFPopxDgzLMIFDMMvWFhuu7wdb4VtXXY9+syyyR8qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIMWECGb/1RrAnIVamqPAt4JuV+I4Cx64Khs9fwIeSB6grMqt
	EJsmvJd9Rml7u4RXBj3GjJbTAL/qZ9YdyK8W6D9y3lAIT22iUylk6JZs21SnJ3sgb5ZRlxy3xIU
	BVvNpCzlP2PhB8z2IMXOjJMrGdmQF9OVHCUVC0gu4HA==
X-Gm-Gg: AR+sD13cRDC4JNxbYPUr4tHy/hHNev+tOKTyste0bpUnwXLJy9jTYqErrYl8u6MCDJq
	28aKLp/hJksFLgu4w3iPcfBKaH5qgTgBhtv0ElwK6nPyKho8XV66KvFLJd+V7h8dATxmez38sNW
	b0GXo2Npum46XZmTtAJHY2tXDdOlwxv+L+KNm2z2CM6G5csmbTTpPlQTwu5DOvRHdQ7lDz8vP0S
	E/pJJnrPlUpTijjjgtnN3AjL7JrdigI7X0QO6pFLODTJLBtNvM4o7kS96Yn35jRPe0c1tN5ywTZ
	pqnGV8hOZviF56bgY90AKEhYpju1DMfvz8xQ2bOluCTwDFJIazQ8GUJ/QXjPmoP/KQHip9yoz4S
	odb1sqEn/iVxoX4z8QhRwzmvFvDqmc4bFabBDRqWY+3VS2596AWYIQXO3s42OsaYu
X-Received: by 2002:a05:600c:310b:b0:496:c93d:35d9 with SMTP id
 5b1f17b1804b1-4996194b09dmr94068685e9.6.1786207128487; Sat, 08 Aug 2026
 09:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com> <20260721-kvm-cpu-pm-v4-2-146bf942547d@sifive.com>
In-Reply-To: <20260721-kvm-cpu-pm-v4-2-146bf942547d@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 8 Aug 2026 22:08:36 +0530
X-Gm-Features: AUfX_myBLxawvwoAU1TMJ9RefODtUOyUhvS_Jpnd7OpEDiV8dNTpoGj8m7MLhbY
Message-ID: <CAAhSdy1jD6RjwyhZUf-ZzUNy0kaKECoEbXPCK5w813A+tSmBVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] KVM: RISC-V: Add CPU PM notifier for non-retention
 idle states
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Jinyu Tang <tjytimi@163.com>, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:22=E2=80=AFAM Yong-Xuan Wang
<yongxuan.wang@sifive.com> wrote:
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
> ---
>  arch/riscv/include/asm/kvm_aia.h |  15 +++-
>  arch/riscv/kvm/aia.c             | 144 ++++++++++++++++++++++-----------=
------
>  arch/riscv/kvm/main.c            |  87 ++++++++++++++++++-----
>  3 files changed, 163 insertions(+), 83 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kv=
m_aia.h
> index c67ec5ac0a14..7c1c3250598f 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -165,8 +165,19 @@ int kvm_riscv_aia_alloc_hgei(int cpu, struct kvm_vcp=
u *owner,
>                              void __iomem **hgei_va, phys_addr_t *hgei_pa=
);
>  void kvm_riscv_aia_free_hgei(int cpu, int hgei);
>
> -void kvm_riscv_aia_enable(void);
> -void kvm_riscv_aia_disable(void);
> +/**
> + * kvm_riscv_aia_enable() - Enable AIA support on current CPU
> + * @full_cleanup: true =3D full hardware init (CPU hotplug/module load),
> + *                false =3D lightweight CSR restore (CPU non-retention i=
dle resume)
> + */
> +void kvm_riscv_aia_enable(bool full_cleanup);
> +
> +/**
> + * kvm_riscv_aia_disable() - Disable AIA support on current CPU
> + * @full_cleanup: true =3D full hardware cleanup (CPU hotplug/module exi=
t),
> + *                false =3D lightweight CSR save (CPU non-retention idle=
 entry)
> + */
> +void kvm_riscv_aia_disable(bool full_cleanup);

Instead of re-using kvm_riscv_aia_enable()/disable()
in PM entry/exit path, I suggest keeping these functions
as-is and introduce new kvm_riscv_aia_pm_enter()/exit()
functions.

>  int kvm_riscv_aia_init(void);
>  void kvm_riscv_aia_exit(void);
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index bafb009c5ce5..4cf351f91c64 100644
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
> @@ -532,50 +533,59 @@ static void aia_hgei_exit(void)
>         free_percpu_irq(hgei_parent_irq, &aia_hgei);
>  }
>
> -void kvm_riscv_aia_enable(void)
> +void kvm_riscv_aia_enable(bool full_cleanup)
>  {
> -       const struct imsic_global_config *gc;
> -       const struct imsic_local_config *lc;
>         struct aia_hgei_control *hgctrl;
>         unsigned long flags;
> -       int aia_nr_hgei;
>
>         if (!kvm_riscv_aia_available())
>                 return;
>
> -       gc =3D imsic_get_global_config();
> -       lc =3D (gc) ? this_cpu_ptr(gc->local) : NULL;
>         hgctrl =3D this_cpu_ptr(&aia_hgei);
>
> -       /* Figure-out number of bits in HGEIE */
> -       csr_write(CSR_HGEIE, -1UL);
> -       hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> -       csr_write(CSR_HGEIE, 0);
> -       if (hgctrl->nr_hgei)
> -               hgctrl->nr_hgei--;
> +       if (full_cleanup) {
> +               const struct imsic_global_config *gc;
> +               const struct imsic_local_config *lc;
> +               int aia_nr_hgei;
>
> -       /*
> -        * Number of usable per-HART HGEI lines should be minimum of
> -        * per-HART IMSIC guest files and number of bits in HGEIE.
> -        */
> -       if (lc)
> -               hgctrl->nr_hgei =3D min((ulong)hgctrl->nr_hgei, lc->nr_gu=
est_files);
> -       else
> -               hgctrl->nr_hgei =3D 0;
> +               gc =3D imsic_get_global_config();
> +               lc =3D (gc) ? this_cpu_ptr(gc->local) : NULL;
>
> -       /* Update the number of IMSIC guest files across all HARTs */
> -       aia_nr_hgei =3D atomic_read(&kvm_riscv_aia_nr_hgei);
> -       do {
> -               if (aia_nr_hgei <=3D hgctrl->nr_hgei)
> -                       break;
> -       } while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia_nr_hgei=
, hgctrl->nr_hgei));
> +               /* Figure-out number of bits in HGEIE */
> +               csr_write(CSR_HGEIE, -1UL);
> +               hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> +               csr_write(CSR_HGEIE, 0);
> +               if (hgctrl->nr_hgei)
> +                       hgctrl->nr_hgei--;
>
> -       raw_spin_lock_irqsave(&hgctrl->lock, flags);
> -       if (!hgctrl->free_bitmap_initialized) {
> -               hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ? GENMASK_ULL(h=
gctrl->nr_hgei, 1) : 0;
> -               hgctrl->free_bitmap_initialized =3D true;
> +               /*
> +                * Number of usable per-HART HGEI lines should be minimum=
 of
> +                * per-HART IMSIC guest files and number of bits in HGEIE=
.
> +                */
> +               if (lc)
> +                       hgctrl->nr_hgei =3D min((ulong)hgctrl->nr_hgei, l=
c->nr_guest_files);
> +               else
> +                       hgctrl->nr_hgei =3D 0;
> +
> +               /* Update the number of IMSIC guest files across all HART=
s */
> +               aia_nr_hgei =3D atomic_read(&kvm_riscv_aia_nr_hgei);
> +               do {
> +                       if (aia_nr_hgei <=3D hgctrl->nr_hgei)
> +                               break;
> +               } while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia=
_nr_hgei,
> +                                            hgctrl->nr_hgei));
> +
> +               raw_spin_lock_irqsave(&hgctrl->lock, flags);
> +               if (!hgctrl->free_bitmap_initialized) {
> +                       hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ?
> +                                             GENMASK_ULL(hgctrl->nr_hgei=
, 1) :
> +                                             0;
> +                       hgctrl->free_bitmap_initialized =3D true;
> +               }
> +               raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +       } else {
> +               csr_write(CSR_HGEIE, hgctrl->saved_value);
>         }
> -       raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
>
>         csr_write(CSR_HVICTL, aia_hvictl_value(false));
>         csr_write(CSR_HVIPRIO1, 0x0);
> @@ -587,16 +597,17 @@ void kvm_riscv_aia_enable(void)
>         csr_write(CSR_HVIPRIO2H, 0x0);
>  #endif
>
> -       /* Enable per-CPU SGEI interrupt */
> -       enable_percpu_irq(hgei_parent_irq,
> -                         irq_get_trigger_type(hgei_parent_irq));
> +       if (full_cleanup)
> +               enable_percpu_irq(hgei_parent_irq,
> +                                 irq_get_trigger_type(hgei_parent_irq));
>         csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
> +
>         /* Enable IRQ filtering for overflow interrupt only if sscofpmf i=
s present */
>         if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF)=
)
>                 csr_set(CSR_HVIEN, BIT(IRQ_PMU_OVF));
>  }
>
> -void kvm_riscv_aia_disable(void)
> +void kvm_riscv_aia_disable(bool full_cleanup)
>  {
>         int i;
>         unsigned long flags;
> @@ -609,42 +620,49 @@ void kvm_riscv_aia_disable(void)
>
>         if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF)=
)
>                 csr_clear(CSR_HVIEN, BIT(IRQ_PMU_OVF));
> -       /* Disable per-CPU SGEI interrupt */
> -       csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
> -       disable_percpu_irq(hgei_parent_irq);
>
> -       csr_write(CSR_HVICTL, aia_hvictl_value(false));
> -
> -       raw_spin_lock_irqsave(&hgctrl->lock, flags);
> -
> -       for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
> -               vcpu =3D hgctrl->owners[i];
> -               if (!vcpu)
> -                       continue;
> +       if (full_cleanup) {
> +               /* Disable per-CPU SGEI interrupt */
> +               csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
> +               disable_percpu_irq(hgei_parent_irq);
> +       }
>
> -               /*
> -                * We release hgctrl->lock before notifying IMSIC
> -                * so that we don't have lock ordering issues.
> -                */
> -               raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +       csr_write(CSR_HVICTL, aia_hvictl_value(false));
>
> -               /* Notify IMSIC */
> -               kvm_riscv_vcpu_aia_imsic_release(vcpu);
> +       if (full_cleanup) {
> +               raw_spin_lock_irqsave(&hgctrl->lock, flags);
>
> -               /*
> -                * Wakeup VCPU if it was blocked so that it can
> -                * run on other HARTs
> -                */
> -               if (csr_read(CSR_HGEIE) & BIT(i)) {
> -                       csr_clear(CSR_HGEIE, BIT(i));
> -                       kvm_vcpu_kick(vcpu);
> +               for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
> +                       vcpu =3D hgctrl->owners[i];
> +                       if (!vcpu)
> +                               continue;
> +
> +                       /*
> +                        * We release hgctrl->lock before notifying IMSIC
> +                        * so that we don't have lock ordering issues.
> +                        */
> +                       raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +
> +                       /* Notify IMSIC */
> +                       kvm_riscv_vcpu_aia_imsic_release(vcpu);
> +
> +                       /*
> +                        * Wakeup VCPU if it was blocked so that it can
> +                        * run on other HARTs
> +                        */
> +                       if (csr_read(CSR_HGEIE) & BIT(i)) {
> +                               csr_clear(CSR_HGEIE, BIT(i));
> +                               kvm_vcpu_kick(vcpu);
> +                       }
> +
> +                       raw_spin_lock_irqsave(&hgctrl->lock, flags);
>                 }
>
> -               raw_spin_lock_irqsave(&hgctrl->lock, flags);
> +               raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> +       } else {
> +               hgctrl->saved_value =3D csr_read(CSR_HGEIE);
>         }
>
> -       raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> -
>         put_cpu_ptr(&aia_hgei);
>  }
>
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 350e4f097d6e..b48bbd1855c1 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -10,6 +10,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/kvm_host.h>
> +#include <linux/cpu_pm.h>
>  #include <asm/cpufeature.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
> @@ -33,14 +34,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
>         return -EINVAL;
>  }
>
> -int kvm_arch_enable_virtualization_cpu(void)
> +/* Initialize hypervisor CSRs - called during CPU online and non-retenti=
on idle resume */
> +static void kvm_riscv_csr_enable(void)

s/kvm_riscv_csr_enable/kvm_riscv_csr_init/

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
> @@ -48,16 +44,11 @@ int kvm_arch_enable_virtualization_cpu(void)
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
> +static void kvm_riscv_csr_disable(void)

s/kvm_riscv_csr_disable/kvm_riscv_csr_cleanup/

>  {
> -       kvm_riscv_aia_disable();
> -
>         /*
>          * After clearing the hideleg CSR, the host kernel will receive
>          * spurious interrupts if hvip CSR has pending interrupts and the
> @@ -70,10 +61,52 @@ void kvm_arch_disable_virtualization_cpu(void)
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
> +       kvm_riscv_csr_enable();
> +       kvm_riscv_aia_enable(true);
>
> +       return 0;
> +}
> +
> +void kvm_arch_disable_virtualization_cpu(void)
> +{
> +       kvm_riscv_aia_disable(true);
> +       kvm_riscv_csr_disable();
>         kvm_riscv_nacl_disable();
>  }
>
> +static int kvm_riscv_cpu_pm_notifier(struct notifier_block *self, unsign=
ed long cmd, void *v)
> +{
> +       switch (cmd) {
> +       case CPU_PM_EXIT:
> +       case CPU_PM_ENTER_FAILED:
> +               kvm_riscv_csr_enable();
> +               kvm_riscv_aia_enable(false);
> +               return NOTIFY_OK;
> +       case CPU_PM_ENTER:
> +               kvm_riscv_aia_disable(false);
> +               kvm_riscv_csr_disable();
> +               return NOTIFY_OK;
> +       default:
> +               break;
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block kvm_riscv_cpu_pm_nb =3D {
> +       .notifier_call =3D kvm_riscv_cpu_pm_notifier,
> +};
> +
>  static void kvm_riscv_teardown(void)
>  {
>         kvm_riscv_aia_exit();
> @@ -174,22 +207,40 @@ static int __init riscv_kvm_init(void)
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
>  static void __exit riscv_kvm_exit(void)
>  {
> +       /* Unregister CPU PM notifier */
> +       if (IS_ENABLED(CONFIG_CPU_PM))
> +               cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
> +
>         kvm_exit();

The sequence in riscv_kvm_exit() should be mirror image of
riscv_kvm_init() so cpu_pm_unregister_notifier() must be done
after kvm_exit().

>
>         kvm_riscv_teardown();
>
> --
> 2.43.7
>

Regards,
Anup
