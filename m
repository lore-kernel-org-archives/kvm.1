Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF434FF5D
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734105; cv=none; b=P/F4HSMG2xdJbzR8AOCqyObPUTO8wcDLhMFAvV7eJDFJUU7OY37yMTDtGBuiC6j+0He+Nu1LQNQ1wKITlI8m585IkY+c1BajqsytaddW2s5TEM2UAcdVD5iSTF/MJj6MfbLR9npRU4hoYTbphkqKGk6DmbYPeIMqBVw6gOJJ4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734105; c=relaxed/simple;
	bh=JhqpdjlUegF5d5RsooTiJX+4AVfcqBJhytFsIcxcvpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNl/FVVPAbLUpYNyxto+LVFxiOyaxbfK4PlIYQdaBZy2O6cG8qThBUpNajcGw8wVrtavBMRW+T0kkFMVMWNnhx/uwxn34LYJU8aj+dAzwwt0/8vGwRyk0bQ3mfWy4Cal6n7BGmrj3S56aPMvdcjYVGZ1CPWviFs0hAm/ywFZWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkofnZYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkofnZYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549761F0089B
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 02:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734104;
	bh=jsB8glCeMIfvLX9QeTCq0ti5cNN5IV0Cvi9+vtjV9v8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hkofnZYICg5YPhSYs1I+bu32Wfn8P/9ul493hDKH72iXRX8R+8JgjJiqVXcx5hb4G
	 pntA5ZcT8oMLuqaVDnnlAx7UByhF/4qunE9KG4yO8B8CYlXV+usXEUOq4FvBcR5t8s
	 5Q6bLIF55QTCdrKmGaQEb7qzk09Dbf5932JuBbCu0cBd+/7Ba2l+hOUUy0JIc3lk9M
	 FOY7pWhSqsN2Ix9XKo97lZDhuubynR7Kk8jQXCxTncnQbE3gKH3YyNh6tLIiRpCjYX
	 WXDyl7fITrHHOKEASWWQuDLWwGB9JCEvfD1076TpEV0Gqxf6YyzNP+PvgknCpX8xd5
	 7uIYyAyQuD2qQ==
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb88abebdso1619355a12.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 19:08:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwm6VHHM74dDJ8raT26fkA4MYaugxNUMZarPvYhpBmcF9AxHdz/LXuPkVeU6ip/lKUGoCM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiIkQc7clgZykwh2X/1N90+yKJkA1qnb+Tw5trPqTT93LDA6PA
	/8J1zglotsYJK9Tz3hyQWWygGHgc7XR60iNaUX63gT6O0WVyzPeh1Luwg58JMtXQi8NlEqql/nT
	AoGl2Z8Z2X2d4+nD4SNM5Q9Kf3XsxZTE=
X-Received: by 2002:a05:6402:4513:b0:6ab:1c2:967e with SMTP id
 4fb4d7f45d1cf-6ad4fd5c29cmr500039a12.32.1790734102933; Tue, 29 Sep 2026
 19:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929102821.36112-1-cui.tao@linux.dev> <20260929102821.36112-3-cui.tao@linux.dev>
 <6bc45b7c-88d8-f134-426a-b556fb867b41@loongson.cn>
In-Reply-To: <6bc45b7c-88d8-f134-426a-b556fb867b41@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 30 Sep 2026 10:08:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cBHvpJa0vgGqapQfeoUyVz2N6zW_DgTcCqwuuG7Utkw@mail.gmail.com>
X-Gm-Features: AclHuK_b3TBwqVF2DXaM6BHodzV78IRxJaZUqGoSgu3d2bLEt92synhb1Wt8tBA
Message-ID: <CAAhV-H5cBHvpJa0vgGqapQfeoUyVz2N6zW_DgTcCqwuuG7Utkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] LoongArch: KVM: Load dmsintc pointer once in pch_msi_set_irq
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:41=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/9/29 =E4=B8=8B=E5=8D=886:28, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > pch_msi_set_irq() reads kvm->arch.dmsintc several times: the non-NULL
> > check and the address-window comparison each reload the pointer, so a
> > concurrent device removal can be observed between them and the
> > following dereference hits a freed object.
> >
> > Load the pointer once at the top of pch_msi_set_irq() and add a NULL
> > check with a local snapshot in dmsintc_set_irq().  Both loads use
> > READ_ONCE() so the compiler keeps them single.  This closes the
> > reload race; a narrower window where removal happens right after the
> > load remains, as the injection path takes no lock against destroy.
> >
> > Fixes: 03de5eecb0f0 ("LoongArch: KVM: Add DMSINTC inject msi to vCPU")
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >   arch/loongarch/kvm/intc/dmsintc.c | 6 +++++-
> >   arch/loongarch/kvm/intc/pch_pic.c | 7 ++++---
> >   2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/int=
c/dmsintc.c
> > index 41c8b597b5bd..91a163698c3c 100644
> > --- a/arch/loongarch/kvm/intc/dmsintc.c
> > +++ b/arch/loongarch/kvm/intc/dmsintc.c
> > @@ -69,9 +69,13 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int d=
ata, int level)
> >   {
> >       unsigned int irq, cpu;
> >       struct kvm_vcpu *vcpu;
> > +     struct loongarch_dmsintc *s =3D READ_ONCE(kvm->arch.dmsintc);
> > +
> > +     if (!s)
> > +             return -EINVAL;
> NULL check with kvm->arch.dmsintc is already done in its caller function
> pch_msi_set_irq(). It is not necessary here.
> >
> >       irq =3D (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
> > -     cpu =3D (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
> > +     cpu =3D (addr >> AVEC_CPU_SHIFT) & s->cpu_mask;
> >       if (cpu >=3D KVM_MAX_VCPUS)
> >               return -EINVAL;
> >       vcpu =3D kvm_get_vcpu_by_cpuid(kvm, cpu);
> > diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/int=
c/pch_pic.c
> > index 62c09b5f3937..30a8c65c7609 100644
> > --- a/arch/loongarch/kvm/intc/pch_pic.c
> > +++ b/arch/loongarch/kvm/intc/pch_pic.c
> > @@ -71,10 +71,11 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, i=
nt irq, int level)
> >   int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_en=
try *e, int level)
> >   {
> >       u64 msg_addr =3D (((u64)e->msi.address_hi) << 32) | e->msi.addres=
s_lo;
> > +     struct loongarch_dmsintc *dmsintc =3D READ_ONCE(kvm->arch.dmsintc=
);
> what is usage of READ_ONCE() here?
>
> If you want to simple the usage of kvm->arch.dmsintc in multiple places,
> just *struct loongarch_dmsintc *dmsintc =3D kvm->arch.dmsintc* is enough.
> And it is not fixup patch, it is code cleanup.
I completely don't think this patch is necessary.

Huacai

>
> Regards
> Bibo Mao
> >
> > -     if (cpu_has_msgint && kvm->arch.dmsintc &&
> > -             msg_addr >=3D kvm->arch.dmsintc->msg_addr_base &&
> > -             msg_addr < (kvm->arch.dmsintc->msg_addr_base + kvm->arch.=
dmsintc->msg_addr_size)) {
> > +     if (cpu_has_msgint && dmsintc &&
> > +             msg_addr >=3D dmsintc->msg_addr_base &&
> > +             msg_addr < (dmsintc->msg_addr_base + dmsintc->msg_addr_si=
ze)) {
> >               return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level)=
;
> >       }
> >
> >
>
