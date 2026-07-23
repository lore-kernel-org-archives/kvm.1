Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3D3EDAD9
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840918; cv=none; b=K49lTfpdLIaUuE1E3JxlHRA5uyDk9Eg3INCkPWdXDfPGczDKGe4CtwdthFvCHGAImxJFjzxuK2G0EMFh8C86H/lSoUIJlGovmdXJXpC30RV0Ufa884aicahdWTw+5K33zDB+tF5kYYd32xz1rc058o0EEva4dews2ndzGj4YDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840918; c=relaxed/simple;
	bh=Oe1WJ5+lIknvXuN76Ycbl24v1fU74BoK1ZMumedRoYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FxZv03aCMULTi1poZd+XPOW2n61Leqx96XTWI511yCQki0FvB5Lo1PgcE0IRyNB/cLFhAmrFjglajB0eSdEhI1vYJ6qAvMl6W1q4TCL6PEIiejAjUSXrkwNRyqmz+/rwq2G3n78yElV+qxe+eccS/DVOlqB9BdTSNL3huPzzOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQ4SYHHy; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQ4SYHHy"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848568a6f62so1794493b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840903; x=1785445703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RCq5ylNViQZe7QiR/An1zWgvOhWD8/7z9Gv+AFo257c=;
        b=RQ4SYHHyqWE06N5qe2DU/NPcUxoAzKmFlg+yb/LsyplM1/B6UhC4yVRghMyasHOlpU
         oJjzwjeAa2KQfQRk2fOOeKJJ7JgSJDZ2+aQCES3NumKv2JS/dGE4tZhRJ50I9KLYntDJ
         NSww/Duj+dS9iwpf6CoVH6kPwcF5ju4x0HQz6c+Bwaf0Kmevp1PWYIFJzdkIhOUQ85DS
         D7JUMvyWcDBWBd1sGfmYCZBn2+wxycFjyAeYxnsB7TQeouCJBqvxw5G3+p6NqCwPkl57
         eVWlVLGcGJGBnXYj400ZiDbD38WEK22uSX8h85GzalKLfXpoqWmAZG3M1EnvUGJb1uIw
         UiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840903; x=1785445703;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RCq5ylNViQZe7QiR/An1zWgvOhWD8/7z9Gv+AFo257c=;
        b=cu9rgMRImEgzUq/EKCSguppvKCiHu8izGfd+nvPehvJQ2UYrSv0EOm7y2/QmyVvXst
         WOvQTAi9II5soijCDzhbfwrK/B5yFOFMtJCiz3LbBrFv4GEbjclA8lNIX7R/MoaaLMQ5
         3w1TF4Sl05+3/GpbiI0rtOB/BGYmWvj/HxgZ5iqx7RSwhDz1hrjc302YU9ifs5L16vAV
         qRCNEL4qwbkcbLz4Xhaic+L2ymw5Z1lNMWiSNVJF8l9CdB+2VALCxS/30iOuIjHiR3gM
         cdBNZA3uOJ7c3iJhpLiuUoK9zLNswkRY0sgq4KlPwz5jzsaGyjJIVQG4OcXAsRkPWWtg
         CrVw==
X-Gm-Message-State: AOJu0Yw23LvlNvNIijqxgheI9OAc7AItX096J9dx2nK+pjf4ifYhj6hg
	Rw4qlzSIJbX4TViDM5HyOr9D++fNzLcdMxF7tHYk7K2ZdP37dWUAz7C6ZQgyqvyDBNIi19wEGw+
	94QSnPA==
X-Received: from pfbhm24.prod.google.com ([2002:a05:6a00:6718:b0:847:9805:8254])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:390f:b0:845:d274:bf88
 with SMTP id d2e1a72fcca58-84e2bb37181mr5398153b3a.49.1784840902783; Thu, 23
 Jul 2026 14:08:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:11 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-10-seanjc@google.com>
Subject: [PATCH v6 9/9] KVM: guest_memfd: Make private exactly what can be
 mapped on page fault
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

