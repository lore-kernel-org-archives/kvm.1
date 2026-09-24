Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16917BCA
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209097; cv=none; b=CnZ6UZc0EnSf2fmZb7vtbwdWymtYYS4BICzIUmgtoDlBbJ/sl2qACH96kNizcepXzYl7JDj9ml5n8wtMBsC+M5ktY1rBADdJmhh6xe8pCtzQVx+9ARHsnVYp7x1d0fI/59Bg+cwfCfcf4UHRhqrj2uGkw8rfyxXEDM4CGaDvLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209097; c=relaxed/simple;
	bh=CrdrZTtS33U3nq622SJasROYdSHQslHQuMcznij5CnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VW2VIgVSLkEJHTF4986qT2DOqUEflmHTXQA7Pk8kggk5IioGYYQSm9dIvu3HfRd7VzUA8Q1xXmFYSphFG33Tc+LUsJVbEi5lDCQ8O7xzsXNfcLY09n58uHlP3dQeR5dYrI8Z3Gq/XsJJ9OpW3lAfcIA+slsyVSYtY/PwkvrLgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tcXfBavV; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcXfBavV"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so2169066a91.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790209095; x=1790813895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G0J8/Y0MliyfTzJdlfGzJOcZtn/lJ3hrXZ867NJt9ig=;
        b=tcXfBavVCF0THf8Oe0/MwZ/bP69PvsDIYWttug8wJwOG1EeixhuTU8IlCCMHECnGu2
         SntAE/4R5ljIEev9HFem6xg2/AhvVL4NZF68Sbv/aopJoWb4RHz0nJaQ8Hr8/xu9vHZD
         xfxbpBvd7/QeDjwVo3gTM2ejYu3P9XHZUi0WmhvLsKZTZCxSJh6xfgIF8kwqi1Y9BAC7
         YI57Vy+FVSRYHWaW00EncT0OQF6ZxKhcXfHMmcFNS02u5xseIgyLc9L+xqStVDGma+y/
         P3bvdufGbkMP2rm20IlfNNPr/QqIcdYoFJoHD3iH1NwB5S8EuWqFUxMjE5zy11vYqEKe
         8hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209095; x=1790813895;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0J8/Y0MliyfTzJdlfGzJOcZtn/lJ3hrXZ867NJt9ig=;
        b=KR6TMrCvVpiPmvIwzvkSjH3o952XWFnb/MxNSm2M1VzQgxCtHcsN8tZqFbd6hmEWQl
         afeKsEvq+in60VQ76g8Il3EFBLmeVWt2rNbKT2gtZYKbVPrdn52GFa5nTsgHvMHt1gku
         QiWu7Ihe+WAN85PKXt14hXTA+s10meqtSqUkuU1lVEPSgLRt5Iw07wSyB09uuL8MZ0hV
         jIv6VzujlgD/Q7XnV3Db8LXNjBk50fSyxJU25jA2wuvO6bsuXXL6eIu9FQgD7vYMZnpT
         Use8XeMqi/suVKTYS6Kgk2aUE6PKX8rr/4I9CZ8rJ4U/BD81L0+JIyKbOxK0X8bLmn1k
         3wpw==
X-Forwarded-Encrypted: i=1; AKwUvBx15iI7fJ/8ox5CVnCHPA7KKm5VYLDlg9aQOjpoT+5iyeW7tWsfUWt5naRxxw5zdwOb6I8=@vger.kernel.org
X-Gm-Message-State: AFuF++kHN5gpBxMsFx6fKfBKrwoqWwD/1ZnjiC+xo1uN2AaAneDMOH3Y
	FPFHBySYHqA92U8uVuP9wjJFyIz09SiDjIyO/ruXd1ifT1zJ8JOkPKhMmDk7MUSLYPab8++NIjQ
	e6aLTsQ==
X-Received: from pjbkj5.prod.google.com ([2002:a17:90a:ed45:b0:3a0:8329:b593])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e53:b0:39e:6a82:afd0
 with SMTP id 98e67ed59e1d1-3a098fe71efmr652389a91.34.1790209095204; Wed, 23
 Sep 2026 17:18:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:18:14 -0700
In-Reply-To: <CAGtprH8syQUQf9PjPe8o6rBFSg+01k=Hb4cvvn3TqED3uWb+yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com> <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com> <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com> <arG3KvaVqWCDAyM9@intel.com>
 <12541025-6579-4baf-911d-dcf1453b3e27@intel.com> <CAGtprH8t2OAh59XeWGtBLUX4JXaJm_NDpPE1ZJeGTjppKWrSLA@mail.gmail.com>
 <CAGtprH8syQUQf9PjPe8o6rBFSg+01k=Hb4cvvn3TqED3uWb+yQ@mail.gmail.com>
Message-ID: <arRsRkn1V8A3xUE5@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Peter Fang <peter.fang@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026, Vishal Annapurve wrote:
> On Tue, Sep 22, 2026 at 9:09=E2=80=AFPM Vishal Annapurve <vannapurve@goog=
le.com> wrote:
> >
> > On Mon, Sep 21, 2026 at 4:06=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> > >
> > > On 9/21/26 16:00, Peter Fang wrote:
> > > >> is how to hide the fact that someone in the future might think fol=
lowing AMD's
> > > >> lead and putting a precious resource into a tiny microprosser on a=
 slow bus is a
> > > >> fantastic idea.
> > > > As shocking as it sounds, there are actually cloud providers out th=
ere
> > > > that are wanting this, or at the very least wanting to see how it g=
oes
> > > > in real deployment. I think memory side channel attacks are a real
> > > > concern for some of them. But yeah this is not great from a perform=
ance
> > > > perspective.
> > >
> > > I'll believe it when I see it (on this mailing list).
> > >
> > > If folks want complexity and low performance in the kernel for
> > > side-channel defense, then I'm your guy. I've made half a career out =
of
> > > it. All that I ask is that they come and ask for it in the open. Here=
,
> > > please.
> >
> > Google is tracking use cases for deploying S3M-based attestation for
> > both TDX guest workloads and host workloads.
> >
>=20
> To clarify this statement further and address the discussion from the
> PUCK meeting: Google is tracking use cases for deploying S3M based
> signing of attestation quotes (or S3M-based quoting as referred to in
> this thread) for TDX guest workloads.

Good timing, I was just chatting with Erdem about this.  The TL;DR of "why"=
 is
that anything that's done on-CPU is more vulnerable to side channel attacks=
, so
hyper-paranoid use cases that *also* know the tradeoffs involved may want t=
o
use much slower, but more secure (in theory) S3M signing.

From an upstream perspective, I think we don't care?  Or rather, we *should=
n't*
have to care beyond letting the admin flip a TDX Module switch.  I'm a-ok l=
etting
end users opt-in to ultra-paranoid mode, with a pile of disclaimers around =
the
shortcomings and tradeoffs involved.  I.e. I don't really care how the quot=
e is
generated, I just don't want to carry any kernel/KVM code to make it less p=
ainful
(and it should absolutely be opt-in).
