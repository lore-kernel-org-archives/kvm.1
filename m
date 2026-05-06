Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827853F23BD
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076422; cv=none; b=WPzuQmlN1KJSxN73Q9lkxnJvLuY7Y07eXO0a4F/2fjPTt6+Yc1NhliDh9f7vUEFWcAT5v9DjXB5wiQzYHCIMuS31UmtHU7jh3kPAO/KfU1SsOCQs5+PEzpFMGkC75T+26btXN1UO74La1YcaQWRORe/1xM0UTKupFYbdXiU8mP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076422; c=relaxed/simple;
	bh=d1GveTJ5vVq/ReLV2Tg8kBqUBdc6F/ZOw/LbCHTCYP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l6txDKMDZj7TblNDuPRShBynrXXksb5em/ZtsdWcSv1mq28WXqV9v+ommu7LAy0v/hPR+4GHYCo2gKfjTpC6G25j4LJOT9VQXzOO3oRSo2CmRoRRkz52YGYiq2MUhRD8EEDUVKVuoUwqgHWmXUNs9onzFO3yNurEn+lTQtR4b9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBl9YEhP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBl9YEhP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36514eb1194so8288537a91.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778076421; x=1778681221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dusEMSdTJZaW+qQ/GlWCiYE+AG8R1AsK+CFejsL/m/w=;
        b=sBl9YEhPfMRJeHoZ8B9VIEJWRop8wQRQqSH1HDYSlBO9nkzt+FR5RMKpcAHHnLG7UF
         xLsBF3HPxikT/u43tn3S2mReCabIjKrjTzHdJ53Ve4pZLcGpuTI/RXn8v1a13XnYVIY1
         qpguT6Ffm7dKKNgAFX8GrfNI11JX+dNhj+TKZ6ZmgUUYiZHcJwjsntbVOp2/7QghuN85
         pPd419WaBveiwKdKaupxRNFczHPrGeg7EJo+d2lybBJR/GZWppLub35YsLEeedercTKy
         3HCHoBVy9bKpvBDk5BGltgaz2KQ2pet/OCBcVH57vZVv6DJ5WWAawJBdnpzVhj0EkoDW
         QAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076421; x=1778681221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dusEMSdTJZaW+qQ/GlWCiYE+AG8R1AsK+CFejsL/m/w=;
        b=MsBdriSUi/To9KgysvRNp5+5Bji8Tn+WYWrB/dFaAjOvHIsHLgm486FFcp8SBbYwtQ
         ukO4MyOuH4laF59vRs+PdmwG0D0ZrJz4udQ9aOTzj14iLduYGUG1Q1VNOMRsyRfaj8ao
         udG+jyGY+EJcp39W8tmcpMVjJQ7EU9xM1XD+Jyw2BOp4dES35N1D8jTFol3+XpwK0XhT
         TvVVRiP3m5VZSeXaOvXwywdsmHfGGNoYd6fMRAqHuew9pQm+iXZcghdafNw+wlBedaht
         +LxGgJ8pgg9Sym4mTNz5AIHPeZO3dtpOYAEw5AN3exJg61KTDnVXOwMad8hbABKBxLhm
         698Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ULcfTLwRFkwYWneohVDmy5JJAo1AA+q0T9FtrlgvkwUUSSq1/xxCA7wAU+fPOX8S4p4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Ii825IiehBU/hI6nm8yi2RuYe4aUoDBtl4lJWfxfFiQCJGoR
	P892rpFoCRCCWpSm9UJRS/a71zHJRbowSgfzGmYcB8EmPMIUPmenL0EonPll5cWN/DHZkQxha02
	ySd8ArA==
X-Received: from pfbfc31.prod.google.com ([2002:a05:6a00:2e1f:b0:839:4a33:c35d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e097:b0:39f:3ca8:a33b
 with SMTP id adf61e73a8af0-3aa5a91552amr4048591637.17.1778076420679; Wed, 06
 May 2026 07:07:00 -0700 (PDT)
Date: Wed, 6 May 2026 07:07:00 -0700
In-Reply-To: <adlNjCRRCur8mjCA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409222449.2013847-1-seanjc@google.com> <20260409222449.2013847-2-seanjc@google.com>
 <adkl4wFdk4JrM3T-@blrnaveerao1> <adlNjCRRCur8mjCA@google.com>
Message-ID: <aftLBDM1dF_xHmo8@google.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs
 KVM actually supports
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, Sean Christopherson wrote:
> On Fri, Apr 10, 2026, Naveen N Rao wrote:
> > -- we may be interested in specific exits, such as AVIC-related exits for
> > some of the tests...
> > Thoughts?
> 
> I don't think we should plan on leveraging per-exit stats for testing purposes,
> as they may never land upstream, and if they do, it will take some time.  E.g.
> even though we find them valuable, I'm far from convinced that what we've got
> implemented internally is suitable for upstream.
> 
> However!  Idea.  For many testcases, we don't actually care about *what* exit
> occurred, only if *an* exit occurred (or not).  I.e. tests really just need a
> binary yes/no signal.  Which we _almost_ have today, except stat.exits is polluted
> with exits that are host-induced/owned (e.g. IRQs and NMIs) and/or asynchronous
> in nature, e.g. the VMX preemption timer (which is arguably host-owned as well).
> 
> If KVM provides a stat that increments only on exits that are the direct result
> of a guest action, then we can use that in selftests to detect unexpected (or
> missed) exits, without having to worry about false failures due to noise from
> host IRQs/NMIs/SMIs, etc.
> 
> The hardest part is probably figuring out a name :-)

Gah, wrong once again.  Because to actually detect the bugs here, where KVM
misconfigures the x2APIC MSR bitmaps, the selftest needs the exact exit reason
so that it can assert that a RDMSR/WRMSR triggered SVM_EXIT_MSR, not
SVM_EXIT_AVIC_UNACCELERATED_ACCESS.  *sigh*
