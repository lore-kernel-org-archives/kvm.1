Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427099;
	b=pm0Q/8Culv11c1xNCBGhU8uiSLRxLoKB74T6Ml6E9yD/auar94V5cerz8DH1ssjdpJsH
	 PKueOil32waK/O8BKMNZ2MaNNrqMZRAJK7th2c7YQu3ntI6f1gG9iIjek1ESc7RDzwhzD
	 82ioaJRJgLZmsBcWAUwLGbDAMw8i42oz6kxcS+6Z495Nff3EdjgDW0qY0xEQt3wzwO4iC
	 9DZFIAA2X6MZFxftNreDJJvpwsfrUsSAiJg5uIUdnZF4naBsVx3ZMYjfvwSGb6fSCfszX
	 wDFtW/OAiYRW2hRasM6Eoo3IDqPjJPHs8fooJRrtLI97n46QfuuYrMqT3P8Y6/CM2yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427099;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=HBGKRs32jhmzs4ZETDbtWHztbcbFrOPxCWLtzOPlv5w=;
	b=M89PzbD4H/E1wqk9DfVq+iLZH9CEvkSHpIpRrur1ly8M8d2XaBtMBUHGYPgW1Jm84Azu
	 fygG3rJ0mg5ehcEARlM+C5+vqh90esc/qkGf03L0cJ0bg6tNGP5aSzIJc5G6tDYbUjewn
	 8a2hqqxeCpyE/dbfzR9BXS03hbDJc+/LchewuKky9isQNB7ky9pS65skcVMHErpC+35ft
	 6JxjpeRrO7SuQeqVLoqYEaQAsflgCSY+CNv6T6FeNzs4r+kEhjzdLdQ2Zg7T21/bhDE2f
	 MCCqnIJG0GLUQBtFKmHTM6StPHfNrywWzakoqdDqhxrvZcYKNLOYHgrQBHFoUqjsFfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rLQbblym;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76902606A328;
	Mon, 19 Oct 2026 16:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76902606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rLQbblym
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=HBGKRs32jhmzs4ZETDbtWHztbcbFrOPxCWLtzOPlv5w=; b=rLQbblymzvI6kXRTP7niDgbmhI
	KGPX1ZlBwKyh3mPoP4CFZmiiAzovE0s55pFfojbEQRKmOhBRkMCk3cOO50+8R7R1RR22foAgD71Go
	KSRnMXdRVvA6mR1xEjlU3xFSPHnlN3n05UDrLfuwRMPEAd+LfaHOTGDq0+ILRhmXGx42RXkZahfx5
	W7Y/Y8nVBsTx//AWlhIvbKVPU/9LtK8hS5Jlr+/scN+gasKxjNAIk83GdfOc/At9Mj1k8gfM/N7/x
	DuQPz38DIFyr9fIR/Km38SP8RYffbYsZ4Rt3A4YTRevk+LO5UqfOArl8/5Hyw9DuPOGeH/aLGwAug
	zzqSOdqQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAK-00000003qsm-1IaQ;
	Mon, 19 Oct 2026 16:24:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009gd-1DNT;
	Mon, 19 Oct 2026 17:24:45 +0100
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
Subject: [PATCH v4 03/12] KVM: pfncache: Add a 'wait' argument to the refresh and activate functions
Date: Mon, 19 Oct 2026 17:24:34 +0100
Message-ID: <20261019162445.37219-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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

The wait is a deliberate poll: a single memslot update bounds it, and
a cond_resched() loop is far simpler than wiring up a wake from the
update side. If a real workload ever cares, an rcuwait signalled on
memslot-update completion — mirroring mn_memslots_update_rcuwait for
the inverse direction — would be the follow-up.

