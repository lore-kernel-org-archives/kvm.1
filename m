Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F84A6889;
	Wed, 14 Oct 2026 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015513; cv=none; b=kHTOw/RIV/YxPlYm4sBFt7Fj3V1A43iBgMBSOP80NgFSx5laBZP3u0yplvUx8C7V4eMZV3JqlI1NBzasQU+Y4//fbAuVX77gOTXtn6Q3PNtW9D376cYNgm56QdNChnKVpSgEkm4sq604BWzQlaNxdY3CTB2m2xhq1AkaGp19bkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015513; c=relaxed/simple;
	bh=oQSboHCdm6nXAeUpNXlZSicBvHIYrpR6sq/HYBuk69g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHPrOVhVjq9xk96KgMfLwt8KxszsP7NONq8hN01hpKNtYV/nqlmO99J7pqlxQEq5bHl7OstSb+MeZGr4PyusqUbja23PboSzZKDvB+LjWGUvl6Vxq2z6wEY2Dm+BzAS6e1wxYTUeTb5UjDkxVu/XVfbshEHjBy5GFxbiORmFSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nau4c/Tk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nau4c/Tk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=ur4ObDn0uRYQS87nAuBJu7yzmg1M8kwhFhToSLud6xY=; b=nau4c/TkEcKHz/Fb9fgLq3rHZR
	Fx6G/IheILj481Sixx0tk+HCCREw1zNrlcImfl0yNiZOXqGOgzX7y4TSC+P2Xn0okBLBtlIxlYcYX
	z+uWp9ZiajuDjLBdM6fx7esrqZhwF+nAfMp/IYNd0g+dxblzuo/pGpMHz2xC05321yvzkJW9UpKJY
	6MxsJzJ4AUJ6Op8GIpxTZHqTgaPwUxRrWKRZu/b6vUnLUwJZAh8F4sypu3sUx/PNm3et850QwpuwE
	9o42YgM8myg9P5way8bdDbbyQQ+OgHHvBGjsHczKA/GR/T4W1GVsRcd8pKgDEDf6SFItWTbLPWT0r
	CwgkB8Ng==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH75w-00000007ibo-3M4m;
	Wed, 14 Oct 2026 22:05:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002Axn-2Q5w;
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
Subject: [PATCH v2 06/11] KVM: x86/xen: Retry event channel delivery which races a memslot update
Date: Wed, 14 Oct 2026 23:05:02 +0100
Message-ID: <20261014220508.518772-7-dwmw2@infradead.org>
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

Event channel delivery now returns -EAGAIN when it races a memslot
update. It always failed; now the failure is distinguishable, and
instead of dropping the event each caller reacts according to its
context:

 - kvm_xen_hvm_evtchn_send(): the KVM_XEN_HVM_EVTCHN_SEND ioctl.
   May sleep: passes wait == true, and kvm_gpc_refresh() rides the
   update out.

 - evtchn_set_fn(): irqfd routing, from the irqfd workqueue after
   the atomic fast path failed. May also wait.

 - kvm_xen_hcall_evtchn_send(): the guest's own EVTCHNOP_send, in
   vcpu_run's exit handling under the vCPU's kvm->srcu read section
   — the very reader the memslot update is waiting out, so waiting
   there deadlocks, and any guest can trigger it. Instead, leave the
   hypercall uncompleted, with RIP not advanced, and the guest
   re-executes it; each attempt cycles the srcu read section on the
   way back in, letting the update complete. This is how Xen itself
   restarts preempted hypercalls, and the pending delivery is pure
   guest state, so there is nothing extra to migrate.

 - kvm_xen_inject_timer_irqs(): the timer retry added by the
   previous commit — timer_pending *is* its pending state, so it
   keeps that and retries on the next entry pass. Neither caller may
   wait: the entry pass holds the vCPU's kvm->srcu, and the
   KVM_XEN_VCPU_GET_ATTR timer flush holds xen_lock, on which a vCPU
   writing the hypercall page MSR blocks inside its kvm->srcu
   section. The flush doesn't need to wait: an undelivered event is
   reported as still owed in the snapshot.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260920215341.5ECE91F000FF@smtp.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c | 58 +++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index f1be9022bc6f..a88f571e8682 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -30,9 +30,10 @@
 #include "cpuid.h"
 #include "trace.h"
 
-static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm);
+static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm,
+			      bool wait);
 static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
-static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
+static int kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
@@ -122,7 +123,7 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
 		e.port = vcpu->arch.xen.timer_virq;
 		e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
