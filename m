Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547E379EE2
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775769677; cv=none; b=K/CDaXpVZaPn6wfTNnWn1GTgFphfBLtxrZedR4enyfoHVsVsmGugCo+l+KpZpamtm6k+IfSqU//c3S8Oyl52b2ViLy2ALGa4AsePIyoJZ5eRpUpMYw7Nlb1YeTp+81oo+z/fxtM0eUmRcW9unNF2uzwZ4Y8AcD7zuV44Y3Wsx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775769677; c=relaxed/simple;
	bh=2wHI8W/EXibXyk6vk6DiujQnKf/gejgiKm+JT7pH3FA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TiUR+9OZDay1rGhLUXFXHIOogTtqFviHa0nBsmJA4Qu+BQcClzpBGls8zQ7f5sgZxTgk0/0RDp3O21qiMO8G8SL1mNSspnOtGasYL7Npo2YMy6Q1wcWF0xcxw1dhO/KB4tFqcax3DcH+kYp7S+q5ob51jqZbI5wyFl7T2cs67jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pS7cZDcl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pS7cZDcl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c769b25315eso1743912a12.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775769676; x=1776374476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewFyxwGAGIIyCKqaXz10XpbtyAsV1BgckZS9sWmcPds=;
        b=pS7cZDcl4T/nSgmnt36+fC6uZOgSDbn5yEGgQ3MCToahUJMMVtgEqxFFZPQ3kw+sj0
         6mqygZfons6YWJmkwVbSPigpQCqxgKjdwXBfYy0fwyPGNN4tgzBVtWtVEkLqQ7sjIelI
         vkKK35U2wG8gChYIzLaLYioSbgvQJ7ttKI11c7KxAv5z+4u0Otr4yVA26dR3RFevMh1r
         sgF+LCW2vrjs17gkbT3+ZrkjeQ55xKC2lnZd7exq+97sUmThMeYGx3hDqYMkMXb3udSo
         ylbgZHfEWpgo54Ak7gvFhDjAUTKkupVvb2YA5RTABrh1o0VJr284yl89rnRLn+RQumHB
         aJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775769676; x=1776374476;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ewFyxwGAGIIyCKqaXz10XpbtyAsV1BgckZS9sWmcPds=;
        b=A0Osf9CBmlUhh+0imMv2kUNkdqUHRrhupzyIQcnBin2rK5Yqq0wPIO2xko98Gxwd1P
         BFg+eZNF8U8WOwPlUlCKMcQucbDzVpXKDlRTMHZhGLf5PyKMWo3KRpL+KP6H501/bJTS
         lkfxrSRarKJF450V1Wc04OH9r9rMjGu/GFceiBLL8Bzqd+50BLM+v46VZ3SnscaVqilf
         jD2Y/8uJ+KMM0gujKjeREC6VZO6gJ18WMTk/Tg44q6amHs7Rj9+MIjVMAPNJb/T9j4zR
         cKcLv4lB0LvvcItmrUfvm7amJwKWNmv34n88i5uZALYCP02lHjPpPNo/I1H9NRR0t9M1
         Bmhw==
X-Forwarded-Encrypted: i=1; AJvYcCU+UiNvpz9d3p/7v8Fs0/vcnq9HUE40dw2ihPeiiJSFUEoskutihIChgMNWznWJp4YfTfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/meEdbus0oPvbvaVwjFYiDjj6X46FaznnC8lO3ulkluI1GJgO
	+MVM+EWMn32LFLOYkiO2WRbnudy4j55b1chK8WSLdrHU+HlyzcRBkLeHr/oyJcIz3AMkKVozayA
	rbho4Rw==
X-Received: from pgr27.prod.google.com ([2002:a63:115b:0:b0:c74:1919:890f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e083:b0:398:9d1e:1c6
 with SMTP id adf61e73a8af0-39fe3791a90mr580399637.0.1775769675591; Thu, 09
 Apr 2026 14:21:15 -0700 (PDT)
Date: Thu, 9 Apr 2026 14:21:14 -0700
In-Reply-To: <adfyKU5WUiW4OnUg@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com> <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com>
Message-ID: <adgYSnE-I1Z19fCY@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026, Sean Christopherson wrote:
> On Thu, Apr 09, 2026, Jim Mattson wrote:
> > On Thu, Apr 9, 2026 at 10:48=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > > In general, this deferral is misguided. The G/H bits should be
> > > > > > re-evaluated before we call kvm_pmu_instruction_retired() for a=
n
> > > > > > emulated instruction.
> > > > > >
> > > > > > > ...
> > > > > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > > > > index f1c29ac306917..966e4138308f6 100644
> > > > > > > --- a/arch/x86/kvm/x86.h
> > > > > > > +++ b/arch/x86/kvm/x86.h
> > > > > > > @@ -9,6 +9,7 @@
> > > > > > >  #include "kvm_cache_regs.h"
> > > > > > >  #include "kvm_emulate.h"
> > > > > > >  #include "cpuid.h"
> > > > > > > +#include "pmu.h"
> > > > > > >
> > > > > > >  #define KVM_MAX_MCE_BANKS 32
> > > > > > >
> > > > > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struc=
t kvm_vcpu *vcpu)
> > > > > > >  {
> > > > > > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > > > > > >         vcpu->stat.guest_mode =3D 1;
> > > > > > > +
> > > > > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > > > > >  }
> > > > > >
> > > > > > This happens too late for VMRUN, since we have already called
> > > > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction=
(), and
> > > > > > VMRUN counts as a *guest* instruction.
> > > > >
> > > > > It's just VMRUN that's problematic though, correct?  I.e. the sch=
eme as a whole
> > > > > is fine, we just need to special case VMRUN due to SVM's erratum^=
Warchitecture.
> > > > > Alternatively, maybe we could get AMD to document the silly VMRUN=
 behavior as an
> > > > > erratum, then we could claim KVM is architecturally superior. :-D
> > > >
> > > > Here, it's just VMRUN. Above, it's WRMSR(EFER).
> > >
> > > But clearing EFER.SVME while in the guest generates architecturally u=
ndefined
> > > behavior.  I don't see any reason to complicate PMU virtualization fo=
r that
> > > scenario, especially now that KVM synthesizes triple fault for L1.
> >=20
> > L1 can clear the virtual EFER.SVME. That is well-defined.
>=20
> Gah, I forgot that the H/G bits are ignored when EFER.SVME=3D0.  That's r=
eally
> annoying.

What do you think about having two flavors of kvm_pmu_handle_nested_transit=
ion()?
One that defers via a request, and a "special" (SVM-only?) version that doe=
s
direct updates.

Poking into PMU state in arbitrary contexts makes me nervous.  E.g. when ca=
lling
svm_leave_nested(), odds are good EFER isn't even correct, and the update *=
needs*
to be deferred.

I definitely don't love having two separate update mechanisms, but it seems=
 like
the safest option in this case.
