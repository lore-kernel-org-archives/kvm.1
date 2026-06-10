Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A04371067
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077059; cv=none; b=aMK4slxSHe/GLnubbvR6NDqTG9eB918HsHKgFEMvPwv3swNDnzlVtEgT4k5batGRO1Vwbvx/OtH600wQvYJJc9HeTSDQODi2y5PQbachYjXwi9TvXOdWHvyXdUnbKeVELFyL4DpdqIrE9si1BCwnD6s3dllD0hLcBLB8jHoOHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077059; c=relaxed/simple;
	bh=g8HJk/WF/WPN15g77t6Df0f0ynHp49fDIYS2UyArhq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVdlrO0uQztjblaO3QJNlnDkRAweZBrsNjw5MQkEFqFuRN7ox4XElVR2pmrno/bstrzrmzIvExeaV8dbGdPTuXA21NwupMJG4dN8+EykEqHfHg+EZ08zdmFmHUI2l27wu6g1m4OAnCSOcqTY5BFINy4CUVdpwt6XzoeEPVTYni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4bF4HQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4bF4HQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989CD1F00893
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077056;
	bh=QQ5tyIv8XSnLuljQqhXwRLjZ9cXqTPCZ3Z0kQgB9KsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E4bF4HQHWUQ0H2fTqr4Dwqut6EZzn3WJatwkoPnHBemh7W+kSIaFknBL+EQMxAK+L
	 WDUwQ4mbhypw3xCT88EwfNeALksqcMOXcc2EngkcE2Ak/0ScvewAQiKTSN2hYaYzBW
	 4isxSdeGuwTKQ70dIOw0ijeyanQW5JfMv1Ewa5xWfy7SMTNrXJODB7J79+yIH/TeMH
	 yscRxmlTzSkqPDnFmflrN7EOuVd8BAxz2lROK2tKbxArVPFgYVBl0YKrpG4vTgnDjb
	 C7KNdgm8tZ7/hqhYaN8ZXMt2dXEKwOXcCTIB3oA09oVXbm+ip+ztrGec4OSiMN5Z1F
	 Ziz0ePypPSb4A==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so11903816a12.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:37:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+58TED3xtOsf/8+UTtC1Cf2YGeKXXdJch9f74lH96VD70bBDssNijUuSUyTZGDD0t4T2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHT9pUKkr8De4EHC8QJLNAkeCSPx0jKwtQIykWzeTCK8dqTVo
	kskZbrd1c+J4V0ibsjgoGfX+iJa3yCDtyqEnfj3b/0LXIlfM8uOde7Qg+6xmx4IHarlGkrxx/2s
	qIlsC2hl5pIHmqSqX2h5uPTcwKGm+4YQ=
X-Received: by 2002:a05:6402:3507:b0:691:b5aa:5a5e with SMTP id
 4fb4d7f45d1cf-69238753416mr3408874a12.20.1781077055301; Wed, 10 Jun 2026
 00:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526125256.2511876-1-maobibo@loongson.cn> <20260526125256.2511876-3-maobibo@loongson.cn>
 <CAAhV-H7RUdVJXOdjktn6vox3crhcXV0cEB1kUgu_zUVV5qpihA@mail.gmail.com>
In-Reply-To: <CAAhV-H7RUdVJXOdjktn6vox3crhcXV0cEB1kUgu_zUVV5qpihA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 10 Jun 2026 15:37:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5X1a96mwTBtpuyTZKWbnV+T9xAnX1CcHQ6EikHJpKJLw@mail.gmail.com>
X-Gm-Features: AVVi8CfXkKQ6SeWTboItptzJXu2Ap8aOimrt-BpLyZihuyHKwOTEgKXdBNLpPEU
Message-ID: <CAAhV-H5X1a96mwTBtpuyTZKWbnV+T9xAnX1CcHQ6EikHJpKJLw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] LoongArch: KVM: Check msgint feature in interrupt post
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 5:54=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Bibo,
>
> On Tue, May 26, 2026 at 8:53=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wr=
ote:
> >
> > Interrupt AVEC is valid only if VM has msgint feature, and this feature
> > is checked in interrupt handling. Since interrupt handling is executing
> > in VM context switch, and it is hot path, here move the feature checkin=
g
> > in interrupt post rather than interrupt handling.
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> >  arch/loongarch/kvm/interrupt.c |  5 -----
> >  arch/loongarch/kvm/vcpu.c      | 14 +++++++++-----
> >  2 files changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interr=
upt.c
> > index a18c60dffbba..48dd56aa4dc5 100644
> > --- a/arch/loongarch/kvm/interrupt.c
> > +++ b/arch/loongarch/kvm/interrupt.c
> > @@ -36,8 +36,6 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, uns=
igned int priority)
> >
> >         switch (priority) {
> >         case INT_AVEC:
> > -               if (!kvm_guest_has_msgint(&vcpu->arch))
> > -                       break;
> >                 dmsintc_inject_irq(vcpu);
> >                 fallthrough;
> >         case INT_TI:
> > @@ -75,9 +73,6 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsig=
ned int priority)
> >
> >         switch (priority) {
> >         case INT_AVEC:
> > -               if (!kvm_guest_has_msgint(&vcpu->arch))
> > -                       break;
> > -               fallthrough;
> >         case INT_TI:
> >         case INT_IPI:
> >         case INT_SWI0:
> > diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> > index df5be9b265e8..ebd432da3ca4 100644
> > --- a/arch/loongarch/kvm/vcpu.c
> > +++ b/arch/loongarch/kvm/vcpu.c
> > @@ -1493,14 +1493,18 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *v=
cpu, struct kvm_interrupt *irq)
> >         if (vector >=3D EXCCODE_INT_NUM)
> >                 return -EINVAL;
> >
> > -       if (intr > 0)
> > +       if (!kvm_guest_has_msgint(&vcpu->arch) && (vector =3D=3D INT_AV=
EC))
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * Clear irq with INT_SWI0 (which is 0) is missing from SW side
> > +        * INT_SWI0 is cleared by guest kernel with the similar instruc=
tion
> > +        * clear_csr_estat(1 << INT_SWI0)
> > +        */
> > +       if (intr >=3D 0)
> >                 kvm_queue_irq(vcpu, intr);
> >         else if (intr < 0)
> I think "else if (intr < 0)" can be simplified as "else".
Any updates for this series?


Huacai

>
>
> Huacai
>
> >                 kvm_dequeue_irq(vcpu, -intr);
> > -       else {
> > -               kvm_err("%s: invalid interrupt ioctl %d\n", __func__, i=
rq->irq);
> > -               return -EINVAL;
> > -       }
> >
> >         kvm_vcpu_kick(vcpu);
> >
> > --
> > 2.39.3
> >
> >
