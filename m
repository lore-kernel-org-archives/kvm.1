Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EAB3624B7
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253570; cv=none; b=cqWCbH5L+MbwmUDyrudC+0R7eNTcZd0ZkKD75RRkJf0uvsCy0/7puC3A47rdBdmr7dTc4+F59S838rM1G65GY+Np1bP4mscrGVh8LPESGm5XTs6CcOuogHgG2pwKaSWWNVFIaA/M+58K1wCG9HtYH2LP4ADIYioaslVqU4Pn05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253570; c=relaxed/simple;
	bh=r+yOxBIHFz8TEnksmcfjlPJLwwVtXaJgcGosVo4cP1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzxMsPBY4hYHuW9NeT5mw880YocQMioWg058lUQt6ysdnNmIr1ySLpo4bfDwCOrvZ/JegiYq4Sfp8lSxr5sHadDH8u5TKGgIAbtnyHO8wxuy7AEytkYCZkUf7f3T1L4dHaKrup3YGhUTuWfPU2n5GhRw0sX0WknBiMZ1dp7D2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YihYbq79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YihYbq79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8391F00A3E
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253569;
	bh=ifx+zSnu/M34z0R+o3TEU5+5UvEwcD6nbk1E60RbwCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YihYbq797SsMayFJJ73fv1AAY180wYqANIN6ziA7issUhS2aMWWHBRopq/GRM8SkF
	 Z+KXCLlJMfcVVlNbGR49EB5HVcZps4UcoEh0oUTlJnIXfn3mREigzQJE5gwTBSCVlg
	 pTdQGf2BsmQ/KNiMdH7hHx6FV0x5RjmXq8VW1B13TKEzttMFmUuAFLBpV68VGajk4T
	 +/HTXOkJvvFoHc/d2oJfmQ93dL/w65Qyg32uV3wWqQoSFrORGpLCMxWFToZjliLbeB
	 nvinvaz9ex2ZRPlo8CPzd2I1U6Avf2AdPSQ91aF/DtKUpJ37VzJf5jtERVZQanV6/l
	 3Ge8oQAj1F/TQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so1274498a12.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:39:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9eIKC2j+iIpEbXbcpTqNvkY5UqNRdoKY+raV9lsIEDKjZ9S+WxbB0wjlMVOuaYjQZC0lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53Sya320TeW4xYfqvSF4Npi9EXtEpwTjzbUvjDAlf64lwufZk
	EDPrwF0jSihq0mm4STgZWcphwtbFOykZTAUv2udZzVm4EeH4IOaGoCRWdfynaayLfpFGvkntyDT
	OtXa8HrJjO/j5ge5WNKc3EotJlFhVSOU=
X-Received: by 2002:a05:6402:1d54:b0:68e:2605:9417 with SMTP id
 4fb4d7f45d1cf-69378a4bcc6mr872140a12.16.1781253567761; Fri, 12 Jun 2026
 01:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611065815.1439154-1-maobibo@loongson.cn> <20260611065815.1439154-6-maobibo@loongson.cn>
 <CAAhV-H7vMq+-nm8f8aL2CvmNYivaHgWj1cTuyv0BTfPQRKpSJA@mail.gmail.com>
 <00f28be5-3805-90d1-d2a5-69734b3d0a03@loongson.cn> <CAAhV-H460mXx5ojv-=Bah5HoMHqy2bDB38uWaXXGkLeDNt8zRg@mail.gmail.com>
In-Reply-To: <CAAhV-H460mXx5ojv-=Bah5HoMHqy2bDB38uWaXXGkLeDNt8zRg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Jun 2026 16:39:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7_F2aQ-d-pJLOWR30j9tJkRQ74DuBB-6Dq44Do5X1H3A@mail.gmail.com>
X-Gm-Features: AVVi8CdcopdsJa4jajkAXnhlaqYXs9kHDdy3PzGzoD8eP16RG-U6TTx8QXK5WNE
Message-ID: <CAAhV-H7_F2aQ-d-pJLOWR30j9tJkRQ74DuBB-6Dq44Do5X1H3A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] LoongArch: KVM: Add valid bit check when set ESTAT
 CSR register
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 9:01=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Thu, Jun 11, 2026 at 8:55=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wr=
ote:
> >
> >
> >
> > On 2026/6/11 =E4=B8=8B=E5=8D=886:10, Huacai Chen wrote:
> > > Hi, Bibo,
> > >
> > > On Thu, Jun 11, 2026 at 2:58=E2=80=AFPM Bibo Mao <maobibo@loongson.cn=
> wrote:
> > >>
> > >> When set ESTAT CSR register in function _kvm_setcsr(), valid bit che=
ck
> > >> is added here. Also interrupt CPU_AVEC is checked by msgint feature.
> > >>
> > >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > >> ---
> > >>   arch/loongarch/kvm/vcpu.c | 25 ++++++++++++++++---------
> > >>   1 file changed, 16 insertions(+), 9 deletions(-)
> > >>
> > >> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> > >> index e986146d2272..4f67eefbd4f1 100644
> > >> --- a/arch/loongarch/kvm/vcpu.c
> > >> +++ b/arch/loongarch/kvm/vcpu.c
> > >> @@ -602,7 +602,7 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kv=
m *kvm, int cpuid)
> > >>
> > >>   static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64=
 *val)
