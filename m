Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94B499F09
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054365; cv=none; b=DSmjEsG6UOex8yKcyBL+dsjSVFRzXoyU0LGzqwjdL5DjFFM1zw0kFZfndg2Gtv9MuMzfQjOv6AjNEUFvJ8CFODOA9oIdRycOilKz35KLyiI28fdmxw5qykV2sBG+OR1EYb4rr3rBn6GFHin1CiE/T0I80uiLUy2FpHBc7RUcz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054365; c=relaxed/simple;
	bh=8sEymD7/iSSj0zqv1j4ytxb+UfXFkVV71wnKB9b9NYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jfe0m1nO/jHNARfHNOqWmzwbqn5d4Y4bhI7dLLOz9Z8NTIWOgK2inZAHVYrh+DL15HBNaWjfRttfxhuUOoPmC1B9Q+B1QSK5hQaCm03tgZFMgRw9Sai3KSueloFHzznG+ufdzI5oxmX38WpapBFzO+JgYdqt7+BGUJKb5feV+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTYD2Psz; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTYD2Psz"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84eccf9d899so3592424b3a.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786054361; x=1786659161; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IORhJ7SeI2tydBbG1Ara4ZQQzv+zNe3W2hPHM+KctrQ=;
        b=mTYD2PszgO+aU/TpcMGSddYOmMeX4pxcl30gTdgcbD/ppe4C0xVnr6zckA1oTielet
         4gUb+DqmLGvvgbXOeEBDyBgzoSBCxjz0u7YTotza3v1OJk09Xaj40wlh4nqFn2SKZLmq
         5QaRkpB3cKSNJxqPqosqfKbl8kOr9sGuSfiGIkcvwR/z2h4X6WWGenRgKHAt+QqtsVSo
         hYUcmKiREc5FpWcVF8FWMK1ZtJlRDxH2AZo1KQjMLt3FdkVw4y9mVjJRJQAsLmow7rrD
         8p9pXHNvqvEKRoiXdgbad53Uf2WVdnEFir3DYr7qK0DlH4qUAXXfx9CL68lvYa9ewPdE
         jFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054361; x=1786659161;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IORhJ7SeI2tydBbG1Ara4ZQQzv+zNe3W2hPHM+KctrQ=;
        b=KMj6sP7HbnQ4+2ep0JIpZi7cY9Ns13yLNP3XS1rS7sw9u5Y7sY+mVHP0EgLtrIqNXc
         9V1oTiKl0t7L6v0q4SYlIfxmuJQvuqY0MI31ZGh1Qa89gaKc5a5dpwjnOiXlg2gl1L46
         E2Vii7cTOtttZ74jYY9JQAXD3gr6mvtd7MItHBTH4HVrE6H7KBG663aEXP29kG9y9h2N
         ugFeyAjbmd49gHGeuewd1SRMAHY6Y4tHXaCxo4kot97Ke4BGhGbfeHH2+mUp2fWdfGhJ
         qubqhdSwhXjX8+41FFbje3chRZI0ghq9GlpaXx4DsPF03rsPapRYfXhVbyx7bgkK9lQy
         IfKQ==
X-Gm-Message-State: AOJu0Yy01ICAEp52PJb35gC7aDgIQGDZAHj35y3YV8W2e75dooc86HQy
	fqvXZ+/BDoCf9F9i5BtRQl0dEcX0q2vI4wnSzhHn3+5h7oCtOsMDHQBAyWlS4NN5jknJlTW3jig
	SrL7QtQ==
X-Received: from pfh25.prod.google.com ([2002:a05:6a00:12d9:b0:845:c4b8:9730])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:986:b0:848:2a71:a48a
 with SMTP id d2e1a72fcca58-84f2dfcfac1mr19558136b3a.13.1786054361372; Thu, 06
 Aug 2026 15:12:41 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:12:40 -0700
In-Reply-To: <20260806215413.537841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-5-seanjc@google.com>
 <20260806215413.537841F000E9@smtp.kernel.org>
Message-ID: <anUG2D2jrXatibSy@google.com>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 06, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 379f570ef04f8..76e3cd717324b 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  		 */
> >  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> >  
> > +		/*
> > +		 * Snapshot the invalidation sequence counter after acquiring
> > +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> > +		 * i.e. any concurrent invalidations are guaranteed to be
> > +		 * irrelevant.
> > +		 */
> > +		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> 
> [Severity: High]
> Does capturing the invalidation sequence after acquiring mmu_lock violate
> the KVM MMU invalidation retry protocol order?

Yes, see the comment and changelog.

> The sequence is explicitly captured inside the mmu_lock critical section
> after the PFN has already been resolved by the caller. This bypasses the
> mandatory generation safety sequence (capture sequence, resolve PFN, acquire
> lock).
> 
> Additionally, could this still cause false positives since
> mmu_invalidate_retry_gfn() checks mmu_invalidate_in_progress?

Yes, it's possible, but it would require zappings GFNs on either side of the GFN
being mapped, such that the target GFN is contained by mmu_invalidate_range_{start,end}.
The odds of that happening in practice are low enough that I'm comfortable eating
false positives even though strictly speaking they _should_ be irrelevant.

> > +		if (is_page_fault_stale(vcpu, &fault))
> > +			continue;
> 
> [Severity: High]
> Does this continue statement inadvertently exit the loop without retrying?
> 
> In C, a continue statement within a do-while loop jumps to the while
> condition evaluation, not the beginning of the loop block. If r is not
> RET_PF_RETRY when this continue is hit, the condition r == RET_PF_RETRY
> will evaluate to false.
> 
> Will this cause the function to exit the loop prematurely and return -EIO?

Doh.  And this is why I'm more than happy to deal with Sashiko's paranoia :-)
