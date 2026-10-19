Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427102;
	b=mrxpi52EIV8Oki/UMUoqBJ71hWACwLMS7+xy4WS6ttIkQSGoTg3QD4kbyfoAim5x4RVF
	 20Suyx/t+AxxylUlfKNn4fMOo8ZcxVl8P5+bsc3FmHZLs5Lh7qjNnmNDM5NV9ASSRfFF2
	 +RgOXUKXsfH1G9mbbVMWVhVE+YHRIYck+ynl1b2q9Gvsm1jesrKPnTvFIHG16bd9ghpyO
	 OHqJlx2sqOqCeZQ7nZiRt/ftGwLathXEftGpiZ2YG3DTAsyZWLYc6rTpt4PzlBaEcpD98
	 hzoQZoc2TiobxiPfgTO5NaH80qNjzm43AXGCi+t32OAuI7QWJo4uTX5bvykn72OMIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427102;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=zjqCyCGBCCDyRk9Gb16bTRiDfPQSCM5vy/BOvodCgA8=;
	b=g07G2lJq77DdGwdPpJT5iMTPSwqbtNXHRa0KFsNvGrDT5s4UiXmmTGZ3656kJT1cmqAV
	 rHzyMJ3bapV1IdmXJqoaz2AqjTy9z/oVyUHX5COsuLzZQelbhIEvM77+0rwA5HYA2gv3D
	 VhTup4rGDyTPROr85FZQ/1l2XS2zas0WqrFddi2cMPzXQXSdzmZJa89EWb/ESVAa9qnCN
	 iJ+S97DrPPxd/JnksR5AsoOA+LLemlQcNZrl36S5Fo18wbym6Ei0LQYWwPO0glsF/SIjf
	 8V237pE9M338GXuHuODIZ73BoRcp3TKvBXEDkXjX5gnWAsgNuGggyGQ1u5KIFE2pZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB1606A319;
	Mon, 19 Oct 2026 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBB1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=zjqCyCGBCCDyRk9Gb16bTRiDfPQSCM5vy/BOvodCgA8=; b=bgiYRe53i1XdaYRJpGMT/1rLt4
	K7o5Hp/pIU5bwxi/JqXQp0cTo27PXz891gjFPh8cNv5L+idxUF/Ux9Ke8BsQtCp/R3iN+lxvx1Zef
	UxiOjoRZwRAmKceSJ1v6e8s7BGJlRT3ifF4PQLoePpJBPy1XkVZwtoSrMd8UYY1yyJOdTfwIHGq+i
	xO/OqwvZeveuYDVSYHHKeoW3IJ8Cif9wKB1j2u4wmwS87fWd9ahVVNmzNiPFu0HVTLC2aAeAyqFb5
	r4Jhtth7ucP9CI+HQ9H8B7xH+EKLtBjUHcLyoT9vzYdQr+pjWlewJM7kIQSBCP9kt/jHpNnsGPzc2
	iU0LQuPA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqAH-00000009VGJ-3MbY;
	Mon, 19 Oct 2026 16:24:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009gg-1MLb;
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
Subject: [PATCH v4 04/12] KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls
Date: Mon, 19 Oct 2026 17:24:35 +0100
Message-ID: <20261019162445.37219-5-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Activating a shared_info, vcpu_info, pvclock or runstate cache can
fail if it races a memslot update: previously with -EFAULT, now with
-EAGAIN. These ioctls may sleep, so pass wait and let the activation
ride the update out; userspace never sees the transient state.

No waiting happens while xen_lock is held. A vCPU writing the
hypercall page MSR blocks on xen_lock from within its kvm->srcu read
section, and the memslot update cannot complete until that section
quiesces, so waiting while holding the lock would deadlock all three.
kvm_xen_shared_info_init() is called with the lock held — keeping the
wallclock publish single-writer — and drops it internally across any
refresh; the publish location is chosen by re-reading long_mode under
the re-taken lock. The activation calls wait with the lock dropped at
the call site. Callers get no state continuity across those waits;
concurrent SET_ATTR calls racing through the window are userspace's
own race, and the last one wins. Document the rule at the lock's
definition.