When calling into arch code to make the underlying memory private, i.e. to
assign memory to the VM in SNP's RMP table, assign/convert *exactly* the
range of memory that can be mapped into the guest for the current page
fault, instead of aggressively converting/assigning the entire folio.  For
SNP, the mapping size in the stage-2 page tables (Nested Page Tables, NPT)
must be at least the size of the corresponding RMP entry, e.g. assigning a
2MiB mapping in the RMP when it can only be mapped at 4KiB granualarity
will ultimate result in another page fault (#NPF for SNP) to "smash" the
RMP down to the correct mapping size.

Assigning the entire folio was necessary back when guest_memfd tracked
preparedness, which was done on a per-folio basis.  At the time, it made
sense to do per-folio tracking/preparation, because tracking per-folio
meant guest_memfd didn't need to add a separate data structure to track
that information, and doing per-folio tracking only works if the entire
folio is prepared (or not).

Now that guest_memfd no longer does preparation tracking (see commit
8622ef05709f ("KVM: guest_memfd: Remove preparation tracking")), in favor
having SNP query the RMP, per-folio preparation, i.e. per-folio conversions
to private, doesn't make any sense.

*If* SNP allowed the RMP size to be greater than the NPT size, then
per-folio conversion could theoretically provide marginal value, as it
would allow KVM to assign a hugepage in the RMP even if it can only be
mapped into the NPT with a smaller page, e.g. because of memslot alignment.
The documentation of that reasoning would be something like this:

  /*
   * If the memory is private from KVM's perspective, and hardware tracks
   * VM-assigned private memory in a dedicated data structure, i.e. not
   * in the stage-2 page tables, then call into arch code to assign the
   * entire folio to the guest.  Assigning the entire folio, e.g. instead
   * of only the memory being mapped into the guest, allows KVM to assign
   * an entire hugepage of memory in the out-of-band structure even if
   * KVM can only map a smaller page size into the MMU, e.g. because the
   * gmem hugepage is spread across multiple memslots.
   */

But even *if* a future SNP implementation supported that behavior, the
value added would be dubious, as having a huge folio that is fully private,
but can only be mapped at a smaller granularity, would be rare.  E.g. maybe
for memory at the top of lower DRAM that has holes for non-RAM assets?

So, convert/assign exactly what guest_memfd allows the caller to map to
simplify the guest_memfd code and provide a (super) minor performance
optimization for SNP.  E.g. once hugepage support comes along, guest_memfd
will only need a single flow to compute "how much memory can be assigned
and at what size".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 53 ++++++------------------------------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 255860c472ee..0bca42a0b346 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -70,50 +70,6 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
 	return !kvm_gmem_is_private_mem(inode, index);
 }
 
-static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
-				    pgoff_t index, struct folio *folio)
-{
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
-	kvm_pfn_t pfn = folio_file_pfn(folio, index);
-	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
-
-	return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_nr_pages(folio));
-#else
-	return 0;
-#endif
-}
-
-/*
- * Process @folio, which contains @gfn, so that the guest can use it.
- * The folio must be locked and the gfn must be contained in @slot.
- * On successful return the guest sees a zero page so as to avoid
- * leaking host data and the up-to-date flag is set.
- */
-static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
-				  gfn_t gfn, struct folio *folio)
-{
-	pgoff_t index;
-
-	/*
-	 * Preparing huge folios should always be safe, since it should
-	 * be possible to split them later if needed.
-	 *
-	 * Right now the folio order is always going to be zero, but the
-	 * code is ready for huge folios.  The only assumption is that
-	 * the base pgoff of memslots is naturally aligned with the
-	 * requested page order, ensuring that huge folios can also use
-	 * huge page table entries for GPA->HPA mapping.
-	 *
-	 * The order will be passed when creating the guest_memfd, and
-	 * checked when creating memslots.
-	 */
-	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
-	index = kvm_gmem_get_index(slot, gfn);
-	index = ALIGN_DOWN(index, folio_nr_pages(folio));
-
-	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
-}
-
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -799,7 +755,9 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
 	struct folio *folio;
-	int r = 0;
+	int r = 0, __order;
+
+	max_order = max_order ?: &__order;
 
 	CLASS(gmem_get_file, file)(slot);
 	if (!file)
@@ -814,8 +772,11 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_mark_uptodate(folio);
 	}
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	if (kvm_gmem_is_private_mem(file_inode(file), index))
-		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
+		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
+					       (kvm_pfn_t)1 << *max_order);
+#endif
 
 	folio_unlock(folio);
 
-- 
2.55.0.229.g6434b31f56-goog

