Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12241A504
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816136; cv=none; b=KLfTwcaZdpdTqDxzD4u3ndaK94kfxOqgC5mn9cxvxPZmho+IfN2USFZR0hF36s7qCGcw8h1whvWuFzXk0cqAPNT4r7sv9cHcExOsZxN95H4JGYCGRgh+xMDoGTpsFUbnLYyZb6lUbPkxWvgBfMfPeWGQsJ/dP3fkFHRLE+K6xaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816136; c=relaxed/simple;
	bh=LwlnfmryNLUiq/trLBK3d+00bns2hRhlmS87KJfHxfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sMqcaRzD3PG2bxWdNoXUFpsuleQHnOFiBwDWRiqeYdmYgx8SHClBn5h4sdvRL6UfIQfItJjM+mBsxte+iE+UBhcPoovD8wcWkkxsNR/XZObI04D7QVm8nZ2uwGGAUfQLEcVlWKfSyC1Ze5PreMZtFjlHJEpaZmN1PGgWmY/Alg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yk4Gorhs; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yk4Gorhs"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so932575a12.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784816132; x=1785420932; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IdKLpdhf7OEu5IcSAmfJueDGfqCP8A2L66+eqcZ3JVs=;
        b=Yk4GorhsMkBX+Mp4KUOZdTZtCk/9bzuPtXVTKC7WCBlaD+owhTt9JWyP5GlMHPvnob
         0SY1xNshVfU92fRvtbp824A9JTyyRPQC2LpO5A7sebhbecC1msXnD0JcMepW7n10D/gh
         Tjvqq2rIM1iJOCJYkuPYQRc6eHXY/omtzIJBn2DQS6snLYnplq9jX0v/w0JyFr+WAeh9
         gSEZONh0HF+XuxkSvXd20Q1/J61yVUzRqtn3xecIiLW87Y9xKDCn33p4nhaF0otPSlBa
         Wezt8GUWKrtQovxueErCvznkAlFl2cC/B0pgLsKnB09u4Wk+0V08UZ20h92IYmwaBIzv
         HL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784816132; x=1785420932;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdKLpdhf7OEu5IcSAmfJueDGfqCP8A2L66+eqcZ3JVs=;
        b=ZCp77x2Y0EGFsspt622EpkkSduZYiIIqd9ik+KAZekstQMkOrradoXEI0CVRCWLdBR
         /aGVTBUBNveoTWfQqPe1cDJEaFrN41fAzv0vt5xBOgKFjdMop6MGPFHyFlTnKc/BYk6i
         PbdsvP7U+S+wPDWQmKmKeU1CPFMY+YsOERFnrvp7LOffmj6t+JXsrsufkIUc23mEsitW
         L5e9YczclOeUKQMVojuNZvDDYgVS1xyLZtK26l3rMUiz1zUHYZSN/Qc++rPXPIlTuDVS
         suseZBGaQ5jYvnXqBAi+CsdwxGGqMfoSpLLN5hO97+CO6eU28Z5SK3ktDkBWBPrhMhAG
         qRCA==
X-Forwarded-Encrypted: i=1; AHgh+RrM6/UQWMdIVwq6ItPdNnHLJD7FkKYunVw5LibXgiMQ9YAFLh6/Ok8qklu+B6sxhy+OX5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0cMhdtQW/PHUoubmcwwrmP3MODZiFdDniuZwk2rEGX3jpHw7
	ZVvKbo/iEkt180/nlIE3bHmbe3ui6c6b4vkhU0RRuZSBqBGLZsjH6bnhO7bzZmSr6xho/Fk/QKT
	xIDw0aQ==
X-Received: from pgah7.prod.google.com ([2002:a05:6a02:4e87:b0:c94:9604:c8da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a89:b0:3c0:b766:74f4
 with SMTP id adf61e73a8af0-3c44b04cc2dmr3887971637.31.1784816131736; Thu, 23
 Jul 2026 07:15:31 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:15:31 -0700
In-Reply-To: <amGfcbuCuWpd_D9c@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-5-yosry@kernel.org>
 <amFgEO8NnEql1MmC@google.com> <amGfcbuCuWpd_D9c@google.com>
Message-ID: <amIiAxXkbNKV9BDn@google.com>
Subject: Re: [RFC PATCH v2 04/25] KVM: x86/mmu: Support specifying a minimum
 TLB tag
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> On Wed, Jul 22, 2026 at 05:28:00PM -0700, Sean Christopherson wrote:
> > On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > > In preparation for using the TLB tags allocator for SVM, which has a
> > > range of ASIDs allocated for SEV/SNP, pass in a minimum TLB tag when
> > > initializing the TLB tags allocator. The bitmap is conceptually shifted
> > > such that bit=0 corresponds to tag=min.
> > > 
> > > Specifying the minimum value during initialization also makes the API
> > > clearer, as the passed number of tags becomes the actual number of
> > > *usable* tags, and tag=0 is explicitly excluded by the caller.
> > > 
> > > No functional change intended for VMX as VPID=0 is not used anyway.
> > > 
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/mmu.h     |  2 +-
> > >  arch/x86/kvm/mmu/mmu.c | 38 +++++++++++++++++++++++---------------
> > >  arch/x86/kvm/vmx/vmx.h |  3 ++-
> > >  3 files changed, 26 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > > index 9a2916012cbff..cfffee92b8b71 100644
> > > --- a/arch/x86/kvm/mmu.h
> > > +++ b/arch/x86/kvm/mmu.h
> > > @@ -337,7 +337,7 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
> > >  
> > >  typedef unsigned int kvm_tlb_tag_t;
> > >  
> > > -int kvm_init_tlb_tags(unsigned int nr);
> > > +int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr);
> > >  void kvm_destroy_tlb_tags(void);
> > >  kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
> > >  void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index e021ed562502f..bf2e0c2205631 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -8197,24 +8197,26 @@ static struct {
> > >  	spinlock_t	lock;
> > >  	unsigned long	*bitmap;
> > >  	unsigned int	nr;
> > > +	kvm_tlb_tag_t	min;
> > >  } tlb_tags;
> > >  
> > > -int kvm_init_tlb_tags(unsigned int nr)
> > > +int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr)
> > 
> > Hmm, I think this code should handle "nr - min" instead of requiring the caller
> > to do so.  Because people that know how SEV+ works, but aren't familiar with this
> > code (like I am right now), will probably find it confusing that nothing in here
> > appears to account for the "reserved" ASIDs.
> > 
> > Maybe this?  With documentation that reserved ASIDs start at 0, inclusive, and
> > are contiguous.
> > 
> >   int kvm_init_tlb_tags(unsigned int nr, unsigned nr_reserved)
> >   {
> > 
> >   }
> 
> So essentially make the reserved tags included in 'nr', and min becomes
> nr_reserved. I wanted to keep it generic by not factoring in the assumptions
> about the reserved tags, 

Eh, by having a @min you've already lost that battle though.  It's only "generic"
in the sense that it obfuscates why there is a minimum in the first place.  E.g.
if SEV+ used ASIDs starting that the top and counting backwards, taking only the
min wouldn't suffice.

> but we can revisit later if ever needed (very unlikely).
