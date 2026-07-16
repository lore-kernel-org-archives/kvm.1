Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12F44605A
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225724; cv=none; b=MrYea7Mj/jVaiHsWcHYMRUo7Ga2wU68J+t/S2vnT5CdccN7qM+pONUSizQiS67c30l9/8CoUAxQpQ0wxZ17wn/+/4DTVCJBLZBgNZ/jtJ03OzewL+LVJnJfQe850zyjrruwxYjifjqJPg+f6S9OxKM7GZQNmNRO1IdnhJ5NNH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225724; c=relaxed/simple;
	bh=Kj/39F27i6nm/FzzqZdRX1SWP/oRHWxE/TjvNdNFZWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+cf+Ed2STasNZUG7qiBDIk7OUpM2Mm8pbPuIXGDP2a1Pxf19gg10AVCYeYnQqlT3RRTYOz5qI9PUMPpG4GgZswLF5MeDIk60NwDv63V5SyHqmwFCAiRvOoioetddHqoc1WH17GTrZJUyZCkotqTYxTGhC4rJff9IudUuTzjavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bObKxmru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bObKxmru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NkFNzpBnvWvuQQmK9EC1837UEMgr2MUOQKRAKWrsHRc=;
	b=bObKxmruDlsA/IdjlSnUADpyF3pyJRymI0ZlkbZlSUhlA2OEay/p7GZSyaplPQ10wcRM2D
	UnL52Cf6bsqFp3HKmUSCaDHMZ2m0ItGTVGGqtVoUS4CHjwxcfoCJX/4IgCFIdUT9A4FjVo
	oHcSSsK1yWPiZ5t98vieT3wu0wVAuwo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-VxWoXOBUPO2GkHcm5aj0wA-1; Thu,
 16 Jul 2026 14:15:08 -0400
X-MC-Unique: VxWoXOBUPO2GkHcm5aj0wA-1
X-Mimecast-MFC-AGG-ID: VxWoXOBUPO2GkHcm5aj0wA_1784225707
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 323AE1955EBC;
	Thu, 16 Jul 2026 18:15:07 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6D671800480;
	Thu, 16 Jul 2026 18:15:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 14/24] KVM: Introduce a generation number for memory attributes
Date: Thu, 16 Jul 2026 14:14:46 -0400
Message-ID: <20260716181456.402786-15-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Introduce a generation number to track memory attribute modifications.
This will allow KVM components to invalidate any assumptions they might
have about guest's physical addresses and their permissions when memory
attributes change.

Like with memory slot updates, it's mandatory for components that access
guest memory based on cached information to do so within a KVM SRCU
read-side critical section, and that they validate the generation number
before accessing memory. This, in combination with the
synchronize_srcu() call within the memory attributes ioctl handler,
ensures the following:
- A memory attribute modification operation only returns after all
  users of outdated GPA data are done running.
- Any component accessing cached data after the memory attribute
  modification returned will see the updated generation number.

Additionally, loads/stores of the generation number have
acquire/release semantics; which ensures all attribute writes are
visible before updating the generation, and loads from attributes happen
after having read the current generation number.

Ultimately, since synchronize_srcu_expedited() is an expensive
operation, only perform it when absolutely necessary. Do so if the
introduced memory attribute is known to require synchronization or if
the attribute being cleared contained a memory attribute that required
synchronization.

There shouldn't be any performance loss for memory attributes that
don't require synchronization (and in general for any VMM that does not
apply memory protections), because the attributes generation will always
remain unchanged.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c         |  4 +-
 include/linux/kvm_host.h   | 33 ++++++++++++++--
 include/linux/kvm_types.h  |  6 ++-
 include/trace/events/kvm.h | 14 +++++--
 virt/kvm/kvm_main.c        | 80 +++++++++++++++++++++++++++++++++-----
 virt/kvm/pfncache.c        | 13 ++++---
 6 files changed, 123 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58f544df47e1..5229f40d074c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2047,7 +2047,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attrs_generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
 		/* We rely on the fact that it fits in a single page. */
@@ -2624,7 +2624,7 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	if (unlikely(current->mm != vcpu->kvm->mm))
 		return;
 
-	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attrs_generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
 		return;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 122af87d6f9a..1fad3eb303c1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -877,6 +877,7 @@ struct kvm {
 	struct {
 		/* Protected by slots_lock (for writes) and RCU (for reads) */
 		struct xarray array;
+		u64 generation;
 	} mem_attrs;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
@@ -2559,29 +2560,49 @@ static inline bool kvm_mem_attributes_may_exec(u64 attrs)
 	return !(attrs & KVM_MEMORY_ATTRIBUTE_NX);
 }
 
-static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_generation, struct kvm_memslots **p_slots)
+static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_generation,
+					  u64 attrs_generation, struct kvm_memslots **p_slots)
 {
 	struct kvm_memslots *slots = *p_slots = kvm_memslots(kvm);
-	return slots->generation == slots_generation;
+	return slots->generation == slots_generation && kvm->mem_attrs.generation == attrs_generation;
 }
 
