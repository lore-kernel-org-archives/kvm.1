Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6324484241
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848716; cv=none; b=EZFFUUyHmcdFmn7AvRMk38CKL8XotMCKgdMgiuYuvD3Uvoh+ldTmUrcmF2Nf3m2QMmXJVnsp9kl3pqfR6BhcSJhiUDfGYpFLcAvDwpv0Qw1dlbPZG20Ae6bKbC3+7IIWe3/l4+1DmKEaUt1p8K62gpJOOTf/Kch6mfCexXkQBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848716; c=relaxed/simple;
	bh=cCkF8f6xFgMdW8Cd6s+O/9FMEWCLYTUUuKxw51rIXgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQQkPiQDJnwswSiCVJN7jF0f4SlHH3bUB2L1i7krhszMfkikNktIdQxUYKKgS51r2KZBHLxGXgRG/+UD4sChhRaFS5YyO2cBb0V2ve50OhXURk0+WgBPZoBBgANhEszFq1o0QTbkL5/xQfvDEUBuXEGfrs4RJzcCoWgcaxLRoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jywE9fJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jywE9fJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F441F00A3A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787848714;
	bh=79LT1FTf1EQ7iIO60cu5IupbbRNT9ep0N1MKx/iPMBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jywE9fJsbOGEFcxhVFrJn0YxQOwZfmxfrhSw0E97IvQSOzwumMNc6PkrXjr6/S6Na
	 hwjAHSd2FV+zdrG9BDBFLXzbEK1foihG8GDC1F4v/hoX33MjVOBvkME91y4wNbpCy1
	 hSV8mNFaSCwCQt19NaH8wU95eNTiAyrnapCuW1lxJj0Zc38zQmTGoXWwWxtp5BoIDH
	 9nZ8UzJ6BB5VGqHM/GpHix9faX9ZQeAOwFdMdRCJtS5havJ3C//kaBClrEE28sgTL+
	 K3SigqHpdhswSAUJvXwKZ9Vjcefdr2pqWkaTLwu1+BlCQxNOzQtSGNiCAWgNQL0Udu
	 qDm9BQcS/BksA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c25344a8c6cso6872566b.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 09:38:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoDOk3jjCt3topKF5zPbw0ixkd01IM/CZ/Zl1ItCzXtCVnRgf3JCR6E4dytT9VO8/ivpys=@vger.kernel.org
X-Gm-Message-State: AFuF++mScTv5spW0EGc/vFZcTxr85nI3+AojUwtm5T3ORzLSHFwWz59z
	jBd07G87mXAgA4vp/F3D/RLpkLJmz3pOHDKSp+WI+JeZt/QqouE8lAb2BFwYn3y1042hfq1/JS8
	vbRYFMiayYxC6sQzX+cPG7OZjmbLrScM=
X-Received: by 2002:a17:907:3e0b:b0:c21:450d:cd7e with SMTP id
 a640c23a62f3a-c250bbbf096mr1528043866b.9.1787848713280; Thu, 27 Aug 2026
 09:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-4-seanjc@google.com>
 <CAO9r8zM7KSRX5r-PazJ87QaZze3wkB5WmJL4e6az5akmJLterQ@mail.gmail.com> <apBQYmmBC8lE-KiQ@google.com>
In-Reply-To: <apBQYmmBC8lE-KiQ@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 09:38:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOiPc=AdSZov9w5EN-WogpSTR54z8UuTd3oqKHiWCfNmA@mail.gmail.com>
X-Gm-Features: AcwNN1Uf16kIBoba-w3xAyfXDcio3hnpMiCJElKz9P4Lzge3Sr8Lt37bi3y7Xp4
Message-ID: <CAO9r8zOiPc=AdSZov9w5EN-WogpSTR54z8UuTd3oqKHiWCfNmA@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:57=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Bug the VM if KVM attempts to construct a CPU role with the should-be=
-
> > > impossible combination of long mode being active without PAE paging b=
eing
> > > enabled.  KVM's MMU construction assumes that EFER.LMA can be set if =
and
> > > only CR4.PAE is set, and will create a completely invalid MMU if that
> > > assumption fails.  FNAME(walk_addr_generic) already has sanity checks=
 to
> > > try and mitigate the fallout, but attempt to catch such bugs earlier,=
 as
> > > this is (at least) the second time KVM has had bugs that escaped into
> > > FNAME(walk_addr_generic), and it's entirely possible the bad state co=
uld
> > > cause problems elsewhere.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 064ecc33b926..81c30e2c74f3 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(str=
uct kvm_vcpu *vcpu,
> > >                 return role;
> > >         }
> > >
> > > +       if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs)=
, vcpu->kvm))
> >
> > Can we shove this into the existing if (____is_efer_lma(regs)) below?
>
> No, because there are three more checks on EFER.LMA:
>
>         role.ext.cr4_pke =3D ____is_efer_lma(regs) && ____is_cr4_pke(regs=
);
>         role.ext.cr4_la57 =3D ____is_efer_lma(regs) && ____is_cr4_la57(re=
gs);
>         role.ext.efer_lma =3D ____is_efer_lma(regs);
>
> and I don't want to have to condition them all on something that shouldn'=
t happen.

