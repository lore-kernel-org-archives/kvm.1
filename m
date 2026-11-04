Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753616;
	b=BVi+U7F2BobLrL9+UkEwLgZoIcI+CKplE/5bweZ5Rpt6OiBYex8OWm5vPOMKZpa30pYL
	 g8R2xricFve1CzWBpl/cTdiicmWIqih+ePViOKf9fMCAePns8R6x5Bmcjsjf5dPhb954I
	 g3ze4QNFgR9exjKepqlDYXPujI4zgs3DDrsi+ovJjYuFeu2EQa0OE6YHeN2vdaVCk5Xjs
	 AnrPnBcUS/aqBv+PlnLczIbaApASh1+f5UPbwAHae1D51FIoNfBfcregHNDJDVHLFTMcT
	 UNiVr/PVSz3X+wlWx+lJE6VIPZUvas6sFjpOmRavaSt3dtClCsFqpUMJNU5AbXC43JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uDc6P16e5tQ1rooADupiFR5ykf48UoP+8OE+oO9j8Bc=;
	b=VfbtVeFxhhpNrn0xuk1ozPHBPN3EpFPaozakOaUAil6uUBkR+k8cfpTgL3CNUruvfRE1
	 d1WqwcuzVpHYg9QXme7SxzVrL7ggG4nCXDTBI4gjRgZciuVO/mExld/R1pYvsN8ztYJPT
	 tp9PHms2xxC4EPOXRjC/j/fO9bPTYzTXTTefb+fJfx68uYDieaOSDlUtqFsi5BXLwwwYN
	 KP+ZSXIyRRLuC+GTHix0wHiNnxCn0+UWWOmT+lUxLyxPQQYF61Mj2WhI5uM63oJT5Mt7Z
	 2psKwoWcSjpqLpUXOEqro6DSwelLEkrD7H0GnG3oQyP1f5OT0fcGospz7MzhGAva57g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RC8BhNeZ;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA41606D816
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DA41606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RC8BhNeZ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so643365e9.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753614; x=1794358414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDc6P16e5tQ1rooADupiFR5ykf48UoP+8OE+oO9j8Bc=;
        b=RC8BhNeZ463s/LzzYMyXiKAbTIJXF+wgKfuB6fEmEhUSrVsjDVYN7ot1yqkpf++aJl
         qk53FGA5e3dZSv75QtS9CgoPUbVjxl8jtyi5OV5yGMGH0oKjDyOEiiiCMxZhJtBlDRhJ
         VzOkFVCKNN0bL/Xt9vCmOUe9T5/e4AGk2Kmo0cT6hLexzQCSHlZVfhqqS6ZPa/YIqmtX
         ksrZ8YkufVTNyiW89LG0c3k/N4f9EvA4+jfsn8DRJSrjDxx1Gw+bg8cLnq5q+tu+ZX/Z
         cvNh5NsGB5RLFnagjW/dXn7kVDTwTNm55i/6PFOSOKaveyNjiv9R2RXxV+2J7SsRY34/
         9mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753614; x=1794358414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uDc6P16e5tQ1rooADupiFR5ykf48UoP+8OE+oO9j8Bc=;
        b=K7OH4dM1VF/Qb/78JAg0qxdTEZqPyifsF1jP3HBwWtaSfZFGncexzd0+l4nscd6HmK
         vFT/6Tz2DwIyhQWKiBH3jAKQhC97Va0/0dxUblOTnNmZ4MD1xJDIUgW+1xmT7ABMetFX
         E7YKafxQ0kssEhcw45dfXo3y3sYIU4kboteKRC4mX3l8aiKs56n2T04xfEsG1LbJvbCx
         q+gUJlwQzafwrU2e/DSOCLeFaku7q/6WE3yRd9LlJ97tWPCt+ybgDO2D2TkMoDlZPill
         izCRbTDDzoY8S/Li+TZoRjTFOMSfKkBIv2ba7glEXYZVVQ8D4EL4uLFlGmPFfg/wtuJJ
         +Cbw==
X-Forwarded-Encrypted: i=1; AKwUvBzv4biae19EsKbsqITYJuCmwkciJOIyjZgzElYITD7SbUk6yO6eOg3PZbiy8puwM1Ov5zY=@vger.kernel.org
X-Gm-Message-State: APuU4Z921O6xdTwE3M1bDA5hc7Es+2IwLKv/vFTpxzFNYw4LrzfezRNo
	AmFjI9rLK/TgEOGN/tmiPBVLZKcOLhJO4/4mdWUXM4Qp+fH7pq5el2GV
