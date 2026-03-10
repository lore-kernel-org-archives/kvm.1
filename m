Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7C342529
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125063; cv=none; b=Qyo9gUbaD/ZIk+mk0OY1BwGWULdV+vYUKhvQ/5OEC0m0oTW6x5r91osJ2m9wqcFjhLT7kJH+6s1wAcoHIrxhQdWwn9+wERKvszEwXlgfRUSXLM8G27cO/WtxHYZ+7CuDIoWegOSJ9O5uHzY0tPcGpDqb/cVPARG6XGPwaXi9uho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125063; c=relaxed/simple;
	bh=VkU8w2DnrD5oWrBvLA4PMHppC203NxwOVzIRmfjCyYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYCvXnErK7Sywb+sOaPUY4iNdbheDBeH+0/MH0uUoUSlJ/cX4HPKgdUVSlMCPx1U460UIKkvZ76crl5+wPQ8133gRAUf/hxKLT5k5lHtJF0DyGbLPdteUnH2vhzUm9ncXHQpR/vpIoHzyQ0X5RvkYYdC6k7yyY0gBdhJlN5jjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dnbKHIJG; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dnbKHIJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773125062; x=1804661062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tv4G1YCN45V1HsQ0FT4LGK+BsDPPZ9GmYhKKpxFDnZM=;
  b=dnbKHIJGjk8IgcA41HS4y4dUVqeh1HjvZ16nut/1bU5L8oBCb+RpvlR9
   Jycv0vwkP0qAGlFh1PlkEa09FRrmBaFBG3nzdD3QnLtZHOQgpF85RsF51
   rS4VAx00aataAzTMHyVLg+DntrL38b+c+zjpu57w1k60LbYoQ93109zeZ
   ul1gdFQTcjslAQ+t/2h6oS/o60JuTbjcPIeYRDVJkrDOH8wJx6LPoDAq+
   ITZ9EIY0/A6wrauBP84wfDgVH649SyAa96wLxdA1kEIVVFC4AXdheOmTu
   ro1724oCi5TGogMDpWossbVDPQnyVlq/iD3USzv0jCKZNJHU9anOJONwB
   A==;
X-CSE-ConnectionGUID: U+OusfQfRaizEYL+Q0/RYQ==
X-CSE-MsgGUID: 6QTjlYa3QPmg/Hs/Z/HMdw==
X-IronPort-AV: E=Sophos;i="6.23,111,1770595200"; 
   d="scan'208";a="14687106"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 06:44:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:5616]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.153:2525] with esmtp (Farcaster)
 id f774c270-9d7e-4955-9cb0-b221cd38d98d; Tue, 10 Mar 2026 06:44:21 +0000 (UTC)
X-Farcaster-Flow-ID: f774c270-9d7e-4955-9cb0-b221cd38d98d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:44:21 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:44:18 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <kalyazin@amazon.com>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Takahiro Itazuri <zulinx86@gmail.com>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [RFC PATCH v3 6/6] KVM: pfncache: Invalidate on gmem invalidation and memattr updates
Date: Tue, 10 Mar 2026 06:44:15 +0000
Message-ID: <20260310064415.22353-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310063647.15665-1-itazur@amazon.com>
References: <20260310063647.15665-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Invalidate pfncaches when guest_memfd invalidation or memory attribute
updates render cached PFN resolutions stale.

Reuse active_invalidate_count to synchronize with the existing retry
logic and preserve ordering against mmu_invalidate_seq.

Invalidation needs to be performed using HVA ranges so that both
GPA-based and HVA-based pfncaches are covered.  Internally GPA-based
ones translate GPA to memslot/UHVA first and then resolve PFN, while
HVA-based ones only resolve PFN and do not store memslot/GPA context.
Technically, it is possible to make HVA-based pfncaches search the
corresponding memslot/GPA when activated / refreshed, but it would add
overhead to a greater ot lesser extent, regardless of guest_memfd-backed
or not.  At the time of writing, only Xen uses HVA-based pfncaches.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 virt/kvm/guest_memfd.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c    | 47 ++++++++++++++++++++++++++++++++++++++-
 virt/kvm/pfncache.c    |  4 ++--
 3 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 79f34dad0c2f..eb2f1a7e54dc 100644
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
+	 * active_invalidate_count instead of mmu_invalidate_in_progress.
+	 */
+	spin_lock(&kvm->invalidate_lock);
+	kvm->active_invalidate_count++;
+	spin_unlock(&kvm->invalidate_lock);
+
+	/*
+	 * Invalidation of pfncaches must be done using a HVA range.  pfncaches
+	 * can be either GPA-based or HVA-based, and all pfncaches store uhva
+	 * while HVA-based pfncaches do not have gpa/memslot info.  Thus,
+	 * using GFN ranges would miss invalidating HVA-based ones.
+	 */
+	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
+		pgoff_t pgoff =3D slot->gmem.pgoff;
+		gfn_t gfn_start =3D slot->base_gfn + max(pgoff, start) - pgoff;
+		gfn_t gfn_end =3D slot->base_gfn + min(pgoff + slot->npages, end) - pgof=
f;
+
+		unsigned long hva_start =3D gfn_to_hva_memslot(slot, gfn_start);
+		unsigned long hva_end =3D gfn_to_hva_memslot(slot, gfn_end);
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
+	 * active_invalidate_count or the new (incremented) mmu_invalidate_seq.
+	 */
+	spin_lock(&kvm->invalidate_lock);
+	if (!WARN_ON_ONCE(!kvm->active_invalidate_count))
+		kvm->active_invalidate_count--;
+	wake =3D !kvm->active_invalidate_count;
+	spin_unlock(&kvm->invalidate_lock);
+
+	/*
+	 * guest_memfd invalidation itself doesn't need to block active memslots
+	 * swap as bindings updates are serialized by filemap_invalidate_lock().
+	 * However, active_invalidate_count is shared with the MMU notifier
+	 * path, so the waiter must be waked when active_invalidate_count drops
+	 * to zero.
+	 */
+	if (wake)
+		rcuwait_wake_up(&kvm->memslots_update_rcuwait);
 }
=20
 static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f51056e971d0..2ad31e491090 100644
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
+	 * active_invalidate_count instead of mmu_invalidate_in_progress.
+	 */
+	spin_lock(&kvm->invalidate_lock);
+	kvm->active_invalidate_count++;
+	spin_unlock(&kvm->invalidate_lock);
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
+			unsigned long hva_end =3D gfn_to_hva_memslot(slot, gfn_end);
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
+	 * active_invalidate_count or the new (incremented) mmu_invalidate_seq.
+	 *
+	 * memslots_update_rcuwait does not need to be waked when
+	 * active_invalidate_count drops to zero because active memslots swap is
+	 * also done while holding slots_lock.
+	 */
+	spin_lock(&kvm->invalidate_lock);
+	if (!WARN_ON_ONCE(!kvm->active_invalidate_count))
+		kvm->active_invalidate_count--;
+	spin_unlock(&kvm->invalidate_lock);
+
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
=20
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 63e08fbac16d..42b3b849f78b 100644
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
 	 * active_invalidate_count acts for all intents and purposes like
@@ -274,7 +274,7 @@ static kvm_pfn_t gpc_to_pfn_retry(struct gfn_to_pfn_cac=
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

