Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F43CD8C3
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576881; cv=pass; b=kvCpEZYTuIx7Y42LDvwoMNmOcuUK9uI5qFuIhtEqGdTFbOWnCCpU6MJ7GeS1BHFJbpEs71wRnd6dbFJ3nBFKsg/IdEmda4k4Y0gDGOPaN/5En12/2qzDzQj77ic/ICyVchIAtPplzHwkfkKGfcbRQjGdIYiWxq33X/h9hAKvyBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576881; c=relaxed/simple;
	bh=T2uG1PHZ2DZKJc4V1Fkt5QBNKproLnPf5esVaJ56cdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVDoHc9Jks0xe6tO/4TLd99Hac7UE/hNVz0n9il1nDsrJs8Uyk7RExNXjiPiwNekBNHmrPQqC/mujJ9TIe3vtg70ULdlCbC8L/DDepd5Gmz4DiHErUJkWYxygHKDRKHw/uGp5ThQHahOY3EJ98xwXMNvHwCDq4Wngmey8fw9dFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZEhTf10; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZEhTf10"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so40866a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 08:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775576862; cv=none;
        d=google.com; s=arc-20240605;
        b=hbbpA1/1OUc4FoGRxIWcM/qmtDenN7EOkebyHh1UrW2vXxeCQoxm41/xru4NRu1NQp
         fzXg8Z+Wv8jMzcKckoJTbO7Ugkev9dDLa4HCKUD/cq3Lcdzx+G3iUvsGskeHIruuVVVx
         xDq42GYckzWOe4lgHvrXuwJ26qaQhU+G2J5kk+H6rdJjr/1g1V8D6aJXTUwOzTlkFXlC
         bzPxgmM7KoROG2JEObhLCEG8Kn27T8ACZTXnvf3Gc+fDbQds7ifnINR0usF1yv/b3moH
         ZRxJKA1kNexZcz/NEZ4zrObdI3MX9Y3D30GZgIpxixyL/Lzu8DkDAOTa5Tg2qVj+XTPn
         78gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OW0PL7Trk5Nbi8kfx4y+iqIlG6zAN+Q5XpqbwQzl6Ao=;
        fh=pW/oq1nKETcyCWC471rvYnn8zokJNQXGuBhSIqWmbtI=;
        b=aJcP4OJ73FIyVXsqNHiRPpHkJixYUUYveb8BHteQ6lZC4VNQVPVjtsQNf6OapACFEC
         mHw8YOK1ZFXm1ssJEmn0bgNlrXgbfw33rsh3G27wu2LJ7RnRp+gnUCCZ4uxzqIcWtOq7
         6OkswiQvHH/ZHhBhg5YWxFNBSPccJuiymaFU29j7w6SCvCJUbjNxfLYZ/M72Blt6Myl4
         JGFvHu1uHqOTb7i5PaYylQic2/jM5mcvpLqurlbMePhJ3nq5ycXIajd9Yajm1sfn9Ld6
         ravA/dFoe5eYxXs8k6RxqXRXUpW0zb69jiSESopqmBkTdaA8WxoeXS+TMQge6hbA2Jau
         i6FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775576862; x=1776181662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW0PL7Trk5Nbi8kfx4y+iqIlG6zAN+Q5XpqbwQzl6Ao=;
        b=GZEhTf10cluMSMlPZxugEczYelJ8qkSlDVDCxhNasE8hHjXOUVNPL7lr5C9XgmpuIF
         i/Ma+TUcfxVoOVZAKFwcpOm1EeL1oFIOCMAVbG9bQcTMNhiLOYcmvV/s8qUOzkcA7kE5
         P6VTNiAQIqpr3Sz6hNDzJMe8dd0dhnTViQaBx4hlW3R72NOaYjIJvHnKCX8SbjJpTYIK
         IxoOQlk2tAL+7Ohq74mMuXtjXKFq2zNRMMgaqmliF59TztI8mWEE/0lvNeUDAwrtehpU
         XdyHuXghUlaAonzG9NpjlX9JPAHLp77O0fIglV7ZfBZfivJIE9NiWjWcZs63/cXKIMea
         9LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576862; x=1776181662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OW0PL7Trk5Nbi8kfx4y+iqIlG6zAN+Q5XpqbwQzl6Ao=;
        b=TciSM0m0yTxF5eMpQe4iU/b45u4e/P0/REyinjmn5dr2LhbyFVm2e6EM1eIfvD0+hJ
         UYCiOR5l70IZ5+0DdlfS1GEY3nDQEk45q5h7QVPi6mMyrPONOiyZ0RpyGUMpfcpDscrX
         F3Dzd0r/J+MkWe6rVEfwh6/TlaPgx+3s7Z0kgIgapVDe7IGivfY7MLlSx3I/icVs81KF
         WZuh+8DXMJaMg6TXvhQIPKyJm3tcfeC7YfVVELFjsC7tQT7/gidcS7F15KXkPDxxZ339
         HBBGn7yuWlns/SF3ad/6mOs3AzzlmIuAQy5y97Q94y8y9vfh/kTfynSzcd8AqvdLz0YL
         PlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk9DsWVj13cvLozQhQ0+zoGijXEj3xgjhtb2iJn51951Tdd7VvJy7Gu20JF4Wida9mbfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPlzSvwc9//zKEV/JHaYaQv6uP9t52Y7qURjEX3pTFsf80WuY
	z2uh9QcmAu5PIgopfs4tjzyhLE00sjBuAQxxw0LdQgSSPSgmiHwGG/ywWDqkXGGXzr6vswf7d6C
	OBp9cM7b9HuLjDrG0weATZzT4/GHYulxZcVRWmRJ5
