Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7E282F01
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779757705; cv=none; b=owJUp/uBkQhzr7Z5qpFKkGOZzJ44nJS3LOqJxhV6EWU9m+umxLyDcf1YbMDTgncDBm/T5in4LZIQKwRGoV/w3HXuzAy899gjRFQFErMLEi23XHNmyd2fWGaWBo7Sl7OZsV5POf5MjTQRXJIXx7BsMKRw/TcdSJ/ZNB2Av/gaWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779757705; c=relaxed/simple;
	bh=Jy11MNFH2h5/stm5ZzS7kGdrF3WKoh6w1m67LfVZX0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD8CIH705M/xfP7YMLwp8/7CW0C5FdZdS5A2g3FHo2H5Ft5DDXfQb7G8B7GTxl1qh4c0mpce0UNPX3prIkP5i55o8W71X+IkamU6P41xGgKKyPBx4PGlJQ7E1htE/Qw+isqqtFkvY4Mqy7onPClDcI8O5uaR4e9KnD/JcK1rUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDbRhUk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDbRhUk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1C51F0155E
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779757704;
	bh=YnNKYuPx4r/TNr+SFNfgkdlZ1+hNXcuQvEpHL3F5H3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RDbRhUk7IiaZ5KisPw3twVJKkle8rEU8V7DS6JFsZvPBB9mSM682siq3ak6qrT6ip
	 xPtBiuGg4vXTtw3OSj0xt9fsAS7rpGn9Ur2k8LL5lvqGmXon1yAwIuVEUucF/8KOWl
	 KmZODFgM9H1Gzaodj8aiA36E8y2oAVJmM/q9d602MD605yAr9ELGJV5QaBxyRpi/Cu
	 t41lfnQqJfHzwAuc+YIULP+fH3QA4LRV2ulAOipdVdMGFhgRrEM1woey3i22mWo/qP
	 s49S7Ci6vTA3U1k4KyTzB4XXKw3rmFdOn7+oPONbPjSlPBqxeaSuc8C6hZAubUzKar
	 adz9A05WpXMhg==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so28651795e9.0
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 18:08:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+11vgz78yVe7QKt+4v0YYDrqOnXsWoG+3gy7EWntkRHFBk9WwdF2Vu+ctD64TiE12WABg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nVTfaRiW8KS4ch5CPY6TpFcdw6Q1JLTaYeVoMxTtHOYU5Pbk
	lXjXycpK3U3VtyFz5kCjZ29QVIloJnMSKwUhFhRBwDOOtnPjTMBv48VXqryxKXt6Rvl1mlshTtB
	PxZSEqlJDdPUx/mTKLTQiKHv0eiDHfK0=
X-Received: by 2002:a05:600c:35d6:b0:490:4973:91a0 with SMTP id
 5b1f17b1804b1-4904973932amr238052045e9.10.1779757702292; Mon, 25 May 2026
 18:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425005916.3321811-1-guoren@kernel.org> <20260425005916.3321811-2-guoren@kernel.org>
 <CAAhSdy1E+k3whKm0dpgFO9J6DdMhAv0ojGc9rfPVKTt8zZW_xg@mail.gmail.com>
In-Reply-To: <CAAhSdy1E+k3whKm0dpgFO9J6DdMhAv0ojGc9rfPVKTt8zZW_xg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 26 May 2026 09:08:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSO1T2-vfA61wKTc9OVfBJmoNE9a+UEeLgth0fhVEidkA@mail.gmail.com>
X-Gm-Features: AVHnY4INRpApw1CofJDN4dczPrz1u7qQHMoIGuuRBleWEhFkHq5jV1o13O-_Ddw
Message-ID: <CAJF2gTSO1T2-vfA61wKTc9OVfBJmoNE9a+UEeLgth0fhVEidkA@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] RISC-V: KVM: AIA: Make HGEI number and management
 fully per-CPU
To: Anup Patel <anup@brainfault.org>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	cp0613@linux.alibaba.com, fangyu.yu@linux.alibaba.com, gaohan@iscas.ac.cn, 
	inochiama@gmail.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, me@ziyao.cc, 
	palmer@dabbelt.com, pjw@kernel.org, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 1:23=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Sat, Apr 25, 2026 at 6:29=E2=80=AFAM <guoren@kernel.org> wrote:
> >
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > Previously the number of Hypervisor Guest External Interrupt (HGEI)
> > lines was stored in a single global variable `kvm_riscv_aia_nr_hgei`
> > and assumed to be the same for all HARTs. This assumption does not
> > hold on heterogeneous RISC-V SoCs where different cores may expose
> > different HGEIE CSR widths.
> >
> > Introduce `nr_hgei` field into the per-CPU `struct aia_hgei_control`
> > and probe the actual supported HGEI count for the current HART in
> > `kvm_riscv_aia_enable()` using the standard RISC-V CSR probe
> > technique:
> >
> >     csr_write(CSR_HGEIE, -1UL);
> >     nr =3D fls_long(csr_read(CSR_HGEIE));
> >     if (nr)
> >         nr--;
> >
> > All HGEI allocation, free and disable paths (`kvm_riscv_aia_free_hgei()=
`,
> > `kvm_riscv_aia_disable()`, etc.) now use the per-CPU value instead of
> > the global one.
> >
> > The early global `kvm_riscv_aia_nr_hgei` is kept only for deciding
> > whether SGEI interrupt registration is needed; the real per-HART
> > initialization of lock and free_bitmap is moved to enable time.
>
> We should keep the `kvm_riscv_aia_nr_hgei` to imply two things:
> 1) Minimum number of HGEI lines available across all HARTs
> 2) Non-zero kvm_riscv_aia_nr_hgei means HGEI is enabled
>
> The PATCH2 is redundant and must be droped. I will take care
> care of this at the time of merging.
Okay.