X-Gm-Gg: AYBFou1Ee0+t7CSlyUuiTzL3/BzC/ggk+auTa4jf5haPXmwDpYQLFJi6xC5us4s9dlU
	7ZbW42u7DQI6OXt2HsMJQLKBAyPTf/Peg71hIl+FWPLlNvMplEvVI2ZlRjE1hn/pFxOR/jeZlL1
	76V8/QPhfzzAgb7haHGxFLwPCOiUSh+yVlgzuz7JcBEt+Th7m0dNPD1yM1r3J3ZUeBAixfiD7DH
	F1EuFRBRwpDWzeB6+0v9+H/+G9/qnqMB7q/e3gzGj2b1whjWqTOknpjIW9ou+rVxR8W9N2BK3N0
	MZcHniEKeSLkJH8qc0oR/gn1UvqviYVq0SeYmF3O9Vjl3febijktMIYnXt7bBz7bgjG//fuL4HI
	UeT3dY/vpl03tGX/aBtFD09zyOJJY7qn6TO+z2MXL9ZjFRaD3TMrlWZUzlIBDveqNFBDYVgpuk6
	1kAl9qrbE9ObSbIMqNz8LXPbSeFITLlzM/43+m06mWtwV4dSSlzeZanhuR+g9LH8+/1lp4OHQyy
	+nuZ6kTbImMdXtwCL6w6tPp8Htz9/5QDjEO3Oh++5Z6er34VIkUrLfR8jiHDhDfIxaqyFSm1Laq
	LJU7gnntCh7XqavLfLiNDISyuqFQhPFLrFsu5/2c1krkyATsWCvjMJ+Mym9VGQuXc/PeIZ3W1ae
	5rbEJTsT9XEIgPGeJFy1y8ww5PUHBknd/gfKKHwRpKt5LVesbIqCKolCZniKc9KVs1A==
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4ac1793e81cmr352938745e9.13.1793753614437;
        Tue, 03 Nov 2026 16:53:34 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ed95sm11899275e9.4.2026.11.03.16.53.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:53:33 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	James Houghton <jthoughton@google.com>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] KVM: x86/mmu: Allocate memslot rmaps in on-demand chunks
Date: Wed,  4 Nov 2026 00:53:29 +0000
Message-ID: <20261104005331.50600-4-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104005331.50600-1-griffoul@gmail.com>
References: <20261104005331.50600-1-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

When L1 runs a nested guest, KVM allocates rmaps for all of L1's
memory the first time it creates a shadow root, which is 8 GiB in one
allocation for a VM with 4 TiB of memory. Only the heads of gfns that
L2 maps are ever used, so an L1 whose L2s map a fraction of its memory
pays mostly for empty rmaps.

Allocate rmaps in page-sized chunks instead, when the first SPTE in a
chunk's range is added, and keep a per-level directory of chunks in
the memslot. A missing chunk reads as empty rmaps. That way, the rmap
cost follows what L2 maps, and when L2 maps every gfn it is what it
was before plus the directory.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  22 ++++++-
 arch/x86/kvm/debugfs.c          |  31 +++++++---
 arch/x86/kvm/mmu/mmu.c          | 100 +++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c              |  22 +++++--
 4 files changed, 153 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0378577d9d8b..4cc00dc83aba 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -431,6 +431,8 @@ struct kvm_rmap_head {
 	atomic_long_t val;
 };
 
