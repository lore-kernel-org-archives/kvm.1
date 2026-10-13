Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F354EECB;
	Tue, 13 Oct 2026 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924523; cv=none; b=M0XndgAkjrlpcDR6uwXD7VGlfL2DLmqPYlGtZq+F84ID1RolH8mVVWvTRtaftbE4eW52rT7OWyKpW/sxGzdYDPNOte3Zn2RMOH1OXT1wg/j0XPnrH2ASOXgX0jGcB3gJ3pCGzV/oEY3iDoYV1nr9hBbZMNaEqqLiKr3iAj6lBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924523; c=relaxed/simple;
	bh=LmmW12cqdAsFXwl+3hY4llUMSfiCZ0n3lbyL8fSPMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQWniu5HxCeHh7vXRYhXlfjDYfWDDGGK3+zOP2yWoSjSbjFJhu2Qyh36rGpANOO5TxnUFp8KwaSGl3ChDXVdfK6WlV//0sOWJg60JiIdnChL9rMZGqHr4kS77EzNlghST3OJxxQX147CYe+CVfY/2RiC/xveS/pM+uf1Pz3I854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XBHhd+6Z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XBHhd+6Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=Or9qWonUOiBVNTXio0dO7dNYdRAsovFXzCL0x3qrXfE=; b=XBHhd+6ZOKPHy5F4AXXc1XNbyP
	OGHPDZqYen9o5uQXwJbm+7v7gkL1OaNbqTAzV251cHCRo6S2HaYrw3FG1PNvo8R4Apz991whH1OeI
	MNUqFIzZac+5httimflDFSLycqMEEPbgLEbNqd//PxRjvbyBgF8xSg4z6aXngpoP8OUJkw5Rx2Wgn
	WfKdKRuOSssXFFOtAHskMCFjSjW5lbt1v3RAQ17/qprfdEJjq8fj17MaMzQxB+dWczRxcXJc6jlsZ
	CgZDTsojaue8EvrET5FnDWRWVjUIhJd4Rcm3ViIeSY7LPF5uE6cNFWCUdQULYPa7pzFzO48jsNe25
	alYFDOBw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQB-0000000G4C1-15yn;
	Tue, 13 Oct 2026 20:48:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQ8-00000001uAC-2YFh;
	Tue, 13 Oct 2026 21:48:24 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 02/10] KVM: pfncache: Add a 'wait' argument to the refresh and activate functions
Date: Tue, 13 Oct 2026 21:48:15 +0100
Message-ID: <20261013204824.454208-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013204824.454208-1-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

A caller which does not hold kvm->srcu may now pass wait=true to
kvm_gpc_refresh() or kvm_gpc_activate() to wait out a concurrent
memslot update instead of receiving -EAGAIN, looping with
cond_resched() until the lookup resolves or a fatal signal is
pending. (An HVA-based cache never consults the memslots, so
kvm_gpc_activate_hva() keeps its signature.)

The refresh now takes its own kvm->srcu read lock for each attempt, so
callers no longer need to hold it. Holding it with wait=true would
deadlock — the wait would block the memslot update from completing —
and is rejected with a lockdep assertion.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/msrs.c      |   2 +-
 arch/x86/kvm/x86.c       |   2 +-
 arch/x86/kvm/xen.c       |  28 +++++-----
 include/linux/kvm_host.h |  17 ++++--
 virt/kvm/pfncache.c      | 114 ++++++++++++++++++++++++++++-----------
 5 files changed, 112 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..4c0fbba6e7ae 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1280,7 +1280,7 @@ static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 	/* we verify if the enable bit is set... */
 	if (system_time & 1)
 		kvm_gpc_activate(&vcpu->arch.pv_time, system_time & ~1ULL,
-				 sizeof(struct pvclock_vcpu_time_info));
+				 sizeof(struct pvclock_vcpu_time_info), false);
 	else
 		kvm_gpc_deactivate(&vcpu->arch.pv_time);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..eadcaeee651a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1727,7 +1727,7 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
 		read_unlock_irqrestore(&gpc->lock, flags);
 
