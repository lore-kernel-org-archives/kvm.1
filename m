Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AEA33BBD7
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821588; cv=none; b=IywFI+ErjeKSfYVvePjCbRqeKo8h2KcPU0M9HPMkHd81y0xR3pXxv/WMBINAhhMW9QQ/4Ux1lvnINGDa8CyIn/9DRbXL3mMa6+/OxzVaB1ZFLJ1CO+zx0AHYY0nM1bJSClfaZIfKIsZBgSjUCkF06rMVR5Lvf6QjFHZYqHFI+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821588; c=relaxed/simple;
	bh=nHWKESLNLKIYqIEoYmwgZTbDYK428g/steFbyt/rhVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APOBY+k/CkOwWMWgPCM8MoYZrLC9ZvwfeB9J+dWf/cFvxQL9x1WP3fyUzRItIoEMwg9TqHCTufgct+2u3D21160lAAtuZdqxBXWBT0om/ESbvdIx5BIQh17q4jukGlAcP+fL8IQlPbkZpRKzVNHwJVXtJydVeEg/WmFw7k6g1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyG8wmnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyG8wmnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1BC1F00A3E
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779821587;
	bh=ji5ELC9qqcq+6qVrUCFcEJP2/xaFB1AguBrbrHljg0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WyG8wmnXR+w83dEotYUQKj65cuYPyd8reIla2Nsx4b7Q+Vla1J3lAZE8U90w5UoEP
	 g5hG0Gz84bgH0KSnQTC5Z2FY14GX+haUWGcCb68P9lekiFCu6VA5NLvx22cUn3qvTy
	 0HdtnUp3qQ4vJXGKfSIQuY4xAXcOtdAUwvzV/H0/duCD2fj0Ck3WmJP62ATz4z+o7I
	 fdfTSH4KujW43MeC0ojkO+m4XNgcB0P53ictHoPrRzYscFk4xd+fhSq1g9axmPkU9n
	 cfQTUfju85Jiabl5eLk6wPT1ywTcc98A4rFwRfE/SOLRWFGw4c/zqMB34zbA2ljrMt
	 rG4mihshKPBnQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso7724903a12.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:53:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ctOppA178bdT23Y8/RWbyX8Fv+mjzbdSvj72f4NFcgMBbJlthuwgcYHHAwwuAubaJu1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfHiE96x0nW72m219oV2aWcX4oxDNpitbQ59Dc4PFGnk6SY2M
	aB4n394+/SJVv42deH/HFKvoESjE0QdU2R6sbswHZwWvtI57PntbRkiUr8Y44xlZK904hELxiMN
	hLEBLpQAuuzZnKTuA4suMKZdr8+tYuRM=
X-Received: by 2002:a17:907:9810:b0:bd8:d86d:568a with SMTP id
 a640c23a62f3a-bdd2b1dc044mr1157847466b.47.1779821586124; Tue, 26 May 2026
 11:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-3-seanjc@google.com>
 <CAO9r8zMVVd6LgBRujJZs9mjWp6Fy4SFxbrGUBNBMsSRFw7krsg@mail.gmail.com> <ahXrDZaVL4fKciUQ@google.com>
In-Reply-To: <ahXrDZaVL4fKciUQ@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 26 May 2026 11:52:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPA-ZpNo7=S22psZ7aoTvwYUnXWx6u=tNVud0Ze78BOBg@mail.gmail.com>
X-Gm-Features: AVHnY4IUtIsRZQzdpOsxGyxTZvErxhE_O1HPl_tBo9aA4oyP1pUt5XxkO_TqdgA
Message-ID: <CAO9r8zPA-ZpNo7=S22psZ7aoTvwYUnXWx6u=tNVud0Ze78BOBg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] KVM: x86: Tell ->inject_page_fault() whether or a
 fault came from hardware
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 11:48=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Tue, May 26, 2026, Yosry Ahmed wrote:
> > On Fri, May 22, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > When injecting a page fault (including nested TDP faults into L1), te=
ll the
> > > injection routine whether or not the fault originated in hardware, i.=
e. if
> > > KVM is effectively forwarding a fault it intercept.  For nested TDP f=
ault
> > > injection, KVM needs to grab PAGE_WALK vs. GUEST_FINAL information fr=
om the
> > > VMCB/VMCS, _if_ the fault originated in hardware.
> > >
> > > No functional change intended (nothing uses the new param, yet...).
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
> > >  arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
> > >  arch/x86/kvm/svm/nested.c       |  3 ++-
> > >  arch/x86/kvm/vmx/nested.c       |  3 ++-
> > >  arch/x86/kvm/x86.c              | 16 +++++++++-------
> > >  5 files changed, 28 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/k=
vm_host.h
> > > index 271bdd109a98..d11063c36f03 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -484,7 +484,8 @@ struct kvm_mmu {
> > >         u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
> > >         int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_faul=
t *fault);
> > >         void (*inject_page_fault)(struct kvm_vcpu *vcpu,
> > > -                                 struct x86_exception *fault);
> > > +                                 struct x86_exception *fault,
> > > +                                 bool from_hardware);
> >
> > Probably a bit late to ask this question, but why do we need
> > from_hardware (or the previous hardware_nested_page_fault) as opposed
> > to just checking exit_code / exit_reason? Is it possible to get an
> > NPF/EPT violation but then synthesize a different one into L1 rather
> > than forwarding the one we got from HW?
>
> Yes.  E.g. if access to emulated MMIO from L2 hit a !PRESENT fault (EPT V=
iolation
> or #NPF), e.g. because MMIO caching is disabled or it's the first time th=
e GPA has
> been accessed by L2, then KVM will enter the emulator.  If emulating the =
MMIO
> access then hits a TDP fault, e.g. because L2 was accessing MMIO with a M=
OVQ
> (memory-to-memory move), or because L1 has since unmapped the code stream=
, then
> the TDP fault synthesized to L1 will not be the "same" fault the triggere=
d the
> VM-Exit.

Interesting, thanks for the example. Probably worth documenting this
somewhere (changelog? comment?).
