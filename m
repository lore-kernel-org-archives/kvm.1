Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B638C42D
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821048; cv=none; b=auGkGkpo5qQK39RJjObB25BBWxM99IeVkJT5nT5K/8c6DXyqznI/lUrIphX6anj9eDVLylE2pOVfoQVzaLHqyNOU0WKlQjLEgsKQufnsp3A/TOcISe4VNtlH3XIDm+FVBGPWa61/Y6T8qgcpkCuYQ6WRhnULMuWAOTIMQlCKQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821048; c=relaxed/simple;
	bh=jisph3qXBkwAscfmsL+8BfW/m3xSzHLkZSvL9C7fhxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=avODRgVwJU7MJchcgzSd0oc6zVFV8INiOAhxuklFa+2H0fGF1PUvFBL1qZKJpy0nUxikrsFXtJENQ/uO+FXm99h1Je+D52S2HgCZvhS10DG3Y0CzDRLHeNhJkqG9SvYh3C9kmeaF8jPCVh6dyXlXuMQjEvJLJ1QefEGNkq0usAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvfWH7Dx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvfWH7Dx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babbeff9e4so118638655ad.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779821046; x=1780425846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiyueY/fWQ1e//F0LkVrrcRuuCkGz7Kq1fBiqF7G62s=;
        b=DvfWH7Dxe99nJAeNEd+rK0Q1abCbnn5WQkXwld/RKCLD8m8oihEpEXP5V1SWROILyr
         9AZbkL8hzHxarriCnAu1CTXG4XAAOtDpwbydnHMLebZJXhN4+tdX2ro0Xo3lyYwg1NHb
         l60zr+WUrMKXO/OEIQXl+bOdOapN33EKRZS2E6fQZEG/SDzQHt/jXWgx++RsjDDRCwct
         vfd6GUv/rL6NDEMnCyzwfovy1yEBj+45W6Sozxq8Ww3rpaG8s0A/7Tz8UjnlVyEXjaf9
         HQzUv5VSMxIZlNHUEPay/Da7QtOimmUNGWKu4s8GnL1FWrY1tKgr5mpc/Teo05yMBcNf
         Erdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821046; x=1780425846;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fiyueY/fWQ1e//F0LkVrrcRuuCkGz7Kq1fBiqF7G62s=;
        b=R7TjDTd+20HTVsd1afHYGeBPaCeDTeVx5kzIBJAT7OY/eEYwBk7f+ZerQjKWE1TZo4
         x13dxjeRyIszidfR13pvfmcF4MKT10jTGqJ3hNUn//mDvE/9UWSL+1lfTqTGvaIxEaNw
         p+Oeq3H828HDBHwtVIwGz1nWf0JGDANB3pYadQ0upLpDoweXhOzVmdd5jO8Nn3ak7kfA
         J8XW2QiOtqHuGLfsBx7r6CEOeYnWdkH5nfxfVwyRgERTnEsirOBEiIUo6tI8ih488OGN
         OF/9lclLjYXTQ/vd3JtRvYMyyyE5tPtyvsiLXoJlUCAVqlevwzYQK4NME4O5ouMf0A+6
         4LGA==
X-Forwarded-Encrypted: i=1; AFNElJ9uJZp/txL/PP3SNzFyZHIcIRv++yjOfX6SlNxzONT6HZQM0ZvVLL0nTBSZQr0nPJ21pqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMcb0LQujsF/lBiCPA0V8q9XAI9gHFVlVKS8zVklVT+q5eh/MG
	qA5AaRgo/VHzgSmOfv39wrQwsB+r/0likwnXY+29Dx7Mbc7DLGJVHdmQ9p+elTBileh+AIhaQbF
	gL8IlKA==
