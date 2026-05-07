Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8C346791
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189539; cv=pass; b=K6xzBhVNYYlqfgV+8G4bPQrdJ8nA+XtuEPgwkgk2hHkNcZ+v9IDW4EHpaoux5P1QwSCh/yjMjYHXyRfcBJ69Yig4XugacKkDsgzhdQSaxovGyn9jiNDWbdl8oiRxI/oSNghyi8VNzOxN4XPcZ5fNcVqzrcK464DawDaJewf15lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189539; c=relaxed/simple;
	bh=ChoDXU0LVEOrs2nvYt60+5edVTs+2hj2g/ff/IT1rVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocHlJusvr2ccJhIynubWQIqCQBZIGiKn41y1W1c5O3Qt9WfJJ82qBhqmIgE8ic4dVy1WxDUAYxxXynvkfebx4QfI3P8sz1hSG/yRkGoW8vv0qVhF5lY8SYoPBi3Or6FEqh5t8lASPzeDvX7wjPNzvkBbhH/PfIBAAhc67Ky8/ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JASb6oVB; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JASb6oVB"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e61648f10so71651cf.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 14:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778189537; cv=none;
        d=google.com; s=arc-20240605;
        b=YGaKq14B/wWzqlP0AtAsGHsF0PVaE8oXPM7MXbfJY41iUGKdQkC/N4nWE+PBjFDjM4
         /qFFtz2HF5bkPx6MJ2Tq5SSf/nbueJuOn/WB1yoQfU5CU0uOCoFuWajwax7r3Sm8uWiM
         +mA8USicfXRKC37HmiQI6KiqG1xRqtODwoZVMy/daQEf93UsAEEeeCM0ehq233L3Z38L
         SnYL94EwwsAKvqVlz/qCAd0DTpUGxgE/HzSUACF6u5vTpzYzhl1HcU//qgalFAxho08B
         A3sw5eNbfzVkk7lO5ZAZ6by9a/Oz7Sd06e/0bryB1sTOqxInbr4lJD3aLph5iJWF1MZe
         z+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=atCOItSnoMMEv+euvWojVr87WM45TeMcPGDANYZmCgo=;
        fh=fziYaWTVymtZbT7NxoUACt6crv8lPRxJVFV8y0rCK1I=;
        b=efsuFik6zUAUVMl/ifvxqy7Tlv7S1XFOxmVMx6n9NLVzp9hndecRvOGd7IX9W77+k+
         BuFPRiilB+XF//kM+YA3VHIwMgBBRIaGsHmpj0l0cTOdDroQT6IBDGiRvImBNkKX2wb4
         WfivLO/24m+BhM4Aj7l77Xc2HfWrg/fr6zsqtzu021ahyuCSkQOi9sRopk6DCBirhkRv
         4vbVEd+J9h2MMNCo/yt9Ny4VGtuaisXhRzbWlzEtf6/t2f7NADYp2tQHM3YcKL1qcJeP
         Zq1EQ+pY3xpEDb2ox/AJFUmco2rHdTktuJBccTWkCTZ7EkdH0HdncFRAQsFr+eYt/gdD
         G/Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778189537; x=1778794337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atCOItSnoMMEv+euvWojVr87WM45TeMcPGDANYZmCgo=;
        b=JASb6oVBExzY5LpRdG85oISXSgj0l1h8tMofolUI67zkX5jJP4sSzPWLnHVGSacI1j
         huxZOyMWMCuQ0zaesNoYdVWIvuRfv234lrwIPDv1TPa3JJ7wQVzki1/rtivzYQAZIlNa
         49uA92qMAmdSvldtAklNFl1kHKLX45/GIG2Cr0RzPzola7Rtwu25X/ScSltjGy2LbY+m
         ii+O7s8rwqDFNKubVGi1Ht9Xv4bO6xPVKrH+YXQ7HroXuIgTT7YnfNqI5Vz2vUVVAjwJ
         PbAYDFfKoaPcH937gL6fkLFJ1/LumN8zHxKxyh6JhosAKhhaB2+H24j0Ty5rAbDmxv+r
         oslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778189537; x=1778794337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=atCOItSnoMMEv+euvWojVr87WM45TeMcPGDANYZmCgo=;
        b=cPbE5m5c4B3B3PyLHCorQqxZ4TVPTcn5QLyTAJjmIBWXISZRnNlEdvel3PjictC5mN
         TZ1jR7P92ar7/rWjKqCcqd2DAf66ABr9O8NTLTJgA0Ib+u09t/XvNX94gEEWkuauo+Tc
         vKrrlDYBABhWs3goJIkx4yJeQ26HjSAqzFfNsIP1wstpUWuPVR20IBQvV0FsEXZtgtAV
         jP2NGfsam/9/5wT7cVyyRh+ONtAWyT1vYhn4RFISCPgfj7NKNGmJjOP47+xK1/ppxb/Z
         qzTGOM6wNe+ILodM4isLvl8a2E/LcKwbSuyPr1LzEEHdU8wkp9rcJdr0P5+UIp9dVrSE
         7Yjw==
X-Forwarded-Encrypted: i=1; AFNElJ/BAoK7iEH1yZNWtUAhkiym1Q2cSzD1TEuNDz/tZTz2Jpwa+IdNM0+8jsAm7Utx0ZDBWpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZGRpq+Tcnd9iMzNuDr0K6n3NQK0kwgkYK8259XU5HjaQJ4WS
	bFl9RZu9bJ6VYyf6hBnu+fQfPmbWvgE8nbD3Hatq9kJnfzx3NCsXQCaTVi7SKLyyIcU5OfLUY7x
	hq3ltZY8xDMrZZfEwVSyA+ZSz+TZm8DYs6DrWnZSU