Yeah I assumed that we don't care about the state anymore if we'll
KVM_BUG_ON(), but apparently that's not the case based on your comment
below.

>
> OMG, I hate SVM.  I resurrected the selftest hack I used to verify this b=
ug, to
> demonstrate that Sashiko's "technically that's undefined behavior and thi=
s is
> useless" complaint is wrong, because even though it's undefined behavior =
and the
> compiler *could* ignore the change, in practice the compiler probably won=
't ignore
> the change.  And since this is defense-in-depth, it's "fine" if the paran=
oid
> hardening only isn't guaranteed to kick in.
>
> And in doing so managed to trip this KVM_BUG_ON() in *L0* when running th=
e test
> in L1, because as you kinda sorta noted in patch 1, KVM doesn't ignore EF=
ER.LMA
> when loading L2 state.
>
> I had actually tried to do exactly that, by having nested_vmcb_check_save=
() clear
> EFER.LMA if EFER.LME=3D0, but that doesn't work because svm_set_nested_st=
ate() uses
> the "cache" only for the checks, not for the actual loading of state.  *s=
igh*
>
> So in addition to patch 1, we also need this to guard against configuring=
 L2's
> walk_mmu with bad state.

Hmm wouldn't it be simpler at this point to let KVM_SET_NESTED_STATE
and nested VMRUN have the invalid LMA/LME combination and just ignore
EFER.LMA if EFER.LME (or just always check EFER.LMA && EFER.LME)?

>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 49fb10ad1f9f..23d29597d6bf 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_s=
vm *svm)
>
>         kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
>
> +       /* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN=
). */
> +       if (!(svm->nested.save.efer & EFER_LME))
> +               svm->nested.save.efer &=3D ~EFER_LMA;
> +
>         svm_set_efer(vcpu, svm->nested.save.efer);
>
>         svm_set_cr0(vcpu, svm->nested.save.cr0);
>
> Anyways, back to Sashiko's "technically this is wrong" statement, I confi=
rmed
> that tweaking the code to do this does NOT trigger the KVM_BUG_ON() with =
at least
> clang-21.  I.e. my assertion that clearing regs->efer.LMA could be useful=
 holds
> true.
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b515a49c5e86..cab8690d0fa0 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5932,8 +5932,10 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct=
 kvm_vcpu *vcpu,
>                 return role;
>         }
>
> -       if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vc=
pu->kvm))
> +       if (____is_efer_lma(regs) && !____is_cr4_pae(regs)) {
> +               pr_warn("Forcing EFER.LMA=3D0 in calc CPU role\n");
>                 *(u64 *)&regs->efer &=3D ~EFER_LMA;
> +       }
>
>         role.base.efer_nx =3D ____is_efer_nx(regs);
>         role.base.cr0_wp =3D ____is_cr0_wp(regs);
> @@ -5941,6 +5943,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct =
kvm_vcpu *vcpu,
>         role.base.smap_andnot_wp =3D ____is_cr4_smap(regs) && !____is_cr0=
_wp(regs);
>         role.base.has_4_byte_gpte =3D !____is_cr4_pae(regs);
>
> +       KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->=
kvm);
> +
>         if (____is_efer_lma(regs))
>                 role.base.level =3D ____is_cr4_la57(regs) ? PT64_ROOT_5LE=
VEL
>                                                         : PT64_ROOT_4LEVE=
L;
>
> Side topic, I also (inadvertantly) somewhat justified keeping the
>
>         if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
>
> check in FNAME(walk_addr_generic) when testing the above.  If KVM manages=
 to
> configure a sane MMU, but still has a vCPU with the above state, then we =
still
> want to WARN and bail.

Good point.

>
> > > +               *(u64 *)&regs->efer &=3D ~EFER_LMA;
> >
> > Why do this if we will crash the VM anyway (and Sashiko doesn't like it=
)?
>
> Because there's a lot of code between here and checking KVM_VM_DEAD in
> vcpu_enter_guest().  And has been proven far too many times this year, de=
tecting
> a flaw doesn't automagically mitigate true badness.

Interesting, I always assumed we can do whatever we want after KVM_BUG_ON()=
 :P

>
> > > +
> > >         role.base.efer_nx =3D ____is_efer_nx(regs);
> > >         role.base.cr0_wp =3D ____is_cr0_wp(regs);
> > >         role.base.cr4_smep =3D ____is_cr4_smep(regs);
> > > --
> > > 2.55.0.887.g758fc8c411-goog
> > >
