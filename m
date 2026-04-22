Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EE1DF256
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851092; cv=pass; b=M9M2xk9a8q+g06vOcOAFrNr/6zZkMeWJzaoWlmeTI8bnfjz+H1bPVLiR7Ox3HMkwUP8oMjcPN23Ugt4G9j2VqexaS9KuWfwb7V2kkbmruF3wb/TD7XztwSagZpfM7PDxlec3a+wYG/HrtmezmbZaSW8bfPHsuv8GK39HsgZ6tQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851092; c=relaxed/simple;
	bh=Z1/HQj6GbAcQNHToVrifnYatcvDVKjjU5N0JLzsF7e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7Rn5b7cyykSA/mcA8LombyknO8iAkGzeJEjyA50mM95RAmZlSqQFmFzSdCFX59RjwtUg8fAqCZgb7juk/FQ1wF8YhBGLpyyKd3P1VpYRsNtv7rJebmOE3ajTtEMnIMMWOAOdKGNCuLw2N/54gUd3m21IffdP7BVTYMqGQwvui4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=eJPIVxV3; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="eJPIVxV3"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4be94eeacso5254651a34.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 02:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776851089; cv=none;
        d=google.com; s=arc-20240605;
        b=eyiokNr72wsOvXshSxV4cQQvZRut6sx88E+ByTRliygZKK8qz6293M+TU8gd5nLNIc
         nKYt9jNZGNIc8XKof0iau1NbnhqINDeI3p9rlJKmBhgd3HFC/h0sX4GIo90ULRiSXUfD
         A6aQnnR3tfdzjniYZDpw0h1pPYYtPSRvFKXpGerzw9iHOozu9pD2xXOtXFhcetE3bwGy
         1lyf2wFaj29VNaNo8XwyCriQNOUynwYV4uha+mQh1YZcp+YbhLsUo+l4Xq6CXBgZ2rdE
         Bnf8BHS+1hYikWWiviwxlY2eLIbUnk359jJ8Wc5TEbaEQ3oZBw+WXo/c91snJ+kRQNnn
         daLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNohhJuDH0wTzg7Vb48xGyj90V8SdJM+WEkGd1AHVB8=;
        fh=HKR7MFWkOk3FJ25ZVv5h6a4Sj5f0gUZy1+MTLPssKGs=;
        b=FZvq4YuM66X/yg+NFTUa5XLUS4poL1R5WE2I9vIN5lWykZoZfq0YWMQJwHb5Z03xEU
         mi7utsIi45BnXNjS4AJ2xb3hVDt7Vv+Uw3IlLYNwDOWFndJsdVqZVf8dkpTzNJBILTE3
         nUtouXOtDgVvHolM16FuTpSi1tDEpPdoraT3ilTKIzNKy58iuekh95g9GQ7+P3MN9DMD
         atuU83uzJfdxhh+N8c/NGHo7rVhLpp4yrUMJENNrIicWv6dHBdLT9pJG4FW5I6Xk0WXo
         3uRejJhIqMlHxF45R5HpalzyphQ8LrByq2WyOMGPCA5WotHWrJQ09Q1xI8zbEwVqPuHq
         szPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1776851089; x=1777455889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNohhJuDH0wTzg7Vb48xGyj90V8SdJM+WEkGd1AHVB8=;
        b=eJPIVxV3JJo6mRHYPcXbi/gQggMUP5BuwEBo/WftDfV95W2LA71DEKYoIDunP7piC7
         Z+GaxPJhvQsl5uhFawwqRXUmJzymMl9CG3stIJKkRMyvCTzFgb+PZuVrxG4HTC570oGJ
         pr3/O0SmYbGIwGN57GGJsm0TjS4QSAGFrAEEqN/urNVv3ZU2XXkBAJdPmq8IKy9+3595
         iP17nGSht0bzq5qjTsjWDpiUOeTgMvO1b4UMp6VTOkle4un9ZeC1CEKjM12qPk2RxlxQ
         7ec/Gm7ZMNsoZQNR5eglE1miXJ3vx3fxw1k6TKN2Dk/Uqry8PjEl2snVG2tX/yM718MO
         C6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851089; x=1777455889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNohhJuDH0wTzg7Vb48xGyj90V8SdJM+WEkGd1AHVB8=;
        b=rfK/bW+C7ov18E86Pb/tYn8nMUpOpErxiaBs+Rbl3EM61gXDaDgwMPgiKTm8bNZT/Q
         zds6WnbcaIZlShVRmAXE8SyqMTuzUwy5Ba5gGMNwOy5IxSisjVOMk3Da2sswo2MUVLVR
         4ZH4Hm75OAZGNePtDXCUNKbc1ZVPGsdt04rhFzIrvOPS575pfdGy57pXvbQRrEtVZpuB
         HR/8AeAVh0E/3KYyLpLNlCBLy2rZTCwRe5VcACSfoprC9ai0R7whoq2AjvU6YnSNZegz
         7vA9JieZN1qSiqCylsN6EREuDFQu9BBilxjVCPXCaiY3VVaMG9XrhJH9xrRiS/zfGF89
         6ERg==
