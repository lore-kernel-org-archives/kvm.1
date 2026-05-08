Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E1390CB8;
	Fri,  8 May 2026 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264254; cv=none; b=O2BPgrDSgfTDk2iSsnZqBJm7bxVAI9I/T+nLKRQfPWtZ3B3DPYf+7aYoOGKuLBRAEjLWoSEtcR0fcF6tjGuthIz0YwUsor7WFq5tN32iuuSKpz7zkgQ3brytYBMiiWmspXYj4dmNTu0U9sW4ONNkQ7Vhl5xJP6oRxb58xFu2je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264254; c=relaxed/simple;
	bh=Qcd2atfGyJQWYahNhwH9zauz3NBcPwffSp7KVyZKEEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezJCChtE8yXFr68JYvoHGQq7U7S6/fJTSVDONjFTCIGIB7o3Ghv8T4cwkVKVjDObruXXABYro+1YQLFmxeGJ7/H/mb4ziZ60gUC0l/3tDBFQJtUs7YKZKBC9aH0SVfCxd253JPGuhjLaQXSxZPBOvxxMR042uhUwMJt6GG8t0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c2wnVYp7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c2wnVYp7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=XXv2L/eBnTQ2xxqyNdJVoSpOW2dKadewk0bGdFKpA/4=; b=c2wnVYp7MfNMNl+9SNE14bmawl
	B4/ghYUnxTHZMyDnzjxao7QrWrsgk00ieRYr1nRkzVPlrYiFuLkRQq+j0zVYzcFhqC3WwDYduq5Xc
	C1B/ii5VytaxTa53R1+F36lQKlyxHnOolCH4xjWDHNFaqV7tfEIUTleL73dzmdeeiKutxUrjgxsIB
	i+gGuObGAE+XyIWE7CjztWDhBZbJzNGU1IzxgnXLo8C2b6OCeiLBQf47UOT8IXimQt9urUoC+cAnP
	H12RAQboOxjtMDcfpztJgJI1KKRk+gFkWCfQKxOsY5+RGyJwQeOm4dy9mGKvH5P0DmqDchDHDnYq0
	utEhKssg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlI-000000072tr-0SKZ;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlH-0000000DYZ1-1VvY;
	Fri, 08 May 2026 19:17:19 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	kernel-dev@igalia.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: [PATCH 7/7] KVM: x86/xen: Handle pending Xen timer events in vcpu_enter_guest()
Date: Fri,  8 May 2026 19:10:09 +0100
Message-ID: <20260508181717.3230988-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508181717.3230988-1-dwmw2@infradead.org>
References: <20260508181717.3230988-1-dwmw2@infradead.org>
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

If xen_timer_callback() can't deliver an event directly to the guest
(e.g. due to memslot changes causing the GPC to need refreshing), it
sets the timer_pending flag and kicks the vCPU.

However, the pending timer was only injected from the outer vcpu_run()
loop via kvm_inject_pending_timer_irqs(), not from the inner loop in
vcpu_enter_guest(). This means that the timer could be delayed until
something else causes vcpu_enter_guest() to return to the outer loop.

Thus, timer delivery could be delayed by a whole scheduler tick, or
hypothetically for ever in a NOHZ_FULL environment.

Subsume Xen timer handling into kvm_xen_has_pending_events() and
kvm_xen_inject_pending_events(), and use those directly from the inner
vcpu_enter_guest() loop. This ensures deferred timer delivery happens
on the next VM-entry rather than waiting for the scheduler.

Remove the Xen timer handling from kvm_inject_pending_timer_irqs() and
from kvm_cpu_has_pending_timer(), since kvm_vcpu_has_events() already
covers the wakeup case via kvm_xen_has_pending_events().

Pull the actual event injection into kvm_xen_inject_pending_events()
and remove kvm_xen_inject_timer_irqs() to avoid a double check of
arch.xen.timer_pending in caller and callee. Its other caller can
just call kvm_xen_inject_pending_events() (to ensure pending timers
are flushed when setting them from userspace).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/irq.c |  4 ----
 arch/x86/kvm/x86.c |  3 +++
 arch/x86/kvm/xen.c | 35 +++++++++++++++++------------------
 arch/x86/kvm/xen.h | 21 ++-------------------
 4 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 9519fec09ee6..7527c9bfe244 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -30,8 +30,6 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 	if (lapic_in_kernel(vcpu))
 		r = apic_has_pending_timer(vcpu);
