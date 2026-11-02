Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641524;
	b=CP0w8OWMlz3UD7AQQwz79+GDbyPbK5nK9bPKd1k2DojxEtM6jMsT+/iONHTDxxZ9/+s+
	 VOztuv/qs54MFZxf7pk1m3T8whgene7B77q1eUHyiustYC1M/nLg15rD2pauz5sPbPcOT
	 zpb+uIXOOiqQjqTUk2+wLAuLf/dUBdwENh7+h20U5/dHad3IIkgynoSbbLcTbqTzQDGC7
	 mLmwe2Ibs2OxxarO+3xBru5LwVqmKWRuf4/ZG7yusxEG1EIT5F4TzSm6REn5p8kBFY9HZ
	 iaBm6YVA0HEKqPZTjspqXORMDTJpPLJ1LqLspYFtvJ0HVKOcSSax1iHx4eak/FEqj0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641524;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=kT7V9jfSqziUC9Uex+C08tBtLPQpRUsh3g5ohXA2ENE=;
	b=UJD6Zqb2o1pRRGe3Y07obVn77Sm1Ja05pudRTjh6mQBH7dDRwfU+dz1BrPyL303qYBRT
	 xnZAY/PRMUYQ2+ClJz5uevN4Mo9U1HrTm8yjnkFy6psSOzyi1xzKRJ0yKfeo/uFceFr6S
	 TSWaFr/L657/ExhkqKY+TxeYvabeG/Qkj9o30qj/wb/8B6DRmKZBFvgTpqiBTKUymXU/l
	 JEYgNLJVagBi8aqKDWfGwfL+TEEStjtmK6UnsvvekQCxUQ9kX9CXUPcFne3rWV1HbDaPn
	 X7bFQIer+2BoXCRWjasUNGsteu81YjcKGuBCa7Adzlo/LHx9SkCHao1CEvDm3mxKzrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RjA4k+Yj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68660A2600
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D68660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RjA4k+Yj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT7V9jfSqziUC9Uex+C08tBtLPQpRUsh3g5ohXA2ENE=;
	b=RjA4k+Yjmf93Q9Gue/NtKDiubTOwNMR1pv8kzVtBrZt2fLMsyFYqMtDhLfRUIVYpJ3QrFc
	ALf96jHLi1WBEZk/eNWmA1Sa2QqfLm8cfLUhO/KoQAdfOwudZLN/L2FUGjOBeali6mQjgQ
	lepJ1HzFlfZZ8Ug+OoSZKvSkQN2csNU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-EUSSZc5-OsaXDkUp3cIfew-1; Mon,
 02 Nov 2026 12:45:19 -0500
X-MC-Unique: EUSSZc5-OsaXDkUp3cIfew-1
X-Mimecast-MFC-AGG-ID: EUSSZc5-OsaXDkUp3cIfew_1793641518
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F4BC1800870;
	Mon,  2 Nov 2026 17:45:18 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C09AE1956087;
	Mon,  2 Nov 2026 17:45:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 24/45] KVM: Introduce a generation number for memory attributes
Date: Mon,  2 Nov 2026 12:44:51 -0500
Message-ID: <20261102174512.8903-8-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
Link: https://patch.msgid.link/20260918135030.171564-22-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/loongarch/kvm/vcpu.c  |  6 ++-
 arch/x86/kvm/x86.c         |  4 +-
 include/linux/kvm_host.h   | 33 +++++++++++++--
 include/linux/kvm_types.h  |  6 ++-
 include/trace/events/kvm.h | 14 +++++--
 virt/kvm/kvm_main.c        | 82 +++++++++++++++++++++++++++++++++-----
 virt/kvm/pfncache.c        | 13 +++---
 7 files changed, 129 insertions(+), 29 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index c3e71ef983bc..6301e726a536 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -163,7 +163,8 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 		return;
 
 	gpa &= KVM_STEAL_PHYS_MASK;
-	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa != ghc->gpa ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attrs_generation) ||
+		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
 		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
 			ghc->gpa = INVALID_GPA;
@@ -1817,7 +1818,8 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vcpu *vcpu)
 
 	gpa &= KVM_STEAL_PHYS_MASK;
 	ghc = &vcpu->arch.st.cache;
-	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa != ghc->gpa ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attrs_generation) ||
+		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
 		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
 			ghc->gpa = INVALID_GPA;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8574d75df4dc..caff8534267d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2077,7 +2077,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attrs_generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
 		/* We rely on the fact that it fits in a single page. */
@@ -2653,7 +2653,7 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	if (unlikely(current->mm != vcpu->kvm->mm))
 		return;
 
-	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->slots_generation, ghc->attrs_generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
 		return;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5cbb50afdb94..2c854aaab92a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -879,6 +879,7 @@ struct kvm {
 	struct {
 		/* Protected by slots_lock (for writes) and RCU (for reads) */
 		struct xarray array;
+		u64 generation;
 	} mem_attrs;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
@@ -2621,7 +2622,23 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
 					   struct kvm_gfn_range *range);
 bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
 					    struct kvm_gfn_range *range);
+bool kvm_range_has_any_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+					    unsigned long mask);
 u64 kvm_supported_vm_mem_attributes(struct kvm *kvm);
+
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
 #else
 static inline u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
 {
@@ -2632,6 +2649,11 @@ static inline unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t
 {
 	return 0;
 }
+
+static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
+{
+	return 0;
+}
 #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
@@ -2676,16 +2698,19 @@ static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
 	return kvm_mem_attributes_may_write(attrs);
 }
 
