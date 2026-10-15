Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7F367295
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077749; cv=pass; b=nA2b8ej3YyvZZYpk3ixHNFrCMM/dNBkwA2OlHfXxmvBCROlm+v1lTvC82+OtBWmvXy633+fETZEZ7ZYbuY32RPocahI6maiUpGHM/pwgrlJCFuIa0m91tiLsCM401azy40xCkwITSBFu25iFB0i2u2k9pBPVD9BmPBPVOyxcmdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077749; c=relaxed/simple;
	bh=tOoKnWkXS6eLJWT/7QdD2bMyx4UfyGw83m8FAMh9FVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhgOeJfphUU2P7DK4IPm22EYealAX/Jy/2/1pxvwRWkoNpIN8zECMOBAIQDlJQnugQZA4OCyF5f+YaDT7f/fOCrAjNTh2WWnQSjdBM1CIS1P66dm+46P4plYAebjGNn2nXQdQuHpOebhHdMyGQf2pDB4j6fEdoMXA0u5ldQ23aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcWHBAvK; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcWHBAvK"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df1eeb43feso2327241eaf.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077744; cv=none;
        d=google.com; s=arc-20260327;
        b=qp0duBrr+Nz/6wdjGw08YHfruJKQogLx4BHpsRpWJRuYGbtkbWEsw3xESELzTaJmNM
         vmNMgga5kV+b0RKdyMMe8VVrSHjt02j7naHZ7C0xntSR0khexp9Nq6GwvdGhJEoUEOYm
         gtypCuzXs3GyxnD87kjYygKuvO5byHFpwZL2n+a4ooYzcX9AEkYmirLEVfGBJrinOM+G
         iams6xBs0wO1GdVc+MlrR3It45+IgEkw4ZT4/saAlJwln+nvFRpdzgPRATaNQ5ey3WIF
         X2ywOw02fhahcTKQHLcpdddRs12kD7L9vRJLAzfUa+kI3A5BuWHnQxKXOPCTVeQMnsN4
         1VfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yvSSopROBCP6eUNokXJ2oRimLwMN7MQjW33S7Bdd9tI=;
        fh=4zy44f7ayE6xtQh+JwVmApJwWn7QpMLghzgbOQg/j2c=;
        b=ppgc6kYCzZBhMgXE1Yl++KDKsNc5T+NPiwNnyCLxtR+9LniJ72EeeWKgfgWAUXCBph
         h0D4HZUV6rHz/DuK9hgpQh+3txacuINS4oAgjbEWEbbj8oA1OyMvstbgyPKodPYeR/rX
         R/aM6yaiEjvU5/ztgULOVU0XptL1mGOkspH1+ydoJHjKJjic8fXb9u9lZLu5BuuMj3dB
         5jRcYAalnFGYTnNREIU0ZpDGqUvpaC06HhhqG9G9j1WjocAY1klDvTssLoi2kDmwHu9v
         J5wFDiJCIidUPMPacjmK+gvmsEMWqrp9CEnIKBR60VMBmRZ7W9TUrEQJlbCwnjrQJ19B
         nPNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077744; x=1792682544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yvSSopROBCP6eUNokXJ2oRimLwMN7MQjW33S7Bdd9tI=;
        b=NcWHBAvKHA2PedchA4nd1CHPTu9pjOwMvOAQjcpLaxV4iYAv60VhqRxEAMJquRQxbH
         a55R2oV8fynkm106nFZOS/c22YaitGRzZkcq8QjcInc+j3GGDfegRVqhsFMLTl6ixr3t
         qi/YvCcKMg/K39aSOcB1VHsPzrU7HQXGcmhMH5gDJpcn86FSzQEiEFBjaYwdfPdtPY8y
         0TDIF+SJScCB81NweHVdIyqkgkf6obMVIHZmTJTUK8SRuz7VGjmz0BVKG+6S/41YgGTR
         U3rODK2ImwInuacGHJZFun3Pqzp9w/T6V/RTRetO6GKQ8CGGAGxFagD5YO4Flpx43ZlY
         aLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077744; x=1792682544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvSSopROBCP6eUNokXJ2oRimLwMN7MQjW33S7Bdd9tI=;
        b=EmJfQeZ4GRhCo4LCVQbKWHnC7spYza2OqnSxqrqqmzkVlwkBdkBVpK1XraHgl26aEm
         MsjzphEFMIqNHuiP8LGRvt8GKxwwaWlAVZTq+OE6/KPIwLIWfMaS5+5O7r4nrI1jKTwQ
         p79yS7EG0PmxVX0cYHLMmn7wXS0r5B2KdkWRy/fWyjJEWAtmPk4juBfUfStbyBRyZENt
         V+WODiSFTSIrkMAZnwQ2ZkDZIcytk7BcyJIArwXK1A9hifTQlyaAQxnlYg9T0bHRvGu0
         pvLO3XE9FqwLXe+surdgAlfY9caDBzrW/u6Z+2DCZbtwcbIqaWovNr66u4qJNniRR0H9
         8PMw==
