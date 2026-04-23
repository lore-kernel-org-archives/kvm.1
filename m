Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0182DF15C
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971869; cv=none; b=AQC7yVXDtr+qFXmJhyHMGU7NPDwuXzBY9eszbbLLsXyZk6vimNA6cpBtE3cUdnsKnuyyMJpfTjlgvyyjqAQjgXkorRslfyPZQEBW5WOnguQB7JJMMCh9yNkZvpZ+HGCNuOgJIQBjtD8UBqFQZfCRxilhN0/7LDQflyTbORFPmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971869; c=relaxed/simple;
	bh=h+q+rPfZ3fxPTFrn0/CGwsHCeUWjC4Mvha2QB7l3zNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gpGzYqPMlRtadnlXVoX2RLOV/meGq0KwIFlLXwKiGrAixM2Z9+THm6ljE4n8HbEMnDFluoXHOxkkHLQ7kr88JBgY2oradP4sG2XuIs5EMdO1f08FA1jgjcXUC2bW+ck3jyB6b0zYrzGFNRwJPP32SEk/PlZ/JYdBLY9CDlt7nVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ck3+xXz4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck3+xXz4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c798e905c29so2497482a12.3
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776971867; x=1777576667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZb+2R0MLZfD0BObiG8PtxZPTqEIvA1SAPAkYFxD8fo=;
        b=Ck3+xXz4iHBxRwI4L6eQFg1MUae2wRp8+mH18+03oblXuNeA1Pl5ES5lFMJrLZGMP9
         2t9XKeItO8iKgvSYeeZJ7AyVP1doB+jcy5CohC7P3FwfUFIWvFdODMjsILQaQqm9wOZg
         N0doC4DVcr/wNgxKTj/7Kd/h5E/ZVd4apA8uHIzmhUG891hXgc0ELU1lK5obsuTpm5Ls
         4N29tTrhF1lU5ZsPjVqqpJo8esa6iet/toQUVKnYGswSLTGg684XaKjDQxQ7eyZmrJYj
         fVyim8VdYVXwZ8qFAwYFlSbCe/8tMHY1GbMdcYWgTBncCcRcwxjGdflMlv7AMKxlXeOT
         P0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776971867; x=1777576667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZb+2R0MLZfD0BObiG8PtxZPTqEIvA1SAPAkYFxD8fo=;
        b=ckMlJTc11dPis720Q5vhp2GrtRHFSGwKyFs9rbM0wO1G0KjrlEqhXK82DAXiAijUU0
         B5R9CkW2ubuh9dNQMEFRk3DSRvGu19TSVl+isMgwCtramS2E58m1NncZdkjRDnnQgNfv
         ZsvcjRoMRHLbmDxBLAFxysVW7nZYqW5JOvz+aBOM8YfnrdRt8OPh54gQQSlwPeI3fy1s
         KzEUcoq5ECgphTQ78Qv/9zHzsI60F5IAaz9+bbg+4XvLMlHKc18nzJNBkhh6sGOV/rVb
         nWfovJkTCVD+jgc4+OkOBqEsdeTQYABFqUeUhwhtEdYXJRLbBQyH/3JOGLh2ipmphT1Q
         TKuA==
X-Forwarded-Encrypted: i=1; AFNElJ+rCdZobtudfpTFhGdLAWxkyShEsY+241RGPvBs0XaOfpj4WZPK6sNApKkIVv4b8a7y3J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGT/a9N6yMUfe1FR2NLDIIviPznHmT/7JeO2qIlKxlRdtPlnV
	MPNMie2O3BRoQAJwB4cDuOiZxyTNrB09t7Fx73BEfcURwLG0ioSvCHs1SIy5PEssihv1sPrX6ER
	3eTOP2Q==
