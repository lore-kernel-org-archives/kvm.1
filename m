Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9EF51C356
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057450; cv=none; b=JqMNM3Te/sDNBcsxA6IrTOrCL0yWejgzaR7ns45e4qDFhYStLs63YsPCxx8uIKQFH43njWEhNIpsQ4XSnOUUugIBbyHy8wVu7XWlVbPncuq/GoZUy+68B3x9fZ33atRtd7WI2mKSgorFRt7gf0wWBQlHzbM5Yop481XKZmAcmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057450; c=relaxed/simple;
	bh=ikMfwhMtZU9paqXK7lBJlN27t/Eb/3ljigo2KEZ0wtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJT58ibBuhBwV+pcAwFRjSqpFvsTqcUh4aleALfPVee/3LGhwcLuuZcqHO3ByL8R3oU87QqsVLDSTVUcxTrLrI5h3VuJF1h3iYGZSTNOykYjWbd08N3st6vGQZ4UiolwA88aAhZAyxjiIvjfAJuXGNJW1P1jVP7iImgNjFks1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqfAG1IL; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqfAG1IL"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49545071724so315645e9.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057443; x=1789662243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eg/KuATtTStoF6vYmBtiBei5rDkCm8qO1Fh60wlX3ho=;
        b=hqfAG1ILjIb05Zds96iPWj62EPV8ggngygUkJHEE8AXLQOHqI5QgOQbyzNIWU+oz3M
         pMAYNLxJQm85GQ7VxhLnmYFGMkhAVrhUPlRpNv28Al3tGkvlu1gTenkXGWEgKKZNjPt+
         rXBEluwGK4usgpQ3twmsceseFtnORrBSkK8PygzA4L11HRMvdpeUVorxQB4U0JbD5rYv
         2nCo5wWoXZJtSOVzexg75+ZQaVrDtQK3jWLvjzl4hGnyrk50sTaqrT8dHssC4+h5JaFd
         oFHPCC/fap1L8MGvkv2YWlhJZ6Rksvr9nZbGRNl3LXPR+qpXUF19isBal+9N1iWmYPFN
         K7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057443; x=1789662243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eg/KuATtTStoF6vYmBtiBei5rDkCm8qO1Fh60wlX3ho=;
        b=LFjgBbyvbMRisyJFt8Pp1d4jOHu18elRzYJqGw0d1BWs0MRfhU2Zd/LFQ6hwvcSef8
         7B9kMX46V3Cx+j/681xZD0KqaLNxsf7av6e5FYWf5dTTNcFjNMtcguk1W7TYg1yEY15h
         0aCPWtf0V/ifpVgGeqyECCETjfYceT0SdaK/usHIs9jg5Lrx8mqjCqCwqJwOHDTId+eC
         YsGGhfFsfIbfFPdGVMrjfPSPUVglOsUZuTM62q1VgOwqVryjEVO4JiiPy77eS/5Dhhd/
         Uormbijj1FDlw7b9wefVDgDrgCILQyRlEjzmmIk+SwKdWmQogySQtwwr2kYJRl6Cu2ow
         +gdw==
X-Forwarded-Encrypted: i=1; AKwUvBzcD6M4iFcuK+n7fjZdsCoaoi4m7m/RkRxi/Lx9oK5kxCZsFnlUxuxcZqH2GjKP6YrHUb8=@vger.kernel.org
X-Gm-Message-State: AFuF++lj2vmOn94I8jFcS56qYGBJcfSzHdB5mvGDLMJgSm2BTtp6l1fh
	j4UNsXZqbBQWMyMdzW2nUBcelcoJyUw7w34JIIFjePpLNZpHKQTEq5kvFenN/sZSEJrfSGfFruu
	TuQ==
X-Received: from wmnb18.prod.google.com ([2002:a05:600c:6d2:b0:49b:2006:9521])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4684:b0:49c:fc6c:be14
 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr386808385e9.26.1789057442334; Thu, 10
 Sep 2026 09:24:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:21:39 +0000