The hypercall page MSR write cannot wait at all — it would be waiting
out its own srcu read section — so its shared_info re-init passes
wait=false and ignores -EAGAIN, skipping the wallclock update and
leaving the new mode's wallclock stale — or, on a first bitness
change, never written. Nothing retries that, but the guest latches
its bitness via the hypercall page early in boot, when nothing should
be changing memslots anyway. A real failure (-EFAULT) still fails the
WRMSR as it always did.

kvm_xen_shared_info_init() gains the wait flag for its refresh.
It and xen_get_guest_pvclock() keep a kvm->srcu read section around
each kvm_gpc_check() and the access through the mapping — the check
consults the memslots — but drop it across the refresh.

The kvm->srcu read sections around the activation calls go away;
they existed to satisfy the old refresh contract, and holding one
across a waiting activation would deadlock against the memslot
update. The runstate updates in kvm_xen_vcpu_set_attr() still read
guest state through the caches, so they keep narrow read sections
of their own.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h |   6 ++
 arch/x86/kvm/xen.c              | 129 +++++++++++++++++++++++---------
 2 files changed, 100 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3af7395c2430..ed633a39a97a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1108,6 +1108,12 @@ struct kvm_hv {
 #ifdef CONFIG_KVM_XEN
 /* Xen emulation context */
 struct kvm_xen {
+	/*
+	 * Taken from within kvm->srcu read sections (e.g. by a vCPU
+	 * writing the hypercall page MSR), so never held while waiting
+	 * out a memslot update: the update waits for those read
+	 * sections to quiesce.
+	 */
 	struct mutex xen_lock;
 	u32 xen_version;
 	bool long_mode;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index ac27b4795d69..8c49ec8aa4d9 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -36,7 +36,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
-static int kvm_xen_shared_info_init(struct kvm *kvm)
+static int kvm_xen_shared_info_init(struct kvm *kvm, bool wait)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct pvclock_wall_clock *wc;
@@ -44,17 +44,35 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	u32 wc_version;
 	u64 wall_nsec;
 	int ret = 0;
-	int idx = srcu_read_lock(&kvm->srcu);
+	int idx;
 
-	read_lock_irq(&gpc->lock);
-	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
+	/* We only really use xen_lock here to serialize wallclock updates. */
+	lockdep_assert_held(&kvm->arch.xen.xen_lock);
+
+	/*
+	 * kvm_gpc_check() consults the memslots, so take kvm->srcu
+	 * around each check and the write through the mapping — but not
+	 * across the refresh.
+	 */
+
+	for (;;) {
+		idx = srcu_read_lock(&kvm->srcu);
+		read_lock_irq(&gpc->lock);
+		if (kvm_gpc_check(gpc, PAGE_SIZE))
+			break;
 		read_unlock_irq(&gpc->lock);
+		srcu_read_unlock(&kvm->srcu, idx);
 
-		ret = kvm_gpc_refresh(gpc, PAGE_SIZE, false);
+		/*
+		 * Drop xen_lock across the refresh, which may wait out a
+		 * memslot update that cannot complete while a vCPU is
+		 * blocked on xen_lock within its kvm->srcu read section.
+		 */
+		mutex_unlock(&kvm->arch.xen.xen_lock);
+		ret = kvm_gpc_refresh(gpc, PAGE_SIZE, wait);
+		mutex_lock(&kvm->arch.xen.xen_lock);
 		if (ret)
 			goto out;
-
-		read_lock_irq(&gpc->lock);
 	}
 
 	/*
@@ -98,9 +116,9 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 
 	wc->version = wc_version + 1;
 	read_unlock_irq(&gpc->lock);
+	srcu_read_unlock(&kvm->srcu, idx);
 
 out:
-	srcu_read_unlock(&kvm->srcu, idx);
 	return ret;
 }
 
@@ -155,21 +173,29 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcpu,
 				 unsigned int offset)
 {
 	unsigned long flags;
-	int r;
+	int idx, r;
 
-	read_lock_irqsave(&gpc->lock, flags);
-	while (!kvm_gpc_check(gpc, offset + sizeof(*hv_clock))) {
+	/*
+	 * As in kvm_xen_shared_info_init(): kvm_gpc_check() consults the
+	 * memslots, so take kvm->srcu around each check and the copy, but
+	 * not across the refresh.
+	 */
+	for (;;) {
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+		read_lock_irqsave(&gpc->lock, flags);
+		if (kvm_gpc_check(gpc, offset + sizeof(*hv_clock)))
+			break;
 		read_unlock_irqrestore(&gpc->lock, flags);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
 		r = kvm_gpc_refresh(gpc, offset + sizeof(*hv_clock), false);
 		if (r)
 			return r;
-
-		read_lock_irqsave(&gpc->lock, flags);
 	}
 
 	memcpy(hv_clock, gpc->khva + offset, sizeof(*hv_clock));
 	read_unlock_irqrestore(&gpc->lock, flags);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
 	/*
 	 * Sanity check TSC shift+multiplier to verify the guest's view of time
@@ -776,7 +802,6 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 {
 	int r = -ENOENT;
 
-
 	switch (data->type) {
 	case KVM_XEN_ATTR_TYPE_LONG_MODE:
 		if (!IS_ENABLED(CONFIG_64BIT) && data->u.long_mode) {
@@ -792,19 +817,23 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 			 * to make the call anyway.
 			 */
 			r = kvm->arch.xen.shinfo_cache.active ?
-				kvm_xen_shared_info_init(kvm) : 0;
+				kvm_xen_shared_info_init(kvm, true) : 0;
 			mutex_unlock(&kvm->arch.xen.xen_lock);
 		}
 		break;
 
 	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
 	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
-		int idx;
-
+		/*
+		 * Deactivation stays under xen_lock, but an activation may
+		 * wait out a memslot update and so must not hold it: a vCPU
+		 * may block on xen_lock from within the kvm->srcu read
+		 * section which that update must wait out. Concurrent
+		 * SET_ATTR calls racing in the window are userspace's own
+		 * race; the cache layer serializes them, last one wins.
+		 */
 		mutex_lock(&kvm->arch.xen.xen_lock);
 
-		idx = srcu_read_lock(&kvm->srcu);
-
 		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
 			gfn_t gfn = data->u.shared_info.gfn;
 
@@ -812,8 +841,10 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
 				r = 0;
 			} else {
+				mutex_unlock(&kvm->arch.xen.xen_lock);
 				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
-						     gfn_to_gpa(gfn), PAGE_SIZE, false);
+						     gfn_to_gpa(gfn), PAGE_SIZE, true);
+				mutex_lock(&kvm->arch.xen.xen_lock);
 			}
 		} else {
 			void __user * hva = u64_to_user_ptr(data->u.shared_info.hva);
@@ -829,10 +860,8 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 			}
 		}
 
