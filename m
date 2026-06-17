Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5923FE677
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731265; cv=none; b=VeJ6uFtVajPyvKn4eoCIWNcEq2xU32/nSZ+sxB+Eaod6N+MFqLve2hjT940oFVD36wlktxPD4su2/4CQYxvJAfp7Da4KWAT+rfG4gr64xcjt+B2ev1APet2mkqw60OtqkgwqYko58VV5b95SOjJ2ENNuJU8pV0MBdPcFMflO6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731265; c=relaxed/simple;
	bh=atB3bgHAvDtmY92Rap1LsxpecyU+4Ejr8Mpz7VCogVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqIUc8WCNCfZYLOMEBEbNLpU4eWG6951IJUYhmpaD5XbM7nr48Jby4xQT93EltPZCKM7cZ3DYldeANS9gy+eia3GjLyAgdSO165TFfWWsMtdRCz6gsug4C7XXnuLz9WGzMhfNI/EGXYDX2tKl6nAw1kqrzMpfs95YAq2bG2XSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHegD52m; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHegD52m"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so226106a91.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781731263; x=1782336063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9Yqm4tffKg4e29hqMAX+T2CRy/ICARHYsUqtEuY7U=;
        b=aHegD52mG32N/8V2sdUJKFpMd7HRDS5uskOtCMARr3KzigTmCTL4RLzioenvm0y7Uh
         Q/ioz4T+jXeBi/goNzaq5NvCZYUMUcWXXWMcAQMlksQnHym68WJaoscoMdUtTKh5eCr5
         ajcGy9jBt7b3AJcW32fJbXVerXQLrysvVgby1gENXzTuSiCT2n93uTmcJjHLWmEgj1Oy
         XyM3cfMPncEyWXeb+U0e65iICZJms2LdAftrPMrNZwWhxcKu4kivd6WAsbB4GeBLbi2t
         7xlhsOHkd0uL94IZLKB24V2j7UiG3WZOc81oh+x20fYvUp9b4+od/lkO2UGOVx9ECU8i
         /Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781731263; x=1782336063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9Yqm4tffKg4e29hqMAX+T2CRy/ICARHYsUqtEuY7U=;
        b=o63QduNSRyV3JYVuCjw5CGLeMcJ4LhXV1dOKRX/EHDP6PPdjh8cobL3bcrm1+mEWhQ
         YRUVzhZi6PHUvRKZg9fqZ/2Rr7cgs2FRAd6JYCKiXfUlVhU4iDrD1mME6jEmf8pyLk84
         1dYovVDQ6UWCBDi5J3zlAzHzfqegG1gSPaI3XpTKPIrYIEx/xtKYfHAseE6/UwA7TF4+
         t3Q6RuIGLOk0zFWACV9Qr632DBKZ+03kWLY4m8GxR0l4a75K9MAHnraaOe+EeJep6Dyi
         aK/MfAyyXRh0y0mH2phKx+IKLHQuTJ4zGdaroHu0T89lzb/cw5bpEPW3VZl25Jsy8/mj
         yjnA==
X-Forwarded-Encrypted: i=1; AFNElJ+1FU/3t67ZUjyjJPTiAsGHACSMVve5waGTAZth04BWwRoMHStK4bVVpBfL3YEg6xaFd5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkTYDL2FXTltDHMWo46TCIOc0pY8MIAGYeylM73P3zFLV55oR
	8mbtNIYg22BymusA/ECAjwDH1VGht30tupbdogd3AYcX+Pr35ezCRoeC+bZhlzB9dHBoYM+LtCq
	lY0rgsg==