+#define KVM_RMAP_CHUNK_NR_HEADS	(PAGE_SIZE / sizeof(struct kvm_rmap_head))
+
 struct kvm_pio_request {
 	unsigned long count;
 	int in;
@@ -785,6 +787,7 @@ struct kvm_vcpu_arch {
 	u64 pdptrs[4]; /* pae */
 
 	struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
+	struct kvm_mmu_memory_cache mmu_rmap_chunk_cache;
 	struct kvm_mmu_memory_cache mmu_shadow_page_cache;
 	struct kvm_mmu_memory_cache mmu_shadowed_info_cache;
 	struct kvm_mmu_memory_cache mmu_page_header_cache;
@@ -1044,7 +1047,13 @@ struct kvm_lpage_info {
 };
 
 struct kvm_arch_memory_slot {
-	struct kvm_rmap_head *rmap[KVM_NR_PAGE_SIZES];
+	/*
+	 * Per-level directories of rmap chunks, each chunk holding
+	 * KVM_RMAP_CHUNK_NR_HEADS rmap heads.  Chunks are allocated when KVM
+	 * adds the first SPTE to a head in the chunk's range.  A NULL chunk
+	 * means all of its heads are empty.
+	 */
+	struct kvm_rmap_head **rmap[KVM_NR_PAGE_SIZES];
 	struct kvm_lpage_info *lpage_info[KVM_NR_PAGE_SIZES - 1];
 	unsigned short *gfn_write_track;
 };
@@ -1418,6 +1427,17 @@ struct kvm_arch {
 #define SPLIT_DESC_CACHE_MIN_NR_OBJECTS (SPTE_ENT_PER_PAGE + 1)
 	struct kvm_mmu_memory_cache split_desc_cache;
 
+	/*
+	 * Memory cache used to allocate rmap chunks while splitting huge
+	 * pages.  The rmap heads of the lower level leaf SPTEs of one huge
+	 * page are contiguous, but span two chunks if the memslot's base gfn
+	 * is not aligned to the chunk size.
+	 *
+	 * Protected by kvm->slots_lock.
+	 */
+#define SPLIT_RMAP_CHUNK_CACHE_NR_OBJECTS 2
+	struct kvm_mmu_memory_cache split_rmap_chunk_cache;
+
 	gfn_t gfn_direct_bits;
 	int mirror_root_level;
 
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 923424011328..0cdb1ef1b184 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -89,16 +89,29 @@ static const char *kvm_lpage_str[KVM_NR_PAGE_SIZES] = { "4K", "2M", "1G" };
 static void kvm_mmu_rmaps_stat_level(struct kvm_memory_slot *slot, int level,
 				     unsigned int *cur)
 {
-	struct kvm_rmap_head *rmap = slot->arch.rmap[level - PG_LEVEL_4K];
+	struct kvm_rmap_head **rmap = slot->arch.rmap[level - PG_LEVEL_4K];
 	unsigned long lpages = kvm_mmu_slot_lpages(slot, level);
-	unsigned int bucket;
-	unsigned long l;
-
-	for (l = 0; l < lpages; l++) {
-		bucket = fls(pte_list_count(&rmap[l]));
-		if (WARN_ON_ONCE(bucket >= RMAP_LOG_SIZE))
-			bucket = RMAP_LOG_SIZE - 1;
-		cur[bucket]++;
+	struct kvm_rmap_head *chunk;
+	unsigned long l, nr;
+	unsigned int index;
+
+	for (l = 0; l < lpages; l += nr) {
+		nr = min(lpages - l, KVM_RMAP_CHUNK_NR_HEADS);
+		chunk = rmap[l / KVM_RMAP_CHUNK_NR_HEADS];
+
+		/* An unallocated chunk holds only empty rmaps. */
+		if (!chunk) {
+			cur[0] += nr;
+			continue;
+		}
+
+		for (index = 0; index < nr; index++) {
+			unsigned int bucket = fls(pte_list_count(&chunk[index]));
+
+			if (WARN_ON_ONCE(bucket >= RMAP_LOG_SIZE))
+				bucket = RMAP_LOG_SIZE - 1;
+			cur[bucket]++;
+		}
 	}
 }
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b3fcd6f2a991..1b958f66764c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -612,6 +612,17 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 				       1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
 	if (r)
 		return r;
+	/*
+	 * 1 rmap chunk for the faulting gfn and 1 per prefetched gfn.  Cap the
+	 * cache at that, as each object is a page.
+	 */
+	if (kvm_memslots_have_rmaps(vcpu->kvm)) {
+		r = __kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_rmap_chunk_cache,
+						 1 + PTE_PREFETCH_NUM,
+						 1 + PTE_PREFETCH_NUM);
+		if (r)
+			return r;
+	}
 	if (kvm_has_mirrored_tdp(vcpu->kvm)) {
 		r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_external_spt_cache,
 					       PT64_ROOT_MAX_LEVEL);
@@ -635,6 +646,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
+	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_rmap_chunk_cache);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_shadow_page_cache);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_shadowed_info_cache);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_external_spt_cache);
@@ -1236,17 +1248,65 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 	return desc->tail_count + desc->spte_count;
 }
 