X-Forwarded-Encrypted: i=1; AFNElJ9hvESk/7n3MsqYH3xpe3RjJrQ2wywKJOioSy9Oz/HRyM6ynKzkq+TXkAx/nC058ktOrFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqAZRlek67bd+bYmoWPC4FUktfJtpMy+QQLDrXuUjEh2Rkoq1
	GpsjQQSU7UdGqH+7oJaDO/onjSe8BLts3LVR8llQlB0P/iJLxBXO7HUXI1x1AWZOXER05yXvXjX
	kunfirPNRNnP2wLjlcsgM267cLxQa3+6o38RR9wocLQ==
X-Gm-Gg: AeBDievjJEU+Sr06RuzPYo2rBLUglgMBxC9EUju8gJTBLJohNNrznns++Zz6tYwUwgY
	kdyjgslIy66Dyu8DVkQtwzRARg7HIxG/K607kgQ7P9HL/00HJ02eoA0G1FcUNHQczyDPY0JyZYS
	9RLNd5JQyS4SjA6GItmhluHgs5/joRA1QPE7vbOG5nDY9CB105M4aUf60j18YDvVPWnMB+/XdR7
	4LP9B1iZr3SiuPJWGBOnF6/ukrLWSJ65goL6Rg10GcvcKE33i7SPYLhWjmu41C1X8jBMO4Y+Gqj
	+5/krz9dIy84D7evmQVo9zFN9Bg5WHUauIF704bxX8+n4IZmdIgr97mNOAjUrRCOEvM5/LmVxJG
	yo7j69JQNgQTSppZ/lnMsnTD1UpbCv6WtkNIJBA==
X-Received: by 2002:a05:6820:6ae3:b0:694:a362:4b8f with SMTP id
 006d021491bc7-694a3624d01mr1461340eaf.6.1776851088816; Wed, 22 Apr 2026
 02:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421145451.1597930-1-guoren@kernel.org> <20260421145451.1597930-4-guoren@kernel.org>
 <CAJF2gTSi_j2LsOSm2MEfz0y38O0MAEEqdYufciGtAhxVOC+U2A@mail.gmail.com>
In-Reply-To: <CAJF2gTSi_j2LsOSm2MEfz0y38O0MAEEqdYufciGtAhxVOC+U2A@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 22 Apr 2026 15:14:37 +0530
X-Gm-Features: AQROBzBB69Ahi7Y0MUFKRhBuneBS0E63Hi9zFKVMzede85aQZNsHr4zAFW-KBcE
Message-ID: <CAAhSdy2RBs15ndXbUMs=k7fw8CH_5+b9k=+o6SNzxpvb-YKDig@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip/riscv-imsic: Remove global nr_guest_files
 after KVM AIA per-HART conversion
To: Guo Ren <guoren@kernel.org>
Cc: fangyu.yu@linux.alibaba.com, cp0613@linux.alibaba.com, inochiama@gmail.com, 
	me@ziyao.cc, gaohan@iscas.ac.cn, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, alex@ghiti.fr, tglx@kernel.org, 
	Albert Ou <aou@eecs.berkeley.edu>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 8:39=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> Hi all,
>
> This patch simply removed `nr_guest_files`, which is suboptimal. For
> v2, I will keep `nr_guest_files` inside `struct imsic_local_config`
> (per-HART) and compute the effective HGEI count in
> `kvm_riscv_aia_enable()` as:
>
> min(hgctrl->nr_hgei, lc->nr_guest_files)

Yes, I was going to comment the exact same thing. Good that you
realized it early.

Regards,
Anup