>
> >
> > This makes KVM AIA robust on big.LITTLE-style and multi-vendor
> > asymmetric platforms.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> >  arch/riscv/kvm/aia.c | 40 ++++++++++++++++++++++++----------------
> >  1 file changed, 24 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> > index 5ec503288555..a23729052cfb 100644
> > --- a/arch/riscv/kvm/aia.c
> > +++ b/arch/riscv/kvm/aia.c
> > @@ -23,6 +23,7 @@ struct aia_hgei_control {
> >         raw_spinlock_t lock;
> >         unsigned long free_bitmap;
> >         struct kvm_vcpu *owners[BITS_PER_LONG];
> > +       unsigned int nr_hgei;
> >  };
> >  static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
> >  static int hgei_parent_irq;
> > @@ -452,7 +453,7 @@ void kvm_riscv_aia_free_hgei(int cpu, int hgei)
> >
> >         raw_spin_lock_irqsave(&hgctrl->lock, flags);
> >
> > -       if (hgei > 0 && hgei <=3D kvm_riscv_aia_nr_hgei) {
> > +       if (hgei > 0 && hgei <=3D hgctrl->nr_hgei) {
> >                 if (!(hgctrl->free_bitmap & BIT(hgei))) {
> >                         hgctrl->free_bitmap |=3D BIT(hgei);
> >                         hgctrl->owners[hgei] =3D NULL;
> > @@ -486,21 +487,8 @@ static irqreturn_t hgei_interrupt(int irq, void *d=
ev_id)
> >
> >  static int aia_hgei_init(void)
> >  {
> > -       int cpu, rc;
> > +       int rc;
> >         struct irq_domain *domain;
> > -       struct aia_hgei_control *hgctrl;
> > -
> > -       /* Initialize per-CPU guest external interrupt line management =
*/
> > -       for_each_possible_cpu(cpu) {
> > -               hgctrl =3D per_cpu_ptr(&aia_hgei, cpu);
> > -               raw_spin_lock_init(&hgctrl->lock);
> > -               if (kvm_riscv_aia_nr_hgei) {
> > -                       hgctrl->free_bitmap =3D
> > -                               BIT(kvm_riscv_aia_nr_hgei + 1) - 1;
> > -                       hgctrl->free_bitmap &=3D ~BIT(0);
> > -               } else
> > -                       hgctrl->free_bitmap =3D 0;
> > -       }
> >
> >         /* Skip SGEI interrupt setup for zero guest external interrupts=
 */
> >         if (!kvm_riscv_aia_nr_hgei)
> > @@ -545,9 +533,29 @@ static void aia_hgei_exit(void)
> >
> >  void kvm_riscv_aia_enable(void)
> >  {
> > +       struct aia_hgei_control *hgctrl;
> > +
> >         if (!kvm_riscv_aia_available())
> >                 return;
> >
> > +       hgctrl =3D this_cpu_ptr(&aia_hgei);
> > +
> > +       /* Figure-out number of bits in HGEIE */
> > +       csr_write(CSR_HGEIE, -1UL);
> > +       hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> > +       csr_write(CSR_HGEIE, 0);
> > +       if (hgctrl->nr_hgei)
> > +               hgctrl->nr_hgei--;
>
> For completness of this patch, we should also have the following:
>
>     if (gc)
>         hgctrl->nr_hgei=3D min((ulong)hgctrl->nr_hgei, gc->nr_guest_files=
);

Thanks for the review!

On keeping kvm_riscv_aia_nr_hgei as the minimum across all HARTs:

I agree to keep kvm_riscv_aia_nr_hgei as a non-zero indicator for HGEI
enablement. However, I have a concern about making it track the
per-HART minimum. The purpose of this patch is precisely to let each
HART use its own nr_hgei independently, so heterogeneous HARTs with
more HGEI lines are not artificially limited by weaker ones.
Collapsing that back into a global minimum would partially defeat the
goal.

ref: global->nr_guest_files =3D min(global->nr_guest_files,
local->nr_guest_files);


>     else
>         hgctrl->nr_hgei =3D 0;
>
> Also, over here we should check and update kvm_riscv_aia_nr_hgei
> to keep it minimum accross HARTs:
>
>   if (hgctrl->nr_hgei && hgctrl->nr_hgei < kvm_riscv_aia_nr_hgei)
>     kvm_riscv_aia_nr_hgei =3D hgctrl->nr_hgei;
>
> > +
> > +       if (hgctrl->nr_hgei) {
> > +               hgctrl->free_bitmap =3D BIT(hgctrl->nr_hgei + 1) - 1;
> > +               hgctrl->free_bitmap &=3D ~BIT(0);
> > +       } else {
> > +               hgctrl->free_bitmap =3D 0;
> > +       }
> > +
> > +       raw_spin_lock_init(&hgctrl->lock);
> > +
> >         csr_write(CSR_HVICTL, aia_hvictl_value(false));
> >         csr_write(CSR_HVIPRIO1, 0x0);
> >         csr_write(CSR_HVIPRIO2, 0x0);
> > @@ -588,7 +596,7 @@ void kvm_riscv_aia_disable(void)
> >
> >         raw_spin_lock_irqsave(&hgctrl->lock, flags);
> >
> > -       for (i =3D 0; i <=3D kvm_riscv_aia_nr_hgei; i++) {
> > +       for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
> >                 vcpu =3D hgctrl->owners[i];
> >                 if (!vcpu)
> >                         continue;
> > --
> > 2.43.0
> >
>
> Regards,
> Anup



--=20
Best Regards
 Guo Ren