X-Received: from pfwy28.prod.google.com ([2002:a05:6a00:1c9c:b0:82f:a201:42c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c5:b0:82f:316:3206
 with SMTP id d2e1a72fcca58-82f8c92997fmr29645641b3a.34.1776971866882; Thu, 23
 Apr 2026 12:17:46 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:17:45 -0700
In-Reply-To: <aekooHTCPGN84ckq@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com> <20260409235622.2052730-7-seanjc@google.com>
 <aegIHrL1pqnRkhDh@google.com> <aegY4FF2n2t5B4pz@google.com> <aekooHTCPGN84ckq@google.com>
Message-ID: <aepwWXMnIFQBiHqA@google.com>
Subject: Re: [PATCH 06/11] KVM: x86: Move kvm_<reg>_{read,write}() definitions
 to x86.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> On Tue, Apr 21, 2026 at 05:40:00PM -0700, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > > On Thu, Apr 09, 2026 at 04:56:17PM -0700, Sean Christopherson wrote:
> > > > Move the direct GPR accessors to x86.h so that they can use
> > > > is_64_bit_mode().
> > > > 
> > > > No functional change intended.
> > > > 
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >  arch/x86/kvm/kvm_cache_regs.h | 34 ----------------------------------
> > > >  arch/x86/kvm/x86.h            | 34 ++++++++++++++++++++++++++++++++++
> > > 
> > > That's a shame, register accessors semantically fit in kvm_cache_regs.h,
> > 
> > Sort of.  I actually had the opposite reaction.  KVM very specifically doesn't
> > do available/dirty tracking for GPRs, in large part because it's not a caching
> > behavior per se: vcpu->arch.regs[] is _the_ source of truth for GPRs (modulo
> > RSP on Intel).
> > 
> > > but taking a step back.. is it even worth having kvm_cache_regs.h
> > > anymore?
> > > 
> > > At some point I needed to move guest mode helpers out of there too (as
> > > they should be):
> > > 
> > > https://lore.kernel.org/kvm/20260326031150.3774017-3-yosry@kernel.org/
> > > 
> > > With this patch and that one, we'd have <200 lines left. Is there a
> > > reason why it can't just be merged with x86.h? I don't see any of the
> > > headers included by x86.h including kvm_cache_regs.h.
> > 
> > What if we go in the opposite direction?  I didn't try moving e.g. is_64_bit_mode()
> > into kvm_cache_regs.h because that reaaaaaly stretches the meaning of "cache regs".
> > 
> > But if we rename kvm_cache_regs.h to something like kvm_regs.h, then I think we
> > can move more of the simpler accessors (and mutators?) into kvm_regs.h.  The
> > motivation would be to keep x86.h from becoming a chonker.  One of the regrets
> > with x86.c is that it became a dumping ground for everything that didn't have an
> > obvious home, and now it's sitting at nearly 15k LoC.
> > 
> > Naming is hard, but if we can come up with a kvm_blah.{h,c} pair, maybe we can
> > kill two birds with one stone?  Or at least kill one, and injure the other :-)
> 
> We can do that, and name it kvm_regs.h or even kvm_accessors.h or
> something. But then we'll sink some time into figuring out what needs to
> be moved from x86.h to that header,

Yes, but it'll largely be one-time pain.

> and we'll occassionally need to move things back. 

Maybe.  I don't think this is likely, so long as we limit the header to including
only kvm_host.h.  If we're at all careful, there should be no need to move things
back into x86.h, e.g. to get access to a structure/asset that's defined in x86.h.

Somewhat related: I've tried, oh so many times, to move stuff out of kvm_host.h
and into x86.h, or some other header in arch/x86/kvm, so that KVM-internal stuff
isn't visible to the external world.  And _that_ is fraught with dependencies
because that are all but impossible to unravel.

I mention that because I do agree that some movement between headers is doomed
to fail, but I don't think that will be a problem here, because what few dependencies
the header would have are pretty much guaranteed to say in kvm_host.h, i.e. there's
basically zero chance of moving key structures/definitions out of kvm_host.h and
into x86.h

> For example, the patch I mentioned above needed to move guest mode helpers to
> update the PMU from there. We may not need that anymore, but I think it's
> possible we run into this situation in the future again.

IMO, it's pretty clear cut that those have no business being in kvm_regs.h or
whatever.  They don't track register state.

> We'll also spend more time nitpicking where new definitions need to go.

Yes, but we'll nitpick random crap no matter what :-)

> I understand wanting to split things up as much as possible and keeping
> the files small-ish, but for headers specifically I wonder if it
> introduces more problems than it solves, specifically because of
> circular dependency issues becoming easier to run into with a larger
> number of smaller headers.

For me, the extra effort is worth it (even though in this case I'm not convinced
the extra effort will be meaningful).  I view it as a "write once, read many" case.

Code is read far, far more often than it's modified.  If we throw everything into
one (or few) giant header, then reading code becomes more difficult.  And so I'm
willing to risk some pain and churn in order to yield a code base is that is easier
to read and understand.

> So my (very unimportant) opinion is still to merge kvm_cache_regs.h into

Your opinions aren't unimportant, quite the opposite.  In general, but especially
for highly subjective things like this, input from others provides a _lot_ of
value.  At the very least, it provides an opportunity for me to explain what I'm
thinking, my motivations, long-term plans, etc.  But more often than not, input
and pushback yields a better end result, sometimes a _significantly_ better end
result.

> x86.h, and we can always revisit later if that starts becoming a real pain.

In theory, yes.  In practice, peeling apart a file is almost always much more
difficult than smashing two or more files together.