In-Reply-To: <20260910162343.4092060-1-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910162343.4092060-7-elver@google.com>
Subject: [PATCH RFC 06/10] KVM: Add basic lock context annotations
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add basic lock context annotations across common KVM sources.

The only opted-out functions are kvm_trylock_all_vcpus(),
kvm_lock_all_vcpus(), and kvm_unlock_all_vcpus(), which dynamically
acquire and release an arbitrary number of vCPU mutexes that cannot be
represented statically.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kvm_host.h | 202 +++++++++++++++++++++++++++------------
 virt/kvm/dirty_ring.c    |   2 +
 virt/kvm/eventfd.c       |   5 +
 virt/kvm/guest_memfd.c   |   1 +
 virt/kvm/kvm_main.c      |  40 +++++++-
 virt/kvm/pfncache.c      |   3 +
 6 files changed, 189 insertions(+), 64 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5ed8260ef01f..12f241304228 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -220,18 +220,6 @@ enum kvm_bus {
 	KVM_NR_BUSES
 };
 
-int kvm_io_bus_write(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
-		     int len, const void *val);
-int kvm_io_bus_write_cookie(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx,
-			    gpa_t addr, int len, const void *val, long cookie);
-int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
-		    int len, void *val);
-int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
-			    int len, struct kvm_io_device *dev);
-int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
-			      struct kvm_io_device *dev);
-struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
-					 gpa_t addr);
 
 #ifdef CONFIG_KVM_ASYNC_PF
 struct kvm_async_pf {
@@ -245,12 +233,6 @@ struct kvm_async_pf {
 	bool   wakeup_all;
 	bool notpresent_injected;
 };
-
-void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
-void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
-bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-			unsigned long hva, struct kvm_arch_async_pf *arch);
-int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
 union kvm_mmu_notifier_arg {
@@ -905,6 +887,25 @@ struct kvm {
 #define vcpu_err(vcpu, fmt, ...)					\
 	kvm_err("vcpu%i " fmt, (vcpu)->vcpu_id, ## __VA_ARGS__)
 
+int kvm_io_bus_write(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
+		     int len, const void *val)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int kvm_io_bus_write_cookie(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx,
+			    gpa_t addr, int len, const void *val, long cookie)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
+		    int len, void *val)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			    int len, struct kvm_io_device *dev)
+	__must_hold(&kvm->slots_lock);
+int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
+			      struct kvm_io_device *dev)
+	__must_hold(&kvm->slots_lock);
+struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
+					 gpa_t addr)
+	__must_hold_shared(&kvm->srcu);
+
 static inline void kvm_vm_dead(struct kvm *kvm)
 {
 	kvm->vm_dead = true;
@@ -956,6 +957,7 @@ static inline void kvm_vm_bugged(struct kvm *kvm)
 })
 
 static inline void kvm_vcpu_srcu_read_lock(struct kvm_vcpu *vcpu)
