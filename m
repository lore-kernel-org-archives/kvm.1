Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EA3EDE40
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630683; cv=none; b=NWjVXggfFbOyUdlCOzf4NLU2ej5sbQa74CFNWv3/BrpPBMxtdEqm58zSoKqF3pOpKa5VxA27nEnSguKMd/FB7meU6LN+HcoQWTlZF97/vaZCZP8YtPheoI752vleVwKo/t+/SUa2VEMU3YEMNIS20tbiOkN5WvgMUUHKN2u1nus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630683; c=relaxed/simple;
	bh=97nVmo+h/AxHEBO2Elc9q4CH+vTfbG4Nezgh8zmJN+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJaEs+wbIOh+TNkhUkXWwKy4HO6m9gqAf/IYC+u+N7y3372Po6VNCHjxsNyZkFLaPjKeu3pxmff6S8+2AANptLpcDF1vkeqSqvcYwK2tjMwhN5NOLX16zuAOyQUizeNIpf0jg7jbYHK4jFrzus/lHuE4OU8qceBc70Xs8FWt8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVmamAz+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVmamAz+"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso3983715b3a.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778630681; x=1779235481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkWtLCoSBKlAv+D7sGTQEygi2ipXCKA/B0WwjzpqiDU=;
        b=SVmamAz+uShyuZpG0vMdbroSmsxyuZ+q8mKUdcdX743Q9n99QfFpyMZ+YMwj2T7Sr6
         nblZo3mQIrsuprf0Hrg7Xjd5Vsw7lNpRR+kV+mG4MIbwpKcx3iYY+BVKqPdDG0tUVbBb
         T0SYIZ7oFVB5rRLwqGahjh8aSDthCN7HgE7qcUwqRqS0C0bJk6N0uPaNyxDWz2rSGuIb
         +iatVoKaACZIpX8kk0a9XuvSohQI+m85jmRp7LR5qB1UrkldALoZNXj5Qwd4RfvqwP1t
         b2iGg/1PjRqya1w++iFq4eVwXoLo7sscHADo3BuR8Y3ojItyQh4eanSn4/hFDf3sGxk8
         sn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778630681; x=1779235481;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SkWtLCoSBKlAv+D7sGTQEygi2ipXCKA/B0WwjzpqiDU=;
        b=ZVnoIUTCeQyTVS5JcoNpoRMPiWGSiqWfsskIy88uTYpD7EEfbD+wy9/rK+T/fts1OP
         l6f0w4/5aNSrCcpWVZybDTU+W6WILIT8V32690daOh9Ss1kaDaaRk5d5P/YS+ILy3NKi
         gkhqtuN1WQGnN9KIJvYLO//Et+E8sylUBK92rNltaxI6tz0uEW8u2SCueJd+2gzTnBoC
         Pb043IU6yttGoebBvFPZYncOz62hYkROlttS9hoaSWtzWUdK4jW/edWV1HBamydvIq28
         hkLn+Q3iIe8mlKpmYLK5WIIn9WqkDXQKxfsMnnmcljGHtid/UST2L/xf2IiayKuKUN3o
         b4MQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lrMDUjQXUQrihHI42ts13W0HbLreyFoMkxik1pBgZ4RlwsO7WKI7VxgiK00I729g5B8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ctPZuJACTvIbr5innMKV8wdVJTX2IdicutSs8hIkztajCWGO
	yS0Y+devXpy77ymnHVNHxrDNLqFoCqH5WfY7NiYjIGtp8mFRd6o/LUVLN2HzkglfnzroCeMT9hg
	UeBtikA==
X-Received: from pfbml25.prod.google.com ([2002:a05:6a00:3d99:b0:82f:a2bb:a7cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c82:b0:83e:6fde:54d3
 with SMTP id d2e1a72fcca58-83f05c100c4mr398197b3a.50.1778630680985; Tue, 12
 May 2026 17:04:40 -0700 (PDT)
Date: Tue, 12 May 2026 17:04:40 -0700
In-Reply-To: <CALMp9eRKcNpLxVBEg8RF6tSqndRFpLW_Q-rcXazPR9HYFJcdag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508170714.489136-1-jmattson@google.com> <20260508170714.489136-3-jmattson@google.com>
 <agOcw9ZIXALKrs_a@google.com> <CALMp9eRKcNpLxVBEg8RF6tSqndRFpLW_Q-rcXazPR9HYFJcdag@mail.gmail.com>
Message-ID: <agPAGOxjALgvPwAY@google.com>
Subject: Re: [PATCH v2 2/3] KVM: x86: Virtualize AMD CPUID faulting
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026, Jim Mattson wrote:
> On Tue, May 12, 2026 at 2:33=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > Date: Tue, 12 May 2026 14:20:47 -0700
> > Subject: [PATCH 1/3] KVM: x86: Consolidate CPUID fault handling for emu=
lator
> >  and interception logic
> >
> > Extract the logic for emulating CPUID faulting (where CPUID #GPs at CPL=
>0
> > outside of SMM) into a dedicated helper and use the helper for both the
> > full emulator and the intercepted-CPUID paths.
> >
> > Opportunistically drop kvm_require_cpl(), as kvm_require_cpl() was the =
one
> > and only user.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  1 -
> >  arch/x86/kvm/cpuid.c            |  5 +++--
> >  arch/x86/kvm/cpuid.h            |  8 ++++++++
> >  arch/x86/kvm/emulate.c          |  6 +-----
> >  arch/x86/kvm/kvm_emulate.h      |  1 +
> >  arch/x86/kvm/x86.c              | 18 ++++++------------
> >  6 files changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index c470e40a00aa..a9005c61619b 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2285,7 +2285,6 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu,=
 unsigned int nr,
> >  void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception=
 *fault);
> >  void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
> >                                     struct x86_exception *fault);
> > -bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
> >  bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
> >
> >  static inline int __kvm_irq_line_state(unsigned long *irq_state,
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index e69156b54cff..1c95d1fa3ead 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -2161,9 +2161,10 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
> >  {
> >         u32 eax, ebx, ecx, edx;
> >
> > -       if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
> > -           !kvm_require_cpl(vcpu, 0))
> > +       if (!kvm_is_cpuid_allowed(vcpu)) {
> > +               kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> >                 return 1;
> > +       }
>=20
> That's so much better!
>=20
> Will you drop this in when applying, or should I send a V3?

Go ahead and send a v3.  It slots in easy enough, but I'm trying not to get=
 into
the habit of applying pseudo-posted patches.
