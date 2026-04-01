Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BC47CC72
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062792; cv=none; b=mncRLz7GRlssIFoKTJXHkz8Uwc2Jn68pFe/r9GqMjRwBRVhB74xwBvtWNrXaCESpn2ewSd8W4yqju2AfUyf3+BZDYHZC+WVOf9K3g19QdRKMaqy4gOJucjA4+cpMopV8MiChcLBSXQ/29bsf57njenL4+K9ctS/p2ZXmPx2biIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062792; c=relaxed/simple;
	bh=rQeC2jRYQIvArJxb2oo5D74j1CAcVaiiI8pTVEihOas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NT4a9DwPU5eNvKgmaUJEl+he1rpcvpux1dNAM6BXBGdypBQyLVMRQKF43L1rBWFIIOMjMLsy6fog2wER0JV05ZuqYGrAGjyQZE1RxtJMdHsJHxVcPuo8MHX25AQvPwWetB1XcNFOWO5ytL2xkZW6oOgg81g0BgBGhFs4GZwoIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgq8nkmB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgq8nkmB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6906e35fso1094896b3a.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775062790; x=1775667590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQeC2jRYQIvArJxb2oo5D74j1CAcVaiiI8pTVEihOas=;
        b=fgq8nkmBaI2+WDRf7ih1fFNdy2n1VTF8DCWWlrKFRAwnH1o6fMLwUjRjXTFcHqAmtJ
         oaS7W9w9MSkDJGlp0ubWCStXpN1PSrrVYwCKTYyy2ijDg39clHL3pcgfnLwgA5FvXUjH
         cbP2mq5VSHkqfxxvLCOwdYhiKjQjIXH/NExuPycrNl5clDVXk7kZN9bfVgRjvTvG5Otf
         xc+raanv2PIrtZvOIJVloSjbQyMz//n6MM+2zHAXIxXopG5ANnBuvg4OhwHYyYgmT8E/
         J22I7ak+Si62HjBtQ/NtEBz6E+hktjmNy47WVIEvuaitlxe524xvVT5EIoltr6I0J2hR
         3DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775062790; x=1775667590;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rQeC2jRYQIvArJxb2oo5D74j1CAcVaiiI8pTVEihOas=;
        b=DpwFeaLHVv+VGuZnpJ5xy0BCo09fFV5GWZzjcSnYWpFL/+2f4EaX0lwPpapWJfQ50B
         K09FZ5pOcPsvq3fu/ghvNUq+fzAMU6ge1TFwoBrpkU7t4y9LGnJULCgCqeWBBnIZG74O
         CqlCY0SrmEHNRE2Zg3zbavqrwv68DGYHFl9aQkgWN1tEvVi6p8qoi39JaJ53WxsQHlCf
         ICFUYR4m8b3gIRT/57UmxcairSeBGkowiNMIvUB9SWaVhbCJ4/wgzdsxpSK7HUXw1/RT
         GMCdBH9BBu3qyJC8kjzuoai2FqXPMmp+oIRGtxuoYr4GdZ4Fy9DzqoPByZ8f4jFHrjhs
         l9RA==
X-Forwarded-Encrypted: i=1; AJvYcCUIbDh3rBvcCGrRnFru7eh6YqVVtI3GUq9E0IYDGbeGVA1yslZkd9lFavSf6iIAdWZO6ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjN4866ulilPV2FT608Nfdd/5J79c3HEBM7zrzRBTmDVFapS+K
	gFjRbpXHmKpc/wfCa4Fd9DMGjlnTOtj7aOZO9ly1SWLhCqO+7CjfcBwEQ029t3UPzSHYMjxathM
	XLebMTA==
X-Received: from pfbfc19.prod.google.com ([2002:a05:6a00:2e13:b0:82c:e227:ea2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cc1:b0:82c:6fdc:8eda
 with SMTP id d2e1a72fcca58-82cd66c6317mr7135977b3a.35.1775062789257; Wed, 01
 Apr 2026 09:59:49 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:59:47 -0700
In-Reply-To: <c1a05fb9c8966d94a581ae2faffb7cf588f6340b.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <5a73e445.aca5.19d48e268dd.Coremail.pcj3195161583@163.com> <c1a05fb9c8966d94a581ae2faffb7cf588f6340b.camel@intel.com>
Message-ID: <ac1PA0l6Re4NSnGv@google.com>
Subject: Re: TDX/non-ACT: failed TDH.PHYMEM.PAGE.WBINVD after successful page
 remove can leave a page unreset
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, "pcj3195161583@163.com" <pcj3195161583@163.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-04-01 at 19:51 +0800, =E8=A3=B4=E8=BE=B0=E4=B8=BE wrote:
> >=20
> > =C2=A0 On non-ACT platforms, TDH.MEM.PAGE.REMOVE does not flush cacheli=
nes
> > or initialize the removed page. KVM handles that by calling
> > TDH.PHYMEM.PAGE.WBINVD=20
> > after a private page is removed.
> > =C2=A0 The problem is the failure path after a successful remove:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM drops a private page.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TDH.MEM.PAGE.REMOVE succeeds, so t=
he page is no longer
> > assigned to the TD.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM then calls TDH.PHYMEM.PA=
GE.WBINVD.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If TDH.PHYMEM.PAGE.WBINVD fa=
ils, KVM marks the VM/TD dead and
> > teardown follows.
> > =C2=A0 At that point, TDH.PHYMEM.PAGE.RECLAIM will not process the page
> > that hit the WBINVD failure, because that page has already been
> > removed from the TD. Normally TDH.PHYMEM.PAGE.RECLAIM
> > clears/reinitializes TD pages during teardown, but this page is no
> > longer in that set. This seems to create a state hole: the page has
> > been=20
> > removed from the TD, but it may never be fully reset/cleared for safe
> > host reuse if the WBINVD step failed. Depending on later host-side
> > handling, this can become=20
> > either a leaked page or an unsafe page reuse issue.
>=20
> Not every SEAMCALL error is expected, based on the constraints in the
> code. So the code deliberately does not handle all documented errors.
> As in, the code is written in a way to guarantee some operations will
> succeed. If the code sees any weird behavior it does a KVM_BUG_ON(), as
> a best effort kind of thing. It is not intended to be part of a system
> to cleanly handle all possible bugs.
>=20
> Instead, if the kernel does allow a specific KVM_BUG_ON() scenario to
> trigger, the kernel should be fixed. If the TDX module starts to return
> an unexpected error, then the TDX module should be fixed.

+1, the right answer here is to not screw up in the first place.
