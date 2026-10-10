Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15563DD516
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622800; cv=pass; b=arjR7Qy3WnpSmEJWruzxj83lz9lHY+GTQZB3BzAwCbx/4alQ/o1R3DIL3uOCdu1ZJt6KVZLbiz9Fukwrnwa41n4lD1F7u6KO8sAj3w/CPkALu/Bchc1EVoK2k1JsW9+3fFAAMQnsRB+qmx6uUN5CjuC2ibLC+3pPnAOE/HlytYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622800; c=relaxed/simple;
	bh=yPG7RiJteaqvJxMy3hLeBf5O/HFEk3LqcUfSdb8mln0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qva0CWTW4cgmwSGxNDMSP3SZtY9npo4OoEEHAr2T3H9aQaBIKE/bSBVfotEujdlFlnUwrSd4eCC05Ro256u8g6dNWMuL546v1zkttXKIpRwryL2M3UJoMJ4UubVrZsANr0eSxuNUPTwwycOSUFAgSK615CkH49+ETG5YsAlu0ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIr9jZMe; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIr9jZMe"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6c8f6a53fabso2203436eaf.1
        for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 01:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791622796; cv=none;
        d=google.com; s=arc-20260327;
        b=Rh1PHvFsNc0hTR48o2s//31BVYq7d6AXtS0KH8VH0cIMSvg+3ce4+8Msczfj4VD68M
         CYVbmonffETxp+CeX5zHc4ZxYNW5kX4/5Bdupz5eSEJTluQ+RD2OOGOpvNBWVFdZUkOL
         FCXmHdD1issRISonm7psB6Gp7A/bEnpdap0f/RuaUcipS63UW+NKlNghLAdNVQtwiw3g
         HqQvEU0hsgCAfi88WtmaasMLgl4JDzWM6RiDpSsLciLuW1+Pb5YUj5tCsrYSHxdyBATZ
         hXbAjbWRUzua4M/w90398XdgAeBP5AVQbsuvCQB0Ndx9BsmbSEl1G6MsksGkt10JoOoQ
         IZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eQkCKJzf+K70h3eWRGaHDDqj0UqDqcW0yE2LcECu2Kk=;
        fh=1vNZwQYDYnLohndX6gX6fGIH6oSjg4n0DxJ33Xd5uF4=;
        b=I27xxDp6b1840zSZnfmMlUk5I32Nqe7Y/GnX2CNAZQ4X79gP3Wqiy6WPJWPow1Np+S
         s6ewPaUMzL6I5mTbi8HPtySXKT69Szf7tsh0S/rqUA3fgZhK7bq6+6FlFkB1K4MJBbYE
         bg6CcxxEP1IgspCQoGIC8XBYvM/H2bA8y02u283hisT00CezxNIJyFh0yQP6ooulitVu
         E0Qer5LlU/rs0S0pv85hi08hXKi1bczSBR5EnVlZLHfLcvz5N8foiG5Sryz/AfPLbVSm
         z8ZHo3V+IWHkpu8HDoqn6BLX0ue4KMbjCytP/ML4UPWljNRu4cWM66nMYJjTGbp4+Tzt
         eIbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791622796; x=1792227596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQkCKJzf+K70h3eWRGaHDDqj0UqDqcW0yE2LcECu2Kk=;
        b=TIr9jZMeGPXNyq+sA2Durz8SjFPk4VJNI3xv3M9egt71XjfNfH+eHRUjrSU3xoqF4s
         baP1ASXK/yZItGhaj3+yNBDGfZIEU7RSDvoFB3K9+2ufYAxCdGggDBetsJRNh5PYgRl4
         AbJA+bml98e6USHNEV3kfaoWiHc6CVEePH0nt8GKYhf//pDFcHzLd/xi9E9/6Y5mM1mJ
         vgVfcXgnoovcb7KYz8UE+Vk8PJTUd6k/ueyKoeNbcsxE3zvJQKkfNoN6tf7/0M531yxY
         YYWqjPQaQfZ6mxeEauTnUrOGeIZ5f98FZVb888Cz/xUGJ6ghgJMkWRH89GCMdLJwxYYO
         4L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791622796; x=1792227596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQkCKJzf+K70h3eWRGaHDDqj0UqDqcW0yE2LcECu2Kk=;
        b=2iU8azFNDsbIlan1DcDK9pS/mt+mZuI1gDwAe8mfzeV9wZLTMouRjWb0fF2TCPiCAl
         PX0BXK5oN+kwtzh8Mq/jTVnecjpebKl26bH7v0mGYZgiYZHcza9jn4Rb+WgVV0HHM8VK
         j9IGR7gkpcGisNNSbE4LSfBXiUgke3Xz2p4hnnz6zshZSy1thZSDuI2hdoloM6+89g+e
         mXatvekUf2wlhY/3/2IdDj14De4idcbY5AzpnP4z7dyhm5gieKx80tlfyfAuEvzruzeK
         eW3MuTL5i5+IaZOrN0xyduJJCkyHEn6BdVhBkXlVTfLXZDPdEBP68EdVySFH4Ri+VuhX
         AzsA==
X-Forwarded-Encrypted: i=1; AKwUvBx7a8GI/awhIReG3zjt87s88naw497t0562W0tQFQmjtv2K7d9c4oL2a3f02aEepaNzE0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuuUwJdmgMl3bNDA8G55YJwlggdlnbKzYip3yhEzUr3xS0c4iK
	QKY9f3uHHJ+pnxFpNpkfzymhZ8Fh+Dn2mWowc8eilGUz4Fs9d9qNSzlYuA3kPiPd7w8nNmWLbPX
	nwxlYC5Rumx+lWjzd9UlKBr8vTIgQgqs=
