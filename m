Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462449B5B6;
	Wed, 14 Oct 2026 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015514; cv=none; b=lihNhf03J+/aes1+qpFp0cnZTapMe7OSnptb/7IwnkuzEGjc0lUO+g+EjkUYrZ3VzEZYesR4dYesF5FlJBJ5C7EQ6rayrpf0H3qyQhhRQHkjW8zlHUWgrbGvs67rK72T5B+htlfCejxbuEl2CABIuBU0HTRelwt2BFwtVA7iezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015514; c=relaxed/simple;
	bh=8+3V+5SJ6Rw6FkAxeymxuhTqhV9AGitrYOfwrwKeJNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imxAqN+4xjxMzFheE6R0WSSiLA7lkLNPsODCy85cufrx+OSKgYdOs7k3fPrr6ZpuS+R6Ag/6x8OUnc2DUdlB4k/woID6jBztw41/GX2QMUulB3w/e71UKAz9wK2m2FvJCFf60E0ZMRRxPv53pQktvnC2hTVi/MydPzpEj3qlD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pNU4+A/L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNU4+A/L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=J4GJJgIUjafBCzXo7NZhS25rQFGvQJR+ea7V8zea3tk=; b=pNU4+A/L1v2qTJvbbbePoyrFZa
	MX9JF9da/ulbc+CISwF2ZH7Z9QuC8rd5buS3g4OclunudnFnzeBK4U+XPG1PTmsmrjHCqgfMIDEG9
	wADEz4ooWAEliwIPqtcGTuDLv/S4e4SNqRDpNMCMCMiq3aCkFf+gGdBKzb25xF+ABQ5fWQlMOcLVv
	Sxv5KDRjy903/ygXgQQJX0oMGyBzes0Vk1uDVHCoLjGAOcItKc6reXmxN0bSsmPYcMejOm8SMAtdM
	FQfFMgok29lQwDP7b2FV3VSyUYefjzIOF5jO2mZzmkdWRO9qlkt6DCrIBJNAY2HLlrNlTONysJIQX
	/LXMogUQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH75w-00000007ibi-2lAQ;
	Wed, 14 Oct 2026 22:05:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002Axf-1mda;
	Wed, 14 Oct 2026 23:05:08 +0100
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
Subject: [PATCH v2 04/11] KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls
Date: Wed, 14 Oct 2026 23:05:00 +0100
Message-ID: <20261014220508.518772-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220508.518772-1-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
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

kvm_xen_shared_info_init() gains the same flag for its refresh:
true from the attribute ioctls, false from the hypercall page MSR
write, which runs in vCPU context under kvm->srcu and keeps its
existing failure behaviour. That one could retry by restarting the
WRMSR, but that is painful to plumb for an error which only matters
to legacy userspace (the non-_HVA shared_info).

kvm_xen_shared_info_init() keeps a read section around each
kvm_gpc_check() and the write through the mapping — the check
consults the memslots — but drops it across the refresh.

The kvm->srcu read sections around the activation calls go away;
they existed to satisfy the old refresh contract, and holding one
across a waiting activation would deadlock against the memslot
update. The runstate updates in kvm_xen_vcpu_set_attr() still read
guest state through the caches, so they keep narrow read sections
of their own.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c | 53 +++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 74dad6789e42..cd1063d659cc 100644
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
 
@@ -792,19 +799,15 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
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
 
@@ -813,7 +816,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 				r = 0;
 			} else {
 				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
-						     gfn_to_gpa(gfn), PAGE_SIZE, false);
+						     gfn_to_gpa(gfn), PAGE_SIZE, true);
 			}
 		} else {
 			void __user * hva = u64_to_user_ptr(data->u.shared_info.hva);
@@ -829,10 +832,8 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 			}
 		}
 
-		srcu_read_unlock(&kvm->srcu, idx);
-
 		if (!r && kvm->arch.xen.shinfo_cache.active)
-			r = kvm_xen_shared_info_init(kvm);
+			r = kvm_xen_shared_info_init(kvm, true);
 
 		mutex_unlock(&kvm->arch.xen.xen_lock);
 		break;
@@ -937,7 +938,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 	int idx, r = -ENOENT;
 
 	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	switch (data->type) {
 	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO:
@@ -960,7 +960,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
-					     data->u.gpa, sizeof(struct vcpu_info), false);
+					     data->u.gpa, sizeof(struct vcpu_info), true);
 		} else {
 			if (data->u.hva == 0) {
 				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
@@ -990,7 +990,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
 		r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_time_info_cache,
 				     data->u.gpa,
-				     sizeof(struct pvclock_vcpu_time_info), false);
+				     sizeof(struct pvclock_vcpu_time_info), true);
 		if (!r)
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		break;
@@ -1023,7 +1023,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		/* How much fits in the (first) page? */
 		sz1 = PAGE_SIZE - (data->u.gpa & ~PAGE_MASK);
 		r = kvm_gpc_activate(&vcpu->arch.xen.runstate_cache,
-				     data->u.gpa, sz1, false);
+				     data->u.gpa, sz1, true);
 		if (r)
 			goto deactivate_out;
 
@@ -1034,12 +1034,14 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
@@ -1052,7 +1054,9 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		kvm_xen_update_runstate(vcpu, data->u.runstate.state);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		r = 0;
 		break;
 
@@ -1132,10 +1136,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
 
@@ -1181,7 +1187,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		break;
 	}
 
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	mutex_unlock(&vcpu->kvm->arch.xen.xen_lock);
 	return r;
 }
@@ -1337,7 +1342,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
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