+	__acquires_shared(&vcpu->kvm->srcu)
 {
 #ifdef CONFIG_PROVE_RCU
 	WARN_ONCE(vcpu->srcu_depth++,
@@ -965,6 +967,7 @@ static inline void kvm_vcpu_srcu_read_lock(struct kvm_vcpu *vcpu)
 }
 
 static inline void kvm_vcpu_srcu_read_unlock(struct kvm_vcpu *vcpu)
+	__releases_shared(&vcpu->kvm->srcu)
 {
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->____srcu_idx);
 
@@ -985,6 +988,7 @@ static inline bool kvm_dirty_log_manual_protect_and_init_set(struct kvm *kvm)
  * registrations.
  */
 static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
+	__must_hold(&kvm->slots_lock)
 {
 	return rcu_dereference_protected(kvm->buses[idx],
 					 lockdep_is_held(&kvm->slots_lock));
@@ -1047,9 +1051,9 @@ static inline bool kvm_is_vcpu_creation_in_progress(struct kvm *kvm)
 
 void kvm_destroy_vcpus(struct kvm *kvm);
 
-int kvm_trylock_all_vcpus(struct kvm *kvm);
-int kvm_lock_all_vcpus(struct kvm *kvm);
-void kvm_unlock_all_vcpus(struct kvm *kvm);
+int kvm_trylock_all_vcpus(struct kvm *kvm) __must_hold(&kvm->lock);
+int kvm_lock_all_vcpus(struct kvm *kvm)    __must_hold(&kvm->lock);
+void kvm_unlock_all_vcpus(struct kvm *kvm) __must_hold(&kvm->lock);
 
 void vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
@@ -1085,6 +1089,7 @@ bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
+	__must_hold_shared(&kvm->srcu)
 {
 	as_id = array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
 	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
@@ -1094,11 +1099,13 @@ static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 }
 
 static inline struct kvm_memslots *kvm_memslots(struct kvm *kvm)
+	__must_hold_shared(&kvm->srcu)
 {
 	return __kvm_memslots(kvm, 0);
 }
 
 static inline struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int as_id = kvm_arch_vcpu_memslots_id(vcpu);
 
@@ -1110,7 +1117,8 @@ static inline bool kvm_memslots_empty(struct kvm_memslots *slots)
 	return RB_EMPTY_ROOT(&slots->gfn_tree);
 }
 
-bool kvm_are_all_memslots_empty(struct kvm *kvm);
+bool kvm_are_all_memslots_empty(struct kvm *kvm)
+	__must_hold(&kvm->slots_lock);
 
 #define kvm_for_each_memslot(memslot, bkt, slots)			      \
 	hash_for_each(slots->id_hash, bkt, memslot, id_node[slots->node_idx]) \
@@ -1225,9 +1233,10 @@ static inline bool kvm_memslot_iter_is_valid(struct kvm_memslot_iter *iter, gfn_
 	     kvm_memslot_iter_is_valid(iter, end);			\
 	     kvm_memslot_iter_next(iter))
 
-struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
-struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
-struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
+struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
+	__must_hold_shared(&kvm->srcu);
+struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 /*
  * KVM_SET_USER_MEMORY_REGION ioctl allows the following operations:
@@ -1248,7 +1257,8 @@ enum kvm_mr_change {
 };
 
 int kvm_set_internal_memslot(struct kvm *kvm,
-			     const struct kvm_userspace_memory_region2 *mem);
+			     const struct kvm_userspace_memory_region2 *mem)
+	__must_hold(&kvm->slots_lock);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
@@ -1268,14 +1278,18 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
 		       struct page **pages, int nr_pages);
 
-struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write);
+struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write)
+	__must_hold_shared(&kvm->srcu);
 static inline struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
+	__must_hold_shared(&kvm->srcu)
 {
 	return __gfn_to_page(kvm, gfn, true);
 }
 
-unsigned long gfn_to_hva(struct kvm *kvm, gfn_t gfn);
-unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable);
+unsigned long gfn_to_hva(struct kvm *kvm, gfn_t gfn)
+	__must_hold_shared(&kvm->srcu);
+unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
+	__must_hold_shared(&kvm->srcu);
 unsigned long gfn_to_hva_memslot(struct kvm_memory_slot *slot, gfn_t gfn);
 unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot, gfn_t gfn,
 				      bool *writable);
@@ -1324,30 +1338,40 @@ kvm_pfn_t __kvm_faultin_pfn(const struct kvm_memory_slot *slot, gfn_t gfn,
 static inline kvm_pfn_t kvm_faultin_pfn(struct kvm_vcpu *vcpu, gfn_t gfn,
 					bool write, bool *writable,
 					struct page **refcounted_page)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return __kvm_faultin_pfn(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn,
 				 write ? FOLL_WRITE : 0, writable, refcounted_page);
 }
 
 int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
-			int len);
-int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len);
+			int len)
+	__must_hold_shared(&kvm->srcu);
+int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len)
+	__must_hold_shared(&kvm->srcu);
 int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-			   void *data, unsigned long len);
+			   void *data, unsigned long len)
+	__must_hold_shared(&kvm->srcu);
 int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 				 void *data, unsigned int offset,
-				 unsigned long len);
+				 unsigned long len)
+	__must_hold_shared(&kvm->srcu);
 int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn, const void *data,
-			 int offset, int len);
+			 int offset, int len)
+	__must_hold_shared(&kvm->srcu);
 int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
-		    unsigned long len);
+		    unsigned long len)
+	__must_hold_shared(&kvm->srcu);
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-			   void *data, unsigned long len);
+			   void *data, unsigned long len)
+	__must_hold_shared(&kvm->srcu);
 int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 				  void *data, unsigned int offset,
-				  unsigned long len);
+				  unsigned long len)
+	__must_hold_shared(&kvm->srcu);
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-			      gpa_t gpa, unsigned long len);
+			      gpa_t gpa, unsigned long len)
+	__must_hold_shared(&kvm->srcu);
 
 #define __kvm_get_guest(kvm, gfn, offset, v)				\
 ({									\
@@ -1391,32 +1415,42 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			offset_in_page(__gpa), v);			\
 })
 
-int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len);
-bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn);
-bool kvm_vcpu_is_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
-unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn);
+int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
+	__must_hold_shared(&kvm->srcu);
+bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn)
+	__must_hold_shared(&kvm->srcu);
+bool kvm_vcpu_is_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
+	__must_hold_shared(&vcpu->kvm->srcu);
+unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void mark_page_dirty_in_slot(struct kvm *kvm, const struct kvm_memory_slot *memslot, gfn_t gfn);
-void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
-void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
+void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
+	__must_hold_shared(&kvm->srcu);
+void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
-		   bool writable);
+		   bool writable)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
 
 static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,
 			       struct kvm_host_map *map)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return __kvm_vcpu_map(vcpu, gfn, map, true);
 }
 
 static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gfn_t gfn,
 					struct kvm_host_map *map)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return __kvm_vcpu_map(vcpu, gfn, map, false);
 }
 
 static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
 					   struct kvm_host_map *map)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (kvm_vcpu_mapped(map))
 		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
@@ -1441,18 +1475,25 @@ DEFINE_CLASS(kvm_vcpu_map_local##ro, kvm_vcpu_local_map_t,		\
 DEFINE_VCPU_MAP_CLASS();
 DEFINE_VCPU_MAP_CLASS(_readonly);
 
-unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
-unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
+unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn)
+	__must_hold_shared(&vcpu->kvm->srcu);
+unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
-			     int len);
+			     int len)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa, void *data,
-			       unsigned long len);
+			       unsigned long len)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data,
-			unsigned long len);
+			unsigned long len)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, const void *data,
-			      int offset, int len);
+			      int offset, int len)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
-			 unsigned long len);
+			 unsigned long len)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 /**
  * kvm_gpc_init - initialize gfn_to_pfn_cache.
@@ -1482,7 +1523,8 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
  * invalidations to be processed.  Callers are required to use kvm_gpc_check()
  * to ensure that the cache is valid before accessing the target page.
  */
-int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len);
+int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
+	__must_hold_shared(&gpc->kvm->srcu);
 
 /**
  * kvm_gpc_activate_hva - prepare a cached kernel mapping and HPA for a given HVA.
@@ -1498,7 +1540,8 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
  * The semantics of this function are the same as those of kvm_gpc_activate(). It
  * merely bypasses a layer of address translation.
  */
