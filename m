Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DF358372
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782423950; cv=none; b=Hr/MTvudiPUdg7KaaxpvS61aXRGpvjBRDGEAkgpJorS4seZ0ndDkzSfJIZ8scExBeXmNf3rWwzp8XTnBhLSviszdGb7PsdoYVCFWBmHSHXFUPPCnafauL6a2R1o7dX1eOsTPEqt6o1rfHBcYKvqhu5gGJi4j1mdbphfVPVmt7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782423950; c=relaxed/simple;
	bh=R695RNKosz53FgQpxHNo3CW1d1pFwQ7ud5ZvpBjzuJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKGUQFMoCUIxaL5PbIYVbnG/zga1kzyO70XpaDd+Q0FXOfMb/fXJY08eS+wi0kMQ/G+LYCm0VfMWAB9wkgk8vwFEMWb6JPrjRz9FCO6tidOHLxGkQgEjtnfggU3u4l8FMKqs09dkTMsWXE84aEDKTjSDTcLDjOlVpMk2VI7ldcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSZHMyvK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSZHMyvK"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c89956023dbso160264a12.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782423948; x=1783028748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLKv2w/oZldsKRU7x2mvxBStpob28cqfWxBp8cLvb0Q=;
        b=RSZHMyvKuXxhtdaUczjj5Gjgf6qmydvLtzixBHQmGCvH/lnWkt8B862Y8NE7953V3l
         XYN+eG0/x7wPIA5eFbkfAqyyNmV6ZKro2NRFsP39JYdZLrCf2HOkPsOFvQ7qRuqoVfHf
         73+CzcqUwrPRO0G6Q98VfN1yOCxoWe/AkrXFEUpo49GQS7iRSsOQ55RJodTbrBxI7/un
         7vRYkMRx68AqeUodrrvQVie7CX//oQSD8o4r/l9N9RFSCHEgJqCJ/gYZDkiPcVXb5pWJ
         upK5k9bu1A+u0qhNRmGLNJlW5w+WfyT6o8ifbluNkl69cAAAsXXTK/dYsIG2+cYrcdVF
         iDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782423948; x=1783028748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLKv2w/oZldsKRU7x2mvxBStpob28cqfWxBp8cLvb0Q=;
        b=jsYqMirnhja5O2slO0Db7jzZSr2RwgOo7lrEOG6EMAQSGqKegQS65z4wY1VzSK/XUa
         ZvGxAoEVAdeCyQ/HY1p70e1DzXC5v211Rp42ncZsmxoYVkj/NxeONEhX5rDsucaVpnzO
         o+9+bKsctoqjLQ7ZmO+9QWXUXxiaA26SB9jZ5hCL5SmwBvp/nyQjrR4dVB8lG6Gal0Jk
         m4C5FNaRy/SxJJ43MLnT4vY0mSWHSXBKIr127JSj+IG7gEW5rX+Tx/ugBSoc82D43pjR
         O4C2E/bOBOYYMNnAoNpWvQ5SRuui72ud/oEGxHi3eYhBtW5nm8iTYz+EYSWLcjcwFPvP
         z8Hw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4AEpjtBTAzb9eFHDybcC4ynwc/PSM7Rwa8O2ZOiggcWO3N5OihR9GZXrgHeXKM5SipeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNAx93S8cDbk088weB6OPjp6IrkXzInWyOVycLK1WxJxOkbyj
	gg6ESav4lqKuvpVANPaaeNZRDUyxKdb3+2OHBihHlNuxFbZO2dIbftXYrQN5I5iQOsJCLi/Hu5I
	POhyRkw==
X-Received: from pfbfj39.prod.google.com ([2002:a05:6a00:3a27:b0:82f:8cba:4285])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:464f:b0:842:2f09:fde9
 with SMTP id d2e1a72fcca58-845b39afe3emr5212047b3a.8.1782423947743; Thu, 25
 Jun 2026 14:45:47 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:45:47 -0700
In-Reply-To: <20260520111325.693807-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520111325.693807-1-aha310510@gmail.com>
Message-ID: <aj2hi-NcqUUCaoQF@google.com>
Subject: Re: [PATCH] KVM: pfncache: track HVA invalidations for HVA-based caches
From: Sean Christopherson <seanjc@google.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Paul Durrant <pdurrant@amazon.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 20, 2026, Jeongjun Park wrote:
> HVA-based gfn_to_pfn caches are not necessarily backed by a KVM memslot.
> When an MMU notifier invalidation targets such an HVA, KVM's global
> mmu_invalidate_seq is not guaranteed to change because that sequence is
> advanced through the memslot-based invalidation path.
> 
> This matters during hva_to_pfn_retry(). The refresh path temporarily
> marks the cache invalid and drops gpc->lock while resolving the HVA and
> creating a kernel mapping. If an overlapping HVA invalidation completes in
> that window, the notifier may observe gpc->valid == false and therefore
> leave no state behind for the in-progress refresh. For an HVA outside all
> memslots, the refresh cannot rely on mmu_invalidate_seq to detect the
> event either.
> 
> To prevent this, we must add a per-cache HVA invalidation sequence.

