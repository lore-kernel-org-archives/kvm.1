Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A33B95E9
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603078; cv=none; b=E1RRysf6T3W2qPanKtPj1d+7Cup1MRJ4Gm8zJv5aPbpw2LZlE0/kJ3u3dclb/CB238SBwZ3MRWobUmYKqA7rDCM02MajeeQsKoSyn38s9Uw5vnKk+uHVN/Ro+VYyMryQL4d/1KzEqooEFbgbjm4UED18qnwyV6eZepFIjdrH+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603078; c=relaxed/simple;
	bh=rXMgegBfOhfeytGkgRNDEJriW8nCixKGipVpwv/Yb0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l6YHjaZet8WEWL9UtSjFM53oPrQpJtPLqEvhJQ3eHDLTrS8ZO0TNfG0bID7WF2NOWMz9YRhNPJsaKBN0kDYuPpuEFa9a+63DcuW2CSkAsSXEo1qFwbxBacdKPJPFADP/W83U6/NyqpGAVLC6GUIVWx6EGe/BjxjjOaRQ/5CRPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qe0MNFI1; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qe0MNFI1"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39533bb224cso422471a91.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789603076; x=1790207876; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1lScqubr1yoj5tPRxggQdvm+qpOPiHCADjlZtOkPnU=;
        b=Qe0MNFI1Ea1lFqndDjR6NqoX7x//SOmMolYJ2hky+j+bvZxcHfpt1VN0yFj1wgMNSL
         9mZNQ8f79eDdZwSB4KpgEZE4TrX9B/QPJlrlpNebQmrKc1KbqhIhCNTLaD9qlcONAJqV
         fnbK1bCrq6A9U1t5NNwxM3XWh3URDJPR6W5sapbufbRyIvjKPsE0X/hpC4y1GCP9ZHrw
         c6dw6OitjgnmM3pkyvItDvJUpa37+W72/KnVSsEqrOH2vm3kYAVzq29rkSMEwk+04zkW
         wdwuXnM2GqVg4Hn02yA21htG8YNor/AyyWJxVoo4mmrn/0PSH2K+VO7b9nQRKnUA0cR8
         uTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603076; x=1790207876;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1lScqubr1yoj5tPRxggQdvm+qpOPiHCADjlZtOkPnU=;
        b=rknm+K6qRSc6wZWhR7UhZceSsvwhrr29vraIDTGOfUwMbA7uvvjLmfYcP1Hk7AdoML
         3sOplQa12QUC62RZUmxz6d91CFUkCpejuMddBgf2FeM9Mu1buUmcNO0nSA8AFu5H2zyF
         acvZ797fHiYhpzDOwkg8QzcpLob7MxoYTbM50ZgAShF9wwBwGQsearIPhcdTgrnO6eiT
         Ezgx/NSRcpFyUzNagjMhUt50Bw54kIYAK6+FOOEt6WKgo3Kf/aB12ecJ4RtBBg+VtAqr
         2oBBYOrlkyzxGcKlRldQ+BrV9cKzEyV2Rxe1mZ8suk9evkWhedWgvzYr8ExXDIf93nrb
         0ZCw==
X-Forwarded-Encrypted: i=1; AKwUvBz3x3lwEyUMdKte/NatiP1jec5BTV2E+Oli4PBbflPQ9gwhj4DoThCvVbS3qjQEkd8xugs=@vger.kernel.org
X-Gm-Message-State: AFuF++mVV+tAg03ZnbbY3ctmFm96y6xN26PUOpTtia8bVG7h1/5uiOp2
	2DJP3/bWYRmzKrU5g90qOoO2eM5EOSOi28HbrGeUr/gvrhIhooOdI7qZSdiUBuHQwxzj3O7Vdmx
	DZjYuFg==
X-Received: from pjk3.prod.google.com ([2002:a17:90b:5583:b0:39e:3716:7aca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f06:b0:39e:252:ae4d
 with SMTP id 98e67ed59e1d1-39e1e4d3fe8mr10125165a91.17.1789603075980; Wed, 16
 Sep 2026 16:57:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:57:49 -0700
In-Reply-To: <aqsfoHzOip3n4zdU@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
 <aqrZUZtSZ-YItclT@google.com> <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
 <aqrtprn5YaMijVdZ@google.com> <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
 <aqsfoHzOip3n4zdU@intel.com>
Message-ID: <aqss_eQAY7soHRwJ@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 16, 2026, Peter Fang wrote:
> On Wed, Sep 16, 2026 at 03:31:50PM -0700, Edgecombe, Rick P wrote:
> > On Wed, 2026-09-16 at 12:27 -0700, Sean Christopherson wrote:
> > > > If you are thinking the implementation could punt on how to handle the guest
> > > > interrupts for now, that seems reasonable. I'd think exiting to handle the
> > > > host interrupts could not be skipped though.
> > > 
> > > I'm just trying to understand the scope of the problem we're trying to solve.
> > > E.g. I don't think any design will save us if generating a quote requires a
> > > CPU to be spinning for multiple milliseconds.
> > 
> > Elena, any updated estimates on CPU based quote generation and HW based?
> 
> The current estimate is 10s of milliseconds for HW based, and
> milliseconds or less for CPU based.

I am beyond confused.  What is "HW based" versus "CPU based"?

At this point, I don't care about the gory details, I just want to understand
the basics:

 - Does generating a quote require the CPU to actively execute instructions?
 - If not, how does software know when a quote is ready? 

I tried peeking at TDX Module source code, but I can't find anything relevant
even in the latest TDX 2.0 drop.