-int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsigned long len);
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsigned long len)
+	__must_hold_shared(&gpc->kvm->srcu);
 
 /**
  * kvm_gpc_check - check validity of a gfn_to_pfn_cache.
@@ -1516,7 +1559,8 @@ int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsign
  * Callers in IN_GUEST_MODE may do so without locking, although they should
  * still hold a read lock on kvm->scru for the memslot checks.
  */
-bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
+bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
+	__must_hold_shared(&gpc->kvm->srcu);
 
 /**
  * kvm_gpc_refresh - update a previously initialized cache.
@@ -1534,7 +1578,8 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
  * still lock and check the cache status, as this function does not return
  * with the lock still held to permit access.
  */
-int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
+int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
+	__must_hold_shared(&gpc->kvm->srcu);
 
 /**
  * kvm_gpc_deactivate - deactivate and unlink a gfn_to_pfn_cache.
@@ -1652,6 +1697,31 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu);
 
+#ifdef CONFIG_KVM_ASYNC_PF
+void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
+void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
+bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
+			unsigned long hva, struct kvm_arch_async_pf *arch)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
+
+bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
+				     struct kvm_async_pf *work)
+	__must_hold_shared(&vcpu->kvm->srcu);
+void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
+				 struct kvm_async_pf *work)
+	__must_hold_shared(&vcpu->kvm->srcu);
+void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
+			       struct kvm_async_pf *work)
+	__must_hold_shared(&vcpu->kvm->srcu);
+#ifndef CONFIG_KVM_ASYNC_PF_SYNC
+void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu);
+#endif
+bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
+#endif
+
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state);
 #endif
@@ -1824,8 +1894,10 @@ struct kvm_irq_ack_notifier {
 };
 
 int kvm_irq_map_gsi(struct kvm *kvm,
-		    struct kvm_kernel_irq_routing_entry *entries, int gsi);
-int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin);
+		    struct kvm_kernel_irq_routing_entry *entries, int gsi)
+	__must_hold_shared(&kvm->irq_srcu);
+int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
+	__must_hold_shared(&kvm->irq_srcu);
 
 int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 		bool line_status);
@@ -1835,7 +1907,8 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 			       struct kvm *kvm, int irq_source_id,
 			       int level, bool line_status);
 bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin);
-void kvm_notify_acked_gsi(struct kvm *kvm, int gsi);
+void kvm_notify_acked_gsi(struct kvm *kvm, int gsi)
+	__must_hold_shared(&kvm->irq_srcu);
 void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin);
 void kvm_register_irq_ack_notifier(struct kvm *kvm,
 				   struct kvm_irq_ack_notifier *kian);
@@ -1937,6 +2010,7 @@ __gfn_to_hva_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
 }
 
 static inline int memslot_id(struct kvm *kvm, gfn_t gfn)
+	__must_hold_shared(&kvm->srcu)
 {
 	return gfn_to_memslot(kvm, gfn)->id;
 }
@@ -1965,6 +2039,7 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
 }
 
 static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
+	__must_hold_shared(&kvm->srcu)
 {
 	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
 
@@ -2265,7 +2340,8 @@ void kvm_irqfd_release(struct kvm *kvm);
 bool kvm_notify_irqfd_resampler(struct kvm *kvm,
 				unsigned int irqchip,
 				unsigned int pin);
-void kvm_irq_routing_update(struct kvm *);
+void kvm_irq_routing_update(struct kvm *kvm)
+	__must_hold(&kvm->irq_lock);
 #else
 static inline int kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
 {
@@ -2282,7 +2358,8 @@ static inline bool kvm_notify_irqfd_resampler(struct kvm *kvm,
 }
 #endif /* CONFIG_HAVE_KVM_IRQCHIP */
 
