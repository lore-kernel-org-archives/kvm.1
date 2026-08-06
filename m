Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BE42903D
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054913; cv=none; b=DPzH2ylJ9LSB0rUOv7BobLp9jjqfGDNXF59vUvW4GX4TC2JEyWZ3QdAFh77IxRX1r7IH3ux04RCvHS5qlCBrPKFqfVdVdE1spt17Kkd0ZdTHwo63ec8d3qQDp2VNpppIXiX7M6vsZqcyCXvnJAXnNzhzsZC9BSup5z5qEldA/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054913; c=relaxed/simple;
	bh=aW7oIeIP4ZCK+akZGuWexPtRK1UWq9PGrc5ukX6GXr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FX23ZM/thrXaJgpWAevtdiJAozcPfllqIsOnoiKwL8oLqfpnRAPsbXr7mfvDi4mmMH77mfmeUl+1EFpkdGUqc9V01XBR1qa7CBPyCoGG5WZ6/0B+MiYGZuPvgALswv37FSGb/JwneKfJ0Pn+8DGLoLjQKk/htQ4gMaR/S8Y4llU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPZRYiJV; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPZRYiJV"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84842381150so4273211b3a.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786054911; x=1786659711; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gld0ILh0vdHn8FgOPInqNxEGvb4kAfssusuZDeF8P1s=;
        b=EPZRYiJVoyi6nr2hBb1tuCqfeWu1xpcjPbDe7YLTnnSEOKYDLNynmQ07PwUgXAOtAV
         PTpoHzsB0EA/6O4LZv/9Rps7afTZZvNjvrP/K9QNS4apuUMhy27M/xixQxx2ZNuMObgZ
         vZoIjGZ/tz0ImquHwovbcZHEeoCHpeRX5dtQGqoaiVWUo7YXaaCECA1IQsE9WKnCtYob
         49ejtakZBYkTzkYO9cO8Zj+x7e7cFeOiMA2qqRXmd3+h8msv+I8RIWukU3jD06KnsYN5
         sJp0/0YWAYWR8OB7ciOCtwo9ut088lGBaU3ynHbamdDbcdskfjFIKSKlUL+37oEQGcen
         YfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054911; x=1786659711;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gld0ILh0vdHn8FgOPInqNxEGvb4kAfssusuZDeF8P1s=;
        b=k6FSMcP1njxutHJOdIK+CsChpjSq1WloGr7abTit8QdFaIskogUhgILsaZTWbqq3vP
         cxMJODgHx/zRTMEluqujXs3qzTejM/0XJzL1wuw2EPMUVBEkfp/R1yevT+botYrvbhs0
         HCtNHMXOm+MKOP7cLSm8CWoXj0TQzu2+QTfgtR5eDlWQIaB0EbM2Mo47W79S6Z+9Vt1j
         uzz6OdfMGGDVgOB07FqOIZdY3cAufGHXPd3rLh3ZiYb2vK4uEM1styyEZw+xKwFl/rAN
         2FPVAjL+K4s/i8+6rRBLxaPDH9EagX/fhAq6w4aIWW6jvEHHCpeFGx2wcKJPwNYeBZjs
         76TA==
X-Gm-Message-State: AOJu0YwbocMZo9LG1XG7IYqV+cq1hPRqZIa9SbMdyHFUDB6uB3wzuH0b
	OpxmoH3R9CfaHafCy1ycmIKNTDnBPWyc+hT8z9FK1Dc55pwkpuRsxK/YF03EvWjsPi6vQJlFkCW
	PVJ0+Dg==
X-Received: from pfcy7.prod.google.com ([2002:a05:6a00:93c7:b0:845:e683:1287])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c95:b0:845:3033:6cb7
 with SMTP id d2e1a72fcca58-84f2dfc8ec7mr17157522b3a.9.1786054911013; Thu, 06
 Aug 2026 15:21:51 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:21:50 -0700
In-Reply-To: <20260806221418.B08551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-3-seanjc@google.com>
 <20260806221418.B08551F000E9@smtp.kernel.org>
Message-ID: <anUI_nHNrxV044FY@google.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 06, 2026, sashiko-bot@kernel.org wrote:
> @@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
> >  		return -EPERM;
> >  
> > -	r = kvm_mmu_reload(vcpu);
> > -	if (r)
> > -		return r;
> > -
> >  	r = mmu_topup_memory_caches(vcpu, false);
> >  	if (r)
> >  		return r;
> 
> [Severity: High]
> Since mmu_topup_memory_caches() is outside the loop, but kvm_mmu_reload()
> was moved inside, is it possible for the reload to consume cache items
> when allocating new roots?
> 
> If the root is invalid and kvm_mmu_load() allocates new roots, this
> consumes items from mmu_page_header_cache and mmu_shadow_page_cache. When
> execution proceeds to kvm_tdp_mmu_map() expecting fully topped up
> caches, could this lead to a cache underflow and a host warning or panic?

Literally the next patch...

> > @@ -5199,10 +5195,21 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> >  			return -EIO;
> >  
> > +		r = kvm_mmu_reload(vcpu);
> > +		if (r)
> > +			return r;
> > +
> >  		cond_resched();
> >  
> >  		guard(read_lock)(&kvm->mmu_lock);
> >  
> > +		/*
> > +		 * Because slots_lock is held, it should be impossible for roots
> > +		 * to be invalidated after the initial MMU reload.  WARN, but
> > +		 * continue and re-reload the MMU to try and keep the VM alive.
> > +		 */
> > +		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> > +
> 
> [Severity: Medium]
> The comment mentions "continue and re-reload the MMU", but does this actually
> fall through directly to kvm_tdp_mmu_map() with an obsolete root?

Yes, addressed two patches from now.

> If the mapping succeeds, it might return RET_PF_FIXED. This would exit the
> loop instead of forcing a retry. Should there be a continue statement after
> the WARN_ON_ONCE to enforce the retry behavior described in the comment?

Eh, I'd rather hedge in the changelog.