X-Gm-Gg: AYBFou2gQ1YJMqmiC3WpIMVuNhP+VQR82/gwblooPD1lP3BpWT2mLW+W8hlL2KrWgXZ
	tY1mILn/q7q9o09uqZS88YHrIFBanvhN2JDvjRIew6lR29FnmxjJS6PY0jGcfT4HGxD5KBZ/QEq
	WpAdiEJRzMNvvzcUGXoM5b248iUDpQK6dTjxBfgDeONV/xQ6N2KltiBgjOgGQKJ9K1SC4C3cNEk
	lsGGP7qUGfREburw+md0jBmzkm6zx+wuzSth0iL+5wUVHKJNCskxUC1j/cxngzfpezIzT1GuslM
	4NEPiiw1s2GCOS7XY1MlHC1/XQq+ZKtz97yULM0/v5L24djD+OrMCOk=
X-Received: by 2002:a05:6820:a09:b0:6dd:9d9d:50e3 with SMTP id
 006d021491bc7-6ef0cb3d34emr2383877eaf.10.1791622796181; Sat, 10 Oct 2026
 01:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008090037.86931-1-flyingpeng@tencent.com> <aslQLXcK1VXSkrVo@google.com>
In-Reply-To: <aslQLXcK1VXSkrVo@google.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Sat, 10 Oct 2026 16:59:45 +0800
X-Gm-Features: AclHuK_Eh4jH9U93pYfHbfQu8YsRH9fT4AkUj2wjYQQTuBXR622OpNEx4Nmszxg
Message-ID: <CAPm50aJ6uudDOAC-XN1qQAd=aEtKYVgKuQWwM7cmLOsruQR9xw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Guard against division by zero in adjust_lapic_timer_advance()
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 4:35=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Oct 08, 2026, Peng Hao wrote:
> > When TSC calibration fails and userspace never programs a tsc khz,
> > vcpu->arch.virtual_tsc_khz stays zero, but the lapic timer's
> > software-mode expiry path still calls adjust_lapic_timer_advance()
> > unconditionally on every timer expiration (unlike
> > __wait_lapic_expire(), this path is not gated on tsc_scaling_ratio).
> > Both the "too early" and "too late" branches do_div() by
> > virtual_tsc_khz, so a zero khz crashes the host with #DE as soon as
> > the timer advance drifts outside the adjust window.
> >
> > Bail out before either division.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  arch/x86/kvm/lapic.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 13e32c4915e2..4dcbc66c8e07 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -1991,6 +1991,9 @@ static inline void adjust_lapic_timer_advance(str=
uct kvm_vcpu *vcpu,
> >           abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_MIN)
> >               return;
> >
> > +     if (unlikely(!vcpu->arch.virtual_tsc_khz))
> > +             return;
>
> Ugh.  I'd rather reject KVM_CREATE_VCPU, even though there is a rather su=
rprising
> amount of code in KVM that does indeed play nice with tsc_khz =3D=3D 0.  =
I don't see
> how the guest can possibly function with virtual_tsc_khz=3D=3D0.
>
Agreed the guest is broken in that state -- virtual_tsc_mult is zero too, s=
o
nsec_to_cycles() returns 0 and the deadline timer fires immediately. But I =
don't
think KVM_CREATE_VCPU is where to enforce it, because letting vCPU creation
 succeed is what makes the state recoverable:
  - kvm_arch_vcpu_create() deliberately ignores kvm_set_tsc_khz()'s -1
  - KVM_SET_TSC_KHZ is only reachable once the vCPU exists. With
      kvm_caps.has_tsc_control and a khz below kvm_caps.max_guest_tsc_khz i=
t
      recomputes virtual_tsc_{shift,mult} and the guest is fully
functional again.
 - max_tsc_khz does the same thing ahead of time, via default_tsc_khz.

 Rejecting KVM_CREATE_VCPU removes both, the guard is the kind of small,
obviously-correct fix that is.

> vcpu->arch.virtual_tsc_{shift,mult} will also be left as zero (to avoid #=
DE there
> as well):
>
>         /* tsc_khz can be zero if TSC calibration fails */
>         if (user_tsc_khz =3D=3D 0) {
>                 /* set tsc_scaling_ratio to a safe value */
>                 kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_=
scaling_ratio);
>                 return -1;
>         }
>
>         /* Compute a scale to convert nanoseconds in TSC cycles */
>         kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
>                            &vcpu->arch.virtual_tsc_shift,
>                            &vcpu->arch.virtual_tsc_mult);
>
> and so nsec_to_cycles() will always return zero due to multiplying by zer=
o.  That
> means things like the APIC timer will always fire immediately:
>
>         apic->lapic_timer.tscdeadline =3D kvm_read_l1_tsc(apic->vcpu, tsc=
l) +
>                 nsec_to_cycles(apic->vcpu, deadline);
>
> The first instance of this goes back to 03ba32cae66e ("VMX: x86: handle h=
ost TSC
> calibration failure"), and every "fix" since then has been to avoid #DE.
>
> > +
> >       /* too early */
> >       if (advance_expire_delta < 0) {
> >               ns =3D -advance_expire_delta * 1000000ULL;
> > --
> > 2.43.7
> >
