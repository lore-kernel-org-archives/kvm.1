Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDEA415B7E
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168484; cv=none; b=H4A7x0PRooJItcHQA5QxYaqYxDaHZJM+K20aMrsXeQdHxIoDOa76q39ZL0k9DAUaCyEWEyeDU/TVJTISaK4O55KsKmbRI8d9TBKySAbTvg1PRoXwuoZjBTZPE2beZotoKdjCBUP0gUXf5FBzAGoot+2FcwPf8a91ka0amRcCHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168484; c=relaxed/simple;
	bh=Mq5+V5+ZUmpq7Hw/9XupS65+jzwahk6GhQuhDlgNwE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fiUBh1JAEV0gyn4euvwCWgB0OXFmXe8Vk93QLKLdzB9exx6OhhmMQ/xRiyfKNxAn0i71KTHIA+J1wK9fbZqAP+oOSCaSPZ25L2r9fKCBLwfZRDO5bn6fRMhD+Hygi5Q7Ouu4kRuQsdUlfpl7o1ghATgSLbH6L/UKdoc4MxhY7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQi1ObHe; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQi1ObHe"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484b9fb055so3036144b3a.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787168482; x=1787773282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nHPfz+9xnErJIyGrKM7A488aJznVuuAajDljXkIrQvo=;
        b=BQi1ObHeduHmlNJJeV5eKi5U+fcAHE4FX0DUqFp08nVnM6vLHQhad7QWQnP0D35ubD
         5oahFYzTAjYh2QvucAsIP+D01/deZx+ngJNjcfi4B90bBnN/eUCLPTuK5vk+nYhR2gvH
         qpB82RLFG0LieST0k7c3FZL7g9BfA+4jV+YY12kUm9t35sEu7JBrFWAyRct/AxvKAUrg
         9vbcBiw/9yrbpW+Ow1sCmd4uM6D2irEN+ob3A67RgscFhkjMZWxVQrVY9Y7HNhY9VCAd
         OYE4Un2h6Hu0YABfHFjgYRer8joUkijeUEGRF2MekDK2hnaFlgE5QG+zp+XmukGzMUy6
         sj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787168482; x=1787773282;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHPfz+9xnErJIyGrKM7A488aJznVuuAajDljXkIrQvo=;
        b=CBpu53030Lp+5/pWLcYN1Le5CzZRJeqJ+DkSTsygXgUAjKuV87iiUXqQdRm53TXhjQ
         3rJnoTb5tFX7hN+/VG+SJbohBGNgXYv0KlLbuPH3aUzifcu01o14pxbAU0nx/4iFutOh
         qV4XqqdHf2udkuvm4YdXncWBulUrcFKtmRYVvOO0aQraagwnzDAtfp7Eo9nw0vXRuUJq
         BBwCaB5FnQ9HSBHa1EeyDR996sNRAmwoEnwQQ2pszvnLRce9efHwJViBMvouPjiVuL9r
         oXEkD1y0fI1iEcgRWBzbMibV95bUsgwHqHi/bjOscDLCugegjCXLfm895Cf274K0Qmwf
         inCw==
X-Forwarded-Encrypted: i=1; AHgh+RpkbmYG/jUCu0C+n5uj0OJNAOh65VugNpoH7WdXq4D8wPBWJ5LcOlWZJ1UouGDlCmtUHbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnHBIEAuQkIY/no6WoI8pYYcyHjKFWPVfPRpQwwO7iOppAIau
	bjcw/p/j7+T3CbWHPZlpbcpKjtNQQnEqrgHx0umbPq5M6sadf/P++eq0ORcMMYm4ZpcW+3boru3
	5PKKBKA==
X-Received: from pgwa2.prod.google.com ([2002:a65:6542:0:b0:c8f:f76a:4b22])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4309:b0:847:8b11:5966
 with SMTP id d2e1a72fcca58-851d38313f0mr12376916b3a.1.1787168481981; Wed, 19
 Aug 2026 12:41:21 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:41:21 -0700
In-Reply-To: <e5979a0a4d7c24d88f57981aba0fda6d8a5e2f29.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814224509.2342760-1-seanjc@google.com> <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
 <aoT_6cnARCAYTrYG@google.com> <bd8f77eb6605f771fafbcef55a47211ecbb70e19.camel@intel.com>
 <aoXSKH4QLTA5DTXe@google.com> <4f8428e0784224c55a2026eb32d046a2051193ea.camel@intel.com>
 <aoX5sbITQYeB7USY@google.com> <e5979a0a4d7c24d88f57981aba0fda6d8a5e2f29.camel@intel.com>
Message-ID: <aoYG4XA6pXAXiHlP@google.com>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-08-19 at 11:45 -0700, Sean Christopherson wrote:
> > Hmm, for defense in depth, I want to explicitly check mirror_root_level=
,
> > because returning '0' would likely have dire consequences.=C2=A0 How ab=
out this?
>=20
> :) Sure.
>=20
> Yan and I were discussing what might be a new level of defense on MMU che=
cking.
> We were basically trying to work out your thinking on some of the defensi=
ve
> patches lately. It seems there has also been a new level of activity on t=
he bugs
> front so we want to adapt to any learnings you had. I actually planned to=
 bring
> it up in PUCK, but...
>=20
> Can you share any thoughts? Should we be more paranoid in general, or sam=
e as
> always? Or more specifically paranoid where issues hit?

The big learning I've had is that simply detecting bugs doesn't help protec=
t the
host unless KVM also takes evasive action when the bug is detected.  E.g. a=
 WARN
will (hopefully) be super helpful in root causing what went wrong, but it d=
oesn't
do anything to mitigate the bug in real time.

A theme common to several (not all, but several) of the recent guest-exploi=
table
vulnerabilities is that KVM *did* have relevant sanity checks, but KVM didn=
't
actually do anything meaningful when a check failed and/or an assumption di=
dn't
hold true.  It's not always possible/desirable to take evasive action (see =
below),
but in most cases it is.

Other than that, I don't think there's anything "new" per se, just a bit mo=
re of
a sense of urgency.  E.g. avoid BUG() and BUG_ON() unless there's a *very* =
high
probability the alternative is worse (this is why I said above that doing m=
ore
than WARNing may not be desirable).  If you fix a bug that could be applica=
ble to
other code, look for ways to (practically) eliminate the potential source o=
f bugs
(much of the guard() stuff falls into this category; the cleanup behavior m=
akes
it a lot hard to end up with deadlock due to forgetting an unlock in a rare=
 path).
And so on and so forth.

As for this exact sanity check, the reason why I think it's worth keeping i=
s that
we've already messed it up once, the code pretty much only runs once per VM=
 boot,
and if KVM configures the wrong level, the *best* case scenario is probably=
 that
the host panics.  I.e. my past statements along the lines of "at some point=
 we have
to not screw up" still hold true, but as with many kernel rules and guidlin=
es, it
needs to be applied with a healthy dose of critical thinking.
