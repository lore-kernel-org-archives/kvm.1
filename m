Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3B4EBACB;
	Fri, 16 Oct 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162620; cv=none; b=IgT6iWqKnTQ5bz524tg95huQ/S1qWXSoa8iOY+SyRkqKYwicgXJI5QkSfdX5SaHfJIV1z4zwSp3zWFi5eyaIRdDcrazAzVAG3DqW2id3iyZyU1oNuSkxw9Vrn/ldgq5wzBDwR+Kzn5F9hr8dkaqB/r2ovTvJ7fKdOwPnGYzXnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162620; c=relaxed/simple;
	bh=tbE8vmQ4rcYAMYfq3TrIS4Ij0cFvRQcxbjwTcfo2itM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoAIPAzy1cDXcf4psWTzz0aRXtmuaBBrM2EK6N7gfcHp7z6Bo0G6IIjtEU0KntxIJ6D60khp1Wgd3kCCsC5lZ3jUKkLyDDRrolUlFGp18nVHy7YFrLVtOy2pEpxX+YymHxmVjY+VkvblIh7tLAtqiFSIuUQSqPKLiepx2WfTWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JyQg8mOd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JyQg8mOd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=/FFWQunDoZLdfyayX2ver/DNdvcc4CrsmeVbtNvpIEQ=; b=JyQg8mOdWoC66df3sAcfPkPUMH
	MkyNiWlK116IIca/2oBqd2OU813TYdRZWeJn15CVxG4O5B9TjQMDzcA3BtmDXR3RfKcpB5sQ1iHWn
	O4SC05HCQueS6RxTB7+xBpXZXnIIiSEUbLT4JuXWcUQigpAu0W6StA6RgcAL3oHTUGXwaRJ+jiBvR
	pg0cEsLlXoO5OWicRtHL46HbQSR51XbdiPY44pRe+eYRQUlW/LkJKImkoDXYYigK0hAL6knwjR0vU
	c0HWogQHi/eAEy8vjIIMyfxokXF9vI87k8DmDXs5SY3AodNgyMWAa4M9XnCIWe/ueXKB335PcnFkt
	75TuJ56w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMX-00000001dOb-1wpo;
	Fri, 16 Oct 2026 14:56:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMU-00000002Qj6-37Fw;
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
Subject: [PATCH v3 05/11] KVM: x86/xen: Retry event channel delivery which races a memslot update
Date: Fri, 16 Oct 2026 15:56:39 +0100
Message-ID: <20261016145646.579369-6-dwmw2@infradead.org>
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
   keeps that and retries on the next entry pass. The entry pass
   holds the vCPU's kvm->srcu, so it may not wait. The
   KVM_XEN_VCPU_GET_ATTR timer flush doesn't need to wait: an
   undelivered event is reported as still owed in the snapshot.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260920215341.5ECE91F000FF@smtp.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c | 58 +++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 0ef646cf3990..6b7532b0e26a 100644
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
 
@@ -135,7 +136,7 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
 		e.port = vcpu->arch.xen.timer_virq;
 		e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
-		rc = kvm_xen_set_evtchn(&e, vcpu->kvm);
+		rc = kvm_xen_set_evtchn(&e, vcpu->kvm, false);
 
 		/*
 		 * Leave timer_pending set if the memslot is being updated
@@ -1868,8 +1869,21 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2060,7 +2074,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	return rc;
 }
 
-static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
+static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm,
+			      bool wait)
 {
 	bool mm_borrowed = false;
 	int rc;
@@ -2097,16 +2112,13 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
@@ -2121,7 +2133,7 @@ static int evtchn_set_fn(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm
 	if (!level)
 		return -EINVAL;
 
-	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm);
+	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm, true);
 }
 
 /*
@@ -2195,7 +2207,7 @@ int kvm_xen_hvm_evtchn_send(struct kvm *kvm, struct kvm_irq_routing_xen_evtchn *
 	e.vcpu_idx = -1;
 	e.priority = uxe->priority;
 
-	ret = kvm_xen_set_evtchn(&e, kvm);
+	ret = kvm_xen_set_evtchn(&e, kvm, true);
 
 	/*
 	 * None of that 'return 1 if it actually got delivered' nonsense.
@@ -2424,7 +2436,11 @@ static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data
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
@@ -2434,7 +2450,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 	BUILD_BUG_ON(sizeof(send) != 4);
 	if (kvm_read_guest_virt(vcpu, param, &send, sizeof(send), &e)) {
 		*r = -EFAULT;
-		return true;
+		return 0;
 	}
 
 	/*
@@ -2443,18 +2459,22 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
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

