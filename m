Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946A3E2748
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755777; cv=pass; b=SK8gOBNoIf0E5UrJRTCKYkGe4maCWe/ijMePg7+lkLV+xZYYcT1mEFz2eMMEOWL1EtqO+TG3POx0IBh3qzKMZhMVPGLF14z6d3S0+1q5BygsyGsiu7xka42lrgraw8isGGwOdHlemj/ybq4N27ufSMhkAiytvtSUwkmAJkf8Zf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755777; c=relaxed/simple;
	bh=CKT/1MOlaR98Y/XDLWPNMK0TStlQhxoVxcoUB1bFoqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TF6sipRY3nS5ZYjRbycF8K7sgWFopssI4dnYP4AuIUXKGTFpvv0KiXgxXyyCc1RPSafMdwdkwKvh+yau/VRBR4g4ALsvVGjipbcqUtgJyLxhalvkXCvIzBJIYXqRAV6+bPGF0Lg1sQK6ck8IGKLkKeZu7fn/28NhLXahDZKo0ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzfwo+xb; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzfwo+xb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so11959a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 10:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775755771; cv=none;
        d=google.com; s=arc-20240605;
        b=IzKuvf0MFdlVuccQgDTpeUn65rpcbCkk5Fi7Oo/9qdwF51wlmJGQoszJgrxbUlDIYS
         CWCD/9GvklGtivhiqfnBZiehpJe8xlw2Tb+icJ62MySRNWU0SF90dHMmXfdsMhoGanrH
         CBiiNlWuWqUJ/V6na4QLZGf7FW9wEsJIaocktOYQMtr/p7aksaoXkDIqgulrABgeR1yr
         sglRh+mK/lQcJUvA+VpoOMXY50rlBIWCJdWbBf78a04MSvpUmwF/hqWwHnXYtKNn2CQF
         LUt/dQyIVptl7E2rk7dZ1p9IUNNVwX/4AxTf1l6cyhZ7yC3UqRsNdSopWkqnq9GTvT4o
         jdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wpJS2AFWyooezggFJwMwJkQFSUfkxNvM5w7ZcmXIpGY=;
        fh=YFppIW0v1MVGHYPlz2tKAdTp8WHDjr5YhpihbDNJ9TU=;
        b=kYsdyA6BosQPRBzS9NtcnYKEq1GRIWjvP9UuYT0z2uUYbNQljuG9LcU5W776v2vOqF
         lfjUAspLsXRgEM7RVIpYlB3bp1DtS1sG/gR90Ju9EmAmxUB4VcVw/jw0fLMDI8+s/36N
         CJHc3w+Na/BuEkE6CjMdCdjAsIPRjzbg2hgUsbAZYgxeWAraiWJS8Mij95j0OW2XGtpV
         SyKJJTiVRQD+evBqxpszhjBhsMWSwv/kAooUG0YlnDfSvyVp5VO/jqp8ClVeMaoWrqZ5
         KioVYMQE56pFz482ro6RpPvsC89v+sanwnEePCKuYEak1p8anCiuikO3QHUqLsDyxUFj
         AbiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775755771; x=1776360571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpJS2AFWyooezggFJwMwJkQFSUfkxNvM5w7ZcmXIpGY=;
        b=Pzfwo+xbTs1o+bbfe17uvkDWZhFSfDtSoih07wijMrB8LCYGbK7VuQrr9CZIYzGf49
         I388ZzHSLI/xfa6Q52MicEjA1JUivJJSK0bGm1A33AygpDYgB5AH/gfjt1U5i4QJhEk0
         ybn+2ml3ZtqrSh7yvVfFhUiS0xPve3m9aUJgJoxr9WC+vdjEe1CWtK3QsDzvrUex4hyd
         3rt60H7ov/J8duSfX3jYhSnv1P4Hepllt97JbNmTnfL/Li1aHaRlLzZAAbciJ/5gpI1o
         vAQyFa3YtHuFtyJAF2jsjvBeP/AikQhnZoiXu6POn+bJgaduCMwapIIwgNaxHgnEIM2h
         ZmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775755771; x=1776360571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpJS2AFWyooezggFJwMwJkQFSUfkxNvM5w7ZcmXIpGY=;
        b=sEz1Mvb/YOD+mDMS29LEeb4s4dvv3Lq/p06WYevycTTMw1h6ZKH11iMJs9Lgs0BFVo
         SFLIe6ozJaFeMec5j3u4TmXY7sN5N85TuQDWe/mXDXqWJdyTGbg9SmRDy0l2O2ijT5eH
         a/4pc91oDp4LSN96uJslKdZ1Wny1FyZXriMJFCglNCZY7neL5TD8DurkOVSg2oa3zkFp
         RHAN07XdOjtt4I1SheU15vIU/IlmaQ2L7Snb5pLkBQt8V2VysH8PqgAkk9GlEoF4nydP
         WhQ6eRN0qZqu4bhWTzR6htlmIBoQkjVSQ8EYlW/TIUQkqh3hEMwGIuqyWKLPaSguvDdD
         T5eA==