+/*
+ * Returned by gfn_to_rmap() for heads in a chunk that hasn't been allocated.
+ * Readers see an empty rmap, and only __rmap_add() writes to a head that may
+ * be empty, after allocating its chunk.
+ */
+static struct kvm_rmap_head kvm_empty_rmap_head;
+
+static struct kvm_rmap_head **
+rmap_chunkp(const struct kvm_memory_slot *slot, int level, unsigned long idx)
+{
+	return &slot->arch.rmap[level - PG_LEVEL_4K][idx / KVM_RMAP_CHUNK_NR_HEADS];
+}
+
+/* Returns NULL if the chunk holding the head hasn't been allocated. */
 static struct kvm_rmap_head *__idx_to_rmap(const struct kvm_memory_slot *slot,
 					   int level, unsigned long idx)
 {
-	return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
+	struct kvm_rmap_head *chunk;
+
+	/*
+	 * Lockless walkers can observe a chunk being installed.  Pairs with
+	 * the smp_store_release() in gfn_to_rmap_alloc().
+	 */
+	chunk = READ_ONCE(*rmap_chunkp(slot, level, idx));
+	if (!chunk)
+		return NULL;
+
+	return &chunk[idx % KVM_RMAP_CHUNK_NR_HEADS];
 }
 
 static struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
 					 const struct kvm_memory_slot *slot)
 {
-	return __idx_to_rmap(slot, level,
-			     gfn_to_index(gfn, slot->base_gfn, level));
+	struct kvm_rmap_head *rmap_head;
+
+	rmap_head = __idx_to_rmap(slot, level,
+				  gfn_to_index(gfn, slot->base_gfn, level));
+	return rmap_head ? : &kvm_empty_rmap_head;
+}
+
+static struct kvm_rmap_head *gfn_to_rmap_alloc(struct kvm *kvm,
+					       struct kvm_mmu_memory_cache *cache,
+					       gfn_t gfn, int level,
+					       const struct kvm_memory_slot *slot)
+{
+	unsigned long idx = gfn_to_index(gfn, slot->base_gfn, level);
+	struct kvm_rmap_head **chunkp, *chunk;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	chunkp = rmap_chunkp(slot, level, idx);
+	chunk = *chunkp;
+	if (!chunk) {
+		chunk = kvm_mmu_memory_cache_alloc(cache);
+		/* Publish the zeroed chunk to lockless walkers. */
+		smp_store_release(chunkp, chunk);
+	}
+
+	return &chunk[idx % KVM_RMAP_CHUNK_NR_HEADS];
 }
 
 static void rmap_remove(struct kvm *kvm, u64 *spte)
