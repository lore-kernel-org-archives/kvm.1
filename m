Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8429204C3B
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759730; cv=pass; b=iyRt3F9+/3tdlB9pJdvtv0FDP3wHEcDSgumZni/OSMWyuBON4rPolBJR82eo6+1qFA80MOdfvXI9chcF4utHgk7xojFHRCdnYQ/n7rQrsqMqm6m1ddZvJYnu3vojYWzrTLOHoX8/vFc8ATaj8HNO7Xqa4JH0gE9QhfQr08FfjvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759730; c=relaxed/simple;
	bh=IOW4RWbFVdTcymMTekrUdqGoVpa2LqhrRznd9NEJRjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4wIixIx9AUTjGmZD2V56iVe4BqUQU+ypbPXVpWkWtZh37XOhbfrkv0dRLqSIifBqu5ySop5upObhysghXZrjr+6L15uWOyPhIxNeZzE9nTTa8x7l+nRhB6/TaLJH0oPVQKIAxntKUHtg6qSf8wHYWYMHkUIEr9PLE5L1Sbbxjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlqCMymM; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlqCMymM"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso15313a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 11:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775759727; cv=none;
        d=google.com; s=arc-20240605;
        b=cHbusTMyQWconH77+VO+r4BcmMQTxYCfk1xTp+wcozi5JIZ2sGHqbvw2roh1mY2hnK
         uRcqHCFS0fLnAotFzGa86QqtKjVpQbYuE8QIWf46HNDtcxmQPLgDpAIrZoOAIDD0n5bG
         DxGFOi+TW2IgHHiSIDjCfiwhbxt9+kY5aS/Edkyk+84e1J6zo6z3EYwApGMe+ArTBpzT
         dUTg4aKbUMeRYltTCOxPMo6CgSCFe6Ev5XQ80OIGpqAevEaGSzA7jGli/wWp5PU4Bxy4
         8FvJsY61LL0n+5RM3fEUnfFoiF3ouRJByirL0CzLoGX8dFo6q6etncpP8RN74K6GLzrq
         71+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G/Qxn6xCdzsa5Aip+820i9pTEZ13cY9GA1m+YwV31yc=;
        fh=ewW1p+d7dDypIN1bKR7bWYsZjQWWQ6AuWt2hUiAPxt4=;
        b=ddxipyLPZ2E6hfQaXJYB7F1ttk6eW1EvH1DSbwZWU+sD/JdN1jNYu4w4dySMZJygW0
         MZMZ35EFMIEsMvMJKa2K/wQmhW1+AWOIfcWclky/Lkv/zdb0/qfp6A9+9hcyQv+zXdMx
         nofxWWvCr9BQ0QBbH9eqazZqcAQEzPksAe63siJE4hXLKnFsododgv7RvYUQZG1BS4dW
         GIB1n1keAlZsamdtoACn0BXoNOftRU9cFECyv1pZ4E2Fgk6VHWVxjc/RMG9jUQkIIiCn
         RUK2uYTChlgqRkFXmgszWgUVUcVpNhFOUNfUMeeHMjLXF2TuA1SdKw84sseP49f2EUIL
         mB9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775759727; x=1776364527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/Qxn6xCdzsa5Aip+820i9pTEZ13cY9GA1m+YwV31yc=;
        b=nlqCMymMhPY1P+TolPtCtT5i9QQcJEmIq6zrZXiKYrrvZNJFLwu6PksQkBvxZnsiRb
         2WPKYd/bTyA/vjFJKMMV48VxmnrdRXkLUH8jCEAEFNd51OIyn9tAs5IHUByKL85egxeL
         zhS7dV96AJI18htNhG4ziGvBInUMew2nK5PKB9+bDc99s2i4gGIPVaUhpD4HywTaVqfa
         4kZY3PbWJIMMiMI/7lKEj5gDZyjoy6rrmJweu0EApvi53HexlAMzCxBDzozEZNYeM5Oc
         rnMkH1ydq3jQmmn+wq5lb6kK7B3+Kss9rr35MgAUlAGLC5QDlJtTnWxZQiLdx9S3UKE7
         Oe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759727; x=1776364527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/Qxn6xCdzsa5Aip+820i9pTEZ13cY9GA1m+YwV31yc=;
        b=kTd5/EhxXQhcBOuefRozfvfP5ZM2PNEoUz6jIqmO/Z/DUNBldmLZzXGkHOO94DfSji
         zs/ozAvQAYx5aaP2dfI1E6Najn6xj0LDfu8hlbCCEuzfi1zvRdyn5AIMLCvEnIu6Genc
         TTRo65KhygMDlJ+0UK+ZyN40NRNvHK2U5gQmGFrUz5Sa9+nAu4GI/ZlJ3dMjsS/z6SFT
         H1sJeZji7maFflWFc24+wpCyaPhGYjmnNvn0n3biPQ1xkrKOClpwmvgGtNl/JIg/OulK
         qZ20GMPIgs6kQFQZ764Wk4IP5cQdF5srk+BJB8EoV8famrreaYZYSyaO55JIa+TY7aNw
         oyzg==
