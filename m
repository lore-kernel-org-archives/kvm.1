Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309F4C9007
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594454; cv=none; b=JUKNmkW/u3o9klBb3gk8SnBwie9r0aVAs6ajKM0TzkItCPR24axiP4PvjTKZxb1BZCc/vo80L6iZF2sWw1NEkV8usOE4BjE7lnHaq3WkfnL9g8ysUw2PtT64r+pgA9Y75bMUqgS84mwXnbsORhHLts5KTmbwoNQe/k9gvnc8RIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594454; c=relaxed/simple;
	bh=aCcdCngiQXJFZOtWdicopve/zATAi7XQT7CIIQpmm4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEbmR8eN8b2PgxhSWwl385ajgA3DN34bOd0ICZf4Ob228IcjvjbqjPTbQ5mSFM0tWIkQYUbLS4hFZm8fzMSSmFHFNEdRcg9LRjuAy0mIcxwI2iU2of/7oghL9DBDmNHNqCi/TxqNkolFBOvuXWRfKDUiZHAdgqJWlFa4cK30K+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJ0mfUm4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJ0mfUm4"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf30576aa3so7191605ad.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594452; x=1781199252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDWsyQXu27Nqo39JjFp9cYOggBh6VemTZn9SCRN13K0=;
        b=QJ0mfUm4yLM/tim8HfqMzWM+dAyhdZJFlnQ07pCmbhxtGrS2UnAlILJoqYrQCSbnUz
         l3wFlSeO6/LWQpTNmHWiye6dRoLjXnK0ZhU/PDZLAFEgYnGmn+JRON0F5Zjs+EldKCbt
         Z3QdmkCFAfNT9imsKrjpiPmY9nIY6Dz58fv1Ijymd8/3zztnx5kc0ZIfu+SVGDxGrhFz
         pC4C3Ygdxhy6zQHsW53UyRXDXSXYpfEmL3plgbJTK/bW31zLB4lua3JqErFgCK26GkFB
         hM1NIuH0x0aJ2SZzeJDnJTMbJn5ToUJ9TMXsy7tNoD52pzPcbamX2aOdwnbQhnP51cDS
         ESPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594452; x=1781199252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDWsyQXu27Nqo39JjFp9cYOggBh6VemTZn9SCRN13K0=;
        b=SIUlWJsnzijf7E5uc+11nCbv5N/yE8b6jGbHXMIjLNJFz1v25EX0s+9TKlDHB8t5so
         W9rSgrdvYuTvYGLLpWOguJsCCr5LI2yzPG+CvaTgvCj0EHAPU4fKXF11OWBbxxR2q4HD
         1UE0US1fAQtQdsI6DK7EvuOcyQeIU+UEmjZWuXG0MO74YXuMD3aBlD43AEwL6E8EjTcr
         7Ii6zbTfZlTzsfY7EmRUbhHy3Du0adUOQCU+TvOTm7yylzDOksSd5E/RtG4cc3JisNxi
         VyBmFAGu2dtDdlWofHyBgJ6ogxuMdqdc/huaKXK/t2ba9mEBbTjbE7RDk1pmGp4J7xEj
         zwBw==
X-Forwarded-Encrypted: i=1; AFNElJ/uU1vkmMRktjIxANXTSGfWJg6g0nUzgMAV7fnt9kOxtJpDZMgZ0fofEHINLcY/6CCpPCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uFfw1vMRvejrs+++dTgDxywVaTS8c28j3/os1ouzmdKQz+uT
	MPK83BSaIaRhKmKieWXzwVn806JtEOJ7FuIJei1YublGoNbYUJ9GUmQS5seI4onwR+l0NIo2GiB
	82k1p+g==
X-Received: from plbjz7.prod.google.com ([2002:a17:903:4307:b0:2b0:b410:3605])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cf:b0:2bf:1e37:a2ff
 with SMTP id d9443c01a7336-2c163606818mr93101205ad.0.1780594452275; Thu, 04
 Jun 2026 10:34:12 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:34:11 -0700
In-Reply-To: <20260604022202.0B8F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-22-jrhilke@google.com> <20260604022202.0B8F11F00893@smtp.kernel.org>
Message-ID: <aiG3E7ggqVuqDhzU@google.com>
Subject: Re: [PATCH v5 21/21] KVM: selftests: Add xAPIC support in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> > index 41c50caa928e2..7e421cb7bc69b 100644
> > --- a/tools/testing/selftests/kvm/irq_test.c
> > +++ b/tools/testing/selftests/kvm/irq_test.c
> [ ... ]
> > @@ -31,14 +32,20 @@ static bool done;
> >  
> >  static u32 guest_get_vcpu_id(void)
> >  {
> > -	return x2apic_read_reg(APIC_ID);
> > +	if (x2apic)
> > +		return x2apic_read_reg(APIC_ID);
> > +	else
> > +		return xapic_read_reg(APIC_ID) >> 24;
> >  }
> 
> [Severity: Medium]
> Does this truncation to 8 bits cause the test to silently hang if run with
> 256 or more vCPUs in xAPIC mode?

Yep.

> For vCPU IDs 256 and above, the 8-bit xAPIC ID will wrap around.

But not because of wraparound (it's amusing how bad AI is at basic math, when
it's so good with advanced stuff).  The test will use IDs [0-255], not [1-256].
The limit with xAPIC is specifically 255 vCPUs, not 256, because 0xff (i.e. ID
255) is a special broadcast value.
