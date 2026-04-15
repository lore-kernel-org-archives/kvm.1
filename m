Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C134751E
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294479; cv=pass; b=saDJFIZdU9Ef5y64rU9CxOuOfo4rX8sx9M+8fJvyQz8/YyBBQHocATmQh23rFld2F2kwHhzZDebjjhhPcmJ/2M5q9maoKVWEdCvQV8I58E28YUWmr/0Pf0UpAzx97vjLVeh94FDhFD9uQfAC+YxLiNOH2Iw5le32rfFQ0mgkgyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294479; c=relaxed/simple;
	bh=kEqi5hf3UpVu5TD5lubNm0uyJxJG9imiyN9JSO4VCDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJ9aDWRr/6ibE6wF2hWU8TY4qGmxFFGBUQsT4NR1WZ1lQ9heTCs1WOqwGajgXY+C/KjDuPau1bF1x9vVSafRut8cEbPBg37whXQnEgq53xfJdPrtlW7CGJuszgOXms4A6pVD/tK4IuUxPLYIZ0WLwj9RewHqecvMPh5/rhnU0Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ry46rJH3; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ry46rJH3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso1128a12.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 16:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776294476; cv=none;
        d=google.com; s=arc-20240605;
        b=QIfO4td9QNi2d5X4sU95R7qcHGnL1vVi9LQ5ANCkpz/ukoD6kMIyFeuxpzCQ/8vnJ+
         YQmrgqB4CBEZl7hZGWnNo5sor2H/ZkZkbFc5GGCr2MDNlJKaHQ4Yww2Tc05UTSlxmdLz
         BssRghawcjV28YKE6obo5XMnJxoJ9JKGwOKzoaYsfdZ+fTqb3VQae1JHrjjjz38k0fj8
         7i4wRarJZyb+H0B29ZLdNgis7syMYm6E9wj+i+IzMSRQ6FjbqvyRxd3AEIPJwYedjsWj
         3ok4cL772mVvtGCkohqigoMU31gCleoYzTY142GrDfZbS5kuIFrr+evjhqXKL4GC3deJ
         ZwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dTs1a+Fw1OjQau0Kc8OaroZUOGSnD6osHJosJQkeXlY=;
        fh=mALt64XcZQw4WbC/gAI31Ru5XnbBfiJYipQ4XN4whbM=;
        b=bQBymC0wnnR0sHwdqaqixgTJfGLheISRKhwFA0ddvMFrdI1hElDYmclz5PlCLXAfA9
         16z0IYdpz+k5jDBUhGrZfdGT/b0PRWl3MvWdZNvq5PRHK8Nl66BPlcloGrA9D9SPHTuK
         eoLFiV4yWFw1IwcpE7yMSpu3CQ8wQ+L1CCG+zPcj0ld6l5qntxaNHxiWpWYbC1wRLLDR
         uhtZKsYY868MldR7QimVUVDyn8k7hg8qOOMzxDeCjInja/x/RFgU01hAM0dneBMAC25Q
         935sdCPvlh5bFn2c2IFQGZkTI7Cl/IgPhpNjd76RkX2BVrMdKQlCBALLymPAOZBPANLm
         Rxgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776294476; x=1776899276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTs1a+Fw1OjQau0Kc8OaroZUOGSnD6osHJosJQkeXlY=;
        b=ry46rJH34vCCjswsl49FcloGmCCPYPbc6GjWoLyI5XOVPhvtAqHDM0rBpZBsoAQk39
         LrRt0g45lAZa1HDA8LEmSe54ThNS60OK8eJ5jx2Vt7UzCdV6YsHzu2xbAK6RddIe0eHe
         l8P/jIHaVoXBM7ymVPRYc5C9G/DOZR5/o3oDctQg1F0BquuN1EIhdfBLcpYZVC/h3LoP
         opxmPledICICilmQGoT8svN0l9fe+L64kj9lgx3G5U7ZaizmoyxwFrfcLNY+/r+erU4d
         o6ig6yvdqzLuqhGy6zhQU6+zIh7JdP+Rn5bEggo5hiKSH7wP24b4iVRnHvn3aA9ACRhu
         2xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294476; x=1776899276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTs1a+Fw1OjQau0Kc8OaroZUOGSnD6osHJosJQkeXlY=;
        b=jn/R3xeM2kBdu35sBeUOshb09LJeBQuMu/615RzdAbLMWiH/epziMUc0IwB/HY/mKY
         LegAb+GRg3pSqU+4A5zvxkw/DptKIZMEQ2z+mthXFW5BujJXT38KCvnM+6bpHCQL/TbT
         hPdjoIjJQWbyaWFsq+Vho/6+/iMwRBPrYHYPvB+WLNhxWeNPn93WoRbEdZl5rJayC9Q+
         Uvo39nSeh4Z28thBEKJrnA9mWMP48/WQybJRsFVTEcqGpeS24kwn2KeQKmYXKOQ1sBu7
         nKb15+a/R9rjZ2y7MprK/xnhBOQAPNmAXPGRlWzGOlzuRhxnpn5ThqKgTafMaqfsEOFw
         CucQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8xyPlMKhPfPg6y2R1ifW9lNpQGsAr7GILXOyRtU/tWoGO7dI/CqzjCsLDxBDjeEOU5eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtg0dsQv0JLfbB+h9oXq351EKQVFzg4mr4p6vsK3NBd/enOR2x
	5cm65OtuUMNF+8d7q3la41snLKJNCSb4CfMyAw1C5dj5Y45NiixzPlV1Kys/KkasVHNmPnSVqkl
	d5T3T5G0Wpm5Yl75qtT3Zc8rA65YO1VBO52CZPujgFTQjWM9Jb/slkUTK
