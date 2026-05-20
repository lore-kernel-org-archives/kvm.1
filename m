Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C83DA7E0
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275611; cv=none; b=tzdRk/Cz/chn/90kQ7WZLEwaMoq+7OwYujOB+Ngx0cN5LkgzHF3U/7Fs7oFzCnZiEyN0BmYVmk+4envMzd9vwyMqepyOkifV8dwgS7iaJ4nzlrrqUNx0vD4xH42YpHswrIA9hc9JPbwmkpq68cvn6OOp5/qIVylUhoZCRLP5pls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275611; c=relaxed/simple;
	bh=LB77Ys2RRwRm1hr3O1UekBIbN8KchsKwolvZBHqv6S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MHKk8DMKkjL+IunIXSxKud16hwn8PxT+1yOwh4FlP6zCUUxX6WafXBsO94Iu4jSFm7fmSSX/0qmZQTWIeFY6GVcXW7O1rjZG5YhCIZcjPwo1Cq6LKKEyYUZpyCu09hSpxRGbmtqxlNz35SmPV+qItm24XhE6nIfSA2lamZZ0R8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+GujgGV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+GujgGV"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36a15ed5119so1184072a91.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779275610; x=1779880410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knwXJ3JEsH6Jmlubb4WZUNQijYP0NQzOunR3rtuM3uE=;
        b=I+GujgGVUxjyNZMP8kvVNgz2+DaSJlH45Iz2vo6HSvjMYqtA2LRlPQjzvtKJWD38gN
         zFTNqJxroFySoIoqEgj+0CfhI9HKCeHyJeRXaNsPpoIhUwNc6ElFnekJPRFvxNn9jcsu
         GiUpUAZN8DNnI4l5w/fItOozurRoNZA5vIBnh1vy+bOaJ6LPwWouwzLTVReB0+wiQwkt
         hUtUHTCENSQznZ7QixsxLNN+obQJratBQb0lkvNB3YQOJXCIuqUow0UMq0KwKrqc/ULg
         9f4ZUGxbEBrP+X8DL9LWk9njMjCl8rDV68TIk/b3wvuC5WNyWAgoL1VYWyLIwCIp+2r2
         j4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779275610; x=1779880410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knwXJ3JEsH6Jmlubb4WZUNQijYP0NQzOunR3rtuM3uE=;
        b=AT2PpdHAG4K5u3PqIUP/dqOVVCOu5qHBsfT1LJM7hX1ZkQrzTg6fKQwsEKLa60qPnc
         mjA2um7xrIRCWvnpQeDAcZwoLjKR1oznnEt8G5HU9L+hp/VQTN3knc/SmRvI0n6LNUKA
         tkL1zJJP5+P/ARmAgAJoCugmCNT37OLukMQRLk7w17Y+2a59v8ayKvAt2FWAFa6Dl6AT
         ixyEPzfGhHXa6o9CKya7Za+6VSScubXGP6ZLZpOMYHccqbANZGNdrj3pNr7xgMfP6rRf
         vSfXcQrp2zzXklTPMLshFzM8G0IRZKuAixRPAbJmyqmsF4dMcEcETcmZlkUky2IEVXOc
         62UA==
X-Forwarded-Encrypted: i=1; AFNElJ/xz6GmqT32ZVCLq7Q5ltQObPgd4Cqj2U2lLIA0/DQfVlPOR6qFzH/mhqFAy3jDbVTFIdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xNxqI1Oosx7lcJ/JlmDo6HAHA6UNfaOPz3KLfj+BA+lieyTn
	yPvWGG2NyWubLd/3fbOMjsG1twh1+AIlnv13EAr+OJCntuzpAd4QJ8lM
X-Gm-Gg: Acq92OGMWUTZfEXd0ft7C0zl5Kmw2xTOqGZSS8pLsbTpjyroKrrtbqcBpGj04E/v45s
	WS1G58dBI7Bp2KD9mWUfb7R1ynCZocJoF6ix7YTzVv5bE6ezxYhZBXEll0DantD5PZk1u/0WBCd
	Becu4xc+vr8GXgGY0bOiVevb35cOUf1z4elAozKYEHQMoJZENmC6IJWaQ8ZkXE6b3ZPBPNxvB1T
	01xJzX2Z2aLq11L1UtYHlQDNEp5rnhqh1DPqm0AqOSjSjZAj6FR2CMEo/enpdEpeJTk9jI793vw
	pzG71wZV6E1rWB+Le30K75nfJb52mwZrIEh36StH2EH+zN0H1Ikt1Az6ix1MQxT04rUxwhBMux8
	pcbSMn5vXvmNnW4LdD/X98huE2t7kzz2pTbDf5qeb8M2HrSJxm14N67pxaIJmyPiccTBKBwPpNN
	3VsFZU19IhkMkAhZxwnzPUR6l4CVy+GizijD8+jRFdfWw=