The refresh now takes its own kvm->srcu read lock for each attempt, so
callers no longer need to hold it. Holding it with wait=true would
deadlock — the wait would block the memslot update from completing —
as would taking any lock held across the wait within a kvm->srcu read
section. The wait therefore functions as a synchronize_srcu() to
lockdep, via srcu_lock_sync(), making both cycles reportable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/msrs.c      |   2 +-
 arch/x86/kvm/x86.c       |   2 +-
 arch/x86/kvm/xen.c       |  24 ++++----
 include/linux/kvm_host.h |  24 ++++++--
 virt/kvm/pfncache.c      | 119 +++++++++++++++++++++++++++++----------
 5 files changed, 121 insertions(+), 50 deletions(-)

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
index 2a0477ad0c91..ac27b4795d69 100644
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
@@ -960,7 +960,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
-					     data->u.gpa, sizeof(struct vcpu_info));
+					     data->u.gpa, sizeof(struct vcpu_info), false);
 		} else {
 			if (data->u.hva == 0) {
 				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
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
@@ -2019,7 +2019,7 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			break;
 
 		idx = srcu_read_lock(&kvm->srcu);
-		rc = kvm_gpc_refresh(gpc, PAGE_SIZE);
+		rc = kvm_gpc_refresh(gpc, PAGE_SIZE, false);
 		srcu_read_unlock(&kvm->srcu, idx);
 	} while(!rc);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3dd04605f2e5..94989a705ee6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1474,16 +1474,24 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @gpa:	   guest physical address to map.
  * @len:	   sanity check; the range being access must fit a single page.
+ * @wait:	   wait out a concurrent memslot update instead of returning
+ *		   -EAGAIN. May not be used while this task holds any kvm->srcu
+ *		   read section, and no lock held across the wait may ever be
+ *		   taken within one: the update's synchronize_srcu() would
+ *		   deadlock against the wait. Lockdep checks both.
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
@@ -1496,10 +1504,13 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
  *                -EINVAL for a mapping which would cross a page boundary.
  *                -EFAULT for an untranslatable guest physical address.
  *
- * The semantics of this function are the same as those of kvm_gpc_activate(). It
- * merely bypasses a layer of address translation.
+ * The semantics of this function are the same as those of kvm_gpc_activate(),
+ * except that an HVA-based cache never consults the memslots and so can
+ * neither return -EAGAIN nor wait: it merely bypasses a layer of address
+ * translation.
  */
-int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsigned long len);
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva,
+			 unsigned long len);
 
 /**
  * kvm_gpc_check - check validity of a gfn_to_pfn_cache.
@@ -1524,10 +1535,13 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
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
@@ -1535,7 +1549,7 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
  * still lock and check the cache status, as this function does not return
  * with the lock still held to permit access.
  */
-int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
+int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len, bool wait);
 
 /**
  * kvm_gpc_deactivate - deactivate and unlink a gfn_to_pfn_cache.
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 17aaebd76db8..0e700c337f5a 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -378,23 +378,63 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
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
 {
-	unsigned long uhva;
+	int idx, ret;
 
-	guard(mutex)(&gpc->refresh_lock);
+	idx = srcu_read_lock(&gpc->kvm->srcu);
+	ret = __kvm_gpc_refresh(gpc, gpa, uhva);
+	srcu_read_unlock(&gpc->kvm->srcu, idx);
 
-	if (!kvm_gpc_is_valid_len(gpc->gpa, gpc->uhva, len))
-		return -EINVAL;
+	return ret;
+}
+
+int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len, bool wait)
+{
+	unsigned long uhva;
+	int ret;
 
 	/*
-	 * If the GPA is valid then ignore the HVA, as a cache can be GPA-based
-	 * or HVA-based, not both.  For GPA-based caches, the HVA will be
-	 * recomputed during refresh if necessary.
+	 * The wait completes only after a memslot update's
+	 * synchronize_srcu(&kvm->srcu), so it functions as one for lockdep:
+	 * taking any lock held across it within a kvm->srcu read section
+	 * is reported as the deadlock it would be.
 	 */
-	uhva = kvm_is_error_gpa(gpc->gpa) ? gpc->uhva : KVM_HVA_ERR_BAD;
+	if (wait)
+		srcu_lock_sync(&gpc->kvm->srcu.dep_map);
+
+	for (;;) {
+		scoped_guard(mutex, &gpc->refresh_lock) {
+			if (!kvm_gpc_is_valid_len(gpc->gpa, gpc->uhva, len))
+				return -EINVAL;
+
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
@@ -410,36 +450,51 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-			      unsigned long len)
+			      unsigned long len, bool wait)
 {
 	struct kvm *kvm = gpc->kvm;
 
 	if (!kvm_gpc_is_valid_len(gpa, uhva, len))
 		return -EINVAL;
 
-	guard(mutex)(&gpc->refresh_lock);
+	/* As in kvm_gpc_refresh(): the wait is a synchronize_srcu() to lockdep. */
+	if (wait)
+		srcu_lock_sync(&kvm->srcu.dep_map);
 
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
@@ -448,15 +503,17 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
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

