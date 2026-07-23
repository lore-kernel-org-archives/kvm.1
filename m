Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396E4968E8
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820864; cv=none; b=Tz5HLUWbTSVfMcgnCFCFF8F1JZzwNwIgfmpVRmaDR3KBjQghmcu7hZURGSdaA5WktgmlSgHa0D64wR1tiBINb0oBGCsw4EqaQtrrg+BvnIooga2/4syMSxj72s1P9H6ARjQiriT8R+QXIi2m96i3qox8bGqQeWJreSrSs9XbPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820864; c=relaxed/simple;
	bh=YI4hWPAbOT7YNSJ2UWdM5AZsQqEJ5zOz1vYHoT320k0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TPg9fpAk6UyG1+rKWFgTJXhFRzKvB9Nrri70bcCCtvpB/agk/aE9WVBSECTwZi5RHV1I/7bLRQGNxP3A2/GEI59+wlUFzuH/rXIOkyPX9ksmV5pqEtkD8MIfwkgZmR6MHj7GMhSsR9YAlb9moAZlNwHhPWlno/BzwKiecOTioZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nP/yTOl2; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nP/yTOl2"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so19661595ad.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784820858; x=1785425658; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jXOS2yBFB2hrfcZtfpqLJLsuAeRSevvHeZliLjBRJk=;
        b=nP/yTOl2MtXY57THejskkZ6/xvXFNn0LefsW2bFtUcMgIJhm29byIw3AdUs6PXCPaL
         fuNnM7gUQCJsAi8bfby4e4yNZFkYcFI5VLws38kgpN8oT+xeb+Y6vk0tAM4hCm8FMfcl
         eOMLCWruJFrC38tS/V4gFpw9MHhX1dBbdzdcu7lRUs5HmJoV1H6LDDTBCRctIikmzMO3
         e5YaiKMicoY1bK6jt0xJLOtXUOriUB69cPeihRdxUNm/03LB00/FHP+vAbnIuP5NKa0u
         MEYeTyTW///npeP0sE0Y7dmIuDWjxus25Ogpdh0Q8yGCu9ok8zEDlPMdlQun6wg1jJxB
         COhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820858; x=1785425658;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jXOS2yBFB2hrfcZtfpqLJLsuAeRSevvHeZliLjBRJk=;
        b=Cq8mWgpvXbCDf9h1D9FWl07AYBmJ3ebVtR0RWC6LyY2DZ02fCOFJ1Eebg9pqHScgOf
         +f0SZuZ+vGLWWA8tfs7BGrx7KZU2PLUiYWlGXR5mjb7f6EPPGP+zNokkYlGnH4VkIe9U
         iS9ImCE5mPHGsRAitwmQbrcEP0u8N2+kyBgYQFFY/GzhTETcdWUCHCgVLOIKRtPZKub1
         8tyrSEyf4u2ITeAnOB6a4zP4GAfh7dT1PdGNVwBYBZVd443TmfZwjO/y8xersGC1GP3P
         YhRHW727p09vwJGLNqZu4MwOEKgBsyJjO7Tps1LNU5yu2v8mkGDd8WzcfchU/Mo6QeT1
         qW0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrWtmEJJQJ89aU4zXE26U1bgvm4tzww8PHm+eCv1yEqtI2mG8jyBBOpBwh7hA6ahKCXvzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwjGEIi8rMfzWqc9S/E5Zr9Z5WNa6GueFETbk1bwXioP+6Kg8
	r5JwXFsuQJBAeVTiEXEwAgrAZQgoRVglVOCQpBu9AxsL7rDovkX6AhkaDuDT0Nl5j2MeAQQJ5fm
	DB95OpQ==
