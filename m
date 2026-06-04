Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B7399348
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589577; cv=none; b=eeCZcqNouFkrn94BATQqUu48btIslxxw46DEiK9P9spH9tdv/1TydqMVbm4JvJLJ9/9wuk3nGjSMnUrzm9S2ZBK58EUgDpWLWM9clA/Vc0KFDQS+JTUENELBsT4xLRq+HHox5LapqcYMMJTK+ZLDWP4+J2EeaVbMU4ucex2jzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589577; c=relaxed/simple;
	bh=r5q17zAJ5FVo6m2eXuZpQdHcUcqOccrbNsR+ygn1HHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nyQ2aScLmNH6ots1sWgl3OAHsAwUmi1jaQxBFPhMwU4WqjaaZ6zhDnVlz4LtjGWZXIsr8lr8AKEYmaq/8XdB5dcN1ocOJ4atDNC0qBxff1OoqNh2QDdX8lWvHsrZByUvsMZwhX288gC8sLwnbxnEYiBSKA3kOrHRZhJpzGXiMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyQQj2Fa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyQQj2Fa"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so1240373a91.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780589575; x=1781194375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHofGI5BidNPmhFV7CbtCFar5wuofTyEezac0pXH5gE=;
        b=uyQQj2Fa+b/qu1Q0zgMXqVoELTUiov4UBCIXxj6B3b6kw6joRhVVnvMvoOPXixla7H
         JEH2OYPQtBiAf4nYYrv4kQR9idtCOAaXy3fh30AKpSAL5SA7jOmxlWHzcxuhENYahUzu
         Ze/ELDIwZQirTRkr22qX97aj3DYRhexdf4todfHkgI8ST89zVuphiZ5ztuguZ8vH8I+5
         dH+EfV1BMUcGQGBVX6/d2EcPJzj4KrLokSb8OZl3cJgibTtmE2NLi/4c/m9OBBWECFSC
         riamsKbn8qjcWjKMsjobJSFrs5aHaQmarD5Tit2trFj5IafAim6rtdK/LnczmuuGSJ7M
         fssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589575; x=1781194375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHofGI5BidNPmhFV7CbtCFar5wuofTyEezac0pXH5gE=;
        b=ExpgqcoCiQA1w1YzCRMHRocJm1AGZxadrGFdv1//CTBzQrCvfs2KG+7KApHUSU+PVz
         AZHofzOIsJW+Wl2KC+5XzLlriy66P8fFpEuRPytPJ3wgCXh5K482Gbrjc1RElmFrXmld
         m9xs3RY/+3oFfmBeCbxAH2YAQ5S+L99/8dZGQLoOf4oUpy+ARn+ALVKEJ3yyOK1PIgWW
         HPA9c/mJEc9KxXDmgignemY1jLxleO39pixIpMTtUwq+CriWwW49i9mfIEzRZclewYmv
         SGf4YEo9n0q9cnc1I9GuuhKEmwdMjReJxTx+abuMXQhjp6+Lm9z1RGCATq7cDWqlc7N/
         ro2g==
X-Forwarded-Encrypted: i=1; AFNElJ97rV/OqRsjAwUfiYLI4b/+RN6OMlJa19tTv4ijsWLQCsHBiitthv4a7bBoYDiANBJ4NaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkow+667LV7S29kMkD7dlmeC+WFUHyroQUAYW/DbVJu7iyCPZj
	uv342yLCJddjoO/DmQksiUm5Bp8h3o+EdtwaAijF176+85mRHuy9DCUungDo0Bqqs3TS539Zt92
	uNsDvNA==
X-Received: from pjqx13.prod.google.com ([2002:a17:90a:b00d:b0:36b:a7c4:95be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8d:b0:36b:afa0:c675
 with SMTP id 98e67ed59e1d1-36e31cacd39mr7915263a91.26.1780589575061; Thu, 04
 Jun 2026 09:12:55 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:12:54 -0700
In-Reply-To: <20260604021233.703BC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-5-jrhilke@google.com> <20260604021233.703BC1F00893@smtp.kernel.org>
Message-ID: <aiGkBodadEKK9F-w@google.com>
Subject: Re: [PATCH v5 04/21] KVM: selftests: Add helper to generate random
 u64 in range [min,max]
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> > @@ -42,6 +42,24 @@ u32 kvm_random_u32(struct kvm_random_state *state)
> >  	return state->seed;
> >  }
> >  
> > +/* Returns a random u64 in the inclusive range [min, max] */
> > +u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min,
> > +			    u64 max)
> > +{
> > +	u64 value;
> > +	u64 range;
> > +
> > +	TEST_ASSERT(min <= max, "PEBKAC, min = 0x%lx, max = 0x%lx", min, max);
> > +
> > +	value = kvm_random_u64(state);
> > +
> > +	range = max - min;
> > +	if (range == ULLONG_MAX)
> > +		return value;
> > +
> > +	return min + (value % (range + 1));
> 
> [Severity: Medium]
> Will this return values uniformly across the entire 64-bit range?
> 
> Because kvm_random_u32() uses a Lehmer PRNG with a modulus of 2^31 - 1, its
> maximum return value is 0x7FFFFFFE. When kvm_random_u64() concatenates two
> of these values, the maximum possible output is 0x7FFFFFFE7FFFFFFE, meaning
> bits 31 and 63 are never set.
> 
> Due to this restricted PRNG space, using the modulo operator here means the
> function cannot generate values in the upper half of large ranges (above
> 0x7FFFFFFE7FFFFFFE). It also introduces significant modulo bias for ranges
> that don't evenly divide this artificial maximum, preventing uniform coverage
> of the requested [min, max] range.

Not sure how much I trust AI's ability to reason about math, given past "bug"
reports.  Regardless, this is a problem to solve in the future.
