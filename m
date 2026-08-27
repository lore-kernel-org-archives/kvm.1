Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162074A2E1F
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853335; cv=none; b=eSHAM7PZOCE0mIn836cG5WSCSWb5P0UBgmcUZQKl15fJ3vOW49PhQUDeVfvQxWgycn9KgObm/0+cV17H5ENr3hFr16EI9PsPOxwZchHC9KdX2gYls67KibOXdrGUTieayvXVZrPtk08o0rMfMDKO0D8YYNbddG77+fjpOi2E9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853335; c=relaxed/simple;
	bh=JquNSy4x+4LWMK12YHrDgFVH96J4CylpGTzlZ6A+yuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPn6A/afFRIyPqDjQTM8UsLF6S7fgQAH7jkTggS4bGI4IDGQylssDuYQYWG6epRZqkOTRuEJ5T9uaZD5T1ngTs8uUVhGnFHtqLDACHfNlvyY5575orfzwOP3yxyLyWjv7lTVVVnU62jWPHJ9pBgSoXlr+tts26GKvqj15uK2oOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqyCQCh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqyCQCh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73561F000E9
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787853328;
	bh=J0OapQGESg1AGMSebGOFhwIaFUe07bM0WphS89XQMkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GqyCQCh/Z0GVCHvMNP3XKvWd4KGH1srRW7ir5f7zgF8+AqP0KCwpcmotAbyASSEeq
	 AjklrRkNmbXozU0/WBhsS0Dz9cXBkneKvmVsYpLef8V88wk3xAM86MyKqwvV98u5ms
	 TqhEErKYVCB1uDrSUhB5DJEHy80AgjRt3q2A7ygVMFjVC/PZXF1XPsmqr2huei9ura
	 +V5FXs7qgnzS/C8kadRVmHMIEGjfr6Mtg62u6z2QCD+0eDOpYPIh59MNLubMvhtdym
	 ugmo1wbWz5E7KO5cN4oPW3eps237uLivSps+aXZL4YcOQ0Gu3ZZuYzHOG/UkRXsNX4
	 LZwc+Pggac5xg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c255206b4dfso19423166b.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 10:55:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpv/H9/MH4NHB6ouQSAUWuIgn2unuwyN6zCtQarcOLpQbOWeIWFbVKuq329Mz7VGvjfPmc=@vger.kernel.org
X-Gm-Message-State: AFuF++nYrjOl2kwDEdLtSqYgeOlivvdKBsK1p+pnNHRWCFRXocTk0YZu
	tX2Y9pop/N6zI2jD9bw8UGYOpJ5rh7NVvujGmEK9Fks80g4QsFkumRvZOmMg0/IEUJHkQQW5j+B
	gPX0KnnVWCPNA6VHGPljpNkhP0jEna2s=
X-Received: by 2002:a17:907:1988:b0:c25:4cff:5cf5 with SMTP id
 a640c23a62f3a-c2557181532mr37092066b.14.1787853327732; Thu, 27 Aug 2026
 10:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-2-seanjc@google.com>
 <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
 <apA9eLuaMxCLdCmn@google.com> <CAO9r8zNm1QcVh29rTCzAFnYdUCS4y8ZSQOvrs2DD18XASuktoQ@mail.gmail.com>
 <apB1A5Ln_lGTI4oy@google.com>
In-Reply-To: <apB1A5Ln_lGTI4oy@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 10:55:14 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPtriVwkVqmvRDv5mQ8HmvOp=NrXdJvjRuog6FY_S1DRQ@mail.gmail.com>
X-Gm-Features: AcwNN1WqOh8rFfqyGrYERI0p2r1fGiTKetWhpzfBQCuYNbXaxs2qnIWnH_Pl58k
Message-ID: <CAO9r8zPtriVwkVqmvRDv5mQ8HmvOp=NrXdJvjRuog6FY_S1DRQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Thu, Aug 27, 2026 at 6:37=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > > > On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > >
> > > > > Reject KVM_SET_NESTED_STATE if the incoming L1 host state has wha=
t is
> > > > > effectively an impossible EFER combination of LMA=3D1 but LME=3D0=
, i.e. if the
> > > > > state says long mode is active but not enabled.  Unlike VMX, SVM =
doesn't
> > > > > have an explicit consistent check for the illegal combination; pr=
esumably
> > > > > hardware simply ignores EFER.LMA if EFER.LME=3D0.
> > > > >
> > > > > Unfortunately, KVM doesn't ignore EFER.LMA in this case and consu=
mes the
> > > > > illegal state when constructing the shadow MMU for L2.  E.g. if u=
serspace
> > > > > also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role=
 with 4 or
> > > > > 5 levels of paging, but shadow_mmu_init_context() will wire up th=
e MMU to
> > > > > use the paging32 template, which maxes out its levels at 2.
> > > >
> > > > Isn't the "right" thing to do what hardware (presumably) does and
> > > > ignore EFER.LMA if EFER.LME=3D0?
> > >
> > > No, because (a) this is KVM uAPI, not emulation of hardware, and (b) =
it's a check
> > > on L1 state, not L2 state.  It should be impossible for L1 state to h=
ave this
> > > combination through "natural" means, and so a snapshot provided by KV=
M should
> > > never have this combo either, which there's zero reason to allow user=
space to
> > > provide garbage.
> >
> > Right, I understand that KVM can do whatever it wants here. I was wonde=
ring
> > if we wanted to make the uAPI behavior match the  VMRUN behavior, but I=
 guess