X-Received: from plgw2.prod.google.com ([2002:a17:902:e882:b0:2bc:a589:91c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:24c:b0:2bd:d7c5:927c
 with SMTP id d9443c01a7336-2beb09b70f0mr168467685ad.20.1779821045824; Tue, 26
 May 2026 11:44:05 -0700 (PDT)
Date: Tue, 26 May 2026 11:44:05 -0700
In-Reply-To: <CAO9r8zP-t3YsiXNZm2beR6RcRZaDN386_ktmipGm+sA=2PGcaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-4-seanjc@google.com>
 <CAO9r8zP-t3YsiXNZm2beR6RcRZaDN386_ktmipGm+sA=2PGcaQ@mail.gmail.com>
Message-ID: <ahXp9V3o0bWVi1lj@google.com>
Subject: Re: [PATCH v4 3/5] KVM: SVM: Fix nested NPF injection of
 PFERR_GUEST_{PAGE,FINAL}_MASK bits
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026, Yosry Ahmed wrote:
> On Fri, May 22, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > From: Kevin Cheng <chengkev@google.com>
> >
> > Fix KVM's generation of PFERR_GUEST_{PAGE,FINAL}_MASK bits when injecti=
ng a
> > Nested Page Fault into L1.  Currently, KVM blindly stuffs GUEST_FINAL i=
nto
> > L1, which is blatantly wrong given that KVM obviously generates NPFs fo=
r
> > page table accesses.
> >
> > There are two paths that trigger NPF injection: hardware NPF exits (fro=
m
> > L2) and emulation-triggered faults, i.e. when KVM detects a NPF as part=
 of
> > emulating an L2 GVA access.  For the hardware case, use the bits verbat=
im
> > from the VMCB, as KVM is simply forwarding a NPF to L1.  For the emulat=
ion
> > case, propagate the GUEST_{PAGE,FINAL} bits from the access field (whic=
h
> > were recently added for MBEC+GMET support).
> >
> > To differentiate between the two cases, add "hardware_nested_page_fault=
"
> > to "struct x86_exception", and set it when injecting a NPF in response =
to
> > an NPF exit from L2.
>=20
> hardware_nested_page_fault is no more.

Hrm, I suspect I unintentionally discarded a changelog update, I distinctly
remember rewriting this.  *sigh*

> > To help guard against future goofs, assert that exactly one of GUEST_PA=
GE
> > or GUEST_FINAL is set when injecting a NPF.  Unlike VMX, there are no
> > (known) cases where hardware doesn't set either bit, and KVM should alw=
ays
> > set one or the other when emulating a GVA access.
> >
> > Signed-off-by: Kevin Cheng <chengkev@google.com>
> > [sean: use plumbed in @access bits, massage changelog]
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> [..]
> > @@ -39,19 +39,32 @@ static void nested_svm_inject_npf_exit(struct kvm_v=
cpu *vcpu,
> >  {
> >         struct vcpu_svm *svm =3D to_svm(vcpu);
> >         struct vmcb *vmcb =3D svm->vmcb;
> > +       u64 fault_stage;
> >
> > -       if (vmcb->control.exit_code !=3D SVM_EXIT_NPF) {
> > -               /*
> > -                * TODO: track the cause of the nested page fault, and
> > -                * correctly fill in the high bits of exit_info_1.
> > -                */
> > -               vmcb->control.exit_code =3D SVM_EXIT_NPF;
> > -               vmcb->control.exit_info_1 =3D (1ULL << 32);
> > -               vmcb->control.exit_info_2 =3D fault->address;
> > -       }
> > +       /*
> > +        * For hardware NPF exits, the GUEST_FAULT_STAGE bits are only
> > +        * available in the hardware exit_info_1, since the guest_mmu
> > +        * walker doesn't know whether the faulting GPA was a page tabl=
e
> > +        * page or final page from L2's perspective.
> > +        */
> > +       if (from_hardware)
> > +               fault_stage =3D vmcb->control.exit_info_1 &
> > +                             PFERR_GUEST_FAULT_STAGE_MASK;
> > +       else
> > +               fault_stage =3D fault->error_code & PFERR_GUEST_FAULT_S=
TAGE_MASK;
> >
> > -       vmcb->control.exit_info_1 &=3D ~0xffffffffULL;
> > -       vmcb->control.exit_info_1 |=3D fault->error_code;
> > +       /*
> > +        * All nested page faults should be annotated as occurring on t=
he
> > +        * final translation *or* the page walk. Arbitrarily choose "fi=
nal"
> > +        * if KVM is buggy and enumerated both or neither.
> > +        */
> > +       if (WARN_ON_ONCE(hweight64(fault_stage) !=3D 1))
> > +               fault_stage =3D PFERR_GUEST_FINAL_MASK;
> > +
> > +       vmcb->control.exit_code =3D SVM_EXIT_NPF;
> > +       vmcb->control.exit_info_1 =3D fault_stage |
> > +                                   (fault->error_code & ~PFERR_GUEST_F=
AULT_STAGE_MASK);
>=20
> Do we need to do this in the common path?

What do you mean by "this"?  Pulling flags from fault->error_code?

> If from_hardware=3Dtrue, can the fault injected by KVM have different fla=
gs
> from the one produced by hardware?=20

Flags, yes.  fault_stage, no.

> I guess the answer is yes, (e.g. if KVM is doing write-protection?). Migh=
t be
> worth a comment.

Or if L1 has modified its TDP PTEs in memory, but hasn't yet flushed TLBs. =
 In
that case, KVM's software walker can see the updated PTEs, while hardware m=
ay
have seen something else.
