Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EF3CA486
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864525; cv=none; b=CZ5j8HcvLj2Ouq7MiV3eXTFhYesUO/NMeVzQK8cgvkThr2ciqNyOPmdqajFNKCK7vGmW49YdLqADgA4Z45kXkZlPfs8P5PoceDI/0KiwCPNFrp00op6qcEq1ET4/leZXvB3v4gvPJMl8XIrtcQfaByK3g1WXJAjkXpxAGFXAGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864525; c=relaxed/simple;
	bh=iKqXrXXEueLz0Wl+PbJ55dtQU+Zoh4YxTnXjCzPBsuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lH/ChV3tc1sLbgFVXKZFyqib3+JuQ+E1D8ui6R/4hxfyVTxXfkasqfzA/1fqGsfTQCb7l1ABBw22dwOsL8VmXDeZUIp2/WvQNS7pClTjrZYhDbFAM89nZPlVx5yZSOMkDL422CLD8ksndYIeTHtRe0T+iKTizHdvSCe+c9VJu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3r+K9IG; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3r+K9IG"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so4419435ad.3
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787864523; x=1788469323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9TFR6u7il3e/CgCyGIr0QJPtUjW/Hrr6HrFoOjzuX0g=;
        b=q3r+K9IGxkddtgcD7smxnv1Ng7QAba3h/XJ16viUhyAMfH94t7yzKtaPExSYmKAHXG
         mg176cqK1pzJY83r6B4EXXXMQ0b57vRzqf9Lz7Vga/dlY/09epokSkTEn8Vu4/hvCULj
         uJeYb40ztUIbfQRs/KB0IPAXstb1xEW4MGGSh9P6u3fzl5k1SqOOCXGrJ0VdEfv8TZP3
         kJtcg810q8Y0AmvfAvV9YodzPmLJpJVYxFVkEe1LEju2ywuuH/phndO8ra/hzWgyTbcd
         8wrKldjpL4WWkX0Fe+2XmJXxwbQSx4zjfd7msC9HXmlgBa0CUQT/hRAlKLyQvWg4VvU7
         qc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787864523; x=1788469323;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TFR6u7il3e/CgCyGIr0QJPtUjW/Hrr6HrFoOjzuX0g=;
        b=ewPJDSHtG/pBNdvNTjQC2/FBLEA1VfV4msZLPPq6ijTqwf1+rsJDCzhR4uYY/GzZ03
         ZGBFei7GHopqqF2/tLsFNqvJCsbV4AAIR7pP9dnEqxV3gckD1cWW0vb5qTpTpPeSuTGD
         smTfEcrfmJs1/00TNMgC+QmWtLPZ1m5Opu5qeSbB1JoIiZTkLlV3GrHD/tMV2qribyCk
         xpPT8MV7LIChB/v/kLHQibR1vNs6WyizncENbg2L8H+aII8auPjwQXpu9sFrWB3oKblT
         9WXrFoNaV65Actuof385gyYJNQtScV812dtMf3WGbT2yvmSVJWyxMTcryV1nQSKB9v4e
         VPKg==
X-Forwarded-Encrypted: i=1; AHgh+RqQYayE2gGevRnXklOK1YuebRZi9ASQyeLEjGp541B81lXMPubObAB46Q4DkYhkUFaeAs4=@vger.kernel.org
X-Gm-Message-State: AFuF++nPniTsPdTZoQYNQ3ZCQ5x6/oNqyNoDoxGFg2fdWTxH5q+FJwpV
	aWRnoiCE1jXPhOx6r+Aa9glmJt2ji6J4aQ+rNlRUot+NT5UITP6fGEyoC2CGW6eSbIsK59gXbFZ
	Deiarhw==
X-Received: from plso4.prod.google.com ([2002:a17:902:bcc4:b0:2d3:83f2:7e3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58a:b0:2d2:da8e:9017
 with SMTP id d9443c01a7336-2d74dc797cemr34204175ad.8.1787864522916; Thu, 27
 Aug 2026 14:02:02 -0700 (PDT)
Date: Thu, 27 Aug 2026 14:02:02 -0700
In-Reply-To: <CAO9r8zOK5D3UMk1MM2X01FJhCW4mXsLpR-66T9+T9aeR5fcQZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-14-seanjc@google.com>
 <CAO9r8zOOq05nWk6c1sCnPAimFTuZLxc3BDrZLro-fXPR6ZMmTw@mail.gmail.com>
 <apCd5RSDYH13g0qR@google.com> <CAO9r8zPF7yPWopSQD=YSLuAxDU5YAacEWwEMbt3s_s9a=niCoQ@mail.gmail.com>
 <apCitFa82WHmiebf@google.com> <CAO9r8zOK5D3UMk1MM2X01FJhCW4mXsLpR-66T9+T9aeR5fcQZA@mail.gmail.com>
Message-ID: <apClyjROxUd8ACEs@google.com>
Subject: Re: [PATCH v3 13/13] KVM: selftests: Add and use double-underscore
 versions of vmlaunch() and vmresume()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> On Thu, Aug 27, 2026 at 1:48=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > > On Thu, Aug 27, 2026 at 1:28=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > > Yeah.  Another idea would be:
> > > >
> > > >   void vmenter(bool do_vmlaunch)
> > > >   {
> > > >         if (do_vmlaunch)
> > > >                 vmlaunch();
> > > >         else
> > > >                 vmresume();
> > > >   }
> > > >
> > > > To yield:
> > > >
> > > >         vmenter(vector =3D=3D SS_VECTOR);
> > > >         vmenter(!i);
> > > >
> > > > Never mind, that's a terrible idea, the call sites are inscrutable.
> > >
> > > Yeah, but I do agree that vmlaunch() vs vmresume() handling in
> > > selftests is annoying (e.g. see run_l2() in [1]).
> > >
> > > If you wanna go scorched earth on the nested VMX infra, what if we
> > > track launch vs resume (e.g. set launch=3Dtrue in prepare_vmcs() and
> > > lauch=3Dfalse in vmlaunch()), then provide a single vmenter() API for
> > > tests (with no arguments)?
> >
> > For selftests, it would be much more difficult to do correctly, as comp=
ared to
> > KUT.  KUT has a "fixed" number of vCPUs, doesn't need to worry about pC=
PU:vCPU
> > bindings, and has a strong need for per-vCPU state for other reasons (b=
ecause
> > it's more like per-pCPU state than per-vCPU state).
> >
> > Selftests doesn't have per-vCPU state, so making the tracking thread-sa=
fe would
> > be challenging.  And I don't really want to add per-vCPU state because =
making
> > GS (or FS) off-limits is actually problematic when the goal is often to=
 do "bad"
> > things to vCPU state (I've debugged weird KUT failures due to GS gettin=
g clobbered
> > more than once).
>=20
> Isn't vmx_pages effectively per-vCPU state (for nested)?

Yeah, but you said "with no arguments", there are tests that use helpers, a=
nd
IMO passing in a vmx_pages pointer is uglier than implicitly tracking launc=
hed
state.=20
