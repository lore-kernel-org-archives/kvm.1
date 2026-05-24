Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2818285066
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779600240; cv=pass; b=M3A2kqbpeQOYJkkhBmm7omoHRnlsepRHIAUEXOWwZRt55qymjjavUzdhjlt66AzltYXTixFFwHO+kpS5tgiA3y8X+O3Nqvx1+yxfHBnxvoaKrfBrNBtprVo120Cc67v219aw9wSnJjHOQQGAVHeFb4PO33SWeEcUm6seFZo+ujY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779600240; c=relaxed/simple;
	bh=Eopx750WVoBwB4WCJWW83n+ga5EbZfJTe9hwIKn1MgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ifct/fAM5/lGC81hSGxjrWCo/Hn6LfjsRWQ0I91JFGnAipSgTKKKsdngG/Ce91vAXb/yPOsBdgVn5odNKmfttGgUXeOl1zhHshXAzH6nxy6ms3PrXuASH9m3eX+TzrfvxxxmLfhriyjvtQtf7KM/kKPUPLPdQe+KPPpMiRqxr7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=v8kkn10g; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="v8kkn10g"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d60694c9bso2377679eaf.2
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 22:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779600236; cv=none;
        d=google.com; s=arc-20240605;
        b=KYC/0V/oNs+CF0w/p8l+P1UOhI5TD6+ElFpXDEBfKnoxafBFjHLob4+cvUCFXeV3zD
         rGbLOiUBh/0XN6NJ+EIIJyf+LuovkOLt9fObzgQu+KckEA202tYAlLJA6DgRVEZurxYa
         fNnpc2lV7/AsxUvs5zNmbY4fdsbgBOZ5F1Dq3qj5ZBBjMp0rOuFBMofw9Tgph3LNI6+J
         pDi+R5yDuJMBRzkxYAR2Tf+SpFUWq/vWK2iXdT9Iuy/F8EYIR+Ms1Pg3xDNXTEiux0Qw
         Fx/OpPhi0fHMn9fQmcRcevHPy+DO3c27libG8XWaBUils+Jt9CnChyvLGKusQ2eO5i4m
         6FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TlsDSTzRWDaQ++yneqT1aqZ8P2+n7UdjaBbJTpkbfU0=;
        fh=/JEJqJWDXNaq0tSlaWZ75Jk/+kHUpBiNWi8dZgNfVPY=;
        b=KXPuAadEJGvZl8m70qzXmGu5L90V98ZfNmSm3mzQGq6oa15v6f1ke5s/0RFz+HDADz
         dcC0Gmi1bCQaoqOHNGLDJezT6hopkERY2k5Dw9gTup0fFPyt79R815sCVJJR6z+TVBB7
         Xxs4kEt0S6HPMjjc9ojJT8frps4xYeUgQqbDzzNo8M5N+P6rzE9AN114zsLOvcKJUofM
         jjeHLPpU3AQcTpSfsmRM4RcjLVFndMv7tZuEwXEiJa+HPSMxxKdrhkVvJZhwbOxUNMpD
         yGdZHJJV2bpEI59tYqZtBZxxHgajxHd0m8sqON0KDsYTeuLDQI6sXDgNXiQ6eOsGIvPo
         OWmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1779600236; x=1780205036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlsDSTzRWDaQ++yneqT1aqZ8P2+n7UdjaBbJTpkbfU0=;
        b=v8kkn10glY91FJDzRXzeUue/f1+0hJMQYl47Hq1grKfCKsq8ff4vjd4drTAWS5K83k
         FcKx+2EsHALq6IHF8PwZXl51AMzk0vZM2z3dXh8+lC1f/+hRV+QlBYAwbVICEMqtav/c
         hdbZr3KP+EbxaFEqLlY18l9+E025828T2ogeFQs8bTqA/YxQUx4lSEJIA8VUqDQEkt29
         gd8oq883Y2UN2o4G+U3REL+/Fm2X6wiVA1UnXtRFOgLp79CNbI+O+Xhe8b/qVgVfFxGR
         dmchXfp3Dnue0rm591/7L3wPBecD0yj/swg4PGXSMXM3hoGO0bTaTWRaB2lNS2DkZut8
         XqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779600236; x=1780205036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TlsDSTzRWDaQ++yneqT1aqZ8P2+n7UdjaBbJTpkbfU0=;
        b=bhFh81HSB3vPKk2UQDqKaOburlOFy41HdCSp0BfOOwosufciQM5Xk6SUtd5jxW3A5t
         klKRdWzVjKTykvM9Yo5mJBKIxuy5gJIifcrYASB6qxa3DNV+fTfFsteQmOPbcqEDWHt6
         Wg1hdmnBNgq1LVcEt+ux+ks5TgTWblmT7gyOefyo1zGKWKkFD8Qsu2xsd0j2YwYTMXAX
         XKj2X5bPuBXUBYCpatb7wb8975B13Q6eGehp28JQBWp+rQlJdAbT/x2AYl77nNdHNoBg
         bWkgObrMZfeafGvNQBss0GDIPUFi8wahjO/ATVWdOSiDaboEr/zj/CMmKDycol/MPu7D
         LcnA==
