Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A742A160
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435365; cv=none; b=t5LPXgIdFX1ajbyL1xcMX3HN+LkiOJFM3sgb2FG7NIwniQOHNm14fetgOHkcaXxFqVBbWY80PdkdqbwTmhfSLj4GGjygITfY+EfN1ZXUt3wk08j+JrQwmjkhyyeBhTJt4SawLneD7fghlnOZN0G9YeKm7Wlm1tWmCC5XUIqEMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435365; c=relaxed/simple;
	bh=MKOY1slFB5lal/8NrKTq4WKcgNGJ+l4j8dOiZH3HobE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MvrEl1l79Ti9bgamOs0nvuqfdGb+ODaFTq/d6OSI+n4UQtbI4shorb9R4OjvHG4IH7TzelrQtx/MaxXAyd1vWxednmIF9eyfFc6B26vtFiyDOiS/7oz1+lJCkBrOgleKQea+O7SBqaHcBCDAylCwUTtKDPgFfFPAFWZiNOpZjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XlJQLJ8m; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlJQLJ8m"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847a5f03ff9so6501655b3a.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783435363; x=1784040163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKOY1slFB5lal/8NrKTq4WKcgNGJ+l4j8dOiZH3HobE=;
        b=XlJQLJ8mgvvSaJUYurCJbwmF4yezVYqdaGG07aYSS+CdPYPkE64erm+GAn8NaA+eOF
         DgcRbN3KCvkrzVMCwYHz+zg+SPdIOYIm2e1ZvZgp1N51Nn5ej7ebymetaA0cwFnQggBV
         G6iFO2zoIvnWMadEdH8KMxPaFhv2jf0XzzF41sFDyM1v4OTZS7bfB2JVc6XDELvYCSRJ
         TAFROqjF6yA2y8L0XGVRiAlAwYQ58zovglDtlrD8wnEaGcZB0JuSHFQVkrojghgs1GfB
         gLD1D1+6DtjjJzHhz2uMCMW9E2bxM7/C285X7YLNWZ1uYprrB5tPmRBrv14YuArRfyvg
         BYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435363; x=1784040163;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MKOY1slFB5lal/8NrKTq4WKcgNGJ+l4j8dOiZH3HobE=;
        b=o0RKy1BTQk954mDPfRXGo2eoWDfGWjrdX1y9QHEYeuYuAHq9tUjrhYTOAcxJ1wOczX
         QEmDIAAcl5bqM4oHbPlYM8HZcj+uVPANXls1MIiOzmJYDQ1c/izSpKMgAwXvX/a3RxPg
         jZFyDpqa/0G4NfSEvjde3+x3y0kBTXq0xtVl66AaBtLdD5SbMkSFbMDPGVVTygnIEaU3
         gagyaDr0rgMdQWoGdaiKA2DkKRSysrd+eLoKB++MD0fRHyx8DzSbBy0qzivg96M4xrK8
         dDRzTYUsJfytqEOrRyxue3v1/F7OTzMI7my7vBQfGx9uxPxzof7YaOayFYE1eFAyxJi6
         dNnA==
X-Forwarded-Encrypted: i=1; AHgh+RqFIJjQp4hWGCAr73ZDj8caysxyhIgckyKojr4k2SvvJfSbkpMYkalEFEN5wSBFyaCNitc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jySteKS8z5xtft9LSv0ft/WYWV86C42KBDPR1IuUwUFGmeYy
	iiQEfMttuz2SZJy9AKIlM7GJwOf71Ut8AVioSBYMIesSGaeV7pszSINIfFCKWBO7ibIQc8va7NY
	LJ8K/yQ==
X-Received: from pfkm11.prod.google.com ([2002:a05:6a00:80b:b0:848:2a35:eb83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4612:b0:845:e34d:f226
 with SMTP id d2e1a72fcca58-84826c23f24mr5146238b3a.16.1783435362805; Tue, 07
 Jul 2026 07:42:42 -0700 (PDT)
Date: Tue, 7 Jul 2026 07:42:42 -0700
In-Reply-To: <CALMp9eQXGYevLQJnEV+Kx6hvp84vPQ=2U8AfZHiZrZj=CVM2hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com> <CALMp9eQXGYevLQJnEV+Kx6hvp84vPQ=2U8AfZHiZrZj=CVM2hQ@mail.gmail.com>
Message-ID: <ak0QYnYvchKTnwxS@google.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026, Jim Mattson wrote:
> On Mon, Jul 6, 2026 at 8:25=E2=80=AFPM Jim Mattson <jmattson@google.com> =
wrote:
> >
> > On Mon, Jul 6, 2026 at 8:21=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Tue, Jul 07, 2026, Tina Zhang wrote:
> > > >
> > > >
> > > > On 7/7/2026 9:32 AM, Jim Mattson wrote:
> > > > > On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@open=
-hieco.net> wrote:
> > > > >
> > > > > > I will take another look for the next version and try to handle=
 the
> > > > > > remaining pieces properly, while also making sure we don't expo=
se stale
> > > > > > or incorrectly synthesized decode-assist state for emulated exi=
ts.
> > > > >
> > > > > Naples erratum 1096 seems to imply that the instruction bytes sto=
red
> > > > > in the VMCB are not necessarily the same instruction bytes that w=
ere
> > > > > fetched and decoded to lead to the #PF/#NPF. Hence, in the case o=
f
> > > > > emulation, it might be sufficient to read the instruction bytes q=
uite
> > > > > late in nested_svm_vmexit(). That would certainly simplify the
> > > > > plumbing.
> > >
> > > The plumbing doesn't seem all that complex though.
>=20
> What about the case of a userspace-injected #PF while running L2, when
> L1 intercepts #PF?

That can/will be handled by the fallback logic of reading the code stream o=
n-demand?