No, there are multiple ways this could be handled.  Instead of saying "we must",
state what change is being (as you did below), and then briefly explain the
alternatives and _why_ the chosen approach was deemed to be the best approach.

> Bump the sequence whenever the cached HVA overlaps an MMU notifier range,
> regardless of the current valid state. Snapshot the sequence before
> dropping gpc->lock in hva_to_pfn_retry(), and retry the refresh if it
> changes before the new mapping is published.
> 
> Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com

Given that there's no reproducer, how did you test this?

> Fixes: b9220d32799a ("KVM: x86/xen: allow shared_info to be mapped by fixed HVA")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  include/linux/kvm_types.h |  1 +
>  virt/kvm/pfncache.c       | 42 ++++++++++++++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index a568d8e6f4e8..ff3b8aa73561 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -85,6 +85,7 @@ struct gfn_to_pfn_cache {
>  	u64 generation;
>  	gpa_t gpa;
>  	unsigned long uhva;
> +	unsigned long hva_invalidate_seq;
>  	struct kvm_memory_slot *memslot;
>  	struct kvm *kvm;
>  	struct list_head list;
> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 728d2c1b488a..296b06482ebc 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -19,6 +19,24 @@
>  
>  #include "kvm_mm.h"
>  
> +static inline bool gpc_uhva_in_range(struct gfn_to_pfn_cache *gpc,
> +			      unsigned long start, unsigned long end)
> +{
> +	return gpc->uhva >= start && gpc->uhva < end;
> +}
> +
> +static inline bool gpc_should_invalidate(struct gfn_to_pfn_cache *gpc,
> +				  unsigned long start, unsigned long end)

Rather than providing a "should invalidate" helper, which is makes it difficult
to understand the conditions for invalidation, i.e. requires jumping around the
code base, I think we should provide:

  static bool gpc_hva_is_valid(struct gfn_to_pfn_cache *gpc)
  {
	return kvm_gpc_is_hva_active(gpc) || gpc->valid;
  }

and open code the start/end checks.  We could keep gpc_uhva_in_range() (but drop
the 'u'), but IMO it's not a net positive.  E.g. yield:

		/* Only a single page so no need to care about length */
		if (gpc_hva_is_valid(gpc) &&
		    gpc->uhva >= start && gpc->uhva < end) {
			read_unlock_irq(&gpc->lock);

Which, for me, makes it easier to understand _this_ flow.  I might have questions
about what constitutes a "valid hva", but I don't need to learn those details to
understand the invalidation flow.

> +{
> +	if (!gpc_uhva_in_range(gpc, start, end))
> +		return false;
> +
> +	if (kvm_gpc_is_hva_active(gpc))
> +		return true;
> +
> +	return gpc->valid && !is_error_noslot_pfn(gpc->pfn);
> +}

>  /*
>   * MMU notifier 'invalidate_range_start' hook.
>   */
> @@ -32,8 +50,7 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
>  		read_lock_irq(&gpc->lock);
>  
>  		/* Only a single page so no need to care about length */
> -		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
> -		    gpc->uhva >= start && gpc->uhva < end) {
> +		if (gpc_should_invalidate(gpc, start, end)) {
>  			read_unlock_irq(&gpc->lock);
>  
>  			/*
> @@ -45,9 +62,11 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
>  			 */
>  
>  			write_lock_irq(&gpc->lock);
> -			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&

Unless I'm forgetting/missing something, it should be impossible for gpc->pfn to
be garbage if gpc->valid is true.  As a follow-up patch, turn that into a
WARN_ON_ONCE()?  Assuming I'm not missing something...

> -			    gpc->uhva >= start && gpc->uhva < end)
> +			if (gpc_should_invalidate(gpc, start, end)) {
> +				if (kvm_gpc_is_hva_active(gpc))
> +					gpc->hva_invalidate_seq++;

Hmm, I think I would rather just add a per-gpc mmu_invalidate_seq and drop
usage of kvm->mmu_invalidate_seq entirely in the gpc code.  Well, if we can get
this working, which I'm not sure we can without a pile of surgery I don't really
want to do.

  CPU0 (hva_to_pfn_retry())     CPU1 (invalidate)
  -------------------------     -------------------------
                                invalidate_range_start()
                                mn_active_invalidate_count = 1
                                hva_invalidate_seq = X
                                write_unlock_irq()

  write_lock_irq()
  gpc->active = true
  gpc->uhva = A
  hva_seq = X
  write_unlock_irq()

  pfn = Z

                                invalidate_range_end()
                                mn_active_invalidate_count = 0

  mn_active_invalidate_count == 0
  hva_seq == hva_invalidate_seq

  use-after-free

In other words, the mmu_invalidate_seq scheme requires that the sequence counter
be incremented in the same critical section as mmu_invalidate_in_progress.

Note, the current use of mn_active_invalidate_count is "fine" because it outlives
mmu_invalidate_in_progress, i.e. mn_active_invalidate_count achieves the "same
critical section" rule by proxy.

We could add gfn_to_pfn_cache_invalidate_end(), but I really, really don't want
to add more serialization to the mmu_notifier flow when it's all but guaranteed
to be unnecessary.  And we can't optimize it to skip bumping sequence counters
if gfn_to_pfn_cache_invalidate_start() doesn't detect relevant GPS, unless we
block GPC refresh while mn_active_invalidate_count is elevated, as is done for
memslots, otherwise KVM would incorrectly skip bumping counters if a GPC becomes
relevant after the fact.  And blocking memslot updates is a bit of a disaster
because it's inherently unfair, and that's for a path that's already slow.

Oh!  But we can simply piggyback mn_invalidate_lock and use a per-VM GPC sequence
counter, then the end() path doesn't need to re-walk GPCs.  That will regress
GPCs in the presense of unrelated mmu_notifier events, but we already know that's
a lurking problem, and we know how to fix it[*] (I think).

There's a "sleeping while atomic" problem that will occur on RT if/when GPCs take
mn_invalidate_lock when refreshing the PFN, thanks to IRQs being disabled, but
that's not a problem until we implement the range-based optimization, because
until then, the reader side can be lockless.

[*] https://lore.kernel.org/all/Zw8DINUkJJKDByXE@google.com

Not yet tested, and I think I'd want to land this at the same time as the
range-based optimzation, to avoid regressing "normal" GPC usage (only AWS uses
the HVA-based Xen API, so getting a fix to LTS kernels isn't a priority, AFAIK),
but this?

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0bdfa3699352..d07e3cbff983 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -854,6 +854,8 @@ struct kvm {
        gfn_t mmu_invalidate_range_start;
        gfn_t mmu_invalidate_range_end;
 
+       unsigned long gpc_invalidate_seq;
+
        struct list_head devices;
        u64 manual_dirty_log_protect;
        struct dentry *debugfs_dentry;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 98da4c889ffc..5c2e92e4a085 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -812,6 +812,15 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 
        /* Pairs with the increment in range_start(). */
        spin_lock(&kvm->mn_invalidate_lock);
+       kvm->gpc_invalidate_seq++;
+
+       /*
+        * As with the MMU sequence counter and mmu_invalidate_in_progress, the
+        * GPC sequence increase must be visible before the invalidate count
+        * goes to zero.  Pairs with the smp_rmb() in gpc_invalidate_retry().
+        */
+       smp_wmb();
+
        if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
                --kvm->mn_active_invalidate_count;
        wake = !kvm->mn_active_invalidate_count;
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..a427daea986f 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -124,7 +124,7 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
 #endif
 }
 
-static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_seq)
+static inline bool gpc_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 {
        /*
         * mn_active_invalidate_count acts for all intents and purposes
@@ -142,14 +142,14 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
                return true;
 
        /*
-        * Ensure mn_active_invalidate_count is read before
-        * mmu_invalidate_seq.  This pairs with the smp_wmb() in
-        * mmu_notifier_invalidate_range_end() to guarantee either the
-        * old (non-zero) value of mn_active_invalidate_count or the
-        * new (incremented) value of mmu_invalidate_seq is observed.
+        * Ensure mn_active_invalidate_count is read before gpc_invalidate_seq.
+        * This pairs with the smp_wmb() in
+        * kvm_mmu_notifier_invalidate_range_end() to guarantee either the
+        * old (non-zero) value of mn_active_invalidate_count or the new
+        * (incremented) value of gpc_invalidate_seq is observed.
         */
        smp_rmb();
-       return kvm->mmu_invalidate_seq != mmu_seq;
+       return kvm->gpc_invalidate_seq != mmu_seq;
 }
 
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
@@ -232,7 +232,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
                 * attempting to refresh.
                 */
                WARN_ON_ONCE(gpc->valid);
-       } while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
+       } while (gpc_invalidate_retry(gpc->kvm, mmu_seq));
 
        gpc->valid = true;
        gpc->pfn = new_pfn;