-		srcu_read_unlock(&kvm->srcu, idx);
-
 		if (!r && kvm->arch.xen.shinfo_cache.active)
-			r = kvm_xen_shared_info_init(kvm);
+			r = kvm_xen_shared_info_init(kvm, true);
 
 		mutex_unlock(&kvm->arch.xen.xen_lock);
 		break;
@@ -937,7 +966,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 	int idx, r = -ENOENT;
 
 	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	switch (data->type) {
 	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO:
@@ -959,8 +987,16 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			if (!IS_ALIGNED(data->u.gpa, sizeof(u32)))
 				break;
 
+			/*
+			 * As with the shared_info attributes: a waiting
+			 * activation must not hold xen_lock, on which a
+			 * vCPU may block from within the kvm->srcu read
+			 * section the memslot update has to wait out.
+			 */
+			mutex_unlock(&vcpu->kvm->arch.xen.xen_lock);
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
-					     data->u.gpa, sizeof(struct vcpu_info), false);
+					     data->u.gpa, sizeof(struct vcpu_info), true);
+			mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
 		} else {
 			if (data->u.hva == 0) {
 				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
@@ -988,9 +1024,11 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		mutex_unlock(&vcpu->kvm->arch.xen.xen_lock);
 		r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_time_info_cache,
 				     data->u.gpa,
-				     sizeof(struct pvclock_vcpu_time_info), false);
+				     sizeof(struct pvclock_vcpu_time_info), true);
+		mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
 		if (!r)
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		break;
@@ -1022,10 +1060,14 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
 		/* How much fits in the (first) page? */
 		sz1 = PAGE_SIZE - (data->u.gpa & ~PAGE_MASK);
