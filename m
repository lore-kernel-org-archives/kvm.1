Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964E3FB077
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182861; cv=none; b=cPFF6OTM7fjhtIgPCSSmt+GoQfxm1dq9apfqSJRd9BHPk1TrhBcPSmJPCbXHffADBIcAt4Yj5QjH58aPgILTG6orQyyAW/GYPSCLteP/nt/RcGjH+SU6PADaAZDFzPL2i/MYs/zbhnuZbZS99HEx203RoYD8qnAaMjfKexBXv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182861; c=relaxed/simple;
	bh=0YOHxKDJtE7JUCdcSrUwyxUab8YtMn/ilX+FHdAOQE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGvSnI8x1CjYo/5lrX7DC8ODlmBxz4FbO3ltV3sM5QI7q8YUr3i/1e00L89NBkzC1hBsCglOjtXpj1Qv9dEyIqGxRwpgECCh4aVWuttN0H2MxK0t9tNOKX7FI1z193r8ZpMwkgPV8guMRtazpK9zlBMgiTg5bIRy6ztNTfGMyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B36c6ggD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B36c6ggD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47FA1F00898
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182859;
	bh=pxqLifDJGGZYXoj4VfsxRd6YGJLysVvyhwmhrG2Zi5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B36c6ggDm2VliBV/+axoFvv2OBV9imDY7iqCs91sl0ZWeXdiFAHhZl7PnAQESNnHY
	 GD6LqHOnqpX/pdepIqVax+1+CaOid7XpPOuFDGjT5ilcrLBrgYpa818pFhXbHMK5+M
	 5+SKBXuyVnOz09i29VPmfHIY72JLzR7lQqz9XEGOHuCE64Nkva63A5VH6G44OiPJIj
	 VhX0IVe/N+HdqCWrrCuxwxmYZAFtmbVY2Suun8R9jeL7DuWI54RSRQFUmWlo9GrjRj
	 b6Gawj1hSd4zJn43v7FuDV8+KSaFUQoTljORn2ruC+1/4Rmq0S/iswbXm69gfYjoGF
	 xdfFY37MzXuhA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6924a68e3f3so5316902a12.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:00:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/rz0DWYwqI+5uUeWL5eudLediWuWrKEtS2A0kVIawRRn5lzPibCfKO2kH4uuMVdzw8hnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0cXb2/h9tV2LOUAcE3xEFOS/xWR8XeZ0JYYpoDE+xrtpgryR
	62EuLjXIDXg/Z30Ui4As79p+HUZ4vd51XILQh4l5pAFj7DJfjA3q6nLb7eUoLc/hkJqaBjKXCGI
	DcAIfceSqobsJD5nP5ixJlX/wZl7Dahk=
X-Received: by 2002:a05:6402:3897:b0:687:ece2:aac6 with SMTP id
 4fb4d7f45d1cf-6930e32cf5dmr1380316a12.15.1781182858289; Thu, 11 Jun 2026
 06:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611065815.1439154-1-maobibo@loongson.cn> <20260611065815.1439154-6-maobibo@loongson.cn>
 <CAAhV-H7vMq+-nm8f8aL2CvmNYivaHgWj1cTuyv0BTfPQRKpSJA@mail.gmail.com> <00f28be5-3805-90d1-d2a5-69734b3d0a03@loongson.cn>