X-Gm-Gg: AeBDiesxgqS9NKAmneijJEMBRv3yhohP5y4sOEuCCDpqxwKSeV5xup1nDXVt47IH5bc
	GHYR54yc743TMm6nsWgnn63fp0D0UFxbfgBKzsrftFWMf264jZ6EN05WGNr+XoRBMuSWNDEuPp8
	WBYMOEcFdwIeZtBUux5dedggNemOhKSY/EUkjfMubx/T8BAdtT8u9yeyyy+n0Tj28kz3f8jmTX0
	8Lxz2pjK7fWsUnLojQaE0RsrOjBmqykQXx2/aJ45d9CgKnVhfIKC32g9lAHswBDUFBjKKXK0eW+
	EZa8JiROEXPfDnKE52Nmbss6aFMmlnGwbE6+ok8Hk8GzgUCMUIQ=
X-Received: by 2002:ac8:7c50:0:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-5148cd0c0bamr1769371cf.15.1778189535912; Thu, 07 May 2026
 14:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507142402.2175933-1-vannapurve@google.com> <afzyAorFFnwsh7u_@google.com>
In-Reply-To: <afzyAorFFnwsh7u_@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 7 May 2026 14:32:03 -0700
X-Gm-Features: AVHnY4IVWJ1KXfT1M8Es6O0Pn48jw2N2ukdUOJMcSXwtPYPLKHW7bz49D3ExdOA
Message-ID: <CAGtprH9YEGd4dJ8db4CJD3NMkW4Kt2SBQT5RUrB9hXRa6i1kpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] KVM: x86: Introduce has_protected_pmu state for
 TDX VMs
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 1:11=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, May 07, 2026, Vishal Annapurve wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 0a1b63c63d1a..99a383455d46 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -6910,7 +6910,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> >                       break;
> >
> >               mutex_lock(&kvm->lock);
> > -             if (!kvm->created_vcpus && !kvm->arch.created_mediated_pm=
u) {
> > +             if (!kvm->created_vcpus && !kvm->arch.created_mediated_pm=
u &&
> > +                 !kvm->arch.has_protected_pmu) {
>
> An offlist Sashiko review pointed out that this will prevent doing
> KVM_PMU_CAP_DISABLE on a TDX VM, which could prove problematic if userspa=
ce is
> already explicitly disabling vPMU support for TDX.  I was thinking that w=
ouldn't
> be a problem since KVM already disallows KVM_PMU_CAP_DISABLE if enable_pm=
u=3Dfalse,
> but in that case KVM doesn't advertise KVM_CAP_PMU_VALID_MASK:
>
>         r =3D enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
>
> And unless I'm misreading QEMU code, this will indeed be a problem.
>
> Argh.  I was going to suggest something sightly fancier, but we rather st=
upidly
> didn't provide a flag for ENABLE, and so we can't feed has_protected_pmu =
into the
> valid mask.  Lame.
>
> The other super minor detail is that kvm->arch.has_protected_pmu isn't gu=
arded by
> kvm->lock, and I really hope we never get to that point (e.g. for SNP).
>
> So instead of disallowing KVM_CAP_PMU_CAPABILITY entirely, this?
>
> diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
> index dc69b8cebe0b..b833a2596430 100644
> --- arch/x86/kvm/x86.c
> +++ arch/x86/kvm/x86.c
> @@ -6911,6 +6911,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                 if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MAS=
K))
>                         break;
>
> +               if (kvm->arch.has_protected_pmu) {
> +                       WARN_ON_ONCE(kvm->arch.enable_pmu);
> +                       if (cap->args[0] =3D=3D KVM_PMU_CAP_DISABLE)
> +                               r =3D 0;
> +                       break;
> +               }
> +
>                 mutex_lock(&kvm->lock);
>                 if (!kvm->created_vcpus && !kvm->arch.created_mediated_pm=
u) {
>                         kvm->arch.enable_pmu =3D !(cap->args[0] & KVM_PMU=
_CAP_DISABLE);
>

Incorporated this in v4 [1].

[1] https://lore.kernel.org/kvm/20260507212957.2629561-1-vannapurve@google.=
com/.

>
> >                       kvm->arch.enable_pmu =3D !(cap->args[0] & KVM_PMU=
_CAP_DISABLE);
> >                       r =3D 0;
> >               }
> > @@ -13375,7 +13376,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned=
 long type)
> >       kvm->arch.default_tsc_khz =3D max_tsc_khz ? : tsc_khz;
> >       kvm->arch.apic_bus_cycle_ns =3D APIC_BUS_CYCLE_NS_DEFAULT;
> >       kvm->arch.guest_can_read_msr_platform_info =3D true;
> > -     kvm->arch.enable_pmu =3D enable_pmu;
> > +     if (kvm->arch.has_protected_pmu)
> > +             kvm->arch.enable_pmu =3D false;
> > +     else
> > +             kvm->arch.enable_pmu =3D enable_pmu;
> >
> >  #if IS_ENABLED(CONFIG_HYPERV)
> >       spin_lock_init(&kvm->arch.hv_root_tdp_lock);
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