X-Forwarded-Encrypted: i=1; AJvYcCXfw4v7f9D4QQZpNy2iz2r1FN0UZz5ZMvBupIdGrhMU1tP295kgJzYccBQrwGIVjyJCIO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMNudhCTXEuYP+zoBdTvB/5skHqJfZCLo8XaLb0QQMs2Ecdvn
	1CADKhlTUJSylqednYjOOEIh5zXHRbAJuzZYvZtHibXd95Oy8wzDrW2iTVTdu5XfsfdI5KJmP4/
	m72oKFY824E3KwvZ8fUFzKzRIJw6ENs7MBM6F/8+w
X-Gm-Gg: AeBDiet6Usz3pNIzgUkbDoZ2s3VVKuFMLEZdZRvcNkjx6MmePQQ0KjrUMbqwY+2Imhz
	ESq/YeK0Mul96dUKZVM1TeP5jx4mJBT+iQTfPeFnYaaiWy3fVOjX8Lwxb7bEinsZYqERzv7G6d1
	KwUEPkBkZmbikRrrY0NEvqk20d3eWyze/pM1W2KMkG0kDOkJxuo9yvAw/10pyNltMOXVZKYr2CH
	gcmirfS0aEi8BpEToIyO4g4bPT4JnZMd/BinWbkgfCzClhW4Aq1+8pVSMgRzCH7N6x1bi88wcUi
	e7Mjc0+uuGcjlz6rDg==
X-Received: by 2002:a05:6402:3247:10b0:670:6df6:3495 with SMTP id
 4fb4d7f45d1cf-6706df63620mr8506a12.11.1775755770236; Thu, 09 Apr 2026
 10:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com> <adfgPwgXz1iQHpVS@google.com>
In-Reply-To: <adfgPwgXz1iQHpVS@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Apr 2026 10:29:16 -0700
X-Gm-Features: AQROBzDE8-OQpg5RG79_SFRU90-XVBQv6tcZ0qyFX_odVTGongX_8fzpz6cimuM
Message-ID: <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 10:22=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Apr 08, 2026, Jim Mattson wrote:
> > On Wed, Mar 25, 2026 at 8:12=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > > index bdbe0456049d0..fb73806d3bfa0 100644
> > > --- a/arch/x86/kvm/pmu.h
> > > +++ b/arch/x86/kvm/pmu.h
> > > @@ -248,6 +248,19 @@ static inline bool kvm_pmu_is_fastpath_emulation=
_allowed(struct kvm_vcpu *vcpu)
> > >                                   X86_PMC_IDX_MAX);
> > >  }
> > >
> > > +static inline void kvm_pmu_handle_nested_transition(struct kvm_vcpu =
*vcpu)
> > > +{
> > > +       struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> > > +
> > > +       if (bitmap_empty(pmu->pmc_needs_nested_reprogram, X86_PMC_IDX=
_MAX))
> > > +               return;
> > > +
> > > +       BUILD_BUG_ON(sizeof(pmu->pmc_needs_nested_reprogram) !=3D siz=
eof(atomic64_t));
> > > +       atomic64_or(*(s64 *)pmu->pmc_needs_nested_reprogram,
> > > +                   &vcpu_to_pmu(vcpu)->__reprogram_pmi);
> > > +       kvm_make_request(KVM_REQ_PMU, vcpu);
> > > +}
> >
> > In general, this deferral is misguided. The G/H bits should be
> > re-evaluated before we call kvm_pmu_instruction_retired() for an
> > emulated instruction.
> >
> > > ...
> > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > index f1c29ac306917..966e4138308f6 100644
> > > --- a/arch/x86/kvm/x86.h
> > > +++ b/arch/x86/kvm/x86.h
> > > @@ -9,6 +9,7 @@
> > >  #include "kvm_cache_regs.h"
> > >  #include "kvm_emulate.h"
> > >  #include "cpuid.h"
> > > +#include "pmu.h"
> > >
> > >  #define KVM_MAX_MCE_BANKS 32
> > >
> > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct kvm_vc=
pu *vcpu)
> > >  {
> > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > >         vcpu->stat.guest_mode =3D 1;
> > > +
> > > +       kvm_pmu_handle_nested_transition(vcpu);
> > >  }
> >
> > This happens too late for VMRUN, since we have already called
> > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction(), and
> > VMRUN counts as a *guest* instruction.
>
> It's just VMRUN that's problematic though, correct?  I.e. the scheme as a=
 whole
> is fine, we just need to special case VMRUN due to SVM's erratum^Warchite=
cture.
> Alternatively, maybe we could get AMD to document the silly VMRUN behavio=
r as an
> erratum, then we could claim KVM is architecturally superior. :-D

Here, it's just VMRUN. Above, it's WRMSR(EFER).
