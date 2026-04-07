Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC03B8954
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571265; cv=none; b=Iap2oZyw3j4X7g9NrtkSI0hMn3QiD8v9jGOzZ9wK5peaqVS90jHhAmULxrCz1kM6yA2tUEO8R2UUTMAbYmjMstkMtnPvRjj+tkr5q693xTgLGAttyn5F73chIN37FH8m/F903F38rr+tpaToJQdUjTVzgnW9Cow/ysb0jif201E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571265; c=relaxed/simple;
	bh=x1X6Et09LdVmwK4AwqUKUpjcDLoVxP1vs1Syj2oayko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ctSJXaODxrPNa3rsMiZie5wydk2Jv0ZLpTPdne3gX8RwmChQyCHYjhkEeY/DyVD++/3sYtjaS+AJNKSCxWmMYDXy3kv3wEhg7gyghvS3p2u01jspIaVVIX3NEo1RGh/lUqau5VJZ1FJOPqucGfxs9qyiuiU5bBs+tQ7HiQ3Qhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFD+BeSG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFD+BeSG"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c6929bd26so6409203b3a.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775571263; x=1776176063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh0Qcy7NAcZjboyYi+P+h2qLdGnuUSHfUg4cTPCdmsU=;
        b=nFD+BeSGicoCBbQCAhStO53LmgxVirn2DMVioSEswFtgCE7cmvjE+v21TcTRvlfERa
         aR88hHbyjPXSEtt+FJ0RNTfXQfz68cBBDkXFz7jI3gFX/7ZDYlDMkuWd5rwJ1IYFOvHf
         zIlyT3E/TaEPO31BQYsMauaLOYCU/i+/hj7CvlPIiimCmnYph+SF1h1Br5TjqYThinZ2
         OO9gOvXRlswAgPcta83UPHIwxZD/b4Wp2VglbLv1EoD+fbYgIBl6ypRMPPsbpVVz++ac
         ok5tgyKN4JBMkvxAIINvts8zAyR8X76a2+h/JLG9lWK37dBw4NlXBkU0pSu9gtKZApnZ
         Md4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775571263; x=1776176063;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oh0Qcy7NAcZjboyYi+P+h2qLdGnuUSHfUg4cTPCdmsU=;
        b=s//odccgFGv4n7cU4+P/EUtD68mQe7IM4gudr2/qm91E9Kz+ctduJ3qlo94YpnNpKe
         S4BBDUaQcTprALB2QGKAi3GfPaXt2+PzUpqJftjbM+vhDmD62Aoitjql+RJopu66x6Y/
         +wruB+nLiRtR/THcXBSmkSEvw4CCIGgqmPwMSyLgdzyMY4iYpvRYR+4Yx9Nj07ZToglR
         mbizZ99gF1OUq8VNAjpbpe6bVIz7gVB6OCJNSHJ9admzpjUYLdTDlju6wrzV+ozfaEvW
         eE3YumUVyqdEkK3T2FiliG7lfzgDW+6T/U5SrlQhEqXiK+I4HvPkTRSWwy7DvLpA0X/S
         5gTg==
X-Forwarded-Encrypted: i=1; AJvYcCWUx5YOyg0RRb1r4NkE/R/O36+12/drx8+aEo1+RslpBk6z1FXUXgHv8G8j8QUcXimoSX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdQJa4dPxTbO9ETg/a58miIHTG3VTWOgfQCuYEm8niaxxcRK7
	WqVOiIQjrrOGtFdgvkvZ+d/PY+6jo+XSk14rivq35icvRb4wbIarzmPOlgfVwaAMHV+yvPQrOHi
	Ou/ceFA==