-void kvm_arch_irq_routing_update(struct kvm *kvm);
+void kvm_arch_irq_routing_update(struct kvm *kvm)
+	__must_hold(&kvm->irq_lock);
 
 static inline void __kvm_make_request(int req, struct kvm_vcpu *vcpu)
 {
@@ -2632,7 +2709,8 @@ typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 		       long npages, bool may_writeback_src,
-		       kvm_gmem_populate_cb post_populate, void *opaque);
+		       kvm_gmem_populate_cb post_populate, void *opaque)
+	__must_hold(&kvm->slots_lock);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..11a6aba98b5e 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -51,6 +51,7 @@ static bool kvm_dirty_ring_full(struct kvm_dirty_ring *ring)
 }
 
 static void kvm_reset_dirty_gfn(struct kvm *kvm, u32 slot, u64 offset, u64 mask)
+	__must_hold(&kvm->slots_lock)
 {
 	struct kvm_memory_slot *memslot;
 	int as_id, id;
@@ -61,6 +62,7 @@ static void kvm_reset_dirty_gfn(struct kvm *kvm, u32 slot, u64 offset, u64 mask)
 	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_USER_MEM_SLOTS)
 		return;
 
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 	memslot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
 
 	if (!memslot || offset >= memslot->npages ||
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 93ad2ebc963f..6701390336f6 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -271,6 +271,7 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 }
 
 static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
