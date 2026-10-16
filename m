Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CC4EB876;
	Fri, 16 Oct 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162621; cv=none; b=gLHObYg9WJzb7bpsfeKvhDRlh1CSXjd1ieZR6XtK291FcIvCXxYAq9oftBZ8mhWfqazrvXBQ1rJkFPyWpzNZysOvPc0L0OY6ON1TxNW2HRo1RUT5BZLihFHguGJimJ9VjUfzXr66g0ycTje5i1dmPuJKOajT+S9NKexKg5ZpC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162621; c=relaxed/simple;
	bh=VPuD+iznaHPFgb0T5ME/jEwcfMyYal3GaoaMzqNGQAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCOcqVndDQFm3MURDu9Qs6fe1/o1kZB2p5MMalGgSk+L8PnErUO4xsfZ7eEwHq1HsJf+s1n440ERdlNscb+sjZtFw0516kLKhEY4A84Bed7N0JM4+a4VBXmxNwUAvRw4qmdFvCpLcTfXC/5p4InlagS6gwx2BeKcZMIiz7S5iWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S6ryZJRj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S6ryZJRj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=EPJAdsPZxOFKgj9EDg8h628y+uz0cGQWZ8gyqAeH6xk=; b=S6ryZJRjgDSSpj5OX2+b8sjyAH
	8mC0CzRvD9zRhOnKDR4tN9XgQ/ifJteK/EMc09jPalBaDovu3lbRTrCIHujYnZ3XGqSwVO/5WF0fc
	/WzjinQQWrnt4pciPa12g/8+Qa1MF92s26k2Ods7t1pfV7ORCtYYh7hESBPTIzmFUH/iLLMuAXIiy
	duk+v2TcK7htEqICq7W+EdrSc5Q2SSNCkS3FoGlr/x6jglunas0QdlR/ylgcagKQDbmHqFtTDekaA
	m3+1y0CC/qhu0zuMbOt0F+aiKxRcBPNd2hS7h/Aii9vecN/thnUdYPYGiNOQ9Y39dg4Hm60O3bTLo
	7B/37b0Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMX-00000001dOZ-1wnR;
	Fri, 16 Oct 2026 14:56:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMU-00000002Qiy-2pyU;
	Fri, 16 Oct 2026 15:56:46 +0100
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
Subject: [PATCH v3 03/11] KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls
Date: Fri, 16 Oct 2026 15:56:37 +0100
Message-ID: <20261016145646.579369-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016145646.579369-1-dwmw2@infradead.org>
References: <20261016145646.579369-1-dwmw2@infradead.org>
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

Activating a shared_info, vcpu_info, pvclock or runstate cache can
fail if it races a memslot update: previously with -EFAULT, now with
-EAGAIN. These ioctls may sleep, so pass wait and let the activation
ride the update out; userspace never sees the transient state.

The waiting is done without xen_lock held. A vCPU writing the
hypercall page MSR blocks on xen_lock from within its kvm->srcu read
section, and the memslot update cannot complete until that section
quiesces, so an ioctl waiting while holding the lock would deadlock
all three. Deactivations and the attribute field updates themselves
stay under the lock; concurrent SET_ATTR calls racing through an
activation window are userspace's own race, serialized by the cache's
refresh_lock, and the last one wins. Document the rule at the lock's
definition.

This also means two kvm_xen_shared_info_init() calls can publish the
wallclock concurrently, no longer excluded by xen_lock. That is
harmless: concurrent writers compute the same epoch, modulo
nanoseconds of jitter, and each re-reads long_mode to pick the
destination, so the location for the final mode is always freshly
written. Interleaving two observably different snapshots would
require userspace to race its own clock update against its own
attribute calls, and even full serialization would give it one or
the other arbitrarily.

The hypercall page MSR write cannot wait at all — it would be waiting
out its own srcu read section — so its shared_info re-init passes
wait=false and ignores -EAGAIN, proceeding with the stale wallclock
snapshot. The wallclock is written only here and in the attribute
paths, so nothing retries it, but hitting that window requires the
guest to change its own bitness while userspace is simultaneously
rearranging memslots. A real failure (-EFAULT) still fails the WRMSR
as it always did.

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
 arch/x86/kvm/xen.c              | 125 +++++++++++++++++++++++---------
 2 files changed, 95 insertions(+), 36 deletions(-)

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
index d64630a417a7..5901b5711c3a 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -36,7 +36,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
-static int kvm_xen_shared_info_init(struct kvm *kvm)
+static int kvm_xen_shared_info_init(struct kvm *kvm, bool wait)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct pvclock_wall_clock *wc;
@@ -44,17 +44,24 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	u32 wc_version;
 	u64 wall_nsec;
 	int ret = 0;
