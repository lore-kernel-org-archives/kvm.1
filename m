Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BE483BFA
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848199; cv=none; b=bxG2F56a/9v+0ruiV2gUUSwVKmaPgA3dKE/0VlRcQZrLbD66PpYOuNV8EVjFvI9bV46RG3KLcfgEZzrOE9rEBWOhHzkrbc5h8JvQa5uO+Rm6PnOinAsH+CGnfpwhlkxY8BDOOfqSlQphYbpTcGxT+6XUGwHT2XmtQj0kS1hIe+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848199; c=relaxed/simple;
	bh=UskaSmTsZML1cWk8dHTPI4SKQ9xEl0Iiat3n386UXvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXVx2DKuI1rEJcZqcKbbMkBZikEZ4tnPgUFyebbDQOuTC6ijDwWKK0CkmEl8xntFoMgdn3YBwYJbu2POtNmSO8OWQZQMrIIWxp/RzZKSavfewml8jK8ehvPY0xBhpgab8taKRccN3TgYaa9uwZZZeiOFrXOx1XZ2wyrZufJTfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsJvF8hW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsJvF8hW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F841F00A3E
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787848198;
	bh=QU7WdqoQGnfbs/XIGYTlEz9X22dZJIb/8rqGN/Q34xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HsJvF8hWZd0XsUMP3jvgFv4zopudjAu6QOQ6C2koaromlJHWCO+QEH7dlSiXess9u
	 3iWh6rASSFqORfAMiFfO+gBMD5LZkNPs/w67qY5kzC2ydmHT/H3Q373Sj8hVnm/kbg
	 57bJZUVVC9S1KeizvbuApwoegPGMsl8f89W9ixrse7FekUwvQ6i7wEFhb51uGoWJ9X
	 QchXE6Be9WjWPe0ofMThODsNS/7vPC07qA7oRCrLfVr7WfJaTpQJc+mAF06Qh2qKIR
	 B+XEXSlSRZyqVchSo8kZH+hRmLjIxnA+U5eu2idlbt/gTcbxnRQWigvo1NT3CUJ6f+
	 fJEKi1SKzmyRA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso5683166b.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 09:29:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RooKTWuEThoeokcSwKjh3ehiN5MPEAfNWQ9+9oF7nBg0C74npbsjm8tuJE5vW6lcXFl834=@vger.kernel.org
X-Gm-Message-State: AFuF++kLtJyOXZm/zUiaXqMC31HWbvc+2u35Lfm2sDdqnzEOHzq+PM0D
	E7wsAx9zEfhlBwBqsDBSgdsV96O5Hx7PK2eFKuCd4WiCpJR0xMl0JJ9cn9XRHDFBAGnz64NjPgG
	mGPRmD6ChRXMtqa78g8PaaGH4oLHf6Xs=
X-Received: by 2002:a17:907:7249:b0:c21:752f:c3f7 with SMTP id
 a640c23a62f3a-c250bc127b0mr1633186966b.18.1787848197059; Thu, 27 Aug 2026
 09:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-2-seanjc@google.com>
 <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com> <apA9eLuaMxCLdCmn@google.com>
In-Reply-To: <apA9eLuaMxCLdCmn@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 09:29:43 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNm1QcVh29rTCzAFnYdUCS4y8ZSQOvrs2DD18XASuktoQ@mail.gmail.com>
X-Gm-Features: AcwNN1WzIl69BkEvs-UV7t1B5rY0MuOE3V9RLYpUEiKNX-1DpJDL0yx_f5ZHNrw
Message-ID: <CAO9r8zNm1QcVh29rTCzAFnYdUCS4y8ZSQOvrs2DD18XASuktoQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:37=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Reject KVM_SET_NESTED_STATE if the incoming L1 host state has what is
> > > effectively an impossible EFER combination of LMA=3D1 but LME=3D0, i.=
e. if the
> > > state says long mode is active but not enabled.  Unlike VMX, SVM does=
n't
> > > have an explicit consistent check for the illegal combination; presum=
ably
> > > hardware simply ignores EFER.LMA if EFER.LME=3D0.
> > >
> > > Unfortunately, KVM doesn't ignore EFER.LMA in this case and consumes =
the
> > > illegal state when constructing the shadow MMU for L2.  E.g. if users=
pace
> > > also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role wit=
h 4 or
> > > 5 levels of paging, but shadow_mmu_init_context() will wire up the MM=
U to
> > > use the paging32 template, which maxes out its levels at 2.
> >
> > Isn't the "right" thing to do what hardware (presumably) does and
> > ignore EFER.LMA if EFER.LME=3D0?
>
> No, because (a) this is KVM uAPI, not emulation of hardware, and (b) it's=
 a check
> on L1 state, not L2 state.  It should be impossible for L1 state to have =
this
> combination through "natural" means, and so a snapshot provided by KVM sh=
ould
> never have this combo either, which there's zero reason to allow userspac=
e to
> provide garbage.

Right, I understand that KVM can do whatever it wants here. I was
wondering if we wanted to make the uAPI behavior match the  VMRUN
behavior, but I guess we're free to make it more strict.

>
> > > Note, the "real badness" is effectively the same as what happened wit=
h the
> > > nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing consis=
tency
> > > checks for CR0 and CR4").  Unfortunately, the sanity check added by c=
ommit
> > > 72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mod=
e
> > > without PAE enabled") doesn't work for this case, since L2 state is a=
ctive
> > > at the time of the page fault, but it's L1 that has the bad state.
> > >
> > > Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and K=
VM_SET_NESTED_STATE")
> > > Cc: stable@vger.kernel.org
> > > Cc: Yosry Ahmed <yosry@kernel.org>
> > > Reported-by: Stefan Teodorescu <fane@google.com>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 73f37b050d0a..49fb10ad1f9f 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_vcpu=
 *vcpu,
> > >         if (!(save->cr0 & X86_CR0_PG) ||
> > >             !(save->cr0 & X86_CR0_PE) ||
> > >             (save->rflags & X86_EFLAGS_VM) ||
> > > +           ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
> >
> > I just realized I have no idea why we check X86_CR0_PE and
> > X86_EFLAGS_VM here. Commit 6906e06db9b04 ("KVM: nSVM: Add missing
> > checks for reserved bits to svm_set_nested_state()") says it's to do
> > the same checks as VMRUN, but I don't think that's actually the case?
> > The checks here seem arbitrary to me?
>
> Again, this is L1 state when L2 is active (the !KVM_STATE_NESTED_GUEST_MO=
DE path
> has already bailed), and VMRUN "can only be executed in protected mode wi=
th SVM
> enabled".  Amusingly, the APM says #VMEXIT "Forces CR0.PE =3D 1, RFLAGS.V=
M =3D 0.",
> so I guess it means business.
>
> If anything is wrong, it's the CR0.PG check.  Presumably that got carried=
 forward
> from commit c0725420cfdc ("KVM: SVM: Add helper functions for nested SVM"=
).  I
> don't see anything in the APM that requires paging to be enabled, and not=
hing in
> that ancient series points at concrete documentation either.

Oh yeah you're right, for some reason I thought it was paging not
protected mode. Well then, it seems like
nested_svm_check_permissions() is also incorrectly checking paging as
well, seems like both checks are incorrect? Also, I don't see anything
in the APM about checking RFLAGS.VM before VMRUN.

If the goal here is to keep the checks here consistent with
nested_svm_check_permissions(), aside from the new EFER check, then
maybe we should also check CPL here?
