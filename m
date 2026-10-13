Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306E5505F8;
	Tue, 13 Oct 2026 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924523; cv=none; b=X6jXBTKYIaCyOh8AiAc5MkPvi5uMXo/bjVedzM+rpSRlPYB7lTm4RqrbFq7kcmnI8oGBx42j4GZvvvjKj28EwOT8XL6+wA/uGTNAplvoI05S0w/T7sa7wwT2/YHFKfg7sVP/8lAb7IHwzLX850kyspnjvKTHpdV9HPWC4snYvcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924523; c=relaxed/simple;
	bh=uogmRdzxzmZ64l0HWk4ttWwMhBd/nKESqloQFHSXb8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBkn+4BdH0c5h/IGfJIu/qX9QCOEnhFmqsrmb2wHsdOO6Dhz99zx8Uh9X/t3jBfRxXFxElnyDn4hNnjZ3GBUFvH0hSKf1XlCOhFdb8Exj/pc650ETM3JG6AGuQIR2Ct7a2U8+1/KedOX8jhXdnIrGamG9uCn32zHz+CtGc+wlww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M6fPKxf1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6fPKxf1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=8vnFWRVZ0PaBjCtFDFpdh5SJtBWKVRiJVfaR1ujX0LU=; b=M6fPKxf1pIB9tI1//Zp4VAM0mX
	V3m2GMICs5gwJJnG+ZCA1XN/G7vu7jHd57ZR4Efy1vvX86ct5d9vlE7LZKVt6Gd6tBqRnyf2Y7gt8
	2NqQZ3EiIwlqrLqwQSKvmC1RZiUCdgT9p5jIcXKMcOpU+Ilnd/VDeBSlcfB9G+Cd8FmlxtE7JcFrb
	PEMLX3h1A4X7ljtz07kOt4BUJgdl+nEz7juaTbgegrC+7HrnS/SzKVEUFMne1N3l+O9HjR4ILsnIO
	7bnulkSfolC3uJJDkJK6gBdV12wArKg7BPif0zAC5hGZsYavVQImL9Be8n7u9ILHTi10Nn1/32nzd
	99tGc2uQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQB-0000000G4C2-0wla;
	Tue, 13 Oct 2026 20:48:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQ8-00000001uAL-3C1u;
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
Subject: [PATCH 05/10] KVM: x86/xen: Retry event channel delivery which races a memslot update
Date: Tue, 13 Oct 2026 21:48:18 +0100
Message-ID: <20261013204824.454208-6-dwmw2@infradead.org>
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
   keeps that and retries on the next entry pass. (Its other caller,
   the KVM_XEN_VCPU_GET_ATTR timer flush, must not wait under
   xen_lock — a vCPU writing the hypercall page MSR blocks on that
   lock inside its kvm->srcu section — and doesn't need to: an
   undelivered event is reported as still owed in the snapshot.)

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260920215341.5ECE91F000FF@smtp.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/irq.c |  2 +-
 arch/x86/kvm/xen.c | 65 ++++++++++++++++++++++++++++++----------------
 arch/x86/kvm/xen.h |  4 +--
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 871977288272..4e986eb4c3c3 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -171,7 +171,7 @@ void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu)
 	if (lapic_in_kernel(vcpu))
 		kvm_inject_apic_timer_irqs(vcpu);
 	if (kvm_xen_timer_enabled(vcpu))
-		kvm_xen_inject_timer_irqs(vcpu);
+		kvm_xen_inject_timer_irqs(vcpu, false);
 }
 
 void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index aea6572163d0..ad7708be6c04 100644
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
 
@@ -102,7 +103,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm, bool wait)
 	return ret;
 }
 
-void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
+void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu, bool wait)
 {
 	if (atomic_read(&vcpu->arch.xen.timer_pending) > 0) {
 		struct kvm_xen_evtchn e;
@@ -113,7 +114,7 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
 		e.port = vcpu->arch.xen.timer_virq;
 		e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
-		rc = kvm_xen_set_evtchn(&e, vcpu->kvm);
+		rc = kvm_xen_set_evtchn(&e, vcpu->kvm, wait);
 
 		/*
 		 * Deliberately leave timer_pending set if the memslot is
@@ -661,10 +662,11 @@ void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
  */
 void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 {
-	unsigned long evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
+	unsigned long evtchn_pending_sel;
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
 	unsigned long flags;
 
+	evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
 	if (!evtchn_pending_sel)
 		return;
 
@@ -1284,7 +1286,7 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		 */
 		if (vcpu->arch.xen.timer_expires) {
 			hrtimer_cancel(&vcpu->arch.xen.timer);
-			kvm_xen_inject_timer_irqs(vcpu);
+			kvm_xen_inject_timer_irqs(vcpu, false);
 		}
 
 		data->u.timer.port = vcpu->arch.xen.timer_virq;
@@ -1791,8 +1793,21 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
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
@@ -1983,7 +1998,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	return rc;
 }
 
-static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
+static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm,
+			      bool wait)
 {
 	bool mm_borrowed = false;
 	int rc;
@@ -2020,16 +2036,13 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
@@ -2044,7 +2057,7 @@ static int evtchn_set_fn(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm
 	if (!level)
 		return -EINVAL;
 
-	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm);
+	return kvm_xen_set_evtchn(&e->xen_evtchn, kvm, true);
 }
 
 /*
@@ -2118,7 +2131,7 @@ int kvm_xen_hvm_evtchn_send(struct kvm *kvm, struct kvm_irq_routing_xen_evtchn *
 	e.vcpu_idx = -1;
 	e.priority = uxe->priority;
 
-	ret = kvm_xen_set_evtchn(&e, kvm);
+	ret = kvm_xen_set_evtchn(&e, kvm, true);
 
 	/*
 	 * None of that 'return 1 if it actually got delivered' nonsense.
@@ -2347,7 +2360,11 @@ static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data
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
@@ -2357,7 +2374,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 	BUILD_BUG_ON(sizeof(send) != 4);
 	if (kvm_read_guest_virt(vcpu, param, &send, sizeof(send), &e)) {
 		*r = -EFAULT;
-		return true;
+		return 0;
 	}
 
 	/*
@@ -2366,18 +2383,22 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
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
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 9d04e350bdb1..f6202510bbd6 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -100,7 +100,7 @@ static inline int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu);
+void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu, bool wait);
 #else
 static inline int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 {
@@ -161,7 +161,7 @@ static inline int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static inline void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
+static inline void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu, bool wait)
 {
 }
 
-- 
2.43.0

