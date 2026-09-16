Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FA42123E
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586882; cv=none; b=TeQIq5uOYMZYxE/RelyCVou5URq1Rf+74VGEgOCJRR1qGXD3pVfQD9B42mVfxsgVZgdXeFE7IarAzME+i8L5rWaRSMMJlrXrVBS1+XqocFghYrsYGflQ6IuqgyBjJ7xUmRsXHDJ3YMxTNn47OUlnswyBkwwEmqNcXFFPQu6WQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586882; c=relaxed/simple;
	bh=q2Lu/gBIIz5tR888gYDfXNn+E1ZBLVUP8HyYrOK6nwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nJUv0ppHflN8P406lj2wNuCKQ8FO71vn5ESW98KVwnMRYJoVG+Tm1PhU4pImj1+C8Rp+jJExZTNOXM9xUiRNbYyWkv9a4VdmnRYeQvMswNXKfOtkcmeJWINwIYkVnsaiZoLYd97bYC9FHo5RAp9KO/3Rhx9xPrekjy5WZfL+B7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T70v9h56; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T70v9h56"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a0dc7f26cso50794b3a.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789586856; x=1790191656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kdb/dcqaU3T+x2hKjF2QXeOgIWRPb7qej2gXSeg/S/w=;
        b=T70v9h56FENC67tCp+lt1ECLI7STXaw+TndKCpnPl36VTgJVTuVevAKJpC3qcMaEgn
         qSb7YiOKzokxSgeQ+OgUhWu6yg6XwAzGkz6oWayxSbFbhLnYfOPCQZPDSZ8FIbrVYYKd
         bme2lmORERyPsNjN2M03fqUaaTTx2QP/+mvh9VRgXrF8c1XrqgUgTK+XlN2Yht8HdwFC
         0GtpU55A//NFvmmMx441D1cworscH9WXnSTR/8YoRwhcJBuhZhsPA1UwMbrcJy/V4xqA
         3rQPBKi+cgHnLMGQQO6GoNYlgcgUtBalmDWLx6N8wTRBd04VZQT1tu5npSoGc2YZ4ZGi
         zUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586856; x=1790191656;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdb/dcqaU3T+x2hKjF2QXeOgIWRPb7qej2gXSeg/S/w=;
        b=OlT5gt4osa/3g1hDwBBB1KvoqfV5v4EPgZXs1mO9u6dJr0RsjLOYOzIsWTpwOjXBvI
         noHNx48piKIa5mdYJA5msg1iLNXgvC7CuJNYrM0F61ywkepurVAjjhXW8A+57On7wWu8
         oLekDQ/72cYNLijq8Q+3x8lLpdpxJAg/M7gx7W91dAaiBsXzLti1/ixlmFdJEtbdNxgc
         XP/LW+zQ/FuIJDS9FBswlUmoB/MZWnJcu4jQeEpYPea4P4bTzEhx8M4vrZPZroF9oscW
         d1tCifAsfnZ5+xUr/cRthfuX0JZ5aeh4ZFHXN5G2mCjQ3nFLxVgh5nEPGNj7369PqqmE
         FXbw==
X-Forwarded-Encrypted: i=1; AKwUvBw4aLHsa7Xb7lISuq6gtFJxlUaYSHEPyPvDeRbWDjv2G6prjbz02j/4f/e0DyxZiRLdluY=@vger.kernel.org
X-Gm-Message-State: AFuF++kGR0NhP/uweeO0whKE+cfwZV5EPDpduNkPf10F1Nqt8JApkQ4u
	pY41X+KXbRLFBteDlakWZCXVBa8oPooZDmPqDoagIL8osDROHID8DY/4lDfp95AjrtB5WpNRfG/
	ursL+CQ==
X-Received: from pfbmc28.prod.google.com ([2002:a05:6a00:769c:b0:847:9be8:84d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4652:b0:86f:394c:5c68
 with SMTP id d2e1a72fcca58-87238d87b0emr7666454b3a.13.1789586855429; Wed, 16
 Sep 2026 12:27:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:27:34 -0700
In-Reply-To: <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
 <aqrZUZtSZ-YItclT@google.com> <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
Message-ID: <aqrtprn5YaMijVdZ@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-09-16 at 11:00 -0700, Sean Christopherson wrote:
> > On Wed, Sep 16, 2026, Rick P Edgecombe wrote:
> > > This DICE quote generation can take a long time. Exactly how long is =
not
> > > known, but it is expected to vary and often exceed the time a SEAMCAL=
L can
> > > be executing in the TDX module by a considerable amount.
> >=20
> > What's the ballpark?=C2=A0 Are we talking tens of nanoseconds, tens of
> > microseconds, tens of milliseconds?
>=20
> I asked about this too. I have not seen any measurement yet for the real
> implementation. AFAIU the PQC stuff is not settled enough at the industry=
 level
> to be sure in the long run. I have been under the impression of at least =
a ms or
> 2 for PQC signature based on general PQC signature benchmarks I've seen. =
That is
> only my guess though.
>=20
> If you are thinking the implementation could punt on how to handle the gu=
est
> interrupts for now, that seems reasonable. I'd think exiting to handle th=
e host
> interrupts could not be skipped though.

I'm just trying to understand the scope of the problem we're trying to solv=
e.
E.g. I don't think any design will save us if generating a quote requires a=
 CPU
to be spinning for multiple milliseconds.

> > Does the TDX Module *need* to provide a save slot?=C2=A0 What would pre=
vent TDX
> > from requiring the guest to provide storage for whatever in-flight data=
 is
> > needed? That way there it doesn't matter if the guest never resumes the=
 call,
> > it can only hurt itself.
>=20
> I was thinking about this too, but thought it sounded a bit like the NAKe=
d SNP
> secure AVIC pattern. At least the TDX module would need to handle getting=
 asked
> to zap the guest page that was given to be a saved state slot.

But doesn't the TDX Module already need to do this?  It's writing guest mem=
ory,
no?  So it needs to prevent the page from being freed while it's handling t=
he
quote.  Just put the onus on the guest to provide the same GPA when restart=
ing
the TDG.

If the host yanks a page away from the guest, the guest is hosed no matter =
what.
If the guest frees an in-use page, e.g. converts it to SHARED, then that's =
100%
a guest bug.

> The host would probably need to be involved in unmapping the page from th=
e S-EPT
> while in use too, since it would need a TLB flush on each vCPU. Otherwise=
 the
> guest could see the intermediate memory of the operation.

Do we care?  I was and am assuming "no".  Unless there is sensitive TDX-Mod=
ule
data that needs to be saved, it's again on the guest not to read half-baked=
 data.

> > What about the whole "TD-specific data in the quote" thing?=C2=A0 If ge=
tting a
> > quote (or report?) is punted to the host, I'd still like to keep it out=
 of
> > KVM.
>=20
> I checked another option for this: Write the nonce to the TDX module via =
some
> new TDG call, then just ask for a TD scoped quote which fills in everythi=
ng from
> what the TDX module already knows. TD details and nonce. Apparently it co=
uld
> work.
>=20
> Then nothing gets passed out of the guest except for request for a quote.=
  We'd
> have to break compatibility with the SGX based quotes though. Is it worth=
 it? Vs
> just utilizing the upstream KVM functionality unchanged?
