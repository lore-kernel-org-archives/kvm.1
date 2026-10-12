Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198B379C56
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810688; cv=none; b=kzXQiA7TqJIGQBVc4a99l3Q53y8ZSpD1uFQdxr70K9z5SQkDyrDLn8rRG94tWBAMRM0vEElwt/E/sJgzN7i3j4tpJDiiqmC4DDZokAPsdEwYRGdBJWumZ8qIQPlBIKbCwEAvaLAeaMUbQoyMCX3rDFxR7vSm7j71nEiIAOGOl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810688; c=relaxed/simple;
	bh=OgbjSscxB6QJ2mH7TdinKOhwy34uThm28tQ2QUpylzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fmsJCS1WDDLQCeaktkMomXugPanU+zri44FbdFkYAQC1OMydBu2rw+MolL/U3fMEnRnEcxToPzqo32uFsnFO619CPYjX5k63m8S9i07zfWNf5keV0xsn9QpD79Hmf5WFRQkSRcYI4SkmNwkWzY4EP1LgL9EidQ2olXlSjbJFzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZAYCWsS; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZAYCWsS"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8dd9b9743so6659985ad.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791810686; x=1792415486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=olMmhrGeAw1U+TyWYiWjfzKorTwUpMEQ84ydn77VcEU=;
        b=CZAYCWsSf6TGmdYzQg7v5a/eGg/cUNXuaSmujLrvNQmA010MYjw7GGfdlzw4gjquup
         zj2FwHbUuDcV/ovrvLJOTZERtIMYuThrgxuX0xSLsILM2+RNqB+cAaBBSi4MPagbyPSW
         JCRMhwPz2rHwJ9qTj8CNxXB1YEi4megFhU1Sk53UmFTdEBgZUfkuv6RuFR/3NH0wGbnm
         i4DmV3iGAQyfUk3vOJQvuKcE0mPpGfwEw9Gsa2O/o+FScg9rSbM9ox0jrX+UAtptPqpy
         F7B2rbHyXNdMZ5DkEqyaL9GL8jtZJfBIraKqVGpXaERt5CmTkmrbwM6sVnRRny8OXdVU
         Lchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791810686; x=1792415486;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=olMmhrGeAw1U+TyWYiWjfzKorTwUpMEQ84ydn77VcEU=;
        b=XyQmHiLMRrlfp79yZ+QgjOq64ACQklO0ydN97Dqe6kk8GySZ1R/VNXa6IaJfdNYQRd
         Wntc9npXyl6bqdS278a8DkfQKhd1OMAcxljABqJzWyykgeeCNrEQ7BerHRFbGd+KSfTP
         SgNM/VrkKyn3JGCzIi1hPtOLa+bS+D2ATIXxkbqDhBr6uw7wFDQMtHhQ0hClNJRfvwt8
         5HvfUCcLk0vsj/VyN9iB1xAO8NBdIAiW9pktXVhEoLsj+PPaGPdJ/ma60gf2ya/3w/Fu
         b3i5aEytZ4HTUPVhniaSnduNS3DHwoJ3LgEV2CPNzHDlQMVH9zFyAxr6YJw/9MjZqpub
         4+3w==
X-Forwarded-Encrypted: i=1; AKwUvBwJnTCvC5xtEMTzV+K5IoZHRNZ0JA2BglkoujHAO66i0kltzheh8tRb80SNsjBnfnkDDxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuyLJ8dKeYwKrSbwSAzaWf+dsohp3f8UnZaEBF+9CO/BDfCAdn
	/0i1mdGVHlw+4jIF6CI6fYNbQrqKL7fHYNrPiCHIVI6oowIcFljBh76G9Lz0yR+qiaMPZ/C2qUS
	70m6ybA==
X-Received: from plmm13.prod.google.com ([2002:a17:902:c44d:b0:2e2:f1f0:112])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccc:b0:2df:7fe1:72b8
 with SMTP id d9443c01a7336-2e8429a649bmr80868175ad.16.1791810686224; Mon, 12
 Oct 2026 06:11:26 -0700 (PDT)