-		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
+		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock), false))
 			return;
 
 		read_lock_irqsave(&gpc->lock, flags);
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6aa00f746cba..fae893cd5762 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -50,7 +50,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
 		read_unlock_irq(&gpc->lock);
 
-		ret = kvm_gpc_refresh(gpc, PAGE_SIZE);
+		ret = kvm_gpc_refresh(gpc, PAGE_SIZE, false);
 		if (ret)
 			goto out;
 
@@ -161,7 +161,7 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcpu,
 	while (!kvm_gpc_check(gpc, offset + sizeof(*hv_clock))) {
 		read_unlock_irqrestore(&gpc->lock, flags);
 
-		r = kvm_gpc_refresh(gpc, offset + sizeof(*hv_clock));
+		r = kvm_gpc_refresh(gpc, offset + sizeof(*hv_clock), false);
 		if (r)
 			return r;
 
@@ -435,7 +435,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		if (atomic)
 			return;
 
-		if (kvm_gpc_refresh(gpc1, user_len1))
+		if (kvm_gpc_refresh(gpc1, user_len1, false))
 			return;
 
 		read_lock_irqsave(&gpc1->lock, flags);
@@ -488,7 +488,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 			 * 64-bit mode, the second GPC won't have been set up.
 			 */
 			if (kvm_gpc_activate(gpc2, gpc1->gpa + user_len1,
-					     user_len2))
+					     user_len2, false))
 				return;
 
 			/*
@@ -669,7 +669,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 		read_unlock_irqrestore(&gpc->lock, flags);
 
-		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info)))
+		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info), false))
 			return;
 
 		read_lock_irqsave(&gpc->lock, flags);
@@ -757,7 +757,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 		if (in_atomic() || !task_is_running(current))
 			return 1;
 
-		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info))) {
+		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info), false)) {
 			/*
 			 * If this failed, userspace has screwed up the
 			 * vcpu_info mapping. No interrupts for you.
@@ -813,7 +813,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 				r = 0;
 			} else {
 				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
-						     gfn_to_gpa(gfn), PAGE_SIZE);
+						     gfn_to_gpa(gfn), PAGE_SIZE, false);
 			}
 		} else {
 			void __user * hva = u64_to_user_ptr(data->u.shared_info.hva);
@@ -825,7 +825,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 				r = 0;
 			} else {
 				r = kvm_gpc_activate_hva(&kvm->arch.xen.shinfo_cache,
-							 (unsigned long)hva, PAGE_SIZE);
+							 (unsigned long)hva, PAGE_SIZE, false);
 			}
 		}
 
@@ -960,7 +960,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
-					     data->u.gpa, sizeof(struct vcpu_info));
+					     data->u.gpa, sizeof(struct vcpu_info), false);
 		} else {
 			if (data->u.hva == 0) {
 				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
@@ -973,7 +973,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 
 			r = kvm_gpc_activate_hva(&vcpu->arch.xen.vcpu_info_cache,
-						 data->u.hva, sizeof(struct vcpu_info));
+						 data->u.hva, sizeof(struct vcpu_info), false);
 		}
 
 		if (!r)
@@ -990,7 +990,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
 		r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_time_info_cache,
 				     data->u.gpa,
-				     sizeof(struct pvclock_vcpu_time_info));
+				     sizeof(struct pvclock_vcpu_time_info), false);
 		if (!r)
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		break;
@@ -1023,7 +1023,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		/* How much fits in the (first) page? */
 		sz1 = PAGE_SIZE - (data->u.gpa & ~PAGE_MASK);
 		r = kvm_gpc_activate(&vcpu->arch.xen.runstate_cache,
-				     data->u.gpa, sz1);
+				     data->u.gpa, sz1, false);
 		if (r)
 			goto deactivate_out;
 
@@ -1034,7 +1034,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			sz2 = sz - sz1;
 			BUG_ON((data->u.gpa + sz1) & ~PAGE_MASK);
 			r = kvm_gpc_activate(&vcpu->arch.xen.runstate2_cache,
-					     data->u.gpa + sz1, sz2);
+					     data->u.gpa + sz1, sz2, false);
 			if (r)
 				goto deactivate_out;
 		}
