Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE0388E40
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864731; cv=none; b=dm1RyBN9ixTXDv4+TxLNmU1gJuENEgluah/YAkZEGvD3LSwm5+y4L19ryaCy0TM9qarwzbp7AZOOyDCZly/AEI65rSpS82eNThfbESr+J4jjk+cd+FfBwqkcmEX6i1oOYuqxjxV8BUeV7d8xy4G4Ysj2IuOvX6vm4fX6KQ58cxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864731; c=relaxed/simple;
	bh=G2Y5rmOgrcJW1cYHfLRhmBcItkWKTWHzdt4zZ7DPXFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsvSOwjlHXv9Is8SZdhDiu4bTUqqEX+edz/aU2zmoVzQJ0BrobiPaB7CpLXHUAoIs85i2SDxzgtPc4K+bHdVikAze7BLGvCBP59TlDGc1+mauw0kS+nT7/8qV11qYda4X0Cdxm9/SwckndCRRWAmwU3BSkyzzzWm2ZcJLROGSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWEwvAYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWEwvAYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FCB1F00ACA
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864729;
	bh=cpC0zyFRw5TvxsK0TeNhl+fOmLRq9beFCwpmebsEwOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QWEwvAYbv058jZpdyY9ydndiKF4wo080Ybihk0bMaYjAnSSDt4/7ck5ap9J74c97q
	 3ldGkSOWX7H+xhAAcIG/iPNQQDOsYkXAIbl1kH+LGIYO4iBSFcygVQJbGPb0tprSss
	 P3HxvcIJP10u7wSrT9GqIZdLC9316IfoptaQmUZTw2nNDdM5wdYOB57hgpm1l0NPbp
	 Qs1LqURsiGlxaDWGmtTYFVwfcWa/gvXekMBAB8Nme1beTy1Gu+6C6l5b7jT+cdS0eZ
	 HQtWg9II3VkvcCOXBm3pMLIUo+FgkXJpkjewZNYlY/1YVrEKvitmArH+QLeQyCBX2i
	 PNWuRMBZ+dCBg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1712a04ddaso19581066b.2
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 14:05:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqop4a58Q3bL9TNRE9ffRdPczuiOfTH1FYdd2GOmwuytcf1mzEbFYBeK5e5c10Ig2pTb1k=@vger.kernel.org
X-Gm-Message-State: AFuF++kqch9wEa7TCGfoogI1Y1YzKSCPIrxOjLQ3gqn5cMR32RWslei3
	QH50rpS2WQ1DO1aqRpse4+znHP4rNNu5bMCX1TxK+WySMqODAl6GVUEbE42s8ql4O0e5nno19H2
	zgTyytg9wco72VFPzVEIGA8epbE72LMA=
X-Received: by 2002:a17:907:1c03:b0:c24:6505:8f66 with SMTP id
 a640c23a62f3a-c2557166b75mr104597366b.13.1787864728647; Thu, 27 Aug 2026
 14:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-14-seanjc@google.com>
 <CAO9r8zOOq05nWk6c1sCnPAimFTuZLxc3BDrZLro-fXPR6ZMmTw@mail.gmail.com>
 <apCd5RSDYH13g0qR@google.com> <CAO9r8zPF7yPWopSQD=YSLuAxDU5YAacEWwEMbt3s_s9a=niCoQ@mail.gmail.com>
 <apCitFa82WHmiebf@google.com> <CAO9r8zOK5D3UMk1MM2X01FJhCW4mXsLpR-66T9+T9aeR5fcQZA@mail.gmail.com>
 <apClyjROxUd8ACEs@google.com>
In-Reply-To: <apClyjROxUd8ACEs@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 14:05:16 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPkh=CT6EjuJOLPQrmPuO2WZ3A_OHdDEGG8zUY=sFOAuA@mail.gmail.com>
X-Gm-Features: AcwNN1XV_ZR_uEy39clrVjEEi29Q3PO5FZhfQV4QGhsigLg4h9AJvJ8va8cAa_A
Message-ID: <CAO9r8zPkh=CT6EjuJOLPQrmPuO2WZ3A_OHdDEGG8zUY=sFOAuA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] KVM: selftests: Add and use double-underscore
 versions of vmlaunch() and vmresume()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 2:02=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Thu, Aug 27, 2026 at 1:48=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > > > On Thu, Aug 27, 2026 at 1:28=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > > Yeah.  Another idea would be:
> > > > >
> > > > >   void vmenter(bool do_vmlaunch)
> > > > >   {
> > > > >         if (do_vmlaunch)
> > > > >                 vmlaunch();
> > > > >         else
> > > > >                 vmresume();
> > > > >   }
> > > > >
> > > > > To yield:
> > > > >
> > > > >         vmenter(vector =3D=3D SS_VECTOR);
> > > > >         vmenter(!i);
> > > > >
> > > > > Never mind, that's a terrible idea, the call sites are inscrutabl=
e.
> > > >
> > > > Yeah, but I do agree that vmlaunch() vs vmresume() handling in
> > > > selftests is annoying (e.g. see run_l2() in [1]).
> > > >
> > > > If you wanna go scorched earth on the nested VMX infra, what if we
> > > > track launch vs resume (e.g. set launch=3Dtrue in prepare_vmcs() an=
d
> > > > lauch=3Dfalse in vmlaunch()), then provide a single vmenter() API f=
or
> > > > tests (with no arguments)?
> > >
> > > For selftests, it would be much more difficult to do correctly, as co=
mpared to
> > > KUT.  KUT has a "fixed" number of vCPUs, doesn't need to worry about =
pCPU:vCPU
> > > bindings, and has a strong need for per-vCPU state for other reasons =
(because
> > > it's more like per-pCPU state than per-vCPU state).
> > >
> > > Selftests doesn't have per-vCPU state, so making the tracking thread-=
safe would
> > > be challenging.  And I don't really want to add per-vCPU state becaus=
e making
> > > GS (or FS) off-limits is actually problematic when the goal is often =
to do "bad"
> > > things to vCPU state (I've debugged weird KUT failures due to GS gett=
ing clobbered
> > > more than once).
> >
> > Isn't vmx_pages effectively per-vCPU state (for nested)?
>
> Yeah, but you said "with no arguments", there are tests that use helpers,=
 and
> IMO passing in a vmx_pages pointer is uglier than implicitly tracking lau=
nched
> state.

That's fair.