-static inline bool kvm_check_gen(struct kvm *kvm, u64 slots_generation)
+static inline bool kvm_check_gen(struct kvm *kvm, u64 slots_generation,
+				 u64 attrs_generation)
 {
 	struct kvm_memslots *slots;
-	return kvm_memslots_check_gen(kvm, slots_generation, &slots);
+	return kvm_memslots_check_gen(kvm, slots_generation, attrs_generation, &slots);
 }
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 #define KVM_MEMORY_ATTRIBUTE_PROT \
 	(KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW | KVM_MEMORY_ATTRIBUTE_NX)
 
+#define KVM_MEMORY_ATTRIBUTE_NEEDS_SYNC_MASK KVM_MEMORY_ATTRIBUTE_PROT
+
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
 	return xa_to_value(xa_load(&kvm->mem_attrs.array, gfn));
 }
 
+static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
+{
+	RCU_LOCKDEP_WARN(!lockdep_is_held(&kvm->slots_lock) &&
+				 !srcu_read_lock_held(&kvm->srcu),
+			 "Suspicious memory attribute generation usage\n");
+
+	/*
+	 * The acquire pairs with the release in kvm_vm_set_mem_attributes().
+	 * Memory attributes should only be queried _after_ storing the
+	 * generation number.
+	 */
+	return smp_load_acquire(&kvm->mem_attrs.generation);
+}
+
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs);
+bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+					unsigned long mask);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
@@ -2611,6 +2632,10 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
 {
 	return 0;
 }
+static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
+{
+	return 0;
+}
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 
 static inline int kvm_mem_attributes_may_read_gfn(struct kvm *kvm, gfn_t gfn)
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..7d911220e00d 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -74,7 +74,8 @@ typedef u64            hfn_t;
 typedef hfn_t kvm_pfn_t;
 
 struct gfn_to_hva_cache {
-	u64 generation;
+	u64 slots_generation;
+	u64 attrs_generation;
 	gpa_t gpa;
 	unsigned long hva;
 	unsigned long len;
@@ -82,7 +83,8 @@ struct gfn_to_hva_cache {
 };
 
 struct gfn_to_pfn_cache {
-	u64 generation;
+	u64 slots_generation;
+	u64 attrs_generation;
 	gpa_t gpa;
 	unsigned long uhva;
 	struct kvm_memory_slot *memslot;
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index b282e3a86769..a620131e9010 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -365,23 +365,29 @@ TRACE_EVENT(kvm_dirty_ring_exit,
  * @attr:	The value of the attribute being set.
  */
 TRACE_EVENT(kvm_vm_set_mem_attributes,
-	TP_PROTO(gfn_t start, gfn_t end, unsigned long attr),
-	TP_ARGS(start, end, attr),
+	TP_PROTO(gfn_t start, gfn_t end, unsigned long attr, bool sync, u64 generation),
+	TP_ARGS(start, end, attr, sync, generation),
 
 	TP_STRUCT__entry(
 		__field(gfn_t,		start)
 		__field(gfn_t,		end)
 		__field(unsigned long,	attr)
+		__field(bool,		sync)
+		__field(u64,		generation)
 	),
 
 	TP_fast_assign(
 		__entry->start		= start;
 		__entry->end		= end;
 		__entry->attr		= attr;
+		__entry->sync		= sync;
+		__entry->generation	= generation;
 	),
 
-	TP_printk("%#016llx -- %#016llx [0x%lx]",
-		  __entry->start, __entry->end, __entry->attr)
+	TP_printk("%#016llx -- %#016llx [0x%lx], sync %d gen %llu",
+		  __entry->start, __entry->end, __entry->attr,
+		  __entry->sync, __entry->generation)
+
 );
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1afaec56ecb3..2fe4087319ad 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1117,6 +1117,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	xa_init(&kvm->mem_attrs.array);
+	kvm->mem_attrs.generation = 0;
 #endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
@@ -2467,6 +2468,51 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	return true;
 }
 
+/*
+ * Returns true if _any_ gfns in the range [@start, @end) have attributes that
+ * match _any_ bit in @mask.
+ */
+bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+					unsigned long mask)
+{
+	XA_STATE(xas, &kvm->mem_attrs.array, start);
+	void *entry;
+
+	mask &= kvm_supported_mem_attributes(kvm);
+	if (!mask)
+		return false;
+
+	if (end == start + 1)
+		return !!(kvm_get_memory_attributes(kvm, start) & mask);
+
+	guard(rcu)();
+	for (;;) {
+		do {
+			entry = xas_next(&xas);
+		} while (xas_retry(&xas, entry));
+
+		if (xas.xa_index >= end)
+			break;
+
+		if (xa_to_value(entry) & mask)
+			return true;
+	}
+
+	return false;
+}
+
+static bool kvm_range_memory_attributes_need_sync(struct kvm *kvm,
+						  gfn_t start, gfn_t end,
+						  unsigned long attributes)
+{
+	u64 mask = KVM_MEMORY_ATTRIBUTE_NEEDS_SYNC_MASK;
+
+	if (attributes & mask)
+		return true;
+
+	return kvm_range_has_any_memory_attributes(kvm, start, end, mask);
+}
+
 static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 						 struct kvm_mmu_notifier_range *range)
 {
@@ -2559,20 +2605,25 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		.on_lock = kvm_mmu_invalidate_end,
 		.may_block = true,
 	};