@@ -2011,7 +2011,7 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			break;
 
 		idx = srcu_read_lock(&kvm->srcu);
-		rc = kvm_gpc_refresh(gpc, PAGE_SIZE);
+		rc = kvm_gpc_refresh(gpc, PAGE_SIZE, false);
 		srcu_read_unlock(&kvm->srcu, idx);
 	} while(!rc);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3dd04605f2e5..88c1ee37550c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1474,16 +1474,23 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @gpa:	   guest physical address to map.
  * @len:	   sanity check; the range being access must fit a single page.
+ * @wait:	   wait out a concurrent memslot update instead of returning
+ *		   -EAGAIN. May not be used while this task holds any kvm->srcu
+ *		   read section (lockdep-asserted): the update's
+ *		   synchronize_srcu() would deadlock against the wait.
  *
  * @return:	   0 for success.
  *		   -EINVAL for a mapping which would cross a page boundary.
  *		   -EFAULT for an untranslatable guest physical address.
+ *		   -EAGAIN if the memslot is being updated (only with
+ *		   wait == false, or on a fatal signal while waiting).
  *
  * This primes a gfn_to_pfn_cache and links it into the @gpc->kvm's list for
  * invalidations to be processed.  Callers are required to use kvm_gpc_check()
  * to ensure that the cache is valid before accessing the target page.
  */
-int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len);
+int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len,
+		     bool wait);
 
 /**
  * kvm_gpc_activate_hva - prepare a cached kernel mapping and HPA for a given HVA.
@@ -1499,7 +1506,8 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
  * The semantics of this function are the same as those of kvm_gpc_activate(). It
  * merely bypasses a layer of address translation.
  */
-int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsigned long len);
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva,
+			 unsigned long len);
 
 /**
  * kvm_gpc_check - check validity of a gfn_to_pfn_cache.
@@ -1524,10 +1532,13 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
  *
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @len:	   sanity check; the range being access must fit a single page.
+ * @wait:	   as kvm_gpc_activate().
  *
  * @return:	   0 for success.
  *		   -EINVAL for a mapping which would cross a page boundary.
  *		   -EFAULT for an untranslatable guest physical address.
+ *		   -EAGAIN if the memslot is being updated (only with
+ *		   wait == false, or on a fatal signal while waiting).
  *
  * This will attempt to refresh a gfn_to_pfn_cache. Note that a successful
  * return from this function does not mean the page can be immediately
@@ -1535,7 +1546,7 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
  * still lock and check the cache status, as this function does not return
  * with the lock still held to permit access.
  */
-int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
+int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len, bool wait);
 
 /**
  * kvm_gpc_deactivate - deactivate and unlink a gfn_to_pfn_cache.
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 17aaebd76db8..8504e26fa111 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -378,23 +378,57 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	return ret;
 }
 
-int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
+/*
+ * One refresh attempt, under the caller's refresh_lock. Takes a kvm->srcu
+ * read section for the attempt, as the memslot lookups consult the active
+ * memslots.
+ */
+static int gpc_refresh_locked(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
+			      unsigned long uhva)
+{
+	int idx, ret;
+
+	idx = srcu_read_lock(&gpc->kvm->srcu);
+	ret = __kvm_gpc_refresh(gpc, gpa, uhva);
+	srcu_read_unlock(&gpc->kvm->srcu, idx);
+
+	return ret;
+}
+
+int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len, bool wait)
 {
 	unsigned long uhva;
+	int ret;
 
-	guard(mutex)(&gpc->refresh_lock);
+	if (wait)
+		lockdep_assert(!srcu_read_lock_held(&gpc->kvm->srcu));
 
-	if (!kvm_gpc_is_valid_len(gpc->gpa, gpc->uhva, len))
-		return -EINVAL;
+	for (;;) {
+		scoped_guard(mutex, &gpc->refresh_lock) {
+			if (!kvm_gpc_is_valid_len(gpc->gpa, gpc->uhva, len))
+				return -EINVAL;
 
-	/*
-	 * If the GPA is valid then ignore the HVA, as a cache can be GPA-based
-	 * or HVA-based, not both.  For GPA-based caches, the HVA will be
-	 * recomputed during refresh if necessary.
-	 */
-	uhva = kvm_is_error_gpa(gpc->gpa) ? gpc->uhva : KVM_HVA_ERR_BAD;
+			/*
+			 * If the GPA is valid then ignore the HVA, as a cache
+			 * can be GPA-based or HVA-based, not both.  For
+			 * GPA-based caches, the HVA will be recomputed during
+			 * refresh if necessary.
+			 */
+			uhva = kvm_is_error_gpa(gpc->gpa) ? gpc->uhva : KVM_HVA_ERR_BAD;
+
+			ret = gpc_refresh_locked(gpc, gpc->gpa, uhva);
+		}
+
+		if (ret != -EAGAIN || !wait || fatal_signal_pending(current))
+			return ret;
 
-	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
+		/*
+		 * Wait with refresh_lock dropped: a kvm->srcu reader blocked
+		 * on it must be able to proceed and quiesce, or the memslot
+		 * update being waited for could never complete.
+		 */
+		cond_resched();
+	}
 }
 
 void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