@@ -1620,12 +1680,22 @@ static bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
 static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 {
 	struct kvm_rmap_head *rmap_head;
+	unsigned long skip;
 
 	while (++iterator->idx <= iterator->end_idx) {
 		iterator->gfn += KVM_PAGES_PER_HPAGE(iterator->level);
 
 		rmap_head = __idx_to_rmap(iterator->slot, iterator->level,
 					  iterator->idx);
+		if (!rmap_head) {
+			/* Skip the rest of the unallocated chunk. */
+			skip = KVM_RMAP_CHUNK_NR_HEADS - 1 -
+			       iterator->idx % KVM_RMAP_CHUNK_NR_HEADS;
+			iterator->idx += skip;
+			iterator->gfn += skip * KVM_PAGES_PER_HPAGE(iterator->level);
+			continue;
+		}
+
 		if (atomic_long_read(&rmap_head->val)) {
 			iterator->rmap = rmap_head;
 			return;
@@ -1748,6 +1818,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 
 static void __rmap_add(struct kvm *kvm,
 		       struct kvm_mmu_memory_cache *cache,
+		       struct kvm_mmu_memory_cache *chunk_cache,
 		       const struct kvm_memory_slot *slot,
 		       u64 *spte, gfn_t gfn, unsigned int access)
 {
@@ -1759,7 +1830,7 @@ static void __rmap_add(struct kvm *kvm,
 	kvm_mmu_page_set_translation(sp, spte_index(spte), gfn, access);
 	kvm_update_page_stats(kvm, sp->role.level, 1);
 
-	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
+	rmap_head = gfn_to_rmap_alloc(kvm, chunk_cache, gfn, sp->role.level, slot);
 	rmap_count = pte_list_add(kvm, cache, spte, rmap_head);
 
 	if (rmap_count > kvm->stat.max_mmu_rmap_size)
@@ -1773,9 +1844,8 @@ static void __rmap_add(struct kvm *kvm,
 static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
 		     u64 *spte, gfn_t gfn, unsigned int access)
 {
-	struct kvm_mmu_memory_cache *cache = &vcpu->arch.mmu_pte_list_desc_cache;
-
-	__rmap_add(vcpu->kvm, cache, slot, spte, gfn, access);
+	__rmap_add(vcpu->kvm, &vcpu->arch.mmu_pte_list_desc_cache,
+		   &vcpu->arch.mmu_rmap_chunk_cache, slot, spte, gfn, access);
 }
 
 static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
@@ -6977,6 +7047,8 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu_pte_list_desc_cache.kmem_cache = pte_list_desc_cache;
 	vcpu->arch.mmu_pte_list_desc_cache.gfp_zero = __GFP_ZERO;
 
+	vcpu->arch.mmu_rmap_chunk_cache.gfp_zero = __GFP_ZERO;
+
 	vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
 	vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
 
@@ -7164,12 +7236,15 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 
 	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
 	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
+
+	kvm->arch.split_rmap_chunk_cache.gfp_zero = __GFP_ZERO;
 	return 0;
 }
 
 static void mmu_free_vm_memory_caches(struct kvm *kvm)
 {
 	kvm_mmu_free_memory_cache(&kvm->arch.split_desc_cache);
+	kvm_mmu_free_memory_cache(&kvm->arch.split_rmap_chunk_cache);
 	kvm_mmu_free_memory_cache(&kvm->arch.split_page_header_cache);
 	kvm_mmu_free_memory_cache(&kvm->arch.split_shadow_page_cache);
 }
@@ -7288,6 +7363,8 @@ static bool need_topup_split_caches_or_resched(struct kvm *kvm)
 	 * is possible but not worth the complexity.
 	 */
 	return need_topup(&kvm->arch.split_desc_cache, SPLIT_DESC_CACHE_MIN_NR_OBJECTS) ||
+	       need_topup(&kvm->arch.split_rmap_chunk_cache,
+			  SPLIT_RMAP_CHUNK_CACHE_NR_OBJECTS) ||
 	       need_topup(&kvm->arch.split_page_header_cache, 1) ||
 	       need_topup(&kvm->arch.split_shadow_page_cache, 1);
 }
@@ -7318,6 +7395,12 @@ static int topup_split_caches(struct kvm *kvm)
 	if (r)
 		return r;
 
+	r = __kvm_mmu_topup_memory_cache(&kvm->arch.split_rmap_chunk_cache,
+					 SPLIT_RMAP_CHUNK_CACHE_NR_OBJECTS,
+					 SPLIT_RMAP_CHUNK_CACHE_NR_OBJECTS);
+	if (r)
+		return r;
+
 	r = kvm_mmu_topup_memory_cache(&kvm->arch.split_page_header_cache, 1);
 	if (r)
 		return r;
@@ -7392,7 +7475,8 @@ static void shadow_mmu_split_huge_page(struct kvm *kvm,
 
 		spte = make_small_spte(kvm, huge_spte, sp->role, index);
 		mmu_spte_set(sptep, spte);
-		__rmap_add(kvm, cache, slot, sptep, gfn, sp->role.access);
+		__rmap_add(kvm, cache, &kvm->arch.split_rmap_chunk_cache, slot,
+			   sptep, gfn, sp->role.access);
 	}
 
 	__link_shadow_page(kvm, cache, huge_sptep, sp, flush);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..6231c9649c95 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10141,12 +10141,27 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_x86_call(vm_destroy)(kvm);
 }
 
+static unsigned long memslot_rmap_nr_chunks(struct kvm_memory_slot *slot,
+					    unsigned long npages, int level)
+{
+	return DIV_ROUND_UP(__kvm_mmu_slot_lpages(slot, npages, level),
+			    KVM_RMAP_CHUNK_NR_HEADS);
+}
+
 static void memslot_rmap_free(struct kvm_memory_slot *slot)
 {
+	unsigned long j, nr_chunks;
 	int i;
 
 	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
-		vfree(slot->arch.rmap[i]);
+		if (!slot->arch.rmap[i])
+			continue;
+
+		nr_chunks = memslot_rmap_nr_chunks(slot, slot->npages, i + 1);
+		for (j = 0; j < nr_chunks; j++)
+			free_page((unsigned long)slot->arch.rmap[i][j]);
+
+		kvfree(slot->arch.rmap[i]);
 		slot->arch.rmap[i] = NULL;
 	}
 }
@@ -10171,13 +10186,12 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
 	int i;
 
 	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
-		int level = i + 1;
-		int lpages = __kvm_mmu_slot_lpages(slot, npages, level);
+		unsigned long nr_chunks = memslot_rmap_nr_chunks(slot, npages, i + 1);
 
 		if (slot->arch.rmap[i])
 			continue;
 
-		slot->arch.rmap[i] = __vcalloc(lpages, sz, GFP_KERNEL_ACCOUNT);
+		slot->arch.rmap[i] = kvcalloc(nr_chunks, sz, GFP_KERNEL_ACCOUNT);
 		if (!slot->arch.rmap[i]) {
 			memslot_rmap_free(slot);
 			return -ENOMEM;
-- 
2.47.3

