Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014B3EFFA2
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972575; cv=none; b=GdKy2G8cEzvbgH+kN8RP5Urom7EMgpmZ3SzanvpW2mEdOp/zXG5wv0T+9h4vYiohiGPvf3S9ZWrhp1Kd4RVDLqbQPL22ulEcIXUy24+k7jiShVupnbop+lzZRlgwpFs/4yWFVJtl4J7eBvyfWnQNVBzVkkamtGGlxIX2NOQTrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972575; c=relaxed/simple;
	bh=cO6gghqKZ0xUf+sm8Z9XiAstEbJFOtgSZ5IWu3J/D+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWfWDntVolvFLpGtQAGrU1+AcZk1R3owH7LvBHaDypKPfW61F2T5KyiTLJJU+UkCAQNJKyEsKf+ka5Ot7Gm5E6x4PRCTHqX/AxuOq2mPdyqXC12/VGYPQpR465277o2G7q3uzKcpWo/lVgyWFYc/V709MLCBpu8bmbpUKpUJlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxI2tHdc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxI2tHdc"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba15e384c7so91109875ad.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779972573; x=1780577373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoX+HJf5CfGdFpnE/ruFvtcG1LFz14O1Rwlo2nX/hWc=;
        b=SxI2tHdc5iMk0dyGhZW9lFiDlFPD5sVniHLmb84rj9kdWaa7bE6dOJ/d9UB7NBNXPp
         /g5ig8YeOIk7KgLPglcOzvN0AaQt6+F9EJir8qIZpqL+Olw9MpcOsMdaM3+ECkCRpt37
         QEw9hvTOds9mbnosDvUD5hKyzuJsF0wOIHcS7DNIp1J2Gg6srF+C4dDs5wSBAWN9jtXR
         9v1Fbk8tkKbksKit1udbQPJ9IyODfAQ451mqhgtiuPx8fNIpt21lgLI8ElyPjH6wrpuz
         DqQZXyXUHCYyDoqlAd7ofe/wQkGa5a04/L9g9Yf4CkJuSjR6ur6F10Pxjcm4pknOiB9Y
         hQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779972573; x=1780577373;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xoX+HJf5CfGdFpnE/ruFvtcG1LFz14O1Rwlo2nX/hWc=;
        b=JWbJPafKy1lmSXOFaH3CUtUdec5eSPpurq1zOXi8twGdXl0VjgiGeVq8e977x/3lgf
         OBZKRryABbgYc4RvXJXch9fQ0wu5WguMFZlhipQ4/lJPMgZmOzJYv2ry8mjBQINRfhJk
         UttKgsGRd8mI3hmka9VQOgAiJMLSPYsHGoqO8HbI+UCqcMNCGuXlhZf+F0F2u60a5ArH
         IKISBpjKPQn3sy5hjyokttNCDh4GIH5Z8u++KDtswuFnhmgieubq/+dxTskC4WS2hkhU
         ORdTk8NzfCmR1xiyX4T6I7xWB1sYYki5jioIt0U9YMAJyYk/Zes2hZIbHm9eRpu8spW1
         gysQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Us0GUwhtf0PLCJEdWfY25P03el/5C3eWzrUWe/KuKy1La0HFRrSW+1rjbXK6Vlg8Za0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy662sc5cZcQ4Rd1dTRMD+Br3zjXQQkSW59bBHss/2jdr77j28j
	8b4uChRZ9UmZnWLQamZEpUUxcQlzNpzpjhkZuUZmrXs8ErxQZwVCTMtbVscBFk2GexoYm7YdgrM
	/3m6/3g==
X-Received: from plbcp5.prod.google.com ([2002:a17:902:e785:b0:2ae:3b07:ebc4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c2d:b0:2b2:42b1:adac
 with SMTP id d9443c01a7336-2beb031af0bmr285011025ad.3.1779972573385; Thu, 28
 May 2026 05:49:33 -0700 (PDT)
Date: Thu, 28 May 2026 05:49:32 -0700
In-Reply-To: <CAG2uPc4E4mW9Rvxb7PdzRByd9teW0KcJaKHB=ZBHQWLa_6iiJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528032234.1322565-2-ewandevelop@gmail.com>
 <20260528034244.DC8041F000E9@smtp.kernel.org> <CAG2uPc4E4mW9Rvxb7PdzRByd9teW0KcJaKHB=ZBHQWLa_6iiJw@mail.gmail.com>
Message-ID: <ahg53BN4d0czbjDV@google.com>
Subject: Re: [PATCH v2 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai <ewandevelop@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, Ewan Hai wrote:
> On Thu, May 28, 2026 at 11:42=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Low] The patch modifies `arch/x86/include/asm/cpufeatures.h` without=
 syncing the changes to the tooling copy at `tools/arch/x86/include/asm/cpu=
features.h`.
> > --
> >
> > commit 17e8fbfd326bc812ee6f132253d520b0c7201874
> > Author: Ewan Hai <ewandevelop@gmail.com>
> >
> > KVM: x86: Expose Zhaoxin SM2 CPUID feature
> >
> > This commit advertises the Zhaoxin SM2 algorithm and SM2_EN features to=
 KVM
> > guests via CPUID 0xC0000001 EDX bits 0 and 1. It updates the CPU featur=
es
> > header and the KVM CPU caps initialization.
> >
> > > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/as=
m/cpufeatures.h
> > > index 1d506e5d6f46a..20b33413189c2 100644
> > > --- a/arch/x86/include/asm/cpufeatures.h
> > > +++ b/arch/x86/include/asm/cpufeatures.h
> > > @@ -136,6 +136,8 @@
> > >  #define X86_FEATURE_HYPERVISOR               ( 4*32+31) /* "hypervis=
or" Running on a hypervisor */
> > >
> > >  /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, w=
ord 5 */
> > > +#define X86_FEATURE_SM2                      ( 5*32+ 0) /* "sm2" SM2=
 algorithm */
> > > +#define X86_FEATURE_SM2_EN           ( 5*32+ 1) /* "sm2_en" SM2 enab=
led */
> >
> > [Severity: Low]
> > Since arch/x86/include/asm/cpufeatures.h is modified here, should this =
patch
> > also update the tooling copy at tools/arch/x86/include/asm/cpufeatures.=
h?
> >
> > Without syncing the tooling header, tools/perf/check-headers.sh will em=
it a
> > warning during the perf tools build process indicating that the kernel =
ABI
> > header differs from the tooling version.
>
> good catch, I'll fold that into v3.

No, ignore Sashiko.  The perf tooling folks keep the tools/ headers synchro=
nized,
they are very deliberately not used by KVM selftests.

P.S. Please don't top-post.

https://people.kernel.org/tglx/notes-about-netiquette