+	__must_hold_shared(&kvm->irq_srcu)
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_kernel_irq_routing_entry entries[KVM_NR_IRQCHIPS];
@@ -300,6 +301,7 @@ struct kvm_irqfd_pt {
 
 static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 			       poll_table *pt)
+	__must_hold_shared(&container_of(pt, struct kvm_irqfd_pt, pt)->kvm->irq_srcu)
 {
 	struct kvm_irqfd_pt *p = container_of(pt, struct kvm_irqfd_pt, pt);
 	struct kvm_kernel_irqfd *irqfd = p->irqfd;
@@ -660,6 +662,9 @@ void kvm_irq_routing_update(struct kvm *kvm)
 {
 	struct kvm_kernel_irqfd *irqfd;
 
+	/* Update-side mutex kvm->irq_lock is held. */
+	__assume_shared_ctx_lock(&kvm->irq_srcu);
+
 	spin_lock_irq(&kvm->irqfds.lock);
 
 	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 896f3b076562..bc97e566559e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -836,6 +836,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 	long i;
 
 	lockdep_assert_held(&kvm->slots_lock);
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 
 	if (WARN_ON_ONCE(npages <= 0))
 		return -EINVAL;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f86e690a1798..2f22d5439d39 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -560,6 +560,7 @@ static void kvm_null_fn(void)
 
 static __always_inline bool __kvm_handle_hva_range_walk(struct kvm *kvm,
 							const struct kvm_mmu_notifier_range *range)
+	__must_hold_shared(&kvm->srcu)
 {
 	struct kvm_gfn_range gfn_range;
 	struct kvm_memory_slot *slot;
@@ -1379,6 +1380,7 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 }
 
 int kvm_trylock_all_vcpus(struct kvm *kvm)
+	__context_unsafe(/* multi-lock acquisition */)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i, j;
@@ -1401,6 +1403,7 @@ int kvm_trylock_all_vcpus(struct kvm *kvm)
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_trylock_all_vcpus);
 
 int kvm_lock_all_vcpus(struct kvm *kvm)
+	__context_unsafe(/* multi-lock acquisition */)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i, j;
@@ -1426,6 +1429,7 @@ int kvm_lock_all_vcpus(struct kvm *kvm)
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lock_all_vcpus);
 
 void kvm_unlock_all_vcpus(struct kvm *kvm)
+	__context_unsafe(/* multi-lock release */)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
@@ -1453,7 +1457,9 @@ static int kvm_alloc_dirty_bitmap(struct kvm_memory_slot *memslot)
 }
 
 static struct kvm_memslots *kvm_get_inactive_memslots(struct kvm *kvm, int as_id)
