Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76233BBA7
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700098; cv=none; b=CGZamdINct25QvrwVhalxyYLVrryZik65PGbsQnehLZORQJItH0orgmA6te2Ahe42Xgg1xXHTUbMTTZt49ZO2ngrMkuUKWlkNUlVtSL3et9eew2r4onLWPArMNYl7h8+mb0mpeddL76no2GIVLR0lQ3xnjwyVVedDV8RFJ1k7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700098; c=relaxed/simple;
	bh=9X2i16qyBlAUhPEd5JM9AEnRH1CDpSzmOVbrhfo5CBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2GC0DxjqAkZ4bpK2ts3x0kU+NOvb+CicodlXf2MeKHCWh0lSaMfFqSPj6kI8PcEzZwwHoL0EhEvv3ZL2oTqEUaoiOQpN0O31beRpbjitB/nrxTi2V1tG0UFk9f044hWeZUI8RygXAFhHzzHpoc5jG6YO2XyfXXUntbtUrMAcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VBDPqZ1Z; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VBDPqZ1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700096; x=1808236096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mTYNJ+Cj3lqr2PWkHM2A14p2rUyWp5mJRGRrflx/09E=;
  b=VBDPqZ1ZqFGg0rrIYZuZbjyuvFOwYEkrAgkZcJwbWU5APpYite4YBb51
   8cXuEUT1aonlzpkjrI0LQlmDbLjuIYXfn/OLJyjP9DYNXVBbBKL26rXHk
   LkMLxD6y5Hkz90+gXIlAbfM+OnGExi40CzkM/dkCOA9alMm8+3Gjvy3up
   +6dsoVGmp2/HJUkIseiLxSZFQm294n+NSyRh1RAAHCkRzK8RqQziDCHkD
   MZHfMhACXhLCfrJ83qPojbZT0F07Ym/4gWwwZFIujdBBtl9VXeb+7zV/x
   iZdeoKVGxOAFiQhgRqkZ+FhVKjXr7cns39MhiM+xy9y9M7ZSS9o4Ny3Uv
   g==;
X-CSE-ConnectionGUID: o4U+kARpSumxDH8pKnPu2A==
X-CSE-MsgGUID: FTJG5EkVSPWPy1wmykFbvA==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17753242"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:48:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:29270]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.189:2525] with esmtp (Farcaster)
 id 419e6823-cd0e-470e-9579-df3cb3db8860; Mon, 20 Apr 2026 15:48:11 +0000 (UTC)
X-Farcaster-Flow-ID: 419e6823-cd0e-470e-9579-df3cb3db8860
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:48:06 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:48:03 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Patrick Roy <patrick.roy@linux.dev>, "Derek
 Manwaring" <derekmn@amazon.com>, Alina Cernea <acernea@amazon.com>, "Michael
 Zoumboulakis" <zoumboul@amazon.com>, Takahiro Itazuri <zulinx86@gmail.com>,
	Takahiro Itazuri <itazur@amazon.com>
Subject: [RFC PATCH v4 5/7] KVM: pfncache: Invalidate on gmem invalidation and memattr updates
Date: Mon, 20 Apr 2026 15:46:06 +0000
Message-ID: <20260420154720.29012-6-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Invalidate pfncaches when guest_memfd invalidation or memory attribute
updates render cached PFN resolutions stale.

Reuse mn_active_invalidate_count to synchronize with the existing retry
logic and preserve ordering against mmu_invalidate_seq.