Date: Mon, 12 Oct 2026 06:11:25 -0700
In-Reply-To: <CAPm50aJ6uudDOAC-XN1qQAd=aEtKYVgKuQWwM7cmLOsruQR9xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008090037.86931-1-flyingpeng@tencent.com>
 <aslQLXcK1VXSkrVo@google.com> <CAPm50aJ6uudDOAC-XN1qQAd=aEtKYVgKuQWwM7cmLOsruQR9xw@mail.gmail.com>
Message-ID: <aszcfeG_qPq_2x9w@google.com>
Subject: Re: [PATCH] KVM: x86: Guard against division by zero in adjust_lapic_timer_advance()
From: Sean Christopherson <seanjc@google.com>
To: Hao Peng <flyingpenghao@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026, Hao Peng wrote:
> On Sat, Oct 10, 2026 at 4:35=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Oct 08, 2026, Peng Hao wrote:
> > > When TSC calibration fails and userspace never programs a tsc khz,
> > > vcpu->arch.virtual_tsc_khz stays zero, but the lapic timer's
> > > software-mode expiry path still calls adjust_lapic_timer_advance()
> > > unconditionally on every timer expiration (unlike
> > > __wait_lapic_expire(), this path is not gated on tsc_scaling_ratio).
> > > Both the "too early" and "too late" branches do_div() by
> > > virtual_tsc_khz, so a zero khz crashes the host with #DE as soon as
> > > the timer advance drifts outside the adjust window.
> > >
> > > Bail out before either division.
> > >
> > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > ---
> > >  arch/x86/kvm/lapic.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > index 13e32c4915e2..4dcbc66c8e07 100644
> > > --- a/arch/x86/kvm/lapic.c
> > > +++ b/arch/x86/kvm/lapic.c
> > > @@ -1991,6 +1991,9 @@ static inline void adjust_lapic_timer_advance(s=
truct kvm_vcpu *vcpu,
> > >           abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_MIN)
> > >               return;
> > >
> > > +     if (unlikely(!vcpu->arch.virtual_tsc_khz))
> > > +             return;
> >
> > Ugh.  I'd rather reject KVM_CREATE_VCPU, even though there is a rather =
surprising
> > amount of code in KVM that does indeed play nice with tsc_khz =3D=3D 0.=
  I don't see
> > how the guest can possibly function with virtual_tsc_khz=3D=3D0.
> >
> Agreed the guest is broken in that state -- virtual_tsc_mult is zero too,=
 so
> nsec_to_cycles() returns 0 and the deadline timer fires immediately. But =
I don't
> think KVM_CREATE_VCPU is where to enforce it, because letting vCPU creati=
on
>  succeed is what makes the state recoverable:
>   - kvm_arch_vcpu_create() deliberately ignores kvm_set_tsc_khz()'s -1
>   - KVM_SET_TSC_KHZ is only reachable once the vCPU exists. With
>       kvm_caps.has_tsc_control and a khz below kvm_caps.max_guest_tsc_khz=
 it
>       recomputes virtual_tsc_{shift,mult} and the guest is fully
> functional again.
>  - max_tsc_khz does the same thing ahead of time, via default_tsc_khz.

I don't see how it's recoverable.  kvm_set_tsc_khz() will compute thresh_{l=
o,hi}=3D0,
and so use_scaling will always be true.  Which means this:

	ratio =3D mul_u64_u32_div(1ULL << kvm_caps.tsc_scaling_ratio_frac_bits,
				user_tsc_khz, tsc_khz);

will again hit a #DE, no?

Even if KVM somehow makes it past that, kvm_guest_time_update() will put th=
e vCPU
into an infinite request loop as get_cpu_tsc_khz() will always return 0 for=
 modern
CPUs with a constant TSC:

  static unsigned long get_cpu_tsc_khz(void)
  {
	if (cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC))
		return tsc_khz;    <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D always zero
	else
		return __this_cpu_read(cpu_tsc_khz);
  }

And so this code will re-request KVM_REQ_CLOCK_UPDATE and the vCPU will han=
g.

	tgt_tsc_hz =3D (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
	if (unlikely(tgt_tsc_hz =3D=3D 0)) {
		preempt_enable();
		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
		return 1;
	}