X-Forwarded-Encrypted: i=1; AKwUvBxEVFJu4Wvg/q5RSULNkDooLCTUqISqM1hMCZs3FAI9ZkMoMG1NMCJIuybMHCP4IwfhcXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYILDNmWGxGrjyKRgO/Kqpq9vxRfT0X3dwnkA3mCSoa9mUSsr5tm
	98fSg2VqNmM+etKHFm4NGlIrgpbm32gTI1oTp0VAj/n3EBOn6t/5pEa4oGNK3PkuujClF0VIKC1
	+Coex4MGXrpL5vqYOaXiWuMGORI1ex80=
X-Gm-Gg: AYBFou16XaBbyqQT77vfqfretwLA4sZIFLVaOPp70+BvzdIS9kTjaIbdL7HJ5rhf45j
	lYAwwD20Qx2mBuUVtAgtheAbYVTOeOMsoZcNzjP9kiBuoYbPNXpwS4ZaIgofkhp9agrqWygwPGK
	q8qlSifVaOwpy1uYPXxFa+dVxhK1A0eM7SyBzLmUCC5l1JyQpthkxAiI6p6FmET3fgnCFkQJS3Z
	FCd8zKmOYIw3qSg1UgLAc2tI73HSs5Hhogu7AlMcZu5ne2afX/ZudP9Jm2NWbENqtfKYLS9VLWp
	v5ovWhh5YyCXzu8APZN51YYpIXCLCAbb1gmeSMEYsD9Oesals6uer4m2
X-Received: by 2002:a05:6820:16a1:b0:6f5:f68f:4016 with SMTP id
 006d021491bc7-6f5f68f5a1cmr10213280eaf.19.1792077744402; Thu, 15 Oct 2026
 08:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008090037.86931-1-flyingpeng@tencent.com>
 <aslQLXcK1VXSkrVo@google.com> <CAPm50aJ6uudDOAC-XN1qQAd=aEtKYVgKuQWwM7cmLOsruQR9xw@mail.gmail.com>
 <aszcfeG_qPq_2x9w@google.com>
