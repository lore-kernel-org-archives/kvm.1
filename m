Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50A556B96;
	Tue, 13 Oct 2026 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924521; cv=none; b=LqqL5/GYTg/pAEsiTUBkDv+7ZGm7oRDt+wFYubgdngDAs2IGtmZgEcWPaeIK+hbwImGKuBPK3GlxT3QMzfN+avAOmFiSELSBnAh7EaqxtVa+rpEePk1uKxQvzRPojqZ+dlaPlSlYgR7pQvueVj2czDovVlyg9yMmdaHneWlA5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924521; c=relaxed/simple;
	bh=Tv2kGfqjqBZqM57c4IkOohVNXpbSagmRJYCc7oE5Loo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdTzsl/PskkDtyzJuMlU3CJsIU1EpIyL/FXngIh+RecLqImkiUa2tiBpecv7dmX/vx2HP4tqSrNAUPdIMflfL2TmGKdO5T89cF5lx9WLsYZ0gWa6PTyfNWLnKn5RwbzGIgZU1t8MSALLxX5yTuO1n5hhSK7VbcITDKP0cuRsm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pLLhiEA8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLLhiEA8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PvqYcbuaavEwOqc4z/KeIP6uAeJxRczsrGjkTaDLvHs=; b=pLLhiEA8IKC8+fnSrRshcPE8Y5
	KQJgf5R+YIseEKjbsemMa0c1rRnaHFh9t/YquR1tX6+UJBAEhOQpS0eycZ8ZRpiX6KxboQYtpITPw
	XYtiUOyRZjRrMAoXFQ5wV4Z0M1ERVFTaVrVtsJTOaX+/vWGwYdFLg/jsXsSYEBSlE+dblAwqHdEGf
	G0kExwj+z6NuImR4khFRNhtw4ljFnI030cuokAc8/LNtGS2ilsRtJuYL/VSEALvatxaegaL1Zwlxg
	NHQKkvEW/ubLepjApG0T76Hv8jTBI9dMmA7T7oQtCej37EFaYCq+GzfVE4C6DZEGyQ5PyHRzE73s6
	+Dn7y8Dg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQB-0000000G4C8-16aR;
	Tue, 13 Oct 2026 20:48:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQ8-00000001uAF-2fqN;
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
Subject: [PATCH 03/10] KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls
Date: Tue, 13 Oct 2026 21:48:16 +0100
Message-ID: <20261013204824.454208-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013204824.454208-1-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Activating a shared_info, vcpu_info, pvclock or runstate cache can
fail if it races a memslot update: previously with -EFAULT, now with
-EAGAIN. These ioctls may sleep, so pass wait and let the activation
ride the update out; userspace never sees the transient state.

kvm_xen_shared_info_init() gains the same flag for its refresh:
true from the attribute ioctls, false from the hypercall page MSR
write, which runs in vCPU context under kvm->srcu and keeps its
existing failure behaviour. That one could retry by restarting the
WRMSR, but that is painful to plumb for an error which only matters
to legacy userspace (the non-_HVA shared_info).

The kvm->srcu read sections around the activation calls go away;
they existed to satisfy the old refresh contract, and holding one
across a waiting activation would deadlock against the memslot
update. The runstate updates in kvm_xen_vcpu_set_attr() still read
guest state through the caches, so they keep narrow read sections
of their own.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index fae893cd5762..76708b896026 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -36,7 +36,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
-static int kvm_xen_shared_info_init(struct kvm *kvm)
+static int kvm_xen_shared_info_init(struct kvm *kvm, bool wait)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct pvclock_wall_clock *wc;
@@ -44,13 +44,12 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	u32 wc_version;
 	u64 wall_nsec;
 	int ret = 0;
-	int idx = srcu_read_lock(&kvm->srcu);
 
 	read_lock_irq(&gpc->lock);
 	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
 		read_unlock_irq(&gpc->lock);
 
-		ret = kvm_gpc_refresh(gpc, PAGE_SIZE, false);
+		ret = kvm_gpc_refresh(gpc, PAGE_SIZE, wait);
 		if (ret)
 			goto out;
 
