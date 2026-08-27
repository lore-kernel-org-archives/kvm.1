Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE83F105D
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863735; cv=none; b=aIRUTRKChyJYxSdt1Tg6C719Z1YgmVcItWVN+FAr7M/RO5pYH6rZ2WrVDR3JxlQ8lNASYPHzbFHdTziaiRIEsObhWs8L4XkzkuD8knwIWBaBAbC1dfH4WXcuOQUQqJamz8km/NkEvzGMs/dLDX4Yjfe1k7Ox1ifG90oPjvnj+Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863735; c=relaxed/simple;
	bh=hfC0E+fisiK12OjyqaqIP5TL+KsVW/EGw++lgtKkPj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJfu+Nihh09Y6ChmBXWDn6f5cnzO+g/gMbLC3f5oXYDHwGFYkb8bVVtDINl1eKXMBeIXt7+espMmoccmOFFi3dvHs7IbiUmd/c8KGs2yn35eYXyUSJlY54iBVNQHvr/xYywPQEAi3TV7zKiyxjh/Si7OLuGYDliP7RcYDS67X44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQpIlfnn; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQpIlfnn"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so212472a12.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787863733; x=1788468533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IrKNshj7vYGAxfeUfZziPp20N0c92G+vt0LvTTRA2KI=;
        b=cQpIlfnnqp/Ve5BDACIjyes3WuYqWWVpt+xltTWYP6rmScRUTj4IzvDzyou9YODhke
         kFRpBMC+TKe8YwGujzbRA8qzbXxFMJJsJ4KsE/v8gk6QRoQ+CysRl3zke8ZVPZstL8L0
         dpUA+KsId7IbX1Fb0tnQF6SHyoAwKC1DlYB5SwLSMTBA0dJMgRTz7+TAaHgg7X2VqAPs
         tdwv/B6ewQHSVeYsNO1JN7N1rkuRbAdRDMjJD191h2XHVjpHch+RePYqBb1yy1WIbV8f
         kH7lY6xEyTVODvkAG2+xE8hVUMMHqDwemYRB6SKK9NW+lTgGReGHJCWNLd3yyIkJzK+Y
         aa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787863733; x=1788468533;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IrKNshj7vYGAxfeUfZziPp20N0c92G+vt0LvTTRA2KI=;
        b=mrB3nK1gf9PddxiX2LpGS1Xx0JDoHmT1OJ3NYVAT+wVsUzR42f/fAFOTvHzPf2Tco3
         Vynxu7BkF0cB+eFQent8MC2RlE/4AM6J2+weaDxavuhZ9snBO9butEUTjnFEe8FmipaV
         Pegi0GXMT54j8TGkZ6iC68m33fcERQolMverlkpsKD9rtFneOMtIj0qt7Yn+8m/UpNVy
         ZHo1aIqLrC00U0BCgxLh8QTOgtfv5ebwKtnnBwAslkzKfIuqA0iPGq1niiCFmBqINy5v
         +Z+e6jht7GDLwVuc8wlaAI6paNzjaR7aDYH515mo5VwBmRgnhiKOKVE3K+HczWSuAY8y
         60ag==
X-Forwarded-Encrypted: i=1; AHgh+Ro1xuGVjDrH8BLbegMTwFqhnwUl6efFOLW2Cy8SDF9D2rAbGZon4pXVmyaDb2IwIyH3Scs=@vger.kernel.org
X-Gm-Message-State: AFuF++lFNSI+PQocLjMl9RNx1iSgr46dniXW0hl3979G/rktHD+cEQFA
	DnwVN7banlHmlloC295/C0TfCw3aM2b62fyZU7aTK5mkVqBsydtAt2nIh3o5F3gkwq0tJhsBQYJ
	TyRe7Pg==
X-Received: from plgd1.prod.google.com ([2002:a17:902:cec1:b0:2d6:fa19:b6a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffcf:b0:2d7:1b20:e98f
 with SMTP id d9443c01a7336-2d725df6dbcmr127091995ad.2.1787863732990; Thu, 27
 Aug 2026 13:48:52 -0700 (PDT)
Date: Thu, 27 Aug 2026 13:48:52 -0700
In-Reply-To: <CAO9r8zPF7yPWopSQD=YSLuAxDU5YAacEWwEMbt3s_s9a=niCoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-14-seanjc@google.com>
 <CAO9r8zOOq05nWk6c1sCnPAimFTuZLxc3BDrZLro-fXPR6ZMmTw@mail.gmail.com>
 <apCd5RSDYH13g0qR@google.com> <CAO9r8zPF7yPWopSQD=YSLuAxDU5YAacEWwEMbt3s_s9a=niCoQ@mail.gmail.com>
Message-ID: <apCitFa82WHmiebf@google.com>
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
> On Thu, Aug 27, 2026 at 1:28=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > Yeah.  Another idea would be:
> >
> >   void vmenter(bool do_vmlaunch)
> >   {
> >         if (do_vmlaunch)
> >                 vmlaunch();
> >         else
> >                 vmresume();
> >   }
> >
> > To yield:
> >
> >         vmenter(vector =3D=3D SS_VECTOR);
> >         vmenter(!i);
> >
> > Never mind, that's a terrible idea, the call sites are inscrutable.
>=20
> Yeah, but I do agree that vmlaunch() vs vmresume() handling in
> selftests is annoying (e.g. see run_l2() in [1]).
>=20
> If you wanna go scorched earth on the nested VMX infra, what if we
> track launch vs resume (e.g. set launch=3Dtrue in prepare_vmcs() and
> lauch=3Dfalse in vmlaunch()), then provide a single vmenter() API for
> tests (with no arguments)?

For selftests, it would be much more difficult to do correctly, as compared=
 to
KUT.  KUT has a "fixed" number of vCPUs, doesn't need to worry about pCPU:v=
CPU
bindings, and has a strong need for per-vCPU state for other reasons (becau=
se
it's more like per-pCPU state than per-vCPU state).

Selftests doesn't have per-vCPU state, so making the tracking thread-safe w=
ould
be challenging.  And I don't really want to add per-vCPU state because maki=
ng
GS (or FS) off-limits is actually problematic when the goal is often to do =
"bad"
things to vCPU state (I've debugged weird KUT failures due to GS getting cl=
obbered
more than once).
=20
> [1]https://lore.kernel.org/kvm/20260728003557.1136583-29-yosry@kernel.org