Invalidation needs to be performed using HVA ranges so that both
GPA-based and HVA-based pfncaches are covered.  Internally GPA-based
ones translate GPA to memslot/UHVA first and then resolve PFN, while
HVA-based ones only resolve PFN and do not store memslot/GPA context.
Technically, it is possible to make HVA-based pfncaches search the
corresponding memslot/GPA when activated/refreshed, but it would add
overhead to a greater or lesser extent, regardless of guest_memfd-backed
or not.  At the time of writing, only Xen uses HVA-based pfncaches.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 virt/kvm/guest_memfd.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c    | 47 ++++++++++++++++++++++++++++++++++++++-
 virt/kvm/pfncache.c    | 21 ++++++++++--------
 3 files changed, 108 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 79f34dad0c2f..011fd205ac7e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -215,6 +215,33 @@ static void __kvm_gmem_invalidate_start(struct gmem_fi=
le *f, pgoff_t start,
 	struct kvm *kvm =3D f->kvm;
 	unsigned long index;
=20
+	/*
+	 * Prevent pfncaches from being activated / refreshed using stale PFN
+	 * resolutions.  To invalidate pfncaches _before_ invalidating the
+	 * secondary MMUs (i.e. without acquiring mmu_lock), pfncaches must use
+	 * mn_active_invalidate_count instead of mmu_invalidate_in_progress.
+	 */
+	spin_lock(&kvm->mn_invalidate_lock);
+	kvm->mn_active_invalidate_count++;
+	spin_unlock(&kvm->mn_invalidate_lock);
+
+	/*
+	 * Invalidation of pfncaches must be done using a HVA range.  pfncaches
+	 * can be either GPA-based or HVA-based, and all pfncaches store uhva
+	 * while HVA-based pfncaches do not have gpa/memslot context.  Thus,
+	 * using GFN ranges would miss invalidating HVA-based ones.
+	 */
+	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
+		pgoff_t pgoff =3D slot->gmem.pgoff;
+		gfn_t gfn_start =3D slot->base_gfn + max(pgoff, start) - pgoff;
+		gfn_t gfn_end =3D slot->base_gfn + min(pgoff + slot->npages, end) - pgof=
f;
+
+		unsigned long hva_start =3D gfn_to_hva_memslot(slot, gfn_start);
+		unsigned long hva_end =3D hva_start + (gfn_end - gfn_start) * PAGE_SIZE;
+
+		gpc_invalidate_hva_range_start(kvm, hva_start, hva_end);
+	}
+
 	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
 		pgoff_t pgoff =3D slot->gmem.pgoff;
=20
@@ -259,12 +286,35 @@ static void __kvm_gmem_invalidate_end(struct gmem_fil=
e *f, pgoff_t start,
 				      pgoff_t end)
 {
 	struct kvm *kvm =3D f->kvm;
+	bool wake;
=20
 	if (xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
 		KVM_MMU_LOCK(kvm);
 		kvm_mmu_invalidate_end(kvm);
 		KVM_MMU_UNLOCK(kvm);
 	}
+
+	/*
+	 * This must be done after the increment of mmu_invalidate_seq and
+	 * smp_wmb() in kvm_mmu_invalidate_end() to guarantee that
+	 * gpc_invalidate_retry() observes either the old (non-zero)
+	 * mn_active_invalidate_count or the new (incremented) mmu_invalidate_seq.
+	 */
+	spin_lock(&kvm->mn_invalidate_lock);
+	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
+		kvm->mn_active_invalidate_count--;
+	wake =3D !kvm->mn_active_invalidate_count;
+	spin_unlock(&kvm->mn_invalidate_lock);
+
+	/*
+	 * guest_memfd invalidation itself doesn't need to block active memslots
+	 * swap as bindings updates are serialized by filemap_invalidate_lock().
+	 * However, mn_active_invalidate_count is shared with the MMU notifier
+	 * path, so the waiter must be woken when mn_active_invalidate_count
+	 * drops to zero.
+	 */
+	if (wake)
+		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
 }
=20
 static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d64e70f8e8e3..b6d0a22fee79 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2583,9 +2583,11 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm=
, gfn_t start, gfn_t end,
 		.on_lock =3D kvm_mmu_invalidate_end,
 		.may_block =3D true,
 	};
+	struct kvm_memslots *slots =3D kvm_memslots(kvm);
+	struct kvm_memory_slot *slot;
 	unsigned long i;
 	void *entry;
-	int r =3D 0;
+	int r =3D 0, bkt;
=20
 	entry =3D attributes ? xa_mk_value(attributes) : NULL;
=20
@@ -2609,6 +2611,34 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm=
, gfn_t start, gfn_t end,
 		cond_resched();
 	}
