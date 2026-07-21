Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4C472F92
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656154; cv=none; b=RrqQi1trW/r4f9M7xRMM3aDxozwjt7c3v/SjHFQ48hJqqiV+WhU/r60dfxPQi6eCzhNyowAMxPZ6LheB3ynrBYfpEBGCVmQcDGfrFQSgmgXhG1TvuE1NQTq5b4mNyYmAXVPwEBUhomhNONuVBfvhf6JtydPNgmdB9wCc9s00jMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656154; c=relaxed/simple;
	bh=wtoP453vHl9jhsIHwdll81HsJdN1cePg3YyVulL6fXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SoYJL3DH1VQlMbgnDVmEuGS+mbHRgswcX9YEZw4dYCWWjZe+aZ/4HrUDHOUJ0ANOqHxulAi2Ae8IDlxLZA13aoa899HmEPmm9D6JI1qdOG8eUTYHksdg+ZAFDFH2OKISChZc5ckAjwMwQpFtCxD+WR4O2MtyQxwDqEyJpg1lqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocB9Y7Si; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocB9Y7Si"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso16199611a12.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784656153; x=1785260953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fjt8b0VZx808GggIVBxRHLGqfLzbT59D1LVyN4koO4=;
        b=ocB9Y7SiLHYzUUFtLYewqKvDHF35kW+50Me3BT3JzK35d9OaQPqq9ISLuWJrfgEn0R
         hOoTcaRxk6k2PNTBW147XPQLTxw1GJztQ5icPa/S1F9gKqSqFMShupB/rqmvfajsl0oS
         HPur727HZAhEVE0Gv/W3wuSGsU8A2q7HXNsBzHlGG5mfOnnbqdwoSr/2Vhvc2F5HskoV
         2ByvTrnrr7qhTla7qpuNE/1wBMj7h3PeXKlTTQ7BfLKyYToVnJ5oniyy+P6NXLNPHma5
         4t0E5VvrXZA0VpZWwo1HcG8zmjRA3XULRXC+KTv4xT56lE/mNWMweHiCh13RQikS//N0
         OaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656153; x=1785260953;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1fjt8b0VZx808GggIVBxRHLGqfLzbT59D1LVyN4koO4=;
        b=OcNmR6eDU9WKb6ja1dRtQrv+PZdB/X657XrH8yBe9fXMTNEbA1dTsSafCwly7UBmJ1
         Cp4y6yyCD76gKezJmEQWysPQdBxLYhC5FyJ0aG0Y4KFm+ot0xii55j3+1YGuePSABqpO
         J955nkdrLYqJCQ2qZwV61VqV/FwH5SMg6BIHwLp0Yrzug+l1reYhqJ+EWDPxoQwrtMBk
         cOZRbupJsPqB7FLJ7M3SbBwEbvzWbCQKeNbmfQuXcExT5SD4yj1E2oio85kMw6O2HqLh
         frtBiu/+bCtoa8oPvD0J2lWS66dJPOcYcF2lWvTd7H5Jt1YuMPVDPj8yFCscfhjIbK65
         Dy/A==
X-Forwarded-Encrypted: i=1; AHgh+Rqt6RmnzycAJCElRU6YOzNLr8bVtxDkA3qxNZX5EL2l9IM8pJ5+FQ/kzJkCAks94MVvnGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8R2rl12cS6k9MI4PUtoNhgeKSAfLKE97iMVsP2Rme31id/hNN
	FcxX0dAoePXosrv/76QLKDZUfiKFVhGye8BeI//MsvMnZvC+BJzR/8hprGikViTPFhyKcKDw48e
	eyDV3HQ==
X-Received: from pgjc9.prod.google.com ([2002:a63:d149:0:b0:c85:9c9a:ab5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2583:b0:3c3:875d:c546
 with SMTP id adf61e73a8af0-3c3ad792448mr20699995637.7.1784656152391; Tue, 21
 Jul 2026 10:49:12 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:49:11 -0700
In-Reply-To: <al-szwXKRbdGYv49@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720192221.72912-1-absandze@amazon.de> <f5552576fc749b4b453514f52921332cc104c6a6.camel@infradead.org>
 <al-isty0nYjQEwqH@google.com> <al-szwXKRbdGYv49@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
Message-ID: <al-xF6G4W6uEikao@google.com>
Subject: Re: [RFC PATCH 0/2] KVM: x86/pmu: Let userspace disable SW accounting
 of emulated instructions
From: Sean Christopherson <seanjc@google.com>
To: Luka Absandze <absandze@amazon.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, Luka Absandze wrote:
> On 2026-07-21 09:47, Sean Christopherson wrote:
> > Hmm, yeah, that'd be better than ignoring emulated instruction entirely, and
> > would give userspace far better control over how shoddy KVM's emulation is.  Off
> > the cuff, the change would be fairly trivial too?  E.g.
> > 
> > diff --git arch/x86/kvm/pmu.c arch/x86/kvm/pmu.c
> > index 7f777049d328..c5f436c6f83f 100644
> > --- arch/x86/kvm/pmu.c
> > +++ arch/x86/kvm/pmu.c
> > @@ -1084,7 +1084,8 @@ static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
> >          */
> >         if (!kvm_vcpu_has_mediated_pmu(vcpu)) {
> >                 pmc->emulated_counter++;
> > -               kvm_pmu_request_counter_reprogram(pmc);
> > +               if (pmc->emulated_counter > pmu_something_something_tolerance)
> > +                       kvm_pmu_request_counter_reprogram(pmc);
> >                 return;
> >         }
> 
> I believe this is fine, but perhaps the tolerance itself could be a knob

Ya, I was envisioning a knob.

> with <0 meaning no reprogram?

Eh, I don't see a need to assign special meaning to <0.  Make it a u32 (or u64),
and then a large value will provide the same behavior in practice, without needing
special handling in KVM.

> While the contention on this path will be much lower, we are still
> introducing more steal time, and the added accuracy is probably not worth
> even that for guests who really only care for the rate of change, rather than
> exact instruction counts.