X-Forwarded-Encrypted: i=1; AJvYcCVIcYDfzbIS1JqWRswWScZeNzlpJPhN712Ysz2IkVj44GDnQTTw6iVGkdinLMI33k8Kbmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyATN8WIVVy6eTc53KbArzC3Yf+1O9OzHsosBRzvD5XasLhe0T/
	sbkM6zbT+jDxrW3k7Mu6uE5tylonVa1fmfrJTmcibU/+2rFwbp5VGuQeSqNlWFAwHXZUv2/QU8x
	y8rymIjFS43gLuichkXlGXcK8660zCRFsWW+Yk7zH
X-Gm-Gg: AeBDietFEFlsdwtnfJjD9ME8Epw4OVUw1med02pusNSuslcw88846lULXtKMCkPiYkH
	NBr9j1NQIDTI5vBW4OX2DyDTmxPWajP+cNbPJSASfI1/Np1rDF01yUR2e+SyXzJHHvtt2qePLQY
	LkP6LitFrenv+G2TRc8qp//+E+r/KbM3HSnwCKyWMr3ireyt9qpsfjhU9JRrjzHXU/GQgIOHQ9q
	Y1jsMOZFU1LQcw+7h7lKkXTwdTUJ4Pchix8H0cpnZm/LNcVeIsBXXHjJNAn4nGh0fGPa0+TsUFk
	FIM8YQg5/fsaHFjVgg==
X-Received: by 2002:a50:ed0e:0:b0:664:d536:82f with SMTP id
 4fb4d7f45d1cf-6701e2ab06bmr51315a12.9.1775759726632; Thu, 09 Apr 2026
 11:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com>
In-Reply-To: <adfmVXRwzZkvRSnj@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Apr 2026 11:35:14 -0700
X-Gm-Features: AQROBzDUtk2Z5RI6rrypuwYYQiwR9qM8MZiqRiF77CpjA9pIOk1Cx9Iu39luQ5E
Message-ID: <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 10:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 09, 2026, Jim Mattson wrote:
> > On Thu, Apr 9, 2026 at 10:22=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, Apr 08, 2026, Jim Mattson wrote:
> > > > On Wed, Mar 25, 2026 at 8:12=E2=80=AFPM Yosry Ahmed <yosry@kernel.o=
rg> wrote:
> > > > > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > > > > index bdbe0456049d0..fb73806d3bfa0 100644
> > > > > --- a/arch/x86/kvm/pmu.h
> > > > > +++ b/arch/x86/kvm/pmu.h
> > > > > @@ -248,6 +248,19 @@ static inline bool kvm_pmu_is_fastpath_emula=
tion_allowed(struct kvm_vcpu *vcpu)
> > > > >                                   X86_PMC_IDX_MAX);
> > > > >  }
> > > > >
> > > > > +static inline void kvm_pmu_handle_nested_transition(struct kvm_v=
cpu *vcpu)
> > > > > +{
> > > > > +       struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> > > > > +
> > > > > +       if (bitmap_empty(pmu->pmc_needs_nested_reprogram, X86_PMC=
_IDX_MAX))
> > > > > +               return;
> > > > > +
> > > > > +       BUILD_BUG_ON(sizeof(pmu->pmc_needs_nested_reprogram) !=3D=
 sizeof(atomic64_t));
> > > > > +       atomic64_or(*(s64 *)pmu->pmc_needs_nested_reprogram,
> > > > > +                   &vcpu_to_pmu(vcpu)->__reprogram_pmi);
> > > > > +       kvm_make_request(KVM_REQ_PMU, vcpu);
> > > > > +}
> > > >
> > > > In general, this deferral is misguided. The G/H bits should be
> > > > re-evaluated before we call kvm_pmu_instruction_retired() for an
> > > > emulated instruction.
> > > >
> > > > > ...
> > > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > > index f1c29ac306917..966e4138308f6 100644
> > > > > --- a/arch/x86/kvm/x86.h
> > > > > +++ b/arch/x86/kvm/x86.h
> > > > > @@ -9,6 +9,7 @@
> > > > >  #include "kvm_cache_regs.h"
> > > > >  #include "kvm_emulate.h"
> > > > >  #include "cpuid.h"
> > > > > +#include "pmu.h"
> > > > >
> > > > >  #define KVM_MAX_MCE_BANKS 32
> > > > >
> > > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct kv=
m_vcpu *vcpu)
> > > > >  {
> > > > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > > > >         vcpu->stat.guest_mode =3D 1;
> > > > > +
> > > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > > >  }
> > > >
> > > > This happens too late for VMRUN, since we have already called
> > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction(), =
and
> > > > VMRUN counts as a *guest* instruction.
> > >
> > > It's just VMRUN that's problematic though, correct?  I.e. the scheme =
as a whole
> > > is fine, we just need to special case VMRUN due to SVM's erratum^Warc=
hitecture.
> > > Alternatively, maybe we could get AMD to document the silly VMRUN beh=
avior as an
> > > erratum, then we could claim KVM is architecturally superior. :-D
> >
> > Here, it's just VMRUN. Above, it's WRMSR(EFER).
>
> But clearing EFER.SVME while in the guest generates architecturally undef=
ined
> behavior.  I don't see any reason to complicate PMU virtualization for th=
at
> scenario, especially now that KVM synthesizes triple fault for L1.

L1 can clear the virtual EFER.SVME. That is well-defined.