-	if (kvm_xen_timer_enabled(vcpu))
-		r += kvm_xen_has_pending_timer(vcpu);
 
 	return r;
 }
@@ -170,8 +168,6 @@ void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu)
 {
 	if (lapic_in_kernel(vcpu))
 		kvm_inject_apic_timer_irqs(vcpu);
-	if (kvm_xen_timer_enabled(vcpu))
-		kvm_xen_inject_timer_irqs(vcpu);
 }
 
 void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e62f4a9ad334..c8e58a18a3e7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11254,6 +11254,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
 			record_steal_time(vcpu);
+		if (kvm_check_request(KVM_REQ_UNBLOCK, vcpu) &&
+		    kvm_xen_has_pending_events(vcpu))
+			kvm_xen_inject_pending_events(vcpu);
 		if (kvm_check_request(KVM_REQ_PMU, vcpu))
 			kvm_pmu_handle_event(vcpu);
 		if (kvm_check_request(KVM_REQ_PMI, vcpu))
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index b1fae42bf295..16b8c154243c 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -105,22 +105,6 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	return ret;
 }
 
-void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
-{
-	if (atomic_read(&vcpu->arch.xen.timer_pending) > 0) {
-		struct kvm_xen_evtchn e;
-
-		e.vcpu_id = vcpu->vcpu_id;
-		e.vcpu_idx = vcpu->vcpu_idx;
-		e.port = vcpu->arch.xen.timer_virq;
-		e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
-
-		kvm_xen_set_evtchn(&e, vcpu->kvm);
-
-		vcpu->arch.xen.timer_expires = 0;
-		atomic_set(&vcpu->arch.xen.timer_pending, 0);
-	}
-}
 
 static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
 {
@@ -634,9 +618,24 @@ void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
  */
 void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 {
-	unsigned long evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
+	unsigned long evtchn_pending_sel;
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
 
+	if (kvm_xen_timer_enabled(v) && atomic_read(&v->arch.xen.timer_pending)) {
+		struct kvm_xen_evtchn e;
+
+		e.vcpu_id = v->vcpu_id;
+		e.vcpu_idx = v->vcpu_idx;
+		e.port = v->arch.xen.timer_virq;
+		e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
+
+		kvm_xen_set_evtchn(&e, v->kvm);
+
+		v->arch.xen.timer_expires = 0;
+		atomic_set(&v->arch.xen.timer_pending, 0);
+	}
+
+	evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
 	if (!evtchn_pending_sel)
 		return;
 
@@ -1238,7 +1237,7 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		 */
 		if (vcpu->arch.xen.timer_expires) {
 			hrtimer_cancel(&vcpu->arch.xen.timer);
-			kvm_xen_inject_timer_irqs(vcpu);
+			kvm_xen_inject_pending_events(vcpu);
 		}
 
 		data->u.timer.port = vcpu->arch.xen.timer_virq;
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 59e6128a7bd3..029026853af5 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -92,7 +92,8 @@ static inline int kvm_xen_has_interrupt(struct kvm_vcpu *vcpu)
 static inline bool kvm_xen_has_pending_events(struct kvm_vcpu *vcpu)
 {
 	return static_branch_unlikely(&kvm_xen_enabled.key) &&
-		vcpu->arch.xen.evtchn_pending_sel;
+		(vcpu->arch.xen.evtchn_pending_sel ||
+		 atomic_read(&vcpu->arch.xen.timer_pending));
 }
 
 static inline bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu)
@@ -100,15 +101,6 @@ static inline bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu)
 	return !!vcpu->arch.xen.timer_virq;
 }
 
-static inline int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu)
-{
-	if (kvm_xen_hypercall_enabled(vcpu->kvm) && kvm_xen_timer_enabled(vcpu))
-		return atomic_read(&vcpu->arch.xen.timer_pending);
-
-	return 0;
-}
-
-void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu);
 #else
 static inline int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 {
@@ -164,15 +156,6 @@ static inline bool kvm_xen_has_pending_events(struct kvm_vcpu *vcpu)
 	return false;
 }
 
-static inline int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-
-static inline void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
-{
-}
-
 static inline bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu)
 {
 	return false;
-- 
2.51.0