X-Forwarded-Encrypted: i=1; AFNElJ/ojuNOkG8pVqMkmhCnxro8Ihu6Y61tlav7e80Bqc8Axemv/gtHroUVJB0wU7tQ7LdZSIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rHSaoakD03+98SKxnwvbjGhlkaB+KmM+PF5zdTJ72BjFmIFY
	dwVXIJ1b+qdUMxUxdHz+xj4F5Gcu33QtvEg2hwLulKm5xzUcM7O3Tbvyo2OEdr5PFCFQpoBhQYV
	lTWqkw7/hKRfS5fw/55xY9CX6uBpZ2ZZB10D4exE80w==
X-Gm-Gg: Acq92OE/fiV1KtMYlyQOEZXroyBgPrRy/mCbi6MMUVhs+GAQFnKfqok8Y0K/XzoDbm/
	uv4Sp3862PvV46e9uSHjTPudB7l9Qe+7kptyJrutefjEQJoz4XF5b+nQCQwyAAWqJ+vg63D+/0G
	pYFzLrSrXDl74d7gRhNIYvD0dZfiuC68FZ0utkJOSxFR8SqtLDw6DyDNEkZnd3TY3/RQqKBQizz
	itNPg7x9JmcYlNDPfDpF/UkBKz/rei4J36+dDQO/7yiM+H8TUa7xjMokCLfyuJUhq0wDXSde7bu
	ZvIUo8LG9lhyyYpB2a7TM/5EvLJl225MbWfv+pD/rDyfPD0kO2yFD2ZF47C49kKU2HADhjPeP/X
	+N1LMJ8SR+sTmYlF/Wk1BmIW+2lE/tFqVNm0fyg==
X-Received: by 2002:a05:6820:809:b0:69d:9b54:8578 with SMTP id
 006d021491bc7-69d9b549206mr1744642eaf.3.1779600236536; Sat, 23 May 2026
 22:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425005916.3321811-1-guoren@kernel.org> <20260425005916.3321811-2-guoren@kernel.org>
In-Reply-To: <20260425005916.3321811-2-guoren@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 24 May 2026 10:53:44 +0530
X-Gm-Features: AVHnY4IC08q9kBcQZP_1G1-2LQgJp4Rcy_GebziaWQmr8stCU9wj261jbCraHkA
Message-ID: <CAAhSdy1E+k3whKm0dpgFO9J6DdMhAv0ojGc9rfPVKTt8zZW_xg@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] RISC-V: KVM: AIA: Make HGEI number and management
 fully per-CPU
To: guoren@kernel.org
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	cp0613@linux.alibaba.com, fangyu.yu@linux.alibaba.com, gaohan@iscas.ac.cn, 
	inochiama@gmail.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, me@ziyao.cc, 
	palmer@dabbelt.com, pjw@kernel.org, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 6:29=E2=80=AFAM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Previously the number of Hypervisor Guest External Interrupt (HGEI)
> lines was stored in a single global variable `kvm_riscv_aia_nr_hgei`
> and assumed to be the same for all HARTs. This assumption does not
> hold on heterogeneous RISC-V SoCs where different cores may expose
> different HGEIE CSR widths.
>
> Introduce `nr_hgei` field into the per-CPU `struct aia_hgei_control`
> and probe the actual supported HGEI count for the current HART in
> `kvm_riscv_aia_enable()` using the standard RISC-V CSR probe
> technique:
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
> The early global `kvm_riscv_aia_nr_hgei` is kept only for deciding
> whether SGEI interrupt registration is needed; the real per-HART
> initialization of lock and free_bitmap is moved to enable time.

We should keep the `kvm_riscv_aia_nr_hgei` to imply two things:
1) Minimum number of HGEI lines available across all HARTs
2) Non-zero kvm_riscv_aia_nr_hgei means HGEI is enabled

