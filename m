Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9B391E55
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589516; cv=none; b=fDZDoQaq3Z7MhnTEEyvALeWNyovZmb2OJy9UTmfNC7j00MOMlA/p7B+QIls3k2Ew1jV0xkBpVzvIVonOj9XipGpzBVxJrKRgbaW05mQUDd9v3BSzkLkRfyONzpP9qpwaeHek8SyczANWxLp7XtRVnwhIeUZUzdbjjaR6Ei9mwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589516; c=relaxed/simple;
	bh=mm4rYToWN8PDg2Taq6Ny5698HQBxA/e9Kov4gskqGDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpHoujlJvQKOsLTGghsuls6HvP4BnfNNvgYJMQ3kOyyn3lg92oyd+swopvwtIT8qLT+Gm1w2K1o3UAGgTJFKYDJIhgE6tyalBrAjz+rJPfn/vpppICUYGp+4ur5GP26u9cLYHqwxzmsNkTiorFY5gue2d6MTx6/U3xi43U1VD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVPYHxMC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVPYHxMC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc02d28b6so762981a91.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780589514; x=1781194314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma/DewyJFgYgz0xP+3/0017sOureUkpqAC/UR6g35xA=;
        b=SVPYHxMCH3UViZNMfkVGakVXF51G4e1Z27aSQa33Kytnx8+MqPnF+tHAnN5g1Qut6L
         1tkz0mQ+qV3wsgnznTS8Ner77tJ+tX8Tw9bcR95/aT2cSDu7RnOQs68KtRrEf9+nVUnq
         YxSnl9xBLHJ2tCjrVmgBBrtTNfG8R/YCh5pMMmKiOgwrg/m39IlA1VmRPi0QlgNJPkru
         QLe7zyxgjW+TqnvbqMO6i6mcqmdiL0Vwo+Sare+b4rlVHuOnVVEDbBeUcTSXIEsxNfE7
         WAc/HDyQ82ZE+DCtOltOkLAF2WgdbiBt+8gIUbbZjYNsKCu1nrCZyFtEvUA9zAlWkZ8z
         8n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589514; x=1781194314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma/DewyJFgYgz0xP+3/0017sOureUkpqAC/UR6g35xA=;
        b=A3mT4+yu/0wq3BauzCMeroLRu4GdOuiaPsxPr0JjvsQ0eoOkWVI5QEXvQEoyLGkaBl
         BphUojW+J7116V11RiH/iEImgBCuT+e022kNJQkowAOjyY8jxOcVtNQgOhIuFi/M2cSw
         oNdCb56gNZgF0szwQwxfHyPe3hYNmQfC4nst95EeHibrhjM5is9Bt0AEukgexILmRrLe
         mc+XXuaVnfJ9Bh8WGDL1NmjXgkMCCiQ0rgT/wv/AF1Yj+ubSciuwLVNRrYTNNWqke16R
         j568YqCzIXzpjjmRMMsshG3osp/emUfAKueMtqa3rAcwRjfBdWH6O5KhElfOAaorTpiU
         jxcw==
X-Forwarded-Encrypted: i=1; AFNElJ94IRe2iDrXGh6X/EPGwCNCohpUE+ip8/23rsgLP4td9ldWqAD564WPOucE5pgQi4/gEq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwadbtsRqwmmgn4OdwStXI6UcD+2YBHsBp3XNwZW/r00ex2sRGI
	zYg2pBe2gqBHJyr/P7y6waenVDPJr5NTVMJDnuma+/OiEHo851r4gosjeZvrm+n+IlCToBSNUMW
	tPk3M9Q==
X-Received: from pjboh6.prod.google.com ([2002:a17:90b:3a46:b0:36a:fcf5:b57f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f47:b0:367:b8ad:f0e9
 with SMTP id 98e67ed59e1d1-36e30a286cdmr9217648a91.16.1780589513680; Thu, 04
 Jun 2026 09:11:53 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:11:53 -0700
In-Reply-To: <20260604021538.BC1A91F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-12-jrhilke@google.com> <20260604021538.BC1A91F0089B@smtp.kernel.org>
Message-ID: <aiGjyfSpkU8t4_W4@google.com>
Subject: Re: [PATCH v5 11/21] KVM: selftests: Verify IRQs wake up halted vCPUs
 in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The guest code introduces a missed wakeup (TOCTOU) race condition between checking the `done` flag and executing the `hlt` instruction. This can cause the guest vCPU to sleep indefinitely, leading to a test hang.
> --
> 
> commit 9a28612ad82c9a519d18da6d85e17ef536f35e8d
> Author: David Matlack <dmatlack@google.com>
> 
> KVM: selftests: Verify IRQs wake up halted vCPUs in IRQ test
>     
> This commit adds a '-b' flag to the KVM IRQ selftest to verify that
> interrupts correctly wake up vCPUs from a halted state.

s/halted/blocking, to connect '-b' to "blocking".

> If the flag is provided, the guest uses the HLT instruction instead of
> spinning.

Describe the *change* as a command, don't describe the effect of the code.  E.g.

  If blocking mode is enabled, execute HLT in the guest (for x86) instead of
  simply doing cpu_relax(), blah blah blah.

> > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> > index 90cff165c3512..671338f0e6122 100644
> > --- a/tools/testing/selftests/kvm/irq_test.c
> > +++ b/tools/testing/selftests/kvm/irq_test.c
> 
> [ ... ]
> 
> > @@ -43,8 +44,12 @@ static void guest_code(void)
> >  
> >  	WRITE_ONCE(guest_ready_for_irqs[guest_get_vcpu_id()], true);
> >  
> > -	while (!READ_ONCE(done))
> > -		cpu_relax();
> > +	while (!READ_ONCE(done)) {
> > +		if (block_vcpus)
> > +			hlt();
> 
> [Severity: Medium]
> Is there a missed wakeup (TOCTOU) race condition between checking the done
> flag and executing the hlt instruction?
> 
> If the host sets done to true and triggers the final wake-up interrupt
> after the guest evaluates !READ_ONCE(done) but before it executes hlt(),
> the interrupt handler will run immediately. Upon returning, the guest will
> blindly execute hlt() and go to sleep. 
> 
> Since the host only sends one final interrupt per vCPU, does the guest
> need to disable interrupts (e.g., using cli()) before checking the condition
> and use safe_halt() to atomically re-enable interrupts and halt?

Yeah, this is all kinds of broken.  Even if the test passes (I haven't actually
tried this version), there's zero chance it's actually providing the coverage I
want it to provide.

In the interest of landing this test sooner than later, as I *really* want this
coverage, I'll skip this patch and punt on getting a functionally correct version
to the future.
