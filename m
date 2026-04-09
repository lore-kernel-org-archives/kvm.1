Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4398BE9
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756890; cv=none; b=LSavgTOm2sdH3jPqX0CExQMoGsJ8GtBZJsjXSME3wdHwLtBttGCMVyf1FuvB0W+e9fSxXma2OFTBgWpNjsYBH30IuCFq5uZM90b4dRYGWpmx5CBjuZGlAcVdjI22DufS9lUwNQIMoHenp0aO4ymJkmYjvDLwOAeByoWKoe44SQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756890; c=relaxed/simple;
	bh=aIAfMrSA8cUJIyUiAkRbPYFZeiE3TInt/dDEE4o2+nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vxr4Afd1NudzSXxRO0VUAIm9hJCVPw18Ke5TBT+jOOpic7nCkCMAuOy6oj1erwLrF24Ci9KYK9Jz7Wxdt+ywEQCQBH9iedIAIOEjzzzRXC8xDAGH7MuuXKNxz9yzCxhE1zEJP0Qidc6ZBowXsjgXXreUCipihSCAmOR27KgZAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WalItd6m; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WalItd6m"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso875478a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775756889; x=1776361689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACR+kdrs5Iw2VxQZkb2RkoTFQ3C4xCdBdInTN5Gc/ZE=;
        b=WalItd6mH1nFFid5c/SA+NKPcQqok96YvavJjhZ8Sl6rXDvkqNsGm8V/5KUIZkJ5cb
         33C8FuHcU2FpVzBH7g5h3rm+dRo8iasA8uF8xK4Ez3RLfX9PivmttSpIninX3NsHO1bx
         IP/Dc470ybE1Xw7AWsU4F/j+Ujyhvdsu+O66SPfBzgQHTJ8GKsr/7yxChkT8uTFtHdv0
         AHYn4N5x5vB9eCvitLWPRp5f2Cl9ZQUpyh1L1pEI6qbEzkybD3NALLr+oujaqKqHevuF
         lYQWlUu1s+MNOWwasvqHwUwZi9BxeRNfTLWyk1D2Xjpzzd6RFs1twFVQBquuI0sY53kM
         Milw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775756889; x=1776361689;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ACR+kdrs5Iw2VxQZkb2RkoTFQ3C4xCdBdInTN5Gc/ZE=;
        b=HjSiPK2D8lz4vXakU7Uh72OPBoFYtzWLjiEDUECombj7TnjuHTV8UsgvIJjj6nkCuK
         62xX59sNW4jqJZxblgvTgMTTNEQsgjtdhxqiCrBRxrGE2CrSzuiKJnv9f7Fhajl2bIqU
         UyCgCM6vhEY8Ywt7Ph+DGiMdDDSA9hqbW0Da4WO8RssN6NCqimzoN6YdO0kfs02lJfIU
         +r2AUBD0x7yxLluwy8ZIwj7deWJriQ3VJdHId+IdGb4nw0mZQfvneYwLe2F9EneL3LZz
         azYjy10k+aUcxRFTGKQzL5zPwJnzMaNo2nJqT6WzP1z0b94wIfJDda358yAYUUypZsf1
         io5g==
X-Forwarded-Encrypted: i=1; AJvYcCXSNmFrjzQrAwOegUK1cEY8q8HQL0H9IE6eDQfJYvUT03LEuILqLUCOIEtzDcsv1dZTPP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8pL68O5nFmsc5Gso0Dt29w86N3ssdh/LNj7/jxktVnf2e4wv
	T7oN6QnO8PGEl9cJxN1lI5fAXquX5ffFE0lgindfBt8V7x4hbg3OZuhBes6fz+n08VnfKfgxIkq
	8T8m8rA==
X-Received: from pfbjr29.prod.google.com ([2002:a05:6a00:915d:b0:82c:63f8:59dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3987:b0:81f:3afe:281e
 with SMTP id d2e1a72fcca58-82f0c12fbd5mr185066b3a.3.1775756888433; Thu, 09
 Apr 2026 10:48:08 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:48:05 -0700
In-Reply-To: <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
Message-ID: <adfmVXRwzZkvRSnj@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026, Jim Mattson wrote:
> On Thu, Apr 9, 2026 at 10:22=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Apr 08, 2026, Jim Mattson wrote:
> > > On Wed, Mar 25, 2026 at 8:12=E2=80=AFPM Yosry Ahmed <yosry@kernel.org=
> wrote:
> > > > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > > > index bdbe0456049d0..fb73806d3bfa0 100644
> > > > --- a/arch/x86/kvm/pmu.h
> > > > +++ b/arch/x86/kvm/pmu.h
> > > > @@ -248,6 +248,19 @@ static inline bool kvm_pmu_is_fastpath_emulati=
on_allowed(struct kvm_vcpu *vcpu)
> > > >                                   X86_PMC_IDX_MAX);
> > > >  }
> > > >
> > > > +static inline void kvm_pmu_handle_nested_transition(struct kvm_vcp=
u *vcpu)
> > > > +{
> > > > +       struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> > > > +
> > > > +       if (bitmap_empty(pmu->pmc_needs_nested_reprogram, X86_PMC_I=
DX_MAX))
> > > > +               return;
> > > > +
> > > > +       BUILD_BUG_ON(sizeof(pmu->pmc_needs_nested_reprogram) !=3D s=
izeof(atomic64_t));
> > > > +       atomic64_or(*(s64 *)pmu->pmc_needs_nested_reprogram,
> > > > +                   &vcpu_to_pmu(vcpu)->__reprogram_pmi);
> > > > +       kvm_make_request(KVM_REQ_PMU, vcpu);
> > > > +}
> > >
> > > In general, this deferral is misguided. The G/H bits should be
> > > re-evaluated before we call kvm_pmu_instruction_retired() for an
> > > emulated instruction.
> > >
> > > > ...
> > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > index f1c29ac306917..966e4138308f6 100644
> > > > --- a/arch/x86/kvm/x86.h
> > > > +++ b/arch/x86/kvm/x86.h
> > > > @@ -9,6 +9,7 @@
> > > >  #include "kvm_cache_regs.h"
> > > >  #include "kvm_emulate.h"
> > > >  #include "cpuid.h"
> > > > +#include "pmu.h"
> > > >
> > > >  #define KVM_MAX_MCE_BANKS 32
> > > >
> > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct kvm_=
vcpu *vcpu)
> > > >  {
> > > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > > >         vcpu->stat.guest_mode =3D 1;
> > > > +
> > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > >  }
> > >
> > > This happens too late for VMRUN, since we have already called
> > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction(), an=
d
> > > VMRUN counts as a *guest* instruction.
> >
> > It's just VMRUN that's problematic though, correct?  I.e. the scheme as=
 a whole
> > is fine, we just need to special case VMRUN due to SVM's erratum^Warchi=
tecture.
> > Alternatively, maybe we could get AMD to document the silly VMRUN behav=
ior as an
> > erratum, then we could claim KVM is architecturally superior. :-D
>=20
> Here, it's just VMRUN. Above, it's WRMSR(EFER).

But clearing EFER.SVME while in the guest generates architecturally undefin=
ed
behavior.  I don't see any reason to complicate PMU virtualization for that
scenario, especially now that KVM synthesizes triple fault for L1.