The PATCH2 is redundant and must be droped. I will take care
care of this at the time of merging.

>
> This makes KVM AIA robust on big.LITTLE-style and multi-vendor
> asymmetric platforms.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  arch/riscv/kvm/aia.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 5ec503288555..a23729052cfb 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -23,6 +23,7 @@ struct aia_hgei_control {
>         raw_spinlock_t lock;
>         unsigned long free_bitmap;
>         struct kvm_vcpu *owners[BITS_PER_LONG];
> +       unsigned int nr_hgei;
>  };
>  static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
>  static int hgei_parent_irq;
> @@ -452,7 +453,7 @@ void kvm_riscv_aia_free_hgei(int cpu, int hgei)
>
>         raw_spin_lock_irqsave(&hgctrl->lock, flags);
>
> -       if (hgei > 0 && hgei <=3D kvm_riscv_aia_nr_hgei) {
> +       if (hgei > 0 && hgei <=3D hgctrl->nr_hgei) {
>                 if (!(hgctrl->free_bitmap & BIT(hgei))) {
>                         hgctrl->free_bitmap |=3D BIT(hgei);
>                         hgctrl->owners[hgei] =3D NULL;
> @@ -486,21 +487,8 @@ static irqreturn_t hgei_interrupt(int irq, void *dev=
_id)
>
>  static int aia_hgei_init(void)
>  {
> -       int cpu, rc;
> +       int rc;
>         struct irq_domain *domain;
> -       struct aia_hgei_control *hgctrl;
> -
> -       /* Initialize per-CPU guest external interrupt line management */
> -       for_each_possible_cpu(cpu) {
> -               hgctrl =3D per_cpu_ptr(&aia_hgei, cpu);
> -               raw_spin_lock_init(&hgctrl->lock);
> -               if (kvm_riscv_aia_nr_hgei) {
> -                       hgctrl->free_bitmap =3D
> -                               BIT(kvm_riscv_aia_nr_hgei + 1) - 1;
> -                       hgctrl->free_bitmap &=3D ~BIT(0);
> -               } else
> -                       hgctrl->free_bitmap =3D 0;
> -       }
>
>         /* Skip SGEI interrupt setup for zero guest external interrupts *=
/
>         if (!kvm_riscv_aia_nr_hgei)
> @@ -545,9 +533,29 @@ static void aia_hgei_exit(void)
>
>  void kvm_riscv_aia_enable(void)
>  {
> +       struct aia_hgei_control *hgctrl;
> +
>         if (!kvm_riscv_aia_available())
>                 return;
>
> +       hgctrl =3D this_cpu_ptr(&aia_hgei);
> +
> +       /* Figure-out number of bits in HGEIE */
> +       csr_write(CSR_HGEIE, -1UL);
> +       hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> +       csr_write(CSR_HGEIE, 0);
> +       if (hgctrl->nr_hgei)
> +               hgctrl->nr_hgei--;

For completness of this patch, we should also have the following:

    if (gc)
        hgctrl->nr_hgei=3D min((ulong)hgctrl->nr_hgei, gc->nr_guest_files);
    else
        hgctrl->nr_hgei =3D 0;

Also, over here we should check and update kvm_riscv_aia_nr_hgei
to keep it minimum accross HARTs:

  if (hgctrl->nr_hgei && hgctrl->nr_hgei < kvm_riscv_aia_nr_hgei)
    kvm_riscv_aia_nr_hgei =3D hgctrl->nr_hgei;

> +
> +       if (hgctrl->nr_hgei) {
> +               hgctrl->free_bitmap =3D BIT(hgctrl->nr_hgei + 1) - 1;
> +               hgctrl->free_bitmap &=3D ~BIT(0);
> +       } else {
> +               hgctrl->free_bitmap =3D 0;
> +       }
> +
> +       raw_spin_lock_init(&hgctrl->lock);
> +
>         csr_write(CSR_HVICTL, aia_hvictl_value(false));
>         csr_write(CSR_HVIPRIO1, 0x0);
>         csr_write(CSR_HVIPRIO2, 0x0);
> @@ -588,7 +596,7 @@ void kvm_riscv_aia_disable(void)
>
>         raw_spin_lock_irqsave(&hgctrl->lock, flags);
>
> -       for (i =3D 0; i <=3D kvm_riscv_aia_nr_hgei; i++) {
> +       for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
>                 vcpu =3D hgctrl->owners[i];
>                 if (!vcpu)
>                         continue;
> --
> 2.43.0
>

Regards,
Anup
