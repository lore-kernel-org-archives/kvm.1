Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D3320A14
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252615; cv=none; b=AL7TrIn2f0utGpE+W+Pg6drqgodd8oMd2eB3UptRuNcI4Yf25izAtQqe7LNF3lexYpaWl+pKw8hg0IL6Ux2pqDU3DpbfATHirqcb8Fk4/6nA6iblYVcth3vHiWPBmOH4pMVlGCXadRUKTsFjjK2b6N1H5bgriy97G4XoCTKDZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252615; c=relaxed/simple;
	bh=7pghjOAdTDo+nHd0E435QGia73sHL9IGcT8cW0GsPL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgdnutSJOhF5iIgAmLr8HPmP7LwDI4bczDjVBSbQclGE5P/q9ROVkPS2a5vljUYSiQUOeSa+hRcF1sYT99dOng+6NT5EB5gEZnMt+efcSgcL1lxyC9kru7Ln4hJ+wfdHtXvBNz5w8Z9bqpao/+m0a4WvBPWdp7VgK+FHPli3ZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0KpUXLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0KpUXLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8F5C4AF0B
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775252615;
	bh=7pghjOAdTDo+nHd0E435QGia73sHL9IGcT8cW0GsPL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b0KpUXLpo6ksVCWBdj/T/ixK7LneDqSHTdAf8YBKMNNaAmDlE/qZspwEx3d4EWUjF
	 UlPzWaDTzlw4ETmJnY51LRhI2hcZJU4etXxLsjoKTfmQOxzumbjXzJ2xtEbd7/ti/Z
	 VnHFWjVT1tqEiJbCIkSC1NGSElT2T6a0z+RpxaADd2jdd8Q1lIwsrNMZ9WIO+EfC0X
	 z0WZ0MMr0qA0P8LQOzBexIbil4/SQCH23acucazmK+OV8YpFX3qPF1eKvh/+PNmEkj
	 RQEbF49tRjXTtLF+wKngy2BCdmH0XaScbRe+dCP2aO7WzdjLdN06ahnK8oYf+wuDfU
	 I3bVnnzgqNJaw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9358bc9c50so318606066b.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 14:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw08uwUn7SIyKMx690rcfIcmsYV52z+cBUX/LfE8tQswFkMzBTmQLmQUkudl67lORB4uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8EMjZUGnqsMKSNyhqjCI1n5aJDQmH6DOVMnDdbi0Cnt9ROA2
	pFv4NS15JW6qxUZ0jizz+IJFPiOJevuTX3TkL3Qsj8Wa59mEoOJE8h0gHY6vHhjwhIeYkyGMQZc
	DRCWZeTQWWCBu0agVDqUQ7+XOx1/Uud4=
X-Received: by 2002:a17:907:3d51:b0:b9c:4893:822e with SMTP id
 a640c23a62f3a-b9c672a7aa6mr224628766b.10.1775252614327; Fri, 03 Apr 2026
 14:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <20260316202732.3164936-4-yosry@kernel.org>
 <ac_7Yg-Ma4UR2nIz@google.com> <adAOS-dKq72VClS_@google.com>
In-Reply-To: <adAOS-dKq72VClS_@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 3 Apr 2026 14:43:21 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMcRmWmEZhRYh-PguvJhnMcD4zvWRtnR-nBGAZFt8xo1w@mail.gmail.com>
X-Gm-Features: AQROBzAHbdDqyi79v_7Tybct6WlpemDfNj7482xDIfo4WHocZ-JzKVSRO5qjESc
Message-ID: <CAO9r8zMcRmWmEZhRYh-PguvJhnMcD4zvWRtnR-nBGAZFt8xo1w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] KVM: SVM: Properly check RAX on #GP intercept of
 SVM instructions
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Apr 03, 2026, Sean Christopherson wrote:
> > On Mon, Mar 16, 2026, Yosry Ahmed wrote:
> > > Replace the PAGE_MASK check with page_address_valid(), which checks b=
oth
> > > page-alignment as well as the legality of the GPA based on the vCPU's
> > > MAXPHYADDR. Use kvm_register_read() to read RAX to avoid
> > > page_address_valid() failing on 32-bit due to garbage in the higher
> > > bits.
> >
> > Nit, not "on" 32-bit, correct?  I think you actually mean "to avoid fal=
se positives
> > when the vCPU is in 32-bit mode, in the unlikely case the vCPU transiti=
oned from
> > 64-bit back to 32-bit, without writing EAX".  Because regs[] is an unsi=
gned long,
> > so the upper bits of save.rax will be cleared by svm_vcpu_run() on ever=
y VM-Entry,
> > and it should be impossible for a purely 32-bit guest to get a non-zero=
 value in
> > RAX[63:32].
> >
> > And even for a 64-bit host with a 32-bit guest, the only way to get a n=
on-zero
> > value in RAX[63:32] while in 32-bit mode would be to transition from 64=
-bit mode,
> > back to 32-bit mode, without writing EAX.
> >
> > > Note that this is currently only a problem if KVM is running an L2 gu=
est
> > > and ends up synthesizing a #VMEXIT to L1, as the RAX check takes
> > > precedence over the intercept. Otherwise, if KVM emulates the
> > > instruction, kvm_vcpu_map() should fail on illegal GPAs and inject a =
#GP
> > > anyway. However, following patches will change the failure behavior o=
f
> > > kvm_vcpu_map(), so make sure the #GP interception handler does this
> > > appropriately.
> > >
> > > Opportunistically drop a teaser FIXME about the SVM instructions
> > > handling on #GP belonging in the emulator.
> > >
> > > Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP trigger=
ed by SVM instructions")
> > > Fixes: d1cba6c92237 ("KVM: x86: nSVM: test eax for 4K alignment for G=
P errata workaround")
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/svm/svm.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 392a5088f20bf..3122a98745ab7 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -2277,10 +2277,12 @@ static int gp_interception(struct kvm_vcpu *v=
cpu)
> > >     if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) !=3D EMULAT=
ION_OK)
> > >             goto reinject;
> > >
> > > +   /* FIXME: Handle SVM instructions through the emulator */
> > >     svm_exit_code =3D svm_instr_exit_code(vcpu);
> > >     if (svm_exit_code) {
> > > -           /* All SVM instructions expect page aligned RAX */
> > > -           if (svm->vmcb->save.rax & ~PAGE_MASK)
> > > +           unsigned long rax =3D kvm_register_read(vcpu, VCPU_REGS_R=
AX);
> > > +
> > > +           if (!page_address_valid(vcpu, rax))
> >
> > Eh, let it poke out, i.e.
> >
> >               if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCP=
U_REGS_RAX)))
>
> Argh, looking at the rest of this series, and at KVM's existing code, hav=
ing to
> use kvm_register_read() is awful.  This really should be able to use kvm_=
rax_read(),
> but that won't handle the truncation.
>
> There are only a handful of likely-benign goofs due to this mess, but the=
re is a
> pile of manual truncation and casting going on.  In addition to _raw() va=
riants,
> and mode-aware defaults, add "e" versions would be helpful, as many of th=
e
> explicit truncation flows are cases where e.g. EAX, ECX, and EDX are arch=
itecturally
> accessed.
>
> I'll put together patches, and think more on how to handle this series (t=
he
> dependencies aren't terrible, but they certainly are annoying).  I'm temp=
ted
> to squeeze this into 7.1 to make future life easier...

Just to make sure I understand this correctly, you'll keep this series
using kvm_register_read() and send patches on top to make
kvm_rax_read() a viable alternative and switch it, right?
