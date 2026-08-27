Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517B46A5F2
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837829; cv=none; b=BFRbN8bmqOm2rBcdGvPTOnCHeds1KWnSgldywJUQIU1dBB/VB+klRrDj96pnUUab2hXFprnOlz1Nv+uCRqlx7dE8ZOyXuiXKcbHReEq+HmQwgJCd7ClNe2tzU2ZlwHDnhd68L4AGeFJXoxV11FeqMJOjkWycgmJczLVLUwdREmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837829; c=relaxed/simple;
	bh=PzPQ//3N888B4W7WpBLgZPuKN9uj8wJDCxYUA0dC7PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vBG3rcWajRJp7cNGlTE0IBhbB4py+V4wcdOu6AIkTBXKaxYc41lSsJ3+gceKqO9puo+mzAcYR+9CBJcgIPTvfeQRXQBZwCrHZ8kruQSZ14PGkGci0qDvNTdn2L6ypP66uQ3kSruJs9Q9TX+QoSvTUcRwObx2FGjX9zWd0sjvIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ccbvp4/H; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ccbvp4/H"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so833202a12.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787837825; x=1788442625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uf8jbJIiRq/WvxNg3EyHYESvAPO3ZqkY2PCqLNzqeXQ=;
        b=Ccbvp4/HU/Gz4WOeRG8jizoJAvJa13SVFoQIO1PVunO9TcvVbgqGpaRUZMKeFfeial
         1F2OpcEKFaOlxpBxJ/cCvqpzY9NvxYlCVZeuMUSWcYWPwI57seLm8VmT5i6V8fIw8Eg3
         aZ+TMpo4yReCRbs1K7SjEzhoQaV5HlLRr3JJAcGOwxueqe50OHUWsNW+vySaYWWlwVNN
         3uemHNJ5bvcVDvpNZgbhcHQoVYQl/hviieIdqwMOqlOiUQnUvEHAvi+aQVeMs24idgJ3
         GdmBASv1tNfEczbyiH2IX670UILoj35A+On/wi9sQs4wZy/8Wgt3H03aB+vbFcfkA7pi
         P32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837825; x=1788442625;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uf8jbJIiRq/WvxNg3EyHYESvAPO3ZqkY2PCqLNzqeXQ=;
        b=ProSmy6DGPcXOrswXf5OmxYHjkKEssRrZ3PoqvUS8hRpcQOToKIHVSjQvzlSCU19ta
         aChHMI8z+hTAfymruKUmQwt926NkdWgqacOXxnMWf9mlOrI5JkF+IQHVS3C6XRZw4bkY
         gEgVDhwbpLO4kLIhmV4ZBskK+dS8Jit9Dqt4PuADpa6nGNHZXb8VTRTlxsAZ8Rt85KDE
         lnWkV/UPAaUvChDoMwt492csMZxWohl7xJ3i9HnZ5QQGIlAJJ/N9k+61YEDFBz4IKOOg
         zxExQJrdyDOUiLDVqWvEhUWBz0PtOoOPpWd0uh6Ji3qWRUPk51buzX/Vhxp1VMzfYLQA
         ls3w==
X-Forwarded-Encrypted: i=1; AHgh+RrjReJpQH4GlT5Fz/dip/FUKxhCEikMV8lqlhcYSlJYP173fb/QHprm64hlP9gxYQ/gSRU=@vger.kernel.org
X-Gm-Message-State: AFuF++nBAGwJcd1SZxZKUWilPfk+3iJqjmbfrDbQNg2RjIZxTHF+eY+L
	M3TH8adPT9vx7XVGb6Rvp6969aU2Sq94iN9W5XPa0AB3UoC80+xa56v5hgHFefzVVfy13B/QBnt
	ZJaojQg==
X-Received: from pgbfm25.prod.google.com ([2002:a05:6a02:4999:b0:c88:e5cb:265])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a7:b0:3bf:b9de:8557
 with SMTP id adf61e73a8af0-3d0f5ce43a0mr8650234637.9.1787837824380; Thu, 27
 Aug 2026 06:37:04 -0700 (PDT)
Date: Thu, 27 Aug 2026 06:36:56 -0700
In-Reply-To: <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-2-seanjc@google.com>
 <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
Message-ID: <apA9eLuaMxCLdCmn@google.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Reject KVM_SET_NESTED_STATE if the incoming L1 host state has what is
> > effectively an impossible EFER combination of LMA=3D1 but LME=3D0, i.e.=
 if the
> > state says long mode is active but not enabled.  Unlike VMX, SVM doesn'=
t
> > have an explicit consistent check for the illegal combination; presumab=
ly
> > hardware simply ignores EFER.LMA if EFER.LME=3D0.
> >
> > Unfortunately, KVM doesn't ignore EFER.LMA in this case and consumes th=
e
> > illegal state when constructing the shadow MMU for L2.  E.g. if userspa=
ce
> > also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role with =
4 or
> > 5 levels of paging, but shadow_mmu_init_context() will wire up the MMU =
to
> > use the paging32 template, which maxes out its levels at 2.
>=20
> Isn't the "right" thing to do what hardware (presumably) does and
> ignore EFER.LMA if EFER.LME=3D0?

No, because (a) this is KVM uAPI, not emulation of hardware, and (b) it's a=
 check
on L1 state, not L2 state.  It should be impossible for L1 state to have th=
is
combination through "natural" means, and so a snapshot provided by KVM shou=
ld
never have this combo either, which there's zero reason to allow userspace =
to
provide garbage.

> > Note, the "real badness" is effectively the same as what happened with =
the
> > nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing consiste=
ncy
> > checks for CR0 and CR4").  Unfortunately, the sanity check added by com=
mit
> > 72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode
> > without PAE enabled") doesn't work for this case, since L2 state is act=
ive
> > at the time of the page fault, but it's L1 that has the bad state.
> >
> > Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM=
_SET_NESTED_STATE")
> > Cc: stable@vger.kernel.org
> > Cc: Yosry Ahmed <yosry@kernel.org>
> > Reported-by: Stefan Teodorescu <fane@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/nested.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 73f37b050d0a..49fb10ad1f9f 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_vcpu *=
vcpu,
> >         if (!(save->cr0 & X86_CR0_PG) ||
> >             !(save->cr0 & X86_CR0_PE) ||
> >             (save->rflags & X86_EFLAGS_VM) ||
> > +           ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
>=20
> I just realized I have no idea why we check X86_CR0_PE and
> X86_EFLAGS_VM here. Commit 6906e06db9b04 ("KVM: nSVM: Add missing
> checks for reserved bits to svm_set_nested_state()") says it's to do
> the same checks as VMRUN, but I don't think that's actually the case?
> The checks here seem arbitrary to me?

Again, this is L1 state when L2 is active (the !KVM_STATE_NESTED_GUEST_MODE=
 path
has already bailed), and VMRUN "can only be executed in protected mode with=
 SVM
enabled".  Amusingly, the APM says #VMEXIT "Forces CR0.PE =3D 1, RFLAGS.VM =
=3D 0.",
so I guess it means business.

If anything is wrong, it's the CR0.PG check.  Presumably that got carried f=
orward
from commit c0725420cfdc ("KVM: SVM: Add helper functions for nested SVM").=
  I
don't see anything in the APM that requires paging to be enabled, and nothi=
ng in
that ancient series points at concrete documentation either.
