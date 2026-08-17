Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B983420463
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974206; cv=none; b=mRIKQz9MA1JJ/qY+ZU98tH/2zPIKvlC8tuV6cc9DYvMq7dqGdbpOBiHNbYLgFnaXbmMb4LOwnSqtX0iC6mjuVye7LsMTiJLQ9G7WoO/ixieo6ioRmZgcKWE6BFr76ZhQYa4sGgBx9JPaiB20x/Nb37CJlnjrCxDF4MRPAaOwkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974206; c=relaxed/simple;
	bh=nGUqCPUIA9/W35719pUr7m88n4jBlAw7AfoXevJNRZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oEb9oe2mQk0sp2RlFXBwWgrF2iZ7tURLcw06UJ8wc5eF/wqmMOPZOgvIyWxhyF25IehIUGwLcx8ok4QwWqzyI3oFt+SYeQcalKDkdPLKwybfr0F7aN/iGiAUnilwsEmNtKVjN2iawoGUMKb0Kag3nsdpbtpbfXQ1NwzW3bqKXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJ7ooy4l; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJ7ooy4l"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb687f82eso55009925ad.3
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974204; x=1787579004; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g09e9+0hqj+bqdX/ny6rU9L4Tg3OUX3BirEzfANrB4g=;
        b=dJ7ooy4luR4IudIfu9F8no8Oc5WZFskNAjPc1jYZ7l7euEQTIeJ/kQ3sDqvHR9RcFt
         a0rXfbbXRFWMuzERpN6vHwyYkqys1Vg+uH8Ba41koxs7ofD9uETn+V4UJLUOnPCOcXrG
         o1z/4IBJ4CkHTadLmtZENoa6hNYB3riPlei7fBb3/SxJ5EmxLho3OzjsTwrfGTXARzmK
         ajzH4k7f8XLDQwWMVVPIBQtxqBtXx5ttxLxo9IBJnSDScXGL49nCfTe6F94yh/6LcokK
         1ScHmW2xDesTnhNeyl4ZAGiw2JJqk3acHAV9CdjK9Lyp7dxlUJsIqZj244DRboNObjrm
         AHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974204; x=1787579004;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g09e9+0hqj+bqdX/ny6rU9L4Tg3OUX3BirEzfANrB4g=;
        b=fYTDqDmBSS4MaUWu1gvtk0ZJQ8oqvTX9NARZjH/MYv2mfDzsiQNJdpawGe1nSW1Aa2
         17cOwv0R4d9IgJ9PgNVdDdQRzAdu8i6BwD28l5NTRuUxSuKn+0fpGsdcECmLNXAherGB
         Rfw/9jKEED3plyWuEZZOKIZ2rbPHHYQ9EHz5EWefNHOZOwQeLKqFW+YehofLCle754eN
         u+mQQFPpWa6HExwz5WVohf1UcPM9sE3CVTAOStg7+dEv3WkWJElPHeDdZoaljgEXfixk
         pn/l2YTK5z/5F0VXrc5HTZ5YQF2+S/R9RJZs3STECklCnsIs4jMw12Q9IPVbSnANwXvU
         NdKA==
X-Forwarded-Encrypted: i=1; AHgh+RqHLqyyT2L3Kjs9jMp3QIgrwX/o/kkosM8jtlzstkyY26NAed5AcgS6tf4bSZRt6wUOJRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVc1IRkIx2SKdgK7DSAYIxcbW0u8W2sWXd12AT3biPezqANUKU
	eXSBo60/Tlb/t2Ax3tM+6DTLy9SN30IyIlTnwHeCo9mQPQ/UW4/3DuShE0vbpMGFlBCPZ3xOukw
	JESQdWQ==
X-Received: from plbbh10.prod.google.com ([2002:a17:902:a98a:b0:2ca:e163:e0c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2d0:b0:2ca:6c8:abd8
 with SMTP id d9443c01a7336-2d3b0e435bamr318400625ad.12.1786974204293; Mon, 17
 Aug 2026 06:43:24 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:43:23 -0700
In-Reply-To: <aoKv0vneW5hleZ9F@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-5-seanjc@google.com>
 <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com> <antX6NCs4-C_ChXD@google.com> <aoKv0vneW5hleZ9F@yzhao56-desk.sh.intel.com>
Message-ID: <aoMP-1OGrkhtliYz@google.com>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Yan Zhao wrote:
> Sorry for the late reply!
> 
> On Tue, Aug 11, 2026 at 10:12:08AM -0700, Sean Christopherson wrote:
> > On Tue, Aug 11, 2026, Yan Zhao wrote:
> > > On Thu, Aug 06, 2026 at 02:40:50PM -0700, Sean Christopherson wrote:
> > > > Harden the "map private PFN" flow against potentially-fatal bugs or future
> > > > KVM changes by checking for a stale "fault" prior to actually mapping the
> > > > PFN into the guest.  While it should be impossible for the "page fault" to
> > > > become stale, the sanity check is cheap, whereas a broken assumption would
> > > > have a high probability of leading to a guest-expoitable use-after-free.
> > > > 
> > > > Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
> > > > positives, even though doing so completely voids anys and all protection
> > > > against unexpected invalidations.  Pretty much the entire point of
> > > > kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
> > > > gifted by the caller, i.e. the caller would have to mess up its one and
> > > > only responsibility.
> > > > 
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index 379f570ef04f..76e3cd717324 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > > >  		 */
> > > >  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> > > >  
> > > > +		/*
> > > > +		 * Snapshot the invalidation sequence counter after acquiring
> > > > +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> > > > +		 * i.e. any concurrent invalidations are guaranteed to be
> > > > +		 * irrelevant.
> > > > +		 */
> > > > +		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> > > Could you explain more about the conditions under which a fault is stale while
> > > guest_memfd guarantees the validity of the pfn?
> > > 
> > > Given that kvm_tdp_mmu_map_private_pfn() already asserts holding slots_lock and
> > > invalidate_lock, I can't think of one. 
> > 
> > A non-guest_memfd mmu_notifier invalidation bumps mmu_invalidate_seq.  And because
> > the range-based invalidation checks are deliberately coarse, in-flight invalidations
> > could also trigger a false positive if GFNs N and N+2 are being invalidate, while
> > kvm_tdp_mmu_map_private_pfn() is trying to map N+1.
> Could updating fault.mmu_seq in each iteration cause a false negative?

Not really.  I mean, yes, technically it could, but I addressed this in changelog.

 : Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
 : positives, even though doing so completely voids anys and all protection
 : against unexpected invalidations.  Pretty much the entire point of
 : kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
 : gifted by the caller, i.e. the caller would have to mess up its one and
 : only responsibility.

> I may be wrong, as I am unaware of the specific bugs or future changes you
> mentioned below in 'defense-in-depth against bugs and against future changes'.
> Could you elaborate a little more on those bugs or future changes?

There are non, AFAIK.  It's a statement saying "things may change at some point
in the future".

> > > If we add the sanity check because it's cheap, why don't we save
> > > fault.mmu_seq before getting the pfn to guard against stale pfn as well?
> > 
> > Because as the changelog says, the whole point of this API is to provide a stable
> > PFN.  I want to add an is_page_fault_stale() check as defense-in-depth against bugs,
> Ok. So adding is_page_fault_stale() is not intended to ensure that a private PFN
> is stable (i.e., not stale).
> Any background on why we cannot update the code when the bug/future changes
> actually arise? :)

Because finding bugs of this nature after they've been shipped to production isn't
very fun.
