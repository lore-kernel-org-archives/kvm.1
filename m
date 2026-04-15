Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3C353EC1
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288406; cv=none; b=td/wXRs9QDZOa2SAAdSAgUg1VcY8LrrNg6BVmp1CwIgYIoVi9ZQ2jPLCnWoV7RW52D9NrIfkZuGWipsyLD56uZZT7eVhh6DsF0X/PrN5dg9lvgutKkwPp5KqLE/AOK02Hf5B1ERkjHvtAX3TR1i+qkUF4cC7LzREfC3CUp2OmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288406; c=relaxed/simple;
	bh=poo8ZWGyPtL9bPOwD2YYZ+K6FlCiV0M+Ouoir/qKB9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MdpStP9PLMuND2XlSWwWOaKgzeWhJRGuFQD5LgrFrrCs8m3rq8xkNYZKgpTfLq7J4F0Ijg33w9ePmC8dwsDPhuJY7xD6DW+6UgBKGUcp4XXtvZlrBdpqRDzl1unYFQd1kVW+EWEL5+Vqm1+IxZem9PTFMSdNrdq3x4TOjTXenOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIFzl59D; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIFzl59D"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7962325ba0so953194a12.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776288405; x=1776893205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OZugw+DMuXri7+qNzOt6/To0VRy8T4/wgnBP9O3Kws=;
        b=LIFzl59DJIBX/pEKSjTCTGkB5zJ8bNlOJQNePXXlzB/oGfAZVC6dT6jORsMRn1aVHB
         KBPD4hWM4czoYZu5Qhr2NefJCXKzzxcdqDaAU+Hju89xsv1fLYkTbaPx2Xz5g99MARXE
         mg4nOTfzHKnt9Ld9R4eAdkpfEf9JbR4i1Xtff4KcodVNBh2SHmn05qv38Kov5vmh93dR
         UqafcjdPkZZ65EfVER5Kdy915203iL/B+xqDEIgJYyIj1bVLW9yIY8yAsc/aK7DGKSXr
         lTlS7fwuLwK6rI2lPoiUdv4KVdkOiieKBjy2ZRpLFO61y2hXw9buFzPdotxSWUjb0Hna
         KrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776288405; x=1776893205;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OZugw+DMuXri7+qNzOt6/To0VRy8T4/wgnBP9O3Kws=;
        b=BAyRf+DbcrnQ/vuBURVuMMydfZlRr0w+kh2hdAF8ETxNx84tigwZR98juyAVM2Rris
         HPn4pCSRshp7cZbcjZrsHDRYzFsFtNJ3DzkUpFqo1/yYA3kdGDYZFeAjWN0CtD6uSfs4
         Xm0AVHIjuHWivjx0ncSrp7CdD8I/pJB6RvtfaDLdncYSd5UtBZHnXIgFmclWXP7G0hlk
         CazFzL5h7fl49LYowEaFN/+w+gf8+FT5xPpaT+s5PaECYyhb3HakP3q1Ev20yjTuw116
         Jv0yaXMEyO5f+vOpU0b7DbIa6TCpGu9MLR+d9PD/sVFzkX8phvOFyabFgjIuaBJcVL78
         6DxA==
X-Forwarded-Encrypted: i=1; AFNElJ816JVUsEzU4r15WS6sUs7GVBVw+EqpqaItaDR6UNXIc6YKnwzBp28gdS1dY9LbuylOsQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDErBV36udiQRmaGhd2IP1sn4wt7xtlJOz8SGJpma6r89U4Sxv
	rVjgZGSnRSBvZSMlB+YO3xGqgS13Hq6S18qVXLvkmUFAOpkghf0IWDbvAX8vFqsVuONB2pSRuPd
	2g8q0EQ==
X-Received: from pfbmt9.prod.google.com ([2002:a05:6a00:6e69:b0:82f:559d:ece6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bf5:b0:82f:7076:cf2b
 with SMTP id d2e1a72fcca58-82f7076d224mr1839413b3a.40.1776288404629; Wed, 15
 Apr 2026 14:26:44 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:26:43 -0700
In-Reply-To: <CALMp9eSjAoVYk2f_j=b_X=EngJ935J=W7YS-C0nDS7b1j2Y4Og@mail.gmail.com>
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
 <adfyKU5WUiW4OnUg@google.com> <adgYSnE-I1Z19fCY@google.com> <CALMp9eSjAoVYk2f_j=b_X=EngJ935J=W7YS-C0nDS7b1j2Y4Og@mail.gmail.com>
Message-ID: <aeACk7T5Q4TxtRMF@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026, Jim Mattson wrote:
> On Thu, Apr 9, 2026 at 2:21=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Thu, Apr 09, 2026, Sean Christopherson wrote:
> > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > On Thu, Apr 9, 2026 at 10:48=E2=80=AFAM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > > > > In general, this deferral is misguided. The G/H bits should=
 be
> > > > > > > > re-evaluated before we call kvm_pmu_instruction_retired() f=
or an
> > > > > > > > emulated instruction.
> > > > > > > >
> > > > > > > > > ...
> > > > > > > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > > > > > > index f1c29ac306917..966e4138308f6 100644
> > > > > > > > > --- a/arch/x86/kvm/x86.h
> > > > > > > > > +++ b/arch/x86/kvm/x86.h
> > > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > > >  #include "kvm_cache_regs.h"
> > > > > > > > >  #include "kvm_emulate.h"
> > > > > > > > >  #include "cpuid.h"
> > > > > > > > > +#include "pmu.h"
> > > > > > > > >
> > > > > > > > >  #define KVM_MAX_MCE_BANKS 32
> > > > > > > > >
> > > > > > > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(s=
truct kvm_vcpu *vcpu)
> > > > > > > > >  {
> > > > > > > > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > > > > > > > >         vcpu->stat.guest_mode =3D 1;
> > > > > > > > > +
> > > > > > > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > > > > > > >  }
> > > > > > > >
> > > > > > > > This happens too late for VMRUN, since we have already call=
ed
> > > > > > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruc=
tion(), and
> > > > > > > > VMRUN counts as a *guest* instruction.
> > > > > > >
> > > > > > > It's just VMRUN that's problematic though, correct?  I.e. the=
 scheme as a whole
> > > > > > > is fine, we just need to special case VMRUN due to SVM's erra=
tum^Warchitecture.
> > > > > > > Alternatively, maybe we could get AMD to document the silly V=
MRUN behavior as an
> > > > > > > erratum, then we could claim KVM is architecturally superior.=
 :-D
> > > > > >
> > > > > > Here, it's just VMRUN. Above, it's WRMSR(EFER).
> > > > >
> > > > > But clearing EFER.SVME while in the guest generates architectural=
ly undefined
> > > > > behavior.  I don't see any reason to complicate PMU virtualizatio=
n for that
> > > > > scenario, especially now that KVM synthesizes triple fault for L1=
.
> > > >
> > > > L1 can clear the virtual EFER.SVME. That is well-defined.
> > >
> > > Gah, I forgot that the H/G bits are ignored when EFER.SVME=3D0.  That=
's really
> > > annoying.
> >
> > What do you think about having two flavors of kvm_pmu_handle_nested_tra=
nsition()?
> > One that defers via a request, and a "special" (SVM-only?) version that=
 does
> > direct updates.
>=20
> When would we use the deferred version? As far as the Intel PMU is
> concerned. there's nothing special about a nested transition.

Actually, outside of VMRUN=3D>#VMEXIT, isn't the deferred version correct? =
 E.g.
when counting instructions, shouldn't WRMSR(EFER) be accounted based on the=
 *old*
EFER value, not the new EFER value?