X-Received: from pfaz1.prod.google.com ([2002:aa7:91c1:0:b0:829:894b:618b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21d6:b0:82c:d7e7:2f8a
 with SMTP id d2e1a72fcca58-82d0db96cd4mr17107604b3a.39.1775571263189; Tue, 07
 Apr 2026 07:14:23 -0700 (PDT)
Date: Tue, 7 Apr 2026 07:14:21 -0700
In-Reply-To: <CALMp9eQsd0fRuDE_R57Mn6-N6jCtbmoPAh7Y7CBdMEZJaNSUGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-9-jmattson@google.com>
 <adRGLPrmBpX-3DdX@google.com> <CALMp9eQsd0fRuDE_R57Mn6-N6jCtbmoPAh7Y7CBdMEZJaNSUGQ@mail.gmail.com>
Message-ID: <adURPZJEDs50NPkB@google.com>
Subject: Re: [PATCH v7 8/9] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2026, Jim Mattson wrote:
> On Mon, Apr 6, 2026 at 4:47=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Fri, Mar 27, 2026, Jim Mattson wrote:
> > > @@ -1918,6 +1921,7 @@ static int svm_set_nested_state(struct kvm_vcpu=
 *vcpu,
> > >       struct vmcb_save_area_cached save_cached;
> > >       struct vmcb_ctrl_area_cached ctl_cached;
> > >       unsigned long cr0;
> > > +     bool use_separate_l2_pat;
> >
> > Land this above "cr0" to preserve the inverted fir tree.
> >
> > >       int ret;
> > >
> > >       BUILD_BUG_ON(sizeof(struct vmcb_control_area) + sizeof(struct v=
mcb_save_area) >
> > > @@ -1993,6 +1997,18 @@ static int svm_set_nested_state(struct kvm_vcp=
u *vcpu,
> > >           !nested_vmcb_check_save(vcpu, &save_cached, false))
> > >               goto out_free;
> > >
> > > +     /*
> > > +      * Validate gPAT when the shared PAT quirk is disabled (i.e. L2
> > > +      * has its own gPAT). This is done separately from the
> > > +      * vmcb_save_area_cached validation above, because gPAT is L2
> > > +      * state, but the vmcb_save_area_cached is populated with L1 st=
ate.
> > > +      */
> > > +     use_separate_l2_pat =3D
> > > +             (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP) &&
> > > +             !kvm_check_has_quirk(vcpu->kvm,
> > > +                                  KVM_X86_QUIRK_NESTED_SVM_SHARED_PA=
T);
> >
> > I vote for either:
> >
> >         use_separate_l2_pat =3D (ctl_cached.misc_ctl & SVM_MISC_ENABLE_=
NP) &&
> >                               !kvm_check_has_quirk(vcpu->kvm,
> >                                                    KVM_X86_QUIRK_NESTED=
_SVM_SHARED_PAT);
> >
> LOL! Aren't you the one who keeps complaining that my indentation
> doesn't line up? Are you schizophrenic?

Huh?  That is aligned.  Perhaps it's whitespace damaged by your MUA?

> > or
> >
> >         use_separate_l2_pat =3D (ctl_cached.misc_ctl & SVM_MISC_ENABLE_=
NP);
> >         if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM_SHA=
RED_PAT))
> >                 use_separate_l2_pat =3D false;
>=20
> Wow. I really have no idea how to predict what you're going to want
> the code to look like. How is this better than the original?!?

It doesn't immediately wrap after the "=3D".  Similar to my view on wrappin=
g before
function names[*], I find wrapping immediately after an assignment operator=
 to be
unnecessarily difficult to read as it doesn't provide any context for singl=
e-line
searches.

I'm pretty darn consistent in my dislike for that style: I count 26 instanc=
es in
arch/x86/kvm that match "\s=3D\n", and only two of those carry my SoB or R-=
b.  I
simply missed the wrap in kvm_vcpu_apicv_activated() that was added by comm=
it=20
896046474f8d ("KVM: x86: Introduce kvm_x86_call() to simplify static calls =
of
kvm_x86_ops"), and I'll give myself a pass for commit 8764ed55c970 ("KVM: x=
86:
Whitelist port 0x7e for pre-incrementing %rip") as that predates treating
checkpatch's 80 char limit as a soft limit.

[*] https://lore.kernel.org/all/CAHk-=3DwjoLAYG446ZNHfg=3DGhjSY6nFmuB_wA8fY=
d5iLBNXjo9Bw@mail.gmail.com