+	bool sync = false;
 	unsigned long i;
 	void *entry;
 	int r = 0;
 
 	entry = attributes ? xa_mk_value(attributes) : NULL;
 
-	trace_kvm_vm_set_mem_attributes(start, end, attributes);
-
 	mutex_lock(&kvm->slots_lock);
 
 	/* Nothing to do if the entire range has the desired attributes. */
 	if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
 		goto out_unlock;
 
+	sync = kvm_range_memory_attributes_need_sync(kvm, start, end,
+						     attributes);
+
+	trace_kvm_vm_set_mem_attributes(start, end, attributes, sync,
+					kvm->mem_attrs.generation + 1);
+
 	/*
 	 * Reserve memory ahead of time to avoid having to deal with failures
 	 * partway through setting the new attributes.
@@ -2594,10 +2645,16 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		cond_resched();
 	}
 
+	/* Pairs with acquire in kvm_mem_attributes_generation() */
+	smp_store_release(&kvm->mem_attrs.generation,
+			  kvm->mem_attrs.generation + 1);
+
 	kvm_handle_gfn_range(kvm, &post_set_range);
 
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
+	if (sync)
+		synchronize_srcu_expedited(&kvm->srcu);
 
 	return r;
 }
@@ -3449,7 +3506,8 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_write_guest);
 
-static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
+static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
+				       struct kvm_memslots *slots,
 				       struct gfn_to_hva_cache *ghc,
 				       gpa_t gpa, unsigned long len)
 {
@@ -3459,8 +3517,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
 	gfn_t nr_pages_needed = end_gfn - start_gfn + 1;
 	gfn_t nr_pages_avail;
 
-	/* Update ghc->generation before performing any error checks. */
-	ghc->generation = slots->generation;
+	/* Update ghc->slots_generation before performing any error checks. */
+	ghc->slots_generation = slots->generation;
 
 	if (start_gfn > end_gfn) {
 		ghc->hva = KVM_HVA_ERR_BAD;
@@ -3479,6 +3537,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
 			return -EFAULT;
 	}
 
+	ghc->attrs_generation = kvm_mem_attributes_generation(kvm);
+
 	/* Use the slow path for cross page reads and writes. */
 	if (nr_pages_needed == 1)
 		ghc->hva += offset;
@@ -3494,7 +3554,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
-	return __kvm_gfn_to_hva_cache_init(slots, ghc, gpa, len);
+	return __kvm_gfn_to_hva_cache_init(kvm, slots, ghc, gpa, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gfn_to_hva_cache_init);
 
@@ -3509,8 +3569,8 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
-		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->slots_generation, ghc->attrs_generation, &slots))) {
+		if (__kvm_gfn_to_hva_cache_init(kvm, slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
 
@@ -3547,8 +3607,8 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
-		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->slots_generation, ghc->attrs_generation, &slots))) {
+		if (__kvm_gfn_to_hva_cache_init(kvm, slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
 
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index e09703d249bb..46ffae69fe77 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -76,10 +76,11 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 		return false;
 
 	/*
-	 * If the page was cached from a memslot, make sure the memslots have
-	 * not been re-configured.
+	 * If the page was cached from a memslot, make sure the memslots nor
+	 * memory attributes have not been re-configured.
 	 */
-	if (!kvm_is_error_gpa(gpc->gpa) && !kvm_check_gen(gpc->kvm, gpc->generation))
+	if (!kvm_is_error_gpa(gpc->gpa) &&
+	    !kvm_check_gen(gpc->kvm, gpc->slots_generation, gpc->attrs_generation))
 		return false;
 
 	if (kvm_is_error_hva(gpc->uhva))
@@ -253,6 +254,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 
 static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva)
 {
+	struct kvm *kvm = gpc->kvm;
 	unsigned long page_offset;
 	bool unmap_old = false;
 	unsigned long old_uhva;
@@ -292,12 +294,13 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
 		page_offset = offset_in_page(gpa);
 
-		if (!kvm_memslots_check_gen(gpc->kvm, gpc->generation, &slots) ||
+		if (!kvm_memslots_check_gen(gpc->kvm, gpc->slots_generation, gpc->attrs_generation, &slots) ||
 		    gpc->gpa != gpa || kvm_is_error_hva(gpc->uhva)) {
 			gfn_t gfn = gpa_to_gfn(gpa);
 
+			gpc->attrs_generation = kvm_mem_attributes_generation(kvm);
 			gpc->gpa = gpa;
-			gpc->generation = slots->generation;
+			gpc->slots_generation = slots->generation;
 			gpc->memslot = __gfn_to_memslot(slots, gfn);
 			gpc->uhva = gfn_to_hva_memslot(gpc->memslot, gfn);
 
-- 
2.52.0