-		rc = kvm_xen_set_evtchn(&e, vcpu->kvm);
+		rc = kvm_xen_set_evtchn(&e, vcpu->kvm, false);
 
 		/*
 		 * Leave timer_pending set if the memslot is being updated
@@ -1823,8 +1824,21 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 		}
 		break;
 	case __HYPERVISOR_event_channel_op:
-		if (params[0] == EVTCHNOP_send)
-			handled = kvm_xen_hcall_evtchn_send(vcpu, params[1], &r);
+		if (params[0] == EVTCHNOP_send) {
+			int ret = kvm_xen_hcall_evtchn_send(vcpu, params[1], &r);
+
+			/*
+			 * Delivery raced a memslot update; waiting for it
+			 * here would deadlock under vcpu_run's kvm->srcu
+			 * read section. Leave the hypercall uncompleted —
+			 * RIP not advanced — so the guest re-executes it.
+			 * Each attempt cycles the srcu read section on the
+			 * way back in, letting the update complete.
+			 */
+			if (ret == -EAGAIN)
+				return 1;
+			handled = !ret;
+		}
 		break;
 	case __HYPERVISOR_sched_op:
 		handled = kvm_xen_hcall_sched_op(vcpu, is_64bit, params[0],
@@ -2015,7 +2029,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	return rc;
 }
 
-static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
+static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm,
+			      bool wait)
 {
 	bool mm_borrowed = false;
 	int rc;
@@ -2052,16 +2067,13 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	 */
 	do {
 		struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
-		int idx;
 
 		rc = kvm_xen_set_evtchn_fast(xe, kvm);
 		if (rc != -EWOULDBLOCK)
 			break;
 
-		idx = srcu_read_lock(&kvm->srcu);
-		rc = kvm_gpc_refresh(gpc, PAGE_SIZE, false);
-		srcu_read_unlock(&kvm->srcu, idx);
-	} while(!rc);
+		rc = kvm_gpc_refresh(gpc, PAGE_SIZE, wait);
+	} while (!rc);
 
 	if (mm_borrowed)
 		kthread_unuse_mm(kvm->mm);
@@ -2076,7 +2088,7 @@ static int evtchn_set_fn(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm
 	if (!level)
 		return -EINVAL;
 
-	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm);
+	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm, true);
 }
 
 /*
@@ -2150,7 +2162,7 @@ int kvm_xen_hvm_evtchn_send(struct kvm *kvm, struct kvm_irq_routing_xen_evtchn *
 	e.vcpu_idx = -1;
 	e.priority = uxe->priority;
 
-	ret = kvm_xen_set_evtchn(&e, kvm);
+	ret = kvm_xen_set_evtchn(&e, kvm, true);
 
 	/*
 	 * None of that 'return 1 if it actually got delivered' nonsense.
@@ -2379,7 +2391,11 @@ static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data
 	return kvm_xen_eventfd_assign(kvm, data);
 }
 
-static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
+/*
+ * Returns 0 with *r set if handled, -EAGAIN if the hypercall should be
+ * re-executed by the guest, or -ENOENT to hand it to userspace.
+ */
+static int kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 {
 	struct evtchnfd *evtchnfd;
 	struct evtchn_send send;
@@ -2389,7 +2405,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 	BUILD_BUG_ON(sizeof(send) != 4);
 	if (kvm_read_guest_virt(vcpu, param, &send, sizeof(send), &e)) {
 		*r = -EFAULT;
-		return true;
+		return 0;
 	}
 
 	/*
@@ -2398,18 +2414,22 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 	 */
 	evtchnfd = xa_load(&vcpu->kvm->arch.xen.evtchn_ports, send.port);
 	if (!evtchnfd)
-		return false;
+		return -ENOENT;
 
 	if (evtchnfd->deliver.port.port) {
-		int ret = kvm_xen_set_evtchn(&evtchnfd->deliver.port, vcpu->kvm);
+		int ret = kvm_xen_set_evtchn(&evtchnfd->deliver.port,
+					     vcpu->kvm, false);
+
+		if (ret == -EAGAIN)
+			return ret;
 		if (ret < 0 && ret != -ENOTCONN)
-			return false;
+			return -ENOENT;
 	} else {
 		eventfd_signal(evtchnfd->deliver.eventfd.ctx);
 	}
 
 	*r = 0;
-	return true;
+	return 0;
 }
 
 void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
-- 
2.43.0