+	__must_hold(&kvm->slots_lock)
 {
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 	struct kvm_memslots *active = __kvm_memslots(kvm, as_id);
 	int node_idx_inactive = active->node_idx ^ 1;
 
@@ -1535,6 +1541,7 @@ static void kvm_replace_gfn_node(struct kvm_memslots *slots,
 static void kvm_replace_memslot(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				struct kvm_memory_slot *new)
+	__must_hold(&kvm->slots_lock)
 {
 	int as_id = kvm_memslots_get_as_id(old, new);
 	struct kvm_memslots *slots = kvm_get_inactive_memslots(kvm, as_id);
@@ -1621,9 +1628,11 @@ static int check_memory_region_flags(struct kvm *kvm,
 }
 
 static void kvm_swap_active_memslots(struct kvm *kvm, int as_id)
+	__must_hold(&kvm->slots_lock)
+	__releases(&kvm->slots_arch_lock)
 {
 	struct kvm_memslots *slots = kvm_get_inactive_memslots(kvm, as_id);
-
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side locks are held */
 	/* Grab the generation from the activate memslots. */
 	u64 gen = __kvm_memslots(kvm, as_id)->generation;
 
@@ -1796,6 +1805,8 @@ static void kvm_commit_memory_region(struct kvm *kvm,
 static void kvm_activate_memslot(struct kvm *kvm,
 				 struct kvm_memory_slot *old,
 				 struct kvm_memory_slot *new)
+	__must_hold(&kvm->slots_lock)
+	__releases(&kvm->slots_arch_lock)
 {
 	int as_id = kvm_memslots_get_as_id(old, new);
 
@@ -1821,6 +1832,8 @@ static void kvm_copy_memslot(struct kvm_memory_slot *dest,
 static void kvm_invalidate_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *old,
 				   struct kvm_memory_slot *invalid_slot)
+	__must_hold(&kvm->slots_lock)
+	__must_hold(&kvm->slots_arch_lock)
 {
 	/*
 	 * Mark the current slot INVALID.  As with all memslot modifications,
@@ -1862,6 +1875,8 @@ static void kvm_invalidate_memslot(struct kvm *kvm,
 
 static void kvm_create_memslot(struct kvm *kvm,
 			       struct kvm_memory_slot *new)
+	__must_hold(&kvm->slots_lock)
+	__releases(&kvm->slots_arch_lock)
 {
 	/* Add the new memslot to the inactive set and activate. */
 	kvm_replace_memslot(kvm, NULL, new);
@@ -1871,6 +1886,8 @@ static void kvm_create_memslot(struct kvm *kvm,
 static void kvm_delete_memslot(struct kvm *kvm,
 			       struct kvm_memory_slot *old,
 			       struct kvm_memory_slot *invalid_slot)
+	__must_hold(&kvm->slots_lock)
+	__releases(&kvm->slots_arch_lock)
 {
 	/*
 	 * Remove the old memslot (in the inactive memslots) by passing NULL as
@@ -1884,6 +1901,8 @@ static void kvm_move_memslot(struct kvm *kvm,
 			     struct kvm_memory_slot *old,
 			     struct kvm_memory_slot *new,
 			     struct kvm_memory_slot *invalid_slot)
+	__must_hold(&kvm->slots_lock)
+	__releases(&kvm->slots_arch_lock)
 {
 	/*
 	 * Replace the old memslot in the inactive slots, and then swap slots
@@ -1896,6 +1915,8 @@ static void kvm_move_memslot(struct kvm *kvm,
 static void kvm_update_flags_memslot(struct kvm *kvm,
 				     struct kvm_memory_slot *old,
 				     struct kvm_memory_slot *new)
+	__must_hold(&kvm->slots_lock)
+	__releases(&kvm->slots_arch_lock)
 {
 	/*
 	 * Similar to the MOVE case, but the slot doesn't need to be zapped as
@@ -1910,6 +1931,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 			   struct kvm_memory_slot *old,
 			   struct kvm_memory_slot *new,
 			   enum kvm_mr_change change)
+	__must_hold(&kvm->slots_lock)
 {
 	struct kvm_memory_slot *invalid_slot;
 	int r;
@@ -2016,6 +2038,7 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
 
 static int kvm_set_memory_region(struct kvm *kvm,
 				 const struct kvm_userspace_memory_region2 *mem)
+	__must_hold(&kvm->slots_lock)
 {
 	struct kvm_memory_slot *old, *new;
 	struct kvm_memslots *slots;
@@ -2026,6 +2049,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	int r;
 
 	lockdep_assert_held(&kvm->slots_lock);
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 
 	r = check_memory_region_flags(kvm, mem);
 	if (r)
@@ -2242,6 +2266,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_dirty_log);
  *
  */
 static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
+	__must_hold(&kvm->slots_lock)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
@@ -2260,6 +2285,7 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
 	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 	slots = __kvm_memslots(kvm, as_id);
 	memslot = id_to_memslot(slots, id);
 	if (!memslot || !memslot->dirty_bitmap)
@@ -2353,6 +2379,7 @@ static int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
  */
 static int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				       struct kvm_clear_dirty_log *log)
+	__must_hold(&kvm->slots_lock)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
@@ -2375,6 +2402,7 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
 	if (log->first_page & 63)
 		return -EINVAL;
 
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 	slots = __kvm_memslots(kvm, as_id);
 	memslot = id_to_memslot(slots, id);
 	if (!memslot || !memslot->dirty_bitmap)
@@ -2487,6 +2515,7 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 static __always_inline bool __kvm_handle_gfn_range_walk(struct kvm *kvm,
 							struct kvm_mmu_notifier_range *range)
+	__must_hold(&kvm->slots_lock)
 {
 	struct kvm_gfn_range gfn_range;
 	struct kvm_memory_slot *slot;
@@ -2506,6 +2535,7 @@ static __always_inline bool __kvm_handle_gfn_range_walk(struct kvm *kvm,
 	 * if the private flag is being toggled, i.e. all mappings are in play.
 	 */
 
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		slots = __kvm_memslots(kvm, i);
 
@@ -2527,6 +2557,7 @@ static __always_inline bool __kvm_handle_gfn_range_walk(struct kvm *kvm,
 
 static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 						 struct kvm_mmu_notifier_range *range)
+	__must_hold(&kvm->slots_lock)
 {
 	struct kvm_memslot_iter iter;
 	struct kvm_memslots *slots;
@@ -2534,6 +2565,7 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 	bool ret;
 	int i;
 
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		slots = __kvm_memslots(kvm, i);
 		kvm_for_each_memslot_in_gfn_range(&iter, slots, range->start, range->end) {
@@ -3201,8 +3233,10 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
 		memunmap(map->hva);
 #endif
 
-	if (map->writable)
+	if (map->writable) {
+		__assume_shared_ctx_lock(&vcpu->kvm->srcu); /* srcu held or VM being destroyed */
 		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
+	}
 
 	if (map->pinned_page) {
 		if (map->writable)
@@ -5075,6 +5109,7 @@ bool kvm_are_all_memslots_empty(struct kvm *kvm)
 	int i;
 
 	lockdep_assert_held(&kvm->slots_lock);
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		if (!kvm_memslots_empty(__kvm_memslots(kvm, i)))
@@ -5930,6 +5965,7 @@ static int __kvm_io_bus_write(struct kvm_vcpu *vcpu, struct kvm_io_bus *bus,
 }
 
 static struct kvm_io_bus *kvm_get_bus_srcu(struct kvm *kvm, enum kvm_bus idx)
+	__must_hold_shared(&kvm->srcu)
 {
 	/*
 	 * Ensure that any updates to kvm_buses[] observed by the previous vCPU
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..f883fbad3487 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -153,6 +153,7 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 }
 
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
+	__must_hold(&gpc->lock)
 {
 	/* Note, the new page offset may be different than the old! */
 	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
@@ -254,6 +255,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 }
 
 static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva)
+	__must_hold_shared(&gpc->kvm->srcu)
 {
 	unsigned long page_offset;
 	bool unmap_old = false;
@@ -396,6 +398,7 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
 			      unsigned long len)
+	__must_hold_shared(&gpc->kvm->srcu)
 {
 	struct kvm *kvm = gpc->kvm;
 
-- 
2.55.0.1003.g10538fe699-goog