X-Received: from pgcv17.prod.google.com ([2002:a05:6a02:5311:b0:c93:59ff:8d6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a04:b0:3c4:3321:5009
 with SMTP id adf61e73a8af0-3c44b044febmr4264727637.29.1784820858096; Thu, 23
 Jul 2026 08:34:18 -0700 (PDT)
Date: Thu, 23 Jul 2026 08:34:17 -0700
In-Reply-To: <amG2rkuE5WqldZxM@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-9-rick.p.edgecombe@intel.com> <20260718061050.E17B01F000E9@smtp.kernel.org>
 <1417841720b8435f8fb95ac0bd95be6e0e9390d4.camel@intel.com>
 <amDd1Ip3XTvKSTcb@google.com> <amG2rkuE5WqldZxM@yzhao56-desk.sh.intel.com>
Message-ID: <amI0eRK2Jq6HOroD@google.com>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	Chao Gao <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Yan Zhao wrote:
> On Wed, Jul 22, 2026 at 08:12:20AM -0700, Sean Christopherson wrote:
> > On Mon, Jul 20, 2026, Rick P Edgecombe wrote:
> > > On Sat, 2026-07-18 at 06:10 +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [High] Infinite kernel loop in `kvm_tdp_mmu_map_private_pfn` due to permanent PAMT cache depletion on transient TDX module contention.
> > > > --
> > > 
> > > Our internal Sashiko found this too. It's a false positive as a real bug.
> > > 
> > > Today kvm_tdp_mmu_map_private_pfn() is only called tdx_gmem_post_populate()
> > > during TD setup. It holds the heavyweight tdx_vm_state_guard which grabs vm-
> > > >lock, kvm->slots_lock, and all vcpu->mutex. So there should be no contention
> > > possible.
> > > 
> > > Any potential confusion is not new either, because a similar thing could happen
> > > with the external page tables.
> > > 
> > > But Yan and I were discussing that it would be a good cleanup to fix this anyway
> > > because the reason it is not a functional issue is not clear from the code. For
> > > improved readability (and quieter sashiko reports) the topup can happen inside
> > > the retry loop. Either by moving the retry loop or moving the topup.
> > 
> > Hmm, yeah, I think I agree.  Super duper technically, that's a fix for an existing
> > flaw.  Because very, very, VERY theoretically, the cache of page table pages could
> > be exhausted.  E.g. if some other task managed to free non-leaf page tables while
> > mmu_lock was dropped, thus forcing kvm_tdp_mmu_map_private_pfn() to allocate from
> > its cache over and over.  In practice, that's likely impossible thanks to holding
> > slots_lock, but given that (a) retry should be rare and (b) kvm_mmu_topup_memory_cache()
> > is basically free if no work needs to be done, I don't see any reason to do topup
> > outside of the retry loop.
> > 
> > The other thing we should address is the call to kvm_mmu_reload().  Like cache
> > exhaustion, it *should* be impossible for the root to be invalidated/obsoleted,
> > thanks to holding slots lock.  But as evidenced by the rash of recent shadow MMU
> > bugs, we don't always get things perfect, and lack of defense-in-depth can be
> > *extremely* painful.
> > 
> > I don't think I want to just move kvm_mmu_reload() into the loop, because KVM
> > should provide stronger guarantees with respect to the validity of the loop,
> > versus the population of the caches.  I.e. I want to WARN if the root becomes
> > obsolete after the initial reload.  And more importantly, KVM really should
> > check the validity of the root after acquiring mmu_lock.
> > 
> > We can't simply call is_page_fault_stale(), because mmu_invalidate_retry_gfn()
> > is inherently fuzzy, i.e. could get false positives, even though the pfn provided
> > by guest_memfd is guaranteed to be valid.  E.g. if shared gfns surrounding the
> > to-be-mapped gfn are concurrently invalidated.
> Past you said "No" to checking is_page_fault_stale() [*] :)
> [*] https://lore.kernel.org/all/aPken0s-0MfdSd5o@google.com/

And my reasoning there still stands: there will be false positives, and avoiding
constant false positives requries a weird mmu_seq snapshot.  To be very clear, I
still find the code to be gross, but unfortunately, the onslaught of recent bugs
in scenarios we _thought_ were impossible has made it abundantly clear that, at
least when it's not completely insane, KVM needs to effectively "fail close"
when the impossible happens.  I.e. take action to ensure a bad assumption in KVM
can't be abused to esclate into a DoS or UAF.

> > My only hesitation with manually checking KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is that
> > if more checks/functionality were added to is_page_fault_stale() in the future,
> > then we could end up missing kvm_tdp_mmu_map_private_pfn() and introduce a bug.
> > 
> > Maybe we can have it both ways?  WARN if roots are unexpectedly made obsolete,
> > but fully check is_page_fault_stale() and gracefully handle an obsolete root
> > instead of effectively terminating the guest.
> > 
> > 	do {
> > 		if (signal_pending(current))
> > 			return -EINTR;
> > 
> > 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> > 			return -EIO;
> > 
> > 		r = kvm_mmu_reload(vcpu);
> > 		if (r)
> > 			return r;
> > 
> > 		r = mmu_topup_memory_caches(vcpu, false);
> > 		if (r)
> > 			return r;
> > 
> > 		cond_resched();
> > 	
> > 		guard(read_lock)(&kvm->mmu_lock);
> > 
> > 		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> > 
> > 		/*
> > 		 * Snapshot the invalidation sequence counter after acquiring
> > 		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> > 		 * i.e. any concurrent invalidations are guaranteed to be
> > 		 * irrelevant.
> > 		 */
> > 		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> > 		if (is_page_fault_stale(vcpu, &fault))
> > 			continue;
> > 
> > 		r = kvm_tdp_mmu_map(vcpu, &fault);
> > 	} while (r == RET_PF_RETRY);
> > 
> BTW, since kvm_tdp_mmu_map_private_pfn() is currently solely invoked by TDX
> during the TD built phase, and was introduced to avoid redundant
> kvm_gmem_get_pfn() calls in the gmem population path, are there any foreseeable
> future users of kvm_tdp_mmu_map_private_pfn()?

Nope, not that I know of.

> If not, could we simply drop the RETRY loop, given that the locks in the TDX
> path already guarantee that a RETRY error will never occur?"

We could, but I don't think that buys us much, because we still need the
is_page_fault_stale() check, or an equivalent.  At that point, removing the
retry loop is probably a net negative, because it could be the difference between
a race resulting in a WARN but an otherwise usable VM, and an unintentional guest
DoS.