=20
+	/*
+	 * Prevent pfncaches from being activated / refreshed using stale PFN
+	 * resolutions.  To invalidate pfncaches _before_ invalidating the
+	 * secondary MMUs (i.e. without acquiring mmu_lock), pfncaches must use
+	 * mn_active_invalidate_count instead of mmu_invalidate_in_progress.
+	 */
+	spin_lock(&kvm->mn_invalidate_lock);
+	kvm->mn_active_invalidate_count++;
+	spin_unlock(&kvm->mn_invalidate_lock);
+
+	/*
+	 * Invalidation of pfncaches must be done using a HVA range.  pfncaches
+	 * can be either GPA-based or HVA-based, and all pfncaches store uhva
+	 * while HVA-based pfncaches do not have gpa/memslot info.  Thus,
+	 * using GFN ranges would miss invalidating HVA-based ones.
+	 */
+	kvm_for_each_memslot(slot, bkt, slots) {
+		gfn_t gfn_start =3D max(start, slot->base_gfn);
+		gfn_t gfn_end =3D min(end, slot->base_gfn + slot->npages);
+
+		if (gfn_start < gfn_end) {
+			unsigned long hva_start =3D gfn_to_hva_memslot(slot, gfn_start);
+			unsigned long hva_end =3D hva_start + (gfn_end - gfn_start) * PAGE_SIZE;
+
+			gpc_invalidate_hva_range_start(kvm, hva_start, hva_end);
+		}
+	}
+
 	kvm_handle_gfn_range(kvm, &pre_set_range);
=20
 	for (i =3D start; i < end; i++) {
@@ -2620,6 +2650,21 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm=
, gfn_t start, gfn_t end,
=20
 	kvm_handle_gfn_range(kvm, &post_set_range);
=20
+	/*
+	 * This must be done after the increment of mmu_invalidate_seq and
+	 * smp_wmb() in kvm_mmu_invalidate_end() to guarantee that
+	 * gpc_invalidate_retry() observes either the old (non-zero)
+	 * mn_active_invalidate_count or the new (incremented) mmu_invalidate_seq.
+	 *
+	 * mn_memslots_update_rcuwait does not need to be waked when
+	 * mn_active_invalidate_count drops to zero because active memslots swap
+	 * is also done while holding slots_lock.
+	 */
+	spin_lock(&kvm->mn_invalidate_lock);
+	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
+		kvm->mn_active_invalidate_count--;
+	spin_unlock(&kvm->mn_invalidate_lock);
+
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
=20
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index bb4ba3a1b3d9..0e7a0f64e14b 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -144,7 +144,7 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
 #endif
 }
=20
-static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long=
 mmu_seq)
+static inline bool gpc_invalidate_retry(struct kvm *kvm, unsigned long mmu=
_seq)
 {
 	/*
 	 * mn_active_invalidate_count acts for all intents and purposes
@@ -178,14 +178,17 @@ static inline bool mmu_notifier_retry_cache(struct kv=
m *kvm, unsigned long mmu_s
  *
  * The caller holds gpc->refresh_lock, but does not hold gpc->lock nor
  * kvm->slots_lock.  Reading slot->flags (via kvm_slot_has_gmem() and
- * kvm_memslot_is_gmem_only()) is safe because memslot changes bump
- * slots->generation, which is detected in kvm_gpc_check(), forcing callers
- * to invoke kvm_gpc_refresh().
+ * kvm_memslot_is_gmem_only()) and looking up memory attributes (via
+ * kvm_mem_is_private()) without those locks is safe because:
  *
- * Looking up memory attributes (via kvm_mem_is_private()) can race with
- * KVM_SET_MEMORY_ATTRIBUTES, which takes kvm->slots_lock to serialize
- * writers but doesn't exclude lockless readers.  Handling that race is de=
ferred
- * to a subsequent commit that wires up pfncache invalidation for gmem eve=
nts.
+ * - memslot changes bump slots->generation, which is detected in
+ *   kvm_gpc_check(), forcing callers to invoke kvm_gpc_refresh().
+ *
+ * - Memory attribute changes and gmem invalidations elevate
+ *   mn_active_invalidate_count and bump mmu_invalidate_seq, bracketing the
+ *   pfncache invalidation.  gpc_invalidate_retry() observes either of the=
se
+ *   changes and forces a retry of the refresh loop in gpc_to_pfn_retry(),=
 so
+ *   any stale value read here will be re-evaluated.
  */
 static inline bool gpc_is_gmem_backed(struct gfn_to_pfn_cache *gpc)
 {
@@ -293,7 +296,7 @@ static kvm_pfn_t gpc_to_pfn_retry(struct gfn_to_pfn_cac=
he *gpc)
 		 * attempting to refresh.
 		 */
 		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
+	} while (gpc_invalidate_retry(gpc->kvm, mmu_seq));
=20
 	gpc->valid =3D true;
 	gpc->pfn =3D new_pfn;
--=20
2.50.1

