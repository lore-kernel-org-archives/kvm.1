Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655874968E3
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333493; cv=none; b=XfxqJcfH+71dkTu2HtH8KIStRdAV9pGFepCfecsrxrPrkmOtwcEmuysNh8hms+1jfTHe1HjBY3BoNK+6fkM9Rv518FbueN+N/QKpZ/iPtx6EqwN8kXefhTYqihGyJHPzjCik94JWPl+0Pf/T3MWLdDFHJZ3QYg/2w3e6BbOonWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333493; c=relaxed/simple;
	bh=7Krgk+KtP2kKGDNSULwxeCTj69yvjuzj5U135znDP8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o2+PUSAx484bSftAcSwkf3P4y7Z7lOi7hAzyXi9EkiMoR9e7o9ShD5ZFyKX7UW7KcF+AlKpW5diMXTCQi+4RFpWPKjlNwQmeF9g9Sa1POfRRYCyG4vAfHkWfyvhPqKMCKTraTr+7EieYFrfDhzGw3NW28BCMg99LJODE4cp+WAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txy+amPS; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txy+amPS"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1054169a91.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785333480; x=1785938280; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gdyVGuXsSa8NOY4PO6tbgVt/hhgWTBtam/u21E/Axk=;
        b=txy+amPSabj3l//oEOyIUCYb73SlRqoINUy9GK1bJYRYJtvijd+RsXrJv30t6qwgyi
         GAKXJ38kRIufEy4S8p4A9/glNhEVfOqGcVrCA24+QrSR0JbDc+B23Ic3hRpDtVWFiQkg
         s5dg2JhkPy+0voQPlSmJUYw1MuNmaJBPsjRodL4XuUrtqFicfmGFfX4ai0UfCrlm9Jbe
         UAzf+BiQ1PRfXphhSQ2tQHET9qKNRf04usewcCqsLyddVeYnjAWiLd7ThZEfewMva/h4
         xm+bmiz33V4bYnlNqTYMruXOIeW5dcAyTFeyUMB/cNTqNN+o0wjVTtILoWZig+svl4Vi
         t2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333480; x=1785938280;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gdyVGuXsSa8NOY4PO6tbgVt/hhgWTBtam/u21E/Axk=;
        b=m4n+sZcC5yCZKmj0subgsAy51air0qaKsvjw9H0ZpNV1un9EbxKsym6KC5e/tpKlLa
         qzjIN7CoSlxjBKBmg2voDnq9RG+cfUzpINNXkNoSuUohYj/KMKWPsytUyOuj8SA66zkj
         p+GhSwXaREEB/J97aP/ntj6g/Ilx1li8ddcOS0Lj4nX+C5hBruRLMqIunWfmhOab74nJ
         yJPMSyvWxOrYQHkSRfBvvypFXqyMjfcpewkvDOgQERzYXpDqaf1mG7u55E0GdntNBD6q
         eq+6W0S/E83tZCdH8y5O+FGSQ5PKU6DZjwMHKu6+nbS8OYMl0bDcK/dOa6XU3sY5oDhp
         0BJw==
X-Gm-Message-State: AOJu0Yyjy3iTkHYoRtSXMgzqu/A/u2tiXTdnLF6vpxtoIkk+JhcIEhUk
	3Xk9zrNW7aIu8ekfi/sku2cjFwyPhdYM7BLqsY4yD/NdI44OnYvvAKvujevYvH5zMCoFSc7Y7lE
	CzOqOTQ==
X-Received: from plka3.prod.google.com ([2002:a17:903:f83:b0:2d0:237a:97bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:78e:b0:2cc:9763:e607
 with SMTP id d9443c01a7336-2d015d23403mr52805965ad.27.1785333479616; Wed, 29
 Jul 2026 06:57:59 -0700 (PDT)
Date: Wed, 29 Jul 2026 06:57:58 -0700
In-Reply-To: <20260729135054.B5CAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729134203.1377606-1-seanjc@google.com> <20260729134203.1377606-3-seanjc@google.com>
 <20260729135054.B5CAA1F000E9@smtp.kernel.org>
Message-ID: <amoG5v6YWX5FcB-e@google.com>
Subject: Re: [PATCH v6 2/2] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 29, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 7d2cc36a04e51..67c8dc1eb2c4f 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> 
> [ ... ]
> 
> > @@ -8305,6 +8306,33 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Workaround for a widespread Intel erratum (e.g. EMR158) where the
> > + * VMX-preemption timer may expire earlier than expected when programmed
> > + * with large values. The workaround is to cap the timer value to strictly
> > + * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
> > + */
> > +static __init u64 calc_preemption_timer_max_value(void)
> > +{
> > +	const u64 ARCHITECTURAL_MAX_VALUE = UINT_MAX;
> > +	u32 eax, ebx, ecx, edx;
> 
> [ ... ]
> 
> > +	if (WARN_ON_ONCE(!(((u64)ebx << 25) / eax)))
> > +		return ARCHITECTURAL_MAX_VALUE;
> > +
> > +	return (((u64)ebx << 25) / eax) - 1;
> 
> [Severity: High]
> If a CPU has a high TSC-to-crystal clock ratio (for example, EBX/EAX >= 128),
> could this calculation exceed UINT_MAX? Because the returned u64 is not clamped
> to ARCHITECTURAL_MAX_VALUE, preemption_timer_max_value could end up storing a
> value larger than 32 bits.

/facepalm

I completely misread this:

	return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);

as max_t.  I'll add it back... 
