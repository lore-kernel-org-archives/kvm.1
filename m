Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995F7262F
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755339; cv=none; b=EeN2WZYU4jILaj4qKQ6lWL8fF+h471vpHu/ObADXvvcwvTB5yxVD2QjD0l/9LK0Wd5qUAa57LeIxPcgNXzMbHKQkQYfNmgTe5QdrpM3oA6gWa2Wi9vI+UjrqnnLtv2VtHYPEWawOAf7/9AtfghPdwaekGXkjW1PJ0yg7EGEdQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755339; c=relaxed/simple;
	bh=oKOYQvL+RSVeeW5SHEJBe5Ei5pbJxSkrujvsECGwHgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7uq8a+BWofOUlt3pzhdkm0JworMsQ0UgVsNwQ5wL4DL1WG3eB/mWT3D1cZ/k6fQyLOWs5GzJmU1E8jI2NkOmTV5y5LYyFWPNwuSsRanQx/dgIIhr3yBnwSZ9wkNQcqz9W2g81PF1WRV2MOV5swgsM78T5H34NLnskRYEujaA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDgwHT9s; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDgwHT9s"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce50e6e28so773386b3a.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775755337; x=1776360137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iurhQmyvwXtb6sJBDt0qYeQ4sQhVGA5gNXILqM+/3uQ=;
        b=dDgwHT9soHLXueGCGpRJbvT6y7uXFWiunPfU5/bVjcoW+tOCWLhK5xm2wNbFDcn/oj
         Bg+piByqYPudC4m2/tXh6My60+CLYqo8AB7YFaZSIvournioYz97djcPvZDpcRC744ir
         axkEUgTzkMP3qfTifGhRoFZHbUMh1WWwCWmjzwDXz4hEnbaKBl3ymlp5fKmIkehSzrKt
         HDTqlEoVMCxNXYKwxIH/E47lqDO+t3y3yF8O6lwan7RMMGY8HW/SS5TMLH5+w1X9n+d2
         /ZNtd8X8xhh5rRHCn0aFcD3imQZylPAhaSOXIM13rAs8uSrfIWgxk4Pp3kKCF0/80/1+
         14Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775755337; x=1776360137;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iurhQmyvwXtb6sJBDt0qYeQ4sQhVGA5gNXILqM+/3uQ=;
        b=FPLPDs2eT9slUsVUncHP8SdU8LHz37TduDgWYAEMwAAJCjTTw0mk7YWf58iIk41HFu
         8mBqTYPhEqSAQ87nHFgU+CTjFGwVxa7PNcE/5n79NUhc/o9ViCOeRSDQHaKQu7jJfHUT
         0Z6OAsVQ3oI3jtQq3Of5CGneOsFCBfDSFPxlrer11DeZyXEupvxF7KWwUCZWdMBgKTxx
         uuYn+ABXrBeK4I4/4A7VU3yhMskXhNDYgoZx+kLhT22pQ1eaJiQvnlUHXHT3Cvf+GK47
         AhrmYGrO27mEy+6DKWa1D2kY8HDqCJC39PH/Ioce9/fVGmF7MbD2ImAJDq0B/OOCRbC1
         0PvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzG7/MUhK2dgQWQmyotR7136szp8rZ2xC8YXZPp7aNVdHCDw7xnv0fCzbnWwT10aj2b8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTFNlCBkIfr2DKPS0t6H4J+aakdeMKYy3kSS1UvbzRv6U5WX1
	GKfn7S8fp/twLet4vU+ui63kITiBCYsk2w58AX1MV3sB8nMfpgGKrp4o3/dxfMDluTNMrbNjdHQ
	02K2CLw==
X-Received: from pfwo8.prod.google.com ([2002:a05:6a00:1bc8:b0:829:874e:d076])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1903:b0:824:b181:f492
 with SMTP id d2e1a72fcca58-82f0c32b625mr30808b3a.45.1775755336850; Thu, 09
 Apr 2026 10:22:16 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:22:07 -0700
In-Reply-To: <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
Message-ID: <adfgPwgXz1iQHpVS@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026, Jim Mattson wrote:
> On Wed, Mar 25, 2026 at 8:12=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > index bdbe0456049d0..fb73806d3bfa0 100644
> > --- a/arch/x86/kvm/pmu.h
> > +++ b/arch/x86/kvm/pmu.h
> > @@ -248,6 +248,19 @@ static inline bool kvm_pmu_is_fastpath_emulation_a=
llowed(struct kvm_vcpu *vcpu)
> >                                   X86_PMC_IDX_MAX);
> >  }
> >
> > +static inline void kvm_pmu_handle_nested_transition(struct kvm_vcpu *v=
cpu)
> > +{
> > +       struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> > +
> > +       if (bitmap_empty(pmu->pmc_needs_nested_reprogram, X86_PMC_IDX_M=
AX))
> > +               return;
> > +
> > +       BUILD_BUG_ON(sizeof(pmu->pmc_needs_nested_reprogram) !=3D sizeo=
f(atomic64_t));
> > +       atomic64_or(*(s64 *)pmu->pmc_needs_nested_reprogram,
> > +                   &vcpu_to_pmu(vcpu)->__reprogram_pmi);
> > +       kvm_make_request(KVM_REQ_PMU, vcpu);
> > +}
>=20
> In general, this deferral is misguided. The G/H bits should be
> re-evaluated before we call kvm_pmu_instruction_retired() for an
> emulated instruction.
>=20
> > ...
> > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > index f1c29ac306917..966e4138308f6 100644
> > --- a/arch/x86/kvm/x86.h
> > +++ b/arch/x86/kvm/x86.h
> > @@ -9,6 +9,7 @@
> >  #include "kvm_cache_regs.h"
> >  #include "kvm_emulate.h"
> >  #include "cpuid.h"
> > +#include "pmu.h"
> >
> >  #define KVM_MAX_MCE_BANKS 32
> >
> > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct kvm_vcpu=
 *vcpu)
> >  {
> >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> >         vcpu->stat.guest_mode =3D 1;
> > +
> > +       kvm_pmu_handle_nested_transition(vcpu);
> >  }
>=20
> This happens too late for VMRUN, since we have already called
> kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction(), and
> VMRUN counts as a *guest* instruction.

It's just VMRUN that's problematic though, correct?  I.e. the scheme as a w=
hole
is fine, we just need to special case VMRUN due to SVM's erratum^Warchitect=
ure.
Alternatively, maybe we could get AMD to document the silly VMRUN behavior =
as an
erratum, then we could claim KVM is architecturally superior. :-D