> > we're free to make it more strict.
>
> But again, this *does* match VMRUN behavior, because it's impossible for =
L1 to
> have EFER.LMA=3D1, EFER.LME=3D0, and EFER.PAE=3D0 at the time of VMRUN.
>
> > > > > Note, the "real badness" is effectively the same as what happened=
 with the
> > > > > nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing co=
nsistency
> > > > > checks for CR0 and CR4").  Unfortunately, the sanity check added =
by commit
> > > > > 72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long=
 mode
> > > > > without PAE enabled") doesn't work for this case, since L2 state =
is active
> > > > > at the time of the page fault, but it's L1 that has the bad state=
.
> > > > >
> > > > > Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE a=
nd KVM_SET_NESTED_STATE")
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: Yosry Ahmed <yosry@kernel.org>
> > > > > Reported-by: Stefan Teodorescu <fane@google.com>
> > > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > > ---
> > > > >  arch/x86/kvm/svm/nested.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.=
c
> > > > > index 73f37b050d0a..49fb10ad1f9f 100644
> > > > > --- a/arch/x86/kvm/svm/nested.c
> > > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > > @@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_=
vcpu *vcpu,
> > > > >         if (!(save->cr0 & X86_CR0_PG) ||
> > > > >             !(save->cr0 & X86_CR0_PE) ||
> > > > >             (save->rflags & X86_EFLAGS_VM) ||
> > > > > +           ((save->efer & EFER_LMA) && !(save->efer & EFER_LME))=
 ||
> > > >
> > > > I just realized I have no idea why we check X86_CR0_PE and
> > > > X86_EFLAGS_VM here. Commit 6906e06db9b04 ("KVM: nSVM: Add missing
> > > > checks for reserved bits to svm_set_nested_state()") says it's to d=
o
> > > > the same checks as VMRUN, but I don't think that's actually the cas=
e?
> > > > The checks here seem arbitrary to me?
> > >
> > > Again, this is L1 state when L2 is active (the !KVM_STATE_NESTED_GUES=
T_MODE path
> > > has already bailed), and VMRUN "can only be executed in protected mod=
e with SVM
> > > enabled".  Amusingly, the APM says #VMEXIT "Forces CR0.PE =3D 1, RFLA=
GS.VM =3D 0.",
> > > so I guess it means business.
> > >
> > > If anything is wrong, it's the CR0.PG check.  Presumably that got car=
ried forward
> > > from commit c0725420cfdc ("KVM: SVM: Add helper functions for nested =
SVM").  I
> > > don't see anything in the APM that requires paging to be enabled, and=
 nothing in
> > > that ancient series points at concrete documentation either.
> >
> > Oh yeah you're right, for some reason I thought it was paging not
> > protected mode. Well then, it seems like
> > nested_svm_check_permissions() is also incorrectly checking paging as
> > well, seems like both checks are incorrect? Also, I don't see anything
> > in the APM about checking RFLAGS.VM before VMRUN.
>
> Presumably it's covered by the !PROTECTED_MODE clause.
>
>   IF ((MSR_EFER.SVME =3D=3D 0) || (!PROTECTED_MODE))  // This instruction=
 can only be executed in protected
>     EXCEPTION [#UD]                               // mode with SVM enable=
d
>
> Section "1.3.4 Legacy Modes" describes "Protected Mode" and "Virtual-8086=
 Mode"
> as separate submodes.  And the tables for most instructions differentiate=
 between
> Real, Virtual 8086, and Protected modes when enumerating exceptions.
>
> The APM weasels around 64-bit mode by also saying "Before enabling and ac=
tivating
> long mode, system software must first enable protected mode".  E.g. the t=
able for
> SYSENTER describes the #UD due to "This instruction is not recognized in =
long mode"
> as scenario that's unique to Protected Mode.
>
> Stating the obvious, it would be lovely if the APM explicitly stated what=
 the
> exact checks are, though that's about as likely as AMD gifting me a pony.
>
> FWIW, if that reading is wrong (though I'm pretty sure it's not), then th=
e only
> issue is that KVM is synthesizing #UD instead of #GP, because Virtual 808=
6 always
> runs at CPL=3D3.
>
>   IF (CPL !=3D 0)                                   // This instruction i=
s only allowed at CPL 0
>     EXCEPTION [#GP]

I see, thanks for digging this up. Either way I think we want to keep
things consistent between here and nested_svm_check_permissions(). We
probably want a CPL check here, and it would be a superset of
X86_EFLAGS_VM as you mentioned. We probably wanna drop the CR0.PG
check from both places, and add an explicit X86_EFLAGS_VM check in
nested_svm_check_permissions() to #UD instead of #GP?

>
>
> > If the goal here is to keep the checks here consistent with
> > nested_svm_check_permissions(), aside from the new EFER check, then
> > maybe we should also check CPL here?