-	int idx = srcu_read_lock(&kvm->srcu);
+	int idx;
 
-	read_lock_irq(&gpc->lock);
-	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
+	/*
+	 * kvm_gpc_check() consults the memslots, so take kvm->srcu around
+	 * each check and the write through the mapping — but not across
+	 * the refresh, which may wait for a memslot update to complete.
+	 */
+	for (;;) {
+		idx = srcu_read_lock(&kvm->srcu);
+		read_lock_irq(&gpc->lock);
+		if (kvm_gpc_check(gpc, PAGE_SIZE))
+			break;
 		read_unlock_irq(&gpc->lock);
+		srcu_read_unlock(&kvm->srcu, idx);
 
-		ret = kvm_gpc_refresh(gpc, PAGE_SIZE, false);
+		ret = kvm_gpc_refresh(gpc, PAGE_SIZE, wait);
 		if (ret)
 			goto out;
-
-		read_lock_irq(&gpc->lock);
 	}
 
 	/*
@@ -98,9 +105,9 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 
 	wc->version = wc_version + 1;
 	read_unlock_irq(&gpc->lock);
+	srcu_read_unlock(&kvm->srcu, idx);
 
 out:
-	srcu_read_unlock(&kvm->srcu, idx);
 	return ret;
 }
 
@@ -155,21 +162,29 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcpu,
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
@@ -784,27 +799,34 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		} else {
 			mutex_lock(&kvm->arch.xen.xen_lock);
 			kvm->arch.xen.long_mode = !!data->u.long_mode;
+			mutex_unlock(&kvm->arch.xen.xen_lock);
 
 			/*
 			 * Re-initialize shared_info to put the wallclock in the
 			 * correct place. Whilst it's not necessary to do this
 			 * unless the mode is actually changed, it does no harm
-			 * to make the call anyway.
+			 * to make the call anyway. Done without xen_lock held:
+			 * the init may wait out a memslot update, and a vCPU
+			 * may block on xen_lock from within the kvm->srcu read
+			 * section which that update must wait out.
 			 */
 			r = kvm->arch.xen.shinfo_cache.active ?
-				kvm_xen_shared_info_init(kvm) : 0;
-			mutex_unlock(&kvm->arch.xen.xen_lock);
+				kvm_xen_shared_info_init(kvm, true) : 0;
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
 
@@ -812,8 +834,10 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
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
@@ -829,12 +853,11 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 			}
 		}
 
-		srcu_read_unlock(&kvm->srcu, idx);
+		mutex_unlock(&kvm->arch.xen.xen_lock);
 
 		if (!r && kvm->arch.xen.shinfo_cache.active)
-			r = kvm_xen_shared_info_init(kvm);
+			r = kvm_xen_shared_info_init(kvm, true);
 
-		mutex_unlock(&kvm->arch.xen.xen_lock);
 		break;
 	}
 	case KVM_XEN_ATTR_TYPE_UPCALL_VECTOR:
@@ -937,7 +960,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 	int idx, r = -ENOENT;
 
 	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	switch (data->type) {
 	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO:
@@ -959,8 +981,16 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
@@ -988,9 +1018,11 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
@@ -1022,10 +1054,14 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
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
@@ -1034,12 +1070,17 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
@@ -1052,7 +1093,9 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		kvm_xen_update_runstate(vcpu, data->u.runstate.state);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		r = 0;
 		break;
 
@@ -1132,10 +1175,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
 
@@ -1181,7 +1226,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		break;
 	}
 
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	mutex_unlock(&vcpu->kvm->arch.xen.xen_lock);
 	return r;
 }
@@ -1326,11 +1370,20 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 
 		/*
 		 * Re-initialize shared_info to put the wallclock in the
-		 * correct place.
+		 * correct place. The wallclock is a snapshot, written only
+		 * here, and this cannot wait out a memslot update from
+		 * within the vCPU's kvm->srcu read section. If it races
+		 * one (-EAGAIN), just proceed with the stale snapshot; a
+		 * guest changing its own bitness while userspace is
+		 * rearranging memslots has only itself to blame. A real
+		 * failure still fails the WRMSR as it always did.
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