> > >>   {
> > >> -       unsigned long gintc;
> > >> +       unsigned long gintc, estat;
> > >>          struct loongarch_csrs *csr =3D vcpu->arch.csr;
> > >>
> > >>          if (get_gcsr_flag(id) & INVALID_GCSR)
> > >> @@ -621,8 +621,9 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, un=
signed int id, u64 *val)
> > >>                  preempt_enable();
> > >>
> > >>                  /* ESTAT IP0~IP7 get from GINTC */
> > >> -               gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC)=
 & 0xff;
> > >> -               *val =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT) =
| (gintc << 2);
> > >> +               gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC)=
 & KVM_GINTC_IRQ_MASK;
> > >> +               estat =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT)=
 & ~KVM_ESTAT_EXTI_MASK;
> > >> +               *val =3D estat | (gintc << VIP_DELTA);
> > >>                  return 0;
> > >>          }
> > >>
> > >> @@ -637,7 +638,8 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, un=
signed int id, u64 *val)
> > >>
> > >>   static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64=
 val)
> > >>   {
> > >> -       int ret =3D 0, gintc;
> > >> +       int ret =3D 0;
> > >> +       unsigned long gintc, estat;
> > >>          struct loongarch_csrs *csr =3D vcpu->arch.csr;
> > >>
> > >>          if (get_gcsr_flag(id) & INVALID_GCSR)
> > >> @@ -648,11 +650,16 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, =
unsigned int id, u64 val)
> > >>
> > >>          if (id =3D=3D LOONGARCH_CSR_ESTAT) {
> > >>                  /* ESTAT IP0~IP7 inject through GINTC */
> > >> -               gintc =3D (val >> 2) & 0xff;
> > >> -               kvm_set_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> > >> -
> > >> -               gintc =3D val & ~(0xffUL << 2);
> > >> -               kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, gintc);
> > >> +               gintc =3D kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC)=
 & ~KVM_GINTC_IRQ_MASK;
> > >> +               gintc |=3D (val >> VIP_DELTA) & KVM_GINTC_IRQ_MASK;
> > >> +               kvm_write_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> > > I think read & write can be combined, which means it can be simplifie=
d as:
> > >                  gintc =3D (val >> VIP_DELTA) & KVM_GINTC_IRQ_MASK;
> > >                  kvm_set_sw_gcsr(csr, LOONGARCH_CSR_GINTC, gintc);
> > >
> > >> +
> > >> +               /* only set valid ESTAT bits */
> > >> +               estat =3D val & ~KVM_ESTAT_EXTI_MASK;
> > >> +               estat &=3D CSR_ESTAT_IS | CSR_ESTAT_EXC | CSR_ESTAT_=
ESUBCODE;
> > >> +               if (!kvm_guest_has_msgint(&vcpu->arch))
> > >> +                       estat &=3D ~CPU_AVEC;
> > >> +               kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat);
> > > I think write csr may lose bits from the original value, so
> > >                  kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat)
> > > should be
> > >                  kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, estat)
> > >
> > > If you agree, I will change it when I apply because all others look g=
ood to me.
> > At the beginning, it is kvm_set_sw_gcsr() with CSR_GINTC/CSR_ESTAT,
> > later I change it with kvm_write_sw_gcsr(). With kvm_set_sw_gcsr() API,
> > it is only set new interrupt, however does not clear the interrupt. So =
I
> > change it with kvm_write_sw_gcsr() which will overwrite the interrupt b=
its.
> >
> > At the same time, bit field CSR_ESTAT_EXC | CSR_ESTAT_ESUBCODE is not
> > suitable for bit set, overwrite its value is more suitable.
> OK, then I will keep using kvm_write_sw_gcsr(), and please update the
> selftest series if needed.
Now all KVM patches are applied, you can double check it here.
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/log/?h=3Dloongarch-kvm

Huacai

>
> Huacai
>
> >
> > Regards
> > Bibo Mao
> >
> > >
> > > Huacai
> > >
> > >>
> > >>                  return ret;
> > >>          }
> > >> --
> > >> 2.39.3
> > >>
> >
