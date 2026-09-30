Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BC353A65
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731137; cv=none; b=X3a02mE3UFaA9GRn8r0NS1iTnI4yPWAc0llCLRHOT6b1UKJqpyTxZsUuheDMiVTOQEIn2KlQmNd58OeWMPae7Nq5XjI+p1Ba0U48cBxEMiJPkOYvO8kSjmR1CG7jxlcrgH+ZnkvBcCVvsCCO+G+d1pQXNEL5iwDb0Y+RL8LKDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731137; c=relaxed/simple;
	bh=BvmcuRCXXXZPAuXMNLO9ZemCr9+Ceq6CToRmQROXTH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o5Q14u0B2XHFDqfaS4Ccmi1gsirHWDEo21nWrENaF2nv2o6bkhNVpklTbzUGDduuX6WfMVHD5YZzxBDh5Ti67kfdTTSPUmfatylOCG2J7yXVZZ8y5gNnbVOTlAFTVVPR/9+/4oHN/T5Uwz6hG0ZG/g83/CYp3leazzT43mZvkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xb54fYL2; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xb54fYL2"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso2899122a12.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790731135; x=1791335935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Un5b8BLNHk7eoJfvRT1Ls7qMfUvtMTWcSi/R3TKBoDU=;
        b=Xb54fYL2x5MZWNi/JU7L7oYoYrK6fznYSSBNnwjwRh3L0wqzbk2Y6hK03Cfiq57S2l
         6KZdBBrm/6+cLem2bFl+z0oJSoiOZc70OS2sg1lxin4Gekem2PuCPYWQ1cH2ozhpLyGH
         V7w2tWwe6hnAeCCz0YGx8zlYxC82koy6QL5qYUbgLAABO0OP64LG0Zf8qYIkb2dMNh/k
         o4uWrg+QEIEfaKBvUFhlljnvXNcQC8i/G/HRLjOa82+ZlZs4GKfJZNEx2HWTRegiiXza
         za9gGZVqm3U9+vbJcRh2cO1u2MsyreCNAGkcRs6BuefXX520oJRSlBEd0sIeKeUSjxg5
         rtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731135; x=1791335935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Un5b8BLNHk7eoJfvRT1Ls7qMfUvtMTWcSi/R3TKBoDU=;
        b=DvKWPQ3kRxE5a8VQ1RBp500+YonYdD4QmRVSI5keK/rq2qdWXjQWgVYQF/WemW5ZSk
         YVwSs9Yr9gx1/oK9P5mnYQQpNP0rMmklupGgM5MRW3LyxnhDaNZ9OYHhBcXd2KWIqkAv
         qm4jANKgpUn9CXmfESJ2VOTWsKnXCkqTF+3DmvVOVZwqUjsJ6IuWYUaVv8+a6r9c3IhI
         n35IDq7NRRSpP5PYBd8BL382dkyQx7qpVe3opzxQX1zazOyNsMTFc5ZYEFfxySa9Le66
         1h2QiFB3ntm4iUiUYYj/bMH5tA2XoI3y7ZIptMmw9PXWF7BF+tF4woOllsr0tx327HFR
         LFyA==
X-Gm-Message-State: AFq9FYLe08bb2Fh58NUgKMa5snoKPfr++zU2A7hAB2trT6wjwm+1eMQ8
	Pu59EDvUcDWVT/Ssyu2B5zEwhThYRNPZLmeOheP5318cYg3bIN5F0PboOxJ/C1p2y4z6C3D952V
	NIHNibg==
X-Received: from pgbeh7.prod.google.com ([2002:a05:6a02:2567:b0:cc7:d296:c015])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b01:b0:39d:fcbe:fe04
 with SMTP id 98e67ed59e1d1-3a4bfad164bmr1055312a91.2.1790731134877; Tue, 29
 Sep 2026 18:18:54 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:18:53 -0700
In-Reply-To: <20260930002238.649421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930001341.3171558-1-seanjc@google.com> <20260930002238.649421F000FF@smtp.kernel.org>
Message-ID: <arxjfYTdZyM2HejW@google.com>
Subject: Re: [PATCH] KVM: selftests: Make guest_snprintf() a macro and use it
 as appropriate
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:
> Closes: https://lore.kernel.org/all/20260918113631.634233-4-gokul02k@gmail.com
> 
> > diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> > index a6a3e16578959..817d4d5ca7cc7 100644
> > --- a/tools/testing/selftests/kvm/include/test_util.h
> > +++ b/tools/testing/selftests/kvm/include/test_util.h
> > @@ -238,7 +238,17 @@ static inline u32 atoi_non_negative(const char *name, const char *num_str)
> >  }
> >  
> >  int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args);
> > -__printf(3, 4) int guest_snprintf(char *buf, int n, const char *fmt, ...);
> > +
> > +#define guest_snprintf(__buf, __n, __fmt)		\
> > +({							\
> > +	va_list va;					\
> > +	int len;					\
> 
> [Severity: Medium]
> Does this macro shadow caller arguments? If a caller passes an argument
> named len to guest_snprintf(), it will be shadowed by the uninitialized
> local len due to C scoping rules for statement expressions. The inner len
> is then passed to guest_vsnprintf(), which could result in a random or
> uninitialized buffer size.
> 
> > +							\
> > +	va_start(va, __fmt);				\
> 
> [Severity: Medium]
> Does this implicitly capture the caller's variadic arguments? 
> 
> The macro internally invokes va_start(va, __fmt), which couples it to the
> caller's stack frame. If this macro is used in a non-variadic function,
> or if __fmt is not the rightmost named argument of the calling function,
> could va_start cause undefined behavior? 

Ugh, and now I remember why we ended up with duplicate code.  Lame.  I'll drop
this and grab Gokul's original patch.  As much as I want to keep guest_snprintf()
around "just in case", in practice I highly doubt we'll ever use it.