-static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_generation, struct kvm_memslots **p_slots)
+static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_generation,
+					  u64 attrs_generation, struct kvm_memslots **p_slots)
 {
 	struct kvm_memslots *slots = *p_slots = kvm_memslots(kvm);
-	return slots->generation == slots_generation;
+	return slots->generation == slots_generation &&
+		kvm_mem_attributes_generation(kvm) == attrs_generation;
 }
 
-static inline bool kvm_check_gen(struct kvm *kvm, u64 slots_generation)
+static inline bool kvm_check_gen(struct kvm *kvm, u64 slots_generation,
+				 u64 attrs_generation)
 {
 	struct kvm_memslots *slots;
-	return kvm_memslots_check_gen(kvm, slots_generation, &slots);
+	return kvm_memslots_check_gen(kvm, slots_generation, attrs_generation, &slots);
 }
 
 
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
index 07013f88e655..0c5cb91ff929 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -371,23 +371,29 @@ TRACE_EVENT(kvm_dirty_ring_exit,
  * @attr:	The value of the attribute being set.
  */
 TRACE_EVENT(kvm_set_vm_mem_attributes,
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
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index da12f4d43c91..6aa6a0a55b07 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1136,6 +1136,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	xa_init_flags(&kvm->mem_attrs.array, XA_FLAGS_ACCOUNT);
+	kvm->mem_attrs.generation = 0;
 #endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
@@ -2558,6 +2559,53 @@ bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	return true;
 }
 
+/*
+ * Returns true if _any_ gfns in the range [@start, @end) have attributes that
+ * match _any_ bit in @mask.
+ */
+bool kvm_range_has_any_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+					unsigned long mask)
+{
+	XA_STATE(xas, &kvm->mem_attrs.array, start);
+	void *entry;
+
+	mask &= kvm_supported_vm_mem_attributes(kvm);
+	if (!mask)
+		return false;
+
+	if (end == start + 1)
+		return !!(kvm_get_vm_memory_attributes(kvm, start) & mask);
+
+	guard(rcu)();
+	for (;;) {
+		do {
+			entry = xas_next(&xas);
+		} while (xas_retry(&xas, entry));
+
+		if (xas.xa_node == XAS_BOUNDS || xas.xa_index >= end)
+			break;
+
+		if (xa_to_value(entry) & mask)
+			return true;
+	}
+
+	return false;
+}
+
+#define KVM_MEMORY_ATTRIBUTE_NEEDS_SYNC_MASK KVM_MEMORY_ATTRIBUTE_PROT
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
+	return kvm_range_has_any_vm_memory_attributes(kvm, start, end, mask);
+}
+
 static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 						 struct kvm_mmu_notifier_range *range)
 {
@@ -2648,20 +2696,25 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		.on_lock = kvm_mmu_invalidate_end,
 		.may_block = true,
 	};
+	bool sync = false;
 	unsigned long i;
 	void *entry;
 	int r = 0;
 
 	entry = attributes ? xa_mk_value(attributes) : NULL;
 
-	trace_kvm_set_vm_mem_attributes(start, end, attributes);
-
 	mutex_lock(&kvm->slots_lock);
 
 	/* Nothing to do if the entire range has the desired attributes. */
 	if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
 		goto out_unlock;
 
+	sync = kvm_range_memory_attributes_need_sync(kvm, start, end,
+						     attributes);
+
+	trace_kvm_set_vm_mem_attributes(start, end, attributes, sync,
+					kvm->mem_attrs.generation + 1);
+
 	/*
 	 * Reserve memory ahead of time to avoid having to deal with failures
 	 * partway through setting the new attributes.  Storing NULL never
@@ -2684,10 +2737,16 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
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
@@ -3582,7 +3641,8 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_write_guest);
 
-static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
+static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
+				       struct kvm_memslots *slots,
 				       struct gfn_to_hva_cache *ghc,
 				       gpa_t gpa, unsigned long len)
 {
@@ -3592,8 +3652,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
 	gfn_t nr_pages_needed = end_gfn - start_gfn + 1;
 	gfn_t nr_pages_avail;
 
-	/* Update ghc->generation before performing any error checks. */
-	ghc->generation = slots->generation;
+	/* Update ghc->slots_generation before performing any error checks. */
+	ghc->slots_generation = slots->generation;
 
 	if (start_gfn > end_gfn) {
 		ghc->hva = KVM_HVA_ERR_BAD;
@@ -3612,6 +3672,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
 			return -EFAULT;
 	}
 
+	ghc->attrs_generation = kvm_mem_attributes_generation(kvm);
+
 	/* Use the slow path for cross page reads and writes. */
 	if (nr_pages_needed == 1)
 		ghc->hva += offset;
@@ -3627,7 +3689,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
-	return __kvm_gfn_to_hva_cache_init(slots, ghc, gpa, len);
+	return __kvm_gfn_to_hva_cache_init(kvm, slots, ghc, gpa, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gfn_to_hva_cache_init);
 
@@ -3642,8 +3704,8 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
-		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->slots_generation, ghc->attrs_generation, &slots))) {
+		if (__kvm_gfn_to_hva_cache_init(kvm, slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
 
@@ -3680,8 +3742,8 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
-		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->slots_generation, ghc->attrs_generation, &slots))) {
+		if (__kvm_gfn_to_hva_cache_init(kvm, slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
 
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index ac02f6a065cc..e82247ca4637 100644
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