X-Gm-Gg: AeBDietJ+/NXbCkF78Rw5wuKwxo1AM6HhjZX+9NDxk9QGMkx+a+yyNlNDm5gi/gFk7x
	1fBk2VopO2jRXwc9JoB0mDO0pJd0DSsAcsE2ZfnOu+tK1hKa93juqNUS4zBCPlDvQL9Ly+cfaaE
	zz6+9LcJPS3DLDuqrsHTmALyRJ4ZPljMyimp4CnZZpbqrpW47qVXT6mZeJiMKhJsLQILqYD/Bnv
	5Jif5KlTXqkj1hnwIDZjA78NAEo4c1oiFmsBggMV3u8DXsvymyIahV4V3a9FgEjQ2PO5M7K2fnd
	eqyl+xA=
X-Received: by 2002:aa7:d1c5:0:b0:66b:99df:42e2 with SMTP id
 4fb4d7f45d1cf-66e4136b6admr159703a12.10.1775576861215; Tue, 07 Apr 2026
 08:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-9-jmattson@google.com>
 <adRGLPrmBpX-3DdX@google.com> <CALMp9eQsd0fRuDE_R57Mn6-N6jCtbmoPAh7Y7CBdMEZJaNSUGQ@mail.gmail.com>
 <adURPZJEDs50NPkB@google.com>
In-Reply-To: <adURPZJEDs50NPkB@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 08:47:28 -0700
X-Gm-Features: AQROBzB9-2Y6jBk2OjVBHpaQ7SDFWjJWA4zzLhVGVcrjOpWk0jyI179MFPhotc8
Message-ID: <CALMp9eSysKOVGF_xakbT59tVsgER6oEYpJuK9=hQutjY=ZpM-A@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 7:14=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Apr 06, 2026, Jim Mattson wrote:
> > On Mon, Apr 6, 2026 at 4:47=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Fri, Mar 27, 2026, Jim Mattson wrote:
> > > > @@ -1918,6 +1921,7 @@ static int svm_set_nested_state(struct kvm_vc=
pu *vcpu,
> > > >       struct vmcb_save_area_cached save_cached;
> > > >       struct vmcb_ctrl_area_cached ctl_cached;
> > > >       unsigned long cr0;
> > > > +     bool use_separate_l2_pat;
> > >
> > > Land this above "cr0" to preserve the inverted fir tree.
> > >
> > > >       int ret;
> > > >
> > > >       BUILD_BUG_ON(sizeof(struct vmcb_control_area) + sizeof(struct=
 vmcb_save_area) >
> > > > @@ -1993,6 +1997,18 @@ static int svm_set_nested_state(struct kvm_v=
cpu *vcpu,
> > > >           !nested_vmcb_check_save(vcpu, &save_cached, false))
> > > >               goto out_free;
> > > >
> > > > +     /*
> > > > +      * Validate gPAT when the shared PAT quirk is disabled (i.e. =
L2
> > > > +      * has its own gPAT). This is done separately from the
> > > > +      * vmcb_save_area_cached validation above, because gPAT is L2
> > > > +      * state, but the vmcb_save_area_cached is populated with L1 =
state.
> > > > +      */
> > > > +     use_separate_l2_pat =3D
> > > > +             (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP) &&
> > > > +             !kvm_check_has_quirk(vcpu->kvm,
> > > > +                                  KVM_X86_QUIRK_NESTED_SVM_SHARED_=
PAT);
> > >
> > > I vote for either:
> > >
> > >         use_separate_l2_pat =3D (ctl_cached.misc_ctl & SVM_MISC_ENABL=
E_NP) &&
> > >                               !kvm_check_has_quirk(vcpu->kvm,
> > >                                                    KVM_X86_QUIRK_NEST=
ED_SVM_SHARED_PAT);
> > >
> > LOL! Aren't you the one who keeps complaining that my indentation
> > doesn't line up? Are you schizophrenic?
>
> Huh?  That is aligned.  Perhaps it's whitespace damaged by your MUA?

Indeed. It was.

> > > or
> > >
> > >         use_separate_l2_pat =3D (ctl_cached.misc_ctl & SVM_MISC_ENABL=
E_NP);
> > >         if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM_S=
HARED_PAT))
> > >                 use_separate_l2_pat =3D false;
> >
> > Wow. I really have no idea how to predict what you're going to want
> > the code to look like. How is this better than the original?!?
>
> It doesn't immediately wrap after the "=3D".  Similar to my view on wrapp=
ing before
> function names[*], I find wrapping immediately after an assignment operat=
or to be
> unnecessarily difficult to read as it doesn't provide any context for sin=
gle-line
> searches.

That's actually a good argument to *never* wrap a line. If a line is
broken at all, the interesting context might follow the line break.

> I'm pretty darn consistent in my dislike for that style: I count 26 insta=
nces in
> arch/x86/kvm that match "\s=3D\n", and only two of those carry my SoB or =
R-b.  I
> simply missed the wrap in kvm_vcpu_apicv_activated() that was added by co=
mmit
> 896046474f8d ("KVM: x86: Introduce kvm_x86_call() to simplify static call=
s of
> kvm_x86_ops"), and I'll give myself a pass for commit 8764ed55c970 ("KVM:=
 x86:
> Whitelist port 0x7e for pre-incrementing %rip") as that predates treating
> checkpatch's 80 char limit as a soft limit.

Might I suggest that you should provide a tool=E2=80=94something like
checkpatch.pl=E2=80=94that flags style violations?