@@ -410,36 +444,50 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-			      unsigned long len)
+			      unsigned long len, bool wait)
 {
 	struct kvm *kvm = gpc->kvm;
 
 	if (!kvm_gpc_is_valid_len(gpa, uhva, len))
 		return -EINVAL;
 
-	guard(mutex)(&gpc->refresh_lock);
+	if (wait)
+		lockdep_assert(!srcu_read_lock_held(&kvm->srcu));
 
-	if (!gpc->active) {
-		if (KVM_BUG_ON(gpc->valid, kvm))
-			return -EIO;
+	for (;;) {
+		int ret;
 
-		spin_lock(&kvm->gpc_lock);
-		list_add(&gpc->list, &kvm->gpc_list);
-		spin_unlock(&kvm->gpc_lock);
+		scoped_guard(mutex, &gpc->refresh_lock) {
+			if (!gpc->active) {
+				if (KVM_BUG_ON(gpc->valid, kvm))
+					return -EIO;
 
-		/*
-		 * Activate the cache after adding it to the list, a concurrent
-		 * refresh must not establish a mapping until the cache is
-		 * reachable by mmu_notifier events.
-		 */
-		write_lock_irq(&gpc->lock);
-		gpc->active = true;
-		write_unlock_irq(&gpc->lock);
+				spin_lock(&kvm->gpc_lock);
+				list_add(&gpc->list, &kvm->gpc_list);
+				spin_unlock(&kvm->gpc_lock);
+
+				/*
+				 * Activate the cache after adding it to the
+				 * list, a concurrent refresh must not
+				 * establish a mapping until the cache is
+				 * reachable by mmu_notifier events.
+				 */
+				write_lock_irq(&gpc->lock);
+				gpc->active = true;
+				write_unlock_irq(&gpc->lock);
+			}
+			ret = gpc_refresh_locked(gpc, gpa, uhva);
+		}
+
+		if (ret != -EAGAIN || !wait || fatal_signal_pending(current))
+			return ret;
+
+		cond_resched();
 	}
-	return __kvm_gpc_refresh(gpc, gpa, uhva);
 }
 
-int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
+int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len,
+		     bool wait)
 {
 	/*
 	 * Explicitly disallow INVALID_GPA so that the magic value can be used
@@ -448,15 +496,17 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 	if (WARN_ON_ONCE(kvm_is_error_gpa(gpa)))
 		return -EINVAL;
 
-	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len);
+	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len, wait);
 }
 
-int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva, unsigned long len)
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva,
+			 unsigned long len)
 {
 	if (!access_ok((void __user *)uhva, len))
 		return -EINVAL;
 
-	return __kvm_gpc_activate(gpc, INVALID_GPA, uhva, len);
+	/* An HVA-based cache never consults the memslots, so never waits. */
+	return __kvm_gpc_activate(gpc, INVALID_GPA, uhva, len, false);
 }
 
 void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
-- 
2.43.0