+
+		mutex_unlock(&vcpu->kvm->arch.xen.xen_lock);
 		r = kvm_gpc_activate(&vcpu->arch.xen.runstate_cache,
-				     data->u.gpa, sz1, false);
-		if (r)
+				     data->u.gpa, sz1, true);
+		if (r) {
+			mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
 			goto deactivate_out;
+		}
 
 		/* Either map the second page, or deactivate the second GPC */
 		if (sz1 >= sz) {
@@ -1034,12 +1076,17 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			sz2 = sz - sz1;
 			BUG_ON((data->u.gpa + sz1) & ~PAGE_MASK);
 			r = kvm_gpc_activate(&vcpu->arch.xen.runstate2_cache,
-					     data->u.gpa + sz1, sz2, false);
-			if (r)
+					     data->u.gpa + sz1, sz2, true);
+			if (r) {
+				mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
 				goto deactivate_out;
+			}
 		}
+		mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
 
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		kvm_xen_update_runstate_guest(vcpu, false);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
 	case KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_CURRENT:
@@ -1052,7 +1099,9 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		kvm_xen_update_runstate(vcpu, data->u.runstate.state);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		r = 0;
 		break;
 
@@ -1132,10 +1181,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		vcpu->arch.xen.runstate_times[RUNSTATE_offline] +=
 			data->u.runstate.time_offline;
 
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		if (data->u.runstate.state <= RUNSTATE_offline)
 			kvm_xen_update_runstate(vcpu, data->u.runstate.state);
 		else if (vcpu->arch.xen.runstate_cache.active)
 			kvm_xen_update_runstate_guest(vcpu, false);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		r = 0;
 		break;
 
@@ -1181,7 +1232,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		break;
 	}
 
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	mutex_unlock(&vcpu->kvm->arch.xen.xen_lock);
 	return r;
 }
@@ -1326,11 +1376,20 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 
 		/*
 		 * Re-initialize shared_info to put the wallclock in the
-		 * correct place.
+		 * correct place. This cannot wait out a memslot update
+		 * from within the vCPU's kvm->srcu read section, so if
+		 * one races (-EAGAIN), the wallclock update is simply
+		 * skipped — leaving the new mode's wallclock stale, or
+		 * never yet written. The guest latches its bitness here
+		 * early in boot, when nothing should be changing memslots
+		 * anyway. A real failure still fails the WRMSR as before.
 		 */
-		if (kvm->arch.xen.shinfo_cache.active &&
-		    kvm_xen_shared_info_init(kvm))
-			r = 1;
+		if (kvm->arch.xen.shinfo_cache.active) {
+			int ret = kvm_xen_shared_info_init(kvm, false);
+
+			if (ret && ret != -EAGAIN)
+				r = 1;
+		}
 	}
 	mutex_unlock(&kvm->arch.xen.xen_lock);
 
-- 
2.43.0