In-Reply-To: <00f28be5-3805-90d1-d2a5-69734b3d0a03@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 11 Jun 2026 21:01:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H460mXx5ojv-=Bah5HoMHqy2bDB38uWaXXGkLeDNt8zRg@mail.gmail.com>
X-Gm-Features: AVVi8Ce0q9ZqmjqSIljoivrfPJzG9mEucIizwIMxsOxnMJqWsRqfcisZfh8OSgo
Message-ID: <CAAhV-H460mXx5ojv-=Bah5HoMHqy2bDB38uWaXXGkLeDNt8zRg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] LoongArch: KVM: Add valid bit check when set ESTAT
 CSR register
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:55=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/6/11 =E4=B8=8B=E5=8D=886:10, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Thu, Jun 11, 2026 at 2:58=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> When set ESTAT CSR register in function _kvm_setcsr(), valid bit check
> >> is added here. Also interrupt CPU_AVEC is checked by msgint feature.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/kvm/vcpu.c | 25 ++++++++++++++++---------
> >>   1 file changed, 16 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> >> index e986146d2272..4f67eefbd4f1 100644
> >> --- a/arch/loongarch/kvm/vcpu.c
> >> +++ b/arch/loongarch/kvm/vcpu.c
> >> @@ -602,7 +602,7 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm =
*kvm, int cpuid)
> >>
> >>   static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *=
val)
> >>   {
> >> -       unsigned long gintc;
> >> +       unsigned long gintc, estat;
> >>          struct loongarch_csrs *csr =3D vcpu->arch.csr;
> >>
> >>          if (get_gcsr_flag(id) & INVALID_GCSR)
> >> @@ -621,8 +621,9 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsi=
gned int id, u64 *val)
> >>                  preempt_enable();
> >>
> >>                  /* ESTAT IP0~IP7 get from GINTC */
> >> -               gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) &=
 0xff;
> >> -               *val =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) | =
(gintc << 2);
> >> +               gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) &=
 KVM_GINTC_IRQ_MASK;
> >> +               estat =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) &=
 ~KVM_ESTAT_EXTI_MASK;
> >> +               *val =3D estat | (gintc << VIP_DELTA);
> >>                  return 0;
> >>          }
> >>
> >> @@ -637,7 +638,8 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsi=
gned int id, u64 *val)
> >>
> >>   static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 v=
al)
> >>   {
> >> -       int ret =3D 0, gintc;
> >> +       int ret =3D 0;
> >> +       unsigned long gintc, estat;
> >>          struct loongarch_csrs *csr =3D vcpu->arch.csr;
> >>
> >>          if (get_gcsr_flag(id) & INVALID_GCSR)
> >> @@ -648,11 +650,16 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, un=
signed int id, u64 val)
> >>
> >>          if (id =3D=3D LOONGARCH_CSR_ESTAT) {
> >>                  /* ESTAT IP0~IP7 inject through GINTC */
> >> -               gintc =3D (val >> 2) & 0xff;
> >> -               kvm_set_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> >> -
> >> -               gintc =3D val & ~(0xffUL << 2);
> >> -               kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, gintc);
> >> +               gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC) &=
 ~KVM_GINTC_IRQ_MASK;
> >> +               gintc |=3D (val >> VIP_DELTA) & KVM_GINTC_IRQ_MASK;
> >> +               kvm_write_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> > I think read & write can be combined, which means it can be simplified =
as:
> >                  gintc =3D (val >> VIP_DELTA) & KVM_GINTC_IRQ_MASK;
> >                  kvm_set_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> >
> >> +
> >> +               /* only set valid ESTAT bits */
> >> +               estat =3D val & ~KVM_ESTAT_EXTI_MASK;
> >> +               estat &=3D CSR_ESTAT_IS | CSR_ESTAT_EXC | CSR_ESTAT_ES=
UBCODE;
> >> +               if (!kvm_guest_has_msgint(&vcpu->arch))
> >> +                       estat &=3D ~CPU_AVEC;
> >> +               kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat);
> > I think write csr may lose bits from the original value, so
> >                  kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat)
> > should be
> >                  kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat)
> >
> > If you agree, I will change it when I apply because all others look goo=
d to me.
> At the beginning, it is kvm_set_sw_gcsr() with CSR_GINTC/CSR_ESTAT,
> later I change it with kvm_write_sw_gcsr(). With kvm_set_sw_gcsr() API,
> it is only set new interrupt, however does not clear the interrupt. So I
> change it with kvm_write_sw_gcsr() which will overwrite the interrupt bit=
s.
>
> At the same time, bit field CSR_ESTAT_EXC | CSR_ESTAT_ESUBCODE is not
> suitable for bit set, overwrite its value is more suitable.
OK, then I will keep using kvm_write_sw_gcsr(), and please update the
selftest series if needed.

Huacai

>
> Regards
> Bibo Mao
>
> >
> > Huacai
> >
> >>
> >>                  return ret;
> >>          }
> >> --
> >> 2.39.3
> >>
>
