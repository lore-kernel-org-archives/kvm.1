Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B253AD52E
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864212; cv=none; b=YxzaAnWM+tRSNOTZccn2n3Kt48VZ0yTR9Vrd7cvcHtnpp04D9FK90R/IPQSpmjdFXhLojA2BABH8VSgiKjA/kSqjEyeocVXNofABNFF2ab4XpY8tNcEYmQzV071QX9ErOSKRQA174tZX2uVOvfsc7DxgfKuKYy4QUvqCgpOWK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864212; c=relaxed/simple;
	bh=7yixmW/lYFaw6J9IIxo9w/V++ZvuZvPmLMynfg+E/W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4PHCXNXA5GqTRzltmKQH/KTh+2i+LX/E4oDz5aR8VCSVEjQ2mzmvavVNudSj76PxtidAzprMGFgKq4+CuIO4icHyzoHkcT/LGe4Glq4XqAsuSNnnIimn19sf1f3P0WTQfwvnKXWQTsqbHzeAi5mxkIYSSRGSu98VhDD66t/cwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvAU74ZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvAU74ZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D791F000E9
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864211;
	bh=VjYAWPiQ04nVMvEDvoWYbY4Zi757dubUtTrhEx+rKv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZvAU74ZHc8E1DZBZjJkqpNrlDujqQDWwxQiH26QNuTInqR0lAXLav4WK4K+XMAITC
	 J4hchCDLGgLlQAd/xiA/Ez7Wzc3psLyS10O5W1JBlZ16CifIBCv9R/LA9+2yVc0bco
	 I++Dd56aPvrum83TwlvOCYSGGIcS4EpnVI85w6lkX56XDkibU4RlZkiVAPtT4frfXg
	 CqmCc8gozT0zWNEF0pBz9ayNcPZbSfNP4okjmgbaLLcPBzDLMwAqHa1Aym/XiuX+Bn
	 GOb6hQ//P8ij82TbtAGdDFWJfqYRIuwOK+L3afWJVUR82nAaLgANV9bkKEdwBRE2ss
	 3QtrqS9NGoOuQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c20ce3c118aso53446866b.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:56:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RojqlDpCTUcHxXcPHaqxmbbENdIMX/MNRx7P+DuYINonYLM7QkuFCR7tD2oPfJ8cbz2SEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k7B2U2//gHn2EiwQkGszMOm4j8jThegjU4eEB6IyOp/hKTDSrn
	EbHzgfc9na07LoXVsLf8HHFsPJd2xWa/Q9u/szdlrCAsguNdtFZxyyQFJtemrkJxP14Ck455NQI
	46wuVc+NDD/GHQxoh9v6EvR5rCJ2aa7M=
X-Received: by 2002:a17:907:d15:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c2535eab8efmr718462766b.1.1787864209998; Thu, 27 Aug 2026
 13:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-14-seanjc@google.com>
 <CAO9r8zOOq05nWk6c1sCnPAimFTuZLxc3BDrZLro-fXPR6ZMmTw@mail.gmail.com>
 <apCd5RSDYH13g0qR@google.com> <CAO9r8zPF7yPWopSQD=YSLuAxDU5YAacEWwEMbt3s_s9a=niCoQ@mail.gmail.com>
 <apCitFa82WHmiebf@google.com>
In-Reply-To: <apCitFa82WHmiebf@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 13:56:38 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOK5D3UMk1MM2X01FJhCW4mXsLpR-66T9+T9aeR5fcQZA@mail.gmail.com>
X-Gm-Features: AcwNN1VEcaJXZNSJH-Jvpv5QfotBnhkVHaAPPNiZWZXjmPhHgjvDEik7T1khfW8
Message-ID: <CAO9r8zOK5D3UMk1MM2X01FJhCW4mXsLpR-66T9+T9aeR5fcQZA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] KVM: selftests: Add and use double-underscore
 versions of vmlaunch() and vmresume()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 1:48=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Thu, Aug 27, 2026 at 1:28=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > Yeah.  Another idea would be:
> > >
> > >   void vmenter(bool do_vmlaunch)
> > >   {
> > >         if (do_vmlaunch)
> > >                 vmlaunch();
> > >         else
> > >                 vmresume();
> > >   }
> > >
> > > To yield:
> > >
> > >         vmenter(vector =3D=3D SS_VECTOR);
> > >         vmenter(!i);
> > >
> > > Never mind, that's a terrible idea, the call sites are inscrutable.
> >
> > Yeah, but I do agree that vmlaunch() vs vmresume() handling in
> > selftests is annoying (e.g. see run_l2() in [1]).
> >
> > If you wanna go scorched earth on the nested VMX infra, what if we
> > track launch vs resume (e.g. set launch=3Dtrue in prepare_vmcs() and
> > lauch=3Dfalse in vmlaunch()), then provide a single vmenter() API for
> > tests (with no arguments)?
>
> For selftests, it would be much more difficult to do correctly, as compar=
ed to
> KUT.  KUT has a "fixed" number of vCPUs, doesn't need to worry about pCPU=
:vCPU
> bindings, and has a strong need for per-vCPU state for other reasons (bec=
ause
> it's more like per-pCPU state than per-vCPU state).
>
> Selftests doesn't have per-vCPU state, so making the tracking thread-safe=
 would
> be challenging.  And I don't really want to add per-vCPU state because ma=
king
> GS (or FS) off-limits is actually problematic when the goal is often to d=
o "bad"
> things to vCPU state (I've debugged weird KUT failures due to GS getting =
clobbered
> more than once).

Isn't vmx_pages effectively per-vCPU state (for nested)?

>
> > [1]https://lore.kernel.org/kvm/20260728003557.1136583-29-yosry@kernel.o=
rg