In-Reply-To: <aszcfeG_qPq_2x9w@google.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Thu, 15 Oct 2026 23:22:11 +0800
X-Gm-Features: AclHuK9EiaUT_jPSN8rUqb6RgQl_YOgCQVAiz-Yopvgi-LUKFA5V_NDuUIcfSbg
Message-ID: <CAPm50aLOKwb4JytbP5q9Y3CfDSnTL=wgVe3-coAko7YO_49xOQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Guard against division by zero in adjust_lapic_timer_advance()
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 9:11=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Sat, Oct 10, 2026, Hao Peng wrote:
> > On Sat, Oct 10, 2026 at 4:35=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, Oct 08, 2026, Peng Hao wrote:
> > > > When TSC calibration fails and userspace never programs a tsc khz,
> > > > vcpu->arch.virtual_tsc_khz stays zero, but the lapic timer's
> > > > software-mode expiry path still calls adjust_lapic_timer_advance()
> > > > unconditionally on every timer expiration (unlike
> > > > __wait_lapic_expire(), this path is not gated on tsc_scaling_ratio)=
.
> > > > Both the "too early" and "too late" branches do_div() by
> > > > virtual_tsc_khz, so a zero khz crashes the host with #DE as soon as
> > > > the timer advance drifts outside the adjust window.
> > > >
> > > > Bail out before either division.
> > > >
> > > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > > ---
> > > >  arch/x86/kvm/lapic.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > index 13e32c4915e2..4dcbc66c8e07 100644
> > > > --- a/arch/x86/kvm/lapic.c
> > > > +++ b/arch/x86/kvm/lapic.c
> > > > @@ -1991,6 +1991,9 @@ static inline void adjust_lapic_timer_advance=
(struct kvm_vcpu *vcpu,
> > > >           abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_MI=
N)
> > > >               return;
> > > >
> > > > +     if (unlikely(!vcpu->arch.virtual_tsc_khz))
> > > > +             return;
> > >
> > > Ugh.  I'd rather reject KVM_CREATE_VCPU, even though there is a rathe=
r surprising
> > > amount of code in KVM that does indeed play nice with tsc_khz =3D=3D =
0.  I don't see
> > > how the guest can possibly function with virtual_tsc_khz=3D=3D0.
> > >
> > Agreed the guest is broken in that state -- virtual_tsc_mult is zero to=
o, so
> > nsec_to_cycles() returns 0 and the deadline timer fires immediately. Bu=
t I don't
> > think KVM_CREATE_VCPU is where to enforce it, because letting vCPU crea=
tion
> >  succeed is what makes the state recoverable:
> >   - kvm_arch_vcpu_create() deliberately ignores kvm_set_tsc_khz()'s -1
> >   - KVM_SET_TSC_KHZ is only reachable once the vCPU exists. With
> >       kvm_caps.has_tsc_control and a khz below kvm_caps.max_guest_tsc_k=
hz it
> >       recomputes virtual_tsc_{shift,mult} and the guest is fully
> > functional again.
> >  - max_tsc_khz does the same thing ahead of time, via default_tsc_khz.
>
> I don't see how it's recoverable.  kvm_set_tsc_khz() will compute thresh_=
{lo,hi}=3D0,
> and so use_scaling will always be true.  Which means this:
>
>         ratio =3D mul_u64_u32_div(1ULL << kvm_caps.tsc_scaling_ratio_frac=
_bits,
>                                 user_tsc_khz, tsc_khz);
>
> will again hit a #DE, no?
>
> Even if KVM somehow makes it past that, kvm_guest_time_update() will put =
the vCPU
> into an infinite request loop as get_cpu_tsc_khz() will always return 0 f=
or modern
> CPUs with a constant TSC:
>
You're right, and it's worse than I argued. I went back and checked:
  - adjust_tsc_khz() gives thresh_lo =3D=3D thresh_hi =3D=3D 0, so use_scal=
ing
is always true, and
set_tsc_khz() lands on mul_u64_u32_div(..., user_tsc_khz, tsc_khz)
with   tsc_khz =3D=3D 0.
 So KVM_SET_TSC_KHZ itself #DEs -- the "recoverable via KVM_SET_TSC_KHZ"
argument I made is wrong; retract it.
     - get_cpu_tsc_khz() (x86.c:1652) returns tsc_khz for
CONSTANT_TSC, and mark_tsc_unstable()
doesn't clear that CPUID bit, so kvm_guest_time_update() returns 1
forever. Since vcpu_run() only
breaks on r <=3D 0 , the vCPU thread spins in the host kernel rather
than even failing the guest.

 Worse for my approach: that first one is a third division by zero in
the same state, reachable from
a plain ioctl and not covered by either of my patches. "Add a guard at
each use site" is a losing
strategy here.
>   static unsigned long get_cpu_tsc_khz(void)
>   {
>         if (cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC))
>                 return tsc_khz;    <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D always zero
>         else
>                 return __this_cpu_read(cpu_tsc_khz);
>   }
>
> And so this code will re-request KVM_REQ_CLOCK_UPDATE and the vCPU will h=
ang.
>
>         tgt_tsc_hz =3D (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
>         if (unlikely(tgt_tsc_hz =3D=3D 0)) {
>                 preempt_enable();
>                 kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
>                 return 1;
>         }
>