X-Gm-Gg: AeBDies12Pg58vfENWLYVH6nHKOhbG3dxhWAubsG1WnrDPGG4pvA6vhmeso0iwhJGBk
	G73LSTK+26pBQfsrSLIU+xNaYdDx19b95VMHE7Za63gMh8aYb3tuOlG630wTRUR8s3f8BvVu0Tn
	SCC95kar1duy8kfFwbnSH/Alqtc8scBUaW10/7cA6quBZDqklaaqLSSIh+C4/QvnY9n2nAwR5n5
	YILsRX8GVz2LMER6i2PFdg9JI1c5nqlU+LHgHaFeqR6vKeajeRS4Kg/LpqOjPM3FH6WV1LTU3DD
	xobdJhMTpNCHYNNOj5M+zKNW5qRy
X-Received: by 2002:a05:6402:318e:b0:66b:99df:42e2 with SMTP id
 4fb4d7f45d1cf-6727177d235mr19810a12.10.1776294476058; Wed, 15 Apr 2026
 16:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com> <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com> <adgYSnE-I1Z19fCY@google.com>
 <CALMp9eSjAoVYk2f_j=b_X=EngJ935J=W7YS-C0nDS7b1j2Y4Og@mail.gmail.com> <aeACk7T5Q4TxtRMF@google.com>
In-Reply-To: <aeACk7T5Q4TxtRMF@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 15 Apr 2026 16:07:43 -0700
X-Gm-Features: AQROBzDlod_VGha0XUDQgqq_4FPeUuHT1CEK2by_j4C7-vUd8amvbGVs_1SCNOo
Message-ID: <CALMp9eSHJmLLAQAvbvRmq99v568PGkJduoQn1djnXGb-yED_5g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 2:26=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 09, 2026, Jim Mattson wrote:
> > On Thu, Apr 9, 2026 at 2:21=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Thu, Apr 09, 2026, Sean Christopherson wrote:
> > > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > On Thu, Apr 9, 2026 at 10:48=E2=80=AFAM Sean Christopherson <sean=
jc@google.com> wrote:
> > > > > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > > > > > In general, this deferral is misguided. The G/H bits shou=
ld be
> > > > > > > > > re-evaluated before we call kvm_pmu_instruction_retired()=
 for an
> > > > > > > > > emulated instruction.
> > > > > > > > >
> > > > > > > > > > ...
> > > > > > > > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > > > > > > > index f1c29ac306917..966e4138308f6 100644
> > > > > > > > > > --- a/arch/x86/kvm/x86.h
> > > > > > > > > > +++ b/arch/x86/kvm/x86.h
> > > > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > > > >  #include "kvm_cache_regs.h"
> > > > > > > > > >  #include "kvm_emulate.h"
> > > > > > > > > >  #include "cpuid.h"
> > > > > > > > > > +#include "pmu.h"
> > > > > > > > > >
> > > > > > > > > >  #define KVM_MAX_MCE_BANKS 32
> > > > > > > > > >
> > > > > > > > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode=
(struct kvm_vcpu *vcpu)
> > > > > > > > > >  {
> > > > > > > > > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > > > > > > > > >         vcpu->stat.guest_mode =3D 1;
> > > > > > > > > > +
> > > > > > > > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > This happens too late for VMRUN, since we have already ca=
lled
> > > > > > > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instr=
uction(), and
> > > > > > > > > VMRUN counts as a *guest* instruction.
> > > > > > > >
> > > > > > > > It's just VMRUN that's problematic though, correct?  I.e. t=
he scheme as a whole
> > > > > > > > is fine, we just need to special case VMRUN due to SVM's er=
ratum^Warchitecture.
> > > > > > > > Alternatively, maybe we could get AMD to document the silly=
 VMRUN behavior as an
> > > > > > > > erratum, then we could claim KVM is architecturally superio=
r. :-D
> > > > > > >
> > > > > > > Here, it's just VMRUN. Above, it's WRMSR(EFER).
> > > > > >
> > > > > > But clearing EFER.SVME while in the guest generates architectur=
ally undefined
> > > > > > behavior.  I don't see any reason to complicate PMU virtualizat=
ion for that
> > > > > > scenario, especially now that KVM synthesizes triple fault for =
L1.
> > > > >
> > > > > L1 can clear the virtual EFER.SVME. That is well-defined.
> > > >
> > > > Gah, I forgot that the H/G bits are ignored when EFER.SVME=3D0.  Th=
at's really
> > > > annoying.
> > >
> > > What do you think about having two flavors of kvm_pmu_handle_nested_t=
ransition()?
> > > One that defers via a request, and a "special" (SVM-only?) version th=
at does
> > > direct updates.
> >
> > When would we use the deferred version? As far as the Intel PMU is
> > concerned. there's nothing special about a nested transition.
>
> Actually, outside of VMRUN=3D>#VMEXIT, isn't the deferred version correct=
?  E.g.
> when counting instructions, shouldn't WRMSR(EFER) be accounted based on t=
he *old*
> EFER value, not the new EFER value?

Unless you can point to documentation stating otherwise, I think this
needs testing. By analogy with VMRUN and #VMEXIT, accounting should be
based on the CPU state at instruction retirement.