@@ -100,7 +99,6 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	read_unlock_irq(&gpc->lock);
 
 out:
-	srcu_read_unlock(&kvm->srcu, idx);
 	return ret;
 }
 
@@ -792,19 +790,15 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
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
 		mutex_lock(&kvm->arch.xen.xen_lock);
 
-		idx = srcu_read_lock(&kvm->srcu);
-
 		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
 			gfn_t gfn = data->u.shared_info.gfn;
 
@@ -813,7 +807,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 				r = 0;
 			} else {
 				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
-						     gfn_to_gpa(gfn), PAGE_SIZE, false);
+						     gfn_to_gpa(gfn), PAGE_SIZE, true);
 			}
 		} else {
 			void __user * hva = u64_to_user_ptr(data->u.shared_info.hva);
@@ -825,14 +819,12 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 				r = 0;
 			} else {
 				r = kvm_gpc_activate_hva(&kvm->arch.xen.shinfo_cache,
-							 (unsigned long)hva, PAGE_SIZE, false);
+							 (unsigned long)hva, PAGE_SIZE);
 			}
 		}
 
-		srcu_read_unlock(&kvm->srcu, idx);
-
 		if (!r && kvm->arch.xen.shinfo_cache.active)
-			r = kvm_xen_shared_info_init(kvm);
+			r = kvm_xen_shared_info_init(kvm, true);
 
 		mutex_unlock(&kvm->arch.xen.xen_lock);
 		break;
@@ -937,7 +929,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 	int idx, r = -ENOENT;
 
 	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	switch (data->type) {
 	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO:
@@ -960,7 +951,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
-					     data->u.gpa, sizeof(struct vcpu_info), false);
+					     data->u.gpa, sizeof(struct vcpu_info), true);
 		} else {
 			if (data->u.hva == 0) {
 				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
@@ -973,7 +964,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 
 			r = kvm_gpc_activate_hva(&vcpu->arch.xen.vcpu_info_cache,
-						 data->u.hva, sizeof(struct vcpu_info), false);
+						 data->u.hva, sizeof(struct vcpu_info));
 		}
 
 		if (!r)
@@ -990,7 +981,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
 		r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_time_info_cache,
 				     data->u.gpa,
-				     sizeof(struct pvclock_vcpu_time_info), false);
+				     sizeof(struct pvclock_vcpu_time_info), true);
 		if (!r)
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		break;
@@ -1023,7 +1014,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		/* How much fits in the (first) page? */
 		sz1 = PAGE_SIZE - (data->u.gpa & ~PAGE_MASK);
 		r = kvm_gpc_activate(&vcpu->arch.xen.runstate_cache,
-				     data->u.gpa, sz1, false);
+				     data->u.gpa, sz1, true);
 		if (r)
 			goto deactivate_out;
 
@@ -1034,12 +1025,14 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			sz2 = sz - sz1;
 			BUG_ON((data->u.gpa + sz1) & ~PAGE_MASK);
 			r = kvm_gpc_activate(&vcpu->arch.xen.runstate2_cache,
-					     data->u.gpa + sz1, sz2, false);
+					     data->u.gpa + sz1, sz2, true);
 			if (r)
 				goto deactivate_out;
 		}
 
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		kvm_xen_update_runstate_guest(vcpu, false);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
 	case KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_CURRENT:
@@ -1052,7 +1045,9 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		kvm_xen_update_runstate(vcpu, data->u.runstate.state);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		r = 0;
 		break;
 
@@ -1132,10 +1127,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
 
@@ -1181,7 +1178,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		break;
 	}
 
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	mutex_unlock(&vcpu->kvm->arch.xen.xen_lock);
 	return r;
 }
@@ -1329,7 +1325,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		 * correct place.
 		 */
 		if (kvm->arch.xen.shinfo_cache.active &&
-		    kvm_xen_shared_info_init(kvm))
+		    kvm_xen_shared_info_init(kvm, false))
 			r = 1;
 	}
 	mutex_unlock(&kvm->arch.xen.xen_lock);
-- 
2.43.0