X-Received: by 2002:a17:90a:51e6:b0:369:932a:2b6d with SMTP id 98e67ed59e1d1-369932a2fa4mr10716050a91.6.1779275609695;
        Wed, 20 May 2026 04:13:29 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([14.48.8.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951278e7fsm17171421a91.8.2026.05.20.04.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:13:29 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Paul Durrant <pdurrant@amazon.com>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] KVM: pfncache: track HVA invalidations for HVA-based caches
Date: Wed, 20 May 2026 20:13:25 +0900
Message-Id: <20260520111325.693807-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HVA-based gfn_to_pfn caches are not necessarily backed by a KVM memslot.
When an MMU notifier invalidation targets such an HVA, KVM's global
mmu_invalidate_seq is not guaranteed to change because that sequence is
advanced through the memslot-based invalidation path.

This matters during hva_to_pfn_retry(). The refresh path temporarily
marks the cache invalid and drops gpc->lock while resolving the HVA and
creating a kernel mapping. If an overlapping HVA invalidation completes in
that window, the notifier may observe gpc->valid == false and therefore
leave no state behind for the in-progress refresh. For an HVA outside all
memslots, the refresh cannot rely on mmu_invalidate_seq to detect the
event either.

To prevent this, we must add a per-cache HVA invalidation sequence.
Bump the sequence whenever the cached HVA overlaps an MMU notifier range,
regardless of the current valid state. Snapshot the sequence before
dropping gpc->lock in hva_to_pfn_retry(), and retry the refresh if it
changes before the new mapping is published.

Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com/
Fixes: b9220d32799a ("KVM: x86/xen: allow shared_info to be mapped by fixed HVA")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 include/linux/kvm_types.h |  1 +
 virt/kvm/pfncache.c       | 42 ++++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..ff3b8aa73561 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -85,6 +85,7 @@ struct gfn_to_pfn_cache {
 	u64 generation;
 	gpa_t gpa;
 	unsigned long uhva;
+	unsigned long hva_invalidate_seq;
 	struct kvm_memory_slot *memslot;
 	struct kvm *kvm;
 	struct list_head list;
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..296b06482ebc 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -19,6 +19,24 @@
 
 #include "kvm_mm.h"
 
+static inline bool gpc_uhva_in_range(struct gfn_to_pfn_cache *gpc,
+			      unsigned long start, unsigned long end)
+{
+	return gpc->uhva >= start && gpc->uhva < end;
+}
+
+static inline bool gpc_should_invalidate(struct gfn_to_pfn_cache *gpc,
+				  unsigned long start, unsigned long end)
+{
+	if (!gpc_uhva_in_range(gpc, start, end))
+		return false;
+
+	if (kvm_gpc_is_hva_active(gpc))
+		return true;
+
+	return gpc->valid && !is_error_noslot_pfn(gpc->pfn);
+}
+
 /*
  * MMU notifier 'invalidate_range_start' hook.
  */
@@ -32,8 +50,7 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 		read_lock_irq(&gpc->lock);
 
 		/* Only a single page so no need to care about length */
-		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-		    gpc->uhva >= start && gpc->uhva < end) {
+		if (gpc_should_invalidate(gpc, start, end)) {
 			read_unlock_irq(&gpc->lock);
 
 			/*
@@ -45,9 +62,11 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 			 */
 
 			write_lock_irq(&gpc->lock);
-			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-			    gpc->uhva >= start && gpc->uhva < end)
+			if (gpc_should_invalidate(gpc, start, end)) {
+				if (kvm_gpc_is_hva_active(gpc))
+					gpc->hva_invalidate_seq++;
 				gpc->valid = false;
+			}
 			write_unlock_irq(&gpc->lock);
 			continue;
 		}
@@ -124,8 +143,11 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
 #endif
 }
 
-static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_seq)
+static inline bool mmu_notifier_retry_cache(struct gfn_to_pfn_cache *gpc,
+					    unsigned long mmu_seq, unsigned long hva_seq)
 {
+	struct kvm *kvm = gpc->kvm;
+
 	/*
 	 * mn_active_invalidate_count acts for all intents and purposes
 	 * like mmu_invalidate_in_progress here; but the latter cannot
@@ -149,7 +171,10 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 	 * new (incremented) value of mmu_invalidate_seq is observed.
 	 */
 	smp_rmb();
-	return kvm->mmu_invalidate_seq != mmu_seq;
+	if (kvm->mmu_invalidate_seq != mmu_seq)
+		return true;
+
+	return gpc->hva_invalidate_seq != hva_seq;
 }
 
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
@@ -159,6 +184,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
 	unsigned long mmu_seq;
+	unsigned long hva_seq;
 	struct page *page;
 
 	struct kvm_follow_pfn kfp = {
@@ -182,6 +208,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 
 	do {
 		mmu_seq = gpc->kvm->mmu_invalidate_seq;
+		hva_seq = gpc->hva_invalidate_seq;
 		smp_rmb();
 
 		write_unlock_irq(&gpc->lock);
@@ -232,7 +259,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		 * attempting to refresh.
 		 */
 		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
+	} while (mmu_notifier_retry_cache(gpc, mmu_seq, hva_seq));
 
 	gpc->valid = true;
 	gpc->pfn = new_pfn;
@@ -391,6 +418,7 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->pfn = KVM_PFN_ERR_FAULT;
 	gpc->gpa = INVALID_GPA;
 	gpc->uhva = KVM_HVA_ERR_BAD;
+	gpc->hva_invalidate_seq = 0;
 	gpc->active = gpc->valid = false;
 }
 
--