>
> This provides a more accurate and robust per-HART configuration.
>
> Here are the updated two patches for your review:
>
>     irqchip/riscv-imsic: Move nr_guest_files to per-HART local config
>
>     With the recent KVM AIA per-HART HGEI conversion, the global
>     nr_guest_files is no longer appropriate. Different HARTs in
>     heterogeneous SoCs may have different numbers of guest interrupt
>     files.
>
>     Move `nr_guest_files` from `struct imsic_global_config` to
>     `struct imsic_local_config`, and compute it per-CPU in
>     imsic_setup_state() based on the actual MMIO guest file region size.
>
>     Update the related comment to reflect that KVM now uses the
>     per-HART value.
>
>     This eliminates the last global assumption about guest files and
>     completes the per-HART conversion series for RISC-V AIA/IMSIC.
>
>     Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c
> b/drivers/irqchip/irq-riscv-imsic-state.c
> index e3ed874d89e7..3d455ef43298 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -784,7 +784,7 @@ static int __init imsic_parse_fwnode(struct
> fwnode_handle *fwnode,
>
>  int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
>  {
> -       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_guest_files,
> nr_handlers =3D 0;
> +       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
>         struct imsic_global_config *global;
>         struct imsic_local_config *local;
>         void __iomem **mmios_va =3D NULL;
> @@ -878,7 +878,6 @@ int __init imsic_setup_state(struct fwnode_handle
> *fwnode, void *opaque)
>         }
>
>         /* Configure handlers for target CPUs */
> -       global->nr_guest_files =3D BIT(global->guest_index_bits) - 1;
>         for (i =3D 0; i < nr_parent_irqs; i++) {
>                 rc =3D imsic_get_parent_hartid(fwnode, i, &hartid);
>                 if (rc) {
> @@ -920,13 +919,13 @@ int __init imsic_setup_state(struct
> fwnode_handle *fwnode, void *opaque)
>                 local->msi_va =3D mmios_va[index] + reloff;
>
>                 /*
> -                * KVM uses global->nr_guest_files to determine the
> available guest
> +                * KVM uses local->nr_guest_files to determine the
> available guest
>                  * interrupt files on each CPU. Take the minimum number o=
f guest
>                  * interrupt files across all CPUs to avoid KVM
> incorrectly allocating
>                  * an unexisted or unmapped guest interrupt file on some =
CPUs.
>                  */
> -               nr_guest_files =3D (resource_size(&mmios[index]) -
> reloff) / IMSIC_MMIO_PAGE_SZ - 1;
> -               global->nr_guest_files =3D min(global->nr_guest_files,
> nr_guest_files);
> +               local->nr_guest_files =3D
> +                       (resource_size(&mmios[index]) - reloff) /
> IMSIC_MMIO_PAGE_SZ - 1;
>
>                 nr_handlers++;
>         }
> diff --git a/include/linux/irqchip/riscv-imsic.h
> b/include/linux/irqchip/riscv-imsic.h
> index 4b348836de7a..13e8bd7ff4b4 100644
> --- a/include/linux/irqchip/riscv-imsic.h
> +++ b/include/linux/irqchip/riscv-imsic.h
> @@ -40,6 +40,9 @@
>  struct imsic_local_config {
>         phys_addr_t                             msi_pa;
>         void __iomem                            *msi_va;
> +
> +       /* Number of guest interrupt files per core */
> +       u32                                     nr_guest_files;
>  };
>
>  struct imsic_global_config {
> @@ -68,9 +71,6 @@ struct imsic_global_config {
>         /* Number of guest interrupt identities */
>         u32                                     nr_guest_ids;
>
> -       /* Number of guest interrupt files per core */
> -       u32                                     nr_guest_files;
> -
>         /* Per-CPU IMSIC addresses */
>         struct imsic_local_config __percpu      *local;
>  };
>
> ------------------------
> The other one:
>
>     RISC-V: KVM: AIA: Use per-HART IMSIC guest files to compute final HGE=
I count
>
>     Now that `nr_guest_files` has been moved to `struct imsic_local_confi=
g`
>     and is computed per-HART, KVM must respect the actual number of guest
>     interrupt files available on each HART when setting up HGEI.
>
>     In `kvm_riscv_aia_enable()`:
>
>      - Retrieve the per-CPU IMSIC local config
>      - Take `min(hgctrl->nr_hgei, lc->nr_guest_files)` as the final usabl=
e
>        HGEI count for this HART
>      - Use the result to initialize `free_bitmap`
>
>     This ensures correct HGEI allocation on heterogeneous RISC-V SoCs
>     where different cores may have different IMSIC guest file counts, and
>     completes the per-HART conversion series.
>
>     Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 70ff1d25dd99..a5f4b7fe1dce 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -534,6 +534,9 @@ static void aia_hgei_exit(void)
>  void kvm_riscv_aia_enable(void)
>  {
>         struct aia_hgei_control *hgctrl;
> +       const struct imsic_global_config *gc;
> +       const struct imsic_local_config *lc;
> +       unsigned int nr_hgei;
>
>         if (!kvm_riscv_aia_available())
>                 return;
> @@ -547,8 +550,13 @@ void kvm_riscv_aia_enable(void)
>         if (hgctrl->nr_hgei)
>                 hgctrl->nr_hgei--;
>
> -       if (hgctrl->nr_hgei) {
> -               hgctrl->free_bitmap =3D BIT(hgctrl->nr_hgei + 1) - 1;
> +       gc =3D imsic_get_global_config();
> +       lc =3D (gc) ? this_cpu_ptr(gc->local) : NULL;
> +       if (lc)
> +               nr_hgei =3D min(hgctrl->nr_hgei, lc->nr_guest_files);
> +
> +       if (nr_hgei) {
> +               hgctrl->free_bitmap =3D BIT(nr_hgei + 1) - 1;
>                 hgctrl->free_bitmap &=3D ~BIT(0);
>         } else {
>                 hgctrl->free_bitmap =3D 0;
>
>
> On Tue, Apr 21, 2026 at 10:55=E2=80=AFPM <guoren@kernel.org> wrote:
> >
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > With the recent KVM AIA changes, HGEI line management is now fully
> > per-CPU (via struct aia_hgei_control::nr_hgei) and the global
> > kvm_riscv_aia_nr_hgei has been replaced by a simple enabled flag.
> > The IMSIC driver no longer needs to compute and enforce a global
> > minimum number of guest interrupt files across all HARTs.
> >
> > Remove:
> >  - `u32 nr_guest_files` from `struct imsic_global_config`
> >  - the initial `BIT(global->guest_index_bits) - 1` assignment
> >  - the entire per-CPU MMIO-based min() calculation and its comment
> >    (which was specifically there to protect old KVM)
> >
> > The per-HART guest file count is already handled locally in
> > `imsic_local_config` during the parent IRQ loop, so this global
> > field was redundant.
> >
> > This completes the cleanup series, eliminates the last global
> > assumption about guest files, and improves support for heterogeneous
> > (big.LITTLE / multi-vendor) RISC-V platforms.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> >  drivers/irqchip/irq-riscv-imsic-state.c | 12 +-----------
> >  include/linux/irqchip/riscv-imsic.h     |  3 ---
> >  2 files changed, 1 insertion(+), 14 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/=
irq-riscv-imsic-state.c
> > index e3ed874d89e7..fef27247a34f 100644
> > --- a/drivers/irqchip/irq-riscv-imsic-state.c
> > +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> > @@ -784,7 +784,7 @@ static int __init imsic_parse_fwnode(struct fwnode_=
handle *fwnode,
> >
> >  int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaqu=
e)
> >  {
> > -       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_guest_files, nr_h=
andlers =3D 0;
> > +       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
> >         struct imsic_global_config *global;
> >         struct imsic_local_config *local;
> >         void __iomem **mmios_va =3D NULL;
> > @@ -878,7 +878,6 @@ int __init imsic_setup_state(struct fwnode_handle *=
fwnode, void *opaque)
> >         }
> >
> >         /* Configure handlers for target CPUs */
> > -       global->nr_guest_files =3D BIT(global->guest_index_bits) - 1;
> >         for (i =3D 0; i < nr_parent_irqs; i++) {
> >                 rc =3D imsic_get_parent_hartid(fwnode, i, &hartid);
> >                 if (rc) {
> > @@ -919,15 +918,6 @@ int __init imsic_setup_state(struct fwnode_handle =
*fwnode, void *opaque)
> >                 local->msi_pa =3D mmios[index].start + reloff;
> >                 local->msi_va =3D mmios_va[index] + reloff;
> >
> > -               /*
> > -                * KVM uses global->nr_guest_files to determine the ava=
ilable guest
> > -                * interrupt files on each CPU. Take the minimum number=
 of guest
> > -                * interrupt files across all CPUs to avoid KVM incorre=
ctly allocating
> > -                * an unexisted or unmapped guest interrupt file on som=
e CPUs.
> > -                */
> > -               nr_guest_files =3D (resource_size(&mmios[index]) - relo=
ff) / IMSIC_MMIO_PAGE_SZ - 1;
> > -               global->nr_guest_files =3D min(global->nr_guest_files, =
nr_guest_files);
> > -
> >                 nr_handlers++;
> >         }
> >
> > diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchi=
p/riscv-imsic.h
> > index 4b348836de7a..7f3ff5c5ea53 100644
> > --- a/include/linux/irqchip/riscv-imsic.h
> > +++ b/include/linux/irqchip/riscv-imsic.h
> > @@ -68,9 +68,6 @@ struct imsic_global_config {
> >         /* Number of guest interrupt identities */
> >         u32                                     nr_guest_ids;
> >
> > -       /* Number of guest interrupt files per core */
> > -       u32                                     nr_guest_files;
> > -
> >         /* Per-CPU IMSIC addresses */
> >         struct imsic_local_config __percpu      *local;
> >  };
> > --
> > 2.40.1
> >
>
>
> --
> Best Regards
>  Guo Ren