X-Received: from pjbpc8.prod.google.com ([2002:a17:90b:3b88:b0:37c:a479:69f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558c:b0:369:73a:326a
 with SMTP id 98e67ed59e1d1-37c9e9c8c91mr4984736a91.13.1781731262980; Wed, 17
 Jun 2026 14:21:02 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:21:02 -0700
In-Reply-To: <ajKcDRqT5m069PXK@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615155244.183044-1-alexandru.elisei@arm.com>
 <20260615160901.9A1A61F000E9@smtp.kernel.org> <ajA6ogaNiI3KDv5i@google.com> <ajKcDRqT5m069PXK@raptor>
Message-ID: <ajMPvgA2eHQCj-B0@google.com>
Subject: Re: [RFC PATCH] KVM: Ignore MMU notifiers for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: sashiko-reviews@lists.linux.dev, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 17, 2026, Alexandru Elisei wrote:
> Hi Sean,
> 
> Thanks for the reply. Just to make sure, once the bugs have been iron out,
> you're ok with this idea?
> 
> On Mon, Jun 15, 2026 at 10:47:14AM -0700, Sean Christopherson wrote:
> > On Mon, Jun 15, 2026, sashiko-bot@kernel.org wrote:
> > > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > > --- a/virt/kvm/kvm_main.c
> > > > +++ b/virt/kvm/kvm_main.c
> > > [ ... ]
> > > > @@ -592,6 +592,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
> > > >  			unsigned long hva_start, hva_end;
> > > >  
> > > >  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> > > > +
> > > > +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> > > > +				continue;
> > > > +
> > > 
> > > [Severity: Critical]
> > > Does this change inadvertently introduce a regression in the pfncache retry
> > > protocol?
> > > 
> > > Looking at the pfncache framework, it maps guest memory into kernel space and
> > > explicitly drops the page reference after mapping it:
> > > 
> > > virt/kvm/pfncache.c:hva_to_pfn_retry() {
> > >     ...
> > >     kvm_release_page_clean(page);
> > >     ...
> > > }
> > > 
> > > It appears to rely entirely on KVM's MMU notifiers (kvm->mmu_invalidate_seq)
> > > to invalidate the cache when the page is unmapped by the host.
> > > 
> > > If a VMM defines a guest_memfd-backed memslot with KVM_MEMSLOT_GMEM_ONLY
> > > but still provides a valid anonymous user mapping as its userspace_addr,
> > > could this regression lead to a use-after-free?
> > 
> > Sadly, yes.  To land this, we would need to first teach the gfn_to_pfn_cache code
> > to be able to pull directly from guest_memfd.  I forget if anyone is working on
> > that.
> 
> I've been trying to wrap my head around this, and I just can't seem to
> figure it out.
> 
> kvm_mmu_notifier_invalidate_range_start(), before handle_hva_range(), calls
> gfn_to_pfn_cache_invalidate_start() for the MMU notifier range, and that
> marks all caches that overlap the range as invalid. kvm_gpc_check() returns
> false for an invalid cache, so how can the memory still be accessed via the
> pfncache?

That just forces gpcs to be refreshed, mmu_notifier_retry_cache() still relies
on mmu_invalidate_seq being bumped to avoid consuming stale state.

> > > By unmapping the anonymous memory, the host would trigger MMU notifiers, but
> > > this new check skips the memslot. As a result, kvm->mmu_invalidate_seq
> > > wouldn't increment, and KVM might retain a kernel mapping to a freed physical
> > > page.
> 
> kvm->mmu_invalidate_seq is incremented in kvm_mmu_invalidate_end(), I don't see
> how that is affected by skipping a memslot in handle_hva_range().

handle_hva_range() only invokes on_lock() if a memslot is found.  By skipping the
memslot entirely, kvm_mmu_invalidate_{start,end}() won't be called and so
mmu_invalidate_seq won't be bumped.

> > > Could this allow the guest to read or write arbitrary host physical memory?
> 
> The KVM_MEMSLOT_GMEM_ONLY flag is set if the backing guest_memfd has been
> created with GUEST_MEMFD_FLAG_MMAP. The documentation for the flag says
> that '[..] the fault will always be consumed from guest_memfd, regardless
> of whether it is a shared or private fault'.  As far as I can tell, this
> means that, absent a fallocate(FALLOC_FL_PUNCH_HOLE) call, the page is
> still in the page cache for the guest_memfd file after userspace has
> unmapped it, so the guest will not be accessing a freed page.

KVM_MEMSLOT_GMEM_ONLY is somewhat misleading, it only applies to the KVM's MMU.
For other cases where KVM accesses guest memory, KVM still follows the host virtual
address, e.g. so that copy_{to,from}_user() Just Works.  But userspace isn't
strictly *required* to keep the userspace mapping coherent with guest_memfd, nor
is userspace required to make the userspace mapping fully RWX.  And so if
userspace modifies the VMA, KVM needs to react accordingly.

When in-place conversion comes along, KVM will also rely on userspace mappings
being torn down before allow a SHARED page to become PRIVATE (for all intents
and purposes, we're conceptually treating conversions as free()+re-alloc().  So
while the page might still be in the page cache, it's effectively been "freed".
So in that case, KVM really does need to ensure it handles mmu_notifier events
correctly to avoid UAF.
